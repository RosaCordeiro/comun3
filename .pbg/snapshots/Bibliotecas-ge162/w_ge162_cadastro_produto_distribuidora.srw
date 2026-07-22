HA$PBExportHeader$w_ge162_cadastro_produto_distribuidora.srw
forward
global type w_ge162_cadastro_produto_distribuidora from dc_w_sheet
end type
type gb_1 from groupbox within w_ge162_cadastro_produto_distribuidora
end type
type dw_1 from dc_uo_dw_base within w_ge162_cadastro_produto_distribuidora
end type
type cb_alterar from commandbutton within w_ge162_cadastro_produto_distribuidora
end type
type dw_3 from dc_uo_dw_base within w_ge162_cadastro_produto_distribuidora
end type
type st_1 from statictext within w_ge162_cadastro_produto_distribuidora
end type
type dw_2 from dc_uo_dw_base within w_ge162_cadastro_produto_distribuidora
end type
type cb_distr_bloq from commandbutton within w_ge162_cadastro_produto_distribuidora
end type
type cb_marcar from commandbutton within w_ge162_cadastro_produto_distribuidora
end type
type gb_2 from groupbox within w_ge162_cadastro_produto_distribuidora
end type
end forward

global type w_ge162_cadastro_produto_distribuidora from dc_w_sheet
string tag = "w_ge162_cadastro_produto_distribuidora"
string accessiblename = "Cadastro de Produto por Distribuidora (GE162)"
integer width = 5783
integer height = 2096
string title = "GE162 - Cadastro de Produtos por Distribuidora"
long backcolor = 80269524
event ue_retrieve ( )
gb_1 gb_1
dw_1 dw_1
cb_alterar cb_alterar
dw_3 dw_3
st_1 st_1
dw_2 dw_2
cb_distr_bloq cb_distr_bloq
cb_marcar cb_marcar
gb_2 gb_2
end type
global w_ge162_cadastro_produto_distribuidora w_ge162_cadastro_produto_distribuidora

type variables
 uo_produto ivo_produto

uo_fornecedor ivo_fornecedor

uo_ge149_comprador io_comprador

string ivs_coluna_produto[], &
         ivs_coluna_distribuidora[], &
         ivs_nome_produto[], &
         ivs_nome_distribuidora[], &
		is_Uf, &
		is_Produto, &
		is_Distribuidoras

long ivl_produto_parametro

boolean ib_valida_imposto_sap=false

boolean ivb_Check

decimal idc_limite = 99
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_insere_uf_default ()
public function boolean wf_localiza_fornecedor (ref string as_distribuidora)
public function boolean wf_verifica_parametro ()
public subroutine wf_insere_grupo_default ()
public function boolean wf_verifica_pendencia_fiscal (long pl_produto)
public function boolean wf_preco_compra_maior_preco_venda ()
public function boolean wf_verifica_prd_exclusivo_bahia (long al_produto)
public function boolean wf_busca_pc_limite_preco (string as_cd_distribuidora, long al_cd_produto, string as_cd_uf, string as_cd_grupo, string as_id_lei_generico, ref decimal adc_limite)
public function boolean wf_verifica_distribuidora_selecionada ()
public function boolean wf_produto_selecionado ()
end prototypes

event ue_retrieve();dw_2.Event ue_Retrieve()
end event

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

public function boolean wf_localiza_fornecedor (ref string as_distribuidora);String lvs_Fantasia

Select nm_fantasia
Into :lvs_Fantasia 
From fornecedor
Where cd_fornecedor =:as_Distribuidora
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_Distribuidora = lvs_Fantasia + " (" + as_Distribuidora + ")"
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor n$$HEX1$$e300$$ENDHEX$$o localizado.")
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do fornecedor")
End Choose

Return False
		


end function

public function boolean wf_verifica_parametro ();Decimal  lvdc_Juro

Select pc_juros_diario_ped_eletronico
Into :lvdc_Juro
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case Sqlca.SqlCode 
	Case 0
		If lvdc_Juro >= 0 Then
			Return True
		Else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "O percentual de juros n$$HEX1$$e300$$ENDHEX$$o pode ser negativo.", StopSign!)
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o foi localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'PC_JUROS_DIARIO_PED_ELETRONICO'")
End Choose

Return False
end function

public subroutine wf_insere_grupo_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_grupo", "0")
	lvdwc.SetItem(1, "de_grupo", "TODOS")
	
	dw_1.Object.Cd_grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Grupo.")
End If

end subroutine

public function boolean wf_verifica_pendencia_fiscal (long pl_produto);String  ls_Situacao

Select id_revisao_fiscal
Into :ls_Situacao
from produto_central
where cd_produto = :pl_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o identificador da revis$$HEX1$$e300$$ENDHEX$$o fiscal.")
	Return False
End If
			
If   (ls_Situacao = 'P')  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto possui pend$$HEX1$$ea00$$ENDHEX$$ncias fiscais.~r~rSolicite a revis$$HEX1$$e300$$ENDHEX$$o ao Departamento Central de Cadastro.", Exclamation!) 
	Return False
End If

end function

public function boolean wf_preco_compra_maior_preco_venda ();Date 		ldh_inicio_pis_cofins

Decimal	ldc_Limite
Decimal	ldc_Preco_Utili
Decimal	ldc_Desc_Utili
Decimal	ldc_Repasse_Icms
Decimal	ldc_Icms_St
Decimal	ldc_Vl_Compra
Decimal	ldc_Preco_Liqui
Decimal	ldc_Repasse
Decimal	ldc_Venda
Decimal	ldc_Resultado
Decimal	ldc_Desc_Finan
Decimal	lvdc_pc_Icms
Decimal	lvdc_pc_Icms_venda
Decimal	lvdc_pc_reducao_base_icms
Decimal	lvdc_vl_icms_venda
Decimal	lvdc_pc_promocao_desconto_finan
Decimal	lvdc_pc_desconto_acordo_sellin
Decimal	lvdc_vl_pis_venda
Decimal	lvdc_vl_cofins_venda
Decimal	lvdc_pc_pis
Decimal	lvdc_pc_cofins
Decimal	ldc_vl_icms_compra
Decimal	ldc_vl_pis_compra
Decimal	ldc_vl_cofins_compra
Decimal	lvdc_Pc_Juros
Decimal	ldc_Vl_Juros

Long	ll_Linha
Long	ll_Qt_Emb_Padrao
Long	lvl_cd_produto

String	ls_Parametro
String	ls_Retira_Bloq
String	lvs_cd_tributacao_icms
String	lvs_id_icms_normal
String	lvs_cd_uf
String	lvs_cd_distribuidora
String	lvs_cd_grupo
String	lvs_id_lei_generico
String	ls_Situacao_Pis_Cofins
String	ls_msg

dw_2.AcceptText()

If Not gf_ge162_busca_parametro_pis_cofins(Ref lvdc_pc_pis,Ref lvdc_pc_cofins,Ref ldh_inicio_pis_cofins,Ref ls_msg) Then
	Messagebox('Erro', ls_msg, stopsign!)
	Return false
End if

Select Coalesce(vl_parametro, '100')
	Into :ls_Parametro
From parametro_geral
Where cd_parametro = 'PC_LIMITE_ACEITE_PRECO_DISTRIB'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		idc_limite = Dec(ls_Parametro)
		
	Case 100
		idc_Limite = 100
		
	Case -1
		SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral 'PC_LIMITE_ACEITE_PRECO_DISTRIB'.")
		Return False
End Choose

Open(w_Aguarde)

w_aguarde.uo_progress.of_setmax(dw_2.RowCount())

