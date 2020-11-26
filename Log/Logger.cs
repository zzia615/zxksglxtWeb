using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading;


/// <summary>
/// 日志对象
/// </summary>
public sealed class Logger
{
    static string LogName = string.Empty;
    public static void SetLogName(string logName)
    {
        LogName = logName;
    }
    /// <summary>
    /// 普通日志
    /// </summary>
    /// <param name="data"></param>
    public static void Info(string data)
    {
        Log(LoggerType.INFO, data);
    }
    /// <summary>
    /// 错误日志
    /// </summary>
    /// <param name="data"></param>
    public static void Error(string data)
    {
        Log(LoggerType.ERROR, data);
    }
    /// <summary>
    /// 警告日志
    /// </summary>
    /// <param name="data"></param>
    public static void Warn(string data)
    {
        Log(LoggerType.WARN, data);
    }
    static ReaderWriterLockSlim writeLock = new ReaderWriterLockSlim();
    static void Log(LoggerType type,string data)
    {
        try
        {
            writeLock.EnterWriteLock();
            string path = "${AppPath}\\logs";
            //如果配置了AppPath,则默认在程序根目录创建log文件夹
            if (path.Contains("${AppPath}"))
                path = path.Replace("${AppPath}", AppDomain.CurrentDomain.BaseDirectory);
            if (!Directory.Exists(path))
            {
                Directory.CreateDirectory(path);
            }
            string logFile = Path.Combine(path, string.Format("{0}{1}.log", LogName, DateTime.Now.ToString("yyyyMMdd")));
            if (!File.Exists(logFile))
            {
                File.Create(logFile).Close();
            }
            string msg = string.Format("【{0}】:{1} ", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"),type);
            File.AppendAllText(logFile, msg, Encoding.UTF8);
            File.AppendAllText(logFile, string.Format("{0}\r\n", data), Encoding.UTF8);
        }
        catch
        {

        }
        finally
        {
            writeLock.ExitWriteLock();
        }
    }
}