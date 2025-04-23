using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;
using System.Text;
using Newtonsoft.Json;
using System.IO;
using System.Configuration;
using System.Threading.Tasks;
public partial class frmExerciseElapsedTimeUpdation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["LoginId"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }
        if (!IsPostBack)
        {
            hdnLoginId.Value = Session["LoginId"].ToString();
        }
    }


    [WebMethod]
    public static string getdata(string usercode)
    {
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        DataSet ds = new DataSet();
        SqlConnection Scon = new SqlConnection(System.Configuration.ConfigurationManager.AppSettings["strConn"]);
        SqlCommand Scmd = new SqlCommand();
        Scmd.Connection = Scon;
        Scmd.CommandText = "[spGetUserExerciseStatusForElapsedTimeUpdation]";
        Scmd.CommandType = CommandType.StoredProcedure;
        Scmd.CommandTimeout = 0;
        Scmd.Parameters.AddWithValue("@UserCode", usercode);
    

        SqlDataAdapter Sdap = new SqlDataAdapter(Scmd);
        Sdap.Fill(ds);
        string str = "0";
     
        if (ds.Tables[0].Rows.Count > 0)
        {
            str = createStoretbl(ds.Tables[0], 1, true, "tblexercise");
        }
        
        return str;
    }



    private static string createStoretbl(DataTable dt, int headerlvl, bool IsHeader, string strtableid)
    {
        //DataTable dt = ds.Tables[1];

        string[] SkipColumn = new string[6];
        SkipColumn[0] = "RspExerciseID";
        SkipColumn[1] = "flgExerciseStatus";
        SkipColumn[2] = "UserCode";
        SkipColumn[3] = "Name";
        SkipColumn[4] = "Band";
        SkipColumn[5] = "flgTimeOver";
        


        StringBuilder bgColor = new StringBuilder();

        if (dt.Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<table class='table'>");
            sb.Append("<tr>");
            sb.Append("<td style='width:8%'>User Code</td><td style='width:2%'>:</td><td>" + dt.Rows[0]["UserCode"].ToString() + "</td>");
            sb.Append("</tr>");
            sb.Append("<td>Name</td><td>:</td><td>" + dt.Rows[0]["Name"].ToString() + "</td>");
            sb.Append("</tr>");
            sb.Append("<td>Band</td><td>:</td><td>" + dt.Rows[0]["Band"].ToString() + "</td>");
            sb.Append("</tr>");
            sb.Append("</tr>");
            sb.Append("</table>");
            sb.Append("<table id='" + strtableid + "'  class='table table-striped table-bordered table-hover table-condensed'>");
            sb.Append("<thead >");
            string[] Collength = dt.Columns[0].ColumnName.ToString().Split('^');
            for (int k = 0; k < Collength.Length; k++)
            {
                sb.Append("<tr>");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                    {
                        string[] ColSpliter = dt.Columns[j].ColumnName.ToString().Trim().Split('^');
                        if (ColSpliter[k] != "")
                        {
                            if (string.Join("", ColSpliter) == ColSpliter[k])
                            {
                                //background-color:#C4D79B;border:1px solid #000000;font-size:8pt;
                                sb.Append("<th style='text-align:center;' rowspan='" + ColSpliter.Length + "'>" + (ColSpliter[k] == "DiscPer" ? "Discount(%)" : ColSpliter[k]) + "</th>");
                            }
                            else
                            {
                                string strrowspan = multilvlPopuptbl(dt, j, k);
                                sb.Append(strrowspan.Split('|')[0]);
                                j = j + Convert.ToInt32(strrowspan.Split('|')[1]) - 1;
                            }
                        }
                    }
                }
                sb.Append("<th style='text-align:center;width:12.5%'>Edit/Update</th>");
                sb.Append("</tr>");
            }
            sb.Append("</thead>");
            sb.Append("<tbody>");


            for (int i = 0; i < dt.Rows.Count; i++)
            {


                sb.Append("<tr>");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (!SkipColumn.Contains(dt.Columns[j].ColumnName.ToString().Trim()))
                    {
                        if (dt.Columns[j].ColumnName.ToString().Trim().ToLower() == "extendtesttime(min)")
                        {
                            sb.Append("<td align='center'><div id='elapsedtime' style='display: block'>" + dt.Rows[i][j].ToString() + "</div><input id='" + dt.Rows[i]["RspExerciseID"].ToString() + "' type='text' style='width:50px;text-align:center;display:none' value='" + dt.Rows[i][j].ToString() + "' onkeypress='return isNumberKeyNotDecimal(event)' onmousedown='whichButton(event)' onkeydown='return noCTRL(event)'   ></td>");//onfocus='Focus(this)'
                        }                        
                        else
                        {
                            string saling = "left";
                            if(dt.Columns[j].ColumnName== "ElapsedTime(Min)" || dt.Columns[j].ColumnName== "TotTestTime(Min)")
                            {
                                saling = "center";
                            }
                            sb.Append("<td style='text-align: "+ saling + ";'>" + dt.Rows[i][j].ToString() + "</td>");
                        }

                    }

                }
                sb.Append("<td style='text-align:center'><input id='hidchange' type='hidden' value='0' /><a id='lbCancel' href='#' style='color: blue;text-decoration: underline; cursor: pointer;display:none;margin-right:10px' onclick='Cancel(this);return false;'>Cancel</a><a id='lbSave' href='#' style='color: blue;text-decoration: underline; cursor: pointer;display:none;' onclick='Save(this);return false;'>Save</a><a id=lbEdit style='color: blue; text - decoration: underline; cursor: pointer; " + (dt.Rows[i]["flgExerciseStatus"].ToString()!="0"  ? "display:block" : "display:none") + "'  onclick='changemain(this); return false;'>Edit</a></td>");
                sb.Append("</tr>");
            }
            sb.Append("</tbody>");
            sb.Append("</table>");
            return sb.ToString();
        }
        else
        {
            return "<span style='font-size:13px; padding : 10px 20px; color:red; font-weight:bold;'>No Record(s) Found !";
        }
    }


    private static string multilvlPopuptbl(DataTable dt, int col_ind, int row_ind)
    {
        int cntr = 1;
        string str = dt.Columns[col_ind].ColumnName.ToString().Split('^')[row_ind];
        for (int i = col_ind + 1; i < dt.Columns.Count; i++)
        {
            if (str == dt.Columns[i].ColumnName.ToString().Split('^')[row_ind])
            {
                cntr++;
            }
            else
            {
                break;
            }
        }
        return " <th colspan='" + cntr + "' style='color: #000000; font-size: 11px; font-family: Calibri; font-weight:bold; background-color: #C4D79B; border: 1px solid #dddddd; min-width:100px;'> " + str + " </th>|" + cntr;
    }


    [System.Web.Services.WebMethod()]
    public static string ExerciseElapsedTimeUpdation(string RSPExerciseId,string ElapsedTimeMin,string LoginId)
    {

        try
        {
            SqlConnection Scon = new SqlConnection(ConfigurationManager.AppSettings["strConn"]);
            SqlCommand Scmd = new SqlCommand();
            Scmd.Connection = Scon;
            Scmd.CommandText = "spExtendRspExerciseTime";
            Scmd.CommandType = CommandType.StoredProcedure;
            //Scmd.Parameters.AddWithValue("@tblAssmentRsltDetails", DttblRating);
            Scmd.Parameters.AddWithValue("@RspExerciseId", RSPExerciseId);
            Scmd.Parameters.AddWithValue("@ExtendTimeInMin", ElapsedTimeMin);
            Scmd.Parameters.AddWithValue("@LoginId", LoginId);
            Scmd.CommandTimeout = 0;
            Scon.Open();
            Scmd.ExecuteNonQuery();
            Scon.Close();
            Scon.Dispose();
            return "0";
        }
        catch (Exception ex)
        {
            return "1^"+ex.Message;
        }
    }


}