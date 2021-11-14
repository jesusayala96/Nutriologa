using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ClientControl.Operations
{
    public partial class setup_user : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                idUsuario.Value = Request.QueryString["userId"];
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


                if (!String.IsNullOrEmpty(idUsuario.Value))
                    this.Search();
            }
        }

        protected void Search()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();

                sqlCommand = new SqlCommand("stp_cat_users", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@method", "showItem");
                sqlCommand.Parameters.AddWithValue("@userId", Request.QueryString["userId"]);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dt = new DataTable();
                sqlDataAdapter.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    //Fill fields
                    nombre.Value = dt.Rows[0]["nombre"].ToString();
                    accesoNombre.Value = dt.Rows[0]["userName"].ToString();
                    accesoPwd.Value = dt.Rows[0]["password"].ToString();
                    ddl_status.SelectedValue = dt.Rows[0]["idEstatus"].ToString();
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
                    sqlCommand = new SqlCommand("stp_cat_users", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "saveItem");
                    sqlCommand.Parameters.AddWithValue("@idPersona", Session["personId"].ToString());
                    //Fill parameters
                    if (!String.IsNullOrEmpty(idUsuario.Value))
                        sqlCommand.Parameters.AddWithValue("@userId", idUsuario.Value);
                    sqlCommand.Parameters.AddWithValue("@nombre", nombre.Value);
                    sqlCommand.Parameters.AddWithValue("@username", accesoNombre.Value);
                    sqlCommand.Parameters.AddWithValue("@password", accesoPwd.Value);
                    sqlCommand.Parameters.AddWithValue("@idEstatus", ddl_status.SelectedValue);

                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                    sqlCommand.ExecuteNonQuery();

                    con.Dispose();
                    con.Close();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado correctamente')", true);
                    Response.Redirect("/Operations/list_user.aspx");
                }
            }
            catch(Exception error)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
            }
        }
        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/list_user.aspx");
        }
    }
}