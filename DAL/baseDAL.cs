using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using zxksglxtWeb.Utils;

namespace zxksglxtWeb.DAL
{
    public class baseDAL<T> where T : class, new()
    {
        protected SqlFactoryUtil Sql = new SqlFactoryUtil();
        public baseDAL()
        {
        }
        /// <summary>
        /// 插入
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        public virtual int Insert(T t)
        {
            return Sql.Insert(t);
        }
        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        public virtual int Edit(T t)
        {
            return Sql.Edit(t);
        }
        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        public virtual int Delete(T t)
        {
            return Sql.Delete(t);
        }
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="sql"></param>
        /// <param name="dic"></param>
        /// <returns></returns>
        public virtual List<T> Query(string sql, Dictionary<string, object> dic = null)
        {
            List<System.Data.IDbDataParameter> parameters = new List<System.Data.IDbDataParameter>();
            if (dic != null && dic.Count > 0)
            {
                foreach (var d in dic)
                {
                    parameters.Add(Sql.CreateParameter("@" + d.Key, d.Value));
                }
            }
            if (parameters.Count <= 0)
            {
                return Sql.Query<T>(sql, null);
            }
            else
            {
                return Sql.Query<T>(sql, parameters.ToArray());
            }
        }

        public DateTime GetSysDateTime()
        {
            try
            {

                return Sql.QueryDataSet("select getdate()").Tables[0].Rows[0][0].AsDateTime();
            }
            catch
            {
                return DateTime.Now;
            }
        }
    }
}