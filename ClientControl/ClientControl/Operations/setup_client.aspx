<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="setup_client.aspx.cs" Inherits="ClientControl.Operations.setup_client" MasterPageFile="~/base.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Cliente</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size:medium" >
                        <tr runat="server" style="background-color:transparent">
                            <td>
                                <input id="idCliente" type="hidden" runat="server" style="width:300px"/>
                                <label>Apellido Paterno</label><input id="apPaterno" type="text" runat="server" style="width:300px"/>
                                <label>Calle</label><input id="domCalle" type="text" runat="server" style="width:300px"/>
                               <label>Estado</label><input id="domEstado" type="text" runat="server" style="width:300px"/>
                            </td>
                            <td>
                                <label>Apellido Materno</label><input id="apMaterno" type="text" runat="server" style="width:300px"/> 
                                <label>N&uacute;mero</label><input id="domNum" type="text" runat="server" style="width:300px"/>
                                 <label>RFC</label><input id="RFC" type="text" runat="server" style="width:200px"/>
                                
                            </td>
                            <td>
                                <label>Nombre</label><input id="nombre" type="text" runat="server" style="width:300px"/>
                                <label>Colonia</label><input id="domColonia" type="text" runat="server" style="width:300px"/>
                                <label>Ocupaci&oacute;n</label><input id="ocupacion" type="text" runat="server" style="width:300px"/>
                            </td>
                            <td>
                                <label>E-mail</label><input id="email" type="text" runat="server" style="width:300px"/>
                                <label>Ciudad</label><input id="domCiudad" type="text" runat="server" style="width:300px"/>
                                <label>Tel&eacute;fono casa</label><input id="telCasa" type="text" runat="server" style="width:300px"/>
                                <label>Referencia</label><input id="referencia" type="text" runat="server" style="width:300px"/>
                            </td>
                        </tr>
                        <tr runat="server" style="background-color:transparent">
                            <td colspan="3"> <label>Observaciones</label><input id="observaciones" type="text" runat="server" style="width:900px"/></td>
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
