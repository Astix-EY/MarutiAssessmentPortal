<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Panel.master" AutoEventWireup="false" CodeFile="frmMeeting.aspx.vb" Inherits="Data_frmBusinessPresentation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .ui-dialog .ui-dialog-content {
            overflow-x: hidden !important;
        }
    </style>
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.my-account > .tab-pane:first').show();
            $('.nav-tabs > li.has-menu').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                $('.my-account > .tab-pane').hide();
                $('.' + $(this).data('class')).fadeIn();
            });

            

            $('#btnPriceModel').click(function () {

                var LngID = $("#hdnLngID").val();
                if (LngID == "2")
                {
                    $("#dvPriceModel_Indonesia").dialog({
                        title: "Pricing Model",
                        width: "65%",
                        modal: true,
                        draggable: false,
                        resizable: false
                    });
                }
				else if (LngID == "3")
                {
                    $("#dvPriceModel_Sinhala").dialog({
                        title: "Pricing Model",
                        width: "65%",
                        modal: true,
                        draggable: false,
                        resizable: false
                    });
                }
				else if (LngID == "1")
                {
                    $("#dvPriceModel_Tamil").dialog({
                        title: "Pricing Model",
                        width: "65%",
                        modal: true,
                        draggable: false,
                        resizable: false
                    });
                }
                else
                {
                    $("#dvPriceModel").dialog({
                        title: "Pricing Model",
                        width: "65%",
                        modal: true,
                        draggable: false,
                        resizable: false
                    });
                }
            });
        })
    </script>

     <script type="text/javascript">

        $(document).ready(function () {

       //     fnChangeDataBasedOnLanguage(1)
        });

        function fnChangeDataBasedOnLanguage(X)
        {
            var LngID = $("#hdnLngID").val();
           // alert(LngID)
            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }
            if (LngID == "2")   //////////////////Indonesia
            {
                $("#dvIndonesia").show();
                $("#dvEnglish").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();
                $("#hdng").html("Diskusi Manajer")
                $("#btnGoToMeeting").val("Mulai Rapat")
                $("#btnSubmit").val("Tutup kegiatan")
              //  $("#theTime").html("Sisa Waktu")
               
            }
            else if (LngID == "3")   //////////////////Sinhala
            {
                $("#dvSinhala").show();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
                $("#dvTamil").hide();

                $("#hdng").html("ව්‍යාපරික ඉදිරිපත් කිරීම")
                $("#btnGoToMeeting").val("රැස්වීම් පිවිසුම")
                $("#btnSubmit").val("ක්‍රියාකරකම අවසන් කරන්න")
              //  $("#theTime").html("ඉතිරිවී ඇති කාලය")
               
            }

            else if (LngID == "1")   //////////////////Tamil
            {
                $("#dvTamil").show();
                $("#dvEnglish").hide();
                $("#dvIndonesia").hide();
                $("#dvSinhala").hide();
                               
                $("#hdng").html("வணிக விளக்கக்காட்சி உருவாக்கம்")
                $("#btnGoToMeeting").val("கூட்டத்திற்குச் செல்லுங்கள்")
                $("#btnSubmit").val("பயிற்சியை மூடு")
                //   $("#theTime").html("Time Left")
              
            }

            else
            {
                $("#dvEnglish").show();
                $("#dvIndonesia").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();
                $("#hdng").html("Meeting Discussion")
                $("#btnGoToMeeting").val("Go To Meeting")
                $("#btnSubmit").val("Close Exercise")
             //   $("#theTime").html("Time Left")
                
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
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        var TimerText = "Discussion Time Left : ";
        var isPrepTimeFinished = 1;
        f1();
        //hdnCounterRunTime
        function f1() {
            $(document).ready(function () {
                //function FnUpdateTimer() {
                if (IsUpdateTimer == 1) {
                    if (parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value) == 0 && parseInt(document.getElementById("ConatntMatterRight_hdnCounterRunTime").value) == 0) {
                        
                       TimerText = "Discussion Time Left : ";
                      
                        flgOpenGotoMeeting = 1;
                        isPrepTimeFinished = 0;
                        IsUpdateTimer = 0;
                        document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                        // clearTimeout(sClearTime);
                        window.clearInterval(sClearTime);
                        clearTimeout(sClearTime);
                        window.clearInterval(eventStartMeetingTimer);
                        clearTimeout(eventStartMeetingTimer);
                        alert("Your discussion time is over, Kindly click on 'Close Exercise' button to complete your exercise");  
						$("#btnSubmit").attr("disabled", false);							
                        return false;
                    }
                    //else if (parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value) == 0 && parseInt(document.getElementById("ConatntMatterRight_hdnCounterRunTime").value) > 0) {
                       
                    //        TimerText = "Discussion Time Left : ";
                       
                    //    document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                    //    isPrepTimeFinished = 0;
                    //    IsUpdateTimer = 0;
                    //    window.clearInterval(sClearTime);
                    //    clearTimeout(sClearTime);
                    //    document.getElementById("ConatntMatterRight_hdnCounter").value = document.getElementById("ConatntMatterRight_hdnCounterRunTime").value;
                    //    document.getElementById("ConatntMatterRight_hdnCounterRunTime").value = 0;
                    //    alert("Your preparation time is over and your meeting with the facilitator will start once he starts the Go to Meeting");
                    //    fnUpdateActualStartEndTime(1, 2);
                    //    fnGoToMeeting();
                    //    eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 3000);
                    //    return false;
                    //} 
                }
                if (IsUpdateTimer == 0) { return; }
                SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
                if (SecondCounter <= 0) {
                    IsUpdateTimer = 0;
                    //alert("Your Time is over now")
                    counter = 0;
                    //(2, "", 2, 1);
                    return;
                }
                SecondCounter = SecondCounter - 1;
                hours = Math.floor(SecondCounter / 3600);
                Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
                Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);

                if (Seconds < 10 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = TimerText+":0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds < 10 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + Minutes + ":" + "0" + Seconds;
                }
                else if (Seconds > 9 && Minutes < 10) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + "0" + Minutes + ":" + Seconds;
                }
                else if (Seconds > 9 && Minutes > 9) {
                    document.getElementById("theTime").innerHTML = TimerText + ":0" + hours + ":" + Minutes + ":" + Seconds;
                }
                document.getElementById("ConatntMatterRight_hdnCounter").value = SecondCounter;

                //var TotalSecond = parseInt(document.getElementById("ConatntMatterRight_hdnExerciseTotalTime").value);
                //document.getElementById("ConatntMatterRight_hdnTimeElapsedSec").value = TotalSecond - SecondCounter;
              
                if (((hours * 60) + Minutes) == 5 && Seconds == 0) {
                  //  alert("hi")
                    $("#dvDialog")[0].innerHTML = "<center>Your Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " .</center>";
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
                if (counter == 10) {//Auto Time Update
                    counter = 0;
                    fnUpdateElapsedTime();
                    //counter = 1;
                }
               
                if (SecondCounter == 0) {
                    //if (parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value) == 0 && parseInt(document.getElementById("ConatntMatterRight_hdnCounterRunTime").value) > 0) {
                    //    document.getElementById("ConatntMatterRight_hdnCounter").value = document.getElementById("ConatntMatterRight_hdnCounterRunTime").value;
                    //    document.getElementById("ConatntMatterRight_hdnCounterRunTime").value = 0;
                    //    // alert("Level Complete");
                        
                    //        TimerText = "Discussion Time Left : ";
                       
                    //    document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                    //    IsUpdateTimer = 0;
                    //    isPrepTimeFinished = 0;
                    //    fnUpdateElapsedTime();
                    //    fnUpdateActualStartEndTime(1, 2);
                    //    fnGoToMeeting();
                    //    alert("Your preparation time is over and your meeting with the facilitator will start once he starts the Go to Meeting");
                    //    eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 3000);
                    //    counter = 0;
                    //    return false;
                    //}
                     if (parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value) == 0 && parseInt(document.getElementById("ConatntMatterRight_hdnCounterRunTime").value) == 0) {
                        flgOpenGotoMeeting = 1;
                        window.clearInterval(sClearTime);
                        clearTimeout(sClearTime);
                        window.clearInterval(eventStartMeetingTimer);
                        clearTimeout(eventStartMeetingTimer);
                        document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                        alert("Your discussion time is over, Kindly click on 'Close Exercise' button to complete your exercise");
                        fnUpdateElapsedTime();
						 $("#btnSubmit").attr("disabled", false);
                        return false;
                    }
                    else {
                        IsUpdateTimer = 0;
                        counter = 0;
                        fnUpdateElapsedTime();
                        return false;
                    }
                }
                // }
                sClearTime= setTimeout("f1()", 1000);

            });

        }
        var sClearTime;
        function fnUpdateElapsedTime() {
            var RspexerciseId = document.getElementById("ConatntMatterRight_hdnRSPExerciseID").value;
            var TotTimeElapsedSec = document.getElementById("ConatntMatterRight_hdnTimeElapsedSec").value
            PageMethods.fnUpdateTime(RspexerciseId, TotTimeElapsedSec, fnUpdateElapsedTimeSuccess, fnUpdateElapsedTimeFailed);
        }
        function fnUpdateElapsedTimeSuccess(result) {

        }
        function fnUpdateElapsedTimeFailed(result) {
            //    alert(result._message);
        }
        function fnGoToMeeting() {

            
                fnUpdateActualStartEndTime(1, 3);
                isPrepTimeFinished = 0;
                TimerText = "Discussion Time Left : ";
                document.getElementById("theTime").innerHTML = TimerText + ":00:00:00";
                IsUpdateTimer = 0;
                eventStartMeetingTimer = setInterval("fnStartMeetingTimer()", 3000);
                var MeetingURL = document.getElementById("ConatntMatterRight_hdnGoToMeetingURL").value;
                window.open(MeetingURL)
          
            $("#btnSubmit").attr("disabled", false);
        }

        function fnSubmit() {
          //  window.location.href = "../Main/frmExerciseMain.aspx";
           
            var ExerciseID = $("#ConatntMatterRight_hdnExerciseID").val();
            var RspExerciseId = $("#ConatntMatterRight_hdnRSPExerciseID").val();
            $("#dvDialog").html("Are you sure you have completed this exercise ?<br />Click OK if you have completed. <br />Click Cancel if you have NOT completed and click on 'Go To Meeting' to start your meeting.");
            $("#dvDialog").dialog({
                modal: true,
                title: "Alert",
                width: '55%',
                maxHeight: 'auto',
                minHeight: 150,
                buttons: {
                    "Ok": function () {

                        PageMethods.fnSubmit(ExerciseID, RspExerciseId, fnSubmitSuccess, fnUpdateResponsesFailed);
                        $(this).dialog("close");
                    },
                    "Cancel": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                    $(this).dialog("close");
                    $(this).dialog("destroy");
                }
            });
        }
        function fnSubmitSuccess(result) {

            if (result.split("^")[0] == "1")
            {
                
                    window.location.href = "../Exercise/ExerciseMain.aspx?MenuId=8";
               
            }
        }
        function fnUpdateResponsesFailed(result) {
            alert(result.split("^")[1])
        }

        function fnPageLoad() {
            if (SecondCounter > -1) {
                setInterval(function () { FnUpdateTimer() }, 1000);
            }
        }

        $(document).ready(function () {
            var PrepStatus = $("#ConatntMatterRight_hdnPrepStatus").val();
            var MeetingStatus = $("#ConatntMatterRight_hdnMeetingStatus").val();
            if (PrepStatus == 0 && MeetingStatus == 0) {
                PrepStatus = PrepStatus == 0 ? 1 : PrepStatus;
                MeetingStatus = MeetingStatus == 0 ? 1 : MeetingStatus;
                fnUpdateActualStartEndTime(PrepStatus, MeetingStatus);
            }
        });

        function fnUpdateActualStartEndTime(UserTypeID, flgAction) {
            $("#loader").show();
            var RspExerciseID = $("#ConatntMatterRight_hdnRSPExerciseID").val();
            PageMethods.fnUpdateActualStartEndTime(RspExerciseID, UserTypeID, flgAction, function (result) {
                $("#loader").hide();
                if (result.split("|")[0] == "1") {
                    alert("Error-" + result.split("^")[1]);
                }
            }, function (result) {
                $("#loader").hide();
                alert("Error-" + result._message);
            });
        }
        var eventStartMeetingTimer; var flgOpenGotoMeeting = 0;
        function fnStartMeetingTimer() {
           
            //$("#loader").show();
            if (flgOpenGotoMeeting == 0) {
                var RspExerciseID = $("#ConatntMatterRight_hdnRSPExerciseID").val();
                var MeetingDefaultTime = $("#ConatntMatterRight_hdnMeetingDefaultTime").val();
                PageMethods.fnStartMeetingTimer(RspExerciseID, MeetingDefaultTime, function (result) {
                    $("#loader").hide();
                    if (result.split("|")[0] == "1") {
                        alert("Error-" + result.split("|")[1]);
                    } else {
                        var IsMeetingStartTimer = result.split("|")[1];
                        var MeetingRemainingTime = result.split("|")[2];
                        window.clearInterval(sClearTime);
                        clearTimeout(sClearTime);
                        if (IsMeetingStartTimer == 1) {
                            flgOpenGotoMeeting = 1;
                            window.clearInterval(eventStartMeetingTimer);
                            clearTimeout(eventStartMeetingTimer);
                            document.getElementById("ConatntMatterRight_hdnCounter").value = MeetingRemainingTime;
                            if (MeetingRemainingTime > 0) {
                                IsUpdateTimer = 1;
                                f1();
                            }
                        }
                    }
                }, function (result) {
                    $("#loader").hide();
                    alert("Error-" + result._message);
                });
            } else {
                window.clearInterval(eventStartMeetingTimer);
                clearTimeout(eventStartMeetingTimer);
            }
        }
        // document.onload = fnPageLoad();
