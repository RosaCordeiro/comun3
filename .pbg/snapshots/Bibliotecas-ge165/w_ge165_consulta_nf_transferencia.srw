HA$PBExportHeader$w_ge165_consulta_nf_transferencia.srw
forward
global type w_ge165_consulta_nf_transferencia from dc_w_2tab_consulta_selecao_lista_2det
end type
type gb_5 from groupbox within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type cb_imprimir_etiqueta from commandbutton within tabpage_1
end type
type cb_solicita_canc_sap from commandbutton within tabpage_1
end type
type cb_reimprimir_etq_excesso from commandbutton within tabpage_1
end type
type cb_imprimir_nota from commandbutton within tabpage_1
end type
end forward

global type w_ge165_consulta_nf_transferencia from dc_w_2tab_consulta_selecao_lista_2det
boolean visible = false
integer x = 215
integer y = 220
integer width = 3598
integer height = 1844
string title = "GE165 - Consulta de Notas Fiscais de Transfer$$HEX1$$ea00$$ENDHEX$$ncia"
end type
global w_ge165_consulta_nf_transferencia w_ge165_consulta_nf_transferencia

type variables
uo_filial ivo_filial

DateTime ivdh_Parametro

uo_centro_custo				ivo_centro_custo
uo_produto						ivo_produto
uo_ge642_volumes_excesso	ivo_volumes

Boolean ib_iniciado_operacao_sap = false
Boolean	ib_Segrega_Excesso

end variables

forward prototypes
public function boolean wf_atualiza_itens (long al_filial_origem, long al_filial_destino, long al_nota, string as_serie, string as_especie, ref long al_qtd)
public function boolean wf_exibe_oculta_botao_solicita_canc_sap ()
public function boolean wf_grava_log_exportacao_sap (long al_filial, long al_nota, string as_especie, string as_serie, string as_cd_chave, datetime adt_dh_documento, ref string as_log)
public function boolean wf_busca_chave_nfe (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_chave_nfe, ref string as_log)
public function boolean wf_atualiza_nota_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, string as_operador, ref string as_log)
public function boolean wf_busca_datas_nota_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, ref datetime adt_dh_recebido_sap, ref datetime adt_dh_cancelamento, ref datetime adt_dh_solicitacao_canc, ref string as_log)
public function boolean wf_obtem_parametro ()
end prototypes

public function boolean wf_atualiza_itens (long al_filial_origem, long al_filial_destino, long al_nota, string as_serie, string as_especie, ref long al_qtd);
Select		sum(qt_transferida) 
Into		:al_Qtd
From		item_nf_transferencia
Where	cd_filial_origem = :al_filial_origem		
And		cd_filial_destino = :al_filial_destino
And		nr_nf =:al_nota
And		de_especie =:as_especie
And		de_serie =:as_serie
Using	SqlCA;

If SqlCa.sqlcode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro atualizar QtdItens da Nota'", StopSign!)
	Return False
End If 	

Return True 

end function

public function boolean wf_exibe_oculta_botao_solicita_canc_sap ();Return (gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "WS" And ib_iniciado_operacao_sap)
end function

public function boolean wf_grava_log_exportacao_sap (long al_filial, long al_nota, string as_especie, string as_serie, string as_cd_chave, datetime adt_dh_documento, ref string as_log);String ls_Log

st_log_export_sap st_log

st_log.cd_chave 				= as_cd_chave
st_log.id_tipo_nf 				= 'WMV'
st_log.cd_tipo_documento   = 'WMV'
st_log.id_tipo_log 				= 77
st_log.cd_filial  					= al_filial
st_log.cd_parametro_geral  = 'DH_INICIO_OPERACAO_SAP'
st_log.nr_nf						= al_nota
st_log.de_especie				= as_especie
st_log.de_serie					= as_serie
st_log.dh_documento			= adt_dh_documento

If Not gf_insere_log_exportacao_sap(st_log, ref as_log) then
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

public function boolean wf_obtem_parametro ();String	ls_Vl_Parametro, &
			ls_Nm_Parametro = 'ID_WMS_SEGREGA_EXCESSO'
			

