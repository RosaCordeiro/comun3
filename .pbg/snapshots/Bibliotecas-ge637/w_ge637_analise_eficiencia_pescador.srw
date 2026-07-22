HA$PBExportHeader$w_ge637_analise_eficiencia_pescador.srw
forward
global type w_ge637_analise_eficiencia_pescador from dc_w_2tab_consulta_selecao_lista_2det
end type
type dw_5 from datawindow within tabpage_1
end type
type dw_6 from datawindow within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type tabpage_3 from userobject within tab_1
end type
type dw_7 from dc_uo_dw_base within tabpage_3
end type
type gb_5 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_7 dw_7
gb_5 gb_5
end type
end forward

global type w_ge637_analise_eficiencia_pescador from dc_w_2tab_consulta_selecao_lista_2det
string tag = "w_ge637_analise_eficiencia_pescador"
integer width = 7090
integer height = 2504
string title = "GE637 - An$$HEX1$$e100$$ENDHEX$$lise efici$$HEX1$$ea00$$ENDHEX$$ncia do pescador"
end type
global w_ge637_analise_eficiencia_pescador w_ge637_analise_eficiencia_pescador

type variables
Boolean	ib_carregar_sku	= False, ib_carregar_demanda_filial	= False
DateTime	idt_dh_inicio_analise, idt_dh_fim_analise
Long		il_cd_filial, il_cd_produto, il_cd_grupo_produto, il_nr_divisao, il_cd_produto_array[]
String	is_filtro	= '', is_nr_comprador, is_cd_fornecedor, is_cd_curva, is_cd_distribuidora, &
			is_id_apenas_prod_ter_ava, is_id_bloqueio_preco = 'T', is_id_cons_rup_geral = 'T', &
			is_id_cons_rup_estadual = 'T', is_id_projeto_conexao, is_lista_produto, is_cd_distribuidora_original
	

uo_fornecedor 			iuo_fornecedor
uo_produto 				iuo_produto
uo_ge149_comprador 	iuo_ge149_comprador
uo_filial				iuo_filial

dc_uo_transacao	ISQLCA_CONSULTA

dc_uo_ds_base ids_avaliar_atendimento_dist_gre3
end variables

forward prototypes
public function boolean wf_montar_sql (ref string as_log)
end prototypes

