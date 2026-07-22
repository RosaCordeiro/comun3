HA$PBExportHeader$w_ge489_rel_dinamico_diversas.srw
forward
global type w_ge489_rel_dinamico_diversas from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge489_rel_dinamico_diversas from dc_w_selecao_lista_dinamica_relatorio
integer width = 4329
integer height = 2036
string title = "GE489 - Relat$$HEX1$$f300$$ENDHEX$$rio de Din$$HEX1$$e200$$ENDHEX$$mico de Notas Diversas"
end type
global w_ge489_rel_dinamico_diversas w_ge489_rel_dinamico_diversas

type variables
uo_filial ivo_filial_orig					//GE009
uo_filial ivo_filial_dest					//GE009
uo_natureza_operacao ivo_cfop	//GE023
uo_produto ivo_produto				//GE001
uo_usuario ivo_usuario				//GE010

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child
Long lvl_Null

SetNull(lvl_Null)

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

/* Motivo Ajuste */
If dw_1.GetChild("cd_motivo_ajuste", ldwc_Child) > 0 Then
	ldwc_Child.InsertRow(1)
	
	ldwc_Child.SetItem(1, "cd_motivo_ajuste", lvl_Null)
	ldwc_Child.SetItem(1, "de_motivo_ajuste", "TODOS")
End If

/* Perfil NF */
If dw_1.GetChild("cd_perfil_nf", ldwc_Child) > 0 Then
	ldwc_Child.InsertRow(1)
	
	ldwc_Child.SetItem(1, "cd_perfil_nf", lvl_Null)
	ldwc_Child.SetItem(1, "de_perfil_nf", "TODOS")
End If
end subroutine

on w_ge489_rel_dinamico_diversas.create
call super::create
end on

on w_ge489_rel_dinamico_diversas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_filial_orig	= Create uo_filial
ivo_filial_dest	= Create uo_filial
ivo_cfop			= Create uo_natureza_operacao
ivo_produto		= Create uo_produto
ivo_usuario		= Create uo_usuario

//Dimensionamento de tela
MaxWidth = 4900
MaxHeight = 9999

//SQL Base para formar o grid
ivs_SQLBase = 'from nf_diversa n '	+ &
					'inner join item_nf_diversa i (index pk_item_nf_diversa) '	+ &
						'on i.cd_filial_origem = n.cd_filial_origem+0 '				+ &
						'and i.nr_nf = n.nr_nf+0 '										+ &
						'and i.de_especie = n.de_especie '							+ &
						'and i.de_serie = n.de_serie '									+ &
					'inner join filial fo (index pk_filial)  '								+ &
						'on fo.cd_filial = n.cd_filial_origem+0 '						+ &
					'inner join cidade co (index pk_cidade)  '							+ &
						'on co.cd_cidade = fo.cd_cidade+0 '							+ &
					'left outer join filial fd  '												+ &
						'on fd.nr_cgc = n.nr_cgc_cpf '									+ &
						"and fd.id_situacao = upper('A') "								+ &
						'and fd.cd_filial <> case when n.cd_filial_destino = 688 then 2 else 688 end '+ & 
						'and fd.cd_filial = coalesce(n.cd_filial_destino,fd.cd_filial) '	+ &
					'left outer join cidade cd (index pk_cidade)  '					+ &
						'on cd.cd_cidade = fd.cd_cidade+0 '							+ &
					'left outer join produto_geral pg (index pk_produto_geral)  '	+ &
						'on pg.cd_produto = i.cd_produto+0 '							+ &
					'left outer join subcategoria scp (index pk_subcategoria) '	+ &
						"on scp.cd_subcategoria = pg.cd_subcategoria||'' "		+ &
					'left outer join categoria cp (index pk_categoria) '				+ &
						"on cp.cd_categoria = scp.cd_categoria||'' "				+ &
					'left outer join subgrupo sgp (index pk_subgrupo) '			+ &
						"on sgp.cd_subgrupo = cp.cd_subgrupo||'' "				+ &
					'left outer join grupo gp  (index pk_grupo) '						+ &
						"on gp.cd_grupo = sgp.cd_grupo||'' "							+ &
					'left outer join produto_uf pu  (index pk_produto_uf)  '		+ &
						'on pu.cd_produto = i.cd_produto+0 '							+ &
						"and pu.cd_unidade_federacao = case when n.cd_natureza_operacao > 5000 then n.nm_uf else co.cd_unidade_federacao end "	+ &
					'left outer join natureza_operacao no (index pk_natureza_operacao)  '	+ &
						'on no.cd_natureza_operacao = n.cd_natureza_operacao+0 '			+ &
					'left outer join unidade_federacao ud (index pk_unidade_federacao)  '	+ &
						"on ud.cd_unidade_federacao = n.nm_uf "									+ &
					'left outer join nf_diversa_nfe ne (index pk_nf_diversa_nfe) '				+ &
						'on ne.cd_filial_origem = n.cd_filial_origem+0 '								+ &
						'and ne.nr_nf = n.nr_nf+0 '														+ &
						'and ne.de_especie = n.de_especie '											+ &
						'and ne.de_serie = n.de_serie '													+ &
					'left outer join tipo_icms ti (index pk_tipo_icms) '								+ &
					'	on ti.cd_tipo_icms = pu.cd_tipo_icms+0 '									+ &
					'left outer join perfil_nota_diversa pnd '											+ &
					'	on pnd.cd_perfil_nf = n.cd_perfil_nf+0 '										+ &
					'left outer join usuario ue (index pk_usuario) '									+ &
					'	on ue.nr_matricula = n.nr_matricula_operador '							+ &
					'left outer join motivo_ajuste ma (index pk_motivo_ajuste) '					+ &
					'	on ma.cd_motivo_ajuste = n.cd_motivo_ajuste+0 '	


