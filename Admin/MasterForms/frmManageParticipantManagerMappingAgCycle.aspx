<%@ Page Title="" Language="VB" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="false" CodeFile="frmManageParticipantManagerMappingAgCycle.aspx.vb" Inherits="Admin_MasterForms_frmManageParticipantManagerMappingAgCycle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .ui-widget-content a {
    color: #007bff;
    text-decoration:underline;
}
    </style>
    <script>

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
         $(document).ready(function () {

             $("#ConatntMatter_ddlCycleName").on("change", function () {
                 //  alert("here")

                 $("#ConatntMatter_dvMain")[0].innerHTML = "";
                 $('#btnSave').hide();
                 var CycleID = $("#ConatntMatter_ddlCycleName option:selected").val();
                
                 $("#ConatntMatter_hdnCycleID").val(CycleID)
                

            //     alert($("#ConatntMatter_hdnSelectedStartedDate").val());
                $("#loader").show()
                fnDisplayParticipantAndManagerAgCycle();
                $("#dvSave").show();
             });             
          

             $("#ConatntMatter_btnSearch").click(function () {
                 $("#ConatntMatter_dvMain")[0].innerHTML = "";

                 var UserFilter = $("#ConatntMatter_txtSearch").val();
                 var CycleID = $("#ConatntMatter_ddlCycleName").val();
                 if (CycleID == "0") {
                     alert("Please select the Batch first")
                     return false;
                 }
                 $("#loader").show()
                 //  debugger;
                 PageMethods.fnDisplayParticipantAgCycle(CycleID,fnGetDisplaySuccessData, fnGetFailed);
             });

         });

         function fnDisplayParticipantAndManagerAgCycle()
         {
             var CycleID = $("#ConatntMatter_ddlCycleName option:selected").val();
             PageMethods.fnDisplayParticipantAgCycle(CycleID, fnGetDisplaySuccessData, fnGetFailed);
         }


         function fnGetDisplaySuccessData(result) {
             $("#loader").hide()
            if (result.split("~")[0] == "1") {

                $("#ConatntMatter_dvMain")[0].innerHTML = result.split("~")[1];
                var allsecheight = $(".navbar").outerHeight() + $('.section-title').outerHeight() + $('.d-flex').outerHeight();
                $("#ConatntMatter_dvMain").tblheaderfix({
                    height: $(window).height() - (allsecheight + 170)
                });

                $("#btnSave").show();
            }
        }
        function fnGetFailed(result)
        {
            alert ("Error")
        }

    </script>
   <%--  <script type="text/javascript">
        function checkBoxValidate() {
            valid = true;

            if ($('input[type=checkbox]:checked').length == 0) {
                alert("Please select at least one checkbox");
                valid = false;
            }

            return valid;
        }


        $(document).ready(function () {

            $('#btnSave').click(function () {

                var flgValidate = checkBoxValidate();

                if (flgValidate == false) {
                    return false;
                }

                var objDetail = new Array();
                var objDetail1 = new Array();
                var CycleID = $("#ConatntMatter_ddlCycleName").val();
                var Selecteddate = $("#ConatntMatter_hdnSelectedStartedDate").val();

                var strCycleAssessorArr = new Array();
                var strAssessorEmailDArr = new Array();
                $("input[type=checkbox]:checked").each(function () {
                    var AssessorID = $(this).attr("AssessorID");
                    var AssessorEmailID = $(this).attr("AssessorEmailID");
                    var UserName = $(this).attr("UserName");
                    var Password = $(this).attr("Password");
                    var AssessorCycleMappingId = $(this).attr("AssessorCycleMappingId");
                    var SecondaryEmailID = $(this).attr("SecondaryEmailID");
                    //  var CmpCycleMapId = $(this).attr("CmpCycleMapId");
                    if (AssessorCycleMappingId == "0")
                    {
                        strCycleAssessorArr = [{
                            CycleID: CycleID, AssessorID: AssessorID
                        }];
                        objDetail.push(strCycleAssessorArr[0]);
                    }
                   

                    //strAssessorEmailDArr = [{
                    //    CycleID: CycleID, AssessorID: AssessorID, AssessorEmailID: AssessorEmailID, UserName: UserName, Password: Password, Selecteddate: $("#ConatntMatter_hdnSelectedStartedDate").val(), AssessorCycleMappingId: AssessorCycleMappingId, SecondaryEmailID: SecondaryEmailID
                    //}];

                   
                  //  objDetail1.push(strAssessorEmailDArr[0]);
                });
              //  alert(objDetail)
                $("#loader").show()
              PageMethods.fnManageAssessmentAssessorAgCycle(CycleID, objDetail, Selecteddate, fnUpdateAssessorCycleSuccess, fnUpdateAssessorCycleFailed)

            });

            function fnUpdateAssessorCycleSuccess(result) {
                if (result.split("~")[0] == "1") {
                    $("#dvDialog")[0].innerHTML = "Mapped Successfull" //result.split("~")[1]
                    $("#dvDialog").dialog({
                        width: "430",
                        modal: true,
                        title: "Confirmation:",
                        buttons:
                            {
                                "Ok": function () {
                                    $(this).dialog('close');
                                }
                            }
                    });
                    $("#loader").hide()
                    fnDisplayAssessorAgCycle();
                }
            }
            function fnUpdateAssessorCycleFailed(result) {
                if (result.split("~")[0] == "2") {
                    alert(result.split("~")[1]);
                    $("#loader").hide()
                }

            }

        });

    </script>
  
     <script type="text/javascript">
         function fnDeleteAssessorMapping(Sender)
        {
             var EmpNodeID = $(Sender).attr("AssessorID")
             var CycleID = $("#ConatntMatter_hdnCycleID").val();

             $("#dvDialog")[0].innerHTML = "Are you sure you want to remove this assessor from this batch"
             $("#dvDialog").dialog({
                 width: "385",
                 modal: true,
                 title: "Confirmation:",
                 buttons:
                     {
                         "Yes": function () {
                             PageMethods.fnCheckMappedUsersAgCycle(EmpNodeID, CycleID, fnChkSuccessMapped, fnFailed, Sender);
                         },
                         "No":function () {
                             $(this).dialog('close');
                         }
                     }
             });

            //if (confirm('Are you sure you want to delete this developer from this cycle')) {
            //    PageMethods.fnCheckMappedUsersAgCycle(EmpNodeID,CycleID, fnChkSuccessMapped, fnFailed, Sender);
            //}
        }
        function fnChkSuccessMapped(result, Sender) {
           
            var CycleID = $("#ConatntMatter_hdnCycleID").val();
          //  var Sender = Str.split("^")[0]
            var EmpNodeID = $(Sender).attr("AssessorID")
            if (result.split("@")[0] == "1") {
                var chkFlag = result.split("@")[1]
                if (chkFlag == "1") {
                    $("#dvDialog")[0].innerHTML = "You can not assessor this developer because this assessor is already mapped with a participant. In any case if you want to delete the mapping, Kindly delete the mapping first from 'Participant and Developer Mapping' page."
                    $("#dvDialog").dialog({
                        width: "500",
                        modal: true,
                        title: "Message:",
                        buttons:
                            {
                                "OK": function () {
                                    $(this).dialog('close');
                                }
                            }
                    });

                   // alert("You can not delete this Developer because this developer is already mapped with any participant.In any case if you want to delete the mapping, Kindly delete the mapping first from 'Participant and Developer Mapping' page.")
                    return false;
                }
                else
                {
                    PageMethods.fnDeleteAssessor(EmpNodeID,CycleID, fnDeleteSuccess, fnFailed, Sender);
                }
            }
            else {
                $("#dvDialog")[0].innerHTML = "Error......"
                $("#dvDialog").dialog({
                    width: "385",
                    modal: true,
                    title: "alert:",
                    buttons:
                        {
                            "Ok": function () {
                                $(this).dialog('close');
                            }
                        }
                });
            }
        }
        function fnDeleteSuccess(result, sender) {
            if (result.split("@")[0] == "1")
            {              
                $(sender).closest('tr').find('input[type="checkbox"]').prop('disabled', false);
                $(sender).closest('tr').find('input[type="checkbox"]').prop('checked', false);             
              
              
                $("#dvDialog")[0].innerHTML = "Maping Removed Successfully"
                $("#dvDialog").dialog({
                    width: "385",
                    modal: true,
                    title: "Message:",
                    buttons:
                        {                            
                            "Ok": function () {
                                $(this).dialog('close');
                            }
                        }
                });

                $(sender).closest("tr").find('input[type="checkbox"]').attr('AssessorCycleMappingId', 0);
               

                $(sender).remove();
            //    fnDisplayParticpantAgCycle();
              
            }
        }
        function fnFailed(result) {
            alert("Error - " + result.split("^")[1])
        }
    </script>--%>

    <script type="text/javascript">
        function fnSaveData()
        {
            var tbl = $("#tblMain").find('select');
            if (tbl.length == 0) {
                alert("Kindly Select Manager first!!!");
                return false;
            }
            var chkFlag = 0;
            $("select").each(function()
            {
                if (this.value == "0")
                {
                    chkFlag = 1;
                    return false;
                }
              
            });

            if(chkFlag==1) {
                alert("Please select the manager");
                return false;
            }


            $("#dvDialog")[0].innerHTML = "Are you sure you have selected the correct manager for each participant?"
            $("#dvDialog").dialog({
                width:"385",
                modal: true,
                title: "Confirmation:",
                buttons: {
                    "Yes": function ()
                    {
                        $(this).dialog('close');

                        var CycleID = $("#ConatntMatter_ddlCycleName").val();
                        var arrNodeID = new Array();
                        for (var i = 0; i < tbl.length; i++) {
                           
                            {
                                if (tbl.eq(i).closest("tr").find("select option:selected").val() != "0")
                                {
                                    var ParticipantNodeID = tbl.eq(i).closest("tr").attr("ParticipantNodeID");
                                    var ManagerId = tbl.eq(i).closest("tr").find("select option:selected").val();
                                    
                                    arrNodeID.push({ID:0, ParticipantNodeID: ParticipantNodeID, ManagerId: ManagerId });
                                }
                            }
                        }
                        if (arrNodeID.length == 0) {
                            alert("Action is not completed as you have not mapped any new Manager!");
                            return false;
                        }
                     
                        $("#loader").show()
                        PageMethods.fnManageAssessmentParticipantManagerAgCycle(CycleID, arrNodeID, function (result) {
                            $("#loader").hide()
                            if (result.split("|")[0] == "2") {
                                alert("Some Technical Error!!")
                            } else {
                                alert("Mapped Successfully!!");
                                fnDisplayParticipantAndManagerAgCycle();
                               
                            }
                        },
                            function (result) {
                                $("#loader").hide()
                                alert(result._message)
                            }
                        )
                    },
                    "No": function () {
                        $(this).dialog('close');
                    }
                }
            });

        }
      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" Runat="Server">
     <div class="section-title clearfix"> 
        <h3 class="text-center">Participant and Manager Mapping</h3>
        <div class="title-line-center"></div>
    </div>
   
   
    <div class="form-group row">
        <label class="col-2 col-form-label" for="Cycle">Select Cycle</label>
        <div class="col-4">
            <asp:DropDownList ID="ddlCycleName" runat="server" CssClass="form-control" AppendDataBoundItems="true">
              
            </asp:DropDownList>
        </div>
        <div style="display:none">
         <div class="input-group ml-auto">
            <asp:TextBox ID="txtSearch" runat="server" placeholder="Search" CssClass="form-control"></asp:TextBox>
            <div class="input-group-append">
                <input type="button" id="btnSearch" runat="server" value="Show" class="btn btn-primary" />
            </div>
        </div>
            </div>
    </div>
    <div id="dvMain" runat="server"></div>
    <div class="text-center" style="display:none" id="dvSave">
        <input type="button" id="btnSave" value="Save" class="btns btn-submit" onclick="fnSaveData()" />
    </div>
     <div id="loader" class="loader_bg">
        <div class="loader"></div>
    </div>
        <div id="dvDialog" style="display: none"></div>
    <input type="hidden" id="hdnCycleName" />
     <input type="hidden" id="hdnSelectedStartedDate" runat="server" />
     <input type="hidden" id="hdnCycleID" runat="server" />
</asp:Content>

