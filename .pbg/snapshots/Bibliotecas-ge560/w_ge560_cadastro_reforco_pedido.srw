HA$PBExportHeader$w_ge560_cadastro_reforco_pedido.srw
forward
global type w_ge560_cadastro_reforco_pedido from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge560_cadastro_reforco_pedido
end type
type st_1 from statictext within w_ge560_cadastro_reforco_pedido
end type
type dw_3 from dc_uo_dw_base within w_ge560_cadastro_reforco_pedido
end type
end forward

global type w_ge560_cadastro_reforco_pedido from dc_w_cadastro_selecao_lista
string tag = "w_ge560_cadastra_reforco_pedido"
integer width = 4343
integer height = 2136
string title = "GE560 - Retirar Produtos do Refor$$HEX1$$e700$$ENDHEX$$o"
cb_1 cb_1
st_1 st_1
dw_3 dw_3
end type
global w_ge560_cadastro_reforco_pedido w_ge560_cadastro_reforco_pedido

type variables
uo_produto ivo_Produto

String is_Operador
String is_incluido_manual = 'N'
String ivs_altera = ''


dc_uo_ds_base ids_historico 

String ivs_Operador


end variables

forward prototypes
public function boolean wf_grava_historico (long pl_cd_produto, string ps_tipo_alteracao, integer pl_linha)
public subroutine wf_inicializa ()
public function boolean wf_localiza_produto (long pl_produto, long pl_linha)
public function boolean wf_produto_cadastrado (long pl_cd_produto, ref string ps_existe, string ps_tipo_reforco, ref string ps_msg)
public subroutine wf_incluir_tabela_historico (integer pl_count, string ps_tipo_reforco, string ps_tipo_acao, string ps_cd_produto)
public subroutine _documentacao ()
end prototypes

public function boolean wf_grava_historico (long pl_cd_produto, string ps_tipo_alteracao, integer pl_linha);String lvs_matricula, lvs_id_tipo_reforco, ls_chave, lvs_ValorPara, ls_erro, lvs_tipo_alteracao
DateTime lvdh_data_inclusao

dw_2.AcceptText()

SELECT pp.id_tipo_reforco, pp.nr_matricula_inclusao, pp.dh_inclusao
    INTO :lvs_id_tipo_reforco, :lvs_matricula, :lvdh_data_inclusao	
  FROM produto_reforco_pedido pp
WHERE pp.cd_produto = :pl_cd_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgdbError()
		Return False
End Choose


ls_Chave = String(pl_cd_produto)

If gf_Houve_Alteracao_Dw(dw_2, 'ID_TIPO_REFORCO', pl_linha , ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_REFORCO_PEDIDO', ls_Chave, 'ID_TIPO_REFORCO', lvs_id_tipo_reforco , lvs_ValorPara, is_Operador, ps_tipo_alteracao, Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(dw_2, 'NR_MATRICULA_INCLUSAO', pl_linha , ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_REFORCO_PEDIDO', ls_Chave, 'NR_MATRICULA_INCLUSAO', lvs_matricula, lvs_ValorPara, is_Operador, ps_tipo_alteracao , Ref ls_Erro, True) Then Return False
End If

