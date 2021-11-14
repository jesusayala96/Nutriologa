<%@ Page Title="" Language="C#" MasterPageFile="~/base.Master" AutoEventWireup="true" CodeBehind="setup_lote.aspx.cs" Inherits="ClientControl.Operations.setup_lote" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Lote</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size: medium">
                        <tr runat="server" style="background-color: transparent">
                            <td>
                                <input id="idLote" type="hidden" style="width:300px" runat="server" />
                                <label>Numero de Lote</label><input id="numLote" type="text" style="width:300px" runat="server" />
                                <label>Manzana</label><asp:DropDownList ID="ddl_manzana" style="width:100px" runat="server"></asp:DropDownList>
                                <label>Precio por m²</label><asp:DropDownList ID="ddl_type" style="width:300px" runat="server"></asp:DropDownList>
                                <label>Enganche Depositado</label><input id="enganche" type="text" style="width:300px" runat="server" />
                            </td>
                            <td>
                                <label>Vendedor</label><asp:DropDownList ID="ddl_vendedor" style="width:400px" runat="server"></asp:DropDownList>
                                <label>%Comision</label><input id="porComision" type="text" style="width:100px" runat="server" />
                                <label>Estatus</label><asp:DropDownList ID="ddl_status" style="width:200px" runat="server"></asp:DropDownList>
                            </td>
                            <td>
                                <label>Superficie</label><input id="superficie" type="text" style="width:200px" runat="server" />
                                <label>#Cliente</label><input id="idCliente" type="text" style="width:100px" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <asp:ImageButton id="ImageButton1" src="../images/save.png" OnClick="btn_save_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:ImageButton id="ImageButton2" src="../images/close.png" OnClick="btn_close_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>
                </form>
            </article>
        </div>
    </section>
</asp:Content>
