<%@ Page Title="" Language="C#" MasterPageFile="~/base.Master" AutoEventWireup="true" CodeBehind="list_tipo.aspx.cs" Inherits="ClientControl.Operations.list_tipo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <section>
        <header class="major">
            <h2>Precio por metro cuadrado</h2>
        </header>
        <div class="post">
            <article>
                 
                <form runat="server" id="form1">
<%--                     <table cellpadding="0" cellspacing="2" align="center" width="100%" border="0" style="font-size:medium" >
                        <tr id="Tr1" runat="server" style="background-color:transparent">
                            <td style="width:1%;vertical-align:top" ><input id="searchValue" type="text" runat="server" style="width:300px"/></td>
                            <td><asp:Button Text="Buscar" ID="btn_searchTipo" OnClick="btn_search_Click" runat="server" /></td></tr>
                        </table>--%>
                    <asp:GridView runat="server" ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="10">
                        <Columns>
                           <asp:BoundField HeaderText="Tipo" DataField="tipo" />
                            <asp:BoundField HeaderText="Precio por metro cuadrado" DataField="precio" />
                            <asp:BoundField HeaderText="Enganche" DataField="enganche" />
                             <asp:BoundField HeaderText="Ultima Actualizacion" DataField="fechaUA" />
                            <asp:HyperLinkField DataNavigateUrlFields="tipo" DataNavigateUrlFormatString="setup_tipo.aspx?tipo={0}"
                                Text="Visualizar..." />
                        </Columns>
                    </asp:GridView>
                     <asp:ImageButton id="ImageButton1" src="../images/new.png" OnClick="btn_new_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" AlternateText="nuevo"/>
                </form>
            </article>
        </div>
    </section>
</asp:Content>
