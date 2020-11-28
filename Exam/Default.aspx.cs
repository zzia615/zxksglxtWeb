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
        public Models.userInfo UserInfo { get; set; }
        public Models.examResult ExamResult { get; set; }

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
            //查询用户信息
            UserInfo = new BLL.userInfoBLL().SingleQuery(new object[] { scode });
            //查询用户考试试卷
            ExamResult = new BLL.examResultBLL().SingleQueryByCode(scode);
            //查询试卷信息
            ExamDesc = new BLL.examDescriptionBLL().SingleQuery(new object[] { exam_des_id });
            //校验
            if (UserInfo == null)
            {
                ResponseAlert("考生信息不存在", "/Exam/Login.aspx");
            }
            if (ExamDesc == null)
            {
                ResponseAlert("未找到试卷信息，请联系管理员", "/Exam/Login.aspx");
            }
            if (ExamResult == null)
            {
                ResponseAlert("考生未安排考试", "/Exam/Login.aspx");
            }
            else
            {
                if (ExamResult.kszt == "已考")
                {
                    ResponseAlert("考生已完成考试，不允许重复考试", "/Exam/Login.aspx");
                }
            }
            ExamResult.kssj = DateTime.Now;
            ExamResult.kszt = "考试中";

            new BLL.examResultBLL().Edit(ExamResult);
        }

        private void HandInExam()
        {
            var obj = new { code = 0, msg = "" };
            try
            {
                string data = Request.Form["data"];
                JObject jo = JObject.Parse(data);
                Dictionary<int, string> dic = new Dictionary<int, string>();
                int pid = Request.Form["pid"].AsInt();
                int examDesc_id = Request.Form["examDesc_id"].AsInt();
                foreach (JProperty jp in jo.Properties())
                {
                    string name = jp.Name;
                    string val = jp.Value.ToString();

                    if (name.Substring(0, 1) == "r") //单选
                    {
                        int id = name.Replace("r_", "").AsInt();
                        dic.Add(id, val);
                    }
                    else if (name.Substring(0, 1) == "k") //判断题
                    {
                        int id = name.Replace("k_", "").AsInt();
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
                //获取试卷信息
                var tmp_exam_desc = new BLL.examDescriptionBLL().SingleQuery(new object[] { examDesc_id });
                //获取本次考试信息
                var examResult = new BLL.examResultBLL().SingleQuery(new object[] { pid });
                //定义变量
                List<Models.examResultDetail> resultDetailList = new List<Models.examResultDetail>();
                //计算答案及分值
                foreach (var d in dic)
                {
                    Models.examResultDetail resultDetail = new Models.examResultDetail();
                    resultDetail.isCorrect = 0;
                    resultDetail.score = 0;
                    var tmp_exam = tmp_exam_desc.ExamList.Find(a => a.id == d.Key);
                    if (tmp_exam != null && tmp_exam.correctResult == d.Value)
                    {
                        resultDetail.isCorrect = 1;
                        resultDetail.score = tmp_exam.score;
                    }
                    resultDetail.pid = pid;
                    resultDetail.exam_id = d.Key;
                    resultDetail.chooseResult = d.Value;
                    resultDetailList.Add(resultDetail);
                }
                //更新考试状态及总分
                examResult.kszt = "已考";
                examResult.jssj = DateTime.Now;
                examResult.score = resultDetailList.Sum(a => a.score);

                new BLL.examResultBLL().SaveExamResult(examResult, resultDetailList);

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
    }
}