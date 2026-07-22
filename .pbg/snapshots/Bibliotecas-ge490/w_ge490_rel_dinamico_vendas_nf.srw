HA$PBExportHeader$w_ge490_rel_dinamico_vendas_nf.srw
forward
global type w_ge490_rel_dinamico_vendas_nf from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge490_rel_dinamico_vendas_nf from dc_w_selecao_lista_dinamica_relatorio
integer width = 4402
integer height = 2036
string title = "GE490 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (Por Nota)"
end type
global w_ge490_rel_dinamico_vendas_nf w_ge490_rel_dinamico_vendas_nf

type variables
uo_filial ivo_filial

uo_cliente ivo_cliente
uo_convenio ivo_convenio
uo_conveniado ivo_conveniado

uo_cliente ivo_cliente_nf
uo_convenio ivo_convenio_nf
uo_conveniado ivo_conveniado_nf
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf[1] = "TD"
end subroutine

on w_ge490_rel_dinamico_vendas_nf.create
call super::create
end on

on w_ge490_rel_dinamico_vendas_nf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_filial				= Create uo_filial
ivo_cliente			= Create uo_cliente
ivo_convenio		= Create uo_convenio
ivo_conveniado		= Create uo_conveniado
ivo_cliente_nf		= Create uo_cliente
ivo_convenio_nf	= Create uo_convenio
ivo_conveniado_nf	= Create uo_conveniado

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
					'Left Outer Join nf_venda_alteracao nva (index idx_nota) '	+ &
					'	on nva.cd_filial = n.cd_filial '									+ &
					'	and nva.nr_nf = n.nr_nf '										+ &
					'	and nva.de_especie = n.de_especie '							+ &
					'	and nva.de_serie = n.de_serie '								+ &
					'Left Outer Join cliente cl (index pk_cliente) '					+ &
					'	on cl.cd_cliente = coalesce(nva.cd_cliente_de, n.cd_cliente) '									+ &
					'Left Outer Join convenio cv (index pk_convenio) '														+ &
					'	on cv.cd_convenio = coalesce(nva.cd_convenio_de, n.cd_convenio) '							+ &
					'Left Outer Join conveniado co (index pk_conveniado) '												+ &
					'	on co.cd_convenio = coalesce(nva.cd_convenio_de, n.cd_convenio) '							+ &
					'  and co.cd_conveniado = coalesce(nva.cd_conveniado_de, n.cd_conveniado) '				+ &	
					'Left Outer Join condicao_venda_convenio cvc (index pk_condicao_venda_convenio) '			+ &
					'  On cvc.cd_condicao_convenio = n.cd_condicao_convenio '										+ &
					'Left Outer Join dependente_conveniado dcv (index pk_dependente_conveniado) '				+ &
					'	on dcv.cd_convenio = coalesce(nva.cd_convenio_de, n.cd_convenio) '						+ &
					'  and dcv.cd_conveniado = coalesce(nva.cd_conveniado_de, n.cd_conveniado) '				+ &
					'  and dcv.cd_dependente = coalesce(nva.cd_dependente_conveniado_de, n.cd_dependente_conveniado) '	+ &
					'Left Outer Join usuario uls (index pk_usuario) '					+ &
					'	on uls.nr_matricula = n.nr_matric_liberacao_senha '		+ &
					'Left Outer Join usuario uap (index pk_usuario) '				+ &
					'	on uap.nr_matricula = n.nr_matric_alteracao_preco '		+ &
					'Left Outer Join usuario ulb (index pk_usuario) '				+ &
					'	on ulb.nr_matricula = n.nr_matric_liberacao_bloqueio '	+ &
					'Left Outer Join usuario ulr (index pk_usuario) '					+ &
					'	on ulr.nr_matricula = n.nr_matric_liberacao_restricao '

