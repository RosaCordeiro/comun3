HA$PBExportHeader$uo_ge513_exporta_arquivos_farmacia.sru
forward
global type uo_ge513_exporta_arquivos_farmacia from nonvisualobject
end type
end forward

global type uo_ge513_exporta_arquivos_farmacia from nonvisualobject
event ue_post_open ( nonvisualobject pvo_comum )
end type
global uo_ge513_exporta_arquivos_farmacia uo_ge513_exporta_arquivos_farmacia

type variables
	String	ivs_Path_Exportacao

dc_uo_api ivo_api

String is_cnpj_clamed
String is_razao_social
String is_uf_rede
Datetime idt_atual

string is_Processo
string is_Server_FTP
string is_Usuario_FTP
string is_Senha_FTP
string is_envia_arquivo_ftp

string is_codigo_iqva = '1550'
String is_protocolo_sftp


end variables

forward prototypes
public function boolean of_cria_diretorios (string ps_processo, ref string ps_log)
public function boolean of_exclui_arquivos_temporarios (ref string ps_log)
public function boolean of_gera_arquivos (string ps_processo, ref string ps_log)
public function boolean of_abre_arquivo (string ps_arquivo, ref integer pi_arquivo, ref string ps_log)
public function boolean of_exporta_arquivos_processo_011 (datastore pdw_controle_processo, datastore pdw_dados_receita, integer pi_arquivo, string ps_nm_arquivo, date pdt_periodo_de, date pdt_periodo_ate, ref string ps_log)
public function boolean of_grava_arquivo (integer pi_arquivo, string ps_registro, ref string ps_log)
public function boolean of_verifica_tipo_prescritor (string ps_tipo_registro, string ps_registro, string ps_uf, ref string ps_nm_prescritor, ref string ps_log)
public function boolean of_atualiza_tab_ult_geracao (string ps_processo, date pdt_ult_exportacao, long pl_ult_arquivo_exportacao, ref string ps_log)
public function boolean of_compacta_arquivos (string ps_diretorio, string ps_destino, ref string ps_file_compactado, ref string ps_log)
public function boolean of_exporta_arquivos_processo_012 (datastore pdw_controle_processo, datastore pdw_dados_receita, integer pi_arquivo, string ps_nm_arquivo, date pdt_periodo_de, date pdt_periodo_ate, ref string ps_log)
public function string of_formata_campo (string ps_processo, string ps_valor, string ps_tipo_campo, long pl_tamanho)
public function boolean of_atualiza_controle_exportacao (date pdt_movimento, datetime pdh_inicio, ref string ps_log)
public function boolean of_exporta_iqva_venda (date pdt_data, ref string ps_log)
public function boolean of_exporta_iqva (string ps_cd_processo, date pdt_data_exportacao_manual, ref string ps_log)
public function boolean of_exporta_iqva (string ps_cd_processo, ref string ps_log)
public function boolean of_exporta_iqva_compra (date pdt_data, ref string ps_log)
public function boolean of_exporta_iqva_ticket (date pdt_data, ref string ps_log)
public function boolean of_exporta_iqva_estoque (date pdt_data, string ps_tipo_arquivo, ref string ps_log)
public function boolean of_exporta_iqva_pedido (date pdt_data, string ps_tipo_arquivo, ref string ps_log)
public function boolean of_exporta_iqva_entrada (date pdt_data, string ps_tipo_arquivo, ref string ps_log)
public function boolean of_envia_arquivo (string ps_nm_arquivo_completo, string ps_nm_arquivo_ext, string ps_nm_arquivo, ref string ps_log)
public function boolean of_envia_arquivo_ftp (string ps_processo, string ps_servidor, string ps_usuario, string ps_senha, string ps_diretorio, string ps_arquivo, string ps_log)
public function boolean of_localiza_ean (long al_produto, string as_ean_old, ref string as_ean_novo, ref string ps_log)
public function boolean of_grava_log (string as_mensagem, string as_ean, boolean ab_envia_email)
public subroutine of_corrige_ean (long lvl_produto, ref string lvs_ean)
public function boolean of_gera_arquivos (string ps_processo, ref string ps_log, date ps_data_de, date ps_data_ate)
end prototypes

public function boolean of_cria_diretorios (string ps_processo, ref string ps_log);String ls_Diretorio

SetNull( ls_Diretorio )

ls_Diretorio = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If IsNull(ls_Diretorio) Then
	ps_Log += "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ diret$$HEX1$$f300$$ENDHEX$$rio definido em " + gvo_Aplicacao.ivs_Arquivo_INI + " para grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo."
	Return False
End If

If Not DirectoryExists( ls_Diretorio + "\Exportacao" ) Then
	CreateDirectory( ls_Diretorio + "\Exportacao" )
End If

