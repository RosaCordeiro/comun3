HA$PBExportHeader$uo_pedido_central_edi.sru
forward
global type uo_pedido_central_edi from nonvisualobject
end type
end forward

global type uo_pedido_central_edi from nonvisualobject
end type
global uo_pedido_central_edi uo_pedido_central_edi

type variables
Boolean ib_Pedido_Automatico = False //Quando o pedido da FEMSA $$HEX1$$e900$$ENDHEX$$ enviado autom$$HEX1$$e100$$ENDHEX$$ticamente pela RO034

Date idt_Emissao
Date idt_Faturamento

Decimal idc_Desconto

LongLong il_Pedido_Clamed
Long il_Filial

String is_Tipo_Pedido
String is_CNPJ_CIA
String is_Razao_Social_CIA
String is_Endereco_CIA
String is_Bairro_CIA
String is_Cidade_CIA
String is_UF_CIA
String is_CEP_CIA
String is_CNPJ_FOR
String is_Transportadora
String is_Inscricao_Estadual
String is_Condicao_Pgto
String is_De_Van
String is_Obs_Pedido
String ivs_cgc_envio
String ivs_nome_arquivo
String is_Id_Utiliza_Ftp
String is_De_Endereco_Ftp
String is_De_Usuario_Ftp
String is_De_Senha_Ftp
String is_De_Diretorio_Envio
String is_Erro
String is_Distribuidora
String is_OPENTEXTSFTP = "C:\Sistemas\Co\Arquivos\OPENTEXTSFTP\"


dc_uo_ds_base ids_Pedido
end variables

forward prototypes
public function boolean of_grava_registro (integer ai_arquivo, string as_registro)
public function string of_string (string as_string, integer ai_tamanho)
public function string of_decimal (decimal adc_decimal, integer ai_tamanho)
public function string of_number (long al_numero, integer ai_tamanho)
public function string of_data (datetime adt_data)
public function boolean of_localiza_codigo_barras (long al_produto, ref string as_codigo_barras)
public subroutine of_gera_arquivo (long al_pedido)
public function boolean of_atualiza_data_envio (long al_pedido)
public function boolean of_consulta_pedido (long al_pedido, ref datetime adt_emissao, ref string as_condicao_pgto, ref string as_cgc, ref string as_razao_social, ref string as_endereco, ref string as_bairro, ref string as_cidade, ref string as_uf, ref string as_cep, ref string as_cgc_fornecedor, ref string as_transportadora, ref decimal adc_desconto, ref string as_inscricao_estadual, ref datetime adt_faturamento, string as_pbm)
public function boolean of_layout_bayer_frete (integer ai_arquivo, ref string as_erro)
public function boolean of_layout_bayer_cabecalho_ped (integer ai_arquivo, ref string as_erro)
public function boolean of_layout_bayer_finalizador (integer ai_arquivo, ref string as_erro)
public function boolean of_proximo_sequencial (ref long al_sequencial, string as_edi)
public function boolean of_atualiza_ultimo_sequencial (long al_sequencial, string as_edi)
public function boolean of_consulta_pedido (long al_pedido, string as_pbm, ref string as_erro)
public function boolean of_layout_bayer_cabecalho (integer ai_arquivo, ref string as_erro)
public function boolean of_gera_registro_cabecalho (integer ai_arquivo, string as_edi, long al_pedido, string as_pbm, long al_sequencial, string as_cnpj_forn, ref string as_erro)
public function boolean of_layout_padrao_cabecalho (integer ai_arquivo, long al_sequencial, string as_cnpj_pedido, string as_cnpj_fornecedor, boolean ab_ims)
public function boolean of_layout_padrao_cabecalho_pedido (integer ai_arquivo, ref string as_tipo_pedido, long al_pedido, string as_pbm, boolean ab_ims)
public function boolean of_layout_padrao_condicao_pgto (integer ai_arquivo, long al_pedido, string as_tipo_pedido, boolean ab_ims)
public function boolean of_layout_padrao_produto (integer ai_arquivo, long al_pedido, boolean ab_ims)
public function boolean of_gera_registro_cabecalho_pedido (integer ai_arquivo, string as_edi, long al_pedido, string as_pbm, ref string as_tipo_pedido, ref string as_erro)
public function boolean of_gera_registro_condicao (integer ai_arquivo, string as_edi, long al_pedido, string as_tipo_pedido, ref string as_erro)
public function boolean of_gera_registro_produto (integer ai_arquivo, string as_edi, long al_pedido, ref string as_erro)
public function boolean of_layout_bayer_produto (integer ai_arquivo, ref string as_erro)
public function boolean of_layout_focopdv_cabecalho (integer ai_arquivo, ref string as_erro)
public function boolean of_layout_focopdv_produto (integer ai_arquivo, ref string as_erro)
public function boolean of_abre_arquivo (ref integer ai_arquivo, ref long al_sequencial, ref string as_path, ref string as_nome_arquivo, string as_laboratorio, string as_edi, string as_de_van, string as_cgc_fornecedor)
public function boolean of_consulta_pedido_distribuidora (long al_pedido, ref datetime adt_emissao, ref string as_condicao_pgto, ref string as_cgc, ref string as_razao_social, ref string as_endereco, ref string as_bairro, ref string as_cidade, ref string as_uf, ref string as_cep, ref string as_cgc_fornecedor, ref string as_transportadora, ref decimal adc_desconto, ref string as_inscricao_estadual, ref datetime adt_faturamento, string as_pbm)
public function boolean of_fornecedor_conexao (ref string as_fornecedor_conexao)
public function boolean of_grava_arquivo_pedido_automatico (long al_filial, long al_pedido, ref string as_arquivo, ref string as_erro)
public function boolean of_retorna_gln_neogrid (ref string as_gln)
end prototypes

public function boolean of_grava_registro (integer ai_arquivo, string as_registro);If FileWrite(ai_arquivo, as_Registro) = -1  Then
	If Not ib_Pedido_Automatico Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao grava os dados no arquivo de pedido.")
	Else
		is_Erro = "Erro ao grava os dados no arquivo de pedido."
	End If
	
	Return False
End If

Return True
end function

public function string of_string (string as_string, integer ai_tamanho);String lvs_String

//lvs_Retorno = Left(as_Informacao + Space(500), ai_Tamanho)

lvs_String = LeftA(as_String, ai_Tamanho) + Space(ai_Tamanho - LenA(as_String))

Return lvs_String
end function

public function string of_decimal (decimal adc_decimal, integer ai_tamanho);String lvs_Valor, lvs_String, lvs_Retorno

Integer lvi_Pos

// Converte para string
lvs_String = String(adc_Decimal)

lvi_Pos = PosA(lvs_String, ",")

// Tira a ","
lvs_Valor	= LeftA(lvs_String, lvi_Pos - 1) + MidA(lvs_String, lvi_Pos + 1)

// Alinha a direita e preenche a esquerda com zeros
lvs_Retorno = FillA("0", ai_Tamanho - LenA(lvs_Valor)) + lvs_Valor

Return lvs_Retorno



end function

public function string of_number (long al_numero, integer ai_tamanho);String lvs_Valor, lvs_String

// Converte para string
lvs_Valor = String(al_Numero)

// Alinha a direita e preenche a esquerda com zeros
lvs_String = FillA("0", ai_Tamanho - LenA(lvs_Valor)) + lvs_Valor

Return lvs_String



end function

public function string of_data (datetime adt_data);String lvs_Data

lvs_Data = String(Year(Date(adt_Data)), '0000') + String(Month(Date(adt_Data)), "00") +&
   	  	   String(Day(Date(adt_Data)), "00")
				
Return lvs_Data

end function

public function boolean of_localiza_codigo_barras (long al_produto, ref string as_codigo_barras);Select de_codigo_barras
Into :as_Codigo_Barras
From codigo_barras_produto
Where cd_produto 	=:al_Produto
  and id_principal 		= 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		If Not ib_Pedido_Automatico Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo de barras principal do produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Else
			is_Erro =  "O c$$HEX1$$f300$$ENDHEX$$digo de barras principal do produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		End If
		
		Return False
		
	Case -1
		If Not ib_Pedido_Automatico Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do codigo de barras do produto '" + String(al_Produto) + "'")
		Else
			is_Erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do codigo de barras do produto '" + String(al_Produto) + "'"
		End If
		
		Return False
End Choose

Return True
end function

