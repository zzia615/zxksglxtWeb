using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using zxksglxtWeb.Models;

namespace zxksglxtWeb.BLL
{
    public class examDescriptionBLL:baseBLL<examDescription>
    {
        public override examDescription SingleQuery(object[] obj)
        {
            var dic = new Dictionary<string, object>();
            dic.Add("id", obj[0]);
            return SingleQuery("id=@id", dic);
        }

        public override List<examDescription> Query(string whereClause = null, Dictionary<string, object> dic = null)
        {
            var dataList = base.Query(whereClause, dic);
            dataList.ForEach(a =>
            {
                Dictionary<string, object> dic1 = new Dictionary<string, object>();
                dic1.Add("id", a.id);
                a.ExamList = new examBLL().Query("examDescription_id=@id", dic1);
            });

            return dataList;
        }
    }
}