<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="AssessorRatingConfirmation.aspx.cs" Inherits="Data_Rpt_AssessorRating" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>
      

        .btns {
            color: #fff !important;
            padding: 7px 20px;
        }

            .btns:hover {
                color: #000 !important;
            }

        #ConatntMatter_divTask {
            width: 100%;
            overflow-x: hidden;
            overflow-y: auto;
        }

        table.tblTasksHeader2 th {
            background-color: cornflowerblue !important;
            color: #ffffff !important;
        }

        table#tblTasks3 th {
            background-color:bisque !important;
        }

        table.clstblTask th {
            font-weight: bold;
            text-align: center;
            vertical-align: middle;
        }

        table.clstblTask td {
        }

            table.clstblTask td:nth-child(1),
            table.clstblTask td:nth-child(2) {
                width: 12.5%;
                font-weight: normal !important;
            }

            table.clstblTask td:nth-child(3),
            table.clstblTask td:nth-child(4),
            table.clstblTask td:nth-child(5),
            table.clstblTask td:nth-child(6),
            table.clstblTask td:nth-child(7) {
                width: 15%;
                padding: 0;
            }

        tr.clsColor td {
            text-align: center;
            padding: 0;
            font-size: 0.76rem;
            border-bottom: 1px solid #ddd;
        }

        td.clsScore_0{
             background: #ff0000;
                text-align: center;
                color:#ffffff;
                font-size: 8pt;
        }
            tr.clsColor td.cls_0 {
                border-style: none !important;
                font-size: 8pt;
            }

            tr.clsColor td.cls_1 {
                background: #B3D335;
                text-align: left;
                font-size: 8pt;
            }

            tr.clsColor td.cls_2 {
                background: #F7941E;
                text-align: left;
                font-size: 8pt;
            }

            tr.clsColor td.cls_3 {
                background: #FF0000;
                color: #ffffff;
                text-align: left;
                font-size: 8pt;
            }

        td.clsColorBGGrayout {
            background: #cfcfcf;
        }

        .container {
            padding-left: 0px !important;
            padding-right: 0px !important;
        }

        table.table, .table > tbody > tr > td {
            border-top: 1px solid #ddd !important;
            text-align: left;
        }

        .container {
            width: 100% !important;
            max-width: 100% !important;
        }
        /* HIDE RADIO */
[type=radio] { 
  position: absolute;
  opacity: 0;
  width: 20px;
  height: 20px;
}

/* IMAGE STYLES */
[type=radio] + img {
  cursor: pointer;
}

