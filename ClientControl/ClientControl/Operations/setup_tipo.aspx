<%@ Page Title="" Language="C#" MasterPageFile="~/base.Master" AutoEventWireup="true" CodeBehind="setup_tipo.aspx.cs" Inherits="ClientControl.Operations.setup_tipo" %>

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
                                <input id="tipo" type="hidden" style="width: 300px" runat="server" />

                                <label>Precio</label>
                                <input id="precio" type="text" style="width: 300px" runat="server" />
                                
                                <label>Enganche</label>
                                <input id="enganche" type="text" style="width: 300px" runat="server" />

                                <label>Ultima Actualizacion</label>
                                <input id="fechaUA" type="text" style="width: 300px" runat="server" readonly="true"/>

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
