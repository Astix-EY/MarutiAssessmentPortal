using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using System.Configuration;
using System.Web;
using System.Web.Services.Description;
using RestSharp;
using System.Activities.Expressions;
using Newtonsoft.Json.Linq;
using System.ServiceModel.Activities;
using System.Data.SqlClient;
using System.Data;
using System.Drawing;
using System.Globalization;
using Microsoft.Ajax.Utilities;
using DataTable = System.Data.DataTable;
using System.IO;
using Newtonsoft.Json;

public class clsHttpRequest
{

    //      public static string GetTokenNo(string UserName,string Password)
    //      {
    //string userName = UserName;
    //      string userPassword = Password;
    //      string consumerKey = "Wjo9NZAk0atNqHkTYpynH0eqVAY7iOm3";
    //      string consumerSecret = "UXLhuciAU4iIyYeA";
    //      var authApi = new OAuth2Api(consumerKey, consumerSecret);
    //      var tokenResponse = authApi.DirectLogin(userName, userPassword);
    //      return tokenResponse.access_token;
    //      }
    public static string userName = ConfigurationManager.AppSettings["apiUser"];
    public static string password = ConfigurationManager.AppSettings["apiPassword"];
    public static string apiAuthenticationUrl = ConfigurationManager.AppSettings["apiAuthentication"];
    public static string AssignCandidateToExamEY = ConfigurationManager.AppSettings["AssignCandidateToExamEY"];
    public static string CreateCandidateDataEY = ConfigurationManager.AppSettings["CreateCandidateDataEY"];
    public static string ReportGenerationEY = ConfigurationManager.AppSettings["ReportGenerationEY"];
    public static string apiRole = ConfigurationManager.AppSettings["apiRole"];
    public static string strConn = ConfigurationManager.AppSettings["strConn"];
    public static string GetTokenNo()
    {
        
        string token = string.Empty;
        RestClient client = new RestClient(apiAuthenticationUrl);
        RestRequest request = new RestRequest(Method.POST);
        request.AddHeader("Content-Type", "application/x-www-form-urlencoded");
        request.AddParameter("Role", apiRole);
        request.AddParameter("Username", userName);
        request.AddParameter("Password", password);
        var response = client.Execute(request);
        CreateLogfile("response.StatusCode:"+ response.StatusCode, true);
        
        if (response.StatusCode == HttpStatusCode.OK)
        {
            CreateLogfile(response.Content.ToString(), true);
            //    CreateLogfile(response.ErrorMessage, true);
            var data = new JavaScriptSerializer().Deserialize<dynamic>(response.Content);

            if (data["objStatusCode"].ToString() == "1")
            {
                token = "1|" + data["Data"]["Token"].ToString();
            }
            else
            {
                token = "2|" + data["Message"].ToString();
            }
        }
        else
        {
            // CreateLogfile(response.StatusCode.ToString(), true);
            CreateLogfile(response.ErrorMessage, true);
            token = "2|" + response.ErrorMessage;
        }


        return token;
    }

