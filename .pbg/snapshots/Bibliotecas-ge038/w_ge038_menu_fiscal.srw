HA$PBExportHeader$w_ge038_menu_fiscal.srw
forward
global type w_ge038_menu_fiscal from window
end type
type cb_2 from commandbutton within w_ge038_menu_fiscal
end type
type cb_3 from commandbutton within w_ge038_menu_fiscal
end type
type cb_1 from commandbutton within w_ge038_menu_fiscal
end type
type cb_diversos from commandbutton within w_ge038_menu_fiscal
end type
type cb_venda_cpf from commandbutton within w_ge038_menu_fiscal
end type
type cb_envio_estoque from commandbutton within w_ge038_menu_fiscal
end type
type cb_envio_reducao from commandbutton within w_ge038_menu_fiscal
end type
type cb_espelho_mdf from commandbutton within w_ge038_menu_fiscal
end type
type cb_registros from commandbutton within w_ge038_menu_fiscal
end type
type cb_arquivo_mf from commandbutton within w_ge038_menu_fiscal
end type
type cb_parametros_configuracao from commandbutton within w_ge038_menu_fiscal
end type
type cb_tab_indice_tecnico from commandbutton within w_ge038_menu_fiscal
end type
type cb_vendas_periodo from commandbutton within w_ge038_menu_fiscal
end type
type cb_sangria from commandbutton within w_ge038_menu_fiscal
end type
type cb_suprimento from commandbutton within w_ge038_menu_fiscal
end type
type cb_sair from commandbutton within w_ge038_menu_fiscal
end type
type dw_1 from dc_uo_dw_base within w_ge038_menu_fiscal
end type
type st_msg from statictext within w_ge038_menu_fiscal
end type
type cb_identifica_pafecf from commandbutton within w_ge038_menu_fiscal
end type
type cb_arquivo_mfd from commandbutton within w_ge038_menu_fiscal
end type
type cb_lmfc_data from commandbutton within w_ge038_menu_fiscal
end type
type cb_lx from commandbutton within w_ge038_menu_fiscal
end type
end forward

global type w_ge038_menu_fiscal from window
integer x = 1056
integer y = 948
integer width = 2597
integer height = 1096
boolean titlebar = true
string title = "GE038 - PAF Menu fiscal"
windowtype windowtype = response!
long backcolor = 80269524
cb_2 cb_2
cb_3 cb_3
cb_1 cb_1
cb_diversos cb_diversos
cb_venda_cpf cb_venda_cpf
cb_envio_estoque cb_envio_estoque
cb_envio_reducao cb_envio_reducao
cb_espelho_mdf cb_espelho_mdf
cb_registros cb_registros
cb_arquivo_mf cb_arquivo_mf
cb_parametros_configuracao cb_parametros_configuracao
cb_tab_indice_tecnico cb_tab_indice_tecnico
cb_vendas_periodo cb_vendas_periodo
cb_sangria cb_sangria
cb_suprimento cb_suprimento
cb_sair cb_sair
dw_1 dw_1
st_msg st_msg
cb_identifica_pafecf cb_identifica_pafecf
cb_arquivo_mfd cb_arquivo_mfd
cb_lmfc_data cb_lmfc_data
cb_lx cb_lx
end type
global w_ge038_menu_fiscal w_ge038_menu_fiscal

type prototypes

end prototypes

type variables
uo_menu_fiscal ivo_menu

s_ge038_parametro_pafecf ivs_Parametro

String ivs_Laudo
String ivs_Autenticacao_Caixa
String ivs_Autenticacao_Retaguarda
String ivs_MD5
String ivs_data_laudo

dc_uo_ds_base ivds_produto
end variables

forward prototypes
public subroutine wf_cria_diretorio_paf ()
public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal)
public subroutine wf_limpa_parametros ()
public function boolean wf_gera_produto_estoque (integer pl_arquivo, ref boolean pb_evidenciado)
public function boolean wf_gera_estoque_saldo (integer pl_arquivo, ref boolean pb_evidenciado)
public function boolean wf_gera_registrosr (integer pl_file, ref boolean pl_evidenciado, date pdh_inicial, date pdh_final)
public function boolean wf_gera_registoe3 (integer pl_arquivo, ref boolean pb_evidenciado, integer pl_ecf)
public function boolean wf_movimento_estoque (date pd_data, long pl_produto, ref long pl_quantidade)
public function boolean wf_gera_registrosj (integer pl_file, ref boolean pl_evidenciado, date pdh_inicial, date pdh_final)
end prototypes

public subroutine wf_cria_diretorio_paf ();dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF')

Destroy(lo_api)
end subroutine

public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal);
String 	ls_Valor

If IsNull(pdc_Valor) Then pdc_Valor = 000.00

ls_Valor = FillA('0', pl_inteiro + pl_decimal) + MidA( String(pdc_valor) , 1, LenA(String(pdc_valor)) -3 ) + RightA(String(pdc_valor),2)

ls_Valor = RightA( ls_Valor, pl_inteiro + pl_decimal )

Return ls_Valor
end function

public subroutine wf_limpa_parametros ();SetNull(ivs_parametro.id_periodo)
SetNull(ivs_parametro.id_ecf)
SetNull(ivs_parametro.id_reducao)
SetNull(ivs_parametro.id_coo)
SetNull(ivs_parametro.id_retorno)
SetNull(ivs_parametro.id_destino)
SetNull(ivs_parametro.id_modelo_arquivo)
SetNull(ivs_parametro.id_leitura)
SetNull(ivs_parametro.id_estoque)
SetNull(ivs_parametro.id_cpf)
end subroutine

public function boolean wf_gera_produto_estoque (integer pl_arquivo, ref boolean pb_evidenciado);Long ll_Row
Long ll_Linhas
Long ll_Produto

String ls_Estoque
String ls_IAT
String ls_IPPT
String ls_Situacao_Tributaria
String ls_Registro
String ls_Desc_Produto
String ls_Und
String ls_Unidade
String ls_codigo_barras
String ls_cest
String ls_ncm

Decimal{2} ldc_Preco
Decimal{2} ldc_Aliquota
Decimal{2} ldc_Desconto

uo_Produto lvo_Produto
lvo_Produto = Create uo_Produto

uo_Tratamento_Fiscal	lvo_tratamento_fiscal
lvo_tratamento_fiscal = Create uo_Tratamento_Fiscal

uo_Atributo_Fiscal_Item_Nf	lvo_atributo
lvo_atributo = Create uo_Atributo_Fiscal_Item_Nf

lvo_tratamento_fiscal.of_grava_uf_origem_destino( gvo_parametro.ivs_uf_filial, gvo_parametro.ivs_uf_filial)

gvo_aplicacao.of_grava_log("Registros PAF - Inicio Gera$$HEX2$$e700e300$$ENDHEX$$o Produtos - GE038 wf_gera_produto_estoque")		

If ivs_Parametro.id_Estoque = 'P' Then	
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando arquivos Produto..."
	ll_Linhas = ivds_Produto.RowCount()
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)	
	
	For ll_Row = 1 To ivds_Produto.RowCount()
	
		ll_Produto 		  = ivds_Produto.Object.Cd_Produto[ll_Row]	
		ls_Desc_Produto = ivds_Produto.Object.De_Produto[ll_Row]
		ls_Und			  = ivds_Produto.Object.cd_un[ll_Row]
	
		lvo_Produto.of_Localiza_Codigo_Interno(ll_Produto)
		
		// Carrega os atributos fiscais 
		lvo_atributo = lvo_tratamento_fiscal.of_atributo_fiscal_produto(lvo_Produto)
		
		If lvo_Produto.Localizado Then
			ldc_Preco 			= lvo_Produto.of_Preco_Venda_Filial()
			ldc_Desconto  		= lvo_Produto.of_Desconto_Filial()
			ldc_Preco 			= ldc_Preco * ((100 - ldc_Desconto) / 100)
			ls_codigo_barras 	= lvo_produto.de_codigo_barras			
			If IsNull(lvo_produto.cd_cest) Or Trim(lvo_produto.cd_cest) = '' Then
				ls_cest = ivo_Menu.cd_cest_generico
			Else
				ls_cest = lvo_produto.cd_cest
			End If			
			If IsNull(String(lvo_produto.nr_classificacao_fiscal,'00000000')) Then	
				ls_ncm = '00000000'
			Else
				ls_ncm = String(lvo_produto.nr_classificacao_fiscal,'00000000')
			End If			

			Choose Case lvo_atributo.cd_situacao_tributaria
				Case '00'
					ls_Situacao_Tributaria = 'T'
					ldc_Aliquota = lvo_tratamento_fiscal.of_Aliquota_Tipo_ICMS(lvo_produto.cd_tipo_icms)							
				Case '04'
					ls_Situacao_Tributaria = 'I'
					ldc_Aliquota = 0.00
				Case else
					ls_Situacao_Tributaria = 'F'
					ldc_Aliquota = 0.00
			End Choose 
			
			ls_IAT = 'A'
			ls_IPPT = 'T'
			
		End If
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If ivo_menu.ivb_padraoH Then
			If ivo_Menu.of_inconsistencia_produto_geral(ll_Produto) Then
				ls_Unidade = FillA("?", 6)
				pb_Evidenciado = True			
			ElseIf ivo_Menu.of_inconsistencia_saldo_produto(ll_Produto, Today(), False, 0) Then
				ls_Unidade = FillA("?", 6)
				pb_Evidenciado = True
			End If				
		End If
		
		ls_Registro += 'P2' 						
		ls_Registro += LeftA(gvo_parametro.nr_cgc+Space(14),14)
		ls_Registro += LeftA(String(ll_produto)+Space(14),14)
		ls_Registro += LeftA(ls_cest+Space(7),7)
		ls_Registro += LeftA(ls_ncm+Space(8),8)				
		ls_Registro += LeftA(ls_Desc_Produto+Space(50),50)
		ls_Registro += LeftA(ls_und+ls_Unidade,6)
		ls_Registro += LeftA(ls_IAT,1)
		ls_Registro += LeftA(ls_IPPT,1)
		ls_Registro += LeftA(ls_Situacao_Tributaria,1)
		ls_Registro += ivo_menu.of_Formata_Valor_PafEcf(ldc_Aliquota,2,2)
		ls_Registro += ivo_menu.of_Formata_Valor_PafEcf(ldc_Preco,10,2)
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then Return False
		
		If Not ivo_Menu.of_grava_registro_temp( 'P2', '', '', '', ls_Registro ) Then
			Return False
		End If	
		
		ls_Registro = ''
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
	
	Next

	Close(w_Aguarde)

End If

