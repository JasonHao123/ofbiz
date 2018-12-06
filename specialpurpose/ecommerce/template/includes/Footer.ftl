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

<#assign nowTimestamp = Static["org.apache.ofbiz.base.util.UtilDateTime"].nowTimestamp()>

<br/>

      </div>
  <div class="footer">
    <div class="container">
      <div class="row">
        <div class="col-lg-8">
          <div class="row">
            <div class="col-6 col-md-3">
              <ul class="list-unstyled mb-0">
                <li><a href="#">First link</a></li>
                <li><a href="#">Second link</a></li>
              </ul>
            </div>
            <div class="col-6 col-md-3">
              <ul class="list-unstyled mb-0">
                <li><a href="#">Third link</a></li>
                <li><a href="#">Fourth link</a></li>
              </ul>
            </div>
            <div class="col-6 col-md-3">
              <ul class="list-unstyled mb-0">
                <li><a href="#">Fifth link</a></li>
                <li><a href="#">Sixth link</a></li>
              </ul>
            </div>
            <div class="col-6 col-md-3">
              <ul class="list-unstyled mb-0">
                <li><a href="#">Other link</a></li>
                <li><a href="#">Last link</a></li>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mt-4 mt-lg-0">
          ${screens.render("component://ecommerce/widget/CommonScreens.xml#language")}
        </div>
      </div>
    </div>
  </div>
  <footer class="footer">
    <div class="container">
      <div class="row align-items-center flex-row-reverse">
        <div class="col-auto ml-lg-auto">
          <div class="row align-items-center">
            <div class="col-auto">
              <ul class="list-inline list-inline-dots mb-0">
                <li class="list-inline-item"><a href="http://ofbiz.apache.org">${uiLabelMap.EcommerceAboutUs}</a></li>
                <li class="list-inline-item"><a href="./faq.html">FAQ</a></li>
              </ul>
            </div>
            <div class="col-auto">
              Powered by <a class="btn btn-outline-primary btn-sm" href="http://ofbiz.apache.org">Apache OFBiz</a>
            </div>
          </div>
        </div>
        <div class="col-12 col-lg-auto mt-3 mt-lg-0 text-center">
          Copyright © 2018 <a href=".">Tabler</a>. Theme by <a href="https://codecalm.net" target="_blank">codecalm.net</a> All rights reserved.
        </div>
      </div>
    </div>
  </footer>
