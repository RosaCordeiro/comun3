HA$PBExportHeader$w_ge247_consulta_nf_transferencia.srw
forward
global type w_ge247_consulta_nf_transferencia from dc_w_2tab_consulta_selecao_lista_2det
end type
type cb_imprimir_etiqueta from commandbutton within tabpage_1
end type
type cb_solicita_canc_sap from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type cb_salva_excel from commandbutton within tabpage_1
end type
type cb_imprimir_nota from commandbutton within tabpage_1
end type
type cb_1 from picturebutton within tabpage_2
end type
end forward

global type w_ge247_consulta_nf_transferencia from dc_w_2tab_consulta_selecao_lista_2det
string tag = "w_ge247_consulta_nf_transferencia"
integer width = 4649
integer height = 2352
string title = "GE247 - Consulta de Notas Fiscais de Transfer$$HEX1$$ea00$$ENDHEX$$ncias"
end type
global w_ge247_consulta_nf_transferencia w_ge247_consulta_nf_transferencia

type variables
uo_Filial ivo_Filial_Origem
uo_Filial ivo_Filial_Destino

uo_natureza_operacao ivo_cfop

uo_produto ivo_produto

Boolean ib_iniciado_operacao_sap = false

string is_situacao

st_parametros_protocolo ist_parametros_protocolo
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public function boolean wf_busca_datas_nota_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, ref datetime adt_dh_recebido_sap, ref datetime adt_dh_cancelamento, ref datetime adt_dh_solicitacao_canc, ref string as_log)
public function boolean wf_exibe_oculta_botao_solicita_canc_sap ()
public function boolean wf_atualiza_nota_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, string as_operador, ref string as_log)
public function boolean wf_busca_chave_nfe (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_chave_nfe, ref string as_log)
public function boolean wf_grava_log_exportacao_sap (long al_filial, long al_nota, string as_especie, string as_serie, string as_cd_chave, datetime adt_dh_documento, ref string as_log, long al_pedido_distribuidora)
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Grupo Produto*/
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")

Tab_1.Tabpage_1.dw_1.Object.cd_grupo[1] = "0"

/*Subgrupo Produto*/
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_subgrupo" )			

ldwc_Child.SetItem(1, "cd_subgrupo", "0")
ldwc_Child.SetItem(1, "de_subgrupo", "TODOS")
ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.SetFilter("cd_grupo='0'")
ldwc_Child.Filter()
Tab_1.Tabpage_1.dw_1.Object.cd_subgrupo[1] = "0"

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", "TD")
ldwc_Child.SetItem(1, "de_lei_generico", "TODAS")

Tab_1.Tabpage_1.dw_1.Object.id_lei_generico[1] = "TD"

/*UF Origem*/
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

Tab_1.Tabpage_1.dw_1.Object.cd_uf[1] = "TD"


/*UF Destino */
ldwc_Child  = Tab_1.Tabpage_1.dw_1.of_InsertRow_DDDW("cd_uf_dest" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

Tab_1.Tabpage_1.dw_1.Object.cd_uf_dest[1] = "TD"
end subroutine

public function boolean wf_busca_datas_nota_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, ref datetime adt_dh_recebido_sap, ref datetime adt_dh_cancelamento, ref datetime adt_dh_solicitacao_canc, ref string as_log);SetNull(adt_dh_recebido_sap)
SetNull(adt_dh_cancelamento)
SetNull(adt_dh_solicitacao_canc)

Select dh_recebido_sap, dh_cancelamento, dh_solicitacao_canc
Into :adt_dh_recebido_sap, :adt_dh_cancelamento, :adt_dh_solicitacao_canc
From nf_transferencia
Where cd_filial_origem	= :al_Filial
	and nr_nf				= :al_Nota
	and de_especie			= :as_especie
	and de_serie			= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro ao buscar as datas de recebimento SAP, cancelamento e solicita$$HEX2$$e700e300$$ENDHEX$$o cancelamento na tabela nf_transferencia."
	Return False
End If

Return True

end function

public function boolean wf_exibe_oculta_botao_solicita_canc_sap ();Return (gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "WS" And ib_iniciado_operacao_sap)
end function

public function boolean wf_atualiza_nota_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, string as_operador, ref string as_log);
Update nf_transferencia
Set dh_solicitacao_canc = Getdate(), nr_matricula_solic_canc = :as_operador
Where cd_filial_origem 		= :al_Filial
	and nr_nf			= :al_Nota
	and de_especie	= :as_especie
	and de_serie		= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro ao atualizar a data de cancelamento na tabela nf_transferencia."
	Return False
End If

Return True

end function

public function boolean wf_busca_chave_nfe (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_chave_nfe, ref string as_log);boolean lb_ret = True
SetNull(as_chave_nfe)

Select top 1 de_chave_acesso
Into :as_chave_nfe
From nf_transferencia_nfe
Where cd_filial_origem	= :al_filial
	and nr_nf				= :al_Nota
	and de_especie			= :as_especie
	and de_serie			= :as_serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		Sqlca.of_MsgDbError("Erro ao buscar a chave da NFE  na tabela nf_transferencia_nfe.")
		lb_ret = False
	Case 100
		as_log = "Nota fiscal de tranfer$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o localizada na tabela de integra$$HEX2$$e700e300$$ENDHEX$$o [nf_transferencia_nfe]."
		lb_ret = False
End Choose

If ( IsNull(as_chave_nfe) Or Trim(as_chave_nfe)="" ) Then
	as_log = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso [de_chave_acesso] n$$HEX1$$e300$$ENDHEX$$o informada na tabela de notas fiscais eletr$$HEX1$$f400$$ENDHEX$$nicas [nf_transferencia_nfe]."
	lb_ret = False
End If

Return lb_ret

end function

