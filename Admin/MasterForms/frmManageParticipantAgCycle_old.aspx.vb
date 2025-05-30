﻿Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Imports Newtonsoft.Json
Partial Class Admin_MasterForms_frmManageParticipantAgCycle
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            fnfillCycleDropDown()
            '    Dim strReturnTable As String = fnDisplayLevelandCycleAgCompany()
            '   dvMain.InnerHtml = strReturnTable.Split("@")(1)
        End If
    End Sub
    Private Sub fnfillCycleDropDown()
        Dim Scon As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("strConn").ConnectionString)
        Dim Scmd As SqlCommand = New SqlCommand()
        Scmd.Connection = Scon
        Scmd.CommandText = "spGetAssessmentCycleDetail"
        Scmd.Parameters.AddWithValue("@CycleID", 0)
		 Scmd.Parameters.AddWithValue("@Flag", 0)
        Scmd.CommandType = CommandType.StoredProcedure
        Scmd.CommandTimeout = 0
        Dim Sdap As SqlDataAdapter = New SqlDataAdapter(Scmd)
        Dim dt As DataTable = New DataTable()
        Sdap.Fill(dt)
        Dim itm As ListItem = New ListItem()
        itm.Text = "- Cycle Name -"
        itm.Value = "0"
        ddlCycleName.Items.Add(itm)

        For Each dr As DataRow In dt.Rows
            itm = New ListItem()
            itm.Text = dr("CycleName").ToString() & " (" + Convert.ToDateTime(dr("CycleStartDate")).ToString("dd MMM yy") & ")" ' & "-->" & dr("Descr")
            itm.Value = dr("CycleId").ToString()
            ddlCycleName.Items.Add(itm)
        Next
    End Sub
    'Sub fnfillCycleDropDown()
    '    Dim objCon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
    '    Dim objCom As New SqlCommand("[spGetAssessmentCycleDetail]", objCon)
    '    objCom.Parameters.Add("@CycleID", SqlDbType.Int).Value = 0
    '    objCom.CommandTimeout = 0
    '    objCom.CommandType = CommandType.StoredProcedure
    '    Dim DT As New DataTable
    '    Dim SqlDA As SqlDataAdapter
    '    Try
    '        SqlDA = New SqlDataAdapter(objCom)
    '        SqlDA.Fill(DT)
    '        ddlCycleName.DataSource = DT
    '        ddlCycleName.DataValueField = "CycleID"
    '        ddlCycleName.DataTextField = "CycleName" & " (" & "CycleStartDate" & ")"
    '        ddlCycleName.DataBind()
    '    Catch ex As Exception
    '        '    strReturn = "2@" & ex.Message
    '    End Try

    'End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function fnGetCycleNameAgDate(ByVal CycleDate As String) As String
        Dim strTable As New StringBuilder
        Dim strReturnVal As String = 1
        Dim srlNmCntr As Int16 = 1

        Dim objCon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom As New SqlCommand("[spGetCycleAgDate]", objCon)
        objCom.Parameters.Add("@Date", SqlDbType.Date).Value = CycleDate

        objCom.CommandTimeout = 0
        objCom.CommandType = CommandType.StoredProcedure
        Dim strReturn As String = ""
        Dim strData As String = ""
        Dim dr As SqlDataReader
        objCon.Open()
        dr = objCom.ExecuteReader()
        'strTable.Append("<div id='tblMain' align='center'>")

        Try
            While dr.Read
                strData &= dr.Item("CycleID") & "^" & dr.Item("CycleName") & "|"
            End While
            strReturn = "1@" & strData
        Catch ex As Exception
            strReturn = "2@" & ex.Message
        End Try
        Return strReturn
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnDisplayParticpantAgCycle(ByVal CycleID As Integer, ByVal TypeID As Integer, ByVal SearchText As String) As String
        Dim strTable As New StringBuilder
        Dim strReturnVal As String = 1
        Dim srlNmCntr As Int16 = 1

        Dim objCon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom As New SqlCommand("[spGETParticipantNameAgCycle]", objCon)
        objCom.Parameters.Add("@CycleID", SqlDbType.Int).Value = CycleID
        objCom.Parameters.Add("@TypeID", SqlDbType.Int).Value = TypeID
        objCom.Parameters.Add("@SearchText", SqlDbType.VarChar).Value = SearchText

        objCom.CommandTimeout = 0
        objCom.CommandType = CommandType.StoredProcedure

        Dim da As New SqlDataAdapter(objCom)
        Dim ds As New DataSet
        da.Fill(ds)

        'Dim dr As SqlDataReader
        'objCon.Open()
        'dr = objCom.ExecuteReader()
        Dim SetName As String = ""
        If ds.Tables(0).Rows.Count > 0 Then
            strTable.Append("<div id='dvtblbody'><table class='table table-bordered table-sm text-center' id='tblEmp'>")
            strTable.Append("<thead><tr>")
            strTable.Append("<th style='width:8%'>")
            strTable.Append("S. No.")
            strTable.Append("</th>")
            strTable.Append("<th>")
            strTable.Append("Participant Name")
            strTable.Append("</th>")
            strTable.Append("<th>")
            strTable.Append("Participant Code")
            strTable.Append("</th>")
            strTable.Append("<th>")
            strTable.Append("Level Name")
            strTable.Append("</th>")

            strTable.Append("<th>")
            strTable.Append("Manager Name")
            strTable.Append("</th>")
            strTable.Append("<th style='width:10%' colspan=2>")
            strTable.Append("Include")
            strTable.Append("</th>")
            strTable.Append("</tr></thead>")
            strTable.Append("<tbody>")

            For Each drParticipant As DataRow In ds.Tables(0).Rows


                strTable.Append("<tr flgactive = " & drParticipant.Item("flgActive") & ">")
                strTable.Append("<td>")
                strTable.Append(srlNmCntr)
                strTable.Append("</td>")

                strTable.Append("<td>")
                strTable.Append(drParticipant.Item("ParticipantName"))
                strTable.Append("</td>")

                strTable.Append("<td>")
                strTable.Append(drParticipant.Item("Empcode"))
                strTable.Append("</td>")

                If drParticipant.Item("BandID") = 1 Then
                    SetName = "Level4"
                ElseIf drParticipant.Item("BandID") = 2 Then
                    SetName = "Level3"
                Else
                    SetName = "No Level Assigned"
                End If
                strTable.Append("<td>")
                strTable.Append(SetName)
                strTable.Append("</td>")

                'Dim ddlManageName As New ListItem
                'ddlManageName.Text = "- Select Manager - "
                'ddlManageName.Value = "0"
                Dim ddlManager As String = ""
                ddlManager &= "<option value = 0>- Select Manager -</option>"
                For Each MngrNameOptions As DataRow In ds.Tables(2).Rows
                    For Each row0 As DataRow In ds.Tables(1).Rows
                        If MngrNameOptions.Item("ManagerNodeID") = row0.Item("ManagerID") And row0.Item("ParticipantID") = drParticipant.Item("ParticipantID") Then
                            ddlManager &= "<option selected value = " & MngrNameOptions.Item("ManagerNodeID") & ">" & MngrNameOptions.Item("ManagerName").ToString() & "</option>"
                        End If
                    Next row0

                    ddlManager &= "<option value = " & MngrNameOptions.Item("ManagerNodeID") & ">" & MngrNameOptions.Item("ManagerName").ToString() & "</option>"

                Next MngrNameOptions
                strTable.Append("<td>")
                strTable.Append("<Select id='ddlmanagerList' > " & ddlManager & "</select>")
                strTable.Append("</td>")

                If drParticipant.Item("flgActive") = 1 Then
                        Dim sdeletelnk = "<i Class='fa fa-times' aria-hidden='true' title='Click to remove mapping' style='font-size:15px;cursor:pointer;' PNodeID =" & drParticipant.Item("ParticipantID") & "   onclick='fnDeleteParticipantMapping(this)'></i>"
                    strTable.Append("<td style='text-align:center'>")
                    strTable.Append("<input flgexist='1' flg=0 type=checkbox checked disabled ParticipantID = '" & drParticipant.Item("ParticipantID") & "'>")
                        strTable.Append("</td>")
                        strTable.Append("<td style='text-align:center'>")
                        strTable.Append(sdeletelnk)
                        strTable.Append("</td>")
                    Else
                        strTable.Append("<td style='text-align:center'>")
                        strTable.Append("<input flgexist='0' flg=0 type=checkbox  ParticipantID = '" & drParticipant.Item("ParticipantID") & "'>")
                        strTable.Append("</td>")
                        strTable.Append("<td>&nbsp;</td>")
                    End If


                    strTable.Append("</tr>")

                    srlNmCntr = srlNmCntr + 1
                Next drParticipant
                strTable.Append("</tbody>")
            strTable.Append("</table></div>")

        Else
            strTable.Append("<div class='text-danger text-center'>")
            strTable.Append("No Record Found...")
            strTable.Append("</div>")
        End If

        '    strReturnVal = "1@" & HttpContext.Current.Server.HtmlDecode(strTable.ToString)
        strReturnVal = "1@" & strTable.ToString
        Return strReturnVal
    End Function


    <System.Web.Services.WebMethod()>
    Public Shared Function fnManageAssessmentParticipantAgCycle(ByVal CycleID As Integer, ByVal BandId As Integer, ByVal objDetails As Object) As String
        Dim strReturn As String = 1

        Dim tblParticipant As New DataTable()
        tblParticipant.TableName = "tblParticipant"
        Dim settings As New JsonSerializerSettings()
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore
        Dim strTable As String = JsonConvert.SerializeObject(objDetails, settings.ReferenceLoopHandling)
        tblParticipant = JsonConvert.DeserializeObject(Of DataTable)(strTable)

        If (tblParticipant.Rows.Count = 0) Then
            tblParticipant.Columns.Add("CycleID", GetType(Int32))
            tblParticipant.Columns.Add("UserNodeID", GetType(Int32))
            tblParticipant.Columns.Add("flg", GetType(Int32))
            tblParticipant.Columns.Add("BandID", GetType(Int32))
        End If

        Dim Objcon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom1 As New SqlCommand("[spAssessmentCycleMappingWithParticipant_New]", Objcon)
        objCom1.CommandType = CommandType.StoredProcedure
        objCom1.CommandTimeout = 0
        objCom1.Parameters.Add("@CycleId", SqlDbType.Int).Value = CycleID
        objCom1.Parameters.Add("@BandID", SqlDbType.Int).Value = BandId
        objCom1.Parameters.AddWithValue("@tblParticipant", tblParticipant)
        Try
            Objcon.Open()
            objCom1.ExecuteNonQuery()
            ' fnSendMailToParitipant(tblParticipant)
            strReturn = "1@"
        Catch ex As Exception
            strReturn = "2@" & ex.Message
        Finally
            objCom1.Dispose()

            Objcon.Close()
            Objcon.Dispose()
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
        objCom2.Parameters.Add("@flagChk", SqlDbType.Int).Value = 1

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
