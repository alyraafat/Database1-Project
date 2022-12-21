<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManagerMainScreen.aspx.cs" Inherits="Milestone3.StadiumManagerMainScreen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h4>Stadium Name:</h4>
            <asp:Label ID="name" runat="server" Text=""></asp:Label>
            <br />
            <h4>Stadium Location:</h4>
            <asp:Label ID="loc" runat="server" Text=""></asp:Label>
            <br />
            <h4>Stadium Capacity:</h4>
            <asp:Label ID="capacity" runat="server" Text=""></asp:Label>
            <br />
            <h4>Stadium Status:</h4>
            <asp:Label ID="status" runat="server" Text=""></asp:Label>
            <br />
            <br />
            <h4>Requests:</h4>
            <asp:GridView ID="requests" runat="server" OnRowCommand="requestsRowCommand" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="cr_name" HeaderText="Club Representative" />
                    <asp:BoundField DataField="host_club" HeaderText="Host Club" />
                    <asp:BoundField DataField="guest_club" HeaderText="Guest Club" />
                    <asp:BoundField DataField="start_time" HeaderText="Start Time" />
                    <asp:BoundField DataField="end_time" HeaderText="End Time" />
                    <asp:BoundField DataField="status" HeaderText="Request Status" />
                    <asp:TemplateField HeaderText="Accept Request" ItemStyle-Width="150">
                        <ItemTemplate >
                            <asp:LinkButton ID="LinkButton1" runat="server" Text="Accept" CommandName="acc" CommandArgument="<%# Container.DataItemIndex %>"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reject Request" ItemStyle-Width="150" >
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton2" runat="server" Text="Reject" CommandName="rej" CommandArgument="<%# Container.DataItemIndex %>"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
