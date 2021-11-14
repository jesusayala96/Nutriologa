<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="documentCancel.aspx.cs" Inherits="ClientControl.Operations.documentCancel" MasterPageFile="~/base.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Cancelar Pagarés</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <input type="hidden" runat="server" id="__inpType" />
                    <table cellpadding="0" cellspacing="0" align="center" width="100%" border="0" style="font-size: medium">
                        <tr>
                            <td colspan="2">
                                <asp:DropDownList ID="ddl_tipo" style="width:300px" runat="server" OnSelectedIndexChanged="ddl_change">
                                    <asp:ListItem Text="Por N&uacute;mero" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Por Nombre" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr runat="server" style="background-color: transparent">
                            <td style="vertical-align: top" width="100px">
                                <input id="searchValue" type="text" runat="server" style="width: 300px" />
                            </td>
                            <td>
                                <asp:ImageButton id="img1" src="../images/magnifying.png" OnClick="btn_search_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton id="ImageButton3" src="../images/clear.png" OnClick="btn_clear_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
                            </td>
                        </tr>
                        <tr><td  colspan="2">
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" PageSize="10" AllowPaging="false" OnRowCommand="GridView2_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="idCliente" HeaderText="idCliente" InsertVisible="False" ReadOnly="True" SortExpression="idCliente" />
                                    <asp:BoundField DataField="nombreCliente" HeaderText="Nombre" SortExpression="nombreCliente" />
                                    <asp:ButtonField CommandName="Seleccione" Text="Seleccione" ButtonType="Button"/>
                                </Columns>
                            </asp:GridView>
                        </td></tr>
                        <tr style="background-color: transparent">
                            <td colspan="2">
                                <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size: medium">
                                    <tr id="Tr3" runat="server" >
                                        <td colspan="5" nowrap style="background-color:white;font-size:x-large;">
                                            <input id="client_id" type="hidden" runat="server" />
                                            <asp:Label runat="server" ID="nombre"></asp:Label>
                                            <asp:Label id="apPaterno" runat="server"></asp:Label>
                                            <asp:Label runat="server" ID="apMaterno"></asp:Label>                                            
                                        </td>
                                    </tr>
                                    <tr id="Tr4" runat="server" style="background-color: transparent">
                                        <td nowrap width="10%">
                                            <asp:Label ID="Label1" runat="server">Motivo de Cancelaci&oacute;n: </asp:Label>
                                        </td>
                                        <td width="10%">
                                             <input id="comentarios" type="text" runat="server" style="width: 300px" />
                                        </td>
                                        <td nowrap width="60%" style="text-align:right;font-size:x-large">
                                            <asp:Label ID="Label2" runat="server">Total: </asp:Label>
                                        </td>
                                        <td style="text-align:left">
                                            <asp:Label runat="server" ID="a_cancelar"   style="width: 300px;font-size:xx-large" Text="$0.00"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                           
                                        </td>
                                        <td nowrap style="text-align:right">
                                            <asp:ImageButton id="ImageButton1" src="../images/voucher.png" OnClick="btn_save_Click"   height="100px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="GridView1" AutoGenerateColumns="False" CssClass="GridViewStyle"
                        runat="server" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="10">
                        <RowStyle CssClass="RowStyle" />
                        <AlternatingRowStyle CssClass="AltRowStyle" />
                        <HeaderStyle CssClass="HeaderStyle" />
                        <Columns>
                            <asp:BoundField HeaderText="folio" DataField="idDocumento"/>
                            <asp:BoundField HeaderText="#Pagar&eacute;" DataField="numero" />
                            <asp:BoundField HeaderText="Lote" DataField="lote" />
                            <asp:BoundField HeaderText="Manzana" DataField="manzana" />
                            <asp:BoundField HeaderText="Total" DataField="total" />
                            <asp:BoundField HeaderText="FechaVencimiento" DataField="fechaVencimiento" dataformatstring="{0:dd/MM/yyyy}"/>
                            <asp:TemplateField HeaderText="Seleccione">
                                <ItemTemplate>
                                    <asp:CheckBox ID="ChkStatus" runat="server" Text="cancelar" Checked="false" AutoPostBack="true" OnCheckedChanged="ChkStatus_CheckedChanged" Height="10px"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </form>
                    
            </article>
        </div>
           
    </section>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript">
       
    </script>
</asp:Content>

