<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Milestone3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 870px; margin-left: 400px">
            Please Login
            <br />
            username
            <br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            <br />
            password
            <br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" OnClick="login" Text="Login" />
             <br />
            <br />
            <asp:Button ID="Button2" runat="server" OnClick="register" Text="Register" />
        </div>
    </form>
</body>
</html>
