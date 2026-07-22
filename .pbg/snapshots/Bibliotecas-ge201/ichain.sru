HA$PBExportHeader$ichain.sru
forward
global type ichain from idispatch
end type
end forward

global type ichain from idispatch
end type
global ichain ichain

type prototypes

//    ['{77F6F881-5D3A-4F2F-AEF0-E4A2F9AA689D}']
//    function Get_Certificates: ICertificates LIBRARY "capicom.dll"
//    function Integer Get_Status(Integer Index) LIBRARY "capicom.dll"
//    function Build(const pICertificate: ICertificate): WordBool LIBRARY "capicom.dll"




end prototypes
type variables

//    property Certificates: ICertificates read Get_Certificates;
//    property Status[Index: Integer]: Integer read Get_Status;

end variables
on ichain.create
call super::create
end on

on ichain.destroy
call super::destroy
end on

