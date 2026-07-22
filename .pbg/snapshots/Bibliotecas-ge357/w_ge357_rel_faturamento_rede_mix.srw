HA$PBExportHeader$w_ge357_rel_faturamento_rede_mix.srw
forward
global type w_ge357_rel_faturamento_rede_mix from dc_w_selecao_lista_relatorio
end type
type cb_exp_fat_farmagora from commandbutton within w_ge357_rel_faturamento_rede_mix
end type
end forward

global type w_ge357_rel_faturamento_rede_mix from dc_w_selecao_lista_relatorio
integer width = 2679
integer height = 1552
string title = "GE357 - Relat$$HEX1$$f300$$ENDHEX$$rio de Faturamento por Rede e Grupo de Produto"
cb_exp_fat_farmagora cb_exp_fat_farmagora
end type
global w_ge357_rel_faturamento_rede_mix w_ge357_rel_faturamento_rede_mix

type variables
dc_uo_ds_base ivds_venda
dc_uo_ds_base ivds_venda_fa
dc_uo_ds_base ivds_devol_fa
end variables

forward prototypes
public function string wf_retorna_descricao_rede (ref string ps_id_rede)
public function boolean wf_atualiza_informacoes (long pl_ano, datetime pdh_inicio, datetime pdh_fim)
end prototypes

public function string wf_retorna_descricao_rede (ref string ps_id_rede);String lvs_Retorno

Choose Case ps_id_rede
	Case "AL", "PP"
		ps_id_rede = "PP"
		lvs_Retorno = "PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
	Case "CD", "CP", "DC"
		ps_id_rede = "DC"
		lvs_Retorno = "DROGARIA CATARINENSE"
	Case "FA"
		lvs_Retorno = "FARMAGORA"
	Case "MP", "PF"
		ps_id_rede = "MP"
		lvs_Retorno = "MANIPULA$$HEX2$$c700c300$$ENDHEX$$O"
	Case Else
		lvs_Retorno = "DESCONHECIDO"
End Choose

Return lvs_Retorno
		
end function

public function boolean wf_atualiza_informacoes (long pl_ano, datetime pdh_inicio, datetime pdh_fim);Long lvl_Linhas
Long lvl_Linha
Long lvl_Find

String lvs_Cd_Grupo
String lvs_De_Grupo
String lvs_Id_Lei_G
String lvs_De_Lei_G
String lvs_ID_Rede
String lvs_Rede
Decimal{2} lvdc_Venda
Decimal{2} lvdc_Devol
Decimal{2} lvdc_Aux

Datetime lvdh_Historico

dw_1.Accepttext( )
lvdh_Historico = dw_1.Object.dh_fim [1]

