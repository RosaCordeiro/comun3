HA$PBExportHeader$w_ge585_promocao.srw
forward
global type w_ge585_promocao from dc_w_sheet
end type
type dw_4 from dc_uo_dw_base within w_ge585_promocao
end type
type cbx_1 from checkbox within w_ge585_promocao
end type
type dw_3 from dc_uo_dw_base within w_ge585_promocao
end type
type pb_localiza from picturebutton within w_ge585_promocao
end type
type cb_copia_promocao from commandbutton within w_ge585_promocao
end type
type cb_selecao_produtos from commandbutton within w_ge585_promocao
end type
type dw_2 from dc_uo_dw_base within w_ge585_promocao
end type
type dw_1 from dc_uo_dw_base within w_ge585_promocao
end type
type gb_1 from groupbox within w_ge585_promocao
end type
type gb_2 from groupbox within w_ge585_promocao
end type
type gb_3 from groupbox within w_ge585_promocao
end type
type gb_4 from groupbox within w_ge585_promocao
end type
type gb_5 from groupbox within w_ge585_promocao
end type
end forward

global type w_ge585_promocao from dc_w_sheet
integer width = 3909
integer height = 2092
string title = "GE585 - Promo$$HEX2$$e700f500$$ENDHEX$$es do Ecommerce"
dw_4 dw_4
cbx_1 cbx_1
dw_3 dw_3
pb_localiza pb_localiza
cb_copia_promocao cb_copia_promocao
cb_selecao_produtos cb_selecao_produtos
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
end type
global w_ge585_promocao w_ge585_promocao

type variables
dc_uo_ds_base ids

uo_promocao ivo_promocao
uo_produto ivo_produto

Long ivl_linhas
Long ivl_filial_ecommerce

String ivs_Operador
end variables

forward prototypes
public function boolean wf_proxima_promocao (ref long al_promocao)
public subroutine wf_atualiza_valores ()
public subroutine wf_copia_promocao ()
public function boolean wf_copia_produto (long al_promocao, ref long al_alteracao)
public subroutine wf_atualiza_valor (long al_linha)
public subroutine wf_exclui_linha ()
public function boolean wf_valida_informacoes ()
public function boolean wf_localiza_filial_ecommerce ()
public function boolean wf_localiza_promocao_ecommerce (long al_linha)
protected subroutine wf_inclui_filial_ecommerce_promocao ()
public function boolean wf_valida_produto (string as_rede)
public function decimal wf_custo_produto (long al_produto, long al_filial_base)
public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto, string as_rede)
public function decimal wf_impostos_produto (long al_produto, string as_rede)
public function boolean wf_localiza_produto (string as_parametro, string as_rede)
end prototypes

public function boolean wf_proxima_promocao (ref long al_promocao);Select max(cd_promocao_sos) Into :al_Promocao
From promocao_sos
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da pr$$HEX1$$f300$$ENDHEX$$xima promo$$HEX2$$e700e300$$ENDHEX$$o.")
		Return False
End Choose

If IsNull(al_Promocao) Then al_Promocao = 0 

al_Promocao = al_Promocao + 1

Return True
end function

public subroutine wf_atualiza_valores ();Long lvl_Linhas, lvl_Linha

dw_2.AcceptText()

Open(w_Aguarde)

w_Aguarde.Title = "Atualizando os valores dos produtos..."

lvl_Linhas = dw_2.RowCount()

SetPointer(HourGlass!)

w_Aguarde.uo_Progress.of_Setmax(lvl_Linhas)

For lvl_Linha = 1 To lvl_Linhas
	
	//dw_2.Object.vl_preco_final		[ lvl_Linha ] = dw_2.Object.vl_preco_venda_atual[ lvl_Linha ] * ((100 - dw_2.Object.pc_desconto[ lvl_Linha ]) / 100)
		
	//dw_2.Object.pc_rentabilidade	[ lvl_Linha ] = round(((dw_2.Object.vl_preco_final[ lvl_Linha ] - dw_2.Object.vl_custo[ lvl_Linha ]) / dw_2.Object.vl_preco_final[ lvl_Linha ]) * 100, 2)
	
	// A fun$$HEX2$$e700e300$$ENDHEX$$o esta com erro, esta passando o c$$HEX1$$f300$$ENDHEX$$digo do produto nulo
	// Segundo o Julio n$$HEX1$$e300$$ENDHEX$$o precisaremos ter mais esta rotina
	
	//wf_Localiza_Promocao_Ecommerce(lvl_Linha)
		
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

SetPointer(Arrow!)

Close(w_Aguarde)


end subroutine

public subroutine wf_copia_promocao ();String lvs_Retorno, &
       lvs_Produto, &
		 lvs_Filial

Long lvl_Promocao, &
     lvl_Alteracao

Open(w_ge585_Copia_Promocao) 

lvs_Retorno = Message.StringParm

If LeftA(lvs_Retorno, 1) = "S" Then
	lvl_Promocao = Long(MidA(lvs_Retorno, 2, 6))
	
	wf_Copia_Produto(lvl_Promocao, ref lvl_Alteracao)
		
	If lvl_Alteracao > 0 Then
		ivb_Valida_Salva = True		
		
		ivm_Menu.mf_Confirmar(True)
		ivm_Menu.mf_Cancelar(True)		
	End If	
End If
end subroutine

public function boolean wf_copia_produto (long al_promocao, ref long al_alteracao);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Linha

Long ll_Promocao_dw1
Long ll_Filial_EC, ll_Filial_Base

Decimal lvdc_Desconto

String ls_Rede, ls_UF

dw_1.AcceptText()

ll_Promocao_dw1 	= dw_1.Object.cd_promocao_sos		[1] 
ls_Rede				= dw_1.Object.id_rede_ecommerce	[1] 

If IsNull(ll_Promocao_dw1) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma promo$$HEX2$$e700e300$$ENDHEX$$o do ecommerce.")
	dw_1.Event ue_Pos(1, "de_localizacao")
	Return False
End If

ll_Filial_Base 	= 454 //Farmagora