public subroutine of_gera_arquivo (long al_pedido);//Boolean lvb_Sucesso = False
//
//Integer lvi_Arquivo
//
//Long lvl_Sequencial
//
//String lvs_Tipo_Pedido,&
//	   lvs_Arquivo
//
//If Not This.of_Abre_Arquivo(Ref lvi_Arquivo, Ref lvl_Sequencial, Ref lvs_Arquivo) Then Return
//
//If This.of_Registro_Cabecalho(al_Pedido, lvi_Arquivo, lvl_Sequencial) Then
//	If This.of_Registro_Cabecalho_Pedido(lvi_Arquivo, al_Pedido, Ref lvs_Tipo_Pedido) Then
//		If This.of_Registro_Condicao_Pgto(lvi_Arquivo, al_Pedido, lvs_Tipo_Pedido) Then
//			If This.of_Registro_Produto(lvi_Arquivo, al_Pedido) Then
//				If This.of_Atualiza_Ultimo_Sequencial(lvl_Sequencial) Then
//					lvb_Sucesso = True
//				End If
//			End If
//		End If
//	End If
//End If
//
//FileClose(lvi_Arquivo)
//
//If lvb_Sucesso Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo de pedido EDI foi gerado com sucesso")
//Else
//	// Se der algum erro durante a gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo o sistema vai excluir o arquivo
//	FileDelete(lvs_Arquivo)
//End If
end subroutine

public function boolean of_atualiza_data_envio (long al_pedido);Update pedido_central
Set dh_envio_edi = getdate()
Where nr_pedido = :al_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de envio do pedido '" + String(al_Pedido) + "'")
	Return False
End If

Return True
end function

public function boolean of_consulta_pedido (long al_pedido, ref datetime adt_emissao, ref string as_condicao_pgto, ref string as_cgc, ref string as_razao_social, ref string as_endereco, ref string as_bairro, ref string as_cidade, ref string as_uf, ref string as_cep, ref string as_cgc_fornecedor, ref string as_transportadora, ref decimal adc_desconto, ref string as_inscricao_estadual, ref datetime adt_faturamento, string as_pbm);Long lvl_Condicao_Pgto,&
	 lvl_Filial
	 
DateTime lvdt_Cancelamento

Select p.dh_pedido, 
	   p.cd_condicao_pagamento,
	   p.cd_filial,
	   f.nr_cgc,
	   f.nm_razao_social,
	   f.de_endereco,
	   f.de_bairro,
	   c.nm_cidade,
	   c.cd_unidade_federacao,
	   f.nr_cep,
	   fo.nr_cgc,
	   p.de_transportadora,
	   p.pc_desconto,
	   p.dh_cancelamento,
	   f.nr_inscricao_estadual,
	   p.dh_previsao_entrega
Into :adt_Emissao, 
	 :lvl_Condicao_Pgto,
	 :lvl_Filial,
	 :as_CGC,
	 :as_Razao_Social,
	 :as_Endereco,
	 :as_Bairro,
	 :as_Cidade,
	 :as_UF,
	 :as_CEP,
	 :as_CGC_Fornecedor,
	 :as_Transportadora,
	 :adc_Desconto,
	 :lvdt_Cancelamento,
	 :as_Inscricao_Estadual,
	 :adt_Faturamento
From pedido_central p, filial f, cidade c, fornecedor fo
Where p.nr_pedido 		= :al_Pedido
  and f.cd_filial		= p.cd_filial
  and c.cd_cidade		= f.cd_cidade
  and fo.cd_fornecedor	= p.cd_fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		// Tira a m$$HEX1$$e100$$ENDHEX$$scara
		as_Inscricao_Estadual = gf_Tira_Mascara_Inscricao_Estadual(as_Inscricao_Estadual)
		
		If lvl_Filial <> 534 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O envio do pedido so $$HEX1$$e900$$ENDHEX$$ permitido para o ESTOQUE CENTRAL.")
			Return False
		End If
		
		If Not IsNull(lvdt_Cancelamento) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido foi em '" + String(lvdt_Cancelamento, "dd/mm/yyyy") + " e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser enviado pelo EDI.", StopSign!)
			Return False
		End If
		
		If as_pbm = 'S' Then
			// Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM
			as_Condicao_Pgto = "007"
		Else
			// Verifica se a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento 
			If lvl_Condicao_Pgto = 50 Then
				// Pedido Bonificado
				as_Condicao_Pgto = "002"
			Else
				// Pedido Normal
				as_Condicao_Pgto = "001"
			End If
		End If
		
		If IsNull(as_Transportadora) Then 
			as_Transportadora = ""
		Else
			as_Transportadora = MidA(as_Transportadora, 1, 3)
			
			If as_Transportadora <> "CIF" and as_Transportadora <> "FOB" Then
				as_Transportadora = ""
			End If
		End If
	
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar os dados do pedido.")
		Return False
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do pedido")
		Return False
End Choose

Return True
end function

public function boolean of_layout_bayer_frete (integer ai_arquivo, ref string as_erro);String ls_Tipo
String ls_Registro
	   
ls_Tipo 				= "03"

ls_Registro = 	ls_Tipo + "CIF" + Space(15) + "000" + Space(77)
								
If LenA(ls_Registro) = 100 Then
	If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then
		Return False
	End If
Else
	as_erro = "Layout Bayer: Tamanho do registro condi$$HEX2$$e700e300$$ENDHEX$$o pagamento inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(ls_Registro)) + "'."
	Return False
End If

Return True
end function

public function boolean of_layout_bayer_cabecalho_ped (integer ai_arquivo, ref string as_erro);String ls_Tipo
String ls_Registro

Integer li_zero
	   
ls_Tipo 				= "02"
li_zero				= 0

ls_Registro = 	ls_Tipo + Space(3) + of_Number( li_zero, 29 ) + Space(3) +  of_Number( li_zero, 18 ) + Space(45)
								
If LenA(ls_Registro) = 100 Then
	If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then
		Return False
	End If
Else
	as_erro = "Layout Bayer: Tamanho do registro cabe$$HEX1$$e700$$ENDHEX$$alho pedido inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(ls_Registro)) + "'."
	Return False
End If

Return True
end function

public function boolean of_layout_bayer_finalizador (integer ai_arquivo, ref string as_erro);String ls_Tipo
String ls_Registro
Integer li_zero
	   
ls_Tipo 				= "09"
li_zero				= 0

ls_Registro = 	ls_Tipo + of_Number( li_zero, 44 ) + Space(104)
								
If LenA(ls_Registro) = 150 Then
	If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then
		Return False
	End If
Else
	as_erro = "Layout Bayer: Tamanho do registro finalizador inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(ls_Registro)) + "'."
	Return False
End If

Return True
end function

public function boolean of_proximo_sequencial (ref long al_sequencial, string as_edi);String lvs_Sequencial
String lvs_Parametro

//Choose Case as_EDI
//	Case 'I' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_IMS'	
//	Case 'N' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_NEOGRID'	
//	Case 'T' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_EDI'
//	Case 'O' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_EDI_OPENTEXT'
//	Case 'M'
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_EDI_MANUAL'
//	Case 'E' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_ENTIRE'	
//End Choose

lvs_Parametro = 'NR_ULTIMO_ARQUIVO_EDI_VAN'

Select vl_parametro
Into :lvs_Sequencial
From parametro_geral
Where cd_parametro = :lvs_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		
		If Not IsNull(lvs_Sequencial) Then
			If IsNumber(lvs_Sequencial) Then
				al_Sequencial = Long(lvs_Sequencial) + 1
				Return True
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O sequencial $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido '" + lvs_Sequencial + "'.")
			End If
		Else
			al_Sequencial = 1
			Return True
		End If
	
	Case 100
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O "+lvs_Parametro+" n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela par$$HEX1$$e200$$ENDHEX$$metro geral.")
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo sequencial do arquivo.")
End Choose

Return False
end function

public function boolean of_atualiza_ultimo_sequencial (long al_sequencial, string as_edi);String lvs_Sequencial
String lvs_Parametro

//Choose Case as_EDI
//	Case 'I' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_IMS'	
//	Case 'T' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_EDI'
//	Case 'O' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_EDI_OPENTEXT'
//	Case 'M' 	
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_EDI_MANUAL'
//	Case 'E'
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_ENTIRE'
//	Case 'N'
//		lvs_Parametro = 'NR_ULTIMO_ARQUIVO_NEOGRID'	
//End Choose

lvs_Parametro = 'NR_ULTIMO_ARQUIVO_EDI_VAN'

lvs_Sequencial = String(al_Sequencial)

Update parametro_geral
Set vl_parametro = :lvs_Sequencial
From parametro_geral
Where cd_parametro = :lvs_Parametro
Using SqlCa;

If SqlCa.SqlCode  = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial do $$HEX1$$fa00$$ENDHEX$$ltimo arquivo na tabela PARAMETRO_GERAL.")
	Return False
End If

Return True
end function

public function boolean of_consulta_pedido (long al_pedido, string as_pbm, ref string as_erro);Long ll_Condicao_Pgto, ll_Filial
	 
DateTime ldt_Cancelamento

