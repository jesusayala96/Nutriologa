using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClientControl.Operations
{
    public partial class clientPayment : System.Web.UI.Page
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
        
        protected void btn_save_Click(object sender, EventArgs e)
        {            
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                conn.Open();
                SqlTransaction safetransaction = conn.BeginTransaction();

                try
                {
                    double aPagar = 0;
                    aPagar =double.Parse(a_pagar.Text.Replace("$", "").Replace(",", "").ToString());

                    if (aPagar > 0)
                    {
                        sqlCommand = new SqlCommand("stp_opr_clientPayment", conn, safetransaction);
                        sqlCommand.CommandType = CommandType.StoredProcedure;
                        sqlCommand.Parameters.AddWithValue("@method", "savePayment");

                        //Fill parameters
                        sqlCommand.Parameters.AddWithValue("@idCliente", searchValue.Value);
                        sqlCommand.Parameters.AddWithValue("@idPersona", Session["personId"].ToString());
                        sqlCommand.Parameters.AddWithValue("@monto", a_pagar.Text.Replace("$", "").Replace(",", ""));
                        sqlCommand.Parameters.AddWithValue("@referencia", referencia.Value);
                        if (!penalizacion.Text.ToString().Trim().Equals(""))
                            sqlCommand.Parameters.AddWithValue("@penalizacion", penalizacion.Text);

                        sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                        //sqlCommand.ExecuteNonQuery();

                        object paymentId = sqlCommand.ExecuteScalar();
                        foreach (GridViewRow gvr in GridView1.Rows)
                        {
                            CheckBox cb = (CheckBox)gvr.FindControl("ChkStatus");
                            if (cb.Checked && cb != null)
                            {
                                TextBox Amount = (TextBox)(gvr.FindControl("monto"));
                                // idDocumento = gvr.FindControl("idDocumento");
                                if (!string.IsNullOrWhiteSpace(Amount.Text))
                                {
                                    //double v = Convert.ToDouble(Amount.Text);
                                    sqlCommand = new SqlCommand("stp_opr_clientPayment", conn, safetransaction);
                                    sqlCommand.CommandType = CommandType.StoredProcedure;
                                    sqlCommand.Parameters.AddWithValue("@method", "saveMovement");

                                    //Fill parameters
                                    sqlCommand.Parameters.AddWithValue("@idPersona", Session["personId"].ToString());
                                    sqlCommand.Parameters.AddWithValue("@idDocumento", gvr.Cells[0].Text.ToString());
                                    sqlCommand.Parameters.AddWithValue("@idPago", paymentId);
                                    sqlCommand.Parameters.AddWithValue("@monto", Amount.Text);

                                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                                    sqlCommand.ExecuteNonQuery();
                                }
                            }
                        }

                        safetransaction.Commit();
                        conn.Dispose();
                        conn.Close();
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado correctamente')", true);
                        btn_clear_Click(sender, e);
                        //Response.Redirect("/Operations/clientPayment.aspx");
                    }
                }
                catch (Exception ex)
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
                    safetransaction.Rollback();
                    conn.Dispose();
                    conn.Close();
                }
               
            }
        }
   
        protected void ChkStatus_CheckedChanged(object sender, EventArgs e)
        {
            double sum = 0;
            double penalizacion_ = 0;
            if (!penalizacion.Text.ToString().Trim().Equals(""))
                penalizacion_=double.Parse(penalizacion.Text);
            sum += penalizacion_;
            foreach (GridViewRow gvr in GridView1.Rows)
            {
                CheckBox cb = (CheckBox)gvr.FindControl("ChkStatus");
                if (cb.Checked && cb != null)
                {
                    TextBox Amount = (TextBox)(gvr.FindControl("monto"));
                    if (!string.IsNullOrWhiteSpace(Amount.Text))
                    {
                        double v = Convert.ToDouble(Amount.Text);
                        sum += v;
                    }
                }
            }
            a_pagar.Text = sum.ToString("C");
        }
        protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            this.Search();
        }
        
        protected void btn_clear_Click(object sender, EventArgs e)
        {
            searchValue.Value = "0";
            nombre.Text = "";
            apMaterno.Text = "";
            apPaterno.Text = "";
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
            a_pagar.Text = "$0.00";
            referencia.Value = "";
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

                    #region [obtener documentos]
                    sqlCommand = new SqlCommand("stp_opr_clientDocument", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "getDocumentToPay");
                    sqlCommand.Parameters.AddWithValue("@idCliente", searchValue.Value);
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dt = new DataTable();
                    sqlDataAdapter.Fill(dt);

                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    #endregion

                    con.Dispose();
                    con.Close();

                    GridView2.DataSource = null;
                    GridView2.DataBind();
                }                
            }
        }
        #region [client search]
        //protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    GridView2.PageIndex = e.NewPageIndex;
        //    this.ClientGridView();
        //    //ClientScript.RegisterStartupScript(this.GetType(), "Popup", "ShowPopup();", true);
        //}

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

                GridView1.DataSource = null;
                GridView1.DataBind();
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
            //searchValue.Value = "";
            //GridView1.DataSource = null;
            //GridView1.DataBind();
            //GridView2.DataSource = null;
            //GridView2.DataBind();
        }
        #endregion
    }
}