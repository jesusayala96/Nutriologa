<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list_user.aspx.cs" Inherits="ClientControl.Operations.list_user" MasterPageFile="~/base.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Usuarios</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <asp:GridView runat="server" ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="20">
                        <Columns>
                            <asp:BoundField HeaderText="Nombre" DataField="nombre" />
                            <asp:HyperLinkField DataNavigateUrlFields="userId" DataNavigateUrlFormatString="setup_user.aspx?userId={0}" 
                                Text="Visualizar..." />
                        </Columns>
                    </asp:GridView>
                    <asp:ImageButton id="ImageButton1" src="../images/new.png" OnClick="btn_new_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" AlternateText="nuevo"/>
                </form>
            </article>
        </div>
    </section>
</asp:Content>