If Not DirectoryExists( ls_Diretorio + "\Exportacao\" + ps_Processo ) Then
	CreateDirectory( ls_Diretorio + "\Exportacao\" + ps_Processo )
End If

If Not DirectoryExists( ls_Diretorio + "\Exportacao\" + ps_Processo + "\Backup"  ) Then
	CreateDirectory( ls_Diretorio + "\Exportacao\" + ps_Processo + "\Backup" )
End If

If Not DirectoryExists( ls_Diretorio + "\Exportacao\" + ps_Processo + "\Temp" ) Then
	CreateDirectory( ls_Diretorio + "\Exportacao\" + ps_Processo + "\Temp" )
End If

ivs_Path_Exportacao = ls_Diretorio + "\Exportacao\" + ps_Processo + "\"

If Not This.Of_Exclui_Arquivos_Temporarios(ref ps_Log) Then Return False

Return True
end function

public function boolean of_exclui_arquivos_temporarios (ref string ps_log);Boolean lvb_Sucesso = True

String 	lvs_Path_Temp, &
			lvs_Arquivos[], &
			lvs_Arquivo_Exclusao

Integer 	lvi_Total, &
			lvi_Row
			
DateTime	lvdth_Servidor, &
				lvdth_Arquivo

lvs_Path_Temp = ivs_Path_Exportacao + "\temp\"

// Exclui TODOS os arquivos da pasta temp
If gf_dir_list( lvs_Path_Temp, '*.*', 0+2+4, Ref lvs_Arquivos[] ) > 0 Then

	lvi_Total = UpperBound(lvs_Arquivos[])
	
	For lvi_Row = 1 To lvi_Total
		
		lvs_Arquivo_Exclusao = lvs_Path_Temp + lvs_Arquivos[ lvi_Row ]
		
		If Not FileDelete(lvs_Arquivo_Exclusao) Then
			ps_Log += "Erro ao excluir o arquivo '" + lvs_Arquivo_Exclusao + "'."
			lvb_Sucesso = False
			Exit
		End If
	Next	
End If

lvdth_Servidor = gf_GetServerDate()

// Exclui os arquivos da pasta Backup com data inferior a 30 dias
lvs_Path_Temp = ivs_Path_Exportacao + "\backup\"

// Exclui TODOS os arquivos da pasta temp
If gf_dir_list( lvs_Path_Temp, '*.*', 0+2+4, Ref lvs_Arquivos[] ) > 0 Then

	lvi_Total = UpperBound(lvs_Arquivos[])
	
	For lvi_Row = 1 To lvi_Total
		
		lvs_Arquivo_Exclusao = lvs_Path_Temp + lvs_Arquivos[ lvi_Row ]
		lvdth_Arquivo			= ivo_Api.Of_Data_Arquivo(lvs_Arquivo_Exclusao)	
		lvdth_Arquivo			= DateTime(RelativeDate(Date(lvdth_Arquivo), 30))
		
		If lvdth_Arquivo < lvdth_Servidor Then		
		
			If Not FileDelete(lvs_Arquivo_Exclusao) Then
				ps_Log += "Erro ao excluir o arquivo '" + lvs_Arquivo_Exclusao + "'."
				lvb_Sucesso = False
				Exit
			End If
		End If
	Next	
End If

Return lvb_Sucesso 

end function

public function boolean of_gera_arquivos (string ps_processo, ref string ps_log);Date	ldt_Nulo

SetNull (ldt_Nulo)

Return of_gera_arquivos (ps_processo, Ref ps_log, ldt_Nulo, ldt_Nulo)
end function

public function boolean of_abre_arquivo (string ps_arquivo, ref integer pi_arquivo, ref string ps_log);// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(ps_Arquivo) Then
	FileDelete(ps_Arquivo)
End If

// Abre o arquivo
pi_arquivo = FileOpen(ps_Arquivo,linemode!,write!,LockReadWrite!,replace!)	

If pi_Arquivo < 1 Then
	ps_Log += "Erro na abertura do arquivo : " + ps_Arquivo + " C$$HEX1$$f300$$ENDHEX$$digo: " + String(SqlCa.SqlCode) + " - " + SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean of_exporta_arquivos_processo_011 (datastore pdw_controle_processo, datastore pdw_dados_receita, integer pi_arquivo, string ps_nm_arquivo, date pdt_periodo_de, date pdt_periodo_ate, ref string ps_log);Boolean lvb_Sucesso = True

Long	lvl_Row, &
		lvl_Filial
		
String	lvs_Tipo_Registro, &
		lvs_UF_Prescritor, &
		lvs_Registro, &
		lvs_Nm_Prescritor, &
		lvs_Reg, &
		lvs_Nr_CGC_Filial

Open(w_Aguarde)
w_Aguarde.Title = 'Gerando Arquivo de Informa$$HEX2$$e700f500$$ENDHEX$$es IMS Health...'
w_Aguarde.uo_Progress.of_SetMax(pdw_dados_receita.RowCount())

For lvl_row = 1 To pdw_dados_receita.RowCount()

	w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)
	
//	/// <Chamado 1048779>Colocado Zeros Nos Valores
//	pdw_dados_receita.object.qt_vendida[lvl_row] = 0 
	
	
	lvl_Filial        		= pdw_dados_receita.object.cd_filial             							[lvl_row]
	lvs_Tipo_Registro 	= pdw_dados_receita.object.id_registro_prescritor					[lvl_row]
	lvs_UF_Prescritor 	= pdw_dados_receita.object.cd_uf_prescritor      						[lvl_row]
	lvs_Registro      	= String(long(pdw_dados_receita.object.nr_registro_prescritor	[lvl_row]),'0000000')
	lvs_Nr_CGC_Filial	= pdw_dados_receita.Object.nr_cgc										[lvl_Row]
			
	lvs_reg  = ''
	lvs_reg += '"' + lvs_Nr_CGC_Filial + '";'														// cnpj filial
	lvs_reg += lvs_Registro + ';'                            											// registro prescritor
	lvs_reg += '"' + pdw_dados_receita.object.id_registro_prescritor[lvl_row] + '";' 	// tipo registro
	lvs_reg += '"' + lvs_uf_prescritor + '";'                											// uf prescritor
	lvs_reg += '"84683481000177"' + ';'															// cnpj empresa
	lvs_reg += '"' + pdw_dados_receita.object.de_codigo_barras[lvl_row] + '";'		// cod.barras produto
	lvs_reg += String(pdw_dados_receita.object.qt_vendida[lvl_row],'000000') + ';'  	// quantidade			
	lvs_reg += '"' + pdw_dados_receita.object.de_produto[lvl_row] + '";'         			// descricao apresentacao produto
	lvs_reg += 	String(Long(pdw_dados_receita.object.dia[lvl_row]),"00") + &
					String(Long(pdw_dados_receita.object.mes[lvl_row]),"00") + &
					pdw_dados_receita.object.ano_ims[lvl_row]								// diamesano		
	
	If Not This.Of_Grava_Arquivo(pi_Arquivo, lvs_Reg, ref ps_Log) Then
		lvb_Sucesso = False
		Exit
	End If
Next	

FileClose(pi_Arquivo)
Close(w_Aguarde)

Return lvb_Sucesso
end function

public function boolean of_grava_arquivo (integer pi_arquivo, string ps_registro, ref string ps_log);if pi_arquivo = 0 or isnull(pi_arquivo) Then return true

If FileWrite(pi_arquivo,ps_registro) <> LenA(ps_registro) Then
	ps_Log += "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo."
	Return False
Else 
	Return true
End If	
end function

public function boolean of_verifica_tipo_prescritor (string ps_tipo_registro, string ps_registro, string ps_uf, ref string ps_nm_prescritor, ref string ps_log);String lvs_prescritor

ps_registro = String(Long(ps_registro),'00000000')

Select nm_prescritor Into :lvs_prescritor
From prescritor_receita
Where id_registro = :ps_tipo_registro
  and nr_registro = :ps_registro
  and cd_unidade_federacao = :ps_uf
  and id_situacao = 'A'
Using Sqlca;  

Choose Case Sqlca.Sqlcode
	Case -1
		ps_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o prescritor receita - registro[" + ps_registro + "]"
		Return False
	Case 100
//		ps_Log += "Registro n$$HEX1$$e300$$ENDHEX$$o localizado - Localiza$$HEX2$$e700e300$$ENDHEX$$o prescritor receita - registro[" + ps_registro + "]"
//		Return False		
End Choose

If Not IsNull(lvs_prescritor) and Trim(lvs_prescritor) <> '' Then
	ps_nm_prescritor = lvs_prescritor
Else
	ps_nm_prescritor = ''
End If	

Return True
end function

public function boolean of_atualiza_tab_ult_geracao (string ps_processo, date pdt_ult_exportacao, long pl_ult_arquivo_exportacao, ref string ps_log);DateTime lvdth_Ult_Exportacao

lvdth_Ult_Exportacao = DateTime(pdt_Ult_Exportacao)

Update controle_exportacao_arquivos
   set dh_ultima_exportacao = :lvdth_Ult_Exportacao,
		nr_ultimo_seq_arquivo = :pl_ult_arquivo_exportacao
Where cd_exportacao = :ps_Processo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_Log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o na tabela de controle_exportacao_arquivos - Processo[" + ps_Processo + "]"
	Return False
End If

Return True
end function

public function boolean of_compacta_arquivos (string ps_diretorio, string ps_destino, ref string ps_file_compactado, ref string ps_log);String 	lvs_Path_Temp,&
	   		lvs_Origem,&
	   		lvs_Destino,&
	   		lvs_Erro
	   
lvs_Path_Temp = ps_diretorio		
		
dc_uo_zip lvo_Zip
lvo_Zip = Create dc_uo_zip

lvs_Origem				= ps_diretorio 	+ "*.*"
ps_file_compactado	= ps_destino 	+ ".ZIP"
lvs_Destino				= ps_diretorio 	+ ps_destino

lvo_Zip.of_Salva_Estrutura( False )
lvo_Zip.of_Zip_Origem( lvs_Origem )
lvo_Zip.of_Zip_Destino( lvs_Destino )
lvs_Erro = lvo_Zip.of_Zip()

If lvs_Erro <> "" Then
	Destroy(lvo_Zip)
	ps_Log += "Erro na compacta$$HEX2$$e700e300$$ENDHEX$$o do arquivo '" + lvs_Erro + "'." 
	Return False
End If

// Verifica se o arquivo zip foi gerado com sucesso
If Not FileExists( lvs_Destino + ".ZIP" ) Then
	ps_Log += "Arquivo ZIP '" + lvs_Destino + "' n$$HEX1$$e300$$ENDHEX$$o localizado ap$$HEX1$$f300$$ENDHEX$$s a compacta$$HEX2$$e700e300$$ENDHEX$$o."
	Destroy( lvo_Zip )
	Return False
End If

Destroy(lvo_Zip)

Return True
end function

public function boolean of_exporta_arquivos_processo_012 (datastore pdw_controle_processo, datastore pdw_dados_receita, integer pi_arquivo, string ps_nm_arquivo, date pdt_periodo_de, date pdt_periodo_ate, ref string ps_log);Boolean lvb_Sucesso = True

Long	lvl_Row, &
		lvl_Filial
		
String	lvs_Tipo_Registro, &
		lvs_UF_Prescritor, &
		lvs_Registro, &
		lvs_Substituido, &
		lvs_Generico, &
		lvs_Nm_Prescritor, &
		lvs_Reg

Open(w_Aguarde)
w_Aguarde.Title = 'Gerando Arquivo de Informa$$HEX2$$e700f500$$ENDHEX$$es Close-UP...'
w_Aguarde.uo_Progress.of_SetMax(pdw_dados_receita.RowCount())

For lvl_row = 1 To pdw_dados_receita.RowCount()

	w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)
	
	lvl_Filial        		= pdw_dados_receita.object.cd_filial             							[lvl_row]
	lvs_Tipo_Registro 	= pdw_dados_receita.object.id_registro_prescritor					[lvl_row]
	lvs_UF_Prescritor 	= pdw_dados_receita.object.cd_uf_prescritor      						[lvl_row]
	lvs_Registro      	= String(long(pdw_dados_receita.object.nr_registro_prescritor	[lvl_row]),'0000000')
	lvs_Substituido   	= pdw_dados_receita.object.id_produto_substituido					[lvl_row]
			
	If This.Of_Verifica_Tipo_Prescritor(	lvs_Tipo_Registro, &
													lvs_Registro, &
													lvs_UF_Prescritor,&
													Ref lvs_Nm_Prescritor, &
													Ref ps_Log) Then
														
		If lvs_Nm_Prescritor = '' Then
//			If Not This.Of_Grava_Arquivo(pi_Arquivo,'FILIAL: ' + String(lvl_Filial,'0000') + ' CR' + lvs_Tipo_Registro + '/' + lvs_Registro + '/' + lvs_UF_Prescritor + ' n$$HEX1$$e300$$ENDHEX$$o encontrado.', ref ps_Log) Then 
//				lvb_Sucesso = False
//				Exit
//			Else
				Continue
//			End If
		End If
	Else
		lvb_Sucesso = False
		Exit
	End If	
																 
	If pdw_dados_receita.object.id_produto_substituido[lvl_row] = 'S' Then
		lvs_Generico = 'S'
	Else
		If pdw_dados_receita.object.id_lei_generico[lvl_row] = 'G' Then
			lvs_Generico = 'G'
		Else
			lvs_Generico = 'M'
		End If	
	End If	
					
	lvs_Reg  = ''
	lvs_Reg += String(pdw_dados_receita.object.cd_cidade[lvl_row],'0000') + ';'    	// cod.cidade 
	lvs_Reg += String(pdw_dados_receita.object.cd_filial [lvl_row],'0000') + ';'   		// cod.filial
	lvs_Reg += String(pdw_dados_receita.object.cd_produto[lvl_row],'000000') + ';'	// cod.interno produto
	lvs_Reg += pdw_dados_receita.object.de_codigo_barras[lvl_row] + ';'				// cod.barras produto
	lvs_Reg += lvs_uf_prescritor                          												// uf prescritor
	lvs_Reg += lvs_registro + ';'                            											// registro prescritor
	lvs_Reg += pdw_dados_receita.object.id_registro_prescritor[lvl_row] + ';' 			// tipo registro
	lvs_Reg += lvs_nm_prescritor + ';'						                     					// nome prescritor
	lvs_Reg += '00000' + ';'															   				// cod.instituicao
	lvs_Reg += String(pdw_dados_receita.object.nr_nf[lvl_row],'0000000') + ';'     	// nr.cupom fiscal
	lvs_Reg += pdw_dados_receita.object.dia[lvl_row] + ';'   								// dia
	lvs_Reg += pdw_dados_receita.object.mes[lvl_row] + ';'       							// mes
	lvs_Reg += pdw_dados_receita.object.ano[lvl_row] + ';'  								// ano
	lvs_Reg += String(pdw_dados_receita.object.qt_vendida[lvl_row],'000000') + ';' 	// quantidade		
	lvs_Reg += pdw_dados_receita.object.de_produto[lvl_row] + ';'                 	 	// descricao apresentacao produto
	lvs_Reg += FillA('0',30) + ';' 																	// instituicao
	lvs_Reg += FillA('0',30) + ';'																		// laboratorio
	lvs_Reg += lvs_generico
	
	If Not This.Of_Grava_Arquivo(pi_Arquivo, lvs_Reg, ref ps_Log) Then
		lvb_Sucesso = False
		Exit
	End If
	
Next	

FileClose(pi_Arquivo)
Close(w_Aguarde)

Return lvb_Sucesso
end function

public function string of_formata_campo (string ps_processo, string ps_valor, string ps_tipo_campo, long pl_tamanho);string ls_retorno
long ll_len, ll_pos

//Formata os campos de acordo com o processo
Choose Case ps_processo
		
	Case '013', '014', '015', '016', '017', '018', '019', '020', '021' //IQVA
		
		if ps_tipo_campo = 'A' then //Alfanumerico
			//Campos alfanum$$HEX1$$e900$$ENDHEX$$ricos dever$$HEX1$$e300$$ENDHEX$$o ser alinhados $$HEX1$$e000$$ENDHEX$$ esquerda com brancos $$HEX1$$e000$$ENDHEX$$ direita, totalizando o tamanho definido para eles.
			// Idealmente, conv$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o enviar conte$$HEX1$$fa00$$ENDHEX$$dos com aspas duplas ($$HEX1$$1c20$$ENDHEX$$).
			
			if isnull(ps_valor) Then ps_valor = ''
			
			//Retirar aspas
			ps_valor = gf_replace(ps_valor,'"','',0)
			
			ll_len = len(ps_valor)
			
			//Trunca a informa$$HEX2$$e700e300$$ENDHEX$$o se a quantidade de caracteres ultrapassar a configurada no arquivo.
			if ll_len > pl_tamanho Then
				ps_valor = Mid(ps_valor, 1, pl_tamanho)
			end if
			
			ls_retorno = ps_valor + fill(' ', pl_tamanho - ll_len)
			
		elseif ps_tipo_campo = 'N' then //Numerico (Inteiro)
			//Campos num$$HEX1$$e900$$ENDHEX$$ricos (exceto campos que representem moedas) dever$$HEX1$$e300$$ENDHEX$$o ser alinhados $$HEX1$$e000$$ENDHEX$$ direita com zeros $$HEX1$$e000$$ENDHEX$$ esquerda, totalizando o tamanho definido para eles.
			
			if isnull(ps_valor) Then ps_valor = '0'
			
			ll_len = len(ps_valor)
			ls_retorno = fill('0', pl_tamanho - ll_len) + ps_valor
			
		elseif ps_tipo_campo = 'D' then //Data
			//Campos de data dever$$HEX1$$e300$$ENDHEX$$o ser alinhados $$HEX1$$e000$$ENDHEX$$ direita e possu$$HEX1$$ed00$$ENDHEX$$rem o formato AAAAMMDD onde AAAA $$HEX1$$e900$$ENDHEX$$ o ano, MM $$HEX1$$e900$$ENDHEX$$ o m$$HEX1$$ea00$$ENDHEX$$s e DD $$HEX1$$e900$$ENDHEX$$ o dia
			
			ls_retorno = String( ps_valor, 'yyyymmdd' )
			
		elseif ps_tipo_campo = 'M' then //Moeda (Decimal)
			//Campos do tipo moeda dever$$HEX1$$e300$$ENDHEX$$o ser, assim como os campos num$$HEX1$$e900$$ENDHEX$$ricos, alinhados $$HEX1$$e000$$ENDHEX$$ direita com zeros $$HEX1$$e000$$ENDHEX$$ esquerda, totalizando o tamanho definido para eles, mas tamb$$HEX1$$e900$$ENDHEX$$m dever$$HEX1$$e300$$ENDHEX$$o
			//considerar as seguintes regras: (1) seus dois $$HEX1$$fa00$$ENDHEX$$ltimos d$$HEX1$$ed00$$ENDHEX$$gitos devem representar os centavos e (2) dever$$HEX1$$e300$$ENDHEX$$o omitir os caracteres separadores de decimais e de milhares
			
			if isnull(ps_valor) Then ps_valor = '0,00'
			
			ll_pos = pos(ps_valor, ',')
			//Verifica se deve acrescentar zeros a direita
			if ll_pos > 0 Then
				ll_len = len( mid(ps_valor, ll_pos + 1 ) )
			
				if ll_len = 1 Then
					ps_valor = ps_valor + '0'
				elseif ll_len = 0 Then
					ps_valor = ps_valor + '00'
				end if
			else
				ps_valor = ps_valor + '00'
			end if
			
			ps_valor = gf_replace( ps_valor, ',', '',0 )
			ps_valor = gf_replace( ps_valor, '.', '',0 )
			
			ll_len = len(ps_valor)
			ls_retorno = fill('0', pl_tamanho - ll_len) + ps_valor
			
		End if
		
End Choose

return ls_retorno
end function

public function boolean of_atualiza_controle_exportacao (date pdt_movimento, datetime pdh_inicio, ref string ps_log);string ls_nr_id

select NewId(1)
into :ls_nr_id
from parametro;

insert into controle_export_arq_periodo(nr_id, cd_exportacao, dh_movimento, dh_geracao_inicio, dh_geracao_termino)
values( :ls_nr_id, :is_processo, :pdt_movimento, :pdh_inicio, getdate() )
Using SQLCA;

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_controle_exportacao' + '~nProblemas ao inserir registro na tabela "controle_export_arq_periodo": ~n' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_exporta_iqva_venda (date pdt_data, ref string ps_log);long ll_linhas, ll_linhas2
long ll_for, ll_for2
long ll_cd_filial
long ll_total_registros=0
long ll_cd_produto
Long ll_tamanhoEan

integer li_arquivo

decimal{2} ldc_preco_liquido, ldc_preco_bruto

string ls_nome_arquivo
string ls_nome_arquivo_ext
string ls_nome_arquivo_completo
string ls_ZIP
string ls_cabecalho
string ls_item
string ls_rodape
string ls_ean1
string ls_ean2
string ls_de_produto
string ls_cnpj_filial
string ls_processo
string ls_quantidade
string ls_dh_transacao

datetime ldh_inicio

boolean lb_sucesso=false

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_item

Try
	
	if not isvalid(w_aguarde_3) Then Open(w_aguarde_3)
	
	w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Venda - Data: ' + String(pdt_data,'dd/mm/yyyy')
	
	ls_processo = '013'
	
	ldh_inicio = gf_getserverdate()
	
	lds_filiais = create dc_uo_ds_base
	lds_item = create dc_uo_ds_base
	
	lds_filiais.of_changedataobject( 'ds_ge513_nf_venda_filial')
	lds_item.of_changedataobject( 'ds_ge513_nf_venda_produto')
	
	ll_linhas = lds_filiais.retrieve(pdt_data)
	
	If ll_linhas < 0 Then
		ps_log = 'Erro ao buscar as filiais. Datawindow: ds_ge513_nf_venda_filial'
		return false
	end if
	
	If ll_linhas > 0 Then
	
		w_aguarde_3.wf_settext('Gerando o nome do Arquivo' , 1)
		
		//Monta o nome do arquivo
		ls_nome_arquivo = 'CPP'
		ls_nome_arquivo += '_'
		ls_nome_arquivo += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 6 ) 
		ls_nome_arquivo += '_'
		ls_nome_arquivo += String( date(idt_atual ), 'yyyymmdd')
		ls_nome_arquivo += '_'
		ls_nome_arquivo += String( idt_atual, 'hhmmss' )
		
		ls_nome_arquivo_ext = ls_nome_arquivo + '.txt'
		ls_nome_arquivo_completo = ivs_Path_Exportacao + ls_nome_arquivo_ext
		
		w_aguarde_3.wf_settext('Criando o arquivo' , 1)
		if Not this.of_abre_arquivo( ls_nome_arquivo_completo, ref li_arquivo, ref ps_log ) Then return false
		
		w_aguarde_3.wf_settext('Gerando o cabe$$HEX1$$e700$$ENDHEX$$alho do arquivo' , 1)
		//Monta o cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
		ls_cabecalho = 'H'
		ls_cabecalho += this.of_formata_campo( ls_processo, is_cnpj_clamed, 'N', 15 ) 
		ls_cabecalho += this.of_formata_campo( ls_processo, is_razao_social, 'A', 80 ) 
		ls_cabecalho += String( date(idt_atual ), 'yyyymmdd')
		
		if len(ls_cabecalho) <> 104 then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva_venda; Problemas ao validar a estrutura do arquivo: Linha de cabe$$HEX1$$e700$$ENDHEX$$alho gerada de tamanho inv$$HEX1$$e100$$ENDHEX$$lido.'
			return false
		end if
		
		if Not this.of_grava_arquivo( li_arquivo, ls_cabecalho, ref ps_log ) then return false
		ll_total_registros++
		
		w_aguarde_3.uo_progress.of_setmax(ll_linhas)
		
		w_aguarde_3.wf_settext('Criando o arquivo' , 1)
		
		for ll_for = 1 to ll_linhas
			
			ll_cd_filial = lds_filiais.object.cd_filial[ll_for]
			ls_cnpj_filial = lds_filiais.object.nr_cgc[ll_for]
		
			w_aguarde_3.wf_settext('Gerando os itens do arquivo' , 1)
			w_aguarde_3.wf_settext('Filial: ' + string(ll_cd_filial) + ' (' + string(ll_for) + ' de ' + string(ll_linhas) + ')', 2)
			
			ll_linhas2 = lds_item.retrieve(pdt_data, ll_cd_filial)
			
			if ll_linhas2 = 0 then 
				w_aguarde_3.uo_progress.of_setprogress(ll_for)
				Continue
			elseif ll_linhas2 < 0 Then
				ps_log = 'Erro ao buscar os itens. Datawindow: ds_ge513_nf_venda_produto'
				return false
			end if
			
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas2)
			
			for ll_for2 = 1 to ll_linhas2
				
				ll_cd_produto = lds_item.object.cd_produto[ll_for2]
				ls_de_produto = lds_item.object.de_produto[ll_for2]
				ls_ean1 = lds_item.object.ean1[ll_for2]
				
				//Chamado 1730304 - EAN inexistente na base NDF, chama a fun$$HEX2$$e700e300$$ENDHEX$$o para tratar os casos de ens com mais de 14 digitos
				If  lenA(ls_ean1) >= 14  then
					This.of_corrige_ean( ll_cd_produto, Ref ls_ean1)	
				End If				
		
				w_aguarde_3.wf_settext('Produto: ' + string(ll_cd_produto) + ' (' + string(ll_for2) + ' de ' + string(ll_linhas2) + ')', 3)
				
				ldc_preco_liquido = lds_item.object.vl_liquido[ll_for2]
				ldc_preco_bruto = lds_item.object.vl_preco_bruto[ll_for2]
				ls_quantidade = String( lds_item.object.qt_vendida[ll_for2] )
				ls_dh_transacao = string( date(lds_item.object.dh_transacao[ll_for2] ), 'yyyymmdd')
				
				//Caso n$$HEX1$$e300$$ENDHEX$$o possua EAN informar c$$HEX1$$f300$$ENDHEX$$digo do produto
				If IsNull(ls_ean1) Then
					ls_ean1 = String(ll_cd_produto)
				End If
				
				//Busca o EAN2
                  SetNull(ls_ean2)
				select top 1 cb.de_codigo_barras
				into :ls_ean2
				from codigo_barras_produto cb
				where cb.cd_produto = :ll_cd_produto
				and cb.id_principal = 'N';
			
				//chamado 	1396288 (BUG: Quando o produto n$$HEX1$$e300$$ENDHEX$$o havia EAN secundario trazia o $$HEX1$$fa00$$ENDHEX$$ltimo ls_ean2 Carregado) 			
				Choose Case SQLCA.SQLCode
								
					Case 0
				
					If  lenA(ls_ean2) >= 14 then
						ls_ean2 = ls_ean1
					End If 
					
					Case 100 
                        ls_ean2 = ls_ean1
								
					Case -1 //Erro
						ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva_venda' + '~nProblemas ao consultar a tabela "codigo_barras_produto": ~n' + sqlca.sqlerrtext
						return false
						
				End Choose
				
				ls_item = 'D'
				ls_item += this.of_formata_campo( ls_processo, ls_ean1, 'A', 13 ) 
				ls_item += this.of_formata_campo( ls_processo, ls_ean2, 'A', 13 ) 
				ls_item += this.of_formata_campo( ls_processo, ls_de_produto, 'A', 80 ) 
				ls_item += this.of_formata_campo( ls_processo, ls_cnpj_filial, 'A', 60 ) 
				ls_item += this.of_formata_campo( ls_processo, string(ldc_preco_liquido), 'M', 18 ) 
				ls_item += this.of_formata_campo( ls_processo, string(ldc_preco_bruto), 'M', 18 ) 
				ls_item += this.of_formata_campo( ls_processo, ls_quantidade, 'N', 15 ) 
				ls_item += ls_dh_transacao
				
				ll_total_registros++
				
				if len(ls_item) <> 226 then
					ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva_venda; Problemas ao validar a estrutura do arquivo: Linha de detalhe gerada de tamanho inv$$HEX1$$e100$$ENDHEX$$lido.'
					return false
				end if
				
				this.of_grava_arquivo( li_arquivo, ls_item, ref ps_log )
				
				w_aguarde_3.uo_progress_2.of_setprogress(ll_for2)
				
			next
			
			w_aguarde_3.uo_progress.of_setprogress(ll_for)
			
		next
	
	End if
	
	if li_arquivo > 0 then
		
		w_aguarde_3.wf_settext('Gerando rodap$$HEX1$$e900$$ENDHEX$$ do arquivo' , 1)

		//Monta o rodap$$HEX1$$e900$$ENDHEX$$ do Arquivo
		ls_rodape = 'T'
		ll_total_registros++
		ls_rodape += this.of_formata_campo( ls_processo, string(ll_total_registros), 'N', 15 ) 
	
		if len(ls_rodape) <> 16 then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva_venda; Problemas ao validar a estrutura do arquivo: Linha de rodap$$HEX1$$e900$$ENDHEX$$ gerada de tamanho inv$$HEX1$$e100$$ENDHEX$$lido.'
			return false
		end if
	
		if Not this.of_grava_arquivo( li_arquivo, ls_rodape, ref ps_log ) then return false
	
		FileClose(li_Arquivo)
		
		w_aguarde_3.wf_settext('Enviando arquivo via FTP' , 1)
		if Not this.of_envia_arquivo( ls_nome_arquivo_completo, ls_nome_arquivo_ext, ls_nome_arquivo, ref ps_log ) then return false
			
	end if

	w_aguarde_3.wf_settext('Atualizando controle de exporta$$HEX2$$e700e300$$ENDHEX$$o - Finalizando' , 1)
	if Not this.of_atualiza_tab_ult_geracao( is_processo, date(idt_atual), 0, ref ps_log ) then return false
	
	if Not this.of_atualiza_controle_exportacao( pdt_data, ldh_inicio, ref ps_log ) then return false
	
	lb_sucesso = true

Finally
	
	if lb_sucesso = false then
		SQLCA.of_rollback( )
		
		if li_arquivo > 0 then
			FileClose(li_Arquivo)		
		end if
		
	else
		SQLCA.of_commit( )
	end if
	
	if isvalid(w_aguarde_3) then Close(w_aguarde_3)
	
	Destroy(lds_filiais)
	Destroy(lds_item)
	
End Try

return true
end function

public function boolean of_exporta_iqva (string ps_cd_processo, date pdt_data_exportacao_manual, ref string ps_log);datetime ldt_ult_mov
date ldt_prox_mov
boolean lb_sucesso = false
boolean lb_exportacao_manual = false
dc_uo_ds_base lds_Controle

Try
	
	is_processo = ps_cd_processo
	
	idt_atual = gf_getserverdate()
	
	lds_Controle = Create dc_uo_ds_base
	lds_Controle.of_ChangeDataObject('ds_ge513_config_ftp_industria')
	
	if lds_Controle.Retrieve(ps_cd_Processo) < 0 Then
		ps_log = 'Erro ao consultar a seguinte datawindow: ds_ge513_config_ftp_industria'
		return false
	end if
	
	If lds_Controle.RowCount() = 0 Then
		ps_Log = "N$$HEX1$$e300$$ENDHEX$$o existe informa$$HEX2$$e700f500$$ENDHEX$$es de controle [tab:controle_exportacoes_arquivos] para o processo:[" + ps_cd_Processo + "]"
		Destroy(lds_Controle)
		Return False
	End If
	
	ldt_ult_mov				= lds_Controle.object.dh_ultima_exportacao	[1]
	is_Server_FTP			= lds_Controle.Object.De_Endereco_FTP			[1]
	is_Usuario_FTP			= lds_Controle.Object.De_Usuario_FTP			[1]
	is_Senha_FTP			= lds_Controle.Object.De_Senha_FTP				[1]
	is_envia_arquivo_ftp	= lds_Controle.Object.id_envia_arquivo_ftp	[1]
	is_protocolo_sftp		= lds_Controle.Object.id_protocolo_sftp		[1]
	
	if isnull(pdt_data_exportacao_manual) Then
	
		//Busca a data da ultima exporta$$HEX2$$e700e300$$ENDHEX$$o
		if isnull(ldt_ult_mov) or String(ldt_ult_mov,'dd/mm/yyyy') = '01/01/1900' then
			//Se $$HEX1$$e900$$ENDHEX$$ a primeira exporta$$HEX2$$e700e300$$ENDHEX$$o, usa a data de ontem
			ldt_prox_mov = relativedate(date(idt_atual),-1)
		else
		
			Select max(dh_movimento)
			into :ldt_prox_mov
			from controle_export_arq_periodo
			where cd_exportacao = :ps_cd_processo
			Using SQLCA;
			
			If SQLCA.sqlcode = -1 then
				ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva' + '~nProblemas ao consultar a tabela "controle_export_arq_periodo" : ~n' + sqlca.sqlerrtext
				return false
			end if
			
			//Se j$$HEX1$$e100$$ENDHEX$$ exportou a data de ontem encerra o processo
			if ldt_prox_mov = relativedate(date(idt_atual),-1) Then Return True
			
			//Adiciona 1 dia
			ldt_prox_mov = relativedate(ldt_prox_mov,1)
			
		end if
	
	else
		ldt_prox_mov = pdt_data_exportacao_manual
		lb_exportacao_manual = true
		
		If Not This.of_Cria_Diretorios(ps_cd_Processo, Ref ps_Log) Then Return False
		
	end if
	
	Select f.nr_cgc, f.nm_razao_social , c.cd_unidade_federacao as UF_Rede
	into :is_cnpj_clamed, :is_razao_social ,  :is_uf_rede
	from filial f 
	inner join cidade c on c.cd_cidade  = f.cd_cidade 
	where cd_filial = 2
	Using SQLCA;
	
	If SQLCA.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva' + '~nProblemas ao consultar a tabela "filial" : ~n' + sqlca.sqlerrtext
		return false
	end if
	
	//Entra em loop para gerar um arquivo por dia. Do $$HEX1$$fa00$$ENDHEX$$ltimo dia gerado at$$HEX1$$e900$$ENDHEX$$ ontem.
	Do
		
		Choose Case ps_cd_processo
				
			Case '013' //Venda
				if Not this.of_exporta_iqva_venda( ldt_prox_mov, ref ps_log ) then return false
				
			Case '014' //Compra
				if Not this.of_exporta_iqva_compra( ldt_prox_mov, ref ps_log ) then return false
			
			Case '015' //Ticket
				if Not this.of_exporta_iqva_ticket( ldt_prox_mov, ref ps_log ) then return false
			
			Case '016' //Estoque (CD)
				if Not this.of_exporta_iqva_estoque( ldt_prox_mov, 'CD', ref ps_log ) then return false
				
			Case '017' //Estoque (Loja)
				if Not this.of_exporta_iqva_estoque( ldt_prox_mov, 'PDV', ref ps_log ) then return false
			
			Case '018' //Pedido (CD)
				if Not this.of_exporta_iqva_pedido( ldt_prox_mov, 'CD', ref ps_log ) then return false
			
			Case '019' //Pedido (Loja)
				if Not this.of_exporta_iqva_pedido( ldt_prox_mov, 'PDV', ref ps_log ) then return false
			
			Case '020' //Entrada (CD)
				if Not this.of_exporta_iqva_entrada( ldt_prox_mov, 'CD', ref ps_log ) then return false
			
			Case '021' //Entrada (Loja)
				if Not this.of_exporta_iqva_entrada( ldt_prox_mov, 'PDV', ref ps_log ) then return false
			
		End Choose
		
		if lb_exportacao_manual = True Then
			EXIT
		End if
		
		//Faz a exporta$$HEX2$$e700e300$$ENDHEX$$o para o proximo dia at$$HEX1$$e900$$ENDHEX$$ chegar a data de ontem
		if ldt_prox_mov = relativedate(date(idt_atual),-1) Then 
			EXIT
		Else
			ldt_prox_mov = relativedate(ldt_prox_mov,1)
			
			//Acrescento 1 segundo na data atual para n$$HEX1$$e300$$ENDHEX$$o correr o risco de gerar dois arquivos com o mesmo nome no processo de Venda.
			idt_atual = Datetime( date(idt_atual) , relativetime( time(idt_atual), 1) )
			
		end if
		
	Loop While True
	
	lb_sucesso = true
	
Finally
	
//	if lb_sucesso = false then
//		If Not gvb_Exp_Auto Then
//			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log )
//		End If
//	end if
	destroy(lds_controle)
	
End Try

return true
end function

public function boolean of_exporta_iqva (string ps_cd_processo, ref string ps_log);date ldt_nula

setnull(ldt_nula)

return this.of_exporta_iqva( ps_cd_processo, ldt_nula, ref ps_log )

end function

public function boolean of_exporta_iqva_compra (date pdt_data, ref string ps_log);long ll_linhas, ll_linhas2
long ll_for, ll_for2
long ll_cd_filial
long ll_total_registros=0
long ll_cd_produto
long ll_qt_faturada
long ll_total_faturada

integer li_arquivo

decimal{2} ldc_preco
decimal{2} ldc_icms
decimal{2} ldc_vl_icms
decimal{2} ldc_desconto
decimal{2} ldc_vl_desconto
decimal{2} ldc_vl_total_icms=0
decimal{2} ldc_vl_total_desconto=0

string ls_processo
string ls_nome_arquivo
string ls_nome_arquivo_ext
string ls_nome_arquivo_completo
String ls_nome_arquivo_zip
string ls_ZIP
string ls_cabecalho
string ls_item
string ls_rodape
string ls_cd_produto
string ls_cnpj_fornecedor
string ls_nr_nf
string ls_flag
string ls_quantidade
string ls_dh_transacao
string ls_UF_Fornecedor, ls_UF_Loja

datetime ldh_inicio

boolean lb_sucesso=false

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_item

Try
	
	if not isvalid(w_aguarde_3) Then Open(w_aguarde_3)
	
	w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Compra - Data: ' + String(pdt_data,'dd/mm/yyyy')
	
	ls_processo = '014'
	
	ldh_inicio = gf_getserverdate()
	
	lds_filiais = create dc_uo_ds_base
	lds_item = create dc_uo_ds_base
	
	lds_filiais.of_changedataobject( 'ds_ge513_nf_compra_filial')
	lds_item.of_changedataobject( 'ds_ge513_nf_compra_produto')
	
	ll_linhas = lds_filiais.retrieve(pdt_data)
	
	If ll_linhas < 0 Then
		ps_log = 'Erro ao buscar as filiais. Datawindow: ds_ge513_nf_compra_filial'
		return false
	end if
	
	if ll_linhas > 0 then
		
		w_aguarde_3.wf_settext('Gerando o nome do Arquivo' , 1)
		
		//Monta o nome do arquivo
		ls_nome_arquivo = 'B'
		ls_nome_arquivo += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 ) 
		ls_nome_arquivo += 'M'
		ls_nome_arquivo += String( date(pdt_data), 'mm')
		
		ls_nome_arquivo_zip = ls_nome_arquivo + 'D' + String( date(pdt_data), 'dd' )
		
		ls_nome_arquivo_ext = ls_nome_arquivo + '.D' + String( date(pdt_data), 'dd' )
		ls_nome_arquivo_completo = ivs_Path_Exportacao + ls_nome_arquivo_ext
		
		w_aguarde_3.wf_settext('Criando o arquivo' , 1)
		if Not this.of_abre_arquivo( ls_nome_arquivo_completo, ref li_arquivo, ref ps_log ) Then return false
		
		w_aguarde_3.wf_settext('Gerando o cabe$$HEX1$$e700$$ENDHEX$$alho do arquivo' , 1)
		//Monta o cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
		ls_cabecalho = '1'
		ls_cabecalho += 'C'
		ls_cabecalho += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 ) 
		ls_cabecalho += this.of_formata_campo( ls_processo, is_razao_social, 'A', 30 ) 
		ls_cabecalho += this.of_formata_campo( ls_processo, is_cnpj_clamed, 'N', 14 ) 
		ls_cabecalho += String( date(pdt_data ), 'ddmmyyyy')
		ls_cabecalho += String( date(pdt_data ), 'ddmmyyyy')
		ls_cabecalho += String( date(idt_atual ), 'ddmmyyyy')
		ls_cabecalho += '1'
		ls_cabecalho += this.of_formata_campo( ls_processo, ' ', 'A', 17 ) 
		ls_cabecalho += this.of_formata_campo( ls_processo, 'imsbrcmp1', 'A', 9 )
		
		if len(ls_cabecalho) <> 101 then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva_compra; Problemas ao validar a estrutura do arquivo: Linha de cabe$$HEX1$$e700$$ENDHEX$$alho gerada de tamanho inv$$HEX1$$e100$$ENDHEX$$lido.'
			return false
		end if
		
		ll_total_registros++
		if Not this.of_grava_arquivo( li_arquivo, ls_cabecalho, ref ps_log ) then return false
		
		w_aguarde_3.uo_progress.of_setmax(ll_linhas)
		
		w_aguarde_3.wf_settext('Criando o arquivo' , 1)
		
		for ll_for = 1 to ll_linhas
			
			ll_cd_filial = lds_filiais.object.cd_filial[ll_for]
		
			w_aguarde_3.wf_settext('Gerando os itens do arquivo' , 1)
			w_aguarde_3.wf_settext('Filial: ' + string(ll_cd_filial) + ' (' + string(ll_for) + ' de ' + string(ll_linhas) + ')', 2)
			
			ll_linhas2 = lds_item.retrieve(pdt_data, ll_cd_filial)
			
			if ll_linhas2 = 0 then
				w_aguarde_3.uo_progress.of_setprogress(ll_for)
				Continue
			
			elseif ll_linhas2 < 0 Then
				ps_log = 'Erro ao buscar os itens. Datawindow: ds_ge513_nf_compra_produto'
				return false
			end if
			
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas2)
			
			for ll_for2 = 1 to ll_linhas2
				
				ls_cd_produto = String(lds_item.object.cd_produto[ll_for2])
				
				w_aguarde_3.wf_settext('Produto: ' + ls_cd_produto + ' (' + string(ll_for2) + ' de ' + string(ll_linhas2) + ')', 3)
							
				ldc_preco				= lds_item.object.vl_preco_unitario	[ll_for2]
				ldc_icms					= lds_item.object.pc_icms				[ll_for2]
				ldc_vl_icms				= lds_item.object.vl_icms				[ll_for2]
				ldc_desconto			= lds_item.object.pc_desconto			[ll_for2]
				ldc_vl_desconto		= lds_item.object.vl_desconto			[ll_for2]
				ls_nr_nf					= String( lds_item.object.nr_nf		[ll_for2] )
				ll_qt_faturada			= lds_item.object.qt_faturada			[ll_for2] 
				ls_dh_transacao		= string( date(lds_item.object.dh_movimentacao_caixa[ll_for2] ), 'ddmmyyyy')
				ls_cnpj_fornecedor	= lds_item.object.nr_cgc				[ll_for2]
				ls_UF_Fornecedor		= lds_item.object.uf_fornecedor	[ll_for2] 
				ls_UF_Loja				= lds_item.object.uf_loja				[ll_for2] 
				ls_flag					= lds_item.object.flag					[ll_for2]					
				
				// Chamado 1247753
				If ls_flag  = '2' Then // CST: 06
				   If is_uf_rede  =	ls_UF_Fornecedor Then 
						ls_flag = '2'
				   Else
						ls_flag = '3'
					End If 
				End If 

				If ldc_desconto = 100.00 Then
					ldc_desconto = 99.99
				End if				
				
				ls_quantidade = string(ll_qt_faturada)
				ll_total_faturada = ll_total_faturada + ll_qt_faturada
				
				if ls_flag = '2' or ls_flag = '3' then
					ldc_icms = 0
					ldc_vl_icms = 0
				end if
				
				ldc_vl_total_icms = ldc_vl_total_icms + ldc_vl_icms
				ldc_vl_total_desconto = ldc_vl_total_desconto + ldc_vl_desconto
				
				//Monta linha do produto
				ls_item = '2'
				ls_item += '00'
				ls_item += '001'
				ls_item += '1'
				ls_item += '0'
				ls_item += ls_dh_transacao
				ls_item += this.of_formata_campo( ls_processo, ls_cnpj_fornecedor, 'N', 14 ) 
				ls_item += ls_flag
				ls_item += this.of_formata_campo( ls_processo, ls_nr_nf, 'N', 9 ) 
				ls_item += this.of_formata_campo( ls_processo, ls_cd_produto, 'N', 13 ) 
				ls_item += '1'
				ls_item += this.of_formata_campo( ls_processo, ls_quantidade, 'N', 8 ) 
				ls_item += this.of_formata_campo( ls_processo, string(ldc_preco), 'M', 10 ) 
				ls_item += this.of_formata_campo( ls_processo, string(ldc_icms), 'M', 4 ) 
				ls_item += this.of_formata_campo( ls_processo, string(ldc_vl_icms), 'M', 10 ) 
				ls_item += this.of_formata_campo( ls_processo, string(ldc_desconto), 'M', 4 ) 
				ls_item += this.of_formata_campo( ls_processo, string(ldc_vl_desconto), 'M', 10 ) 
				ls_item += 'C'
				
				ll_total_registros++
				
				if len(ls_item) <> 101 then
					ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva_compra; Problemas ao validar a estrutura do arquivo: Linha de detalhe gerada de tamanho inv$$HEX1$$e100$$ENDHEX$$lido.'
					return false
				end if
				
				if Not this.of_grava_arquivo( li_arquivo, ls_item, ref ps_log ) Then return false
				
				w_aguarde_3.uo_progress_2.of_setprogress(ll_for2)
				
			next
			
			w_aguarde_3.uo_progress.of_setprogress(ll_for)
			
		next

	End if
	
	if li_arquivo > 0 then
		
		w_aguarde_3.wf_settext('Gerando rodap$$HEX1$$e900$$ENDHEX$$ do arquivo' , 1)
	
		ll_total_registros++
		
		//Monta o rodap$$HEX1$$e900$$ENDHEX$$ do Arquivo
		ls_rodape = '3'
		ls_rodape += '0'
		ls_rodape += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 ) 
		ls_rodape += this.of_formata_campo( ls_processo, string(ll_total_registros), 'N', 8 ) 
		ls_rodape += this.of_formata_campo( ls_processo, string(ll_total_faturada), 'N', 10 ) 
		// ls_rodape += this.of_formata_campo( ls_processo, string(ll_total_registros - 2), 'N', 10 ) 
		ls_rodape += this.of_formata_campo( ls_processo, string(ldc_vl_total_icms), 'M', 12 ) 
		ls_rodape += this.of_formata_campo( ls_processo, string(ldc_vl_total_desconto), 'M', 12 ) 
		ls_rodape += this.of_formata_campo( ls_processo, ' ', 'A', 44 ) 
		ls_rodape += this.of_formata_campo( ls_processo, 'imsbrcmp3', 'A', 9 )
	
		if len(ls_rodape) <> 101 then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva_compra; Problemas ao validar a estrutura do arquivo: Linha de rodap$$HEX1$$e900$$ENDHEX$$ gerada de tamanho inv$$HEX1$$e100$$ENDHEX$$lido.'
			return false
		end if
	
		if Not this.of_grava_arquivo( li_arquivo, ls_rodape, ref ps_log ) then return false
	
		FileClose(li_Arquivo)
		
		w_aguarde_3.wf_settext('Enviando arquivo via FTP' , 1)
		if Not this.of_envia_arquivo( ls_nome_arquivo_completo, ls_nome_arquivo_ext, ls_nome_arquivo_zip, ref ps_log ) then return false
			
	end if

	w_aguarde_3.wf_settext('Atualizando controle de exporta$$HEX2$$e700e300$$ENDHEX$$o - Finalizando' , 1)
	if Not this.of_atualiza_tab_ult_geracao( is_processo, date(idt_atual), 0, ref ps_log ) then return false

	if Not this.of_atualiza_controle_exportacao( pdt_data, ldh_inicio, ref ps_log ) then return false

	lb_sucesso = true

