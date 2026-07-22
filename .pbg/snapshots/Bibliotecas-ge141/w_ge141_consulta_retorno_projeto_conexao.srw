HA$PBExportHeader$w_ge141_consulta_retorno_projeto_conexao.srw
forward
global type w_ge141_consulta_retorno_projeto_conexao from dc_w_selecao_lista_relatorio
end type
type cb_cancela from commandbutton within w_ge141_consulta_retorno_projeto_conexao
end type
type st_1 from statictext within w_ge141_consulta_retorno_projeto_conexao
end type
end forward

global type w_ge141_consulta_retorno_projeto_conexao from dc_w_selecao_lista_relatorio
integer width = 5015
integer height = 2388
string title = "GE141 - Retorno de Pedido via Projeto Conex$$HEX1$$e300$$ENDHEX$$o"
cb_cancela cb_cancela
st_1 st_1
end type
global w_ge141_consulta_retorno_projeto_conexao w_ge141_consulta_retorno_projeto_conexao

type variables
uo_filial io_Filial

Boolean ivb_Check
end variables

forward prototypes
public subroutine wf_insere_fornecedor_default ()
public subroutine wf_set_somente_consulta ()
end prototypes

public subroutine wf_insere_fornecedor_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
	lvi_Row

If dw_1.GetChild("cd_projeto", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	lvdwc.SetItem(1, "cd_fornecedor_envio", "000000000")
	lvdwc.SetItem(1, "de_projeto_conexao",   "TODOS")
		 
	dw_1.Object.cd_projeto[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild fornecedor.")
End If

If dw_1.GetChild("cd_laboratorio", lvdwc) = 1 Then
	lvi_Row = lvdwc.InsertRow(1)
	
	lvdwc.SetItem(lvi_Row, "de_prefixo_pedido_entire", "XXX")
	lvdwc.SetItem(lvi_Row, "nm_fantasia"  , "TODAS")
	
	dw_1.Object.Cd_Laboratorio[1] = "XXX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild.", StopSign!)
End If
end subroutine

public subroutine wf_set_somente_consulta ();dw_2.of_Set_Somente_Leitura(False)

dw_2.Object.Id_Selecionar.Protect = 0
end subroutine

on w_ge141_consulta_retorno_projeto_conexao.create
int iCurrent
call super::create
this.cb_cancela=create cb_cancela
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancela
this.Control[iCurrent+2]=this.st_1
end on

on w_ge141_consulta_retorno_projeto_conexao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_cancela)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;io_Filial = Create uo_Filial

Date lvdt_Parametro

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

dw_1.Object.dt_inicio 	[1] = lvdt_Parametro
dw_1.Object.dt_termino	[1] = lvdt_Parametro

wf_insere_fornecedor_default()

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CO' Then
	cb_Cancela.Enabled = False
End If
end event

event close;call super::close;Destroy(io_Filial)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge141_consulta_retorno_projeto_conexao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge141_consulta_retorno_projeto_conexao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge141_consulta_retorno_projeto_conexao
integer y = 508
integer width = 4832
integer height = 1672
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge141_consulta_retorno_projeto_conexao
integer width = 1778
integer height = 484
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge141_consulta_retorno_projeto_conexao
integer x = 46
integer width = 1737
integer height = 400
string dataobject = "dw_ge141_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = 'nm_fantasia' Then
	If Not IsNull(Data) and Trim(Data) <> '' Then
		If Data <> io_filial.nm_fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		//  DW <--  objeto.propriedade
		This.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
		This.Object.cd_filial	[1] = io_Filial.cd_filial
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If key = KeyEnter! Then
	If This.GetColumnName() = 'nm_fantasia' Then

		io_Filial.of_localiza_filial(This.GetText())
		
		If io_Filial.Localizada Then
			This.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
			This.Object.cd_filial	[1]	= io_Filial.cd_filial
		End If
		
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = 'nm_fantasia' Then
	If Not IsNull(Data) and Trim(Data) <> '' Then
		If Data <> io_filial.nm_fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		//  DW <--  objeto.propriedade
		This.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
		This.Object.cd_filial	[1] = io_Filial.cd_filial
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge141_consulta_retorno_projeto_conexao
integer x = 64
integer y = 584
integer width = 4891
integer height = 1572
string dataobject = "dw_ge141_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_recuperar;// OverRide

Datetime ldt_Inicio, &
        ldt_Termino

Long ll_Filial
String ls_id_situacao
String ls_id_sem_retorno
String ls_cd_fornecedor_envio
String ls_de_prefixo_pedido

dw_1.AcceptText()

ldt_Inicio						= dw_1.Object.dt_inicio			[1]
ldt_Termino					= dw_1.Object.dt_termino		[1]
ll_Filial						= dw_1.Object.cd_filial			[1]
ls_id_sem_retorno			= dw_1.Object.id_sem_retorno	[1]
ls_cd_fornecedor_envio	= dw_1.Object.cd_projeto		[1]
ls_de_prefixo_pedido		= dw_1.Object.cd_laboratorio	[1]