    public static string sendConsolidatedReportDataToEK_OLD(string rspID)
    {
        string response = string.Empty;
        try
        {
            //System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;
            var strTokenNo = GetTokenNo();
            clsUserDetailsData objclsUserDetailsData = new clsUserDetailsData();
            using (SqlConnection sqlConn = new SqlConnection(strConn))
            {
                using (SqlCommand sqlcmd = new SqlCommand("SpAssessmentGetDataForAPI", sqlConn))
                {
                    sqlcmd.Parameters.AddWithValue("@RspId", rspID);
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.CommandTimeout = 0;
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        objclsUserDetailsData.studentName = ds.Tables[0].Rows[0]["studentName"].ToString();
                        objclsUserDetailsData.studentCode = ds.Tables[0].Rows[0]["studentCode"].ToString();
                        objclsUserDetailsData.studentEmail = ds.Tables[0].Rows[0]["studentEmail"].ToString();
                        objclsUserDetailsData.isInstantResultProcess = true;
                        objclsUserDetailsData.clientName = "assessment1";
                        objclsUserDetailsData.assessmentDetails = new List<clsassessmentDetails>();
                        foreach (DataRow drow in ds.Tables[4].Rows)
                        {
                            clsassessmentDetails clsclsassessmentDetails = new clsassessmentDetails();
                            string ExerciseId = Convert.ToString(drow["ExerciseId"]);
                            string ExerciseName = Convert.ToString(drow["ExerciseName"]);
                            string RspExerciseID = Convert.ToString(drow["RspExerciseID"]);
                            clsclsassessmentDetails.competency = new List<clsCompetency>();
                            DataRow[] drowsCompetencies = ds.Tables[1].Select("ExerciseID=" + ExerciseId);
                            if (drowsCompetencies.Length > 0)
                            {
                                foreach (DataRow drowcom in drowsCompetencies)
                                {
                                    clsCompetency clsclsCompetency = new clsCompetency();
                                    clsclsCompetency.competencyName = drowcom["CompetencyName"].ToString();
                                    clsclsCompetency.description = Convert.ToString(drowcom["CompetencyDescr"]);
                                    string ComppetencyId = Convert.ToString(drowcom["ComppetencyId"]);
                                    clsclsCompetency.marksCriteria = new List<clsmarksCriteria>();

                                    foreach (DataRow drowMark in ds.Tables[8].Rows)
                                    {
                                        string marks = Convert.ToString(drowMark["Score"]);
                                        DataRow[] drowsmarksCriteria = ds.Tables[9].Select("CompetencyID=" + ComppetencyId + " and ExerciseID=" + ExerciseId + " and Score=" + marks);
                                        clsmarksCriteria objclsmarksCriteria = new clsmarksCriteria();
                                        objclsmarksCriteria.Marks = marks;
                                        StringBuilder sb = new StringBuilder();
                                        foreach (DataRow drowMarkCriteria in drowsmarksCriteria)
                                        {
                                            sb.Append(drowMarkCriteria["Description"].ToString() + " ");
                                        }
                                        objclsmarksCriteria.Description = sb.ToString();
                                        clsclsCompetency.marksCriteria.Add(objclsmarksCriteria);
                                    }

                                    clsclsCompetency.subCompetency = new List<clsSubCompetency>();
                                    DataRow[] drowsSubCompetencies = ds.Tables[2].Select("CompetencyID=" + ComppetencyId + " and ExerciseID=" + ExerciseId);
                                    foreach (DataRow drowSubcom in drowsSubCompetencies)
                                    {
                                        clsSubCompetency objclsSubCompetency = new clsSubCompetency();
                                        objclsSubCompetency.subCompetencyName = drowSubcom["SubCompetencyName"].ToString();
                                        objclsSubCompetency.description = Convert.ToString(drowSubcom["SubCompetencyName"]);
                                        DataRow[] drowsproficiencyLevel = ds.Tables[3].Select("CompetencyID=" + ComppetencyId + " and SubCompetencyID=" + drowSubcom["SubCompetencyID"].ToString());
                                        objclsSubCompetency.proficiencyLevel = new List<clsproficiencyLevel>();
                                        string oldplid = "";
                                        string plid = "0";
                                        string plidDescr = "";
                                        for (int i = 0; i < drowsproficiencyLevel.Length; i++)
                                        {
                                            if (oldplid != "" && drowsproficiencyLevel[i]["plid"].ToString() != oldplid)
                                            {
                                                clsproficiencyLevel objclsproficiencyLevel = new clsproficiencyLevel();
                                                objclsproficiencyLevel.Level = oldplid;
                                                objclsproficiencyLevel.Description = plidDescr;
                                                objclsSubCompetency.proficiencyLevel.Add(objclsproficiencyLevel);
                                                plid = drowsproficiencyLevel[i]["plid"].ToString();
                                                plidDescr = drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                            }
                                            else
                                            {
                                                plid = drowsproficiencyLevel[i]["plid"].ToString();
                                                if (plidDescr == "")
                                                {
                                                    plidDescr = drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                                }
                                                else
                                                {
                                                    plidDescr += " " + drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                                }

                                            }
                                            oldplid = drowsproficiencyLevel[i]["plid"].ToString();
                                        }
                                        if (plidDescr != "")
                                        {
                                            clsproficiencyLevel objclsproficiencyLevel1 = new clsproficiencyLevel();
                                            objclsproficiencyLevel1.Level = oldplid;
                                            objclsproficiencyLevel1.Description = plidDescr;
                                            objclsSubCompetency.proficiencyLevel.Add(objclsproficiencyLevel1);
                                        }

                                        clsclsCompetency.subCompetency.Add(objclsSubCompetency);
                                    }
                                    clsclsassessmentDetails.competency.Add(clsclsCompetency);
                                }
                                //jObject.assessmentDetails.add(jObject1);
                            }

                            clsclsassessmentDetails.assessmentId = ExerciseId;
                            clsclsassessmentDetails.assessmentName = ExerciseName;
                            clsclsassessmentDetails.scheduleID = Convert.ToString(drow["scheduleID"]);
                            clsclsassessmentDetails.assessmentType = Convert.ToString(drow["assessmentType"]);
                            clsclsassessmentDetails.Questions = new List<clsQuestions>();
                            DataRow[] drowsQuestions = ds.Tables[5].Select("ExerciseId=" + ExerciseId);
                            foreach (DataRow drowQst in drowsQuestions)
                            {
                                clsQuestions objclsQuestions = new clsQuestions();
                                objclsQuestions.QstName = drowQst["QuestionText"].ToString();
                                objclsQuestions.Options = new List<clsOptions>();

                                DataRow[] drowsResponseOptions = ds.Tables[7].Select("RspExerciseQstnId=" + drowQst["RspExerciseQstnId"].ToString());
                                DataRow[] drowsOptions = ds.Tables[6].Select("RspExerciseQstnId=" + drowQst["RspExerciseQstnId"].ToString());
                                if (drowsOptions.Length > 0 && drowsResponseOptions.Length > 0)
                                {
                                    foreach (DataRow drowOption in drowsOptions)
                                    {
                                        if (Convert.ToString(drowOption["OptionDescr"]) != "")
                                        {
                                            clsOptions objclsOptions = new clsOptions();
                                            objclsOptions.OptionDescr = drowOption["OptionDescr"].ToString();
                                            objclsOptions.OptionScore = drowOption["OptionScore"].ToString();
                                            objclsOptions.IsSelected = Convert.ToString(drowOption["IsSelected"]) == "1";
                                            objclsQuestions.Options.Add(objclsOptions);
                                        }
                                        else
                                        {
                                            if (drowsResponseOptions.Length > 0)
                                            {
                                                objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                                break;
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    if (drowsResponseOptions.Length > 0)
                                    {
                                        objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                    }
                                }
                                clsclsassessmentDetails.Questions.Add(objclsQuestions);
                            }
                            objclsUserDetailsData.assessmentDetails.Add(clsclsassessmentDetails);
                        }

                    }
                    var body = new JavaScriptSerializer().Serialize(objclsUserDetailsData);
                    string spath = HttpContext.Current.Server.MapPath("~/Log/ReportJson_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".txt");
                    using (var sw = new StreamWriter(spath, true))
                    {
                        //sw.WriteLine(DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + " ");
                        sw.WriteLine(body);
                    }
                    RestClient client = new RestClient(ReportGenerationEY);
                    RestRequest request = new RestRequest(Method.POST);

                    request.AddHeader("Content-Type", "application/json");
                    request.AddHeader("Authorization", "Bearer " + strTokenNo.Split('|')[1]);
                    request.AddParameter("application/json", body.ToString(), "application/json", ParameterType.RequestBody);

                    if (strTokenNo.Split('|')[0] == "1")
                    {
                        var response1 = client.Execute(request);
                        CreateLogfile(response1.Content, true);
                        CreateLogfile(response1.StatusCode.ToString(), true);
                        if (response1.StatusCode == HttpStatusCode.OK)
                        {
                            var data1 = new JavaScriptSerializer().Deserialize<dynamic>(response1.Content);
                            if (data1["objStatusCode"].ToString() == "1")
                            {
                                response = "1|" + data1["Data"].ToString();
                            }
                            else
                            {
                                response = "2|" + data1["Message"].ToString();
                            }
                        }
                        else
                        {
                            response = "2|" + response1.StatusDescription;
                        }
                    }
                    else
                    {
                        response = "2|" + strTokenNo.Split('|')[1];
                    }
                }
            }
        }
        catch (Exception ex)
        {
            response = "2|" + ex.Message;
            CreateLogfile(ex.Message, true);
        }
        finally
        {

        }
        return response;
    }

    public static string sendConsolidatedReportDataToEK(string rspID)
    {
        string response = string.Empty;
        try
        {
            //System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;
            var strTokenNo = GetTokenNo();
            //clsUserDetailsData objclsUserDetailsData = new clsUserDetailsData();
            dynamic objclsUserDetailsData = new JObject();
            int IsBasicInfoAddedd = 0;
            using (SqlConnection sqlConn = new SqlConnection(strConn))
            {

                using (SqlCommand sqlcmd = new SqlCommand("SpAssessmentGetDataForAPI", sqlConn))
                {
                    sqlcmd.Parameters.AddWithValue("@RspId", rspID);
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.CommandTimeout = 0;
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        objclsUserDetailsData.studentName = ds.Tables[0].Rows[0]["studentName"].ToString();
                        objclsUserDetailsData.studentCode = ds.Tables[0].Rows[0]["studentCode"].ToString();
                        objclsUserDetailsData.studentEmail = ds.Tables[0].Rows[0]["studentEmail"].ToString();
                        objclsUserDetailsData.isInstantResultProcess = true;
                        objclsUserDetailsData.clientName = "maruti";
                        objclsUserDetailsData.cycleName = ds.Tables[0].Rows[0]["CycleName"].ToString();
                        objclsUserDetailsData.bandName = ds.Tables[0].Rows[0]["BandName"].ToString();
                        objclsUserDetailsData.assessmentDetails = new JArray() as dynamic;
                        IsBasicInfoAddedd = 1;
                        foreach (DataRow drow in ds.Tables[4].Rows)
                        {
                            dynamic clsclsassessmentDetails = new JObject();
                            string ExerciseId = Convert.ToString(drow["ExerciseId"]);
                            string ExerciseName = Convert.ToString(drow["ExerciseName"]);
                            string RspExerciseID = Convert.ToString(drow["RspExerciseID"]);
                            clsclsassessmentDetails.assessmentId = ExerciseId;
                            clsclsassessmentDetails.assessmentName = ExerciseName;
                            clsclsassessmentDetails.scheduleID = Convert.ToString(drow["scheduleID"]);
                            clsclsassessmentDetails.assessmentType = Convert.ToString(drow["assessmentType"]);
                            clsclsassessmentDetails.competency = new JArray() as dynamic;
                            DataRow[] drowsCompetencies = ds.Tables[1].Select("ExerciseID=" + ExerciseId);
                            if (drowsCompetencies.Length > 0)
                            {
                                foreach (DataRow drowcom in drowsCompetencies)
                                {
                                    dynamic clsclsCompetency = new JObject();
                                    clsclsCompetency.competencyName = drowcom["CompetencyName"].ToString();
                                    clsclsCompetency.description = Convert.ToString(drowcom["CompetencyDescr"]);
                                    string ComppetencyId = Convert.ToString(drowcom["ComppetencyId"]);
                                    clsclsCompetency.marksCriteria = new JArray() as dynamic;

                                    foreach (DataRow drowMark in ds.Tables[8].Rows)
                                    {
                                        string marks = Convert.ToString(drowMark["Score"]);
                                        DataRow[] drowsmarksCriteria = ds.Tables[9].Select("CompetencyID=" + ComppetencyId + " and ExerciseID=" + ExerciseId + " and Score=" + marks);
                                        //clsmarksCriteria objclsmarksCriteria = new clsmarksCriteria();
                                        dynamic objclsmarksCriteria = new JObject();
                                        objclsmarksCriteria.Marks = marks;
                                        StringBuilder sb = new StringBuilder();
                                        foreach (DataRow drowMarkCriteria in drowsmarksCriteria)
                                        {
                                            sb.Append(drowMarkCriteria["Description"].ToString() + " ");
                                        }
                                        objclsmarksCriteria.Description = sb.ToString();
                                        clsclsCompetency.marksCriteria.Add(objclsmarksCriteria);
                                    }

                                    clsclsCompetency.subCompetency = new JArray() as dynamic;
                                    DataRow[] drowsSubCompetencies = ds.Tables[2].Select("CompetencyID=" + ComppetencyId + " and ExerciseID=" + ExerciseId);
                                    foreach (DataRow drowSubcom in drowsSubCompetencies)
                                    {
                                        dynamic objclsSubCompetency = new JObject();
                                        // clsSubCompetency objclsSubCompetency = new clsSubCompetency();
                                        objclsSubCompetency.subCompetencyName = drowSubcom["SubCompetencyName"].ToString();
                                        objclsSubCompetency.description = Convert.ToString(drowSubcom["SubCompetencyName"]);
                                        DataRow[] drowsproficiencyLevel = ds.Tables[3].Select("CompetencyID=" + ComppetencyId + " and SubCompetencyID=" + drowSubcom["SubCompetencyID"].ToString());
                                        objclsSubCompetency.proficiencyLevel = new JArray() as dynamic;
                                        string oldplid = "";
                                        string plid = "0";
                                        string plidDescr = "";
                                        for (int i = 0; i < drowsproficiencyLevel.Length; i++)
                                        {
                                            if (oldplid != "" && drowsproficiencyLevel[i]["plid"].ToString() != oldplid)
                                            {
                                                dynamic objclsproficiencyLevel = new JObject();
                                                // clsproficiencyLevel objclsproficiencyLevel = new clsproficiencyLevel();
                                                objclsproficiencyLevel.Level = oldplid;
                                                objclsproficiencyLevel.Description = plidDescr;
                                                objclsSubCompetency.proficiencyLevel.Add(objclsproficiencyLevel);
                                                plid = drowsproficiencyLevel[i]["plid"].ToString();
                                                plidDescr = drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                            }
                                            else
                                            {
                                                plid = drowsproficiencyLevel[i]["plid"].ToString();
                                                if (plidDescr == "")
                                                {
                                                    plidDescr = drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                                }
                                                else
                                                {
                                                    plidDescr += " " + drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                                }

                                            }
                                            oldplid = drowsproficiencyLevel[i]["plid"].ToString();
                                        }
                                        if (plidDescr != "")
                                        {
                                            dynamic objclsproficiencyLevel1 = new JObject();
                                            //clsproficiencyLevel objclsproficiencyLevel1 = new clsproficiencyLevel();
                                            objclsproficiencyLevel1.Level = oldplid;
                                            objclsproficiencyLevel1.Description = plidDescr;
                                            objclsSubCompetency.proficiencyLevel.Add(objclsproficiencyLevel1);
                                        }

                                        clsclsCompetency.subCompetency.Add(objclsSubCompetency);
                                    }
                                    clsclsassessmentDetails.competency.Add(clsclsCompetency);
                                }
                                //jObject.assessmentDetails.add(jObject1);
                            }


                            clsclsassessmentDetails.Questions = new JArray() as dynamic;
                            DataRow[] drowsQuestions = ds.Tables[5].Select("ExerciseId=" + ExerciseId);
                            foreach (DataRow drowQst in drowsQuestions)
                            {
                                dynamic objclsQuestions = new JObject();
                                //clsQuestions objclsQuestions = new clsQuestions();
                                objclsQuestions.QstName = drowQst["QuestionText"].ToString();
                                objclsQuestions.Options = new JArray() as dynamic;

                                DataRow[] drowsResponseOptions = ds.Tables[7].Select("RspExerciseQstnId=" + drowQst["RspExerciseQstnId"].ToString());
                                DataRow[] drowsOptions = ds.Tables[6].Select("RspExerciseQstnId=" + drowQst["RspExerciseQstnId"].ToString());
                                if (drowsOptions.Length > 0 && drowsResponseOptions.Length > 0)
                                {
                                    foreach (DataRow drowOption in drowsOptions)
                                    {
                                        if (Convert.ToString(drowOption["OptionDescr"]) != "")
                                        {
                                            dynamic objclsOptions = new JObject();
                                            // clsOptions objclsOptions = new clsOptions();
                                            objclsOptions.OptionDescr = drowOption["OptionDescr"].ToString();
                                            objclsOptions.OptionScore = drowOption["OptionScore"].ToString();
                                            objclsOptions.IsSelected = Convert.ToString(drowOption["IsSelected"]) == "1";
                                            objclsQuestions.Options.Add(objclsOptions);
                                        }
                                        else
                                        {
                                            if (drowsResponseOptions.Length > 0)
                                            {
                                                objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                                break;
                                            }
                                            else
                                            {
                                                objclsQuestions.Response = "";
                                            }
                                        }
                                    }
                                }
                                else
                                {
                                    if (drowsResponseOptions.Length > 0)
                                    {
                                        objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                    }
                                    else
                                    {
                                        objclsQuestions.Response = "";
                                    }
                                }
                                clsclsassessmentDetails.Questions.Add(objclsQuestions);
                            }
                            objclsUserDetailsData.assessmentDetails.Add(clsclsassessmentDetails);
                        }
                    }
                }
                

                using (SqlCommand sqlcmd = new SqlCommand("SpAssessmentGetDataForAPI_LifeReflection", sqlConn))
                {
                    sqlcmd.Parameters.AddWithValue("@RspId", rspID);
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.CommandTimeout = 0;
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (IsBasicInfoAddedd == 0)
                        {
                            objclsUserDetailsData.studentName = ds.Tables[0].Rows[0]["studentName"].ToString();
                            objclsUserDetailsData.studentCode = ds.Tables[0].Rows[0]["studentCode"].ToString();
                            objclsUserDetailsData.studentEmail = ds.Tables[0].Rows[0]["studentEmail"].ToString();
                            objclsUserDetailsData.isInstantResultProcess = true;
                            objclsUserDetailsData.clientName = "maruti";
                            objclsUserDetailsData.cycleName = ds.Tables[0].Rows[0]["CycleName"].ToString();
                            objclsUserDetailsData.bandName = ds.Tables[0].Rows[0]["BandName"].ToString();
                            objclsUserDetailsData.assessmentDetails = new JArray() as dynamic;
                            IsBasicInfoAddedd = 1;
                        }
                        foreach (DataRow drow in ds.Tables[1].Rows)
                        {
                            dynamic clsclsassessmentDetails = new JObject();
                            string ExerciseId = Convert.ToString(drow["ExerciseId"]);
                            string ExerciseName = Convert.ToString(drow["ExerciseName"]);
                            string RspExerciseID = Convert.ToString(drow["RspExerciseID"]);
                            clsclsassessmentDetails.assessmentId = ExerciseId;
                            clsclsassessmentDetails.assessmentName = ExerciseName;
                            clsclsassessmentDetails.scheduleID = Convert.ToString(drow["scheduleID"]);
                            clsclsassessmentDetails.assessmentType = Convert.ToString(drow["assessmentType"]);
                            clsclsassessmentDetails.competency = new JArray() as dynamic;
                            DataRow[] drowsCompetencies = ds.Tables[2].Select("ExerciseID=" + ExerciseId);
                            if (drowsCompetencies.Length > 0)
                            {
                                foreach (DataRow drowcom in drowsCompetencies)
                                {
                                    dynamic clsclsCompetency = new JObject();
                                    clsclsCompetency.competencyName = drowcom["CompetencyName"].ToString();
                                    clsclsCompetency.description = Convert.ToString(drowcom["CompetencyDescr"]);
                                    string ComppetencyId = Convert.ToString(drowcom["CompetencyID"]);
                                    clsclsCompetency.marksCriteria = new JArray() as dynamic;

                                    //foreach (DataRow drowMark in ds.Tables[8].Rows)
                                    //{
                                    //    string marks = Convert.ToString(drowMark["Score"]);
                                    //    DataRow[] drowsmarksCriteria = ds.Tables[9].Select("CompetencyID=" + ComppetencyId + " and ExerciseID=" + ExerciseId + " and Score=" + marks);
                                    //    //clsmarksCriteria objclsmarksCriteria = new clsmarksCriteria();
                                    //    dynamic objclsmarksCriteria = new JObject();
                                    //    objclsmarksCriteria.Marks = marks;
                                    //    StringBuilder sb = new StringBuilder();
                                    //    foreach (DataRow drowMarkCriteria in drowsmarksCriteria)
                                    //    {
                                    //        sb.Append(drowMarkCriteria["Description"].ToString() + " ");
                                    //    }
                                    //    objclsmarksCriteria.Description = sb.ToString();
                                    //    clsclsCompetency.marksCriteria.Add(objclsmarksCriteria);
                                    //}

                                    clsclsCompetency.subCompetency = new JArray() as dynamic;
                                    DataRow[] drowsSubCompetencies = ds.Tables[3].Select("CompetencyID=" + ComppetencyId + " and ExerciseID=" + ExerciseId);
                                    foreach (DataRow drowSubcom in drowsSubCompetencies)
                                    {
                                        dynamic objclsSubCompetency = new JObject();
                                        // clsSubCompetency objclsSubCompetency = new clsSubCompetency();
                                        objclsSubCompetency.subCompetencyName = drowSubcom["GroupName"].ToString();
                                        objclsSubCompetency.description = Convert.ToString(drowSubcom["GroupDescr"]);
                                        //DataRow[] drowsproficiencyLevel = ds.Tables[3].Select("CompetencyID=" + ComppetencyId + " and SubCompetencyID=" + drowSubcom["SubCompetencyID"].ToString());
                                        objclsSubCompetency.proficiencyLevel = new JArray() as dynamic;
                                        string oldplid = "";
                                        string plid = "0";
                                        string plidDescr = "";
                                        //for (int i = 0; i < drowsproficiencyLevel.Length; i++)
                                        //{
                                        //    if (oldplid != "" && drowsproficiencyLevel[i]["plid"].ToString() != oldplid)
                                        //    {
                                        //        dynamic objclsproficiencyLevel = new JObject();
                                        //        // clsproficiencyLevel objclsproficiencyLevel = new clsproficiencyLevel();
                                        //        objclsproficiencyLevel.Level = oldplid;
                                        //        objclsproficiencyLevel.Description = plidDescr;
                                        //        objclsSubCompetency.proficiencyLevel.Add(objclsproficiencyLevel);
                                        //        plid = drowsproficiencyLevel[i]["plid"].ToString();
                                        //        plidDescr = drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                        //    }
                                        //    else
                                        //    {
                                        //        plid = drowsproficiencyLevel[i]["plid"].ToString();
                                        //        if (plidDescr == "")
                                        //        {
                                        //            plidDescr = drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                        //        }
                                        //        else
                                        //        {
                                        //            plidDescr += " " + drowsproficiencyLevel[i]["Descr"].ToString() + ".";
                                        //        }

                                        //    }
                                        //    oldplid = drowsproficiencyLevel[i]["plid"].ToString();
                                        //}
                                        //if (plidDescr != "")
                                        //{
                                        //    dynamic objclsproficiencyLevel1 = new JObject();
                                        //    //clsproficiencyLevel objclsproficiencyLevel1 = new clsproficiencyLevel();
                                        //    objclsproficiencyLevel1.Level = oldplid;
                                        //    objclsproficiencyLevel1.Description = plidDescr;
                                        //    objclsSubCompetency.proficiencyLevel.Add(objclsproficiencyLevel1);
                                        //}

                                        clsclsCompetency.subCompetency.Add(objclsSubCompetency);
                                    }
                                    clsclsassessmentDetails.competency.Add(clsclsCompetency);
                                }
                                //jObject.assessmentDetails.add(jObject1);
                            }


                            clsclsassessmentDetails.Questions = new JArray() as dynamic;
                            DataRow[] drowsCompetenciesQstns = ds.Tables[2].Select("ExerciseID=" + ExerciseId);
                            if (drowsCompetenciesQstns.Length > 0)
                            {
                                foreach (DataRow drowcom in drowsCompetenciesQstns)
                                {
                                    DataRow[] drowsQuestions = ds.Tables[4].Select("ExerciseId=" + ExerciseId + " and CompetencyID=" + Convert.ToString(drowcom["CompetencyID"]));
                                    foreach (DataRow drowQst in drowsQuestions)
                                    {
                                        dynamic objclsQuestions = new JObject();
                                        //clsQuestions objclsQuestions = new clsQuestions();
                                        objclsQuestions.Competency = drowcom["CompetencyName"].ToString();
                                        objclsQuestions.SubCompetency = drowQst["SubCompetencyName"].ToString();
                                        objclsQuestions.QstName = drowQst["QuestionText"].ToString();
                                        objclsQuestions.Options = new JArray() as dynamic;

                                        DataRow[] drowsResponseOptions = ds.Tables[6].Select("RspExerciseQstnId=" + drowQst["RspExerciseQstnId"].ToString());
                                        DataRow[] drowsOptions = ds.Tables[5].Select("RspExerciseQstnId=" + drowQst["RspExerciseQstnId"].ToString());
                                        if (drowsOptions.Length > 0 && drowsResponseOptions.Length > 0)
                                        {
                                            foreach (DataRow drowOption in drowsOptions)
                                            {
                                                if (Convert.ToString(drowOption["OptionDescr"]) != "")
                                                {
                                                    dynamic objclsOptions = new JObject();
                                                    // clsOptions objclsOptions = new clsOptions();
                                                    objclsOptions.OptionDescr = drowOption["OptionDescr"].ToString();
                                                    objclsOptions.Score1 = drowOption["OptionScore1"].ToString();
                                                    objclsOptions.Score2 = drowOption["OptionScore2"].ToString();
                                                    objclsOptions.IsSelected = Convert.ToString(drowOption["IsSelected"]) == "1";
                                                    objclsQuestions.Options.Add(objclsOptions);
                                                }
                                                else
                                                {
                                                    if (drowsResponseOptions.Length > 0)
                                                    {
                                                        objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                                        break;
                                                    }
                                                    else
                                                    {
                                                        objclsQuestions.Response = "";
                                                    }
                                                }
                                            }
                                            if (drowsResponseOptions.Length > 0)
                                            {
                                                objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                            }
                                            else
                                            {
                                                objclsQuestions.Response = "";
                                            }
                                        }
                                        else
                                        {
                                            if (drowsResponseOptions.Length > 0)
                                            {
                                                objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                            }
                                            else
                                            {
                                                objclsQuestions.Response = "";
                                            }
                                        }
                                        clsclsassessmentDetails.Questions.Add(objclsQuestions);
                                    }
                                }
                                objclsUserDetailsData.assessmentDetails.Add(clsclsassessmentDetails);
                            }
                        }
                    }
                }

/*
                using (SqlCommand sqlcmd = new SqlCommand("SpAssessmentGetDataForAPI_FunctionalSimulation", sqlConn))
                {
                    sqlcmd.Parameters.AddWithValue("@RspId", rspID);
                    sqlcmd.CommandType = CommandType.StoredProcedure;
                    sqlcmd.CommandTimeout = 0;
                    DataSet ds = new DataSet();
                    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                    da.Fill(ds);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        if (IsBasicInfoAddedd == 0)
                        {
                            objclsUserDetailsData.studentName = ds.Tables[0].Rows[0]["studentName"].ToString();
                            objclsUserDetailsData.studentCode = ds.Tables[0].Rows[0]["studentCode"].ToString();
                            objclsUserDetailsData.studentEmail = ds.Tables[0].Rows[0]["studentEmail"].ToString();
                            objclsUserDetailsData.isInstantResultProcess = true;
                            objclsUserDetailsData.clientName = "adani";
                        objclsUserDetailsData.cycleName = ds.Tables[0].Rows[0]["CycleName"].ToString();
                            objclsUserDetailsData.assessmentDetails = new JArray() as dynamic;
                            IsBasicInfoAddedd = 1;
                        }
                        dynamic clsclsassessmentDetails = new JObject();
                        clsclsassessmentDetails.assessmentType = "Functional Expertise";
                        clsclsassessmentDetails.compentencyWiseQuestions = new JArray() as dynamic;
                        foreach (DataRow drow in ds.Tables[1].Rows)
                        {
                            string ExerciseId = Convert.ToString(drow["ToolId"]);
                            string ExerciseName = Convert.ToString(drow["ToolDescr"]);
                            DataTable drowsSubCompetencies = ds.Tables[2].Select("ToolId=" + ExerciseId).CopyToDataTable().DefaultView.ToTable(true, "SubCompetencyID", "SubCompetencyName");

                            // compentencyWiseQuestions.arrQuestions = new JArray() as dynamic;
                            if (drowsSubCompetencies.Rows.Count > 0)
                            {
                                foreach (DataRow drowcom in drowsSubCompetencies.Rows)
                                {
                                    string SubCompetencyID = Convert.ToString(drowcom["SubCompetencyID"]);
                                    string SubCompetencyName = Convert.ToString(drowcom["SubCompetencyName"]);

                                    DataRow[] drowsQuestions = ds.Tables[3].Select("ToolId=" + ExerciseId + " and SubCompetencyID=" + SubCompetencyID);
                                    foreach (DataRow drowQst in drowsQuestions)
                                    {
                                        dynamic objclsQuestions = new JObject();
                                        //clsQuestions objclsQuestions = new clsQuestions();
                                        objclsQuestions.Competency = ExerciseName;
                                        objclsQuestions.SubCompetency = SubCompetencyName;
                                        objclsQuestions.QstName = drowQst["QuestionText"].ToString();
                                        objclsQuestions.Options = new JArray() as dynamic;

                                        DataRow[] drowsResponseOptions = ds.Tables[5].Select("RspExerciseQstnId=" + drowQst["RspExerciseQstnId"].ToString());
                                        DataRow[] drowsOptions = ds.Tables[4].Select("RspExerciseQstnId=" + drowQst["RspExerciseQstnId"].ToString());
                                        if (drowsOptions.Length > 0 && drowsResponseOptions.Length > 0)
                                        {
                                            foreach (DataRow drowOption in drowsOptions)
                                            {
                                                if (Convert.ToString(drowOption["OptionDescr"]) != "")
                                                {
                                                    dynamic objclsOptions = new JObject();
                                                    // clsOptions objclsOptions = new clsOptions();
                                                    objclsOptions.OptionDescr = drowOption["OptionDescr"].ToString();
                                                    objclsOptions.OptionScore = drowOption["OptionScore"].ToString();
                                                    objclsOptions.IsSelected = Convert.ToString(drowOption["IsSelected"]) == "1";
                                                    objclsQuestions.Options.Add(objclsOptions);
                                                }
                                                else
                                                {
                                                    if (drowsResponseOptions.Length > 0)
                                                    {
                                                        objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                                        break;
                                                    }
                                                    else
                                                    {
                                                        objclsQuestions.Response = "";
                                                    }
                                                }
                                            }
                                            if (drowsResponseOptions.Length > 0)
                                            {
                                                objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                            }
                                            else
                                            {
                                                objclsQuestions.Response = "";
                                            }
                                        }
                                        else
                                        {
                                            if (drowsResponseOptions.Length > 0)
                                            {
                                                objclsQuestions.Response = Convert.ToString(drowsResponseOptions[0]["Response"]);
                                            }
                                            else
                                            {
                                                objclsQuestions.Response = "";
                                            }
                                        }
                                        clsclsassessmentDetails.compentencyWiseQuestions.Add(objclsQuestions);
                                    }
                                }

                                // clsclsassessmentDetails.compentencyWiseQuestions.Add(compentencyWiseQuestions);
                            }
                        }
                        objclsUserDetailsData.assessmentDetails.Add(clsclsassessmentDetails);
                    }
                }

                */

                var body = objclsUserDetailsData.ToString(); // new JavaScriptSerializer().Serialize(objclsUserDetailsData);
string logfilename="ReportJson_"+ rspID+"_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".txt";
                string spath = HttpContext.Current.Server.MapPath("~/Log/"+logfilename);
                using (var sw = new StreamWriter(spath, true))
                {
                    //sw.WriteLine(DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + " ");
                    sw.WriteLine(body);
                }
                RestClient client = new RestClient(ReportGenerationEY);
                RestRequest request = new RestRequest(Method.POST);

                request.AddHeader("Content-Type", "application/json");
                request.AddHeader("Authorization", "Bearer " + strTokenNo.Split('|')[1]);
                request.AddParameter("application/json", body.ToString(), "application/json", ParameterType.RequestBody);

                if (strTokenNo.Split('|')[0] == "1")
                {
                    var response1 = client.Execute(request);
                    //CreateLogfile(response1.Content, true);
                    //CreateLogfile(response1.StatusCode.ToString(), true);
                    if (response1.StatusCode == HttpStatusCode.OK)
                    {
                        var data1 = new JavaScriptSerializer().Deserialize<dynamic>(response1.Content);
                        if (data1["objStatusCode"].ToString() == "1")
                        {
                            try
                            {
                                response = "1|" + Convert.ToString(data1["Data"]["ReportURL"]) + "^" + Convert.ToString(data1["Data"]["MindsetReportURL"]) + "^" + Convert.ToString(data1["Data"]["PenPictureReportURL"]) + "^" + Convert.ToString(data1["Data"]["TalentSnapshotURL"]);
                                using (SqlCommand sqlcmd = new SqlCommand("spUpdateAIReportURL", sqlConn))
                                {
                                    sqlcmd.Parameters.AddWithValue("@RspId", rspID);
                                    sqlcmd.Parameters.AddWithValue("@DetailedFeedbackReport", Convert.ToString(data1["Data"]["ReportURL"]));
                                    sqlcmd.Parameters.AddWithValue("@MindsetReportURL", Convert.ToString(data1["Data"]["MindsetReportURL"]));
                                    sqlcmd.Parameters.AddWithValue("@PenPictureReportURL", Convert.ToString(data1["Data"]["PenPictureReportURL"]));
                                    sqlcmd.Parameters.AddWithValue("@TalentSnapshotURL", Convert.ToString(data1["Data"]["TalentSnapshotURL"]));
                                    sqlcmd.CommandType = CommandType.StoredProcedure;
                                    sqlcmd.CommandTimeout = 0;
                                    DataTable dt = new DataTable();
                                    SqlDataAdapter da = new SqlDataAdapter(sqlcmd);
                                    da.Fill(dt);
                                }
                            }catch(Exception ex)
                            {
                                response = "2|" + ex.Message + "<br><a href='../../Log/" + logfilename + "' style='color:blue' target='_blank' download>Download JSON</a>";
                            }
                        }
                        else
                        {
                            response = "2|" + data1["Message"].ToString()+"<br><a href='../../Log/"+logfilename+"' style='color:blue' target='_blank' download>Download JSON</a>";
                        }
                    }
                    else
                    {
                        response = "2|" + response1.StatusDescription+"<br><a href='../../Log/"+logfilename+"' style='color:blue' target='_blank' download>Download JSON</a>";
                    }
                }
                else
                {
                    response = "2|" + strTokenNo.Split('|')[1];
                }
            }
        }
        catch (Exception ex)
        {
            response = "2|" + ex.Message;
            CreateLogfile(ex.Message, true);
        }
        finally
        {

        }
        return response;
    }


    public static string sendConsolidatedUserDataToEK(System.Data.DataTable dt, int CycleID)
    {
        string response = string.Empty;
        try
        {
            clsUserMappingDetailsToEK objclsUserDetailsData = new clsUserMappingDetailsToEK();
            objclsUserDetailsData.userdetails = new List<clsuserdetails>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                clsuserdetails objclsuserdetails = new clsuserdetails();
                objclsuserdetails.CandidateID = dt.Rows[i]["ParticipantId"].ToString();
                objclsuserdetails.CandidateEmail = dt.Rows[i]["ParticipantMailID"].ToString();
                objclsuserdetails.CandidateName = dt.Rows[i]["ParticipantName"].ToString();
                objclsuserdetails.designation = dt.Rows[i]["Designation"].ToString();
                objclsUserDetailsData.userdetails.Add(objclsuserdetails);
            }
            var strTokenNo = GetTokenNo();
            CreateLogfile(strTokenNo, true);
            var body = new JavaScriptSerializer().Serialize(objclsUserDetailsData);
            RestClient client = new RestClient(CreateCandidateDataEY);
            RestRequest request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");
            request.AddHeader("Authorization", "Bearer " + strTokenNo.Split('|')[1]);
            request.AddParameter("application/json", body.ToString(), "application/json", ParameterType.RequestBody);
           
            if (strTokenNo.Split('|')[0] == "1")
            {
                var response1 = client.Execute(request);
                
                CreateLogfile("response1.StatusCode:" + response1.StatusCode, true);

                if (response1.StatusCode == HttpStatusCode.OK)
                {
                    var data1 = new JavaScriptSerializer().Deserialize<dynamic>(response1.Content);
                    if (data1["objStatusCode"].ToString() == "1")
                    {
                        //foreach(var dd in data1["Data"])
                        //{
                        string ss = new JavaScriptSerializer().Serialize(data1["Data"]["UserDetails"]);
                        DataTable repDT = JsonConvert.DeserializeObject<DataTable>(ss);
                        using (SqlConnection sqlConn = new SqlConnection(strConn))
                        {
                            using (SqlCommand sqlcmd = new SqlCommand("spCreateParticipantMappingWithEK", sqlConn))
                            {
                                sqlcmd.Parameters.AddWithValue("@UserMappingDT", repDT);
                                sqlcmd.Parameters.AddWithValue("@CycleID", CycleID);
                                sqlcmd.CommandType = CommandType.StoredProcedure;
                                sqlcmd.CommandTimeout = 0;
                                sqlConn.Open();
                                sqlcmd.ExecuteNonQuery();
                                sqlConn.Close();
                            }
                        }
                        //}

                        response = "1|Mapped Successfully";
                    }
                    else
                    {
                        response = "2|" + data1["Message"].ToString();
                    }
                }
                else
                {
                    response = "2|" + response1.StatusDescription;
                }
            }
            else
            {
                response = "2|" + strTokenNo.Split('|')[1];
            }


        }
        catch (Exception ex)
        {
            response = "2|" + ex.Message;
            CreateLogfile(ex.Message, true);
        }
        finally
        {

        }
        CreateLogfile(response, true);
        return response;
    }