Choose Case ls_Rede
	Case 'DC';	ll_Filial_Base 	= 790 //DC
	Case 'MP';	ll_Filial_Base 	= 786 //MP
	Case 'PP';	ll_Filial_Base 	= 13 //PP
End Choose

ls_UF = IIF( ls_Rede = 'FA', 'SP', 'SC') 

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge585_produto_normal") Then
	Destroy(lvds)
	Return False
End If

lvds.Of_AppendWhere( "( g.id_liberado_ecommerce = 'S' Or g.id_liberado_ecommerce_dc = 'S' Or g.id_liberado_ecommerce_mp= 'S' Or g.id_liberado_ecommerce_pp= 'S' ) " )

lvl_Total = lvds.Retrieve(al_Promocao, ls_UF, ll_Filial_Base)

If lvl_Total > 0 Then
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Produto   	= lvds.Object.Cd_Produto [lvl_Contador]
		lvdc_Desconto 	= lvds.Object.Pc_Desconto[lvl_Contador]
		
		lvl_Linha = dw_2.Find("cd_produto = " + String(lvl_Produto), 1, dw_2.RowCount())
		
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "'.")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Linha = 0 Then
		   ivo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
			
			If ivo_Produto.Localizado Then		
				
				If wf_Valida_Produto(ls_Rede) Then 
					lvl_Linha = dw_2.InsertRow(0)
					
					dw_2.Object.Cd_Produto 				[lvl_Linha] = lvl_Produto
					dw_2.Object.Pc_Desconto				[lvl_Linha] = lvdc_Desconto
					dw_2.Object.De_Produto 				[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
					dw_2.Object.Vl_Preco_Venda_Atual	[lvl_Linha] = ivo_Produto.Vl_Preco_Venda_Atual
					dw_2.Object.vl_custo_aux				[lvl_Linha] = wf_custo_produto(ivo_Produto.Cd_Produto, ll_Filial_Base)
					dw_2.Object.vl_imposto					[lvl_Linha] = wf_impostos_produto(ivo_Produto.Cd_Produto, ls_Rede)
					
					wf_atualiza_valor(lvl_Linha)
					
					If lvl_Linha = 1 Then
						dw_2.ivo_Controle_Menu.of_Excluir(True)
					End If
					
					al_Alteracao ++
				End If
			End If
		End If
	Next	
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados para c$$HEX1$$f300$$ENDHEX$$pia.")
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public subroutine wf_atualiza_valor (long al_linha);Decimal lvdc_Desconto

lvdc_Desconto = dw_2.Object.pc_desconto[al_Linha]
		
If Isnull(lvdc_Desconto) Then lvdc_Desconto = 0.00
		
dw_2.Object.vl_preco_final[al_Linha] = dw_2.Object.vl_preco_venda_atual[al_Linha] * ((100 - lvdc_Desconto) / 100)
		
dw_2.Object.pc_rentabilidade[al_Linha] = round(((dw_2.Object.vl_preco_final[al_Linha] - dw_2.Object.vl_custo[al_Linha]) / dw_2.Object.vl_preco_final[al_Linha]) * 100, 2)
end subroutine

public subroutine wf_exclui_linha ();Long lvl_Linha

//Exclui a ultima linha em branco
For lvl_Linha = 1 To dw_2.RowCount()
	If IsNull(dw_2.Object.cd_produto[lvl_Linha]) Then
		dw_2.DeleteRow(lvl_Linha)
	End If
Next

end subroutine

public function boolean wf_valida_informacoes ();Long lvl_Linha

For lvl_Linha = 1 To dw_2.RowCount()
	
	If dw_2.Object.pc_desconto[lvl_Linha] < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O percentual do desconto n$$HEX1$$e300$$ENDHEX$$o pode ser negativo.", Exclamation!)
		dw_2.SetFocus()
		dw_2.Event ue_Pos(lvl_Linha, "pc_desconto")
		Return False		
	End If
	
	If dw_2.Object.pc_desconto[lvl_Linha] >= 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O percentual do desconto n$$HEX1$$e300$$ENDHEX$$o pode ser 100.", Exclamation!)
		dw_2.SetFocus()
		dw_2.Event ue_Pos(lvl_Linha, "pc_desconto")
		Return False		
	End If
	
Next

Return True
end function

public function boolean wf_localiza_filial_ecommerce ();String lvs_Filial

Select vl_parametro
Into :lvs_Filial
From parametro_geral
Where cd_parametro = 'CD_FILIAL_ECOMMERCE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If  Not IsNull(lvs_Filial) and isNumber(lvs_Filial) Then
			ivl_Filial_Ecommerce = Long(lvs_Filial)
			Return True
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial ecommerce informado na tabela par$$HEX1$$e200$$ENDHEX$$metro $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.")
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'C$$HEX1$$f300$$ENDHEX$$digo da filial eCommerce n$$HEX1$$e300$$ENDHEX$$o foi localizado.')
	Case -1
		SqlCa.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial eCommerce na PARAMETRO_GERAL')
End Choose

Return False
end function

public function boolean wf_localiza_promocao_ecommerce (long al_linha);Decimal lvdc_Desconto, lvdc_Nulo

String lvs_Promocao, lvs_Nulo

SetNull(lvs_Nulo)
SetNull(lvdc_Nulo)

lvdc_Desconto = ivo_Produto.Of_Desconto_Filial(ivl_Filial_Ecommerce)
				
// Se exite promo$$HEX2$$e700e300$$ENDHEX$$o
If Not IsNull(ivo_Produto.cd_promocao_sos) and lvdc_Desconto > 0.00 Then
	
	Select nm_promocao_sos
	Into :lvs_Promocao
	From promocao_sos p
	Where p.cd_promocao_sos		= :ivo_Produto.cd_promocao_sos
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a promo$$HEX1$$e700$$ENDHEX$$ao da loja f$$HEX1$$ed00$$ENDHEX$$sica do ecommerce.")
		Return False
	Else
		dw_2.Object.cd_promocao_sos_ecommerce	[al_Linha] = ivo_Produto.cd_promocao_sos
		dw_2.Object.nm_promocao_sos_ecommerce	[al_Linha] = lvs_Promocao
		dw_2.Object.pc_desconto_sos_ecommerce		[al_Linha] = lvdc_Desconto
	End If

