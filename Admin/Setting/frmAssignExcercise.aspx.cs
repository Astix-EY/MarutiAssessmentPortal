using Ionic.Zip;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class M3_Rating_RatingStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginId"] != null && Session["LoginId"].ToString() != "")
        {
            hdnLogin.Value = Session["LoginId"].ToString();
            frmGetStatus(Session["LoginId"].ToString(), Session["CycleId"].ToString());
        }
        else
        {
            Response.Redirect("../../Login.aspx");
        }
    }
    private void frmGetStatus(string loginId, string CycleId)
    {
        DataSet ds = new DataSet();
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "[spAssessorAssignGetExcerciseList]";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        Scmd.Parameters.AddWithValue("@CycleId", CycleId);
        Scmd.Parameters.AddWithValue("@LoginId", loginId);
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        Sdap.Fill(ds);

        divStatus.InnerHtml = createStoretbl(ds, 1, true);
        divLegend.InnerHtml = LegendMstr(ds.Tables[1]);
        hdnAssessorMstr.Value = AssessorMstr(ds.Tables[2]);
    }
    private string createStoretbl(DataSet ds, int headerlvl, bool IsHeader)
    {
        StringBuilder sbColor = new StringBuilder();
        DataTable dt = ds.Tables[0];
        dt.Columns.Add("User Response");
        string[] SkipColumn = new string[1];
        SkipColumn[0] = "EmpNodeId";

        if (ds.Tables[0].Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<table id='tbl_Status' class='clstbl'>");
            sb.Append("<thead >");
            string[] Collength = dt.Columns[2].ColumnName.ToString().Split('|')[0].Split('^');
            for (int k = 0; k < Collength.Length; k++)
            {
                sb.Append("<tr>");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Split('|')[0].Trim()))
                    {
                        string[] ColSpliter = (dt.Columns[j].ColumnName.ToString().Split('|')[0].Trim()).Split('^');
                        if (ColSpliter[k] != "")
                        {
                            if (string.Join("", ColSpliter) == ColSpliter[k])
                            {
                                if (ColSpliter[k].Trim() == "Report Download")
                                {
                                    sb.Append("<th rowspan='" + ColSpliter.Length + "' style=''>" + ColSpliter[k] + " <input type='checkbox' onclick='fnCheckUncheck(this);' /></th>");
                                }
                                else
                                {
                                    sb.Append("<th rowspan='" + ColSpliter.Length + "' style=''>" + ColSpliter[k] + "</th>");
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
                sb.Append("</tr>");
            }
            sb.Append("</thead>");
            sb.Append("<tbody>");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                sb.Append("<tr EmpNodeId='" + ds.Tables[0].Rows[i]["EmpNodeId"].ToString() + "'>");
                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(ds.Tables[0].Columns[j].ColumnName.ToString().Split('|')[0].Trim()))
                    {
                        if (ds.Tables[0].Rows[i][j].ToString().Split('^').Length > 2)
                        {
                            sbColor.Clear();
                            switch (ds.Tables[0].Rows[i][j].ToString().Split('^')[0])
                            {
                                case "1":
                                    sbColor.Append("color: #ffffff; background-color: #ff0000;");
                                    break;
                                case "2":
                                    sbColor.Append("color: #000000; background-color: #ff9b9b;");
                                    break;
                                case "3":
                                    sbColor.Append("color: #000000; background-color: #80ff80;");
                                    break;
                                case "4":
                                    sbColor.Append("color: #000000; background-color: #8080ff;");
                                    break;
                                case "5":
                                    sbColor.Append("color: #ffffff; background-color: #8000ff;");
                                    break;
                                case "6":
                                    sbColor.Append("color: #ffffff; background-color: #0000a0;");
                                    break;
                                default:
                                    sbColor.Append("color: #000000; background-color: transparent;");
                                    break;
                            }

                            if (ds.Tables[0].Rows[i][j].ToString().Split('^')[0] == "4" && ds.Tables[0].Rows[i][j].ToString().Split('^')[2] == "1")
                            {
                                sb.Append("<td style='" + sbColor.ToString() + "' AssessorId='" + ds.Tables[0].Rows[i][j].ToString().Split('^')[5] + "' RSPExerciseId='" + ds.Tables[0].Rows[i][j].ToString().Split('^')[3] + "'' id='td_" + i + "_" + j + "'><a href='#' onclick='fnAssignAssessor(this);'  style='" + sbColor.ToString() + "'>" + ds.Tables[0].Rows[i][j].ToString().Split('^')[1] + "</a></td>");
                            }
                            else if (ds.Tables[0].Rows[i][j].ToString().Split('^')[0] == "7")
                            {
                                sb.Append("<td style='" + sbColor.ToString() + "' id='td_" + i + "_" + j + "'><a href='#' onclick='fnViewScore(this);'  style='" + sbColor.ToString() + "'>" + ds.Tables[0].Rows[i][j].ToString().Split('^')[1] + "</a></td>");
                            }
                            else
                            {
                                sb.Append("<td style='" + sbColor.ToString() + "' AssessorId='" + ds.Tables[0].Rows[i][j].ToString().Split('^')[5] + "' RSPExerciseId='" + ds.Tables[0].Rows[i][j].ToString().Split('^')[3] + "' id='td_" + i + "_" + j + "'>" + ds.Tables[0].Rows[i][j].ToString().Split('^')[1] + "</td>");
                            }
                        }
                        else
                        {
                            if (ds.Tables[0].Columns[j].ColumnName.ToString().Trim() == "User Response" && ds.Tables[0].Rows[i]["Report Download"].ToString() != "")
                            {
                                sb.Append("<td><a href='FileDownloadHandler.ashx?flg=1&EmpId="+ ds.Tables[0].Rows[i]["EmpNodeId"].ToString() + "&UserCode="+ ds.Tables[0].Rows[i]["User Code"].ToString() + "' target='_blank'>Download</a></td>");
                            }
                            else
                            {
                                if (ds.Tables[0].Columns[j].ColumnName.ToString().Trim() == "Report Download" && ds.Tables[0].Rows[i][j].ToString() != "")
                                {
                                    sb.Append("<td style='text-align:center; " + sbColor.ToString() + "' id='td_" + i + "_" + j + "' ><input type='checkbox' doc='" + ds.Tables[0].Rows[i][j].ToString() + "'></td>");
                                }
                                else
                                {
                                    sb.Append("<td style=''>" + ds.Tables[0].Rows[i][j].ToString().Split('^')[0] + "</td>");
                                }
                            }
                        }
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
        return " <th colspan='" + cntr + "' style='color: #ffffff; font-size: 11px; font-family: Verdana; font-weight:bold; background-color: #0080b9; border: 1px solid #dddddd;'> " + str + " </th>|" + cntr;
    }
    private string AssessorMstr(DataTable dt)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<select>");
        sb.Append("<option value='0'>--Please Select--</option>");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sb.Append("<option value='" + dt.Rows[i]["AssessorID"].ToString() + "'>" + dt.Rows[i]["Assessor"].ToString() + "</option>");
        }
        sb.Append("</select>");
        return sb.ToString();
    }

    private string LegendMstr(DataTable dt)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<table><tr>");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            switch (dt.Rows[i]["ExerciseStatusId"].ToString())
            {
                case "1":
                    sb.Append("<td style='background-color: #ff0000; width:20px'></td><td class='clslegendlbl'>" + dt.Rows[i]["ExerciseStatus"].ToString() + "</td>");
                    break;
                case "2":
                    sb.Append("<td style='background-color: #ff9b9b; width:20px'></td><td class='clslegendlbl'>" + dt.Rows[i]["ExerciseStatus"].ToString() + "</td>");
                    break;
                case "3":
                    sb.Append("<td style='background-color: #80ff80; width:20px'></td><td class='clslegendlbl'>" + dt.Rows[i]["ExerciseStatus"].ToString() + "</td>");
                    break;
                case "4":
                    sb.Append("<td style='background-color: #8080ff; width:20px'></td><td class='clslegendlbl'>" + dt.Rows[i]["ExerciseStatus"].ToString() + "</td>");                    
                    break;
                case "5":
                    sb.Append("<td style='background-color: #8000ff; width:20px'></td><td class='clslegendlbl'>" + dt.Rows[i]["ExerciseStatus"].ToString() + "</td>");
                    break;
                case "6":
                    sb.Append("<td style='background-color: #0000a0; width:20px'></td><td class='clslegendlbl'>" + dt.Rows[i]["ExerciseStatus"].ToString() + "</td>");
                    break;
            }            
        }
        sb.Append("</tr></table>");
        return sb.ToString();
    }

    [System.Web.Services.WebMethod()]
    public static string fnAssignAssessor(string RSPExerciseid, string AssessorId, string LoginId)
    {
        try
        {
            DataSet ds = new DataSet();
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spAssessAssignToRSPExercise]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@RSPExerciseId", RSPExerciseid);
            Scmd.Parameters.AddWithValue("@AssessorId", AssessorId);
            Scmd.Parameters.AddWithValue("@LoginId", LoginId);
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            Sdap.Fill(ds);

            return "0^" + ds.Tables[0].Rows[0]["ExerciseStatusId"].ToString() + "^" + ds.Tables[0].Rows[0]["ExerciseStatus"].ToString() + "^" + ds.Tables[0].Rows[0]["IsButton"].ToString();
        }
        catch (Exception ex)
        {
            return "1";
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnViewScore(string Emp)
    {
        try
        {
            DataSet ds = new DataSet();
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spViewUserScore]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@EmpNodeId", Emp);
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            Sdap.Fill(ds);

            string[] SkipColumn = new string[1];
            SkipColumn[0] = "EmpNodeId";
            return "0^" + createtbl(ds.Tables[0], "tblScore", true, 1, SkipColumn);
        }
        catch (Exception ex)
        {
            return "1";
        }
    }

    private static string createtbl(DataTable dt, string tblname, bool IsHeader, int RowMerge_Index, string[] SkipColumn)
    {
        StringBuilder sb = new StringBuilder();
        if (IsHeader)
        {
            sb.Append("<table cellpadding='0' cellspacing='0' valign='middle' class='clspopuptbl' id='" + tblname + "'>");
            sb.Append("<thead>");
            string[] Collength = dt.Columns[0].ColumnName.ToString().Split('^');
            for (int k = 0; k < Collength.Length; k++)
            {
                sb.Append("<tr>");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                    {
                        string[] ColSpliter = dt.Columns[j].ColumnName.ToString().Split('^');
                        if (ColSpliter[k] != "")
                        {
                            if (string.Join("", ColSpliter) == ColSpliter[k])
                            {
                                sb.Append("<th rowspan='" + ColSpliter.Length + "' class='clspopuptblhead_" + k + "_" + j + "'>" + dt.Columns[j].ColumnName.ToString().Split('^')[0] + "</th>");
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
                sb.Append("</tr>");
            }
            sb.Append("</thead>");
            sb.Append("<tbody>");
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sb.Append("<tr>");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                {
                    if (j <= RowMerge_Index)
                    {
                        DataTable temp_dt = dt.Select("[" + dt.Columns[j].ColumnName + "]='" + dt.Rows[i][j].ToString() + "'").CopyToDataTable();
                        if (temp_dt.Rows.Count > 1)
                        {
                            temp_dt.Columns.RemoveAt(j);
                            sb.Append(createRowMergeTbl(SkipColumn, temp_dt, dt.Rows[i][j].ToString(), RowMerge_Index - 1));
                            i = i + temp_dt.Rows.Count - 1;
                            break;
                        }
                        else
                        {
                            sb.Append("<td>" + dt.Rows[i][j].ToString() + "</td>");
                        }
                    }
                    else
                    {
                        sb.Append("<td>" + dt.Rows[i][j].ToString() + "</td>");
                    }
                }
            }
            sb.Append("</tr>");
        }
        if (IsHeader)
        {
            sb.Append("</tbody>");
            sb.Append("</table>");
        }
        return sb.ToString();
    }

    private static string createRowMergeTbl(string[] SkipColumn, DataTable dt, string colvalue, int RowMerge_Index)
    {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (i != 0)
                sb.Append("<tr>");
            else {
                sb.Append("<td rowspan ='" + dt.Rows.Count + "' >" + colvalue + "</td>");
            }

            for (int j = 0; j < dt.Columns.Count; j++)
            {
                if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                {
                    if (j <= RowMerge_Index)
                    {
                        DataTable temp_dt = dt.Select("[" + dt.Columns[j].ColumnName + "]='" + dt.Rows[i][j].ToString() + "'").CopyToDataTable();
                        if (temp_dt.Rows.Count > 1)
                        {
                            temp_dt.Columns.RemoveAt(j);
                            sb.Append(createRowMergeTbl(SkipColumn, temp_dt, dt.Rows[i][j].ToString(), RowMerge_Index - 1));
                            i = i + temp_dt.Rows.Count - 1;
                            break;
                        }
                        else
                        {
                            sb.Append("<td>" + dt.Rows[i][j].ToString() + "</td>");
                        }
                    }
                    else
                    {
                        sb.Append("<td>" + dt.Rows[i][j].ToString() + "</td>");
                    }
                }
            }

            if (i != (dt.Rows.Count - 1))
            {
                sb.Append("</tr>");
            }
        }
        return sb.ToString();
    }
    [System.Web.Services.WebMethod()]
    public static string fnRpt(object udt_DataSaving, string LoginId)
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

            DataSet ds = new DataSet();
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spDownloadUserReport]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@UserList", dtDataSaving);
            Scmd.Parameters.AddWithValue("@LoginId", LoginId);
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            Sdap.Fill(ds);

            String path = HttpContext.Current.Server.MapPath("~/Report/");
            FileInfo file = new FileInfo(path + "Reports.zip");
            if (file.Exists)
            {
                file.Delete();
            }            

            using (ZipFile zip = new ZipFile())
            {
                for(int i =0; i < dtDataSaving.Rows.Count; i++)
                {
                    file = new FileInfo(path + dtDataSaving.Rows[i][1].ToString());
                    if (file.Exists)
                    {
                        zip.AddFile(path + dtDataSaving.Rows[i][1].ToString(), "Reports");
                    }
                }
                zip.Save(path + "Reports.zip");
            }

            return "0^Reports.zip";
        }
        catch (Exception ex)
        {
            return "1";
        }
    }

    protected void btnScoreCard_Click(object sender, EventArgs e)
    {
        DataTable dt_EmpId = new DataTable();
        dt_EmpId.Columns.Add("ID", typeof(string));
        dt_EmpId.Columns.Add("Val", typeof(string));

        for(int i=0; i < hdnSelectedEmp.Value.Split('^').Length; i++)
        {
            dt_EmpId.Rows.Add(hdnSelectedEmp.Value.Split('^')[i], "");
        }

        string sp_Name = ""; string fileName = "";
        if (hdnScoreCardType.Value == "1")              //Score Card
        {
            sp_Name = "spDownloadUserScore";
            fileName = "Score-Card_" + DateTime.Now.ToString("yyyyMMddhhmmssff");
        }
        else                                           //New Score Card
        {
            sp_Name = "spDownloadUserScoreWithNewLogic";
            fileName = "New Score-Card_" + DateTime.Now.ToString("yyyyMMddhhmmssff");
        }

        SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = sp_Name;
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        Scmd.Parameters.AddWithValue("@EmpNodeIds", dt_EmpId);
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet Ds = new DataSet();
        Sdap.Fill(Ds);

        DataTable dt = Ds.Tables[0];
        string[] SkipColumn = new string[1];
        SkipColumn[0] = "Document";

        string strtbl = createtbl(Ds.Tables[0], SkipColumn);
        
        Response.Clear();
        Response.Charset = "";
        Response.ContentEncoding = System.Text.UTF8Encoding.UTF8;
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/ms-excel.xls";
        Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".xls");
        Response.Write("<html><head><style type='text/css'>" + "" + "</style></head>" + strtbl + "</html>");
        Response.Flush();
        Response.End();
    }
    
    private string createtbl(DataTable dt, string[] SkipColumn)
    {

        StringBuilder sb = new StringBuilder();
        sb.Append("<table cellpadding='0' cellspacing='0' valign='middle' style='border-left:1px solid gray; border-top:1px solid gray;'>");
        sb.Append("<thead>");
        string[] Collength = dt.Columns[2].ColumnName.ToString().Split('|')[0].Split('^');
        for (int k = 0; k < Collength.Length; k++)
        {
            sb.Append("<tr>");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Split('|')[0].Trim()))
                {
                    string[] ColSpliter = (dt.Columns[j].ColumnName.ToString().Split('|')[0].Trim()).Split('^');
                    //if (ColSpliter[k] != "")
                    //{
                        if (string.Join("", ColSpliter) == ColSpliter[k])
                        {
                            if (ColSpliter[k].Trim() == "Report Download")
                            {
                                sb.Append("<th rowspan='" + ColSpliter.Length + "' style=''>" + ColSpliter[k] + " <input type='checkbox' onclick='fnCheckUncheck(this);' /></th>");
                            }
                            else
                            {
                                sb.Append("<th rowspan='" + ColSpliter.Length + "' style=''>" + ColSpliter[k] + "</th>");
                            }
                        }
                        else
                        {
                            string strrowspan = multilvlPopuptbl(dt, j, k);
                            sb.Append(strrowspan.Split('|')[0]);
                            j = j + Convert.ToInt32(strrowspan.Split('|')[1]) - 1;
                        }
                    //}
                }
            }
            sb.Append("</tr>");
        }        
        sb.Append("</thead>");
        sb.Append("<tbody>");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sb.Append("<tr>");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                {
                    sb.Append("<td style='border-right:1px solid gray; border-bottom:1px solid gray; font-size:7pt; font-family:verdana;'>" + dt.Rows[i][j].ToString() + "</td>");
                }
            }
            sb.Append("</tr>");
        }
        sb.Append("</tbody>");
        sb.Append("</table>");
        return sb.ToString();
    }
}