For ll_Linha = 1 To dw_2.RowCount()
	
	lvs_cd_distribuidora	= dw_2.object.cd_distribuidora			[ll_linha]
	lvl_cd_produto			= dw_2.object.cd_produto				[ll_linha]
	lvs_cd_uf					= dw_2.object.cd_unidade_federacao	[ll_linha]
	lvs_cd_grupo			= dw_2.object.cd_grupo					[ll_linha]
	lvs_id_lei_generico	= dw_2.object.id_lei_generico			[ll_linha]
	
	// chamado 902727-6 - busca limite de preco da funcao f_busca_pc_limite_preco, que considera o que foi cadastrado nas novas tabelas produto_compra_bloqueio, produto_compra_desbloqueio
	if not wf_busca_pc_limite_preco(lvs_cd_distribuidora, lvl_cd_produto, lvs_cd_uf, lvs_cd_grupo, lvs_id_lei_generico, ldc_Limite ) then return false

	ldc_Preco_Utili						= dw_2.Object.Vl_Preco_Utilizado							[ll_Linha]
	ldc_Desc_Utili							= dw_2.Object.Pc_Desconto_Utilizado				[ll_Linha]
	ldc_Repasse_Icms						= dw_2.Object.Pc_Repasse_Icms						[ll_Linha]
	ldc_Icms_St								= dw_2.Object.Vl_Icms_St								[ll_Linha]
	ll_Qt_Emb_Padrao						= dw_2.Object.Qt_Embalagem_Padrao_Distrib		[ll_Linha]
	ldc_Venda								= dw_2.Object.Vl_Preco_Venda						[ll_Linha]
	ldc_Desc_Finan							= dw_2.Object.pc_desconto_financeiro				[ll_Linha]
	ls_Retira_Bloq							= dw_2.Object.Id_Retira_Bloq_Compra_Distrib		[ll_Linha]
	lvdc_pc_Icms 							= dw_2.Object.pc_icms									[ll_Linha]
	lvdc_pc_reducao_base_icms		= dw_2.Object.pc_reducao_base_icms				[ll_Linha]
	lvdc_pc_Icms_venda					= dw_2.Object.pc_Icms_venda							[ll_Linha]
	lvs_cd_tributacao_icms				= dw_2.Object.cd_tributacao_icms					[ll_Linha]
	lvs_id_icms_normal 					= dw_2.Object.id_icms_normal							[ll_Linha]
	lvdc_pc_promocao_desconto_finan	= dw_2.Object.pc_promocao_desconto_finan	[ll_Linha]
	lvdc_pc_desconto_acordo_sellin	= dw_2.Object.pc_desconto_acordo_sellin			[ll_Linha]
	ls_Situacao_Pis_Cofins				= dw_2.Object.id_situacao_pis_cofins				[ll_Linha]
	lvdc_Pc_Juros							= dw_2.Object.pc_juros									[ll_Linha]
	
	lvdc_vl_icms_venda	= 0
	ldc_vl_pis_compra		= 0
	ldc_vl_cofins_compra	= 0
	
	//Para mostrar o repasse na planilha
	dw_2.Object.Vl_Repasse_Plan[ll_Linha]		= dw_2.Object.Vl_Repasse[ll_Linha]
	
	dw_2.Object.Vl_Compra_Plan[ll_Linha] 		= dw_2.Object.Vl_Compra[ll_Linha]
	
	ldc_Preco_Liqui	= Round(ldc_Preco_Utili * ((100 - ldc_Desc_Utili) / 100), 2)

	ldc_Repasse			= Round(ldc_Preco_Liqui * (ldc_Repasse_Icms / 100), 2)
	
	ldc_Vl_Compra		=  ldc_Preco_Liqui - ldc_Repasse
	
	
	// chamado 900895 - no caso dos produtos tributados integralmente (cd_tributacao <> 1 e id_icms_normal = S), abate ICMS do preco de compra para fazer o calculo do bloqueio
	if lvs_cd_tributacao_icms <> '1' And lvs_id_icms_normal = 'S' then
		ldc_vl_icms_compra	= Round(ldc_Vl_Compra * (( (lvdc_pc_icms * (100 - lvdc_pc_reducao_base_icms) / 100)) / 100), 2)
				
		// para os tributados integralmente, o valor do ICMS de venda ser$$HEX1$$e100$$ENDHEX$$ somado ao pre$$HEX1$$e700$$ENDHEX$$o de compra 
		lvdc_vl_icms_venda	= Round(ldc_venda * lvdc_pc_Icms_venda / 100, 2)		
	else
		ldc_vl_icms_compra = 0
	end if
	
	If	ls_Situacao_Pis_Cofins = 'T' and Date(gf_GetServerDate()) >= ldh_inicio_pis_cofins Then
		lvdc_vl_pis_venda		= Round(ldc_venda * lvdc_pc_pis / 100, 2)
		lvdc_vl_cofins_venda	= Round(ldc_venda * lvdc_pc_cofins / 100, 2)
		
		ldc_vl_pis_compra		= Round(ldc_Vl_Compra * (lvdc_pc_pis / 100), 2)
		ldc_vl_cofins_compra	= Round(ldc_Vl_Compra * (lvdc_pc_cofins / 100), 2)
	End if
	
	ldc_Vl_Compra = Round(ldc_Vl_Compra - (ldc_vl_pis_compra + ldc_vl_cofins_compra + ldc_vl_icms_compra),2)
		
	// 902727-5 - aplica promocao de desconto financeiro
	ldc_Vl_Compra = Round(ldc_Vl_Compra * ((100 - lvdc_pc_promocao_desconto_finan) / 100), 2)
	
	ldc_Vl_Compra = round(ldc_Vl_Compra * ((100 - ldc_Desc_Finan) / 100), 2)
	
	// 902727-25 - Considerar desconto Sell-In
	ldc_Vl_Compra = Round(ldc_Vl_Compra * ((100 - lvdc_pc_desconto_acordo_sellin) / 100), 2)
	
	// Somar a ST apenas depois do desconto do fornecedor, assim como no pedido.
	If lvs_cd_tributacao_icms = '1' Then
		ldc_Vl_Compra = ldc_Vl_Compra + ldc_Icms_St
	End If
	
	ldc_Vl_Juros	= Round(ldc_Vl_Compra * (lvdc_Pc_Juros / 100), 2)	
	ldc_Vl_Compra	= round((ldc_Vl_Compra) / ll_Qt_Emb_Padrao, 2)
				
	If ldc_Venda > 0 Then
		// o resultado eh o quanto, em termos percentuais, o pre$$HEX1$$e700$$ENDHEX$$o de compra + valor ICMS venda (este considerado apenas para tributados integralmente) representam em rela$$HEX2$$e700e300$$ENDHEX$$o ao pre$$HEX1$$e700$$ENDHEX$$o de venda
		// nao podendo ultrapassar o percentual cadastrado no parametro PC_LIMITE_ACEITE_PRECO_DISTRIB
		If Date(gf_GetServerDate()) >= ldh_inicio_pis_cofins Then
			ldc_Resultado = Round(((ldc_Vl_Compra + lvdc_vl_icms_venda + lvdc_vl_pis_venda + lvdc_vl_cofins_venda) / ldc_Venda) * 100, 2)
		else
			ldc_Resultado = Round(((ldc_Vl_Compra + lvdc_vl_icms_venda) / ldc_Venda) * 100, 2)
		end if
			
	Else
		ldc_Resultado = 100
	End If
	
	// se funcao wf_busca_pc_limite_preco retornou limite nulo, significa que ha uma configuracao de desbloqueio, portanto desconsidera qualquer limite de pre$$HEX1$$e700$$ENDHEX$$o, inclusive o limite geral de 93%
	if not isnull(ldc_Limite) then
		If ldc_Resultado >= ldc_Limite Then
			If ls_Retira_Bloq = "N"Then
				dw_2.Modify("p_2.Tooltip.Tip='O pre$$HEX1$$e700$$ENDHEX$$o de compra $$HEX1$$e900$$ENDHEX$$ superior a " + String(ldc_Limite)  + "% do valor de venda'")
				dw_2.Object.Id_Legenda[ll_Linha] = 'S'
			Else
				dw_2.Object.Id_Legenda[ll_Linha] = 'N'
			End If
		End If
	else
		dw_2.Object.Id_Legenda[ll_Linha] = 'N'
	end if
	
	dw_2.object.vl_preco_compra_calculo_bloq		[ll_Linha]	= ldc_Vl_Compra
	dw_2.object.vl_preco_venda_calculo_bloq		[ll_Linha]	= ldc_Venda
	dw_2.object.vl_icms_venda_calculo_bloq			[ll_Linha]	= lvdc_vl_icms_venda
	dw_2.object.vl_pis_venda_calculo_bloq			[ll_Linha]	= lvdc_vl_pis_venda
	dw_2.object.vl_cofins_venda_calculo_bloq		[ll_Linha]	= lvdc_vl_cofins_venda
	dw_2.object.vl_pis_compra_calculo_bloq			[ll_Linha]	= ldc_vl_pis_compra
	dw_2.object.vl_cofins_compra_calculo_bloq		[ll_Linha]	= ldc_vl_cofins_compra
	dw_2.object.pc_margem								[ll_Linha]	= 100 - ldc_Resultado
	dw_2.object.vl_compra								[ll_Linha]	= ldc_Vl_Compra - ldc_Vl_Juros
	dw_2.object.vl_juros_compra						[ll_Linha]	= ldc_Vl_Juros
	
	w_Aguarde.Title = "Verificando pre$$HEX1$$e700$$ENDHEX$$o maior que da CLAMED. Aguarde... Registro " + String(ll_Linha) + " de " + String(dw_2.RowCount())
	w_aguarde.uo_progress.of_setprogress(ll_Linha)