SELECT vl_parametro
  INTO :ls_Vl_Parametro
  FROM wms_parametro
 WHERE cd_parametro = :ls_Nm_Parametro
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		SQLCA.of_MsgDBError ('Erro ao buscar o par$$HEX1$$e200$$ENDHEX$$metro ' + ls_Nm_Parametro)
		Return False
	case 100
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_Nm_Parametro + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!')
		Return False
End choose

ib_Segrega_Excesso = ls_Vl_Parametro = 'S'

Return True
end function

on w_ge165_consulta_nf_transferencia.create
int iCurrent
call super::create
end on

on w_ge165_consulta_nf_transferencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_produto)
Destroy(ivo_centro_custo)
Destroy(ivo_volumes)

end event

event open;call super::open;
ivo_filial				= Create uo_filial
ivo_centro_custo	= Create uo_centro_custo
ivo_volumes       = Create uo_ge642_volumes_excesso

ivo_volumes.ib_ja_imprimiu_etiqueta = False
end event

event ue_postopen;call super::ue_postopen;String ls_msg
//
tab_1.tabpage_1.cb_1.Enabled = FALSE
//

ivdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio[1]  = Date(ivdh_Parametro)
Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1] = Date(ivdh_Parametro)


Tab_1.TabPage_1.dw_5.Event ue_AddRow()

If Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_iniciado_operacao_sap, ref ls_msg ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_msg,StopSign!)
	Post Event Close(this)
End If

//tab_1.tabpage_1.cb_solicita_canc_sap.visible = wf_exibe_oculta_botao_solicita_canc_sap()
//tab_1.tabpage_1.cb_solicita_canc_sap.enabled = tab_1.tabpage_1.cb_solicita_canc_sap.visible

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'WS' then
	If not wf_obtem_parametro () then
		Post Close (This)
	else
		tab_1.tabpage_1.cb_reimprimir_etq_excesso.Visible = ib_Segrega_Excesso
	End if
End if

Return
end event

event ue_preopen;call super::ue_preopen;// Determina as dimens$$HEX1$$f500$$ENDHEX$$es dos folders
// Sele$$HEX2$$e700e300$$ENDHEX$$o
ivl_Largura_1 = 3561
ivl_Altura_1  = 1785

// Detalhes
ivl_Largura_2 = ivl_Largura_1
ivl_Altura_2  	= ivl_Altura_1

MaxHeight = 9999

ivo_produto = Create uo_produto
end event

event resize;call super::resize;Long lvl_Diferenca

lvl_Diferenca = (This.Height - 165) - Tab_1.Height
Tab_1.Height += lvl_Diferenca
Tab_1.TabPage_1.gb_2.Height	+= lvl_Diferenca
Tab_1.TabPage_1.dw_2.Height	+= lvl_Diferenca
Tab_1.TabPage_1.gb_5.Y		+= lvl_Diferenca
Tab_1.TabPage_1.dw_5.Y		+= lvl_Diferenca
Tab_1.TabPage_2.gb_4.Height += lvl_Diferenca
Tab_1.TabPage_2.dw_4.Height	+= lvl_Diferenca
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge165_consulta_nf_transferencia
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge165_consulta_nf_transferencia
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge165_consulta_nf_transferencia
integer x = 9
integer width = 3543
integer height = 1652
long backcolor = 79741120
end type

event tab_1::selectionchanged;//override
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
event create ( )
event destroy ( )
integer width = 3506
integer height = 1536
gb_5 gb_5
cb_1 cb_1
dw_5 dw_5
cb_imprimir_etiqueta cb_imprimir_etiqueta
cb_solicita_canc_sap cb_solicita_canc_sap
cb_reimprimir_etq_excesso cb_reimprimir_etq_excesso
cb_imprimir_nota cb_imprimir_nota
end type

on tabpage_1.create
this.gb_5=create gb_5
this.cb_1=create cb_1
this.dw_5=create dw_5
this.cb_imprimir_etiqueta=create cb_imprimir_etiqueta
this.cb_solicita_canc_sap=create cb_solicita_canc_sap
this.cb_reimprimir_etq_excesso=create cb_reimprimir_etq_excesso
this.cb_imprimir_nota=create cb_imprimir_nota
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_5
this.Control[iCurrent+4]=this.cb_imprimir_etiqueta
this.Control[iCurrent+5]=this.cb_solicita_canc_sap
this.Control[iCurrent+6]=this.cb_reimprimir_etq_excesso
this.Control[iCurrent+7]=this.cb_imprimir_nota
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.cb_1)
destroy(this.dw_5)
destroy(this.cb_imprimir_etiqueta)
destroy(this.cb_solicita_canc_sap)
destroy(this.cb_reimprimir_etq_excesso)
destroy(this.cb_imprimir_nota)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer x = 27
integer y = 512
integer width = 3465
integer height = 800
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer x = 27
integer y = 0
integer width = 3342
integer height = 424
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer x = 46
integer y = 68
integer width = 3301
integer height = 344
string dataobject = "dw_ge165_selecao_consulta_transferencia"
end type

