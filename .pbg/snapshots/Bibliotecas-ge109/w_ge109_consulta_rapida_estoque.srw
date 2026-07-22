HA$PBExportHeader$w_ge109_consulta_rapida_estoque.srw
forward
global type w_ge109_consulta_rapida_estoque from dc_w_selecao_lista_relatorio
end type
type gb_4 from groupbox within w_ge109_consulta_rapida_estoque
end type
type dw_4 from dc_uo_dw_base within w_ge109_consulta_rapida_estoque
end type
end forward

global type w_ge109_consulta_rapida_estoque from dc_w_selecao_lista_relatorio
integer width = 3557
integer height = 1832
string title = "GE109 - Consulta R$$HEX1$$e100$$ENDHEX$$pida de Estoque"
long backcolor = 80269524
gb_4 gb_4
dw_4 dw_4
end type
global w_ge109_consulta_rapida_estoque w_ge109_consulta_rapida_estoque

type variables
uo_produto ivo_produto
end variables

forward prototypes
public subroutine wf_atualiza_preco_final ()
end prototypes

public subroutine wf_atualiza_preco_final ();Long lvl_Linhas, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Filial
	  
Decimal lvdc_Desconto_SOS

uo_Produto lvo_Produto
lvo_Produto = Create uo_Produto

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Verificando Pre$$HEX1$$e700$$ENDHEX$$os e Descontos..."

lvl_Linhas = dw_2.RowCount()
w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)

lvl_Filial = gvo_Parametro.of_Filial()

For lvl_Contador = 1 To lvl_Linhas
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Contador]	
	
	lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
	
	If lvo_Produto.Localizado Then
		lvdc_Desconto_SOS = lvo_Produto.of_Desconto_SOS()
		
		If lvdc_Desconto_SOS < 0 Then lvdc_Desconto_SOS = 0
		
		dw_2.Object.Vl_Preco_Tabela				[lvl_Contador] = lvo_Produto.of_Preco_Venda_Filial()
		dw_2.Object.Pc_Desconto_Fixo				[lvl_Contador] = lvo_Produto.of_Desconto_Filial()
		dw_2.Object.Pc_Desconto_Negociavel	[lvl_Contador] = lvo_Produto.of_Desconto_Negociavel()
		dw_2.Object.Pc_Desconto_SOS			[lvl_Contador] = lvdc_Desconto_SOS
		dw_2.Object.Pc_Desconto_Clube_Atual	[lvl_Contador] = lvo_Produto.of_Desconto_Clube()
		
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next

Destroy(lvo_Produto)

Close(w_Aguarde)
SetPointer(Arrow!)
end subroutine

on w_ge109_consulta_rapida_estoque.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
end on

on w_ge109_consulta_rapida_estoque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_4)
destroy(this.dw_4)
end on

event ue_postopen;call super::ue_postopen;dw_4.InsertRow(0)

ivo_Produto = Create uo_Produto

ivo_Produto.ivb_nao_liberado_filial = False
end event

event key;If Key = KeyF4! Then
	Open(w_ge107_consulta_posicao_desconto)
End If

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge109_consulta_rapida_estoque
integer y = 1848
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge109_consulta_rapida_estoque
integer y = 1776
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge109_consulta_rapida_estoque
integer x = 18
integer y = 252
integer width = 3483
integer height = 1112
string text = "Lista de Produtos"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge109_consulta_rapida_estoque
integer x = 18
integer y = 0
integer width = 1691
integer height = 240
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge109_consulta_rapida_estoque
integer x = 46
integer y = 56
integer width = 1614
integer height = 172
string dataobject = "dw_selecao_consulta_rapida_estoque"
end type

event dw_1::ue_key;String  lvs_Coluna, &
        lvs_Produto

