HA$PBExportHeader$uo_classificacao_tributaria.sru
forward
global type uo_classificacao_tributaria from nonvisualobject
end type
end forward

global type uo_classificacao_tributaria from nonvisualobject
end type
global uo_classificacao_tributaria uo_classificacao_tributaria

type variables
uo_imposto_cst ivo_imposto_cst 

String id_imposto_tributacao
String cd_classe_tributaria
String de_imposto_tributacao
Long id_imposto_cst
Decimal{4} pc_reducao_aliq_cbs
Decimal{4} pc_reducao_aliq_ibs
Integer cd_mensagem_fiscal
String id_tipo_aliquota
String id_trib_regular = 'N'
String id_estorno_credito = 'N'
String cd_tax_situation_sap

Boolean Localizado = False

end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (string ps_id_imposto_tributacao)
public function boolean of_localiza_generica (string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(id_imposto_tributacao)
SetNull(cd_classe_tributaria)
SetNull(de_imposto_tributacao)
SetNull(id_imposto_cst)
SetNull(pc_reducao_aliq_cbs)
SetNull(pc_reducao_aliq_ibs)
SetNull(cd_mensagem_fiscal)
SetNull(id_tipo_aliquota)
SetNull(id_trib_regular)
SetNull(id_estorno_credito)
SetNull(cd_tax_situation_sap)

Localizado = False

ivo_imposto_cst.Of_Inicializa()
end subroutine

public function boolean of_localiza_codigo (string ps_id_imposto_tributacao);Try
	Select id_imposto_tributacao,
			cd_classe_tributaria,
			de_imposto_tributacao,
			id_imposto_cst,
			pc_reducao_aliq_cbs,
			pc_reducao_aliq_ibs,
			cd_mensagem_fiscal,
			id_tipo_aliquota,
			id_trib_regular,
			id_estorno_credito,
			cd_tax_situation_sap
	Into 	:This.id_imposto_tributacao,
			:This.cd_classe_tributaria,
			:This.de_imposto_tributacao,
			:This.id_imposto_cst,
			:This.pc_reducao_aliq_cbs,
			:This.pc_reducao_aliq_ibs,
			:This.cd_mensagem_fiscal,
			:This.id_tipo_aliquota,
			:This.id_trib_regular,
			:This.id_estorno_credito,
			:This.cd_tax_situation_sap
	From imposto_tributacao
	Where id_imposto_tributacao = :ps_id_imposto_tributacao
	Using SQLCa;
	
	This.Localizado = (SQLCa.SQLCode = 0)
	
	If Not This.Localizado Then 
		This.of_Inicializa()
	Else
		ivo_imposto_cst.Of_Localiza_Codigo(This.id_imposto_cst)
	End If

Catch (RuntimeError lvo_Erro)
	gvo_Aplicacao.Of_Grava_Log(lvo_Erro.GetMessage())
	This.Localizado = False
	Return This.Localizado
	
Finally
	//
End Try

Return This.Localizado
end function

public function boolean of_localiza_generica (string ps_parametro);String	lvs_Retorno

OpenWithParm (w_ge021_selecao_tributacao, ps_parametro) 

lvs_Retorno = Message.StringParm

If Not IsNull (lvs_Retorno) and lvs_Retorno <> '' then
	This.Of_Localiza_Codigo (lvs_Retorno)
Else
	This.Of_Inicializa( )
End If

Return Localizado
end function

on uo_classificacao_tributaria.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_classificacao_tributaria.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_imposto_cst = Create uo_imposto_cst

This.Of_Inicializa()
end event

event destructor;If IsValid(ivo_imposto_cst) Then Destroy(ivo_imposto_cst)
end event

