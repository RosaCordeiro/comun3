HA$PBExportHeader$w_ge510_monitor_saldo.srw
forward
global type w_ge510_monitor_saldo from dc_w_selecao_lista_relatorio
end type
type st_1 from statictext within w_ge510_monitor_saldo
end type
type st_data from statictext within w_ge510_monitor_saldo
end type
type st_2 from statictext within w_ge510_monitor_saldo
end type
end forward

global type w_ge510_monitor_saldo from dc_w_selecao_lista_relatorio
integer width = 2478
integer height = 2940
string title = "GE510 - Monitor Saldo Filiais"
st_1 st_1
st_data st_data
st_2 st_2
end type
global w_ge510_monitor_saldo w_ge510_monitor_saldo

type variables
string is_id_ecommerce = '2'

uo_filial io_filial
end variables

forward prototypes
public subroutine wf_atualizar ()
public subroutine wf_aplica_filtro ()
end prototypes

public subroutine wf_atualizar ();dw_2.event ue_retrieve()
//dw_4.event ue_retrieve()
//dw_5.event ue_retrieve()

st_data.text = String( gf_getserverdate() , 'dd/mm/yyyy hh:mm' )
end subroutine

public subroutine wf_aplica_filtro ();string ls_exibe_erro
string ls_exibe_alerta
long ll_cd_filial
string ls_filtro

dw_1.accepttext( )

ll_cd_filial = dw_1.object.cd_filial[1]
ls_exibe_erro = dw_1.object.id_exibe_erro[1]
ls_exibe_alerta = dw_1.object.id_exibe_alerta[1]

ls_filtro = ''

if ll_cd_filial > 0 then
	ls_filtro = 'cd_filial = ' + string(ll_cd_filial)
end if

if ls_exibe_erro = 'S' then
	if ls_filtro <> '' then
		ls_filtro += ' and '
	end if
	if ls_exibe_alerta = 'S' then
		ls_filtro += '(id_situacao = "E"'
	else
		ls_filtro += '(id_situacao = "E")'
	end if
end if

if ls_exibe_alerta = 'S' then
	if ls_filtro <> '' then
		if ls_exibe_erro = 'S' then
			ls_filtro += ' or c_nivel_alerta < 3)'
		else
			ls_filtro += ' and (c_nivel_alerta < 3)'
		end if
	else
		ls_filtro += '(c_nivel_alerta < 3)'
	end if
end if
	
dw_2.setfilter(ls_filtro)
dw_2.filter()
end subroutine

on w_ge510_monitor_saldo.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_data=create st_data
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_data
this.Control[iCurrent+3]=this.st_2
end on

on w_ge510_monitor_saldo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_data)
destroy(this.st_2)
end on

event ue_postopen;call super::ue_postopen;io_filial = create uo_filial

wf_atualizar()

end event

event timer;call super::timer;wf_atualizar()
end event

event open;call super::open;Timer(180)
end event

event key;call super::key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge510_monitor_saldo
integer x = 1047
integer y = 2132
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge510_monitor_saldo
integer x = 1010
integer y = 2152
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge510_monitor_saldo
integer y = 432
integer width = 2354
integer height = 2296
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge510_monitor_saldo
integer width = 2354
integer height = 400
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge510_monitor_saldo
integer y = 96
integer width = 1495
integer height = 284
string dataobject = "dw_ge510_monitor_saldo_selecao"
end type

event dw_1::itemchanged;long ll_nulo

Choose Case dwo.name 
		
	Case 	'nm_filial'
	
		if data = '' or isnull(data) Then
			setnull(ll_nulo)
			object.cd_filial[row] = ll_nulo
		end if
		
		post wf_aplica_filtro()
		
	Case 'id_exibe_erro' , 'id_exibe_alerta'
	
	post wf_aplica_filtro()
	
End choose
end event

event dw_1::ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if

If Key = KeyEnter! Then
	if This.GetColumnName() = "nm_filial" then
			io_Filial.of_Localiza_Filial(This.GetText())
	
			If io_Filial.Localizada Then
				This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial 
				This.Object.Nm_Filial[1] = io_Filial.Nm_Fantasia
				
				post wf_aplica_filtro()
				
			End If	

	End if
End If
end event

event dw_1::editchanged;//
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge510_monitor_saldo
integer y = 488
integer width = 2263
integer height = 2160
string dataobject = "dw_ge510_monitor_saldo_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::buttonclicked;call super::buttonclicked;st_ge510_detalhes lst_parametros

if dwo.name = 'b_detalhes' then
	lst_parametros.cd_filial = this.object.cd_filial[row]
	lst_parametros.nr_atualizacao = this.object.nr_atualizacao_log[row]
	lst_parametros.cd_tipo = this.object.cd_tipo_log[row]
	
	OpenWithParm(w_ge510_monitor_interfaces_detalhe, lst_parametros)
	
end if
end event

event dw_2::ue_recuperar;return retrieve( is_id_ecommerce)
end event

event dw_2::ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;wf_aplica_filtro()

return pl_linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge510_monitor_saldo
boolean visible = false
integer x = 2181
integer y = 16
end type

type st_1 from statictext within w_ge510_monitor_saldo
integer x = 1426
integer y = 320
integer width = 471
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "$$HEX1$$da00$$ENDHEX$$ltima Atualiza$$HEX2$$e700e300$$ENDHEX$$o:"
boolean focusrectangle = false
end type

type st_data from statictext within w_ge510_monitor_saldo
integer x = 1902
integer y = 320
integer width = 480
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge510_monitor_saldo
integer x = 105
integer y = 2656
integer width = 608
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "<F5> para atualizar"
boolean focusrectangle = false
end type