Select cast(coalesce(nr_pedido_sap, cast(nr_pedido as varchar(15))) as bigint), 
		p.dh_pedido, 
	   p.cd_condicao_pagamento,
	   p.cd_filial,
	   f.nr_cgc,
	   f.nm_razao_social,
	   f.de_endereco,
	   f.de_bairro,
	   c.nm_cidade,
	   c.cd_unidade_federacao,
	   f.nr_cep,
	   fo.nr_cgc,
	   IsNull(p.de_transportadora, ''),
	   p.pc_desconto,
	   p.dh_cancelamento,
	   f.nr_inscricao_estadual,
	   p.dh_previsao_entrega,
	   Coalesce(p.de_observacao, '')
Into :il_Pedido_Clamed, 
	:idt_Emissao, 
	 :ll_Condicao_Pgto,
	 :ll_Filial,
	 :is_CNPJ_CIA,
	 :is_Razao_Social_CIA,
	 :is_Endereco_CIA,
	 :is_Bairro_CIA,
	 :is_Cidade_CIA,
	 :is_UF_CIA,
	 :is_CEP_CIA,
	 :is_CNPJ_FOR,
	 :is_Transportadora,
	 :idc_Desconto,
	 :ldt_Cancelamento,
	 :is_Inscricao_Estadual,
	 :idt_Faturamento,
	 :is_Obs_Pedido
From pedido_central p 	inner join filial f 			on f.cd_filial 			= p.cd_filial  
								inner join cidade c 		on c.cd_cidade			= f.cd_cidade
								inner join fornecedor fo 	on fo.cd_fornecedor	= p.cd_fornecedor 
Where p.nr_pedido 		= :al_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		// Tira a m$$HEX1$$e100$$ENDHEX$$scara
		is_Inscricao_Estadual = gf_Tira_Mascara_Inscricao_Estadual(is_Inscricao_Estadual)
		
		If ll_Filial <> 534 Then
			as_erro = "O envio do pedido s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ permitido para o ESTOQUE CENTRAL."
			Return False
		End If
		
		If Not IsNull(ldt_Cancelamento) Then
			as_erro = "O pedido foi cancelado em '" + String(ldt_Cancelamento, "dd/mm/yyyy") + " e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser enviado pelo EDI."
			Return False
		End If
		
		If as_pbm = 'S' Then
			// Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM
			is_Condicao_Pgto = "007"
		Else
			// Verifica se a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento 
			If ll_Condicao_Pgto = 50 Then
				// Pedido Bonificado
				is_Condicao_Pgto = "002"
			Else
				// Pedido Normal
				is_Condicao_Pgto = "001"
			End If
		End If
		
		If MidA(is_Transportadora, 1, 3) <> "CIF" and MidA(is_Transportadora, 1, 3) <> "FOB" Then
			is_Transportadora = ""
		End If
	
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar os dados do pedido: " + String( al_pedido )
		Return False
	Case -1 
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do pedido: " + + String( al_pedido ) + " . " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_layout_bayer_cabecalho (integer ai_arquivo, ref string as_erro);String ls_Tipo, ls_Mensagem
String ls_Pedido_cliente
String ls_Registro
String ls_EAN_FORN
String ls_Cod_Local 
Integer li_zero
	   
ls_Tipo 				= "01"
ls_Mensagem		= "ORDERS"
ls_Pedido_cliente	= String(il_pedido_clamed) + "    " 
li_zero				= 0
ls_EAN_FORN		= "7891106000000"



// NESTLE: Aguardando devido ao Layout.
//If is_CNPJ_FOR = '60409075000152'  Or   is_CNPJ_FOR = '60409075010034'  Or    is_CNPJ_FOR = '60409075054082'   Then 
//	ls_Cod_Local = '7898918966012' // Novo GLN do CD
//End If 

ls_Registro = 	ls_Tipo + ls_Mensagem + of_String( ls_Pedido_cliente, 20 ) + Space(3) + String(idt_Emissao, "YYYYMMDD") + &
					 of_Number( li_zero, 28 ) + "001" + of_Number( li_zero, 33 ) + of_String( is_CNPJ_CIA, 15) + ls_EAN_FORN + of_String( is_CNPJ_FOR, 15 ) + &
					 of_Number( li_zero, 13 ) + of_String( is_CNPJ_CIA, 15) + of_Number( li_zero, 51) + Space(10) + "0000" + Space(22) + &
					 of_String( String(il_pedido_clamed), 20 ) +  String(idt_Emissao, "YYYYMMDD") + Space(111)
					 
				
If LenA(ls_Registro) = 400 Then
	If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then
		Return False
	End If
Else
	as_erro = "Layout Bayer: Tamanho do registro cabe$$HEX1$$e700$$ENDHEX$$alho inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(ls_Registro)) + "'."
	Return False
End If

Return True
end function

public function boolean of_gera_registro_cabecalho (integer ai_arquivo, string as_edi, long al_pedido, string as_pbm, long al_sequencial, string as_cnpj_forn, ref string as_erro);Boolean lb_Retorno, lb_IMS

as_erro = ""

lb_IMS = (as_EDI = "I" Or as_Edi = "M")

If Not ib_Pedido_Automatico Then
	If Not This.of_Consulta_Pedido( al_Pedido, as_pbm, Ref as_erro ) Then Return False
End If

Choose Case as_EDI
	Case 'O' //OpenText - Layout Bayer		
		lb_Retorno = This.of_Layout_Bayer_Cabecalho( ai_arquivo, Ref as_erro )
		
	Case 'F' //Foco PDV
		lb_Retorno = This.of_Layout_focopdv_Cabecalho( ai_arquivo, Ref as_erro )
		
	Case Else //Layout Tivit e IMS
		lb_Retorno = This.of_Layout_Padrao_Cabecalho(ai_Arquivo, al_Sequencial, is_CNPJ_CIA, as_cnpj_forn, lb_IMS)
		
End Choose

Return lb_Retorno
end function

public function boolean of_layout_padrao_cabecalho (integer ai_arquivo, long al_sequencial, string as_cnpj_pedido, string as_cnpj_fornecedor, boolean ab_ims);String lvs_Tipo,&
	   lvs_Identificacao,&
	   lvs_Registro,&
	   lvs_Filler
	   
lvs_Tipo 				= "00"
lvs_Identificacao	= "ORDERS" + String(Day(Today()), "00") + String(Month(Today()), "00") + String(al_Sequencial, "0000")
lvs_Filler				= ""

//Alterar o CNPJ da linha 00 do arquivo de pedido Novo Nordisk (chamado 718706)
If as_CNPJ_Fornecedor = '82277955000740' Then
	as_CNPJ_Fornecedor = '82277955000155'
End If

//Alterar o CNPJ da linha 00 do arquivo de pedido Cristalia (chamado 437165)
// Chamado 1205850
If (as_CNPJ_Fornecedor = '44734671000151'  or as_CNPJ_Fornecedor = '44734671002529')  Then
	as_CNPJ_Fornecedor = '44734671000402'
End If


//Alterar o CNPJ pelo c$$HEX1$$f300$$ENDHEX$$digo de caixa postal quando o fornecedor $$HEX1$$e900$$ENDHEX$$ Hypera
If as_CNPJ_Fornecedor = '02932074004260' Then
	as_CNPJ_Fornecedor = '7896090122707'
End If

//Alterar o CNPJ pelo c$$HEX1$$f300$$ENDHEX$$digo de caixa postal quando o fornecedor $$HEX1$$e900$$ENDHEX$$ Novartis
If as_CNPJ_Fornecedor = '56994502002779' Then
	as_CNPJ_Fornecedor = '56994502009862'
End If

lvs_Registro = 	lvs_Tipo + of_String(lvs_Identificacao, 14) +&
				of_String(as_CNPJ_Pedido, 35) + of_String(as_CNPJ_Fornecedor, 35) 
				
If ab_Ims Then
	lvs_Registro = lvs_Registro + Of_String(lvs_Filler, 364)
	
	If LenA(lvs_Registro) = 450 Then
		If Not of_Grava_Registro(ai_Arquivo, lvs_Registro) Then
			Return False
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro cabe$$HEX1$$e700$$ENDHEX$$alho inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'.", StopSign!)
		Return False
	End If
Else
	lvs_Registro = lvs_Registro + Of_String(lvs_Filler, 414)
	
	If LenA(lvs_Registro) = 500 Then
		If Not of_Grava_Registro(ai_Arquivo, lvs_Registro) Then
			Return False
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro cabe$$HEX1$$e700$$ENDHEX$$alho inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'.", StopSign!)
		Return False
	End If
End If
				
Return True
end function

public function boolean of_layout_padrao_cabecalho_pedido (integer ai_arquivo, ref string as_tipo_pedido, long al_pedido, string as_pbm, boolean ab_ims);String lvs_Tipo_Registro, lvs_Pedido, lvs_Registro, lvs_Filler, lvs_Tipo_Pedido2, lvs_Tipo_Mercadoria, lvs_Desconto, lvs_Contrato, ls_Cod_Local
	   
