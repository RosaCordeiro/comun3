HA$PBExportHeader$w_ge192_cadastro_fornecedor.srw
forward
global type w_ge192_cadastro_fornecedor from dc_w_sheet
end type
type tab_1 from tab within w_ge192_cadastro_fornecedor
end type
type tabpage_1 from userobject within tab_1
end type
type cb_hist from commandbutton within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_hist cb_hist
dw_1 dw_1
gb_1 gb_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_2 from dc_uo_dw_base within tabpage_2
end type
type gb_2 from groupbox within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
dw_2 dw_2
gb_2 gb_2
gb_3 gb_3
end type
type tab_1 from tab within w_ge192_cadastro_fornecedor
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_ge192_cadastro_fornecedor from dc_w_sheet
string accessiblename = "Cadastro de Fornecedores (GE192)"
integer width = 3835
integer height = 2284
string title = "GE192 - Cadastro de Fornecedores"
tab_1 tab_1
end type
global w_ge192_cadastro_fornecedor w_ge192_cadastro_fornecedor

type variables
uo_condicao_pagamento	ivo_condicao
uo_fornecedor				ivo_fornecedor
uo_cidade					ivo_cidade
uo_ge149_Comprador	io_Comprador
uo_usuario					io_Usuario

Boolean ib_Permite_Alteracao = True
Boolean ib_Permite_Alter_Sit = False

String is_Divisao
end variables

forward prototypes
public function boolean wf_localiza_proximo_codigo_fornecedor (ref string ps_cd_fornecedor)
public function boolean wf_grava_historico_alteracao_principal ()
public function boolean wf_grava_historico_alteracao (string as_tabela, string as_chave, string as_coluna, string as_de, string as_para, string as_operador, string as_tipo_alteracao)
public function boolean wf_grava_historico_alteracao_telefone ()
public subroutine wf_lista_divisao_fornecedor ()
public function boolean wf_verifica_divisao ()
public function boolean wf_verifica_possui_divisao (ref long al_achou)
public subroutine wf_set_somente_consulta ()
public function boolean wf_permite_alterar_situacao (long al_evento)
end prototypes

public function boolean wf_localiza_proximo_codigo_fornecedor (ref string ps_cd_fornecedor);String lvs_Proximo_Fornecedor, &
       lvs_Ultimo_Fornecedor

Long lvl_Ultimo_Sequencial, &
     lvl_Filial

lvl_Filial = gvo_Parametro.of_Filial()

Select max(cd_fornecedor) Into :lvs_Ultimo_Fornecedor
From fornecedor
Where cd_filial = :lvl_Filial;

If SqlCa.SqlCode = 0 Then
	If IsNull(lvs_Ultimo_Fornecedor) Then
		lvl_Ultimo_Sequencial = 0
	Else
		lvl_Ultimo_Sequencial = Long(RightA(lvs_Ultimo_Fornecedor, 5))
	End If
	
	lvs_Proximo_Fornecedor = String(lvl_Filial, "0000") + String(lvl_Ultimo_Sequencial + 1, "00000")
	
	tab_1.tabpage_1.dw_1.Object.Cd_Fornecedor[1] = lvs_Proximo_Fornecedor
	tab_1.tabpage_1.dw_1.Object.Cd_Filial[1]     = lvl_Filial
	
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro durante a determina$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do fornecedor.", StopSign!, Ok!)
	Return False
End If
end function

public function boolean wf_grava_historico_alteracao_principal ();Long ll_Cidade, ll_Nr_Endereco
Decimal lde_Minimo_Pedido
String	ls_Operador, ls_Situacao, ls_For_Trans, ls_Nm_Razao, ls_Tipo_Pessoa, ls_Nm_Fantasia, ls_Cgc, ls_Cpf, ls_Inscri_Estad, &
		ls_Bairro, ls_Endereco, ls_Cep, ls_Nulo, ls_Matric_Compr, ls_De_Email, ls_Id_Recebe_Email_Xml, &
		ls_Id_Regime_Esp, ls_Id_Consid_Ipi_Ped, ls_Uti_Agend, ls_Id_Ped_Edi, ls_Ati_Economica

Tab_1.tabpage_1.dw_1.AcceptText()

Select	coalesce(f.id_situacao, 'A'), f.id_fornecedor_transportadora, f.nm_razao_social, f.id_fisica_juridica, f.nm_fantasia, f.nr_cgc,
		f.nr_cpf, f.nr_inscricao_estadual, f.cd_cidade, f.de_bairro, f.de_endereco, f.nr_cep, f.nr_endereco, f.nr_matricula_comprador,
		f.de_email, f.id_utiliza_agendamento_entrega, coalesce(f.id_recebe_email_xml, 'N'), coalesce(f.id_regime_especial, 'N'), coalesce(f.id_considera_ipi_pedido, 'N'),
		f.id_pedido_edi, f.id_atividade_economica, coalesce(f.vl_minimo_pedido,0)
Into	:ls_Situacao, :ls_For_Trans, :ls_Nm_Razao, :ls_Tipo_Pessoa, :ls_Nm_Fantasia, :ls_Cgc,
		:ls_Cpf, :ls_Inscri_Estad, :ll_Cidade, :ls_Bairro, :ls_Endereco, :ls_Cep, :ll_Nr_Endereco, :ls_Matric_Compr,
		:ls_De_Email, :ls_Uti_Agend, :ls_Id_Recebe_Email_Xml, :ls_Id_Regime_Esp, :ls_Id_Consid_Ipi_Ped,
		:ls_Id_Ped_Edi, :ls_Ati_Economica, :lde_Minimo_Pedido

From fornecedor f
Where f.cd_fornecedor = :ivo_Fornecedor.Cd_Fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
		
	Case 0
		//Faz as valida$$HEX2$$e700f500$$ENDHEX$$es abaixo
		
	Case 100
		Return True
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es da fun$$HEX2$$e700e300$$ENDHEX$$o principal." + SqlCa.SQLErrText, StopSign!)
		Return False
End Choose

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
SetNull(ls_Nulo)

