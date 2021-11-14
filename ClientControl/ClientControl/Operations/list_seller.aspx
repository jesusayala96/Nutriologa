<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list_seller.aspx.cs" Inherits="ClientControl.Operations.list_seller" MasterPageFile="~/base.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Vendedores</h2>
        </header>
        <div class="post">
            <article>
                 
                <form runat="server" id="form1">
                    <input type="hidden" id="__inpGenSearch" value="1" runat="server"/>
                     <table cellpadding="0" cellspacing="2" align="center" width="100%" border="0" style="font-size:medium" >
                        <tr id="Tr1" runat="server" style="background-color:transparent">
                            <td style="width:1%;vertical-align:top" ><input id="searchValue" type="text" runat="server" style="width:100px"/></td>
                           <td>
                                <asp:ImageButton id="img1" src="../images/magnifying.png" OnClick="btn_search_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton id="ImageButton3" src="../images/clear.png" OnClick="btn_clear_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
                            </td>
                        </tr>
                        </table>
                    <asp:GridView runat="server" ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="10">
                        <Columns>
                            <asp:BoundField HeaderText="Vendedor" DataField="idVendedor" />
                            <asp:BoundField HeaderText="Nombre" DataField="nombreCompleto" />
                            <asp:BoundField HeaderText="Estatus" DataField="estatus" />
                             <asp:HyperLinkField DataNavigateUrlFields="idVendedor" DataNavigateUrlFormatString="setup_seller.aspx?idVendedor={0}"
                                Text="Visualizar..." />
                        </Columns>
                    </asp:GridView>
                    <asp:ImageButton id="ImageButton1" src="../images/new.png" OnClick="btn_new_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" AlternateText="nuevo"/>
                </form>
            </article>
        </div>
    </section>
</asp:Content>
