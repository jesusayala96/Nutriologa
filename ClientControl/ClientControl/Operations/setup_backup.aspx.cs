using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace ClientControl.Operations
{
    public partial class setup_backup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_respaldo_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                var connectionString = ConfigurationManager.ConnectionStrings["ConcordiaDB"].ConnectionString;
                var backupFolder = ConfigurationManager.AppSettings["BackupFolder"];

                var sqlConStrBuilder = new SqlConnectionStringBuilder(connectionString);

                var backupFileName = String.Format("{0}{1}-{2}.bak",
                    backupFolder, sqlConStrBuilder.InitialCatalog,
                    DateTime.Now.ToString("yyyy-MM-dd"));

                using (var connection = new SqlConnection(sqlConStrBuilder.ConnectionString))
                {
                    var query = String.Format("BACKUP DATABASE {0} TO DISK='{1}'",
                        sqlConStrBuilder.InitialCatalog, backupFileName);

                    using (var command = new SqlCommand(query, connection))
                    {
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Se ha guardado el respaldo correctamente')", true);
            }
            catch(Exception ex)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('No se ha podido guardar, intente de nuevo')", true);
            }
        }
    }
}