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
using System.Data.Common;
using System.Collections;

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
            String userName = username.Text;
            String passWord = password.Text;
            String assoc = "SELECT * from allAssocManagers";
            String clubR = "SELECT * from allClubRepresentatives";
            String stadiumM = "SELECT * from allStadiumManagers";
            String fans = "SELECT * from allFans";
            String user = "SELECT * from SystemUser";
            SqlCommand allAssoc = new SqlCommand(assoc, conn);
            SqlCommand allClubR = new SqlCommand(clubR, conn);
            SqlCommand allStadiumM = new SqlCommand(stadiumM, conn);
            SqlCommand allFans = new SqlCommand(fans, conn);
            SqlCommand allUsers = new SqlCommand(user, conn);


            conn.Open();
            SqlDataReader assocReader = allAssoc.ExecuteReader();
            ArrayList AListUsernames = new ArrayList();
            ArrayList AListPassword = new ArrayList();
            while (assocReader.Read())
            {
                String resultusernames = assocReader["username"].ToString();
                String resultpasswords = assocReader["password"].ToString();
                AListUsernames.Add(resultusernames);
                AListPassword.Add(resultpasswords);
            }
            assocReader.Close();
            SqlDataReader clubRReader = allClubR.ExecuteReader();
            ArrayList CListUsernames = new ArrayList();
            ArrayList CListPassword = new ArrayList();
            while (clubRReader.Read())
            {
                String resultusernames = clubRReader["username"].ToString();
                String resultpasswords = clubRReader["password"].ToString();
                CListUsernames.Add(resultusernames);
                CListPassword.Add(resultpasswords);
            }
            clubRReader.Close();
            SqlDataReader stadiumMReader = allStadiumM.ExecuteReader();
            ArrayList SListUsernames = new ArrayList();
            ArrayList SListPassword = new ArrayList();
            while (stadiumMReader.Read())
            {
                String resultusernames = stadiumMReader["username"].ToString();
                String resultpasswords = stadiumMReader["password"].ToString();
                SListUsernames.Add(resultusernames);
                SListPassword.Add(resultpasswords);
            }
            stadiumMReader.Close();
            SqlDataReader fansReader = allFans.ExecuteReader();
            ArrayList FListUsernames = new ArrayList();
            ArrayList FListPassword = new ArrayList();
            while (fansReader.Read())
            {
                String resultusernames = fansReader["username"].ToString();
                String resultpasswords = fansReader["password"].ToString();
                FListUsernames.Add(resultusernames);
                FListPassword.Add(resultpasswords);
            }
            fansReader.Close();
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
                Response.Write("<script>alert('This user does not exist');</script>");
            }
            else if (AListUsernames.Contains(userName))
            {
                int i = AListUsernames.IndexOf(userName);
                String password = AListPassword[i].ToString();
                if (passWord != password)
                    Response.Write("<script>alert('Wrong password');</script>");
                else
                {
                    Session["user"] = userName;
                    Response.Redirect("SportsAssociationManagerMainScreen.aspx");
                }
            }
            else if (CListUsernames.Contains(userName))
            {
                int i = CListUsernames.IndexOf(userName);
                String password = CListPassword[i].ToString();
                if (passWord != password)
                    Response.Write("<script>alert('Wrong password');</script>");
                else
                {
                    Session["user"] = userName;
                    Response.Redirect("ClubRepresentativeMainScreen.aspx");
                }
            }
            else if (SListUsernames.Contains(userName))
            {
                int i = SListUsernames.IndexOf(userName);
                String password = SListPassword[i].ToString();
                if (passWord != password)
                    Response.Write("<script>alert('Wrong password');</script>");
                else
                {
                    Session["user"] = userName;
                    Response.Redirect("StadiumManagerMainScreen.aspx");
                }
            }
            else if (FListUsernames.Contains(userName))
            {
                int i = FListUsernames.IndexOf(userName);
                String password = FListPassword[i].ToString();
                if (passWord != password)
                    Response.Write("<script>alert('Wrong password');</script>");
                else
                {
                    Session["user"] = userName;
                    Response.Redirect("FanMainScreen.aspx");
                }
            }
            else
            {
                int i = UListUsernames.IndexOf(userName);
                String password = UListPassword[i].ToString();
                if (passWord != password)
                    Response.Write("<script>alert('Wrong password');</script>");
                else
                {
                    Response.Redirect("SystemAdminMainScreen.aspx");
                    Session["user"] = userName;
                }
            }
            conn.Close();

        }

        protected void register(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        }

    }
}