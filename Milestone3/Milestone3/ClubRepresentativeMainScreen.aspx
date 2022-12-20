<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepresentativeMainScreen.aspx.cs" Inherits="Milestone3.ClubRepresentativeMainScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h4>
                Club Name:
            </h4>
            <br />
            <asp:Label ID="name" runat="server" Text=""></asp:Label>
            <br />
            <h4>
                Club Location:
            </h4>
            <br />
            <asp:Label ID="loc" runat="server" Text=""></asp:Label>
        </div>
    </form>
</body>
</html>
