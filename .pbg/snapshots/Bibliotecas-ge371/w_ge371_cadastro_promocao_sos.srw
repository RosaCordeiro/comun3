HA$PBExportHeader$w_ge371_cadastro_promocao_sos.srw
forward
global type w_ge371_cadastro_promocao_sos from dc_w_sheet
end type
type cb_selecao_filiais from commandbutton within w_ge371_cadastro_promocao_sos
end type
type gb_3 from groupbox within w_ge371_cadastro_promocao_sos
end type
type gb_2 from groupbox within w_ge371_cadastro_promocao_sos
end type
type gb_1 from groupbox within w_ge371_cadastro_promocao_sos
end type
type dw_1 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
end type
type dw_2 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
end type
type dw_3 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
end type
type cb_selecao_filial from commandbutton within w_ge371_cadastro_promocao_sos
end type
type dw_4 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
end type
type cb_importar_produto from commandbutton within w_ge371_cadastro_promocao_sos
end type
type dw_5 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
end type
end forward

global type w_ge371_cadastro_promocao_sos from dc_w_sheet
integer width = 3630
integer height = 1900
string title = "GE371 - Cadastro de Promo$$HEX2$$e700f500$$ENDHEX$$es SOS"
boolean resizable = false
cb_selecao_filiais cb_selecao_filiais
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_selecao_filial cb_selecao_filial
dw_4 dw_4
cb_importar_produto cb_importar_produto
dw_5 dw_5
end type
global w_ge371_cadastro_promocao_sos w_ge371_cadastro_promocao_sos

type variables
uo_promocao ivo_promocao

uo_Produto ivo_Produto

String ivs_Responsavel
Long ivl_linhas
String  ivs_promocao_sap
end variables

forward prototypes
public function long wf_proxima_promocao ()
public subroutine wf_localiza_produto ()
public function boolean wf_existe_promocao (long pl_produto)
public function boolean wf_valida_desconto (long pl_row, string ps_dado, ref decimal rdc_desconto)
public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto, decimal adc_desc_clube)
public subroutine wf_desabilita_controles (string ls_operacao)
end prototypes

public function long wf_proxima_promocao ();Long lvl_Promocao

Select max(cd_promocao_sos) Into :lvl_Promocao
From promocao_sos
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvl_Promocao) Then
			Return lvl_Promocao + 1
		Else
			Return 1
		End If
	Case 100
		Return 1
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da pr$$HEX1$$f300$$ENDHEX$$xima promo$$HEX2$$e700e300$$ENDHEX$$o.")
End Choose
end function

public subroutine wf_localiza_produto ();Long lvl_Linha, &
     lvl_Linha_Selecao

String lvs_Produto