Finally
	
	if lb_sucesso = false then
		SQLCA.of_rollback( )
		
		if li_arquivo > 0 then
			FileClose(li_Arquivo)		
		end if
		
	else
		SQLCA.of_commit( )
	end if
	
	if isvalid(w_aguarde_3) then Close(w_aguarde_3)
	
	Destroy(lds_filiais)
	Destroy(lds_item)
	
End Try

return true
end function

public function boolean of_exporta_iqva_ticket (date pdt_data, ref string ps_log);long ll_linhas, ll_linhas2
long ll_for, ll_for2
long ll_cd_filial
long ll_sequencial
long ll_nr_nf
long ll_for3
long ll_linhas3
long ll_cd_convenio_pbm
long ll_cd_promocao
long ll_cd_convenio
long ll_qt_total
long ll_qt_produto

integer li_arquivo

String ls_nome_arquivo
String ls_nome_arquivo_zip
String ls_nome_arquivo_ext
String ls_nome_arquivo_completo
String ls_processo
String ls_item
String ls_cd_caixa
String ls_canal_venda
String ls_ticket
String ls_serie
String ls_de_especie
String ls_danfe
String ls_cnpj_filial
String ls_tipo_venda
String ls_tipo_pagamento
String ls_ean
String ls_cd_produto
String ls_de_produto
String ls_tipo_desconto
String ls_desconto
String ls_data 
String ls_nr_comprovante_venda
String ls_id_pbm
String ls_id_tipo_promocao

