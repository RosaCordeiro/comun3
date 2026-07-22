HA$PBExportHeader$w_ge625_rel_dinamico_transf_x_origem.srw
forward
global type w_ge625_rel_dinamico_transf_x_origem from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge625_rel_dinamico_transf_x_origem from dc_w_selecao_lista_dinamica_relatorio
integer width = 4233
integer height = 2036
string title = "GE625 - Relat$$HEX1$$f300$$ENDHEX$$rio de Din$$HEX1$$e200$$ENDHEX$$mico de Transfer$$HEX1$$ea00$$ENDHEX$$ncias x Origem (entrada)"
end type
global w_ge625_rel_dinamico_transf_x_origem w_ge625_rel_dinamico_transf_x_origem

type variables
uo_filial ivo_filial_orig
uo_filial ivo_filial_dest
uo_natureza_operacao ivo_cfop
uo_produto ivo_produto

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Grupo Produto*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")

dw_1.Object.cd_grupo[1] = "0"

/*Subgrupo Produto*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_subgrupo" )			

ldwc_Child.SetItem(1, "cd_subgrupo", "0")
ldwc_Child.SetItem(1, "de_subgrupo", "TODOS")
ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.SetFilter("cd_grupo='0'")
ldwc_Child.Filter()
dw_1.Object.cd_subgrupo[1] = "0"

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", "TD")
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")

dw_1.Object.id_lei_generico[1] = "TD"

/*UF Origem*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf[1] = "TD"


/*UF Destino */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf_dest" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf_dest[1] = "TD"
end subroutine

on w_ge625_rel_dinamico_transf_x_origem.create
call super::create
end on

on w_ge625_rel_dinamico_transf_x_origem.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_filial_orig	= Create uo_filial
ivo_filial_dest	= Create uo_filial
ivo_cfop				= Create uo_natureza_operacao
ivo_produto			= Create uo_produto

//Dimensionamento de tela
MaxWidth = 4900
MaxHeight = 9999

