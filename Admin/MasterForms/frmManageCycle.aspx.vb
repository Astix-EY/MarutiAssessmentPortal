Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Partial Class Admin_MasterForms_frmManageCycle
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            fnfillAssessmentType()
            Dim strReturnTable As String = fnGetCycleDetails(0, "", 1)
            dvMain.InnerHtml = strReturnTable.Split("@")(1)

        End If

    End Sub

    Private Sub fnfillAssessmentType()
        Dim Scon As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("strConn").ConnectionString)
        Dim Scmd As SqlCommand = New SqlCommand()
        Scmd.Connection = Scon
        Scmd.CommandText = "spGetAssessmentTypeMstr"

        Scmd.CommandType = CommandType.StoredProcedure
        Scmd.CommandTimeout = 0
        Dim Sdap As SqlDataAdapter = New SqlDataAdapter(Scmd)
        Dim dt As DataTable = New DataTable()
        Sdap.Fill(dt)
        Dim itm As ListItem = New ListItem()
        itm.Text = "- Assessment Type -"
        itm.Value = "0"
        ddlAssessmentType.Items.Add(itm)

        For Each dr As DataRow In dt.Rows
            itm = New ListItem()
            itm.Text = dr("Descr").ToString()
            itm.Value = dr("AssmntTypeID").ToString()
            ddlAssessmentType.Items.Add(itm)
        Next
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function fnGetCycleDetails(ByVal CycleID As Integer, ByVal SearchTxt As String, ByVal Flag As Integer) As String
        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spGetAssessmentCycleDetail_new]", Objcon2)
        objCom2.Parameters.Add("@CycleID", SqlDbType.Int).Value = CycleID
        objCom2.Parameters.Add("@Flag", SqlDbType.Int).Value = Flag
        objCom2.Parameters.Add("@SearchText", SqlDbType.NVarChar).Value = SearchTxt
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
            strTable.Append("<table class='table table-bordered table-sm text-center' id='tblEmp'>")

            If dr.HasRows Then

                strTable.Append("<thead><tr>")
                strTable.Append("<th>Cycle Name</th>")
                strTable.Append("<th>Cycle Date</th>")
                strTable.Append("<th>Assessment Type</th>")
                strTable.Append("<th>Mapped Participant</th>")
                strTable.Append("<th>Mapped Assessor</th>")
                strTable.Append("<th style='width:8%'>Action</th>")
                strTable.Append("</tr></thead><tbody>")
                While dr.Read
                    cycleDate = IIf(IsDBNull(dr("CycleStartDate")), "", dr("CycleStartDate"))
                    cycleName = IIf(IsDBNull(dr("CycleName")), "", dr("CycleName"))
                    strTable.Append("<tr>")
                    strTable.Append("<td class='text-left'>" & dr("CycleName") & "</td>")
                    strTable.Append("<td>" & dr("CycleStartDate") & "</td>")
                    strTable.Append("<td style='background-color:#e9e9e9'><i>" & dr("AssementType") & "</i></td>")
                    strTable.Append("<td style='background-color:#e9e9e9'><i>" & dr("ParticipantCount") & "</i></td>")
                    strTable.Append("<td style='background-color:#e9e9e9'><i>" & dr("AssessorCount") & "</i></td>")
                    strTable.Append("<td><span style='cursor:pointer' class='text-primary fa fa-pencil' onclick=fnEditCycleDetails('" & dr.Item("cycleid") & "','" & Replace(dr.Item("CycleName"), " ", "_") & "','" & dr("CycleStartDate") & "','" & dr("BandID") & "','" & dr("AssessmentTypeId") & "')></span><span style='cursor:pointer' class='text-danger ml-3 fa fa-trash' onclick=fndelete_row('" & dr.Item("cycleid") & "')></span></td>")
                    strTable.Append("</tr>")
                End While
                strTable.Append("</tbody>")
            Else
                strTable.Append("<thead><tr>")
                strTable.Append("<th>No Record Found... </th>")

                strTable.Append("</tr></thead><tbody>")
                strTable.Append("<tbody><tr>")
                strTable.Append("<td class='text-left'>Please click on the ''Add New Cycle'' Button to add the new batch.</td>")
                strTable.Append("</tr>")
                strTable.Append("</tbody>")
            End If
            strTable.Append("</table>")
            dr = Nothing
            ' dvMain.InnerHtml = strTable.ToString()
        Catch ex As Exception
            strReturn = "2^" & ex.Message
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try

        strReturn = "1@" & HttpContext.Current.Server.HtmlDecode(strTable.ToString)
        Return strReturn
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnManageCycleName(ByVal CycleID As Integer, CycleName As String, CycleDate As String, ByVal BandID As Integer, ByVal AssessmentType As Integer) As String
        Dim strReturn As String = 1
        ' Sub spRspBusinessCaseUPDAnswers(ByVal RspExerciseID As Integer, ByVal LoginId As Integer, ByVal selValues As String, ByVal statusValue As Integer)
        Dim LoginId As Integer
        LoginId = HttpContext.Current.Session("LoginId")
        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spManageAssessmentCycle]", Objcon2)
        objCom2.Parameters.Add("@CycleID", SqlDbType.Int).Value = CycleID
        objCom2.Parameters.Add("@CycleName", SqlDbType.NVarChar).Value = CycleName
        objCom2.Parameters.Add("@CycleStartDate", SqlDbType.DateTime).Value = CycleDate
        objCom2.Parameters.Add("@BandID", SqlDbType.Int).Value = BandID
        objCom2.Parameters.Add("@AssmntTypeId", SqlDbType.Int).Value = AssessmentType

        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Dim dr As SqlDataReader
        Dim ReturnCycleId As Integer
        Try
            Objcon2.Open()
            dr = objCom2.ExecuteReader
            dr.Read()

            ReturnCycleId = dr.Item("CycleID")
            strReturn = "1@" & ReturnCycleId
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
    Public Shared Function fnCheckMappedUsersAgCycle(ByVal CycleID As Integer) As String
        Dim strReturn As String = 1
        ' Sub spRspBusinessCaseUPDAnswers(ByVal RspExerciseID As Integer, ByVal LoginId As Integer, ByVal selValues As String, ByVal statusValue As Integer)
        Dim LoginId As Integer
        LoginId = HttpContext.Current.Session("LoginId")
        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spCheckMappedUsersAgCycle]", Objcon2)
        objCom2.Parameters.Add("@CycleID", SqlDbType.Int).Value = CycleID


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
    Public Shared Function fnDeleteCycle(ByVal CycleID As Integer) As String
        Dim strReturn As String = 1

        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spDeleteCycle]", Objcon2)
        objCom2.Parameters.Add("@CycleID", SqlDbType.Int).Value = CycleID

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
