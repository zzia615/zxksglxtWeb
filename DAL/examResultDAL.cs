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
                var con = Sql.CreateCon();
                con.Open();
                var trans = con.BeginTransaction();
                try
                {
                    int ret = con.Edit(examResult, trans);
                    detailList.ForEach(a =>
                    {
                        ret += con.Insert(a, trans);
                    });

                    trans.Commit();
                    return ret;
                }
                catch (System.Exception ex)
                {
                    trans.Rollback();
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