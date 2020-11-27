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

            //Dictionary<string, object> dic = new Dictionary<string, object>();
            //dic.Add("id", exam_des_id);
            ExamDesc = new BLL.examDescriptionBLL().SingleQuery(new object[] { exam_des_id });
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