Else
	
	dw_2.Object.cd_promocao_sos_ecommerce	[al_Linha] = ivo_Produto.cd_promocao_sos
	dw_2.Object.nm_promocao_sos_ecommerce	[al_Linha] = lvs_Nulo
	dw_2.Object.pc_desconto_sos_ecommerce		[al_Linha] = lvdc_Nulo
		
End If

Return True
end function

protected subroutine wf_inclui_filial_ecommerce_promocao ();Long lvl_Promocao, lvl_Achou, ll_Filial_Ecommerce

String ls_Rede

dw_1.AcceptText()

lvl_Promocao 	= dw_1.Object.cd_promocao_sos		[1]
ls_Rede			= dw_1.Object.id_rede_ecommerce	[1]

Choose Case ls_Rede
	Case 'FA'; ll_Filial_Ecommerce = 809
	Case 'DC'; ll_Filial_Ecommerce = 986
	Case 'MP'; ll_Filial_Ecommerce = 355
	Case 'PP'; ll_Filial_Ecommerce = 318	
End Choose

If Not IsNull(lvl_Promocao) Then
	
	Select cd_promocao_sos
	Into :lvl_Achou
	From promocao_sos_filial
	Where cd_promocao_sos 	=	:lvl_Promocao
		and cd_filial					= :ll_Filial_Ecommerce
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			
			  	INSERT INTO promocao_sos_filial ( cd_promocao_sos,cd_filial )  
  				VALUES ( :lvl_Promocao,   :ll_Filial_Ecommerce )
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o da filial na promo$$HEX2$$e700e300$$ENDHEX$$o SOS.")
				Else
					SqlCa.of_Commit();
				End If
				
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial na promo$$HEX2$$e700e300$$ENDHEX$$o SOS.")
	End Choose
		
End If
end subroutine

public function boolean wf_valida_produto (string as_rede);String lvs_Ecommerce, lvs_Produto

Choose Case as_rede
	Case 'FA'; lvs_Ecommerce = ivo_Produto.id_liberado_ecommerce 
	Case 'DC'; lvs_Ecommerce = ivo_Produto.id_liberado_ecommerce_dc
	Case 'MP'; lvs_Ecommerce = ivo_Produto.id_liberado_ecommerce_mp
	Case 'PP'; lvs_Ecommerce = ivo_Produto.id_liberado_ecommerce_pp
End Choose

lvs_Produto = ivo_Produto.de_produto + " : " + ivo_Produto.de_apresentacao_venda + " (" + String(ivo_Produto.cd_produto) + ")"

If IsNull(lvs_Ecommerce) Then lvs_Ecommerce = 'N'

If Mid(ivo_Produto.cd_subcategoria,1,1) = '5' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a venda deste produto pelo site.~r~r" +&
					"Produto: " + lvs_Produto + ".~rMotivo: ALMOXARIFADO.", Exclamation!)
	Return False
	
End If

If lvs_Ecommerce = 'N' Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 	"O produto '" + lvs_Produto + "' n$$HEX1$$e300$$ENDHEX$$o esta liberado para venda pelo site.~r~r" +&
										"Deseja incluir o produto mesmo assim ?", Question!, YesNo!, 2) = 2 Then
		Return False
	End If
End If

If ivo_Produto.id_situacao = 'I' Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + lvs_Produto + "'  esta INATIVO na matriz.~r~r" +&
										"Deseja incluir mesmo assim ?", Question!, YesNo!, 2) = 2 Then
		Return False
	End If	
End If

Return True
end function

public function decimal wf_custo_produto (long al_produto, long al_filial_base);Decimal lvdc_Custo, lvdc_Custo_empresa

Select vl_custo_gerencial_geral
Into :lvdc_Custo_empresa
From produto_central
Where cd_produto = :al_produto
Using SqlCa;

Select vl_custo_gerencial 
Into :lvdc_Custo
From vw_saldo_atual_produto
where cd_produto 	=	:al_Produto
  and cd_filial 			= 	:al_Filial_Base
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvdc_Custo) or lvdc_Custo < 0  Then
			If lvdc_Custo_empresa > 0  Then
				lvdc_Custo = lvdc_Custo_empresa			
			Else
				lvdc_Custo = 0.00
			End If
		End If
		If lvdc_Custo = 0 Then
			Select vl_custo_gerencial 
				Into :lvdc_Custo
			From produto_central
			where cd_produto 	=	:al_Produto
			Using SqlCa;

			Choose Case SqlCa.SqlCode
				Case 0
					If IsNull(lvdc_Custo) or lvdc_Custo < 0  Then
						If lvdc_Custo_empresa > 0  Then
							lvdc_Custo = lvdc_Custo_empresa			
						Else
							lvdc_Custo = 0.00
						End If
					End If		
		
				Case 100
					If lvdc_Custo_empresa > 0  Then
						lvdc_Custo = lvdc_Custo_empresa			
					Else
						lvdc_Custo = 0.00
					End If
				Case -1
					SqlCa.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do custo m$$HEX1$$e900$$ENDHEX$$dio do produto '" + String(al_Produto) + "'. ")
					Return 0.00
		
			End Choose
		End If
		
		Return lvdc_Custo
		
	Case 100
		If lvdc_Custo_empresa > 0  Then
			lvdc_Custo = lvdc_Custo_empresa			
		Else
			lvdc_Custo = 0.00
		End If
		Return lvdc_Custo

	Case -1
		SqlCa.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do custo m$$HEX1$$e900$$ENDHEX$$dio do produto '" + String(al_Produto) + "'. ")
		Return 0.00
		
End Choose

end function

public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto, string as_rede);Long lvl_Find, &
     lvl_Row

Long ll_Filial_Base

lvl_Find = dw_2.Find("cd_produto = " + String(al_produto), 1, dw_2.RowCount())

If lvl_Find = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find para o produto '" + String(al_Produto) + "'.", StopSign!)
	Return False
End If 

