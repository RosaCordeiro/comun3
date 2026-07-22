HA$PBExportHeader$uo_ge505_integracao_ifood.sru
forward
global type uo_ge505_integracao_ifood from nonvisualobject
end type
end forward

global type uo_ge505_integracao_ifood from nonvisualobject
end type
global uo_ge505_integracao_ifood uo_ge505_integracao_ifood

type variables

end variables

forward prototypes
public function boolean of_processa_integracao_ifood (long pl_tipo_interface)
public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log)
public function boolean of_pedido_feed ()
public function boolean of_pedido_baixa ()
public function boolean of_pedido_loja ()
public function boolean of_produto ()
public function boolean of_pedido_status ()
public function boolean of_valida_situacao_interface (long pl_cd_interface)
end prototypes

public function boolean of_processa_integracao_ifood (long pl_tipo_interface);string ls_situacao_ecommerce
string ls_log

Try

	//Valida se o ecommerce est$$HEX1$$e100$$ENDHEX$$ ativo.
	If Not this.of_situacao_ecommerce( ref ls_situacao_ecommerce, ref ls_log ) Then return false
	
	if ls_situacao_ecommerce = 'I' or isnull(ls_situacao_ecommerce) or ls_situacao_ecommerce = '' Then
		Return true
	end if

	if pl_tipo_interface > 0 then
		
		if Not this.of_valida_situacao_interface( pl_tipo_interface ) then return true
		
	ENd if

	Choose CAse pl_tipo_interface
			
		Case 0 //Interface de Pedidos
			
			if this.of_valida_situacao_interface( 8 ) Then 
				this.of_pedido_baixa( )
			End if
			
			if this.of_valida_situacao_interface( 9 ) Then 
				this.of_pedido_loja( )
			ENd if
			
		Case 2 //Produtos / Saldo
			
			this.of_produto()
			
		Case 7 //Pedido - Feed
			
			this.of_pedido_feed( )
			
		Case 8 //Pedido - Baixa
			
			this.of_pedido_baixa( )
			
		Case 9 //Pedido - Loja
			
			this.of_pedido_loja( )
		
		Case 12 //Pedido - Status
			
			this.of_pedido_status( )
		
	End Choose

Finally
	
	
End Try

return true
end function

public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log);string ls_retorno

select id_situacao
into :ls_retorno
from ecommerce
where id_ecommerce = '3';

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_situacao_ecommerce ~n' + 'Problemas ao consultar a tabela "ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

ps_situacao = ls_retorno

return true
end function

public function boolean of_pedido_feed ();uo_ge505_pedido_feed luo_pedido

luo_pedido = create uo_ge505_pedido_feed

luo_pedido.of_processa_atualizacao_pedido( )

destroy(luo_pedido)

return true

end function

public function boolean of_pedido_baixa ();uo_ge505_pedido_baixa luo_pedido

luo_pedido = create uo_ge505_pedido_baixa

luo_pedido.of_processa_atualizacao_pedido( )

destroy(luo_pedido)

return true
//

end function

public function boolean of_pedido_loja ();uo_ge505_pedido_loja luo_pedido

luo_pedido = create uo_ge505_pedido_loja

luo_pedido.of_processa_atualizacao_pedido()

destroy(luo_pedido)

return true

end function

public function boolean of_produto ();uo_ge505_produto luo_produto

luo_produto = create uo_ge505_produto

luo_produto.of_processa_atualizacao_produto( )

destroy(luo_produto)

return true

end function

public function boolean of_pedido_status ();uo_ge505_pedido_status luo_pedido

luo_pedido = create uo_ge505_pedido_status

luo_pedido.of_processa_atualizacao_status( )

destroy(luo_pedido)

return true
//

end function

public function boolean of_valida_situacao_interface (long pl_cd_interface);long ll_existe

select count(*)
into :ll_existe
from ecommerce_interface ei
	inner join ecommerce_interface_plataforma eip on eip.cd_interface = ei.cd_interface
where ei.id_situacao = 'A'
and eip.id_situacao = 'A'
and eip.id_tecnologia = 'PB'
and ei.cd_interface = :pl_cd_interface
and eip.id_ecommerce = '3';

if ll_existe > 0 and not isnull(ll_existe) then
	Return true
Else
	Return false
End if

end function

on uo_ge505_integracao_ifood.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge505_integracao_ifood.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