If IsNull(ls_Situacao) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Id_Situacao[1]) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_SITUACAO', ls_Nulo, tab_1.tabpage_1.dw_1.Object.Id_Situacao[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Situacao[1] <> ls_Situacao Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_SITUACAO', ls_Situacao, tab_1.tabpage_1.dw_1.Object.Id_Situacao[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nm_Razao_Social[1] <> ls_Nm_Razao Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NM_RAZAO_SOCIAL', ls_Nm_Razao, tab_1.tabpage_1.dw_1.Object.Nm_Razao_Social[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nm_Fantasia[1] <> ls_Nm_Fantasia Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NM_FANTASIA', ls_Nm_Fantasia, tab_1.tabpage_1.dw_1.Object.Nm_Fantasia[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Fornecedor_Transportadora[1] <> ls_For_Trans Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_FORNECEDOR_TRANSPORTADORA', ls_For_Trans, tab_1.tabpage_1.dw_1.Object.Id_Fornecedor_Transportadora[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Fisica_Juridica[1] <> ls_Tipo_Pessoa Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_FISICA_JURIDICA', ls_Tipo_Pessoa, tab_1.tabpage_1.dw_1.Object.Id_Fisica_Juridica[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If IsNull(ls_Ati_Economica) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Id_Atividade_Economica) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_ATIVIDADE_ECONOMICA', ls_Nulo, tab_1.tabpage_1.dw_1.Object.Id_Atividade_Economica[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Atividade_Economica[1] <> ls_Ati_Economica Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_ATIVIDADE_ECONOMICA', ls_Ati_Economica, tab_1.tabpage_1.dw_1.Object.Id_Atividade_Economica[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If IsNull(ls_Cgc) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Nr_Cgc) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_CGC', ls_Nulo, tab_1.tabpage_1.dw_1.Object.Nr_Cgc[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Cgc[1] <> ls_Cgc Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_CGC', ls_Cgc, tab_1.tabpage_1.dw_1.Object.Nr_Cgc[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If IsNull(ls_Inscri_Estad) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Nr_Inscricao_Estadual[1]) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_INSCRICAO_ESTADUAL', ls_Nulo, tab_1.tabpage_1.dw_1.Object.Nr_Inscricao_Estadual[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Inscricao_Estadual[1] <> ls_Inscri_Estad Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_INSCRICAO_ESTADUAL', ls_Inscri_Estad, tab_1.tabpage_1.dw_1.Object.Nr_Inscricao_Estadual[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If IsNull(ls_Cpf) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Nr_Cpf[1]) And tab_1.tabpage_1.dw_1.Object.Nr_Cpf[1] <> "" Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_CPF', ls_Nulo, tab_1.tabpage_1.dw_1.Object.Nr_Cpf[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If
		
If tab_1.tabpage_1.dw_1.Object.Nr_Cpf[1] <> ls_Cpf Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_CPF', ls_Cpf, tab_1.tabpage_1.dw_1.Object.Nr_Cpf[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Cd_Cidade[1] <> ll_Cidade Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'CD_CIDADE', String(ll_Cidade) + "@#!" + tab_1.tabpage_1.dw_1.Object.Nm_Cidade_Anterior[1], String(tab_1.tabpage_1.dw_1.Object.Cd_Cidade[1]) + "@#!" + tab_1.tabpage_1.dw_1.Object.Nm_Cidade[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.De_Bairro[1] <> ls_Bairro Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'DE_BAIRRO', ls_Bairro, tab_1.tabpage_1.dw_1.Object.De_Bairro[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.De_Endereco[1] <> ls_Endereco Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'DE_ENDERECO', ls_Endereco, tab_1.tabpage_1.dw_1.Object.De_Endereco[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Cep[1] <> ls_Cep Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_CEP', ls_Cep, tab_1.tabpage_1.dw_1.Object.Nr_Cep[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If IsNull(ll_Nr_Endereco) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Nr_Endereco[1]) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_ENDERECO', ls_Nulo, String(tab_1.tabpage_1.dw_1.Object.Nr_Endereco[1]), ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Endereco[1] <> ll_Nr_Endereco Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_ENDERECO', String(ll_Nr_Endereco), String(tab_1.tabpage_1.dw_1.Object.Nr_Endereco[1]), ls_Operador, 'A') Then
		Return False
	End If
End If

If IsNull(ls_Matric_Compr) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Nr_Matricula_Comprador[1]) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_MATRICULA_COMPRADOR', ls_Nulo, tab_1.tabpage_1.dw_1.Object.Nr_Matricula_Comprador[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If IsNull(tab_1.tabpage_1.dw_1.Object.Nr_Matricula_Comprador[1]) Then
	If Not IsNull(ls_Matric_Compr) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_MATRICULA_COMPRADOR', ls_Matric_Compr, ls_Nulo, ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Matricula_Comprador[1] <> ls_Matric_Compr Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_MATRICULA_COMPRADOR', ls_Matric_Compr, tab_1.tabpage_1.dw_1.Object.Nr_Matricula_Comprador[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.De_Email[1] <> ls_De_Email Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'DE_EMAIL', ls_De_Email, tab_1.tabpage_1.dw_1.Object.De_Email[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If IsNull(ls_Uti_Agend) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Id_Utiliza_Agendamento_Entrega[1]) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_UTILIZA_AGENDAMENTO_ENTREGA', ls_Nulo, tab_1.tabpage_1.dw_1.Object.Id_Utiliza_Agendamento_Entrega[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If IsNull(tab_1.tabpage_1.dw_1.Object.Id_Utiliza_Agendamento_Entrega[1]) Then
	If Not IsNull(ls_Uti_Agend) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_UTILIZA_AGENDAMENTO_ENTREGA', ls_Uti_Agend, ls_Nulo, ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Utiliza_Agendamento_Entrega[1] <> ls_Uti_Agend Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_UTILIZA_AGENDAMENTO_ENTREGA', ls_Uti_Agend, tab_1.tabpage_1.dw_1.Object.Id_Utiliza_Agendamento_Entrega[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Recebe_Email_Xml[1] <> ls_Id_Recebe_Email_Xml Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_RECEBE_EMAIL_XML', ls_Id_Recebe_Email_Xml, tab_1.tabpage_1.dw_1.Object.Id_Recebe_Email_Xml[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Regime_Especial[1] <> ls_Id_Regime_Esp Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_REGIME_ESPECIAL', ls_Id_Regime_Esp, tab_1.tabpage_1.dw_1.Object.Id_Regime_Especial[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Considera_Ipi_Pedido[1] <> ls_Id_Consid_Ipi_Ped Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_CONSIDERA_IPI_PEDIDO', ls_Id_Consid_Ipi_Ped, tab_1.tabpage_1.dw_1.Object.Id_Considera_Ipi_Pedido[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If IsNull(ls_Id_Ped_Edi) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1]) And tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1] <> "Z" Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_PEDIDO_EDI', ls_Nulo, tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1], ls_Operador, 'A') Then
			Return False
		End If
	End If

	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1]) And tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1] = "Z" Then
		tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1] = ls_Nulo		
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1] <> ls_Id_Ped_Edi Then
	//Z $$HEX1$$e900$$ENDHEX$$ igual a Nenhuma. Se for selecionado Nenhuma ir$$HEX1$$e100$$ENDHEX$$ gravar o para como nulo
	If tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1] = "Z" Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_PEDIDO_EDI', ls_Id_Ped_Edi,ls_Nulo, ls_Operador, 'A') Then
			Return False
		End If
		
		tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1] = ls_Nulo
	Else
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_PEDIDO_EDI', ls_Id_Ped_Edi, tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

