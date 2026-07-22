HA$PBExportHeader$w_ge222_consulta_aprova_pedido_forn.srw
forward
global type w_ge222_consulta_aprova_pedido_forn from dc_w_sheet
end type
type tab_1 from tab within w_ge222_consulta_aprova_pedido_forn
end type
type tabpage_1 from userobject within tab_1
end type
type cb_enviar_rascunho from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type st_mensagem from statictext within tabpage_1
end type
type cb_aprovar_pedido from commandbutton within tabpage_1
end type
type cb_descancelar from commandbutton within tabpage_1
end type
type gb_3 from groupbox within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type dw_3 from dc_uo_dw_base within tabpage_1
end type
type cb_cancelar_pedido from commandbutton within tabpage_1
end type
type cb_imprimir_pedido from commandbutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_enviar_rascunho cb_enviar_rascunho
cb_2 cb_2
st_mensagem st_mensagem
cb_aprovar_pedido cb_aprovar_pedido
cb_descancelar cb_descancelar
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_cancelar_pedido cb_cancelar_pedido
cb_imprimir_pedido cb_imprimir_pedido
end type
type tabpage_2 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
type tabpage_3 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_3
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_5 gb_5
dw_5 dw_5
end type
type tab_1 from tab within w_ge222_consulta_aprova_pedido_forn
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_ge222_consulta_aprova_pedido_forn from dc_w_sheet
integer width = 3621
integer height = 2016
string title = "GE222 - Aprova$$HEX2$$e700e300$$ENDHEX$$o de Pedidos de Compras de Fornecedores"
boolean maxbox = true
long backcolor = 80269524
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge222_consulta_aprova_pedido_forn w_ge222_consulta_aprova_pedido_forn

type variables
uo_Fornecedor ivo_Fornecedor
uo_Produto ivo_produto
uo_usuario ivo_usuario_liberacao
uo_pedido_central_edi ivo_pedido_edi
uo_Filial ivo_Filial

uo_ge149_Comprador io_Comprador

decimal idc_valor_maximo_liberacao
end variables

forward prototypes
public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome)
public function decimal wf_percentual_atendido (long al_pedido)
public subroutine wf_insere_filial_default ()
public subroutine wf_imprimir_relatorio ()
public function boolean wf_retorna_situacao_pedido (long al_pedido, ref string as_situacao)
public subroutine wf_marca_pedido_liberacao ()
public subroutine wf_calcula_custo ()
public function string wf_email_responsavel (string as_responsavel, ref string as_nome)
public function boolean wf_existe_pedido_selecionado (ref integer ai_pedidos)
public function boolean wf_verifica_situacao_pedido (long al_pedido, ref string as_situacao)
public function boolean wf_envia_email_responsaveis (long al_pedido, string as_responsavel, string as_email_comprador, string as_tipo)
public function boolean wf_libera_pedidos ()
public function boolean wf_valor_liberacao_pedido (string as_responsavel)
public subroutine wf_atualiza_informacoes ()
public function boolean wf_grava_historico_pedido (long al_pedido, string as_responsavel, string as_alteracao_de)
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public function boolean wf_localiza_usuario (string as_matricula, ref string as_nome);Boolean lvb_Sucesso = False

Select nm_usuario Into :as_Nome
From usuario
Where nr_matricula = :as_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio com a matr$$HEX1$$ed00$$ENDHEX$$cula '" + as_Matricula + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Usu$$HEX1$$e100$$ENDHEX$$rio")
End Choose

If Not lvb_Sucesso Then
	as_Nome = ""
End If

Return lvb_Sucesso
end function

public function decimal wf_percentual_atendido (long al_pedido);Decimal lvdc_Percentual

Long lvl_Pedida,&
     lvl_Recebida
	 
Select sum(qt_pedida), sum(qt_recebida)
Into :lvl_Pedida, :lvl_Recebida
From pedido_central_produto
Where nr_pedido =:al_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Sumariza$$HEX2$$e700e300$$ENDHEX$$o das quantidades atendidas.")
	Return 0
End If

If IsNull(lvl_Pedida)   Then lvl_Pedida   = 0
If IsNull(lvl_Recebida) Then lvl_Recebida = 0

lvdc_Percentual = Round((lvl_Recebida * 100) / lvl_Pedida, 2)

Return lvdc_Percentual
end function

public subroutine wf_insere_filial_default ();ivo_Filial.of_Localiza_Filial(String(534))

If ivo_Filial.Localizada Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
	Tab_1.TabPage_1.dw_1.Object.Nm_filial	[1] = ivo_Filial.Nm_Fantasia
Else
	ivo_Filial.of_Inicializa()
	
	Tab_1.TabPage_1.dw_1.Object.cd_filial	[1] = ivo_Filial.Cd_Filial
	Tab_1.TabPage_1.dw_1.Object.nm_filial	[1] = ivo_Filial.Nm_Fantasia
End If


end subroutine

public subroutine wf_imprimir_relatorio ();
end subroutine

public function boolean wf_retorna_situacao_pedido (long al_pedido, ref string as_situacao);Select id_situacao
Into :as_situacao
From pedido_central
Where nr_pedido =:al_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
		Return False
End Choose

Return True
end function

public subroutine wf_marca_pedido_liberacao ();Long lvl_Linha

For lvl_Linha = 1 To tab_1.TabPage_1.dw_2.RowCount()
		
	If  Tab_1.TabPage_1.dw_2.Object.id_situacao[lvl_Linha] = 'P' and &
		Tab_1.TabPage_1.dw_2.Object.vl_total_pedido[lvl_Linha] <= idc_valor_maximo_liberacao Then
		Tab_1.TabPage_1.dw_2.Object.id_liberar[lvl_Linha] = 'S'
	Else
		Tab_1.TabPage_1.dw_2.Object.id_liberar[lvl_Linha] = 'N'
	End If
		
Next





end subroutine

public subroutine wf_calcula_custo ();Decimal 	lvdc_Preco_Unitario,&
			lvdc_Desconto,&
			lvdc_Desconto_Pedido,&
			lvdc_PC_ICMS_Venda,&
			lvdc_PC_IPI,&
			lvdc_Preco_Venda_Maximo,&
			lvdc_Preco_Liquido,&
			lvdc_Valor_Compra,&
			lvdc_Reducao_ICMS,&
			lvdc_Valor_ICMS
			
Long 	lvl_Produto,&
		lvl_Condicao_Pagto,&
		lvl_Tributacao_Produto,&
		lvl_Linha,&
		lvl_Linha_Ativa,&
		ll_Classificacao_Fiscal

String	lvs_UF_Fornecedor,&
		lvs_UF_Filial,&
		lvs_Grupo,&		
		lvs_ICMS_Normal,&		
		lvs_Tributacao_ICMS,&		
		lvs_Caderno_ABCFarma,&
		lvs_Lei_Generico,&
		lvs_Situacao_Pis_Cofins,&
		ls_IPI
	//	lvs_Considera_IPI

tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha_Ativa = tab_1.TabPage_1.dw_2.GetRow()

lvs_UF_Fornecedor		= tab_1.TabPage_1.dw_2.Object.cd_uf_fornecedor	[lvl_Linha_Ativa]
lvs_UF_Filial					= tab_1.TabPage_1.dw_2.Object.cd_uf_filial	 		[lvl_Linha_Ativa]
lvdc_Desconto_Pedido	= tab_1.TabPage_1.dw_2.Object.pc_desconto			[lvl_Linha_Ativa]
ls_IPI							= tab_1.TabPage_1.dw_2.Object.id_ipi					[lvl_Linha_Ativa]

uo_simula_pedido  uo_simula
uo_Simula = Create uo_Simula_Pedido

uo_Produto	lvo_Produto
lvo_Produto = Create uo_Produto


