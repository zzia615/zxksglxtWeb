using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace zxksglxtWeb.Admin
{
    public partial class UserInfo : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (action)
            {
                case "queryUserInfo":
                    QueryUserInfo();
                    break;
                case "addUserInfo":
                    AddUserInfo();
                    break;
                case "editUserInfo":
                    EditUserInfo();
                    break;
                case "delSelectedData":
                    DelSelectedData();
                    break;

            }
        }
        
        private void EditUserInfo()
        {
            var obj = new
            {
                code = 0,
                msg = ""
            };
            try
            {

                Models.userInfo userInfo = new Models.userInfo
                {
                    code = Request.Form["code"],
                    name = Request.Form["name"],
                    password = Request.Form["password"],
                    sfzh = Request.Form["sfzh"],
                    phone = Request.Form["phone"],
                    userType = Request.Form["userType"],
                };

                new BLL.userInfoBLL().Edit(userInfo);
            }
            catch (Exception ex)
            {
                obj = new
                {
                    code = 99,
                    msg = ex.Message
                };
            }

            ResponseJson(obj);
        }

        private void AddUserInfo()
        {
            var obj = new
            {
                code = 0,
                msg = ""
            };
            try
            {
                Models.userInfo userInfo = new Models.userInfo
                {
                    code = Request.Form["code"],
                    name = Request.Form["name"],
                    password = Request.Form["password"],
                    sfzh = Request.Form["sfzh"],
                    phone = Request.Form["phone"],
                    userType = Request.Form["userType"],
                };

                new BLL.userInfoBLL().Insert(userInfo);
            }
            catch (Exception ex)
            {
                obj = new
                {
                    code = 99,
                    msg = ex.Message
                };
            }

            ResponseJson(obj);
        }
        
        private void DelSelectedData()
        {
            var obj = new
            {
                code = 0,
                msg = ""
            };
            try
            {
                string data = Request.Form["data"];
                var dataList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<Models.userInfo>>(data);
                var bll = new BLL.userInfoBLL();
                foreach (var dd in dataList)
                {
                    bll.Delete(dd);
                }
            }
            catch (Exception ex)
            {
                obj = new
                {
                    code = 99,
                    msg = ex.ToString()
                };
            }
            ResponseJson(obj);
        }

        private void QueryUserInfo()
        {
            StringBuilder s_wherClause = new StringBuilder();
            string code = Request.QueryString["code"];
            string name = Request.QueryString["name"];
            string userType = Request.QueryString["userType"];
            int limit = Request.QueryString["limit"].AsInt();
            int page = Request.QueryString["page"].AsInt();
            Dictionary<string, object> dic = new Dictionary<string, object>();
            if (!string.IsNullOrEmpty(code))
            {
                s_wherClause.AppendAnd("code=@code");
                dic.Add("code", code);
            }
            if (!string.IsNullOrEmpty(name))
            {
                s_wherClause.AppendAnd("name like @name");
                dic.Add("name", "%" + name + "%");
            }
            if (!string.IsNullOrEmpty(userType))
            {
                s_wherClause.AppendAnd("userType=@userType");
                dic.Add("userType", userType);
            }

            List<Models.userInfo> dataList = new BLL.userInfoBLL().Query(s_wherClause.ToString(), dic);
            int count = dataList.Count;
            dataList = dataList.OrderBy(a=>a.code).Skip((page - 1) * limit).Take(limit).ToList();
            var obj = new
            {
                code = 0,
                msg = "",
                count,
                data = dataList
            };
            ResponseJson(obj);
        }
    }
}