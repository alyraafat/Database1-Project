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
using System.Globalization;

namespace Milestone3
{
    public partial class FanRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void fanReg(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            String userName = username.Text;
            String passWord = password.Text;
            String Name = name.Text;
            String natId = nationalId.Text;
            String ph = phone.Text;
            String add = address.Text;
            //String bd = birthDate.Text;
            
            String user = "SELECT * from SystemUser";
            SqlCommand allUsers = new SqlCommand(user, conn);
            SqlCommand addFan = new SqlCommand("addFan", conn);
            addFan.CommandType = CommandType.StoredProcedure;
            
            //DateTime result;
            String fan = "SELECT * from allFans";
            SqlCommand allFans = new SqlCommand(fan, conn);
            conn.Open();
            if (Name.Length > 20 || Name.Length == 0)
            {
                Response.Write("<script>alert('name is too long or empty');</script>");
            }
            else if (userName.Length > 20 || userName.Length == 0)
            {
                Response.Write("<script>alert('username is too long or empty');</script>");
            }
            else if (passWord.Length > 20 || passWord.Length == 0)
            {
                Response.Write("<script>alert('password is too long or empty');</script>");
            }

            else if (natId.Length > 20 || natId.Length == 0)
            {
                Response.Write("<script>alert('national id is too long or empty');</script>");
            }
            else if (ph.Length > 20 || ph.Length == 0)
            {
                Response.Write("<script>alert('phone is too long or empty');</script>");
            }
            else if (add.Length > 20 || add.Length == 0)
            {
                Response.Write("<script>alert('address is too long or empty');</script>");
            }
            else if (birthDate.Text.Length > 20 || birthDate.Text.Length == 0 )
            {
                Response.Write("<script>alert('birth date is too long or empty');</script>");
            }
            else
            {
                SqlDataReader fanReader = allFans.ExecuteReader();
                ArrayList FListnatIds = new ArrayList();
                while (fanReader.Read())
                {
                    String resultnatIds = fanReader["national_id"].ToString();
                    FListnatIds.Add(resultnatIds);
                }
                fanReader.Close();
                if (FListnatIds.Contains(natId))
                {
                    Response.Write("<script>alert('national id exists');</script>");
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
                        DateTime bd = DateTime.Parse(birthDate.Text);
                        String date = bd.ToString("yyyy-MM-dd");
                        bd = DateTime.Parse(date);
                        addFan.Parameters.Add(new SqlParameter("@name", Name));
                        addFan.Parameters.Add(new SqlParameter("@password", passWord));
                        addFan.Parameters.Add(new SqlParameter("@username", userName));
                        addFan.Parameters.Add(new SqlParameter("@nationalIdNumber", natId));
                        addFan.Parameters.Add(new SqlParameter("@phoneNumber", ph));
                        addFan.Parameters.Add(new SqlParameter("@address", add));
                        addFan.Parameters.Add(new SqlParameter("@birthDate", bd));
                        addFan.ExecuteNonQuery();
                        Session["user"] = userName;
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        Response.Write("<script>alert('existing username');</script>");
                    }
                }
                
            }   
            conn.Close();  
        }
    }
}