If lvl_Find = 0 Then
	
	ivo_Produto.of_Localiza_Codigo_Interno( al_Produto )
	
	ll_Filial_Base = 454 //Farmagora
	
	Choose Case as_Rede
		Case 'DC'; ll_Filial_Base = 790
		Case 'MP'; ll_Filial_Base = 786
		Case 'PP';	ll_Filial_Base 	= 13 //PP
	End Choose
	
	If ivo_Produto.Localizado Then
		If wf_Valida_Produto( as_rede ) Then
			lvl_Row = dw_2.InsertRow(0) 		
			
			dw_2.Object.cd_produto          		[lvl_Row] = al_Produto
			dw_2.Object.pc_desconto         		[lvl_Row] = adc_desconto
			dw_2.Object.De_Produto          		[lvl_Row] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			dw_2.Object.Vl_Preco_Venda_Atual	[lvl_Row] = ivo_Produto.Vl_Preco_Venda_Atual
			dw_2.Object.vl_custo_aux				[lvl_Row] = wf_custo_produto(ivo_Produto.Cd_Produto, ll_Filial_Base)
			dw_2.Object.vl_imposto					[lvl_Row] = wf_impostos_produto(ivo_Produto.Cd_Produto, as_Rede)
			
			wf_atualiza_valor(lvl_Row)
			
			ivl_Linhas ++
		End If
	End If
	
Else
	
   If dw_2.Object.pc_desconto[lvl_Find] <> adc_desconto Then
		dw_2.Object.pc_desconto[lvl_Find] = adc_desconto
		ivl_Linhas ++
	End If
	
End If

Return True
end function

public function decimal wf_impostos_produto (long al_produto, string as_rede);Decimal lvdc_Imposto

String ls_UF

//FA 			--> Sao Paulo
//DC e MP 	--> Santa Catarina
ls_UF = IIF( as_Rede = 'FA', 'SP', 'SC' )

select CONVERT(DECIMAL(13,2),round((u.vl_preco_venda_atual / g.vl_fator_conversao) * (t.pc_icms / 100),2)) 
  into :lvdc_Imposto
  from produto_uf u, tipo_icms t, produto_geral g
where u.cd_produto 				 	= :al_Produto
   and u.cd_unidade_federacao 	= :ls_UF
   and u.cd_produto 					= g.cd_produto
   and u.cd_tipo_icms 		   		= t.cd_tipo_icms
   and u.cd_tributacao_icms   		= '0'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvdc_Imposto) or lvdc_Imposto < 0  Then
			lvdc_Imposto = 0.00
		End If
		
		Return lvdc_Imposto
		
	Case 100
		Return 0.00
	Case -1	
		SqlCa.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do imposto do produto '" + String(al_Produto) + "'. ")
		Return 0.00
End Choose

end function

public function boolean wf_localiza_produto (string as_parametro, string as_rede);Long lvl_Linha, ll_Filial_Base

Decimal lvdc_Desconto

ivo_Produto.of_Localiza_Produto(as_parametro)

dw_1.AcceptText()

Choose Case as_rede
	Case 'FA'; ll_Filial_Base = 454
	Case 'DC'; ll_Filial_Base = 790
	Case 'MP'; ll_Filial_Base = 786
	Case 'PP';	ll_Filial_Base 	= 13 //PP	
End Choose
		
If ivo_Produto.Localizado Then
	lvl_Linha = dw_2.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_2.RowCount())

	If lvl_Linha < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto selecionado.", StopSign!)
		Return False
	End If

	If lvl_Linha = 0 Then
		
		If Not wf_Valida_Produto(as_rede) Then Return False
				
		lvl_Linha = dw_2.GetRow()
		dw_2.Object.Cd_Produto          		[lvl_Linha] = ivo_Produto.Cd_Produto
		dw_2.Object.De_Produto          		[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		dw_2.Object.Vl_Preco_Venda_Atual	[lvl_Linha] = ivo_Produto.of_Preco_Venda_Filial_Matriz( ll_Filial_Base )  //ja esta dividido pelo fator de conversao
		dw_2.Object.vl_custo_aux				[lvl_Linha] = wf_custo_produto(ivo_Produto.Cd_Produto, ll_Filial_Base)
		dw_2.Object.vl_imposto					[lvl_Linha] = wf_impostos_produto(ivo_Produto.Cd_Produto, as_rede)
		
		lvdc_Desconto = dw_2.Object.pc_desconto[lvl_Linha]
		
		dw_2.Object.vl_preco_final		[lvl_Linha] = dw_2.Object.vl_preco_venda_atual[lvl_Linha] * ((100 - lvdc_Desconto) / 100)
		
		dw_2.Object.pc_rentabilidade	[lvl_Linha] = ((dw_2.Object.vl_preco_final[lvl_Linha] - dw_2.Object.vl_custo	[lvl_Linha] ) / dw_2.Object.vl_preco_final[lvl_Linha]) * 100
		
		wf_Localiza_Promocao_Ecommerce(lvl_Linha)	
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ivo_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionado.", Information!)
		Return False
	End If
	
	dw_2.Post Event ue_Pos(lvl_Linha, "pc_desconto")	
End If

ivb_Valida_Salva = True

Return True
end function

on w_ge585_promocao.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cbx_1=create cbx_1
this.dw_3=create dw_3
this.pb_localiza=create pb_localiza
this.cb_copia_promocao=create cb_copia_promocao
this.cb_selecao_produtos=create cb_selecao_produtos
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cbx_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.pb_localiza
this.Control[iCurrent+5]=this.cb_copia_promocao
this.Control[iCurrent+6]=this.cb_selecao_produtos
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.gb_5
end on

on w_ge585_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.cbx_1)
destroy(this.dw_3)
destroy(this.pb_localiza)
destroy(this.cb_copia_promocao)
destroy(this.cb_selecao_produtos)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]

lvo_Update = {dw_1, dw_2}

This.wf_SetUpdate_DW(lvo_Update)

ids	= Create dc_uo_ds_base

If Not ids.of_ChangeDataObject("dw_ge585_produto_normal") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'dw_ge585_produto_normal'.", StopSign!)
	Destroy(ids)
	Return
End If

ids.insertrow( 0 )

