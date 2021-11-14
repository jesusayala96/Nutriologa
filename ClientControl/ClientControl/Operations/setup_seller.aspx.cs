using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ClientControl.Operations
{
    public partial class setup_seller : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                idVendedor.Value = Request.QueryString["idVendedor"];
                if (!String.IsNullOrEmpty(idVendedor.Value))
                {
                    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                    {
                        con.Open();

                        sqlCommand = new SqlCommand("stp_cat_status", con);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@method", "showAll");
                        sqlCommand.Parameters.AddWithValue("@tipo", "3");
                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        dt = new DataTable();
                        sqlDataAdapter.Fill(dt);
                        ddl_status.DataSource = dt;
                        ddl_status.DataTextField = "estatus";
                        ddl_status.DataValueField = "idEstatus";
                        ddl_status.DataBind();


                        sqlCommand = new SqlCommand("stp_cat_seller", con);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@method", "showItem");
                        sqlCommand.Parameters.AddWithValue("@idVendedor", idVendedor.Value);
                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        dt = new DataTable();
                        sqlDataAdapter.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            //Fill fields
                            nombre.Value = dt.Rows[0]["nombre"].ToString();
                            apPaterno.Value = dt.Rows[0]["apPaterno"].ToString();
                            apMaterno.Value = dt.Rows[0]["apMaterno"].ToString();
                            telefono.Value = dt.Rows[0]["telefono"].ToString();
                            email.Value = dt.Rows[0]["email"].ToString();
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
                    sqlCommand = new SqlCommand("stp_cat_seller", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "saveItem");

                    //Fill parameters
                    if (!String.IsNullOrEmpty(idVendedor.Value))
                        sqlCommand.Parameters.AddWithValue("@idVendedor", idVendedor.Value);
                    sqlCommand.Parameters.AddWithValue("@nombre", nombre.Value);
                    sqlCommand.Parameters.AddWithValue("@apPaterno", apPaterno.Value);
                    sqlCommand.Parameters.AddWithValue("@apMaterno", apMaterno.Value);
                    sqlCommand.Parameters.AddWithValue("@idEstatus", ddl_status.SelectedValue);

                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                    sqlCommand.ExecuteNonQuery();

                    con.Dispose();
                    con.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado correctamente')", true);
                    Response.Redirect("/Operations/list_seller.aspx");
                }
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
            }
        }
        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/list_seller.aspx");
        }
    }
}