event dw_1::itemchanged;call super::itemchanged;tab_1.tabPage_1.dw_2.Reset()

Choose Case dwo.Name
	Case "de_filial"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Filial.Nm_Fantasia Then				
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.de_Filial[1] = ivo_Filial.Nm_Fantasia			
		End If	
		
	Case "de_produto"
		If Trim(Data) <> "" Then
			If Data <> ivo_Produto.de_produto+': '+ivo_produto.de_apresentacao_estoque Then				
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto	[1] = ivo_Produto.cd_produto
			This.Object.de_produto	[1] = ivo_Produto.de_produto			
		End If
		
	Case "id_entrada_saida"
		
		ivo_Filial.of_Inicializa()
		
		This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
		This.Object.de_Filial[1] = ivo_Filial.Nm_Fantasia	
		
	Case "de_centro_custo"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Centro_Custo.de_centro_custo Then
				Return 1
			End If
		Else
			ivo_Centro_Custo.of_Inicializa()
			
			This.Object.cd_centro_custo	[1] = ivo_Centro_Custo.cd_centro_custo
			This.Object.de_centro_custo	[1] = ivo_Centro_Custo.de_centro_custo
		End If	

End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_filial"
			ivo_filial.Of_Localiza_Filial( This.GetText() )
	
			If ivo_filial.Localizada Then
		
				This.Object.cd_filial[1] = ivo_filial.cd_filial
				This.Object.de_filial[1] = ivo_filial.nm_fantasia	
			Else
				ivo_filial.Of_inicializa( )
				
				This.Object.cd_filial[1] = ivo_filial.cd_filial
				This.Object.de_filial[1] = ivo_filial.nm_fantasia	
			End If
			
		Case "de_produto"
			ivo_Produto.Of_Localiza_produto(This.GetText())
	
			If ivo_Produto.Localizado Then
		
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.de_produto 	[1] = ivo_Produto.de_produto+': '+ivo_Produto.de_apresentacao_estoque	
			Else
				ivo_Produto.Of_inicializa( )
				
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.de_produto 	[1] = ivo_Produto.de_produto
			End If
	
		Case "de_centro_custo"
			ivo_Centro_Custo.ivb_Centro_Custo = True
			
			ivo_Centro_Custo.of_Localiza_Centro_Custo(This.GetText())
			
			If ivo_Centro_Custo.Localizada Then
				
				If ivo_Centro_Custo.id_Situacao = "A" Then
					This.Object.cd_centro_custo	[1] = ivo_Centro_Custo.cd_centro_custo
					This.Object.de_centro_custo	[1] = ivo_Centro_Custo.de_centro_custo
				Else
					
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O departamento " + ivo_Centro_Custo.de_centro_custo + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativo.")
					
					ivo_Centro_Custo.of_Inicializa()
					
					This.Object.cd_centro_custo	[1] = ivo_Centro_Custo.cd_centro_custo
					This.Object.de_centro_custo	[1] = ivo_Centro_Custo.de_centro_custo
					
					Return -1
					
				End If
					
			End If	
	End Choose
End If

end event

event dw_1::ue_addrow;call super::ue_addrow;Date lvdt_Movimento

lvdt_Movimento = Date(gvo_Parametro.of_dh_movimentacao())

dw_1.Object.dt_inicio [1] = lvdt_Movimento
dw_1.Object.dt_termino[1] = lvdt_Movimento

Return AncestorReturnValue


end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Centro_Custo) Then
	This.Object.cd_centro_custo	[1] = ivo_Centro_Custo.cd_centro_custo
	This.Object.de_centro_custo	[1] = ivo_Centro_Custo.de_centro_custo