Next

Close(w_Aguarde)

Return True
end function

public function boolean wf_verifica_prd_exclusivo_bahia (long al_produto);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From produto_central
Where cd_produto = :al_Produto
	and id_exclusivo_pedido_falta_ba = 'S'
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o produto exclusivo.")
	Return False
End If
	
If ll_Achou > 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto possui exclusividade para atender as faltas da Bahia.~r"+&
				"O produto deve ser removido da lista de exclusividade para que possa ser ATIVADO.", Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_busca_pc_limite_preco (string as_cd_distribuidora, long al_cd_produto, string as_cd_uf, string as_cd_grupo, string as_id_lei_generico, ref decimal adc_limite);string 	lvs_id_rede_filial, &
			lvs_msg_Erro

long		lvl_cd_desbloqueio, &
			lvl_cd_bloqueio

setnull(lvs_id_rede_filial)

if not f_ge568_busca_dados_desbloqueio(al_cd_produto, as_cd_Distribuidora, as_cd_uf, lvs_id_rede_filial, lvl_cd_desbloqueio, lvs_msg_Erro) then 
	Messagebox('Erro', lvs_msg_erro, stopsign!)
	return false
end if

// se tem configuracao de desbloqueio, entao ignora qualquer setup de bloqueio, seja o geral da tabela parametro_geral ou o restritivo da tabela produto_compra_bloqueio
if not isnull(lvl_cd_desbloqueio) and lvl_cd_desbloqueio > 0 then
	setnull(adc_limite)
	return true
end if

// Testa para a rede PP
if not f_ge568_busca_dados_desbloqueio(al_cd_produto, as_cd_Distribuidora, as_cd_uf, 'PP', lvl_cd_desbloqueio, lvs_msg_Erro) then 
	Messagebox('Erro', lvs_msg_erro, stopsign!)
	return false
end if

// se tem configuracao de desbloqueio, entao ignora qualquer setup de bloqueio, seja o geral da tabela parametro_geral ou o restritivo da tabela produto_compra_bloqueio
if not isnull(lvl_cd_desbloqueio) and lvl_cd_desbloqueio > 0 then
	setnull(adc_limite)
	return true
end if

// Testa para a rede DC
if not f_ge568_busca_dados_desbloqueio(al_cd_produto, as_cd_Distribuidora, as_cd_uf, 'DC', lvl_cd_desbloqueio, lvs_msg_Erro) then 
	Messagebox('Erro', lvs_msg_erro, stopsign!)
	return false
end if

// se tem configuracao de desbloqueio, entao ignora qualquer setup de bloqueio, seja o geral da tabela parametro_geral ou o restritivo da tabela produto_compra_bloqueio
if not isnull(lvl_cd_desbloqueio) and lvl_cd_desbloqueio > 0 then
	setnull(adc_limite)
	return true
end if

if not f_ge568_busca_dados_bloqueio(al_cd_produto, as_cd_grupo, as_cd_uf, lvs_id_rede_filial, as_id_lei_generico, lvl_cd_bloqueio, adc_limite, lvs_msg_Erro) then 
	Messagebox('Erro', lvs_msg_erro, stopsign!)
	return false
end if

if isnull(adc_limite) then
	adc_limite = idc_limite
end if

return true
end function

public function boolean wf_verifica_distribuidora_selecionada ();Integer lvi_Find

lvi_Find = dw_2.Find("id_selecionada = 'S'", 1, dw_2.RowCount())

If lvi_Find < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
	Return False
End If

Return True
end function

public function boolean wf_produto_selecionado ();Long lvl_Linha

lvl_Linha = dw_1.Find("id_selecionada = 'S'", 1, dw_1.RowCount())

If lvl_Linha > 0 Then
	Return True
Else
	Return False
End If
end function

on w_ge162_cadastro_produto_distribuidora.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_alterar=create cb_alterar
this.dw_3=create dw_3
this.st_1=create st_1
this.dw_2=create dw_2
this.cb_distr_bloq=create cb_distr_bloq
this.cb_marcar=create cb_marcar
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_alterar
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.cb_distr_bloq
this.Control[iCurrent+8]=this.cb_marcar
this.Control[iCurrent+9]=this.gb_2
end on

on w_ge162_cadastro_produto_distribuidora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_alterar)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.cb_distr_bloq)
destroy(this.cb_marcar)
destroy(this.gb_2)
end on

event open;call super::open;String lvs_Parametro

ivo_Produto 		= Create uo_Produto
ivo_Fornecedor = Create uo_Fornecedor
io_comprador	= Create uo_ge149_comprador

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)

lvs_Parametro = Message.StringParm

is_Uf = MidA(lvs_Parametro, 7, 2)

If Trim(lvs_Parametro) <> "" Then
	ivl_Produto_Parametro = Long(MidA(lvs_Parametro, 1, 6))
End If
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Fornecedor)
Destroy(io_comprador)
end event

event ue_postopen;call super::ue_postopen;string ls_data_imp_sap
datetime ldt_atual

dw_1.Event ue_AddRow()

ivm_Menu.mf_Recuperar(True)

wf_Insere_Distribuidora_Default()

wf_Insere_UF_Default()

wf_Insere_Grupo_Default()

If is_Uf = "SC" Then
	dw_1.Object.Cd_Uf[1] = is_Uf
End If

If Not IsNull(ivl_Produto_Parametro) and ivl_Produto_Parametro <> 0 Then
	ivo_Produto.of_Localiza_Codigo_Interno(ivl_Produto_Parametro)
	
	If ivo_Produto.Localizado Then
		dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
		dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		
		dw_2.Event ue_Retrieve()
	End If
End If

ivm_Menu.ivb_Permite_Imprimir = True

If gb_2.Text = "Lista de Distribuidoras" Then
	dw_1.Object.Id_Planilha.Visible = False
Else
	dw_1.Object.Id_Planilha.Visible = True
