HA$PBExportHeader$w_ge369_alteracao_preco_direta.srw
forward
global type w_ge369_alteracao_preco_direta from dc_w_sheet
end type
type gb_3 from groupbox within w_ge369_alteracao_preco_direta
end type
type gb_2 from groupbox within w_ge369_alteracao_preco_direta
end type
type gb_1 from groupbox within w_ge369_alteracao_preco_direta
end type
type dw_1 from dc_uo_dw_base within w_ge369_alteracao_preco_direta
end type
type dw_2 from dc_uo_dw_base within w_ge369_alteracao_preco_direta
end type
type dw_3 from dc_uo_dw_base within w_ge369_alteracao_preco_direta
end type
type dw_4 from dc_uo_dw_base within w_ge369_alteracao_preco_direta
end type
type st_1 from statictext within w_ge369_alteracao_preco_direta
end type
type st_2 from statictext within w_ge369_alteracao_preco_direta
end type
type st_3 from statictext within w_ge369_alteracao_preco_direta
end type
type st_4 from statictext within w_ge369_alteracao_preco_direta
end type
end forward

global type w_ge369_alteracao_preco_direta from dc_w_sheet
integer width = 3602
integer height = 1980
string title = "GE369 - Altera$$HEX2$$e700e300$$ENDHEX$$o Direta de Pre$$HEX1$$e700$$ENDHEX$$os"
long backcolor = 80269524
event ue_retrieve ( )
event type integer ue_preprint ( )
event ue_sort ( )
event ue_find ( )
event ue_filter ( )
event ue_clearfilter ( )
event ue_historico_preco_reposicao ( )
event ue_historico_preco_venda ( )
event ue_historico_desconto ( )
event ue_importar_arquivo ( )
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_ge369_alteracao_preco_direta w_ge369_alteracao_preco_direta

type variables
uo_fornecedor ivo_fornecedor

uo_produto ivo_produto

uo_grupo_produto_mkt ivo_grupo_produto_mkt

date ivdt_parametro
end variables

forward prototypes
public subroutine wf_atualiza_preco_dw ()
public function boolean wf_verifica_bloqueio ()
end prototypes

event ue_retrieve;dw_2.Event ue_Retrieve()
end event

event ue_preprint;dw_3.Object.DataWindow.Table.Select = dw_2.Object.DataWindow.Table.Select

Return dw_3.RowCount()
end event

event ue_sort;dw_2.Event ue_Sort()
end event

event ue_find;dw_2.Event ue_Find()
end event

event ue_filter;dw_2.Event ue_Filter()
end event

event ue_clearfilter;dw_2.Event ue_ClearFilter()
end event

event ue_historico_preco_reposicao();Long lvl_Linha, &
     lvl_Produto 

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Linha]

	OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(lvl_Produto))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico.")
End If
end event

event ue_historico_preco_venda();Long lvl_Linha, &
     lvl_Produto 

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Linha]

	OpenWithParm(w_ge120_Historico_Preco_Venda, String(lvl_Produto))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico.")
End If
end event

event ue_historico_desconto();Long lvl_Linha, &
     lvl_Produto 

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Linha]

	OpenWithParm(w_ge120_Historico_Desconto, String(lvl_Produto))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o hist$$HEX1$$f300$$ENDHEX$$rico.")
End If
end event

event ue_importar_arquivo();Open(w_ge369_Importacao_Arquivo)
end event

public subroutine wf_atualiza_preco_dw ();Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Contador
	 
String lvs_Considerar_Bloqueados,&
	   lvs_Bloqueado
	 
Decimal lvl_Preco_Reposicao,&
		lvl_Preco_Venda
		
dw_1.AcceptText()
	 
lvl_Linhas = dw_2.RowCount()

lvl_Preco_Reposicao 		= dw_1.Object.vl_preco_reposicao	  [1]
lvl_Preco_Venda     	    = dw_1.Object.vl_preco_venda    	  [1]
lvs_Considerar_Bloqueados	= dw_1.Object.id_considerar_bloqueados[1]

