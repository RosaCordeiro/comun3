HA$PBExportHeader$uo_internetresult.sru
forward
global type uo_internetresult from internetresult
end type
end forward

global type uo_internetresult from internetresult
end type
global uo_internetresult uo_internetresult

type variables
string is_data

end variables

forward prototypes
public function integer internetdata (blob data)
end prototypes

public function integer internetdata (blob data);is_data = String(data, EncodingAnsi!)

Return 1
end function

on uo_internetresult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_internetresult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

