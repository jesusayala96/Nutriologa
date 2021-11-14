using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClientControl.Operations
{
    public partial class rpt_contractByClient : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;

        List<Document> documents = new List<Document>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                ddlLotes.DataSource = null;
            }
        }
        protected void btn_search_Click(object sender, EventArgs e)
        {
            if (ddl_tipo.SelectedValue.Equals("1"))
            {
                if (searchValue.Value.Trim().Equals(""))
                    searchValue.Value = "0";
                this.Search();
            }
            else
            {
                ClientGridView();
            }
        }
       
        protected void Search()
        {
            //a_pagar.Text = "$0.00";
            if (!searchValue.Value.Trim().Equals(""))
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                {
                    con.Open();
                    #region[obtener datos cliente]
                    sqlCommand = new SqlCommand("stp_cat_client", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "showItem");
                    sqlCommand.Parameters.AddWithValue("@idEstatus", "1");
                    sqlCommand.Parameters.AddWithValue("@idCliente", searchValue.Value);
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dt = new DataTable();
                    sqlDataAdapter.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        //Fill fields
                        apPaterno.Text = dt.Rows[0]["apPaterno"].ToString();
                        apMaterno.Text = dt.Rows[0]["apMaterno"].ToString();
                        nombre.Text = dt.Rows[0]["nombre"].ToString();

                        //Buscar Lotes Comprados, sin pagares realizados
                        sqlCommand = new SqlCommand("stp_opr_document", con);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@method", "showLotes");
                        sqlCommand.Parameters.AddWithValue("@idCliente", searchValue.Value);
                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                        dt = new DataTable();
                        sqlDataAdapter.Fill(dt);
                        DataRow row = dt.NewRow();
                        row["folioLote"] = "-1";
                        row["lote"] = "SELECCIONE";
                        dt.Rows.InsertAt(row, 0);
                        ddlLotes.DataSource = dt;
                        ddlLotes.DataBind();

                    }
                    #endregion

                    con.Dispose();
                    con.Close();

                    GridView2.DataSource = null;
                    GridView2.DataBind();
                }
            }
        }
        protected void btn_clear_Click(object sender, EventArgs e)
        {
            searchValue.Value = "0";
            ddl_tipo.SelectedValue = "1";
            this.Search();
        }
        #region [client search]
        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            ClientGridView();
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup();", true);
        }

        private void ClientGridView()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();
                #region [obtener documentos]
                sqlCommand = new SqlCommand("stp_cat_client", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@method", "searchItem");
                sqlCommand.Parameters.AddWithValue("@idEstatus", "1");
                sqlCommand.Parameters.AddWithValue("@value", searchValue.Value);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dt = new DataTable();
                sqlDataAdapter.Fill(dt);

                GridView2.DataSource = dt;
                GridView2.DataBind();
                #endregion

                con.Dispose();
                con.Close();
            }
        }
        protected void GridView2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            searchValue.Value = GridView2.Rows[rowIndex].Cells[0].Text;
            ddl_tipo.SelectedValue = "1";
            Search();
        }
        #endregion

        protected void btn_print_Click(object sender, ImageClickEventArgs e)
        {
            if (ddlLotes.SelectedIndex > 0)
            {
                string page = "/Operations/web_reporter.aspx?";
                if (solId.SelectedValue == "1")
                    page += "report=rpt_contractByClientHORA";
                else page += "report=rpt_contractByClientMOGA";
                page += "&idCliente=" + searchValue.Value;
                page += "&idLote=" + int.Parse(ddlLotes.SelectedValue);
                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "OpenWindow", "window.open('" + page + "');", true);
            }
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('Verifica que has introducido los campos necesarios');", true);
        }
    }
}