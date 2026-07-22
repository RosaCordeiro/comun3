HA$PBExportHeader$w_ge419_pedido_empurrado_produto.srw
forward
global type w_ge419_pedido_empurrado_produto from dc_w_sheet
end type
type gb_3 from groupbox within w_ge419_pedido_empurrado_produto
end type
type gb_2 from groupbox within w_ge419_pedido_empurrado_produto
end type
type gb_1 from groupbox within w_ge419_pedido_empurrado_produto
end type
type dw_1 from dc_uo_dw_base within w_ge419_pedido_empurrado_produto
end type
type dw_2 from dc_uo_dw_base within w_ge419_pedido_empurrado_produto
end type
type st_salva from statictext within w_ge419_pedido_empurrado_produto
end type
type dw_3 from dc_uo_dw_base within w_ge419_pedido_empurrado_produto
end type
type cb_1 from commandbutton within w_ge419_pedido_empurrado_produto
end type
end forward

global type w_ge419_pedido_empurrado_produto from dc_w_sheet
integer width = 1879
integer height = 1940
string title = "GE419 - Cadastro de Pedidos Empurrados por Produto"
boolean controlmenu = false
boolean resizable = false
event ue_retrieve ( )
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
st_salva st_salva
dw_3 dw_3
cb_1 cb_1
end type
global w_ge419_pedido_empurrado_produto w_ge419_pedido_empurrado_produto

type variables
uo_produto ivo_produto

uo_pedido_empurrado ivo_pedido
end variables

forward prototypes
public function boolean wf_filial_selecionada ()
public function boolean wf_atualiza_pedido_produto (long al_filial, long al_pedido, long al_produto, long al_qtde)
public subroutine wf_atualiza_qtde_perfil (long al_perfil, long al_qtde)
public subroutine wf_insere_motivo_padrao ()
public function boolean wf_verifica_pedido_ecommerce (long pl_cd_filial, long pl_nr_pedido, long pl_cd_produto, ref boolean pb_ecommerce, ref string ps_log)
end prototypes

event ue_retrieve;dw_2.Event ue_Retrieve()
end event

public function boolean wf_filial_selecionada ();Long lvl_Find

lvl_Find = dw_2.Find("qt_empurrada > 0", 1, dw_2.RowCount())

If lvl_Find > 0 Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma filial para receber o produto.", Information!)
	Return False
End If
end function

public function boolean wf_atualiza_pedido_produto (long al_filial, long al_pedido, long al_produto, long al_qtde);Boolean lvb_Sucesso = True
String lvs_Situacao,&
        	 lvs_Chave,&
		 ls_Matricula,&
		 ls_Tabela,&
		 ls_Coluna,&
		 ls_ChaveHistorico,&
		 ls_Alterado_De,&
		 ls_Alterado_Para,&
		 ls_Motivo,&
		 ls_Matricula_Inclusao

Long ll_Cod_Motivo_Empurrado
		 
// Defini$$HEX2$$e700e300$$ENDHEX$$o de valores
ls_Matricula	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
ls_Tabela 	= 'PEDIDO_EMPURRADO_PRODUTO'
ls_Coluna	='QT_EMPURRADA'

lvs_Chave = " (" + String(al_Filial) + "-" + String(al_Pedido) + "-" + String(al_Produto) + ")"
ls_ChaveHistorico = String(al_Filial) +  '@#!' + String(al_Pedido) +  '@#!' + String(al_Produto)
ls_Alterado_Para = String(al_Qtde)

ll_Cod_Motivo_Empurrado 	= dw_1.Object.cd_Motivo_Empurrado[1]
ls_Motivo							= dw_1.Describe ("Evaluate('LookupDisplay(cd_motivo_empurrado)', " + String(1) + ")")

Select id_situacao, qt_empurrada 
Into :lvs_Situacao,
	  :ls_Alterado_De