If IsNull(ldt_Inicio) or Not IsDate(String(ldt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ldt_Termino) or Not IsDate(String(ldt_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1	
End If

If Not IsNull(ll_Filial) and ll_Filial > 0 Then
	This.of_AppendWhere("f.cd_filial = " + String(ll_Filial), 1)
End If

// Projeto
If  ls_cd_fornecedor_envio <> "000000000" Then
	This.of_AppendWhere("p.cd_fornecedor = '" + ls_cd_fornecedor_envio + "'")
End If

// Laboratorio
If  ls_de_prefixo_pedido <> "XXX" Then
	This.of_AppendWhere("p.de_prefixo_pedido = '" + ls_de_prefixo_pedido + "'")
End If

// 'Sem Retorno' Setado
If  ls_id_sem_retorno = "S" Then
	This.of_AppendWhere("(p.dh_retorno is null or p.dh_retorno = '')")
End If

Return This.Retrieve(ldt_Inicio, ldt_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas >0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()				
		This.Object.Id_Selecionar[lvl_Row] = lvs_Marcacao		
	Next
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge141_consulta_retorno_projeto_conexao
boolean visible = false
integer x = 887
integer y = 1420
integer taborder = 50
end type

type cb_cancela from commandbutton within w_ge141_consulta_retorno_projeto_conexao
integer x = 1851
integer y = 380
integer width = 526
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar Pedido"
end type

event clicked;Long ll_Filial
Long ll_Pedido
Long ll_Linha
Long ll_Find

String ls_Van
String ls_Laboratorio
String ls_Prefixo
String ls_Sem_Retorno
String ls_Responsavel
String ls_Selecionado

dw_1.AcceptText()

ll_Find = dw_2.Find("id_selecionar = 'S'", 1, dw_2.RowCount())

If dw_2.RowCount() = 0 Or ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido foi selecionado.", Exclamation!)
	dw_2.SetFocus()
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o cancelamento do(s) pedido(s) selecionado(s)?", Question!, YesNo!, 2) = 2 Then Return -1

ls_Van				= dw_1.Object.Cd_Projeto			[1]
ls_Laboratorio		= dw_1.Object.Cd_Laboratorio		[1]
ls_Sem_Retorno	= dw_1.Object.Id_Sem_Retorno	[1]

If ls_Sem_Retorno = "N" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a op$$HEX2$$e700e300$$ENDHEX$$o 'Sem Retorno' para prosseguir.", Exclamation!)
	dw_1.SetFocus()
	Return -1
End If

If ls_Van = "000000000" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a Van para prosseguir.", Exclamation!)
	dw_1.Event ue_Pos(1, "cd_projeto")
	Return -1
End If

If ls_Laboratorio = "XXX" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o Laborat$$HEX1$$f300$$ENDHEX$$rio para prosseguir.", Exclamation!)
	dw_1.Event ue_Pos(1, "cd_laboratorio")
	Return -1
End If

For ll_Linha = 1 To dw_2.RowCount()
	
	ls_Selecionado = dw_2.Object.Id_Selecionar	[ll_Linha]
	
	If ls_Selecionado = "N" Then Continue

	ll_Filial		= dw_2.Object.Cd_Filial				[ll_Linha]
	ll_Pedido		= dw_2.Object.Nr_Pedido_Filial	[ll_Linha]
	ls_Prefixo	= dw_2.Object.De_Prefixo_Pedido	[ll_Linha]

	Update pedido_conexao_controle
		Set	dh_retorno = getdate(),
				de_rejeicao = 'ARQUIVO DE RET. NAO RECEBIDO'
		Where cd_filial = :ll_Filial
			And nr_pedido_filial = :ll_Pedido
			And cd_fornecedor = :ls_Van
			And de_prefixo_pedido = :ls_Prefixo
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack();
		SqlCa.of_MsgdbError("Erro ao cancelar o pedido conex$$HEX1$$e300$$ENDHEX$$o. " + SqlCa.SqlErrText)
		Return -1
	End If
	
Next

SqlCa.of_Commit();
dw_2.Retrieve(dw_1.Object.Dt_Inicio[1], dw_1.Object.Dt_Termino[1])
end event

type st_1 from statictext within w_ge141_consulta_retorno_projeto_conexao
integer x = 2418
integer y = 368
integer width = 1499
integer height = 124
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Somente a T.I. poder$$HEX1$$e100$$ENDHEX$$ cancelar os pedidos de Conex$$HEX1$$e300$$ENDHEX$$o que est$$HEX1$$e300$$ENDHEX$$o pendentes de retorno."
boolean focusrectangle = false
end type

