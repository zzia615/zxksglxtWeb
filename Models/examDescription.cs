using System.Collections.Generic;

namespace zxksglxtWeb.Models
{
    /// <summary>
    /// 试卷
    /// </summary>
    public class examDescription
    {

        /// <summary>
        /// 自增长主键
        /// </summary>
        public int id { get; set; }

        /// <summary>
        /// 名称
        /// </summary>
        public string title { get; set; }
        /// <summary>
        /// 时间限制
        /// </summary>
        public int costTime { get; set; }
        /// <summary>
        /// 及格分
        /// </summary>
        public int passScore { get; set; }
        /// <summary>
        /// 是否已发布 0未发布 1已发布（只有已发布的试卷才能在线答题）
        /// </summary>
        public int isPublished { get; set; }
        /// <summary>
        /// 试题列表
        /// </summary>
        public List<exam> ExamList { get; set; }
    }
    
}