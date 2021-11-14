<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rpt_documents.aspx.cs" Inherits="ClientControl.Operations.rpt_documents" MasterPageFile="~/base.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Pagarés</h2>
        </header>
        <div class="post">

            <article>
                <form runat="server" id="form1">
                    <input type="hidden" id="__inpGenSearch" value="1" runat="server"/>
                    <table cellpadding="0" cellspacing="0" align="center" width="100%" border="0" style="font-size: medium">
                        <tr id="Tr1" runat="server" style="background-color: transparent">
                            <td style="vertical-align: top;width:15%" >
                                <input id="searchValue" type="text" runat="server" style="width: 300px" title="Nombre de Cliente"/></td>
                            <td style="width:15%">
                                 <asp:Label id="fechaInicial" runat="server" style="font-size:x-large"></asp:Label>&nbsp;&nbsp;&nbsp;
                                 <img id="img_txt_fromDate" src="../images/calendar.png"  onclick="OnClick('inicial')" height="50px" onMouseOver="this.style.cursor='pointer'" title="Fecha">
                                <div id="divCalendar1" style="DISPLAY: none; POSITION: absolute;" >
                                    <asp:Calendar id="Calendar1" runat="server" BorderWidth="2px" BackColor="White" Width="200px"
                                    ForeColor="Black" Height="180px" Font-Size="8pt" Font-Names="Verdana" BorderColor="#999999"  
                                    BorderStyle="Outset" DayNameFormat="FirstLetter" CellPadding="4"  OnSelectionChanged="Calendar1_SelectionChanged">
                                    <TodayDayStyle ForeColor="Black" BackColor="#CCCCCC">
                                      </TodayDayStyle>
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
                            </td>
                            <td style="width:35%;text-align:right">
                                <asp:ImageButton id="ImageButton1" src="../images/magnifying.png" OnClick="btn_search_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" title="Buscar"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton id="ImageButton2" src="../images/clear.png" OnClick="btn_clear_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" title="Limpiar Filtros"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:ImageButton id="ImageButton3" src="../images/pdf.png" OnClick="btn_print_Click" height="50px" onMouseOver="this.style.cursor='pointer'" runat="server" title="Preliminar"/>
                            </td>
                        </tr>
                         <tr style="height:10px">
                            <td colspan="4">
                                <asp:RadioButtonList ID="rbl" runat="Server" RepeatDirection="Horizontal" BorderWidth="0">
                                    <asp:ListItem Text="Pagados" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Vencidos" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="Cancelados" Value="4"></asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr id="Tr2" runat="server" style="background-color: transparent">
                            <td colspan="4">
                                <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size: medium">
                                    
                                    <tr id="Tr4" runat="server" style="background-color: transparent">
                                        <td>
                                            <label>Total</label>
                                            <asp:Label runat="server" ID="a_pagar"   style="width: 300px;font-size:xx-large" Text="$0.00"/>&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:GridView ID="GridView1" AutoGenerateColumns="False" CssClass="GridViewStyle"
                        runat="server" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="15">
                        <RowStyle CssClass="RowStyle" />
                        <AlternatingRowStyle CssClass="AltRowStyle" />
                        <HeaderStyle CssClass="HeaderStyle" />
                        <Columns>
                            <asp:BoundField HeaderText="Cliente" DataField="idCliente"/>
                            <asp:BoundField HeaderText="nombre" DataField="nombre" />
                            <asp:BoundField HeaderText="folio pagaré" DataField="idDocumento" />
                             <asp:BoundField HeaderText="numero" DataField="numero" />
                             <asp:BoundField HeaderText="total" DataField="total"/>
                            <asp:BoundField HeaderText="balance" DataField="balance"/>
                            <asp:BoundField HeaderText="lote" DataField="numeroLote"/>
                            <asp:BoundField HeaderText="manzana" DataField="manzana"/>
                            <asp:BoundField HeaderText="estatus" DataField="estatus"/>
                            <asp:BoundField HeaderText="fecha último pago" DataField="fechaPago" dataformatstring="{0:dd/MM/yyyy}"/>
                            <asp:BoundField HeaderText="fecha vencimiento" DataField="fechaVencimiento" dataformatstring="{0:dd/MM/yyyy}"/>
                        </Columns>
                    </asp:GridView>
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