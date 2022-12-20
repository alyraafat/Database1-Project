using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Configuration;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class SportsAssociationManagerMainScreen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void addMatchButton(object sender, EventArgs e) {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String hostName = HostNameAddBox.Text;
            String guestName = GuestNameAddBox.Text;
            String startTime = StartTimeAddBox.Text;
            String endTime = EndTimeAddBox.Text;
            String club = "SELECT * from allCLubs";
            SqlCommand allClub = new SqlCommand(club, conn);

            String match = "SELECT * from allCLubs";
            SqlCommand allMatch = new SqlCommand(club, conn);

            SqlCommand addM = new SqlCommand("addNewMatch", conn);
            addM.CommandType = CommandType.StoredProcedure;
            addM.Parameters.Add(new SqlParameter("@hostclub", hostName));
            addM.Parameters.Add(new SqlParameter("@guestclub", guestName));
            addM.Parameters.Add(new SqlParameter("@starttime", startTime));
            addM.Parameters.Add(new SqlParameter("@endtime", endTime));
            conn.Open();
            SqlDataReader clubReader = allClub.ExecuteReader();

            conn.Close();
        }
    }
}