lvl_Linha_Selecao = dw_2.GetRow()
lvs_Produto = dw_2.GetText()

ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	
	lvl_Linha = dw_2.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_2.RowCount())

	If lvl_Linha = 0 Then
		lvl_Linha = dw_2.GetRow()
		
		dw_2.Object.Cd_Produto[lvl_Linha] = ivo_Produto.Cd_Produto
		dw_2.Object.De_Produto[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(ivo_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionado.", Information!)
		dw_2.DeleteRow(lvl_Linha_Selecao)
	End If
	
	dw_2.Event ue_Pos(lvl_Linha, "pc_desconto")	
	dw_2.SelectText(1, 100)

End If
end subroutine

public function boolean wf_existe_promocao (long pl_produto);String lvs_Promocao

Decimal lvdc_Desconto

Select a.nm_promocao_sos,
       b.pc_desconto 
Into :lvs_Promocao, 
     :lvdc_Desconto 
From promocao_sos a, 
	  promocao_sos_produto b,
	  parametro p
Where a.cd_promocao_sos = b.cd_promocao_sos
  and b.cd_produto = :pl_Produto
  and a.id_tipo_promocao = 'S'
  and a.dh_inicio <= p.dh_movimentacao
  and (a.dh_termino >= p.dh_movimentacao or a.dh_termino Is Null)
Using SqlCa;
		
Choose Case SqlCa.SqlCode
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(pl_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ faz parte da promo$$HEX2$$e700e300$$ENDHEX$$o '" + &
		                      lvs_Promocao + "' com '" + String(lvdc_Desconto, "0.00") + "%' de desconto.", Information!)
	   Return True
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Desconto SOS.")
		Return False
End Choose
end function

public function boolean wf_valida_desconto (long pl_row, string ps_dado, ref decimal rdc_desconto);Decimal ldc_Desc

If Not IsNumber( ps_Dado ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do desconto inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String( pl_row ) + "~rValor: " + ps_dado)
	Return False
End If

ldc_Desc = Dec(ps_Dado)

If IsNull(ldc_Desc) or ldc_Desc <= 0 Then ldc_Desc = 0

If ldc_Desc > 99 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do desconto maior que o permitido.~rLinha: " + String(pl_row) + "~rValor: " + ps_dado)
	Return False
End If

rdc_desconto = ldc_Desc

Return True



end function

public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto, decimal adc_desc_clube);Long 	lvl_Find, &
     	lvl_Row


lvl_Find = dw_2.Find(" g.cd_produto = " + String(al_produto), 1, dw_2.RowCount())


If lvl_Find = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find para o produto '" + String(al_Produto) + "'.", StopSign!)
	Return False
End If 

If lvl_Find = 0 Then
	
	ivo_Produto.of_Localiza_Codigo_Interno(al_Produto)

	If ivo_Produto.Localizado Then
		
		lvl_Row = dw_2.InsertRow(0) 
		
		dw_2.Object.cd_produto          			[ lvl_Row ] = al_Produto
		dw_2.Object.pc_desconto         		[ lvl_Row ] = adc_desconto
		dw_2.Object.de_Produto          		[ lvl_Row ] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		
		ivl_Linhas ++
	End If
	
Else
	
   	If dw_2.Object.pc_desconto[ lvl_Find ] <> adc_desconto Then
		dw_2.Object.pc_desconto[ lvl_Find ] = adc_desconto
		ivl_Linhas ++
	End If
	
End If

Return True
end function

public subroutine wf_desabilita_controles (string ls_operacao);If ls_operacao = 'S' Then 
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promocao foi cadastrada no SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar altera$$HEX2$$e700f500$$ENDHEX$$es, somente no SAP!.", Information!)
	
	cb_selecao_filial.enabled = False
	cb_importar_produto.enabled = False
	cb_selecao_filiais.enabled = False
	cb_selecao_filial.enabled = False
	cb_importar_produto.enabled = False
	
	//dw_1.Object.dh_inicio.protect = 1
	//dw_1.Object.dh_termino.protect = 1  
	
	dw_1.ivo_Controle_Menu.of_Incluir(False)
	dw_2.ivo_Controle_Menu.of_Incluir(False)
	dw_3.ivo_Controle_Menu.of_Incluir(False)
	dw_4.ivo_Controle_Menu.of_Incluir(False)
	dw_5.ivo_Controle_Menu.of_Incluir(False)
	
	dw_1.ivo_controle_menu.of_alterar(False)
	dw_2.ivo_controle_menu.of_alterar(False)
	dw_3.ivo_controle_menu.of_alterar(False)
	dw_4.ivo_controle_menu.of_alterar(False)
	dw_5.ivo_controle_menu.of_alterar(False)
	
	dw_1.ivo_controle_menu.of_excluir( False)
	dw_2.ivo_controle_menu.of_excluir( False)
	dw_3.ivo_controle_menu.of_excluir( False)	
	dw_4.ivo_controle_menu.of_excluir( False)	
	dw_5.ivo_controle_menu.of_excluir( False)	

	dw_3.ivm_menu.mf_confirmar( False)
	dw_3.ivm_menu.mf_excluir( False)
	dw_3.ivm_menu.mf_incluir( False)
	dw_4.ivm_menu.mf_incluir( False)
	dw_5.ivm_menu.mf_incluir( False)
	
	dw_1.ivm_menu.mf_confirmar( False)
	dw_1.ivm_menu.mf_excluir( False)
	dw_1.ivm_menu.mf_incluir( False)
	dw_4.ivm_menu.mf_incluir( False)
	dw_5.ivm_menu.mf_incluir( False)

	dw_2.ivm_menu.mf_confirmar( False)
	dw_2.ivm_menu.mf_excluir( False)
	dw_2.ivm_menu.mf_incluir( False)
	dw_4.ivm_menu.mf_incluir( False)
	dw_4.ivm_menu.mf_incluir( False)
Else
	cb_selecao_filial.enabled = True
	cb_importar_produto.enabled = True
	cb_selecao_filiais.enabled = True
	cb_selecao_filial.enabled = True
	cb_importar_produto.enabled = True
	
	//dw_1.Object.dh_inicio.protect = 0
	//dw_1.Object.dh_termino.protect = 0  
	
	dw_1.ivo_Controle_Menu.of_Incluir(True)
	dw_2.ivo_Controle_Menu.of_Incluir(True)
	dw_3.ivo_Controle_Menu.of_Incluir(True)
	dw_4.ivo_Controle_Menu.of_Incluir(True)
	dw_5.ivo_Controle_Menu.of_Incluir(True)
	
	dw_1.ivo_controle_menu.of_alterar(True)
	dw_2.ivo_controle_menu.of_alterar(True)
	dw_3.ivo_controle_menu.of_alterar(True)
	dw_4.ivo_controle_menu.of_alterar(True)
	dw_5.ivo_controle_menu.of_alterar(True)
	
	dw_1.ivo_controle_menu.of_excluir( True)
	dw_2.ivo_controle_menu.of_excluir( True)
	dw_3.ivo_controle_menu.of_excluir( True)	
	dw_4.ivo_controle_menu.of_excluir( True)	
	dw_5.ivo_controle_menu.of_excluir( True)	

	dw_3.ivm_menu.mf_confirmar(True)
	dw_3.ivm_menu.mf_excluir(True)
	dw_3.ivm_menu.mf_incluir(True)
	dw_4.ivm_menu.mf_incluir(True)
	dw_5.ivm_menu.mf_incluir(True)
	
	dw_1.ivm_menu.mf_confirmar(True)
	dw_1.ivm_menu.mf_excluir(True)
	dw_1.ivm_menu.mf_incluir(True)
	dw_4.ivm_menu.mf_incluir(True)
	dw_5.ivm_menu.mf_incluir(True)

	dw_2.ivm_menu.mf_confirmar(True)
	dw_2.ivm_menu.mf_excluir(True)
	dw_2.ivm_menu.mf_incluir(True)
	dw_4.ivm_menu.mf_incluir(True)
	dw_5.ivm_menu.mf_incluir(True)

End If 
end subroutine

on w_ge371_cadastro_promocao_sos.create
int iCurrent
call super::create
this.cb_selecao_filiais=create cb_selecao_filiais
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_selecao_filial=create cb_selecao_filial
this.dw_4=create dw_4
this.cb_importar_produto=create cb_importar_produto
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecao_filiais
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.cb_selecao_filial
this.Control[iCurrent+9]=this.dw_4
this.Control[iCurrent+10]=this.cb_importar_produto
this.Control[iCurrent+11]=this.dw_5
end on

on w_ge371_cadastro_promocao_sos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_selecao_filiais)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_selecao_filial)
destroy(this.dw_4)
destroy(this.cb_importar_produto)
destroy(this.dw_5)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1, dw_2, dw_4, dw_5}
This.wf_SetUpdate_DW(lvo_Update)