//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 26
end event

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_cliente)
Destroy(ivo_convenio)
Destroy(ivo_conveniado)
Destroy(ivo_cliente_nf)
Destroy(ivo_convenio_nf)
Destroy(ivo_conveniado_nf)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge490_rel_dinamico_vendas_nf
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge490_rel_dinamico_vendas_nf
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge490_rel_dinamico_vendas_nf
integer y = 628
integer width = 4302
integer height = 1196
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge490_rel_dinamico_vendas_nf
integer width = 4302
integer height = 592
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge490_rel_dinamico_vendas_nf
integer width = 4233
integer height = 504
string dataobject = "dw_ge490_selecao"
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

		Case "nm_conveniado_de"
			If ivo_convenio_nf.localizado Then
				
				ivo_conveniado_nf.of_localiza_conveniado(ivo_convenio_nf.cd_convenio, This.GetText())
				
				If ivo_conveniado_nf.Localizado Then
					This.Object.cd_conveniado_de	[1] = ivo_conveniado_nf.cd_conveniado
					This.Object.nm_conveniado_de	[1] = ivo_conveniado_nf.nm_conveniado
				End If
			Else
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione primeiramente o conv$$HEX1$$ea00$$ENDHEX$$nio!')
				This.Event ue_pos(1,'nm_convenio_de')
			End If
			
		Case "nm_cliente_de"
			ivo_cliente_nf.of_localiza_cliente(This.GetText())
			
			If ivo_cliente_nf.Localizado Then
				This.Object.cd_cliente_de	[1] = ivo_cliente_nf.cd_cliente
				This.Object.nm_cliente_de	[1] = ivo_cliente_nf.nm_cliente
			End If
			
		Case "nm_convenio_de"
			ivo_convenio_nf.of_localiza_convenio(This.GetText())
			
			If ivo_convenio_nf.Localizado Then
				This.Object.cd_convenio_de		[1] = ivo_convenio_nf.cd_convenio
				This.Object.nm_convenio_de	[1] = ivo_convenio_nf.nm_razao_social
			End If


	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
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
		
	Case "nm_conveniado_de"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_conveniado_nf.nm_conveniado Then
				Return 1
			End If	
		Else			
			ivo_conveniado_nf.Of_Inicializa()
			
			This.Object.nm_conveniado_de	[1] = ivo_conveniado_nf.nm_conveniado
			This.Object.cd_conveniado_de	[1] = ivo_conveniado_nf.cd_conveniado
			
		End If	
		
	Case "nm_cliente_de"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cliente_nf.nm_cliente Then
				Return 1
			End If	
		Else			
			ivo_cliente_nf.Of_Inicializa()
			
			This.Object.nm_cliente_de	[1] = ivo_cliente_nf.nm_cliente
			This.Object.cd_cliente_de	[1] = ivo_cliente_nf.cd_cliente
			
		End If	
		
	Case "nm_convenio_de"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_convenio_nf.nm_razao_social Then
				Return 1
			End If	
		Else			
			ivo_convenio_nf.Of_Inicializa()
			
			This.Object.nm_convenio_de[1] = ivo_convenio_nf.nm_razao_social
			This.Object.cd_convenio_de	[1] = ivo_convenio_nf.cd_convenio
			
			ivo_conveniado_nf.Of_Inicializa()
			
			This.Object.nm_conveniado_de	[1] = ivo_conveniado_nf.nm_conveniado
			This.Object.cd_conveniado_de	[1] = ivo_conveniado_nf.cd_conveniado
			
		End If	
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

If IsValid(ivo_conveniado_nf) Then 
	This.Object.nm_conveniado_de [1] = ivo_conveniado_nf.nm_conveniado
End If

If IsValid(ivo_cliente) Then 
	This.Object.nm_cliente_de [1] = ivo_cliente_nf.nm_cliente
End If

If IsValid(ivo_convenio_nf) Then 
	This.Object.nm_convenio_de [1] = ivo_convenio_nf.nm_razao_social
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge490_rel_dinamico_vendas_nf
integer y = 704
integer width = 4233
integer height = 1088
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
String lvs_Cliente_NF
String lvs_Conveniado_NF

Long lvl_Filial
Long lvl_Convenio
Long lvl_Where_Subquery = 1
Long lvl_Convenio_NF

Date lvdt_Inicio
Date lvdt_Fim

Boolean ivb_Indice = False

dw_1.Accepttext( )

lvdt_Inicio				= dw_1.Object.dt_inicio				[1]
lvdt_Fim					= dw_1.Object.dt_fim					[1]
lvl_Filial					= dw_1.Object.cd_filial				[1]
lvl_Convenio				= dw_1.Object.cd_convenio			[1]
lvs_UF_Fil				= dw_1.Object.cd_uf					[1]
lvs_Cliente				= dw_1.Object.cd_cliente			[1]
lvs_Tipo					= dw_1.Object.id_tipo_venda		[1]
lvs_Forma_Pagto		= dw_1.Object.cd_forma_pagto	[1]
lvs_Especie				= dw_1.Object.de_especie			[1]
lvs_Anexa				= dw_1.Object.id_anexa				[1]
lvs_Conveniado			= dw_1.Object.cd_conveniado		[1]
lvs_Situacao				= dw_1.Object.id_situacao			[1]
lvs_Tipo_Desc			= dw_1.Object.id_tipo_desconto	[1]
lvs_Lib_Senha			= dw_1.Object.id_lib_senha			[1]
lvs_Lib_Restr			= dw_1.Object.id_lib_restricao		[1]
lvs_Lib_Bloq				= dw_1.Object.id_lib_bloqueio		[1]
lvs_Cliente_NF			= dw_1.Object.cd_cliente_de		[1]
lvl_Convenio_NF		= dw_1.Object.cd_convenio_de	[1]
lvs_Conveniado_NF	= dw_1.Object.cd_conveniado_de	[1]

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
	This.Of_AppendWhere("n.cd_convenio="+String(lvl_Convenio))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Conv$$HEX1$$ea00$$ENDHEX$$nio Atual: '+ivo_convenio.nm_razao_social+' ('+String(lvl_Convenio)+')'

	If (Not IsNull(lvs_Conveniado)) and (Trim(lvs_Conveniado) <> '') Then
		This.Of_AppendWhere("n.cd_conveniado='"+String(lvs_Conveniado)+"'")
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Conveniado Atual: '+ivo_conveniado.nm_conveniado+' ('+String(lvs_Conveniado)+')'		
	End If
	
	ivb_Indice = True