From pedido_empurrado_produto
Where cd_filial           = :al_Filial
  and nr_pedido_empurrado = :al_Pedido
  and cd_produto          = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Update pedido_empurrado_produto
		Set qt_empurrada = :al_Qtde
		Where cd_filial      = :al_Filial
		  and nr_pedido_empurrado = :al_Pedido
		  and cd_produto          = :al_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Produto no Pedido" + lvs_Chave)
			lvb_Sucesso = False
		End If
		
		// Insere Registros de Altera$$HEX2$$e700e300$$ENDHEX$$o
		If (string(al_Qtde)<>ls_Alterado_De) Then 
			Insert Into historico_alteracao_tabela   
										( nm_tabela,   
										  de_chave,   
										  nm_coluna,   
										  de_alteracao_de,   
										  de_alteracao_para,   
										  nr_matric_alteracao,   
										  id_alteracao )  
							Values (  :ls_Tabela,
										  :ls_ChaveHistorico,
										  :ls_Coluna,
										  :ls_Alterado_De,
										  :ls_Alterado_Para,
										  :ls_Matricula,
										  'A')
							Using SqlCA;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Ocorreu Erro ao Gravar o Historico Altera$$HEX2$$e700e300$$ENDHEX$$o" + lvs_Chave)
					lvb_Sucesso = False
				End If
		End If	
		
		
	Case 100
		Insert Into pedido_empurrado_produto (cd_filial,   
														  nr_pedido_empurrado,   
														  cd_produto,   
														  qt_empurrada,   
														  qt_faturada,   
														  id_situacao,
														  nr_matricula_inclusao,
														  de_motivo,
														  cd_motivo_empurrado)  
  		Values (:al_Filial,   
				  :al_Pedido,   
				  :al_Produto,   
				  :al_Qtde,   
				  0,   
				  'C',
				  :ls_Matricula,
				  :ls_Motivo,
				  :ll_Cod_Motivo_Empurrado)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Produto no Pedido" + lvs_Chave)
			lvb_Sucesso = False
		End If
		
		// Insere Registros de Inclus$$HEX1$$e300$$ENDHEX$$o
		Insert Into historico_alteracao_tabela   
									( nm_tabela,   
									  de_chave,   
									  nm_coluna,   
									  de_alteracao_de,   
									  de_alteracao_para,   
									  nr_matric_alteracao,   
									  id_alteracao )  
						Values (  :ls_Tabela,
									  :ls_ChaveHistorico,
									  :ls_Coluna,
									  :ls_Alterado_De,
									  :ls_Alterado_Para,
									  :ls_Matricula,
									  'I')
						Using SqlCA;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Ocorreu Erro ao Gravar o Historico Inclusao" + lvs_Chave)
			lvb_Sucesso = False
		End If
		
		
		
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia do Pedido" + lvs_Chave)
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public subroutine wf_atualiza_qtde_perfil (long al_perfil, long al_qtde);Long lvl_Total, &
     lvl_Linha, &
	  lvl_Perfil
	  
String lvs_Possui_Mix
	  
lvl_Total = dw_2.RowCount()

If lvl_Total > 0 Then
	For lvl_Linha = 1 To lvl_Total
		lvl_Perfil     = dw_2.Object.Cd_Perfil_Filial[lvl_Linha]
		lvs_Possui_Mix = dw_2.Object.Id_Possui_Mix   [lvl_Linha]
		
		If lvl_Perfil = al_Perfil and lvs_Possui_Mix = "S" Then
			dw_2.Object.Qt_Empurrada[lvl_Linha] = al_Qtde
		End If		
	Next	
End If
end subroutine

