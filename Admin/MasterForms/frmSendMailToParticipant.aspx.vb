Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Imports Newtonsoft.Json
Imports System.Net
Imports System.Net.Mail
Imports System.Net.Mime
Imports System.Security.Cryptography.X509Certificates
Partial Class Admin_MasterForms_frmSendMailToParticipant
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
        itm.Text = "- Batch Name -"
        itm.Value = "0"
        ddlCycleName.Items.Add(itm)

        For Each dr As DataRow In dt.Rows
            itm = New ListItem()
            itm.Text = dr("CycleName").ToString() & " (" + Convert.ToDateTime(dr("CycleStartDate")).ToString("dd MMM yy") & ")"
            itm.Value = dr("CycleId").ToString()
            ddlCycleName.Items.Add(itm)
        Next
    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function fnGetParticpantAgCycle(ByVal CycleID As Integer) As String
        Dim strTable As New StringBuilder
        Dim strReturnVal As String = 1
        Dim srlNmCntr As Int16 = 1

        Dim objCon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom As New SqlCommand("[spMailGetParticipantList]", objCon)
        objCom.Parameters.Add("@CycleID", SqlDbType.Int).Value = CycleID


        objCom.CommandTimeout = 0
        objCom.CommandType = CommandType.StoredProcedure

        Dim dr As SqlDataReader
        objCon.Open()
        dr = objCom.ExecuteReader()

        If dr.HasRows Then
            strTable.Append("<div id='dvtblbody'><table class='table table-bordered table-sm text-center' id='tblEmp'>")
            strTable.Append("<thead><tr>")
            strTable.Append("<th style='width:8%'>")
            strTable.Append("S. No.")
            strTable.Append("</th>")
            strTable.Append("<th>")
            strTable.Append("Participant Name")
            strTable.Append("</th>")

            strTable.Append("<th>")
            strTable.Append("Participant EmailID")
            strTable.Append("</th>")


            strTable.Append("<th style='width:10%'>")
            strTable.Append("Action")
            strTable.Append("</th>")
            strTable.Append("</tr></thead>")
            strTable.Append("<tbody>")

            While dr.Read

                strTable.Append("<tr flgactive = 1>")
                strTable.Append("<td>")
                strTable.Append(srlNmCntr)
                strTable.Append("</td>")

                strTable.Append("<td>")
                strTable.Append(dr.Item("FullName"))
                strTable.Append("</td>")


                strTable.Append("<td>")
                strTable.Append(dr.Item("EmailId"))
                strTable.Append("</td>")


                strTable.Append("<td>")

                strTable.Append("<input type=checkbox   Fname =  '" & dr.Item("FirstName") & "'   ParticipantID = '" & dr.Item("EmpNodeID") & "' ParticipantEmailID = '" & dr.Item("EmailId") & "'>")

                strTable.Append("</td>")
                strTable.Append("</tr>")
                srlNmCntr = srlNmCntr + 1

            End While
            strTable.Append("</tbody>")
            strTable.Append("</table></div>")

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
    Public Shared Function fnSendMailToParticipantAgCycle(ByVal CycleID As Integer, ByVal objDetails As Object) As String
        Dim strReturn As String = ""

        Dim tblParticipant As New DataTable()
        tblParticipant.TableName = "tblParticipant"
        Dim settings As New JsonSerializerSettings()
        settings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore
        Dim strTable As String = JsonConvert.SerializeObject(objDetails, settings.ReferenceLoopHandling)
        tblParticipant = JsonConvert.DeserializeObject(Of DataTable)(strTable)
        Dim ParticipantNodeID As Integer
        Dim EmailID As String
        Dim FName As String


        Dim DT As DateTime
        For Each rows In tblParticipant.Rows

            ParticipantNodeID = rows("ParticipantID").ToString
            EmailID = rows("ParticipantEmailID").ToString
            FName = rows("Fname").ToString


            Dim startDate As DateTime = Convert.ToDateTime("2020-05-21 14:30") ' rows("MeetingStartTime").ToString()
            Dim startDate1 = startDate.ToString("yyyy-MM-dd hh:mm:ss tt")

            Dim endDate As DateTime = Convert.ToDateTime("2020-05-21 16:30") ' rows("MeetingEndTime").ToString()
            Dim endDate1 = endDate.ToString("yyyy-MM-dd hh:mm:ss tt")

            strReturn = fnSendMailToParticipant(CycleID, ParticipantNodeID, EmailID, FName, startDate1, endDate1)
        Next

        Return strReturn
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function fnSendMailToParticipant(ByVal CycleID As Integer, ByVal ParticipantNodeID As Integer, ByVal MailTo As String, ByVal FName As String, ByVal Startdate As String, ByVal EndDate As String) As String
        Dim strcon As String
        Dim con As SqlConnection
        Dim cmd As SqlCommand
        Dim strReturn As String = ""
        Dim flgActualUser As Integer = System.Configuration.ConfigurationManager.AppSettings("flgActualUser")
        Dim FromEmailID As String = System.Configuration.ConfigurationManager.AppSettings("FromAddress")
        If flgActualUser = 2 Then
            MailTo = System.Configuration.ConfigurationManager.AppSettings("MailTo")
        End If

        Dim smtpMail As SmtpClient
        Dim objMailMsg As MailMessage
        Dim strMail As String = ""
        strMail = "<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>"
        strMail &= "<p>Dear " & FName & ",</p>"
        strMail &= "<p>We are blocking your time for the scheduled <b>Enterprise Academy – Capability Development Inventory (CDI).</b> </p>"
        strMail &= "<p>Please accept the invite immediately, no rescheduling will be allowed. </p>"
        strMail &= "<p><b>Before your CDI session:</b></p>"
        strMail &= "<p>•	Check that you have received your login credentials email from Fuse and Spotmentor<br>•	Go through the CDI background information – <u>available on Fuse > Spotmentor</u> (no softcopy materials will be emailed)</p>"
        strMail &= "<p><b>Day of CDI session:</b> </p>"
        strMail &= "<p>•	Be present on the specific date and time<br>•	Please DO NOT login into CDI before your scheduled time. If you login earlier, the timer will start ticking and this will impact your CDI process<br>•	The entire CDI needs to be completed in one sitting. A 10 minute break will be allocated in between task 2 and task 3</p>"
        strMail &= "<p>Please contact <a href=mailto:techsupport@axiatafastforward.com>techsupport@axiatafastforward.com</a> should you run into any difficulties. </p>"
        strMail &= "<p><i><b>Let’s FastForward to a sustainable future, together!</b><i/></p>"
        strMail &= "</FONT>"

        '//////////////End Of EY Welcome Mail/////////////////////////////////////////

        objMailMsg = New MailMessage
        objMailMsg.To.Add("jyoti@astixsolutions.com,mukhtyar@astixsolutions.com,alok@astixsolutions.com")
        objMailMsg.From = New MailAddress("AxiataFastForward<" & FromEmailID & ">")

        objMailMsg.Subject = "Axiata FastForward Enterprise Academy | Scheduled CDI slot"

        '  objMailMsg.Headers.Add("X-MC-Track", "noopens,noclicks")
        objMailMsg.IsBodyHtml = True

        Dim HTMLType As System.Net.Mime.ContentType = New System.Net.Mime.ContentType("text/html")
        Dim avCal As AlternateView = AlternateView.CreateAlternateViewFromString(strMail.ToString(), HTMLType)
        objMailMsg.AlternateViews.Add(avCal)


        Dim str As New StringBuilder
        str.AppendLine("BEGIN:VCALENDAR")
        str.AppendLine("PRODID:Meeting1")
        str.AppendLine("VERSION:2.0")
        str.AppendLine("METHOD:REQUEST")
        str.AppendLine("BEGIN:VEVENT")

        Dim dtStartTime As DateTime = Convert.ToDateTime(Startdate)
        Dim dtEndTime As DateTime = Convert.ToDateTime(EndDate)

        str.AppendLine(String.Format("DTSTART:{0:yyyyMMddTHHmmss}", dtStartTime.ToUniversalTime().ToString("yyyyMMdd\\THHmmss\\Z")))
        str.AppendLine(String.Format("DTSTAMP:{0:yyyyMMddTHHmmss}", DateTime.Now))
        str.AppendLine(String.Format("DTEND:{0:yyyyMMddHHmmss}", dtEndTime.ToUniversalTime().ToString("yyyyMMdd\\THHmmss\\Z")))
        str.AppendLine("LOCATION: " + objMailMsg.From.Address)
        str.AppendLine(String.Format("UID:{0}", Guid.NewGuid()))
        str.AppendLine(String.Format("DESCRIPTION:{0}", strMail.ToString()))
        str.AppendLine(String.Format("X-ALT-DESC;FMTTYPE=text/html:{0}", strMail.ToString()))
        str.AppendLine(String.Format("SUMMARY:{0}", objMailMsg.Subject))
        str.AppendLine(String.Format("ORGANIZER:MAILTO:{0}", objMailMsg.From.Address))
        str.AppendLine(String.Format("ATTENDEE;CN=""{0}"";RSVP=TRUE:mailto:{1}", objMailMsg.To(0).DisplayName, objMailMsg.To(0).Address))

        str.AppendLine("BEGIN:VALARM")
        str.AppendLine("TRIGGER:-PT15M")
        str.AppendLine("ACTION:DISPLAY")
        str.AppendLine("DESCRIPTION:Reminder")
        str.AppendLine("END:VALARM")
        str.AppendLine("END:VEVENT")
        str.AppendLine("END:VCALENDAR")

        Dim ContentType As System.Net.Mime.ContentType = New System.Net.Mime.ContentType("text/calendar")
        ContentType.Parameters.Add("method", "REQUEST")
        ContentType.Parameters.Add("name", "Meeting.ics")

        Dim avCal1 As AlternateView = AlternateView.CreateAlternateViewFromString(str.ToString(), ContentType)
        objMailMsg.AlternateViews.Add(avCal1)

        ' objMail.Body = strMail.ToString
        smtpMail = New SmtpClient()
        smtpMail.Host = System.Configuration.ConfigurationManager.AppSettings("MailServer")
        smtpMail.Port = System.Configuration.ConfigurationManager.AppSettings("PortNo")
        Dim loginInfo As NetworkCredential
        loginInfo = New NetworkCredential()
        loginInfo.UserName = System.Configuration.ConfigurationManager.AppSettings("MailUser")
        loginInfo.Password = System.Configuration.ConfigurationManager.AppSettings("MailPassword")
        smtpMail.UseDefaultCredentials = False
        smtpMail.Credentials = loginInfo
        smtpMail.EnableSsl = True
        ' ServicePointManager.ServerCertificateValidationCallback = Function(s As Object, certificate As X509Certificate, chain As X509Chain, sslPolicyErrors As SslPolicyErrors) True
        'objMailMsg.To.Add(MailTo)

        Try

            smtpMail.Send(objMailMsg)

            strcon = ConfigurationManager.ConnectionStrings("strConn").ToString()
            con = New SqlConnection(strcon)
            cmd = New SqlCommand()

            cmd.CommandType = Data.CommandType.StoredProcedure
            cmd.CommandText = "spMailUpdateLog"
            cmd.Parameters.AddWithValue("@CycleId", CycleID)
            cmd.Parameters.AddWithValue("@EmpNodeID", ParticipantNodeID)
            cmd.Parameters.AddWithValue("@MailType", 1)
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
            cmd.Parameters.AddWithValue("@EmpNodeID", ParticipantNodeID)
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
End Class
