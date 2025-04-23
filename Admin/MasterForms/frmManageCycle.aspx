<%@ Page Title="" Language="VB" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="false" CodeFile="frmManageCycle.aspx.vb" Inherits="Admin_MasterForms_frmManageCycle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../../Scripts/validation.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ConatntMatter_lstCycle").css({
                "height": $(window).height() - ($(".navbar").outerHeight() + 160)
            });


            var allsecheight = $(".navbar").outerHeight() + $('.section-title').outerHeight() + $('.d-flex').outerHeight();
            $("#ConatntMatter_dvMain").tblheaderfix({
                height: $(window).height() - (allsecheight + 170)
            });



            $("#ConatntMatter_btnSearch").click(function () {
                $("#ConatntMatter_dvMain")[0].innerHTML = "";

                var UserFilter = $("#ConatntMatter_txtSearch").val();
                $("#loader").show()
                //  debugger;
                PageMethods.fnGetCycleDetails(0, UserFilter, 2, fnGetAllSuccessData, fnFailedCycle, 0);
            });
            $("#ConatntMatter_btnShowAll").click(function () {
                $("#ConatntMatter_dvMain")[0].innerHTML = "";
                $("#ConatntMatter_txtSearch").val('');
                PageMethods.fnGetCycleDetails(0, '', 1, fnGetAllSuccessData, fnFailedCycle, 0);
            });

            fnSetDateTimePicker();
        });
        function fnSetDateTimePicker() {
            $("#ConatntMatter_txtDate").datepicker({
                dateFormat: "dd-M-yy",
                changeMonth: true,
                changeYear: true,
                minDate: new Date(),
                onSelect: function (selected) {
                    $("#ConatntMatter_txtEndDate").datepicker("option", "minDate", selected)
                    $("#ConatntMatter_txtEndDate").val($("#ConatntMatter_txtDate").val());
                    fnddlBatchTypeChange();
                }
            });
            $("#ConatntMatter_txtEndDate").datepicker({
                dateFormat: "dd-M-yy",
                changeMonth: true,
                changeYear: true,
                minDate: $("#ConatntMatter_txtDate").val(),

            });


            $('img.ui-datepicker-trigger').css({ 'cursor': 'pointer', 'height': '25px', 'width': '25px', 'position': 'absolute', 'bottom': '7px', 'right': '10px' });
        }
    </script>

    <script type="text/javascript">
        $.fn.tblheaderfix = function (options) {
            var strid = $(this)[0].id, clss = $(this).find("table").attr('class');
            var defaults = {
                width: '100%',
                height: 350,
                padding: 1
            };
            var options = $.extend(defaults, options);
            $(this).css({ "width": options.width, "height": options.height, "padding": options.padding });

            $(this).find("table").attr('id', strid + '_tbl');
            var contant = $(this).html(), wid = $("#" + strid + "_tbl").width(), thead = $("#" + strid + "_tbl").find("thead").eq(0).html();
            $(this).html("<div id='" + strid + "_head'></div><div id='" + strid + "_body'></div>");
            $("#" + strid + "_head").html("<table id='" + strid + "_hfix' class='" + clss + " mb-0' style='width:" + wid + "px'><thead>" + thead + "</thead><tbody></tbody></table>");
            $("#" + strid + "_body").html(contant);
            $("#" + strid + "_tbl").css({ "width": wid, "min-width": wid });
            for (i = 0; i < $("#" + strid + "_tbl").find("th").length; i++) {
                var th_wid = $("#" + strid + "_tbl").find("th")[i].clientWidth; //offsetWidth;
                $("#" + strid + "_hfix, #" + strid + "_tbl").find("th").eq(i).css({ "min-width": th_wid, "width": th_wid });
            }
            $("#" + strid + "_tbl").css("margin-top", "-" + ($("#" + strid + "_hfix")[0].offsetHeight) + "px");
            $("#" + strid + "_body").css({
                'height': $(this).height() - $("#" + strid + "_head").outerHeight(),
                'overflow-y': 'auto',
                'overflow-x': 'hidden'
            });
        }
    </script>

    <script type="text/javascript">
        function fnSaveCycle() {
            var CycleName = document.getElementById("ConatntMatter_txtCycleName").value.trim();
            var CycleDate = document.getElementById("ConatntMatter_txtDate").value.trim();
            var CycleEndDate = $("#ConatntMatter_txtEndDate").val().trim();
            var SetID = 0// $('#ConatntMatter_ddlSetName').val();
            var AssessmentType = $('#ConatntMatter_ddlAssessmentType').val();
            var BatchTypeValue = $('#ConatntMatter_ddlBatchType').val();
            if (CycleName == "") {
                alert("Please enter batch name")
                return false;
            }
            if (CycleDate == "") {
                alert("Please enter batch date")
                return false;
            }

            CycleName = CycleName.replace("_", " ");
            var hdnCycleID = document.getElementById("ConatntMatter_hdnCycleID").value;
            PageMethods.fnManageCycleName(hdnCycleID, CycleName, CycleDate, CycleEndDate, SetID, AssessmentType, BatchTypeValue, fnSuccessCycle, fnFailedCycle);

        }
        function fnSuccessCycle(result) {
            if (result.split("@")[0] == "1") {

                var CycleID = result.split("^")[1]
                document.getElementById("ConatntMatter_hdnCycleID").value = CycleID;

                var CycleName = document.getElementById("ConatntMatter_txtCycleName").value.trim();
                var CycleDate = document.getElementById("ConatntMatter_txtDate").value.trim();

                var Returnresult = result.split("@")[0]
                if (Returnresult == 1) {
                    PageMethods.fnGetCycleDetails(0, '', 1, fnGetAllSuccessData, fnFailedCycle, 1);
                }


            }
            else {
                alert("Error....")
            }
        }

        function fnGetAllSuccessData(result, returnVal) {
            if (result.split("@")[0] == "1") {
                if (returnVal == 1) {
                    $("#dvDialog").dialog('close');
                    if (document.getElementById("ConatntMatter_hdnFlag").value == "1") {
                        alert("Updated Successfully")
                    }
                    else {
                        alert("Saved Successfully")
                    }
                }

                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("@")[1];

                var allsecheight = $(".navbar").outerHeight() + $('.section-title').outerHeight() + $('.d-flex').outerHeight();
                $("#ConatntMatter_dvMain").tblheaderfix({
                    height: $(window).height() - (allsecheight + 170)
                });


            }
        }

        function fnFailedCycle(result) {
            alert("Error - " + result.split("^")[1])
        }
    </script>
    <script type="text/javascript">
        function fnAddNewCycle() {
            $("#dvDialog").dialog({
                title: "Add New Cycle Details",
                resizable: false,
                height: "auto",
                width: "50%",
                modal: true
            });
            document.getElementById("ConatntMatter_txtCycleName").value = "";
            document.getElementById("ConatntMatter_txtDate").value = "";
            document.getElementById("ConatntMatter_txtEndDate").value = "";
            document.getElementById("ConatntMatter_hdnCycleID").value = 0;
            document.getElementById("ConatntMatter_hdnFlag").value = 0;
            $("#ConatntMatter_txtDate, #ConatntMatter_ddlBatchType,#ConatntMatter_ddlAssessmentType").prop("disabled", false);
            // $("#ConatntMatter_ddlSetName").val(0);
        }

        function fndelete_row(CycleID) {
            if (confirm('Are you sure you want to delete this batch')) {
                PageMethods.fnCheckMappedUsersAgCycle(CycleID, fnChkSuccessMapped, fnFailedCycle, CycleID);
            }
        }

        function fnChkSuccessMapped(result, CycleID) {

            if (result.split("@")[0] == "1") {
                var chkFlag = result.split("@")[1]
                if (chkFlag == "1") {
                    alert("You can not delete this cycle because Users are already Mapped with the batch. In any case if you want to remove this , kindly removed the mapping first from ''Assessee and Assessor Mapping''")
                    return false;
                }
                else {
                    PageMethods.fnDeleteCycle(CycleID, fnDeleteSuccess, fnFailedCycle);
                }
            }
            else {
                alert("Error....")
            }
        }
        function fnDeleteSuccess(result) {
            if (result.split("@")[0] == "1") {
                alert("Delete Successfully")
                var UserFilter = $("#ConatntMatter_txtSearch").val();
                $("#loader").show()
                //  debugger;
                PageMethods.fnGetCycleDetails(0, '', 1, fnGetAllSuccessData, fnFailedCycle, 0);
                //  PageMethods.fnGetCycleDetails(0, fnGetAllSuccessData, fnFailedCycle, 0);
            }
        }
    </script>

    <script type="text/javascript">


        function fnEditCycleDetails(CycleID, CycleName, CycleStartdate, CycleEnddate, BandID, AssessmentTypeId, flgCycleType) {
            // alert(flgCycleType);
            CycleName = replaceAll(CycleName, "_", " ") //CycleName.replace("_", " ");
            document.getElementById("ConatntMatter_hdnCycleID").value = CycleID;
            document.getElementById("ConatntMatter_txtCycleName").value = CycleName;
            document.getElementById("ConatntMatter_txtDate").value = CycleStartdate;
            document.getElementById("ConatntMatter_txtEndDate").value = CycleEnddate;
            $("#ConatntMatter_txtEndDate").datepicker("option", "minDate", CycleStartdate)
            $("#ConatntMatter_txtDate, #ConatntMatter_ddlBatchType,#ConatntMatter_ddlAssessmentType").prop("disabled", true);
            $("#ConatntMatter_ddlAssessmentType").val(AssessmentTypeId);
            $("#ConatntMatter_ddlBatchType").val(flgCycleType);
            document.getElementById("ConatntMatter_hdnFlag").value = 1;
            //   $("#ConatntMatter_ddlSetName").val(BandID);
            $("#dvDialog").dialog({
                title: "Modify Cycle Details",
                resizable: false,
                height: "auto",
                width: "50%",
                modal: true
            });
        }



        function replaceAll(str, find, replace) {
            while (str.indexOf(find) > -1) {
                str = str.replace(find, replace);
            }
            return str;
        }
        function fnddlBatchTypeChange() {
            var ddlBatchTypeValue = $("#ConatntMatter_ddlBatchType option:selected").text();
            document.getElementById("ConatntMatter_txtCycleName").value = "Cycle:" + document.getElementById("ConatntMatter_txtDate").value;//+ "_" + ddlBatchTypeValue;

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title clearfix">
        <h3 class="text-center">Cycle Information</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="form-inline mb-3 d-flex">
        <div>
            <input type="button" id="btnShowAll" runat="server" value="Show All" class="btn btn-primary" />
        </div>
        <div class="input-group ml-auto">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search" CssClass="form-control"></asp:TextBox>
            <div class="input-group-append">
                <input type="button" id="btnSearch" runat="server" value="Show" class="btn btn-primary" />
            </div>
        </div>
    </div>
    <div id="dvMain" runat="server"></div>
    <div class="text-center">
        <input type="button" id="AddNewCycle" value="Add New Cycle" onclick="fnAddNewCycle()" class="btns btn-cancel" />
    </div>


    <div id="dvDialog" style="display: none">
        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="CycleName">Assessment Type</label>
                <asp:DropDownList ID="ddlAssessmentType" runat="server" CssClass="form-control"></asp:DropDownList>
            </div>
            <div class="form-group col-md-6 d-none">
                <label for="BatchName">Bacth Type</label>
                <asp:DropDownList ID="ddlBatchType" runat="server" onchange="fnddlBatchTypeChange()" CssClass="form-control">
                    <asp:ListItem Value="0">With Functional</asp:ListItem>
                    <asp:ListItem Value="1" Selected>Without Functional</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group col-md-3">
                <label for="CycleDate">Cycle Start Date</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="form-control" MaxLength="50" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="form-group col-md-3">
                <label for="CycleDate">Cycle End Date</label>
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" MaxLength="50" ReadOnly="true"></asp:TextBox>
            </div>
            <div class="form-group col-md-12">
                <label for="CycleName">Cycle Name</label>
                <asp:TextBox ID="txtCycleName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>


        <div class="text-center">
            <input type="button" value="Save" onclick="fnSaveCycle()" class="btns btn-cancel" />
        </div>
    </div>


    <asp:HiddenField ID="hdnCycleID" runat="server" Value=" 0" />
    <asp:HiddenField ID="hdnFlag" runat="server" Value=" 0" />
</asp:Content>

