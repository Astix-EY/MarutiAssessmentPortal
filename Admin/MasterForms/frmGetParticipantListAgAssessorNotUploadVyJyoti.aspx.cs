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

public partial class Admin_Evidence_frmGetParticipantListAgAssessor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginID"] == null)
        {
            Response.Redirect("~/AssessorLogin.aspx");
            return;
        }
        if (!IsPostBack)
        {
            hdnLoginId.Value = Session["LoginID"].ToString();
        }
    }
    [System.Web.Services.WebMethod()]
    public static string fnGetParticipantDetails(int CycleID,int loginId,int flgCallType)
    {
        DataSet ds = new DataSet();
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "[spGetParticipantMeetingDetailsAgAssessor]";
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

        string[] SkipColumn = new string[18];
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
                                if(dt.Columns[j].ColumnName.ToString()== "MeetingActualStartTime")
                                {
                                    sb.Append("<th rowspan='" + ColSpliter.Length + "' style='width:10%' >" + ColSpliter[k] + "</th>");
                                }else if(dt.Columns[j].ColumnName.ToString()== "Status")
                                {
                                    sb.Append("<th rowspan='" + ColSpliter.Length + "' style='width:22%' >" + ColSpliter[k] + "</th>");
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
                sb.Append("<th style='width:11.5%'>Action</th>");
                sb.Append("</tr>");
            }
            sb.Append("</thead>");
            sb.Append("<tbody>");
            string[] rowspanColumn = new string[1];
            rowspanColumn[0] = "ParticipantName";
            foreach (DataRow Row in ds.Tables[0].Rows)
            {
                sb.Append("<tr participantid='" + Row["ParticipantId"].ToString() + "' exerciseid='" + Row["exerciseid"].ToString() + "'>"); 
                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(ds.Tables[0].Columns[j].ColumnName.ToString()))
                    {
                        if (rowspanColumn.Contains(ds.Tables[0].Columns[j].ColumnName))
                        {
                            int Row_Span = 0;
                            DataRow drows = null;
                            Row_Span = dt.Select("[ParticipantId]='" + Row["ParticipantId"].ToString() + "'").Count();
                            drows = dt.Select("[ParticipantId]='" + Row["ParticipantId"].ToString() + "'")[0];
                            if (Row_Span > 1)
                            {
                                if (Row == drows)
                                {
                                    sb.Append(string.Format("<td rowspan='{0}'>{1}</td>", Row_Span, Row[ds.Tables[0].Columns[j].ColumnName]));
                                }
                            }
                            else
                            {
                                sb.Append(string.Format("<td >{1}</td>", Row_Span, Row[ds.Tables[0].Columns[j].ColumnName]));
                            }
                        }
                        else
                        {
                            if(ds.Tables[0].Columns[j].ColumnName== "MeetingActualStartTime")
                            {
                                sb.Append("<td iden='mast'>" + Row[ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }else if (ds.Tables[0].Columns[j].ColumnName == "Status")
                            {
                                sb.Append("<td iden='mstatus'>" + Row[ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }
                            else
                            {
                                sb.Append("<td>" + Row[ds.Tables[0].Columns[j].ColumnName].ToString() + "</td>");
                            }
                                

                        }
                    }
                }
                if (Row["flgShowLink"].ToString() == "1")
                {
                    sb.Append("<td><a href='###' onclick='fnStartMeeting(this)' rspexerciseid='" + Row["rspexerciseid"].ToString() + "' meetinglink='" + Row["AssessorMeetingLink"].ToString() + "' class='btn btn-primary' style='padding:0px 4px' >Start Meeting</a></td>");
                }
                else
                {
                    sb.Append("<td><a href='###' onclick='fnStartMeeting(this)' rspexerciseid='" + Row["rspexerciseid"].ToString() + "' meetinglink='" + Row["AssessorMeetingLink"].ToString() + "'  class='btn btn-primary'  style='display:none;padding:0px 4px'>Start Meeting</a></td>");
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
    public static string fnUpdateActualStartEndTime(string RSPExerciseid, int UserTypeID, string flgAction)
    {
        try
        {
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spUpdateActualStartEndTime]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@RSPExerciseid", RSPExerciseid);
            Scmd.Parameters.AddWithValue("@UserTypeID", UserTypeID);
            Scmd.Parameters.AddWithValue("@flgAction", flgAction);
            Scmd.CommandTimeout = 0;
            Scon.Open();
            Scmd.ExecuteNonQuery();
            Scon.Close();
            Scon.Dispose();
            return "0";
        }
        catch (Exception ex)
        {
            return "1^" + ex.Message;
        }
    }
}