If gf_Houve_Alteracao_Dw(dw_2, 'DH_INCLUSAO', pl_linha , ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_REFORCO_PEDIDO', ls_Chave, 'DH_INCLUSAO', String(lvdh_data_inclusao), lvs_ValorPara, is_Operador, ps_tipo_alteracao , Ref ls_Erro, True) Then Return False
End If

Return True
end function

public subroutine wf_inicializa ();ivo_Produto.of_Inicializa()
dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque


end subroutine

public function boolean wf_localiza_produto (long pl_produto, long pl_linha);Long ll_Produto

Select cd_produto
Into :ll_Produto
From produto_geral
Where cd_produto =:pl_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto n$$HEX1$$e300$$ENDHEX$$o cadastrado. Favor analisar a lista antes de importar. Linha do Erro: " + String(pl_linha) + " - Produto: " + String(pl_produto) ,StopSign!)  
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto.")
		Return False
End Choose

Return True
end function

public function boolean wf_produto_cadastrado (long pl_cd_produto, ref string ps_existe, string ps_tipo_reforco, ref string ps_msg);long ll_produto


Select count(1)
   Into :ll_produto
 From produto_reforco_pedido
Where cd_produto			=:pl_cd_produto
    and id_tipo_reforco 	=:ps_tipo_reforco
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	ps_msg = 'Erro ao acessar a tabela Produto Refor$$HEX1$$e700$$ENDHEX$$o Pedido!'
	Return False
End If	

If ll_produto = 0 Then
	ps_existe = 'N'
	Return False	
End If

ps_existe = 'S'

Return True

end function

public subroutine wf_incluir_tabela_historico (integer pl_count, string ps_tipo_reforco, string ps_tipo_acao, string ps_cd_produto);// Fun$$HEX2$$e700e300$$ENDHEX$$o para atualizar o processo de historico
Long ll_linha_hist

ll_linha_hist = ids_historico.insertRow(0)   

If pl_count = 1 Then
	ids_historico.Object.nm_tabela				[ll_linha_hist] 		= 'PRODUTO_REFORCO_PEDIDO' 
	ids_historico.Object.nm_coluna				[ll_linha_hist] 		= 'ID_TIPO_REFORCO' 
	ids_historico.Object.de_chave				[ll_linha_hist] 		= ps_cd_produto + '@#!' + ps_tipo_reforco
	ids_historico.Object.dh_alteracao			[ll_linha_hist] 		= Today()
	ids_historico.Object.de_alteracao_para	[ll_linha_hist]		= ps_tipo_reforco
	ids_historico.Object.nr_matric_alteracao	[ll_linha_hist]		= is_operador
	ids_historico.Object.id_alteracao			[ll_linha_hist]		= ps_tipo_acao
ElseIf pl_count = 2 Then
	ids_historico.Object.nm_tabela				[ll_linha_hist] 		= 'PRODUTO_REFORCO_PEDIDO' 
	ids_historico.Object.nm_coluna				[ll_linha_hist] 		= 'NR_MATRICULA_INCLUSAO' 
	ids_historico.Object.de_chave				[ll_linha_hist] 		= ps_cd_produto + '@#!' + ps_tipo_reforco
	ids_historico.Object.dh_alteracao			[ll_linha_hist] 		= Today()
	ids_historico.Object.de_alteracao_para	[ll_linha_hist]		= is_operador
	ids_historico.Object.nr_matric_alteracao	[ll_linha_hist]		= is_operador
	ids_historico.Object.id_alteracao			[ll_linha_hist]		= ps_tipo_acao
Else
	ids_historico.Object.nm_tabela				[ll_linha_hist] 		= 'PRODUTO_REFORCO_PEDIDO'
	ids_historico.Object.nm_coluna				[ll_linha_hist] 		= 'DH_INCLUSAO' 
	ids_historico.Object.de_chave				[ll_linha_hist] 		= ps_cd_produto + '@#!' + ps_tipo_reforco
	ids_historico.Object.dh_alteracao			[ll_linha_hist] 		= Today()
	ids_historico.Object.de_alteracao_para	[ll_linha_hist]		= String(Today(),"dd/mm/yyyy hh:mm:ss")
	ids_historico.Object.nr_matric_alteracao	[ll_linha_hist]		= is_operador
	ids_historico.Object.id_alteracao			[ll_linha_hist]		= ps_tipo_acao
End If	
end subroutine

public subroutine _documentacao ();/*
	  Objetivo: Retirar produtos do Refor$$HEX1$$e700$$ENDHEX$$o. Existem dois tipo de Refor$$HEX1$$e700$$ENDHEX$$o, D - DISTRIBUIDORA, E - ESTOQUE CENTRAL
	Chamado: 1092847
Respons$$HEX1$$e100$$ENDHEX$$vel: Saulo Braga

Layout das Celulas:	A - C$$HEX1$$f300$$ENDHEX$$digo do Produto
							B - Tipo de Refor$$HEX1$$e700$$ENDHEX$$o

Tabelas: 
			- hitorico_altera$$HEX2$$e700e300$$ENDHEX$$o_tabela
			- produto_reforco_pedido

Est$$HEX1$$e100$$ENDHEX$$ tela est$$HEX1$$e100$$ENDHEX$$ sendo disponibilizada nos seguintes Sistemas: CO e GC.		
*/
end subroutine

on w_ge560_cadastro_reforco_pedido.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_3
end on

on w_ge560_cadastro_reforco_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_3)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto		= Create uo_Produto
ids_historico 	= Create dc_uo_ds_base

