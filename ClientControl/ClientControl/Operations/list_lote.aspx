<%@ Page Title="" Language="C#" MasterPageFile="~/base.Master" AutoEventWireup="true" CodeBehind="list_lote.aspx.cs" Inherits="ClientControl.Operations.list_lote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Lotes</h2>
        </header>
        <div class="post">
            <article>
                 
                <form runat="server" id="form1">
                    <input type="hidden" id="__inpGenSearch" value="1" runat="server"/>
                     <table cellpadding="0" cellspacing="2" align="center" width="100%" border="0" style="font-size:medium" >
                        <tr id="Tr1" runat="server" style="background-color:transparent">
                            <td style="width:1%;vertical-align:top" ><input id="searchValue" type="text" runat="server" style="width:100px" maxlength="3" pattern="^[0-9]*$" title="Número de lote"/></td>
                            <td style="width:1%; vertical-align:top">                               
                                <asp:DropDownList ID="ddl_manzana" style="width:100px" runat="server" ToolTip="Manzana"></asp:DropDownList>
                            </td>
                           <td>
                                <asp:ImageButton id="img1" src="../images/magnifying.png" OnClick="btn_search_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton id="ImageButton3" src="../images/clear.png" OnClick="btn_clear_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
                            </td>
                        </tr>
                        </table>
                    <asp:GridView runat="server" ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="10">
                        <Columns>
                            <asp:BoundField HeaderText="Lote" DataField="numLote" />
                            <asp:BoundField HeaderText="Manzana" DataField="manzana" />
                            <asp:BoundField HeaderText="Superficie" DataField="superficie" />
                            <asp:BoundField HeaderText="Propietario" DataField="propietario" />
                            <asp:BoundField HeaderText="Vendedor" DataField="vendedor" />
                            <asp:BoundField HeaderText="Estatus" DataField="estatus" />
                             <asp:HyperLinkField DataNavigateUrlFields="idLote" DataNavigateUrlFormatString="setup_lote.aspx?idLote={0}"
                                Text="Visualizar..." />
                        </Columns>
                    </asp:GridView>
                    <asp:ImageButton id="ImageButton1" src="../images/new.png" OnClick="btn_new_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" AlternateText="nuevo"/>
                </form>
            </article>
        </div>
    </section>
</asp:Content>
