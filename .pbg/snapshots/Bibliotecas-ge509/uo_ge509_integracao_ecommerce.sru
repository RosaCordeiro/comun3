HA$PBExportHeader$uo_ge509_integracao_ecommerce.sru
forward
global type uo_ge509_integracao_ecommerce from nonvisualobject
end type
end forward

global type uo_ge509_integracao_ecommerce from nonvisualobject
end type
global uo_ge509_integracao_ecommerce uo_ge509_integracao_ecommerce

type variables
string is_id_ecommerce
end variables

forward prototypes
public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log)
public function boolean of_pedido_baixa ()
public function boolean of_produto ()
public function boolean of_pedido_status ()
public function boolean of_processa_integracao (string ps_id_ecommerce, long pl_tipo_interface)
end prototypes

public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log);string ls_retorno

select id_situacao
into :ls_retorno
from ecommerce
where id_ecommerce = :is_id_ecommerce;

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_situacao_ecommerce ~n' + 'Problemas ao consultar a tabela "ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

ps_situacao = ls_retorno

return true
end function

public function boolean of_pedido_baixa ();long ll_linhas, ll_for
long ll_cd_filial
string ls_rede
string ls_id_sistema_novo

dc_uo_ds_base lds_dados

uo_ge509_pedido_baixa luo_pedido
uo_ge509_pedido_loja luo_loja

lds_dados = create dc_uo_ds_base

lds_dados.of_changedataobject( 'ds_ge509_filiais_ecommerce' )

ll_linhas = lds_dados.retrieve( is_id_ecommerce )

for ll_for = 1 to ll_linhas

	ll_cd_filial = lds_dados.object.cd_filial[ll_for]
	ls_rede = lds_dados.object.id_rede_filial[ll_for]
	ls_id_sistema_novo = lds_dados.object.id_sistema_novo[ll_for]
	
	//Pedido Baixa
	luo_pedido = create uo_ge509_pedido_baixa
	luo_pedido.of_processa_interface( ls_rede, ll_cd_filial, is_id_ecommerce )
	destroy(luo_pedido)
	
	if ls_id_sistema_novo = 'N' Then
		//Pedido Loja
		luo_loja = create uo_ge509_pedido_loja
		luo_loja.of_processa_interface( ls_rede, ll_cd_filial, is_id_ecommerce )
		destroy(luo_loja)
	ENd if
	
Next

return true
//

end function

public function boolean of_produto ();long ll_linhas, ll_for
long ll_cd_filial
string ls_rede

dc_uo_ds_base lds_dados

uo_ge509_produto luo_produto

lds_dados = create dc_uo_ds_base

lds_dados.of_changedataobject( 'ds_ge509_filiais_ecommerce' )

ll_linhas = lds_dados.retrieve( is_id_ecommerce )

for ll_for = 1 to ll_linhas

	ll_cd_filial = lds_dados.object.cd_filial[ll_for]
	ls_rede = lds_dados.object.id_rede_filial[ll_for]

	luo_produto = create uo_ge509_produto
	
	luo_produto.of_processa_interface( ls_rede, ll_cd_filial, is_id_ecommerce )
	
	destroy(luo_produto)

Next

return true
//

end function

public function boolean of_pedido_status ();long ll_linhas, ll_for
long ll_cd_filial
string ls_rede

dc_uo_ds_base lds_dados

uo_ge509_pedido_status luo_status

lds_dados = create dc_uo_ds_base

lds_dados.of_changedataobject( 'ds_ge509_filiais_ecommerce' )

ll_linhas = lds_dados.retrieve( is_id_ecommerce )

for ll_for = 1 to ll_linhas

	ll_cd_filial = lds_dados.object.cd_filial[ll_for]
	ls_rede = lds_dados.object.id_rede_filial[ll_for]

	//Pedido Loja
	luo_status = create uo_ge509_pedido_status
	luo_status.of_processa_interface( ls_rede, ll_cd_filial, is_id_ecommerce )
	destroy(luo_status)
	
Next

return true
//

end function

public function boolean of_processa_integracao (string ps_id_ecommerce, long pl_tipo_interface);string ls_situacao_ecommerce
string ls_log

Try

	is_id_ecommerce = ps_id_ecommerce

	//Valida se o ecommerce est$$HEX1$$e100$$ENDHEX$$ ativo.
	If Not this.of_situacao_ecommerce( ref ls_situacao_ecommerce, ref ls_log ) Then return false
	
	if ls_situacao_ecommerce = 'I' or isnull(ls_situacao_ecommerce) or ls_situacao_ecommerce = '' Then
		Return true
	end if

	Choose CAse pl_tipo_interface
			
		Case 0 //Interface de Pedidos
			
			this.of_pedido_baixa( )
			//this.of_pedido_loja( )
			//this.of_pedido_status( )
			
		Case 2 //Produtos
			
			this.of_produto( )
			
		Case 8 //Pedido - Baixa
			
			this.of_pedido_baixa( )
			
		Case 9 //Pedido - Loja
			
			//this.of_pedido_loja( )
		
		Case 13 //Pedido - Status
			
			this.of_pedido_status( )
			
	End Choose

Finally
	
	
End Try

return true
end function

on uo_ge509_integracao_ecommerce.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge509_integracao_ecommerce.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

