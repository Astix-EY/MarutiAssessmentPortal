<%@ WebHandler Language="C#" Class="UserDetailsUpload" %>

using System;
using System.IO;
using System.Web;
using System.Data;
using System.Linq;
using ClosedXML.Excel;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Text.RegularExpressions;
using Newtonsoft.Json;

public class UserDetailsUpload : IHttpHandler, System.Web.SessionState.IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        var postedFile = context.Request.Files[0];
        string FileSetType = "1";// context.Request.Form["FileSetType"].ToString();
        string FileExtType = context.Request.Form["FileExtType"].ToString();
        string Email = context.Request.Form["Email"].ToString();
        string LoginID = context.Request.Form["LoginID"].ToString();
        string EngagementId = context.Request.Form["EngagementId"].ToString();
        string EngagementAssessmentId = context.Request.Form["EngagementAssessmentId"].ToString();
        try
        {
            string msg = UploadFile(postedFile, FileSetType, FileExtType, Email, LoginID, EngagementId, EngagementAssessmentId, context);
            context.Response.Write(msg);
        }
        catch (Exception ex)
        {
            // SendMail(ConfigurationManager.AppSettings["MailTO"].ToString(), "RSPL BD Primary  data File Upload: Error while Uploading File", "Error while Uploading File :<br/>File Type : " + FileSetType + "<br/>File Name : " + Path.GetFileName(postedFile.FileName) + "<br/>Date-Time : " + DateTime.Now.ToString() + "<br/>Error : " + ex.Message, "");
            context.Response.Write("1^Due to some technical reasons, we are unable to process your request. Error : " + ex.Message + " !");
        }
    }


    private string UploadFile(HttpPostedFile File_Up, string FileSetType, string FileExtType, string Email, string LoginID, string EngagementId, string EngagementAssessmentId, HttpContext context)
    {
        string flgstring = "";
        string flgstring_CheckColumnMappingSheet = "";
        string strShowUploadData = "";
        string strShowUploadData1 = "";
        string strShowUploadData2 = "";
        string strShowUploadDataFull = "";
        string UserID = context.Session["UserID"].ToString();

        try
        {
            string FileExt = Path.GetFileName(File_Up.FileName).Split('.')[1].ToUpper();
            if (FileSetType == "3" && FileExt != "XLSX")
                return "1^Please select .xlsx file !";
            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            // SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            DataSet ds = new DataSet();

            Scmd.Connection = Scon;
            Scmd.CommandText = "[spGetFileSetId]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@FileName", Path.GetFileName(File_Up.FileName));
            Scmd.Parameters.AddWithValue("@FileType", FileSetType);
            //Scmd.Parameters.AddWithValue("@loginId", Convert.ToInt32(LoginID));
            Scmd.Parameters.AddWithValue("@LoginId", context.Session["LoginID"].ToString());
            Scmd.Parameters.Add("@FileSetId", SqlDbType.VarChar, 30);
            Scmd.Parameters["@FileSetId"].Direction = ParameterDirection.Output;
            Scon.Open();
            Scmd.ExecuteNonQuery();
            Scon.Close();
            Scmd.Dispose();

            //Save the uploaded file at new location.
            string FileSetID = Scmd.Parameters["@FileSetId"].Value.ToString();
            string filename = Path.GetFileNameWithoutExtension(File_Up.FileName) + "_" + FileSetID + "_" + DateTime.Now.ToString("dd-MM-yyyy-hh-mm-ss") + Path.GetExtension(File_Up.FileName);
            string filePath = HttpContext.Current.Server.MapPath("~/Admin/UserDetailsUpload_Excel/UploadedFiles/") + filename;
            File_Up.SaveAs(filePath);

            DataTable dt = new DataTable();

            //Read the uploaded Excel file.
            using (XLWorkbook workBook = new XLWorkbook(filePath))
            {
                if (workBook.Worksheets.Count > 0)
                {
                    int Excel_SheetCounter = 1;
                    string strUpload = "";
                    foreach (var WorksheetNameNew in workBook.Worksheets)
                    {
                        string workSheetName = WorksheetNameNew.Name;
                        //string workSheetName = workBook.Worksheet(1).Name;
                        IXLWorksheet workSheet = workBook.Worksheet(Excel_SheetCounter);
                        dt = new DataTable();
                        dt = ExcelToDatatable(dt, workSheet, FileSetID, FileSetType, LoginID,UserID);
                        if (dt.Rows.Count > 0)
                        {
                            strUpload = UploadData(dt, workSheetName, FileSetType);
                            dt.Dispose();
                        }
                        else
                        {
                            dt.Dispose();
                            return "1^Error : No data found in " + Path.GetFileName(File_Up.FileName) + " File.";
                            //return "1^" + flgstring + Path.GetFileName(File_Up.FileName) + " File."; ;
                        }
                        Excel_SheetCounter = Excel_SheetCounter + 1;
                    }
                    if (strUpload == "0")
                    {
                        SqlDataAdapter SdapS = new SqlDataAdapter(Scmd);
                        ds.Dispose();
                        ds = new DataSet();
                        Scmd = new SqlCommand();
                        Scmd.Connection = Scon;
                        Scmd.CommandText = "spValidateUploadedUserList";  //"[SpQstBank_TransformEyFormatToSystemFormat]";
                        Scmd.CommandType = CommandType.StoredProcedure;
                        // Scmd.Parameters.AddWithValue("@EngagementAssessmentId", Convert.ToInt32(EngagementAssessmentId));
                        Scmd.Parameters.AddWithValue("@LoginId", Convert.ToInt32(LoginID));
                        Scmd.CommandTimeout = 0;
                        SdapS = new SqlDataAdapter(Scmd);
                        SdapS.Fill(ds);


                        //flgstring = ds.Tables[2].Rows[0][0].ToString(); // If 0 then No issue, If 1 The need to show Table
                        //flgstring_CheckColumnMappingSheet = ds.Tables[3].Rows[0][0].ToString();// If 0 then No issue, If 1 The need to show Table
                        //strShowUploadData1 = DatatabletoStr(ds.Tables[0]);
                        //if (flgstring_CheckColumnMappingSheet != "0")
                        //{
                        //    strShowUploadData2 = DatatabletoStr_Old(ds.Tables[1]);
                        //}

                        flgstring = ds.Tables[1].Rows[0][0].ToString(); // If 0 then No issue, If 1 The need to show Table                                                                       
                        //strShowUploadData1 = DatatabletoStr(ds.Tables[0]);
                        if (flgstring != "0")
                        {
                             strShowUploadData1 = DatatabletoStr(ds.Tables[0]);
                        }




                        strShowUploadDataFull = strShowUploadData2 + strShowUploadData1;
                        Scmd.Dispose();
                        SdapS.Dispose();
                        //  return 0 + "^" + flgstring + "~" + strShowUploadData;
                    }
                    else
                    {
                        return 1 + "^" + 0 + "~" + strUpload;
                    }
                }
                else
                {
                    return "1^No Worksheet found !";
                }

            }
            return 0 + "^" + flgstring + "~" + strShowUploadDataFull;
            //return "0^File Uploaded successfully at " + DateTime.Now.ToString("dd-MMM-yyyy HH:mm:ss") + ".";
        }
        catch (Exception ex)
        {
            //  SendMail(ConfigurationManager.AppSettings["MailTO"].ToString(), "RSPL BD Primary  data File Upload: Error while Uploading File", "Error while Uploading File :<br/>File Type : " + FileSetType + "<br/>File Name : " + Path.GetFileName(File_Up.FileName) + "<br/>Date-Time : " + DateTime.Now.ToString() + "<br/>Error : " + ex.Message, "");
            return "1^Due to some technical reasons, we are unable to process your request. Error : " + ex.Message + " !";
            // return "1^" + flgstring;
        }
    }

    public DataTable CSVToDatatable(HttpPostedFile File_Up, DataTable dt, string FileSetID, string FileSetType)
    {
        try
        {
            int lineNo = 0;
            int ColumnCount = 0;
            using (StreamReader sr = new StreamReader(File_Up.InputStream))
            {
                string[] headers = sr.ReadLine().Split(',');
                ColumnCount = headers.Length;
                for (int i = 0; i < ColumnCount; i++)
                {
                    dt.Columns.Add(headers[i].Trim().Replace("\"", "").Replace("\r", ""));
                }
                dt.Columns.Add("FileSetID", typeof(string));
                dt.Columns.Add("TimeStampIns", typeof(string));

                while (!sr.EndOfStream)
                {
                    lineNo++;
                    string[] CellArr = sr.ReadLine().Split(',');

                    DataRow dr = dt.NewRow();
                    for (int i = 0; i < CellArr.Length; i++)
                    {
                        dr[i] = CellArr[i];
                    }
                    dr[CellArr.Length] = FileSetID;
                    dr[CellArr.Length + 1] = DateTime.Now.ToString();
                    dt.Rows.Add(dr);
                }
            }
        }
        catch (Exception ex)
        {
            SendMail(ConfigurationManager.AppSettings["MailTO"].ToString(), "RSPL BD Primary  data File Upload: Error while Uploading File", "Error while creating DataTable :<br/>File Type : " + FileSetType + "<br/>FileSetID : " + FileSetID + "<br/>Date-Time : " + DateTime.Now.ToString() + "<br/>Error : " + ex.Message, "");
        }
        return dt;
    }



    public DataTable ExcelToDatatable(DataTable dt, IXLWorksheet workSheet, string FileSetID, string FileSetType, string LoginID, string UserID)
    {
        try
        {
            bool firstRow = true;
            string strDateTime = DateTime.Now.ToString();
            var firstCell = workSheet.FirstCellUsed();
            var lastCell = workSheet.LastCellUsed();
            var range = workSheet.Range(firstCell.Address, lastCell.Address);
            var table = range.CreateTable();
            int i = 0, j = 0;
            int count = 0;

            foreach (var row in table.Rows())
            {
                //if (row.Cell(5).Value.ToString() == "")
                //{
                //    continue;
                //}
                i = 0; j = 0;
                if (firstRow)
                {
                    foreach (var cell in row.Cells())
                    {
                        dt.Columns.Add(cell.Value.ToString().Trim());
                        i++;
                        if (i > 21)
                        {
                            break;
                        }
                    }


                    dt.Columns.Add("FileSetIdIns");
                    dt.Columns.Add("TimeStampIns");
                    dt.Columns.Add("LoginId");
                    dt.Columns.Add("UserID");
                    firstRow = false;
                }
                else
                {
                    count = 0;
                    dt.Rows.Add();

                    foreach (var cell in row.Cells())
                    {
                        if (i <= 22)
                        {
                            if ((i == 0 && cell.Value.ToString() != ""))
                            {
                                j++;
                            }
                            dt.Rows[dt.Rows.Count - 1][i] = cell.Value.ToString();
                            i++;
                            count++;
                        }
                        if (i > 22)
                        {
                            break;
                        }
                    }

                    dt.Rows[dt.Rows.Count - 1][i] = FileSetID;
                    dt.Rows[dt.Rows.Count - 1][i + 1] = DateTime.Now.ToString();
                    dt.Rows[dt.Rows.Count - 1][i + 2] = LoginID;
                    dt.Rows[dt.Rows.Count - 1][i + 3] = UserID;
                }
                if (j == 2)
                {
                    dt.Rows.RemoveAt(dt.Rows.Count - 1);
                    break;
                }
            }
        }
        catch (Exception ex)
        {
            SendMail(ConfigurationManager.AppSettings["MailTO"].ToString(), "RSPL BD Primary  data File Upload : Error while Uploading File", "Error while creating DataTable :<br/>File Type : " + FileSetType + "<br/>FileSetID : " + FileSetID + "<br/>Date-Time : " + DateTime.Now.ToString() + "<br/>Error : " + ex.Message, "");
        }
        return dt;
    }




    public string UploadData(DataTable dtRecords, string ws_name, string FileSetType)
    {
        string[] ArrColumnName = new string[0];
        if (ws_name.ToString() == "User List")
        {
            ArrColumnName = new string[15];
            ArrColumnName[0] = "ParticipantFirstName";
            ArrColumnName[1] = "ParticipantLastName";
            ArrColumnName[2] = "ParticipantID(EmpCode)";
            ArrColumnName[3] = "ParticipantEmailAddress";
            ArrColumnName[4] = "WithFunctionalSimulation?(Y/N)";
            ArrColumnName[5] = "Entity";
            ArrColumnName[6] = "Department";
            ArrColumnName[7] = "Role";
            ArrColumnName[8] = "Band";
ArrColumnName[9] = "SetNo";
            ArrColumnName[10] = "Grade";
            ArrColumnName[11] = "FileSetIdIns";
            ArrColumnName[12] = "TimeStampIns";
            ArrColumnName[13] = "LoginId";
            ArrColumnName[14] = "UserID";//  context.Session["LoginID"].ToString()

        }
        else
        {
            ArrColumnName = new string[5];
            ArrColumnName[0] = "ColumnName";
            ArrColumnName[1] = "ActualName";
            ArrColumnName[2] = "FileSetIdIns";
            ArrColumnName[3] = "TimeStampIns";
            ArrColumnName[4] = "LoginId";

        }

        try
        {
            string strcon = ConfigurationManager.AppSettings["strConn"];
            //string strcon = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;

            if (dtRecords.Columns.Count != ArrColumnName.Length)
                // return "1^Column count mis-match. Plz re-verify the File !";
                return "Column count mis-match. Plz re-verify the File !";

            for (int j = 0; j < dtRecords.Columns.Count; j++)
            {
                if (!ArrColumnName.Contains(dtRecords.Columns[j].ColumnName.ToString().Trim()))
                    //  return "1^" + dtRecords.Columns[j].ColumnName.ToString().Trim() + " column is not a valid defined column. Please check..";
                    return dtRecords.Columns[j].ColumnName.ToString().Trim() + " column is not a valid defined column. Please check..";
            }

            using (SqlBulkCopy bulkCopy = new SqlBulkCopy(strcon))
            {
                bulkCopy.BatchSize = 1000;
                bulkCopy.NotifyAfter = 1000;
                if (ws_name.ToString() == "User List")
                {
                    bulkCopy.DestinationTableName = "tbltmpUploadedUserDetails";
                    bulkCopy.ColumnMappings.Add(0, 0);
                    bulkCopy.ColumnMappings.Add(1, 1);
                    bulkCopy.ColumnMappings.Add(2, 2);
                    bulkCopy.ColumnMappings.Add(3, 3);
                    bulkCopy.ColumnMappings.Add(4, 4);
                    bulkCopy.ColumnMappings.Add(5, 5);
                    bulkCopy.ColumnMappings.Add(6, 6);
                    bulkCopy.ColumnMappings.Add(7, 7);
                    bulkCopy.ColumnMappings.Add(8, 8);
                    bulkCopy.ColumnMappings.Add(9, 9);
                    bulkCopy.ColumnMappings.Add(10, 10);
                    bulkCopy.ColumnMappings.Add(11, 11);
                    bulkCopy.ColumnMappings.Add(12, 12);
                    bulkCopy.ColumnMappings.Add(13, 13);
bulkCopy.ColumnMappings.Add(14, 14);

                }
                else if (ws_name.ToString() == "Column Mapping")
                {
                    bulkCopy.DestinationTableName = "tbltmpColumnMappingForUploadedUserDetails";
                    bulkCopy.ColumnMappings.Add(0, 0);
                    bulkCopy.ColumnMappings.Add(1, 1);
                    bulkCopy.ColumnMappings.Add(2, 2);
                    bulkCopy.ColumnMappings.Add(3, 3);
                    bulkCopy.ColumnMappings.Add(4, 4);

                }

                System.Data.SqlClient.SqlBulkCopyColumnMappingCollection sbcmc = bulkCopy.ColumnMappings;
                bulkCopy.WriteToServer(dtRecords);


            }
            return "0";
        }
        catch (Exception ex)
        {
            //  SendMail(ConfigurationManager.AppSettings["MailTO"].ToString(), "RSPL BD Primary  data File Upload : Error while Uploading File", "Error while Uploading File :<br/>File Type : " + FileSetType + "<br/>FileSetID : " + dtRecords.Rows[0]["FileSetID"].ToString() + "<br/>Date-Time : " + DateTime.Now.ToString() + "<br/>Error : " + ex.Message, "");
            return "1^Due to some technical reasons, we are unable to process your request. Error : " + ex.Message + " !";
        }
    }


    public static string DatatabletoStr(DataTable dt)
    {
        StringBuilder sbErrorCss = new StringBuilder();

        StringBuilder sb = new StringBuilder();
        sb.Append("<table class='table table-striped table-bordered table-sm'>");
        sb.Append("<thead>");
        sb.Append("<tr>");
        for (int j = 0; j < dt.Columns.Count; j++)
        {
            //  sb.Append("<th>" + dt.Columns[j].ColumnName.ToString() + "</th>");
            if (j == 0)
            {
                sbErrorCss.Append("background-color:#f2db9b; font-weight:bold");
                sb.Append("<th style='text-align:left; " + sbErrorCss.ToString() + "'>" + dt.Columns[j].ColumnName.ToString() + "</th>");
            }
            else
            {

                sb.Append("<th>" + dt.Columns[j].ColumnName.ToString() + "</th>");
            }
        }
        sb.Append("</tr>");
        sb.Append("</thead>");
        sb.Append("<tbody>");

        DataTable dtQuestion = dt.DefaultView.ToTable(true, "Remarks", "Participant First Name", "Participant Last Name", "Participant ID", "Participant Email Address", "With Functional Simulation? (Y/N)", "Entity", "Department", "Role","Band","Grade");


        for (int i = 0; i < dtQuestion.Rows.Count; i++)
        {
            sb.Append("<tr>");
            for (int j = 0; j < dtQuestion.Columns.Count; j++)
            {
                sbErrorCss.Clear();
                if (HttpUtility.HtmlEncode(dtQuestion.Rows[i][j].ToString()).Split('~').Length > 1)
                    sbErrorCss.Append("background-color:#f2db9b; font-weight:bold");

                //if (dtQuestion.Columns[j].ColumnName.ToString() == "Question_Id" || (dtQuestion.Columns[j].ColumnName.ToString() == "Option_Seq_No") || (dtQuestion.Columns[j].ColumnName.ToString() == "Is_Correct_Option") || (dtQuestion.Columns[j].ColumnName.ToString() == "Option_Id"))
                //{
                //    continue;
                //}
                //else
                if (dtQuestion.Columns[j].ColumnName.ToString() == "Participant First Name")
                {
                    sb.Append("<td style='text-align:left; " + sbErrorCss.ToString() + "'>" + HttpUtility.HtmlEncode(dtQuestion.Rows[i][j].ToString()).Split('~')[0] + "</td>");
                }
                else if (dtQuestion.Columns[j].ColumnName.ToString() == "Participant Last Name")
                {
                    sb.Append("<td style='text-align:left; " + sbErrorCss.ToString() + "'>" + HttpUtility.HtmlEncode(dtQuestion.Rows[i][j].ToString()).Split('~')[0] + "</td>");
                }
                else if (dtQuestion.Columns[j].ColumnName.ToString() == "Participant ID")
                {
                    sb.Append("<td style='text-align:left; " + sbErrorCss.ToString() + "'>" + HttpUtility.HtmlEncode(dtQuestion.Rows[i][j].ToString()).Split('~')[0] + "</td>");
                }
                else if (dtQuestion.Columns[j].ColumnName.ToString() == "Participant Email Address")
                {
                    sb.Append("<td style='text-align:left; " + sbErrorCss.ToString() + "'>" + HttpUtility.HtmlEncode(dtQuestion.Rows[i][j].ToString()).Split('~')[0] + "</td>");
                }
                else if (dtQuestion.Columns[j].ColumnName.ToString() == "With Functional Simulation? (Y/N)")
                {
                    sb.Append("<td style='text-align:left; " + sbErrorCss.ToString() + "'>" + HttpUtility.HtmlEncode(dtQuestion.Rows[i][j].ToString()).Split('~')[0] + "</td>");
                }
                //else if (dtQuestion.Columns[j].ColumnName.ToString() == "Option_Text")
                //{
                //    DataRow[] drowsOptions = dtQuestion.Select("Question_Text='" + HttpUtility.HtmlEncode(dtQuestion.Rows[i]["Question_Text"].ToString()) + "'");
                //    sb.Append("<td style='text-align:left; " + sbErrorCss.ToString() + "'>" + (drowsOptions.Length > 0 ? createRowMergeTbl(drowsOptions.CopyToDataTable(), dtQuestion.Rows[i]["Question_Id"].ToString()) : "") + "</td>");
                //}
                else
                {
                    sb.Append("<td style='text-align:left; " + sbErrorCss.ToString() + "'>" + HttpUtility.HtmlEncode(dtQuestion.Rows[i][j].ToString()).Split('~')[0] + "</td>");
                }
            }
            sb.Append("</tr>");
        }
        //END for Row merger code ROW As it is.

        sb.Append("</tbody>");
        sb.Append("</table>");
        return sb.ToString();
    }


    private static string createRowMergeTbl(DataTable dtOptions, string QstnId)
    {
        string value = "";
        StringBuilder sb = new StringBuilder();
        StringBuilder sb_disabled = new StringBuilder();
        sb.Append("<table id='tblOptions_" + QstnId + "' class='table table-borderless mb-0 clsTableOptions'>");

        for (int i = 0; i < dtOptions.Rows.Count; i++)
        {
            string qstnid = QstnId;// dtOptions.Rows[i]["RspExcerciseQstnID"].ToString();
            string CorrectOpt = dtOptions.Rows[i]["Is_Correct_Option"].ToString();
            string bgcls = "";
            if (CorrectOpt == "1")
            {
                bgcls = "style='color:#28a745;font-weight:bold' title='correct answer'";
            }
            value = dtOptions.Rows[i]["Option_Text"].ToString();
            value = value.Replace("^", "");
            sb.Append("<tr " + bgcls + " qstnid='" + qstnid + "' QstnOptionId='" + dtOptions.Rows[i]["Option_Id"].ToString() + "'  CorrectOption='" + dtOptions.Rows[i]["Is_Correct_Option"].ToString() + "' >");
            sb.Append("<td class='cls-0' style='width:3%'>" + (i + 1) + ". </td>");
            // sb.Append("<td class='cls-0' style='text-align:left'>" + value + "</td>");
            sb.Append("<td class='cls-0' style='text-align:left'>" + HttpUtility.HtmlEncode(dtOptions.Rows[i]["Option_Text"].ToString()) + "</td>");
            // sb.Append("<td class='cls-0' style='text-align:left'>Ram</td>");
            sb.Append("</tr>");
        }
        sb.Append("</tbody>");
        sb.Append("</table>");
        return sb.ToString();
    }



    public static string DatatabletoStr_Old(DataTable dt)
    {
        StringBuilder sbErrorCss = new StringBuilder();
        StringBuilder sb = new StringBuilder();
        sb.Append("<table class='table table-striped table-bordered table-sm'>");
        sb.Append("<thead>");
        sb.Append("<tr>");
        for (int j = 0; j < dt.Columns.Count; j++)
        {
            //  sb.Append("<th>" + dt.Columns[j].ColumnName.ToString() + "</th>");
            if (j == 0)
            {
                sbErrorCss.Append("background-color:#f2db9b; font-weight:bold");
                sb.Append("<th style='text-align:left; " + sbErrorCss.ToString() + "'>" + dt.Columns[j].ColumnName.ToString() + "</th>");
            }
            else
            {

                sb.Append("<th>" + dt.Columns[j].ColumnName.ToString() + "</th>");
            }
        }
        sb.Append("</tr>");
        sb.Append("</thead>");
        sb.Append("<tbody>");



        //Start for Bind All ROW As it is.
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sb.Append("<tr>");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                sb.Append("<td>" + dt.Rows[i][j] + "</td>");
            }
            sb.Append("</tr>");
        }
        //  End for Bind All ROW As it is.









        sb.Append("</tbody>");
        sb.Append("</table>");
        return sb.ToString();
    }


    private static string createRowMergeTbl_OLD(DataTable dtOptions, string QstnId)
    {
        StringBuilder sb = new StringBuilder();
        StringBuilder sb_disabled = new StringBuilder();
        sb.Append("<table id='tblOptions_" + QstnId + "' class='table table-borderless mb-0 clsTableOptions'>");

        for (int i = 0; i < dtOptions.Rows.Count; i++)
        {
            string qstnid = QstnId;// dtOptions.Rows[i]["RspExcerciseQstnID"].ToString();
            string CorrectOpt = dtOptions.Rows[i]["Is_Correct_Option"].ToString();
            string bgcls = "";
            if (CorrectOpt == "1")
            {
                bgcls = "style='color:#28a745;font-weight:bold' title='correct answer'";
            }
            sb.Append("<tr " + bgcls + " qstnid='" + qstnid + "' QstnOptionId='" + dtOptions.Rows[i]["Option_Id"].ToString() + "'  CorrectOption='" + dtOptions.Rows[i]["Is_Correct_Option"].ToString() + "' >");
            sb.Append("<td class='cls-0' style='width:3%'>" + (i + 1) + ". </td>");
            sb.Append("<td class='cls-0' style='text-align:left'>" + dtOptions.Rows[i]["Option_Text"].ToString() + "</td>");
            sb.Append("</tr>");
        }
        sb.Append("</tbody>");
        sb.Append("</table>");
        return sb.ToString();
    }

    public static string CreateErrorRpt(DataSet DsError)
    {
        string[] ArrColor = new string[14];
        ArrColor[0] = "#ee88a4";
        ArrColor[1] = "#55c2ff";
        ArrColor[2] = "#a1b49b";
        ArrColor[3] = "#00ff7f";
        ArrColor[4] = "#bdac73";
        ArrColor[5] = "#f5d45e";
        ArrColor[6] = "#ce05f0";
        ArrColor[7] = "#c0d6e4";
        ArrColor[8] = "#f08080";
        ArrColor[9] = "#ffc3a0";
        ArrColor[10] = "#6897bb";
        ArrColor[11] = "#81d8d0";
        ArrColor[12] = "#e18a7a";
        ArrColor[13] = "#967b59";

        DataTable dt = DsError.Tables[0];
        DataTable dtError = DsError.Tables[1];
        StringBuilder sb = new StringBuilder();
        sb.Append("<table class='clsErrorList'>");
        sb.Append("<tbody>");
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            sb.Append("<tr>");
            sb.Append("<td><div class='clsColor-block' style='background:" + ArrColor[Convert.ToInt32(dt.Rows[i]["ErrorId"]) - 1] + "'></div></td><td>" + dt.Rows[i]["ErrorDescr"] + "</td>");
            sb.Append("</tr>");
        }
        sb.Append("</tbody>");
        sb.Append("</table>");

        sb.Append("<div id='divErrortbl' style='overflow-y: auto;'>");
        sb.Append("<table class='clsErrortbl table table-striped table-bordered table-sm'>");
        sb.Append("<thead>");
        sb.Append("<tr>");
        for (int j = 0; j < dtError.Columns.Count; j++)
        {
            sb.Append("<th>" + dtError.Columns[j].ColumnName.ToString() + "</th>");
        }
        sb.Append("</tr>");
        sb.Append("</thead>");
        sb.Append("<tbody>");
        for (int i = 0; i < dtError.Rows.Count; i++)
        {
            sb.Append("<tr>");
            for (int j = 0; j < dtError.Columns.Count; j++)
            {
                if (dtError.Rows[i][j].ToString().Split('^').Length > 1)
                {
                    sb.Append("<td style='background:" + ArrColor[Convert.ToInt32(dtError.Rows[i][j].ToString().Split('^')[1]) - 1] + "'>" + dtError.Rows[i][j].ToString().Split('^')[0] + "</td>");
                }
                else
                {
                    sb.Append("<td>" + dtError.Rows[i][j] + "</td>");
                }
            }
            sb.Append("</tr>");
        }
        sb.Append("</tbody>");
        sb.Append("</table>");
        sb.Append("</div>");
        return sb.ToString();
    }

    public static void SendMail(string ToMail, string sub, string msg, string AttachFile)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(ConfigurationManager.AppSettings["MailFrom"].ToString());
            if (ConfigurationManager.AppSettings["isTesting"].ToString() == "1")
            {
                mail.To.Add(ConfigurationManager.AppSettings["MailTO"].ToString());

            }
            else
            {
                if (ToMail != "")
                    mail.To.Add(ToMail);
            }
            mail.Subject = sub;
            mail.Body = msg;
            mail.IsBodyHtml = true;
            if (AttachFile != "")
                mail.Attachments.Add(new Attachment(AttachFile));

            SmtpClient SmtpServer = new SmtpClient(ConfigurationManager.AppSettings["MailSMTPServer"].ToString());
            SmtpServer.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["MailUsername"].ToString(), ConfigurationManager.AppSettings["MailPassword"].ToString());
            SmtpServer.Port = 25;
            SmtpServer.EnableSsl = false;
            SmtpServer.Send(mail);
        }
        catch (Exception ex)
        {
            //
        }
    }

    static bool validatefiledate(string date)
    {
        bool isValid = false;
        try
        {

            Regex regex = new Regex(@"^\d{4}((0\d)|(1[012]))(([012]\d)|3[01])$");///([12]\d{3}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01]))/
            isValid = regex.IsMatch(date.Trim());
        }
        catch (Exception ex)
        {
            isValid = false;
        }

        return isValid;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}