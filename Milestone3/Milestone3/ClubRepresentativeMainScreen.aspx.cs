using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Milestone3
{
    public partial class ClubRepresentativeMainScreen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String username = Session["user"].ToString();
            SqlCommand getClub = new SqlCommand("getClubOfRep",conn);
            getClub.CommandType = CommandType.StoredProcedure;
            getClub.Parameters.Add(new SqlParameter("@username", username));
            Response.Write(username);
            conn.Open();
            SqlDataReader clubReader = getClub.ExecuteReader();
            String clubName = "";
            String clubLocation = "";
            while (clubReader.Read())
            {
                clubName = clubReader["name"].ToString();
                clubLocation = clubReader["location"].ToString();
            }
            clubReader.Close();
            name.Text = clubName;
            loc.Text = clubLocation;
            conn.Close();
        }
    }
}