decimal{2} ldc_vl_bruto
decimal{2} ldc_vl_liquido
decimal{2} ldc_vl_desconto
decimal{2} ldc_vl_bruto_prod
decimal{2} ldc_vl_liquido_prod
decimal{2} ldc_vl_desconto_prod
decimal{2} ldc_vl_pago_avista

datetime ldh_inicio
datetime ldh_movimento

boolean lb_sucesso=false

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_item
dc_uo_ds_base lds_notas

Try
	
	if not isvalid(w_aguarde_3) Then Open(w_aguarde_3)
	
	w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Ticket - Data: ' + String(pdt_data,'dd/mm/yyyy')
	
	ls_processo = '015'
	
	ldh_inicio = gf_getserverdate()
	
	lds_filiais = create dc_uo_ds_base
	lds_item = create dc_uo_ds_base
	lds_notas = create dc_uo_ds_base
	
	lds_filiais.of_changedataobject( 'ds_ge513_ticket_filial')
	lds_item.of_changedataobject( 'ds_ge513_ticket_produto')
	lds_notas.of_changedataobject( 'ds_ge513_ticket')
	
	ll_linhas = lds_filiais.retrieve(pdt_data)
	
	If ll_linhas < 0 Then
		ps_log = 'Erro ao buscar as filiais. Datawindow: ds_ge513_ticket_filial'
		return false
	end if
	
	if ll_linhas > 0 then
		
		w_aguarde_3.wf_settext('Gerando o nome do Arquivo' , 1)
		
		//Monta o nome do arquivo
		ls_nome_arquivo = 'T'
		ls_nome_arquivo += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 ) 
		ls_nome_arquivo += 'Y'
		ls_nome_arquivo += String( date(pdt_data), 'yyyy')
		ls_nome_arquivo += 'M'
		ls_nome_arquivo += String( date(pdt_data), 'mm')
		
		ls_nome_arquivo_zip = ls_nome_arquivo + 'D' + String( date(pdt_data), 'dd' )
		
		ls_nome_arquivo_ext = ls_nome_arquivo + '.D' + String( date(pdt_data), 'dd' )
		ls_nome_arquivo_completo = ivs_Path_Exportacao + ls_nome_arquivo_ext
		
		w_aguarde_3.wf_settext('Criando o arquivo' , 1)
		if Not this.of_abre_arquivo( ls_nome_arquivo_completo, ref li_arquivo, ref ps_log ) Then return false
	
		w_aguarde_3.uo_progress.of_setmax(ll_linhas)
		
		//Filiais
		for ll_for = 1 to ll_linhas
			
			ll_cd_filial = lds_filiais.object.cd_filial[ll_for]
			ls_cnpj_filial = lds_filiais.object.nr_cgc[ll_for]
			
			w_aguarde_3.wf_settext('Gerando os itens do arquivo' , 1)
			w_aguarde_3.wf_settext('Filial: ' + string(ll_cd_filial) + ' (' + string(ll_for) + ' de ' + string(ll_linhas) + ')', 2)
			
			//Carrega as vendas da filial
			ll_linhas2 = lds_notas.retrieve(pdt_data, ll_cd_filial)
			
			if ll_linhas2 = 0 then
				w_aguarde_3.uo_progress.of_setprogress(ll_for)
				Continue
			
			elseif ll_linhas2 < 0 Then
				ps_log = 'Erro ao buscar os itens. Datawindow: ds_ge513_ticket'
				return false
			end if
			
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas2)
			
			//Vendas
			for ll_for2 = 1 to ll_linhas2
				
				ll_nr_nf = lds_notas.object.nr_nf[ll_for2]
				ls_ticket = String(ll_nr_nf)
				ls_cd_caixa = lds_notas.object.cd_caixa[ll_for2]
				ls_de_especie = lds_notas.object.de_especie[ll_for2]
				ls_serie = lds_notas.object.de_serie[ll_for2]
						
				w_aguarde_3.wf_settext('Nota: ' + string(ll_nr_nf) + ' (' + string(ll_for2) + ' de ' + string(ll_linhas2) + ')', 3)
				
				ls_danfe = lds_notas.object.de_chave_acesso[ll_for2]
				if isnull(ls_danfe) then ls_danfe = '0'
				
				ls_canal_venda = lds_notas.object.cd_canal_venda[ll_for2]
				ldh_movimento = lds_notas.object.dh_emissao[ll_for2]
				
				ls_data = string(ldh_movimento, 'yyyymmddhhmm')
				
				Choose Case ls_canal_venda
					Case 'LF'
						ls_tipo_venda = '2'	//Offline
						
					Case 'EC', 'IF'
						ls_tipo_venda = '1' //Online
						
					Case Else
						ls_tipo_venda = '5' //Outros
						
				End Choose
	
				ls_tipo_pagamento = lds_notas.object.cd_forma_pagamento[ll_for2]
				
				if ls_tipo_pagamento = 'MF' Then
				
					select cd_forma_pagamento 
					into :ls_tipo_pagamento
					from nf_venda_pagamento
					where cd_filial = :ll_cd_filial
					  and nr_nf = :ll_nr_nf
					  and de_especie  = :ls_de_especie
					  and de_serie = :ls_serie
					  and nr_sequencial = 1
					  Using SQLCA;
				  
				  	If SQLCA.sqlcode = -1 then
						ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_exporta_iqva_ticket ~nProblemas ao consultar a tabela "nf_venda_pagamento": ~n' + SQLCA.sqlerrtext
						return false
					end if
				  
				end if
				  
			  Choose Case ls_tipo_pagamento
				Case 'DI'
					ls_tipo_pagamento = '1'
				Case 'CP'
					ls_tipo_pagamento = '2'
				Case 'CA'
					ls_tipo_pagamento = '3'
				Case 'HA', 'HP'
					ls_tipo_pagamento = '4'
				Case Else
					// 'CV', 'CC'
					ls_tipo_pagamento = '7'
			End Choose
				
				ll_linhas3 = lds_item.retrieve(ll_cd_filial, ll_nr_nf, ls_de_especie, ls_serie)
				
				if ll_linhas3 = 0 then
					Continue
				
				elseif ll_linhas3 < 0 Then
					ps_log = 'Erro ao buscar os itens. Datawindow: ds_ge513_ticket_produto'
					return false
				end if
			
				//Produtos
				for ll_for3 = 1 to ll_linhas3
					
					ll_qt_total = lds_item.object.c_qt_total_item[ll_linhas3]
					ldc_vl_bruto = lds_item.object.c_vl_bruto_total[ll_linhas3]
					ldc_vl_liquido = lds_item.object.c_vl_liquido_total[ll_linhas3]
					ldc_vl_desconto = lds_item.object.c_vl_desconto_total[ll_linhas3]
					
					ls_cd_produto = String(lds_item.object.cd_produto[ll_for3])

					w_aguarde_3.wf_settext('Produto: ' + ls_cd_produto + ' (' + string(ll_for3) + ' de ' + string(ll_linhas3) + ')', 4)
					
					ll_sequencial = lds_item.object.nr_item[ll_for3]
					ls_ean = lds_item.object.ean[ll_for3]
					ls_de_produto = lds_item.object.de_produto[ll_for3]
					ll_qt_produto = lds_item.object.qt_vendida[ll_for3]
					
					ldc_vl_bruto_prod = lds_item.object.vl_preco_bruto[ll_for3]
					ldc_vl_liquido_prod = lds_item.object.vl_liquido[ll_for3]
					ldc_vl_desconto_prod = lds_item.object.vl_desconto[ll_for3]
					
					if ldc_vl_desconto_prod > 0 then
						ls_desconto = 'S'
					else
						ls_desconto = 'N'
					end if
					
					ll_cd_convenio_pbm = lds_item.object.cd_convenio_pbm[ll_for3]
					ll_cd_promocao = lds_item.object.cd_promocao_sos[ll_for3]
					ll_cd_convenio = lds_item.object.cd_convenio[ll_for3]
					ls_nr_comprovante_venda = lds_item.object.nr_comprovante_venda[ll_for3]
					ls_id_pbm = lds_item.object.id_pbm[ll_for3]
					ls_id_tipo_promocao = lds_item.object.id_tipo_promocao[ll_for3]
					ldc_vl_pago_avista = lds_item.object.vl_pago_avista[ll_for3]
					
					ls_tipo_desconto = ''
					
					//2-FPOP gratuidade
					if ll_cd_convenio_pbm = 52575 and ls_nr_comprovante_venda = 'AVFARPOP' and ldc_vl_pago_avista = 0 Then
						ls_tipo_desconto = '2'
					end if
					
					//3-FPOP co-pagamento
					if ls_tipo_desconto = '' Then
						if ll_cd_convenio_pbm = 52575 and ls_nr_comprovante_venda = 'AVFARPOP' and ldc_vl_pago_avista > 0 Then
							ls_tipo_desconto = '3'
						end if
					end if
					
					//1-PBM
					if ls_tipo_desconto = '' Then
						if not isnull(ll_cd_convenio_pbm) and ll_cd_convenio_pbm <> 52575 and ls_id_pbm = 'S' Then
							ls_tipo_desconto = '1'
						end if
					end if
					
					//7-convenios empresariais
					if ls_tipo_desconto = '' Then
						if not isnull(ll_cd_convenio) and ll_cd_convenio > 0 and ( isnull(ll_cd_promocao) or ll_cd_promocao = 0 ) and ldc_vl_desconto_prod > 0 Then
							ls_tipo_desconto = '7'
						end if
					end if
					
					//10-desconto por quantidade de itens
					if ls_tipo_desconto = '' Then
						if ls_id_tipo_promocao = 'V' Then ls_tipo_desconto = '10'
					end if
					
					//5-desconto balconista
					if ls_tipo_desconto = '' Then
						if ls_id_tipo_promocao = 'N' Then ls_tipo_desconto = '5'
					end if
					
					//13-Outros
					if ls_tipo_desconto = '' and ldc_vl_desconto_prod > 0 Then 
						ls_tipo_desconto = '13'
					end if
					
					//99-N$$HEX1$$e300$$ENDHEX$$o tem informa$$HEX2$$e700e300$$ENDHEX$$o
					if ls_tipo_desconto = '' Then ls_tipo_desconto = '99'
					
					//Monta linha do produto
					//C$$HEX1$$f300$$ENDHEX$$digo padr$$HEX1$$e300$$ENDHEX$$o IQVIA para lojas
					ls_item = this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 )
					ls_item += ';'
					
					//Nr da nota
					ls_item += ls_ticket
					ls_item += ';'
		
					//ECF e SEQ
					ls_item += ls_cd_caixa
					ls_item += ';'
					
					//Chave NFCE
					ls_item += this.of_formata_campo( ls_processo, ls_danfe, 'N', 44 )
					ls_item += ';'
					
					//"Ano-Mes-Dia-Hora-MiN" Emiss$$HEX1$$e300$$ENDHEX$$o da NF
					ls_item += ls_data
					ls_item += ';'
					
					//CNPJ da Filial
					ls_item += ls_cnpj_filial
					ls_item += ';'
					
					ls_item += ls_tipo_venda
					ls_item += ';'
					
					//Quantidade total de itens
					ls_item += String(ll_qt_total)
					ls_item += ';'
					
					//***Valor total da NF sem Desconto 
					ls_item += gf_replace(String(ldc_vl_bruto), ",", ".", 1)
					ls_item += ';'
					
					//***Valor da NF
					ls_item += gf_Replace(String(ldc_vl_liquido), ",", ".", 1)
					ls_item += ';'

					//Total dos Descontos da NF
					ls_item += gf_Replace(String(ldc_vl_desconto, "0.00"), ",", ".", 1)
					ls_item += ';'
					
					ls_item += ls_tipo_pagamento
					ls_item += ';'
					
					//Sequencial do Item
					ls_item += string(ll_sequencial)
					ls_item += ';'
					
					//EAN do Produto
					ls_item += ls_ean
					ls_item += ';'
					
					//C$$HEX1$$f300$$ENDHEX$$digo produto CLAMED
					ls_item += this.of_formata_campo( ls_processo, ls_cd_produto, 'N', 13 )
					ls_item += ';'
					
					//Descri$$HEX2$$e700e300$$ENDHEX$$o do Produto
					ls_item += ls_de_produto
					ls_item += ';'
					
					//Quantidade do Produto
					ls_item += String(ll_qt_produto)
					ls_item += ';'
					
					//***Pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio do Produto			
					ls_item += gf_Replace(String(ldc_vl_bruto_prod), ",", ".", 1)
					ls_item += ';'
					
					//***Total do Produto
					ls_item += gf_Replace(String(ldc_vl_liquido_prod), ",", ".", 1)
					ls_item += ';'					
					
					//Porduto possui desconto (S/N)
					ls_item += ls_desconto
					ls_item += ';'
					
					//Tipo do Desconto
					ls_item += ls_tipo_desconto
					ls_item += ';'
					
					//Valor do Desconto em reais
					ls_item += gf_Replace(String(ldc_vl_desconto_prod, "0.00"), ",", ".", 1)
	
					if Not this.of_grava_arquivo( li_arquivo, ls_item, ref ps_log ) Then return false
					
				next
			
				w_aguarde_3.uo_progress_2.of_setprogress(ll_for2)
			
			next
			
			w_aguarde_3.uo_progress.of_setprogress(ll_for)
			
		next

	End if
	
	if li_arquivo > 0 then
	
		FileClose(li_Arquivo)
		
		w_aguarde_3.wf_settext('Enviando arquivo via FTP' , 1)
		if Not this.of_envia_arquivo( ls_nome_arquivo_completo, ls_nome_arquivo_ext, ls_nome_arquivo_zip, ref ps_log ) then return false
			
	end if

	w_aguarde_3.wf_settext('Atualizando controle de exporta$$HEX2$$e700e300$$ENDHEX$$o - Finalizando' , 1)
	if Not this.of_atualiza_tab_ult_geracao( is_processo, date(idt_atual), 0, ref ps_log ) then return false

	if Not this.of_atualiza_controle_exportacao( pdt_data, ldh_inicio, ref ps_log ) then return false

	lb_sucesso = true

