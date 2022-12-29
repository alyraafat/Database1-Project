<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanMainScreen.aspx.cs" Inherits="Milestone3.FanMainScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Fan Main Screen</div>
        <p>
            Host Name&nbsp;
            <br />
            <asp:TextBox ID="HostNameAddBox" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <br />
            <br />
            Guest Name
            <br />
            <asp:TextBox ID="GuestNameAddBox" runat="server" ></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:TextBox ID="purchaseDate" runat="server" type="datetime-local"></asp:TextBox>

        <p>
            <asp:Button ID="Button1" runat="server" Height="32px" Text="Purchase Ticket" OnClick = "onPurchaseClick" />
        </p>
        <h4>Enter date to see available matches</h4>
        <asp:TextBox ID="dateOfAvailableMatches" runat="server" type="datetime-local"></asp:TextBox>
        <br />
        <br />
        <asp:Button ID="Button2" runat="server" onClick="showAvailableMatches" Text="Show" />
        <br />
        <asp:GridView ID="availableMatches" runat="server" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="host_club_name" HeaderText="Host Club" />
                <asp:BoundField DataField="guest_club_name" HeaderText="Guest Club" />
                <asp:BoundField DataField="stadium_name" HeaderText="Stadium Name" />
                <asp:BoundField DataField="location" HeaderText="Stadium Location" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
