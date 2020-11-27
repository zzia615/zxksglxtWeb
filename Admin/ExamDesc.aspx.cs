﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace zxksglxtWeb.Admin
{
    public partial class ExamDesc : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (action)
            {
                case "getExamDesc":
                    GetExamDesc();
                    break;
                case "addExamDesc":
                    AddExamDesc();
                    break;
                case "editExamDesc":
                    EditExamDesc();
                    break;
                case "delExamDesc":
                    DelExamDesc();
                    break;
                case "getExam":
                    GetExam();
                    break;

            }
        }

        private void EditExamDesc()
        {
            throw new NotImplementedException();
        }

        private void AddExamDesc()
        {
            var obj = new
            {
                code = 0,
                msg = ""
            };
            try
            {
                Models.examDescription examDesc = new Models.examDescription
                {
                    costTime = Request.Form["costTime"].AsInt(),
                    isPublished = Request.Form["isPublished"].AsInt(),
                    passScore = Request.Form["passScore"].AsInt(),
                    title = Request.Form["title"].AsString(),
                };

                new BLL.examDescriptionBLL().Insert(examDesc);
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

        void GetExam()
        {
            int? examDescId = Request.QueryString["examDescription_id"].AsNullInt();
            int limit = Request.QueryString["limit"].AsInt();
            int page = Request.QueryString["page"].AsInt();
            StringBuilder s_whereCluase = new StringBuilder();
            Dictionary<string, object> dic = new Dictionary<string, object>();
            if (examDescId != null)
            {
                s_whereCluase.AppendAnd("examDescription_id=@examDescription_id");
                dic.Add("examDescription_id", examDescId);
            }


            List<Models.exam> dataList = new BLL.examBLL().Query(s_whereCluase.ToString(), dic);
            
            var tmp = dataList.OrderBy(a=>a.orderNo).Skip((page - 1) * limit).Take(limit).ToList();
            var obj = new
            {
                code = 0,
                msg = "",
                count = dataList.Count,
                data = tmp
            };
            ResponseJson(obj);
        }

        private void DelExamDesc()
        {
            var obj = new
            {
                code = 0,
                msg = ""
            };
            try
            {
                string data = Request.Form["data"];
                var exam_desc_ids = Newtonsoft.Json.JsonConvert.DeserializeObject<int[]>(data);
                var bll = new BLL.examDescriptionBLL();
                foreach (int id in exam_desc_ids)
                {
                    Models.examDescription examDesc = new Models.examDescription
                    {
                        id = id
                    };
                    if (examDesc != null)
                    {
                        bll.Delete(examDesc);
                    }
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

        private void GetExamDesc()
        {
            List<Models.examDescription> examDescList = new BLL.examDescriptionBLL().Query();
            var obj = new
            {
                code = 0,
                msg = "",
                data = examDescList
            };
            ResponseJson(obj);
        }
    }
}