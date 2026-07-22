HA$PBExportHeader$w_ge001_busca_facil_lista_tecnica.srw
forward
global type w_ge001_busca_facil_lista_tecnica from dc_w_response
end type
type gb_4 from groupbox within w_ge001_busca_facil_lista_tecnica
end type
type gb_3 from groupbox within w_ge001_busca_facil_lista_tecnica
end type
type gb_2 from groupbox within w_ge001_busca_facil_lista_tecnica
end type
type gb_1 from groupbox within w_ge001_busca_facil_lista_tecnica
end type
type dw_1 from dc_uo_dw_base within w_ge001_busca_facil_lista_tecnica
end type
type dw_2 from dc_uo_dw_base within w_ge001_busca_facil_lista_tecnica
end type
type dw_3 from dc_uo_dw_base within w_ge001_busca_facil_lista_tecnica
end type
type dw_4 from dc_uo_dw_base within w_ge001_busca_facil_lista_tecnica
end type
end forward

global type w_ge001_busca_facil_lista_tecnica from dc_w_response
integer width = 3570
integer height = 1460
string title = "GE001 - Busca F$$HEX1$$e100$$ENDHEX$$cil (Lista T$$HEX1$$e900$$ENDHEX$$cnica)"
long backcolor = 80269524
boolean center = true
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
end type
global w_ge001_busca_facil_lista_tecnica w_ge001_busca_facil_lista_tecnica

type variables
uo_produto ivo_produto

long ivl_produto

Decimal idc_Rentabilidade_Negativa, idc_Rentabilidade_Positiva
end variables

forward prototypes
public subroutine wf_produto ()
public function long wf_saldo_produto (long pl_produto)
public function string wf_concentracao ()
public function decimal wf_custo_gerencial (long pl_produto)
end prototypes

