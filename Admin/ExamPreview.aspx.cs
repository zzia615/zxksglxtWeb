using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace zxksglxtWeb.Admin
{
    public partial class ExamPreview : BasePage
    {
        public Models.examDescription ExamDesc { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(action)) return;
            //ID
            int exam_des_id = Request.QueryString["exam_des_id"].AsInt();
            ExamDesc = new BLL.examDescriptionBLL().SingleQuery(new object[] { exam_des_id });
        }
    }
}