For lvl_Linha = 1 To lvl_Linhas
	If Not IsNull(lvl_Preco_Reposicao) and lvl_Preco_Reposicao > 0 Then
		dw_2.Object.vl_preco_reposicao[lvl_Linha] = lvl_Preco_Reposicao
		lvl_Contador ++
	End If
	
	lvs_Bloqueado = dw_2.Object.id_bloqueado[lvl_Linha]
	
	If lvs_Bloqueado = "S" and lvs_Considerar_Bloqueados = "S" Then lvs_Bloqueado = "N"
	
	// S$$HEX1$$f300$$ENDHEX$$ vai atualizar se o produto n$$HEX1$$e300$$ENDHEX$$o estiver bloqueado
	If Not IsNull(lvl_Preco_Venda) and lvl_Preco_Venda > 0 and  lvs_Bloqueado = "N" Then
		dw_2.Object.vl_preco_venda_futuro[lvl_Linha] = lvl_Preco_Venda
		lvl_Contador ++
	End If
Next

//dw_1.Object.vl_preco_reposicao[1] = 0
//dw_1.Object.vl_preco_venda    [1] = 0

If lvl_Contador > 0 Then
	
	ivb_Valida_Salva = True
	
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If



end subroutine

public function boolean wf_verifica_bloqueio ();Long ll_Linha, ll_Linhas, ll_Produto, ll_Promocao, ll_Achou

String ls_Nome_Promocao, ls_UF

Date ldh_Termino

dw_2.AcceptText()

Open(w_Aguarde)

ll_Linhas = dw_2.RowCount()

w_aguarde.uo_progress.of_setmax(ll_Linhas)

w_Aguarde.Title = "Verificando as Promo$$HEX2$$e700f500$$ENDHEX$$es Bloqueadas ..."

For ll_Linha = 1 To ll_Linhas
	
	ll_Produto 	= dw_2.Object.cd_produto					[ll_Linha]
	ls_UF 			= dw_2.Object.	cd_unidade_federacao	[ll_Linha]
	
	select count(*)
	Into :ll_Achou
	from vw_promocao_estoque_minimo v
	where v.cd_produto = :ll_Produto
	  and v.cd_uf = :ls_UF
	  and v.id_preco_bloqueado = 'S' 
	  and v.id_situacao = 'L'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o.")
		Close(w_Aguarde)
		Return False
	Else
		If ll_Achou > 0 Then
			dw_2.Object.id_bloqueado_promocao		[ll_Linha] = 'S'
			dw_2.Object.id_bloqueado_promocao_ant	[ll_Linha] = 'S'
		Else
			dw_2.Object.id_bloqueado_promocao		[ll_Linha] = 'N'
			dw_2.Object.id_bloqueado_promocao_ant	[ll_Linha] = 'N'
		End If
	End If
	
	w_aguarde.uo_progress.of_setprogress(ll_Linha)
		
Next

Close(w_Aguarde)

Return True
end function

on w_ge369_alteracao_preco_direta.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
end on

on w_ge369_alteracao_preco_direta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_DW[]
lvo_DW = {dw_2}
This.wf_SetUpdate_DW(lvo_DW)

dw_1.Event ue_AddRow()
dw_4.Event ue_AddRow()

This.ivm_Menu.mf_Recuperar(True)

ivdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

dw_1.Object.Dt_Inicio_Vigencia[1] = RelativeDate(ivdt_Parametro, 1)

dw_1.SetFocus()
end event

event ue_preopen;call super::ue_preopen;dw_3.Visible = False
end event

event ue_print;call super::ue_print;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas  = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_3.Event ue_Print()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event ue_printimmediate;call super::ue_printimmediate;Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas  = This.Event ue_PrePrint()

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then
		dw_3.Event ue_PrintImmediate()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)
end event

