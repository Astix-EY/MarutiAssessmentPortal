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

public partial class Admin_MasterForms_frmParticipantAndAssessorMapping : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginID"] == null)
        {
            Response.Redirect("~/AssessorLogin.aspx");
        }
        else {
            if (!IsPostBack)
            {
                hdnLoginId.Value = Session["LoginID"].ToString();
                fnBindAssessementList();
            }
        }
    }

 
  
    private void fnBindAssessementList()
    {

        SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spGetAssessmentCycleDetailForFinalSubmit";
        //Scmd.Parameters.AddWithValue("@CycleID", 0);
        //Scmd.Parameters.AddWithValue("@Flag", 0);
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
            ddlCycle.Items.Add(itm);

        }
    }




    //Get Scheme And Product Detail Bases on Store
    [System.Web.Services.WebMethod()]
    public static string fngetdata(int CycleId, string cycledate)
    {
        SqlConnection con = null;
        con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        string stresponse = "";
        try
        {
            string storedProcName = "spGetAssessorParticipantForMeeting";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {
                   new SqlParameter("@CycleId", CycleId),
                };
            DataSet Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);


            StringBuilder str = new StringBuilder();
            StringBuilder str1 = new StringBuilder();

            if (Ds.Tables[0].Rows.Count > 0)
            {
                string[] SkipColumn = new string[16];
                SkipColumn[0] = "ParticipantId";
                SkipColumn[1] = "ParticipantCycleMappingId";
                SkipColumn[2] = "ParticipantAssessorMappingId";
                SkipColumn[3] = "EmpCode";
                SkipColumn[4] = "MeetingId";
                SkipColumn[5] = "ExerciseId";
                SkipColumn[6] = "ParticipantEmailId";
                SkipColumn[7] = "AssessorCycleMappingId";
                SkipColumn[8] = "AssessorTime";
                SkipColumn[9] = "PrepTime";
                SkipColumn[10] = "AssessorId";
                SkipColumn[11] = "GDID";
                SkipColumn[12] = "PR Time";
                SkipColumn[13] = "Exercise StartDate";
                SkipColumn[14] = "BEIUserName";
                SkipColumn[15] = "BEIPassword";


                int isSubmitted = 0;// int.Parse(Ds.Tables[1].Rows[0]["isSubmitted"].ToString());
                str.Append("<div id='dvtblbody' class='mb-3'><table id='tbldbrlist' class='table table-bordered table-sm mb-0' isSubmitted=" + isSubmitted + "><thead><tr>");

                //string ss = "style='text-align:center'";

                //str.Append("<th style='width:6%' >SrNo</th>");
                for (int j = 0; j < Ds.Tables[0].Columns.Count; j++)
                {
                    if (SkipColumn.Contains(Ds.Tables[0].Columns[j].ColumnName))
                    {
                        continue;
                    }


                    string sColumnName = Ds.Tables[0].Columns[j].ColumnName;
                    
                    str.Append("<th>" + sColumnName + "</th>");
                }
                str.Append("</tr></thead><tbody>");

                //ss = "";
                for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
                {

                    str.Append("<tr cycledate='" + cycledate + "' roleid='" + Ds.Tables[0].Rows[i]["Role"].ToString() + "'  ParticipantCycleMappingId='" + Ds.Tables[0].Rows[i]["ParticipantCycleMappingId"].ToString() + "' Participantid='" + Ds.Tables[0].Rows[i]["Participantid"].ToString() + "' assessorcyclemappingid='" + Ds.Tables[0].Rows[i]["assessorcyclemappingid"].ToString() + "' AssessorId='" + Ds.Tables[0].Rows[i]["AssessorId"].ToString() + "' participantassessormappingid='" + Ds.Tables[0].Rows[i]["participantassessormappingid"].ToString() + "'    participantname='" + Ds.Tables[0].Rows[i]["participantname"].ToString() + "'  empcode='" + Ds.Tables[0].Rows[i]["empcode"].ToString() + "'  exerciseid='" + Ds.Tables[0].Rows[i]["exerciseid"].ToString() + "'  ExerciseName='" + Ds.Tables[0].Rows[i]["ExerciseName"].ToString() + "' PreTime='" + Ds.Tables[0].Rows[i]["PrepTime"].ToString() + "' AssessorTime='" + Ds.Tables[0].Rows[i]["AssessorTime"].ToString() + "' BEIUserName='" + Ds.Tables[0].Rows[i]["BEIUserName"].ToString() + "' BEIPassword='" + Ds.Tables[0].Rows[i]["BEIPassword"].ToString() + "'>");
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

                         if (Ds.Tables[0].Columns[j].ColumnName.ToLower() == "participantname")
                        {
                            if (i > 0)
                            {
                                if ((Ds.Tables[0].Rows[i]["ParticipantId"].ToString() == Ds.Tables[0].Rows[i - 1]["ParticipantId"].ToString()) == false)
                                {
                                    str.Append("<td class='mergerow' rowspan=" + Ds.Tables[0].Select("ParticipantId = '" + Ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "'").Length + " " + flgSearchable + ">" + sData + "</td>");
                                }
                            }
                            else
                            {
                                str.Append("<td  class='mergerow' rowspan=" + Ds.Tables[0].Select("ParticipantId = '" + Ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "'").Length + " " + flgSearchable + ">" + sData + "</td>");
                            }
                        }
                        else
                        {
                            str.Append("<td " + flgSearchable + ">" + sData + "</td>");
                        }

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
    public static string fnSave(string LoginId, int CycleId)
    {
        string strResponse = "";
        SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
        try
        {
            Scon.Open();
            DataSet DsData = null;
            string storedProcName = "spGetMeetingAssessorParticipantList";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {
                   new SqlParameter("@CycleId", CycleId),
                };
            DsData = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, Scon, sp);


            DataTable dtTable = new DataTable();
            
            dtTable.Columns.Add(new DataColumn("AssessorName", typeof(string)));
            dtTable.Columns.Add(new DataColumn("ExerciseName", typeof(string)));
            dtTable.Columns.Add(new DataColumn("MeetingStartTime", typeof(string)));
            dtTable.Columns.Add(new DataColumn("MeetingStatus", typeof(string)));
            dtTable.Columns.Add(new DataColumn("ParticipantName", typeof(string)));
            dtTable.Columns.Add(new DataColumn("Role", typeof(string)));
            dtTable.Rows.Clear();



            string OldAssorId = "0"; var accessToken1 = "";
            if (DsData.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow drow in DsData.Tables[0].Rows)
                {
                    DataRow dr = dtTable.NewRow();
                    try
                    {
                        string ParticipantAssessorMappingId = drow["ParticipantAssessorMappingId"].ToString();
                        string AssessorCycleMappingId = drow["AssessorCycleMappingId"].ToString();
                        string GDId = drow["GDID"].ToString();
                        string ExerciseId = drow["ExerciseID"].ToString();
                        string AssessorName = Convert.ToString(drow["AssessorName"]);
                        string AssesseeName = Convert.ToString(drow["AssesseeName"]);
                        string RoleId = Convert.ToString(drow["BandId"]);
                        string ExerciseName = Convert.ToString(drow["ExerciseName"]);
                        string StartDate = drow["MeetingStartTime"].ToString();
                        string endDate = drow["MeetingEndTime"].ToString();

                        if (OldAssorId != drow["AssessorId"].ToString())
                        {
                            string BEIUserName = Convert.ToString(drow["UserName"]);
                            string BEIPassword = Convert.ToString(drow["Password"]);
                            accessToken1 = "";// clsHttpRequest.GetTokenNo(BEIUserName, BEIPassword);
                        }
                        OldAssorId = drow["AssessorId"].ToString();
                        List<MeetingCreated> lstMeetingCreated = fnCreateGotoMeeting(ExerciseName, accessToken1, StartDate, endDate);
                        string AssesseMeetingLink =lstMeetingCreated[0].joinURL;
                        string MeetingId =lstMeetingCreated[0].meetingid.ToString();
                        var strHostURL = "";
                        string AssessorMeetingLink = "";


                        dr[0] = AssessorName;
                        dr[1] = ExerciseName;
                        dr[2] = StartDate;


                        SqlCommand Scmd = new SqlCommand();
                        Scmd.Connection = Scon;
                        Scmd.CommandText = "[spCreateMeetingLinkForAssessorParticipant]";
                        Scmd.CommandType = CommandType.StoredProcedure;
                        Scmd.Parameters.AddWithValue("@CycleId", CycleId);
                        Scmd.Parameters.AddWithValue("@ParticipantAssessorMappingId", ParticipantAssessorMappingId);
                        Scmd.Parameters.AddWithValue("@AssessorCycleMappingId", AssessorCycleMappingId);
                        Scmd.Parameters.AddWithValue("@GDId", GDId);
                        Scmd.Parameters.AddWithValue("@ExerciseId", ExerciseId);
                        Scmd.Parameters.AddWithValue("@AssesseMeetingLink", AssesseMeetingLink);
                        Scmd.Parameters.AddWithValue("@AssessorMeetingLink", AssessorMeetingLink);
                        Scmd.Parameters.AddWithValue("@MeetingId", MeetingId);
                        Scmd.Parameters.AddWithValue("@LoginId", LoginId);
                        Scmd.CommandTimeout = 0;
                        Scmd.ExecuteNonQuery();

                        dr[3] = "Meeting Scheduled";
                        dr[4] = AssesseeName;
                        dr[5] = RoleId;
                    }
                    catch (Exception ex)
                    {
                        dr["MeetingStatus"] = "Error-" + ex.Message;
                    }
                    dtTable.Rows.Add(dr);
                }
                dtTable.DefaultView.Sort = "ParticipantName asc";
                dtTable = dtTable.DefaultView.ToTable(true);
                strResponse = "0|" + JsonConvert.SerializeObject(dtTable, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
                Scon.Dispose();
            }
            else
            {
                strResponse = "1|No Record Found For Meeting";
            }
           

        }
        catch (Exception ex)
        {
            strResponse = "1|" + ex.Message;
        }
        finally {
            Scon.Dispose();
        }
        return strResponse;
    }




    [System.Web.Services.WebMethod()]
    public static string fnSaveGD(object udt_DataSaving, string LoginId)
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

            DataTable dtTable = new DataTable();
            dtTable.Columns.Add(new DataColumn("ParticipantAssessorMappingId", typeof(int)));
            dtTable.Columns.Add(new DataColumn("ParticipantCycleMappingId", typeof(int)));
            dtTable.Columns.Add(new DataColumn("AssessorCycleMappingId", typeof(int)));
            dtTable.Columns.Add(new DataColumn("ParticipantId", typeof(int)));
            dtTable.Columns.Add(new DataColumn("AssessorId", typeof(int)));
            dtTable.Columns.Add(new DataColumn("IsLeadAssessor", typeof(int)));
            dtTable.Columns.Add(new DataColumn("ExerciseId", typeof(int)));
            dtTable.Columns.Add(new DataColumn("ExerciseStartTime", typeof(DateTime)));
            dtTable.Columns.Add(new DataColumn("ExerciseEndTime", typeof(DateTime)));
            dtTable.Columns.Add(new DataColumn("AssesseMeetingLink", typeof(string)));
            dtTable.Columns.Add(new DataColumn("AssessorMeetingLink", typeof(string)));
            dtTable.Columns.Add(new DataColumn("MeetingSlotTime", typeof(string)));
            dtTable.Columns.Add(new DataColumn("MeetingStartTime", typeof(DateTime)));
            dtTable.Columns.Add(new DataColumn("MeetingEndTime", typeof(DateTime)));
            dtTable.Columns.Add(new DataColumn("MeetingId", typeof(int)));
            dtTable.Rows.Clear();

            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            Scon.Open();

            int PreTime = Convert.ToInt32(dtDataSaving.Rows[0]["PreTime"].ToString());
            DateTime dt = Convert.ToDateTime(dtDataSaving.Rows[0]["MeetingStartTime"].ToString());
            dt = dt.AddMinutes(PreTime);
            string StartDate = dt.ToString("yyyy-MM-dd hh:mm:ss tt");
            int AssessorTime = Convert.ToInt32(dtDataSaving.Rows[0]["AssessorTime"].ToString());
            string endDate = dt.AddMinutes(AssessorTime).ToString("yyyy-MM-dd hh:mm:ss tt");

            string BEIUserName = Convert.ToString(dtDataSaving.Rows[0]["BEIUserName"]);
            string BEIPassword = Convert.ToString(dtDataSaving.Rows[0]["BEIPwd"]);
            var accessToken = "";// clsHttpRequest.GetTokenNo(BEIUserName, BEIPassword);
            List<MeetingCreated> lstMeetingCreated = fnCreateGotoMeeting("GD", accessToken, StartDate, endDate);
            MeetingsApi objMeetingsApi = new MeetingsApi();
            var strHostURL = objMeetingsApi.startMeeting(accessToken, lstMeetingCreated[0].meetingid);
            string AssessorName = Convert.ToString(dtDataSaving.Rows[0]["AssessorName"]);
            string AssessorMail = Convert.ToString(dtDataSaving.Rows[0]["AssessorMail"]);


            string strMailToDeveloper = "";

            foreach (DataRow drow in dtDataSaving.Rows)
            {
                try
                {
                    dtTable.Rows.Clear();
                    drow["AssesseMeetingLink"] = lstMeetingCreated[0].joinURL;
                    drow["MeetingId"] = lstMeetingCreated[0].meetingid;
                    drow["AssessorMeetingLink"] = strHostURL.hostURL;
                    string AssesseMailTo = Convert.ToString(drow["AssesseeMail"]);
                    string ExerciseName = "GD";// Convert.ToString(drow["ExerciseName"]);
                    string AssessName = Convert.ToString(drow["AssesseeName"]);
                    DataRow dr = dtTable.NewRow();
                    dr[0] = 0;
                    dr[1] = drow["ParticipantCycleMappingId"].ToString();
                    dr[2] = drow["AssessorCycleMappingId"].ToString();
                    dr[3] = drow["ParticipantId"].ToString();
                    dr[4] = drow["AssessorId"].ToString();
                    dr[5] = drow["IsLeadAssessor"].ToString();
                    dr[6] = drow["ExerciseId"].ToString();
                    dr[7] = Convert.ToDateTime(StartDate);
                    dr[8] = Convert.ToDateTime(endDate);
                    dr[9] = lstMeetingCreated[0].joinURL;
                    dr[10] = strHostURL.hostURL;
                    dr[11] = Convert.ToDateTime(StartDate).ToString("HH:mm");
                    dr[12] = Convert.ToDateTime(StartDate);
                    dr[13] = Convert.ToDateTime(endDate);
                    dr[14] = lstMeetingCreated[0].meetingid;
                    dtTable.Rows.Add(dr);
                    SqlCommand Scmd = new SqlCommand();
                    Scmd.Connection = Scon;
                    Scmd.CommandText = "[spPopulateAssessorParticipantMapping]";
                    Scmd.CommandType = CommandType.StoredProcedure;
                    Scmd.Parameters.AddWithValue("@tblParticipant", dtTable);
                    Scmd.Parameters.AddWithValue("@LoginId", LoginId);
                    Scmd.Parameters.AddWithValue("@flgStatus", 3);
                    Scmd.CommandTimeout = 0;
                    Scmd.ExecuteNonQuery();
                    drow["flgCreated"] = 1;
                    drow["MeetingStatus"] = "Meeting Scheduled";
                    //strMailToDeveloper = ("<table><tr><td>" + AssessName + "</td><td>:</td><td>" + StartDate + "</td></tr></table>");

                    // fnSendICSFIleToParticipant(ExerciseName, AssesseMailTo, AssessName, StartDate, endDate);

                }
                catch (Exception ex)
                {
                    drow["MeetingStatus"] = "Error-" + ex.Message;
                }
            }

            //fnSendICSFIleToDeveloper("GD",strMailToDeveloper.ToString(), AssessorMail, AssessorName,"","", StartDate, endDate, BEIUserName, BEIPassword);
            strResponse = "0|" + JsonConvert.SerializeObject(dtDataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            Scon.Dispose();
        }
        catch (Exception ex)
        {
            strResponse = "1|" + ex.Message;
        }
        return strResponse;
    }


    [System.Web.Services.WebMethod()]
    public static string fnSaveOrientation(string MeetingTime, string LoginId, int CycleId)
    {

        string strResponse = "";
        try
        {
            //string strDataSaving = JsonConvert.SerializeObject(udt_DataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            //DataTable dtDataSaving = JsonConvert.DeserializeObject<DataTable>(strDataSaving);
            //dtDataSaving.TableName = "tblMeetingData";
            //if (dtDataSaving.Rows[0][0].ToString() == "0")
            //{
            //    dtDataSaving.Rows[0].Delete();
            //}

            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            Scon.Open();

            DateTime dt = Convert.ToDateTime(MeetingTime);
            string StartDate = dt.ToString("yyyy-MM-dd hh:mm:ss tt");
            string endDate = dt.AddMinutes(30).ToString("yyyy-MM-dd hh:mm:ss tt");
            //string BEIUserName = Convert.ToString(dtDataSaving.Rows[0]["BEIUserName"]);
            //string BEIPassword = Convert.ToString(dtDataSaving.Rows[0]["BEIPwd"]);

            string BEIUserName = "alok@astixsolutions.com";
            string BEIPassword = "ALK031109";

            var accessToken = "";// clsHttpRequest.GetTokenNo(BEIUserName, BEIPassword);
            List<MeetingCreated> lstMeetingCreated = fnCreateGotoMeeting("Orientation", accessToken, StartDate, endDate);
            MeetingsApi objMeetingsApi = new MeetingsApi();
            var strHostURL = objMeetingsApi.startMeeting(accessToken, lstMeetingCreated[0].meetingid);
            //string AssessorName = Convert.ToString(dtDataSaving.Rows[0]["AssessorName"]);
            //string AssessorMail = Convert.ToString(dtDataSaving.Rows[0]["AssessorMail"]);
            string Orient_MeetingStartTime = StartDate;
            string Orient_AssessorMeetLink = lstMeetingCreated[0].joinURL;
            string Orient_AssesseeMeetLink = strHostURL.hostURL;

            string strMailToDeveloper = "";
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spCreateCycleOrientationMeeting]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@CycleId", CycleId);
            Scmd.Parameters.AddWithValue("@Orient_MeetingStartTime", Orient_MeetingStartTime);
            Scmd.Parameters.AddWithValue("@Orient_AssessorMeetLink", Orient_AssessorMeetLink);
            Scmd.Parameters.AddWithValue("@Orient_AssesseeMeetLink", Orient_AssesseeMeetLink);
            Scmd.Parameters.AddWithValue("@LoginId", LoginId);
            Scmd.Parameters.AddWithValue("@flgStatus", 5);
            Scmd.CommandTimeout = 0;
            Scmd.ExecuteNonQuery();
            string oldAssesseMailTo = "";
            //strMailToDeveloper = ("<table><tr><td>" + AssessName + "</td><td>:</td><td>" + StartDate + "</td></tr></table>");
            /*
            foreach (DataRow drow in dtDataSaving.Rows)
            {
                try
                {
                    string AssesseMailTo = Convert.ToString(drow["AssesseeMail"]);
                    if (oldAssesseMailTo != AssesseMailTo)
                    {
                        oldAssesseMailTo = AssesseMailTo;
                        string ExerciseName = "Orientation";// Convert.ToString(drow["ExerciseName"]);
                        string AssessName = Convert.ToString(drow["AssesseeName"]);
                        drow["flgCreated"] = 1;
                        drow["MeetingStatus"] = "Meeting Scheduled";
             
                        fnSendICSFIleToParticipant(ExerciseName, AssesseMailTo, AssessName, StartDate, endDate);
                    }
                }
                catch (Exception ex)
                {
                    drow["MeetingStatus"] = "Error-" + ex.Message;
                }

            }
            fnSendICSFIleToDeveloper("Orientation", strMailToDeveloper.ToString(), AssessorMail, AssessorName, "", "", StartDate, endDate, BEIUserName, BEIPassword);
            */
            strResponse = "0|";// + JsonConvert.SerializeObject(dtDataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            Scon.Dispose();
        }
        catch (Exception ex)
        {
            strResponse = "1|" + ex.Message;
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
        str.AppendLine("LOCATION: " + MailTo);
        str.AppendLine(string.Format("UID:{0}", Guid.NewGuid()));
        str.AppendLine(string.Format("DESCRIPTION:{0}", strBody.ToString()));
        str.AppendLine(string.Format("X-ALT-DESC;FMTTYPE=text/html:{0}", strBody.ToString()));
        str.AppendLine(string.Format("SUMMARY:{0}", msg.Subject));
        str.AppendLine(string.Format("ORGANIZER:MAILTO:{0}", MailTo));
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
            DisplayName = "Assessor";
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

    public static List<MeetingCreated> fnCreateGotoMeeting(string ExerciseName, string accessToken, string MeetingDate, string MeetingEndDate)
    {
        MeetingRecording objMeetingRec = new MeetingRecording();
        MeetingsApi objMeetingsApi = new MeetingsApi();
        MeetingReqCreate meetingBody = new MeetingReqCreate();
        meetingBody.subject = "Assessment Meeting-" + ExerciseName;
        meetingBody.meetingtype = MeetingType.scheduled;
        meetingBody.passwordrequired = false;
        DateTime dtStartTime = Convert.ToDateTime(MeetingDate).ToUniversalTime();
        DateTime dtEndTime = Convert.ToDateTime(MeetingEndDate).ToUniversalTime();
        meetingBody.starttime = dtStartTime;
        meetingBody.endtime = dtEndTime;
        meetingBody.conferencecallinfo = "hybrid";
        meetingBody.timezonekey = "Asia/Calcutta";
        //OrganizersApi oapi = new OrganizersApi();
        //List<Organizer> lst = oapi.getOrganizerByEmail(accessToken, "jyoti@astixsolutions.com");
        //List<string> lst1 = new List<string>();
        //lst1.Add(lst[0].organizerKey.ToString());
        //meetingBody.coorganizerKeys = lst1;
        List<MeetingCreated> lstMeetingCreated = objMeetingsApi.createMeeting(accessToken, meetingBody);
        return lstMeetingCreated;
    }
}