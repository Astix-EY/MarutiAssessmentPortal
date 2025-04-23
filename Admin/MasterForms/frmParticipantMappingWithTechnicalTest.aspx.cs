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
using System.Net.Mail;
using System.Net;
using DataTable = System.Data.DataTable;
using Formatting = Newtonsoft.Json.Formatting;
using RestSharp;
using System.Web.Script.Serialization;
using Newtonsoft.Json.Linq;

public partial class frmParticipantMappingWithTechnicalTest : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginId"] != null && Session["LoginId"].ToString() != "")
        {
            if (!IsPostBack)
            {
                hdnLogin.Value = Session["LoginId"].ToString();
                GetMaster();
            }
        }
        else
        {
            Response.Redirect("../../Login.aspx");
        }
    }

    private void GetMaster()
    {
        SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spGetAssessmentCycleDetail";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        Scmd.Parameters.AddWithValue("@CycleID", 0);
        Scmd.Parameters.AddWithValue("@Flag", 0);
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataTable dtBatch = new DataTable();
        Sdap.Fill(dtBatch);
        Scmd.Dispose();
        Sdap.Dispose();

        ddlBatch.Items.Add(new ListItem("-- Select --", "0"));
        foreach (DataRow dr in dtBatch.Rows)
        {
            ddlBatch.Items.Add(new ListItem(dr["CycleName"].ToString(), dr["CycleId"].ToString()));
        }
    }
    [System.Web.Services.WebMethod()]
    public static string fnGetEntries(string CycleId, string TypeId)
    {
        SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spAssessmentGetDetailsForCycleMappingWithUser";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.Parameters.AddWithValue("@CycleId", CycleId);
        Scmd.Parameters.AddWithValue("@TypeId", TypeId);
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet Ds = new DataSet();
        Sdap.Fill(Ds);
        Scmd.Dispose();
        Sdap.Dispose();

        string strDTTest = JsonConvert.SerializeObject(Ds.Tables[2], Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });

        StringBuilder sbddl2 = new StringBuilder();

        DataTable dtTest = Ds.Tables[3];
        //  sbddl2.Append("<option value='0'>-- Select --</option>");
        for (int i = 0; i < dtTest.Rows.Count; i++)
        {
            sbddl2.Append("<option flg='0' value='"+ dtTest.Rows[i]["ExerciseID"]  + "' EKExerciseCode='" + dtTest.Rows[i]["EKExerciseCode"] + "'  ScheduleID='" + dtTest.Rows[i]["ScheduleID"] + "'>" + dtTest.Rows[i]["TestName"] + "</option>");
        }

        StringBuilder sb = new StringBuilder();
        sb.Append("<table class='table table-bordered table-sm text-center' id='tblMapping'>");
        sb.Append("<thead class='thead-light text-center'>");
        sb.Append("<tr>");
        sb.Append("<th>#</th>");
        // sb.Append("<th><label style='margin:0'><input type='checkbox'> ALL</label></th>");
       
        sb.Append("<th>Participant</th>");
        //if (TypeId == "1")
        //{
            sb.Append("<th style='width:200px'>Test</th>");
            //sb.Append("<th>Action</th>");
       // }
        sb.Append("</tr>");
        sb.Append("</thead>");
        sb.Append("<tbody>");
        for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
        {
            sb.Append("<tr empnodeid='" + Ds.Tables[0].Rows[i]["empnodeid"].ToString() + "' CandidateCode='" + Ds.Tables[0].Rows[i]["EmpCode"].ToString() + "'>");
            sb.Append("<td>" + (i + 1).ToString() + "</td>");
            sb.Append("<td style='text-align:left'>" + Ds.Tables[0].Rows[i]["EmpName"].ToString() + " ( " + Ds.Tables[0].Rows[i]["EmpCode"].ToString() + " )</td>");
            sb.Append("<td><select iden='test'  style='width:300px;height:28px' multiple='true' class='clsmultiple'>" + sbddl2.ToString() + "</select></td>");
            sb.Append("</tr>");
        }
        sb.Append("<tbody>");
        sb.Append("</table>");

        return sb.ToString() + "|" + Ds.Tables[1].Rows[0][0].ToString() + "|" + strDTTest + "|" + sbddl2.ToString();
    }
    [System.Web.Services.WebMethod()]
    public static string fnRemoveSlot(string CycleId, string SeqNo, object obj, string flgtoKeepSlot, string LoginId)
    {
        try
        {
            string str = JsonConvert.SerializeObject(obj, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            DataTable tbl = JsonConvert.DeserializeObject<DataTable>(str);

            SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "spRemoveParticipantFromBatchMapping";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@CycleId", CycleId);
            Scmd.Parameters.AddWithValue("@SeqNo", SeqNo);
            Scmd.Parameters.AddWithValue("@tblUserList", tbl);
            Scmd.Parameters.AddWithValue("@flgtoKeepSlot", flgtoKeepSlot);
            Scmd.Parameters.AddWithValue("@LoginId", LoginId);
            Scmd.CommandTimeout = 0;
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            DataSet Ds = new DataSet();
            Sdap.Fill(Ds);
            Scmd.Dispose();
            Sdap.Dispose();
            return "0^" + Ds.Tables[0].Rows[0]["IsMeetingCreated"].ToString();
        }
        catch (Exception e)
        {
            return ("1");
        }
    }
    [System.Web.Services.WebMethod()]
    public static string fnSave(string CycleId, string TypeId, object objTest, string LoginId)
    {
        try
        {
            string strResult = "1|";
            DataTable tb11 = new DataTable();

            string str1 = JsonConvert.SerializeObject(objTest, Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
            tb11 = JsonConvert.DeserializeObject<DataTable>(str1);
            if (tb11.Rows[0][0].ToString() == "0")
            {
                tb11.Rows.Clear();
            }

            strResult = clsHttpRequest.fnAssignCandidateToExamEY(tb11, CycleId, LoginId);
            return strResult;
        }
        catch (Exception e)
        {
            return ("2|" + e.Message);
        }
    }
}