    public static string fnAssignCandidateToExamEY(DataTable dt, string CycleID, string LoginId)
    {
        string response = string.Empty;
        try
        {
            clsTestMappingWithParticipants clsObj = new clsTestMappingWithParticipants();
            clsObj.userdetails = new List<clsuserExercisedetails>();
            for (int i = 0; i < dt.Rows.Count; i++)
            {

                clsuserExercisedetails objcls = new clsuserExercisedetails();
                objcls.CandidateCode = dt.Rows[i]["CandidateCode"].ToString();
                objcls.ExerciseCode = dt.Rows[i]["ExerciseCode"].ToString();
                objcls.ScheduleID = dt.Rows[i]["ScheduleID"].ToString();
                clsObj.userdetails.Add(objcls);
            }
            var strTokenNo = GetTokenNo();

            var body = new JavaScriptSerializer().Serialize(clsObj);
            RestClient client = new RestClient(AssignCandidateToExamEY);
            RestRequest request = new RestRequest(Method.POST);

            request.AddHeader("Content-Type", "application/json");
            request.AddHeader("Authorization", "Bearer " + strTokenNo.Split('|')[1]);
            request.AddParameter("application/json", body.ToString(), "application/json", ParameterType.RequestBody);

            if (strTokenNo.Split('|')[0] == "1")
            {
                var response1 = client.Execute(request);
                if (response1.StatusCode == HttpStatusCode.OK)
                {
                    var data1 = new JavaScriptSerializer().Deserialize<dynamic>(response1.Content);
                    if (data1["objStatusCode"].ToString() == "1")
                    {
                        //foreach(var dd in data1["Data"])
                        //{
                        string ss = new JavaScriptSerializer().Serialize(data1["Data"]["UserDetails"]);
                        DataTable repDT = JsonConvert.DeserializeObject<DataTable>(ss);
                        using (SqlConnection sqlConn = new SqlConnection(strConn))
                        {
                            using (SqlCommand sqlcmd = new SqlCommand("spAssignCandidateToExamEK", sqlConn))
                            {
                                sqlcmd.Parameters.AddWithValue("@UserMappingDT", repDT);
                                sqlcmd.Parameters.AddWithValue("@CycleID", CycleID);
                                sqlcmd.CommandType = CommandType.StoredProcedure;
                                sqlcmd.CommandTimeout = 0;
                                sqlConn.Open();
                                sqlcmd.ExecuteNonQuery();
                                sqlConn.Close();
                            }
                        }
                        //}

                        response = "1|Exam Assigned Successfully";
                    }
                    else
                    {
                        response = "2|" + data1["Message"].ToString();
                    }
                }
                else
                {
                    response = "2|" + response1.StatusDescription;
                }
            }
            else
            {
                response = "2|" + strTokenNo.Split('|')[1];
            }
        }
        catch (Exception ex)
        {
            response = "2|" + ex.Message;
            CreateLogfile(ex.Message, true);
        }
        finally
        {

        }
        return response;
    }


