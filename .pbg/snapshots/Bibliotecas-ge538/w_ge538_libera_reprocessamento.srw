HA$PBExportHeader$w_ge538_libera_reprocessamento.srw
forward
global type w_ge538_libera_reprocessamento from dc_w_response_ok_cancela
end type
end forward

global type w_ge538_libera_reprocessamento from dc_w_response_ok_cancela
string tag = "w_ge538_libera_processamento"
integer width = 2181
integer height = 484
string title = "GE538 - Libera Processamento Autom$$HEX1$$e100$$ENDHEX$$tico"
end type
global w_ge538_libera_reprocessamento w_ge538_libera_reprocessamento

type variables
String ivs_Operador

uo_filial ivo_Filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();Integer lvi_Nulo


SetNull(lvi_Nulo)

dw_1.AcceptText()

ivo_Filial.of_Localiza_Filial(dw_1.GetText())

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial[1]   = ivo_Filial.Cd_Filial
	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
Else
	dw_1.Object.Cd_Filial[1]   = lvi_Nulo
	dw_1.Object.Nm_Filial[1] = ""
End If
end subroutine

on w_ge538_libera_reprocessamento.create
call super::create
end on

on w_ge538_libera_reprocessamento.destroy
call super::destroy
end on

event ue_postopen;dw_1.insertrow(0)
dw_1.AcceptText()
end event

event open;call super::open;lstr_scanntech lstr_parm

lstr_parm 		= Message.PowerObjectParm

ivo_Filial	= Create uo_Filial

// Verifica acesso no procedimento
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE538_LIBERA_REPROCESSAMENTO", ref ivs_Operador) Then
	lstr_parm.as_botao = 'CA'
	CloseWithReturn(This, lstr_parm)
	Return
End If

dw_1.SetFocus()
dw_1.SetColumn('nm_filial')



end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge538_libera_reprocessamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge538_libera_reprocessamento
integer x = 9
integer y = 0
integer width = 2144
integer height = 280
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge538_libera_reprocessamento
integer x = 59
integer width = 2080
integer height = 180
string dataobject = "dw_ge538_selecao"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna


If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'nm_filial' Then		
		wf_Localiza_Filial()
	End If
End If
	
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge538_libera_reprocessamento
integer x = 1513
integer y = 284
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Date ld_dh_inicio, ld_dh_termino
Long ll_cd_filial

lstr_scanntech lstr_parm


dw_1.AcceptText()

ld_dh_inicio	= dw_1.object.dh_inicio[1]
ld_dh_termino = dw_1.object.dh_termino[1]
ll_cd_filial = dw_1.object.cd_filial[1]

If IsNull(ld_dh_inicio) or IsNull(ld_dh_termino) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Necess$$HEX1$$e100$$ENDHEX$$rio informar as datas de in$$HEX1$$ed00$$ENDHEX$$cio de t$$HEX1$$e900$$ENDHEX$$rmino do reprocessamento.',Stopsign!)   	
	dw_1.Setcolumn("dh_inicio")
	Return
End If

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Deseja realmente habilitar movimento para reprocessar novamente?', Exclamation! , OKCancel!, 2 ) = 2 Then
	Return
End If	

lstr_parm.dh_inicio = ld_dh_inicio
lstr_parm.dh_termino = ld_dh_termino
lstr_parm.cd_filial = ll_cd_filial
lstr_parm.as_botao = 'OK'

CloseWithReturn(Parent, lstr_parm)







  	
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge538_libera_reprocessamento
integer x = 1847
integer y = 284
end type

event cb_cancelar::clicked;//Overrider
lstr_scanntech lstr_parm

lstr_parm.as_botao = 'CA'

CloseWithReturn(Parent, lstr_parm)
end event