String lvs_CGC_CIA, lvs_Razao_Social_CIA, lvs_Endereco_CIA,&
	   lvs_Bairro_CIA, lvs_Cidade_CIA, lvs_UF_CIA, lvs_CEP_CIA, lvs_CGC_FOR, lvs_Transportadora,&
	   lvs_Data_Emissao, lvs_Inscricao_Estadual, lvs_Data_Faturamento

Decimal lvdc_Desconto
	   
DateTime lvdt_Emissao, lvdt_Faturamento

Integer lvi_Len

If Not ib_Pedido_Automatico Then
	If Not of_Consulta_Pedido(	al_Pedido, Ref lvdt_Emissao, Ref as_Tipo_Pedido, Ref lvs_CGC_CIA,&
								Ref lvs_Razao_Social_CIA, Ref lvs_Endereco_CIA, Ref lvs_Bairro_CIA, &
								Ref lvs_Cidade_CIA, Ref lvs_UF_CIA, Ref lvs_CEP_CIA, Ref lvs_CGC_FOR,&
								Ref lvs_Transportadora, Ref lvdc_Desconto, Ref lvs_Inscricao_Estadual,&
								Ref lvdt_Faturamento, as_pbm) Then Return False
	
Else
	
	If Not of_Consulta_Pedido_Distribuidora(	al_Pedido, Ref lvdt_Emissao, Ref as_Tipo_Pedido, Ref lvs_CGC_CIA,&
							Ref lvs_Razao_Social_CIA, Ref lvs_Endereco_CIA, Ref lvs_Bairro_CIA, &
							Ref lvs_Cidade_CIA, Ref lvs_UF_CIA, Ref lvs_CEP_CIA, Ref lvs_CGC_FOR,&
							Ref lvs_Transportadora, Ref lvdc_Desconto, Ref lvs_Inscricao_Estadual,&
							Ref lvdt_Faturamento, as_pbm) Then Return False
End If

lvs_Filler		 	= ""

lvs_Tipo_Registro 			= "01"
lvs_Pedido					= of_String(String(il_Pedido_Clamed), 15)
lvs_Data_Emissao 			= Of_Data(lvdt_Emissao)
lvs_CGC_CIA				= Of_String(lvs_CGC_CIA, 14)
lvs_Razao_Social_CIA		= Of_String(lvs_Razao_Social_CIA, 35)
lvs_Endereco_CIA			= Of_String(lvs_Endereco_CIA, 35)
lvs_Bairro_CIA				= Of_String(lvs_Bairro_CIA, 35)
lvs_Cidade_CIA				= Of_String(lvs_Cidade_CIA, 35)
lvs_UF_CIA					= Of_String(lvs_UF_CIA, 2)
lvs_CEP_CIA					= Of_String(lvs_CEP_CIA, 9)
lvs_Inscricao_Estadual 	= Of_String(lvs_Inscricao_Estadual, 20)
lvs_CGC_FOR				= Of_String(lvs_CGC_FOR, 14)
lvs_Transportadora		= Of_String(lvs_Transportadora, 3)
lvs_Desconto				= Of_Decimal(lvdc_Desconto, 10)
lvs_Tipo_Mercadoria 		= "001"	// Revenda
lvs_Contrato					= Of_String(lvs_CGC_CIA, 25)
lvs_Tipo_Pedido2			= "220"	// Pedido Normal
lvs_Data_Faturamento	= Of_Data(lvdt_Faturamento)

If ab_ims Then
	
	is_Tipo_Pedido = as_Tipo_Pedido
	
	lvs_Registro = 	lvs_Tipo_Registro + lvs_Pedido +  lvs_Data_Faturamento + lvs_Data_Faturamento + lvs_Data_Faturamento + lvs_Data_Emissao +&
					as_Tipo_Pedido + Of_String(lvs_Filler, 20) + Of_String(lvs_Filler, 13) + lvs_CGC_CIA +&
					Of_String(lvs_Filler, 13) + lvs_Razao_Social_CIA + lvs_Endereco_CIA + lvs_Bairro_CIA +&
					lvs_Cidade_CIA + lvs_UF_CIA + lvs_CEP_CIA + lvs_CGC_CIA + lvs_Inscricao_Estadual +&
					Of_String(lvs_Filler, 13) + lvs_CGC_CIA + Of_String(lvs_Filler, 13) + lvs_CGC_FOR +&
					lvs_Transportadora + lvs_Desconto + Of_Number(0, 18) + lvs_Tipo_Mercadoria + lvs_Contrato +&
					lvs_Tipo_Pedido2 + Of_String(lvs_Filler, 37) 
					
	If LenA(lvs_Registro) = 450 Then
		If Not of_Grava_Registro(ai_Arquivo, lvs_Registro) Then
			Return False
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro cabe$$HEX1$$e700$$ENDHEX$$alho do pedido inv$$HEX1$$e100$$ENDHEX$$lido '" +&
					String(LenA(lvs_Registro)) + "'.", StopSign!)
		Return False
	End If
	
Else
	
	// Neogrid -> Como n$$HEX1$$e300$$ENDHEX$$o possuiamos o c$$HEX1$$f300$$ENDHEX$$digo na GS1 eles geraram um c$$HEX1$$f300$$ENDHEX$$digo que dever$$HEX1$$e100$$ENDHEX$$ ser fixado no pedido LOCAL COMPRADOR / LOCAL ENTREGA.
	If as_pbm = 'N' Then
		If Not ib_Pedido_Automatico Then
			ls_Cod_Local = '8468348101995' //GLN do Estoque Central
		Else
			If Not This.of_Retorna_GLN_Neogrid(Ref ls_Cod_Local) Then Return False
		End If
	
	Else
		ls_Cod_Local = Of_String(lvs_Filler, 13)
	End If
	
	// NESTLE
	///If lvs_CGC_FOR = '60409075000152'  Or   lvs_CGC_FOR = '60409075010034'  Or    lvs_CGC_FOR = '60409075054082'   Then 
	///		ls_Cod_Local = '7898918966012' // Novo GLN do CD
	///End If 
	
	//Hypermacas - data de entrega solicitada
	If lvs_CGC_FOR = '02932074004260' Or lvs_CGC_FOR = '02932074005665' Or lvs_CGC_FOR = '54516661003623' Then
		
		lvs_Registro = 	lvs_Tipo_Registro + lvs_Pedido +  lvs_Data_Faturamento  + lvs_Data_Faturamento + lvs_Data_Emissao + lvs_Data_Emissao +&
					as_Tipo_Pedido + Of_String(lvs_Filler, 20) + Of_String(lvs_Filler, 13) + lvs_CGC_CIA +&
					Of_String(lvs_Filler, 13) + lvs_Razao_Social_CIA + lvs_Endereco_CIA + lvs_Bairro_CIA +&
					lvs_Cidade_CIA + lvs_UF_CIA + lvs_CEP_CIA + lvs_CGC_CIA + lvs_Inscricao_Estadual +&
					Of_String(lvs_Filler, 13) + lvs_CGC_CIA + Of_String(lvs_Filler, 13) + lvs_CGC_FOR +&
					lvs_Transportadora + lvs_Desconto + Of_Number(0, 18) + lvs_Tipo_Mercadoria + lvs_Contrato +&
					lvs_Tipo_Pedido2 + lvs_CGC_CIA + lvs_Data_Faturamento + Of_Number(0, 5) + Of_Number(0, 18) +&
					Of_Number(0, 8) + Of_String(lvs_Filler, 156) + Of_String(lvs_Filler, 3) 
	Else
		
		lvs_Registro = 	lvs_Tipo_Registro + lvs_Pedido +  "00000000" + "00000000" + "00000000" + lvs_Data_Emissao +&
					as_Tipo_Pedido + Of_String(lvs_Filler, 20) + ls_Cod_Local + lvs_CGC_CIA +&
					ls_Cod_Local + lvs_Razao_Social_CIA + lvs_Endereco_CIA + lvs_Bairro_CIA +&
					lvs_Cidade_CIA + lvs_UF_CIA + lvs_CEP_CIA + lvs_CGC_CIA + lvs_Inscricao_Estadual +&
					ls_Cod_Local + lvs_CGC_CIA + Of_String(lvs_Filler, 13) + lvs_CGC_FOR +&
					lvs_Transportadora + lvs_Desconto + Of_Number(0, 18) + lvs_Tipo_Mercadoria + lvs_Contrato +&
					lvs_Tipo_Pedido2 + lvs_CGC_CIA + lvs_Data_Faturamento + Of_Number(0, 5) + Of_Number(0, 18) +&
					Of_Number(0, 8) + Of_String(lvs_Filler, 156) + Of_String(lvs_Filler, 3) 
	End If
	
	If LenA(lvs_Registro) = 625 Then
		If Not of_Grava_Registro(ai_Arquivo, lvs_Registro) Then
			Return False
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro cabe$$HEX1$$e700$$ENDHEX$$alho do pedido inv$$HEX1$$e100$$ENDHEX$$lido '" +&
					String(LenA(lvs_Registro)) + "'.", StopSign!)
		Return False
	End If
	
