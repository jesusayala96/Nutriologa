using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ClientControl.Operations
{
    public partial class setup_lote : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                idLote.Value = Request.QueryString["idLote"];
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                {
                    con.Open();

                    sqlCommand = new SqlCommand("stp_cat_status", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                    sqlCommand.Parameters.AddWithValue("@tipo", 2);
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dt = new DataTable();
                    sqlDataAdapter.Fill(dt);
                    ddl_status.DataSource = dt;
                    ddl_status.DataTextField = "estatus";
                    ddl_status.DataValueField = "idEstatus";
                    ddl_status.DataBind();

                    sqlCommand = new SqlCommand("stp_cat_manzana", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dt = new DataTable();
                    sqlDataAdapter.Fill(dt);
                    ddl_manzana.DataSource = dt;
                    ddl_manzana.DataTextField = "manzana";
                    ddl_manzana.DataValueField = "idManzana";
                    ddl_manzana.DataBind();

                    sqlCommand = new SqlCommand("stp_cat_tipo", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dt = new DataTable();
                    sqlDataAdapter.Fill(dt);
                    ddl_type.DataSource = dt;
                    ddl_type.DataTextField = "precioEnganche";
                    ddl_type.DataValueField = "tipo";
                    ddl_type.DataBind();                   

                    sqlCommand = new SqlCommand("stp_cat_seller", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                    //sqlCommand.Parameters.AddWithValue("@idEstatus", "1");
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dt = new DataTable();
                    sqlDataAdapter.Fill(dt);
                    ddl_vendedor.DataSource = dt;                    
                    ddl_vendedor.DataTextField = "nombreCompletoDropDown";
                    ddl_vendedor.DataValueField = "idVendedor";
                    ddl_vendedor.DataBind();
                    ddl_vendedor.Items.Insert(0, "---Seleccione---");
                    ddl_vendedor.SelectedIndex = 0;

                    if (!String.IsNullOrEmpty(idLote.Value))
                    {
                        sqlCommand = new SqlCommand("stp_cat_lote", con);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@method", "showItem");
                        sqlCommand.Parameters.AddWithValue("@idLote", idLote.Value);
                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        dt = new DataTable();
                        sqlDataAdapter.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            //Fill fields
                            idLote.Value = dt.Rows[0]["idLote"].ToString();
                            numLote.Value = dt.Rows[0]["numLote"].ToString();
                            idCliente.Value = dt.Rows[0]["idCliente"].ToString();
                            porComision.Value = dt.Rows[0]["porComision"].ToString();
                            superficie.Value = dt.Rows[0]["superficie"].ToString();
                            //txt_saleDate.Value = dt.Rows[0]["fechaVenta"].ToString();
                            enganche.Value = dt.Rows[0]["enganche"].ToString();

                            ddl_manzana.SelectedValue = dt.Rows[0]["idManzana"].ToString();
                            ddl_status.SelectedValue = dt.Rows[0]["idEstatus"].ToString();
                            ddl_type.SelectedValue = dt.Rows[0]["tipo"].ToString();
                            ddl_vendedor.SelectedValue = dt.Rows[0]["idVendedor"].ToString();
                        }
                    }

                    con.Dispose();
                    con.Close();
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
                    sqlCommand = new SqlCommand("stp_cat_lote", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "saveItem");
                    sqlCommand.Parameters.AddWithValue("@idPersona", Session["personId"].ToString());
                    //Fill parameters
                    if (!String.IsNullOrEmpty(idLote.Value))
                        sqlCommand.Parameters.AddWithValue("@idLote", idLote.Value);
                    sqlCommand.Parameters.AddWithValue("@numLote", numLote.Value);
                    sqlCommand.Parameters.AddWithValue("@idManzana", ddl_manzana.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@idEstatus", ddl_status.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@tipo", ddl_type.SelectedValue);
                    if (ddl_vendedor.SelectedIndex > 0)
                        sqlCommand.Parameters.AddWithValue("@idVendedor", ddl_vendedor.SelectedValue);
                    if (!String.IsNullOrEmpty(idCliente.Value))
                        sqlCommand.Parameters.AddWithValue("@idCliente", idCliente.Value);
                    sqlCommand.Parameters.AddWithValue("@superficie", superficie.Value);
                    sqlCommand.Parameters.AddWithValue("@porComision", porComision.Value);
                    sqlCommand.Parameters.AddWithValue("@enganche", enganche.Value);
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                    sqlCommand.ExecuteNonQuery();

                    con.Dispose();
                    con.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado correctamente')", true);
                    Response.Redirect("/Operations/list_lote.aspx");
                }
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
            }
        }
        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/list_lote.aspx");
        }
    }
}