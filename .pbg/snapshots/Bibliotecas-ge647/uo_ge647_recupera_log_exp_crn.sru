HA$PBExportHeader$uo_ge647_recupera_log_exp_crn.sru
forward
global type uo_ge647_recupera_log_exp_crn from nonvisualobject
end type
end forward

global type uo_ge647_recupera_log_exp_crn from nonvisualobject
end type
global uo_ge647_recupera_log_exp_crn uo_ge647_recupera_log_exp_crn

forward prototypes
public function boolean of_executa ()
end prototypes

public function boolean of_executa ();Boolean	lb_sucesso	= False
Date		ld_ultima_execucao
Long		ll_id_tipo_log, ll_cd_filial, ll_linhas, ll_nr_nf, ll_for
String	ls_log, ls_chave, ls_id_tipo_nf, ls_id_tipo_log, ls_cd_tipo_documento, &
			ls_de_especie, ls_de_serie, ls_cd_varchar

st_log_export_sap	lst_log_export_sap, lst_null
dc_uo_ds_base lds

Try
	ls_cd_tipo_documento	= 'CRN'
	ls_id_tipo_nf			= 'CRN'
	ls_cd_varchar			= '0002'
	ll_id_tipo_log			= 93

	lds = Create dc_uo_ds_base
	
	lds.Of_ChangeDataObject('ds_ge647_nf_transf_sem_log_exp_sap')
	
	ld_ultima_execucao	= RelativeDate(Date(gf_getserverdate()), -130)
	
	ll_Linhas	= lds.Retrieve(ld_ultima_execucao)
	
	For ll_for = 1 to ll_linhas
		lst_log_export_sap	= lst_null
		
		ll_nr_nf	= lds.GetItemNumber(ll_for, 'nr_nf')
		ll_cd_filial	= lds.GetItemNumber(ll_for, 'cd_filial_origem')
		ls_de_especie	= lds.GetItemString(ll_for, 'de_especie')
		ls_de_serie	= lds.GetItemString(ll_for, 'de_serie')
		
		ls_chave	= String(ll_nr_nf)
		
		lst_log_export_sap.cd_chave				= ls_chave
		lst_log_export_sap.id_tipo_nf				= ls_id_tipo_nf
		lst_log_export_sap.id_tipo_log			= ll_id_tipo_log
		lst_log_export_sap.cd_tipo_documento	= ls_cd_tipo_documento
		lst_log_export_sap.cd_filial				= ll_cd_filial
		lst_log_export_sap.nr_nf					= ll_nr_nf
		lst_log_export_sap.de_especie				= ls_de_especie
		lst_log_export_sap.de_serie				= ls_de_serie
		lst_log_export_sap.cd_varchar				= ls_cd_varchar
		
		lst_log_export_sap.cd_parametro_geral  = 'DH_INICIO_OPERACAO_SAP'
		
		If Not gf_insere_log_exportacao_sap(lst_log_export_sap, REF ls_log) Then
			SQLCA.of_rollback()
			gvo_aplicacao.of_grava_log (ls_Log)
			lb_sucesso	= False
			Continue
		Else
			SQLCA.of_commit()
		End If
	Next

	lb_sucesso	= True
Catch (RunTimeError RTE)
	ls_log = 'Erro ao executar processo para recuperar log da confirma$$HEX2$$e700e300$$ENDHEX$$o de recebimento das notas fiscais de transfer$$HEX1$$ea00$$ENDHEX$$ncia das lojas para o CD.~r~r' + RTE.getmessage()
	gvo_aplicacao.of_grava_log (ls_Log)
	lb_sucesso = False
Finally
	Return lb_sucesso
End Try

Return True
end function

on uo_ge647_recupera_log_exp_crn.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge647_recupera_log_exp_crn.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

