<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Panel.master" AutoEventWireup="false" CodeFile="Channelpartership.aspx.vb" Inherits="Data_Information_Channelpartership" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <script type="text/javascript">
        function fnGoBack() {
            window.location.href = "LeadershipPresence.aspx";
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

            if ($("#hdnFlagPageToOpen").val() == "3") {
                f1();
                $("#btnClose").remove();
            }
            else {
                $("#theTime").hide();
                $("#btnClose").remove();
            }
 
        });
        function f1() {

            if (IsUpdateTimer == 0) { return; }
            SecondCounter = parseInt(document.getElementById("ConatntMatterRight_hdnCounter").value);
            if (SecondCounter <= 0) {
                IsUpdateTimer = 0;

                $("#theTime").addClass("blinkmsg");

                $('.blinkmsg').blink({
                    delay: "1500"
                });

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
    <time id="theTime" class="fst-color">Reading Time Left 00: 00: 00</time>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatterRight" runat="Server">
    <!------------ English------------------>

    <div id="dvEnglish">
        <div class="section-title">
            <h3 class="text-center">Annexures</h3>
            <div class="title-line-center"></div>
        </div>
        <table class="table table-bordered table-sm">
            <thead>
                <tr>
                    <th width="220">
                        <p><strong>Organization</strong></p>
                    </th>
                    <th width="92">
                        <p><strong>AutoNext</strong></p>
                    </th>
                    <th width="95">
                        <p><strong>Vega Motors</strong></p>
                    </th>
                    <th width="94">
                        <p><strong>Zenith Automobiles</strong></p>
                    </th>
                    <th width="91">
                        <p><strong>Other Companies</strong></p>
                    </th>
                </tr>
            </thead>


            <tbody>

                <tr>
                    <td width="220">
                        <p>Sales Turnover (INR Crore)</p>
                    </td>
                    <td width="92">
                        <p>1,00,000</p>
                    </td>
                    <td width="95">
                        <p>33,000</p>
                    </td>
                    <td width="94">
                        <p>26,000</p>
                    </td>
                    <td width="91">
                        <p>-</p>
                    </td>
                </tr>
                <tr>
                    <td width="220">
                        <p>Net Profit (INR Crore)</p>
                    </td>
                    <td width="92">
                        <p>5,100</p>
                    </td>
                    <td width="95">
                        <p>3,100</p>
                    </td>
                    <td width="94">
                        <p>1,900</p>
                    </td>
                    <td width="91">
                        <p>-</p>
                    </td>
                </tr>
                <tr>
                    <td width="220">
                        <p>Sales Volume FY 22 (Million)</p>
                    </td>
                    <td width="92">
                        <p>1.65</p>
                    </td>
                    <td width="95">
                        <p>0.51</p>
                    </td>
                    <td width="94">
                        <p>0.38</p>
                    </td>
                    <td width="91">
                        <p>-</p>
                    </td>
                </tr>
                <tr>
                    <td width="220">
                        <p>Sales Volume FY 23 (Million)</p>
                    </td>
                    <td width="92">
                        <p>2.2</p>
                    </td>
                    <td width="95">
                        <p>0.60</p>
                    </td>
                    <td width="94">
                        <p>0.45</p>
                    </td>
                    <td width="91">
                        <p>-</p>
                    </td>
                </tr>
                <tr>
                    <td width="220">
                        <p>SUV Market Share</p>
                    </td>
                    <td width="92">
                        <p>23%</p>
                    </td>
                    <td width="95">
                        <p>12%</p>
                    </td>
                    <td width="94">
                        <p>37%</p>
                    </td>
                    <td width="91">
                        <p>28%</p>
                    </td>
                </tr>
                <tr>
                    <td width="220">
                        <p>EV Market Share</p>
                    </td>
                    <td width="92">
                        <p>10%</p>
                    </td>
                    <td width="95">
                        <p>60%</p>
                    </td>
                    <td width="94">
                        <p>8%</p>
                    </td>
                    <td width="91">
                        <p>22%</p>
                    </td>
                </tr>
                <tr>
                    <td width="220">
                        <p>Network Size</p>
                    </td>
                    <td width="92">
                        <p>3,000</p>
                    </td>
                    <td width="95">
                        <p>982</p>
                    </td>
                    <td width="94">
                        <p>827</p>
                    </td>
                    <td width="91">
                        <p>3,500</p>
                    </td>
                </tr>
                <tr>
                    <td width="220">
                        <p>Network Strength</p>
                    </td>
                    <td width="92">
                        <p>Rural, Semi-urban</p>
                    </td>
                    <td width="95">
                        <p>Urban, Semi-urban</p>
                    </td>
                    <td width="94">
                        <p>Urban</p>
                    </td>
                    <td width="91">
                        <p>Urban, Rural</p>
                    </td>
                </tr>
                <tr>
                    <td width="220">
                        <p>Number of employees</p>
                    </td>
                    <td width="92">
                        <p>12,000</p>
                    </td>
                    <td width="95">
                        <p>3,700</p>
                    </td>
                    <td width="94">
                        <p>2,500</p>
                    </td>
                    <td width="91">
                        <p>-</p>
                    </td>
                </tr>
            </tbody>
        </table>
        <p><strong>&nbsp;</strong></p>
        <p><strong>Volume and Growth Trends for AutoNext (Passenger Vehicles and SUVs)</strong></p>
        <table class="table table-bordered table-sm">
            <thead>
                <tr>
                    <th width="173">
                        <p><strong>Units</strong></p>
                    </th>
                    <th width="105">
                        <p><strong>FY 20</strong></p>
                    </th>
                    <th width="105">
                        <p><strong>FY 21</strong></p>
                    </th>
                    <th width="105">
                        <p><strong>FY 22</strong></p>
                    </th>
                    <th width="105">
                        <p><strong>FY 23</strong></p>
                    </th>
                </tr>
            </thead>
            <tbody>

                <tr>
                    <td width="173">
                        <p>Passenger Vehicles</p>
                    </td>
                    <td width="105">
                        <p>15,00,000</p>
                    </td>
                    <td width="105">
                        <p>17,20,000</p>
                    </td>
                    <td width="105">
                        <p>16,50,000</p>
                    </td>
                    <td width="105">
                        <p>22,00,000</p>
                    </td>
                </tr>
                <tr>
                    <td width="173">
                        <p>&middot;&nbsp; Compact Cars</p>
                    </td>
                    <td width="105">
                        <p>6,50,000</p>
                    </td>
                    <td width="105">
                        <p>7,50,000</p>
                    </td>
                    <td width="105">
                        <p>6,80,000</p>
                    </td>
                    <td width="105">
                        <p>9,00,000</p>
                    </td>
                </tr>
                <tr>
                    <td width="173">
                        <p>&middot;&nbsp; Mid-Sized Cars</p>
                    </td>
                    <td width="105">
                        <p>4,00,000</p>
                    </td>
                    <td width="105">
                        <p>4,70,000</p>
                    </td>
                    <td width="105">
                        <p>3,50,000</p>
                    </td>
                    <td width="105">
                        <p>5,50,000</p>
                    </td>
                </tr>
                <tr>
                    <td width="173">
                        <p>&middot;&nbsp; SUVs</p>
                    </td>
                    <td width="105">
                        <p>4,50,000</p>
                    </td>
                    <td width="105">
                        <p>5,00,000</p>
                    </td>
                    <td width="105">
                        <p>6,20,000</p>
                    </td>
                    <td width="105">
                        <p>7,50,000</p>
                    </td>
                </tr>
                <tr>
                    <td width="173">
                        <p>EVs</p>
                    </td>
                    <td width="105">
                        <p>-</p>
                    </td>
                    <td width="105">
                        <p>-</p>
                    </td>
                    <td width="105">
                        <p>40,000</p>
                    </td>
                    <td width="105">
                        <p>75,000</p>
                    </td>
                </tr>
            </tbody>
        </table>
        <p>&nbsp;</p>
        <p><strong>Autonext Year-over-Year Growth (% YoY)</strong></p>
        <table class="table table-bordered table-sm">
            <thead>
                <tr>
                    <th width="191">
                        <p><strong>YoY (%)</strong></p>
                    </th>
                    <th width="100">
                        <p><strong>FY 20</strong></p>
                    </th>
                    <th width="100">
                        <p><strong>FY 21</strong></p>
                    </th>
                    <th width="100">
                        <p><strong>FY 22</strong></p>
                    </th>
                    <th width="100">
                        <p><strong>FY 23</strong></p>
                    </th>
                </tr>
            </thead>
            <tbody>

                <tr>
                    <td width="191">
                        <p>SUVs</p>
                    </td>
                    <td width="100">
                        <p>15%</p>
                    </td>
                    <td width="100">
                        <p>11%</p>
                    </td>
                    <td width="100">
                        <p>24%</p>
                    </td>
                    <td width="100">
                        <p>21%</p>
                    </td>
                </tr>
                <tr>
                    <td width="191">
                        <p>EVs</p>
                    </td>
                    <td width="100">
                        <p>-</p>
                    </td>
                    <td width="100">
                        <p>-</p>
                    </td>
                    <td width="100">
                        <p>-</p>
                    </td>
                    <td width="100">
                        <p>88%</p>
                    </td>
                </tr>
            </tbody>
        </table>
        <p>&nbsp;</p>
        <p><strong>Category Contribution (% to Overall Sales)</strong></p>
        <table class="table table-bordered table-sm">
            <thead>
                <tr>
                    <th width="191">
                        <p><strong>Contribution (%)</strong></p>
                    </th>
                    <th width="100">
                        <p><strong>FY 20</strong></p>
                    </th>
                    <th width="100">
                        <p><strong>FY 21</strong></p>
                    </th>
                    <th width="100">
                        <p><strong>FY 22</strong></p>
                    </th>
                    <th width="100">
                        <p><strong>FY 23</strong></p>
                    </th>
                </tr>
            </thead>
            <tbody>

                <tr>
                    <td width="191">
                        <p>Passenger Vehicles</p>
                    </td>
                    <td width="100">
                        <p>40%</p>
                    </td>
                    <td width="100">
                        <p>41%</p>
                    </td>
                    <td width="100">
                        <p>39%</p>
                    </td>
                    <td width="100">
                        <p>36%</p>
                    </td>
                </tr>
                <tr>
                    <td width="191">
                        <p>Compact Cars</p>
                    </td>
                    <td width="100">
                        <p>43%</p>
                    </td>
                    <td width="100">
                        <p>44%</p>
                    </td>
                    <td width="100">
                        <p>42%</p>
                    </td>
                    <td width="100">
                        <p>41%</p>
                    </td>
                </tr>
                <tr>
                    <td width="191">
                        <p>Mid-Sized Cars</p>
                    </td>
                    <td width="100">
                        <p>27%</p>
                    </td>
                    <td width="100">
                        <p>28%</p>
                    </td>
                    <td width="100">
                        <p>26%</p>
                    </td>
                    <td width="100">
                        <p>25%</p>
                    </td>
                </tr>
                <tr>
                    <td width="191">
                        <p>SUVs</p>
                    </td>
                    <td width="100">
                        <p>30%</p>
                    </td>
                    <td width="100">
                        <p>28%</p>
                    </td>
                    <td width="100">
                        <p>32%</p>
                    </td>
                    <td width="100">
                        <p>34%</p>
                    </td>
                </tr>
                <tr>
                    <td width="191">
                        <p>EVs</p>
                    </td>
                    <td width="100">
                        <p>-</p>
                    </td>
                    <td width="100">
                        <p>-</p>
                    </td>
                    <td width="100">
                        <p>-</p>
                    </td>
                    <td width="100">
                        <p>4%</p>
                    </td>
                </tr>
            </tbody>
        </table>

        <p><strong>Working Capital Cycle</strong></p>
        <table class="table table-bordered table-sm">
            <thead>
                <tr>
                    <th width="132">
                        <p><strong>Company</strong></p>
                    </th>
                    <th width="142">
                        <p><strong>Average Inventory Held (days)</strong></p>
                    </th>
                    <th width="170">
                        <p><strong>Receivables Period From Dealerships (days)</strong></p>
                    </th>
                    <th width="142">
                        <p><strong>Payables Period To Suppliers (days)</strong></p>
                    </th>
                </tr>
            </thead>
            <tbody>

                <tr>
                    <td width="132">
                        <p>AutoNext</p>
                    </td>
                    <td width="142">
                        <p>30</p>
                    </td>
                    <td width="170">
                        <p>35</p>
                    </td>
                    <td width="142">
                        <p>33</p>
                    </td>
                </tr>
                <tr>
                    <td width="132">
                        <p>Vega Motors</p>
                    </td>
                    <td width="142">
                        <p>25</p>
                    </td>
                    <td width="170">
                        <p>25</p>
                    </td>
                    <td width="142">
                        <p>30</p>
                    </td>
                </tr>
                <tr>
                    <td width="132">
                        <p>Zenith Automobiles</p>
                    </td>
                    <td width="142">
                        <p>30</p>
                    </td>
                    <td width="170">
                        <p>20</p>
                    </td>
                    <td width="142">
                        <p>30</p>
                    </td>
                </tr>
            </tbody>
        </table>
        <p>&nbsp;</p>
        <p><strong>Autonext Profit and Loss Statement</strong></p>
        <table class="table table-bordered table-sm">
            <thead>
                <tr>
                    <th width="164">
                        <p><strong>Particulars</strong></p>
                    </th>
                    <th width="164">
                        <p><strong>FY 2022-2023 (crores INR)</strong></p>
                    </th>
                    <th width="164">
                        <p><strong>FY 2021-2022 (crores INR)</strong></p>
                    </th>
                </tr>
            </thead>
            <tbody>

                <tr>
                    <td width="164">
                        <p>Revenue from operations</p>
                    </td>
                    <td width="164">
                        <p>1,00,000</p>
                    </td>
                    <td width="164">
                        <p>75,128</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>Other income</p>
                    </td>
                    <td width="164">
                        <p>1,971</p>
                    </td>
                    <td width="164">
                        <p>1,622</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>Total Income</p>
                    </td>
                    <td width="164">
                        <p>1,01,971</p>
                    </td>
                    <td width="164">
                        <p>76,750</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>Expenses:</p>
                    </td>
                    <td width="164">
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;</p>
                    </td>
                    <td width="164">
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Cost of materials consumed</p>
                    </td>
                    <td width="164">
                        <p>42,995</p>
                    </td>
                    <td width="164">
                        <p>30,108</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Purchases of stock-in-trade</p>
                    </td>
                    <td width="164">
                        <p>27,967</p>
                    </td>
                    <td width="164">
                        <p>23,902</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Changes in inventories</p>
                    </td>
                    <td width="164">
                        <p>-344</p>
                    </td>
                    <td width="164">
                        <p>-259</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Employee benefits expenses</p>
                    </td>
                    <td width="164">
                        <p>5,642</p>
                    </td>
                    <td width="164">
                        <p>3,947</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Finance costs</p>
                    </td>
                    <td width="164">
                        <p>159</p>
                    </td>
                    <td width="164">
                        <p>120</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Depreciation and amortisation expense</p>
                    </td>
                    <td width="164">
                        <p>2,203</p>
                    </td>
                    <td width="164">
                        <p>1,809</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Other expenses</p>
                    </td>
                    <td width="164">
                        <p>17,143</p>
                    </td>
                    <td width="164">
                        <p>11,803</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Vehicles / dies for own use</p>
                    </td>
                    <td width="164">
                        <p>-74</p>
                    </td>
                    <td width="164">
                        <p>-56</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>Total expenses</p>
                    </td>
                    <td width="164">
                        <p>95,691</p>
                    </td>
                    <td width="164">
                        <p>71,374</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>Profit before tax</p>
                    </td>
                    <td width="164">
                        <p>6,280</p>
                    </td>
                    <td width="164">
                        <p>5,376</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>Tax expense:</p>
                    </td>
                    <td width="164">
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;</p>
                    </td>
                    <td width="164">
                        <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -&nbsp;&nbsp;</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>- Current tax</p>
                    </td>
                    <td width="164">
                        <p>1,180</p>
                    </td>
                    <td width="164">
                        <p>990</p>
                    </td>
                </tr>
                <tr>
                    <td width="164">
                        <p>Profit for the year</p>
                    </td>
                    <td width="164">
                        <p>5,100</p>
                    </td>
                    <td width="164">
                        <p>4,386</p>
                    </td>
                </tr>
            </tbody>
        </table>


    </div>
    <!------------ End English------------------>

  

    <div class="text-center mb-3" style="display: none;">
        <asp:Button ID="btnSubmit" runat="server" CssClass="btns btn-submit" Text="Next" />
    </div>
    <div class="text-center mb-3" id="btnNext"><a href="#" onclick="fnMenu(8, this)" id="btnAnchorNext" class="btns btn-submit">Next</a></div>
    <div class="text-center mb-3" id="btnClose"><a href="#" onclick="fnClose()" id="btnAnchorclose" class="btns btn-submit">Close</a></div>




    <asp:HiddenField ID="hdnCounter" runat="server" Value="0" />
    <div id="dvDialog" style="display: none"></div>
</asp:Content>

