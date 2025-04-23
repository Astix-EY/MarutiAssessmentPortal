<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="GtcStrategicPartners.aspx.vb" Inherits="Data_Information_GtcStrategicPartners" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "LeadershipPresence.aspx";
        }
        function fnExample() {
            window.location.href = "TaskExample.aspx?MenuId=8";
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


        function fnClose() {
            window.location.href = '<%=System.Configuration.ConfigurationManager.AppSettings("TestURL") %>'
        }

    </script>

    <script type="text/javascript">
        var SecondCounter = 0; var MinuteCounter = 0; var hours = 0; var IsUpdateTimer = 1; var flgChances = 1; var counter = 0; var counterAutoSaveTxt = 0;
        $(document).ready(function () {

       
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
    <time id="theTime" class="fst-color" style="display: none">Reading Time Left 00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>

    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">Competitive Landscape</h3>
            <div class="title-line-center"></div>
        </div>
        <p>AutoNext's recent venture into the hybrid and electric vehicle segments has lagged its competitors despite its strengths. As a result, its once-dominant position in the SUV category has come under threat from companies like Zenith Automobiles, which are offering technologically superior, feature-loaded models.</p>
<p>Also, Vega Motors is now a major contender in the electric vehicle segment. Vega Motors has captured over 60% of the EV market, with its substantial investments in battery technology and charging infrastructure. In FY2022-23, Vega reported revenue of INR 33,000 crore and an EBITDA margin of 12%, placing it well ahead of AutoNext in terms of financial health. The company has a workforce of 3,700 employees reflecting its focus on productivity, high-margin electric vehicles and efficient operations.</p>
<p>Zenith Automobiles, on the other hand, has successfully positioned itself in the premium SUV market, with a 37% share in this segment. Zenith&rsquo;s focus on luxury, connectivity features, and advanced driver assistance systems (ADAS) has driven strong consumer demand, particularly in urban markets. Zenith&rsquo;s revenue for FY2022-23 stood at INR 26,000 crore, with an EBITDA margin of 9%. The company&rsquo;s productivity metrics are even stronger with 2,500 employees.</p>
<p>Both Vega and Zenith have also been investing heavily in workforce training programs with nearly 40% of their employees skilled in emerging areas such as electric powertrains, autonomous driving, and data analytics. AutoNext, in contrast, has maintained more traditional training approaches with only 15% of its employees trained in EV technology or software development which could become a major obstacle in the future.</p>
<p>Vega and Zenith have also implemented leaner supply chains and digitalized operations to control costs more effectively.</p>
<p>AutoNext&rsquo;s competitors have also begun offering online sales channels. Nearly 20% of sales of Vega Motors in FY2022-23 came through its digital platform. AutoNext, meanwhile, has yet to fully digitize its sales and after-sales services.</p>
    </div>
    <!------------ End English------------------>

  

    <div class="text-center mb-3" style="display: none;">
        <asp:Button ID="btnSubmit" runat="server" CssClass="btns btn-submit" Text="Next" />
    </div>
    <div class="text-center mb-3" id="btnNext"><a href="#" onclick="fnMenu(5, this)" id="btnAnchorNext" class="btns btn-submit">Next</a></div>

    <%--  <div class="text-center mb-3" id="btnClose"><a href="#" onclick="fnClose()" id="btnAnchorclose" class="btns btn-submit">Close</a></div>--%>




    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

