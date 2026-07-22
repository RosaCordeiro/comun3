HA$PBExportHeader$idispatch.sru
forward
global type idispatch from nonvisualobject
end type
end forward

global type idispatch from nonvisualobject
end type
global idispatch idispatch

type prototypes





function long GetTypeInfoCount(Integer Count)  LIBRARY "capicom.dll" //HResult
//function GetTypeInfo(Integer Index, Ineger LocaleID, out TypeInfo): HResult LIBRARY "capicom.dll"
//    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
//      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult LIBRARY "capicom.dll"
//    function Invoke(Integer DispID: ; const IID: TGUID; LocaleID: Integer;
//      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult LIBRARY "capicom.dll"
		
		
	
end prototypes
on idispatch.create
call super::create
TriggerEvent( this, "constructor" )
end on

on idispatch.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

