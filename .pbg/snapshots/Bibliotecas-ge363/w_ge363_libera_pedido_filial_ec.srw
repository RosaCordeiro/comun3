HA$PBExportHeader$w_ge363_libera_pedido_filial_ec.srw
forward
global type w_ge363_libera_pedido_filial_ec from dc_w_selecao_lista_relatorio
end type
type cb_incluir from picturebutton within w_ge363_libera_pedido_filial_ec
end type
type cb_alterar from picturebutton within w_ge363_libera_pedido_filial_ec
end type
type cb_excluir from picturebutton within w_ge363_libera_pedido_filial_ec
end type
type st_1 from statictext within w_ge363_libera_pedido_filial_ec
end type
end forward

global type w_ge363_libera_pedido_filial_ec from dc_w_selecao_lista_relatorio
integer width = 3762
integer height = 1556
string title = "GE363 - Libera Pedido de Filial para o Estoque Central"
cb_incluir cb_incluir
cb_alterar cb_alterar
cb_excluir cb_excluir
st_1 st_1
end type
global w_ge363_libera_pedido_filial_ec w_ge363_libera_pedido_filial_ec

type variables
uo_filial io_Filial //ge009
String is_Parametro
end variables

forward prototypes
public subroutine wf_insere_dia_padrao ()
end prototypes

public subroutine wf_insere_dia_padrao ();DataWindowChild ldwc_Child

ldwc_Child = dw_1.of_InsertRow_DDDW("nr_dia_semana")

ldwc_Child.SetItem(1, "nr_dia_semana", 0)
ldwc_Child.SetItem(1, "de_dia_semana", "TODOS")

dw_1.Object.Nr_Dia_Semana[1] = 0
end subroutine

on w_ge363_libera_pedido_filial_ec.create
int iCurrent
call super::create
this.cb_incluir=create cb_incluir
this.cb_alterar=create cb_alterar
this.cb_excluir=create cb_excluir
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_incluir
this.Control[iCurrent+2]=this.cb_alterar
this.Control[iCurrent+3]=this.cb_excluir
this.Control[iCurrent+4]=this.st_1
end on

on w_ge363_libera_pedido_filial_ec.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_incluir)
destroy(this.cb_alterar)
destroy(this.cb_excluir)
destroy(this.st_1)
end on

event ue_preopen;call super::ue_preopen;io_Filial = Create uo_filial
end event

event close;call super::close;Destroy(io_Filial)
end event

event ue_postopen;call super::ue_postopen;wf_Insere_Dia_Padrao()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge363_libera_pedido_filial_ec
integer x = 37
integer y = 844
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge363_libera_pedido_filial_ec
integer x = 0
integer y = 772
integer width = 2373
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge363_libera_pedido_filial_ec
integer y = 380
integer width = 3639
integer height = 968
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge363_libera_pedido_filial_ec
integer width = 1797
integer height = 348
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge363_libera_pedido_filial_ec
integer width = 1742
integer height = 236
string dataobject = "dw_ge363_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If Not io_Filial.Localizada Then
			io_Filial.of_Inicializa()
		End If
		
		This.Object.Cd_Filial		[1]	= io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1]	= io_Filial.Nm_Fantasia
		
		
		//Verifica se vai ser atulizado no SAP
			If Not gf_filial_administrada_sap(io_Filial.Cd_Filial   , Ref is_Parametro) Then
				Return 1
			End If
			
			If is_Parametro = "S" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(io_Filial.Cd_Filial  )+" deve ser utilizado o SAP.")				
				Return 1				
			End If 
		
		
		
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge363_libera_pedido_filial_ec
integer x = 73
integer y = 456
integer width = 3575
integer height = 864
string dataobject = "dw_ge363_lista"
end type

event dw_2::constructor;call super::constructor;ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Filial
Long ll_Dia_Semana

String ls_Mix_Completo

dw_1.AcceptText()

ll_Filial				= dw_1.Object.Cd_Filial				[1]
ll_Dia_Semana		= dw_1.Object.Nr_Dia_Semana	[1]
ls_Mix_Completo	= dw_1.Object.Id_Mix_Completo	[1]

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere("l.cd_filial = " + String(ll_Filial))
End If

