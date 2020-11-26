using System;
using System.Collections.Generic;
using System.Linq;
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
                case "delExamDesc":
                    DelExamDesc();
                    break;
                case "getExam":
                    GetExam();
                    break;

            }
        }

        void GetExam()
        {
            int limit = Request.QueryString["limit"].AsInt();
            int page = Request.QueryString["page"].AsInt();
            List<Models.exam> dataList = new List<Models.exam>();
            for (int j = 1; j <= 100; j++)
            {
                dataList.Add(new Models.exam
                {
                    correctResult = "A,B,C",
                    resultC = "测试答案C",
                    resultA = "测试答案A",
                    resultB = "测试答案B",
                    resultD = "测试答案D",
                    examDescription_id = 1,
                    id = j,
                    score = 1,
                    title = "测试题目",
                    type = "多选题",
                    orderNo = j
                });
            }
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
            string data = Request.Form["data"];
            var exam_desc_ids = Newtonsoft.Json.JsonConvert.DeserializeObject<int[]>(data);


            var obj = new
            {
                code = 0,
                msg = ""
            };
            ResponseJson(obj);
        }

        private void GetExamDesc()
        {
            List<Models.examDescription> examDescList = new List<Models.examDescription>();
            for(int i = 1; i < 100; i++)
            {
                examDescList.Add(new Models.examDescription
                {
                    id = i,
                    title = "测试试卷" + i.ToString()
                });
            }
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