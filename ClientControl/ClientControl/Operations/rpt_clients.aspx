<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="rpt_clients.aspx.cs" MasterPageFile="~/base.Master" Inherits="ClientControl.Operations.rpt_clients" %>
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
                    <table cellpadding="0" cellspacing="2" align="center" width="100%" border="0" style="font-size:medium" >
                        <tr id="Tr1" runat="server" style="background-color:transparent">
                            <td style="width:1%;vertical-align:top" ><input id="searchValue" type="text" runat="server" style="width:300px"/></td>
                            <td><asp:Button Text="Buscar" ID="btn_searchClient" OnClick="btn_searchClient_Click" runat="server" />
                                <button onclick="printReport()" >Print</button>
                            </td></tr>

                        </table>
                    <asp:GridView runat="server" ID="GridView1" ShowHeaderWhenEmpty="true" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging" PageSize="10">
                        <Columns>
                            <asp:BoundField HeaderText="Cliente" DataField="client_id" />
                            <asp:BoundField HeaderText="Nombre" DataField="nombre" />
                            <asp:BoundField HeaderText="Apellido Paterno" DataField="ap_paterno" />
                            <asp:BoundField HeaderText="Apellido Materno" DataField="ap_materno" />
                            <asp:HyperLinkField DataNavigateUrlFields="client_id" DataNavigateUrlFormatString="setup_client.aspx?client_id={0}"
                                Text="Visualizar..." />
                        </Columns>
                    </asp:GridView>
                     
                </form>
            </article>
        </div>
    </section>
    <script type="text/javascript">
        function printReport() {
            var page = "/Operations/web_reporter.aspx?";
            page += "report=rpt_clients"
            //page +="&parametro=valor"
            window.open(page);
        }
    </script>
</asp:Content>
