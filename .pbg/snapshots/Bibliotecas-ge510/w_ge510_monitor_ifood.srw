HA$PBExportHeader$w_ge510_monitor_ifood.srw
forward
global type w_ge510_monitor_ifood from dc_w_selecao_lista_relatorio
end type
type st_1 from statictext within w_ge510_monitor_ifood
end type
type st_data from statictext within w_ge510_monitor_ifood
end type
type st_2 from statictext within w_ge510_monitor_ifood
end type
type iuo_1 from uo_ge510_monitor_ifood within w_ge510_monitor_ifood
end type
type iuo_2 from uo_ge510_monitor_ifood within w_ge510_monitor_ifood
end type
type iuo_3 from uo_ge510_monitor_ifood within w_ge510_monitor_ifood
end type
type iuo_4 from uo_ge510_monitor_ifood within w_ge510_monitor_ifood
end type
end forward

global type w_ge510_monitor_ifood from dc_w_selecao_lista_relatorio
integer width = 5618
integer height = 3028
string title = "GE510 - Monitor Interfaces Ifood"
st_1 st_1
st_data st_data
st_2 st_2
iuo_1 iuo_1
iuo_2 iuo_2
iuo_3 iuo_3
iuo_4 iuo_4
end type
global w_ge510_monitor_ifood w_ge510_monitor_ifood

type variables
string is_id_ecommerce = '3'
uo_filial io_filial
end variables

forward prototypes
public subroutine wf_atualizar ()
public function boolean wf_aplica_filtro ()
end prototypes

public subroutine wf_atualizar ();long ll_cd_filial
string ls_id_erro
string ls_log

iuo_1.of_carrega_interface( is_id_ecommerce, 7, ref ls_log )
iuo_2.of_carrega_interface( is_id_ecommerce, 8, ref ls_log )
iuo_3.of_carrega_interface( is_id_ecommerce, 9, ref ls_log )
iuo_4.of_carrega_interface( is_id_ecommerce, 13, ref ls_log )

st_data.text = String( gf_getserverdate() , 'dd/mm/yyyy hh:mm' )
end subroutine

public function boolean wf_aplica_filtro ();long ll_cd_filial
string ls_id_erro
string ls_filtro

ll_cd_filial = dw_1.object.cd_filial[1]
ls_id_erro = dw_1.object.id_exibe_erro[1]

ls_filtro = ''

if ll_cd_filial > 0 then
	ls_filtro = 'cd_filial = ' + string(ll_cd_filial)
end if

if ls_id_erro = 'S' Then
	if ls_filtro <> '' then
		ls_filtro += ' and '
	end if
	ls_filtro = 'id_situacao = "E"'
end if

iuo_1.of_filtro( ls_filtro )
iuo_2.of_filtro( ls_filtro )
iuo_3.of_filtro( ls_filtro )
iuo_4.of_filtro( ls_filtro )

return true
end function

on w_ge510_monitor_ifood.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_data=create st_data
this.st_2=create st_2
this.iuo_1=create iuo_1
this.iuo_2=create iuo_2
this.iuo_3=create iuo_3
this.iuo_4=create iuo_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_data
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.iuo_1
this.Control[iCurrent+5]=this.iuo_2
this.Control[iCurrent+6]=this.iuo_3
this.Control[iCurrent+7]=this.iuo_4
end on

on w_ge510_monitor_ifood.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_data)
destroy(this.st_2)
destroy(this.iuo_1)
destroy(this.iuo_2)
destroy(this.iuo_3)
destroy(this.iuo_4)
end on

event ue_postopen;call super::ue_postopen;wf_atualizar()

//Timer(60)
end event

event timer;call super::timer;wf_atualizar()
end event

event open;call super::open;io_filial = create uo_filial

Timer(60)
end event

