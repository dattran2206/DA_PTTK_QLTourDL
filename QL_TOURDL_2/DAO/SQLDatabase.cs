using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAO
{
    public class SQLDatabase
    {
        private static string connectionString = string.Empty;
        public SqlConnection conn;
        public DataSet DataSet = new DataSet();
        private string strConnect, strServerName, strDataBaseName, strUserName, strPassword;
        public string StrServerName
        {
            get { return strServerName; }
            set { strServerName = value; }
        }
        public string StrDataBaseName
        {
            get { return strDataBaseName; }
            set { strDataBaseName = value; }
        }
        public string StrUserName
        {
            get { return strUserName; }
            set { strUserName = value; }
        }
        public string StrPassword
        {
            get { return strPassword; }
            set { strPassword = value; }
        }
        public static void OpenConnection(SqlConnection connection)
        {
            if(connection.State == ConnectionState.Closed)
            {
                connection.Open();
            }
        }
        public static void CloseConnection(SqlConnection connection)
        {
            if (connection.State == ConnectionState.Open)
            {
                connection.Close();
            }
        }
        public SQLDatabase()
        {
            StrServerName = "DESKTOP-MIKOLH7\\SQLEXPRESS";
            StrDataBaseName = "QL_TourDuLich";
            StrUserName = "sa";
            StrPassword = "sa2012";
            strConnect = @"Data Source=" + StrServerName + ";Initial Catalog=" +
            StrDataBaseName;
            strConnect += ";User ID=" + StrUserName + ";Password=" + StrPassword;
            conn = new SqlConnection();
            conn.ConnectionString = strConnect;
            DataSet = new DataSet(strDataBaseName);
        }
        public SQLDatabase(string strServerName, string strDataBaseName, string strUserName, string strPassword)
        {
            StrServerName = strServerName;
            StrDataBaseName = strDataBaseName;
            StrUserName = strUserName;
            StrPassword = strPassword;
            strConnect = @"Data Source=" + StrServerName + ";Initial Catalog=" +
           StrDataBaseName;
            strConnect += ";User ID=" + StrUserName + ";Password=" + StrPassword;
            conn = new SqlConnection();
            conn.ConnectionString = strConnect;
            DataSet = new DataSet(strDataBaseName);
        }
        public static string ConnectionString
        {
            get
            {
                if (connectionString.Equals(""))
                {
                    connectionString = "Data Source=DESKTOP-MIKOLH7\\SQLEXPRESS;Initial Catalog=QL_TourDuLich;Integrated Security=True";
                }
                return connectionString;
            }
            set
            {
                connectionString = value;
            }
        }

        public static SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection();
            conn.ConnectionString = connectionString;
            return conn;
        }
        public static void ExcuteNoneQuery(SqlCommand cmd)
        {
            if (cmd.Connection != null)
            {
                cmd.ExecuteNonQuery();
            }
            else
            {
                SqlConnection conn = GetConnection();
                conn.Open();
                cmd.Connection = conn;
                cmd.ExecuteNonQuery();
            }
        }
        public static DataTable GetData(SqlCommand cmd)
        {
            if (cmd.Connection != null)
            {
                using (DataSet ds = new DataSet())
                {
                    using (SqlDataAdapter da = new SqlDataAdapter())
                    {
                        da.Fill(ds);
                        return ds.Tables[0];
                    }
                }
            }
            else
            {
                using (SqlConnection conn = GetConnection())
                {
                    cmd.Connection = conn;
                    using (DataSet ds = new DataSet())
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(ds);
                            return ds.Tables[0];
                        }
                    }
                }
            }
        }
    }
}
