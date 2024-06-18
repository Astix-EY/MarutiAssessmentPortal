<%@ Page Title="" Language="VB" MasterPageFile="../MasterPage/Site.master" AutoEventWireup="false" CodeFile="frmSessionExpire.aspx.vb" Inherits="frmSessionExpire" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        function fnLogout() {
            window.location.href = "Login.aspx";
        }
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });
        $(function () {
            $('.middle-cont').css({
                "margin-top": ($(window).height() - $(".middle-cont").outerHeight()) / 2 - ($(".navbar").outerHeight() + 30) + "px"
            });
        });
		
        function fnGoToLogin()
        {
            //window.location.href = "https://www.spotmentor.com/sign-in"
            window.location.href = '<%=System.Configuration.ConfigurationManager.AppSettings("TestURL") %>'
        }
		

    </script>
	<script type="text/javascript">
        $(document).ready(function ()
        {
            $("#rolehead").css("display", "none");
			 $("#liBackground").css("display", "none");
			
        })
       
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
    <div class="middle-cont">
        <div class="text-center">
           <%-- <h2 class="icon4thanku"><span class="fa fa-check"></span></h2>--%>
        </div>
        <h5 class="text-center mt-4"><em>Your session has been expired. Please click on the below button to login it again.</em></h5>
       
        <div class="text-center m-4">
           <input type="button" id="btnGoToSession" Class="btns btn-submit" onclick="fnGoToLogin()" value="Click here to login" />
        </div>
    </div>
</asp:Content>