event key;call super::key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge510_monitor_ifood
integer x = 887
integer y = 2788
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge510_monitor_ifood
integer x = 850
integer y = 2716
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge510_monitor_ifood
integer y = 280
integer width = 5504
integer height = 2520
string text = "Interfaces"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge510_monitor_ifood
integer width = 5504
integer height = 252
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge510_monitor_ifood
integer y = 68
integer width = 1861
integer height = 176
string dataobject = "dw_ge510_monitor_ifood_selecao"
end type

event dw_1::itemchanged;long ll_nulo

if dwo.name = 'id_exibe_erro' then
	post wf_aplica_filtro()
end if

if dwo.name = 'nm_filial' then
	
	if data = '' or isnull(data) Then
		setnull(ll_nulo)
		object.cd_filial[row] = ll_nulo
	end if
	
	post wf_aplica_filtro()
	
end if
end event

event dw_1::ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
			
		Case "nm_filial"
			io_Filial.of_Localiza_Filial(This.GetText())
	
			If io_Filial.Localizada Then
				This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial 
				This.Object.Nm_Filial[1] = io_Filial.Nm_Fantasia
			End If	

			post wf_aplica_filtro()

	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge510_monitor_ifood
boolean visible = false
integer x = 3346
integer y = 64
integer width = 229
integer height = 168
string dataobject = "dw_ge510_monitor_ifood_lista"
boolean border = true
end type

event dw_2::buttonclicked;call super::buttonclicked;st_ge510_detalhes lst_parametros

if dwo.name = 'b_detalhes' then
	lst_parametros.cd_filial = this.object.cd_filial[row]
	lst_parametros.nr_atualizacao = this.object.nr_atualizacao_log[row]
	lst_parametros.cd_tipo = this.object.cd_tipo_log[row]
	
	OpenWithParm(w_ge510_monitor_interfaces_detalhe, lst_parametros)
	
end if
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;if dw_1.object.id_exibe_erro[1] = 'S' Then
	setfilter('id_situacao = "E" or c_nivel_alerta < 3')
else
	setfilter('')
end if
filter()

return pl_linhas
end event

event dw_2::ue_recuperar;return retrieve(986, is_id_ecommerce)
end event

event dw_2::ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge510_monitor_ifood
boolean visible = false
integer x = 2208
integer y = 76
integer width = 485
integer height = 160
end type

type st_1 from statictext within w_ge510_monitor_ifood
integer x = 4512
integer y = 164
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

type st_data from statictext within w_ge510_monitor_ifood
integer x = 4987
integer y = 164
integer width = 498
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

type st_2 from statictext within w_ge510_monitor_ifood
integer x = 105
integer y = 2732
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

type iuo_1 from uo_ge510_monitor_ifood within w_ge510_monitor_ifood
event destroy ( )
integer x = 87
integer y = 348
integer height = 2368
integer taborder = 20
boolean bringtotop = true
boolean border = true
end type

on iuo_1.destroy
call uo_ge510_monitor_ifood::destroy
end on

event ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if

return 1
end event

type iuo_2 from uo_ge510_monitor_ifood within w_ge510_monitor_ifood
event destroy ( )
integer x = 1445
integer y = 348
integer height = 2368
integer taborder = 30
boolean bringtotop = true
boolean border = true
end type

on iuo_2.destroy
call uo_ge510_monitor_ifood::destroy
end on

event ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if

return 1
end event

type iuo_3 from uo_ge510_monitor_ifood within w_ge510_monitor_ifood
event destroy ( )
integer x = 2802
integer y = 348
integer height = 2368
integer taborder = 30
boolean bringtotop = true
boolean border = true
end type

on iuo_3.destroy
call uo_ge510_monitor_ifood::destroy
end on

event ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if

return 1
end event

type iuo_4 from uo_ge510_monitor_ifood within w_ge510_monitor_ifood
event destroy ( )
integer x = 4160
integer y = 348
integer height = 2368
integer taborder = 40
boolean bringtotop = true
boolean border = true
end type

on iuo_4.destroy
call uo_ge510_monitor_ifood::destroy
end on

event ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if

return 1
end event

