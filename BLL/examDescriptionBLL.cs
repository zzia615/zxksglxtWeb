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
    }
}