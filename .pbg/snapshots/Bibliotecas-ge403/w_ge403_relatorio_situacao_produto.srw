HA$PBExportHeader$w_ge403_relatorio_situacao_produto.srw
forward
global type w_ge403_relatorio_situacao_produto from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge403_relatorio_situacao_produto from dc_w_selecao_lista_relatorio
integer width = 4526
integer height = 2288
string title = "GE403 - Relat$$HEX1$$f300$$ENDHEX$$rio de Altera$$HEX2$$e700e300$$ENDHEX$$o Situa$$HEX2$$e700e300$$ENDHEX$$o do Produto"
end type
global w_ge403_relatorio_situacao_produto w_ge403_relatorio_situacao_produto

type variables
uo_produto io_Produto
end variables

forward prototypes
public function boolean wf_localiza_dados (long al_produto, ref string as_nome_produto, string as_matricula, ref string as_responsavel)
public function boolean wf_recupera_informacoes ()
end prototypes

public function boolean wf_localiza_dados (long al_produto, ref string as_nome_produto, string as_matricula, ref string as_responsavel);Select de_produto + ' : ' + de_apresentacao_venda
	Into: as_Nome_produto
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro a consultar o nome do produto '" + String(al_Produto) + "'.", StopSign!)
	Return False
End If

Select nm_usuario
	Into: as_Responsavel
From usuario
Where nr_matricula = :as_Matricula
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o nome do usu$$HEX1$$e100$$ENDHEX$$rio.", StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_recupera_informacoes ();Long ll_Linha
Long ll_Produto

String ls_Descricao
String ls_Matricula
String ls_Responsavel
String ls_Para
String ls_De

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	ll_Produto	= dw_2.Object.Cd_Produto				[ll_Linha]
	ls_Matricula	= dw_2.Object.Nr_Matric_Alteracao	[ll_Linha]
	
	If Not wf_Localiza_Dados(ll_Produto, Ref ls_Descricao, ls_Matricula, Ref ls_Responsavel) Then Return False
	
	dw_2.Object.De_Produto			[ll_Linha] = ls_Descricao
	dw_2.Object.Nm_Responsavel	[ll_Linha] = ls_Responsavel
	
	ls_Para = dw_2.Object.De_Alteracao_Para[ll_Linha]
	
	Choose Case ls_Para
		Case "A"
			dw_2.Object.De_Alteracao_Para[ll_Linha] = "ATIVO"
		Case "P"
			dw_2.Object.De_Alteracao_Para[ll_Linha] = "PENDENTE"
		Case "I"
			dw_2.Object.De_Alteracao_Para[ll_Linha] = "INATIVO"
	End Choose
	
	ls_De = dw_2.Object.De_Alteracao_De[ll_Linha]
	
	Choose Case ls_De
		Case "A"
			dw_2.Object.De_Alteracao_De[ll_Linha] = "ATIVO"
		Case "P"
			dw_2.Object.De_Alteracao_De[ll_Linha] = "PENDENTE"
		Case "I"
			dw_2.Object.De_Alteracao_De[ll_Linha] = "INATIVO"
	End Choose
Next

Return True
end function

on w_ge403_relatorio_situacao_produto.create
call super::create
end on

on w_ge403_relatorio_situacao_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(io_Produto)
end event

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Termino	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Inicio		[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Termino[1]), -30))
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge403_relatorio_situacao_produto
integer x = 37
integer y = 804
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge403_relatorio_situacao_produto
integer x = 0
integer y = 732
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge403_relatorio_situacao_produto
integer y = 288
integer width = 4398
integer height = 1772
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge403_relatorio_situacao_produto
integer width = 2002
integer height = 272
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge403_relatorio_situacao_produto
integer width = 1934
integer height = 156
string dataobject = "dw_ge403_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
				This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge403_relatorio_situacao_produto
integer y = 364
integer width = 4329
integer height = 1660
string dataobject = "dw_ge403_lista"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	If Not wf_Recupera_Informacoes() Then Return -1
	
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

This.SetRedraw(True)

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OverRide

DateTime ldh_Inicio
DateTime ldh_Termino

dw_1.AcceptText()

This.SetRedraw(False)

ldh_inicio		= Datetime(dw_1.Object.dh_inicio		[1],Time('00:00:00'))
ldh_termino	= Datetime(dw_1.Object.dh_termino	[1],Time('23:59:59'))

Return This.Retrieve(ldh_inicio, ldh_termino)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date ldh_Inicio
Date ldh_Termino

Long ll_Produto

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio		[1]
ldh_Termino	= dw_1.Object.Dh_Termino	[1]
ll_Produto		= dw_1.Object.Cd_Produto	[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere("de_chave = '" + String(ll_Produto) + "'")
End If

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge403_relatorio_situacao_produto
integer x = 2231
integer y = 24
end type

