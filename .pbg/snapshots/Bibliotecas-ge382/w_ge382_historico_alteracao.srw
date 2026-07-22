HA$PBExportHeader$w_ge382_historico_alteracao.srw
forward
global type w_ge382_historico_alteracao from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge382_historico_alteracao
end type
type dw_3 from dc_uo_dw_base within w_ge382_historico_alteracao
end type
type gb_2 from groupbox within w_ge382_historico_alteracao
end type
type gb_3 from groupbox within w_ge382_historico_alteracao
end type
end forward

global type w_ge382_historico_alteracao from dc_w_response_ok_cancela
integer width = 3762
integer height = 2332
string title = "GE382 - Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o"
dw_2 dw_2
dw_3 dw_3
gb_2 gb_2
gb_3 gb_3
end type
global w_ge382_historico_alteracao w_ge382_historico_alteracao

type variables
uo_usuario io_Usuario

st_ge382_parametros str

Date idt_Parametro
end variables

forward prototypes
public subroutine wf_insere_campo_padrao ()
public function boolean wf_descricao_codigo ()
public subroutine wf_set_somente_consulta ()
end prototypes

public subroutine wf_insere_campo_padrao ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("nm_coluna", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "nm_coluna", "T")
	lvdwc.SetItem(1, "de_coluna", "TODAS")
	
	dw_1.Object.Nm_Coluna[1] = "T"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do campo.")
End If
end subroutine

public function boolean wf_descricao_codigo ();Long ll_Linha
Long ll_Tamanho

String ls_Valor_De
String ls_Valor_Para
String ls_Descricao

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	ls_Valor_De = dw_2.Object.De_Alteracao_De[ll_Linha]
			
	ll_Tamanho = PosA(ls_Valor_De, "@#!", 1)
	
	If ll_Tamanho > 0 Then
	
		ls_Descricao = MidA(ls_Valor_De, ll_Tamanho + 3)
		
		If ls_Descricao <> "" Then
			ls_Descricao = gf_Troca_Caracteres_Especiais(ls_Descricao)
			dw_2.Object.De_Alteracao_De[ll_Linha] = ls_Descricao
		End If
	End If
		
	ls_Descricao = ""
	
	ls_Valor_Para = dw_2.Object.De_Alteracao_Para[ll_Linha]
		
	ll_Tamanho = PosA(ls_Valor_Para, "@#!", 1)
	
	If ll_Tamanho > 0 Then
	
		ls_Descricao = MidA(ls_Valor_Para, ll_Tamanho + 3)
		
		If ls_Descricao <> "" Then
			dw_2.Object.De_Alteracao_Para[ll_Linha] = ls_Descricao
		End If
	End If
Next

If dw_2.RowCount() > 0 Then
	dw_2.Event RowFocusChanged(1)
End If

Return True
end function

public subroutine wf_set_somente_consulta ();dw_3.of_set_somente_leitura(False)
end subroutine

on w_ge382_historico_alteracao.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_3
end on

on w_ge382_historico_alteracao.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_preopen;call super::ue_preopen;io_Usuario = Create uo_usuario
end event

event close;call super::close;Destroy(io_Usuario)
end event

event ue_postopen;call super::ue_postopen;str = Message.PowerObjectParm

wf_Insere_Campo_Padrao()

idt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

dw_1.Object.dt_inicio		[1] = DateTime(RelativeDate(idt_Parametro, -90))
dw_1.Object.dt_termino	[1] = idt_Parametro

dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge382_historico_alteracao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge382_historico_alteracao
integer x = 9
integer width = 3419
integer height = 264
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge382_historico_alteracao
integer x = 64
integer width = 3333
integer height = 172
string dataobject = "dw_ge382_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_usuario" Then
		io_Usuario.of_Localiza_Usuario(This.GetText())
		
		If Not io_Usuario.Localizado Then
			io_Usuario.of_Inicializa()
		End If
		
		This.Object.Nr_Matricula	[1]	= io_Usuario.Nr_Matricula
		This.Object.Nm_Usuario	[1]	= io_Usuario.Nm_Usuario
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Usuario.Nm_Usuario Then
			Return 1
		End If
	Else
		io_Usuario.of_Inicializa()
		
		This.Object.Nr_Matricula	[1] = io_Usuario.Nr_Matricula
		This.Object.Nm_Usuario	[1] = io_Usuario.Nm_Usuario
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Usuario.Nm_Usuario Then
			Return 1
		End If
	Else
		io_Usuario.of_Inicializa()
		
		This.Object.Nr_Matricula	[1] = io_Usuario.Nr_Matricula
		This.Object.Nm_Usuario	[1] = io_Usuario.Nm_Usuario
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge382_historico_alteracao
integer x = 3031
integer y = 2124
integer width = 343
string text = "&Consultar"
end type

