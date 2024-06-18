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

public partial class frmAsseesorRating : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["LoginId"] == null)
        {
            Response.Redirect("../../AssesorLogin.aspx");
            return;
        }


        if (!IsPostBack)
        {
            hdnLogin.Value = Session["LoginId"].ToString();
            hdnRSPExId.Value = Request.QueryString["str"].ToString();
            frmGetExerciseDetail();
        }
    }
    private void frmGetExerciseDetail()
    {
        DataSet ds = new DataSet();
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "[spRatingAssessorGetApplicableSubCompList]";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        Scmd.Parameters.AddWithValue("@RSPExerciseId", hdnRSPExId.Value);
        Scmd.Parameters.AddWithValue("@LoginId", hdnLogin.Value);

        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        Sdap.Fill(ds);

        StringBuilder sb = new StringBuilder();
        sb.Append("<div id='dvleftList' style='overflow-y:auto;'><ul id='ulmain' class='ulmain'>");
        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
        {
            string flgCompetency = ds.Tables[0].Rows[i]["flgCompetency"].ToString();
            if (ds.Tables[0].Rows[i]["IsOpen"].ToString() == "1")
            {
                sb.Append("<li onclick='fnMailDetails(this);' ExcerciseRatingDetId='" + ds.Tables[0].Rows[i]["ExcerciseRatingDetId"].ToString() + "' class='clsOpen'><b>" + ds.Tables[0].Rows[i]["SubCompetencyName"].ToString() + "</b></li>");
            }
            else {
                if (flgCompetency == "0")
                {
                    sb.Append("<li onclick='fnMailDetails(this);' ExcerciseRatingDetId='" + ds.Tables[0].Rows[i]["ExcerciseRatingDetId"].ToString() + "' class='clsNotOpen'><b>" + ds.Tables[0].Rows[i]["SubCompetencyName"].ToString() + "</b></li>");
                }
                else {
                    sb.Append("<li onclick='fnMailDetails(this);' ExcerciseRatingDetId='" + ds.Tables[0].Rows[i]["ExcerciseRatingDetId"].ToString() + "' class='clsNotOpen clsOpenComptency'><b>" + ds.Tables[0].Rows[i]["SubCompetencyName"].ToString() + "</b></li>");
                }
            }
        }
        sb.Append("</ul>");

        sb.Append("</div><div class='text-center mt-3'><a href='#' onclick='fnSubmit()' class='btn btn-outline-light'>Submit For Task</a></div>");

        divleft.InnerHtml = sb.ToString();
        tdUserCode.InnerHtml = ds.Tables[1].Rows[0]["UserCode"].ToString();
        tdCaseStudy.InnerHtml = ds.Tables[1].Rows[0]["ExerciseName"].ToString();
    }

    [System.Web.Services.WebMethod()]
    public static object fnGetDetailRpt(string ExcerciseRatingDetId)
    {
        DataSet ds = new DataSet();
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "[spRatingAssessorGetResponsesForSubComp]";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        Scmd.Parameters.AddWithValue("@ExcerciseRatingDetId", ExcerciseRatingDetId);
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        Sdap.Fill(ds);

        if (ds.Tables[1].Rows.Count > 0)
        {

            return createStoretbl(ds, ExcerciseRatingDetId);
        }
        else
            return "";
    }

    private static string createStoretbl(DataSet ds, string ExcerciseRatingDetId)
    {
        DataTable dt = ds.Tables[1];
        DataTable dtScore = ds.Tables[0];
        DataTable dtCues = ds.Tables[2];
        string[] SkipColumn = new string[1];
        SkipColumn[0] = "ExcerciseRatingDetId";
        StringBuilder sb = new StringBuilder();
        StringBuilder sbScore = new StringBuilder();
        string[] arrScore= new string[7];
        arrScore[0] = "1";
        arrScore[1] = "1.5";
        arrScore[2] = "2";
        arrScore[3] = "2.5";
        arrScore[4] = "3";
        arrScore[5] = "3.5";
        arrScore[6] = "4";
        sbScore.Append("<option value='0.0' selected>--Select Score--</option>");
        for (int c=0; c < arrScore.Length; c++)
        {
            if (arrScore[c].ToString()==Convert.ToString(dtScore.Rows[0][0])){
                sbScore.Append("<option value='"+ arrScore[c].ToString() + "' selected>"+ arrScore[c].ToString() + "</option>");
            }
            else
            {
                sbScore.Append("<option value='" + arrScore[c].ToString() + "' >" + arrScore[c].ToString() + "</option>");
            }
        }
       

        sb.Append("<table><tr><td><b>Sub Competency Score : </b></td><td style='padding-left:5px'><select id='txt_" + ExcerciseRatingDetId + "' style='border:1px solid #bbb;text-align:center;width:120px' onchange='fnRatingAssessorSaveSubCompetencyScore(this)'>" + sbScore + "</select></td></tr></table>");
        if (dt.Rows.Count > 0)
        {

            sb.Append("<div><table id='tbl_Ans' class='table table-sm bg-white' style='font-size:11pt;border-left:1px solid #bbb'>");
            sb.Append("<tbody>");
            string OldPLID = "0";
            int cntTot = 0;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string PLID = dt.Rows[i]["PLID"].ToString();
                if (PLID != OldPLID)
                {
                    if (OldPLID != "0")
                    {
                        DataRow[] drowCues = dtCues.Select("plid=" + PLID);
                        if (drowCues.Length > 0)
                        {
                            sb.Append("<tr>");
                            sb.Append("<td colspan='5'  class='clsCues'>" + createCuetbl(drowCues.CopyToDataTable()) + "</td>");
                            sb.Append("</tr>");
                        }
                    }
                    sb.Append("<tr class='bg-blue text-white'>");
                    sb.Append("<td><b>" + dt.Rows[i]["PLDescr"].ToString() + "</b></td>");
                    sb.Append("<td style='width:8%;text-align:center'><img src='../../images/icons/thumbs-up.png' style='width:20px' /></td>");
                    sb.Append("<td style='width:8%;text-align:center'><img src='../../images/icons/thumbs-pointer.png' style='width:20px' /></td>");
                    sb.Append("<td style='width:8%;text-align:center'><img src='../../images/icons/thumbs-down.png'  style='width:20px' /></td>");
                    sb.Append("<td style='width:3%;text-align:center'></td>");

                    sb.Append("</tr>");
                }
                sb.Append("<tr ExerciseCompetencyPLMapID='" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' PLID='" + dt.Rows[i]["PLID"].ToString() + "' >");
                sb.Append("<td>" + dt.Rows[i]["PlStatemenst"].ToString() + "</td>");
                if (dt.Rows[i]["Rating 1^1"].ToString() == "1")
                {
                    sb.Append("<td class='clsBGGreen' style='text-align:center'><input type='radio' value='1' name='evi_" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' flg='0' onclick='fnRatingAssessorSavePLListForSubCompetency(this)' checked></td>");
                }
                else
                {
                    sb.Append("<td class='clsInput' style='text-align:center'><input type='radio'  value='1'  name='evi_" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' onclick='fnRatingAssessorSavePLListForSubCompetency(this)' flg='0'></td>");
                }
                if (dt.Rows[i]["Rating 2^2"].ToString() == "1")
                {
                    sb.Append("<td class='clsBGOrange' style='text-align:center'><input type='radio' value='2' name='evi_" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' flg='0' onclick='fnRatingAssessorSavePLListForSubCompetency(this)' checked></td>");
                }
                else
                {
                    sb.Append("<td class='clsInput' style='text-align:center'><input type='radio'  value='2'  name='evi_" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' onclick='fnRatingAssessorSavePLListForSubCompetency(this)' flg='0'></td>");
                }

                if (dt.Rows[i]["Rating 3^3"].ToString() == "1")
                {
                    sb.Append("<td class='clsBGRed' style='text-align:center'><input type='radio' value='3' name='evi_" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' onclick='fnRatingAssessorSavePLListForSubCompetency(this)' flg='0' checked></td>");
                }
                else
                {
                        sb.Append("<td class='clsInput' style='text-align:center'><input type='radio'  value='3'  name='evi_" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' onclick='fnRatingAssessorSavePLListForSubCompetency(this)' flg='0'></td>");
                }
                if (dt.Rows[i]["Rating 1^1"].ToString() == "1" || dt.Rows[i]["Rating 2^2"].ToString() == "1"  || dt.Rows[i]["Rating 3^3"].ToString() == "1")
                {
                    sb.Append("<td style='width:3%;text-align:center'><i class='fa fa-undo' onclick='fnDeleteResponse(this)' ></i></td>");
                }
                else
                {
                    sb.Append("<td style='width:3%;text-align:center'><i class='fa fa-undo' onclick='fnDeleteResponse(this)' style='display:none' ></i></td>");
                }
                    
                sb.Append("</tr>");
                cntTot++;
                if (cntTot == dt.Rows.Count)
                {
                    DataRow[] drowCues = dtCues.Select("plid=" + PLID);
                    if (drowCues.Length > 0)
                    {
                        sb.Append("<tr>");
                        sb.Append("<td colspan='5' class='clsCues'>" + createCuetbl(drowCues.CopyToDataTable()) + "</td>");
                        sb.Append("</tr>");
                    }
                }

                OldPLID = PLID;
            }
            sb.Append("</tbody>");
            sb.Append("</table></div>");
            return sb.ToString();
        }
        else
        {
            return "<div style='font-size:13px; padding : 10px 20px; color:red; font-weight:bold;'>No Record Found !</div>";
        }
    }

    private static string createCuetbl(DataTable dt)
    {

        string[] SkipColumn = new string[1];
        SkipColumn[0] = "ExcerciseRatingDetId";
        StringBuilder sb = new StringBuilder();
        if (dt.Rows.Count > 0)
        {

            sb.Append("<table style='width:100%;border-style:none' border='0'>");
            sb.Append("<tbody>");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sb.Append("<tr ExerciseCompetencyPLMapID='" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' PLID='" + dt.Rows[i]["PLID"].ToString() + "' >");
                sb.Append("<td style='border-top:none'>" + dt.Rows[i]["Cue"].ToString() + "</td>");
                sb.Append("</tr>");
            }
            sb.Append("</tbody>");
            sb.Append("</table>");

        }
        return sb.ToString();
    }

    [System.Web.Services.WebMethod()]
    public static string fnSave(string AnsVal, object udt_DataSaving, string ExcerciseRatingDetId)
    {
        try
        {
            string strDataSaving = JsonConvert.SerializeObject(udt_DataSaving, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            DataTable dtDataSaving = JsonConvert.DeserializeObject<DataTable>(strDataSaving);
            dtDataSaving.TableName = "udt_DataSaving";
            if (dtDataSaving.Rows[0][0].ToString() == "0")
            {
                dtDataSaving.Rows[0].Delete();
            }

            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spRatingAssessorSaveResponsesForSubComp]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@ExcerciseRatingDetId", ExcerciseRatingDetId);
            Scmd.Parameters.AddWithValue("@AnsVal", AnsVal);
            Scmd.Parameters.AddWithValue("@tmpPLListWithRating", dtDataSaving);
            Scmd.CommandTimeout = 0;
            Scon.Open();
            Scmd.ExecuteNonQuery();
            Scon.Close();
            Scon.Dispose();
            return "0";
        }
        catch (Exception ex)
        {
            return "1|" + ex.Message;
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
            Scmd.CommandText = "[spRatingAssessorFinalSubmit]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@RSPExerciseid", RSPExerciseid);
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
            return "1";
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnRatingAssessorSaveSubCompetencyScore(string ExcerciseRatingDetId, string AnsVal)
    {
        try
        {
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spRatingAssessorSaveSubCompetencyScore]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@ExcerciseRatingDetId", ExcerciseRatingDetId);
            Scmd.Parameters.AddWithValue("@AnsVal", AnsVal);
            Scmd.CommandTimeout = 0;
            Scon.Open();
            Scmd.ExecuteNonQuery();
            Scon.Close();
            Scon.Dispose();
            return "0";
        }
        catch (Exception ex)
        {
            return "1";
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnRatingAssessorSavePLListForSubCompetency(int ExcerciseRatingDetId, int ExerciseCompetencyPLMapID,int RatingId)
    {
        try
        {
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spRatingAssessorSavePLListForSubCompetency]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@ExcerciseRatingDetId", ExcerciseRatingDetId);
            Scmd.Parameters.AddWithValue("@ExerciseCompetencyPLMapID", ExerciseCompetencyPLMapID);
            Scmd.Parameters.AddWithValue("@RatingId", RatingId);
            Scmd.CommandTimeout = 0;
            Scon.Open();
            Scmd.ExecuteNonQuery();
            Scon.Close();
            Scon.Dispose();
            return "0";
        }
        catch (Exception ex)
        {
            return "1|"+ex.Message;
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnFinalReview(string RSPExerciseid, string LoginId)
    {
        try
        {
            DataSet ds = new DataSet();
            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spRatingAssessorGetRSPExerciseFullDetail_PopUp]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.CommandTimeout = 0;
            Scmd.Parameters.AddWithValue("@RSPExerciseId", RSPExerciseid);
            Scmd.Parameters.AddWithValue("@LoginId", LoginId);
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            Sdap.Fill(ds);

            return "0|" + CreateFinalReviewQuestion(ds);
        }
        catch (Exception ex)
        {
            return "1|";
        }
    }

    private static string createStoretblFinalReview(DataSet ds, string SubcompetencyId)
    {
        StringBuilder sb = new StringBuilder();
        if (ds.Tables[1].Select("SubCompetencyID=" + SubcompetencyId).Length > 0)
        {
            DataTable dt = ds.Tables[1].Select("SubCompetencyID=" + SubcompetencyId).CopyToDataTable();
            DataTable dtScore = ds.Tables[0].Select("SubCompetencyID=" + SubcompetencyId).CopyToDataTable();
            string[] SkipColumn = new string[1];
            SkipColumn[0] = "ExcerciseRatingDetId";
           
            string scrore = "";
            if (ds.Tables[0].Select("SubCompetencyID=" + SubcompetencyId).Length > 0)
            {
                scrore = Convert.ToString(dtScore.Rows[0][1]);
            }
            sb.Append("<table><tr><td><b>Sub Competency Score : </b></td><td style='padding-left:5px'>" + scrore + "</td></tr></table>");
            if (dt.Rows.Count > 0)
            {

                sb.Append("<div><table id='tbl_Ans1' class='clsAns'>");
                sb.Append("<tbody>");
                string OldPLID = "0";
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string PLID = dt.Rows[i]["PLID"].ToString();
                    if (PLID != OldPLID)
                    {
                        sb.Append("<tr>");
                        sb.Append("<td><b>" + dt.Rows[i]["PLDescr"].ToString() + "</b></td>");
                        sb.Append("<td><b>Rating</b></td>");
                        sb.Append("</tr>");
                    }
                    sb.Append("<tr ExerciseCompetencyPLMapID='" + dt.Rows[i]["ExerciseCompetencyPLMapID"].ToString() + "' PLID='" + dt.Rows[i]["PLID"].ToString() + "' >");
                    sb.Append("<td>" + dt.Rows[i]["PlStatemenst"].ToString() + "</td>");
                    string strImgPath = "";
                    if (dt.Rows[i]["RatingID"].ToString() == "1")
                    {
                        strImgPath = "../../Images/Icons/thumbs-up.png";
                    }
                    else if (dt.Rows[i]["RatingID"].ToString() == "2")
                    {
                        strImgPath = "../../Images/Icons/thumbs-pointer.png";
                    }
                    else
                    {
                        strImgPath = "../../Images/Icons/thumbs-down.png";
                    }
                    sb.Append("<td><img src='" + strImgPath + "' style='width:25px'/></td>");

                    sb.Append("</tr>");
                    OldPLID = PLID;
                }
                sb.Append("</tbody>");
                sb.Append("</table></div>");
            }
        }
        return sb.ToString();
    }

    private static string CreateFinalReviewQuestion(DataSet ds)
    {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
        {
            string SubCompetencyId = ds.Tables[2].Rows[i]["SubCompetencyID"].ToString();

            sb.Append("<div class='clsReviewBlock'>");
            if (i == ds.Tables[2].Rows.Count - 1)
            {
                sb.Append("<div class='clsReviewHead' flg='0' onclick='fnShowHideReviewBlock(this);'>");
                sb.Append("<table>");
                sb.Append("<tr>");
                sb.Append("<td class='clsMaillbl' style='width: 20px; padding-top:4px;'><img alt='' src='../../Images/Icons/iconDel.gif' style='width: 12px; cursor: pointer;' /></td>");
                sb.Append("<td class='clsMaillbl' style='padding-top:4px; font-weight:100;'>" + ds.Tables[2].Rows[i]["SubCompetencyName"].ToString().Replace("'", "\"").Replace("<br>", " ") + "</td>");
                sb.Append("</tr>");
                sb.Append("</table>");
                sb.Append("</div>");
                sb.Append("<div class='clsReviewBody'>" + createStoretblFinalReview(ds, SubCompetencyId) + "</div>");
            }
            else
            {
                sb.Append("<div class='clsReviewHead' flg='1' onclick='fnShowHideReviewBlock(this);'>");
                sb.Append("<table>");
                sb.Append("<tr>");
                sb.Append("<td class='clsMaillbl' style='width: 20px; padding-top:4px;'><img alt='' src='../../Images/Icons/iconAdd.gif' style='width: 12px; cursor: pointer;' /></td>");
                sb.Append("<td class='clsMaillbl' style='padding-top:4px; font-weight:100;'>" + ds.Tables[2].Rows[i]["SubCompetencyName"].ToString().Replace("'", "\"").Replace("<br>", " ") + "</td>");
                sb.Append("</tr>");
                sb.Append("</table>");
                sb.Append("</div>");
                sb.Append("<div class='clsReviewBody' style='display:none;'>" + createStoretblFinalReview(ds, SubCompetencyId) + "</div>");
            }
            sb.Append("</div>");
        }

        return sb.ToString();
    }

    private static string CreateFinalReviewQuestionWiseResponse(DataTable dt)
    {
        string[] SkipColumn = new string[4];
        SkipColumn[0] = "QstnID";
        SkipColumn[1] = "Question";
        SkipColumn[2] = "MailOrderNo";
        SkipColumn[3] = "ResponseDetId";

        if (dt.Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<table id='tbl_Response' class='clstblResponse'>");
            sb.Append("<thead >");
            sb.Append("<tr>");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Split('^')[0].Trim()))
                {
                    sb.Append("<th style=''>" + dt.Columns[j].ColumnName.ToString().Split('^')[0] + "</th>");
                }
            }
            sb.Append("</tr>");
            sb.Append("</thead>");
            sb.Append("<tbody>");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                switch (dt.Rows[i]["Selected Response"].ToString())
                {
                    case "Yes":
                        sb.Append("<tr class='clsAnsYes'>");
                        break;
                    case "Demonstrated":
                        sb.Append("<tr class='clsAnsYes'>");
                        break;
                    case "Partially Demonstrated":
                        sb.Append("<tr class='clsAnsPartialYes'>");
                        break;
                    default:
                        sb.Append("<tr class='clsAnsNo'>");
                        break;
                }

                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString()))
                    {
                        sb.Append("<td>" + dt.Rows[i][j].ToString().Replace("'", "\"") + "</td>");
                    }
                }
                sb.Append("</tr>");
            }
            sb.Append("</tbody>");
            sb.Append("</table>");
            return sb.ToString();
        }
        else
        {
            return "<div style='font-size:13px; padding : 10px 20px; color:red; font-weight:bold;'>No Record Found !</div>";
        }
    }
}