// Verifica acesso no procedimento
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE560_CADASTRO_REFORCO_PEDIDO", ref ivs_Operador) Then
	Close(This)
	Return
End If

dw_1.object.tipo_reforco[1] = 'D'
	
If Not ids_historico.of_ChangeDataObject("ds_ge560_historico") Then
	SqlCa.of_rollback()
	Return 
End If

is_Operador = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Incluir(True)





end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ids_historico)

end event

event ue_retrieve;call super::ue_retrieve;ivm_Menu.mf_excluir(False)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge560_cadastro_reforco_pedido
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge560_cadastro_reforco_pedido
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge560_cadastro_reforco_pedido
integer x = 78
integer y = 80
integer width = 1879
integer height = 184
string dataobject = "dw_ge560_selecao"
boolean livescroll = false
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				dw_1.Object.cd_produto			[This.Getrow()] = ivo_Produto.cd_produto
				dw_1.Object.de_produto 		[This.Getrow()] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	This.Object.de_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_produto" Then
	If Not IsNull(Data) and Data <> "" Then
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		ivo_Produto.of_Inicializa()
		
		This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
		This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge560_cadastro_reforco_pedido
integer x = 32
integer width = 4256
integer height = 1536
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge560_cadastro_reforco_pedido
integer width = 1961
integer height = 272
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge560_cadastro_reforco_pedido
event ue_ ( )
integer x = 78
integer width = 4174
integer height = 1416
string dataobject = "dw_ge560_lista"
end type

event dw_2::ue_addrow;Long lvl_cd_produto, ll_find, ll_cont_hist
String lvs_tipo_reforco, lvs_existe, lvs_msg

long lvl_cont, lvl_cd_produto_dw

lvl_cd_produto		= dw_1.object.cd_produto[1]
lvs_tipo_reforco	= dw_1.object.tipo_reforco[1]

For lvl_cont = 1 To This.RowCount()
	lvl_cd_produto_dw = dw_2.object.cd_produto[lvl_cont]
	If This.object.seleciona[lvl_cont] = 'S' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Antes de inluir um produto, necess$$HEX1$$e100$$ENDHEX$$rio desmarcar o produto: " + String(lvl_cd_produto_dw) + ", selecionado para exclus$$HEX1$$e300$$ENDHEX$$o.")
		dw_1.SetColumn("de_produto")
		Return -1	
	End If
Next


If lvs_tipo_reforco = 'T' Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o tipo de Refor$$HEX1$$e700$$ENDHEX$$o no qual quer incluir.")
	dw_1.SetColumn("tipo_reforco")
	Return -1
End If 	

If IsNull(lvl_cd_produto) or lvl_cd_produto = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o produto para cadastro.")
	dw_1.SetColumn("de_produto")
	Return -1
End If

