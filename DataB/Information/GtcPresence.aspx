<%@ Page Title="" Language="VB" MasterPageFile="~/DataB/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="GtcPresence.aspx.vb" Inherits="Data_Information_GtcPresence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "MarketOverview.aspx";
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
    <time id="theTime" class="fst-color" style="display: none">Reading Time Left  00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English--------------->
    <div id="dvEnglish">
               <div class="section-title">
            <h3 class="text-center">Growth Plans</h3>
            <div class="title-line-center"></div>
        </div>
        <%--   <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>--%>

        <img src="../../Images/Growth.jpg" class="img-thumb pull-right" />
        <p>The company's financial and strategic growth highlights are structured as follows:</p>
        <p>The company has achieved a revenue milestone of ₹15,000 crores and has set an ambitious target to double this figure within the next five years, demonstrating a strong commitment to growth and value creation. The financial track record showcases a robust 3-year Compound Annual Growth Rate (CAGR) of 19.8%, coupled with a 5-year CAGR of 13.6%, reflecting consistent and substantial growth over time.</p>
        <p><strong>Strategic goals: </strong></p>
        <p>In order to achieve their target, the organisation&rsquo;s roadmap include:</p>
        <p><strong>Investment in R&amp;D:</strong> The company allocates 7% of its annual revenue to Research and Development (R&amp;D), with plans to scale this investment in line with their growth objectives.</p>
        <p><strong>Market Expansion</strong>: The organisation is pursuing aggressive growth plans that include capacity building in untapped Indian markets and strategic acquisitions.</p>
        <p><strong>Diversification:</strong> Their strategy also involves entering new verticals, such as electric mobility and smart home ecosystems.&nbsp;</p>
        <p><strong>Technology:</strong> The organisation is committed to leveraging digital transformation and Industry 4.0 principles to streamline their operations and enhance product offerings.&nbsp;</p>
        <p><strong>Partnerships:</strong> The company is actively forging alliances with both tech startups and established industry players to foster co-innovation and deepen market penetration&nbsp;</p>
        <p><strong>Employee Development: </strong>It has implemented digital upskilling programs and innovation labs to foster a culture of continuous learning.<strong>&nbsp;</strong></p>
        <p><strong>Corporate Social Responsibility (CSR): </strong>The company's commitment to social responsibility and environmental stewardship is demonstrated through the following initiatives:</p>
        <ul>
            <li><strong>Community Engagement:</strong> The company is actively involved in enhancing digital literacy by implementing programs aimed at improving technology skills in rural areas. Additionally, it supports tech entrepreneurship in these communities, empowering individuals to leverage digital tools for economic growth and innovation.</li>
            <li><strong>Environmental Stewardship:</strong> The organisation&rsquo;s investment in digital tools for environmental monitoring and resource optimization reflects their dedication to sustainable practices. These tools enable it to minimize its ecological footprint while maintaining operational efficiency and promoting the responsible use of natural resources.</li>
        </ul>
        <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">Next</a></div>
    </div>
    <!------------ End English--------------->

    <!------------ Indonesia--------------->
    <div id="dvIndonesia" style="display: none">
        <div class="section-title">
            <h3 class="text-center">KEHADIRAN GTC DI INDUSTRI PENDIDIKAN</h3>
            <div class="title-line-center"></div>
        </div>
        <%--<h4 class="small-heading">GTC’s growing leadership presence in the Education industry</h4>--%>
        <p>GTC telah membangun kredibilitas operasi jaringannya dan memenangkan lebih dari 15 kontrak dengan institusi pendidikan selama 3-4 bulan terakhir. Secara bertahap, kontrak-kontrak tersebut kini diperpanjang, yang awalnya hanya operasi jaringan, namun sekarang meliputi domain yang lebih besar yaitu layanan Teknologi Informasi dan Komunikasi (ICT). Investasi di bidang TIK pendidikan dapat memberikan imbalan ekonomi yang besar bagi Malaysia.</p>
        <p>GTC telah melakukan diversifikasi portofolio produk untuk memberikan penawaran yang lebih relevan dan dapat disesuaikan untuk klien industri pendidikan:</p>
        <p><strong>1. Tarif nol  (zero rating)</strong></p>
        <p>GTC telah menyampaikan bahwa data terkait situs web atau aplikasi pendidikan spesifik tidak akan dikenakan tarif, dengan kata lain tidak ada biaya yang dibebankan ketika situs atau aplikasi tersebut diakses.</p>
        <p><strong>2. Meningkatkan batas data</strong></p>
        <p>GTC meningkatkan batasan data untuk program konektivitas pendidikan, misalnya seorang pelajar biasanya memperoleh 4GB data secara gratis; sekarang pelajar tersebut dapat memperoleh 8GB.</p>
        <p><strong>3. Mendistribusikan perangkat pada komunitas</strong></p>
        <p>Kementerian pendidikan bekerja sama dengan GTC untuk membantu pemberian perangkat bagi pelajar dan tenaga pendidik melalui berbagai cara, tidak terbatas pada pengadaan dan pengiriman perangkat baru saja, namun juga dalam hal inventori, persiapan, dan distribusi perangkat dari sekolah untuk penggunaan di rumah.</p>
        <p><strong>4. Hotspot publik, dan mengaktifkan kembali layanan dan perangkat lama</strong></p>
        <p>GTC mempersiapkan lokasi publik untuk dapat mengakses Wi-Fi secara gratis dalam kemitraan dengan pemerintah Malaysia, dimana pelajar dapat mendatangi lokasi tersebut untuk mengunggah atau mengunduh data.</p>
        <p><strong>5. Kampanye SMS dan dukungan call center</strong></p>
        <p>Kementerian Pendidikan bekerjasama dengan GTC untuk mendukung kampanye peningkatan kesadaran terkait pembelajaran online melalui SMS dan dengan cepat mempersiapkan call center sebagai helpdesk untuk membantu tenaga pengajar, pelajar, dan keluarga pelajar di lokasi terpencil.</p>
        <p><strong>6. Kartu SIM gratis</strong></p>
        <p>GTC menyediakan SIM Card gratis untuk digunakan oleh tenaga pengajar dan pelajar, dengan prosedur registrasi yang dipermudah dan dilengkapi paket data spesial.</p>


        <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">Selanjutnya</a></div>

    </div>
    <!------------ End Indonesia--------------->

    <!------------ Sinhala--------------->
    <div id="dvSinhala" style="display: none">
        <div class="section-title">
            <h3 class="text-center">උප ටැබ්- අධ්‍යාපන ක්ෂේත්‍රයේ GTC හි ස්ථාවරය</h3>
            <div class="title-line-center"></div>
        </div>
        <%--<h4 class="small-heading">GTC’s growing leadership presence in the Education industry</h4>--%>
        <p>GTC ආයතනය සිය ජාල මෙහෙයුම් විශ්වසනීයත්වය මත ගොඩනගා ඇති අතර පසුගිය මාස 3-4 තුළ අධ්‍යාපන ආයතන සමඟ ගිවිසුම් 15 කට වැඩි ප්‍රමාණයක් දිනා ගෙන ඇත. මෙම කොන්ත්‍රාත්තු දැන් වැඩි වැඩියෙන් ජාල මෙහෙයුම්වල සිට තොරතුරු හා සන්නිවේදන තාක්‍ෂණ (ICT) සේවාවන්හි විශාල වසම් දක්වා විහිදේ. තොරතුරු හා සන්නිවේදන තාක්ෂණ අධ්‍යාපනය සඳහා ආයෝජනය කිරීමෙන් මැලේසියාවට විශාල ආර්ථික ප්‍රතිලාභයක් ලබා ගත හැකිය.</p>
        <p>අධ්‍යාපන කර්මාන්තයේ සේවාදායකයින්ට අභිරුචිකරණ [customized] සේවාවක් හා වඩාත් අදාළ සේවාවක් ලබා දීම සඳහා GTC ආයතනය සිය නිෂ්පාදන කළඹ විවිධාංගීකරණය කර ඇත:</p>
        <p><strong>1. ශුන්‍ය ශ්‍රේණිගත කිරීම (Zero-rating)</strong></p>
        <p>GTC ආයතනය විසින් නම් කර ඇති නිශ්චිත අධ්‍යාපන වෙබ් අඩවි හෝ යෙදුම් වලට අදාළ දත්ත සඳහා ශුන්‍ය ගාස්තුවක් අය කිරිම. එනම්, මෙම වෙබ් අඩවි වෙත ප්‍රවේශ වන විට දත්ත ගාස්තු අය නොකෙරේ.</p>
        <p><strong>2. දත්ත සීමා ලිහිල් කිරිම [Lifting data caps]</strong></p>
        <p>GTC ආයතනය විසින් අධ්‍යාපන සම්බන්ධතා වැඩසටහන් වල දත්ත සීමා ලිහිල් කිරිම සිදු කරයි. උදා. මසකට 4GB නොමිලේ භාවිතා කළ හැකි ශිෂ්‍යයෙකුට, දැන් 8GB නොමිලේ භාවිතා කළ හැකිය.</p>
        <p><strong>3. ප්‍රජාව අතර උපාංග බෙදා හැරීම</strong></p>
        <p>අධ්‍යාපන අමාත්‍යාංශය, ඉගෙනුම්කරුවන්ගේ සහ ගුරුවරුන්ගේ අතට උපාංග ලබා දීමට GTC ආයතනය සමඟ විවිධාකාරයෙන් කටයුතු  කරයි. නව උපාංග මිලදී ගැනීම සහ ලබා දීම පමණක් නොව ගෘහ භාවිතය සඳහා පාසල් වලින් උපකරණ තොග [inventorying], සකස් කිරීම [preparing] සහ බෙදා හැරීම [distributing] ඒ කටයුතු අතර වේ.</p>
        <p><strong>4. පොදු Wi-Fi ප්‍රවේශ ස්ථාන (Hotspots), සහ පැරණි සේවා සහ උපාංග නැවත ආරම්භ කිරීම.</strong></p>
        <p>සිසුන්ට දත්ත උඩුගත කිරීමට (Upload) / බාගත කිරීමට (Download) GTC ආයතනය විසින් මැලේසියාවේ රජය සමඟ හවුල්ව නොමිලේ පොදු Wi-Fi ප්‍රවේශ ස්ථාන සකස් කරයි.</p>
        <p><strong>5. කෙටි පණිවුඩ ව්‍යාපාර සහ ඇමතුම් මධ්‍යස්ථාන සහාය</strong></p>
        <p>කෙටි පණිවුඩ හරහා Online ඉගෙනීම පිළිබද දැනුවත් කිරීමේ වැඩ සටහන් කිරිමට සහ දුරස්ථව සිටින ගුරුවරුන්ට, ඉගෙන ගන්නන්ට සහ ඔවුන්ගේ පවුල්වලට සහාය වීම සඳහා ඉක්මනින් ඇමතුම් මධ්‍යස්ථාන උපකාරක කවුළු [call centre helpdesks] පිහිටුවීම සදහා අධ්‍යාපන අමාත්‍යාංශය GTC ආයතනය සමඟ සහයෝගයෙන් කටයුතු කරයි.</p>
        <p><strong>6. නොමිලේ සිම් කාඩ්පත් ලබාදිම</strong></p>
        <p>කෙටි පණිවුඩ හරහා Online ඉගෙනීම පිළිබද දැනුවත් කිරීමේ වැඩ සටහන් කිරිමට සහ දුරස්ථව සිටින ගුරුවරුන්ට, ඉගෙන ගන්නන්ට සහ ඔවුන්ගේ පවුල්වලට සහාය වීම සඳහා ඉක්මනින් ඇමතුම් මධ්‍යස්ථාන උපකාරක කවුළු [call centre helpdesks] පිහිටුවීම සදහා අධ්‍යාපන අමාත්‍යාංශය GTC ආයතනය සමඟ සහයෝගයෙන් කටයුතු කරයි.</p>


        <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!------------ End Sinhala--------------->

    <!------------ Tamil--------------->
    <div id="dvTamil">
        <div class="section-title">
            <h3 class="text-center">கல்வித் தொழிலில் ஜி.டி.சி யின் இருப்பு</h3>
            <div class="title-line-center"></div>
        </div>
        <%--<h4 class="small-heading">GTC’s growing leadership presence in the Education industry</h4>--%>
        <p>ஜி.டி.சி அதன் நெட்வொர்க் செயல்பாட்டு நம்பகத்தன்மையை உருவாக்கியுள்ளது மற்றும் கடந்த 3-4 மாதங்களில் கல்வி நிறுவனங்களுடன் 15 க்கும் மேற்பட்ட ஒப்பந்தங்களை வென்றுள்ளது. இந்த ஒப்பந்தங்கள் இப்போது நெட்வொர்க் செயல்பாடுகளிலிருந்து தகவல் மற்றும் தொடர்பு தொழில்நுட்ப (ஐ.சி.டி) சேவைகளின் பெரிய களத்திற்கு விரிவடைந்து வருகின்றன. ஐ.சி.டி கல்வியில் முதலீடு செய்வது மலேசியாவிற்கு ஒரு பெரிய பொருளாதார ஊதியத்தை அளிக்கும்.</p>
        <p>கல்வித் துறை வாடிக்கையாளர்களுக்கு மிகவும் பொருத்தமுடைய சலுகைகளை வழங்க ஜிடிசி அதன் பிரிவுகளை பல்வேறு பரிணாமங்களை அடைந்துள்ளது:</p>
        <p><strong>1. பூஜ்ஜிய மதிப்பீடு</strong></p>
        <p>குறிப்பிட்ட கல்வி வலைத்தளங்கள் அல்லது பயன்பாடுகளுடன் தொடர்புடைய தரவு பூஜ்ஜிய கட்டணமாக வசூலிக்கப்படும் என்று ஜி.டி.சி நியமித்துள்ளது, அதாவது இந்த வளங்களை அணுகும்போது தரவு கட்டணங்கள் எதுவும் பொருந்தாது</p>
        <p><strong>2. தரவு தொப்பிகளை (Lifting data caps) தூக்குதல்</strong></p>
        <p>ஜி.டி.சி கல்வி இணைப்பு திட்டங்களில் தரவு தொப்பிகளை (Lifting data caps) உயர்த்துகிறது. உதாரணமாக. ஒரு மாணவர் ஒரு மாதத்திற்கு 4 ஜிபி இலவசமாகப் பயன்படுத்த முடியும்; இப்போது அவள் 8 ஜிபி பயன்படுத்தலாம்</p>
        <p><strong>3. சமூகங்களில் சாதனங்களை விநியோகித்தல் (Distributing devices in communities)</strong></p>
        <p>புதிய சாதனங்களை வாங்குவது மற்றும் வழங்குவது மட்டுமல்லாமல், வீட்டு உபயோகத்திற்காக பள்ளிகளிலிருந்து சாதனங்களை தயாரித்தல் மற்றும் விநியோகித்தல் உள்ளிட்ட பல்வேறு வழிகளில் மற்றும் ஆசிரியர்களின் கைகளில் அதிகமான சாதனங்களைப் பெற கல்வி அமைச்சகம் ஜி.டி.சி உடன் இணைந்து செயல்படுகிறது.</p>
        <p><strong>4. பொது ஹாட்ஸ்பாட்கள், மற்றும் பழைய சேவைகள் மற்றும் சாதனங்களை ஒளிரச் செய்தல் (lighting up)</strong></p>
        <p>ஜி.டி.சி மாணவர்களுக்கு மலேசியா அரசாங்கத்துடன் இணைந்து இலவச பொது வைஃபை அணுகல் புள்ளிகளை அமைத்து மாணவர்களுக்கு தரவைப் பதிவேற்றவும் / பதிவிறக்கவும் செய்கிறது.</p>
        <p><strong>5. எஸ்எம்எஸ் பிரச்சாரங்கள் மற்றும் கால் சென்டர் ஆதரவு</strong></p>
        <p>எஸ்.எம்.எஸ் வழியாக ஆன்லைன் கற்றலுக்கு ஆதரவாக விழிப்புணர்வை அதிகரிக்கும் பிரச்சாரங்களை ஆதரிப்பதற்கும் தொலைதூரத்தில் அமைந்துள்ள ஆசிரியர்கள், கற்பவர்கள் மற்றும் அவர்களது குடும்பங்களுக்கு ஆதரவளிக்க கால் சென்டர் ஹெல்ப் டெஸ்க்களை விரைவாக அமைப்பதற்கும் கல்வி அமைச்சகம் ஜி.டி.சி உடன் இணைந்து செயல்படுகிறது.</p>
        <p><strong>6. இலவச சிம் கார்டுகள்</strong></p>
        <p>ஜி.டி.சி துரிதப்படுத்தியுள்ளது பதிவு நடைமுறைகள், சிறப்புத் தரவுத் திட்டங்களை இணைந்து கொண்டு, ஆசிரியர்கள் மற்றும் மாணவர்களின் பயன்பாட்டிற்கு கிடைக்கும் இலவச சிம் கார்டுகள் செய்து வருகிறது.</p>


        <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">அடுத்து</a></div>
    </div>
    <!------------ End Tamil--------------->

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

