using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ClientControl.Operations
{
    public partial class setup_client : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                idCliente.Value = Request.QueryString["idCliente"];
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                {
                    con.Open();
                    sqlCommand = new SqlCommand("stp_cat_status", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                    sqlCommand.Parameters.AddWithValue("@tipo", 3);
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dt = new DataTable();
                    sqlDataAdapter.Fill(dt);
                    ddl_status.DataSource = dt;
                    ddl_status.DataTextField = "estatus";
                    ddl_status.DataValueField = "idEstatus";
                    ddl_status.DataBind();

                    con.Dispose();
                    con.Close();
                }


                if (!String.IsNullOrEmpty(idCliente.Value))
                    this.Search();
            }
        }

        protected void Search()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();

                sqlCommand = new SqlCommand("stp_cat_client", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@method", "showItem");
                sqlCommand.Parameters.AddWithValue("@idCliente", Request.QueryString["idCliente"]);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dt = new DataTable();
                sqlDataAdapter.Fill(dt);

                 if (dt.Rows.Count > 0)
                 {
                     //Fill fields
                     apPaterno.Value = dt.Rows[0]["apPaterno"].ToString();
                     apMaterno.Value = dt.Rows[0]["apMaterno"].ToString();
                     nombre.Value = dt.Rows[0]["nombre"].ToString();
                     RFC.Value = dt.Rows[0]["RFC"].ToString();
                     ocupacion.Value = dt.Rows[0]["ocupacion"].ToString();
                     domCalle.Value = dt.Rows[0]["domCalle"].ToString();
                     domNum.Value = dt.Rows[0]["domNum"].ToString();
                     domColonia.Value = dt.Rows[0]["domColonia"].ToString();
                     domCiudad.Value = dt.Rows[0]["domCiudad"].ToString();
                     domEstado.Value = dt.Rows[0]["domEstado"].ToString();
                     telCasa.Value = dt.Rows[0]["telCasa"].ToString();
                     email.Value = dt.Rows[0]["email"].ToString();
                     ddl_status.SelectedValue = dt.Rows[0]["idEstatus"].ToString();
                     observaciones.Value = dt.Rows[0]["observaciones"].ToString();
                     referencia.Value = dt.Rows[0]["referencia"].ToString();
                 }
                con.Dispose();
                con.Close();
            }
        }
       
        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                {
                    con.Open();
                    sqlCommand = new SqlCommand("stp_cat_client", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "saveItem");
                    sqlCommand.Parameters.AddWithValue("@idPersona", Session["personId"].ToString());
                    //Fill parameters
                    if (!String.IsNullOrEmpty(idCliente.Value))
                        sqlCommand.Parameters.AddWithValue("@idCliente", idCliente.Value);
                    sqlCommand.Parameters.AddWithValue("@apPaterno", apPaterno.Value);
                    sqlCommand.Parameters.AddWithValue("@apMaterno", apMaterno.Value);
                    sqlCommand.Parameters.AddWithValue("@nombre", nombre.Value);
                    sqlCommand.Parameters.AddWithValue("@RFC", RFC.Value);
                    sqlCommand.Parameters.AddWithValue("@ocupacion", ocupacion.Value);
                    sqlCommand.Parameters.AddWithValue("@domCalle", domCalle.Value);
                    sqlCommand.Parameters.AddWithValue("@domNum", domNum.Value);
                    sqlCommand.Parameters.AddWithValue("@domColonia", domColonia.Value);
                    sqlCommand.Parameters.AddWithValue("@domCiudad", domCiudad.Value);
                    sqlCommand.Parameters.AddWithValue("@domEstado", domEstado.Value);
                    sqlCommand.Parameters.AddWithValue("@idEstatus", ddl_status.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@telCasa", telCasa.Value);
                    sqlCommand.Parameters.AddWithValue("@email", email.Value);
                    sqlCommand.Parameters.AddWithValue("@referencia", referencia.Value);
                    sqlCommand.Parameters.AddWithValue("@observaciones", observaciones.Value);

                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                    sqlCommand.ExecuteNonQuery();

                    con.Dispose();
                    con.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado correctamente')", true);
                    Response.Redirect("/Operations/list_client.aspx");
                }
            }
            catch
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
            }
        }
        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/list_client.aspx");
        }
    }
}