HA$PBExportHeader$w_ge265_relatorio_compras_produto.srw
forward
global type w_ge265_relatorio_compras_produto from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge265_relatorio_compras_produto from dc_w_selecao_lista_relatorio
string tag = "w_ge265_relatorio_compras_produto"
integer width = 3593
integer height = 1900
string title = "GE265 - Relat$$HEX1$$f300$$ENDHEX$$rio de Compras por Produto"
long backcolor = 80269524
end type
global w_ge265_relatorio_compras_produto w_ge265_relatorio_compras_produto

type variables
uo_fornecedor	ivo_fornecedor
uo_produto		ivo_produto
uo_filial			ivo_filial
end variables

forward prototypes
private subroutine wf_insere_padrao ()
end prototypes

private subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

If dw_1.GetChild("cd_uf_filial", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_unidade_federacao","TD")
	ldw_Child.SetItem(1,"nm_unidade_federacao","TODAS")
	
	dw_1.Object.cd_uf_filial[1] = "TD"
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna UF Filial.", StopSign!)
End If

If dw_1.GetChild("cd_uf_forn", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_unidade_federacao","TD")
	ldw_Child.SetItem(1,"nm_unidade_federacao","TODAS")
	
	dw_1.Object.cd_uf_forn[1] = "TD"
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna UF Fornecedor.", StopSign!)
End If

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldw_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldw_Child.SetItem(1, "id_lei_generico", "T")
ldw_Child.SetItem(1, "de_lei_generico", "TODAS")

dw_1.Object.id_lei_generico[1] = "T"
end subroutine

on w_ge265_relatorio_compras_produto.create
call super::create
end on

on w_ge265_relatorio_compras_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_Produto)
Destroy(ivo_filial)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_Inicio 	[1] = Today()
dw_1.Object.Dt_Termino	[1] = Today()

wf_insere_padrao()
end event

event ue_preopen;call super::ue_preopen;ivo_Fornecedor	= Create uo_Fornecedor
ivo_Produto		= Create uo_Produto
ivo_filial			= Create uo_filial

MaxHeight = 9999
MaxWidth = 5480
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge265_relatorio_compras_produto
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge265_relatorio_compras_produto
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge265_relatorio_compras_produto
integer x = 18
integer y = 448
integer width = 3515
integer height = 1248
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge265_relatorio_compras_produto
integer x = 18
integer width = 3077
integer height = 416
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge265_relatorio_compras_produto
integer x = 50
integer width = 3031
integer height = 328
string dataobject = "dw_ge265_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If


	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
					Return 1
			End If	
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	Case 'nm_filial'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_filial.nm_fantasia Then
				Return 1
			End If	
		Else
			ivo_filial.of_Inicializa()
			
			This.Object.cd_filial	[1] = ivo_filial.Cd_filial
			This.Object.nm_filial 	[1] = ivo_filial.nm_fantasia
		End If		
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If

If IsValid(ivo_Produto) Then
	This.Object.cd_Produto[1] = ivo_Produto.cd_produto
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	This.Object.cd_filial	[1] = ivo_Filial.cd_filial
	This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
			End If

		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case "nm_filial"
			ivo_Filial.of_Localiza_filial(This.GetText())
			
			If ivo_Filial.localizada Then
				This.Object.cd_filial	[1] = ivo_Filial.Cd_filial
				This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			End If
	End Choose
	
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge265_relatorio_compras_produto
integer x = 50
integer y = 524
integer width = 3456
integer height = 1152
string dataobject = "dw_ge265_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_Inicio, &
     lvdt_Termino

Long lvl_cd_Produto

dw_1.AcceptText()
	  
lvdt_Inicio 		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino  	= dw_1.Object.Dt_Termino	[1]
lvl_Cd_Produto = dw_1.Object.Cd_Produto	[1]

Return This.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Cd_Produto)
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]	 , &
		 lvs_Bloqueio[]
		 
lvs_Nome   = {"Fornecedor","Data","C$$HEX1$$f300$$ENDHEX$$digo da Filial","Nome da Filial","Nota","Esp$$HEX1$$e900$$ENDHEX$$cie","S$$HEX1$$e900$$ENDHEX$$rie","Quantidade","Pre$$HEX1$$e700$$ENDHEX$$o","% Desconto","ICMS Repassado","Custo"}

lvs_Coluna = {"cd_fornecedor","dh_emissao","cd_filial","nm_fantasia","nr_nf","de_especie","de_serie","qt_faturada","vl_preco_unitario","pc_desconto","vl_icms_repassado","vl_custo_nf"}

lvs_Bloqueio = {"S","N","N","N","N","N","N","N","N","N","N","N"}

This.of_SetSort(lvs_Coluna, lvs_Nome, lvs_Bloqueio)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto
Long lvl_Filial

Date lvdt_Inicio
Date lvdt_Termino
	  
String lvs_UF_Filial
String lvs_UF_Forn
String lvs_Lei_G
String lvs_Fornecedor

dw_1.AcceptText()

