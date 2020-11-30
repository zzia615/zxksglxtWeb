using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;

namespace zxksglxtWeb.Utils
{
    public class SqlFactoryUtil
    {
        /// <summary>
        /// 字段开始字符
        /// </summary>
        public string QuotePrefix { get; set; }
        /// <summary>
        /// 字段结尾字符
        /// </summary>
        public string QuoteSuffix { get; set; }
        /// <summary>
        /// 架构分隔符
        /// </summary>
        public string SchemaSeparator { get; set; }
        /// <summary>
        /// 参数前缀
        /// </summary>
        public string ParameterPrefix { get; set; }
        IDbConnection dbConnection;
        IDbTransaction dbTransaction;
        public string ConStr { get; private set; }
        public string ProviderName { get; private set; }

        /// <summary>
        /// 构造函数，默认读取数据库连接defaultDb的节点配置
        /// </summary>
        public SqlFactoryUtil()
        {
            ConStr = ConfigurationManager.ConnectionStrings["defaultDb"].ConnectionString;
            ProviderName = ConfigurationManager.ConnectionStrings["defaultDb"].ProviderName;
        }
        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="configName">配置数据库连接的节点名</param>
        public SqlFactoryUtil(string configName)
        {
            ConStr = ConfigurationManager.ConnectionStrings[configName].ConnectionString;
            ProviderName = ConfigurationManager.ConnectionStrings[configName].ProviderName;
        }
        /// <summary>
        /// 开始事务
        /// </summary>
        public void BeginTransaction()
        {
            dbConnection = CreateConnection();
            dbTransaction = dbConnection.BeginTransaction();
        }
        /// <summary>
        /// 提交事务
        /// </summary>
        public void CommitTransaction()
        {
            try
            {
                dbTransaction.Commit();
            }
            finally 
            {
                dbConnection = null;
                dbTransaction = null;
            }
        }
        /// <summary>
        /// 回滚事务
        /// </summary>
        public void RollbackTransaction()
        {
            try
            {
                dbTransaction.Rollback();
            }
            finally
            {
                dbConnection = null;
                dbTransaction = null;
            }
        }

        /// <summary>
        /// 创建Connection
        /// </summary>
        /// <returns></returns>
        public IDbConnection CreateConnection()
        {
            if (dbConnection == null)
            {
                var con = System.Data.Common.DbProviderFactories.GetFactory(ProviderName).CreateConnection();
                con.ConnectionString = ConStr;
                con.Open();
                return con;
            }
            else
            {
                return dbConnection;
            }
        }
        /// <summary>
        /// 创建DataAdapter
        /// </summary>
        /// <returns></returns>
        public IDbDataAdapter CreateDataAdapter()
        {
            var dapt = System.Data.Common.DbProviderFactories.GetFactory(ProviderName).CreateDataAdapter();
            return dapt;
        }
        /// <summary>
        /// 创建Command
        /// </summary>
        /// <returns></returns>
        public IDbCommand CreateCommand()
        {
            var cmd = System.Data.Common.DbProviderFactories.GetFactory(ProviderName).CreateCommand();
            return cmd;
        }
        /// <summary>
        /// 创建CommandBuilder
        /// </summary>
        /// <returns></returns>
        public System.Data.Common.DbCommandBuilder CreateCommandBuilder()
        {
            var builder = System.Data.Common.DbProviderFactories.GetFactory(ProviderName).CreateCommandBuilder();
            builder.QuotePrefix = QuotePrefix;
            builder.QuoteSuffix = QuoteSuffix;
            builder.SchemaSeparator = SchemaSeparator;
            return builder;
        }

        /// <summary>
        /// 创建参数
        /// </summary>
        /// <param name="pName"></param>
        /// <param name="pVal"></param>
        /// <returns></returns>
        public IDbDataParameter CreateParameter(string pName, object pVal)
        {
            var pp = System.Data.Common.DbProviderFactories.GetFactory(ProviderName).CreateParameter();
            pp.ParameterName = ParameterPrefix + pName;
            pp.Value = pVal;
            return pp;
        }

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <returns></returns>