If ivs_Parametro.id_Estoque = 'T' Then
	If Not ivds_produto.of_ChangeDataObject('dw_ge038_pafecf_estoque') Then
		Return False
	End If
	
	ivds_produto.Retrieve()
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando arquivos Produto..."
	ll_Linhas = ivds_Produto.RowCount()
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)	
	
	For ll_Row = 1 To ivds_Produto.RowCount()
	
		ll_Produto 		  = ivds_Produto.Object.Cd_Produto[ll_Row]	
		ls_Desc_Produto = ivds_Produto.Object.De_Produto[ll_Row]
		ls_Und			  = ivds_Produto.Object.cd_un[ll_Row]
		If IsNull(ivds_Produto.Object.cd_cest[ll_Row]) Or Trim(ivds_Produto.Object.cd_cest[ll_Row]) = '' Then
			ls_cest = ivo_Menu.cd_cest_generico
		Else
			ls_cest = ivds_Produto.Object.cd_cest[ll_Row]
		End If			
		If IsNull(String(ivds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
			ls_ncm = '00000000'
		Else
			ls_ncm = String(ivds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')
		End If				
	
		lvo_Produto.of_Localiza_Codigo_Interno(ll_Produto)
		
		// Carrega os atributos fiscais 
		lvo_atributo = lvo_tratamento_fiscal.of_atributo_fiscal_produto(lvo_Produto)
		
		If lvo_Produto.Localizado Then
			ldc_Preco = lvo_Produto.of_Preco_Venda_Filial()
			ldc_Desconto  	= lvo_Produto.of_Desconto_Filial()
			ldc_Preco 		= ldc_Preco * ((100 - ldc_Desconto) / 100)
			ls_codigo_barras 	= lvo_produto.de_codigo_barras
			If IsNull(lvo_produto.cd_cest) Or Trim(lvo_produto.cd_cest) = '' Then
				ls_cest = ivo_Menu.cd_cest_generico
			Else
				ls_cest = lvo_produto.cd_cest
			End If			
			If IsNull(String(lvo_produto.nr_classificacao_fiscal,'00000000')) Then	
				ls_ncm = '00000000'
			Else
				ls_ncm = String(lvo_produto.nr_classificacao_fiscal,'00000000')
			End If						

			Choose Case lvo_atributo.cd_situacao_tributaria
				Case '00'
					ls_Situacao_Tributaria = 'T'
					ldc_Aliquota = lvo_tratamento_fiscal.of_Aliquota_Tipo_ICMS(lvo_produto.cd_tipo_icms)							
				Case '04'
					ls_Situacao_Tributaria = 'I'
					ldc_Aliquota = 0.00
				Case else
					ls_Situacao_Tributaria = 'F'
					ldc_Aliquota = 0.00
			End Choose 
			
			ls_IAT = 'A'
			ls_IPPT = 'T'
			
		End If
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If ivo_menu.ivb_padraoH Then
			If ivo_Menu.of_inconsistencia_produto_geral(ll_Produto) Then
				ls_Unidade = FillA("?", 6)
				pb_Evidenciado = True			
			ElseIf ivo_Menu.of_inconsistencia_saldo_produto(ll_Produto, Today(), False, 0) Then
				ls_Unidade = FillA("?", 6)
				pb_Evidenciado = True
			End If				
		End If
		
		ls_Registro += 'P2' 						
		ls_Registro += LeftA(gvo_parametro.nr_cgc+Space(14),14)
		ls_Registro += LeftA(String(ll_produto)+Space(14),14)
		ls_Registro += LeftA(ls_cest+Space(7),7)
		ls_Registro += LeftA(ls_ncm+Space(8),8)				
		ls_Registro += LeftA(ls_Desc_Produto+Space(50),50)
		ls_Registro += LeftA(ls_und+ls_Unidade,6)
		ls_Registro += LeftA(ls_IAT,1)
		ls_Registro += LeftA(ls_IPPT,1)
		ls_Registro += LeftA(ls_Situacao_Tributaria,1)
		ls_Registro += ivo_menu.of_Formata_Valor_PafEcf(ldc_Aliquota,2,2)
		ls_Registro += ivo_menu.of_Formata_Valor_PafEcf(ldc_Preco,10,2)
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then Return False
		
		If Not ivo_Menu.of_grava_registro_temp( 'P2', '', '', '', ls_Registro ) Then
			Return False
		End If	
		
		ls_Registro = ''
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
	
	Next
	
	Close(w_Aguarde)	
	
End If

//ivo_Menu.ids_arquivo.saveas( 'c:\sistemas\cl\arquivos\ds_produto.txt', TEXT!, false )

gvo_aplicacao.of_grava_log("Registros PAF - T$$HEX1$$e900$$ENDHEX$$rmino Gera$$HEX2$$e700e300$$ENDHEX$$o Produtos - GE038-wf_gera_produto_estoque")		

Destroy(lvo_Produto)
Destroy(lvo_atributo)
Destroy(lvo_tratamento_fiscal)	

Return True
end function

public function boolean wf_gera_estoque_saldo (integer pl_arquivo, ref boolean pb_evidenciado);Long ll_Row
Long ll_Linhas
Long ll_Produto
Long ll_Saldo
Long ll_Movimentado

String ls_Estoque
String ls_Registro
String ls_Desc_Produto
String ls_Und
String ls_Unidade
String ls_Sinal
String ls_ncm
String ls_cest

DateTime ldh_Data_Estoque
Date ldh_Data_Movimento

gvo_aplicacao.of_grava_log("Registros PAF - Inicio Saldo Produtos - GE038-wf_gera_estoque_saldo")		

If Not ivo_Menu.of_data_primeira_venda(ldh_Data_Estoque, PDV.ecf) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel buscar primeira venda do ECF.",StopSign!)
	Return False
Else
	If IsNull(ldh_Data_Estoque) Or String(ldh_Data_Estoque,'ddmmyyyy') = '01011900' Then
		ldh_Data_Estoque = gf_GetServerDate()
	End If
End If		

If ivs_Parametro.id_Estoque = 'P' Then	
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando arquivos Saldo Estoque..."
	ll_Linhas = ivds_Produto.RowCount()
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)	
	
	For ll_Row = 1 To ivds_Produto.RowCount()
	
		ll_Produto 		  	= ivds_Produto.Object.Cd_Produto[ll_Row]	
		ls_Desc_Produto 	= ivds_Produto.Object.De_Produto[ll_Row]
		ls_Und			  	= ivds_Produto.Object.cd_un[ll_Row]		
		If IsNull(ivds_Produto.Object.cd_cest[ll_Row]) Or Trim(ivds_Produto.Object.cd_cest[ll_Row]) = '' Then
			ls_cest = ivo_Menu.cd_cest_generico
		Else
			ls_cest = ivds_Produto.Object.cd_cest[ll_Row]
		End If			
		If IsNull(String(ivds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
			ls_ncm = '00000000'
		Else
			ls_ncm = String(ivds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')
		End If
		
		ldh_Data_Movimento = ivds_Produto.object.dh_ultima_venda[ll_row]
		If Date(ldh_Data_Estoque) >= Date(ldh_Data_Movimento) Then
			If wf_movimento_estoque(Date(ldh_Data_Estoque), ivds_Produto.object.cd_produto[ll_row], ll_Movimentado) Then
				//ls_Estoque = Trim(String(ivds_Produto.object.qt_saldo_final[ll_row] + ll_Movimentado))
				ls_Estoque = Trim(String(ll_Movimentado))
			End If
		Else		
			ls_Estoque = Trim(String(ivds_Produto.object.qt_saldo_final[ll_row]))
		End If		
		
		If Dec(ls_Estoque) < 0 Then
			ls_Estoque = gf_Replace(ls_Estoque,"-","0",0)
			ls_Sinal = "-"
		Else
			ls_Sinal = "+"
		End If		

		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If ivo_Menu.ivb_padraoH Then		
			If ivo_Menu.of_inconsistencia_produto_geral(ll_Produto) Then
				ls_Unidade = FillA("?", 6)
				pb_Evidenciado = True			
			ElseIf ivo_Menu.of_inconsistencia_saldo_produto(ll_Produto, Today(), False, 0) Then
				ls_Unidade = FillA("?", 6)
				pb_Evidenciado = True
			End If		
		End If
		
		ll_Saldo = Long(ls_Estoque)
		
		ls_Registro += 'E2' 						
		ls_Registro += LeftA(gvo_parametro.nr_cgc+Space(14),14)
		ls_Registro += LeftA(String(ll_Produto)+Space(14),14)
		ls_Registro += LeftA(ls_cest+Space(7),7)
		ls_Registro += LeftA(ls_ncm+Space(8),8)		
		ls_Registro += LeftA(ls_Desc_Produto+Space(50),50)
		ls_Registro += LeftA(ls_und+ls_Unidade,6)		
		ls_Registro += LeftA(ls_Sinal,1)
//		ls_Registro += RightA('000000000'+ ls_Estoque,09)
		ls_Registro += LeftA(String(ll_Saldo,'000000')+'000',9)
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then Return False
		
		If Not ivo_Menu.of_grava_registro_temp( 'E2', '', '', '', ls_Registro ) Then
			Return False
		End If
		
		ls_Registro = ''
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
	
	Next

	Close(w_Aguarde)
End If

If ivs_Parametro.id_Estoque = 'T' Then	
	If Not ivds_produto.of_ChangeDataObject('dw_ge038_pafecf_estoque') Then
		Return False
	End If
	
	ivds_produto.Retrieve()
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando arquivos Saldo Estoque..."
	ll_Linhas = ivds_Produto.RowCount()
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)	
	
	For ll_Row = 1 To ivds_Produto.RowCount()
	
		ll_Produto 		  	= ivds_Produto.Object.Cd_Produto[ll_Row]	
		ls_Desc_Produto 	= ivds_Produto.Object.De_Produto[ll_Row]
		ls_Und			  	= ivds_Produto.Object.cd_un[ll_Row]
		If IsNull(ivds_Produto.Object.cd_cest[ll_Row]) Or Trim(ivds_Produto.Object.cd_cest[ll_Row]) = '' Then
			ls_cest = ivo_Menu.cd_cest_generico
		Else
			ls_cest = ivds_Produto.Object.cd_cest[ll_Row]
		End If			
		If IsNull(String(ivds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
			ls_ncm = '00000000'
		Else
			ls_ncm = String(ivds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')
		End If		

		ldh_Data_Movimento = ivds_Produto.object.dh_ultima_venda[ll_row]
		If Date(ldh_Data_Estoque) >= Date(ldh_Data_Movimento) Then
			If wf_movimento_estoque(Date(ldh_Data_Estoque), ivds_Produto.object.cd_produto[ll_row], ll_Movimentado) Then
//				ls_Estoque = Trim(String(ivds_Produto.object.qt_saldo_final[ll_row] + ll_Movimentado))
				ls_Estoque = Trim(String(ll_Movimentado))
			End If
		Else		
			ls_Estoque = Trim(String(ivds_Produto.object.qt_saldo_final[ll_row]))
		End If		
		
		If Dec(ls_Estoque) < 0 Then
			ls_Estoque = gf_Replace(ls_Estoque,"-","0",0)
			ls_Sinal = "-"
		Else
			ls_Sinal = "+"
		End If	
		ll_Saldo = Long(ls_Estoque)
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If ivo_Menu.ivb_padraoH Then		
			If ivo_Menu.of_inconsistencia_produto_geral(ll_Produto) Then
				ls_Unidade = FillA("?", 6)
				pb_Evidenciado = True			
			ElseIf ivo_Menu.of_inconsistencia_saldo_produto(ll_Produto, Today(), False, 0) Then
				ls_Unidade = FillA("?", 6)
				pb_Evidenciado = True
			End If				
		End If
		
		ls_Registro += 'E2' 						
		ls_Registro += LeftA(gvo_parametro.nr_cgc+Space(14),14)
		ls_Registro += LeftA(String(ll_Produto)+Space(14),14)
		ls_Registro += LeftA(ls_cest+Space(7),7)
		ls_Registro += LeftA(ls_ncm+Space(8),8)				
		ls_Registro += LeftA(ls_Desc_Produto+Space(50),50)
//		ls_Registro += LeftA(ls_und+Space(6),6)
		ls_Registro += LeftA(ls_und+ls_Unidade,6)		
		ls_Registro += LeftA(ls_Sinal,1)
		ls_Registro += LeftA(String(ll_Saldo,'000000')+'000',9)
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then Return False
		
		If Not ivo_Menu.of_grava_registro_temp( 'E2', '', '', '', ls_Registro ) Then
			Return False
		End If
		
		ls_Registro = ''
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
	
	Next	
	
	Close(w_Aguarde)	
//	ivo_Menu.ids_arquivo.saveas( 'c:\sistemas\cl\arquivos\ds_saldo.txt', TEXT!, false )	
	gvo_aplicacao.of_grava_log("Registros PAF - T$$HEX1$$e900$$ENDHEX$$rmino Saldo Produtos - GE038-wf_gera_estoque_saldo")			
	
End If

Return True
end function

public function boolean wf_gera_registrosr (integer pl_file, ref boolean pl_evidenciado, date pdh_inicial, date pdh_final);Boolean lb_Sucesso

Long ll_row
Long ll_ecf

gvo_aplicacao.of_grava_log("Registros PAF - Inicio Registros R - GE038-wf_gera_registrosr")			

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_ecfs_ativas') Then 
	Destroy(lvds_1)
	Return False
End If

//lvds_1.of_AppendWhere("dh_ultima_venda >= '" + String(pdh_inicial,'yyyymmdd') +"'")
							 
lvds_1.Retrieve()

If lvds_1.RowCount() > 0 Then
	
	For ll_row = 1 To lvds_1.RowCount()	
		ll_ecf = lvds_1.Object.nr_ecf[ll_Row]
		
		If Not ivo_Menu.of_Carrega_dados_ecf(ll_ecf) Then Return False		
		gvo_aplicacao.of_grava_log("Registros PAF - Inicio Registro R ECF: " +String(ll_ecf) + "  - GE038-wf_gera_registrosr")								
		
		If ivo_Menu.of_pafecf_Registro_R01(ll_ecf, pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
			gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros R1 OK - GE038-wf_gera_registrosr")						
			
			If ivo_Menu.of_pafecf_Registro_R02(ll_ecf, pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
				gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros R2 OK - GE038-wf_gera_registrosr")										
				
				If ivo_Menu.of_pafecf_Registro_R03(ll_ecf, pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
					gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros R3 OK - GE038-wf_gera_registrosr")											
	
					If ivo_Menu.of_pafecf_Registro_R04(ll_ecf, pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
						gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros R4 OK - GE038-wf_gera_registrosr")												
				
						If ivo_Menu.of_pafecf_Registro_R05(ll_ecf, pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
							gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros R5 OK - GE038-wf_gera_registrosr")													
					
							If ivo_Menu.of_pafecf_Registro_R06(ll_ecf, pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
								gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros R6 OK - GE038-wf_gera_registrosr")														
								
								If ivo_Menu.of_pafecf_Registro_R07(ll_ecf, pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
									gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros R7 OK - GE038-wf_gera_registrosr")															
					
									lb_Sucesso = True
									
								End If
							End If
						End If
					End If
				End If
			End If
		End If		
	
	Next
	
End If

Destroy(lvds_1)

//ivo_Menu.ids_arquivo.saveas( 'c:\sistemas\cl\arquivos\ds_registrosR.txt', TEXT!, false )

gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros R - GE038-wf_gera_registrosr")			

Return lb_Sucesso
end function

public function boolean wf_gera_registoe3 (integer pl_arquivo, ref boolean pb_evidenciado, integer pl_ecf);Boolean lb_Sucesso

String ls_Tipo
String ls_Marca
String ls_Modelo

DateTime ldh_Data_Estoque

gvo_aplicacao.of_grava_log("Registros PAF - Inicio Registros E3 - GE038-wf_gera_registrose3")			

If Not ivo_Menu.of_Carrega_dados_ecf(pl_ecf) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados da ECF.",StopSign!)
	Return False
End If

ivo_Menu.of_data_primeira_venda(ldh_Data_Estoque,pl_ecf)

If IsNull(ivo_Menu.de_Tipo) Then 
	ls_Tipo += Space(07)
Else				 
	ls_Tipo += LeftA(ivo_Menu.de_Tipo + Space(07) , 07 )
End If

If IsNull(ivo_Menu.de_Marca) Then
	ls_Marca += Space(20)
Else	
	ls_Marca += LeftA(ivo_Menu.de_Marca + Space(20) , 20 )
End If

//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
If ivo_Menu.ivb_padraoH Then
	If ivo_Menu.of_inconsistencia_impressora_fiscal(pl_ecf) Then					
		ls_Modelo = FillA("?", 20)
		ls_Modelo = gf_Replace(LeftA( ivo_Menu.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
		pb_Evidenciado = True			
	Else
		ls_Modelo += LeftA(ivo_Menu.de_Modelo + Space(20) , 20 )
	End If
Else
	ls_Modelo += LeftA(ivo_Menu.de_Modelo + Space(20) , 20 )	
End If

//If FileWrite(pl_arquivo,'E3' + &
//							 LeftA(ivo_Menu.nr_Serie + Space(20),20) + &
//							 LeftA(ivo_Menu.id_MfAdicional, 1) + &
//							 ls_Tipo + ls_Marca + ls_Modelo + &
//							 String(ldh_Data_Estoque,'yyyymmdd') + & 
//							 String(ldh_Data_Estoque,'hhmmss')) <> -1 Then

If ivo_Menu.of_grava_registro_temp( 'E3', '', '', '', 'E3' + &
							 LeftA(ivo_Menu.nr_Serie + Space(20),20) + &
							 LeftA(ivo_Menu.id_MfAdicional, 1) + &
							 ls_Tipo + ls_Marca + ls_Modelo + &
							 String(ldh_Data_Estoque,'yyyymmdd') + & 
							 String(ldh_Data_Estoque,'hhmmss') ) Then
	gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros E3 Sucesso - GE038-wf_gera_registrose3")			
	Return True
Else
	gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros E3 ERRO - GE038-wf_gera_registrose3")			
	Return False
End If

end function

public function boolean wf_movimento_estoque (date pd_data, long pl_produto, ref long pl_quantidade);


 SELECT COALESCE( SUM( i.qt_vendida ), 0 ) + dbo.uf_saldo_produto_parcial( :pd_data, :pl_produto ) INTO :pl_quantidade
        FROM nf_venda n
            INNER JOIN item_nf_venda i ON i.cd_filial = n.cd_filial AND
        i.nr_nf = n.nr_nf AND
        i.de_especie = n.de_especie AND
        i.de_serie = n.de_serie
        WHERE CAST( n.dh_emissao AS DATE ) >= :pd_data
          AND i.cd_produto = :pl_produto
          AND COALESCE( n.id_cancelamento_impressora, 'N' ) = 'N'
Using Sqlca;

//select sum(qt_movimento) 
//	into :pl_quantidade
//from movimento_estoque
//where dh_movimento >= :pd_data
//  and cd_tipo_movimento = 1
//  and cd_produto = :pl_produto
////  and de_especie = 'CF'
////  and de_serie = 'ECF'
//

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o quantidade mov. estoque.')
	Return False
End If

//Sen$$HEX1$$e300$$ENDHEX$$o achou busca a ultima nota de dia anterior ao atual.
If IsNull(pl_quantidade) Then
	pl_quantidade = 0
End If

Return True
end function

public function boolean wf_gera_registrosj (integer pl_file, ref boolean pl_evidenciado, date pdh_inicial, date pdh_final);Boolean lb_Sucesso
Long ll_ecf
	
gvo_aplicacao.of_grava_log("Registros PAF - Inico Registros J - GE038-wf_gera_registrosj")

If PDV.fabricante <> "NFCE" Then  //Por ECF
	If ivo_Menu.of_pafecf_Registro_J01(pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
		
		If ivo_Menu.of_pafecf_Registro_J02(ll_ecf, pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then				
						
			lb_Sucesso = True
			
		End If
	End If		
Else  //Para NFC-e
	If ivo_Menu.of_pafecf_Registro_nfc_J01(pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then
		
		If ivo_Menu.of_pafecf_Registro_nfc_J02(pdh_inicial, pdh_final, pl_File, Ref pl_Evidenciado) Then				
						
			lb_Sucesso = True
			
		End If
	End If			
End If
//ivo_Menu.ids_arquivo.saveas( 'c:\sistemas\cl\arquivos\ds_registroJ.txt', TEXT!, false )
gvo_aplicacao.of_grava_log("Registros PAF - Termino Registros J - GE038-wf_gera_registrosj")			
Return lb_Sucesso
end function

on w_ge038_menu_fiscal.create
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_diversos=create cb_diversos
this.cb_venda_cpf=create cb_venda_cpf
this.cb_envio_estoque=create cb_envio_estoque
this.cb_envio_reducao=create cb_envio_reducao
this.cb_espelho_mdf=create cb_espelho_mdf
this.cb_registros=create cb_registros
this.cb_arquivo_mf=create cb_arquivo_mf
this.cb_parametros_configuracao=create cb_parametros_configuracao
this.cb_tab_indice_tecnico=create cb_tab_indice_tecnico
this.cb_vendas_periodo=create cb_vendas_periodo
this.cb_sangria=create cb_sangria
this.cb_suprimento=create cb_suprimento
this.cb_sair=create cb_sair
this.dw_1=create dw_1
this.st_msg=create st_msg
this.cb_identifica_pafecf=create cb_identifica_pafecf
this.cb_arquivo_mfd=create cb_arquivo_mfd
this.cb_lmfc_data=create cb_lmfc_data
this.cb_lx=create cb_lx
this.Control[]={this.cb_2,&
this.cb_3,&
this.cb_1,&
this.cb_diversos,&
this.cb_venda_cpf,&
this.cb_envio_estoque,&
this.cb_envio_reducao,&
this.cb_espelho_mdf,&
this.cb_registros,&
this.cb_arquivo_mf,&
this.cb_parametros_configuracao,&
this.cb_tab_indice_tecnico,&
this.cb_vendas_periodo,&
this.cb_sangria,&
this.cb_suprimento,&
this.cb_sair,&
this.dw_1,&
this.st_msg,&
this.cb_identifica_pafecf,&
this.cb_arquivo_mfd,&
this.cb_lmfc_data,&
this.cb_lx}
end on

on w_ge038_menu_fiscal.destroy
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_diversos)
destroy(this.cb_venda_cpf)
destroy(this.cb_envio_estoque)
destroy(this.cb_envio_reducao)
destroy(this.cb_espelho_mdf)
destroy(this.cb_registros)
destroy(this.cb_arquivo_mf)
destroy(this.cb_parametros_configuracao)
destroy(this.cb_tab_indice_tecnico)
destroy(this.cb_vendas_periodo)
destroy(this.cb_sangria)
destroy(this.cb_suprimento)
destroy(this.cb_sair)
destroy(this.dw_1)
destroy(this.st_msg)
destroy(this.cb_identifica_pafecf)
destroy(this.cb_arquivo_mfd)
destroy(this.cb_lmfc_data)
destroy(this.cb_lx)
end on

event close;Destroy(ivo_menu)
end event

event open;Date ldt_Reduzaoz

String ls_Laudo
String ls_Autenticacao_Caixa
String ls_Autenticacao_Retaguarda
String ls_data_laudo

ivo_menu = Create uo_menu_fiscal 

//PDV.of_Modo_Impressora()
ivo_Menu.ivl_Filial  = gvo_parametro.cd_filial

If PDV.Fabricante = "NFCE" And gvo_parametro.ivs_uf_filial = 'SC' Then
	This.cb_identifica_pafecf.text = "&Identifica$$HEX2$$e700e300$$ENDHEX$$o PAF-NFC-e"
	This.cb_registros.text = "Registros do PAF-NFC-e"
End If

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If lvo_Parametro.of_Localiza_Parametro("NR_LAUDO_PAFECF", ref ls_Laudo) Then
	
	If lvo_Parametro.of_Localiza_Parametro("ID_AUTENTICACAO_PAFECF_CL", ref ls_Autenticacao_Caixa) Then
		
		If lvo_Parametro.of_Localiza_Parametro("ID_AUTENTICACAO_PAFECF_RL", ref ls_Autenticacao_Retaguarda) Then
			
			If lvo_Parametro.of_Localiza_Parametro("DH_LAUDO_PAFECF", ref ls_data_Laudo) Then			
		
				//This.ivs_Autenticacao_Caixa		= ls_Autenticacao_Caixa
				This.ivs_MD5							= ls_Autenticacao_Caixa
				This.ivs_Autenticacao_Retaguarda	= ls_Autenticacao_Retaguarda
				This.ivs_Laudo							= ls_Laudo
				This.ivs_data_laudo					= ls_data_laudo
				
			End If		
					
		End If			
		
	End If
	
End If

Destroy(lvo_Parametro)
end event

type cb_2 from commandbutton within w_ge038_menu_fiscal
integer x = 27
integer y = 652
integer width = 818
integer height = 108
integer taborder = 170
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Requisi$$HEX2$$e700f500$$ENDHEX$$es Externas Registradas"
end type

event clicked;If PDV.Fabricante = "NFCE" Then 
	If gvo_parametro.ivs_uf_filial = 'SC' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este PAF-NFC n$$HEX1$$e300$$ENDHEX$$o executa fun$$HEX2$$e700f500$$ENDHEX$$es do Bloco III")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")			
	End If
Else 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este PAF-ECF n$$HEX1$$e300$$ENDHEX$$o executa fun$$HEX2$$e700f500$$ENDHEX$$es do Bloco XI")
End If
end event

type cb_3 from commandbutton within w_ge038_menu_fiscal
integer x = 887
integer y = 648
integer width = 864
integer height = 108
integer taborder = 180
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Transmitir arquivos Requisito XXVI"
end type

event clicked;If PDV.Fabricante = "NFCE" Then 
	If gvo_parametro.ivs_uf_filial = 'SC' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este PAF-NFC n$$HEX1$$e300$$ENDHEX$$o executa fun$$HEX2$$e700f500$$ENDHEX$$es do Bloco XII")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")			
	End If
Else 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este PAF-ECF n$$HEX1$$e300$$ENDHEX$$o executa fun$$HEX2$$e700f500$$ENDHEX$$es do Bloco XII")
End If
end event

type cb_1 from commandbutton within w_ge038_menu_fiscal
boolean visible = false
integer x = 1221
integer y = 780
integer width = 402
integer height = 112
integer taborder = 210
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "none"
end type

event clicked;String ls_file
String ls_caminho
String ls_arquivos[]
String ls_arquivo
Long li_contador

ls_caminho = 'C:\Sistemas\CL\Arquivos\Assinar\'

gf_dir_list( ls_caminho, '*.txt', 0+1, Ref ls_Arquivos )	
	
For li_Contador = 1 To UpperBound( ls_Arquivos )
	ls_Arquivo 		= ls_Arquivos[ li_Contador ]
	ivo_Menu.of_Assinatura_Digital(ls_arquivo)
Next		



end event

type cb_diversos from commandbutton within w_ge038_menu_fiscal
integer x = 1755
integer y = 408
integer width = 800
integer height = 108
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Arquivos ECFs"
end type

event clicked;
Boolean lb_Sucesso

String ls_parametro_inicial
String ls_parametro_final

String ls_tipo
String ls_File
String ls_arquivo
String ls_caminho = 'C:\Sistemas\CL\Arquivos\PAF-ECF\'
String ls_caminho_MFD
String ls_File_temp
String ls_Binario
Long	ll_Geracao

ivs_Parametro.id_periodo	= 'S'
ivs_Parametro.id_coo 		= 'S'
ivs_Parametro.id_reducao 	= 'S'
ivs_Parametro.id_destino 	= 'N'
ivs_Parametro.id_cpf = 'N'

PDV.Of_Modo_Impressora()

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

If Not PDV.of_Numero_Serie() Then Return

OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	wf_cria_diretorio_paf()		
	
	If ivs_Parametro.nr_coo_inicial > 0 Then
		ls_Tipo = 'C'
		ls_Parametro_inicial = String(ivs_Parametro.nr_coo_inicial,'000000')
		ls_Parametro_final   = String(ivs_Parametro.nr_coo_final,'000000')
	Else
		If ivs_Parametro.nr_reducao_inicial > 0 Then
			ls_Tipo = 'Z'
			ls_Parametro_inicial = String(ivs_Parametro.nr_reducao_inicial,'0000')
			ls_Parametro_final   = String(ivs_Parametro.nr_reducao_final,'0000')
		Else		
			ls_Tipo = 'D'
			ls_Parametro_inicial = String(ivs_Parametro.dh_inicial,'ddmmyyyy')
			ls_Parametro_final  = String(ivs_Parametro.dh_final,'ddmmyyyy')
		End If
	End If	
	
	ls_arquivo = PDV.nr_serie + '_' + String(Today(), "yyyymmdd") + '_' + String(Now(), "hhmmss")
	ls_File 		= ls_caminho + ls_arquivo + '.txt'
	ls_Binario 	= ls_caminho + ls_arquivo + '.MFD'	
	ls_File_temp= ls_caminho + ls_arquivo + '_MD5.txt'		

	//GERACAO:  1 = MF  /  2 = MFD  /  3 = TDM ou Cotepe
	ll_Geracao = 3
	
	FileDelete(ls_File)
	FileDelete(ls_Binario)	
	FileDelete(ls_file_temp)		
		
	st_msg.text = 'Gerando Arquivos ECF ...'
	
	Open(w_Janela_Aguarde)
	w_Janela_Aguarde.Wf_Mensagem("N$$HEX1$$c300$$ENDHEX$$O DESLIGUE o PDV/ECF.")	
	Yield( )	
	
	lb_Sucesso = PDV.of_gera_arquivos_ecf(ls_tipo,ls_Parametro_inicial,ls_Parametro_final,ls_File,'',255,ll_Geracao, ls_caminho, Ref ls_caminho_MFD)	
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		String lvs_MD5
		String lvs_registro
		Long lvi_File		
		
//		If ivo_Menu.of_Assinatura_Digital(ls_File) Then
		If FileExists(ls_caminho_MFD) Then
			FileCopy(ls_caminho_MFD,ls_Binario,False)
		End If
		
//		lvi_File = FileOpen(ls_File_temp, LineMode!, Write!, LockWrite!, Replace!)
//	
//		If lvi_File <> - 1 Then				
//			If PDV.of_Capturar_MD5(ls_Binario, Ref lvs_MD5) Then
//				If IsNull(lvs_MD5) Or Trim(lvs_MD5) = "" Then
//					//Return True
//					return
//				End If		
//			
//				lvs_Registro	 = lvs_MD5
//		
//				FileWrite(lvi_File, lvs_Registro)
//			End If			
//		
//			FileClose(lvi_File)
//		End If	
//		//Assinatura digital no arquivo MD5
//		If ivo_Menu.of_Assinatura_Digital(ls_File_temp) Then			
//			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File_temp + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
//				Run('Notepad.exe ' + ls_File_temp )
//			End If			
//		End If
		//Inclui assinatura digital no arquivo gerado pela dll do ECF
		Choose Case PDV.Fabricante
			Case "Bematech"
				//A dll j$$HEX1$$e100$$ENDHEX$$ inclui a chave no arquivo
			Case "Daruma"
				ivo_Menu.of_Assinatura_Digital(ls_File)								
			Case "Epson"				
				ivo_Menu.of_Assinatura_Digital(ls_File)				
			Case Else
				ivo_Menu.of_Assinatura_Digital(ls_File)
		End Choose
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso!", Information!)	
		
		//FileDelete(ls_file)		
		
//		End If
		
	End If
	
	Close(w_Janela_Aguarde)	
End If

wf_limpa_parametros()
end event

type cb_venda_cpf from commandbutton within w_ge038_menu_fiscal
integer x = 27
integer y = 776
integer width = 1001
integer height = 108
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Vendas Identificadas pelo CPF/CNPJ"
end type

event clicked;Date 	ldt_ini, &
		ldt_fim
		
Boolean lb_sucesso = True

String ls_file, &
		ls_Razao_Social, &
		ls_Insc_Estadual, &
		ls_cnpj_desenv, &
		ls_insc_desenv, &
		ls_razao_desenv, &
		ls_versao

Long ll_file

PDV.Of_Modo_Impressora()

If (PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT") And gvo_parametro.ivs_uf_filial <> "SC" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

wf_cria_diretorio_paf()

ivs_Parametro.id_cpf = 'S'
ivs_Parametro.id_periodo = 'N'
ivs_Parametro.id_coo 	 = 'N'
ivs_Parametro.id_destino = 'N'
ivs_Parametro.id_ecf		 = 'N'
ivs_Parametro.id_reducao = 'N'

OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then	
	ldt_ini   = Date(String(ivs_parametro.nr_ano_ini) +'/'+ String(ivs_parametro.nr_mes_ini) +'/01')
	ldt_fim  = gf_retorna_ultimo_dia_mes(ldt_ini)
 
	st_msg.text = 'Gerando Vendas identificadas pelo CPF/CNPJ...'
	
	ls_File = 'c:\sistemas\cl\arquivos\paf-ecf\VENDASIDENTIFICADAS' + String(ivs_parametro.nr_mes_ini,'00') + String(ivs_parametro.nr_ano_ini) + '.txt'
	
	FileDelete(ls_File)

	ll_File = FileOpen(ls_File, LineMode!, Write!, LockWrite!, Append!)	
	
	If ivo_Menu.of_inconsistencia_inclusao_exclusao() Then		
		ls_Razao_Social = gf_Replace(gvo_parametro.nm_razao_social, " ", "?", 0) + FillA("?", 50)
	Else
		ls_Razao_Social = gvo_parametro.nm_razao_social + Space(50)
	End If

	ls_Insc_Estadual = gf_replace(gvo_parametro.nr_inscricao_estadual,'.','',0)	
	
	If Not ivo_Menu.of_grava_registro_temp( 'Z1', '', '', '', 'Z1' + &
								 LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
								 LeftA(ls_Insc_Estadual+Space(14),14) + &
								 Space(14) + &
								 LeftA(ls_Razao_Social, 50)  ) Then
	End If

	
	ls_cnpj_desenv = '84683481000177'	
	ls_insc_desenv = '250330539'
	//Raz$$HEX1$$e300$$ENDHEX$$o Social Matriz - Desenvolvedora
	If ivo_Menu.of_inconsistencia_inclusao_exclusao() Then		
		ls_razao_desenv = LeftA('CIA?LATINO?AMERICANA?DE?MEDICAMENTOS' + FillA("?", 50),50)
	//	pb_evidenciado = True
	Else
		ls_razao_desenv = LeftA('CIA LATINO AMERICANA DE MEDICAMENTOS' + Space(50),500)
	End If
	
	If Not ivo_Menu.of_grava_registro_temp( 'Z2', '', '', '', 'Z2' + &
								 LeftA(ls_cnpj_desenv+Space(14),14) + &
								 LeftA(ls_insc_desenv+Space(14),14) + &
								 Space(14) + &
								 LeftA(ls_Razao_desenv, 50)  ) Then
	End If	
	
	Select nr_versao
	  Into :ls_Versao
	  From sistema
	 Where cd_sistema = 'CL'
	 Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar a vers$$HEX1$$e300$$ENDHEX$$o do sistema.")
		st_msg.text = ''
		Return -1
	End If
	
	If PDV.fabricante = 'NFCE' Then
		If Not ivo_Menu.of_grava_registro_temp( 'Z3', '', '', '', 'Z3' + &
									 LeftA('SISTEMA DE CAIXA'+Space(50),50) + &
									 LeftA(ls_versao+Space(10),10)  ) Then
		End If		
	Else	
		If Not ivo_Menu.of_grava_registro_temp( 'Z3', '', '', '', 'Z3' + &
									 LeftA(ivs_laudo+Space(10),10) + &
									 LeftA('SISTEMA DE CAIXA'+Space(50),50) + &
									 LeftA(ls_versao+Space(10),10)  ) Then
		End If
	End If
	
	If ivo_Menu.of_Gera_Vendas_Identificadas(ldt_ini, ldt_fim, ll_file, ivs_parametro.nr_cpf_cnpj) Then
		lb_Sucesso = True
	End If	
	
	ivo_Menu.of_grava_registro_temp_arquivo( ll_File )	
	
	ivo_Menu.ids_Arquivo.Reset()
	
	FileClose(ll_file)	
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		If ivo_Menu.of_Assinatura_Digital(ls_File) Then
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
				Run('Notepad.exe ' + ls_File )
			End If
		
		End If
		
	End If

End If

wf_limpa_parametros()
end event

type cb_envio_estoque from commandbutton within w_ge038_menu_fiscal
integer x = 887
integer y = 408
integer width = 827
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Envio ao FISCO-ESTOQUE"
end type

event clicked;Boolean lb_bloquear

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

If Trim(ivo_menu.id_envia_blocoX) = 'L' Then
	If ivo_menu.of_verifica_pendencias_blocox('EST', 0, False, True, Ref lb_bloquear,'N') Then
		ivo_menu.of_envia_pendencias_blocox('EST', 0, True)
	End If
Else
	MessageBox("Aviso","Envio de arquivo Bloco X $$HEX1$$e900$$ENDHEX$$ feito na Matriz.",Information!)
End If
end event

type cb_envio_reducao from commandbutton within w_ge038_menu_fiscal
integer x = 27
integer y = 408
integer width = 818
integer height = 108
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar ao FISCO-REDU$$HEX2$$c700c300$$ENDHEX$$O Z"
end type

event clicked;Boolean lb_compactar = True
Boolean lb_bloquear

Long ll_Linhas, ll_Row
Long ll_Filial, ll_Sequencial

Date ldh_movimento

Integer li_nr_ECF
Integer li_Contador

String ls_diretorio_arquivo_local = "C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\FISCO - Local\"

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

If Not DirectoryExists(ls_diretorio_arquivo_local) Then CreateDirectory(ls_diretorio_arquivo_local)

//Atualiza Certificado
//Necess$$HEX1$$e100$$ENDHEX$$rio para assinar os arquivos
Open(w_Aguarde)
w_Aguarde.Title = "Atualizando certificado..."
ivo_Menu.AtualizaCertificado()
Close(w_Aguarde)

ivs_Parametro.id_periodo 	= 'S'
ivs_Parametro.id_ECF	 		= 'S'
ivs_Parametro.id_reducao 	= 'N'
ivs_Parametro.id_destino 	= 'NA' //Desabilitado e setado na opcao Arquivo (A - Arquivo / E - ECF)
ivs_Parametro.id_leitura 		= 'N'
ivs_Parametro.id_cpf	 		= 'N'

OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	wf_cria_diretorio_paf()		
	
	Try
		dc_uo_ds_base lo_reduzao_z
		lo_reduzao_z = Create dc_uo_ds_base
		
		If Not lo_reduzao_z.of_changedataobject( "dw_ge038_pafecf_hist_blocox" ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no evento of_changedataobject")
			Return -1
		End If
		
		If Not IsNull(ivs_Parametro.dh_inicial) Then
			lo_reduzao_z.of_appendwhere( "dh_movimento >= '" +String(ivs_Parametro.dh_inicial, 'yyyy/mm/dd') +"'" )
		End If
		
		If Not IsNull(ivs_Parametro.dh_final) Then
			lo_reduzao_z.of_appendwhere( "dh_movimento <= '" +String(ivs_Parametro.dh_final, 'yyyy/mm/dd') +"'" )
		End If
		
		If ivs_Parametro.nr_ecf_inicial > 0 Then
			lo_reduzao_z.of_appendwhere( "nr_ecf >= " +String(ivs_Parametro.nr_ecf_inicial) )			
		End If
		
		If ivs_Parametro.nr_ecf_final > 0 Then
			lo_reduzao_z.of_appendwhere( "nr_ecf <= " +String(ivs_Parametro.nr_ecf_final) )			
		End If
		
		ll_Linhas = lo_reduzao_z.Retrieve()
		
		If ll_Linhas < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Retrieve.")
			Return -1
		End If
		
		Open(w_aguarde)
		w_aguarde.Title = "Gera XML - Bloco X..."
		w_aguarde.uo_Progress.Of_SetMax(ll_Linhas)
		
		For ll_Row = 1 To ll_Linhas
			
			//Atualiza tela a cada 10 linhas
			If Mod(ll_Row, 10) = 0 Then Yield()
			
			ll_Filial				= lo_reduzao_z.Object.cd_filial					[ll_Row]
			ll_Sequencial		= lo_reduzao_z.Object.nr_sequencial			[ll_Row]
			ldh_Movimento		= Date( lo_reduzao_z.Object.dh_movimento[ll_Row] )
			li_nr_ECF			= lo_reduzao_z.Object.nr_ecf					[ll_Row]
			
			w_aguarde.Title = "Bloco X - Gerando XML "+String(ll_Row) + ' de ' + string(ll_Linhas)+"..."
			w_aguarde.uo_Progress.Of_SetProgress(ll_Row)
						
			If ivo_Menu.of_gera_blocox_reducao( ldh_Movimento, li_nr_ECF, ll_Sequencial, ls_diretorio_arquivo_local) Then
				If ivo_Menu.of_assinar_arquivo( ivo_Menu.ivs_nome_arquivo, ls_diretorio_arquivo_local + ivo_Menu.ivs_nome_arquivo +'.xml' , ls_diretorio_arquivo_local, false) Then
					li_Contador++
				End If
			End If
						
		Next
		
		If li_Contador > 0 Then
			//Mostrar msg do local onde os arquivos foram salvos
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivos gerados com sucesso.~rDir.: " + ls_diretorio_arquivo_local + "~r~rDeseja abrir o local dos arquivos?", Question!, YesNO!, 2) = 1 Then
				gf_Run("explorer " +ls_diretorio_arquivo_local)
			End If
		End if
	
	Catch (RuntimeError lvo_Erro)
		SQLCa.Of_Rollback()
		MessageBox("Erro", lvo_Erro.GetMessage())
			
	Finally
		If IsNull(lo_reduzao_z) Then Destroy lo_reduzao_z
		If IsValid(w_aguarde) Then Close(w_aguarde) 
	End Try
		
End If
end event

type cb_espelho_mdf from commandbutton within w_ge038_menu_fiscal
integer x = 1755
integer y = 152
integer width = 800
integer height = 112
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Espelho MFD"
end type

event clicked;
Boolean lb_Sucesso

String ls_Parametro_Inicial
String ls_Parametro_Final
String ls_Tipo

String ls_File = 'C:\Sistemas\CL\Arquivos\PAF-ECF\leitura-memoria-fita-detalhe.txt'

PDV.Of_Modo_Impressora()

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

wf_cria_diretorio_paf()

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_coo 	 = 'S'
ivs_Parametro.id_destino = 'N'
ivs_Parametro.id_ecf		 = 'N'
ivs_Parametro.id_reducao = 'N'
ivs_Parametro.id_cpf = 'N'

OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo ser$$HEX1$$e100$$ENDHEX$$ gerado no modelo padr$$HEX1$$e300$$ENDHEX$$o.")	
	st_msg.text = 'Gerando Leitura Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal Completa - Espelho MFD...'
	
	If ivs_Parametro.nr_coo_inicial > 0 Then

		lb_Sucesso = PDV.of_leitura_memoria_fita_detalhe('2',String(ivs_Parametro.nr_coo_inicial,'000000'),String(ivs_Parametro.nr_coo_final,'000000'))			
	
	Else
		
		lb_Sucesso = PDV.of_leitura_memoria_fita_detalhe('1',String(ivs_Parametro.dh_inicial,'dd/mm/yyyy'),String(ivs_Parametro.dh_final,'dd/mm/yyyy'))
	
	End If
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		If ivo_Menu.of_Assinatura_Digital(ls_File) Then
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
				Run('Notepad.exe ' + ls_File )
			End If
		
		End If
		
	End If	
	
End If	

wf_limpa_parametros()
end event

type cb_registros from commandbutton within w_ge038_menu_fiscal
integer x = 1755
integer y = 280
integer width = 800
integer height = 108
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Registros do &PAF"
end type

event clicked;Boolean 	lb_Sucesso
Boolean	lb_Evidenciado = False

Long		ll_Indice
Long 		ll_ECF
Long		ll_File
Long		ll_Row

String 	ls_Relatorio[]
String		ls_Razao_Social
String		ls_Tipo
String		ls_Marca
String		ls_Modelo
String		ls_Insc_Estadual
String		ls_File
String 	ls_Arquivo_Evidenciado

DateTime	ldh_Data_Estoque

ivs_Parametro.id_periodo	= 'S'

PDV.of_modo_impressora()

If (PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT") And gvo_parametro.ivs_uf_filial <> "SC" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

Destroy(ivds_produto)

OpenWithParm(w_ge038_registros_paf,ivds_produto)

ivds_produto = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then

	st_msg.text = 'Gerando Arquivo de Registros PAF ...'	
	
	gvo_aplicacao.of_grava_log("Inicio Gera$$HEX2$$e700e300$$ENDHEX$$o Registros PAF - GE038 - Registros PAF")		
	
	wf_cria_diretorio_paf()
	
	If PDV.fabricante <> "NFCE" Then  //Por ECF
	
		ivo_Menu.of_busca_ecf_primeira_venda(Ref ll_ECF)
		If IsNull(ll_ecf) or ll_ecf <= 0 Then
			ll_ECF = PDV.ECF
		End If
		
		//SE PRECISAR PARA VENDAS DEPOIS DAS 00:00 HRS
		//BUSCAR ATRAVES DO MAPA RESUMO A DATA/HORA emissao da redu$$HEX2$$e700e300$$ENDHEX$$o Z 
		//e usar como data/hora final. 
	
		If Not ivo_Menu.of_Carrega_dados_ecf(ll_ECF) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados da ECF.",StopSign!)
			lb_Sucesso = False
			Return
		End If
		
		If ivs_Parametro.dh_inicial = ivs_Parametro.dh_final Then
			ls_File = 'c:\sistemas\cl\arquivos\paf-ecf\' + LeftA(ivo_Menu.cd_identificacao_nacional,6) + RightA(ivo_Menu.nr_Serie_MFD,20) + String(ivs_Parametro.dh_inicial,'ddmmyyyy') + '.txt'
		Else	
			ls_File = 'c:\sistemas\cl\arquivos\paf-ecf\' + LeftA(ivo_Menu.cd_identificacao_nacional,6) + RightA(ivo_Menu.nr_Serie_MFD,20) + String(gf_GetServerDate(),'ddmmyyyy') + '.txt'
		End If		
		
		FileDelete(ls_File)		
	
		If Not ivo_Menu.of_data_primeira_venda(REf ldh_Data_Estoque, ll_ecf) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel buscar primeira venda do ECF.",StopSign!)
			lb_Sucesso = False
			Return
		Else
			If IsNull(ldh_Data_Estoque) Or String(ldh_Data_Estoque,'ddmmyyyy') = '01011900' Then
				ldh_Data_Estoque = gf_GetServerDate()
			End If
		End If		
	
		If ivo_Menu.of_inconsistencia_inclusao_exclusao() Then		
			ls_Razao_Social = gf_Replace(gvo_parametro.nm_razao_social, " ", "?", 0) + FillA("?", 50)
		Else
			ls_Razao_Social = gvo_parametro.nm_razao_social + Space(50)
		End If
	
		If IsNull(ldh_Data_Estoque) Then
		//	ldh_Data_Estoque = ()
		End If
	Else //POR NFC-E
		ls_Razao_Social = gvo_parametro.nm_razao_social + Space(50)
		
		If ivs_Parametro.dh_inicial = ivs_Parametro.dh_final Then
			ls_File = 'c:\sistemas\cl\arquivos\paf-ecf\' + gvo_parametro.nr_cgc + '_' + String(ivs_Parametro.dh_inicial,'ddmmyyyy') + '.txt'
		Else	
			ls_File = 'c:\sistemas\cl\arquivos\paf-ecf\' + gvo_parametro.nr_cgc + '_' + String(gf_GetServerDate(),'ddmmyyyy') + '.txt'
		End If	
		
		FileDelete(ls_File)		
		
	End If
	
	ll_File = FileOpen(ls_File, LineMode!, Write!, LockWrite!, Append!)	
	
	ls_Insc_Estadual = gf_replace(gvo_parametro.nr_inscricao_estadual,'.','',0)
	
	If Not ivo_Menu.of_grava_registro_temp( 'U1', '', '', '', 'U1' + &
								 LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
								 LeftA(ls_Insc_Estadual+Space(14),14) + &
								 Space(14) + &
								 LeftA(ls_Razao_Social, 50)  ) Then
	End If
	
	//Registro A2 - Meios Pagamento
	gvo_aplicacao.of_grava_log("Registros PAF - Vai chamar a fun$$HEX2$$e700e300$$ENDHEX$$o of_gera_meios_pagamento - Registros PAF")		
	If ivo_Menu.of_gera_meios_pagamento(ivs_Parametro.dh_inicial, ivs_Parametro.dh_final, ll_File, Ref lb_Evidenciado) Then
		//Registo P2 - Produtos
		If wf_Gera_Produto_Estoque(ll_File, Ref lb_Evidenciado) Then		
			//Registo E2 - Saldo
			If wf_Gera_Estoque_Saldo(ll_File, Ref lb_Evidenciado) Then		
				If PDV.fabricante <> "NFCE" Then  //Por ECF				
					//Registro E3 - ECFs
					If wf_gera_registoE3(ll_File, Ref lb_Evidenciado, ll_ecf) Then
						//Registro Rs
						If wf_gera_registrosR(ll_File, Ref lb_Evidenciado,ivs_Parametro.dh_inicial,ivs_Parametro.dh_final) Then
							//Registros Js
							If wf_gera_registrosJ(ll_File, Ref lb_Evidenciado,ivs_Parametro.dh_inicial,ivs_Parametro.dh_final) Then
								lb_Sucesso = True	
							End If				
						End If
					End If
				Else // Para NFC-e
					//Registros Js NFC
					If wf_gera_registrosJ(ll_File, Ref lb_Evidenciado,ivs_Parametro.dh_inicial,ivs_Parametro.dh_final) Then
						lb_Sucesso = True	
					End If				
				End If				
			End If			
		End If
	End If								 

	st_msg.text = ''
	
	gvo_aplicacao.of_grava_log("T$$HEX1$$e900$$ENDHEX$$rmino Gera$$HEX2$$e700e300$$ENDHEX$$o Registros PAF - Vai assinar o arquivo. - GE038 - Registros PAF")			
	
	ivo_Menu.of_grava_registro_temp_arquivo( ll_File )	
	
	ivo_Menu.ids_Arquivo.Reset()
	
	FileClose(ll_File)	
	
	If lb_Evidenciado Then
//		ls_Arquivo_Evidenciado = MidA(ls_File, 1, LenA(ls_File) - 4) + "_evid.txt"
		ls_Arquivo_Evidenciado = MidA(ls_File, 1, LenA(ls_File) - 4) + "_evid_" + String(Today(),"DDMMYYhhmmss") + ".txt"		
		If ivo_Menu.of_Renomeia_Arquivo(ls_File, ls_Arquivo_Evidenciado, True) Then	
			ls_File = ls_Arquivo_Evidenciado
		Else
			lb_Sucesso = False
		End If
	End If 	
	
	If lb_Sucesso Then		
		If ivo_Menu.of_Assinatura_Digital(ls_File) Then		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
				Run('Notepad.exe ' + ls_File )
			End If		
		End If		
	End If	
End If

wf_limpa_parametros()

end event

type cb_arquivo_mf from commandbutton within w_ge038_menu_fiscal
integer x = 1755
integer y = 28
integer width = 800
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Ar&q. MF"
end type

event clicked;
Boolean lb_Sucesso

String ls_parametro_inicial
String ls_parametro_final

String ls_tipo
String ls_File
String ls_File_temp
String ls_Binario
String ls_caminho = 'C:\Sistemas\CL\Arquivos\PAF-ECF\'
String ls_caminho_MFD
String ls_arquivo
Long	ll_Geracao  //0 = MF   -   1 = MFD   -   2 = TDM  	-	3 = RZ	-   4 = RFD

ivs_Parametro.id_periodo	= 'S'
ivs_Parametro.id_coo 		= 'S'
ivs_Parametro.id_reducao 	= 'S'
ivs_Parametro.id_destino 	= 'N'
ivs_Parametro.id_leitura	 	= 'N'
ivs_Parametro.id_cpf = 'N'

PDV.Of_Modo_Impressora()

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

If Not PDV.of_Numero_Serie() Then Return

OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	wf_cria_diretorio_paf()		
	
	If ivs_Parametro.nr_coo_inicial > 0 Then
		ls_Tipo = 'C'
		ls_Parametro_inicial = String(ivs_Parametro.nr_coo_inicial,'000000')
		ls_Parametro_final   = String(ivs_Parametro.nr_coo_final,'000000')
	Else
		If ivs_Parametro.nr_reducao_inicial > 0 Then
			ls_Tipo = 'Z'
			ls_Parametro_inicial = String(ivs_Parametro.nr_reducao_inicial,'0000')
			ls_Parametro_final   = String(ivs_Parametro.nr_reducao_final,'0000')
		Else		
			ls_Tipo = 'D'
			ls_Parametro_inicial = String(ivs_Parametro.dh_inicial,'ddmmyyyy')
			ls_Parametro_final  = String(ivs_Parametro.dh_final,'ddmmyyyy')
		End If
	End If	
	
	ls_arquivo = 'MF' + PDV.nr_serie + '_' + String(Today(), "yyyymmdd") + '_' + String(Now(), "hhmmss")
	ls_File 		= ls_caminho + ls_arquivo + '_ECF.txt'
	ls_Binario 	= ls_caminho + ls_arquivo + '.MFD'	
	ls_File_temp= ls_caminho + ls_arquivo + '.txt'		
	ll_Geracao = 0
	
	FileDelete(ls_File)
	FileDelete(ls_Binario)
	FileDelete(ls_file_temp)	
		
	st_msg.text = 'Gerando Arquivo MF ...'
	
	lb_Sucesso = PDV.of_gera_arquivo_mfd(ls_tipo,ls_Parametro_inicial,ls_Parametro_final,ls_file,'',ll_Geracao, Ref ls_caminho_MFD)	
	
	st_msg.text = ''
	
	If lb_Sucesso Then		
		String lvs_MD5
		String lvs_registro
		Long lvi_File
		
		If FileExists(ls_caminho_MFD) Then
			FileCopy(ls_caminho_MFD,ls_Binario,False)
		End If		
		
		lvi_File = FileOpen(ls_File_temp, LineMode!, Write!, LockWrite!, Replace!)
	
		If lvi_File <> - 1 Then				
			If PDV.of_Capturar_MD5(ls_Binario, Ref lvs_MD5) Then
				If IsNull(lvs_MD5) Or Trim(lvs_MD5) = "" Then
					//Return True
					return
				End If		
			
				lvs_Registro	 = lvs_MD5
		
				FileWrite(lvi_File, lvs_Registro)
			End If			
		
			FileClose(lvi_File)
		End If	
		
		If ivo_Menu.of_Assinatura_Digital(ls_File_temp) Then
			
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File_temp + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
				Run('Notepad.exe ' + ls_File_temp )
			End If	
		
		End If
		Choose Case PDV.Fabricante
			Case "Bematech"
				//A dll j$$HEX1$$e100$$ENDHEX$$ inclui a chave no arquivo
			Case "Daruma"
			Case "Epson"				
				ivo_Menu.of_Assinatura_Digital(ls_File)				
			Case Else
				ivo_Menu.of_Assinatura_Digital(ls_File)
		End Choose		
		
//		FileDelete(ls_file)
		
	End If
	
End If

wf_limpa_parametros()
end event

type cb_parametros_configuracao from commandbutton within w_ge038_menu_fiscal
integer x = 887
integer y = 280
integer width = 827
integer height = 108
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Par$$HEX1$$e200$$ENDHEX$$metros de &Configura$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;
Boolean 	lb_Sucesso

Long		ll_Indice

String 	ls_Relatorio[]

DateTime ldt_data_hora

PDV.Of_Modo_Impressora()

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

ll_Indice = 1	

ls_Relatorio[ll_Indice] = 'Todas as parametriza$$HEX2$$e700f500$$ENDHEX$$es relacionadas neste relat$$HEX1$$f300$$ENDHEX$$rio s$$HEX1$$e300$$ENDHEX$$o de ' +&
								  'configura$$HEX2$$e700e300$$ENDHEX$$o inacess$$HEX1$$ed00$$ENDHEX$$vel ao usu$$HEX1$$e100$$ENDHEX$$rio do PAF-ECF. A ativa$$HEX2$$e700e300$$ENDHEX$$o ' +&
								  'ou n$$HEX1$$e300$$ENDHEX$$o destes par$$HEX1$$e200$$ENDHEX$$metros $$HEX1$$e900$$ENDHEX$$ determinada pela unidade federada e ' +&
								  'somente pode ser feita pela interven$$HEX2$$e700e300$$ENDHEX$$o da empresa desenvolvedora do PAF-ECF.'
ll_Indice++
ls_Relatorio[ll_Indice] = ''
ll_Indice++

ls_Relatorio[ll_Indice] = 'Perfil de Requisitos'
ll_Indice++
ls_Relatorio[ll_Indice] = 'V'
ll_Indice++

ls_Relatorio[ll_Indice] = 'Tipo de funcionamento'
ll_Indice++
//ls_Relatorio[ll_Indice] = '(REQUISITO III - Item 1)'
//ll_Indice++
ls_Relatorio[ll_Indice] = 'Em Rede'
ll_Indice++
ls_Relatorio[ll_Indice] = 'Tipo de Desenvolvimento'
ll_Indice++
ls_Relatorio[ll_Indice] = 'Exclusivo-Pr$$HEX1$$f300$$ENDHEX$$prio'
ll_Indice++
//ls_Relatorio[ll_Indice] = 'Emiss$$HEX1$$e300$$ENDHEX$$o de DAV-OS para oficina de conserto'
//ll_Indice++
//ls_Relatorio[ll_Indice] = '(REQUISITO IV - Item 1)'
//ll_Indice++
//ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
//ll_Indice++	
ls_Relatorio[ll_Indice] = 'Realiza registros de Pr$$HEX1$$e900$$ENDHEX$$-Venda'
ll_Indice++
ls_Relatorio[ll_Indice] = '(REQUISITO IV - Item 2)'
ll_Indice++
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'Emiss$$HEX1$$e300$$ENDHEX$$o de DAV '
ll_Indice++
ls_Relatorio[ll_Indice] = '(REQUISITO IV - Item 3)'
ll_Indice++
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'Realiza registro de Conta de Cliente'
ll_Indice++
ls_Relatorio[ll_Indice] = '(REQUISITO IV - Item 5)'
ll_Indice++
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++				
ls_Relatorio[ll_Indice] = 'CRIT$$HEX1$$c900$$ENDHEX$$RIOS POR UNIDADE FEDERADA'
ll_Indice++				
ls_Relatorio[ll_Indice] = 'Emiss$$HEX1$$e300$$ENDHEX$$o de documento fiscal por PED:'
ll_Indice++
ls_Relatorio[ll_Indice] = '(REQUISITO XVII - Item 1)'
ll_Indice++
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'Tela para consulta de pre$$HEX1$$e700$$ENDHEX$$o permite:'
ll_Indice++
ls_Relatorio[ll_Indice] = '(REQUISITO XVIII)'
ll_Indice++
ls_Relatorio[ll_Indice] = 'a) Totaliza$$HEX2$$e700e300$$ENDHEX$$o dos valores da lista de itens'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'b) Transforma$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es digitadas em registro de pr$$HEX1$$e900$$ENDHEX$$-venda'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'c) A utiliza$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es digitadas para impress$$HEX1$$e300$$ENDHEX$$o de DAV'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'Executa recomposi$$HEX2$$e700e300$$ENDHEX$$o de GT:'
ll_Indice++
ls_Relatorio[ll_Indice] = '(REQUISITO XXII - Item 7)'
ll_Indice++
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++
ls_Relatorio[ll_Indice] = '(REQUISITO VIII-A Iitem 2)'
ll_Indice++
ls_Relatorio[ll_Indice] = 'Minas Legal'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'a) Cupom Mania'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'b) Notal Legal'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'c) Paraiba Legal'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++
ls_Relatorio[ll_Indice] = '(REQUISITO XIV)'
ll_Indice++
ls_Relatorio[ll_Indice] = 'Troco em Cart$$HEX1$$e300$$ENDHEX$$o'
ll_Indice++	
ls_Relatorio[ll_Indice] = 'N$$HEX1$$e300$$ENDHEX$$o'
	
PDV.of_emite_comprovante('01',ls_Relatorio,000.00)
end event

type cb_tab_indice_tecnico from commandbutton within w_ge038_menu_fiscal
integer x = 27
integer y = 284
integer width = 818
integer height = 108
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Tab. $$HEX1$$cd00$$ENDHEX$$nd. T$$HEX1$$e900$$ENDHEX$$cnico Produ$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este PAF-ECF n$$HEX1$$e300$$ENDHEX$$o executa fun$$HEX2$$e700f500$$ENDHEX$$es de baixa de estoque " + &
			  "com base em $$HEX1$$ed00$$ENDHEX$$ndices t$$HEX1$$e900$$ENDHEX$$cnicos de produ$$HEX2$$e700e300$$ENDHEX$$o, n$$HEX1$$e300$$ENDHEX$$o podendo ser utilizado por " + &
			  "estabelecimento que necessite deste recurso.")
end event

type cb_vendas_periodo from commandbutton within w_ge038_menu_fiscal
boolean visible = false
integer x = 1755
integer y = 76
integer width = 800
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo"
end type

event clicked;
Boolean lb_Sucesso

String ls_Parametro_Inicial
String ls_Parametro_Final
String ls_Tipo
String ls_File

Long ll_ecf

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_coo 	 = 'N'
ivs_Parametro.id_destino = 'M'
ivs_Parametro.id_cpf = 'N'

PDV.of_modo_impressora()

//Pegar numero da ECF quando estiver desligada
If IsNull(PDV.ecf) Or PDV.ecf = 0 Then
	ll_ecf = PDV.of_ecf_caixa()
Else
	ll_ecf = PDV.ecf
End If

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	wf_cria_diretorio_paf()		
	 
	If ivs_Parametro.id_Modelo_Arquivo = 'cv5795' Then
		st_msg.text = 'Gerando Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo (Conv$$HEX1$$ea00$$ENDHEX$$nio 57/95)...'
		If ivo_Menu.of_Gera_Vendas_Periodo(Ref ls_File, ivs_Parametro.dh_inicial,ivs_Parametro.dh_final, True, ll_ecf) Then
			lb_Sucesso = True
		End If
	ElseIf ivs_Parametro.id_Modelo_Arquivo = 'ac0908' Then
		st_msg.text = 'Gerando Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo (Ato Cotepe 09/08)...'
		If ivo_Menu.of_Gera_Vendas_Periodo(Ref ls_File, ivs_Parametro.dh_inicial,ivs_Parametro.dh_final, False, ll_ecf) Then
			lb_Sucesso = True
		End If		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esse modelo de arquivo escolhido n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel para essa fun$$HEX2$$e700e300$$ENDHEX$$o.")
		lb_Sucesso = False
	End If
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		If ivo_Menu.of_Assinatura_Digital(ls_File) Then
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
				Run('Notepad.exe ' + ls_File )
			End If
		
		End If
		
	End If
	
End If	

wf_limpa_parametros()
end event

type cb_sangria from commandbutton within w_ge038_menu_fiscal
integer x = 887
integer y = 528
integer width = 827
integer height = 108
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "San&gria"
end type

event clicked;
Boolean 	lb_Sucesso

String 	ls_Valor
String 	ls_Titulo

PDV.Of_Modo_Impressora()

If Not pdv.of_verifica_problemas_impressora() Then Return

ls_Titulo = "Informe o valor da Sangria"

OpenWithParm(w_ge038_coleta_campo_numerico,ls_Titulo)

ls_Valor = Message.StringParm

If ls_Valor = "CANCELAR" Then Return

st_msg.text = 'Registrando Sangria na ECF ...'

lb_Sucesso = PDV.of_Sangria_Caixa(Dec(ls_Valor))

st_msg.text = ''

end event

type cb_suprimento from commandbutton within w_ge038_menu_fiscal
integer x = 27
integer y = 528
integer width = 818
integer height = 108
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Suprimento"
end type

event clicked;
Boolean 	lb_Sucesso

String 	ls_Valor
String 	ls_Titulo

PDV.Of_Modo_Impressora()

If Not pdv.of_verifica_problemas_impressora() Then Return

ls_Titulo = "Informe o valor do suprimento"

OpenWithParm(w_ge038_coleta_campo_numerico,ls_Titulo)

ls_Valor = Message.StringParm

If ls_Valor = "CANCELAR" Then Return

st_msg.text = 'Registrando Suprimento na ECF ...'

lb_Sucesso = PDV.of_Suprimento_Caixa(Dec(ls_Valor))

st_msg.text = ''

end event

type cb_sair from commandbutton within w_ge038_menu_fiscal
integer x = 1755
integer y = 776
integer width = 800
integer height = 108
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sai&r"
end type

event clicked;Close(Parent)
end event

type dw_1 from dc_uo_dw_base within w_ge038_menu_fiscal
boolean visible = false
integer x = 133
integer y = 336
integer width = 1143
integer height = 708
integer taborder = 160
string dataobject = "dw_ge038_pafecf_estoque"
end type

type st_msg from statictext within w_ge038_menu_fiscal
integer x = 27
integer y = 904
integer width = 2469
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type cb_identifica_pafecf from commandbutton within w_ge038_menu_fiscal
integer x = 887
integer y = 152
integer width = 827
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Identifica$$HEX2$$e700e300$$ENDHEX$$o PAF-ECF"
end type

event clicked;Boolean	lb_Sucesso

String	ls_Relatorio[]

String	ls_Laudo
String	ls_Arquivos[]
String	ls_MD5
String	lvs_Versao

Long		ll_Idx = 1
Long		ll_Linha

PDV.Of_Modo_Impressora()

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	If gvo_parametro.ivs_uf_filial <> 'SC' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
		Return
	Else
		//Abre tela paf nfc
		Open(w_ge038_identificacao_paf_nfc)
		Return 0
	End If
End If

st_msg.text = 'Imprimindo Identifica$$HEX2$$e700e300$$ENDHEX$$o do PAF-ECF ...'

// Localiza$$HEX2$$e700e300$$ENDHEX$$o da Vers$$HEX1$$e300$$ENDHEX$$o do Sistema ----------------------------------------- //
Select nr_versao
  Into :lvs_Versao
  From sistema
 Where cd_sistema = 'CL'
 Using SQLCa;

If SQLCa.SQLCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar a vers$$HEX1$$e300$$ENDHEX$$o do sistema.")
	st_msg.text = ''
	Return -1
End If
//--------------------------------------------------------------------------- //

//If Not PDV.of_numero_serie() Then Return -- retirado, faz em todas as ecfs na funcao abreporta

ls_Relatorio[ll_Idx]  = space(50)
ll_Idx++
ls_Relatorio[ll_Idx]  = "      I D E N T I F I C A C A O    D O    P A F - E C F" + CharA(13) + CharA(10)
ll_Idx++
ls_Relatorio[ll_Idx]  = space(50)
ll_Idx++
ls_Relatorio[ll_Idx]  = "NR LAUDO : " + ivs_Laudo
ll_Idx++
ls_Relatorio[ll_Idx]  = "DATA EMISS$$HEX1$$c300$$ENDHEX$$O LAUDO : " + ivs_data_Laudo
ll_Idx++
ls_Relatorio[ll_Idx]  = space(50)
ll_Idx++
ls_Relatorio[ll_Idx]  = "DESENVOLVEDOR : 84.683.481/0001-77"
ll_Idx++
ls_Relatorio[ll_Idx]  = "                CIA LATINO AMERICANA DE MEDICAMENTOS"
ll_Idx++
ls_Relatorio[ll_Idx]  = space(50)
ll_Idx++
ls_Relatorio[ll_Idx]  = "RUA NOVE DE MARCO 638 - CENTRO - CEP: 89.201-400"
ll_Idx++
ls_Relatorio[ll_Idx]  = "JOINVILLE - SANTA CATARINA"
ll_Idx++
ls_Relatorio[ll_Idx]  = "FONE: (47) 3461-9994 FAX: (47) 3461-9959 " + CharA(13) + CharA(10)
ll_Idx++
ls_Relatorio[ll_Idx] = "CONTATO: ADMOCIR SANTANA SILVA"
ll_Idx++
ls_Relatorio[ll_Idx] = "         admocir.silva@clamed.com.br"
ll_Idx++
ls_Relatorio[ll_Idx] =  space(50)
ll_Idx++
ls_Relatorio[ll_Idx] = "SOFTWARE: SISTEMA DE CAIXA"
ll_Idx++
ls_Relatorio[ll_Idx] = "VERSAO " + lvs_Versao + CharA(13) + CharA(10)
ll_Idx++
ls_Relatorio[ll_Idx] = "VERSAO da ER-PAF-ECF: 02.06" + CharA(13) + CharA(10)
ll_Idx++

gf_dir_list("C:\Sistemas\CL\ExeMD5\", '*.*', 0+1, ref ls_Arquivos)

ls_Relatorio[ll_Idx] = "Nome do EXE principal: cl.exe"
ll_Idx++

If PDV.of_Capturar_MD5("C:\Sistemas\CL\ExeMD5\cl.exe", Ref ls_MD5) Then
	ls_Relatorio[ll_Idx] = "MD5 do EXE principal: " + ls_MD5 + CharA(13) + CharA(10)
	ll_Idx++
	ls_MD5 = ""
End If

ls_Relatorio[ll_Idx] = "Arquivo de autentica$$HEX2$$e700e300$$ENDHEX$$o:" 
ll_Idx++
ls_Relatorio[ll_Idx] = "listaMD5.txt " + ivs_MD5 + CharA(13) + CharA(10)
ll_Idx++

ls_Relatorio[ll_Idx] = "Lista dos arquivos autenticados:"
ll_Idx++

For ll_Linha = 1 To UpperBound(ls_Arquivos)
	//If ls_Arquivos[ll_Linha] <> "cl.exe" Then
		If PDV.of_Capturar_MD5("C:\Sistemas\CL\ExeMD5\" + ls_Arquivos[ll_Linha], Ref ls_MD5) Then
			ls_Relatorio[ll_Idx] = ls_Arquivos[ll_Linha] + " " + ls_MD5
			ll_Idx++
			ls_MD5 = ""
		End If
	//End If 
Next

ls_Relatorio[ll_Idx] = "ECF AUTORIZADA NUMERO DE S$$HEX1$$c900$$ENDHEX$$RIE"
ll_Idx++
ls_Relatorio[ll_Idx] = PDV.nr_serie
ll_Idx++
		
lb_Sucesso = PDV.of_emite_comprovante('01',ls_Relatorio,000.00)

st_msg.text = ''

wf_limpa_parametros()
end event

type cb_arquivo_mfd from commandbutton within w_ge038_menu_fiscal
integer x = 27
integer y = 152
integer width = 818
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Arq. MFD"
end type

event clicked;
Boolean lb_Sucesso

String ls_parametro_inicial
String ls_parametro_final

String ls_tipo
String ls_File
String ls_arquivo
String ls_caminho = 'C:\Sistemas\CL\Arquivos\PAF-ECF\'
String ls_caminho_MFD
String ls_File_temp
String ls_Binario
Long	ll_Geracao  //0 = MF   e   1 = MFD

ivs_Parametro.id_periodo	= 'S'
ivs_Parametro.id_coo 		= 'S'
ivs_Parametro.id_reducao 	= 'S'
ivs_Parametro.id_destino 	= 'N'
ivs_Parametro.id_cpf = 'N'

PDV.Of_Modo_Impressora()

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

If Not PDV.of_Numero_Serie() Then Return

OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	wf_cria_diretorio_paf()		
	
	If ivs_Parametro.nr_coo_inicial > 0 Then
		ls_Tipo = 'C'
		ls_Parametro_inicial = String(ivs_Parametro.nr_coo_inicial,'000000')
		ls_Parametro_final   = String(ivs_Parametro.nr_coo_final,'000000')
	Else
		If ivs_Parametro.nr_reducao_inicial > 0 Then
			ls_Tipo = 'Z'
			ls_Parametro_inicial = String(ivs_Parametro.nr_reducao_inicial,'0000')
			ls_Parametro_final   = String(ivs_Parametro.nr_reducao_final,'0000')
		Else		
			ls_Tipo = 'D'
			ls_Parametro_inicial = String(ivs_Parametro.dh_inicial,'ddmmyyyy')
			ls_Parametro_final  = String(ivs_Parametro.dh_final,'ddmmyyyy')
		End If
	End If	
	
	ls_arquivo = 'MFD' + PDV.nr_serie + '_' + String(Today(), "yyyymmdd") + '_' + String(Now(), "hhmmss")
	ls_File 		= ls_caminho + ls_arquivo + '_ECF.txt'
	ls_Binario 	= ls_caminho + ls_arquivo + '.MFD'	
	ls_File_temp= ls_caminho + ls_arquivo + '.txt'		
	
	ll_Geracao = 1
	
	FileDelete(ls_File)
	FileDelete(ls_Binario)	
	FileDelete(ls_file_temp)		
		
	st_msg.text = 'Gerando Arquivo MFD ...'
	
	lb_Sucesso = PDV.of_gera_arquivo_mfd(ls_tipo,ls_Parametro_inicial,ls_Parametro_final,ls_file,'',ll_Geracao, ref ls_caminho_MFD)
		
	st_msg.text = ''
	
	If lb_Sucesso Then
		String lvs_MD5
		String lvs_registro
		Long lvi_File		
		
//		If ivo_Menu.of_Assinatura_Digital(ls_File) Then
		If FileExists(ls_caminho_MFD) Then
			FileCopy(ls_caminho_MFD,ls_Binario,False)
		End If
		
		lvi_File = FileOpen(ls_File_temp, LineMode!, Write!, LockWrite!, Replace!)
	
		If lvi_File <> - 1 Then				
			If PDV.of_Capturar_MD5(ls_Binario, Ref lvs_MD5) Then
				If IsNull(lvs_MD5) Or Trim(lvs_MD5) = "" Then
					//Return True
					return
				End If		
			
				lvs_Registro	 = lvs_MD5
		
				FileWrite(lvi_File, lvs_Registro)
			End If			
		
			FileClose(lvi_File)
		End If	
		//Assinatura digital no arquivo MD5
		If ivo_Menu.of_Assinatura_Digital(ls_File_temp) Then			
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File_temp + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
				Run('Notepad.exe ' + ls_File_temp )
			End If			
		End If
		//Inclui assinatura digital no arquivo gerado pela dll do ECF
		Choose Case PDV.Fabricante
			Case "Bematech"
				//A dll j$$HEX1$$e100$$ENDHEX$$ inclui a chave no arquivo
			Case "Daruma"
			Case "Epson"				
				ivo_Menu.of_Assinatura_Digital(ls_File)				
			Case Else
				ivo_Menu.of_Assinatura_Digital(ls_File)
		End Choose
		
		//FileDelete(ls_file)		
		
//		End If
		
	End If
	
End If

wf_limpa_parametros()
end event

type cb_lmfc_data from commandbutton within w_ge038_menu_fiscal
integer x = 887
integer y = 28
integer width = 827
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&LMF"
end type

event clicked;Boolean 	lb_Sucesso

String	ls_File
String	ls_Retorno
String ls_Tipo
String ls_Periodo

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_reducao = 'S'
ivs_Parametro.id_destino = 'N'
ivs_Parametro.id_leitura = 'S'
ivs_Parametro.id_cpf = 'N'

PDV.Of_Modo_Impressora()

If PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	wf_cria_diretorio_paf()		

	If Not PDV.of_Numero_Serie() Then Return
	
	If ivs_Parametro.id_Modelo_Arquivo = '' Then
		ls_Tipo = 'S'
	Else
		ls_Tipo = 'C'
	End If
	
	If Not IsNull(ivs_Parametro.nr_reducao_inicial) And ivs_Parametro.nr_reducao_inicial > 0 Then
		ls_Periodo = 'R'
	Else
		ls_Periodo = 'D'
	End If
	
	st_msg.text = 'Emitindo Leitura da Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal...'	
	
	If ls_Periodo = 'D' Then
		lb_Sucesso = PDV.of_leitura_memoria_fiscal(String(ivs_Parametro.dh_inicial,'dd/mm/yyyy'),String(ivs_Parametro.dh_final,'dd/mm/yyyy'),ivs_Parametro.id_Arquivo,ls_Tipo)
	Else
		lb_Sucesso = PDV.of_leitura_memoria_fiscal_reducao(ivs_Parametro.nr_reducao_inicial,ivs_Parametro.nr_reducao_final,ivs_Parametro.id_Arquivo,ls_Tipo)
	End If
	
	If lb_sucesso Then
		PDV.of_registra_documento_ecf( 'MF','' ,0 )		
	End If
	
	st_msg.text = ''	
End If

wf_limpa_parametros()
end event

type cb_lx from commandbutton within w_ge038_menu_fiscal
integer x = 27
integer y = 28
integer width = 818
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "LX"
end type

event clicked;Boolean 	lb_Sucesso

String 	ls_File = 'C:\Sistemas\CL\Arquivos\PAF-ECF\leiturax.txt'

ivs_Parametro.id_destino = 'S'

PDV.Of_Modo_Impressora()

If (PDV.Fabricante = "NFCE" Or PDV.Fabricante = "SAT")  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "PDV configurado para NFC-e/SAT. Funcionalidade indispon$$HEX1$$ed00$$ENDHEX$$vel!.")	
	Return
End If

st_msg.text = 'Emitindo Leitura X ...'

lb_Sucesso = PDV.of_leiturax(False)	

st_msg.text = ""

//OpenWithParm(w_ge038_parametro_pafecf,ivs_Parametro)
//
//ivs_Parametro = Message.PowerObjectParm
//
//If ivs_Parametro.id_Retorno = 'OK' Then
//	
//	st_msg.text = 'Emitindo Leitura X ...'
//	
//	lb_Sucesso = PDV.of_leiturax(ivs_Parametro.id_Arquivo)	
//	
//	st_msg.text = ''
//	
//	If ivs_Parametro.id_Arquivo And lb_Sucesso Then
//		
//		dc_uo_Api lvo_Api
//		lvo_Api = Create dc_uo_Api
//		
//		If lvo_Api.of_Move_File('c:\retorno.txt',ls_File,True) Then
//		
//			If ivo_menu.of_Assinatura_Digital(ls_File) Then
//			
//				If ivs_Parametro.id_Arquivo Then
//							
//					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
//						Run('Notepad.exe ' + ls_File )
//					End If	
//					
//				End If	
//				
//			End If	
//			
//		End If
//		
//		Destroy lvo_Api
//		
//	End If	
//	
//	st_msg.text = ""
//	
//End If





end event