public subroutine wf_insere_motivo_padrao ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_motivo_empurrado", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_motivo_empurrado", 0)
	lvdwc.SetItem(1, "de_motivo_empurrado", "NENHUM")
	
	dw_1.Object.Cd_Motivo_Empurrado[1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Motivo.")
End If
end subroutine

public function boolean wf_verifica_pedido_ecommerce (long pl_cd_filial, long pl_nr_pedido, long pl_cd_produto, ref boolean pb_ecommerce, ref string ps_log);long ll_existe

select count(*)
into :ll_existe
from pedido_empurrado_produto
where cd_filial = :pl_cd_filial
and nr_pedido_empurrado = :pl_nr_pedido
and cd_produto = :pl_cd_produto
and id_ecommerce = 'S';

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela pedido_empurrado_produto: ' + sqlca.sqlerrtext
	return false
end if

if ll_existe > 0 then
	pb_ecommerce = true
else
	pb_ecommerce = false
end if

return true
end function

on w_ge419_pedido_empurrado_produto.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.st_salva=create st_salva
this.dw_3=create dw_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.st_salva
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.cb_1
end on

on w_ge419_pedido_empurrado_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.st_salva)
destroy(this.dw_3)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

//dw_2.Event ue_Retrieve()
dw_3.Event ue_Retrieve()

dw_1.SetFocus()

wf_insere_motivo_padrao()
ivm_Menu.mf_Recuperar(True)
ivm_Menu.mf_Confirmar(True)	
ivm_Menu.mf_Cancelar(True)	
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Pedido)

end event

event ue_cancel;call super::ue_cancel;ivo_Produto.of_Inicializa()

dw_1.Reset()
dw_1.Event ue_AddRow()

dw_2.Reset()

dw_3.Reset()
dw_3.Event ue_Retrieve()

dw_1.Event ue_Pos(1, "de_produto")


end event

event open;call super::open;ivo_Produto = Create uo_Produto
ivo_Pedido  = Create uo_Pedido_Empurrado
end event

event ue_save;// Override

Boolean lvb_Sucesso = True
Boolean lb_ecommerce = false
string ls_log

Long lvl_Produto, &
     lvl_Filial, &
	  lvl_Qtde, &
	  lvl_Total, &
	  lvl_Linha, &
	  lvl_Pedido,&
	  ll_Motivo_Empurrado
	  
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Produto = dw_1.Object.Cd_Produto[1]

If IsNull(lvl_Produto) or lvl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.", Information!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If Not wf_Filial_Selecionada() Then Return -1

ll_Motivo_Empurrado = dw_1.Object.Cd_Motivo_Empurrado[1]

If ll_Motivo_Empurrado = 0 or isnull(ll_Motivo_Empurrado) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione o motivo do pedido empurrado.",Exclamation!)
	dw_1.Event ue_Pos(1, "cd_motivo_empurrado")
	Return -1
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Atualizando os Pedidos das Filiais..."

lvl_Total = dw_2.RowCount()

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Linha = 1 To lvl_Total
	lvl_Filial = dw_2.Object.Cd_Filial   [lvl_Linha]
	lvl_Qtde   = dw_2.Object.Qt_Empurrada[lvl_Linha]
	
	If lvl_Qtde > 0 Then
		If ivo_Pedido.of_Produto_Colocado(lvl_Filial, lvl_Produto, "P") Then
			lvb_Sucesso = False
			Exit
		End If
				
		If ivo_Pedido.of_Pedido_Nao_Processado(lvl_Filial, ref lvl_Pedido) Then
			If IsNull(lvl_Pedido) Then
				If Not ivo_Pedido.of_Inclui_Pedido(lvl_Filial, ref lvl_Pedido) Then
					lvb_Sucesso = False
					Exit
				End If
				
			Else	
				//Alertar se o pedido teve alguma quantidade solicitada pelo ecommerce:
				If Not this.wf_verifica_pedido_ecommerce( lvl_filial, lvl_pedido, lvl_produto, ref lb_ecommerce, ref ls_log) then 
					lvb_Sucesso = false
					Exit
				ENd if
				
				if lb_ecommerce = True Then
					//Perguntar se o usu$$HEX1$$e100$$ENDHEX$$rio deseja alterar a quantidade de pedidos solicitados pelo ecommerce:
					if Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O pedido ' + string(lvl_pedido) + ' da filial ' + string(lvl_filial) + ' possui quantidade solicitada pelo e-Commerce.~n~nDeseja alterar mesmo assim?', question!, yesno!, 2) = 2 then
						Continue
					ENd if
				ENd if
				
			End If
		Else
			lvb_Sucesso = False
			Exit
		End If
		
		If Not wf_Atualiza_Pedido_Produto(lvl_Filial, &
													 lvl_Pedido, &
													 lvl_Produto, &
													 lvl_Qtde) Then
			lvb_Sucesso = False
			Exit
		End If
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

