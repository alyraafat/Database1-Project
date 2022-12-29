<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SportsAssociationManagerMainScreen.aspx.cs" Inherits="Milestone3.SportsAssociationManagerMainScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Sports Association Manager:<br />
            1. Add a new match<br />
            Host Name&nbsp;<br />
            <asp:TextBox ID="HostNameAddBox" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <br />
            Guest Name<br />
            <asp:TextBox ID="GuestNameAddBox" runat="server" OnTextChanged="GuestNameAddBox_TextChanged"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            Start Time:&nbsp;&nbsp;&nbsp;
            <br />
            <asp:TextBox ID="addMatchStartTime" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            End Time:
            <br />
            <asp:TextBox ID="addMatchEndTime" runat="server" type="datetime-local"></asp:TextBox>
            </div>
        <asp:Button ID="Button1" runat="server" OnClick ="addMatchButton" Text="Add a new Match" />
        <br />
        <br />
        <br />
        <div>
            2. Delete a match<br />
            Host Name&nbsp;<br />
            <asp:TextBox ID="HostNameAddBox0" runat="server"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <br />
            Guest Name<br />
            <asp:TextBox ID="GuestNameAddBox0" runat="server" OnTextChanged="GuestNameAddBox_TextChanged"></asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            Start Time:&nbsp;&nbsp;&nbsp;
            <br />
            <asp:TextBox ID="deleteMatchStartTime" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            End Time:<br />
            <asp:TextBox ID="deleteMatchEndTime" runat="server" type="datetime-local"></asp:TextBox>
            </div>
        <asp:Button ID="Button2" runat="server" OnClick ="deleteMatchButton" Text="Delete Match" />
        <br />
        <br />
        Upcoming Matches:<br />
        <br />
            <asp:GridView ID="matches" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="host_club_name" HeaderText="Host Club" />
                    <asp:BoundField DataField="guest_club_name" HeaderText="Guest Club" />
                    <asp:BoundField DataField="start_time" HeaderText="Start Time" />
                    <asp:BoundField DataField="end_time" HeaderText="End Time" />
                </Columns>
            </asp:GridView>
            <br />
        Already Played Matches:<br />
        <br />
            <asp:GridView ID="matches0" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="host_club_name" HeaderText="Host Club" />
                    <asp:BoundField DataField="guest_club_name" HeaderText="Guest Club" />
                    <asp:BoundField DataField="start_time" HeaderText="Start Time" />
                    <asp:BoundField DataField="end_time" HeaderText="End Time" />
                </Columns>
            </asp:GridView>
            <br />
        Clubs Never Played Each other:<br />
        <br />
            <asp:GridView ID="neverPlaying" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="club1_name" HeaderText="Host Club" />
                    <asp:BoundField DataField="club2_name" HeaderText="Guest Club" />
                </Columns>
            </asp:GridView>
            <br />
            <br />
        <br />
    </form>
</body>
</html>