</script>


</asp:Content>
<asp:Content ID="ContentTimer" ContentPlaceHolderID="ContentTimer" runat="Server">
    <time id="theTime" class="fst-color">Discussion Time Left
        00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <div class="section-title">
        <h3 class="text-center" id="hdng">Assessor Discussion</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="section-content position-relative">
        <div class="gtc-logo">
           <input type="button"  class="btns btn-submit btns-small" id="btnGoToMeeting" value="Go To Meeting" onClick = "fnGoToMeeting()" />
        </div>
<!---------------- English---------------------->
    <div id="dvEnglish">
        <div class="border border-dark d-inline-block mb-3 p-2">
            <p class="mb-0">
                Preparation time: 0<br />
                Discussion time:30 mins
            </p>
        </div>
        <p>Please start your meeting by click on "Go To Meeting"</p>

       
    </div>
    <%-- <!----------------End English---------------------->
        <!---------------- Indonesia---------------------->
         <div id="dvIndonesia" style="display:none" >
        <div class="border border-dark d-inline-block mb-3 p-2">
            <p class="mb-0">
                Waktu persiapan: 20 menit<br />
                Waktu diskusi: 20 menit
            </p>
        </div>
        <p>Peserta akan berperan sebagai Agas dan asesor akan berperan sebagai Manajer dari Agas – Ibu Zeliha.</p>

        <p class="fst-color">Selama pengerjaan tugas, Anda diharapkan untuk berdiskusi dengan klien dan:</p>
        <ul>
            <li>Merangkum secara jelas kebutuhan/ekspektasi klien</li>
            <li>Mengevaluasi faktor-faktor yang telah Anda pertimbangkan untuk membuat proposisi klien yang kuat</li>
            <li>Mengevaluasi model penetapan harga yang berbeda dan mendiskusikan pertimbangan Anda dalam memilih model tersebut</li>
        </ul>
    </div>

         <!---------------- End Indonesia---------------------->
         <!---------------- Sinhala---------------------->
        <div id="dvSinhala">
        <div class="border border-dark d-inline-block mb-3 p-2">
            <p class="mb-0">
                සූදානම් වීමේ කාලය : මිනිත්තු 20<br />
                සාකච්ඡා කාලය : මිනිත්තු 20
            </p>
        </div>
        <p>සහභාගිවන්නා අගාස්ගේ ( Agas ) ධාරිතාවයෙන් කටයුතු කරනු ඇති අතර තක්සේරුකරු ( assessor) අගාස්ගේ කළමනාකරු, සෙලිහා මහත්මියගේ (Ms. Zeliha)  භූමිකාව ඉටු කරයි. </p>

        <p class="fst-color">ඔබ සේවාදායකයා සමඟ මෙම කාර්යය අතරතුර සාකච්ඡා කිරීමට බලාපොරොත්තු වන කරුණු:</p>
        <ul>
            <li>සේවාදායකයාගේ අවශ්‍යතාවය / අපේක්ෂාවන් පිළිබඳව පැහැදිලිව සාරාංශ ගත කිරිම.</li>
            <li>ප්‍රබල පරිභෝගික යෝජනාවක් සදහා ඔබ විසින් සලක බලන ලද සාධක ඇගයිමකට ලක් කිරිම.</li>
            <li>මිලකරණය සම්බන්ධව ඇති විවිධ මිල ආකෘති (Pricing Models) ඇගයිමකට ලක් කර ඉන් ඔබ තෝරා ගන්න මිල ආකෘතිය තෝරා ගැනිම සම්බන්ධයෙන් කරුණු පැහැදිලි කිරිම.</li>
        </ul>
    </div>
         <!---------------- End Sinhala---------------------->

        <!---------------- Tamil---------------------->
    <div id="dvTamil">
        <div class="border border-dark d-inline-block mb-3 p-2">
            <p class="mb-0">
                தயாராகும் நேரம்: 20 நிமிடம்<br />
                கலந்துரையாடல் நேரம் : 20 நிமிடம்

            </p>
        </div>
        <p>பங்கேற்பாளர் ஆகாஷின் பங்கை வகிப்பார், மேலும் மதிப்பீட்டாளர் ஆகாஷின் மேலாளர் - திருமதி. ஜெலிஹாவின் பாத்திரத்தை வகிப்பார்.
