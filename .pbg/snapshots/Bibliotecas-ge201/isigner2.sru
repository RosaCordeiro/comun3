HA$PBExportHeader$isigner2.sru
forward
global type isigner2 from nonvisualobject
end type
end forward

global type isigner2 from nonvisualobject
end type
global isigner2 isigner2

type prototypes

// ISigner2 = interface(ISigner)
//    ['{625B1F55-C720-41D6-9ECF-BA59F9B85F17}']

public subroutine GhostMethod_ISigner2_0_1() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_4_2() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_8_3() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_12_4() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_16_5() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_20_6() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_24_7() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_28_8() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_32_9() LIBRARY "capicom.dll"
public subroutine GhostMethod_ISigner2_36_10() LIBRARY "capicom.dll"

function IChain Get_Chain() LIBRARY "capicom.dll"
function long Get_Options()  LIBRARY "capicom.dll"   //CAPICOM_CERTIFICATE_INCLUDE_OPTION
public subroutine Set_Options(long pVal) LIBRARY "capicom.dll"  //CAPICOM_CERTIFICATE_INCLUDE_OPTION
public subroutine Load(string FileName, String Password) LIBRARY "capicom.dll"
end prototypes

type variables
// property Chain: IChain read Get_Chain;
// property Options: CAPI COM_CERTIFICATE_INCLUDE_OPTION read Get_Options write Set_Options;
 
 IChain Chain
 Long Options
end variables

on isigner2.create
call super::create
TriggerEvent( this, "constructor" )
end on

on isigner2.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

