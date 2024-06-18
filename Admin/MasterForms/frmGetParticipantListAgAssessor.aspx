<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmGetParticipantListAgAssessor.aspx.cs" Inherits="Admin_Evidence_frmGetParticipantListAgAssessor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">    
    <style type="text/css">
        div.clsloader {
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            height: 100%;
            z-index: 20000;
            background-color: white;
            opacity: 0.3;
        }
        .bg-blue{
            background:#194597;
        }
         .nav-tabs>li>a.active {
    background-color:#4472c4 !important;
    color:#ffffff !important;
}
         input[type=text]::-ms-clear {
            display: none;
        }

        .ui-autocomplete-loading {
            background: url('../../images/preloader_18.gif') no-repeat right center;
        }
        .ui-dialog{
            z-index:10000 !important;
        } 
    </style>
    <style type="text/css">
        .WaterMarkedTextBox {
            color: gray;
        }

        .NormalTextBox {
        }
    </style>
    <script language="javascript" type="text/javascript">
        function Focus(objname, waterMarkText) {
            obj = $(objname)[0];
            if (obj.value == waterMarkText) {
                obj.value = "";
                obj.style.color = "black";
            }
        }
        function Blur(objname, waterMarkText) {
            obj = $(objname)[0];
            if (obj.value == "") {
                obj.value = waterMarkText;
                obj.className = "WaterMarkedTextBox";
            }
            if (obj.value == waterMarkText) {
                obj.style.color = "gray";
            }
        }
    </script>
    <script>
        function whichButton(event) {
            if (event.button == 2)//RIGHT CLICK
            {
                alert("Not Allow Right Click!");
            }
        }
        function noCTRL(e) {
            //alert(e);
            //e.preventDefault();

            var code = (document.all) ? event.keyCode : e.which;
            var msg = "Sorry, this functionality is disabled.";
            if (parseInt(code) == 17) //CTRL
            {
                alert(msg);
                window.event.returnValue = false;
            }
        }

        function isNumberKeyNotDecimal(evt) {
            //debugger;
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;


            return true;
        }

        function isNumericWithOneDecimal(evt) {
            var val1;
            if (!(evt.keyCode == 46 || (evt.keyCode >= 48 && evt.keyCode <= 57)))
                return false;
            var parts = evt.srcElement.value.split('.');
            if (parts.length > 2)
                return false;
            if (evt.keyCode == 46)
                return (parts.length == 1);
            if (evt.keyCode != 46) {
                var currVal = String.fromCharCode(evt.keyCode);
                val1 = parseFloat(String(parts[0]) + String(currVal));
                if (parts.length == 2)
                    val1 = parseFloat(String(parts[0]) + "." + String(currVal));
            }



            if ($(evt.srcElement).is("[crlt]")) {
                if (parts.length == 2 && parts[1].length >= 2) {
                    return false;
                }
            }

            return true;
        }
    </script>
    <script>
        function fnChangeScore(sender) {
            var EmpNodeId = $(sender).closest("tr").attr("ParticipantId");
            var RspId = $(sender).closest("tr").attr("RspId");
            var CompNodeId = $(sender).closest("tr").attr("nodeid");
            var CompNodeType = $(sender).closest("tr").attr("nodetype");
            var FinalScore = $(sender).val();
            var FinalOldScore = $(sender).attr("old");
            if (FinalScore > 4) {
                alert("Score can not be greater than 4");
                $(sender).val(FinalOldScore);
                $(sender).focus();
                return false;
            }
            if (FinalScore < 1) {
                alert("Score can not be less than than 1");
                $(sender).val(FinalOldScore);
                $(sender).focus();
                return false;
            }
            var LoginId = $("#ConatntMatter_hdnLoginId").val();
            
            $(sender).addClass("ui-autocomplete-loading");
            PageMethods.fnUpdateCompetencyWiseScoreByAssessor(EmpNodeId,RspId,CompNodeId,CompNodeType,FinalScore,LoginId, function (result) {
                $(sender).removeClass("ui-autocomplete-loading");
                if (result.split("|")[0] == "2") {
                    alert("Error-" + result.split("|")[1]);
                    $(sender).val(FinalOldScore);
                    return false;
                } else {
                    $(sender).attr("old", FinalScore);
                }
            }, function (result) {
                $(sender).removeClass("ui-autocomplete-loading");
                $(sender).val(FinalOldScore);
                alert("Error-" + result._message);

                return false;
            });
        }
        function fnOpenLink(sender) {
            $("#myTab a.active").removeClass("active");
            $(sender).addClass("active");
            $("#myTabContent div.active").removeClass("active");
            var sHeight = "450";
            var flgExerciseStatus = $(sender).attr("flgExerciseStatus");
            if (flgExerciseStatus == 2) {
                var sUrl = "frmQusetionnaire.aspx?BandID=" + $(sender).attr("bandid") + "&RspID=" + $(sender).attr("RspID") + "&intLoginID=" + $(sender).attr("LoginId") + "&ExerciseID=" + $(sender).attr("ExerciseID");
                $("#divMainContent")[0].innerHTML = "<iframe id=\"Iframefrm\" src='" + sUrl + "' style=\"height: " + sHeight + "px; width: 100%; background-color: #fff\" frameborder=\"0\" name=\"Iframefrm\"  ></iframe>";
                $("#loader").show();
                $("#Iframefrm").on("load", function () {
                    $("#loader").hide();
                    });
            } else {
                $("#divMainContent")[0].innerHTML = "Task is not completed by Participant";
            }
        }
    </script>
    <script type="text/javascript">
        function fnOpenViewResponsesPop(sender) {
            var ParticipantId = $(sender).attr("ParticipantId");
            $("#dvDialog")[0].innerHTML = "Please wait...";
            $("#dvDialog").dialog({
                width: "85%",
                height:"590",
                modal: true,
                title: "View Responses",
                open:function(){
                    $("#loader").show();
                    PageMethods.fnGetParticipantResponses(ParticipantId, function (result) {
                        $("#loader").hide();
                        if (result.split("|")[0] == "1") {
                            var tbl = $.parseJSON(result.split("|")[1]);
                            if (tbl!="") {
                                var strHTML = "<ul class=\"nav nav-tabs\" id=\"myTab\" role=\"tablist\">";
                                for (var i in tbl.Table) {
                                    var ExerciseID = tbl.Table[i]["ExerciseID"];
                                    var Exercise = tbl.Table[i]["Exercise"];
                                    var RspID = tbl.Table[i]["RspID"];
                                    var RspExerciseID = tbl.Table[i]["RspExerciseID"];
                                    var LoginID = tbl.Table[i]["LoginID"];
                                    var BandID = tbl.Table[i]["BandID"];
                                    var flgExerciseStatus = tbl.Table[i]["flgExerciseStatus"];
                                    var strDisabled = "";
                                    
                                    strHTML += "<li class=\"nav-item\"><a onclick='fnOpenLink(this)' flgExerciseStatus='" + flgExerciseStatus + "' ExerciseID='" + ExerciseID + "' BandID='" + BandID + "' LoginID='" + LoginID + "' RspID='" + RspID + "' class=\"nav-link\" id='tab" + (ExerciseID) + "' data-toggle=\"tab\" href=\"###\" role=\"tab\" aria-controls=\"divMain\" aria-selected=\"false\">" + Exercise + "</a></li>";
                                }
                                strHTML += "</ul>";
                                strHTML += "<div class=\"tab-content\" id=\"myTabContent\">";
                                strHTML += "<div id='divMainContent' role=\"tabpanel\" aria-labelledby=\"divStarEarned-tab\" class=\"tab-pane\" style=\"display:block;overflow-y: auto; overflow-x: hidden;padding: 0px;\"></div>";
                                strHTML += "</div>";
                                $("#dvDialog")[0].innerHTML = strHTML;
                                $("#myTab a").eq(0).click();
                            }
                        } else {
                            $("#dvDialog")[0].innerHTML = "Error-" + result.split("|")[1];
                        }
                    }, function (result) {
                        $("#loader").hide();
                        $("#dvDialog")[0].innerHTML = "Error-" + result._message;
                    });
                },
                close:function(){
                    $("#dvDialog").dialog('destroy');
                }
            })
        }

        function fnOpenViewScorePop(sender) {
            var ParticipantId = $(sender).attr("ParticipantId");
            var RspId = $(sender).closest("tr").attr("RspId");
            $("#dvDialog")[0].innerHTML = "Please wait...";
            $("#dvDialog").dialog({
                width: "60%",
                height: "590",
                modal: true,
                title: "View & Edit Score",
                open: function () {
                    $("#loader").show();
                    PageMethods.fnGetParticipantScore(ParticipantId, function (result) {
                        $("#loader").hide();
                        var str = "Scoring entered by you is automatically saved.</br>";
                        str += "When you have finished the rating click on final submit button after which you will not able to edit the scores.";
                        $("#dvDialog")[0].innerHTML = "<div style='font-size:10pt;margin:5px 0px'>" + str + "</div><div id='divPop'>" + result.split("|")[1] + "</div>";
                        var flgFinalSubmit =result.split("|")[2];
                        if ($("#tblEmpFinalScore").length > 0) {
                            $("#divPop").prepend("<div id='tblheader1'></div>");
                            var wid = $("#tblEmpFinalScore").width(), thead = $("#tblEmpFinalScore").find("thead").eq(0).html();
                            $("#tblheader1").html("<table id='tblEmp_header1' class='table table-bordered table-sm mb-0' style='width:" + (wid) + "px;'><thead>" + thead + "</thead></table>");
                            $("#tblEmpFinalScore").css({ "width": wid, "min-width": wid });
                            for (i = 0; i < $("#tblEmpFinalScore").find("th").length; i++) {
                                var th_wid = $("#tblEmpFinalScore").find("th")[i].clientWidth;
                                $("#tblEmp_header1, #tblEmpFinalScore").find("th").eq(i).css({ "min-width": th_wid, "width": th_wid });
                            }
                            $("#tblEmpFinalScore").css("margin-top", "-" + ($("#tblEmp_header1")[0].offsetHeight) + "px");
                            var secheight = $('.section-title').outerHeight(), nvheight = $(".navbar").outerHeight(), fgheight = $('.form-group').outerHeight();
                            $('#dvtblbody1').css({
                                'height': "390",
                                'overflow-y': 'auto',
                                'overflow-x': 'hidden'
                            });
                        }
                        if (flgFinalSubmit == 1) {
                            $('#dvtblbody1').find("input:text").prop("disabled", true);
                            $('#dvtblbody1').find("input:text").css({"border-style": "none"});
                            $("div.ui-dialog-buttonset button").eq(0).hide();
                        }
                    }, function (result) {
                        $("#loader").hide();
                        $("#dvDialog")[0].innerHTML = "Error-" + result._message;
                    });
                },
                close: function () {
                    $("#dvDialog").dialog('destroy');
                },
                buttons: {
                    "Final Submit": function () {
                        $("#loader").show();
                        var LoginId = $("#ConatntMatter_hdnLoginId").val();
                        PageMethods.fnMarkFinalSubmitScore(RspId, LoginId, function (result) {
                            $("#loader").hide();
                            if (result.split("|")[0] == "1") {
                                alert("Error-" + result.split("|")[1]);
                            } else {
                                $("#dvDialog").dialog('close');
                            }
                        }, function (result) {
                            $("#loader").hide();
                            alert("Error-" + result._message);
                        });
                    },
                    "Close": function () {
                        $(this).dialog('close');
                    }
                }
            })
        }
        function fnStartMeeting(sender) {
            var MeetingLink = $(sender).attr("MeetingLink");
            var RspExerciseID = $(sender).attr("RspExerciseID")
            var meetingid= $(sender).attr("meetingid");
            var gotousername = $(sender).attr("gotousername");
            var gotopassword = $(sender).attr("gotopassword");
            var UserTypeID = 2;
            var flgAction = 3;
            fnUpdateActualStartEndTime(sender, UserTypeID, flgAction, RspExerciseID, gotousername, gotopassword, meetingid);
        }
        function fnUpdateActualStartEndTime(sender, UserTypeID, flgAction, RspExerciseID, gotousername, gotopassword, meetingid) {
            $("#loader").show();
            PageMethods.fnUpdateActualStartEndTime(RspExerciseID, UserTypeID, flgAction, gotousername, gotopassword, meetingid, function (result) {
                $("#loader").hide();
                if (result.split("|")[0] == "1") {
                    alert("Error-" + result.split("^")[1]);
                    
                } else {
                    fnEnableExerciseAutomatically();
                    window.open(result);
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
            setInterval("fnEnableExerciseAutomatically()", 10000);
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
                                var AssessmentTypeId = tbl[i]["AssmntTypeId"];
                                var MeetingActualStartTime =AssessmentTypeId==1? tbl[i]["MeetingActualStartTime"]:"";
                                var sStatus = tbl[i]["Status"];
                                var flgShowLink = tbl[i]["flgShowLink"];
                                $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("a.clslink").attr("rspexerciseid", RspExerciseID)
                                $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("td[iden='mstatus']").html(sStatus);
                                if (flgShowLink == 1) {
                                    $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("a.clslink").show();
                                    var d = new Date(MeetingActualStartTime);
                                    $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("td[iden='mast']").html(d.toLocaleString());
                                } else {
                                    $("#tblEmp tr[participantid='" + ParticipantId + "'][exerciseid=" + ExerciseID + "]").find("a.clslink").hide();
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
                    'height': $(window).height() - (nvheight + secheight + fgheight + 90),
                    'overflow-y': 'auto',
                    'overflow-x': 'hidden'
                });
            }

        }
        function fnGetFailed(result) {
            $("#loader").hide();
            alert(result._message);
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title clearfix">
        <h3 class="text-center">Upcoming Meetings</h3>
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
    <div id="loader" class="clsloader" style="display: none">
        <div class="loader"></div>
    </div>
      <div id="dvDialog" style="display: none"></div>

</asp:Content>