public subroutine wf_produto ();//Integer lvi_Contador
//
//Long lvl_Linha, &
//     lvl_Saldo, &
//	  lvl_Filial, &
//	  lvl_Saldo_Pendente
//
//String lvs_Produto, &
//       lvs_Situacao, &
//	   lvs_Local, &
//	   lvs_Indicador_Comissao
//
//Decimal lvdc_Desconto_SOS
//
//Tab_1.TabPage_1.dw_2.AcceptText()
//
//lvs_Produto = Tab_1.TabPage_1.dw_2.GetText()
//
//ivo_Produto.of_Localiza_Produto(lvs_Produto)
//
//If ivo_Produto.Localizado Then	
//	
//	lvl_Filial = gvo_Parametro.of_Filial()
//	
//	If wf_Existe_Produto_Orcamento () Then
//		Tab_1.TabPage_1.dw_2.Object.De_Produto[Tab_1.TabPage_1.dw_2.GetRow()] = ""
//		Tab_1.TabPage_1.dw_2.SetColumn("de_produto")
//		Return False
//	End If		
//
//	lvl_Saldo   		 = wf_Saldo_Produto(ivo_Produto.Cd_Produto)	
//	lvs_Situacao		 = wf_Verifica_Situacao(ivo_Produto.Cd_Produto)	
//	lvs_Local   		 = wf_Verifica_Local_Estocagem(ivo_Produto.Cd_Produto)
//	
//	lvl_linha = tab_1.tabpage_1.dw_2.GetRow()
//	
//	lvdc_Desconto_SOS = ivo_Produto.of_Desconto_SOS()
//	
//	If lvdc_Desconto_SOS < 0 Then lvdc_Desconto_SOS = 0
//			
//	tab_1.tabpage_1.dw_2.SetReDraw(False)
//	tab_1.tabpage_1.dw_2.Object.cd_produto [lvl_linha] = ivo_produto.cd_produto
//	
//	// Verifica se o produto tem comiss$$HEX1$$e300$$ENDHEX$$o extra
//	If Not wf_Comissao_Extra(Ref lvi_Contador, lvl_Linha) Then Return False
//	
//	tab_1.tabpage_1.dw_2.Object.de_produto 	[lvl_linha] = ivo_produto.ivs_descricao_apresentacao_venda
//	tab_1.tabpage_1.dw_2.Object.qt_orcada	   [lvl_linha] = 1
//	tab_1.tabpage_1.dw_2.Object.qt_estoque	   [lvl_linha] = lvl_Saldo
//	tab_1.tabpage_1.dw_2.Object.id_situacao	[lvl_linha] = lvs_Situacao
//	tab_1.tabpage_1.dw_2.Object.local      	[lvl_linha] = lvs_Local
//	
//	tab_1.tabpage_1.dw_2.Object.vl_preco_unitario[lvl_linha]      = ivo_Produto.of_Preco_Venda_Filial()
//	tab_1.tabpage_1.dw_2.Object.pc_desconto_fixo[lvl_linha]       = ivo_Produto.of_Desconto_Filial()
//	tab_1.tabpage_1.dw_2.Object.pc_desconto_negociavel[lvl_linha] = ivo_Produto.of_Desconto_Negociavel()
//	tab_1.tabpage_1.dw_2.Object.Pc_Desconto_SOS  [lvl_linha]      = lvdc_Desconto_SOS
//	tab_1.tabpage_1.dw_2.Object.Pc_Desconto_Clube[lvl_linha]      = ivo_Produto.of_Desconto_Clube()
//	tab_1.tabpage_1.dw_2.SetReDraw(True)
//	
//	tab_1.tabpage_1.dw_2.SetColumn("qt_orcada")
//	
//	tab_1.tabpage_1.dw_2.Event RowFocusChanged(lvl_linha)
//	
//	If ivs_Controla_Psico = "S" Then
//		If ivb_Lancamento_Psico_Pendente Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Escritura$$HEX2$$e700e300$$ENDHEX$$o de psicotr$$HEX1$$f300$$ENDHEX$$picos pendentes. Favor verificar.",Exclamation!)
//		End If
//		
//		If ivb_Pedido_Pendente Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem pedidos n$$HEX1$$e300$$ENDHEX$$o confirmados a mais de '" + String(ivi_dias_Pedido_Pendente) + "' dias.", Exclamation!)
//		End If
//	End If
//	
//	Return True
//	
//Else
//	tab_1.tabpage_1.dw_2.SetColumn("de_produto")
//	Return False
//End If
//
end subroutine

public function long wf_saldo_produto (long pl_produto);Long lvl_Saldo

Select qt_saldo_final Into :lvl_Saldo
from vw_saldo_atual_produto
where cd_produto = :pl_produto;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvl_Saldo
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo do produto " + String(pl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!)
		Return 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do produto " + String(pl_Produto) + "." + SqlCa.SqlErrText, Information!)		
		Return 0		
End Choose
end function

public function string wf_concentracao ();String lvs_Subcategoria,&
	   lvs_Concentracao,&
	   lvs_Apresentacao

Select de_subcategoria
Into :lvs_SubCategoria
From subcategoria
Where cd_subcategoria = :ivo_Produto.cd_subcategoria
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da SubCategoria")
End If

