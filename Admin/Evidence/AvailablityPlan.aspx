<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="AvailablityPlan.aspx.cs" Inherits="M3_Rating_RatingStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

            table th {
                color: #ffffff;
                padding: 4px;
                font-size: 12px;
                font-weight: bold;
                text-align: center;
                background-color: #005D9B;
                border: 1px solid #eeeeee;
            }

            table td {
                color: #000000;
                padding: 2px;
                font-size: 12px;
                border: 1px solid #eeeeee;
                height: 30px;
                text-align: center;
            }
    </style>
    <style>
        /*.clsPastAndBlock {
            cursor: pointer;
            background-color: #C9302C; 
        }*/

        .clsOpen {
            cursor: pointer;
            background-color: #ffffff;
        }

        .clsPast {
            background-color: #D8D8D8;
        }

        .clsBlock {
            cursor: pointer;
            background-color: #FBE12D;
        }

        .clsBlockAndMapped {
            cursor: pointer;
            color:#ffffff;
            background-color: #8080C0;
        }

        .clsBlockAndExtended {
            background-color: #00BB00;
        }

        .clsBlockAndExtended-bottom {
            border-bottom-color: #00BB00;
        }

        .clsBlockAndExtendedAndMapped {
            color:#ffffff;
            background-color: #8000FF;
        }

        .clsBlockAndExtendedAndMapped-bottom {
            border-bottom-color: #8000FF;
        }

        .clslegend{
            padding:2px;
            width:30px;
            min-height:14px;
        }

        .clslegendlbl{
            font-weight:bold;
            padding-left:5px;
            padding-right:10px;
            text-align : left;
            min-height:14px;
        }
    </style>
    <script>
        var IsChecked = 0;
        var MonthArr = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        $(document).ready(function () {
            $("#ConatntMatter_divStatus").css("height", $(window).height() - 220);
            PageMethods.fnGetDetail($("#ConatntMatter_hdnLogin").val(), fnGetDetail_Success, fnFailed);

            setInterval(function () { fnUpdateDateTime(); }, 1000);
        });

        function fnUpdateDateTime() {
            var d = new Date();
            var strdate = d.getDate() + " " + MonthArr[d.getMonth()] + ", " + d.getFullYear() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
            $("#divDateTime").html(strdate);
        }

        function fnGetDetail_Success(result) {
            if (result != "") {
                var tbl = $.parseJSON(result);
                for (i = 0; i < tbl.length; i++) {
                    var td = $("#ConatntMatter_divStatus").find("table").eq(0).find("td[dd='" + tbl[i].Date + "'][hr='" + tbl[i].calendarTime + "']").eq(0);
                    $(td).attr("flgLocked", "1");
                    $(td).removeAttr("iden");
                    $(td).removeAttr("onclick");
                    $(td).css("cursor", "default");

                    $(td).html("");
                    if (tbl[i].UserCode != null && tbl[i].UserCode.toString() != '') {
                        $(td).attr("class", "clsBlockAndMapped");
                        $(td).html(tbl[i].UserCode.toString());
                    }
                    else {
                        $(td).attr("class", "clsBlock");
                    }
                    $(td).attr("flgblocked", "1");

                    //switch (tbl[i].flgExtendible.toString()) {
                    //    case "0":
                    //        $(td).html("");
                    //        if (tbl[i].UserCode != null && tbl[i].UserCode.toString() != '') {
                    //            $(td).attr("class", "clsBlockAndMapped");
                    //            $(td).html(tbl[i].UserCode.toString());
                    //        }
                    //        else {
                    //            $(td).attr("class", "clsBlock");
                    //        }
                    //        $(td).attr("flgblocked", "1");
                    //        break;
                    //    case "1":
                    //        $(td).html("<input type='checkbox' checked disabled/>");
                    //        if (tbl[i].UserCode != null && tbl[i].UserCode.toString() != '') {
                    //            $(td).attr("class", "clsBlockAndExtendedAndMapped clsBlockAndExtendedAndMapped-bottom");
                    //            $(td).html(tbl[i].UserCode.toString());
                    //        }
                    //        else {
                    //            $(td).attr("class", "clsBlockAndExtended clsBlockAndExtended-bottom");
                    //        }
                    //        $(td).attr("flgblocked", "2");
                    //        break;
                    //    case "2":
                    //        $(td).html("");
                    //        if (tbl[i].UserCode != null && tbl[i].UserCode.toString() != '') {
                    //            $(td).attr("class", "clsBlockAndExtendedAndMapped");
                    //        }
                    //        else {
                    //            $(td).attr("class", "clsBlockAndExtended");
                    //        }
                    //        $(td).attr("flgblocked", "3");
                    //        break;
                    //}
                }
            }
            $("#dvFadeForProcessing").hide();
        }

        function fnChangeAvailablity(ctrl) {
            if (IsChecked != 1) {
                var hr = parseInt($(ctrl).attr("hr"));
                var date = $(ctrl).attr("dd");
                var flgLocked = $(ctrl).attr("flgLocked");
                var flgBlocked = $(ctrl).attr("flgBlocked");

                if (flgLocked != "1") {
                    if (flgBlocked == "1") {
                        $(ctrl).attr("class", "clsOpen");
                        $(ctrl).attr("flgBlocked", "0");
                        $(ctrl).html('');

                        //var td_prev = $(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr - 1).toString() + "']").eq(0);
                        //if (td_prev.attr("flgBlocked") == "1" && td_prev.attr("flgLocked") != "1") {
                        //    td_prev.html("<input type='checkbox' onclick='fnExtended(this);'/>");
                        //}
                    }
                    else if (flgBlocked == "2") {
                        var td = $(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr + 1).toString() + "']").eq(0);

                        $(ctrl).attr("class", "clsOpen");
                        $(ctrl).attr("flgBlocked", "0");
                        $(ctrl).html('');

                        $(td).attr("class", "clsOpen");
                        $(td).attr("flgBlocked", "0");

                        //var td_prev = $(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr - 1).toString() + "']").eq(0);
                        //if (td_prev.attr("flgBlocked") == "1" && td_prev.attr("flgLocked") != "1") {
                        //    td_prev.html("<input type='checkbox' onclick='fnExtended(this);'/>");
                        //}
                    }
                    else if (flgBlocked == "3") {
                        var td = $(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr - 1).toString() + "']").eq(0);

                        $(td).attr("class", "clsOpen");
                        $(td).attr("flgBlocked", "0");
                        $(td).html('');

                        $(ctrl).attr("class", "clsOpen");
                        $(ctrl).attr("flgBlocked", "0");

                        //var td_prev = $(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr - 2).toString() + "']").eq(0);
                        //if (td_prev.attr("flgBlocked") == "1" && td_prev.attr("flgLocked") != "1") {
                        //    td_prev.html("<input type='checkbox' onclick='fnExtended(this);'/>");
                        //}
                    } 
                    else {
                        $(ctrl).attr("class", "clsBlock");
                        $(ctrl).attr("flgBlocked", "1");

                        //var trIndx = $(ctrl).closest("tr").attr("tr_index");
                        //if (trIndx == $(ctrl).closest('table').find("tbody").eq(0).find("tr").length) {
                        //    $(ctrl).html('');
                        //}
                        //else if ($(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr + 1).toString() + "']").eq(0).attr("flgBlocked") != "0") {
                        //    $(ctrl).html('');
                        //}
                        //else {
                        //    $(ctrl).html("<input type='checkbox' onclick='fnExtended(this);'/>");
                        //}

                        //$(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr - 1).toString() + "']").eq(0).html('');
                    }
                }
                else {
                    alert("Slot Locked !");
                }
            }
            else
                IsChecked = 0;
        }

        function fnExtended(ctrl) {
            IsChecked = 1;

            var flgLocked = $(ctrl).closest("td").attr("flgLocked");
            var hr = parseInt($(ctrl).closest("td").attr("hr"));
            var date = $(ctrl).closest("td").attr("dd");

            if (flgLocked != "1") {
                if ($(ctrl).is(":checked")) {
                    var td = $(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr + 1).toString() + "']").eq(0);

                    $(ctrl).closest("td").attr("class", "clsBlockAndExtended clsBlockAndExtended-bottom");
                    $(ctrl).closest("td").attr("flgBlocked", "2");

                    $(td).attr("class", "clsBlockAndExtended");
                    $(td).attr("flgBlocked", "3");
                }
                else {
                    var td = $(ctrl).closest('table').find("td[dd='" + date + "'][hr='" + (hr + 1).toString() + "']").eq(0);

                    $(ctrl).closest("td").attr("class", "clsBlock");
                    $(ctrl).closest("td").attr("flgBlocked", "1");

                    $(td).attr("class", "clsOpen");
                    $(td).attr("flgBlocked", "0");
                }
            }
            else {
                alert("Slot Locked !");
            }
        }

        function fnSave() {
            var ArrDataSaving = [];
            $("#ConatntMatter_divStatus").find("table").eq(0).find("td[iden='Action']").each(function () {
                switch ($(this).attr("flgBlocked")) {
                    case "1":
                        ArrDataSaving.push({ CalendarDate: $(this).attr("dd"), CalendarTime: $(this).attr("hr") + ":00:00", flgExtendible: '0' });
                        break;
                    case "2":
                        ArrDataSaving.push({ CalendarDate: $(this).attr("dd"), CalendarTime: $(this).attr("hr") + ":00:00", flgExtendible: '1' });
                        break;
                }
            });
            if (ArrDataSaving.length == 0) {
                ArrDataSaving.push({ CalendarDate: '0', CalendarTime: '0', flgExtendible: '0' });
            }

            $("#dvFadeForProcessing").show();
            PageMethods.fnSave(ArrDataSaving, $("#ConatntMatter_hdnLogin").val(), fnSave_Success, fnFailed);
        }

        function fnSave_Success(result) {
            if (result == "0") {
                alert("Plan Saved successfully !");

                $("#ConatntMatter_divStatus").find("table").eq(0).find("td[iden='Action']").each(function () {
                    switch ($(this).attr("flgBlocked")) {
                        case "1":
                            $(this).removeAttr("iden");
                            $(this).removeAttr("onclick");
                            $(this).css("cursor", "default");
                            $(this).attr("flgLocked","1");
                            $(this).html('');
                            break;
                        case "2":
                            $(this).removeAttr("iden");
                            $(this).removeAttr("onclick");
                            $(this).css("cursor", "default");
                            $(this).attr("flgLocked", "1");
                            $(this).find("input").eq(0).prop("disabled",true);
                            break;
                        case "3":
                            $(this).removeAttr("iden");
                            $(this).removeAttr("onclick");
                            $(this).css("cursor", "default");
                            $(this).attr("flgLocked", "1");
                            break;
                    }
                });
            }
            else {
                alert("Oops! Something went wrong. Please try again.");
            }
            $("#dvFadeForProcessing").hide();
        }

        function fnFailed(result) {
            alert("Oops! Something went wrong. Please try again.");
            $("#dvFadeForProcessing").hide();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div id="divDateTime" style="text-align: right; padding-bottom: 6px; font-size: 12px; font-weight: bold; margin-top: -12px;"></div>
    <div id="divLegend" style="padding-bottom: 5px;">
        <table>
            <tr>
                <td class="clsPast clslegend"></td>
                <td class="clslegendlbl" style="width:30%;">Past / Holiday</td>
                <td class="clsBlock clslegend"></td>
                <td class="clslegendlbl" style="width:30%;">Block</td>
                <td class="clsBlockAndMapped clslegend"></td>
                <td class="clslegendlbl" style="width:30%;">Block & Mapped</td>
                <%--<td class="clsBlockAndExtended clslegend"><input type="checkbox" checked disabled/></td>
                <td class="clslegendlbl">Block & Extended</td>
                <td class="clsBlockAndExtendedAndMapped clslegend"></td>
                <td class="clslegendlbl">Block & Extended & Mapped</td>--%>
            </tr>
        </table>
    </div>
    <div id="divStatus" runat="server" style="overflow-y: auto;"></div>
    <div id="divButton" style="text-align: center;"><a href="#" onclick="fnSave()" class="btns btn-submit">Submit</a></div>
    <div id="dvAlert" style="display: none;"></div>
    <div id="dvFadeForProcessing" style="display: block; position: fixed; text-align: center; z-index: 999999; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
        <img src="../../Images/blue-loading.gif" style="width: 90px; height: 70px; position: relative; top: 50%; margin-top: -35px;" />
    </div>
    <asp:HiddenField ID="hdnLogin" runat="server" />
</asp:Content>
