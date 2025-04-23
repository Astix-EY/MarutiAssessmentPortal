<%@ Page Title="" Language="VB" MasterPageFile="~/Task/MasterPage/Site.master" AutoEventWireup="false" CodeFile="ExerciseMain.aspx.vb" Inherits="Set1_Main_frmExerciseMain_New" %>

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
            $("#dvDialog").html("Are you sure you have completed all the exercises ?<br />Click OK if you have completed. Please note that you will be logged out and will not be able to resume once you click OK.<br />Click Cancel if you have NOT completed and need to go back to complete.");
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
            if (result.split("^")[0] == "1") {

                window.location.href = "../Exercise/ExerciseMain.aspx";

            }
            else if (result.split("^")[0] == "3") {
                fnEndLoading();
                alert("Please complete all the assessments first.");
            }
            else {
                fnEndLoading();
                alert("Oops! Something went wrong. Please try again.");
            }
        }
        function fnFailed() {
            alert("Error...")
        }
        function fnStartLoading() {
            $("#dvFadeForProcessing").show();
        }
        function fnEndLoading() {
            $("#dvFadeForProcessing").hide();
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
        function fnOpenTest(ToolID, LoginID) {

            if (ToolID == 1) {
                window.location.href = "../../DataA/Information/CompanyOverview.aspx?ToolID=" + ToolID + "&intLoginID=" + LoginID
            }
            else if (ToolID == 2) {
                window.location.href = "../../DataB/Information/CompanyOverview.aspx?ToolID=" + ToolID + "&intLoginID=" + LoginID
            }
            else if (ToolID == 3) {
                window.location.href = "../../DataC/Information/CompanyOverview.aspx?ToolID=" + ToolID + "&intLoginID=" + LoginID
            }
            else if (ToolID == 4) {
                window.location.href = "../../DataD/Information/CompanyOverview.aspx?ToolID=" + ToolID + "&intLoginID=" + LoginID
            }
            else if (ToolID == 5) {
                window.location.href = "../../DataE/Information/CompanyOverview.aspx?ToolID=" + ToolID + "&intLoginID=" + LoginID
            }
            else if (ToolID == 6) {
                window.location.href = "../../DataF/Information/CompanyOverview.aspx?ToolID=" + ToolID + "&intLoginID=" + LoginID
            }
            else if (ToolID == 7) {
                window.location.href = "../../DataG/Information/CompanyOverview.aspx?ToolID=" + ToolID + "&intLoginID=" + LoginID
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
        <script type="text/javascript">
            function fnGoBack() {
                window.location.href = "../../MainTask/Exercise/ExerciseMain.aspx";
            }

        </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
      <div class="back-btn">
                <a href="##" class="" onclick="fnGoBack()" id="btnBack"><i class="fa fa-arrow-left"></i>&nbsp;Back</a>
            </div>
    <div class="section-title">
        <h3 class="text-center">Task Details</h3>
        <span class="title-line-center"></span>
        <div>
            <br />
            <b>Note: You need to complete any two functional simulations listed below. The first area you chose will be considered as your primary competency and the second area that you chose will be considered as your secondary competency. </b></div>

    </div>
    <div id="dvExerciseName" runat="server" class="row absolute-center"></div>
    <div class="text-center mb-3" style="display: none">
        <asp:Button ID="btnFinalSubmit" runat="server" CssClass="btns btn-submit" Text="Submit" OnClientClick="fnShowFinalSubmitAlert(this); return false;" />
        <asp:Button ID="btnExperienceFeedback" runat="server" CssClass="btns btn-cancel" Enabled="false" Text="VDC Experience Form" />
        <asp:Button ID="btnFeedbackSession" runat="server" CssClass="btns btn-cancel" Enabled="false" Text="Flash Feedback Session" OnClientClick="fnShowExperienceFeedbackSession(this); return false;" />
    </div>
    <asp:HiddenField ID="hdnRspId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnCycleId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspStatus" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFlagFeedbackession" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFlagIDPSession" runat="server" Value="0" />
    <asp:HiddenField ID="hdnFeedbackGoToMeetingURL" runat="server" Value="" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

