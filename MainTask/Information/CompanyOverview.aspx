<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="CompanyOverview.aspx.vb" Inherits="Data_Information_CompanyOverview" %>

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

            //if ($("#hdnFlagPageToOpen").val() == "3") {
            //    f1();
            //}
            //else {
            //    $("#theTime").hide();
            //}

            fnChangeDataBasedOnLanguage(1)
        });


        function f1() {

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
        <div class="position-relative mb-2">
            <div class="section-title">
                <h3 class="text-center">About the Company</h3>
                <div class="title-line-center"></div>
            </div>
            <%--   <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>--%>
        </div>
        <img src="../../Images/overview.jpg" class="img-thumb pull-right" />
        <p>Nexus Infrastructure Solutions is a visionary force in the realm of infrastructure development, driven by an unwavering commitment to innovation and excellence. Established 3 decade ago, the company has carved its niche as a trailblazer in crafting world-class infrastructure solutions across diverse sectors.</p>
        <p><strong>Areas of Expertise:</strong></p>
        <p><strong>Transportation</strong>: Nexus specializes in designing and constructing transportation networks that facilitate the movement of people and goods, including roads, bridges, tunnels, railways, and airports.</p>
        <p><strong>Energy</strong>: We are leaders in the development of sustainable energy infrastructure, including renewable energy projects, power grids, and smart infrastructure solutions.</p>
        <p><strong>Water and Sanitation</strong>: Nexus is committed to ensuring access to clean water and sanitation for all, designing and implementing water supply systems, wastewater treatment facilities, and water conservation initiatives.</p>
        <p><strong>Telecommunications</strong>: We provide comprehensive telecommunications infrastructure solutions, including fiber optic networks, mobile towers, and satellite communications systems, to connect people and businesses around the globe.</p>
        <p><strong>Urban Development</strong>: Nexus specializes in urban development projects that promote sustainable growth and livability, including mixed-use developments, green spaces, and smart city initiatives.</p>
        <p><strong>Recent Developments:</strong></p>
        <p>Nexus's growth trajectory resembles a meteoric rise, propelled by its relentless pursuit of excellence and forward-thinking strategies. With each passing year, the company has not only expanded its footprint but also revolutionized the industry landscape through groundbreaking initiatives.</p>
        <p><strong>Strategic Public-Private Partnerships (PPP): </strong>Nexus recognizes the power of collaboration and has spearheaded numerous strategic public-private partnerships to fuel its growth engine. By synergizing resources and expertise, these partnerships have unlocked new avenues for innovation and accelerated the pace of infrastructure development. Some of the key projects include Metro Extension Project in Hyderabad, Upgradation of State Highways in Jaipur and Dharwad, etc</p>
        <p><strong>Automation and Robotics: </strong>Nexus stands at the forefront of technological advancement, leveraging automation and robotics to enhance efficiency, productivity, and safety across its manufacturing sites and wastewater treatment plants. Some examples are usage of remote I/O systems to monitor the wastewater route, harnessing decarbonization solutions for energy efficiencies, etc</p>
        <p><strong>Make in India Focus</strong>: Nexus takes pride in its strong 'Make in India' focus, championing indigenous manufacturing and fostering economic growth through investment in own capabilities as well as through national and international partnerships. It has partnered with the GoI to strengthen industrial corridors and in the upgradation of infrastructure in industrial clusters.</p>
        <p><strong>Global Expansion and Strategic Acquisitions</strong>: Nexus's quest for innovation knows no bounds. The company is actively exploring build-versus-buy options globally, strategically acquiring cutting-edge technology firms to augment its capabilities across various business lines to stay ahead of the curve and deliver unparalleled value to its clients.</p>

        <div class="text-center mt-3 mb-3" ><a href="#" onclick="fnMenu(2, this)" id="btnNext" class="btns btn-submit">Next</a></div>
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
        <img src="../../Images/overview.jpg" class="img-thumb pull-right" />
        <p>GTC didirikan pada tahun 2001 dan memulai bisnis layanan telekomunikasi dengan meluncurkan layanan seluler di Malaysia. GTC kini telah dikenal sebagai salah satu perusahaan telekomunikasi terbaik dan merupakan salah satu dari lima operator nirkabel (wireless) terbaik di dunia. GTC memiliki sekitar 100 juta pelanggan di seluruh ASIA dengan pendapatan sebesar 26,7 miliar MYR pada FY18-19. GTC beroperasi di 9 negara secara global dengan aktivitas yang signifikan di Malaysia, Sri Lanka, Indonesia, Bangladesh, Kamboja, dan Nepal. Dalam beberapa tahun terakhir, GTC telah melakukan diversifikasi ke bidang-bidang bisnis yang marak berkembang di ekonomi Asia yang berkembang dengan pesat. </p>
        <p>Kini GTC berupaya untuk bertransformasi dari ‘digital first’ menjadi ‘digital-throughout’ dan mengembangkan kapabilitas untuk lini pendapatan baru yang muncul sebagai dampak dari krisis COVID-19.  Mobilitas bisnis konvensional GTC tidak menghasilkan pendapatan yang memadai, sehingga GTC perlu membangun keahlian untuk memberikan value propositions baru kepada pelanggan.</p>
        <div class="row">
            <div class="col-7">
                <p>Pasar telekomunikasi yang dulu dikenal kini sedang bergejolak. Sementara klien korporat berupaya mengurangi pengeluaran telekomunikasi mereka dengan menyesuaikan daya beli mereka dan mengganti layanan telekomunikasi tradisional dengan produk yang lebih baru seperti penggunaan VoIP (Voice over Internet Protocol) untuk melakukan panggilan, usaha kecil dan menengah (UKM) akan mendominasi pasar telekomunikasi. Sektor UKM saat ini berkontribusi sebanyak 45% atas pendapatan GTC yang berasal dari klien bisnis. Namun demikian, dalam lima tahun ke depan, angka tersebut diperkirakan akan melonjak menjadi sekitar 70%.</p>
                <h4 class="small-heading">POTRET & PROYEKSI ATAS PERFORMA</h4>
                <p>GTC menunjukkan hasil yang sangat baik, dengan 17.2% pertumbuhan pendapatan dan mencapai seluruh target KPI, serta mengumumkan 60% rasio pembayaran dividen untuk FY19-20 dibandingkan dengan 50% di FY 18-19. Peningkatan yang baik untuk pasar ASEAN juga tercatat pada FY 19-20.</p>
            </div>
            <div class="col-5">
                <img src="../../Images/L3-overviewPerformance-indonesian.jpg" class="img-thumbnail" />
            </div>
        </div>
        <div class="text-center mt-3"><a href="#" onclick="fnMenu(2, this)" class="btns btn-submit">Selanjutnya</a></div>
    </div>
    <!------------End Indonesia----------------->

    <!------------ Sinhala------------------>
    <div id="dvSinhala">
        <div class="position-relative mb-2">
            <div class="section-title">
                <h3 class="text-center">සමාගම් දළ විශ්ලේෂණය</h3>
                <div class="title-line-center"></div>
            </div>
            <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>
        </div>
        <img src="../../Images/overview.jpg" class="img-thumb pull-right" />
        <p>GTC ආයතනය 2001 දී ආරම්භ කරන ලද අතර මැලේසියාවේ ජංගම දුරකථන සේවා දියත් කරමින් ටෙලිකොම් සේවා ව්‍යාපාරය ආරම්භ කළේය. GTC ආයතනය ඉහළම ටෙලිකොම් සමාගම් වලින් එකක් වන අතර එය ලොව හොඳම රැහැන් රහිත ක්‍රියාකරුවන් පස් දෙනා අතර වේ. එයට ආසියා කලාපය පුරා දළ වශයෙන් මිලියන 100 ක ග්‍රාහකයින් සංඛ්‍යාවක් සිටින අතර 18-19 මුදල් වර්ෂයේදී MYR බිලියන 26.7 ක ආදායමක් ලබා ඇත. මැලේසියාව, ශ්‍රී ලංකාව, ඉන්දුනීසියාව, බංග්ලාදේශය, කාම්බෝජය සහ නේපාලය යන රටවල සැලකිය යුතු මට්ටමක තම කටයුතු කරමින් සිටින GTC ආයතනය ගෝලීය වශයෙන් රටවල් 9 ක මෙහෙයුම් කටයුතු සිදු කරයි. පසුගිය වසර කිහිපය තුළ, වේගයෙන් ව්‍යාප්ත වන ආසියානු ආර්ථිකය තුළ GTC ආයතනය නැගී එන ව්‍යාපාරික අංශ වෙත විවිධාංගීකරණය වී තිබේ.</p>
        <p>GTC ආයතනය දැන් ‘ඩිජිටල්-ෆස්ට්’ සංකල්පයේ සිට ‘ඩිජිටල්-පුරාවටම’ [‘digital-first’ to ‘digital-throughout’] සංකල්පයට පරිවර්තනය කිරීමට සහ COVID-19 අර්බුදයෙන් මතුවන නව ආදායම් මාර්ග සඳහා හැකියාවන් ගොඩනැගීමට අපේක්ෂා කරයි. GTC ආයතනයේ හි සාම්ප්‍රදායික සංචලතා ව්‍යාපාරය [conventional mobility business] ප්‍රමාණවත් ආදායමක් උපයන්නේ නැත, එබැවින් සේවාදායකයින් සඳහා නව වටිනාකම් යෝජනා සඳහා විශේෂඥ දැනුම ගොඩනැගීමේ අවශ්‍යතාවය වැටහි ඇත.</p>
        <div class="row">
            <div class="col-7">
                <p>පෙර පැවති සුපුරුදු ටෙලිකොම් වෙළඳපොල විපරිණාමී [market is in flux] ප්‍රවාහ අවධියේ පවතී. විශාල ආයතනික ගනුදෙනුකරුවන් ඔවුන්ගේ ටෙලිකොම් වියදම් කපා හරිමින් ඔවුන්ගේ මිලදී ගැනීමේ ශක්තිය උපයෝගි කරමින් සාම්ප්‍රදායික ටෙලිකොම් සේවාවන් වෙනුවට නව නිෂ්පාදනයක් වන VoIP තාක්ෂණය (Voice over Internet Protocol) භාවිතා කරන ඇමතුම් සැලසුම් මිලට ගැනිම, කුඩා හා මධ්‍ය පරිමාණ ව්‍යවසායන් (SME) ටෙලිකොම් වෙළඳපොලේ ආධිපත්‍යය දැරීමට සූදානම් වෙමින් පවති. සුළු හා මධ්‍ය පරිමාණ ව්‍යාපාර අංශය දැනට GTC ආයතනික ව්‍යාපාරික-සේවාදායක ආදායමෙන් 45% ක් පමණ සපයයි. කෙසේ වෙතත්, ඉදිරි වසර පහ තුළ එම අගය 70% ක් දක්වා ඉහළ යනු ඇතැයි පුරෝකථනය කර ඇත.</p>
                <h4 class="small-heading">කාර්ය සාධන සාරාංශය සහ පුරෝකථනයන් </h4>
                <p>සියළුම KPI සාක්ෂාත් කර ගැනීම සඳහා GTC ආයතනය 17.2% ක ආදායම් වර්ධනයක් සමඟ 19-20 මුදල් වර්ෂය සඳහා 60% ක ලාභාංශ ගෙවීමේ අනුපාතය [Dividend Payout Ratio] ප්‍රකාශයට පත් කර ඇත්තේ 18-19 මුදල් වර්ෂයේ ප්‍රකාශයට පත් කල 50% ක ලාභාංශ ගෙවීමේ අනුපාතයට සාපේක්ෂවයි. ව්‍යාපාරික සමූහයේ ආසියානු  වෙළඳපොළ හි යහපත් වර්ධනයක් FY19-20 හි වාර්තා විය.</p>
            </div>
            <div class="col-5">
                <img src="../../Images/L3-overviewPerformance-Sinhala.jpg" class="img-thumbnail" />
            </div>
        </div>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(2, this)" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!-------------End Sinhala-------------------------->

    <!------------ Tamil------------------>
    <div id="dvTamil">
        <div class="position-relative mb-2">
            <div class="section-title">
                <h3 class="text-center">நிறுவனத்தின் கண்ணோட்டம்</h3>
                <div class="title-line-center"></div>
            </div>
            <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>
        </div>
        <img src="../../Images/overview.jpg" class="img-thumb pull-right" />

        <p>ஜி.டி.சி 2001 இல் நிறுவப்பட்டது மற்றும் மலேசியாவில் மொபைல் சேவைகளைத் தொடங்குவதன் மூலம் அதன் தொலைத் தொடர்பு சேவை வணிகத்தைத் தொடங்கியது. ஜி.டி.சி சிறந்த தொலைத் தொடர்பு நிறுவனங்களில் ஒன்றாகும், இது உலகின் முதல் ஐந்து வயர்லெஸ் ஆபரேட்டர்களில் ஒன்றாகும். இது ஆசிய நாடுகளில் சுமார் 100 மில்லியன் சந்தாதாரர்களைக் கொண்டுள்ளது மற்றும் 18-19 நிதியாண்டில் மலேசிய ரிங்கிட் 26.7 பில்லியன் வருவாய் ஈட்டியுள்ளது. ஜி.டி.சி உலகளவில் 9 நாடுகளில் செயல்பட்டு வருகிறது அதில் குறிப்பிடத்தக்க இருப்பை மலேசியா, இலங்கை, இந்தோனேசியா, பங்களாதேஷ், கம்போடியா மற்றும் நேபாளம் ஆகிய நாடுகளில் கொண்டுள்ளது.. கடந்த சில ஆண்டுகளில், ஜி.டி.சி வேகமாக வளர்ந்து வரும் ஆசிய பொருளாதாரத்தில் வளர்ந்து வரும் வணிக பகுதிகளில் பல்வேறு பரிணாமங்களை அடைந்துள்ளது</p>
        <p>ஜி.டி.சி இப்போது ‘டிஜிட்டல்-ஃபர்ஸ்ட் (digital-first)’ இலிருந்து ‘டிஜிட்டல்-முழுவதும் (digital-throughout)’ ஆக மாறுவதற்கும், கோவிட் -19 நெருக்கடியிலிருந்து வெளிவரும் புதிய வருவாய் நீரோட்டங்களுக்கான திறன்களை உருவாக்குவதற்கும் முயல்கிறது. ஜி.டி.சியின் வழக்கமான இயக்கம் வணிகம்  (conventional mobility business) போதுமான வருவாயை ஈட்டவில்லை, எனவே வாடிக்கையாளர்களுக்கு புதிய மதிப்பை உருவாக்க நிபுணத்துவத்தை உருவாக்க வேண்டும்.</p>
        <div class="row">
            <div class="col-7">
                <p>ஒருமுறை பழக்கமான தொலைத் தொடர்பு சந்தை பாய்மையில் (flux) உள்ளது. பெரிய பெருநிறுவன வாடிக்கையாளர்கள் தங்களது தொலைதொடர்பு செலவினங்களை தங்கள் கொள்முதல் சக்தியை நெகிழ (flexing) வைப்பதன் மூலமும், பாரம்பரிய தொலைத்தொடர்பு சேவைகளை மாற்றுவதன் மூலமும் VoIP (வாய்ஸ் ஓவர் இன்டர்நெட் புரோட்டோகால்), சிறு மற்றும் நடுத்தர நிறுவனங்கள் (SME) தொலைத் தொடர்பு சந்தையில் ஆதிக்கம் செலுத்துகின்றன. சிறு மற்றும் நடுத்தர நிறுவனங்கள் SME தற்போது ஜி.டி.சி இன் வணிக-வாடிக்கையாளர் வருவாயில் 45% வழங்குகிறது. இருப்பினும், அடுத்த ஐந்து ஆண்டுகளில், அந்த எண்ணிக்கை சுமார் 70% ஆக உயரும் என்று கணிக்கப்பட்டுள்ளது.</p>
                <h4 class="small-heading">செயல்திறன் ஸ்னாப்ஷாட் (SNAPSHOT) மற்றும் திட்டங்கள்</h4>
                <p>அனைத்து கேபிஐகளையும் (KPIs) அடைய ஜிடிசி 17.2% வருவாய் வளர்ச்சியுடன் முடிவுகளை வெளியிட்டது மற்றும் நிதியாண்டு 19-20க்கான 60% ஈவுத்தொகை (Dividend) செலுத்தும் விகிதத்தை நிதியாண்டு 19-19க்கான ஈவுத்தொகை (Dividend) செலுத்தும் விகிதம் FY18-19 இல் 50% உடன் ஒப்பிடும்போது. குழுவின் ஆசியான் சந்தைகளில் (Group’s ASEAN markets) FY19-20 இல் நல்ல முன்னேற்றங்கள் பதிவு செய்யப்பட்டுள்ளன என்பதை இது குறிக்கிறது</p>
            </div>
            <div class="col-5">
                <img src="../../Images/L3-overviewPerformance-tamil.JPG" class="img-thumbnail" />

            </div>
        </div>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(2, this)" class="btns btn-submit">அடுத்து </a></div>
    </div>
    <!-------------End Tamil-------------------------->

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

