HA$PBExportHeader$w_ge529_cadastro_cartao_gift.srw
forward
global type w_ge529_cadastro_cartao_gift from dc_w_2tab_cadastro_selecao_lista_det
end type
end forward

global type w_ge529_cadastro_cartao_gift from dc_w_2tab_cadastro_selecao_lista_det
integer width = 4882
integer height = 2136
string title = "GE529 - Cadastro de Cart$$HEX1$$e300$$ENDHEX$$o Gift"
end type
global w_ge529_cadastro_cartao_gift w_ge529_cadastro_cartao_gift

type variables
dc_uo_dw_base dw_1, dw_2, dw_3

uo_ge503_cartao_gift io_Cartao_Gift

Long il_Seq_Cartao = 0
Long il_Linha_DW2 = 0
end variables

forward prototypes
public function boolean wf_proximo_sequencial (ref long al_cartao)
public function boolean wf_maior_data_inicio (long al_cartao, ref date adt_inicio)
public function boolean wf_valida_comissao_ja_cadastrada (long al_cartao, date adt_inicio)
public function boolean wf_verifica_registro_duplicado (string as_id_venda_pin, string as_ean, string as_texto_tef, long al_produto_cartao, string as_nr_bin)
end prototypes

public function boolean wf_proximo_sequencial (ref long al_cartao);al_Cartao = 0

Select Coalesce(Max(cd_cartao), 0) + 1
	Into :al_Cartao
From cartao_gift
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial da cartao_gift.", StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_maior_data_inicio (long al_cartao, ref date adt_inicio);SetNull(adt_Inicio)

Select Max(dh_inicio)
	Into :adt_Inicio
From cartao_gift_comissao
Where cd_cartao = :al_Cartao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o maior dh_inicio da cartao_gift_comissao do cart$$HEX1$$e300$$ENDHEX$$o selecionado.", StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_valida_comissao_ja_cadastrada (long al_cartao, date adt_inicio);Long ll_Find

ll_Find = dw_3.Find("cd_cartao = " + String(al_Cartao) + " and dh_inicio = Date('" + String(adt_Inicio, "yyyy/mm/dd") + "')", 1, dw_3.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_3.", StopSign!)
	Return False
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foi informado mais de uma vez o Cart$$HEX1$$e300$$ENDHEX$$o [" + String(al_Cartao) + "] e data de in$$HEX1$$ed00$$ENDHEX$$cio [" + String(adt_Inicio) + "].", Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_verifica_registro_duplicado (string as_id_venda_pin, string as_ean, string as_texto_tef, long al_produto_cartao, string as_nr_bin);Long ll_Find
Long ll_Contador = 0

String ls_Find
String ls_Mensagem

dw_2.AcceptText()

If as_Id_Venda_Pin = "S" Then
	ls_Find = "nr_ean_cartao = '" + as_EAN + "' and de_texto_tef = '" + as_Texto_TEF + "'"
Else
	ls_Find = "cd_produto_cartao = " + String(al_Produto_Cartao) + " and nr_bin = '" + as_Nr_Bin + "'"
End If

ll_Find = dw_2.Find(ls_Find, 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
	Return False
End If

Do While ll_Find > 0
	
	ll_Contador ++
	
	If ll_Contador > 1 Then
		If as_Id_Venda_Pin = "S" Then
			ls_Mensagem = "EAN [" + as_EAN + "] e Texto TEF = [" + as_Texto_TEF + "] foi informado mais de uma vez."
		Else
			ls_Mensagem = "Produto Cart$$HEX1$$e300$$ENDHEX$$o [" + String(al_Produto_Cartao) + "] e N$$HEX1$$ba00$$ENDHEX$$ BIN [" + as_Nr_Bin + "] foi informado mais de uma vez."
		End If
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Exclamation!)
		Return False
	End If
	
	If ll_Find < dw_2.RowCount() Then
		ll_Find = dw_2.Find(ls_Find, ll_Find + 1, dw_2.RowCount())

		If ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
			Return False
		End If
	Else
		ll_Find = 0
	End If
Loop

Return True
end function

on w_ge529_cadastro_cartao_gift.create
call super::create
end on

on w_ge529_cadastro_cartao_gift.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivb_grava_log = True

dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2, dw_3}
This.wf_SetUpdate_DW(lvo_Update)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(False)
end event

event ue_preopen;call super::ue_preopen;ivl_Altura_1		= 1956
ivl_Largura_1	= 4846

ivl_Altura_2 		= 1956
ivl_Largura_2 	= 1714

io_Cartao_Gift = Create uo_ge503_cartao_gift
end event

event ue_addrow;//OverRide

