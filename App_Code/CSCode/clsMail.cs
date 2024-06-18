using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Configuration;
using System.IO;
using ClosedXML.Excel;
using System.Data;

/// <summary>
/// Summary description for clsSendLogMail
/// </summary>
public class clsMail
{
    // 
    //private static Hashtable _simpleTable;
    public clsMail()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public static string SendMail(string userId, string testName, string status, string username, string band, string email, string mobile)
    {
        string result = "";
        try
        {
            StringBuilder mailString = new StringBuilder();

            MailMessage objmail = new MailMessage();
            objmail = new System.Net.Mail.MailMessage();

            objmail.Subject = ConfigurationSettings.AppSettings["MailTitle"] + " - " + testName;
            mailString.Append("<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>");

            mailString.Append("<p>Dear Pearson representative,</p>");
            mailString.Append("<p>We are happy to partner with you for conducting these assessments. As a part of this association, we request your help in updating the completion status of exercises for the user.</p>");
            mailString.Append("<p>The user with the below information has self-declared that he/she has completed the below mentioned test within Pearson environment. </p>");
             mailString.Append("<p>We request you to please <b><u>urgently</u></b> validate the below details (particularly the User Code and completion status).</p>");

             mailString.Append("<p>");
            mailString.Append("User Code: " + userId);
            mailString.Append("<br />Test name: " + testName);
            mailString.Append("<br />Completion status: " + status);
            //mailString.Append("<br />User’s name: " + username);
            //mailString.Append("<br />User’s band: " + band);
            //mailString.Append("<br />User’s email: " + email);
            //mailString.Append("<br />User’s mobile: " + mobile);
            mailString.Append("</p>");

            mailString.Append("<p>");
            mailString.Append("For validating the above mentioned details, please refer the below instructions:");
            mailString.Append("<p>");
            mailString.Append("<ol>");
            mailString.Append("<li>Click on this link <a href='"+ ConfigurationSettings.AppSettings["PearsonAdminLink"] + "'>"+ ConfigurationSettings.AppSettings["PearsonAdminLink"] + "</a> or paste this in a browser.</li>");
            mailString.Append("<li>You will see the user codes listed (in 1<sup>st</sup> column from left). You will also see two buttons “Mark complete” for SOSIE (in 2<sup>nd</sup> column) and for RAVENs (in 3<sup>rd</sup> column) against each user code. Please click on the appropriate button as per the test completed.</li>");
            mailString.Append("<li>Please understand that clicking on button “Mark complete” will immediately notify Astix team and EY team that the user has completed the corresponding test. This will also be reflected in their Virtual Assessment Centre. Hence, <b><u>this is an urgent action required from Pearson.</u></b></li>");
            mailString.Append("</ol>");
            mailString.Append("</p>");
            mailString.Append("</p>");

            mailString.Append("<p>Please contact Astix support at <a href='mailto:"+ ConfigurationSettings.AppSettings["SupportMail"] + "'>" + ConfigurationSettings.AppSettings["SupportMail"] + "</a> or "+ ConfigurationSettings.AppSettings["SupportContactNo"] + " for any assistance required.</p>");

            mailString.Append("<p>Thanks and regards,<br />Astix development team</p>");
            mailString.Append("</font>");

            string toEmail = ConfigurationSettings.AppSettings["MailTo"];
            objmail.To.Add(toEmail);

            string ccEmail = ConfigurationSettings.AppSettings["MailCc"];
            if (!string.IsNullOrWhiteSpace(ccEmail))
                objmail.CC.Add(ccEmail);

            string bccEmail = ConfigurationSettings.AppSettings["MailBcc"];
            if (!string.IsNullOrWhiteSpace(bccEmail))
                objmail.Bcc.Add(bccEmail);

            objmail.IsBodyHtml = true;
            objmail.Body = Convert.ToString(mailString);
            objmail.From = new System.Net.Mail.MailAddress(ConfigurationSettings.AppSettings["MailTitle"] + "<" + ConfigurationSettings.AppSettings["MailUser"] + ">");

            SmtpClient SmtpMail;
            SmtpMail = new SmtpClient();

            SmtpMail.Host = ConfigurationSettings.AppSettings["MailServer"];
            SmtpMail.Port = 25;

            NetworkCredential loginInfo;
            loginInfo = new NetworkCredential();
            loginInfo.UserName = ConfigurationSettings.AppSettings["MailUser"];
            loginInfo.Password = ConfigurationSettings.AppSettings["MailPassword"];
            SmtpMail.Credentials = loginInfo;
            SmtpMail.EnableSsl = true;
            SmtpMail.Timeout = 0;

            SmtpMail.Send(objmail);
            mailString = null;
        }
        catch (Exception ex)
        {
            result = ex.Message;
        }

        return result;
    }