// Verifica se o produto $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido
If  wf_produto_cadastrado(lvl_cd_produto, ref lvs_existe, lvs_tipo_reforco, ref lvs_msg ) Then
	cb_1.enabled = True
	//wf_inicializa()
	dw_1.SetColumn("de_produto")
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto j$$HEX1$$e100$$ENDHEX$$ Cadastrado para o Tipo de Refor$$HEX1$$e700$$ENDHEX$$o.")
	Return - 1
Else 
	If lvs_msg <> '' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_msg,StopSign!)
	End If	
End If	


ll_find = This.Find(" cd_produto = " + String(lvl_cd_produto) + " and id_tipo_reforco = '" + lvs_tipo_reforco + "'" , 1 , This.Rowcount() )

If ll_find > 0  Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto j$$HEX1$$e100$$ENDHEX$$ incluido para o tipo de Refor$$HEX1$$e700$$ENDHEX$$o.")
	Return -1
End If	

For ll_cont_hist = 1 To 3
	wf_incluir_tabela_historico(ll_cont_hist,lvs_tipo_reforco,'I',String(lvl_cd_produto))
Next

call super::ue_addrow


// For$$HEX1$$e700$$ENDHEX$$a ao confirmar validar o evento ue_save
ivb_Valida_Salva = True
//Informando que houve uma inclus$$HEX1$$e300$$ENDHEX$$o manual, caso tenha um importa$$HEX2$$e700e300$$ENDHEX$$o ainda n$$HEX1$$e300$$ENDHEX$$o salva, incluir na importa$$HEX2$$e700e300$$ENDHEX$$o e salva tudo juntos
is_incluido_manual = 'S'

//If lvs_tipo_reforco = 'T' Then
//	SetNull(lvs_tipo_reforco)
//End If 

This.object.cd_produto[getrow()]                    = lvl_cd_produto
This.object.dh_inclusao[getrow()] 				= Today()
This.object.nr_matricula_inclusao[getrow()] 	= is_operador 
This.object.id_tipo_reforco[getrow()]				=	lvs_tipo_reforco


ivm_Menu.mf_cancelar( True)
ivm_Menu.mf_confirmar( True)

AncestorReturnValue = 1

Return AncestorReturnValue
end event

event dw_2::ue_update;// Overrider
Long ll_cont_hist, lvl_ret

This.AcceptText()

String lvs_tipo_reforco, lvs_existe
Long ll_find, lvl_cd_produto, lvl_cont, lvl_row

If This.Rowcount() > 0 Then
	lvl_cd_produto	 = this.object.cd_produto[getrow()]
	lvs_tipo_reforco = this.object.id_tipo_reforco[getrow()]
	
	ll_find = This.Find(" cd_produto = " + String(lvl_cd_produto), 1 , This.Rowcount() )
	
	If IsNull(ll_find) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Informe o c$$HEX1$$f300$$ENDHEX$$digo do Produto.')
		Return -1
	End If	
	
	ll_find = This.Find(" id_tipo_reforco = '" + lvs_tipo_reforco + "'", 1 , This.Rowcount() )
	
	If IsNull(ll_find) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Informe o Tipo de Refor$$HEX1$$e700$$ENDHEX$$o.')
		Return -1
	End If	

	dwItemStatus l_status

   	For lvl_cont = 1 To dw_2.rowCount() 
		If dw_2.object.seleciona[lvl_cont] = 'S' Then	
			 l_status = this.GetItemStatus( lvl_cont , "id_tipo_reforco", Primary!)
			 If  l_status <> NotModified!  Then
				lvl_cd_produto	 = this.object.cd_produto[lvl_cont]
				If Not wf_grava_historico(lvl_cd_produto,'A',lvl_cont) Then
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao gravar Hist$$HEX1$$f300$$ENDHEX$$rico de Produto.')
					Return -1	
				End If
			End If	
		End If
	Next 
  //  SqlCa.of_Commit( )
End If

long lvi_Retorno 

lvi_Retorno = dw_2.Update()
	
