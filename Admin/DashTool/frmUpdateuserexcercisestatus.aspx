<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmUpdateuserexcercisestatus.aspx.cs" Inherits="frmUpdateuserexcercisestatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
  
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    
    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
     <script src="https://cdn.datatables.net/fixedcolumns/3.2.3/js/dataTables.fixedColumns.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet" />

    <script src="Scripts/tableHeadFixer.js" type="text/javascript"></script>
 

    <script>
        function GetCurrentDate() {
            //var d = new Date();
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
            PageMethods.Gettbl(fnSuccessTarget, fnFail);
        });

        

      

        function fnStartLoading() {
            $("#dvFadeForProcessing").css("display", "block");
        }

        function fnEndLoading() {
            $("#dvFadeForProcessing").css("display", "none");
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
            /*width: 80%;
            margin-left:5px;*/
        }

        /*#clsStoretbl th {
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
        }*/

        .dataTable th {
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
            font-size: 12px;
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
       

        function clicklist(id) {
            var RSPExerciseId = $(id).attr("id");
            PageMethods.UpdatepearsonExerciseStatus(RSPExerciseId, exci_pass, fnFail);
           
        }

        function exci_pass(res) {
            //$("#dvTaskRptContent").html(res);
            fnEndLoading();
            window.location.reload();
        }

        function fnFail(err) {
            //alert(err._message);
            fnEndLoading();
        }

        function fnSuccessTarget(result) {
            fnEndLoading();
            if (result == "" && result != -1) {
                $("#dvSummaryList").html("<span style='font-size:13px;font-weight:bold;color:red;'>No Record Found...</span>");
            }
            else {
                $("#dvSummaryList").html(result.split("|")[0]);
                //$('#clsStoretbl tr').find('th:first').addClass("clsfirstCol");
                //$('#clsStoretbl tr').find('td:first').addClass("clsfirstCol");



                var table = $('#clsStoretbl').DataTable({
                    scrollCollapse: true,
                    scrollY: "400px",
                    paging: false,
                    "ordering": false,
                    "info": false,
                    "bFilter": false,
                    fixedHeader: {
                        header: true
                        
                    }
                });


                //var table = $('#clsStoretbl').DataTable({
                //    fixedHeader: true
                //});
                //$('#clsStoretbl').tableHeadFixer({
                //    //ht: $(window).height() - 200

                //});

                //var str = $('#clsStoretbl').parent().attr('id', 'divclstbl');
                //$('#divclstbl').css("overflow-x", "scroll");
                //$('#divclstbl').css("height", "400px");
                ////$('#cphRight_dvRpt').css("overflow-x", "scroll");
                //$('#divclstbl').css("max-height", "100%");

                //,
                //scrollCollapse: true,
                //paging: false,
                //"ordering": false,
                //"info": false,
                //"bFilter": false


            }

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

        a,
a label {
            font-weight:bold;
            cursor: pointer;
            
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" Runat="Server">
     <!-- Loading Effect -->
    <!-- End Loading Effect -->
    <!-- Default First Box Start For Graph -->
    <div id="dvFadeForProcessing" style="position: fixed; z-index: 99999999; display: none; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <div id="Div1" runat="server" align="center" style="position: absolute; width: 150px; top: 30%; left: 45%;">
            <img alt="" title="Loading..." src="Images/blue-loading.gif" />
        </div>
    </div>
  
            
      <div id="dvSummaryList" ></div>
       
</asp:Content>
