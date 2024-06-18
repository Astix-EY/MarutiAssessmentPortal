<%@ Page Title="" Language="VB" MasterPageFile="~/Data/MasterPage/IIPanel.master" AutoEventWireup="false" CodeFile="frmKnowledgeQuestions.aspx.vb" Inherits="frmKnowledgeQuestions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" type="text/css">
    <script src="../../../Scripts/jquery-ui.js" type="text/javascript"></script>
    <style type="text/css">
        .sliderwidth {
            width: 100% !important;
            margin-top: 4px;
            margin-bottom: 4px;
        }

        .sliderwidth {
            border-radius: 10px;
            -moz-border-radius: 10px;
            -webkit-border-radius: 10px;
            border: 1px solid #d5d5d5;
            height: 10px;
            position: relative;
            background: #B6B6B6;
            background-repeat: no-repeat;
            background-size: 100% 100%;
        }

        .ajax_slider_h_rail_0 {
            background-size: 100% 100%;
        }

        .ajax_slider_h_rail_1 {
            background-image: url('../../Images/point_1.png');
        }

        .ajax_slider_h_rail_2 {
            background-image: url('../../Images/point_2.png');
        }

        .ajax_slider_h_rail_3 {
            background-image: url('../../Images/point_3.png');
        }

        .ajax_slider_h_rail_4 {
            background-image: url('../../Images/point_4.png');
        }

        .ajax_slider_h_handle {
            height: 20px;
            position: absolute !important;
            top: -8px !important;
            width: 20px;
            cursor: move;
            overflow: visible !important;
        }
    </style>
   
    <script type="text/javascript">
        history.forward(+1);

        $(document).ready(function () {
            BindImageEvent();
        });
    </script>



    <script type="text/javascript">

        function BindImageEvent() {
            var StrSLiderID = "";
            $("input[id^='ConatntMatterRight_slider']").bind("change", function () {

                //alert("HI");

                var Value = $(this).val();

                var RailElementID = $(this).closest("td").find("div[id^='slider']")[0].id
               // alert(RailElementID)

                var RailElementRspDetID = RailElementID.split("_")[0]
                var RspDetIDForTr = RailElementRspDetID.split("~")[1]
                var SliderImageID = RailElementRspDetID + "_handleImage"
             //   alert("RailElementRspDetID=" + RailElementRspDetID)
             //   alert("SliderImageID=" + SliderImageID)

                // var TRID = $(this).closest('div').find("tr[rspdetid=" + RspDetIDForTr + "]")[0].id
                var TRID = $(this).closest('div').find("tr").attr("RspDetID");
             //    alert(TRID)
                if (Value == 0) {
                    // document.getElementById(TRID).style.backgroundColor = "yellow";
                }
               
                else {
                    document.getElementById("ConatntMatterRight_Tr" + TRID).style.backgroundColor = "white";
                }

                if (Value == "0") {
                    $(this).closest("td").find("div[id^='slider']").removeClass().addClass("ajax_slider_h_rail_0 sliderwidth")
                    document.getElementById(SliderImageID).title = "";
                }
                else if (Value == "1") {

                    $(this).closest("td").find("div[id^='slider']").removeClass().addClass("ajax_slider_h_rail_1 sliderwidth")
                    document.getElementById(SliderImageID).title = "Basic Knowledge";
                  
                }
                else if (Value == "2") {

                    $(this).closest("td").find("div[id^='slider']").removeClass().addClass("ajax_slider_h_rail_2 sliderwidth")
                    document.getElementById(SliderImageID).title = "Working Knowledge";

                }
                else if (Value == "3") {
                    //alert(Value)
                    $(this).closest("td").find("div[id^='slider']").removeClass().addClass("ajax_slider_h_rail_3 sliderwidth")
                    document.getElementById(SliderImageID).title = "Extensive Experience";

                }
                else if (Value == "4") {

                    $(this).closest("td").find("div[id^='slider']").removeClass().addClass("ajax_slider_h_rail_4 sliderwidth")
                    document.getElementById(SliderImageID).title = "Expert";

                }


            });


            // document.getElementById("CphContent_hdnSliderID").value = StrSLiderID

        }


    </script>

    <script type="text/javascript">
        function fnMakeString() {
            var RowCntr = document.getElementById("ConatntMatterRight_hdnNoOfQuestions").value;
            var TRRspDetID = "";
            var SliderValue = 0;
            var MainString = ""
            for (var i = 1; i <= RowCntr; i++) {
                SliderValue = document.getElementById("ConatntMatterRight_slider" + i).value;
                TRRspDetID = $("#ConatntMatterRight_Tr" + i).attr("RspDetID");
                MainString += TRRspDetID + "^" + SliderValue + "|";

            }
            return MainString;
        }
        function fnNext() {
            if (parseInt(fnValidate(), 10) == 1) {
                alert("You have left atleast one question unanswered . Please note that it is compulsory to respond to every question!");
                return false;
            }

            var ReturnString = fnMakeString()
            document.getElementById("ConatntMatterRight_hdnResult").value = ReturnString;

            document.getElementById("ConatntMatterRight_btnNext").value = "Submit"


            document.getElementById("ConatntMatterRight_btnSaveASP").click();

        }

        function fnPrevious() {
            var ReturnString = fnMakeString()
            document.getElementById("ConatntMatterRight_hdnResult").value = ReturnString;
            document.getElementById("ConatntMatterRight_hdnDirection").value = 1;
            document.getElementById("ConatntMatterRight_hdnSaveType").value = 1;
            document.getElementById("ConatntMatterRight_hdnStatusValue").value = 1;
            document.getElementById("ConatntMatterRight_btnSaveASP").click();


        }
        function fnSaveExit() {
            // debugger;
            if (window.confirm("Do you really want to Exit ")) {

                var ReturnString = fnMakeString()
                document.getElementById("ConatntMatterRight_hdnResult").value = ReturnString;
                document.getElementById("ConatntMatterRight_hdnSaveType").value = 0;
                document.getElementById("ConatntMatterRight_hdnDirection").value = 0;
                document.getElementById("ConatntMatterRight_hdnStatusValue").value = 1;
                document.getElementById("ConatntMatterRight_btnSaveASP").click();
            }
            else {
                return false;
            }
        }
		
		
        function fnSubmit()
        {
            window.location.href = "../Common/frmThanks.aspx"
        }
		
        function fnValidate() {
            var RowCntr = document.getElementById("ConatntMatterRight_hdnNoOfQuestions").value;
            var SliderValue = 0;
            var FlagValidate = 0;
            var TRRspDetID = ""
            for (var i = 1; i <= RowCntr; i++) {
                SliderValue = document.getElementById("ConatntMatterRight_slider" + i).value;
                // TRRspDetID = $("#CphContent_Tr" + i).attr("RspDetID");
                if (SliderValue == 0) {
                    FlagValidate = 1;
                    document.getElementById("ConatntMatterRight_Tr" + i).style.backgroundColor = "#b1c7ed";

                }

            }
            return FlagValidate;
        }
    </script>
    <script type="text/javascript">
        history.forward(+1);

        $(document).ready(function () {
            BindImageEvent();

            $('.main-box-wrapper').css('margin-bottom', '0');
            var winh = $(window).height(), rth = $('.rating-title').height(), pbh = $('.progress-section').height(), cdrh = $('.change-del-rating').height();
            $('.ques-panel').css({
                height: winh - (rth + pbh + cdrh + 160) + 'px',
                'overflow-y': 'auto',
                'margin': '0 auto'
            });
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPageTitle" runat="Server">
    <h3 class="pagetitle">Evaluation</h3>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <div class="section-content">
        <div class="rating-title mb-3">
            <img src="../../Images/rating-person.jpg" />
            <div class="inner-text">
                <h3>Perform Self Ratings</h3>
            </div>
            <p>In this step you will be create your skill profile and self rate yourself on those skills</p>
        </div>
        <div class="row mb-3 progress-section">
            <div class="col-md-8 offset-2">
                <ul class="status-progress">
                    <li class="done">Assessment Evaluations</li>
                    <li class="active">Perform Self Ratings</li>
                    <li>Perform Manager Ratings</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="section-content feedback-panel">
        <div class="row mb-3 change-del-rating">
            <div class="col-md-4 offset-md-2 bg-white p-0">
                <table class="table-status">
                    <tr>
                        <td class="info-icon" style="width: 40px;">
                            <i class="fa fa-info"></i>
                        </td>
                        <td style="width: 55%;">
                            <div class="range-container">
                            </div>
                        </td>
                        <td class="border-r">Change rating by moving the slider</td>
                    </tr>
                </table>
            </div>
            <div class="col-md-4 bg-white">
                <table class="table-status">
                    <tr>
                        <td style="width: 50px">
                            <div class="delete-icon red">
                                <i class="fa fa-trash-o"></i>
                            </div>
                        </td>
                        <td>Delete a skill<br />
                            (** Skills Required for the role can't be deleted)
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8 ques-panel p-0" id="divMainContainer" runat="server">
            </div>
        </div>
    </div>
    <div class="d-block">
        <%-- <div class="row border-bottom border-primary mb-2 bg-light">
            <div class="col-md-4 dvPgNmbr" id="dvPgNmbr" runat="server"></div>
            <div class="col-md-8" id="dvRating" runat="server"></div>
        </div>

        <div id="dvSurvey" runat="server"></div>--%>
        <div id="dvDialog" style="display: none"></div>
        <div class="text-center mt-3">

            <input type="button" class="btns btn-submit" id="btnNext" style="" onclick="fnSubmit()" value="Submit" runat="server" />
        </div>
    </div>


    <div style="display: none;">
        <asp:Button ID="btnSaveASP" Style="visibility: hidden" runat="server" Text="Save"></asp:Button>
        <input id="hdnNoOfQuestions" type="text" size="2" name="hdnNoOfQuestions" runat="server" />
        <input id="hdnPageNmbr" type="text" size="2" name="hdnPageNmbr" runat="server" />
        <input id="hdnflgTimeOver" type="text" size="2" name="hdnPageNmbr" runat="server" value="0" />
        <input id="hdnDirection" type="text" size="2" name="hdnDirection" runat="server" />
        <input id="hdnResult" type="text" name="hdnResult" runat="server" />
        <input id="hdnSaveType" type="text" size="2" name="hdnSaveType" runat="server" />
        <input id="hdnQsntnIdForIdPurpose" type="text" size="2" name="hdnQsntnIdForIdPurpose" runat="server" />
        <input id="hdnPreviousSelected" type="text" size="5" name="hdnPreviousSelected" runat="server" />
        <input id="hdnColorCounter" type="text" size="4" name="hdnColorCounter" runat="server" />
        <input id="hdnSliderID" type="text" />
    </div>



    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />





</asp:Content>