End If
				
	   
Return True
end function

public function boolean of_layout_padrao_condicao_pgto (integer ai_arquivo, long al_pedido, string as_tipo_pedido, boolean ab_ims);Boolean lvb_Sucesso = True

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Parcela,&
	 lvl_Parcelas,&
	 lvl_Dias_Vencimento
	 
String lvs_Registro,&
	   	lvs_Filler, &
		ls_DS

Decimal lvdc_PC_Valor

dc_uo_ds_base lvds
lvds = Create dc_uo_ds_base

If Not ib_Pedido_Automatico Then
	ls_DS = "ds_ge147_lista_condicao_pagto"
Else
	ls_DS = "ds_ge147_lista_cond_pagto_distrib"
End If

If Not lvds.of_ChangeDataObject(ls_DS) Then
	Destroy(lvds)
	Return False
End If

If Not ib_Pedido_Automatico Then
	lvds.Retrieve(al_Pedido)
Else
	lvds.Retrieve(Long(as_tipo_pedido)) //as_tipo_pedido $$HEX1$$e900$$ENDHEX$$ a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento do fornecedor/distribuidora
End If

lvl_Linhas = lvds.RowCount()

If lvl_Linhas > 0 Then
	
	lvs_Filler = ""
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Parcelas 		= lvds.Object.qt_parcelas		[lvl_Linha]
		lvl_Parcela	 		= lvds.Object.nr_parcela		[lvl_Linha]
		lvl_Dias_Vencimento = lvds.Object.qt_dias_vencimento[lvl_Linha]
		lvdc_PC_Valor		= lvds.Object.pc_valor_total	[lvl_Linha]
		
		If ab_Ims Then
		
			lvs_Registro = 	"02" + of_String(String(lvl_Parcela), 2) + Of_String("5", 3) + Of_String("1", 3) +&
							String(lvl_Dias_Vencimento, "000") + of_Decimal(lvdc_PC_Valor, 10) +&
							Of_String(lvs_Filler, 427)
							
			If LenA(lvs_Registro) = 450 Then										
				If Not of_Grava_Registro(ai_Arquivo, lvs_Registro) Then
					lvb_Sucesso = False
					Exit
				End If
			Else
				If Not ib_Pedido_Automatico Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro condi$$HEX2$$e700e300$$ENDHEX$$o pagamento inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'.", StopSign!)
				Else
					is_Erro = "Tamanho do registro condi$$HEX2$$e700e300$$ENDHEX$$o pagamento inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'."
				End If
				
				lvb_Sucesso = False
				Exit
			End If 
		
		Else
		
			lvs_Registro = 	"02" + of_String(String(lvl_Parcela), 2) + Of_String("5", 3) + Of_String("1", 3) +&
							String(lvl_Dias_Vencimento, "000") + of_Decimal(lvdc_PC_Valor, 10) +&
							Of_String(lvs_Filler, 477)
							
			If LenA(lvs_Registro) = 500 Then										
				If Not of_Grava_Registro(ai_Arquivo, lvs_Registro) Then
					lvb_Sucesso = False
					Exit
				End If
			Else
				If Not ib_Pedido_Automatico Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro condi$$HEX2$$e700e300$$ENDHEX$$o pagamento inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'.", StopSign!)
				Else
					is_Erro = "Tamanho do registro condi$$HEX2$$e700e300$$ENDHEX$$o pagamento inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'."
				End If
				
				lvb_Sucesso = False
				Exit
			End If 
		
		End If
		
	Next
		
