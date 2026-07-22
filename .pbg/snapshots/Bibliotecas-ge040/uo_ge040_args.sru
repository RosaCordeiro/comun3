HA$PBExportHeader$uo_ge040_args.sru
forward
global type uo_ge040_args from nonvisualobject
end type
end forward

global type uo_ge040_args from nonvisualobject autoinstantiate
end type

type variables
Any		ia_value[]
Long		il_index	= 0
String	is_key[]
end variables

forward prototypes
public function boolean of_add_arg (string as_key, any aa_value)
public function any of_get_arg (string as_key)
public function long of_find_arg (string as_key)
end prototypes

public function boolean of_add_arg (string as_key, any aa_value);Long	ll_index = 0

uo_ge040_array luo_ge040_array


ll_index = luo_ge040_array.uo_find(is_key, as_key)

if ll_index > 0 then
	ia_value[ll_index]	= aa_value
else
	il_index ++
	
	ia_value[il_index]	= aa_value
	is_key[il_index]		= as_key
end if

return true
end function

public function any of_get_arg (string as_key);Any		la_value
Boolean	lb_achou = false
Long		ll_for


for ll_for = 1 to il_index
	if is_key[ll_for] = as_key then
		la_value = ia_value[ll_for]
		
		exit
	end if
next


return la_value
end function

public function long of_find_arg (string as_key);return 1
end function

on uo_ge040_args.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge040_args.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

