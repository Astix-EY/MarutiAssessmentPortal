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

public partial class Data_Rpt_AssessorRating : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       // Session["LoginID"] = "3529";
        if (Session["LoginID"] == null)
        {
            Response.Redirect("../../AssessorLogin.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                hdnLoginID.Value = Session["LoginID"].ToString();
                hdnRSPExerciseId.Value = Request.QueryString["RSPExerciseId"].ToString();
                hdnflg.Value =  Request.QueryString["flg"].ToString();

                SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
                SqlCommand Scmd = new SqlCommand();
                Scmd.Connection = Scon;
                Scmd.CommandText = "[spRatingAssessorGetFullDetailsSubmitted]";
                Scmd.CommandType = CommandType.StoredProcedure;
                Scmd.Parameters.AddWithValue("@RSPExerciseId", hdnRSPExerciseId.Value);
                Scmd.Parameters.AddWithValue("@LoginId", hdnLoginID.Value);
                Scmd.CommandTimeout = 0;
                SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
                DataSet Ds = new DataSet();
                Sdap.Fill(Ds);

                string[] SkipColumn = new string[3];
                SkipColumn[0] = "ExcerciseRatingDetId";
                SkipColumn[1] = "ExerciseCompetencyPLMapID";
                SkipColumn[2] = "CompetencyType";

                if (hdnflg.Value == "2")
                {
                    if (Ds.Tables[3].Rows[0][0].ToString() == "1")
                    {
                        btnSave.Style.Add("display", "none");
                    }
                    else if (Ds.Tables[2].Rows.Count>0)
                    {
                        btnSave.Style.Add("display", "none");
                    }
                }
                else
                {
                    if (Ds.Tables[2].Rows.Count == 0)
                    {
                        fnIndividualExerciseSubmit(hdnRSPExerciseId.Value, hdnLoginID.Value,"1");
                    }
                    else
                    {
                        hdnValid.Value = "1";
                    }
                }
                divTask.InnerHtml = getTable(Ds, SkipColumn, "tblTasks");
            }
        }
    }

    private static string getTable(DataSet ds, string[] SkipColumn, string tbl)
    {
        StringBuilder sb = new StringBuilder();
        int Tcnt = 1;
        foreach (DataTable dt in ds.Tables)
        {
            if (dt.Rows.Count > 0)
            {
                if (Tcnt == 3)
                {
                    sb.Append("<div style='margin:5px 0px;color:#000;font-size:11pt' class='bg-warning'><b>Note : </b><i>You have selected the same behaviours across categories of thumps up/down/horizontal. Please change the conflicts before you proceed further.</i></div>");
                }
                    sb.Append("<div id='divmaincont" + Tcnt + "'><table id='" + tbl + Tcnt + "' style='margin-bottom:3px' class='table table-bordered bg-white table-sm clstblTask'>");
                sb.Append("<thead class='thead-light text-Left'>");
                sb.Append("<tr>");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                    {
                        sb.Append("<th>" + dt.Columns[j].ColumnName.ToString().Trim() + "</th>");
                    }
                }
                if (Tcnt == 3)
                {
                    sb.Append("<th></th>");
                }
                sb.Append("</tr>");
                sb.Append("</thead>");
                sb.Append("<tbody>");
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sb.Append("<tr>");
                    for (int j = 0; j < dt.Columns.Count; j++)
                    {
                        if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                        {
                            if (j > 1)
                            {
                                if (dt.Rows[i][j].ToString() == "")
                                {
                                    sb.Append("<td class='clsColorBGGrayout'></td>");
                                }
                                else
                                {
                                    if (Tcnt == 1)
                                    {
                                        sb.Append("<td style='vertical-align:middle;'><table>");
                                        string[] strArr = dt.Rows[i][j].ToString().Trim().Split('|');
                                        for (int k = 0; k < strArr.Length; k++)
                                        {
                                            sb.Append("<tr class='clsColor'><td class='cls_" + strArr[k].Split('^')[1] + "'>" + strArr[k].Split('^')[0] + "</td></tr>");
                                        }
                                        sb.Append("</table></td>");
                                    }
                                    else if (Tcnt == 2)
                                    {
                                        if (dt.Rows[i][j].ToString().Split('^').Length == 2)
                                        {
                                            sb.Append("<td style='vertical-align:middle;font-size:8pt;text-align:center' class='clsScore_" + dt.Rows[i][j].ToString().Split('^')[1] + "'>" + dt.Rows[i][j].ToString().Split('^')[0] + "</td>");
                                        }
                                        else
                                        {
                                            sb.Append("<td style='vertical-align:middle;text-align:center' >" + dt.Rows[i][j].ToString() + "</td>");
                                        }
                                    }
                                    else {
                                        if (dt.Columns[j].ColumnName.ToString().ToLower() == "rating")
                                        {
                                            sb.Append("<td style='vertical-align:middle;font-size:8pt;text-align:center;vertical-align:middle;width:8%' >" + fnFillRatingOption(dt.Rows[i]["rating"].ToString(), dt.Rows[i]["ExcerciseRatingDetId"].ToString(), dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString()) + "</td>");
                                        }
                                        else if (dt.Columns[j].ColumnName.ToString().ToLower() == "pl")
                                        {
                                            sb.Append("<td style='vertical-align:middle;text-align:center;width:3%' >" + dt.Rows[i][j].ToString() + "</td>");
                                        }
                                        else if (dt.Columns[j].ColumnName.ToString().ToLower() == "plbehaviour")
                                        {
                                            if (i > 0)
                                            {
                                                if ((dt.Rows[i]["PLBehaviour"].ToString() == dt.Rows[i - 1]["PLBehaviour"].ToString()) == false)
                                                {
                                                    sb.Append("<td class='mergerow' iden='pl'  pl='" + HttpUtility.HtmlEncode(dt.Rows[i]["PLBehaviour"].ToString()) + "' rowspan=" + dt.Select("PLBehaviour= '" + dt.Rows[i]["PLBehaviour"].ToString().Replace("'", "''") + "'").Length + " >" + dt.Rows[i][dt.Columns[j].ColumnName].ToString() + "</td>");
                                                }
                                            }
                                            else
                                            {
                                                sb.Append("<td  class='mergerow' iden='pl' pl='" + HttpUtility.HtmlEncode(dt.Rows[i]["PLBehaviour"].ToString()) + "' rowspan=" + dt.Select("PLBehaviour = '" + dt.Rows[i]["PLBehaviour"].ToString().Replace("'", "''") + "'").Length + " >" + dt.Rows[i][dt.Columns[j].ColumnName].ToString() + "</td>");
                                            }
                                        }
                                        else
                                        {
                                            sb.Append("<td style='vertical-align:middle;text-align:left' >" + dt.Rows[i][j].ToString() + "</td>");
                                        }
                                    }
                                }
                            }
                            else
                            {
                                sb.Append("<td style='font-size:8.8pt'>" + dt.Rows[i][j].ToString() + "</td>");
                            }
                        }

                    }
                    if (Tcnt == 3)
                    {
                        sb.Append("<td style='width:2%;text-align:center'  pl='" +HttpUtility.HtmlEncode(dt.Rows[i]["PLBehaviour"].ToString()) + "'><a href='###' ExcerciseRatingDetId='" + dt.Rows[i]["ExcerciseRatingDetId"].ToString() + "' ExerciseCompetencyPLMapID='" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' onclick=\"fnDeleteOrUpdateRating(this,1)\" ><i class='fa fa-trash' ></i></a></td>");
                    }
                    sb.Append("</tr>");
                }
                sb.Append("</tbody>");
                sb.Append("</table></div>");
            }
            else
            {
                if (Tcnt == 3) { 
                    sb.Append("");
                }
                else
                {
                    sb.Append("<span style='color:#ff0000; font-weight:bold; padding-left:11px;'>No Record/s Found !</span>");
                }
            }
            Tcnt++;
            if (Tcnt ==4)
            {
                break;
            }
        }
        return sb.ToString();
    }

    public static string fnFillRatingOption(string Id,string ExcerciseRatingDetId,string ExerciseCompetencyPLMapID)
    {
        StringBuilder sb = new StringBuilder();
        for(int i = 1; i < 4; i++)
        {
            if (i ==1)
            {
                sb.Append("<label><input type='radio' id='" + ExcerciseRatingDetId + "_" + ExerciseCompetencyPLMapID+"_"+i.ToString() + "' oldrating='" + Id + "' name='"+ ExcerciseRatingDetId+"_"+ ExerciseCompetencyPLMapID + "' ExcerciseRatingDetId='" + ExcerciseRatingDetId + "' ExerciseCompetencyPLMapID='" + ExerciseCompetencyPLMapID + "' onclick=\"fnDeleteOrUpdateRating(this,2)\"  value='" + i.ToString() + "' " + (Id == i.ToString() ? "checked" : "") + "><img for='" + ExcerciseRatingDetId + "_" + ExerciseCompetencyPLMapID + "_" + i.ToString() + "' src='../../images/icons/thumbs-up.png' style='width:20px'/></label>");
            }
            else if (i == 2)
            {
                sb.Append("<label style='margin:0px 15px'><input type='radio' id='" + ExcerciseRatingDetId + "_" + ExerciseCompetencyPLMapID + "_" + i.ToString() + "' oldrating='" + Id + "' name='" + ExcerciseRatingDetId + "_" + ExerciseCompetencyPLMapID + "' ExcerciseRatingDetId='" + ExcerciseRatingDetId + "' ExerciseCompetencyPLMapID='" + ExerciseCompetencyPLMapID + "' onclick=\"fnDeleteOrUpdateRating(this,2)\" value='" + i.ToString() + "' " + (Id == i.ToString() ? "checked" : "") + "><img for='" + ExcerciseRatingDetId + "_" + ExerciseCompetencyPLMapID + "_" + i.ToString() + "' src='../../images/icons/thumbs-pointer.png' style='width:20px'/></label>");
            }
            else
            {
                sb.Append("<label><input type='radio' id='" + ExcerciseRatingDetId + "_" + ExerciseCompetencyPLMapID + "_" + i.ToString() + "' oldrating='" + Id + "' name='" + ExcerciseRatingDetId + "_" + ExerciseCompetencyPLMapID + "' ExcerciseRatingDetId='" + ExcerciseRatingDetId + "' ExerciseCompetencyPLMapID='" + ExerciseCompetencyPLMapID + "' onclick=\"fnDeleteOrUpdateRating(this,2)\" value='" + i.ToString() + "' " + (Id == i.ToString() ? "checked" : "") + "><img for='" + ExcerciseRatingDetId + "_" + ExerciseCompetencyPLMapID + "_" + i.ToString() + "' src='../../images/icons/thumbs-down.png' style='width:20px'/></label>");
            }
        }
        return sb.ToString();
    }


    [System.Web.Services.WebMethod()]
    public static string fnIndividualExerciseSubmit(string RSPExerciseid, string LoginId,string flg)
    {
        try
        {
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            Scon.Open();
            int IsDuplicatePLExist = 0;
            if (flg == "2")
            {
                SqlCommand Scmd = new SqlCommand();
                Scmd.Connection = Scon;
                Scmd.CommandText = "[spRatingAssessorCheckForDuplicityOfPL]";
                Scmd.CommandType = CommandType.StoredProcedure;
                Scmd.Parameters.AddWithValue("@RSPExerciseid", RSPExerciseid);
                Scmd.CommandTimeout = 0;
                IsDuplicatePLExist = (int)Scmd.ExecuteScalar();
            }
            if (IsDuplicatePLExist == 0)
            {
                SqlCommand Scmd1 = new SqlCommand();
                Scmd1.Connection = Scon;
                Scmd1.CommandText = "[spRatingAssessorFinalSubmit]";
                Scmd1.CommandType = CommandType.StoredProcedure;
                Scmd1.Parameters.AddWithValue("@RSPExerciseid", RSPExerciseid);
                Scmd1.Parameters.AddWithValue("@LoginId", LoginId);
                Scmd1.CommandTimeout = 0;
                Scmd1.ExecuteNonQuery();
            }

            Scon.Close();
            Scon.Dispose();
            return IsDuplicatePLExist.ToString();
        }
        catch (Exception ex)
        {
            return "2|"+ex.Message;
        }
    }


    [System.Web.Services.WebMethod()]
    public static string fnFinalSubmit(string RSPExerciseid, string LoginId)
    {
        try
        {
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spRatingAssessorOverallFinalSubmit]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@RSPExerciseId", RSPExerciseid);
            Scmd.Parameters.AddWithValue("@LoginId", LoginId);
            Scmd.CommandTimeout = 0;
            Scon.Open();
            Scmd.ExecuteNonQuery();
            Scon.Close();
            Scon.Dispose();
            return "0";
        }
        catch (Exception ex)
        {
            return "1|";
        }
    }
}