Imports System.Data
Imports System.Data.SqlClient
Partial Class Data_Information_Instructions
    Inherits System.Web.UI.Page
    Dim intLoginID As Integer = 0
    Dim AssessmentType As Integer
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If (Session("LoginId") Is Nothing) Then
            Response.Redirect("../../Common/frmSessionExpire.aspx")
            Return
        End If

        intLoginID = IIf(IsNothing(Request.QueryString("intLoginID")), 0, Request.QueryString("intLoginID"))
        AssessmentType = IIf(IsNothing(Request.QueryString("AssessmentType")), 0, Request.QueryString("AssessmentType"))

    End Sub

    Protected Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click
        'Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        'Dim objCom2 As New SqlCommand("[SpSavePageNo]", Objcon2)
        'objCom2.Parameters.Add("@EmpNodeID", SqlDbType.Int).Value = Session("EmpNodeID")
        'objCom2.Parameters.Add("@Pgnmbr", SqlDbType.Int).Value = 2

        'objCom2.CommandType = CommandType.StoredProcedure
        'objCom2.CommandTimeout = 0
        'Objcon2.Open()
        'objCom2.ExecuteNonQuery()
        'objCom2.Dispose()
        'Objcon2.Close()
        'Objcon2.Dispose()
        'Dim strConsentInfo As String
        'strConsentInfo = 1 ' fnGetConsentInfo()
        'Response.Redirect("../../MainTask/Exercise/MyTask.aspx?intLoginID=" & intLoginID & "&AssessmentType=" & AssessmentType)


        If (Convert.ToString(Session("IsSelfieTaken")) = "0") Then
            '    Response.Redirect("../../Admin/Setting/frmSelfie.aspx")
            Response.Redirect("../../MainTask/Information/frmSelfie.aspx?intLoginID=" & intLoginID & "&AssessmentType=" & AssessmentType)
        Else
            If (Convert.ToString(Session("IsLifeReflectionFormDone")) = "0") Then
                Response.Redirect("../../MainTask/Questionnaire/frmLifeRefQuestionnaire.aspx?RspID=" & Session("RspID") & "&intLoginID=" & intLoginID)
            Else
                Response.Redirect("../../MainTask/Exercise/MyTask.aspx?intLoginID=" & intLoginID & "&AssessmentType=" & AssessmentType)
            End If


        End If

    End Sub

    <System.Web.Services.WebMethod(EnableSession:=True)>
    Public Shared Function fnSetSession(ByVal LngID As Integer) As String
        HttpContext.Current.Session("SelectedLngID") = LngID
        Return "a"
    End Function
End Class
