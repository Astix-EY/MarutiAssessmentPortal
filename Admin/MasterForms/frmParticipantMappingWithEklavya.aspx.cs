using Ionic.Zip;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class frmParticipantMappingWithEklavya : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else
        {
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
            itm.Value = dr["CycleId"].ToString();
            itm.Attributes.Add("cycledate", Convert.ToDateTime(dr["CycleStartDate"]).ToString("yyyy-MM-dd"));
            itm.Attributes.Add("assessmenttypeid", dr["AssmntTypeId"].ToString());
            ddlCycle.Items.Add(itm);

        }
    }

    //Get Scheme And Product Detail Bases on Store
    [System.Web.Services.WebMethod()]
    public static string fngetdata(int CycleId, string cycledate, int assessmenttypeid)
    {
        SqlConnection con = null;
        con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        DataSet Ds = null;
        DataSet DsData = null;
        string stresponse = "";
        try
        {
            string storedProcName = "spGetParticipantMappingWithEK";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {
                   new SqlParameter("@CycleId", CycleId),
                };
            Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);



            StringBuilder str = new StringBuilder();
            StringBuilder str1 = new StringBuilder();

            if (Ds.Tables[0].Rows.Count > 0)
            {
                string[] SkipColumn = new string[14];
                SkipColumn[0] = "ParticipantId";
                SkipColumn[1] = "ParticipantCycleMappingId";
                SkipColumn[2] = "ParticipantAssessorMappingId";
                SkipColumn[3] = "EmpCode";
                SkipColumn[4] = "MeetingId";
                SkipColumn[5] = "ExerciseId";
                SkipColumn[6] = "ParticipantEmailId1";
                SkipColumn[7] = "AssessorCycleMappingId";
                SkipColumn[8] = "AssessorTime";
                SkipColumn[9] = "PrepTime";
                SkipColumn[10] = "Mapped Assessor";
                SkipColumn[11] = "GDID";
                SkipColumn[12] = "CandidateID";
                SkipColumn[13] = "ExerciseName";







                int isSubmitted = 0;// int.Parse(Ds.Tables[1].Rows[0]["isSubmitted"].ToString());
                str.Append("<div id='dvtblbody' class='mb-3'><table id='tbldbrlist' class='table table-bordered table-sm mb-0' isSubmitted=" + isSubmitted + "><thead><tr>");

                string ss = "";

                //str.Append("<th style='width:6%' >SrNo</th>");
                for (int j = 0; j < Ds.Tables[0].Columns.Count; j++)
                {
                    if (SkipColumn.Contains(Ds.Tables[0].Columns[j].ColumnName))
                    {
                        continue;
                    }
                    string sColumnName = "";

                    //ss = "style='text-align:center'";
                    if (Ds.Tables[0].Columns[j].ColumnName.ToLower() == "assessorid")
                    {
                        sColumnName = "Assessor";
                    }
                    else if (Ds.Tables[0].Columns[j].ColumnName.ToLower() == "exercise startdate")
                    {
                        sColumnName = assessmenttypeid == 1 ? "Exercise Startdate" : "Task4 Start Date";
                        ss = "style='width:15%;text-align:center'";
                    }
                    else if (Ds.Tables[0].Columns[j].ColumnName.ToLower() == "exercise starttime")
                    {
                        sColumnName = assessmenttypeid == 1 ? "Client Conversation Start Time(IST)" : "Task4 Start Time(IST)";
                        ss = "style='width:25%'";
                    }
                    else
                    {
                        sColumnName = Ds.Tables[0].Columns[j].ColumnName;
                    }
                    //sColumnName = Ds.Tables[0].Columns[j].ColumnName;
                    //if (sColumnName == "Route Name")
                    //{
                    //    ss = "style='width:35%'";
                    //}
                    str.Append("<th " + ss + ">" + sColumnName + "</th>");
                }
                //str.Append("<th style='width:30%'>Developer</th>");
                str.Append("<th style='width:10%'><input id='chkcheckAll' type='checkbox' onchange='fnChangeCheckAll()' /> Is Mapped</th>");
                str.Append("</tr></thead><tbody>");

                //ss = "";
                string OldParticipantId = "0"; string strStyleDisplayRow = ";display:none";
                for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
                {
                    strStyleDisplayRow = ";display:none";
                    if (OldParticipantId != Ds.Tables[0].Rows[i]["ParticipantId"].ToString())
                    {
                        strStyleDisplayRow = "display:table-row";
                    }
                    string dropdownlist_at = "";
                    string time_dropdownlist = "";




                    //lstTimeIntervals.Add(i.ToString("HH:mm tt"));


                    string ParticipantCycleMappingId = Ds.Tables[0].Rows[i]["ParticipantCycleMappingId"].ToString();
                    int flgMapped = 0;// Convert.ToInt32(Ds.Tables[0].Rows[i]["ParticipantAssessorMappingId"]);
                                      //int flgStatus = Convert.ToInt32(Ds.Tables[0].Rows[i]["flgStatus"]);
                                      //long flgMeeting = Convert.ToInt64(Ds.Tables[0].Rows[i]["MeetingId"]);
                    string strHightlightclass = "";
                    string strTitle = "";
                    string[] rowspanColumn = new string[2];
                    rowspanColumn[0] = "participantname";
                    rowspanColumn[0] = "exercise startdate";
                    if (flgMapped > 0)
                    {
                        strTitle = "Assessement has not started";
                        strHightlightclass = "class='clsHighlightrows'";
                    }
                    str.Append("<tr style='" + strStyleDisplayRow + "'  cycledate='" + cycledate + "' ParticipantCycleMappingId='" + Ds.Tables[0].Rows[i]["ParticipantCycleMappingId"].ToString() + "' Participantid='" + Ds.Tables[0].Rows[i]["Participantid"].ToString() + "' participantemailid='" + Ds.Tables[0].Rows[i]["participantemailid"].ToString() + "'  designation='" + Ds.Tables[0].Rows[i]["designation"].ToString() + "'  participantname='" + Ds.Tables[0].Rows[i]["participantname"].ToString() + "'  empcode='" + Ds.Tables[0].Rows[i]["empcode"].ToString() + "'>");
                    //str.Append("<td style='text-align:center'>" + (i + 1) + "</td>");
                    for (int j = 0; j < Ds.Tables[0].Columns.Count; j++)
                    {
                        string sColumnName = Ds.Tables[0].Columns[j].ColumnName;
                        if (SkipColumn.Contains(sColumnName))
                        {
                            continue;
                        }
                        var sData = Ds.Tables[0].Rows[i][j];

                        string flgSearchable = "Searchable='0'";
                        if (Ds.Tables[0].Columns[j].ColumnName == "EmpName" || Ds.Tables[0].Columns[j].ColumnName == "EmpCode")
                        {
                            flgSearchable = "Searchable='1'";
                        }
                        //ss += "'";

                        if (Ds.Tables[0].Columns[j].ColumnName.ToLower() == "assessorid")
                        {
                            str.Append("<td style='text-align:left'><select id='ddlassessor' onchange='fnChangeAssessor(this)'  class='col-10' class='clsassessor'  AssessorCycleMappingId='0'  > " + dropdownlist_at + "<select/></td>");
                        }
                        else if (Ds.Tables[0].Columns[j].ColumnName.ToLower() == "exercise startdate" && assessmenttypeid == 2)
                        {
                            str.Append("<td style='text-align:left'><input type='text' iden='txtdateslot'  class='col-10 clsDate' readonly value='" + Ds.Tables[0].Rows[i]["Exercise StartDate"].ToString() + "' /></td>");
                        }
                        else if (Ds.Tables[0].Columns[j].ColumnName.ToLower() == "exercise starttime")
                        {
                            str.Append("<td style='text-align:left'><select id='ddltimeslot'  class='col-10' class='clsisleadassessor'   onchange='fnChangeTimeSlot(this)' > " + time_dropdownlist + "<select/></td>");
                        }
                        str.Append("<td " + flgSearchable + ">" + sData + "</td>");
                    }
                    str.Append("<td style='text-align:center'>");
                    if (Convert.ToString(Ds.Tables[0].Rows[i]["CandidateId"]) == "")
                    {
                        str.Append("<input flgexist='1' flg='1' type=checkbox >");
                    }
                    str.Append("</td>");
                    str.Append("</tr>");

                    OldParticipantId = Ds.Tables[0].Rows[i]["ParticipantId"].ToString();
                }
                str.Append("</tbody></table></div>");
            }
            else
            {
                str.Append("");
            }

            stresponse = str.ToString() + "|0";
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
    public static string fnSave(object udt_DataSaving, string LoginId, int CycleId, int flgStatus)
    {
        string strResponse = "";
        try
        {
            string strDataSaving = JsonConvert.SerializeObject(udt_DataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            DataTable dtDataSaving = JsonConvert.DeserializeObject<DataTable>(strDataSaving);
            dtDataSaving.TableName = "tblMeetingData";
            if (dtDataSaving.Rows[0][0].ToString() == "0")
            {
                dtDataSaving.Rows[0].Delete();
            }
            strResponse = clsHttpRequest.sendConsolidatedUserDataToEK(dtDataSaving, CycleId);
        }
        catch (Exception ex)
        {
            strResponse = "2|" + ex.Message;
        }
        return strResponse;
    }



    public static void fnSendICSFIleToParticipant(string ExerciseName, string MailTo, string DisplayName, string StartDate, string EndDate)
    {
        string flgActualUser = ConfigurationManager.AppSettings["flgActualUser"].ToString();
        string fromMail = ConfigurationManager.AppSettings["MailUser"].ToString();
        // Now Contruct the ICS file using string builder
        if (flgActualUser == "2")
        {
            MailTo = ConfigurationManager.AppSettings["MailTo"].ToString();
            DisplayName = "Participant";
        }
        MailMessage msg = new MailMessage();
        msg.From = new MailAddress("BoschAssessment<" + fromMail + ">");
        msg.To.Add(MailTo);


        msg.Subject = "Assessement Meeting -" + ExerciseName;
        StringBuilder strBody = new StringBuilder();
        strBody.Append("<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>");
        strBody.Append("<p>Dear " + DisplayName + ",</p>");
        strBody.Append("<p>Your " + ExerciseName + " assessement meeting will start at " + StartDate + ". Request to you click on \"<b>Start Meeting</b>\" on your portal 5 minutes prior to the scheduled time to ensure system is ready for the meeting to commence.</p>");
        strBody.Append("<p>Thanks</p>");
        strBody.Append("</font>");
        msg.IsBodyHtml = true;

        System.Net.Mime.ContentType HTMLType = new System.Net.Mime.ContentType("text/html");
        AlternateView avCal = AlternateView.CreateAlternateViewFromString(strBody.ToString(), HTMLType);
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
        SmtpMail.Host = ConfigurationManager.AppSettings["MailServer"].ToString();
        SmtpMail.Port = 25;
        string UserName = ConfigurationManager.AppSettings["MailUser"].ToString();
        string Pwd = ConfigurationManager.AppSettings["MailPassword"].ToString();
        NetworkCredential loginInfo = new NetworkCredential(UserName, Pwd);
        SmtpMail.Credentials = loginInfo;
        SmtpMail.EnableSsl = true;
        SmtpMail.Timeout = int.MaxValue;
        SmtpMail.Send(msg);
    }

    public static void fnSendICSFIleToDeveloper(string ExerciseName, string MeetingData, string MailTo, string DisplayName, string ParticipantName, string ParticipantMail, string StartDate, string EndDate, string BEIUserName, string BEIPassword)
    {
        string flgActualUser = ConfigurationManager.AppSettings["flgActualUser"].ToString();
        string fromMail = ConfigurationManager.AppSettings["MailUser"].ToString();
        // Now Contruct the ICS file using string builder
        if (flgActualUser == "2")
        {
            MailTo = ConfigurationManager.AppSettings["MailTo"].ToString();
            DisplayName = "Developer";
        }
        MailMessage msg = new MailMessage();
        msg.From = new MailAddress("BoschAssessment<" + fromMail + ">");
        msg.To.Add(MailTo);

        msg.Subject = "Assessment Meeting-" + ExerciseName;
        StringBuilder strBody = new StringBuilder();

        strBody.Append("<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>");
        strBody.Append("<p>Dear " + DisplayName + ",</p>");
        strBody.Append("<p>Your " + ExerciseName + " assessement meeting have been scheduled as follows:</p>");
        strBody.Append(MeetingData);
        strBody.Append("<p>Your credential for " + ExerciseName + " are below:</p>");
        strBody.Append("<p>UserName:" + BEIUserName + "</p>");
        strBody.Append("<p>Password:" + BEIPassword + "</p>");
        strBody.Append("<p>Request to you click on \"Start Meeting\" on your portal 5 minutes prior to the scheduled time to ensure system is ready for the meeting to commence.</p>");
        strBody.Append("<p>Thanks</p>");
        strBody.Append("</font>");
        msg.IsBodyHtml = true;
        System.Net.Mime.ContentType HTMLType = new System.Net.Mime.ContentType("text/html");
        AlternateView avCal = AlternateView.CreateAlternateViewFromString(strBody.ToString(), HTMLType);
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
        str.AppendLine("LOCATION: " + MailTo);
        str.AppendLine(string.Format("UID:{0}", Guid.NewGuid()));
        str.AppendLine(string.Format("DESCRIPTION:{0}", strBody.ToString()));
        str.AppendLine(string.Format("X-ALT-DESC;FMTTYPE=text/html:{0}", strBody.ToString()));
        str.AppendLine(string.Format("SUMMARY:{0}", msg.Subject));
        str.AppendLine(string.Format("ORGANIZER:MAILTO:{0}", MailTo));
        str.AppendLine(string.Format("ATTENDEE;CN=\"{0}\";RSVP=TRUE:mailto:{1}", ParticipantName, ParticipantMail));

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
        SmtpMail.Host = ConfigurationManager.AppSettings["MailServer"].ToString();
        SmtpMail.Port = 25;
        string UserName = ConfigurationManager.AppSettings["MailUser"].ToString();
        string Pwd = ConfigurationManager.AppSettings["MailPassword"].ToString();
        NetworkCredential loginInfo = new NetworkCredential(UserName, Pwd);
        SmtpMail.Credentials = loginInfo;
        SmtpMail.EnableSsl = true;
        SmtpMail.Timeout = int.MaxValue;
        SmtpMail.Send(msg);
    }

}