using System;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace ClientControl.Operations
{
    public partial class setup_tipo : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                tipo.Value = Request.QueryString["tipo"];
                if (!String.IsNullOrEmpty(tipo.Value))
                {
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                    {
                        con.Open();
                        sqlCommand = new SqlCommand("stp_cat_tipo", con);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@method", "showItem");
                        sqlCommand.Parameters.AddWithValue("@tipo", tipo.Value);
                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        dt = new DataTable();
                        sqlDataAdapter.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            //Fill fields
                            tipo.Value = dt.Rows[0]["tipo"].ToString();
                            enganche.Value = dt.Rows[0]["enganche"].ToString();
                            precio.Value = dt.Rows[0]["precio"].ToString();
                            fechaUA.Value = dt.Rows[0]["fechaUa"].ToString();
                        }

                        con.Dispose();
                        con.Close();
                    }
                }
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                {
                    con.Open();
                    sqlCommand = new SqlCommand("stp_cat_tipo", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "saveItem");

                    //Fill parameters
                    if (!String.IsNullOrEmpty(tipo.Value))
                        sqlCommand.Parameters.AddWithValue("@tipo", tipo.Value);
                    sqlCommand.Parameters.AddWithValue("@enganche", enganche.Value);
                    // sqlCommand.Parameters.AddWithValue("@fechaUA", fechaUA.Value);
                    sqlCommand.Parameters.AddWithValue("@precio", precio.Value);

                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                    sqlCommand.ExecuteNonQuery();

                    con.Dispose();
                    con.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado correctamente')", true);

                    Response.Redirect("/Operations/list_tipo.aspx");
                }
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
            }
        }
        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/list_tipo.aspx");
        }
    }
}