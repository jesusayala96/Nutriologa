using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ClientControl
{
    public partial class login : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();

                sqlCommand = new SqlCommand("stp_cat_users", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@method", "getUser");
                sqlCommand.Parameters.AddWithValue("@username", username.Value);
                sqlCommand.Parameters.AddWithValue("@password", password.Value);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dt = new DataTable();
                sqlDataAdapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    //Redirect to index
                    Session.Add("personId",dt.Rows[0]["personId"].ToString());
                    Response.Redirect("/index.aspx");
                }
                else
                {
                    System.Web.UI.ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('Usuario/Contraseña Incorrectos');", true);
                }
                con.Dispose();
                con.Close();
            }
        }
    }
}