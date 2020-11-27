using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace zxksglxtWeb.Models
{
    /// <summary>
    /// 用户信息
    /// </summary>
    public class userInfo
    {
        /// <summary>
        /// 账号
        /// </summary>
        [Key]
        public string code { get; set; }
        /// <summary>
        /// 密码
        /// </summary>
        public string password { get; set; }
        /// <summary>
        /// 姓名
        /// </summary>
        public string name { get; set; }
        /// <summary>
        /// 用户类别：系统管理员、考生
        /// </summary>
        public string userType { get; set; }
        /// <summary>
        /// 头像
        /// </summary>
        public string imageUrl { get; set; }
        /// <summary>
        /// 身份证号
        /// </summary>
        public string sfzh { get; set; }
        /// <summary>
        /// 联系电话
        /// </summary>
        public string phone { get; set; }
    }
}