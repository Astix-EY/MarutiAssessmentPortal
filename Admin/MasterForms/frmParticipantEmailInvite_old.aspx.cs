using Ionic.Zip;
using LogMeIn.GoToMeeting.Api;
using LogMeIn.GoToMeeting.Api.Model;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using LogMeIn.GoToMeeting.Api.Model;
using System.Net.Mime;

public partial class frmParticipantEmailInvite : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["LoginID"] = 0;
        if (Session["LoginID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else {
            if (!IsPostBack)
            {
                hdnLoginId.Value = Session["LoginID"].ToString();
                fnBindAssessementList();
                //fnbindgroupmaster();
                //fnbindassessor();
            }
        }
    }

    private void fnBindAssessementList()
    {

        SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spGetAssessmentCycleDetail";
        Scmd.Parameters.AddWithValue("@CycleID", 0);
        Scmd.Parameters.AddWithValue("@Flag", 0);
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataTable dt = new DataTable();
        Sdap.Fill(dt);

        ListItem itm = new ListItem();
        itm.Text = "--------";
        itm.Value = "0";
        ddlCycle.Items.Add(itm);
        foreach (DataRow dr in dt.Rows)
        {
            itm = new ListItem();
            itm.Text = dr["CycleName"].ToString() + " (" + Convert.ToDateTime(dr["CycleStartDate"]).ToString("dd MMM yy") + ")";
            itm.Value = dr["CycleId"].ToString() + "^" + dr["flgStatus"];
            itm.Attributes.Add("cycledate", Convert.ToDateTime(dr["CycleStartDate"]).ToString("yyyy-MM-dd"));
            ddlCycle.Items.Add(itm);
            
        }
    }
    
    //Get Scheme And Product Detail Bases on Store
    [System.Web.Services.WebMethod()]
    public static string fngetdata(int CycleId,string cycledate)
    {
        SqlConnection con = null;
        con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        DataSet Ds = null;
        string stresponse = "";
        try
        {
            string storedProcName = "spMailGetParticipantList";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {
                   new SqlParameter("@CycleId", CycleId),
                };
            Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);

            
            StringBuilder str = new StringBuilder();
            StringBuilder str1 = new StringBuilder();

            if (Ds.Tables[0].Rows.Count > 0)
            {
                string[] SkipColumn = new string[5];
                SkipColumn[0] = "EmpNodeID";
                SkipColumn[1] = "FirstName";
                SkipColumn[2] = "SurName";
                SkipColumn[3] = "flgNewMail";
                SkipColumn[4] = "flgRescheduleMail";


                int isSubmitted = 0;// int.Parse(Ds.Tables[1].Rows[0]["isSubmitted"].ToString());
                str.Append("<div id='dvtblbody' class='mb-3'><table id='tbldbrlist' class='table table-bordered table-sm mb-0' isSubmitted=" + isSubmitted + "><thead><tr>");

                string ss = "";

                str.Append("<th style='width:6%' >SrNo</th>");
                for (int j = 0; j < Ds.Tables[0].Columns.Count; j++)
                {
                    if (SkipColumn.Contains(Ds.Tables[0].Columns[j].ColumnName))
                    {
                        continue;
                    }
                    string sColumnName = Ds.Tables[0].Columns[j].ColumnName; ;
                    
                    str.Append("<th "+ ss + ">" + sColumnName + "</th>");
                }
                str.Append("<th>Include</th>");
                //str.Append("<th><input type='checkbox' value='0' id='checkAll' onclick='check_uncheck_checkbox(this.checked)' > ALL</th>");
                str.Append("</tr></thead><tbody>");
                 
                //ss = "";
                string OldParticipantId = "0";
                for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
                {
                    string Fname = Ds.Tables[0].Rows[i]["FirstName"].ToString();
                    string starttime =  Ds.Tables[0].Rows[i]["AssessmentStartDate"].ToString();
                    string endtime =  Ds.Tables[0].Rows[i]["AssessmentEndTime"].ToString();
                    string subjectline = "";
                    string EmpNodeID = Ds.Tables[0].Rows[i]["EmpNodeID"].ToString();
                    string flgNewMail = Ds.Tables[0].Rows[i]["flgNewMail"].ToString();
                    string flgRescheduleMail = Ds.Tables[0].Rows[i]["flgRescheduleMail"].ToString();
                    str.Append("<tr flgRescheduleMail = '" + flgRescheduleMail + "' flgNewMail = '" + flgNewMail + "' EmpNodeID = '" + EmpNodeID +"' Fname ='" + Fname + "' cycledate ='" + cycledate + "' starttime='" + starttime + "' endtime='" + endtime + "'  subjectline='" + subjectline + "' >");
                        str.Append("<td style='text-align:center'>" + (i + 1) + "</td>");
                        for (int j = 0; j < Ds.Tables[0].Columns.Count; j++)
                        {
                            string sColumnName = Ds.Tables[0].Columns[j].ColumnName;
                            if (SkipColumn.Contains(sColumnName))
                            {
                                continue;
                            }
                            var sData = Ds.Tables[0].Rows[i][j];

                                str.Append("<td>" + sData + "</td>");

                        }
                        if (flgNewMail != "0")
                        {
                        str.Append("<td><input type='checkbox' flg='1' value='1'></td>");
                         }
                        else
                        {
                        str.Append("<td>&nbsp;</td>");
                    }
                   
                    str.Append("</tr>");
                }
                str.Append("</tbody></table></div>");
            }
            else
            {
                str.Append("");
            }

            stresponse = str.ToString();
        }
        catch (Exception ex)
        {
            stresponse = "2|" + ex.Message;
        }
        finally
        {
            con.Dispose();
        }

        return stresponse;
    }

    [System.Web.Services.WebMethod()]
    public static string fnSave(object udt_DataSaving)
    {
        string strResponse = "";
        try
        {
            string MailServer = ConfigurationManager.AppSettings["MailServer"].ToString();
            string MailUserName = ConfigurationManager.AppSettings["MailUser"].ToString();
            string MailPwd = ConfigurationManager.AppSettings["MailPassword"].ToString();
            string flgActualUser = ConfigurationManager.AppSettings["flgActualUser"].ToString();
            string fromMail = ConfigurationManager.AppSettings["FromAddress"].ToString();

            string strDataSaving = JsonConvert.SerializeObject(udt_DataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            DataTable dtDataSaving = JsonConvert.DeserializeObject<DataTable>(strDataSaving);
            dtDataSaving.TableName = "tblMeetingData";
            if (dtDataSaving.Rows[0][0].ToString() == "0")
            {
                dtDataSaving.Rows[0].Delete();
            }
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            Scon.Open();
            foreach (DataRow drow in dtDataSaving.Rows)
            {
                try
                {

                    DateTime dt1 = Convert.ToDateTime(drow["StartTime"].ToString());   //Convert.ToDateTime("2020-05-21 16:30");
                    string StartDate = dt1.ToString("yyyy-MM-dd hh:mm:ss tt");
                    DateTime dt2 = Convert.ToDateTime(drow["EndTime"].ToString()); //Convert.ToDateTime("2020-05-21 18:30");
                    string EndDate = dt2.ToString("yyyy-MM-dd hh:mm:ss tt");
                    string SubjectName = "Axiata FastForward Enterprise Academy | Scheduled CDI slot";// drow["Subject"].ToString();
                    string MailTo = drow["EmailId"].ToString();
                    string DisplayName = drow["Name"].ToString();
                    string FName = drow["Fname"].ToString();
                    string EmpNodeID = drow["EmpNodeID"].ToString();
                    string SchedulerFlagValue = drow["SchedulerFlagValue"].ToString();
                    string strStatus = fnSendICSFIleToParticipant(EmpNodeID,FName, SubjectName, MailTo, DisplayName, StartDate, EndDate, MailServer, MailUserName, MailPwd, fromMail, flgActualUser, SchedulerFlagValue);
                    drow["MailStatus"] = strStatus == "1" ? "Mail Sent" : strStatus;

                }
                catch (Exception ex)
                {
                    drow["MailStatus"] = "Error-" + ex.Message;
                }
            }

            strResponse = "0|" + JsonConvert.SerializeObject(dtDataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            Scon.Dispose();
        }
        catch (Exception ex)
        {
            strResponse = "1|" + ex.Message;
        }
        return strResponse;
    }


    public static string fnSendICSFIleToParticipant(string EmpNodeID,string FName,string SubjectName, string MailTo, string DisplayName, string StartDate, string EndDate,string MailServer,string MailUserName,string MailPwd,string fromMail,string flgActualUser,string SchedulerFlagValue)
    {
        string strRespoonse = "1";
        try
        {
            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("AxiataFastforward<" + fromMail + ">");
            string CCMailID = "Melissa.Lim@my.ey.com,Zarina.Husin@my.ey.com,Vidya.Mohan@in.ey.com,Harkamal.Khanna@in.ey.com";
            // Now Contruct the ICS file using string builder
            if (flgActualUser == "2")
            {
                MailTo = ConfigurationManager.AppSettings["MailTo"].ToString();
                CCMailID = ConfigurationManager.AppSettings["MailCc"].ToString();
            }
          
            msg.To.Add(MailTo);
            msg.CC.Add(CCMailID);
            msg.Bcc.Add("jyoti@astixsolutions.com");
            

            msg.Subject = SubjectName;

            string path1 =HttpContext.Current.Server.MapPath("~/Images/AxiataLogo.png");

            StringBuilder strBody = new StringBuilder();
            strBody.Append("<p><img src=cid:picture1 /></p>");


            //'''''''''''''''' Invitaion Mail Format'''''''''''''''''''''''''''''''''

            if (SchedulerFlagValue == "0")
            {
                strBody.Append("<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>");
                strBody.Append("<p>Dear " + FName + ",</p>");
                strBody.Append("<p>We are blocking your time for the scheduled <b>Enterprise Academy – Capability Development Inventory (CDI)</b>.</p>");
                strBody.Append("<p>Please accept the invite immediately, no rescheduling will be allowed..</p>");
                strBody.Append("<p><b>3 days (72 hours) before the date of your CDI</b></p>");
                strBody.Append("<ul>");
                strBody.Append("<li>Check that you have received your login credentials email from Fuse and Spotmentor</li>");
                strBody.Append("<li>Go through the CDI background information – <u>available on Fuse > Spotmentor</u> (no softcopy materials will be emailed)</li>");
                strBody.Append("</ul>");

                strBody.Append("<p><b>Day of CDI session:</b></p>");
                strBody.Append("<ul>");
                strBody.Append("<li>Be present on the specific date and time</li>");
                strBody.Append("<li>On the date of your CDI, please <b>DO NOT</b> login into CDI before your scheduled time. If you login earlier, the timer will start ticking and this will impact your CDI process</li>");
                strBody.Append("<li>The entire CDI needs to be completed in one sitting. A 10 minute break will be allocated in between task 2 and task 3</li>");
                strBody.Append("</ul>");
                strBody.Append("<p>Please contact <a href='mailto:techsupport@axiatafastforward.com'>techsupport@axiatafastforward.com</a> should you run into any difficulties.</p>");

                strBody.Append("<p><b><i>Let’s FastForward to a sustainable future, together!</i></b></p>");
                strBody.Append("</font>");


            }
            else
            {
                strBody.Append("<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>");
                strBody.Append("<p>REScheduled Mail Format</p>");
                strBody.Append("<p>Dear " + FName + ",</p>");
                strBody.Append("<p>We are blocking your time for the Re-scheduled <b>Enterprise Academy – Capability Development Inventory (CDI)</b>.</p>");
                strBody.Append("<p>Please accept the invite immediately, no rescheduling will be allowed..</p>");
                strBody.Append("<p><b>3 days (72 hours) before the date of your CDI</b></p>");
                strBody.Append("<ul>");
                strBody.Append("<li>Check that you have received your login credentials email from Fuse and Spotmentor</li>");
                strBody.Append("<li>Go through the CDI background information – <u>available on Fuse > Spotmentor</u> (no softcopy materials will be emailed)</li>");
                strBody.Append("</ul>");

                strBody.Append("<p><b>Day of CDI session:</b></p>");
                strBody.Append("<ul>");
                strBody.Append("<li>Be present on the specific date and time</li>");
                strBody.Append("<li>On the date of your CDI, please <b>DO NOT</b> login into CDI before your scheduled time. If you login earlier, the timer will start ticking and this will impact your CDI process</li>");
                strBody.Append("<li>The entire CDI needs to be completed in one sitting. A 10 minute break will be allocated in between task 2 and task 3</li>");
                strBody.Append("</ul>");
                strBody.Append("<p>Please contact <a href='mailto:techsupport@axiatafastforward.com'>techsupport@axiatafastforward.com</a> should you run into any difficulties.</p>");

                strBody.Append("<p><b><i>Let’s FastForward to a sustainable future, together!</i></b></p>");
                strBody.Append("</font>");

            }        



            msg.IsBodyHtml = true;

            System.Net.Mime.ContentType HTMLType = new System.Net.Mime.ContentType("text/html");
            AlternateView avCal = AlternateView.CreateAlternateViewFromString(strBody.ToString(), HTMLType);

            LinkedResource Pic1 = new LinkedResource(path1, MediaTypeNames.Image.Jpeg);
            Pic1.ContentId = "picture1";
            avCal.LinkedResources.Add(Pic1);

            msg.AlternateViews.Add(avCal);

            StringBuilder str = new StringBuilder();
            str.AppendLine("BEGIN:VCALENDAR");
            str.AppendLine("PRODID:Meeting1");
            str.AppendLine("VERSION:2.0");
            str.AppendLine("METHOD:REQUEST");
            str.AppendLine("BEGIN:VEVENT");
            DateTime dtStartTime = Convert.ToDateTime(StartDate);
            DateTime dtEndTime = Convert.ToDateTime(EndDate);
            str.AppendLine(string.Format("DTSTART:{0:yyyyMMddTHHmmss}", dtStartTime.ToUniversalTime().ToString("yyyyMMdd\\THHmmss\\Z")));
            str.AppendLine(string.Format("DTSTAMP:{0:yyyyMMddTHHmmss}", DateTime.Now));
            str.AppendLine(string.Format("DTEND:{0:yyyyMMddHHmmss}", dtEndTime.ToUniversalTime().ToString("yyyyMMdd\\THHmmss\\Z")));
            str.AppendLine("LOCATION: " + msg.From.Address);
            str.AppendLine(string.Format("UID:{0}", Guid.NewGuid()));
            str.AppendLine(string.Format("DESCRIPTION:{0}", strBody.ToString()));
            str.AppendLine(string.Format("X-ALT-DESC;FMTTYPE=text/html:{0}", strBody.ToString()));
            str.AppendLine(string.Format("SUMMARY:{0}", msg.Subject));
            str.AppendLine(string.Format("ORGANIZER:MAILTO:{0}", msg.From.Address));
            str.AppendLine(string.Format("ATTENDEE;CN=\"{0}\";RSVP=TRUE:mailto:{1}", msg.To[0].DisplayName, msg.To[0].Address));

            str.AppendLine("BEGIN:VALARM");
            str.AppendLine("TRIGGER:-PT15M");
            str.AppendLine("ACTION:DISPLAY");
            str.AppendLine("DESCRIPTION:Reminder");
            str.AppendLine("END:VALARM");
            str.AppendLine("END:VEVENT");
            str.AppendLine("END:VCALENDAR");

            System.Net.Mime.ContentType contype = new System.Net.Mime.ContentType("text/calendar");
            contype.Parameters.Add("method", "REQUEST");
            contype.Parameters.Add("name", "Meeting.ics");
            AlternateView avCal1 = AlternateView.CreateAlternateViewFromString(str.ToString(), contype);
            msg.AlternateViews.Add(avCal1);
            SmtpClient SmtpMail = new SmtpClient();
            SmtpMail.Host = MailServer;
            SmtpMail.Port = 25;
            string UserName = MailUserName;
            string Pwd = MailPwd;
            NetworkCredential loginInfo = new NetworkCredential(UserName, Pwd);
            SmtpMail.Credentials = loginInfo;
            SmtpMail.EnableSsl = true;
            SmtpMail.Timeout = int.MaxValue;
          
           SmtpMail.Send(msg);

            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "spMailUpdateFlagP";
            Scmd.Parameters.AddWithValue("@EmpNodeID", EmpNodeID);
            Scmd.Parameters.AddWithValue("@FlgMailState", 1);
            Scmd.Parameters.AddWithValue("@flgUpdate", 2);

            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.CommandTimeout = 0;
            Scmd.Connection = Scon;
            Scon.Open();
            Scmd.ExecuteNonQuery();


        }
        catch (Exception ex) {
            strRespoonse = ex.Message;
        }
        return strRespoonse;
    }

   

   
}