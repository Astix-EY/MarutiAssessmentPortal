<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmManageUserDetailsUpload_Excel.aspx.cs" Inherits="frmBulkUploadQuestionnaire_Excel" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-te-1.4.0.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-te-1.4.0.min.js"></script>
    <%--<script src="../../scripts/Multiselect/jquery.multiselectLatest.js"></script>--%>
    <link href="../../CSS/Multiselect/jquery.multiselect.css" rel="stylesheet" />
    <link href="../../CSS/Multiselect/jquery.multiselect.filter.css" rel="stylesheet" />
    <script src="../../Scripts/Multiselect/jquery.multiselect.js"></script>
    <script src="../../Scripts/Multiselect/jquery.multiselect.filter.js"></script>

    <style type="text/css">
        /*.container {
            max-width: 100% !important;
        }*/

        .jqte_editor, .jqte_source {
            padding: 2px 5px;
            background: #FFF;
            min-height: 25px;
            max-height: 150px;
            overflow: auto;
            outline: none;
            word-wrap: break-word;
            -ms-word-wrap: break-word;
            resize: vertical;
        }

        .jqte_toolbar {
            overflow: auto;
            padding: 0px 4px;
            background: #EEE;
            border-bottom: #BBB 1px solid;
            font-size: 11px;
        }

        .jqte {
            margin: 0px !important;
            font-size: 13px;
        }

        .ui-dialog .ui-dialog-buttonpane {
            padding: 0.0em 1em 0.0em 0.4em !important;
        }

        .ui-multiselect span.ui-icon {
            float: right;
            background-color: #F1F1F1;
            border: none !important;
            margin-top: -0.3px !important;
            margin-right: 1.3px !important;
            background-color: #ffffff;
        }

        .ui-multiselect-checkboxes li {
            clear: both;
            font-size: 0.75em;
            padding-right: 3px;
        }

        .ui-multiselect span {
            font-size: 0.75em;
        }

        button.ui-multiselect {
            width: 100% !important;
            height: 35px !important;
            border: 1px solid #ced4da !important;
            border-radius: 0.25rem !important;
            transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out !important;
        }

        .ui-multiselect-menu, .ui-multiselect-single {
            min-width: 250px;
        }

        .ui-multiselect-filter input {
            min-width: 100px;
            width: auto !important;
        }



        .ui-multiselect-checkboxes label input {
            margin-right: 10px;
        }

        .frm-group-txt, .form-control {
            background: #ffffff;
        }

        .form-group {
            margin-bottom: 0.5rem !important;
        }

        label {
            margin-bottom: 0.2rem !important;
        }

        .table-sm td {
            padding: 0.1rem !important;
        }

        .table td, .table th {
            padding: 0.1rem !important;
        }

        fieldset {
            border: 1px solid gray;
            padding: 2px 5px;
            margin-bottom: 5px;
        }

        legend {
            font-size: 11.5pt;
            background-color: #041E42;
            color: white;
            padding: 0px 10px;
            display: inline;
            width: auto;
            margin-bottom: 0.2rem !important;
        }

        #ConatntMatter_dvMain {
            overflow: auto;
        }

        #tblScheduling th {
            vertical-align: middle;
        }

        #tblScheduling td, #tblScheduling th {
            font-size: 9.3pt;
        }

            #tblScheduling td.cls-4 {
                text-align: center;
                vertical-align: middle;
            }

        table.clsTableOptions {
            font-size: 9.3pt;
        }

            table.clsTableOptions thead th {
                background-color: #fcfcfc !important;
            }

                table.clsTableOptions thead th:nth-child(1) {
                    text-align: left;
                }

            table.clsTableOptions td.cls-2 {
                padding-left: 5px !important;
            }

            table.clsTableOptions td.cls-3,
            table.clsTableOptions td.cls-4,
            table.clsTableOptions td.cls-5 {
                width: 8%;
                text-align: center !important;
            }

        .cls-bg-gray {
            background: #ccc;
        }
    </style>

    <style type="text/css">
        /* .container {
            max-width: 100% !important;
        }*/

        table.table-upload {
            width: 100%;
            border-spacing: 0;
            border-collapse: collapse;
            font-family: Arial, Helvetica, sans-serif;
            border: 1px solid #ddd;
            background-color: #e9fbfb;
            padding-top: 1rem;
        }

            table.table-upload > tbody > tr > td {
                font-size: 1.5rem;
                padding: .5rem 1rem;
                text-align: left;
                color: black;
            }

                table.table-upload > tbody > tr > td:first-child {
                    width: 290px !important;
                    font-weight: bold;
                }
    </style>


    <style type="text/css">
        /* .container {
            max-width: 100% !important;
        }*/

        table.table-uploadNew {
            width: 100%;
            border-spacing: 0;
            border-collapse: collapse;
            font-family: Arial, Helvetica, sans-serif;
            /* border: 1px solid #ddd;*/
            /*    background-color: white;*/
            padding-top: 1rem;
        }

            table.table-uploadNew > tbody > tr > td {
                font-size: 1.5rem;
                padding: .5rem 1rem;
                text-align: left;
                color: black;
            }

                table.table-uploadNew > tbody > tr > td:first-child {
                    width: 290px !important;
                    font-weight: bold;
                }
    </style>

    <script type="text/javascript">



        //*************************for Email Validation*********************
        function IsEmail(email) {
            var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!regex.test(email)) {
                return false;
            } else {
                return true;
            }
        }

        //*************************for Backgrouncolor*********************
        function fnErrorColor(obj) {
            obj.style.backgroundColor = "#ffffcc";
        }
        function fnOriginalColor(obj) {
            obj.style.backgroundColor = "#ffffff";
        }
        function fnClear(Obj) {
            document.getElementById(Obj).innerText = "";
        }
        //*************************Only Numeric Digit For Mob No*********************
        function isNumberKeyNotDecimal(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }


        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
        //********************************************************

    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.main-box').css({
                /*'min-height': ($(window).height() - 75),*/
                'min-width': "100%",
                /*    'background': 'rgba(255,255,255,.85)'*/
            });
            $("#divHeaderTitle").html("<h3>Bulk Upload Questionnaire</h3>");
            $("#dvloader").hide();
            $("select.clsMasterMultiselect").multiselect({
                header: true,
                showcheckall: true,
                noneSelectedText: 'All',
                multiple: true,
                appendTo: "#dvQuestionDialog",
                position: ({
                    my: "center top",
                    at: "center bottom",
                    collision: 'flipfit',
                    within: window,
                })
            }).multiselectfilter();

        });

        function fnUploadUserData(ctrl) {
            //alert("Hi");
            /*            $("#divloader").show();*/

            var LoginID = $("#ConatntMatter_hdnLogin").val();
            var EngagementId = $("#ConatntMatter_hdnEngagementId").val();
            var EngagementAssessmentId = $("#ConatntMatter_hdnEngagementAssessmentId").val();
            //  alert(EngagementId);
            var filetype = $(ctrl).attr("filetype");
            // alert(filetype);
            var fileUploader = "FileUploader" + filetype;
            //alert(fileUploader);
            var Email = "abhishek@astix.in";//document.getElementById("cphRight_txtEmail").value.trim();

            //alert(filetype);
            //alert(fileUploader);
            //alert(Email);
            //alert(filetype.toString());

            var fileName = "";
            switch (filetype.toString()) {
                case "1":
                    fileName = "UserMaster_Sample";
                    break;
            }

            if ($("#" + fileUploader).get(0).files.length == 0) {
                // alert("Please Select the " + fileName + "'s File !");
                //  alert("Please Select the file in EY Template formate! If you have no file then please Download Template from “Download template for bulk uploaded” button");
                //AutoHideAlertMsg("If you have no file then please Download Template from <strong>“Download User Template”</strong> button");
                alert("If you have no file then please Download Template from “Download Sample Template” button");
                $("#divloader").hide();
                return false;

            }
            else {
                // alert("A");
                var fileUpload = $("#" + fileUploader).get(0);
                var file = fileUpload.files;
                //  alert(fileUpload);
                // alert(file);
                var data = new FormData();
                data.append(file[0].name, file[0]);
                data.append("FileSetType", filetype);
                data.append("FileExtType", "1");
                data.append("Email", Email);
                data.append("LoginID", LoginID);
                data.append("EngagementId", EngagementId);
                data.append("EngagementAssessmentId", EngagementAssessmentId);



                //  alert("B");
                //alert(LoginID);
                //alert("C");
                $("#divMsg").empty();
                $('#divUploadedData').empty();

                //alert("D");
                //alert($("#divShowUploadedData").html());
                //alert($("#divUploadedData").html());
                $("#divloader").show();
                //alert("E");
                $("#divShowUploadedData").dialog({
                    title: "User Template",
                    modal: true,
                    width: "95%",
                    height: window.innerHeight - 85,
                    appendTo: $("#divUploadedData").html()
                });
                //alert("F");


                $.ajax({
                    url: "UserDetailsUpload.ashx",
                    type: "POST",
                    data: data,
                    async: true,
                    contentType: false,
                    processData: false,
                    success: function (result) {
                        //  alert("F");
                        // alert(result.split("^")[0]);
                        if (result.split("^")[0] == "0") {
                            // alert(result);
                            //alert(result.split("^")[1].split("~")[0]);

                            //1 = Not show  Error In Data
                            //0 = Show button

                            if (result.split("^")[1].split("~")[0] == "1") {
                                $("#divMsg").html("Your file has errors, please correct the errors, mentioned in column named Remarks, and upload the file again.");
                                $("#div_btnApprove_Reject").hide();
                                $("#div_DownloadExcel").hide();

                                // alert(result.split("^")[1]);
                                //alert(result.split("^")[1].split("_")[1]);
                                // alert(result.split("^")[1].split("~")[1]);
                                // $('#divUploadedData').empty();
                                //  $('#divUploadedData').val('');
                                $("#divUploadedData").show();
                                $("#divUploadedData").html(result.split("^")[1].split("~")[1]);
                                $("#" + fileUploader).closest("td").prev().html('');
                                $("#" + fileUploader).val('');
                                $('#cphRight_txtEmail').val('');
                                $("#divUploadedData").height($(window).height() - 150 + "px");
                            }
                            else {

                                //  $("#divMsg").html("Data Loaded Successfully..");
                                // $("#divMsg").html("File has no errors and it is successfully converted to required format.");
                                $("#divMsg").empty();
                                $('#divUploadedData').empty();
                                $("#div_btnApprove_Reject").hide();
                                $("#div_DownloadExcel").hide();
                                $("#divUploadedData").html(result.split("^")[1].split("~")[1]);


                                $("#dvAlert")[0].innerHTML = "File has no errors,</br> Do you want to successfully upload this file?";
                                $("#dvAlert").dialog({
                                    title: "Confirmation:",
                                    modal: true,
                                    width: "auto",
                                    height: "auto",
                                    close: function () {
                                        $(this).dialog('destroy');
                                    },
                                    open: function () {
                                        $("div.ui-dialog-buttonpane").find("button").removeClass("ui-button").removeClass("ui-corner-all");
                                    },
                                    buttons: [
                                        {
                                            text: "Yes",
                                            class: "btns btn-submit",
                                            click: function () {
                                                $("#dvloader").show();
                                                $("#dvAlert").dialog('close');

                                                // fnDownload();
                                                PageMethods.fnFinalSubmit(EngagementId, EngagementAssessmentId, LoginID, fnSave_pass, fnfail, 1);
                                            }
                                        },
                                        {
                                            text: "No",
                                            class: "btns btn-submit",
                                            click: function () {
                                                $(this).dialog('close');
                                                $("#divShowUploadedData").dialog('close');
                                                $("#divMsg").empty();
                                                $('#divUploadedData').empty();
                                            }

                                        }
                                    ]
                                })


                                $("#divUploadedData").hide();
                                $("#" + fileUploader).closest("td").prev().html('');
                                $("#" + fileUploader).val('');
                                $('#cphRight_txtEmail').val('');
                                $("#divMsg").empty();
                                $('#divUploadedData').empty();
                                $("#divUploadedData").height($(window).height() - 210 + "px");
                            }
                        }

                        else if (result.split("^")[0] == "1") {
                            // alert("A");
                            if (result.split("^")[1].split("~")[0] == "0") {
                                //alert("A1");
                                alert(result.split("^")[1].split("~")[1]);
                                $("#div_btnApprove_Reject").hide();
                                $("#div_DownloadExcel").hide();
                                // alert(result.split("^")[1]);
                                //alert(result.split("^")[1].split("_")[1]);
                                $("#divMsg").empty();
                                $('#divUploadedData').empty();
                                $("#divUploadedData").html(result.split("^")[1].split("~")[1]);
                                $("#" + fileUploader).closest("td").prev().html('');
                                $("#" + fileUploader).val('');
                                $('#cphRight_txtEmail').val('');
                                $("#divUploadedData").height($(window).height() - 150 + "px");
                            }
                            else {
                                // alert("A2");
                                //AutoHideAlertMsg("You are selected wrong file. Please select correct file for upload..");
                                alert("You are selected wrong file. Please select correct file for upload..");
                                $("#divShowUploadedData").dialog('close');
                                $("#div_DownloadExcel").hide();
                                $("#div_btnApprove_Reject").hide();
                                $("#divMsg").empty();
                                $('#divUploadedData').empty();
                                $("#divUploadedData").html(result.split("^")[1].split("~")[1]);
                                $("#" + fileUploader).closest("td").prev().html('');
                                $("#" + fileUploader).val('');
                                $('#cphRight_txtEmail').val('');
                                $("#divUploadedData").height($(window).height() - 210 + "px");
                            }
                        }

                        else {
                            //$("#divShowUploadedData").dialog('close');
                            $("#div_DownloadExcel").hide();
                            $("#div_btnApprove_Reject").hide();
                            $("#divMsg").empty();
                            $('#divUploadedData').empty();
                            $("#divUploadedData").html(result.split("^")[1].split("~")[1]);
                            $("#divUploadedData").height($(window).height() - 150 + "px");
                        }
                        $("#divloader").hide();
                    },
                    error: function (err) {
                        alert("Error : " + err.statusText);
                        //$("#" + fileUploader).closest("td").prev().html('');
                        //$("#" + fileUploader).val('');
                        $("#divloader").hide();
                    }
                });
            }
        }


    </script>

    <script type="text/javascript">   
        function fnAssignAttribute() {
            $("#dvQuestionDialog").dialog({
                title: "Assign Attribute",
                modal: true,
                height: window.innerHeight - 135,
                width: '99%',
                close: function () {
                    $(this).dialog('destroy');
                }
            })
        }

        function fnSubmitWithoutAttribute() {

            var login = $("#ConatntMatter_hdnLogin").val();
            var arrAttributes = [];

            $("#dvAlert")[0].innerHTML = "<br/>Are you sure to submit this ?";
            $("#dvAlert").dialog({
                title: "Confirmation:",
                modal: true,
                width: "auto",
                height: "auto",
                close: function () {
                    $(this).dialog('destroy');
                },
                open: function () {
                    $("div.ui-dialog-buttonpane").find("button").removeClass("ui-button").removeClass("ui-corner-all");
                },
                buttons: [
                    {
                        text: "Yes",
                        class: "btns btn-submit",
                        click: function () {
                            $("#dvloader").show();
                            $("#dvAlert").dialog('close');
                            PageMethods.fnFinalSubmit(arrAttributes, login, fnSave_pass, fnfail, 1);
                        }
                    },
                    {
                        text: "No",
                        class: "btns btn-submit",
                        click: function () {
                            $(this).dialog('close');
                        }
                    }
                ]
            })
        }


        function fnSubmitWithAttribute() {
            var login = $("#ConatntMatter_hdnLogin").val();
            var $Attributes = $("select.clsMasterMultiselect");
            var arrAttributes = [];

            for (var i = 0; i < $Attributes.length; i++) {
                var $Checked = $Attributes.eq(i).find("option:selected");
                var snodetype = $Attributes.eq(i).attr("snodetype");
                if ($Checked.length > 0) {
                    for (var j = 0; j < $Checked.length; j++) {
                        var sval = $Checked.eq(j).val();
                        arrAttributes.push({ NodeId: sval.split("_")[0], NodeType: sval.split("_")[1] })
                    }
                }
                else {
                    arrAttributes.push({ NodeId: 0, NodeType: snodetype })
                }
            }

            $("#dvAlert")[0].innerHTML = "<br/>Are you sure to save this ?";
            $("#dvAlert").dialog({
                title: "Confirmation:",
                modal: true,
                width: "auto",
                height: "auto",
                close: function () {
                    $(this).dialog('destroy');

                },
                open: function () {
                    $("div.ui-dialog-buttonpane").find("button").removeClass("ui-button").removeClass("ui-corner-all");
                },
                buttons: [
                    {
                        text: "Yes",
                        class: "btns btn-submit",
                        click: function () {
                            $("#dvloader").show();
                            PageMethods.fnFinalSubmit(arrAttributes, login, fnSave_pass, fnfail, 2);
                            //PageMethods.fnValidateQuestionFromBulkUpload(arrAttributes, login, fnSave_pass, fnfail);

                            $("#dvAlert").dialog('close');
                        }
                    },
                    {
                        text: "No",
                        class: "btns btn-submit",
                        click: function () {
                            $(this).dialog('close');
                        }
                    }
                ]
            })
        }


        function fnSave_pass(result, flg) {
            //alert(result);
            //alert(flg);
            $("#dvloader").hide();
            window.location.href = "../MasterForms/frmManageEmployeeDetails.aspx";
       
            if (flg == 2)
                $("#dvQuestionDialog").dialog('close');

            if (result.split("|")[0] == "0") {
                $("#div_btnApprove_Reject").hide();
                $("#divUploadedData").html("Data submitted successfully !");
                $("#" + fileUploader).closest("td").prev().html('');
                $("#" + fileUploader).val('');
                $('#cphRight_txtEmail').val('');
              

            }
            else {
                fnShowDialog(result.split("|")[1], "Error!");
                return false;
            }
        }

        function fnfail(result) {
            $("#dvloader").hide();
            fnShowDialog("Error:" + result._message, "Alert!");
            return false;
        }

        //function DownloadSampleFile() {
        //    alert("File downloaded successfully, please add Questions for bulk upload to the template”. Before uploading, please read instructions carefully.");

        //}
    </script>
    <script type="text/javascript">

        //function fnDownload1() {
        //   AutoHideAlertMsg("“File with required format is downloaded successfully”. Please upload that file using below <strong>“Bulk Upload Questions”</strong> button.");
        //}

        function fnDownloadUploadDataExcel() {
            var LoginID = $("#ConatntMatter_hdnLogin").val();
            var EngagementId = $("#ConatntMatter_hdnEngagementId").val();
            var EngagementAssessmentId = $("#ConatntMatter_hdnEngagementAssessmentId").val();
            var EngagementName = $("#ConatntMatter_hdnEngagementName").val();
            var EngagementAssessmentName = $("#ConatntMatter_hdnEngagementAssessmentName").val();
            var url = "frmDownloadUploadDataExcel.aspx?flg=1&LoginID=" + LoginID + "&EngagementId=" + EngagementId + "&EngagementAssessmentId=" + EngagementAssessmentId + "&EngagementName=" + EngagementName + "&EngagementAssessmentName=" + EngagementAssessmentName;
            window.open(url, "_blank");
            $("#dvloader").hide();
            AutoHideAlertMsg("File downloaded successfully.");
            ////alert("File with required format is downloaded successfully”. Please upload that file using below “Bulk Upload Questions” button.");
            //// $("#divShowUploadedData").hide();
            //$("#divMsg").empty();
            //$('#divUploadedData').empty();
            //$("#divShowUploadedData").dialog('close');
        }

        function fnDownload() {
            var LoginID = $("#ConatntMatter_hdnLogin").val();
            //if (CycleID == 0) {
            //    alert("Kindly select batch first!");
            //    $("#ConatntMatter_ddlCycleName").focus();
            //    return false;
            //}
            var url = "frmDownloadExcel.aspx?flg=1&LoginID=" + LoginID;
            window.open(url, "_blank");
            $("#dvloader").hide();
            AutoHideAlertMsg("“File with required format is downloaded successfully”. Please upload that file using below <strong>“Bulk Upload Questions”</strong> button.");
            //alert("File with required format is downloaded successfully”. Please upload that file using below “Bulk Upload Questions” button.");
            // $("#divShowUploadedData").hide();
            $("#divMsg").empty();
            $('#divUploadedData').empty();
            $("#divShowUploadedData").dialog('close');
        }

        //window.onload = function () {
        //    document.getElementById('closeHideAlertMsg').onclick = function () {
        //        this.parentNode.parentNode.remove();
        //        return false;
        //    };
        //};

        function AutoHideAlertMsg(msg) {

            var str = "<div id='divAutoHideAlertMsg' style='width: 100%; background-color: transparent; top: 0; position: fixed; z-index: 999; text-align: center; opacity: 0;' >";
            str += "<span style='font-size: 0.9rem; font-weight: 700; color: #fff; padding: 6px 16px; border-radius: 4px; background-color: #9E2F6C; box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.6), 0 6px 20px 0 rgba(0, 0, 0, 0.2)'>";
            /*str += "&nbsp;&nbsp;&nbsp;<span id='closeHideAlertMsg' style='cursor: pointer;' onclick='this.parentNode.parentNode.remove(); return false;'>x</span>";*/
            str += msg;
            str += "</span>";
            str += "</div>";
            $("body").append(str);
            $("#divAutoHideAlertMsg").animate({
                top: '600px',
                opacity: '1'
            }, "slow");



            //---------------------------------------------
            setTimeout(function () {
                $("#divAutoHideAlertMsg").animate({
                    top: '0px',
                    opacity: '0'
                }, "slow");
            }, 3000);
            setTimeout(function () {
                $("#divAutoHideAlertMsg").remove();
            }, 3500);


        }


        function fnChangeParent(ctrl) {
            var TblhdnAllAttributeData = $.parseJSON($("#ConatntMatter_hdnAllAttributeData").val());
            var IsMultiSelect = $(ctrl).attr("isMultiSelect");
            var isPopup = $(ctrl).attr("isPopup"); //  1 Means For Pop up Data SHow, 0 Means On Page of Top Data
            var sntype = $(ctrl).attr("snodetype");
            var cntype = $(ctrl).attr("cntype");
            var SubDDLOptions = "";
            //alert(IsMultiSelect);
            //alert(sntype);
            //alert(cntype);
            if (isPopup == "1") {
                if (IsMultiSelect == "1") {
                    var ddlArr = $(ctrl).val();
                    if (ddlArr.length > 0) {
                        // alert(ddlArr.length);
                        for (var i = 0; i < cntype.split("^").length; i++) {
                            SubDDLOptions = "";
                            for (j = 0; j < TblhdnAllAttributeData.length; j++) {
                                //alert(TblhdnAllAttributeData[j].NodeType.toString());
                                //alert(cntype.split("^")[i].toString());
                                //alert(dlArr.indexOf(TblhdnAllAttributeData[j].PNodeId.toString() + "_" + sntype));
                                if (TblhdnAllAttributeData[j].NodeType.toString() == cntype.split("^")[i].toString() && ddlArr.indexOf(TblhdnAllAttributeData[j].PNodeId.toString() + "_" + sntype) > -1) {
                                    // SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                                    SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "_" + TblhdnAllAttributeData[j].NodeType + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                                }
                            }
                            $("#ddlAttr_" + cntype.split("^")[i]).html(SubDDLOptions);
                            $("#ddlAttr_" + cntype.split("^")[i]).multiselect('refresh');

                        }
                    }
                    else {
                        for (var i = 0; i < cntype.split("^").length; i++) {
                            SubDDLOptions = "";
                            for (j = 0; j < TblhdnAllAttributeData.length; j++) {
                                if (TblhdnAllAttributeData[j].NodeType.toString() == cntype.split("^")[i].toString()) {
                                    // SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                                    SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "_" + TblhdnAllAttributeData[j].NodeType + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                                }
                            }
                            $("#ddlAttr_" + cntype.split("^")[i]).html(SubDDLOptions);
                            $("#ddlAttr_" + cntype.split("^")[i]).multiselect('refresh');


                        }
                    }
                }
                else {
                    var ddlVal = $(ctrl).val().toString();
                    if (ddlVal != "0") {
                        for (var i = 0; i < cntype.split("^").length; i++) {
                            SubDDLOptions = "";
                            for (j = 0; j < TblhdnAllAttributeData.length; j++) {
                                if (TblhdnAllAttributeData[j].NodeType.toString() == cntype.split("^")[i].toString() && (TblhdnAllAttributeData[j].PNodeId.toString() + "_" + sntype) == ddlVal)
                                    SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                            }
                            $("#ddlAttr_" + cntype.split("^")[i]).html(SubDDLOptions);
                        }
                    }
                }
            }
            else {
                if (IsMultiSelect == "1") {
                    var ddlArr = $(ctrl).val();
                    if (ddlArr.length > 0) {
                        // alert(ddlArr.length);
                        for (var i = 0; i < cntype.split("^").length; i++) {
                            SubDDLOptions = "";
                            for (j = 0; j < TblhdnAllAttributeData.length; j++) {
                                //alert(TblhdnAllAttributeData[j].NodeType.toString());
                                //alert(cntype.split("^")[i].toString());
                                //alert(dlArr.indexOf(TblhdnAllAttributeData[j].PNodeId.toString() + "_" + sntype));
                                if (TblhdnAllAttributeData[j].NodeType.toString() == cntype.split("^")[i].toString() && ddlArr.indexOf(TblhdnAllAttributeData[j].PNodeId.toString() + "_" + sntype) > -1) {
                                    //  SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                                    SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "_" + TblhdnAllAttributeData[j].NodeType + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                                }
                            }
                            $("#ddlAttrTop_" + cntype.split("^")[i]).html(SubDDLOptions);
                            $("#ddlAttrTop_" + cntype.split("^")[i]).multiselect('refresh');

                        }
                    }
                    else {
                        for (var i = 0; i < cntype.split("^").length; i++) {
                            SubDDLOptions = "";
                            for (j = 0; j < TblhdnAllAttributeData.length; j++) {
                                if (TblhdnAllAttributeData[j].NodeType.toString() == cntype.split("^")[i].toString()) {
                                    // SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                                    SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "_" + TblhdnAllAttributeData[j].NodeType + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                                }
                            }
                            $("#ddlAttrTop_" + cntype.split("^")[i]).html(SubDDLOptions);
                            $("#ddlAttrTop_" + cntype.split("^")[i]).multiselect('refresh');


                        }
                    }
                }
                else {
                    var ddlVal = $(ctrl).val().toString();
                    if (ddlVal != "0") {
                        for (var i = 0; i < cntype.split("^").length; i++) {
                            SubDDLOptions = "";
                            for (j = 0; j < TblhdnAllAttributeData.length; j++) {
                                if (TblhdnAllAttributeData[j].NodeType.toString() == cntype.split("^")[i].toString() && (TblhdnAllAttributeData[j].PNodeId.toString() + "_" + sntype) == ddlVal)
                                    SubDDLOptions += "<option value='" + TblhdnAllAttributeData[j].NodeId + "'>" + TblhdnAllAttributeData[j].Descr + "</option>";
                            }
                            $("#ddlAttrTop_" + cntype.split("^")[i]).html(SubDDLOptions);
                        }
                    }
                }
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="../MasterForms/frmManageEmployeeDetails.aspx">Back</a></li>
<%--     <li class="breadcrumb-item"><a href="../MasterForms/frmManageEngagementMaster.aspx">Engagement Master</a></li>
<li class="breadcrumb-item"><a href="../MasterForms/frmManageAssessments.aspx">Assessment Master</a></li>
        <li class="breadcrumb-item active" aria-current="page">User Master</li>--%>

    </ol>
    <%--    <div class="section-title clearfix d-none">
        <h3 class="text-center">Bulk Upload Questionnaire</h3>
        <div class="title-line-center"></div>
    </div>--%>
   <%-- <div class="text-left d-inline-block">
        Engagement Name : <span id="spnEngagementName" runat="server"></span>
        > Assessment Name : <span id="spnAssessmentName" runat="server"></span>
    </div>--%>

    <table class="table table-bordered mt-2">
        <tr>
            <td style="width: 90%" class="p-3">
                <fieldset>
                    <legend>User Data Upload</legend>
                    <div class="form-row">
                        <div class="form-group col-md-12 " style="margin-bottom: 0px !important">
                            <table class="table">
                                <tr>
                                    <td colspan="3" style="text-align: right">
                                        <a href="SampleFiles/UserMaster_Sample.xlsx" title="Download Sample Template​" onclick="DownloadSampleFile()" class="btns btn-submit" download>Download Sample Template</a>

                                    </td>
                                </tr>
                                <tr>
                                    <td class="border-right-0">
                                        <input type="file" id="FileUploader1" name="FileUploader1" onchange="fnFileSelect(this);" class="form-control-sm" style="display: inline-block" />

                                    </td>
                                    <td>
                                        <a href="#" filetype='1' onclick="fnUploadUserData(this);" class="btns btn-submit">Upload User Data</a>
                                    </td>
                                    <td style="text-align: right; display:none" class="border-left-0" >
                                        <input type="button" id="btnDownloadUploadDataExcel" value="Download Uploaded Data" onclick="fnDownloadUploadDataExcel()" class="btns btn-submit" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </fieldset>
            </td>

        </tr>

    </table>

    <div id="divShowUploadedData" style="display: none">
        <div id="divMsg"></div>
        <div id="divUploadedData" class="w-100 mt-3" style="background-color: white; overflow: auto;"></div>

        <div class="text-center m-2" id="div_DownloadExcel" style="display: none">
            <input type="button" id="btnDownloadExel" value="Download Data" onclick="fnDownload()" class="btns btn-submit" />
        </div>
    </div>

    <div class="text-center m-2" id="div_btnApprove_Reject" style="display: none">
        <input type="button" id="btnAssignAttribute" value="Assign Attribute" onclick="fnAssignAttribute()" class="btns btn-submit" />
        <input type="button" id="btnApprove" value="Submit" onclick="fnSubmitWithoutAttribute()" class="btns btn-submit" />
        <%--  <input type="button" id="btnReject" value="Reject" onclick="fnReject()" class="btns btn-cancel" />--%>
    </div>
    <div class="loader_bg" id="divloader">
        <div class="loader"></div>
    </div>
    <div id="dvQuestionDialog" style="display: none">
        <fieldset style="margin-top: 10px">
            <legend>Attributes Section</legend>
            <div class="form-row" runat="server" id="divAttributesMaster">
            </div>
        </fieldset>
        <div class="mt-3 text-center">
            <input type="button" id="btnAssignAttributeSubmit" value="Submit" onclick="fnSubmitWithAttribute()" class="btns btn-submit" />
        </div>
    </div>

    <div id="dvAlert" style="display: none;"></div>
    <div id="dvloader" class="loader_bg" style="display: block">
        <div class="loader"></div>
    </div>
    <asp:HiddenField ID="hdnUserlst" runat="server" />
    <asp:HiddenField ID="hdnLogin" runat="server" />
    <asp:HiddenField ID="hdnEngagementId" Value="0" runat="server" />
    <asp:HiddenField ID="hdnEngagementAssessmentId" Value="0" runat="server" />
    <asp:HiddenField ID="hdnEngagementName" Value="0" runat="server" />
    <asp:HiddenField ID="hdnEngagementAssessmentName" Value="0" runat="server" />
    <asp:HiddenField ID="hdnFlg" runat="server" />
    <asp:HiddenField ID="hdnAllAttributeData" runat="server" />
</asp:Content>