End If

gf_ge003_lista_divisao_fornecedor(dw_1, "", 1)

ldt_atual = gf_getserverdate()

Select vl_parametro
into :ls_data_imp_sap
from parametro_geral
where cd_parametro = 'DH_INICIO_SAP_REGISTRO_INFO';

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar a tabela "parametro_geral": ' + sqlca.sqlerrtext)
	return 
end if

if not isnull(ls_data_imp_sap) and ls_data_imp_sap <> '' Then
	
	if date(ldt_atual) >= date(ls_data_imp_sap) Then
		ib_valida_imposto_sap = True
	end if
	
end if


end event

event ue_cancel;call super::ue_cancel;If dw_2.RowCount() > 0 Then
	dw_2.Event ue_Retrieve()
Else
	dw_1.Event ue_Reset()
	dw_2.Event ue_Reset()
	
	dw_1.Event ue_AddRow()
End If

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	dw_2.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

event ue_print;call super::ue_print;dw_2.SetFocus()

dw_2.Event ue_Printimmediate()
end event

event ue_printimmediate;call super::ue_printimmediate;dw_2.SetFocus()

dw_2.Event ue_Printimmediate()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge162_cadastro_produto_distribuidora
integer y = 1268
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge162_cadastro_produto_distribuidora
integer y = 1196
end type

type gb_1 from groupbox within w_ge162_cadastro_produto_distribuidora
integer x = 14
integer width = 5705
integer height = 484
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Par$$HEX1$$e200$$ENDHEX$$metros de Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge162_cadastro_produto_distribuidora
integer x = 41
integer y = 64
integer width = 5650
integer height = 404
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge162_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()

dw_2.Object.st_de_alteracao.Text = ""
dw_2.Object.Sit_Clamed_t.Text = ""

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
		If IsNull(dw_1.Object.Cd_Produto[1]) Then
			dw_1.Object.Id_Planilha.Visible = True
		Else
			dw_1.Object.Id_Planilha.Visible = False
		End If
		
	Case "cd_distribuidora"
		If IsNull(dw_1.Object.Cd_Produto[1]) Then
			If Data <> "000000000" Then
				dw_1.Object.Id_Planilha.Visible = True
				
				dw_1.Object.Id_Seleciona_Distrib[1] = "N"
				is_Distribuidoras = ""
			End If
		End If
		
		If Data <> "000000000" Then
			dw_1.Object.Id_Homologacao.Visible = False
		Else
			dw_1.Object.Id_Homologacao.Visible = True
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_comprador.of_Inicializa()
				
			This.Object.nr_matricula	[1] = io_comprador.nr_matricula
			This.Object.nm_usuario  [1] = io_comprador.nm_usuario
		End If
End Choose

If dwo.Name = "de_produto" Then
	If IsNull(dw_1.Object.Cd_Produto[1]) Then
		If Data <> "000000000" Then
			dw_1.Object.Id_Planilha.Visible = True
		End If
	End If
End If
end event

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Long ll_Nulo

String ls_Nulo

SetNull(ll_Nulo)
SetNull(ls_Nulo)

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "cd_distribuidora"
		If IsNull(dw_1.Object.Cd_Produto[1]) Then
			If Data <> "000000000" Then
				dw_1.Object.Id_Planilha.Visible = True
				
				dw_1.Object.Id_Seleciona_Distrib[1] = "N"
				is_Distribuidoras = ""
			End If
		End If
		
		If Data <> "000000000" Then
			dw_1.Object.Id_Homologacao.Visible = False
		Else
			dw_1.Object.Id_Homologacao.Visible = True
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_comprador.of_Inicializa()
				
			This.Object.nr_matricula	[1] = io_comprador.nr_matricula
			This.Object.nm_usuario  [1] = io_comprador.nm_usuario
		End If
		
	Case "id_planilha"
		If Data = "S" Then
			OpenWithParm(w_ge162_filtro_via_planilha, '')
			
			is_Produto = Message.StringParm
			
			If Trim(is_Produto) = "" Or IsNull(is_Produto) Then
				Return 1
			End If
					
			dw_1.Object.De_Produto[1] = ls_Nulo
			dw_1.Object.Cd_Produto[1] = ll_Nulo
			
		Else
			is_Produto = ""
		End If
		
		Case "id_seleciona_distrib"
			If Data = "S" Then
				OpenWithParm(w_ge162_selecao_distribuidoras, "")
				
				is_Distribuidoras = Message.StringParm
				
				If Trim(is_Distribuidoras) = "" Or IsNull(is_Distribuidoras) Then
					Return 1
				End If
				
				dw_1.Object.Cd_Distribuidora[1] = "000000000"
				
			Else
				is_Distribuidoras = ""
			End If
			
End Choose
end event

event losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

event ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				
				dw_1.Object.Id_Planilha[1] = "N"
				dw_1.Object.Id_Planilha.Visible = False
				is_Produto = ""
			End If
		
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
			End If
			
			gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
			
		Case "nm_usuario"
			io_comprador.of_Localiza_comprador( This.GetText() )
		
			If io_comprador.Localizado Then
				This.Object.nr_matricula	[1] = io_comprador.nr_matricula
				This.Object.nm_usuario  [1] = io_comprador.nm_usuario
			End If
		Case "de_categoria"
	End Choose
End If

// Se a janela foi acionada pela CO040 e se foi pressionado o ESC fecha a janela
If Not IsNull(ivl_Produto_Parametro) and ivl_Produto_Parametro > 0 Then
	If Key = KeyEscape! Then
		Close(Parent)
	End If
End If
end event

event ue_saveas;//override
dw_3.Event ue_SaveAs()
end event

type cb_alterar from commandbutton within w_ge162_cadastro_produto_distribuidora
integer x = 5161
integer y = 1792
integer width = 544
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Alterar Produto..."
end type

event clicked;Decimal ldc_Vl_Compra
Decimal ldc_Preco_Liqui
Decimal ldc_Preco_Utili
Decimal ldc_Desc_Utili
Decimal ldc_Repasse
Decimal ldc_Repasse_Icms
Decimal ldc_Icms_St

Long lvl_Linha
Long lvl_Produto
Long ll_Qt_Emb_Padrao

String lvs_Distribuidora
String lvs_UF

dw_2.AcceptText()

lvl_Linha = dw_2.GetRow()

If lvl_Linha <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para alterar.")
	Return
End If

lvs_Distribuidora	= dw_2.Object.Cd_Distribuidora    				[lvl_Linha]
lvl_Produto       	= dw_2.Object.Cd_Produto							[lvl_Linha]
lvs_UF           		= dw_2.Object.Cd_Unidade_Federacao			[lvl_Linha]
ldc_Preco_Utili		= dw_2.Object.Vl_Preco_Utilizado					[lvl_Linha]
ldc_Desc_Utili		= dw_2.Object.Pc_Desconto_Utilizado			[lvl_Linha]
ldc_Repasse_Icms	= dw_2.Object.Pc_Repasse_Icms					[lvl_Linha]
ldc_Icms_St			= dw_2.Object.Vl_Icms_St							[lvl_Linha]
ll_Qt_Emb_Padrao	= dw_2.Object.Qt_Embalagem_Padrao_Distrib	[lvl_Linha]

ldc_Preco_Liqui = Round(ldc_Preco_Utili * ((100 - ldc_Desc_Utili) / 100), 2)

ldc_Repasse = Round(ldc_Preco_Liqui * (ldc_Repasse_Icms / 100), 2)

ldc_Vl_Compra = Round(((ldc_Preco_Liqui - ldc_Repasse) + ldc_Icms_St) / ll_Qt_Emb_Padrao, 2)

