using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace zxksglxtWeb
{
    public partial class Default : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            switch (action)
            {
                case "checkLoginUser":
                    CheckLoginUser();
                    break;
                case "changePwd":
                    ChangePwd();
                    break;
                case "changeProfile":
                    ChangeProfile();
                    break;
                case "getProfile":
                    GetProfile();
                    break;
                case "uploadImg":
                    UploadImg();
                    break;
            }
        }

        private void CheckLoginUser()
        {
            ResponseJson(new { code = 0 });
        }

        private void UploadImg()
        {
            var file = Request.Files[0];
            string path = Server.MapPath("/UploadFiles");
            if (!System.IO.Directory.Exists(path))
            {
                System.IO.Directory.CreateDirectory(path);
            }
            string guid = Guid.NewGuid().ToString();
            string fileName = System.IO.Path.Combine(path, guid + "_" + file.FileName);
            file.SaveAs(fileName);
            var obj = new
            {
                code = 0,
                data = new { fileName = file.FileName, fileUrl = "/UploadFiles/" + guid + "_" + file.FileName },
                msg = ""
            };
            ResponseJson(obj);
        }

        private void GetProfile()
        {
        }

        private void ChangeProfile()
        {
            
        }

        /// <summary>
        /// 修改密码
        /// </summary>
        private void ChangePwd()
        {
            
        }
    }
}