//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 25
end event

event close;call super::close;If IsValid(ivo_filial_dest) Then Destroy(ivo_filial_dest)
If IsValid(ivo_filial_orig) Then Destroy(ivo_filial_orig)
If IsValid(ivo_produto) Then Destroy(ivo_produto)
If IsValid(ivo_usuario) Then Destroy(ivo_usuario)
If IsValid(ivo_cfop) Then Destroy(ivo_cfop)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge489_rel_dinamico_diversas
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge489_rel_dinamico_diversas
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge489_rel_dinamico_diversas
integer y = 676
integer width = 4229
integer height = 1156
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge489_rel_dinamico_diversas
integer width = 4233
integer height = 656
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge489_rel_dinamico_diversas
integer width = 4165
integer height = 568
string dataobject = "dw_ge489_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_usuario_emissor"
			ivo_usuario.Of_Localiza_Usuario( This.GetText() )
			
			If ivo_usuario.Localizado Then
				  
				This.Object.nr_matricula_emissor	[1] = ivo_usuario.nr_matricula
				This.Object.nm_usuario_emissor	[1] = ivo_usuario.nm_usuario
				
			End If
			
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
				This.Object.nm_filial_dest	[1] = ivo_filial_dest.nm_fantasia
				
			End If
			
		Case "nm_cfop"
			ivo_cfop.of_localiza_natureza(This.GetText())
			
			If ivo_cfop.Localizado Then
				  
				This.Object.cd_cfop	[1] = ivo_cfop.cd_natureza_operacao
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
		
	Case "nm_usuario_emissor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <>  ivo_usuario.nm_usuario Then
				Return 1
			End If	
		Else			
			ivo_usuario.Of_Inicializa()
			
			This.Object.nm_usuario_emissor	[1] = ivo_usuario.nm_usuario
			This.Object.nr_matricula_emissor	[1] = ivo_usuario.nr_matricula
			
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
			This.Object.cd_filial_dest		[1] = ivo_Filial_Dest.cd_filial
			
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

If IsValid(ivo_usuario) Then 
	This.Object.nm_usuario_emissor [1] = ivo_usuario.nm_usuario
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge489_rel_dinamico_diversas
integer y = 752
integer width = 4160
integer height = 1048
string title = "Rel. Din$$HEX1$$e200$$ENDHEX$$mico de Notas Diversas"
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
String lvs_Oculta_NF_Dest_Filial
String lvs_Matric_Emissor
String lvs_PDV_Novo

Long lvl_NCM_Ini
Long lvl_NCM_Fim
Long lvl_NF
Long lvl_CFOP
Long lvl_Filial_Orig
Long lvl_Filial_Dest
Long lvl_Produto
Long lvl_Mot_Ajuste				
Long lvl_Perfil_NF					

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio						= dw_1.Object.dt_inicio							[1]
lvdt_Fim							= dw_1.Object.dt_fim								[1]
lvl_Filial_Orig					= dw_1.Object.cd_filial							[1]
lvl_Filial_Dest					= dw_1.Object.cd_filial_dest					[1]
lvs_UF_Fil						= dw_1.Object.cd_uf								[1]
lvs_UF_Dest						= dw_1.Object.cd_uf_dest						[1]
lvl_Produto						= dw_1.Object.cd_produto						[1]
lvs_Situacao						= dw_1.Object.id_situacao						[1]
lvs_Tipo							= dw_1.Object.id_tipo							[1]
lvl_CFOP							= dw_1.Object.cd_cfop							[1]
lvs_Grupo						= dw_1.Object.cd_grupo							[1]
lvs_Subgrupo					= dw_1.Object.cd_subgrupo					[1]
lvl_NCM_Ini						= dw_1.Object.nr_ncm_ini						[1]
lvl_NCM_Fim					= dw_1.Object.nr_ncm_fim						[1]
lvs_Lista_Pis						= dw_1.Object.id_lista_pis_cofins				[1]
lvs_Lei_Gen						= dw_1.Object.id_lei_generico					[1]
lvl_NF								= dw_1.Object.nr_nf								[1]
lvs_Serie							= dw_1.Object.de_serie							[1]
lvl_Mot_Ajuste					= dw_1.Object.cd_motivo_ajuste				[1]
lvl_Perfil_NF						= dw_1.Object.cd_perfil_nf						[1]
lvs_Oculta_NF_Dest_Filial	= dw_1.Object.id_oculta_dest_propria_fil	[1]
lvs_Matric_Emissor			= dw_1.Object.nr_matricula_emissor			[1]
lvs_PDV_Novo					= dw_1.Object.id_sistema_novo				[1]