ivo_Promocao = Create uo_Promocao
ivo_Produto  = Create uo_Produto

dw_1.Event ue_AddRow()
dw_1.SetFocus()

dw_1.ivo_Controle_Menu.of_Incluir(True)
dw_2.ivo_Controle_Menu.of_Incluir(True)

ivo_Promocao.ivs_Tipo = "S"
end event

event close;call super::close;Destroy(ivo_Promocao)

Destroy(ivo_Produto)
end event

event ue_cancel;call super::ue_cancel;dw_1.Event ue_AddRow()
end event

event ue_preopen;call super::ue_preopen;dw_4.Visible = False
end event

event ue_preupdate;call super::ue_preupdate;Date lvdh_Inicio

Long lvl_Cd_Promocao
Long ll_Find

String lvs_Nm_Promocao

dw_1.AcceptText()

lvs_Nm_Promocao = dw_1.Object.nm_promocao_sos	[1]
lvl_Cd_Promocao 	= dw_1.Object.cd_promocao_sos	[1]
lvdh_Inicio			= Date(dw_1.Object.dh_inicio			[1])

If IsNull(lvl_Cd_Promocao) Then
	If Trim(lvs_Nm_Promocao) = "" Or IsNull(lvs_Nm_Promocao) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o nome da promo$$HEX2$$e700e300$$ENDHEX$$o SOS.", Information!)
		dw_1.Event ue_Pos(1,"nm_promocao_sos")
		Return False
	End If
