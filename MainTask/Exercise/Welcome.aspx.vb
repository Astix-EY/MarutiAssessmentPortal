Imports System.Data
Imports System.Data.SqlClient
Partial Class Data_Information_Welcome
    Inherits System.Web.UI.Page
    Dim intLoginID As Integer = 0
    Dim AssessmentType As Integer
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If (Session("LoginId") Is Nothing) Then
            Response.Redirect("../Common/frmSessionExpire.aspx")
            Return
        End If
        intLoginID = IIf(IsNothing(Request.QueryString("intLoginID")), 0, Request.QueryString("intLoginID"))
	   hdnRegionID.Value = Session("RegionID")

    End Sub
    Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        'Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        'Dim objCom2 As New SqlCommand("[SpSavePageNo]", Objcon2)
        'objCom2.Parameters.Add("@EmpNodeID", SqlDbType.Int).Value = Session("NodeId")
        'objCom2.Parameters.Add("@Pgnmbr", SqlDbType.Int).Value = 1

        'objCom2.CommandType = CommandType.StoredProcedure
        'objCom2.CommandTimeout = 0
        'Objcon2.Open()
        'objCom2.ExecuteNonQuery()
        'objCom2.Dispose()
        'Objcon2.Close()
        'Objcon2.Dispose()
        'Dim strConsentInfo As String
        ' strConsentInfo = 1 ' fnGetConsentInfo()
        Response.Redirect("Instructions.aspx?intLoginID=" & intLoginID & "&AssessmentType=" & AssessmentType)
        'If strConsentInfo.Split("^")(1) = 1 Then
        '    Response.Redirect("frmIntroduction.aspx?intLoginID=" & intLoginID)
        'Else
        '    Response.Redirect("frmConsentMessage.aspx?intLoginID=" & intLoginID)
        'End If
    End Sub

    Function fnGetConsentInfo() As String

        Dim dr As SqlDataReader
        Dim flgConsent As Integer = 0
        Dim strReturn As Integer = 0
        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spGetConsentInfoAgEmployee]", Objcon2)
        objCom2.Parameters.Add("@EmpNodeID", SqlDbType.Int).Value = Session("EmpNodeID")

        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Try
            Objcon2.Open()
            dr = objCom2.ExecuteReader
            dr.Read()
            flgConsent = dr.Item(0)
            strReturn = 1
        Catch ex As Exception
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
            strReturn = 2
        End Try
        If strReturn = 1 Then
            Return "1^" & flgConsent
        Else
            Return "2^" & flgConsent
        End If

    End Function
    <System.Web.Services.WebMethod(EnableSession:=True)>
    Public Shared Function fnSetSession(ByVal LngID As Integer) As String
        HttpContext.Current.Session("SelectedLngID") = LngID
        Return "a"
    End Function
End Class
