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
<!--
<#if productCategoryList?has_content>
  <h1>Popular Categories</h1>
  <div class="productsummary-container matrix">
    <table>
      <tbody>
        <#list productCategoryList as childCategoryList>
          <tr>
            <#assign cateCount = 0/>
            <#list childCategoryList as productCategory>
              <#if (cateCount > 2)>
                <tr>
                  <#assign cateCount = 0/>
              </#if>
              <#assign productCategoryId = productCategory.productCategoryId/>
              <#assign categoryImageUrl = "/images/defaultImage.jpg">
              <#assign productCategoryMembers = delegator
                  .findByAnd("ProductCategoryAndMember", Static["org.apache.ofbiz.base.util.UtilMisc"]
                  .toMap("productCategoryId", productCategoryId),
                  Static["org.apache.ofbiz.base.util.UtilMisc"].toList("-quantity"), false)>
              <#if productCategory.categoryImageUrl?has_content>
                <#assign categoryImageUrl = productCategory.categoryImageUrl/>
              <#elseif productCategoryMembers?has_content>
                <#assign productCategoryMember =
                    Static["org.apache.ofbiz.entity.util.EntityUtil"].getFirst(productCategoryMembers)/>
                <#assign product = delegator.findOne("Product",
                    Static["org.apache.ofbiz.base.util.UtilMisc"]
                    .toMap("productId", productCategoryMember.productId), false)/>
                <#if product.smallImageUrl?has_content>
                  <#assign categoryImageUrl = product.smallImageUrl/>
                </#if>
              </#if>
              <td>
                <div class="productsummary">
                  <div class="smallimage">
                    <a href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>">
                      <span class="popup_link"><img alt="Small Image" src="${categoryImageUrl}"></span>
                    </a>
                  </div>
                  <div class="productbuy">
                    <a class="linktext" style="font-size:12px"
                        href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>">
                      ${productCategory.categoryName!productCategoryId}
                    </a>
                  </div>
                  <div class="productinfo">
                    <ul>
                      <#if productCategoryMembers??>
                        <#assign i = 0/>
                        <#list productCategoryMembers as productCategoryMember>
                          <#if (i > 2)>
                            <#if productCategoryMembers[i]?has_content>
                              <a class="linktext" href="<@ofbizCatalogAltUrl productCategoryId=productCategoryId/>">
                                <span>More...</span>
                              </a>
                            </#if>
                            <#break>
                          </#if>
                          <#if productCategoryMember?has_content>
                            <#assign product = delegator.findOne("Product",
                                Static["org.apache.ofbiz.base.util.UtilMisc"].toMap("productId",
                                productCategoryMember.productId), false)>
                            <li class="browsecategorytext">
                              <a class="linktext"
                                  href="<@ofbizCatalogAltUrl productCategoryId="PROMOTIONS"
                                  productId="${product.productId}"/>">
                                ${product.productName!product.productId}
                              </a>
                            </li>
                          </#if>
                          <#assign i = i+1/>
                        </#list>
                      </#if>
                    </ul>
                  </div>
                </div>
              </td>
              <#assign cateCount = cateCount + 1/>
            </#list>
          <tr/>
        </#list>
      </tbody>
    </table>
  </div>
</#if>
-->

<#if (promoToShow>0)>
                    <div id="carousel-captions" class="carousel slide col-lg-12 py-3" data-ride="carousel">
                      <div class="carousel-inner">
                       <#list  0..productPromos?size-1 as i>
                        <div class="carousel-item <#if (i==0) >active</#if>">
                          <img class="d-block" alt="" src="${productPromoImageMap.get(productPromos[i].productPromoId)}" data-holder-rendered="true">
                          <div class="carousel-caption d-none d-md-block">
                            <h3> <a href="<@ofbizUrl>showPromotionDetails?productPromoId=${productPromos[i].productPromoId}</@ofbizUrl>">${StringUtil.wrapString(productPromos[i].promoName!)}</a></h3>
                            <p> <a href="<@ofbizUrl>showPromotionDetails?productPromoId=${productPromos[i].productPromoId}</@ofbizUrl>">${StringUtil.wrapString(productPromos[i].promoText!)}</a></p>
                          </div>
                        </div>
                        </#list>
                        
                      </div>
                      <a class="carousel-control-prev" href="#carousel-captions" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                      </a>
                      <a class="carousel-control-next" href="#carousel-captions" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                      </a>
                    </div>
                  </div>
</#if>
