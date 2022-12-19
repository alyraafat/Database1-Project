using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.Runtime.Remoting.Messaging;

namespace Milestone3
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login(object sender, EventArgs e)
        {

            String connStr = WebConfigurationManager.ConnectionStrings["FootballDB"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand systemUsers = new SqlCommand("SystemUsers", conn);
            systemUsers.CommandType = CommandType.StoredProcedure;
            conn.Open();
            string sql = "SELECT * from SystemUser";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataReader rdr = cmd.ExecuteReader();
            while (rdr.Read())
            {
                String name = rdr.GetString(rdr.GetOrdinal("username"));
                Label n = new Label();
                n.Text = name;
                form1.Controls.Add(n)
            }
            conn.Close();

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}