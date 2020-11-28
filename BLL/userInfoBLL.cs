using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace zxksglxtWeb.BLL
{
    public class userInfoBLL:baseBLL<Models.userInfo>
    {
        /// <summary>
        /// 根据身份证号或用户账号查询用户信息
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public override Models.userInfo SingleQuery(object[] obj)
        {
            var dic = new Dictionary<string, object>();
            dic.Add("code", obj[0]);
            dic.Add("sfzh", obj[0]);
            return SingleQuery("(code=@code or sfzh=@sfzh)", dic);
        }
    }
}