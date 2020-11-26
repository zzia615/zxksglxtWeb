using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public static class Ext
{
    public static string AsString(this object obj)
    {
        if (obj == null) return string.Empty;
        return obj.ToString();
    }
    public static int AsInt(this object obj)
    {
        int o;
        int.TryParse(obj.AsString(), out o);
        return o;
    }
    public static int? AsNullInt(this object obj)
    {
        if (string.IsNullOrEmpty(obj.AsString()))
        {
            return null;
        }
        int o;
        int.TryParse(obj.AsString(), out o);
        return o;
    }
    public static DateTime AsDateTime(this object obj)
    {
        DateTime o;
        DateTime.TryParse(obj.AsString(), out o);
        return o;
    }
    public static double AsDouble(this object obj)
    {
        double o;
        double.TryParse(obj.AsString(), out o);
        return o;
    }
    public static string AsJson(this object obj)
    {
        return Newtonsoft.Json.JsonConvert.SerializeObject(obj);
    }

    public static DateTime? AsNullDateTime(this object obj)
    {
        if (string.IsNullOrEmpty(obj.AsString()))
        {
            return null;
        }
        DateTime o;
        DateTime.TryParse(obj.AsString(), out o);
        return o;
    }


    public static void AppendAnd(this System.Text.StringBuilder sb,string val)
    {
        if (sb.Length > 0) sb.Append(" AND ");
        sb.Append(val);
    }
}