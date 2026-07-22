HA$PBExportHeader$w_ge390_historico_alteracao_produto.srw
forward
global type w_ge390_historico_alteracao_produto from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge390_historico_alteracao_produto
end type
type gb_2 from groupbox within w_ge390_historico_alteracao_produto
end type
end forward

global type w_ge390_historico_alteracao_produto from dc_w_response_ok_cancela
integer width = 3813
integer height = 2008
string title = "GE390 - Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge390_historico_alteracao_produto w_ge390_historico_alteracao_produto

type variables
uo_produto	io_Produto //ge001
uo_usuario	io_Usuario //ge010
end variables

forward prototypes
public function boolean wf_carrega_dados ()
end prototypes

public function boolean wf_carrega_dados ();Long ll_Linha
Long ll_Produto

String ls_Matricula
String ls_Descricao
String ls_Usuario

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	ll_Produto = dw_2.Object.De_Chave[ll_Linha]
	
	Select de_produto + ' : ' + de_apresentacao_venda
		Into: ls_Descricao
	From produto_geral
	Where cd_produto = :ll_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			dw_2.Object.De_Produto[ll_Linha] = ls_Descricao
			
		Case 100
			
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o nome do produto. " + SqlCa.SqlErrText, StopSign!)
			Return False
	End Choose
	
	ls_Matricula = dw_2.Object.Nr_Matric_Alteracao[ll_Linha]
	
	Select nm_usuario
		Into :ls_Usuario
	From usuario
	Where nr_matricula = :ls_Matricula
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			dw_2.Object.Nm_Responsavel[ll_Linha] = ls_Usuario
			
		Case 100
			
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o nome do respons$$HEX1$$e100$$ENDHEX$$vel. " + SqlCa.SqlErrText, StopSign!)
			Return False
	End Choose
Next

Return True
end function

on w_ge390_historico_alteracao_produto.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge390_historico_alteracao_produto.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
io_Usuario = Create uo_usuario
end event

event close;call super::close;Destroy(io_Produto)
Destroy(io_Usuario)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Inicio		[1] = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -10)
dw_1.Object.Dt_Termino	[1] = Date(gvo_Parametro.of_Dh_Movimentacao())
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge390_historico_alteracao_produto
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge390_historico_alteracao_produto
integer width = 3730
integer height = 260
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge390_historico_alteracao_produto
integer width = 3666
integer height = 172
string dataobject = "dw_ge390_selecao_historico"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

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

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

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

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If Not io_Produto.Localizado Then
			io_Produto.of_Inicializa()
		End If
		
		This.Object.Cd_Produto	[1]	= io_Produto.Cd_Produto
		This.Object.De_Produto	[1]	= io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

If Key = KeyEnter! Then
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

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge390_historico_alteracao_produto
integer x = 3086
integer y = 1792
integer width = 343
string text = "&Consultar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;dw_2.Event ue_Retrieve()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge390_historico_alteracao_produto
integer x = 3442
integer y = 1792
end type

type dw_2 from dc_uo_dw_base within w_ge390_historico_alteracao_produto
integer x = 46
integer y = 340
integer width = 3666
integer height = 1384
integer taborder = 20
string dataobject = "dw_ge390_lista_historico"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

event ue_preretrieve;call super::ue_preretrieve;Date ldt_Inicio
Date ldt_Termino

Long ll_Produto

String ls_Tipo
String ls_Matricula

dw_1.AcceptText()

ldt_Inicio		= dw_1.Object.Dt_Inicio			[1]
ldt_Termino	= dw_1.Object.Dt_Termino		[1]
ll_Produto	= dw_1.Object.Cd_Produto		[1]
ls_Tipo		= dw_1.Object.Id_Alteracao		[1]
ls_Matricula	= dw_1.Object.Nr_Matricula		[1]

If IsNull(ldt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio para prosseguir.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ldt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino para prosseguir.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If ll_Produto > 0 Then
	This.of_AppendWhere("h.de_chave = '" + String(ll_Produto) + "'")
End If

If ls_Tipo <> "T" Then
	This.of_AppendWhere("h.id_alteracao = '" + ls_Tipo + "'")
End If

If Not IsNull(ls_Matricula) And ls_Matricula <> "" Then
	This.of_AppendWhere("h.nr_matric_alteracao = '" + ls_Matricula + "'")
End If

This.SetRedraw(False)

Return 1
end event

event ue_recuperar;//OverRide

DateTime ldt_inicio
DateTime ldt_termino

dw_1.AcceptText()

ldt_inicio		= Datetime(dw_1.Object.dt_inicio		[1],Time('00:00:00'))
ldt_termino	= Datetime(dw_1.Object.dt_termino	[1],Time('23:59:59'))

Return This.Retrieve(ldt_inicio, ldt_termino)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	If Not wf_Carrega_Dados() Then Return -1
	This.Sort()
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
	Return -1
End If

This.SetRedraw(True)

Return pl_Linhas
end event

type gb_2 from groupbox within w_ge390_historico_alteracao_produto
integer x = 23
integer y = 284
integer width = 3730
integer height = 1480
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
end type

