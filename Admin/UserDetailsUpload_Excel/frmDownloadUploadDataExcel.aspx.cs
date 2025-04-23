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
public partial class frmDownloadUploadDataExcel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        //Response.Write("<br/><br/><b>Report is being downloaded,please wait... </b>");
        string[] notrowspanColumn = new string[0];
        string sFlg = Request.QueryString["flg"].ToString();//"1";//
        if (sFlg == "1")
        {
            string LoginId = Request.QueryString["LoginID"].ToString();//"1";//
            string EngagementId = Request.QueryString["EngagementId"].ToString();//"1";//
            string EngagementAssessmentId = Request.QueryString["EngagementAssessmentId"].ToString();//"1";//
            string EngagementName = Request.QueryString["EngagementName"].ToString();//"1";//
            string EngagementAssessmentName = Request.QueryString["EngagementAssessmentName"].ToString();//"1";//

            fnDownloadUploadedData(LoginId, EngagementId, EngagementAssessmentId, EngagementName, EngagementAssessmentName);
        }

    }

    public void fnDownloadUploadedData(string LoginId, string EngagementId, string EngagementAssessmentId, string EngagementName, string EngagementAssessmentName)
    {
        string[] SkipColumn = new string[0];
        string filename = "";
        int cntvalid = 0;
        string strSheetName = "";
        filename = EngagementName + "_" + EngagementAssessmentName + DateTime.Now.ToString("ddMMyyyy_HHmmss");
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            string storedProcName = "spEngaggementMaster_GetUploadedUserList";
            List<SqlParameter> sp = new List<SqlParameter>()
                    {

                   new SqlParameter("@EngagementAssessmentId", Convert.ToInt32(EngagementAssessmentId)),
                   new SqlParameter("@LoginId", Convert.ToInt32(LoginId))
                };
            DataSet Ds = clsDbCommand.ExecuteQueryReturnDataSet(storedProcName, con, sp);


            using (XLWorkbook wb = new XLWorkbook())
            {
                ////Start Chassiss
                int k = 1; int j = 0; int colFreeze = 2; int colLeft = 3;
                string strold = ""; int cntc = 0; int colst = 2; bool flgb = true;

                int resulsetcnt = 0;
                // foreach (DataRow drowchasiss in Ds.Tables[0].Rows)//For SheetName
                //foreach (DataTable drowchasiss in Ds.Tables)//For SheetName
                for (resulsetcnt = 0; resulsetcnt < Ds.Tables.Count; resulsetcnt++)
                {
                   

                    //if (resulsetcnt == 4 || resulsetcnt == 5)
                    //{
                    // string strSheetName = drowchasiss["SheetName"].ToString(); //"PrimaryUploadStatus";//
                    DataTable dt = Ds.Tables[resulsetcnt];
                    //  resulsetcnt++;
                    if (dt.TableName == "Table")
                    {
                        strSheetName = "User Data";

                    }
                    else if (dt.TableName == "Table1")
                    {
                        strSheetName = "Column Mapping";
                    }
                    else
                    {
                        strSheetName = dt.TableName;
                    }
                    var ws = wb.Worksheets.Add(strSheetName.Replace("/", "_"));
                    //var ws = wb.Worksheets.Add(dt.TableName.Replace("/", "_"));
                    k = 1; j = 0; colFreeze = 2; colLeft = 3;
                    strold = ""; cntc = 0; colst = 2; flgb = true; bool flgm = false;
                    //int rowstart = 0; // for data part insertion
                    int noofsplit = Convert.ToInt16(dt.Columns[0].ColumnName.ToString().Split('^').Length); //Convert.ToInt16(drowchasiss["NoOfSplit"]);
                    int noofcolfreeze = 0;// Convert.ToInt16(drowchasiss["Noofcolfreeze"]);
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
                                ws.Cell(k + i, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml("#728cd4");
                                ws.Cell(k + i, j + 1).Style.Font.FontColor = XLColor.FromHtml("#ffffff");
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

                    ws.Rows().AdjustToContents();

                    //var rangeWithData = ws.Cell(noofsplit + 1, 1).InsertData(dt.AsEnumerable());

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        for (j = 0; j < dt.Columns.Count; j++)
                        {
                            var sData = dt.Rows[i][j];
                            //string aligns = "";
                            if (sData.GetType() == typeof(int))
                            {
                                //aligns = "center";
                                ws.Cell(noofsplit + i + 1, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                            }
                            else if (sData.GetType() == typeof(decimal))
                            {
                                //aligns = "right";
                                ws.Cell(noofsplit + i + 1, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Right);
                                //sData = Convert.ToDecimal(sData).ToString("F");
                            }
                            else
                            {
                                ws.Cell(noofsplit + i + 1, j + 1).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Left);
                                //aligns = "left";
                            }


                            // ws.Cell(noofsplit + i + 1, j + 1).Value =  dt.Rows[i][j].ToString().IndexOf('') != -1 ? dt.Rows[i][j].ToString().Split('')[0] : dt.Rows[i][j].ToString();
                            ws.Cell(noofsplit + i + 1, j + 1).Value = dt.Rows[i][j].ToString();
                            ws.Cell(noofsplit + i + 1, j + 1).Style.Font.FontName = "Calibri";
                            ws.Cell(noofsplit + i + 1, j + 1).Style.Font.FontSize = 9;

                            if (dt.Rows[i][j].ToString().IndexOf('~') != -1)
                            {
                                ws.Cell(noofsplit + i + 1, j + 1).Style.Fill.BackgroundColor = XLColor.FromHtml("#ffff80");
                            }
                        }
                    }


                    IXLCell cell3 = ws.Cell(1, 1);
                    IXLCell cell4 = ws.Cell(dt.Rows.Count + noofsplit, dt.Columns.Count);

                    //ws.Range(ws.Cell(k, 4), cell4).Style.Alignment.SetHorizontal(XLAlignmentHorizontalValues.Center);
                    ws.Range(cell3, cell4).Style.Border.SetInsideBorder(XLBorderStyleValues.Thin);
                    ws.Range(cell3, cell4).Style.Border.SetOutsideBorder(XLBorderStyleValues.Medium);
                    ws.SheetView.FreezeRows(noofsplit);
                    ws.SheetView.FreezeColumns(noofcolfreeze);
                    //}
                    ws.Columns().AdjustToContents();
                    ws.Rows().AdjustToContents();
                    ws.Range(1, 1, 1, dt.Columns.Count).Style.Alignment.WrapText = true;

                    //}
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