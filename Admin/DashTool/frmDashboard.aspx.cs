using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_frmDashboard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Dim panelLogout As Panel
        //panelLogout = DirectCast(Page.Master.FindControl("panelLogout"), Panel)
        //panelLogout.Visible = False

        LinkButton lnkHome =(LinkButton) Page.Master.FindControl("lnkHome");
        lnkHome.Visible = false;

        if (Session["LoginId"] == null)
        {
            Response.Redirect("../login.aspx");
            return;
        }

        int roleId = (Session["RoleId"] == null ? 0 : Convert.ToInt32(Session["RoleId"]));

        dvLinks.InnerHtml = CreateLinks(roleId);
    }

    private string CreateLinks(int roleId)
    {
        StringBuilder sb = new StringBuilder();
        switch (roleId)
        {
            case 1:
                sb.Append("<a href='Setting/frmAssignExcercise.aspx' class='btns btn-submit'>User Exercise Status</a>");
                sb.Append("<a href='Setting/frmUserCreation.aspx' class='btns btn-submit'>User Creation</a>");
                sb.Append("<a href='Setting/frmUsersAvailableForDownload.aspx' class='btns btn-submit'>Users Ready For Download</a>");
                return sb.ToString();
            case 3:
                sb.Append("<a href='Evidence/RatingStatus.aspx' class='btns btn-submit'>Participant Rating</a>");
                sb.Append("<a href='Evidence/frmAssessorRolePlayAssign.aspx' class='btns btn-submit'>Start Exercises</a>");
                sb.Append("<a href='Evidence/AvailablityPlan.aspx' class='btns btn-submit'>Create Availability Plan</a>");
                return sb.ToString();
            case 4:
                /*sb.Append("<a href='Pearson/UserLinkUplaodByPearson.aspx' class='btns btn-submit'>Upload User Links</a>");
                sb.Append("<a href='Pearson/frmUpdateLinkbyPearson.aspx' class='btns btn-submit'>Update User Links</a>");
                sb.Append("<a href='Pearson/frmUpdateuserexcercisestatus.aspx' class='btns btn-submit'>Update Exercise Status</a>");*/
                sb.Append("<a href='Pearson/UserResultUplaodByPearson.aspx' class='btns btn-submit'>Upload Result</a>");              
                return sb.ToString();
            default:
                sb.Append("<a href='../login.aspx' class='btns btn-submit'>Logout</a>");
                return sb.ToString();
        }

    }
}