Finally
	
	if lb_sucesso = false then
		SQLCA.of_rollback( )
		
		if li_arquivo > 0 then
			FileClose(li_Arquivo)		
		end if
		
	else
		SQLCA.of_commit( )
	end if
	
	if isvalid(w_aguarde_3) then Close(w_aguarde_3)
	
	Destroy(lds_filiais)
	Destroy(lds_item)
	Destroy(lds_notas)
End Try

return true

end function

public function boolean of_exporta_iqva_estoque (date pdt_data, string ps_tipo_arquivo, ref string ps_log);long ll_linhas, ll_linhas2
long ll_for, ll_for2
long ll_cd_filial
long ll_qt_produto
Long ll_tamanhoEan

integer li_arquivo

String ls_nome_arquivo
String ls_nome_arquivo_zip
String ls_nome_arquivo_ext
String ls_nome_arquivo_completo
String ls_processo
String ls_item
String ls_cnpj_filial
String ls_ean
String ls_ean_novo
String ls_cd_produto
String ls_de_produto

Datetime ldh_inicio
Date ldt_saldo

Boolean lb_sucesso=false

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_item

Try
	
	dc_uo_ds_base lds_datas
	lds_datas= create dc_uo_ds_base
	lds_datas.of_changedataobject( 'ds_ge513_estoque_filial')

	
	
	
	if not isvalid(w_aguarde_3) Then Open(w_aguarde_3)
	
	if ps_tipo_arquivo = 'CD' Then
		w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Estoque (CD) - Data: ' + String(pdt_data,'dd/mm/yyyy')
	else
		w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Estoque (LOJA) - Data: ' + String(pdt_data,'dd/mm/yyyy')
	end if
	
	ldh_inicio = gf_getserverdate()
	
	lds_filiais = create dc_uo_ds_base
	lds_item = create dc_uo_ds_base
	
	lds_filiais.of_changedataobject( 'ds_ge513_estoque_filial')
	lds_item.of_changedataobject( 'ds_ge513_estoque_produto')
	
	ldt_saldo = date( '01/' + String(month(pdt_data)) + '/' + string(year(pdt_data)) )
	
	if ps_tipo_arquivo = 'CD' Then
		ls_processo = '016'
		ll_linhas = lds_filiais.retrieve(pdt_data, 534)
	else
		ls_processo = '017'
		
		lds_filiais.of_appendwhere( 'f.cd_filial not in (534, 1, 2) ')
		
		ll_linhas = lds_filiais.retrieve(pdt_data, 0)
	end if
	
	If ll_linhas < 0 Then
		ps_log = 'Erro ao buscar as filiais. Datawindow: ds_ge513_estoque_filial'
		return false
	end if
	
	if ll_linhas > 0 then
		
		w_aguarde_3.wf_settext('Gerando o nome do Arquivo' , 1)
		
		//Monta o nome do arquivo
		if ps_tipo_arquivo	= 'CD' Then
			ls_nome_arquivo = 'SCD'	
		else
			ls_nome_arquivo = 'SPV'
		end if
		
		ls_nome_arquivo += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 ) 
		ls_nome_arquivo += 'Y'
		ls_nome_arquivo += String( date(pdt_data), 'yyyy')
		ls_nome_arquivo += 'M'
		ls_nome_arquivo += String( date(pdt_data), 'mm')
		
		ls_nome_arquivo_zip			= ls_nome_arquivo + 'D' + String( date(pdt_data), 'dd' )
		
		ls_nome_arquivo_ext 			= ls_nome_arquivo + '.D' + String( date(pdt_data), 'dd' )
		ls_nome_arquivo_completo	= ivs_Path_Exportacao + ls_nome_arquivo_ext
		
		w_aguarde_3.wf_settext('Criando o arquivo' , 1)
		if Not this.of_abre_arquivo( ls_nome_arquivo_completo, ref li_arquivo, ref ps_log ) Then return false
	
		w_aguarde_3.uo_progress.of_setmax(ll_linhas)
		
		//Filiais
		for ll_for = 1 to ll_linhas
			
			ll_cd_filial		= lds_filiais.object.cd_filial[ll_for]
			ls_cnpj_filial	= lds_filiais.object.nr_cgc[ll_for]
			
			w_aguarde_3.wf_settext('Gerando os itens do arquivo' , 1)
			w_aguarde_3.wf_settext('Filial: ' + string(ll_cd_filial) + ' (' + string(ll_for) + ' de ' + string(ll_linhas) + ')', 2)
			
			ll_linhas2		= lds_item.retrieve(ll_cd_filial, ldt_saldo)
			
			if ll_linhas2		= 0 then
				w_aguarde_3.uo_progress.of_setprogress(ll_for)
				Continue
			
			elseif ll_linhas2 < 0 Then
				ps_log		= 'Erro ao buscar os itens. Datawindow: ds_ge513_estoque_produto'
				return false
			end if
			
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas2)
			
			//Produtos
			for ll_for2				= 1 to ll_linhas2					
				ls_cd_produto	= String(lds_item.object.cd_produto		[ll_for2])				
				ls_ean 				= lds_item.object.de_codigo_barras		[ll_for2]
				ls_de_produto 	= lds_item.object.de_produto				[ll_for2]
				ll_qt_produto 	= lds_item.object.qt_saldo_final			[ll_for2]
				ll_tamanhoEan   	= lds_item.object.tamanhoean				[ll_for2]

				//Caso o primeiro seja diferente de 13 caracteres, ser$$HEX1$$e100$$ENDHEX$$ buscado o EAN secundario 
				If ls_processo = '017' or ls_processo = '016 'then
					If ll_tamanhoEan <> 13 then
						If Not This.of_localiza_ean( Long(ls_cd_produto),&
														  ls_ean,&													  
														  Ref ls_ean_novo,&
														  Ref ps_Log) Then Return False
						If Not IsNull(ls_ean_novo) Then ls_ean = ls_ean_novo
						ll_tamanhoEan = Len(ls_ean)
					End If
				End If
	
				// Chamado 1261629 - Verificar EAN invalido - IQVIA
				// Email enviado em : 01/03/2023
				Choose Case ll_tamanhoEan
					Case  14
						ls_ean		 = MidA(ls_ean,2,13)						
					Case 12 
						If Not This.of_localiza_ean( Long(ls_cd_produto),&
														  ls_ean,&													  
														  Ref ls_ean_novo,&
														  Ref ps_Log) Then Return False
						If Not IsNull(ls_ean_novo) Then ls_ean = ls_ean_novo
				End Choose
				
				
				w_aguarde_3.wf_settext('Produto: ' + ls_cd_produto + ' (' + string(ll_for2) + ' de ' + string(ll_linhas2) + ')', 3)
				w_aguarde_3.wf_settext(ls_de_produto, 4)
				
				//Monta linha do produto
				ls_item = string(pdt_data,'yyyymmdd')
				ls_item += ';'
				
				ls_item += this.of_formata_campo( ls_processo, is_cnpj_clamed, 'N', 14 )
				ls_item += ';'
				
				ls_item += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 )
				ls_item += ';'

				ls_item += ps_tipo_arquivo
				ls_item += ';'
				
				ls_item += this.of_formata_campo( ls_processo, ls_cd_produto, 'N', 13 )
				ls_item += ';'
				
				ls_item += ls_ean
				ls_item += ';'
				
				ls_item += ls_de_produto
				ls_item += ';'
				
				ls_item += this.of_formata_campo( ls_processo, ls_cnpj_filial, 'N', 14 )
				ls_item += ';'
				
				ls_item += String(ll_qt_produto)

				if Not this.of_grava_arquivo( li_arquivo, ls_item, ref ps_log ) Then return false
				
				w_aguarde_3.uo_progress_2.of_setprogress(ll_for2)
				
			next
			
			w_aguarde_3.uo_progress.of_setprogress(ll_for)
			
		next

	End if
	
	if li_arquivo > 0 then
	
		FileClose(li_Arquivo)
		
		w_aguarde_3.wf_settext('Enviando arquivo via FTP' , 1)
		if Not this.of_envia_arquivo( ls_nome_arquivo_completo, ls_nome_arquivo_ext, ls_nome_arquivo_zip, ref ps_log ) then return false
			
	end if

	w_aguarde_3.wf_settext('Atualizando controle de exporta$$HEX2$$e700e300$$ENDHEX$$o - Finalizando' , 1)
	if Not this.of_atualiza_tab_ult_geracao( is_processo, date(idt_atual), 0, ref ps_log ) then return false

	if Not this.of_atualiza_controle_exportacao( pdt_data, ldh_inicio, ref ps_log ) then return false

	lb_sucesso = true