For lvl_Linha = 1 To tab_1.TabPage_2.dw_4.RowCount()
	
	lvl_Produto 						= tab_1.TabPage_2.dw_4.Object.cd_produto					[lvl_Linha]
	lvs_Grupo						= tab_1.TabPage_2.dw_4.Object.cd_grupo						[lvl_Linha]
	lvdc_Preco_Unitario			= tab_1.TabPage_2.dw_4.Object.vl_preco_unitario			[lvl_Linha]
	lvdc_Desconto					= tab_1.TabPage_2.dw_4.Object.pc_desconto					[lvl_Linha]
	lvs_ICMS_Normal				= tab_1.TabPage_2.dw_4.Object.id_icms_normal				[lvl_Linha]
	lvdc_PC_ICMS_Venda			= tab_1.TabPage_2.dw_4.Object.pc_icms						[lvl_Linha]
	lvdc_PC_IPI						= tab_1.TabPage_2.dw_4.Object.pc_ipi							[lvl_Linha]
	lvs_Tributacao_ICMS			= tab_1.TabPage_2.dw_4.Object.cd_tributacao_icms			[lvl_Linha]
	lvl_Tributacao_Produto 		= tab_1.TabPage_2.dw_4.Object.cd_tributacao_produto		[lvl_Linha]
	lvs_Caderno_ABCFarma		= tab_1.TabPage_2.dw_4.Object.id_caderno_abcfarma		[lvl_Linha]
	lvs_Lei_Generico				= tab_1.TabPage_2.dw_4.Object.id_lei_generico				[lvl_Linha]
	lvs_Situacao_Pis_Cofins		= tab_1.TabPage_2.dw_4.Object.id_situacao_pis_cofins		[lvl_Linha]
	lvdc_Preco_Venda_Maximo	= tab_1.TabPage_2.dw_4.Object.vl_preco_venda_maximo	[lvl_Linha]
	//lvs_Considera_IPI				= tab_1.TabPage_2.dw_4.Object.id_considera_ipi_pedido	[lvl_Linha]
	ll_Classificacao_Fiscal			= tab_1.TabPage_2.dw_4.Object.nr_classificacao_fiscal		[lvl_Linha]
		
	lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
	
	If ls_IPI = "N" Then
		lvdc_PC_IPI  = 0.00
	End If

//	lvdc_Valor_Compra = uo_Simula.of_Valor_Compra(	lvdc_Preco_Unitario, lvdc_Desconto, lvdc_Desconto_Pedido,&
//																lvdc_PC_ICMS_Venda, lvs_Tributacao_ICMS, &
//																lvl_Tributacao_Produto,&
//																lvs_Caderno_ABCFarma, lvs_Lei_Generico,  &
//																lvs_UF_Filial,  lvs_UF_Fornecedor, lvs_Situacao_Pis_Cofins,&
//																lvdc_Preco_Venda_Maximo, lvo_Produto,lvs_ICMS_Normal,&
//																lvdc_PC_IPI, ll_Classificacao_Fiscal, 0.00)
																
//	lvdc_Valor_Compra = uo_Simula.of_valor_compra_nova(	lvdc_Preco_Unitario,&
//																				lvdc_Desconto,& 
//																				lvdc_Desconto_Pedido,&
//																				lvs_UF_Filial,&  
//																				lvs_UF_Fornecedor, &
//																				lvo_Produto,&
//																				lvdc_PC_IPI)
//																
//	tab_1.TabPage_2.dw_4.Object.vl_custo_pedido	[lvl_Linha] = lvdc_Valor_Compra
				
Next

Destroy(uo_Simula)
Destroy(lvo_produto)
end subroutine

public function string wf_email_responsavel (string as_responsavel, ref string as_nome);String lvs_Retorno, lvs_Nome

Select n.de_endereco_email, nm_usuario
Into :lvs_Retorno, :lvs_Nome
From nivel_liberacao_pedido_usuario n, usuario u
Where n.nr_matricula =:as_Responsavel
    and u.nr_matricula = n.nr_matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If IsNull(lvs_Retorno) Then
			lvs_Retorno = "clamed@clamed.com.br"
			lvs_Nome	= "Respons$$HEX1$$e100$$ENDHEX$$vel"
		End If
		
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do e-mail do respons$$HEX1$$e100$$ENDHEX$$vel")
		lvs_Retorno = "clamed@clamed.com.br"
		lvs_Nome	= "Respons$$HEX1$$e100$$ENDHEX$$vel"
End Choose

Return lvs_Retorno
end function

public function boolean wf_existe_pedido_selecionado (ref integer ai_pedidos);String ls_Mensagem

ai_pedidos = Tab_1.TabPage_1.dw_2.GetItemNumber(Tab_1.TabPage_1.dw_2.RowCount(), "total_pedidos")

If ai_pedidos = 0 Then
	MessageBox('Aten$$HEX1$$e700$$ENDHEX$$ao', 'Nenhum pedido foi selecionado.', Exclamation!)
	Return False
End If

If ai_pedidos = 1 Then
	ls_Mensagem = 'Confirma a aprova$$HEX2$$e700e300$$ENDHEX$$o do pedido selecionado ?'
Else
	ls_Mensagem = 'Confirma a aprova$$HEX2$$e700e300$$ENDHEX$$o dos pedidos selecionados ?'
End If

If MessageBox('Aten$$HEX1$$e700$$ENDHEX$$ao', ls_Mensagem, Question!, YesNo!, 2)  = 2 Then
	Return False
End If

Return true
end function

public function boolean wf_verifica_situacao_pedido (long al_pedido, ref string as_situacao);String ls_Matricula, ls_Usuario

DateTime ldt_Liberacao

Select p.id_situacao, p.nr_matricula_liberacao, u.nm_usuario, dh_liberacao
Into :as_Situacao, :ls_Matricula, :ls_Usuario, :ldt_Liberacao
From pedido_central p, usuario u
Where u.nr_matricula	=* p.nr_matricula_liberacao
	and nr_pedido 		= :al_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If as_Situacao <> "P" Then
			
			If as_Situacao = 'C' Then
				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido '" + String(al_Pedido) + "'  j$$HEX1$$e100$$ENDHEX$$ foi liberado pelo '" + ls_Usuario +&
								"' no dia '" + String(ldt_Liberacao, "dd/mm/yyyy hh:mm:ss") + "'.", Exclamation!)
				
			End If
						
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido '" + String(al_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
		Return False
End Choose

Return True



end function

public function boolean wf_envia_email_responsaveis (long al_pedido, string as_responsavel, string as_email_comprador, string as_tipo);Boolean lvb_Sucesso = True

Long lvl_Linhas, lvl_Linha, lvl_Contador = 1

String	lvs_Enter,&
		lvs_Mensagem,&
		lvs_Email_Comprador[],&
		lvs_Email_Responsavel,&
		lvs_Nome_Resp,&
		lvs_Matricula,&
		lvs_Email,&
		lvs_Assunto

SetPointer(HourGlass!)

uo_ge219_Liberacao_Pedido_Central uo_Liberacao
uo_Liberacao = Create uo_ge219_Liberacao_Pedido_Central

lvs_Email_Responsavel = wf_Email_Responsavel(as_Responsavel, ref  lvs_Nome_Resp)

dc_uo_ds_base uo_ds
uo_ds = Create dc_uo_ds_base 

If Not uo_ds.of_ChangeDataObject("dw_ge222_lista_usuarios_liberacao") Then
	Destroy(uo_ds)
	Destroy(uo_Liberacao)
	Return False
End If

lvl_Linhas = uo_ds.Retrieve(al_Pedido) 

lvs_Email_Comprador[lvl_Contador]	= as_email_comprador

For lvl_Linha = 1 To lvl_Linhas
	
	lvs_Matricula = uo_ds.Object.nr_matricula[lvl_Linha]
	
	If lvs_Matricula <> as_Responsavel Then
		
		lvl_Contador ++
		
		lvs_Email_Comprador[lvl_Contador]	= uo_ds.Object.de_endereco_email[lvl_Linha]
		
	End If
			
