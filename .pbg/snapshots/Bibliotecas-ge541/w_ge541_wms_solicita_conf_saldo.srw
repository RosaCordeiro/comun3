HA$PBExportHeader$w_ge541_wms_solicita_conf_saldo.srw
forward
global type w_ge541_wms_solicita_conf_saldo from dc_w_response_ok_cancela
end type
end forward

global type w_ge541_wms_solicita_conf_saldo from dc_w_response_ok_cancela
integer width = 2130
integer height = 632
string title = "GE541 - Solicita$$HEX2$$e700e300$$ENDHEX$$o Valida$$HEX2$$e700e300$$ENDHEX$$o Saldo SAP x LEGADO"
end type
global w_ge541_wms_solicita_conf_saldo w_ge541_wms_solicita_conf_saldo

type variables
uo_Produto ivo_Produto
end variables

forward prototypes
public function boolean wf_grava_integracao_wmp_sap (ref string as_erro)
end prototypes

public function boolean wf_grava_integracao_wmp_sap (ref string as_erro);Long	ll_nr_integracao, &
		ll_cd_produto		
String	ls_id_somente_com_saldo, &
		ls_cd_deposito, &
		ls_cd_chave_interface

If not gf_proximo_seq_int_wms(ref ll_nr_integracao, ref as_erro) Then
	 Return False
End If

dw_1.accepttext( )

ll_cd_produto = dw_1.GetItemNumber(1,"cd_produto")
ls_cd_deposito = dw_1.GetItemString(1,"cd_deposito")
If ls_cd_deposito = '0000' then SetNull(ls_cd_deposito)
ls_id_somente_com_saldo = dw_1.GetItemString(1,"id_somente_saldo")
ls_cd_chave_interface = String(ll_nr_integracao)

//Grava wms_int_sap
INSERT INTO wms_int_sap
            (nr_integracao,
             cd_tipo,
             dh_inclusao,
             id_situacao,
             cd_produto,
             cd_filial,
             cd_deposito,
             cd_chave_interface,
			id_somente_com_saldo)
VALUES  (:ll_nr_integracao,
             6,
             getdate(),
             'C',
             :ll_cd_produto,
             534,
             :ls_cd_deposito,
             :ls_cd_chave_interface,
			:ls_id_somente_com_saldo) 
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro	= "Erro ao gravar na tabela {wms_int_sap}. Erro: "+SqlCa.SqlErrText
	Return False
End If

Return True

end function

on w_ge541_wms_solicita_conf_saldo.create
call super::create
end on

on w_ge541_wms_solicita_conf_saldo.destroy
call super::destroy
end on

event open;call super::open;ivo_Produto = Create uo_Produto
end event

event close;call super::close;Destroy(ivo_Produto)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge541_wms_solicita_conf_saldo
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge541_wms_solicita_conf_saldo
integer width = 2075
integer height = 416
string text = " Solicitar Confer$$HEX1$$ea00$$ENDHEX$$ncia de Saldo "
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge541_wms_solicita_conf_saldo
integer y = 60
integer width = 2016
integer height = 348
string dataobject = "dw_ge541_wms_solicita_conf_saldo"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	
	Case "nm_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_descricao_apresentacao_venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto	[Row] = ivo_Produto.cd_produto
			This.Object.nm_produto	[Row] = ivo_Produto.ivs_descricao_apresentacao_venda
		End If

	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then 
	This.Object.nm_produto[1] = ivo_Produto.ivs_descricao_apresentacao_venda
End If	
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName() 
			
		Case "nm_produto"
			ivo_Produto.Of_Inicializa()
			
			ivo_Produto.of_Localiza_produto( This.getText() )
			
			This.Object.cd_produto	[1] = ivo_Produto.cd_produto
			This.Object.nm_produto	[1] = ivo_Produto.ivs_descricao_apresentacao_venda
		
	End Choose
	
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge541_wms_solicita_conf_saldo
integer x = 1467
integer y = 432
string text = "&Gravar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_log
//Faz a gravacao
If Not wf_grava_integracao_wmp_sap(Ref ls_log) Then
	SqlCa.of_rollback( )
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_log, StopSign!)
Else
	SqlCa.of_commit( )
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Solicita$$HEX2$$e700e300$$ENDHEX$$o da valida$$HEX2$$e700e300$$ENDHEX$$o de saldo SAP x LEGADO gravada com sucesso.")
End If

CloseWithReturn(Parent, 1)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge541_wms_solicita_conf_saldo
integer x = 1787
integer y = 432
end type

event cb_cancelar::clicked;//override
CloseWithReturn(Parent, 0)
end event

