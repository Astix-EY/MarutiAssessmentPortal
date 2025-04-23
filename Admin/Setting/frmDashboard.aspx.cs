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

        LinkButton lnkHome = (LinkButton)Page.Master.FindControl("lnkHome");
        lnkHome.Visible = false;

        if (Session["LoginId"] == null)
        {
            Response.Redirect("../../login.aspx");
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
                dvLinks.Style.Add("font-size", "15px");

                 sb.Append("<table class='table table-bordered table-sm bg-white'>");
                sb.Append("<tr>");
                sb.Append("<td rowspan='4' class='fstth-title'>View Status</td>");
                
                sb.Append("</tr>");
                sb.Append("<tr >");
                sb.Append("<td><a href='../Setting/frmAssignExcercise.aspx' class='btns btn-submit col-12'>Participant Exercise Status</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>View the progress of participant exercise and assessor rating</li>");
                sb.Append("<li>Download the assessment report of participants</li></ul>");
                sb.Append("</td>");
                sb.Append("</tr>");

                sb.Append("<tr >");
                sb.Append("<td><a href='../Setting/frmUserSnapshots.aspx' class='btns btn-submit col-12'>Proctoring Report</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>View the Proctoring Report</li>");
                sb.Append("</td>");
                sb.Append("</tr>");
sb.Append("<tr>");
                sb.Append("<td><a href='../MasterForms/frmGetExperiencePageResponse.aspx' class='btns btn-submit col-12'>Download Participant Experience Responses</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>Download Participant Experience Responses</li></ul>");                
                sb.Append("</td>");
                sb.Append("</tr>");


                sb.Append("<tr>");
                sb.Append("<td colspan='3' class='border-0'><div class='bg-primary' style='height:4px;'>&nbsp;</div></td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td rowspan='11' class='fstth-title'>Manage Process</td>");
                sb.Append("<td><a href='../MasterForms/frmManageEmployeeDetails.aspx' class='btns btn-submit col-12'>Manage Employee Information</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>Create new employee information</li>");
                sb.Append("<li>Edit or delete existing employees for which the assement has not started as yet</li></ul>");
                sb.Append("</td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td><a href='../MasterForms/frmManageCycle.aspx' class='btns btn-submit col-12'>Cycle Creation & information</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>Create New Cycle</li>");
                sb.Append("<li>Edit or delete existing cycle for which the date has not surpassed yet</li>");
                sb.Append("</ul>");
                sb.Append("</td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td><a href='../MasterForms/frmManageParticipantAgCycle.aspx' class='btns btn-submit col-12'>Cycle Mapping With Participant</a></td>");
                sb.Append("<td><ul class='mb-0 pl-3'><li>Map participants with a particular cycle</li></ul></td>");
                sb.Append("</tr>");
                sb.Append("<tr>");
                sb.Append("<td><a href='../MasterForms/frmParticipantMappingWithEklavya.aspx' class='btns btn-submit col-12'>Participant Configuration With AI Assessment </a></td>");
                sb.Append("<td><ul class='mb-0 pl-3'><li>Participant Configuration With AI Assessment</li></ul></td>");
                sb.Append("</tr>");

                sb.Append("<tr>");
                sb.Append("<td><a href='../MasterForms/frmParticipantMappingWithTechnicalTest.aspx' class='btns btn-submit col-12'>Participant Mapping With AI Tools </a></td>");
                sb.Append("<td><ul class='mb-0 pl-3'><li>Participant Mapping With AI Tools</li></ul></td>");
                sb.Append("</tr>");

                //sb.Append("<tr>");
                //sb.Append("<td><a href='../MasterForms/frmManageAssessorAgCycle.aspx' class='btns btn-submit col-12'>Cycle Mapping With Assessor</a></td>");
                //sb.Append("<td><ul class='mb-0 pl-3'><li>Map assessors with a cycle</li></ul></td>");
                //sb.Append("</tr>");
                //sb.Append("<tr>");
                //sb.Append("<td><a href='../MasterForms/frmParticipantAndAssessorMapping.aspx' class='btns btn-submit col-12'>Participant & Assessor Mapping</a></td>");
                //sb.Append("<td>");
                //sb.Append("<ul class='mb-0 pl-3'><li>Map selected participants for a given cycle with Assessors</li>");
                //sb.Append("<li>View the list of assessors mapped to the cycle and respective number of participants mapped</li></ul>");
                //sb.Append("</td>");
                //sb.Append("</tr>");  
                //sb.Append("<tr>");
                //            sb.Append("<td><a href='../MasterForms/frmParticipantAndAssessorGotomeetingcreation.aspx' class='btns btn-submit col-12'>Meeting Creation</a></td>");
                //            sb.Append("<td>");
                //            sb.Append("<ul class='mb-0 pl-3'><li>Map selected participants for a given cycle with Assessors</li>");
                //            sb.Append("<li>View the list of assessors mapped to the cycle and respective number of participants mapped</li></ul>");
                //            sb.Append("</td>");
                //            sb.Append("</tr>");  

   sb.Append("<tr>");
                sb.Append("<td><a href='../Setting/frmExerciseElapsedTimeUpdation.aspx' class='btns btn-submit col-12'>Exercise Elapsed Time Update</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>Exercise Elapsed Time Update</li></ul>");                
                sb.Append("</td>");
                sb.Append("</tr>");				
                sb.Append("<tr>");
                sb.Append("<td><a href='../MasterForms/frmParticipantEmailInvite.aspx' class='btns btn-submit col-12'>Participant Invitation Mail</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>Send Invitation Mail to Mapped participant</li></ul>");                
                sb.Append("</td>");
                sb.Append("</tr>");


				
				//sb.Append("<tr>");
    //            sb.Append("<td><a href='../MasterForms/frmAssessorEmailInvite.aspx' class='btns btn-submit col-12'>Assessor Invitation Mail</a></td>");
    //            sb.Append("<td>");
    //            sb.Append("<ul class='mb-0 pl-3'><li>Send Invitation Mail to Mapped Assessor</li></ul>");
    //            sb.Append("</td>");
    //            sb.Append("</tr>");
                //sb.Append("<tr>");
                //sb.Append("<td><a href='../MasterForms/frmManageParticipantManagerMappingAgCycle.aspx' class='btns btn-submit col-12'>Manager & Participant Mapping</a></td>");
                //sb.Append("<td>");
                //sb.Append("<ul class='mb-0 pl-3'><li>Participant and Manager Mapping</li></ul>");
                //sb.Append("</td>");
                //sb.Append("</tr>");
				
				  //sb.Append("<tr>");
      //          sb.Append("<td><a href='../MasterForms/frmViewMOMParticipantAndAssessor.aspx' class='btns btn-submit col-12'>Participant Status/Download MOM</a></td>");
      //          sb.Append("<td>");
      //          sb.Append("<ul class='mb-0 pl-3'><li>Click here to see the participant status and download MOM</li></ul>");
      //          sb.Append("</td>");
      //          sb.Append("</tr>");

                sb.Append("</table>");
                //btnGI.Style.Add("display", "none");
                btnGI.Attributes.Add("style", "display:none");
                return sb.ToString();
            case 3:
                dvLinks.Style.Add("font-size", "15px");
                pgsubtitle.InnerHtml = "Assessor Home Page";

                sb.Append("<table class='table table-bordered'>");
                sb.Append("<tr>");
                sb.Append("<td rowspan='3' class='fstth-title'>Manage Process</td>");
                sb.Append("<td><a href='../MasterForms/frmGetParticipantListAgAssessor.aspx' class='btns btn-submit col-12'>Start Meeting</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>Click here to start meeting with participants mapped to you</li></ul>");
                sb.Append("</td>");
                sb.Append("</tr>");

                sb.Append("<tr>");              
                sb.Append("<td><a href='../Evidence/RatingStatus.aspx' class='btns btn-submit col-12'>Participant Rating</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'>");
                sb.Append("<li>Click here to start rating of participant</li></ul>");
                sb.Append("</td>");
                sb.Append("</tr>");
                sb.Append("</table>");

                return sb.ToString();
              case 6:
                dvLinks.Style.Add("font-size", "15px");
                pgsubtitle.InnerHtml = "Main Page";
                sb.Append("<table class='table table-bordered'>");
                sb.Append("<tr>");
                sb.Append("<td><a href='../MasterForms/frmViewMOMParticipantAndAssessor.aspx' class='btns btn-submit col-12'>Participant Status/Download MOM</a></td>");
                sb.Append("<td>");
                sb.Append("<ul class='mb-0 pl-3'><li>Click here to see the participant status and download MOM</li></ul>");
                sb.Append("</td>");
                sb.Append("</tr>");
                sb.Append("</table>");
                return sb.ToString();
            default:
                sb.Append("<a href='../login.aspx' class='btn-one'>Logout</a>");
                return sb.ToString();
        }

    }
}