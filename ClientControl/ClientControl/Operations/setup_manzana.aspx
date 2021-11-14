<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="setup_manzana.aspx.cs" Inherits="ClientControl.Operations.setup_manzana" MasterPageFile="~/base.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Manzana</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size: medium">
                        <tr runat="server" style="background-color: transparent">
                            <td>
                                <input id="idManzana" type="hidden" runat="server" style="width:300px" />

                                <label>Manzana</label><input id="manzana" type="text" runat="server" style="width:300px" />
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
