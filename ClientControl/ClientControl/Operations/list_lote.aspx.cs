using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace ClientControl.Operations
{
    public partial class list_lote : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        bool genSearch = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                {
                    con.Open();
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
                    con.Dispose();
                    con.Close();

                }
                this.Search(genSearch);
            }
        }

        private void Search(bool all)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();
                sqlCommand = new SqlCommand("stp_cat_lote", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                if (all)
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                else if (!searchValue.Value.Trim().Equals(""))
                    sqlCommand.Parameters.AddWithValue("@method", "searchItem");
                else
                    sqlCommand.Parameters.AddWithValue("@method", "searchItemByManzana");
                sqlCommand.Parameters.AddWithValue("@idManzana", ddl_manzana.SelectedValue);
                sqlCommand.Parameters.AddWithValue("@value", searchValue.Value);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dt = new DataTable();
                sqlDataAdapter.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
                con.Dispose();
                con.Close();
            }
        }

        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            if (__inpGenSearch.Value.Equals("1"))
                genSearch = true;
            else
                genSearch = false;
            this.Search(genSearch);
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/setup_lote.aspx");
        }
        protected void btn_clear_Click(object sender, EventArgs e)
        {   
            genSearch = true;
            __inpGenSearch.Value = "1";
            searchValue.Value = "";
            this.Search(true);
        }
        protected void btn_search_Click(object sender, EventArgs e)
        {
            genSearch = false;
            __inpGenSearch.Value = "0";
            this.Search(genSearch);           
        }
    }
}