If lvi_Retorno < 0 Then
	SqlCa.of_RollBack( )
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Erro ao incluir dados da Importa$$HEX2$$e700e300$$ENDHEX$$o. ')
	Return -1
End If

If Isvalid(ids_historico) and ids_historico.RowCount() > 0 Then
	lvi_Retorno = ids_historico.Update()
End If
	
If lvi_Retorno < 0 Then
	SqlCa.of_RollBack( )
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Dados n$$HEX1$$e300$$ENDHEX$$o atualizados na tabela HIST$$HEX1$$d300$$ENDHEX$$RICO ALTERACAO TABELA.')
	Return -1
End If

SqlCa.of_Commit( )

ids_historico.Reset()



dw_1.object.tipo_reforco[1] = 'D'
ivo_Produto.of_Inicializa()
is_incluido_manual = 'N'
		
dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque

cb_1.enabled = True

This.event ue_recuperar( )

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Concluido com Sucesso"')

ivm_Menu.mf_recuperar(True)
ivm_Menu.mf_Incluir(True)
ivm_Menu.mf_excluir(False)


Return 1
end event

event dw_2::ue_recuperar;//Overrider
String lvs_tp_reforco
Long lvl_cd_produto

dw_1.AcceptText()

lvs_tp_reforco	= dw_1.Object.tipo_reforco[1]
lvl_cd_produto	= dw_1.Object.cd_produto[1]

If dw_2.RowCount() > 0 Then
	If ids_historico.rowcount() > 0 Then
		If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Existem dados importados sem salvar, deseja prosseguir mesmo assim?' ,Exclamation!,YesNo!,2)  = 2 Then
			Return -1
		End If	
	End If
End If

If Not dw_3.of_ChangeDataObject("ds_ge560_reforco_lista_rel") Then
	Return -1
End If


call super:: ue_recuperar

ivm_Menu.mf_salvarcomo( True)

This.of_AppendWhere(" pp.id_tipo_reforco = '" + lvs_tp_reforco +"'")
dw_3.of_AppendWhere(" pp.id_tipo_reforco = '" + lvs_tp_reforco +"'")

If lvl_cd_produto > 0  Then
	This.of_AppendWhere(" pp.cd_produto = " + String(lvl_cd_produto) )
	dw_3.of_AppendWhere(" pp.cd_produto = " + String(lvl_cd_produto) )
End If

dw_3.retrieve()


Return This.Retrieve()






end event

event dw_2::ue_cancel;call super::ue_cancel;dw_1.object.tipo_reforco[1] = 'D'

cb_1.enabled = True
ivm_Menu.mf_recuperar(True)
ids_historico.reset()


end event

event dw_2::ue_deleterow;// Overrider
Long lvl_cd_produto, ll_cont_hist, lvl_cont, lvl_row, lvi_Retorno, ll_find_existe, lvl_linha, lvl_ret, ll_find
String lvs_tipo_reforco, lvs_erro
Long ll_existe

String ls_habilita_menu = 'N'

Boolean lb_Sucesso = True
Boolean lb_auto

lvl_row = dw_2.rowcount()

ll_find_existe = dw_2.find(" seleciona = 'S' ", 1 , lvl_row)

If ll_find_existe = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Favor selecionar o produto para Exclus$$HEX1$$e300$$ENDHEX$$o. ')
	Return False
End If

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja excluir o(s) Produto(s) selecionado(s)?",exclamation!,yesno!,2) = 2 Then
	Return False
End if

