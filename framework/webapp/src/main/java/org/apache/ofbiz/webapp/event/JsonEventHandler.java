/*******************************************************************************
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *******************************************************************************/
package org.apache.ofbiz.webapp.event;

import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.namespace.QName;
import javax.xml.stream.XMLInputFactory;
import javax.xml.stream.XMLStreamReader;

import org.apache.axiom.om.OMAbstractFactory;
import org.apache.axiom.om.OMAttribute;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.OMXMLBuilderFactory;
import org.apache.axiom.om.impl.builder.StAXOMBuilder;
import org.apache.axiom.soap.SOAPBody;
import org.apache.axiom.soap.SOAPEnvelope;
import org.apache.axiom.soap.SOAPFactory;
import org.apache.ofbiz.base.util.Debug;
import org.apache.ofbiz.base.util.UtilHttp;
import org.apache.ofbiz.base.util.UtilProperties;
import org.apache.ofbiz.entity.Delegator;
import org.apache.ofbiz.service.GenericServiceException;
import org.apache.ofbiz.service.LocalDispatcher;
import org.apache.ofbiz.service.ModelService;
import org.apache.ofbiz.service.ServiceUtil;
import org.apache.ofbiz.service.engine.SoapSerializer;
import org.apache.ofbiz.webapp.control.ConfigXMLReader;
import org.apache.ofbiz.webapp.control.ConfigXMLReader.Event;
import org.apache.ofbiz.webapp.control.ConfigXMLReader.RequestMap;
import org.apache.ofbiz.webapp.control.RequestHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * SOAPEventHandler - SOAP Event Handler implementation
 */
public class JsonEventHandler implements EventHandler {

    public static final String module = JsonEventHandler.class.getName();
    private static final ObjectMapper mapper = new ObjectMapper();

    /**
     * @see org.apache.ofbiz.webapp.event.EventHandler#init(javax.servlet.ServletContext)
     */
    public void init(ServletContext context) throws EventHandlerException {
    }

    /**
     * @see org.apache.ofbiz.webapp.event.EventHandler#invoke(ConfigXMLReader.Event, ConfigXMLReader.RequestMap, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
     */
    public String invoke(Event event, RequestMap requestMap, HttpServletRequest request, HttpServletResponse response) throws EventHandlerException {
        LocalDispatcher dispatcher = (LocalDispatcher) request.getAttribute("dispatcher");
        Delegator delegator = (Delegator) request.getAttribute("delegator");

        // not a wsdl request; invoke the service
        response.setContentType("application/json");

        String serviceName = null;
        try {
        		String path = request.getPathInfo();
            serviceName = path.substring(path.lastIndexOf("/")+1);
            Map<String, Object> parameters = new HashMap<String,Object>();
            Map<String,Object> attributeMap = UtilHttp.getAttributeMap(request);
            try {
                // verify the service is exported for remote execution and invoke it
                ModelService model = dispatcher.getDispatchContext().getModelService(serviceName);
                
                if (model == null) {
                    sendError(response, "Problem processing the service", serviceName);
                    Debug.logError("Could not find Service [" + serviceName + "].", module);
                    return null;
                }

                if (!model.export) {
                    sendError(response, "Problem processing the service", serviceName);
                    Debug.logError("Trying to call Service [" + serviceName + "] that is not exported.", module);
                    return null;
                }
                for(String name:model.getInParamNames()) {
                		if(attributeMap.get(name)!=null) {
                			parameters.put(name, attributeMap.get(name));
                		}
                }
                
                HttpSession session = request.getSession(false);
                if(session!=null) {
                		Object userLogin = session.getAttribute("userLogin");
                		if(userLogin!=null) {
                			parameters.put("userLogin", userLogin);
                		}
                }
                Map<String, Object> serviceResults = dispatcher.runSync(serviceName, parameters);
                Debug.logVerbose("[EventHandler] : Service invoked", module);

                createAndSendJsonResponse(serviceResults, serviceName, response);

            } catch (GenericServiceException e) {
                Debug.logError(e, module);
                if (UtilProperties.getPropertyAsBoolean("service", "secureSoapAnswer", true)) {
                    sendError(response, "Problem processing the service, check your parameters.", serviceName);
                } else {
                    if(e.getMessageList() == null) {
                        sendError(response, e.getMessage(), serviceName);
                    } else {
                        sendError(response, e.getMessageList(), serviceName);
                    }
                    return null;
                }
            }
        } catch (Exception e) {
            sendError(response, e.getMessage(), serviceName);
            Debug.logError(e, module);
            return null;
        }

        return null;
    }


