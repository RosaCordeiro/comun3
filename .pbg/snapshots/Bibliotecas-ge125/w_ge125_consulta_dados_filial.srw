HA$PBExportHeader$w_ge125_consulta_dados_filial.srw
forward
global type w_ge125_consulta_dados_filial from dc_w_selecao_lista_relatorio
end type
type cb_exportar from commandbutton within w_ge125_consulta_dados_filial
end type
end forward

global type w_ge125_consulta_dados_filial from dc_w_selecao_lista_relatorio
string tag = "w_ge125_consulta_dados_filial"
integer width = 3662
integer height = 1788
string title = "GE125 - Consulta Dados Gerais Filial"
cb_exportar cb_exportar
end type
global w_ge125_consulta_dados_filial w_ge125_consulta_dados_filial

type variables
dc_uo_transacao ivtr_mysql

dc_uo_ds_base ivds_farmagora
dc_uo_ds_base ivds_disque
dc_uo_ds_base ivds_filial
uo_filial	 		ivo_filial
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();Integer 	lvi_Retorno, &
        		lvi_Linha

Long lvl_Regiao

DataWindowChild lvdwc

lvi_Retorno = dw_1.GetChild("cd_regiao", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_regiao", 0)
		lvdwc.SetItem(lvi_Linha, "de_regiao", "TODAS")
		
		select cd_regiao
		Into :lvl_Regiao
		From regiao
		Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
		Using SQLCa;
		
		If SQLCa.SQLCode = 0 Then
			dw_1.Object.cd_regiao[1] = lvl_Regiao
		Else
			dw_1.Object.cd_regiao[1] = 0	
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da regi$$HEX1$$e300$$ENDHEX$$o default.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If
end subroutine

on w_ge125_consulta_dados_filial.create
int iCurrent
call super::create
this.cb_exportar=create cb_exportar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exportar
end on

on w_ge125_consulta_dados_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_exportar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = gf_primeiro_dia_mes(Today())

wf_insere_padrao()

ivtr_mysql.ivs_DataBase 	= "MYSQL"
ivtr_mysql.ivs_Usuario 	= "gambiarra"

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "CO" Then
	If Not ivtr_mysql.of_Connect("Intranet", "DM",False) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',"Erro na Conex$$HEX1$$e300$$ENDHEX$$o com o Banco de Dados da Intranet.~r~n As informa$$HEX2$$e700f500$$ENDHEX$$es de 5S n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o recuperadas!~r~r"+ sqlca.sqlerrtext, Exclamation!)
	End If
End If

ivds_filial.Retrieve()
end event

event ue_preopen;call super::ue_preopen;//N$$HEX1$$e300$$ENDHEX$$o permite fechamento por inatividade
ivb_permite_fechar = False

ivtr_mysql 		= Create dc_uo_transacao
ivds_farmagora	= Create dc_uo_ds_base
ivds_disque		= Create dc_uo_ds_base
ivds_filial			= Create dc_uo_ds_base
ivo_filial			= Create uo_filial

ivds_filial.of_ChangeDataObject('ds_ge125_filial_regiao')

MaxWidth 	= 9999
MaxHeight 	= 9999
end event

event close;call super::close;If ivtr_mysql.of_isconnected( ) Then ivtr_mysql.of_disconnect( )
Destroy(ivtr_mysql)
Destroy(ivds_farmagora)
Destroy(ivds_disque)
Destroy(ivds_filial)
Destroy(ivo_filial)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge125_consulta_dados_filial
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge125_consulta_dados_filial
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge125_consulta_dados_filial
integer x = 32
integer y = 292
integer width = 3557
integer height = 1280
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge125_consulta_dados_filial
integer width = 2921
integer height = 264
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge125_consulta_dados_filial
integer width = 2862
integer height = 184
string dataobject = "dw_ge125_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'nm_filial' 
		
			ivo_filial.of_Localiza_filial(This.GetText())
			
			If Not ivo_filial.Localizada Then	ivo_filial.Of_Inicializa()
				
			This.Object.cd_filial	[1] = ivo_filial.cd_filial
			This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_filial) Then
	This.Object.nm_filial [1] = ivo_filial.nm_fantasia
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name 
	Case "nm_filial"
		If Data <> ivo_Filial.Nm_Fantasia Then
			If Data <> '' Then
				Return 1
			Else
				ivo_Filial.of_inicializa( )
				This.Object.cd_filial [Row] = ivo_Filial.cd_filial
			End If
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge125_consulta_dados_filial
integer x = 73
integer y = 368
integer width = 3483
integer height = 1172
string dataobject = "dw_ge125_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean livescroll = false
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

Long lvl_Linha
Long lvl_Find
Long lvl_Find_Desc
Long lvl_Filial
Long lvl_Filtro_Filial
Long lvl_Regiao
Long lvl_Grupo
Long lvl_Aux
Long lvl_Clientes
Long lvl_Progresso = 0

String lvs_Grupo
String lvs_Lei_Gen
String lvs_PBM
String lvs_Aux
String lvs_Convenio
String lvs_Disque_Farma
String ls_Id_Alt_Preco
String lvs_Canal

Decimal{2} lvdc_Aux
Decimal{2} lvdc_Venda

dw_1.AcceptText( )

lvs_Disque_Farma = dw_1.Object.id_deduz 	[1]
lvl_Filtro_Filial		= dw_1.Object.cd_filial	 	[1]
lvl_Regiao			= dw_1.Object.cd_regiao 	[1]
ls_Id_Alt_Preco 	= dw_1.Object.Id_Alt_Preco_Aberto[1]
lvdt_Inicio 			= Datetime(gf_primeiro_dia_mes(dw_1.Object.dt_inicio 	[1]) , Time('00:00'))
lvdt_Fim				= Datetime(gf_retorna_ultimo_dia_mes(Date(lvdt_Inicio)) , Time('23:59:59'))

