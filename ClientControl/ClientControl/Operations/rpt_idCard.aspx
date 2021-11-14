<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rpt_idCard.aspx.cs" Inherits="ClientControl.Operations.rpt_idCard" MasterPageFile="~/base.Master"%>

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
                        <tr id="Tr1" runat="server" style="background-color: transparent">
                            <td style="vertical-align: top" width="100px">
                                <input id="searchValue" type="text" runat="server" style="width: 300px"/>
                            </td>
                            <td>
                                <asp:ImageButton id="img1" src="../images/magnifying.png" OnClick="btn_search_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton id="ImageButton3" src="../images/clear.png" OnClick="btn_clear_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
                                <asp:ImageButton id="ImageButton2" src="../images/pdf.png" OnClick="btn_print_Click" height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" title="Preliminar"/>
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
                        <tr id="Tr2" runat="server" style="background-color: transparent">
                            <td colspan="2">
                                <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size: medium">
                                    <tr id="Tr3" runat="server" >
                                        <td colspan="5" nowrap style="background-color:white;font-size:x-large;">
                                            <input id="idCliente" type="hidden" runat="server" />
                                            <asp:Label runat="server" ID="nombre"></asp:Label>
                                            <asp:Label runat="server" ID="apPaterno"></asp:Label>
                                            <asp:Label runat="server" ID="apMaterno"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </form>
            </article>
        </div>
    </section>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript">

        
    </script>
</asp:Content>
