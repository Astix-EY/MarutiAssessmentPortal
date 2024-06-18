Imports System.Data.SqlClient
Imports System.IO
Imports System.Data
Imports System.Net
Imports System.Net.Mail
Imports System.Net.Mime
Imports System.Security.Cryptography.X509Certificates
Imports System.Net.Security
Imports System.Text
Partial Class frmKnowledgeQuestions
    Inherits System.Web.UI.Page
    Dim arrPara(0, 1) As String
    Dim RspId As Integer
    Dim PgNmbr As Integer
    Dim Direction As Integer
    Dim intColorCount As Integer
    Dim ExerciseID As Integer = 0
    Dim BandID As Integer = 0
    Dim ExerciseType As Integer = 0

    Dim objCon As SqlConnection
    Dim objCom As SqlCommand
    Dim objADO As New clsConnection.clsConnection
    Public TimeAllotedSec As Integer = 0
    Dim IndustryID As Integer = 0

    'Dim IndustryLevelMapId As Integer = 0
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load

        hdnRspID.Value = 100 ' IIf(IsNothing(Request.QueryString("RspId")), 0, Request.QueryString("RspId"))

        CreateDynamicSlider_Div(hdnRspID.Value)

    End Sub
    Sub CreateDynamicSlider_Div(ByVal RspID As Integer)
        '  LoginId = HttpContext.Current.Session("LoginId")
        Dim arrPara(2, 1) As String
        arrPara(0, 0) = RspID
        arrPara(0, 1) = "0"

        arrPara(1, 0) = 1
        arrPara(1, 1) = "0"

        arrPara(2, 0) = 0
        arrPara(2, 1) = "0"


        Dim objCon As New SqlConnection
        Dim objcom As New SqlCommand
        objcom.CommandTimeout = 0
        Dim dr As SqlDataReader
        Dim Cntr As Integer = 0
        Dim objAdo As New SqlConnection(ConfigurationManager.AppSettings("strConn"))
        Dim cmd As New SqlCommand("spRspGetFeedbackQst", objAdo)
        cmd.Parameters.AddWithValue("@RspId", RspID)
        cmd.Parameters.AddWithValue("@PgNmbr", 1)
        cmd.Parameters.AddWithValue("@Direction", 0)
        cmd.CommandType = CommandType.StoredProcedure
        Dim da As New SqlDataAdapter(cmd)
        Dim ds As New DataSet
        da.Fill(ds)
        Dim cntRow As Integer = 1

        For Each row As DataRow In ds.Tables(1).Rows
            Dim GroupId = row.Item("GroupId")
            Dim GroupName = row.Item("GroupName")
            Dim DivGroup = New Panel
            DivGroup.Attributes.Add("class", "ques-group")
            Dim h1 As New HtmlGenericControl
            h1.Attributes.Add("class", "ques-title")
            h1.InnerHtml = GroupName & "<br/><span class='ques-subtitle'>Please rate yourself on the following Knowledge/Skill applicable to your role:</span>"
            DivGroup.Controls.Add(h1)

            Dim cntCell As Integer = 1
            For Each row1 As DataRow In ds.Tables(0).Select("GroupID=" & GroupId)
                Dim DivQstn = New Panel
                DivQstn.Attributes.Add("class", "bd-callout bd-callout-info")
                Dim tblQstn As New HtmlTable
                tblQstn.Attributes.Add("class", "table-status")
                DivQstn.Controls.Add(tblQstn)
                Dim tRowQstn As New HtmlTableRow

                tRowQstn.Attributes.Add("RspDetID", row1.Item("RspDetId"))
                tRowQstn.ID = "Tr" & row1.Item("RspDetId")
                tblQstn.Controls.Add(tRowQstn)

                Dim tCellQstn As New HtmlTableCell
                tRowQstn.Controls.Add(tCellQstn)

                tCellQstn.Attributes.Add("class", "text-left")
                tCellQstn.InnerHtml = "<p>" & row1.Item("QstnHdrTxt") & "</p>"

                Dim TdSlider As New HtmlTableCell
                TdSlider.Style.Add("width", "50%")
                Dim txtSliderCurrent As New TextBox
                Dim ScriptManagerCrnt As ScriptManager = Page.Master.FindControl("ScriptManager1")
                ScriptManagerCrnt.RegisterAsyncPostBackControl(txtSliderCurrent)

                Dim extSliderCurrent As New AjaxControlToolkit.SliderExtender
                Dim pagePanelsCurrent As New Panel

                ' txtSliderCurrent.ID = "slider" & cntRow & "_" & cntCell
                txtSliderCurrent.ID = "slider" & row1.Item("RspDetId")

                If row1.Item("RsltVal") <> "0" Then
                    txtSliderCurrent.Text = row1.Item("RsltVal")
                End If
                'txtSliderCurrent.Text = 0

                TdSlider.Controls.Add(txtSliderCurrent)

                extSliderCurrent.ID = "extSlider" & row1.Item("QstID")
                'extSliderCurrent.BehaviorID = txtSliderCurrent.ID & "~" & row1.Item("RspDetId")
                extSliderCurrent.BehaviorID = txtSliderCurrent.ID

                extSliderCurrent.TargetControlID = txtSliderCurrent.ID

                extSliderCurrent.HandleCssClass = "ajax_slider_h_handle"

                extSliderCurrent.HandleImageUrl = "../../Images/h_handle.png"
                If row1.Item("RsltVal") = 0 Then
                    extSliderCurrent.RailCssClass = "ajax_slider_h_rail_0 sliderwidth"
                ElseIf row1.Item("RsltVal") = 1 Then
                    extSliderCurrent.RailCssClass = "ajax_slider_h_rail_1 sliderwidth"
                    extSliderCurrent.TooltipText = "Basic Knowledge"
                ElseIf row1.Item("RsltVal") = 2 Then
                    extSliderCurrent.RailCssClass = "ajax_slider_h_rail_2 sliderwidth"
                    extSliderCurrent.TooltipText = "Working Knowledge"
                ElseIf row1.Item("RsltVal") = 3 Then
                    extSliderCurrent.RailCssClass = "ajax_slider_h_rail_3 sliderwidth"
                    extSliderCurrent.TooltipText = "Extensive Experience"
                ElseIf row1.Item("RsltVal") = 4 Then
                    extSliderCurrent.RailCssClass = "ajax_slider_h_rail_4 sliderwidth"
                    extSliderCurrent.TooltipText = "Expert"

                End If

                extSliderCurrent.Orientation = Orientation.Horizontal
                extSliderCurrent.Minimum = 0

                extSliderCurrent.Maximum = 4
                extSliderCurrent.Steps = 5
                'extSliderCurrent.Length = 450

                extSliderCurrent.EnableHandleAnimation = True
                'extSliderCurrent.RaiseChangeOnlyOnMouseUp = True

                TdSlider.Controls.Add(extSliderCurrent)

                tRowQstn.Controls.Add(TdSlider)
                DivGroup.Controls.Add(DivQstn)
                cntCell = cntCell + 1
            Next row1
            divMainContainer.Controls.Add(DivGroup)
            cntRow = cntRow + 1
        Next row

        '    If dr.HasRows Then


        '    mainDv.Attributes.Add("class", "clearfix")
        '    Dim DivGroup As HtmlGenericControl

        '    While dr.Read
        '        Cntr = Cntr + 1

        '        Dim DivRow As New HtmlGenericControl
        '        DivRow.Attributes.Add("class", "row mb-3")
        '        DivRow.Attributes.Add("RspDetID", dr.Item("RspDetId"))
        '        DivRow.ID = "Tr" & Cntr
        '        ' dvSurvey.InnerText = drdr.Item("QstnHdrTxt")
        '        Dim MainTDQstn As New HtmlGenericControl
        '        MainTDQstn.Attributes.Add("class", "col-md-4")
        '        MainTDQstn.InnerHtml = dr.Item("QstnHdrTxt")
        '        DivRow.Controls.Add(MainTDQstn)

        '        Dim TdSlider As New HtmlGenericControl
        '        TdSlider.Attributes.Add("class", "col-md-8")

        '        Dim txtSliderCurrent As New TextBox
        '        Dim ScriptManagerCrnt As ScriptManager = Page.Master.FindControl("ScriptManager1")
        '        ScriptManagerCrnt.RegisterAsyncPostBackControl(txtSliderCurrent)

        '        Dim extSliderCurrent As New AjaxControlToolkit.SliderExtender
        '        Dim pagePanelsCurrent As New Panel

        '        txtSliderCurrent.ID = "slider" & Cntr

        '        If dr.Item("RsltVal") <> "0" Then
        '            txtSliderCurrent.Text = dr.Item("RsltVal")
        '        End If
        '        'txtSliderCurrent.Text = 0

        '        TdSlider.Controls.Add(txtSliderCurrent)

        '        extSliderCurrent.ID = "extSlider" & dr.Item("QstID")
        '        extSliderCurrent.BehaviorID = txtSliderCurrent.ID & "~" & dr.Item("RspDetId")

        '        extSliderCurrent.TargetControlID = txtSliderCurrent.ID

        '        extSliderCurrent.HandleCssClass = "ajax_slider_h_handle"

        '        extSliderCurrent.HandleImageUrl = "../../Images/h_handle.png"
        '        If dr.Item("RsltVal") = 0 Then
        '            extSliderCurrent.RailCssClass = "ajax_slider_h_rail_0 sliderwidth"
        '        ElseIf dr.Item("RsltVal") = 1 Then
        '            extSliderCurrent.RailCssClass = "ajax_slider_h_rail_1 sliderwidth"
        '            extSliderCurrent.TooltipText = "B"
        '        ElseIf dr.Item("RsltVal") = 2 Then
        '            extSliderCurrent.RailCssClass = "ajax_slider_h_rail_2 sliderwidth"
        '            extSliderCurrent.TooltipText = "W"
        '        ElseIf dr.Item("RsltVal") = 3 Then
        '            extSliderCurrent.RailCssClass = "ajax_slider_h_rail_3 sliderwidth"
        '            extSliderCurrent.TooltipText = "EE"
        '        ElseIf dr.Item("RsltVal") = 4 Then
        '            extSliderCurrent.RailCssClass = "ajax_slider_h_rail_4 sliderwidth"
        '            extSliderCurrent.TooltipText = "E"

        '        End If

        '        extSliderCurrent.Orientation = Orientation.Horizontal
        '        extSliderCurrent.Minimum = 0
        '        extSliderCurrent.Maximum = 4
        '        extSliderCurrent.Steps = 5
        '        'extSliderCurrent.Length = 450

        '        extSliderCurrent.EnableHandleAnimation = True
        '        'extSliderCurrent.RaiseChangeOnlyOnMouseUp = True

        '        TdSlider.Controls.Add(extSliderCurrent)

        '        DivRow.Controls.Add(TdSlider)

        '        hdnPageNmbr.Value = dr.Item("PgNmbr")

        '        mainDv.Controls.Add(DivRow)
        '        OldGrp = dr.Item("GroupID")
        '        '  dvPgNmbr.InnerText = "Page Number = " & dr.Item("PgNmbr") & "/4"
        '    End While
        '    dr.Close()
        'End If

        hdnNoOfQuestions.Value = cntRow
        'dvSurvey.Controls.Add(mainDv)


    End Sub

    Private Sub btnSaveASP_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveASP.Click

        Dim Objcon2 As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom2 As New SqlCommand("[spManageFeedbackResponses]", Objcon2)
        objCom2.Parameters.Add("@RspID", SqlDbType.Int).Value = hdnRspID.Value
        objCom2.Parameters.Add("@RespStr", SqlDbType.NVarChar).Value = hdnResult.Value
        objCom2.Parameters.Add("@TypeID", SqlDbType.NVarChar).Value = 1

        objCom2.CommandType = CommandType.StoredProcedure
        objCom2.CommandTimeout = 0
        Dim strReturn As Integer
        Try
            Objcon2.Open()
            objCom2.ExecuteNonQuery()

        Catch ex As Exception
            strReturn = "2^" & ex.Message
        Finally
            objCom2.Dispose()
            Objcon2.Close()
            Objcon2.Dispose()
        End Try

        '   Response.Redirect("../Common/frmThanks.aspx")
        fnSendMailtoManager(hdnRspID.Value)

    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function fnUpdateTime(ByVal ExerciseID As Integer) As String
        Dim ObjclassUsedForExerciseSave As New classUsedForExerciseSave
        ObjclassUsedForExerciseSave.SpUpdateElaspedTime(ExerciseID)
        Return "0"
    End Function

    Public Shared Function fnSendMailtoManager(ByVal RspID As Integer) As String



        Dim strMail As New StringBuilder
        strMail.Append("<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>")
        strMail.Append("<p>Dear << Manager Name >></p>")
        strMail.Append("<p>Congratulations for your participation in the Axiata FastForward initiative. Axiata FastForward has been conceptualized to cater to the development needs of employees in different business functions through academies.  </p>")
        strMail.Append("<p>As a part of the Enterprise Academy, <participant first name> <last name>, has been selected to undergo a learning journey. You play a critical role in this journey as his/her manager. In order to help understand the current skill profile of <participant first name>, you have to take a survey evaluating her/him on technical skills and competencies. The survey will not take you more than 20 mins and comprises of 33 areas across which the rating has to be provided. </p>")
        strMail.Append("<p>The scale for rating is:</p>")
        strMail.Append("<p>-Basic Knowledge (B)</p>")
        strMail.Append("<p>-Working Knowledge (W)</p>")
        strMail.Append("<p>-Extensive Experience (EE)</p>")
        strMail.Append("<p>-Expert (E)</p>")
        strMail.Append("<p>Provided below is the link to the online survey and your user credentials:</p>")
        strMail.Append("<p>Link : </p>")
        strMail.Append("<p>EmailID : </p>")
        strMail.Append("<p>Password : </p>")
        strMail.Append("<p>Guidelines for taking the survey are:</p>")
        strMail.Append("<p>•	Finish the survey in one go within 5 days of receiving this mail<br>•	Provide candid feedback considering a holistic view of your professional interactions with him/her<br>•	Provide feedback from a developmental perspective<br>•	Think and respond carefully to every area<br>•	Do not base your feedback on a recent experience/interaction/personal relationship<br>•	Avoid evaluating individuals as you view their performance</p>")

        strMail.Append("<p>The success of this initiative and the richness of each participant`s feedback rests on your whole-hearted participation. We urge you to use fair judgement while providing ratings.</p>")
        strMail.Append("<p>We appreciate and thank you for your time and effort.</p>")
        strMail.Append("<p>Regards,</p>")
        strMail.Append("<p><b>Team EY</b></p>")
        strMail.Append("</FONT>")
        Dim strReturn As String
        Dim objMail As New MailMessage()
        Dim smtpMail As SmtpClient
        objMail = New MailMessage
        Dim FromEmailID As String = System.Configuration.ConfigurationManager.AppSettings("MailFrom")

        objMail.From = New MailAddress("AxiatForward<" & FromEmailID & ">")
        objMail.Subject = "Manager Invitation Mail"
        objMail.IsBodyHtml = True
        objMail.Body = strMail.ToString
        smtpMail = New SmtpClient()
        smtpMail.Host = System.Configuration.ConfigurationManager.AppSettings("smtpClient")
        smtpMail.Port = 587 '25
        Dim loginInfo As NetworkCredential
        loginInfo = New NetworkCredential()
        loginInfo.UserName = System.Configuration.ConfigurationManager.AppSettings("sUser")
        loginInfo.Password = System.Configuration.ConfigurationManager.AppSettings("sPassword")
        smtpMail.UseDefaultCredentials = False
        smtpMail.Credentials = loginInfo
        smtpMail.EnableSsl = True
        'smtpMail.EnableSsl = False
        ServicePointManager.ServerCertificateValidationCallback = Function(s As Object, certificate As X509Certificate, chain As X509Chain, sslPolicyErrors As SslPolicyErrors) True
        Dim ManagerEmailID As String = System.Configuration.ConfigurationManager.AppSettings("ManagerEmailID")

        Dim Objcon As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("strConn"))
        Dim objCom As New SqlCommand("[spMailUpdateLog]", Objcon)
        Try
            objMail.To.Add(ManagerEmailID)
            objMail.Bcc.Add("jyoti@astixsolutions.com")
            smtpMail.Send(objMail)
            Objcon.Open()

            'objCom.CommandType = Data.CommandType.StoredProcedure
            'objCom.CommandText = "spMailUpdateLog"
            'objCom.Parameters.AddWithValue("@EmpNodeID", EmpID)
            'objCom.Parameters.AddWithValue("@MailType", 1)

            objCom.Connection = Objcon
            objCom.ExecuteNonQuery()
            Objcon.Close()
            strReturn = "1^"
        Catch ex As Exception
            strReturn = "2^" & ex.Message
        Finally
            objCom.Dispose()
            Objcon.Close()
            Objcon.Dispose()
        End Try
        Return strReturn

    End Function
End Class