/* CHECKED STYLES */
[type=radio]:checked + img {
  outline: 2px solid cornflowerblue;
}
    </style>
    <script type="text/javascript">
        function fnBack() {
            if ($("#ConatntMatter_hdnflg").val() == 1) {
                window.location.href = "frmAsseesorRating.aspx?str=" + $("#ConatntMatter_hdnRSPExerciseId").val();
            } else {
                window.location.href = "RatingStatus.aspx";
            }
        }

        $(document).ready(function () {
            if ($("#ConatntMatter_hdnflg").val() == 1) {
                if ($("#ConatntMatter_hdnValid").val() == "0") {
                    $("#ConatntMatter_btnSave").html("Continue");
                } else {
                    $("#ConatntMatter_btnSave").html("Submit For Task");
                }
            } else {
                $("#ConatntMatter_btnSave").html("Confirm");
            }
            //$("#ConatntMatter_divTask").height(($(window).height() - 160) + "px");
            var dvHieght = 200;
            if ($("#divmaincont3").length > 0) {
                dvHieght = 280;
            }
            $("#divmaincont1").css({ "height": ($(window).height() - dvHieght+50) / 2 + "px", "overflow-y": "auto", "overflow-x": "hidden" });
            $("#divmaincont2").css({ "height": ($(window).height() - dvHieght- 50) / 2 + "px", "overflow-y": "auto", "overflow-x": "hidden" });
            //$("#divmaincont2").css(($(window).height() - 180) / 2 + "px");

            
            $("#divmaincont1").before("<div id='tblheader1'></div>");
            var wid = $("#tblTasks1").width();
            var thead = $("#tblTasks1").find("thead").eq(0).html();
            $("#tblheader1").html("<table id='tblTasks_header1' class='table bg-white table-sm clstblTask' style='margin-top:-4px; margin-bottom:0; width:" + (wid - 1) + "px; min-width:" + (wid - 1) + "px;'><thead class='thead-light text-center'>" + thead + "</thead></table>");
            $("#tblTasks1").css("width", wid);
            $("#tblTasks1").css("min-width", wid);
            for (i = 0; i < $("#tblTasks1").find("th").length; i++) {
                var th_wid = $("#tblTasks1").find("th")[i].clientWidth;
                $("#tblTasks_header1").find("th").eq(i).css("min-width", th_wid);
                $("#tblTasks_header1").find("th").eq(i).css("width", th_wid);
                $("#tblTasks1").find("th").eq(i).css("min-width", th_wid);
                $("#tblTasks1").find("th").eq(i).css("width", th_wid);
            }
            $("#tblTasks1").css("margin-top", "-" + $("#tblTasks_header1")[0].offsetHeight + "px");

            $("#divmaincont2").before("<div id='tblheader2'></div>");
            var wid = $("#tblTasks2").width();
            var thead = $("#tblTasks2").find("thead").eq(0).html();
            $("#tblheader2").html("<table id='tblTasks_header2' class='table bg-white table-sm clstblTask tblTasksHeader2' style='margin-top:-4px; margin-bottom:0; width:" + (wid - 1) + "px; min-width:" + (wid - 1) + "px;'><thead class='thead-light text-center'>" + thead + "</thead></table>");
            $("#tblTasks2").css("width", wid);
            $("#tblTasks2").css("min-width", wid);
            for (i = 0; i < $("#tblTasks2").find("th").length; i++) {
                var th_wid = $("#tblTasks2").find("th")[i].clientWidth;
                $("#tblTasks_header2").find("th").eq(i).css("min-width", th_wid);
                $("#tblTasks_header2").find("th").eq(i).css("width", th_wid);
                $("#tblTasks2").find("th").eq(i).css("min-width", th_wid);
                $("#tblTasks2").find("th").eq(i).css("width", th_wid);
            }
            $("#tblTasks2").css("margin-top", "-" + $("#tblTasks_header2")[0].offsetHeight + "px");

           
            $("#divloader").hide();
        });

        function fnAction() {
            if ($("#ConatntMatter_hdnflg").val() == 1) {
                if ($("#ConatntMatter_hdnValid").val() == "0") {
                    window.location.href = "RatingStatus.aspx";
                } else {
                    var loginId = $("#ConatntMatter_hdnLoginID").val();
                    var RSPExId = $("#ConatntMatter_hdnRSPExerciseId").val();
                    var scon = confirm("Are you sure you want to proceed?")
                    if (scon) {
                        $("#loader").show();
                        PageMethods.fnIndividualExerciseSubmit(RSPExId, loginId, 2, function (result) {
                            $("#loader").hide();
                            if (result.split("|")[0] == "2") {
                                alert("Error-" + result.split("|")[1]);
                            }
                            else if (result.split("|")[0] == "1") {
                                alert("You can not submit till the Behavior duplicity across categories is removed");
                            }
                            else {
                                window.location.href = "RatingStatus.aspx";
                            }
                        }, fnFail);
                    }
                }
            } else {
                $("#divAlert").hide();
                var loginId = $("#ConatntMatter_hdnLoginID").val();
                var RSPExId = $("#ConatntMatter_hdnRSPExerciseId").val();
                var scon = confirm("Are you sure you want to proceed?")
                if (scon) {
                    $("#loader").show();
                    PageMethods.fnFinalSubmit(RSPExId, loginId, fnSubmitSuccess, fnFail);
                }
            }
        }

        function fnDeleteOrUpdateRating(sender, flg) {
            var ExcerciseRatingDetId = $(sender).attr("ExcerciseRatingDetId");
            var ExerciseCompetencyPLMapID = $(sender).attr("ExerciseCompetencyPLMapID");
            var RatingId = flg == 1 ? 0 : $(sender).val();
            var sconfirm = confirm("Are you sure to take action?");
            if (sconfirm) {
                $.ajax({
                    url: "frmAsseesorRating.aspx/fnRatingAssessorSavePLListForSubCompetency",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{ExcerciseRatingDetId:'" + ExcerciseRatingDetId + "',ExerciseCompetencyPLMapID:'" + ExerciseCompetencyPLMapID + "',RatingId:'" + RatingId + "'}",
                    success: function (result) {
                        $("#loader").hide();
                        if (result.d.split("|")[0] == "0") {
                            var PL = "";
                            if (flg == 1) {
                                if ($(sender).closest("td").prev().prev().attr("iden") == "pl") {
                                    var rowspancnt = $(sender).closest("td").prev().prev().attr("rowspan");
                                    rowspancnt = parseInt(rowspancnt) - 1;
                                    PL = $(sender).closest("td").prev().prev().html();
                                    var tr = $(sender).closest("tr").next();
                                    var tdLen = $(tr).find("td").length;
                                    $(sender).closest("tr").remove();
                                    if (rowspancnt > 0) {
                                        $(tr).find("td").eq(tdLen - 1).prev().before("<td iden='pl' rowspan='" + rowspancnt + "'>" + PL + "</td>");
                                    }
                                } else {
                                    var PL = $(sender).closest("td").attr("pl");
                                    PL = PL.replace("'", "");
                                    var tbl = $(sender).closest("table");
                                    $(sender).closest("tr").remove();
                                    var rowspancnt = $(tbl).find("td[iden='pl'][pl='" + PL + "']").attr("rowspan");
                                    rowspancnt = parseInt(rowspancnt) - 1;
                                    $(tbl).find("td[iden='pl'][pl='" + PL + "']").attr("rowspan", rowspancnt);
                                }
                            }
                        } else {
                            alert("Error-" + result.d.split("|")[1]);
                        }
                    },
                    error: function (msg) {
                        $("#loader").hide();
                        alert('Error-' + msg.statusText);
                    }
                });
            } else {
                if (flg == 2) {
                    var oldRating = $(sender).attr("oldrating");
                    //alert(oldRating);
                    $(sender).closest("td").find("input[type='radio'][value='" + oldRating + "']").prop("checked", true);
                }
            }
        }

        function fnSubmitSuccess(result) {
            $("#loader").hide();
            if (result == "0") {
                alert("Final Submit Successfully Done");
                window.location.href = "RatingStatus.aspx";
            }
            else {
                alert("Due to some technical error, we are unable to process your request !");
            }
        }

        function fnFail(err) {
            $("#loader").hide();
            alert("Due to some technical error, we are unable to process your request !");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <%--    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true"></asp:ScriptManager>--%>
    <div id="loader" class="loader_bg">
        <div class="loader"></div>
    </div>
    <div id="divHeader" runat="server"></div>
    <div id="divTask" runat="server"></div>
    <div id="divbtn" style="padding: 2px; width: 100%; text-align: center;">
        <a href="#" onclick="fnBack()" class="btns btn-submit">Go Back</a> &nbsp; 
        <a href="#" onclick="fnAction()" class="btns btn-submit" id="btnSave" runat="server">Continue</a>
    </div>
    <asp:HiddenField ID="hdnLoginID" runat="server" />
    <asp:HiddenField ID="hdnRSPExerciseId" runat="server" />
    <asp:HiddenField ID="hdnflg" runat="server" Value="0" />
    <asp:HiddenField ID="hdnValid" runat="server" Value="0" />
</asp:Content>