public function boolean wf_grava_log_exportacao_sap (long al_filial, long al_nota, string as_especie, string as_serie, string as_cd_chave, datetime adt_dh_documento, ref string as_log, long al_pedido_distribuidora);String ls_Log

st_log_export_sap st_log

st_log.cd_chave 				= string(al_filial, '0000') + '@#!'  + string(al_nota) + '@#!' + as_especie + '@#!' + as_serie
st_log.id_tipo_nf 				= 'WMV'
st_log.cd_tipo_documento   = 'WMV'
st_log.id_tipo_log 				= 77
st_log.cd_filial  					= al_filial
st_log.cd_parametro_geral  = 'DH_INICIO_OPERACAO_SAP'
st_log.nr_nf						= al_nota
st_log.de_especie				= as_especie
st_log.de_serie					= as_serie
st_log.dh_documento			= adt_dh_documento
st_log.cd_integer 				= al_pedido_distribuidora
st_log.cd_chave_interface	= as_cd_chave

If al_filial  = 534 Then st_log.cd_fornecedor	= '053404705'

If Not gf_insere_log_exportacao_sap(st_log, ref as_log) then
	Return False
End If			

Return True
end function

on w_ge247_consulta_nf_transferencia.create
int iCurrent
call super::create
end on

on w_ge247_consulta_nf_transferencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Filial_Origem)
Destroy(ivo_Filial_Destino)
Destroy(ivo_produto)
Destroy(ivo_cfop)
end event

event ue_postopen;call super::ue_postopen;String ls_msg

ivm_Menu.Mf_Recuperar(True)

wf_insere_padrao()

If Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_iniciado_operacao_sap, ref ls_msg ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_msg,StopSign!)
	Post Event Close(this)
End If

tab_1.tabpage_1.cb_solicita_canc_sap.visible = wf_exibe_oculta_botao_solicita_canc_sap()
end event

event ue_preopen;call super::ue_preopen;// Determina as dimens$$HEX1$$f500$$ENDHEX$$es dos folders
// Sele$$HEX2$$e700e300$$ENDHEX$$o
//ivl_Largura_1 	= 3980
//ivl_Altura_1 		= 2698

// Detalhes
//ivl_Largura_2 	= 3791
//ivl_Altura_2 		= 2698

//Maxheight	= 9999
//MaxWidth	= 4000

ivo_produto			= Create uo_produto
ivo_cfop				= Create uo_natureza_operacao
ivo_Filial_Origem	= Create uo_Filial
ivo_Filial_Destino	= Create uo_Filial
end event

event resize;call super::resize;Tab_1.Height = NewHeight - 18
Tab_1.Width = NewWidth - 20

Tab_1.tabpage_1.gb_2.Height = NewHeight - Tab_1.tabpage_1.gb_2.Y - 150
Tab_1.tabpage_1.dw_2.Height = Tab_1.tabpage_1.gb_2.Height - 90

Tab_1.tabpage_2.gb_4.Height = NewHeight - Tab_1.tabpage_2.gb_4.Y - 150
Tab_1.tabpage_2.dw_4.Height = Tab_1.tabpage_2.gb_4.Height - 90
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge247_consulta_nf_transferencia
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge247_consulta_nf_transferencia
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge247_consulta_nf_transferencia
integer width = 4576
integer height = 2144
end type

event tab_1::selectionchanged;//OVerRide
SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
	//	This.Width  = Parent.ivl_Largura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
	//	This.Width  = Parent.ivl_Largura_2	
		
		Tab_1.TabPage_2.dw_3.SetFocus()
End Choose
	
//Parent.Width  = This.Width + 100
SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 4539
integer height = 2028
cb_imprimir_etiqueta cb_imprimir_etiqueta
cb_solicita_canc_sap cb_solicita_canc_sap
cb_2 cb_2
cb_3 cb_3
cb_salva_excel cb_salva_excel
cb_imprimir_nota cb_imprimir_nota
end type

on tabpage_1.create
this.cb_imprimir_etiqueta=create cb_imprimir_etiqueta
this.cb_solicita_canc_sap=create cb_solicita_canc_sap
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_salva_excel=create cb_salva_excel
this.cb_imprimir_nota=create cb_imprimir_nota
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir_etiqueta
this.Control[iCurrent+2]=this.cb_solicita_canc_sap
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_salva_excel
this.Control[iCurrent+6]=this.cb_imprimir_nota
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_imprimir_etiqueta)
destroy(this.cb_solicita_canc_sap)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_salva_excel)
destroy(this.cb_imprimir_nota)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer y = 636
integer width = 4489
integer height = 1372
integer taborder = 10
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer width = 3854
integer height = 560
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer x = 41
integer y = 76
integer width = 3794
integer height = 476
integer taborder = 30
string dataobject = "dw_ge247_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
cb_imprimir_etiqueta.enabled = false
cb_2.enabled = false
end event

event dw_1::itemchanged;call super::itemchanged;DataWindowChild ldw_Child

