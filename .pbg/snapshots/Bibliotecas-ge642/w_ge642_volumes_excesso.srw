HA$PBExportHeader$w_ge642_volumes_excesso.srw
forward
global type w_ge642_volumes_excesso from dc_w_response_ok_cancela
end type
type gb_2 from groupbox within w_ge642_volumes_excesso
end type
type gb_3 from groupbox within w_ge642_volumes_excesso
end type
type dw_3 from dc_uo_dw_base within w_ge642_volumes_excesso
end type
type dw_2 from dc_uo_dw_base within w_ge642_volumes_excesso
end type
type st_confirmar from statictext within w_ge642_volumes_excesso
end type
end forward

global type w_ge642_volumes_excesso from dc_w_response_ok_cancela
integer width = 3186
integer height = 1840
string title = "GE642 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Volumes"
gb_2 gb_2
gb_3 gb_3
dw_3 dw_3
dw_2 dw_2
st_confirmar st_confirmar
end type
global w_ge642_volumes_excesso w_ge642_volumes_excesso

type variables
Boolean							ib_Check = False
Long								il_nr_chv_volume
st_ge642_parametros_nota	ist_par_nota
end variables

on w_ge642_volumes_excesso.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_3=create dw_3
this.dw_2=create dw_2
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.st_confirmar
end on

on w_ge642_volumes_excesso.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.st_confirmar)
end on

event open;call super::open;ist_par_nota = Message.PowerObjectParm

Choose case ist_par_nota.id_acao
	case 'C'
		This.Title += ' para Cancelamento'
		cb_ok.Text  = '&Cancelar Volume(s)'
	case 'I'
		This.Title += ' para Impress$$HEX1$$e300$$ENDHEX$$o de Etiquetas'
		cb_ok.Text  = '&Imprimir Etiqueta(s)'
End choose
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.cd_filial   [1] = ist_par_nota.cd_filial
dw_1.Object.nm_fantasia [1] = ist_par_nota.nm_fantasia
dw_1.Object.nr_nf       [1] = ist_par_nota.nr_nf
dw_1.Object.de_especie  [1] = ist_par_nota.de_especie
dw_1.Object.de_serie    [1] = ist_par_nota.de_serie

dw_2.Post Event ue_retrieve ()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge642_volumes_excesso
integer y = 1644
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge642_volumes_excesso
integer y = 0
integer width = 1495
integer height = 252
string text = "Nota"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge642_volumes_excesso
integer x = 64
integer y = 56
integer width = 1435
integer height = 180
string dataobject = "dw_ge642_volume_cabecalho"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge642_volumes_excesso
integer x = 1129
integer y = 1644
integer width = 585
boolean default = false
end type

event cb_ok::clicked;call super::clicked;// Declara$$HEX2$$e700f500$$ENDHEX$$es

Long		ll_qtd_sel, &
			ll_linha,   &
			ll_linhas
			
String	ls_lista_volumes, &
			ls_msg = 'Selecione pelo menos um volume para '

// Procedimentos

dw_2.AcceptText ()

ll_qtd_sel = dw_2.Object.cf_qtd_sel [1]

If ll_qtd_sel = 0 then
	Choose case ist_par_nota.id_acao
		case 'C'
			ls_msg += 'fazer o cancelamento'
		case 'I'
			ls_msg += 'imprimir a etiqueta'
	End choose
	
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg)
	Return
End if

ll_linhas = dw_2.RowCount ()

If ll_qtd_sel = ll_linhas then
	//Todos os volumes
	ls_lista_volumes = '0'
else
	
	ll_linha = dw_2.Find ("id_sel = '" + 'S' + "'", 1, ll_linhas)
	
	Do Until ll_linha = 0
		If ls_lista_volumes = '' then
			ls_lista_volumes  = String (dw_2.Object.nr_volume [ll_linha])
		else
			ls_lista_volumes += ', ' + String (dw_2.Object.nr_volume [ll_linha])
		End if
		
		ll_linha ++
		If ll_linha > ll_linhas then
			Exit
		End if
		ll_linha = dw_2.Find ("id_sel = '" + 'S' + "'", ll_linha, ll_linhas)
	Loop
End if