Finally
	
	if lb_sucesso = false then
		SQLCA.of_rollback( )
		
		if li_arquivo > 0 then
			FileClose(li_Arquivo)		
		end if
		
	else
		SQLCA.of_commit( )
	end if
	
	if isvalid(w_aguarde_3) then Close(w_aguarde_3)
	
	Destroy(lds_filiais)
	Destroy(lds_item)
	
End Try

return true
end function

public function boolean of_exporta_iqva_pedido (date pdt_data, string ps_tipo_arquivo, ref string ps_log);long ll_linhas, ll_linhas2
long ll_for, ll_for2
long ll_cd_filial
long ll_qt_produto
long ll_nr_pedido
long ll_qt_pedida_total
long ll_existe

integer li_arquivo

String ls_nome_arquivo
String ls_nome_arquivo_zip
String ls_nome_arquivo_ext
String ls_nome_arquivo_completo
String ls_processo
String ls_item
String ls_cnpj_solic
String ls_cnpj_forn
String ls_ean
String ls_cd_produto
String ls_de_produto
String ls_tipo_Pedido
String ls_cd_unidade
String ls_cd_tipo
String ls_id_pbm

datetime ldh_emissao
datetime ldh_entrega 
datetime ldh_inicio

boolean lb_sucesso=false

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_item

Try
	
	if not isvalid(w_aguarde_3) Then Open(w_aguarde_3)
	
	if ps_tipo_arquivo = 'CD' Then
		w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Pedido (CD) - Data: ' + String(pdt_data,'dd/mm/yyyy')
	else
		w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Pedido (LOJA) - Data: ' + String(pdt_data,'dd/mm/yyyy')
	end if
	
	ldh_inicio = gf_getserverdate()
	
	lds_filiais = create dc_uo_ds_base
	lds_item = create dc_uo_ds_base
	
	lds_filiais.of_changedataobject( 'ds_ge513_pedido_filial')
	lds_item.of_changedataobject( 'ds_ge513_pedido')
	
	
	if ps_tipo_arquivo = 'CD' Then
		ls_processo = '018'
		ll_linhas = lds_filiais.retrieve(pdt_data, 534)
	else
		ls_processo = '019'
		ll_linhas = lds_filiais.retrieve(pdt_data, 0)
	end if
	
	If ll_linhas < 0 Then
		ps_log = 'Erro ao buscar as filiais. Datawindow: ds_ge513_pedido_filial'
		return false
	end if
	
	if ll_linhas > 0 then
		
		w_aguarde_3.wf_settext('Gerando o nome do Arquivo' , 1)
		
		//Monta o nome do arquivo
		if ps_tipo_arquivo = 'CD' Then
			ls_nome_arquivo = 'OCD'	
		else
			ls_nome_arquivo = 'OPV'
		end if
		
		ls_nome_arquivo += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 ) 
		ls_nome_arquivo += 'Y'
		ls_nome_arquivo += String( date(pdt_data), 'yyyy')
		ls_nome_arquivo += 'M'
		ls_nome_arquivo += String( date(pdt_data), 'mm')
		
		ls_nome_arquivo_zip = ls_nome_arquivo + 'D' + String( date(pdt_data), 'dd' )
		
		ls_nome_arquivo_ext = ls_nome_arquivo + '.D' + String( date(pdt_data), 'dd' )
		ls_nome_arquivo_completo = ivs_Path_Exportacao + ls_nome_arquivo_ext
		
		w_aguarde_3.wf_settext('Criando o arquivo' , 1)
		if Not this.of_abre_arquivo( ls_nome_arquivo_completo, ref li_arquivo, ref ps_log ) Then return false
	
		w_aguarde_3.uo_progress.of_setmax(ll_linhas)
		
		//Filiais
		for ll_for = 1 to ll_linhas
			
			ll_cd_filial = lds_filiais.object.cd_filial[ll_for]
			
			ll_nr_pedido 	= lds_filiais.object.nr_pedido					[ll_for]
			ls_cnpj_solic 	= lds_filiais.object.cnpj_solic				[ll_for]
			ls_cnpj_forn 	= lds_filiais.object.cnpj_forn				[ll_for]
			ldh_emissao 	= lds_filiais.object.dh_emissao				[ll_for]
			ldh_entrega 	= lds_filiais.object.dh_previsao_entrega	[ll_for]
			ls_cd_tipo 		= lds_filiais.object.cd_tipo					[ll_for]
			ls_id_pbm		= lds_filiais.object.id_pbm					[ll_for]
			ls_tipo_pedido 	= string(lds_filiais.object.tipo_pedido[ll_for])
			
			w_aguarde_3.wf_settext('Gerando os itens do arquivo' , 1)
			w_aguarde_3.wf_settext('Pedido: ' + string(ll_nr_pedido) + ' (' + string(ll_for) + ' de ' + string(ll_linhas) + ')', 2)
			
			If ll_cd_filial = 534 and (ldh_entrega < ldh_emissao) Then
                ldh_entrega = DateTime(RelativeDate ( Date(ldh_emissao), 10 ))
            	End If   
			
			if ls_id_pbm = 'S' Then
				ls_tipo_pedido = '3' //PBM
			else
				
				if ps_tipo_arquivo = 'CD' Then
					
					ll_existe = 0
					
					select count(*)
					into :ll_existe
					from pedido_central_produto pp
						inner join produto_geral g on g.cd_produto = pp.cd_produto
					where pp.nr_pedido = :ll_nr_pedido
						and substring(g.cd_subcategoria, 1,1) = '5'
					Using SQLCA;
					
					If SQLCA.sqlcode = -1 then
						ps_log = this.classname() + '.of_exporta_iqva_entrada: Erro ao consultar a tabela "pedido_central_produto" - ' + SQLCA.sqlerrtext
						return false
					end if
					
					if ll_existe > 0 Then
						ls_tipo_pedido = '1' //Interno
					else
						ls_tipo_pedido = '2' //Compra
					end if
					
				else
					ls_tipo_pedido = '2' //Compra
				end if
				
			end if
			
			
			ll_linhas2 = lds_item.retrieve(ll_cd_filial, ll_nr_pedido, ls_cd_tipo)
			
			if ll_linhas2 = 0 then
				w_aguarde_3.uo_progress.of_setprogress(ll_for)
				Continue
			
			elseif ll_linhas2 < 0 Then
				ps_log = 'Erro ao buscar os itens. Datawindow: ds_ge513_pedido'
				return false
			end if
			
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas2)
			
			//Produtos
			for ll_for2 = 1 to ll_linhas2
					
				ls_cd_produto = String(lds_item.object.cd_produto[ll_for2])
				
				ls_ean = lds_item.object.de_codigo_barras[ll_for2]
				ls_de_produto = lds_item.object.de_produto[ll_for2]
				ll_qt_produto = lds_item.object.qt_pedida[ll_for2]
				//ls_cd_unidade = lds_item.object.cd_unidade_medida_venda[ll_for2]
				
				ll_qt_pedida_total = lds_item.object.c_qt_pedida_total[ll_linhas2]
				
				w_aguarde_3.wf_settext('Produto: ' + ls_cd_produto + ' (' + string(ll_for2) + ' de ' + string(ll_linhas2) + ')', 3)
				w_aguarde_3.wf_settext(ls_de_produto, 4)
				
				//Monta linha do produto

				ls_item = this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 )
				ls_item += ';'

				ls_item += String(ll_nr_pedido)
				ls_item += ';'
				
				ls_item += String(ldh_emissao, 'yyyymmdd')
				ls_item += ';'
				
				ls_item += String(ldh_entrega, 'yyyymmdd')
				ls_item += ';'
				
				ls_item += this.of_formata_campo( ls_processo, ls_cnpj_solic, 'N', 14 )
				ls_item += ';'
				
				ls_item += this.of_formata_campo( ls_processo, ls_cnpj_forn, 'N', 14 )
				ls_item += ';'
				
				ls_item += ps_tipo_arquivo
				ls_item += ';'
				
				ls_item += ls_tipo_pedido
				ls_item += ';'
				
				ls_item += String(ll_qt_pedida_total)
				ls_item += ';'
				
				ls_item += this.of_formata_campo( ls_processo, ls_ean, 'N', 13 )
				ls_item += ';'
				
				ls_item += this.of_formata_campo( ls_processo, ls_cd_produto, 'N', 13 )
				ls_item += ';'
				
				ls_item += ls_de_produto
				ls_item += ';'
				
				//ls_item += ls_cd_unidade
				//ls_item += ';'
				
				ls_item += String(ll_qt_produto)
				
				if Not this.of_grava_arquivo( li_arquivo, ls_item, ref ps_log ) Then return false
				
				w_aguarde_3.uo_progress_2.of_setprogress(ll_for2)
				
			next
			
			w_aguarde_3.uo_progress.of_setprogress(ll_for)
			
		next

	End if
	
	if li_arquivo > 0 then
	
		FileClose(li_Arquivo)
		
		w_aguarde_3.wf_settext('Enviando arquivo via FTP' , 1)
		if Not this.of_envia_arquivo( ls_nome_arquivo_completo, ls_nome_arquivo_ext, ls_nome_arquivo_zip, ref ps_log ) then return false
			
	end if

	w_aguarde_3.wf_settext('Atualizando controle de exporta$$HEX2$$e700e300$$ENDHEX$$o - Finalizando' , 1)
	if Not this.of_atualiza_tab_ult_geracao( is_processo, date(idt_atual), 0, ref ps_log ) then return false

	if Not this.of_atualiza_controle_exportacao( pdt_data, ldh_inicio, ref ps_log ) then return false

	lb_sucesso = true

Finally
	
	if lb_sucesso = false then
		SQLCA.of_rollback( )
		
		if li_arquivo > 0 then
			FileClose(li_Arquivo)		
		end if
		
	else
		SQLCA.of_commit( )
	end if
	
	if isvalid(w_aguarde_3) then Close(w_aguarde_3)
	
	Destroy(lds_filiais)
	Destroy(lds_item)
	
End Try

return true
end function