End If

If IsNull(lvdh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1,"dh_inicio")
	Return False
End If
	
If dw_4.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma filial.", Information!)
	Return False
End If
	
If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um produto.", Information!)
	Return False
End If

ll_Find = dw_2.Find("pc_desconto < 0.00 or pc_desconto > 100.00", 1, dw_2.RowCount())

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Percentual de desconto inv$$HEX1$$e100$$ENDHEX$$lido.")
	dw_2.Event ue_Pos(ll_Find, "pc_desconto")
	Return False
End If

Return True
end event

event open;call super::open;SetNull(ivs_Responsavel)

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE371_LIBERACAO_PROCEDIMENTO", ref ivs_Responsavel) Then 
	Return Close(This)
End If

end event

type dw_visual from dc_w_sheet`dw_visual within w_ge371_cadastro_promocao_sos
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge371_cadastro_promocao_sos
end type

type cb_selecao_filiais from commandbutton within w_ge371_cadastro_promocao_sos
integer x = 3072
integer y = 196
integer width = 512
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
end type

event clicked;Boolean lvb_Sucesso = True

Long	lvl_Linha,&
		lvl_Linhas,&
		lvl_Filial,&
		lvl_Find
		
String ls_Filial_SAP

SetPointer(HourGlass!)

uo_ge216_filiais uo_filiais

uo_Filiais = Create uo_ge216_filiais

OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)

SetPointer(Arrow!)

lvl_Linhas = Message.DoubleParm

If lvl_Linhas > 0 Then
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Filial = uo_Filiais.ivl_filial[lvl_Linha]
		
		lvl_Find = dw_3.Find("cd_filial = " + String(lvl_Filial), 1, dw_3.RowCount())
		
		gf_filial_administrada_sap(lvl_Filial, ls_Filial_SAP)
	
		If ls_Filial_SAP = 'S' Then Continue
		
		If lvl_Find > 0 Then
			// Se a filial n$$HEX1$$e300$$ENDHEX$$o tiver marcada o sistema vai marcar
			If dw_3.Object.Id_Filial[lvl_Find] = "N"  Then
				dw_3.Event ue_Seleciona_Filial(lvl_Filial, True)
				dw_3.Object.Id_Filial[lvl_Find] = "S"
			End If
		Else
			If lvl_Find = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + String(lvl_Filial) + " selecionada n$$HEX1$$e300$$ENDHEX$$o foi localizada na lista de filiais.")
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial '" + String(lvl_Filial) + "'")
				lvb_Sucesso = False
				Exit
			End If
		End If
		
	Next
		
End If

If lvb_Sucesso Then
	Parent.ivb_Valida_Salva = True
	
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)		
End If

Destroy(uo_Filiais)
end event

type gb_3 from groupbox within w_ge371_cadastro_promocao_sos
integer x = 2080
integer y = 416
integer width = 1504
integer height = 1276
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filiais"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge371_cadastro_promocao_sos
integer x = 23
integer y = 416
integer width = 2034
integer height = 1276
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge371_cadastro_promocao_sos
integer x = 23
integer width = 2034
integer height = 412
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Promo$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
integer x = 46
integer y = 60
integer width = 1979
integer height = 328
boolean bringtotop = true
string dataobject = "dw_ge371_cadastro_promocao_sos"
end type

event constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}
end event

event editchanged;// Override
If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
		
		//If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_cd_promocao_sap ) Then 			
		//	If Long(ivs_cd_promocao_sap)>0 Then 
		//		wf_desabilita_controles('S')
		//	Else
		//		wf_desabilita_controles('N')
		//	End If 
		//End If 
		
		
		
		//Parent.ivm_Menu.mf_Confirmar(True)
		//Parent.ivm_Menu.mf_Cancelar(True)		
	End If
End If
end event

event ue_key;String lvs_Promocao

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_localizacao" Then
		lvs_Promocao = This.GetText()
		ivo_Promocao.of_Localiza(lvs_Promocao)

		If ivo_Promocao.Localizado Then
			This.Object.Cd_Promocao_SOS[1] = ivo_Promocao.Cd_Promocao

			If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
				If Long(ivs_promocao_sap)>0 Then 
					wf_desabilita_controles('S')
				Else
					wf_desabilita_controles('N')
				End If 
			End If 
			
			This.Event ue_Retrieve()
		End If
	End If
End If
end event

event ue_recuperar;// Override
Long lvl_Promocao

This.AcceptText()
lvl_Promocao = This.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.Event ue_Retrieve()
	dw_4.Event ue_Retrieve()
	ivs_promocao_sap = dw_1.Object.cd_promocao_sap[1]
	This.SetFocus()
	
//If gf_promocao_sap ( This.Object.Cd_Promocao_SOS[1] ,  ivs_cd_promocao_sap ) Then 			
//	If Long(ivs_cd_promocao_sap)>0 Then 
//   	   wf_desabilita_controles('S')
//	Else
//		wf_desabilita_controles('N')
//	End If 
//End If 
	
End If

Return pl_LInhas
end event

event ue_preupdate;call super::ue_preupdate;If IsNull(This.Object.Cd_Promocao_SOS[1]) Then
	This.Object.Cd_Promocao_SOS[1] = wf_Proxima_Promocao()
End If

Return 1
end event

event ue_preretrieve;call super::ue_preretrieve;If wf_Valida_Salva() < 0 Then
	Return -1
Else
	Return 1
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If wf_Valida_Salva() < 0 Then
	Return -1
Else
	This.Reset()
	Return 1
End If
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	Parent.ivb_Valida_Salva = False
	
	dw_2.Reset()
	dw_3.Reset()
	dw_3.Event ue_Retrieve()
	dw_4.Reset()
	
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
End If

Return AncestorReturnValue
end event

type dw_2 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
integer x = 46
integer y = 472
integer width = 1984
integer height = 1208
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge371_cadastro_produto_promocao_sos"
boolean vscrollbar = true
end type

event ue_recuperar;// Override
Long lvl_Promocao

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event editchanged;call super::editchanged;If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	   wf_desabilita_controles('S')
	Else
       	ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')						
	End If
End If 
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Promocao

Decimal ldc_Desconto
Decimal ldc_Desconto_Anterior

DateTime ldt_Alteracao

This.AcceptText()	
	
lvl_Promocao	= dw_1.Object.Cd_Promocao_SOS[1]
ldt_Alteracao	= gf_getserverdate()

For lvl_Linha = 1 To This.RowCount()
	
	ldc_Desconto_Anterior 	= This.Object.pc_desconto_anterior	[ lvl_Linha ]
	ldc_Desconto					= This.Object.pc_desconto				[ lvl_Linha ]
	
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS	[lvl_Linha] = lvl_Promocao
	End If
	
	If ldc_Desconto_Anterior <> ldc_Desconto Then 
		This.Object.dh_alteracao					[ lvl_Linha ] = ldt_Alteracao
		This.Object.nr_matricula_alteracao	[ lvl_Linha ] = ivs_Responsavel
		This.Object.pc_desconto_anterior		[ lvl_Linha ] = ldc_Desconto
	End If 
	
	If IsNull(This.Object.cd_produto[lvl_Linha]) Then
		This.DeleteRow(lvl_Linha)
	End If
Next

Return 1
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_key;call super::ue_key;String lvs_Coluna
lvs_Coluna = This.GetColumnName()


If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	   wf_desabilita_controles('S')
	Else
    	ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')	
				
		If Key = KeyEnter! Then
			Choose Case lvs_Coluna
				Case "de_produto"		
					wf_Localiza_Produto()			
				Case "pc_desconto"
					If Long(ivs_promocao_sap) = 0 Then 
						This.Event ue_AddRow()
					End If 
			End Choose
		End If		
	End If 
End If 


end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull(cd_produto)", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 100)
end event

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto", "de_produto", "pc_desconto"}

lvs_Nome = {"c$$HEX1$$f300$$ENDHEX$$digo", "descri$$HEX2$$e700e300$$ENDHEX$$o", "percentual de desconto"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)


If Long(ivs_promocao_sap) = 0 Then 
	This.ivb_Selecao_Linhas = True
	This.of_SetRowSelection()
End If 
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then

	If Long(ivs_promocao_sap) >0 Then 
		This.ivo_Controle_Menu.of_Excluir(False)
	Else 	
		This.ivo_Controle_Menu.of_Excluir(True)		
	End If

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

	If Long(ivs_promocao_sap) > 0 Then 
		This.ivo_Controle_Menu.of_Excluir(False)
		This.ivo_Controle_Menu.of_Filtrar(False)
		This.ivo_Controle_Menu.of_Classificar(False)	
	Else
		This.ivo_Controle_Menu.of_Excluir(True)
		This.ivo_Controle_Menu.of_Filtrar(True)
		This.ivo_Controle_Menu.of_Classificar(True)	
	End If 
Else
	This.ivo_Controle_Menu.of_Excluir(False)
	This.ivo_Controle_Menu.of_Filtrar(False)
	This.ivo_Controle_Menu.of_Classificar(False)
End If

Return pl_Linhas



end event

type dw_3 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
event ue_seleciona_filial ( long pl_filial,  boolean pb_selecao )
integer x = 2094
integer y = 472
integer width = 1449
integer height = 1200
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge371_filial_promocao_sos"
boolean vscrollbar = true
end type

event ue_seleciona_filial;Long lvl_Linha

lvl_Linha = dw_4.Find("cd_filial = " + String(pl_Filial), 1, dw_4.RowCount())

If lvl_Linha > 0 Then
	If pb_Selecao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(pl_Filial) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	Else
		dw_4.DeleteRow(lvl_Linha)
	End If
Else
	If pb_Selecao Then
		lvl_Linha = dw_4.InsertRow(0)			
		
		dw_4.Object.Cd_Filial[lvl_Linha] = pl_Filial
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(pl_Filial) + "' j$$HEX1$$e100$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	End If
End If

end event

event itemchanged;call super::itemchanged;Boolean lvb_Selecao

If Data = "S" Then
	lvb_Selecao = True
Else
	lvb_Selecao = False
End If

This.Event ue_Seleciona_Filial(This.Object.Cd_Filial[Row], lvb_Selecao)

If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	   wf_desabilita_controles('S')
	Else
       	ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')						
	End If
End If 
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_key;call super::ue_key;If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promocao foi cadastrada no SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar altera$$HEX2$$e700f500$$ENDHEX$$es, somente no SAP!.", Information!)
	End If 
End If 
end event

type cb_selecao_filial from commandbutton within w_ge371_cadastro_promocao_sos
integer x = 3067
integer y = 312
integer width = 512
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Todas Filiais"
end type

event clicked;Long lvl_Linha

Boolean lvb_Selecao

String lvs_Titulo

String ls_Filial_SAP

If This.Text = "&Todas Filiais" Then
	lvs_Titulo  = "&Nenhuma Filial"
	lvb_Selecao = True
Else
	lvs_Titulo  = "&Todas Filiais"
	lvb_Selecao = False
End If


For lvl_Linha = 1 To dw_3.RowCount()
	
		gf_filial_administrada_sap(dw_3.Object.cd_filial[lvl_Linha], ls_Filial_SAP)
	
		If ls_Filial_SAP = 'S' Then Continue
	
		If lvb_Selecao Then
			If dw_3.Object.Id_Filial[lvl_Linha] = "N" Then
				dw_3.Object.Id_Filial[lvl_Linha] = "S"
				dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], True)
			End If
		Else
			If dw_3.Object.Id_Filial[lvl_Linha] = "S" Then
				dw_3.Object.Id_Filial[lvl_Linha] = "N"
				dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], False)
			End If
		End If
	Next

This.Text = lvs_Titulo
Parent.ivb_Valida_Salva = True
end event

type dw_4 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
boolean visible = false
integer x = 2181
integer y = 48
integer width = 882
integer height = 236
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_ge371_filial_promocao_sos_cadastrada"
end type

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Contador, &
     lvl_Linha

If pl_Linhas > 0 Then
	For lvl_Contador = 1 To dw_3.RowCount()
		lvl_Linha = This.Find("cd_filial = " + String(dw_3.Object.Cd_Filial[lvl_Contador]), 1, This.RowCount())
		
		If lvl_Linha > 0 Then
			dw_3.Object.Id_Filial[lvl_Contador] = "S"
			//dw_3.SelectRow(lvl_Contador, True)
		Else
			dw_3.Object.Id_Filial[lvl_Contador] = "N"
			//dw_3.SelectRow(lvl_Contador, False)
		End If
	Next
End If

Return pl_Linhas
end event

event ue_recuperar;// Override
Long lvl_Promocao

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Promocao
	  
lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS[lvl_Linha] = lvl_Promocao
	End If
Next

Return 1
end event

type cb_importar_produto from commandbutton within w_ge371_cadastro_promocao_sos
integer x = 2080
integer y = 312
integer width = 608
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir Produto (.XLS)"
end type

event clicked;String lvs_Path,&
	     lvs_Nome_Arquivo,&
		 lvs_Arquivo,&
		 lvs_Dado,&
		 lvs_Msg, &
		 lvs_Nulo
		 
Integer lvi_Arquivo

Decimal lvdc_Desconto
Decimal lvdc_Desconto_Clube
Decimal lvdc_Retorno

Long lvl_Linhas,   & 
	  lvl_Linha,    &
	  lvl_Produto,  &
	  lvl_Promocao

	  
Integer lvi_Retorno, &
        lvi_Nulo
		  
dw_1.AcceptText()

lvl_Promocao = dw_1.Object.cd_promocao_sos[1]

If IsNull(lvl_Promocao) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	dw_1.Event ue_Pos(1, "de_localizacao")
	Return
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Para importar a planilha de produtos os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A = Produto.~r" + &
					"Coluna B = Desconto")

			
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo <> 1 Then Return

ivl_Linhas = 0

dw_5.Object.nm_arquivo[1] = lvs_Path

lvs_Msg = "Importar os produtos com os descontos do arquivo selecionado ?"
		  
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

dw_2.SetRedRaw(False)

dw_5.AcceptText()
lvs_Arquivo = dw_5.Object.nm_arquivo [1]

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
			
			lvdc_Desconto 			= 0.00
			lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A"))
	
			If IsNumber(lvs_Dado) Then
				lvl_Produto = Long(lvs_Dado)
	
				//Desconto
				lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B"))
				
				If Not wf_valida_desconto( lvl_Linha, lvs_Dado, Ref lvdc_Desconto) Then Exit
								
				//Inclui Promocao_SOS_produto
				If Not wf_Inclui_Promocao_SOS_Produto(lvl_Produto, lvdc_Desconto, lvdc_Desconto_Clube) Then
					Exit
				End If
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(lvl_Linha) + "~rValor: " + lvs_Dado)
				Exit
			End If //Produto
			
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
			
		Next
	
		If ivl_Linhas > 0 Then
			Parent.ivm_Menu.mf_Confirmar(True)
			Parent.ivm_Menu.mf_Cancelar(True)
			Parent.ivb_Valida_Salva = True
		End If

	End If //Linha

End If //Excel

Close(w_Aguarde)

dw_2.SetRedRaw(True)

Destroy(lvo_Excel)
end event

type dw_5 from dc_uo_dw_base within w_ge371_cadastro_promocao_sos
boolean visible = false
integer x = 91
integer y = 760
integer width = 1861
integer height = 112
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge371_selecao_arquivo"
end type

