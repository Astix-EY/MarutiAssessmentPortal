Imports System.Data
Imports System.Data.SqlClient
Partial Class _Default
    Inherits System.Web.UI.Page
    Public EmpCode As String
    Public Name As String
    Public EmailId As String
    Public RoleId As String
    Public TFunction As String
    Public Department As String
    Public Level As String
    Public AssessmentType As String
    Dim arrPara(0, 1) As String
    Dim objAdo As New clsConnection.clsConnection
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        empcode = request.form("empcode")
        name = request.form("name")
        emailid = request.form("emailid")
        roleid = request.form("roleid")
        tfunction = request.form("function")
        department = request.form("department")
        level = request.form("level")
        assessmenttype = request.form("assessmenttype")
      

        Dim chkFlag As Integer = 0
        If EmpCode = "" Or EmpCode Is Nothing Then
            chkFlag = 1
        End If
        If Name = "" Or Name Is Nothing Then
            chkFlag = 1
        End If
        If EmailId = "" Or EmailId Is Nothing Then
            chkFlag = 1
        End If
        If Level = "" Or Level Is Nothing Then
            chkFlag = 1
        End If
        If AssessmentType = "" Or AssessmentType Is Nothing Then
            chkFlag = 1
        End If
        If chkFlag = 1 Then
            Session("EmpCode") = EmpCode
            Session("Name") = Name
            Session("EmailId") = EmailId
            Session("Level") = Level
            Session("AssessmentType") = AssessmentType
            Response.Redirect("~/CommonForm/Error.aspx")
        Else
            fnCallSp(EmpCode, Name, EmailId, RoleId, TFunction, Department, Level, AssessmentType)

        End If

    End Sub
    Sub fnCallSp(ByVal EmpCode As String, ByVal Name As String, ByVal EmailId As String, ByVal RoleId As String, ByVal TFunction As String, ByVal Department As String, ByVal Level As String, ByVal AssessmentType As String)

        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spCreateAndValidateUserForLMS]", Objcon2)
        objCom2.Parameters.Add("@EmpCode", SqlDbType.VarChar).Value = EmpCode
        objCom2.Parameters.Add("@Name", SqlDbType.VarChar).Value = Name
        objCom2.Parameters.Add("@EmailId", SqlDbType.VarChar).Value = EmailId
        objCom2.Parameters.Add("@RoleId", SqlDbType.VarChar).Value = RoleId
        objCom2.Parameters.Add("@Function", SqlDbType.VarChar).Value = TFunction
        objCom2.Parameters.Add("@Department", SqlDbType.VarChar).Value = Department
        objCom2.Parameters.Add("@Level", SqlDbType.VarChar).Value = Level
        objCom2.Parameters.Add("@AssessmentType", SqlDbType.VarChar).Value = AssessmentType
        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0

        Dim strReturn As String = ""
        Dim EmpNodeId As Integer = 0
        Dim LoginID As Integer = 0
        Dim strError As String = ""
        Dim flgPageToOpen As Integer = 0
        Try
            Objcon2.Open()
            Dim dr As SqlDataReader
            dr = objCom2.ExecuteReader
            dr.Read()

            LoginID = dr("LoginId")
            Session("LoginId") = LoginID

            EmpNodeId = dr("EmpNodeID")
            Session("NodeId") = EmpNodeId

            flgPageToOpen = dr("flgPageToOpen")
            Session("flgPageToOpen") = flgPageToOpen

            strReturn = "1^"

        Catch ex As Exception
            Session("EXMessage") = ex.Message
            strReturn = "2^"
			strError=ex.Message
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try

        If strReturn = "1^" Then

            If flgPageToOpen = 9 Then
                strError = "You are not authorised to enter Competency Connect. Please contact your administrator."
                hdMsg.InnerText = strError
	ElseIf flgPageToOpen = 4 Then
                strError = "Your assessment schedule has not be finalized as yet. Kindly contact your administrator for next steps."
                hdMsg.InnerText = strError
            Else
                If flgPageToOpen = 1 Then
                    Response.Redirect("Data/Common/frmCDIMessage.aspx")
                ElseIf flgPageToOpen = 2 Or flgPageToOpen = 3 Then
                    Response.Redirect("Login.aspx?intLoginID=" & LoginID & "&EmpID=" & EmpNodeId)
                End If
            End If

        Else
            'Response.Redirect("CommonForm/Error.aspx")
            Response.Write("Error-" & strError)
        End If
    End Sub
End Class
