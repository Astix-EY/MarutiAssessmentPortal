<%@ Page Title="" Language="VB" MasterPageFile="~/MainTask/MasterPage/Site.master" AutoEventWireup="false" CodeFile="frmThanks.aspx.vb" Inherits="frmThanks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        function fnLogout() {
            window.location.href = "Login.aspx";
        }
        history.pushState(null, null, document.URL);
        window.addEventListener('popstate', function () {
            history.pushState(null, null, document.URL);
        });

    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" runat="Server">
<div class="middle-cont p-5">
        <%-- <div class="text-center">
            <h2 class="icon4thanku"><span class="fa fa-check"></span></h2>
        </div>--%>
        <h5 class="text-left"><em>Thank you very much for your feedback. It will help us to continuously improve the
Virtual Development Center experience. All the best for your further career and
professional development!</em></h5>
   		<br />
        <h5 class="text-left mt-4"><em>EY Virtual Development Center Team</em></h5>
        <%--<h4 class="text-center">Please close the browser before you leave the system.</h4>--%>
        <div class="text-center m-4">
            <asp:Button ID="btnCLose" CssClass="btns btn-submit" runat="server" Text="Close" OnClick="btnCLose_Click" />
        </div>
    </div>
   

</asp:Content>