If SqlCa.SqlCode = 0 Then
	
	Choose Case ivo_Produto.id_apresentacao
		Case '00'
			lvs_Apresentacao = 'NENHUM'
			
		Case '01'
			lvs_Apresentacao = 'COMPRIMIDO'
			
		Case '02'
			lvs_Apresentacao = 'INJETAVEL'
			
		Case '03'
			lvs_Apresentacao = 'GOTAS'
			
		Case '04'
			lvs_Apresentacao = 'LIQUIDO'
			
		Case '05'
			lvs_Apresentacao = 'PO'
			
		Case '06'
			lvs_Apresentacao = 'POMADA'
			
		Case '07'
			lvs_Apresentacao = 'SUPOSITORIO'
			
		Case '08'
			lvs_Apresentacao = 'LOCAO'
			
		Case '09'
			lvs_Apresentacao = 'SABONETE'
			
		Case '10'
			lvs_Apresentacao = 'DRAGEA'
			
		Case '11'
			lvs_Apresentacao = 'CAPSULA'
			
		Case '12'
			lvs_Apresentacao = 'CREME'
			
		Case '13'
			lvs_Apresentacao = 'GEL'
			
		Case '14'
			lvs_Apresentacao = 'ADESIVO'
			
		Case '16'
			lvs_Apresentacao = 'AEROSOL'
			
		Case '17'
			lvs_Apresentacao = 'COLIRIO'
			
		Case '18'
			lvs_Apresentacao = 'CP DISPERSIVEL'
			
		Case '19'
			lvs_Apresentacao = 'CP MASTIGAVEL'
			
		Case '20'
			lvs_Apresentacao = 'CP REVESTIDO'
			
		Case '21'
			lvs_Apresentacao = 'CP SUBILINGUAL'
			
		Case '22'
			lvs_Apresentacao = 'DIU'
			
		Case '23'
			lvs_Apresentacao = 'EFERVESCENTE'
			
		Case '24'
			lvs_Apresentacao = 'ELEXIR'
			
		Case '25'
			lvs_Apresentacao = 'ENEMA'
			
		Case '26'
			lvs_Apresentacao = 'ESMALTE'
			
		Case '27'
			lvs_Apresentacao = 'GEL OFTALMICO'
			
		Case '28'
			lvs_Apresentacao = 'GOMA'
			
		Case '29'
			lvs_Apresentacao = 'IMPLANTE'
			
		Case '30'
			lvs_Apresentacao = 'OVULO'
			
		Case '31'
			lvs_Apresentacao = 'PASTILHA'
			
		Case '32'
			lvs_Apresentacao = 'SHAMPOO'
			
		Case '33'
			lvs_Apresentacao = 'SOLUCAO'
			
		Case '34'
			lvs_Apresentacao = 'SPRAY'
			
		Case '35'
			lvs_Apresentacao = 'CP SUBLINGUAL'
			
		Case '36'
			lvs_Apresentacao = 'CP TAMPONADO'
			
		Case '37'
			lvs_Apresentacao = 'CP VAGINAL'
			
		Case '38'
			lvs_Apresentacao = 'DISPERSIVEL'
			
		Case '39'
			lvs_Apresentacao = 'EFERVECENTE'
			
		Case '40'
			lvs_Apresentacao = 'GELEIA'
			
		Case '41'
			lvs_Apresentacao = 'GLOBULO'
			
		Case '42'
			lvs_Apresentacao = 'PD OFTALMICA'
			
		Case '43'
			lvs_Apresentacao = 'TINTURA'
			
		Case '44'
			lvs_Apresentacao = 'CP EFERVESCENTE'
			
		Case '45'
			lvs_Apresentacao = 'CHA'
			
		Case '46'
			lvs_Apresentacao = 'CANETA'
			
		Case '47'
			lvs_Apresentacao = 'TABLETE'
			
		Case '48'
			lvs_Apresentacao = 'ANEL'
			
		Case '49'
			lvs_Apresentacao = 'CR VAGINAL'
			
		Case '50'
			lvs_Apresentacao = 'XAROPE'
			
		Case '51'
			lvs_Apresentacao = 'INALADOR'
	End Choose

   lvs_Concentracao = lvs_SubCategoria + " / " + lvs_Apresentacao + " / " + String(ivo_Produto.qt_concentracao) + " (mg)"
End If

If SqlCa.SqlCode = 100 Then
	lvs_Concentracao = ""
End If

Return lvs_Concentracao


end function

public function decimal wf_custo_gerencial (long pl_produto);Decimal {2} lvd_custo

Select COALESCE(vl_custo_gerencial,0) Into :lvd_custo
from vw_saldo_atual_produto
where cd_produto = :pl_produto;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvd_custo
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo do produto " + String(pl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!)
		Return 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do produto " + String(pl_Produto) + "." + SqlCa.SqlErrText, Information!)		
		Return 0		
