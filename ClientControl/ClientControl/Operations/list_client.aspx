<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list_client.aspx.cs" MasterPageFile="~/base.Master" Inherits="ClientControl.Operations.list_client" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Clientes</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <input type="hidden" id="__inpGenSearch" value="1" runat="server"/>
                    <table cellpadding="0" cellspacing="2" align="center" width="100%" border="0" style="font-size:medium" >
                        <tr>
                            <td colspan="2">
                                <asp:DropDownList ID="ddl_tipo" style="width:300px" runat="server" OnSelectedIndexChanged="ddl_change">
                                    <asp:ListItem Text="Por N&uacute;mero" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Por Nombre" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr id="Tr1" runat="server" style="background-color:transparent">
                            <td style="width:1%;vertical-align:top" ><input id="searchValue" type="text" runat="server" style="width:300px"/></td>
                            <td>
                                <asp:ImageButton id="img1" src="../images/magnifying.png" OnClick="btn_search_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton id="ImageButton3" src="../images/clear.png" OnClick="btn_clear_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
                            </td>
                        </tr>
                         <tr style="height:10px">
                            <td colspan="2">
                                <asp:RadioButtonList ID="rbl" runat="Server" RepeatDirection="Horizontal" BorderWidth="0">
                                    <asp:ListItem Text="Activos" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Cancelados" Value="4"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        </table>
                    <asp:GridView runat="server" ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="20">
                        <Columns>
                            <asp:BoundField HeaderText="Cliente" DataField="idCliente" />
                            <asp:BoundField HeaderText="Nombre" DataField="nombre" />
                            <asp:BoundField HeaderText="Apellido Paterno" DataField="apPaterno" />
                            <asp:BoundField HeaderText="Apellido Materno" DataField="apMaterno" />
                            <asp:HyperLinkField DataNavigateUrlFields="idCliente" DataNavigateUrlFormatString="setup_client.aspx?idCliente={0}" 
                                Text="Visualizar..." />
                        </Columns>
                    </asp:GridView>
                    <asp:ImageButton id="ImageButton1" src="../images/new.png" OnClick="btn_new_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" AlternateText="nuevo"/>
                </form>
            </article>
        </div>
    </section>
</asp:Content>
