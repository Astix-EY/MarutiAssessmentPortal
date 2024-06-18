<%@ Page Title="" Language="VB" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="false" CodeFile="frmManageEmployeeDetails.aspx.vb" Inherits="Admin_MasterForms_frmManageEmployeeDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style type="text/css">
        .pointer {
            cursor: pointer;
        }
    </style>
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

        var string = /^[a-zA-Z]*$/;
        var stringFirstName = /^[a-zA-Z ]*$/;


        function fnSaveEmployeeDetails() {

            var UserType = $('#ConatntMatter_ddlUserType').val();
            var Fname = document.getElementById("ConatntMatter_txtFName").value.trim();
            var Lname = document.getElementById("ConatntMatter_txtLName").value.trim();
            var EmailID = document.getElementById("ConatntMatter_txtEmailID").value.trim();


            var Empcode = document.getElementById("ConatntMatter_txtEmpCode").value.trim();

            var SetID = $('#ConatntMatter_ddlSetName').val();
            if (UserType == 0) {
                alert("Please select the user type")
                return false;
            }

            //if (Fname == "" || !Fname.match(stringFirstName))
            //{

            //    if (!Fname.match(string)) {
            //        alert("Please enter only alphabetical characters")
            //    }
            //    else {
            //        alert("Please enter the first name")
            //    }
            //    return false;
            //}

            //if (Lname == "" || !Lname.match(stringFirstName)) {

            //    if (!Lname.match(string)) {
            //        alert("Please enter only alphabetical characters")
            //    }
            //    else {
            //        alert("Please enter the last name")
            //    }
            //    return false;
            //}    


            if (Fname == "") {
                alert("Please enter the first name")
                return false;
            }


            if (Lname == "") {
                alert("Please enter the last name")
                return false;
            }

            if (Empcode == "") {
                alert("Please enter the Empcode")
                return false;
            }

            if (EmailID == "") {
                alert("Please enter the EmailId")
                return false;
            }

            if (IsEmail(EmailID) == false) {
                alert("Please enter the correct emailid")
                return false;
            }


            if (UserType == "1") {

                if (SetID == 0) {
                    alert("Please select the Level name")
                    return false;
                }

            }

            Fname = Fname.replace("_", " ");
            Lname = Lname.replace("_", " ");

            var hdnEmpID = document.getElementById("ConatntMatter_hdnEmpID").value;
            //   alert(hdnEmpID)
            PageMethods.fnManageEmployeeDetails(hdnEmpID, Fname, Lname, Empcode, EmailID, UserType, SetID, fnSaveSuccessEmpDetails, fnFailed);

        }
        function fnSaveSuccessEmpDetails(result) {
            if (result.split("@")[0] == "1") {

                //  var ReturnEmpId = result.split("^")[1]
                //document.getElementById("ConatntMatter_hdnEmpID").value = ReturnEmpId;
                if (result.split("@")[1] == "1") {
                    alert("This EmailID/Employee Code is already exists into the system")
                    return false;
                }
                else {
                    // alert("Save Successfully")
                    var UserFilter = $("#ConatntMatter_ddlUsers").val();
                    PageMethods.fnGetEmployeeDetails(UserFilter, '', 1, fnGetAllSuccessData, fnFailed, 1);
                }

            }
            else {
                alert("Error....")
            }
        }

        function fnGetAllSuccessData(result, returnVal) {
            $("#loader").hide();
            if (result.split("~")[0] == "1") {
                if (returnVal == 1) {
                    $("#dvDialog").dialog('close');
                    if (document.getElementById("ConatntMatter_hdnFlag").value == "1") {
                        alert("Updated Successfully")
                    }
                    else {
                        alert("Saved Successfully")
                    }
                }
                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("~")[1];
                var allsecheight = $(".navbar").outerHeight() + $('.section-title').outerHeight() + $('.d-flex').outerHeight();
                $("#ConatntMatter_dvMain").tblheaderfix({
                    height: $(window).height() - (allsecheight + 170)
                });


            }

        }
        function fnFailed(result) {
            alert("Error - " + result.split("^")[1])
        }



        function fnAddNewEmployee() {
            $("#dvDialog").dialog({
                title: "Add New User Details",
                resizable: false,
                height: "auto",
                width: "50%",
                modal: true
            });
            document.getElementById("ConatntMatter_txtFName").value = "";
            document.getElementById("ConatntMatter_txtLName").value = "";
            document.getElementById("ConatntMatter_txtEmpCode").value = "";
            document.getElementById("ConatntMatter_txtEmailID").value = "";

            // $("#ConatntMatter_ddlUserType option[value=0]").attr('selected', 'true')
            $("#ConatntMatter_txtEmpCode").prop("disabled", false);

            $("#ConatntMatter_ddlUserType").val(0);

            $("#ConatntMatter_ddlUserType").prop("disabled", false);

            //$("#ConatntMatter_ddlSetName option[value=0]").attr('selected', 'true')
           // $("#ConatntMatter_ddlSetName").val(0);
            $("#ConatntMatter_ddlSetName").prop("disabled", false);
            document.getElementById("ConatntMatter_hdnEmpID").value = 0;
            document.getElementById("ConatntMatter_hdnFlag").value = 0;

        }

        function fndelete_row(EmpNodeID) {
            if (confirm('Are you sure you want to delete this employee')) {
                PageMethods.fnCheckMappedUsersAgCycle(EmpNodeID, fnChkSuccessMapped, fnFailed, EmpNodeID);
            }
        }

        function fnChkSuccessMapped(result, EmpNodeID) {

            if (result.split("@")[0] == "1") {
                var chkFlag = result.split("@")[1]
                if (chkFlag == "1") {
                    alert("You can not delete this user because this user is already started his/her Assessment.")
                    return false;
                }
                else {
                    PageMethods.fnDeleteUser(EmpNodeID, fnDeleteSuccess, fnFailed);
                }
            }
            else {
                alert("Error....")
            }
        }
        function fnDeleteSuccess(result) {
            if (result.split("@")[0] == "1") {
                alert("Delete Successfully")
                $("#ConatntMatter_dvMain")[0].innerHTML = "";
                $("#ConatntMatter_txtSearch").val("");
                var UserFilter = $("#ConatntMatter_ddlUsers").val();
                $("#loader").show()
                PageMethods.fnGetEmployeeDetails(UserFilter, '', 1, fnGetAllSuccessData, fnFailed, 0);
            }
        }
    </script>
    <script type="text/javascript">


        function fnEditEmployeeDetails(EmpNodeId, FName, LName, EmailID, EmpCode, UserType, BandID) {
            FName = replaceAll(FName, "-", " ");

            document.getElementById("ConatntMatter_hdnEmpID").value = EmpNodeId;
            document.getElementById("ConatntMatter_txtFName").value = FName;
            document.getElementById("ConatntMatter_txtLName").value = LName;

            document.getElementById("ConatntMatter_txtEmailID").value = EmailID;

            document.getElementById("ConatntMatter_txtEmpCode").value = EmpCode;
            $("#ConatntMatter_ddlUserType").val(UserType);
            //   $("#ConatntMatter_ddlUserType").find('option[value="' + UserType + '"]').attr('selected', 'true')
            $("#ConatntMatter_ddlUserType").prop("disabled", true);
           // $("#ConatntMatter_ddlSetName").val(BandID);
            // $("#ConatntMatter_ddlSetName").find('option[value="' + BandID + '"]').attr('selected', 'true')
            //$("#ConatntMatter_ddlSetName").prop("disabled", true);

            document.getElementById("ConatntMatter_hdnEmpID").value = EmpNodeId;
            document.getElementById("ConatntMatter_hdnFlag").value = 1;
            $("#dvDialog").dialog({
                title: "Modify Employee Details",
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

        function IsEmail(email) {
            var regex = /^([a-zA-Z0-9_\.\-\+])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            if (!regex.test(email)) {
                return false;
            } else {
                return true;
            }
        }
    </script>
    <script>
        $(document).ready(function () {
            var allsecheight = $(".navbar").outerHeight() + $('.section-title').outerHeight() + $('.d-flex').outerHeight();
            $("#ConatntMatter_dvMain").tblheaderfix({
                height: $(window).height() - (allsecheight + 170)
            });

            $("#ConatntMatter_ddlUsers").on("change", function () {
                $("#ConatntMatter_dvMain")[0].innerHTML = "";
                $("#ConatntMatter_txtSearch").val("");
                var UserFilter = $("#ConatntMatter_ddlUsers").val();
                //   alert(UserFilter)
                $("#loader").show()
                PageMethods.fnGetEmployeeDetails(UserFilter, '', 1, fnGetAllSuccessData, fnFailed, 0);

            });
            $("#ConatntMatter_btnSearch").click(function () {
                $("#ConatntMatter_dvMain")[0].innerHTML = "";
                $("#ConatntMatter_ddlUsers").find('option[value="0"]').attr('selected', 'selected')

                var UserFilter = $("#ConatntMatter_txtSearch").val();
                $("#loader").show()
                //  debugger;
                PageMethods.fnGetEmployeeDetails(0, UserFilter, 2, fnGetAllSuccessData, fnFailed, 0);
            });

            $("#ConatntMatter_ddlUserType").on("change", function () {

                var UserType = $("#ConatntMatter_ddlUserType").val();
                if (UserType == "1") {
                    $("#ConatntMatter_ddlSetName").prop("disabled", false);
                    //  $("#ConatntMatter_txtEmpCode").prop("disabled", false); 
                  //  $("#dvSearch").show();
                }
                else {
                    //  $("#ConatntMatter_txtEmpCode").prop("disabled", true)
                    $("#ConatntMatter_ddlSetName").prop("disabled", true);
                 //   $("#dvSearch").hide();
                }   
            });

        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title clearfix">
        <h3 class="text-center">User Information</h3>
        <div class="title-line-center"></div>
    </div>

    <div class="form-inline mb-3 d-flex">
        <label for="ac" class="col-form-label mr-3">Select Filter</label>
        <div class="input-group">
            <asp:DropDownList ID="ddlUsers" runat="server" CssClass="form-control">
                <asp:ListItem Value="0">.......</asp:ListItem>
                <asp:ListItem Value="1" Selected="true">Participant Not Mapped with any batch</asp:ListItem>
                <asp:ListItem Value="2">Show Participant</asp:ListItem>
                <asp:ListItem Value="3">Show Assessor</asp:ListItem>
                <asp:ListItem Value="4">Show Manager</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="input-group ml-auto" id="dvSearch">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search" CssClass="form-control"></asp:TextBox>
            <div class="input-group-append">
                <input type="button" id="btnSearch" runat="server" value="Show" class="btn btn-primary" />
            </div>
        </div>
    </div>

    <div id="dvMain" runat="server"></div>
    <div class="text-center mt-2">
        <input type="button" id="AddNewEmployee" value="Add New User" onclick="fnAddNewEmployee()" class="btns btn-cancel" />
    </div>

    <div id="dvDialog" style="display: none">

        <div class="form-group col-md-6">
            <label for="EmpCode">Select User Type</label>
            <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control">
                <asp:ListItem Value="0" Selected="True">- Select -</asp:ListItem>
                <asp:ListItem Value="1">Participant</asp:ListItem>
                <asp:ListItem Value="2">Assessor</asp:ListItem>
                <asp:ListItem Value="3">Manager</asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="form-row">
            <div class="form-group col-md-6">
                <label for="FName">FName</label>
                <asp:TextBox ID="txtFName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group col-md-6">
                <label for="FName">LName</label>
                <asp:TextBox ID="txtLName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group col-md-6">
                <label for="EmpCode">EmpCode</label>
                <asp:TextBox ID="txtEmpCode" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <div class="form-group col-md-6">
                <label for="EmailID">EmailID</label>
                <asp:TextBox ID="txtEmailID" runat="server" CssClass="form-control"></asp:TextBox>
            </div>



            <div class="form-group col-md-6 d-none">
                <label for="EmpCode">Which Level to be mapped to participant</label>
                <asp:DropDownList ID="ddlSetName" runat="server" CssClass="form-control">
                    <asp:ListItem Value="0">- Select -</asp:ListItem>
                    <asp:ListItem Value="1" Selected="True">Level4</asp:ListItem>
                    <asp:ListItem Value="2">Level3</asp:ListItem>
                      <asp:ListItem Value="3">Level3-Direct Sales</asp:ListItem>
                      <asp:ListItem Value="4">Level4-Direct Sales</asp:ListItem>
                      <asp:ListItem Value="5">Level3-IndirectSales</asp:ListItem>
                      <asp:ListItem Value="6">Level4-IndirectSales</asp:ListItem>
			 <asp:ListItem Value="7">Level3-Solution </asp:ListItem>
			 <asp:ListItem Value="8">Level4-Solution </asp:ListItem>


                </asp:DropDownList>
            </div>
        </div>
        <div class="text-center mb-2">
            <input type="button" value="Save" onclick="fnSaveEmployeeDetails()" class="btns btn-cancel" />
        </div>
    </div>

    <asp:HiddenField ID="hdnEmpID" runat="server" Value=" 0" />
    <asp:HiddenField ID="hdnFlag" runat="server" Value=" 0" />
</asp:Content>

