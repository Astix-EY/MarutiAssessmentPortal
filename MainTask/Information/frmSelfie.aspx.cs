﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Setting_frmSelfie : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["LoginId"] == null || Session["BandId"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }
        hdnLoginID.Value =Session["LoginId"].ToString();
        hdnBandId.Value =Session["BandId"].ToString();
        hdnRspID.Value = Session["RspID"].ToString();
        hdnFolderName.Value = "MainTask";
    }
}