HA$PBExportHeader$dc_uo_idispatch.sru
forward
global type dc_uo_idispatch from nonvisualobject
end type
end forward

global type dc_uo_idispatch from nonvisualobject
end type
global dc_uo_idispatch dc_uo_idispatch

type prototypes
function long GetTypeInfoCount(integer Count)  LIBRARY "capicom.dll"
// function GetTypeInfo(Integer Index, LocaleID ; out TypeInfo): HResult; stdcall;
// function GetIDsOfNames(const IID: TGUID; Names: Pointer;
//      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
// function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
//      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;



FUNCTION long addUNZIP_Overwrite(integer pi_sobrepor) LIBRARY "aunzip32.dll"
end prototypes
forward prototypes
public function integer dc_uo_idispatch ()
end prototypes

public function integer dc_uo_idispatch ();return 1
end function

on dc_uo_idispatch.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_idispatch.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