        public int ExecuteSql(string sql)
        {
            return ExecuteSql(sql, null);
        }
        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        public int ExecuteSql(string sql,IDbDataParameter[] parameters)
        {
            return ExecuteSql(sql, CommandType.Text, null);
        }
        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="commandType">命令类别</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        public int ExecuteSql(string sql,CommandType commandType, IDbDataParameter[] parameters)
        {
            using(var con = CreateConnection())
            {
                var cmd = con.CreateCommand();
                cmd.CommandText = sql;
                cmd.CommandType = commandType;
                if (dbTransaction != null)
                    cmd.Transaction = dbTransaction;
                if (parameters != null && parameters.Length > 0)
                {
                    foreach (var p in parameters)
                    {
                        cmd.Parameters.Add(p);
                    }
                }

                return cmd.ExecuteNonQuery();
            }
        }
        /// <summary>
        /// 执行查询并返回第一行第一列
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <returns></returns>

        public object ExecuteScalar(string sql)
        {
            return ExecuteScalar(sql, null);
        }
        /// <summary>
        /// 执行查询并返回第一行第一列
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        public object ExecuteScalar(string sql, IDbDataParameter[] parameters)
        {
            return ExecuteScalar(sql, CommandType.Text, null);
        }
        /// <summary>
        /// 执行查询并返回第一行第一列
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="commandType">命令类别</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        public object ExecuteScalar(string sql, CommandType commandType, IDbDataParameter[] parameters)
        {
            using (var con = CreateConnection())
            {
                var cmd = con.CreateCommand();
                cmd.CommandText = sql;
                cmd.CommandType = commandType;
                if (dbTransaction != null)
                    cmd.Transaction = dbTransaction;
                if (parameters != null && parameters.Length > 0)
                {
                    foreach (var p in parameters)
                    {
                        cmd.Parameters.Add(p);
                    }
                }
                return cmd.ExecuteScalar();
            }
        }

        /// <summary>
        /// 执行查询并返回数据集
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <returns></returns>

        public DataSet QueryDataSet(string sql)
        {
            return QueryDataSet(sql, null);
        }
        /// <summary>
        /// 执行查询并返回数据集
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        public DataSet QueryDataSet(string sql, IDbDataParameter[] parameters)
        {
            return QueryDataSet(sql, CommandType.Text, null);
        }
        /// <summary>
        /// 执行查询并返回数据集
        /// </summary>
        /// <param name="sql">sql语句</param>
        /// <param name="commandType">命令类别</param>
        /// <param name="parameters">参数</param>
        /// <returns></returns>
        public DataSet QueryDataSet(string sql, CommandType commandType, IDbDataParameter[] parameters)
        {
            using (var con = CreateConnection())
            {
                var cmd = con.CreateCommand(); 
                cmd.CommandText = sql;
                cmd.CommandType = commandType;
                if (dbTransaction != null)
                    cmd.Transaction = dbTransaction;
                if (parameters != null && parameters.Length > 0)
                {
                    foreach (var p in parameters)
                    {
                        cmd.Parameters.Add(p);
                    }
                }
                var dapt = CreateDataAdapter();
                dapt.SelectCommand = cmd;
                DataSet ds = new DataSet();
                dapt.Fill(ds);
                return ds;
            }
        }
        /// <summary>
        /// 查询数据库
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="sql"></param>
        /// <param name="parms"></param>
        /// <returns></returns>
        public List<T> Query<T>(string sql, System.Data.IDbDataParameter[] parms = null) where T : class, new()
        {
            DataTable table = QueryDataSet(sql, parms).Tables[0];
            if (table == null || table.Rows.Count <= 0)
            {
                return new List<T>();
            }
            var dataList = new List<T>();
            PropertyInfo[] propertyInfos = typeof(T).GetProperties();
            foreach (DataRow row in table.Rows)
            {
                T t = new T();

                foreach (PropertyInfo propertyInfo in propertyInfos)
                {
                    //过滤Ignore属性
                    int count = propertyInfo.GetCustomAttributes(false).Where(a => a is IgnoreAttribute).Count();
                    if (count > 0)
                    {
                        continue;
                    }
                    //数据库为空时
                    if (row[propertyInfo.Name] == DBNull.Value)
                    {
                        propertyInfo.SetValue(t, null, null);
                    }
                    else
                    {
                        //否则直接赋值
                        propertyInfo.SetValue(t, row[propertyInfo.Name], null);
                    }
                }

                dataList.Add(t);
            }

            return dataList;
        }