//Remove van
If IsNull(Tab_1.tabpage_1.dw_1.Object.Id_Pedido_Edi[1]) Then
	If Not IsNull(ls_Id_Ped_Edi) And ls_Id_Ped_Edi <> "Z" Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_PEDIDO_EDI', ls_Id_Ped_Edi, ls_Nulo, ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

// Altera$$HEX2$$e700e300$$ENDHEX$$o de valor m$$HEX1$$ed00$$ENDHEX$$nimo de pedido de compra.
If Not IsNull(tab_1.tabpage_1.dw_1.GetItemDecimal(1, 'vl_minimo_pedido')) Then
	If tab_1.tabpage_1.dw_1.GetItemDecimal(1, 'vl_minimo_pedido') <> lde_Minimo_Pedido Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'VL_MINIMO_PEDIDO', String(lde_Minimo_Pedido), String(tab_1.tabpage_1.dw_1.GetItemDecimal(1, 'vl_minimo_pedido')), ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

Return True
end function

public function boolean wf_grava_historico_alteracao (string as_tabela, string as_chave, string as_coluna, string as_de, string as_para, string as_operador, string as_tipo_alteracao);Insert Into historico_alteracao_tabela(nm_tabela, de_chave, nm_coluna, de_alteracao_de, de_alteracao_para, nr_matric_alteracao, id_alteracao)
Values (:as_Tabela, :as_Chave, :as_Coluna, :as_De, :as_Para, :as_Operador, :as_Tipo_Alteracao)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es." + SqlCa.SQLErrText, StopSign!)
	SqlCa.of_RollBack()
	Return False
End If

Return True
end function

public function boolean wf_grava_historico_alteracao_telefone ();Decimal ldc_Pc_Desconto_Usual

Long ll_Cd_Cond_Pag

String	ls_Operador, ls_Nulo, ls_Nr_Ddd_Tel, ls_Nr_Tel, ls_Nr_Ddd_Fax, ls_Nr_Fax, ls_Nr_Ddd_Tel_Compras, &
		ls_Nr_Tel_Compras, ls_Nr_Ddd_Fax_Comp, ls_Nr_Fax_Comp, ls_Id_Regime_Tributario, ls_End_Ema_Env_Xml

Select	coalesce(f.nr_ddd_telefone, ""), coalesce(f.nr_telefone, ""), coalesce(f.nr_ddd_fax, ""), coalesce(f.nr_fax, ""),
		coalesce(f.nr_ddd_telefone_compras, ""), coalesce(f.nr_telefone_compras, ""), coalesce(f.nr_ddd_fax_compras, ""),
		coalesce(f.nr_fax_compras, ""), f.cd_condicao_pagamento, f.id_regime_tributario, f.pc_desconto_usual,
		f.de_endereco_email_envio_xml
Into	:ls_Nr_Ddd_Tel, :ls_Nr_Tel, :ls_Nr_Ddd_Fax, :ls_Nr_Fax,
		:ls_Nr_Ddd_Tel_Compras, :ls_Nr_Tel_Compras, :ls_Nr_Ddd_Fax_Comp,
		:ls_Nr_Fax_Comp, :ll_Cd_Cond_Pag, :ls_Id_Regime_Tributario, :ldc_Pc_Desconto_Usual,
		:ls_End_Ema_Env_Xml
From fornecedor f
Where cd_fornecedor = :ivo_Fornecedor.Cd_Fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
		
	Case 0
		//Faz as valida$$HEX2$$e700f500$$ENDHEX$$es abaixo
		
	Case 100
		//N$$HEX1$$e300$$ENDHEX$$o faz nada
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es." + SqlCa.SQLErrText, StopSign!)
		Return False
		
End Choose

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
SetNull(ls_Nulo)

