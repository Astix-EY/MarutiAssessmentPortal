<%@ Page Title="" Language="VB" MasterPageFile="~/DataB/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="BriefOnYourRole.aspx.vb" Inherits="Data_Information_BriefOnYourRole" %>

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

        $(function () {
            fnChangeDataBasedOnLanguage(1)

        });

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

        //----- Indonesia -----------------------
        function fnIndonesia(flg) {
            var ids = "";
            if (flg == 1) {
                ids = "AugngM-idn-cont";
            }
            else if (flg == 2) {
                ids = "KhalisT-idn-cont";
            }
            else if (flg == 3) {
                ids = "AmarM-idn-cont";
            }
            else if (flg == 4) {
                ids = "AishahR-idn-cont";
            }
            else if (flg == 5) {
                ids = "AmitSharma-idn-cont";
            }
            else if (flg == 6) {
                ids = "ZahilHasan-idn-cont";
            }
            $("#" + ids).dialog({
                title: "",
                width: "45%",
                modal: true,
                draggable: false,
                resizable: false,
            });
        }

        //----- Sinhala -------------------------
        function fnSinhala(flg) {
            var ids = "";
            if (flg == 1) {
                ids = "AugngM-sin-cont";
            }
            else if (flg == 2) {
                ids = "KhalisT-sin-cont";
            }
            else if (flg == 3) {
                ids = "AmarM-sin-cont";
            }
            else if (flg == 4) {
                ids = "AishahR-sin-cont";
            }
            else if (flg == 5) {
                ids = "AmitSharma-sin-cont";
            }
            else if (flg == 6) {
                ids = "ZahilHasan-sin-cont";
            }
            $("#" + ids).dialog({
                title: "",
                width: "45%",
                modal: true,
                draggable: false,
                resizable: false,
            });
        }

        //----- Tamin ---------------------------
        function fnTamil(flg) {
            var ids = "";
            if (flg == 1) {
                ids = "AugngM-Tamil-cont";
            }
            else if (flg == 2) {
                ids = "KhalisT-Tamil-cont";
            }
            else if (flg == 3) {
                ids = "AmarM-Tamil-cont";
            }
            else if (flg == 4) {
                ids = "AishahR-Tamil-cont";
            }
            else if (flg == 5) {
                ids = "AmitSharma-Tamil-cont";
            }
            else if (flg == 6) {
                ids = "ZahilHasan-Tamil-cont";
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
        function fnChangeDataBasedOnLanguage(X) {
            var LngID = $("#hdnLngID").val();
            //alert(LngID)
            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }

            fnChangeDataOnPanelPage()
            //   alert(LngID)
            if (LngID == "2") {

                $("#dvIndonesia").show();
                $("#IndonesiaSalesOrg").show();

                $("#dvEnglish").hide();
                $("#EngSalesOrg").hide();


                $("#dvSinhala").hide();
                $("#SinhalaSalesOrg").hide();

                $("#dvTamil").hide();
                $("#TamilSalesOrg").hide();

                $("#HdngBrief").html("DESKRIPSI PERAN");
                $("#HdngSales").html("STRUKTUR ORGANISASI PERUSAHAAN");
                $("#AnchorBack").html("Kembali");
                $("#AnchorNext1").html("Selanjutnya");
                $("#AnchorNext2").html("Selanjutnya");
                $("#paraClickText").html("*Klik pada ikon untuk mengetahui lebih jauh tentang mereka");
            }
            else if (LngID == "3") {

                $("#dvSinhala").show();
                $("#SinhalaSalesOrg").show();

                $("#dvIndonesia").hide();
                $("#IndonesiaSalesOrg").hide();

                $("#dvEnglish").hide();
                $("#EngSalesOrg").hide();

                $("#dvTamil").hide();
                $("#TamilSalesOrg").hide();

                $("#HdngBrief").html("ඔබගේ භුමිකාව පිළිබඳ කෙටි සටහන");
                $("#HdngSales").html("GTC හි ආයතනික සංවිධාන ව්‍යුහය");
                $("#AnchorBack").html("ආපසු");
                $("#AnchorNext1").html("ඊළඟ");
                $("#AnchorNext2").html("ඊළඟ");
                $("#paraClickText").html("*පුද්ගලයා පිළිබඳ වැඩි විස්තර දැන ගැනීමට අයිකනය (icon) මත ක්ලික් (click) කරන්න");
            }

            else if (LngID == "1") {

                $("#dvTamil").show();
                $("#TamilSalesOrg").show();

                $("#dvEnglish").hide();
                $("#EngSalesOrg").hide();

                $("#dvIndonesia").hide();
                $("#IndonesiaSalesOrg").hide();

                $("#dvSinhala").hide();
                $("#SinhalaSalesOrg").hide();


                $("#HdngBrief").html("உங்கள் பங்களிப்பின் சுருக்கம்");
                $("#HdngSales").html("ஜிடிசியின் நிறுவன கட்டமைப்பு");
                $("#AnchorBack").html("பின்னுக்கு");
                $("#AnchorNext1").html("அடுத்து");
                $("#AnchorNext2").html("அடுத்து");
                $("#paraClickText").html("*தனி நபரைப் பற்றி மேலும் அறிய ஐகானைக் (icon) கிளிக் செய்க");
            }

            else {
                $("#dvEnglish").show();
                $("#EngSalesOrg").show();

                $("#dvIndonesia").hide();
                $("#IndonesiaSalesOrg").hide();


                $("#dvSinhala").hide();
                $("#SinhalaSalesOrg").hide();

                $("#dvTamil").hide();
                $("#TamilSalesOrg").hide();

                $("#HdngBrief").html("Your Role & Current Context");
                $("#HdngSales").html("SALES ORG STRUCTURE");
                $("#AnchorBack").html("Back");
                $("#AnchorNext1").html("Next");
                $("#AnchorNext2").html("Next");
                $("#paraClickText").html("*Click over the icon to know more about the individual");
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
            <h3 class="text-center" id="HdngBrief">Your Role & Current Context</h3>
            <div class="title-line-center"></div>
        </div>
        <!-------   English  ------>
        <div id="dvEnglish" style="display: none">


         
             <%--   <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>--%>

            <img src="../../Images/YourRole.jpg" class="img-thumb pull-right" />
            <p>Bharat Manufacturing Solutions (BMS) has recently acquired XYZ Manufacturing, a company based out of Copenhagen, Denmark, specializing in advanced robotics for industrial automation. XYZ Manufacturing has a strong R&amp;D team, innovative product line, and a different organizational culture compared to BMS. The acquisition aims to enhance BMS's product offerings and market presence in the industrial automation sector.</p>
            <p>Post-acquisition, BMS faces significant challenges in integrating XYZ Manufacturing into its existing corporate structure. These challenges include cultural misalignment, redundant processes, and systems incompatibility, different employment laws, etc which could potentially lead to operational inefficiencies, employee dissatisfaction and loss of key talent, and a decline in productivity.&nbsp; BMS has acquired XYZ while the above scenarios and challenges prevail at the organization during integration.&nbsp;&nbsp;</p>
            <p>Your Role:</p>
            <p>You are the CHRO of BMS and have joined the company 6 months back. You are still in the process of familiarizing yourself with the current practices in BMS and now are also expected to manage the integration of BMS and XYZ in a seamless manner.</p>
            <p>While you decide on the best possible options for managing the integration process, do keep in mind the various organizational priorities in BMS.</p>

        </div>
        <!------- End  English  ------>

        <!-------   Indonesia  ------>
        <div id="dvIndonesia" style="display: none">
            <img src="../../Images/brief.jpg" class="img-thumb" align="right" />
            <p>
                Nama: Agas Ahad<br />
                Pengalaman kerja: 5 tahun<br />
                Peran: Manajer Akun
            </p>
            <p>Agas bergabung dengan GTC sebagai sales executive pada tahun 2016 untuk penjualan B2B dan sejak saat itu karirnya telah berkembang hingga ia mengelola klien Medium Enterprise Business selama bertahun-tahun.Agas memiliki keahlian dalam mengembangkan strategi bisnis yang unggul untuk mencapai tujuan jangka pendek & jangka panjang, membangun hubungan dengan para stakeholders, dan memberikan solusi untuk memastikan pertumbuhan pendapatan dan laba yang berkelanjutan.</p>
            <p>Agas telah dipercayakan dengan sebuah tugas menantang, yaitu membuat proposal yang baik untuk bekerja sama dengan Institusi Sunrise Grup di Kuala Lumpur dan mengikuti persyaratan mereka untuk bermitra dengan Penyedia Layanan Pengelolaan Lengkap TIK dalam rangka mendukung kurikulum online untuk sejumlah sekolah mereka sebagai proyek pilot.</p>
        </div>
        <!------- ENd  Indonesia  ------>

        <!-------   Sinhala  ------>
        <div id="dvSinhala" style="display: none">
            <img src="../../Images/brief.jpg" class="img-thumb" align="right" />
            <p>
                නම: අගාස් අහද්<br />
                පළපුරුද්ද: අවුරුදු 5 යි<br />
                කාර්යභාරය: ගිණුම් කළමනාකරු
            </p>
            <p>අගාස් 2016 දී බී 2 බී අලෙවිය සඳහා විකුණුම් විධායකයෙකු ලෙස GTC ආයතනය සමඟ සම්බන්ධ වූ අතර එතැන් සිට වසර ගණනාවක් තිස්සේ මධ්‍යම ව්‍යවසාය ව්‍යාපාර සේවාදායකයින් කළමනාකරණය කිරීම සඳහා වර්ධනය වී තිබේ. කෙටිකාලීන හා දිගු කාලීන අරමුණු සාක්ෂාත් කර ගැනීම සඳහා ජයග්‍රාහී ව්‍යාපාරික උපාය මාර්ග සංවර්ධනය කිරීම, පාර්ශවකරුවන් සමඟ සබඳතා ගොඩනඟා ගැනීම සහ තිරසාර ආදායම සහ ලාභ වර්ධනය සහතික කිරීම සඳහා විසඳුම් ලබා දීමට ආගාස් විශිෂ්ටයි.</p>
            <p>ක්වාලාලම්පූර්හි සන්රයිස් ආයතන සමූහය ඔවුන්ගේ පාසල් කිහිපයක මාර්ගගත (Online) විෂය මාලාවට සහාය වීම සඳහා තොරතුරු සන්නිවේදන තාක්ෂණ (ICT) සැපයුම්කරුවෙකු සමඟ හවුල් වීමේ ඔවුන්ගේ අවශ්‍යතාවය මත ඔවුන් සමඟ වැඩ කිරීමේ යෝජනාවක් ධනාත්මකව හැසිරවීමේ අභියෝගාත්මක කාර්යය අගාස්ට භාර දී ඇත.</p>
        </div>
        <!------- ENd  Sinhala  ------>

        <!-------   Tamil  ------>
        <div id="dvTamil" style="display: none">
            <img src="../../Images/brief.jpg" class="img-thumb pull-right" />
            <p>
                Name: Agas Ahad<br>
                Experience: 5 ஆண்டுகள்<br>
                Role: கணக்கு மேலாளர் (Regional Manager)
            </p>
            <p>அகாஸ் ஜிடிசியில் B2B விற்பனைக்காக 2016 ஆம் ஆண்டில் விற்பனை நிர்வாகியாக சேர்ந்தார், அதன் பின்னர் பல ஆண்டுகளாக நடுத்தர நிறுவன வணிக வாடிக்கையாளர்களை நிர்வகிக்கும் அளவுக்கு வளர்ந்துள்ளார். குறுகிய மற்றும் நீண்ட கால நோக்கங்களை அடைய வெற்றிகரமான வணிக உத்திகளை வளர்ப்பதில் அகாஸ் சிறந்து விளங்குகிறார், பங்குதாரர்களுடன் உறவை வளர்த்துக் கொள்ளுங்கள், மற்றும் நிலையான வருவாய் மற்றும் இலாப வளர்ச்சியை உறுதி செய்வதற்கான தீர்வுகளை வழங்குகிறார்.</p>
            <p>கோலாலம்பூரில் உள்ள சன்ரைஸ் குழும நிறுவனங்களுடன் இணைந்து பணியாற்றுவதற்கான முன்மொழிவை சாதகமாக திருப்புவதற்கான சவாலான பணியை அகாஸ் ஒப்படைத்துள்ளார், ஒரு பைலட்டாக தங்கள் பள்ளிகளில் சிலருக்கு ஆன்லைன் பாடத்திட்டத்தை ஆதரிக்க ஐ.சி.டி வழங்குநருடன் கூட்டாளராக இருக்க வேண்டும்.</p>
        </div>
        <!------- End Tamil ------>

        <div class="text-center mt-3 mb-3">
            <%--<a href="#" onclick="fnRole()" class="btns btn-submit" id="AnchorNext1"></a>--%>
            <div class="text-center mb-3"><a href="#" onclick="fnExample()" class="btns btn-submit">Next</a></div>
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