        /// <summary>
        /// 插入数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="con"></param>
        /// <param name="t"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Insert<T>(T t) where T : class, new()
        {
            var con = CreateConnection();
            PropertyInfo[] propertyInfos = typeof(T).GetProperties();
            string tblName = typeof(T).Name;
            int keyCount = 0;
            foreach (PropertyInfo propertyInfo in propertyInfos)
            {
                int count = propertyInfo.GetCustomAttributes(false).Where(a => a is KeyAttribute).Count();
                if (count <= 0)
                {
                    continue;
                }
                keyCount++;
            }

            if (keyCount <= 0)
            {
                throw new Exception("实体未设置KeyAttribute属性");
            }

            DataSet ds = new DataSet();
            var cmd = con.CreateCommand();
            cmd.CommandText = "select * from " + tblName + " where 1<>1";
            cmd.CommandType = CommandType.Text;
            if (dbTransaction != null)
                cmd.Transaction = dbTransaction;
            var dapt = CreateDataAdapter();
            dapt.SelectCommand = cmd;
            dapt.Fill(ds);

            DataRow row = ds.Tables[0].NewRow();

            foreach (PropertyInfo propertyInfo in propertyInfos)
            {
                //过滤Ignore属性
                int count = propertyInfo.GetCustomAttributes(false).Where(a => a is IgnoreAttribute).Count();
                if (count > 0)
                {
                    continue;
                }
                //主键如果是Identity则不允许主动插入数据
                object pkAttr = propertyInfo.GetCustomAttributes(false).Where(a => a is KeyAttribute).FirstOrDefault();
                if (pkAttr != null)
                {
                    if ((pkAttr as KeyAttribute).Identity)
                    {
                        continue;
                    }
                }

                object obj = propertyInfo.GetValue(t, null);
                if (obj == null)
                {
                    row[propertyInfo.Name] = DBNull.Value;
                }
                else
                {
                    row[propertyInfo.Name] = obj;
                }
            }

            ds.Tables[0].Rows.Add(row);
            
            var scb = CreateCommandBuilder();
            scb.DataAdapter = (System.Data.Common.DbDataAdapter)dapt;
            return dapt.Update(ds);
        }

