<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Panel.master" AutoEventWireup="false" CodeFile="BackgroundInformation.aspx.vb" Inherits="Data_Information_BackgroundInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "Groupoverview.aspx";
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
            }
            else if (LngID == "3") {

                $("#dvSinhala").show();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
                $("#dvTamil").hide();
            }
            else if (LngID == "1") {
                $("#dvTamil").show();
                $("#dvSinhala").hide();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
            }

            else {
                $("#dvEnglish").show();
                $("#dvIndonesia").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();
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
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        $(document).ready(function () {

            if ($("#hdnFlagPageToOpen").val() == "3") {
                f1();
            }
            else {
                $("#theTime").hide();
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
    <time id="theTime" class="fst-color">Reading Time Left  00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>

    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">BACKGROUND INFORMATION</h3>
            <div class="title-line-center"></div>
        </div>
        <p>With government support on the digital transformation agenda, telecom industry players are now taking a closer look at the SME market.</p>
        <p>ICT (information and communications technology) players are digitally transforming the status quo of business environments across Malaysia. In Malaysia, this transformation is coming to life with the rollout of 5G networks. With faster speeds of up to 1 Gbps, higher network capacity enabling up to 100 times more connected devices per square kilometer, and 1 ms latency, 5G is creating a new chapter in connectivity for individuals, businesses, and government entities.</p>
        <p>The recent COVID pandemic has only added to the momentum around all of this. A major industry impacted due to COVID pandemic is Education, most of them currently fall under the SME segment as categorised internally by GTC. </p>
        <p>With educational institutions not being allowed to function normally through regular classroom led programs in Malaysia and around the world as a result of the coronavirus pandemic, many countries are seeking to promote and support online learning for students at home. However, there is a constant challenge related to quick and easy access to online education. Many institutions are working with mobile operators, telecom providers, ISPs and other companies to increase access to digital resources while they are forced to remain closed. While these changes seem to be triggered by the pandemic, these changes are here to stay and hence transform how education is delivered not just across Malaysia but across the entire world.</p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(3, this)" class="btns btn-submit">Next</a></div>
    </div>
    <!------------ End English------------------>

    <!------------  Indonesia------------------>
    <div id="dvIndonesia" style="display: none">
        <div class="section-title">
            <h3 class="text-center">PERSPEKTIF PERUBAHAN INDUSTRI</h3>
            <div class="title-line-center"></div>
        </div>
        <p>Saat ini, pasar bertumbuh dengan cepat dan permintaan terhadap Layanan Pengelolaan Lengkap (Managed Services) Telekomunikasi terus meningkat. </p>
        <img src="../../Images/industry.jpg" class="img-thumb" align="right" />
        <p>Layanan Pengelolaan Lengkap membantu organisasi dalam memelihara infrastruktur ICT sehingga memungkinkan organisasi untuk fokus terhadap kegiatan bisnis inti mereka dan strategi pengembangan pasar. Diperkirakan bahwa 80% dari perusahaan Fortune 500 akan berpindah ke model operasi Layanan Pengelolaan Lengkap dalam 5-6 tahun ke depan.</p>
        <p>Tren global akan Layanan Pengelolaan Lengkap Telekomunikasi telah dipantau lebih lanjut di Amerika Utara dan Eropa. Asia Pasifik akan menunjukkan tingkat pertumbuhan yang sangat tinggi dalam 2-3 tahun ke depan. Pertumbuhan pasar di Asia Pasifik didorong oleh:</p>
        <ul class="font-weight-bold">
            <li>Peningkatan secara pesat untuk internet dan layanan seluler</li>
            <li>Kenaikan dalam penyebaran pusat data</li>
            <li>Pertumbuhan pesat dalam perkembangan teknologi</li>
            <li>Pendanaan dari pemerintah</li>
        </ul>
        <p>Pasar bagi Layanan Pengelolaan Lengkap Telekomunikasi diperkirakan akan tumbuh dari 11,90 miliar USD pada tahun 2017 menjadi 22,58 miliar USD pada tahun 2022, dengan Compound Annual Growth Rate (CAGR) sebesar 13,7%. Layanan Pengelolaan Lengkap juga diperkirakan akan menjadi pendorong pertumbuhan utama untuk GTC.</p>
        <div class="text-center mt-3"><a href="#" onclick="fnMenu(3, this)" class="btns btn-submit">Selanjutnya</a></div>
    </div>
    <!------------ End Indonesia------------------>

    <!------------ Sinhala------------------>
    <div id="dvSinhala" style="display: none">
        <div class="section-title">
            <h3 class="text-center">විවර්ත කර්මාන්ත පසුබිම (THE CHANGING INDUSTRY LANDSCAPE)</h3>
            <div class="title-line-center"></div>
        </div>
        <p>
            වෙළඳපල ශීඝ්‍රයෙන් වර්ධනය වන අතර ටෙලිකොම් කළමණාකරන සේවා සඳහා ඇති ඉල්ලුමද දිනෙන් දින ඉහළ යමින් පවතී.
        </p>
        <img src="../../Images/industry.jpg" class="img-thumb" align="right" />
        <p>
            ආයතන වල ICT යටිතල පහසුකම් නඩත්තු කිරීම සඳහා කළමනාකරණ සේවා (The Managed Services) උපකාර වන අතර එමඟින් ඔවුන්ගේ මූලික ව්‍යාපාරික ක්‍රියාකාරකම් සහ උපායමාර්ගික වෙළඳපල සංවර්ධනය කෙරෙහි අවධානය යොමු කිරීමට ආයතනවලට හැකි වේ. ෆෝචූන් සමාගම් 500 (Fortune 500 companies) අතරින් 80% ක් ඉදිරි වසර 5-6 තුළ කළමනාකරණ සේවා මෙහෙයුම් ආකෘතියකට (Model) පරිවර්තනය වනු ඇතැයි අපේක්ෂා කෙරේ.
        </p>
        <p>
            ගෝලීය ටෙලිකොම් කළමණාකරන සේවා ප්‍රවණතාව දැනටමත් උතුරු ඇමරිකාවේ සහ යුරෝපයේ දක්නට ලැබේ. ආසියා පැසිෆික් කලාපය ඉදිරි වසර 2-3 තුළ ඉතා ශීඝ්‍ර වර්ධන වේගයක් පෙන්වනු ඇත. ආසියා පැසිෆික් කලාපයේ වෙළඳපොළ බලගන්වනු ලබන්නේ:
        </p>
        <ul class="font-weight-bold">
            <li>අන්තර්ජාල හා ජංගම සේවාවන් ඉතා ශිඝ්‍රයෙන් ඉහළ යාම</li>
            <li>දත්ත මධ්‍යස්ථාන තුල යෙදවීමේ වැඩිවීම</li>
            <li>තාක්ෂණික සංවර්ධනයේ ශිඝ්‍ර වර්ධනය
            </li>
            <li>රජයේ අරමුදල්</li>
        </ul>
        <p>
            ටෙලිකොම් කළමණාකරන සේවා වෙළඳපොල 2017 දී ඇමරිකානු ඩොලර් බිලියන 11.90 සිට 2022 වන විට ඇමරිකානු ඩොලර් බිලියන 22.58 දක්වා වර්ධනය වනු ඇතැයි අපේක්ෂා කෙරේ. එහි සංයුක්ත වාර්ෂික වර්ධන අනුපාතය (Compound Annual Growth Rate - CAGR) 13.7% කි. කළමනාකරණ සේවා GTC හි ප්‍රධාන වර්ධන ධාවකයක් (driver) වනු ඇතැයි අපේක්ෂා කෙරේ.
        </p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(3, this)" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!------------ End Sinhala------------------>

    <!------------ Tamil------------------>
    <div id="dvTamil">
        <div class="section-title">
            <h3 class="text-center">மாறிவரும் தொழில்துறை நிலைமைகள்</h3>
            <div class="title-line-center"></div>
        </div>
        <p>சந்தை வேகமாக வளர்ந்து வருகிறதுடன் தொலைத்தொடர்பால் நிர்வகிக்கப்பட்ட சேவைகளுக்கான தேவை அதிகரித்து வருகிறது.</p>
        <img src="../../Images/industry.jpg" class="img-thumb" align="right" />
        <p>
            இந்நிர்வகிக்கப்பட்ட சேவைகள் ஐ.சி.டி(ICT) உள்கட்டமைப்பை பராமரிப்பதில் நிறுவனங்களுக்கு உதவுகின்றன, இதன் மூலம் நிறுவனங்கள் தங்கள் முக்கிய வணிக நடவடிக்கைகள் மற்றும் திட்டமிட்ட சந்தை மேம்பாட்டில் கவனம் செலுத்த உதவுகின்றன. ஃபார்ச்சூன் 500 நிறுவனங்களில் 80% நிறுவனங்கள் அடுத்த 5-6 ஆண்டுகளில் நிர்வகிக்கப்பட்ட சேவைகள் இயக்க மாதிரிக்குத் தம்மை மாற்றிக்கொள்ளும் என்று எதிர்பார்க்கப்படுகிறது.
        </p>
        <p>
            உலகளாவிய தொலைத்தொடர்பால் நிர்வகிக்கப்பட்ட சேவைகளின் போக்கு ஏற்கனவே வட அமெரிக்கா மற்றும் ஐரோப்பாவில் காணப்படுகிறது. ஆசியா பசிபிக்கில் அடுத்த 2-3 ஆண்டுகளில் மிக உயர்ந்த வளர்ச்சி விகிதத்தைக் காண்பிக்கும். ஆசியா பசிபிக் சந்தையின் ஊக்க சக்திகளாக இருப்பது:
        </p>
        <ul class="font-weight-bold">
            <li>இணையம் மற்றும் கைபேசி சேவைகளின் விரைவான அதிகரிப்பு</li>
            <li>தரவு மையங்களின் பயன்பாட்டு அதிகரிப்பு</li>
            <li>தொழில்நுட்ப மேம்பாட்டின் விரைவான வளர்ச்சி</li>
            <li>அரசு நிதி வழங்குதல்
            </li>
        </ul>
        <p>
            தொலைதொடர்பால் நிர்வகிக்கப்பட்ட சேவைகளின் சந்தை 2017 ஆம் ஆண்டில் 11.90 பில்லியன் அமெரிக்க டாலரிலிருந்து 2022 ஆம் ஆண்டில் 22.58 பில்லியன் அமெரிக்க டாலராக உயரும் என்று எதிர்பார்க்கப்படுகிறது, இது கூட்டு வருடாந்திர வளர்ச்சி விகிதத்தில் (கூவவவி) 13.7% ஆகும். நிர்வகிக்கப்பட்ட சேவைகள் ஜி.டி.சிக்கு ஒரு முக்கிய வளர்ச்சிக் காரணியாக இருக்கும் என்றும் எதிர்பார்க்கப்படுகிறது.
        </p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(3, this)" class="btns btn-submit">அடுத்து</a></div>
    </div>
    <!------------ End Tamil------------------>
    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

