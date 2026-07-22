HA$PBExportHeader$uo_ge509_cancelamento.sru
forward
global type uo_ge509_cancelamento from nonvisualobject
end type
end forward

global type uo_ge509_cancelamento from nonvisualobject
end type
global uo_ge509_cancelamento uo_ge509_cancelamento

type variables
string is_objeto
string is_url_interface = 'https://integracao.equilibriumsc.com/api/v1/cancelarPedido/'



end variables

forward prototypes
public function boolean of_processa_cancelamento (string ps_id_pedido, ref string ps_log)
end prototypes

public function boolean of_processa_cancelamento (string ps_id_pedido, ref string ps_log);string ls_log
string ls_retorno

uo_ge509_comum luo_comum

try 

	luo_comum = create uo_ge509_comum

	luo_comum.of_post('', is_url_interface + ps_id_pedido , ref ls_retorno, ref ls_log )

	if ls_log <> '' and not isnull(ls_log) Then
		ps_log = ls_log
		return false
	end if

Finally
		
	destroy(luo_comum)
	
End try

return true
end function

on uo_ge509_cancelamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge509_cancelamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - ' + 'Objeto: ' + this.classname() + ' - '
end event

