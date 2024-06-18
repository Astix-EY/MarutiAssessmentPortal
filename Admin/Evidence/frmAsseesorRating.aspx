<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmAsseesorRating.aspx.cs" Inherits="frmAsseesorRating" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script>
        $(document).ready(function () {
            $("#loader").hide();

            $("#ConatntMatter_divleft").css("height", '100%');
            $("#dvleftList").css("max-height", $(window).height() - 160);
            //$("#divRight").css("min-height", $(window).height() - 150);

            //$("#divBody").css("max-height", $(window).height() - 180);
            $("#divBody").css("height", $(window).height() - 185);

        });

        function fnBack() {
            window.location.href = "RatingStatus.aspx";
        }

        function fnMailDetails(ctrl) {
            //var loginId = $("#ConatntMatter_hdnLogin").val();
            //var RSPExId = $("#ConatntMatter_hdnRSPExId").val();
            var ExcerciseRatingDetId = $(ctrl).attr("ExcerciseRatingDetId");
            $("#ulmain li.clsLIHightlight").removeClass("clsLIHightlight");
            $(ctrl).addClass("clsLIHightlight");
            $("#loader").show();
            $("#btnSaveContinue").hide();
            $.ajax({
                url: "frmAsseesorRating.aspx/fnGetDetailRpt",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{ExcerciseRatingDetId:'" + ExcerciseRatingDetId + "'}",
                success: function (response) {
                    $("#loader").hide();
                    if (response.d != "") {
                        $("#divBody").css("display", "block");
                        // $("#divBack").css("display", "none");

                        $("#ConatntMatter_hdnMailID").val(ExcerciseRatingDetId);
                        $("#btnSaveContinue").show();
                        $("#divBody").html(response.d);
                    }
                    else {
                        alert("No Details found !");
                    }
                },
                error: function (msg) {
                    $("#loader").hide();
                    alert('Error-' + msg.statusText);
                }
            });
        }

        function fnRatingAssessorSavePLListForSubCompetency(sender) {
            $("#divAlert").hide();
            var ExcerciseRatingDetId = $("#ConatntMatter_hdnMailID").val();
            var ExerciseCompetencyPLMapID = $(sender).closest("tr").attr("ExerciseCompetencyPLMapID");
            var RatingId = $(sender).val();
            $("#loader").show();
            PageMethods.fnRatingAssessorSavePLListForSubCompetency(ExcerciseRatingDetId, ExerciseCompetencyPLMapID, RatingId, function (result) {
                $("#loader").hide();
                if (result.split("|")[0] == "0") {
                    fnSetBGColor(sender);
                    $(sender).closest("tr").find("i").show();
                } else {
                    alert("Error-" + result.split("|")[1]);
                    $(sender).prop("checked", false);
                }
            }, function (result) {
                $("#loader").hide();
                alert("Error-" + result._message);
            });
        }

        function fnRatingAssessorSaveSubCompetencyScore(sender) {
            $("#divAlert").hide();
            var ExcerciseRatingDetId = $("#ConatntMatter_hdnMailID").val();
            var AnsVal = $(sender).val();
            $("#loader").show();
            PageMethods.fnRatingAssessorSaveSubCompetencyScore(ExcerciseRatingDetId, AnsVal, function (result) {
                $("#loader").hide();
                if (result.split("|")[0] == "1") {
                    alert("Error-" + result.split("|")[1]);
                   
                } else {
                    var MailId = $("#ConatntMatter_hdnMailID").val();
                    var li = $("#ConatntMatter_divleft").find("li[ExcerciseRatingDetId='" + MailId + "']").eq(0);
                    li.removeClass("clsNotOpen");
                    li.removeClass("clsOpen");
                    li.addClass("clsOpen");
                }
            }, function (result) {
                $("#loader").hide();
                alert("Error-" + result._message);
            });
        }
        function fnDeleteResponse(sender) {
            var ExcerciseRatingDetId = $("#ConatntMatter_hdnMailID").val();
            var ExerciseCompetencyPLMapID = $(sender).closest("tr").attr("ExerciseCompetencyPLMapID");
            var RatingId =0
            $("#loader").show();
            PageMethods.fnRatingAssessorSavePLListForSubCompetency(ExcerciseRatingDetId, ExerciseCompetencyPLMapID, RatingId, function (result) {
                $("#loader").hide();
                if (result.split("|")[0] == "0") {
                    $(sender).closest("tr").find("input[type=radio]:checked").prop("checked", false);
                    $(sender).closest("tr").find("input[type=radio]:checked").removeAttr("checked");
                    $(sender).closest("tr").find("td").removeClass("clsBGOrange").removeClass("clsBGRed").removeClass("clsBGGreen");
                    $(sender).hide();
                } else {
                    alert("Error-" + result.split("|")[1]);
                    $(sender).prop("checked", false);
                }
            }, function (result) {
                $("#loader").hide();
                alert("Error-" + result._message);
            });

        }

        function fnSave() {
            $("#loader").show();
            setTimeout(function () {
                $("#loader").hide();
            }, 500);
            /*
            var ArrDataSaving = []; var totCheckNotDemonstrated = 0; var totalChecked = 0;
            var totlen = $("#tbl_Ans").find("tbody").eq(0).find("tr").length;
            var strPL = "";
            var ExcerciseRatingDetId = $("#ConatntMatter_hdnMailID").val();
            var AnsVal = $("#txt_" + ExcerciseRatingDetId).val();
            if (AnsVal == "") {
                $("#dvDialog")[0].innerHTML = "<center>Kindly Enter Sub Competency Score First!</center>";
                $("#dvDialog").dialog({
                    title: 'Alert',
                    modal: true,
                    width: '30%',
                    buttons: [{
                        text: "OK",
                        click: function () {
                            $("#dvDialog").dialog("close");
                            $("#txt_" + ExcerciseRatingDetId).focus();
                        }
                    }]
                });

                return false;
            }
            $("#tbl_Ans input[type=checkbox]:checked").each(function () {
                if (strPL == "") {
                    strPL = $(this).closest("tr").attr("ExerciseCompetencyPLMapID");
                } else {
                    strPL += "," + $(this).closest("tr").attr("ExerciseCompetencyPLMapID");
                }
            });
            var totlen = $("#tbl_Ans").find("tbody").eq(0).find("tr").length;
            $("#tbl_Ans").find("tbody").eq(0).find("tr").each(function () {
                if ($(this).find("input:checked").length > 0) {
                    ArrDataSaving.push({ ExerciseCompetencyPLMapID: $(this).attr("ExerciseCompetencyPLMapID"), RatingId: $(this).find("input:checked").eq(0).val() });
                } else {
                    totCheckNotDemonstrated += 1;
                }

            });
            if (totlen == totCheckNotDemonstrated) {
                $("#dvDialog")[0].innerHTML = "<center>Kindly mark atleast one option in all PL's</center>";
                $("#dvDialog").dialog({
                    title: 'Alert',
                    modal: true,
                    width: '30%',
                    buttons: [{
                        text: "OK",
                        click: function () {
                            $("#dvDialog").dialog("close");
                        }
                    }]
                });
                return false;
            }
            if ($("#tbl_Ans input[type=checkbox]:checked").length == 0) {

            }
            $("#loader").show();
            var loginId = $("#ConatntMatter_hdnLogin").val();
            PageMethods.fnSave(AnsVal, ArrDataSaving, ExcerciseRatingDetId, fnSaveSuccess, fnFail);

            */
        }
        function fnConfirmYesOnSave() {
            var ArrDataSaving = [];
            $("#tbl_Ans").find("tbody").eq(0).find("tr").each(function () {
                ArrDataSaving.push({ ID: $(this).attr("EvidenceId"), Val: $(this).find("input:checked").eq(0).attr("flg") });
            });
            if (ArrDataSaving.length == 0) {
                ArrDataSaving.push({ ID: '0', Val: '0' });
            }
            fnCloseModalSecond();

            PageMethods.fnSave(ArrDataSaving, loginId, fnSaveSuccess, fnFail);
        }
        function fnCloseModalSecond() {
            $("#divAlertSecond").hide();
        }

        function fnSaveSuccess(result) {
            $("#loader").hide();
            if (result.split("|")[0] == "0") {
                alert("Saved successfully !");
                var MailId = $("#ConatntMatter_hdnMailID").val();

                var li = $("#ConatntMatter_divleft").find("li[ExcerciseRatingDetId='" + MailId + "']").eq(0);
                li.removeClass("clsNotOpen");
                li.removeClass("clsOpen");
                li.addClass("clsOpen");
            }
            else {
                alert("Error:" + result.split("|")[1]);
            }
        }

        function fnSubmit() {
            if ($("#ConatntMatter_divleft").find("li.clsNotOpen").length > 0) {
                alert("Please respond to all the items before clicking on Submit button !");
            }
            else {
              
                $("#dvDialog")[0].innerHTML = "<center>Are you sure you want to proceed?</center>";
                $("#dvDialog").dialog({
                    title: 'Confirmation:',
                    modal: true,
                    width: 'auto',
                    buttons: [{
                        text: "Yes",
                        click: function () {
                            $("#dvDialog").dialog("close");
                            var loginId = $("#ConatntMatter_hdnLogin").val();
                            var RSPExId = $("#ConatntMatter_hdnRSPExId").val();
                            $("#loader").show();
                            window.location.href = "AssessorRatingConfirmation.aspx?flg=1&RSPExerciseId=" + RSPExId;
                           // PageMethods.fnFinalSubmit(RSPExId, loginId, fnSubmitSuccess, fnFail);
                        }
                    },
                    {
                        text: "No",
                        click: function () {
                            $("#dvDialog").dialog("close");
                        }
                    }

                    ]
                });
               // window.location.href = "AssessorRatingConfirmation.aspx?RSPExerciseId=" + RSPExId;
               // PageMethods.fnFinalReview(RSPExId, loginId, fnReviewSuccess, fnFail);
            }
        }

        function fnReviewSuccess(res) {
            $("#loader").hide();
            if (res.split("|")[0] == "0") {
                window.location.href = "AssessorRatingConfirmation.aspx?flg=1&RSPExerciseId=" + RSPExId;
            }
            else {
                alert("Due to some technical error, we are unable to process your request !");
            }
        }

        function fnCloseModal() {
            $("#divAlert").hide();
        }

        function fnSaveSubmit() {
            $("#divAlert").hide();
            var loginId = $("#ConatntMatter_hdnLogin").val();
            var RSPExId = $("#ConatntMatter_hdnRSPExId").val();

            $("#loader").show();
            PageMethods.fnFinalSubmit(RSPExId, loginId, fnSubmitSuccess, fnFail);
        }

        function fnSubmitSuccess(result) {
            $("#loader").hide();
            if (result == "0") {
                var loginId = $("#ConatntMatter_hdnLogin").val();
                var RSPExId = $("#ConatntMatter_hdnRSPExId").val();
                window.location.href = "AssessorRatingConfirmation.aspx?flg=1&RSPExerciseId=" + RSPExId;
            }
            else {
                alert("Due to some technical error, we are unable to process your request !");
            }
        }

        function fnFail(err) {
            $("#loader").hide();
            alert("Due to some technical error, we are unable to process your request !");
        }

        function fnShowHideReviewBlock(ctrl) {
            if ($(ctrl).attr("flg") == "1") {
                $(ctrl).next("div.clsReviewBody").slideDown("slow");
                $(ctrl).attr("flg", "0");
                $(ctrl).find("img").eq(0).attr("src", "../../Images/Icons/iconDel.gif");
            }
            else {
                $(ctrl).next("div.clsReviewBody").slideUp("slow");
                $(ctrl).attr("flg", "1");
                $(ctrl).find("img").eq(0).attr("src", "../../Images/Icons/iconAdd.gif");
            }
        }

        function fnShowHideMail(ctrl) {
            if ($(ctrl).attr("flg") == "1") {
                $("#divMail").slideDown("slow");
                $(ctrl).attr("flg", "0");
                $(ctrl).attr("src", "../../Images/Icons/iconDel.gif");
            }
            else {
                $("#divMail").slideUp("slow");
                $(ctrl).attr("flg", "1");
                $(ctrl).attr("src", "../../Images/Icons/iconAdd.gif");
            }
        }
    </script>
    <script type="text/javascript" language="javascript">
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
        function validateEmail(sEmail) {
            var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
            if (filter.test(sEmail)) {
                return true;
            }
            else {
                return false;
            }
        }
        function fnSetBGColor(sender) {
            $(sender).closest("tr").find("td").removeClass("clsBGOrange").removeClass("clsBGRed").removeClass("clsBGGreen")
            if ($(sender).val() == 1) {
                $(sender).closest("td").removeClass("clsBGOrange").removeClass("clsBGRed").addClass("clsBGGreen");
            } else if ($(sender).val() == 2) {
                $(sender).closest("td").removeClass("clsBGGreen").removeClass("clsBGRed").addClass("clsBGOrange");
            } else {
                $(sender).closest("td").removeClass("clsBGOrange").removeClass("clsBGGreen").addClass("clsBGRed");
            }
        }
    </script>
    <style type="text/css">
        table.table, .table > tbody > tr > td {
    border-top: 1px solid #ddd !important;
    text-align: left;
}
        ul.ulmain {
            padding: 0;
            margin: 0;
            border-bottom: none;
        }

        .ulmain > li {
            position: relative;
            cursor: pointer;
            color: #BCC1CD;
            font-weight: 500;
            font-size: 0.75rem;
            text-align: left;
            padding: 8px 15px;
            list-style: none;
            border-bottom: 1px dotted #ddd;
        }

            .ulmain > li.clsLIHightlight,
            .ulmain > li.clsLIHightlight:focus,
            .ulmain > li.clsLIHightlight:hover {
                color: #FFF;
                Background: #164396;
                outline: none;
            }

            .ulmain > li:hover {
                background: #164396;
                color: #BCC1CD;
            }

            .ulmain > li::after {
                content: "";
                background: #C60D4A;
                position: absolute;
                left: 0px;
                top: -1px;
                width: 3px;
                height: 100%;
                transition: all 250ms ease 0s;
                transform: scale(0);
            }

            .ulmain > li.clsLIHightlight::after,
            .ulmain > li:hover::after {
                transform: scale(1);
            }

        .divHeader {
            color: #194597;
        }

        .bg-blue {
            background: #194597;
        }

        .clsAnsYes {
            background-color: #defde0;
        }

        .clsAnsPartialYes {
            background-color: #fcf7de;
        }

        .clsAnsNo {
            background-color: #fddfdf;
        }        
        td.clsBGGreen {
            background-color: #b3d335;
        }

        td.clsBGOrange {
            background-color: #f7941e;
        }

        td.clsBGRed {
            background-color: #ff0000;
        }
        td.clsCues {
            background-color: #ffffa6;
        }
        #ConatntMatter_divleft li.clsOpen {
                    background-color: #9fddec;
                    color:#666666;
                }

                #ConatntMatter_divleft li:hover {
                    color: #ffffff;
                    background-color: #666666;
                }
              
        li.clsLIHightlight {
            background-color: #ffff82 !important;
            color:#000000 !important;
        }

         #ConatntMatter_divleft li.clsOpenComptency {
                    background-color: #008080;
                    color:#ffffff;
                }
    </style>
    <%--<style type="text/css">
        .modal-dialog-center {
            margin-top: 15%;
        }
        td.clsBGGreen {
            background-color: #b3d335;
        }

        td.clsBGOrange {
            background-color: #f7941e;
        }

        td.clsBGRed {
            background-color: #ff0000;
        }

        .main-box {
            padding-bottom: 5px;
        }

        .container {
            padding-left: 0;
            padding-right: 0;
        }

        #ConatntMatter_divleft {
            border-right: 2px solid #808080;
        }

            #ConatntMatter_divleft ul {
                list-style-type: none;
                margin: 0;
                padding: 0;
                width: 100%;
                background-color: #f1f1f1;
            }

            #ConatntMatter_divleft li {
                color: #000;
                padding: 7px 14px;
                border-bottom: 1px solid #a9a9a9;
            }

               

                #ConatntMatter_divleft li:hover {
                    color: #ffffff;
                    background-color: #666666;
                }

        #divHeader {
            padding: 6px;
            font-weight: bold;
            background-color: #eeeeee;
        }

        td.clsMaillbl {
            color: #005d9b;
            font-size: 14px;
            font-weight: bold;
            padding-top: 14px;
            padding-bottom: 6px;
        }

        #divMail,
        #divAnswer {
            padding: 10px;
            min-height: 80px;
            max-height: 200px;
            overflow-y: auto;
            border: 2px solid #eeeeee;
        }

        table.clsAns {
            width: 100%;
            border-collapse: collapse;
        }

            table.clsAns th {
                color: #000000;
                padding: 2px;
                font-size: 13px;
                font-weight: bold;
                text-align: center;
                background-color: #dddddd;
                border: 1px solid #eeeeee;
            }

            table.clsAns td {
                color: #000000;
                padding: 1px 0 1px 2px;
                font-size: 9.5pt;
            }

                table.clsAns td.clsInput {
                    text-align: center;
                }

        li.clsLIHightlight {
            background-color: #ffff82 !important;
        }

        div.clsReviewBlock {
            text-align: left;
            margin-bottom: 2px;
            border-radius: 3px;
            border: 1px solid #bce8f1;
        }

        div.clsReviewHead {
            cursor: pointer;
            padding-left: 10px;
            background-color: #d9edf7;
        }

        div.clsReviewBody {
            padding: 10px;
            font-size: 12px;
        }

        table.clstblResponse {
            width: 100%;
            border-collapse: collapse;
        }

            table.clstblResponse th {
                color: #000000;
                padding: 2px;
                font-size: 12px;
                font-weight: bold;
                text-align: center;
                background-color: #dddddd;
                border: 1px solid #eeeeee;
            }

            table.clstblResponse td {
                color: #000000;
                padding: 1px 0 1px 10px;
                font-size: 12px;
                border: 1px solid #eeeeee;
                border-bottom-color: #dddddd;
            }

                table.clstblResponse td:nth-child(2) {
                    width: 18%;
                }

        
    </style>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div id="loader" class="loader_bg">
        <div class="loader"></div>
    </div>
    <div class="d-block">
        <div id="divleft" class="main-sidebar" runat="server"></div>
        <div id="divRight" class="content-wrapper">
            <table class="table table-sm mb-0 divHeader">
                <thead>
                    <tr>
                        <th style="width: 75px;">User-Code</th>
                        <th style="width: 10px;">:</th>
                        <th id="tdUserCode" runat="server"></th>
                        <th id="tdCaseStudy" runat="server" class="text-right"></th>
                    </tr>
                </thead>
            </table>
            <div id="divBody" style="padding: 0; overflow-y: auto; background-color: #ffffff;">
            </div>
            <div style="text-align: center; margin-top: 10px;" id="divBack">
                <a href="#" onclick="fnSave()" class="btns btn-submit" style="display:none" id="btnSaveContinue">Save</a>
                <a href="#" onclick="fnBack()" class="btns btn-submit">Back</a>
            </div>
        </div>
    </div>


    <%--<div id="divContainer">
        <div id="" style="width: 22%; display: inline-block;" runat="server"></div>
        <div id="" style="width: 77%; display: inline-block; vertical-align: top;">
            <div id="divHeader">
                <table style="width: 100%; font-size: 12pt">
                    <tr>
                        <td style="width: 120px; padding-left: 10px;">User-Code</td>
                        <td style="width: 20px;">:</td>
                        <td id="tdUserCode" runat="server" style="font-weight: 100;"></td>
                        <td id="tdCaseStudy" runat="server" style="text-align: right; padding-right: 10px;"></td>
                    </tr>
                </table>
            </div>
            <div id="divBody" style="padding: 0; overflow-y: auto; background-color: #ffffff;">
            </div>
            <div style="text-align: center; margin-top: 10px;" id="divBack">
                <a href="#" onclick="fnSave()" style="display: none" id="btnSaveContinue" class="btns btn-submit">Save</a>
                <a href="#" onclick="fnBack()" class="btns btn-submit">Back</a>
            </div>
        </div>
    </div>--%>

    <div id="dvDialog" style="display: none"></div>
    <div id="divAlert" style="display: none;" class="modal" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" style="padding: 2px;">
                <div class="modal-header" style="padding: 2px">
                    <h3 class="modal-title" id="divAlertHead">Responses</h3>
                    <button type="button" class="close" aria-hidden="true" onclick="fnCloseModal()">
                        <img src="../../Images/button_cancel.png" />
                    </button>

                </div>
                <div class="modal-body" style="padding: 2px; padding-top: 0px; height: 500px; overflow-y: auto" id="divAlertbody">
                </div>
                <div class="modal-footer" id="divAlertFooter">
                    <button type="button" data-backdrop="static" data-keyboard="false" class="btn btn-primary orange" onclick="fnSaveSubmit()">Confirm</button>
                    <button type="button" data-backdrop="static" data-keyboard="false" class="btn btn-primary orange" onclick="fnCloseModal()">Cancel</button>
                </div>
            </div>
        </div>
    </div>
    <div id="divAlertSecond" style="display: none;" class="modal" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-sm modal-dialog-center" role="document">
            <div class="modal-content" style="padding: 2px;">
                <div class="modal-header" style="padding: 2px">
                    <h3 class="modal-title" id="divAlertHeadSeconf">Alert!!!</h3>
                    <button type="button" class="close" aria-hidden="true" onclick="fnCloseModal()">
                        <img src="../../Images/button_cancel.png" />
                    </button>
                </div>
                <div class="modal-body" style="padding: 2px; padding-top: 0px; overflow-y: auto" id="divAlertbodySecond">
                </div>
                <div class="modal-footer" id="divAlertFooterSecond">
                    <button type="button" data-backdrop="static" data-keyboard="false" class="btn btn-primary orange" onclick="fnConfirmYesOnSave()">Yes</button>
                    <button type="button" data-backdrop="static" data-keyboard="false" class="btn btn-primary orange" onclick="fnCloseModalSecond()">No</button>
                </div>
            </div>
        </div>
    </div>


    <asp:HiddenField ID="hdnLogin" runat="server" />
    <asp:HiddenField ID="hdnRSPExId" runat="server" />
    <asp:HiddenField ID="hdnMailID" runat="server" />
</asp:Content>