//SQL Base para formar o grid
ivs_SQLBase = 	'from nf_transferencia nt (index idx_data_filial_origem) ~r~n' + &
					'inner join item_nf_transferencia int (index pk_item_nf_transferencia)  ~r~n' + &
					'	on int.cd_filial_origem = nt.cd_filial_origem ~r~n' + &
					'	and int.nr_nf = nt.nr_nf ~r~n' + &
					'	and int.de_especie = nt.de_especie ~r~n' + &
					'	and int.de_serie = nt.de_serie ~r~n' + &
					'inner join nf_transferencia_nfe nte (index pk_nf_transferencia_nfe) ~r~n' + &
					'	on nte.cd_filial_origem = nt.cd_filial_origem+0 ~r~n' + &
					'	and nte.nr_nf = nt.nr_nf+0 ~r~n' + &
					'	and nte.de_especie = nt.de_especie ~r~n' + &
					'	and nte.de_serie = nt.de_serie ~r~n' + &
					'inner join movimento_produto_tributacao mpt (index idx_nota_forn) ~r~n' + &
					'	on mpt.cd_filial_movimento = int.cd_filial_origem ~r~n' + &
					'	and mpt.nr_nf = int.nr_nf ~r~n' + &
					'	and mpt.de_especie = int.de_especie ~r~n' + &
					'	and mpt.de_serie = int.de_serie ~r~n' + &
					'	and mpt.cd_produto = int.cd_produto ~r~n' + &
					'	and mpt.cd_tipo_movimento = 6 ~r~n' + &
					'inner join produto_geral pg (index pk_produto_geral) ~r~n' + &
					'	on pg.cd_produto = mpt.cd_produto ~r~n' + &
					'inner join filial filo (index pk_filial) ~r~n' + &
					'	on filo.cd_filial = nt.cd_filial_origem ~r~n' + &
					'inner join cidade cido (index pk_cidade) ~r~n' + &
					'	on cido.cd_cidade = filo.cd_cidade ~r~n' + &
					'inner join filial fild (index pk_filial) ~r~n' + &
					'	on fild.cd_filial = nt.cd_filial_destino ~r~n' + &
					'inner join cidade cidd (index pk_cidade) ~r~n' + &
					'	on cidd.cd_cidade = fild.cd_cidade ~r~n' + &
					'left outer join movimento_produto_tributacao mpto (index pk_movimento_produto_tributaca) ~r~n' + &
					'	on mpto.cd_filial_movimento = mpt.cd_filial_movimento+0 ~r~n' + &
					'	and mpto.dh_movimento = mpt.dh_movimento_origem ~r~n' + &
					'	and mpto.cd_produto = mpt.cd_produto+0 ~r~n' + &
					'	and mpto.nr_movimento = mpt.nr_movimento_origem ~r~n' + &
					'	and mpto.cd_tipo_movimento in (3,5) ~r~n' + &
					'left outer join item_nf_compra inco (index pk_item_nf_compra) ~r~n' + &
					'	on inco.cd_filial = mpto.cd_filial_movimento ~r~n' + &
					'	and inco.cd_fornecedor = mpto.cd_fornecedor ~r~n' + &
					'	and inco.nr_nf = mpto.nr_nf ~r~n' + &
					'	and inco.de_especie = mpto.de_especie ~r~n' + &
					'	and inco.de_serie = mpto.de_serie ~r~n' + &
					'	and inco.cd_produto = mpto.cd_produto ~r~n' + &
					'	and mpto.cd_tipo_movimento=3 ~r~n' + &
					'left outer join nf_compra nco (index pk_nf_compra) ~r~n' + &
					'	on nco.cd_filial = inco.cd_filial+0 ~r~n' + &
					'	and nco.cd_fornecedor = inco.cd_fornecedor ~r~n' + &
					'	and nco.nr_nf = inco.nr_nf+0 ~r~n' + &
					'	and nco.de_especie = inco.de_especie ~r~n' + &
					'	and nco.de_serie = inco.de_serie ~r~n' + &
					'	and mpto.cd_tipo_movimento=3 ~r~n' + &
					'left outer join item_nf_transferencia itor (index pk_item_nf_transferencia) ~r~n' + &
					'	on itor.cd_filial_origem = mpto.cd_filial+0 ~r~n' + &
					'	and itor.nr_nf = mpto.nr_nf+0 ~r~n' + &
					'	and itor.de_especie = mpto.de_especie ~r~n' + &
					'	and itor.de_serie = mpto.de_serie ~r~n' + &
					'	and itor.cd_produto = mpto.cd_produto ~r~n' + &
					'	and mpto.cd_tipo_movimento=5 ~r~n' + &
					'left outer join nf_transferencia_nfe nto (index nf_transferencia_nfe) ~r~n' + &
					'	on nto.cd_filial_origem = itor.cd_filial_origem+0 ~r~n' + &
					'	and nto.nr_nf = itor.nr_nf+0 ~r~n' + &
					'	and nto.de_especie = itor.de_especie ~r~n' + &
					'	and nto.de_serie = itor.de_serie ~r~n' + &
					'	and mpto.cd_tipo_movimento=5 ~r~n' + &
					'left outer join integracao_sap isf (index pk_integracao_sap) ~r~n' + &
					'	on isf.cd_empresa = 1000 ~r~n' + &
					"	and isf.cd_tabela = upper('FILIAL') ~r~n"+&
					'	and isf.cd_chave_legado = cast(fild.cd_filial as varchar) ~r~n'	+ &
					'left outer join produto_uf pu (index pk_produto_uf) ~r~n'				+ &
					'	on pu.cd_produto					= mpt.cd_produto+0 ~r~n'				+ &
					"	and pu.cd_unidade_federacao	= cidd.cd_unidade_federacao||'' ~r~n"	+ &
					'left outer join historico_produto hp	(index pk_historico_produto) ~r~n'+ &
					'	on hp.cd_produto					= mpt.cd_produto+0 ~r~n'					+ &
					'	and hp.dh_historico				= dbo.primeiro_dia_mes(mpt.dh_movimento) ~r~n'	+ &
					'left outer join historico_produto_uf hpu (index pk_historico_produto_uf) ~r~n'				+ &
					'	on hpu.cd_produto					= hp.cd_produto+0 ~r~n'					+ &
					"	and hpu.cd_unidade_federacao 	= pu.cd_unidade_federacao||'' ~r~n"	+ &
					'	and hpu.dh_historico				= hp.dh_historico ~r~n'					+ &
					'Where 1 = 1 ~r~n' 

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 31
end event

