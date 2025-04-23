using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class CommonData_Questionnaire_frmQusetionnaire : System.Web.UI.Page
{
    static string strConn = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)

    {

        if (Session["LoginId"] == null)
        {
            Response.Write("<script>parent.frames.location.href='../Common/frmSessionExpire.aspx'</script>");
            return;
        }
        
        
        hdnToolID.Value = ((Request.QueryString["ToolID"] == null) ? "0" : Request.QueryString["ToolID"]);
        hdnLanguageId.Value = ((Session["SelectedLngID"] == null) ? "6" : Session["SelectedLngID"].ToString());
        int BandID = 1;// ((Request.QueryString["BandID"] == null) ? 0 : Convert.ToInt32(Request.QueryString["BandID"]));
        int ExerciseType = ((Request.QueryString["ExerciseType"] == null) ? 0 : Convert.ToInt32(Request.QueryString["ExerciseType"]));
        hdnRspID.Value = ((Request.QueryString["RspID"] == null) ? "0" : Request.QueryString["RspID"]);
        hdnLoginID.Value = ((Request.QueryString["intLoginID"] == null) ? "0" : Request.QueryString["intLoginID"]);
        hdnExerciseID.Value = ((Request.QueryString["ExerciseID"] == null) ? "0" : Request.QueryString["ExerciseID"]);

        SqlConnection objCon = new SqlConnection(strConn);
        SqlCommand objcom = new SqlCommand("spRspExerciseManage", objCon);
        objcom.Parameters.AddWithValue("@RspID", Convert.ToInt32(hdnRspID.Value));
        objcom.Parameters.AddWithValue("@ExerciseID", Convert.ToInt32(hdnExerciseID.Value));
        objcom.Parameters.AddWithValue("@LoginId", Convert.ToInt32(hdnLoginID.Value));
        objcom.Parameters.AddWithValue("@BandID", BandID);//1
        objcom.CommandTimeout = 0;
        objcom.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr;
        objCon.Open();
        dr = objcom.ExecuteReader();
        if (dr.HasRows)
        {
            dr.Read();
            ExerciseName.InnerHtml = dr["ExerciseName"].ToString();
            hdnRSPExerciseID.Value = dr["RSPExerciseID"].ToString();
            int PrepStatus = Convert.ToInt32(dr["PrepStatus"]);
            int MeetingStatus = Convert.ToInt32(dr["MeetingStatus"]);
            hdnPrepStatus.Value = PrepStatus.ToString();
            hdnMeetingStatus.Value = MeetingStatus.ToString();
            int MeetingRemainingTime = Convert.ToInt32(dr["MeetingRemainingTime"]);
            hdnCounterRunTime.Value = MeetingRemainingTime.ToString();
            hdnMeetingDefaultTime.Value = dr["MeetingDefaultTime"].ToString();
            if (MeetingStatus == 2)
            {
                hdnCounterRunTime.Value = "0";
            }
            else {
                hdnCounterRunTime.Value = MeetingRemainingTime < 0 ? "0" : MeetingRemainingTime.ToString();
            }

            int PrepRemainingTime = Convert.ToInt32(dr["PrepRemainingTime"]);
            if (PrepStatus == 2)
            {
                hdnCounter.Value = "0";
            }
            else {
                hdnCounter.Value = PrepRemainingTime < 0 ? "0" : PrepRemainingTime.ToString();
                fnUpdateActualStartEndTime(Convert.ToInt32(hdnRSPExerciseID.Value), 1, 1);
            }
            hdnTotQstn.Value = dr["TotQstn"].ToString();
            hdnExerciseStatus.Value = dr["flgExerciseStatus"].ToString();
            hdnPageNmbr.Value = dr["PGNmbr"].ToString() == "0" ? "1" : dr["PGNmbr"].ToString();
            if (hdnExerciseStatus.Value == "2")
            {
                hdnPageNmbr.Value = "1";
            }
            divMainContainer.InnerHtml = fnGetQuestionDetails(Convert.ToInt32(hdnPageNmbr.Value), Convert.ToInt32(hdnExerciseID.Value), Convert.ToInt32(hdnRSPExerciseID.Value), Convert.ToInt32(hdnTotQstn.Value), Convert.ToInt32(hdnLanguageId.Value));

        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnUpdateUserExerciseResponses(int RSPExerciseID, int RspDetId, string strResult, int Status, int PGNmbr, int flgTimeOver, int LoginId, int Direction)
    {
        string strReturn = 1.ToString();
        // Sub spRspBusinessCaseUPDAnswers(ByVal RspExerciseID As Integer, ByVal LoginId As Integer, ByVal selValues As String, ByVal statusValue As Integer)
        var Objcon2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["strConn"]);
        var objCom2 = new SqlCommand("[spUpdateUserExerciseResponses]", Objcon2);
        objCom2.Parameters.Add("@RspExcersiseID", SqlDbType.Int).Value = RSPExerciseID;
        objCom2.Parameters.Add("@RspDetId", SqlDbType.NVarChar).Value = RspDetId;
        objCom2.Parameters.Add("@RespStr", SqlDbType.NVarChar).Value = strResult;
        objCom2.Parameters.Add("@LoginID", SqlDbType.Int).Value = LoginId;
        objCom2.Parameters.Add("@Status", SqlDbType.Int).Value = Status;
        objCom2.Parameters.Add("@PGNmbr", SqlDbType.Int).Value = PGNmbr;
        objCom2.Parameters.Add("@flgTimeOver", SqlDbType.Int).Value = flgTimeOver;
        objCom2.CommandType = CommandType.StoredProcedure;
        objCom2.CommandTimeout = 0;
        try
        {
            Objcon2.Open();
            objCom2.ExecuteNonQuery();
            if (Status == 2 && Direction == 2)
            {
                fnUpdateActualStartEndTime(RSPExerciseID, 1, 2);
            }
            strReturn = "1^";
        }
        catch (Exception ex)
        {
            strReturn = "2^" + ex.Message;
        }
        finally
        {
            objCom2.Dispose();
            Objcon2.Close();
            Objcon2.Dispose();
        }

        return strReturn;
    }

    [System.Web.Services.WebMethod()]
    public static string fnUpdateActualStartEndTime(int RSPExerciseid, int UserTypeID, int flgAction)
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
            return "0|";
        }
        catch (Exception ex)
        {
            return "1|" + ex.Message;
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnGetQuestionDetails(int PageNo, int ExerciseID, int RspExerciseID, int TotQstn, int SelectedLanguageId)
    {
        SqlConnection objCon = new SqlConnection(strConn);
        SqlCommand objcom = new SqlCommand("spRspGetQstns", objCon);
        objcom.Parameters.AddWithValue("@RspExerciseID", RspExerciseID);
        objcom.Parameters.AddWithValue("@ExcersiseID", ExerciseID);
        objcom.Parameters.AddWithValue("@PgNmbr", PageNo);
        objcom.Parameters.AddWithValue("@LanguageId", SelectedLanguageId);
        objcom.CommandTimeout = 0;
        objcom.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter da = new SqlDataAdapter(objcom);
        DataSet ds = new DataSet();
        da.Fill(ds);
        StringBuilder strHTML = new StringBuilder();
        string RspDetID = "0";
        string RspExcerciseQstnID = "0";
        string QstnTypeID = "0";
        int IsSequencing = 0;
        string flgAllOptionCompulsory = "0";
        if (ds.Tables[0].Rows.Count > 0)
        {
            flgAllOptionCompulsory = Convert.ToString(ds.Tables[0].Rows[0]["flgAllOptionCompulsory"]);
            //flgAllOptionCompulsory
            strHTML.Append("<div class='alert alert-info' style='position:absolute;margin-top:-41px;padding:.30rem 1.25rem;'>Page No :  " + ds.Tables[0].Rows[0]["Qstno"] + " / " + TotQstn + "</div>");
            RspDetID = Convert.ToString(ds.Tables[0].Rows[0]["RspDetID"]);
            RspDetID = RspDetID == "" ? "0" : RspDetID;
            QstnTypeID = ds.Tables[0].Rows[0]["TypeId"].ToString();
            RspExcerciseQstnID = ds.Tables[0].Rows[0]["RspExcerciseQstnID"].ToString();
            //strHTML.Append("<p iden='qstnHeader' style='font-weight: bold;font-size:13pt;color:black'>" + Convert.ToString(ds.Tables[0].Rows[0]["QstnHdr"]) + "</p>");
            strHTML.Append("<p style='font-size:12pt; font-weight:bold;' iden='qstn' flgAllOptionCompulsory='" + flgAllOptionCompulsory + "' RspDetID='" + RspDetID + "'  QstnTypeID='" + QstnTypeID + "' RspExcerciseQstnID='" + RspExcerciseQstnID + "'><b style='font-size:12.5pt'>Q" + ds.Tables[0].Rows[0]["Qstno"].ToString() + ": </b>" + ds.Tables[0].Rows[0]["Qstn"].ToString() + "</p>");
            IsSequencing = Convert.ToInt32(ds.Tables[0].Rows[0]["IsOrdrSequence"]);
        }
        else
        {
            return "No Data Found!";
        }

        string strInstructions = "";

        if (Convert.ToInt32(QstnTypeID) != 7 && Convert.ToInt32(QstnTypeID) != 8 && Convert.ToInt32(QstnTypeID) != 9 && Convert.ToInt32(QstnTypeID) != 10)
        {
            strHTML.Append("<div class='col-md-11 col-md-offset-1'>");
            strHTML.Append("<div class='qusgroup_option'>");
            strHTML.Append(fnGetSubStatement(ds, Convert.ToInt32(ds.Tables[0].Rows[0]["RspExcerciseQstnID"]), Convert.ToString(ds.Tables[0].Rows[0]["Answrval"]).Split('~')[0], Convert.ToInt32(RspDetID), Convert.ToInt32(QstnTypeID), Convert.ToInt32(ds.Tables[0].Rows[0]["MaxQstnSelected"])));
            strHTML.Append("</div>");

 if (ds.Tables[0].Rows[0]["flgShowAdditionalTextBox"].ToString() == "1")
            {
                strHTML.Append("<table style='width:100%'>");
                strHTML.Append("<tr>");
                strHTML.Append("<td style='width:20px;padding-right:10px;vertical-align:top;font-size:12pt;font-weight:bold'>");
                strHTML.Append("Please share your reasons for your chosen option.");
                strHTML.Append("</td>");
                strHTML.Append("</tr>");
                strHTML.Append("<tr>");
                strHTML.Append("<td>");
                if (Convert.ToString(ds.Tables[0].Rows[0]["Answrval"]) != "")
                {
                    if (Convert.ToString(ds.Tables[0].Rows[0]["Answrval"]) == "-1^")
                    {
                        strHTML.Append("<textarea qstId='" + ds.Tables[0].Rows[0]["RspExcerciseQstnID"].ToString() + "'  id='txtAdditional_" + ds.Tables[0].Rows[0]["RspExcerciseQstnID"].ToString() + "'   cols='200'  rows='8'   class='form-control' style='width:100%; height:180px'></textarea>");
                    }
                    else
                    {
                        //strHTML.Append("<textarea  id='txtAdditional_" + ds.Tables[0].Rows[0]["RspExcerciseQstnID"].ToString() + "'   cols='200'  rows='8'   class='form-control' style='width:100%; height:180px'></textarea>");
                        strHTML.Append("<textarea qstId='" + ds.Tables[0].Rows[0]["RspExcerciseQstnID"].ToString() + "' id='txtAdditional_" + ds.Tables[0].Rows[0]["RspExcerciseQstnID"].ToString() + "' cols='200'  rows='8'   class='form-control' style='width:100%; height:180px'>" + (Convert.ToString(ds.Tables[0].Rows[0]["Answrval"]).Split('~').Length>1? Convert.ToString(ds.Tables[0].Rows[0]["Answrval"]).Split('~')[1]:"") + "</textarea>");
                    }
                }

                else
                {
                    strHTML.Append("<textarea  qstId='" + ds.Tables[0].Rows[0]["RspExcerciseQstnID"].ToString() + "' id='txtAdditional_" + ds.Tables[0].Rows[0]["RspExcerciseQstnID"].ToString() + "'   cols='200'  rows='8'   class='form-control' style='width:100%; height:180px'></textarea>");
                }
                strHTML.Append("</td>");
                strHTML.Append("</tr>");
                strHTML.Append("</table>");
            }
            strHTML.Append("</div>");
        }
        else
        {

            string Answrval = Convert.ToString(ds.Tables[0].Rows[0]["Answrval"]);
            string AnsDrag = "";
            if (Convert.ToInt32(QstnTypeID) != 10)
            {
                if (Answrval != "")
                {
                    for (int s = 0; s < Answrval.Split('|').Length - 1; s++)
                    {
                        if (AnsDrag == "")
                        {
                            AnsDrag = Answrval.Split('|')[s].Split('^')[1];
                        }
                        else
                        {
                            AnsDrag += "," + Answrval.Split('|')[s].Split('^')[1];
                        }
                    }
                }
            }
            if (Convert.ToInt32(QstnTypeID) == 9)
            {
                strHTML.Append("<div>");
                int cntactive = 0;
                foreach (DataRow drow1 in ds.Tables[2].Rows)
                {
                    int BucketNo = Convert.ToInt32(drow1["BucketNo"]);
                    if (Answrval != "")
                    {
                        string arrAnswrval = Answrval.Split('|')[0];
                        if (BucketNo - 1 == Convert.ToInt32(arrAnswrval.Split('^')[0]))
                        {
                            strHTML.Append("<button type='button' onclick='fnFillBucketLbl(this)' class='btn btn-warning m-2 active' id='btnBucketNo_" + Convert.ToString(drow1["BucketNo"]) + "'  >" + drow1["BucketDescrLvl1"].ToString() + "</button>");
                        }
                        else
                        {
                            strHTML.Append("<button type='button' onclick='fnFillBucketLbl(this)' class='btn btn-warning m-2' id='btnBucketNo_" + Convert.ToString(drow1["BucketNo"]) + "'  >" + drow1["BucketDescrLvl1"].ToString() + "</button>");
                        }
                    }
                    else {
                        if (cntactive == 0)
                        {
                            strHTML.Append("<button type='button' onclick='fnFillBucketLbl(this)' class='btn btn-warning m-2 active' id='btnBucketNo_" + Convert.ToString(drow1["BucketNo"]) + "'  >" + drow1["BucketDescrLvl1"].ToString() + "</button>");
                        }
                        else
                        {
                            strHTML.Append("<button type='button' onclick='fnFillBucketLbl(this)' class='btn btn-warning m-2' id='btnBucketNo_" + Convert.ToString(drow1["BucketNo"]) + "'  >" + drow1["BucketDescrLvl1"].ToString() + "</button>");
                        }
                    }
                    cntactive++;
                }
                strHTML.Append("</div>");
            }
            if (Convert.ToInt32(QstnTypeID) == 7 || Convert.ToInt32(QstnTypeID) == 9)
            {
                strHTML.Append("<div class=\"clsOptionContainer clearfix mb-2\" id='dvDrag_" + RspExcerciseQstnID + "'>");
            }
            else if (Convert.ToInt32(QstnTypeID) == 10)
            {

            }
            else
            {
                strHTML.Append("<div class=\"d-block clsOptionContainerLeftHeader clearfix mb-2\">");
                strHTML.Append("<div class=\"box-header\">Options</div>");
                strHTML.Append("<div class=\"clsOptionContainerLeft\" id='dvDrag_" + RspExcerciseQstnID + "'>");
            }
            if (Convert.ToInt32(QstnTypeID) == 10)
            {
                StringBuilder sb1 = new StringBuilder();
                StringBuilder sb2 = new StringBuilder();
                int inx = 0;
                string strSolutions = ""; string strOutCome = "";
                if (Answrval != "")
                {
                    for (int s = 0; s < Answrval.Split('|').Length - 1; s++)
                    {
                        if (strSolutions == "")
                        {
                            strSolutions = Answrval.Split('|')[s].Split('-')[1];
                        }
                        else
                        {
                            strSolutions += "," + Answrval.Split('|')[s].Split('-')[1];
                        }
                        if (strOutCome == "")
                        {
                            strOutCome = Answrval.Split('|')[s].Split('-')[2];
                        }
                        else
                        {
                            strOutCome += "," + Answrval.Split('|')[s].Split('-')[2];
                        }
                    }
                }
                foreach (DataRow drow1 in ds.Tables[1].Rows)
                {

                    string RspExerciseQstnOptionId = Convert.ToString(drow1["RspExerciseQstnOptionId"]);
                    if (strSolutions.IndexOf(RspExerciseQstnOptionId) == -1)
                    {
                        sb1.Append("<div IsSequencing='" + IsSequencing.ToString() + "' QstnTypeID='" + QstnTypeID + "' class=\"clsdivdraggableSolution\" id=" + Convert.ToString(drow1["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(drow1["RspExerciseQstnId"]) + "_" + Convert.ToString(drow1["SeqNo"]) + " ><span class='ques-panel-no'>" + Convert.ToString(drow1["SeqNo"]) + "</span>" + drow1["OptionDescr"].ToString() + "</div>");
                    }
                    if (strOutCome.IndexOf(RspExerciseQstnOptionId) == -1)
                    {
                        if (Convert.ToString(drow1["OptionDescr2"]) != "")
                        {
                            sb2.Append("<div IsSequencing='" + IsSequencing.ToString() + "' QstnTypeID='" + QstnTypeID + "' class=\"clsdivdraggableOutcome\" id=" + Convert.ToString(drow1["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(drow1["RspExerciseQstnId"]) + "_" + Convert.ToString(drow1["SeqNo"]) + " ><span class='ques-panel-no'>" + Convert.ToString(drow1["SeqNo"]) + "</span>" + drow1["OptionDescr2"].ToString() + "</div>");
                        }
                    }

                }
                strHTML.Append("<div style='width:49%;float:left'><div style='background-color:#01a3ae;color:#ffffff;text-align:center;margin:0px 20%;font-size:12pt'>Solution</div><div class=\"clsOptionContainerSolution clearfix mb-2\" id='dvDrag1_" + RspExcerciseQstnID + "' style='min-height:140px'>" + sb1.ToString() + "</div></div>");
                strHTML.Append("<div style='width:49%;float:right'><div style='background-color:#01a3ae;color:#ffffff;text-align:center;margin:0px 20%;font-size:12pt'>Outcome</div><div class=\"clsOptionContainerOutcome clearfix mb-2\" id='dvDrag2_" + RspExcerciseQstnID + "' style='min-height:140px'>" + sb2.ToString() + "</div></div>");
            }
            else {
                foreach (DataRow drow1 in ds.Tables[1].Rows)
                {
                    string RspExerciseQstnOptionId = Convert.ToString(drow1["RspExerciseQstnOptionId"]);
                    if (AnsDrag.IndexOf(RspExerciseQstnOptionId) == -1)
                    {
                        strHTML.Append("<div IsSequencing='" + IsSequencing.ToString() + "' QstnTypeID='" + QstnTypeID + "' class=\"clsdivdraggable \" id=" + Convert.ToString(drow1["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(drow1["RspExerciseQstnId"]) + "_" + Convert.ToString(drow1["SeqNo"]) + " ><span class='ques-panel-no'>" + Convert.ToString(drow1["SeqNo"]) + "</span>" + drow1["OptionDescr"].ToString() + "</div>");
                    }
                }
                strHTML.Append("</div>");
            }

            if (Convert.ToInt32(QstnTypeID) != 7 && Convert.ToInt32(QstnTypeID) != 9 && Convert.ToInt32(QstnTypeID) != 10)
            {
                strHTML.Append("</div>");
            }
            if (Convert.ToInt32(QstnTypeID) == 7 || Convert.ToInt32(QstnTypeID) == 9)
            {
                strHTML.Append("<div class='text-center'><h1 class=\"small-heading\">Solution</h1></div>");
            }

            strHTML.Append("<div class=\"d-block clearfix mb-2\" id='dvDrop_" + RspExcerciseQstnID + "'>");

            int BucketNoSeq = 0;
            int swidth = 0;
            if (ds.Tables[2].Rows.Count == 3 || ds.Tables[2].Rows.Count == 6)
            {
                swidth = 0;
            }
            else if (ds.Tables[2].Rows.Count == 2 || ds.Tables[2].Rows.Count == 4)
            {
                swidth = 50;
            }
            else if (ds.Tables[2].Rows.Count == 1)
            {
                swidth = 100;
            }
            swidth = Convert.ToInt32(QstnTypeID) == 9 ? 100 : swidth;
            swidth = Convert.ToInt32(QstnTypeID) == 8 ? 0 : swidth;

            int ImgExist = 0;
            foreach (DataRow drow1 in ds.Tables[2].Rows)
            {
                int BucketNo = Convert.ToInt32(drow1["BucketNo"]);
                string BucketDescrLvl1 = drow1["BucketDescrLvl1"].ToString();
                StringBuilder strOption = new StringBuilder();
                if (Convert.ToInt32(QstnTypeID) != 10)
                {
                    if (Answrval != "")
                    {

                        string arrAnswrval = Answrval.Split('|')[BucketNoSeq];
                        if (Convert.ToInt32(QstnTypeID) == 9)
                        {
                            if (BucketNo - 1 != Convert.ToInt32(arrAnswrval.Split('^')[0]))
                            {
                                continue;
                            }
                        }
                        if (arrAnswrval.Split('^')[1] != "")
                        {
                            for (int o = 0; o < arrAnswrval.Split('^')[1].Split(',').Length; o++)
                            {
                                DataRow[] drowsOptions = ds.Tables[1].Select("RspExerciseQstnOptionId in (" + arrAnswrval.Split('^')[1].Split(',')[o] + ")");
                                foreach (DataRow doption in drowsOptions)
                                {
                                    string OptionDescr = doption["OptionDescr"].ToString();
                                    if (Convert.ToInt32(QstnTypeID) == 7)
                                    {
                                        OptionDescr = OptionDescr.Length > 55 ? OptionDescr.Substring(0, 54) + "..." : OptionDescr;
                                        strOption.Append("<div title='" + HttpUtility.HtmlEncode(doption["OptionDescr"].ToString()) + "' IsSequencing='" + IsSequencing.ToString() + "' QstnTypeID='" + QstnTypeID + "' class=\"clsdivdraggable\" id=" + Convert.ToString(doption["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(doption["RspExerciseQstnId"]) + "_" + Convert.ToString(doption["SeqNo"]) + " style='font-size:.75rem;margin-bottom:3px;padding:2px;width:98%;min-height:20px'><span class='ques-panel-no'>" + Convert.ToString(doption["SeqNo"]) + "</span>" + OptionDescr + "</div>");
                                    }
                                    else if (Convert.ToInt32(QstnTypeID) == 8)
                                    {
                                        if (IsSequencing == 0)
                                        {
                                            strOption.Append("<div IsSequencing='" + IsSequencing.ToString() + "' title='" + HttpUtility.HtmlEncode(doption["OptionDescr"].ToString()) + "' QstnTypeID='" + QstnTypeID + "' class=\"clsdivdraggable\" id=" + Convert.ToString(doption["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(doption["RspExerciseQstnId"]) + "_" + Convert.ToString(doption["SeqNo"]) + " style='font-size:.75rem;margin-bottom:3px;padding:2px;width:98%;min-height:20px'><span class='ques-panel-no'>" + Convert.ToString(doption["SeqNo"]) + "</span>" + OptionDescr + "</div>");
                                        }
                                        else {
                                            strOption.Append("<div title='" + HttpUtility.HtmlEncode(doption["OptionDescr"].ToString()) + "' IsSequencing='" + IsSequencing.ToString() + "' QstnTypeID='" + QstnTypeID + "' class=\"divsort\" id=" + Convert.ToString(doption["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(doption["RspExerciseQstnId"]) + "_" + Convert.ToString(doption["SeqNo"]) + " style='font-size:.75rem;margin-bottom:3px;padding:2px;width:98%;min-height:20px'><span class='ques-panel-no'>" + Convert.ToString(doption["SeqNo"]) + "</span>" + OptionDescr + "</div>");
                                        }
                                    }
                                    else
                                    {
                                        strOption.Append("<div title='" + HttpUtility.HtmlEncode(doption["OptionDescr"].ToString()) + "' IsSequencing='" + IsSequencing.ToString() + "' QstnTypeID='" + QstnTypeID + "' class=\"clsdivdraggable\" id=" + Convert.ToString(doption["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(doption["RspExerciseQstnId"]) + "_" + Convert.ToString(doption["SeqNo"]) + " ><span class='ques-panel-no'>" + Convert.ToString(doption["SeqNo"]) + "</span>" + OptionDescr + "</div>");
                                    }

                                }
                            }
                        }
                    }
                }
                if (Convert.ToInt32(QstnTypeID) != 10)
                {
                    string IsHeShe = Convert.ToString(drow1["BucketDescrLvl2"]);
                    string divimg = (IsHeShe == "" || IsHeShe == "0") ? "" : "<div class='clsImgTitle'><img style='height:37px' src='../../images/" + (IsHeShe == "1" ? "icoHe.png" : "icoShe.png") + "'/></div>";
                    string strMinHeight = (IsHeShe == "" || IsHeShe == "0") ? "" : "style='min-height: 60px !important'";
                    string strWidth = swidth == 0 ? "" : "style='width: " + swidth + "% !important'";
                    if (IsHeShe == "" || IsHeShe == "0")
                    {
                        strHTML.Append("<div " + strWidth + " class=" + (Convert.ToInt32(QstnTypeID) == 7 || Convert.ToInt32(QstnTypeID) == 9 ? "'box'" : "'boxLeft'") + " BucketNo='" + (BucketNo - 1) + "' id='DivBucketNo_" + Convert.ToString(drow1["BucketNo"]) + "_" + Convert.ToString(drow1["QstBucketMapId"]) + "_" + Convert.ToString(drow1["CorrectOptions"]) + "'  >" + divimg + "<div class=\"box-header\" style='font-size:9pt;padding-left:35px'>" + BucketDescrLvl1 + "</div><div " + strMinHeight + "  class=\"box-body clsdivdroppable\" data-max='" + Convert.ToString(drow1["BucketMaxLimit"]) + "' data-min='" + Convert.ToString(drow1["BucketMinLimit"]) + "'>" + strOption.ToString() + "</div></div>");
                    }
                    else
                    {
                        ImgExist = 1;
                        strHTML.Append("<div " + strWidth + " IsHeShe='1'  class=" + (Convert.ToInt32(QstnTypeID) == 7 || Convert.ToInt32(QstnTypeID) == 9 ? "'box'" : "'boxLeft'") + " BucketNo='" + (BucketNo - 1) + "' id='DivBucketNo_" + Convert.ToString(drow1["BucketNo"]) + "_" + Convert.ToString(drow1["QstBucketMapId"]) + "_" + Convert.ToString(drow1["CorrectOptions"]) + "'  >" + divimg + "<div class=\"box-header\" style='font-size:8.5pt;padding-left:35px'><label><input type='checkbox' onchange='fnDisableEnableDroppable(this)'> " + BucketDescrLvl1 + "</label></div><div " + strMinHeight + "  class=\"box-body clsdivdroppable\" data-max='" + Convert.ToString(drow1["BucketMaxLimit"]) + "' data-min='" + Convert.ToString(drow1["BucketMinLimit"]) + "'>" + strOption.ToString() + "</div></div>");
                    }
                }
                else
                {
                    strHTML.Append("<table class='table table-bordered' id='tblQstType10'>");
                    string strBucket2 = Convert.ToString(drow1["BucketDescrLvl2"]);
                    strHTML.Append("<thead><tr class='btn-primary text-white'>");
                    strHTML.Append("<th style='padding:2px;font-weight:bold;text-align:center;font-size:12pt'>NB Need</th>");
                    strHTML.Append("<th style='width:33%;padding:2px;font-weight:bold;text-align:center;font-size:12pt'>Solution</th>");
                    strHTML.Append("<th style='width:33%;padding:2px;font-weight:bold;text-align:center;font-size:12pt'>Outcome</th>");
                    strHTML.Append("</tr></thead><tbody>");
                    for (int b = 0; b < strBucket2.Split('|').Length; b++)
                    {
                        string strSelectedSolution = "";
                        string strSelectedOutcome = "";
                        if (Answrval != "")
                        {
                            string arrAnswrval = Answrval.Split('|')[b];
                            string solutionId = arrAnswrval.Split('-')[1];
                            string OutcomeId = arrAnswrval.Split('-')[2];
                            DataRow[] arrsolution = ds.Tables[1].Select("RspExerciseQstnOptionId in (" + solutionId + ")");
                            strSelectedSolution = "<div IsSequencing='" + IsSequencing.ToString() + "' QstnTypeID='10' class=\"clsdivdraggableSolution\" id=" + Convert.ToString(arrsolution[0]["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(arrsolution[0]["RspExerciseQstnId"]) + "_" + Convert.ToString(arrsolution[0]["SeqNo"]) + " style='width:97%;min-height:30px' ><span class='ques-panel-no'>" + Convert.ToString(arrsolution[0]["SeqNo"]) + "</span>" + arrsolution[0]["OptionDescr"].ToString() + "</div>";
                            DataRow[] arrOutcome = ds.Tables[1].Select("RspExerciseQstnOptionId in (" + OutcomeId + ")");
                            strSelectedOutcome = "<div IsSequencing='" + IsSequencing.ToString() + "' QstnTypeID='10' class=\"clsdivdraggableOutcome\" id=" + Convert.ToString(arrOutcome[0]["RspExerciseQstnOptionId"]) + "_" + Convert.ToString(arrOutcome[0]["RspExerciseQstnId"]) + "_" + Convert.ToString(arrOutcome[0]["SeqNo"]) + " style='width:97%;min-height:30px' ><span class='ques-panel-no'>" + Convert.ToString(arrOutcome[0]["SeqNo"]) + "</span>" + arrOutcome[0]["OptionDescr2"].ToString() + "</div>";
                        }
                        strHTML.Append("<tr style='height:40px'>");
                        strHTML.Append("<td style='padding:2px;'><span class='ques-panel-no' style='position:relative !important;left:0;'>" +(b+1).ToString() + "</span>    " + strBucket2.Split('|')[b] + "</td>");
                        strHTML.Append("<td style='padding:2px' class='clsdivdroppableSolution' data-max='1' data-min='" + Convert.ToString(drow1["BucketMinLimit"]) + "'>" + strSelectedSolution + "</td>");
                        strHTML.Append("<td style='padding:2px' class='clsdivdroppableOutcome' data-max='1' data-min='" + Convert.ToString(drow1["BucketMinLimit"]) + "'>" + strSelectedOutcome + "</td>");
                        strHTML.Append("</tr>");
                    }
                    strHTML.Append("</tbody></table>");
                }
                BucketNoSeq++;
                if (Convert.ToInt32(QstnTypeID) == 9)
                {
                    break;
                }

            }
            strHTML.Append("</div>");

            if (Convert.ToInt32(QstnTypeID) == 7)
            {
                if (SelectedLanguageId == 1)
                {
                    if (ImgExist == 0)
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>சரியான பதிலை தேர்ந்தெடுத்து அதற்கு பொருத்தமான வகையுடன் சேர்க்கவும்.</li><li>ஒவ்வொரு வகையிலும் குறைந்தது ஒரு பதிலாவது இருக்க வேண்டும்.</li></ul></div>";
                    }
                    else
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>தேர்ந்தெடுக்கப்பட்ட வகைகளில் பதில்களை இழுத்து விடுங்கள்.</li><li>தேர்ந்தெடுக்கப்பட்ட ஒவ்வொரு வகையிலும் குறைந்தது ஒரு பதிலைக் கொண்டிருக்க வேண்டும்.</li></ul></div>";
                    }
                }else if (SelectedLanguageId == 2)
                {
                    if (ImgExist == 0)
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>Silakan pilih dan pindahkan pilihan respons yang tersedia ke dalam 3 kategori.</li><li>Tiap kategori harus berisi setidaknya satu respons.</li></ul></div>";
                    }
                    else
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>Harap seret dan lepas tanggapan ke dalam kategori yang dipilih.</li><li>Setiap kategori yang dipilih harus berisi setidaknya satu tanggapan.</li></ul></div>";
                    }
                }
                else if (SelectedLanguageId == 3)
                {
                    if (ImgExist == 0)
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>කරුණාකර ඔබේ ප්‍රතිචාර කාණ්ඩ 3 තුල ගොනු කරන්න.</li><li>සෑම කාණ්ඩයකම අවම වශයෙන් එක් ප්‍රතිචාරයක්වත් අඩංගු විය යුතුය.</li></ul></div>";
                    }
                    else
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>කරුණාකර ප්‍රතිචාර තෝරාගත් කාණ්ඩවලට ඇදගෙන යන්න.</li><li>තෝරාගත් සෑම කාණ්ඩයකම අවම වශයෙන් එක් ප්‍රතිචාරයක්වත් තිබිය යුතුය.</li></ul></div>";
                    }
                }
                else {
                    if (ImgExist == 0)
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>Please drag and drop the responses into the 3 categories.</li><li>Each category should contain at least one response.</li></ul></div>";
                    }
                    else
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>Please drag and drop the responses into the selected categories.</li><li>Each selected category should contain at least one response.</li></ul></div>";
                    }
                }
            }
            else if (Convert.ToInt32(QstnTypeID) == 8)
            {
                if (SelectedLanguageId == 1)
                {
                    if (IsSequencing == 0)
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>சரியான விருப்பங்களுக்கு பதிலை இழுத்து விடுங்கள்.</li></ul></div>";
                    }
                    else
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>தேவையான வரிசையில் சரியான விருப்பங்கள் மற்றும் வரிசைக்கு பதிலை இழுத்து விடுங்கள்.</li><li>நீங்கள் பதிலை நீக்க விரும்பினால் தயவுசெய்து இருமுறை சொடுக்கவும்.</li></ul></div>";
                    }
                }else if (SelectedLanguageId == 2)
                {
                    if (IsSequencing == 0)
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>Harap seret dan lepas tanggapan ke opsi yang benar.</li></ul></div>";
                    }
                    else
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>Harap seret dan lepaskan tanggapan ke dalam opsi dan Urutan yang benar dalam urutan yang diperlukan.</li><li>Jika Anda ingin menghapus tanggapan, klik dua kali di bagian yang sama. </li></ul></div>";
                    }
                }
                else if (SelectedLanguageId == 3)
                {
                    if (IsSequencing == 0)
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>කරුණාකර ප්‍රතිචාරය නිවැරදි විකල්ප වෙත ඇදගෙන යන්න.</li></ul></div>";
                    }
                    else
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>කරුණාකර ප්‍රතිචාරය නිවැරදි විකල්ප වලට ඇදගෙන අවශ්‍ය අනුපිළිවෙලට අනුපිළිවෙලට දමන්න.</li><li>ඔබට ප්‍රතිචාරය මකා දැමීමට අවශ්‍ය නම් එය මත දෙවරක් ක්ලික් කරන්න. </li></ul></div>";
                    }
                }
                else
                {
                    if (IsSequencing == 0)
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>Please drag and drop the response into the correct options.</li></ul></div>";
                    }
                    else
                    {
                        strInstructions = "<div style='float:left;display:inline'><ul><li>Please drag and drop the response into the correct options and Sequence in the required order.</li><li>If you wish to delete response kindly double click on the same. </li></ul></div>";
                    }
                }
            }
            else if (Convert.ToInt32(QstnTypeID) == 9)
            {
                if (SelectedLanguageId == 1)
                {
                    strInstructions = "<div style='float:left;display:inline'><ul><li>தயவுசெய்து சரியான மாதிரியைத் தேர்ந்தெடுத்து தேவையான விருப்பங்களை இழுக்கவும்.</li></ul></div>";
                }else if (SelectedLanguageId == 2)
                {
                    strInstructions = "<div style='float:left;display:inline'><ul><li>Harap pilih model yang benar, lalu tarik jatuhkan opsi yang diperlukan.</li></ul></div>";
                }
                else if (SelectedLanguageId == 3)
                {
                    strInstructions = "<div style='float:left;display:inline'><ul><li>කරුණාකර නිවැරදි ආකෘතිය තෝරන්න, පසුව අවශ්‍ය විකල්ප ඇදගෙන යන්න.</li></ul></div>";
                }
                else {
                    strInstructions = "<div style='float:left;display:inline'><ul><li>Please select the correct model and then drag drop required options.</li></ul></div>";
                }
            }
            else if (Convert.ToInt32(QstnTypeID) == 10)
            {
                if (SelectedLanguageId == 1)
                {
                    strInstructions = "<div style='float:left;display:inline'><ul><li>தயவுசெய்து பதிலை தீர்வு மற்றும் விளைவு பிரிவுகளுக்கு இழுத்து விடுங்கள்.</li></ul></div>";
                }
                else if (SelectedLanguageId == 2)
                {
                    strInstructions = "<div style='float:left;display:inline'><ul><li>Harap seret dan lepas tanggapan ke bagian solusi dan hasil.</li></ul></div>";
                }
                else if (SelectedLanguageId == 3)
                {
                    strInstructions = "<div style='float:left;display:inline'><ul><li>කරුණාකර ප්‍රතිචාරය විසඳුම් සහ ප්‍රති come ල කොටස් වලට ඇදගෙන යන්න.</li></ul></div>";
                }
                else {
                    strInstructions = "<div style='float:left;display:inline'><ul><li>Please drag and drop the response into the solution and outcome sections.</li></ul></div>";
                }
                
            }
        }
        string sbtnNext = "";
        string sbtnPrevious = "";
        string sbtnSubmit = "";
        if (SelectedLanguageId == 1)
        {
            sbtnNext = "அடுத்தது";
            sbtnPrevious = "முந்தையது";
            sbtnSubmit = "சமர்ப்பிக்கவும்";
        }
        else if (SelectedLanguageId == 2)
        {
            sbtnNext = "Lanjut";
            sbtnPrevious = "Sebelumnya";
            sbtnSubmit = "Kirimkan";
        }
        else if (SelectedLanguageId == 3)
        {
            sbtnNext = "ඊලඟ";
            sbtnPrevious = "පෙර";
            sbtnSubmit = "ඉදිරිපත් කරන්න";
        }
        else {
            sbtnNext = "Next";
            sbtnPrevious = "Previous";
            sbtnSubmit = "Submit";
        }
        if (PageNo == 1)
        {
            strHTML.Append("<div class=\"text-center mb-3\" id=\"divNext\">" + strInstructions + "<div class='divbtncls' style='float:right;display:inline'><a href=\"###\" onclick=\"fnNext()\" id=\"btnNext\" class=\"btns btn-submit\">"+ sbtnNext + "</a></div></div>");
        }
        else if (PageNo > 1 && PageNo < TotQstn)
        {
            strHTML.Append("<div class=\"text-center mb-3\" id=\"divNext\">" + strInstructions + "<div class='divbtncls' style='float:right;display:inline'><a href=\"###\" onclick=\"fnPrevious()\" id=\"btnAnchorPrevious\" class=\"btns btn-submit\">" + sbtnPrevious + "</a><a href=\"###\" onclick=\"fnNext()\" id=\"btnNext\" class=\"btns btn-submit\">" + sbtnNext + "</a></div></div>");
        }
        else if (PageNo > 1 && PageNo == TotQstn)
        {
            strHTML.Append("<div class=\"text-center mb-3\" id=\"divNext\">" + strInstructions + "<div class='divbtncls' style='float:right;display:inline'><a href=\"###\" onclick=\"fnPrevious()\" id=\"btnAnchorPrevious\" class=\"btns btn-submit\">" + sbtnPrevious + "</a><a href=\"###\" onclick=\"fnNext()\" id=\"btnNext\" class=\"btns btn-submit\">" + sbtnSubmit + "</a></div></div>");
        }

        return strHTML.ToString();

    }


    public static string fnCreateRadioBtnDetail(int QstnStatID, string Descr, int iCount, string RsltQstnStatID, int RspDetID, int QstnTypeId, int qstno, int PageNo, int CorrectAnswer, int OptionSeq, int OptionView)
    {
        string InnerTable = ""; string padding = "8px";


        if (QstnTypeId == 1 && OptionView == 1)
        {
            InnerTable += "<div class=\"radio\"><label><input type='radio' id='rdoAns" + RspDetID + "^" + (iCount + 1) + "' QstnTypeId=" + QstnTypeId + " role='" + CorrectAnswer + "'  value='" + RspDetID + "#" + QstnStatID + "'   name='check" + qstno + "'>" + Descr + "</label></div>";
        }
        else if (QstnTypeId == 2 && OptionView == 1)
        {
            InnerTable += "<div class=\"checkbox\"><label><input type='checkbox' id='rdoAns" + RspDetID + "^" + (iCount + 1) + "' QstnTypeId=" + QstnTypeId + " role='" + CorrectAnswer + "'  value='" + RspDetID + "#" + QstnStatID + "'   name='checkch" + qstno + "'>" + Descr + "</label></div>";
        }
        else if (QstnTypeId == 1 && OptionView == 2)
        {
            InnerTable += "<label><input type='radio' id='rdoAns" + RspDetID + "^" + (iCount + 1) + "' QstnTypeId=1 role='" + CorrectAnswer + "'  value='" + RspDetID + "#" + QstnStatID + "'   name='check" + qstno + "'>" + Descr + "</label>";
        }
        else if (QstnTypeId == 2 && OptionView == 2)
        {
            InnerTable += "<label><input type='checkbox' id='rdoAns" + RspDetID + "^" + (iCount + 1) + "' QstnTypeId=" + QstnTypeId + " role='" + CorrectAnswer + "'  value='" + RspDetID + "#" + QstnStatID + "'   name='checkch" + qstno + "'>" + Descr + "</label>";
        }
        else if (QstnTypeId == 6)
        {
            string src = OptionSeq == 1 ? "opThumbUP.png" : "opThumbDown.png";
            InnerTable += "<a href='###' style='margin-left:110px;' onclick='fnClickThumbOPtion(this)'><img style='border: 1px solid white;' src='images/" + src + "' flg='flgimg' id='rdoAns" + RspDetID + "^" + (iCount + 1) + "' QstnTypeId=" + QstnTypeId + " role='" + CorrectAnswer + "'  value='" + RspDetID + "#" + QstnStatID + "'   name='check" + qstno + "'/></a>";
        }
        else if (QstnTypeId == 12)
        {
            string src = OptionSeq == 1 ? "happysmily.png" : "sadsmily.png";
            InnerTable += "<a href='###' style='margin-left:110px;' onclick='fnClickThumbOPtion(this)'><img style='border: 1px solid white;width:7%' src='images/" + src + "' flg='flgimg' id='rdoAns" + RspDetID + "^" + (iCount + 1) + "' QstnTypeId=" + QstnTypeId + " role='" + CorrectAnswer + "'  value='" + RspDetID + "#" + QstnStatID + "'   name='check" + qstno + "'/></a>";
        }
        else
        {
            if (OptionView == 1)
            {
                InnerTable += "<div class=\"radio\"><label><input type='radio' id='rdoAns" + RspDetID + "^" + (iCount + 1) + "' QstnTypeId=" + QstnTypeId + " role='" + CorrectAnswer + "'  value='" + RspDetID + "#" + QstnStatID + "'   name='check" + qstno + "'>" + Descr + "</label></div>";
            }
            else
            {
                InnerTable += "<label><input type='radio' id='rdoAns" + RspDetID + "^" + (iCount + 1) + "' QstnTypeId=1 role='" + CorrectAnswer + "'  value='" + RspDetID + "#" + QstnStatID + "'   name='check" + qstno + "'>" + Descr + "</label>";
            }
        }


        return InnerTable;
    }

    public static string fnGetSubStatement(DataSet ds, int QstID, string RsltVal, int RspDetId, int TypeID, int MaxQstnSelected)
    {
        string strArrayOptionsSeq = "Option A</br>(Medium Difficulty)|Option B</br>(High Difficulty)|Option C</br>(High Difficulty)|Option D</br>(Extremely High Difficulty)";
        var strInnerTable = new StringBuilder();
        string QstnValue;
        string Value = "";
        int ctr = 0;
        int cntr = 0;
        int flagCount = 0;
        var arrStrAnswrVal = RsltVal.Replace("-1^", "").Split(',');
        if (ds.Tables[1].Rows.Count > 0)
        {
            if (TypeID == 3)  // for Checkbox
            {

                for (int k = 0, loopTo = ds.Tables[1].Rows.Count - 1; k <= loopTo; k++)
                {
                    strInnerTable.Append("<div id='tblChk' class='checkbox checkbox-group'>");
                    QstnValue = ds.Tables[1].Rows[k]["RspExerciseQstnOptionId"].ToString();

                    strInnerTable.Append("<table id='tblChk' class='checkbox checkbox-group' style='width:100%'>");
                    strInnerTable.Append("<td class='checkbox' style='width:20px;padding-right:10px;vertical-align:top;font-size:12pt;font-weight:bold' >");
                    strInnerTable.Append(strArrayOptionsSeq.Split('|')[k] + ". ");
                    strInnerTable.Append("</td>");
                    if (arrStrAnswrVal.Contains(QstnValue))
                    {
                        strInnerTable.Append("<td class='checkbox' style='width:20px;vertical-align:top;text-align:center' >");
                        strInnerTable.Append("<input qstId='" + QstID + "' style='cursor:default' type='checkbox' maxQstnSelected=" + MaxQstnSelected + " RspDetID = " + RspDetId + " value = '" + QstnValue + "' checked=true id='chkAns" + RspDetId + "^" + (k + 1) + "' name = '" + RspDetId + "'>");
                        strInnerTable.Append("</td>");
                        strInnerTable.Append("<td style='padding-left:7px'>");
                        strInnerTable.Append("<label for='chkAns" + RspDetId + "^" + (k + 1) + "' >" + ds.Tables[1].Rows[k]["OptionDescr"] + "</label>");
                        strInnerTable.Append("</td>");
                    }
                    else
                    {
                        strInnerTable.Append("<td class='radio' style='width:20px;vertical-align:top;text-align:center' >");
                        strInnerTable.Append("<input qstId='" + QstID + "' style='cursor:default' type='checkbox' maxQstnSelected=" + MaxQstnSelected + " RspDetID = " + RspDetId + " value = '" + QstnValue + "' id='chkAns" + RspDetId + "^" + (k + 1) + "' name = '" + RspDetId + "'>");
                        strInnerTable.Append("</td>");
                        strInnerTable.Append("<td style='padding-left:7px'>");
                        strInnerTable.Append("<label for='chkAns" + RspDetId + "^" + (k + 1) + "' >" + ds.Tables[1].Rows[k]["OptionDescr"] + "</label>");
                        strInnerTable.Append("</td>");
                    }
                    strInnerTable.Append("</table>");
                }


            }
            else if (TypeID == 1)  // for Radio
            {
                flagCount = 0;
                int countOfRowsForRank = ds.Tables[1].Rows.Count;

                for (int k = 0, loopTo2 = ds.Tables[1].Rows.Count - 1; k <= loopTo2; k++)
                {
                    QstnValue = ds.Tables[1].Rows[k]["RspExerciseQstnOptionId"].ToString(); // & "^" & ds.Tables(0).Rows(k)("flgQstnShow") & "^" & QstID
                    RsltVal = RsltVal.Replace("-1^", "");                                                    // Value = RspDetId & "^" & QstnValue
                    strInnerTable.Append("<table id='tblRdo' class='radio-group' style='width:100%'>");
                    //strInnerTable.Append("<td class='radio' style='width:130px;padding-right:10px;vertical-align:top;font-size:9pt;text-align:left;padding-bottom:10px;font-weight:bold' >");
                    //strInnerTable.Append(strArrayOptionsSeq.Split('|')[k] + ". ");
                    //strInnerTable.Append("</td>");
                    if (!string.IsNullOrEmpty(RsltVal) & (QstnValue ?? "") == (RsltVal ?? ""))
                    {
                        strInnerTable.Append("<td class='radio' style='width:20px;vertical-align:top;padding-bottom:10px;text-align:center' >");
                        strInnerTable.Append("<input qstId='" + QstID + "' style='cursor:default' type='radio' RspDetID = " + RspDetId + " value = " + QstnValue + " checked=true id='rdoAns" + k + "^" + (k + 1) + "'  name = '" + RspDetId + "'>");
                        strInnerTable.Append("</td>");
                        strInnerTable.Append("<td style='padding-left:7px;vertical-align:top;padding-bottom:10px;'>");
                        strInnerTable.Append("<label for='rdoAns" + k + "^" + (k + 1) + "' >" + ds.Tables[1].Rows[k]["OptionDescr"] + "</label>");
                        strInnerTable.Append("</td>");
                    }
                    else
                    {
                        strInnerTable.Append("<td class='radio' style='width:20px;vertical-align:top;padding-bottom:10px;text-align:center'>");
                        strInnerTable.Append("<input qstId='" + QstID + "' style='cursor:default' type='radio' RspDetID = " + RspDetId + " value = " + QstnValue + " id='rdoAns" + k + "^" + (k + 1) + "'  name = '" + RspDetId + "'>");
                        strInnerTable.Append("</td>");
                        strInnerTable.Append("<td style='padding-left:7px;vertical-align:top;padding-bottom:10px;'>");
                        strInnerTable.Append("<label for='rdoAns" + k + "^" + (k + 1) + "' >" + ds.Tables[1].Rows[k]["OptionDescr"] + "</label>");
                        strInnerTable.Append("</td>");
                    }
                    strInnerTable.Append("</table>");
                }


            }
            else if (TypeID == 2)  // for drop down
            {
                strInnerTable.Append("<select id='ddl" + QstID + "' class='form-control'><option value='0'>- Select Rank- </option>");
                int countOfRowsForRank = ds.Tables[1].Rows.Count;
                for (int k = 0, loopTo3 = ds.Tables[1].Rows.Count - 1; k <= loopTo3; k++)
                {
                    QstnValue = ds.Tables[1].Rows[k]["RspExerciseQstnOptionId"].ToString();
                    Value = RspDetId + "^" + QstnValue;
                    if (!string.IsNullOrEmpty(RsltVal) & (QstnValue ?? "") == (RsltVal ?? ""))
                    {
                        strInnerTable.Append("<option value='" + ds.Tables[1].Rows[k]["OptionDescr"] + "' qtnval='" + Value + "' selected > " + ds.Tables[1].Rows[k]["OptionDescr"] + "</option>");
                    }
                    else
                    {
                        strInnerTable.Append("<option value='" + ds.Tables[1].Rows[k]["OptionDescr"] + "' qtnval='" + Value + "'>" + ds.Tables[1].Rows[k]["OptionDescr"] + "</option>");
                    }
                }

                strInnerTable.Append("</select>");
            }
            else if (TypeID == 4)  // for textbox
            {
                int countOfRowsForRank = ds.Tables[1].Rows.Count;
                strInnerTable.Append("<table id='tblTextbox' style='width:100%'>");
                for (int k = 0, loopTo4 = ds.Tables[1].Rows.Count - 1; k <= loopTo4; k++)
                {
                    QstnValue = ds.Tables[1].Rows[k]["RspExerciseQstnOptionId"].ToString(); // & "^" & ds.Tables(0).Rows(k)("flgQstnShow") & "^" & QstID
                    Value = RspDetId + "^" + QstnValue;
                    if (!string.IsNullOrEmpty(RsltVal))
                    {
                        strInnerTable.Append("<tr>");
                        //strInnerTable.Append("<td style='width:40%'>");
                        //strInnerTable.Append(ds.Tables[1].Rows[k]["OptionDescr"]);
                        //strInnerTable.Append("</td>");
                        strInnerTable.Append("<td>");
                        //strInnerTable.Append("<input type='textbox'  id='rdoAns" + k + "^" + (k + 1) + "' class='form-control' style='width:250px'>");
                        //strInnerTable.Append("<textarea cols='200' multiline='true'  rows='8'   class='form-control' style='width:100%; height:180px'>'" + RsltVal.Split('^')[1] + "'</textarea>");
                        strInnerTable.Append("<textarea qstId='" + QstID + "' cols='200' multiline='false'  rows='8'   class='form-control' style='width:100%; height:180px'>" + RsltVal.Split('^')[1] + "</textarea>");
                        strInnerTable.Append("</td>");
                        strInnerTable.Append("</tr>");
                    }
                    else
                    {
                        strInnerTable.Append("<tr>");
                        //strInnerTable.Append("<td style='width:40%'>");
                        //strInnerTable.Append(ds.Tables[1].Rows[k]["OptionDescr"]);
                        //strInnerTable.Append("</td>");
                        strInnerTable.Append("<td>");
                        //strInnerTable.Append("<input type='textbox'   id='rdoAns" + k + "^" + (k + 1) + "' class='form-control' style='width:250px'>");
                        strInnerTable.Append("<textarea cols='200' qstId='" + QstID + "' multiline='false'  rows='8'   class='form-control' style='width:100%;height:180px'></textarea>");
                        strInnerTable.Append("</td>");
                        strInnerTable.Append("</tr>");
                    }
                }

                strInnerTable.Append("</table>");
            }
        }

        return strInnerTable.ToString();
    }
    [System.Web.Services.WebMethod()]
    public static string fnUpdateTime(int RspExerciseID, int TotalElapsedSec)
    {
        classUsedForExerciseSave ObjclassUsedForExerciseSave = new classUsedForExerciseSave();
        ObjclassUsedForExerciseSave.SpUpdateElaspedTime(RspExerciseID);
        return "0";
    }

    [System.Web.Services.WebMethod]
    public static string fnStartMeetingTimer(int RSPExerciseID, int MeetingDefaultTIME)
    {
        string strReturn = "1";

        //int LoginId = (int)HttpContext.Current.Session["LoginId"];
        using (SqlConnection Objcon2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["strConn"]))
        {
            using (SqlCommand objCom2 = new SqlCommand("[spAssesmentCheckDiscussionStarted]", Objcon2))
            {
                objCom2.Parameters.Add("@RspExerciseID", SqlDbType.Int).Value = RSPExerciseID;
                objCom2.Parameters.Add("@MeetingDefaultTIME", SqlDbType.Int).Value = MeetingDefaultTIME;
                objCom2.CommandType = CommandType.StoredProcedure;
                objCom2.CommandTimeout = 0;

                SqlDataAdapter da = new SqlDataAdapter(objCom2);
                DataTable dt = new DataTable();
                try
                {
                    da.Fill(dt);
                    strReturn = "0|" + dt.Rows[0]["flgReturnVal"] + "|" + dt.Rows[0]["RemainingTimeMeeting"] + "|" + dt.Rows[0]["PrepRemainingTime"];
                }
                catch (Exception ex)
                {
                    strReturn = "1|" + ex.Message;
                }
            }
        }
        return strReturn;
    }

}