If tab_1.tabpage_1.dw_1.Object.Nr_Ddd_Telefone[1] <> ls_Nr_Ddd_Tel Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_DDD_TELEFONE', ls_Nr_Ddd_Tel, tab_1.tabpage_1.dw_1.Object.Nr_Ddd_Telefone[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Telefone[1] <> ls_Nr_Tel Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_TELEFONE', ls_Nr_Tel, tab_1.tabpage_1.dw_1.Object.Nr_Telefone[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Ddd_Fax[1] <> ls_Nr_Ddd_Fax Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_DDD_FAX', ls_Nr_Ddd_Fax, tab_1.tabpage_1.dw_1.Object.Nr_Ddd_Fax[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Fax[1] <> ls_Nr_Fax Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_FAX', ls_Nr_Fax, tab_1.tabpage_1.dw_1.Object.Nr_Fax[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Ddd_Telefone_Compras[1] <> ls_Nr_Ddd_Tel_Compras Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_DDD_TELEFONE_COMPRAS', ls_Nr_Ddd_Tel_Compras, tab_1.tabpage_1.dw_1.Object.Nr_Ddd_Telefone_Compras[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Telefone_Compras[1] <> ls_Nr_Tel_Compras Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_TELEFONE_COMPRAS', ls_Nr_Tel_Compras, tab_1.tabpage_1.dw_1.Object.Nr_Telefone_Compras[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Ddd_Fax_Compras[1] <> ls_Nr_Ddd_Fax_Comp Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_DDD_FAX_COMPRAS', ls_Nr_Ddd_Fax_Comp, tab_1.tabpage_1.dw_1.Object.Nr_Ddd_Fax_Compras[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Nr_Fax_Compras[1] <> ls_Nr_Fax_Comp Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'NR_FAX_COMPRAS', ls_Nr_Fax_Comp, tab_1.tabpage_1.dw_1.Object.Nr_Fax_Compras[1], ls_Operador, 'A') Then
		Return False
	End If
End If

//INICIO TRATAMENTO CD_CONDICAO_PAGAMENTO

If IsNull(ll_Cd_Cond_Pag) Then
	If Not IsNull(tab_1.tabpage_1.dw_1.Object.Cd_Condicao_Pagamento[1]) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'CD_CONDICAO_PAGAMENTO', ls_Nulo, String(tab_1.tabpage_1.dw_1.Object.Cd_Condicao_Pagamento[1]) + "@#!" + tab_1.tabpage_1.dw_1.Object.De_Condicao_Pagamento[1], ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If IsNull(tab_1.tabpage_1.dw_1.Object.Cd_Condicao_Pagamento[1]) Then
	If Not IsNull(ll_Cd_Cond_Pag) Then
		If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'CD_CONDICAO_PAGAMENTO', String(ll_Cd_Cond_Pag) + "@#!" + tab_1.tabpage_1.dw_1.Object.De_Condicao_Pagamento_Ant[1], ls_Nulo, ls_Operador, 'A') Then
			Return False
		End If
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Cd_Condicao_Pagamento[1] <> ll_Cd_Cond_Pag Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'CD_CONDICAO_PAGAMENTO', String(ll_Cd_Cond_Pag) + "@#!" + tab_1.tabpage_1.dw_1.Object.De_Condicao_Pagamento_Ant[1], String(tab_1.tabpage_1.dw_1.Object.Cd_Condicao_Pagamento[1]) + "@#!" + tab_1.tabpage_1.dw_1.Object.De_Condicao_Pagamento[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Id_Regime_Tributario[1] <> ls_Id_Regime_Tributario Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'ID_REGIME_TRIBUTARIO', ls_Id_Regime_Tributario, tab_1.tabpage_1.dw_1.Object.Id_Regime_Tributario[1], ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.Pc_Desconto_Usual[1] <> ldc_Pc_Desconto_Usual Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'PC_DESCONTO_USUAL', String(ldc_Pc_Desconto_Usual), String(tab_1.tabpage_1.dw_1.Object.Pc_Desconto_Usual[1]), ls_Operador, 'A') Then
		Return False
	End If
End If

If tab_1.tabpage_1.dw_1.Object.De_Endereco_Email_Envio_Xml[1] <> ls_End_Ema_Env_Xml Then
	If Not wf_Grava_Historico_Alteracao('FORNECEDOR', ivo_Fornecedor.Cd_Fornecedor, 'DE_ENDERECO_EMAIL_ENVIO_XML', ls_End_Ema_Env_Xml, tab_1.tabpage_1.dw_1.Object.De_Endereco_Email_Envio_Xml[1], ls_Operador, 'A') Then
		Return False
	End If
End If

Return True
end function

public subroutine wf_lista_divisao_fornecedor ();DataWindowChild lvdwc

String ls_SQL, ls_Fornecedor

Tab_1.TabPage_1.dw_1.AcceptText()

ls_Fornecedor = Tab_1.TabPage_1.dw_1.Object.cd_fornecedor[1]
	
If Tab_1.TabPage_2.dw_3.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
		
	ls_SQL = " SELECT 	cast(f.nr_divisao as char(5)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao, f.nr_divisao FROM fornecedor_divisao f   " +&
				 " inner join usuario u on u.nr_matricula = f.nr_matricula_comprador " +&
				 " where f.cd_fornecedor = '" + string(ls_Fornecedor) + "'" +&
				 " union " +&
				 " select 'NENHUMA', null"				 
	
	lvdwc.SetSQLSelect(ls_SQL)
		
	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return 
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild divis$$HEX1$$e300$$ENDHEX$$o fornecedor.")
End If
end subroutine

public function boolean wf_verifica_divisao ();Long ll_Achou
Long ll_GetRow
Long ll_Divisao

Tab_1.TabPage_2.dw_2.AcceptText()

ll_GetRow = Tab_1.TabPage_2.dw_2.GetRow()
ll_Divisao  = Tab_1.TabPage_2.dw_3.Object.Nr_Divisao_Fornecedor[1]

If Not wf_Verifica_Possui_Divisao(Ref ll_Achou) Then
	Return False
End If

If SqlCa.SqlCode = 0 Then
	If ll_Achou > 0 Then
		// Se is_Divisao for nulo, signfica que a divis$$HEX1$$e300$$ENDHEX$$o escolhida foi NENHUMA
		If IsNull(ll_Divisao ) Or ll_Divisao = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.")
			Tab_1.TabPage_2.dw_2.DeleteRow(ll_GetRow)
			Return False
		End If
	End If
End If

Return True
end function

public function boolean wf_verifica_possui_divisao (ref long al_achou);Select Count(*)
	Into :al_Achou
From fornecedor_divisao
Where cd_fornecedor = :ivo_Fornecedor.Cd_Fornecedor
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao consultar a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_possui_divisao")
	Return False
End If

Return True
end function

public subroutine wf_set_somente_consulta ();If Not ib_Permite_Alteracao Then
	Tab_1.TabPage_1.dw_1.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar = False)
End If
end subroutine

public function boolean wf_permite_alterar_situacao (long al_evento);Long ll_Achou

If al_Evento = 1 Then
	
	Select Count(*)
		Into :ll_Achou
	From fornecedor
	Where nr_cgc = :ivo_Fornecedor.Nr_CGC
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se existe outro c$$HEX1$$f300$$ENDHEX$$digo de fornecedor referente ao CNPJ '" + ivo_Fornecedor.Nr_CGC + "'. " + SqlCa.SqlErrText, StopSign!)
		Return False
	End If
	
	If ll_Achou > 1 Then
		ib_Permite_Alter_Sit = True
	End If
	
Else
	
	If ib_Permite_Alter_Sit Then
		Select Count(*)
			Into :ll_Achou
		From fornecedor
		Where nr_cgc = :ivo_Fornecedor.Nr_CGC
			And id_situacao = 'A'
		Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se existe outro c$$HEX1$$f300$$ENDHEX$$digo de fornecedor referente ao CNPJ '" + ivo_Fornecedor.Nr_CGC + "'. " + SqlCa.SqlErrText, StopSign!)
			Return False
		End If
		
		If ll_Achou > 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe um ou mais fornecedores ativos com o CNPJ '" + ivo_Fornecedor.Nr_CGC + "'.", Exclamation!)
		End If
	End If
End If

Return True
end function

on w_ge192_cadastro_fornecedor.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge192_cadastro_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event close;call super::close;Destroy(ivo_Condicao)
Destroy(ivo_Fornecedor)
Destroy(ivo_Cidade)
Destroy(io_Comprador)
Destroy(io_Usuario)
end event

event ue_cancel;call super::ue_cancel;tab_1.tabpage_1.dw_1.Event ue_Cancel()
tab_1.tabpage_2.dw_2.Event ue_Cancel()
end event

event ue_save;call super::ue_save;Boolean lb_Permite

If ivb_Valida_Salva Then
	Tab_1.TabPage_2.dw_2.Object.b_1.Enabled = False
Else
	Tab_1.TabPage_2.dw_2.Object.b_1.Enabled = True
End If

If AncestorReturnValue = 1 Then	
	//Tratamento feito para mostar NENHUMA quando id_pedido_edi for nulo
	If IsNull(Tab_1.TabPage_1.dw_1.Object.Id_Pedido_Edi[1]) Then Tab_1.TabPage_1.dw_1.Object.Id_Pedido_Edi[1] = "Z"
	
	Tab_1.TabPage_1.dw_1.Event ue_Retrieve()
	
	If Not wf_Permite_Alterar_Situacao(2) Then Return -1
	
	Tab_1.TabPage_2.dw_2.ivm_Menu.mf_incluir( True)
	Tab_1.TabPage_2.dw_2.ivm_Menu.mf_excluir( True)
End If

Return 1
end event

event ue_preopen;call super::ue_preopen;ivo_Condicao	= Create uo_Condicao_Pagamento
ivo_Fornecedor	= Create uo_Fornecedor
ivo_Cidade		= Create uo_Cidade
io_Comprador	= Create uo_ge149_Comprador
io_Usuario		= Create uo_usuario
end event

event open;call super::open;Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)

