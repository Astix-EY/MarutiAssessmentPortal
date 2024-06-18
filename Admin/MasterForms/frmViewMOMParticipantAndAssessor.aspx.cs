using LogMeIn.GoToMeeting.Api;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class frmViewMOMParticipantAndAssessor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["LoginID"] = "0";
        if (Session["LoginID"] == null)
        {
            Response.Redirect("~/AssesorLogin.aspx");
            return;
        }
        if (!IsPostBack)
        {
            hdnLoginId.Value = Session["LoginID"].ToString();
            fnBindAssessementList();
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
        itm.Text = "All";
        itm.Value = "0";
        ddlCycleName.Items.Add(itm);
        if (dt.Rows.Count > 0)
        {
            foreach (DataRow dr in dt.Rows)
            {
                itm = new ListItem();
                itm.Text = dr["CycleName"].ToString() + " (" + Convert.ToDateTime(dr["CycleStartDate"]).ToString("dd MMM yy") + ")";
                itm.Value = dr["CycleId"].ToString();
                ddlCycleName.Items.Add(itm);
            }

        }
        else
        {
            itm = new ListItem();
            itm.Text = "No cycle mapped";
            itm.Value = "0";
            ddlCycleName.Items.Add(itm);
        }

    }


    [System.Web.Services.WebMethod()]
    public static string fnGetParticipantDetails(int CycleID, int loginId, int flgCallType)
    {
        DataSet ds = new DataSet();
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "[spViewMOMParticipantAndAssessor]";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        Scmd.Parameters.AddWithValue("@CycleId", CycleID);
        Scmd.Parameters.AddWithValue("@LoginId", loginId);
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        Sdap.Fill(ds);
        string strResponse = "";
        if (flgCallType == 1)
        {
            strResponse = createStoretbl(ds, 1, true);
        }
        else {
            //Discussion in Progress
            //Prep Completed, Discussion To Start
            DataRow[] drow = ds.Tables[0].Select("[Status]='Prep Completed, Discussion To Start' OR [Status]='Prep In Progress' OR [Status]='Discussion Over'");
            if (drow.Length > 0)
            {
                strResponse = JsonConvert.SerializeObject(drow.CopyToDataTable(), Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            }
        }
        return strResponse;
    }



    private static string createStoretbl(DataSet ds, int headerlvl, bool IsHeader)
    {
        DataTable dt = ds.Tables[0];

        string[] SkipColumn = new string[26];
        SkipColumn[0] = "ParticipantId";
        SkipColumn[1] = "RspExerciseID";
        SkipColumn[2] = "RspId";
        SkipColumn[3] = "ExerciseID";
        SkipColumn[4] = "flgPrepStatus";
        SkipColumn[5] = "flgMeetingStatus";
        SkipColumn[6] = "PrepActualStartTime";
        SkipColumn[7] = "AssessorMeetingLink";
        SkipColumn[8] = "PrepDefaultTime";
        SkipColumn[9] = "MeetingDefaultTime";
        SkipColumn[10] = "MeetingScheduledStartTime";
        SkipColumn[11] = "txtMeetingDisplayTime";
        SkipColumn[12] = "flgMeetingStatusP";
        SkipColumn[13] = "flgMeetingStatusA";
        SkipColumn[14] = "flgMeetingStatus";
        SkipColumn[15] = "PrepActualEndTime";
        SkipColumn[16] = "MeetingActualEndTime";
        SkipColumn[17] = "flgShowLink";
        SkipColumn[18] = "GotoUserName";
        SkipColumn[19] = "GotoPassword";
        SkipColumn[20] = "MeetingId";
        SkipColumn[21] = "MeetingStartTime";
        SkipColumn[22] = "MeetingEndTime";
        SkipColumn[23] = "MeetingActualStartTime";
        SkipColumn[24] = "ParticipantAssessorMappingId";
        SkipColumn[25] = "DownloadMeetingLink";


        

        if (ds.Tables[0].Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<div id='dvtblbody'><table id='tblEmp' class='table table-bordered table-sm bg-white'>");
            sb.Append("<thead>");
            string[] Collength = dt.Columns[2].ColumnName.ToString().Split('|')[0].Split('^');
            for (int k = 0; k < Collength.Length; k++)
            {
                sb.Append("<tr class='bg-blue text-white'>");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Split('|')[0].Trim()))
                    {
                        string[] ColSpliter = (dt.Columns[j].ColumnName.ToString().Split('|')[0].Trim()).Split('^');
                        if (ColSpliter[k] != "")
                        {
                            if (string.Join("", ColSpliter) == ColSpliter[k])
                            {
                                if (dt.Columns[j].ColumnName.ToString() == "Exercise EndTime")
                                {
                                    sb.Append("<th rowspan='" + ColSpliter.Length + "' style='width:10%' >" + ColSpliter[k] + "</th>");
                                }
                                else
                                {
                                    sb.Append("<th rowspan='" + ColSpliter.Length + "'>" + ColSpliter[k] + "</th>");
                                }

                            }
                            else
                            {
                                string strrowspan = multilvlPopuptbl(dt, j, k);
                                sb.Append(strrowspan.Split('|')[0]);
                                j = j + Convert.ToInt32(strrowspan.Split('|')[1]) - 1;
                            }
                        }
                    }
                }
                sb.Append("<th style='width:8%'>Action</th>");
                sb.Append("</tr>");
            }
            sb.Append("</thead>");
            sb.Append("<tbody>");
            string[] rowspanColumn = new string[1];
            rowspanColumn[0] = "ParticipantName";
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                sb.Append("<tr>");
                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(ds.Tables[0].Columns[j].ColumnName.ToString()))
                    {

                        if (ds.Tables[0].Columns[j].ColumnName.ToLower() == "participantname")
                        {
                            if (i > 0)
                            {
                                if ((ds.Tables[0].Rows[i]["ParticipantId"].ToString() == ds.Tables[0].Rows[i - 1]["ParticipantId"].ToString()) == false)
                                {
                                    sb.Append("<td class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                                }
                            }
                            else
                            {
                                sb.Append("<td  class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }
                        }
                        else if (ds.Tables[0].Columns[j].ColumnName.ToLower() == "assessorname")
                        {
                            if (i > 0)
                            {
                                if ((ds.Tables[0].Rows[i]["ParticipantId"].ToString() == ds.Tables[0].Rows[i - 1]["ParticipantId"].ToString() && ds.Tables[0].Rows[i]["assessorname"].ToString() == ds.Tables[0].Rows[i - 1]["assessorname"].ToString()) == false)
                                {
                                    sb.Append("<td class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and assessorname = '" + ds.Tables[0].Rows[i]["assessorname"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                                }
                            }
                            else
                            {
                                sb.Append("<td  class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and assessorname = '" + ds.Tables[0].Rows[i]["assessorname"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }
                        }
                        else if (ds.Tables[0].Columns[j].ColumnName.ToLower() == "assessment status")
                        {
                            if (i > 0)
                            {
                                if ((ds.Tables[0].Rows[i]["ParticipantId"].ToString() == ds.Tables[0].Rows[i - 1]["ParticipantId"].ToString() && ds.Tables[0].Rows[i]["Assessment Status"].ToString() == ds.Tables[0].Rows[i - 1]["Assessment Status"].ToString()) == false)
                                {
                                    sb.Append("<td class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and [Assessment Status] = '" + ds.Tables[0].Rows[i]["Assessment Status"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                                }
                            }
                            else
                            {
     ;                           sb.Append("<td  class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and [Assessment Status] = '" + ds.Tables[0].Rows[i]["Assessment Status"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }
                        }
                        else if (ds.Tables[0].Columns[j].ColumnName.ToLower() == "ratingfeedback status")
                        {
                            if (i > 0)
                            {
                                if ((ds.Tables[0].Rows[i]["ParticipantId"].ToString() == ds.Tables[0].Rows[i - 1]["ParticipantId"].ToString() && ds.Tables[0].Rows[i]["ratingfeedback status"].ToString() == ds.Tables[0].Rows[i - 1]["ratingfeedback status"].ToString()) == false)
                                {
                                    sb.Append("<td class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and [ratingfeedback status] = '" + ds.Tables[0].Rows[i]["ratingfeedback status"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                                }
                            }
                            else
                            {
                                sb.Append("<td  class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and [ratingfeedback status] = '" + ds.Tables[0].Rows[i]["ratingfeedback status"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }
                        }
                        else if (ds.Tables[0].Columns[j].ColumnName.ToLower() == "cdifeedback status")
                        {
                            if (i > 0)
                            {
                                if ((ds.Tables[0].Rows[i]["ParticipantId"].ToString() == ds.Tables[0].Rows[i - 1]["ParticipantId"].ToString() && ds.Tables[0].Rows[i]["cdiFeedback status"].ToString() == ds.Tables[0].Rows[i - 1]["cdiFeedback status"].ToString()) == false)
                                {
                                    sb.Append("<td class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and [cdiFeedback status] = '" + ds.Tables[0].Rows[i]["cdiFeedback status"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                                }
                            }
                            else
                            {
                                sb.Append("<td  class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and [cdiFeedback status] = '" + ds.Tables[0].Rows[i]["cdiFeedback status"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }
                        }
                        else if (ds.Tables[0].Columns[j].ColumnName.ToLower() == "managerfeedback status")
                        {
                            if (i > 0)
                            {
                                if ((ds.Tables[0].Rows[i]["ParticipantId"].ToString() == ds.Tables[0].Rows[i - 1]["ParticipantId"].ToString() && ds.Tables[0].Rows[i]["managerfeedback status"].ToString() == ds.Tables[0].Rows[i - 1]["managerfeedback status"].ToString()) == false)
                                {
                                    sb.Append("<td class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and [managerfeedback status] = '" + ds.Tables[0].Rows[i]["managerfeedback status"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                                }
                            }
                            else
                            {
                                sb.Append("<td  class='mergerow' rowspan=" + ds.Tables[0].Select("ParticipantId = '" + ds.Tables[0].Rows[i]["ParticipantId"].ToString() + "' and [managerfeedback status] = '" + ds.Tables[0].Rows[i]["managerfeedback status"].ToString() + "'").Length + " >" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }
                        }
                        else if (ds.Tables[0].Columns[j].ColumnName == "Status")
                        {
                            sb.Append("<td iden='mstatus'>" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                        }
                        else
                        {
                            sb.Append("<td>" + ds.Tables[0].Rows[i][ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                        }
                    }
                }
                if (ds.Tables[0].Rows[i]["flgMeetingStatus"].ToString() == "2")
                {
                    if (Convert.ToString(ds.Tables[0].Rows[i]["DownloadMeetingLink"]) == "")
                    {
                        sb.Append("<td><a href='###' onclick='fnViewMeeting(this)' ParticipantAssessorMappingId='" + ds.Tables[0].Rows[i]["ParticipantAssessorMappingId"].ToString() + "' meetingid='" + Convert.ToString(ds.Tables[0].Rows[i]["meetingid"]) + "' gotousername='" + Convert.ToString(ds.Tables[0].Rows[i]["gotousername"]) + "' gotopassword='" + Convert.ToString(ds.Tables[0].Rows[i]["gotopassword"]) + "' MeetingStartTime='" + Convert.ToString(ds.Tables[0].Rows[i]["MeetingStartTime"]) + "' MeetingEndTime='" + Convert.ToString(ds.Tables[0].Rows[i]["MeetingEndTime"]) + "' class='btn btn-primary' style='padding:0px 4px;font-size:12px' >View MOM</a></td>");
                    }
                    else
                    {
                        sb.Append("<td><a href='" + Convert.ToString(ds.Tables[0].Rows[i]["DownloadMeetingLink"]) + "' target='_blank' class='btn btn-primary' style='padding:0px 4px;font-size:12px' >View MOM</a></td>");
                    }
                }
                else
                {
                    sb.Append("<td></td>");
                }
                sb.Append("</tr>");
            }
            sb.Append("</tbody>");
            sb.Append("</table></div>");
            return sb.ToString();
        }
        else
        {
            return "<div style='padding : 10px 20px; color:red; font-weight:bold;'>No Record Found !</div>";
        }
    }
    private static string multilvlPopuptbl(DataTable dt, int col_ind, int row_ind)
    {
        int cntr = 1;
        string str = dt.Columns[col_ind].ColumnName.ToString().Split('|')[0].Split('^')[row_ind];
        for (int i = col_ind + 1; i < dt.Columns.Count; i++)
        {
            if (str == dt.Columns[i].ColumnName.ToString().Split('|')[0].Split('^')[row_ind])
            {
                cntr++;
            }
            else
            {
                break;
            }
        }
        return " <th colspan='" + cntr + "' style='color: #ffffff; font-weight:bold; background-color: #0080b9; border: 1px solid #dddddd;'> " + str + " </th>|" + cntr;
    }


    [System.Web.Services.WebMethod()]
    public static string fnViewMOM(string RSPExerciseid, string MeetingStartDate, string MeetingEndDate, string GotoUserName, string GotoPassword, long Meetingid)
    {

        try
        {
            string DownloadMeetingRecordingLink = "";
            var accessToken = "";// clsHttpRequest.GetTokenNo(GotoUserName, GotoPassword);
            MeetingsApi objMeetingsApi = new MeetingsApi();
            string StartDate = Convert.ToDateTime(MeetingStartDate).ToString("yyyy/MMM/dd");
            StartDate = Convert.ToDateTime(StartDate).ToString("yyyy-MM-ddTHH:mm:ssZ");
            string Enddate = Convert.ToDateTime(MeetingEndDate).ToString("yyyy-MM-ddTHH:mm:ssZ");
            List<LogMeIn.GoToMeeting.Api.Model.MeetingHistory> lstMeetingHistory = objMeetingsApi.getHistoryMeetings(accessToken, true, Convert.ToDateTime(StartDate).ToUniversalTime(), Convert.ToDateTime(Enddate).ToUniversalTime());
            foreach (var lst in lstMeetingHistory)
            {
                if (Convert.ToString(lst.meetingId) == Meetingid.ToString())
                {
                    LogMeIn.GoToMeeting.Api.Model.MeetingRecording lstMeetingRecording = lst.recording;
                    if (lstMeetingRecording != null)
                    {
                       /* if (lstMeetingRecording.shareUrl != null)
                        {
                            DownloadMeetingRecordingLink = Convert.ToString(lstMeetingRecording.shareUrl);
                        }*/
                        if (lstMeetingRecording.downloadUrl != null)
                        {
                            DownloadMeetingRecordingLink =Convert.ToString(lstMeetingRecording.downloadUrl);
                        }
                    }
                    break;
                }
            }

            //if (DownloadMeetingRecordingLink != "")
            //{
            //    SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            //    SqlCommand Scmd = new SqlCommand();
            //    Scmd.Connection = Scon;
            //    Scmd.CommandText = "[spUpdateMeetingMOMByScheduler]";
            //    Scmd.Parameters.AddWithValue("@ParticipantAssessorMappingId", RSPExerciseid);
            //    Scmd.Parameters.AddWithValue("@DownloadMeetingRecordingLink", DownloadMeetingRecordingLink);

            //    Scmd.CommandType = CommandType.StoredProcedure;
            //    Scmd.CommandTimeout = 0;
            //    Scon.Open();
            //    Scmd.ExecuteNonQuery();
            //    Scon.Close();
            //    Scon.Dispose();
            //}
            return DownloadMeetingRecordingLink;
        }
        catch (Exception ex)
        {
            return "1|" + ex.Message;
        }
    }
}