Next

lvs_Enter = char(13)+char(10)

If as_tipo = "A" then
	
	lvs_Assunto = "Pedido de Compra APROVADO"

	lvs_Mensagem =	"O pedido '" +&
							String(al_Pedido) + "' foi aprovado e esta liberado para a impress$$HEX1$$e300$$ENDHEX$$o." +&
							lvs_Enter + lvs_Enter +  "Email autom$$HEX1$$e100$$ENDHEX$$tico."
							
ElseIf as_tipo = "X" then
	
		lvs_Assunto = "Pedido de Compra CANCELADO"
		
		lvs_Mensagem =	"O pedido '" + String(al_Pedido) + "' foi cancelado." +&
							lvs_Enter + lvs_Enter +  "Email autom$$HEX1$$e100$$ENDHEX$$tico."
							
Else
	
	lvs_Assunto = "Pedido de Compra Enviado para Rascunho"
		
	lvs_Mensagem =	"O pedido '" + String(al_Pedido) + "' foi enviado para rascunho." +&
							lvs_Enter + lvs_Enter +  "Email autom$$HEX1$$e100$$ENDHEX$$tico."
							
End If



						
uo_Liberacao.of_Envia_Email(lvs_Nome_Resp, lvs_Assunto, lvs_Mensagem, lvs_Email_Responsavel, lvs_Email_Comprador)

Destroy(uo_Liberacao)

SetPointer(Arrow!)

Return True
end function

public function boolean wf_libera_pedidos ();Boolean lvb_Sucesso = True

Long lvl_Linha, lvl_Pedido, lvl_Notas

Integer lvi_Pedidos, lvi_Aprovados

String lvs_Situacao, lvs_Liberar, lvs_Email, lvs_Responsavel, lvs_Situacao_Parametro

If Not wf_existe_pedido_selecionado(ref lvi_Pedidos) Then Return False

If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE222_LIBERACAO_PROCEDIMENTO", Ref lvs_Responsavel) Then Return False

SetPointer(HourGlass!)

For lvl_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
	
	lvl_Pedido 				= Tab_1.TabPage_1.dw_2.Object.nr_pedido				[lvl_Linha]
	lvs_Situacao 			= Tab_1.TabPage_1.dw_2.Object.id_situacao				[lvl_Linha]
	lvs_Liberar 				= Tab_1.TabPage_1.dw_2.Object.id_liberar					[lvl_Linha]
	lvs_Email					= Tab_1.TabPage_1.dw_2.Object.de_endereco_email	[lvl_Linha]
		
	If	lvs_Liberar = 'S' Then
						
		If Not wf_Verifica_Situacao_Pedido(lvl_Pedido, Ref lvs_Situacao) Then
			lvb_Sucesso = False
			Exit
		End If
		
		If lvs_Situacao = 'P' Then
			
			lvs_Situacao_Parametro = 'C'
			
			Select count(nr_nf)
			Into :lvl_Notas
			From nf_compra
			Where cd_filial 					= 534
			    and nr_pedido_central 	= :lvl_Pedido
			 Using SqlCa;
			 
			 Choose Case SqlCa.SqlCode 
				Case 0
					If lvl_Notas > 0 Then
						lvs_Situacao_Parametro = 'A'
					End If
				Case 100
				Case -1
					SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das notas fiscais de compras do pedido '" + String(lvl_Pedido) + "'")
					lvb_Sucesso = False
					Exit
			End Choose

			Update pedido_central
			Set id_situacao              		= :lvs_Situacao_Parametro,
				 dh_liberacao           		= getdate(),
				 nr_matricula_liberacao	= :lvs_Responsavel
			Where nr_pedido = :lvl_Pedido
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Libera$$HEX2$$e700e300$$ENDHEX$$o do Pedido '" + String(lvl_Pedido) + "'")
				SqlCa.of_RollBack();
				lvb_Sucesso = False
			Else
				SqlCa.of_Commit();	
				
				lvi_Aprovados ++
				
				wf_Envia_Email_Responsaveis(lvl_Pedido, lvs_Responsavel, lvs_Email, "A")
							
			End If
			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido '" + String(lvl_Pedido) + " n$$HEX1$$e300$$ENDHEX$$o esta mais PENDENTE.", Exclamation!)		
		End If // Pendente
		
	End If // Marcado
		
Next

If lvb_Sucesso and lvi_Aprovados > 0 Then
	
	If lvi_Aprovados > 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Todos os pedidos foram liberados com sucesso.", Information!)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido foi aprovado com sucesso.", Information!)
	End If
	
End If

SetPointer(Arrow!)

Return True
end function

public function boolean wf_valor_liberacao_pedido (string as_responsavel);Boolean lvb_Retorno

uo_ge219_liberacao_pedido_central lvo_Liberacao
lvo_Liberacao = Create uo_ge219_liberacao_pedido_central

lvb_Retorno = lvo_Liberacao.of_verifica_valor_maximo_liberacao(as_responsavel, ref idc_valor_maximo_liberacao)

Tab_1.TabPage_1.st_mensagem.Text = "Valor m$$HEX1$$e100$$ENDHEX$$ximo liberado para este perfil $$HEX1$$e900$$ENDHEX$$ de 'R$ " +  String(idc_valor_maximo_liberacao, "#,##0.00") + "'."

Destroy(lvo_Liberacao)

Return lvb_Retorno
end function

public subroutine wf_atualiza_informacoes ();Decimal 	lvdc_Preco_Unitario,&
			lvdc_Desconto,&
			lvdc_Desconto_Pedido,&
			lvdc_PC_ICMS_Venda,&
			lvdc_PC_IPI,&
			lvdc_Preco_Venda_Maximo,&
			lvdc_Preco_Liquido,&
			lvdc_Reducao_ICMS,&
			lvdc_Valor_ICMS,&
			lvdc_Valor_Compra_Fab,&
			lvdc_Valor_Compra_Dist,&
			lvdc_Variacao
			
Long 	lvl_Produto,&
		lvl_Condicao_Pagto,&
		lvl_Tributacao_Produto,&
		lvl_Linha,&
		lvl_Linha_Ativa,&
		ll_Classificacao_Fiscal

String	lvs_UF_Fornecedor,&
		lvs_UF_Filial,&
		lvs_Grupo,&		
		lvs_ICMS_Normal,&		
		lvs_Tributacao_ICMS,&		
		lvs_Caderno_ABCFarma,&
		lvs_Lei_Generico,&
		lvs_Situacao_Pis_Cofins,&
		lvs_Considera_IPI

tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha_Ativa = tab_1.TabPage_1.dw_2.GetRow()

lvs_UF_Fornecedor		= tab_1.TabPage_1.dw_2.Object.cd_uf_fornecedor	[lvl_Linha_Ativa]
lvs_UF_Filial					= tab_1.TabPage_1.dw_2.Object.cd_uf_filial	 		[lvl_Linha_Ativa]
lvdc_Desconto_Pedido	= tab_1.TabPage_1.dw_2.Object.pc_desconto			[lvl_Linha_Ativa]

uo_simula_pedido  uo_simula
uo_Simula = Create uo_Simula_Pedido

uo_Produto	lvo_Produto
lvo_Produto = Create uo_Produto


