using System;
using System.Collections;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Milestone3
{
    public partial class SAMRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void samReg(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String userName = username.Text;
            String passWord = password.Text;
            String Name = name.Text;
            String user = "SELECT * from SystemUser";
            SqlCommand allUsers = new SqlCommand(user, conn);
            SqlCommand addSAM = new SqlCommand("addAssociationManager", conn);
            addSAM.CommandType = CommandType.StoredProcedure;
            addSAM.Parameters.Add(new SqlParameter("@name", Name));
            addSAM.Parameters.Add(new SqlParameter("@password", passWord));
            addSAM.Parameters.Add(new SqlParameter("@username", userName));
            conn.Open();
            if (Name.Length > 20 || Name.Length == 0)
            {
                Response.Write("name is too long or empty");
            }
            else if (passWord.Length > 20 || passWord.Length == 0)
            {
                Response.Write("password is too long or empty");
            }
            else if (userName.Length > 20 || userName.Length == 0)
            {
                Response.Write("username is too long or empty");
            }
            else
            {
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
                if (!UListUsernames.Contains(userName))
                {
                    addSAM.ExecuteNonQuery();
                    Session["user"] = userName;
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    Response.Write("existing username");
                }
            }
            conn.Close();
        }
    }
}