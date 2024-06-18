Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Partial Class Admin_MasterForms_frmManageEmployeeDetails
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Dim strReturnTable As String = fnGetEmployeeDetails(1, "", 1)
            dvMain.InnerHtml = strReturnTable.Split("~")(1)
        End If

    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function fnGetEmployeeDetails(ByVal flagChkddlUsers As Integer, ByVal SerachTxt As String, ByVal TypeID As Integer) As String
        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spGetAllEmployeeDetails_New]", Objcon2)
        objCom2.Parameters.Add("@flagChkParticipant", SqlDbType.Int).Value = flagChkddlUsers
        objCom2.Parameters.Add("@SearchText", SqlDbType.NVarChar).Value = SerachTxt
        objCom2.Parameters.Add("@TypeID", SqlDbType.Int).Value = TypeID
        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Dim dr As SqlDataReader
        Dim cycleName As String = ""
        Dim cycleDate As DateTime
        Dim strReturn As String
        Dim strTable As New StringBuilder
        Try
            Objcon2.Open()
            dr = objCom2.ExecuteReader
            Dim strUserType As String = ""

            If dr.HasRows Then
                strTable.Append("<table class='table table-bordered table-sm text-center'>")
                strTable.Append("<thead><tr>")
                strTable.Append("<th>FName</th>")
                strTable.Append("<th>LName</th>")
                strTable.Append("<th>EMailID</th>")
                strTable.Append("<th>Emp Code</th>")
                'strTable.Append("<th>Level Name</th>")
                strTable.Append("<th>User Type</th>")
                strTable.Append("<th style='width:8%'>Action</th>")
                strTable.Append("</tr></thead><tbody>")
                While dr.Read

                    strTable.Append("<tr>")
                    strTable.Append("<td class='text-center'>" & dr("FName") & "</td>")
                    strTable.Append("<td class='text-center'>" & dr("LName") & "</td>")
                    strTable.Append("<td class='text-center'>" & dr("EmailID") & "</td>")

                    strTable.Append("<td class='text-center'>" & dr("EmpCode") & "</td>")
                    'strTable.Append("<td class='text-center'>" & dr("BandName") & "</td>")
                    If dr.Item("TypeID") = 1 Then
                        strUserType = "Participant"
                    ElseIf dr.Item("TypeID") = 2 Then
                        strUserType = "Assessor"
                    Else
                        strUserType = "Manager"
                    End If
                    strTable.Append("<td style='background-color:#e9e9e9'><i>" & strUserType & "</i></td>")
                    strTable.Append("<td><span class='text-primary fa fa-pencil pointer' onclick=fnEditEmployeeDetails('" & dr.Item("EmpNodeID") & "','" & Replace(dr("FName"), " ", "-") & "','" & Replace(dr("LName"), " ", "-") & "','" & Replace(dr("EmailID"), " ", "-") & "','" & Replace(dr("EmpCode"), " ", "-") & "'," & dr.Item("TypeID") & "," & dr.Item("BandID") & ")></span><span class='text-danger ml-3 fa fa-trash pointer' onclick=fndelete_row('" & dr.Item("EmpNodeID") & "')></span></td>")
                    strTable.Append("</tr>")
                End While

            Else
                strTable.Append("<table class='table table-bordered table-sm text-center'><tbody>")
                strTable.Append("<tr>")
                strTable.Append("<td class='text-left'>No Record Found... Please click on the ''Add New User'' Button to add the new user.</td>")
                strTable.Append("</tr>")
            End If
            strTable.Append("</tbody></table>")

            dr = Nothing
            ' dvMain.InnerHtml = strTable.ToString()
        Catch ex As Exception
            strReturn = "2^" & ex.Message
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try

        strReturn = "1~" & HttpContext.Current.Server.HtmlDecode(strTable.ToString)
        Return strReturn
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnManageEmployeeDetails(ByVal EmpID As Integer, FName As String, LName As String, EmpCode As String, EmailID As String, ByVal UserType As Integer, ByVal SetID As Integer) As String
        Dim strReturn As String = 1

        Dim LoginId As Integer

        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spManageEmployeeDetails]", Objcon2)
        objCom2.Parameters.Add("@EmpId", SqlDbType.Int).Value = EmpID
        objCom2.Parameters.Add("@FName", SqlDbType.NVarChar).Value = FName
        objCom2.Parameters.Add("@LName", SqlDbType.NVarChar).Value = LName
        objCom2.Parameters.Add("@EmailID", SqlDbType.NVarChar).Value = EmailID
        objCom2.Parameters.Add("@Empcode", SqlDbType.NVarChar).Value = EmpCode
        objCom2.Parameters.Add("@UserType", SqlDbType.Int).Value = UserType
        objCom2.Parameters.Add("@SetNameID", SqlDbType.Int).Value = SetID
        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Dim dr As SqlDataReader
        Dim ReturnFlgVal As Integer
        Try
            Objcon2.Open()
            dr = objCom2.ExecuteReader
            dr.Read()

            ReturnFlgVal = dr.Item("FlgVal")
            strReturn = "1@" & ReturnFlgVal
        Catch ex As Exception
            strReturn = "2@" & ex.Message
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try
        Return strReturn

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnCheckMappedUsersAgCycle(ByVal EmpNodeID As Integer) As String
        Dim strReturn As String = 1
        ' Sub spRspBusinessCaseUPDAnswers(ByVal RspExerciseID As Integer, ByVal LoginId As Integer, ByVal selValues As String, ByVal statusValue As Integer)
        Dim LoginId As Integer
        LoginId = HttpContext.Current.Session("LoginId")
        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spCheckUsersAssmntStatus]", Objcon2)
        objCom2.Parameters.Add("@EmpNodeID", SqlDbType.Int).Value = EmpNodeID


        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Dim dr As SqlDataReader
        Dim ReturnFlag As Integer
        Try
            Objcon2.Open()
            dr = objCom2.ExecuteReader
            dr.Read()

            ReturnFlag = dr.Item("chkFlag")
            strReturn = "1@" & ReturnFlag
        Catch ex As Exception
            strReturn = "2@" & ex.Message
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try
        Return strReturn

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnDeleteUser(ByVal EmpNodeID As Integer) As String
        Dim strReturn As String = 1

        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spDeleteUser]", Objcon2)
        objCom2.Parameters.Add("@EmpNodeID", SqlDbType.Int).Value = EmpNodeID

        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Try
            Objcon2.Open()
            objCom2.ExecuteNonQuery()
            strReturn = "1@"
        Catch ex As Exception
            strReturn = "2@" & ex.Message
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try
        Return strReturn

    End Function
End Class