ivo_Promocao	= Create uo_Promocao
ivo_Produto  	= Create uo_Produto

dw_3.Event ue_AddRow()

dw_1.Event ue_AddRow()

// exclui o item TODAS
DataWindowChild ldw_Child
dw_1.GetChild("id_rede_ecommerce", ldw_Child)
ldw_Child.deleterow( 1 ) 

dw_1.SetFocus()

dw_1.ivo_Controle_Menu.of_Incluir(True)
dw_2.ivo_Controle_Menu.of_Incluir(False)

// (Ecommerce)
ivo_Promocao.ivs_Tipo = "F"
end event

event close;call super::close;Destroy(ivo_Promocao)
Destroy(ivo_Produto)
Destroy(ids)
end event

event ue_preupdate;call super::ue_preupdate;DateTime 	lvdh_Parametro, &
         		lvdh_Inicio, &
	      		lvdh_Termino, &
				lvdh_Inicio_Anterior
			
Long 	lvl_Promocao, &
		lvl_Linhas, &
		lvl_Resposta, &
		lvl_Find

String lvs_Terminada, &
		 lvs_Promocao_Linha,&
		 lvs_Nome

lvdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

lvl_Promocao         		= dw_1.Object.Cd_Promocao_SOS          			[1]
lvdh_Inicio          			= dw_1.Object.Dh_Inicio                					[1]
lvdh_Termino         		= dw_1.Object.Dh_Termino               				[1]
lvs_Terminada        		= dw_1.Object.Id_Terminada             				[1]
lvdh_Inicio_Anterior 		= dw_1.Object.Dh_Inicio_Anterior       				[1]
lvs_Nome					= dw_1.Object.nm_promocao_sos       				[1]

// Exclui linhas em branco
wf_Exclui_Linha()

////Exclui a ultima linha em branco
//If dw_2.RowCount() > 0 Then
//	If IsNull(dw_2.Object.cd_produto[dw_2.RowCount()]) Then
//		dw_2.DeleteRow(dw_2.RowCount())
//	End If
//End If

If dw_1.ModifiedCount() > 0 Then
	dw_1.Object.nr_matricula_alteracao[1] = ivs_Operador
End If

If Not wf_Valida_Informacoes () Then
	Return False
End If
	
If lvs_Terminada = "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promo$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ terminou, portanto nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salva.")
	Return False
End If

If IsNull(lvdh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return False
End If	

If Not IsNull(lvdh_Termino) Then
	If lvdh_Termino < lvdh_Inicio Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
		dw_1.Event ue_Pos(1, "dh_termino")
		Return False	
	End If
End If

If IsNull(lvl_Promocao) or (Not IsNull(lvl_Promocao) and lvdh_Inicio <> lvdh_Inicio_Anterior) Then
	If lvdh_Inicio < lvdh_Parametro Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser maior ou igual a '" + String(lvdh_Parametro, "dd/mm/yyyy") + "'.", Information!)
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return False	
	End If
End If

If lvdh_Termino < lvdh_Parametro Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deveria ser maior ou igual a '" + String(lvdh_Parametro, "dd/mm/yyyy") + "'. ~r~r" + &
	                         "Confirma grava$$HEX2$$e700e300$$ENDHEX$$o assim mesmo ?", Question!, YesNo!, 2) = 2 Then	
									 
		dw_1.Event ue_Pos(1, "dh_termino")
		Return False	
	End If
End If

//If dw_2.RowCount() = 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto informado.")
//	dw_1.Event ue_Pos(1, "nm_promocao_sos")
//	Return False
//End If

If IsNull(lvl_Promocao) Then
	
	If IsNull(lvs_Nome) or Trim(lvs_Nome) = '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um nome para a promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
		dw_1.Event ue_Pos(1, "nm_promocao_sos")
		Return False
	End If	

	If wf_proxima_promocao(ref lvl_Promocao) Then
		dw_1.Object.Cd_Promocao_SOS[1] = lvl_Promocao
	Else
		Return False
	End If
End If

Return True
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then	
	wf_inclui_filial_ecommerce_promocao()
	
	dw_1.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

event ue_cancel;call super::ue_cancel;dw_1.Reset()
dw_2.Reset()
dw_3.Reset()
dw_3.Event ue_AddRow()
dw_1.Event ue_AddRow()

dw_1.SetFocus()
end event

event ue_update;call super::ue_update;If Not gf_ge065_Historico_Exclusao_Produto(ids, dw_2, "N") Then Return False

Return True
end event

event open;call super::open;//If wf_Localiza_Filial_Ecommerce() Then
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("ge585_libera_acesso_promocao", ref ivs_Operador) Then 
		Close(This)
	End If
//Else
//	Close(This)
//End If
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge585_promocao
integer y = 1332
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge585_promocao
integer y = 1260
end type

type dw_4 from dc_uo_dw_base within w_ge585_promocao
integer x = 2427
integer y = 292
integer width = 1079
integer height = 172
integer taborder = 30
string dataobject = "dw_ge585_aplicar_percentuais"
end type

event constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"pc_desconto", "pc_rentabilidade"}
end event

event editchanged;call super::editchanged;Choose Case dwo.name
	Case "pc_desconto"
		
		If(This.Object.pc_rentabilidade[row] > 0.00) Then
			This.Object.pc_rentabilidade[row] = 0.00
		End If	
				
	Case "pc_rentabilidade"
		If(This.Object.pc_desconto[row] > 0.00) Then
			This.Object.pc_desconto[row] = 0.00
		End If			
		
End Choose

end event

event itemchanged;call super::itemchanged;String lvs_Selecao
		  
Long lvl_Linha

If dw_2.RowCount() = 0 Then Return

