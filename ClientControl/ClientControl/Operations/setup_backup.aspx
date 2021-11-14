<%@ Page Title="" Language="C#" MasterPageFile="~/base.Master" AutoEventWireup="true" CodeBehind="setup_backup.aspx.cs" Inherits="ClientControl.Operations.setup_backup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section>
        <header class="major">
            <h2>Respaldo</h2>
        </header>
        <div class="post">
            <article>
                <form runat="server" id="form1">
                    <table cellpadding="0" cellspacing="2" align="center" width="100%" bgcolor="#fdffed" border="0" style="font-size:medium" >
                        <tr id="Tr1" runat="server" style="background-color:transparent">
                            <td>
                                 <label>Generacion de respaldo</label>
                            </td>
                        </tr>
                    </table>
                    <asp:ImageButton id="btn_respaldo" src="../images/save.png" OnClick="btn_respaldo_Click"   height="50px" onMouseOver="this.style.cursor='pointer'" runat="server"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </form>
            </article>
        </div>
    </section>
</asp:Content>