If IsNull(lvdt_Inicio)or(lvdt_Inicio < Datetime('01/12/2010')) Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de in$$HEX1$$ed00$$ENDHEX$$cio inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!, Ok!)
	dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
End If

dc_uo_ds_base ivds_info
ivds_info = Create dc_uo_ds_base

dc_uo_ds_base ivds_info_2
ivds_info_2 = Create dc_uo_ds_base

Open(w_Aguarde)
w_Aguarde.uo_Progress.of_SetMax(26)

dw_2.SetRedraw(False)
dw_2.Reset()

If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then
	ivds_filial.SetFilter("cd_filial="+String(lvl_Filtro_Filial))
ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then
	ivds_filial.SetFilter("cd_regiao="+String(lvl_Regiao))
Else
	ivds_filial.SetFilter("")
End If
ivds_filial.Filter()

If ivtr_mysql.of_IsConnected( ) Then
	w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es 5S...'
	lvl_Progresso ++
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
	ivds_info.DataObject = 'ds_ge125_5s'
	ivds_info.SetTransObject(ivtr_mysql)
	
	ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)
	
	For lvl_Linha = 1 To ivds_info.RowCount()
		lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
		
		If ivds_filial.Find('cd_filial='+String(lvl_Filial),1,ivds_filial.RowCount())>0 Then //N$$HEX1$$e300$$ENDHEX$$o tem no banco da intranet a informa$$HEX2$$e700e300$$ENDHEX$$o de regiao
			lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
			If Not(lvl_Find > 0) Then
				lvl_Find = dw_2.InsertRow(0)
				dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
			End If
			dw_2.Object.vl_5s [lvl_Find] = ivds_info.Object.qt_pontos [lvl_Linha]
		End If
	Next
End If

w_Aguarde.Title = 'Recuperando Vendas com Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)

If ls_Id_Alt_Preco = "N" Then // Atera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o Normal
	ivds_info.of_changedataobject('ds_ge125_altera_preco')
	ivds_info.SetTransobject(SQLCa)
	
	/* Filtros */
	If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
	If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('n.cd_filial='+String(lvl_Filtro_Filial))
	/* Recupera */
	ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)
	
	For lvl_Linha = 1 To ivds_info.RowCount()
		lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
		lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = dw_2.InsertRow(0)
			dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
		End If
		dw_2.Object.vl_alteracao_preco [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
	Next
Else // Altera$$HEX2$$e700e300$$ENDHEX$$o de Preco - aberto F5/Neg/PVE
	ivds_info.of_changedataobject('ds_ge125_altera_preco_aberto')
	ivds_info.SetTransobject(SQLCa)
	
	/* Filtros */
	If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
	If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('n.cd_filial='+String(lvl_Filtro_Filial))
	/* Recupera */
	ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)
	
	String lvs_Tipo_Desc
	
	For lvl_Linha = 1 To ivds_info.RowCount()
		lvl_Filial 			= ivds_info.Object.cd_filial [lvl_Linha]
		lvs_Tipo_Desc 	= ivds_info.Object.id_tipo_desconto [lvl_Linha]
		lvl_Find 			= dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())		
		
		If Not(lvl_Find > 0) Then
			lvl_Find 								= dw_2.InsertRow(0)
			dw_2.Object.cd_filial [lvl_Find] = lvl_Filial			
		End If
				
		Choose Case lvs_Tipo_Desc
			Case "NEG"
				If lvdt_Inicio >= DateTime('01/06/2019') Then 
					dw_2.Object.vl_alteracao_preco_neg[lvl_Find] = ivds_info.Object.vl_desconto [lvl_Linha]
				Else
					dw_2.Object.vl_alteracao_preco_neg[lvl_Find] 	= ivds_info.Object.vl_desconto [lvl_Linha]
					dw_2.Object.vl_alteracao_preco [lvl_Find] 			= dw_2.Object.vl_alteracao_preco [lvl_Find] + (ivds_info.Object.vl_desconto1 [lvl_Linha] - ivds_info.Object.vl_desconto [lvl_Linha])
				End If
			Case "PVE"
				If lvdt_Inicio >= DateTime('01/06/2019') Then
					dw_2.Object.vl_alteracao_preco_pve[lvl_Find] = ivds_info.Object.vl_desconto[lvl_Linha]
				Else					
					dw_2.Object.vl_alteracao_preco_pve[lvl_Find] = ivds_info.Object.vl_desconto1 [lvl_Linha]
				End If
			Case Else
				If lvdt_Inicio >= DateTime('01/06/2019' ) Then
					dw_2.Object.vl_alteracao_preco [lvl_Find]	= dw_2.Object.vl_alteracao_preco [lvl_Find] + ivds_info.Object.vl_desconto[lvl_Linha]
				Else
					dw_2.Object.vl_alteracao_preco [lvl_Find]	= ivds_info.Object.vl_desconto1[lvl_Linha]
				End If
		End Choose

//		// NEG
//		lvl_Find_Desc = ivds_info.Find('cd_filial='+String(lvl_Filial) + ' and id_tipo_desconto = "NEG"', lvl_Linha, ivds_info.RowCount())
//		
//		If lvl_Find_Desc > 0 Then
//			dw_2.Object.vl_alteracao_preco_neg[lvl_Find] = ivds_info.Object.vl_desconto [lvl_Find_Desc]
//			dw_2.Object.vl_alteracao_preco [lvl_Find] 		= ivds_info.Object.vl_desconto1 [lvl_Find_Desc] - ivds_info.Object.vl_desconto [lvl_Find_Desc]
//		End If
//				
//		// F5
//		lvl_Find_Desc = ivds_info.Find('cd_filial='+String(lvl_Filial) +' and id_tipo_desconto = "F5"', lvl_Linha, ivds_info.RowCount())
//		
//		If lvl_Find_Desc > 0 Then
//			dw_2.Object.vl_alteracao_preco [lvl_Find] = dw_2.Object.vl_alteracao_preco [lvl_Find] +  ivds_info.Object.vl_desconto [lvl_Find_Desc]
//		End If
//
//		// PVE
//		lvl_Find_Desc = ivds_info.Find('cd_filial='+String(lvl_Filial) +' and id_tipo_desconto = "PVE"', lvl_Linha, ivds_info.RowCount())
//		
//		If lvl_Find_Desc > 0 Then
//			dw_2.Object.vl_alteracao_preco_pve[lvl_Find] = ivds_info.Object.vl_desconto [lvl_Find_Desc]
//		End If		
	Next	
