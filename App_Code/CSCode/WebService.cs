using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService
{

    public WebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }


    [WebMethod]
    public string fnValidateUserInboxStatus(string RspExerciseID)
    {
        string strRep = "0";
        string strConn = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;
        SqlConnection objCon = new SqlConnection(strConn);
        SqlCommand objcom = new SqlCommand("spValidateUserInboxStatus", objCon);
        objcom.Parameters.AddWithValue("@RspExerciseID", RspExerciseID);
        objcom.CommandTimeout = 0;
        objcom.CommandType = CommandType.StoredProcedure;
        SqlDataReader dr;
        try {
            objCon.Open();
            dr = objcom.ExecuteReader();
            if (dr.HasRows)
            {
                dr.Read();
                strRep = dr[0].ToString();
            }
            dr.Close();
        }
        catch(Exception ex)
        {
            strRep = "0";
        }
        finally
        {
            objcom.Dispose();
            objCon.Close();
            objCon = null;
        }

        return strRep;
    }

    [WebMethod]
    public string fnDeleteCurrentlyInProgressRSP()
    {
        string strRep = "0";
        string RSPID = Session["RspId"] == null ? "0" : Session["RspId"].ToString();
        string strConn = ConfigurationManager.ConnectionStrings["strConn"].ConnectionString;
        SqlConnection objCon = new SqlConnection(strConn);
        SqlCommand objcom = new SqlCommand("spDeleteCurrentlyInProgressRSP", objCon);
        objcom.Parameters.AddWithValue("@RSPID", RSPID);
        objcom.Parameters.AddWithValue("@ExerciseId", 0);
        objcom.CommandTimeout = 0;
        objcom.CommandType = CommandType.StoredProcedure;
        try
        {
            objCon.Open();
            objcom.ExecuteNonQuery();
            strRep = "1";
        }
        catch (Exception ex)
        {
            strRep = "0";
        }
        finally
        {
            objcom.Dispose();
            objCon.Close();
            objCon = null;
        }

        return strRep;
    }

}