Open(w_aguarde)
/* Recuperando Informa$$HEX2$$e700f500$$ENDHEX$$es */
w_aguarde.Title = "Recuperando vendas per$$HEX1$$ed00$$ENDHEX$$odo "+String(pdh_inicio,"DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(pdh_Fim,"DD/MM/YYYY")+"..."
lvl_Linhas = ivds_venda.Retrieve(pdh_inicio,pdh_fim, lvdh_Historico)
w_aguarde.Title = "Recuperando vendas Farmagora per$$HEX1$$ed00$$ENDHEX$$odo "+String(pdh_inicio,"DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(pdh_Fim,"DD/MM/YYYY")+"..."
lvl_Linhas = ivds_venda_fa.Retrieve(pdh_inicio,pdh_Fim, lvdh_Historico)
w_aguarde.Title = "Recuperando devolu$$HEX2$$e700f500$$ENDHEX$$es Farmagora per$$HEX1$$ed00$$ENDHEX$$odo "+String(pdh_inicio,"DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(pdh_Fim,"DD/MM/YYYY")+"..."
lvl_Linhas = ivds_devol_fa.Retrieve(pdh_inicio,pdh_Fim, lvdh_Historico)

/* Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es */
lvl_Linhas = ivds_venda.RowCount()
w_aguarde.uo_progress.Of_SetMax(lvl_Linhas)
For lvl_Linha = 1 To lvl_Linhas
	lvs_Cd_Grupo	=	ivds_venda.Object.cd_grupo 		[lvl_Linha]
	lvs_De_Grupo	=	ivds_venda.Object.de_grupo 		[lvl_Linha]
	lvs_Id_Lei_G		=	ivds_venda.Object.id_lei_generico [lvl_Linha]
	lvs_De_Lei_G	=	ivds_venda.Object.de_lei_generico[lvl_Linha]
	lvdc_Venda		=	ivds_venda.Object.vl_venda		 	[lvl_Linha]
	lvs_ID_Rede		=	ivds_venda.Object.id_rede_filial 	[lvl_Linha]
	lvs_Rede			=  wf_retorna_descricao_rede(ref lvs_ID_Rede)
	
	lvl_Find = dw_2.Find("id_tipo_faturamento='"+lvs_Cd_Grupo+"' and id_rede_filial='"+lvs_ID_Rede+"' and id_lei_generico='"+lvs_Id_Lei_G+"'",1,dw_2.RowCount())
	If Not lvl_Find > 0 Then
		lvl_Find = dw_2.InsertRow(0)
		dw_2.Object.id_tipo_faturamento 	[lvl_Find] = lvs_Cd_Grupo
		dw_2.Object.de_tipo_faturamento	[lvl_Find] = lvs_De_Grupo+' '+IIF(lvs_Cd_Grupo="1", lvs_De_Lei_G, "")
		dw_2.Object.id_lei_generico		[lvl_Find] = lvs_Id_Lei_G
		dw_2.Object.id_medicamento		[lvl_Find] = IIF(lvs_Cd_Grupo="1","S","N")
		dw_2.Object.de_rede_filial			[lvl_Find] = lvs_Rede
		dw_2.Object.id_rede_filial			[lvl_Find] = lvs_ID_Rede
		dw_2.Object.vl_ano1					[lvl_Find] = 0.00
		dw_2.Object.vl_ano2					[lvl_Find] = 0.00
	End If
	
	If pl_ano = 1 Then
		lvdc_Aux = dw_2.Object.vl_ano1 [lvl_Find]
		lvdc_Aux += lvdc_Venda
		dw_2.Object.vl_ano1 [lvl_Find] = lvdc_Aux
	Else
		lvdc_Aux = dw_2.Object.vl_ano2 [lvl_Find]
		lvdc_Aux += lvdc_Venda
		dw_2.Object.vl_ano2 [lvl_Find] = lvdc_Aux
	End If
	
	w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)
Next

/*Deduzir devolu$$HEX2$$e700f500$$ENDHEX$$es Farmagora das vendas Farmagora*/
lvl_Linhas = ivds_devol_fa.RowCount()
w_aguarde.uo_progress.Of_SetMax(lvl_Linhas)
w_aguarde.Title = "Deduzindo devolu$$HEX2$$e700f500$$ENDHEX$$es das vendas Farmagora..."
For lvl_Linha = 1 To lvl_Linhas
	lvs_Cd_Grupo	=	ivds_devol_fa.Object.cd_grupo 			[lvl_Linha]
	lvs_Id_Lei_G		=	ivds_devol_fa.Object.id_lei_generico	[lvl_Linha]
	lvdc_Devol		=	ivds_devol_fa.Object.vl_devolucao	 	[lvl_Linha]
	lvs_ID_Rede		=	ivds_devol_fa.Object.id_rede_filial 	[lvl_Linha]
	
	lvl_Find = ivds_venda_fa.Find("cd_grupo='"+lvs_Cd_Grupo+"' and id_rede_filial='"+lvs_ID_Rede+"' and id_lei_generico='"+lvs_Id_Lei_G+"'",1,ivds_venda_fa.RowCount())
	If Not lvl_Find > 0 Then
		lvl_Find = ivds_venda_fa.InsertRow(0)
		ivds_venda_fa.Object.cd_grupo 			[lvl_Find] = lvs_Cd_Grupo
		ivds_venda_fa.Object.id_rede_filial		[lvl_Find] = lvs_ID_Rede
		ivds_venda_fa.Object.id_lei_generico		[lvl_Find] = lvs_Id_Lei_G
		ivds_venda_fa.Object.vl_venda				[lvl_Find] = 0.00 - lvdc_Devol
	Else
		lvdc_Aux = ivds_venda_fa.Object.vl_venda	[lvl_Find]
		ivds_venda_fa.Object.vl_venda				[lvl_Find] = lvdc_Aux - lvdc_Devol		
	End If
	
	w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)
Next


/* Transportar vendas Farmagora em DCs para FA */
lvl_Linhas = ivds_venda_fa.RowCount()
w_aguarde.uo_progress.Of_SetMax(lvl_Linhas)
w_aguarde.Title = "Transportando vendas Farmagora..."
For lvl_Linha = 1 To lvl_Linhas
	lvs_Cd_Grupo	=	ivds_venda_fa.Object.cd_grupo 		[lvl_Linha]
	lvs_Id_Lei_G		=	ivds_venda_fa.Object.id_lei_generico	[lvl_Linha]
	lvdc_Venda		=	ivds_venda_fa.Object.vl_venda			[lvl_Linha]
	lvs_ID_Rede		=	ivds_venda_fa.Object.id_rede_filial 	[lvl_Linha]
	
	lvl_Find = dw_2.Find("id_tipo_faturamento='"+lvs_Cd_Grupo+"' and id_rede_filial='"+lvs_ID_Rede+"' and id_lei_generico='"+lvs_Id_Lei_G+"'",1,dw_2.RowCount())
	If pl_ano = 1 Then
		lvdc_Aux = dw_2.Object.vl_ano1 [lvl_Find]
		dw_2.Object.vl_ano1 [lvl_Find] = lvdc_Aux - lvdc_Venda
	Else
		lvdc_Aux = dw_2.Object.vl_ano2	[lvl_Find]
		dw_2.Object.vl_ano2 [lvl_Find] = lvdc_Aux - lvdc_Venda	
	End If

	lvl_Find = dw_2.Find("id_tipo_faturamento='"+lvs_Cd_Grupo+"' and id_rede_filial='FA' and id_lei_generico='"+lvs_Id_Lei_G+"'",1,dw_2.RowCount())
	If pl_ano = 1 Then
		lvdc_Aux = dw_2.Object.vl_ano1 [lvl_Find]
		dw_2.Object.vl_ano1 [lvl_Find] = lvdc_Aux + lvdc_Venda
	Else
		lvdc_Aux = dw_2.Object.vl_ano2	[lvl_Find]
		dw_2.Object.vl_ano2 [lvl_Find] = lvdc_Aux + lvdc_Venda	
	End If
	
	w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)