If lvb_Sucesso Then
	SqlCa.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedidos atualizados com sucesso.", Information!)
Else
	SqlCa.of_RollBack()
End If

Close(w_Aguarde)
SetPointer(Arrow!)

Return 1
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge419_pedido_empurrado_produto
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge419_pedido_empurrado_produto
end type

type gb_3 from groupbox within w_ge419_pedido_empurrado_produto
integer x = 18
integer y = 248
integer width = 1833
integer height = 488
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Perfis de Loja"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge419_pedido_empurrado_produto
integer x = 18
integer y = 848
integer width = 1833
integer height = 912
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Filiais"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge419_pedido_empurrado_produto
integer x = 18
integer y = 4
integer width = 1833
integer height = 232
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

type dw_1 from dc_uo_dw_base within w_ge419_pedido_empurrado_produto
integer x = 46
integer y = 60
integer width = 1792
integer height = 164
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge419_selecao"
end type

event itemchanged;call super::itemchanged;If dwo.Name = "de_produto" Then
	If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
		Return 1
	End If	
End If	

end event

event ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If mid(ivo_Produto.cd_subcategoria, 1,1) = '5' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido empurrar produto do grupo ALMOXARIFADO.", StopSign!)
			Return
		End If
		
		If ivo_Produto.Localizado Then
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			
			dw_2.Event ue_Retrieve()
		End If
	End If
End If
end event

event losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_uo_dw_base within w_ge419_pedido_empurrado_produto
integer x = 41
integer y = 900
integer width = 1787
integer height = 836
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge419_lista_filial"
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetRowSelection("", "if(id_possui_mix = ~"S~", rgb(0,0,0), rgb(255,0,0))")
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)

Return pl_Linhas
end event

event ue_recuperar;// Override

Return This.Retrieve(ivo_Produto.Cd_Produto)
end event

type st_salva from statictext within w_ge419_pedido_empurrado_produto
boolean visible = false
integer x = 2386
integer y = 48
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "[Modo Autom$$HEX1$$e100$$ENDHEX$$tico]"
boolean focusrectangle = false
end type

type dw_3 from dc_uo_dw_base within w_ge419_pedido_empurrado_produto
integer x = 41
integer y = 300
integer width = 1787
integer height = 416
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge419_lista_perfil_filial"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_1 from commandbutton within w_ge419_pedido_empurrado_produto
integer x = 809
integer y = 736
integer width = 1047
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Atualizar Baseado nos Perfis de Loja"
end type

event clicked;Long lvl_Contador, &
     lvl_Perfil, &
	  lvl_Qtde
	  
SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando a Quantidade por Perfil de Loja..."

dw_3.AcceptText()

dw_2.SetRedraw(False)	

For lvl_Contador = 1 To dw_3.RowCount()
	lvl_Perfil = dw_3.Object.Cd_Perfil_Filial[lvl_Contador]
	lvl_Qtde   = dw_3.Object.Qt_Empurrada    [lvl_Contador]

	wf_Atualiza_Qtde_Perfil(lvl_Perfil, lvl_Qtde)
Next

dw_2.SetRedraw(True)
dw_2.SetFocus()

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
ivb_Valida_Salva = True

Close(w_Aguarde)
SetPointer(Arrow!)
end event

