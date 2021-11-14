<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="clientDocument.aspx.cs" Inherits="ClientControl.Operations.clientDocument" MasterPageFile="~/base.Master" %>

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
                    <input type="hidden" id="__inpDocumentCancel" value="" runat="server"/>
                    <table cellpadding="0" cellspacing="0" align="center" width="100%" border="0" style="font-size: medium">
                        <tr>
                            <td colspan="2">
                                <asp:DropDownList ID="ddl_tipo" Style="width: 300px" runat="server" OnSelectedIndexChanged="ddl_change">
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
                                <asp:ImageButton id="ImageButton2" src="../images/pdf.png" OnClick="btn_print_Click" height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" title="Preliminar"/>
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
                                            <asp:DropDownList ID="ddlLotes" runat="server" Width="300px" AutoPostBack="true" DataValueField="folioLote" DataTextField="lote" OnSelectedIndexChanged="ddl_loteChange">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
                        <tr>
                            <td style="width: 150px"># pagar&eacute; inicial:<br />
                                <asp:TextBox ID="txtInicial" runat="server" Width="80" />
                            </td>
                            <td style="width: 150px">Cantidad a generar:<br />
                                <asp:TextBox ID="txtCantidad" runat="server" Width="80" />
                            </td>
                            <td style="width: 150px">Monto:<br />
                                <asp:TextBox ID="txtMonto" runat="server" Width="140" />
                            </td>
                            <td style="width: 15%">
                              <asp:Label ID="fechaInicial" runat="server" Style="font-size: x-large"></asp:Label>&nbsp;&nbsp;&nbsp;
                                 <img id="img_txt_fromDate" src="../images/calendar.png" height="50px" onmouseover="this.style.cursor='pointer'" title="Fecha" onclick="OnClick('inicial')">
                                <div id="divCalendar1" style="display: none; position: absolute;">
                                    <asp:Calendar ID="Calendar1" runat="server" BorderWidth="2px" BackColor="White" Width="200px"
                                        ForeColor="Black" Height="180px" Font-Size="8pt" Font-Names="Verdana" BorderColor="#999999"
                                        BorderStyle="Outset" DayNameFormat="FirstLetter" CellPadding="4" OnSelectionChanged="Calendar1_SelectionChanged">
                                        <TodayDayStyle ForeColor="Black" BackColor="#CCCCCC"></TodayDayStyle>
                                        <SelectorStyle BackColor="#CCCCCC"></SelectorStyle>
                                        <NextPrevStyle VerticalAlign="Bottom"></NextPrevStyle>
                                        <DayHeaderStyle Font-Size="7pt" Font-Bold="True"
                                            BackColor="#CCCCCC"></DayHeaderStyle>
                                        <SelectedDayStyle Font-Bold="True" ForeColor="White"
                                            BackColor="#666666"></SelectedDayStyle>
                                        <TitleStyle Font-Bold="True" BorderColor="Black"
                                            BackColor="#999999"></TitleStyle>
                                        <WeekendDayStyle BackColor="#FFFFCC"></WeekendDayStyle>
                                        <OtherMonthDayStyle ForeColor="#808080"></OtherMonthDayStyle>
                                    </asp:Calendar>
                                </div>
                              <%--  <input id="fechaInicial" runat="server" class='datepicker' size='11' title='D-MMM-YYYY' /> --%>
                            </td>
                            <td style="width: 150px">
                                <asp:Button Text="Generar" runat="server" ID="btnGenerar" OnClick="btnGenerar_Click" />
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" DataKeyNames="NumeroPagare"
                        OnRowDataBound="OnRowDataBound" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added.">
                        <Columns>
                            <asp:BoundField DataField="idDocumento" HeaderText="Folio" InsertVisible="False" ReadOnly="True" SortExpression="idDocumento" />
                            <asp:TemplateField HeaderText="Numero de Pagare" ItemStyle-Width="50">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtNumeroPagare" runat="server" Text='<%#  Eval("NumeroPagare") %>' Width="80"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="fechaVencimiento" DataField="fechaVencimiento" dataformatstring="{0:MM/dd/yyyy}"/>
                            <asp:TemplateField HeaderText="Monto" ItemStyle-Width="150">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtMonto" runat="server" Text='<%# Eval("Monto") %>'></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="balance" DataField="balance" />
                            <asp:CommandField ButtonType="Link" ShowEditButton="false" ShowDeleteButton="true" ItemStyle-Width="150" />
                        </Columns>
                    </asp:GridView>
                    <asp:ImageButton src="../images/save.png" OnClick="btn_save_Click" Height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" />
                </form>
            </article>
        </div>
    </section>
    <%-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>--%>
    <script type="text/javascript">
        function OnClick(valor) {
            if (valor == 'inicial') {
                if (divCalendar1.style.display == "none")
                    divCalendar1.style.display = "";
                else
                    divCalendar1.style.display = "none";
            } else {
                if (divCalendar2.style.display == "none")
                    divCalendar2.style.display = "";
                else
                    divCalendar2.style.display = "none";
            }
        }
    </script>
</asp:Content>