Choose Case Key
	Case KeyEnter!
		lvs_Coluna = This.GetColumnName()
		
		If lvs_Coluna = "nm_produto" Then
			This.AcceptText()
			lvs_Produto = This.Object.nm_produto[1]
			
			If Not IsNull(lvs_Produto) Then
				dw_2.Event ue_Retrieve()
			End If	
		End If
		
	Case KeyF4!
		//Open(w_ge107_consulta_posicao_desconto)
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge109_consulta_rapida_estoque
integer x = 46
integer y = 308
integer width = 3433
integer height = 1040
integer taborder = 0
string dataobject = "dw_lista_consulta_rapida_estoque"
boolean ivb_ordena_colunas = true
end type

event dw_2::rowfocuschanged;call super::rowfocuschanged;Decimal lvdc_Nulo

SetNull(lvdc_Nulo)

If CurrentRow > 0 Then
	If This.Object.Pc_Desconto_Negociavel[CurrentRow] > 0 Then
		dw_4.Object.Pc_Desconto_Fixo   [1] = This.Object.Pc_Desconto_Negociavel[CurrentRow]
		dw_4.Object.Vl_Preco_Final_Fixo[1] = This.Object.Vl_Preco_Negociavel[CurrentRow]
	Else
		dw_4.Object.Pc_Desconto_Fixo   [1] = lvdc_Nulo //This.Object.Pc_Desconto_Fixo[CurrentRow]
		dw_4.Object.Vl_Preco_Final_Fixo[1] = lvdc_Nulo //This.Object.Vl_Preco_Venda_Final[CurrentRow]
	End If
	
	If This.Object.Pc_Desconto_SOS[CurrentRow] > 0 Then
		dw_4.Object.Pc_Desconto_Sos   [1] = This.Object.Pc_Desconto_SOS[CurrentRow]
		dw_4.Object.Vl_Preco_Final_Sos[1] = This.Object.Vl_Preco_SOS[CurrentRow]
	Else
		dw_4.Object.Pc_Desconto_Sos   [1] = lvdc_Nulo
		dw_4.Object.Vl_Preco_Final_Sos[1] = lvdc_Nulo
	End If
	
	If This.Object.Pc_Desconto_Clube_Atual[CurrentRow] > 0 Then
		dw_4.Object.Pc_Desconto_Clube   [1] = This.Object.Pc_Desconto_Clube_Atual[CurrentRow]
		dw_4.Object.Vl_Preco_Final_Clube[1] = This.Object.Vl_Preco_Clube_Atual[CurrentRow]
	Else
		dw_4.Object.Pc_Desconto_Clube   [1] = lvdc_Nulo
		dw_4.Object.Vl_Preco_Final_Clube[1] = lvdc_Nulo
	End If
	
End If
end event

event dw_2::ue_key;//Long lvl_Produto, &
//     lvl_Linha
//	  
//Decimal lvdc_Desconto
//
//Choose Case Key
//	Case KeyF4!
//		Open(w_ge107_consulta_posicao_desconto)
//		
//	Case KeyF7!
//		lvl_Linha = This.GetRow()
//		
//		If lvl_Linha > 0 Then
//			uo_Produto lvo_Produto
//			lvo_Produto = Create uo_Produto
//			
//			lvl_Produto = This.Object.Cd_Produto[lvl_Linha]
//		
//			lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
//			
//			If lvo_Produto.Localizado Then
//				If lvo_Produto.of_Tem_Desconto_Negociavel() Then
//					lvdc_Desconto = lvo_Produto.of_Desconto_Negociado()			
//					
//					If lvdc_Desconto > 0 Then
//						This.Object.Pc_Desconto_Fixo[lvl_Linha] = lvdc_Desconto
//					End If
//				Else
//					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o possui desconto negoci$$HEX1$$e100$$ENDHEX$$vel.", Information!)
//				End If
//			End If
//			
//			Destroy(lvo_Produto)
//		End If
//End Choose
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If AncestorReturnValue = -1 Then Return -1

dw_4.Reset()
dw_4.InsertRow(0)

If AncestorReturnValue > 0 Then
	wf_Atualiza_Preco_Final()
	This.Event RowFocusChanged(1)	
End If

