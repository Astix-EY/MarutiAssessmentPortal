<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="BriefOnYourRole.aspx.vb" Inherits="Data_Information_BriefOnYourRole" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="">
        area {
            display: inline;
            outline: 0;
            border: 0;
        }
    </style>
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>

    <script type="text/javascript">
        (function ($) {
            $.fn.blink = function (options) {
                var defaults = {
                    delay: 500
                };
                var options = $.extend(defaults, options);
                var obj = $(this);
                setInterval(function () {
                    $(obj).fadeOut().fadeIn();
                }, options.delay);
            }

        }(jQuery));

        function fnExample() {
            var ToolID = document.getElementById("ConatntMatterRight_hdnToolID").value;
            //window.location.href = "TaskExample.aspx?MenuId=8";
            // window.location.href = "../Exercise/ExerciseMain.aspx?MenuId=" + MaxInd;
            window.location.href = "../Exercise/ExerciseMain.aspx?MenuId=8&ToolID=" + ToolID;
        }

        function fnRole() {
            $('#role').hide();
            $('#structure').fadeIn(200);
        }
        function fnStructure() {
            $('#structure').hide();
            $('#role').fadeIn(200);
        }

        //function openPopup(el) {
        //    if ($('#' + el).attr("flg") == "1") {
        //        $('.modal').hide();
        //        $('#' + el).fadeIn(200);

        //        if (el == "div1") {
        //            $("#hdnDiv1").val(1);
        //        }
        //        else if (el == "div2") {
        //            $("#hdnDiv1").val(2);
        //        }
        //        else if (el == "div3") {
        //            $("#hdnDiv1").val(3);
        //        }
        //    }
        //    else {
        //        alert("Please, Watch the Instruction in Order !");
        //    }
        //}

      
    </script>
    <script type="text/javascript">
        //----- English -------------------------
        function fnEnglish(flg) {
            var ids = "";
            if (flg == 1) {
                ids = "AugngM-cont";
            }
            else if (flg == 2) {
                ids = "KhalisT-cont";
            }
            else if (flg == 3) {
                ids = "AmarM-cont";
            }
            else if (flg == 4) {
                ids = "AishahR-cont";
            }
            else if (flg == 5) {
                ids = "AmitSharma-cont";
            }
            else if (flg == 6) {
                ids = "ZahilHasan-cont";
            }
            $("#" + ids).dialog({
                title: "",
                width: "45%",
                modal: true,
                draggable: false,
                resizable: false,
            });
        }

    </script>

  

    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        f1();
        function f1() {
            $(document).ready(function () {
                //function FnUpdateTimer() {
                if (IsUpdateTimer == 0) { return; }
                SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
                if (SecondCounter <= 0) {
                    IsUpdateTimer = 0;

                    //$("#theTime").addClass("blinkmsg");

                    //$('.blinkmsg').blink({
                    //    delay: "1500"
                    //});

                    return;
                }
                SecondCounter = SecondCounter - 1;
                hours = Math.floor(SecondCounter / 3600);
                Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
                Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);


                if (Seconds < 10 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds < 10 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds > 9 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + Seconds;
                }
                else if (Seconds > 9 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + Minutes + ":" + Seconds;
                }
                document.getElementById("ConatntMatterRight_hdnCounter").value = SecondCounter;

                if (((hours * 60) + Minutes) == 5 && Seconds == 0) {

                    $("#dvDialog")[0].innerHTML = "<center>Your time left to read background information : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " </center>";
                    $("#dvDialog").dialog({
                        title: 'Alert',
                        modal: true,
                        width: '30%',
                        buttons: [{
                            text: "OK",
                            click: function () {
                                $("#dvDialog").dialog("close");
                            }
                        }]
                    });

                    //   document.getElementById("dvDialog").innerHTML = "<center>Your Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " After that your window will be closed automatically.</center>";
                }

                counter++;
                counterAutoSaveTxt++;
                if (counter == 10) {//Auto Time Update
                    counter = 0;

                }
                if (counterAutoSaveTxt == 30) {//Auto Text Save
                    counterAutoSaveTxt = 0;

                }

                if (SecondCounter == 0) {
                    // alert("Level Complete");
                    IsUpdateTimer = 0;
                    counter = 0;


                    $("#theTime").addClass("blinkmsg");

                    $('.blinkmsg').blink({
                        delay: "1500"
                    });
                    alert("Your scheduled time for reading the background information is over. You will now be redirected to your tasks page. Please start Task 1.");
                    if ($("#hdnAssmntType").val() == "1") {
                        window.location.href = "../Exercise/ExerciseMain_L4.aspx?MenuId=8";
                    }
                    else {
                        window.location.href = "../Exercise/ExerciseMain_L3.aspx?MenuId=8";
                    }
                    return;
                }
                // }
                setTimeout("f1()", 1000);


            });

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime" class="fst-color" style="display: none">Reading Time Left
        00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <div class="coll-body" id="role">
        <div class="section-title">
            <h3 class="text-center" id="HdngBrief">Strategic Landscape and Future Growth</h3>
            <div class="title-line-center"></div>
        </div>
        <!-------   English  ------>
        <div id="dvEnglish">

            <p><strong>Sales &amp; Operations</strong></p>
            <p>AutoNext operates through a national network across North, South, East, and West regions, with over 3,000 touchpoints. While the company has strong rural and semi-urban penetration, its urban reach is comparatively weaker. AutoNext also faces challenges in its aftermarket services, with customers frequently opting for lower-quality spare parts alternatives. Strengthening aftermarket services and building customer trust in the quality of spare parts remains a key priority for maintaining competitiveness.</p>
            <p><strong>Customer Connect</strong></p>
            <p>Despite efforts by sales and marketing teams to engage with dealers and customers, AutoNext lacks a unified system for managing customer feedback and product complaints. Competitors such as Zenith Automobiles have introduced integrated customer portals that consolidate feedback, setting a new industry standard. AutoNext is now planning to launch a customer portal to manage lifecycle interactions, complaints, and feedback, while also feeding this data back to its R&amp;D teams to inform product development.</p>
            <p><strong>Production &amp; Supply Chain</strong></p>
            <p>AutoNext operates a decentralized procurement system, working with over 200 suppliers. However, as demand for passenger cars has recovered post FY 21-22, the company faces capacity constraints, reduced liquidity and high inventory holding costs especially during peak seasons. Similar to the industry, AutoNext could benefit from vendor consolidation and centralized procurement to optimize costs and improve supply chain efficiency. In addition, transitioning to BS-VII emission norms by 2025 presents significant challenges, particularly for smaller domestic suppliers.</p>
            <p><strong>New Technology Infrastructure</strong></p>
            <p>India&rsquo;s EV infrastructure remains a significant challenge, with limited availability of charging stations and power supply in remote areas. While AutoNext leads industry with its total market share, its presence in the EV segment remains minimal at 10%. In terms of expanding its EV portfolio, AutoNext has been relatively slow to react to market demands. AutoNext, like other players, is seeking partnerships to address these gaps, but the investment required is considerable and subject to fluctuating government regulations. The company is exploring collaboration with technology providers to co-develop EV charging infrastructure, which will be essential for expanding its EV portfolio. AutoNext&rsquo;s leadership has gradually been indicating a shift in focus towards electric vehicles and has announced plans to launch its first mass-market EV by 2025.</p>
            <p><strong>Research and Development</strong></p>
            <p>While AutoNext&rsquo;s R&amp;D budget is INR 3,000 crore (3% of revenue), it is considerably lower than competitors (Vega ~5% and Zenith ~5.8%). Increase in R&amp;D expenditure has been earmarked for developing electric powertrains and building proprietary technology in-house to incorporate modern features and appeal to tech-savvy customers. Future growth will likely hinge on how well AutoNext manages to balance its legacy ICE operations with the burgeoning demand for electric and technologically advanced vehicles.</p>
            <p><strong>Technology</strong></p>
            <p>AutoNext, known for its innovation in affordability and efficiency, is now focusing on integrating advanced technologies such as riding assist systems and AI-driven safety features. However, these innovations have led to higher operating costs, making it difficult to maintain competitive margins in India&rsquo;s price-sensitive market. Balancing technological advancements with operational efficiency will be critical to sustaining profitability in this evolving industry.</p>
            <p><strong>Key Partnerships</strong></p>
            <p>AutoNext has the potential opportunity to act as an original equipment manufacturer (OEM) for a Japanese automotive firm, which would allow it to expand into markets like Japan and Costa Rica. However, this opportunity comes with significant hurdles, including meeting rigorous safety standards, emission regulations, and enhancing electrification capabilities to enter these markets successfully.</p>
            <p>At the same time, AutoNext&rsquo;s management has emphasized the need for cost-saving measures, including localizing supply chains and reducing reliance on imported raw materials to achieve operational efficiencies.</p>
        </div>
        <!------- End  English  ------>

   

        <div class="text-center mt-3 mb-3">
            <%--<a href="#" onclick="fnRole()" class="btns btn-submit" id="AnchorNext1"></a>--%>
            <div class="text-center mb-3" id="btnNext"><a href="#" onclick="fnMenu(6, this)" id="btnAnchorNext" class="btns btn-submit">Next</a></div>
            <%--<div class="text-center mb-3"><a href="#" onclick="fnExample()" class="btns btn-submit">Next</a></div>--%>
        </div>
    </div>

    <div class="coll-body" id="structure" style="display: none">
        <div class="section-title">
            <h3 class="text-center" id="HdngSales"></h3>
            <div class="title-line-center"></div>
        </div>

        <!-------   English  ------>
        <div class="text-center" id="EngSalesOrg">
            <img src="../../Images/L4-direct-org-eng.JPG" usemap="#MapENG" style="width: 790px !important">
            <map name="MapENG" id="MapENG">
                <area shape="rect" coords="541,257,621,281" href="#" alt="AugngKhan" onclick="fnEnglish(1)">
                <area shape="rect" coords="667,255,760,281" href="#" alt="KhalisRahman" onclick="fnEnglish(2)">
                <area shape="rect" coords="404,256,493,282" href="#" alt="AmarHossain" onclick="fnEnglish(3)">
                <area shape="rect" coords="546,331,641,357" href="#" alt="AishahAhmed" onclick="fnEnglish(4)">
                <area shape="rect" coords="64,249,150,278" href="#" alt="AmitSharma" onclick="fnEnglish(5)">
                <area shape="rect" coords="158,174,245,202" href="#" alt="ZelihaHasan" onclick="fnEnglish(6)">
            </map>
            <%--<map name="MapENG" id="MapENG">
              <area shape="rect" coords="620,178,675,194" href="#" alt="AugngKhan" onclick="fnEnglish(1)">
              <area shape="rect" coords="706,178,772,194" href="#" alt="KhalisRahman" onclick="fnEnglish(2)">
              <area shape="rect" coords="523,178,588,195" href="#" alt="AmarHossain" onclick="fnEnglish(3)">
              <area shape="rect" coords="622,230,687,246" href="#" alt="AishahAhmed" onclick="fnEnglish(4)">
              <area shape="rect" coords="280,173,340,191" href="#" alt="AmitSharma" onclick="fnEnglish(5)">
              <area shape="rect" coords="347,121,404,140" href="#" alt="ZelihaHasan" onclick="fnEnglish(6)">
            </map>--%>
        </div>

        <!-------   Indonesia  ------>
        <div class="text-center" id="IndonesiaSalesOrg" style="display: none">
            <img src="../../Images/L4-direct-org-indonesian.JPG" class="img-thumbnail" usemap="#Map-IDN" style="width: 790px !important" />
            <%-- <map name="Map-IDN" id="Map-IDN">
                <area shape="rect" coords="593,223,648,242" href="#" alt="AugngM" id="AugngM-idn" onclick="fnIndonesia(1)">
                <area shape="rect" coords="709,223,755,242" href="#" alt="KhalisT" id="KhalisT-idn" onclick="fnIndonesia(2)">
                <area shape="rect" coords="483,224,533,243" href="#" alt="AmarM" id="AmarM-idn" onclick="fnIndonesia(3)">
                <area shape="rect" coords="593,284,646,304" href="#" alt="AishahR" id="AishahR-idn" onclick="fnIndonesia(4)">
                <area shape="rect" coords="205,202,274,224" href="#" alt="AmitSharma" id="AmitSharma-idn" onclick="fnIndonesia(5)">
                <area shape="rect" coords="284,138,352,159" href="#" alt="ZahilHasan" id="ZahilHasan-idn" onclick="fnIndonesia(6)">
            </map>--%>
            <map name="Map-IDN" id="Map-IDN">
                <area shape="rect" coords="543,258,621,285" href="#" alt="AugngKhan" id="AugngKhan-idn" onclick="fnIndonesia(1)" />
                <area shape="rect" coords="670,266,763,293" href="#" alt="KhalisRahman" id="KhalisRahman-idn" onclick="fnIndonesia(2)" />
                <area shape="rect" coords="405,258,493,287" href="#" alt="AmarHossain" id="AmarHossain-idn" onclick="fnIndonesia(3)" />
                <area shape="rect" coords="546,333,642,362" href="#" alt="AishahAhmed" id="AishahAhmed-idn" onclick="fnIndonesia(4)" />
                <area shape="rect" coords="59,252,145,278" href="#" alt="AmitSharma" id="AmitSharma-idn" onclick="fnIndonesia(5)" />
                <area shape="rect" coords="157,176,240,203" href="#" alt="ZelihaHasan" id="ZelihaHasan-idn" onclick="fnIndonesia(6)" />
            </map>
        </div>

        <!-------   Sinhala  ------>
        <div class="text-center" id="SinhalaSalesOrg" style="display: none">
            <img src="../../Images/L4-direct-org-sinhala.JPG" class="img-thumbnail" usemap="#Map-SHL" style="width: 790px !important" />
            <%--   <map name="Map-Sinhala" id="Map-Sinhala">
                <area shape="rect" coords="584,216,673,246" href="#" alt="AugngM" id="AugngM-sinhala" onclick="fnSinhala(1)" />
                <area shape="rect" coords="688,229,780,249" href="#" alt="KhalisT" id="KhalisT-sinhala" onclick="fnSinhala(2)" />
                <area shape="rect" coords="498,214,554,241" href="#" alt="AmarM" id="AmarM-sinhala" onclick="fnSinhala(3)" />
                <area shape="rect" coords="593,286,690,304" href="#" alt="AishahR" id="AishahR-sinhala" onclick="fnSinhala(4)" />
                <area shape="rect" coords="216,203,296,230" href="#" alt="AmitSharma" id="AmitSharma-sinhala" onclick="fnSinhala(5)" />
                <area shape="rect" coords="292,129,359,156" href="#" alt="ZahilHasan" id="ZahilHasan-sinhala" onclick="fnSinhala(6)" />
            </map>--%>
            <map name="Map-SHL" id="Map-SHL">
                <area shape="rect" coords="542,258,623,285" href="#" alt="AugngKhan" id="AugngKhan-shl" onclick="fnSinhala(1)" />
                <area shape="rect" coords="670,258,762,284" href="#" alt="KhalisRahman" id="KhalisRahman-shl" onclick="fnSinhala(2)" />
                <area shape="rect" coords="409,268,488,293" href="#" alt="AmarHossain" id="AmarHossain-shl" onclick="fnSinhala(3)" />
                <area shape="rect" coords="554,340,634,368" href="#" alt="AishahAhmed" id="AishahAhmed-shl" onclick="fnSinhala(4)" />
                <area shape="rect" coords="65,253,141,279" href="#" alt="AmitSharma" id="AmitSharma-shl" onclick="fnSinhala(5)" />
                <area shape="rect" coords="157,183,242,212" href="#" alt="ZelihaHasan" id="ZelihaHasan-shl" onclick="fnSinhala(6)" />
            </map>
        </div>

        <!-------   Tamil  ------>
        <div class="text-center" id="TamilSalesOrg" style="display: none">
            <img src="../../Images/L4-direct-org-tamil.JPG" class="img-thumbnail" usemap="#Map-Tamil" style="width: 790px !important" />
            <map name="Map-Tamil" id="Map-Tamil">
                <area shape="rect" coords="548,262,623,286" href="#" alt="AugngKhan" onclick="fnTamil(1)">
                <area shape="rect" coords="678,253,753,288" href="#" alt="KhalisRahman" onclick="fnTamil(2)">
                <area shape="rect" coords="406,258,492,293" href="#" alt="AmarHossain" onclick="fnTamil(3)">
                <area shape="rect" coords="540,339,648,367" href="#" alt="AishahAhmed" onclick="fnTamil(4)">
                <area shape="rect" coords="60,250,145,277" href="#" alt="AmitSharma" onclick="fnTamil(5)">
                <area shape="rect" coords="162,171,235,208" href="#" alt="ZelihaHasan" onclick="fnTamil(6)">
            </map>
        </div>

        <p class="text-center font-weight-bold mt-2 mb-0" id="paraClickText"><b>*Click over the icon to know more about the individual</b></p>

        <div class="text-center mt-3 mb-3">
            <a href="#" onclick="fnStructure()" class="btns btn-submit" id="AnchorBack"></a>
            <a href="#" onclick="fnMenu(6, this)" class="btns btn-submit" id="AnchorNext2"></a>
        </div>
    </div>

    <!-------   English  ------>
    <div id="eng-popup">
        <div id="AugngM-cont" style="display: none">
            <p class="font-weight-bold">
                Augng Khan<br>
                Lead - Managed Services<br>
                Age – 33 years; Experience – 8 years; GTC experience – 7 years
            </p>
            <p>Augng has, since the beginning of his career, worked with Multi National Organizations, and made significant contribution in the Managed Services domain. Augng has consistently been a good performer and demonstrated strong domain and market knowledge. His role within GTC evolved from Technical Solution Design to Project Management over the years. His articulation skills enable him to engage and inspire his stakeholders easily. He is self motivated and appreciates an environment of empowerment and little micromanagement from the top. This helps him build ownership of the task at hand. He has one team member reporting into him – Aishah.</p>
        </div>
        <div id="KhalisT-cont" style="display: none">
            <p class="font-weight-bold">
                Khalis Rahman<br>
                Lead – Program Management<br>
                Age – 31 years; Experience – 7 years; GTC experience – 7 years
            </p>
            <p>Khalis started his career with GTC and has been instrumental in driving some key partnerships. He is a result oriented individual and works well in teams and is able to ensure project timelines are not compromised. He has a strong network both within and outside the organization that he leverages to bring in relevant expertise and insights. He, however, is particular about not compromising on his work life balance and does not appreciate working till late hours in the office.</p>
        </div>
        <div id="AmarM-cont" style="display: none">
            <p class="font-weight-bold">
                Amar Hossain<br>
                Lead – Solution Architect<br>
                Age – 31 years; Experience – 7 years; GTC experience – 6 years
            </p>
            <p>Amar has expertise in creating IT solution architecture to best suit the client needs. He has worked on diverse projects across different sectors and leveraged his strong IT background. He is often consulted on technology implementation during projects due to his competence in the area. As a result, he is invariably stretched and struggling to complete work within the defined timelines. Thus, he is always reluctant to pick up new work as it would mean having to deal with conflicting priorities. In order to align him, a conversation with his manager is often required.</p>
        </div>
        <div id="AishahR-cont" style="display: none">
            <p class="font-weight-bold">
                Aishah Ahmed<br>
                Solution Architect<br>
                Age – 29 years; Experience – 6 years; GTC experience – 3 years
            </p>
            <p>Aishah is an eager team player and brings with her a good knowledge of telecom sector. She reports into Augng and assists him in technology solutioning during implementation of Managed Services model. She has good domain knowledge and is result driven. She is dependable and demonstrates good stakeholder management skills.</p>
        </div>
        <div id="AmitSharma-cont" style="display: none">
            <p class="font-weight-bold">
                Amit Sharma<br>
                Regional Manager<br>
                Age – 38 years; Experience – 15 years; GTC experience – 10 years
            </p>
            <p>Amit has worked with SME clients in the industry. He has been managing small teams and has great track record in the clients space. He has spent a decade with GTC and has over the years developed an expertise in market. He has excellent stakeholder and client management skills. He is, however, the most difficult to get a hold off due to his busy schedule.</p>
        </div>
        <div id="ZahilHasan-cont" style="display: none">
            <p class="font-weight-bold">
                Zeliha Hasan<br>
                VP – Small-Medium Enterprises<br>
                Age – 40 years; Experience – 17 years; GTC experience – 9 years
            </p>
            <p>Zeliha is an invaluable member of the Leadership Team at GTC and has significantly contributed to the success of the company by forging strong relationships with new and old clients. Her progression in the company has always been fast tracked due to her exemplary performance. She is looked up to as a great leader in the company, who is able to easily engage and inspire others by creating a strong vision.</p>
        </div>
    </div>

    <!-------   Indonesia  ------>
    <div id="idn-popup">
        <div id="AugngM-idn-cont" style="display: none">
            <p class="font-weight-bold">
                Augng M<br />
                Senior Manager – ICT Managed Services
                <br />
                Usia – 33 tahun; Pengalaman kerja – 8 tahun; Pengalaman di GTC – 7 tahun
            </p>
            <p>Augng sejak awal karirnya bekerja dengan Organisasi Multi Nasional dan memberikan kontribusi yang signifikan dalam bidang Layanan Pengelolaan Lengkap (Managed Services). Augng secara konsisten menunjukkan performa yang baik serta Keahlian akan bidang tersebut dan pengetahuan mendalam atas pasar. Perannya di GTC berkembang mulai dari Technical Solution Design ke Manajemen Proyek selama bertahun-tahun. Keterampilan dalam hal artikulasi mendukungnya untuk melakukan stakeholder engagement dan menginspirasikan mereka dengan mudah. Ia memiliki motivasi diri dan menghargai lingkungan yang memiliki pemberdayaan (empowerment) serta sedikit micromanagement dari atasannya. Hal tersebut membantunya dalam membangun rasa kepemilikan atas tugas yang dimilikinya. Ia memiliki satu anggota tim yang melapor kepadanya - Aishah. </p>
        </div>
        <div id="KhalisT-idn-cont" style="display: none">
            <p class="font-weight-bold">
                Khalis T<br />
                Senior Manager – Partner Mgmt. & Operations<br />
                Usia – 31 tahun; Pengalaman kerja – 7 tahun; Pengalaman di GTC – 7 tahun
            </p>
            <p>Khalis memulai karirnya di GTC dan telah berperan penting dalam mendorong beberapa kemitraan utama. Ia adalah individu yang berorientasi pada hasil dan bekerja dengan baik dalam tim serta mampu memastikan jadwal proyek tidak terganggu. Ia memiliki jejaring yang kuat baik di dalam maupun di luar organisasi, yang ia manfaatkan untuk mendapatkan keahlian serta wawasan yang relevan. Bagaimanapun, ia tidak berkompromi khususnya mengenai work life balance dan tidak menyukai bekerja hingga larut malam di kantor.</p>
        </div>
        <div id="AmarM-idn-cont" style="display: none">
            <p class="font-weight-bold">
                Amar M<br />
                Senior Manager – Solution Architect<br />
                Usia – 31 tahun; Pengalaman kerja – 7 tahun; Pengalaman di GTC – 6 tahun
            </p>
            <p>Amar memiliki keahlian dalam menciptakan solusi Arsitektur TI yang paling sesuai dengan kebutuhan klien. Ia telah bekerja di berbagai proyek di berbagai sektor dan menggunakan pengetahuan IT-nya yang dalam. Ia sering memberikan konsultasi mengenai implementasi teknologi selama proyek karena kompetensinya di bidang tersebut. Oleh karena itu, ia selalu kesulitan untuk menyelesaikan pekerjaan dalam jangka waktu yang ditentukan. Ia selalu enggan mengambil pekerjaan baru dikarenakan membuatnya harus mengatur kembali prioritasnya. Untuk menyelaraskannya, percakapan dengan manajernya sering dibutuhkan.</p>
        </div>
        <div id="AishahR-idn-cont" style="display: none">
            <p class="font-weight-bold">
                Aishah R<br />
                Manager – Technical Solution<br />
                Usia – 29 tahun; Pengalaman kerja – 6 tahun; Pengalaman di GTC – 3 tahun

            </p>
            <p>Aishah adalah anggota tim yang memiliki motivasi dan pengetahuan yang baik tentang sektor telekomunikasi. Ia melapor kepada Augng dan membantunya dalam menyelesaikan masalah teknologi pada saat implementasi model Layanan Pengelolaan Lengkap (Managed Services). Ia memiliki pengetahuan yang baik atas bidang ini dan berorientasi pada hasil. Ia dapat diandalkan dan menunjukkan kemampuan manajemen stakeholder yang baik.  </p>
        </div>
        <div id="AmitSharma-idn-cont" style="display: none">
            <p class="font-weight-bold">
                Amit Sharma<br />
                Key Account Manager – Connectivity Products
                <br />
                Usia – 38 tahun; Pengalaman kerja – 15 tahun; Pengalaman di GTC – 10 tahun
            </p>
            <p>Amit telah bekerja dengan klien-klien telekomunikasi besar. Ia telah mengelola tim dalam jumlah besar dan memiliki rekam jejak baik di lingkungan klien. Ia telah menghabiskan satu dekade bersama GTC dan selama bertahun-tahun ia mengembangkan keahliannya terkait pasar. Ia memiliki keterampilan manajemen klien dan stakeholder yang sangat baik. Namun, ia adalah orang yang paling susah dijangkau dikarenakan ia memiliki jadwal yang padat.</p>
        </div>
        <div id="ZahilHasan-idn-cont" style="display: none">
            <p class="font-weight-bold">
                Zeliha Hasan<br />
                VP – Large Enterprises<br />
                Usia – 40 tahun; Pengalaman kerja – 17 tahun; Pengalaman di GTC – 9 tahun
            </p>
            <p>Zeliha adalah anggota Tim Kepemimpinan di GTC yang sangat berharga dan telah memberikan kontribusi yang signifikan terhadap keberhasilan perusahaan dalam menjalin hubungan yang kuat dengan klien baru dan lama. Kemajuannya di perusahaan selalu bersifat cepat karena kinerjanya yang patut dicontoh. Ia dipandang sebagai pemimpin hebat di perusahaan, seseorang yang mampu dengan mudah mengikutsertakan dan menginspirasi orang lain dengan menciptakan visi yang kuat.</p>
        </div>
    </div>

    <!-------   Sinhala  ------>
    <div id="sinhala-popup">
        <div id="AugngM-sin-cont" style="display: none">
            <p class="font-weight-bold">
                ඔග්න් ඛාන් (Augng Khan)<br>
                නායක- කළමනාකරණ සේවා<br>
                වයස - අවුරුදු 33; පළපුරුද්ද - අවුරුදු 8; GTC පළපුරුද්ද - අවුරුදු 7 යි
            </p>
            <p>ඔග්න්ග් සිය වෘත්තීය දිවියේ ආරම්භයේ සිටම බහු ජාතික සංවිධාන සමඟ කටයුතු කර ඇති අතර කළමනාකරණ සේවා වසමේ සැලකිය යුතු දායකත්වයක් ලබා දී ඇත. ඔග්න්ග් නිරන්තරයෙන් හොඳ ශිල්පියෙකු වන අතර ශක්තිමත් වසම සහ වෙළඳපොළ දැනුම පෙන්නුම් කරයි. GTC ආයතනය තුළ ඔහුගේ කාර්යභාරය තාක්ෂණික විසඳුම් නිර්මාණයේ සිට ව්‍යාපෘති කළමනාකරණය දක්වා වසර ගණනාවක් පුරා විකාශනය විය. ඔහුගේ කථන කුසලතා [articulation skills] නිසා පාර්ශවකරුවන් සමග පහසුවෙන් සම්බන්ධ වීමට හා ආස්වාදයක් ලබා දිමට හැකිය. ඔහු ස්වයං අභිප්‍රේරණයකින් යුක්ත වන අතර ඉහළ සිට බලගැන්වීමේ හා සුළු ක්ෂුද්‍ර කළමනාකරණ පරිසරයක් අගය කරයි. කර්තව්‍යයේ හිමිකාරිත්වය ගොඩනැගීමට මෙය ඔහුට උපකාරී වේ. ඔහුට එක් කණ්ඩායම් සාමාජිකයෙක් වාර්තා කරයි - අයිෂා.</p>

        </div>
        <div id="KhalisT-sin-cont" style="display: none">
            <p class="font-weight-bold">
                කලිස් රහ්මාන් (Khalis Rahman)<br>
                නායක - වැඩසටහන් කළමනාකරණය<br>
                වයස - අවුරුදු 31; පළපුරුද්ද - අවුරුදු 7; GTC පළපුරුද්ද - අවුරුදු 7 යි
            </p>
            <p>කලීස් සිය වෘත්තීය ජීවිතය GTC ආයතනය සමඟ ආරම්භ කළ අතර ප්‍රධාන හවුල්කාරිත්වයන් කිහිපයක් මෙහෙයවීමට ඉවහල් විය. ඔහු ප්‍රතිඵල මත පදනම් වූ පුද්ගලයෙක් වන අතර කණ්ඩායම් වශයෙන් හොඳින් ක්‍රියා කරන අතර ව්‍යාපෘති කාල නියමයන් නොසලකා හරිනු නොලැබේ. අදාළ විශේෂඥතාව සහ තීක්ෂ්ණ බුද්ධිය ගෙන ඒම සඳහා ඔහුට උපකාරි වන ශක්තිමත් ජාලයක් සංවිධානය තුළත් ඉන් පිටතත් ඔහු සතුව ඇත. කෙසේ වෙතත්, ඔහු විශේෂයෙන් සිය සේවා ජීවන සමතුලිතතාවයට පටහැනි නොවීම ගැන විශේෂයෙන් සඳහන් කරන අතර කාර්යාලයේ ප්‍රමාද වන තෙක් වැඩ කිරීම අගය නොකරයි</p>
        </div>
        <div id="AmarM-sin-cont" style="display: none">
            <p class="font-weight-bold">
                අමර් හුසේන් (Amar Hossain)<br>
                නායක - විසඳුම් ගෘහ නිර්මාණ ශිල්පියා<br>
                වයස - අවුරුදු 31; පළපුරුද්ද - අවුරුදු 7; GTC පළපුරුද්ද - අවුරුදු 6 යි
            </p>
            <p>සේවාදායකයාගේ අවශ්‍යතාවන්ට සරිලන පරිදි තොරතුරු තාක්‍ෂණ විසඳුම් නිර්මාණය කිරීම සඳහා අමර්ට විශේෂඥතා දැනුමක් ඇත. ඔහු විවිධ අංශයන්හි විවිධ ව්‍යාපෘතිවල වැඩ කර ඇති අතර එයට ඔහුගේ ශක්තිමත් තොරතුරු තාක්ෂණ පසුබිම ඔහුට උපකාරි විය. තාක්ෂණ සේවා අංශයේ ඇති නිපුණතාවය හේතුවෙන් ව්‍යාපෘති වලදී තාක්‍ෂණය ක්‍රියාත්මක කිරීම පිළිබඳව ඔහුගෙන් බොහෝ විට උපදෙස් ලබා ගනී. එහි ප්‍රතිඵලයක් වශයෙන් ඔහු නිරන්තරයෙන් නියමිත කාල සීමාවන් තුළ වැඩ නිම කිරීමට නිරන්තර අරගලයක යෙදේ. මේ අනුව, ගැටුම්කාරී ප්‍රමුඛතා සමඟ කටයුතු කිරීමට සිදුවන බැවින් නව කාර්යය තෝරා ගැනීමට ඔහු සැමවිටම මැලි වේ. ඔහුව පෙළගැස්වීම සඳහා, ඔහුගේ කළමනාකරු සමඟ සංවාදයක් බොහෝ විට අවශ්‍ය වේ.</p>
        </div>
        <div id="AishahR-sin-cont" style="display: none">
            <p class="font-weight-bold">
                අයිෂා අහමඩ් (Aishah Ahmed)<br>
                විසඳුම් ගෘහ නිර්මාණ ශිල්පියා<br>
                වයස - අවුරුදු 29; පළපුරුද්ද - අවුරුදු 6; GTC පළපුරුද්ද - අවුරුදු 3 යි
            </p>
            <p>අයිෂා ටෙලිකොම් අංශය පිළිබඳ හොඳ දැනුමක් ඇති ඉතා උනන්දු කණ්ඩායම් සාමාජිකාවකි. ඇය ඔග්න්ග් වෙත වාර්තා කරන අතර කළමනාකරණ සේවා ආකෘතිය ක්‍රියාත්මක කිරීමේදී තාක්‍ෂණික විසඳුම් සඳහා ඔහුට සහාය වේ. ඇයට හොඳ වසම් දැනුමක් ඇති අතර ප්‍රතිඵල මත පදනම් වේ. ඇය විශ්වසනීය වන අතර පාර්ශ්වකරුවන් කළමනාකරණ කුසලතා පෙන්නුම් කරයි.</p>
        </div>
        <div id="AmitSharma-sin-cont" style="display: none">
            <p class="font-weight-bold">
                අමිත් ෂර්මා (Amith Sharma)<br>
                ප්‍රාදේශීය කළමනාකරු<br>
                වයස - අවුරුදු 38; පළපුරුද්ද - අවුරුදු 15; GTC පළපුරුද්ද - අවුරුදු 10 යි
            </p>
            <p>අමිත් ක්ෂේත්‍රයේ සුළු හා මධ්‍ය පරිමාණ ව්‍යාපාර ගනුදෙනුකරුවන් සමඟ කටයුතු කර ඇත. ඔහු කුඩා කණ්ඩායම් කළමනාකරණය කර ඇති අතර ගනුදෙනුකරුවන්ගේ අවකාශය තුළ ඔහු යහපත් වාර්තාවක් තබා ඇත. ඔහු GTC ආයතනය සමඟ පුරා දශකයක් ගත කර ඇති අතර වසර ගණනාවක් තිස්සේ වෙළඳපල පිළිබඳ විශේෂඥතාවයන් වර්ධනය කර ගෙන ඇත. ඔහුට පාර්ශ්වකරුවන් සහ සේවාදායක කළමනාකරණ විශිෂ්ට කුසලතා ඇත. කෙසේවෙතත්, ඔහුගේ කාර්යබහුල කාලසටහන නිසා ඔහුව සම්බන්ධ කර ගැනීම දුෂ්කර ය.</p>
        </div>
        <div id="ZahilHasan-sin-cont" style="display: none">
            <p class="font-weight-bold">
                සෙලිහා හසන් (Zeliha Hasan)<br>
                වීපී - කුඩා මධ්‍යම පරිමාණ ව්‍යවසායන්<br>
                වයස - අවුරුදු 40; පළපුරුද්ද - අවුරුදු 17; GTC පළපුරුද්ද - අවුරුදු 9 යි
            </p>
            <p>සෙලීහා GTC ආයතනයෙහි නායකත්ව කණ්ඩායමේ මිල කළ නොහැකි සාමාජිකයෙකු වන අතර නව සහ පැරණි සේවාදායකයින් සමඟ ශක්තිමත් සබඳතා ගොඩනඟා ගනිමින් සමාගමේ සාර්ථකත්වයට සැලකිය යුතු දායකත්වයක් ලබා දී ඇත. ඇයගේ ආදර්ශමත් කාර්යසාධනය හේතුවෙන් සමාගම තුළ ඇය ලබා ඇති වේගවත් ප්‍රගතිය සැම විටම කැපි පෙනිනි. ශක්තිමත් දැක්මක් ඇති කර ගැනීමෙන් අන් අය සමග පහසුවෙන් සම්බන්ධ වීමට හා ආස්වාදයක් ලබා දිමට හැකි සමාගමේ විශිෂ්ට නායිකාවක් ලෙස ඇය සලකනු ලැබේ.</p>
        </div>

    </div>

    <!-------   Tamil  ------>
    <div id="Tamil-popup">
        <div id="AugngM-Tamil-cont" style="display: none">
            <p class="font-weight-bold">
                ஆகங் கான்<br>
                முன்னணி - நிர்வகிக்கப்பட்ட சேவைகள்<br>
                வயது - 33 வயது; அனுபவம் - 8 ஆண்டுகள்; ஜிடிசி அனுபவம் - 7 ஆண்டுகள்
            </p>
            <p>ஆக்ங், தனது தொழில் வாழ்க்கையின் தொடக்கத்திலிருந்து, பல தேசிய நிறுவனங்களுடன் பணிபுரிந்தார், மேலும் நிர்வகிக்கப்பட்ட சேவைகள் களத்தில் குறிப்பிடத்தக்க பங்களிப்பைச் செய்துள்ளார். ஆக்ங் தொடர்ந்து ஒரு நல்ல வலுவான களத்தையும் சந்தை அறிவையும் வெளிப்படுத்தியுள்ளார். ஜி.டி.சி-க்குள் அவரது பங்கு பல ஆண்டுகளாக தொழில்நுட்ப தீர்வு வடிவமைப்பிலிருந்து திட்ட மேலாண்மை வரை உருவானது. அவரது வெளிப்பாடு திறன்கள் அவரது பங்குதாரர்களை எளிதில் ஈடுபடுத்தவும் ஊக்குவிக்கவும் உதவுகின்றன. அவர் சுய உந்துதல் கொண்டவர், மற்றும் மேலிருந்து சிறிய மைக்ரோமேனேஜ்மென்ட் (micromanagement). இது கையில் இருக்கும் பணியின் உரிமையை உருவாக்க அவருக்கு உதவுகிறது. அவரிடம் ஒரு குழு உறுப்பினர் புகார் அளிக்கிறார் - ஆயிஷா.</p>
        </div>
        <div id="KhalisT-Tamil-cont" style="display: none">
            <p class="font-weight-bold">
                காலிஸ் ரஹ்மான் |<br>
                முன்னணி - நிரல் மேலாண்மை<br>
                வயது - 31 வயது; அனுபவம் - 7 ஆண்டுகள்; ஜிடிசி அனுபவம் - 7 ஆண்டுகள்
            </p>
            <p>காலிஸ் ஜி.டி.சி உடன் தனது வாழ்க்கையைத் தொடங்கினார் மற்றும் சில முக்கிய கூட்டாண்மைகளை இயக்குவதில் முக்கிய பங்கு வகித்தார். அவர் அணிகளில் சிறப்பாக செயல்படுகிறார், மேலும் திட்ட காலக்கெடு சமரசம் செய்யப்படுவதை உறுதிசெய்ய. அவர் நிறுவனத்திற்கு உள்ளேயும் வெளியேயும் ஒரு வலுவான வலையமைப்பைக் கொண்டுள்ளார், அவர் தொடர்புடைய நிபுணத்துவம் மற்றும் நுண்ணறிவுகளைக் கொண்டுவர உதவுகிறார். எவ்வாறாயினும், அவர் தனது பணி வாழ்க்கை சமநிலையில் சமரசம் செய்யாதது குறித்து குறிப்பாகக் குறிப்பிடுகிறார், மேலும் அலுவலகத்தில் பிற்பகல் வரை பணியாற்றுவதைப் பாராட்டுவதில்லை.</p>
        </div>
        <div id="AmarM-Tamil-cont" style="display: none">
            <p class="font-weight-bold">
                அமர் ஹொசைன்<br>
                முன்னணி - தீர்வு கட்டிடக் கலைஞர்<br>
                வயது - 31 வயது; அனுபவம் - 7 ஆண்டுகள்; ஜிடிசி அனுபவம் - 6 ஆண்டுகள்
            </p>
            <p>
                வாடிக்கையாளரின் தேவைகளுக்கு ஏற்றவாறு தீர்வு கட்டமைப்பை உருவாக்குவதில் அமருக்கு நிபுணத்துவம் உள்ளது. அவர் பல்வேறு துறைகளில் பல்வேறு திட்டங்களில் பணியாற்றியுள்ளார் மற்றும் அவரது வலுவான தகவல் தொழில்நுட்ப பின்னணியை மேம்படுத்தினார். இப்பகுதியில் அவரது திறமை காரணமாக திட்டங்களின் போது தொழில்நுட்பத்தை செயல்படுத்துவது குறித்து அவர் அடிக்கடி ஆலோசிக்கப்படுகிறார். இதன் விளைவாக, அவர் தொடர்ந்து நீட்டிக்கப்பட்டது, வரையறுக்கப்பட்ட காலக்கெடுவுக்குள் வேலையை முடிக்க போராடுகிறார். எனவே, புதிய படைப்புகளை எடுக்க அவர் எப்போதும் தயக்கம் காட்டுகிறார், ஏனெனில் முரண்பட்ட முன்னுரிமைகளைச் சமாளிக்க வேண்டும். அவரை சீரமைக்க, அவரது மேலாளருடன் உரையாடல் பெரும்பாலும் தேவைப்படுகிறது.
            </p>
        </div>
        <div id="AishahR-Tamil-cont" style="display: none">
            <p class="font-weight-bold">
                அமித் சர்மா<br>
                பிராந்திய மேலாளர்<br>
                வயது - 38 வயது; அனுபவம் - 15 ஆண்டுகள்; ஜிடிசி அனுபவம் - 10 ஆண்டுகள்
            </p>
            <p>அமித் தொழிலில் SME வாடிக்கையாளர்களுடன் பணியாற்றியுள்ளார். அவர் சிறிய அணிகளை நிர்வகித்து வருகிறார் மற்றும் வாடிக்கையாளர்களின் இடத்தில் சிறந்த சாதனை படைத்துள்ளார். அவர் ஜி.டி.சி உடன் ஒரு தசாப்தத்தை செலவிட்டார் மற்றும் பல ஆண்டுகளாக சந்தையில் ஒரு நிபுணத்துவத்தை உருவாக்கியுள்ளார். அவர் சிறந்த பங்குதாரர் மற்றும் வாடிக்கையாளர் மேலாண்மை திறன்களைக் கொண்டவர். எவ்வாறாயினும், அவர் தனது ஓய்வில்லாத கால அட்டவணை காரணமாக ஒரு பிடியைப் (hold off) பெறுவது மிகவும் கடினம்</p>
        </div>
        <div id="AmitSharma-Tamil-cont" style="display: none">
            <p class="font-weight-bold">
                ஆயிஷா அகமது |<br>
                தீர்வு கட்டிடக் கலைஞர்<br>
                வயது - 29 வயது; அனுபவம் - 6 ஆண்டுகள்; ஜிடிசி அனுபவம் - 3 ஆண்டுகள்
            </p>
            <p>ஆயிஷா ஒரு ஆர்வமுள்ள அணி வீரர் மற்றும் தொலைத் தொடர்புத் துறையைப் பற்றிய நல்ல அறிவைக் கொண்டிருக்கிறார். அவர் ஆக்ங்கில் மேற்பார்வையின் கீழ்  நிர்வகிக்கப்பட்ட சேவைகள் மாதிரியை செயல்படுத்தும்போது தொழில்நுட்ப தீர்வுக்கு அவருக்கு உதவுகிறார். அவளுக்கு நல்ல டொமைன் (domain) அறிவு உள்ளது, இதன் விளைவாக இயக்கப்படுகிறார். அவர் நம்பகமானவர் மற்றும் நல்ல பங்குதாரர் மேலாண்மை திறன்களை நிரூபிக்கிறார்.</p>
        </div>
        <div id="ZahilHasan-Tamil-cont" style="display: none">
            <p class="font-weight-bold">
                ஜெலிஹா ஹசன்<br>
                வி.பி - சிறு நடுத்தர நிறுவனங்கள்<br>
                வயது - 40 வயது; அனுபவம் - 17 ஆண்டுகள்; ஜிடிசி அனுபவம் - 9 ஆண்டுகள்
            </p>
            <p>ஜீலிஹா ஜி.டி.சியில் தலைமைக் குழுவின் விலைமதிப்பற்ற உறுப்பினராக உள்ளார், மேலும் புதிய மற்றும் பழைய வாடிக்கையாளர்களுடன் வலுவான உறவுகளை ஏற்படுத்தி நிறுவனத்தின் வெற்றிக்கு கணிசமாக பங்களித்துள்ளார். அவரது முன்மாதிரியான செயல்திறன் காரணமாக நிறுவனத்தில் அவரது முன்னேற்றம் எப்போதும் வேகமாக கண்காணிக்கப்படுகிறது. அவர் ஒரு சிறந்த தலைவராக பார்க்கப்படுகிறார், அவர் ஒரு வலுவான பார்வையை (strong vision )உருவாக்குவதன் மூலம் மற்றவர்களை எளிதில் ஊக்கப்படுத்த முடியும்.</p>
        </div>
    </div>

    <div id="dvDialog" style="display: none"></div>
    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
</asp:Content>

