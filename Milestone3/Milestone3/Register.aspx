<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Milestone3.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Register<br />
            Name:</div>
        <p>
            <asp:TextBox ID="name" runat="server" Height="16px"></asp:TextBox>
        </p>
        <p>
            <asp:Label ID="Label1" runat="server" Text="Username"></asp:Label>
            :</p>
        <p>
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
        </p>
        <p>
            Password:</p>
        <p>
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>Sports Association Manager</asp:ListItem>
                <asp:ListItem>Fan</asp:ListItem>
                <asp:ListItem>Club Representative</asp:ListItem>
                <asp:ListItem>Stadium Manager</asp:ListItem>
            </asp:DropDownList>
        </p>
        <asp:Button ID="Button" runat="server" OnClick="register" Text="Register" />
    </form>
</body>
</html>
