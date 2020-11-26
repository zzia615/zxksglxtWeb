using System;

namespace zxksglxtWeb.Models
{
    /// <summary>
    /// 考试结果
    /// </summary>
    public class examResult
    {
        /// <summary>
        /// 自增长ID
        /// </summary>
        public int id { get; set; }
        /// <summary>
        /// 学生编号
        /// </summary>
        public string scode { get; set; }
        /// <summary>
        /// 试卷ID
        /// </summary>
        public int examDescription_id { get; set; }
        /// <summary>
        /// 考试状态：已考，空
        /// </summary>
        public string kszt { get; set; }
        /// <summary>
        /// 实际考试时间
        /// </summary>
        public DateTime? kssj { get; set; }
        /// <summary>
        /// 考试分数
        /// </summary>
        public int? score { get; set; }
        /// <summary>
        /// 实际交卷时间
        /// </summary>
        public DateTime? jssj { get; set; }
    }
}