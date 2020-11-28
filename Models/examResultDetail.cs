namespace zxksglxtWeb.Models
{
    /// <summary>
    /// 考试结果明细
    /// </summary>
    public class examResultDetail
    {
        /// <summary>
        /// 自增长ID
        /// </summary>
        [Key(Identity =true)]
        public int id { get; set; }
        /// <summary>
        /// 结果ID
        /// </summary>
        public int pid { get; set; }
        /// <summary>
        /// 试题ID
        /// </summary>
        public int exam_id { get; set; }
        /// <summary>
        /// 选择的结果A、B、C、D，如果是多选则用逗号隔开
        /// </summary>
        public string chooseResult { get; set; }
        /// <summary>
        /// 是否正确 1正确 0不正确
        /// </summary>
        public int isCorrect { get; set; }
        /// <summary>
        /// 得分
        /// </summary>
        public int score { get; set; }
    }
}