public function boolean wf_montar_sql (ref string as_log);Try
	tab_1.tabpage_1.dw_2.of_restoreoriginalsql()
	tab_1.tabpage_2.dw_3.of_restoreoriginalsql()
	tab_1.tabpage_3.dw_7.of_restoreoriginalsql()
	ids_avaliar_atendimento_dist_gre3.of_restoresqloriginal()
	
	if not IsNull(il_cd_filial) and il_cd_filial > 0 then
		tab_1.tabpage_1.dw_2.of_appendwhere('aad.cd_filial = ' + String(il_cd_filial))
		ids_avaliar_atendimento_dist_gre3.of_appendwhere('aad.cd_filial = ' + String(il_cd_filial))
		tab_1.tabpage_2.dw_3.of_appendwhere('aad.cd_filial = ' + String(il_cd_filial))
		tab_1.tabpage_3.dw_7.of_appendwhere('aad.cd_filial = ' + String(il_cd_filial))
	end if
	
	if not IsNull(il_cd_produto) and il_cd_produto > 0 then
		tab_1.tabpage_1.dw_2.of_appendwhere('aad.cd_produto = ' + String(il_cd_produto))
		ids_avaliar_atendimento_dist_gre3.of_appendwhere('aad.cd_produto = ' + String(il_cd_produto))
		tab_1.tabpage_2.dw_3.of_appendwhere('aad.cd_produto = ' + String(il_cd_produto))
		tab_1.tabpage_3.dw_7.of_appendwhere('aad.cd_produto = ' + String(il_cd_produto))
	end if

	if not IsNull(is_cd_fornecedor) and Trim(is_cd_fornecedor) <> '' then
		tab_1.tabpage_1.dw_2.of_appendwhere("aad.cd_fornecedor = '" + String(is_cd_fornecedor + "'"))
		ids_avaliar_atendimento_dist_gre3.of_appendwhere("aad.cd_fornecedor = '" + String(is_cd_fornecedor + "'"))
		tab_1.tabpage_2.dw_3.of_appendwhere("aad.cd_fornecedor = '" + String(is_cd_fornecedor + "'"))
		tab_1.tabpage_3.dw_7.of_appendwhere("aad.cd_fornecedor = '" + String(is_cd_fornecedor + "'"))
	end if
	
	if not IsNull(il_cd_grupo_produto) and il_cd_grupo_produto > 0 then
		tab_1.tabpage_1.dw_2.of_appendwhere('aad.cd_grupo_produto = ' + String(il_cd_grupo_produto))
		ids_avaliar_atendimento_dist_gre3.of_appendwhere('aad.cd_grupo_produto = ' + String(il_cd_grupo_produto))
		tab_1.tabpage_2.dw_3.of_appendwhere('aad.cd_grupo_produto = ' + String(il_cd_grupo_produto))
		tab_1.tabpage_3.dw_7.of_appendwhere('aad.cd_grupo_produto = ' + String(il_cd_grupo_produto))
	end if

	if is_cd_distribuidora	= '999999999' then
		tab_1.tabpage_1.dw_2.of_appendwhere("aad.cd_distribuidora is null")
		tab_1.tabpage_1.dw_2.of_appendwhere("aad.cd_distribuidora is null")
		tab_1.tabpage_2.dw_3.of_appendwhere("aad.cd_distribuidora is null")
		tab_1.tabpage_3.dw_7.of_appendwhere("aad.cd_distribuidora is null")
	elseif not IsNull(is_cd_distribuidora) and Trim(is_cd_distribuidora) <> '' then
		tab_1.tabpage_1.dw_2.of_appendwhere("aad.cd_distribuidora = '" + String(is_cd_distribuidora + "'"))
		tab_1.tabpage_1.dw_2.of_appendwhere("aad.cd_distribuidora = '" + String(is_cd_distribuidora + "'"))
		tab_1.tabpage_2.dw_3.of_appendwhere("aad.cd_distribuidora = '" + String(is_cd_distribuidora + "'"))
		tab_1.tabpage_3.dw_7.of_appendwhere("aad.cd_distribuidora = '" + String(is_cd_distribuidora + "'"))
	end if
	
	if not IsNull(il_nr_divisao) and il_nr_divisao > 0 then
		tab_1.tabpage_1.dw_2.of_appendwhere('aad.nr_divisao = ' + String(il_nr_divisao))
		ids_avaliar_atendimento_dist_gre3.of_appendwhere('aad.nr_divisao = ' + String(il_nr_divisao))
		tab_1.tabpage_2.dw_3.of_appendwhere('aad.nr_divisao = ' + String(il_nr_divisao))
		tab_1.tabpage_3.dw_7.of_appendwhere('aad.nr_divisao = ' + String(il_nr_divisao))
	end if

	if not IsNull(is_nr_comprador) and Trim(is_nr_comprador) <> '' then
		tab_1.tabpage_1.dw_2.of_appendwhere("aad.nr_matricula_comprador = '" + String(is_nr_comprador + "'"))
		ids_avaliar_atendimento_dist_gre3.of_appendwhere("aad.nr_matricula_comprador = '" + String(is_nr_comprador + "'"))
		tab_1.tabpage_2.dw_3.of_appendwhere("aad.nr_matricula_comprador = '" + String(is_nr_comprador + "'"))
		tab_1.tabpage_3.dw_7.of_appendwhere("aad.nr_matricula_comprador = '" + String(is_nr_comprador + "'"))
	end if
	
	if is_id_apenas_prod_ter_ava = 'S' then
		tab_1.tabpage_1.dw_2.of_appendwhere("aad.dh_termino_avaliacao <= getdate()")
		ids_avaliar_atendimento_dist_gre3.of_appendwhere("aad.dh_termino_avaliacao <= getdate()")
		tab_1.tabpage_2.dw_3.of_appendwhere("aad.dh_termino_avaliacao <= getdate()")
		tab_1.tabpage_3.dw_7.of_appendwhere("aad.dh_termino_avaliacao <= getdate()")
	end if
	
	if not IsNull(is_cd_curva) then
		tab_1.tabpage_1.dw_2.of_appendwhere("aad.cd_curva_abc_filiais '" + is_cd_curva + "'")
		ids_avaliar_atendimento_dist_gre3.of_appendwhere("aad.cd_curva_abc_filiais '" + is_cd_curva + "'")
		tab_1.tabpage_2.dw_3.of_appendwhere("aad.cd_curva_abc_filiais '" + is_cd_curva + "'")
		tab_1.tabpage_3.dw_7.of_appendwhere("aad.cd_curva_abc_filiais '" + is_cd_curva + "'")
	end if
	
	if is_id_projeto_conexao <> 'T' then
		choose case is_id_projeto_conexao
			case 'A'
				tab_1.tabpage_1.dw_2.of_appendwhere("aad.id_projeto_conexao is not null")
				ids_avaliar_atendimento_dist_gre3.of_appendwhere("aad.id_projeto_conexao is not null")
				tab_1.tabpage_2.dw_3.of_appendwhere("aad.id_projeto_conexao is not null")
				tab_1.tabpage_3.dw_7.of_appendwhere("aad.id_projeto_conexao is not null")
			case 'N'
				tab_1.tabpage_1.dw_2.of_appendwhere("aad.id_projeto_conexao is null")
				ids_avaliar_atendimento_dist_gre3.of_appendwhere("aad.id_projeto_conexao is null")
				tab_1.tabpage_2.dw_3.of_appendwhere("aad.id_projeto_conexao is null")
				tab_1.tabpage_3.dw_7.of_appendwhere("aad.id_projeto_conexao is null")
			case else
				tab_1.tabpage_1.dw_2.of_appendwhere("aad.id_projeto_conexao = '" + is_id_projeto_conexao + "'")
				ids_avaliar_atendimento_dist_gre3.of_appendwhere("aad.id_projeto_conexao = '" + is_id_projeto_conexao + "'")
				tab_1.tabpage_2.dw_3.of_appendwhere("aad.id_projeto_conexao = '" + is_id_projeto_conexao + "'")
				tab_1.tabpage_3.dw_7.of_appendwhere("aad.id_projeto_conexao = '" + is_id_projeto_conexao + "'")
		end choose
	end if

	//Os filtros abaixo s$$HEX1$$f300$$ENDHEX$$ devem alterar os detalhes da consulta
	if is_id_cons_rup_geral <> 'T' then
		Choose Case is_id_cons_rup_geral
			Case 'S'
				tab_1.tabpage_2.dw_3.of_appendwhere("aad.id_ruptura_geral IN ('S')")
				tab_1.tabpage_3.dw_7.of_appendwhere("aad.id_ruptura_geral IN ('S')")
			Case 'N'
				tab_1.tabpage_2.dw_3.of_appendwhere("aad.id_ruptura_geral IN ('A', 'N')")
				tab_1.tabpage_3.dw_7.of_appendwhere("aad.id_ruptura_geral IN ('A', 'N')")
		End Choose
	end if
	
	if is_id_cons_rup_estadual <> 'T' then
		Choose Case is_id_cons_rup_estadual
			Case 'S'
				tab_1.tabpage_2.dw_3.of_appendwhere("aad.id_ruptura_estadual IN ('S')")
				tab_1.tabpage_3.dw_7.of_appendwhere("aad.id_ruptura_estadual IN ('S')")
			Case 'N'
				tab_1.tabpage_2.dw_3.of_appendwhere("aad.id_ruptura_estadual IN ('A', 'N')")
				tab_1.tabpage_3.dw_7.of_appendwhere("aad.id_ruptura_estadual IN ('A', 'N')")
		End Choose
	end if
	
	if is_id_bloqueio_preco <> 'T' then
		tab_1.tabpage_2.dw_3.of_appendwhere("aad.id_bloqueio_preco = '" + is_id_bloqueio_preco + "'")
		tab_1.tabpage_3.dw_7.of_appendwhere("aad.id_bloqueio_preco = '" + is_id_bloqueio_preco + "'")
	end if	
