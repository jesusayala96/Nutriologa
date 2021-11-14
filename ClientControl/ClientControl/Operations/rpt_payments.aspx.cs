using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClientControl.Operations
{
    public partial class rpt_payments : System.Web.UI.Page
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
                fechaFinal.Text = DateTime.Now.ToString("MM/dd/yyyy");
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
        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            fechaFinal.Text = Calendar2.SelectedDate.ToString("MM/dd/yyyy");
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
            fechaInicial.Text = DateTime.Now.ToString("MM/dd/yyyy");
            fechaFinal.Text = DateTime.Now.ToString("MM/dd/yyyy");
            searchValue.Value = "";
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
                sqlCommand = new SqlCommand("stp_opr_clientPayment", con);
                sqlCommand.CommandType = CommandType.StoredProcedure;
                if (all)
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                else
                    sqlCommand.Parameters.AddWithValue("@method", "searchItem");
               
                sqlCommand.Parameters.AddWithValue("@fechaInicial", fechaInicial.Text);
                sqlCommand.Parameters.AddWithValue("@fechaFinal", fechaFinal.Text);
                sqlCommand.Parameters.AddWithValue("@idEstatus", rbl.SelectedValue);
                if (!searchValue.Value.Equals(""))
                    sqlCommand.Parameters.AddWithValue("@value", searchValue.Value);
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

        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {
            string page = "/Operations/web_reporter.aspx?";
            page += "report=rpt_payments";
            if (!searchValue.Value.Trim().Equals(""))
            {
                genSearch = false;
            }
            else
            {
                genSearch = true;
            }

            if (genSearch)
                page += "&method=showAll";
            else
                page += "&method=searchItem";

            page += "&fechaInicial=" + fechaInicial.Text;
            page += "&fechaFinal=" + fechaFinal.Text;
            page += "&idEstatus=" + rbl.SelectedValue;
            if (searchValue.Value != "")
                page += "&value=" + searchValue.Value;
            System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "OpenWindow", "window.open('" + page + "');", true);

        }
    }
}