public function boolean of_exporta_iqva_entrada (date pdt_data, string ps_tipo_arquivo, ref string ps_log);long ll_linhas, ll_linhas2
long ll_for, ll_for2
long ll_cd_filial
long ll_nr_pedido
long ll_for3
long ll_linhas3
long ll_qt_total
long ll_qt_produto
long ll_existe

integer li_arquivo

String ls_nome_arquivo
String ls_nome_arquivo_zip
String ls_nome_arquivo_ext
String ls_nome_arquivo_completo
String ls_processo
String ls_item
String ls_danfe
String ls_cnpj_solic
String ls_cnpj_forn
String ls_ean
String ls_cd_produto
String ls_de_produto
String ls_id_pbm
String ls_status
String ls_tipo_pedido
String ls_tipo_movimento

datetime ldh_pedido
datetime ldh_entrada
datetime ldh_inicio

boolean lb_sucesso=false

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_item
dc_uo_ds_base lds_notas

Try
	
	if not isvalid(w_aguarde_3) Then Open(w_aguarde_3)
	
	if ps_tipo_arquivo = 'CD' then	
		w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Entrada (CD) - Data: ' + String(pdt_data,'dd/mm/yyyy')
	else
		w_aguarde_3.title = 'Exporta$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVA - Entrada (LOJA) - Data: ' + String(pdt_data,'dd/mm/yyyy')
	end if
	
	ldh_inicio = gf_getserverdate()
	
	lds_filiais = create dc_uo_ds_base
	lds_item = create dc_uo_ds_base
	lds_notas = create dc_uo_ds_base
	
	lds_filiais.of_changedataobject( 'ds_ge513_entrada_filial')
	lds_notas.of_changedataobject( 'ds_ge513_entrada_pedido')
	lds_item.of_changedataobject( 'ds_ge513_entrada_pedido_produto')
	
	if ps_tipo_arquivo = 'CD' then
		ls_processo = '020'
		
		lds_filiais.of_appendwhere( 'n.cd_filial = 534')
		
	else
		ls_processo = '021'
		
		lds_filiais.of_appendwhere( 'n.cd_filial not in ( 534, 1,2 )')
		
	end if
	
	ll_linhas = lds_filiais.retrieve(pdt_data)
	
	If ll_linhas < 0 Then
		ps_log = 'Erro ao buscar as filiais. Datawindow: ds_ge513_entrada_filial'
		return false
	end if
	
	if ll_linhas > 0 then
		
		w_aguarde_3.wf_settext('Gerando o nome do Arquivo' , 1)
		
		//Monta o nome do arquivo
		if ps_tipo_arquivo = 'CD' then
			ls_nome_arquivo = 'ECD'
		else
			ls_nome_arquivo = 'EPV'
		end if
		
		ls_nome_arquivo += this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 ) 
		ls_nome_arquivo += 'Y'
		ls_nome_arquivo += String( date(pdt_data), 'yyyy')
		ls_nome_arquivo += 'M'
		ls_nome_arquivo += String( date(pdt_data), 'mm')
		
		ls_nome_arquivo_zip = ls_nome_arquivo + 'D' + String( date(pdt_data), 'dd' )
		
		ls_nome_arquivo_ext = ls_nome_arquivo + '.D' + String( date(pdt_data), 'dd' )
		ls_nome_arquivo_completo = ivs_Path_Exportacao + ls_nome_arquivo_ext
		
		w_aguarde_3.wf_settext('Criando o arquivo' , 1)
		if Not this.of_abre_arquivo( ls_nome_arquivo_completo, ref li_arquivo, ref ps_log ) Then return false
	
		w_aguarde_3.uo_progress.of_setmax(ll_linhas)
		
		//Filiais
		for ll_for = 1 to ll_linhas
			
			ll_cd_filial = lds_filiais.object.cd_filial[ll_for]

			w_aguarde_3.wf_settext('Gerando os itens do arquivo' , 1)
			w_aguarde_3.wf_settext('Filial: ' + string(ll_cd_filial) + ' (' + string(ll_for) + ' de ' + string(ll_linhas) + ')', 2)
			
			//Carrega as notas da filial
			ll_linhas2 = lds_notas.retrieve(pdt_data, ll_cd_filial)
			
			if ll_linhas2 = 0 then
				w_aguarde_3.uo_progress.of_setprogress(ll_for)
				Continue
			
			elseif ll_linhas2 < 0 Then
				ps_log = 'Erro ao buscar os itens. Datawindow: ds_ge513_entrada_pedido'
				return false
			end if
			
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas2)
			
			//Notas
			for ll_for2 = 1 to ll_linhas2
				
				ll_nr_pedido = lds_notas.object.nr_pedido[ll_for2]
				
				w_aguarde_3.wf_settext('Pedido: ' + string(ll_nr_pedido) + ' (' + string(ll_for2) + ' de ' + string(ll_linhas2) + ')', 3)
				
				ls_danfe = lds_notas.object.de_chave_acesso[ll_for2]
				ldh_pedido = lds_notas.object.dh_pedido[ll_for2]
				ldh_entrada = lds_notas.object.dh_entrada[ll_for2]
				ls_cnpj_solic = lds_notas.object.cnpj_solic[ll_for2]
				ls_cnpj_forn = lds_notas.object.cnpj_forn[ll_for2]
				ls_status = '2' //Encerrado
				ls_id_pbm = lds_notas.object.id_pbm[ll_for2]
				
				if ls_id_pbm = 'S' Then
					ls_tipo_pedido = '3' //PBM
				else
					
					if ps_tipo_arquivo = 'CD' Then
						
						ll_existe = 0
						
						select count(*)
						into :ll_existe
						from pedido_central_produto pp
							inner join produto_geral g on g.cd_produto = pp.cd_produto
						where pp.nr_pedido = :ll_nr_pedido
							and substring(g.cd_subcategoria, 1,1) = '5'
						Using SQLCA;
						
						If SQLCA.sqlcode = -1 then
							ps_log = this.classname() + '.of_exporta_iqva_entrada: Erro ao consultar a tabela "pedido_central_produto" - ' + SQLCA.sqlerrtext
							return false
						end if
						
						if ll_existe > 0 Then
							ls_tipo_pedido = '1' //Interno
						else
							ls_tipo_pedido = '2' //Compra
						end if
						
					else
						ls_tipo_pedido = '2' //Compra
					end if
					
				end if
				
				if isnull(ls_danfe) then ls_danfe = '0'
				
				if ps_tipo_arquivo = 'CD' then
					ls_tipo_movimento = 'PEDCENT'
				else
					ls_tipo_movimento = 'PEDDIST'
				end if
				
				ll_linhas3 = lds_item.retrieve(ll_cd_filial, ll_nr_pedido, pdt_data, ls_tipo_movimento)
				
				if ll_linhas3 = 0 then
					Continue
				
				elseif ll_linhas3 < 0 Then
					ps_log = 'Erro ao buscar os itens. Datawindow: ds_ge513_entrada_pedido_produto'
					return false
				end if
			
				//Produtos
				for ll_for3 = 1 to ll_linhas3
					
					ll_qt_total = lds_item.object.c_qt_total_item[ll_linhas3]
					
					ls_cd_produto = String(lds_item.object.cd_produto[ll_for3])
					
					w_aguarde_3.wf_settext('Produto: ' + ls_cd_produto + ' (' + string(ll_for3) + ' de ' + string(ll_linhas3) + ')', 4)
					
					ls_ean = lds_item.object.de_codigo_barras[ll_for3]
					ls_de_produto = lds_item.object.de_produto[ll_for3]
					ll_qt_produto = lds_item.object.qt_faturada[ll_for3]
					
					//Monta linha do produto
					ls_item = this.of_formata_campo( ls_processo, is_codigo_iqva, 'N', 4 )
					ls_item += ';'
	
					ls_item += string(ll_nr_pedido)
					ls_item += ';'
					
					ls_item += this.of_formata_campo( ls_processo, ls_danfe, 'N', 44 )
					ls_item += ';'
					
					ls_item += string(ldh_pedido, 'yyyymmdd')
					ls_item += ';'
					
					ls_item += ls_status
					ls_item += ';'
				
					ls_item += string(ldh_entrada, 'yyyymmdd')
					ls_item += ';'
				
					ls_item += ls_cnpj_solic
					ls_item += ';'
					
					ls_item += ls_cnpj_forn
					ls_item += ';'
					
					ls_item += ps_tipo_arquivo
					ls_item += ';'
					
					ls_item += ls_tipo_pedido
					ls_item += ';'
					
					ls_item += String(ll_qt_total)
					ls_item += ';'
					
					ls_item += this.of_formata_campo( ls_processo, ls_ean, 'N', 13 )
					ls_item += ';'
					
					ls_item += this.of_formata_campo( ls_processo, ls_cd_produto, 'N', 13 )
					ls_item += ';'
					
					ls_item += ls_de_produto
					ls_item += ';'
					
					ls_item += String(ll_qt_produto)
					
					if Not this.of_grava_arquivo( li_arquivo, ls_item, ref ps_log ) Then return false
					
				next
			
				w_aguarde_3.uo_progress_2.of_setprogress(ll_for2)
			
			next
			
			w_aguarde_3.uo_progress.of_setprogress(ll_for)
			
		next

	End if
	
	if li_arquivo > 0 then
	
		FileClose(li_Arquivo)
		
		w_aguarde_3.wf_settext('Enviando arquivo via FTP' , 1)
		if Not this.of_envia_arquivo( ls_nome_arquivo_completo, ls_nome_arquivo_ext, ls_nome_arquivo_zip, ref ps_log ) then return false
			
	end if

	w_aguarde_3.wf_settext('Atualizando controle de exporta$$HEX2$$e700e300$$ENDHEX$$o - Finalizando' , 1)
	if Not this.of_atualiza_tab_ult_geracao( is_processo, date(idt_atual), 0, ref ps_log ) then return false

	if Not this.of_atualiza_controle_exportacao( pdt_data, ldh_inicio, ref ps_log ) then return false

	lb_sucesso = true

Finally
	
	if lb_sucesso = false then
		SQLCA.of_rollback( )
		
		if li_arquivo > 0 then
			FileClose(li_Arquivo)		
		end if
		
	else
		SQLCA.of_commit( )
	end if
	
	if isvalid(w_aguarde_3) then Close(w_aguarde_3)
	
	Destroy(lds_filiais)
	Destroy(lds_item)
	Destroy(lds_notas)
End Try

return true
end function

public function boolean of_envia_arquivo (string ps_nm_arquivo_completo, string ps_nm_arquivo_ext, string ps_nm_arquivo, ref string ps_log);string ls_zip


