using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace zxksglxtWeb.BLL
{
    public class examBLL:baseBLL<Models.exam>
    {
        public override Models.exam SingleQuery(object[] obj)
        {
            var dic = new Dictionary<string, object>();
            dic.Add("id", obj[0]);
            return SingleQuery("id=@id", dic);
        }

        public List<Models.exam> QueryByExamDescID(int id)
        {
            var dic = new Dictionary<string, object>();
            dic.Add("id", id);
            return Query("examDescription_id=@id", dic);
        }
    }
}