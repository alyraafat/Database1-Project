using System;
using System.Collections;
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
using System.Xml.Linq;

namespace Milestone3
{
    public partial class SportsAssociationManagerMainScreen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String username = Session["user"].ToString();
            conn.Open();
            //get upcoming matches
            SqlCommand getMatches = new SqlCommand("SELECT * FROM getUpcomingMatches2", conn);
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
                matches.DataSource = dt;
                matches.DataBind();
            }
            SqlCommand getAlreadyMatches = new SqlCommand("SELECT * FROM getAlreadyPlayedMatches2", conn);
            SqlDataAdapter da2 = new SqlDataAdapter(getAlreadyMatches);
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);
            if (dt2.Rows.Count == 0)
            {
                Label empty = new Label();
                empty.Text = "No upcoming matches";
                form1.Controls.Add(empty);
            }
            else
            {
                matches0.DataSource = dt2;
                matches0.DataBind();
            }
            SqlCommand clubsNeverPlaying = new SqlCommand("SELECT * FROM clubsNeverMatched", conn);
            SqlDataAdapter da3 = new SqlDataAdapter(clubsNeverPlaying);
            DataTable dt3 = new DataTable();
            da3.Fill(dt3);
            if (dt3.Rows.Count == 0)
            {
                Label empty = new Label();
                empty.Text = "No upcoming matches";
                form1.Controls.Add(empty);
            }
            else
            {
                neverPlaying.DataSource = dt3;
                neverPlaying.DataBind();
            }
            conn.Close();
        }
        protected void addMatchButton(object sender, EventArgs e) {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String hostName = HostNameAddBox.Text;
            String guestName = GuestNameAddBox.Text;

            try
            {
                DateTime startDateTime = new DateTime(Int32.Parse(startTimeYears.Text),Int32.Parse(startTimeMonth.Text), Int32.Parse(startTimeDay.Text), Int32.Parse(startTimeHours.Text), Int32.Parse(startTimeMinutes.Text),0);
                DateTime endDateTime = new DateTime(Int32.Parse(endTimeYears.Text),Int32.Parse(endTimeMonths.Text), Int32.Parse(endTimeDays.Text), Int32.Parse(endTimeHours.Text), Int32.Parse(endTimeMinutes.Text),0);
                String club = "SELECT * from allCLubs";
                SqlCommand allClub = new SqlCommand(club, conn);

                String match = "SELECT * from allMatches ";
                SqlCommand allMatch = new SqlCommand(match, conn);

                SqlCommand addM = new SqlCommand("addNewMatch", conn);
                addM.CommandType = CommandType.StoredProcedure;
                addM.Parameters.Add(new SqlParameter("@hostclub", hostName));
                addM.Parameters.Add(new SqlParameter("@guestclub", guestName));
                addM.Parameters.Add(new SqlParameter("@starttime", startDateTime));
                addM.Parameters.Add(new SqlParameter("@endtime", endDateTime));

                conn.Open();
                SqlDataReader clubReader = allClub.ExecuteReader();
                ArrayList CListNames = new ArrayList();
                ArrayList CListlocation = new ArrayList();
                while (clubReader.Read())
                {
                    String resultname = clubReader["name"].ToString();
                    String resultLocation = clubReader["location"].ToString();
                    CListNames.Add(resultname);
                    CListlocation.Add(resultLocation);
                }
                clubReader.Close();
                if (!(CListNames.Contains(hostName)))
                {
                    Response.Write("<script>alert('Please make Sure the host club name is right');</script>");
                }
                else if (!CListNames.Contains(guestName))
                {
                    Response.Write("<script>alert('Please make Sure the guest club name is right');</script>");
                }
                else
                {
                    if (hostName.Equals(guestName))
                    {
                        Response.Write("<script>alert('The host and guest teams cannot be the same');</script>");
                    }
                    else
                    {
                        Boolean hostTeamFlag = false;
                        Boolean guestTeamFlag = false;
                        SqlDataReader matchReader = allMatch.ExecuteReader();
                        String resultTime = "";
                        while (matchReader.Read())
                        {
                            String resultHost = matchReader["host_club"].ToString();
                            String resultGuest = matchReader["guest_club"].ToString();
                            resultTime = matchReader["start_time"].ToString();

                            if (resultHost.Equals(hostName) || resultGuest.Equals(hostName))
                            {
                                if (resultTime.Equals(startDateTime.ToString()))
                                {
                                    hostTeamFlag = true;
                                    break;
                                }
                            }
                            else if (resultHost.Equals(guestName) || resultGuest.Equals(guestName))
                            {
                                if (resultTime.Equals(startDateTime.ToString()))
                                {
                                    guestTeamFlag = true;
                                    break;
                                }
                            }
                        }
                        matchReader.Close();
                        if (hostTeamFlag || guestTeamFlag)
                        {
                            Response.Write("<script>alert('There is a match schedueld for one of the teams');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Done');</script>");
                            addM.ExecuteNonQuery();
                        }
                        matchReader.Close();
                    }
                } 
                conn.Close();
            }
            catch (FormatException)
            {
                Response.Write("<script>alert('Wrong date Format');</script>");
            }
            
        }
        protected void deleteMatchButton(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String hostName = HostNameAddBox0.Text;
            String guestName = GuestNameAddBox0.Text;
            try
            {
                DateTime startDateTime = new DateTime(Int32.Parse(startTimeYears0.Text), Int32.Parse(startTimeMonth0.Text), Int32.Parse(startTimeDay0.Text), Int32.Parse(startTimeHours0.Text), Int32.Parse(startTimeMinutes0.Text), 0);
                DateTime endDateTime = new DateTime(Int32.Parse(endTimeYears0.Text), Int32.Parse(endTimeMonths0.Text), Int32.Parse(endTimeDays0.Text), Int32.Parse(endTimeHours0.Text), Int32.Parse(endTimeMinutes0.Text), 0);
                String club = "SELECT * from allCLubs";
                SqlCommand allClub = new SqlCommand(club, conn);

                String match = "SELECT * from allMatches ";
                SqlCommand allMatch = new SqlCommand(match, conn);

                SqlCommand addM = new SqlCommand("deleteMatch", conn);
                addM.CommandType = CommandType.StoredProcedure;
                addM.Parameters.Add(new SqlParameter("@namehostclub", hostName));
                addM.Parameters.Add(new SqlParameter("@nameguestclub", guestName));


                conn.Open();
                SqlDataReader clubReader = allClub.ExecuteReader();
                ArrayList CListNames = new ArrayList();
                ArrayList CListlocation = new ArrayList();
                while (clubReader.Read())
                {
                    String resultname = clubReader["name"].ToString();
                    String resultLocation = clubReader["location"].ToString();
                    CListNames.Add(resultname);
                    CListlocation.Add(resultLocation);
                }
                clubReader.Close();
                if (!(CListNames.Contains(hostName)))
                {
                    Response.Write("<script>alert('Please make Sure the host club name is write');</script>");
                }
                else if (!CListNames.Contains(guestName))
                {
                    Response.Write("<script>alert('Please make Sure the guest club name is write');</script>");
                }
                else
                {
                    Boolean isThereMatch = false;
                    SqlDataReader matchReader = allMatch.ExecuteReader();
                    String resultTime = "";
                    while (matchReader.Read())
                    {
                        String resultHost = matchReader["host_club"].ToString();
                        String resultGuest = matchReader["guest_club"].ToString();
                        resultTime = matchReader["start_time"].ToString();

                        if (resultHost.Equals(hostName) && resultGuest.Equals(guestName))
                        {
                            isThereMatch = true;
                        }
                        
                    }
                    matchReader.Close();
                    if (!isThereMatch)
                    {
                        Response.Write("<script>alert('There is no matches between these 2 clubs');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Done');</script>");
                        addM.ExecuteNonQuery();
                    }
                    matchReader.Close();
                }
                conn.Close();
            }
            catch (FormatException)
            {
                Response.Write("<script>alert('Wrong date Format');</script>");
            }
        }

            protected void GuestNameAddBox_TextChanged(object sender, EventArgs e)
        {

        }
    }
}