Choose Case dwo.name
	Case "pc_desconto"
		If This.Object.pc_desconto[1] <> Dec(data) and Dec(data) > 0.00 Then

			This.Object.pc_desconto[1] = Dec(data)
			
			For lvl_Linha = 1 To dw_2.RowCount()
				dw_2.Object.pc_desconto[lvl_Linha] = Dec(data)
				dw_2.Event itemchanged(lvl_Linha, dw_2.Object.pc_desconto,  data)
			Next
		End If


	Case "pc_rentabilidade"
		If This.Object.pc_rentabilidade[1] <> Dec(data) and Dec(data) > 0.00 Then
			
			This.Object.pc_rentabilidade[1] = Dec(data)
			
			For lvl_Linha = 1 To dw_2.RowCount()
				dw_2.Object.pc_rentabilidade[lvl_Linha] = Dec(data)
				dw_2.Event itemchanged(lvl_Linha, dw_2.Object.pc_rentabilidade, data)
			Next				
		End If
	
End Choose

end event

event losefocus;call super::losefocus;If This.GetColumnName() = 'pc_desconto' Then
	This.Event itemchanged(1, This.Object.pc_desconto, This.gettext() )
End If

If This.GetColumnName() = 'pc_rentabilidade' Then
    This.Event itemchanged(1, This.Object.pc_rentabilidade, This.gettext() )
End If

end event

type cbx_1 from checkbox within w_ge585_promocao
integer x = 2455
integer y = 584
integer width = 1006
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Apenas Produtos Abaixo de 10% ?"
boolean lefttext = true
end type

event clicked;If This.Checked Then
	
	dw_2.SetFilter("pc_rentabilidade < 9.98")
	
	dw_2.Filter()
	
Else
	
	dw_2.SetFilter("")
	
	dw_2.Filter()
	
End If
end event

type dw_3 from dc_uo_dw_base within w_ge585_promocao
integer x = 69
integer y = 576
integer width = 2103
integer height = 92
integer taborder = 50
string dataobject = "dw_ge585_selecao_arquivo"
end type

type pb_localiza from picturebutton within w_ge585_promocao
string tag = "Localiza o arquivo com os produtos da promo$$HEX2$$e700e300$$ENDHEX$$o."
integer x = 2199
integer y = 568
integer width = 133
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Search!"
end type

event clicked;String lvs_Path,         &
       lvs_Nome_Arquivo, &
		 lvs_Arquivo,      &
		 lvs_Dado,         &
		 lvs_Msg,          &
		 lvs_Nulo
		 
Integer lvi_Arquivo

Decimal lvdc_Desconto

Long lvl_Linhas,   & 
	  lvl_Linha,    &
	  lvl_Produto,  &
	  lvl_Promocao
	  
Integer lvi_Retorno, &
        lvi_Nulo

String ls_Rede
		  
dw_1.AcceptText()

lvl_Promocao 	= dw_1.Object.cd_promocao_sos		[1]
ls_Rede			= dw_1.Object.id_rede_ecommerce	[1]

If IsNull(lvl_Promocao) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return
End If

If cbx_1.checked Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desmarque o filtro de rentabilidade para importar novos produtos.", StopSign!)
	Return
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                     "Coluna A = Produto.~r" + &
							"Coluna B = Desconto. ~r")
			
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLS", &
	+ "Excel (*.XLS),*.XLS,")

If lvi_Arquivo <> 1 Then Return

ivl_Linhas = 0

dw_3.Object.nm_arquivo[1] = lvs_Path

lvs_Msg = "Importar os produtos com os descontos do arquivo selecionado ?"
		  
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

dw_2.SetRedRaw(False)

dw_3.AcceptText()

lvs_Arquivo = dw_3.Object.nm_arquivo [1]

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas 
			 lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A"))
					 
			 If IsNumber(lvs_Dado) Then
				 lvl_Produto = Long(lvs_Dado)
				 
				 lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B"))
				 
				 lvdc_Desconto = Dec(lvs_Dado)
							 
				 If IsNull(lvdc_Desconto) or lvdc_Desconto <= 0 Then lvdc_Desconto = 0							 
				  
				 If Not wf_Inclui_Promocao_SOS_Produto(lvl_Produto, lvdc_Desconto, ls_Rede) Then
					 Exit
				 End If
			 End If
			 
			 w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
		
		If ivl_Linhas > 0 Then
			Parent.ivm_Menu.mf_Confirmar(True)
			Parent.ivm_Menu.mf_Cancelar(True)
			Parent.ivb_Valida_Salva = True
		End If
		
	End If
		
End If

Close(w_Aguarde)

dw_2.SetRedRaw(True)

Destroy(lvo_Excel)










end event

type cb_copia_promocao from commandbutton within w_ge585_promocao
integer x = 2377
integer y = 76
integer width = 530
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Copia Promo$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;wf_Copia_Promocao()
end event

type cb_selecao_produtos from commandbutton within w_ge585_promocao
integer x = 2971
integer y = 76
integer width = 613
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Inclus$$HEX1$$e300$$ENDHEX$$o de Produtos"
end type

event clicked;Decimal lvdc_Desconto

String lvs_Produtos, lvs_Produto, ls_Rede

Long lvl_Pos1, lvl_Contador, lvl_Pos2, lvl_Teste, lvl_Len, lvl_Linha

Long ll_Promocao_sos

dw_1.AcceptText()

ll_Promocao_sos 	= dw_1.Object.cd_promocao_sos		[ 1 ]
ls_Rede 				= dw_1.Object.id_rede_ecommerce 	[ 1 ]

If IsNull(ll_Promocao_sos) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma promo$$HEX2$$e700e300$$ENDHEX$$o do ecommerce.")
	dw_1.Event ue_Pos(1, 'de_localizacao')
	Return -1
End If

Open(w_ge585_selecao_produto)

lvs_Produtos = Message.StringParm	

lvl_Len = Len(lvs_Produtos)

dw_2.SetRedRaw(False)

Do While lvl_Len > 1
	
	lvl_Pos1 = Pos(lvs_Produtos, "|") 
	lvl_Pos2 = Pos(lvs_Produtos, "|", lvl_Pos1 + 1) 

	lvs_Produto 	= Mid(lvs_Produtos, lvl_Pos1 + 1, (lvl_Pos2 - lvl_Pos1) - 1)
	
	lvl_Linha = dw_2.InsertRow(0)
	
	// Posiciona na linha inclu$$HEX1$$ed00$$ENDHEX$$da
	dw_2.ScrollToRow(lvl_Linha)
	dw_2.SetRow(lvl_Linha)
	
	If Not wf_Localiza_Produto(lvs_Produto, ls_rede)	Then
		dw_2.DeleteRow(lvl_Linha)
	Else
		
		wf_atualiza_valor(lvl_Linha)
	
		Parent.ivb_Valida_Salva = True
		
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)
	End If

	lvs_Produtos = Mid(lvs_Produtos, lvl_Pos2)
	
	lvl_Len = Len(lvs_Produtos)
	
