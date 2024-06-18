<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Panel.master" AutoEventWireup="false" CodeFile="Performancesnapshot.aspx.vb" Inherits="Data_Information_Performancesnapshot" %>

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
    <time id="theTime" class="fst-color">Reading Time Left
        00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English--------------->
    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">PERFORMANCE SNAPSHOT & PROJECTIONS</h3>
            <div class="title-line-center"></div>
        </div>
        <p>GTC posted stellar results with 17.2% Revenue Growth to achieve all KPIs and declared 60% Dividend Payout Ratio for FY19-20 compared to 50% in FY18-19. Good improvements were recorded in FY19-20 in the Group’s ASEAN markets. GTC shows marked improvements in all turnaround elements and key performance drivers to record a full year of positive growth in a more stable competitive environment.</p>
        <div class="text-center">
            <img src="../../Images/PerformanceSnapshot-eng.png" class="img-thumbnail" />
        </div>
        <div class="text-center mt-3"><a href="#" onclick="fnMenu(5, this)" class="btns btn-submit">Next</a></div>
    </div>
    <!------------ End English--------------->

    <!------------ Indonesia--------------->
    <div id="dvIndonesia" style="display: none">
        <div class="section-title">
            <h3 class="text-center">PROYEKSI DAN GAMBARAN KINERJA</h3>
            <div class="title-line-center"></div>
        </div>
        <p>GTC menunjukan hasil yang sangat baik dengan pertumbuhan pendapatan sebesar 17.2% dalam pencapaian seluruh KPI dan mengumumkan rasio pembayaran sebesar 60% pada FY19-20, dibandingkan dengan FY18-19 sebesar 50%. Peningkatan yang baik ini tercatat pada FY19-20 dalam Kelompok Pasar ASEAN. GTC menunjukkan peningkatan yang signifikan pada seluruh elemen perbaikan (turnaround) dan penentu kinerja utama untuk mencapai pertumbuhan positif dalam setahun penuh di dalam lingkungan kompetitif yang lebih stabil.</p>
        <div class="text-center">
            <img src="../../Images/PerformanceSnapshot-Indonesia.png" class="img-thumbnail" />
        </div>
        <div class="text-center mt-3"><a href="#" onclick="fnMenu(5, this)" class="btns btn-submit">Selanjutnya</a></div>
    </div>
    <!------------ End Indonesia--------------->

    <!------------ Sinhala--------------->
    <div id="dvSinhala" style="display: none">
        <div class="section-title">
            <h3 class="text-center">කාර්යසාධන ප්‍රතිබිම්භයන් සහ ප්‍රක්ෂේපන</h3>
            <div class="title-line-center"></div>
        </div>
        <p>සියළුම ප්‍රධාන කාර්ය සාධන දර්ශක (KPIs) සාක්ෂාත් කර ගැනීම සඳහා GTC ආයතනය 17.2% ක ආදායම් වර්ධනයක් සමඟ වඩා හොඳ ප්‍රතිඵල ලබා ඇති අතර 18/19 මුල්‍ය වර්ෂයේ 50% ට සාපේක්ෂව, 19/20 මූල්‍ය වර්ෂ සඳහා 60% ක ලාභාංශ ගෙවීමේ අනුපාතයක් (Dividend Payout Ratio) ප්‍රකාශයට පත් කරන ලදී. සමුහයක් ලෙස ගත් කල ආසියාන් වෙළඳපල තුළ හොඳ වර්ධනයක් 19/20 මූල්‍ය වර්ෂයෙ හි වාර්තා විය. වඩාත් ස්ථාවර තරඟකාරී වාතාවරණයක් තුළ පුර්ණ වසරක් සදහා ධනාත්මක වර්ධනයක් වාර්තා කිරීම සඳහා GTC සියළුම පිරිවැටුම් අංග සහ ප්‍රධාන කාර්ය සාධන ධාවකවල (drivers) කැපී පෙනෙන දියුණුවක් පෙන්නුම් කර ඇත.</p>
        <div class="text-center">
            <img src="../../Images/PerformanceSnapshot-Sinhala.png" class="img-thumbnail" />
        </div>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(5, this)" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!------------ End Sinhala--------------->

    <!------------ Tamil--------------->
    <div id="dvTamil" style="display: none">
        <div class="section-title">
            <h3 class="text-center">செயல்திறன் கண்ணோட்டம் மற்றும் எதிர்வுகூறல்</h3>
            <div class="title-line-center"></div>
        </div>
        <p>அனைத்து KPI களையும் அடைய ஜிடிசி 17.2% வருவாய் வளர்ச்சியுடனான முடிவுகளை வெளியிட்டது.  மேலும், நிதியாண்டு 19-20 இல் 60% லாபப்பங்கு செலுத்தும் விகிதம் (Dividend) அறிவித்தது. இது நிதியாண்டு 18-19 இல் 50% என்பது குறிப்பிடத்தக்கது.  குழுவின் ஆசியான் (ASEAN) சந்தைகளில் நிதியாண்டு 19-20 இல் நல்ல முன்னேற்றங்கள் பதிவு செய்யப்பட்டன. ஜி.டி.சி அனைத்து திருப்புமுனை கூறுகள் மற்றும் முக்கிய செயல்திறன் இயக்கிகளில் குறிப்பிடத்தக்க முன்னேற்றங்களைக் காட்டுகிறது, மேலும் நிலையான போட்டிச் சூழலில், முழு ஆண்டும் நேர்த்தியான வளர்ச்சியைப் பதிவுசெய்துள்ளது.</p>
        <div class="text-center">
            <img src="../../Images/PerformanceSnapshot-Tamil.png" class="img-thumbnail" />
        </div>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(5, this)" class="btns btn-submit">அடுத்து </a></div>
    </div>
    <!------------ End Tamil--------------->
    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

