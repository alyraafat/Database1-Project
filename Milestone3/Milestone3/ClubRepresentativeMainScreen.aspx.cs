using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
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

            //get upcoming matches
            SqlCommand getMatches = new SqlCommand("SELECT * FROM dbo.upcomingMatchesOfClub2(@clubName)", conn);
            getMatches.Parameters.AddWithValue("@clubName", clubName);
            SqlDataAdapter da = new SqlDataAdapter(getMatches);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                Label empty = new Label();
                empty.Text = "No upcoming matches";
                form1.Controls.Add(empty);
            }
            else
            {
                matches.DataSource= dt;
                matches.DataBind();
            }
      

            //getStadiumManagers
            if (!IsPostBack)
            { 
                smdd.AppendDataBoundItems = true;
                String stadiumSql = "SELECT * from allStadiumManagers";
                SqlCommand allStadium = new SqlCommand(stadiumSql, conn);
                SqlDataReader stadiumMReader = allStadium.ExecuteReader();
                //ArrayList SListNames = new ArrayList();
                //while (stadiumMReader.Read())
                //{
                //  String resultNames = stadiumMReader["stadium_manager_name"].ToString();
                //SListNames.Add(resultNames);
                //}
                //stadiumMReader.Close();
                try
                {
                    smdd.DataSource = stadiumMReader;
                    smdd.DataTextField = "stadium_name";
                    smdd.DataBind();
                    stadiumMReader.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
           
            conn.Close();
        }

        protected void showStadium(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            //get available Stadiums
            if (dateInput.Text.Length > 20 || dateInput.Text.Length == 0)
            {
                Response.Write("<script>alert('date is too long or empty');</script>");
            }
            else
            {
                DateTime date = DateTime.Parse(dateInput.Text);
                String date2 = date.ToString("yyyy-MM-dd HH:mm:ss");
                date = DateTime.Parse(date2);
                //if (!DateTime.TryParseExact(dateInput.Text, "yyyy-MM-dd", CultureInfo.CurrentCulture, DateTimeStyles.None, out date))
                //{
                //  Response.Write("Write date in this format yyyy-mm-dd");
                //}
                // else
                //{
                conn.Open();
                SqlCommand getAvailableStadiums = new SqlCommand("SELECT * FROM dbo.viewAvailableStadiumsOn(@datetime)", conn);
                getAvailableStadiums.Parameters.AddWithValue("@datetime", date);
                SqlDataAdapter da2 = new SqlDataAdapter(getAvailableStadiums);
                DataTable dt2 = new DataTable();
                da2.Fill(dt2);
                if (dt2.Rows.Count == 0)
                {
                    Label empty = new Label();
                    empty.Text = "No available stadiums";
                    form1.Controls.Add(empty);
                }
                else
                {
                    availableStadiums.DataSource = dt2;
                    availableStadiums.DataBind();
                }       
                conn.Close();
               // }
            } 
        }

        protected void sendRequest(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            if (dateOfRequest.Text.Length > 20 || dateOfRequest.Text.Length == 0)
            {
                Response.Write("<script>alert('date of request is too long or empty');</script>");
            }
            else
            {
                conn.Open();
                DateTime date = DateTime.Parse(dateOfRequest.Text);
                String date2 = date.ToString("yyyy-MM-dd HH:mm:ss");
                date = DateTime.Parse(date2);
                SqlCommand getMatchesWithNoStadium = new SqlCommand("upcomingMatchesOfClubWithNoStadium", conn);
                getMatchesWithNoStadium.CommandType = CommandType.StoredProcedure;
                Response.Write(name.Text);
                getMatchesWithNoStadium.Parameters.Add(new SqlParameter("@clubName", name.Text));
                SqlDataReader getMatchesWithNoStadiumReader = getMatchesWithNoStadium.ExecuteReader();
                ArrayList m = new ArrayList();
                while (getMatchesWithNoStadiumReader.Read())
                {
                    m.Add(getMatchesWithNoStadiumReader["start_time"]);
                }
                getMatchesWithNoStadiumReader.Close();
                SqlCommand getMatches = new SqlCommand("SELECT * FROM dbo.upcomingMatchesOfClub2(@clubName)", conn);
                getMatches.Parameters.AddWithValue("@clubName", name.Text);
                SqlDataReader getMatchesReader = getMatches.ExecuteReader();
                ArrayList m2 = new ArrayList();
                while (getMatchesReader.Read())
                {
                    m2.Add(getMatchesReader["start_time"]);
                }
                getMatchesReader.Close();
                //Convert.ToDateTime(dateOfRequest.Text.ToString());
                //DateTime.TryParseExact(dateOfRequest.Text, "yyyy-MM-dd HH:mm:ss", CultureInfo.CurrentCulture, DateTimeStyles.None, out date);
                //if (!DateTime.TryParseExact(dateOfRequest.Text, "yyyy-MM-dd HH:mm:ss", CultureInfo.CurrentCulture, DateTimeStyles.None, out date))
                // {
                //   Response.Write("Write date of request in this format yyyy-mm-dd hh:mm:ss");
                // }
                // else
                // {
                if (!m2.Contains(date))
                {
                    Response.Write("<script>alert('No match with this date');</script>");
                }
                else
                {
                    if (!m.Contains(date))
                    {
                        Response.Write("<script>alert('Match is already hosted on a stadium');</script>");
                    }
                    else
                    {
                        SqlCommand addHostRequest = new SqlCommand("addHostRequest", conn);
                        addHostRequest.CommandType = CommandType.StoredProcedure;
                        addHostRequest.Parameters.Add(new SqlParameter("@clubName", name.Text));
                        addHostRequest.Parameters.Add(new SqlParameter("@stadiumName", smdd.SelectedItem.Text));
                        addHostRequest.Parameters.Add(new SqlParameter("@startTime", date));
                        addHostRequest.ExecuteNonQuery();
                    }
                    
                }
                
            //}
                conn.Close();
            }
            
        }

    }
}