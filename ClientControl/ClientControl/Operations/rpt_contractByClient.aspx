<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rpt_contractByClient.aspx.cs" Inherits="ClientControl.Operations.rpt_contractByClient" MasterPageFile="~/base.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Pagares</h2>
        </header>
        <div class="post">

            <article>
                <form runat="server" id="form1">
                    <table cellpadding="0" cellspacing="0" align="center" width="100%" border="0" style="font-size: medium">
                        <tr>
                            <td colspan="2">
                                <asp:DropDownList ID="ddl_tipo" Style="width: 300px" runat="server">
                                    <asp:ListItem Text="Por N&uacute;mero" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Por Nombre" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr runat="server" style="background-color: transparent">
                            <td style="vertical-align: top">
                                <input id="searchValue" type="text" runat="server" style="width: 300px" /></td>
                            <td style="width: 95%">
                                <asp:ImageButton ID="img1" src="../images/magnifying.png" OnClick="btn_search_Click" Height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton ID="ImageButton3" src="../images/clear.png" OnClick="btn_clear_Click" Height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" />
                                <asp:ImageButton ID="ImageButton2" src="../images/pdf.png" OnClick="btn_print_Click" Height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" title="Preliminar" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" PageSize="10" AllowPaging="false" OnRowCommand="GridView2_RowCommand">
                                    <Columns>
                                        <asp:BoundField DataField="idCliente" HeaderText="idCliente" InsertVisible="False" ReadOnly="True" SortExpression="idCliente" />
                                        <asp:BoundField DataField="nombreCliente" HeaderText="Nombre" SortExpression="nombreCliente" />
                                        <asp:ButtonField CommandName="Seleccione" Text="Seleccione" ButtonType="Button" />
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr runat="server" style="background-color: transparent">
                            <td colspan="2">
                                <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size: medium">
                                    <tr runat="server" style="background-color: transparent">
                                        <td colspan="2">
                                            <input id="client_id" type="hidden" runat="server" style="width: 300px" />

                                            <label>Cliente</label>
                                            <asp:Label runat="server" ID="nombre"></asp:Label>
                                            <asp:Label runat="server" ID="apPaterno"></asp:Label>
                                            <asp:Label runat="server" ID="apMaterno"></asp:Label>
                                            <asp:Label runat="server">Lote</asp:Label>
                                            <asp:DropDownList ID="ddlLotes" runat="server" Width="300px" AutoPostBack="true" DataValueField="folioLote" DataTextField="lote">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                        <tr>
                            <td style="width: 150px">Formato a Imprimir:<br />
                                <asp:RadioButtonList runat="server" ID="solId">
                                    <asp:ListItem Text="SOLICITUD MOGA" Value="0" />
                                    <asp:ListItem Text="SOLICITUD HORA" Value="1" />
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                    </table>
                </form>
            </article>
        </div>
    </section>
</asp:Content>
