HA$PBExportHeader$w_ge478_promocoes_pbm_clamed.srw
forward
global type w_ge478_promocoes_pbm_clamed from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge478_promocoes_pbm_clamed from dc_w_selecao_lista_relatorio
string accessiblename = "Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos com benef$$HEX1$$ed00$$ENDHEX$$cio PBM CLAMED (GE478)"
integer width = 3584
integer height = 1884
string title = "GE478 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos com benef$$HEX1$$ed00$$ENDHEX$$cio PBM CLAMED"
boolean maxbox = true
end type
global w_ge478_promocoes_pbm_clamed w_ge478_promocoes_pbm_clamed

type variables
uo_produto ivo_produto
end variables

forward prototypes
public subroutine wf_localiza_produto ()
end prototypes

public subroutine wf_localiza_produto ();String lvs_Produto

lvs_Produto = dw_1.GetText()

ivo_Produto.Of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
Else
	Long lvl_Nulo	
	SetNull(lvl_Nulo)	
	dw_1.Object.cd_produto[1] = lvl_Nulo
	dw_1.Object.de_produto[1] = ''	
End If
end subroutine

on w_ge478_promocoes_pbm_clamed.create
call super::create
end on

on w_ge478_promocoes_pbm_clamed.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy ivo_Produto
end event

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto

//ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_printimmediate;//OverRide
dw_2.Event ue_imprimir_relatorio( dw_2.Title, '', True )
end event

event ue_print;//OverRide
dw_2.Event ue_imprimir_relatorio( dw_2.Title, '', False )
end event

event open;call super::open;This.maxheight = 9000
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge478_promocoes_pbm_clamed
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge478_promocoes_pbm_clamed
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge478_promocoes_pbm_clamed
integer y = 192
integer width = 3483
integer height = 1492
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge478_promocoes_pbm_clamed
integer width = 3483
integer height = 168
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge478_promocoes_pbm_clamed
integer x = 69
integer y = 64
integer width = 3442
integer height = 92
string dataobject = "dw_ge478_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

Choose Case dwo.Name 
	Case "de_produto"
	
		SetNull(lvl_Nulo)
	
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Produto[1] = lvl_nulo
			ivo_Produto.of_Inicializa()
			Return 0
		End If	
		
		If Data <> ivo_Produto.De_Produto Then Return 1
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		wf_Localiza_Produto()
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge478_promocoes_pbm_clamed
integer x = 55
integer y = 244
integer width = 3451
integer height = 1424
string title = "GE478 - Produtos com benef$$HEX1$$ed00$$ENDHEX$$cio PBM CLAMED"
string dataobject = "dw_ge478_lista"
end type

event dw_2::constructor;call super::constructor;This.ivb_ordena_colunas = True
end event

event dw_2::ue_key;call super::ue_key;Long ll_linha, ll_produto

Choose Case Key
	Case KeyF5!
		ll_Linha = This.GetRow()		
		If ll_Linha > 0 Then		
			ll_Produto = This.Object.cd_produto[ ll_Linha ]
			
			If Not IsNull(ll_Produto) Then
				OpenWithParm( w_ge478_pbm_clamed, '0|C|'+String(ll_Produto) )
			End If
		End If
End Choose

end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_produto

dw_1.AcceptText()

lvl_produto = dw_1.Object.Cd_Produto	[1]

If Not IsNull(lvl_produto) And lvl_produto > 0 Then
	This.Of_AppendWhere("g.cd_produto = " + String(lvl_produto))
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge478_promocoes_pbm_clamed
integer x = 2277
integer y = 896
end type