End Choose
end function

on w_ge001_busca_facil_lista_tecnica.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_4
end on

on w_ge001_busca_facil_lista_tecnica.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
end on

event open;Long lvl_Nulo

ivo_Produto = Create uo_Produto

ivl_Produto = Message.DoubleParm	

ivo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)

If ivo_Produto.Localizado Then
	
//	//Produtos que n$$HEX1$$e300$$ENDHEX$$o foram preenchidos tipo apresentacao e a concentracao nao devem ser mostrados em tela
//	If ( IsNull( ivo_Produto.id_apresentacao ) Or ivo_Produto.id_apresentacao = "00" Or Trim(ivo_Produto.id_apresentacao) = '' ) OR ( IsNull(ivo_Produto.qt_concentracao) Or ivo_Produto.qt_concentracao = 0 ) Then
//		
//		MessageBox("Busca F$$HEX1$$e100$$ENDHEX$$cil", "Nenhum produto foi encontrado com o mesmo princ$$HEX1$$ed00$$ENDHEX$$pio ativo e concentra$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
//		
//		SetNull(lvl_Nulo)
//		Return CloseWithReturn(This, lvl_Nulo)
//		
//	End If	

	If (ivo_Produto.ivl_Filial_Parametro <> ivo_Produto.ivl_Filial_Matriz) Then		
		uo_Parametro_Filial lvo_Parametro
		lvo_Parametro = Create uo_Parametro_Filial
		
		lvo_parametro.of_localiza_parametro( 'PC_RENTABILIDADE_NEGATIVA_ATENDIMENTO', ref idc_Rentabilidade_Negativa)
		lvo_parametro.of_localiza_parametro( 'PC_RENTABILIDADE_POSITIVA_ATENDIMENTO',  ref idc_Rentabilidade_Positiva)	
		
		Destroy(lvo_parametro)		
	End If
	
	dw_1.Object.st_produto.text = ivo_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(ivo_Produto.cd_produto) + ")"
	dw_1.Event ue_Retrieve()
	
//	x = 115
//	y = 368
	
	If dw_1.RowCount() = 0 Then
		SetNull(lvl_Nulo)
		CloseWithReturn(This, lvl_Nulo)
	End If
End If




end event

event close;call super::close;Destroy(ivo_Produto)
end event

