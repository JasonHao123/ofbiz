<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->

    <div class="row">
            <div class="col col-login mx-auto">

  <h3>${uiLabelMap.CommonForgotYourPassword}</h3>
  <form class="card" method="post" action="<@ofbizUrl>forgotpassword</@ofbizUrl>" class="horizontal">
  	<div class="card-body p-6">
      <div class="form-group">
        <label class="form-label">${uiLabelMap.CommonUsername}</label>
        <input class="form-control" type="text" id="userName" name="USERNAME" value="<#if requestParameters.USERNAME?has_content>${requestParameters.USERNAME}<#elseif autoUserLogin?has_content>${autoUserLogin.userLoginId}</#if>">
      </div>
    <div class="form-footer">
      <input type="submit" class="button" name="GET_PASSWORD_HINT" value="${uiLabelMap.CommonGetPasswordHint}"/>
      <input type="submit" class="button" name="EMAIL_PASSWORD" value="${uiLabelMap.CommonEmailPassword}"/>
    </div>
    </div>
  </form>

            </div>
          </div>
        </div>
        
        
