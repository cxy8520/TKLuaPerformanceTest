-------------
---缓存类型和静态绑定的变量
local T_CSLString = CSLString
local T_SystemManager = TKNS.TKFrame.SystemManager
local F_Concat = T_CSLString.Concat
local F_getInstance = T_SystemManager.getInstance
-------------
---本类型里被引用函数的声明
local TestBranch
local TestVirtualCall
local TestFuncCall
local CurrentTimeMillis
local Func
-------------
--------
---code begin
---------------------
local BaseClass
local SubClass
---------------------
local PerformanceLua = class('PerformanceLua')


--
--ILMethod:System.String PerformanceLua::Test()
function PerformanceLua.Test()
	local times = 1000000
	local outMsg = F_Concat('\nloop branch ' , TestBranch(times))
	outMsg = F_Concat(outMsg , '\nvirtual call ' , TestVirtualCall(times))
	outMsg = F_Concat(outMsg , '\nfunc clall ' , TestFuncCall(times))
	return outMsg
end

--
--ILMethod:System.Double PerformanceLua::CurrentTimeMillis()
function PerformanceLua.CurrentTimeMillis()
	return F_getInstance():CurrentTimeMillis()
end

--
--ILMethod:System.Int32 PerformanceLua::Func()
function PerformanceLua.Func()
	return 2
end

--
--ILMethod:System.String PerformanceLua::TestVirtualCall(System.Double)
function PerformanceLua.TestVirtualCall(times)
	local result = 0
	local obj = CSLNew(SubClass)
	local startTime = CurrentTimeMillis()
	local i = 0
	while (i < times) do
		result = (result + obj:VirtualFunc())
		i = (i + 1)
	end
	local duration = (CurrentTimeMillis() - startTime)
	return F_Concat(CSLInitArray('times:' , times , ' duration:' , duration , ' result:' , result))
end

--
--ILMethod:System.String PerformanceLua::TestFuncCall(System.Double)
function PerformanceLua.TestFuncCall(times)
	local result = 0
	local obj = CSLNew(SubClass)
	local startTime = CurrentTimeMillis()
	local i = 0
	while (i < times) do
		result = (result + Func())
		i = (i + 1)
	end
	local duration = (CurrentTimeMillis() - startTime)
	return F_Concat(CSLInitArray('times:' , times , ' duration:' , duration , ' result:' , result))
end

--
--ILMethod:System.String PerformanceLua::TestBranch(System.Double)
function PerformanceLua.TestBranch(times)
	local result = 0
	local obj = CSLNew(SubClass)
	local startTime = CurrentTimeMillis()
	local i = 0
	while (i < times) do
		if ( not (i <= 100)) then
			result = (result + i)
		else
		
			result = (result - i)
		end
		i = (i + 1)
	end
	local duration = (CurrentTimeMillis() - startTime)
	return F_Concat(CSLInitArray('times:' , times , ' duration:' , duration , ' result:' , result))
end

--
--ILMethod:System.Void PerformanceLua::.ctor()
function PerformanceLua:initialize()
	
end
BaseClass = class('PerformanceLua.BaseClass')


--
--ILMethod:System.Int32 PerformanceLua/BaseClass::VirtualFunc()
function BaseClass:VirtualFunc()
	return 1
end

--
--ILMethod:System.Void PerformanceLua/BaseClass::.ctor()
function BaseClass:initialize()
	
end
SubClass = class('PerformanceLua.SubClass',BaseClass)


--
--ILMethod:System.Int32 PerformanceLua/SubClass::VirtualFunc()
function SubClass:VirtualFunc()
	return 3
end

--
--ILMethod:System.Void PerformanceLua/SubClass::.ctor()
function SubClass:initialize()
	BaseClass.initialize(self)
end
PerformanceLua.BaseClass = BaseClass
PerformanceLua.SubClass = SubClass
-------------
---本类型里被引用函数的赋值
TestBranch = PerformanceLua.TestBranch
TestVirtualCall = PerformanceLua.TestVirtualCall
TestFuncCall = PerformanceLua.TestFuncCall
CurrentTimeMillis = PerformanceLua.CurrentTimeMillis
Func = PerformanceLua.Func
-------------
return PerformanceLua