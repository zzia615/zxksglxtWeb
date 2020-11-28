using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace zxksglxtWeb.BLL
{
    public class examResultBLL:baseBLL<Models.examResult>
    {
        public override Models.examResult SingleQuery(object[] obj)
        {
            var dic = new Dictionary<string, object>();
            dic.Add("id", obj[0]);
            return SingleQuery("id=@id", dic);
        }
        /// <summary>
        /// 根据用户账号查询信息
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public Models.examResult SingleQueryByCode(string code)
        {
            var dic = new Dictionary<string, object>();
            dic.Add("code", code);
            return SingleQuery("scode=@code", dic);
        }


        public int SaveExamResult(Models.examResult examResult, List<Models.examResultDetail> detailList)
        {
            return new DAL.examResultDAL().SaveExamResult(examResult, detailList);
        }
    }
}