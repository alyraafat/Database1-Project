using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace Milestone3
{
    public partial class Register : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void cr_Click(object sender, EventArgs e)
        {
            Response.Redirect("CRRegister.aspx");
        }

        protected void sam_Click(object sender, EventArgs e)
        {
            Response.Redirect("SAMRegister.aspx");

        }

        protected void sm_Click(object sender, EventArgs e)
        {
            Response.Redirect("SMRegister.aspx");
        }

        protected void fan_Click(object sender, EventArgs e)
        {
            Response.Redirect("FanRegister.aspx");
        }
    }
}