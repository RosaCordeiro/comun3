HA$PBExportHeader$w_ge077_selecao_cliente.srw
forward
global type w_ge077_selecao_cliente from dc_w_selecao_generica
end type
end forward

global type w_ge077_selecao_cliente from dc_w_selecao_generica
int X=379
int Y=436
int Width=3598
int Height=1664
boolean TitleBar=true
string Title="GE077 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Clientes"
long BackColor=80269524
end type
global w_ge077_selecao_cliente w_ge077_selecao_cliente

type variables
uo_cliente_central ivo_cliente
end variables

on w_ge077_selecao_cliente.create
call super::create
end on

on w_ge077_selecao_cliente.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

ivo_Cliente = Message.PowerObjectParm

lvs_Parametro = ivo_Cliente.ivs_Parametro

If lvs_Parametro <> "" Then
	dw_1.Object.Nm_Cliente[1] = lvs_Parametro
	
	This.ivb_Pesquisa_Direta = True
End If
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge077_selecao_cliente
int X=18
int Y=276
int Width=3529
int Height=1144
string Text="Lista de Clientes"
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge077_selecao_cliente
int X=18
int Y=4
int Width=1527
int Height=260
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge077_selecao_cliente
int X=41
int Y=68
int Width=1490
int Height=184
boolean BringToTop=true
string DataObject="dw_ge077_selecao_cliente"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge077_selecao_cliente
int X=41
int Y=328
int Width=3483
int Height=1072
boolean BringToTop=true
string DataObject="dw_ge077_lista_cliente"
boolean HScrollBar=true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Nome, &
       lvs_RG, &
		 lvs_CPF
		 
dw_1.AcceptText()

lvs_Nome = dw_1.Object.Nm_Cliente[1]
lvs_RG   = dw_1.Object.Nr_RG     [1]
lvs_CPF  = dw_1.Object.Nr_CPF    [1]

If Not IsNull(lvs_Nome) and Trim(lvs_Nome) <> "" Then
	If LenA(Trim(lvs_Nome)) < 3 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos tr$$HEX1$$ea00$$ENDHEX$$s letras para localiza$$HEX2$$e700e300$$ENDHEX$$o pelo nome do cliente.")
		dw_1.SetFocus()
		Return -1		
	End If
	
	This.of_AppendWhere("nm_cliente like '" + lvs_Nome + "%'")
End If

If Not IsNull(lvs_RG) and Trim(lvs_RG) <> "" Then
	This.of_AppendWhere("nr_rg like '" + lvs_RG + "%'")
End If

If Not IsNull(lvs_CPF) and Trim(lvs_CPF) <> "" Then
	This.of_AppendWhere("nr_cpf_cgc like '" + lvs_CPF + "%'")
End If

// Verifica se nenhum par$$HEX1$$e200$$ENDHEX$$metro foi preenchido
If (IsNull(lvs_Nome) or Trim(lvs_Nome) = "") and &
   (IsNull(lvs_RG) or Trim(lvs_RG) = "") and &
	(IsNull(lvs_CPF) or Trim(lvs_CPF) = "") Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos um par$$HEX1$$e200$$ENDHEX$$metro para sele$$HEX2$$e700e300$$ENDHEX$$o do cliente.")
	dw_1.SetFocus()
	Return -1
End If

// Verifica a necessidade de filtrar o tipo do cliente
If ivo_Cliente.ivs_Tipo_Cliente <> "" Then
	If ivo_Cliente.ivs_Tipo_Cliente = "CL" Then
		This.of_AppendWhere("id_tipo_cliente in ('RC', 'CC')")
	Else
		This.of_AppendWhere("id_tipo_cliente = '" + ivo_Cliente.ivs_Tipo_Cliente + "'")		
	End If
End If

// Verifica a necessidade de filtrar a pessoa do cliente
//If ivo_Cliente.ivs_Fisica_Juridica <> "" Then
//	This.of_AppendWhere("id_fisica_juridica = '" + ivo_Cliente.ivs_Fisica_Juridica + "'")
//End If

Return 1
end event

event dw_2::ue_recuperar;// Override

Long lvl_Linhas

String lvs_Sintaxe
String lvs_Erro

This.SetRedraw(False)

//If ivo_Cliente.ivo_Conexao.of_Retrieve(ref dw_2, "CONSULTA DE CLIENTES DO CLUBE") Then 
//	lvl_Linhas = This.RowCount()
//End If

Datastore lds_Dados
lds_Dados = Create Datastore

// Determina a sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow
lvs_Sintaxe = SqlCa.SyntaxFromSQL(This.GetSQLSelect(), "Style(Type=Grid)", lvs_Erro)

If Trim(lvs_Erro) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datastore para retrieve.~n~n" + lvs_Erro)
	lvl_Linhas = -1	
Else
		
	lds_Dados.Create(lvs_Sintaxe, lvs_Erro)
	
	If Trim(lvs_Erro) <> "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datastore para retrieve.~n~n" + lvs_Erro)
		lvl_Linhas = -1
	Else
	
		uo_Transacao_Remota lvo_Conexao
		lvo_Conexao = Create uo_Transacao_Remota
		
		lvo_Conexao.of_BancoProducao()
		lvo_Conexao.of_Relatorio(True)
		lvo_Conexao.of_Retrieve(Ref lds_Dados)
		
		Destroy(lvo_Conexao)
		
		lvl_Linhas = lds_Dados.RowCount()
		
		If lvl_Linhas > 0 Then
			If lds_Dados.RowsCopy(1,lds_Dados.RowCount(),Primary!,This,1,Primary!) = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao carregar dados da consulta.",StopSign!)
				lvl_Linhas = 0
			Else
				lvl_Linhas = This.RowCount()
			End If	
			
		End If
		
	End If	
	
End If	


This.VScrollBar = True

This.SetRedraw(True)

Return lvl_Linhas
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge077_selecao_cliente
int X=2779
int Y=1444
boolean BringToTop=true
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_Cliente

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Cliente = dw_2.Object.Cd_Cliente[lvl_Linha]
	
	CloseWithReturn(Parent, lvs_Cliente)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cliente na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge077_selecao_cliente
int X=3177
int Y=1444
boolean BringToTop=true
end type

event cb_cancelar::clicked;String lvs_Cliente

SetNull(lvs_Cliente)

CloseWithReturn(Parent, lvs_Cliente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge077_selecao_cliente
int X=2309
int Y=1444
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge077_selecao_cliente
int X=27
int Y=1456
int Width=1467
boolean BringToTop=true
long BackColor=80269524
end type

