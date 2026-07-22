HA$PBExportHeader$w_ge323_rel_dinamico_vendas_nf.srw
forward
global type w_ge323_rel_dinamico_vendas_nf from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge323_rel_dinamico_vendas_nf from dc_w_selecao_lista_dinamica_relatorio
integer width = 4379
integer height = 2116
string title = "GE323 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (Por Nota)"
end type
global w_ge323_rel_dinamico_vendas_nf w_ge323_rel_dinamico_vendas_nf

type variables
uo_filial ivo_filial
uo_cliente ivo_cliente
uo_convenio ivo_convenio
uo_conveniado ivo_conveniado

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			
ldwc_Child.SetItem(1, "cd_unidade_federacao", "")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")
dw_1.Object.cd_uf[1] = ""

/*Tipo Canal Venda*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_tipo_canal" )			
ldwc_Child.SetItem(1, "id_tipo_canal_venda", "")
ldwc_Child.SetItem(1, "de_tipo_canal_venda", "TODAS")
dw_1.Object.id_tipo_canal[1] = ""

/*Canal Venda*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_canal_venda" )			
ldwc_Child.SetItem(1, "cd_canal_venda", "")
ldwc_Child.SetItem(1, "de_canal_venda", "TODAS")
dw_1.Object.id_canal_venda[1] = ""

/*Area de Vendas / Rede */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_area_vendas" )			
ldwc_Child.SetItem(1, "vl_parametro", "")
ldwc_Child.SetItem(1, "rede", "TODAS")
dw_1.Object.id_area_vendas[1] = ""

/*Modo Entrega */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_modo_entrega" )			
ldwc_Child.SetItem(1, "cd_modo_entrega", "")
ldwc_Child.SetItem(1, "de_modo_entrega", "TODAS")
dw_1.Object.cd_modo_entrega[1] = ""
end subroutine

on w_ge323_rel_dinamico_vendas_nf.create
call super::create
end on

on w_ge323_rel_dinamico_vendas_nf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_filial			= Create uo_filial
ivo_conveniado	= Create uo_conveniado
ivo_cliente		= Create uo_cliente
ivo_convenio	= Create uo_convenio

//Dimensionamento de tela
MaxWidth = 4600
MaxHeight = 9999

//SQL Base para formar o grid
ivs_SQLBase = 'from nf_venda n '														+ &
					'Inner Join filial f (index pk_filial) '									+ &
					'	on f.cd_filial = n.cd_filial '										+ &
					'Inner Join cidade cf (index pk_cidade) '							+ &
					'	on cf.cd_cidade = f.cd_cidade '									+ &
					'Left Outer Join usuario op (index pk_usuario) '					+ &
					'	on op.nr_matricula = n.nr_matric_operador '				+ &
					'Left Outer Join usuario vd (index pk_usuario) '					+ &
					'	on vd.nr_matricula = n.nr_matricula_vendedor '			+ &
					'Left Outer Join cliente cl (index pk_cliente) '					+ &
					'	on cl.cd_cliente = n.cd_cliente '								+ &
					'Left Outer Join convenio cv (index pk_convenio) '				+ &
					'	on cv.cd_convenio = n.cd_convenio '							+ &
					'Left Outer Join conveniado co (index pk_conveniado) '		+ &
					'	on co.cd_convenio = n.cd_convenio '							+ &
					'  and co.cd_conveniado = n.cd_conveniado '					+ &	
					'Left Outer Join condicao_venda_convenio cvc (index pk_condicao_venda_convenio) '		+ &
					'  On cvc.cd_condicao_convenio = n.cd_condicao_convenio '+ &
					'Left Outer Join dependente_conveniado dcv (index pk_dependente_conveniado) '		+ &
					'	on dcv.cd_convenio = n.cd_convenio '						+ &
					'  and dcv.cd_conveniado = n.cd_conveniado '					+ &
					'  and dcv.cd_dependente = n.cd_dependente_conveniado '	+ &
					'Left Outer Join usuario uls (index pk_usuario) '					+ &
					'	on uls.nr_matricula = n.nr_matric_liberacao_senha '		+ &
					'Left Outer Join usuario uap (index pk_usuario) '				+ &
					'	on uap.nr_matricula = n.nr_matric_alteracao_preco '		+ &
					'Left Outer Join usuario ulb (index pk_usuario) '				+ &
					'	on ulb.nr_matricula = n.nr_matric_liberacao_bloqueio '	+ &
					'Left Outer Join usuario ulr (index pk_usuario) '					+ &
					'	on ulr.nr_matricula = n.nr_matric_liberacao_restricao ' + &
					'Left Outer Join pedido_ecommerce_auxiliar pea (index pk_pedido_ecommerce_auxiliar) '	+ &
					'	on pea.cd_filial_ecommerce = coalesce(n.cd_filial_ecommerce,809) '	+ &
					'	and pea.nr_pedido = n.nr_pedido_ecommerce ' 			+ &
					'Left Outer Join pedido_ecommerce pe (index pk_pedido_ecommerce) '	+ &
					'	on pe.cd_filial_ecommerce = coalesce(n.cd_filial_ecommerce,809) '		+ &
					'	and pe.nr_pedido = n.nr_pedido_ecommerce '				+ &
					'Left Outer Join canal_venda cnv (index pk_canal_venda) '	+ &
					" 	on cnv.cd_canal_venda = Upper(case when n.dh_movimentacao_caixa >= '2019/01/01' then coalesce(case when pe.de_canal_compra_vtex in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n') then 'AP' else n.cd_canal_venda end, 'LF') else case when n.nr_pedido_ecommerce > 0 then 'EC'  else case when n.nr_pedido_drogaexpress is not null then 'DE' else 'LF' end end end)"

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 9
end event