If tab_1.SelectedTab = 1 Then
	dw_2.Event ue_AddRow()
Else
	dw_3.Event ue_AddRow()
End If
end event

event close;call super::close;If IsValid(io_Cartao_Gift) Then Destroy(io_Cartao_Gift)
end event

event ue_presave;call super::ue_presave;Decimal ldc_Comissao_Posa
Decimal ldc_Comissao_Digital

Date ldt_Inicio
Date ldt_Maior_Inicio

Long ll_Linha

Integer li_Prd_Cartao

String ls_Nome_Cartao
String ls_Categoria
String ls_Id_Venda_Pin
String ls_Nr_Bin
String ls_EAN
String ls_Texto_TEF
String ls_Para

dw_2.AcceptText()
dw_3.AcceptText()

If tab_1.SelectedTab = 1 Then
	
	For ll_Linha = 1 To dw_2.RowCount()
		ls_Nome_Cartao	= dw_2.Object.Nm_Cartao				[ll_Linha]
		ls_Categoria			= dw_2.Object.Nm_Categoria			[ll_Linha]
		ls_Id_Venda_Pin 	= dw_2.Object.Id_Venda_Pin			[ll_Linha]
		ls_Nr_Bin				= dw_2.Object.Nr_Bin					[ll_Linha]
		li_Prd_Cartao		= dw_2.Object.Cd_Produto_Cartao	[ll_Linha]
		ls_EAN				= dw_2.Object.Nr_EAN_Cartao			[ll_Linha]
		ls_Texto_TEF		= dw_2.Object.De_Texto_TEF			[ll_Linha]
		
		If IsNull(ls_Nome_Cartao) Or Trim(ls_Nome_Cartao) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o nome do cart$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
			dw_2.Event ue_Pos(ll_Linha, "nm_cartao")
			Return False
		End If
		
		If IsNull(ls_Categoria) Or Trim(ls_Categoria) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a categoria.", Exclamation!)
			dw_2.Event ue_Pos(ll_Linha, "nm_categoria")
			Return False
		End If
		
		If ls_Id_Venda_Pin = "N" Then		
			If IsNull(ls_Nr_Bin) Or Trim(ls_Nr_Bin) = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para Venda PIN [N$$HEX1$$c300$$ENDHEX$$O], deve ser preenchido o n$$HEX1$$fa00$$ENDHEX$$mero do BIN.", Exclamation!)
				dw_2.Event ue_Pos(ll_Linha, "nr_bin")
				Return False
			End If
			
			If IsNull(li_Prd_Cartao) Or li_Prd_Cartao = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para Venda PIN [N$$HEX1$$c300$$ENDHEX$$O], deve ser preenchido o produto Cart$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
				dw_2.Event ue_Pos(ll_Linha, "cd_produto_cartao")
				Return False
			End If
			
		Else
			
			If IsNull(ls_EAN) Or Trim(ls_EAN) = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para Venda PIN [SIM], deve ser preenchido o EAN.", Exclamation!)
				dw_2.Event ue_Pos(ll_Linha, "nr_ean_cartao")
				Return False
			End If
			
			If IsNull(ls_Texto_TEF) Or Trim(ls_Texto_TEF) = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para Venda PIN [SIM], deve ser preenchido o Texto TEF.", Exclamation!)
				dw_2.Event ue_Pos(ll_Linha, "de_texto_tef")
				Return False
			End If
		End If
		
		If IsNull(dw_2.Object.Cd_Cartao[ll_Linha]) Or gf_Houve_Alteracao_Dw(dw_2, 'ID_VENDA_PIN', ll_Linha, Ref ls_Para) Or &
			gf_Houve_Alteracao_Dw(dw_2, 'DE_TEXTO_TEF', ll_Linha, Ref ls_Para) Or gf_Houve_Alteracao_Dw(dw_2, 'NR_EAN_CARTAO', ll_Linha, Ref ls_Para) Or &
			gf_Houve_Alteracao_Dw(dw_2, 'NR_BIN', ll_Linha, Ref ls_Para) Or gf_Houve_Alteracao_Dw(dw_2, 'CD_PRODUTO_CARTAO', ll_Linha, Ref ls_Para) Then
			
			If Not wf_Verifica_Registro_Duplicado(ls_Id_Venda_Pin, ls_EAN, ls_Texto_TEF, li_Prd_Cartao, ls_Nr_Bin) Then Return False
		End If
	Next

