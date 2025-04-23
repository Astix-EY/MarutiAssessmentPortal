<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Panel.master" AutoEventWireup="false" CodeFile="GtcPresence.aspx.vb" Inherits="Data_Information_GtcPresence" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "MarketOverview.aspx";
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
    <time id="theTime" class="fst-color" style="display: none">Reading Time Left  00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English--------------->
    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">Company Overview</h3>
            <div class="title-line-center"></div>
        </div>
<p>AutoNext Industries was founded with the vision of making car ownership affordable for the average Indian family. By 2022, AutoNext had a market share of 42%, making it the largest player in the Indian passenger vehicle segment. AutoNext's success has largely been rooted in its dominance in the compact and mid-sized vehicle segments, where its products have consistently outperformed rivals in terms of affordability and fuel efficiency.</p>
<p>The company&rsquo;s production facilities in Gujarat, Haryana, and Tamil Nadu are capable of manufacturing over 2.4 million units annually, and its extensive dealership network (over 3,000 touchpoints) has ensured it remains a household name in India.</p>
<p>AutoNext's total revenue for FY2022-23 was INR 1,00,000 crore, with an EBITDA margin of 8.5%, down from 9.5% the previous year. AutoNext&rsquo;s profit after tax for FY2022-23 was INR 5,100 crore, but rising material costs (steel, semiconductors) and significant R&amp;D spending on EV development reduced its profitability.</p>
<p>AutoNext&rsquo;s workforce of 12,000 employees has been key to its operational success. Moreover, while AutoNext's output per employee (183 vehicles/year) is higher than industry averages, the company has yet to fully integrate automation and digital tools to enhance production efficiency, leaving room for significant improvement.</p>
<p>But lately, AutoNext has been facing several challenges related to talent attraction, retention and motivation. Attrition has increased to multi-folds (~2X) in verticals such as Engineering (8%), Supply Chain (14%), Sales (22%), Services (15%) leading to potential risk of capacity and capability loss impacting speed to delivery. AutoNext is also unable to hire external talent because of fitment related challenges resulting in long lead time for replacement hiring. Limited career visibility and lack of flexible work policies as followed in the industry is further leading to poor employee experience and motivation.</p>
    </div>
    <div class="text-center mb-3"><a href="#" onclick="fnMenu(4, this)" class="btns btn-submit">Next</a></div>

    <!------------ End English--------------->

  

    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <asp:HiddenField ID="hdnToolID" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