try

	// Move para a pasta temp
	ivo_Api.of_Move_File( ps_nm_arquivo_completo, ivs_Path_Exportacao + "\Temp\" + ps_nm_arquivo_ext, True )
	
	If Not This.of_Compacta_Arquivos( ivs_Path_Exportacao + "\Temp\", ps_nm_arquivo, Ref ls_ZIP, Ref ps_Log) Then return false
		
	If is_envia_arquivo_ftp = 'S' Then
		
		If Not This.of_Envia_Arquivo_FTP( is_Processo,  is_Server_FTP, is_Usuario_FTP, is_Senha_FTP, ivs_Path_Exportacao + "\Temp\", ls_ZIP,  Ref ps_Log ) Then return false
		
		ivo_Api.of_Copy_File( ivs_Path_Exportacao + "\Temp\"+ ls_ZIP,  ivs_Path_Exportacao + "\Backup\" +ls_ZIP, False )
		
	Else
		ivo_Api.of_Copy_File( ivs_Path_Exportacao + "\Temp\"+ ls_ZIP,  ivs_Path_Exportacao + "\Backup\" +ls_ZIP, False )
	End If

Finally

	if Not this.of_exclui_arquivos_temporarios( ref ps_log ) then return false
	
End Try

return true
end function

public function boolean of_envia_arquivo_ftp (string ps_processo, string ps_servidor, string ps_usuario, string ps_senha, string ps_diretorio, string ps_arquivo, string ps_log);Boolean lvb_Sucesso = True
Long lvl_Porta 

//Desenvolvimento
//Return True

If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

Open( w_Aguarde )

w_Aguarde.Title = "Enviando Arquivo para o FTP..."

//If ps_Processo = '011' Then
//
//	dc_uo_ftp_proxy lvo_FTP_Proxy
//	lvo_FTP_Proxy = create dc_uo_ftp_proxy
//	
//	If lvo_FTP_Proxy.of_Conecta_Ftp('RO', ps_Servidor, ps_Usuario, ps_Senha, Ref ps_Log, ps_Usuario, ps_Senha) Then	
//		If Not lvo_FTP_Proxy.of_Ftp_PutFile(ps_diretorio + ps_Arquivo, ps_Arquivo, Ref ps_Log, True ) Then
//			lvb_Sucesso = False
//		End If		
//	End If
//	
//	Destroy(lvo_FTP_Proxy)
//	
//Else

if is_protocolo_sftp = 'S' Then
	
	dc_uo_sftp lvo_SFTP
	lvo_SFTP = create dc_uo_sftp
	lvl_Porta = 0 
	
	If Not lvo_sftp.of_enviar_arquivo( ps_diretorio + ps_arquivo, ps_arquivo, ps_Servidor, ps_usuario, ps_senha, lvl_Porta, ref ps_log ) then
		lvb_Sucesso = False		
	End If
	
Else

	dc_uo_ftp lvo_FTP
	lvo_FTP = create dc_uo_ftp
	
	If lvo_FTP.of_Conecta_Ftp('RO', ps_Servidor, ps_Usuario, ps_Senha, Ref ps_Log) Then	
		If Not lvo_FTP.of_Ftp_PutFile(ps_diretorio + ps_Arquivo, ps_Arquivo, Ref ps_Log, True ) Then
			lvb_Sucesso = False
		End If		
	End If
	
	Destroy(lvo_FTP)
	
End if	
	
//End If	

Close( w_Aguarde )

If Not lvb_Sucesso Then
	ps_Log+= "ERRO ao enviar o arquivo para o FTP do processo[" + ps_Processo + "] - Arquivo[" + ps_Arquivo + "]"
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_ean (long al_produto, string as_ean_old, ref string as_ean_novo, ref string ps_log);SetNull(as_ean_novo)


Select  Top 1 de_codigo_barras
Into   :as_ean_novo
From		codigo_barras_produto
Where 	cd_produto=:al_produto
and        de_codigo_barras <>:as_ean_old
Using SqlCA;

Choose Case Sqlca.Sqlcode
	Case -1
		ps_log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o codigo_barras_produto - Produto [" + String(al_produto) + "]"
		Return False
	Case 100
		ps_log += "Registro n$$HEX1$$e300$$ENDHEX$$o localizado -codigo_barras_produtoo - Produto [" + String(al_produto) + "]"
		SetNull(as_ean_novo)
	Case 0
		Return True		
End Choose



Return True 
end function

public function boolean of_grava_log (string as_mensagem, string as_ean, boolean ab_envia_email);Integer lvi_Status

String lvs_Mensagem 

String ls_Anexo[]
String ls_Mensagem_Email
String ls_Mensagem_Log

//lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + 	String(Now(), "hh:mm:ss") + " " + as_Mensagem

If ab_envia_email Then
	lvs_Mensagem = "Produto: " + as_ean + '<br><br>'
	lvs_Mensagem += "Data: " + String(Today(), "dd/mm/yyyy") + " " + 	String(Now(), "hh:mm:ss") + '<br><br>' 
	lvs_Mensagem += "<b>Mensagem:</b> " + as_Mensagem
		
	If Not gf_ge202_envia_email_automatico(44, " - LOG ", lvs_Mensagem, ls_Anexo) Then
		Return False
	End If
End If
end function

public subroutine of_corrige_ean (long lvl_produto, ref string lvs_ean);Long			lvl_Total,&
				lvl_Contador
				
Integer		lvi_tamanho
				
String		lvs_EAN1

Boolean 		lb_Ean_Principal = True

Try

	dc_uo_ds_Base lvds
	lvds = Create dc_uo_ds_Base

    If Not lvds.of_ChangeDataObject("dw_ge513_lista_ean") Then 
		This.of_Grava_Log("Erro ao atualizar a 'dw_ge513_lista_ean'.",'', True)
	End If

	lvl_Total = lvds.Retrieve(lvl_produto)

	If lvl_Total > 0 Then
		For	lvl_Contador	= 1 To lvl_Total
				lvs_EAN1		= lvds.Object.de_codigo_barras          [lvl_Contador]

			If LenA(lvs_EAN1) = 13 Then
				lvs_EAN				= lvs_EAN1
				lb_Ean_Principal	= False
			End If		
		Next		 	
	End if	
	
	If	lb_Ean_Principal = TRUE Then
		This.of_Grava_Log("C$$HEX1$$f300$$ENDHEX$$digo de barras '" + lvs_EAN + "' sofreu altera$$HEX2$$e700e300$$ENDHEX$$o pois possui mais de 13 digitos '" ,lvs_EAN, True)
		lvi_tamanho = LenA(lvs_EAN)
       
        If	lvi_tamanho > 13 Then
			lvs_EAN = Right(lvs_EAN, 13)
		Else 
			lvi_tamanho		= 13 - LenA(lvs_EAN)
			lvs_EAN				= MidA("0000000000000",1,lvi_tamanho) + lvs_EAN	
		End if	
	End if	
	
Finally
	Destroy(lvds)	
End try
end subroutine

public function boolean of_gera_arquivos (string ps_processo, ref string ps_log, date ps_data_de, date ps_data_ate);Boolean lvb_Sucesso

Date	lvdt_Periodo_De, &
		lvdt_Periodo_Ate, &
		lvdt_Servidor, &
		lvdt_Aux
		
Integer	lvi_Arquivo, &
			lvi_Periodicidade
			
Long 	lvl_Ult_Arquivo_Exp, &
		lvl_Nr_Prox_Arquivo_Exp	

String	lvs_Nm_Arquivo, &
		lvs_ZIP, &
		lvs_Nm_Arquivo_Completo, &
		lvs_Nm_Arquivo_Sem_Extensao, &
		lvs_Server_FTP, &
		lvs_Usuario_FTP, &
		lvs_Senha_FTP, &
		lvs_Nm_Arquivo_ZIP

If Not This.of_Cria_Diretorios(ps_Processo, Ref ps_Log) Then Return False

//Lima
//Conforme solicitado pelo Correa, a rotina 011 deve rodar em um hor$$HEX1$$e100$$ENDHEX$$rio pr$$HEX1$$f300$$ENDHEX$$ximo de 12 horars
//Para padronizar IMS/IQVIA e Close Up v$$HEX1$$e300$$ENDHEX$$o executar ap$$HEX1$$f300$$ENDHEX$$s $$HEX1$$e000$$ENDHEX$$s 10 horas

If gvb_Exp_Auto Then
	If Now() < Time('10:00:00') Then Return True
End If

is_processo = ps_processo

Choose CAse ps_processo
	Case '013', '014', '015', '016', '017', '018', '019', '020', '021'
		
		//Exporta$$HEX2$$e700e300$$ENDHEX$$o de arquivos para a IQVA
		lvb_Sucesso= this.of_exporta_iqva( ps_processo, ref ps_log )
		
	Case else

		dc_uo_ds_base ds_Controle
		ds_Controle = Create dc_uo_ds_base
		ds_Controle.of_ChangeDataObject('ds_ge513_config_ftp_industria')
		
		ds_Controle.Retrieve(ps_Processo)
		
		If ds_Controle.RowCount() = 0 Then
			ps_Log += "N$$HEX1$$e300$$ENDHEX$$o existe informa$$HEX2$$e700f500$$ENDHEX$$es de controle [tab:controle_exportacoes_arquivos] para o processo:[" + ps_Processo + "]"
			Destroy(ds_Controle)
			Return False
		End If
	
		lvdt_Periodo_De 		= Date(ds_Controle.Object.Dh_Ultima_Exportacao[1])
		lvdt_Servidor			= Date(gf_GetServerDate())
		lvi_Periodicidade		= ds_Controle.Object.Id_Periodicidade[1]
		lvl_Ult_Arquivo_Exp 	= ds_Controle.Object.Nr_Ultimo_Seq_Arquivo[1]
		lvs_Server_FTP			= ds_Controle.Object.De_Endereco_FTP[1]
		lvs_Usuario_FTP		= ds_Controle.Object.De_Usuario_FTP[1]
		lvs_Senha_FTP			= ds_Controle.Object.De_Senha_FTP[1]
		
		If not gvb_Exp_Auto and &
			(ps_processo = '011' or ps_processo = '012') and &
			(Not IsNull (ps_data_de) and Not IsNull (ps_data_ate)) then
			lvdt_Periodo_De  = ps_data_de
			lvdt_Periodo_Ate = ps_data_ate
		else
			Choose Case lvi_Periodicidade
				Case 1 // Diario
					//lvdt_Periodo_Ate = RelativeDate(lvdt_Servidor, -1)
					
					//Os arquivos close up e ims/iqvia s$$HEX1$$e300$$ENDHEX$$o gerados 2 vezes por dia.
					//O controle abaixo $$HEX1$$e900$$ENDHEX$$ feito pra n$$HEX1$$e300$$ENDHEX$$o permitir que o segundo do dia n$$HEX1$$e300$$ENDHEX$$o seja gerado com a data corrente.
					//O correto $$HEX1$$e900$$ENDHEX$$ sempre d-1
					If RelativeDate(lvdt_Periodo_De, 1) < lvdt_Servidor Then
						lvdt_Periodo_De = RelativeDate(lvdt_Periodo_De, 1)
					End If
					
					lvdt_Periodo_Ate = lvdt_Periodo_De
					
				Case 2 // Semanal
					lvdt_Periodo_Ate = RelativeDate(lvdt_Periodo_De, 7)		// Processo n$$HEX1$$e300$$ENDHEX$$o realizado/testado
				Case 3 // Mensal
					
					// S$$HEX1$$f300$$ENDHEX$$ gerar$$HEX1$$e100$$ENDHEX$$ o arquivo no dia 3 de cada m$$HEX1$$ea00$$ENDHEX$$s
					If Day(lvdt_Servidor) <> 2 Then Return True
					
					gf_DateAdd(lvdt_Servidor, 'day', -5, lvdt_Aux)
					
					lvdt_Periodo_Ate = gf_Retorna_Ultimo_Dia_Mes(lvdt_Aux)
					
					// Caso a $$HEX1$$fa00$$ENDHEX$$ltima data gravada na base seja igual ao per$$HEX1$$ed00$$ENDHEX$$odo at$$HEX1$$e900$$ENDHEX$$ da exporta$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ porque a exporta$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ sendo realizada novamente.
					If lvdt_Periodo_De = lvdt_Periodo_Ate Then Return True
					
					lvdt_Periodo_De  = gf_Primeiro_Dia_Mes(lvdt_Aux)		
					
				Case 4 // Semestral
					lvdt_Periodo_Ate = RelativeDate(lvdt_Periodo_De, 180)	// Processo n$$HEX1$$e300$$ENDHEX$$o realizado/testado
				Case 5 // Anual
					lvdt_Periodo_Ate = RelativeDate(lvdt_Periodo_De, 365)	// Processo n$$HEX1$$e300$$ENDHEX$$o realizado/testado
			End Choose
			
			If lvdt_Periodo_Ate >= lvdt_Servidor Then
				Destroy(ds_Controle)
				Return True
			End If
		End if
		
		dc_uo_ds_base ds_Receita
		ds_Receita = Create dc_uo_ds_base
		ds_Receita.of_ChangeDataObject('ds_ge513_receita_medica')
		
		//n$$HEX1$$e300$$ENDHEX$$o esquecer de comentar novamente em produ$$HEX2$$e700e300$$ENDHEX$$o 
		//lvdt_Periodo_De = Date('2023/09/01')
		//lvdt_Periodo_Ate = Date('2023/09/01')
		ds_receita.Retrieve( lvdt_Periodo_De, lvdt_Periodo_Ate )
		
		If ds_receita.RowCount() = 0 Then
			ps_Log += "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ receitas capturadas no Per$$HEX1$$ed00$$ENDHEX$$odo para o Processo[" + ps_Processo + "]"
			Destroy(ds_Receita)
			Destroy(ds_Controle)
			Return False
		End If
		
		lvl_Nr_Prox_Arquivo_Exp = lvl_Ult_Arquivo_Exp + 1
		
		Choose Case ps_Processo
			Case '011' // IMS Health
				lvs_Nm_Arquivo_Sem_Extensao 	= 'BR' + String(lvdt_Periodo_De, 'YYYY') + String(lvdt_Periodo_De, 'MM') + 'DD' + String(lvdt_Periodo_De, 'DD') + '_' + &
																		String(lvdt_Periodo_Ate, 'YYYY') + String(lvdt_Periodo_Ate, 'MM') + 'DD' + String(lvdt_Periodo_Ate, 'DD') + &
																'1550-RX-' + String(lvl_Nr_Prox_Arquivo_Exp, '000')
		//		lvs_Nm_Arquivo_Sem_Extensao 	= 'BR' + String(lvdt_Periodo_Ate, 'YYYY') + String(lvdt_Periodo_Ate, 'MM') + 'DXX' + '1550-RX-XXX' //+ String(lvl_Nr_Prox_Arquivo_Exp, '000')		
				lvs_Nm_Arquivo 						= lvs_Nm_Arquivo_Sem_Extensao + '.csv'
				lvs_Nm_Arquivo_ZIP					= lvs_Nm_Arquivo_Sem_Extensao
			
			Case '012' // CloseUp
				
				lvs_Nm_Arquivo_Sem_Extensao 	= 'CT_' + 	String(lvdt_Periodo_Ate, 'YY') + String(lvdt_Periodo_Ate, 'MM') + String(lvdt_Periodo_Ate, 'DD')
				lvs_Nm_Arquivo_ZIP					= 'Receita_' + String(lvdt_Periodo_Ate, 'DD') + String(lvdt_Periodo_Ate, 'MM') + String(lvdt_Periodo_Ate, 'YY') + '_a_' + &
																				String(lvdt_Periodo_Ate, 'DD') + String(lvdt_Periodo_Ate, 'MM') + String(lvdt_Periodo_Ate, 'YY')
				lvs_Nm_Arquivo 						=  lvs_Nm_Arquivo_Sem_Extensao + '.txt'
				
		End Choose
			
		lvs_Nm_Arquivo_Completo = ivs_Path_Exportacao + lvs_Nm_Arquivo
		
		//Abre arquivo
		If Not This.of_Abre_Arquivo(lvs_Nm_Arquivo_Completo, ref lvi_Arquivo, ref ps_Log) Then
			ps_Log += "Erro na abertura do arquivo para gera$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es para o processo:[" + ps_Processo + "]"
			Destroy(ds_Receita)
			Destroy(ds_Controle)
			
			Return False
		End If
		
		Choose Case ps_Processo
			Case '011' // IMS Health
				
				lvb_Sucesso = This.Of_Exporta_Arquivos_Processo_011(ds_Controle, ds_Receita, lvi_Arquivo, lvs_Nm_Arquivo_Completo, lvdt_Periodo_De, lvdt_Periodo_Ate, ref ps_Log)
				
			Case '012' // CloseUp
				
				lvb_Sucesso = This.Of_Exporta_Arquivos_Processo_012(ds_Controle, ds_Receita, lvi_Arquivo, lvs_Nm_Arquivo_Completo, lvdt_Periodo_De, lvdt_Periodo_Ate, ref ps_Log)	
				
		End Choose
	
		If lvb_Sucesso Then
			
			lvb_Sucesso = False
			
			// Move para a pasta temp
			ivo_Api.of_Move_File( lvs_Nm_Arquivo_Completo, ivs_Path_Exportacao + "\Temp\" + lvs_Nm_Arquivo, True )
			
			If This.of_Compacta_Arquivos( ivs_Path_Exportacao + "\Temp\", lvs_Nm_Arquivo_ZIP, Ref lvs_ZIP, Ref ps_Log) Then
				
				If This.of_Envia_Arquivo_FTP(ps_Processo,  lvs_Server_FTP, lvs_Usuario_FTP, lvs_Senha_FTP, ivs_Path_Exportacao + "\Temp\", lvs_ZIP, Ref ps_Log ) Then
					
					ivo_Api.of_Copy_File( ivs_Path_Exportacao + "\Temp\"+ lvs_ZIP,  ivs_Path_Exportacao + "\Backup\" +lvs_ZIP, False )
					
					If This.Of_Atualiza_Tab_Ult_Geracao(ps_Processo, lvdt_Periodo_Ate, lvl_Nr_Prox_Arquivo_Exp, Ref ps_Log) Then			
						lvb_Sucesso = True
						SQLCA.of_Commit ()
					End If
				End If
			End If
		End If

End Choose

Destroy(ds_Receita)
Destroy(ds_Controle)

Return lvb_Sucesso
end function

on uo_ge513_exporta_arquivos_farmacia.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge513_exporta_arquivos_farmacia.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_api = Create dc_uo_api
end event

event destructor;Destroy(ivo_api)
end event

