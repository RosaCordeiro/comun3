HA$PBExportHeader$w_ge110_lancamento_lote.srw
forward
global type w_ge110_lancamento_lote from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge110_lancamento_lote
end type
end forward

global type w_ge110_lancamento_lote from dc_w_cadastro_selecao_lista
integer width = 2830
cb_1 cb_1
end type
global w_ge110_lancamento_lote w_ge110_lancamento_lote

on w_ge110_lancamento_lote.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge110_lancamento_lote.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge110_lancamento_lote
integer x = 55
integer y = 64
integer width = 1385
integer height = 264
string dataobject = "dw_ge110_selecao"
end type

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge110_lancamento_lote
integer x = 27
integer y = 368
integer width = 2651
integer height = 1084
integer weight = 700
fontcharset fontcharset = ansi!
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge110_lancamento_lote
integer x = 27
integer width = 1422
integer height = 352
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge110_lancamento_lote
integer x = 64
integer y = 428
integer width = 2592
integer height = 996
string dataobject = "dw_ge110_devolucao_compra"
end type

event dw_2::ue_recuperar;//OverRide
Long ll_Nota

String ls_Especie
String ls_Serie

dw_1.AcceptText()

ll_Nota		 = dw_1.Object.Nr_Nf			[1]
ls_Especie	 = dw_1.Object.De_Especie	[1]
ls_Serie		 = dw_1.Object.De_Serie	[1]

Return This.Retrieve( gvo_Parametro.Cd_Filial, ll_Nota, ls_Especie, ls_Serie )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long ll_Linha
Long ll_Devolucao
Long ll_Compra

For ll_Linha = 1 To pl_Linhas
	ll_Devolucao	=	This.Object.Qt_Devolucao	[ ll_Linha ]
	ll_Compra	=	This.Object.Qt_Compra		[ ll_Linha ]
	
	If ll_Devolucao <> ll_Compra Then
		This.Object.Protege[ ll_Linha ] = 'N'
	End If
Next

Return pl_Linhas
end event

type cb_1 from commandbutton within w_ge110_lancamento_lote
integer x = 1522
integer y = 96
integer width = 393
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;Long	ll_Linha, &
		ll_Linhas, &
		ll_Devolucao, &
		ll_Produto, &
		ll_Produto_Aux, &
		ll_Total_Devolvendo, &
		ll_Filial, &
		ll_Nota, &
		ll_Natureza, &
		ll_Lote

String	ls_Produto, &
		ls_Especie, &
		ls_Serie, &
		ls_Lote

ll_Linhas = dw_2.RowCount()

If ll_Linhas > 0 Then
	ll_Produto 				= dw_2.Object.Cd_Produto[ 1 ]
	ll_Produto_Aux 			= ll_Produto
	ll_Total_Devolvendo	= 0
	
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_Produto	= dw_2.Object.Cd_Produto	[ ll_Linha ]
		ll_Devolucao	= dw_2.Object.Qt_Lote		[ ll_Linha ]
		
		If dw_2.Object.Id_Selecao[ ll_Linha ] = 'N' Then Continue
		
		If ll_Produto_Aux <> ll_Produto Then
			ll_Produto_Aux = dw_2.Object.Cd_Produto		[ ll_Linha ]
			ll_Devolucao 	= dw_2.Object.Qt_Devolucao	[ ll_Linha -1 ]
			
			If ll_Total_Devolvendo <> ll_Devolucao Then
				ls_Produto = dw_2.Object.Desc_Produto[ ll_Linha -1 ]
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade dos lotes do produto " + ls_Produto + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ de acordo com a quantidade devolvida na nota fiscal.", StopSign! )
				Return -1
			End If
			
			ll_Total_Devolvendo = 0
		End If
		
		ll_Total_Devolvendo += ll_Devolucao
	Next
	
	ll_Produto 		= dw_2.Object.Cd_Produto[ 1 ]
	ll_Produto_Aux 	= ll_Produto
	
	For ll_Linha = 1 To ll_Linhas
		If dw_2.Object.Id_Selecao[ ll_Linha ] = 'N' Then Continue
		
		If ll_Linha = 1 Or ll_Produto <> ll_Produto_Aux Then
			ll_Filial		= dw_2.Object.Cd_Filial						[ ll_Linha ]
			ll_Nota		= dw_2.Object.Nr_Nf							[ ll_Linha ]
			ls_Especie	= dw_2.Object.De_Especie					[ ll_Linha ]
			ls_Serie		= dw_2.Object.De_Serie						[ ll_Linha ]
			ll_Produto	= dw_2.Object.Cd_Produto					[ ll_Linha ]
			ll_Natureza	= dw_2.Object.Cd_Natureza_Operacao	[ ll_Linha ]
			
			ll_Produto_Aux = ll_Produto
			
			Delete
			  From item_nf_compra_lote
			Where cd_filial 						= :ll_Filial
				And nr_nf						= :ll_Nota
				And de_especie				= :ls_Especie
				And de_serie					= :ls_Serie
				And cd_natureza_operacao	= :ll_Natureza
				And cd_produto				= :ll_Produto
			  Using SqlCa;
			  
			 Choose Case SqlCa.SqlCode
				Case -1
					SqlCa.of_MsgDbError( "Exclus$$HEX1$$e300$$ENDHEX$$o dos lotes da nota de devolu$$HEX2$$e700e300$$ENDHEX$$o" )
					SqlCa.of_RollBack()
					Return -1
			 End Choose
		End If
		
		ls_Lote	= dw_2.Object.Nr_Lote[ ll_Linha ]
		ll_Lote	= dw_2.Object.Qt_Lote[ ll_Linha ]
		
		Insert
		  Into item_nf_compra_lote (
		  			cd_filial,
					nr_nf,
					de_especie,
					de_serie,
					cd_natureza_operacao,
					cd_produto,
					nr_lote,
					qt_lote )
				Values (
					:ll_Filial,
					:ll_Nota,
					:ls_Especie,
					:ls_Serie,
					:ll_Natureza,
					:ll_Produto,
					:ls_Lote,
					:ll_Lote )
			Using SqlCa;
			  
		 Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_MsgDbError( "Inclus$$HEX1$$e300$$ENDHEX$$o dos lotes da nota de devolu$$HEX2$$e700e300$$ENDHEX$$o" )
				SqlCa.of_RollBack()
				Return -1
		 End Choose
	Next
	
	SqlCa.of_Commit()
End If
end event