If ist_par_nota.id_acao = 'C' then
	If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma o cancelamento do(s) volume(s) selecionado(s)?', Question!, YesNo!, 2) = 2 then
		SetNull (ls_lista_volumes)
	End if
End if

CloseWithReturn (Parent, ls_lista_volumes)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge642_volumes_excesso
integer x = 1737
integer y = 1644
string text = "&Fechar"
boolean default = true
end type

type gb_2 from groupbox within w_ge642_volumes_excesso
integer x = 23
integer y = 252
integer width = 3136
integer height = 692
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Volumes"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge642_volumes_excesso
integer x = 23
integer y = 944
integer width = 3136
integer height = 692
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within w_ge642_volumes_excesso
integer x = 55
integer y = 992
integer width = 3067
integer height = 624
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge642_volume_lista_produtos"
boolean vscrollbar = true
end type

event ue_recuperar;//Override
Long	ll_Linhas

ll_Linhas = This.Retrieve (il_nr_chv_volume)

If ll_Linhas = 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o foram encontrados produtos para o volume ' + String (il_nr_chv_volume))
End If

Return ll_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection ()
end event

type dw_2 from dc_uo_dw_base within w_ge642_volumes_excesso
event ue_mousemove pbm_mousemove
integer x = 55
integer y = 304
integer width = 3067
integer height = 624
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge642_volume_lista_volumes"
boolean vscrollbar = true
end type

event ue_mousemove;If This.RowCount () > 0 then
	If xpos >= Long (dw_2.Object.id_imagem.x) and xpos <= (Long (dw_2.Object.id_imagem.x) + 73) and &
		ypos >= Long (dw_2.Object.id_imagem.y) and ypos <= (Long (dw_2.Object.id_imagem.y) + 64) then
		
		st_confirmar.Visible = True
		
		If ib_Check then
			st_confirmar.Text = 'D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos'
		else
			st_confirmar.Text = 'D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos'
		End if
	else
		st_confirmar.Visible = False
	End if
End if
end event

event rowfocuschanged;call super::rowfocuschanged;il_nr_chv_volume = This.Object.nr_chave_volume [CurrentRow]

dw_3.Post Event ue_retrieve ()
end event

event ue_preretrieve;call super::ue_preretrieve;String	ls_Where

ls_Where =  'cd_filial_origem = '  + String (ist_par_nota.cd_filial) + ' AND ' + &
				'nr_nf            = '  + String (ist_par_nota.nr_nf)     + ' AND ' + &
				"de_especie       = '" + ist_par_nota.de_especie         + "' AND " + &
				"de_serie         = '" + ist_par_nota.de_serie           + "'"

If ist_par_nota.id_acao = 'I' then
	ls_Where += ' AND dh_termino_registro IS NOT NULL'
End if

This.of_AppendWhere (ls_Where)

Return 1
end event

event constructor;call super::constructor;This.of_SetRowSelection ()
end event

event doubleclicked;call super::doubleclicked;Long		ll_Row

String	ls_Marcacao

If dwo.Name = 'id_imagem' then
	If ib_Check then
		ls_Marcacao       = 'N'
		ib_Check          = False
		st_confirmar.Text = 'D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos.'
	Else
		ls_Marcacao       = 'S'
		ib_Check          = True
		st_confirmar.Text = 'D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos.'
	End if
	
	For ll_Row = 1 To This.RowCount ()
		
		This.Object.id_sel [ll_Row] = ls_Marcacao
		
	Next
	
End if
end event

event ue_retrieve;call super::ue_retrieve;String	ls_msg = 'Esta nota n$$HEX1$$e300$$ENDHEX$$o tem volumes '

If AncestorReturnValue = 0 then
	Choose case ist_par_nota.id_acao
		case 'C'
			ls_msg += 'ativos que possam ser cancelados'
		case 'I'
			ls_msg += 'encerrados para a impress$$HEX1$$e300$$ENDHEX$$o de etiquetas'
	End choose
	
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg)
	cb_cancelar.Post Event Clicked ()
End if

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;Return pl_linhas
end event

type st_confirmar from statictext within w_ge642_volumes_excesso
boolean visible = false
integer x = 1847
integer y = 272
integer width = 1061
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
alignment alignment = right!
boolean focusrectangle = false
end type

