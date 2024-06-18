<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="GtcStrategicPartners.aspx.vb" Inherits="Data_Information_GtcStrategicPartners" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "LeadershipPresence.aspx";
        }
        function fnExample() {
            window.location.href = "TaskExample.aspx?MenuId=8";
        }
    </script>
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

        }(jQuery))


    </script>

    <script type="text/javascript">
        function fnChangeDataBasedOnLanguage(X) {
            var LngID = $("#hdnLngID").val();

            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }

            fnChangeDataOnPanelPage()

            if (LngID == "2") {
                $("#dvIndonesia").show();
                $("#dvEnglish").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();

                $("#btnAnchorNext").html("Selanjutnya")
                $("#btnAnchorclose").html("Tutup")
            }
            else if (LngID == "3") {

                $("#dvSinhala").show();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
                $("#dvTamil").hide();

                $("#btnAnchorNext").html("ඊළඟ")
                $("#btnAnchorclose").html("நெருக்கமான")
            }
            else if (LngID == "1") {

                $("#dvTamil").show();
                $("#dvSinhala").hide();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();

                $("#btnAnchorNext").html("ඊළඟ")
                $("#btnAnchorclose").html("நெருக்கமான")
            }
            else {
                $("#dvEnglish").show();
                $("#dvTamil").hide();

                $("#dvIndonesia").hide();
                $("#dvSinhala").hide();


                $("#btnAnchorNext").html("Next")
                $("#btnAnchorclose").html("Close")
            }

            if (X == 2) {
                $('#dvLanguage').dialog('close');
            }

            PageMethods.fnSetSession(LngID, fnUpdateSessionSuccess, fnUpdateSessionFailed);
        }
        function fnUpdateSessionSuccess(result) {

        }
        function fnUpdateSessionFailed(result) {
            //    alert(result._message);
        }
    </script>

    <script type="text/javascript">


        function fnClose() {
            window.location.href = '<%=System.Configuration.ConfigurationManager.AppSettings("TestURL") %>'
        }

    </script>

    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        $(document).ready(function () {

            //if ($("#hdnFlagPageToOpen").val() == "3") {
            //    f1();
            //    $("#btnClose").remove();
            //}
            //else {
            //    $("#theTime").hide();
            //    $("#btnNext").remove();
            //}
            fnChangeDataBasedOnLanguage(1)
        });
        function f1() {

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

                $("#dvDialog")[0].innerHTML = "<center>Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " </center>";
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


        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime" class="fst-color" style="display: none">Reading Time Left 00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>

    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">Employee Details & Work Culture</h3>
            <div class="title-line-center"></div>
        </div>
        <%--   <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>--%>

         <div class="col-9">
                        <img src="../../Images/EmployeeDetails.jpg" class="img-thumbnail" />
                    </div>
                    <%--<img src="../../Images/EmployeeDetails.jpg" class="img-thumb pull-right" />--%>
                    <p><strong>Manpower Growth:</strong></p>

                    <table class="table table-bordered table-sm">
                        <thead>
                            <tr>
                                <th colspan="5" width="414">
                                    <p style="text-align: center;"><strong>Manpower Growth</strong></p>
                                </th>
                            </tr>
                            <tr>
                                <th width="88">&nbsp;</th>
                                <th width="77">
                                    <p><strong>2023-24</strong></p>
                                </th>
                                <th width="81">
                                    <p><strong>2022-23</strong></p>
                                </th>
                                <th width="92">
                                    <p><strong>2021-22</strong></p>
                                </th>
                                <th width="77">
                                    <p><strong>2020-21</strong></p>
                                </th>
                            </tr>
                        </thead>
                        <tbody>

                            <tr>
                                <td width="88">
                                    <p>Employees</p>
                                </td>
                                <td width="77">
                                    <p>57,061</p>
                                </td>
                                <td width="81">
                                    <p>54,202</p>
                                </td>
                                <td width="92">
                                    <p>50,267</p>
                                </td>
                                <td width="77">
                                    <p>49,107</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>


                    <p><strong>Manpower Distribution 2023-24 </strong></p>
                    <div class="col-8">
                        <img src="../../Images/CaseStudy_Image4.png" class="img-thumbnail" />
                    </div>

                    <table class="table table-bordered table-sm">
                        <thead>

                            <tr>
                                <th colspan="6" width="532">
                                    <p style="text-align: center;"><strong>Agewise Distribution</strong></p>
                                </th>
                            </tr>
                            <tr>
                                <th width="68">&nbsp;</th>
                                <th width="113">
                                    <p><strong>&lt;30 years</strong></p>
                                </th>
                                <th width="113">
                                    <p><strong>30-50 years</strong></p>
                                </th>
                                <th width="103">
                                    <p><strong>&gt;50 years</strong></p>
                                </th>
                                <th width="68">
                                    <p><strong>Total</strong></p>
                                </th>
                                <th width="65">
                                    <p><strong>Total</strong></p>
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td width="68">
                                    <p>Female</p>
                                </td>
                                <td width="113">
                                    <p>2,082</p>
                                </td>
                                <td width="113">
                                    <p>1,498</p>
                                </td>
                                <td width="103">
                                    <p>1,042</p>
                                </td>
                                <td width="68">
                                    <p>4,622</p>
                                </td>
                                <td rowspan="2" width="65">
                                    <p>57,061</p>
                                </td>
                            </tr>
                            <tr>
                                <td width="68">
                                    <p>Male</p>
                                </td>
                                <td width="113">
                                    <p>14,485</p>
                                </td>
                                <td width="113">
                                    <p>27,805</p>
                                </td>
                                <td width="103">
                                    <p>10,149</p>
                                </td>
                                <td width="68">
                                    <p>52,439</p>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <p><strong>Work Culture in Nexus</strong></p>
                    <p>The work culture at Nexus reflects the organization's commitment to excellence and continuous improvement. It embraces change wholeheartedly, driving multiple transformations in the way work is approached, executed, and managed.</p>
                    <p><strong>Innovation and Agility</strong>: Employees are encouraged to think outside the box and challenge the status quo. Innovation is not just a buzzword but a way of life, driving the company's relentless pursuit of excellence. Agile methodologies are embraced to adapt quickly to changing market dynamics and customer needs.</p>
                    <p><strong>Collaborative Environment</strong>: Collaboration is at the heart of the company culture. Teams work seamlessly across departments and disciplines, leveraging each other's strengths to deliver world-class solutions. Strategic partnerships with both public and private entities foster a spirit of collaboration beyond the organization's boundaries.</p>
                    <p><strong>Change Management</strong>: With the company driving multiple changes in the ways of working, employees are accustomed to a culture of change and adaptation. Change is seen as an opportunity for growth rather than a disruption, and employees are empowered to embrace and drive change at all levels of the organization.</p>
                    <p><strong>Empowerment and Ownership</strong>: Employees are empowered to take ownership of their work and make decisions that drive results. A flat organizational structure encourages open communication and transparency, enabling employees to voice their ideas and concerns freely.</p>
                    <p><strong>Continuous Learning and Development</strong>: The company recognizes that its most valuable asset is its people. As such, it invests heavily in the training and development of its workforce, ensuring that employees have access to the skills and knowledge they need to thrive in a rapidly evolving industry.</p>
                    <p><strong>Environmental and Social Responsibility</strong>: As a responsible corporate citizen, the company is committed to minimizing its environmental footprint and making a positive impact on society. Sustainable practices are integrated into every aspect of the business, from design and construction to operations and maintenance.</p>
             
    </div>
    <!------------ End English------------------>

    <!------------ Indonesia------------------>
    <div id="dvIndonesia" style="display: none">
        <div class="section-title">
            <h3 class="text-center">KEMITRAAN STRATEGIS GTC</h3>
            <div class="title-line-center"></div>
        </div>
        <p>GTC ingin meraih posisi yang kuat pada pasar dengan memanfaatkan ekosistem mitra mereka untuk memberikan praktik pengalaman pembelajaran terbaik, model agile delivery, dan harga yang kompetitif bagi klien. Model Kemitraan Strategis (Strategic Partnership Model) selalu menjadi pembeda utama bagi GTC yang memberikan keunggulan kompetitif dibandingkan dengan pemain lain di pasar.</p>
        <img src="../../Images/partnership.jpg" class="img-thumb pull-right" />
        <p>GTC belakangan ini mulai menjalin kemitraan dengan Mteams dan Google Cloud untuk menawarkan solusi konektivitas tingkat lanjut untuk UKM. Kemitraan dengan Mteams meliputi layanan software-defined wide area network (SD-WAN) yang terkelola, termasuk analitik real-time dan keamanan bawaan (in-build safety), serta layanan Webex.  Di bawah kemitraan dengan Google Cloud, GTC akan menawarkan G Suite, sekumpulan aplikasi cerdas termasuk Gmail, Google Docs, Google Drive, Google Calendar, dan aplikasi lainnya yang dirancang dengan kolaborasi real-time dan kecerdasan mesin (machine intelligence).</p>
        <p>Kemitraan strategis yang efektif dan andal tersebut membantu GTC untuk membangun keahlian yang sifatnya sektor spesifik, memberikan layanan dalam volume tinggi, dan menghadirkan keahlian  mengenai peralatan dan platform terkait.</p>

    </div>
    <!------------ End Indonesia------------------>

    <!------------ Sinhala------------------>
    <div id="dvSinhala" style="display: none">
        <div class="section-title">
            <h3 class="text-center">උප ටැබ්- GTC ආයතන උපායමාර්ගික හවුල්කරුවන්</h3>
            <div class="title-line-center"></div>
        </div>
        <p>GTC ආයතනය හට තම හවුල්කාර පරිසර පද්ධතිය උත්තේජනය [leveraging] කිරීමෙන් වෙළඳපොළ තුළ ශක්තිමත් අඩිපාරක් [strong foothold] ලබා ගැනීමට අවශ්‍ය වන්නේ, හොඳම පන්තියේ [best-in-class] ඉගෙනුම් අත්දැකීම්, කඩිනම් බෙදාහැරීමේ ආකෘති සහ තරඟකාරී මිල ගණන් ගනුදෙනුකරුවන්ට ලබා දීම සඳහා ය. උපායමාර්ගික හවුල්කාරිත්ව ආකෘතිය සැමවිටම GTC ආයතනය සඳහා වෙළඳපොලේ අනෙකුත් තරගකරුවන්ට [players] වඩා තරඟකාරී ස්ථානයක් ලබා දෙන ප්‍රධාන අවකලනයකි. (differentiator).</p>
        <img src="../../Images/partnership.jpg" class="img-thumb pull-right" />
        <p>කුඩා හා මධ්‍ය පරිමාණ ව්‍යාපාර සඳහා උසස් සම්බන්ධතා විසඳුම් ලබා දීම සඳහා GTC ආයතනය මෑතකදී MTeams සහ Google Cloud සමඟ හවුල්කාරිත්වයකට එළඹ තිබේ. MTeams සමඟ ඇති හවුල්කාරිත්ව තුල කළමනාකරණය කළ මෘදුකාංග-නිර්වචනය කළ පුළුල් ප්‍රදේශ ජාල  (SD-WAN) [software-defined wide area network] සේවා තත්කාලීන විශ්ලේෂණ [real-time analytics] සහ අභ්‍යන්තර ආරක්ෂාව මෙන්ම වෙබෙක්ස් [Webex] සේවා ඇතුළුව සැපයීම සිදු වේ.</p>
        <p>ගූගල් ක්ලවුඩ් [Google Cloud] සමඟ ඇතිකරගත් හවුල්කාරිත්වය යටතේ, ජීටීසී [GCT] විසින් තත්කාලීන සහයෝගීතාවයෙන් [real-time collaboration] සහ යන්ත්‍ර බුද්ධියෙන් [machine intelligence] නිර්මාණය කර ඇති ජීමේල් (Gmail), ඩොක්ස් (Docs), ඩ්‍රයිව් (Drive), දින දර්ශනය සහ තවත් බොහෝ බුද්ධිමත් යෙදුම් [intelligent apps] සමූහයක් අඩංගු වන ජී සූට් (G Suite) ලබා දෙනු ඇත.</p>
        <p>එවැනි ඵලදායී හා විශ්වාසදායක උපායමාර්ගික හවුල්කරුවන් විසින් ක්ෂේත්‍රයට විශේෂිත වූ විශේෂඥ්තාවයන් ගොඩනඟා ගැනීමටත්, ඉහළ සේවාවක් ලබා දීමටත්, මෙවලම් හා වේදිකා [platform] ආශ්‍රිත විශේෂඥ්තාවයන් ගෙන ඒමටත් GTC ආයතනයට උපකාරී වේ.     </p>

    </div>
    <!------------ End Sinhala------------------>

    <!------------ Tamil------------------>
    <div id="dvTamil" style="display: none">
        <div class="section-title">
            <h3 class="text-center">ஜிடிசி ஸ்ட்ராடஜிக் பார்ட்னர்ஷிப்ஸ்</h3>
            <div class="title-line-center"></div>
        </div>
        <p>ஜி.டி.சி தங்கள் கூட்டாளர் சுற்றுச்சூழல் அமைப்பை மேம்படுத்துவதன் மூலம் சந்தையில் ஒரு வலுவான இடத்தைப் பெற விரும்புகிறது, இது சிறந்த-வகுப்பு கற்றல் அனுபவம், விநியோக மாதிரிகள் மற்றும் வாடிக்கையாளர்களுக்கு போட்டி விலை நிர்ணயம் ஆகியவற்றை வழங்குகிறது. மூலோபாய கூட்டாண்மை மாதிரி எப்போதுமே ஜி.டி.சி சந்தையில் உள்ள மற்ற வீரர்களை விட ஒரு போட்டி விளிம்பைக் கொடுக்கும் ஒரு முக்கிய வேறுபாடாக இருந்து வருகிறது.</p>
        <img src="../../Images/partnership.jpg" class="img-thumb pull-right" />
        <p>சிறிய நடுத்தர நிறுவனங்களுக்கு மேம்பட்ட இணைப்பு தீர்வுகளை வழங்க ஜி.டி.சி சமீபத்தில் எம்டீம்ஸ் (Mteams) மற்றும் கூகிள் கிளவுட் உடன் கூட்டாண்மைக்குள் நுழைந்துள்ளது. எம்டீம்ஸ் (Mteams) உடனான கூட்டு, நிர்வகிக்கப்பட்ட மென்பொருள் வரையறுக்கப்பட்ட பரந்த பகுதி நெட்வொர்க் (software-defined wide area network (SD-WAN) services) சேவைகளை வழங்குகிறது, இதில் நிகழ்நேர பகுப்பாய்வு மற்றும் உள்ளடிக்கிய பாதுகாப்பு மற்றும் வெபெக்ஸ் சேவைகள் ஆகியவை அடங்கும். கூகிள் கிளவுட் உடனான கூட்டுறவின் கீழ், ஜிடிசி ஜி சூட் (G Suite), ஜிமெயில், டாக்ஸ், டிரைவ், கேலெண்டர் (Gmail, Docs, Drive, Calendar) மற்றும் பலவற்றை உள்ளடக்கிய அறிவார்ந்த பயன்பாடுகளின் தொகுப்பை வழங்கும், இது நிகழ்நேர ஒத்துழைப்பு மற்றும் இயந்திர நுண்ணறிவுடன் வடிவமைக்கப்பட்டுள்ளது.</p>
        <p>
            இத்தகைய பயனுள்ள மற்றும் நம்பகமான மூலோபாய பங்காளிகள் ஜி.டி.சி.க்கு துறை சார்ந்த நிபுணத்துவத்தை உருவாக்கவும், அதிக அளவிலான சேவையை வழங்கவும் மற்றும் கருவி மற்றும் தளம் தொடர்பான நிபுணத்துவத்தை கொண்டு வரவும் உதவுகிறார்கள்.
        </p>
    </div>
    <!------------ End Tamil------------------>

    <div class="text-center mb-3" style="display: none;">
        <asp:Button ID="btnSubmit" runat="server" CssClass="btns btn-submit" Text="Next" />
    </div>
    <div class="text-center mb-3" id="btnNext"><a href="#" onclick="fnMenu(5, this)" id="btnAnchorNext" class="btns btn-submit">Next</a></div>

    <%--  <div class="text-center mb-3" id="btnClose"><a href="#" onclick="fnClose()" id="btnAnchorclose" class="btns btn-submit">Close</a></div>--%>




    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

