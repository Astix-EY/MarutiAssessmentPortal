using System;
using System.Collections;
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
using System.Xml;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;


public partial class frmTestStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string spath = HttpContext.Current.Server.MapPath("~/Log/DailyLog_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ".txt");
/*       
 using (var sw = new StreamWriter(spath,true))
        {
            sw.WriteLine(DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + " ");
            sw.WriteLine("Total Query:" + Request.QueryString.Count);

        }
*/
        if (Request.QueryString.Count > 0)
        {
            string emailid = Request.QueryString["CandidateCode"] !=null?Convert.ToString(Request.QueryString["CandidateCode"]):"";
            string status = Request.QueryString["status"] != null ? Convert.ToString(Request.QueryString["status"]) : "";
            string complitionOn = Request.QueryString["complitionOn"] != null ? Convert.ToString(Request.QueryString["complitionOn"]) : "";
            string testid = Request.QueryString["ExerciseCode"] != null ? Convert.ToString(Request.QueryString["ExerciseCode"]) : ""; 

/*
            using (var sw = new StreamWriter(spath, true))
            {
                sw.WriteLine(DateTime.Now.ToString("dd-MM-yyyy HH:mm:ss") + " ");
                sw.WriteLine("CandidateCode:" + emailid);
                sw.WriteLine("status:" + status);
                sw.WriteLine("ExerciseCode:" + testid);
                sw.WriteLine("complitionOn:" + complitionOn);
                sw.WriteLine("-------------------------------------------------------------------------------------------------------");
            }
*/
            string IsUpdated = "1";
            if (status == "2" && emailid!="" && testid != "")
            {
                SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
                SqlCommand Scmd = new SqlCommand();
                Scmd.Connection = Scon;
                Scmd.CommandText = "[spCloseExternalExercise]";
                Scmd.CommandType = CommandType.StoredProcedure;
                Scmd.CommandTimeout = 0;
                Scmd.Parameters.AddWithValue("@candidateCode", emailid);
                Scmd.Parameters.AddWithValue("@Status", status);
                Scmd.Parameters.AddWithValue("@TestId", testid);
                Scmd.Parameters.AddWithValue("@complitionOn", complitionOn);
                SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
                DataTable Ds = new DataTable();
                Sdap.Fill(Ds);
                IsUpdated = Ds.Rows[0]["IsUpdated"].ToString();

            }
            if (IsUpdated == "1" && emailid != "" && testid != "")
            {
                SqlConnection con = null;
                SqlCommand cmd = null;
                DataSet ds = null;
                SqlDataAdapter da = null;
                SqlDataReader drdr = null;
                string strConn = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;
                con = new SqlConnection(strConn);
                cmd = new SqlCommand("spSecUserLogin_Email", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@UserName", emailid);
                cmd.Parameters.AddWithValue("@UserPwd", emailid);
                cmd.Parameters.AddWithValue("@SessionIdNw", Session.SessionID);
                cmd.Parameters.AddWithValue("@IPAddress", Request.ServerVariables["REMOTE_ADDR"]);
                cmd.Parameters.AddWithValue("@BrwsrVer", Request.Browser.Type);
                cmd.Parameters.AddWithValue("@ScrRsltn", "");
                con.Open();
                drdr = cmd.ExecuteReader();
                
                drdr.Read();
                Session["LoginId"] = drdr["LoginId"].ToString();
               // Session["CycleId"] = drdr["CycleId"].ToString();
                Session.Timeout = 120;
                Session["EmpNodeID"] = drdr["UserNodeID"].ToString();
                Session["UserLoginId"] = emailid;
                Session["EmpName"] = drdr["EmpName"].ToString();
                Session["username"] = drdr["EmpName"].ToString();
                Session["EmpEmailId"] = drdr["EmailID"].ToString();
                Session["BandID"] = drdr["BandID"].ToString();
                Session["GradeId"] = "0";// drdr["GradeId"].ToString();
                con.Close();
                Response.Redirect("~/MainTask/Exercise/ExerciseMain.aspx");
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
           
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }


}