type pb_help from dc_w_response`pb_help within w_ge001_busca_facil_lista_tecnica
integer x = 91
integer y = 164
end type

type gb_4 from groupbox within w_ge001_busca_facil_lista_tecnica
integer x = 2441
integer y = 1168
integer width = 1097
integer height = 180
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Desconto SOS"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge001_busca_facil_lista_tecnica
integer x = 1230
integer y = 1168
integer width = 1111
integer height = 180
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Prestes $$HEX1$$e000$$ENDHEX$$ Vencer"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge001_busca_facil_lista_tecnica
integer x = 27
integer y = 1168
integer width = 1106
integer height = 180
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Desconto Clube"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge001_busca_facil_lista_tecnica
integer x = 23
integer y = 12
integer width = 3520
integer height = 1132
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge001_busca_facil_lista_tecnica
integer x = 55
integer y = 68
integer width = 3461
integer height = 1040
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge001_produtos_busca_facil_lista"
boolean vscrollbar = true
end type

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Linhas, &
     lvl_Produto,&
	 lvl_Linha,&
	 lvl_Nulo

Decimal lvdc_Desc_SOS
Decimal ldc_rentabilidade
Decimal ldc_vl_rentabilidade
Decimal ldc_preco_liquido
	 
lvl_Linhas = This.RowCount()

If lvl_Linhas > 0 Then

	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Produto = This.Object.cd_produto[lvl_Linha]
		
		ivo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
		
		If ivo_Produto.Localizado Then
			
//			If lvl_Linha = 1 Then
//				gb_1.text = wf_Concentracao()
//			End If
			
			This.Object.vl_preco_unitario			[lvl_Linha] = ivo_Produto.of_Preco_Venda_Filial()
			This.Object.pc_desconto_fixo			[lvl_Linha] = ivo_Produto.of_Desconto_Filial()
			This.Object.pc_desconto_negociavel	[lvl_Linha] = ivo_Produto.of_Desconto_Negociavel()
			This.Object.Pc_Desconto_Clube		[lvl_Linha] = ivo_Produto.of_Desconto_Clube()
			This.Object.qt_saldo			  			[lvl_Linha] = wf_Saldo_Produto(ivo_Produto.cd_produto)
			This.Object.pc_desconto_prestes		[lvl_Linha] = ivo_produto.Of_Desconto_Prestes()
			This.Object.nr_etiqueta_preste			[lvl_Linha] = ivo_produto.nr_etiqueta_preste
			This.Object.vl_custo_gerencial 			[lvl_Linha] = wf_custo_gerencial(ivo_Produto.cd_produto)
			
			// Desconto SOS
			lvdc_Desc_SOS = ivo_Produto.of_Desconto_SOS()
			If lvdc_Desc_SOS < 0 Then lvdc_Desc_SOS = 0
			This.Object.Pc_Desconto_SOS	[lvl_Linha] = lvdc_Desc_SOS
			
			If (ivo_Produto.ivl_Filial_Parametro <> ivo_Produto.ivl_Filial_Matriz) Then			
				If This.Object.vl_custo_gerencial[lvl_Linha] > 0 And (This.Object.qt_saldo[lvl_Linha] > 0 ) Then
					ldc_preco_liquido = round(This.Object.vl_preco_unitario[lvl_Linha] * ((100 - This.Object.pc_desconto_fixo[lvl_Linha]) / 100),2)
					ldc_rentabilidade = Round((((ldc_Preco_Liquido - This.Object.vl_custo_gerencial[lvl_Linha] ) / ldc_Preco_Liquido ) * 100 ),2)
			
					This.Object.vl_rentabilidade	[lvl_Linha] = Round((ldc_Preco_Liquido - This.Object.vl_custo_gerencial[lvl_Linha] ),2)
					This.Object.pc_rentabilidade	[lvl_Linha] = ldc_rentabilidade
							
					If ldc_rentabilidade >= idc_Rentabilidade_Positiva AND ldc_rentabilidade > idc_Rentabilidade_Negativa Then
						This.Object.id_positivo[lvl_Linha] = IIF(idc_Rentabilidade_Positiva > 0, 'S', 'N')
					ElseIF ldc_rentabilidade <= idc_Rentabilidade_Negativa Then
						This.Object.id_negativo[lvl_Linha] = IIF(idc_Rentabilidade_Negativa > 0, 'S', 'N')
					Else 
						This.Object.id_positivo	[lvl_Linha] = 'N'
						This.Object.id_negativo	[lvl_Linha] = 'N'
					End If
				End If			
			End If			
		End If
	Next
	
	This.of_SetRowSelection("if (id_lei_generico = ~"G~", rgb(255, 255, 0), if (id_lei_generico = ~"E~", rgb(135, 206, 235), rgb(255, 255, 255)))","")

	If (ivo_Produto.ivl_Filial_Parametro <> ivo_Produto.ivl_Filial_Matriz) Then			
		This.SetSort( "grupo a, vl_rentabilidade d, qt_saldo d" )	
	End If
	
	This.Sort()
	This.GroupCalc()
	
	dw_1.SetFocus()
Else
	MessageBox("Busca F$$HEX1$$e100$$ENDHEX$$cil", "Nenhum produto foi encontrado com o mesmo princ$$HEX1$$ed00$$ENDHEX$$pio ativo e concentra$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
End If

Return lvl_Linhas


end event

event ue_recuperar;// OverRide
Long ll_Retorno

//ll_Retorno = This.Retrieve(ivo_Produto.cd_produto, ivo_Produto.cd_subcategoria, ivo_Produto.id_apresentacao, ivo_Produto.qt_concentracao)
ll_Retorno = This.Retrieve(ivo_Produto.cd_produto)

Return ll_Retorno
end event

event rowfocuschanged;call super::rowfocuschanged;Decimal lvdc_Nulo
SetNull(lvdc_Nulo)

If CurrentRow > 0 Then
	If This.Object.Pc_Desconto_Prestes[CurrentRow] > 0 Then
		dw_3.Object.Pc_Desconto   [1] = This.Object.Pc_Desconto_Prestes	[CurrentRow]
		dw_3.Object.Vl_Preco_Final[1] = This.Object.Vl_Preco_prestes		[CurrentRow]
	Else
		dw_3.Object.Pc_Desconto   [1] = lvdc_Nulo 
		dw_3.Object.Vl_Preco_Final[1] = lvdc_Nulo 
	End If
	
	If This.Object.Pc_Desconto_SOS[CurrentRow] > 0 Then
		dw_4.Object.Pc_Desconto   [1] = This.Object.Pc_Desconto_SOS	[CurrentRow]
		dw_4.Object.Vl_Preco_Final[1] = This.Object.Vl_Preco_SOS   		[CurrentRow]
	Else
		dw_4.Object.Pc_Desconto   [1] = lvdc_Nulo
		dw_4.Object.Vl_Preco_Final[1] = lvdc_Nulo
	End If
	
	If This.Object.Pc_Desconto_Clube[CurrentRow] > 0 Then
		dw_2.Object.Pc_Desconto   [1] = This.Object.Pc_Desconto_Clube	[CurrentRow]
		dw_2.Object.Vl_Preco_Final[1] = This.Object.Vl_Preco_Clube		[CurrentRow]
	Else
		dw_2.Object.Pc_Desconto   [1] = lvdc_Nulo
		dw_2.Object.Vl_Preco_Final[1] = lvdc_Nulo
	End If
End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;call super::ue_key;Long lvl_Retorno

SetNull(lvl_Retorno)

If key = KeyEscape! Then
	CloseWithReturn(Parent, lvl_Retorno)
End If

If key = KeyEnter! Then
	If This.RowCount() > 0 Then
		lvl_Retorno = This.Object.cd_produto[This.GetRow()]
		
		CloseWithReturn(Parent, lvl_Retorno)
	End If
End If
end event

event doubleclicked;call super::doubleclicked;Long lvl_Produto

If This.RowCount() > 0 Then
	lvl_Produto = This.Object.cd_produto[This.GetRow()]
	
	CloseWithReturn(Parent, lvl_Produto)
End If


end event

type dw_2 from dc_uo_dw_base within w_ge001_busca_facil_lista_tecnica
integer x = 55
integer y = 1232
integer width = 1061
integer height = 96
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge001_desconto_negociavel_nova"
end type

event ue_key;call super::ue_key;Long lvl_Nulo

SetNull(lvl_Nulo)

If key = KeyEscape! Then
	CloseWithReturn(Parent, lvl_Nulo)
End If
end event

type dw_3 from dc_uo_dw_base within w_ge001_busca_facil_lista_tecnica
integer x = 1257
integer y = 1236
integer width = 1065
integer height = 96
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge001_desconto_negociavel_nova"
end type

event ue_key;call super::ue_key;Long lvl_Nulo

SetNull(lvl_Nulo)

If key = KeyEscape! Then
	CloseWithReturn(Parent, lvl_Nulo)
End If
end event

type dw_4 from dc_uo_dw_base within w_ge001_busca_facil_lista_tecnica
integer x = 2464
integer y = 1232
integer width = 1051
integer height = 104
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge001_desconto_negociavel_nova"
end type

event ue_key;call super::ue_key;Long lvl_Nulo

SetNull(lvl_Nulo)

If key = KeyEscape! Then
	CloseWithReturn(Parent, lvl_Nulo)
End If
end event

