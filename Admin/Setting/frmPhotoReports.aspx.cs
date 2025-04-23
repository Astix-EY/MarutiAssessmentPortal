
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class frmDataAndReports : System.Web.UI.Page
{


    protected void Page_Load(object sender, EventArgs e)
    {
        // Session["LoginId"] = "1";
        if (Session["LoginId"] != null)
        {
            hdnRoleId.Value = Session["RoleId"].ToString();
            hdnLogin.Value = Session["LoginId"].ToString();
            fnfillCycleDropDown();

        }
        else
        {
            Response.Write("<script>window.top.location.href = '../../Login.aspx'</script>");

        }
    }

    private void fnfillCycleDropDown()
    {

        SqlConnection Scon = new SqlConnection(ConfigurationManager.ConnectionStrings["strConn"].ConnectionString);
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
        //itm.Text = "All";
        //itm.Value = "0";
        //ddlCycle.Items.Add(itm);
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

    }

    [System.Web.Services.WebMethod()]
    public static string frmGetStatus(string loginId, int bandid, string CycleID)
    {
        DataSet ds = new DataSet();
        SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;

        Scmd.CommandText = "[SpRptProctoring]";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        Scmd.Parameters.AddWithValue("@CycleId", CycleID);
        //Scmd.Parameters.AddWithValue("@LoginId",  loginId);
        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        Sdap.Fill(ds);
        HttpContext.Current.Session["dsRptProctoring"] = ds;
        return createStoretbl(ds, 1, true);
    }
    private static string createStoretbl(DataSet ds, int headerlvl, bool IsHeader)
    {
        StringBuilder sbColor = new StringBuilder();
        DataTable dt = ds.Tables[0];
        // dt.Columns.Add("User Response");
        string[] SkipColumn = null;

        SkipColumn = new string[3];
        SkipColumn[0] = "EmpID";
        SkipColumn[1] = "ColorCode_NoFace";
        SkipColumn[2] = "ColorCode_Instance";


        if (ds.Tables[0].Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<table id='tbl_Status' class='table table-bordered table-sm' >");
            sb.Append("<thead>");

            sb.Append("<tr>");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                if (!SkipColumn.Contains(ds.Tables[0].Columns[j].ColumnName.ToString()))
                {
                    sb.Append("<th>" + dt.Columns[j].ColumnName + " </th>");
                }
            }
            //sb.Append("<th></th>");
            sb.Append("</tr>");

            sb.Append("</thead>");
            sb.Append("<tbody>");

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                sb.Append("<tr empid='" + ds.Tables[0].Rows[i]["empid"].ToString() + "' AssessmentDate='" + ds.Tables[0].Rows[i]["Assessment Date"].ToString() + "'>");
                for (int j = 0; j < ds.Tables[0].Columns.Count; j++)
                {
                    string sColumnName = ds.Tables[0].Columns[j].ColumnName.ToString();
                    if (!SkipColumn.Contains(sColumnName))
                    {
                        if(sColumnName== "View")
                        {
                            sb.Append("<td style='text-align:left'><a href='###' onclick='fnSHowImg(this)'>Show Images</a></td>");
                        }else if (sColumnName == "Images With No Face")
                        {
                            sb.Append("<td style='text-align:center;background-color:"+ ds.Tables[0].Rows[i]["ColorCode_NoFace"].ToString() + "'  Searchable='1'>" + ds.Tables[0].Rows[i][j].ToString() + "</td>");
                        }
                        else if (sColumnName == "Instance With Lost Focus")
                        {
                            sb.Append("<td style='text-align:center;background-color:" + ds.Tables[0].Rows[i]["ColorCode_Instance"].ToString() + "'  Searchable='1'>" + ds.Tables[0].Rows[i][j].ToString() + "</td>");
                        }
                        else if (sColumnName == "Violation")
                        {
                            sb.Append("<td style='text-align:center' ><label for='chkNoViolation" + i.ToString() + "' class='switch'><input type='checkbox' id='chkNoViolation" + i.ToString()+ "' "+(ds.Tables[0].Rows[i][j].ToString()=="1"?"checked='checked'":"")+ " onchange='fnSaveValidate(this)' ><span class='slider round'></span></label></td>");
                        }
                        else
                        {
                            sb.Append("<td style='text-align:left'  Searchable='1'>" + ds.Tables[0].Rows[i][j].ToString() + "</td>");
                        }
                        
                    }
                }
                
                sb.Append("</tr>");
            }
            sb.Append("</tbody>");
            sb.Append("</table>");
            return sb.ToString() + "|" + JsonConvert.SerializeObject(ds.Tables[1], Formatting.Indented, new JsonSerializerSettings { ReferenceLoopHandling = ReferenceLoopHandling.Ignore });
        }
        else
        {
            return "<div style='font-size:13px; padding : 10px 20px; color:red; font-weight:bold;'>No Record Found !</div>";
        }
    }

    [System.Web.Services.WebMethod()]
    public static string fnSave(string EmpID,string AssessmentDate, string LoginId, int flgValidate)
    {
        try
        {
            HttpContext.Current.Session["LoginId"] = LoginId;
            
            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "[SpSaveParticipant]";
            Scmd.CommandType = CommandType.StoredProcedure;
            Scmd.Parameters.AddWithValue("@EmpID", EmpID);
            Scmd.Parameters.AddWithValue("@LoginId", LoginId);
            Scmd.Parameters.AddWithValue("@flgValidate", flgValidate);
            Scmd.Parameters.AddWithValue("@AssessmentDate", AssessmentDate);
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
}