Catch (RunTimeError RTE)
	as_log	= 'Erro ao executar a fun$$HEX2$$e700e300$$ENDHEX$$o wf_montar_sql.~r~rErro: ' + RTE.GetMEssage()
	Return False
Finally
	Return True
End Try
end function

on w_ge637_analise_eficiencia_pescador.create
int iCurrent
call super::create
end on

on w_ge637_analise_eficiencia_pescador.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;iuo_fornecedor 		= Create uo_fornecedor
iuo_produto    		= Create uo_produto
iuo_ge149_comprador	= Create uo_ge149_comprador
iuo_filial				= Create uo_filial

ids_avaliar_atendimento_dist_gre3 = Create dc_uo_ds_base
ids_avaliar_atendimento_dist_gre3.of_ChangeDataObject("ds_ge637_avaliar_atendimento_dist_gre")

gf_ge003_lista_divisao_fornecedor_comp(Tab_1.TabPage_1.dw_1, iuo_fornecedor.Cd_Fornecedor, iuo_ge149_comprador.nr_matricula, 1)
end event

event close;call super::close;Destroy(iuo_fornecedor)
Destroy(iuo_produto)
Destroy(iuo_ge149_comprador)
Destroy(iuo_filial)
Destroy(ids_avaliar_atendimento_dist_gre3 )
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge637_analise_eficiencia_pescador
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge637_analise_eficiencia_pescador
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge637_analise_eficiencia_pescador
integer x = 18
integer width = 7026
integer height = 2304
tabpage_3 tabpage_3
end type

event tab_1::selectionchanging;//
end event

event tab_1::selectionchanged;Long		ll_cd_produto, ll_row_sku
String	ls_null, ls_de_produto
Boolean	lb_salva

ivm_Menu.mf_SalvarComo(false)

Try	
	SetNull(ls_null)
	
	if ib_carregar_sku and oldindex <> newindex and newindex = 2 then
		ib_carregar_sku	= False
		
		tab_1.tabpage_2.dw_3.Retrieve(Date(idt_dh_inicio_analise), Date(idt_dh_fim_analise))
	elseif ib_carregar_demanda_filial and tab_1.tabpage_2.dw_3.RowCount() > 0 and oldindex <> newindex and newindex = 3 then
		ll_row_sku	= tab_1.tabpage_2.dw_3.GetRow()
		if ll_row_sku > 0 then
			ll_cd_produto	= tab_1.tabpage_2.dw_3.GetItemNumber(ll_row_sku, 'cd_produto')
			ls_de_produto	= tab_1.tabpage_2.dw_3.GetItemString(ll_row_sku, 'de_produto')
			
			tab_1.tabpage_3.gb_5.Text	= 'Demanda Filiais | Produto: ' + String(ll_cd_produto) + ' - ' + ls_de_produto
			
			SetNull(ls_null)
			
			ib_carregar_demanda_filial	= False
			
			tab_1.tabpage_3.dw_7.Retrieve(Date(idt_dh_inicio_analise), Date(idt_dh_fim_analise), ll_cd_produto)
		end if
	end if
	
	If newindex <> 1 Then
		If newindex = 3 Then
			If tab_1.tabpage_3.dw_7.RowCount() > 0 Then
				tab_1.tabpage_3.dw_7.ivm_menu.mf_SalvarComo(true)
			end If
		Else 
			If tab_1.tabpage_2.dw_3.RowCount() > 0 Then
				tab_1.tabpage_2.dw_3.setFocus()
				tab_1.tabpage_2.dw_3.ivo_controle_menu.of_SalvarComo(true)
			end If
		End if
	end if
Catch (RunTimeError RTE)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', RTE.GetMEssage(), StopSign!)
	Return -1
Finally
	Return 1
End Try
end event

on tab_1.create
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
end on

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 6990
integer height = 2188
dw_5 dw_5
dw_6 dw_6
cb_1 cb_1
end type

on tabpage_1.create
this.dw_5=create dw_5
this.dw_6=create dw_6
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.dw_6
this.Control[iCurrent+3]=this.cb_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.cb_1)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer y = 592
integer width = 6149
integer height = 1576
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer width = 6149
integer height = 572
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer width = 6085
integer height = 476
string dataobject = "dw_ge637_analise_eficiencia_pescador_param"
end type

event dw_1::itemchanged;call super::itemchanged;String	ls_null