Else
	
	// Se o pedido for diverente de BONIFICADO n$$HEX1$$e300$$ENDHEX$$o continua o processo sem as parcelas de pagto.
	If as_Tipo_Pedido <> "002" Then
		If Not ib_Pedido_Automatico Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As parcelas de pagamento do pedido '" + String(al_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizadas.", StopSign!)
		Else
			is_Erro = "As parcelas de pagamento do pedido '" + String(al_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizadas."
		End If
		
		lvb_Sucesso = False
	End If
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean of_layout_padrao_produto (integer ai_arquivo, long al_pedido, boolean ab_ims);Boolean lvb_Sucesso = True

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Produto,&
	 lvl_Qtde
	 
Decimal lvdc_Desconto
		
Decimal{3} lvdc_Preco 

String lvs_EAN,&
	   lvs_Registro,&
	   lvs_Tipo_Registro,&
	   lvs_Sequencial,&
	   lvs_Qtde,&
	   lvs_Filler,&
	   lvs_Desconto,&
	   lvs_Preco, &
	   ls_DS

If Not ib_Pedido_Automatico Then
	ls_DS = "ds_ge147_lista_produto_pedido"
Else
	ls_DS = "ds_ge147_lista_produto_ped_distrib"
End If

dc_uo_ds_base lvds
lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject(ls_DS) Then
	Destroy(lvds)
	Return False
End If

If Not ib_Pedido_Automatico Then
	lvds.Retrieve(al_Pedido)
Else
	lvds.Retrieve(il_Filial, al_Pedido)
End If

lvl_Linhas = lvds.RowCount()

If lvl_Linhas > 0 Then
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Produto 		= lvds.Object.cd_produto			[lvl_Linha]
		lvl_Qtde			= lvds.Object.qt_pedida				[lvl_Linha]
		lvdc_Preco		= lvds.Object.vl_preco_unitario		[lvl_Linha]
		lvdc_Desconto	= lvds.Object.pc_desconto			[lvl_Linha]
		lvs_EAN			= lvds.Object.De_Codigo_Barras	[lvl_Linha]
		
//		If Not of_localiza_codigo_barras(lvl_Produto, Ref lvs_EAN) Then
//			lvb_Sucesso = False
//			Exit
//		End If
		
		lvs_Sequencial	= Of_Number(lvl_Linha, 6)
		lvs_EAN			= Of_String(lvs_EAN, 14)
		lvs_Qtde			= Of_Number(lvl_Qtde, 15)
		lvs_Filler			= ""
		lvs_Preco		= Of_Decimal(lvdc_Preco, 15)
		lvs_Desconto	= Of_Decimal(lvdc_Desconto, 10)
		
		If ab_Ims Then
		
			lvs_Registro = 	"03" + lvs_Sequencial + lvs_EAN + Of_String("EN", 3) + lvs_Qtde + Of_String(lvs_Filler, 3) + &
								is_Tipo_Pedido + lvs_Preco + Of_Number(0, 9) + Of_String(lvs_Filler, 3) + lvs_Desconto +  "001" + Of_String(lvs_Filler, 364)
							
			
			If LenA(lvs_Registro) = 450 Then
				If Not of_Grava_Registro(ai_Arquivo, lvs_Registro) Then
					lvb_Sucesso = False
					Exit
				End If
			Else
				If Not ib_Pedido_Automatico Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'.", StopSign!)
				Else
					is_Erro = "Tamanho do registro produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'."
				End If
				
				lvb_Sucesso = False
				Exit
			End If
		
		Else
			
			lvs_Registro = 	"03" + lvs_Sequencial + lvs_EAN + Of_String("EN", 3) + lvs_Qtde + Of_String(lvs_Filler, 6) +&
							lvs_Preco + Of_Number(0, 9) + Of_String(lvs_Filler, 3) + lvs_Desconto + "001" +&
							Of_String(lvs_Filler, 3) + Of_Number(0, 6) + Of_String(lvs_Filler, 3) + Of_String(lvs_Filler, 3) +&
							Of_String(lvs_Filler, 3) + Of_String(lvs_Filler, 3) + Of_String(lvs_Filler, 3) + Of_String(lvs_Filler, 17) +& 
							Of_Number(0, 18) + Of_String(lvs_Filler, 3) + Of_Number(0, 22) + Of_String(lvs_Filler, 330)
							
			
			If LenA(lvs_Registro) = 500 Then
				If Not of_Grava_Registro(ai_Arquivo, lvs_Registro) Then
					lvb_Sucesso = False
					Exit
				End If
			Else
				
				If Not ib_Pedido_Automatico Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'.", StopSign!)
				Else
					is_Erro = "Tamanho do registro produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(lvs_Registro)) + "'."
				End If
				
				lvb_Sucesso = False
				Exit
			End If	
		
		End If
	Next
	
Else
	If Not ib_Pedido_Automatico Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi localizado no pedido '" + String(al_Pedido) + "'.", StopSign!)
	Else
		is_Erro = "Nenhum produto foi localizado no pedido '" + String(al_Pedido) + "'."
	End If
	
	lvb_Sucesso = False
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean of_gera_registro_cabecalho_pedido (integer ai_arquivo, string as_edi, long al_pedido, string as_pbm, ref string as_tipo_pedido, ref string as_erro);Boolean lb_Retorno, lb_IMS

as_erro = ""

lb_IMS = (as_EDI = "I" Or as_Edi = "M")

Choose Case as_EDI
	Case 'O' //OpenText - Layout Bayer		
		lb_Retorno = This.of_Layout_Bayer_Cabecalho_Ped( ai_arquivo, Ref as_erro )
		
	Case 'F' //Foco PDV
		Return True
						
	Case Else //Layout Tivit e IMS
		lb_Retorno = This.of_Layout_Padrao_Cabecalho_Pedido( ai_Arquivo, Ref as_tipo_pedido, al_pedido, as_pbm, lb_IMS)
		
End Choose

Return lb_Retorno
end function

public function boolean of_gera_registro_condicao (integer ai_arquivo, string as_edi, long al_pedido, string as_tipo_pedido, ref string as_erro);Boolean lb_Retorno, lb_IMS

as_erro = ""

lb_IMS = (as_EDI = "I" Or as_Edi = "M")

Choose Case as_EDI
	Case 'O' //OpenText - Layout Bayer		
		lb_Retorno = This.of_Layout_Bayer_Frete( ai_arquivo, Ref as_erro )
		
	Case 'F' //Foco PDV
		Return True
		
	Case Else //Layout Tivit e IMS
		lb_Retorno = This.of_Layout_Padrao_Condicao_Pgto( ai_Arquivo, al_pedido, as_tipo_pedido, lb_IMS)
		
End Choose

Return lb_Retorno
end function

public function boolean of_gera_registro_produto (integer ai_arquivo, string as_edi, long al_pedido, ref string as_erro);Boolean lb_Retorno, lb_IMS

as_erro = ""

lb_IMS = (as_EDI = "I" Or as_Edi = "M")

Choose Case as_EDI
	Case 'O' //OpenText - Layout Bayer		
		lb_Retorno = This.of_Layout_Bayer_Produto( ai_arquivo, Ref as_erro )
		
	Case 'F'
		lb_Retorno = This.of_Layout_FocoPDV_Produto( ai_arquivo, Ref as_erro )
		
	Case Else //Layout Tivit e IMS
		lb_Retorno = This.of_Layout_Padrao_Produto( ai_Arquivo, al_pedido, lb_IMS)
		
End Choose

Return lb_Retorno
end function

public function boolean of_layout_bayer_produto (integer ai_arquivo, ref string as_erro);Boolean lb_Sucesso = False

Long ll_Row , &
	 ll_Linhas, &
	 ll_Produto
	 	
Decimal{2} ldc_Preco_UN, ldc_Desconto, ldc_Desconto_Ped
Decimal{4} ldc_Qtde

Integer li_Zero = 0

String ls_EAN,&
	   ls_Registro,&
	   ls_Sequencial,&
	   ls_Qtde,&
	   ls_Desconto,&
	   ls_Preco_UN

Try
	
	as_erro = ""

	dc_uo_ds_base lvds
	lvds = Create dc_uo_ds_base
	
	If Not lvds.of_ChangeDataObject("ds_ge147_lista_produto_pedido") Then
		as_erro = "Erro no ChangeDataObject ds_ge147_lista_produto_pedido. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_layout_bayer_produto"
		Return False
	End If
		
	ll_Linhas = lvds.Retrieve(il_Pedido_Clamed)
	
	Choose Case ll_Linhas
		Case is < 0
			as_erro = "Erro no retrieve. Pedido: " + String( il_Pedido_Clamed )
		Case 0
			as_erro = "Nenhum produto foi localizado no pedido '" + String(il_Pedido_Clamed) + "'."
		Case is > 0
				
			For ll_Row  = 1 To ll_Linhas
				
				lb_Sucesso 		= False
				ldc_Desconto 	= 0.00
				ldc_Preco_UN	= 0.00
				
				ll_Produto 			= lvds.Object.cd_produto			[ ll_Row ]
				ldc_Qtde				= Dec(lvds.Object.qt_pedida		[ ll_Row ])
				ldc_Preco_UN		= lvds.Object.vl_preco_unitario		[ ll_Row ]
				ldc_Desconto		= lvds.Object.pc_desconto			[ ll_Row ]
				ldc_Desconto_Ped	= lvds.Object.pc_desconto_pedido	[ ll_Row ]
								
				ls_EAN				= lvds.Object.de_codigo_barras	[ ll_Row ]		
				
				// Pre$$HEX1$$e700$$ENDHEX$$o Liquido
				ldc_Preco_UN 	=  Round(ldc_Preco_UN * ((100 - ldc_Desconto) / 100), 2)
				ldc_Preco_UN 	=  Round(ldc_Preco_UN * ((100 - ldc_Desconto_Ped) / 100), 2)
								
				ldc_Desconto = 0.00
	
				ls_Sequencial 	= Of_Number(ll_Row , 6 )		
				ls_EAN		   	= Of_String(ls_EAN, 14 )
				ls_Qtde			= Of_Decimal(ldc_Qtde, 17)
				ls_Preco_UN	   	= Of_Decimal(ldc_Preco_UN, 17)
				ls_Desconto   	= Of_Decimal(ldc_Desconto, 8)
				
				ls_Registro = "04" + ls_Sequencial + Of_String( ls_EAN, 14) + "EAN" + Space(35) + ls_Qtde + of_Number( li_zero, 17 ) + &
									Space(3) + of_Number( li_zero, 23 ) + ls_Preco_UN + of_Number( li_zero, 17 ) + Space(33) + &
									of_Number( li_zero, 71 ) + ls_Desconto + Space(134)
													
					
				If LenA( ls_Registro ) = 400 Then
					If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then
						Exit
					End If
				Else
					as_erro = "Layout Bayer: Tamanho do registro produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(ls_Registro)) + "'."
					Exit
				End If	
				
				lb_Sucesso = True
				
			Next
			
	End Choose
		
Finally
	If IsValid( lvds ) Then Destroy lvds
	Return lb_Sucesso
End Try
end function

public function boolean of_layout_focopdv_cabecalho (integer ai_arquivo, ref string as_erro);String ls_Registro
String ls_Aux

Time lt_Hora_Atual

ls_Aux = String(Date(gf_GetServerDate()))
ls_Aux = gf_Replace(ls_Aux, "/", "", 0)

lt_Hora_Atual = Time(gf_GetServerDate())

ls_Registro = "00;" + of_String( "61940292005872", 15) + ";" + of_String(ls_Aux, 8) + ";" + of_String(String(lt_Hora_Atual), 8)
					
ls_Registro = gf_Replace(ls_Registro, "/", "", 0)
ls_Registro = gf_Replace(ls_Registro, ":", "", 0)
ls_Registro = gf_Replace(ls_Registro, " ", "", 0)
					
//If LenA(ls_Registro) = 33 Then
	If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then
		Return False
	End If
//Else
//	as_erro = "Layout Foco PDV: Tamanho do registro cabe$$HEX1$$e700$$ENDHEX$$alho inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(ls_Registro)) + "'."
//	Return False
//End If

ls_Aux = String(idt_Emissao)
ls_Aux = gf_Replace(ls_Aux, "/", "", 0)

ls_Registro = "08;" + of_String(is_CNPJ_CIA, 15) + ";" + of_String(is_Razao_Social_CIA, 60) + ";" + of_String("CLAMED", 30) + ";" + of_String(is_Endereco_CIA, 60) + ";" + &
					of_String(is_Bairro_CIA, 60) + ";" + of_String(is_Cidade_CIA, 60) + ";" + of_String(is_UF_CIA, 2) + ";" + of_String(is_CEP_CIA, 9) + ";" + of_String("", 60) + ";" + &
					of_String("", 50) + ";" + of_String("COMPRADOR", 50) + ";" + of_String("anderson.lima@clamed.com.br", 100) + ";" + of_String("0", 8) + ";" + &
					of_String("0", 14) + ";" + of_String("0", 8) + ";" + of_String("256134715;", 20) + ";" + of_String("SUFRAMA", 20) + ";" + of_String("OBSERVA$$HEX2$$c700c300$$ENDHEX$$O CLIENTE", 500) + ";" + & 
					of_String("OBSERVA$$HEX2$$c700c300$$ENDHEX$$O DA NF", 255)
					
If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then Return False

Return True
end function

public function boolean of_layout_focopdv_produto (integer ai_arquivo, ref string as_erro);Boolean lb_Sucesso = False

Long ll_Row , &
	 ll_Linhas, &
	 ll_Produto
	 	
Decimal{2} ldc_Preco_UN, ldc_Desconto, ldc_Desconto_Ped, ldc_Vl_Total
Decimal{4} ldc_Qtde

Integer li_Zero = 0

String ls_EAN,&
	   ls_Registro,&
	   ls_Sequencial,&
	   ls_Qtde,&
	   ls_Desconto,&
	   ls_Preco_UN, &
	   ls_Emissao, &
	   ls_Vl_Total
		
Try
	
	as_erro = ""

	dc_uo_ds_base lvds
	lvds = Create dc_uo_ds_base
	
	If Not lvds.of_ChangeDataObject("ds_ge147_lista_produto_pedido") Then
		as_erro = "Erro no ChangeDataObject ds_ge147_lista_produto_pedido. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_layout_focopdv_produto"
		Return False
	End If
		
	ll_Linhas = lvds.Retrieve(il_Pedido_Clamed)
	
	Choose Case ll_Linhas
		Case is < 0
			as_erro = "Erro no retrieve. Pedido: " + String( il_Pedido_Clamed )
		Case 0
			as_erro = "Nenhum produto foi localizado no pedido '" + String(il_Pedido_Clamed) + "'."
		Case is > 0
				
				ls_Emissao = String(idt_Emissao)
				ls_Emissao = gf_Replace(ls_Emissao, "/", "", 0)
				ls_Emissao = gf_Replace(ls_Emissao, ":", "", 0)
				
				ls_Registro = "01;" + of_String(is_CNPJ_CIA, 15) + ";" + of_String("0", 12) + ";" + of_String(ls_Emissao, 8) + ";" + &
				of_String("30 DIAS", 60) + ";" + of_String(String(il_Pedido_Clamed), 20) + ";" + of_String("54.46", 14)
				ls_Registro = gf_Replace(ls_Registro, " ", "", 0)
				
				ls_Registro = gf_Replace(ls_Registro, " ", "", 0)
				
				If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then Return False
				
			For ll_Row  = 1 To ll_Linhas
				
				lb_Sucesso 		= False
				ldc_Desconto 	= 0.00
				ldc_Preco_UN	= 0.00
				
				ll_Produto 			= lvds.Object.cd_produto			[ ll_Row ]
				ldc_Qtde				= Dec(lvds.Object.qt_pedida		[ ll_Row ])
				ldc_Preco_UN		= lvds.Object.vl_preco_unitario		[ ll_Row ]
				ldc_Desconto		= lvds.Object.pc_desconto			[ ll_Row ]
				ldc_Desconto_Ped	= lvds.Object.pc_desconto_pedido	[ ll_Row ]
								
				ls_EAN				= lvds.Object.de_codigo_barras	[ ll_Row ]
				
				// Pre$$HEX1$$e700$$ENDHEX$$o Liquido
				ldc_Preco_UN 	=  Round(ldc_Preco_UN * ((100 - ldc_Desconto) / 100), 2)
				ldc_Preco_UN 	=  Round(ldc_Preco_UN * ((100 - ldc_Desconto_Ped) / 100), 2)
				
				ldc_Vl_Total = ldc_Preco_UN * ldc_Qtde
	
				ls_Sequencial 	= Of_Number(ll_Row , 5 )
				ls_EAN		   	= Of_String(ls_EAN, 13 )
				ls_Qtde			= of_Number(ldc_Qtde, 6)
				ls_Desconto   	= Of_Decimal(ldc_Desconto, 5)
				ls_Preco_UN	   	= Of_Decimal(ldc_Preco_UN, 12)
				ls_Vl_Total		= Of_Decimal(ldc_Vl_Total, 12)
				
//				ls_Sequencial 	= Of_Number(ll_Row , 6 )		
//				ls_EAN		   	= Of_String(ls_EAN, 14 )
//				ls_Qtde			= Of_Decimal(ldc_Qtde, 17)
//				ls_Preco_UN	   	= Of_Decimal(ldc_Preco_UN, 17)
//				ls_Desconto   	= Of_Decimal(ldc_Desconto, 8)
								
				ls_Registro = "02;" + of_String(is_CNPJ_CIA, 15) + ";" + Of_String( "0", 12) + ";" + ls_Sequencial + ";" + ls_Ean + ";" + &
				ls_Qtde + ";" + ls_Desconto + ";" + ls_Preco_UN+ ";" + ls_Vl_Total + ";1"
																				
//				If LenA( ls_Registro ) = 400 Then
					If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then
						Exit
					End If
//				Else
//					as_erro = "Layout Bayer: Tamanho do registro produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(LenA(ls_Registro)) + "'."
//					Exit
//				End If	
				
				lb_Sucesso = True
			Next
			
	End Choose
	
	ls_Registro = "10;" + of_String(is_CNPJ_CIA, 15) + ";" + of_String("0", 12) + ";0;" + "N;" + "N;" + of_String(is_Obs_Pedido, 100)
	ls_Registro = gf_Replace(ls_Registro, " ", "", 0)
	
	If Not of_Grava_Registro(ai_Arquivo, ls_Registro) Then
		Return False
	End If
		
Finally
	If IsValid( lvds ) Then Destroy lvds
	Return lb_Sucesso
End Try
end function

public function boolean of_abre_arquivo (ref integer ai_arquivo, ref long al_sequencial, ref string as_path, ref string as_nome_arquivo, string as_laboratorio, string as_edi, string as_de_van, string as_cgc_fornecedor);String	lvs_INI,&
	   	lvs_Path,&
		lvs_Diretorio,&
		ls_Backup, &
		ls_Forn_Conexao

If Not ib_Pedido_Automatico Then

	is_De_Van = as_De_Van
	lvs_Path = "C:\" + is_De_Van
	
	If as_cgc_fornecedor = '60409075010034' Then 
		lvs_Path =is_OPENTEXTSFTP
	End If 
	
	If lvs_Path <> "" Then
		
		If Not of_Proximo_Sequencial(Ref al_Sequencial, as_EDI) Then
			Return False
		End If
		
		If Right(lvs_Path, 1) = "\" Then
			lvs_Diretorio = lvs_Path
		Else
			lvs_Diretorio = lvs_Path +  "\"
		End If
		
		If Not DirectoryExists(lvs_Diretorio) Then
			If CreateDirectory(lvs_Diretorio) = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + lvs_Diretorio + "'.", StopSign!)
				Return False
			End If
		End If
		
		ls_Backup = lvs_Diretorio + "BKP"
		
		If Not DirectoryExists(ls_Backup) Then
			If CreateDirectory(ls_Backup) = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + ls_Backup + "'.", StopSign!)
				Return False
			End If
		End If
		
		If as_EDI = 'F' Then
			//OLPEDXXXXDDMMAAAAHHMMSSYYYYYYYYYYYY.txt
			
			as_Nome_Arquivo = 'OLPED1234' + String(gf_GetServerDate()) + '123456789012'
			as_Nome_Arquivo = gf_Retira_Caracteres_Especiais(as_Nome_Arquivo)
			as_Nome_Arquivo = gf_Replace(as_Nome_Arquivo, " ", "", 0)
			as_Nome_Arquivo = gf_Replace(as_Nome_Arquivo, ":", "", 0) + ".txt"
		
		ElseIf as_EDI <> 'O' Then
			//Retira acentos e caracteres especiais para n$$HEX1$$e300$$ENDHEX$$o ter problema quando for gerar o arquivo
			as_laboratorio = gf_Retira_Acentos(as_laboratorio)
			as_laboratorio = gf_Retira_Caracteres_Especiais(as_Laboratorio)
			
			as_nome_arquivo = as_laboratorio + "_" + String(Day(Today()), "00") + &
											String(Month(Today()), "00") + String(al_Sequencial, "0000") + ".txt"
											  
		Else
			
			as_nome_arquivo = 'ORD' + as_cgc_fornecedor + "_" + String(Day(Today()), "00") + &
											String(Month(Today()), "00") + String(al_Sequencial, "0000") + ".txt"
		End If
	
		as_Path = lvs_Diretorio + as_nome_arquivo
		
		ai_Arquivo = FileOpen(as_Path, LineMode!, Write!, LockWrite!, Append!)
		
		If ai_Arquivo = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo do pedido '" + as_Path + ".", StopSign!)
			Return False
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O caminho para grava$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o foi definido.", StopSign!)
		Return False
	End If
	
