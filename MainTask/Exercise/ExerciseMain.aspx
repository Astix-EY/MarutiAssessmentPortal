<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Site.master" AutoEventWireup="false" CodeFile="ExerciseMain.aspx.vb" Inherits="Set1_Main_frmExerciseMain_New" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>

    <style type="text/css">
        .disabledbutton {
            pointer-events: none;
            opacity: 0.4 !important;
        }

        .status_icon.disabled-icon {
            background-color: #dddddd;
            color: #666;
        }
    </style>


    <script type="text/javascript">
        function fnShowFinalSubmitAlert(ctrl) {
            //alert("1");
            $("#dvDialog").html("Are you sure you have completed all the exercises ?<br />Click OK if you have completed.<br />Click Cancel if you have NOT completed and need to go back to complete.");
            //alert("1");
            $("#dvDialog").dialog({
                modal: true,
                title: "Alert",
                width: '40%',
                maxHeight: 'auto',
                minHeight: 150,
                buttons: {
                    "Ok": function () {
                        fnStartLoading();
                        //window.location.href = "../Survey/frmSrvy.aspx";
                        PageMethods.SubmitFinalStatus(fnFinalSuccess, fnFailed);
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

            return false;
        }

        function fnFinalSuccess(result) {
            fnEndLoading();
            if (result.split("|")[0] == "1") {
                alert("Thank you, your responses have been saved.");
                window.location.href = "../Exercise/ExerciseMain.aspx";
                //window.open(result.split("|")[1], "_blank");
               
               // alert("Thank you, your responses have been saved. You will now be redirected to feedback form");
            }
            else if (result.split("|")[0] == "3") {
                fnEndLoading();
                alert("Please complete all the assessments first.");
            }
            else {
                fnEndLoading();
                alert("Oops! Something went wrong. Please try again.");
            }
        }
        function fnFailed() {
            fnEndLoading();
            alert("Error...")
        }
        function fnStartLoading() {
            $("#loader1").show();
        }
        function fnEndLoading() {
            $("#loader1").hide();
        }


        function fnSubmit() {

        }
    </script>

    <script type="text/javascript">
        $(function () {
            $('#panelhome').hide();
            $('#asidebtn').css({
                "margin-top": "62px"
            });

            $('.tab-contant-ex > .tab-panel-ex').hide();
            //$('.tab-contant-ex > .tab-panel-ex:first').show();
            $(".CSTab-4").show();
            $('#asidebtn > a').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                $('.tab-contant-ex > .tab-panel-ex').hide();
                $('.' + $(this).data('class')).fadeIn();
            });

        });
        function fnOpenTest(sender, ExerciseID, IsExternal, LoginID, ToolId, CandidateCode) {
            if (IsExternal == 1) {
                var redirectionURL = "https://ey-virtualsolutions.com/assessment1/frmTeststatus.aspx";
                //alert("Will be coming soon");

                var bandid = 1;// $("#ConatntMatterRight_hdnBandId").val();
                var student_email = $("#ConatntMatter_hdnEmailId").val();
                if (student_email == "") {
                    alert("Email Id is not available,kindy check this with support admin");
                    return false;
                }
                <%--var apikey = '<%=ConfigurationManager.AppSettings("iamneo:apikey")%>';
                var schoolCode = '<%=ConfigurationManager.AppSettings("iamneo:schoolCode")%>';--%>
               $("#dvloader").show();
               PageMethods.CallSPRspManage(ExerciseID, bandid, LoginID, student_email, function (result) {

                   if (result.split("|")[0] == "1") {
                       var secrettoken = "";// result.split("|")[1];
                       var rspexerciseid = result.split("|")[1];
                       // alert(result.split("|")[1]);
                       $("#dvloader").hide();
                       //window.location.href = "https://assessment1.ey-virtualsolutions.com?email=" + student_email + "&tokenid=" + secrettoken + "&rspexerciseid=" + rspexerciseid
                       if (ToolId == "9") {
                           window.location.href = $(sender).attr("url") + "&CandidateCode=" + CandidateCode + "&ExerciseCode=" + ExerciseID + "&redirectionurl=" + redirectionURL;
                           //window.open($(sender).attr("url"), "_blank");
                           //window.location.href = "https://assessment1.ey-virtualsolutions.com/Exam/StartExam?StudentID=8108889&ExamAssignmentID=30982307";
                       }
                       else {
                           //window.open($(sender).attr("url"), "_blank");
                           window.location.href = $(sender).attr("url") + "&CandidateCode=" + CandidateCode + "&ExerciseCode=" + ExerciseID + "&redirectionurl=" + redirectionURL;
                           // window.location.href = "https://assessment1.ey-virtualsolutions.com/Exam/StartExam?StudentID=8108889&ExamAssignmentID=30982206";
                       }

                   } else {
                       $("#dvloader").hide();
                       alert("Error:" + result.split("|")[1]);
                   }
               }, function (result) {
                   alert("Error:" + result._message)
                   $("#dvloader").hide();
               });

           }
           else if (IsExternal == 2) {
               //alert("Comming Soon");
               //return false;

               //alert(ExerciseID);
               //alert(IsExternal);
               //alert(LoginID);
               //alert(ToolId);

               if (ToolId == "8") {

                   var bandid = 1;// $("#ConatntMatterRight_hdnBandId").val();
                   var student_email = $("#ConatntMatter_hdnEmailId").val();
                   // alert(student_email);
                   $("#dvloader").show();
                   PageMethods.CallSPRspManage(ExerciseID, bandid, LoginID, student_email, function (result) {
                       //  alert(result.split("|")[1]);
                       if (result.split("|")[0] == "1") {
                           var secrettoken = "";// result.split("|")[1];
                           var rspexerciseid = result.split("|")[1];
                           var RspID = result.split("|")[2];


                           var ToolID = ToolId;//document.getElementById("ConatntMatterRight_hdnToolID").value;

                           //window.location.href = "../Questionnaire/CaseProbing.aspx?MenuId=6" + "&RspID=" + RspID + "&ExerciseID=" + ExerciseID + "&ExerciseType=0&TotalTime=0&intLoginID=" + LoginID + "&ToolID=" + ToolID
                           window.location.href = "../Information/CompanyOverview.aspx?MenuId=6" + "&RspID=" + RspID + "&ExerciseID=" + ExerciseID + "&ExerciseType=0&TotalTime=0&intLoginID=" + LoginID + "&ToolID=" + ToolID
                       } else {
                           $("#dvloader").hide();
                           alert("Error:" + result.split("|")[1]);
                       }
                   }, function (result) {
                       alert("Error:" + result._message)
                       $("#dvloader").hide();
                   });

               }
               else {

                   var bandid = 1;// $("#ConatntMatterRight_hdnBandId").val();
                   var student_email = $("#ConatntMatter_hdnEmailId").val();
                   // alert(student_email);
                   $("#dvloader").show();
                   PageMethods.CallSPRspManage(ExerciseID, bandid, LoginID, student_email, function (result) {
                       //  alert(result.split("|")[1]);
                       if (result.split("|")[0] == "1") {
                           var secrettoken = "";// result.split("|")[1];
                           var rspexerciseid = result.split("|")[1];
                           var RspID = result.split("|")[2];


                           var ToolID = ToolId;//document.getElementById("ConatntMatterRight_hdnToolID").value;
                           window.location.href = "../Questionnaire/frmQusetionnaire_Task3.aspx?MenuId=6" + "&RspID=" + RspID + "&ExerciseID=" + ExerciseID + "&ExerciseType=0&TotalTime=0&intLoginID=" + LoginID + "&ToolID=" + ToolID
                       } else {
                           $("#dvloader").hide();
                           alert("Error:" + result.split("|")[1]);
                       }
                   }, function (result) {
                       alert("Error:" + result._message)
                       $("#dvloader").hide();
                   });

               }



           }
           else {
               window.location.href = "../../Task/Exercise/ExerciseMain.aspx";
           }



       }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            if ($("#ConatntMatterRight_hdnRspStatus").val() != 2) {
                //    alert("here")
                //fnEnableExerciseAutomatically();
                //setInterval("fnEnableExerciseAutomatically()", 5000);
            }
        });

        function fnEnableExerciseAutomatically() {
            //    debugger;
            var RspId = $("#ConatntMatterRight_hdnRspId").val();
            // alert(RspId)
            if (RspId > 0) {
                try {
                    //  debugger;
                    PageMethods.fnEnableExerciseAutomatically(RspId, function (result) {
                        if (result.split("^")[0] == "1") {
                            var sData = $.parseJSON('[' + result.split("^")[1] + ']');
                            for (var i in sData[0]) {
                                var ExerciseId = parseInt(sData[0][i].ExerciseId);
                                var flgExerciseStatus = parseInt(sData[0][i].flgExerciseStatus);
                                var ExerciseStartDateTime = sData[0][i].ExerciseStartDateTime;
                                var CurrentDateTime = sData[0][i].CurrentDateTime;
                                var flgOpen = sData[0][i].flgOpen;
                                if (flgExerciseStatus == 2) {
                                    $("#btnTask_" + ExerciseId).val("Completed");
                                    $("#btnTask_" + ExerciseId).closest("div.panel-box").removeClass("panel-box-default").addClass("panel-box-success");
                                    $("#btnTask_" + ExerciseId).removeAttr("onclick");
                                    //   $("#btnTask_" + ExerciseId).prop("disabled", true);
                                    //  $("#btnTask_" + ExerciseId).addClass("disabledbutton");
                                } else if (flgOpen == 1) {
                                    $("#btnTask_" + ExerciseId).prop("disabled", false);
                                    $("#btnTask_" + ExerciseId).removeAttr("disabled");
                                    $("#btnTask_" + ExerciseId).removeClass("disabled");
                                    $("#btnTask_" + ExerciseId).removeClass("disabledbutton");
                                    $("#spanMark_" + ExerciseId).removeClass("status_icon disabled-icon fa fa-ban");
                                }
                                else {
                                    $("#btnTask_" + ExerciseId).prop("disabled", true);
                                    $("#btnTask_" + ExerciseId).addClass("disabledbutton");
                                    $("#spanMark_" + ExerciseId).addClass("status_icon disabled-icon fa fa-ban");
                                }
                            }
                        }
                    }
                    );
                } catch (err) { }
            }
        }

        function fnShowExperienceFeedbackSession(sender) {

            var MeetingURL = document.getElementById("ConatntMatterRight_hdnFeedbackGoToMeetingURL").value;
            if (MeetingURL.trim() == "") {
                alert("Feedback session meeting not available!")
                return false;
            }

            window.open(MeetingURL)
        }
        function fnShowExperienceFeedback() {
            window.location.href = "../Information/ParticipantExperienceEvaluation.aspx?RspID=" + $("#ConatntMatterRight_hdnRspId").val();
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title">
        <h3 class="text-center">Task Details</h3>
        <span class="title-line-center"></span>

    </div>
    <div id="dvExerciseName" runat="server" class="row absolute-center"></div>
    <div class="text-center mb-3" style="display: block">
        <asp:Button ID="btnFinalSubmit" runat="server" CssClass="btns btn-cancel" Enabled="false" Text="Final Submit" OnClientClick="fnShowFinalSubmitAlert(this); return false;" />
        <asp:Button ID="btnExperienceFeedback" runat="server" CssClass="btns btn-cancel" Enabled="false" Text="Feedback Form" />
        <%-- <asp:Button ID="btnFeedbackSession" runat="server" CssClass="btns btn-cancel" Enabled="false" Text="Flash Feedback Session" OnClientClick="fnShowExperienceFeedbackSession(this); return false;" />--%>
    </div>
    <div id="loader1" style="position: fixed; z-index: 9999999999999; display: none; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <div id="Div2" runat="server" align="center" style="font-size:15pt;font-weight:bold;position: absolute; width: 35%; top: 30%; left: 45%;">
            <img alt="" title="Loading..." src="../../Images/preloader_18.gif" style="width:40px" /> Report is being generated, please wait....
        </div>
    </div>


     <div id="dvloader" class="clsloader" style="display: none">
        <div class="loader"></div>
    </div>
    
    <asp:HiddenField ID="hdnEmailId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCycleId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFlagFeedbackession" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFlagIDPSession" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFeedbackGoToMeetingURL" runat="server" Value="" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

