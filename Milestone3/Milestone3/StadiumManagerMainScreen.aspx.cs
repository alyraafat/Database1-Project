using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using System.Text.RegularExpressions;

namespace Milestone3
{
    public partial class StadiumManagerMainScreen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String username = Session["user"].ToString();
            SqlCommand getStadium = new SqlCommand("getStadiumOfManager", conn);
            getStadium.CommandType = CommandType.StoredProcedure;
            getStadium.Parameters.Add(new SqlParameter("@username", username));
            conn.Open();
            SqlDataReader stadiumReader = getStadium.ExecuteReader();
            String stadiumName = "";
            String stadiumLocation = "";
            String stadiumStatus = "";
            String stadiumCapacity = "";
            while (stadiumReader.Read())
            {
                stadiumName = stadiumReader["name"].ToString();
                stadiumLocation = stadiumReader["location"].ToString();
                stadiumCapacity = stadiumReader["capacity"].ToString();
                if (stadiumReader["status"].ToString().Equals("True"))
                {
                    stadiumStatus = "available";
                }
                else
                {
                    stadiumStatus = "unavailable";

                }
            }
            stadiumReader.Close();
            name.Text = stadiumName;
            loc.Text = stadiumLocation;
            capacity.Text = stadiumCapacity;
            status.Text = stadiumStatus;

            // Get all requests
            SqlCommand getRequests = new SqlCommand("SELECT * FROM dbo.requests(@stadiumName)", conn);
            getRequests.Parameters.AddWithValue("@stadiumName", stadiumName);
            SqlDataAdapter da = new SqlDataAdapter(getRequests);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if(dt.Rows.Count == 0)
            {
                Label empty = new Label();
                empty.Text = "No requests";
                form1.Controls.Add(empty);
            }
            else
            {
                requests.DataSource = dt;
                requests.DataBind();
                for(int i = 0; i < requests.Rows.Count; i++)
                {
                    if (!requests.Rows[i].Cells[5].Text.Equals("unhandled"))
                    {
                        requests.Rows[i].Cells[6].Visible = false;
                        requests.Rows[i].Cells[7].Visible = false;
                    }
                }
            }   
        }

        protected void acceptRequest(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String username = Session["user"].ToString();
            SqlCommand accept = new SqlCommand("acceptRequest", conn);
            accept.CommandType = CommandType.StoredProcedure;
            accept.Parameters.Add(new SqlParameter("@stadiumManagerUserName", username));
            accept.Parameters.Add(new SqlParameter("@hostingClubName", requests.SelectedRow.Cells[1].Text));
            accept.Parameters.Add(new SqlParameter("@guestClubName", requests.SelectedRow.Cells[2].Text));
            accept.Parameters.Add(new SqlParameter("@matchStartTime", requests.SelectedRow.Cells[3].Text));

            conn.Open();
           // accept.ExecuteNonQuery();
            conn.Close();
        }
        protected void rejectRequest(object sender, EventArgs e)
        {

        }

        protected void requestsRowCommand(object sender, GridViewCommandEventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String username = Session["user"].ToString();
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = requests.Rows[rowIndex];
            if (e.CommandName.Equals("acc"))
            {
                SqlCommand accept = new SqlCommand("acceptRequest", conn);
                accept.CommandType = CommandType.StoredProcedure;
                accept.Parameters.Add(new SqlParameter("@stadiumManagerUserName", username));
                accept.Parameters.Add(new SqlParameter("@hostingClubName", row.Cells[1].Text));
                accept.Parameters.Add(new SqlParameter("@guestClubName", row.Cells[2].Text));
                accept.Parameters.Add(new SqlParameter("@matchStartTime", DateTime.Parse(row.Cells[3].Text)));

                conn.Open();
                accept.ExecuteNonQuery();
                row.Cells[5].Text= "accepted";
                row.Cells[6].Visible = false;
                row.Cells[7].Visible = false;
                conn.Close();
            }
            else if (e.CommandName.Equals("rej"))
            {
                SqlCommand reject = new SqlCommand("rejectRequest", conn);
                reject.CommandType = CommandType.StoredProcedure;
                reject.Parameters.Add(new SqlParameter("@stadiumManagerUserName", username));
                reject.Parameters.Add(new SqlParameter("@hostingClubName", row.Cells[1].Text));
                reject.Parameters.Add(new SqlParameter("@guestClubName", row.Cells[2].Text));
                reject.Parameters.Add(new SqlParameter("@matchStartTime", DateTime.Parse(row.Cells[3].Text)));

                conn.Open();
                reject.ExecuteNonQuery();
                row.Cells[5].Text = "rejected";
                row.Cells[6].Visible = false;
                row.Cells[7].Visible = false;
                conn.Close();

            }
        }

    }
}