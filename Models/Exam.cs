using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
        public string name { get; set; }
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
        public List<Exam> ExamList { get; set; }
    }
    /// <summary>
    /// 试题
    /// </summary>
    public class Exam
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