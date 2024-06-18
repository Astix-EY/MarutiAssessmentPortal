<%@ Page Title=""  Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmParticipantMappingWithEklavya.aspx.cs" EnableEventValidation="false" Inherits="frmParticipantMappingWithEklavya" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%--<script src="https://code.jquery.com/jquery-3.4.1.js"></script>--%>
    <style>
        tr.clstrgdmapped > td{
            background-color:#f5f5f5;
        }
        img{
            width:auto;
        }
    </style>
    <script>
        var StoreList = [];
        $(document).ready(function () {
            fnDSEList();
        });
        var MappingStatus = 0;
        function fnDSEList() {
            var CycleId =$("#ConatntMatter_ddlCycle").val();
            var LoginId = $("#ConatntMatter_hdnLoginId").val();
            var CycleDate = $("#ConatntMatter_ddlCycle option:selected").attr("CycleDate");
            var assessmenttypeid = $("#ConatntMatter_ddlCycle option:selected").attr("assessmenttypeid");
            $("#anchorbtn_other").hide();
            $("#anchorbtn_gd").hide();
            if (CycleId == 0) {
                
                $("#ConatntMatter_divdrmmain").show();
               
                $("#anchorbtn_other").hide();
                $("#ConatntMatter_divdrmmain")[0].innerHTML = "";
                return false;
            }
            $("#dvFadeForProcessing").show();
            PageMethods.fngetdata(CycleId, CycleDate,assessmenttypeid, function (result) {
                $("#dvFadeForProcessing").hide();
                $("#divBTNS").hide();
                if (result.split("|")[0] == "2") {
                    alert("Error-" + result.split("|")[1]);
                } else if (result == "") {
                    $("#ConatntMatter_divdrmmain")[0].innerHTML = "No Participant Found!!!";
                }
                else {
                   
                    $("#ConatntMatter_divdrmmain").show();
                    $("#anchorbtn_other").show();
                    $("#ConatntMatter_divdrmmain")[0].innerHTML = result.split("|")[0];
                    
                    //---- this code add by satish --- //
                    $("#ConatntMatter_divdrmmain").prepend("<div id='tblheader'></div>");
                    if ($("#tbldbrlist").length > 0) {
                        var wid = $("#tbldbrlist").width(), thead = $("#tbldbrlist").find("thead").eq(0).html();
                        $("#tblheader").html("<table id='tblEmp_header' class='table table-bordered table-sm mb-0' style='width:" + (wid - 1) + "px;'><thead>" + thead + "</thead></table>");
                        $("#tbldbrlist").css({ "width": wid, "min-width": wid });

                        for (i = 0; i < $("#tbldbrlist").find("th").length; i++) {
                            var th_wid = $("#tbldbrlist").find("th")[i].clientWidth;
                            $("#tblEmp_header, #tbldbrlist").find("th").eq(i).css({ "min-width": th_wid, "width": th_wid });
                        }
                        $("#tbldbrlist").css("margin-top", "-" + ($("#tblEmp_header")[0].offsetHeight) + "px");

                        //var secheight = $('.section-title').outerHeight(), nvheight = $(".navbar").outerHeight(), fgheight = $('.form-group').outerHeight();
                        $('#dvtblbody').css({
                            'height': $(window).height() - 320,
                            'overflow-y': 'auto',
                            'overflow-x': 'hidden'
                        });
                        $("#divBTNS").show();


                        $(".mergerow").closest('tr').find('td').css('border-top', '2px solid black');
                        //$(".mergerow").closest('tr').find('td').css('border-top-width', 'thik');

                    }
                   
                    //---- end code --- //

                }
            },
                function (result) {
                    $("#dvFadeForProcessing").hide();
                    alert("Error-" + result._message);
                }
            )
        }

        function fnFixTblHeader(flg) {
            if (flg == 2) {
                $("#ConatntMatter_divdrmmainGD").prepend("<div id='tblheaderGD'></div>");
                if ($("#tbldbrlistGD").length > 0) {
                    var wid = $("#tbldbrlistGD").width(), thead = $("#tbldbrlistGD").find("thead").eq(0).html();
                    $("#tblheaderGD").html("<table id='tblEmp_headerGD' class='table table-bordered table-sm mb-0' style='width:" + (wid - 1) + "px;'><thead>" + thead + "</thead></table>");
                    $("#tbldbrlistGD").css({ "width": wid, "min-width": wid });

                    for (i = 0; i < $("#tbldbrlistGD").find("th").length; i++) {
                        var th_wid = $("#tbldbrlistGD").find("th")[i].clientWidth;
                        $("#tblEmp_headerGD, #tbldbrlistGD").find("th").eq(i).css({ "min-width": th_wid, "width": th_wid });
                    }
                    $("#tbldbrlistGD").css("margin-top", "-" + ($("#tblEmp_headerGD")[0].offsetHeight) + "px");

                    var secheight = $('.section-title').outerHeight(), nvheight = $(".navbar").outerHeight(), fgheight = $('.form-group').outerHeight();
                    $('#dvtblbodyGD').css({
                        'height': $(window).height() - (nvheight + secheight + fgheight + 190),
                        'overflow-y': 'auto',
                        'overflow-x': 'hidden'
                    });
                    $("#divBTNS").show();
                }
            } else {
                $("#ConatntMatter_divdrmmain").prepend("<div id='tblheader'></div>");
                if ($("#tbldbrlist").length > 0) {
                    var wid = $("#tbldbrlist").width(), thead = $("#tbldbrlist").find("thead").eq(0).html();
                    $("#tblheader").html("<table id='tblEmp_header' class='table table-bordered table-sm mb-0' style='width:" + (wid - 1) + "px;'><thead>" + thead + "</thead></table>");
                    $("#tbldbrlist").css({ "width": wid, "min-width": wid });

                    for (i = 0; i < $("#tbldbrlist").find("th").length; i++) {
                        var th_wid = $("#tbldbrlist").find("th")[i].clientWidth;
                        $("#tblEmp_header, #tbldbrlist").find("th").eq(i).css({ "min-width": th_wid, "width": th_wid });
                    }
                    $("#tbldbrlist").css("margin-top", "-" + ($("#tblEmp_header")[0].offsetHeight) + "px");

                    var secheight = $('.section-title').outerHeight(), nvheight = $(".navbar").outerHeight(), fgheight = $('.form-group').outerHeight();
                    $('#dvtblbody').css({
                        'height': $(window).height() - (nvheight + secheight + fgheight + 355),
                        'overflow-y': 'auto',
                        'overflow-x': 'hidden'
                    });
                    $("#divBTNS").show();


                    $(".mergerow").closest('tr').find('td').css('border-top', '2px solid black');
                    //$(".mergerow").closest('tr').find('td').css('border-top-width', 'thik');
                    $("#anchorbtn_other").show();
                    $("#anchorbtn_gd").hide();
                }
            }
        }

     

    </script>



    <script>

        //for saving 


        function fnSave(flg) {

            var flgvalid = true;
            var IsCnt = 0;
            var flgStatus = 1;

            var CycleId = $("#ConatntMatter_ddlCycle").val();
            var CycleDate = $("#ConatntMatter_ddlCycle option:selected").attr("CycleDate");
            var assessmenttypeid = $("#ConatntMatter_ddlCycle option:selected").attr("assessmenttypeid");
            var ArrDataSaving = []; var ArrDataMails = [];

         
            // if (flg == 1) {
            var cntOneTonOne = 0; var OldParticipantCycleMappingId = 0; var startTime = ""; var timeselected = 0; var exercisecnt = 0;
            $("#ConatntMatter_divdrmmain").find("#tbldbrlist tbody").find("input[type='checkbox'][flg='1']:checked").each(function () {
                flgvalid = true;
                ArrDataSaving.push({ ParticipantId: $(this).closest("tr").attr("ParticipantId"), ParticipantName: $(this).closest("tr").attr("participantname"), Designation: $(this).closest("tr").attr("designation"), ParticipantMailID: $(this).closest("tr").attr("participantemailid")});
            });

         
            if (flgvalid == false) {
                return false;
            }
           
            if (ArrDataSaving.length == 0) {
                alert("No Mapping Selected!")
                return false;
            }
            //$.extend(ArrDataSaving, ArrDataSavingGD);
            $("#dvFadeForProcessing").show();
            PageMethods.fnSave(ArrDataSaving, $("#ConatntMatter_hdnLoginId").val(), CycleId, flgStatus, fnSave_Success, fnFailed, flgStatus);
        }
        function fnRemoveAssessorMapping(sender,flg) {
            if ($(sender).is(":checked") == false) {
                $(sender).closest("tr").attr("gdid", "0");
                $(sender).closest("tr").attr("assessorid", "0");
                $(sender).closest("tr").attr("assessorcyclemappingid", "0");
                $(sender).closest("tr").find("td").eq(2).html("");
                $(sender).closest("tr").find("td").eq(3).html("");
                $(sender).closest("tr").find("td").eq(4).html("");
                $(sender).closest("tr").removeClass("clstrgdmapped");
            }
        }
        function fnSave_Success(result, flgStatus) {
            $("#dvFadeForProcessing").hide();
            if (result.split("|")[0] == "1") {
               // var tbl = $.parseJSON(result.split("|")[1]);
                $("#dvAlert")[0].innerHTML = result.split("|")[1];
                $("#dvAlert").dialog({
                    title: "Alert!",
                    modal: true,
                    width: "auto",
                    height: "auto",
                    close: function () {
                        $(this).dialog('destroy');
                        fnDSEList();
                    },
                    buttons: {
                        "OK": function () {
                            $(this).dialog('close');
                        }
                    }
                })
            }
            else {
                $("#dvAlert")[0].innerHTML = "Oops! Something went wrong. Please try again.</br>Error:" + result.split("|")[1];
                $("#dvAlert").dialog({
                    title: "Error:",
                    modal: true,
                    width: "550",
                    height: "auto",
                    close: function () {
                        $(this).dialog('destroy');
                    },
                    buttons: {
                        "OK": function () {
                            $(this).dialog('close');
                        }
                    }
                })
            }
        }

        function fnFailed(result) {
            alert("Oops! Something went wrong. Please try again.");
            $("#dvFadeForProcessing").hide();
        }

        
        function fnSaveFinalData() {
            var tbl = $("#tbldbrlist").find('select');
            if (tbl.length == 0) {
                alert("Kindly Select Assessor first!!!");
                return false;
            }
            $("#dvDialog")[0].innerHTML = "Are you sure you have selected the correct developer for each participant?"
            $("#dvDialog").dialog({
                width: "385",
                modal: true,
                title: "Confirmation:",
                buttons: {
                    "Yes": function () {
                        $(this).dialog('close');
                        var personIds = "";
                        var arrDSENodeID = new Array();
                        for (var i = 0; i < tbl.length; i++) {
                            var flgMapped = tbl.eq(i).closest("tr").attr("flgMapped");
                            var flgMeeting = tbl.eq(i).closest("tr").attr("flgMeeting");
                            if (flgMeeting == 0 && flgMapped == 0) {
                                if (tbl.eq(i).closest("tr").find("select option:selected").val() != "0") {
                                    var ParticipantAssessorMappingId = tbl.eq(i).closest("tr").attr("ParticipantAssessorMappingId");
                                    var ParticipantCycleMappingId = tbl.eq(i).closest("tr").attr("ParticipantCycleMappingId");
                                    var AssessorCycleMappingId = tbl.eq(i).closest("tr").attr("AssessorCycleMappingId");
                                    var ParticipantId = tbl.eq(i).closest("tr").attr("ParticipantId");
                                    var AssessorId = tbl.eq(i).closest("tr").attr("AssessorId");
                                    var IsLeadAssessor = tbl.eq(i).closest("tr").attr("IsLeadAssessor");
                                    var ExerciseId = tbl.eq(i).closest("tr").attr("ExerciseId");
                                    var AssesseMeetingLink = '';
                                    var AssessorMeetingLink = '';
                                    var MeetingSlotTime = tbl.eq(i).closest("tr").attr("MeetingSlotTime");
                                    var MeetingStartTime = tbl.eq(i).closest("tr").attr("MeetingStartTime");
                                    var MeetingId = 0;


                                    //var ParticipantCycleMappingId = tbl.eq(i).closest("tr").find("select option:selected").val();


                                    arrDSENodeID.push({ ParticipantAssessorMappingId: ParticipantAssessorMappingId, ParticipantCycleMappingId: ParticipantCycleMappingId, AssessorCycleMappingId: AssessorCycleMappingId, ParticipantId: ParticipantId, AssessorId: AssessorId, IsLeadAssessor: IsLeadAssessor, ExerciseId: ExerciseId, AssesseMeetingLink: AssesseMeetingLink, AssessorMeetingLink: AssessorMeetingLink, MeetingSlotTime: MeetingSlotTime, MeetingStartTime: MeetingStartTime, MeetingId: MeetingId });
                                }
                            }
                        }
                        if (arrDSENodeID.length == 0) {
                            alert("Action is not completed as you have not mapped any new Developer!");
                            return false;
                        }
                        var LoginId = $("#ConatntMatter_hdnLoginId").val();
                        $("#dvFadeForProcessing").show();
                        PageMethods.fnParticipantAssessorMapping(LoginId, arrDSENodeID, function (result) {
                            $("#dvFadeForProcessing").hide();
                            if (result.split("|")[0] == "2") {
                                alert("Some Technical Error,Please contact to Technical Team Or Try again later!!")
                            } else {
                                alert("Mapped Successfully!!");
                                fnDSEList();
                                $("#divBTNS").hide();
                            }
                        },
                            function (result) {
                                $("#dvFadeForProcessing").hide();
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



    <script type="text/javascript">
        var OldActive = 1;
        function fnShowDataAssigned(X) {
            var CycleID = $("#ConatntMatter_ddlCycle").val();

            if (CycleID == 0) {
                alert("Please select the Cycle Name");
                $("#ConatntMatter_ddlCycle").eq(0).focus();
                return false;
            }
            //    alert(CycleID)
            var chkFlag = $("#hdnChkFlag").val();

            if (chkFlag == 1) {

                $("#dvDialog")[0].innerHTML = "You have taken an action against the participant but did not saved."
                $("#dvDialog").dialog({
                    width: "450",
                    modal: true,
                    title: "Alert",
                    buttons:
                        {
                            "Ok": function () {
                                $(this).dialog('close');
                            }
                        }
                });


                $("#tablist").find("a.active").removeClass("active");
                $("#tablist").find("a").eq(OldActive - 1).addClass("active");
                return false;
            }

            OldActive = X;
            if (X == 1)   ////// other
            {
                //alert('tab1');
                //$("#anchorbtn_other").show()
                $("#divgrpfilter").hide();
                //     fnDSEList();
                $("#ConatntMatter_divdrmmain").show();
                $("#ConatntMatter_divdrmmainGD").hide();
                $("#ConatntMatter_divdrmmainPR").hide();
                if (MappingStatus < 3) {
                    $("#anchorbtn_other").show();
                    $("#anchorbtn_gd").hide();
                }
                //fnFixTblHeader(1);
                //$("#tblEmp tbody tr").hide();
                //$("#tblEmp  tbody tr[flgactive=1]").css("display", "table-row")

            }
            else if (X == 2)  ///// group discussion
            {
                //alert('tab2');
                $("#divgrpfilter").show();
                //$("#anchorbtn_gd").show()
                // fngroupdiscussion();
                $("#ConatntMatter_divdrmmain").hide();
                $("#ConatntMatter_divdrmmainGD").show();
                $("#ConatntMatter_divdrmmainPR").hide();
               // $("#lblSlotTime")[0].innerHTML="Discussion Time :";
                $(".clsGD").show();
                $(".clsPR").hide();
                //fnFixTblHeader(2);
                //$("#tblEmp tbody tr").hide();
                //$("#tblEmp  tbody tr[flgactive=0]").css("display", "table-row")
                if (MappingStatus < 3) {
                    $("#anchorbtn_gd").show();
                    $("#anchorbtn_other").hide();
                }
            }
            else if (X == 3)  ///// group discussion
            {
                //alert('tab2');
                $("#divgrpfilter").show();
                //$("#anchorbtn_gd").show()
                // fngroupdiscussion();
                $("#ConatntMatter_divdrmmain").hide();
                $("#ConatntMatter_divdrmmainGD").hide();
                $("#ConatntMatter_divdrmmainPR").show();
                $(".clsGD").hide();
                $(".clsPR").show();
                //$("#lblSlotTime")[0].innerHTML="PR Time :";
                //fnFixTblHeader(2);
                //$("#tblEmp tbody tr").hide();
                //$("#tblEmp  tbody tr[flgactive=0]").css("display", "table-row")
                if (MappingStatus < 3) {
                    $("#anchorbtn_gd").show();
                    $("#anchorbtn_other").hide();
                }
            }
            else {
                //$("#tblEmp  tbody tr").css("display", "table-row")
            }
            $("#tablist").find("a.active").removeClass("active");
            $("#tablist").find("a").eq(OldActive - 1).addClass("active");
            //PageMethods.fnDisplayParticpantAgCycle(CycleID, X, fnGetDisplaySuccessData, fnGetFailed, X);

        }

        function fnChangeAssessor(sender) {
            var participantcyclemappingid = $(sender).closest("tr").attr("participantcyclemappingid");
            $(sender).closest("tbody").find("tr[participantcyclemappingid='" + participantcyclemappingid + "']").find("select#ddlassessor").find("option[value=" + $(sender).val() + "]").prop("selected", true);
        }
        function fnChangeTimeSlot(sender) {
            var timeslot = $(sender).val();
            var participantcyclemappingid = $(sender).closest("tr").attr("participantcyclemappingid");
            $(sender).closest("tbody").find("tr[participantcyclemappingid='" + participantcyclemappingid + "']").find("select#ddltimeslot").find("option[value='" + $(sender).val() + "']").prop("selected", true);
        }
        function fnChangeTimeSlotPRP(sender) {
            var timeslot = $(sender).val();
            if (timeslot != "0") {
                var gdid = $("#ConatntMatter_ddlPR").val();
                if ($("#tbldbrlistPR tbody").find("tr[gdid='" + gdid + "']").length > 0) {
                    if ($("#tbldbrlistPR tbody").find("tr[gdid='" + gdid + "']").find("td").eq(2).html().trim() != timeslot) {
                        alert("Sorry,PRP Time can not be changed as you have already assigned this time slot for this PRP,if you want then unmapped the assessor first from the list first.");
                        timeslot = $("#tbldbrlistPR tbody").find("tr[gdid='" + gdid + "']").find("td").eq(2).html().trim();
                        $("#ConatntMatter_ddltimePR option[value='" + timeslot + "']").prop("selected", true);
                    }
                }
            }
        }
        function fnChangeGD(sender) {
            $("#ConatntMatter_ddltime option[value='0']").prop("selected", true);
            $("#ConatntMatter_ddlassessor option[value='0']").prop("selected", true);
        }
        function fnChangePR(sender) {
            $("#ConatntMatter_ddltimePR option[value='0']").prop("selected", true);
            $("#ConatntMatter_ddlassessorPR option[value='0']").prop("selected", true);
        }

        function fnChangeCheckAll() {
            if ($("#chkcheckAll").is(":checked")) {
                $("#tbldbrlist input[flg=1]").prop("checked", true);
            }
            else {
                $("#tbldbrlist input[flg=1]").prop("checked", false);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title clearfix">
        <h3 class="text-center">Participant Mapping With Eklavya</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="form-group row" >
        <label for="ac" class="col-sm-2 col-form-label">Select Cycle :</label>
        <div class="col-sm-4">
            <asp:DropDownList runat="server" ID="ddlCycle" onchange="fnDSEList()" CssClass="form-control">
            </asp:DropDownList>
        </div>
    </div>
   

    <div class="body-content">
      
        <!-- Tab panes -->
             <div id="divdrmmain" runat="server" style="min-height:340px"></div>
    </div>


    <div class="text-center" id="divBTNS" style="display: none;">
        <a href="###" class="btns btn-submit" onclick="return fnSave(1)" id="anchorbtn_other" style="display: none">Save Mapping</a>
    </div>
  

    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlert" style="display: none;"></div>
    <div id="dvFadeForProcessing" class="loader_bg">
        <div class="loader"></div>
    </div>
    <asp:HiddenField runat="server" ID="hdnLoginId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnMenuId" Value="0" />
</asp:Content>

