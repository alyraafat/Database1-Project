<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanRegister.aspx.cs" Inherits="Milestone3.FanRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>
                Fan
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
                National Id:
            </h3>
            <br />
            <asp:TextBox ID="nationalId" runat="server"></asp:TextBox>
            <br />
            <h3>
                Phone Number:
            </h3>
            <br />
            <asp:TextBox ID="phone" runat="server"></asp:TextBox>
            <br />
            <h3>
                Address:
            </h3>
            <br />
            <asp:TextBox ID="address" runat="server"></asp:TextBox>
            <br />
            <h3>
                Birth Date:
            </h3>
            <br />
            <asp:TextBox ID="birthDate" runat="server" type="date"></asp:TextBox>
            <br />
            <br />
           <asp:Button ID="register" runat="server" onClick="fanReg" Text="Register" />
        </div>
    </form>
</body>
</html>