Else

	If dw_3.RowCount() > 0 Then
		
		//Se $$HEX1$$e900$$ENDHEX$$ um cart$$HEX1$$e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ cadastrado, ou seja, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ novo
		If Not IsNull(dw_2.Object.Cd_Cartao[dw_2.GetRow()]) Then
			If Not wf_Maior_Data_Inicio(dw_2.Object.Cd_Cartao[dw_2.GetRow()], Ref ldt_Maior_Inicio) Then Return False
		End If
	
		For ll_Linha = 1 To dw_3.RowCount()
			ldt_Inicio 				= Date(dw_3.Object.Dh_Inicio			[ll_Linha])
			ldc_Comissao_Posa 	= dw_3.Object.Pc_Comissao_Posa	[ll_Linha]
			ldc_Comissao_Digital 	= dw_3.Object.Pc_Comissao_Digital	[ll_Linha]
			
			If IsNull(ldt_Inicio) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
				dw_3.Event ue_Pos(ll_Linha, "dh_inicio")
				Return False
			End If		
				
			If IsNull(dw_3.Object.Cd_Cartao[ll_Linha]) Then
				If Not IsNull(ldt_Maior_Inicio) Then
					If ldt_Inicio < ldt_Maior_Inicio Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio [" + String(ldt_Inicio) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser MENOR que a data [" + String(ldt_Maior_Inicio) + "] j$$HEX1$$e100$$ENDHEX$$ cadastrada para o cart$$HEX1$$e300$$ENDHEX$$o selecionado.", Exclamation!)
						dw_3.Event ue_Pos(ll_Linha, "dh_inicio")
						Return False
					End If
				End If		
			
				If Not wf_Valida_Comissao_Ja_Cadastrada(dw_2.Object.Cd_Cartao[dw_2.GetRow()], ldt_Inicio) Then
					dw_3.Event ue_Pos(ll_Linha, "dh_inicio")
					Return False
				End If
			End If
					
			If (IsNull(ldc_Comissao_Posa) Or ldc_Comissao_Posa = 0.00) And (IsNull(ldc_Comissao_Digital) Or ldc_Comissao_Digital = 0.00) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Comiss$$HEX1$$e300$$ENDHEX$$o Posa e/ou Comiss$$HEX1$$e300$$ENDHEX$$o Digital deve ser informada.", Exclamation!)
				dw_3.Event ue_Pos(ll_Linha, "pc_comissao_posa")
				Return False
			End If
			
			If ldc_Comissao_Posa > 100.00 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Comiss$$HEX1$$e300$$ENDHEX$$o Posa n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 100,00.", Exclamation!)
				dw_3.Event ue_Pos(ll_Linha, "pc_comissao_posa")
				Return False
			End If
			
			If ldc_Comissao_Digital > 100.00 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Comiss$$HEX1$$e300$$ENDHEX$$o Digital n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 100,00.", Exclamation!)
				dw_3.Event ue_Pos(ll_Linha, "pc_comissao_digital")
				Return False
			End If
			
			dw_3.Object.Cd_Cartao[ll_Linha] = dw_2.Object.Cd_Cartao[dw_2.GetRow()]
			
			If IsNull(ldc_Comissao_Posa) Then dw_3.Object.Pc_Comissao_Posa[ll_Linha] = 0
			If IsNull(ldc_Comissao_Digital) Then dw_3.Object.Pc_Comissao_Digital[ll_Linha] = 0
		Next
	End If
End If

Return True
end event

event ue_cancel;call super::ue_cancel;If tab_1.SelectedTab = 1 Then
	dw_1.SetFocus()
Else
	dw_3.SetFocus()
End If
end event

type dw_visual from dc_w_2tab_cadastro_selecao_lista_det`dw_visual within w_ge529_cadastro_cartao_gift
end type

type gb_aux_visual from dc_w_2tab_cadastro_selecao_lista_det`gb_aux_visual within w_ge529_cadastro_cartao_gift
end type

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge529_cadastro_cartao_gift
integer width = 4800
integer height = 1916
end type

event tab_1::selectionchanged;call super::selectionchanged;If NewIndex = 2 Then
	dw_3.Object.Texto_t.Text = dw_2.Object.Nm_Cartao[dw_2.GetRow()] + " (" + String(dw_2.Object.Cd_Cartao[dw_2.GetRow()]) + ")"
End If
end event

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1		
		If ivb_Valida_Salva Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Salve ou cancele a altera$$HEX2$$e700e300$$ENDHEX$$o para prosseguir.", Exclamation!)
			Return 1
		End If
	
		If oldIndex = 2 Then
			If dw_2.RowCount() > 0 Then
				dw_2.SetRow(il_Linha_DW2)
				dw_2.ScrollToRow(il_Linha_DW2)
			End If
		End If

	Case 2
		If dw_2.GetRow() > 0 Then
			il_Linha_DW2 = dw_2.GetRow()
		End If
		
		If Not Parent.ivb_Inclusao Then
			If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
				
				If ivb_Valida_Salva Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Salve ou cancele a altera$$HEX2$$e700e300$$ENDHEX$$o para prosseguir.", Exclamation!)
					Return 1
				End If				
					
				// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW's de detalhes
				Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
			
				// Permite a troca do folder
				//Return 0
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
				// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
				Return 1
			End If
		End If