Loop

dw_2.SetRedRaw(True)





end event

type dw_2 from dc_uo_dw_base within w_ge585_promocao
integer x = 69
integer y = 776
integer width = 3735
integer height = 1100
integer taborder = 40
string dataobject = "dw_ge585_produto_normal"
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;//String lvs_Coluna[], &
//       lvs_Nome[]
//		 
//lvs_Coluna = {"cd_produto", "de_produto", "pc_desconto"}
//
//lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o", "Desconto (%)"}

//This.of_SetSort(lvs_Coluna, lvs_Nome)
//
//This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetSort( )
This.of_SetFilter( )

This.of_SetRowSelection("", "if (pc_rentabilidade <= 0.00, rgb(255, 0, 0), if (pc_desconto = 100, rgb(255, 0, 0), rgb(0, 0, 0)))")

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event editchanged;call super::editchanged;ivw_ParentWindow.ivb_Valida_Salva = True

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)	
end event

event itemchanged;call super::itemchanged;Decimal lvdc_Preco_Venda_Atual, lvdc_Desconto, lvdc_Rentabilidade, lvdc_Vl_Preco_Final

Choose Case dwo.name
	Case "pc_desconto"
		
		lvdc_Desconto = Dec(data)
		
		If lvdc_Desconto < 0.00 or lvdc_Desconto >= 100.00 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto informado inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			Return 1
		End If
				
		lvdc_Vl_Preco_Final 	= Round(dw_2.Object.vl_preco_venda_atual[row] * ((100 - lvdc_Desconto) / 100), 2)
		lvdc_Rentabilidade		= Round(round(((lvdc_Vl_Preco_Final - dw_2.Object.vl_custo[row]) / lvdc_Vl_Preco_Final ), 4) * 100, 2)			
		
		This.Object.vl_preco_final			[row] = lvdc_Vl_Preco_Final
		This.Object.pc_rentabilidade		[row] = lvdc_Rentabilidade
				
	Case "vl_preco_final"
		
		lvdc_Vl_Preco_Final = Dec(data)
		
		If lvdc_Vl_Preco_Final <= 0.00  Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pre$$HEX1$$e700$$ENDHEX$$o final informado inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			Return 1
		End If
		
		lvdc_Rentabilidade	= Round(Round(( ( lvdc_Vl_Preco_Final - dw_2.Object.vl_custo[ row ] ) / lvdc_Vl_Preco_Final), 4) * 100, 2)
		lvdc_Desconto  		= Round(((dw_2.Object.vl_preco_venda_atual[row] - lvdc_Vl_Preco_Final) / dw_2.Object.vl_preco_venda_atual[row]) * 100, 2)
			
		If lvdc_Desconto < 0.00 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O desconto calculado n$$HEX1$$e300$$ENDHEX$$o pode ficar negativo.", Exclamation!)
			Return 1
		End If			
			
		This.Object.pc_rentabilidade	[row] = lvdc_Rentabilidade
		This.Object.pc_desconto			[row] = lvdc_Desconto
							
	Case "pc_rentabilidade"
		
		lvdc_Rentabilidade = Dec(data)
		
		If lvdc_Rentabilidade < 0.00 or lvdc_Rentabilidade >= 100.00 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","% de rentabilidade informado inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			Return 1
		End If
		
		lvdc_Vl_Preco_Final	= Round( dw_2.Object.vl_custo[row] /  ( (100 - lvdc_Rentabilidade ) / 100 ) , 2)
		lvdc_Desconto			= Round(round(((dw_2.Object.vl_preco_venda_atual[row] - lvdc_Vl_Preco_Final ) / dw_2.Object.vl_preco_venda_atual[row]), 4) * 100, 2)
		
		If lvdc_Desconto < 0.00 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O desconto calculado n$$HEX1$$e300$$ENDHEX$$o pode ficar negativo.", Exclamation!)
			Return 1
		End If
		
		This.Object.vl_preco_final	[row]	= lvdc_Vl_Preco_Final
		This.Object.pc_desconto		[row]	= lvdc_Desconto
		
End Choose

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)	
ivb_Valida_Salva = True


end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then	
	This.ivo_Controle_Menu.of_Excluir(True)	
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then 
		This.ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_Excluir(True)
	This.ivo_Controle_Menu.of_Filtrar(True)
	This.ivo_Controle_Menu.of_Classificar(True)
	
	This.ivo_Controle_Menu.of_SalvarComo(True)
	//wf_Atualiza_Valores()
	
	ids.Reset()
	
	If dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, ids, 1, Primary!) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy. dw_2.Event ue_postretrieve()", StopSign!)
		Return -1
	End If
	
Else
	This.ivo_Controle_Menu.of_Excluir(False)
	This.ivo_Controle_Menu.of_Filtrar(False)
	This.ivo_Controle_Menu.of_Classificar(False)
	
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull(cd_produto)", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Promocao
	  
DateTime lvdh_Atual

Date lvdt_Alteracao

lvdh_Atual = gvo_Parametro.of_Dh_Movimentacao()

lvdt_Alteracao = RelativeDate(Date(lvdh_Atual), 1)

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS		[lvl_Linha] = lvl_Promocao
		This.Object.Dh_Alteracao   				[lvl_Linha] = lvdt_Alteracao
		This.Object.nr_matricula_alteracao  	[lvl_Linha] = ivs_Operador
	Else
		If This.Object.Pc_Desconto[lvl_Linha] <> This.Object.Pc_Desconto_Anterior[lvl_Linha] Then
			This.Object.Dh_Alteracao				[lvl_Linha] = lvdt_Alteracao
			This.Object.nr_matricula_alteracao	[lvl_Linha] = ivs_Operador
		End If
	End If