Choose Case Dwo.name
	Case "cd_grupo"
		If Data <> '1' Then This.Object.id_lei_generico [Row] = 'TD'
	
		If This.GetChild("cd_subgrupo", ldw_Child) = 1 Then
			ldw_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+Data+"')")
			ldw_Child.Filter()
			This.Object.cd_subgrupo [Row] = '0'
		End If
		
	Case "nm_cfop"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cfop.de_natureza_operacao Then
				Return 1
			End If	
		Else			
			ivo_cfop.Of_Inicializa()
			
			This.Object.nm_cfop	[1] = ivo_cfop.de_natureza_operacao
			This.Object.cd_cfop	[1] = ivo_cfop.cd_natureza_operacao
			
		End If	

	Case "nm_filial"
		If data <> ivo_Filial_Origem.nm_Fantasia Then
			Return 1
		End If	
		
		If IsNull(data) Then
					
			ivo_Filial_Origem.Of_inicializa( )
			
			This.Object.Cd_Filial	[1] = ivo_Filial_Origem.Cd_Filial
			This.Object.Nm_Filial	[1] = ivo_Filial_Origem.Nm_Fantasia
			
		End If		
		
	Case "nm_filial_dest"
		If data <> ivo_Filial_Destino.nm_Fantasia Then
			Return 1
		End If	
		
		If IsNull(data) Then
					
			ivo_Filial_Destino.Of_inicializa( )
			
			This.Object.cd_filial_dest		[1] = ivo_Filial_Destino.Cd_Filial
			This.Object.nm_filial_dest	[1] = ivo_Filial_Destino.Nm_Fantasia
			
		End If		
		
	Case "de_produto"
		If Trim(Data) <> "" Then
			If Data <> (ivo_Produto.de_produto+': '+ivo_produto.de_apresentacao_venda) Then
				Return 1
			End If
		Else
					
			ivo_Produto.Of_inicializa( )
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.De_produto
			
		End If		

	
End Choose		
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial_Origem) Then 
	This.Object.Nm_Filial[1] = ivo_Filial_Origem.Nm_Fantasia
End If	

If IsValid(ivo_Filial_Destino) Then 
	This.Object.Nm_Filial_Dest[1] = ivo_Filial_Destino.Nm_Fantasia
End If	

