<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="CaseProbing.aspx.vb" Inherits="L3DirectSales_Task2_CaseProbing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">

        <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>

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
            // $('.my-account').css({ 'min-height': $(window).height() - ($(".navbar").outerHeight() + 60) });
            ///* ------------------ for tabs-1 script ------------------ */
            $('.my-account > .tab-pane:first').show();
            ActiveIndex = "1";

            $('ul.sidebar-menu > li > a').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                //$('ul.sidebar-menu > li').removeClass('active');
                //$(this).parent().addClass('active');

                $('.my-account > .tab-pane').hide();
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>
    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">Your Role & Task</h3>
            <div class="title-line-center"></div>
        </div>
        <img src="../../Images/YourRole.jpg" class="img-thumb pull-right" />
        <p><strong>Your Role</strong></p>
        <p>You are the CHRO of Nexus and have been with the organization for 10+ years. Your strategic leadership and innovative initiatives have positioned you as a trusted advisor to the Board and a respected advocate for employees. Through your visionary leadership, you have transformed the HR function into a strategic partner that drives organizational success, fosters a culture of excellence, and enhances the employee experience. Your ability to gain the trust of both the Board and employees is a testament to your dedication to advancing the organization's mission, values, and long-term sustainability.</p>


        <div class="text-center mb-3" style="padding-top: 40px;">
            <asp:Button runat="server" ID="btnStartENG" Enabled="true" Text="Start Questions" CssClass="btns btn-submit" />
        </div>
    </div>

    <!------------ End English------------------>



    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
</asp:Content>

