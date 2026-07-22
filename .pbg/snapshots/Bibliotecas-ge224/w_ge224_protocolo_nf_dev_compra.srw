HA$PBExportHeader$w_ge224_protocolo_nf_dev_compra.srw
forward
global type w_ge224_protocolo_nf_dev_compra from dc_w_response_ok_cancela
end type
end forward

global type w_ge224_protocolo_nf_dev_compra from dc_w_response_ok_cancela
string tag = "w_ge224_protocolo_nf_dev_compra"
integer width = 2039
integer height = 840
string title = "GE224 - Protocolo NF Devolu$$HEX2$$e700e300$$ENDHEX$$o Compra"
end type
global w_ge224_protocolo_nf_dev_compra w_ge224_protocolo_nf_dev_compra

type variables
string is_fornecedor, is_serie, is_especie, is_motivo, is_nm_fornecedor, is_protocolo, is_situacao, is_Operador
long il_nr_nf

boolean ib_novo_cadastro = false
end variables

forward prototypes
public function boolean wf_insere_protocolo ()
public function boolean wf_carrega_dados ()
public function boolean wf_atualiza_protocolo ()
end prototypes

public function boolean wf_insere_protocolo ();

INSERT INTO nf_devolucao_compra_protocolo (cd_fornecedor, nr_nf, de_especie, de_serie, id_protocolo_fornecedor, dh_inclusao, nr_matricula_inclusao, id_situacao) 
VALUES(:is_fornecedor, :il_nr_nf, :is_especie, :is_serie, :is_protocolo, getdate(), :is_Operador, :is_situacao )
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao gravar registro na nf_devolucao_compra_protocolo.~r~n"+SQLCa.SQLErrText )
	SQLCa.Of_RollBack()
	Return False
Else
	SQLCa.Of_Commit()
End If

Return True
end function

public function boolean wf_carrega_dados ();SELECT 
    id_protocolo_fornecedor,
    id_situacao
INTO
	:is_protocolo,
	:is_situacao
FROM 
    nf_devolucao_compra_protocolo
WHERE 
    cd_fornecedor = :is_fornecedor  
    AND nr_nf = :il_nr_nf
    AND de_serie = :is_serie
    AND de_especie = :is_especie
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao carregar dados da nf_devolucao_compra_protocolo.~r~n"+SQLCa.SQLErrText )
	Return False
End If

If isnull(is_protocolo) or trim(is_protocolo) = "" then ib_novo_cadastro = true

Return True
end function

public function boolean wf_atualiza_protocolo ();UPDATE 
	nf_devolucao_compra_protocolo 
SET 
	id_protocolo_fornecedor = :is_protocolo,
	nr_matricula_inclusao = :is_Operador,
	id_situacao = :is_situacao
WHERE
	cd_fornecedor = :is_fornecedor
	AND nr_nf = :il_nr_nf
	AND de_especie = :is_especie
	AND de_serie = :is_serie
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Erro ao atualizar registro na nf_devolucao_compra_protocolo.~r~n"+SQLCa.SQLErrText )
	SQLCa.Of_RollBack()
	Return False
Else
	SQLCa.Of_Commit()
End If

Return True
end function

on w_ge224_protocolo_nf_dev_compra.create
call super::create
end on

on w_ge224_protocolo_nf_dev_compra.destroy
call super::destroy
end on

event open;call super::open;st_ge224_parametros_protocolo lst_Parametro

lst_Parametro = Message.PowerObjectParm

is_fornecedor 	= lst_Parametro.cd_fornecedor
is_nm_fornecedor = lst_Parametro.nm_razao_social
il_nr_nf			= lst_Parametro.nr_nf
is_serie			= lst_Parametro.de_serie
is_especie		= lst_Parametro.de_especie
is_motivo		= lst_Parametro.de_motivo

end event

event ue_postopen;call super::ue_postopen;is_Operador = gvo_aplicacao.ivo_seguranca.nr_matricula

dw_1.accepttext( )

dw_1.object.nm_fornecedor[1]	= is_fornecedor + ' - ' + is_nm_fornecedor
dw_1.object.nr_nf[1] 				= string(il_nr_nf)
dw_1.object.de_serie[1] 		= is_serie
dw_1.object.de_especie[1] 		= is_especie
dw_1.object.de_motivo[1] 		= is_motivo

wf_carrega_dados()

If Not ib_novo_cadastro Then
	dw_1.object.id_protocolo[1] 	= is_protocolo
	dw_1.object.id_situacao[1] 		= is_situacao
End if
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge224_protocolo_nf_dev_compra
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge224_protocolo_nf_dev_compra
integer width = 1947
integer height = 604
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge224_protocolo_nf_dev_compra
integer y = 72
integer width = 1829
integer height = 480
string dataobject = "dw_ge224_protocolo_nf_dev_compra"
boolean ivb_updateable = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge224_protocolo_nf_dev_compra
integer x = 1330
integer y = 628
string text = "&Salvar"
end type

event cb_ok::clicked;call super::clicked;dw_1.accepttext( )

is_protocolo = trim(dw_1.object.id_protocolo[1])
is_situacao = trim(dw_1.object.id_situacao[1])

If Len(trim(is_protocolo)) < 2 Or IsNull(is_protocolo) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe um protocolo!')
	dw_1.Event ue_Pos(1, "id_protocolo")
	Return 1
End If

If ib_novo_cadastro Then
	If wf_insere_protocolo() Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Protocolo Salvo!')
		closewithreturn(parent, 'ok')
	End if
Else
	If wf_atualiza_protocolo() Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Atualizado!')
		closewithreturn(parent, 'ok')
	End if
End If

return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge224_protocolo_nf_dev_compra
integer x = 1659
integer y = 628
end type

