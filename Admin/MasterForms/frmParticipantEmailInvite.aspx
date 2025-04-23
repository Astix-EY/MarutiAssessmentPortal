<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="true" CodeFile="frmParticipantEmailInvite.aspx.cs" EnableEventValidation="false" Inherits="frmParticipantEmailInvite" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <%--<script src="https://code.jquery.com/jquery-3.4.1.js"></script>--%>
    <style>
        tr.clstrgdmapped > td{
            background-color:#f5f5f5;
        }

    </style>
    <script>
      
        $(document).ready(function () {
            //fnDSEList();

           
        });
        var MappingStatus = 0;
        function fnDSEList() {
            var CycleId = $("#ConatntMatter_ddlCycle").val().split("^")[0];
            var MailCreationStatus = 3;// $("#ConatntMatter_ddlCycle").val().split("^")[1];
            var LoginId = $("#ConatntMatter_hdnLoginId").val();
            var CycleDate = $("#ConatntMatter_ddlCycle option:selected").attr("CycleDate");
            //alert("CycleId=" + CycleId)
            //alert("MeetingCreationStatus=" + MailCreationStatus)
            $("#anchorbtn_other").hide();
            $("#anchorbtn_gd").hide();
            if (CycleId == 0)
            {
                
                $("#ConatntMatter_divdrmmain").show();
                $("#anchorbtn_other").hide();
                $("#ConatntMatter_divdrmmain")[0].innerHTML = "";
                return false;
            }

            if (MailCreationStatus != 3)
            {
                $("#ConatntMatter_divdrmmain").show();
                $("#anchorbtn_other").hide();
                $("#ConatntMatter_divdrmmain")[0].innerHTML = "Meeting Links has not been created as yet for this cycle";
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

                        $('#dvtblbody').css({
                            'height': $(window).height() - 380,
                            'overflow-y': 'auto',
                            'overflow-x': 'hidden'
                        });
                        $("#divBTNS").show();
                        $(".mergerow").closest('tr').find('td').css('border-top', '2px solid black');
                    }
                    var activeIndex = parseInt($("#tablist").find("a.active").closest("li").index()) + 1;
                    fnShowDataAssigned(activeIndex);
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

        function check_uncheck_checkbox(isChecked) {
            if (isChecked) {
                $('input[type=checkbox]').each(function () {
                    this.checked = true;
                });
            } else {
                $('input[type=checkbox]').each(function () {
                    this.checked = false;
                });
            }
        }



        function fnSave(flg) {

            var flgvalid = true;
            var IsCnt = 0;
            var flgStatus = 1;

            var CycleId = $("#ConatntMatter_ddlCycle").val();
            var CycleDate = $("#ConatntMatter_ddlCycle option:selected").attr("CycleDate");

            var ArrDataSaving = []; var ArrDataMails = [];
            var hdnFlagValue  = $("#ConatntMatter_hdnMailFlag").val(1);
         
            // if (flg == 1) {
            var cntOneTonOne = 0; var OldParticipantCycleMappingId = 0; var startTime = ""; var timeselected = 0;
            $("#ConatntMatter_divdrmmain").find("#tbldbrlist input[flg=1]:checked").each(function () {
                var Name = $(this).closest("tr").attr("FullName");
                var username = $(this).closest("tr").attr("username");
                var pwd = $(this).closest("tr").attr("pwd");
                var EmailId = $(this).closest("tr").attr("EmailID");
                var Subject =  $(this).closest("tr").attr("subjectline");
                var StartTime =  $(this).closest("tr").attr("StartTime");
                var EndTime = $(this).closest("tr").attr("EndTime");
                var Fname = $(this).closest("tr").attr("Fname");
                var EmpNodeID = $(this).closest("tr").attr("EmpNodeID");
                var SchedulerFlagValue = $("#ConatntMatter_hdnMailFlag").val();
                //alert(StartTime)
              //  alert(EndTime)
                //  ArrDataSaving.push({ EmpNodeID:EmpNodeID, Name: Name, EmailId: EmailId, Subject: Subject, StartTime: StartTime, EndTime: EndTime,Fname:Fname,FlagValue: hdnFlagValue, MailStatus: '' });
                ArrDataSaving.push({ EmpNodeID: EmpNodeID, Name: Name, EmailId: EmailId, Subject: Subject, StartTime: StartTime, EndTime: EndTime, Fname: Fname, MailStatus: '', SchedulerFlagValue: SchedulerFlagValue, username: username,pwd:pwd });
            });

         
            if (ArrDataSaving.length == 0) {
                alert("Kindly Select atleast one checkbox!")
                return false;
            }
           
            //$.extend(ArrDataSaving, ArrDataSavingGD);
            $("#dvFadeForProcessing").show();
            PageMethods.fnSave(ArrDataSaving, fnSave_Success, fnFailed, flgStatus);
        }
       
        function fnSave_Success(result, flgStatus) {
            $("#dvFadeForProcessing").hide();
            if (result.split("|")[0] == "0") {
                var tbl = $.parseJSON(result.split("|")[1]);
                var strHTML = "";
                if (tbl.length > 0) {

                    var style = "border-left: 1px solid #A0A0A0; border-bottom: 1px solid #A0A0A0;font-family:arial narrow;font-size:9pt;";
                    strHTML += "Kindly find below Mail status for each participant.</br>";
                    strHTML += ("<table cellpadding='2' cellspacing='0' style='font-family:arial narrow;font-size:8.5pt;border-right: 1px solid #A0A0A0; border-top: 1px solid #A0A0A0;text-align:center;width:100%'><thead>");
                    strHTML += ("<tr bgcolor='#26a6e7'>");
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Sr.No</th>";
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Participant Name</th>";
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>EmailId</th>";
                    strHTML += "<th  style='" + style + ";color:#fff;text-align:left;padding:3px'>Mail Status</th>";
                    strHTML += ("</tr></thead><tbody>");
                    //MeetingStartTime
                    var flgvalid = true;
                    var Oldparticipantcyclemappingid = 0;
                    var cnt = 1;
                    for (var i in tbl) {
                        var ParticipantAssessorMappingId = 0;// tbl[i]["ParticipantAssessorMappingId"];
                        var MailStatus = tbl[i]["MailStatus"];
                        var ParticipantName = tbl[i]["Name"];
                        var EmailId = tbl[i]["EmailId"];
                       
                        var strColor = "";
                                             
                        strHTML += ("<tr " + strColor + ">");
                        strHTML += "<td  style='" + style + ";text-align:center;padding:3px'>" + cnt + "</td>";
                        strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + ParticipantName + "</td>";
                        strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + EmailId + "</td>";
                        strHTML += "<td  style='" + style + ";text-align:left;padding:3px'>" + MailStatus + "</td>";
                        strHTML += ("</tr>");
                        cnt++;
                       
                       
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
                      
                    },
                    buttons: {
                        "OK": function () {
                            $(this).dialog('close');
                        }
                    }
                })

             //   $("#tbldbrlist  input[type=checkbox]:checked").closest("tr").attr("flgDisplayRow", "2");
                $("#tbldbrlist  input[type=checkbox]:checked").prop("checked", false);
                var i = parseInt($("#tablist").find("a.active").closest("li").index()) + 1
                $("#hdnChkFlag").val(0);
                fnShowDataAssigned(i);
                $("#loader").hide();
                 fnDSEList();

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



    <script type="text/javascript">
        var OldActive = 2;
        function fnShowDataAssigned(X) {
            var CycleID = $("#ConatntMatter_ddlCycle").val();

            if (CycleID == 0) {
                alert("Please select the Cycle Name");
                $("#ConatntMatter_ddlCycle").eq(0).focus();
                return false;
            }
            //    alert(CycleID)
           

            OldActive = X;
            if (X == 1)   ////// For New User mail
            {
                $("#tbldbrlist tbody tr").hide();
                $("#tbldbrlist  tbody tr[flgDisplayRow = 1]").css("display", "table-row")

                $("#ConatntMatter_hdnMailFlag").val(1);
            }
            else if (X == 2)  ///// For updated Scheduler Mail
            {
                $("#tbldbrlist tbody tr").hide();
                $("#tbldbrlist  tbody tr[flgDisplayRow = 3]").css("display", "table-row")
                $("#ConatntMatter_hdnMailFlag").val(2);
            }
            else {
                $("#tbldbrlist tbody tr").hide();    ////// For Resend
                $("#tbldbrlist  tbody tr[flgDisplayRow = 2]").css("display", "table-row")

                //$("#tbldbrlist  tbody tr").css("display", "table-row")
                $("#ConatntMatter_hdnMailFlag").val(1);
            }
            $("#tablist").find("a.active").removeClass("active");
            $("#tablist").find("a").eq(OldActive - 1).addClass("active");
            //PageMethods.fnDisplayParticpantAgCycle(CycleID, X, fnGetDisplaySuccessData, fnGetFailed, X);

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="section-title clearfix">
        <h3 class="text-center">Invitatation Mail To Participant </h3>
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
        <!-- Nav tabs -->
        <ul class="nav nav-tabs" role="tablist" id="tablist">
            <li><a class="nav-link active" onclick="fnShowDataAssigned(1)" style="cursor:pointer">New Users Scheduler Email</a></li>
            <li ><a  class="nav-link"  onclick="fnShowDataAssigned(2)" style="cursor:pointer">Updated Scheduler Mail</a></li>
            <li style="display:none"><a class="nav-link " onclick="fnShowDataAssigned(3)" style="cursor:pointer">Resend Scheduler Email</a></li>
        </ul>

             <div class="tab-content">
      
        <!-- Tab panes -->
             <div id="divdrmmain" runat="server" style="min-height:300px"></div>
    </div>
        </div>


    <div class="text-center" id="divBTNS" style="display: none;">
        <a href="###" class="btns btn-submit" onclick="return fnSave(1)" id="anchorbtn_other" style="display: none">Send Mail</a>
    </div>
   

    <div id="dvDialog" style="display: none"></div>
    <div id="dvAlert" style="display: none;"></div>
    <div id="dvFadeForProcessing" class="loader_bg">
        <div class="loader"></div>
    </div>
    <asp:HiddenField runat="server" ID="hdnLoginId" Value="0" />
    <asp:HiddenField runat="server" ID="hdnMenuId" Value="0" />
     <asp:HiddenField runat="server" ID="hdnMailFlag" Value="0" />
</asp:Content>

