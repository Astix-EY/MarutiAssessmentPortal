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
using Newtonsoft.Json;
using DocumentFormat.OpenXml.Wordprocessing;

public partial class CommonData_Questionnaire_frmLifeRefQuestionnaire : System.Web.UI.Page
{
    static string strConn = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginId"] == null)
        {
            Response.Write("<script>parent.frames.location.href='../Common/frmSessionExpire.aspx'</script>");
            return;
        }

        hdnToolID.Value = "0";// ((Request.QueryString["ToolID"] == null) ? "0" : Request.QueryString["ToolID"]);
        hdnLanguageId.Value = "0";// ((Session["SelectedLngID"] == null) ? "6" : Session["SelectedLngID"].ToString());
        int BandID = 1;// ((Request.QueryString["BandID"] == null) ? 0 : Convert.ToInt32(Request.QueryString["BandID"]));
        int ExerciseType = 0;// ((Request.QueryString["ExerciseType"] == null) ? 0 : Convert.ToInt32(Request.QueryString["ExerciseType"]));
        hdnRspID.Value =  ((Request.QueryString["RspID"] == null) ? "0" : Request.QueryString["RspID"]);
        hdnLoginID.Value =  ((Request.QueryString["intLoginID"] == null) ? "0" : Request.QueryString["intLoginID"]);
        hdnExerciseID.Value = "47";// ((Request.QueryString["ExerciseID"] == null) ? "0" : Request.QueryString["ExerciseID"]);
        if (!IsPostBack)
        {
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
                else
                {
                    hdnCounterRunTime.Value = MeetingRemainingTime < 0 ? "0" : MeetingRemainingTime.ToString();
                }

                int PrepRemainingTime = Convert.ToInt32(dr["PrepRemainingTime"]);
                if (PrepStatus == 2)
                {
                    hdnCounter.Value = "0";
                }
                else
                {
                    hdnCounter.Value = PrepRemainingTime < 0 ? "0" : PrepRemainingTime.ToString();
                    fnUpdateActualStartEndTime(Convert.ToInt32(hdnRSPExerciseID.Value), 1, 1);
                }
                hdnTotQstn.Value = "3";// dr["TotQstn"].ToString();
                hdnExerciseStatus.Value = dr["flgExerciseStatus"].ToString();
                hdnPageNmbr.Value = dr["PGNmbr"].ToString() == "0" ? "1" : dr["PGNmbr"].ToString();
                if (hdnExerciseStatus.Value == "2")
                {
                    hdnPageNmbr.Value = "1";
                }

                divMainContainer.InnerHtml = fnGetQuestionDetails(Convert.ToInt32(hdnPageNmbr.Value), Convert.ToInt32(hdnExerciseID.Value), Convert.ToInt32(hdnRSPExerciseID.Value), Convert.ToInt32(hdnTotQstn.Value), Convert.ToInt32(hdnLanguageId.Value));
            }
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnUpdateUserExerciseResponses(int RSPExerciseID, object strResult, int Status, int flgTimeOver, int LoginId)
    {
        string strReturn = 1.ToString();
        string strTablePurchase = JsonConvert.SerializeObject(strResult, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
        DataTable DtActualAnswerDetail = JsonConvert.DeserializeObject<DataTable>(strTablePurchase);
        DtActualAnswerDetail.TableName = "ActualAnswerDetail";


        // Sub spRspBusinessCaseUPDAnswers(ByVal RspExerciseID As Integer, ByVal LoginId As Integer, ByVal selValues As String, ByVal statusValue As Integer)
        var Objcon2 = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["strConn"]);
        var objCom2 = new SqlCommand("[spUpdateUserExerciseResponsesWithMultipleQstns]", Objcon2);
        objCom2.Parameters.AddWithValue("@RspExcersiseID", RSPExerciseID);
        objCom2.Parameters.AddWithValue("@RspActualAnswerDetail", DtActualAnswerDetail);
        objCom2.Parameters.AddWithValue("@LoginID", LoginId);
        objCom2.Parameters.AddWithValue("@Status", Status);
        objCom2.Parameters.AddWithValue("@PGNmbr", 1);
        objCom2.Parameters.AddWithValue("@flgTimeOver", flgTimeOver);
        objCom2.CommandType = CommandType.StoredProcedure;
        objCom2.CommandTimeout = 0;
        try
        {
            Objcon2.Open();
            objCom2.ExecuteNonQuery();
            if (Status == 2)
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
string oldQstnHdr = "";
        int IsSequencing = 0;
        string flgAllOptionCompulsory = "0";
        for (int z = 0; z < ds.Tables[0].Rows.Count; z++)
        {
            if (ds.Tables[0].Rows.Count > 0)
            {
                flgAllOptionCompulsory = Convert.ToString(ds.Tables[0].Rows[z]["flgAllOptionCompulsory"]);
                //flgAllOptionCompulsory
                // strHTML.Append("<div class='alert alert-info' style='position:absolute;margin-top:-41px;padding:.30rem 1.25rem;'>Page No :  " + ds.Tables[0].Rows[z]["Qstno"] + " / " + TotQstn + "</div>");
                RspDetID = Convert.ToString(ds.Tables[0].Rows[z]["RspDetID"]);
                RspDetID = RspDetID == "" ? "0" : RspDetID;
                QstnTypeID = ds.Tables[0].Rows[z]["TypeId"].ToString();
                RspExcerciseQstnID = ds.Tables[0].Rows[z]["RspExcerciseQstnID"].ToString();
if(oldQstnHdr!= Convert.ToString(ds.Tables[0].Rows[z]["QstnHdr"])){
                strHTML.Append("<p iden='qstnHeader' style='font-weight: bold;font-size:13pt;color:black'>" + Convert.ToString(ds.Tables[0].Rows[z]["QstnHdr"]) + "</p>");
}     
oldQstnHdr= Convert.ToString(ds.Tables[0].Rows[z]["QstnHdr"]);         
 strHTML.Append("<div flg='idenQuestionContain' questId='" + RspExcerciseQstnID + "' RspDetID='" + RspDetID + "'>");
                DataTable dt = ds.Tables[1].Select("RspExerciseQstnId=" + RspExcerciseQstnID).CopyToDataTable();
                if (Convert.ToString(ds.Tables[0].Rows[z]["displayType"]) == "V")
                {
                    strHTML.Append("<table style='width:70%'>");
                    strHTML.Append("<tr>");
                    strHTML.Append("<td  style='width:55%'>");
                    strHTML.Append("<p style='font-size:12pt;font-weight:bold;' iden='qstn' flgAllOptionCompulsory='" + flgAllOptionCompulsory + "' RspDetID='" + RspDetID + "'  QstnTypeID='" + QstnTypeID + "' RspExcerciseQstnID='" + RspExcerciseQstnID + "'><b style='font-size:12.5pt'>Q" + ds.Tables[0].Rows[z]["IsOrdrSequence"].ToString() + ": </b>" + ds.Tables[0].Rows[z]["Qstn"].ToString());
                    if (flgAllOptionCompulsory == "1")
                    {
                        strHTML.Append("<span style='color:red'>*</span>");
                    }
                    strHTML.Append("</p>");
                    strHTML.Append("</td>");

                    strHTML.Append("<td style='text-align:left'>");

                    strHTML.Append(fnGetSubStatement(dt, Convert.ToInt32(ds.Tables[0].Rows[z]["RspExcerciseQstnID"]), Convert.ToString(ds.Tables[0].Rows[z]["Answrval"]), Convert.ToInt32(RspDetID), Convert.ToInt32(QstnTypeID), Convert.ToInt32(ds.Tables[0].Rows[z]["MaxQstnSelected"]), Convert.ToString(ds.Tables[0].Rows[z]["displayType"]), Convert.ToInt32(ds.Tables[0].Rows[z]["QstnDependent"]), flgAllOptionCompulsory));
                    strHTML.Append("</td>");
                    strHTML.Append("</tr>");
                    strHTML.Append("</table>");
                }
                else
                {
                    strHTML.Append("<div class='col-md-12 p-0'>");
                    strHTML.Append("<p style='font-size:12pt;font-weight:bold;' iden='qstn' flgAllOptionCompulsory='" + flgAllOptionCompulsory + "' RspDetID='" + RspDetID + "'  QstnTypeID='" + QstnTypeID + "' RspExcerciseQstnID='" + RspExcerciseQstnID + "'><b style='font-size:12.5pt'>Q" + ds.Tables[0].Rows[z]["IsOrdrSequence"].ToString() + ": </b>" + ds.Tables[0].Rows[z]["Qstn"].ToString());
                    if (flgAllOptionCompulsory == "1")
                    {
                        strHTML.Append("<span style='color:red'>*</span>");
                    }
                    strHTML.Append("</p>");

                    strHTML.Append("</div>");
                    IsSequencing = Convert.ToInt32(ds.Tables[0].Rows[z]["IsOrdrSequence"]);
                    strHTML.Append("<div class='col-md-11 col-md-offset-1 mb-2'>");
                    strHTML.Append("<div class='qusgroup_option'>");

                    strHTML.Append(fnGetSubStatement(dt, Convert.ToInt32(ds.Tables[0].Rows[z]["RspExcerciseQstnID"]), Convert.ToString(ds.Tables[0].Rows[z]["Answrval"]), Convert.ToInt32(RspDetID), Convert.ToInt32(QstnTypeID), Convert.ToInt32(ds.Tables[0].Rows[z]["MaxQstnSelected"]), Convert.ToString(ds.Tables[0].Rows[z]["displayType"]), Convert.ToInt32(ds.Tables[0].Rows[z]["QstnDependent"]), flgAllOptionCompulsory));
                    strHTML.Append("</div>");
                    strHTML.Append("</div>");
                }
                strHTML.Append("</div>");
            }
            else
            {
                return "No Data Found!";
            }

        }
        string strInstructions = "";
        string sbtnNext = "Next";
        string sbtnPrevious = "Previous";
        string sbtnSubmit = "Submit";
        if (PageNo == 1)
        {
            strHTML.Append("<div class=\"text-center mb-3\" id=\"divNext\">" + strInstructions + "<div class='divbtncls' style='float:right;display:inline'><a href=\"###\" onclick=\"fnNext()\" id=\"btnNext\" class=\"btns btn-submit\">" + sbtnNext + "</a></div></div>");
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


    public static string fnGetSubStatement(DataTable dt, int QstID, string RsltVal, int RspDetId, int TypeID, int MaxQstnSelected, string displayType,int QstnDependent,string flgalloptioncompulsory)
    {
        string strArrayOptionsSeq = "Option A</br>(Medium Difficulty)|Option B</br>(High Difficulty)|Option C</br>(High Difficulty)|Option D</br>(Extremely High Difficulty)";
        var strInnerTable = new StringBuilder();
        string QstnValue;
        string Value = "";
        int ctr = 0;
        int cntr = 0;
        int flagCount = 0;
        var arrStrAnswrVal = RsltVal.Replace("-1^", "").Split(',');
        if (dt.Rows.Count > 0)
        {

            if (TypeID == 4)  // for textbox
            {
                int countOfRowsForRank = dt.Rows.Count;
                strInnerTable.Append("<table id='tblTextbox' style='width:100%'>");
                
                for (int k = 0, loopTo4 = dt.Rows.Count - 1; k <= loopTo4; k++)
                {
                    QstnValue = dt.Rows[k]["RspExerciseQstnOptionId"].ToString(); // & "^" & ds.Tables(0).Rows(k)("flgQstnShow") & "^" & QstID
                    Value = RspDetId + "^" + QstnValue;
                    strInnerTable.Append("<tr>");
                    if (Convert.ToString(dt.Rows[k]["OptionDescr"]).Trim() != "")
                    {
                        strInnerTable.Append("<td style='text-align:right;padding-right:50px'>" + dt.Rows[k]["OptionDescr"] + "</td>");
                    }
                    if (!string.IsNullOrEmpty(RsltVal))
                    {
                       
                        strInnerTable.Append("<td style='text-align:left'>");
                        if (displayType == "V" || dt.Rows.Count>1)
                        {
                            strInnerTable.Append("<input type='text' flgalloptioncompulsory='" + (k < 2 ? flgalloptioncompulsory : "0") + "'  questId='" + QstID + "' RspDetId='" + RspDetId + "'   class='form-control "+ (QstnDependent>0?"clsDepedent_"+ QstnDependent:"")+"' style='width:100%;background-color:#ffffff' value='" + RsltVal.Split('^')[1].Split('|')[k] + "'/>");
                        }
                        else
                        {
                            strInnerTable.Append("<textarea flgalloptioncompulsory='"+ flgalloptioncompulsory + "'  questId='" + QstID + "' RspDetId='" + RspDetId + "' multiline='false'  rows='3'   class='form-control' style='width:100%;background-color:#ffffff'>" + RsltVal.Split('^')[1].Split('|')[k] + "</textarea>");
                        }
                        
                        strInnerTable.Append("</td>");
              
                    }
                    else
                    {
                        strInnerTable.Append("<td  style='text-align:left'>");

                        if (displayType == "V" || dt.Rows.Count > 1)
                        {
                            strInnerTable.Append("<input type='text' flgalloptioncompulsory='"+ (k<2? flgalloptioncompulsory:"0") + "'  questId='" + QstID + "' RspDetId='" + RspDetId + "' "+ (QstnDependent>0?" disabled":"")+"  class='form-control "+ (QstnDependent>0?"clsDepedent_"+ QstnDependent:"")+ "' style='width:100%;"+ (QstnDependent==0? "background-color:#ffffff":"") + "' />");
                        }
                        else
                        {
                            strInnerTable.Append("<textarea flgalloptioncompulsory='"+ flgalloptioncompulsory + "'  questId='" + QstID + "' RspDetId='" + RspDetId + "' multiline='false'  rows='3'   class='form-control' style='width:100%;background-color:#ffffff'></textarea>");
                        }
                       
                        strInnerTable.Append("</td>");
               
                       
                    }
                    strInnerTable.Append("</tr>");

                }
                
                strInnerTable.Append("</table>");
            }
            else if (TypeID == 1)  // for Radio
            {
                flagCount = 0;
                int countOfRowsForRank = dt.Rows.Count;

                for (int k = 0, loopTo2 = dt.Rows.Count - 1; k <= loopTo2; k++)
                {
                    QstnValue = dt.Rows[k]["RspExerciseQstnOptionId"].ToString(); // & "^" & ds.Tables(0).Rows(k)("flgQstnShow") & "^" & QstID
                    RsltVal = RsltVal.Replace("-1^", "");                                                    // Value = RspDetId & "^" & QstnValue
                    strInnerTable.Append("<table id='tblRdo' class='radio-group' style='width:100%'>");
                    //strInnerTable.Append("<td class='radio' style='width:130px;padding-right:10px;vertical-align:top;font-size:9pt;text-align:left;padding-bottom:10px;font-weight:bold' >");
                    //strInnerTable.Append(strArrayOptionsSeq.Split('|')[k] + ". ");
                    //strInnerTable.Append("</td>");
                    if (!string.IsNullOrEmpty(RsltVal) & (QstnValue ?? "") == (RsltVal ?? ""))
                    {
                        strInnerTable.Append("<td class='radio' style='width:20px;vertical-align:top;padding-bottom:10px;text-align:center' >");
                        strInnerTable.Append("<input style='cursor:default' type='radio' RspDetID = " + RspDetId + " flgalloptioncompulsory='"+ flgalloptioncompulsory + "' value = " + QstnValue + " checked=true id='rdoAns" + k + "^" + (k + 1) + "'  name = '" + RspDetId + "'>");
                        strInnerTable.Append("</td>");
                        strInnerTable.Append("<td style='padding-left:7px;vertical-align:top;padding-bottom:10px;'>");
                        strInnerTable.Append("<label for='rdoAns" + k + "^" + (k + 1) + "' >" + dt.Rows[k]["OptionDescr"] + "</label>");
                        strInnerTable.Append("</td>");
                    }
                    else
                    {
                        strInnerTable.Append("<td class='radio' style='width:20px;vertical-align:top;padding-bottom:10px;text-align:center'>");
                        strInnerTable.Append("<input style='cursor:default' type='radio' RspDetID = " + RspDetId + " flgalloptioncompulsory='"+ flgalloptioncompulsory + "' value = " + QstnValue + " id='rdoAns" + k + "^" + (k + 1) + "'  name = '" + RspDetId + "'>");
                        strInnerTable.Append("</td>");
                        strInnerTable.Append("<td style='padding-left:7px;vertical-align:top;padding-bottom:10px;'>");
                        strInnerTable.Append("<label for='rdoAns" + k + "^" + (k + 1) + "' >" + dt.Rows[k]["OptionDescr"] + "</label>");
                        strInnerTable.Append("</td>");
                    }
                    strInnerTable.Append("</table>");
                }


            }
            else if (TypeID == 2)  // for drop down
            {
                string selectedtxt = "";
                if (!string.IsNullOrEmpty(RsltVal))
                {
                    DataRow[] dr = dt.Select("RspExerciseQstnOptionId=" + RsltVal.Split('^')[1]);
                    if (dr.Length > 0)
                    {
                        selectedtxt = dr[0]["OptionDescr"].ToString();
                    }
                }
                strInnerTable.Append("<select id='ddl" + QstID + "' QstID='"+ QstID + "' flgalloptioncompulsory='"+ flgalloptioncompulsory + "'  class='form-control " + (QstnDependent>0?"clsDepedent_"+ QstnDependent:"")+"' "+(QstnDependent>0 && string.IsNullOrEmpty(RsltVal) ? " disabled":"")+" onchange=\"fnChangeDependentQstn(this,'"+ QstID + "')\"><option value='0'>---- </option>");
                int countOfRowsForRank = dt.Rows.Count;
                for (int k = 0, loopTo3 = dt.Rows.Count - 1; k <= loopTo3; k++)
                {
                    QstnValue = dt.Rows[k]["RspExerciseQstnOptionId"].ToString();
                    Value = RspDetId + "^" + QstnValue;
                    if (!string.IsNullOrEmpty(RsltVal) & ("-1^"+QstnValue ?? "") == (RsltVal ?? ""))
                    {
                        strInnerTable.Append("<option value='" + QstnValue + "' qtnval='" + Value + "' selected > " + dt.Rows[k]["OptionDescr"] + "</option>");
                    }
                    else
                    {
                        strInnerTable.Append("<option value='" + QstnValue + "' qtnval='" + Value + "'>" + dt.Rows[k]["OptionDescr"] + "</option>");
                    }
                }

                strInnerTable.Append("</select>");
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

        int LoginId = (int)HttpContext.Current.Session["LoginId"];
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