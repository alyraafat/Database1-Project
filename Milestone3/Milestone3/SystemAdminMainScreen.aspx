<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SystemAdminMainScreen.aspx.cs" Inherits="Milestone3.SystemAdminMainScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>System Admin</h1></div>
        Add a new Club:<br />
        1- New Club&#39;s Name<div style="margin-left: 40px">
            <asp:TextBox ID="addname" runat="server"></asp:TextBox>
        </div>
        2- New Club&#39;s Location:<br />
        <div style="margin-left: 40px">
            <asp:TextBox ID="addlocation" runat="server"></asp:TextBox>
        </div>
        <div style="margin-left: 80px">
            <asp:Button ID="Button1" OnClick ="addClubButton" runat="server" Text="Add New Club" />
        </div>
        Delete an existing Club:<br />
        <div style="margin-left: 40px">
            <asp:TextBox ID="deleteclubname" runat="server"></asp:TextBox>
        </div>
        <div style="margin-left: 40px">
            <asp:Button ID="Button2" OnClick="deleteClubButton" runat="server" Text="Delete Existing Club" />
        </div>
        <p>
            Add a New Stadium</p>
        <p>
            1- New Stadium&#39;s Name:</p>
        <p style="margin-left: 40px">
            <asp:TextBox ID="stadiumname" runat="server"></asp:TextBox>
        </p>
        2- New Stadium&#39;s Location:<p style="margin-left: 40px">
            <asp:TextBox ID="stadiumlocation" runat="server"></asp:TextBox>
        </p>
        3- New Stadium&#39;s Capacity:<br />
        <div style="margin-left: 40px">
            <asp:TextBox ID="stadiumcapacity" runat="server"></asp:TextBox>
        </div>
        <div style="margin-left: 40px">
            <asp:Button ID="Button3" OnClick="addNewStadiumButton" runat="server" Text="Button" />
        </div>
        Delete Stadium<br />
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="deleteStadiumBox" runat="server"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="Button4" OnClick="deleteStadiumButton" runat="server" Text="Button" />
        <br />
        Block fan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <p>
            <asp:TextBox ID="deleteFanBox" runat="server" OnTextChanged="TextBox5_TextChanged" style="height: 25px; width: 168px"></asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button5" OnClick="blockFanButton" runat="server" Text="Button" />
        </p>
    </form>
</body>
</html>
