<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmAssignExcercise.aspx.cs" Inherits="M3_Rating_RatingStatus" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
    <script>
        $(document).ready(function () {
            $("#loader").hide();
            //$("#ConatntMatter_divStatus").css("height", $(window).height() - 200);
            $("#ddlAssessor").html($("#ConatntMatter_hdnAssessorMstr").val());
            //fnshowStatus();
            fnFixHeader();


            $('#txtSearchproduct').keyup(function () {
                var text = $(this).val().toUpperCase();
                $("#tbl_Status").find("tbody").eq(0).find("tr").css("display", "none");
                var tbl = $("#tbl_Status").find("tbody").eq(0).find("tr");
                var tr;
                for (var i = 0; i < tbl.length; i++) {
                    tr = $(tbl[i]);
                    var searchstr = $(tr).find("td").eq(0).text() + "," + $(tr).find("td").eq(1).text() + "," + $(tr).find("td").eq(2).text() + "," + $(tr).find("td").eq(8).text() + "," + $(tr).find("td").eq(9).text();
                    var flgValid = 1;
                    for (var t = 0; t < text.split(",").length; t++) {
                        if (searchstr.toLowerCase().indexOf(text.split(",")[t].toLowerCase()) == -1) {
                            flgValid = 0;
                        }
                    }
                    if (flgValid == 1) {
                        $(tr).css("display", "table-row");

                    }
                }
                fnFixHeader();
            });

        });

        function fnFixHeader() {
            $("#ConatntMatter_divStatus").scrollLeft(0);

            var thead = $("#tbl_Status").find("thead").eq(0).html();
            $("#ConatntMatter_divfixedHeader").html("<table id='tbl_Status_fixedhead'><thead>" + thead + "</thead><tbody></tbody></table>");
            for (i = 0; i < $("#tbl_Status").find("th").length; i++) {
                $("#tbl_Status_fixedhead").find("th").eq(i).css("min-width", $("#tbl_Status").find("th")[i].offsetWidth);
            }

            $("#ConatntMatter_divStatus").scroll(function () {
                $("#ConatntMatter_divfixedHeader").scrollLeft(this.scrollLeft);
            });

            $("#tbl_Status").css("margin-top", "-69px");
            $("#ConatntMatter_divfixedHeader").css("width", $("#ConatntMatter_divStatus")[0].clientWidth);
        }

        function fnAssignAssessor(ctrl) {
            $("#ddlAssessor").val($(ctrl).closest("td").attr("AssessorId"));

            $("#divAssessor").dialog({
                title: 'Please Assign the Assessor :',
                resizable: false,
                height: "auto",
                width: 350,
                modal: true,
                buttons: {
                    "Save": function () {
                        var RSPExId = $(ctrl).closest("td").attr("RSPExerciseId");
                        var AssessorId = $("#ddlAssessor").val();
                        var loginId = $("#ConatntMatter_hdnLogin").val();
                        var td_id = $(ctrl).closest("td").attr("id");

                        if (AssessorId != "0") {
                            $("#loader").show();
                            PageMethods.fnAssignAssessor(RSPExId, AssessorId, loginId, fnAssignAssessorSuccess, fnFail, td_id);
                            $(this).dialog("close");
                        }
                        else {
                            alert("Please Select the Assessor ! ");
                        }
                    },
                    "Cancel": function () {
                        $(this).dialog("close");
                    }
                }
            });
        }


        function fnshowStatus() {
            $("#loader").show();
            var CycleID = $("#ConatntMatter_ddlCycleName").val();
            PageMethods.frmGetStatus($("#ConatntMatter_hdnLogin").val(), CycleID, function (result) {
                $("#loader").hide();
                $("#ConatntMatter_divStatus").html(result);
                fnFixHeader();
            }, function (result) {
                $("#loader").hide();
                fnShowMsg(result._message);
            });
        }

        function fnshowReport(sender,rspid, flgReportGenerated) {
            if (flgReportGenerated == 0) {
                $("#loader").show();
                PageMethods.fnShowReport(rspid, function (result) {
                    $("#loader").hide();
                    if (result.split("|")[0] == "1") {
                        fnshowStatus();
                        var strRPT = result.split("|")[1].split("^");
                        var str = "<div style='width:250px'><table style='width:100%'>";
                        str += "<tr><td>1.</td><td><a href='" + strRPT[0] + "' style='color:blue;text-decoration:underline' target='_blank'>Detailed Feedback Report</a></td></tr>";
                        str += "<tr><td>2.</td><td><a href='" + strRPT[1] + "' style='color:blue;text-decoration:underline' target='_blank'>Mindset Report</a></td></tr>";
                        str += "<tr><td>3.</td><td><a href='" + strRPT[2] + "' style='color:blue;text-decoration:underline' target='_blank'>Pen Picture</a></td></tr>";
                        str += "<tr><td>4.</td><td><a href='" + strRPT[3] + "' style='color:blue;text-decoration:underline' target='_blank'>Snapshot</a></td></tr>";
                        str += "</table></div>";
                        fnShowMsg(str);
                    }
                    else {
                        fnShowMsg(result.split("|")[1]);
                    }
                }, function (result) {
                    $("#loader").hide();
                    fnShowMsg(result._message);
                });
            }
            else {
                var str = "<div style='width:250px'><table style='width:100%'>";
                str += "<tr><td>1.</td><td><a href='" + $(sender).closest("tr").attr("DetailedFeedbackReport") + "' style='color:blue;text-decoration:underline' target='_blank'>Detailed Feedback Report</a></td></tr>";
                str += "<tr><td>2.</td><td><a href='" + $(sender).closest("tr").attr("MindsetReportURL") + "' style='color:blue;text-decoration:underline' target='_blank'>Mindset Report</a></td></tr>";
                str += "<tr><td>3.</td><td><a href='" + $(sender).closest("tr").attr("PenPictureReportURL") + "' style='color:blue;text-decoration:underline' target='_blank'>Pen Picture</a></td></tr>";
                str += "<tr><td>4.</td><td><a href='" + $(sender).closest("tr").attr("TalentSnapshotURL") + "' style='color:blue;text-decoration:underline' target='_blank'>Snapshot</a></td></tr>";
                str += "</table></div>";
                fnShowMsg(str);
            }
           
        }


        function fnShowMsg(msg) {
            $("#divDialog1").html(msg);
            $("#divDialog1").dialog({
                title: 'Alert:',
                resizable: false,
                height: "auto",
                width: "auto",
                modal: true,
                close: function () {
                    $(this).dialog("destroy");
                },
                buttons: {
                    "OK": function () {
                        $(this).dialog("close");
                    }
                }

            });
        }

        function fnSubmitAndshowReport(sender,rspid, flg) {
            $("#divDialog1")[0].innerHTML = "Are you sure to " + (flg == 1 ? "submit" : "reverse") + " the same?";
            $("#divDialog1").dialog({
                title: 'Confirmation for submission :',
                resizable: false,
                height: "auto",
                width: "350",
                modal: true,
                buttons: {
                    "Yes": function () {
                        $(this).dialog("close");
                        $("#loader").show();
                        PageMethods.fnSubmitAndShowReport(rspid, $("#ConatntMatter_hdnLogin").val(), flg, function (result) {
                            $("#loader").hide();
                            if (result.split("|")[0] == 1) {
                                fnshowStatus();
                                var strRPT = result.split("|")[1].split("^");
                                var str = "<div style='width:250px'><table style='width:100%'>";
                                str += "<tr><td>1.</td><td><a href='" + strRPT[0] + "' style='color:blue;text-decoration:underline' target='_blank'>Detailed Feedback Report</a></td></tr>";
                                str += "<tr><td>2.</td><td><a href='" + strRPT[1] + "' style='color:blue;text-decoration:underline' target='_blank'>Mindset Report</a></td></tr>";
                                str += "<tr><td>3.</td><td><a href='" + strRPT[2] + "' style='color:blue;text-decoration:underline' target='_blank'>Pen Picture</a></td></tr>";
                                str += "<tr><td>4.</td><td><a href='" + strRPT[3] + "' style='color:blue;text-decoration:underline' target='_blank'>Snapshot</a></td></tr>";
                                str += "</table></div>";
                                fnShowMsg(str);
                                //window.open(result.split("|")[1], "_blank");
                            }
                            else if (result.split("|")[0] == 3) {
                                fnShowMsg("Status has been reversed now");
                                fnshowStatus();
                            }
                            else if (result.split("|")[0] == 2) {
                                fnShowMsg(result.split("|")[1]);
                                fnshowStatus();
                            }
                            else {
                                fnShowMsg(result.split("|")[1]);
                            }
                        }, function (result) {
                            $("#loader").hide();
                            fnShowMsg(result._message);
                        });
                    },
                    "No": function () {
                        $(this).dialog("close");
                    }
                }

            })

        }

        function fnResetTool(RspID, ExerciseID) {
            $("#divDialog1")[0].innerHTML = "Are you sure to reset this exercise?";
            $("#divDialog1").dialog({
                title: 'Confirmation :',
                resizable: false,
                height: "auto",
                width: "auto",
                modal: true,
                buttons: {
                    "Yes": function () {
                        $(this).dialog("close");
                        $("#loader").show();
                        PageMethods.fnResetTools(RspID, ExerciseID, function (result) {
                            $("#loader").hide();
                            if (result.split("|")[0] == 1) {
                                fnshowStatus();
                                fnShowMsg("Reset Now");
                                //window.open(result.split("|")[1], "_blank");
                            }
                            else if (result.split("|")[0] == 2) {
                                fnShowMsg(result.split("|")[1]);
                                fnshowStatus();
                            }
                            else {
                                fnShowMsg(result.split("|")[1]);
                            }
                        }, function (result) {
                            $("#loader").hide();
                            fnShowMsg(result._message);
                        });
                    },
                    "No": function () {
                        $(this).dialog("close");
                    }
                }

            })

        }


        function fnViewScore(ctrl) {
            $("#loader").show();
            PageMethods.fnViewScore($(ctrl).closest("tr").attr("EmpNodeId"), fnViewScore_pass, fnFail);
        }

        function fnViewScore_pass(res) {
            if (res.split("^")[0] == "0") {
                $("#divScore").html(res.split("^")[1]);

                $("#divScore").dialog({
                    title: 'View Score :',
                    resizable: false,
                    height: "auto",
                    width: 1000,
                    modal: true,
                    buttons: {
                        "Cancel": function () {
                            $(this).dialog("close");
                        }
                    }
                });
            }
            else {
                alert("Due to some technical error, we are unable to process your request !");
            }
            $("#loader").hide();
        }

        function fnFail(err) {
            $("#loader").hide();
            alert("Due to some technical error, we are unable to process your request !");
        }

        function fnAssignAssessorSuccess(res, td_id) {
            $("#loader").hide();
            if (res.split("^")[0] == "1") {
                alert("Due to some technical error, we are unable to process your request !");
            }
            else {
                var style = "";
                switch (res.split("^")[1]) {
                    case "1":
                        style = "color: #ffffff; background-color: #ff0000;";
                        break;
                    case "2":
                        style = "color: #000000; background-color: #ff9b9b;";
                        break;
                    case "3":
                        style = "color: #000000; background-color: #80ff80;";
                        break;
                    case "4":
                        style = "color: #000000; background-color: #8080ff;";
                        break;
                    case "5":
                        style = "color: #ffffff; background-color: #8000ff;";
                        break;
                    case "6":
                        style = "color: #ffffff; background-color: #0000a0;";
                        break;
                    default:
                        style = "color: #000000; background-color: transparent;";
                        break;
                }

                if (res.split("^")[3] == "1") {
                    var td = $("#tbl_Status").find("td[id='" + td_id + "']").eq(0);
                    td.attr("style", style);
                    td.find("a").eq(0).attr("style", style);
                    td.find("a").eq(0).html(res.split("^")[2]);
                }
                else {
                    var td = $("#tbl_Status").find("td[id='" + td_id + "']").eq(0);
                    td.attr("style", style);
                    td.html(res.split("^")[2]);
                }
            }
        }

        function fnCheckUncheck(ctrl) {
            if ($(ctrl).is(":checked")) {
                $("#tbl_Status tbody").find("input[type='checkbox']").prop("checked", true);
            }
            else {
                $("#tbl_Status tbody").find("input[type='checkbox']").prop("checked", false);
            }
        }

        function fnDownloadData() {
            var CycleID = $("#ConatntMatter_ddlCycleName").val();
            window.open("frmDownloadExcel.aspx?flg=2&CycleId=" + CycleID);
            //var ArrDataSaving = [];
            //$("#tbl_Status tbody").find("input[type='checkbox']").each(function () {
            //    if ($(this).is(":checked")) {
            //        //window.open("../../Report/" + $(this).attr("doc"), "_blank");
            //        ArrDataSaving.push({ ID: $(this).closest("tr").attr("EmpNodeId"), Val: $(this).attr("doc") });
            //    }
            //});

            //if (ArrDataSaving.length != 0) {
            //    PageMethods.fnRpt(ArrDataSaving, $("#ConatntMatter_hdnLogin").val(), fnRptSuccess, fnFail);
            //}
            //else {
            //    alert("Please select the Report/s for download !");
            //}
        }

        function fnRptSuccess(res) {
            if (res.split('^')[0] == "1") {
                alert("Due to some technical reasons, we are unable to download the Reports !");
            }
            else {
                window.open("../../Report/" + res.split('^')[1], "_blank");
            }
        }

        function fnScorecard() {
            var Emp = "";
            $("#tbl_Status tbody").find("input[type='checkbox']").each(function () {
                if ($(this).is(":checked")) {
                    Emp += "^" + $(this).closest("tr").attr("EmpNodeId");
                }
            });

            if (Emp != "") {
                $("#ConatntMatter_hdnScoreCardType").val("1");
                $("#ConatntMatter_hdnSelectedEmp").val(Emp.substring(1));
                $("#ConatntMatter_btnScore").click();
            }
            else {
                alert("Please select the Report/s for Score download !");
            }
        }

        function fnNewScorecard() {
            var Emp = "";
            $("#tbl_Status tbody").find("input[type='checkbox']").each(function () {
                if ($(this).is(":checked")) {
                    Emp += "^" + $(this).closest("tr").attr("EmpNodeId");
                }
            });

            if (Emp != "") {
                $("#ConatntMatter_hdnScoreCardType").val("2");
                $("#ConatntMatter_hdnSelectedEmp").val(Emp.substring(1));
                $("#ConatntMatter_btnScore").click();
            }
            else {
                alert("Please select the Report/s for Score download !");
            }
        }
    </script>

    <style>
        .main-box {
            max-width: 90%
        }

        table {
            width: 98%;
            border-collapse: collapse;
        }

            table th {
                color: #000000;
                padding: 4px;
                font-size: 13px;
                font-weight: bold;
                text-align: center;
                background-color: #dddddd;
                border: 1px solid #eeeeee;
            }

            table td {
                color: #000000;
                padding: 1px 0 1px 10px;
                font-size: 12px;
                border: 1px solid #eeeeee;
                text-align:left;
            }

        #tblAssessor {
            width: 98%;
        }


            #tblAssessor td {
                border: none;
                color: #000000;
                font-size: 13px;
                font-weight: bold;
            }

        #ddlAssessor {
            width: 200px;
            padding: 1px;
            font-weight: bold;
        }

        td.clslegendlbl {
            padding-right: 10px;
            font-size: 10px;
            font-weight: bold;
        }

        .clsDIv {
            overflow-y: auto;
            padding-bottom: 10px;
            width: 60%;
            display: inline-block;
            float: right;
            margin-top: 5px;
        }

        .clsInputsearch {
            width: 80%;
            display: inline-block;
            background-color: #ffffff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div id="loader" style="position: fixed; z-index: 9999; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <div align="center" style="position: absolute; width: 150px; top: 30%; left: 45%;">
            <img title="Loading..." src="../../Images/loading.gif" />
        </div>
    </div>

    <div class="form-group row">
        <label class="col-1 col-form-label" for="Cycle">Select Cycle</label>
        <div class="col-3">
            <asp:DropDownList ID="ddlCycleName" runat="server" CssClass="form-control" onchange="fnshowStatus()" AppendDataBoundItems="true">
            </asp:DropDownList>
        </div>

        <div class="col-7">
            <div id="div1" class="clsDIv">
                <input type="search" placeholder="search here" class="form-control clsInputsearch" id="txtSearchproduct" /><i class="fa fa-search" style="font-size: 18px; margin-left: -30px"></i></div>
        </div>
    </div>




    <div id="divLegend" runat="server" style="overflow-y: auto; padding-bottom: 10px;"></div>
    <div id="divfixedHeader" runat="server" style="width: 98%; overflow: hidden;"></div>
    <div id="divStatus" runat="server" style="overflow-y: auto; height: 450px;"></div>
    <div style="padding-top: 30px; display: block">
        <a href="#" onclick="fnDownloadData();" class="btns btn-submit">Download Excel</a>
    </div>
    <div style="padding-top: 30px; display: none">
        &nbsp;<a href="#" onclick="fnScorecard();" class="btns btn-submit">Download Scorecard</a>&nbsp;<a href="#" onclick="fnNewScorecard();" class="btns btn-submit">Download New Scorecard</a>
    </div>
    <div id="divAssessor" style="display: none;">
        <table style="width: 100%;" id="tblAssessor">
            <tr>
                <td>Assessor</td>
                <td style="width: 20px;">:</td>
                <td>
                    <select id="ddlAssessor"></select></td>
            </tr>
        </table>
    </div>
    <div id="divScore" style="display: none;">
    </div>
    <div id="divDialog1" style="display: none;"></div>
    <asp:HiddenField ID="hdnSelectedEmp" runat="server" />
    <asp:Button ID="btnScore" runat="server" Text="" OnClick="btnScoreCard_Click" Style="visibility: hidden;" />
    <asp:HiddenField ID="hdnLogin" runat="server" />
    <asp:HiddenField ID="hdnAssessorMstr" runat="server" />
    <asp:HiddenField ID="hdnScoreCardType" runat="server" />
</asp:Content>