SetNull(ls_null)

		
Choose Case dwo.Name 
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> iuo_filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			iuo_filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = iuo_filial.Cd_Filial
			This.Object.Nm_Filial[1] = iuo_filial.Nm_Fantasia
		End If
	Case "nm_comprador"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> iuo_ge149_comprador.nm_usuario Then
				Return 1
			End If
		Else
			iuo_ge149_comprador.of_Inicializa()
			
			This.Object.nr_comprador[1] = iuo_ge149_comprador.nr_matricula
			This.Object.nm_comprador[1] = iuo_ge149_comprador.nm_usuario
			
			gf_ge003_lista_divisao_fornecedor_comp(Tab_1.TabPage_1.dw_1, iuo_fornecedor.Cd_Fornecedor, iuo_ge149_comprador.nr_matricula, 1)
		End If
	Case "nm_fornecedor"
		If Not IsNull(data) and Trim(data) <> "" Then
			If data <> iuo_fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			iuo_fornecedor.of_Inicializa()
		
			This.Object.cd_fornecedor[1] = iuo_fornecedor.cd_fornecedor
			This.Object.nm_fornecedor[1] = iuo_fornecedor.nm_razao_social
			
			gf_ge003_lista_divisao_fornecedor_comp(Tab_1.TabPage_1.dw_1, iuo_fornecedor.Cd_Fornecedor, iuo_ge149_comprador.nr_matricula, 1)
		End If
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> iuo_produto.de_Produto Then
				Return 1
			End If
		Else
			iuo_produto.of_Inicializa()
			
			This.Object.cd_produto[1] = iuo_produto.cd_produto
			This.Object.de_produto[1] = iuo_produto.de_Produto
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(iuo_ge149_comprador) Then
	This.Object.nr_comprador[1] = iuo_ge149_comprador.nr_matricula
	This.Object.nm_comprador[1] = iuo_ge149_comprador.nm_usuario
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;String	lvs_Nulo

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial"
			iuo_filial.of_Localiza_Filial(This.GetText())
		
			If iuo_filial.Localizada Then
				This.Object.Cd_Filial[1] = iuo_filial.Cd_Filial
				This.Object.Nm_Filial[1] = iuo_filial.Nm_Fantasia
			End If
		Case "nm_comprador"
			iuo_ge149_comprador.of_Localiza_Comprador(This.GetText())
			
			If iuo_ge149_comprador.Localizado Then
				This.Object.nr_comprador[1] = iuo_ge149_comprador.nr_matricula
				This.Object.nm_comprador[1] = iuo_ge149_comprador.nm_usuario
			End If

			gf_ge003_lista_divisao_fornecedor_comp(Tab_1.TabPage_1.dw_1, iuo_fornecedor.Cd_Fornecedor, iuo_ge149_comprador.nr_matricula, 1)
		Case "nm_fornecedor"
			iuo_fornecedor.of_Localiza_Fornecedor(This.GetText())
		
			If iuo_fornecedor.Localizado Then
				dw_1.Object.cd_fornecedor[1] = iuo_fornecedor.cd_fornecedor
				dw_1.Object.nm_fornecedor[1] = iuo_fornecedor.Nm_Razao_Social
			Else
				SetNull(lvs_Nulo)
						
				dw_1.Object.cd_fornecedor[1] = lvs_Nulo
				dw_1.Object.nm_fornecedor[1] = lvs_Nulo
			End If

			gf_ge003_lista_divisao_fornecedor_comp(Tab_1.TabPage_1.dw_1, iuo_fornecedor.Cd_Fornecedor, iuo_ge149_comprador.nr_matricula, 1)
		Case 'de_produto'
			iuo_produto.of_Localiza_produto( This.GetText() )
			
			If Not iuo_produto.Localizado Then Return
				
			This.Object.cd_produto[1] = iuo_produto.cd_produto
			This.Object.de_produto[1] = iuo_produto.de_produto + " : " + iuo_produto.de_apresentacao_venda
	End Choose
End If



end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer y = 656
integer width = 2208
integer height = 1484
string dataobject = "dw_ge637_avaliar_atendimento_dist_res"
boolean vscrollbar = false
string ivs_cor_linha_padrao = "RGB(0,0,0)"
end type

event dw_2::ue_recuperar;Long		ll_row, ll_cd_produto_aux, ll_linhas, ll_for, ll_qt_concentracao
String	ls_null, ls_id_situacao, ls_cd_subcategoria, ls_id_apresentacao, ls_log

dc_uo_ds_base	ids_produtos_busca_facil


