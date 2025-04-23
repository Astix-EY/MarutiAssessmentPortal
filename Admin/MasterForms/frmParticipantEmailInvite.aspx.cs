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
using System.Net.Mime;
using AjaxControlToolkit.HTMLEditor.ToolbarButton;

public partial class frmParticipantEmailInvite : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["LoginID"] = 0;
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
            itm.Value = dr["CycleId"].ToString() + "^" + dr["flgStatus"];
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
                string[] SkipColumn = new string[8];
                SkipColumn[0] = "EmpNodeID";
                SkipColumn[1] = "FirstName";
                SkipColumn[2] = "SurName";
                SkipColumn[3] = "flgNewMail";
                SkipColumn[4] = "flgRescheduleMail";
                SkipColumn[5] = "BandID";
                SkipColumn[6] = "UserName";
                SkipColumn[7] = "Pwd";


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

                    str.Append("<th " + ss + ">" + sColumnName + "</th>");
                }
                //str.Append("<th>Include</th>");
                str.Append("<th><input type='checkbox' value='0' id='checkAll' onclick='check_uncheck_checkbox(this.checked)' > ALL</th>");
                str.Append("</tr></thead><tbody>");

                //ss = "";
                string OldParticipantId = "0";
                for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
                {
                    string Fname = Ds.Tables[0].Rows[i]["FirstName"].ToString();
                    string starttime = Ds.Tables[0].Rows[i]["AssessmentStartDate"].ToString();
                    string endtime = Ds.Tables[0].Rows[i]["AssessmentEndTime"].ToString();
                    string subjectline = "";
                    string EmpNodeID = Ds.Tables[0].Rows[i]["EmpNodeID"].ToString();
                    string flgNewMail = Ds.Tables[0].Rows[i]["flgNewMail"].ToString();
                    string flgRescheduleMail = Ds.Tables[0].Rows[i]["flgRescheduleMail"].ToString();
                    string EmailID = Ds.Tables[0].Rows[i]["EMailID"].ToString();
                    string FullName = Ds.Tables[0].Rows[i]["FullName"].ToString();
                    string flgDisplayRow = "";
                    // if (flgNewMail=="1" && flgRescheduleMail=="0")
                    // {
                    //     flgDisplayRow = "1";   /// For New User mail
                    // }
                    //else if (flgNewMail == "2" && flgRescheduleMail == "0")
                    // {
                    //     flgDisplayRow = "2";   /// For Resend Mail
                    // }
                    // else if (flgNewMail == "2" && flgRescheduleMail == "1")
                    // {
                    //     flgDisplayRow = "3";   /// For Updated Scheduler Mail
                    // }

                    flgDisplayRow = "1";


                    str.Append("<tr username= '" + Ds.Tables[0].Rows[i]["username"].ToString() + "'  pwd = '" + Ds.Tables[0].Rows[i]["pwd"].ToString() + "'  FullName= '" + FullName + "'  EmailID = '" + EmailID + "' flgDisplayRow ='" + flgDisplayRow + "' flgRescheduleMail = '" + flgRescheduleMail + "'  flgNewMail = '" + flgNewMail + "' EmpNodeID = '" + EmpNodeID + "' Fname ='" + Fname + "' cycledate ='" + cycledate + "' starttime='" + starttime + "' endtime='" + endtime + "'  subjectline='" + subjectline + "' >");
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
                    str.Append("<td><input type='checkbox' flg='1' value='1'></td>");


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

                    string SubjectName = "EY | Login Credentials";// drow["Subject"].ToString();
                    string MailTo = drow["EmailId"].ToString();
                    string DisplayName = drow["Name"].ToString();
                    string FName = drow["Fname"].ToString();
                    string username = drow["username"].ToString();
                    string pwd = drow["pwd"].ToString();
                    string EmpNodeID = drow["EmpNodeID"].ToString();
                    string SchedulerFlagValue = drow["SchedulerFlagValue"].ToString();
                    string strStatus = fnSendICSFIleToParticipant(EmpNodeID, FName, SubjectName, MailTo, DisplayName, username, pwd, SchedulerFlagValue);
                    drow["MailStatus"] = strStatus == "1" ? "Mail Sent" : strStatus;

                    if (strStatus == "1")
                    {
                        // SqlConnection Scon1 = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
                        SqlCommand Scmd = new SqlCommand();
                        Scmd.Connection = Scon;
                        Scmd.CommandText = "spMailUpdateFlagP";
                        Scmd.Parameters.AddWithValue("@EmpNodeID", EmpNodeID);
                        Scmd.Parameters.AddWithValue("@FlgMailState", 1);
                        Scmd.Parameters.AddWithValue("@flgUpdate", 2);

                        Scmd.CommandType = CommandType.StoredProcedure;
                        Scmd.CommandTimeout = 0;

                        Scmd.ExecuteNonQuery();
                    }

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


    public static string fnSendICSFIleToParticipant(string EmpNodeID, string FName, string SubjectName, string MailTo, string DisplayName, string UserName, string UserPwd, string SchedulerFlagValue)
    {
        string strRespoonse = "1";
        try
        {
            string MailServer = ConfigurationManager.AppSettings["MailServer"].ToString();
            string MailUserName = ConfigurationManager.AppSettings["MailUser"].ToString();
            string MailPwd = ConfigurationManager.AppSettings["MailPassword"].ToString();
            string flgActualUser = ConfigurationManager.AppSettings["flgActualUser"].ToString();
            string fromMail = ConfigurationManager.AppSettings["FromAddress"].ToString();
            string ParticipantInviteMailBodyText_ReachoutValue = ConfigurationManager.AppSettings["ParticipantInviteMailBodyText_ReachoutValue"].ToString();

            MailMessage msg = new MailMessage();
            msg.From = new MailAddress("VACAdmin<" + fromMail + ">");
            string CCMailID = "";
            string BCCMailID = "";
            // Now Contruct the ICS file using string builder
            string TestURL = ConfigurationManager.AppSettings["TestURL"].ToString();
            string PortNo = ConfigurationManager.AppSettings["PortNo"].ToString();
            if (flgActualUser == "2")
            {
                MailTo = ConfigurationManager.AppSettings["MailTo"].ToString();
                CCMailID = ConfigurationManager.AppSettings["MailCc"].ToString();
            }

            msg.To.Add(MailTo);
            if (CCMailID != "")
            {
                msg.CC.Add(CCMailID);
            }
            BCCMailID = ConfigurationManager.AppSettings["MailBcc"].ToString();
            msg.Bcc.Add(BCCMailID);

            msg.Subject = SubjectName;

            StringBuilder strBody = new StringBuilder();
            strBody.Append("<font  style='COLOR: #000080; FONT-FAMILY: Arial'  size=2>");
            strBody.Append("<p>Dear " + FName + ",</p>");
            strBody.Append("<p>Greetings from Ernst & Young (EY)!</p>");
            strBody.Append("<p>Congratulations on being invited to participate in the Virtual Development Centre.</p>");

            // strBody.Append("<p>To ensure that the talent is future ready and aligned with the organisation’s vision and mission, TVS Talent Development Team has undertaken many initiatives. One of them is to conduct a “Virtual Development Centre” in association with EY (Ernst and Young). </p>");

            strBody.Append("<p>Please find below the link and your login credentials to complete the necessary tasks.</p>");
            strBody.Append("<p><b>URL: </b><a href=" + TestURL + ">" + TestURL + "</a></p>");
            strBody.Append("<p><b>Login ID: " + UserName + "</b></p>");
            strBody.Append("<p><b>Password: " + UserPwd + "</b></p>");

            strBody.Append("<p>In case of further questions, please reach out to " + ParticipantInviteMailBodyText_ReachoutValue + "</p>");
            strBody.Append("<p>All the best for the process!</p>");
            strBody.Append("<p><b>Thanks & Regards, </b></p>");
            strBody.Append("<p><b>Team EY</b></p>");

            strBody.Append("</font>");
            msg.Body = strBody.ToString();
            msg.IsBodyHtml = true;
            SmtpClient SmtpMail = new SmtpClient();
            SmtpMail.Host = MailServer;
            SmtpMail.Port = Convert.ToInt32(PortNo);
            NetworkCredential loginInfo = new NetworkCredential(MailUserName, MailPwd);
            SmtpMail.Credentials = loginInfo;
            SmtpMail.EnableSsl = false;
            SmtpMail.Timeout = int.MaxValue;
            SmtpMail.Send(msg);
        }
        catch (Exception ex)
        {
            strRespoonse = ex.Message;
        }
        return strRespoonse;
    }




}