<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Site.master" AutoEventWireup="false" CodeFile="CaseProbing_tab.aspx.vb" Inherits="L3DirectSales_Task2_CaseProbing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">

    <style type="text/css">
        .nav-tabs {
            padding-left: 0;
            margin-bottom: 0;
            background: #FFF;
            border-bottom: 2px solid #00249C;
        }

            .nav-tabs > li {
                margin-right: 4px;
                display: inline-block;
                margin-bottom: -2px;
                line-height: 1.42857143;
                    padding: 6px 10px 4px;
            }

                .nav-tabs > li.active, .nav-tabs > li.active:focus, .nav-tabs > li.active:hover {
                    color: #00249C;
                    Background: #fff;
                    border: 1px solid #00249C;
                    border-bottom: 1px solid #fff;
                    outline: none;
                }

                .nav-tabs > li:hover {
                    background: #f4f4f4;
                    color: #606366;
                    border: 1px solid #c8c8c8;
                    border-bottom: none;
                }

                .nav-tabs > li::after {
                    content: "";
                    background: #00249C;
                    height: 3px;
                    position: absolute;
                    width: 100%;
                    left: 0px;
                    top: -1px;
                    transition: all 250ms ease 0s;
                    transform: scale(0);
                }

                .nav-tabs > li.active::after,
                .nav-tabs > li:hover::after {
                    transform: scale(1);
                }

            .nav-tabs > li {
                position: relative;
                cursor: pointer;
                background: #E6ECFF;
                border: 1px solid #BCC1D2;
                color: #727FA8;
                font-weight: 500;
                font-size: 0.85rem;
            }

        .coll-box > .coll-body {
            padding: 10px;
              border: 1px solid #00249C;
              border-top: none;
            display: none;
        }
    </style>

    <script type="text/javascript">
        (function ($) {
            $.fn.blink = function (options) {
                var defaults = {
                    delay: 500
                };
                var options = $.extend(defaults, options);
                var obj = $(this);
                setInterval(function () {
                    $(obj).fadeOut().fadeIn();
                }, options.delay);
            }

        }(jQuery))

        $(function () {
            $('.coll-box > div:first').show();

            $('.nav-tabs > li').click(function () {

                $(this).addClass('active').siblings().removeClass('active');

                $('.coll-box > .coll-body').hide();

                $('.' + $(this).data('class')).fadeIn();

            });
        });



    </script>

    <script type="text/javascript">
        function fnChangeDataBasedOnLanguage(X) {
            var navbar = ($("nav.navbar").outerHeight());
            $('.main-box').css({
                "min-height": $(window).height() - (navbar + 22),
                'margin-top': navbar
            });
            $('.main-sidebar').css({
                "height": "100%" //$('.main-box').outerHeight()
            });

            var LngID = $("#hdnLngID").val();

            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }

            fnChangeDataOnPanelPage()

            if (LngID == "2") {

                $("#dvIndonesia").show();
                $("#dvEnglish").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();
            }
            else if (LngID == "3") {

                $("#dvSinhala").show();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
                $("#dvTamil").hide();
            }
            else if (LngID == "1") {
                $("#dvTamil").show();
                $("#dvSinhala").hide();
                $("#dvIndonesia").hide();
                $("#dvEnglish").hide();
            }

            else {
                $("#dvEnglish").show();
                $("#dvIndonesia").hide();
                $("#dvSinhala").hide();
                $("#dvTamil").hide();
            }

            if (X == 2) {
                $('#dvLanguage').dialog('close');
            }

            PageMethods.fnSetSession(LngID, fnUpdateSessionSuccess, fnUpdateSessionFailed);

        }

        function fnUpdateSessionSuccess(result) {

        }
        function fnUpdateSessionFailed(result) {
            //    alert(result._message);
        }

        function fnCaseProbing(flg) {
            var ids = "";
            if (flg == 1) {
                var LngID = $("#hdnLngID").val();
                titles = "ICT Deployment Models"
                if (LngID == "2") {
                    ids = "DeploymentModels_INDO";
                }
                else if (LngID == "3") {

                    ids = "DeploymentModels_SIN";
                }
                else if (LngID == "1") {
                    ids = "DeploymentModels_TAMIL";
                }
                else {
                    ids = "DeploymentModels_ENG";
                }

                $("#" + ids).dialog({
                    title: titles,
                    width: "75%",
                    height: "480",
                    modal: true,
                    draggable: false,
                    resizable: false,
                });
            }
            else if (flg == 2) {
                var LngID = $("#hdnLngID").val();
                titles = "Cost Benefit Analysis"
                if (LngID == "2") {
                    ids = "BenefitAnalysis_INDO";
                }
                else if (LngID == "3") {

                    ids = "BenefitAnalysis_SIN";
                }
                else if (LngID == "1") {
                    ids = "BenefitAnalysis_TAMIL";
                }
                else {
                    ids = "BenefitAnalysis_ENG";
                }
                $("#" + ids).dialog({
                    title: titles,
                    width: "75%",
                    height: "480",
                    modal: true,
                    draggable: false,
                    resizable: false,
                });

            }
            else if (flg == 3) {
                var LngID = $("#hdnLngID").val();
                titles = "Parent & Student Feedback"
                if (LngID == "2") {
                    ids = "ParentStudentFeedback_INDO";
                }
                else if (LngID == "3") {

                    ids = "ParentStudentFeedback_SIN";
                }
                else if (LngID == "1") {
                    ids = "ParentStudentFeedback_TAMIL";
                }
                else {
                    ids = "ParentStudentFeedback_ENG";
                }
                $("#" + ids).dialog({
                    title: titles,
                    width: "75%",
                    height: "480",
                    modal: true,
                    draggable: false,
                    resizable: false,
                });
            }

        }
    </script>
    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        $(document).ready(function () {

            //if ($("#hdnFlagPageToOpen").val() == "3") {
            //    f1();
            //}
            //else {
            //    $("#theTime").hide();
            //}
            fnChangeDataBasedOnLanguage(1);
        });

        function f1() {

            if (IsUpdateTimer == 0) { return; }
            SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
            if (SecondCounter <= 0) {
                IsUpdateTimer = 0;

                //$("#theTime").addClass("blinkmsg");

                //$('.blinkmsg').blink({
                //    delay: "1500"
                //});


                return;
            }
            SecondCounter = SecondCounter - 1;
            hours = Math.floor(SecondCounter / 3600);
            Minutes = Math.floor((SecondCounter - (hours * 3600)) / 60);
            Seconds = SecondCounter - (hours * 3600) - (Minutes * 60);


            if (Seconds < 10 && Minutes < 10) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds;
            }
            else if (Seconds < 10 && Minutes > 9) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + Minutes + ":" + "0" + Seconds;
            }
            else if (Seconds > 9 && Minutes < 10) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + Seconds;
            }
            else if (Seconds > 9 && Minutes > 9) {
                document.getElementById("theTime").innerHTML = "Reading Time Left : 0" + hours + ":" + Minutes + ":" + Seconds;
            }
            document.getElementById("ConatntMatterRight_hdnCounter").value = SecondCounter;

            if (((hours * 60) + Minutes) == 5 && Seconds == 0) {

                $("#dvDialog")[0].innerHTML = "<center>Reading Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " </center>";
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

                //   document.getElementById("dvDialog").innerHTML = "<center>Your Time Left : 0" + hours + ":" + "0" + Minutes + ":" + "0" + Seconds + " After that your window will be closed automatically.</center>";
            }

            counter++;
            counterAutoSaveTxt++;
            if (counter == 10) {//Auto Time Update
                counter = 0;

            }
            if (counterAutoSaveTxt == 30) {//Auto Text Save
                counterAutoSaveTxt = 0;

            }

            if (SecondCounter == 0) {
                // alert("Level Complete");
                IsUpdateTimer = 0;
                counter = 0;


                $("#theTime").addClass("blinkmsg");

                $('.blinkmsg').blink({
                    delay: "1500"
                });
                alert("Your scheduled time for reading the background information is over. You will now be redirected to your tasks page. Please start Task 1.");
                if ($("#hdnAssmntType").val() == "1") {
                    window.location.href = "../Exercise/ExerciseMain_L4.aspx?MenuId=8";
                }
                else {
                    window.location.href = "../Exercise/ExerciseMain_L3.aspx?MenuId=8";
                }
                return;
            }
            // }
            setTimeout("f1()", 1000);

        }
    </script>

</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>--%>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <!------------ English------------------>
    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">Case Probing</h3>
            <div class="title-line-center"></div>
        </div>

        <div>
            <ul class="nav-tabs">
                <li class="active" data-class="1">1 About the Company </li>
                <li data-class="2">2 Vision, Mission & Growth Plans</li>
                <li data-class="3">3 Financial Highlights</li>
                <li data-class="4">4 Employee Details & Work Culture</li>
                <li data-class="5">5 Technological Disruptions in Sector</li>
                <li data-class="6">6 Government Initiatives</li>
                <li data-class="7">7 Your Role & Task</li>
            </ul>
            <div class='coll-box'>
                <div class='1 coll-body'>1</div>
                <div class='2 coll-body'>2</div>
                <div class='3 coll-body'>3</div>
                <div class='4 coll-body'>4</div>
                <div class='5 coll-body'>5</div>
                <div class='6 coll-body'>6</div>
                <div class='7 coll-body'>7</div>
            </div>

        </div>


        <div class="text-center mb-3">
            <asp:Button runat="server" ID="btnStartENG" Enabled="true" Text="Start Questions" CssClass="btns btn-submit" />
        </div>

    </div>
    <!------------ End English------------------>



    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
</asp:Content>

