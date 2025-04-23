<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true"
    CodeFile="frmUserSnapshots.aspx.cs" Inherits="_default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
   <%-- <link href="css/jquery-ui.css" rel="stylesheet" />
    <script src="js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="scripts/BootStrap/bootstrap.min.js"></script>
    <link rel="Stylesheet" type="text/css" href="scripts/BootStrap/bootstrap.min.css" />
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/fixedcolumns/3.2.3/js/dataTables.fixedColumns.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css" rel="stylesheet" />--%>

    <style type="text/css">
        div.clsloader {
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            height: 100%;
            z-index: 200;
            background-color: white;
            opacity: 0.5;
        }

        body {
            overflow-x: hidden !important;
        }

        .jqte_editor, .jqte_source {
            padding: 10px;
            background: #FFF;
            min-height: 260px;
            max-height: 900px;
            overflow: auto;
            outline: none;
            word-wrap: break-word;
            -ms-word-wrap: break-word;
            resize: vertical;
        }

        .jqte {
            margin: 0px !important;
        }

        .ui-dialog {
            z-index: 1200 !important;
        }

        fieldset {
            background-color: #eeeeee;
        }

            fieldset > div {
                padding-top: 4px;
                padding-left: 0.75em;
                padding-right: 0.75em;
            }

        legend {
            background-color: gray;
            color: white;
            padding: 5px 10px;
            font-size: 11pt;
        }

        input[type=file] {
            margin: 5px;
        }

        table.table {
            border-collapse: collapse;
            font-size: .75rem;
        }

        td.clslegendlbl {
            padding-right: 10px;
            font-size: 10px;
            font-weight: bold;
        }

        #tblCalendar img {
            width: auto;
        }

        #tblNormalImg td, #tblNormalImg1 td {
            padding: 2px !important;
        }

        #tblNormalImg, #tblNormalImg1 {
            width: auto !important;
        }

        .ui-dialog .ui-dialog-content {
            position: relative;
            border: 0;
            padding: 0.0em 0.15em;
            background: none;
            overflow: auto;
        }

        #divfilterheader {
            margin-bottom: 5px;
            text-align: center;
            font-size: 10pt;
            background-color: #fff;
            position: fixed;
            width: 94%;
            padding: 5px;
        }

            #divfilterheader > label {
                font-size: 10pt;
            }
    </style>

    <style>
        .switch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 24px;
            margin-bottom: 0px !important;
            padding: 0px !important
        }

            .switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
        }

            .slider:before {
                position: absolute;
                content: "";
                height: 19px;
                width: 19px;
                left: 4px;
                bottom: 3px;
                background-color: white;
                -webkit-transition: .4s;
                transition: .4s;
            }

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }

        /* Rounded sliders */
        .slider.round {
            border-radius: 34px;
        }

            .slider.round:before {
                border-radius: 50%;
            }
    </style>

    <script>
        $(document).ready(function () {
           // fnStartLoading();
            //$("#dvSummaryList").html("<span style='font-size:13px;font-weight:bold;'>Please wait...</span>");
            //PageMethods.Gettbl(fnSuccess, fnFail);
           // resizeElementHeight();
        });
        var Widthd = 0;
        function resizeElementHeight() {
            //debugger;
            var height = 0; var width = 0;
            var body = window.document.body;
            if (window.innerHeight) {
                height = window.innerHeight;
                width = window.innerWidth;
            } else if (body.parentElement.clientHeight) {
                height = body.parentElement.clientHeight;
                width = body.parentElement.clientWidth;
            } else if (body && body.clientHeight) {
                height = body.clientHeight;
                width = body.clientWidth;
            }
            Widthd = (width - 26);

            //document.getElementById("DataListMeasure1").style.width = (width - ($(".leftpanel").width()+26)) + "px";
            //document.getElementById("divPicContainer").style.width =(width-($(".leftpanel").width()+3))+"px";
            //document.getElementById("divPicContainer").style.height = ((height - (document.getElementById("divPicContainer").offsetTop + $("#FilterTree").height() + $("#divButton").height() + 20)) + "px");
            //fnGetWidth();
        }
        function fnGetWidth() {
            //alert((Widthd / 4)-10);
            $("#DataListMeasure1 img").closest("td").css("width", (Widthd / 4) - 10 + "px");
            $("#DataListMeasure1 img").closest("td").css("height", "180px");
        }

        function fnSuccess(result) {
            fnEndLoading();

            if (result == "" && result != -1) {
                $("#dvSummaryList").html("<span style='font-size:13px;font-weight:bold;color:red;'>No Record Found...</span>");
            }
            else {
                $("#dvSummaryList").html(result.split("|")[0]);

                var height = 0; var width = 0;
                var body = window.document.body;
                if (window.innerHeight) {
                    height = window.innerHeight;
                    width = window.innerWidth;
                } else if (body.parentElement.clientHeight) {
                    height = body.parentElement.clientHeight;
                    width = body.parentElement.clientWidth;
                } else if (body && body.clientHeight) {
                    height = body.clientHeight;
                    width = body.clientWidth;
                }

                var table = $("#tblSnapshots").DataTable({
                    paging: false,
                    "pagingType": "full_numbers",
                    "bLengthChange": false,
                    "bSort": false,
                    "info": false,
                    "bFilter": true,
                    "rowHeight": 'auto',
                    "pageLength": 20,
                    "columnDefs": [{ "targets": 2, "type": "date" }],
                    "order": [2, "desc"],
                    "binfo": true,
                    "scrollY": '55vh',
                    "scrollCollapse": true,
                    "bDestroy": true
                });
            }
        }

        function fnFail(err) {
            alert(err._message);
            $("#dvSummaryList").html("<span style='font-size:13px;font-weight:bold;color:red;'>" + err._message + "</span>");
            fnEndLoading();
        }

        function fnStartLoading() {
            $("#dvFadeForProcessing").css("display", "block");
        }

        function fnEndLoading() {
            $("#dvFadeForProcessing").css("display", "none");
        }

        function fnViewLargeImage(ctrl) {
            $("#dvDialog")[0].innerHTML = "<center><img style='height:300px;width:400px' src='" + $(ctrl).attr("src") + "' /></center>";
            $("#dvDialog").dialog({
                title: 'Image',
                modal: true,
                height: 'auto',
                width: 'auto',
                buttons: {
                    //"Close": function () {
                    //    $("#dvDialog").dialog("close");
                    //}
                }
            });
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
            margin-left: 5px;
        }

        #tblSnapshots th {
            color: #ffffff;
            font-size: 12px;
            font-weight: bold;
            font-family: Verdana;
            text-align: center !important;
            background-color: #26A6E7;
            border-top: 1px solid darkgray;
            border-right: 1px solid darkgray;
            border-bottom: 1px solid darkgray;
            padding:1px;
        }

        #tblSnapshots td {
            /*color: rgba(153, 153, 153, 1);*/
            font-size: 10px;
            font-family: Verdana;
            text-align: center;
            border-right: 1px solid darkgray;
            border-bottom: 1px solid darkgray;
        }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title">
        <h3 class="text-center">Proctoring Report</h3>
        <div class="title-line-center"></div>

    </div>
    <div class="form-group row">
       <label class="col-2 col-form-label" for="Cycle">Select Cycle</label>
        <div class="col-3">
            <asp:DropDownList ID="ddlCycleName" runat="server" CssClass="form-control" OnSelectedIndexChanged="ddlCycleName_SelectedIndexChanged" AppendDataBoundItems="true"  AutoPostBack="true">
            </asp:DropDownList>
        </div>

         <label class="col-2 col-form-label" for="Cycle">Select Employee:</label>
          <div class="col-3">
           <asp:DropDownList runat="server" DataValueField="EmpNodeId" DataTextField="FullName" AppendDataBoundItems="true" ID="ddlEmployee" CssClass="form-control" style="width:250px" OnSelectedIndexChanged="ddlEmployee_SelectedIndexChanged" AutoPostBack="true"><asp:ListItem Value="0">All</asp:ListItem></asp:DropDownList>
        </div>
         <div class="text-center" id="divBTNS">
        <a href="frmDashboard.aspx" class="btns btn-submit btns-small ml-5" id="anchorbtn_other1">Back</a>
    </div>
     
    </div>

  

    <div id="dvFadeForProcessing" style="position: fixed; z-index: 99999999; display: none; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <div id="Div1" runat="server" align="center" style="position: absolute; width: 150px; top: 30%; left: 45%;">
            <img alt="" title="Loading..." src="Images/loading.gif" />
        </div>
    </div>
    <div id="dvSummaryList" style="overflow-y: auto; overflow-x: hidden; width: 100%;">
         <asp:DataList ID="DataListMeasure1" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" RepeatLayout="Table" CellSpacing="0" CellPadding="0" Visible="true" Width="100%">
                                            <ItemTemplate>
                                                    <img id='<%# "img"+Convert.ToString(Container.ItemIndex+1) %>'  src='<%# "../../Snapshot/"+Convert.ToString(Eval("PicName")) %>' style="cursor:pointer;object-fit:contain;width:200px;height:180px" onclick='fnViewLargeImage(this);' />
                                                    <br />
                                                <table style="font-size:12px;width:100%">
                                                    <tr><td style="font-weight:bold">Photo No</td> <td>:</td> <td><%# Convert.ToString(Container.ItemIndex+1) %></td></tr>
                                                    <tr>
                                                        <td style="width: 55px;font-weight:bold" valign="top">Employee
                                                        </td>
                                                        <td>:</td>
                                                        <td style="font-size: 11px;"  flg="1"><%# Convert.ToString(Eval("FullName")) %></td>
                                                    </tr>
                                                   <tr>
                                                        <td style="width: 55px;font-weight:bold" valign="top">Assesment
                                                        </td>
                                                        <td>:</td>
                                                        <td style="font-size: 11px;"  flg="1"><%# Convert.ToString(Eval("Descr")) %></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 55px;font-weight:bold" valign="top">TakenTime
                                                        </td>
                                                        <td>:</td>
                                                        <td style="font-size: 11px;"  flg="1"><%# Convert.ToDateTime(Eval("PicTakenTime")).ToString("dd-MMM-yyyy HH:mm:ss") %></td>
                                                    </tr>
                                                </table>

                                            </ItemTemplate>
                                            
                                        </asp:DataList>
    </div>
    <div id="dvDialog" style="display: none;"></div>
    <!-- End First Box End For Graph -->
</asp:Content>