Next

Return 1
end event

event ue_recuperar;// Override
Long lvl_Promocao, ll_Filial

String ls_Rede_EC, ls_UF

dw_1.AcceptText()

lvl_Promocao 	= dw_1.Object.Cd_Promocao_SOS	[1]
ls_Rede_EC		= dw_1.Object.id_rede_ecommerce	[1]

dw_4.Reset()
dw_4.Event ue_AddRow()

Choose Case ls_Rede_EC
	Case 'FA'
		ls_UF 		= 'SP'
		ll_Filial 	= 454
	Case 'DC'
		ls_UF 		= 'SC'
		ll_Filial 	= 790
	Case 'MP'
		ls_UF 		= 'SC'
		ll_Filial 	= 786
	Case 'PP'
		ls_UF 		= 'SC'
		ll_Filial 	= 13
End Choose

Return This.Retrieve(lvl_Promocao, ls_UF, ll_Filial, ls_Rede_EC)
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_1 from dc_uo_dw_base within w_ge585_promocao
integer x = 69
integer y = 88
integer width = 2277
integer height = 368
integer taborder = 20
string dataobject = "dw_ge585_promocao"
end type

event constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao", "id_rede_ecommerce"}

This.of_SetColSelection(True)
end event

event editchanged;// Override
If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
		
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)		
	End If
End If
end event

event itemchanged;// Override
If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
		
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)		
	End If
End If
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_key;call super::ue_key;String lvs_Promocao

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_localizacao" Then
		lvs_Promocao = This.GetText()

		ivo_Promocao.of_Localiza(lvs_Promocao)

		If ivo_Promocao.Localizado Then
			This.Object.Cd_Promocao_SOS[1] = ivo_Promocao.Cd_Promocao
			
			//dw_6.Object.id_tipo[1] = "TD"
			//dw_3.Event ue_Retrieve()
			
			This.Event ue_Retrieve()
		End If
	End If
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If wf_Valida_Salva() < 0 Then
	Return -1
Else
	This.Reset()
	Return 1
End If
end event

event ue_preretrieve;call super::ue_preretrieve;If wf_Valida_Salva() < 0 Then
	Return -1
Else
	Return 1
End If
end event

event ue_recuperar;// Override

Long lvl_Promocao

This.AcceptText()

lvl_Promocao = This.Object.Cd_Promocao_SOS[1]

If IsNull(lvl_Promocao) or lvl_Promocao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o para recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es.", Information!)
	Return -1
End If

Return This.Retrieve(lvl_Promocao)
end event

event ue_postretrieve;call super::ue_postretrieve;DateTime	lvdh_Atual, &
         		lvdh_Inicio, &
				lvdh_Termino

Long ll_Filial_Ec, ll_Promocao

If pl_Linhas > 0 Then
	lvdh_Inicio  		= This.Object.Dh_Inicio      			[1]
	lvdh_Termino 	= This.Object.Dh_Termino     		[1]
	lvdh_Atual   		= This.Object.Dh_Movimentacao	[1]
	ll_Promocao		= This.Object.cd_promocao_sos	[1]
	
	Select top 1 cd_filial
	Into :ll_Filial_Ec
	From promocao_sos_filial
	Where cd_promocao_sos 	=	:ll_Promocao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_msgDbError("Erro ao localizar a filial_ecommerce, dw_1.ue_postretrieve()")
		Return -1
	End If
	
	Choose Case ll_Filial_Ec
		Case 809;  This.Object.id_Rede_Ecommerce [1] = 'FA'
		Case 986;  This.Object.id_Rede_Ecommerce [1] = 'DC'
		Case 355;  This.Object.id_Rede_Ecommerce [1] = 'MP'
		Case 318;  This.Object.id_Rede_Ecommerce [1] = 'PP'
	End Choose
		
	//This.Object.id_Rede_Ecommerce.Protect = 1
	
	dw_2.Event ue_Retrieve()
		
	If lvdh_Atual > lvdh_Termino Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promo$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ terminou, portanto nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salva.")		
		
		This.Object.Id_Terminada[1] = "S"
		
		This.Object.Dh_Inicio.Protect 				= 1
		This.Object.Dh_termino.Protect 			= 1
		This.Object.nm_promocao_sos.Protect 	= 1
	End If
	
	dw_2.SetFocus()
End If

Return pl_LInhas
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.Object.Dh_Inicio.Protect  = 0
	This.Object.Dh_Termino.Protect = 0
	//This.Object.id_Rede_Ecommerce.Protect = 0
	
	//dw_3.Object.Id_Filial.Protect = 0
		
	//cb_Selecao_Filial.Enabled = True
	
	Parent.ivb_Valida_Salva = False
	
	dw_2.Reset()
	dw_3.Reset()
	dw_3.Event ue_AddRow()
	dw_4.Reset()
	dw_4.Event ue_AddRow()
	
	dw_1.SetFocus()	
	
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
End If

Return AncestorReturnValue
end event

event ue_deleterow;// OverRide

dw_2.SetFocus()

dw_2.Event ue_DeleteRow()

Return True

end event

type gb_1 from groupbox within w_ge585_promocao
integer x = 32
integer y = 8
integer width = 2331
integer height = 472
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Promo$$HEX2$$e700e300$$ENDHEX$$o"
end type

type gb_2 from groupbox within w_ge585_promocao
integer x = 32
integer y = 720
integer width = 3799
integer height = 1168
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos "
end type

type gb_3 from groupbox within w_ge585_promocao
integer x = 32
integer y = 508
integer width = 2331
integer height = 200
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Inclus$$HEX1$$e300$$ENDHEX$$o dos Produtos na Promo$$HEX2$$e700e300$$ENDHEX$$o via Excel (XLS)"
end type

type gb_4 from groupbox within w_ge585_promocao
integer x = 2391
integer y = 508
integer width = 1193
integer height = 200
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filtrar por Rentabilidade"
end type

type gb_5 from groupbox within w_ge585_promocao
integer x = 2391
integer y = 236
integer width = 1193
integer height = 244
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aplicar Percentuais"
end type

