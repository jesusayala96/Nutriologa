using Microsoft.Reporting.WebForms;
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
    public partial class web_reporter : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string reportName = Request.QueryString["report"].ToString();
            string[] parameters = HttpContext.Current.Request.Url.PathAndQuery.Split('&');
            reportViewer.ProcessingMode = ProcessingMode.Local;
            reportViewer.LocalReport.ReportPath = Server.MapPath("/Operations/" + reportName + ".rdlc");

            web_rpt dataSet = GetData(reportName,parameters);

            ReportDataSource datasource = new ReportDataSource(reportName, dataSet.Tables[reportName]);
            reportViewer.LocalReport.DataSources.Clear();
            reportViewer.LocalReport.DataSources.Add(datasource);
            
            Warning[] warnings;
            string[] streamIds;
            string mimeType = string.Empty;
            string encoding = string.Empty;
            string extension = string.Empty;

            byte[] bytes = reportViewer.LocalReport.Render("PDF", null, out mimeType, out encoding, out extension, out streamIds, out warnings);
  
            Response.Buffer = true;
            Response.Clear();
            Response.ContentType = mimeType;
            Response.AddHeader("content-disposition", "attachment; filename= report.pdf");
            Response.BinaryWrite(bytes); // create the file    
            Response.Flush();
        }

        private web_rpt GetData(string report, string[] parameters)
        {

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString))
            {
                con.Open();
                SqlCommand sqlCommand = new SqlCommand();
                SqlDataAdapter sqlDataAdapter;

                switch (report)
                {
                    //AQUI, SOLO AGREGAR EL CASE DeL REPORTE Y A QUE STP VA
                    case "rpt_clients":
                        sqlCommand = new SqlCommand("stp_cat_client", con);
                        sqlCommand.Parameters.AddWithValue("@method", "showItem");
                        break;
                    case "rpt_documents":
                        sqlCommand = new SqlCommand("stp_opr_clientDocument", con);
                        //sqlCommand.Parameters.AddWithValue("@method", "getDocuments");
                        break;
                    case "rpt_payments":
                        sqlCommand = new SqlCommand("stp_opr_clientPayment", con);
                        break;
                    case "rpt_contractByClientHORA":
                        sqlCommand = new SqlCommand("stp_opr_contract", con);
                        sqlCommand.Parameters.AddWithValue("@method", "showByClient");
                        break;
                    case "rpt_contractByClientMOGA":
                        sqlCommand = new SqlCommand("stp_opr_contract", con);
                        sqlCommand.Parameters.AddWithValue("@method", "showByClient");
                        break;
                    case "rpt_clientDocument":
                        sqlCommand = new SqlCommand("stp_opr_clientDocument", con);
                        sqlCommand.Parameters.AddWithValue("@method", "getRptDocuments");
                        break;
                    case "rpt_idCard":
                        sqlCommand = new SqlCommand("stp_cat_credencial", con);
                        sqlCommand.Parameters.AddWithValue("@method", "showItem");
                        break;
                }

                sqlCommand.CommandType = CommandType.StoredProcedure;
                //PARAMETERS
                for (int i = 1; i < parameters.Length; i++)
                {   
                    sqlCommand.Parameters.AddWithValue(
                        string.Concat("@",parameters[i].Split('=')[0]), //Parameter
                        parameters[i].Split('=')[1]);                   //Value
                }
                sqlDataAdapter = new SqlDataAdapter(sqlCommand);

                using (web_rpt dataSet = new web_rpt())
                {
                    sqlDataAdapter.Fill(dataSet, report);
                    return dataSet;
                }
                con.Dispose();
                con.Close();
            }
        }

    }
    
}