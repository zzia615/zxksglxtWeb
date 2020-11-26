using System;
using System.Linq;
using System.Web;

namespace zxksglxtWeb.Models
{
    /// <summary>
    /// 试题
    /// </summary>
    public class exam
    {
        /// <summary>
        /// 自增长主键
        /// </summary>
        public int id { get; set; }
        /// <summary>
        /// 试卷ID
        /// </summary>
        public int examDescription_id { get; set; }
        /// <summary>
        /// 题目
        /// </summary>
        public string title { get; set; }
        /// <summary>
        /// 单选题、多选题
        /// </summary>
        public string type { get; set; }
        /// <summary>
        /// A选项
        /// </summary>
        public string resultA { get; set; }
        /// <summary>
        /// B选项
        /// </summary>
        public string resultB { get; set; }
        /// <summary>
        /// C选项
        /// </summary>
        public string resultC { get; set; }
        /// <summary>
        /// D选项
        /// </summary>
        public string resultD { get; set; }
        /// <summary>
        /// 正确答案A、B、C、D，如果是多选则用逗号隔开
        /// </summary>
        public string correctResult { get; set; }
        /// <summary>
        /// 分值
        /// </summary>
        public int score { get; set; }
        /// <summary>
        /// 序号
        /// </summary>
        public int orderNo { get; set; }
    }
    
}