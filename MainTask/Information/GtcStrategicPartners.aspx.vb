Imports System.Data
Imports System.Data.SqlClient
Partial Class Data_Information_GtcStrategicPartners
    Inherits System.Web.UI.Page
    Dim intLoginID As Integer = 0
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        hdnToolID.Value = IIf(IsNothing(Request.QueryString("ToolID")), 0, Request.QueryString("ToolID"))
        If (Session("LoginId") Is Nothing) Then
            Response.Redirect("../Common/frmSessionExpire.aspx")
            Return
        End If

        intLoginID = IIf(IsNothing(Request.QueryString("intLoginID")), 0, Request.QueryString("intLoginID"))
        Dim ExerciseMainFlagValue As Integer = IIf(IsNothing(Request.QueryString("ExerciseMainFlagValue")), 0, Request.QueryString("ExerciseMainFlagValue"))
        'If ExerciseMainFlagValue = 1 Then
        '    BriefRole.Attributes.Add("style", "display:block")
        '    ExerciseMain.Attributes.Add("style", "display:block")
        'End If

        If Session("flgPageToOpen") = 3 Then
            fnCallPreExerciseStatus()
        End If

    End Sub

    Sub fnCallPreExerciseStatus()
        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("spPreExerciseUpdateStatus", Objcon2)
        objCom2.Parameters.Add("@LoginID", SqlDbType.Int).Value = Session("LoginId")
        objCom2.Parameters.Add("@EmpNodeID", SqlDbType.Int).Value = Session("NodeId")
        objCom2.Parameters.Add("@flgStage", SqlDbType.Int).Value = 1
        objCom2.Parameters.Add("@flgStatus", SqlDbType.Int).Value = 1

        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Dim strReturn As String = ""

        Try
            Objcon2.Open()
            Dim dr As SqlDataReader
            dr = objCom2.ExecuteReader
            dr.Read()
            hdnCounter.Value = IIf(IsNothing(dr.Item("BackGroundTimeRemaining")), 0, dr.Item("BackGroundTimeRemaining"))
        Catch ex As Exception
            strReturn = "2^"
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try
    End Sub

    Private Sub btnSubmit_Click(sender As Object, e As EventArgs) Handles btnSubmit.Click

        Response.Redirect("BriefOnYourRole.aspx?intLoginID=" & intLoginID)

    End Sub
    <System.Web.Services.WebMethod(EnableSession:=True)>
    Public Shared Function fnSetSession(ByVal LngID As Integer) As String
        HttpContext.Current.Session("SelectedLngID") = LngID
        Return "a"
    End Function
End Class
