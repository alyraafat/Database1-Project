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
            <asp:Label ID="name" runat="server" Text=""></asp:Label>
            <br />
            <h4>
                Club Location:
            </h4>
            <asp:Label ID="loc" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <asp:GridView ID="matches" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="host_club_name" HeaderText="Host Club" />
                    <asp:BoundField DataField="competing_club_name" HeaderText="Guest Club" />
                    <asp:BoundField DataField="start_time" HeaderText="Start Time" />
                    <asp:BoundField DataField="end_time" HeaderText="End Time" />
                    <asp:BoundField DataField="stadium_name" HeaderText="Stadium Name" />
                </Columns>
            </asp:GridView>
            <br />
            <br />
            <h4>
                Date:
            </h4>
            <br />
            <asp:TextBox ID="dateInput" runat="server" type="date"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="show" runat="server" onClick="showStadium" Text="Show" />
            <br />
            <br />
            <asp:GridView ID="availableStadiums" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="name" HeaderText="Stadium Name" />
                    <asp:BoundField DataField="capacity" HeaderText="Capacity" />
                    <asp:BoundField DataField="location" HeaderText="Location" />
                </Columns>
            </asp:GridView>
            <br />
            <br />
            <h5>Stadium Manager</h5>
            <asp:DropDownList ID="smdd" AutoPostBack = "true" runat="server"></asp:DropDownList>
            <br />
            <h4>
                Date Of Request:
            </h4>
            <br />
            <asp:TextBox ID="dateOfRequest" runat="server" type="datetime-local"></asp:TextBox>
            <br />
            <asp:Button ID="Button1" runat="server" onClick="sendRequest" Text="Send" />
        </div>
    </form>
</body>
</html>
