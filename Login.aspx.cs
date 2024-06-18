using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Xml;
using System.IO;

public partial class AssessorLogin : System.Web.UI.Page
{
    SqlConnection con = null;
    SqlCommand cmd = null;
    DataSet ds = null;
    SqlDataAdapter da = null;
    SqlDataReader drdr = null;
    string strConn = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;
    int intlogin = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        btnSubmit.Attributes.Add("onclick", "javascript:return fnValidate()");
        //	  Response.Redirect("https://www.ey-virtualsolutions.com/AxiataAssessment/AssessorLogin.aspx");
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string strTicket = "";
        int sameuser = 0;

        SqlConnection con = new SqlConnection(strConn);
        //   cmd = new SqlCommand("spSecUserLogin", con);
        cmd = new SqlCommand("spSecUserLogin", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@UserName", txtUserName.Value.ToString().Trim());
        cmd.Parameters.AddWithValue("@UserPwd", txtPwd.Value.ToString().Trim());
        cmd.Parameters.AddWithValue("@SessionIdNw", Session.SessionID);
        cmd.Parameters.AddWithValue("@IPAddress", Request.ServerVariables["REMOTE_ADDR"]);
        cmd.Parameters.AddWithValue("@BrwsrVer", Request.Browser.Type);
        cmd.Parameters.AddWithValue("@ScrRsltn", hdnRes.Value);

        int flgForChk = 0;
        int flgConfirmation = 0;
        int PageNmbr = 0;
        int roleId = 0;

        int ElapsedTimeMin = 0;
        int ElapsedTimeSec = 0;
        int flgExcersiseStatus = 0;
        int ExerciseID = 0;
        int TotalTime = 0;
        int RspId = 0;
        int flgOpenStatus = 0;
        try
        {
            con.Open();

            //DataSet ds = new DataSet();
            //SqlDataAdapter da = new SqlDataAdapter(cmd);
            //da.Fill(ds);

            //if (ds.Tables.Count == 1 && ds.Tables[0].Rows.Count > 0)
            //{
            //    string result = clsCheckRspCurrentProgress.GetStartedAssesments(ds.Tables[0]);
            //    lblloginmsg.Text = "Following assesments are already open: " + result;
            //}

            drdr = cmd.ExecuteReader();


            //   drdr.NextResult();

            int UserNodeID = 0;
            if (drdr.HasRows)
            {
                while (drdr.Read())
                {
                    //if (drdr["FinalStatus"].ToString() == "2")
                    //{
                    //    lblloginmsg.Text = "You have already completed your exercises with these user credentials.";
                    //    return;
                    //}
                    //if(drdr["TypeID"].ToString() == "1")
                    //{
                    if (drdr["LoginResult"].ToString() == "1")
                    {
                        flgForChk = 0;
                    }
                    else if (drdr["LoginResult"].ToString() == "2" || drdr["LoginResult"].ToString() == "3")
                    {

                        Session["LoginId"] = drdr["LoginId"].ToString();
                        Session["RoleId"] = drdr["RoleID"].ToString();
                        Session["CycleId"] = 1;
                        roleId = Convert.ToInt32(drdr["RoleID"].ToString());
                        Session.Timeout = 120;
                        strTicket = drdr["LoginId"].ToString();
                        intlogin = Convert.ToInt32(drdr["LoginId"].ToString());


                        UserNodeID = Convert.ToInt32(drdr["UserNodeID"].ToString());
                        Session["EmpNodeID"] = UserNodeID;
                        Session["FinalLinkStatus"] = drdr["FinalLinkStatus"].ToString();
                        Session["UserLoginId"] = txtUserName.Value.ToString().Trim();

                        Session["EmpName"] = drdr["EmpName"].ToString();
                        // Session["Designation"] = drdr["Designation"].ToString();

                        Session["EmpEmailId"] = drdr["EmailID"].ToString();
                        Session["ActiveStatus"] = drdr["ActiveStatus"].ToString();
                        Session["RspID"] = drdr["RspID"].ToString();
                        Session["BandID"] = drdr["BandID"].ToString();
                        PageNmbr = Convert.ToInt32(drdr["PgNmbr"].ToString());


                        flgConfirmation = 1;// Convert.ToInt32(drdr["flgConfirmation"].ToString());
                        Session["flgConfirmation"] = flgConfirmation;

                        flgOpenStatus = Convert.ToInt32(drdr["flgOpenStatus"].ToString());
                        // Session["TimeOut"] = drdr["ElapsedMin"].ToString();
                        //    Session["ElapsedTime"] = Convert.ToInt32(drdr["ElapsedMin"].ToString()) * 60 + Convert.ToInt32(drdr["ElapsedSec"].ToString());
                        flgForChk = 1;

                    }
                }
            }
            // }
            drdr.NextResult();

            if (drdr.HasRows)
            {
                drdr.Read();
                //ElapsedTimeMin = Convert.ToInt32(drdr["ElapsedTime(Min)"].ToString());
                //ElapsedTimeSec = Convert.ToInt32(drdr["ElapsedTime(Sec)"].ToString());
                //flgExcersiseStatus = Convert.ToInt32(drdr["flgExerciseStatus"].ToString());
                //ExerciseID = Convert.ToInt32(drdr["ExerciseId"].ToString());
                RspId = Convert.ToInt32(drdr["RspID"].ToString());

            }
            //flgOpenStatus = 1;
            //flgExcersiseStatus = 0;
            //PageNmbr = 0;
            if (intlogin == 0)
            {
                lblloginmsg.Text = "Invalid Username or Password !!!";
                txtUserName.Value = "";
                txtPwd.Value = "";
                return;
            }

            else
            {
                if (flgForChk == 1)
                {
                    if (roleId == 1)
                    {
                        Response.Redirect("Admin/setting/frmDashboard.aspx");
                    }
                    else if (roleId == 3)
                    {
                        Response.Redirect("Admin/setting/frmDashboard.aspx");
                    }
                    else if (roleId == 4)
                    {
                        Response.Redirect("Admin/setting/frmDashboard.aspx");
                    }
                    else if (roleId == 6)
                    {
                        Response.Redirect("Admin/setting/frmDashboard.aspx");
                    }
                    else
                    {
                        //string pFolderName = "J1";
                        //  pFolderName = "J1";
                        //Response.Redirect("Login.aspx?intLoginID=" + Session["LoginId"] + "&EmpId=" + Session["EmpNodeID"]);
                       // Response.Redirect("Task/Information/CompanyOverview.aspx");
                       if(RspId==0)
                        {
                            Response.Redirect("Task/Exercise/Welcome.aspx");
                        }
                       else
                        {
                            Response.Redirect("MainTask/Exercise/MyTask.aspx");
                        }

                        
                    }
                }

                else
                {
                    lblloginmsg.Text = "Invalid username or password!!!";
                    txtUserName.Value = "";
                    txtPwd.Value = "";

                }
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            con.Close();
            txtUserName.Value = "";
            txtPwd.Value = "";
        }
    }
}