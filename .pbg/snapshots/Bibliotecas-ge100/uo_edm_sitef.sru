HA$PBExportHeader$uo_edm_sitef.sru
forward
global type uo_edm_sitef from nonvisualobject
end type
end forward

global type uo_edm_sitef from nonvisualobject
end type
global uo_edm_sitef uo_edm_sitef

type variables
String Id_Status

String cd_Rede = "00019"

String de_Produto[]
String cd_Produto[]
String qt_Vendida[]
String vl_praticado[]
String id_Grupo[]

Long ivl_Produtos
Long ivl_Enviados




end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_insere_produto_autorizacao (long pl_codigo, string ps_descricao, long pl_quantidade, decimal pdc_preco_unitario, string ps_grupo)
public function string of_mensagem_produto ()
end prototypes

public subroutine of_inicializa ();String 	ls_Nulo[]

SetNull(Id_Status)

This.ivl_Produtos = 0
This.ivl_Enviados = 0

This.de_Produto 	= ls_Nulo
This.id_Grupo   	= ls_Nulo
This.cd_Produto 	= ls_Nulo
This.qt_Vendida 	= ls_Nulo
This.vl_praticado = ls_Nulo




end subroutine

public function boolean of_insere_produto_autorizacao (long pl_codigo, string ps_descricao, long pl_quantidade, decimal pdc_preco_unitario, string ps_grupo);
If IsNull(This.ivl_Produtos) Then This.ivl_Produtos = 0

This.id_Status = '1'

This.ivl_Produtos ++

This.cd_Produto  [This.ivl_Produtos] = String(pl_codigo,'000000')
This.de_Produto  [This.ivl_Produtos] = ps_descricao
This.qt_Vendida  [This.ivl_Produtos] = String(pl_quantidade,'000')
This.vl_praticado[This.ivl_Produtos] = LeftA(String(pdc_preco_unitario,'####0.00'),LenA(String(pdc_preco_unitario,'####0.00'))-3) + RightA(String(pdc_preco_unitario,'####0.00'),2)
This.id_Grupo    [This.ivl_Produtos] = ps_grupo

Return True
end function

public function string of_mensagem_produto ();String ls_Retorno

This.ivl_Enviados ++				 

ls_Retorno = This.de_Produto  [This.ivl_Enviados] + ";" + &
				 This.cd_Produto  [This.ivl_Enviados] + ";" + &
				 This.qt_Vendida  [This.ivl_Enviados] + ";" + &
				 This.vl_praticado[This.ivl_Enviados] + ";" + &
				 This.id_Grupo    [This.ivl_Enviados] + ";"
				 			 
Return ls_Retorno				 
end function

on uo_edm_sitef.create
TriggerEvent( this, "constructor" )
end on

on uo_edm_sitef.destroy
TriggerEvent( this, "destructor" )
end on

