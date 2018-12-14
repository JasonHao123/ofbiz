<#assign currentCatalogId =
    Static["org.apache.ofbiz.product.catalog.CatalogWorker"].getCurrentCatalogId(request)/>
  <div class="col-lg-3 ml-auto">
    <form class="input-icon my-3 my-lg-0" name="keywordsearchform" id="keywordsearchbox_keywordsearchform" method="post" action="<@ofbizUrl>keywordsearch</@ofbizUrl>">
      <input type="hidden" name="VIEW_SIZE" value="12" />
	  <input type="hidden" name="PAGING" value="Y" />
	  <input type="hidden" name="SEARCH_CATALOG_ID" value="${currentCatalogId}"/>
      <input type="search" class="form-control header-search" placeholder="Search&hellip;" tabindex="1" name="SEARCH_STRING" value="${requestParameters.SEARCH_STRING!}" maxlength="50">
      <div class="input-icon-addon">
        <i class="fe fe-search"></i>
      </div>
    </form>
  </div>