For lvl_cont = 1 To dw_2.rowcount()
	
	If dw_2.object.seleciona[lvl_cont] = 'S' Then

    		lvl_cd_produto		= This.object.cd_produto[lvl_cont]
	   	lvs_tipo_reforco    = This.object.id_tipo_reforco[lvl_cont]
		dw_2.DeleteRow(lvl_cont)		

		Select count(1)
	        Into :ll_existe
	      From produto_reforco_pedido 
         Where cd_produto 		=:lvl_cd_produto
			And id_tipo_reforco 	=:lvs_tipo_reforco
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Erro ao acessar a tabela PRODUTO REFOR$$HEX1$$c700$$ENDHEX$$O PEDIDO!',STOPSIGN!)
			Exit
		End If
		
	    If ll_existe > 0 Then
             ls_habilita_menu = 'S'
			For ll_cont_hist = 1 To 3
				wf_incluir_tabela_historico(ll_cont_hist,lvs_tipo_reforco,'E',String(lvl_cd_produto))
			Next
		Else 
			ls_habilita_menu = 'N'
	    End if
	
				
	End If
	
	ll_find = dw_2.find(" seleciona = 'S' ",1,dw_2.rowcount())
		
	If 	ll_find = 0 Then
		lvl_cont = dw_2.rowcount()
	ElseIf ll_find <=  dw_2.rowcount() Then
		lvl_cont = ll_find -1
	End If	
	
	
Next

// For$$HEX1$$e700$$ENDHEX$$a ao confirmar validar o evento ue_save
ivb_Valida_Salva = True

If ls_habilita_menu = 'S' Then
	ivm_Menu.mf_recuperar(False)
	ivm_Menu.mf_Incluir(False)
	ivm_Menu.mf_excluir(False)
	ivm_Menu.mf_cancelar( True)
	ivm_Menu.mf_confirmar( True)
End If

If dw_2.rowcount() = 0 Then
	ivm_Menu.mf_excluir(False)	
End If	
	

Return True
end event

event dw_2::clicked;//Overrider
long lvl_row, lvl_cont, lvl_find
Boolean lb_result

If dwo.Name = "p_seleciona" or dwo.name = "seleciona" Then
	
	ivm_Menu.mf_excluir(True)
	
	lvl_row = This.rowCount()
		
	lvl_find = This.find(" seleciona = 'S' " , 1, lvl_row)
	
	If dwo.Name = "p_seleciona" Then
		For lvl_cont = 1 To lvl_row
			If lvl_find = 0 Then
				This.object.seleciona[lvl_cont] = 'S'
			Else	
				This.object.seleciona[lvl_cont] = 'N'
			End If
		Next
	End If	
// For$$HEX1$$e700$$ENDHEX$$a ao confirmar validar o evento ue_save
	ivb_Valida_Salva = False
	ivm_Menu.mf_cancelar( False)
	ivm_Menu.mf_confirmar( False)	
End If

call super :: clicked


end event

event dw_2::itemchanged;call super::itemchanged;If dwo.Name = "p_seleciona" or dwo.name = "seleciona" Then
	// For$$HEX1$$e700$$ENDHEX$$a ao confirmar validar o evento ue_save
	ivb_Valida_Salva = False
	ivm_Menu.mf_cancelar( False)
	ivm_Menu.mf_confirmar( False)	
End If
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If dw_2.GetColumnName() = "p_seleciona" or dw_2.GetColumnName() = "seleciona" Then
	// For$$HEX1$$e700$$ENDHEX$$a ao confirmar validar o evento ue_save
	ivb_Valida_Salva = False
	ivm_Menu.mf_cancelar( False)
	ivm_Menu.mf_confirmar( False)	
End If
end event

event dw_2::ue_saveas;//Overrider
Long ll_ret

//ll_ret = This.RowsCopy(This.GetRow(), This.RowCount(), Primary!, dw_3, 1, Primary!)

//This.ShareData(dw_3)

dw_3.Event ue_SaveAs()
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type cb_1 from commandbutton within w_ge560_cadastro_reforco_pedido
integer x = 2487
integer y = 148
integer width = 617
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Refor$$HEX1$$e700$$ENDHEX$$o"
end type

