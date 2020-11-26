using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace zxksglxtWeb.Utils
{
    public class SqlUtil
    {
        public static SqlParameter CreateParameter(string pName, object pVal)
        {
            return new SqlParameter(pName, pVal);
        }
        private readonly string conStr;
        public SqlUtil()
        {
            //conStr = "Server=(localdb)\\MSSQLLocalDB;Database=OA_OFFICE;Integrated Security=true";
            conStr = ConfigurationManager.ConnectionStrings["defaultDb"].ConnectionString;
        }
        public SqlUtil(string conStr)
        {
            this.conStr = conStr;
        }

        public System.Data.SqlClient.SqlConnection CreateCon()
        {
            return new System.Data.SqlClient.SqlConnection(conStr);
        }

        public int ExecuteSql(string sql, System.Data.IDataParameter[] parameters = null)
        {
            using (var con = CreateCon())
            {
                try
                {
                    con.Open();
                    var cmd = con.CreateCommand();
                    cmd.CommandText = sql;
                    cmd.CommandType = System.Data.CommandType.Text;
                    if (parameters != null)
                    {
                        foreach (var p in parameters)
                        {
                            if (p.Value == null)
                            {
                                p.Value = DBNull.Value;
                            }
                            cmd.Parameters.Add(p);
                        }
                    }
                    return cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        public DataTable QuerySqlDataTable(string sql, System.Data.IDataParameter[] parms = null)
        {
            using (var con = CreateCon())
            {
                con.Open();
                var cmd = con.CreateCommand();
                cmd.CommandText = sql;
                if (parms != null)
                {
                    foreach (var p in parms)
                    {
                        if (p.Value == null)
                        {
                            p.Value = DBNull.Value;
                        }
                        cmd.Parameters.Add(p);
                    }
                }
                DataTable table = new DataTable();
                System.Data.SqlClient.SqlDataAdapter dapt = new System.Data.SqlClient.SqlDataAdapter(cmd);
                dapt.Fill(table);
                return table;
            }
        }

        public DataSet QuerySqlDataSet(string sql)
        {
            using (var con = CreateCon())
            {
                DataSet ds = new DataSet();
                System.Data.SqlClient.SqlDataAdapter dapt = new System.Data.SqlClient.SqlDataAdapter(sql, con);
                dapt.Fill(ds);
                return ds;
            }
        }
    }

    public static class SqlUtilExt
    {
        public static int ExecuteSql(this System.Data.SqlClient.SqlConnection con, string sql, System.Data.SqlClient.SqlTransaction trans)
        {
            return ExecuteSql(con, sql, null, trans);
        }

        public static int ExecuteSql(this System.Data.SqlClient.SqlConnection con, string sql, System.Data.IDataParameter[] parameters, System.Data.SqlClient.SqlTransaction trans)
        {
            var cmd = con.CreateCommand();
            cmd.CommandText = sql;
            cmd.CommandType = System.Data.CommandType.Text;
            if (parameters != null)
            {
                foreach (var p in parameters)
                {
                    if (p.Value == null)
                    {
                        p.Value = DBNull.Value;
                    }
                    cmd.Parameters.Add(p);
                }
            }
            cmd.Transaction = trans;
            return cmd.ExecuteNonQuery();
        }
    }
}