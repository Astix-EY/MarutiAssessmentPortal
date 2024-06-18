Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Imports Newtonsoft.Json
Imports System.Net
Imports System.Net.Mail
Imports System.Net.Mime
Imports System.Security.Cryptography.X509Certificates
Partial Class Admin_MasterForms_frmManageParticipantManagerMappingAgCycle
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            fnfillCycleDropDown()
            '   Dim strReturnTable As String = fnDisplayLevelandCycleAgCompany()
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
            itm.Text = dr("CycleName").ToString() & " (" + Convert.ToDateTime(dr("CycleStartDate")).ToString("dd MMM yyyy") & ")"
            itm.Value = dr("CycleId").ToString()
            ddlCycleName.Items.Add(itm)
        Next

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function fnDisplayParticipantAgCycle(ByVal CycleID As Integer) As String
        Dim strTable As New StringBuilder
        Dim strReturnVal As String = 1
        Dim srlNmCntr As Int16 = 1

        Dim objCon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom As New SqlCommand("[spGetParticipantAndManagerListForMapping]", objCon)
        objCom.Parameters.Add("@CycleID", SqlDbType.Int).Value = CycleID

        objCom.CommandTimeout = 0
        objCom.CommandType = CommandType.StoredProcedure

        Dim da As New SqlDataAdapter(objCom)
        Dim ds As New DataSet
        da.Fill(ds)
        strTable.Append("<div id='tblMain' align='center'>")

        If ds.Tables(0).Rows.Count > 0 Then
            strTable.Append("<table class='table table-bordered table-sm text-center' id='tblMain'>")
            strTable.Append("<thead><tr>")
            strTable.Append("<th style='width:8%' class='text-left'>")
            strTable.Append("S. No.")
            strTable.Append("</th>")
            strTable.Append("<th class='text-left'>")
            strTable.Append("Participant Name")
            strTable.Append("</th>")
            strTable.Append("<th class='text-left'>")
            strTable.Append("Participant EmailID")
            strTable.Append("</th>")

            strTable.Append("<th class='text-left'>")
            strTable.Append("Select Manager")
            strTable.Append("</th>")


            strTable.Append("</tr></thead>")

            For Each drParticipant As DataRow In ds.Tables(0).Rows

                strTable.Append("<tr ParticipantNodeID = " & drParticipant.Item("ParticipantID") & " >")
                strTable.Append("<td>")
                strTable.Append(srlNmCntr)
                strTable.Append("</td>")

                strTable.Append("<td class='text-left'>")
                strTable.Append(drParticipant.Item("ParticipantName"))
                strTable.Append("</td>")

                strTable.Append("<td class='text-left'>")
                strTable.Append(drParticipant.Item("ParticipantEmailID"))
                strTable.Append("</td>")

                Dim ddlManager As String = ""
                ddlManager &= "<option value = 0>- Select Manager -</option>"

                For Each MngrNameOptions As DataRow In ds.Tables(1).Rows
                    If MngrNameOptions.Item("ManagerNodeID") = drParticipant.Item("ManagerNodeID") Then
                        ddlManager &= "<option selected value = " & MngrNameOptions.Item("ManagerNodeID") & ">" & MngrNameOptions.Item("FName").ToString() & "-->" & MngrNameOptions.Item("ManagerEmailID").ToString() & "</Option>"
                    Else
                        ddlManager &= "<option value = " & MngrNameOptions.Item("ManagerNodeID") & ">" & MngrNameOptions.Item("FName").ToString() & "-->" & MngrNameOptions.Item("ManagerEmailID").ToString() & "</Option>"
                    End If

                Next MngrNameOptions

                strTable.Append("<td>")
                strTable.Append("<Select id='ddlmanagerList'> " & ddlManager & "</select>")
                strTable.Append("</td>")

                strTable.Append("</tr>")

                srlNmCntr = srlNmCntr + 1
            Next
            strTable.Append("</table>")

        Else
            strTable.Append("<div class='text-danger text-center'>")
            strTable.Append("No Record Found...")
            strTable.Append("</div>")
        End If

        '    strReturnVal = "1@" & HttpContext.Current.Server.HtmlDecode(strTable.ToString)
        strReturnVal = "1~" & strTable.ToString
        Return strReturnVal
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnManageAssessmentParticipantManagerAgCycle(ByVal CycleID As Integer, ByVal objDetails As Object) As String
        Dim strReturn As String = 1
        Dim strReturnFromDb As Integer = 0
        Dim tblManager As New DataTable()
        tblManager.TableName = "tblManager"
        Dim settings As New JsonSerializerSettings()
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore
        Dim strTable As String = JsonConvert.SerializeObject(objDetails, settings.ReferenceLoopHandling)
        tblManager = JsonConvert.DeserializeObject(Of DataTable)(strTable)

        Dim dr As SqlDataReader
        Dim dr1 As SqlDataReader
        Dim Objcon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom1 As New SqlCommand("[spAssessmentManagerMappingWithParticipant]", Objcon)

        objCom1.CommandType = CommandType.StoredProcedure
        objCom1.CommandTimeout = 0
        objCom1.Parameters.Add("@CycleId", SqlDbType.Int).Value = CycleID
        objCom1.Parameters.AddWithValue("@tblManagerParticipant", tblManager)
        Try
            Objcon.Open()
            objCom1.ExecuteNonQuery()
            strReturn = "1~"
        Catch ex As Exception
            strReturn = "2~" & ex.Message
        Finally
            ' dr.Close()
            'dr1.Close()
            objCom1.Dispose()

            Objcon.Close()
            Objcon.Dispose()
        End Try

        Return strReturn
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnGetMappedAssessorListAgCycle() As String
        Dim strTable As New StringBuilder
        Dim strCycleName As New StringBuilder

        Dim strReturnVal As String = 1
        Dim srlNmCntr As Int16 = 1

        Dim objCon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom As New SqlCommand("[spGetMappedAssessorListAgCycle]", objCon)

        objCom.CommandTimeout = 0
        objCom.CommandType = CommandType.StoredProcedure

        Dim dr As SqlDataReader
        objCon.Open()
        dr = objCom.ExecuteReader()

        strTable.Append("<div id='tblMain' align='center'>")

        If dr.HasRows Then
            strTable.Append("<table class='table table-bordered table-sm text-center'>")
            strTable.Append("<thead><tr>")
            strTable.Append("<th style='width:25%'>")
            strTable.Append("Assessor Name")
            strTable.Append("</th>")
            strTable.Append("<th class='text-left'>")
            strTable.Append("Batch Count")
            strTable.Append("</th>")

            strTable.Append("</tr></thead>")

            While dr.Read

                strTable.Append("<tr>")
                strTable.Append("<td>")
                strTable.Append(dr.Item("AssessorName"))
                strTable.Append("</td>")

                strTable.Append("<td class='text-left' assessorid= " & dr.Item("AssessorID") & "><a href='###' onclick = fnShowCycleName(" & dr.Item("AssessorID") & ")>")
                strTable.Append(dr.Item("CountOfCycleID"))
                strTable.Append("</a></td>")

                strTable.Append("</tr>")

                srlNmCntr = srlNmCntr + 1
            End While
            strTable.Append("</table>")

            dr.NextResult()

            strCycleName.Append("<table class='table table-bordered table-sm text-center' id='tblCycleName'>")

            While dr.Read
                strCycleName.Append("<tr AssessorID = " & dr.Item("AssessorID") & ">")
                strCycleName.Append("<td>")
                strCycleName.Append(dr.Item("CycleName") & "--->" & Convert.ToDateTime(dr("CycleStartDate")).ToString("dd MMM yy"))
                strCycleName.Append("</td>")
                strCycleName.Append("</tr>")
            End While
            strCycleName.Append("</table>")

        Else
            strTable.Append("<div class='text-danger text-center'>")
            strTable.Append("No Record Found...")
            strTable.Append("</div>")
        End If

        '    strReturnVal = "1@" & HttpContext.Current.Server.HtmlDecode(strTable.ToString)
        strReturnVal = "1@" & strTable.ToString & "@" & strCycleName.ToString
        Return strReturnVal
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnSendMailToAssessor(ByVal CycleID As Integer, ByVal AssesorNodeID As Integer, ByVal MailTo As String, ByVal UserName As String, ByVal Pwd As String, ByVal BEIUserName As String, ByVal BEIPwd As String, ByVal SelectedDate As String, ByVal SecondaryEmailID As String) As String
        Dim strcon As String
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim strReturn As String = ""
        Dim flgActualUser As Integer = System.Configuration.ConfigurationManager.AppSettings("flgActualUser")
        Dim fromMail As String = System.Configuration.ConfigurationManager.AppSettings("MailUser")
        If flgActualUser = 2 Then
            MailTo = System.Configuration.ConfigurationManager.AppSettings("MailTo")
        End If

        Dim smtpMail As SmtpClient
        Dim objMail As MailMessage
        Dim strMail As String = ""
        strMail = "<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>"
        strMail &= "<p>Dear Developer,</p>"
        strMail &= "<p>This is to inform you have been nominated as the Developer for DC-1 scheduled on <b>" & SelectedDate & "</b>.</p>"

        strMail &= "<p>Please find below the login details. These login details will remain valid throughout the course of DC-1.</p>"
        strMail &= "<p><b>Link : </b><a href=https://www.ey-virtualsolutions.com/LT_DevelopmentCentre/DC1//> https://www.ey-virtualsolutions.com/LT_DevelopmentCentre/DC1/ </a></p>"
        strMail &= "<p>Your credentials for accessing EY Platform:</p>"
        strMail &= "<p><b>User Name :</b> " & UserName & "</p>"
        strMail &= "<p><b>Password :</b> " & Pwd & "</p><br>"

        strMail &= "<p>Your credentials for accessing GoToMeetings: (This feature is built within the EY Platform. You can use these credentials whenever you are asked to Sign-in during BEI and Feedback sessions)</p>"

        strMail &= "<p><b>User Name :</b> " & BEIUserName & "</p>"
        strMail &= "<p><b>Password :</b> " & BEIPwd & "</p><br>"

        strMail &= "<p> You can login on the day of the DC to</p>"
        strMail &= "<p>1. Schedule BEI of participants mapped to you <br/>2. Evaluate Case Study responses based on cues <br/>3. Conduct BEI and rate cues</p>"
        strMail &= "<p>Post completion of the above steps, you can login on the next day to:</p>"
        strMail &= "<p>1. View automated report <br/>2. Update the status of feedback session conducted with the participant <br/>3. Document and submit Pen-picture of the participants</p>"
        strMail &= "<p>We wish you all the best!</p>"

        strMail &= "<p><i>Note: This is a system generated email. Do not reply directly to this email.<i/></p>"
        strMail &= "</fONT>"

        '//////////////End Of EY Welcome Mail/////////////////////////////////////////

        objMail = New MailMessage

        objMail.From = New MailAddress("LTAssessment<" & fromMail & ">")

        objMail.Subject = "Invitation Mail For Assessment"

        objMail.Headers.Add("X-MC-Track", "noopens,noclicks")
        objMail.IsBodyHtml = True
        objMail.Body = strMail.ToString
        smtpMail = New SmtpClient()
        smtpMail.Host = System.Configuration.ConfigurationManager.AppSettings("MailServer")
        smtpMail.Port = 587
        Dim loginInfo As NetworkCredential
        loginInfo = New NetworkCredential()
        loginInfo.UserName = System.Configuration.ConfigurationManager.AppSettings("MailUser")
        loginInfo.Password = System.Configuration.ConfigurationManager.AppSettings("MailPassword")
        smtpMail.UseDefaultCredentials = False
        smtpMail.Credentials = loginInfo
        smtpMail.EnableSsl = True
        ' ServicePointManager.ServerCertificateValidationCallback = Function(s As Object, certificate As X509Certificate, chain As X509Chain, sslPolicyErrors As SslPolicyErrors) True

        objMail.To.Add(MailTo)
        objMail.CC.Add(SecondaryEmailID)

        Try

            smtpMail.Send(objMail)

            strcon = ConfigurationManager.ConnectionStrings("strConn").ToString()
            con = New SqlConnection(strcon)
            cmd = New SqlCommand()

            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.CommandText = "spMailUpdateLog"
            cmd.Parameters.AddWithValue("@CycleId", CycleID)
            cmd.Parameters.AddWithValue("@EmpNodeID", AssesorNodeID)
            cmd.Parameters.AddWithValue("@MailType", 2)
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()
            strReturn = "1~"

        Catch ex As Exception
            strcon = ConfigurationManager.ConnectionStrings("strConn").ToString()
            con = New SqlConnection(strcon)
            cmd = New SqlCommand()

            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.CommandText = "spMailExceptionLog"
            cmd.Parameters.AddWithValue("@CycleId", CycleID)
            cmd.Parameters.AddWithValue("@EmpNodeID", AssesorNodeID)
            cmd.Parameters.AddWithValue("@Error", ex.Message)
            cmd.Connection = con
            con.Open()
            cmd.ExecuteNonQuery()
            strReturn = "2~"
        Finally
            cmd.Dispose()
            con.Close()
        End Try
        Return strReturn
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function fnCheckMappedUsersAgCycle(ByVal EmpNodeID As Integer, ByVal CycleID As Integer) As String
        Dim strReturn As String = 1

        Dim LoginId As Integer
        LoginId = HttpContext.Current.Session("LoginId")
        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spCheckAssessorMapping]", Objcon2)
        objCom2.Parameters.Add("@AssessorNodeID", SqlDbType.Int).Value = EmpNodeID
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
    Public Shared Function fnDeleteAssessor(ByVal EmpNodeID As Integer, ByVal CycleID As Integer) As String
        Dim strReturn As String = 1

        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spDeleteAssessorMapping]", Objcon2)
        objCom2.Parameters.Add("@AssessorID", SqlDbType.Int).Value = EmpNodeID
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