Else
		
	lvs_Path = gvo_Aplicacao.of_GetFromINI("Diretorio", "Pedidos")
	
	If Not This.of_Fornecedor_Conexao(Ref ls_Forn_Conexao) Then Return False
	
	lvs_Diretorio = lvs_Path + ls_Forn_Conexao
	
	//Cria o diret$$HEX1$$f300$$ENDHEX$$rio do fornecedor conex$$HEX1$$e300$$ENDHEX$$o
	If Not DirectoryExists(lvs_Diretorio) Then
		If CreateDirectory(lvs_Diretorio) = -1 Then
			is_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + lvs_Diretorio + "'."
			Return False
		End If
	End If
	
	//Cria o diret$$HEX1$$f300$$ENDHEX$$rio backup
	If Not DirectoryExists(lvs_Diretorio + "\backup") Then
		If CreateDirectory(lvs_Diretorio + "\backup") = -1 Then
			is_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + lvs_Diretorio + "/backup" + "'."
			Return False
		End If
	End If
	
	//Cria o diret$$HEX1$$f300$$ENDHEX$$rio temp
	If Not DirectoryExists(lvs_Diretorio + "\temp") Then
		If CreateDirectory(lvs_Diretorio + "\temp") = -1 Then
			is_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + lvs_Diretorio + "/temp" + "'."
			Return False
		End If
	End If
	
	as_nome_arquivo = is_CNPJ_CIA + "_" + String(il_Pedido_Clamed) + ".txt"
	
	as_Path = lvs_Diretorio + "\" + as_nome_arquivo
		
	ai_Arquivo = FileOpen(as_Path, LineMode!, Write!, LockWrite!, Append!)
	
	If ai_Arquivo = -1 Then
		is_Erro = "Erro ao abrir o arquivo do pedido '" + as_Path + "."
		Return False
	End If	