event close;call super::close;Destroy(ivo_cliente)
Destroy(ivo_convenio)
Destroy(ivo_filial)
Destroy(ivo_conveniado)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge323_rel_dinamico_vendas_nf
integer y = 1324
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge323_rel_dinamico_vendas_nf
integer y = 1252
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge323_rel_dinamico_vendas_nf
integer y = 704
integer width = 4261
integer height = 1216
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge323_rel_dinamico_vendas_nf
integer width = 4265
integer height = 676
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge323_rel_dinamico_vendas_nf
integer width = 4197
integer height = 588
string dataobject = "dw_ge323_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial.Localizada Then
				  
				This.Object.cd_filial	[1] = ivo_filial.cd_filial
				This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
				
			End If
			
		Case "nm_conveniado"
			If ivo_convenio.localizado Then
				
				ivo_conveniado.of_localiza_conveniado(ivo_convenio.cd_convenio, This.GetText())
				
				If ivo_conveniado.Localizado Then
					  
					This.Object.cd_conveniado	[1] = ivo_conveniado.cd_conveniado
					This.Object.nm_conveniado	[1] = ivo_conveniado.nm_conveniado
					
				End If
			Else
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione primeiramente o conv$$HEX1$$ea00$$ENDHEX$$nio!')
				This.Event ue_pos(1,'nm_convenio')
			End If
		Case "nm_cliente"
			ivo_cliente.of_localiza_cliente(This.GetText())
			
			If ivo_cliente.Localizado Then
				  
				This.Object.cd_cliente	[1] = ivo_cliente.cd_cliente
				This.Object.nm_cliente	[1] = ivo_cliente.nm_cliente
				
			End If
			
		Case "nm_convenio"
			ivo_convenio.of_localiza_convenio(This.GetText())
			
			If ivo_convenio.Localizado Then
				  
				This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
				This.Object.nm_convenio[1] = ivo_convenio.nm_razao_social
				
			End If

	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;DatawindowChild lvdw_Child

