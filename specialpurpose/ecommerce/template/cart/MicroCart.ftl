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
                    <a href="#" class="dropdown-item d-flex">
                      <span class="avatar mr-3 align-self-center" style="background-image: url(/images/demo/faces/male/41.jpg)"></span>
                      <div>
                        <strong>Nathan</strong> pushed new commit: Fix page load performance issue.
                        <div class="small text-muted">10 minutes ago</div>
                      </div>
                    </a>
                    <a href="#" class="dropdown-item d-flex">
                      <span class="avatar mr-3 align-self-center" style="background-image: url(/images/demo/faces/female/1.jpg)"></span>
                      <div>
                        <strong>Alice</strong> started new task: Tabler UI design.
                        <div class="small text-muted">1 hour ago</div>
                      </div>
                    </a>
                    <a href="#" class="dropdown-item d-flex">
                      <span class="avatar mr-3 align-self-center" style="background-image: url(/images/demo/faces/female/18.jpg)"></span>
                      <div>
                        <strong>Rose</strong> deployed new version of NodeJS REST Api V3
                        <div class="small text-muted">2 hours ago</div>
                      </div>
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="<@ofbizUrl>view/showcart</@ofbizUrl>" class="dropdown-item text-center text-muted-dark">${uiLabelMap.OrderViewCart}</a>
                  </div>
        
                </div>