//Busca a DLL DllInscE32 no FTP [Cleser]
If Not FileExists("C:\Sistemas\DLL\DllInscE32.dll") Then
	dc_uo_Ftp lo_Ftp
	lo_Ftp = Create dc_uo_Ftp
	
	If Not lo_Ftp.of_Conecta_Ftp("", "10.0.0.4", "pdv2", "pdv2") Then
		Destroy lo_Ftp					
		Return
	End If
	
	lo_Ftp.of_Ftp_Set_Dir("dll_IE")	
	lo_Ftp.of_Ftp_GetFile("DllInscE32.dll", "C:\Sistemas\DLL\DllInscE32.dll" )	
	Destroy(lo_Ftp)
End If

tab_1.tabpage_1.dw_1.Event ue_AddRow()
tab_1.tabpage_2.dw_3.Event ue_AddRow()
tab_1.tabpage_1.dw_1.SetFocus()

dc_uo_dw_Base lvo_Update[]
lvo_Update = {tab_1.tabpage_1.dw_1, tab_1.tabpage_2.dw_2}
This.wf_SetUpdate_DW(lvo_Update)
This.ivm_Menu.mf_Incluir(True)

ib_Permite_Alteracao = False

end event

type dw_visual from dc_w_sheet`dw_visual within w_ge192_cadastro_fornecedor
integer y = 648
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge192_cadastro_fornecedor
integer y = 576
end type

type tab_1 from tab within w_ge192_cadastro_fornecedor
integer x = 18
integer y = 16
integer width = 3762
integer height = 2056
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;Tab_1.TabPage_1.dw_1.AcceptText()

If newIndex = 2 Then
	Tab_1.TabPage_2.dw_2.ivm_Menu.mf_incluir( True)
	Tab_1.TabPage_2.dw_2.ivm_Menu.mf_excluir( True)
	wf_Lista_Divisao_Fornecedor()
	Long ll_Nulo
	SetNull(ll_Nulo)
	Tab_1.TabPage_2.dw_2.Retrieve(Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor[1], ll_Nulo)
	Tab_1.TabPage_2.dw_2.SetFocus()
Else
	Tab_1.TabPage_1.dw_1.ivm_Menu.mf_incluir( False)
	Tab_1.TabPage_2.dw_2.ivm_Menu.mf_excluir( False)
	Tab_1.TabPage_2.dw_3.Reset()
	Tab_1.TabPage_2.dw_3.InsertRow(0)
	Tab_1.TabPage_1.dw_1.SetFocus()
End If
end event

event selectionchanging;If newIndex = 2 Then
	If IsNull(Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor[1]) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o fornecedor.', Exclamation!)
		Tab_1.TabPage_1.dw_1.SetFocus()
		Return 1
	End If
End If
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3726
integer height = 1940
long backcolor = 79741120
string text = "Cadastro"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_hist cb_hist
dw_1 dw_1
gb_1 gb_1
end type

on tabpage_1.create
this.cb_hist=create cb_hist
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_hist,&
this.dw_1,&
this.gb_1}
end on

on tabpage_1.destroy
destroy(this.cb_hist)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type cb_hist from commandbutton within tabpage_1
integer x = 3017
integer y = 1804
integer width = 626
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;If Not ivo_Fornecedor.Localizado Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localize o fornecedor para consultar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "nm_localiza")
	Return -1
End If

If ivb_Valida_Salva Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Salve ou cancele as altera$$HEX2$$e700f500$$ENDHEX$$es antes de prosseguir.")
	Return -1
End If

st_ge382_parametros str

str.Tabela[1] = 'FORNECEDOR'
str.Chave = ivo_Fornecedor.Cd_Fornecedor

OpenWithParm(w_ge382_historico_alteracao, str)
end event

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 18
integer y = 48
integer width = 3602
integer height = 1708
integer taborder = 30
string dataobject = "dw_ge192_cadastro_fornecedor"
end type

event constructor;call super::constructor;//ivi_Tipo_Cancelar = ADDROW

This.ivs_Coluna_Sem_Validacao_Salva = {"nm_localiza"}

This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Tab_1.TabPage_1.dw_1.ivm_menu.mf_confirmar( True)
	Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Cancelar(True)
End If

Choose Case dwo.Name

	Case"de_condicao_pagamento"
	
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If data <> ivo_Condicao.de_Condicao Then
				Return 1
			End If 
		Else
			ivo_Condicao.of_Inicializa()
			
			This.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
			This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
		End If

	Case "nm_comprador"
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.nr_matricula_comprador[1] = io_Comprador.nr_matricula
			This.Object.nm_comprador			   [1] = io_Comprador.nm_usuario
		End If
End Choose

Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Incluir(False)
Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Excluir(False)
end event

event itemchanged;call super::itemchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Tab_1.TabPage_1.dw_1.ivm_menu.mf_confirmar( True)
	Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Cancelar(True)
End If

Choose Case dwo.Name
		
	Case "nr_cgc"	
		If Not ( gf_CGC_Valido( data ) ) Then 		
			// CGC Invalido, continua com foco no campo CGC //
			RETURN 1 		  
		End If
	  
	Case "nr_cpf"	  
		If Not ( gf_Nr_CPF_Valido( data ) ) Then 		
			// CGC Invalido, continua com foco no campo CGC //
			RETURN 1 		  
		End If
		
	Case "id_fisica_juridica"		
		If data = "F"  Then 			
			This.Object.Nr_CGC[1] = ''
			This.Object.nr_inscricao_estadual[1] = ''			
		Else			
			This.Object.Nr_CPF[1] = ''			
		End If

	Case "nm_cidade"
		If Data <> ivo_Cidade.Nm_Cidade Then
			Return 1
		End If
			
	Case "de_condicao_pagamento"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If data <> ivo_Condicao.de_Condicao Then
				Return 1
			End If 
		Else
			ivo_Condicao.of_Inicializa()
			
			This.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
			This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
		End If
	
	Case "nm_comprador"
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.nr_matricula_comprador[1] = io_Comprador.nr_matricula
			This.Object.nm_comprador			   [1] = io_Comprador.nm_usuario
		End If
	
	Case "vl_minimo_pedido"
		If Dec(Data) < 0 Then Return 1
End Choose

Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Incluir(False)
Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Excluir(False)
end event

event losefocus;call super::losefocus;If IsValid(ivo_Cidade) Then
	This.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
End If

If IsValid(ivo_Condicao) Then
	This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
End If

If IsValid(io_Comprador) Then
	This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
	This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
End If
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivo_Fornecedor.of_Inicializa()

	ivo_Cidade.of_Inicializa()

	ivo_Condicao.of_Inicializa()
End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_localiza"
			ivo_Fornecedor.id_selecao_cadastro = "S"
			
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
						
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				is_Divisao = ""
				This.Event ue_Retrieve()
				tab_1.tabpage_2.dw_2.Event ue_Retrieve()
			End If
			
		Case "nm_cidade"
			ivo_Cidade.of_Localiza_Cidade(This.GetText())
			
			If ivo_Cidade.Localizada Then
				This.Object.Cd_Cidade[1] 					= ivo_Cidade.Cd_Cidade
				This.Object.Nm_Cidade[1] 					= ivo_Cidade.Nm_Cidade
				This.Object.Cd_Unidade_Federacao[1] 	= ivo_Cidade.Cd_Unidade_Federacao
			End If

		Case "de_condicao_pagamento"
			If ivo_Condicao.of_Localiza(This.GetText()) Then
				dw_1.Object.cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
				dw_1.Object.de_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
			End If		
			
		Case "nm_comprador"
			io_Comprador.of_Localiza_Comprador(This.GetText())
			
			If io_Comprador.Localizado Then
				This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
				This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
			End If
		
	End Choose
End If


end event

event ue_postretrieve;call super::ue_postretrieve;Long	lvl_Cidade, &
		lvl_Condicao, &
		ll_Achou

String lvs_Comprador
String ls_Responsavel

Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Incluir(False)
Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Excluir(False)

If pl_Linhas > 0 Then
	lvl_Cidade   		= This.Object.Cd_Cidade            			[1]
	lvl_Condicao 	= This.Object.Cd_Condicao_Pagamento	[1]
	lvs_Comprador	= This.Object.nr_matricula_comprador	[1]
	ls_Responsavel = This.Object.Nr_Matricula_Atualizacao	[1]
	
	If Not wf_Verifica_Possui_Divisao(Ref ll_Achou) Then
		Return -1
	End If
	
	If ll_Achou > 0 Then
		This.Object.Comprador_t.Visible = True
		This.Object.B_1.Visible = True
		This.Object.Nm_Comprador.Visible = False
		This.Object.Nr_Matricula_Comprador.Visible = False
	Else
		This.Object.Comprador_t.Visible = False
		This.Object.B_1.Visible = False
		This.Object.Nm_Comprador.Visible = True
		This.Object.Nr_Matricula_Comprador.Visible = True
	End If
	
	ivo_Cidade.of_Localiza_Codigo(lvl_Cidade)
	
	If ivo_Cidade.Localizada Then
		This.Object.Nm_Cidade					[1] = ivo_Cidade.Nm_Cidade
		This.Object.Nm_Cidade_Anterior		[1] = ivo_Cidade.Nm_Cidade
		This.Object.Cd_Unidade_Federacao	[1] = ivo_Cidade.Cd_Unidade_Federacao
	End If
	
	If ivo_Condicao.of_Localiza_Codigo(lvl_Condicao) Then
		dw_1.Object.de_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
		dw_1.Object.de_Condicao_Pagamento_Ant[1] = ivo_Condicao.De_Condicao
	End If
	
	If Not Isnull(lvs_Comprador) Then
		io_Comprador.of_Localiza_Comprador(lvs_Comprador)
			
		If io_Comprador.Localizado Then
			This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
			This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
		End If
	End If
	
	If Not IsNull(ls_Responsavel) Then
		io_Usuario.of_Localiza_Usuario(ls_Responsavel)
		
		If io_Usuario.Localizado Then
			This.Object.Nr_Matricula_Atualizacao	[1] = io_Usuario.Nr_Matricula
			This.Object.Nm_Usuario					[1] = io_Usuario.Nm_Usuario
		End If
	End If
	
	//Tratamento feito para mostar NENHUMA quando id_pedido_edi for nulo
	If IsNull(This.Object.Id_Pedido_Edi[1]) Then This.Object.Id_Pedido_Edi[1] = "Z"
	
	wf_Lista_Divisao_Fornecedor()
	
	ib_Permite_Alter_Sit = False
	Tab_1.TabPage_1.dw_1.Object.Id_Situacao.Protect = 1
	
	//Somente a Li$$HEX1$$e900$$ENDHEX$$ge poder$$HEX1$$e100$$ENDHEX$$ alterar a situa$$HEX2$$e700e300$$ENDHEX$$o do fornecedor
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "GC" Then
		If gvo_Aplicacao.ivo_Seguranca.Cd_Perfil_Usuario = 10 Then
			//Se o usu$$HEX1$$e100$$ENDHEX$$rio for a Li$$HEX1$$e900$$ENDHEX$$ge e se houver mais de um fornecedor com o mesmo CNPJ, libera o id_situacao pra edi$$HEX2$$e700e300$$ENDHEX$$o
			If Not wf_Permite_Alterar_Situacao(1) Then Return -1
			
			If ib_Permite_Alter_Sit Then
				Tab_1.TabPage_1.dw_1.Object.Id_Situacao.Protect = 0
			End If
		End If
	End If
	
	// Liberar campo vl_Minimo_Pedido para altera$$HEX2$$e700e300$$ENDHEX$$o no Compras.
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
		This.Modify("vl_Minimo_Pedido.EditMask.ReadOnly=No")
	End If
End If

Return pl_Linhas
end event

event ue_recuperar;// Override

Tab_1.TabPage_1.dw_1.AcceptText()

Return This.Retrieve(Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor[1])
end event

event ue_preupdate;call super::ue_preupdate;Boolean lb_Permite

DateTime ldh_Inclusao
DateTime ldh_Atualizacao

Long ll_Cidade
Long ll_Numero_Endereco

String lvs_Cd_Fornecedor
String ls_Endereco
String ls_Bairro
String ls_Fantasia
String ls_Razao
String ls_CGC
String ls_Nulo
String ls_Comprador
String ls_Tipo_Pessoa
String ls_Cpf
String ls_Edi
String ls_Atividade_Economica
String ls_Matricula_Atua

This.AcceptText()

SetNull( ls_Nulo )

If This.RowCount() > 0 Then
	
	ll_Cidade 					= This.Object.cd_cidade						[1]
	ls_Bairro						= This.Object.de_bairro						[1]
	ls_Endereco					= This.Object.de_endereco					[1]
	ll_Numero_Endereco		= This.Object.nr_endereco					[1]
	ls_Fantasia					= This.Object.nm_fantasia					[1]
	ls_Razao						= This.Object.nm_razao_social				[1]
	ls_CGC						= This.Object.nr_cgc							[1]
	ls_Comprador				= This.Object.nr_matricula_comprador	[1]
	ls_Tipo_Pessoa				= This.Object.Id_Fisica_Juridica			[1]
	ls_Cpf							= This.Object.Nr_Cpf							[1]
	ls_Edi							= This.Object.Id_Pedido_Edi				[1]
	ls_Atividade_Economica	= This.Object.Id_Atividade_Economica	[1]
	ldh_Inclusao					= This.Object.Dh_Inclusao					[1]
	ldh_Atualizacao				= This.Object.Dh_Atualizacao				[1]
	ls_Matricula_Atua			= This.Object.Nr_Matricula_Atualizacao	[1]
	
	If ls_Comprador = "" Then This.Object.nr_matricula_comprador[1] = ls_Nulo
			
	If IsNull( ls_Razao ) Or Trim(ls_Razao) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a raz$$HEX1$$e300$$ENDHEX$$o social.")
		This.Event ue_Pos(1,"nm_razao_social")
		Return -1
	End If
	
	If IsNull( ls_Fantasia ) Or Trim(ls_Fantasia) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o nome fantasia.")
		This.Event ue_Pos(1,"nm_fantasia")
		Return -1
	End If
	
	If ls_Tipo_Pessoa = 'J' Then
		If IsNull(ls_Cgc) Or Trim(ls_Cgc) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o CGC.")
			This.Event ue_Pos(1,"nr_cgc")
			Return -1
		End If 
		
		If Not gf_cgc_valido(ls_CGC)  Then
			This.Event ue_Pos(1,"nr_cgc")
			Return -1
		End If
				
	Else
		
		If IsNull(ls_Cpf) Or Trim(ls_Cpf) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o CPF.")
			This.Event ue_Pos(1,"nr_cpf")
			Return -1
		End If
		
		If Not ( gf_Nr_CPF_Valido( ls_Cpf ) ) Then
			This.Event ue_Pos(1,"nr_cpf")
			Return -1
		End If
	End If
	
	If IsNull(This.Object.Cd_Fornecedor[1]) Then
		This.Object.Dh_Inclusao[1] = gvo_Parametro.of_Dh_Movimentacao()
	Else
		If This.Modifiedcount( ) > 0 Then
			This.Object.Dh_Atualizacao				[1] = gvo_Parametro.of_Dh_Movimentacao()
			This.Object.Nr_Matricula_Atualizacao	[1] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		End If
	End If
	
	If IsNull(This.Object.Cd_Fornecedor[1]) Then
		wf_Localiza_Proximo_Codigo_Fornecedor(Ref lvs_Cd_Fornecedor)
	End If
	
	//Se for 'Z' que $$HEX1$$e900$$ENDHEX$$ igual a NENHUMA, grava o campo como nulo.
	If ls_Edi = "Z" Then
		This.Object.Id_Pedido_Edi[1] = ls_Nulo
	End If
	
	If Not IsNull(ivo_Fornecedor.Cd_Fornecedor) Then
		If Not wf_Grava_Historico_Alteracao_Principal() Then Return -1
		If Not wf_Grava_Historico_Alteracao_Telefone() Then Return -1
	End If
End If
		
Return 1
end event

event clicked;call super::clicked;If dwo.Name = "b_1" Then
	st_fornecedor str
	
	str.Cd_Fornecedor = ivo_Fornecedor.Cd_Fornecedor
	
	OpenWithParm(w_ge192_lista_divisao, str)
End If
end event

type gb_1 from groupbox within tabpage_1
integer width = 3648
integer height = 1780
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3726
integer height = 1940
long backcolor = 79741120
string text = "Contatos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
dw_2 dw_2
gb_2 gb_2
gb_3 gb_3
end type

on tabpage_2.create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.dw_3,&
this.dw_2,&
this.gb_2,&
this.gb_3}
end on

on tabpage_2.destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 18
integer y = 44
integer width = 2002
integer height = 76
integer taborder = 20
string dataobject = "dw_ge192_divisao_contato"
end type

event itemchanged;call super::itemchanged;Long ll_Divisao

This.AcceptText()

ll_Divisao = This.Object.Nr_Divisao_Fornecedor[1]

is_Divisao = MidA(String(ll_Divisao), 0,5)

If IsNull(is_Divisao) Then
	tab_1.tabpage_2.dw_2.of_ChangeDataObject("dw_ge192_cadastro_fornecedor_contato")
Else
	tab_1.tabpage_2.dw_2.of_ChangeDataObject("dw_ge192_cadastro_fornecedor_contato_informado")
End If

tab_1.tabpage_2.dw_2.Retrieve(ivo_Fornecedor.Cd_Fornecedor, ll_Divisao)

Tab_1.TabPage_2.dw_2.SetFocus()

wf_Set_Somente_Consulta()
end event

event editchanged;call super::editchanged;Tab_1.TabPage_2.dw_2.SetFocus()
end event

event ue_addrow;call super::ue_addrow;Tab_1.TabPage_2.dw_2.SetFocus()

Return 1
end event

type dw_2 from dc_uo_dw_base within tabpage_2
integer x = 23
integer y = 192
integer width = 3639
integer height = 1384
integer taborder = 20
string dataobject = "dw_ge192_cadastro_fornecedor_contato"
boolean vscrollbar = true
end type

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Tab_1.TabPage_1.dw_1.ivm_menu.mf_confirmar( True)
	Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Cancelar(True)
End If

If ivb_Valida_Salva Then
	This.Object.b_1.Enabled = False
Else
	This.Object.b_1.Enabled = True
End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;// Override

Long ll_Nulo

If Long(is_Divisao) = 0 Then
	SetNull(ll_Nulo)
	Return This.Retrieve(ivo_Fornecedor.Cd_Fornecedor, ll_Nulo)
Else
	Return This.Retrieve(ivo_Fornecedor.Cd_Fornecedor, Long(is_Divisao))
End If
end event

event ue_addrow;call super::ue_addrow;This.Object.cd_fornecedor[This.GetRow()] = ivo_Fornecedor.Cd_Fornecedor

//If Not wf_Verifica_Divisao() Then Return -1

Return 1
end event

event ue_preupdate;call super::ue_preupdate;Long 	ll_Linha,&
		ll_Linhas,&
		ll_Contato,&
		ll_Contato_Proximo,&
		ll_Find, &
		ll_Nulo, &
		ll_Asc

String ls_Fornecedor

tab_1.tabpage_1.dw_1.AcceptText()
tab_1.tabpage_2.dw_2.AcceptText()

SetNull(ll_Nulo)

ls_Fornecedor = tab_1.tabpage_1.dw_1.Object.Cd_Fornecedor[1]

If tab_1.tabpage_2.dw_2.RowCount() > 0 Then
	
	ll_Find = tab_1.tabpage_2.dw_2.Find("isnull(cd_contato)", 1, tab_1.tabpage_2.dw_2.RowCount())
	
	If ll_Find < 0 Then
		SqlCa.of_Rollback()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find que verifica se tem algum 'cd_contato' nulo.", StopSign!)
		Return -1
	End If
	
	If ll_Find > 0 Then
		SqlCa.of_Rollback()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o Tipo do contato.", Exclamation!)
		This.Event ue_Pos(ll_Find,"cd_contato")
		Return -1
	End If
	
	ll_Linhas = tab_1.tabpage_2.dw_2.RowCount()
	
	Select coalesce(max(nr_contato), 0)
	Into :ll_Contato_Proximo
	From fornecedor_contato
	Where cd_fornecedor = :ls_Fornecedor
	Using SqlCa;
			
	Choose Case SqlCa.SqlCode
		Case 100
			SqlCa.of_Rollback()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pr$$HEX1$$f300$$ENDHEX$$ximo 'nr_contato' da tabela 'fornecedor_contato'.", StopSign!)
			Return -1
			
		Case -1
			SqlCa.of_Rollback()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo 'nr_contato' da tabela 'fornecedor_contato'." + SqlCa.SQLErrText, StopSign!)
			Return -1
			
	End Choose
	
	For ll_Linha = 1 To ll_Linhas
		
		tab_1.tabpage_2.dw_2.Object.Cd_Fornecedor[ll_Linha] = ls_Fornecedor
		
		ll_Contato = tab_1.tabpage_2.dw_2.Object.nr_contato[ll_Linha]
		
		If IsNull(ll_Contato) Then
			ll_Contato_Proximo++
			Tab_1.tabpage_2.dw_2.Object.nr_contato[ll_Linha] = ll_Contato_Proximo
		End If
		
		If Long(is_Divisao) = 0 Then
			This.Object.Nr_Divisao_Fornecedor[ll_Linha] = ll_Nulo
		Else
			This.Object.Nr_Divisao_Fornecedor[ll_Linha] = Long(is_Divisao)
		End If
		
		ll_Asc = AscA(MidA(This.Object.De_Email[ll_Linha], 1, 1))
		
		If ll_Asc = 32 Or ll_Asc = 160 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Endere$$HEX1$$e700$$ENDHEX$$o de e-mail inv$$HEX1$$e100$$ENDHEX$$lido.~r~rVerifique se h$$HEX1$$e100$$ENDHEX$$ espa$$HEX1$$e700$$ENDHEX$$o em branco antes do endere$$HEX1$$e700$$ENDHEX$$o de e-mail cadastrado.", Exclamation!)
			dw_2.Event ue_Pos(ll_Linha, "de_email")
			Return -1
		End If
	Next
	
End If

Return 1
end event

event buttonclicked;call super::buttonclicked;Long ll_Contato
Long ll_GetRow
Long ll_Divisao
Long ll_Achou

String ls_Parametro
String ls_Retorno

This.AcceptText()

If Not wf_Verifica_Possui_Divisao(Ref ll_Achou) Then
	Return -1
End If

If ll_Achou > 0 Then
	
	ll_GetRow = This.GetRow()
	ll_Contato = This.Object.Nr_Contato[ll_GetRow]
	
	If IsNull(is_Divisao) or trim(is_Divisao) = "" Then
		ls_Parametro = ivo_Fornecedor.Cd_Fornecedor + '00000' + String(ll_Contato)
	Else
		ls_Parametro = ivo_Fornecedor.Cd_Fornecedor + Right('0000' + is_Divisao, 5) + String(ll_Contato)
	End If
	
//	If ib_Permite_Alteracao Then	
		OpenWithParm(w_ge192_altera_divisao, ls_Parametro)
//	End If
	
	ls_Retorno = Message.StringParm
	
	If ls_Retorno = "S" Then
		
		If IsNull(is_Divisao) Or is_Divisao = "" Then
			tab_1.tabpage_2.dw_2.of_ChangeDataObject("dw_ge192_cadastro_fornecedor_contato")
		Else
			tab_1.tabpage_2.dw_2.of_ChangeDataObject("dw_ge192_cadastro_fornecedor_contato_informado")
		End If
		
		This.Retrieve(ivo_Fornecedor.Cd_Fornecedor, Long(is_Divisao))
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor n$$HEX1$$e300$$ENDHEX$$o possui divis$$HEX1$$e300$$ENDHEX$$o.")
End If
end event

event itemchanged;call super::itemchanged;string ls_telefone, ls_retorno

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Tab_1.TabPage_1.dw_1.ivm_menu.mf_confirmar( True)
	Tab_1.TabPage_1.dw_1.ivm_Menu.mf_Cancelar(True)
End If

If ivb_Valida_Salva Then
	This.Object.b_1.Enabled = False
Else
	This.Object.b_1.Enabled = True
End If

if dwo.name = 'nr_ddd_telefone' Then
	
	if data <> '' and not isnull(data) Then
	
		if gf_valida_ddd(data) = False Then
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O c$$HEX1$$f300$$ENDHEX$$digo DDD informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.')
			return 2
		end if
		
	end if
	
end if

if dwo.name = 'nr_telefone' Then
	
	if data <> '' and not isnull(data) Then
		
		ls_telefone = data
		
		select dbo.retorna_telefone_validado('', :ls_telefone)
		into :ls_retorno
		from parametro
		Using sqlca;
	
		if sqlca.sqlcode = -1 then 
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar o banco de dados: ' + sqlca.sqlerrtext)
			return 2
		end if
	
		if isnull(ls_retorno) or ls_retorno = '' Then
			
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O n$$HEX1$$fa00$$ENDHEX$$mero de telefone informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.')
			return 2
			
		end if
		
	end if
	
end if

if dwo.name = 'de_email' then
	
	if data <> '' and not isnull(data) Then
		
		if gf_valida_email(data) = False Then
			
//			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O endere$$HEX1$$e700$$ENDHEX$$o de email informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.')
			return -1
			
		end if
	end if
end if
end event

event ue_cancel;call super::ue_cancel;This.Object.b_1.Enabled = True

Tab_1.TabPage_2.dw_2.ivm_Menu.mf_incluir( True)
Tab_1.TabPage_2.dw_2.ivm_Menu.mf_excluir( True)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	wf_Lista_Divisao_Fornecedor()
End If

Return pl_Linhas
end event

type gb_2 from groupbox within tabpage_2
integer y = 152
integer width = 3707
integer height = 1448
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within tabpage_2
integer width = 2034
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

