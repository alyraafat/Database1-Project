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
    public partial class SystemAdminMainScreen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void addClubButton(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String newName = addname.Text;
            String newLocation = addlocation.Text;
            String club = "SELECT * from allCLubs";
            SqlCommand allClub = new SqlCommand(club, conn);

            SqlCommand addC = new SqlCommand("addClub", conn);
            addC.CommandType = CommandType.StoredProcedure;
            addC.Parameters.Add(new SqlParameter("@nameOfClub", newName));
            addC.Parameters.Add(new SqlParameter("@nameOfLocation", newLocation));

            

            conn.Open();
            SqlDataReader clubReader = allClub.ExecuteReader();
            if (newName.Length > 20 || newName.Length == 0) {
                Response.Write("name is to long");
            }
            else if (newLocation.Length > 20 || newLocation.Length == 0 ) {
                Response.Write("name is to long");
            }
            else {
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
                if (CListNames.Contains(newName))
                {
                    Response.Write("Cannot add");
                }
                else {
                    addC.ExecuteNonQuery();
                }
            }
            conn.Close();
            
        }
        protected void deleteClubButton(object sender, EventArgs e) {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String deleteName = deleteclubname.Text;
            String club = "SELECT * from allCLubs";
            SqlCommand allClub = new SqlCommand(club, conn);

            SqlCommand deleteC = new SqlCommand("deleteClub", conn);
            deleteC.CommandType = CommandType.StoredProcedure;
            deleteC.Parameters.Add(new SqlParameter("@clubName", deleteName));



            conn.Open();
            SqlDataReader clubReader = allClub.ExecuteReader();
            if (deleteName.Length > 20)
            {
                Response.Write("name is to long");
            }
            else
            {
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
                if (CListNames.Contains(deleteName))
                {
                    deleteC.ExecuteNonQuery();
                }
                else
                {
                    Response.Write("There is no club");
                }
            }
            conn.Close();
        }
        protected void addNewStadiumButton(object sender, EventArgs e) {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String newName = stadiumname.Text;
            String newLocation = stadiumlocation.Text;
            int newCapacity = Int32.Parse(stadiumcapacity.Text);
            String stadium = "SELECT * from allStadiums";
            SqlCommand allStadium = new SqlCommand(stadium, conn);

            SqlCommand addS = new SqlCommand("addStadium", conn);
            addS.CommandType = CommandType.StoredProcedure;
            addS.Parameters.Add(new SqlParameter("@stadiumName", newName));
            addS.Parameters.Add(new SqlParameter("@location", newLocation));
            addS.Parameters.Add(new SqlParameter("@capacity", newCapacity));



            conn.Open();
            SqlDataReader stadiumReader = allStadium.ExecuteReader();
            if (newName.Length > 20 || newName.Length == 0)
            {
                Response.Write("name is to long or to short");
            }
            else if (newLocation.Length > 20 || newLocation.Length == 0)
            {
                Response.Write("location is to long or to short");
            }
            else if (stadiumcapacity.Text.Length == 0 || newCapacity == 0) {
                Response.Write("Capacity cannot be equal 0");
            }
            else
            {
                ArrayList SListNames = new ArrayList();
                ArrayList SListlocation = new ArrayList();
                ArrayList SListCapacity = new ArrayList();
                while (stadiumReader.Read())
                {
                    String resultname = stadiumReader["name"].ToString();
                    String resultLocation = stadiumReader["location"].ToString();
                    String resultCapacity = stadiumReader["capacity"].ToString();
                    SListNames.Add(resultname);
                    SListlocation.Add(resultLocation);
                    SListlocation.Add(resultCapacity);
                }
                stadiumReader.Close();
                if (SListNames.Contains(newName))
                {
                    Response.Write("Cannot add");
                }
                else
                {
                    addS.ExecuteNonQuery();
                }
            }
            conn.Close();


        }
        protected void deleteStadiumButton(object sender, EventArgs e) {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String deleteName = deleteStadiumBox.Text;
            String stadium = "SELECT * from allStadiums";
            SqlCommand allStadium = new SqlCommand(stadium, conn);

            SqlCommand deleteC = new SqlCommand("deleteStadium", conn);
            deleteC.CommandType = CommandType.StoredProcedure;
            deleteC.Parameters.Add(new SqlParameter("@stadiumName", deleteName));



            conn.Open();
            SqlDataReader stadiumReader = allStadium.ExecuteReader();
            if (deleteName.Length > 20)
            {
                Response.Write("name is to long");
            }
            else
            {
                ArrayList SListNames = new ArrayList();
                while (stadiumReader.Read())
                {
                    String resultname = stadiumReader["name"].ToString();
                    SListNames.Add(resultname);
                }
                stadiumReader.Close();
                if (SListNames.Contains(deleteName))
                {
                    deleteC.ExecuteNonQuery();
                    Response.Write("Done");
                }
                else
                {
                    Response.Write("There is no stadium");
                }
            }
            conn.Close();
        }
        protected void blockFanButton(object sender, EventArgs e) {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String deleteFan = deleteFanBox.Text;
            String fan = "SELECT * from allFans";
            SqlCommand allFan = new SqlCommand(fan, conn);

            SqlCommand blockF = new SqlCommand("blockFan", conn);
            blockF.CommandType = CommandType.StoredProcedure;
            blockF.Parameters.Add(new SqlParameter("@fanNationalId", deleteFan));



            conn.Open();
            SqlDataReader fanReader = allFan.ExecuteReader();
            if (deleteFan.Length > 20)
            {
                Response.Write("nationalid is to long");
            }
            else
            {
                ArrayList FListNationalID = new ArrayList();
                while (fanReader.Read())
                {
                    String resultFanID = fanReader["national_id"].ToString();
                    FListNationalID.Add(resultFanID);
                }
                fanReader.Close();
                if (FListNationalID.Contains(deleteFan))
                {
                    blockF.ExecuteNonQuery();
                    Response.Write("Done");
                }
                else
                {
                    Response.Write("There is no fan");
                }
            }
            conn.Close();
        }
            protected void TextBox5_TextChanged(object sender, EventArgs e)
        {

        }
    }
}