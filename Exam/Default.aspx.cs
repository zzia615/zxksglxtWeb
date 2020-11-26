using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace zxksglxtWeb.Exam
{
    public partial class Default : BasePage
    {
        public Models.examDescription ExamDesc { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            switch (action)
            {
                case "HandInExam":
                    HandInExam();
                    break;
            }
            if (!string.IsNullOrEmpty(action)) return;
            //ID
            int exam_des_id = Request.QueryString["exam_des_id"].AsInt();
            //编码
            string scode = Request.QueryString["scode"];

            ExamDesc = new Models.examDescription();
            ExamDesc.costTime = 120;
            ExamDesc.isPublished = 1;
            ExamDesc.name = "测试";
            ExamDesc.passScore = 100;
            ExamDesc.id = 1;
            ExamDesc.ExamList = new List<Models.Exam>();
            int j = 0;
            for(int i = 0; i < 60; i++)
            {
                j++;
                ExamDesc.ExamList.Add(new Models.Exam
                {
                    correctResult = "A",
                    resultC = "测试答案C",
                    resultA = "测试答案A",
                    resultB = "测试答案B",
                    resultD = "测试答案D",
                    examDescription_id = 1,
                    id = j,
                    score=1,
                    title="测试题目",
                    type="单选题",
                    orderNo = j
                });
            }

            for (int i = 0; i < 30; i++)
            {
                j++;
                ExamDesc.ExamList.Add(new Models.Exam
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
        }

        private void HandInExam()
        {
            string data = Request.Form["data"];
            JObject jo = JObject.Parse(data);
            Dictionary<int, string> dic = new Dictionary<int, string>();
            int pid = Request.Form["pid"].AsInt();
            foreach (JProperty jp in jo.Properties())
            {
                string name = jp.Name;
                string val = jp.Value.ToString();

                if (name.Substring(0, 1) == "r") //单选
                {
                    int id = name.Replace("r_", "").AsInt();
                    dic.Add(id, val);
                }
                else if (name.Substring(0, 1) == "c") //多选
                {

                    int id = name.Replace("c_", "").Replace("[A]", "").Replace("[B]", "").Replace("[C]", "").Replace("[D]", "").AsInt();
                    ArrayList tmpList = new ArrayList();
                    if (dic.ContainsKey(id))
                    {
                        string tmp_val;
                        dic.TryGetValue(id, out tmp_val);
                        string[] tmp_arr = tmp_val.Split(',');
                        tmpList.AddRange(tmp_arr);
                        dic.Remove(id);
                    }
                    if (val == "on")
                    {
                        if (name.Contains("[A]"))
                        {
                            tmpList.Add("A");
                        }
                        if (name.Contains("[B]"))
                        {
                            tmpList.Add("B");
                        }
                        if (name.Contains("[C]"))
                        {
                            tmpList.Add("C");
                        }
                        if (name.Contains("[D]"))
                        {
                            tmpList.Add("D");
                        }
                    }
                    if (tmpList.Count > 0)
                    {
                        tmpList.Sort();
                        dic.Add(id, string.Join(",", tmpList.ToArray()));
                    }
                }
            }

            ResponseJson(new { code = 0, msg = "" });
            
        }
    }
}