event open;call super::open;ivo_Fornecedor 		  = Create uo_Fornecedor
ivo_Produto       	  = Create uo_Produto
ivo_Grupo_Produto_MKT = Create uo_Grupo_Produto_MKT 


end event

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_Produto)
Destroy(ivo_Grupo_Produto_MKT)
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	dw_2.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge369_alteracao_preco_direta
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge369_alteracao_preco_direta
end type

type gb_3 from groupbox within w_ge369_alteracao_preco_direta
integer x = 18
integer y = 1440
integer width = 3515
integer height = 256
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados Anteriores a Altera$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge369_alteracao_preco_direta
integer x = 18
integer y = 440
integer width = 3515
integer height = 980
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge369_alteracao_preco_direta
integer x = 18
integer width = 3515
integer height = 412
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge369_alteracao_preco_direta
integer x = 41
integer y = 52
integer width = 3479
integer height = 336
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge369_selecao"
end type

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fantasia  [1] = ivo_Fornecedor.Nm_Fantasia
		End If
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Not IsNull(This.Object.Cd_Produto[1]) Then
				If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
					Return 1
				End If
			End If
		Else
			ivo_Produto.of_Inicializa()			
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque			
		End If
		
	Case "de_grupo"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Not IsNull(This.Object.Cd_Grupo[1]) Then
				If Data <> ivo_Grupo_Produto_MKT.de_grupo Then
					Return 1
				End If
			End If
		Else
			ivo_Grupo_Produto_MKT.of_Inicializa()			
			
			This.Object.Cd_Grupo[1] = ivo_Grupo_Produto_MKT.Cd_Grupo
			This.Object.De_Grupo[1] = ivo_Grupo_Produto_MKT.de_Grupo
			
			dw_1.Object.st_Preco_Venda.Visible      	 = 0
			dw_1.Object.st_Preco_Reposicao.Visible  	 = 0
			dw_1.Object.vl_preco_venda.Visible 	    	 = 0
			dw_1.Object.vl_preco_reposicao.Visible  	 = 0
			dw_1.Object.id_considerar_bloqueados.Visible = 0
		End If
End Choose

If dwo.Name = "vl_preco_reposicao" or dwo.Name = "vl_preco_venda" Then
	wf_Atualiza_Preco_DW()
End If

If dwo.Name = "id_considerar_bloqueados" Then
	If This.Object.id_considerar_bloqueados[1] = "N" Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja alterar o pre$$HEX1$$e700$$ENDHEX$$o de venda dos produtos bloqueados ?", Question!, YesNo!, 2) = 2 Then
			Return 1
		End If
	End If
End If

If dwo.Name <> "dt_inicio_vigencia" and &
   dwo.Name <> "vl_preco_reposicao" and &
   dwo.Name <> "vl_preco_venda"     and &
   dwo.Name <> "id_considerar_bloqueados" Then
	dw_2.Event ue_Reset()
End If
end event

event editchanged;call super::editchanged;If dwo.Name <> "dt_inicio_vigencia" and &
   dwo.Name <> "vl_preco_reposicao" and &
   dwo.Name <> "vl_preco_venda"     and &
   dwo.Name <> "id_considerar_bloqueados" Then
	dw_2.Event ue_Reset()
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event ue_key;Integer lvi_Visible

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fantasia  [1] = ivo_Fornecedor.Nm_Fantasia
			End If		
			
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If	
		Case "de_grupo" 
			ivo_Grupo_Produto_MKT.of_Localiza_Grupo(This.GetText())
			
			lvi_Visible = 0
			
			If ivo_Grupo_Produto_MKT.Localizado Then
				This.Object.cd_grupo[1] = ivo_Grupo_Produto_MKT.cd_grupo
				This.Object.de_grupo[1] = ivo_Grupo_Produto_MKT.de_grupo
			End If
			
			dw_1.Object.st_Preco_Venda.Visible      	 		= lvi_Visible
			dw_1.Object.st_Preco_Reposicao.Visible			= lvi_Visible
			dw_1.Object.vl_preco_venda.Visible 	    	 		= lvi_Visible
			dw_1.Object.vl_preco_reposicao.Visible  	 	= lvi_Visible
			dw_1.Object.id_considerar_bloqueados.Visible = lvi_Visible
	End Choose
