<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRRegister.aspx.cs" Inherits="Milestone3.CRRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>
                Club Representative
            </h1>
            <br />
            <br />
            <h3>
                Name:
            </h3>
            <br />
            <asp:TextBox ID="name" runat="server"></asp:TextBox>
            <br />
            <h3>
                Username:
            </h3>
            <br />
            <asp:TextBox ID="username" runat="server"></asp:TextBox>
            <br />
            <h3>
                Password:
            </h3>
            <br />
            <asp:TextBox ID="password" runat="server"></asp:TextBox>
            <br />
            <h3>
                Club Name:
            </h3>
            <br />
            <asp:TextBox ID="club" runat="server"></asp:TextBox>
            <br />
            <br />
           <asp:Button ID="register" runat="server" onClick="crReg" Text="Register" />
        </div>
    </form>
</body>
</html>
