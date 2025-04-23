using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ClosedXML.Excel;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System.Xml;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System.Net;
using X15 = DocumentFormat.OpenXml.Office2013.Excel;
using X14 = DocumentFormat.OpenXml.Office2010.Excel;
using A = DocumentFormat.OpenXml.Drawing;
using Ap = DocumentFormat.OpenXml.ExtendedProperties;
using Vt = DocumentFormat.OpenXml.VariantTypes;
using Thm15 = DocumentFormat.OpenXml.Office2013.Theme;
using System.Globalization;
public static class TypeHelper
{
    private static readonly HashSet<Type> NumericTypes = new HashSet<Type>
        {
            typeof(int),  typeof(double),  typeof(decimal),
            typeof(long), typeof(short),   typeof(sbyte),
            typeof(byte), typeof(ulong),   typeof(ushort),
            typeof(uint), typeof(float)
        };

    public static bool IsNumeric(this Type myType)
    {
        return NumericTypes.Contains(Nullable.GetUnderlyingType(myType) ?? myType);
    }
}
public partial class frmDownloadExcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //Response.Write("<br/><br/><b>Report is being downloaded,please wait... </b>");
        string[] notrowspanColumn = new string[0];
        string sFlg = Request.QueryString["flg"].ToString();//"1";//
        if (sFlg == "1")
        {
            string band = Request.QueryString["band"].ToString();//"1";//
            fnDownloadProctoringReport(band);
        }
        else if (sFlg == "2")
        {
            string CycleId = Request.QueryString["CycleId"] == null ? "0" : Request.QueryString["CycleId"].ToString();
            fnDownloadRptParticipantStatus(CycleId);
        }
        //else if (sFlg == "3")
        //{
        //    fnDownloadRptParticipantStatus(0);
        //}
        else if (sFlg == "4")
        {
            string Phase1date = Request.QueryString["Phase1date"].ToString();//"1";//
            string LoginId = Request.QueryString["LoginId"].ToString();//"1";//
            string BandId = Request.QueryString["BandId"].ToString();//"1";//
            string Phase2RolePlayDate = Request.QueryString["Phase2RolePlayDate"].ToString();//"1";//
            string Phase2BEIDate = Request.QueryString["Phase2BEIDate"].ToString();//"1";//
            fnDownloadAssessmentScore(Phase1date, LoginId, BandId, Phase2RolePlayDate, Phase2BEIDate);
        }
        else if (sFlg == "5")
        {
            string Phase1date = Request.QueryString["Phase1date"].ToString();//"1";//
            string LoginId = Request.QueryString["LoginId"].ToString();//"1";//
            string BandId = Request.QueryString["BandId"].ToString();//"1";//
            string Phase2RolePlayDate = Request.QueryString["Phase2RolePlayDate"].ToString();//"1";//
            string Phase2BEIDate = Request.QueryString["Phase2BEIDate"].ToString();//"1";//
            fnDownloadReflectionData(Phase1date, LoginId, BandId, Phase2RolePlayDate, Phase2BEIDate);
        }
        else if (sFlg == "6")
        {
            string FromDate = Request.QueryString["FromDate"].ToString();//"1";//
            string ToDate = Request.QueryString["ToDate"].ToString();//"1";//
            fnDownloadParticipantAssessorList(FromDate, ToDate);
        }
        else if (sFlg == "7")
        {
            string Phase1date = Request.QueryString["Phase1date"].ToString();//"1";//
            string LoginId = Request.QueryString["LoginId"].ToString();//"1";//
            string BandId = Request.QueryString["BandId"].ToString();//"1";//
            string Phase2Date = Request.QueryString["Phase2Date"].ToString();//"1";//
            fnDownloadAssessmentWeightedScore(Phase1date, LoginId, BandId, Phase2Date);
        }
        else if (sFlg == "8")
        {
            //string FromDate = Request.QueryString["FromDate"].ToString();//"1";//
            // string ToDate = Request.QueryString["ToDate"].ToString();//"1";//
            fnDownloadFeedbackParticipantAssessorList();
        }
    }

    public void fnDownloadAssessmentWeightedScore(string Phase1date, string LoginId, string BandId, string Phase2Date)
    {
        string[] SkipColumn = new string[0];
        string filename = "";
        int cntvalid = 0;
        filename = "AssessmentWeightedScore_" + DateTime.Now.ToString("yyyyMMdd");
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            string storedProcName = "spDownloadAllParticipantScoreNewFormat";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {
                 new SqlParameter("@Phase1date", Phase1date),
                   new SqlParameter("@LoginId", LoginId),
                   new SqlParameter("@BandId", BandId),
                   new SqlParameter("@Phase2Date", Phase2Date)
                };
            DataSet Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);
            using (XLWorkbook wb = new XLWorkbook())
            {
                cntvalid = 1;
                ////Start Chassiss
                int k = 1; int j = 0; int colFreeze = 2; int colLeft = 3;
                string strold = ""; int cntc = 0; int colst = 2; bool flgb = true;
                int resulsetcnt = 0;
                //foreach (DataRow drowchasiss in Ds.Tables[0].Rows)//For SheetName
                //{
                string strSheetName = "AssessmentScore";
                DataTable dt = Ds.Tables[resulsetcnt];

                resulsetcnt++;
                var ws = wb.Worksheets.Add(strSheetName);
                k = 1; j = 0; colFreeze = 2; colLeft = 3;
                strold = ""; cntc = 0; colst = 2; flgb = true; bool flgm = false;
                //int rowstart = 0; // for data part insertion
                int noofsplit = 1; //Convert.ToInt16(drowchasiss["NoOfSplit"]);
                int noofcolfreeze = 2;// Convert.ToInt16(drowchasiss["Noofcolfreeze"]);
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                    {
                        string[] ColSpliter = dt.Columns[c].ColumnName.ToString().Split('^');
                        flgm = true;
                        for (var i = 0; i < ColSpliter.Length; i++)
                        {
                            string sVal = dt.Columns[c].ColumnName.ToString().Split('|')[i];
                            ws.Cell(k + i, j + 1).Value = sVal.Split('^')[0];
                            string bgcolor = "#305496"; string forrecolor = "#ffffff";
                            if (i == 0)
                            {
                                if (dt.Columns[c].ColumnName.ToString().Split('|')[1] == "1")
                                {
                                    forrecolor = "#ffffff";
                                    bgcolor = "#2f75b5";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Split('|')[1] == "2")
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#b4c6e7";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Split('|')[1] == "3")
                                {
                                    forrecolor = "#ffffff";
                                    bgcolor = "#c65911";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Split('|')[1] == "4")
                                {
                                    forrecolor = "#ffffff";
                                    bgcolor = "#ffc000";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Split('|')[1] == "5")
                                {
                                    forrecolor = "#ffffff";
                                    bgcolor = "#a5a5a5";
                                }
                            }
                            else
                            {
                                if (dt.Columns[c].ColumnName.ToString().Contains("BEI score"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#f6c9ab";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("Role Play"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#dec8ee";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("AOS"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#a9d08e";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("AOD"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#f77575";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("Tech Savy"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#d6dce4";
                                }
                            }
                            ws.Cell(k + i, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(bgcolor);
                            ws.Cell(k + i, j + 1).Style.Font.FontColor = XLColor.FromHtml(forrecolor);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        }

                        j++;
                    }
                }

                for (var i = 0; i < noofsplit - 1; i++)
                {
                    j = 0; colst = 1; k = 1; strold = "";
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        //if (strold != "")
                        //{
                        if (strold != dt.Columns[c].ColumnName.ToString().Split('^')[i])
                        {
                            flgb = true;
                            if (strold != "")
                            {
                                ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j)).Merge();
                            }
                            cntc = 0;
                        }
                        //}
                        if (flgb == true)
                        {
                            colst = j + 1;
                        }
                        flgb = false;
                        strold = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                        cntc++;
                        if (c == dt.Columns.Count - 1)
                        {
                            ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j + 1)).Merge();
                            cntc = 0;
                        }

                        j++;
                    }
                }


                int rowst = 0;
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    strold = dt.Columns[c].ColumnName.ToString().Split('^')[0];
                    colst = 1; k = 1; flgb = false; rowst = 1;


                    for (var i = 0; i < noofsplit; i++)
                    {
                        //strold = "";                                                   
                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == true)
                        {
                            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i, c + 1)).Merge();
                            flgb = false;
                            rowst++;
                        }

                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] == "")
                        {
                            flgb = true;
                        }

                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == false && i > 0)
                        {
                            rowst++;
                        }

                        if (i == noofsplit - 1 && flgb == true)
                        {
                            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i + 1, c + 1)).Merge();
                        }
                    }
                }
                /**/



                //ws.Rows().AdjustToContents();
                // var rangeWithData = ws.Cell(noofsplit + 1, 1).InsertData(dt.AsEnumerable());
                //ws.Columns().AdjustToContents();//noofsplit + 1,  dt.Columns.Count
                k = 2;
                for (int r = 0; r < dt.Rows.Count; r++)
                {
                    j = 0;
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        string sbColor = ""; string sbForeColor = "";
                        if (dt.Rows[r][c].ToString().Contains("^"))
                        {
                            sbForeColor = "#ffffff";
                            sbColor = "#00aa00";
                            ws.Cell(k + r, j + 1).Style.Font.FontColor = XLColor.FromHtml(sbForeColor);
                            ws.Cell(k + r, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(sbColor);
                            ws.Cell(k + r, j + 1).Value = dt.Rows[r][c].ToString().Split('^')[0];
                        }
                        else
                        {
                            ws.Cell(k + r, j + 1).Value = dt.Rows[r][c].ToString().Split('^')[0];
                        }

                        j++;
                    }
                }

                IXLCell cell3 = ws.Cell(1, 1);
                IXLCell cell4 = ws.Cell(dt.Rows.Count + noofsplit, dt.Columns.Count);
                //ws.Range(ws.Cell(k, 7), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 8), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 9), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(2,3, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                ws.Range(ws.Cell(k, 6), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 12), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 13), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);

                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Fill.BackgroundColor = XLColor.FromHtml("#d6d6d6");
                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Font.FontColor = XLColor.FromHtml("#000000");
                ws.SheetView.FreezeRows(noofsplit);
                ws.SheetView.FreezeColumns(noofcolfreeze);
                //}
                ws.Columns().AdjustToContents();
                ws.Rows().AdjustToContents();
                ws.Range(1, 1, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.WrapText = true;
                // ws.Cell(dt.Rows.Count + 1, 1).Value = "";
                //ws.Column(1).Delete();


                //Export the Excel file.
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(HttpContext.Current.Response.OutputStream);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            if (cntvalid == 0)
            {
                Response.Write(ex.Message);
            }
            // string ProjectTitle = ConfigurationManager.AppSettings["Title"];
            //clsSendLogMail.fnSendLogMail(ex.Message, ex.ToString(), "FrmDownload Page", "Download Page", "Error in FrmDownload Page in " + ProjectTitle);
        }
        finally
        {
        }
    }

    public void fnDownloadReflectionData(string Phase1Date, string LoginId, string BandId, string Phase2RolePlayDate, string Phase2BEIDate)
    {
        string[] SkipColumn = new string[6];
        SkipColumn[0] = "col1";
        SkipColumn[1] = "col2";
        SkipColumn[2] = "col3";
        SkipColumn[3] = "col4";
        SkipColumn[4] = "col5";
        SkipColumn[5] = "col6";
        string filename = "";
        int cntvalid = 0;
        filename = "ReflectionData_" + DateTime.Now.ToString("yyyyMMdd");
        try
        {
            Phase1Date = Phase1Date == "" ? "1-1-1900" : Phase1Date;
            Phase2RolePlayDate = Phase2RolePlayDate == "" ? "1-1-1900" : Phase2RolePlayDate;
            Phase2BEIDate = Phase2BEIDate == "" ? "1-1-1900" : Phase2BEIDate;

            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            string storedProcName = "spDownloadReflectionData";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {
                   new SqlParameter("@Phase1Date", Phase1Date),
                   new SqlParameter("@LoginId", LoginId),
                   new SqlParameter("@BandId", BandId),
                   new SqlParameter("@Phase2RolePlayDate", Phase2RolePlayDate),
                   new SqlParameter("@Phase2BEIDate", Phase2BEIDate)
                };
            DataSet Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);
            using (XLWorkbook wb = new XLWorkbook())
            {
                cntvalid = 1;
                ////Start Chassiss
                int k = 1; int j = 0; int colFreeze = 3; int colLeft = 3;
                string strold = ""; int cntc = 0; int colst = 2; bool flgb = true;
                int resulsetcnt = 0;
                //foreach (DataRow drowchasiss in Ds.Tables[0].Rows)//For SheetName
                //{
                string strSheetName = "ReflectionData";
                DataTable dt = Ds.Tables[resulsetcnt];
                DataTable dt1 = Ds.Tables[1];
                //dt.Columns.Remove("RspID");
                ////dt.Columns.Remove("EmpNodeId");
                //dt.Columns.Remove("MobileNo");
                //dt.Columns.Remove("Department");
                //dt.AcceptChanges();

                resulsetcnt++;
                var ws = wb.Worksheets.Add(strSheetName);
                k = 1; j = 0; colFreeze = 2; colLeft = 3;
                strold = ""; cntc = 0; colst = 2; flgb = true; bool flgm = false;
                //int rowstart = 0; // for data part insertion
                int noofsplit = 1; //Convert.ToInt16(drowchasiss["NoOfSplit"]);
                int noofcolfreeze = 2;// Convert.ToInt16(drowchasiss["Noofcolfreeze"]);
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                    {
                        string[] ColSpliter = dt.Columns[c].ColumnName.ToString().Split('^');
                        flgm = true;
                        for (var i = 0; i < ColSpliter.Length; i++)
                        {
                            string sVal = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                            ws.Cell(k + i, j + 1).Value = sVal.Split('^')[0];
                            string bgcolor = "#305496"; string forrecolor = "#ffffff";
                            //if (i == 0)
                            //{
                            //    if (dt.Columns[c].ColumnName.ToString().Contains("BEI score"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#c55911";
                            //    }
                            //    else if (dt.Columns[c].ColumnName.ToString().Contains("Role Play"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#b678b5";
                            //    }
                            //    else if (dt.Columns[c].ColumnName.ToString().Contains("Individual Development"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#ffd966";
                            //    }
                            //    else if (dt.Columns[c].ColumnName.ToString().Contains("Tech Savy"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#8497b0";
                            //    }
                            //}
                            //else
                            //{
                            //    if (dt.Columns[c].ColumnName.ToString().Contains("BEI score"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#f6c9ab";
                            //    }
                            //    else if (dt.Columns[c].ColumnName.ToString().Contains("Role Play"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#dec8ee";
                            //    }
                            //    else if (dt.Columns[c].ColumnName.ToString().Contains("AOS"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#a9d08e";
                            //    }
                            //    else if (dt.Columns[c].ColumnName.ToString().Contains("AOD"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#f77575";
                            //    }
                            //    else if (dt.Columns[c].ColumnName.ToString().Contains("Tech Savy"))
                            //    {
                            //        forrecolor = "#000000";
                            //        bgcolor = "#d6dce4";
                            //    }
                            //}
                            ws.Cell(k + i, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(bgcolor);
                            ws.Cell(k + i, j + 1).Style.Font.FontColor = XLColor.FromHtml(forrecolor);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        }

                        j++;
                    }
                }
                for (int c = 0; c < dt1.Rows.Count; c++)
                {

                    string sVal = dt1.Rows[c][1].ToString().Trim();
                    ws.Cell(k + 0, j + 1).Value = sVal;
                    string bgcolor = "#305496"; string forrecolor = "#ffffff";

                    ws.Cell(k + 0, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(bgcolor);
                    ws.Cell(k + 0, j + 1).Style.Font.FontColor = XLColor.FromHtml(forrecolor);
                    ws.Cell(k + 0, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    ws.Cell(k + 0, j + 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);

                    j++;
                }

                //for (var i = 0; i < noofsplit - 1; i++)
                //{
                //    j = 0; colst = 1; k = 1; strold = "";
                //    for (int c = 0; c < dt.Columns.Count; c++)
                //    {
                //        //if (strold != "")
                //        //{
                //        if (strold != dt.Columns[c].ColumnName.ToString().Split('^')[i])
                //        {
                //            flgb = true;
                //            if (strold != "")
                //            {
                //                ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j)).Merge();
                //            }
                //            cntc = 0;
                //        }
                //        //}
                //        if (flgb == true)
                //        {
                //            colst = j + 1;
                //        }
                //        flgb = false;
                //        strold = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                //        cntc++;
                //        if (c == dt.Columns.Count - 1)
                //        {
                //            ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j + 1)).Merge();
                //            cntc = 0;
                //        }

                //        j++;
                //    }
                //}


                //int rowst = 0;
                //for (int c = 0; c < dt.Columns.Count; c++)
                //{
                //    strold = dt.Columns[c].ColumnName.ToString().Split('^')[0];
                //    colst = 1; k = 1; flgb = false; rowst = 1;


                //    for (var i = 0; i < noofsplit; i++)
                //    {
                //        //strold = "";                                                   
                //        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == true)
                //        {
                //            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i, c + 1)).Merge();
                //            flgb = false;
                //            rowst++;
                //        }

                //        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] == "")
                //        {
                //            flgb = true;
                //        }

                //        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == false && i > 0)
                //        {
                //            rowst++;
                //        }

                //        if (i == noofsplit - 1 && flgb == true)
                //        {
                //            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i + 1, c + 1)).Merge();
                //        }
                //    }
                //}
                /**/

                ws.Columns().AdjustToContents();
                ws.Rows().AdjustToContents();

                //ws.Rows().AdjustToContents();
                var rangeWithData = ws.Cell(noofsplit + 1, 1).InsertData(dt.AsEnumerable());
                //ws.Columns().AdjustToContents();//noofsplit + 1,  dt.Columns.Count
                k = 3;
                IXLCell cell3 = ws.Cell(1, 1);
                IXLCell cell4 = ws.Cell(dt.Rows.Count + noofsplit, dt.Columns.Count);
                //ws.Range(ws.Cell(k, 7), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 8), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 9), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(2, 3, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 11), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 12), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 13), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);

                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Fill.BackgroundColor = XLColor.FromHtml("#d6d6d6");
                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Font.FontColor = XLColor.FromHtml("#000000");
                ws.SheetView.FreezeRows(noofsplit);
                ws.SheetView.FreezeColumns(noofcolfreeze);
                //}
                ws.Columns().AdjustToContents();
                ws.Rows().AdjustToContents();
                ws.Range(1, 1, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.WrapText = true;
                // ws.Cell(dt.Rows.Count + 1, 1).Value = "";
                //ws.Column(1).Delete();


                //Export the Excel file.
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(HttpContext.Current.Response.OutputStream);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            if (cntvalid == 0)
            {
                Response.Write(ex.Message);
            }
            // string ProjectTitle = ConfigurationManager.AppSettings["Title"];
            //clsSendLogMail.fnSendLogMail(ex.Message, ex.ToString(), "FrmDownload Page", "Download Page", "Error in FrmDownload Page in " + ProjectTitle);
        }
        finally
        {
        }
    }

    public void fnDownloadAssessmentScore(string Phase1Date, string LoginId, string BandId, string Phase2RolePlayDate, string Phase2BEIDate)
    {
        string[] SkipColumn = new string[0];
        string filename = "";
        int cntvalid = 0;
        filename = "AssessmentScore_" + DateTime.Now.ToString("yyyyMMdd");
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            string storedProcName = "spDownloadAssessmentScore";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {
                  new SqlParameter("@Phase1Date", Phase1Date),
                   new SqlParameter("@LoginId", LoginId),
                   new SqlParameter("@BandId", BandId),
                   new SqlParameter("@Phase2RolePlayDate", Phase2RolePlayDate),
                   new SqlParameter("@Phase2BEIDate", Phase2BEIDate)
                };
            DataSet Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);
            using (XLWorkbook wb = new XLWorkbook())
            {
                cntvalid = 1;
                ////Start Chassiss
                int k = 1; int j = 0; int colFreeze = 2; int colLeft = 3;
                string strold = ""; int cntc = 0; int colst = 2; bool flgb = true;
                int resulsetcnt = 0;
                //foreach (DataRow drowchasiss in Ds.Tables[0].Rows)//For SheetName
                //{
                string strSheetName = "AssessmentScore";
                DataTable dt = Ds.Tables[resulsetcnt];

                resulsetcnt++;
                var ws = wb.Worksheets.Add(strSheetName);
                k = 1; j = 0; colFreeze = 2; colLeft = 3;
                strold = ""; cntc = 0; colst = 2; flgb = true; bool flgm = false;
                //int rowstart = 0; // for data part insertion
                int noofsplit = 2; //Convert.ToInt16(drowchasiss["NoOfSplit"]);
                int noofcolfreeze = 2;// Convert.ToInt16(drowchasiss["Noofcolfreeze"]);
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                    {
                        string[] ColSpliter = dt.Columns[c].ColumnName.ToString().Split('^');
                        flgm = true;
                        for (var i = 0; i < ColSpliter.Length; i++)
                        {
                            string sVal = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                            ws.Cell(k + i, j + 1).Value = sVal.Split('^')[0];
                            string bgcolor = "#305496"; string forrecolor = "#ffffff";
                            if (i == 0)
                            {
                                if (dt.Columns[c].ColumnName.ToString().Contains("BEI"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#c55911";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("Role Play"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#b678b5";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("Individual Development"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#ffd966";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("Case Study measuring"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#8497b0";
                                }
                            }
                            else
                            {
                                if (dt.Columns[c].ColumnName.ToString().Contains("BEI"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#f6c9ab";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("Role Play"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#dec8ee";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("AOS"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#a9d08e";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("AOD"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#f77575";
                                }
                                else if (dt.Columns[c].ColumnName.ToString().Contains("Case Study Answer"))
                                {
                                    forrecolor = "#000000";
                                    bgcolor = "#d6dce4";
                                }
                            }
                            ws.Cell(k + i, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(bgcolor);
                            ws.Cell(k + i, j + 1).Style.Font.FontColor = XLColor.FromHtml(forrecolor);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        }

                        j++;
                    }
                }

                for (var i = 0; i < noofsplit - 1; i++)
                {
                    j = 0; colst = 1; k = 1; strold = "";
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        //if (strold != "")
                        //{
                        if (strold != dt.Columns[c].ColumnName.ToString().Split('^')[i])
                        {
                            flgb = true;
                            if (strold != "")
                            {
                                ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j)).Merge();
                            }
                            cntc = 0;
                        }
                        //}
                        if (flgb == true)
                        {
                            colst = j + 1;
                        }
                        flgb = false;
                        strold = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                        cntc++;
                        if (c == dt.Columns.Count - 1)
                        {
                            ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j + 1)).Merge();
                            cntc = 0;
                        }

                        j++;
                    }
                }


                int rowst = 0;
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    strold = dt.Columns[c].ColumnName.ToString().Split('^')[0];
                    colst = 1; k = 1; flgb = false; rowst = 1;


                    for (var i = 0; i < noofsplit; i++)
                    {
                        //strold = "";                                                   
                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == true)
                        {
                            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i, c + 1)).Merge();
                            flgb = false;
                            rowst++;
                        }

                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] == "")
                        {
                            flgb = true;
                        }

                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == false && i > 0)
                        {
                            rowst++;
                        }

                        if (i == noofsplit - 1 && flgb == true)
                        {
                            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i + 1, c + 1)).Merge();
                        }
                    }
                }
                /**/



                //ws.Rows().AdjustToContents();
                var rangeWithData = ws.Cell(noofsplit + 1, 1).InsertData(dt.AsEnumerable());
                //ws.Columns().AdjustToContents();//noofsplit + 1,  dt.Columns.Count
                k = 3;
                IXLCell cell3 = ws.Cell(1, 1);
                IXLCell cell4 = ws.Cell(dt.Rows.Count + noofsplit, dt.Columns.Count);
                //ws.Range(ws.Cell(k, 7), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 8), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 9), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(2,3, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 11), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 12), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 13), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);

                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Fill.BackgroundColor = XLColor.FromHtml("#d6d6d6");
                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Font.FontColor = XLColor.FromHtml("#000000");
                ws.SheetView.FreezeRows(noofsplit);
                ws.SheetView.FreezeColumns(noofcolfreeze);
                //}
                ws.Columns().AdjustToContents();
                ws.Rows().AdjustToContents();
                ws.Range(1, 1, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.WrapText = true;
                // ws.Cell(dt.Rows.Count + 1, 1).Value = "";
                //ws.Column(1).Delete();


                //Export the Excel file.
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(HttpContext.Current.Response.OutputStream);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            if (cntvalid == 0)
            {
                Response.Write(ex.Message);
            }
            // string ProjectTitle = ConfigurationManager.AppSettings["Title"];
            //clsSendLogMail.fnSendLogMail(ex.Message, ex.ToString(), "FrmDownload Page", "Download Page", "Error in FrmDownload Page in " + ProjectTitle);
        }
        finally
        {
        }
    }

    public void fnDownloadProctoringReport(string band)
    {
        string[] SkipColumn = new string[0];
        string filename = "";
        int cntvalid = 0;
        filename = "ProctoringReport_" + band + "_" + DateTime.Now.ToString("yyyyMMdd");
        try
        {
            DataSet Ds = (DataSet)Session["dsRptProctoring"];
            using (XLWorkbook wb = new XLWorkbook())
            {
                cntvalid = 1;
                ////Start Chassiss
                int k = 1; int j = 0; int colFreeze = 2; int colLeft = 3;
                string strold = ""; int cntc = 0; int colst = 2; bool flgb = true;
                int resulsetcnt = 0;
                //foreach (DataRow drowchasiss in Ds.Tables[0].Rows)//For SheetName
                //{
                string strSheetName = band;//drowchasiss["SheetName"].ToString();
                DataTable dt = Ds.Copy().Tables[resulsetcnt];
                dt.Columns.Remove("EmpID");

                resulsetcnt++;
                var ws = wb.Worksheets.Add(strSheetName);
                k = 1; j = 0; colFreeze = 2; colLeft = 3;
                strold = ""; cntc = 0; colst = 2; flgb = true; bool flgm = false;
                //int rowstart = 0; // for data part insertion
                int noofsplit = 1; //Convert.ToInt16(drowchasiss["NoOfSplit"]);
                int noofcolfreeze = 1;// Convert.ToInt16(drowchasiss["Noofcolfreeze"]);
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                    {
                        string[] ColSpliter = dt.Columns[c].ColumnName.ToString().Split('^');


                        flgm = true;

                        for (var i = 0; i < ColSpliter.Length; i++)
                        {
                            string sVal = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                            ws.Cell(k + i, j + 1).Value = sVal.Split('^')[0];
                        }
                        for (var i = 0; i < noofsplit; i++)
                        {
                            string bgcolor = "#728cd4"; string forrecolor = "#ffffff";
                            if (i == 1)
                            {
                                bgcolor = "#a4b6e3";
                                forrecolor = "#000000";
                            }
                            ws.Cell(k + i, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(bgcolor);
                            ws.Cell(k + i, j + 1).Style.Font.FontColor = XLColor.FromHtml(forrecolor);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        }
                        j++;
                    }
                }

                for (var i = 0; i < noofsplit - 1; i++)
                {
                    j = 0; colst = 1; k = 1; strold = "";
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        //if (strold != "")
                        //{
                        if (strold != dt.Columns[c].ColumnName.ToString().Split('^')[i])
                        {
                            flgb = true;
                            if (strold != "")
                            {
                                ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j)).Merge();
                            }
                            cntc = 0;
                        }
                        //}
                        if (flgb == true)
                        {
                            colst = j + 1;
                        }
                        flgb = false;
                        strold = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                        cntc++;
                        if (c == dt.Columns.Count - 1)
                        {
                            ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j + 1)).Merge();
                            cntc = 0;
                        }

                        j++;
                    }
                }


                int rowst = 0;
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    strold = dt.Columns[c].ColumnName.ToString().Split('^')[0];
                    colst = 1; k = 1; flgb = false; rowst = 1;


                    for (var i = 0; i < noofsplit; i++)
                    {
                        //strold = "";                                                   
                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == true)
                        {
                            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i, c + 1)).Merge();
                            flgb = false;
                            rowst++;
                        }

                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] == "")
                        {
                            flgb = true;
                        }

                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == false && i > 0)
                        {
                            rowst++;
                        }

                        if (i == noofsplit - 1 && flgb == true)
                        {
                            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i + 1, c + 1)).Merge();
                        }
                    }
                }
                /**/
                k = 2;
                for (int r = 0; r < dt.Rows.Count; r++)
                {
                    j = 0;
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                        {
                            if (dt.Columns[c].ColumnName.ToString().Trim() == "ColorCode_NoFace" || dt.Columns[c].ColumnName.ToString().Trim() == "ColorCode_Instance")
                            {

                                //ws.Cell(k + r, j + 1).Style.Font.FontColor = XLColor.FromHtml(sbForeColor);
                                ws.Cell(k + r, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(dt.Rows[r][c].ToString());
                                //ws.Cell(k + r, j + 1).Value = dt.Rows[r][c].ToString(); ;
                            }
                            else
                            {
                                ws.Cell(k + r, j + 1).Value = dt.Rows[r][c].ToString().Split('^')[0];
                            }

                            j++;
                        }

                    }
                }


                ws.Rows().AdjustToContents();
                //var rangeWithData = ws.Cell(noofsplit + 1, 1).InsertData(dt.AsEnumerable());
                ws.Columns().AdjustToContents();//noofsplit + 1,  dt.Columns.Count

                IXLCell cell3 = ws.Cell(1, 1);
                IXLCell cell4 = ws.Cell(dt.Rows.Count + noofsplit, dt.Columns.Count);
                ws.Range(ws.Cell(k, 7), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 8), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 9), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 10), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 11), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 12), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 13), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);

                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Fill.BackgroundColor = XLColor.FromHtml("#d6d6d6");
                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Font.FontColor = XLColor.FromHtml("#000000");
                ws.SheetView.FreezeRows(noofsplit);
                ws.SheetView.FreezeColumns(noofcolfreeze);
                //}
                ws.Columns().AdjustToContents();
                ws.Rows().AdjustToContents();
                ws.Range(1, 1, 1, dt.Columns.Count).Style.Alignment.WrapText = true;
                // ws.Cell(dt.Rows.Count + 1, 1).Value = "";
                //ws.Column(1).Delete();


                //Export the Excel file.
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(HttpContext.Current.Response.OutputStream);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            if (cntvalid == 0)
            {
                Response.Write(ex.Message);
            }
            // string ProjectTitle = ConfigurationManager.AppSettings["Title"];
            //clsSendLogMail.fnSendLogMail(ex.Message, ex.ToString(), "FrmDownload Page", "Download Page", "Error in FrmDownload Page in " + ProjectTitle);
        }
        finally
        {
        }
    }


    public void fnDownloadRptParticipantStatus(string CycleID)
    {
        string[] SkipColumn = new string[0];
        string filename = "";
        int cntvalid = 0;
        filename = "ParticipantStatusReport_" + DateTime.Now.ToString("yyyyMMdd");
        try
        {
            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = null;
            SqlDataAdapter Sdap = null;

            Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[spRspGetMainToolWiseStatusForAll]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.CommandTimeout = 0;
            Scmd.Parameters.AddWithValue("@CycleId", CycleID);

            Sdap = new SqlDataAdapter(Scmd);

            //DataSet Ds = (DataSet)Session["dsRptParticipantStatus"];
            DataSet Ds = new DataSet();
            Sdap.Fill(Ds);
            using (XLWorkbook wb = new XLWorkbook())
            {
                cntvalid = 1;
                ////Start Chassiss
                int k = 1; int j = 0; int colFreeze = 2; int colLeft = 3;
                string strold = ""; int cntc = 0; int colst = 2; bool flgb = true;
                int resulsetcnt = 0;
                //foreach (DataRow drowchasiss in Ds.Tables[0].Rows)//For SheetName
                //{
                string strSheetName = "AssessmentStatus";//drowchasiss["SheetName"].ToString();
                DataTable dt = Ds.Copy().Tables[resulsetcnt];
                dt.Columns.Remove("EmpNodeId");
                dt.Columns.Remove("RspID");
                dt.Columns.Remove("flgFinalStatus");
                dt.Columns.Remove("IsSubmitByEYAdminForReporting");
                dt.Columns.Remove("DetailedFeedbackReport");
                dt.Columns.Remove("MindsetReportURL");
dt.Columns.Remove("PenPictureReportURL");
dt.Columns.Remove("TalentSnapshotURL");
dt.Columns.Remove("flgReportGenerated");


                resulsetcnt++;
                var ws = wb.Worksheets.Add(strSheetName);
                k = 1; j = 0; colFreeze = 2; colLeft = 3;
                strold = ""; cntc = 0; colst = 2; flgb = true; bool flgm = false;
                //int rowstart = 0; // for data part insertion
                int noofsplit = 1; //Convert.ToInt16(drowchasiss["NoOfSplit"]);
                int noofcolfreeze = 1;// Convert.ToInt16(drowchasiss["Noofcolfreeze"]);
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                    {
                        string[] ColSpliter = dt.Columns[c].ColumnName.ToString().Split('^');


                        flgm = true;

                        for (var i = 0; i < ColSpliter.Length; i++)
                        {
                            string sVal = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                            ws.Cell(k + i, j + 1).Value = sVal.Split('^')[0].Replace("<br>",":");
                        }
                        for (var i = 0; i < noofsplit; i++)
                        {
                            string bgcolor = "#728cd4"; string forrecolor = "#ffffff";
                            if (i == 1)
                            {
                                bgcolor = "#a4b6e3";
                                forrecolor = "#000000";
                            }
                            ws.Cell(k + i, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(bgcolor);
                            ws.Cell(k + i, j + 1).Style.Font.FontColor = XLColor.FromHtml(forrecolor);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            ws.Cell(k + i, j + 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                        }
                        j++;
                    }
                }

                for (var i = 0; i < noofsplit - 1; i++)
                {
                    j = 0; colst = 1; k = 1; strold = "";
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        //if (strold != "")
                        //{
                        if (strold != dt.Columns[c].ColumnName.ToString().Split('^')[i])
                        {
                            flgb = true;
                            if (strold != "")
                            {
                                ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j)).Merge();
                            }
                            cntc = 0;
                        }
                        //}
                        if (flgb == true)
                        {
                            colst = j + 1;
                        }
                        flgb = false;
                        strold = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                        cntc++;
                        if (c == dt.Columns.Count - 1)
                        {
                            ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j + 1)).Merge();
                            cntc = 0;
                        }

                        j++;
                    }
                }


                int rowst = 0;
                for (int c = 0; c < dt.Columns.Count; c++)
                {
                    strold = dt.Columns[c].ColumnName.ToString().Split('^')[0];
                    colst = 1; k = 1; flgb = false; rowst = 1;


                    for (var i = 0; i < noofsplit; i++)
                    {
                        //strold = "";                                                   
                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == true)
                        {
                            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i, c + 1)).Merge();
                            flgb = false;
                            rowst++;
                        }

                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] == "")
                        {
                            flgb = true;
                        }

                        if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == false && i > 0)
                        {
                            rowst++;
                        }

                        if (i == noofsplit - 1 && flgb == true)
                        {
                            ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i + 1, c + 1)).Merge();
                        }
                    }
                }
                /**/


                k = 2;
                ws.Rows().AdjustToContents();
                for (int r = 0; r < dt.Rows.Count; r++)
                {
                    j = 0;
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        string sbColor = ""; string sbForeColor = "";
                        if (dt.Rows[r][c].ToString().Split('^').Length > 2)
                        {
                            switch (dt.Rows[r][c].ToString().Split('^')[0])
                            {
                                case "1":
                                    sbForeColor = "#ffffff";
                                    sbColor = "#ff0000";
                                    break;
                                case "2":
                                    sbForeColor = "#000000";
                                    sbColor = "#ff9b9b";
                                    break;
                                case "3":
                                    sbForeColor = "#000000";
                                    sbColor = "#80ff80";
                                    break;
                                case "4":
                                    sbForeColor = "#000000";
                                    sbColor = "#80ff80";
                                    break;
                                case "5":
                                    sbForeColor = "#ffffff";
                                    sbColor = "#8000ff";
                                    break;
                                case "6":
                                    sbForeColor = "#ffffff";
                                    sbColor = "#0000a0";
                                    break;
                                default:
                                    sbForeColor = "#000000";
                                    sbColor = "transparent";
                                    break;
                            }

                            if (dt.Rows[r][c].ToString().Split('^')[0] == "Completed")
                            {
                                ws.Cell(k + r, j + 1).Style.Font.FontColor = XLColor.FromHtml(sbForeColor);
                                ws.Cell(k + r, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(sbColor);
                                ws.Cell(k + r, j + 1).Value = "Completed";
                            }
                            else
                            {
                                ws.Cell(k + r, j + 1).Style.Font.FontColor = XLColor.FromHtml(sbForeColor);
                                ws.Cell(k + r, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(sbColor);
                                ws.Cell(k + r, j + 1).Value = dt.Rows[r][c].ToString().Split('^')[0];
                            }
                        }
                        else
                        {
                            ws.Cell(k + r, j + 1).Value = dt.Rows[r][c].ToString().Split('^')[0];
                        }

                        j++;
                    }
                }
                //  var rangeWithData = ws.Cell(noofsplit + 1, 1).InsertData(dt.AsEnumerable());
                //ws.Columns().AdjustToContents();//noofsplit + 1,  dt.Columns.Count

                IXLCell cell3 = ws.Cell(1, 1);
                IXLCell cell4 = ws.Cell(dt.Rows.Count + noofsplit, dt.Columns.Count);
                ws.Range(ws.Cell(k, 7), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 8), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 9), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                //ws.Range(ws.Cell(k, 10), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 11), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 12), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                //ws.Range(ws.Cell(k, 13), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);

                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Fill.BackgroundColor = XLColor.FromHtml("#d6d6d6");
                //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Font.FontColor = XLColor.FromHtml("#000000");
                ws.SheetView.FreezeRows(noofsplit);
                ws.SheetView.FreezeColumns(noofcolfreeze);
                //}
                ws.Columns().AdjustToContents();
                ws.Rows().AdjustToContents();
                ws.Range(1, 1, 1, dt.Columns.Count).Style.Alignment.WrapText = true;
                // ws.Cell(dt.Rows.Count + 1, 1).Value = "";
                //ws.Column(1).Delete();


                //Export the Excel file.
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(HttpContext.Current.Response.OutputStream);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            if (cntvalid == 0)
            {
                Response.Write(ex.Message);
            }
            // string ProjectTitle = ConfigurationManager.AppSettings["Title"];
            //clsSendLogMail.fnSendLogMail(ex.Message, ex.ToString(), "FrmDownload Page", "Download Page", "Error in FrmDownload Page in " + ProjectTitle);
        }
        finally
        {
        }
    }

    public void fnDownloadParticipantAssessorList(string FromDate, string ToDate)
    {
        string[] SkipColumn = new string[0];
        string filename = "";
        int cntvalid = 0;
        filename = "ParticipantAssessorList_" + DateTime.Now.ToString("yyyyMMdd");
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            string storedProcName = "spDownloadParticipantAssessorList";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {
                 new SqlParameter("@FromDate", FromDate),
                   new SqlParameter("@ToDate", ToDate)
                };
            DataSet Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);
            using (XLWorkbook wb = new XLWorkbook())
            {
                cntvalid = 1;
                ////Start Chassiss
                int resulsetcnt = 1;
                foreach (DataRow drowchasiss in Ds.Tables[0].Rows)//For SheetName
                {
                    int k = 1; int j = 0; int colFreeze = 2; int colLeft = 3;
                    string strold = ""; int cntc = 0; int colst = 2; bool flgb = true;
                    string strSheetName = drowchasiss["SheetName"].ToString();
                    DataTable dt = Ds.Tables[resulsetcnt];

                    resulsetcnt++;
                    var ws = wb.Worksheets.Add(strSheetName);
                    k = 1; j = 0; colFreeze = 2; colLeft = 3;
                    strold = ""; cntc = 0; colst = 2; flgb = true; bool flgm = false;
                    //int rowstart = 0; // for data part insertion
                    int noofsplit = 1; //Convert.ToInt16(drowchasiss["NoOfSplit"]);
                    int noofcolfreeze = 2;// Convert.ToInt16(drowchasiss["Noofcolfreeze"]);
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                        {
                            string[] ColSpliter = dt.Columns[c].ColumnName.ToString().Split('^');
                            flgm = true;
                            for (var i = 0; i < ColSpliter.Length; i++)
                            {
                                string sVal = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                                ws.Cell(k + i, j + 1).Value = sVal.Split('^')[0];
                                string bgcolor = "#305496"; string forrecolor = "#ffffff";
                                ws.Cell(k + i, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(bgcolor);
                                ws.Cell(k + i, j + 1).Style.Font.FontColor = XLColor.FromHtml(forrecolor);
                                ws.Cell(k + i, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                                ws.Cell(k + i, j + 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                            }

                            j++;
                        }
                    }

                    for (var i = 0; i < noofsplit - 1; i++)
                    {
                        j = 0; colst = 1; k = 1; strold = "";
                        for (int c = 0; c < dt.Columns.Count; c++)
                        {
                            //if (strold != "")
                            //{
                            if (strold != dt.Columns[c].ColumnName.ToString().Split('^')[i])
                            {
                                flgb = true;
                                if (strold != "")
                                {
                                    ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j)).Merge();
                                }
                                cntc = 0;
                            }
                            //}
                            if (flgb == true)
                            {
                                colst = j + 1;
                            }
                            flgb = false;
                            strold = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                            cntc++;
                            if (c == dt.Columns.Count - 1)
                            {
                                ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j + 1)).Merge();
                                cntc = 0;
                            }

                            j++;
                        }
                    }


                    int rowst = 0;
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        strold = dt.Columns[c].ColumnName.ToString().Split('^')[0];
                        colst = 1; k = 1; flgb = false; rowst = 1;


                        for (var i = 0; i < noofsplit; i++)
                        {
                            //strold = "";                                                   
                            if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == true)
                            {
                                ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i, c + 1)).Merge();
                                flgb = false;
                                rowst++;
                            }

                            if (dt.Columns[c].ColumnName.ToString().Split('^')[i] == "")
                            {
                                flgb = true;
                            }

                            if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == false && i > 0)
                            {
                                rowst++;
                            }

                            if (i == noofsplit - 1 && flgb == true)
                            {
                                ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i + 1, c + 1)).Merge();
                            }
                        }
                    }
                    /**/



                    //ws.Rows().AdjustToContents();
                    var rangeWithData = ws.Cell(noofsplit + 1, 1).InsertData(dt.AsEnumerable());
                    //ws.Columns().AdjustToContents();//noofsplit + 1,  dt.Columns.Count
                    k = 3;
                    IXLCell cell3 = ws.Cell(1, 1);
                    IXLCell cell4 = ws.Cell(dt.Rows.Count + noofsplit, dt.Columns.Count);
                    //ws.Range(ws.Cell(k, 7), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                    //ws.Range(ws.Cell(k, 8), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                    //ws.Range(ws.Cell(k, 9), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                    //ws.Range(2,3, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    //ws.Range(ws.Cell(k, 11), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    //ws.Range(ws.Cell(k, 12), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    //ws.Range(ws.Cell(k, 13), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                    ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                    ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);

                    //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Fill.BackgroundColor = XLColor.FromHtml("#d6d6d6");
                    //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Font.FontColor = XLColor.FromHtml("#000000");
                    ws.SheetView.FreezeRows(noofsplit);
                    ws.SheetView.FreezeColumns(noofcolfreeze);

                    ws.Columns().AdjustToContents();
                    ws.Rows().AdjustToContents();
                    ws.Range(1, 1, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.WrapText = true;
                    // ws.Cell(dt.Rows.Count + 1, 1).Value = "";
                    //ws.Column(1).Delete();
                }

                //Export the Excel file.
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(HttpContext.Current.Response.OutputStream);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            if (cntvalid == 0)
            {
                Response.Write(ex.Message);
            }
            // string ProjectTitle = ConfigurationManager.AppSettings["Title"];
            //clsSendLogMail.fnSendLogMail(ex.Message, ex.ToString(), "FrmDownload Page", "Download Page", "Error in FrmDownload Page in " + ProjectTitle);
        }
        finally
        {
        }
    }

    public void fnDownloadFeedbackParticipantAssessorList()
    {
        string[] SkipColumn = new string[0];
        string filename = "";
        int cntvalid = 0;
        filename = "AssessorParticipantFeedbackDetail_" + DateTime.Now.ToString("yyyyMMdd");
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            string storedProcName = "spDownloadAssessorParticipantFeedbackDetail";
            //List<SqlParameter> sp = new List<SqlParameter>()
            //        {
            //     new SqlParameter("@FromDate", FromDate),
            //       new SqlParameter("@ToDate", ToDate)
            //    };
            List<SqlParameter> sp = null;
            DataSet Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);
            using (XLWorkbook wb = new XLWorkbook())
            {
                cntvalid = 1;
                ////Start Chassiss
                int resulsetcnt = 1;
                foreach (DataRow drowchasiss in Ds.Tables[0].Rows)//For SheetName
                {
                    int k = 1; int j = 0; int colFreeze = 2; int colLeft = 3;
                    string strold = ""; int cntc = 0; int colst = 2; bool flgb = true;
                    string strSheetName = drowchasiss["SheetName"].ToString();
                    DataTable dt = Ds.Tables[resulsetcnt];

                    resulsetcnt++;
                    var ws = wb.Worksheets.Add(strSheetName);
                    k = 1; j = 0; colFreeze = 2; colLeft = 3;
                    strold = ""; cntc = 0; colst = 2; flgb = true; bool flgm = false;
                    //int rowstart = 0; // for data part insertion
                    int noofsplit = 1; //Convert.ToInt16(drowchasiss["NoOfSplit"]);
                    int noofcolfreeze = 2;// Convert.ToInt16(drowchasiss["Noofcolfreeze"]);
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        if (!SkipColumn.Contains(dt.Columns[c].ColumnName.ToString().Trim()))
                        {
                            string[] ColSpliter = dt.Columns[c].ColumnName.ToString().Split('^');
                            flgm = true;
                            for (var i = 0; i < ColSpliter.Length; i++)
                            {
                                string sVal = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                                ws.Cell(k + i, j + 1).Value = sVal.Split('^')[0];
                                string bgcolor = "#305496"; string forrecolor = "#ffffff";
                                ws.Cell(k + i, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml(bgcolor);
                                ws.Cell(k + i, j + 1).Style.Font.FontColor = XLColor.FromHtml(forrecolor);
                                ws.Cell(k + i, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                                ws.Cell(k + i, j + 1).Style.Alignment.SetVertical(XLAlignmentVerticalValues.Center);
                            }

                            j++;
                        }
                    }

                    for (var i = 0; i < noofsplit - 1; i++)
                    {
                        j = 0; colst = 1; k = 1; strold = "";
                        for (int c = 0; c < dt.Columns.Count; c++)
                        {
                            //if (strold != "")
                            //{
                            if (strold != dt.Columns[c].ColumnName.ToString().Split('^')[i])
                            {
                                flgb = true;
                                if (strold != "")
                                {
                                    ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j)).Merge();
                                }
                                cntc = 0;
                            }
                            //}
                            if (flgb == true)
                            {
                                colst = j + 1;
                            }
                            flgb = false;
                            strold = dt.Columns[c].ColumnName.ToString().Split('^')[i];
                            cntc++;
                            if (c == dt.Columns.Count - 1)
                            {
                                ws.Range(ws.Cell(k + i, colst), ws.Cell(k + i, j + 1)).Merge();
                                cntc = 0;
                            }

                            j++;
                        }
                    }


                    int rowst = 0;
                    for (int c = 0; c < dt.Columns.Count; c++)
                    {
                        strold = dt.Columns[c].ColumnName.ToString().Split('^')[0];
                        colst = 1; k = 1; flgb = false; rowst = 1;


                        for (var i = 0; i < noofsplit; i++)
                        {
                            //strold = "";                                                   
                            if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == true)
                            {
                                ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i, c + 1)).Merge();
                                flgb = false;
                                rowst++;
                            }

                            if (dt.Columns[c].ColumnName.ToString().Split('^')[i] == "")
                            {
                                flgb = true;
                            }

                            if (dt.Columns[c].ColumnName.ToString().Split('^')[i] != "" && flgb == false && i > 0)
                            {
                                rowst++;
                            }

                            if (i == noofsplit - 1 && flgb == true)
                            {
                                ws.Range(ws.Cell(rowst, c + 1), ws.Cell(i + 1, c + 1)).Merge();
                            }
                        }
                    }
                    /**/



                    //ws.Rows().AdjustToContents();
                    var rangeWithData = ws.Cell(noofsplit + 1, 1).InsertData(dt.AsEnumerable());
                    //ws.Columns().AdjustToContents();//noofsplit + 1,  dt.Columns.Count
                    k = 3;
                    IXLCell cell3 = ws.Cell(1, 1);
                    IXLCell cell4 = ws.Cell(dt.Rows.Count + noofsplit, dt.Columns.Count);
                    //ws.Range(ws.Cell(k, 7), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                    //ws.Range(ws.Cell(k, 8), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                    //ws.Range(ws.Cell(k, 9), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                    //ws.Range(2,3, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    //ws.Range(ws.Cell(k, 11), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    //ws.Range(ws.Cell(k, 12), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    //ws.Range(ws.Cell(k, 13), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                    ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                    ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);

                    //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Fill.BackgroundColor = XLColor.FromHtml("#d6d6d6");
                    //ws.Range(ws.Cell(dt.Rows.Count + 1, 1), cell4).Style.Font.FontColor = XLColor.FromHtml("#000000");
                    ws.SheetView.FreezeRows(noofsplit);
                    ws.SheetView.FreezeColumns(noofcolfreeze);

                    ws.Columns().AdjustToContents();
                    ws.Rows().AdjustToContents();
                    ws.Range(1, 1, dt.Rows.Count + noofsplit, dt.Columns.Count).Style.Alignment.WrapText = true;
                    // ws.Cell(dt.Rows.Count + 1, 1).Value = "";
                    //ws.Column(1).Delete();
                }

                //Export the Excel file.
                HttpContext.Current.Response.Clear();
                HttpContext.Current.Response.Buffer = true;
                HttpContext.Current.Response.Charset = "";
                HttpContext.Current.Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";

                //Response.ContentType = "application/vnd.ms-excel";
                HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(HttpContext.Current.Response.OutputStream);
                    HttpContext.Current.Response.Flush();
                    HttpContext.Current.Response.End();
                }
            }
        }
        catch (Exception ex)
        {
            if (cntvalid == 0)
            {
                Response.Write(ex.Message);
            }
            // string ProjectTitle = ConfigurationManager.AppSettings["Title"];
            //clsSendLogMail.fnSendLogMail(ex.Message, ex.ToString(), "FrmDownload Page", "Download Page", "Error in FrmDownload Page in " + ProjectTitle);
        }
        finally
        {
        }
    }

}