End If

If Key = KeyF2! Then
	Event ue_Historico_Preco_Reposicao()
End If

If Key = KeyF3! Then
	Event ue_Historico_Preco_Venda()
End If

If Key = KeyF4! Then
	Event ue_Historico_Desconto()
End If

If Key = KeyF5! Then
	Event ue_Importar_Arquivo()
End If
end event

event losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Fantasia[1] = ivo_Fornecedor.Nm_Fantasia
End If		
			
If IsValid(ivo_Produto) Then
	If Not IsNull(This.Object.Cd_Produto[1]) Then
		This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If

If IsValid(ivo_Grupo_Produto_MKT) Then
	This.Object.de_grupo[1] = ivo_Grupo_Produto_MKT.de_grupo
End If	



end event

type dw_2 from dc_uo_dw_base within w_ge369_alteracao_preco_direta
integer x = 46
integer y = 488
integer width = 3465
integer height = 912
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_ge369_lista"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ShareData(dw_3)

This.of_SetRowSelection()
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		lvb_Localizar, &
		lvb_Imprimir
		
Integer lvi_Visible

If pl_Linhas > 0 Then
	
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
	
	dw_4.Reset()
	dw_4.Event ue_AddRow()
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Imprimir(lvb_Imprimir)

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

If pl_Linhas > 0 Then
	If Not IsNull(dw_1.Object.cd_grupo[1]) Then
		lvi_Visible = 1
		dw_1.Object.vl_preco_venda	  [1] 		= 0
		dw_1.Object.vl_preco_reposicao[1] 	    = 0
		dw_1.Object.id_considerar_bloqueados[1] = "N"
	Else
		lvi_Visible = 0 
	End If
	
	dw_1.Object.st_Preco_Venda.Visible      	 = lvi_Visible
	dw_1.Object.st_Preco_Reposicao.Visible  	 = lvi_Visible
	dw_1.Object.vl_preco_venda.Visible 	    	 = lvi_Visible
	dw_1.Object.vl_preco_reposicao.Visible  	 = lvi_Visible
	dw_1.Object.id_considerar_bloqueados.Visible = lvi_Visible
	
	wf_Verifica_Bloqueio()
End If

Return pl_Linhas
end event

event ue_reset;call super::ue_reset;ivm_Menu.mf_Classificar(False)
ivm_Menu.mf_Filtrar(False)
ivm_Menu.mf_Localizar(False)
ivm_Menu.mf_Imprimir(False)

dw_4.Reset()
dw_4.InsertRow(0)

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_4.Object.Vl_Preco_Venda_Atual [1] = This.Object.Vl_Preco_Venda_Atual   [CurrentRow]
	dw_4.Object.Dh_Preco_Venda_Atual [1] = This.Object.Dh_Preco_Venda_Atual   [CurrentRow]
	dw_4.Object.Vl_Preco_Venda_Futuro[1] = This.Object.Vl_Preco_Venda_Futuro_A[CurrentRow]
	dw_4.Object.Dh_Preco_Venda_Futuro[1] = This.Object.Dh_Preco_Venda_Futuro_A[CurrentRow]
	dw_4.Object.Vl_Preco_Reposicao   [1] = This.Object.Vl_Preco_Reposicao_A   [CurrentRow]
	dw_4.Object.Dh_Preco_Reposicao   [1] = This.Object.Dh_Preco_Reposicao_A   [CurrentRow]	
End If
end event

