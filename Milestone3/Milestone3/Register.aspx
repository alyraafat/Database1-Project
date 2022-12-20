<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Milestone3.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="sam" runat="server" Text="Sports Association Manager" OnClick="sam_Click" />
            <br />
            <br />
            <asp:Button ID="sm" runat="server" Text="Stadium Manager" OnClick="sm_Click" />
            <br />
            <br />
        <asp:Button ID="cr" runat="server" Text="Club Representative" OnClick="cr_Click" />
            <br />
            <br />
            <asp:Button ID="fan" runat="server" Text="Fan" OnClick="fan_Click" />
    </form>
</body>
</html>
