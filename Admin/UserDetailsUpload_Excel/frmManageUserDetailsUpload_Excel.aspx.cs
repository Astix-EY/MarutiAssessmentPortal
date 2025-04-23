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

public partial class frmBulkUploadQuestionnaire_Excel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginId"] != null && Session["LoginId"].ToString() != "")
        {
            if (!IsPostBack)
            {
                int EngagementId = Request.QueryString["EngagementId"] == null ? 0 : Convert.ToInt32(Request.QueryString["EngagementId"]);
                hdnEngagementId.Value = EngagementId.ToString();
                int EngagementAssessmentId = Request.QueryString["EngagementAssessmentId"] == null ? 0 : Convert.ToInt32(Request.QueryString["EngagementAssessmentId"]);
                hdnEngagementAssessmentId.Value = EngagementAssessmentId.ToString();

                //spnEngagementName.InnerHtml = Request.QueryString["EngagementName"].ToString();
                //spnAssessmentName.InnerHtml = Request.QueryString["AssessmentName"].ToString();

                //string EngagementName = Request.QueryString["EngagementName"].ToString();
                //hdnEngagementName.Value = EngagementName.ToString();
                //string EngagementAssessmentName = Request.QueryString["AssessmentName"].ToString();
                //hdnEngagementAssessmentName.Value = EngagementAssessmentName.ToString();


                hdnLogin.Value = Session["LoginId"].ToString();
            }
        }
        else
        {
            Response.Redirect("../../Login.aspx");
        }

    }

    [System.Web.Services.WebMethod()]
    public static string fnFinalSubmit(string EngagementId, string EngagementAssessmentId, string LoginId)
    {
        try
        {
          
            StringBuilder sb = new StringBuilder();
            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "spSaveUploadedUserList";
            Scmd.CommandType = CommandType.StoredProcedure;
        
           // Scmd.Parameters.AddWithValue("@EngagementAssessmentId", Convert.ToInt32(EngagementAssessmentId));
            Scmd.Parameters.AddWithValue("@LoginId", Convert.ToInt32(LoginId));

            Scmd.CommandTimeout = 0;
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            DataSet Ds = new DataSet();
            Sdap.Fill(Ds);
            return "0|";
        }
        catch (Exception e)
        {
            return ("1|" + e.Message);
        }
    }

}