Try
	This.SetRedraw(False)
	
	tab_1.tabpage_1.dw_1.AcceptText()
	
	ll_row	= tab_1.tabpage_1.dw_1.GetRow()
	
	il_cd_filial					= tab_1.tabpage_1.dw_1.GetItemNumber(ll_row, 'cd_filial')
	il_cd_produto					= tab_1.tabpage_1.dw_1.GetItemNumber(ll_row, 'cd_produto')
	il_cd_grupo_produto			= tab_1.tabpage_1.dw_1.GetItemNumber(ll_row, 'cd_grupo')
	il_nr_divisao					= tab_1.tabpage_1.dw_1.GetItemNumber(ll_row, 'nr_divisao_fornecedor')
	is_nr_comprador				= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'nr_comprador')
	is_cd_fornecedor				= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'cd_fornecedor')
	is_cd_curva						= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'cd_curva')
	idt_dh_inicio_analise		= tab_1.tabpage_1.dw_1.GetItemDateTime(ll_row, 'dh_inicio_analise')
	idt_dh_fim_analise			= tab_1.tabpage_1.dw_1.GetItemDateTime(ll_row, 'dh_fim_analise')
	is_cd_distribuidora			= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'cd_distribuidora')
	is_id_apenas_prod_ter_ava	= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'id_apenas_prod_ter_ava')
	is_id_projeto_conexao		= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'id_projeto_conexao')
	
	SetNull(ls_null)
	
	If Trim(is_cd_curva) = '' Then SetNull(is_cd_curva)
	
	is_lista_produto	= ''
	
	ib_carregar_sku				= True
	ib_carregar_demanda_filial	= True
	
	if Not IsNull(il_cd_produto) then
		SELECT
			pg.cd_subcategoria,
			pg.id_apresentacao,
			pg.qt_concentracao
		INTO
			:ls_cd_subcategoria,
			:ls_id_apresentacao,
			:ll_qt_concentracao
		FROM
			produto_geral pg
		WHERE
			pg.cd_produto	= :il_cd_produto;
			
		Choose Case SQLCA.SQLCode
			Case -1
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Problema ao consultar dados da produto geral.~r~rErro: ' + SQLCA.SQLErrText, StopSign!)
				Return -1
		End Choose
		
		ids_produtos_busca_facil = Create dc_uo_ds_base
		ids_produtos_busca_facil.of_ChangeDataObject("dw_ge120_produtos_busca_facil")
		
		ids_produtos_busca_facil.Retrieve(il_cd_produto, ls_cd_subcategoria, ls_id_apresentacao, ll_qt_concentracao)
		
		ll_linhas	= ids_produtos_busca_facil.RowCount()
		
		for ll_for = 1 to ll_linhas
			ls_id_situacao	= ids_produtos_busca_facil.GetItemString(ll_for, 'id_situacao')
			
			if ls_id_situacao = 'A' then
				ll_cd_produto_aux	= ids_produtos_busca_facil.GetItemNumber(ll_for, 'cd_produto')
				
				il_cd_produto_array[UpperBound(il_cd_produto_array) + 1] = ll_cd_produto_aux
				
				is_lista_produto += String(ll_cd_produto_aux)
				
				if ll_for < ll_linhas then is_lista_produto += ', '
			end if
		next
	else
		il_cd_produto_array[UpperBound(il_cd_produto_array) + 1] = -1
	end if
	
	is_cd_distribuidora_original	= is_cd_distribuidora
	
	if not wf_montar_sql(REF ls_log) then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log, StopSign!)
		Return -1
	end if
	
	This.Retrieve(Date(idt_dh_inicio_analise), Date(idt_dh_fim_analise))
	ids_avaliar_atendimento_dist_gre3.Retrieve(Date(idt_dh_inicio_analise), Date(idt_dh_fim_analise))
	
Catch (RunTimeError RTE)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', RTE.GetMEssage(), StopSign!)
	Return -1
Finally
	Destroy ids_produtos_busca_facil
	
	This.SetRedraw(True)
	
	Return 1
End Try
end event

event dw_2::rowfocuschanged;//
end event

event dw_2::buttonclicked;call super::buttonclicked;Long		ll_linhas
String	ls_null, ls_log, ls_desc


Try
	SetNull(ls_null)
	
	tab_1.tabpage_2.dw_3.Reset()
	
	tab_1.tabpage_1.dw_1.AcceptText()
		
	is_filtro	= ''
	
	tab_1.tabpage_2.dw_3.SetFilter(is_filtro)
	tab_1.tabpage_2.dw_3.Filter()
	
	is_cd_distribuidora	= is_cd_distribuidora_original
	
	is_id_cons_rup_geral		= 'T'
	is_id_cons_rup_estadual	= 'T'
	is_id_bloqueio_preco		= 'T'
	
	Choose Case dwo.name
		Case 'b_cf_demanda_total'
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_demanda_total_t.Text
		Case 'b_cf_qt_pedido_dist'
			is_filtro	= 'qt_pedido_dist > 0'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_qt_pedido_dist_t.Text
		Case 'b_cf_qt_atendida'
			is_filtro	= 'qt_atendida > 0'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_qt_atendida_t.Text
		Case 'b_cf_qt_faturada'
			is_filtro	= 'qt_faturada > 0'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_qt_faturada_t.Text
		Case 'b_cf_qt_falta_total'
			
			is_filtro	= 'qt_problema <> 0'
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_qt_falta_total_t.Text
		Case 'b_cf_qt_sem_destino_total'
			is_cd_distribuidora		= '999999999'
			is_id_cons_rup_geral		= 'T'
			is_id_cons_rup_estadual	= 'T'
			is_id_bloqueio_preco		= 'T'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_qt_sem_destino_total_t.Text
		Case 'b_cf_demanda_ruptura_geral'
			is_cd_distribuidora		= '999999999'
			is_id_cons_rup_geral		= 'S'
			is_id_cons_rup_estadual	= 'T'
			is_id_bloqueio_preco		= 'T'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_demanda_ruptura_geral_t.Text
		Case 'b_cf_demanda_ruptura_estadual'
			is_cd_distribuidora		= '999999999'
			is_id_cons_rup_geral		= 'N'
			is_id_cons_rup_estadual	= 'S'
			is_id_bloqueio_preco		= 'T'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_demanda_ruptura_estadual_t.Text
		Case 'b_cf_demanda_bloqueio_preco'
			is_cd_distribuidora		= '999999999'
			is_id_cons_rup_geral		= 'N'
			is_id_cons_rup_estadual	= 'N'
			is_id_bloqueio_preco		= 'S'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_demanda_bloqueio_preco_t.Text
		Case 'b_cf_demanda_bloqueio_distribuidoras'
			is_cd_distribuidora		= '999999999'
			is_id_cons_rup_geral		= 'N'
			is_id_cons_rup_estadual	= 'N'
			is_id_bloqueio_preco		= 'N'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_demanda_bloqueio_distribuidoras_t.Text
		Case 'b_cf_qt_nao_solicitada'
			is_filtro	= 'qt_nao_solicitada <> 0'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_qt_nao_solicitada_t.Text
		Case 'b_cf_qt_nao_atendida'
			is_filtro	= 'qt_nao_atendida <> 0'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_qt_nao_atendida_t.Text
		Case 'b_cf_qt_nao_faturada'
			is_filtro	= 'qt_nao_faturada <> 0'
			
			ls_desc	= tab_1.tabpage_1.dw_2.Object.cf_qt_nao_faturada_t.Text
		Case Else
			Return
	End Choose

	tab_1.tabpage_2.dw_3.SetRedraw(False)
	
	if not wf_montar_sql(REF ls_log) then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log, StopSign!)
		Return
	end if
	
	ib_carregar_sku	= True
	
	tab_1.tabpage_2.gb_3.Text = "SKU's | " + Trim(ls_desc)
	tab_1.SelectTab(2)

	tab_1.tabpage_2.dw_3.SetFilter(is_filtro)
	tab_1.tabpage_2.dw_3.Filter()
