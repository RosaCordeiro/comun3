HA$PBExportHeader$w_ge645_response_imp_etiquetas.srw
forward
global type w_ge645_response_imp_etiquetas from dc_w_response_ok_cancela
end type
end forward

global type w_ge645_response_imp_etiquetas from dc_w_response_ok_cancela
string tag = "w_ge645_response_imp_etiquetas"
integer width = 4763
integer height = 1972
string title = "GE645 - Informar Volumes das NF~'s"
end type
global w_ge645_response_imp_etiquetas w_ge645_response_imp_etiquetas

on w_ge645_response_imp_etiquetas.create
call super::create
end on

on w_ge645_response_imp_etiquetas.destroy
call super::destroy
end on

event open;call super::open;dc_uo_ds_base lvds_Param

lvds_Param = Message.PowerObjectParm

lvds_Param.RowsCopy( 1, lvds_Param.RowCount(), Primary!, dw_1, 1, Primary!)


end event

event ue_postopen;call super::ue_postopen;Long ll_last_row

ll_last_row = dw_1.RowCount()

if ll_last_row > 0 then
    if isnull(dw_1.object.nr_nf[ll_last_row]) then
        dw_1.DeleteRow(ll_last_row)
    end if
end if
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge645_response_imp_etiquetas
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge645_response_imp_etiquetas
integer width = 4699
integer height = 1724
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge645_response_imp_etiquetas
integer width = 4645
integer height = 1640
string dataobject = "dw_ge645_resp_lista_imp_etiqueta"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge645_response_imp_etiquetas
integer x = 3666
integer y = 1756
integer width = 718
string text = "&Imprimir Etiquetas"
end type

event cb_ok::clicked;call super::clicked;Long 		ll_Volumes,&
			ll_Qt_Impressa,&
			ll_Linha,&
			ll_Linhas,&
			ll_Nr_Nf
						
String		ls_Especie,&
			ls_Serie
			
Boolean lb_Sucesso = False

If PrintSetup() = -1 Then
	MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
	Return -1
End If

uo_ge224_etiqueta_vol_dev_compra lo_Etiqueta		
lo_Etiqueta = Create uo_ge224_etiqueta_vol_dev_compra

Try
	dw_1.AcceptText()
	
	ll_linhas = dw_1.RowCount()
	
	Open(w_Aguarde)
		
	w_Aguarde.Title = 'Imprimindo Etiquetas...'
	w_Aguarde.uo_Progress.of_SetMax(ll_linhas)
	
	ll_Qt_Impressa = 0
	
	For ll_Linha = 1 To ll_linhas
		ll_Qt_Impressa ++
		
		w_Aguarde.Title = 'Imprimindo... '+String(ll_Qt_Impressa)+' de '+String(ll_linhas)
		w_Aguarde.uo_Progress.of_SetProgress(ll_Qt_Impressa)
			
		ll_Nr_Nf					= dw_1.Object.nr_nf					[ll_Linha]
		ls_Especie				= dw_1.Object.de_especie			[ll_Linha]
		ls_Serie					= dw_1.Object.de_serie				[ll_Linha]
		ll_volumes				= dw_1.Object.nr_volumes			[ll_Linha]
		
		If Not IsNull(ll_Nr_Nf) And Not IsNull(ls_Especie) And Not IsNull(ls_Serie) And Not IsNull(ll_volumes) And ll_volumes > 0 Then
			lb_Sucesso = lo_Etiqueta.of_emite_etiqueta(ll_Nr_Nf, ls_Serie, ls_Especie, ll_Volumes)
		End If
	Next
	
Finally
	Destroy(lo_Etiqueta)
	If lb_Sucesso Then 
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Etiqueta(s) Impressa(s)!')
		closewithreturn(Parent, 1)
	Else
		closewithreturn(Parent, 0)
	End If
End Try

Return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge645_response_imp_etiquetas
integer x = 4416
integer y = 1756
end type

