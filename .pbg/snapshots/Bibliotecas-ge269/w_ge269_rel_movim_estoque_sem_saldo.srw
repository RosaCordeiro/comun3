HA$PBExportHeader$w_ge269_rel_movim_estoque_sem_saldo.srw
forward
global type w_ge269_rel_movim_estoque_sem_saldo from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge269_rel_movim_estoque_sem_saldo from dc_w_selecao_lista_relatorio
string tag = "w_ge269_rel_movim_estoque_sem_saldo"
integer x = 1
integer width = 3616
integer height = 1888
string title = "GE269 - Movimenta$$HEX2$$e700e300$$ENDHEX$$o de Estoque sem Saldo"
long backcolor = 80269524
end type
global w_ge269_rel_movim_estoque_sem_saldo w_ge269_rel_movim_estoque_sem_saldo

type variables
uo_produto ivo_produto

uo_filial ivo_filial
end variables

forward prototypes
public function boolean wf_cliente (string as_codigo, ref string as_nome)
public function boolean wf_fornecedor (string as_codigo, ref string as_nome)
public function boolean wf_filial (long al_codigo, ref string as_nome)
public function boolean wf_convenio (long al_codigo, ref string as_nome)
end prototypes

public function boolean wf_cliente (string as_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_cliente Into :as_Nome
From cliente
Where cd_cliente = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cliente '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome do Cliente")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_fornecedor (string as_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_razao_social Into :as_Nome
From fornecedor
Where cd_fornecedor = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome do Fornecedor")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_filial (long al_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_fantasia Into :as_Nome
From filial
Where cd_filial = :al_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(al_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome da Filial")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_convenio (long al_codigo, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_fantasia Into :as_Nome
From convenio
Where cd_convenio = :al_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conv$$HEX1$$ea00$$ENDHEX$$nio '" + String(al_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Nome do Conv$$HEX1$$ea00$$ENDHEX$$nio")
End Choose

Return lvb_Sucesso
end function

on w_ge269_rel_movim_estoque_sem_saldo.create
call super::create
end on

on w_ge269_rel_movim_estoque_sem_saldo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto
ivo_Filial  = Create uo_Filial

ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Object.Dt_Inicio [1] = Today()
dw_1.Object.Dt_Termino[1] = Today()

dw_1.SetFocus()

end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
end event

event ue_preopen;call super::ue_preopen;MaxHeight = 1715
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge269_rel_movim_estoque_sem_saldo
integer x = 18
integer y = 332
integer width = 3543
integer height = 1352
integer weight = 700
string text = "Movimentos de Estoque"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge269_rel_movim_estoque_sem_saldo
integer x = 18
integer y = 0
integer width = 1783
integer height = 324
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge269_rel_movim_estoque_sem_saldo
integer x = 41
integer y = 56
integer width = 1733
integer height = 256
string dataobject = "dw_ge269_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
		
	Case "nm_filial"
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
End Choose
end event

event dw_1::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If
			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge269_rel_movim_estoque_sem_saldo
integer x = 50
integer y = 384
integer width = 3493
integer height = 1280
string dataobject = "dw_ge269_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// Override

Long lvl_Filial, &
     lvl_Produto, &
	  lvl_Saldo_Inicial

Date lvdt_Inicio, &
     lvdt_Termino
	  
dw_1.AcceptText()

lvl_Filial			= dw_1.Object.Cd_Filial 		[1]
lvl_Produto		= dw_1.Object.Cd_Produto	[1]
lvdt_Inicio		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

If IsNull(lvl_Filial) or lvl_Filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.", Information!)
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

If IsNull(lvl_Produto) or lvl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.", Information!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

Return This.Retrieve(lvl_Filial, lvl_Produto, lvdt_Inicio, lvdt_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Contador, &
     lvl_Filial, &
	  lvl_Convenio
	  
String lvs_Cliente, &
       lvs_Fornecedor, &
		 lvs_Origem_Destino

If pl_Linhas > 0 Then
	This.SetRedraw(False)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Origem e Destino dos Movimentos..."
	
	w_Aguarde.uo_Progress.of_SetMax(pl_Linhas)
	
	For lvl_Contador = 1 To pl_Linhas
		lvl_Filial			= This.Object.Cd_Filial			[lvl_Contador]
		lvl_Convenio		= This.Object.Cd_Convenio		[lvl_Contador]
		lvs_Fornecedor	= This.Object.Cd_Fornecedor	[lvl_Contador]
		lvs_Cliente		= This.Object.Cd_Cliente			[lvl_Contador]

		lvs_Origem_Destino = ""
		
		If Not IsNull(lvs_Cliente) Then
			wf_Cliente(lvs_Cliente, ref lvs_Origem_Destino)
		Else
			If Not IsNull(lvs_Fornecedor) Then
				wf_Fornecedor(lvs_Fornecedor, ref lvs_Origem_Destino)
			Else
				If Not IsNull(lvl_Filial) Then
					wf_Filial(lvl_Filial, ref lvs_Origem_Destino)
				Else
					If Not IsNull(lvl_Convenio) Then
						wf_Convenio(lvl_Convenio, ref lvs_Origem_Destino)
					End If
				End If
			End If
		End If
		
		If Trim(lvs_Origem_Destino) <> "" Then
			This.Object.De_Origem_Destino[lvl_Contador] = lvs_Origem_Destino
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	Close(w_Aguarde)
	This.SetRedraw(True)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge269_rel_movim_estoque_sem_saldo
integer x = 2683
integer y = 32
integer height = 256
string dataobject = "dw_ge269_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino

lvdt_Inicio  		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

dw_3.Object.Cabecalho_Periodo.Text = String(lvdt_Inicio, "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Termino, "dd/mm/yyyy")
dw_3.Object.Cabecalho_Filial.Text  = ivo_Filial.Nm_Fantasia + " (" + String(ivo_Filial.Cd_Filial) + ")"
dw_3.Object.Cabecalho_Produto.Text = ivo_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(ivo_Produto.Cd_Produto) + ")"

Return AncestorReturnValue
end event