    public static string SendUserToPearson(DataTable dt)
    {
        string result = "0";
        try
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                StringBuilder mailString = new StringBuilder();

            MailMessage objmail = new MailMessage();
            objmail = new System.Net.Mail.MailMessage();

            objmail.Subject = "User Assessmet Link - "+DateTime.Now.ToString("dd-MMM-yyyy hh:mm tt");
            mailString.Append("<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>");

            mailString.Append("<p>Dear Pearson representative,</p>");
            mailString.Append("<p>");
            mailString.Append("Please upload attached file after adding the RAVEN & SOSIE links.");
            mailString.Append("</p>");
            mailString.Append("<p>Click on this link <a href='" + ConfigurationSettings.AppSettings["PearsonAdminLink"] + "'>" + ConfigurationSettings.AppSettings["PearsonAdminLink"] + "</a> or paste this in a browser.</p>");
            mailString.Append("</p>");

            mailString.Append("<p>Please contact Astix support at <a href='mailto:" + ConfigurationSettings.AppSettings["SupportMail"] + "'>" + ConfigurationSettings.AppSettings["SupportMail"] + "</a> or " + ConfigurationSettings.AppSettings["SupportContactNo"] + " for any assistance required.</p>");

            mailString.Append("<p>Thanks and regards,<br />Astix development team</p>");
            mailString.Append("</font>");

            string toEmail = ConfigurationSettings.AppSettings["MailTo"];
            objmail.To.Add(toEmail);

                string ccEmail = ConfigurationSettings.AppSettings["MailCc"];
                if (!string.IsNullOrWhiteSpace(ccEmail))
                    objmail.CC.Add(ccEmail);

                string bccEmail = ConfigurationSettings.AppSettings["MailBcc"];
                if (!string.IsNullOrWhiteSpace(bccEmail))
                    objmail.Bcc.Add(bccEmail);

                int k = 1;
                string strSheetName = "UserAssessmentLink";

                var ws = wb.Worksheets.Add(dt, strSheetName);

                ws.Range(1, 1, 1, 4).Style.Alignment.Vertical = XLAlignmentVerticalValues.Center;
                ws.Range(1, 1, 1, 4).Style.Fill.BackgroundColor = XLColor.FromHtml("#4f81bd");
                ws.Range(1, 1, 1, 4).Style.Font.FontColor = XLColor.FromHtml("#ffffff");

                ws.Columns().AdjustToContents();
                ws.Rows().AdjustToContents();
                ws.Columns("1").Hide();
                ws.Column("3").Width = 70;
                ws.Column("4").Width = 70;
                IXLCell cell3 = ws.Cell(1, 1);
                IXLCell cell4 = ws.Cell(dt.Rows.Count + 1, dt.Columns.Count);
                ws.Range(ws.Cell(k, 4), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);
                ws.SheetView.FreezeRows(1);
                using (MemoryStream memoryStream = new MemoryStream())
                {
                    wb.SaveAs(memoryStream);
                    memoryStream.Position = 0;
                    objmail.Attachments.Add(new Attachment(memoryStream, "UserLink_" + DateTime.Now.ToString("yyyyMMddhhmmss") + ".xlsx"));

                    objmail.IsBodyHtml = true;
                    objmail.Body = Convert.ToString(mailString);
                    objmail.From = new System.Net.Mail.MailAddress("User Assessment Link<" + ConfigurationSettings.AppSettings["MailUser"] + ">");

                    SmtpClient SmtpMail;
                    SmtpMail = new SmtpClient();

                    SmtpMail.Host = ConfigurationSettings.AppSettings["MailServer"];
                    SmtpMail.Port = 25;

                    NetworkCredential loginInfo;
                    loginInfo = new NetworkCredential();
                    loginInfo.UserName = ConfigurationSettings.AppSettings["MailUser"];
                    loginInfo.Password = ConfigurationSettings.AppSettings["MailPassword"];
                    SmtpMail.Credentials = loginInfo;
                    SmtpMail.EnableSsl = true;
                    SmtpMail.Timeout = 0;

                    SmtpMail.Send(objmail);
                    mailString = null;
                    memoryStream.Close();
                }
            }
        }
        catch (Exception ex)
        {
            result = "4";
        }

        return result;
    }
}