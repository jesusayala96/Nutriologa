using System;

namespace ClientControl
{
    public partial class _base : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Redirige a index ---- mandar a login
            if (string.IsNullOrEmpty(Session["personId"] as string))
                Response.Redirect("/login.aspx");
            
        }
    }
}