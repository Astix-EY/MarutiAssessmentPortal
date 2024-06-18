<%@ Page Title="" Language="VB" MasterPageFile="~/DataA/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="GtcStrategicPartners.aspx.vb" Inherits="Data_Information_GtcStrategicPartners" %>

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
            <h3 class="text-center">Organizational Priorities</h3>
            <div class="title-line-center"></div>
        </div>
        <%--   <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>--%>

        <img src="../../Images/OrganizationalPriorities.png" class="img-thumb pull-right" />
       <p><strong>Integration of Acquisitions and Cultural Alignment: </strong>As BMS acquires new companies, integrating them into the existing corporate structure and people processes can be complex. Differences in culture, systems, and processes require a thoughtful approach to create a cohesive and efficient organization. Organizational restructuring and adequate due diligence may be required to reinforce core values and ensure that all employees are aligned with the company's unified culture and strategic goals.</p>
<p><strong>Customer-Centricity:</strong> As BMS enters new markets and product segments, staying close to the customer can become more difficult. The company may need to restructure to be more agile and responsive to these changes. It may create more customer-centric units or roles, ensuring that customer feedback and market trends directly influence business decisions.</p>
<p><strong>Market Expansion and Customization:</strong> While expanding into new geographies and industries, it may encounter different customer expectations and competitive landscapes. BMS may need to ensure right structural alignment as suited to cater to different market needs and tap local customers. It needs to be in compliance with varying legal and regulatory requirements across different regions and sectors.</p>
<p><strong>Scaling Operations:</strong> Rapid expansion and the addition of new facilities and product lines can strain current operational structures. The company may need to restructure to manage increased complexity and ensure that all units operate synergistically to create operational excellence.</p>
<p><strong>Supply Chain Optimization:</strong> As the company grows, its supply chain becomes more complex. Restructuring may be necessary to streamline supply chain management, possibly by centralizing certain functions or adopting new technologies for better coordination.</p>
<p><strong>Innovation and Digital Transformation:</strong> To stay at the cutting edge, BMS needs to manage its innovation pipeline while embracing digital technologies. This may need BMS to restructure and create dedicated innovation hubs or specialized digital innovation teams to work on new product development/ process improvements with a digital-first approach.</p>
<p><strong>Talent Management:</strong> With the focus on innovation and digital skills, BMS may need to re-evaluate its talent acquisition, retention, and development strategies. Restructuring could involve creating new career paths, training programs, and performance management systems. With operations spanning across multiple countries and with few recent acquisitions, BMS also faces the challenge of managing rewards and compensation practices that comply with local regulations while maintaining consistency and fairness across the organization. Additionally, the ongoing exercise of transitioning to a fully integrated HRMS may pose a challenge if XYZ has legacy systems which are not completely compatible with the current HRMS. It would take a lot of additional investment for the integration to be seamless</p>
<p><strong>Talent Retention:</strong> With increasing number of players in the infrastructure business, ensuring a steady talent pool in India and other geographies has become more difficult. The company may need to review the existing people policies and create compensation plans which would ensure strong pull for prospective/ current employees. While BMS is a market leader in its core segment, the technology sector is highly competitive and skilled professionals are in high demand. To remain an employer of choice, the company must offer competitive compensation and benefits packages that attract and retain top talent in those segments too.</p>
<p><strong>Employee Feedback:</strong> While employees have always valued their association with the BMS brand and more than 40% employees have been with the company for over 10 years, recent employee feedback surveys have shown a decline in the overall satisfaction levels. Few of the low-scoring areas include career progression opportunities, compensation &amp; benefits, work life balance, etc</p>
<p><strong>High Employee Costs:</strong> Despite concerted efforts to rein in expenses, employee-related costs continue to spiral out of control. Rising salaries, escalating healthcare premiums, and other benefits expenses, coupled with the hefty price tag associated with turnover and recruitment, are straining the organization's financial resources</p>

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

