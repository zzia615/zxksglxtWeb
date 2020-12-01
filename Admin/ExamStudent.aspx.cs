using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace zxksglxtWeb.Admin
{
    public partial class ExamStudent : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (action)
            {
                case "getExamDesc":
                    GetExamDesc();
                    break;
                case "getExamStudent":
                    GetExamStudent();
                    break;
                case "queryStudent":
                    QueryStudent();
                    break;
                case "importStudent":
                    ImportStudent();
                    break;
                case "delExamStudent":
                    DelExamStudent();
                    break;



            }
        }

        private void DelExamStudent()
        {
            var obj = new
            {
                code = 0,
                msg = ""
            };
            try
            {
                int id = Request.Form["id"].AsInt();
                var bll = new BLL.examResultBLL();
                Models.examResult examResult = new Models.examResult
                {
                    id = id
                };
                bll.Delete(examResult);
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

        private void ImportStudent()
        {
            var obj = new
            {
                code = 0,
                msg = ""
            };
            try
            {
                string data = Request.Form["data"];
                int examDescription_id = Request.Form["examDescription_id"].AsInt();
                List<Models.userInfo> dataList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<Models.userInfo>>(data);
                var bill = new BLL.examResultBLL();
                bill.BeginTransaction();
                try
                {
                    foreach (var dd in dataList)
                    {
                        bill.Insert(new Models.examResult
                        {
                            examDescription_id = examDescription_id,
                            scode = dd.code,
                            kszt = "待考"
                        });
                    }
                    bill.Commit();
                }
                catch (Exception ex)
                {
                    bill.Rollback();
                    throw ex;
                }
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
        void GetExamStudent()
        {
            int examDescId = Request.QueryString["examDescription_id"].AsInt();
            int limit = Request.QueryString["limit"].AsInt();
            int page = Request.QueryString["page"].AsInt();
            StringBuilder s_whereCluase = new StringBuilder();
            Dictionary<string, object> dic = new Dictionary<string, object>();
            
            s_whereCluase.AppendAnd("examDescription_id=@examDescription_id");
            dic.Add("examDescription_id", examDescId);
            


            List<Models.v_examStudent> dataList = new BLL.examStudentBLL().Query(s_whereCluase.ToString(), dic);

            var tmp = dataList.OrderBy(a=>a.scode).Skip((page - 1) * limit).Take(limit).ToList();
            var obj = new
            {
                code = 0,
                msg = "",
                count = dataList.Count,
                data = tmp
            };
            ResponseJson(obj);
        }
        

        private void GetExamDesc()
        {
            List<Models.examDescription> examDescList = new BLL.examDescriptionBLL().Query("isPublished = 1");
            var obj = new
            {
                code = 0,
                msg = "",
                data = examDescList
            };
            ResponseJson(obj);
        }
        
        private void QueryStudent()
        {
            StringBuilder s_wherClause = new StringBuilder();
            Dictionary<string, object> dic = new Dictionary<string, object>();
            string code = Request.QueryString["code"];
            string name = Request.QueryString["name"];
            int examDescId = Request.QueryString["examDescription_id"].AsInt();
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


            s_wherClause.AppendAnd("userType=@userType");
            dic.Add("userType", "学生");


            s_wherClause.AppendAnd("not exists(select 1 from v_examStudent where code=scode and examDescription_id=@examDescription_id)");
            dic.Add("examDescription_id", examDescId);
            List<Models.userInfo> dataList = new BLL.userInfoBLL().Query(s_wherClause.ToString(), dic);
            int count = dataList.Count;
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