OpenWithParm(w_ge162_Inclusao_Alteracao_Produto, lvs_Distribuidora + String(lvl_Produto, "000000") + lvs_UF + String((ldc_Preco_Liqui - ldc_Repasse) + ldc_Icms_St))

If Message.StringParm = "S" Then
	dw_2.Event ue_Retrieve()
End If
end event

type dw_3 from dc_uo_dw_base within w_ge162_cadastro_produto_distribuidora
boolean visible = false
integer x = 1847
integer y = 1124
integer width = 411
integer height = 272
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge162_lista_produto_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;// OverRide
String lvs_Distribuidora,&
	   lvs_UF,&
	   lvs_Descricao,&
	   lvs_Nome,&
	   lvs_Fornecedor

Long lvl_Produto

dw_1.AcceptText()

lvs_Distribuidora = dw_1.Object.cd_distribuidora	[1]
lvs_UF			  = dw_1.Object.cd_uf				[1]
lvl_Produto		  = dw_1.Object.cd_produto			[1]
lvs_Descricao     = dw_1.Object.de_produto			[1]
lvs_Fornecedor	  = dw_1.Object.cd_fornecedor 	[1]
lvs_Nome		  = dw_1.Object.nm_fornecedor	[1]

If lvs_Distribuidora <> "000000000" Then
	
	If Not wf_Localiza_Fornecedor(Ref lvs_Distribuidora) Then Return -1
	
	This.Object.st_distribuidora.text = lvs_Distribuidora
Else
	This.Object.st_distribuidora.text = "TODAS"
End If

If lvs_UF = 'XX' Then
	This.Object.st_uf.text = "TODAS"
Else
	This.Object.st_uf.text = lvs_UF
End If

If Not IsNull(lvl_Produto) Then
	This.Object.st_produto.text = lvs_Descricao + " (" + String(lvl_Produto) + ")"
End If

If Not IsNull(lvs_Fornecedor) Then
	This.Object.st_fornecedor.text = lvs_Nome + " (" + lvs_Fornecedor + ")"
End If

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type st_1 from statictext within w_ge162_cadastro_produto_distribuidora
integer x = 41
integer y = 1808
integer width = 3328
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "SIT. ~"E~" -  $$HEX1$$c900$$ENDHEX$$ QUANDO O PRODUTO FOI REIMPORTADO AP$$HEX1$$d300$$ENDHEX$$S SER CORRIGIDA A DIVERG$$HEX1$$ca00$$ENDHEX$$NCIA DE RELACIONAMENTO"
boolean focusrectangle = false
end type

type dw_2 from dc_uo_dw_base within w_ge162_cadastro_produto_distribuidora
event cliked pbm_bnclicked
integer x = 41
integer y = 544
integer width = 5650
integer height = 1196
integer taborder = 40
string dataobject = "dw_ge162_lista_distribuidora"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event cliked;//String	lvs_Marcar
//Integer	lvi_linha
//
//If 	This.text	=	"&Marcar Todas" Then
//	This.text	=	"&Marcar Todas"
//	lvs_Marcar	=	"S"
//Else
//	This.text	=	"&Marcar Todas"
//	lvs_Marcar	=	"N"
//End if

//For	lvi_linha	=	1	To dw_2.RowCount()
//	dw_2.Object.id_selecionada[lvi_Linha]	=	lvs_Marcar
//Next
end event

event ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto
Long ll_Divisao

String lvs_Distribuidora
String lvs_Situacao
String lvs_Fornecedor
String lvs_Produto_Distribuidora
String lvs_DW
String lvs_DW3
String lvs_UF
String lvs_grupo
String lvs_Comprador
String lvs_Situacao_Clamed
String ls_Sit
String ls_Planilha
String ls_Homologacao
String lvs_Coluna[]
String lvs_Nome[]
String ls_Tipo_Preco
String ls_de_categoria
long	 lvl_nr_dias_variacao_preco

dw_1.AcceptText()

lvs_Distribuidora					= dw_1.Object.Cd_Distribuidora        			[1]
lvl_Produto							= dw_1.Object.Cd_Produto              			[1]
lvs_Fornecedor						= dw_1.Object.Cd_Fornecedor           			[1]
lvs_Situacao						= dw_1.Object.Id_Situacao             			[1]
lvs_Produto_Distribuidora 		= dw_1.Object.Cd_Produto_Distribuidora			[1]
lvs_UF                    		= dw_1.Object.Cd_UF                   			[1]
lvs_Grupo                 		= dw_1.Object.Cd_grupo                			[1]
lvs_Comprador						= dw_1.Object.nr_matricula              		[1]
lvs_Situacao_Clamed				= dw_1.Object.Id_Situacao_clamed       		[1]
ls_Planilha							= dw_1.Object.Id_Planilha							[1]
ls_Homologacao						= dw_1.Object.Id_Homologacao						[1]
ll_Divisao							= dw_1.Object.Nr_Divisao_Fornecedor				[1]
ls_Tipo_Preco						= dw_1.Object.Id_Tipo_Preco						[1]
lvl_nr_dias_variacao_preco		= dw_1.Object.nr_dias_variacao_preco			[1]
ls_de_categoria					= dw_1.Object.de_categoria							[1]

If is_Produto = "" And is_Distribuidoras = "" Then
	If (IsNull(lvs_Distribuidora) Or lvs_Distribuidora = "000000000") And (lvs_UF = "XX") And (lvs_Situacao = "T") And (IsNull(lvl_Produto) or lvl_Produto = 0) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora ou a UF ou a situa$$HEX2$$e700e300$$ENDHEX$$o na distribuidora ou o produto.")
		dw_1.Event ue_Pos(1, "cd_distribuidora")
		Return -1
	End If
	
	If (IsNull(lvs_Distribuidora) Or lvs_Distribuidora = "000000000") And (lvs_UF = "XX") And (lvs_Situacao = "A" Or lvs_Situacao = "B" Or lvs_Situacao = "P") And (IsNull(lvl_Produto) or lvl_Produto = 0)Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Com os par$$HEX1$$e200$$ENDHEX$$metros selecionados este relat$$HEX1$$f300$$ENDHEX$$rio pode demorar at$$HEX1$$e900$$ENDHEX$$ 10 minutos para terminar sua execu$$HEX2$$e700e300$$ENDHEX$$o." + &
						"~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return -1
	End If
End If

// chamado 902727-7 - novo filtro para definir o numero de dias que sera utilizado para o calculo da variacao de pre$$HEX1$$e700$$ENDHEX$$o
if isnull(lvl_nr_dias_variacao_preco) or lvl_nr_dias_variacao_preco = 0 then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o n$$HEX1$$fa00$$ENDHEX$$mero de dias para varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o para continuar.")
	dw_1.Event ue_Pos(1, "nr_dias_variacao_preco")
	Return -1
end if

If Not wf_Verifica_Parametro() Then Return -1

If IsNull(lvl_Produto) Or lvl_Produto = 0 Then
	lvs_DW  = "dw_ge162_lista_produto"
	lvs_DW3 = "dw_ge162_lista_produto_relatorio"
		
	gb_2.Text = "Lista de Produtos"
	
	lvs_Coluna = ivs_Coluna_Produto
	lvs_Nome   = ivs_Nome_Produto
Else
	lvs_DW  = "dw_ge162_lista_distribuidora"
	lvs_DW3 = "dw_ge162_lista_distribuidora_relatorio"
		
	gb_2.Text = "Lista de Distribuidoras"
	
	lvs_Coluna = ivs_Coluna_Distribuidora
	lvs_Nome   = ivs_Nome_Distribuidora
End If

If This.DataObject <> lvs_DW Then
	If Not This.of_ChangeDataObject(lvs_DW) Then Return -1

	This.of_SetSort(lvs_Coluna, lvs_Nome)
	This.of_SetFilter(lvs_Coluna, lvs_Nome)
	
	This.of_SetRowSelection()
