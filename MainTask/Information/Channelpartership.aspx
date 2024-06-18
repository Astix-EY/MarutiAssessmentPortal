<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Panel.master" AutoEventWireup="false" CodeFile="Channelpartership.aspx.vb" Inherits="Data_Information_Channelpartership" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "LeadershipPresence.aspx";
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

            if ($("#hdnFlagPageToOpen").val() == "3") {
                f1();
                $("#btnClose").remove();
            }
            else {
                $("#theTime").hide();
                $("#btnNext").remove();
            }
            fnChangeDataBasedOnLanguage(1)
        });
        function f1() {

            if (IsUpdateTimer == 0) { return; }
            SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
            if (SecondCounter <= 0) {
                IsUpdateTimer = 0;

                $("#theTime").addClass("blinkmsg");

                $('.blinkmsg').blink({
                    delay: "1500"
                });

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
    <time id="theTime" class="fst-color">Reading Time Left 00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>

    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">GTC STRATEGIC PARTNERSHIPS</h3>
            <div class="title-line-center"></div>
        </div>
        <p>GTC wants to gain a strong foothold in the market by leveraging their partner ecosystem to provide best-in-class learner experience, agile delivery models and competitive pricing to clients. Strategic Partnership Model has always been a key differentiator for GTC giving it a competitive edge over other players in the market.</p>
        <img src="../../Images/partnership.jpg" class="img-thumb pull-right" />
        <p>GTC has recently entered into partnerships with MTeams and Google Cloud to offer advanced connectivity solutions to SMEs. The partnership with MTeams entails offering managed software-defined wide area network (SD-WAN) services, including real-time analytics and inbuilt safety, as well as Webex services. Under the partnership with Google Cloud, GTC will offer G Suite, a set of intelligent apps including Gmail, Docs, Drive, Calendar and more, designed with real-time collaboration and machine intelligence.</p>
        <p>Such effective and reliable strategic partners help GTC to build in sector specific expertise, deliver high volumes of service and bring in tool and platform related expertise.</p>
    </div>
    <!------------ End English------------------>

    <!------------ Indonesia------------------>
    <div id="dvIndonesia" style="display: none">
        <div class="section-title">
            <h3 class="text-center">KANAL KEMITRAAN GTC</h3>
            <div class="title-line-center"></div>
        </div>
        <p>GTC ingin meraih posisi yang kuat pada pasar dengan memanfaatkan ekosistem mitra mereka untuk memberikan layanan pelanggan terbaik, model agile delivery, dan harga yang kompetitif bagi klien. Model Kanal Kemitraan (Channel Partnership Model) selalu menjadi pembeda utama bagi GTC yang memberikan keunggulan kompetitiff dibandingkan dengan pemain lain di pasar.</p>
        <p class="font-weight-bold">Kanal mitra yang efektif dan dapat diandalkan membantu GTC untuk:</p>
        <img src="../../Images/partnership.jpg" class="img-thumb" align="right" />
        <ul>
            <li><span class="font-weight-bold">MEMBANGUN KEAHLIAN PADA SEKTOR SPESIFIK -</span> GTC memahami bahwa klien sangat memiliki kebutuhan untuk bermitra dengan vendor yang memiliki pemahaman tentang sektor di mana mereka beroperasi. Apresiasi kontekstual terhadap lingkungan bisnis ini membantu GTC menciptakan layanan spesifik yang relevan dengan sektor tersebut.</li>
            <li><span class="font-weight-bold">MENGHASILKAN VOLUME LAYANAN YANG TINGGI -</span> GTC bermitra dengan kanal mitra besar yang terpercaya untuk memastikan pemenuhan seluruh SLA-nya, terutama untuk klien dengan server, pusat data, atau perangkat berskala tinggi. Hal tersebut membantu untuk memastikan bahwa GTC tidak pernah kekurangan sumber daya, sehingga memungkinkan GTC menyediakan layanan dengan biaya hingga 15-35% lebih rendah.</li>
            <li><span class="font-weight-bold">AHLI DALAM TOOL DAN PLATFORM -</span> GTC merupakan perusahaan terdepan dalam membentuk komitmen strategi global dengan pemain besar pada pasar untuk RPA, AI, ML, Chatbots dalam rangka memastikan penawaran terbaik mereka kepada klien. </li>
        </ul>
        <p>Kemitraan yang terjalin dengan MSoft telah membantu dalam membangun hubungan yang saling menguntungkan antara kedua belah pihak dan meningkatkan nilai yang ditawarkan GTC kepada klien. Dengan kemitraan ini, GTC memiliki akses ke seluruh jaringan kanal mitra MSoft di seluruh dunia sehingga memungkinkan antar layanan (service delivery) secara lokal untuk klien mereka.</p>

    </div>
    <!------------ End Indonesia------------------>

    <!------------ Sinhala------------------>
    <div id="dvSinhala" style="display: none">
        <div class="section-title">
            <h3 class="text-center">GTC නාලිකා හවුල්කරුවන්</h3>
            <div class="title-line-center"></div>
        </div>
        <p>
            GTC තම හවුල්කාර පරිසර පද්ධතිය (partner ecosystem) ඉහළ නැංවිම මඟින් ඉහළ මට්ටමේ පාරිභෝගික සේවාවක්, කඩිනම් බෙදාහැරීමේ ආකෘතික් සහ ගනුදෙනුකරුවන්ට තරඟකාරී මිල ගණන් ලබා දීමේ වැඩපිළිවෙලක් මඟින් වෙළඳපල තුළ ශක්තිමත් අඩිතාලමක් සකස් කිරිමට අවශ්‍ය වේ. නාලිකා හවුල්කාරිත්ව ආකෘතිය සැමවිටම GTC සඳහා වෙළඳපොලේ සෙසු තරඟකරුවන්ට වඩා තරඟකාරී ස්ථානයක් ලබා දෙයි.
        </p>
        <p class="font-weight-bold">ඵලදායී සහ විශ්වාසදායක නාලිකා හවුල්කරුවන් GTC සහය වනු ලබන්නේ:</p>
        <img src="../../Images/partnership.jpg" class="img-thumb" align="right" />
        <ul>
            <li><span class="font-weight-bold">ක්ෂේත්‍රය ආශ්‍රිත විශේෂිත වු පළපුරුද්ද ගොඩනැගීම  -</span> සේවාදායකයින් තමන් ක්‍රියාත්මක වන ක්ෂේත්‍රය පිළිබඳව දැඩි අවබෝධයක් ඇති වෙළෙන්දන් සමඟ හවුල් වීමේ දැඩි අවශ්‍යතාවය GTC විසින් අගය කරයි. ව්‍යාපාරික පරිසරය පිළිබඳ මෙම අගය කිරීම එම අංශයට අදාළ සුවිශේෂී සේවාවන් නිර්මාණය කිරීමට GTC උපකාරී වේ.  </li>
            <li><span class="font-weight-bold">ඉහළ සේවා පරිමාවන් සැපයිම -</span> විශ්වාසදායක මහා පරිමාණ නාලිකා හවුල්කරුවන් සමඟ GTC හවුල් වනුයේ,  විශේෂයෙන් තම ඉහළ මට්ටමේ සර්වරස් (servers), දත්ත මධ්‍යස්ථාන හෝ උපාංග (device) ඇති සේවාදායකයන්ට සේවා මට්ටමේ ගිවිසුම් (SLAs) සපුරා දෙන බව සහතික කිරීමටයි. එය මගින් GTC කිසි දිනෙක සම්පත් හි හිගයක් ඇති නොවන බවට විශ්වාසයක් සහ GTC 15%-35% අතර, අඩු පිරිවැයකින් සේවා සැපයිය හැකි බවට විශ්වාසයක් ද ඇත.</li>
            <li><span class="font-weight-bold">උපකරණ සහ වේදිකා ආශ්‍රිත ප්‍රවීණත්වය -</span> ගනුදෙනුකරුවන්ට විශිෂ්ට සේවාවක් ලබාදිම සහතික කිරීමට RPA, AI, ML, Chatbots සඳහා වෙළඳපොලේ සිටින මහා පරිමාණ තරඟකරුවන් සමඟ ගෝලීය උපායමාර්ගික සම්බන්ධතා ඇති කර ගැනීමට GTC පෙරමුණ ගෙන සිටී. </li>
        </ul>
        <p>
            MSoft සමඟ මෑත කාලීන හවුල්කාරිත්වය, හවුල්කරුවන් දෙදෙනා අතර අන්‍යෝන්‍ය වශයෙන් වාසිදායක සම්බන්ධතාවයක් ගොඩනඟා ගැනීමට උපකාරී වූ අතර ගනුදෙනුකරුවන්ට GTC විසින් ලබා දෙන වටිනාකම තවදුරටත් වැඩි දියුණු විය. මෙම හවුල්කාරිත්වය සමඟින්, තම සේවාදායකයින්ට දේශීය සේවා සැපයීම සඳහා MSoft හි ලොව පුරා ඇති නාලිකා හවුල්කරුවන්ගේ ජාලයට GTC ප්‍රවේශ විය හැක.
        </p>
    </div>
    <!------------ End Sinhala------------------>

    <!------------ Tamil------------------>
    <div id="dvTamil" style="display: none">
        <div class="section-title">
            <h3 class="text-center">ஜிடிசி விநியோக கூட்டிணைப்பு</h3>
            <div class="title-line-center"></div>
        </div>
        <p>சிறந்த வாடிக்கையாளர் சேவை, சுறுசுறுப்பான விநியோக மாதிரிகள் மற்றும் வாடிக்கையாளர்களுக்கு போட்டி விலை நிர்ணயம் ஆகியவற்றை வழங்குவதற்காக தங்கள் கூட்டாளர் சுற்றுச்சூழல் அமைப்பை மேம்படுத்துவதன் மூலம் சந்தையில் வலுவான இடத்தைப் பெற ஜிடிசி விரும்புகிறது. விநியோக கூட்டமைப்பு மாதிரி(channel partnership model)  எப்போதுமே ஜி.டி.சிக்கு சந்தையில் உள்ள மற்றவர்களை விட ஒரு கூடுதல் அனுகூலத்தைக் கொடுக்கும் முக்கியக் காரணியாக இருந்து வருகிறது.</p>
        <p class="font-weight-bold">பயனுள்ள மற்றும் நம்பகமான விநியோக கூட்டாளர்கள் ஜி.டி.சிக்கு பின்வருமாறு உதவுகிறார்கள்:</p>
        <img src="../../Images/partnership.jpg" class="img-thumb" align="right" />
        <ul>
            <li><span class="font-weight-bold">துறைசார் பிரதியேக நிபுணத்துவதில் வடிவமைக்கப்பட்டது -</span> வாடிக்கையாளர்கள், அவர்கள் செயல்படும் துறையைப் பற்றி வலுவான புரிதலைக் கொண்டுள்ள விற்பனையாளர்களுடன் கூட்டாளர்களாக இருப்பதற்கான வலுவான தேவையை ஜி.டி.சி விரும்புகின்றது. இந்த நிலையினூடாக, ஜி.டி.சி அந்தத் துறைக்கு பொருத்தமான சேவைகளை உருவாக்க உதவுகிறது.</li>
            <li><span class="font-weight-bold">அதிகப்படியான சேவைகளை வழங்குதல் -</span> நம்பகமான பெரிய சேனல் கூட்டாளர்களுடன் ஜி.டி.சி கூட்டமைப்பதனூடாக அதன் அனைத்து எஸ்.எல்.ஏஸ்களுக்குமான (SLAs) தேவைப்பாடுகளையும் பூர்த்தி செய்வதை உறுதிப்படுத்துகறது , குறிப்பாக அதிக அளவு சேவையகங்கள், தரவு மையங்கள் அல்லது சாதனங்களைக் கொண்ட வாடிக்கையாளர்களுக்கு வழங்குவதை உறுதிசெய்கிறார்கள். ஜி.டி.சிக்கு ஒருபோதும் வளங்கள் பற்றாக்குறை ஏற்படாது என்பதை உறுதிப்படுத்த ஜி.டி.சிக்கு இது உதவுகிறது, மேலும் ஜி.டி.சிஐ 15-35% குறைந்த செலவில் சேவைகளை வழங்க உதவுகிறது.</li>
            <li><span class="font-weight-bold">கருவி மற்றும் செயல்தளம் தொடர்பான அனுபவம் -</span>வாடிக்கையாளர்களுக்கு அவர்களின் சிறந்த சலுகையை உறுதி செய்வதற்காக, ஆர்.பி.ஏ(RPA), ஏ.ஐ(AI), எம்.எல் (ML), சாட்போட்களுக்கான(chatbots) சந்தையில் பெரிய நிறுவனங்களுக்கு மத்தியில், உலகளாவிய திட்டமிட்ட ஒத்துழைப்புகளை உருவாக்குவதில் ஜி.டி.சி முன்னணியில் உள்ளது.</li>
        </ul>
        <p>
            எம்.சொப்ட் உடனான சமீபத்திய கூட்டமைப்பு இரு கூட்டாளர்களிடையே பரஸ்பர நன்மை பயக்கும் உறவை உருவாக்க உதவியது மற்றும் வாடிக்கையாளர்களுக்கு ஜி.டி.சி வழங்கும் மதிப்பை மேலும் மேம்படுத்தியது. இந்த கூட்டமைப்பு மூலம், ஜி.டி.சி, எம்.சொப்ட்  வாடிக்கையாளர்களுக்கு சேவை வழங்கலை செயல்படுத்த உலகெங்கிலும் உள்ள எம்.சொப்ட் இன் முழு சேனல் கூட்டாளர்களின் வலைப்பினல்களிற்குள்ளும் செல்லும் அனுமதியை பெற்றுள்ளது..
        </p>
    </div>
    <!------------ End Tamil------------------>

    <div class="text-center mb-3" style="display: none;">
        <asp:Button ID="btnSubmit" runat="server" CssClass="btns btn-submit" Text="Next" />
    </div>
    <div class="text-center mb-3" id="btnNext"><a href="#" onclick="fnMenu(6, this)" id="btnAnchorNext" class="btns btn-submit">Next</a></div>
    <div class="text-center mb-3" id="btnClose"><a href="#" onclick="fnClose()" id="btnAnchorclose" class="btns btn-submit">Close</a></div>




    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

