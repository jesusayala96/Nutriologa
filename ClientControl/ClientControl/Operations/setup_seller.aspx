<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="setup_seller.aspx.cs" Inherits="ClientControl.Operations.setup_seller" MasterPageFile="~/base.Master"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Vendedor</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size: medium">
                        <tr id="Tr1" runat="server" style="background-color: transparent">
                            <td>
                                <input id="idVendedor" type="hidden" runat="server" style="width:300px" />

                                <label>Nombre</label><input id="nombre" type="text" runat="server" style="width:300px" />
                                <label>Apellido Paterno</label><input id="apPaterno" type="text" runat="server" style="width:300px" />
                                <label>Apellido Materno</label><input id="apMaterno" type="text" runat="server" style="width:300px" />
                                <label>Telefono</label><input id="telefono" type="text" runat="server" style="width:300px" />
                                <label>Email</label><input id="email" type="text" runat="server" style="width:300px" />
                                <label>Estatus</label>
                                <asp:DropDownList ID="ddl_status" runat="server" style="width:300px"></asp:DropDownList>
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

