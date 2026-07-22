HA$PBExportHeader$w_ge041_impressao_etiqueta_licitacao.srw
forward
global type w_ge041_impressao_etiqueta_licitacao from dc_w_response_ok_cancela
end type
end forward

global type w_ge041_impressao_etiqueta_licitacao from dc_w_response_ok_cancela
string tag = "w_ge041_imprssao_etiqueta_licitacao"
integer width = 1230
integer height = 696
string title = "GE041 - Impress$$HEX1$$e300$$ENDHEX$$o Etiqueta Licita$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge041_impressao_etiqueta_licitacao w_ge041_impressao_etiqueta_licitacao

type variables
str_etiqueta1 istr_parm



end variables

forward prototypes
public function Boolean wf_atualiza_alteracao_volume (long al_nr_nf, string as_de_especie, string as_de_serie, long al_qtd_volume)
public function boolean wf_dados_destinatario (long al_nr_nf, string as_de_especie, string as_de_serie, ref string as_nm_razao_social)
public subroutine _documentacao ()
end prototypes

public function Boolean wf_atualiza_alteracao_volume (long al_nr_nf, string as_de_especie, string as_de_serie, long al_qtd_volume);

Update nf_venda_nfe
	Set qt_volume  	= :al_qtd_volume
Where nr_nf  			=:al_nr_nf 
	And de_especie	=:as_de_especie
	And de_serie 		=:as_de_serie
	And cd_filial     		= 534
Using Sqlca;	

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_rollback( );
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao atualizar a tabela NF_VENDA_NFE.",stopsign!)
	Return False
End If 	

Sqlca.of_commit( );

Return True
end function

public function boolean wf_dados_destinatario (long al_nr_nf, string as_de_especie, string as_de_serie, ref string as_nm_razao_social);String ls_nm_razao_social


 Select b.nm_razao_social
    Into :ls_nm_razao_social
  From nf_venda a 
  Inner Join cliente b On a.cd_cliente  = b.cd_cliente
Where a.cd_filial  = 534
    And a.id_licitacao  = 'S'
    And a.nr_nf  		= :al_nr_nf
    And a.de_especie	=:as_de_especie
    And a.de_serie 		=:as_de_serie
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao acessar os dados do Destinat$$HEX1$$e100$$ENDHEX$$rio.",stopsign!)
	Return False	
End If

as_nm_razao_social = ls_nm_razao_social

Return True
end function

public subroutine _documentacao ();/*	  Objetivo: Objetivo dessa janela $$HEX1$$e900$$ENDHEX$$ imprimir etiquetas de licita$$HEX2$$e700e300$$ENDHEX$$o, com base na quantidade de volume retornado ou informado.
	Chamado: 1080940
Respons$$HEX1$$e100$$ENDHEX$$vel: Saulo Braga

Obs.: Essa tela somente pode ser acessada pelo WMS, pelo compras n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ habilitado.

Tabelas: 
			-	nf_venda_nfe
			-	cliente
			-	nf_venda

*/






end subroutine

on w_ge041_impressao_etiqueta_licitacao.create
call super::create
end on

on w_ge041_impressao_etiqueta_licitacao.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;Long ll_nr_nf, ll_volume

String ls_de_serie, ls_de_especie

istr_parm = message.PowerObjectParm

ll_nr_nf 			= istr_parm.al_nr_nf
ls_de_serie 		= istr_parm.as_de_serie
ls_de_especie	= istr_parm.as_de_especie
ll_volume		= istr_parm.al_volume

dw_1.Object.nr_nf[1]				= 	ll_nr_nf
dw_1.Object.de_especie[1]		=	ls_de_especie
dw_1.Object.de_serie[1]			=	ls_de_serie
dw_1.Object.qtd_volume[1]		=	ll_volume

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge041_impressao_etiqueta_licitacao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge041_impressao_etiqueta_licitacao
integer width = 1175
integer height = 436
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge041_impressao_etiqueta_licitacao
integer y = 56
integer width = 1056
integer height = 364
string dataobject = "dw_ge041_selecao"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge041_impressao_etiqueta_licitacao
integer x = 539
integer y = 472
end type

event cb_ok::clicked;call super::clicked;//Overrider
Long ll_qtd_volume_impresso
Long ll_nr_nf, ll_cont
String ls_de_especie, ls_de_serie, ls_nm_razao_social
String ls_ImpressoraZebra

dw_1.AcceptText()

istr_parm.as_acao = 'OK'

ll_nr_nf						= dw_1.Object.nr_nf[1]
ls_de_especie				= dw_1.Object.de_especie[1]
ls_de_serie					= dw_1.Object.de_serie[1]
ll_qtd_volume_impresso 	= dw_1.Object.qtd_volume[1]

If ll_qtd_volume_impresso = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar a quantidade de volume para ser impresso.",INFORMATION!)
	Return
End If	

If ll_qtd_volume_impresso <> istr_parm.al_volume Then
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de Volumes informado $$HEX1$$e900$$ENDHEX$$ diferente do Numero de Volumes informado no Faturamento de Licita$$HEX2$$e700e300$$ENDHEX$$o desta Nota! Deseja Continuar ?",information!,yesno!, 1 ) = 1 Then
		If Not wf_atualiza_alteracao_volume(ll_nr_nf,ls_de_especie,ls_de_serie,ll_qtd_volume_impresso) Then
			Return
		End If	
	End If
End If

dc_uo_ds_base ids_etiqueta

ids_etiqueta = Create dc_uo_ds_base

If Not ids_etiqueta.of_ChangeDataObject("ds_ge041_etiqueta_print") Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao validar dados de etiquetas.",stopsign!)
	Return -1
End If

If Not wf_dados_destinatario(ll_nr_nf,ls_de_especie,ls_de_serie,ls_nm_razao_social) Then
	Return 
End If

ids_etiqueta.reset( )
For ll_cont = 1 To ll_qtd_volume_impresso
	ids_etiqueta.Object.t_cabecalho.text 			=  ls_nm_razao_social  
	ids_etiqueta.Object.nr_cgc[ll_cont] 			=	istr_parm.as_nr_cnpj
	ids_etiqueta.Object.nr_nf[ll_cont]				=	ll_nr_nf
	ids_etiqueta.Object.dh_corrente[ll_cont]		=	Today()
	ids_etiqueta.Object.volume1[ll_cont] 			= 	ll_cont
	ids_etiqueta.Object.volume2[ll_cont] 			= 	ll_qtd_volume_impresso
Next	

PrintSetup()
ids_etiqueta.print()
ids_etiqueta.reset( )
Destroy ids_etiqueta

CloseWithReturn(Parent,istr_parm)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge041_impressao_etiqueta_licitacao
integer x = 873
integer y = 472
end type

event cb_cancelar::clicked;//Overrider

istr_parm.as_acao = 'CA'

CloseWithReturn(Parent,istr_parm)

end event