End If

If Not IsNull(lvl_Convenio_NF) and (lvl_Convenio_NF > 0) Then
	This.Of_AppendWhere("coalesce(nva.cd_convenio_de, n.cd_convenio)="+String(lvl_Convenio_NF))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Conv$$HEX1$$ea00$$ENDHEX$$nio NF: '+ivo_convenio_nf.nm_razao_social+' ('+String(lvl_Convenio_NF)+')'

	If (Not IsNull(lvs_Conveniado_NF)) and (Trim(lvs_Conveniado_NF) <> '') Then
		This.Of_AppendWhere("coalesce(nva.cd_conveniado_de, n.cd_conveniado)='"+String(lvs_Conveniado_NF)+"'")
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Conveniado NF: '+ivo_conveniado_nf.nm_conveniado+' ('+String(lvs_Conveniado_NF)+')'		
	End If
	
	ivb_Indice = True
End If

If lvs_UF_Fil<>'TD' Then
	This.Of_AppendWhere("cf.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If lvs_Especie<>'TD' Then
	This.Of_AppendWhere("n.de_especie='"+lvs_Especie+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Esp$$HEX1$$e900$$ENDHEX$$cie: '+dw_1.Describe("Evaluate('LookUpDisplay(de_especie)',1)")
End If

If lvs_Tipo<>'TD' Then
	This.Of_AppendWhere("coalesce(nva.id_tipo_venda_de, n.id_tipo_venda)='"+lvs_Tipo+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Venda: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_venda)',1)")
	
	If lvs_Tipo = 'CV' Then
		This.Of_AppendWhere("n.cd_convenio > 0")
	End If	
End If

If lvs_Anexa = 'N' Then
	This.Of_AppendWhere("n.nr_nf_anexa is null")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Considera Anexa: N$$HEX1$$c300$$ENDHEX$$O'
Else
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Considera Anexa: SIM'
End If

If lvs_Forma_Pagto<>'TD' Then
	This.Of_AppendWhere("n.cd_forma_pagamento='"+lvs_Forma_Pagto+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Forma Pagto: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_forma_pagto)',1)")
End If

If (Not IsNull(lvs_Cliente)) and (Trim(lvs_Cliente)<>'') Then
	This.Of_AppendWhere("n.cd_cliente='"+lvs_Cliente+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Cliente: '+ivo_cliente.nm_cliente+' ('+lvs_Cliente+')'
	
	ivb_Indice = True
End If

If (Not IsNull(lvs_Cliente_NF)) and (Trim(lvs_Cliente_NF)<>'') Then
	This.Of_AppendWhere("coalesce(nva.cd_cliente_de, n.cd_cliente)='"+lvs_Cliente_NF+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Cliente NF: '+ivo_cliente_nf.nm_cliente+' ('+lvs_Cliente_NF+')'
	
	ivb_Indice = True
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
		Case "PM"
			This.Of_AppendWhere("n.nr_matric_alteracao_preco is not null")
			This.Of_AppendWhere("exists (select 1 from item_nf_venda_desconto n1 "+ &
													" where n1.id_tipo_desconto = 'PVE' "+ &
													" and n1.cd_filial = n.cd_filial "+&
													" and n1.nr_nf = n.nr_nf "+ &
													" and n1.de_especie = n.de_especie "+&
													" and n1.de_serie = n.de_serie)")
		Case Else
			This.Of_AppendWhere("exists (select 1 from item_nf_venda_desconto n1 "+ &
													" where n1.id_tipo_desconto = '"+lvs_Tipo_Desc+"' "+ &
													" and n1.cd_filial = n.cd_filial "+&
													" and n1.nr_nf = n.nr_nf "+ &
													" and n1.de_especie = n.de_especie "+&
													" and n1.de_serie = n.de_serie)")
	End Choose
	lvl_Where_Subquery++
End If

//N$$HEX1$$e300$$ENDHEX$$o pode existir nf_alteracao menor que a retornada na query principal
This.Of_AppendWhere("(nva.nr_nf is null or not exists (select 1 from nf_venda_alteracao n1 (index idx_nota) "+ &
																	" where n1.cd_filial = n.cd_filial "+&
																	" and n1.nr_nf = n.nr_nf "+ &
																	" and n1.de_especie = n.de_especie "+&
																	" and n1.de_serie = n.de_serie "+&
																	" and n1.dh_alteracao < nva.dh_alteracao))")

If Not ivb_Indice Then
	lvs_SQL = This.GetSQLSelect( )
	lvs_SQL = gf_replace(lvs_SQL,'from nf_venda n ','from nf_venda n (index idx_data_filial) ',1)
	This.of_ChangeSQL(lvs_SQL)
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge490_rel_dinamico_vendas_nf
integer x = 1865
integer y = 784
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (Nota)"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge490_rel_dinamico_vendas_nf
integer x = 2606
integer y = 712
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge490_rel_dinamico_vendas_nf
integer x = 1143
integer y = 1120
end type

