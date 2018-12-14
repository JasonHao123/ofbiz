                <ul class="nav nav-tabs border-0 flex-column flex-lg-row">
                	<#list completedTree?sort_by("productCategoryId") as root>
                		<#if root.child?has_content>
                  	<li class="nav-item dropdown">
                  	
	                    <a href="javascript:void(0)" class="nav-link" data-toggle="dropdown"><i class="fe fe-home"></i>
	                     <#if root.categoryName??>${root.categoryName?js_string}
	                     <#elseif root.categoryDescription??>${root.categoryDescription?js_string}
	                     <#else>${root.productCategoryId?js_string}
	                     </#if></a>
                      
				           <div class="dropdown-menu dropdown-menu-arrow">
				         <!--   	 <a href="/ecommerce/category/${root.productCategoryId?js_string}.html" class="dropdown-item ">
		                       	 <#if root.categoryName??>All ${root.categoryName?js_string}
	                     <#elseif root.categoryDescription??>All ${root.categoryDescription?js_string}
	                     <#else>All ${root.productCategoryId?js_string}
	                     </#if>
		                      </a> -->
				            <#list root.child?sort_by("productCategoryId") as sub>
		                      <a href="/ecommerce/category/${sub.productCategoryId?js_string}.html" class="dropdown-item ">
		                       	 <#if sub.categoryName??>${sub.categoryName?js_string}
			                     <#elseif sub.categoryDescription??>${sub.categoryDescription?js_string}
			                     <#else>${sub.productCategoryId?js_string}
			                     </#if>
		                      </a>
		                     </#list>
		                     
		                    </div>

                  </li>
                   <#else>
                   	<li class="nav-item">
                    	<a href="/ecommerce/category/${root.productCategoryId?js_string}.html" class="nav-link"><i class="fe fe-home"></i> 
						<#if root.categoryName??>${root.categoryName?js_string}
	                     <#elseif root.categoryDescription??>${root.categoryDescription?js_string}
	                     <#else>${root.productCategoryId?js_string}
	                     </#if>
					</a>
                 	 </li>
                  </#if>
                  </#list>
                 
                </ul>