event ue_preretrieve;call super::ue_preretrieve;//String lvs_UF, &
//       lvs_Fornecedor, &
//	   lvs_Produto, &
//	   lvs_Tipo
//		 
//Long lvl_Produto,&
//	 lvl_Grupo
//
//If wf_Valida_Salva() <= 0 Then Return -1
//
//dw_1.AcceptText()
//
//lvs_UF         = dw_1.Object.Cd_UF        [1]
//lvs_Fornecedor = dw_1.Object.Cd_Fornecedor[1]
//lvl_Produto    = dw_1.Object.Cd_Produto   [1]
//lvs_Produto    = dw_1.Object.De_Produto   [1]
//lvs_Tipo       = dw_1.Object.Id_Tipo      [1]
//lvl_Grupo	   = dw_1.Object.cd_grupo     [1]
//
//If IsNull(lvs_UF) or Trim(lvs_UF) = "" Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a U.F. para alterar os pre$$HEX1$$e700$$ENDHEX$$os.")
//	dw_1.Event ue_Pos(1, "cd_uf")
//	Return 1
//End If
//
//If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
//	This.of_AppendWhere("g.cd_fornecedor_usual = '" + lvs_Fornecedor + "'", 1)
//	This.of_AppendWhere("g.cd_fornecedor_usual = '" + lvs_Fornecedor + "'", 3)
//End If
//
//If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
//	This.of_AppendWhere("u.cd_produto = " + String(lvl_Produto), 1)
//	This.of_AppendWhere("u.cd_produto = " + String(lvl_Produto), 3)
//Else
//	If Not IsNull(lvs_Produto) and lvs_Produto <> "" Then
//		This.of_AppendWhere("g.de_produto like '" + lvs_Produto + "%'", 1)
//		This.of_AppendWhere("g.de_produto like '" + lvs_Produto + "%'", 3)
//	End If
//End If
//
//Choose Case lvs_Tipo
//	Case "I" 
//		This.of_AppendWhere("c.id_preco_informado = 'S'", 1)		
//		This.of_AppendWhere("c.id_preco_informado = 'S'", 3)		
//		
//	Case "A"
//		This.of_AppendWhere("c.cd_produto_abcfarma is not null", 1)		
//		This.of_AppendWhere("c.cd_produto_abcfarma is not null", 3)		
//End Choose
//
//If Not IsNull(lvl_Grupo) Then
//	This.of_AppendWhere("g.cd_produto in (select mk.cd_produto from promocao_mkt_grupo_produto mk where mk.cd_grupo = " + String(lvl_Grupo)  + ")", 1)
//	This.of_AppendWhere("g.cd_produto in (select mk.cd_produto from promocao_mkt_grupo_produto mk where mk.cd_grupo = " + String(lvl_Grupo)  + ")", 4)
//End If
//
//Return This

Return 1
end event

event editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha

Date lvdt_Vigencia, &
     lvdt_Nulo

Decimal lvdc_Venda_Anterior, &
        lvdc_Venda_Novo, &
		  lvdc_Reposicao_Anterior, &
		  lvdc_Reposicao_Novo
		  
String lvs_Nulo

DateTime lvdh_ServerDate

dw_1.AcceptText()
lvdt_Vigencia = dw_1.Object.Dt_Inicio_Vigencia[1]

