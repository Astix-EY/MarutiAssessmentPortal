<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Panel.master" AutoEventWireup="false" CodeFile="Groupoverview.aspx.vb" Inherits="Data_Information_Groupoverview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>

    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "MyTask.aspx";
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

            //function FnUpdateTimer() {
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
        <div class="position-relative mb-2">
            <div class="section-title">
                <h3 class="text-center">GROUP OVERVIEW</h3>
                <div class="title-line-center"></div>
            </div>
            <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>
        </div>
        <img src="../../Images/overview.jpg" class="img-thumb pull-right" />
        <p>GTC was founded in 2001 and started its telecom services business by launching mobile services in Malaysia. GTC is one of the top telecom companies and is amongst the top five wireless operators in the world. It has approximately 100 million subscribers across ASIA and a revenue of MYR 26.7 billion in FY18-19. GTC has operations in 9 countries globally with significant presence in Malaysia, Sri Lanka, Indonesia, Bangladesh, Cambodia and Nepal. Over the last few years, GTC has diversified into emerging business areas in the fast expanding Asian economy.</p>
        <p>GTC is now looking to transform from ‘digital-first’ to ‘digital-throughout’ and build capabilities for new revenue streams emerging out of the COVID-19 crisis. GTC’s conventional mobility business is not generating enough revenue hence the need to build expertise for new value propositions to clients.</p>
        <img src="../../Images/overviewPerformance.jpg" class="img-thumb pull-right" width="150px" height="250px" />
        <p>The once familiar telecom market is in flux. While the large corporate clients seem to be cutting back on their telecom spending by flexing their purchasing power and replacing traditional telecom services with newer products such as calling plans that use the VoIP (Voice over Internet Protocol), the small and medium enterprises (SME) are set to dominate the telecom market. The SME sector currently provides about 45% of GTC’s business-client revenues. In the next five years, however, that figure is forecasted to surge to about 70%.</p>
        <h4 class="small-heading">PERFORMANCE SNAPSHOT & PROJECTIONS</h4>
        <p>GTC posted stellar results with 17.2% Revenue Growth to achieve all KPIs and declared 60% Dividend Payout Ratio for FY19-20 compared to 50% in FY18-19. Good improvements were recorded in FY19-20 in the Group’s ASEAN markets. </p>
        
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(2, this)" id="btnNext" class="btns btn-submit">Next</a></div>
    </div>
    <!-------------End English-------------------------->

    <!---------------Indonesia------------------>
    <div id="dvIndonesia" style="display: none">
        <div class="position-relative mb-2">
            <div class="section-title">
                <h3 class="text-center">GAMBARAN UMUM PERUSAHAAN</h3>
                <div class="title-line-center"></div>
            </div>
            <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>
        </div>
        <p>GTC didirikan pada tahun 2001 dan memulai bisnis layanan telekomunikasi dengan meluncurkan layanan seluler di Malaysia. GTC kini telah dikenal sebagai salah satu perusahaan telekomunikasi terbaik dan merupakan salah satu dari lima operator nirkabel (wireless) terbaik di dunia. GTC memiliki sekitar 100 juta pelanggan di seluruh ASIA dengan pendapatan sebesar 26,7 miliar MYR pada FY18-19. Pertumbuhan keseluruhan pada FY19-20 adalah sebesar 17,2%.</p>
        <img src="../../Images/overview.jpg" class="img-thumb" align="left" />
        <p>GTC beroperasi di 9 negara secara global dengan aktivitas yang signifikan di Malaysia, Sri Lanka, Indonesia, Bangladesh, Kamboja, dan Nepal. Dalam beberapa tahun terakhir, GTC telah melakukan diversifikasi ke bidang-bidang bisnis yang marak berkembang di ekonomi Asia yang berkembang dengan pesat. GTC memiliki aspirasi untuk menjadi New Generation Digital Champion pada tahun 2022 dan telah memperluas portofolionya dimulai dari aset seluler murni menjadi Digital Telco, Bisnis Digital, dan Infrastruktur. Produk-produk utama GTC saat ini telah memiliki konektivitas dan produk-produk ICT. GTC menjual produk-produk tersebut pada pasar melalui jalur Layanan Pengelolaan Lengkap (Managed Services) atau sebagai produk & solusi individual.</p>
        <p>Faktor yang membedakan GTC dari perusahaan lainnya adalah kemampuan GTC dalam membangun kemitraan yang kuat. Selama bertahun-tahun, beberapa perusahaan ternama dalam bisnis internasional telah bermitra dengan GTC. Sebagai hasil dari kemitraan terbaru dengan MSoft, GTC telah menciptakan sebuah pengalaman pelanggan (customer experience) baru melalui teknologi canggih berbasis AI dan ML. Kemitraan ini telah diterapkan secara global dan implementasi pertama yang sukses telah dilakukan di Malaysia dengan umpan balik dari pelanggan yang luar biasa.</p>
        <div class="text-center mt-3"><a href="#" onclick="fnMenu(2, this)" class="btns btn-submit">Selanjutnya</a></div>
    </div>
    <!------------End Indonesia----------------->

    <!------------ Sinhala------------------>
    <div id="dvSinhala">
        <div class="position-relative mb-2">
            <div class="section-title">
                <h3 class="text-center">සමාගම් පැතිකඩ</h3>
                <div class="title-line-center"></div>
            </div>
            <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>
        </div>
        <p>2001 වර්ෂයේ දී GTC ආයතනය පිහිටුවන ලද අතර  මැලේසියාව තුල  එහි ජංගම සේවා දියත් කරමින් ටෙලිකොම් සේවා ව්‍යාපාරය ආරම්භ කෙරිණී. මේ වන විට ප්‍රබල ටෙලිකොම් සමාගම් අතරින් එකක් බවට GTC ආයතනය පත්ව ඇති අතර එය ලොව හොඳම රැහැන් රහිත ක්‍රියාකරුවන් (wireless operators) පස් දෙනා අතරට ද පැමිණ ඇත. ආසියාව පුරා දළ වශයෙන් මිලියන 100 ක ග්‍රාහකයින් සංඛ්‍යාවක් සිටින අතර මැලේසියානු රින්ගිට් (MYR) බිලියන 26.7 ක ආදායමක් 18/19 මුල්‍ය වර්ෂයේදී ලබා ඇත. 19/20 මුල්‍ය වර්ෂයේ දී සමස්ත වර්ධනය 17.2% කි. </p>
        <img src="../../Images/overview.jpg" class="img-thumb" align="left" />
        <p>ගෝලීය වශයෙන් රටවල් 9 ක GTC ආයතනය මෙහෙයුම් කටයුතු  සිදුකරන අතර  මැලේසියාව, ශ්‍රී ලංකාව, ඉන්දුනීසියාව, බංගලාදේශය, කාම්බෝජය සහ නේපාලය යන රටවල සැලකිය යුතු මට්ටමක මෙහෙයුම් කටයුතු පවත්වාගෙන යනු ලබයි. පසුගිය වසර කිහිපය තුළ, ශීඝ්‍රයෙන් ව්‍යාප්ත වන ආසියානු ආර්ථිකය තුළ නැගී එන ව්‍යාපාරික අංශ වෙත GTC විවිධාංගීකරණය විය. 2022 වන විට නව පරම්පරාවේ ඩිජිටල් ශූරයකු වීමට GTC ආයතනය අපේක්ෂා කරන අතර pure-play mobile assets වල සිට ඩිජිටල් ටෙල්කෝ, ඩිජිටල් ව්‍යාපාර සහ යටිතල පහසුකම් දක්වා සිය සේවා කළඹ (portfolio) පුළුල් කර ඇත. ප්‍රධාන GTC නිෂ්පාදන වලට - සම්බන්ධතා සහ ICT නිෂ්පාදන යන දෙකම දැන් ඇතුළත් වේ. ඔවුන් මෙම නිෂ්පාදන කළමනාකරණ සේවා මාර්ගය (Managed Services route) හරහා හෝ කේවල නිෂ්පාදන සහ විසඳුම් ලෙස වෙළඳපොලේ විකුණනු ලැබේ.  </p>
        <p>GTC ආයතනය අනෙක් ආයතන වලට වඩා වෙනස් වන්නේ ශක්තිමත් හවුල්කාරිත්වයක් නිර්මාණය කිරීමට ඇති හැකියාව නිසාය. වසර ගණනාවක් පුරා, ජාත්‍යන්තර ව්‍යාපාරයන් හී  දැවැන්ත නම් සමහරක් GTC ආයතනය සමඟ හවුල් වී ඇත. MSoft සමඟ මෑතකදී ඇතිකර ගත් හවුල්කාරිත්වයේ ප්‍රතිඵලයක් ලෙස උසස් AI සහ ML පදනම් කරගත් තාක්ෂණයන් තුළින් නව පාරිභෝගික අත්දැකීමක් නිර්මාණය කිරීමට GTC ආයතනය සමත් වී තිබේ. මෙම හවුල්කාරිත්වය මේ වන විටත් ගෝලීයව ක්‍රියාත්මක කර ඇති අතර පළමු සාර්ථක ක්‍රියකාරකම මැලේසියාව තුල විශාල පාරිභෝගික ප්‍රතිචාරයක් සමඟ ක්‍රියාත්මක කරන ලදි.</p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(2, this)" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!-------------End Sinhala-------------------------->

    <!------------ Tamil------------------>
    <div id="dvTamil">
        <div class="position-relative mb-2">
            <div class="section-title">
                <h3 class="text-center">நிறுவனம் – ஒரு பார்வை </h3>
                <div class="title-line-center"></div>
            </div>
            <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>
        </div>
        <p>2001 இல் நிறுவப்பட்ட மலேசியாவில் ஜி.டி.சி  மொபைல் சேவைகளை வழங்குவதன் மூலம் தொலைத் தொடர்பு வணிகத்தைத் தொடங்கியது. ஜி.டி.சி இப்போது சிறந்த தொலைத் தொடர்பு நிறுவனங்களில் ஒன்றாக உருவெடுத்துள்ளதுடன் தொலைத் தொடர்பு உலகின் முதல் ஐந்து வயர்லெஸ் ஆபரேட்டர்களில் ஒன்றாகும். இது ஆசியா முழுவதும் சுமார் 100 மில்லியன் சந்தாதாரர்களைக் கொண்டுள்ளது. 2018-19 நிதியாண்டில் MYR 26.7 பில்லியன் வருவாய் ஈட்டியுள்ளது. நிதியாண்டு 2019 - 20 இல் ஒட்டுமொத்த வளர்ச்சி 17.2% ஆகும்.</p>
        <img src="../../Images/overview.jpg" class="img-thumb" align="left" />
        <p>மலேசியா, இலங்கை, இந்தோனேசியா, பங்களாதேஷ், கம்போடியா மற்றும் நேபாளம் ஆகிய நாடுகளில் ஜி.டி.சி ஆதிக்கம் செலுத்துவதுடன் உலகளவில் 9 நாடுகளில் செயல்பட்டு வருகிறது. கடந்த சில ஆண்டுகளில், வேகமாக விரிவடைந்து வரும் ஆசிய பொருளாதாரத்தில், வளர்ந்து வரும் வணிக செயற்பாடுகளில் பன்முகப்படுத்தியுள்ளது. ஜிடிசி 2022 ஆம் ஆண்டளவில் ஒரு புதிய தலைமுறை டிஜிட்டல் சாம்பியனாக விரும்புகிறது, மேலும் அதன் போர்ட்ஃபோலியோவை (Portfolio) தூய்மையான விளையாட்டு மொபைல் சொத்துக்களிலிருந்து டிஜிட்டல் டெல்கோ (Digital Telco), டிஜிட்டல் வணிககள் (Digital Business) மற்றும் உள்கட்டமைப்பு வரை விரிவுபடுத்தியுள்ளது. இணைப்புச் சாதனங்கள் மற்றும் ஐ.சி.டி தயாரிப்புகள் ஆகியவை முக்கிய ஜி.டி.சி தயாரிப்புகளாகும். அவர்கள் இந்த தயாரிப்புகளை நிர்வகிக்கப்பட்ட சேவை வழியாக அல்லது தனிப்பட்ட தயாரிப்புகள் மற்றும் தீர்வுகளாக சந்தையில் விற்கிறார்கள்.</p>
        <p>வலுவான கூட்டமைப்பு உருவாக்குவதற்கான அதன் திறன், ஜி.டி.சியை மற்றவர்களிடமிருந்து வேறுபடுத்துகிறது. கடந்த காலங்களில், சர்வதேச வணிகத்தில் சில பெரிய நிறுவனங்கள் ஜி.டி.சி உடன் கூட்டு சேர்ந்துள்ளன. எம்.சொப்டுடனான சமீபத்திய கூட்டணியின் விளைவாக, மேம்பட்ட ஏ.ஐ மற்றும் எம்.எல் அடிப்படையிலான தொழில்நுட்பங்கள் மூலம் ஜி.டி.சி புதிய வாடிக்கையாளர் அனுபவத்தை உருவாக்கியுள்ளது. இந்த கூட்டணி ஏற்கனவே உலகளவில் செயல்படுத்தப்பட்டுள்ளதுடன் முதல் வெற்றிகரமான செயல்படுத்தல் மலேசியாவில் சிறந்த வாடிக்கையாளர் கருத்துகளுடன் முன்னெடுகப்பட்டுள்ளது. </p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(2, this)" class="btns btn-submit">அடுத்து </a></div>
    </div>
    <!-------------End Tamil-------------------------->

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