Return AncestorReturnValue
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	lvs_Produto, &
		lvs_Produto_Busca, &
		lvs_Ativos
		 
Integer lvi_Tamanho

dw_1.AcceptText()

lvs_Produto = dw_1.Object.Nm_Produto[1]
lvs_Ativos  = dw_1.Object.Id_Ativos [1]

lvs_Produto = Trim(lvs_Produto)

lvi_Tamanho = LenA(lvs_Produto)

ivo_Produto.of_inicializa()

If lvi_Tamanho > 0 Then
	If IsNumber(lvs_Produto) Then
		ivo_Produto.of_localiza_produto(lvs_Produto)
		
		If ivo_Produto.Localizado Then
			This.of_AppendWhere_SubQuery("pg.cd_produto = " + String(ivo_Produto.cd_Produto), 2)
			dw_1.Object.nm_produto[1] = String(ivo_Produto.cd_Produto)
		Else
			Return -1
		End If
	Else
		If LeftA(lvs_Produto, 1) = "+" Then
			// A primeira posi$$HEX2$$e700e300$$ENDHEX$$o "+" identifica c$$HEX1$$f300$$ENDHEX$$digos de barras de produtos importados
			This.of_AppendWhere_SubQuery("pg.cd_produto in (select cd_produto from codigo_barras_produto where de_codigo_barras = '" + lvs_Produto + "')", 2)
		Else
			lvs_Produto_Busca = lvs_Produto
	
			If LeftA( lvs_Produto, 2 ) = 'ZZ' Then
				lvs_Produto_Busca = MidA( lvs_Produto, 3 )
			End If
			
			If LeftA( lvs_Produto, 3 ) = '%ZZ' Then
				This.of_AppendWhere_SubQuery("( pg.de_produto like '%" + MidA( lvs_Produto, 4 ) + "%' Or pg.de_produto like '%ZZ" + MidA( lvs_Produto, 4 ) + "%' Or pg.de_produto_metaphone like '%' || dbo.uf_metaphone( '" + MidA( lvs_Produto, 4 ) + "' ) || '%' Or pg.de_produto_metaphone like '%ZZ' || dbo.uf_metaphone( '" + MidA( lvs_Produto, 4 ) + "' ) || '%' )", 2)
			Else
				This.of_AppendWhere_SubQuery("( pg.de_produto like '" + lvs_Produto_Busca + "%' Or pg.de_produto like 'ZZ" + lvs_Produto_Busca + "%' Or pg.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Produto_Busca + "' ) || '%' Or pg.de_produto_metaphone like dbo.uf_metaphone( 'ZZ" + lvs_Produto_Busca + "' ) || '%' )", 2)		
			End If
		
		End If		
		
		This.of_AppendWhere_SubQuery("pg.id_liberado_filial = 'S'", 2)
		
		This.of_AppendWhere_SubQuery("not exists (Select 1 From parametro_loja Where cd_parametro = 'CD_CATEGORIA_PRD_MOVIMENTACAO_BLOQUEADA' and vl_parametro like  '%' + substring(pg.cd_subcategoria, 1,6) + '%')", 2)
	End If	
	
	If lvs_Ativos = "S" Then
		This.of_AppendWhere_SubQuery("pl.id_situacao = 'A'", 2)
	End If
	
	Return 1
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o dos produtos.", Information!)
	Return -1
End If	
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("", "if(id_situacao = ~"A~", rgb(0,0,0), if(id_situacao = ~"P~", rgb(0,128,0), rgb(255, 0,0)))")
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge109_consulta_rapida_estoque
integer x = 2939
integer y = 1248
integer height = 160
end type

type gb_4 from groupbox within w_ge109_consulta_rapida_estoque
integer x = 18
integer y = 1380
integer width = 3483
integer height = 252
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Descontos"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within w_ge109_consulta_rapida_estoque
integer x = 50
integer y = 1432
integer width = 3415
integer height = 184
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_rapida_estoque_desconto_negociavel"
end type