End If	
//

w_Aguarde.Title = 'Recuperando Cancelamentos de Vendas...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_cancelamento_cf')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao), 2)
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao), 3)
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('l.cd_filial='+String(lvl_Filtro_Filial), 2)
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('nv.cd_filial='+String(lvl_Filtro_Filial), 3)
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.qt_cancelamentos [lvl_Find] = ivds_info.Object.qt_total [lvl_Linha]
Next

//ivds_info.of_changedataobject('ds_ge125_cliente_manip_itj')
w_Aguarde.Title = 'Recuperando Vendas...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_venda')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('r.cd_filial='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.qt_clientes	[lvl_Find] = ivds_info.Object.qt_clientes 	[lvl_Linha]
	dw_2.Object.vl_vendas	[lvl_Find] = ivds_info.Object.vl_valor		[lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Compras...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_compra')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('n.cd_filial='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_compras [lvl_Find] = ivds_info.Object.vl_compra [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Vendas para Conv$$HEX1$$ea00$$ENDHEX$$nio...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_convenio')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('n.cd_filial='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_convenios [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Informa$$HEX2$$e700f500$$ENDHEX$$es Estoque...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
If Date(lvdt_Inicio) = gf_primeiro_dia_mes(Today()) Then
	ivds_info.of_changedataobject('ds_ge125_estoque_grupo_atual')
ElseIf Date(lvdt_Inicio) >= Date('01/10/2014') Then
	ivds_info.of_changedataobject('ds_ge125_estoque_grupo')
Else
	ivds_info.of_changedataobject('ds_ge125_estoque_grupo_anterior')	
End If
/* Filtros */
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then 
	ivds_info.Of_AppendWhere('s.cd_filial='+String(lvl_Filtro_Filial))
ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then 
	ivds_info.Of_AppendWhere('s.cd_filial in (select f1.cd_filial from filial f1 where f1.cd_regiao='+String(lvl_Regiao)+')')
End If
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial 	= ivds_info.Object.cd_filial	[lvl_Linha]
	lvl_Grupo	= ivds_info.Object.cd_grupo	[lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	Choose Case lvl_Grupo
		Case 1
			lvdc_Aux = dw_2.Object.vl_estq_med	[lvl_Find]
			dw_2.Object.vl_estq_med	[lvl_Find] = lvdc_Aux + ivds_info.Object.vl_estoque [lvl_Linha]		
		Case 3
			lvdc_Aux = dw_2.Object.vl_estq_perf	[lvl_Find]
			dw_2.Object.vl_estq_perf	[lvl_Find] = lvdc_Aux + ivds_info.Object.vl_estoque [lvl_Linha]		
		Case Else			
			lvdc_Aux = dw_2.Object.vl_estq_pop	[lvl_Find]
			dw_2.Object.vl_estq_pop	[lvl_Find] = lvdc_Aux + ivds_info.Object.vl_estoque [lvl_Linha]
	End Choose
Next

For lvl_Aux = 1 To 6
	Choose Case lvl_Aux
		Case 1
			w_Aguarde.Title = 'Recuperando Vendas PBM - Vidalink - Outros...'
			ivds_info.of_changedataobject('ds_ge125_pbm_vdk')
			If lvdt_Inicio < Datetime('2016/11/01') Then
				lvs_Convenio = '52575'
			Else
				lvs_Convenio = '53724,53725'		
			End If
		Case 2
			w_Aguarde.Title = 'Recuperando Vendas PBM - Farm$$HEX1$$e100$$ENDHEX$$cia Popular...'
			ivds_info.of_changedataobject('ds_ge125_pbm_fpb')
			lvs_Convenio = '52575'
		Case 3
			w_Aguarde.Title = 'Recuperando Vendas PBM - PharmaSystem...'
			ivds_info.of_changedataobject('ds_ge125_pbm_phs')
			lvs_Convenio = '53545'
		Case 4
			w_Aguarde.Title = 'Recuperando Vendas PBM - TRNCentre...'
			ivds_info.of_changedataobject('ds_ge125_pbm_trn')
			lvs_Convenio = '52568'
		Case 5
			w_Aguarde.Title = 'Recuperando Vendas PBM - Funcional...'
			ivds_info.of_changedataobject('ds_ge125_pbm_fun')
			lvs_Convenio = '52349'
		Case 6
			w_Aguarde.Title = 'Recuperando Vendas PBM - E-Pharma...'
			ivds_info.of_changedataobject('ds_ge125_pbm_eph')
			lvs_Convenio = '52718'
		Case 7
			w_Aguarde.Title = 'Recuperando Vendas PBM - Vidalink - Copel...'
			ivds_info.of_changedataobject('ds_ge125_pbm_vdk')
			lvs_Convenio = '53724'
	End Choose
	
	
	lvl_Progresso ++
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
	/* Filtros */
	If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then 
		ivds_info.Of_AppendWhere('k.cd_filial='+String(lvl_Filtro_Filial))
		/*Altera $$HEX1$$ed00$$ENDHEX$$ndice fixo */
		lvs_Aux = ivds_info.GetSQLSelect()
		lvs_Aux = gf_replace(lvs_Aux, 'idx_data_convenio','idx_fil_dt_conv',0)
		ivds_info.SetSQLSelect(lvs_Aux)
	ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then
		ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
		/*Altera $$HEX1$$ed00$$ENDHEX$$ndice fixo */
		lvs_Aux = ivds_info.GetSQLSelect()
		lvs_Aux = gf_replace(lvs_Aux, 'idx_data_convenio','idx_fil_dt_conv',0)
		ivds_info.SetSQLSelect(lvs_Aux)
	End If
	
	//N$$HEX1$$e300$$ENDHEX$$o utiliza o filtro pelo produto em vendas FPB
	If lvl_Aux <> 2 Then
		If lvdt_Inicio < Datetime('01/04/2015') Then
			ivds_info.Of_AppendWhere("exists (select  1 " 											+ &
														"from pbm pb1 "									+ &
														"inner join pbm_produto p1 "					+ &
															"on p1.cd_pbm = pb1.cd_pbm "			+ &
														"Where pb1.cd_convenio in ("+lvs_Convenio+")"	+ &
															"And p1.cd_produto = inf.cd_produto )")
		Else
			ivds_info.Of_AppendWhere("x.id_pbm='S'")
		End If
	End If
	/* Recupera */
	ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)
	
	For lvl_Linha = 1 To ivds_info.RowCount()
		lvl_Filial 	= ivds_info.Object.cd_filial	[lvl_Linha]
		lvl_Find 	= dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = dw_2.InsertRow(0)
			dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
		End If
		Choose Case lvl_Aux
			Case 1
				lvdc_Aux = dw_2.Object.vl_vidalink [lvl_Find]
				If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
				dw_2.Object.vl_vidalink			[lvl_Find] = lvdc_Aux + ivds_info.Object.vl_venda [lvl_Linha]
			Case 2
				dw_2.Object.vl_fpb				[lvl_Find] = ivds_info.Object.vl_venda [lvl_Linha]
			Case 3
				dw_2.Object.vl_pharmasystem	[lvl_Find] = ivds_info.Object.vl_venda [lvl_Linha]
			Case 4
				dw_2.Object.vl_trncenter		[lvl_Find] = ivds_info.Object.vl_venda [lvl_Linha]
			Case 5
				dw_2.Object.vl_funcional			[lvl_Find] = ivds_info.Object.vl_venda [lvl_Linha]
			Case 6
				dw_2.Object.vl_epharma			[lvl_Find] = ivds_info.Object.vl_venda [lvl_Linha]
		End Choose
	Next
Next

w_Aguarde.Title = 'Recuperando Devolu$$HEX2$$e700f500$$ENDHEX$$es Vendas PBM...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_pbm_devolucao')
/* Filtros */
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then 
	ivds_info.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial),6)
	ivds_info.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial),5)
	ivds_info.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial),4)
	ivds_info.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial),3)
	ivds_info.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial),2)
	ivds_info.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial),1)
ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao),6)
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao),5)
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao),4)
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao),3)
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao),2)
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao),1)
End If
If lvdt_Inicio < Datetime('01/04/2015') Then
	ivds_info.Of_AppendWhere("exists (select  1 " 											+ &
												"from pbm pb1 "									+ &
												"inner join pbm_produto p1 "					+ &
													"on p1.cd_pbm = pb1.cd_pbm "			+ &
												"Where pb1.cd_convenio =k.cd_convenio "	+ &
													"And p1.cd_produto = inf.cd_produto )",6)
	ivds_info.Of_AppendWhere("exists (select  1 " 											+ &
												"from pbm pb1 "									+ &
												"inner join pbm_produto p1 "					+ &
													"on p1.cd_pbm = pb1.cd_pbm "			+ &
												"Where pb1.cd_convenio =k.cd_convenio "	+ &
													"And p1.cd_produto = inf.cd_produto)",5)
	ivds_info.Of_AppendWhere("exists (select  1 " 											+ &
												"from pbm pb1 "									+ &
												"inner join pbm_produto p1 "					+ &
													"on p1.cd_pbm = pb1.cd_pbm "			+ &
												"Where pb1.cd_convenio =53545 "	+ &
													"And p1.cd_produto = inf.cd_produto )",4)
	ivds_info.Of_AppendWhere("exists (select  1 " 											+ &
												"from pbm pb1 "									+ &
												"inner join pbm_produto p1 "					+ &
													"on p1.cd_pbm = pb1.cd_pbm "			+ &
												"Where pb1.cd_convenio =k.cd_convenio "	+ &
													"And p1.cd_produto = inf.cd_produto)",3)
	ivds_info.Of_AppendWhere("exists (select  1 " 											+ &
												"from pbm pb1 "									+ &
												"inner join pbm_produto p1 "					+ &
													"on p1.cd_pbm = pb1.cd_pbm "			+ &
												"Where pb1.cd_convenio =k.cd_convenio "	+ &
													"And p1.cd_produto = inf.cd_produto )",1)