event close;call super::close;Destroy(ivo_filial_orig)
Destroy(ivo_filial_dest)
Destroy(ivo_cfop)
Destroy(ivo_produto)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim		[1] = RelativeDate(Today(),-1)

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge625_rel_dinamico_transf_x_origem
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge625_rel_dinamico_transf_x_origem
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge625_rel_dinamico_transf_x_origem
integer y = 588
integer width = 4137
integer height = 1236
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge625_rel_dinamico_transf_x_origem
integer width = 4128
integer height = 536
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge625_rel_dinamico_transf_x_origem
integer width = 4059
integer height = 448
string dataobject = "dw_ge625_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial_orig.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial_orig.Localizada Then
				  
				This.Object.cd_filial	[1] = ivo_filial_orig.cd_filial
				This.Object.nm_filial	[1] = ivo_filial_orig.nm_fantasia
				
			End If
			
		Case "nm_filial_dest"
			ivo_filial_dest.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial_dest.Localizada Then
				  
				This.Object.cd_filial_dest		[1] = ivo_filial_dest.cd_filial
				This.Object.nm_filial_dest		[1] = ivo_filial_dest.nm_fantasia
				
			End If
			
		Case "nm_cfop"
			ivo_cfop.of_localiza_natureza(This.GetText())
			
			If ivo_cfop.Localizado Then
				  
				This.Object.cd_cfop		[1] = ivo_cfop.cd_natureza_operacao
				This.Object.nm_cfop	[1] = ivo_cfop.de_natureza_operacao
				
			End If
			
		Case "de_produto"
			ivo_produto.of_localiza_produto(This.GetText())
			
			If ivo_produto.Localizado Then
				  
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
				
			End If

	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;DataWindowChild ldw_Child

Choose Case dwo.Name
	Case "cd_grupo"
		If Data <> '1' Then This.Object.id_lei_generico [Row] = 'TD'
	
		If This.GetChild("cd_subgrupo", ldw_Child) = 1 Then
			ldw_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+Data+"')")
			ldw_Child.Filter()
			This.Object.cd_subgrupo [Row] = '0'
		End If
		
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial_Orig.nm_fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial_Orig.Of_Inicializa()
			
			This.Object.nm_filial	[1] = ivo_Filial_Orig.nm_fantasia
			This.Object.cd_filial	[1] = ivo_Filial_Orig.cd_filial
			
		End If	
		
	Case "nm_filial_dest"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial_Dest.nm_fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial_Dest.Of_Inicializa()
			
			This.Object.nm_filial_dest	[1] = ivo_Filial_Dest.nm_fantasia
			This.Object.cd_filial_dest	[1] = ivo_Filial_Dest.cd_filial
			
		End If	
		
	Case "nm_cfop"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cfop.de_natureza_operacao Then
				Return 1
			End If	
		Else			
			ivo_cfop.Of_Inicializa()
			
			This.Object.nm_cfop	[1] = ivo_cfop.de_natureza_operacao
			This.Object.cd_cfop		[1] = ivo_cfop.cd_natureza_operacao
			
		End If	
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> (ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque) Then
				Return 1
			End If	
		Else			
			ivo_produto.Of_Inicializa()
			
			This.Object.de_produto	[1] = ivo_produto.de_produto
			This.Object.cd_produto	[1] = ivo_produto.cd_produto
			
		End If	

