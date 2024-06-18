<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SlotBooking.aspx.cs" Inherits="M3_Rating_RatingStatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js" type="text/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" crossorigin="anonymous"></script>
    <link href="../../CSS/bootstrap.min.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        table {
            width: 100%;
            border-collapse: collapse;
        }

            table th {
                color: #ffffff;
                padding: 4px;
                font-size: 11px;
                font-weight: bold;
                text-align: center;
                background-color: #005D9B;
                border: 1px solid #eeeeee;
            }

            table td {
                color: #000000;
                padding: 2px;
                font-size: 10px;
                border: 1px solid #eeeeee;
                height: 28px;
                text-align: center;
		font-weight:bold;
            }
    </style>
    <style type="text/css">
        .clsPast {
            background-color: #D8D8D8;
        }

        /*.clsAvailable {
            cursor: pointer;
            background-color: #6CFF6C;
        }

        .clsAvailable-bottom {
            border-bottom-color: #6CFF6C;
        }*/

        .clsSelected {
            cursor: pointer;
            background-color: #FFAD04;
        }

        .clsSelected-top {
            border-top-color: #FFAD04;
        }

        /*.clsAvailableAndMapped {
            color: #ffffff;
            background-color: #0073AA;
        }

        .clsAvailableAndMapped-bottom {
            border-bottom-color: #0073AA;
        }*/


        .clslegend {
            padding: 2px;
            width: 30px;
            min-height: 14px;
        }

        .clslegendlbl {
            font-weight: bold;
            padding-left: 5px;
            padding-right: 10px;
            text-align: left;
            min-height: 14px;
        }

        .cls_1st_hr {
            cursor: pointer;
            background-color: #FBE12D;
        }

        .cls_2nd_hr {
            border-top: #F3AC05;
            background-color: #F3AC05;
        }
    </style>
    <script type="text/javascript">
        var IsChecked = 0;
        var MonthArr = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

        $(document).ready(function () {
            setInterval(function () { fnUpdateDateTime(); }, 1000);
            PageMethods.fnGetDetail($("#hdnLogin").val(), fnGetDetail_Success, fnFailed);
        });

        function fnUpdateDateTime() {
            var d = new Date();
            var strdate = d.getDate() + " " + MonthArr[d.getMonth()] + ", " + d.getFullYear() + " " + d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
            $("#divDateTime").html(strdate);
        }

        function fnSelectedTime(Hr) {
            return fnFormatTime(Hr) + " to " + fnFormatTime(parseInt(Hr) + parseInt($("#hdnSlotDuration").val()));
        }

        function fnFormatTime(Hr) {
            if (parseInt(Hr) > 12)
                return (parseInt(Hr) - 12).toString() + ":00 PM";
            else
                return Hr + ":00 PM";
        }

        function fnGetDetail_Success(result) {
            if (result.split("|@|")[0] != "1") {
                var ds = $.parseJSON(result.split("|@|")[1]);
                $("#hdnSlotDuration").val(ds.Table[0].Hours);
                var tbl_AvailableSlots = ds.Table1;
                var tbl_SelectedSlot = ds.Table2;

                if (tbl_AvailableSlots.length > 0) {
                    for (i = 0; i < tbl_AvailableSlots.length; i++) {
                        var td = $("#divStatus").find("table").eq(0).find("td[dd='" + tbl_AvailableSlots[i].Date + "'][hr='" + tbl_AvailableSlots[i].calendarTime + "']").eq(0);
                        if ($(td).attr("flgPast") != "1") {
                            if (tbl_AvailableSlots[i].flgSlot == 1) {
                                $(td).attr("class", "cls_1st_hr");
                                $(td).attr("onclick", "fnChangeAvailablity(this);");
                                $(td).attr("flgblocked", "1");
                            }
                            else {
                                $(td).attr("class", "cls_2nd_hr");
                                $(td).attr("flgblocked", "2");
                            }
                            $(td).attr("flgLocked", "0");
                        }
                        else {
                            $(td).attr("class", "cls_2nd_hr");
                        }
                    }

                    if (tbl_SelectedSlot.length > 0) {
                        //$("#divStatus").find("table").eq(0).find("td[iden='tdAction']").attr("flgLocked", "1");
                        //$("#divStatus").find("table").eq(0).find("td[iden='tdAction']").attr("onclick", "");

                        //for (i = 0; i < tbl_SelectedSlot.length; i++) {
                        //    var td = $("#divStatus").find("table").eq(0).find("td[dd='" + tbl_SelectedSlot[i].date + "'][hr='" + tbl_SelectedSlot[i].calendarTime + "']").eq(0);
                        //    if (tbl_SelectedSlot[i].flgSlot == 1) {
                        //        $(td).attr("class", "clsSelected");
                        //        $(td).attr("flgSelect", "1");
                        //    }
                        //    else {
                        //        $(td).attr("class", "clsSelected clsSelected-top");
                        //        $(td).attr("flgSelect", "2");
                        //    }
                        //}

                        $("#divStatus").html("<div style='text-align:center; width:100%; padding-top:20px; font-weight:bold; color:#0000FF;'>Your Slot booked for " + tbl_SelectedSlot[0].Date + " from " + fnSelectedTime(tbl_SelectedSlot[0].calendarTime) + ".<br/>A mail has been sent to you. Please re login 10 minutes before the scheduled appointment time, with the same login credentials.<br/><br/><b>Note : – Please logout and close the browser. Please login at the time of your appointment</b></div>");
                        $("#divLegend").hide();
                    }
                }
                else {
                    $("#divStatus").html("<div style='text-align:center; width:100%; padding-top:20px; font-weight:bold; color:#ff0000;'>No slot is currently available. Please try after some time or consult your BHR.</div>");
                    $("#divSwitchSlots").html('&nbsp;');
                }
            }
            else {
                $("#divStatus").html(result.split("|@|")[1]);
                $("#divSwitchSlots").html('&nbsp;');
            }
            $("#dvFadeForProcessing").hide();
        }

        function fnChangeAvailablity(ctrl) {
            var hr = parseInt($(ctrl).attr("hr"));
            var date = $(ctrl).attr("dd");
            var flgLocked = $(ctrl).attr("flgLocked");
            var flgBlocked = $(ctrl).attr("flgBlocked");

            if (flgLocked != "1") {
                if (flgBlocked == "1") {
                    $("#hdn_Selected_Date").val(date);
                    $("#hdn_Selected_Hr").val(hr);

                    $("#divAlert").show();
                    $("#divAlertbody").html("<div style='text-align:center; width:100%; padding-top:10px; font-weight:bold;'>Please confirm, You are booking a Slot for " + date + " from " + fnSelectedTime(hr) + ".</div>");

                    //$(ctrl).attr("class", "clsSelected");
                    //$(ctrl).attr("flgSelect", "1");

                    //var td_nxt = $("#divStatus").find("table").eq(0).find("td[dd='" + date + "'][hr='" + (parseInt(hr) + 1).toString() + "']").eq(0);
                    //$(td_nxt).attr("class", "clsSelected clsSelected-top");
                    //$(td_nxt).attr("flgSelect", "2");
                }
                else {
                    alert("Slot Locked!");
                }
            }
            else {
                alert("Slot not available for Past Hours!");
            }
        }

        function fnCloseModal() {
            $("#divAlert").hide();
        }

        function fnSaveSubmit() {
            var ArrDataSaving = [];
            //$("#divStatus").find("table").eq(0).find("td[flgSelect='1']").each(function () {
            //    switch ($(this).attr("flgBlocked")) {
            //        case "1":
            //            ArrDataSaving.push({ CalendarDate: $(this).attr("dd"), CalendarTime: $(this).attr("hr") + ":00:00", flgExtendible: '0' });
            //            break;
            //        case "2":
            //            ArrDataSaving.push({ CalendarDate: $(this).attr("dd"), CalendarTime: $(this).attr("hr") + ":00:00", flgExtendible: '1' });
            //            break;
            //    }
            //});

            ArrDataSaving.push({ CalendarDate: $("#hdn_Selected_Date").val(), CalendarTime: $("#hdn_Selected_Hr").val() + ":00:00", flgExtendible: '0' });
            if (ArrDataSaving.length == 0) {
                alert("Please select the Slot !");
            }
            else {
                $("#dvFadeForProcessing").show();
                PageMethods.fnSave(ArrDataSaving, $("#hdnLogin").val(), fnSave_Success, fnFailed);
            }
        }

        function fnSave_Success(result) {
            if (result != "1") {
                if (result != "0") {
                    $("#divStatus").html("<div style='text-align:center; width:100%; padding-top:20px; font-weight:bold; color:#0000FF;'>Your Slot booked for " + $("#hdn_Selected_Date").val() + " from " + fnSelectedTime($("#hdn_Selected_Hr").val()) + ".</div>");
parent.fnSetStatusForScheduling();
                }
                else {
                    alert("Slot already Booked. Please try again.");
                }
            }
            else {
                alert("Oops! Something went wrong. Please try again.");
            }
            $("#divAlert").hide();
            $("#dvFadeForProcessing").hide();
        }

        function fnFailed(result) {
            alert("Oops! Something went wrong. Please try again.");
            $("#dvFadeForProcessing").hide();
            $("#divAlert").hide();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server" EnablePageMethods="true"></asp:ScriptManager>
        <div style="margin-top: -12px; padding-bottom: 6px; font-size: 12px;">
            <div id="divDateTime" style="width: 100%; text-align: right; font-weight: bold; float: left; padding: 10px;"></div>
        </div>
     <div id="divLegend" style="padding-bottom: 5px;">
        <table style='width:40%;'>
            <tr>
                <td class="clsPast clslegend"></td>
                <td class="clslegendlbl" style="width:30%;">Past / Holiday</td>
                <td class="cls_1st_hr clslegend"></td>
                <td class="clslegendlbl" style="width:30%;">Slot Available for Booking</td>
            </tr>
        </table>
    </div>
        <div id="divStatus" runat="server" style="overflow-y: auto; width: 100%"></div>

        <div id="divAlert" style="display: none;" class="modal" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="padding: 2px;">
                    <div class="modal-header" style="padding: 2px">
                        <button type="button" class="close" aria-hidden="true" onclick="fnCloseModal()">
                            <img src="http://expediaholiday.d.seven2.net/_images/modal_close.png" />
                        </button>
                        <h3 class="modal-title" id="divAlertHead" style="font-size: 16px;"></h3>
                    </div>
                    <div class="modal-body" style="height: 100px; text-align: center; padding-top: 40px;" id="divAlertbody">
                    </div>
                    <div class="modal-footer" style="padding: 8px 30px 6px 5px" id="divAlertFooter">
                        <button type="button" data-backdrop="static" data-keyboard="false" class="btn btn-primary orange" onclick="fnSaveSubmit()">Confirm</button>
                        <button type="button" data-backdrop="static" data-keyboard="false" class="btn btn-primary orange" onclick="fnCloseModal()">Cancel</button>
                    </div>
                </div>
            </div>
        </div>
        <div id="dvFadeForProcessing" style="display: block; position: fixed; text-align: center; z-index: 999999; top: 0; bottom: 0; left: 0; right: 0; opacity: .80; -moz-opacity: 0.8; filter: alpha(opacity=80); background-color: #ccc;">
            <img src="../../Images/blue-loading.gif" style="width: 90px; height: 70px; position: relative; top: 50%; margin-top: -35px;" />
        </div>
        <asp:HiddenField ID="hdnLogin" runat="server" />
        <asp:HiddenField ID="hdn_Selected_Date" runat="server" />
        <asp:HiddenField ID="hdn_Selected_Hr" runat="server" />
        <asp:HiddenField ID="hdnSlotDuration" runat="server" />
    </form>
</body>
</html>
