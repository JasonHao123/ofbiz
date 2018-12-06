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

        <div class="header py-4">
          <div class="container">
            <div class="d-flex">
              <a class="header-brand" href="<@ofbizContentUrl>/ecomseo</@ofbizContentUrl>">
                <#if sessionAttributes.overrideLogo??>
			      <img class="header-brand-img" src="<@ofbizContentUrl>${sessionAttributes.overrideLogo}</@ofbizContentUrl>" alt="Logo"/>
			    <#elseif catalogHeaderLogo??>
			      <img class="header-brand-img" src="<@ofbizContentUrl>${catalogHeaderLogo}</@ofbizContentUrl>" alt="Logo"/>
			    <#elseif layoutSettings.VT_HDR_IMAGE_URL?has_content>
			      <img class="header-brand-img" src="<@ofbizContentUrl>${layoutSettings.VT_HDR_IMAGE_URL.get(0)}</@ofbizContentUrl>" alt="Logo"/>
			    </#if>
              </a>
              <div class="d-flex order-lg-2 ml-auto">
 
                ${screens.render("component://ecommerce/widget/CartScreens.xml#microcart")}

                <div class="dropdown">
                  <a href="#" class="nav-link pr-0 leading-none" data-toggle="dropdown">
                    <span class="avatar" style="background-image: url(/images/demo/faces/female/25.jpg)"></span>
                    <span class="ml-2 d-none d-lg-block">
                      <span class="text-default">Jane Pearson</span>
                      <small class="text-muted d-block mt-1">Administrator</small>
                    </span>
                  </a>
                  <div class="dropdown-menu dropdown-menu-right dropdown-menu-arrow">
                    <a class="dropdown-item" href="<@ofbizUrl>viewprofile</@ofbizUrl>">
                      <i class="dropdown-icon fe fe-user"></i> ${uiLabelMap.CommonProfile}
                    </a>
                    <a class="dropdown-item" href="<@ofbizUrl>messagelist</@ofbizUrl>">
                      <i class="dropdown-icon fe fe-settings"></i> ${uiLabelMap.CommonMessages}
                    </a>
                    <a class="dropdown-item" href="<@ofbizUrl>ListQuotes</@ofbizUrl>">
                      <span class="float-right"><span class="badge badge-primary">6</span></span>
                      <i class="dropdown-icon fe fe-mail"></i> ${uiLabelMap.OrderOrderQuotes}
                    </a>
                    <a class="dropdown-item" href="<@ofbizUrl>ListRequests</@ofbizUrl>">
                      <i class="dropdown-icon fe fe-send"></i> ${uiLabelMap.OrderRequests}
                    </a>
                    
                    <a class="dropdown-item" href="<@ofbizUrl>editShoppingList</@ofbizUrl>">
                      <i class="dropdown-icon fe fe-help-circle"></i> ${uiLabelMap.EcommerceShoppingLists}
                    </a>
                    <div class="dropdown-divider"></div>
                    <#if userLogin?has_content && userLogin.userLoginId != "anonymous">
                    		<a class="dropdown-item" href="<@ofbizUrl>logout</@ofbizUrl>">
	                      <i class="dropdown-icon fe fe-log-out"></i> ${uiLabelMap.CommonLogout}
	                    </a>
				     
				    <#else>
				    	   <a class="dropdown-item" href="<@ofbizUrl>${checkLoginUrl}</@ofbizUrl>">
	                      <i class="dropdown-icon fe fe-log-in"></i> ${uiLabelMap.CommonLogin}
	                    </a>
	                    <a class="dropdown-item" href="<@ofbizUrl>newcustomer</@ofbizUrl>">
	                      <i class="dropdown-icon fe fe-log-in"></i> ${uiLabelMap.EcommerceRegister}
	                    </a>
				    </#if>
                  </div>
                </div>
              </div>
              <a href="#" class="header-toggler d-lg-none ml-3 ml-lg-0" data-toggle="collapse" data-target="#headerMenuCollapse">
                <span class="header-toggler-icon"></span>
              </a>
            </div>
          </div>
        </div>
        <div class="header collapse d-lg-flex p-0" id="headerMenuCollapse">
          <div class="container">
            <div class="row align-items-center">
              ${screens.render("component://ecommerce/widget/CatalogScreens.xml#keywordsearchbox")}
              <div class="col-lg order-lg-first">
				${screens.render("component://ecommerce/widget/CatalogScreens.xml#categorynavibar")}
              </div>
            </div>
          </div>
        </div>
        