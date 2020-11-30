using System.Collections.Generic;
using zxksglxtWeb;
using zxksglxtWeb.Utils;
namespace zxksglxtWeb.DAL
{
    public class examResultDAL : baseDAL<Models.examResult>
    {
        public int SaveExamResult(Models.examResult examResult, List<Models.examResultDetail> detailList)
        {
            try
            {
                Sql.BeginTransaction();
                try
                {
                    int ret = Sql.Edit(examResult);
                    detailList.ForEach(a =>
                    {
                        ret += Sql.Insert(a);
                    });

                    Sql.Commit();
                    return ret;
                }
                catch (System.Exception ex)
                {
                    Sql.Rollback();
                    throw ex;
                }
            }
            catch (System.Exception ex)
            {

                throw ex;
            }
        }
    }
}