For lvl_Linha = 1 To tab_1.TabPage_2.dw_4.RowCount()
	
	lvl_Produto 						= tab_1.TabPage_2.dw_4.Object.cd_produto					[lvl_Linha]
	lvs_Grupo						= tab_1.TabPage_2.dw_4.Object.cd_grupo						[lvl_Linha]
	lvdc_Preco_Unitario			= tab_1.TabPage_2.dw_4.Object.vl_preco_unitario			[lvl_Linha]
	lvdc_Desconto					= tab_1.TabPage_2.dw_4.Object.pc_desconto					[lvl_Linha]
	lvs_ICMS_Normal				= tab_1.TabPage_2.dw_4.Object.id_icms_normal				[lvl_Linha]
	lvdc_PC_ICMS_Venda			= tab_1.TabPage_2.dw_4.Object.pc_icms						[lvl_Linha]
	lvdc_PC_IPI						= tab_1.TabPage_2.dw_4.Object.pc_ipi							[lvl_Linha]
	lvs_Tributacao_ICMS			= tab_1.TabPage_2.dw_4.Object.cd_tributacao_icms			[lvl_Linha]
	lvl_Tributacao_Produto 		= tab_1.TabPage_2.dw_4.Object.cd_tributacao_produto		[lvl_Linha]
	lvs_Caderno_ABCFarma		= tab_1.TabPage_2.dw_4.Object.id_caderno_abcfarma		[lvl_Linha]
	lvs_Lei_Generico				= tab_1.TabPage_2.dw_4.Object.id_lei_generico				[lvl_Linha]
	lvs_Situacao_Pis_Cofins		= tab_1.TabPage_2.dw_4.Object.id_situacao_pis_cofins		[lvl_Linha]
	lvdc_Preco_Venda_Maximo	= tab_1.TabPage_2.dw_4.Object.vl_preco_venda_maximo	[lvl_Linha]
	lvs_Considera_IPI				= tab_1.TabPage_2.dw_4.Object.id_considera_ipi_pedido	[lvl_Linha]
	ll_Classificacao_Fiscal			= tab_1.TabPage_2.dw_4.Object.nr_classificacao_fiscal		[lvl_Linha]
	
	lvdc_Valor_Compra_Fab = tab_1.TabPage_2.dw_4.Object.vl_preco_final_fab					[lvl_Linha]
	lvdc_Valor_Compra_Dist = tab_1.TabPage_2.dw_4.Object.vl_preco_final_dist				[lvl_Linha]

	lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
	
	If lvs_Considera_IPI = "N" Then
		lvdc_PC_IPI  = 0.00
	End If
	
//	lvdc_Valor_Compra = uo_Simula.of_Valor_Compra(	lvdc_Preco_Unitario, lvdc_Desconto, lvdc_Desconto_Pedido,&
//																lvdc_PC_ICMS_Venda, lvs_Tributacao_ICMS, &
//																lvl_Tributacao_Produto,&
//																lvs_Caderno_ABCFarma, lvs_Lei_Generico,  &
//																lvs_UF_Filial,  lvs_UF_Fornecedor, lvs_Situacao_Pis_Cofins,&
//																lvdc_Preco_Venda_Maximo, lvo_Produto,lvs_ICMS_Normal,&
//																lvdc_PC_IPI, ll_Classificacao_Fiscal, 0.00)
		
//	tab_1.TabPage_2.dw_4.Object.vl_custo_pedido	[lvl_Linha] = lvdc_Valor_Compra
	
	If lvdc_Valor_Compra_Dist > 0 Then
		lvdc_Variacao = round(((lvdc_Valor_Compra_Dist - lvdc_Valor_Compra_Fab) / lvdc_Valor_Compra_Fab) * 100, 2)
	Else
		// Se o produto n$$HEX1$$e300$$ENDHEX$$o tiver relacionado com nenhuma distribuidora o percentual fica zerado
		lvdc_Variacao = 0.00
	End If
	
	tab_1.TabPage_2.dw_4.Object.vl_variacao[lvl_Linha] = lvdc_Variacao
					
Next

Destroy(uo_Simula)
Destroy(lvo_produto)
end subroutine

public function boolean wf_grava_historico_pedido (long al_pedido, string as_responsavel, string as_alteracao_de);Insert into historico_alteracao_pedido
			(nr_pedido,
			 dh_alteracao,
			 nr_matricula_alteracao,
			 cd_tipo_alteracao,
			 nm_coluna,
			 de_alteracao_de,
			 de_alteracao_para,
			 nr_matric_liberacao_alteracao)
values (	:al_Pedido,
			getdate(),
			:as_responsavel,
			'A',
			'ID_SITUACAO',
			:as_Alteracao_De,
			'R',
			:as_responsavel)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao gravar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
	Return False
End If

Return True
end function

on w_ge222_consulta_aprova_pedido_forn.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge222_consulta_aprova_pedido_forn.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Movimentacao

String lvs_Responsavel

lvdt_Movimentacao = Date(gvo_Parametro.of_Dh_Movimentacao())

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_3.Event ue_AddRow()

Tab_1.TabPage_1.dw_1.Object.dt_pedido_inicio  		[1] = relativedate(lvdt_Movimentacao, -3) 
Tab_1.TabPage_1.dw_1.Object.dt_pedido_termino 	[1] = relativedate(lvdt_Movimentacao, 30) 

Tab_1.TabPage_1.dw_1.SetFocus()

ivm_Menu.mf_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)

ivm_Menu.ivb_Permite_Imprimir = True

wf_Insere_Filial_Default()

If Tab_1.TabPage_1.dw_1.Object.Id_Situacao[1] = "P" Then
	Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Inicio.Visible = 0
	Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Termino.Visible = 0
	
	Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Inicio_t.Visible = 0
	Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Termino_t.Visible = 0
Else
	Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Inicio.Visible = 1
	Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Termino.Visible = 1
	
	Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Inicio_t.Visible = 1
	Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Termino_t.Visible = 1
End If

If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE222_LIBERACAO_PROCEDIMENTO", Ref lvs_Responsavel) Then 
	Close(This)
	Return
End If

If Not wf_Valor_Liberacao_Pedido(lvs_Responsavel) Then
	Close(This)
End If
end event

event open;call super::open;ivo_Fornecedor 			= Create uo_Fornecedor
ivo_Produto    				= Create uo_Produto
ivo_Usuario_Liberacao	= Create uo_Usuario
ivo_Pedido_EDI 			= Create uo_Pedido_Central_EDI
ivo_Filial						= Create uo_Filial
io_Comprador				= Create uo_ge149_Comprador

Tab_1.TabPage_1.dw_1.of_SetMenu(ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(ivm_Menu)
Tab_1.TabPage_1.dw_3.of_SetMenu(ivm_Menu)
Tab_1.TabPage_2.dw_4.of_SetMenu(ivm_Menu)
end event

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_Produto)
Destroy(ivo_Usuario_Liberacao)
Destroy(ivo_Pedido_EDI)
Destroy(ivo_Filial)
Destroy(io_Comprador)
end event

event ue_print;This.Event ue_PrintImmediate()
end event

event ue_printimmediate;Long 	lvl_Pedido

Date	lvdt_Pedido_I, &
     	lvdt_Pedido_T
	  
String	lvs_Usuario,&
		lvs_Matricula_Lib,&
		lvs_Situacao

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("dw_ge222_relatorio_pedido") Then
	Destroy(lvds)
	Return
End If

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Pedido     		= Tab_1.TabPage_1.dw_1.Object.Nr_Pedido					[1]
lvdt_Pedido_I  		= Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Inicio			[1]
lvdt_Pedido_T  		= Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Termino		[1]
lvs_Usuario    		= Tab_1.TabPage_1.dw_1.Object.nr_matricula					[1]
lvs_Matricula_Lib	= Tab_1.TabPage_1.dw_1.Object.nr_matricula_liberacao	[1]
lvs_Situacao			= Tab_1.TabPage_1.dw_1.Object.id_situacao					[1]

If Not IsNull(lvl_Pedido) and lvl_Pedido > 0 Then
	lvds.of_AppendWhere("p.nr_pedido = " + String(lvl_Pedido))
Else
	
	If Not IsNull(lvdt_Pedido_I) Then
		lvds.of_AppendWhere("p.dh_pedido >= '" + String(lvdt_Pedido_I, "yyyy/mm/dd") + "'")
	End If
	
	If Not IsNull(lvdt_Pedido_T) Then
		lvds.of_AppendWhere("p.dh_pedido <= '" + String(lvdt_Pedido_T, "yyyy/mm/dd") + "'")
	End If

	If Not IsNull(lvs_Usuario) and lvs_Usuario <> ""  Then
		lvds.of_AppendWhere("p.nr_matricula_cadastramento = '" + lvs_Usuario + "'")
	End If
	
	If Not IsNull(lvs_Matricula_Lib) and lvs_Matricula_Lib <> ""  Then
		lvds.of_AppendWhere("p.nr_matricula_liberacao = '" + lvs_Matricula_Lib + "'")
	End If
	