Next

Close(w_aguarde)

Return True
end function

on w_ge357_rel_faturamento_rede_mix.create
int iCurrent
call super::create
this.cb_exp_fat_farmagora=create cb_exp_fat_farmagora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exp_fat_farmagora
end on

on w_ge357_rel_faturamento_rede_mix.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_exp_fat_farmagora)
end on

event ue_preopen;call super::ue_preopen;ivds_venda		= Create dc_uo_ds_base
ivds_venda_fa	= Create dc_uo_ds_base
ivds_devol_fa 	= Create dc_uo_ds_base

ivds_venda.Of_changedataobject("ds_ge357_fat_rede_grupo")
ivds_venda_fa.Of_changedataobject("ds_ge357_fat_rede_grupo_fa")
ivds_devol_fa.Of_changedataobject("ds_ge357_dev_rede_grupo_fa")

Maxheight = 2820

This.ivm_menu.ivb_permite_imprimir = True
end event

event close;call super::close;Destroy(ivds_venda)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_inicio	[1] = gf_primeiro_dia_mes(RelativeDate(gf_primeiro_dia_mes(Today()),-1))
dw_1.Object.dh_fim		[1] = gf_primeiro_dia_mes(RelativeDate(gf_primeiro_dia_mes(Today()),-1))

end event

