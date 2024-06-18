<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmParticipantAndAssessorGotoMeetingCreation.aspx.cs" EnableEventValidation="false" Inherits="Admin_MasterForms_frmParticipantAndAssessorMapping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">

     <script>
        var StoreList = [];
        $(document).ready(function () {
            //fnDSEList();
        });

        function fnDSEList() {
            var CycleId = $("#ConatntMatter_ddlCycle").val();
            var LoginId = $("#ConatntMatter_hdnLoginId").val();
            var CycleDate = $("#ConatntMatter_ddlCycle option:selected").attr("CycleDate");
            $("#anchorbtn_other").hide();
            $("#anchorbtn_gd").hide();
            if (CycleId == 0) {
                $("#ConatntMatter_divdrmmain").show();
                $("#anchorbtn_other").hide();
                $("#ConatntMatter_divdrmmain")[0].innerHTML = "";
                return false;
            }
            $("#dvFadeForProcessing").show();
            PageMethods.fngetdata(CycleId, CycleDate, function (result) {
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
                    $("#divBTNS").show();
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

                        var secheight = $('.section-title').outerHeight(), nvheight = $(".navbar").outerHeight(), fgheight = $('.form-group').outerHeight();
                        $('#dvtblbody').css({
                            'height': $(window).height() - (nvheight + secheight + fgheight + 290),
                            'overflow-y': 'auto',
                            'overflow-x': 'hidden'
                        });


                        $(".mergerow").closest('tr').find('td').css('border-top', '2px solid black');
                        //$(".mergerow").closest('tr').find('td').css('border-top-width', 'thik');
                       
                    }
                }
            },
                function (result) {
                    $("#dvFadeForProcessing").hide();
                    alert("Error-" + result._message);
                }
            )
        }



         </script>



    <script>

        //for saving 


        function fnSave() {

            var isvalid = true;
           
            var CycleId = $("#ConatntMatter_ddlCycle").val();
            var CycleDate = $("#ConatntMatter_ddlCycle option:selected").attr("CycleDate");
            var ArrDataSaving = []; var ArrDataMails = [];
            $("#ConatntMatter_divdrmmain").find("#tbldbrlist tbody tr").each(function () {
                var IsLeadAssessor = 0
                    ArrDataSaving.push({ ParticipantCycleMappingId: $(this).attr("ParticipantCycleMappingId"), AssessorCycleMappingId: $(this).attr("AssessorCycleMappingId"), ParticipantId: $(this).attr("ParticipantId"), AssessorId: $(this).attr("AssessorId"), IsLeadAssessor: 0, ExerciseId: $(this).attr("ExerciseId"), ExerciseName: $(this).attr("ExerciseName"), AssesseMeetingLink: "", AssessorMeetingLink: "", MeetingId: "0", MeetingStartTime: $(this).attr("cycledate") + " " + $(this).attr("ExerciseStartTime"), PreTime: $(this).attr("PreTime"), AssessorTime: $(this).attr("AssessorTime"), AssessorMail: "", AssessorName: $(this).attr("AssessorName"), AssesseeMail: "", AssesseeName: $(this).attr("participantname"), BEIUserName: $(this).attr("BEIUserName"), BEIPwd: $(this).attr("BEIPassword"), flgCreated: 0, MeetingStatus: '', gdid: 0, PRStartTime: "00:00", Role: 0 });
            });

           
            if (ArrDataSaving.length == 0) {
                alert("No Meeting Schedule!")
                return false;
            }
            $("#dvFadeForProcessing").show();
            PageMethods.fnSave($("#ConatntMatter_hdnLoginId").val(),CycleId, fnSave_Success, fnFailed);
        }

        function fnSave_Success(result) {
            $("#dvFadeForProcessing").hide();
            if (result.split("|")[0] == "0") {
                var tbl = $.parseJSON(result.split("|")[1]);
                var strHTML = "";
                if (tbl.length > 0) {
                    $("#anchorbtn_other").hide();
                    var style = "border-left: 1px solid #A0A0A0; border-bottom: 1px solid #A0A0A0;font-family:arial narrow;font-size:9pt;";
                    strHTML += "Kindly find below Schedule status for each participant.</br> If there is an error against any participant to schedule meeting,Kindly try again for that participant to schedule a meeting</br></br>";
                    strHTML += ("<table cellpadding='2' cellspacing='0' style='font-family:arial narrow;font-size:8.5pt;border-right: 1px solid #A0A0A0; border-top: 1px solid #A0A0A0;text-align:center;width:100%'><thead>");
                    strHTML += ("<tr bgcolor='#26a6e7'>");
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Sr.No</th>";
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Assessor Name</th>";
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Participant Name</th>";
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Exercise Name</th>";
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Exercise Time</th>";
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Mapping Status</th>";
                    strHTML += ("</tr></thead><tbody>");
                    var oldAssesseeName = ""; var cntrow = 0;
                    for (var i in tbl) {
                        var ParticipantAssessorMappingId = 0;
                        var MeetingStatus = tbl[i]["MeetingStatus"];
                        var AssesseeName = tbl[i]["ParticipantName"];
                        var AssessorName = tbl[i]["AssessorName"];
                        var MeetingStartTime = tbl[i]["MeetingStartTime"];
                        var ExerciseName = tbl[i]["ExerciseName"];
                        var Role = tbl[i]["Role"];
                        var strColor = "";
                        var rowspancnt = Role == 2 ? 5 :(Role == 1? 4:1);
                        strHTML += ("<tr>");
                       
                        if (oldAssesseeName != AssesseeName) {
                            strHTML += "<td  style='" + style + ";text-align:center;padding:3px' rowspan='" + rowspancnt + "'>" + (eval(cntrow) + 1) + "</td>";
                            strHTML += "<td  style='" + style + ";text-align:left;padding:3px' rowspan='" + rowspancnt + "'>" + AssessorName + "</td>";
                            strHTML += "<td  style='" + style + ";text-align:left;padding:3px' rowspan='" + rowspancnt + "'>" + AssesseeName + "</td>";
                            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + ExerciseName + "</td>";
                            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + MeetingStartTime + "</td>";
                            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + MeetingStatus + "</td>";
                            cntrow++;
                        } else {
                            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + ExerciseName + "</td>";
                            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + MeetingStartTime + "</td>";
                            strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + MeetingStatus + "</td>";
                        }
                        strHTML += ("</tr>");
                        
                        oldAssesseeName = AssesseeName;
                    }
                    strHTML += ("</tbody></table>");
                }
                $("#dvAlert")[0].innerHTML = strHTML;
                $("#dvAlert").dialog({
                    title: "Alert!",
                    modal: true,
                    width: "750",
                    height: "450",
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
                    width: "auto",
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

    </script>



   
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" Runat="Server">
     <div class="section-title clearfix">
        <h3 class="text-center">Meeting Creation</h3>
        <div class="title-line-center"></div>
    </div>
    <div class="form-group row">
        <label for="ac" class="col-sm-2 col-form-label">Select Cycle :</label>
        <div class="col-sm-4">
            <asp:DropDownList runat="server" ID="ddlCycle" onchange="fnDSEList()" CssClass="form-control">
            </asp:DropDownList>
        </div>
        
    </div>
  

     <div id="divdrmmain" runat="server"></div>


    <div class="text-center" id="divBTNS" style="display: none;">
        <a href="###" class="btns btn-submit" onclick="return fnSave()" id="anchorbtn_other" style="display:none">Final Submit</a>
    </div>

    <div id="dvDialog" style="display: none"></div>
     <div id="dvAlert" style="display: none;"></div>
    <div id="dvFadeForProcessing" class="loader_bg">
        <div class="loader"></div>
    </div>
     <asp:HiddenField runat="server" ID="hdnLoginId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnMenuId" Value="0" />
</asp:Content>

