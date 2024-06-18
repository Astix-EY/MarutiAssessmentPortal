<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true"     CodeFile="frmAttendencerpt.aspx.cs" Inherits="frmAttendencerpt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="css/jquery-ui.css" rel="stylesheet" />
    <script src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="scripts/BootStrap/bootstrap.min.js"></script>
    <link rel="Stylesheet" type="text/css" href="scripts/BootStrap/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
     <script src="https://cdn.datatables.net/fixedcolumns/3.2.3/js/dataTables.fixedColumns.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet" />

    <script src="scripts/jQueryRotate.js"></script>

    <script>
        function GetCurrentDate() {
            var d = new Date();
            var dat = d.getDate();
            var MonthArr = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            if (dat < 10) {
                dat = "0" + dat.toString();
            }
            return (dat + "-" + MonthArr[d.getMonth()] + "-" + d.getFullYear());
        }
  
        var colorArr = ["b3b3ff", "ccccff", "e6e6ff", "fafaff"]; //"8080ff","9999ff",
        $(document).ready(function () {
            //$("#datepicker").datepicker({ maxDate: '0', dateFormat: 'dd-M-yy' });
            //$("#datepicker").val(GetCurrentDate());
            fnStartLoading();
$("#dvSummaryList").html("<span style='font-size:13px;font-weight:bold;'>Please wait...</span>");
            PageMethods.Gettbl($("#ConatntMatter_hdnAssessorid").val(), fnSuccessTarget, fnFail);
        });

        function fnSuccessTarget(result) {
fnEndLoading();
            if (result == "" && result != -1) {
                $("#dvSummaryList").html("<span style='font-size:13px;font-weight:bold;color:red;'>No Record Found...</span>");
            }
            else {
                $("#dvSummaryList").html(result.split("|")[0]);
                $('#clsStoretbl tr').find('th:first').addClass("clsfirstCol");
                $('#clsStoretbl tr').find('td:first').addClass("clsfirstCol");
                var table = $("#clsStoretbl").removeAttr('width').DataTable({                   
                    scrollCollapse: true,
                    paging: false,
                    "ordering": false,
                    "info": false,
                    "bFilter": false                     
                });
            }
            
        }

        function fnFail(err) {
            alert(err._message);
$("#dvSummaryList").html("<span style='font-size:13px;font-weight:bold;color:red;'>"+err._message+"</span>");
            fnEndLoading();
        }

        function fnStartLoading() {
            $("#dvFadeForProcessing").css("display", "block");
        }

        function fnEndLoading() {
            $("#dvFadeForProcessing").css("display", "none");
        }

        function fnViewMap() {

            fnStartLoading();
            if ($("#ConatntMatter_ddlDSR").val() == "0|") {
                alert("Please Select the SR !");
                fnEndLoading();
                return false;
            }

            if ($("#datepicker").val() == null || $("#datepicker").val() == "") {
                alert("Please Select the Date !");
                fnEndLoading();
                return false;
            }

            var $form = $("<form/>").attr("id", "data_form")
                                .attr("action", "fnDSRTracker.aspx")
                                .attr("method", "post")
            //.attr("target", "_self");
            $("body").append($form);

            //Append the values to be send
            AddParameter($form, "strnode", $("#ConatntMatter_ddlDSR").val());
            AddParameter($form, "dat", $("#datepicker").val());
            $form[0].submit();
            return false;
        }

        function AddParameter(form, name, value) {
            var $input = $("<input />").attr("type", "hidden")
                                .attr("name", name)
                                .attr("value", value);
            form.append($input);
        }

        function fndownload(ctrl) {
            var EmpID = $(ctrl).attr("EmpId");
            var EmpName = $(ctrl).attr("EmpName");
            PageMethods.GetMails(EmpID,EmpName, fnSuccessMail, fnFail);
        }
        function fnSuccessMail(res) {
            //$("#dvSummaryList").html(res);
            document.getElementById("ConatntMatter_btnExport").click();
        }
        function fnFail(err) {
            alert(err._message);
            fnEndLoading();
        }
        function fnEndLoading() {
            $("#dvFadeForProcessing").css("display", "none");
        }

    </script>
    <style type="text/css">
        .content {
            padding-left: 0px;
            padding-right: 0px;
        }

        .img {
        }

        .lstCol {
        }
        #clsStoretbl {
            width: 80%;
            margin-left:5px;
        }

        #clsStoretbl th {
            padding: 2px;
            color: #ffffff;
            font-size: 12px;
            font-weight: bold;
            font-family: Verdana;
            text-align: center;
            background-color: #26A6E7;
            border-top: 1px solid darkgray;
            border-right: 1px solid darkgray;
            border-bottom: 1px solid darkgray;
        }

        #clsStoretbl td {
            padding: 1px;
            color: rgba(153, 153, 153, 1);
            font-size: 10px;
            font-family: Verdana;
            text-align: center;
            border-right: 1px solid darkgray;
            border-bottom: 1px solid darkgray;
        }

        #clsStoretbl td.clsfirstCol {
            border-left: 1px solid darkgray;
            text-align: left;
            padding-left: 5px;
        }
        #clsStoretbl td.clstd2 {
            text-align: left;
            padding-left: 5px;
        }

        #tblpoprpt {
            width: 97%;
            margin-left:5px;
            border-left: 1px solid darkgray;
        }

        #tblpoprpt th {
            padding: 2px;
            color: #ffffff;
            font-size: 10px;
            font-weight: bold;
            font-family: Verdana;
            text-align: center;
            background-color: rgba(46, 109, 164, 1);
            border-top: 1px solid darkgray;
            border-right: 1px solid darkgray;
            border-bottom: 1px solid darkgray;
        }

        #tblpoprpt td {
            padding: 1px;
            color: rgba(153, 153, 153, 1);
            font-size: 10px;
            font-family: Verdana;
            text-align: center;
            border-right: 1px solid darkgray;
            border-bottom: 1px solid darkgray;
        }
        #tblpoprpt td.clsrpttd0 {
            text-align:left;
            padding-left:5px;
        }
        #tblpoprpt td.clsrpttd1 {
            text-align:left;
            padding-left:5px;
        }
    </style>
    <script>
        function fnPopup(ctrl)
        {
            $("#TaskPopup").dialog({
                height: 600,
                width: 800,
                modal: true,
                buttons: {
                    "View Report": function () {
                        $("#TaskPopupRpt").dialog({
                            height: 450,
                            width: 700,
                            modal: true
                        }).prev(".ui-dialog-titlebar").css("background", "darkgray");
                        PageMethods.GetPopupRpt($(ctrl).attr("empid"), GetPopupRpt_pass, fnFail);
                    },
                    "Save": function () {
                        fnSaveRatings(1);
                    },
                    "Submit": function () {
                        fnSaveRatings(2);
                    },

                },
                close: function () {
                    PageMethods.Gettbl($("#ConatntMatter_hdnAssessorid").val(), fnSuccessTarget, fnFail);
                }
            });

            fnStartLoading();
            var excerciseid = $(ctrl).attr("excersiceid");
            $($("div.ui-dialog-buttonset").find("button")[0]).css("margin-right","550px");
            PageMethods.GetRatingPopup($("#ConatntMatter_hdnAssessorid").val(), excerciseid, fnSuccessRatingPopup, fnFail);
        }

        function fnSuccessRatingPopup(res) {
            $("#dvTaskContent").html(res);
            $("#Contentdiv").resizable({
                maxWidth: 760,
                minWidth: 760
            });
            $("#tblCompetency").find("select[iden='ddlrating']").each(function () {
                $(this).val($(this).attr("selval"));
            });
            fnEndLoading();
        }

        function GetPopupRpt_pass(res) {
            $("#dvTaskRptContent").html(res);
            fnEndLoading();           
        }

        function fnShowContent(ctrl) {
            $("#Contentdiv").html($(ctrl).attr("mailtext"));
            $("#Contentdiv").resizable({
                maxWidth: 760,
                minWidth: 760
            });
            //$("#trContenthead").css("display", "table-row");
            //$("#trContent").css("display", "table-row");
        }

        function fnSaveRatings(cntr) {
            fnStartLoading();
            var ArrRating = []; var flg = 0;
            $("#tblCompetency").find("select[iden='ddlrating']").each(function () {
                var AssmentRsltMainID = $(this).attr("AssmentRsltMainID");
                var AssmentRsltDetailID = $(this).attr("AssmentRsltDetailID");
                var Rating = $(this).val();
                var Remarks = $(this).closest("tr").find("textarea")[0].value;
                if(Rating == 0)
                {
                    flg = 1;
                }
                ArrRating.push({ AssmentRsltMainID: parseInt(AssmentRsltMainID), AssmentRsltDetailID: parseInt(AssmentRsltDetailID), Rating: parseInt(Rating), Remarks: Remarks });
            });
            if (flg == 1 && cntr == 2) {
                alert("Please Select the Rating !");
                fnEndLoading();
                return false;
            }
            else
                PageMethods.SaveRating(ArrRating, cntr, fnSuccessSaveRating, fnFail, cntr);
        }

        function fnSuccessSaveRating(res, cntr) {
            if (res == "0") {
                alert("Saved Successfully !");
                if (cntr == 2) {
                    $("#TaskPopup").dialog("close");
                    //PageMethods.Gettbl($("#ConatntMatter_hdnAssessorid").val(), fnSuccessTarget, fnFail);
                }
                else
                {
                    fnEndLoading();
                }
                
            }
            else {
                alert("Due to some technical reasons, we are unable to save records !");
                fnEndLoading();
            }
        }

        function fnopencomment(ctrl)
        {
            $("#TaskCommentContent").html($(ctrl).attr("remark"));
            $("#TaskComment").dialog({
                position: {
                    my: 'left bottom', at: 'left top', of: ctrl
                },
                modal: true
            }).prev(".ui-dialog-titlebar").css("display", "none");
        }
        function fnclosecomment() {
            $("#TaskComment").dialog("close");
        }
       
    </script>
    <style>
        .clslbl{
            color:blue;
            font-size:16px;
            font-weight:bold;
            font-family:Arial;
            padding-bottom:10px;
        }
        .clsContentdiv{
            font-size:11px;
            padding:8px;
            border:1px solid gray;
            height:150px;
            overflow-y:auto;
            background-color:lightgray;
        }

        #tblCompetency{
            width:100%;
            border-left:1px solid lightgray;
        }

        #tblCompetency th{
            background-color:rgba(46, 109, 164, 1);
            text-align:center;
            color:white;
            font-weight:bold;
            padding:5px;
            font-size:10px;
        }

        #tblCompetency td{
            padding:2px 0 0 5px;
            text-align:left;
            border-bottom:1px solid lightgray;
            border-right:1px solid lightgray;
        }

        #tblCompetency select{
            padding:2px 0 0 5px;
            text-align:left;
            width:96%;
            font-size:11px;
        }

        #tblMails{
            width:100%;
            border-left:1px solid lightgray;
        }

        #tblMails th{
            background-color:lightgray;
            text-align:center;
            font-weight:bold;
            padding:5px;
        }

        #tblMails td{
            padding:2px 0 0 5px;
            text-align:left;
            border-bottom:1px solid lightgray;
            border-right:1px solid lightgray;
            background-color:#ddd;
        }

        td.clsComp1{
            width:80px;
            font-size:11px;
        }
        td.clsComp2{
            width:120px;
            font-size:11px;
        }
        td.clsComp3{
            width:70px;
        }
        td.clsComp4{
            width:auto;
            font-size:10px;
        }
        .clsCompremark{
            font-size:10px;
        }
    </style>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="PageHeader" runat="Server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item active"><a class="white-text" href="frmAdminPage.aspx">Return To Home</a></li>
        <li class="breadcrumb-item">User Status</li>
    </ol>
</asp:Content>--%>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <!-- Loading Effect -->
    <!-- End Loading Effect -->
    <!-- Default First Box Start For Graph -->
    <div id="dvFadeForProcessing" style="position: fixed; z-index: 99999999; display: none; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <div id="Div1" runat="server" align="center" style="position: absolute; width: 150px; top: 30%; left: 45%;">
            <img alt="" title="Loading..." src="Images/loading.gif" />
        </div>
    </div>
    <div id="dvSummaryList" style=" overflow-y: auto; overflow-x:hidden; width:100%;"></div>
    <div id="TaskPopup" title="EY VDC" style="display:none;"><div id="dvTaskContent"></div></div>
    <div id="TaskPopupRpt" style="display:none;"><div id="dvTaskRptContent"></div></div>
    <div id="TaskComment" title="Comment" style="display:none; border-radius:10px;"><div id="TaskCommentContent"></div></div>
    <asp:Button ID="btnExport" Text="Export To Excel" CssClass="button1" runat="server" OnClick="btnExport_Click" style="visibility:hidden;"/>
    <asp:HiddenField ID="hdnAssessorid" runat="server" />
    <!-- End First Box End For Graph -->
</asp:Content>