</p>

        <p class="fst-color">இந்த பணியின் போது நீங்கள் வாடிக்கையாளருடன் கலந்துரையாடுவீர்கள் என்று எதிர்பார்க்கப்படுகிறது மற்றும்:
</p>
        <ul>
            <li>வாடிக்கையாளர் தேவை / எதிர்பார்ப்புகளை தெளிவாகவும் சுருக்கமாகவும் விளக்கவம்</li>
            <li>வலுவான வாடிக்கையாளர் முன்மொழிவை உருவாக்க நீங்கள் கருதிய காரணிகளை மதிப்பீடு செய்யுங்கள்</li>
            <li>வெவ்வேறு விலையிடல் மாதிரிகள் மதிப்பீடு செய்து, ஒரு மாதிரியைத் தேர்ந்தெடுப்பதற்கான உங்கள் எண்ணவோட்டங்களைப் பற்றி விவாதிக்கவும்.
</li>
        </ul>
    </div>--%>
     <!----------------End Tamil---------------------->
   </div>
    <div class="text-center">
      
         <input type="button" id="btnSubmit" class="btns btn-cancel" disabled value = "Close Exercise" onclick="fnSubmit()">
    </div>

 

    <div id="dvPriceModel" style="display: none">
        <img src="../../Images/PriceModel.png" class="img-thumbnail" />
    </div>
     <div id="dvPriceModel_Indonesia" style="display: none">
        <img src="../../Images/PriceModel-indonesia.png" class="img-thumbnail" />
    </div>
	<div id="dvPriceModel_Sinhala" style="display: none">
        <img src="../../Images/PriceModel-Sinhala.png" class="img-thumbnail" />
    </div>
	<div id="dvPriceModel_Tamil" style="display: none">
        <img src="../../Images/PriceModel-Tamil.png" class="img-thumbnail" />
    </div>



     <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
     <asp:HiddenField ID="hdnCounterRunTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseTotalTime" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeElapsedMin" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeElapsedSec" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTimeLeft" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRSPExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
   <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnGoToMeetingURL" runat="server" Value="0" />

     <asp:HiddenField ID="hdnPrepStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMeetingStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnMeetingDefaultTime" runat="server" Value="0" />

      <div id="dvDialog" style="display: none"></div>

    <div id="loader" class="loader-outerbg" style="display: none">
        <div class="loader"></div>
    </div>
</asp:Content>

