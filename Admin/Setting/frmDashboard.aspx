<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmDashboard.aspx.cs" Inherits="Admin_frmDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .fstth-title {
            width: 170px;
            color: #044d91;
            text-align: center;
            font-weight: 500;
            text-transform: uppercase;
        }

        .btns.btn-submit {
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            var winheight = $(window).height(), nvheight = $(".navbar").outerHeight(), secheight = $('.section-content').outerHeight();
            $("#ConatntMatter_dvLinks").css({ 'min-height': winheight - (nvheight + secheight + 90) });
            $(".table td, .table th").css({ 'vertical-align': 'middle' });

            //$("#btnGInstructions").click(function () {
            //    $("#dvGInstructions").dialog({
            //        title: "General Instructions",
            //        width: '50%',
            //        maxHeight: $(window).height() - 150,
            //        modal: true,
            //        close: function () {
            //            $(this).dialog("close");
            //            $(this).dialog("destroy");
            //        }
            //    });
            //});

            //$("#btncasesutdy_one").click(function () {
            //    $("#casesutdy_one").dialog({
            //        title: "Case Study One",
            //        width: '80%',
            //        maxHeight: $(window).height() - 150,
            //        modal: true,
            //        position: { my: 'center', at: 'center', of: window },
            //        close: function () {
            //            $(this).dialog("close");
            //            $(this).dialog("destroy");
            //        }
            //    });
            //});
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-content">
        <div class="section-title clearfix m-0">
            <h3 class="text-center">Welcome To Assessment centre !</h3>
            <div class="title-line-center"></div>
        </div>
        <h4 class="meddle-title" runat="server" id="pgsubtitle">Admin Home Page</h4>
        <p>Please click on the below options to access respective tabs. You can click on the Home button provided at the top right corner to come back to this page</p>
    </div>
    <div id="dvLinks" runat="server" class="clearfix"></div>

    <div class="text-right d-none" id="btnGI" runat="server">
        <input type="button" id="btnGInstructions" class="btns btn-submit" value="General Instructions" />
    </div>

    <div id="casesutdy_one" style="display: none;">
        <div class="body-content">
            <!-- Nav tabs -->
            <ul class="nav nav-tabs" role="tablist">
                <li><a class="nav-link active" href="#section-1" role="tab" data-toggle="tab">Over-Arching Theme</a></li>
                <li><a class="nav-link" href="#section-2" role="tab" data-toggle="tab">Section-2</a></li>
                <li><a class="nav-link" href="#section-3" role="tab" data-toggle="tab">Section-3</a></li>
                <li><a class="nav-link" href="#section-4" role="tab" data-toggle="tab">Section-4</a></li>
                <li><a class="nav-link" href="#section-5" role="tab" data-toggle="tab">Section-5</a></li>
                <li><a class="nav-link" href="#section-6" role="tab" data-toggle="tab">Section-6</a></li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <%--Section 1--%>
                <div role="tabpanel" class="tab-pane fade show active" id="section-1">
                    <div class="section-title">
                        <h3 class="text-center">Brief of the task</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <h4 class="meddle-title">Overview</h4>
                    <p>Established in 1959, Cornerstone Group of Companies ('CGC' or 'The  Company') is a globally renowned company engaged in a multitude of services  spanning across construction and infrastructure. CGC continues to look for new  technologies and methods that add value because it believes that, even  after 60 years, there's always room for improvement. Serving project  locations within and outside the country, what sets CGC apart is their unique  approach to delivering construction. Their Integrated Construction  Services maximize the intersection of preconstruction planning and  estimating, high performance, safety, quality, virtual construction and Mechanical,  Electrical and Plumbing (MEP) coordination. Please refer to Appendix 1 for the  organization structure of CGC.</p>
                    <p>CGC is known for mobilizing a robust Project Management Office (PMO)  arm for medium to large scale projects that underpins the project delivery  mechanism ensuring that all other related streams are managed in a controlled  and effective manner. They combine all in-house expertise into a right-sized  solution, resulting in greater efficiency and providing higher levels of value  for its customers. With the degree of maturity at CGC, the PMO arm specializes  in governance, decision support and delivery support.</p>
                    <h4 class="meddle-title">Introduction</h4>
                    <p>The island of Utopia is amongst the top few destinations that is  frequently visited by local and international tourists as well as pilgrims.  Utopia, however, lacks adequate healthcare facilities that offer its  inhabitants and visitors superior specialty services. Aimed at leveraging the  city's popularity among an ever-increasing tourist population, the Central  Tourism Ministry has joined forces with Jupiter Group of Hospitals to develop a  state-of-the art modern healthcare facility in the heart of Utopia, in order to  provide the best-in-class healthcare services to its local inhabitants and  tourists alike. Shri Sushil Desai, Chairman- Ministry of Tourism, has envisaged  creation of a healthcare facility, aimed at boosting medical tourism and also  generating employment opportunities for its local residents.</p>
                    <h4 class="meddle-title">Jupiter Group of  Hospitals:</h4>
                    <p>Jupiter Group of Hospitals provides world class healthcare  facilities, neighborhood diagnostic clinics, extensive chain of Jupiter  Pharmacy, medical BPO and health insurance services. Right from the  infrastructure to the latest medical technology acquisition, Jupiter Group of  Hospitals has always kept its patients first and strived to deliver the worlds  best care to its patients since its inception.</p>
                    <p>The transformation initiative in Utopia, termed as "PULSE" is led  by Mr. Umang Patel- President, Transformation Projects, Jupiter Group of  Hospitals.</p>
                    <h4 class="meddle-title">Upgradation of Metro  Regency Hospital:</h4>
                    <p>Metro Regency is a 130-bed general hospital in Utopia, catering to  healthcare of local public. As per the directive received from Ministry of  Tourism, Metro Regency has been taken over by Jupiter Group of Hospitals for  transformation, encompassing renovation of existing infrastructure and services  along with its expansion in a phased manner. While it will be operational  during the period of renovation, adequate safety measures will be adopted along  with tight security controls to ensure that patients and hospital staff remain  unaffected during this period. Certain sections of Metro Regency will be  temporarily closed as per the project plan to renovate existing facility.</p>
                    <div class="row mb-3">
                        <div class="col-md-5">
                            <!-- insert image 1 here -->
                            <div class="text-center">
                                <img src="../../Images/set-1_cs-img_1.jpg" class="img-thumbnail mb-3" alt="Image1" />
                            </div>
                            <p class="text-center"><em>Exterior  view of the hospital as visualized by the Design Team</em></p>
                        </div>
                        <div class="col-md-7">
                            <p>CGC won the tender for this project in September last year. The  work kickstarted in January this year and is expected to complete within a  period of 38 months (starting January). The new hospital- 'Jupiter Super Specialty  Healthcare' is planned to be equipped with 650 beds. Spread over 15 acres of  land, the hospital will provide highly advanced services with round the clock  diagnostic, curative, preventive and rehabilitative care across specialties,  through its Centres of Excellence - Cardiac Sciences, Oncology (Cancer Care),  Neuro Sciences, Gastro Sciences, Orthopedics, Obstetrics & Gynecology,  Critical Care and 24X7 Trauma Care.</p>
                            <p>For the purpose of this Development Centre, you will  be playing the role of Mr. Nitin Kumar. The project has been ongoing for the  last 4 months. As the PMO Head for Project PULSE, you are the primary point of  contact from CGC to key stakeholders at Jupiter Group of Hospitals, Ministry of  Tourism and vendors associated with the project. You have 90 minutes to read  the report and answer the questions that follow. Should you require, please  feel free to use a calculator during the course of the exercise.</p>
                        </div>
                    </div>
                    <h4 class="meddle-title">Appendix 1: Top level organization structure  of CGC</h4>
                    <!-- insert image 2 here -->
                    <div class="text-center mb-3">
                        <img src="../../Images/set-1_cs-img_2.png" class="img-thumbnail mb-3 col-11" alt="Image1" />
                    </div>
                    <h4 class="meddle-title">Appendix 2: Organization structure for PULSE</h4>
                    <!-- insert image 3 here -->
                    <div class="text-center mb-3">
                        <img src="../../Images/set-1_cs-img_3.png" class="img-thumbnail mb-3 col-11" alt="Image1" />
                    </div>
                    <h4 class="meddle-title">Appendix 3: Key stakeholders (Governance  Committee Members)</h4>
                    <ol>
                        <li>Shri Sushil Desai, Chairman- Ministry of  Tourism</li>
                        <li>Mrs. Sushma Devraj, Minister- Utopia Tourism  Authority</li>
                        <li>Mr. Umang Patel- President, Transformation  Projects, Jupiter Group of Hospitals</li>
                        <li>Ms. Geetanjali Garg- Program Manager (PULSE),Jupiter Group of Hospitals</li>
                    </ol>
                </div>

                <%--Section 2--%>
                <div role="tabpanel" class="tab-pane fade" id="section-2">
                    <h4 class="meddle-title">Project Plan:</h4>
                    <p>The below snapshot presents a high-level plan of  ongoing activities on site.</p>
                    <!-- insert table 4 here -->
                    <table class="table table-bordered table-sm table-sm" style="font-size: .76rem;">
                        <thead>
                            <tr>
                                <th colspan="4">&nbsp;</th>
                                <th colspan="3" style="background: #FFCC66;">Quarter 1</th>
                                <th colspan="3" style="background: #FFCC66;">Quarter 2</th>
                                <th colspan="3" style="background: #FFCC66;">Quarter 3</th>
                            </tr>
                            <tr>
                                <th colspan="2">&nbsp;</th>
                                <th><strong>Primary Owner</strong></th>
                                <th><strong>Supervisor</strong></th>
                                <th style="width: 6%; background: #FFCCCC;">January</th>
                                <th style="width: 6%; background: #FFCCCC;">February</th>
                                <th style="width: 6%; background: #FFCCCC;">March</th>
                                <th style="width: 6%; background: #FFCCCC;">April</th>
                                <th style="width: 6%; background: #FFCCCC;">May</th>
                                <th style="width: 6%; background: #FFCCCC;">June</th>
                                <th style="width: 6%; background: #FFCCCC;">July</th>
                                <th style="width: 6%; background: #FFCCCC;">August</th>
                                <th style="width: 6%; background: #FFCCCC;">September</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="bg-light font-weight-bold">
                                <td>1</td>
                                <td colspan="12">Milestone 1 (Block B2)</td>
                            </tr>
                            <tr>
                                <td>1A</td>
                                <td>Preparatory infastructure &amp; foundation work</td>
                                <td>CGC Stream-1</td>
                                <td>CGC PMO</td>
                                <td colspan="5" style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>1B</td>
                                <td>Concrete construction</td>
                                <td>CGC Stream-1</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td colspan="4" style="background: #FFFF33;">&nbsp;</td>
                            </tr>
                            <tr class="bg-light font-weight-bold">
                                <td>2</td>
                                <td colspan="12">Milestone 2 (Block C)</td>
                            </tr>
                            <tr>
                                <td>2A</td>
                                <td>Preparatory infastructure &amp; foundation work</td>
                                <td>CGC Stream-2</td>
                                <td>CGC PMO</td>
                                <td colspan="8" style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>2B</td>
                                <td>Concrete construction</td>
                                <td>CGC Stream-2</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td style="background: #FFFF33;">&nbsp;</td>
                            </tr>
                            <tr class="bg-light font-weight-bold">
                                <td>3</td>
                                <td colspan="12">Milestone 3 (Yoga & Meditation Center)</td>
                            </tr>
                            <tr>
                                <td>3A</td>
                                <td>Construction of man complex</td>
                                <td>Design Studio</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td colspan="3" style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>3B</td>
                                <td>Construction of pavilion</td>
                                <td>Design Studio</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td colspan="3" style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>3C</td>
                                <td>Construction of fountain</td>
                                <td>Design Studio</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>3D</td>
                                <td>Machanical, electronic &amp; Pulmbing installation</td>
                                <td>CGC MEP Stream</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>3E</td>
                                <td>Road repair work (highway link road &amp; inter-facility)</td>
                                <td>CGC Stream-1</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>3F</td>
                                <td>Finishing</td>
                                <td>Design Studio</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>3G</td>
                                <td>Quality inspection and audlt </td>
                                <td>CGC</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td style="background: #FFFF33;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>3H</td>
                                <td>Inaugration</td>
                                <td>CGC PMO</td>
                                <td>JGH</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr class="bg-light font-weight-bold">
                                <td>4</td>
                                <td colspan="12">Milestone 4 (Smart Waste Management System)</td>
                            </tr>
                            <tr>
                                <td>4A</td>
                                <td>Vendor evaluation</td>
                                <td>CGC PMO</td>
                                <td>JGH</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td colspan="2" style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>4B</td>
                                <td>Vendor selection and empanelment</td>
                                <td>CGC PMO</td>
                                <td>JGH</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td style="background: #FFFF33;">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>4C</td>
                                <td>Design and prototype development</td>
                                <td>Vendor</td>
                                <td>CGC PMO</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                                <td colspan="3" style="background: #FFFF33;">&nbsp;</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="alert alert-danger">
                        <em>Note: </em>
                        <ul>
                            <li><em>Each stage within a  milestone is dependent on completion of previous steps unless indicated otherwise  in the project plan </em></li>
                            <li><em>CGC Stream-1 and Stream-2  refers to the on-ground teams working on each milestone</em></li>
                        </ul>
                    </div>
                    <div class="section-title">
                        <h3 class="text-center">Agenda 1: Smart Waste  Management System</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <p>Hospitals generate millions of tons of waste each year.  Unfortunately, waste management pertaining to health care facilities within the  landscape of Utopia, is still poorly managed and implemented. Medical waste  management is complex, and success is in large part dependent on changing the  habits of hospital staff and administration. Of the total amount of waste  generated by health-care activities, about 85% is general, non-hazardous waste.  The remaining 15% is considered hazardous material that may be infectious,  toxic or radioactive, therefore requiring a formal process for medical waste  management disposal. Jupiter Group of Hospitals has chosen to install  one-of-a-kind automated waste collection system in order to ensure that waste  collection in and around the hospital is made hygienic, safe, modernized and  simple to use for patients and staff. The rate  of&nbsp;generation&nbsp;of&nbsp;hospital waste&nbsp;is estimated to be 3.3 to 4.9  pounds/day/bed at JGH.</p>
                    <p>The  automated waste collection system envisaged by JGH utilizes pneumatic tube  technology (PTT) which leverages compressed air or partial vacuum to transport  solid objects as opposed to a traditional hand carted system. The pneumatic  waste collection facility at JGH will encompass two separate pipe networks- one  for linen/ laundry and one for general waste- that would transport waste from  58 disposal points located at each designated section of the hospital, located  over 8 floors, throughout the hospital. The pipe network will be spread across  a length of 1315 feet. With PTT, used linen/ laundry and general waste will be  transported from the disposal points, via airflow, to automated conveyors that will  feed the trolleys before being sent to laundry rooms or to waste processing  areas. A central computer will automatically manage the waste management process  and provide the hospital with real time data relating to collection levels and  frequency.</p>
                    <p>By leveraging this technology, the time required to manually handle  waste will significantly reduce as hospital porters will no longer be required  to push and pull waste collection trolleys around the hospital. It will  contribute to a cleaner and more productive environment. It will reduce the  risk of spreading infections by minimizing the risk of cross contamination from  waste-related pathogens, both airborne and physically spread to achieve  improved infection control and cleanliness levels. The pneumatic system will  also minimize the operational cost of waste collection compared with  conventional, hand carted method by reducing energy consumption attributable to  using hospital elevators and by reallocating the time that would have been  spent transporting waste by hospital porters to other front of house duties.  Bin rooms will no longer be required, which means additional floor space can be  allocated to patient care. The system will be fully operational 24 hours a day,  365 days a year and will reflect the hospital&rsquo;s commitment to world-class  standards.</p>
                    <p>You have been invited by Ms. Geetanjali Garg to attend a meeting with  the Governance Committee of PULSE. Your team has  provided some interesting statistics (Reference Table A) pertaining to healthcare  facilities where this system has been implemented along with the traditional  hand carted system.</p>
                    <div class="section-title">
                        <h3 class="text-center">Table A<br />
                            <span>Cost of Transporting Waste (in Utopian Dollars)</span></h3>
                        <div class="title-line-center"></div>
                    </div>
                    <table class="table table-bordered table-sm table-sm">
                        <thead>
                            <tr>
                                <th>&nbsp;</th>
                                <th colspan="2">St. Mary's Hospital</th>
                                <th colspan="2">Vcare Hospital</th>
                                <th colspan="2">New Life Hospital</th>
                            </tr>
                            <tr>
                                <th>Comparison of weight vs. volume</th>
                                <th>Pneumatic Tube</th>
                                <th>Hand Carted</th>
                                <th>Pneumatic Tube</th>
                                <th>Hand Carted</th>
                                <th>Pneumatic Tube</th>
                                <th>Hand Carted</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Avg. pounds/ day transported through waste system</td>
                                <td>882</td>
                                <td>1,391</td>
                                <td>1,115</td>
                                <td>3,330</td>
                                <td>2,218</td>
                                <td>1,460</td>
                            </tr>
                            <tr>
                                <td>Cost per pound </td>
                                <td>0.13</td>
                                <td>0.06</td>
                                <td>0.15</td>
                                <td>0.03</td>
                                <td>0.1</td>
                                <td>0.07</td>
                            </tr>
                            <tr>
                                <td>Avg. cubic ft/ day transported through waste system</td>
                                <td>382</td>
                                <td>185</td>
                                <td>557</td>
                                <td>1018</td>
                                <td>1008</td>
                                <td>180</td>
                            </tr>
                            <tr>
                                <td>Cost per cubic ft </td>
                                <td>0.3</td>
                                <td>0.41</td>
                                <td>0.3</td>
                                <td>0.09</td>
                                <td>0.22</td>
                                <td>0.54</td>
                            </tr>
                        </tbody>
                    </table>
                    <p>The Governance Committee firmly believes that introducing Smart  Waste Management System will enable Jupiter Group of Hospitals to provide state-of-the-art  healthcare services for the very first time in Utopia. For this purpose, the  client is looking to partner with an innovative, cost effective and an  established service provider with prior experience in the market. These factors  also comprised the primary evaluation criteria for vendor selection.</p>
                    <p>It is envisaged that as part of the contract, the selected partner  will be expected to design, build, install the Waste Management system. Although,  they will have end to end responsibility of building the Waste Management  System, the project will be a part of PULSE, where it will be overseen and  controlled by the PMO Division of CGC. The project research team has conducted a  comprehensive market study to identify potential partners who are experts in the  field of Smart Waste Management. A summary of quotations received from vendors  is summarized in Table B.</p>
                </div>

                <%--Section 3--%>
                <div role="tabpanel" class="tab-pane fade" id="section-3">
                    <h4 class="meddle-title">Summary of research conducted by your team:</h4>
                    <div class="section-title">
                        <h3 class="text-center" style="font-size: 1.1rem;">Option 1: InnovaCare</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <p>InnovaCare is a German company engaging in design and construction of waste management system. They are known for designing custom made solutions as per client requirements. They come with over 35 years of experience and have immense goodwill in the market. The company has successfully delivered large scale projects in the past. Earlier this year, Sweden’s largest chain of hospitals chose InnovaCare as their partner for ‘technology enabled healthcare waste management scheme’, one of the world’s most ambitious Biomedical Waste Management projects. InnovaCare is now partnering with other Scandinavian countries to provide smart healthcare waste management solutions.</p>
                    <h4 class="meddle-title">Possible issues</h4>
                    <ul>
                        <li>Due to its immense  success in previous projects, InnovaCare is in extremely high demand and  thereby quotes high commercials. However, it is a safe option to partner with,  given the brand image and guaranteed quality.</li>
                        <li>Apart from design and construction, as part of their  offering, InnovaCare also charges a premium for installation of waste disposal  points as they use a third party to do the installation. Thereby, the rate of installation  is significantly high as compared to a package deal.</li>
                    </ul>
                    <div class="section-title">
                        <h3 class="text-center" style="font-size: 1.1rem;">Option 2: ECube Labs Ltd.</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <p>ECube Labs Limited is a Korean  organization established 25 years ago. Whether it's a university campus, theme  park, hospital, or zoo, ECube Labs has provided custom deployments to clients  of small and large size. The organization has executed many successful projects  in the past and comes with a reputation of delivering quality work within the  stipulated timeline. They also offer an end-to-end deal, including design,  construction and installation. Additionally, ECube Labs offers an advanced  remote monitoring and recording technology where the staff can observe and  control the live process in the office.</p>
                    <p>However, in a recent assignment  executed by the firm for a mall located in China, there were some quality  issues with the work that was executed. The firm was accused of being lax on  their quality parameters. The incident garnered negative publicity for ECube  Labs, raising concerns on the authenticity of all batches of raw material used  and the construction authority had to conduct an extensive quality check drive  for every network pipe.</p>
                    <p>The firm claims that the material was as  per defined standards. It was the constant water leakage in the adjoining walls  at the site location that led to the damage. While the issue is still under  investigation, ECube has recently won a contract with a theme park in Indonesia  to design and construct their smart waste management system.</p>
                    <h4 class="meddle-title">Possible issues</h4>
                    <ul>
                        <li>The issue at the  mall in China is a cause of worry as the quality of material used may be  sub-standard.</li>
                        <li>Jupiter Group of  Hospitals might disagree to on-board ECube Labs Ltd., given the recent case of  quality issues and reputational damage faced.</li>
                    </ul>
                    <div class="section-title">
                        <h5 class="text-center">Option 3: New Sense & Co.</h5>
                        <div class="title-line-center"></div>
                    </div>
                    <p>Based in China, New Sense & Co. is  a well-established company and has been in existence for almost 20 years. It  has positioned itself as a provider of economical solutions and works mostly on  budget assignments, with low degree of customization. They do not offer the  most technologically advanced solutions unlike the other vendors but are known  for their quality and timely delivery of work, meeting all the applicable  quality standards.</p>
                    <p>They have executed projects where they  have designed and installed network pipe systems that does not provide any real  time data pertaining to collection levels and frequency.</p>
                    <p>However, they have recently joined  forces with a start-up that specializes in waste recognition and fill-level  control technology, which will enable New Sense & Co. to digitalize their  waste management system in the next few months.</p>
                    <h4 class="meddle-title">Possible  issues:</h4>
                    <ul>
                        <li>If contracted only  for their core capability, it will be a challenge to get the client to agree to  a solution that is not as technologically advanced as the ones available in the  market.</li>
                        <li>If contracted along  with its relatively new digitalized solution, this will be the first time that  New Sense & Co. will execute an end-to-end smart waste management system,  which might pose a possible risk to timely closure of the project as well as  the project quality.</li>
                    </ul>
                    <div class="section-title">
                        <h3 class="text-center">Table B<br />
                            <span>Summary of quotations received from Vendors</span></h3>
                        <div class="title-line-center"></div>
                    </div>
                    <table class="table table-bordered table-sm text-center">
                        <thead>
                            <tr>
                                <th colspan="5"><em>All costs in Thousand Utopian Dollars (UD)</em></th>
                            </tr>
                            <tr>
                                <th>S. No</th>
                                <th>Particulars</th>
                                <th><em>InnovaCare</em></th>
                                <th><em>ECube Labs</em></th>
                                <th><em>New Sense </em></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td colspan="4" class="text-left">Area cost</td>
                            </tr>
                            <tr>
                                <td>1.a</td>
                                <td><em>Laundry collector</em></td>
                                <td>32</td>
                                <td>23</td>
                                <td>16</td>
                            </tr>
                            <tr>
                                <td>1.b</td>
                                <td><em>Waste collector</em></td>
                                <td>30</td>
                                <td>21</td>
                                <td>12</td>
                            </tr>
                            <tr>
                                <td>1.c</td>
                                <td><em>Fan room</em></td>
                                <td>18</td>
                                <td>10</td>
                                <td>8</td>
                            </tr>
                            <tr>
                                <td>1.d</td>
                                <td>Control panel</td>
                                <td>12</td>
                                <td>6</td>
                                <td>2**</td>
                            </tr>
                            <tr>
                                <td>1.e</td>
                                <td><em>Load stations</em></td>
                                <td>62</td>
                                <td>44</td>
                                <td>36</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td><em>Air tubes (Linen and waste)</em></td>
                                <td>15</td>
                                <td>6</td>
                                <td>5</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td><em>Pneumatic equipment &amp; installation</em></td>
                                <td>215*</td>
                                <td>170</td>
                                <td>160</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Labour Cost</td>
                                <td>25</td>
                                <td>19</td>
                                <td>16</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Bags to transport waste</td>
                                <td>6</td>
                                <td>14</td>
                                <td>11</td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>Utilities (power &amp; control)</td>
                                <td>10</td>
                                <td>5</td>
                                <td>4</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>Total Cost (For Year 1)</td>
                                <td>425</td>
                                <td>318</td>
                                <td>270</td>
                            </tr>
                        </tbody>
                    </table>
                    <p>
                        <em>*InnovaCare will hire a third party to get the assembly and installation, hence a premium has been charged
                        <br />
                            **Indicates cost without advanced technology. Cost with technology is approximately 8000 UD</em>
                    </p>
                </div>

                <%--Section 4--%>
                <div role="tabpanel" class="tab-pane fade" id="section-4">
                    <div class="section-title">
                        <h3 class="text-center">Agenda 2: Backlash from Local Community</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <p>The hospital building is envisaged to be a major infrastructural  landmark within the geographic area. While that presents an exciting  opportunity, it can also mean that community members may have their own  opinions or objections to the ongoing construction. The area surrounding the  existing hospital premises comprises numerous small sized clinics and centers  offering low cost treatments. While these clinics are run by a joint group of  Non-profit organizations to benefit the larger community, the land is owned by  the government.</p>
                    <p>As a result of the renovation and expansion plan of Jupiter Super  Specialty HealthCare Facility, the area occupied by these clinics and treatment  Centres will be allocated to the Jupiter Group of Hospitals, as per the  direction received from Ministry of Health and State Government. The recent  announcement has spurred outrage among community members and local activists of  a nearby village. The local community comprising approximately 500 families  depends on these clinics and treatment centers for all their medical  requirements, including extremely cost-effective treatment for children, adults  as well as the elderly. Establishment of a high-end private healthcare facility  instead of an affordable medical treatment poses a threat to these local families.</p>
                    <p>Several opposition parties have sided with local activists and are  supporting the cause, claiming that as a result of the upcoming Super Specialty  Hospital, local households will be severely impacted as they will no longer  have access to affordable medical care due to demolishment of the existing  facilities.</p>
                    <p>Hundreds of families recently gathered around the construction  premises to mass protest against the demolishment of these clinics and  treatment centers. During the rally, some angered activists threatened to  assault members of hospital staff. In response to the threat, the hospital  staff including administration and nurses are now planning to go on strike,  demanding justice for the hospital staff members who have been threatened.  Anita, a nurse working at the hospital, said "It is not justified why hospital  staff would be threatened to get assaulted like this. We do the best for our  patients, but in the end, we are threatened and attacked like this." Your team  members have informed you that some members of the workers' union may also be  expected to join the strike as they belong to the nearby village area.</p>
                    <p>Mr. Umang Patel and Ms. Geetanjali Garg are currently unavailable  due to an ongoing transformation project overseas and have asked CGC to resolve  the issue as soon as possible to avoid any reputational damage.</p>
                    <div class="section-title">
                        <h3 class="text-center">Agenda 3:  Unprecedented project delay</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <p>In  the island of Utopia, there has been a significant deterioration in the quality  of air over the last 2-3 years during the winter months. The major contributor  to the root cause lies in burning of crop residue in the adjoining islands  leading to a spike in air pollution during the winter months.</p>
                    <p>According  to a study by the Pollution Control Board, construction and demolition  activities also form one of the contributing factors for high levels of air  pollution. Utopia is witnessing massive infrastructure development works like  construction of transportation networks, highways, bridges, hospitals,  commercial establishments amongst others. Construction and demolition  activities generate a lot of dust which when mixed with prevalent smog further  deteriorates the quality of air.</p>
                    <p>Last evening, the Supreme Court-mandated Environment Pollution  Authority had declared a "public health emergency", warning residents  to not leave homes as smog enveloped streets of the city. Following this, the  State government decided to shut all schools, offices and has ordered all  construction work to stop. Experts have advised to wear anti-pollution masks  during outdoor exposure and limit outdoor activities to a minimum.</p>
                    <h4 class="meddle-title">Current Situation 1</h4>
                    <p>While  public health emergency has been declared for a week as of last evening, smog  is expected to prevail for at least 30 days. It is probable that construction  related activities will not be entirely resumed during this period in order to  avoid any further deterioration of the situation. All construction companies  have been advised to make advance plans to deal with the lax period.</p>
                    <p>The  tender for Project PULSE has not factored in time for any natural calamity.  While the initial project schedule was made by taking into account potential  risks and delays, the built-in buffer for delay has already been exhausted due  to lag in receipt of construction material by a supplier, which impacted the  timely renovation of roof covering the main entrance area. Post the lag, you  had promised the client that there will be no further delay in the ongoing  renovation, as it has been causing a lot of inconvenience to patients as well  as the staff alike.</p>
                    <h4 class="meddle-title">Current Situation 2</h4>
                    <p>One  month post this incident, you receive a firm-wide communication from your  internal Quality & Risk Management Team, intimating all Team Leads about a  quality and process improvement audit to be scheduled across all active  construction sites. Upon gathering further information, it is known that the  trigger for a sudden quality assessment was deviation from quality standards in  material used for the construction of a commercial building developed by CGC,  that falls under a seismic active zone. The cost impact resulting due to this  quality issue resulted in spending by 12% on the reconstruction.</p>
                    <p>Two  independent consulting firms will be engaged for this process. Phase 1 of the  transformation project will encompass identification of red flags derived  through a thorough quality assessment and addressing of gaps, whereas Phase 2  of the project will entail diagnosis of lags and improvement opportunities in  systems, processes and workforce productivity on site.</p>
                    <p>As  new processes are implemented, multiple systems as well as people involved in  managing those systems will require alignment. You envisage resistance from  your on-ground project team and workers towards process improvement. Moreover, workforce  productivity enhancement exercise may have a negative impact on the motivation  of staff. Given that the project is at such a crucial juncture, where any more  delay in project plan would sabotage your reputation and relationship with the  client, you are unsure about taking up this additional task.</p>
                </div>

                <%--Section 5--%>
                <div role="tabpanel" class="tab-pane fade" id="section-5">
                    <div class="section-title">
                        <h3 class="text-center">Agenda 4: Yoga and Meditation Centre Inauguration</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <p>It was a dream conceived by Shri Nirmala Devi- the founder of Metro  Regency to construct a building for Yoga Centre on the same site. Shri Nirmala  Devi was a highly influential leader of her era, who played an important role in  the development of Utopia. To honor her memory, the Ministry of Tourism has  envisioned incorporation of a Yoga and Meditation Centre within the hospital  facility premises. This centre will be located in the outer section of the  hospital premises, situated in the midst of a huge green garden with flowering  bushes, fruit plants and trees; the entrance will have a big pavilion,  decorative fountain and a road network linking the main highway to Yoga Centre  as well as interlinking the Yoga Centre to various blocks within the hospital.</p>
                    <p>The project schedule for the Yoga and Meditation Centre is spread  over a period of 5 months, keeping in mind the inauguration date. The Centre  will be inaugurated by the Head- Ministry of Tourism during his visit to Utopia  for other important state affairs. The construction of the main building of  Yoga and Meditation Centre, pavilion and water fountain is underway.</p>
                    <p>Cornerstone Group of Companies has outsourced the construction of  this complex to a boutique design and engineering firm- Design Studio, who has  been sub-contracted for design, construction and periodic maintenance of the  Yoga and Meditation Centre Complex.</p>
                    <p>Two months into the initiation of the assignment, you have started  facing difficulties with Design Studio. While the work delivered is high on  quality, the time taken by them to complete a piece of work is usually much  more than the budgeted timeline. The project management for Design Studio is  poor and they are not being able to accurately estimate the time and effort  required for timely construction of the Complex. You have also observed that  Design Studio is not deploying adequate manpower to the project (Refer to Table  C for a summary of manpower shortage). A Project Lead in your team who is  responsible for handling the contractor has previously tried to communicate  this issue of manpower shortage to the Project Manager at Design Studio,  however there has been no permanent resolution yet. The prolonged back and  forth has also resulted in disputes between your team and Design Studio,</p>
                    <p>As the construction is ongoing, you realize that the impressive  picturesque Yoga and Meditation Centre cannot partly remain in the state of  shambles on the day of inauguration.</p>
                    <div class="section-title">
                        <h3 class="text-center">Table C<br />
                            <span>Summary of Manpower Shortage (Total Manpower as per contract with Design Studio = 40)</span></h3>
                        <div class="title-line-center"></div>
                    </div>
                    <table class="table table-bordered table-sm text-center">
                        <thead>
                            <tr>
                                <th style="width: 18%;">&nbsp;</th>
                                <th colspan="3">Month 1</th>
                                <th colspan="3">Month 2</th>
                            </tr>
                            <tr>
                                <th>Scenario</th>
                                <th>No. of Instances</th>
                                <th>Weightage</th>
                                <th>No. of man-days lost (instances *weightage *manpower)</th>
                                <th>No. of Instances</th>
                                <th>Weightage</th>
                                <th>No. of man-days lost (instances *weightage *manpower)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>No work was done</td>
                                <td>2</td>
                                <td>1</td>
                                <td>80</td>
                                <td>1</td>
                                <td>1</td>
                                <td>40</td>
                            </tr>
                            <tr>
                                <td>Work impacted by 50%</td>
                                <td>3</td>
                                <td>0.5</td>
                                <td>60</td>
                                <td>5</td>
                                <td>0.5</td>
                                <td>100</td>
                            </tr>
                            <tr>
                                <td>Work impacted by 25%</td>
                                <td>11</td>
                                <td>0.25</td>
                                <td>110</td>
                                <td>7</td>
                                <td>0.25</td>
                                <td>70</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>16</td>
                                <td>&nbsp;</td>
                                <td>250</td>
                                <td>13</td>
                                <td>&nbsp;</td>
                                <td>210</td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="section-title">
                        <h3 class="text-center">Agenda 5: New Technology for Roadway</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <p>You recently attended the 10th International Conference  on Construction Engineering and Project Management (ICCEPM), with the agenda  titled 'Toward sustainable and smart construction'.</p>
                    <p>The conference echoed the belief that technological advances and  the emergence of the new sustainable and digital world will drive a step-change  in how we build and how our built environment operates. Industry scholars and  experts from across the globe were invited to discuss the application and  development of sustainable and smart construction and management concepts in  building, civil and infrastructure construction projects.</p>
                    <p>During the conference, you attended a panel discussion led by  Professor Albert Chan from The Hong Kong Polytechnic University. A Chartered  Construction Manager, Engineer, Project Manager, and Surveyor by  profession, Prof. Chan has won a number of prestigious research paper and  innovation awards for his work in the field of 'Sustainable Roadway  Infrastructure'.</p>
                    <p>Following is an excerpt from the discussion that you recall:</p>
                    <p>"China has opened a 1-kilometer long solar road in Jinan, the  capitol of Shandong province south of Beijing. The two-lane road covers 5,875  square meters and can generate up to 1 million kilowatt-hours of power annually  — enough to power 800 Chinese homes. The electricity will be used to run street  lights, billboards, surveillance cameras, and toll collection plazas. It will  also be used to heat the road surface to keep it clear of snow. Any excess will  be fed back into the local utility grid. The surface of the road is made of  transparent concrete which can withstand 10 times more pressure than regular  concrete, according to  Slate. Beneath the concrete are solar panels that convert sunlight to  electricity. Under the solar panels is an insulating layer designed to protect  them from excessive heat or cold."</p>
                    <p>Post the discussion, you and your colleagues were left  with the thought that perhaps more so than any other developing country, Utopia  is confronted with the effects of pollution and therefore needs to establish  vast amounts of renewable energy infrastructure.</p>
                    <div class="section-title">
                        <h3 class="text-center">Agenda 6: Disciplinary and Quality Issues</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <p>Few days after the issue of manpower shortage was resolved, your  Project Lead, Arnav, has voiced his concern regarding some cases of unreported  theft and indiscipline among workmen deployed in the construction of Yoga and  Meditation Centre. Imported decorative material for ceiling, glass windows and  expensive flooring material were found missing in astonishingly high volumes.</p>
                    <p>Arnav suspects that the security guards responsible for routine  frisking of workers aren't complying by the process entirely, thereby, leading  to unidentified and unreported theft of such costly construction material. He  also reported that CCTVs installed on site have not been helpful as they  require to be constantly relocated due to ongoing construction and get damaged  in the process. Arnav suggested that while many new technologies and systems,  such as drone, smart wearables etc. are available to increase safety and  security of on-site operations, he faced numerous issues in his previous organization  during implementation of these technologies, as it was difficult to drive  adoption and change the mindset of workers, their supervisors and contractors  towards using improved systems. Arnav suspects that the client will also be  hesitant towards investing in these technologies.</p>
                    <p>You decide to give this challenge a thought.</p>
                    <p>As soon as Arnav leaves the room, you receive a call from your colleague  informing you that Purity Suppliers- one of your suppliers for the ongoing  Jupiter Super Specialty Healthcare Facility Project, has become insolvent and  are unable to pay their debts; and may declare a state of bankruptcy soon.</p>
                    <p>Few days prior to this call, you had on-boarded Purity  Suppliers based out of China- for supply of antique glass windows to be used  for the construction of Yoga and Meditation Centre, upon strong  recommendation by the client. However, if this information is accurate, according  to the policy and guidelines set by the Vendor Database Management team, you  will have to take immediate action in this regard and remove this vendor from  the empaneled list of suppliers.</p>
                </div>

                <%--Section 6--%>
                <div role="tabpanel" class="tab-pane fade" id="section-6">
                    <div class="section-title">
                        <h3 class="text-center">Sample Answers for Case Study Descriptive Questions</h3>
                        <div class="title-line-center"></div>
                    </div>
                    <h4 class="meddle-title">Index</h4>
                    <table class="table table-bordered table-sm">
                        <thead>
                            <tr>
                                <th># </th>
                                <th>Theme </th>
                                <th>Sample answers </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td rowspan="3">Question 3</td>
                                <td rowspan="3">Solving Problems and Taking Decisions</td>
                                <td><a href="#ques-3">Ideal answer</a></td>
                            </tr>
                            <tr>
                                <td><a href="#ques-3">Average answer</a></td>
                            </tr>
                            <tr>
                                <td><a href="#ques-3">Below average answer</a></td>
                            </tr>
                            <tr>
                                <td rowspan="3">Question 7</td>
                                <td rowspan="3">Process Orientation </td>
                                <td><a href="#ques-7">Ideal answer</a></td>
                            </tr>
                            <tr>
                                <td><a href="#ques-7">Average answer</a></td>
                            </tr>
                            <tr>
                                <td><a href="#ques-7">Below average answer</a></td>
                            </tr>
                            <tr>
                                <td rowspan="3">Question 9</td>
                                <td rowspan="3">Appreciating Big Picture </td>
                                <td><a href="#ques-9">Ideal answer</a></td>
                            </tr>
                            <tr>
                                <td><a href="#ques-9">Average answer</a></td>
                            </tr>
                            <tr>
                                <td><a href="#ques-9">Below average answer</a></td>
                            </tr>
                            <tr>
                                <td rowspan="3">Question 11</td>
                                <td rowspan="3">Change (learning) agility</td>
                                <td><a href="#ques-11">Ideal answer</a></td>
                            </tr>
                            <tr>
                                <td><a href="#ques-11">Average answer</a></td>
                            </tr>
                            <tr>
                                <td><a href="#ques-11">Below average answer</a></td>
                            </tr>
                        </tbody>
                    </table>

                    <div id="ques-b">
                        <h4 class="meddle-title">Question Bank</h4>
                        <p><b>Question 3: Solving problems and taking  decisions</b></p>
                        <p>The client has  asked you to suggest a vendor for the Smart Waste Management System. Which  vendor will you recommend? Support your choice with a detailed rationale.</p>
                        <p><b>Question 7: Process orientation</b></p>
                        <p>You receive a call from the  Country Head of Quality &amp; Risk Management to inform you about the specifics  of quality assessment, process and workforce study at your site. How will you  respond to the situation to ensure that quality standards are met without  impacting the project timeline?</p>
                        <p><b>Question 9: Appreciating big picture</b></p>
                        <p>You have an upcoming monthly  meeting with the Chairman of the Jupiter Super Specialty Hospital and you are  aware that ensuring the readiness of the Yoga and Meditation Centre and its  surrounding area is the responsibility of Cornerstone. It is extremely crucial  to the Chairman that the entire set-up for the Yoga &amp; Meditation Centre is  ready as it will be featured in newspapers and covered extensively by media on  the day of inauguration. You are also expecting the Project Manager of Design  Studio and Quality Team to be present in the meeting. What will be your  recommended approach to address the situation so that the impact of this delay  is minimized? Provide a detailed rationale for the same.</p>
                        <p><b>Question 11: Change (learning) agility</b></p>
                        <p>Arnav wants to  schedule a meeting with you to discuss possible solutions for the theft case at  Yoga &amp; Meditation Centre. What will you recommend as a solution to Arnav  and how will you ensure its implementation at the site?</p>
                    </div>

                    <div id="ques_3">
                        <h4 class="meddle-title"><em>Question 3 - Solving Problems and Taking Decisions</em></h4>
                        <p>The client has asked  you to suggest a vendor for the Smart Waste Management System. Which vendor  will you recommend? Support your choice with a detailed rationale.</p>
                        <p><strong>Sample Answer for Question 3 - </strong>Ideal</p>
                        <p>Based on the stated client  requirement, following parameters need to be considered while selecting a  vendor for smart waste management system</p>
                        <ul>
                            <li>Degree of innovation</li>
                            <li>Cost effectiveness</li>
                            <li>Prior experience in the market</li>
                        </ul>
                        <ol>
                            <li>
                                <p><b>Degree of innovation:</b></p>
                                <p>While InnovaCare offers a  standard level of innovation, ECube Labs and NewSense provide differentiated  technology.</p>
                                <p>Risk: Selecting NewSense  could be a potential risk as they are integrating with a new partner and have  not developed such a solution previously. However, NewSense does not provide  high degree of customization unlike other vendors</p>
                                <p>Based on degree of innovation- Priority order</p>
                                <ul class="mb-4">
                                    <li>ECube Labs</li>
                                    <li>InnovaCare</li>
                                    <li>NewSense</li>
                                </ul>
                            </li>
                            <li>
                                <p><b>Cost effectiveness:</b></p>
                                <p>InnovaCare is  the most expensive choice, almost 30% higher cost than the average cost of  end-to-end system installation. While the one-time installation cost is fixed,  the power and control cost will result in a higher year-on-year cost for  running the equipment compared to the other options. ECube Labs provides  affordable cost, while NewSense Co is the most economical.</p>
                                <p>Risk: The cost component  corresponding to Bags required to transport waste is substantially lower in  case of InnovaCare. This may have an implication on the quality or constituent  components of the bag.</p>
                                <p>Based on degree of innovation- Priority order</p>
                                <ul class="mb-4">
                                    <li>ECube Labs</li>
                                    <li>New Sense</li>
                                    <li>Innova Care</li>
                                </ul>
                            </li>
                            <li>
                                <p><b>Prior experience in the market:</b></p>
                                <p>ECube and NewSense have been  in the market for 20-25 years, InnovaCare is the most established vendor, who  has provided services to a large- scale projects in the healthcare sector</p>
                                <p>Risk: While all 3 vendors  have substantial experience, NewSense &amp; Co&rsquo;s new partnership does not have  any experience in the market.</p>
                                <p>Based on prior experience- Priority order</p>
                                <ul>
                                    <li>Innova Care</li>
                                    <li>ECube Labs</li>
                                    <li>NewSense &amp; Co.</li>
                                </ul>
                            </li>
                        </ol>
                        <p>Other potential risks:</p>
                        <ul>
                            <li>Innova Care- Dependency on  third party for assembly and installation, may raise concerns from legal  safety, quality and timeline perspective.</li>
                            <li>ECube Labs- Clearing  background check may be an issue given the ongoing investigation</li>
                        </ul>
                        <p>Based on the above analysis, I will recommend</p>
                        <p>Choice 1. ECube Labs. This  vendor offers innovative solution at an affordable cost, with extensive  experience. However, will choose this only if its investigation has been  cleared.</p>
                        <p>Choice 2. InnovaCare Labs.  This vendor comes with immense experience and is known for its quality and  delivery. However, will investigate the reason for extremely low cost of bags  required to transport waste and ascertain the quality standards for the same.</p>
                        <p>Will not recommend NewSense as its  technologically integrated solution is not tried and tested in the market, and  thus it fails to make the cut as per the requirements of JGH.</p>
                        <p><strong>Sample Answer for Question 3 - </strong>Average</p>
                        <p><strong>1. Innova Care</strong></p>
                        <p>Pros</p>
                        <ul>
                            <li>Extremely high goodwill in the market and strong  credentials</li>
                            <li>High quality assurance of material, equipment</li>
                            <li>Rich experience in the sector of healthcare, as  required by client</li>
                            <li>Customization of the waste management system is  possible</li>
                        </ul>
                        <p>Cons</p>
                        <ul>
                            <li>Almost 30% higher cost than  the average cost of end-to-end system installation</li>
                            <li>Hiring third party for  assembly and installation may require multiple background check to ensure to  ascertain legal safety</li>
                            <li>While the one-time installation cost is fixed,  the power and control cost will result in a higher year-on-year cost for  running the equipment compared to the other options</li>
                        </ul>
                        <p><strong>2. ECube Labs Ltd</strong></p>
                        <p>Pros</p>
                        <ul>
                            <li>Experience across diverse  sectors, industries, infrastructural landscape</li>
                            <li>Assurance on delivery within stipulated timeline</li>
                            <li>Affordable costing of the waste management  system</li>
                            <li>Offer a technologically  advanced technology that differentiates it from other competitors</li>
                            <li>Offers an end-to-end deal  including design, construction and installation, therefore no dependency on a  third party to complete the required task</li>
                        </ul>
                        <p>Cons</p>
                        <ul>
                            <li>The vendor has suffered a reputational damage in  the recent past</li>
                            <li>If selected, it may not clear the background  verification process given the recent happenings</li>
                        </ul>
                        <p><strong>3. New Sense &amp; Co</strong></p>
                        <p>Pros</p>
                        <ul>
                            <li>Extremely cost effective service provider</li>
                            <li>If technologically  integrated, it will provide a differentiated smart system as the technology  partner specializes in waste recognition and fill-level control technology</li>
                            <li>Assurance on quality, time and adherence to applicable  standards</li>
                        </ul>
                        <p>Cons</p>
                        <ul>
                            <li>Low degree of customization</li>
                            <li>High risk pertaining to new partnership</li>
                        </ul>
                        <p>Based on the above analysis  of Pros and Cons, I will recommend ECube Labs Ltd as the partner of choice for  the following differentiating points:</p>
                        <ul>
                            <li>Advanced technology</li>
                            <li>End-to-end package deal without dependency on  third party</li>
                            <li>Affordable costing</li>
                            <li>Delivery and timeline assurance</li>
                        </ul>
                        <p>However, will only consider selection under following  conditions:</p>
                        <ul>
                            <li>A clear background check report is obtained by  JGH</li>
                            <li>The ongoing investigation  report proves that the raw material supplied by them was not faulty and it was  a result of constant water leakage</li>
                        </ul>
                        <p><strong>Sample Answer for Question 3</strong> - Below Average</p>
                        <ol>
                            <li>
                                <p><b>Innova Care</b></p>
                                <p>InnovaCare is the safest  option to go with. It comes with 35 years of experience in delivering projects  of large scale. Given its goodwill in the market, the waste management system  will be of extremely high quality. They are known to develop customized  solutions, thus will be a good choice to partner with</p>
                            </li>
                            <li>
                                <p><b>ECube Labs Ltd</b></p>
                                <p>It will be a risk to choose  ECube Labs as there have been quality issues in the past. The client would also  not want to partner with a vendor who has suffered reputational damage as this  is a state-of-the-art project.</p>
                            </li>
                            <li>
                                <p><b>New Sense &amp; Co</b></p>
                                <p>This vendor is extremely  cost-effective, but they lack experience in executing technologically enabled  waste management systems. As the client has chosen to install a smart waste  management system, the vendor does not have sufficient experience in the field</p>
                                <p>I will recommend InnovaCare as the option</p>
                            </li>
                        </ol>
                    </div>

                    <div id="ques-7">
                        <h4 class="meddle-title"><em>Question 7 - Process Orientation</em></h4>
                        <p>You receive a call from the  Country Head of Quality &amp; Risk Management to inform you about the specifics  of quality assessment, process and workforce study at your site. How will you  respond to the situation to ensure that quality standards are met without impacting  the project timeline?</p>
                        <p><strong>Sample Answer for Question 7</strong> - Ideal</p>
                        <p>I shall respond to the  Quality Head with the following rationale and suggest below action items:</p>
                        <p><strong>Phase 1  Quality Assessment</strong></p>
                        <ol>
                            <li>A quality assessment shall  help in identifying areas of concern at an early stage that if not rectified  may hamper the success of the project as well as the reputation of the  organization. However, I will express concern pertaining to the delay resulted  due to Public Health Emergency declaration. Highlight the need to arrive at a  suitable timeline to conduct the audit. This can be achieved by prioritizing  activities that have been recently closed and resources are not deployed for  the same, such as foundation work for Block B2, main complex of Yoga Centre and  pavilion.</li>
                            <li>Inform Quality Head about all  the quality audits that have been done in the past. Also apprise him on the  corresponding action taken for each finding so that a detailed assessment is  not required from scratch.</li>
                            <li>Inform him that a quality assessment  is scheduled for Yoga and Meditation Centre in September. Two audits can be  combined to conduct a single audit to optimize time and effort.</li>
                            <li>Mention to the Quality Head  to involve my team members in the planning of quality assessment as they will have  a clear idea on the ongoing and scheduled activities. This will help to  continue on-site operations smoothly while also deriving benefit from the  quality assessment.</li>
                            <li>Sensitize the client that a  firm-wide quality assessment has been issued. Its purpose is to reaffirm our  adherence to quality standards. Reassure the client that it will be planned in  a manner that it does not impact project timeline.</li>
                        </ol>
                        <p><strong>Phase 2  Process, System and Productivity Improvement</strong></p>
                        <ol>
                            <li>Appreciate the initiative  taken by the firm, as this will optimize the project cost in the long run.  While the findings may not be implemented in this year, their implementation in  Year 2 and Year 3 of the project will result in cost savings. An external  consultant will also bring in the perspective of best market practices that can  be incorporated.</li>
                            <li>Provide a list of scheduled  activities to the Quality Head, detailed project plan and manpower plan for the  following:
                        <ol type="A">
                            <li>Concrete construction of Block B2</li>
                            <li>Fountain construction for Yoga and Meditation  Centre complex</li>
                            <li>MEP installation</li>
                            <li>Road repair work</li>
                        </ol>
                            </li>
                            <li>Ask the Quality Head to put  the consultant team in touch with your team to prioritize the areas where such  interventions can begin immediately. The project team can also share areas of  concern</li>
                            <li>Sensitize the client that  such projects are aimed at improving speed of delivery by enhancing  productivity and optimizing costs. Reassure that these planned activities shall  not interfere with project schedule in any manner as I will also educate the  team</li>
                            <li>Plan a workshop with the  on-ground resources. Ensure that they are aware of the objectives of this  project and that it is meant for their betterment so that their effort are  minimized. Answer to their queries and gather support. Create a suggestion box where  project resources can contribute through ideas or highlight complaints, if any.</li>
                        </ol>
                        <p><strong>Sample Answer for Question 7</strong> - Average</p>
                        <p>I shall take the following steps in response to  the situation:</p>
                        <ol>
                            <li>Will respond to the Quality  Head with evidence supporting adherence to quality standards at all stages of  Project PULSE</li>
                            <li>If there are any further  findings from the Quality Team, we can schedule a quality assessment exercise  to rectify identified red flags. A quality assessment helps in identifying  areas of concern at an early stage that if not rectified may hamper the success  of the project as well as the reputation of the organization. Will communicate  the quality audit as a routine firm-wide audit to the client. To address any  apprehensions/ concerns by the client, I will also highlight the advantages of  routine quality assessments as they help us to identify and address areas of  concern before it is too late to address them.</li>
                            <li>Understand the timeline of Phase  2 commencement. Inform the Quality Head that following activities are in early  stages of initiation as per project plan. Would suggest beginning process and  productivity improvement for these activities.
                        <ul>
                            <li>Concrete construction of Block B2</li>
                            <li>Fountain construction for Yoga and Meditation  Centre complex</li>
                        </ul>
                                <p>Ask for best practices on  upcoming scheduled activities such as MEP installation for Yoga and Meditation  Centre and road repair work. My team can provide our detailed project plan and  estimated manpower requirements for these activities based on which the team  can give us an optimized figure.</p>
                                <p>To ensure smooth implementation, I will deploy  my own team members to each of these 2 streams. They will act as point of  contact to ensure all required information is provided to external consultants  while also ensuring that routine  activities and on-ground manpower is not distracted or disturbed in this whole  process.</p>
                            </li>
                        </ol>
                        <p><strong>Sample Answer for Question 7</strong> - Below Average</p>
                        <p>I shall take the following steps in response to  the situation</p>
                        <ol>
                            <li>As the project is at a  crucial juncture and this step may cause further delay, I would request the  Quality Head to re-schedule the quality assessment for a later time when the  project has stabilized</li>
                            <li>Would suggest that as  workforce productivity and process improvement study is a time-taking exercise,  and by the time its findings are resolved, and action steps are implemented,  project PULSE will already be midway. Therefore, this project could be taken up  in a different project which has not yet commenced, as it will yield better  returns</li>
                            <li>If there are any best  practices that we can learn from other projects, we will be happy to  incorporate those to achieve higher productivity</li>
                        </ol>
                    </div>

                    <div id="ques-9">
                        <h4 class="meddle-title"><em>Question 9 - Appreciating Big  Picture</em></h4>
                        <p>You have an upcoming monthly  meeting with the Chairman of the Jupiter Super Specialty Hospital and you are  aware that ensuring the readiness of the Yoga and Meditation Centre and its  surrounding area is the responsibility of Cornerstone. It is extremely crucial  to the Chairman that the entire set-up for the Yoga &amp; Meditation Centre is  ready as it will be featured in newspapers and covered extensively by media on  the day of inauguration. You are also expecting the Project Manager of Design  Studio and Quality Team to be present in the meeting. What will be your  recommended approach to address the situation so that the impact of this delay  is minimized? Provide a detailed rationale for the same.</p>
                        <p><strong>Sample Answer for Question 9</strong> - Ideal</p>
                        <p>1. Prior to the meeting, I will take the  following actions</p>
                        <ul>
                            <li>Study the impact of delay on  other workstreams of the larger project
                            <ul>
                                <li>As per the project plan, any  delay in construction of Yoga and Meditation Center will impact the following  streams
                                    <ul>
                                        <li>Mechanical, electrical and  plumbing [MEP] installation that is to be done by CGC MEP stream</li>
                                        <li>Road repair work by CGC Stream 1</li>
                                    </ul>
                                </li>
                                <li>Both these streams cannot  commence their work until Design Studio has completed its construction</li>
                                <li>This delay shall also impact  the finishing activity on quality inspection, audit and inauguration, which is  a high-profile event in present scenario</li>
                                <li>If possible, I will push to  start the preparatory/ foundational work for both these streams in advance, to  catch up for the time lost. Will connect with CGC MEP stream and CGC Stream 1  Manager to identify such activities that can be completed in advance.</li>
                            </ul>
                                <li>Strengthen Project Management  by Design Studios 
  	                        <ul>
                                  <li>Allocate a resource from CGC  to monitor and track project management of Yoga and Meditation Center
  	                            <ul>
                                      <li>The full-time resource to  setup regular calls and meetings with Design Studio to ensure project is on  track and address any red flags. Suggest calibrating manpower plan to gradually  make up for the lost man-days</li>
                                  </ul>
                                  </li>
                              </ul>
                                </li>
                            <li>Manpower issue at Design  Studio
                        <ul>
                            <li>A total of 460 mandays  corresponds to a delay of approximately 11.5 days if the work is done by 40  resources.</li>
                            <li>Check with Design Studio if they have additional  resources that can be deployed to make up for this loss. If not, search other empaneled contractors whose manpower can be deployed for short term.</li>
                            <li>Jointly take this decision with Project Manager of Design Studio and other stakeholders present in the meeting</li>
                        </ul>
                            </li>
                        </ul>
                        <p>2. For the meeting with the Chairman, I will highlight the following discussion points</p>
                        <ul>
                            <li>Explain progress till date  and highlight the impact of delay</li>
                            <li>Describe  above stated action points taken in response to poor  project  management, manpower issues and delay in commencement of other workstreams</li>
                            <li>Empathize  with him to understand the outcomes of delay as it will  lead to  negative publicity of JGH despite multiple efforts going into it to make it a  world class facility</li>
                            <li>Reassure  the Chairman that the envisaged inauguration date shall  not be  impacted the issues have been identified at an early stage</li>
                        </ul>
                        <p><strong>Sample Answer for Question 9</strong> - Average</p>
                        <p>I will emphasize  on the following points during the meeting along with rationale</p>
                        <ul>
                            <li>The construction of Yoga and  Meditation Centre ultimately impacts the inauguration date that has been widely  publicized in the media as a big-ticket event. Hence it is most important to  complete this part of the project with priority. It also impacts other project  workstreams scheduled after completion of this milestone.</li>
                            <li>Design Studio to be held  accountable for all timeline escalations in future. Support to be provided by  CGC by deployment of SPOC for project management issues.</li>
                            <li>Manpower issue needs to be  taken care of by Design Studio to ensure timely completion and set quality  standards. Since it is recurring issue, the Project Manager at Design Studio  must prioritize timely completion of work without compromising on quality of  work. Loss of 200+ man-days per month is a big loss that needs to be recovered  by deploying additional manpower</li>
                            <li>Explain the scenario to the Chairman, Jupiter Super  Specialty Hospital and give him/ her a heads up on possible escalations and  preventive measures discussed in the meeting</li>
                        </ul>
                        <p><strong>Sample Answer for Question 9</strong> - Below Average</p>
                        <p>My recommended approach to  address the situation so that the impact of the delay is minimized</p>
                        <ol>
                            <li>Understand key problems areas  of the project and solve the issues one by one – The project was conceived as a  mark of respect to a revered public figure and hence, it transcends the purpose  of just a facility in the hospital. Therefore, it is important to complete the  project on time to reduce local uproar and reputational loss.</li>
                            <li>If another vendor needs to be  on board or Design Studio needs additional resources, the issue needs to be  resolved on immediate basis through collaborating with the Project Manager,  Design Studio.
                        <ul>
                            <li>Manpower issues need to be  resolved through support either internally or externally [Example; Support from  CGC, other vendors, contractual workers]</li>
                            <li>Search for another vendor  needs to be initiated in addition to Design Studio for faster execution.</li>
                        </ul>
                            </li>
                            <li>Explain the situation to the  Chairman, Jupiter Super Specialty Hospital and ask for some reasonable  extension in timeline for completion of construction of Yoga and Meditation  Center </li>
                        </ol>
                    </div>

                    <div id="ques-11">
                        <h4 class="meddle-title"><em>Question 11 - Change (learning)  Agility</em></h4>
                        <p>Arnav wants to schedule a meeting with you to discuss possible solutions for the theft case at Yoga & Meditation Centre. What will you recommend as a solution to Arnav and how will you ensure its implementation at the site?</p>
                        <p><strong>Sample Answer for Question 11</strong> - Ideal</p>
                        <p>As the PMO Head, I will  appreciate Arnav for highlighting this issue and suggesting measures based on  his experience. I will take the following actions to ensure both immediate and  long-term solution to this issue</p>
                        <p><strong>Immediate  measures</strong></p>
                        <ol>
                            <li>Develop/ redraft the SOP for  movement of material, assign primary and secondary owners for each stage of  movement</li>
                            <li>Attach a barcode panel on  each unit and use barcode scanners to track progress at each stage</li>
                            <li>Inform the contractors and  workers about the issue; mention that penalty will be charged if found guilty</li>
                            <li>Equip all entry and exit  points with biometric devices to de-risk cases of failure of the above plans</li>
                        </ol>
                        <p><strong>Long-term  measures</strong></p>
                        <ol>
                            <li>Further explore the root  cause of failure of smart wearables and drones. Undertake a cost-benefit  analysis to assess feasibility of implementation.</li>
                            <li>Explore other ideas such as  geotagging of each unit to track movement in real time and identify immediately  if any discrepancy is observed in its pre-defined route</li>
                            <li>As the end users of each of  these technologies is the workers, conduct a workshop for them and their  contractors prior to implementation, make them understand its usage and intent.  Position the initiatives as &lsquo;Digitalization of workforce on site&rsquo;.</li>
                            <li>Schedule a meeting with the client to highlight  the issues. Recommend usage of alternative methods to ensure safety and  security on-site given the long timeline of the project. Provide pros and cons  associated with each solution to help them assess the most effective option </li>
                        </ol>
                        <p><strong>Sample Answer for Question 11</strong> - Average</p>
                        <p>I will take the following actions</p>
                        <ol>
                            <li>Empathize with Arnav and  appreciate his effort in bringing up the issue faced at site intended towards  the improvement of site operations. Also appreciate his contribution to bring  relevant ideas to the table to address the issue.</li>
                            <li>Jointly explore case studies  and live examples of similar cases where smart wearables and drones have been  implemented. Identify causes of failure and measures that be taken to drive  successful implementation. In cases where such technologies have sustained,  identify critical success factors and create a business case.</li>
                            <li>Meanwhile, to ensure such  cases do not go unreported and unidentified, attach a bar-code to each unit of  material that can be scanned at all stages of movement through a barcode  scanner. As this may also lead to extra effort by manpower, ask Arnav to  explore other means to track movement of material.</li>
                            <li>Sensitize the client towards  identified issue. Explain the reasons of failure of CCTV cameras and list out  pros and cons of using other identified solutions; work on the implementation  of solution as recommended by client</li>
                        </ol>
                        <p><strong>Sample Answer for Question 11</strong> - Below Average</p>
                        <p>I will take the following actions</p>
                        <ol>
                            <li>Ask Arnav for the locations  where CCTV is currently placed and identify other feasible locations for its  placement to ensure full coverage and identification of theft.</li>
                            <li>I will take strict measures  to ensure that all the material coming in the construction premises is tracked  at all stages.</li>
                            <li>To avoid the situation of any  manual error in the tracking process, I will also look at enabling &lsquo;geotagging&rsquo;  technology for high-value material as this will help in identifying the exact  location of material at all times. Using geotagging, one can locate the  material and extract cases of mishandling.</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="dvGInstructions" style="display: none;" title="Instructions">
        <p>As a Developer for DC-1, you are required to follow the below steps:</p>
        <ol>
            <li>Go to participant exercise status and view the progress of participants mapped to you</li>
            <li>Based on case study completion status, initiate scheduling of the participant BEI by clicking on &quot;Manage Scheduling&quot;</li>
            <li>Immediately post scheduling, navigate to paticipant rating to commence rating of case study responses</li>
            <li>Ensure completion of case study evaluation prior to beginning BEI</li>
            <li>Navigate to Participant Rating to initiate BEI and complete rating</li>
        </ol>
        <ol>
            <li>Go to participant exercise status and view the progress of participants mapped to you</li>
            <li>Based on case study completion status, initiate scheduling of the participant BEI by clicking on &quot;Manage Scheduling&quot;</li>
            <li>Immediately post scheduling, navigate to paticipant rating to commence rating of case study responses</li>
            <li>Ensure completion of case study evaluation prior to beginning BEI</li>
            <li>Navigate to Participant Rating to initiate BEI and complete rating</li>
        </ol>
        <ol>
            <li>Go to participant exercise status and view the progress of participants mapped to you</li>
            <li>Based on case study completion status, initiate scheduling of the participant BEI by clicking on &quot;Manage Scheduling&quot;</li>
            <li>Immediately post scheduling, navigate to paticipant rating to commence rating of case study responses</li>
            <li>Ensure completion of case study evaluation prior to beginning BEI</li>
            <li>Navigate to Participant Rating to initiate BEI and complete rating</li>
        </ol>
        <ol>
            <li>Go to participant exercise status and view the progress of participants mapped to you</li>
            <li>Based on case study completion status, initiate scheduling of the participant BEI by clicking on &quot;Manage Scheduling&quot;</li>
            <li>Immediately post scheduling, navigate to paticipant rating to commence rating of case study responses</li>
            <li>Ensure completion of case study evaluation prior to beginning BEI</li>
            <li>Navigate to Participant Rating to initiate BEI and complete rating</li>
        </ol>
        <ol>
            <li>Go to participant exercise status and view the progress of participants mapped to you</li>
            <li>Based on case study completion status, initiate scheduling of the participant BEI by clicking on &quot;Manage Scheduling&quot;</li>
            <li>Immediately post scheduling, navigate to paticipant rating to commence rating of case study responses</li>
            <li>Ensure completion of case study evaluation prior to beginning BEI</li>
            <li>Navigate to Participant Rating to initiate BEI and complete rating</li>
        </ol>
        <ol>
            <li>Go to participant exercise status and view the progress of participants mapped to you</li>
            <li>Based on case study completion status, initiate scheduling of the participant BEI by clicking on &quot;Manage Scheduling&quot;</li>
            <li>Immediately post scheduling, navigate to paticipant rating to commence rating of case study responses</li>
            <li>Ensure completion of case study evaluation prior to beginning BEI</li>
            <li>Navigate to Participant Rating to initiate BEI and complete rating</li>
        </ol>
    </div>

</asp:Content>