Catch (RunTimeError RTE)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', RTE.GetMEssage(), StopSign!)
	Return -1
Finally
	tab_1.tabpage_2.dw_3.SetRedraw(True)
	tab_1.tabpage_2.dw_4.SetRedraw(True)
	
	Return 1
End Try

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;DateTime	ldt_dh_emissao
Dec		ldc_pc_atendimento, ldc_pc_sem_destino
Long		ll_new_row, ll_row, ll_qt_falta, ll_linhas, ll_for, ll_qt_faturada, ll_qt_demanda, ll_qt_sem_destino
String	ls_null


Try
	SetNull(ls_null)
	
	tab_1.tabpage_1.dw_5.SetRedraw(False)
	tab_1.tabpage_1.dw_6.SetRedraw(False)
	
	ll_new_row	= 0
		
	if tab_1.tabpage_1.dw_2.RowCount() > 0 then
		ll_row	= tab_1.tabpage_1.dw_2.GetRow()
		
		ll_qt_faturada	= tab_1.tabpage_1.dw_2.GetItemNumber(ll_row, 'qt_faturada')
		ll_qt_falta	= tab_1.tabpage_1.dw_2.GetItemNumber(ll_row, 'qt_falta')
		
		ll_new_row	= tab_1.tabpage_1.dw_6.InsertRow(0)
			
		tab_1.tabpage_1.dw_6.SetItem(ll_new_row, 'categoria', 'Faturada Total')
		tab_1.tabpage_1.dw_6.SetItem(ll_new_row, 'valor', ll_qt_faturada)
		
		ll_new_row	= tab_1.tabpage_1.dw_6.InsertRow(0)
		
		tab_1.tabpage_1.dw_6.SetItem(ll_new_row, 'categoria', 'Falta Total')
		tab_1.tabpage_1.dw_6.SetItem(ll_new_row, 'valor', ll_qt_falta)
	end if
	
	ids_avaliar_atendimento_dist_gre3.Retrieve(Date(idt_dh_inicio_analise), Date(idt_dh_fim_analise))
	
	ll_linhas	= ids_avaliar_atendimento_dist_gre3.RowCount()
	
	tab_1.tabpage_1.dw_5.Reset()
	
	for ll_for = 1 to ll_linhas
		ldt_dh_emissao		= ids_avaliar_atendimento_dist_gre3.GetItemDateTime(ll_for, 'dh_emissao')
		ll_qt_demanda		= ids_avaliar_atendimento_dist_gre3.GetItemNumber(ll_for, 'qt_demanda')
		ll_qt_faturada		= ids_avaliar_atendimento_dist_gre3.GetItemNumber(ll_for, 'qt_faturada')
		ll_qt_sem_destino	= ids_avaliar_atendimento_dist_gre3.GetItemNumber(ll_for, 'qt_sem_destino')
		
		ll_new_row	= tab_1.tabpage_1.dw_5.InsertRow(0)
		
		if ll_new_row > 0 then
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'categoria', String(ldt_dh_emissao, 'dd/mm/yyyy'))
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'serie', 'Demanda Total')
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'valor', 100)
		end if
					
		ldc_pc_atendimento	= (Dec(ll_qt_faturada) / Dec(ll_qt_demanda)) * 100
		
		ll_new_row	= tab_1.tabpage_1.dw_5.InsertRow(0)
		
		if ll_new_row > 0 then
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'categoria', String(ldt_dh_emissao, 'dd/mm/yyyy'))
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'serie', '% Faturada')
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'valor', ldc_pc_atendimento)
		end if
		
		ldc_pc_sem_destino	= (Dec(ll_qt_sem_destino) / Dec(ll_qt_demanda)) * 100
		
		ll_new_row	= tab_1.tabpage_1.dw_5.InsertRow(0)
		
		if ll_new_row > 0 then
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'categoria', String(ldt_dh_emissao, 'dd/mm/yyyy'))
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'serie', '% Sem Destino')
			tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'valor', ldc_pc_sem_destino)
		end if
	next
	
	tab_1.tabpage_1.dw_5.SetRedraw(True)
	tab_1.tabpage_1.dw_6.SetRedraw(True)
Catch (RunTimeError RTE)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', RTE.GetMessage())
	Return -1
Finally
	Return 1
End Try