If IsValid(ivo_produto) Then 
	If ivo_produto.Localizado Then 
		This.Object.De_Produto [1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_venda
	Else
		This.Object.De_Produto [1] = ''
	End If
End If	

If IsValid(ivo_cfop) Then 
	This.Object.nm_cfop [1] = ivo_cfop.de_natureza_operacao
End If
end event

event dw_1::ue_addrow;call super::ue_addrow;This.Object.Dt_Inicio		[1] = Today()
This.Object.Dt_Fim		[1] = Today()

Return AncestorReturnValue
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = dw_1.GetColumnName()

If key = KeyEnter! Then	   	 
	Choose Case lvs_Coluna
		Case "nm_filial"

			ivo_Filial_Origem.of_Localiza_Filial(This.GetText())
			
			// Verifica se a Filial foi localizada e atualiza a DW
			If ivo_Filial_Origem.Localizada Then
				This.Object.Cd_Filial	[1] = ivo_Filial_Origem.Cd_Filial
				This.Object.Nm_Filial	[1] = ivo_Filial_Origem.Nm_Fantasia
			Else
			
				ivo_Filial_Origem.Of_inicializa( )
				
				This.Object.Cd_Filial	[1] = ivo_Filial_Origem.Cd_Filial
				This.Object.Nm_Filial	[1] = ivo_Filial_Origem.Nm_Fantasia
			End If
			
		Case "nm_filial_dest"

			ivo_Filial_Destino.of_Localiza_Filial(This.GetText())
			
			// Verifica se a Filial foi localizada e atualiza a DW
			If ivo_Filial_Destino.Localizada Then
				This.Object.Cd_Filial_Dest	[1] = ivo_Filial_Destino.Cd_Filial
				This.Object.Nm_Filial_Dest	[1] = ivo_Filial_Destino.Nm_Fantasia
			Else
			
				ivo_Filial_Destino.Of_inicializa( )
				
				This.Object.Cd_Filial_Dest[1] = ivo_Filial_Destino.Cd_Filial
				This.Object.Nm_Filial_Dest[1] = ivo_Filial_Destino.Nm_Fantasia
			End If
			
		Case "de_produto"
			ivo_produto.of_localiza_produto(This.GetText())
			
			If ivo_produto.Localizado Then
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_venda
			Else
				ivo_produto.of_Inicializa( )
				
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto
			End If
			
		Case "nm_cfop"
			ivo_cfop.of_localiza_natureza(This.GetText())
			
			If ivo_cfop.Localizado Then
				  
				This.Object.cd_cfop	[1] = ivo_cfop.cd_natureza_operacao
				This.Object.nm_cfop	[1] = ivo_cfop.de_natureza_operacao
				
			End If
	End Choose
End If
end event

event dw_1::getfocus;call super::getfocus;dw_2.ivo_Controle_Menu.of_Atualiza()
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_sort;dw_2.Event ue_Sort()
end event

event dw_1::ue_saveas;dw_2.Event ue_SaveAs()
end event

event dw_1::ue_print;dw_2.Event ue_Print()
end event

event dw_1::ue_printimmediate;dw_2.Event ue_PrintImmediate()
end event

event dw_1::ue_filter;dw_2.Event ue_Filter()
end event

event dw_1::ue_clearfilter;dw_2.Event ue_ClearFilter()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 55
integer y = 704
integer width = 4443
integer height = 1260
integer taborder = 40
string dataobject = "dw_ge247_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::editchanged;call super::editchanged;If This.RowCount() > 0 Then
	ivm_Menu.mf_SalvarComo(True)
	cb_salva_excel.Enabled = True
End If
end event

event dw_2::ue_retrieve;call super::ue_retrieve;If AncestorReturnValue > 0 Then
	This.Event RowFocusChanged(1)
	
	ivm_Menu.mf_SalvarComo(True)
	cb_salva_excel.Enabled = True
Else	
	ivm_Menu.mf_SalvarComo(False)
	cb_salva_excel.Enabled = False
End if	

Return AncestorReturnValue 


end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()

String lvs_Coluna[], &
		lvs_Nome[]
		 
lvs_Coluna = {"nr_nf","de_especie","de_serie","dh_movimentacao_caixa","vl_total_nf","cd_filial_origem","filial_origem","cd_filial_destino","filial_destino", "nr_rota_entrega_d", "recebimento"}

lvs_Nome = {"Nr. NF","Esp$$HEX1$$e900$$ENDHEX$$cie","S$$HEX1$$e900$$ENDHEX$$rie","Data de Movimenta$$HEX2$$e700e300$$ENDHEX$$o","Total Nota","C$$HEX1$$f300$$ENDHEX$$d. Filial Origem","Filial Origem","C$$HEX1$$f300$$ENDHEX$$d. Filial Destino","Filial Destino", "Rota D.", "Recebimento"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection( "if( not isnull( dh_cancelamento ), rgb(255, 20, 20), if(Not IsNull(dh_solicitacao_canc) , rgb(0, 128, 0), " + This.ivs_Cor_Linha_Padrao + "))", "", False )
end event

event dw_2::ue_postretrieve;//OverRide
If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	//This.of_SetRowSelection("", "If ( Not IsNull( dh_cancelamento ) , RGB(255,0,0) , RGB(0,0,0))") 
	cb_imprimir_etiqueta.enabled = true
	cb_2.enabled = true
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nenhuma nota fiscal localizada.", Information!)
	End If
End If

If pl_Linhas > 0 Then 
	cb_salva_excel.Enabled = True
Else
	cb_salva_excel.Enabled = False
ENd If

This.ivo_controle_menu.of_SalvarComo(pl_Linhas > 0)
This.ivo_controle_menu.of_Classificar(pl_Linhas > 0)
This.ivo_controle_menu.of_Filtrar(pl_Linhas > 0)



Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo
String lvs_Subgrupo
String lvs_UF_Fil
String lvs_UF_Dest
String lvs_Lei_Gen
String lvs_Lista_Pis
String lvs_Tipo
String lvs_NCM_Ini
String lvs_NCM_Fim
String lvs_Situacao
String lvs_SQL
String lvs_Serie
String lvs_Where = ""
String lvs_NaoRecebido
String lvs_id_tipo_pedido_distribuidora

Long lvl_NCM_Ini
Long lvl_NCM_Fim
Long lvl_CFOP
Long lvl_NF
Long lvl_Filial_Orig
Long lvl_Filial_Dest
Long lvl_Produto
Long lvl_nr_rota

Date lvdt_Inicio
Date lvdt_Fim

Parent.dw_1.Accepttext( )

lvdt_Inicio								= Parent.dw_1.Object.dt_inicio[1]
lvdt_Fim									= Parent.dw_1.Object.dt_fim[1]
lvl_Filial_Orig						= Parent.dw_1.Object.cd_filial[1]
lvl_Filial_Dest						= Parent.dw_1.Object.cd_filial_dest[1]
lvs_UF_Fil								= Parent.dw_1.Object.cd_uf	[1]
lvs_UF_Dest								= Parent.dw_1.Object.cd_uf_dest[1]
lvl_Produto								= Parent.dw_1.Object.cd_produto[1]
lvs_Situacao							= Parent.dw_1.Object.id_situacao[1]
lvs_Tipo									= Parent.dw_1.Object.id_tipo[1]
lvl_CFOP									= Parent.dw_1.Object.cd_cfop[1]
lvs_Grupo								= Parent.dw_1.Object.cd_grupo[1]
lvs_Subgrupo							= Parent.dw_1.Object.cd_subgrupo[1]
lvl_NCM_Ini								= Parent.dw_1.Object.nr_ncm_ini[1]
lvl_NCM_Fim								= Parent.dw_1.Object.nr_ncm_fim[1]
lvs_Lista_Pis							= Parent.dw_1.Object.id_lista_pis_cofins[1]
lvs_Lei_Gen								= Parent.dw_1.Object.id_lei_generico[1]
lvl_NF									= Parent.dw_1.Object.nr_nf[1]
lvs_Serie								= Parent.dw_1.Object.de_serie[1]
lvs_NaoRecebido						= Parent.dw_1.Object.id_naorecebido[1]		
lvs_id_tipo_pedido_distribuidora	= Parent.dw_1.Object.id_tipo_pedido_distribuidora[1]		
lvl_nr_rota							= Parent.dw_1.Object.nr_rota[1]		

If IsNull(lvdt_Inicio) or (lvdt_Inicio < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data inicial para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	Parent.dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
Else
	This.Of_AppendWhere_Subquery("n.dh_movimentacao_caixa>='"+String(lvdt_Inicio,'YYYY/MM/DD')+"'",2)
End If

If IsNull(lvdt_Fim) or (lvdt_Fim < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data final para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	Parent.dw_1.Event ue_Pos(1,'dt_fim')
	Return -1
Else
	This.Of_AppendWhere_Subquery("n.dh_movimentacao_caixa<='"+String(lvdt_Fim,'YYYY/MM/DD')+"'",2)
End If

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	lvs_Where += IIF(lvs_Where<>""," and ","")+"i1.cd_produto="+String(lvl_Produto)
End If

If Not IsNull(lvl_Filial_Orig) and (lvl_Filial_Orig > 0) Then
	This.Of_AppendWhere_Subquery("n.cd_filial_origem="+String(lvl_Filial_Orig),2)
ElseIf IsNull(lvl_Filial_Dest) or (lvl_Filial_Dest <= 0) Then
	This.Of_AppendWhere_Subquery("n.cd_filial_origem > 0",2)
End If

If Not IsNull(lvl_Filial_Dest) and (lvl_Filial_Dest > 0) Then
	If lvl_Filial_Dest = 534 Then
		This.Of_AppendWhere_Subquery("n.cd_filial_destino in (1,"+String(lvl_Filial_Dest)+")",2)
	Else
		This.Of_AppendWhere_Subquery("n.cd_filial_destino="+String(lvl_Filial_Dest),2)
	End If
	
	lvs_SQL = This.GetSQLSelect()
	lvs_SQL = gf_replace(lvs_SQL,'idx_data_filial_origem','idx_data_filial_destino',0)
	This.SetSQLSelect(lvs_SQL)
End If

If lvs_UF_Fil<>'TD' Then
	This.Of_AppendWhere_Subquery("co.cd_unidade_federacao='"+lvs_UF_Fil+"'",2)
End If

if lvs_id_tipo_pedido_distribuidora <> 'TD' then
	This.Of_AppendWhere_Subquery("pd.id_tipo_pedido='"+lvs_id_tipo_pedido_distribuidora+"'",2)
end if

If lvs_UF_Dest<>'TD' Then
	This.Of_AppendWhere_Subquery("cd.cd_unidade_federacao='"+lvs_UF_Dest+"'",2)
End If

Choose Case lvs_Tipo
	Case 'AX'
		This.Of_AppendWhere_Subquery("n.id_almoxarifado='S'",2)
	Case 'EF'
		This.Of_AppendWhere_Subquery("n.cd_filial_destino not in (1,534)",2)
		This.Of_AppendWhere_Subquery("n.cd_filial_origem not in (1,534)",2)
	Case 'EC'
		This.Of_AppendWhere_Subquery("( (n.cd_filial_origem in (1,534)) or (n.cd_filial_destino in (1,534)) )",2)
	Case 'MC'
		This.Of_AppendWhere_Subquery("coalesce(n.id_almoxarifado,'N')<>'S'",2)
	Case 'PV'
		This.Of_AppendWhere_Subquery("coalesce(n.id_produto_vencido,'N')='S'",2)
	Case 'RM'
		This.Of_AppendWhere_Subquery("((n.cd_remanejamento is not null) or exists (select 1 from remanejamento_resultado rr1 "+ &
												" where rr1.cd_filial_origem = n.cd_filial_origem 	and " + &
												" rr1.nr_nf = n.nr_nf								and  " + &
												" rr1.de_especie = n.de_especie 				and  " + &
												" rr1.de_serie = n.de_serie))",2)
	Case 'RE'
		This.Of_AppendWhere_Subquery("n.nr_retirada_estoque is not null",2)
End Choose

Choose Case lvs_Situacao
	Case "CA"
		This.Of_AppendWhere_Subquery(" n.dh_cancelamento is not null",2)
	Case "NO"
		This.Of_AppendWhere_Subquery(" n.dh_cancelamento is null",2)
End Choose

If Not IsNull(lvl_NF) and (lvl_NF > 0) Then
	This.Of_AppendWhere_Subquery("n.nr_nf="+String(lvl_NF),2)
End If

If Not IsNull(lvs_Serie) and (Trim(lvs_Serie)<>"") Then
	This.Of_AppendWhere_Subquery("n.de_serie='"+lvs_Serie+"'",2)
End If

If Not IsNull(lvl_CFOP) and (lvl_CFOP > 0) Then
	lvs_Where += IIF(lvs_Where<>""," and ","")+"i1.cd_natureza_operacao="+String(lvl_CFOP)
End If

If lvs_Grupo<>'0' Then
	lvs_Where += IIF(lvs_Where<>""," and ","")+"substring(pg1.cd_subcategoria,1,1)='"+lvs_Grupo+"'"
End If

If lvs_Subgrupo<>'0' Then
	lvs_Where += IIF(lvs_Where<>""," and ","")+"substring(pg1.cd_subcategoria,1,3)='"+lvs_Subgrupo+"'"
End If

If lvs_Lista_Pis<>'TD' Then
	lvs_Where += IIF(lvs_Where<>""," and ","")+"pg1.id_situacao_pis_cofins='"+lvs_Lista_Pis+"'"
End If

If lvs_Lei_Gen<>'TD' Then
	lvs_Where += IIF(lvs_Where<>""," and ","")+"pg1.id_lei_generico='"+lvs_Lei_Gen+"'"
End If

If (Not IsNull(lvl_NCM_Ini) or (lvl_NCM_Ini > 0))or((Not IsNull(lvl_NCM_Fim) or (lvl_NCM_Fim > 0))) Then
	lvs_NCM_Ini 	= String(lvl_NCM_Ini)
	lvs_NCM_Fim 	= String(lvl_NCM_Fim)

	Do While Len(lvs_NCM_Ini) < 8
		lvs_NCM_Ini += '0'
	Loop
	
	Do While Len(lvs_NCM_Fim) < 8
		lvs_NCM_Fim += '9'
	Loop

	If (Not IsNull(lvl_NCM_Ini) or (lvl_NCM_Ini > 0)) Then
			lvs_Where += IIF(lvs_Where<>""," and ","")+"pg1.nr_classificacao_fiscal >= "+String(lvl_NCM_Ini)
	End If
		
	If (Not IsNull(lvl_NCM_Fim) or (lvl_NCM_Fim > 0)) Then
		lvs_Where += IIF(lvs_Where<>""," and ","")+"pg1.nr_classificacao_fiscal <= "+String(lvl_NCM_Fim)
	End If
End If

If lvs_Where<>"" Then
	This.Of_AppendWhere_Subquery("exists (select 1 from item_nf_transferencia i1 "+ &
											"inner join produto_geral pg1 "+ &
												"on pg1.cd_produto = i1.cd_produto "+ &
											" Where i1.cd_filial_origem = n.cd_filial_origem "+ &
											" And i1.nr_nf = n.nr_nf "+ &
											" And i1.de_especie = n.de_especie "+ &
											" And i1.de_serie = n.de_serie "+ &
											" And "+lvs_Where+")",2)
End If

If (lvs_NaoRecebido = "S") Then
	This.Of_AppendWhere_Subquery(" n.dh_recebimento is null " ,2)
End If

If Not IsNull(lvl_nr_Rota) And lvl_nr_Rota <> 0 Then
	This.of_AppendWhere_SubQuery("fd.nr_rota_entrega = "+ String(lvl_nr_Rota), 2)
End If

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
cb_salva_excel.Enabled = False
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;long ll_filial_destino

setnull(ist_parametros_protocolo.cd_filial_origem)
setnull(ist_parametros_protocolo.nr_nf)
setnull(ist_parametros_protocolo.de_especie)
setnull(ist_parametros_protocolo.de_serie)

if currentrow > 0 then
	ll_filial_destino = object.cd_filial_destino[currentrow]
	/* Libera Altera$$HEX1$$e700$$ENDHEX$$ao do Protocolo apenas se a filial destino for 534 */
	if ll_filial_destino = 534 then
		cb_3.enabled = true
		ist_parametros_protocolo.cd_filial_origem = Object.cd_filial_origem[currentrow]
		ist_parametros_protocolo.nr_nf = Object.nr_nf[currentrow]
		ist_parametros_protocolo.de_especie = Object.de_especie[currentrow]
		ist_parametros_protocolo.de_serie = Object.de_serie[currentrow]
	else
		cb_3.enabled = false
	end if
else
	cb_3.enabled = false
end if
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 4539
integer height = 2028
cb_1 cb_1
end type

on tabpage_2.create
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_1)
end on

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer y = 952
integer width = 3707
integer height = 1060
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer width = 3707
integer height = 936
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 41
integer y = 64
integer width = 3680
integer height = 848
string dataobject = "dw_ge247_detalhe_cabecalho"
end type

event dw_3::ue_retrieve;// OverRide
Long lvl_Cd_Filial_Origem, &
     lvl_Nr_NF
	  
String lvs_De_Especie, &
       lvs_De_Serie
		 
Integer lvi_Linha_Ativa, &
        lvi_Linhas
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial_Origem 	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial_Origem[lvi_Linha_Ativa]
lvl_Nr_NF            		= Tab_1.TabPage_1.dw_2.Object.Nr_NF[lvi_Linha_Ativa]
lvs_De_Especie       	= Tab_1.TabPage_1.dw_2.Object.De_Especie[lvi_Linha_Ativa]
lvs_De_Serie         	= Tab_1.TabPage_1.dw_2.Object.De_Serie[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(	lvl_Cd_Filial_Origem, &
                           			lvl_Nr_NF, &
									lvs_De_Especie, &
									lvs_De_Serie)

Return lvi_Linhas

end event

event dw_3::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 55
integer y = 1008
integer width = 3634
integer height = 964
string dataobject = "dw_ge247_detalhe_item"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_4::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_4::ue_postretrieve;call super::ue_postretrieve;Parent.dw_3.Object.vl_bc_antecipacao	[1] = This.GetItemdecimal( pl_linhas, 'vl_total_bc_antecipacao')
Parent.dw_3.Object.vl_antecipacao 		[1] = This.GetItemdecimal( pl_linhas, 'vl_total_antecipacao')
Parent.dw_3.Object.vl_bc_st_origem		[1] = This.GetItemdecimal( pl_linhas, 'vl_total_bc_st_origem')
Parent.dw_3.Object.vl_st_origem			[1] = This.GetItemdecimal( pl_linhas, 'vl_total_st_origem')
Parent.dw_3.Object.vl_bc_fcp				[1] = This.GetItemdecimal( pl_linhas, 'vl_total_bc_fcp')
Parent.dw_3.Object.vl_fcp					[1] = This.GetItemdecimal( pl_linhas, 'vl_total_fcp')

Return AncestorReturnValue
end event

event dw_4::ue_recuperar;Long lvl_Cd_Filial_Origem, &
     lvl_Nr_NF
	  
String lvs_De_Especie, &
       lvs_De_Serie
		 
Integer lvi_Linha_Ativa
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial_Origem 	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial_Origem	[lvi_Linha_Ativa]
lvl_Nr_NF            			= Tab_1.TabPage_1.dw_2.Object.Nr_NF					[lvi_Linha_Ativa]
lvs_De_Especie       	= Tab_1.TabPage_1.dw_2.Object.De_Especie			[lvi_Linha_Ativa]
lvs_De_Serie         		= Tab_1.TabPage_1.dw_2.Object.De_Serie				[lvi_Linha_Ativa]

Return This.Retrieve(	lvl_Cd_Filial_Origem, 	lvl_Nr_NF, lvs_De_Especie, lvs_De_Serie)

end event

type cb_imprimir_etiqueta from commandbutton within tabpage_1
integer x = 2514
integer y = 572
integer width = 535
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Imprimir Etiqueta"
end type

event clicked;Long ll_Nf, ll_Filial_Origem, ll_Row
String ls_Especie, ls_Serie,  lvs_Parametro
Date lvdh_Cancelamento

st_dados_nf lst_dados


dw_2.AcceptText()
ll_Row = dw_2.GetRow()

ll_Nf 				= dw_2.Object.nr_nf[ll_Row]
ls_Especie 			= dw_2.Object.de_especie[ll_Row]
ls_Serie 			= dw_2.Object.de_serie[ll_Row]
ll_Filial_Origem 	= dw_2.Object.cd_filial_origem[ll_Row]
lvdh_Cancelamento = Date(dw_2.Object.dh_cancelamento[ll_Row])

If ll_Filial_Origem = 534 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Etiquetas de notas fiscais do Estoque Central n$$HEX1$$e300$$ENDHEX$$o podem ser reemitidas." )
	Return
End If

If ll_Row<0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma nota fiscal para reemitir a etiqueta.")
	Return
End If

If Not IsNull(lvdh_Cancelamento) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Etiquetas de notas fiscais Canceladas n$$HEX1$$e300$$ENDHEX$$o podem ser reemitidas.")
	Return
End If

lst_dados.cd_filial		= ll_Filial_Origem
lst_dados.nr_nf 			= ll_Nf
lst_dados.de_especie		= ls_Especie
lst_dados.de_serie		= ls_Serie

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a reemiss$$HEX1$$e300$$ENDHEX$$o da etiqueta da nota fiscal selecionada ?", Question!, YesNo!, 2) = 1 Then
	OpenWithParm(w_ge339_emissao_etiqueta_transferencia, lst_dados)
End If
end event

type cb_solicita_canc_sap from commandbutton within tabpage_1
integer x = 1966
integer y = 572
integer width = 535
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Solicita Canc. SAP"
end type

event clicked;Boolean lb_sucesso = false
String	ls_Operador,&
		ls_msg,&
		ls_Especie, &
		ls_Serie,&
		ls_chave_nfe
DateTime ldt_dh_recebido_sap,&
			 ldt_dh_cancelamento,&
			 ldt_dh_solicitacao_canc,&
			 ldt_dh_movimentacao_caixa
Long 	ll_NF, &
		ll_Filial,&
		ll_Linha,&
		ll_Pedido,&
		ll_Horas_Emissao

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Linha							= Tab_1.TabPage_1.dw_2.GetRow( )
ll_NF								= Tab_1.TabPage_1.dw_2.Object.nr_nf				[ll_Linha]
ll_Filial							= Tab_1.TabPage_1.dw_2.Object.cd_filial_origem	[ll_Linha]
ls_Serie							= Tab_1.TabPage_1.dw_2.Object.de_serie			[ll_Linha]
ls_Especie						= Tab_1.TabPage_1.dw_2.Object.de_especie		[ll_Linha]
ll_Pedido							= Tab_1.TabPage_1.dw_2.Object.nr_pedido_distribuidora[ll_Linha]
ldt_dh_movimentacao_caixa	=Tab_1.TabPage_1.dw_2.Object.dh_movimentacao_caixa[ll_Linha]
ll_Horas_Emissao				=Tab_1.TabPage_1.dw_2.Object.qt_dias_emissao			[ll_Linha]

If wf_busca_datas_nota_transferencia( ll_Filial, ll_NF, ls_Especie, ls_Serie, ref ldt_dh_recebido_sap, ref ldt_dh_cancelamento, ref ldt_dh_solicitacao_canc, ref ls_msg ) Then
	If Not IsNull(ldt_dh_recebido_sap) Then
		If IsNull(ldt_dh_cancelamento) Then
			If IsNull(ldt_dh_solicitacao_canc) Then
				
				If ll_Horas_Emissao >= 24 Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cancelamento n$$HEX1$$e300$$ENDHEX$$o permitido." +  "~r~rPassou o prazo legal na SEFAZ - [24 horas].", Exclamation!)
					Return
				End If		
				
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja solicitar ao SAP o cancelamento da nota selecionada ?~r~rNota: " + String(ll_NF) + '.', Question!, YesNo!, 2) = 2 Then Return
		
				If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE165_SOLICITA_CANCELAMENTO", ref ls_Operador) Then return
												
				If wf_busca_chave_nfe( ll_Filial, ll_NF, ls_Especie, ls_Serie, ref ls_chave_nfe, ref ls_msg ) Then
					If wf_atualiza_nota_transferencia( ll_Filial, ll_NF, ls_Especie, ls_Serie, ls_Operador, ref ls_msg ) Then
						If wf_grava_log_exportacao_sap( ll_Filial, ll_NF, ls_Especie, ls_Serie, ls_chave_nfe, ldt_dh_movimentacao_caixa, ref ls_msg, ll_Pedido) Then
							lb_sucesso = True
						End If
					End If
				End If
			Else
				ls_msg = "J$$HEX1$$e100$$ENDHEX$$ existe uma solicita$$HEX2$$e700e300$$ENDHEX$$o de cancelamento pendente registrada em: "+String(ldt_dh_solicitacao_canc)+"."
			End If
		Else
			ls_msg = "A nota j$$HEX1$$e100$$ENDHEX$$ foi cancelada no SAP em: "+String(ldt_dh_cancelamento)+"."
		End If
	Else
		ls_msg = "Esta funcionalidade $$HEX1$$e900$$ENDHEX$$ somente para notas que foram emitidas pelo SAP."
	End If
End If

If Not lb_sucesso Then
	SqlCa.of_Rollback()
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_msg,Exclamation!)
Else
	SqlCa.of_Commit()
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Solicita$$HEX2$$e700e300$$ENDHEX$$o de cancelamento da NF de Transfer$$HEX1$$ea00$$ENDHEX$$ncia no SAP realizada com sucesso.")
End If


end event

type cb_2 from commandbutton within tabpage_1
integer x = 3063
integer y = 572
integer width = 818
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Imprimir Etq. Pedido Urgente"
end type

event clicked;Boolean	lvb_Sucesso
Long 		ll_Nf, ll_Filial_Origem, ll_Row, ll_Filial_Destino, ll_Contador
String	ls_Especie, ls_Serie,  lvs_Parametro, ls_Matricula, ls_id_tipo_pedido, &
			ls_de_tipo_urgente, ls_de_tipo_almox_urgente
Date 		lvdh_Cancelamento

st_dados_nf lst_dados
uo_etiqueta lo_Etiqueta


dw_2.AcceptText()
ll_Row = dw_2.GetRow()

ll_Nf 				= dw_2.Object.nr_nf[ll_Row]
ls_Especie 			= dw_2.Object.de_especie[ll_Row]
ls_Serie 			= dw_2.Object.de_serie[ll_Row]
ls_id_tipo_pedido	= dw_2.Object.id_tipo_pedido[ll_Row]
ll_Filial_Origem 	= dw_2.Object.cd_filial_origem[ll_Row]
ll_Filial_Destino	= dw_2.Object.cd_filial_destino[ll_Row]
lvdh_Cancelamento = Date(dw_2.Object.dh_cancelamento[ll_Row])

if (ls_id_tipo_pedido <> '5' and ls_id_tipo_pedido <> '6') or IsNull(ls_id_tipo_pedido) then
	select de_tipo
	  into :ls_de_tipo_urgente
	  from tipo_pedido_distribuidora
	 where id_tipo = '5';
	
	choose case sqlca.sqlcode
		case 100
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel localizar a descri$$HEX2$$e700e300$$ENDHEX$$o do tipo de pedido 5.', StopSign!)
			return 0
		case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a descri$$HEX2$$e700e300$$ENDHEX$$o do tipo de pedido 5. ' + SQLCA.SQLErrText, StopSign!)
			return 0
	end choose
	
	select de_tipo
	  into :ls_de_tipo_almox_urgente
	  from tipo_pedido_distribuidora
	 where id_tipo = '6';
	
	choose case sqlca.sqlcode
		case 100
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel localizar a descri$$HEX2$$e700e300$$ENDHEX$$o do tipo de pedido 6.', StopSign!)
			return 0
		case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a descri$$HEX2$$e700e300$$ENDHEX$$o do tipo de pedido 6. ' + SQLCA.SQLErrText, StopSign!)
			return 0
	end choose
	
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Essa etiqueta deve ser utilizada apenas para pedidos dos tipos: ' + ls_de_tipo_urgente + ' e ' + ls_de_tipo_almox_urgente + '. ' + SQLCA.SQLErrText, StopSign!)
	return 0
end if

ls_Matricula	= gvo_Aplicacao.ivo_Seguranca.nr_matricula

lo_Etiqueta = create uo_etiqueta

SetPointer(HourGlass!)

Open(w_Aguarde)

If Not lo_Etiqueta.of_imprimir_etiqueta(ll_Filial_Origem, ll_Nf, ls_Especie, ls_Serie) = -1 Then 
	Close(w_Aguarde)
	return -1
End if

If Not lo_Etiqueta.of_executa_rotina_intranet(ll_Filial_Origem,  ll_Filial_Destino,  ll_Nf,  ls_Especie,  ls_Serie,  ls_Matricula) Then 
	Close(w_Aguarde)
	return -1
end if

Close(w_Aguarde)

destroy(lo_Etiqueta)

SetPointer(Arrow!)
end event

type cb_3 from commandbutton within tabpage_1
integer x = 1481
integer y = 572
integer width = 471
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Altera Protocolo"
end type

event clicked;string ls_matricula

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE252_ALTERA_PROTOCOLO", ref ls_Matricula) Then 
	Return 1
End If		 

OpenWithParm(w_ge252_altera_protocolo, ist_parametros_protocolo)

//ls_Retorno = Message.StringParm
//
//If ls_Retorno = "S" Then
//	Tab_1.TabPage_2.dw_3.Event ue_Recuperar()
//	
//	//If ivs_situacao = 'A' Then
//	//	Tab_1.TabPage_2.dw_3.Event ue_AddRow()
//	//End If	
//	
//	Tab_1.TabPage_2.dw_3.SetRow(ll_Row)
//	Tab_1.TabPage_2.dw_3.ScrollToRow(ll_Row)
//End If

end event

type cb_salva_excel from commandbutton within tabpage_1
integer x = 1079
integer y = 572
integer width = 389
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Salvar Excel"
end type

event clicked;dw_2.Event ue_SaveAs()

//this.enabled = false
//ivm_menu.mf_SalvarComo(False)

Return 1
end event

type cb_imprimir_nota from commandbutton within tabpage_1
integer x = 649
integer y = 572
integer width = 416
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imprimir Nota"
end type

event clicked;dc_uo_ds_base	lds_nota

Long				lvl_Cd_Filial, &
					lvl_Nr_NF
	  
String			lvs_De_Especie, &
					lvs_De_Serie
		 
Integer			lvi_Linha_Ativa, &
					lvi_Linhas
		  
lvi_Linha_Ativa = dw_2.GetRow ()

If lvi_Linha_Ativa = 0 then Return

lds_nota = Create dc_uo_ds_base

Try
	If not lds_nota.of_ChangeDataObject ('dw_ge247_imagem_nota') then Return
	
	lvl_Cd_Filial  = dw_2.Object.Cd_Filial_Origem [lvi_Linha_Ativa]
	lvl_Nr_NF      = dw_2.Object.Nr_NF            [lvi_Linha_Ativa]
	lvs_De_Especie = dw_2.Object.De_Especie       [lvi_Linha_Ativa]
	lvs_De_Serie   = dw_2.Object.De_Serie         [lvi_Linha_Ativa]
	
	lvi_Linhas = lds_nota.Retrieve (lvl_Cd_Filial,  &
											  lvl_Nr_NF,      &
											  lvs_De_Especie, &
											  lvs_De_Serie)
	
	If lvi_Linhas > 0 then
		If PrintSetup () <> 1 then Return
		
		lds_nota.Print (False)
	End if

Finally
	Destroy lds_nota
End try

Return
end event

type cb_1 from picturebutton within tabpage_2
integer x = 2130
integer y = 584
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Copy.png"
alignment htextalign = left!
end type

event clicked;Integer lvi_Retorno

Parent.dw_3.Event ue_Pos(1,'de_chave_acesso')
Parent.dw_3.SelectText(1, 44)

lvi_Retorno = Parent.dw_3.Copy()

Choose Case lvi_Retorno
	Case -1  // Vazio
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
End Choose
end event