End If

If dw_3.DataObject <> lvs_DW3 Then
	If Not dw_3.of_ChangeDataObject(lvs_DW3) Then	Return -1

	dw_3.of_SetSort(lvs_Coluna, lvs_Nome)
	dw_3.of_SetFilter(lvs_Coluna, lvs_Nome)
End If

This.ShareData (dw_3)
This.GroupCalc()

If is_Distribuidoras = "" Then
	If Not IsNull(lvs_Distribuidora) and lvs_Distribuidora <> "000000000" Then
		This.of_AppendWhere_SubQuery("d.cd_distribuidora = '" + lvs_Distribuidora + "'", 15)
	End If
	
Else
	This.of_AppendWhere_SubQuery("d.cd_distribuidora in (" + is_Distribuidoras + ")", 15)
End If

If is_Produto = "" Then
	If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
		This.of_AppendWhere_SubQuery("d.cd_produto = " + String(lvl_Produto), 15)
	End If
	
	If Not IsNull(lvs_Produto_Distribuidora) and Trim(lvs_Produto_Distribuidora) <> "" Then
		This.of_AppendWhere_SubQuery("d.cd_produto_distribuidora = '" + lvs_Produto_Distribuidora + "'", 15)
	End If
Else
	This.of_AppendWhere_SubQuery("d.cd_produto in (" + is_Produto + ")", 15)
End If

If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
	This.of_AppendWhere_SubQuery("g.cd_fornecedor_usual = '" + lvs_Fornecedor + "'", 15)
End If

//Matricula Comprador
If Not IsNull( lvs_Comprador ) Then
	This.of_AppendWhere_SubQuery("c.nr_matricula_comprador = '" + lvs_Comprador + "'", 15)
End If

If lvs_Situacao <> "T" Then
	If lvs_Situacao = "B" Then
		This.of_AppendWhere_SubQuery("d.id_situacao in ('B', 'D') ", 15)
	Else
		This.of_AppendWhere_SubQuery("d.id_situacao = '" + lvs_Situacao + "'", 15)
	End If
End If

If lvs_Situacao_Clamed <> "T" Then
	This.of_AppendWhere_SubQuery("g.id_situacao = '" + lvs_Situacao_Clamed + "'", 15)
End If

If Not IsNull(lvs_grupo) and Trim(lvs_grupo) <> "0" Then
	This.of_AppendWhere_SubQuery("substring(g.cd_subcategoria, 1, 1) = '" + lvs_grupo + "'", 15)
End If

If Not IsNull(lvs_UF) and Trim(lvs_UF) <> "XX" Then
	This.of_AppendWhere_SubQuery("d.cd_unidade_federacao = '" + lvs_UF + "'", 15)
End If

If Not ISnull(ls_de_categoria) and ls_de_categoria <> '' Then
	This.of_AppendWhere_SubQuery("ca.de_categoria like '%"+ ls_de_categoria +"%'", 15)
End If

//$$HEX1$$c900$$ENDHEX$$ Feita novamente a valida$$HEX2$$e700e300$$ENDHEX$$o do preenchimento do produto aqui, porque nesse momento dw j$$HEX1$$e100$$ENDHEX$$ foi alterada (of_changedataobject)
If IsNull(lvl_Produto) Or lvl_Produto = 0 Then
	dw_2.Object.Sit_Clamed_t.Text = ""
Else	
	Choose Case ivo_Produto.Id_Situacao
		Case "A"
			ls_Sit = "ATIVO"
		Case "P"
			ls_Sit = "PENDENTE"
		Case "I"
			ls_Sit = "INATIVO"
	End Choose
	
	dw_2.Object.Sit_Clamed_t.Text = "Situa$$HEX2$$e700e300$$ENDHEX$$o CLAMED: " + ls_Sit
End If

If lvs_Distribuidora = "000000000" Then
	If ls_Homologacao = "N" Then
		This.of_AppendWhere_SubQuery("uf.id_homologando_pedido= 'N'", 15)
	End If
End If

Choose Case ls_Tipo_Preco
	Case "T" //Todos
		
	Case "M" //Maior que zero
		This.of_AppendWhere_SubQuery("Coalesce(d.vl_preco_novo, d.vl_preco_atual) > 0.00", 15)
		
	Case "I" //Igual a zero
		This.of_AppendWhere_SubQuery("Coalesce(d.vl_preco_novo, d.vl_preco_atual) = 0.00", 15)
End Choose

// joguei a divisao para ser adicionado por ultimo para nao criar problema com nenhum of_appendwhere_subquery que venha depois, pois este filtro adiciona um novo where
If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	This.of_appendwhere_subquery("d.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 15)
End If

Return 1
end event

event constructor;call super::constructor;This.of_SetRowSelection()

ivs_Coluna_Produto = {"cd_produto", &
                      			 "de_produto", &
							 "cd_unidade_federacao", &
							 "cd_produto_distribuidora", &
							 "vl_preco_atual", &
							 "pc_desconto_atual", &
							 "vl_preco_liquido", &
							 "vl_preco_compra", &
							 "id_situacao"}
							 
ivs_Nome_Produto = {"C$$HEX1$$f300$$ENDHEX$$digo", &
						  "Descri$$HEX2$$e700e300$$ENDHEX$$o", &
						  "U.F.", &
						  "C$$HEX1$$f300$$ENDHEX$$digo na Distribuidora", &
						  "Pre$$HEX1$$e700$$ENDHEX$$o Bruto", &
						  "Desconto", &
						  "Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido", &
						  "Pr$$HEX1$$e700$$ENDHEX$$ Compra", &
						  "Situa$$HEX2$$e700e300$$ENDHEX$$o"}							 
						  
ivs_Coluna_Distribuidora = {"cd_distribuidora", &
									 "nm_razao_distribuidora", &
									 "cd_unidade_federacao", &
									 "nr_prioridade_distribuicao", &
									 "cd_produto_distribuidora", &
									 "vl_preco_atual", &
									 "pc_desconto_atual", &
									 "vl_preco_liquido", &
									 "vl_preco_compra", &
									 "id_situacao"}
							 
ivs_Nome_Distribuidora = {"C$$HEX1$$f300$$ENDHEX$$digo", &
								  "Raz$$HEX1$$e300$$ENDHEX$$o Social", &
								  "U.F.", &
								  "Prioridade Distribui$$HEX2$$e700e300$$ENDHEX$$o", &
								  "C$$HEX1$$f300$$ENDHEX$$digo na Distribuidora", &
								  "Pre$$HEX1$$e700$$ENDHEX$$o Bruto", &
								  "Desconto", &
								  "Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido", &
								  "Pr$$HEX1$$e700$$ENDHEX$$ Compra", &
								  "Situa$$HEX2$$e700e300$$ENDHEX$$o"}							 						  
								  
This.of_SetSort(ivs_Coluna_Produto, ivs_Nome_Produto)

This.of_SetFilter(ivs_Coluna_Produto, ivs_Nome_Produto)
end event

event ue_reset;call super::ue_reset;ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

ivm_Menu.mf_Classificar(False)
ivm_Menu.mf_Filtrar(False)
ivm_Menu.mf_Localizar(False)
ivm_Menu.mf_Imprimir(False)
ivm_Menu.mf_SalvarComo(False)

cb_Alterar.Enabled = False
dw_1.Enabled = True


end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True
	
	If Not wf_Preco_Compra_Maior_Preco_Venda() Then Return -1

	This.Event RowFocusChanged(1)
	
	If This.DataObject = "dw_ge162_lista_distribuidora" Then
		
		dw_1.AcceptText()
			
		If dw_1.Object.id_ordem_possui_saldo[1] = 'S' Then
			This.SetSort("id_situacao asc, id_possui_saldo desc, vl_compra asc, nr_prioridade_distribuicao asc")
		Else
			This.SetSort("id_situacao asc, vl_compra asc, nr_prioridade_distribuicao asc")
		End If
		
	End If
	
	This.Sort()
	This.GroupCalc()
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

ivm_Menu.mf_Classificar(lvb_Classificar)
ivm_Menu.mf_Filtrar(lvb_Filtrar)
ivm_Menu.mf_Localizar(lvb_Localizar)
ivm_Menu.mf_Imprimir(lvb_Imprimir)
ivm_Menu.mf_SalvarComo(lvb_Imprimir)

ivm_Menu.mf_Excluir(lvb_Imprimir)

cb_Alterar.Enabled = lvb_Imprimir
dw_1.Enabled = True

Return pl_Linhas
end event

event editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)