event clicked;// Processo para importar uma planilha em excel, para um determinado tipo de refor$$HEX1$$e700$$ENDHEX$$o.
// Para importa$$HEX2$$e700e300$$ENDHEX$$o o arquivo dever$$HEX1$$e100$$ENDHEX$$ seguir o layout.
String lvs_Arquivo,&
	   	lvs_Nome,&
	   	lvs_Nulo, &
		lvs_Mensagem, &
		lvs_cd_reforco, &
		lvs_tipo_reforco, &
		lvs_de_reforco, & 
		lvs_existe, &
		lvs_Produto, lvs_erro
		
dc_uo_excel lvo_Excel		

Integer lvi_Retorno 

Long	lvl_Linhas, &
		lvl_Linha,&
		lvl_Find,&
		lvl_Linha_dw2, &
		ll_cont_hist, &
		ll_linha_hist, &
		lvl_linha_reforco

Long lvl_cont, lvl_cd_produto		
		
Any lva_cd_produto

For lvl_cont = 1 To dw_2.RowCount()
	lvl_cd_produto = dw_2.object.cd_produto[lvl_cont]
	If dw_2.object.seleciona[lvl_cont] = 'S' Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Antes de importar, necess$$HEX1$$e100$$ENDHEX$$rio desmarcar o(s) produto(s): " + String(lvl_cd_produto) + ", selecionado para exclus$$HEX1$$e300$$ENDHEX$$o." )
	dw_1.SetColumn("de_produto")
	cb_1.enabled = True
	Return -1	
	End If
Next

lvs_tipo_reforco = dw_1.object.tipo_reforco[1]

If lvs_tipo_reforco = 'D' Then
	lvs_de_reforco = 'DISTRIBUIDORA'
Else
		lvs_de_reforco = 'ESTOQUE CENTRAL'
End If

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Voc$$HEX1$$ea00$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ assumindo a Planilha: ' + lvs_de_reforco + ". Deseja Importar?  ~n~n Layout - (celulas):  ~n~n 'A' - C$$HEX1$$f300$$ENDHEX$$digo Produto. ~n 'B' - Tipo de Refor$$HEX1$$e700$$ENDHEX$$o." ,Exclamation!,YesNo!,2)  = 2 Then
	cb_1.enabled = True
	Return
End If

lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Arquivo, lvs_Nome, "XLS", "Excel (*.XLS),*.XLS")

If lvi_Retorno = 0 then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Importa$$HEX2$$e700e300$$ENDHEX$$o Cancelada.")
	cb_1.enabled = True
	Return -1
End If

lvo_Excel = Create dc_uo_excel

