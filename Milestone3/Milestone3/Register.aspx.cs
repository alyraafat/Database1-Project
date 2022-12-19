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

        protected void register(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String userName = username.Text;
            String passWord = password.Text;
            String Name = name.Text;
            String dd = DropDownList1.Text;
            String user = "SELECT * from SystemUser";
            SqlCommand allUsers = new SqlCommand(user, conn);
            SqlCommand addSM = new SqlCommand("addStadiumManager", conn);
            addSM.CommandType = CommandType.StoredProcedure;
            addSM.Parameters.Add(new SqlParameter("@name", Name));
            addSM.Parameters.Add(new SqlParameter("@password", passWord));
            addSM.Parameters.Add(new SqlParameter("@username", userName));
            addSM.Parameters.Add(new SqlParameter("@stadiumname", Name));
            SqlCommand addRep = new SqlCommand("addFan", conn);
            addRep.CommandType = CommandType.StoredProcedure;
            addRep.Parameters.Add(new SqlParameter("@repname", Name));
            addRep.Parameters.Add(new SqlParameter("@password", passWord));
            addRep.Parameters.Add(new SqlParameter("@username", userName));
            addRep.Parameters.Add(new SqlParameter("@clubname", Name));
            SqlCommand addFan = new SqlCommand("addFan", conn);
            addFan.CommandType = CommandType.StoredProcedure;
            addFan.Parameters.Add(new SqlParameter("@name", Name));
            addFan.Parameters.Add(new SqlParameter("@password", passWord));
            addFan.Parameters.Add(new SqlParameter("@username", userName)); addFan.Parameters.Add(new SqlParameter("@name", Name));
            addFan.Parameters.Add(new SqlParameter("@nationalIdNumber", passWord));
            addFan.Parameters.Add(new SqlParameter("@birthDate", userName));
            addFan.Parameters.Add(new SqlParameter("@address", userName));
            addFan.Parameters.Add(new SqlParameter("@phoneNumber", userName));
            SqlCommand addSAM = new SqlCommand("addAssociationManager", conn);
            addSAM.CommandType = CommandType.StoredProcedure;
            addSAM.Parameters.Add(new SqlParameter("@name", Name));
            addSAM.Parameters.Add(new SqlParameter("@password", passWord));
            addSAM.Parameters.Add(new SqlParameter("@username", userName));

            conn.Open();
            SqlDataReader userReader = allUsers.ExecuteReader();
            ArrayList UListUsernames = new ArrayList();
            ArrayList UListPassword = new ArrayList();
            while (userReader.Read())
            {
                String resultusernames = userReader["username"].ToString();
                String resultpasswords = userReader["password"].ToString();
                UListUsernames.Add(resultusernames);
                UListPassword.Add(resultpasswords);
            }
            userReader.Close();
            if (!UListUsernames.Contains(userName)){
                if (dd.Equals("Sports Association Manager")){
                    addSAM.ExecuteNonQuery();
                }
                else if (dd.Equals("Fan")){
                    addFan.ExecuteNonQuery();
                }
                else if (dd.Equals("Club Representative")) {
                    addRep.ExecuteNonQuery();
                }
                else if (dd.Equals("Stadium Manager")) {
                    addSM.ExecuteNonQuery();
                }
            }
            else {
                Response.Write("I love lulu");
            }
        }
    }
}