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
<#assign shoppingCart = sessionAttributes.shoppingCart!>
<#if shoppingCart?has_content>
  <#assign shoppingCartSize = shoppingCart.size()>
<#else>
  <#assign shoppingCartSize = 0>
</#if>
<div id="microcart" class="dropdown d-md-flex">
         

       
                  <a class="nav-link icon" data-toggle="dropdown">
        <#if (shoppingCartSize > 0)>
    <p id="microCartNotEmpty">
    
      ${uiLabelMap.EcommerceCartHas}
      <strong id="microCartQuantity">
        ${shoppingCart.getTotalQuantity()}
      </strong>
      <#if shoppingCart.getTotalQuantity() == 1>
        ${uiLabelMap.OrderItem}
      <#else>
        ${uiLabelMap.OrderItems}
      </#if>,
      <strong id="microCartTotal">
        <@ofbizCurrency amount=shoppingCart.getDisplayGrandTotal() isoCode=shoppingCart.getCurrency()/>
      </strong>
    </p>
    <span id="microCartEmpty" style="display:none">${uiLabelMap.OrderShoppingCartEmpty}</span>
  <#else>
    
  </#if>  
                  </a>
                  <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                  	 <#list shoppingCart.items() as cartLine>
                  	  <#if cartLine.getParentProductId()??>
                        <#assign parentProductId = cartLine.getParentProductId() />
                      <#else>
                        <#assign parentProductId = cartLine.getProductId() />
                      </#if>
                    <a href="<@ofbizCatalogAltUrl productId=parentProductId/>" class="dropdown-item d-flex">
                     <#assign smallImageUrl =
                          Static["org.apache.ofbiz.product.product.ProductContentWrapper"].getProductContentAsText(
                          cartLine.getProduct(), "SMALL_IMAGE_URL", locale, dispatcher, "string")! />
                      <#if !smallImageUrl?string?has_content>
                        <#assign smallImageUrl = "/images/defaultImage.jpg" />
                      </#if>
                      <span class="avatar mr-3 align-self-center" style="background-image: url('<@ofbizContentUrl>${requestAttributes.contentPathPrefix!}${smallImageUrl!}</@ofbizContentUrl>')"></span>
                      <div>
                        <strong>${cartLine.getName()!}</strong>
                        <div class="small text-muted">${cartLine.getQuantity()?string.number} pieces &nbsp;&nbsp;<@ofbizCurrency amount=cartLine.getDisplayItemSubTotal() isoCode=shoppingCart.getCurrency()/></div>
                      </div>
                    </a>
                    </#list>
                    
                    <div class="dropdown-divider"></div>
                    <a href="<@ofbizUrl>view/showcart</@ofbizUrl>" class="dropdown-item text-center text-muted-dark">${uiLabelMap.OrderViewCart}</a>
                  </div>
        
                </div>