End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial_Orig) Then 
	This.Object.Nm_Filial[1] = ivo_Filial_Orig.Nm_Fantasia
End If

If IsValid(ivo_Filial_Dest) Then 
	This.Object.Nm_Filial_dest [1] = ivo_Filial_Dest.Nm_Fantasia
End If

If IsValid(ivo_produto) Then 
	If ivo_produto.Localizado Then	This.Object.de_produto [1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
End If

If IsValid(ivo_cfop) Then 
	This.Object.nm_cfop [1] = ivo_cfop.de_natureza_operacao
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge625_rel_dinamico_transf_x_origem
integer y = 664
integer width = 4069
integer height = 1128
string title = "Rel. Din$$HEX1$$e200$$ENDHEX$$mico de Transfer$$HEX1$$ea00$$ENDHEX$$ncias x Entradas"
string icon = "AppIcon!"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo
String lvs_Subgrupo
String lvs_UF_Fil
String lvs_UF_Dest
String lvs_Lei_Gen
String lvs_Lista_Pis
String lvs_Tipo
String lvs_NCM_Ini
String lvs_NCM_Fim
String lvs_Serie
String lvs_Situacao
String lvs_SQL

Long lvl_NCM_Ini
Long lvl_NCM_Fim
Long lvl_NF
Long lvl_CFOP
Long lvl_Filial_Orig
Long lvl_Filial_Dest
Long lvl_Produto

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio			= dw_1.Object.dt_inicio				[1]
lvdt_Fim				= dw_1.Object.dt_fim					[1]
lvl_Filial_Orig	= dw_1.Object.cd_filial				[1]
lvl_Filial_Dest	= dw_1.Object.cd_filial_dest		[1]
lvs_UF_Fil			= dw_1.Object.cd_uf					[1]
lvs_UF_Dest			= dw_1.Object.cd_uf_dest			[1]
lvl_Produto			= dw_1.Object.cd_produto			[1]
lvs_Situacao		= dw_1.Object.id_situacao			[1]
lvs_Tipo				= dw_1.Object.id_tipo				[1]
lvl_CFOP				= dw_1.Object.cd_cfop				[1]
lvs_Grupo			= dw_1.Object.cd_grupo				[1]
lvs_Subgrupo		= dw_1.Object.cd_subgrupo			[1]
lvl_NCM_Ini			= dw_1.Object.nr_ncm_ini			[1]
lvl_NCM_Fim			= dw_1.Object.nr_ncm_fim			[1]
lvs_Lista_Pis		= dw_1.Object.id_lista_pis_cofins[1]
lvs_Lei_Gen			= dw_1.Object.id_lei_generico		[1]
lvl_NF				= dw_1.Object.nr_nf					[1]
lvs_Serie			= dw_1.Object.de_serie				[1]

If IsNull(lvdt_Inicio) or (lvdt_Inicio < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data inicial para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
Else
	This.Of_AppendWhere("nt.dh_movimentacao_caixa>='"+String(lvdt_Inicio,'YYYY/MM/DD')+"'")
	This.Of_AppendWhere("mpt.dh_movimento>='"+String(lvdt_Inicio,'YYYY/MM/DD')+"'")
End If

If IsNull(lvdt_Fim) or (lvdt_Fim < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data final para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_fim')
	Return -1
Else
	This.Of_AppendWhere("nt.dh_movimentacao_caixa<='"+String(lvdt_Fim,'YYYY/MM/DD')+"'")
	This.Of_AppendWhere("mpt.dh_movimento<='"+String(lvdt_Fim,'YYYY/MM/DD')+"'")
End If

This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'DD/MM/YYYY')

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	This.Of_AppendWhere("mpt.cd_produto="+String(lvl_Produto))
	This.Of_AppendWhere("pg.cd_produto="+String(lvl_Produto))
//
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Produto: '+ivo_produto.de_produto+' ('+String(lvl_Produto)+')'
	
	//Altera o $$HEX1$$ed00$$ENDHEX$$ndice para buscar primeiro na movimento_produto_tributacao, onde tem produto e data
	lvs_SQL = This.GetSQLSelect()
	lvs_SQL = gf_replace(lvs_SQL,'index idx_nota_forn','index pk_movimento_produto_tributaca',0)
	lvs_SQL = gf_replace(lvs_SQL,'idx_data_filial_origem','pk_nf_transferencia',0)
	This.SetSQLSelect(lvs_SQL)
End If

If Not IsNull(lvl_Filial_Orig) and (lvl_Filial_Orig > 0) Then
	This.Of_AppendWhere("nt.cd_filial_origem="+String(lvl_Filial_Orig))
	This.Of_AppendWhere("mpt.cd_filial_movimento="+String(lvl_Filial_Orig))
	This.Of_AppendWhere("filo.cd_filial="+String(lvl_Filial_Orig))
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Filial Origem: '+ivo_filial_orig.nm_fantasia+' ('+String(lvl_Filial_Orig)+')'
ElseIf IsNull(lvl_Filial_Dest) or (lvl_Filial_Dest <= 0) Then
	This.Of_AppendWhere("nt.cd_filial_origem > 0")
	This.Of_AppendWhere("mpt.cd_filial_movimento > 0")
	This.Of_AppendWhere("filo.cd_filial > 0")
End If

If Not IsNull(lvl_Filial_Dest) and (lvl_Filial_Dest > 0) Then
	If lvl_Filial_Dest = 534 Then
		This.Of_AppendWhere("nt.cd_filial_destino in (1,"+String(lvl_Filial_Dest)+")")
		This.Of_AppendWhere("mpt.cd_filial in (1,"+String(lvl_Filial_Dest)+")")
		This.Of_AppendWhere("fild.cd_filial in (1,"+String(lvl_Filial_Dest)+")")
	Else
		This.Of_AppendWhere("nt.cd_filial_destino="+String(lvl_Filial_Dest))
		This.Of_AppendWhere("mpt.cd_filial="+String(lvl_Filial_Dest))
		This.Of_AppendWhere("fild.cd_filial="+String(lvl_Filial_Dest))
	End If
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Filial Destino: '+ivo_filial_dest.nm_fantasia+' ('+String(lvl_Filial_Dest)+')'
	
	If lvl_Filial_Dest <> 534 or IsNull(lvl_Filial_Orig) Then
		lvs_SQL = This.GetSQLSelect()
		lvs_SQL = gf_replace(lvs_SQL,'idx_data_filial_origem','idx_data_filial_destino',0)
		This.SetSQLSelect(lvs_SQL)
	End If
End If

If lvs_UF_Fil<>'TD' Then
	This.Of_AppendWhere("cido.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'UF Origem: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If lvs_UF_Dest<>'TD' Then
	This.Of_AppendWhere("cidd.cd_unidade_federacao='"+lvs_UF_Dest+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf_dest)',1)")+' ('+lvs_UF_Dest+')'
	
	If IsNull(lvl_Filial_Dest) or IsNull(lvl_Filial_Orig) Then
		lvs_SQL = This.GetSQLSelect()
		lvs_SQL = gf_replace(lvs_SQL,'idx_data_filial_origem','idx_data_filial_destino',0)
		This.SetSQLSelect(lvs_SQL)
	End If
End If

Choose Case lvs_Tipo
	Case 'AX'
		This.Of_AppendWhere("nt.id_almoxarifado='S'")
	Case 'EF'
		This.Of_AppendWhere("nt.cd_filial_destino not in (1,534)")
		This.Of_AppendWhere("nt.cd_filial_origem not in (1,534)")
		This.Of_AppendWhere("mpt.cd_filial_movimento not in (1,534)")
		This.Of_AppendWhere("mpt.cd_filial not in (1,534)")
	Case 'EC'
		This.Of_AppendWhere("( (nt.cd_filial_origem in (1,534)) or (nt.cd_filial_destino in (1,534)) )")
		This.Of_AppendWhere("( (mpt.cd_filial_movimento in (1,534)) or (mpt.cd_filial in (1,534)) )")
	Case 'MC'
		This.Of_AppendWhere("coalesce(nt.id_almoxarifado,'N')<>'S'")
	Case 'PV'
		This.Of_AppendWhere("coalesce(nt.id_produto_vencido,'N')='S'")
	Case 'RM'
		This.Of_AppendWhere("exists (select 1 from remanejamento_resultado rr1 (index idx_remanej_resultado_nf) "+ &
												" where rr1.cd_filial_origem = nt.cd_filial_origem 	and " + &
												" rr1.nr_nf = nt.nr_nf								and  " + &
												" rr1.de_especie = nt.de_especie 				and  " + &
												" rr1.de_serie = nt.de_serie)")
	Case 'RE'
		This.Of_AppendWhere("nt.nr_retirada_estoque is not null")
End Choose
This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Tipo: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo)',1)")

Choose Case lvs_Situacao
	Case "CA"
		This.of_AppendWhere(" nt.dh_cancelamento is not null")
	Case "NO"
		This.of_AppendWhere(" nt.dh_cancelamento is null")
End Choose

If Not IsNull(lvl_CFOP) and (lvl_CFOP > 0) Then
	This.Of_AppendWhere("int.cd_natureza_operacao="+String(lvl_CFOP))
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'CFOP: '+String(lvl_CFOP)
End If

If Not IsNull(lvl_NF) and (lvl_NF > 0) Then
	This.Of_AppendWhere("nt.nr_nf="+String(lvl_NF))
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Nota: '+String(lvl_NF)
End If

If Not IsNull(lvs_Serie) and (Trim(lvs_Serie)<>"") Then
	This.Of_AppendWhere("nt.de_serie='"+lvs_Serie+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'S$$HEX1$$e900$$ENDHEX$$rie: '+lvs_Serie
End If

If lvs_Grupo<>'0' Then
	This.Of_AppendWhere("substring(coalesce(hp.cd_subcategoria, pg.cd_subcategoria),1,1)='"+lvs_Grupo+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Grupo Produto: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Subgrupo<>'0' Then
	This.Of_AppendWhere("substring(coalesce(hp.cd_subcategoria, pg.cd_subcategoria),1,3)='"+lvs_Subgrupo+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Subgrupo: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_subgrupo)',1)")
End If

If lvs_Lista_Pis<>'TD' Then
	This.Of_AppendWhere("coalesce(hp.id_situacao_pis_cofins, pg.id_situacao_pis_cofins)='"+lvs_Lista_Pis+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Lista PIS: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lista_pis_cofins)',1)")
End If

If lvs_Lei_Gen<>'TD' Then
	This.Of_AppendWhere("coalesce(hp.id_lei_generico, pg.id_lei_generico)='"+lvs_Lei_Gen+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Lei Gen$$HEX1$$e900$$ENDHEX$$rico: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")
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
		This.Of_AppendWhere("coalesce(hp.nr_classificacao_fiscal, pg.nr_classificacao_fiscal) >= "+String(lvl_NCM_Ini))
	End If
		
	If (Not IsNull(lvl_NCM_Fim) or (lvl_NCM_Fim > 0)) Then
		This.Of_AppendWhere("coalesce(hp.nr_classificacao_fiscal, pg.nr_classificacao_fiscal) <= "+String(lvl_NCM_Fim))
	End If
	
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'NCM: '+String(lvl_NCM_Ini)+' $$HEX1$$e000$$ENDHEX$$ '+String(lvl_NCM_Fim)
End If

lvs_SQL = This.GetSQLSelect()

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge625_rel_dinamico_transf_x_origem
integer x = 2053
integer y = 964
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio de Din$$HEX1$$e200$$ENDHEX$$mico de Transfer$$HEX1$$ea00$$ENDHEX$$ncias"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge625_rel_dinamico_transf_x_origem
integer x = 2889
integer y = 736
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge625_rel_dinamico_transf_x_origem
integer x = 1189
integer y = 960
end type

