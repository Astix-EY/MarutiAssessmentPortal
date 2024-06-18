<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Panel.master" AutoEventWireup="false" CodeFile="AssessmentDescription.aspx.vb" Inherits="Data_Information_AssessmentDescription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
       <script type="text/javascript">
        function fnExample() {
            window.location.href = "TaskExample.aspx?MenuId=8";
        }
    </script>
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
            <h3 class="text-center">ASSESSMENT DESCRIPTION</h3>
            <div class="title-line-center"></div>
        </div>
        <p>In the upcoming sections, there will be multiple tasks presented to you with different scenarios and judgement based questions. Your responses to these simulated assessment will help us to better understand your behaviour and functional strengths and development areas which will further aid to curate a more aligned and personalized learning journey for you.</p>
        <p>You will be required to use your understanding of the case background, situation context as well your judgement to answer these questions. Please note the following:</p>
        <ul>
            <li>Response to all questions is mandatory and will have to be answered within the assigned time</li>
            <li>The situations as well as the type of questions will vary as you progress. Read the question carefully and select your response</li>
            <li>There is no right or wrong answer. Your approach will be assessed in the given situations</li>
        </ul>
        <p>An example has been shared along with its explanation. Please read the same before beginning your assessment tasks.</p>
        <div class="text-center mb-3"><a href="#" onclick="fnExample()" class="btns btn-submit">Next</a></div>
    </div>
    <!------------ End English------------------>

    <!------------  Indonesia------------------>
    <div id="dvIndonesia">
       <div class="section-title">
            <h3 class="text-center">Deskripsi Asesmen</h3>
            <div class="title-line-center"></div>
        </div>
        <p>Di bagian selanjutnya, akan ada sejumlah tugas yang disampaikan kepada Anda dengan skenario yang berbeda-beda dan pertanyaan yang didasarkan pada penilaian (judgement-based). Respon Anda terhadap simulasi asesmen ini akan membantu kami untuk lebih memahami perilaku, area kekuatan, dan area pengembangan Anda yang nantinya akan membantu dalam penyusunan perjalanan pembelajaran (learning journey) yang lebih selaras dan personal untuk Anda.</p>
        <p>Anda akan diminta untuk menggunakan pemahaman Anda terkait latar belakang kasus, konteks situasi, juga penilaian Anda untuk menjawab pertanyaan-pertanyaan ini. Mohon perhatikan beberapa hal berikut:</p>
        <ul>
            <li>Jawaban untuk semua pertanyaan adalah wajib, dan harus dijawab dalam jangka waktu yang diberikan</li>
            <li>Situasi maupun tipe pertanyaan akan bervariasi sepanjang kemajuan Anda. Bacalah tiap pertanyaan dengan hati-hati dan pilih respon Anda </li>
            <li>Tidak ada jawaban benar atau salah. Pendekatan Anda akan dinilai dalam situasi yang diberikan</li>
        </ul>
        <p>Sebuah contoh telah diberikan beserta penjelasannya. Mohon baca contoh tersebut sebelum memulai tugas asesmen Anda.</p>
        <div class="text-center mt-3"><a href="#" onclick="fnExample()" class="btns btn-submit">Selanjutnya</a></div>
    </div>
    <!------------ End Indonesia------------------>

    <!------------ Sinhala------------------>
    <div id="dvSinhala">
       <div class="section-title">
            <h3 class="text-center">තක්සේරු විස්තරය</h3>
            <div class="title-line-center"></div>
        </div>
        <p>ඉදිරි කොටස් වලදී, විවිධ අවස්ථා සහ විනිශ්චය පදනම් කරගත් ප්‍රශ්න සමඟ ඔබට විවිධ කාර්යයන් ඉදිරිපත් කරනු ඇත. මෙම සමානුපාතික ඇගයීම් සඳහා ඔබ දක්වන ප්‍රතිචාර ඔබගේ හැසිරීම සහ ක්‍රියාකාරී ශක්තීන් සහ සංවර්ධන ක්ෂේත්‍ර වඩාත් හොඳින් අවබෝධ කර ගැනීමට උපකාරී වන අතර එමඟින් ඔබ වෙනුවෙන් වඩාත් පෙළගැස්වූ සහ පුද්ගලීකරණය කළ ඉගෙනුම් පටිපාටියක් ඔබට සැපයීමට තවදුරටත් උපකාරී වේ</p>
        <p>මෙම ප්‍රශ්නවලට පිළිතුරු සැපයීම සඳහා සිද්ධි පසුබිම, තත්ව සන්දර්භය(Context)  සහ ඔබේ විනිශ්චය පිළිබඳ ඔබේ අවබෝධය භාවිතා කිරීමට ඔබට සිදු වනු ඇත. කරුණාකර පහත සඳහන් කරුණු කෙරෙහි අවදානය යොමු කරන්න:</p>
        <ul>
            <li>සියලුම ප්‍රශ්න වලට ප්‍රතිචාර දැක්වීම අනිවාර්ය වන අතර නියමිත කාලය තුළ පිළිතුරු සැපයිය යුතුය.</li>
            <li>ඔබ ඉදිරියට ගමන් කරන විට තත්වයන් මෙන්ම ප්‍රශ්න වර්ගයන්ද වෙනස් වේ. ප්‍රශ්නය ප්‍රවේශමෙන් කියවා ඔබේ ප්‍රතිචාරය තෝරන්න.</li>
            <li>හරි හෝ වැරදි පිළිතුරක් නැත. දී ඇති අවස්ථා වලදී ඔබේ ප්‍රවේශය තක්සේරු කරනු ලැබේ.</li>
        </ul>
        <p>උදාහරණයක් එහි පැහැදිලි කිරීම සමඟ මෙහි දක්වා ඇත. ඔබේ තක්සේරු කිරීමේ කාර්යයන් ආරම්භ කිරීමට පෙර කරුණාකර එය කියවන්න.</p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnExample()" class="btns btn-submit">ඊළඟ</a></div>
    </div>
    <!------------ End Sinhala------------------>

    <!------------ Tamil------------------>
    <div id="dvTamil">
      <div class="section-title">
            <h3 class="text-center">மதிப்பீட்டு விளக்கம்</h3>
            <div class="title-line-center"></div>
        </div>
        <p>வரவிருக்கும் பிரிவுகளில், வெவ்வேறு காட்சிகள் (scenarios) மற்றும் தீர்ப்பு அடிப்படையிலான கேள்விகளுடன் உங்களுக்கு பல பணிகள் (tasks )வழங்கப்படும். இந்த உருவகப்படுத்தப்பட்ட மதிப்பீட்டிற்கான உங்கள் பதில்கள் உங்கள் நடத்தை மற்றும் செயல்பாட்டு பலங்கள் (strengths) மற்றும் மேம்பாட்டுப் பகுதிகளை நன்கு புரிந்துகொள்ள எங்களுக்கு உதவும், இது உங்களுக்காக மிகவும் சீரமைக்கப்பட்ட மற்றும் தனிப்பயனாக்கப்பட்ட கற்றல் பயணத்தை மேம்படுத்துவதற்கு மேலும் உதவும்.</p>
        <p>இந்த கேள்விகளுக்கு பதிலளிக்க வழக்கு பின்னணி (case background), சூழ்நிலை (situation)மற்றும் உங்கள் தீர்ப்பைப் (your judgement) பற்றிய உங்கள் புரிதலைப் (understanding) பயன்படுத்த வேண்டும். பின்வருவதைக் கவனியுங்கள்:</p>
        <ul>
            <li>எல்லா கேள்விகளுக்கும் பதிலளிப்பது கட்டாயமானது மற்றும் ஒதுக்கப்பட்ட நேரத்திற்குள் பதிலளிக்கப்பட வேண்டும்</li>
            <li>நீங்கள் முன்னேறும்போது சூழ்நிலைகள் மற்றும் கேள்விகளின் வகை மாறுபடும். கேள்வியை கவனமாகப் படித்து உங்கள் பதிலைத் தேர்ந்தெடுக்கவும்</li>
            <li>சரியான அல்லது தவறான பதில். கொடுக்கப்பட்டவில்லை சூழ்நிலைகளில் உங்கள் அணுகுமுறை மதிப்பீடு செய்யப்படும்</li>
        </ul>
        <p>
            ஒரு எடுத்துக்காட்டு அதன் விளக்கத்துடன் பகிரப்பட்டுள்ளது. உங்கள் மதிப்பீட்டு பணிகளைத் தொடங்குவதற்கு முன் அதைப் படிக்கவும்.
        </p>
        <div class="text-center mb-3"><a href="#" onclick="fnExample()" class="btns btn-submit">அடுத்து </a></div>
    </div>
    <!------------ End Tamil------------------>
    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

