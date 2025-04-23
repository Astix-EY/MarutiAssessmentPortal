using Newtonsoft.Json;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.UI.WebControls;

public partial class _default : System.Web.UI.Page
{
    #region Declare protected Method
    protected void Page_Load(object sender, EventArgs e)
    {
        //if (Session["LoginID"] == null || Session["LoginID"].ToString() == "")
        //        Response.Redirect("Login.aspx");
        if (!IsPostBack)
        {

            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "spGetAssessmentCycleDetail";
            Scmd.Parameters.AddWithValue("@CycleID", 0);
            Scmd.Parameters.AddWithValue("@Flag", 0);
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.CommandTimeout = 0;
            SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
            DataTable dt = new DataTable();
            Sdap.Fill(dt);
            System.Web.UI.WebControls.ListItem itm;//= new ListItem();
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dr in dt.Rows)
                {
                    itm = new System.Web.UI.WebControls.ListItem();
                    itm.Text = dr["CycleName"].ToString() + " (" + Convert.ToDateTime(dr["CycleStartDate"]).ToString("dd MMM yy") + ")";
                    itm.Value = dr["CycleId"].ToString();
                    ddlCycleName.Items.Add(itm);
                }
            }
            else
            {
                itm = new System.Web.UI.WebControls.ListItem();
                itm.Text = "No cycle mapped";
                itm.Value = "0";
                ddlCycleName.Items.Add(itm);
            }
            fnFIllEMpDD();




            //Panel panelLogout;
            //panelLogout = (Panel)Page.Master.FindControl("panelLogout");
            //panelLogout.Visible = false;
        }

       // Gettbl(0);
    }
    #endregion

    #region Public Static Webmethod Method

    
    public void Gettbl()
    {
        int EmpNodeId = int.Parse(ddlEmployee.SelectedValue);
        int CycleId = int.Parse(ddlCycleName.SelectedValue);
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "SpRptProctoringData";
        Scmd.Parameters.AddWithValue("@CycleId", CycleId);
        Scmd.Parameters.AddWithValue("@EmpNodeId", EmpNodeId);
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet ds = new DataSet();
        Sdap.Fill(ds);
        DataListMeasure1.Visible = true;
        DataListMeasure1.DataSource = ds.Tables[0];
        DataListMeasure1.DataBind();

       

        //StringBuilder sb = new StringBuilder();

        //sb.Append("<table cellpadding='0' cellspacing='0' valign='middle' id='tblSnapshots' class='table-striped' style='margin: 0 auto;'>");
        //sb.Append("<thead>");

        //sb.Append("<tr style='background-color: #26A6E7;color:#fff;'>");
        ////sb.Append("<th>#</th>");
        //sb.Append("<th style='text-align:center;'>Employee</th>");
        //sb.Append("<th style='text-align:center;'>Assesment</th>");
        //sb.Append("<th style='text-align:center;'>Snapshot Time</th>");
        //sb.Append("<th style='text-align:center;'>Snapshot</th>");
        //sb.Append("</tr>");

        //sb.Append("</thead>");
        //sb.Append("<tbody>");

        //int count = 1;
        //foreach (DataRow dr in ds.Tables[0].Rows)
        //{
        //    sb.Append("<tr>");
        //    //sb.Append("<td>" + count + "</td>");
        //    sb.Append("<td>" + dr["FullName"].ToString() + "</td>");
        //    sb.Append("<td>" + dr["Descr"].ToString() + "</td>");
        //    sb.Append("<td>" + Convert.ToDateTime(dr["PicTakenTime"].ToString()).ToString("dd-MMM-yyyy HH:mm:ss") + "</td>");
        //    sb.Append("<td><img Path='" + "Snapshot/" + dr["PicName"].ToString() + "' style='height:50px; width:60px;cursor:pointer;' title='Large View' onclick='fnViewLargeImage(this)' src='" + "Snapshot/" + dr["PicName"].ToString() + "' /></td>");
        //    sb.Append("</tr>");

        //    count++;
        //}

        //sb.Append("</tbody>");
        //sb.Append("</table>");

        //return sb.ToString();
    }
    #endregion

    protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        Gettbl();
    }

   public void fnFIllEMpDD()
    {
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "spGetEmployeeListForWebCam";
        int CycleId = int.Parse(ddlCycleName.SelectedValue);
        Scmd.Parameters.AddWithValue("@CycleId", CycleId);
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        DataSet ds = new DataSet();
        Sdap.Fill(ds);
        ddlEmployee.Items.Clear();
        ddlEmployee.Items.Add(new ListItem("All", "0"));
        ddlEmployee.Visible = true;
        ddlEmployee.DataSource = ds.Tables[0];
        ddlEmployee.DataBind();
    }

    protected void ddlCycleName_SelectedIndexChanged(object sender, EventArgs e)
    {

        fnFIllEMpDD();
      
        Gettbl();
    }
}