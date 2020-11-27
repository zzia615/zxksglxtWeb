using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace zxksglxtWeb.BLL
{
    public class baseBLL<T> where T:class,new()
    {
        protected DAL.baseDAL<T> BaseDAL = new DAL.baseDAL<T>();
        /// <summary>
        /// 插入数据
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        public virtual int Insert(T t)
        {
            return BaseDAL.Insert(t);
        }
        /// <summary>
        /// 修改数据
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        public virtual int Edit(T t)
        {
            return BaseDAL.Edit(t);
        }
        /// <summary>
        /// 删除数据
        /// </summary>
        /// <param name="t"></param>
        /// <returns></returns>
        public virtual int Delete(T t)
        {
            return BaseDAL.Delete(t);
        }
        /// <summary>
        /// 查询列表
        /// </summary>
        /// <param name="whereClause"></param>
        /// <param name="dic"></param>
        /// <returns></returns>
        public virtual List<T> Query(string whereClause = null, Dictionary<string, object> dic = null)
        {
            string tableName = typeof(T).Name;
            string sql = "select * from " + tableName + " where 1=1 ";
            if (!string.IsNullOrEmpty(whereClause))
            {
                sql += " AND " + whereClause;
            }
            var dataList = BaseDAL.Query(sql, dic);
            return dataList;
        }
        /// <summary>
        /// 查询单条
        /// </summary>
        /// <param name="whereCluase"></param>
        /// <param name="dic"></param>
        /// <returns></returns>
        public virtual T SingleQuery(string whereCluase = null, Dictionary<string, object> dic = null)
        {
            return Query(whereCluase, dic).FirstOrDefault();
        }
        /// <summary>
        /// 获取系统时间
        /// </summary>
        /// <returns></returns>
        public virtual DateTime GetSysDateTime()
        {
            return BaseDAL.GetSysDateTime();
        }
        /// <summary>
        /// 根据主键获取
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public virtual T SingleQuery(object[] obj)
        {
            return null;
        }
    }
}