End If

If lvs_Situacao <> 'T' Then
	// Liberados
	If lvs_Situacao = 'L' Then
		lvds.of_AppendWhere("p.dh_liberacao is not null ")
	Else
		lvds.of_AppendWhere("p.id_situacao = '" + lvs_Situacao + "'")
	End If
End If

lvds.Object.st_periodo.Text = String(lvdt_Pedido_I,"dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Pedido_T,"dd/mm/yyyy")

SetPointer(HourGlass!)

If lvds.Retrieve(lvl_Pedido) > 0 Then
	lvds.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados do pedido n$$HEX1$$e300$$ENDHEX$$o localizados para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
End If

SetPointer(Arrow!)

Destroy(lvds)



//Long lvl_Linha, &
//     lvl_Pedido
//	  
//String lvs_Situacao
//
//lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()
//
//If lvl_Linha = 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para imprimir.", StopSign!)
//	Return
//End If
//
//lvl_Pedido   = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido  [lvl_Linha]
//
//If Not wf_Retorna_Situacao_Pedido(lvl_Pedido,  Ref lvs_Situacao) Then
//	Return
//End If
//
////lvs_Situacao = Tab_1.TabPage_1.dw_2.Object.Id_Situacao[lvl_Linha]
//
//If lvs_Situacao = "X" Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o [CANCELADO] n$$HEX1$$e300$$ENDHEX$$o podem ser impressos.", Information!)
//	Tab_1.TabPage_1.dw_2.SetFocus()
//	Return	
//End If
//
//If lvs_Situacao = "P" Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os pedidos com situa$$HEX2$$e700e300$$ENDHEX$$o [PENDENTE] n$$HEX1$$e300$$ENDHEX$$o podem ser impressos.", Information!)
//	Tab_1.TabPage_1.dw_2.SetFocus()
//	Return	
//End If
//
//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a impress$$HEX1$$e300$$ENDHEX$$o do pedido '" + String(lvl_Pedido) + "' ?", Question!, YesNo!, 2) = 2 Then
//	Return
//End If
//
//dc_uo_ds_Base lvds
//lvds = Create dc_uo_ds_Base
//
//If Not lvds.of_ChangeDataObject("dw_ge147_impressao_pedido") Then
//	Destroy(lvds)
//	Return
//End If
//
//SetPointer(HourGlass!)
//
//If lvds.Retrieve(lvl_Pedido) > 0 Then
//	lvds.Print()
//Else
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados do pedido n$$HEX1$$e300$$ENDHEX$$o localizados para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
//End If
//
//SetPointer(Arrow!)
//
//Destroy(lvds)



end event

type dw_visual from dc_w_sheet`dw_visual within w_ge222_consulta_aprova_pedido_forn
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge222_consulta_aprova_pedido_forn
end type

type tab_1 from tab within w_ge222_consulta_aprova_pedido_forn
integer x = 5
integer y = 4
integer width = 3561
integer height = 1820
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;Long ll_Linha

If NewIndex = 2 or NewIndex = 3 Then
	
	ll_Linha = Tab_1.TabPage_1.dw_2.GetRow()

	If ll_Linha <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para visualizar os produtos.", StopSign!)
		Return 1
	End If
	
	If NewIndex = 2 Then
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
		Return 0
	End If
	
	If NewIndex = 3 Then
		Tab_1.TabPage_3.dw_5.Event ue_Retrieve()
		Return 0
	End If
	
End If


end event

event selectionchanged;Choose Case NewIndex
	Case 1
		Tab_1.TabPage_1.dw_2.SetFocus()
		
		If Tab_1.TabPage_1.dw_1.RowCount() > 0 Then ivm_Menu.mf_Imprimir(True)
		
	Case 2
		Tab_1.TabPage_2.dw_4.SetFocus()
		
	Case 3
		Tab_1.TabPage_3.dw_5.SetFocus()
End Choose
	
Parent.Width  = This.Width + 45
Parent.Height = This.Height + 110
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3525
integer height = 1704
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Pedidos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_enviar_rascunho cb_enviar_rascunho
cb_2 cb_2
st_mensagem st_mensagem
cb_aprovar_pedido cb_aprovar_pedido
cb_descancelar cb_descancelar
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_cancelar_pedido cb_cancelar_pedido
cb_imprimir_pedido cb_imprimir_pedido
end type

on tabpage_1.create
this.cb_enviar_rascunho=create cb_enviar_rascunho
this.cb_2=create cb_2
this.st_mensagem=create st_mensagem
this.cb_aprovar_pedido=create cb_aprovar_pedido
this.cb_descancelar=create cb_descancelar
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_cancelar_pedido=create cb_cancelar_pedido
this.cb_imprimir_pedido=create cb_imprimir_pedido
this.Control[]={this.cb_enviar_rascunho,&
this.cb_2,&
this.st_mensagem,&
this.cb_aprovar_pedido,&
this.cb_descancelar,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.dw_3,&
this.cb_cancelar_pedido,&
this.cb_imprimir_pedido}
end on

on tabpage_1.destroy
destroy(this.cb_enviar_rascunho)
destroy(this.cb_2)
destroy(this.st_mensagem)
destroy(this.cb_aprovar_pedido)
destroy(this.cb_descancelar)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_cancelar_pedido)
destroy(this.cb_imprimir_pedido)
end on

type cb_enviar_rascunho from commandbutton within tabpage_1
integer x = 1541
integer y = 1068
integer width = 626
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Voltar para Rascunho"
end type

event clicked;DateTime ldh_Emissao
DateTime ldh_GetDate

Long 	lvl_Linha, &
     	lvl_Pedido, &
	 	ll_Diferenca_Dias
	  
String	lvs_Situacao,&
	   	lvs_Responsavel,&
		lvs_Email

lvl_Linha = dw_2.GetRow()

If lvl_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para voltar para rascunho.", StopSign!)
	Return
End If

lvl_Pedido   		= Tab_1.TabPage_1.dw_2.Object.Nr_Pedido				[lvl_Linha]
lvs_Situacao		= Tab_1.TabPage_1.dw_2.Object.Id_Situacao				[lvl_Linha]
lvs_Email			= Tab_1.TabPage_1.dw_2.Object.de_endereco_email	[lvl_Linha]
ldh_Emissao		= Tab_1.TabPage_1.dw_2.Object.Dh_Emissao				[lvl_Linha]
ldh_GetDate		= gf_GetServerDate()
	
If lvs_Situacao <> "P" and lvs_Situacao <> "C"  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido com situa$$HEX2$$e700e300$$ENDHEX$$o [PENDENTE] ou [COLOCADO] pode voltar a situa$$HEX2$$e700e300$$ENDHEX$$o para rascunho.", Information!)
	dw_2.SetFocus()
	Return	
End If

ll_Diferenca_Dias = DaysAfter(Date(ldh_Emissao), Date(ldh_GetDate))

If lvs_Situacao = "C" Then
	If ll_Diferenca_Dias > 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO' com emiss$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ mais de um dia n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterado para rascunho.")
		dw_2.SetFocus()
		Return -1
	End If
End If

If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE222_LIBERACAO_PROCEDIMENTO", Ref lvs_Responsavel) Then Return

wf_valor_liberacao_pedido(lvs_Responsavel)

If Tab_1.TabPage_1.dw_2.Object.vl_total_pedido[lvl_Linha] > idc_valor_maximo_liberacao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O valor deste pedido ultrapassa o permitido para a sua al$$HEX1$$e700$$ENDHEX$$ada.", Exclamation!)	
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do '" + String(lvl_Pedido) + "' para rascunho ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

SetPointer(HourGlass!)

Update pedido_central
Set	id_situacao               		= 'R',
    		dh_liberacao           		= getdate(),
		nr_matricula_liberacao	= :lvs_Responsavel,
		id_situacao_anterior		= :lvs_Situacao
Where nr_pedido = :lvl_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido para rascunho")
Else
	
	If wf_grava_historico_pedido(lvl_Pedido, lvs_Responsavel, lvs_Situacao) Then
		SqlCa.of_Commit()	
	End If
	
	wf_Envia_Email_Responsaveis(lvl_Pedido, lvs_Responsavel, lvs_Email, "R")
		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido '" + String(lvl_Pedido) + "' enviado para rascunho com sucesso.", Information!)
	
	dw_2.Event ue_Retrieve()
End If

SetPointer(Arrow!)
end event

type cb_2 from commandbutton within tabpage_1
integer x = 9
integer y = 1068
integer width = 891
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Niveis de Aprova$$HEX2$$e700e300$$ENDHEX$$o de Pedidos"
end type

event clicked;Open(w_ge222_consulta_perfil)
end event

type st_mensagem from statictext within tabpage_1
boolean visible = false
integer x = 9
integer y = 1076
integer width = 1696
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type cb_aprovar_pedido from commandbutton within tabpage_1
integer x = 2949
integer y = 1068
integer width = 558
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Aprovar Pedido"
end type

event clicked;Long 	lvl_Pedido, &
		lvl_Linha
		
String lvs_Situacao, &
		lvs_Responsavel,&
		lvs_aux

lvl_Linha = dw_2.GetRow()

If wf_Libera_Pedidos() Then
	dw_2.Event ue_Retrieve()
End If



end event

type cb_descancelar from commandbutton within tabpage_1
boolean visible = false
integer x = 1202
integer y = 1084
integer width = 603
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Descancelar Pedido"
end type

event clicked;Long 	lvl_Pedido, &
		lvl_Linha
		
String lvs_Situacao, &
		lvs_Responsavel,&
		lvs_aux


lvl_Linha = dw_2.GetRow()

If	lvl_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um pedido para reverter o cancelamento", StopSign!)
	Return
End If

lvs_Situacao 	= dw_2.Object.id_situacao[lvl_Linha]
lvl_Pedido 		= dw_2.Object.nr_Pedido  [lvl_Linha]

If lvs_Situacao <> 'X' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A situa$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o se encontra [CANCELADO]. Selecione apenas pedidos Cancelados.", Information!)
	dw_2.setFocus()
	Return
End If

//
If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE147_DESCANCELAMENTO_PEDIDO", ref lvs_Responsavel) Then Return

lvs_aux = String(lvl_Pedido,"0000000000") + lvs_Responsavel

OpenWithParm(w_ge147_descancelamento_pedido, lvs_aux)

dw_2.Event ue_Retrieve()



	
end event

type gb_3 from groupbox within tabpage_1
integer x = 9
integer y = 1180
integer width = 3497
integer height = 512
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes do Pedido Selecionado"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 388
integer width = 3497
integer height = 660
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Pedidos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 9
integer y = 12
integer width = 3497
integer height = 360
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

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 76
integer width = 3451
integer height = 268
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge222_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event losefocus;call super::losefocus;If IsValid(io_Comprador) Then
	This.Object.nr_matricula[1] = io_Comprador.nr_matricula
	This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
End If
end event

event itemchanged;call super::itemchanged;If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Comprador.nm_usuario Then
			Return 1
		End If
	Else
		io_Comprador.of_Inicializa()
		
		This.Object.nr_matricula[1] = io_Comprador.nr_matricula
		This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
	End If
End If

If dwo.Name = "nm_responsavel_liberacao" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Usuario_Liberacao.nm_usuario Then
			Return 1
		End If
	Else
		ivo_Usuario_Liberacao.of_Inicializa()
		
		This.Object.nr_matricula_liberacao		[1] = ivo_Usuario_Liberacao.nr_matricula
		This.Object.nm_responsavel_liberacao	[1] = ivo_Usuario_Liberacao.nm_usuario
	End If
End If

If dwo.Name = "id_situacao" Then
	If Data = "P" Then
		This.Object.Dt_Pedido_Inicio.Visible = 0
		This.Object.Dt_Pedido_Termino.Visible = 0
		
		This.Object.Dt_Pedido_Inicio_t.Visible = 0
		This.Object.Dt_Pedido_Termino_t.Visible = 0
	Else
		This.Object.Dt_Pedido_Inicio.Visible = 1
		This.Object.Dt_Pedido_Termino.Visible = 1
		
		This.Object.Dt_Pedido_Inicio_t.Visible = 1
		This.Object.Dt_Pedido_Termino_t.Visible = 1
	End If
End If
end event

event ue_key;If Key = KeyEnter! Then

	If This.GetColumnName() = "nm_usuario" Then
		io_Comprador.of_Localiza_Comprador(This.GetText())
		
		If io_Comprador.Localizado Then
			This.Object.nr_matricula[1] = io_Comprador.nr_matricula
			This.Object.nm_usuario  [1] = io_Comprador.nm_usuario
		End If
	End If
	
	If This.GetColumnName() = "nm_responsavel_liberacao" Then
		ivo_Usuario_Liberacao.of_Localiza_Usuario(This.GetText())
		
		If ivo_Usuario_Liberacao.Localizado Then
			This.Object.nr_matricula_liberacao		[1] = ivo_Usuario_Liberacao.nr_matricula
			This.Object.nm_responsavel_liberacao	[1] = ivo_Usuario_Liberacao.nm_usuario
		End If
	End If

End If


	
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 41
integer y = 452
integer width = 3447
integer height = 560
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge222_lista_pedido"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir, &
		  lvb_Habilitar = False

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir	= True
	lvb_Habilitar	= True
	
	//This.of_SetRowSelection("if (id_situacao = ~"X~", rgb(255, 0, 0), if(id_situacao = ~"E~",rgb(0, 255, 0), if(id_situacao = ~"V~",rgb(192, 192, 192), rgb(255, 255, 255))))","")
	
//	This.of_SetRowSelection("if(id_situacao = ~"P~" and vl_total_pedido > " +&
//									gf_Replace(String(idc_valor_maximo_liberacao), ',','.',0)  +&
//									",rgb(192, 192, 192), rgb(255, 255, 255))","")

	This.of_SetRowSelection("if(id_situacao = ~"P~" and vl_total_pedido > " +&
									gf_Replace(String(idc_valor_maximo_liberacao), ',','.',0)  +&
									",rgb(192, 192, 192), if(id_situacao = ~"X~", rgb(255,0,0), rgb(255, 255, 255)))","")
	
	//wf_Marca_Pedido_Liberacao()
	
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		Tab_1.TabPage_1.dw_3.Reset()
		Tab_1.TabPage_1.dw_3.Event ue_AddRow()
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido localizado com os par$$HEX1$$e200$$ENDHEX$$metros informados.", Information!)
				
		Tab_1.TabPage_1.dw_3.SetFocus()
	End If
End If

ivm_Menu.mf_Classificar(lvb_Classificar)
ivm_Menu.mf_Filtrar(lvb_Filtrar)
ivm_Menu.mf_Localizar(lvb_Localizar)
ivm_Menu.mf_Imprimir(lvb_Imprimir)

cb_Cancelar_Pedido.Enabled = lvb_Habilitar
cb_Imprimir_Pedido.Enabled = lvb_Habilitar
cb_Descancelar.Enabled 		 = lvb_Habilitar

Return pl_Linhas
end event

event rowfocuschanged;call super::rowfocuschanged;Decimal lvdc_Percentual_Atendido

Long lvl_Pedido

String lvs_Nome,&
       lvs_Situacao 

If CurrentRow > 0 Then
	Tab_1.TabPage_1.dw_3.Object.Dh_Emissao                			[1] = Tab_1.TabPage_1.dw_2.Object.Dh_Emissao                					[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Qt_Dias_Suprimento        		[1] = Tab_1.TabPage_1.dw_2.Object.Qt_Dias_Suprimento        				[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Cd_Condicao_Pagamento     	[1] = Tab_1.TabPage_1.dw_2.Object.Cd_Condicao_Pagamento     			[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.De_Condicao_Pagamento     	[1] = Tab_1.TabPage_1.dw_2.Object.De_Condicao               					[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Pc_desconto               			[1] = Tab_1.TabPage_1.dw_2.Object.Pc_Desconto               					[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cadastramento	[1] = Tab_1.TabPage_1.dw_2.Object.Nr_Matricula_Cadastramento			[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Dh_Cancelamento           		[1] = Tab_1.TabPage_1.dw_2.Object.Dh_Cancelamento           				[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cancelamento 	[1] = Tab_1.TabPage_1.dw_2.Object.Nr_Matricula_Cancelamento 			[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.De_Observacao             			[1] = Tab_1.TabPage_1.dw_2.Object.De_Observacao             					[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.nr_matricula_liberacao           	[1] = Tab_1.TabPage_1.dw_2.Object.nr_matricula_liberacao             		[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.nm_responsavel_liberacao      	[1] = Tab_1.TabPage_1.dw_2.Object.nm_responsavel_liberacao             	[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.dh_liberacao      					[1] = Tab_1.TabPage_1.dw_2.Object.dh_liberacao									[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.Nm_Cancelamento					[1] = Tab_1.TabPage_1.dw_2.Object.nm_responsavel_cancelamento		[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.nm_cadastramento				[1] = Tab_1.TabPage_1.dw_2.Object.nm_cadastramento							[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.nm_filial								[1] = Tab_1.TabPage_1.dw_2.Object.nm_fantasia									[CurrentRow]
	Tab_1.TabPage_1.dw_3.Object.cd_filial									[1] = Tab_1.TabPage_1.dw_2.Object.cd_filial											[CurrentRow]
	
	//lvs_Situacao = Tab_1.TabPage_1.dw_2.Object.id_situacao[CurrentRow]
	//lvl_Pedido   = Tab_1.TabPage_1.dw_2.Object.nr_pedido  [CurrentRow]
			
//	wf_Localiza_Usuario(Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cadastramento[1], ref lvs_Nome)
//	
//	Tab_1.TabPage_1.dw_3.Object.Nm_Cadastramento[1] = lvs_Nome
	
//	If Not IsNull(Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cancelamento[1]) Then
//		wf_Localiza_Usuario(Tab_1.TabPage_1.dw_3.Object.Nr_Matricula_Cancelamento[1], ref lvs_Nome)
//	Else
//		lvs_Nome = ""
//	End If
//	
//	Tab_1.TabPage_1.dw_3.Object.Nm_Cancelamento[1] = lvs_Nome
	
End If
end event

event ue_preretrieve;call super::ue_preretrieve;Long lvl_Pedido

Date	lvdt_Pedido_I, &
     	lvdt_Pedido_T
	  
String	lvs_Usuario,&
		lvs_Situacao,&
		lvs_Matricula_Liberacao

dw_1.AcceptText()

lvl_Pedido     				= dw_1.Object.Nr_Pedido         			[1]
lvdt_Pedido_I  				= dw_1.Object.Dt_Pedido_Inicio  			[1]
lvdt_Pedido_T  				= dw_1.Object.Dt_Pedido_Termino 		[1]
lvs_Usuario    				= dw_1.Object.nr_matricula	   				[1]
lvs_Situacao	 				= dw_1.Object.id_situacao	   				[1]
lvs_Matricula_Liberacao	= dw_1.Object.nr_matricula_liberacao	[1]

If Not IsNull(lvl_Pedido) and lvl_Pedido > 0 Then
	This.of_AppendWhere("p.nr_pedido = " + String(lvl_Pedido))
Else

	If lvs_Situacao <> "P" Then
		If Not IsNull(lvdt_Pedido_I) Then
			This.of_AppendWhere("p.dh_pedido >= '" + String(lvdt_Pedido_I, "yyyy/mm/dd") + "'")
		End If
		
		If Not IsNull(lvdt_Pedido_T) Then
			This.of_AppendWhere("p.dh_pedido <= '" + String(lvdt_Pedido_T, "yyyy/mm/dd") + "'")
		End If
	End If
	
	If Not IsNull(lvs_Usuario) and lvs_Usuario <> ""  Then
		This.of_AppendWhere("p.nr_matricula_cadastramento = '" + lvs_Usuario + "'")
	End If
	
	If Not IsNull(lvs_Matricula_Liberacao) and lvs_Matricula_Liberacao <> ""  Then
		This.of_AppendWhere("p.nr_matricula_liberacao = '" + lvs_Matricula_Liberacao + "'")
	End If
End If

If lvs_Situacao <> 'T' Then
	// Liberados
	If lvs_Situacao = 'L' Then
		This.of_AppendWhere("p.dh_liberacao is not null ")
	Else
		This.of_AppendWhere("p.id_situacao = '" + lvs_Situacao + "'")
	End If
End If

Return 1
end event

event itemchanged;call super::itemchanged;If dwo.Name = "id_liberar" Then
	
	If Data = 'S' Then
		
		If Tab_1.TabPage_1.dw_2.Object.id_situacao[row] = 'P' Then
			If Tab_1.TabPage_1.dw_2.Object.vl_total_pedido[row] > idc_valor_maximo_liberacao Then
				//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ pode liberar pedidos com valor m$$HEX1$$e100$$ENDHEX$$ximo de R$ '" + String(idc_valor_maximo_liberacao, "#,##0.00") + "'.", Exclamation!)
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O valor deste pedido ultrapassa o permitido para a sua al$$HEX1$$e700$$ENDHEX$$ada.", Exclamation!)
				Return 1
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido [PENDENTE] poder$$HEX1$$e100$$ENDHEX$$ ser aprovado.")
			Return 1
		End If
		
	End If
	
End If
end event

type dw_3 from dc_uo_dw_base within tabpage_1
integer x = 27
integer y = 1252
integer width = 3470
integer height = 420
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge222_detalhe_pedido"
end type

type cb_cancelar_pedido from commandbutton within tabpage_1
integer x = 951
integer y = 1068
integer width = 539
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar Pedido"
end type

event clicked;Long 	lvl_Linha, &
     	lvl_Pedido
	  
String	lvs_Situacao,&
	   	lvs_Responsavel,&
		lvs_Email

lvl_Linha = dw_2.GetRow()

If lvl_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para cancelar.", StopSign!)
	Return
End If

lvl_Pedido   	= Tab_1.TabPage_1.dw_2.Object.Nr_Pedido  [lvl_Linha]
lvs_Situacao	= Tab_1.TabPage_1.dw_2.Object.Id_Situacao[lvl_Linha]
lvs_Email		= Tab_1.TabPage_1.dw_2.Object.de_endereco_email	[lvl_Linha]
	
If lvs_Situacao <> "C" and lvs_Situacao <> "P" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente pedido com situa$$HEX2$$e700e300$$ENDHEX$$o [PENDENTE] ou [COLOCADO] pode ser cancelado.", Information!)
	dw_2.SetFocus()
	Return	
End If

If Tab_1.TabPage_1.dw_2.Object.vl_total_pedido[lvl_Linha] > idc_valor_maximo_liberacao Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ pode cancelar pedido somente com valor m$$HEX1$$e100$$ENDHEX$$ximo de R$ '" + String(idc_valor_maximo_liberacao, "#,##0.00") + "'.", Exclamation!)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O valor deste pedido ultrapassa o permitido para a sua al$$HEX1$$e700$$ENDHEX$$ada.", Exclamation!)
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o cancelamento do pedido '" + String(lvl_Pedido) + "' ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE222_LIBERACAO_PROCEDIMENTO", Ref lvs_Responsavel) Then Return

SetPointer(HourGlass!)

Update pedido_central
Set id_situacao               = 'X',
    dh_cancelamento           = getdate(),
	nr_matricula_cancelamento = :lvs_Responsavel
Where nr_pedido = :lvl_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Cancelamento do Pedido")
Else
	SqlCa.of_Commit()	
	
	wf_Envia_Email_Responsaveis(lvl_Pedido, lvs_Responsavel, lvs_Email, "X")
		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido '" + String(lvl_Pedido) + "' cancelado com sucesso.", Information!)
	
	dw_2.Event ue_Retrieve()
End If

SetPointer(Arrow!)
end event

type cb_imprimir_pedido from commandbutton within tabpage_1
boolean visible = false
integer x = 3040
integer y = 1068
integer width = 466
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Imprimir Lista"
end type

event clicked;Long 	lvl_Pedido

Date	lvdt_Pedido_I, &
     	lvdt_Pedido_T
	  
String	lvs_Usuario,&
		lvs_Matricula_Lib,&
		lvs_Situacao

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("dw_ge222_relatorio_pedido") Then
	Destroy(lvds)
	Return
End If

Tab_1.TabPage_1.dw_1.AcceptText()

lvl_Pedido     		= Tab_1.TabPage_1.dw_1.Object.Nr_Pedido				[1]
lvdt_Pedido_I  		= Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Inicio		[1]
lvdt_Pedido_T  		= Tab_1.TabPage_1.dw_1.Object.Dt_Pedido_Termino	[1]
lvs_Usuario    		= Tab_1.TabPage_1.dw_1.Object.nr_matricula				[1]
lvs_Matricula_Lib	= dw_1.Object.nr_matricula_liberacao						[1]
lvs_Situacao			= dw_1.Object.id_situacao										[1]

If Not IsNull(lvl_Pedido) and lvl_Pedido > 0 Then
	lvds.of_AppendWhere("p.nr_pedido = " + String(lvl_Pedido))
Else
	
	If Not IsNull(lvdt_Pedido_I) Then
		lvds.of_AppendWhere("p.dh_pedido >= '" + String(lvdt_Pedido_I, "yyyy/mm/dd") + "'")
	End If
	
	If Not IsNull(lvdt_Pedido_T) Then
		lvds.of_AppendWhere("p.dh_pedido <= '" + String(lvdt_Pedido_T, "yyyy/mm/dd") + "'")
	End If

	If Not IsNull(lvs_Usuario) and lvs_Usuario <> ""  Then
		lvds.of_AppendWhere("p.nr_matricula_cadastramento = '" + lvs_Usuario + "'")
	End If
	
	If Not IsNull(lvs_Matricula_Lib) and lvs_Matricula_Lib <> ""  Then
		lvds.of_AppendWhere("p.nr_matricula_liberacao = '" + lvs_Matricula_Lib + "'")
	End If
	
End If

If lvs_Situacao <> 'T' Then
	// Liberados
	If lvs_Situacao = 'L' Then
		lvds.of_AppendWhere("p.dh_liberacao is not null ")
	Else
		lvds.of_AppendWhere("p.id_situacao = '" + lvs_Situacao + "'")
	End If
End If

lvds.Object.st_periodo.Text = String(lvdt_Pedido_I,"dd/mm/yyyy") + " at$$HEX1$$e900$$ENDHEX$$: " + String(lvdt_Pedido_T,"dd/mm/yyyy")

SetPointer(HourGlass!)

If lvds.Retrieve(lvl_Pedido) > 0 Then
	lvds.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados do pedido n$$HEX1$$e300$$ENDHEX$$o localizados para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
End If

SetPointer(Arrow!)

Destroy(lvds)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3525
integer height = 1704
long backcolor = 80269524
string text = "Produtos do Pedido"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_2.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_2.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_2
integer x = 9
integer y = 12
integer width = 3497
integer height = 1628
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos do Pedido"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 32
integer y = 68
integer width = 3461
integer height = 1560
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge222_lista_produto_nova"
boolean vscrollbar = true
end type

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	//lvb_Imprimir = True
	
	//wf_Calcula_Custo()
	wf_atualiza_informacoes()

	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	//This.ivm_Menu.mf_SalvarComo(True)
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos do pedido n$$HEX1$$e300$$ENDHEX$$o localizados.", Information!)
	End If
		This.ivm_Menu.mf_SalvarComo(False)
End If

ivm_Menu.mf_Classificar(lvb_Classificar)
ivm_Menu.mf_Filtrar(lvb_Filtrar)
ivm_Menu.mf_Localizar(lvb_Localizar)
ivm_Menu.mf_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event constructor;call super::constructor;//This.of_SetRowSelection()

This.of_SetRowSelection("if(vl_variacao < 0.00, rgb(255,0,0), rgb(255, 255, 255))","")
end event

event ue_recuperar;// Override

//Long lvl_Linha, &
//     lvl_Pedido
//
//lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()
//
//If lvl_Linha = 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um pedido para visualizar os produtos.", StopSign!)
//	Return -1
//End If
//
//lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[lvl_Linha]

//Return This.Retrieve(lvl_Pedido)

Return This.Retrieve(Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[Tab_1.TabPage_1.dw_2.GetRow()])
end event

event ue_saveas;// OverRide

String lvs_Arquivo, &
       lvs_Diretorio

Integer lvi_Retorno

Long lvl_Pedido

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.nr_pedido[Tab_1.TabPage_1.dw_2.GetRow()]

// Verifica o nome do arquivo
If Trim(This.ivs_Arquivo_SalvarComo) = "" or IsNull(This.ivs_Arquivo_SalvarComo) Then
	lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
											lvs_Diretorio, &
											lvs_Arquivo, &
											"XLS", "Arquivos do Excel (*.XLS),*.XLS,")
	
	If lvi_Retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
		Return 
	Else
		If lvi_Retorno = 0 Then Return
	End If
Else
	lvs_Diretorio = This.ivs_Arquivo_SalvarComo
End If

lvs_Diretorio = Upper(lvs_Diretorio)

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return
		End If
	Else
		Return 
   End If   
End If

dc_uo_ds_base ds_lista

ds_Lista = Create dc_uo_ds_base

If Not ds_Lista.of_ChangeDataObject("ds_ge147_lista_produto_excel") Then
	Destroy(ds_Lista)
	Return 
End If

If ds_Lista.Retrieve(lvl_Pedido) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es para gerar a planilha excel.")
	Destroy(ds_Lista)
	Return 
End If

If ds_Lista.RowCount() > 0 Then
	
	// Salva o arquivo
	lvi_Retorno = ds_Lista.SaveAs(lvs_Diretorio, Excel!, True)
		
	If lvi_Retorno <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
		Return 
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
End If
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3525
integer height = 1704
long backcolor = 67108864
string text = "Valores da Simula$$HEX2$$e700e300$$ENDHEX$$o da Melhor Compra"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_5 gb_5
dw_5 dw_5
end type

on tabpage_3.create
this.gb_5=create gb_5
this.dw_5=create dw_5
this.Control[]={this.gb_5,&
this.dw_5}
end on

on tabpage_3.destroy
destroy(this.gb_5)
destroy(this.dw_5)
end on

type gb_5 from groupbox within tabpage_3
integer x = 9
integer y = 12
integer width = 2194
integer height = 672
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Simula$$HEX2$$e700e300$$ENDHEX$$o da Melhor Compra"
borderstyle borderstyle = styleraised!
end type

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 23
integer y = 104
integer width = 2149
integer height = 548
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge222_detalhe_simulacao"
end type

event ue_recuperar;// Override
Return This.Retrieve(Tab_1.TabPage_1.dw_2.Object.Nr_Pedido[Tab_1.TabPage_1.dw_2.GetRow()])
end event

