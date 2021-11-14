using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace ClientControl.Operations
{
    public partial class list_manzana : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.Search(true);
            }

        }

        private void Search(bool all)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();
                sqlCommand = new SqlCommand("stp_cat_manzana", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                if(all)
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                else
                    sqlCommand.Parameters.AddWithValue("@method", "searchItem");
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
            this.Search(true);
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Operations/setup_manzana.aspx");
        }
        protected void btn_clear_Click(object sender, EventArgs e)
        {
            searchValue.Value = "";
            this.Search(true);
        }
        protected void btn_search_Click(object sender, EventArgs e)
        {
            if (!searchValue.Value.Trim().Equals(""))
            {
                this.Search(false);
            }
        }
    }
}