Choose Case dwo.Name
		
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_Inicializa()
			
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			
		End If	
		
	Case "nm_conveniado"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_conveniado.nm_conveniado Then
				Return 1
			End If	
		Else			
			ivo_conveniado.Of_Inicializa()
			
			This.Object.nm_conveniado	[1] = ivo_conveniado.nm_conveniado
			This.Object.cd_conveniado	[1] = ivo_conveniado.cd_conveniado
			
		End If	
		
	Case "nm_cliente"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cliente.nm_cliente Then
				Return 1
			End If	
		Else			
			ivo_cliente.Of_Inicializa()
			
			This.Object.nm_cliente	[1] = ivo_cliente.nm_cliente
			This.Object.cd_cliente	[1] = ivo_cliente.cd_cliente
			
		End If	
		
	Case "nm_convenio"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_convenio.nm_razao_social Then
				Return 1
			End If	
		Else			
			ivo_convenio.Of_Inicializa()
			
			This.Object.nm_convenio[1] = ivo_convenio.nm_razao_social
			This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
			
			ivo_conveniado.Of_Inicializa()
			
			This.Object.nm_conveniado	[1] = ivo_conveniado.nm_conveniado
			This.Object.cd_conveniado	[1] = ivo_conveniado.cd_conveniado
			
		End If	
		
	Case "id_tipo_canal"
		If dw_1.GetChild("id_canal_venda", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(id_tipo_canal) or id_tipo_canal = '"+Data+"'")
			lvdw_Child.Filter()
		End If
		
		If dw_1.GetChild("cd_modo_entrega", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(id_tipo_canal) or id_tipo_canal = '"+Data+"'")
			lvdw_Child.Filter()
		End If
		
		This.Object.id_canal_venda 		[1] = ""
		This.Object.cd_modo_entrega	[1] = ""
		
	Case "id_canal_venda"
		If dw_1.GetChild("cd_modo_entrega", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(id_tipo_canal) or id_tipo_canal = '"+This.Object.id_tipo_canal[Row]+"'")
			lvdw_Child.Filter()
		End If
		This.Object.cd_modo_entrega [1] = ""
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_conveniado) Then 
	This.Object.nm_conveniado [1] = ivo_conveniado.nm_conveniado
End If

If IsValid(ivo_cliente) Then 
	This.Object.nm_cliente [1] = ivo_cliente.nm_cliente
End If

If IsValid(ivo_convenio) Then 
	This.Object.nm_convenio [1] = ivo_convenio.nm_razao_social
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge323_rel_dinamico_vendas_nf
integer y = 780
integer width = 4192
integer height = 1108
boolean controlmenu = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_UF_Fil
String lvs_Cliente
String lvs_Tipo
String lvs_Forma_Pagto
String lvs_Especie
String lvs_Anexa
String lvs_Conveniado
String lvs_SQL
String lvs_Situacao
String lvs_Tipo_Desc
String lvs_Lib_Senha
String lvs_Lib_Restr
String lvs_Lib_Bloq
String lvs_Rede
String lvs_Modo_Entrega
String lvs_Canal_Venda
String lvs_Tipo_Canal
String lvs_Indice = "idx_data_filial"

Long lvl_Filial
Long lvl_Convenio
Long lvl_NF
Long lvl_SubQuery = 1

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio			= dw_1.Object.dt_inicio				[1]
lvdt_Fim				= dw_1.Object.dt_fim					[1]
lvl_Filial				= dw_1.Object.cd_filial				[1]
lvl_Convenio			= dw_1.Object.cd_convenio			[1]
lvs_UF_Fil			= dw_1.Object.cd_uf					[1]
lvs_Cliente			= dw_1.Object.cd_cliente			[1]
lvs_Tipo				= dw_1.Object.id_tipo_venda		[1]
lvs_Forma_Pagto	= dw_1.Object.cd_forma_pagto	[1]
lvs_Especie			= dw_1.Object.de_especie			[1]
lvs_Anexa			= dw_1.Object.id_anexa				[1]
lvs_Conveniado		= dw_1.Object.cd_conveniado		[1]
lvs_Situacao			= dw_1.Object.id_situacao			[1]
lvs_Tipo_Desc		= dw_1.Object.id_tipo_desconto	[1]
lvs_Lib_Senha		= dw_1.Object.id_lib_senha			[1]
lvs_Lib_Restr		= dw_1.Object.id_lib_restricao		[1]
lvs_Lib_Bloq			= dw_1.Object.id_lib_bloqueio		[1]
lvs_Rede				= dw_1.Object.id_area_vendas		[1]
lvs_Modo_Entrega	= dw_1.Object.cd_modo_entrega	[1]
lvs_Canal_Venda	= dw_1.Object.id_canal_venda		[1]
lvs_Tipo_Canal		= dw_1.Object.id_tipo_canal		[1]
lvl_NF					= dw_1.Object.nr_nf					[1]

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

ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'YYYY/MM/DD')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'YYYY/MM/DD')

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.Of_AppendWhere("n.cd_filial="+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
End If

If Not IsNull(lvl_Convenio) and (lvl_Convenio > 0) Then
	lvs_Indice = "idx_convenio_data"
	This.Of_AppendWhere("n.cd_convenio="+String(lvl_Convenio))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_convenio.nm_razao_social+' ('+String(lvl_Convenio)+')'

	If (Not IsNull(lvs_Conveniado)) and (Trim(lvs_Conveniado) <> '') Then
		lvs_Indice = "idx_convenio_conveniado"
		This.Of_AppendWhere("n.cd_conveniado='"+String(lvs_Conveniado)+"'")
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Conveniado: '+ivo_conveniado.nm_conveniado+' ('+String(lvs_Conveniado)+')'		
	End If
End If

If lvs_UF_Fil<>'' Then
	This.Of_AppendWhere("cf.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If lvs_Especie<>'TD' Then
	This.Of_AppendWhere("n.de_especie='"+lvs_Especie+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Esp$$HEX1$$e900$$ENDHEX$$cie: '+dw_1.Describe("Evaluate('LookUpDisplay(de_especie)',1)")
End If

If lvs_Tipo<>'TD' Then
	This.Of_AppendWhere("n.id_tipo_venda='"+lvs_Tipo+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Venda: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_venda)',1)")
	
	If lvs_Tipo = 'CV' Then
		This.Of_AppendWhere("n.cd_convenio > 0")
	End If	
End If

If lvs_Anexa <> "" Then
	If lvs_Anexa = 'N' Then
		This.Of_AppendWhere("n.nr_nf_anexa is null")
	Else
		This.Of_AppendWhere("n.nr_nf_anexa is not null")
	End If
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NF Anexa: '+dw_1.Describe("Evaluate('LookUpDisplay(id_anexa)',1)")
End If

If lvs_Forma_Pagto<>'TD' Then
	This.Of_AppendWhere("n.cd_forma_pagamento='"+lvs_Forma_Pagto+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Forma Pagto: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_forma_pagto)',1)")
End If

If (Not IsNull(lvs_Cliente)) and (Trim(lvs_Cliente)<>'') Then
	lvs_Indice = "idx_cd_cliente"
	This.Of_AppendWhere("n.cd_cliente='"+lvs_Cliente+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Cliente: '+ivo_cliente.nm_cliente+' ('+lvs_Cliente+')'
End If

If lvl_NF > 0 Then
	If lvl_Filial > 0 Then lvs_Indice = "pk_nf_venda"
	This.Of_AppendWhere("n.nr_nf="+String(lvl_NF))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Nota: '+String(lvl_NF)
End If

Choose Case lvs_Situacao
	Case "S"
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Situa$$HEX2$$e700e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")
		This.Of_AppendWhere("n.dh_cancelamento is not null")
	Case "N"
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Situa$$HEX2$$e700e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")
		This.Of_AppendWhere("n.dh_cancelamento is null")
End Choose

Choose Case lvs_Lib_Senha
	Case "S"
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lib. Senha: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lib_senha)',1)")
		This.Of_AppendWhere("coalesce(n.nr_matric_liberacao_senha,'')<>''")
	Case "N"
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lib. Senha: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lib_senha)',1)")
		This.Of_AppendWhere("coalesce(n.nr_matric_liberacao_senha,'')=''")
End Choose

Choose Case lvs_Lib_Restr
	Case "S"
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lib. Restri$$HEX2$$e700e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lib_restricao)',1)")
		This.Of_AppendWhere("n.nr_matric_liberacao_restricao is not null")
	Case "N"
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lib. Restri$$HEX2$$e700e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lib_restricao)',1)")
		This.Of_AppendWhere("n.nr_matric_liberacao_restricao is null")
