HA$PBExportHeader$w_ge375_alteracao_preco.srw
forward
global type w_ge375_alteracao_preco from dc_w_sheet
end type
type cb_finaliza from commandbutton within w_ge375_alteracao_preco
end type
type cb_1 from commandbutton within w_ge375_alteracao_preco
end type
type cb_atualiza_preco from commandbutton within w_ge375_alteracao_preco
end type
type st_confirmar from statictext within w_ge375_alteracao_preco
end type
type dw_5 from dc_uo_dw_base within w_ge375_alteracao_preco
end type
type dw_4 from dc_uo_dw_base within w_ge375_alteracao_preco
end type
type dw_3 from dc_uo_dw_base within w_ge375_alteracao_preco
end type
type dw_2 from dc_uo_dw_base within w_ge375_alteracao_preco
end type
type cb_importar_planilha from commandbutton within w_ge375_alteracao_preco
end type
type dw_1 from dc_uo_dw_base within w_ge375_alteracao_preco
end type
type gb_1 from groupbox within w_ge375_alteracao_preco
end type
type gb_2 from groupbox within w_ge375_alteracao_preco
end type
type gb_3 from groupbox within w_ge375_alteracao_preco
end type
type gb_4 from groupbox within w_ge375_alteracao_preco
end type
end forward

global type w_ge375_alteracao_preco from dc_w_sheet
integer width = 5216
integer height = 2200
string title = "GE375 - Altera$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o Venda"
cb_finaliza cb_finaliza
cb_1 cb_1
cb_atualiza_preco cb_atualiza_preco
st_confirmar st_confirmar
dw_5 dw_5
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
cb_importar_planilha cb_importar_planilha
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_ge375_alteracao_preco w_ge375_alteracao_preco

type variables
uo_Produto io_Produto

uo_ge376_alteracao_preco_venda io_Alteracao

dc_uo_ds_Base ids_UF

uo_simula_pedido io_Simula // GE222

uo_ge118_nf_transferencia_perini io_nf

Integer ii_Alteracoes

Date ivdt_Parametro

Boolean ivb_Check
end variables

forward prototypes
public function integer wf_seleciona_arquivo (ref string as_path, ref string as_nome)
public function boolean wf_verifica_uf_fornecedor (ref string as_uf)
public function boolean wf_produto_uf (uo_produto ao_produto, long al_alteracao, decimal adc_custo)
public function boolean wf_localiza_filial (string as_uf, ref long al_filial)
public function boolean wf_grava_preco_produto_uf (long al_codigo_alteracao, uo_produto ao_produto, uo_ge118_nf_transferencia_perini ao_nf, string as_uf_destino, long al_filial, decimal adc_custo_compra)
public function boolean wf_margem_resultado_venda (long al_produto, string as_uf, ref decimal adc_margem_resultado, ref decimal adc_preco_venda_atual)
public function boolean wf_verifica_bloqueio ()
public function boolean wf_salva_alteracoes ()
public function boolean wf_atualiza_valores (long al_alteracao)
public function integer wf_alteracoes_pendentes ()
public function boolean wf_atualiza_preco_futuro ()
public function boolean wf_valor (long al_row, any aa_valor, string as_coluna, ref any aa_valor_retorno, ref boolean ab_retorno)
public subroutine wf_exclui_alteracao ()
public subroutine wf_finaliza_alteracao ()
public function boolean wf_grava_preco_produto (long al_codigo_alteracao, long al_produto, string as_prod_distribuidora, decimal adc_preco_fabrica, decimal adc_desconto, decimal adc_ipi, string as_uf_fornecedor, decimal adc_preco_sugerido_forn, decimal adc_pc_icms)
end prototypes

public function integer wf_seleciona_arquivo (ref string as_path, ref string as_nome);Integer li_arquivo


MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
				   	"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo de Barras~r" +&
				 	"Coluna B = Descri$$HEX2$$e700e300$$ENDHEX$$o Produto~r" +&
					"Coluna C = Classifica$$HEX2$$e700e300$$ENDHEX$$o Fiscal~r" +&
					"Coluna D = ICMS Compra~r" +&
					"Coluna E = Pre$$HEX1$$e700$$ENDHEX$$o Fabrica~r" +&
					"Coluna F = Desconto(%)~r" +&
					"Coluna G = IPI(%)~r" +&
                     	"Coluna H = Pre$$HEX1$$e700$$ENDHEX$$o Sugerido.~r" )

li_arquivo = GetFileOpenName("Selecione o arquivo", &
										   as_Path, &
										   as_nome  , & 
											"XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")
													
If li_Arquivo < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao abrir o arquivo '" + as_nome + "'.")
	Return -1
End If

If li_Arquivo = 0 Then Return -1
end function

public function boolean wf_verifica_uf_fornecedor (ref string as_uf);String ls_Fornecedor, ls_Mensagem

dw_1.AcceptText()

ls_Fornecedor = dw_1.Object.cd_fornecedor_faturamento[1]