event cb_ok::clicked;call super::clicked;dw_2.Event ue_Retrieve()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge382_historico_alteracao
integer x = 3406
integer y = 2124
end type

type dw_2 from dc_uo_dw_base within w_ge382_historico_alteracao
integer x = 55
integer y = 352
integer width = 3634
integer height = 1032
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge382_lista"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

DateTime ldt_inicio
DateTime ldt_termino

dw_1.AcceptText()

ldt_inicio		= Datetime(dw_1.Object.dt_inicio	[1],Time('00:00:00'))
ldt_termino	= Datetime(dw_1.Object.dt_termino	[1],Time('23:59:59'))

Return This.Retrieve(ldt_inicio, ldt_termino)
end event

event ue_preretrieve;call super::ue_preretrieve;Date ldt_Prazo_Limite

Date ldt_inicio
Date ldt_termino

Long ll_Qt_Dias

String ls_Campo
String ls_Tipo
String ls_Matricula

dw_1.AcceptText()

ldt_inicio			= dw_1.Object.dt_inicio		[1]
ldt_termino		= dw_1.Object.dt_termino	[1]
ls_Campo		= dw_1.Object.Nm_Coluna	[1]
ls_Tipo			= dw_1.Object.Id_Alteracao	[1]
ls_Matricula		= dw_1.Object.Nr_Matricula	[1]

If IsNull(ldt_inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ldt_termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If ldt_inicio > idt_Parametro Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data corrente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If ldt_inicio > ldt_termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

ll_Qt_Dias = DaysAfter(Date(ldt_inicio), idt_Parametro)

If ll_Qt_Dias > 90 Then
	ldt_Prazo_Limite = RelativeDate(idt_Parametro, -90)
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo m$$HEX1$$e100$$ENDHEX$$ximo para consulta s$$HEX1$$e300$$ENDHEX$$o 90 dias." + &
						"~rA consulta deve ser a partir de '" + String(ldt_Prazo_Limite) + "'.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

dw_2.of_AppendWhere("h.nm_tabela = '" + Upper(str.Tabela[1]) + "'")
dw_2.of_AppendWhere("h.de_chave = '" + Upper(str.Chave) + "'")

If ls_Campo <> "T" Then
	dw_2.of_AppendWhere("h.nm_coluna = '" + ls_Campo + "'")
End If

If ls_Tipo <> "T" Then
	dw_2.of_AppendWhere("h.id_alteracao = '" + ls_Tipo + "'")
End If

If Not IsNull(ls_Matricula) And ls_Matricula <> "" Then
	dw_2.of_AppendWhere("h.nr_matric_alteracao = '" + ls_Matricula + "'")
End If

Return 1
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;If (Not IsNull(CurrentRow)) and (CurrentRow > 0) and (CurrentRow <= This.RowCount()) Then
	dw_3.Object.de_de	[1] = This.Object.de_alteracao_de	[CurrentRow]
	dw_3.Object.de_para	[1] = This.Object.de_alteracao_para	[CurrentRow]
Else
	dw_3.Object.de_de	[1] = ''
	dw_3.Object.de_para	[1] = ''
End If
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	If Not wf_Descricao_Codigo() Then Return -1
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
End If

Return pl_Linhas
end event

type dw_3 from dc_uo_dw_base within w_ge382_historico_alteracao
integer x = 46
integer y = 1472
integer width = 3634
integer height = 608
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge382_alteracao"
boolean livescroll = false
end type

type gb_2 from groupbox within w_ge382_historico_alteracao
integer x = 14
integer y = 288
integer width = 3703
integer height = 1124
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge382_historico_alteracao
integer x = 18
integer y = 1424
integer width = 3703
integer height = 680
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhe"
borderstyle borderstyle = styleraised!
end type

