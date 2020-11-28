using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace zxksglxtWeb
{
    public class BasePage : System.Web.UI.Page
    {
        protected string action;
        protected override void OnPreLoad(EventArgs e)
        {
            base.OnPreLoad(e);
            if (Request.HttpMethod.ToUpper() == "POST")
            {
                action = Request.Form["action"];
                if (string.IsNullOrEmpty(action))
                {
                    action = Request.QueryString["action"];
                }
            }
            else
            {
                action = Request.QueryString["action"];
            }

        }
        
        
        /// <summary>
        /// 返回json
        /// </summary>
        /// <param name="obj"></param>
        public void ResponseJson(object obj)
        {
            Response.ContentType = "application/json";
            Response.Write(obj.AsJson());
            Response.End();
        }
        /// <summary>
        /// 提示并关闭
        /// </summary>
        /// <param name="msg"></param>
        public void ResponseAlert(string msg)
        {
            string html = @"<script>alert('" + msg + "');window.close();</script>";
            Response.Write(html);
            Response.End();
        }
        /// <summary>
        /// 提示并跳转
        /// </summary>
        /// <param name="msg"></param>
        public void ResponseAlert(string msg,string url)
        {
            string html = @"<script>alert('" + msg + "');window.location.href='"+url+"';</script>";
            Response.Write(html);
            Response.End();
        }
        /// <summary>
        /// 下载文件
        /// </summary>
        /// <param name="fileName"></param>
        /// <param name="bytes"></param>
        public void ResponseFile(string fileName,byte[] bytes)
        {
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.AddHeader("Content-Disposition", "attachment;filename=\"" + HttpUtility.UrlEncode(fileName, System.Text.Encoding.UTF8) + "\"");
            Response.AddHeader("Content-Length", bytes.Length.ToString());
            Response.AddHeader("Content-Transfer-Encoding", "binary");
            Response.ContentType = "application/octet-stream";
            Response.BinaryWrite(bytes);
            Response.End();
        }
    }
}