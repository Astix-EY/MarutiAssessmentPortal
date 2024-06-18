<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Site.master" AutoEventWireup="false" CodeFile="Mytask.aspx.vb" Inherits="Data_Information_myTask" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
      <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#rolehead").css("display", "none");
            $("#liBackground").css("display", "none");           

           // $("#ConatntMatter_hdnStatus").val().toString();
            fnChangeDataBasedOnLanguage(1)           

        });

        function fnChangeDataBasedOnLanguage(X)
        {
           
            var LngID = $("#hdnLngID").val();
            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }
            var statusval = 0
            if (LngID == 2) // INDONESIA
            {
                $("#btnBack").html("Kembali");
                $("#hdngMYTask").html("Tugas saya");
                $("#dvTutorial").html("Tutorial");
                $("#tdTutorialTask").html("Tugas");
                $("#tdTutorial").html("Tutorial");
                $("#tdTutorialTime").html("Waktu");
                $("#dvInventory").html("Inventarisasi Pengembangan Kemampuan");
                $("#tdInventoryTask").html("Tugas");
                $("#tdInventoryTime").html("Waktu");

                    if (statusval == "0") {
                        $("#btntutorial").html("Tutorial in Bahasa Inggeris");
                        $("#btnassessment").html("Mulai CDI");

                    }
                    else if (statusval == "1") {
                        $("#tutorial").html("Complete");
                        $("#btnassessment").html("Mulai CDI");
                        $("#btnassessment").attr("flg", "1");

                    }
                    else if (statusval == "2") {
                        $("#btntutorial").html("Lengkap");
                        $("#btnassessment").html("Tidak lengkap");
                        $("#btnassessment").attr("flg", "1");

                    }
                    else {
                        $("#btntutorial").html("Lengkap");
                        $("#btnassessment").html("Lengkap");
                        $("#btnassessment").attr("flg", "1");

                    }

            }

            else if (LngID == 3) {//SINHALA

                $("#btnBack").html("ආපසු");
                $("#hdngMYTask").html("මගේ කාර්යයන්");
                $("#dvTutorial").html("නිබන්ධනය");
                $("#tdTutorialTask").html("කාර්ය");
                $("#tdTutorial").html("නිබන්ධනය");
                $("#tdTutorialTime").html("කාලය");
                $("#dvInventory").html("ශක්‍යතා සංවර්ධන ඉන්වෙන්ටරි");
                $("#tdInventoryTask").html("කාර්ය");
                $("#tdInventoryTime").html("කාලය");

                if (statusval == "0") {
					$("#btntutorial").css({ "font-size": ".75rem", "width": "185px" });
                    $("#btnassessment").css({ "font-size": ".75rem", "width": "185px", "line-height": "36px" });
                    $("#btntutorial").html("ඉංග්‍රීසියෙන් නිබන්ධනය ආරම්භ කරන්න ");
                    $("#btnassessment").html("ආරම්භ කරන්න CDI");

                }
                else if (statusval == "1") {
                    $("#btntutorial").html("සම්පූර්ණයි");
                    $("#btnassessment").html("ආරම්භ කරන්න CDI");
                    $("#btnassessment").attr("flg", "1");

                }
                else if (statusval == "2") {
                    $("#tutorial").html("සම්පූර්ණයි");
                    $("#btnassessment").html("අසම්පූර්ණයි");
                    $("#btnassessment").attr("flg", "1");

                }
                else {
                    $("#btntutorial").html("සම්පූර්ණයි");
                    $("#assessment").html("සම්පූර්ණයි");
                    $("#assessment").attr("flg", "1");

                }

            }

            else if (LngID == 1) {//TAMIL

                $("#btnBack").html("மீண்டும்");
                $("#hdngMYTask").html("எனது பணிகள்");
                $("#dvTutorial").html("பயிற்சி");
                $("#tdTutorialTask").html("பணி");
                $("#tdTutorial").html("பயிற்சி");
                $("#tdTutorialTime").html("நேரம்");
                $("#dvInventory").html("திறன் மேம்பாட்டு சரக்கு");
                $("#tdInventoryTask").html("பணி");
                $("#tdInventoryTime").html("நேரம்");

                if (statusval == "0") {				
                    $("#btntutorial").css({ "font-size": ".75rem", "width": "185px" });
                    $("#btnassessment").css({ "font-size": ".75rem", "width": "185px", "line-height": "36px" });
                    $("#btntutorial").html("ஆங்கிலத்தில் டுடோரியலைத் தொடங்குங்கள் ");
                    $("#btnassessment").html("தொடங்கு CDI");

                }
                else if (statusval == "1") {
                    $("#btntutorial").html("Complete");
                    $("#btnassessment").html("தொடங்கு CDI");
                    $("#btnassessment").attr("flg", "1");

                }
                else if (statusval == "2") {
                    $("#tutorial").html("Complete");
                    $("#btnassessment").html("Incomplete");
                    $("#btnassessment").attr("flg", "1");

                }
                else {
                    $("#btntutorial").html("Complete");
                    $("#assessment").html("Complete");
                    $("#assessment").attr("flg", "1");

                }

            }



            else {

                $("#btnBack").html("Back");
                $("#hdngMYTask").html("My Tasks");
                $("#dvTutorial").html("Tutorial");
                $("#tdTutorialTask").html("Task");
                $("#tdTutorial").html("Tutorial");
                $("#tdTutorialTime").html("Time");
                $("#dvInventory").html("Capability Development Inventory");
                $("#tdInventoryTask").html("Task");
                $("#tdInventoryTime").html("Time");

                    if (statusval == "0") {
                        $("#btntutorial").html("Start Tutorial");
                        $("#btnassessment").html("Start CDI");

                    }
                    else if (statusval == "1") {
                        $("#btntutorial").html("Complete");
                        $("#btnassessment").html("Start CDI");
                        $("#btnassessment").attr("flg", "1");

                    }
                    else if (statusval == "2") {
                        $("#tutorial").html("Complete");
                        $("#btnassessment").html("Incomplete");
                        $("#btnassessment").attr("flg", "1");

                    }
                    else {
                        $("#btntutorial").html("Complete");
                        $("#assessment").html("Complete");
                        $("#assessment").attr("flg", "1");

                    }

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

        function closePopup()
        {
            $('.modal').fadeOut(300);
            $("#myvideo")[0].pause();
        }
        function fndisplayVideo()
        {
           
            var LngID = $("#hdnLngID").val();
           // alert(LngID);
            var VideoSourcePath = "";
            VideoSourcePath = "../../videos/AxiataTutorial.mp4"
            //if (LngID == 2)
            //{
            //    VideoSourcePath = "../../videos/AxiataTutorial11.mp4"
            //}
            //else
            //{
            //    VideoSourcePath = "../../videos/AxiataTutorial.mp4"
            //}
            //$("#divcontent").css("display", "none");
            $("#div_video").css("display", "block");
            $(".modal-lg").css({ width: "100%" });
            $("#videoSource").attr('src', VideoSourcePath)
            $("#objectSource").attr('src', VideoSourcePath)

            fnplayPause($("#myvideo")[0]);
            $("#btnpause").html("<span class='fa fa-pause'></span>");
         
        }

        function fnPause() {
            fnplayPause($("#myvideo")[0]);
        }

        function fnReplay() {
            var myVideo = $("#myvideo")[0];
            myVideo.pause();
            myVideo.currentTime = '0';
            myVideo.play();
            $("#btnpause").html("<span class='fa fa-pause'></span>");
           
        }

        function fnplayPause(myVideo) {
            if (myVideo.paused) {
                myVideo.play();
                $("#btnpause").html("<span class='fa fa-pause'></span>");
               
            }
            else {
                myVideo.pause();
               $("#btnpause").html("<span class='fa fa-play'></span>");
               
            }
        }

        function fnProceed() {
            $("#div_video").css("display", "none");
            $("#myvideo")[0].pause();
            $("#tutorial").html("Complete");
            //$("#tutorial").css("display", "inline-block");
            $("#assessment").html("Start CDI");
            $("#assessment").attr("flg", "1");
        }

        function fnSuccessTarget(result) {
            if (result == "1") {
                alert("Due to some technical issue, we are unable to proceed further !");
            }
            else {
                //alert("11")
                $("#divcontent").css("display", "table-cell");
                $("#div_video").css("display", "none");
                $("#myvideo")[0].pause();
                if ($("#ConatntMatter_hdnStatus").val().toString() == "0") {
                    $("#ConatntMatter_hdnStatus").val("1");
                    $("#tutorial").html("Complete");
                    //$("#tutorial").css("display", "inline-block");
                    $("#assessment").html("Start Assessment");
                    $("#assessment").attr("flg", "1");
                }
            }
            $("#dvFade").css("display", "none");
        }

        function fnGoBack() {
            //alert("here")
            window.location.href = "Instructions.aspx"
        }

        function fnAssessment()
        {

            window.location.href = "CompanyOverview.aspx";

           /* if ($("#assessment").attr("flg") == "1") {
                window.location.href = "Groupoverview.aspx";

            }
            else {
                alert("Please, watch the tutorial first !");
            }*/
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="container">
        <div class="position-relative mb-5">
            <div class="back-btn">
                <a href="##" class="" onclick="fnGoBack()" id="btnBack"><i class="fa fa-arrow-left "></i>&nbsp;Back</a>
            </div>
            <div class="section-title">
                <h3 class="text-center" id="hdngMYTask">My Tasks</h3>
                <div class="title-line-center"></div>
            </div>
        </div>
        <div class="section-content">
            <div class="row absolute-center">
                <div class="col-sm-6 col-md-3" style="display:none">
                    <div class="panel-box panel-box-default">
                        <div class="box-title" style="background-image: url('../../Images/task-1.png')">
                            <div class="box-title-text" id="dvTutorial">Tutorial</div>
                        </div>
                        <div class="panel-body">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td style="width: 45%" id="tdTutorialTask">Task</td>
                                        <td id="tdTutorial">Tutorial</td>
                                    </tr>
                                    <tr>
                                        <td id="tdTutorialTime">Time</td>
                                        <td>00:05:00</td>
                                    </tr>
                                </tbody>
                            </table>
                            <a href="#" class="btn" onclick="fndisplayVideo();" id="btntutorial">Start Tutorial</a>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-3">
                    <div class="panel-box panel-box-default">
                        <div class="box-title" style="background-image: url('../../Images/task-2.png')">
                            <div class="box-title-text" id="dvInventory">Capability Development Inventory</div>
                        </div>
                        <div class="panel-body">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <td style="width: 45%" id="tdInventoryTask">Task </td>
                                        <td id="tdInventory">Inventory</td>
                                    </tr>
                                    <tr>
                                        <td id="tdInventoryTime">Time</td>
                                        <td>03:00:00</td>
                                    </tr>
                                </tbody>
                            </table>
                            <a href="#" class="btn" onclick="fnAssessment();" id="btnassessment">Start Assessment</a>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%--div_video for player --%>
    <div class="modal" id="div_video" style="display: none;">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Task Tutorial</h5>
                    <div class="close" onclick="closePopup();">&times;</div>
                </div>
                <div class="modal-body p-t-25">
                    <video width="100%" id="myvideo" vtime="0" poster="../../Images/please_wait.gif" controls>
                        <source src="../../videos/AxiataTutorial.mp4" type="video/mp4" id="videoSource">

                        <object>
                            <embed src="../../videos/AxiataTutorial.mp4" type="application/x-shockwave-flash" id="objectSource" allowfullscreen="false" allowscriptaccess="always" />
                        </object>
                        HTML5 Video is required for this video
                    </video>
                    <div id="divbtn" class="text-right mb-2">                    
                        <a href="#" title="Replay" onclick="fnReplay()"><span class="fa fa-repeat"></span></a>
                        <a href="#" title="Pause" onclick="fnPause()" id="btnpause"><span class="fa fa-pause"></span></a>
                        <a href="#" title="Proceed Further" onclick="fnProceed()"><span class="fa fa-arrow-right"></span></a>
                       
                    </div>
                   
                </div>
            </div>
        </div>
    </div>
    <%--<object>
        <embed src="../../videos/AxiataTutorial.mp4" type="application/x-shockwave-flash" allowfullscreen="false" allowscriptaccess="always" />
    </object>--%>
</asp:Content>

