HA$PBExportHeader$uo_ge514_integracao_vmpay.sru
forward
global type uo_ge514_integracao_vmpay from nonvisualobject
end type
end forward

global type uo_ge514_integracao_vmpay from nonvisualobject
end type
global uo_ge514_integracao_vmpay uo_ge514_integracao_vmpay

type variables

end variables

forward prototypes
public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log)
public function boolean of_pedido_baixa ()
public function boolean of_pedido_loja ()
public function boolean of_produto ()
public function boolean of_pedido_status ()
public function boolean of_processa_integracao (long pl_tipo_interface)
public function boolean of_fabricante ()
public function boolean of_categoria ()
end prototypes

public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log);string ls_retorno

select id_situacao
into :ls_retorno
from ecommerce
where id_ecommerce = '4';

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_situacao_ecommerce ~n' + 'Problemas ao consultar a tabela "ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

ps_situacao = ls_retorno

return true
end function

public function boolean of_pedido_baixa ();uo_ge514_pedido_baixa luo_pedido

luo_pedido = create uo_ge514_pedido_baixa

luo_pedido.of_processa_interface( 'DC' )

destroy(luo_pedido)

return true
//

end function

public function boolean of_pedido_loja ();uo_ge514_pedido_loja luo_pedido

luo_pedido = create uo_ge514_pedido_loja

luo_pedido.of_processa_interface()

destroy(luo_pedido)

return true

end function

public function boolean of_produto ();uo_ge514_produto luo_produto

luo_produto = create uo_ge514_produto

luo_produto.of_processa_interface('DC'  )

destroy(luo_produto)

return true
//

end function

public function boolean of_pedido_status ();uo_ge514_pedido_status luo_pedido

luo_pedido = create uo_ge514_pedido_status

luo_pedido.of_processa_interface( )

destroy(luo_pedido)

return true
//

end function

public function boolean of_processa_integracao (long pl_tipo_interface);string ls_situacao_ecommerce
string ls_log

Try

	//Valida se o ecommerce est$$HEX1$$e100$$ENDHEX$$ ativo.
	If Not this.of_situacao_ecommerce( ref ls_situacao_ecommerce, ref ls_log ) Then return false
	
	if ls_situacao_ecommerce = 'I' or isnull(ls_situacao_ecommerce) or ls_situacao_ecommerce = '' Then
		Return true
	end if

	Choose CAse pl_tipo_interface
			
		Case 0 //Interface de Pedidos
			
			this.of_pedido_baixa( )
			this.of_pedido_loja( )
			this.of_pedido_status( )
			
		Case 2 //Produtos
			
			this.of_produto( )
			
		Case 8 //Pedido - Baixa
			
			this.of_pedido_baixa( )
			
		Case 9 //Pedido - Loja
			
			this.of_pedido_loja( )
		
		Case 13 //Pedido - Status
			
			this.of_pedido_status( )
		
		Case 21 //Fabricante
		
			this.of_fabricante( )
		
		Case 22 //Categoria
		
			this.of_categoria( )
			
	End Choose

Finally
	
	
End Try

return true
end function

public function boolean of_fabricante ();uo_ge514_fabricante luo_pedido

luo_pedido = create uo_ge514_fabricante

luo_pedido.of_processa_interface('DC'  )

destroy(luo_pedido)

return true
//

end function

public function boolean of_categoria ();uo_ge514_categoria luo_pedido

luo_pedido = create uo_ge514_categoria

luo_pedido.of_processa_interface('DC'  )

destroy(luo_pedido)

return true
//

end function

on uo_ge514_integracao_vmpay.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge514_integracao_vmpay.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

