using System;
using TKLua;

[CSLStub.Out("Tests")]
class PerformanceLua
{
    public static string Test()
    {
        int times = 1 * 1000 * 1000;
        string outMsg = "";
        outMsg += "EmptyLoop " + TestEmptyLoop(times);
        outMsg += "\nBranch " + TestBranch(times);
        outMsg += "\nVirtualCall " + TestVirtualCall(times);
        outMsg += "\nFuncCall " + TestFuncCall(times);
        return outMsg;
    }
    static double CurrentTimeMillis()
    {
        return TKLua.LuaGameSystem.getInstance().CurrentTimeMillis();
    }
    static string TestEmptyLoop(double times)
    {
        double result = 0;
        double startTime = CurrentTimeMillis();
        for (double i = 0; i < times; i++)
        {
            result += i / 5;
        }

        double duration = CurrentTimeMillis() - startTime;
        return "times:" + times + " duration:" + duration + " result:" + result;
    }
    public static int Func()
    {
        return 2;
    }
    static string TestVirtualCall(double times)
    {
        double result = 0;
        BaseClass obj = new SubClass();
        double startTime = CurrentTimeMillis();
        for (double i = 0; i < times; i++)
        {
            result += obj.VirtualFunc();
        }
        double duration = CurrentTimeMillis() - startTime;
        return "times:" + times + " duration:" + duration + " result:" + result;
    }
    static string TestFuncCall(double times)
    {
        double result = 0;
        BaseClass obj = new SubClass();
        double startTime = CurrentTimeMillis();
        for (double i = 0; i < times; i++)
        {
            result += Func();
        }
        double duration = CurrentTimeMillis() - startTime;
        return "times:" + times + " duration:" + duration + " result:" + result;
    }
    static string TestBranch(double times)
    {
        double result = 0;
        BaseClass obj = new SubClass();
        double startTime = CurrentTimeMillis();
        for (double i = 0; i < times; i++)
        {
            if (i > 100.0)
            {
                result += i;
            }
            else
            {
                result -= i;
            }
        }
        double duration = CurrentTimeMillis() - startTime;
        return "times:" + times + " duration:" + duration + " result:" + result;
    }
    public class BaseClass
    {
        public virtual int VirtualFunc()
        {
            return 1;
        }

    }
    public class SubClass : BaseClass
    {
        public override int VirtualFunc()
        {
            return 3;
        }
    }
}