    public class clsUserDetailsData
    {
        public string studentName { get; set; }
        public string studentCode { get; set; }
        public string studentEmail { get; set; }
        public bool isInstantResultProcess { get; set; }
        public string clientName { get; set; }

        public List<clsassessmentDetails> assessmentDetails { get; set; }
    }
    public class clsassessmentDetails
    {
        public string assessmentId { get; set; }
        public string assessmentName { get; set; }
        public string scheduleID { get; set; }
        public string assessmentType { get; set; }
        public List<clsCompetency> competency { get; set; }
        public List<clsQuestions> Questions { get; set; }
    }

    public class clsCompetency
    {
        public string competencyName { get; set; }
        public string description { get; set; }
        public List<clsmarksCriteria> marksCriteria { get; set; }
        public List<clsSubCompetency> subCompetency { get; set; }
    }

    public class clsmarksCriteria
    {
        public string Marks { get; set; }
        public string Description { get; set; }
    }

    public class clsSubCompetency
    {
        public string subCompetencyName { get; set; }
        public string description { get; set; }
        public List<clsproficiencyLevel> proficiencyLevel { get; set; }
    }

    public class clsproficiencyLevel
    {
        public string Level { get; set; }
        public string Description { get; set; }
    }

    public class clsQuestions
    {
        public string QstName { get; set; }
        public List<clsOptions> Options { get; set; }
        public string Response { get; set; }
    }
    public class clsOptions
    {
        public string OptionDescr { get; set; }
        public string OptionScore { get; set; }
        public bool IsSelected { get; set; }
    }

    public class clsUserMappingDetailsToEK
    {
        public List<clsuserdetails> userdetails { get; set; }
    }

    public class clsuserdetails
    {
        public string CandidateID { get; set; }
        public string CandidateName { get; set; }
        public string CandidateEmail { get; set; }
        public string designation { get; set; }
    }

    public class clsTestMappingWithParticipants
    {
        public List<clsuserExercisedetails> userdetails { get; set; }
    }

    public class clsuserExercisedetails
    {
        public string CandidateCode { get; set; }
        public string ExerciseCode { get; set; }
        public string ScheduleID { get; set; }
    }

    public static void CreateLogfile(string strMsg, bool IsWeb)
    {
        string RspID = HttpContext.Current.Session["RspID"] == null ? "0" : Convert.ToString(HttpContext.Current.Session["RspID"]);
        string spath = HttpContext.Current.Server.MapPath("~/Log/DailyLog_" + RspID + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".txt");
        using (var sw = new StreamWriter(spath, true))
        {
            sw.WriteLine(DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + " ");
            sw.WriteLine(strMsg);
        }
    }

}