return 1
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 6990
integer height = 2188
string text = "Resumo SKU"
end type

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
boolean visible = false
integer x = 6304
integer y = 1004
integer width = 535
integer height = 1016
string text = "Demandas por Sku"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer width = 5998
integer height = 2160
string text = "SKU~'s | 1. Demanda Total"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer width = 5915
integer height = 2060
string dataobject = "dw_ge637_avaliar_atendimento_dist_skus"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_selecao_linhas = true
boolean ivb_ordena_colunas = true
end type

event dw_3::rowfocuschanged;call super::rowfocuschanged;ib_carregar_demanda_filial = True
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
boolean visible = false
integer x = 6363
integer y = 1012
integer width = 457
integer height = 948
string dataobject = "dw_ge637_avaliar_atendimento_dist_dmd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_selecao_linhas = true
boolean ivb_ordena_colunas = true
end type

type dw_5 from datawindow within tabpage_1
integer x = 3803
integer y = 644
integer width = 2277
integer height = 1392
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge637_gr_analise_efic_pesc_evo_line"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_6 from datawindow within tabpage_1
integer x = 2272
integer y = 644
integer width = 1536
integer height = 1392
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge637_gr_analise_efic_pesc_tot"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within tabpage_1
integer x = 4009
integer y = 88
integer width = 494
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar Per$$HEX1$$ed00$$ENDHEX$$odo"
end type

event clicked;Boolean	lb_monitora_tempo_execucao	= True
DateTime	ldt_dh_inicio_analise, ldt_dh_fim_analise, ldt_dh_emissao_ant, ldt_dh_emissao
Dec{2}	ldc_ruptura
Long		ll_cd_filial, ll_cd_produto, ll_cd_grupo_produto, ll_nr_divisao, ll_row, ll_dias_alerta_ruptura, &
			ll_for, ll_qt_demanda_total, ll_new_row, ll_qt_falta_total, ll_cf_qt_faturada
String	ls_log, ls_cd_fornecedor, ls_cd_distribuidora, ls_nr_comprador, ls_cd_curva, ls_id_rede_filial, &
			ls_cd_unidade_federacao, ls_id_apenas_prod_ter_ava, ls_id_bloqueio_preco, ls_id_cons_rup_geral, &
			ls_id_cons_rup_estadual

dc_uo_ds_base									ldc_uo_ads_base_list_avaliar_atend_dist
dc_uo_ds_base									ldc_uo_ads_base_list_avaliar_atend_dist_sku
uo_ge637_analise_eficiencia_pescador	luo_ge637_analise_eficiencia_pescador