End Choose

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer width = 4763
integer height = 1800
end type

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer y = 304
integer width = 4713
integer height = 1468
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
integer width = 2203
integer height = 280
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
integer width = 2121
integer height = 172
string dataobject = "dw_ge529_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_cartao"
			io_Cartao_Gift.of_Localiza_Cartao_Gift(This.GetText())
			
			If io_Cartao_Gift.Localizado Then
				This.Object.Cd_Cartao	[1] = io_Cartao_Gift.Cd_Cartao
				This.Object.Nm_Cartao	[1] = io_Cartao_Gift.Nm_Cartao
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_cartao"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Cartao_Gift.Nm_Cartao Then
				Return 1
			End If
		Else
			io_Cartao_Gift.of_Inicializa()
			
			This.Object.Cd_Cartao	[1] = io_Cartao_Gift.Cd_Cartao
			This.Object.Nm_Cartao	[1] = io_Cartao_Gift.Nm_Cartao
		End If
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer y = 384
integer width = 4635
integer height = 1348
string dataobject = "dw_ge529_lista"
end type

event dw_2::itemchanged;call super::itemchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If
end event

event dw_2::editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Cartao

String ls_Categoria
String ls_EAN
String ls_Id_Venda_Pin

dw_1.AcceptText()

ll_Cartao 			= dw_1.Object.Cd_Cartao		[1]
ls_Categoria			= dw_1.Object.Nm_Categoria	[1]
ls_EAN				= dw_1.Object.Nr_Ean_Cartao	[1]
ls_Id_Venda_Pin	= dw_1.Object.Id_Venda_Pin	[1]

If Not IsNull(ll_Cartao) And ll_Cartao > 0 Then
	This.of_AppendWhere("cd_cartao = " + String(ll_Cartao))
End If

If Not IsNull(ls_Categoria) And Trim(ls_Categoria) <> "" Then
	This.of_AppendWhere("nm_categoria = '" + ls_Categoria + "'")
End If

If Not IsNull(ls_EAN) And Trim(ls_EAN) <> "" Then
	This.of_AppendWhere("nr_ean_cartao = '" + ls_EAN + "'")
End If

If ls_Id_Venda_Pin <> "T" Then
	This.of_AppendWhere("id_venda_pin = '" + ls_Id_Venda_Pin + "'")
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(True)
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(False)
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long ll_Linha
Long ll_Prox_Cartao = 0

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	
	If IsNull(dw_2.Object.Cd_Cartao[ll_Linha]) Then
		If ll_Prox_Cartao = 0 Then
			If Not wf_Proximo_Sequencial(Ref ll_Prox_Cartao) Then Return -1
		Else
			ll_Prox_Cartao ++
		End If
		
		dw_2.Object.Cd_Cartao[ll_Linha] = ll_Prox_Cartao
	End If
Next
end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer width = 4763
integer height = 1800
end type

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer width = 1627
integer height = 1772
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer width = 1541
integer height = 1656
string dataobject = "dw_ge529_detalhe"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = false
end type

event dw_3::ue_recuperar;//OverRide

dw_2.AcceptText()

Return This.Retrieve(dw_2.Object.Cd_Cartao[il_Linha_DW2])
end event

event dw_3::ue_postretrieve;//OverRide

Boolean lvb_Ok = False

If pl_Linhas > 0 Then
	lvb_Ok = False
	
	This.ScrollToRow(1)
	This.SetRow(1)
	This.SetFocus()
	
	This.ivi_Tipo_Cancelar = RETRIEVE
	
	dw_3.ivo_Controle_Menu.of_SalvarComo(True)
	
Else
	
	dw_3.ivo_Controle_Menu.of_SalvarComo(False)
	
//ElseIf pl_Linhas = 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

This.ivo_Controle_Menu.of_Excluir(lvb_Ok)

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

Return pl_Linhas
end event

event dw_3::ue_preinsertrow;//OverRide

If This.RowCount() > 0 Then
	If IsNull(This.Object.Cd_Cartao[This.RowCount()]) Then
		Return -1
	End If
End If

If wf_Valida_Salva() > 0 Then
	//This.Reset()
	Return 1
Else
	Return -1
End If
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_3::ue_addrow;call super::ue_addrow;ivi_Tipo_Cancelar = RETRIEVE

Return AncestorReturnValue
end event

