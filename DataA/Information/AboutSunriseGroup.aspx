<%@ Page Title="" Language="VB" MasterPageFile="~/DataA/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="AboutSunriseGroup.aspx.vb" Inherits="Data_Information_AboutSunriseGroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "CompanyOverview.aspx";
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
    <time id="theTime" class="fst-color" style="display:none">Reading Time Left  00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>

    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">YOUR POTENTIAL CLIENT: SUNRISE GROUP OF INSTITUTIONS</h3>
            <%-- <h3 class="text-center">ABOUT SUNRISE GROUP OF INSTITUTIONS</h3>--%>
            <div class="title-line-center"></div>
        </div>
        <p>Sunrise Group of Institutions is a renowned educational Group in Kuala Lumpur and has various schools and colleges all over Malaysia. The Group is currently running 15 schools across Malaysia and plans to set up a state of the art university offering graduate and under graduate studies in the heart of Kuala Lumpur. Sunrise schools offer the full K-12 curriculum i.e. from pre-school level all the way to pre-university level in one school campus. The aim of the Group is to provide quality holistic international education. The school has been in the news for some drastic measures they have adopted to transform the learning experience of students. </p>
        <p>Sunrise Group has recently announced their plan to implement the Global Sunrise School program in the next 6 months. The program is a long-term educational initiative that seeks to transform half of their schools into centres of “ICT excellence” and provide new high-tech teaching methods. </p>
        <p>The Group is now looking for potential partners to provide the schools with “superior online connectivity,” a Globe Mobile Laboratory package, and 21st Century Teaching Methods using ICT in the classroom.</p>
        <%--<p>The objective of this program is to increase interest of teachers to  conduct lessons, increase student interest towards learning and improve the  school&rsquo;s performance in the National Achievement Test (NAT). Currently, the  program is to be implemented in 7 different schools located in various parts of  the country. By next year, the program hopes to be present in all 15 schools,  and also cover the future university.</p>--%>
        <p>The objective of this program is to increase interest of teachers to conduct lessons, increase student interest towards learning and improve the school’s performance in the National Achievement Test (NAT). Currently, the program is to be implemented in 7 different schools located in various parts of the country. By next year, the program hopes to be present in all 15 schools, and also cover the future university.</p>
        <p>Mr. Mustafa Aziz (Mustafa), is the Chief Technology Officer of the Sunrise Group, has been entrusted with the responsibility to transform how education is delivered at Sunrise by integrating ICT tools into formal education. Mustafa joined Sunrise about 2 years ago from the Public Sector, wherein, he played an instrumental role in implementing several digital education initiatives for the country. He comes with a keen eye for detail and needs convincing on the robustness of the design, technology and expertise GTC brought to the table.</p>
        <p>Mustafa is not positively inclined about GTC given a past experience he had in his previous role.</p>
          <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(7, this)" class="btns btn-submit">Next</a></div>
    </div>
    <!------------ End English------------------>

    <!------------  Indonesia------------------>
    <div id="dvIndonesia">
       <div class="section-title">
            <h3 class="text-center">Klien Potensial Anda: Grup Institusi Sunrise</h3>
            <%-- <h3 class="text-center">ABOUT SUNRISE GROUP OF INSTITUTIONS</h3>--%>
            <div class="title-line-center"></div>
        </div>
        <p>Grup Institusi Sunrise adalah grup pendidikan terkenal di Kuala Lumpur dan memiliki beragam sekolah dan perguruan tinggi di Malaysia. Saat ini, grup tersebut mengoperasikan 15 sekolah di Malaysia dan berencana untuk mendirikan universitas mutakhir yang menawarkan pendidikan sarjana dan pasca sarjana di pusat Kuala Lumpur. Sekolah Sunrise menawarkan kurikulum K-12 secara penuh, mulai dari tingkat pra-sekolah hingga pra-universitas di satu area kampus. Tujuan dari grup ini adalah untuk memberikan pendidikan internasional yang berkualitas dan menyeluruh. Sekolah ini telah banyak diberitakan oleh media untuk langkah-langkah drastis yang dilakukan untuk mentransformasi kegiatan pembelajaran untuk pelajar.</p>
        <p>Grup Sunrise baru-baru ini mengumumkan rencana mereka untuk mengimplementasikan program Sekolah Global Sunrise dalam 6 bulan mendatang. Program ini merupakan inisiatif pendidikan jangka panjang yang berupaya untuk mentransformasikan sebagian dari sekolah mereka menjadi pusat “Keunggulan TIK” (ICT Excellence)  dan memberikan metode pengajaran baru dengan teknologi tinggi.</p>
        <p>Grup Sunrise saat ini tengah mencari mitra potensial untuk menyediakan “konektivitas online yang unggul”, paket Globe Mobile Laboratory, dan Metode Pengajaran Abad 21 dengan menggunakan TIK (atau ICT) di kelas untuk sekolah-sekolahnya.</p>
        <%--<p>The objective of this program is to increase interest of teachers to  conduct lessons, increase student interest towards learning and improve the  school&rsquo;s performance in the National Achievement Test (NAT). Currently, the  program is to be implemented in 7 different schools located in various parts of  the country. By next year, the program hopes to be present in all 15 schools,  and also cover the future university.</p>--%>
        <p>Tujuan dari program ini adalah untuk meningkatkan antusiasme tenaga pengajar untuk mengajar, meningkatkan antusiasme pelajar untuk belajar, dan memperbaiki performa sekolah pada Tes Pencapaian Nasional (National Achievement Test/NAT). Saat ini, program tersebut akan diimplementasikan di 7 sekolah berbeda yang berada di sejumlah lokasi di Malaysia. Hingga tahun depan, program tersebut diharapkan dapat hadir di seluruh 15 sekolah dan juga di universitas yang akan didirikan.</p>
        <p>Bapak Mustafa Aziz (Mustafa), merupakan Chief Technology Officer dari Grup Sunrise, telah dipercayakan dengan tugas untuk mentransformasikan cara bagaimana pendidikan diberikan di Sunrise dengan mengintegrasikan perangkat TIK ke dalam pendidikan formal. Mustafa bergabung dengan Sunrise sejak  2 tahun lalu dari Sektor Publik, dimana beliau memainkan peran penting untuk mengimplementasikan sejumlah inisiatif pendidikan digital untuk Malaysia. Beliau memiliki atensi yang tinggi terhadap detail dan perlu diyakinkan atas kekuatan desain, teknologi, dan keahlian yang dimiliki oleh GTC dalam proyek ini.</p>
        <p>Mustafa tidak terlalu positif mengenai GTC, berdasarkan pengalaman yang dimilikinya di posisi sebelumnya.</p>
        <div class="text-center mt-3"><a href="#" onclick="fnMenu(7, this)" class="btns btn-submit">Selanjutnya</a></div>
    </div>
    <!------------ End Indonesia------------------>

    <!------------ Sinhala------------------>
    <div id="dvSinhala">
        <div class="section-title">
            <h3 class="text-center">ඔබේ විභව සේවාදායකයා: සන්රයිස් ආයතන සමූහය</h3>
            <%-- <h3 class="text-center">ABOUT SUNRISE GROUP OF INSTITUTIONS</h3>--%>
            <div class="title-line-center"></div>
        </div>
        <p>සන්රයිස් සමූහය ක්වාලාලම්පූර් හි සුප්‍රසිද්ධ අධ්‍යාපන ආයතන සමූහයක් වන අතර මැලේසියාව පුරා විවිධ පාසල් හා විද්‍යාල ඔවුන් සතු වේ. සමූහය මේ වන විට මැලේසියාව පුරා පාසල් 15 ක් පවත්වාගෙන යන අතර ක්වාලාලම්පූර් හි හදවතෙහි උපාධිධාරී සහ උපාධි අධ්‍යයනය සදහා නවීන විශ්ව විද්‍යාලයක් පිහිටුවීමට සැලසුම් කර ඇත. සන්රයිස් පාසල් සම්පූර්ණ K-12 විෂය මාලාව ඉදිරිපත් කරයි. එනම් එක් පාසලක පෙර පාසල් මට්ටමේ සිට පෙර විශ්ව විද්‍යාල මට්ටම දක්වා පවති. ආයතන සමූහයේ පරමාර්ථය වන්නේ ගුණාත්මක පරිපූර්ණ ජාත්‍යන්තර අධ්‍යාපනයක් ලබා දීමයි. සිසුන්ගේ ඉගෙනීමේ අත්දැකීම් පරිවර්තනය කිරීම සඳහා ඔවුන් විසින් ගනු ලැබූ ක්‍රියාමාර්ගයන් පිළිබඳව ප්‍රවෘත්තිවල පළ වී තිබේ.</p>
        <p>ඉදිරි මාස 6 තුළ ග්ලෝබල් සන්රයිස් පාසල් වැඩසටහන ක්‍රියාත්මක කිරීමේ සැලසුම සන්රයිස් සමූහය විසින් මෑතකදී ප්‍රකාශයට පත් කරන ලදී. මෙම වැඩසටහන දිගු කාලීන අධ්‍යාපනික මුලපිරීමක් වන අතර ඔවුන්ගේ පාසල්වලින් අඩක් “තොරතුරු හා සන්නිවේදන තාක්ෂණ විශිෂ්ටත්වයේ” මධ්‍යස්ථාන බවට පත් කිරීමටත් නව අධි තාක්‍ෂණික ඉගැන්වීම් ක්‍රම ලබා දීමටත් ඔවුන් උත්සාහ කරයි.</p>
        <p>පාසල්වලට “උසස් මාර්ගගත සම්බන්ධතාවයක්”, ග්ලෝබ් ජංගම රසායනාගාර පැකේජයක් සහ 21 වන සියවසේ ඉගැන්වීමේ ක්‍රම ලබා දීමට සමූහය දැන් අනාගත තොරතුරු හා සන්නිවේදන තාක්‍ෂණ හවුල්කරුවන් සොයමින් සිටී.</p>
        <%--<p>The objective of this program is to increase interest of teachers to  conduct lessons, increase student interest towards learning and improve the  school&rsquo;s performance in the National Achievement Test (NAT). Currently, the  program is to be implemented in 7 different schools located in various parts of  the country. By next year, the program hopes to be present in all 15 schools,  and also cover the future university.</p>--%>
        <p>මෙම වැඩසටහනේ පරමාර්ථය වන්නේ පාඩම් පැවැත්වීම සඳහා ගුරුවරුන්ගේ උනන්දුව වැඩි කිරීම, ඉගෙනීම කෙරෙහි සිසුන්ගේ උනන්දුව වැඩි කිරීම සහ ජාතික ජයග්‍රහණ පරීක්ෂණයෙහි (NAT) පාසලේ කාර්ය සාධනය වැඩි දියුණු කිරීමයි. මේ වන විට දිවයිනේ විවිධ ප්‍රදේශවල පිහිටි පාසල් 7 ක මෙම වැඩසටහන ක්‍රියාත්මක කිරීමට නියමිතය. ලබන වසර වන විට මෙම වැඩසටහන පාසල් 15 ටම ව්‍යාප්ත කරවීමට අපේක්ෂා කරන අතර අනාගතයේදී විශ්ව විද්‍යාලයටද ව්‍යාප්ත කරවීමට අපේක්ෂා කරයි.</p>
        <p>සන්රයිස් සමූහයේ ප්‍රධාන තාක්‍ෂණ නිලධාරියා වන මුස්තාපා අසීස් (මුස්තාපා) මහතාට තොරතුරු හා සන්නිවේදන තාක්ෂණ මෙවලම් විධිමත් ව අධ්‍යාපනයට ඒකාබද්ධ කර ගනිමින් සන්රයිස් හි අධ්‍යාපනය ලබා දෙන ආකාරය පරිවර්තනය කිරීමේ වගකීම පවරා ඇත. මුස්තාපා මීට වසර 2 කට පමණ පෙර සන්රයිස් සමඟ එකතු විමට පෙර රාජ්‍ය අංශයේ සේවය කල අතර එහිදි ඔහු රට වෙනුවෙන් ඩිජිටල් අධ්‍යාපන වැඩසටහන් කිහිපයක් ක්‍රියාත්මක කිරීමේ දී වැදගත් කාර්යභාරයක් ඉටු කළේය. ඔහු සවිස්තරාත්මක ඇසකින් බලන අතර GTC ආයතනය සපයන සැලසුම්, තාක්‍ෂණය සහ විශේෂඥතාවය කෙරෙහි නැඹුරුවක් ඇති කරවිම සදහා ඒවා ශක්තිමත් බව ඒත්තු ගැන්විය යුතුය.</p>
        <p>මුස්තාපාට ඔහුගේ පෙර භූමිකාව හා සසදන කල GTC ආයතනය තුල ඔහුගේ භූමිකාව පිළිබඳ ධනාත්මක නැඹුරුවක් නැත.</p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(7, this)" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!------------ End Sinhala------------------>

    <!------------ Tamil------------------>
    <div id="dvTamil">
       <div class="section-title">
            <h3 class="text-center">உங்கள் சாத்தியமான (Potential) வாடிக்கையாளர்: நிறுவனங்களின் சன்ரைஸ் குழு</h3>
            <%-- <h3 class="text-center">ABOUT SUNRISE GROUP OF INSTITUTIONS</h3>--%>
            <div class="title-line-center"></div>
        </div>
        <p>சன்ரைஸ் குரூப் ஆஃப் இன்ஸ்டிடியூஷன்ஸ் கோலாலம்பூரில் உள்ள ஒரு புகழ்பெற்ற கல்வி குழுவாகும், மேலும் மலேசியா முழுவதும் பல்வேறு பள்ளிகள் மற்றும் கல்லூரிகளைக் கொண்டுள்ளது. இந்த குழு தற்போது மலேசியா முழுவதும் 15 பள்ளிகளை நடத்தி வருகிறது, மேலும் கோலாலம்பூரின் மையப்பகுதியில் பட்டதாரி மற்றும் படிப்புகளை வழங்கும் கலை பல்கலைக்கழகத்தை அமைக்க திட்டமிட்டுள்ளது. சன்ரைஸ் பள்ளிகள் முழு கே -12 பாடத்திட்டத்தை வழங்குகின்றன, அதாவது முன்பள்ளி மட்டத்தில் இருந்து ஒரே பள்ளி வளாகத்தில் பல்கலைக்கழகத்திற்கு முந்தைய நிலை வரை.  தரமான முழுமையான சர்வதேச கல்வியை வழங்குவதாகும். மாணவர்களின் கற்றல் அனுபவத்தை மாற்றுவதற்காக அவர்கள் கடைப்பிடித்த சில கடுமையான நடவடிக்கைகளுக்காக பள்ளி செய்திகளில் வந்துள்ளது.</p>
        <p>அடுத்த 6 மாதங்களில் குளோபல் சன்ரைஸ் பள்ளி திட்டத்தை செயல்படுத்த உள்ளது சன்ரைஸ் குழு சமீபத்தில் அறிவித்தது. இந்த திட்டம் ஒரு நீண்டகால கல்வி முயற்சியாகும், இது அவர்களின் பள்ளிகளில் பாதியை "ஐ.சி.டி சிறப்பின்" மையங்களாக மாற்றவும் புதிய உயர் தொழில்நுட்ப கற்பித்தல் முறைகளை வழங்கவும் முயல்கிறது.</p>
        <p>குழு இப்போது பள்ளிகளுக்கு "சிறந்த ஆன்லைன் இணைப்பு", குளோப் மொபைல் (Globe Mobile) ஆய்வக தொகுப்பு மற்றும் வகுப்பறையில் ICT.யைப் பயன்படுத்தி 21 ஆம் நூற்றாண்டு கற்பித்தல் முறைகள் ஆகியவற்றை வழங்குவதற்கான சாத்தியமான கூட்டாளர்களைத் தேடுகிறது.</p>
        <p>பாடத்திட்டங்களை நடத்துவதற்கு ஆசிரியர்களின் ஆர்வத்தை அதிகரிப்பது, கற்றல் மீதான மாணவர்களின் ஆர்வத்தை அதிகரிப்பது மற்றும் தேசிய சாதனை தேர்வில் (நாட்) பள்ளியின் செயல்திறனை மேம்படுத்துவதே இந்த திட்டத்தின் நோக்கம். தற்போது, ​​நாட்டின் பல்வேறு பகுதிகளில் அமைந்துள்ள 7 வெவ்வேறு பள்ளிகளில் இந்த திட்டம் செயல்படுத்தப்பட உள்ளது. அடுத்த ஆண்டுக்குள், இந்த திட்டம் அனைத்து 15 பள்ளிகளிலும் இருக்கும் என்று நம்புகிறது, மேலும் எதிர்கால பல்கலைக்கழகத்தையும் உள்ளடக்கும்.</p>
        <p>சன்ரைஸ் குழுமத்தின் தலைமை தொழில்நுட்ப அதிகாரியாக உள்ள திரு. முஸ்தபா அஜீஸ் (முஸ்தபா), ICT கருவிகளை முறையான கல்வியில் ஒருங்கிணைப்பதன் மூலம் சன்ரைஸில் கல்வி எவ்வாறு வழங்கப்படுகிறது என்பதை மாற்றும் பொறுப்பை ஒப்படைத்துள்ளனர். முஸ்தபா பொதுத் துறையிலிருந்து சுமார் 2 ஆண்டுகளுக்கு முன்பு சன்ரைஸில் சேர்ந்தார், அதில், நாட்டிற்காக பல டிஜிட்டல் கல்வி முயற்சிகளை செயல்படுத்துவதில் அவர் ஒரு கருவியாகப் பங்கு வகித்தார். அவர் விவரங்களுக்கு மிகுந்த ஆர்வமாக உள்ளார், மேலும் வடிவமைப்பு, தொழில்நுட்பம் மற்றும் நிபுணத்துவம் ஜி.டி.சி</p>
        <p>முஸ்தபாவின் முந்தைய பாத்திரத்தில் (role) பெற்ற அனுபவம் ஜி.டி.சி சார்பாகவில்லை.</p>

        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(7, this)" class="btns btn-submit">அடுத்து</a></div>
    </div>
    <!------------ End Tamil------------------>
    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