Else
	ivds_info.Of_AppendWhere("x.id_pbm='S'",6)
	ivds_info.Of_AppendWhere("x.id_pbm='S'",5)
	ivds_info.Of_AppendWhere("x.id_pbm='S'",4)
	ivds_info.Of_AppendWhere("x.id_pbm='S'",3)
	ivds_info.Of_AppendWhere("x.id_pbm='S'",1)
End If
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial 	= ivds_info.Object.cd_filial	[lvl_Linha]
	lvs_PBM	= ivds_info.Object.tipo		[lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	Choose Case lvs_PBM
		Case 'EPH'
			lvdc_Venda = dw_2.Object.vl_epharma			[lvl_Find]
			dw_2.Object.vl_epharma			[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_devolucao [lvl_Linha]
		Case 'FPB'
			lvdc_Venda = dw_2.Object.vl_fpb					[lvl_Find]
			dw_2.Object.vl_fpb				[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_devolucao [lvl_Linha]
		Case 'FUN'
			lvdc_Venda = dw_2.Object.vl_funcional			[lvl_Find]
			dw_2.Object.vl_funcional			[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_devolucao [lvl_Linha]		
		Case 'PHS'
			lvdc_Venda = dw_2.Object.vl_pharmasystem	[lvl_Find]
			dw_2.Object.vl_pharmasystem	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_devolucao [lvl_Linha]		
		Case 'TRN'		
			lvdc_Venda = dw_2.Object.vl_trncenter			[lvl_Find]
			dw_2.Object.vl_trncenter		[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_devolucao [lvl_Linha]	
		Case 'VDL'
			lvdc_Venda = dw_2.Object.vl_vidalink			[lvl_Find]
			dw_2.Object.vl_vidalink			[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_devolucao [lvl_Linha]
	End Choose
Next

w_Aguarde.Title = 'Recuperando Psico Vencidos...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_psico_vencido')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('asai.cd_filial_ajuste='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)
For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_psico_vencidos [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Qtde Produtos Vendidos...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_qt_produto')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('r.cd_filial='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.qt_produto [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Quebra Invent$$HEX1$$e100$$ENDHEX$$rio...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_quebrainventario')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('a.cd_filial_ajuste='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_quebra_inventario [lvl_Find] = ivds_info.Object.vl_ajuste [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Transfer$$HEX1$$ea00$$ENDHEX$$ncias de Entrada...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_trans_entrada')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('n.cd_filial_destino='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_transf_entrada [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Transfer$$HEX1$$ea00$$ENDHEX$$ncias de Sa$$HEX1$$ed00$$ENDHEX$$da...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_trans_saida')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('n.cd_filial_origem='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_transf_saida [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Transfer$$HEX1$$ea00$$ENDHEX$$ncias do Perini...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_transferencia')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('n.cd_filial_destino='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_transferencia [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Produtos Vencidos...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_vencidos')
/* Filtros */
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then
	ivds_info.Of_AppendWhere('asai.cd_filial_ajuste='+String(lvl_Filtro_Filial),2)
	ivds_info.Of_AppendWhere('n.cd_filial_origem='+String(lvl_Filtro_Filial),1)
ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then 
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao),2)
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao),1)
End If
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	lvdc_Aux = dw_2.Object.vl_vencidos [lvl_Find]
	If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
	dw_2.Object.vl_vencidos [lvl_Find] = lvdc_Aux + ivds_info.Object.vl_valor [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Vendas por Grupo de Produto...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_venda_grupo')
/* Filtros */
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then
	ivds_info.Of_AppendWhere('r.cd_filial='+String(lvl_Filtro_Filial))
ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then 
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
End If
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial 		= ivds_info.Object.cd_filial		[lvl_Linha]
	lvs_Grupo	= ivds_info.Object.cd_grupo		[lvl_Linha]
	lvs_Lei_Gen	= ivds_info.Object.id_generico	[lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	Choose Case lvs_Grupo
		Case '1'
			Choose Case lvs_Lei_Gen
				Case 'G'
					lvdc_Venda 	= dw_2.Object.vl_genericos		[lvl_Find]
					dw_2.Object.vl_genericos	[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
				Case 'R'
					lvdc_Venda 	= dw_2.Object.vl_referencia	[lvl_Find]
					dw_2.Object.vl_referencia	[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
				Case 'S'
					lvdc_Venda 	= dw_2.Object.vl_similar			[lvl_Find]
					dw_2.Object.vl_similar		[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
				Case 'E'
					lvdc_Venda 	= dw_2.Object.vl_equivalente	[lvl_Find]
					dw_2.Object.vl_equivalente	[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
				Case 'O'
					lvdc_Venda 	= dw_2.Object.vl_outros	[lvl_Find]
					dw_2.Object.vl_outros	[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]					
			End Choose
		Case '2'
			lvdc_Venda 	= dw_2.Object.vl_popular			[lvl_Find]
			dw_2.Object.vl_popular			[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
		Case '3'
			lvdc_Venda 	= dw_2.Object.vl_perfumaria		[lvl_Find]
			dw_2.Object.vl_perfumaria		[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
		Case '4'
			lvdc_Venda 	= dw_2.Object.vl_conveniencia		[lvl_Find]
			dw_2.Object.vl_conveniencia	[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
		Case '6'
			lvdc_Venda 	= dw_2.Object.vl_manipulacao		[lvl_Find]
			dw_2.Object.vl_manipulacao	[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
		Case Else
			lvdc_Venda 	= dw_2.Object.vl_diversos 			[lvl_Find]
			dw_2.Object.vl_diversos 			[lvl_Find] = lvdc_Venda + ivds_info.Object.vl_venda [lvl_Linha]
	End Choose
Next

If lvs_Disque_Farma = 'S' Then
	/* Cliente NF */
	dc_uo_ds_base ivds_info_3
	dc_uo_ds_base ivds_info_4
	ivds_info_3 = Create dc_uo_ds_base
	ivds_info_4 = Create dc_uo_ds_base
	ivds_info_3.Of_ChangeDataObject('ds_ge125_cliente_vd')
	ivds_info_4.Of_ChangeDataObject('ds_ge125_cliente_dv')
	ivds_info_3.of_appendwhere('nf.nr_pedido_ecommerce is null')
	ivds_info_4.of_appendwhere('v.nr_pedido_ecommerce is null')
	ivds_info_3.of_appendwhere('nf.nr_pedido_drogaexpress is not null')
	ivds_info_4.of_appendwhere('v.nr_pedido_drogaexpress is not null')
	
	w_Aguarde.Title = 'Recuperando Vendas Disque Entrega...'
	lvl_Progresso ++
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
	ivds_info.of_changedataobject('ds_ge125_disque_venda_grupo')
	ivds_info_2.of_changedataobject('ds_ge125_disque_devolucao_grupo')

	/* Filtros */
	If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then
		ivds_info.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial))
		ivds_info_2.Of_AppendWhere('nf.cd_filial_venda='+String(lvl_Filtro_Filial))
		ivds_info_3.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial))
		ivds_info_4.Of_AppendWhere('nf.cd_filial_venda='+String(lvl_Filtro_Filial))
	ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then 
		ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
		ivds_info_2.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
		ivds_info_3.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
		ivds_info_4.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
	End If
	
	//Se a pesquisa for anterior a 2014 deve desconsiderar as vendas da 748-Alomed como disque
	If Date(lvdt_Inicio) < Date('01/01/2015') Then
		ivds_info_4.of_appendWhere("(((nf.dh_movimentacao_caixa < '2015/01/01') and (nf.cd_filial<>748))or(nf.dh_movimentacao_caixa >= '2015/01/01'))")
		ivds_info_3.of_appendWhere("(((nf.dh_movimentacao_caixa < '2015/01/01') and (nf.cd_filial<>748))or(nf.dh_movimentacao_caixa >= '2015/01/01'))")
		ivds_info_2.of_appendWhere("(((nf.dh_movimentacao_caixa < '2015/01/01') and (nf.cd_filial<>748))or(nf.dh_movimentacao_caixa >= '2015/01/01'))")
		ivds_info.of_appendWhere("(((nf.dh_movimentacao_caixa < '2015/01/01') and (nf.cd_filial<>748))or(nf.dh_movimentacao_caixa >= '2015/01/01'))")
	End If
	
	ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)
	ivds_info_2.Retrieve(lvdt_Inicio,lvdt_Fim)
	ivds_info_3.Retrieve(lvdt_Inicio,lvdt_Fim)
	ivds_info_4.Retrieve(lvdt_Inicio,lvdt_Fim)
	//Deduzindo as Clientes das Vendas Farmagora
	For lvl_Linha = 1 To ivds_info_3.RowCount()
		lvl_Filial	= ivds_info_3.Object.cd_filial			[lvl_Linha]
		lvl_Find = dw_2.Find("cd_filial="+String(lvl_Filial), 1, dw_2.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = dw_2.InsertRow(0)
			dw_2.Object.cd_filial 		[lvl_Find] = lvl_Filial
			dw_2.Object.qt_clientes	[lvl_Find] = 0
		End If		
		lvl_Clientes	= dw_2.Object.qt_clientes [lvl_Find]
		dw_2.Object.qt_clientes	[lvl_Find] = lvl_Clientes - ivds_info_3.Object.qt_cliente	[lvl_Linha]
	Next
	//Adicionando Clientes Devolu$$HEX2$$e700f500$$ENDHEX$$es das Vendas
	For lvl_Linha = 1 To ivds_info_4.RowCount()
		lvl_Filial	= ivds_info_4.Object.cd_filial			[lvl_Linha]
		lvl_Find	= dw_2.Find("cd_filial="+String(lvl_Filial), 1, dw_2.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = dw_2.InsertRow(0)
			dw_2.Object.cd_filial 		[lvl_Find] = lvl_Filial
			dw_2.Object.qt_clientes	[lvl_Find] = 0
		End If		
		lvl_Clientes	= dw_2.Object.qt_clientes [lvl_Find]
		dw_2.Object.qt_clientes	[lvl_Find] = lvl_Clientes + ivds_info_4.Object.qt_cliente	[lvl_Linha]
	Next
	
	//Deduzindo as devolu$$HEX2$$e700f500$$ENDHEX$$es das Vendas
	For lvl_Linha = 1 To ivds_info_2.RowCount()
		lvl_Filial		= ivds_info_2.Object.cd_filial			[lvl_Linha]
		lvs_Grupo	= ivds_info_2.Object.cd_grupo			[lvl_Linha]
		lvs_Lei_Gen	= ivds_info_2.Object.id_lei_generico	[lvl_Linha]
		lvl_Find = ivds_info.Find("cd_filial="+String(lvl_Filial)+" and cd_grupo='"+lvs_Grupo+"' and id_lei_generico='"+lvs_Lei_Gen+"'", 1, ivds_info.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = ivds_info.InsertRow(0)
			ivds_info.Object.cd_filial 		[lvl_Find] = lvl_Filial
			ivds_info.Object.vl_valor 		[lvl_Find] = 0.00
		End If
		lvdc_Venda	= ivds_info.Object.vl_valor	[lvl_Find]
		ivds_info.Object.vl_valor 		[lvl_Find] = lvdc_Venda - ivds_info_2.Object.vl_valor		[lvl_Linha]
	Next
	//Deduzindo as Vendas Disque Entrega das Vendas Normais
	For lvl_Linha = 1 To ivds_info.RowCount()
		lvl_Filial 		= ivds_info.Object.cd_filial 			[lvl_Linha]
		lvs_Grupo	= ivds_info.Object.cd_grupo			[lvl_Linha]
		lvs_Lei_Gen	= ivds_info.Object.id_lei_generico	[lvl_Linha]
		lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = ivds_info.InsertRow(0)
			dw_2.Object.cd_filial 		[lvl_Find] = lvl_Filial
		End If
		lvdc_Venda 	= dw_2.Object.vl_vendas	[lvl_Find]
		dw_2.Object.vl_vendas	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor		[lvl_Linha]
		Choose Case lvs_Grupo
			Case '1'
				Choose Case lvs_Lei_Gen
					Case 'G'
						lvdc_Venda 	= dw_2.Object.vl_genericos		[lvl_Find]
						dw_2.Object.vl_genericos	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
					Case 'R'
						lvdc_Venda 	= dw_2.Object.vl_referencia	[lvl_Find]
						dw_2.Object.vl_referencia	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
					Case 'S'
						lvdc_Venda 	= dw_2.Object.vl_similar			[lvl_Find]
						dw_2.Object.vl_similar		[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
					Case 'E'
						lvdc_Venda 	= dw_2.Object.vl_equivalente	[lvl_Find]
						dw_2.Object.vl_equivalente	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
				End Choose
			Case '2'
				lvdc_Venda 	= dw_2.Object.vl_popular [lvl_Find]
				dw_2.Object.vl_popular			[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
			Case '3'
				lvdc_Venda 	= dw_2.Object.vl_perfumaria	[lvl_Find]
				dw_2.Object.vl_perfumaria		[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
			Case '4'
				lvdc_Venda 	= dw_2.Object.vl_conveniencia	[lvl_Find]
				dw_2.Object.vl_conveniencia	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
			Case '6'
				lvdc_Venda 	= dw_2.Object.vl_manipulacao	[lvl_Find]
				dw_2.Object.vl_manipulacao	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
			Case Else
				lvdc_Venda 	= dw_2.Object.vl_diversos 		[lvl_Find]
				dw_2.Object.vl_diversos 			[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
		End Choose
	Next
	
	w_Aguarde.Title = 'Recuperando Vendas Farmagora...'
	lvl_Progresso ++
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
	/*Troca DS*/
	ivds_info.of_changedataobject('ds_ge125_farmagora_venda_grupo')
	ivds_info_2.of_changedataobject('ds_ge125_farmagora_devolucao_grupo')
	ivds_info_3.of_RestoreSqlOriginal( )
	ivds_info_3.of_appendwhere('nf.nr_pedido_ecommerce is not null')
	ivds_info_4.of_RestoreSqlOriginal( )
	ivds_info_4.of_appendwhere('v.nr_pedido_ecommerce is not null')
	
	/* Filtros */
	If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then
		ivds_info.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial))
		ivds_info_2.Of_AppendWhere('nf.cd_filial_venda='+String(lvl_Filtro_Filial))
		ivds_info_3.Of_AppendWhere('nf.cd_filial='+String(lvl_Filtro_Filial))
		ivds_info_4.Of_AppendWhere('nf.cd_filial_venda='+String(lvl_Filtro_Filial))
	ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then 
		ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
		ivds_info_2.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
		ivds_info_3.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
		ivds_info_4.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
	End If

	ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)
	ivds_info_2.Retrieve(lvdt_Inicio,lvdt_Fim)
	ivds_info_3.Retrieve(lvdt_Inicio,lvdt_Fim)
	ivds_info_4.Retrieve(lvdt_Inicio,lvdt_Fim)
	
	//Deduzindo as Clientes das Vendas Farmagora
	For lvl_Linha = 1 To ivds_info_3.RowCount()
		lvl_Filial	= ivds_info_3.Object.cd_filial			[lvl_Linha]
		lvl_Find = dw_2.Find("cd_filial="+String(lvl_Filial), 1, dw_2.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = dw_2.InsertRow(0)
			dw_2.Object.cd_filial 		[lvl_Find] = lvl_Filial
			dw_2.Object.qt_clientes	[lvl_Find] = 0
		End If		
		lvl_Clientes	= dw_2.Object.qt_clientes [lvl_Find]
		dw_2.Object.qt_clientes	[lvl_Find] = lvl_Clientes - ivds_info_3.Object.qt_cliente	[lvl_Linha]
	Next
	//Adicionando Clientes Devolu$$HEX2$$e700f500$$ENDHEX$$es das Vendas
	For lvl_Linha = 1 To ivds_info_4.RowCount()
		lvl_Filial	= ivds_info_4.Object.cd_filial			[lvl_Linha]
		lvl_Find	= dw_2.Find("cd_filial="+String(lvl_Filial), 1, dw_2.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = dw_2.InsertRow(0)
			dw_2.Object.cd_filial 		[lvl_Find] = lvl_Filial
			dw_2.Object.qt_clientes	[lvl_Find] = 0
		End If		
		lvl_Clientes	= dw_2.Object.qt_clientes [lvl_Find]
		dw_2.Object.qt_clientes	[lvl_Find] = lvl_Clientes + ivds_info_4.Object.qt_cliente	[lvl_Linha]
	Next
	
	//Deduzindo as devolu$$HEX2$$e700f500$$ENDHEX$$es das Vendas
	For lvl_Linha = 1 To ivds_info_2.RowCount()
		lvl_Filial		= ivds_info_2.Object.cd_filial			[lvl_Linha]
		lvs_Grupo	= ivds_info_2.Object.cd_grupo			[lvl_Linha]
		lvs_Lei_Gen	= ivds_info_2.Object.id_lei_generico	[lvl_Linha]
		lvl_Find = ivds_info.Find("cd_filial="+String(lvl_Filial)+" and cd_grupo='"+lvs_Grupo+"' and id_lei_generico='"+lvs_Lei_Gen+"'", 1, ivds_info.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = ivds_info.InsertRow(0)
			ivds_info.Object.cd_filial		[lvl_Find] = lvl_Filial
			ivds_info.Object.vl_valor		[lvl_Find] = 0.00
		End If
		lvdc_Venda = ivds_info.Object.vl_valor	[lvl_Find]
		ivds_info.Object.vl_valor		[lvl_Find] = lvdc_Venda - ivds_info_2.Object.vl_valor		[lvl_Linha]
	Next
	//Deduzindo as Vendas Disque Entrega das Vendas Normais
	For lvl_Linha = 1 To ivds_info.RowCount()
		lvl_Filial 		= ivds_info.Object.cd_filial 			[lvl_Linha]
		lvs_Grupo	= ivds_info.Object.cd_grupo			[lvl_Linha]
		lvs_Lei_Gen	= ivds_info.Object.id_lei_generico	[lvl_Linha]
		lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = ivds_info.InsertRow(0)
			dw_2.Object.cd_filial 		[lvl_Find] = lvl_Filial
		End If
		lvdc_Venda = dw_2.Object.vl_vendas		[lvl_Find]
		dw_2.Object.vl_vendas	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
		Choose Case lvs_Grupo
			Case '1'
				Choose Case lvs_Lei_Gen
					Case 'G'
						lvdc_Venda 	= dw_2.Object.vl_genericos		[lvl_Find]
						dw_2.Object.vl_genericos	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
					Case 'R'
						lvdc_Venda 	= dw_2.Object.vl_referencia	[lvl_Find]
						dw_2.Object.vl_referencia	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
					Case 'S'
						lvdc_Venda 	= dw_2.Object.vl_similar			[lvl_Find]
						dw_2.Object.vl_similar		[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
					Case 'E'
						lvdc_Venda 	= dw_2.Object.vl_equivalente	[lvl_Find]
						dw_2.Object.vl_equivalente	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
				End Choose
			Case '2'
				lvdc_Venda 	= dw_2.Object.vl_popular [lvl_Find]
				dw_2.Object.vl_popular			[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
			Case '3'
				lvdc_Venda 	= dw_2.Object.vl_perfumaria	[lvl_Find]
				dw_2.Object.vl_perfumaria		[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
			Case '4'
				lvdc_Venda 	= dw_2.Object.vl_conveniencia	[lvl_Find]
				dw_2.Object.vl_conveniencia	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
			Case '6'
				lvdc_Venda 	= dw_2.Object.vl_manipulacao	[lvl_Find]
				dw_2.Object.vl_manipulacao	[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
			Case Else
				lvdc_Venda 	= dw_2.Object.vl_diversos 		[lvl_Find]
				dw_2.Object.vl_diversos 			[lvl_Find] = lvdc_Venda - ivds_info.Object.vl_valor [lvl_Linha]
		End Choose
	Next
	Destroy(ivds_info_3)
	Destroy(ivds_info_4)
End If

w_Aguarde.Title = 'Recuperando Remanejamento Sa$$HEX1$$ed00$$ENDHEX$$da...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_remanejamento_saida')
/* Filtros */
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then
	ivds_info.Of_AppendWhere('n.cd_filial_origem='+String(lvl_Filtro_Filial))
ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then 
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
End If
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_remanej_sai [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
Next

w_Aguarde.Title = 'Recuperando Remanejamento Entrada...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_remanejamento_entrada')
/* Filtros */
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then
	ivds_info.Of_AppendWhere('n.cd_filial_destino='+String(lvl_Filtro_Filial))
ElseIf Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then 
	ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
End If
ivds_info.Retrieve(lvdt_Inicio,lvdt_fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	dw_2.Object.vl_remanej_ent [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
Next

// Vendas por Canal
w_Aguarde.Title = 'Recuperando Vendas por Canal...'
lvl_Progresso ++
w_Aguarde.uo_Progress.of_SetProgress(lvl_Progresso)
ivds_info.of_changedataobject('ds_ge125_venda_canal')
/* Filtros */
If Not IsNull(lvl_Regiao)and(lvl_Regiao > 0) Then ivds_info.Of_AppendWhere('fi.cd_regiao='+String(lvl_Regiao))
If Not IsNull(lvl_Filtro_Filial)and(lvl_Filtro_Filial > 0) Then ivds_info.Of_AppendWhere('r.cd_filial='+String(lvl_Filtro_Filial))
/* Recupera */
ivds_info.Retrieve(lvdt_Inicio,lvdt_Fim)

For lvl_Linha = 1 To ivds_info.RowCount()
	lvl_Filial = ivds_info.Object.cd_filial [lvl_Linha]
	lvl_Find = dw_2.Find('cd_filial='+String(lvl_Filial), 1, dw_2.RowCount())
	
	If Not(lvl_Find > 0) Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.cd_filial [lvl_Find] = lvl_Filial
	End If
	
	lvs_Canal = ivds_info.Object.Cd_Canal_Venda[lvl_Linha]
	
	Choose Case lvs_Canal
		Case "LF"
			dw_2.Object.vl_cv_lf [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
		Case "EC"
			dw_2.Object.vl_cv_ec [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
		Case "DE"
			dw_2.Object.vl_cv_de [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
		Case "IF"
			dw_2.Object.vl_cv_if [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
		Case "LI"
			dw_2.Object.vl_cv_li [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
		Case "AP"
			dw_2.Object.vl_cv_ap [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
		Case "VM"
			dw_2.Object.vl_cv_vm [lvl_Find] = ivds_info.Object.vl_valor [lvl_Linha]
	End Choose	
Next
// Fim Vendas por Canal

This.Sort()
This.of_SetRowSelection()
This.SetRedraw(True)

Close(w_Aguarde)
Destroy(ivds_info)
Destroy(ivds_info_2)

Return dw_2.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;cb_exportar.Enabled = (pl_Linhas > 0)
This.ivm_menu.mf_salvarcomo((pl_Linhas > 0))

If pl_Linhas > 0 then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()	
End If

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;cb_exportar.Enabled = False
This.ivm_menu.mf_salvarcomo(False)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Id_Alt_Preco

cb_exportar.Enabled = False
This.ivm_menu.mf_salvarcomo(False)

dw_1.AcceptText()

ls_Id_Alt_Preco = dw_1.Object.Id_Alt_Preco_Aberto[1]

If ls_Id_Alt_Preco = "S" Then
	If Not This.of_ChangeDataObject("dw_ge125_lista_aberto_alt_preco")   Then Return -1
Else
	If Not This.of_ChangeDataObject("dw_ge125_lista")   Then Return -1
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge125_consulta_dados_filial
integer x = 3109
integer y = 36
integer height = 196
end type

type cb_exportar from commandbutton within w_ge125_consulta_dados_filial
integer x = 2976
integer y = 180
integer width = 608
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Exportar Planilha"
end type

event clicked;Date lvdt_Referencia

String lvs_Arquivo

dw_1.AcceptText( )
lvdt_Referencia = dw_1.Object.dt_inicio[1]

lvs_Arquivo = gvo_aplicacao.ivs_path_arquivos + 'Informa$$HEX2$$e700f500$$ENDHEX$$es_Filiais_'+gf_mes_extenso(Month(lvdt_Referencia))+'.'+String(lvdt_Referencia,'yyyy')+'.XLS'

dw_2.of_exporta_excel(lvs_Arquivo)
end event

