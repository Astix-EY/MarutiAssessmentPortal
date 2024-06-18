using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;

public partial class frmAttendencerpt : System.Web.UI.Page
{
    #region Declare protected Method
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginId"] == null)
        {
            Response.Redirect("../login.aspx");
            return;
        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        if (HttpContext.Current.Session["Result"] != null)
        {
            string str = HttpContext.Current.Session["Result"].ToString();
            int ind = str.LastIndexOf("|||");
            string fileName = str.Substring(ind + 3);
            str = str.Substring(0, ind);
            Response.Clear();
            Response.Charset = "";
            //Response.ContentEncoding = System.Text.UTF8Encoding.UTF8;
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.ContentType = "application/msword";
            Response.AddHeader("content-disposition", "attachment;filename=" + fileName + ".doc");
            Response.Write("<html><head></head><body>" + str + "</body></html>");
            Response.Flush();
            Response.End();
        }
    }
    #endregion

    #region Public Static Webmethod Method

    [System.Web.Services.WebMethod()]
    public static string Gettbl(string AssessorId)
    {
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spAssmentAssesseeListDisplay";
        Scmd.CommandType = CommandType.StoredProcedure;
        //Scmd.Parameters.AddWithValue("@AssessorId", AssessorId);
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet ds = new DataSet();
        Sdap.Fill(ds);

        string[] SkipColumn = new string[1];
        SkipColumn[0] = "EmpNodeID";

        StringBuilder sb = new StringBuilder();
        if (ds.Tables[0].Rows.Count > 0)
        {
            sb = new StringBuilder();

            sb.Append("<table cellpadding='0' cellspacing='0' valign='middle' id='clsStoretbl' style='margin: 0 auto;'>");
            sb.Append("<thead>");

            sb.Append("<tr>");
            for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
            {
                if (!SkipColumn.Contains(ds.Tables[0].Columns[j].ColumnName.ToString().Trim()))
                {
                    sb.Append("<th>" + ds.Tables[0].Columns[j].ColumnName.ToString() + "</th>");
                }
            }
            sb.Append("</tr>");

            sb.Append("</thead>");
            sb.Append("<tbody>");
            
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (ds.Tables[0].Rows[i]["Final Status"].ToString() == "Completed")
                {
                    sb.Append("<tr style='background-color:#8be58f'>");
                }
                else
                {
                    sb.Append("<tr>");
                }
                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(ds.Tables[0].Columns[j].ColumnName.ToString().Trim()))
                    {
                        if (j == 1)
                        {
                            string fileName = ds.Tables[0].Rows[i][j].ToString();
                            if (fileName == "Not Started" || fileName == "Completed" || fileName == "Started but not Completed" || fileName== "Completed but not Uploaded")
                            {
                                sb.Append("<td class='clstd" + j + "'>" + fileName + "</td>");
                            }
                            else
                            {
                                // fileName = "BLP ELP 2018_106.pdf";
                                if (j == 1)
                                {
                                    sb.Append("<td class='clstd" + j + "'><a target='_Blank' href='FileUploadHandler.ashx?flgfilefolderid=5&OFileName=" + fileName.Split('|')[0] + "&FileName=AttachmentForCaseStudy\\" + Path.GetFileNameWithoutExtension(fileName.Split('|')[0]) + "_" + fileName.Split('|')[1] + Path.GetExtension(fileName.Split('|')[0]) + "'><span>" + fileName.Split('|')[0] + "</span></a></td>");
                                }
                                else
                                {
                                    sb.Append("<td class='clstd" + j + "'><a target='_Blank' href='FileUploadHandler.ashx?flgfilefolderid=5&OFileName=" + fileName.Split('|')[0] +"&FileName=AttachmentForScheduling\\" + Path.GetFileNameWithoutExtension(fileName.Split('|')[0]) + "_" + fileName.Split('|')[1] + Path.GetExtension(fileName.Split('|')[0]) + "'><span>" + fileName.Split('|')[0] + "</span></a></td>");
                                }

                            }
                        }
                       /* else if (j == 4)
                        {
                            if (ds.Tables[0].Rows[i][j].ToString() == "Completed")
                            {
                                sb.Append("<td class='clstd" + j + "'><a href='#' onclick='fndownload(this);' EmpId='" + ds.Tables[0].Rows[i]["EmpNodeId"].ToString() + "' EmpName='" + ds.Tables[0].Rows[i][0].ToString() + "'>Completed</a></td>");
                            }
                            else
                            {
                                sb.Append("<td class='clstd" + j + "'>" + ds.Tables[0].Rows[i][j].ToString() + "</td>");
                            }

                        }*/
                        else if (j == 5)
                        {
                            if (ds.Tables[0].Rows[i][j].ToString() == "1")
                            {
                                string fileName = ""; string OfileName = "";
                                if (ds.Tables[0].Rows[i][1].ToString() != "Not Started" && ds.Tables[0].Rows[i][1].ToString() != "Completed" && ds.Tables[0].Rows[i][1].ToString() != "Started but not Completed")
                                {
                                    //fileName = "AttachmentForCaseStudy\\Screenshot_661.png";
                                    string fnname=ds.Tables[0].Rows[i][1].ToString();
                                    fileName = "AttachmentForCaseStudy\\" +  Path.GetFileNameWithoutExtension(fnname.Split('|')[0]) + "_" + fnname.Split('|')[1] + Path.GetExtension(fnname.Split('|')[0]);
                                    //OfileName = fnname.Split('|')[0];
                                }
                                

                                sb.Append("<td class='clstd" + j + "'><a target='_Blank' href='FileUploadHandler.ashx?flgfilefolderid=6&fileName=" + HttpUtility.UrlEncode(fileName) + "&Employee=" + ds.Tables[0].Rows[i][0].ToString() + "&EmpId=" + ds.Tables[0].Rows[i]["EmpNodeId"].ToString() + "'><span>Download All</span></a></td>");
                            }
                            else
                            {
                                sb.Append("<td class='clstd" + j + "'></td>");
                            }
                        }
                        else
                        {
                            sb.Append("<td class='clstd" + j + "'>" + ds.Tables[0].Rows[i][j].ToString() + "</td>");
                        }
                    }
                }
                sb.Append("</tr>");
            }
            sb.Append("</tbody>");
            sb.Append("</table>");
            HttpContext.Current.Session["Result"] = ds.Tables[0];
        }
        else
        {
            HttpContext.Current.Session["Result"] = null;
        }

        return sb.ToString();
    }

    [System.Web.Services.WebMethod()]
    public static string GetMails(string EmpId, string EmpName)
    {
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "[spRptGetResponseAgExercise]";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.Parameters.AddWithValue("@EmpNodeId", EmpId);
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet ds = new DataSet();
        Sdap.Fill(ds);

        string[] SkipColumn = new string[1];
        SkipColumn[0] = "EmpNodeId";

        StringBuilder sb = new StringBuilder();
        if (ds.Tables[0].Rows.Count > 0)
        {
            sb = new StringBuilder();

            sb.Append("<table style='margin: 0 auto; width:90%; font-weight: bold;font-family: Calibri, Gadget, sans-serif;'><tr><td style='color: blue; padding:0 0 10px 10px; font-size: 17px;'>Name</td><td>:</td><td style='font-size: 16px;'>" + EmpName + "</td></tr></table>");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                sb.Append("<br/><br/><span style='font-size:15px; font-weight:bold; color: Orange; text-decoration:underline; font-family: Calibri, Gadget, sans-serif;'> Mail - " + (i + 1).ToString() + " : " + ds.Tables[0].Rows[i]["MailSubject"].ToString() + "</span><br/>");
                sb.Append("<table style='margin: 0 auto; width:90%; font-family: Calibri, Gadget, sans-serif; border:3px solid lightblue;padding:0;'>");
                if (ds.Tables[0].Rows[i]["Priority"].ToString() != "")
                {
                    sb.Append("<tr><td style='padding:5px 0 0 0; font-weight:bold; width:20%; font-size:13px;'>Priority</td><td>:</td><td style='font-size:13px;  '>" + ds.Tables[0].Rows[i]["Priority"].ToString() + "(" + ds.Tables[0].Rows[i]["PriorityText"].ToString() + ")</td></tr>");
                }
                if (ds.Tables[0].Rows[i]["Action"].ToString() != "")
                {
                    sb.Append("<tr><td style='padding:5px 0 0 0; font-weight:bold; width:20%; font-size:13px;'>Action</td><td>:</td><td style='font-size:13px;'>" + ds.Tables[0].Rows[i]["Action"].ToString() + "(" + ds.Tables[0].Rows[i]["ActionText"].ToString() + ")</td></tr>");
                }
                sb.Append("<tr><td colspan='3' style='padding:5px; background-color:gray; font-weight:bold; color:#ffffff;'>Content</td></tr>");
                sb.Append("<tr><td colspan='3' style='padding:10px;'>" + WebUtility.HtmlDecode(ds.Tables[0].Rows[i]["MailText"].ToString()) + "</td></tr>");
                sb.Append("</table>");
            }
            //WebUtility.HtmlDecode(ds.Tables[0].Rows[i]["MailText"].ToString())
            //sb.Append("</td></tr></table>");
            sb.Append("<table style='margin: 0 auto; width:90%; padding-top:5px;'>");
            sb.Append("<tr><td colspan='3' style='padding:20px 5px 5px 5px; font-size:15px; font-weight:bold; color: Orange; text-decoration:underline; border-bottom:3px solid lightblue;'>Feedback Form</td></tr>");
            for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
            {
                sb.Append("<tr style='border:3px solid lightblue;'><td style='padding:4px; font-weight:bold; width:50%;'>" + ds.Tables[1].Rows[i]["Qstn"].ToString() + "</td><td>:</td><td style='padding:4px; border:1px solid gray;'>" + ds.Tables[1].Rows[i]["Answ"].ToString() + "</td></tr>");
            }
            sb.Append("</table>");
            HttpContext.Current.Session["Result"] = sb.ToString() + "|||" + EmpName;
        }
        else
        {
            HttpContext.Current.Session["Result"] = null;
        }

        return sb.ToString();
    }


    [System.Web.Services.WebMethod()]
    public static string GetRatingPopup(string AssessorId, string excerciseid)
    {
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spAssmentStartRating";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.Parameters.AddWithValue("@AssessorId", AssessorId);
        Scmd.Parameters.AddWithValue("@RSPExerciseID", excerciseid);
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet ds = new DataSet();
        Sdap.Fill(ds);

        StringBuilder sb = new StringBuilder();
        switch (ds.Tables[2].Rows[0]["ExerciseID"].ToString())
        {
            case "1":
                sb.Append("<table style='width:100%;'><tr><td><span class='clslbl'>" + ds.Tables[0].Rows[0]["ExerciseName"].ToString() + "</span></td></tr>");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sb.Append("<tr><td><div style='height:150px; overflow-y:auto; padding-bottom:10px;'><table id='tblMails' style='width:100%;'><tr><th style='width:50%;'>Mail From</th><th>Subject</th></tr>");
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        sb.Append("<tr><td><a href='#' onclick='fnShowContent(this);' mailtext='" + ds.Tables[0].Rows[i]["MailText"].ToString().Replace("'", "") + "'>" + ds.Tables[0].Rows[i]["MailFrom"].ToString() + "</a></td><td>" + ds.Tables[0].Rows[i]["MailSubject"].ToString().Replace("'", "") + "</td></tr>");
                    }
                    sb.Append("</table></div></td></tr>");
                }
                sb.Append("<tr id='trContenthead'><td style='background-color:gray; padding:2px 0 2px 6px;'>Content :</td></tr><tr  id='trContent' ><td><div class='clsContentdiv' id='Contentdiv'></div></td></tr><tr><td style='padding-top:10px;'>");
                if (ds.Tables[1].Rows.Count > 0)
                {
                    sb.Append("<table id='tblCompetency' style='width:100%;'><tr><th>Competency</th><th>Theme</th><th>Rating</th><th>Remarks</th></tr>");
                    DataTable dtCompetency = ds.Tables[1].DefaultView.ToTable("CompetencyName", true, "CompetencyName");
                    for (int i = 0; i < dtCompetency.Rows.Count; i++)
                    {
                        DataRow[] dtCompetencybased = ds.Tables[1].Select("CompetencyName = '" + dtCompetency.Rows[i][0].ToString() + "'");
                        sb.Append("<tr><td rowspan='" + dtCompetencybased.Length + "' class='clsComp1'>" + dtCompetency.Rows[i][0].ToString() + "</td>");
                        foreach (DataRow row in dtCompetencybased)
                        {
                            sb.Append("<td class='clsComp2'>" + row["Theme"] + "</td><td class='clsComp3'><select selval='" + row["Rating"].ToString() + "' AssmentRsltMainID='" + row["AssmentRsltMainID"].ToString() + "' AssmentRsltDetailID='" + row["AssmentRsltDetailID"].ToString() + "' iden='ddlrating'><option value='0'>Select</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option></select></td><td class='clsComp4'><textarea rows='2' style='width:99%;'  class='clsCompremark'>" + row["Remarks"].ToString() + "</textarea></td></tr>");
                        }
                        //sb.Append("</tr>");
                    }
                    sb.Append("</table>");
                }
                sb.Append("</td></tr></table>");
                break;
            case "2":
                sb.Append("<table style='width:100%;'><tr><td><span class='clslbl'>" + ds.Tables[0].Rows[0]["ExerciseName"].ToString() + "</span></td></tr><tr><td><div class='clsContentdiv' id='Contentdiv'>" + WebUtility.HtmlDecode(ds.Tables[0].Rows[0]["AnswrVal"].ToString()).Replace("'", "") + "</div></td></tr><tr><td style='padding-top:10px;'>");
                if (ds.Tables[1].Rows.Count > 0)
                {
                    sb.Append("<table id='tblCompetency' style='width:100%;'><tr><th>Competency</th><th>Theme</th><th>Rating</th><th>Remarks</th></tr>");
                    DataTable dtCompetency = ds.Tables[1].DefaultView.ToTable("CompetencyName", true, "CompetencyName");
                    for (int i = 0; i < dtCompetency.Rows.Count; i++)
                    {
                        DataRow[] dtCompetencybased = ds.Tables[1].Select("CompetencyName = '" + dtCompetency.Rows[i][0].ToString() + "'");
                        sb.Append("<tr><td rowspan='" + dtCompetencybased.Length + "' class='clsComp1'>" + dtCompetency.Rows[i][0].ToString() + "</td>");
                        int flg = 0;
                        foreach (DataRow row in dtCompetencybased)
                        {
                            if (flg == 1)
                                sb.Append("<tr>");
                            flg = 1;
                            sb.Append("<td class='clsComp2'>" + row["Theme"] + "</td><td class='clsComp3'><select selval='" + row["Rating"].ToString() + "' AssmentRsltMainID='" + row["AssmentRsltMainID"].ToString() + "' AssmentRsltDetailID='" + row["AssmentRsltDetailID"].ToString() + "' iden='ddlrating'><option value='0'>Select</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option></select></td><td class='clsComp4'><textarea rows='2' style='width:99%;' class='clsCompremark'>" + row["Remarks"].ToString() + "</textarea></td></tr>");
                        }
                        //sb.Append("</tr>");
                    }
                    sb.Append("</table>");
                }
                sb.Append("</td></tr></table>");
                break;
            case "3":
                sb.Append("<table style='width:100%;'><tr><td><span class='clslbl'>" + ds.Tables[0].Rows[0]["ExerciseName"].ToString() + "</span></td></tr><tr><td><div class='clsContentdiv' id='Contentdiv'>" + WebUtility.HtmlDecode(ds.Tables[0].Rows[0]["AnswrVal"].ToString()).Replace("'", "") + "</div></td></tr><tr><td style='padding-top:10px;'>");
                if (ds.Tables[1].Rows.Count > 0)
                {
                    sb.Append("<table id='tblCompetency' style='width:100%;'><tr><th>Competency</th><th>Theme</th><th>Rating</th><th>Remarks</th></tr>");
                    DataTable dtCompetency = ds.Tables[1].DefaultView.ToTable("CompetencyName", true, "CompetencyName");
                    for (int i = 0; i < dtCompetency.Rows.Count; i++)
                    {
                        DataRow[] dtCompetencybased = ds.Tables[1].Select("CompetencyName = '" + dtCompetency.Rows[i][0].ToString() + "'");
                        sb.Append("<tr><td rowspan='" + dtCompetencybased.Length + "' class='clsComp1'>" + dtCompetency.Rows[i][0].ToString() + "</td>");
                        foreach (DataRow row in dtCompetencybased)
                        {
                            sb.Append("<td class='clsComp2'>" + row["Theme"] + "</td><td class='clsComp3'><select selval='" + row["Rating"].ToString() + "' AssmentRsltMainID='" + row["AssmentRsltMainID"].ToString() + "' AssmentRsltDetailID='" + row["AssmentRsltDetailID"].ToString() + "' iden='ddlrating'><option value='0'>Select</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option></select></td><td class='clsComp4'><textarea rows='2' style='width:99%;' class='clsCompremark'>" + row["Remarks"].ToString() + "</textarea></td></tr>");
                        }
                        //sb.Append("</tr>");
                    }
                    sb.Append("</table>");
                }
                sb.Append("</td></tr></table>");
                break;
        }
        return sb.ToString();
    }
    [System.Web.Services.WebMethod()]
    public static string GetPopupRpt(string EmpId)
    {
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spRptGetEmpAndThemeWiseScores";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.Parameters.AddWithValue("@EmpNodeId", EmpId);
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet ds = new DataSet();
        Sdap.Fill(ds);

        string[] SkipColumn = new string[1];
        SkipColumn[0] = "EmpNodeID";

        StringBuilder sb = new StringBuilder();
        if (ds.Tables[0].Rows.Count > 0)
        {
            sb = new StringBuilder();

            sb.Append("<table cellpadding='0' cellspacing='0' valign='middle' id='tblpoprpt' style='margin: 0 auto;'>");
            sb.Append("<thead>");

            sb.Append("<tr>");
            for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
            {
                if (!SkipColumn.Contains(ds.Tables[0].Columns[j].ColumnName.ToString().Trim()))
                {
                    sb.Append("<th>" + ds.Tables[0].Columns[j].ColumnName.ToString() + "</th>");
                }
            }
            sb.Append("</tr>");

            sb.Append("</thead>");
            sb.Append("<tbody>");

            DataTable dtCompetency = ds.Tables[0].DefaultView.ToTable("CompetencyName", true, "CompetencyName");
            for (int i = 0; i < dtCompetency.Rows.Count; i++)
            {
                DataRow[] dtCompetencybased = ds.Tables[0].Select("CompetencyName = '" + dtCompetency.Rows[i][0].ToString() + "'");
                sb.Append("<tr><td rowspan='" + dtCompetencybased.Length + "' class='clsrpttd0'>" + dtCompetency.Rows[i][0].ToString() + "</td>");
                int flg = 0;
                foreach (DataRow row in dtCompetencybased)
                {
                    if (flg == 1)
                    {
                        sb.Append("<tr>");
                    }
                    sb.Append("<td class='clsrpttd1'>" + row["Theme"] + "</td>");
                    if (row["In Basket"].ToString().Split('^').Length > 1)
                    {
                        sb.Append("<td class='clsrpttd2'><label remark='" + row["In Basket"].ToString().Split('^')[1] + "' onmouseover='fnopencomment(this);' onmouseleave='fnclosecomment();'>" + row["In Basket"].ToString().Split('^')[0] + "</td>");
                    }
                    else
                    {
                        sb.Append("<td class='clsrpttd2'>" + row["In Basket"].ToString().Split('^')[0] + "</td>");
                    }
                    if (row["Case Study"].ToString().Split('^').Length > 1)
                    {
                        sb.Append("<td class='clsrpttd3'><label remark='" + row["Case Study"].ToString().Split('^')[1] + "' onmouseover='fnopencomment(this);' onmouseleave='fnclosecomment();'>" + row["Case Study"].ToString().Split('^')[0] + "</td>");
                    }
                    else
                    {
                        sb.Append("<td class='clsrpttd3'>" + row["Case Study"].ToString().Split('^')[0] + "</td>");
                    }
                    if (row["Scenario Analysis"].ToString().Split('^').Length > 1)
                    {
                        sb.Append("<td class='clsrpttd4'><label remark='" + row["Scenario Analysis"].ToString().Split('^')[1] + "'  onmouseover='fnopencomment(this);' onmouseleave='fnclosecomment();'>" + row["Scenario Analysis"].ToString().Split('^')[0] + "</td>");
                    }
                    else
                    {
                        sb.Append("<td class='clsrpttd4'>" + row["Scenario Analysis"].ToString().Split('^')[0] + "</td>");
                    }
                    sb.Append("</tr>");
                    //sb.Append("<td class='clsrpttd3'>" + row["Case Study"] + "</td><td class='clsrpttd4'>" + row["Scenario Analysis"] + "</td></tr>");
                }
                //
            }

            //for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            //{
            //    sb.Append("<tr>");

            //    for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
            //    {
            //        if (!SkipColumn.Contains(ds.Tables[0].Columns[j].ColumnName.ToString().Trim()))
            //        {
            //            if (j > 1)
            //            {
            //                if (ds.Tables[0].Rows[i][j].ToString() != "")
            //                {
            //                    string[] strArr = ds.Tables[0].Rows[i][j].ToString().Split('^');
            //                    if (strArr.Length > 1)
            //                    {
            //                        //sb.Append("<td class='clsrpttd" + j + "'><a href='#' onclick='fnCommentPopup(this);' remarks='" + strArr[1] + "'>" + strArr[0] + "</a></td>");
            //                        sb.Append("<td class='clsrpttd" + j + "'><label Title='" + strArr[1] + "' style='cursor:pointer;'>" + strArr[0] + "</label></td>");
            //                    }
            //                    else
            //                    {
            //                        sb.Append("<td class='clsrpttd" + j + "'>" + strArr[0] + "</td>");
            //                    }
            //                }
            //                else
            //                {
            //                    sb.Append("<td class='clsrpttd" + j + "'></td>");
            //                }
            //            }
            //            else
            //            {
            //                sb.Append("<td class='clsrpttd" + j + "'>" + ds.Tables[0].Rows[i][j].ToString() + "</td>");
            //            }
            //        }
            //    }
            //    sb.Append("</tr>");
            //}
            sb.Append("</tbody>");
            sb.Append("</table>");
        }
        else
        {
        }

        return sb.ToString();
    }
    [System.Web.Services.WebMethod()]
    public static string SaveRating(object tblRating, string flg)
    {
        string strtblRating = JsonConvert.SerializeObject(tblRating, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
        DataTable DttblRating = JsonConvert.DeserializeObject<DataTable>(strtblRating);
        DttblRating.TableName = "AssmentRsltDetails";
        try
        {
            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "spAssmentSaveRating";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@tblAssmentRsltDetails", DttblRating);
            Scmd.Parameters.AddWithValue("@flgCompletionStatus", flg);
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
    #endregion
}