If IsNull(lvdt_Inicio) or (lvdt_Inicio < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data inicial para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
Else
	This.Of_AppendWhere("n.dh_movimentacao_caixa>='"+String(lvdt_Inicio,'YYYY/MM/DD')+"'")
End If

If IsNull(lvdt_Fim) or (lvdt_Fim < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data final para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_fim')
	Return -1
Else
	This.Of_AppendWhere("n.dh_movimentacao_caixa<='"+String(lvdt_Fim,'YYYY/MM/DD')+"'")
End If

This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'DD/MM/YYYY')

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	This.Of_AppendWhere("i.cd_produto="+String(lvl_Produto))
	This.Of_AppendWhere("pg.cd_produto="+String(lvl_Produto))
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Produto: '+ivo_produto.de_produto+' ('+String(lvl_Produto)+')'
End If

If Not IsNull(lvl_Filial_Orig) and (lvl_Filial_Orig > 0) Then
	This.Of_AppendWhere("case when n.cd_natureza_operacao<5000 and substring(n.nr_cgc_cpf,1,8)  = '84683481' then fd.cd_filial else fo.cd_filial end="+String(lvl_Filial_Orig))
	//This.Of_AppendWhere("fo.cd_filial="+String(lvl_Filial_Orig))
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Filial Origem: '+ivo_filial_orig.nm_fantasia+' ('+String(lvl_Filial_Orig)+')'
ElseIf IsNull(lvl_Filial_Dest) or (lvl_Filial_Dest <= 0) Then
	This.Of_AppendWhere("n.cd_filial_origem > 0")
End If

If Not IsNull(lvl_Filial_Dest) and (lvl_Filial_Dest > 0) Then
	If lvl_Filial_Dest = 534 Then
		This.Of_AppendWhere("case when n.cd_natureza_operacao<5000 and substring(n.nr_cgc_cpf,1,8)  = '84683481' then n.cd_filial_origem else fd.cd_filial end in (1,"+String(lvl_Filial_Dest)+")")
		This.Of_AppendWhere("case when n.cd_natureza_operacao<5000 and substring(n.nr_cgc_cpf,1,8)  = '84683481' then fo.cd_filial else fd.cd_filial end in (1,"+String(lvl_Filial_Dest)+")")
	Else
		This.Of_AppendWhere("case when n.cd_natureza_operacao<5000 and substring(n.nr_cgc_cpf,1,8)  = '84683481' then n.cd_filial_origem else fd.cd_filial end="+String(lvl_Filial_Dest))
		This.Of_AppendWhere("case when n.cd_natureza_operacao<5000 and substring(n.nr_cgc_cpf,1,8)  = '84683481' then fo.cd_filial else fd.cd_filial end="+String(lvl_Filial_Dest))
	End If
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Filial Destino: '+ivo_filial_dest.nm_fantasia+' ('+String(lvl_Filial_Dest)+')'
End If

If lvs_UF_Fil<>'TD' Then
	This.Of_AppendWhere("co.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'UF Origem: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If lvs_UF_Dest<>'TD' Then
	This.Of_AppendWhere("cd.cd_unidade_federacao='"+lvs_UF_Dest+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf_dest)',1)")+' ('+lvs_UF_Dest+')'
End If

Choose Case lvs_Tipo
	Case 'PT'		//PATRIMONIO/ATIVO
		This.Of_AppendWhere("n.id_patrimonio='S'")
	Case 'AJ'		//AJUSTE ESTOQUE
		This.Of_AppendWhere("n.id_ajusta_estoque ='S'")
	Case 'AU' 	//AJUSTE AUDITORIA
		This.Of_AppendWhere("n.id_ajuste_auditoria='S'")
	Case 'CD' 	//DEV. COMPRA COMPL. - ICMS
		This.Of_AppendWhere("n.cd_tipo_documento='DC2'")
	Case 'CS' 	//DEV. COMPRA COMPL. - ICMS ST
		This.Of_AppendWhere("n.cd_tipo_documento='DC3'")
	Case 'CT'	//TRANSF. COMPL. - ICMS ST
		This.Of_AppendWhere("n.cd_tipo_documento='TR1'")
	Case 'CI'		//TRANSF. COMPL. - ICMS
		This.Of_AppendWhere("n.cd_tipo_documento='TR2'")
	Case 'ES'		//ESTORNO
		This.Of_AppendWhere("n.cd_tipo_documento='EST'")
	Case 'ES'		//VENDAS COM CONTAS A RECEBER
		This.Of_AppendWhere("n.cd_tipo_documento='VDD'")
End Choose
This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Tipo: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo)',1)")

Choose Case lvs_Situacao
	Case "CA"
		This.of_AppendWhere(" n.dh_cancelamento is not null")
	Case "NO"
		This.of_AppendWhere(" n.dh_cancelamento is null")
End Choose

If Not IsNull(lvl_CFOP) and (lvl_CFOP > 0) Then
	This.Of_AppendWhere("n.cd_natureza_operacao="+String(lvl_CFOP))
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'CFOP: '+String(lvl_CFOP)
End If

If Not IsNull(lvl_NF) and (lvl_NF > 0) Then
	This.Of_AppendWhere("n.nr_nf="+String(lvl_NF))
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Nota: '+String(lvl_NF)
End If

If Not IsNull(lvs_Serie) and (Trim(lvs_Serie)<>"") Then
	This.Of_AppendWhere("n.de_serie='"+lvs_Serie+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'S$$HEX1$$e900$$ENDHEX$$rie: '+lvs_Serie
End If

If lvs_Grupo<>'0' Then
	This.Of_AppendWhere("substring(pg.cd_subcategoria,1,1)='"+lvs_Grupo+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Grupo Prod.: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Subgrupo<>'0' Then
	This.Of_AppendWhere("substring(pg.cd_subcategoria,1,3)='"+lvs_Subgrupo+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Subgrupo: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_subgrupo)',1)")
End If

If lvs_Lista_Pis<>'TD' Then
	This.Of_AppendWhere("pg.id_situacao_pis_cofins='"+lvs_Lista_Pis+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Lista PIS: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lista_pis_cofins)',1)")
End If

If lvs_Lei_Gen<>'TD' Then
	This.Of_AppendWhere("pg.id_lei_generico='"+lvs_Lei_Gen+"'")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Lei Gen$$HEX1$$e900$$ENDHEX$$rico: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")
End If

If lvs_Oculta_NF_Dest_Filial = "S" Then
	This.Of_appendwhere("coalesce(n.nr_cgc_cpf, '') <> coalesce(fo.nr_cgc, '')")
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = '[ X ] Ocultar notas destinadas a mesma filial '
End If

If Not IsNull( lvl_Mot_Ajuste ) and lvl_Mot_Ajuste > 0 Then
	This.of_AppendWhere("n.cd_motivo_ajuste = " + String( lvl_Mot_Ajuste ) )
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Motivo Ajuste: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_motivo_ajuste)',1)")
End If

If Not IsNull( lvl_Perfil_NF ) and lvl_Perfil_NF > 0 Then
	This.of_AppendWhere("n.cd_perfil_nf = " + String( lvl_Perfil_NF ) )
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Perfil NF: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_perfil_nf)',1)")
End If

If lvs_PDV_Novo<>"" Then
	This.of_AppendWhere("coalesce(n.id_sistema_novo,'N') ='" + lvs_PDV_Novo+"'" )
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Sistema: '+dw_1.Describe("Evaluate('LookUpDisplay(id_sistema_novo)',1)")
End If

If lvs_Matric_Emissor<>"" Then
	This.of_AppendWhere("n.nr_matricula_operador='" + lvs_Matric_Emissor+"'" )
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Emissor NF: '+dw_1.Describe("Evaluate('LookUpDisplay(id_sistema_novo)',1)")
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
		This.Of_AppendWhere("pg.nr_classificacao_fiscal >= "+String(lvl_NCM_Ini))
	End If
		
	If (Not IsNull(lvl_NCM_Fim) or (lvl_NCM_Fim > 0)) Then
		This.Of_AppendWhere("pg.nr_classificacao_fiscal <= "+String(lvl_NCM_Fim))
	End If
	
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'NCM: '+String(lvl_NCM_Ini)+' $$HEX1$$e000$$ENDHEX$$ '+String(lvl_NCM_Fim)
End If

lvs_Subgrupo = This.GetSQLSelect()

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge489_rel_dinamico_diversas
integer x = 2053
integer y = 964
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio de Din$$HEX1$$e200$$ENDHEX$$mico de Transfer$$HEX1$$ea00$$ENDHEX$$ncias"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge489_rel_dinamico_diversas
integer x = 2889
integer y = 736
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge489_rel_dinamico_diversas
integer x = 1189
integer y = 960
end type