If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		
		For lvl_Linha = 1 To lvl_Linhas
			
			If Not IsValid(w_aguarde) then
				Open(w_aguarde)
	  		End If	
	  		w_aguarde.Title = "Processando Refor$$HEX1$$e700$$ENDHEX$$o de Pedido:"
	  		w_aguarde.uo_progress.of_reset()
	  		w_aguarde.uo_progress.Of_SetMax(lvl_Linhas )	
					
			// Produto
			lva_cd_produto      	= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
	         lvs_Produto = String(lva_cd_produto)
         		
			If Not IsNumber(lvs_Produto) Then
				dw_2.reset()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor n$$HEX1$$e300$$ENDHEX$$o num$$HEX1$$e900$$ENDHEX$$rico. Favor analisar a lista antes de importar. Linha do Erro: " + string(lvl_Linha) + " - Produto: " + lvs_Produto,StopSign!)
				cb_1.enabled = True
				wf_inicializa()
				ids_historico.reset()
             		Exit   
             End If
			
			If IsNull(lvs_Produto) or lvs_Produto = '' Then
				dw_2.reset()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor nulo ou igual a zero. Favor analisar a lista antes de importar. Linha Erro: " + string(lvl_Linha) ,StopSign!)
				cb_1.enabled = True
				ids_historico.reset()
				wf_inicializa()
				Exit
			End If
			
			 w_aguarde.Title   = "Produto:" + lvs_Produto + "-> Tipo Refor$$HEX1$$e700$$ENDHEX$$o:"  +lvs_de_reforco  + "->Nro:" + String(lvl_Linha)+" De:"+String(lvl_Linhas)
			
			// Verifica se o produto $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido
			If Not wf_Localiza_Produto(Long(lvs_Produto),lvl_linha) Then
				cb_1.enabled = True
				dw_2.reset()
				wf_inicializa()
				ids_historico.reset()
				Exit
			End If	
		
			// Verifica se o produto $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido
			If  wf_produto_cadastrado(Long(lvs_Produto), ref lvs_existe, lvs_tipo_reforco, ref lvs_erro ) Then
				cb_1.enabled = True
				dw_2.reset()
				wf_inicializa()
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto j$$HEX1$$e100$$ENDHEX$$ Cadastrado para o Tipo de Refor$$HEX1$$e700$$ENDHEX$$o. Favor analisar a lista antes de importar. Linha do Erro: " + String(lvl_linha) + " - Produto: " + lvs_Produto,StopSign!)
				ids_historico.reset()
				Exit
			Else
				If lvs_erro <> '' Then
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_erro,stopsign!)
					ids_historico.reset()
					Exit
				End If
			End If	
		
			ivo_Produto.of_Localiza_Produto(lvs_Produto)
		
			If ivo_Produto.Localizado Then
			
				lvl_Find = dw_2.Find("cd_produto = " + String(ivo_Produto.cd_produto) + " and id_tipo_reforco = '"  + lvs_tipo_reforco + "'", 1, dw_2.RowCount())
			
				If lvl_Find > 1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto em duplicidade na lista. Favor analisar a lista antes de importar. Linha do Erro: " +  + String(lvl_linha) + " - Produto: " + lvs_Produto,StopSign!)
					dw_2.reset()
					cb_1.enabled = True
					ids_historico.reset()
					wf_inicializa()
					Exit
				End If
				
				If lvl_Find > 0 Then Continue
				
			End If	
			
			// 3 campos para inclus$$HEX1$$e300$$ENDHEX$$o
			For ll_cont_hist = 1 To 3
				wf_incluir_tabela_historico(ll_cont_hist,lvs_tipo_reforco,'I',lvs_Produto)
              Next
			
			lvl_linha_reforco = dw_2.insertrow(0)
			
			dw_2.Object.cd_produto					[lvl_linha_reforco] 	= ivo_Produto.cd_produto
			dw_2.Object.id_tipo_reforco			[lvl_linha_reforco] 	= lvs_tipo_reforco	
			dw_2.Object.dh_inclusao					[lvl_linha_reforco] 	= Today()
			dw_2.Object.nr_matricula_inclusao	[lvl_linha_reforco] 	= is_operador
			
			w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)
			
		Next
	  
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		cb_1.enabled = True
		Return
	End If
End If

Close(w_aguarde)

// For$$HEX1$$e700$$ENDHEX$$a ao confirmar validar o evento ue_save
ivb_Valida_Salva = True

wf_inicializa()

If dw_2.Rowcount( ) > 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados importados com SUCESSO.")
	ivm_Menu.mf_cancelar(True)
	ivm_Menu.mf_confirmar(True)
Else
	ivm_Menu.mf_cancelar(False)
	ivm_Menu.mf_confirmar(False)
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados n$$HEX1$$e300$$ENDHEX$$o Importados.")
End If	
end event

type st_1 from statictext within w_ge560_cadastro_reforco_pedido
integer x = 41
integer y = 1852
integer width = 1527
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "**Este Cadastro Retira os Produtos do Refor$$HEX1$$e700$$ENDHEX$$o"
boolean focusrectangle = false
end type

type dw_3 from dc_uo_dw_base within w_ge560_cadastro_reforco_pedido
boolean visible = false
integer x = 3410
integer y = 28
boolean bringtotop = true
string dataobject = "ds_ge560_reforco_lista_rel"
end type