Try
	tab_1.tabpage_1.dw_2.Reset()	
	tab_1.tabpage_2.dw_3.Reset()
	tab_1.tabpage_2.dw_4.Reset()
	
	tab_1.tabpage_1.dw_1.AcceptText()
	
	ll_row	= tab_1.tabpage_1.dw_1.GetRow()
	
	ll_cd_filial					= tab_1.tabpage_1.dw_1.GetItemNumber(ll_row, 'cd_filial')
	ll_cd_produto					= tab_1.tabpage_1.dw_1.GetItemNumber(ll_row, 'cd_produto')
	ll_cd_grupo_produto			= tab_1.tabpage_1.dw_1.GetItemNumber(ll_row, 'cd_grupo')
	ll_nr_divisao					= tab_1.tabpage_1.dw_1.GetItemNumber(ll_row, 'nr_divisao_fornecedor')
	ls_nr_comprador				= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'nr_comprador')
	ls_cd_fornecedor				= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'cd_fornecedor')
	ls_cd_curva						= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'cd_curva')
	ldt_dh_inicio_analise		= tab_1.tabpage_1.dw_1.GetItemDateTime(ll_row, 'dh_inicio_analise')
	ldt_dh_fim_analise			= tab_1.tabpage_1.dw_1.GetItemDateTime(ll_row, 'dh_fim_analise')
	ls_cd_distribuidora			= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'cd_distribuidora')
	ls_id_apenas_prod_ter_ava	= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'id_apenas_prod_ter_ava')
	ls_id_bloqueio_preco			= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'id_bloqueio_preco')
	ls_id_cons_rup_geral			= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'id_cons_rup_geral')
	ls_id_cons_rup_estadual		= tab_1.tabpage_1.dw_1.GetItemString(ll_row, 'id_cons_rup_estadual')
	
	ldc_ruptura					= 50.00
	ll_dias_alerta_ruptura	= 5
	
	luo_ge637_analise_eficiencia_pescador			= Create uo_ge637_analise_eficiencia_pescador
	ldc_uo_ads_base_list_avaliar_atend_dist		= Create dc_uo_ds_base
	ldc_uo_ads_base_list_avaliar_atend_dist_sku	= Create dc_uo_ds_base

	If Not luo_ge637_analise_eficiencia_pescador.of_handle(ll_cd_filial, &
																			ls_id_rede_filial, &
																			ls_cd_unidade_federacao, &
																			ldt_dh_inicio_analise, &
																			ldt_dh_fim_analise, &
																			ll_cd_produto, &
																			ll_cd_grupo_produto, &
																			ll_nr_divisao, &
																			ls_cd_curva, &
																			ls_id_apenas_prod_ter_ava, &
																			ls_nr_comprador, &
																			ls_cd_distribuidora, &
																			ls_cd_fornecedor, &
																			ls_id_cons_rup_estadual, &
																			ls_id_cons_rup_geral, &
																			ldc_ruptura, &
																			ll_dias_alerta_ruptura, &
																			ls_id_bloqueio_preco, &
																			lb_monitora_tempo_execucao, &
																			REF ls_log) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log, StopSign!)
		Return -1
	End If
	
	Destroy luo_ge637_analise_eficiencia_pescador
	
	tab_1.tabpage_1.dw_2.SetRedraw(False)
	ldc_uo_ads_base_list_avaliar_atend_dist.RowsCopy(ldc_uo_ads_base_list_avaliar_atend_dist.GetRow(), ldc_uo_ads_base_list_avaliar_atend_dist.RowCount(), Primary!, tab_1.tabpage_1.dw_2, 1, Primary!)
	
	Destroy ldc_uo_ads_base_list_avaliar_atend_dist
	
	tab_1.tabpage_1.dw_2.Sort()
	tab_1.tabpage_1.dw_2.GroupCalc()
	
	ldt_dh_emissao_ant	= DateTime('1900-01-01')
	
	ll_new_row	= 0
	
	if tab_1.tabpage_1.dw_2.RowCount() > 0 then
		ll_cf_qt_faturada	= tab_1.tabpage_1.dw_2.GetItemNumber(1, 'cf_qt_faturada')
		ll_qt_falta_total	= tab_1.tabpage_1.dw_2.GetItemNumber(1, 'cf_qt_falta_total')
		
		ll_new_row	= tab_1.tabpage_1.dw_6.InsertRow(0)
			
		tab_1.tabpage_1.dw_6.SetItem(ll_new_row, 'categoria', 'Faturada Total')
		tab_1.tabpage_1.dw_6.SetItem(ll_new_row, 'valor', ll_cf_qt_faturada)
		
		ll_new_row	= tab_1.tabpage_1.dw_6.InsertRow(0)
		
		tab_1.tabpage_1.dw_6.SetItem(ll_new_row, 'categoria', 'Falta Total')
		tab_1.tabpage_1.dw_6.SetItem(ll_new_row, 'valor', ll_qt_falta_total)
	end if
	
	ll_new_row	= 0
	
	for ll_for	= 1 to tab_1.tabpage_1.dw_2.RowCount()
		ldt_dh_emissao			= tab_1.tabpage_1.dw_2.GetItemDateTime(ll_for, 'dh_emissao')
		
		if ldt_dh_emissao <> ldt_dh_emissao_ant then
			ldt_dh_emissao_ant	= ldt_dh_emissao
			
			ll_qt_demanda_total	= tab_1.tabpage_1.dw_2.GetItemNumber(ll_for, 'cf_demanda_per_emissao')
			ll_cf_qt_faturada		= tab_1.tabpage_1.dw_2.GetItemNumber(ll_for, 'cf_qt_faturada_per_emissao')
			
			ll_new_row	= tab_1.tabpage_1.dw_5.InsertRow(0)
			
			if ll_new_row > 0 then
				tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'valor', ll_qt_demanda_total)
				tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'categoria', String(ldt_dh_emissao, 'dd/mm/yyyy'))
				tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'serie', 'Demanda')
			end if
			
			ll_new_row	= tab_1.tabpage_1.dw_5.InsertRow(0)
			
			if ll_new_row > 0 then
				tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'valor', ll_cf_qt_faturada)
				tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'categoria', String(ldt_dh_emissao, 'dd/mm/yyyy'))
				tab_1.tabpage_1.dw_5.SetItem(ll_new_row, 'serie', 'Faturada')
			end if
		end if
	next
	
	tab_1.tabpage_1.dw_2.SetRedraw(True)
	
	tab_1.tabpage_2.dw_3.SetRedraw(False)
	ldc_uo_ads_base_list_avaliar_atend_dist_sku.RowsCopy(ldc_uo_ads_base_list_avaliar_atend_dist_sku.GetRow(), ldc_uo_ads_base_list_avaliar_atend_dist_sku.RowCount(), Primary!, tab_1.tabpage_2.dw_3, 1, Primary!)
	
	Destroy ldc_uo_ads_base_list_avaliar_atend_dist_sku
	
	tab_1.tabpage_2.dw_3.SetRedraw(True)
	
	tab_1.tabpage_2.dw_4.SetRedraw(False)
	tab_1.tabpage_1.dw_2.RowsCopy(tab_1.tabpage_1.dw_2.GetRow(), tab_1.tabpage_1.dw_2.RowCount(), Primary!, tab_1.tabpage_2.dw_4, 1, Primary!)
	tab_1.tabpage_2.dw_4.SetRedraw(True)
Catch (RunTimeError RTE)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', RTE.GetMEssage(), StopSign!)
	Return -1
Finally
	Destroy ldc_uo_ads_base_list_avaliar_atend_dist_sku
	Destroy ldc_uo_ads_base_list_avaliar_atend_dist
	Destroy luo_ge637_analise_eficiencia_pescador
	
	Return 1
End Try
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 6990
integer height = 2188
long backcolor = 67108864
string text = "Demandas Filiais"
long picturemaskcolor = 536870912
dw_7 dw_7
gb_5 gb_5
end type

on tabpage_3.create
this.dw_7=create dw_7
this.gb_5=create gb_5
this.Control[]={this.dw_7,&
this.gb_5}
end on

on tabpage_3.destroy
destroy(this.dw_7)
destroy(this.gb_5)
end on

type dw_7 from dc_uo_dw_base within tabpage_3
integer x = 46
integer y = 48
integer width = 6834
integer height = 2112
integer taborder = 20
string dataobject = "dw_ge637_avaliar_atendimento_dist_dmd"
boolean vscrollbar = true
boolean ivb_selecao_linhas = true
boolean ivb_ordena_colunas = true
end type

type gb_5 from groupbox within tabpage_3
integer x = 18
integer width = 6949
integer height = 2176
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Demandas Filiais"
end type

