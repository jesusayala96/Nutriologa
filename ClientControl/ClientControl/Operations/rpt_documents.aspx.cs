using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClientControl.Operations
{
    public partial class rpt_documents : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        bool genSearch = true;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                fechaInicial.Text = DateTime.Now.ToString("MM/dd/yyyy");
                this.Search(genSearch);
            }
        }
        protected void btn_search_Click(object sender, EventArgs e)
        {
            a_pagar.Text = "$0.00";
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
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            fechaInicial.Text = Calendar1.SelectedDate.ToString("MM/dd/yyyy");
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
        protected void btn_clear_Click(object sender, EventArgs e)
        {
            searchValue.Value = "";
            fechaInicial.Text = DateTime.Now.ToString("MM/dd/yyyy");
            a_pagar.Text = "$0.00";
            genSearch = true;
            __inpGenSearch.Value = "1";
            this.Search(genSearch);
        }
        protected void Search(bool all)
        {
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();

                #region [obtener documentos]
                sqlCommand = new SqlCommand("stp_opr_clientDocument", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                if (all)
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                else
                    sqlCommand.Parameters.AddWithValue("@method", "searchItem");
                sqlCommand.Parameters.AddWithValue("@fechaInicial", fechaInicial.Text);
                if (!searchValue.Value.Equals(""))
                    sqlCommand.Parameters.AddWithValue("@value", searchValue.Value);

                sqlCommand.Parameters.AddWithValue("@idEstatus", rbl.SelectedValue);
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                dt = new DataTable();
                sqlDataAdapter.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();

                double sum = 0;
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        double v = Convert.ToDouble(dt.Rows[i]["monto"].ToString());
                        sum += v;
                    }
                }
                a_pagar.Text = sum.ToString("C");
                #endregion

                con.Dispose();
                con.Close();
            }

        }

        protected void btn_print_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            if (!searchValue.Value.Trim().Equals(""))
            {
                genSearch = false;
            }
            else
            {
                genSearch = true;
            }

            string page = "/Operations/web_reporter.aspx?";
            page += "report=rpt_documents";
            if (genSearch)
                page += "&method=showAll";
            else
                page += "&method=searchItem";
          
            page += "&fechaInicial=" + fechaInicial.Text;
            page += "&idEstatus="+rbl.SelectedValue;
            if (!searchValue.Value.Equals(""))
                page += "&value="+searchValue.Value;

            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "OpenWindow", "window.open('" + page + "');", true);
        }
    }
}