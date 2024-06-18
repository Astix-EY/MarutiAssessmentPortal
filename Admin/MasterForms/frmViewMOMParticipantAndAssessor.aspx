<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmViewMOMParticipantAndAssessor.aspx.cs" Inherits="frmViewMOMParticipantAndAssessor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">    
    <style type="text/css">
        .bg-blue{
            background:#194597;
        }
    </style>
    <script type="text/javascript">
        function fnViewMeeting(sender) {
            var MeetingLink = $(sender).attr("MeetingLink");
            var ParticipantAssessorMappingId = $(sender).attr("ParticipantAssessorMappingId")
            var meetingid= $(sender).attr("meetingid");
            var gotousername = $(sender).attr("gotousername");
            var gotopassword = $(sender).attr("gotopassword");
            var MeetingStartTime = $(sender).attr("MeetingStartTime");
            var MeetingEndTime = $(sender).attr("MeetingEndTime");
            var UserTypeID = 2;
            var flgAction = 3;
            fnViewMOM(sender,ParticipantAssessorMappingId, MeetingStartTime, MeetingEndTime, gotousername, gotopassword, meetingid);
        }
        function fnViewMOM(sender, ParticipantAssessorMappingId, MeetingStartTime, MeetingEndTime, gotousername, gotopassword, meetingid) {
            $("#loader").show();
            PageMethods.fnViewMOM(ParticipantAssessorMappingId, MeetingStartTime, MeetingEndTime, gotousername, gotopassword, meetingid, function (result) {
                $("#loader").hide();
                if (result.split("|")[0] == 1) {
                    alert('Error-' + result.split("|")[1]);
                } else {
                    if (result == "") {
                        alert("Meeting minutes still not available.");
                    } else if (result == "NA") {
                        alert("Meeting Not Recorded By Assessor.");
                    } else {
                        window.open(result, "_blank");
                        var CycleID = $("#ConatntMatter_ddlCycleName").val();
                        var LoginId = $("#ConatntMatter_hdnLoginId").val();
                        $("#loader").show();
                        PageMethods.fnGetParticipantDetails(CycleID, LoginId, 1, fnGetDisplaySuccessData, fnGetFailed);
                    }
                }
            }, function (result) {
                $("#loader").hide();
                alert("Error-" + result._message);
            });
        }

        function fnFail(err) {
            alert("Due to some technical error, we are unable to process your request !");
        }

        $(document).ready(function () {
            //fnEnableExerciseAutomatically();
           // setInterval("fnEnableExerciseAutomatically()", 10000);
        });

        function fnEnableExerciseAutomatically() {
            try {
                var LoginId = $("#ConatntMatter_hdnLoginId").val();
                var CycleID = $("#ConatntMatter_ddlCycleName").val();
                PageMethods.fnGetParticipantDetails(CycleID, LoginId, 2, function (result) {
                    if (result != "") {
                        var tbl = $.parseJSON(result);
                        if (tbl.length > 0) {
                            for (var i in tbl) {
							var RspExerciseID = tbl[i]["RspExerciseID"];
                                var ParticipantId = tbl[i]["ParticipantId"];
                                var ExerciseID = tbl[i]["ExerciseID"];
                                var MeetingActualStartTime = tbl[i]["MeetingActualStartTime"];
                                var sStatus = tbl[i]["Status"];
                                var flgShowLink = tbl[i]["flgShowLink"];
								$("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("a").attr("rspexerciseid",RspExerciseID)
                                $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("td[iden='mstatus']").html(sStatus);
                                if (flgShowLink == 1) {
                                    $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("a").show();
                                    var d = new Date(MeetingActualStartTime);
                                    $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("td[iden='mast']").html(d.toLocaleString());
                                } else {
                                    $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("a").hide();
                                }
                            }
                        }
                    }
                    }, function(result){});

            } catch (err) { }
        }

        $(document).ready(function () {
            var LoginId = $("#ConatntMatter_hdnLoginId").val();
            $("#loader").show();

            $("#ConatntMatter_ddlCycleName").on("change", function () {
                $("#ConatntMatter_dvMain")[0].innerHTML = "";
                $('#btnSave').hide();
                var CycleID = $("#ConatntMatter_ddlCycleName").val();
                $("#loader").show();
                PageMethods.fnGetParticipantDetails(CycleID, LoginId, 1, fnGetDisplaySuccessData, fnGetFailed);
            });

            var CycleID = $("#ConatntMatter_ddlCycleName").val();
            $("#loader").show();
            PageMethods.fnGetParticipantDetails(CycleID, LoginId, 1, fnGetDisplaySuccessData, fnGetFailed);
        });
        

        function fnGetDisplaySuccessData(result) {

            $("#loader").hide();

            $("#ConatntMatter_dvMain")[0].innerHTML = result;

            //---- this code add by satish --- //
            if ($("#tblEmp").length > 0) {

                $("#ConatntMatter_dvMain").prepend("<div id='tblheader'></div>");

                var wid = $("#tblEmp").width(), thead = $("#tblEmp").find("thead").eq(0).html();
                $("#tblheader").html("<table id='tblEmp_header' class='table table-bordered table-sm mb-0' style='width:" + (wid) + "px;'><thead>" + thead + "</thead></table>");
                $("#tblEmp").css({ "width": wid, "min-width": wid });
                for (i = 0; i < $("#tblEmp").find("th").length; i++) {
                    var th_wid = $("#tblEmp").find("th")[i].clientWidth;
                    $("#tblEmp_header, #tblEmp").find("th").eq(i).css({ "min-width": th_wid, "width": th_wid });
                }
                $("#tblEmp").css("margin-top", "-" + ($("#tblEmp_header")[0].offsetHeight) + "px");
                var secheight = $('.section-title').outerHeight(), nvheight = $(".navbar").outerHeight(), fgheight = $('.form-group').outerHeight();
                $('#dvtblbody').css({
                    'height': $(window).height() - (nvheight + secheight + fgheight + 130),
                    'overflow-y': 'auto',
                    'overflow-x': 'hidden'
                });
            }

        }
        function fnGetFailed(result) {
            alert(result.split("@")[1])
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title clearfix">
        <h3 class="text-center">Meetings History</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="form-group row">
        <label class="col-2 col-form-label" for="Cycle">Select Batch :</label>
        <div class="col-4">
            <asp:DropDownList ID="ddlCycleName" runat="server" CssClass="form-control" AppendDataBoundItems="true">
               
            </asp:DropDownList>
        </div>
    </div>
    <div id="dvMain" runat="server"></div>
    <asp:HiddenField runat="server" ID="hdnLoginId" Value="0" />
    <div id="loader" class="loader-outerbg" style="display: none">
        <div class="loader"></div>
    </div>
      <div id="dvDialog" style="display: none"></div>

</asp:Content>


