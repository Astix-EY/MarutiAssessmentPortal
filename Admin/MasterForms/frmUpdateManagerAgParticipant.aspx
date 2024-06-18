<%@ Page Title="" Language="VB" MasterPageFile="~/Admin/AdminMaster/Site.master" AutoEventWireup="false" CodeFile="frmUpdateManagerAgParticipant.aspx.vb" Inherits="Admin_MasterForms_frmUpdateManagerAgParticipant" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentTimer" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ConatntMatter" Runat="Server">
    <div class="section-title clearfix">
        <h3 class="text-center">Participant And Manager List</h3>
        <div class="title-line-center"></div>
    </div>

    <div id="dvMain" runat="server"></div>
   
    <div id="loader" class="loader-outerbg" style="display: none">
        <div class="loader"></div>
    </div>
</asp:Content>

