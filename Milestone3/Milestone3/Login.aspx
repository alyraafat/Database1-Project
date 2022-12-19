<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Milestone3.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 870px; margin-left: 400px">
            Please Login<br />
            username<br />
            <input id="username" type="text" /><br />
            <br />
            password<br />
            <input id="password" type="text" /><br />
            <asp:Button ID="Button1" runat="server" OnClick="login" Text="Button" />
        </div>
    </form>
</body>
</html>
