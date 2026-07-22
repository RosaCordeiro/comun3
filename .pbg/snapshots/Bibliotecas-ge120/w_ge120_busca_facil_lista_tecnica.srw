HA$PBExportHeader$w_ge120_busca_facil_lista_tecnica.srw
forward
global type w_ge120_busca_facil_lista_tecnica from dc_w_response
end type
type gb_1 from groupbox within w_ge120_busca_facil_lista_tecnica
end type
type dw_1 from dc_uo_dw_base within w_ge120_busca_facil_lista_tecnica
end type
end forward

global type w_ge120_busca_facil_lista_tecnica from dc_w_response
integer width = 1847
integer height = 1256
string title = "GE120 - Busca F$$HEX1$$e100$$ENDHEX$$cil (Lista T$$HEX1$$e900$$ENDHEX$$cnica)"
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
end type
global w_ge120_busca_facil_lista_tecnica w_ge120_busca_facil_lista_tecnica

type variables
uo_produto ivo_produto

long ivl_produto
end variables

forward prototypes
public subroutine wf_produto ()
public function long wf_saldo_produto (long pl_produto)
public function string wf_concentracao ()
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
where cd_produto = :pl_produto
and cd_filial = 534;

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
	Case '11' 
		lvs_Apresentacao = "C$$HEX1$$c100$$ENDHEX$$PSULA" 
	Case  '01' 
		lvs_Apresentacao = "COMPRIMIDO"
	Case  '12' 
		lvs_Apresentacao = "CREME"
	Case  '10' 
		lvs_Apresentacao = "DR$$HEX1$$c100$$ENDHEX$$GEA"
	Case  '03' 
		lvs_Apresentacao = "GOTA"
	Case  '02' 
		lvs_Apresentacao = "INJET$$HEX1$$c100$$ENDHEX$$VEL"
	Case  '04' 
		lvs_Apresentacao = "L$$HEX1$$cd00$$ENDHEX$$QUIDO"
	Case  '08' 
		lvs_Apresentacao = "LO$$HEX2$$c700c300$$ENDHEX$$O"
	Case  '05' 
		lvs_Apresentacao = "P$$HEX1$$d300$$ENDHEX$$"
	Case  '06' 
		lvs_Apresentacao = "POMADA"
	Case  '09' 
		lvs_Apresentacao = "SABONETE"
	Case  '07' 
		lvs_Apresentacao = "SUPOSIT$$HEX1$$d300$$ENDHEX$$RIO"
	Case  '00' 
		lvs_Apresentacao = "NENHUM"
  End Choose

   lvs_Concentracao = lvs_SubCategoria + " / " + lvs_Apresentacao + " / " + String(ivo_Produto.qt_concentracao) + " (mg)"
End If

If SqlCa.SqlCode = 100 Then
	lvs_Concentracao = ""
End If

Return lvs_Concentracao


end function

on w_ge120_busca_facil_lista_tecnica.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_ge120_busca_facil_lista_tecnica.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;//OverRide

Long lvl_Nulo

pb_Help.Visible = False

ivo_Produto = Create uo_Produto

ivl_Produto = Message.DoubleParm	

ivo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)

If ivo_Produto.Localizado Then
	
	dw_1.Object.st_produto.text = ivo_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(ivo_Produto.cd_produto) + ")"
	dw_1.Event ue_Retrieve()
	
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "GF" Then
		x = 165
		y = 368
	End If
	
	If dw_1.RowCount() = 0 Then
		SetNull(lvl_Nulo)
		CloseWithReturn(This, lvl_Nulo)
	End If
End If



end event

event close;call super::close;Destroy(ivo_Produto)
end event

type pb_help from dc_w_response`pb_help within w_ge120_busca_facil_lista_tecnica
integer y = 1044
end type

type gb_1 from groupbox within w_ge120_busca_facil_lista_tecnica
integer x = 32
integer y = 12
integer width = 1765
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

type dw_1 from dc_uo_dw_base within w_ge120_busca_facil_lista_tecnica
integer x = 64
integer y = 68
integer width = 1710
integer height = 1048
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge120_produtos_busca_facil_lista"
boolean vscrollbar = true
end type

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Linhas, &
     lvl_Produto,&
	 lvl_Linha,&
	 lvl_Nulo

Decimal lvdc_Desconto_SOS
	 
lvl_Linhas = This.RowCount()

If lvl_Linhas > 0 Then
	
	This.of_SetRowSelection("if (id_lei_generico = ~"G~", rgb(255, 255, 0), rgb(255, 255, 255))","")
	
	This.Sort()
	This.GroupCalc()
	
	dw_1.SetFocus()
Else
	MessageBox("Busca F$$HEX1$$e100$$ENDHEX$$cil", "Nenhum produto foi encontrado com o mesmo princ$$HEX1$$ed00$$ENDHEX$$pio ativo e concentra$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
End If

Return lvl_Linhas


end event

event ue_recuperar;// OverRide

Return This.Retrieve(ivo_Produto.cd_produto, ivo_Produto.cd_subcategoria, ivo_Produto.id_apresentacao, ivo_Produto.qt_concentracao)
end event

event rowfocuschanged;call super::rowfocuschanged;/*Decimal lvdc_Nulo
SetNull(lvdc_Nulo)

If CurrentRow > 0 Then
	If This.Object.Pc_Desconto_Negociavel[CurrentRow] > 0 Then
		dw_3.Object.Pc_Desconto   [1] = This.Object.Pc_Desconto_Negociavel[CurrentRow]
		dw_3.Object.Vl_Preco_Final[1] = This.Object.Vl_Preco_Negociavel   [CurrentRow]
	Else
		dw_3.Object.Pc_Desconto   [1] = lvdc_Nulo 
		dw_3.Object.Vl_Preco_Final[1] = lvdc_Nulo 
	End If
	
	If This.Object.Pc_Desconto_SOS[CurrentRow] > 0 Then
		dw_4.Object.Pc_Desconto   [1] = This.Object.Pc_Desconto_SOS[CurrentRow]
		dw_4.Object.Vl_Preco_Final[1] = This.Object.Vl_Preco_SOS   [CurrentRow]
	Else
		dw_4.Object.Pc_Desconto   [1] = lvdc_Nulo
		dw_4.Object.Vl_Preco_Final[1] = lvdc_Nulo
	End If
	
	If This.Object.Pc_Desconto_Clube[CurrentRow] > 0 Then
		dw_2.Object.Pc_Desconto   [1] = This.Object.Pc_Desconto_Clube[CurrentRow]
		dw_2.Object.Vl_Preco_Final[1] = This.Object.Vl_Preco_Clube   [CurrentRow]
	Else
		dw_2.Object.Pc_Desconto   [1] = lvdc_Nulo
		dw_2.Object.Vl_Preco_Final[1] = lvdc_Nulo
	End If
End If*/
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;call super::ue_key;Long lvl_Nulo

SetNull(lvl_Nulo)

If key = KeyEscape! Then
	CloseWithReturn(Parent, lvl_Nulo)
End If

end event

event doubleclicked;call super::doubleclicked;Long lvl_Produto

If This.RowCount() > 0 Then
	lvl_Produto = This.Object.cd_produto[This.GetRow()]
	
	CloseWithReturn(Parent, lvl_Produto)
End If
end event