lvl_Produto		= dw_1.Object.Cd_Produto		[1]
lvdt_Inicio		= dw_1.Object.dt_inicio 			[1]
lvdt_Termino	= dw_1.Object.dt_termino		[1]
lvs_UF_Filial		= Dw_1.Object.cd_uf_filial		[1]
lvs_UF_Forn		= Dw_1.Object.cd_uf_forn		[1]
lvs_Lei_G			= Dw_1.Object.id_lei_generico	[1]
lvl_Filial			= Dw_1.Object.cd_filial			[1]
lvs_Fornecedor = dw_1.Object.Cd_Fornecedor	[1]

If lvdt_Inicio > lvdt_Termino Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	dw_1.SetFocus()
	Return -1
End If

If IsNull(lvdt_Inicio) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	dw_1.SetFocus()
	Return -1
End If

If IsNull(lvdt_Termino) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")
	dw_1.SetFocus()
	Return -1
End If

If (DaysAfter(lvdt_Inicio,lvdt_Termino) > 4)and(IsNull(lvl_Produto))and(IsNull(lvl_Filial)) Then
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta consulta poder$$HEX1$$e100$$ENDHEX$$ demorar, para otimiz$$HEX1$$e100$$ENDHEX$$-la voc$$HEX1$$ea00$$ENDHEX$$ pode especificar um produto ou filial.~rDeseja informar o produto ou filial?", Question!,YesNo!,1)=1 Then
		dw_1.Event ue_Pos(1, "de_produto")
		dw_1.SetFocus()
		Return -1
	End If
End If

If lvs_UF_Filial <> 'TD' Then
	This.Of_Appendwhere("cf.cd_unidade_federacao='"+lvs_UF_Filial+"'")
End If

If lvs_UF_Forn <> 'TD' Then
	This.Of_Appendwhere("cfo.cd_unidade_federacao='"+lvs_UF_Forn+"'")
End If

If lvs_Lei_G <> 'T' Then
	This.Of_Appendwhere("g.id_lei_generico='"+lvs_Lei_G+"'")
End If

If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
	This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'")
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	This.of_AppendWhere("i.cd_produto+0 = " + String(lvl_Produto))
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_SalvarComo(pl_Linhas > 0)
ivm_Menu.mf_Imprimir(pl_Linhas > 0)
	
Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;ivm_Menu.mf_SalvarComo(False)
ivm_Menu.mf_Imprimir(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge265_relatorio_compras_produto
integer x = 2569
integer y = 500
integer height = 280
string dataobject = "dw_ge265_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino

lvdt_Inicio		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

This.Object.Cabecalho_Periodo.Text = String(lvdt_Inicio, "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Termino, "dd/mm/yyyy")

If ivo_Produto.localizado Then 
	This.Object.Cabecalho_Produto.Text			= ivo_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(ivo_Produto.Cd_Produto) + ")"
	This.Object.DataWindow.Print.Orientation	= '2'
	This.Object.de_produto.Visible		= 0
	This.Object.de_produto_t.Visible	= 0
	This.Object.de_produto_l.Visible	= 0
	This.Object.cd_produto.Visible		= 0
	This.Object.cd_produto_t.Visible	= 0
	This.Object.cd_produto_l.Visible	= 0
	This.Object.data_dw.X				= 2944
	This.Object.pagina_dw.X				= 2944
	This.Object.titulo_dw.X				= 864
Else
	This.Object.Cabecalho_Produto.Text 			= 'TODOS'
	This.Object.DataWindow.Print.Orientation	= '1'
	This.Object.de_produto.Visible		= 1
	This.Object.de_produto_t.Visible	= 1
	This.Object.de_produto_l.Visible	= 1
	This.Object.cd_produto.Visible		= 1
	This.Object.cd_produto_t.Visible	= 1
	This.Object.cd_produto_l.Visible	= 1
	This.Object.data_dw.X				= 4411
	This.Object.pagina_dw.X				= 4411
	This.Object.titulo_dw.X				= 1564
End If

If ivo_Filial.localizada Then 
	This.Object.Cabecalho_Filial.Text = ivo_Filial.nm_fantasia + " (" + String(ivo_Filial.cd_filial) + ")"
Else
	This.Object.Cabecalho_Filial.Text = 'TODAS'
End If

If ivo_Fornecedor.Localizado Then 
	This.Object.Cabecalho_Fornecedor.Text = ivo_Fornecedor.nm_razao_social + " (" + String(ivo_Fornecedor.cd_fornecedor) + ")"
Else
	This.Object.Cabecalho_Fornecedor.Text = 'TODOS'
End If

This.Object.Cabecalho_UF_Forn.Text = dw_1.Describe("Evaluate('LookUpDisplay(cd_uf_forn)',1)")
This.Object.Cabecalho_UF_Filial.Text = dw_1.Describe("Evaluate('LookUpDisplay(cd_uf_filial)',1)")
This.Object.Cabecalho_Lei.Text 		= dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")

Return AncestorReturnValue
end event