If ll_Dia_Semana > 0 Then
	This.of_AppendWhere("l.nr_dia_semana = " + String(ll_Dia_Semana))
End If

If ls_Mix_Completo <> "T" Then
	This.of_AppendWhere("l.id_mix_completo = '" + ls_Mix_Completo + "'")
End If

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge363_libera_pedido_filial_ec
integer x = 832
integer y = 960
end type

type cb_incluir from picturebutton within w_ge363_libera_pedido_filial_ec
integer x = 1861
integer y = 252
integer width = 375
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_incluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Parametro

st_parametros_agend_ped str

str.Id_Tipo = "I"
str.Id_Tela = "GE363"

If is_Parametro = "N" Then 
	OpenWithParm(w_ge363_agenda_liberacao, str)
	
	ls_Parametro = Message.StringParm
	
	If Not IsNull(ls_Parametro) And ls_Parametro <> "" Then
		dw_2.Event ue_Retrieve()
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(io_Filial.Cd_Filial  )+" deve ser utilizado o SAP.")				
	Return 
End If 
end event

type cb_alterar from picturebutton within w_ge363_libera_pedido_filial_ec
integer x = 2258
integer y = 252
integer width = 347
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_alterar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Parametro

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi localizada para no incluir no agendamento do pedido.")
	Return -1
End If

dw_2.AcceptText()

st_parametros_agend_ped str

str.Cd_Filial									= dw_2.Object.Cd_Filial								[dw_2.GetRow()]
str.Nm_Fantasia							= dw_2.Object.Nm_Fantasia						[dw_2.GetRow()]
str.Nr_Dia_Semana						= dw_2.Object.Nr_Dia_Semana					[dw_2.GetRow()]
str.Qt_Dias_Reforco						= dw_2.Object.Qt_Dias_Reforco					[dw_2.GetRow()]
str.Id_Mix_Completo						= dw_2.Object.Id_Mix_Completo					[dw_2.GetRow()]
str.id_pedido_controlado_exclusivo	= dw_2.Object.id_pedido_controlado_exclusivo	[dw_2.GetRow()]

str.Id_Tipo 				= "A"
str.Id_Tela				= "GE363"


If is_Parametro = "N" Then 
	OpenWithParm(w_ge363_agenda_liberacao, str)

	ls_Parametro = Message.StringParm
	
	If Not IsNull(ls_Parametro) And ls_Parametro <> "" Then
		dw_2.Event ue_Retrieve()
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(io_Filial.Cd_Filial  )+" deve ser utilizado o SAP.")				
	Return 
End If 




end event

type cb_excluir from picturebutton within w_ge363_libera_pedido_filial_ec
integer x = 2629
integer y = 252
integer width = 375
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_excluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Parametro

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi localizada para excluir o agendamento do pedido.")
	Return -1
End If

dw_2.AcceptText()

st_parametros_agend_ped str

str.Cd_Filial									= dw_2.Object.Cd_Filial								[dw_2.GetRow()]
str.Nm_Fantasia							= dw_2.Object.Nm_Fantasia						[dw_2.GetRow()]
str.Nr_Dia_Semana						= dw_2.Object.Nr_Dia_Semana					[dw_2.GetRow()]
str.Qt_Dias_Reforco						= dw_2.Object.Qt_Dias_Reforco					[dw_2.GetRow()]
str.Id_Mix_Completo						= dw_2.Object.Id_Mix_Completo					[dw_2.GetRow()]
str.id_pedido_controlado_exclusivo	= dw_2.Object.id_pedido_controlado_exclusivo	[dw_2.GetRow()]

str.Id_Tipo 				= "E"
str.Id_Tela				= "GE363"


If is_Parametro = "N" Then 
	OpenWithParm(w_ge363_agenda_liberacao, str)

	ls_Parametro = Message.StringParm
	
	If Not IsNull(ls_Parametro) And ls_Parametro <> "" Then
		dw_2.Event ue_Retrieve()
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(io_Filial.Cd_Filial  )+" deve ser utilizado o SAP.")				
	Return 
End If 




end event

type st_1 from statictext within w_ge363_libera_pedido_filial_ec
integer x = 1851
integer y = 112
integer width = 1184
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "ROTINA SOMENTE P/ FILIAIS DA BAHIA"
boolean focusrectangle = false
end type