cb_Alterar.Enabled = False
dw_1.Enabled = False
end event

event itemchanged;call super::itemchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)

Long ll_Produto, lvl_Linha, ll_Achou
string ls_imposto_sap

lvl_Linha=GetRow()

ll_Produto= This.Object.cd_produto[lvl_Linha]
ls_imposto_sap = getitemstring(row,'cd_imposto_sap')

If This.GetColumnName() ='id_situacao' Then
	
	If Data = 'A'  Then
		
		if ib_valida_imposto_sap = True and ( ls_imposto_sap = '' or isnull(ls_imposto_sap) ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Imposto SAP n$$HEX1$$e300$$ENDHEX$$o informado.')
			return 2
		end if
		
		//Valida revis$$HEX1$$e300$$ENDHEX$$o Fiscal pendente
		If Not wf_verifica_pendencia_fiscal(ll_Produto) Then
			This.Event ue_Pos(lvl_Linha, "id_situacao")
			Return 1
		End If
		
		//Valida produto exclusivo da Bahia
		If This.Object.cd_unidade_federacao[lvl_Linha] = 'BA' Then		
			If Not wf_Verifica_Prd_Exclusivo_Bahia(ll_Produto) Then
				This.Event ue_Pos(lvl_Linha, "id_situacao")
				Return 1
			End If
		End If
		
	end if
		
End If
end event

event ue_preupdate;call super::ue_preupdate;String	lvs_Produto, &
		lvs_Situacao_Atual, &
		lvs_Situacao_Nova, &
		lvs_Nulo,&
		lvs_Parametro

String ls_Motivo

Long	lvl_Linha,&
	 	lvl_Dias_Pagto,&
		 ll_Produto

Long ll_Find

Decimal	lvdc_Preco_Atual, &
        		lvdc_Preco_Novo, &
		  	lvdc_Desconto_Atual, &
		  	lvdc_Desconto_Novo,&
		  	lvdc_Preco_Utilizado
		  
DateTime lvdh_GetDate,&
			 lvdh_Data_termino

Boolean lb_Ativao_Produtos = True
			 
dw_2.AcceptText()
		  
SetNull(lvs_Nulo)

lvdh_GetDate = gf_GetServerDate()

If This.RowCount() > 0 Then
	ll_Find = This.Find("Id_Situacao_Alteracao <> Id_Situacao ", 1, This.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
		Return -1
	End If

	If ll_Find > 0 Then
		// Para Procurar alguma situacao Nova B
		For lvl_Linha = 1 To This.RowCount()
	
			lvs_Situacao_Atual		= This.Object.Id_Situacao_Alteracao		[lvl_Linha]
			lvs_Situacao_Nova		= This.Object.Id_Situacao					[lvl_Linha]
			
			If lvs_Situacao_Nova <> lvs_Situacao_Atual  Then
				Choose case lvs_Situacao_Nova
				
					Case "B"
							lb_Ativao_Produtos = False
							lvs_Parametro = 'B'
							Exit
							
					Case "D"
							lb_Ativao_Produtos = False
							lvs_Parametro = 'D'
							Exit
					
					Case Else
						If lvs_Situacao_Nova <> "A" Then
							lb_Ativao_Produtos = False
						End If
						
				End choose
				
			End If 			
		Next
		
		If lb_Ativao_Produtos Then
			lvs_Parametro = String(Date(lvdh_GetDate), "yyyy-mm-dd") + "ATIVA$$HEX2$$c700c300$$ENDHEX$$O DO PROD. SEM MOTIVO INF."
		Else
			OpenWithParm(w_ge162_motivo_alteracao,lvs_Parametro)
			lvs_Parametro = Message.StringParm	
		End if
	
		/*//ALtera$$HEX2$$e700e300$$ENDHEX$$o 
		If lvs_Situacao_Nova = 'A' Then
			// N$$HEX1$$e300$$ENDHEX$$o abre a tela e define motivo padr$$HEX1$$e300$$ENDHEX$$o
			lvs_Parametro = String(lvdh_GetDate) + "ATIVA$$HEX2$$c700c300$$ENDHEX$$O DO PROD. SEM MOTIVO INF."
		Else
			OpenWithParm(w_ge162_motivo_alteracao, lvs_Parametro)
			lvs_Parametro = Message.StringParm
		End If
		*/

		If IsNull(lvs_Parametro) Then Return -1		
	End If
	
	For lvl_Linha = 1 To This.RowCount()
		lvs_Produto				= This.Object.Cd_Produto_Distribuidora	[lvl_Linha]
		lvdc_Preco_Atual       	= This.Object.Vl_Preco_Alteracao			[lvl_Linha]
		lvdc_Desconto_Atual	= This.Object.Pc_Desconto_Alteracao		[lvl_Linha]
		lvdc_Preco_Novo		= This.Object.Vl_Preco_Atual				[lvl_Linha]
		lvdc_Desconto_Novo	= This.Object.Pc_Desconto_Atual			[lvl_Linha]
		lvs_Situacao_Atual		= This.Object.Id_Situacao_Alteracao		[lvl_Linha]
		lvs_Situacao_Nova		= This.Object.Id_Situacao					[lvl_Linha]
		lvl_Dias_Pagto			= This.Object.nr_dias_pagamento			[lvl_Linha]
		ll_Produto				= This.Object.cd_produto					[lvl_Linha]
		lvdc_Preco_Utilizado	= This.Object.vl_preco_utilizado			[lvl_Linha]
		lvdh_Data_termino =DateTime(MidA(lvs_Parametro,1,10))
		ls_Motivo = MidA(lvs_Parametro,11)
			
		If IsNull(lvs_Produto) or Trim(lvs_Produto) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto na distribuidora.")
			This.Event ue_Pos(lvl_Linha, "cd_produto_distribuidora")
			Return -1
		End If
		
		If lvs_Situacao_Atual <> lvs_Situacao_Nova Then
			// Quando for ativar o produto
			
			If lvs_Situacao_Nova <> "F" and lvs_Situacao_Nova <> "A" and lvs_Situacao_Nova <> "I" and lvs_Situacao_Nova <> "P" and lvs_Situacao_Nova <> "B" and lvs_Situacao_Nova <> "D" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A situa$$HEX2$$e700e300$$ENDHEX$$o deve ser F - (Fiscal) ou A - (Ativo) ou I - (Inativo) ou P - (Pendente) ou D $$HEX1$$1320$$ENDHEX$$ (Bloqueado Cadastral) ~rB - (Bloqueado).")
				This.Event ue_Pos(lvl_Linha, "id_situacao")
				Return -1
			End If
			
			If lvs_Situacao_Nova = 'A' Then
				If IsNull(lvdc_Preco_Utilizado) or lvdc_Preco_Utilizado <= 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o atual ou o pre$$HEX1$$e700$$ENDHEX$$o do produto deve ser maior que zero.")
					//This.Event ue_Pos(lvl_Linha, "vl_preco_atual")
					Return -1
				End If
				
				//Valida se o produto possui revis$$HEX1$$e300$$ENDHEX$$o fiscal pendente
				If Not wf_verifica_pendencia_fiscal(ll_Produto) Then
					This.Event ue_Pos(lvl_Linha, "id_situacao")
					Return -1
				End If
				
				//Valida se o produto $$HEX1$$e900$$ENDHEX$$ exclusivo para a Bahia
				If This.Object.cd_unidade_federacao[lvl_Linha] = 'BA' Then
					If Not wf_Verifica_Prd_Exclusivo_Bahia(ll_Produto) Then
						This.Event ue_Pos(lvl_Linha, "id_situacao")
						Return -1
					End If
				End If
			End If
		End If
		
		If lvs_Situacao_Atual <> lvs_Situacao_Nova Then
			If IsNull(lvl_Dias_Pagto) or lvl_Dias_Pagto < 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero de dias para pagamento do produto (distribuidora) '" + lvs_Produto + "'deve ser maior que zero.")
				This.Event ue_Pos(lvl_Linha, "nr_dias_pagamento")
				Return -1		
			End If
		End If
		
		If lvs_Situacao_Nova <> lvs_Situacao_Atual Then
			If lvs_Situacao_Nova <> 'B' and lvs_Situacao_Nova <> 'D' Then setNull(lvdh_Data_termino)
			 
			This.Object.Dh_Alteracao_Situacao			 [lvl_Linha] = lvdh_GetDate
			This.Object.Nr_Matric_Alteracao_Situacao	 [lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
			This.Object.De_Alteracao_Situacao_anterior [lvl_Linha] = String(This.Object.De_Alteracao_Situacao[lvl_Linha])
			This.Object.De_Alteracao_Situacao			 [lvl_Linha] = ls_Motivo
			This.Object.Dh_Alteracao_Situacao_Termino[lvl_Linha] = lvdh_Data_termino
		End If
	Next
End If

Return 1
end event

event ue_key;call super::ue_key;// Se a janela foi acionada pela CO040 e se foi pressionado o ESC fecha a janela
If Not IsNull(ivl_Produto_Parametro) and ivl_Produto_Parametro > 0 Then
	If Key = KeyEscape! Then
		Close(Parent)
	End If
End If
end event

event ue_printimmediate;//override
dw_3.Event ue_PrintImmediate()
end event

event ue_recuperar;// 	902727-7 - faz override do script ancestor para poder chamar o retrieve aqui, para passar como parametro 
// o numero de dias para o calculo da variacao de preco (nova coluna "% Var." na dw_2)
long lvl_rows

lvl_rows = This.Retrieve(dw_1.object.nr_dias_variacao_preco[1])

This.Object.cd_produto_distribuidora.Protect=1

Return lvl_rows
end event

event rowfocuschanged;call super::rowfocuschanged;If currentrow > 0 Then
	This.Object.st_projeto_conexao.text	= This.Object.de_projeto_conexao	[currentrow]
	This.Object.st_de_alteracao.text 		= This.Object.de_alteracao				[currentrow] 
End If
end event

event ue_print;//override
dw_3.Event ue_Print()
end event

event ue_saveas;//override
dw_3.Event ue_SaveAs()
end event

event clicked;call super::clicked;string 	lvs_cd_distribuidora, &
			lvs_cd_uf, &
			lvs_Parametro

long 		lvl_cd_produto

date		lvdt_inicial, &
			lvdt_final

decimal	lvdc_vl_preco_compra

// chamado 902727-7 - nova coluna que exibe o percentual de variacao de pre$$HEX1$$e700$$ENDHEX$$o em X dias, onde X $$HEX1$$e900$$ENDHEX$$ o numero de dias selecionado no novo campo incluido no filtro
if dwo.name = 'pc_variacao_preco' then
	if row > 0 then
		
		if isnull(dw_1.object.nr_dias_variacao_preco[1]) or dw_1.object.nr_dias_variacao_preco[1] = 0 then
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione o n$$HEX1$$fa00$$ENDHEX$$mero de dias para o c$$HEX1$$e100$$ENDHEX$$lculo do percentual de varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o.')
			return
		end if
		
//		if not isnull(this.object.de_projeto_conexao[row]) then
//			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Para visualizar o gr$$HEX1$$e100$$ENDHEX$$fico de varia$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o deste produto, por favor utilize a interface GE365.')
//			return
//		end if
		
		lvs_cd_distribuidora = this.object.cd_distribuidora[row]
		lvl_cd_produto       = this.object.cd_produto[row]
		lvs_cd_uf            = this.object.cd_unidade_federacao[row]
		lvdt_final				= today()
		lvdt_inicial			= relativedate(lvdt_final, dw_1.object.nr_dias_variacao_preco[1] * -1)
		lvdc_vl_preco_compra = this.object.vl_preco_compra[row]

		lvs_Parametro = string(lvdt_inicial, 'dd/mm/yyyy') + string(lvdt_final, 'dd/mm/yyyy') + lvs_cd_Uf + String(lvl_cd_Produto, "0000000") + lvs_cd_distribuidora
		
		if isvalid(w_ge162_grafico_historico_preco) then 
			close(w_ge162_grafico_historico_preco)
		end if
		
		OpenSheetWithParm(w_ge162_grafico_historico_preco, lvs_Parametro, parent, 0, Original! )

	end if
end if
end event

event ue_deleterow;Boolean lvb_Retorno = False
Long ll_Row

SetPointer(HourGlass!)

If This.Event ue_PreDeleteRow() Then
    If Not IsNull(ivm_Menu) Then
        ivm_Menu.mf_Confirmar(True)
        ivm_Menu.mf_Cancelar(True)

        For ll_Row = 1 To This.RowCount()
            If This.GetItemString(ll_Row, "id_selecionada") = "S" Then
                If This.DeleteRow(ll_Row) = 1 Then
                    lvb_Retorno = True
                    ll_Row = ll_Row - 1
                End If
            End If
        Next

        If ivb_UpdateAble Then
            ivw_ParentWindow.ivb_Valida_Salva = True
        End If

        lvb_Retorno = True
    End if
End If 

SetPointer(Arrow!)
Return lvb_Retorno
end event

event doubleclicked;call super::doubleclicked;Integer lvi_Row
		  
String	lvs_Marcacao,&
	   		lvs_Nulo 

SetNull(lvs_Nulo)
	
Choose Case dwo.Name 
		
	Case 'st_selecionado'
	
		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
		End If
		
		For lvi_Row = 1 To This.RowCount()					
			This.Object.Id_selecionada[lvi_Row] = lvs_Marcacao			
		Next
		
End Choose
end event

type cb_distr_bloq from commandbutton within w_ge162_cadastro_produto_distribuidora
integer x = 4576
integer y = 1792
integer width = 544
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Distrib. Bloqueadas"
end type

event clicked;Open(w_ge162_hist_distrib_bloq)
end event

type cb_marcar from commandbutton within w_ge162_cadastro_produto_distribuidora
boolean visible = false
integer x = 3429
integer y = 1796
integer width = 142
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Marcar Todas"
end type

event clicked;//String lvs_Marcar
//
//Integer lvi_Linha
//
//If This.text = "&Marcar Todas" Then
//	This.text = "&Desmarcar Todas"
//	lvs_Marcar = "S"
//Else
//	This.text = "&Marcar Todas"
//	lvs_Marcar = "N"
//End If
//
//For lvi_Linha = 1 To dw_2.RowCount()
//	dw_2.Object.id_selecionada[lvi_Linha] = lvs_Marcar
//Next
//
//dw_2.SetFocus()
//


end event

type gb_2 from groupbox within w_ge162_cadastro_produto_distribuidora
integer x = 14
integer y = 496
integer width = 5705
integer height = 1268
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