End If

Return True
end function

public function boolean of_consulta_pedido_distribuidora (long al_pedido, ref datetime adt_emissao, ref string as_condicao_pgto, ref string as_cgc, ref string as_razao_social, ref string as_endereco, ref string as_bairro, ref string as_cidade, ref string as_uf, ref string as_cep, ref string as_cgc_fornecedor, ref string as_transportadora, ref decimal adc_desconto, ref string as_inscricao_estadual, ref datetime adt_faturamento, string as_pbm);Date ldt_Atual

Long ll_Condicao_Pgto
	 
Select p.nr_pedido_distribuidora, 
	   fo.cd_condicao_pagamento,
	   f.nr_cgc,
	   f.nm_razao_social,
	   f.de_endereco,
	   f.de_bairro,
	   c.nm_cidade,
	   c.cd_unidade_federacao,
	   f.nr_cep,
	   fo.nr_cgc,
	   fo.pc_desconto_usual,
	   f.nr_inscricao_estadual
Into :al_Pedido, 
	 :ll_Condicao_Pgto,
	 :as_CGC,
	 :as_Razao_Social,
	 :as_Endereco,
	 :as_Bairro,
	 :as_Cidade,
	 :as_UF,
	 :as_CEP,
	 :as_CGC_Fornecedor,
	 :idc_Desconto,
	 :as_Inscricao_Estadual
From pedido_distribuidora p 
	inner join filial f 			on f.cd_filial 			= p.cd_filial  
	inner join cidade c 		on c.cd_cidade			= f.cd_cidade
	inner join fornecedor fo 	on fo.cd_fornecedor	= p.cd_distribuidora
Where p.cd_filial = :il_Filial
	And p.nr_pedido_distribuidora = :al_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		ldt_Atual = Date(gf_GetServerDate())
		
		adt_Emissao = DateTime(ldt_Atual)
		as_Transportadora = ""
		adt_Faturamento = DateTime(RelativeDate(ldt_Atual, 2))
		is_Obs_Pedido = ""
		// Pedido Normal
		as_Condicao_Pgto = "001"
		
		// Tira a m$$HEX1$$e100$$ENDHEX$$scara
		is_Inscricao_Estadual = gf_Tira_Mascara_Inscricao_Estadual(is_Inscricao_Estadual)
			
	Case 100
		is_erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar os dados do pedido: " + String( al_pedido )
		Return False
		
	Case -1
		is_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do pedido: " + + String( al_pedido ) + " . " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_fornecedor_conexao (ref string as_fornecedor_conexao);Select cd_fornecedor_envio
	Into :as_Fornecedor_Conexao
From conexao
Where id_projeto_conexao = '6'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(as_Fornecedor_Conexao) And as_Fornecedor_Conexao <> "" Then
			Return True
		Else
			is_Erro = "Fornecedor envio est$$HEX1$$e100$$ENDHEX$$ nulo no projeto conex$$HEX1$$e300$$ENDHEX$$o 6 da tabela conex$$HEX1$$e300$$ENDHEX$$o."
		End If
		
	Case 100
		is_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o projeto conex$$HEX1$$e300$$ENDHEX$$o 6 na tabela conexao."
		
	Case -1
		is_Erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do fornecedor envio do projeto conex$$HEX1$$e300$$ENDHEX$$o 6. " + SqlCa.SqlErrText
		
End Choose

Return False
end function

public function boolean of_grava_arquivo_pedido_automatico (long al_filial, long al_pedido, ref string as_arquivo, ref string as_erro);Boolean lvb_Sucesso = False, lvb_IMS

Integer lvi_Arquivo

Long lvl_Pedido,&
	 lvl_Find,&
	 lvl_Sequencial
	 
String	lvs_Tipo_Pedido,&
	   	lvs_CGC_Fornecedor,&
		lvs_PBM	
		
String lvs_Path
String lvs_Arquivo
String ls_ID_EDI
String ls_EDI_Layout
String ls_De_Van
 
ib_Pedido_Automatico = True 

If Not ids_Pedido.of_ChangeDataObject("dw_ge147_lista_pedido_edi_conveniencia") Then
	as_Erro = "Erro no change da ds 'dw_ge147_lista_pedido_edi_conveniencia'."
	Return False
End If

If ids_Pedido.Retrieve(al_Filial, al_Pedido) < 0 Then
	as_Erro = "Erro no retrieve da ds 'dw_ge147_lista_pedido_edi_conveniencia'."
	Return False
End If

If ids_Pedido.RowCount() > 0 Then
		
	ls_ID_EDI				= ids_Pedido.Object.id_pedido_edi	[1]	
	il_Filial					= al_Filial
	lvl_Pedido				= ids_Pedido.Object.Nr_Pedido			[1]
	is_CNPJ_CIA				= ids_Pedido.Object.Nr_CGC_Filial		[1]
	lvs_CGC_Fornecedor	= ids_Pedido.Object.nr_cgc_forn		[1]
	lvs_PBM					= "N"
	il_Pedido_Clamed		= lvl_Pedido
	is_Distribuidora			= ids_Pedido.Object.Cd_Distribuidora	[1]

	// Abre o arquivo
	If This.of_Abre_Arquivo( Ref lvi_Arquivo, Ref lvl_Sequencial, Ref lvs_Path, Ref lvs_Arquivo, ivs_nome_arquivo, ls_ID_EDI, ls_De_Van, lvs_CGC_Fornecedor ) Then
		// Grava o registro cabe$$HEX1$$e700$$ENDHEX$$alho
		If This.of_Gera_Registro_Cabecalho( lvi_Arquivo, ls_EDI_Layout, lvl_Pedido, lvs_PBM, lvl_Sequencial, lvs_CGC_Fornecedor, Ref as_Erro ) Then
			If This.of_gera_registro_cabecalho_pedido(lvi_Arquivo, ls_EDI_Layout, lvl_Pedido, lvs_PBM, Ref lvs_Tipo_Pedido, Ref as_Erro ) Then
				If This.of_Gera_Registro_Condicao(lvi_Arquivo, ls_EDI_Layout, lvl_Pedido, lvs_Tipo_Pedido, Ref as_Erro ) Then 
					If This.of_Gera_Registro_Produto(lvi_Arquivo, ls_EDI_Layout, lvl_Pedido, Ref as_Erro ) Then
						lvb_Sucesso = True
					End If
				End If
			End If
		End If
	End If
	
	FileClose(lvi_Arquivo)
	
	If lvb_Sucesso Then
		SqlCa.of_Commit();
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo de pedido EDI '" + lvs_Path + "' foi gerado com sucesso.")
	Else
		SqlCa.of_RollBack();
		
		//is_Erro $$HEX1$$e900$$ENDHEX$$ utilizado em algumas fun$$HEX2$$e700f500$$ENDHEX$$es que n$$HEX1$$e300$$ENDHEX$$o tem o par$$HEX1$$e200$$ENDHEX$$metro Ref as_Erro
		as_Erro = as_Erro + is_Erro
		
		// Se der algum erro durante a gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo o sistema vai excluir o arquivo
		FileDelete( lvs_Path )
	End If
	
End If

Return True
end function

public function boolean of_retorna_gln_neogrid (ref string as_gln);Select nr_gln
	Into :as_gln
From filial_distribuidora
Where cd_filial = :il_Filial
	and cd_distribuidora = :is_Distribuidora
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If IsNull(as_gln) Or Trim(as_gln) = "" Then
			 as_gln = Space(13)
		Else
			 If Len(as_gln) > 13 Then
				  as_gln = Left(as_gln, 13)
			 ElseIf Len(as_gln) < 13 Then
				  as_gln = Space(13)
			 End If
		End If
		
		Return True
		
	Case 100		
		as_gln = Space(13)
		
		Return True
	Case -1
		is_Erro = "Erro ao consultar o GLN da filial " + String(il_Filial) + " na distribuidora " + is_Distribuidora + ". " + SqlCa.SqlErrText
		
End Choose

Return False
end function

on uo_pedido_central_edi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pedido_central_edi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_Pedido = Create dc_uo_ds_base
end event

event destructor;If IsValid(ids_Pedido) Then Destroy(ids_Pedido)
end event