Select c.cd_unidade_federacao
Into :as_uf
from fornecedor f 
inner join cidade c on c.cd_cidade = f.cd_cidade
where f.cd_fornecedor = :ls_Fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O fornecedor n$$HEX1$$e300$$ENDHEX$$o foi localizado.", StopSign!)
		Return False
	Case -1
		ls_Mensagem = 'Localiza$$HEX2$$e700e300$$ENDHEX$$o da UF do fornecedor. ' + SQLCA.SQLErrText
		SqlCa.of_RollBack();
		MessageBox("Erro", ls_Mensagem, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_produto_uf (uo_produto ao_produto, long al_alteracao, decimal adc_custo);String ls_UF

Long ll_Linhas, ll_Row

ll_Linhas = ids_UF.RowCount()

For ll_Row = 1 To ll_Linhas

	ls_UF = ids_UF.Object.cd_unidade_federacao[ ll_Row ]

//	Insert into alteracao_preco_venda_prd_uf
//		(nr_alteracao,
//		cd_produto,
//		cd_unidade_federacao,
//		pc_icms_venda,
//		pc_mva,
//		pc_margem_resultado,
//		vl_venda )
//	Values(	:al_codigo_alteracao,
//				:io_produto.cd_produto,
//				:ls_UF,
//				0,
//				0,
//				0,
//				0 )
//	Using SqlCa;
//	
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_msgdbError("Erro ao inserir o produto: " + String(io_produto.cd_produto) + " na UF: " + ls_UF + ". " + SqlCa.SqlErrText)
//		Return False
//	End If
	
Next

Return True
end function

public function boolean wf_localiza_filial (string as_uf, ref long al_filial);String ls_MSG

Select top 1 cd_filial
Into :al_Filial
From vw_filial
where cd_uf = :as_Uf
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada filial para a UF '" + as_UF + "'.", StopSign!)
		Return False	
	Case -1
		ls_MSG = "Erro ao localizar a filial da UF '" + as_UF + "'. " + SQLCA.SQLErrText
		SqlCa.of_RollBack();
		Return False
End Choose

Return True

end function

public function boolean wf_grava_preco_produto_uf (long al_codigo_alteracao, uo_produto ao_produto, uo_ge118_nf_transferencia_perini ao_nf, string as_uf_destino, long al_filial, decimal adc_custo_compra);Long ll_Produto, ll_Tributacao_Produto

Decimal ldc_BC_ICMS, ldc_ICMS, ldc_BC_ICMS_ST, ldc_ICMS_ST, ldc_PC_ICMS_ST, ldc_PC_Red_BC_ST
Decimal ldc_PC_Red_BC_ICMS, ldc_VL_ICMS, ldc_PC_ICMS, ldc_PC_MVA, ldc_PC_Margem, ldc_Venda
Decimal ldc_Preco_Venda_Atual

String ls_CST_Origem, ls_CST_Tributacao

If Not ao_nf.of_inicializa(al_filial) Then Return False

// A fun$$HEX2$$e700e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ retornar o custo que foi utilizado na transfer$$HEX1$$ea00$$ENDHEX$$ncia conforme a UF.
If ao_nf.of_tributacao(io_Produto, ref adc_custo_compra, 'SC', as_uf_destino, 1) Then
					
	ll_Produto		= io_Produto.cd_produto
	
	ldc_PC_Margem = 0.00
	
	If Not wf_margem_resultado_venda(ll_Produto, as_uf_destino, ref ldc_PC_Margem, ref ldc_Preco_Venda_Atual) Then Return False
		
	If ll_Produto = 588286 Then
		ll_Produto = 588286
	End If
	
	ldc_BC_ICMS				= 	round(ao_nf.vl_bc_icms, 2)
	ldc_PC_ICMS			 	= 	ao_nf.pc_icms
	ldc_VL_ICMS				= 	round(ao_nf.vl_icms, 2)
	
	ldc_BC_ICMS_ST			=	round(ao_nf.vl_bc_icms_st_prd	, 2) // originalmente $$HEX1$$e900$$ENDHEX$$ 4 casas decimais
	ldc_ICMS_ST				=	round(ao_nf.vl_icms_st_prd, 2) // originalmente $$HEX1$$e900$$ENDHEX$$ 4 casas decimais
	ldc_PC_ICMS_ST			= 	ao_nf.pc_icms_st
	
	ldc_PC_Red_BC_ST 		= ao_nf.pc_reducao_base_st
	ldc_PC_MVA					= ao_nf.vl_mva
	ldc_PC_Red_BC_ICMS	= ao_nf.pc_reducao_base_icms
	
	If IsNull(ldc_PC_MVA) Then
		ldc_PC_MVA = 0.00
	End If
	
//	// 0.90 => 10 %
//	If ao_nf.pc_reducao_base_st > 0 Then
//		ldc_PC_Red_BC_ST	=	(1 - ao_nf.pc_reducao_base_st) * 100	
//	End If
//	
//	// 1,9947		=>	99,47 %
//	If ao_nf.vl_mva > 0 Then
//		ldc_PC_MVA = (ao_nf.vl_mva - 1) * 100
//	End If
//	
//	// 0.8951		=>	10,49 %
//	If ao_nf.pc_reducao_base_icms > 0 Then
//		ldc_PC_Red_BC_ICMS	= (1 - ao_nf.pc_reducao_base_icms) * 100
//	End If	
	
	ls_CST_Origem 		= ao_nf.cd_cst_origem
	ls_CST_Tributacao	= ao_nf.cd_cst_tributacao
	ll_Tributacao_Produto	= ao_nf.cd_tributacao_produto
	
	// N$$HEX1$$c300$$ENDHEX$$O ESTA SENDO CONSIDERADO PISCOFINS, SEGUNDO A ANA N$$HEX1$$c300$$ENDHEX$$O TEM...
	// O arrendondamento $$HEX1$$e900$$ENDHEX$$ um em virtude do troco na loja.
	ldc_Venda = round((adc_custo_compra + ldc_ICMS_ST) / ((100 - ldc_PC_Margem) / 100), 1)
	
	INSERT INTO alteracao_preco_venda_prd_uf  (	nr_alteracao,   
																  	cd_produto,   
																  	cd_unidade_federacao,   
																  	vl_custo_transferencia,   
																  	vl_bc_icms,   
																  	pc_reducao_base_icms,   
																  	pc_icms,   
																  	vl_icms,   
																  	pc_mva,   
																  	vl_bc_icms_st,   
																  	pc_reducao_base_st,   
																  	pc_icms_st,   
																  	vl_icms_st,   
																  	pc_margem_resultado,   
																  	vl_venda,   
																  	dh_alteracao,
																	cd_cst_origem,
																	cd_cst_tributacao,
																	cd_tributacao_produto,
																	vl_venda_atual)  
	VALUES (	:al_codigo_alteracao,			//nr_alteracao,   
					:ll_Produto,						//cd_produto,   
					:as_UF_Destino,				//cd_unidade_federacao,   
					:adc_custo_compra,			//vl_custo_transferencia,   
					:ldc_BC_ICMS,					//vl_bc_icms,   
					:ldc_PC_Red_BC_ICMS,		//pc_reducao_base_icms,   
					:ldc_PC_ICMS,					//pc_icms,   
					:ldc_VL_ICMS,					//vl_icms,   
					:ldc_PC_MVA,					//pc_mva,   
					:ldc_BC_ICMS_ST,				//vl_bc_icms_st,   
					:ldc_PC_Red_BC_ST,			//pc_reducao_base_st,   
					:ldc_PC_ICMS_ST,				//pc_icms_st,   
					:ldc_ICMS_ST,					//vl_icms_st,   
					:ldc_PC_Margem,				//pc_margem_resultado,   
					:ldc_Venda,						//vl_venda,   
					getdate(),						//dh_alteracao 	
					:ls_CST_Origem,				//cd_cst_origem									  	
					:ls_CST_Tributacao,			//cd_cst_tributacao
					:ll_Tributacao_Produto,		//cd_tributacao_produto
					:ldc_Preco_Venda_Atual) 	//vl_venda_atual
	Using SqlCa;
		
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_msgdbError("Erro ao inserir o produto: " + String(io_produto.cd_produto) + " na UF: " + as_UF_Destino + ". " + SqlCa.SqlErrText)
		Return False
	End If
				
Else
	Return False
End If

Return True
end function

public function boolean wf_margem_resultado_venda (long al_produto, string as_uf, ref decimal adc_margem_resultado, ref decimal adc_preco_venda_atual);String ls_MSG

Select coalesce(pc_margem_resultado_preco, 0), coalesce(vl_preco_venda_atual, 0)
Into :adc_margem_resultado, :adc_preco_venda_atual
From produto_uf
where cd_produto = :al_produto
  and cd_unidade_federacao = :as_uf
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Return False	
	Case -1
		ls_MSG = "Erro ao localizar o produto '" + String(al_Produto) + "'. " + SQLCA.SQLErrText
		SqlCa.of_RollBack();
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_verifica_bloqueio ();String ls_Mensagem, ls_UF, ls_Preco_Bloqueado

Long ll_Linha, ll_Produto, ll_Achou, ll_Filial

dw_2.AcceptText()

Open(w_Aguarde)

w_Aguarde.Title = "Verificando a exist$$HEX1$$ea00$$ENDHEX$$ncia de bloqueio de pre$$HEX1$$e700$$ENDHEX$$o ..."

w_Aguarde.uo_Progress.of_setmax(dw_2.RowCount())

ls_UF	= dw_2.Object.cd_unidade_federacao[1]

If Not wf_Localiza_Filial(ls_UF, ref ll_Filial) Then Return False

For ll_Linha = 1 To dw_2.RowCount()
	
	ll_Produto 	= dw_2.Object.cd_Produto[ll_Linha]
	
	Select count(*)
	Into :ll_Achou
	from vw_promocao_estoque_minimo v
	where v.cd_produto = :ll_Produto
	 and v.cd_uf = :ls_Uf
	 and v.id_preco_bloqueado = 'S'
	 and v.id_situacao = 'L'
	 Using SqlCa;
 
	 If SqlCa.SqlCode = -1 Then
		ls_Mensagem = 'Localiza$$HEX2$$e700e300$$ENDHEX$$o do bloqueio de altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o. ' + SQLCA.SQLErrText
		SqlCa.of_RollBack();
		MessageBox("Erro", ls_Mensagem, StopSign!)
		Close(w_Aguarde)
		Return False
	 Else
		If ll_Achou > 0 Then
			ls_Preco_Bloqueado = "S"
		Else
			ls_Preco_Bloqueado = "N"
		End If
	 End If
 
	dw_2.Object.id_preco_bloqueado [ll_Linha]  = ls_Preco_Bloqueado
	
	w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
Next

Close(w_Aguarde)

Return True
end function

public function boolean wf_salva_alteracoes ();Long ll_Linha, ll_Produto, ll_Linhas, ll_Alteracao, ll_Registros_Alterados

Decimal ldc_Margem_Atual, ldc_Margem_Nova, ldc_Venda_Novo, ldc_Venda_Atual

String ls_UF, ls_Utilizado_Preco_Sugerido_Original, ls_Utilizado_Preco_Sugerido, ls_MSG

dw_1.AcceptText()

ll_Alteracao = dw_1.Object.nr_alteracao [ 1 ]  

If IsNull ( ll_Alteracao ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cadastro de altera$$HEX2$$e700e300$$ENDHEX$$o.")	
	Return False
End If

ll_Linhas = dw_2.RowCount()

try

	Open(w_Aguarde)
	
	w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
		
		ldc_Venda_Novo     	= dw_2.Object.vl_venda_u					[ll_Linha]
		ll_Produto				= dw_2.Object.cd_produto					[ll_Linha]
		ls_UF						= dw_2.Object.cd_unidade_federacao	[ll_Linha]
	
		ldc_Margem_Atual		= dw_2.Object.pc_margem_resultado_u_original	[ll_Linha]				 
		ldc_Margem_Nova		= dw_2.Object.pc_margem_resultado_u				[ll_Linha]
		
		ldc_Venda_Atual		= dw_2.Object.vl_venda_u_original					[ll_Linha]
			
		ls_Utilizado_Preco_Sugerido 			= dw_2.Object.id_utilizado_preco_sug_forn	[ll_Linha]
		ls_Utilizado_Preco_Sugerido_Original = dw_2.Object.id_utilizado_preco_sug_forn_or[ll_Linha]
		
		
		If ldc_Margem_Atual <> ldc_Margem_Nova or ldc_Venda_Atual  <> ldc_Venda_Novo or ls_Utilizado_Preco_Sugerido <> ls_Utilizado_Preco_Sugerido_Original Then
			
			  UPDATE alteracao_preco_venda_prd_uf  
		     SET 	pc_margem_resultado 		= :ldc_Margem_Nova, 
			  		vl_venda 						= :ldc_Venda_Novo, 
					id_utilizado_preco_sug_forn	= :ls_Utilizado_Preco_Sugerido
			WHERE	nr_alteracao				= :ll_Alteracao
				AND	cd_produto					= :ll_Produto
				AND	cd_unidade_federacao	= :ls_UF
			USING SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(ll_Produto) + "' da UF '" + ls_UF + "' MARGEM/VENDA/UTILIZADO PRECO SUGERIDO. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				MessageBox("Erro", ls_MSG, StopSign!)
				Return False
			End If
			
			ll_Registros_Alterados ++
		End If
		
		w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
	Next
	
	If ll_Registros_Alterados > 0 Then
		SqlCa.of_Commit();
		ii_Alteracoes = 0
	End If

finally
	Close(w_Aguarde)
end try

Return True
end function

public function boolean wf_atualiza_valores (long al_alteracao);String ls_UF

Long ll_Cont_UF, ll_Cont_PRD, ll_Produtos, ll_Produto, ll_Filial

Decimal ldc_Custo_Compra

If Not ids_UF.Of_ChangeDataObject( "ddw_uf_ativa" ) Then Return False
	
If ids_UF.Retrieve() < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve 'ddw_uf_ativa'.")
	Return False
End If

dc_uo_ds_Base lds_Produtos

Try
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	
	lds_Produtos = Create dc_uo_ds_Base
	
	lds_Produtos.of_ChangeDataObject("ds_ge375_lista_produtos")
	
	For ll_Cont_UF = 1 To ids_UF.RowCount()
		
		ls_UF = ids_UF.Object.cd_unidade_federacao[ll_Cont_UF]
		
		uo_ge118_nf_transferencia_perini lo_NF
		lo_NF = Create uo_ge118_nf_transferencia_perini
		
		lo_NF.of_grava_uf_origem_destino('SC', ls_UF)
		
		If Not wf_Localiza_Filial(ls_UF, ref ll_Filial) Then Return False
		
		// loop produtos
		
		ll_Produtos = lds_Produtos.Retrieve(al_Alteracao)
		
		If ll_Produtos > 0 Then
			
			For ll_Cont_PRD = 1 To ll_Produtos
				
				ll_Produto			= lds_Produtos.Object.cd_produto			[ll_Cont_PRD]
				ldc_Custo_Compra	= lds_Produtos.Object.vl_custo_compra	[ll_Cont_PRD]
	
				io_Produto.of_Localiza_Codigo_Interno(ll_Produto)
				
				If Not wf_grava_preco_produto_uf(al_Alteracao, io_Produto, lo_NF, ls_UF, ll_Filial, ldc_Custo_Compra) Then
					Return False
				End If
				
			Next
			
		ElseIf ll_Produtos = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi localizado para o a UF '" + ls_UF + "'.")
			Return False
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os produtos da UF '" + ls_UF + "'.")
			Return False
		End If		
		
		Destroy lo_NF
		
	Next
	
	SqlCa.of_Commit()
	
	ii_Alteracoes = 0
	
Finally
	Destroy lds_Produtos
	SetPointer(Arrow!)
	Close(w_Aguarde)
End Try

Return True
end function

public function integer wf_alteracoes_pendentes ();//Long lvl_Modificado
//
//dw_2.AcceptText()
//
//lvl_Modificado = dw_2.ModifiedCount() + dw_2.DeletedCount()
//							 
//If lvl_Modificado > 0 Then
//	Return True
//Else
//	Return False
//End If

Integer li_Retorno

If ii_Alteracoes > 0 Then
	li_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas.~r~r" + "Deseja salvar antes de continuar ?", Question!, YesNoCancel!, 2)
End If

Return li_Retorno
end function

public function boolean wf_atualiza_preco_futuro ();Long ll_Linha, ll_Produto, ll_Linhas, ll_Produtos_Alterados, ll_Alteracao, ll_Registros_Alterados

Date ldt_Vigencia

Decimal 	ldc_Venda_Anterior, ldc_Venda_Novo, ldc_Venda_Futuro, ldc_Margem_Atual, ldc_Margem_Nova, ldc_Venda_Atual

Decimal ldc_Preco_Fabrica, ldc_Preco_Fabrica_Novo
		  
String ls_UF, ls_MSG, ls_Matricula, ls_Atualizar, ls_Utilizado_Preco_Sugerido, ls_Utilizado_Preco_Sugerido_Original

DateTime ldh_ServerDate

dw_1.AcceptText()

ll_Linhas = dw_2.RowCount()

If ll_Linhas = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos para serem atualizados.")
	Return False
End If

ll_Alteracao = dw_1.Object.nr_alteracao [ 1 ]  

If IsNull ( ll_Alteracao ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cadastro de altera$$HEX2$$e700e300$$ENDHEX$$o.")	
	Return False
End If

If dw_2.GetItemNumber(dw_2.RowCount(), "cont_selecionadas") <= 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos selecionados para serem atualizados.", Exclamation!)
	Return False
End If

ldt_Vigencia = Date(dw_1.Object.Dt_Inicio_Vigencia[1])

If IsNull(ldt_Vigencia) or Not IsDate(String(ldt_Vigencia, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe corretamente a data de in$$HEX1$$ed00$$ENDHEX$$cio da vig$$HEX1$$ea00$$ENDHEX$$ncia para os pre$$HEX1$$e700$$ENDHEX$$os de venda alterados.")
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return False
End If

If ldt_Vigencia <= ivdt_Parametro Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da vig$$HEX1$$ea00$$ENDHEX$$ncia deve ser maior ou igual a '" + &
	                      String(RelativeDate(ivdt_Parametro, 1), "dd/mm/yyyy") + "'.")
								 
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return False
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE375_ALTERACAO_PRECO", ref ls_Matricula) Then 
	Return False
End If

ldh_ServerDate = gf_GetServerDate()

try

	Open(w_Aguarde)
	
	w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
		
		ldc_Venda_Novo     	= dw_2.Object.vl_venda_u					[ll_Linha]
		ll_Produto				= dw_2.Object.cd_produto					[ll_Linha]
		ls_UF						= dw_2.Object.cd_unidade_federacao	[ll_Linha]
		ls_Atualizar				= dw_2.Object.id_atualizar					[ll_Linha]
		ldc_Preco_Fabrica_Novo	= dw_2.Object.vl_preco_fabrica			[ll_Linha]
		
		ldc_Margem_Atual		= dw_2.Object.pc_margem_resultado_u_original	[ll_Linha]				 
		ldc_Margem_Nova		= dw_2.Object.pc_margem_resultado_u				[ll_Linha]
		
		ldc_Venda_Atual		= dw_2.Object.vl_venda_u_original					[ll_Linha]
			
		ls_Utilizado_Preco_Sugerido 			= dw_2.Object.id_utilizado_preco_sug_forn	[ll_Linha]
		ls_Utilizado_Preco_Sugerido_Original = dw_2.Object.id_utilizado_preco_sug_forn_or[ll_Linha]
		
		
		If ldc_Margem_Atual <> ldc_Margem_Nova or ldc_Venda_Atual  <> ldc_Venda_Novo or ls_Utilizado_Preco_Sugerido <> ls_Utilizado_Preco_Sugerido_Original Then
			
			  UPDATE alteracao_preco_venda_prd_uf  
		     SET 	pc_margem_resultado 		= :ldc_Margem_Nova, 
			  		vl_venda 						= :ldc_Venda_Novo, 
					id_utilizado_preco_sug_forn	= :ls_Utilizado_Preco_Sugerido
			WHERE	nr_alteracao				= :ll_Alteracao
				AND	cd_produto					= :ll_Produto
				AND	cd_unidade_federacao	= :ls_UF
			USING SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(ll_Produto) + "' da UF '" + ls_UF + "' MARGEM/VENDA/UTILIZADO PRECO SUGERIDO. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				MessageBox("Erro", ls_MSG, StopSign!)
				Return False
			End If
			
			ll_Registros_Alterados ++
		End If
		
		If ls_Atualizar = 'S' Then
		
			Select coalesce(vl_preco_venda_futuro, 0), coalesce(vl_preco_reposicao, 0)
			Into :ldc_Venda_Futuro, :ldc_Preco_Fabrica
			From produto_uf
			Where cd_unidade_federacao 	= :ls_UF
				 and cd_produto				= :ll_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda futuro do produto '" + String(ll_Produto) + "'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				MessageBox("Erro", ls_MSG, StopSign!)
				Return False
			End If
			
			If ldc_Venda_Novo <> ldc_Venda_Futuro Then
				If ldc_Venda_Novo > 0 Then
					update produto_uf
					set		vl_preco_venda_futuro 			= :ldc_Venda_Novo,  
							dh_preco_venda_futuro 			= :ldt_Vigencia, 
							nr_matric_preco_venda_futuro = :ls_Matricula
					Where cd_unidade_federacao 	= :ls_UF
						and cd_produto					= :ll_Produto
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						ls_MSG = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda futuro do produto '" + String(ll_Produto) + "' da UF '" + ls_UF + "'. " + SQLCA.SQLErrText
						SqlCa.of_RollBack();
						MessageBox("Erro", ls_MSG, StopSign!)
						Return False
					End If
					
					ll_Produtos_Alterados ++
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o calculado deve ser maior que zero.", Exclamation!)
					dw_2.ScrollToRow(ll_Linha)
					dw_2.SetFocus()
					Return False
				End If
								
				If ldc_Preco_Fabrica_Novo <> ldc_Preco_Fabrica Then
					If ldc_Preco_Fabrica_Novo > 0 Then
						update produto_uf
						Set	vl_preco_reposicao				= :ldc_Preco_Fabrica_Novo,
								dh_preco_reposicao				= :ldh_ServerDate,
								nr_matricula_preco_reposicao	= :ls_Matricula
						Where cd_unidade_federacao 	= :ls_UF
							and cd_produto					= :ll_Produto
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							ls_MSG = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de f$$HEX1$$e100$$ENDHEX$$brica do produto '" + String(ll_Produto) + "' da UF '" + ls_UF + "'. " + SQLCA.SQLErrText
							SqlCa.of_RollBack();
							MessageBox("Erro", ls_MSG, StopSign!)
							Return False
						End If
						
						ll_Produtos_Alterados ++
					Else
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o f$$HEX1$$e100$$ENDHEX$$brica deve ser maior que zero.", Exclamation!)
						dw_2.ScrollToRow(ll_Linha)
						dw_2.SetFocus()
						Return False
					End If
				End If
						
			End If
		
		End If // id_atualizar
		
		w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
	Next
	
	If ll_Produtos_Alterados > 0 or ll_Registros_Alterados > 0 Then
		
		Update alteracao_preco_venda
		Set dh_alteracao = getDate(), nr_matricula_alteracao = :ls_Matricula , dt_inicio_vigencia = :ldt_Vigencia
		Where nr_alteracao = :ll_Alteracao
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			ls_MSG = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da altera$$HEX1$$e700$$ENDHEX$$ao '" + String(ll_Alteracao) + "'. " + SQLCA.SQLErrText
			SqlCa.of_RollBack();
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		Else
			SqlCa.of_Commit();
			ii_Alteracoes = 0
			If ll_Produtos_Alterados > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os pre$$HEX1$$e700$$ENDHEX$$os foram atualizados com sucesso.")
			End If
		End If
		
	End If

finally
	Close(w_Aguarde)
end try

Return True
end function

public function boolean wf_valor (long al_row, any aa_valor, string as_coluna, ref any aa_valor_retorno, ref boolean ab_retorno);ab_retorno = True

Choose Case as_Coluna
	Case 'A'	//A - Codigo Barras		
		io_produto.of_localiza_codigo_barras( String( aa_Valor ) )
		
		If Not io_produto.Localizado Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + String( aa_Valor )  + " n$$HEX1$$e300$$ENDHEX$$o foi localizado.~rLinha: " + String(al_Row))
			ab_Retorno = False
			//Return False
		End If
		
		aa_Valor_Retorno = aa_Valor
				
	Case 'B' //B - Descricao Produto Distribuidora
		aa_Valor_Retorno = aa_Valor

	Case 'C' //Leitura da coluna C - Classificacao_fiscal
//		If io_produto.Nr_Classificacao_Fiscal <> Long( aa_Valor ) Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","CLASSIFICA$$HEX2$$c700c300$$ENDHEX$$O FISCAL difere do cadastro. Produto: " + String(io_produto.cd_produto) + " - " + String( aa_Valor ) + ".~rLinha: " + String(al_Row))
//			Return False
//		End If
		
		aa_Valor_Retorno = aa_Valor

	Case 'D', 'F', 'G'
		aa_Valor_Retorno = Round( Dec( aa_Valor ) , 2 )
				
		If aa_Valor_Retorno < 0 Or aa_Valor_Retorno > 100 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor Inv$$HEX1$$e100$$ENDHEX$$lido: " + String( aa_Valor_Retorno ) + ".~rLinha: " + String( al_Row ) +"~rColuna: " + as_Coluna )
			Return False
		End If

	Case 'E', 'H'
		aa_Valor_Retorno = Round( Dec( aa_Valor ) , 2)
				
		If aa_Valor_Retorno < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor Inv$$HEX1$$e100$$ENDHEX$$lido: " + String( aa_Valor_Retorno ) + ".~rLinha: " + String( al_Row) +"~rColuna: " + as_Coluna )
			Return False
		End If

End Choose
end function

public subroutine wf_exclui_alteracao ();DateTime ldt_Finalizacao

String ls_MSG

Long ll_Alteracao

dw_1.AcceptText()

ll_Alteracao = dw_1.Object.nr_alteracao [ 1 ]  

If IsNull ( ll_Alteracao ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cadastro de altera$$HEX2$$e700e300$$ENDHEX$$o.")	
	Return
End If

Select dh_finalizacao
Into :ldt_Finalizacao
From alteracao_preco_venda
Where nr_alteracao = :ll_Alteracao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If IsNull(ldt_Finalizacao) Then
			
			If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o da altera$$HEX2$$e700e300$$ENDHEX$$o '" + String(ll_Alteracao) + "' ?", Question!, YesNo!, 2) = 2 Then Return
			
			Delete From alteracao_preco_venda_prd_uf
			Where nr_alteracao = :ll_Alteracao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Exclus$$HEX1$$e300$$ENDHEX$$o dos registros da tabela 'alteracao_preco_venda_prd_uf'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				MessageBox("Erro", ls_MSG, StopSign!)
				Return
			End If
			
			Delete From alteracao_preco_venda_prd
			Where nr_alteracao = :ll_Alteracao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Exclus$$HEX1$$e300$$ENDHEX$$o dos registros da tabela 'alteracao_preco_venda_prd'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				MessageBox("Erro", ls_MSG, StopSign!)
				Return
			End If
			
			Delete From alteracao_preco_venda
			Where nr_alteracao = :ll_Alteracao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Exclus$$HEX1$$e300$$ENDHEX$$o dos registros da tabela 'alteracao_preco_venda'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				MessageBox("Erro", ls_MSG, StopSign!)
				Return
			End If
			
			SqlCa.of_Commit();
			
			dw_1.Reset()
			dw_2.Reset()
			
			dw_1.Event ue_AddRow()
			
			//dw_1.Event ue_Pos(1, "de_localizacao")
			
		Else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Esta altera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser exclu$$HEX1$$ed00$$ENDHEX$$da.~r~r' +&
							"Motivo: A altera$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ foi finalizada '" + String(ldt_Finalizacao, 'dd/mm/yy hh:mm'))
		End If
				
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar a altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o.")
		Return 
End Choose



end subroutine

public subroutine wf_finaliza_alteracao ();DateTime ldt_Finalizacao

String ls_MSG, ls_Matricula

Long ll_Alteracao

dw_1.AcceptText()

ll_Alteracao = dw_1.Object.nr_alteracao [ 1 ]  

If IsNull ( ll_Alteracao ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cadastro de altera$$HEX2$$e700e300$$ENDHEX$$o.")	
	Return
End If

Select dh_finalizacao
Into :ldt_Finalizacao
From alteracao_preco_venda
Where nr_alteracao = :ll_Alteracao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If IsNull(ldt_Finalizacao) Then
			
			If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE375_FINALIZA_ALTERACAO_PRECO", ref ls_Matricula) Then 
				Return
			End If
			
			//If Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Confirma a finaliza$$HEX2$$e700e300$$ENDHEX$$o da altera$$HEX2$$e700e300$$ENDHEX$$o '" + String(ll_Alteracao) + "' ?", Question!, YesNo!, 2) = 2 Then Return
			
			update alteracao_preco_venda
			set dh_finalizacao = getdate(), nr_matricula_finalizacao = :ls_Matricula
			Where nr_alteracao = :ll_Alteracao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Exclus$$HEX1$$e300$$ENDHEX$$o dos registros da tabela 'alteracao_preco_venda'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				MessageBox("Erro", ls_MSG, StopSign!)
				Return
			End If
			
			dw_1.Object.dh_finalizacao[1] = Date(String(Today(), "yyyy/mm/dd"))
			
			SqlCa.of_Commit();
			
			dw_2.Event ue_retrieve()
			
		Else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Esta altera$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ foi finalizada '" + String(ldt_Finalizacao, 'dd/mm/yy hh:mm') + "'.")
		End If
				
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar a altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o.")
		Return 
End Choose



end subroutine

public function boolean wf_grava_preco_produto (long al_codigo_alteracao, long al_produto, string as_prod_distribuidora, decimal adc_preco_fabrica, decimal adc_desconto, decimal adc_ipi, string as_uf_fornecedor, decimal adc_preco_sugerido_forn, decimal adc_pc_icms);Decimal ldc_Valor_Compra
Decimal ldc_Pc_Mva

String ls_Fornecedor

dw_1.AcceptText()

ls_Fornecedor = dw_1.Object.cd_fornecedor_faturamento[1]

io_Produto.of_Localiza_Codigo_Interno(al_produto)

ldc_Valor_Compra = io_Simula.of_valor_compra_nova(adc_preco_fabrica, adc_desconto, 0.00, 'SC', as_uf_fornecedor, io_Produto, adc_ipi, ls_Fornecedor, adc_pc_icms)

If ldc_Valor_Compra < 0 Then
	SqlCa.of_Rollback();
	MessageBox("Erro", "Valor de compra calculado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	Return False
End If

//// ICMS normal ou ICMS normal com redu$$HEX2$$e700e300$$ENDHEX$$o
//If io_Simula.cd_tributacao_icms = '00' or  io_Simula.cd_tributacao_icms = '02' Then
//	// Tira o IPI
//	ldc_Valor_Compra = ldc_Valor_Compra - io_Simula.vl_ipi
//	// Retira o ICMS
//	ldc_Valor_Compra = round(ldc_Valor_Compra * ((100 - adc_pc_icms) / 100), 2)
//	// Acrescenta o IPI
//	ldc_Valor_Compra = ldc_Valor_Compra + io_Simula.vl_ipi
//End If

ldc_Pc_Mva = io_Simula.vl_mva

If IsNull(ldc_Pc_Mva) Then
	ldc_Pc_Mva = 0.00
End If

INSERT INTO alteracao_preco_venda_prd (	nr_alteracao,   
													  	cd_produto,   
														de_produto,   
														nr_classificacao_fiscal,   
														vl_preco_fabrica,   
														pc_desconto,   
														pc_mva,   
														vl_bc_icms,   
														pc_reducao_base_icms,   
														pc_icms,   
														vl_icms,   
														vl_bc_icms_st,   
														pc_reducao_base_st,   
														pc_icms_st,   
														vl_icms_st,   
														vl_bc_ipi,   
														  pc_ipi,   
														  vl_ipi,   
														  pc_pis_cofins,   
														  vl_custo_compra,
														  vl_venda_sugerido_forn,
														  pc_repasse_icms)  
VALUES (	:al_codigo_alteracao,						//nr_alteracao,   
           		 :io_Produto.cd_produto,					//cd_produto,   
				  :as_prod_distribuidora,					//de_produto,   
				  :io_Produto.nr_classificacao_fiscal,		//nr_classificacao_fiscal,   
				  :adc_preco_fabrica,							//vl_preco_fabrica,   
				  :adc_desconto,								//pc_desconto,   
				  :ldc_Pc_Mva,									//pc_mva,   
				  :io_Simula.vl_bc_icms,						//vl_bc_icms,   
				  :io_Simula.pc_Reducao_Base_ICMS,	//pc_reducao_base_icms,   
				  :io_Simula.pc_icms_compra, 				//pc_icms,   
				  :io_Simula.vl_icms,							//vl_icms,   
				  :io_Simula.vl_bc_icms_st,  				//vl_bc_icms_st,   
				  0,												//pc_reducao_base_st,   
				  :io_Simula.pc_icms_venda,   				//pc_icms_st,   
				  :io_Simula.vl_icms_st,						//vl_icms_st,   
				  :io_Simula.vl_bc_ipi,   						//vl_bc_ipi,   
				  :adc_ipi,										//pc_ipi,   
				  :io_Simula.vl_ipi,  							//vl_ipi,   
				  0,												//pc_pis_cofins,   
				  :ldc_Valor_Compra,							//vl_custo_compra)
				  :adc_preco_sugerido_forn,
				  :io_Simula.pc_repasse)

Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdbError("Erro ao inserir o produto: " + String(io_produto.cd_produto) + ". " + SqlCa.SqlErrText)
	Return False
End If

Return True
end function

on w_ge375_alteracao_preco.create
int iCurrent
call super::create
this.cb_finaliza=create cb_finaliza
this.cb_1=create cb_1
this.cb_atualiza_preco=create cb_atualiza_preco
this.st_confirmar=create st_confirmar
this.dw_5=create dw_5
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_importar_planilha=create cb_importar_planilha
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_finaliza
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_atualiza_preco
this.Control[iCurrent+4]=this.st_confirmar
this.Control[iCurrent+5]=this.dw_5
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.cb_importar_planilha
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_4
end on

on w_ge375_alteracao_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_finaliza)
destroy(this.cb_1)
destroy(this.cb_atualiza_preco)
destroy(this.st_confirmar)
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_importar_planilha)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_3.Event ue_AddRow()
dw_4.Event ue_AddRow()
dw_5.Event ue_AddRow()

io_produto 		= Create uo_Produto
io_Alteracao 	= Create uo_ge376_alteracao_preco_venda

ids_UF 			= Create dc_uo_ds_Base

io_Simula 		= Create uo_simula_pedido

io_simula.id_considera_repasse = 'N'

io_nf = Create uo_ge118_nf_transferencia_perini



ivdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

dw_1.Object.Dt_Inicio_Vigencia[1] = RelativeDate(ivdt_Parametro, 1)

dw_1.SetFocus()
end event

event close;call super::close;Destroy ids_UF
Destroy io_produto
Destroy io_Alteracao
Destroy io_Simula
Destroy io_nf

end event

event ue_save;// OverRide

If wf_salva_alteracoes() Then
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)	
End If

Return 1
end event

event ue_cancel;//wf_alteracoes_pendentes()

//OverRide

dw_1.Event ue_Cancel()
end event

event closequery;// OverRide

Integer li_Retorno

li_Retorno = wf_alteracoes_pendentes()

// Cancela
If li_Retorno = 3 Then
	// N$$HEX1$$e300$$ENDHEX$$o fecha
	Return 1
Else
	// Salva
	If li_Retorno =1 Then
		// Se houver erros
		If Not wf_salva_alteracoes() Then
			// N$$HEX1$$e300$$ENDHEX$$o fecha
			Return 1
		End If
	End If
	
	// Fecha
	Return 0
End If
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge375_alteracao_preco
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge375_alteracao_preco
end type

type cb_finaliza from commandbutton within w_ge375_alteracao_preco
integer x = 2976
integer y = 188
integer width = 544
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Finalizar Altera$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;wf_finaliza_alteracao()
end event

type cb_1 from commandbutton within w_ge375_alteracao_preco
integer x = 2976
integer y = 300
integer width = 544
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Altera$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;wf_exclui_alteracao()
end event

type cb_atualiza_preco from commandbutton within w_ge375_alteracao_preco
integer x = 4325
integer y = 300
integer width = 763
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar o Pre$$HEX1$$e700$$ENDHEX$$o de Venda"
end type

event clicked;wf_atualiza_preco_futuro()
end event

type st_confirmar from statictext within w_ge375_alteracao_preco
boolean visible = false
integer x = 3785
integer y = 572
integer width = 951
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

type dw_5 from dc_uo_dw_base within w_ge375_alteracao_preco
integer x = 2839
integer y = 1604
integer width = 2053
integer height = 348
integer taborder = 80
string dataobject = "dw_ge375_detalhes_transf"
end type

type dw_4 from dc_uo_dw_base within w_ge375_alteracao_preco
integer x = 32
integer y = 1604
integer width = 2656
integer taborder = 70
string dataobject = "dw_ge375_detalhes_compra"
end type

type dw_3 from dc_uo_dw_base within w_ge375_alteracao_preco
integer x = 55
integer y = 500
integer width = 448
integer height = 72
integer taborder = 50
string dataobject = "dw_ge375_uf"
end type

event itemchanged;call super::itemchanged;dw_2.Event ue_retrieve(  )
end event

type dw_2 from dc_uo_dw_base within w_ge375_alteracao_preco
integer x = 50
integer y = 540
integer width = 5042
integer height = 928
integer taborder = 50
string dataobject = "dw_ge375_lista"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_recuperar;//Over

String ls_UF
Long ll_Codigo

dw_1.AcceptText()
dw_3.AcceptText()

ls_UF 		= dw_3.Object.cd_uf				[ 1 ]
ll_Codigo	= dw_1.Object.nr_alteracao		[ 1 ]

Return This.Retrieve( ll_Codigo, ls_UF  )
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_4.Object.vl_preco_fabrica			[1] = dw_2.Object.vl_preco_fabrica			[CurrentRow]
	dw_4.Object.vl_bc_icms					[1] = dw_2.Object.vl_bc_icms					[CurrentRow]
	dw_4.Object.vl_icms						[1] = dw_2.Object.vl_icms						[CurrentRow]
	dw_4.Object.de_produto					[1] = dw_2.Object.de_produto					[CurrentRow]
	dw_4.Object.nr_classificacao_fiscal	[1] = dw_2.Object.nr_classificacao_fiscal	[CurrentRow]
	dw_4.Object.pc_mva						[1] = dw_2.Object.pc_mva						[CurrentRow]
	dw_4.Object.pc_icms						[1] = dw_2.Object.pc_icms						[CurrentRow]
	dw_4.Object.pc_icms_st					[1] = dw_2.Object.pc_icms_st					[CurrentRow]
	dw_4.Object.pc_ipi						[1] = dw_2.Object.pc_ipi							[CurrentRow]
	dw_4.Object.vl_bc_ipi						[1] = dw_2.Object.vl_bc_ipi						[CurrentRow]
	dw_4.Object.vl_ipi							[1] = dw_2.Object.vl_ipi							[CurrentRow]
	dw_4.Object.vl_bc_icms_st				[1] = dw_2.Object.vl_bc_icms_st				[CurrentRow]
	dw_4.Object.vl_icms_st					[1] = dw_2.Object.vl_icms_st					[CurrentRow]
	dw_4.Object.pc_Reducao_Base_ICMS[1] = dw_2.Object.pc_Reducao_Base_ICMS	[CurrentRow]
		
	dw_5.Object.vl_custo_transferencia	[1] = dw_2.Object.vl_custo_transferencia_u	[CurrentRow]
	dw_5.Object.vl_bc_icms					[1] = dw_2.Object.vl_bc_icms_u					[CurrentRow]
	dw_5.Object.vl_icms						[1] = dw_2.Object.vl_icms_u						[CurrentRow]
	dw_5.Object.pc_mva						[1] = dw_2.Object.pc_mva_u						[CurrentRow]
	dw_5.Object.pc_icms						[1] = dw_2.Object.pc_icms_u						[CurrentRow]
	dw_5.Object.pc_icms_st					[1] = dw_2.Object.pc_icms_st_u					[CurrentRow]
	dw_5.Object.vl_bc_icms_st				[1] = dw_2.Object.vl_bc_icms_st_u				[CurrentRow]
	dw_5.Object.vl_icms_st					[1] = dw_2.Object.vl_icms_st_u					[CurrentRow]
	dw_5.Object.pc_Reducao_Base_ICMS[1] = dw_2.Object.pc_reducao_base_icms_u	[CurrentRow]
	dw_5.Object.vl_venda					[1] = dw_2.Object.vl_venda_u						[CurrentRow]
End If
end event

event ue_postretrieve;call super::ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir, &
		  lvb_Habilitar = False
		  
Date ldt_Finalizacao


dw_1.AcceptText()

If pl_Linhas > 0 Then
	
	ldt_Finalizacao = Date(dw_1.Object.dh_finalizacao[1])
	
	If IsNull(ldt_Finalizacao) Then
		dw_2.Object.pc_margem_resultado_u.Protect		= 	0
		dw_2.Object.vl_venda_u.Protect						= 	0
		dw_2.Object.id_utilizado_preco_sug_forn.Protect	= 	0
		dw_2.Object.id_atualizar.Protect						=	0
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A altera$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ foi finalizada e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser mais alterada.", Exclamation!)
		dw_2.Object.pc_margem_resultado_u.Protect		= 	1
		dw_2.Object.vl_venda_u.Protect						= 	1
		dw_2.Object.id_utilizado_preco_sug_forn.Protect	= 	1
		dw_2.Object.id_atualizar.Protect						= 	1
	End If
		
	wf_verifica_bloqueio()
	
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir	= True
	lvb_Habilitar	= True
	
	Parent.ivm_Menu.mf_salvarcomo(True)
	
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		Parent.ivm_Menu.mf_salvarcomo(False)
		dw_3.Reset()
		dw_3.Event ue_AddRow()
		dw_3.SetFocus()
	End If
End If

ivm_Menu.mf_Classificar(lvb_Classificar)
ivm_Menu.mf_Filtrar(lvb_Filtrar)
ivm_Menu.mf_Localizar(lvb_Localizar)
ivm_Menu.mf_Imprimir(lvb_Imprimir)

Return pl_Linhas
end event

event itemchanged;call super::itemchanged;Decimal ldc_Margem, ldc_Custo_Transferencia, ldc_Venda, ldc_ST, ldc_Venda_Alterado

If dwo.Name = "id_atualizar" Then
	If Data = "S" Then
		If This.Object.id_preco_bloqueado[row] = 'S' Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto est$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado na promo$$HEX2$$e700e300$$ENDHEX$$o." + "~r~rDeseja alterar o pre$$HEX1$$e700$$ENDHEX$$o mesmo assim ?", Question!, YesNo!, 2) = 2 Then 
				Return 1
			End If		
		End If
	End If
End If

If dwo.Name = "id_utilizado_preco_sug_forn" Then 
	If Data = "S" Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja utilizar o pre$$HEX1$$e700$$ENDHEX$$o sugerido pelo fornecedor ?", Question!, YesNo!, 2) = 1 Then 
			This.Object.vl_venda_u[row] = This.Object.vl_venda_sugerido_forn[row]
		Else
			Return 1
		End If		
		ii_Alteracoes++
	Else
		This.Object.vl_venda_u[row] = This.Object.vl_venda_u_original[row]
		ii_Alteracoes --
	End If
End If

ldc_Custo_Transferencia = This.Object.vl_custo_transferencia_u	[row]

//ldc_Venda = round((adc_custo_compra + ldc_ICMS_ST) / ((100 - ldc_PC_Margem) / 100), 1)
If dwo.Name = "pc_margem_resultado_u" Then 
	If This.Object.id_utilizado_preco_sug_forn	[row] = 'N' Then
		ldc_Margem = Dec(Data)
		
		If IsNull(ldc_Margem) or ldc_Margem <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O percentual da margem de resultado deve ser maior que zero.", Exclamation!)
			Return 1
		End If
		
		ldc_ST	= This.Object.vl_icms_st_u					[row]
		
		// Recalcula a venda
		This.Object.vl_venda_u	[row] = round((ldc_Custo_Transferencia + ldc_ST) / ((100 - ldc_Margem) / 100), 1)
		ii_Alteracoes++
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ser$$HEX1$$e100$$ENDHEX$$ utilizado o pre$$HEX1$$e700$$ENDHEX$$o sugerido pelo fornecedor.")
		Return 1
	End If
End If 

If dwo.Name = "vl_venda_u" Then
	ldc_Venda_Alterado = Dec(Data)
	
	This.Object.pc_margem_resultado_u[row] = round((1 - (ldc_Custo_Transferencia / ldc_Venda_Alterado)) * 100, 2)
	
	If This.Object.pc_margem_resultado_u[row]  <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A margem calcula $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
		Return 1
	End If
	
	ii_Alteracoes++
End If

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
	

end event

event doubleclicked;call super::doubleclicked;Long lvl_Row
	  
String lvs_Marcacao,&
	   lvs_Nulo 

SetNull(lvs_Nulo)

Choose Case dwo.Name 
			
	Case 'id_atualizar_t'
			
		If ivb_Check Then
			lvs_Marcacao = 'N'
			ivb_Check = False
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		Else
			lvs_Marcacao = 'S'
			ivb_Check = True
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		End If
		
		For lvl_Row = 1 To This.RowCount()
			
			If lvs_Marcacao = 'N' Then
				dw_2.Object.id_atualizar[lvl_Row] = lvs_Marcacao
			Else
				If dw_2.Object.id_preco_bloqueado[lvl_Row] = 'N' Then
					dw_2.Object.id_atualizar[lvl_Row] = lvs_Marcacao
				End If
			End If
			
		Next
		
End Choose
end event

event editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

type cb_importar_planilha from commandbutton within w_ge375_alteracao_preco
integer x = 4325
integer y = 188
integer width = 763
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Planilha"
end type

event clicked;String ls_Path, ls_Barras, ls_Prod_distribuidora, ls_Nm_Arquivo, ls_UF_Forn

Long ll_Row, ll_Total, ll_Linha_Nova, ll_Produto, ll_Codigo, ll_Classificacao_Fiscal

Boolean lb_Sucesso = True, lb_Retorno

Any la_Dado

Integer li_arquivo

Decimal ldc_PC_ICMS, ldc_PC_IPI, ldc_Preco_Fabrica, ldc_PC_desconto, ldc_Preco_Sugerido

ll_Codigo = dw_1.Object.nr_alteracao [ 1 ]  

If IsNull ( ll_Codigo ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cadastro de altera$$HEX2$$e700e300$$ENDHEX$$o.")	
	Return
End If

If wf_seleciona_arquivo(Ref ls_Path, Ref ls_Nm_Arquivo ) <= 0 Then Return

wf_verifica_uf_fornecedor(ref ls_UF_Forn)

Try											
	
	SetPointer(HourGlass!)
											
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo dados do arquivo : '" + Upper( ls_Nm_Arquivo ) + "'."
	
	dc_uo_Excel lo_Excel
	lo_Excel = Create dc_uo_Excel
	
	lo_Excel.uo_Referencia_Objeto_Excel( ls_Path )
	ll_Total = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Total )
	
	If Not ids_UF.Of_ChangeDataObject( "ddw_uf_ativa" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no ChangeDataObject 'ddw_uf_ativa'.")
		Return -1
	End If
	
	If ids_UF.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve 'ddw_uf_ativa'.")
		Return -1
	End If
				
	For ll_Row = 1 To ll_Total
		
		 ldc_PC_ICMS			= 0.00
		 ldc_PC_IPI				= 0.00
		 ldc_Preco_Fabrica	= 0.00
		 ldc_PC_desconto		= 0.00
		 ldc_Preco_Sugerido	= 0.00
		
		w_Aguarde.uo_Progress.of_SetProgress( ll_Row )
		
		//A - Codigo Barras	
		If Not wf_Valor( ll_Row, lo_Excel.uo_Lendo_Dados( ll_Row, "A"), 'A', Ref la_Dado, lb_Retorno) Then Exit
		ls_Barras = String( la_Dado )
		
		If Not lb_Retorno Then Continue
				
		//Leitura da coluna B - Descricao Produto Distribuidora
		If Not wf_Valor( ll_Row, lo_Excel.uo_Lendo_Dados( ll_Row, "B"), 'B', Ref la_Dado, lb_Retorno ) Then Exit
		ls_Prod_distribuidora = String( la_Dado )
			
		//Leitura da coluna C - Classificacao_fiscal
		If Not wf_Valor( ll_Row, lo_Excel.uo_Lendo_Dados( ll_Row, "C"), 'C', Ref la_Dado, lb_Retorno ) Then Exit
		ll_Classificacao_Fiscal = Long( la_Dado )
		
		//Leitura da coluna D - PC ICMS Compra
		If Not wf_Valor( ll_Row, lo_Excel.uo_Lendo_Dados( ll_Row, "D"), 'D', Ref la_Dado, lb_Retorno ) Then Exit
		ldc_PC_ICMS = Dec( la_Dado )
				
		//Leitura da coluna E - VL Preco Fabrica
		If Not wf_Valor( ll_Row,  lo_Excel.uo_Lendo_Dados( ll_Row, "E"), 'E', Ref la_Dado, lb_Retorno ) Then Exit
		ldc_Preco_Fabrica = Dec( la_Dado )
				
		//Leitura da coluna F - PC Desconto
		If Not wf_Valor( ll_Row,  lo_Excel.uo_Lendo_Dados( ll_Row, "F"), 'F', Ref la_Dado, lb_Retorno ) Then Exit
		ldc_PC_desconto = Dec( la_Dado )
				
		//Leitura da coluna G - PC IPI
		la_Dado = lo_Excel.uo_Lendo_Dados( ll_Row, "G")
		If Not wf_Valor( ll_Row, lo_Excel.uo_Lendo_Dados( ll_Row, "G"), 'G', Ref la_Dado, lb_Retorno ) Then Exit
		ldc_PC_IPI = Dec( la_Dado )
	
		//Leitura da coluna H - Preco Venda_Sugerido
		If Not wf_Valor( ll_Row, lo_Excel.uo_Lendo_Dados( ll_Row, "H"), 'H', Ref la_Dado, lb_Retorno ) Then Exit
		ldc_Preco_Sugerido = Dec( la_Dado )
		//ldc_Preco_Sugerido = 0.00
		
 		If wf_grava_Preco_produto( ll_Codigo, io_produto.cd_produto, ls_Prod_distribuidora, ldc_Preco_Fabrica, ldc_PC_Desconto, ldc_PC_IPI, ls_UF_Forn, ldc_Preco_Sugerido, ldc_PC_ICMS ) Then
			lb_Sucesso = True
		End If
		
		If Not lb_Sucesso Then Exit
				
		Yield()	 
			 
	Next
	
	If lb_Sucesso Then
		// Grava os produtos na alteracao_preco_venda_prd_uf
		lb_Sucesso = wf_atualiza_valores(ll_Codigo)
	End If
	
	If Not lb_Sucesso Then
		SqlCa.of_Rollback()
	Else
		SqlCa.of_Commit()
	End If
	
Finally
	SetPointer(Arrow!)
	//dw_1.of_SetRowSelection()
	Destroy lo_Excel
	Close( w_Aguarde )
	dw_2.Event ue_Retrieve()
End Try

end event

type dw_1 from dc_uo_dw_base within w_ge375_alteracao_preco
integer x = 55
integer y = 76
integer width = 2839
integer height = 284
integer taborder = 20
string dataobject = "dw_ge375_selecao"
end type

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	
	dw_1.AcceptText()
		
	dw_2.Reset()
	dw_2.Event ue_retrieve()
End If

Return pl_linhas
end event

event buttonclicked;call super::buttonclicked;Long ll_Codigo

OpenWithParm(w_ge375_cad_alteracao_preco_venda,"")

ll_Codigo = Message.DoubleParm

dw_1.AcceptText()

If Not IsNull(ll_Codigo) Then
	dw_1.Reset()
	dw_2.Reset()
	io_Alteracao.of_localiza_codigo( ll_Codigo )
	If io_Alteracao.Localizada Then This.Retrieve( io_Alteracao.nr_alteracao )
	
//	If dw_1.RowCount() > 0 Then
//		If Not	IsNull(Date(dw_1.Object.dh_finalizacao[1])) Then
//			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A altera$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ foi finalizada e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser mais alterada.")
//		End If
//	End If
End If
end event

event ue_key;call super::ue_key;String ls_busca

If Key = KeyEnter! Then
	If This.GetColumnName() = 'de_localizacao' Then
		
		io_Alteracao.of_Localiza( This.GetText() )

		If io_Alteracao.Localizada Then 
			This.Retrieve( io_Alteracao.nr_alteracao )
			dw_2.Event ue_Retrieve()
			dw_1.Object.Dt_Inicio_Vigencia[1] = RelativeDate(ivdt_Parametro, 1)
		End If
								
	End If	
End If
end event

event ue_recuperar;Long ll_Alteracao

dw_1.AcceptText()

// Esta fun$$HEX1$$e700$$ENDHEX$$ao $$HEX1$$e900$$ENDHEX$$ disparada pelo ue_Cancel() da dw_1.

ll_Alteracao = dw_1.Object.nr_alteracao [ 1 ]  

If IsNull ( ll_Alteracao ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cadastro de altera$$HEX2$$e700e300$$ENDHEX$$o.")	
	Return -1
End If

Return This.Retrieve(ll_Alteracao)

end event

event ue_saveas;// OverRide

dw_2.Event ue_SaveAs()
end event

type gb_1 from groupbox within w_ge375_alteracao_preco
integer x = 18
integer y = 4
integer width = 2907
integer height = 400
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge375_alteracao_preco
integer x = 18
integer y = 428
integer width = 5106
integer height = 1076
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge375_alteracao_preco
integer x = 18
integer y = 1536
integer width = 2702
integer height = 440
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Compra"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_ge375_alteracao_preco
integer x = 2802
integer y = 1544
integer width = 2098
integer height = 428
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Transfer$$HEX1$$ea00$$ENDHEX$$ncia"
borderstyle borderstyle = styleraised!
end type