End Choose

Choose Case lvs_Lib_Bloq
	Case "S"
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lib. Bloqueio: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lib_bloqueio)',1)")
		This.Of_AppendWhere("n.nr_matric_liberacao_bloqueio is not null")
	Case "N"
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lib. Bloqueio: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lib_bloqueio)',1)")
		This.Of_AppendWhere("n.nr_matric_liberacao_bloqueio is null")
End Choose

If lvs_Tipo_Desc <> "" Then
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Desconto: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_desconto)',1)")
	Choose Case lvs_Tipo_Desc
		Case "PE"
			This.Of_AppendWhere("n.nr_matric_alteracao_preco is null ")
			This.Of_AppendWhere("exists (select 1 from nf_venda_desconto n1 "+ &
																" where n1.item_nf_venda_desconto = 'PVE' "+ &
																" and n1.cd_filial = n.cd_filial "+&
																" and n1.nr_nf = n.nr_nf "+ &
																" and n1.de_especie = n.de_especie "+&
																" and n1.de_serie = n.de_serie)")
			lvl_SubQuery++
		Case "PM"
			This.Of_AppendWhere("n.nr_matric_alteracao_preco is not null")
			This.Of_AppendWhere("exists (select 1 from item_nf_venda_desconto n1 "+ &
																" where n1.id_tipo_desconto = 'PVE' "+ &
																" and n1.cd_filial = n.cd_filial "+&
																" and n1.nr_nf = n.nr_nf "+ &
																" and n1.de_especie = n.de_especie "+&
																" and n1.de_serie = n.de_serie)")
			lvl_SubQuery++
		Case Else
			This.Of_AppendWhere("exists (select 1 from item_nf_venda_desconto n1 "+ &
																" where n1.id_tipo_desconto = '"+lvs_Tipo_Desc+"' "+ &
																" and n1.cd_filial = n.cd_filial "+&
																" and n1.nr_nf = n.nr_nf "+ &
																" and n1.de_especie = n.de_especie "+&
																" and n1.de_serie = n.de_serie)")
			lvl_SubQuery++
	End Choose