event ue_print;//override
dw_2.Event ue_imprimir_relatorio("Relat$$HEX1$$f300$$ENDHEX$$rio de Faturamento por Rede e Mix", "CL", False)
end event

event ue_printimmediate;//override
dw_2.Event ue_imprimir_relatorio("Relat$$HEX1$$f300$$ENDHEX$$rio de Faturamento por Rede e Mix", "CL", True)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge357_rel_faturamento_rede_mix
integer x = 238
integer y = 2940
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge357_rel_faturamento_rede_mix
integer x = 201
integer y = 2868
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge357_rel_faturamento_rede_mix
integer y = 212
integer width = 2569
integer height = 1128
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge357_rel_faturamento_rede_mix
integer width = 1015
integer height = 184
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge357_rel_faturamento_rede_mix
integer width = 951
integer height = 92
string dataobject = "dw_ge357_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge357_rel_faturamento_rede_mix
integer y = 288
integer width = 2501
integer height = 1020
string dataobject = "dw_ge357_lista"
end type

event dw_2::ue_recuperar;//override
Datetime lvdh_Inicio
Datetime lvdh_Fim

Open(w_aguarde)
This.SetRedraw(False)

dw_1.AcceptText( )
lvdh_Inicio	= dw_1.Object.dh_inicio	[1]
lvdh_Fim		= dw_1.Object.dh_fim	[1]
lvdh_Fim		= Datetime(gf_retorna_ultimo_dia_mes(Date(lvdh_Fim)))

This.ivs_filtro_relatorio[ UpperBound(This.ivs_filtro_relatorio) +1 ] = 'Classifica$$HEX2$$e700e300$$ENDHEX$$o Produtos: '+String(lvdh_Fim,'MM/YYYY')
This.ivs_filtro_relatorio[ UpperBound(This.ivs_filtro_relatorio) +1 ] = 'Per$$HEX1$$ed00$$ENDHEX$$odo 2: '+String(lvdh_Inicio,'MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdh_Fim,'MM/YYYY')
wf_atualiza_informacoes(2,lvdh_Inicio,lvdh_Fim)

lvdh_Inicio	= Datetime(String(lvdh_Inicio,'DD/MM')+'/'+String(Year(Date(lvdh_Inicio))-1))
lvdh_Fim		= Datetime(String(lvdh_Fim,'DD/MM')+'/'+String(Year(Date(lvdh_Fim))-1))
lvdh_Fim		= Datetime(gf_retorna_ultimo_dia_mes(Date(lvdh_Fim)))
This.ivs_filtro_relatorio[ UpperBound(This.ivs_filtro_relatorio) +1 ] = 'Per$$HEX1$$ed00$$ENDHEX$$odo 1: '+String(lvdh_Inicio,'MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdh_Fim,'MM/YYYY')
wf_atualiza_informacoes(1,lvdh_Inicio,lvdh_Fim)

This.Sort()
This.Groupcalc( )
This.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_1.AcceptText( )
lvdh_Inicio	= dw_1.Object.dh_inicio	[1]
lvdh_Fim		= dw_1.Object.dh_fim	[1]

If Month(Date(lvdh_Fim)) >= Month(Today()) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe uma data final anterior ao m$$HEX1$$ea00$$ENDHEX$$s atual.',Exclamation!)
	Return -1
End If

This.Event ue_Reset()

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_salvarcomo( pl_linhas > 0 )

cb_exp_fat_farmagora.Enabled = ( pl_linhas > 0 )

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_salvarcomo( False )
cb_exp_fat_farmagora.Enabled = False
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge357_rel_faturamento_rede_mix
integer x = 3703
integer y = 188
end type

type cb_exp_fat_farmagora from commandbutton within w_ge357_rel_faturamento_rede_mix
integer x = 1079
integer y = 104
integer width = 1061
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Exportar Fat. Transportado Farmagora"
end type

event clicked;ivds_venda_fa.Of_Saveas("")
end event

