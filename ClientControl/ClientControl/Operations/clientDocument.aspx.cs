using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Text.RegularExpressions;
namespace ClientControl.Operations
{
    public partial class clientDocument : System.Web.UI.Page
    {
        SqlCommand sqlCommand;
        SqlDataAdapter sqlDataAdapter;
        DataTable dt;
        bool genSearch = true;
        List<Document> documents = new List<Document>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                ddlLotes.DataSource = null;
                fechaInicial.Text = DateTime.Now.ToString("MM/dd/yyyy");
                //fechaInicial.Value = DateTime.Now.ToString("MM/dd/yyyy");
                this.BindGrid();
            }
            documents = (List<Document>)ViewState["currentGrid"];
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
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            fechaInicial.Text = Calendar1.SelectedDate.ToString("MM/dd/yyyy");
            //NADA
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
        private void SearchDocuments()
        {
            documents = new List<Document>();
            if (!searchValue.Value.Trim().Equals("") && ddlLotes.SelectedIndex>0)
            {
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                {
                    con.Open();
                    #region [obtener documentos]
                    sqlCommand = new SqlCommand("stp_opr_clientDocument", con);
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@method", "showAll");
                    sqlCommand.Parameters.AddWithValue("@idCliente", searchValue.Value);
                    sqlCommand.Parameters.AddWithValue("@idLote", ddlLotes.SelectedValue);
                    sqlCommand.Parameters.AddWithValue("@idEstatus", "1");
                    sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                    dt = new DataTable();
                    sqlDataAdapter.Fill(dt);
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        documents.Add(
                            new Document()
                            {
                                IdDocumento = dt.Rows[i]["idDocumento"].ToString(),
                                NumeroPagare = int.Parse(dt.Rows[i]["numeroPagare"].ToString()),
                                Monto = Decimal.Parse(dt.Rows[i]["monto"].ToString()),
                                Balance = Decimal.Parse(dt.Rows[i]["balance"].ToString()),
                                FechaVencimiento = DateTime.Parse(dt.Rows[i]["fechaVencimiento"].ToString()).ToString("MM/dd/yyyy")
                            });
                    }
                    this.BindGrid();//aqui
                    #endregion

                    con.Dispose();
                    con.Close();
                }
            }
        }
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (ddlLotes.SelectedIndex > 0)
            {
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
                {
                    conn.Open();
                    SqlTransaction safetransaction = conn.BeginTransaction();

                    try
                    {
                        foreach (GridViewRow gvr in GridView1.Rows)
                        {
                            if (gvr.Cells[0].Text.ToString().Equals("-1"))
                            {
                            sqlCommand = new SqlCommand("stp_opr_document", conn, safetransaction);
                            sqlCommand.CommandType = CommandType.StoredProcedure;

                            sqlCommand.Parameters.AddWithValue("@method", "saveDocument");
                            sqlCommand.Parameters.AddWithValue("@idPersona", Session["personId"].ToString());
                            sqlCommand.Parameters.AddWithValue("@numeroPagare", ((TextBox)gvr.Cells[1].FindControl("txtNumeroPagare")).Text);
                                sqlCommand.Parameters.AddWithValue("@fechaVencimiento", gvr.Cells[2].Text.ToString());//gvr.Cells[1].Text.ToString());//DateTime.Parse(((Label)gvr.Cells[1].FindControl("lblVencimiento")).Text).ToString("MM/dd/yyyy"));
                            sqlCommand.Parameters.AddWithValue("@monto", Decimal.Parse(((TextBox)gvr.Cells[3].FindControl("txtMonto")).Text));

                            sqlCommand.Parameters.AddWithValue("@folioLote", int.Parse(ddlLotes.SelectedValue));
                            sqlCommand.Parameters.AddWithValue("@idCliente", searchValue.Value);
                            sqlCommand.ExecuteNonQuery();
                        }
                        }
                        string[] lines = Regex.Split(__inpDocumentCancel.Value, ",");
                        for (int i = 1; i < lines.Length; i++) {
                            string idDocument = lines[i];
                            if (!idDocument.Equals("-1"))
                            {
                                sqlCommand = new SqlCommand("stp_opr_clientDocument", conn, safetransaction);
                                sqlCommand.CommandType = CommandType.StoredProcedure;
                                sqlCommand.Parameters.AddWithValue("@method", "cancelDocument");
                                sqlCommand.Parameters.AddWithValue("@idDocumento", idDocument);
                                sqlDataAdapter = new SqlDataAdapter(sqlCommand);
                                sqlCommand.ExecuteNonQuery();
                            }
                        }
                        safetransaction.Commit();
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado correctamente')", true);
                        Response.Redirect("/Operations/clientDocument.aspx");
                        //btn_clear_Click(sender, e);
                    }
                    catch (Exception ex)
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
                        safetransaction.Rollback();
                        conn.Dispose();
                        conn.Close();
                    }
                    conn.Dispose();
                    conn.Close();
                    this.Search();
                }
            }
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Seleccione un Lote')", true);
        }
        private void BindGrid()
        {
            ViewState["currentGrid"] = documents;
            documents = (List<Document>)ViewState["currentGrid"];
            GridView1.DataSource = documents;
            GridView1.DataBind();
        }
        protected void DocumentGeneration()
        {
            int numDocuments = int.Parse(txtCantidad.Text);
            int month = 0;
            int day = 0;
            int year = 0;
            string date = fechaInicial.Text;
            //string date = fechaInicial.Value;
            string date_ = "";
            string[] lines = Regex.Split(date, "/");
            
            month = int.Parse(lines[0].ToString());
            day = int.Parse(lines[1].ToString());
            year = int.Parse(lines[2].ToString());
            decimal monto = decimal.Parse(txtMonto.Text);
            int inicial = int.Parse(txtInicial.Text);

            for (int i = 0; i < numDocuments; i++)
            {
                date_ = month.ToString("#00") + "/" + day.ToString("#00") + "/" + year.ToString();
                documents.Add(
                    new Document()
                    {
                        IdDocumento="-1",
                        NumeroPagare = inicial,
                        Monto = monto,
                        Balance = monto,
                        FechaVencimiento = date_
                    });
                //date = date.AddMonths(1);
                month++;
                if (month > 12)
                {
                    month = 1;
                    year++;
                }
                inicial++;
            }
            this.BindGrid();
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se agregaron [" + numDocuments +"] pagarés')", true);
        }
        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            __inpDocumentCancel.Value += "," + documents[e.RowIndex].IdDocumento;
                documents.RemoveAt(e.RowIndex);
                this.BindGrid();
        }
        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow && e.Row.RowIndex != GridView1.EditIndex)
            {
                //if (e.Row.Cells[0].Text.ToString().Equals("-1"))
                //{
                    (e.Row.Cells[5].Controls[0] as LinkButton).Attributes["onclick"] = "return confirm('Do you want to delete this row?');";
                //}
                //else
                //{
                //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('No se puede cancelar');", true);
                //}
            }
        }
        protected void btn_clear_Click(object sender, EventArgs e)
        {
            __inpDocumentCancel.Value = "";
            apPaterno.Text = "";
            apMaterno.Text = "";
            nombre.Text = "";
            searchValue.Value = "0";
            ddl_tipo.SelectedValue = "1";
            txtInicial.Text = "";
            txtCantidad.Text = "";
            txtMonto.Text = "";
            GridView1.Dispose();
            GridView1.DataSource = null;
            GridView1.DataBind();
            GridView2.DataSource = null;
            GridView2.DataBind();
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
                GridView1.Dispose();
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
        #endregion
        protected void ddl_change(object sender, EventArgs e)
        {
            //searchValue.Value = "";
            //GridView1.DataSource = null;
            //GridView1.DataBind();
            //GridView2.DataSource = null;
            //GridView2.DataBind();
        }
        protected void ddl_loteChange(object sender, EventArgs e)
        {
            __inpDocumentCancel.Value = "";
            documents= new List<Document>();
            GridView1.DataSource = null;
            GridView1.Dispose();
            GridView1.DataBind();
            this.SearchDocuments();
        }
       
        protected void btnGenerar_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtCantidad.Text)
                && !string.IsNullOrEmpty(txtInicial.Text)
                && ddlLotes.SelectedIndex > 0 
                && int.Parse(txtCantidad.Text) > 0 
                && int.Parse(txtInicial.Text) > 0 
                && Decimal.Parse(txtMonto.Text) > 0)
                DocumentGeneration();
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('Verifica que has introducido los campos necesarios');", true);
        }
        protected void btn_print_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            if (ddlLotes.SelectedIndex > 0)
            {
                string page = "/Operations/web_reporter.aspx?";
                page += "report=rpt_clientDocument";
                page += "&idCliente=" + searchValue.Value;
                page += "&idLote=" + ddlLotes.SelectedValue;
                page += "&idEstatus=1";

                System.Web.UI.ScriptManager.RegisterClientScriptBlock(Page, typeof(Page), "OpenWindow", "window.open('" + page + "');", true);
            }
            else
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "AlertBox", "alert('Verifica que has introducido los campos necesarios');", true);
        }

    }
    [Serializable]
    public class Document
    {
        string idDocumento;
        int numeroPagare;
        Decimal monto;
        Decimal balance;
        string fechaVencimiento;
        public string IdDocumento
        {
            get { return idDocumento; }
            set { idDocumento = value; }
        }
        public int NumeroPagare
        {
            get { return numeroPagare; }
            set { numeroPagare = value;}
        }
        public Decimal Monto
        {
            get { return monto; }
            set{monto = value;}
        }
        public Decimal Balance
        {
            get { return balance; }
            set{balance = value;}
        }
        public string FechaVencimiento
        {
            get { return fechaVencimiento; }
            set { fechaVencimiento = value; }
        }
    }
}