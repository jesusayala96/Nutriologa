using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ClientControl.Operations
{
    public partial class setup_manzana : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                idManzana.Value = Request.QueryString["idManzana"];
                if (!String.IsNullOrEmpty(idManzana.Value))
                {
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                    {
                        con.Open();

                        sqlCommand = new SqlCommand("stp_cat_status", con);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@method", "showAll");
                        sqlCommand.Parameters.AddWithValue("@tipo", "4");
                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        dt = new DataTable();
                        sqlDataAdapter.Fill(dt);
                        ddl_status.DataSource = dt;
                        ddl_status.DataTextField = "estatus";
                        ddl_status.DataValueField = "idEstatus";
                        ddl_status.DataBind();


                        sqlCommand = new SqlCommand("stp_cat_manzana", con);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@method", "showItem");
                        sqlCommand.Parameters.AddWithValue("@idManzana", idManzana.Value);
                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        dt = new DataTable();
                        sqlDataAdapter.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            //Fill fields
                            manzana.Value = dt.Rows[0]["manzana"].ToString();
                            ddl_status.SelectedValue = dt.Rows[0]["idEstatus"].ToString();
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
                    sqlCommand = new SqlCommand("stp_cat_manzana", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "saveItem");

                    //Fill parameters
                    if (!String.IsNullOrEmpty(idManzana.Value))
                        sqlCommand.Parameters.AddWithValue("@idManzana", idManzana.Value);
                    sqlCommand.Parameters.AddWithValue("@manzana", manzana.Value);
                    //sqlCommand.Parameters.AddWithValue("@estatus", ddl_status.Text);
                    sqlCommand.Parameters.AddWithValue("@idEstatus", ddl_status.SelectedValue);

                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                    sqlCommand.ExecuteNonQuery();

                    con.Dispose();
                    con.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado correctamente')", true);
                    Response.Redirect("/Operations/list_manzana.aspx");
                }
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
            }
        }
        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/list_manzana.aspx");
        }
    }
}