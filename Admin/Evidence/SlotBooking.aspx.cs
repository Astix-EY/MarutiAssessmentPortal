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

public partial class M3_Rating_RatingStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["LoginId"] != null && Session["LoginId"].ToString() != "")
            {
                hdnLogin.Value = Session["LoginId"].ToString();
                DateTime Start_date = DateTime.Now;
                DateTime Start_Time = Convert.ToDateTime("1/1/2000  10:00:00");
                int Date_Range = 30;
                int Time_Range = 18 - 10;

                string[] SkipHoliday = new string[2];
                SkipHoliday[0] = "Sat";
                SkipHoliday[1] = "Sun";

                fnCreatePlan(Start_date, Start_Time, Date_Range, Time_Range, SkipHoliday);
            }
            else
            {
                divStatus.InnerHtml = "<div style='text-align:center; width:100%; padding-top:20px; font-weight:bold; color:#ff0000;'>Session Expired. Please, Re-login !</div>";
            }
        }
    }
    private void fnCreatePlan(DateTime Start_date, DateTime Start_Time, int Date_Range, int Time_Range, string[] SkipHoliday)
    {
        divStatus.InnerHtml = CreateWeekTimetbl(Start_date, Start_Time, Date_Range, Time_Range, SkipHoliday);
    }
    private string CreateWeekTimetbl(DateTime Start_date, DateTime Start_Time, int Date_Range, int Time_Range, string[] SkipHoliday)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<table class='clstbl'>");
        sb.Append("<thead>");
        sb.Append("<tr>");
        for (int j = 0; j < Date_Range + 1; j++)
        {
            if (j == 0)
            {
                sb.Append("<th></th>");
            }
            else
            {
                sb.Append("<th>" + Start_date.AddDays(j - 1).ToString("dd-MMM, ddd") + "</th>");
            }            
        }
        sb.Append("</tr>");
        sb.Append("</thead>");
        sb.Append("<tbody>");

        for (int i = 0; i < Time_Range + 1; i++) 
        {
            sb.Append("<tr tr_index='"+ (i+1).ToString() +"'>");
            for (int j = 0; j < Date_Range + 1; j++)
            {
                if (j == 0)
                {
                    sb.Append("<td style='min-width:80px'>" + Start_Time.AddHours(i).ToString("hh:00") + " - " + Start_Time.AddHours(i + 1).ToString("hh:00") + "</td>");
                }
                else if(j == 1)
                {
                    if (!SkipHoliday.Contains(Start_date.AddDays(j - 1).ToString("ddd")))
                    {
                        if ((Convert.ToInt16(DateTime.Now.ToString("HH"))) < Convert.ToInt16(Start_Time.AddHours(i).ToString("HH")))
                        {
                            sb.Append("<td iden='tdAction' flgPast='0' flgBlocked='0' flgLocked='1' flgSelect='0' hr='" + Convert.ToInt16(Start_Time.AddHours(i).ToString("HH")) + "' dd='" + Start_date.AddDays(j - 1).ToString("dd-MMM-yyyy") + "'></td>");
                        }
                        else
                        {
                            sb.Append("<td title='Slot not available for Past Hours!' iden='tdAction' flgPast='1' flgBlocked='0' flgLocked='1' class='clsPast' flgSelect='0' hr='" + Convert.ToInt16(Start_Time.AddHours(i).ToString("HH")) + "' dd='" + Start_date.AddDays(j - 1).ToString("dd-MMM-yyyy") + "'></td>");
                        }
                    }
                    else
                    {
                        sb.Append("<td title='Slot not available for Holidays!' iden='tdAction' flgPast='1' flgBlocked='0' flgLocked='1' class='clsPast' flgSelect='0' hr='" + Convert.ToInt16(Start_Time.AddHours(i).ToString("HH")) + "' dd='" + Start_date.AddDays(j - 1).ToString("dd-MMM-yyyy") + "'></td>");
                    }
                }
                else
                {
                    if (!SkipHoliday.Contains(Start_date.AddDays(j - 1).ToString("ddd")))
                    {
                        sb.Append("<td iden='tdAction' flgPast='0' flgBlocked='0' flgLocked='1' flgSelect='0' hr='" + Convert.ToInt16(Start_Time.AddHours(i).ToString("HH")) + "' dd='" + Start_date.AddDays(j - 1).ToString("dd-MMM-yyyy") + "'></td>");
                    }
                    else
                    {
                        sb.Append("<td title='Slot not available for Holidays!' iden='tdAction' flgPast='1' flgBlocked='0' flgLocked='1' class='clsPast' flgSelect='0' hr='" + Convert.ToInt16(Start_Time.AddHours(i).ToString("HH")) + "' dd='" + Start_date.AddDays(j - 1).ToString("dd-MMM-yyyy") + "'></td>");
                    }
                }
            }
            sb.Append("</tr>");
        }
        sb.Append("</tbody>");
        sb.Append("</table>");
        return sb.ToString();
    }

    [System.Web.Services.WebMethod()]
    public static object fnGetDetail(string loginId)
    {
        if (loginId != "")
        {
            DataSet ds = new DataSet();
            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spGetAssesseeCalendar]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.CommandTimeout = 0;
            Scmd.Parameters.AddWithValue("@LoginId", loginId);
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            Sdap.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                object obj = JsonConvert.SerializeObject(ds, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
                return "0|@|" + obj.ToString();
            }
            else
                return "1|@|<div style='text-align:center; width:100%; padding-top:20px; font-weight:bold; color:#ff0000;'>No slot is currently available. Please try after some time or consult your BHR.</div>";
        }
        else
            return "1|@|<div style='text-align:center; width:100%; padding-top:20px; font-weight:bold; color:#ff0000;'>Session Expired. Please Re-login !</div>";
    }

    [System.Web.Services.WebMethod()]
    public static string fnSave(object udt_DataSaving, string LoginId)
    {
        try
        {
            string strDataSaving = JsonConvert.SerializeObject(udt_DataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            DataTable dtDataSaving = JsonConvert.DeserializeObject<DataTable>(strDataSaving);
            dtDataSaving.TableName = "AssessorBookedTimeSlot";
            if (dtDataSaving.Rows[0][0].ToString() == "0")
            {
                dtDataSaving.Rows[0].Delete();
            }

            DataSet ds = new DataSet();
            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spAssesseBookedTimeSlot]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.CommandTimeout = 0;
            Scmd.Parameters.AddWithValue("@AssessorBookedTimeSlot", dtDataSaving);
            Scmd.Parameters.AddWithValue("@LoginId ", LoginId);
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            Sdap.Fill(ds);

            if (ds.Tables[0].Rows[0][0].ToString() == "0")
            {
                return "0";
            }
            else
            {
                return "2";
            }

        }
        catch (Exception ex)
        {
            return "1";
        }
    }
}