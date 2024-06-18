Imports System.Data
Imports System.Data.SqlClient
Partial Class Data_Information_Mytask
    Inherits System.Web.UI.Page
    Dim intLoginID As Integer = 0
    Dim AssessmentType As Integer
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If (Session("LoginId") Is Nothing) Then
            Response.Redirect("../Common/frmSessionExpire.aspx")
            Return
        End If

        intLoginID = IIf(IsNothing(Request.QueryString("intLoginID")), 0, Request.QueryString("intLoginID"))
        AssessmentType = IIf(IsNothing(Request.QueryString("AssessmentType")), 0, Request.QueryString("AssessmentType"))
    End Sub
    <System.Web.Services.WebMethod(EnableSession:=True)>
    Public Shared Function fnSetSession(ByVal LngID As Integer) As String
        HttpContext.Current.Session("SelectedLngID") = LngID
        Return "a"
    End Function
End Class