If IsNull(lvdt_Vigencia) or Not IsDate(String(lvdt_Vigencia, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe corretamente a data de in$$HEX1$$ed00$$ENDHEX$$cio da vig$$HEX1$$ea00$$ENDHEX$$ncia para os pre$$HEX1$$e700$$ENDHEX$$os de venda alterados.")
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return -1
End If

If lvdt_Vigencia <= ivdt_Parametro Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da vig$$HEX1$$ea00$$ENDHEX$$ncia deve ser maior ou igual a '" + &
	                      String(RelativeDate(ivdt_Parametro, 1), "dd/mm/yyyy") + "'.")
								 
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return -1
End If

SetNull(lvdt_Nulo)
SetNull(lvs_Nulo)

lvdh_ServerDate = gf_GetServerDate()

For lvl_Linha = 1 To This.RowCount()
	lvdc_Venda_Anterior     = This.Object.Vl_Preco_Venda_Futuro_A[lvl_Linha]
	lvdc_Venda_Novo         = This.Object.Vl_Preco_Venda_Futuro  [lvl_Linha]
   lvdc_Reposicao_Anterior = This.Object.Vl_Preco_Reposicao_A   [lvl_Linha]
   lvdc_Reposicao_Novo     = This.Object.Vl_Preco_Reposicao     [lvl_Linha]
	
	If IsNull(lvdc_Venda_Anterior) Then     lvdc_Venda_Anterior     = 0
	If IsNull(lvdc_Venda_Novo) Then         lvdc_Venda_Novo         = 0
	If IsNull(lvdc_Reposicao_Anterior) Then lvdc_Reposicao_Anterior = 0
	If IsNull(lvdc_Reposicao_Novo) Then     lvdc_Reposicao_Novo     = 0
	
	If lvdc_Reposicao_Novo <> lvdc_Reposicao_Anterior Then
		If lvdc_Reposicao_Novo <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o deve ser maior que zero.")
			This.Event ue_Pos(lvl_Linha, "vl_preco_reposicao")
			Return -1
		End If
		
		This.Object.Dh_Preco_Reposicao          [lvl_Linha] = lvdh_ServerDate
		This.Object.Nr_Matricula_Preco_Reposicao[lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	End If
	
	If lvdc_Venda_Novo <> lvdc_Venda_Anterior Then
		If lvdc_Venda_Novo > 0 Then
			This.Object.Dh_Preco_Venda_Futuro       [lvl_Linha] = lvdt_Vigencia
			This.Object.Nr_Matric_Preco_Venda_Futuro[lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		Else
			This.Object.Dh_Preco_Venda_Futuro       [lvl_Linha] = lvdt_Nulo
			This.Object.Nr_Matric_Preco_Venda_Futuro[lvl_Linha] = lvs_Nulo
		End If
	End If
Next

Return 1
end event

event itemchanged;call super::itemchanged;If dwo.Name = "id_bloqueado_promocao" Then
	If Data = "N" and dw_2.Object.id_bloqueado_promocao_ant[row] = 'S' Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto est$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado na promo$$HEX2$$e700e300$$ENDHEX$$o." +&
							"~r~rDeseja alterar o pre$$HEX1$$e700$$ENDHEX$$o mesmo assim ?", Question!, YesNo!, 2) = 2 Then 
			Return 1
		End If		
	End If
End If


end event

event ue_recuperar;// OverRide
Date ldt_Resumo

String	lvs_UF, &
       	lvs_Fornecedor, &
	   	lvs_Produto, &
	   	lvs_Tipo
		 
Long	lvl_Produto,&
	 	lvl_Grupo

//If wf_Valida_Salva() <= 0 Then Return -1

dw_1.AcceptText()

ldt_Resumo = gf_primeiro_dia_mes(Date(gf_GetServerDate()))

lvs_UF         	= dw_1.Object.Cd_UF        		[1]
lvs_Fornecedor = dw_1.Object.Cd_Fornecedor	[1]
lvl_Produto    	= dw_1.Object.Cd_Produto   	[1]
lvs_Produto    	= dw_1.Object.De_Produto   	[1]
lvs_Tipo       	= dw_1.Object.Id_Tipo      		[1]
lvl_Grupo	   		= dw_1.Object.cd_grupo     	[1]

If IsNull(lvs_UF) or Trim(lvs_UF) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a U.F. para alterar os pre$$HEX1$$e700$$ENDHEX$$os.")
	dw_1.Event ue_Pos(1, "cd_uf")
	Return -1
End If

If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
	This.of_AppendWhere("g.cd_fornecedor_usual = '" + lvs_Fornecedor + "'", 1)
	This.of_AppendWhere("g.cd_fornecedor_usual = '" + lvs_Fornecedor + "'", 2)
End If

If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
	This.of_AppendWhere("g.cd_produto = " + String(lvl_Produto), 1)
	This.of_AppendWhere("g.cd_produto = " + String(lvl_Produto), 2)
Else
	If Not IsNull(lvs_Produto) and lvs_Produto <> "" Then
		This.of_AppendWhere("g.de_produto like '" + lvs_Produto + "%'", 1)
		This.of_AppendWhere("g.de_produto like '" + lvs_Produto + "%'", 2)
	End If
End If

If lvs_Tipo = "I" Then
	This.of_AppendWhere("c.id_preco_informado = 'S'", 1)		
	This.of_AppendWhere("c.id_preco_informado = 'S'", 2)		
ElseIf lvs_Tipo ="A" Then
	This.of_AppendWhere("c.cd_produto_abcfarma is not null", 1)		
	This.of_AppendWhere("c.cd_produto_abcfarma is not null", 2)		
End If

If Not IsNull(lvl_Grupo) Then
	This.of_AppendWhere("g.cd_produto in (select mk.cd_produto from promocao_mkt_grupo_produto mk where mk.cd_grupo = " + String(lvl_Grupo)  + ")", 1)
	This.of_AppendWhere("g.cd_produto in (select mk.cd_produto from promocao_mkt_grupo_produto mk where mk.cd_grupo = " + String(lvl_Grupo)  + ")", 2)
End If

If IsNull(lvs_Fornecedor) and IsNull(lvs_Produto) and IsNull(lvl_Grupo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe algum par$$HEX1$$e200$$ENDHEX$$metro para sele$$HEX2$$e700e300$$ENDHEX$$o dos produtos FORNECEDOR/PRODUTO/GRUPO MKT.", Exclamation!)
	dw_1.Event ue_Pos(1, "nm_fantasia")
	Return -1
End If
	
Return This.Retrieve(lvs_UF, ldt_Resumo)
end event

event ue_key;call super::ue_key;If Key = KeyF2! Then
	Event ue_Historico_Preco_Reposicao()
End If

If Key = KeyF3! Then
	Event ue_Historico_Preco_Venda()
End If

If Key = KeyF4! Then
	Event ue_Historico_Desconto()
End If

If Key = KeyF5! Then
	Event ue_Importar_Arquivo()
End If
end event

type dw_3 from dc_uo_dw_base within w_ge369_alteracao_preco_direta
boolean visible = false
integer x = 2853
integer y = 44
integer width = 233
integer height = 76
integer taborder = 70
boolean bringtotop = true
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.Modify("DataWindow.Print.Preview=Yes")
end event

type dw_4 from dc_uo_dw_base within w_ge369_alteracao_preco_direta
integer x = 50
integer y = 1504
integer width = 3136
integer height = 176
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge369_detalhe"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()

end event

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

event ue_key;call super::ue_key;If Key = KeyF2! Then
	Event ue_Historico_Preco_Reposicao()
End If

If Key = KeyF3! Then
	Event ue_Historico_Preco_Venda()
End If

If Key = KeyF4! Then
	Event ue_Historico_Desconto()
End If

If Key = KeyF5! Then
	Event ue_Importar_Arquivo()
End If
end event

type st_1 from statictext within w_ge369_alteracao_preco_direta
integer x = 27
integer y = 1712
integer width = 983
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico de Pre$$HEX1$$e700$$ENDHEX$$os de Reposi$$HEX2$$e700e300$$ENDHEX$$o [F2]"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge369_alteracao_preco_direta
integer x = 1106
integer y = 1712
integer width = 878
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico de Pre$$HEX1$$e700$$ENDHEX$$os de Venda [F3]"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ge369_alteracao_preco_direta
integer x = 2089
integer y = 1712
integer width = 722
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico de Descontos [F4]"
boolean focusrectangle = false
end type

type st_4 from statictext within w_ge369_alteracao_preco_direta
integer x = 2935
integer y = 1712
integer width = 594
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 67108864
string text = "Importar Arquivo [F5]"
boolean focusrectangle = false
end type

