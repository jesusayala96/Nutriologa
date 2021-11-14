<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="clientPayment.aspx.cs" Inherits="ClientControl.Operations.clientPayment" MasterPageFile="~/base.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Pagos</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
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
                                <input id="searchValue" type="text" runat="server" style="width: 300px"/>
                            </td>
                            <td>
                                <asp:ImageButton id="img1" src="../images/magnifying.png" OnClick="btn_search_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton id="ImageButton3" src="../images/clear.png" OnClick="btn_clear_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
                            </td>
                        </tr>
                         <tr><td  colspan="2">
                            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"  PageSize="10" AllowPaging="false" OnRowCommand="GridView2_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="idCliente" HeaderText="idCliente" InsertVisible="False" ReadOnly="True" SortExpression="idCliente" />
                                    <asp:BoundField DataField="nombreCliente" HeaderText="Nombre" SortExpression="nombreCliente" />
                                    <asp:ButtonField CommandName="Seleccione" Text="Seleccione" ButtonType="Button" />
                                </Columns>
                            </asp:GridView>
                        </td></tr>
                        <tr runat="server" style="background-color: transparent">
                            <td colspan="2">
                                <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size: medium">
                                    <tr runat="server" >
                                        <td colspan="7" nowrap style="background-color:white;font-size:x-large;">
                                            <input id="idCliente" type="hidden" runat="server" />
                                           <%-- <asp:Label runat="server">Cliente: </asp:Label>--%>
                                            <asp:Label runat="server" ID="nombre"></asp:Label>
                                            <asp:Label runat="server" id="apPaterno" ></asp:Label>
                                            <asp:Label runat="server" ID="apMaterno"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr runat="server" style="background-color: transparent">
                                        <td nowrap width="10%">
                                            <asp:Label runat="server">Referencia de Pago: </asp:Label>
                                        </td>
                                        <td width="10%">
                                             <input id="referencia" type="text" runat="server" style="width: 300px" />
                                        </td>
                                        <td nowrap width="60%" style="text-align:right;font-size:x-large">
                                            <asp:Label ID="Label2" runat="server">Penalizaci&oacute;n: $</asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="penalizacion" runat="server" Width="100px" OnTextChanged="ChkStatus_CheckedChanged" AutoPostBack="true" ></asp:TextBox>
                                        </td>
                                        <td nowrap width="60%" style="text-align:right;font-size:x-large">
                                            <asp:Label ID="Label1" runat="server">Total: </asp:Label>
                                        </td>
                                        <td style="text-align:left">
                                            <asp:Label runat="server" ID="a_pagar"   style="width: 300px;font-size:xx-large" Text="$0.00"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                           
                                        </td>
                                        <td nowrap style="text-align:right">
                                            <asp:ImageButton id="ImageButton1" src="../images/currency.png" OnClick="btn_save_Click"   height="100px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
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
                            <asp:BoundField HeaderText="numeroLote" DataField="numeroLote" />
                            <asp:BoundField HeaderText="manzana" DataField="manzana" />
                            <asp:BoundField HeaderText="fechaVencimiento" DataField="fechaVencimiento" dataformatstring="{0:dd/MM/yyyy}"/>
                            <asp:BoundField HeaderText="total" DataField="total" />
                            <asp:BoundField HeaderText="balance" DataField="balance" />
                            <asp:TemplateField HeaderText="monto">
                                <ItemTemplate>
                                    <asp:TextBox ID="monto" runat="server" Width="100px" Text='<%# Bind("monto") %>' AutoPostBack="true" OnTextChanged="ChkStatus_CheckedChanged" Height="30px"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Seleccione">
                                <ItemTemplate>
                                    <asp:CheckBox ID="ChkStatus" runat="server" Text="pagar" Checked="false" AutoPostBack="true" OnCheckedChanged="ChkStatus_CheckedChanged" Height="10px"/>
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
