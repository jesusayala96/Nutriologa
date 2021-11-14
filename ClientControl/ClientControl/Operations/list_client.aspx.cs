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
    public partial class list_client : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        bool genSearch = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.Search(genSearch);
            }
        }

        private void Search(bool all)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();
                sqlCommand = new SqlCommand("stp_cat_client", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                if (all)
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                else
                {
                    if (ddl_tipo.SelectedValue.Equals("1"))
                    {
                        sqlCommand.Parameters.AddWithValue("@method", "showItem");
                        sqlCommand.Parameters.AddWithValue("@idCliente", searchValue.Value);
                    }
                    else
                    {
                        sqlCommand.Parameters.AddWithValue("@method", "searchItem");
                    }
                }
                sqlCommand.Parameters.AddWithValue("@value", searchValue.Value);
                sqlCommand.Parameters.AddWithValue("@idEstatus", rbl.SelectedValue);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dt = new DataTable();
                sqlDataAdapter.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
                con.Dispose();
                con.Close();
            }
        }
        protected void ddl_change(object sender, EventArgs e)
        {
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
            Response.Redirect("/Operations/setup_client.aspx");
        }
        protected void btn_clear_Click(object sender, EventArgs e)
        {
            genSearch = true;
            ddl_tipo.SelectedValue = "1";
            __inpGenSearch.Value = "1";
            searchValue.Value = "";
            this.Search(genSearch);
        }
        protected void btn_search_Click(object sender, EventArgs e)
        {             
            if (!searchValue.Value.Trim().Equals(""))
            {
                genSearch = false;
                __inpGenSearch.Value = "0";
            }
            else
            {
                genSearch = true;
                __inpGenSearch.Value = "1";
            }
            this.Search(genSearch); 
        }
    }
}