End If

If lvs_Rede <> "" Then
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Rede: " + dw_1.Describe("Evaluate('LookUpDisplay(id_area_vendas)',1)")
	This.Of_AppendWhere("coalesce(pea.id_rede_ecommerce, f.id_rede_filial) = '" + lvs_Rede + "'")
End If

If lvs_Tipo_Canal <> "" Then
	This.Of_AppendWhere("cnv.id_tipo_canal = '"+lvs_Tipo_Canal+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Tipo Canal de Venda: " + dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_canal)',1)")
	
	//Otimiza$$HEX2$$e700e300$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o
	Choose Case lvs_Tipo_Canal
		Case "EC"
			lvs_Indice = "idx_data_ped_ecommerce"
			This.Of_AppendWhere("n.nr_pedido_ecommerce > 0") 
			
		Case "LI" //Licita$$HEX2$$e700e300$$ENDHEX$$o
			lvs_Indice = "idx_licitacao"
			This.Of_AppendWhere("n.id_licitacao='S'")
	End Choose
End If

If lvs_Canal_Venda <> "" Then
	If lvs_Canal_Venda = "AP" Then
		This.of_AppendWhere("coalesce(pe.id_ecommerce,'1')='2'") //Todas as vendas VTEX, depois ajustar o filtro quando for poss$$HEX1$$ed00$$ENDHEX$$vel identificar
		This.of_AppendWhere("pe.de_canal_compra_vtex in ('app_android', 'app_ios', app_android_n', 'app_ios_n')") 
	Else
		If lvdt_Inicio > Date("2020/10/08") Then This.Of_AppendWhere("n.cd_canal_venda = '"+lvs_Canal_Venda+"'")
		This.Of_AppendWhere("cnv.cd_canal_venda = '"+lvs_Canal_Venda+"'")
		This.of_AppendWhere("coalesce(pe.de_canal_compra_vtex,'') not in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n')") 
	End If	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Canal de Venda: " + dw_1.Describe("Evaluate('LookUpDisplay(id_canal_venda)',1)")
End If

If lvs_Modo_Entrega <> "" Then
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Modo Entrega: " + dw_1.Describe("Evaluate('LookUpDisplay(cd_modo_entrega)',1)")
	This.Of_AppendWhere("pe.nm_transportadora = '" + dw_1.Describe("Evaluate('LookUpDisplay(cd_modo_entrega)',1)") + "'")
End If

lvs_SQL = This.GetSQLSelect( )
lvs_SQL = gf_replace(lvs_SQL,'from nf_venda n ','from nf_venda n (index '+lvs_Indice+') ',1)	
This.of_ChangeSQL(lvs_SQL)

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge323_rel_dinamico_vendas_nf
integer x = 1865
integer y = 864
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (Nota)"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge323_rel_dinamico_vendas_nf
integer x = 2606
integer y = 792
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge323_rel_dinamico_vendas_nf
integer y = 644
end type