End If

If IsValid(ivo_Produto) Then
	If ivo_Produto.Localizado Then
		This.Object.de_produto	[1] = ivo_Produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
	Else
		This.Object.de_produto	[1] = ''
	End if
End If
end event

event dw_1::editchanged;call super::editchanged;Parent.dw_2.Reset()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 41
integer y = 576
integer width = 3442
integer height = 724
string dataobject = "dw_ge165_lista_consulta_transferencia"
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
This.of_SetRowSelection( "if(Not IsNull(dh_solicitacao_canc) , if(getrow() = currentrow(), rgb(240, 250, 147), rgb(227, 252, 3)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "", False )
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String		lvs_Especie
String		lvs_Serie	
String		lvs_Entrada_Saida
String		lvs_Situacao
String		lvs_Tipo_nota

Long	lvl_Filial
Long	lvl_NF
Long	lvl_Centro_Custo
Long	lvl_Produto

DateTime lvdh_Inicio
DateTime lvdh_Termino
		
// Verifica quais os par$$HEX1$$e200$$ENDHEX$$metros informados
Parent.dw_1.AcceptText()

dw_5.Reset()
dw_5.Event ue_AddRow()

lvs_Entrada_Saida   	= Parent.dw_1.Object.Id_Entrada_Saida  	[1]
lvs_Situacao        		= Parent.dw_1.Object.Id_Situacao		  		[1]
lvl_Filial          			= Parent.dw_1.Object.Cd_Filial		     		[1]
lvl_NF              		= Parent.dw_1.Object.Nr_NF				 	[1]
lvs_Especie         		= Parent.dw_1.Object.De_Especie		  		[1]
lvs_Serie           		= Parent.dw_1.Object.De_Serie			  	[1]
lvdh_Inicio         		= Parent.dw_1.Object.Dt_Inicio         			[1]
lvdh_Termino        	= Parent.dw_1.Object.Dt_Termino        		[1]
lvl_Centro_Custo		= Parent.dw_1.Object.cd_centro_custo  		[1]
lvs_Tipo_nota			= Parent.dw_1.Object.id_tipo_nota			[1]
lvl_Produto				= Parent.dw_1.Object.cd_produto				[1]

// Formula a cl$$HEX1$$e100$$ENDHEX$$usula where correspondente
If lvs_Entrada_Saida = "E" Then
	
	If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
		This.of_AppendWhere("a.cd_filial_origem  = " + String(lvl_Filial))
	End If	
	
	This.of_AppendWhere("a.cd_filial_destino = " + String(gvo_parametro.of_filial()) )
	
Else
	
	If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
		This.of_AppendWhere("a.cd_filial_destino = " + String(lvl_Filial))
	End If
	
	This.of_AppendWhere("a.cd_filial_origem  = " + String(gvo_parametro.of_filial()) )
	
End If

If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
	This.of_AppendWhere("exists (select 1 from item_nf_transferencia i1"+ &
										 " Where i1.cd_filial_origem = a.cd_filial_origem "+&
										 " And i1.nr_nf = a.nr_nf "+ &
										 " And i1.de_especie = a.de_especie "+ &
										 " And i1.de_serie = a.de_serie "+&
										 " And i1.cd_produto = "+String(lvl_Produto)+")")
End If

If Not IsNull(lvdh_Inicio) Then
	This.of_AppendWhere("a.dh_movimentacao_caixa >= '" + String(lvdh_Inicio, "yyyymmdd") + "'" )
End If

If Not IsNull(lvdh_Termino) Then
	This.of_AppendWhere("a.dh_movimentacao_caixa <= '" + String(lvdh_Termino, "yyyymmdd") + "'" )
End If

If Not IsNull(lvl_NF) and lvl_NF > 0 Then
	This.of_AppendWhere("a.nr_nf = " + String(lvl_NF) )
End If

If Not IsNull(lvs_Especie) and lvs_Especie <> "" Then
	This.of_AppendWhere("a.de_especie = '" + lvs_Especie + "'" )
End If

If Not IsNull(lvs_Serie) and lvs_Serie <> "" Then
	This.of_AppendWhere("a.de_serie = '" + lvs_Serie + "'" )
End If

Choose Case lvs_Situacao
	Case "C"
		This.of_AppendWhere("a.dh_cancelamento is not null" )
	Case "N"
		This.of_AppendWhere("a.dh_cancelamento is null" )
End Choose

//Retirado para atender o chamado 139322
//This.of_AppendWhere("a.id_produto_vencido <> 'S'" )

If Not IsNull(lvl_Centro_Custo) Then
	This.of_AppendWhere("a.cd_centro_custo = "+String(lvl_Centro_Custo))
End If

If lvs_Tipo_nota = "U" Then	//Urgente
	This.of_AppendWhere("a.nr_pedido_distribuidora is null and coalesce(id_almoxarifado, 'N') <> 'S'")	
ElseIf lvs_Tipo_nota = "N" Then	//Normal
	This.of_AppendWhere("a.nr_pedido_distribuidora is not null and coalesce(id_almoxarifado, 'N') <> 'S'")
ElseIf lvs_Tipo_nota = "A" Then	//Almoxarifado
	This.of_AppendWhere("a.nr_pedido_distribuidora is not null and coalesce(id_almoxarifado, 'N') = 'S'")
ElseIf lvs_Tipo_nota = "B" Then	//Urgente Almoxarifado
	This.of_AppendWhere("a.nr_pedido_distribuidora is null and coalesce(id_almoxarifado, 'N') = 'S'")
End If

Return 1
end event

event dw_2::ue_retrieve;call super::ue_retrieve;//IF AncestorReturnValue > 0 THEN
//	
//	If Tab_1.TabPage_1.dw_1.Object.id_entrada_saida[1] = 'S' Then
//		
//		tab_1.tabpage_1.cb_1.Enabled = TRUE
//		THIS.Event RowFocusChanged(1)		
//	Else		
//		tab_1.tabpage_1.cb_1.Enabled = FALSE
//	End If		
//ELSE
//	tab_1.tabpage_1.cb_1.Enabled = FALSE
//END IF

RETURN AncestorReturnValue



end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If currentRow > 0 Then
	
	dw_5.Object.nm_responsavel	[1] = This.Object.nm_usuario					[ currentRow ]
	dw_5.Object.nr_matricula		[1] = This.Object.nr_matricula_entrada_cd	[ currentRow ]
	dw_5.Object.dh_entrada			[1] = This.Object.dh_entrada_cd				[ currentRow ]
	
	If dw_2.Object.cd_filial_origem[currentRow] = 534 or &
		dw_2.Object.cd_filial_origem[currentRow] = 294 Then
	  	cb_Imprimir_Etiqueta.Enabled = True
	Else
		cb_Imprimir_Etiqueta.Enabled = False
	End If
	
	//Mesmo que o bot$$HEX1$$e300$$ENDHEX$$o seja habilitado, pode n$$HEX1$$e300$$ENDHEX$$o estar vis$$HEX1$$ed00$$ENDHEX$$vel (a visibilidade dele foi determinada no ue_postopen)
	If dw_2.Object.id_retirada_excesso [currentRow] = 'S' and &
		IsNull (dw_2.Object.dh_cancelamento [currentRow]) then
		cb_reimprimir_etq_excesso.Enabled = True
	Else
		cb_reimprimir_etq_excesso.Enabled = False
	End If
	
End If
end event

event dw_2::ue_postretrieve;//OverRide


String lvs_serie,&
		lvs_especie
Long  ll_Nota,&
		ll_Filial_origem,&
		ll_Filial_destino,&
		ll_Linha,&
		ll_Qtd_Iten
		
		
Boolean lvb_Habilita = False

If pl_Linhas > 0 Then
	lvb_Habilita = True
	
	// Trecho para Buscar a QtdIntes Nota
	If Not IsValid(w_aguarde) then
		Open(w_aguarde)
	End If	
		
	w_aguarde.Title =  "Atualizando Qtd Itens.: Nota:"
	w_aguarde.uo_progress.of_reset()
	w_aguarde.uo_progress.Of_SetMax(pl_Linhas)		
	
	For ll_Linha = 1 To pl_Linhas
		ll_Nota			=  dw_2.Object.nr_nf [ll_Linha]
		ll_Filial_origem =	dw_2.Object.cd_filial_origem [ll_Linha]
		ll_Filial_destino =  dw_2.Object.cd_filial_destino[ll_Linha]
		lvs_serie   		=	dw_2.Object.de_serie [ll_Linha]
		lvs_especie 		=	dw_2.Object.de_especie  [ll_Linha]
		w_aguarde.Title = "Atualizando Qtd Itens.: Nota:"  + String(ll_Nota)  + " Serie:" + String(lvs_serie)+" Especie:"+String(lvs_especie)				
		
		// Fun$$HEX2$$e700e300$$ENDHEX$$o busca QtdItens da Nota
		If wf_atualiza_itens  (ll_Filial_origem , ll_Filial_destino , ll_Nota , lvs_serie , lvs_especie ,  ll_Qtd_Iten) Then 
			dw_2.Object.qtd_itens[ll_Linha] = ll_Qtd_Iten
		End If 
		w_aguarde.uo_progress.Of_SetProgress(ll_Linha)		
	Next
	If IsValid(w_aguarde) then Close(w_aguarde)
		
	
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
ElseIf pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

//This.ivo_Controle_Menu.of_Classificar(lvb_Habilita)
//This.ivo_Controle_Menu.of_Filtrar(lvb_Habilita)
//This.ivo_Controle_Menu.of_Localizar(lvb_Habilita)
//This.ivo_Controle_Menu.of_Imprimir(lvb_Habilita)
Return pl_Linhas
end event

event dw_2::getfocus;call super::getfocus;If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
	Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_salvarcomo( True)
End If

end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 3506
integer height = 1536
end type

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer y = 728
integer width = 3461
integer height = 792
long backcolor = 79741120
string text = "Itens"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer y = 20
integer width = 3461
integer height = 704
long backcolor = 79741120
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 46
integer y = 96
integer width = 3410
integer height = 592
string dataobject = "dw_ge165_detalhe_consulta_transferencia"
end type

event dw_3::ue_recuperar;// OverRide

Long lvl_Cd_Filial_Origem, &
     lvl_Nr_NF
	  
String lvs_De_Especie, &
       lvs_De_Serie
		 
Integer lvi_Linha_Ativa, &
        lvi_Linhas
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial_Origem = Tab_1.TabPage_1.dw_2.Object.Cd_Filial_Origem[lvi_Linha_Ativa]
lvl_Nr_NF            = Tab_1.TabPage_1.dw_2.Object.Nr_NF[lvi_Linha_Ativa]
lvs_De_Especie       = Tab_1.TabPage_1.dw_2.Object.De_Especie[lvi_Linha_Ativa]
lvs_De_Serie         = Tab_1.TabPage_1.dw_2.Object.De_Serie[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(lvl_Cd_Filial_Origem, &
                           lvl_Nr_NF, &
									lvs_De_Especie, &
									lvs_De_Serie)

Return lvi_Linhas

end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer y = 780
integer width = 3392
integer height = 720
string dataobject = "dw_ge165_detalhe_item_transferencia"
boolean vscrollbar = true
end type

event dw_4::ue_recuperar;// OverRide

Long lvl_Cd_Filial_Origem, &
     lvl_Nr_NF
	  
String lvs_De_Especie, &
       lvs_De_Serie
		 
Integer lvi_Linha_Ativa, &
        lvi_Linhas
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial_Origem = Tab_1.TabPage_1.dw_2.Object.Cd_Filial_Origem[lvi_Linha_Ativa]
lvl_Nr_NF            = Tab_1.TabPage_1.dw_2.Object.Nr_NF[lvi_Linha_Ativa]
lvs_De_Especie       = Tab_1.TabPage_1.dw_2.Object.De_Especie[lvi_Linha_Ativa]
lvs_De_Serie         = Tab_1.TabPage_1.dw_2.Object.De_Serie[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(lvl_Cd_Filial_Origem, &
                           lvl_Nr_NF, &
									lvs_De_Especie, &
									lvs_De_Serie)

Return lvi_Linhas

end event

event dw_4::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_4::getfocus;call super::getfocus;If Tab_1.TabPage_2.dw_4.RowCount() > 0 Then
	Tab_1.TabPage_2.dw_4.ivo_Controle_Menu.of_salvarcomo( True)
End If
end event

type gb_5 from groupbox within tabpage_1
integer x = 27
integer y = 1320
integer width = 3465
integer height = 192
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Entrada CD"
end type

type cb_1 from commandbutton within tabpage_1
boolean visible = false
integer x = 2409
integer y = 432
integer width = 535
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cancelar Nota"
end type

event clicked;Long lvl_Linha, &
     lvl_Filial, &
     lvl_NF
	  
String lvs_Especie,&
       lvs_Serie,&
		 lvs_Matricula,&
		 lvs_Mensagem

DateTime lvdh_Caixa, &
         lvdh_Cancelamento
			
lvl_Linha = Parent.dw_2.GetRow()

If lvl_Linha <= 0 Then Return

If Not gvo_Aplicacao.ivo_Seguranca.of_Acesso_Procedimento("CANCELAMENTO_NF_TRANSFERENCIA") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o tem acesso a este procedimento.", StopSign!)
	Return
End If

lvdh_Caixa        		= Parent.dw_2.Object.Dh_Movimentacao_Caixa	[lvl_Linha]
lvdh_Cancelamento	= Parent.dw_2.Object.Dh_Cancelamento				[lvl_Linha]

If Date(lvdh_Caixa) <> Date(ivdh_Parametro) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Notas fiscais emitidas em dias anteriores n$$HEX1$$e300$$ENDHEX$$o podem ser canceladas.", StopSign!)
	Return
End If

If Not IsNull(lvdh_Cancelamento) Then
	lvs_Mensagem = "A nota fiscal '" + String(lvl_NF) + "', esp$$HEX1$$e900$$ENDHEX$$cie '" + lvs_Especie + "', s$$HEX1$$e900$$ENDHEX$$rie '" + lvs_Serie + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cancelada."
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Exclamation!)
	Return 1
End If

lvl_Filial		= Parent.dw_2.Object.Cd_Filial_Origem	[lvl_Linha]
lvl_NF			= Parent.dw_2.Object.Nr_NF				[lvl_Linha]
lvs_Especie	= Parent.dw_2.Object.De_Especie			[lvl_Linha]
lvs_Serie		= Parent.dw_2.Object.De_Serie			[lvl_Linha]

If lvs_Especie = "NFE" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta nota s$$HEX1$$f300$$ENDHEX$$ poder$$HEX1$$e100$$ENDHEX$$ ser cancelada pelo sistema da NFE.")
	Return 
End If

lvs_Mensagem = "Confirma o cancelamento da nota fiscal '" + String(lvl_NF) + "', esp$$HEX1$$e900$$ENDHEX$$cie '" + lvs_Especie + "', s$$HEX1$$e900$$ENDHEX$$rie '" + lvs_Serie + "' ?"

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Question!, YesNo!) = 1 Then
	
	SetPointer(HourGlass!)
	
	lvs_Matricula = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	
	Update nf_transferencia
	Set dh_cancelamento           = :ivdh_Parametro,
	    nr_matricula_cancelamento = :lvs_Matricula
   Where cd_filial_origem = :lvl_Filial
	  and nr_nf            = :lvl_NF
	  and de_especie       = :lvs_Especie
	  and de_serie         = :lvs_Serie
	Using SqlCa;

	If SqlCa.SqlCode = 0 Then
		
		SqlCa.of_Commit();
		
		If SqlCa.SqlCode = -1 Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no commit." + SqlCa.SqlErrText, StopSign!)
		
	Else
		Sqlca.of_RollBack()
		Sqlca.of_MsgDbError("Cancelamento de Nota Fiscal.")		
	End If
		 
	Parent.dw_2.Event ue_Retrieve()
	
End If
end event

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 82
integer y = 1396
integer width = 3346
integer height = 72
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge165_responsavel_entrada_cd"
end type

type cb_imprimir_etiqueta from commandbutton within tabpage_1
integer x = 2958
integer y = 432
integer width = 535
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Imprimir Etiqueta"
end type

event clicked;uo_etiqueta lo_Etiqueta
Long ll_Nf, ll_Filial_Origem, ll_Row
String ls_Especie, ls_Serie

dw_2.AcceptText()

ll_Row = dw_2.GetRow()

ll_Nf 					= dw_2.Object.nr_nf[ll_Row]
ls_Especie 			= dw_2.Object.de_especie[ll_Row]
ls_Serie 				= dw_2.Object.de_serie[ll_Row]
ll_Filial_Origem 	= dw_2.Object.cd_filial_origem[ll_Row]

lo_Etiqueta = create uo_etiqueta

lo_Etiqueta.of_imprimir_etiqueta(ll_Filial_Origem, ll_Nf, ls_Especie, ls_Serie)

destroy(lo_Etiqueta)

ivo_volumes.ib_ja_imprimiu_etiqueta = False	//Para for$$HEX1$$e700$$ENDHEX$$ar o PrintSetup se for imprimir etiqueta de excesso depois




end event

type cb_solicita_canc_sap from commandbutton within tabpage_1
integer x = 1861
integer y = 432
integer width = 535
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
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
		ll_Linha
	
If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE165_SOLICITA_CANCELAMENTO", ref ls_Operador) Then return

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Linha		= Tab_1.TabPage_1.dw_2.GetRow( )
ll_NF			= Tab_1.TabPage_1.dw_2.Object.nr_nf				[ll_Linha]
ll_Filial		= Tab_1.TabPage_1.dw_2.Object.cd_filial_origem	[ll_Linha]
ls_Serie		= Tab_1.TabPage_1.dw_2.Object.de_serie			[ll_Linha]
ls_Especie	= Tab_1.TabPage_1.dw_2.Object.de_especie		[ll_Linha]
ldt_dh_movimentacao_caixa	=Tab_1.TabPage_1.dw_2.Object.dh_movimentacao_caixa[ll_Linha]

If wf_busca_datas_nota_transferencia( ll_Filial, ll_NF, ls_Especie, ls_Serie, ref ldt_dh_recebido_sap, ref ldt_dh_cancelamento, ref ldt_dh_solicitacao_canc, ref ls_msg ) Then
	If Not IsNull(ldt_dh_recebido_sap) Then
		If IsNull(ldt_dh_cancelamento) Then
			If IsNull(ldt_dh_solicitacao_canc) Then
				If wf_busca_chave_nfe( ll_Filial, ll_NF, ls_Especie, ls_Serie, ref ls_chave_nfe, ref ls_msg ) Then
					If wf_atualiza_nota_transferencia( ll_Filial, ll_NF, ls_Especie, ls_Serie, ls_Operador, ref ls_msg ) Then
						If wf_grava_log_exportacao_sap( ll_Filial, ll_NF, ls_Especie, ls_Serie, ls_chave_nfe, ldt_dh_movimentacao_caixa, ref ls_msg) Then
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

type cb_reimprimir_etq_excesso from commandbutton within tabpage_1
boolean visible = false
integer x = 1047
integer y = 432
integer width = 800
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reimprimir Etiqueta Excesso"
end type

event clicked;Long								ll_Linha
st_ge642_parametros_nota	lst_par_nota
String							ls_Lista_Volumes, &
									ls_Usuario

If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento ('GE642_REIMPRIMIR_ETIQUETA', ref ls_Usuario) then
	Return
End if

ll_Linha = dw_2.GetRow ()

If ll_Linha < 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione uma nota de retirada de excesso que n$$HEX1$$e300$$ENDHEX$$o esteja cancelada!', Exclamation!)
	Return
End if

lst_par_nota.cd_filial   = dw_2.Object.cd_filial_origem          [ll_Linha]
lst_par_nota.nm_fantasia = dw_2.Object.filial_nm_fantasia_origem [ll_Linha]
lst_par_nota.nr_nf       = dw_2.Object.nr_nf                     [ll_Linha]
lst_par_nota.de_especie  = dw_2.Object.de_especie                [ll_Linha]
lst_par_nota.de_serie    = dw_2.Object.de_serie                  [ll_Linha]
lst_par_nota.id_acao     = 'I'

OpenWithParm (w_ge642_volumes_excesso, lst_par_nota)

ls_Lista_Volumes = Message.StringParm

If IsNUll (ls_Lista_Volumes) then
	Return
End if

ivo_volumes.of_imprime_etiqueta (lst_par_nota.cd_filial, lst_par_nota.nr_nf, lst_par_nota.de_especie, lst_par_nota.de_serie, ls_lista_volumes)

end event

type cb_imprimir_nota from commandbutton within tabpage_1
integer x = 613
integer y = 432
integer width = 421
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
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
	If not lds_nota.of_ChangeDataObject ('dw_ge165_imagem_nota') then Return
	
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