        /// <summary>
        /// 修改数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="con"></param>
        /// <param name="t"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Edit<T>(T t) where T : class, new()
        {
            var con = CreateConnection();
            PropertyInfo[] propertyInfos = typeof(T).GetProperties();
            List<IDbDataParameter> parameters = new List<IDbDataParameter>();
            StringBuilder s_where = new StringBuilder();
            foreach (PropertyInfo propertyInfo in propertyInfos)
            {
                int count = propertyInfo.GetCustomAttributes(false).Where(a => a is KeyAttribute).Count();
                if (count <= 0)
                {
                    continue;
                }
                object obj = propertyInfo.GetValue(t, null);
                IDbDataParameter parameter = null;
                if (obj == null)
                {
                    parameter = CreateParameter(propertyInfo.Name, DBNull.Value);
                }
                else
                {
                    parameter = CreateParameter(propertyInfo.Name, obj);
                }
                parameter.DbType = SetDbType(obj);
                if (obj.GetType() == typeof(string))
                {
                    parameter.DbType = DbType.String;
                    var tmp_sla = propertyInfo.GetCustomAttributes(false).Where(a => a is StringLengthAttribute).FirstOrDefault();
                    if (tmp_sla != null)
                    {
                       parameter.Size = (tmp_sla as StringLengthAttribute).Length;
                    }
                }

                parameters.Add(parameter);
                s_where.AppendAnd(propertyInfo.Name + "="+ParameterPrefix + propertyInfo.Name);
            }

            if (parameters.Count <= 0)
            {
                throw new Exception("实体未设置KeyAttribute属性");
            }

            string tblName = typeof(T).Name;
            DataSet ds = new DataSet();
            var cmd = con.CreateCommand();
            cmd.CommandText = "select * from " + tblName + " where " + s_where.ToString();
            cmd.CommandType = CommandType.Text;
            foreach(var pp in parameters)
            {
                cmd.Parameters.Add(pp);
            }
            if (dbTransaction != null)
                cmd.Transaction = dbTransaction;
            var dapt = CreateDataAdapter();
            dapt.SelectCommand = cmd;
            dapt.Fill(ds);

            if (ds.Tables[0].Rows.Count <= 0)
            {
                throw new Exception("未找到符合条件的记录");
            }
            DataRow row = ds.Tables[0].Rows[0];
            row.BeginEdit();
            foreach (PropertyInfo propertyInfo in propertyInfos)
            {
                //过滤Ignore和Key属性
                int count = propertyInfo.GetCustomAttributes(false).Where(a => a is IgnoreAttribute || a is KeyAttribute).Count();
                if (count > 0)
                {
                    continue;
                }

                object obj = propertyInfo.GetValue(t, null);
                if (obj == null)
                {
                    row[propertyInfo.Name] = DBNull.Value;
                }
                else
                {
                    row[propertyInfo.Name] = obj;
                }
            }
            row.EndEdit();
            var scb = CreateCommandBuilder();
            scb.DataAdapter = (System.Data.Common.DbDataAdapter)dapt;
            return dapt.Update(ds);
        }
        /// <summary>
        /// 删除数据
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="con"></param>
        /// <param name="t"></param>
        /// <param name="trans"></param>
        /// <returns></returns>
        public int Delete<T>(T t) where T : class, new()
        {
            var con = CreateConnection();
            PropertyInfo[] propertyInfos = typeof(T).GetProperties();
            List<IDbDataParameter> parameters = new List<IDbDataParameter>();
            StringBuilder s_where = new StringBuilder();
            foreach (PropertyInfo propertyInfo in propertyInfos)
            {
                int count = propertyInfo.GetCustomAttributes(false).Where(a => a is KeyAttribute).Count();
                if (count <= 0)
                {
                    continue;
                }
                object obj = propertyInfo.GetValue(t, null);
                IDbDataParameter parameter = null;
                if (obj == null)
                {
                    parameter = CreateParameter(propertyInfo.Name, DBNull.Value);
                }
                else
                {
                    parameter = CreateParameter(propertyInfo.Name, obj);
                }
                parameter.DbType = SetDbType(obj);
                if (obj.GetType() == typeof(string))
                {
                    parameter.DbType = DbType.String;
                    var tmp_sla = propertyInfo.GetCustomAttributes(false).Where(a => a is StringLengthAttribute).FirstOrDefault();
                    if (tmp_sla != null)
                    {
                        parameter.Size = (tmp_sla as StringLengthAttribute).Length;
                    }
                }

                parameters.Add(parameter);
                s_where.AppendAnd(propertyInfo.Name + "="+ ParameterPrefix + propertyInfo.Name);
            }

            if (parameters.Count <= 0)
            {
                throw new Exception("实体未设置KeyAttribute属性");
            }

            string tblName = typeof(T).Name;
            DataSet ds = new DataSet();
            var cmd = con.CreateCommand();
            cmd.CommandText = "select * from " + tblName + " where " + s_where.ToString();
            cmd.CommandType = CommandType.Text;
            foreach (var pp in parameters)
            {
                cmd.Parameters.Add(pp);
            }
            if (dbTransaction != null)
                cmd.Transaction = dbTransaction;
            var dapt = CreateDataAdapter();
            dapt.SelectCommand = cmd;
            dapt.Fill(ds);

            if (ds.Tables[0].Rows.Count <= 0)
            {
                throw new Exception("未找到符合条件的记录");
            }
            DataRow row = ds.Tables[0].Rows[0];
            row.Delete();
            var scb = CreateCommandBuilder();
            scb.DataAdapter = (System.Data.Common.DbDataAdapter)dapt;
            return dapt.Update(ds);
        }
        /// <summary>
        /// 设置类型
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        DbType SetDbType(object obj)
        {
            if (obj.GetType() == typeof(double))
                return DbType.Double;
            else if (obj.GetType() == typeof(float))
                return DbType.Double;
            else if (obj.GetType() == typeof(decimal))
                return DbType.Decimal;
            else if (obj.GetType() == typeof(DateTime))
                return DbType.DateTime;
            else if (obj.GetType() == typeof(int))
                return DbType.Int32;
            else if (obj.GetType() == typeof(long))
                return DbType.Int64;
            else
                return DbType.String;
        }
    }
}
