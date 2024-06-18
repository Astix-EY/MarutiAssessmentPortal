<%@ Page Title="" Language="VB" MasterPageFile="~/Task/MasterPage/Site.master" AutoEventWireup="false" CodeFile="Welcome.aspx.vb" Inherits="Data_Information_Welcome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../../CSS/jquery-ui.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-ui.js"></script>
    <style type="text/css">
        #dvMalasiaVideo > video {
            width: 15.5% !important;
        }
    </style>

    <script type="text/javascript">
        function preventBack() { window.history.forward(); }

        setTimeout("preventBack()", 0);

        window.onunload = function () { null };
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#rolehead").css("display", "none");
            $("#liBackground").css("display", "none");
            fnChangeDataBasedOnLanguage(1)
            var RegionID = $("#ConatntMatter_hdnRegionID").val()
            if (RegionID == "1") {
                $("#dvMalasiaVideo").show();
                $("#dvBengali").hide();
                $("#dvNepal").hide();
                $("#dvEnglish").hide();
            }
            else if (RegionID == "2" || RegionID == "3") {
                $("#dvMalasiaVideo").hide();
                $("#dvBengali").hide();
                $("#dvNepal").hide();
                $("#dvEnglish").show();
            }
            else if (RegionID == "4") {
                $("#dvMalasiaVideo").hide();
                $("#dvBengali").show();
                $("#dvNepal").hide();
                $("#dvEnglish").hide();
            }
            else if (RegionID == "5") {
                $("#dvMalasiaVideo").hide();
                $("#dvBengali").hide();
                $("#dvNepal").show();
                $("#dvEnglish").hide();
            }

        })


        function fnChangeDataBasedOnLanguage(X) {
            var LngID = $("#hdnLngID").val();

            if (X == 2) {
                var LngID = $("#ddlLanguage").val();
                $("#hdnLngID").val(LngID);
            }
            // fnChangeDataOnPanelPage()

            if (LngID == "2") {
                $("#dvBengali").hide();
                $("#dvNepal").hide();
                $("#dvEnglish").show();
                $("#ConatntMatter_btnSubmit").val("Next")

            }
            else if (LngID == "4") {

                $("#dvBengali").show();
                $("#dvNepal").hide();
                $("#dvEnglish").hide();
                $("#ConatntMatter_btnSubmit").val("Next")
            }
            else if (LngID == "5") {

                $("#dvBengali").hide();
                $("#dvNepal").show();
                $("#dvEnglish").hide();
                $("#ConatntMatter_btnSubmit").val("Next")
            }
            else if (LngID == "8") {

                $("#dvBengali").hide();
                $("#dvNepal").hide();
                $("#dvEnglish").hide();
                $("#dvMalasiaVideo").show();
                $("#ConatntMatter_btnSubmit").val("Next")
            }
            else {
                $("#dvBengali").hide();
                $("#dvNepal").hide();
                $("#dvEnglish").show();
                $("#ConatntMatter_btnSubmit").val("Next")

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
    </script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="latter-panel">
        <div class="latter-panel_header">
            <h2>Our Commitment</h2>
            <h5>To development. To our people. To the future.</h5>
        </div>

        <div class="latter-panel_body" id="dvEnglish" style="display: none">
            <div class="row">
                <div class="col-md-7">
                    <p>Dear Colleague,&nbsp;</p>
                    <p>At the outset, we would like to thank each of you for taking out time to participate in crafting your individual development journey!</p>
                    <p>This experience is an opportunity for you to reflect and take charge of your individual unique careers and gain insight on strengths and opportunity areas. The tasks you will encounter are designed to mirror real-life situations and provide you with an opportunity to experience and navigate change. The outcome of this exercise is intended to support you in your unique personal journey.</p>
                    <p>We request you to make the most of this opportunity and attempt each task with the utmost sincerity and candidness.</p>
                    <p>Wish you the very best.</p>
                    <p>Cheers!<br />Leadership Team.</p>
                </div>
                <div class="col-md-5">
                    <div>
                        <video id="myvideoBahasaMalaysia" vtime="0" poster="../../Images/please_wait.gif" controls>
                            <source src="../../videos/Leadershipvideo_Malaysia.mp4" type="video/mp4" id="videoSource">
                            <object>
                                <embed src="../../videos/Leadershipvideo_Malaysia.mp4" type="application/x-shockwave-flash" id="objectSource" allowfullscreen="false" allowscriptaccess="always" />
                            </object>
                            HTML5 Video is required for this video
                        </video>


                       
                    </div>
                </div>
            </div>

        </div>

        <div class="latter-panel_body" id="dvNepal">
            <p>Dear All, </p>
            <p>Welcome  to Assessment!</p>
            <p>At the outset, we would like to thank each of you for taking out time for the Capability Development Inventory (CDI) initiative. </p>
            <p>The CDI is designed to understand your behavioural preferences when placed in different workplace situations with external clients and internal team members. The tasks within the CDI simulate real life situations you encounter on a day-to-day basis. The behaviours demonstrated by you would be evaluated by trained facilitators and will serve as an input into your developmental journeys. </p>
            <p>The CDI will conclude with a self and manager survey on knowledge competencies across products and sectors. </p>
            <p>We request you to make the most of this opportunity and attempt each task with the utmost sincerity and candidness. The self awareness you will create with these exercises will help you go a long way in building the right skills for success. </p>
            <p>As a next step, the CDI will form the basis of creating your personalized learning journey, which will help you in your sustainable growth and success in your role. </p>
            <p>Good luck.</p>
            <div class="text-right">
                <img src="../../Images/signature-nepal.jpg" alt="" title="signature" style="width: 100px;" />
            </div>
        </div>

        <div class="latter-panel_body" id="dvBengali" style="display: none">
            <p>Dear All, </p>
            <p>Welcome  to Assessment!</p>
            <p>At the outset, we would like to thank each of you for taking out time for the Capability Development Inventory (CDI) initiative. </p>
            <p>The CDI is designed to understand your behavioural preferences when placed in different workplace situations with external clients and internal team members. The tasks within the CDI simulate real life situations you encounter on a day-to-day basis. The behaviours demonstrated by you would be evaluated by trained facilitators and will serve as an input into your developmental journeys. </p>
            <p>The CDI will conclude with a self and manager survey on knowledge competencies across products and sectors. </p>
            <p>We request you to make the most of this opportunity and attempt each task with the utmost sincerity and candidness. The self awareness you will create with these exercises will help you go a long way in building the right skills for success. </p>
            <p>As a next step, the CDI will form the basis of creating your personalized learning journey, which will help you in your sustainable growth and success in your role. </p>

            <p>Good luck.</p>
            <div class="text-right">
                <img src="../../Images/signature-bangla.jpg" alt="" title="signature" style="width: 100px;" />
                <p>
                    Md. Adil Hossain Noble
                    <br />
                    Chief Enterprise Business Officer
                </p>
            </div>
        </div>

        <div class="modal-body p-t-25 text-center" id="dvMalasiaVideo" style="display: none">
            <video id="myvideoBahasaMalaysia" vtime="0" poster="../../Images/please_wait.gif" controls>
                <source src="../../videos/Leadershipvideo_Malaysia.mp4" type="video/mp4" id="videoSource">
                <object>
                    <embed src="../../videos/Leadershipvideo_Malaysia.mp4" type="application/x-shockwave-flash" id="objectSource" allowfullscreen="false" allowscriptaccess="always" />
                </object>
                HTML5 Video is required for this video
            </video>
        </div>
        <div class="text-center mt-2 mb-2">
            <asp:Button ID="btnSubmit" runat="server" CssClass="btns btn-submit" Text="Next" />
        </div>
    </div>

    <asp:HiddenField ID="hdnRegionID" runat="server" />
</asp:Content>

