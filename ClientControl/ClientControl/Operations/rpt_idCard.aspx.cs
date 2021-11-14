using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace ClientControl.Operations
{
    public partial class rpt_idCard : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            searchValue.Value = "0";
            ddl_tipo.SelectedValue = "1";
            this.Search();
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
                this.ClientGridView();
            }
        }
        private void Search()
        {
            nombre.Text = "";
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
                    }
                    #endregion

                    con.Dispose();
                    con.Close();

                    GridView2.DataSource = null;
                    GridView2.DataBind();
                }
            }
        }
        #region [client search]
        private void ClientGridView()
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();
                #region [obtener documentos]
                sqlCommand = new SqlCommand("stp_cat_client", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.Parameters.AddWithValue("@method", "searchItem");
                sqlCommand.Parameters.AddWithValue("@value", searchValue.Value);
                sqlCommand.Parameters.AddWithValue("@idEstatus", "1");
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
        protected void ddl_change(object sender, EventArgs e)
        {
        }
        #endregion
        protected void btn_print_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            if (!searchValue.Value.Trim().Equals(""))
            {
                string page = "/Operations/web_reporter.aspx?";
                page += "report=rpt_idCard";
                page += "&idCliente=" + searchValue.Value;
                //page += "&idEstatus=1";

                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "OpenWindow", "window.open('" + page + "');", true);
            }
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('Verifica que has introducido los campos necesarios');", true);
        }
    }
}