    private void createAndSendJsonResponse(Map<String, Object> serviceResults, String serviceName, HttpServletResponse response) throws EventHandlerException {
        try {
        		mapper.writeValue(response.getOutputStream(), serviceResults);
        } catch (Exception e) {
            Debug.logError(e, module);
            throw new EventHandlerException(e.getMessage(), e);
        }
    }

    private void sendError(HttpServletResponse res, String errorMessage, String serviceName) throws EventHandlerException {
        // setup the response
        sendError(res, ServiceUtil.returnError(errorMessage), serviceName);
    }

    private void sendError(HttpServletResponse res, List<String> errorMessages, String serviceName) throws EventHandlerException {
        sendError(res, ServiceUtil.returnError(errorMessages.toString()), serviceName);
    }
    private void sendError(HttpServletResponse res, Object object, String serviceName) throws EventHandlerException {
        try {
            // setup the response
            res.setContentType("text/xml");
            String xmlResults= SoapSerializer.serialize(object);
            XMLStreamReader xmlReader = XMLInputFactory.newInstance().createXMLStreamReader(new StringReader(xmlResults));
            StAXOMBuilder resultsBuilder = (StAXOMBuilder) OMXMLBuilderFactory.createStAXOMBuilder(OMAbstractFactory.getOMFactory(), xmlReader);
            OMElement resultSer = resultsBuilder.getDocumentElement();

            // create the response soap
            SOAPFactory factory = OMAbstractFactory.getSOAP11Factory();
            SOAPEnvelope resEnv = factory.createSOAPEnvelope();
            SOAPBody resBody = factory.createSOAPBody();
            OMElement errMsg = factory.createOMElement(new QName((serviceName != null ? serviceName : "") + "Response"));
            errMsg.addChild(resultSer.getFirstElement());
            resBody.addChild(errMsg);
            resEnv.addChild(resBody);

            // The declareDefaultNamespace method doesn't work see (https://issues.apache.org/jira/browse/AXIS2-3156)
            // so the following doesn't work:
            // resService.declareDefaultNamespace(ModelService.TNS);
            // instead, create the xmlns attribute directly:
            OMAttribute defaultNS = factory.createOMAttribute("xmlns", null, ModelService.TNS);
            errMsg.addAttribute(defaultNS);

            // log the response message
            if (Debug.verboseOn()) {
                try {
                    Debug.logInfo("Response Message:\n" + resEnv + "\n", module);
                } catch (Throwable t) {
                }
            }

            resEnv.serialize(res.getOutputStream());
            res.getOutputStream().flush();
        } catch (Exception e) {
            throw new EventHandlerException(e.getMessage(), e);
        }
    }

    private String getLocationURI(HttpServletRequest request) {
        StringBuilder uri = new StringBuilder();
        uri.append(request.getScheme());
        uri.append("://");
        uri.append(request.getServerName());
        if (request.getServerPort() != 80 && request.getServerPort() != 443) {
            uri.append(":");
            uri.append(request.getServerPort());
        }
        uri.append(request.getContextPath());
        uri.append(request.getServletPath());

        String reqInfo = RequestHandler.getRequestUri(request.getPathInfo());
        if (!reqInfo.startsWith("/")) {
            reqInfo = "/" + reqInfo;
        }

        uri.append(reqInfo);
        return uri.toString();
    }
}
