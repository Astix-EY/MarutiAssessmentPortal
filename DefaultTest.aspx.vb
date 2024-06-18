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
        'EmpCode = Request.Form("EmpCode")
        'Name = Request.Form("Name")
        'EmailId = Request.Form("EmailId")
        'RoleId = Request.Form("RoleId")
        'TFunction = Request.Form("Function")
        'Department = Request.Form("Department")
        'Level = Request.Form("Level")
        'AssessmentType = Request.Form("AssessmentType")

        Dim EmpID = Request.QueryString("EmpID")

        Session("NodeId") = EmpID
 AssessmentType = "5" 'Request.Form("AssessmentType")
        Session("AssessmentType") = AssessmentType
	'Response.Redirect("frmUnderConstruction.aspx")
        Response.Redirect("Login.aspx?EmpID=" & EmpID)

        EmpCode = "1000"
        Name = "Astix Test"
        EmailId = "astix@astixsolutions.com"
        RoleId = "1"
        TFunction = "1"
        Department = "1"
        Level = "1"
        AssessmentType = "2" 'Request.Form("AssessmentType")

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
        Dim flgPageToOpen As Integer = 0
        Dim strError As String = ""
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
            strError = ex.Message
        Finally

            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try

        If strReturn = "1^" Then
            If flgPageToOpen = 1 Then
                Response.Redirect("Data/Common/frmCDIMessage.aspx")
            ElseIf flgPageToOpen = 2 Then
                Response.Redirect("Login.aspx?intLoginID=" & LoginID & "&EmpID=" & EmpNodeId)
            Else
                Response.Redirect("Login.aspx?intLoginID=" & LoginID & "&EmpID=" & EmpNodeId)
            End If

        Else
            Response.Write("Error-" & strError)
        End If
    End Sub
End Class
