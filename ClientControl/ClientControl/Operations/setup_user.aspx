<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="setup_user.aspx.cs" Inherits="ClientControl.Operations.setup_user" MasterPageFile="~/base.Master"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Usuario</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size:medium" >
                        <tr id="Tr1" runat="server" style="background-color:transparent">
                            <td>
                                <input id="idUsuario" type="hidden" runat="server" style="width:300px"/>
                                 <label>Nombre</label><input id="nombre" type="text" runat="server" style="width:300px"/>
                            </td>
                            <td>
                                <label>Usuario</label><input id="accesoNombre" type="password" runat="server" style="width:300px"/>
                                <label>Password</label><input id="accesoPwd" type="password" runat="server" style="width:300px"/>
                            </td>
                        </tr>
                        <tr id="Tr2" runat="server" style="background-color:transparent">
                            <td>
                                <label>Estatus</label>
                                <asp:DropDownList ID="ddl_status" style="width:300px" runat="server"></asp:DropDownList>
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