<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="CompanyOverview.aspx.vb" Inherits="Data_Information_CompanyOverview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>

    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "MyTask.aspx";
        }

    </script>

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


    </script>

  
    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;

        $(document).ready(function () {


        });


        function f1() {

            //function FnUpdateTimer() {
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
    <time id="theTime" class="fst-color" style="display: none">Reading Time Left 00: 00: 00</time>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>

    <div id="dvEnglish">
        <div class="position-relative mb-2">
            <div class="section-title">
                <h3 class="text-center">Introduction and Overview</h3>
                <div class="title-line-center"></div>
            </div>
            <%--   <div class="gtc-logo">
                <img src="../../Images/GTC-logo.png" />
            </div>--%>
        </div>
        <p>As part of the Assessment Center at Maruti, you will be participating in a case simulation. The following pages provide you with a detailed Business Simulation Case Study set in a fictitious company, AutoNext Industries Limited. The case contains key information about AutoNext's organization, industry landscape, key competitors, and strategic challenges.</p>
        <p><strong>&nbsp;</strong></p>
        <p><strong>Overview</strong><br />
            AutoNext Industries Limited, founded in 1983, has emerged as one of the key players in India's passenger car markets. The company has maintained a leading position through its commitment to affordability, fuel efficiency, and reliability, especially in the compact and mid-sized vehicle segments. Its strong domestic manufacturing presence, coupled with a broad dealership network across urban and rural India, has been crucial in driving its growth. However, the rapidly evolving market, driven by advancements in electric vehicles (EVs), connected mobility, and smart, feature-rich cars, is putting pressure on AutoNext&rsquo;s ability to maintain its leadership. Emerging trends such as autonomous vehicle technology, Mobility-as-a-Service (MaaS) and impending BS-VII regulations further challenge the company's traditional model.</p>
        <p>In the backdrop of these challenges, the company faces growing competition from both traditional rivals and new entrants who have swiftly capitalized on emerging trends in the auto industry.</p>
        <div class="text-center mt-3 mb-3"><a href="#" onclick="fnMenu(2, this)" id="btnNext" class="btns btn-submit">Next</a></div>
    </div>
    <!-------------End English-------------------------->

  

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnRspId" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoginID" runat="server" Value="0" />
    <asp:HiddenField ID="hdnExerciseID" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

