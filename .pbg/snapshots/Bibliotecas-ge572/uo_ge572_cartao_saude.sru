HA$PBExportHeader$uo_ge572_cartao_saude.sru
forward
global type uo_ge572_cartao_saude from nonvisualobject
end type
end forward

global type uo_ge572_cartao_saude from nonvisualobject
end type
global uo_ge572_cartao_saude uo_ge572_cartao_saude

type variables
String ivs_diretorio_trabalho
String ivs_diretorio_processado
String ivs_caminho_arquivo
String ivs_nm_arquivo

String is_log
String is_host
String is_user
String is_pass
Long il_porta

//'clamed@875123' / '200.217.218.230' / 'clamed' / 22

Long il_Convenio

private String ivs_Path_Remoto



end variables

forward prototypes
public subroutine _documentacao ()
public function boolean of_atualiza_cartao_saude (boolean pb_exibe_msg)
public function integer of_busca_arquivos (string ps_empresa, ref string ps_log)
public subroutine of_set_path_remoto (string ps_empresa)
public function boolean of_processa_arquivos (string ps_empresa, boolean pb_exibe_msg, ref string ps_mensagem)
public function boolean of_insert_controle_movimento (string ps_empresa, integer pi_qt_arquivo, ref long pl_sequencial_movimento, ref string ps_msg)
public function boolean of_processa_inativacao (ref string ps_mensagem)
public function boolean of_update_controle_movimento (string ps_empresa, long pl_sequencial_movimento, ref string ps_mensagem)
public subroutine of_set_cod_convenio (string as_empresa)
public function boolean of_atualiza_registros_importados (ref string ps_mensagem)
public function boolean of_verifica_arquivo_processado (string as_arquivo, ref boolean ab_arquivo_processado)
public function boolean of_processa_arquivos_novo (string ps_empresa, boolean pb_exibe_msg, ref string ps_mensagem)
public function boolean of_carrega_parametros ()
end prototypes

public subroutine _documentacao ();/*
  Objetivo:  Exporta dados de cartao saude Clinipam/Hapvida/CCG e incluir em nossas estruturas.

A Clinipam disponibiliza v$$HEX1$$e100$$ENDHEX$$rios arquivos por empresa, ex:
1 Arquivo Full com todos os CPFs no final de cada m$$HEX1$$ea00$$ENDHEX$$s
1 arquivo incremental semanalmente

Esses arquivos n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o deletados na area ftp.

Nosso sistema baixa os arquivos do mes anterior e do mes atual
Existe um controle na tabela cartao_saude_historico_arquivo para verificar se o arquivo j$$HEX1$$e100$$ENDHEX$$ foi processado

A leitura dos arquivos $$HEX1$$e900$$ENDHEX$$ realizada e gravada na tabela cartao_saude_tmp
a cada 50.000 mil linhas $$HEX1$$e900$$ENDHEX$$ realizado um update/insert para a tabela principal cartao_saude.
*/


end subroutine

public function boolean of_atualiza_cartao_saude (boolean pb_exibe_msg);Boolean lb_Sucesso = True

Integer li_Busca
Integer li_Row

String ls_arquivos[]
String ls_Nm_Empresa
String ls_Log

Date ldh_Parametro

String ls_Empresas[] = { 'HAPVIDA', 'CLINIPAM', 'CCG' }
//String ls_Empresas[] = { 'HAPVIDA' } //Apenas a CLINIPAM Tem contrato ativo
//String ls_Empresas[] = { 'HAPVIDA' }

Try
	ldh_Parametro = Date(gvo_Parametro.of_dh_movimentacao( )	)
	
	For li_Row = 1 To UpperBound( ls_Empresas[] )
		ls_Nm_Empresa = ls_Empresas[ li_Row ]
		This.of_set_cod_convenio(ls_Nm_Empresa)
		
		gvo_Aplicacao.of_Grava_Log("Buscando arquivo de cart$$HEX1$$f500$$ENDHEX$$es.")
		li_busca = This.of_busca_arquivos( ls_Nm_Empresa, Ref ls_log ) 
		
		Choose Case li_busca
			Case 0	
				gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o havia arquivo dispon$$HEX1$$ed00$$ENDHEX$$vel")
				If pb_exibe_msg Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ arquivo dispon$$HEX1$$ed00$$ENDHEX$$vel no FTP",Information!)
				Return True
			Case -1
				gvo_Aplicacao.of_Grava_Log("Erro na busca do arquivo: " + ls_log)
				If pb_exibe_msg Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na busca FTP: " + ls_log,StopSign!)
				Else
					gf_ge202_envia_email_automatico(284, '',ls_log )
				End If
				Return False
		End Choose
	
		//Processa todos os arquivos da empresa
		If ldh_Parametro >= Date('2024/05/20') Then
			If Not This.of_processa_arquivos_novo(ls_Nm_Empresa, pb_exibe_msg, Ref ls_log) Then
				Return False
			End If
		Else
			If Not This.of_processa_arquivos(ls_Nm_Empresa, pb_exibe_msg, Ref ls_log) Then
				Return False
			End If
		End If
		
		//Ao termino da leitura processa a inativa$$HEX2$$e700e300$$ENDHEX$$o
		If Not This.of_processa_inativacao(Ref ls_Log) Then
			Return False
		End If
		
	Next	
		
	Return True
		
Finally
	If IsValid( w_Aguarde ) Then close(w_aguarde)
	
	If Not isNull(ls_log) And Trim(ls_log) <> '' Then
		If pb_exibe_msg Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao processar arquivo Cart$$HEX1$$e300$$ENDHEX$$o Sa$$HEX1$$fa00$$ENDHEX$$de.~rLog: " + ls_log,StopSign!)
		Else
			gf_ge202_envia_email_automatico(284, '', ls_log )
		End If	
	End If
End Try
end function

public function integer of_busca_arquivos (string ps_empresa, ref string ps_log);/*
Conexao antiga
String ls_host	= "sftp.clamed.com.br"
String ls_user	= "clinipam"
String ls_pass	= "v5c_i3r1BiSp"
Long ll_porta = 8222
*/

Date ldt_Parametro

String ls_Filtro_Mes_Atual, ls_Filtro_Mes_Anterior

This.of_carrega_parametros()

Try
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	
	lo_api.of_create_directory(gvo_aplicacao.ivs_path_arquivos + 'cartao_saude')
	lo_api.of_create_directory(gvo_aplicacao.ivs_path_arquivos + 'cartao_saude\processados')
	
	lo_api.of_create_directory(gvo_aplicacao.ivs_path_arquivos + 'cartao_saude\' + ps_Empresa)
	lo_api.of_create_directory(gvo_aplicacao.ivs_path_arquivos + 'cartao_saude\processados\' + ps_Empresa)
	
	This.ivs_diretorio_trabalho 		= gvo_aplicacao.ivs_path_arquivos + 'cartao_saude\' + ps_Empresa + '\'
	This.ivs_diretorio_processado	= gvo_aplicacao.ivs_path_arquivos + 'cartao_saude\processados\' + ps_Empresa + '\'
			
	This.of_set_Path_Remoto(ps_Empresa)
	
	//Buscar Arquivos do mes atual
	ldt_Parametro = Date(String(gf_Getserverdate(), 'YYYY/MM/01'))
	ls_Filtro_Mes_Atual = "PARCERIA_PESSOA_" + String(ldt_Parametro, "YYYYMM") + '*'
	
	//Buscar Arquivos mes anterior
	ldt_Parametro = RelativeDate( ldt_Parametro, -1 )
	ls_Filtro_Mes_Anterior = "PARCERIA_PESSOA_" + String(ldt_Parametro, "YYYYMM") + '*'
	
	dc_uo_sftp lo_SFTP
	lo_SFTP = create dc_uo_sftp
	
	open(w_Aguarde)
	w_Aguarde.Title = 'Buscando arquivo na $$HEX1$$e100$$ENDHEX$$rea FTP, aguarde...'
	
	If Not lo_SFTP.of_get_file( This.ivs_diretorio_trabalho, ivs_path_remoto + '/' + ls_Filtro_Mes_Anterior, is_host, is_user, is_pass, il_porta, Ref ps_log) Then
		Return -1
	End If
	If Not lo_SFTP.of_get_file( This.ivs_diretorio_trabalho, ivs_path_remoto + '/' + ls_Filtro_Mes_Atual, is_host, is_user, is_pass, il_porta, Ref ps_log) Then
		Return -1
	End If
	
	Return 1
	
Finally
	If IsValid(lo_Api) 		Then Destroy(lo_api)					
	If IsValid(lo_SFTP) 	Then Destroy(lo_SFTP)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
End Try 
end function

public subroutine of_set_path_remoto (string ps_empresa);ivs_Path_Remoto = "/home/farmacias/hapvida/Beneficiario/" + lower(ps_Empresa)
end subroutine

public function boolean of_processa_arquivos (string ps_empresa, boolean pb_exibe_msg, ref string ps_mensagem);Boolean lb_Sucesso = False
Boolean lb_Arquivo_Processado = False

Integer li_DirList, li_Row
Integer li_Arquivo, li_Read
Integer li_Qt_Arquivos
Integer li_Qt_Arquivos_Processados
Integer li_Pos_Nm_Arquivo

Long ll_update
Long ll_update_tb_principal
Long ll_Sequencial_Controle_Movimento
Long ll_Total_Registro
Long ll_Linha_Registro

String ls_FileName
String ls_Registro
String ls_log
String ls_CPF
String ls_Existe
String ls_Data_Arquivo

String ls_Arquivos[]

blob lbl_Registro
blob lbl_temp
blob lbl_data


String ls_Aux
long ll_Pos
String ls_insert
String ls_sql_base

String ls_CPF_Incompleto
String ls_Qt_Registros

//Desenv
//ivs_diretorio_trabalho = 'C:\Sistemas\RO\Arquivos\cartao_saude\CLINIPAM\' 
//ivs_diretorio_processado = 'C:\Sistemas\RO\Arquivos\cartao_saude\processados\CLINIPAM\' 

Try
	li_Dirlist = gf_dir_list (ivs_diretorio_trabalho, '', 0, Ref ls_arquivos[])
	
	If li_Dirlist <= 0 Then
		ps_Mensagem = "Erro no Dirlist ou n$$HEX1$$e300$$ENDHEX$$o existem arquivos no FTP da Clinipam"
		gvo_Aplicacao.of_Grava_Log(ps_mensagem)	
		Return False
	End If
	
	//Qt de Arquivos dispobilizados pelas empresas
	li_Qt_Arquivos = UpperBound( ls_arquivos[] )
	
	//Grava controle importacao
	If li_Qt_Arquivos > 0 Then
		If Not This.of_insert_controle_movimento( ps_empresa, li_Qt_Arquivos, Ref ll_Sequencial_Controle_Movimento, Ref ps_Mensagem ) Then
			Return False
		End If
	End If
		
	gvo_Aplicacao.of_Grava_Log("**** INICIO CARTAO SAUDE " + ps_empresa + " ****")
	
	If Not IsValid( w_Aguarde ) Then Open(w_Aguarde)	
	
	For li_row = 1 To li_Qt_Arquivos
		
		ll_update					= 0
		ll_Linha_Registro 		= 0		
		ll_update_tb_principal	= 0
		
		//Limpa a tabela auxiliar a cada arquivo
		delete from cartao_saude_tmp
		using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			gvo_Aplicacao.of_Grava_Log("Erro no delete cartao_saude_tmp.")
			Return false
		Else
			SqlCa.of_Commit()
		End If		
		
		ls_FileName = ls_Arquivos[li_row]
		
		//Verifica se o arquivo j$$HEX1$$e100$$ENDHEX$$ foi processado.
		If Not This.of_verifica_arquivo_processado(ls_FileName, lb_Arquivo_Processado) Then
			Return False
		End If

		If lb_Arquivo_Processado Then
			li_Qt_Arquivos_Processados++
			FileDelete(This.ivs_diretorio_trabalho + ls_FileName)
			Continue
		End If		
		
		This.ivs_nm_arquivo = ls_FileName
		
		w_Aguarde.Title = ps_Empresa + " - Atualizando registros..."
		
		li_Pos_Nm_Arquivo = Pos(This.ivs_nm_arquivo, '_I_')	
		ls_Qt_Registros = midA(This.ivs_nm_arquivo, li_Pos_Nm_Arquivo + 3)
		ls_Qt_Registros = midA(ls_Qt_Registros, 1, LenA(ls_Qt_Registros) -4 )

		ll_Total_Registro = Long( ls_Qt_Registros )
		w_Aguarde.uo_Progress.of_SetMax( ll_Total_Registro )
		
		gvo_Aplicacao.of_Grava_Log("Arquivo: " + This.ivs_diretorio_trabalho + This.ivs_nm_arquivo)		
		li_Arquivo = FileOpen(This.ivs_diretorio_trabalho + This.ivs_nm_arquivo, streammode!)
					
		If li_Arquivo = -1 Then
			ps_mensagem = "Erro na abertura do arquivo '" +  This.ivs_nm_arquivo + "'"
			gvo_Aplicacao.of_Grava_Log(ps_mensagem)	
			Return False
		End If
							 						
		ls_sql_base = "insert into cartao_saude_tmp(nr_cpf) "
		
		DO WHILE FileRead(li_Arquivo, lbl_temp) > 0		  			  
			ls_Aux =   string(lbl_temp, EncodingAnsi!)
			
			//Usado p/ corrigir a quebra de linha a cada leitura do arquivo
			If ls_CPF_Incompleto <> '' Then
				ls_Aux = ',I,' + ls_CPF_Incompleto + ls_Aux
				ll_Pos = PosA(ls_Aux, ',I,')
				ls_CPF_Incompleto = ""
			Else
				ll_Pos = PosA(ls_Aux, ',I,')
			End If
			
			DO
				yield()
				
				//ls_Aux = Mid(ls_Aux, ll_Pos)
				ls_CPF 					= Mid(ls_Aux, ll_Pos + 3, 11)
				
				If lenA(ls_cpf) <> 11 Then
					ls_CPF_Incompleto = ls_CPF
				Else
					ll_Linha_Registro++
					ll_update++
					ll_update_tb_principal++

					w_Aguarde.Title = ps_Empresa + " - Atualizando registros " + String(ll_Linha_Registro) + " de " +String(ll_Total_Registro)
															
					ls_insert += "select '" + ls_CPF + "' nr_cpf union "					
				
					If ll_update = 1000 Then
						//Retira o ultimo union da string
						ls_insert = Mid(ls_insert, 1, LenA(ls_insert) - 7 )
							
						ls_insert = ls_sql_base + ls_insert + " plan '(use ins_by_bulk on)'"
						Execute Immediate :ls_insert Using SqlCa;
		
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_RollBack()
							ps_mensagem = "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o saude, arquivo: "+ This.ivs_nm_arquivo + SqlCa.SqlErrText
							gvo_Aplicacao.of_Grava_Log(ps_mensagem)
							Return False	
						End If
						
						SqlCa.of_Commit()
						
						If Not This.of_atualiza_registros_importados( Ref ps_mensagem ) Then
							gvo_Aplicacao.of_Grava_Log(ps_mensagem)
							gf_ge202_envia_email_automatico (93, 'Erro atualiza$$HEX2$$e700e300$$ENDHEX$$o cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de', ps_mensagem)
							Return False
						End If
						
						ll_update = 0
						ls_insert=""
					End If	
				End If
				
				ls_Aux = Mid(ls_Aux, ll_Pos + 14)
				ll_Pos = PosA(ls_Aux, ',I,')
			LOOP WHILE ll_pos > 0			  
			  
		LOOP
				
		If ls_insert <> "" Then
			//Retira o ultimo union da string
			ls_insert = Mid(ls_insert, 1, LenA(ls_insert) - 7 )
			
			ls_insert = ls_sql_base + ls_insert + " plan '(use ins_by_bulk on)'"
			Execute Immediate :ls_insert Using SqlCa;
	
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack()
				ps_mensagem = "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o saude, arquivo: "+ This.ivs_nm_arquivo + SqlCa.SqlErrText
				gvo_Aplicacao.of_Grava_Log(ps_mensagem)
				Return False	
			End If
			
			SqlCa.of_Commit()
			
			//Atualiza a tabela principal com os ultimos registros do arquivo
			If Not This.of_atualiza_registros_importados( Ref ps_mensagem ) Then
				gvo_Aplicacao.of_Grava_Log(ps_mensagem)
				gf_ge202_envia_email_automatico (93, 'Erro atualiza$$HEX2$$e700e300$$ENDHEX$$o cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de', ps_mensagem)
				Return False
			End If
		End If
		
		//Fecha o arquivo...
		FileClose(li_Arquivo)
		
		//Insere o arquivo na tabela de historico
		insert into cartao_saude_historico_arquivo(cd_convenio, nm_arquivo)
			values( :This.il_Convenio, :This.ivs_nm_arquivo)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_rollback( )
			ps_mensagem = "Erro no insert into cartao_saude_historico_arquivo, arquivo: "+ This.ivs_nm_arquivo + ' - ' + SqlCa.SqlErrText
			gvo_Aplicacao.of_grava_log(ps_mensagem)
			Return False
		End If		
					
		gvo_Aplicacao.of_Grava_Log("Termino leitura: Arquivo: " + This.ivs_nm_arquivo + " Linhas: " +String (ll_Linha_Registro))
			
		//move arquivo para processado
		If FileExists(This.ivs_diretorio_processado + This.ivs_nm_arquivo) Then
			FileDelete(This.ivs_diretorio_processado + This.ivs_nm_arquivo)
		End If
		If FileMove (This.ivs_diretorio_trabalho + This.ivs_nm_arquivo, This.ivs_diretorio_processado + This.ivs_nm_arquivo) > 0 Then
			li_Qt_Arquivos_Processados++
		End If
		
		ls_insert 		= ""
		ls_sql_base 	= ""						
	Next
	
	lb_Sucesso = ( li_Qt_Arquivos_Processados > 0  )
	
	If lb_Sucesso Then
		If Not This.of_update_controle_movimento( ps_empresa, ll_Sequencial_Controle_Movimento, Ref ps_Mensagem) Then
			Return False
		End If
	End If
	
	gvo_Aplicacao.of_Grava_Log("**** TERMINO CARTAO SAUDE " + ps_empresa + " ****")
	
	Return lb_Sucesso

Finally
	//Se houver erro apos a abertura do arquivo, garante o fechamento
	FileClose(li_Arquivo)
	If IsValid( w_Aguarde ) Then Close(w_Aguarde)
End Try
end function

public function boolean of_insert_controle_movimento (string ps_empresa, integer pi_qt_arquivo, ref long pl_sequencial_movimento, ref string ps_msg);Long ll_Sequencial

Date ldt_Registro

ldt_registro = Date(gf_getserverdate())

ps_Empresa = Upper(ps_Empresa)

Select  nr_sequencial 
	Into :ll_Sequencial
From cartao_saude_movimento
Where cd_convenio 	= :This.il_convenio
	and nm_empresa  = :ps_Empresa
	and id_situacao 	= 'A'	
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Update cartao_saude_movimento
		Set 	dh_registro 	= :ldt_registro,
				id_situacao 	= 'A',
				dh_inicio 	= getdate()
		Where cd_convenio 	= :This.il_convenio
			and nr_sequencial = :ll_sequencial
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()						
			ps_msg = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o saude movimento." + SqlCa.SqlErrText
			gvo_Aplicacao.of_Grava_Log(ps_msg)
			Return False
		End If
		
	Case 100				
		Select max(nr_sequencial) 
		  Into :ll_sequencial
		From cartao_saude_movimento
		Where cd_convenio 	= :This.il_convenio
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ps_msg = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o sequencial cartao saude movimento." + SqlCa.SqlErrText
			gvo_Aplicacao.of_Grava_Log(ps_msg)			
			Return False
		Else
			If IsNull(ll_sequencial) Then ll_sequencial = 0
			ll_sequencial = ll_sequencial + 1
		End If						
		
		Insert Into cartao_saude_movimento (cd_convenio,
										nr_sequencial ,
										id_situacao,
										dh_registro,
										dh_inicio,
										nm_empresa,
										qt_arquivo)
		Values (	:This.il_convenio,
					:ll_sequencial,
					'A',
					:ldt_registro,
					getdate(),
					:ps_empresa,
					:pi_qt_arquivo)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()
			ps_msg = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de movimento" + SqlCa.SqlErrText
			gvo_Aplicacao.of_Grava_Log(ps_msg)			
			Return False					
		End If
		
	Case -1
		SqlCa.of_RollBack()
		ps_msg = "Erro verifica$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de movimento" + SqlCa.SqlErrText
		gvo_Aplicacao.of_Grava_Log(ps_msg)		
		Return False									
End Choose
	
SqlCa.of_Commit()

//Retorna por parametro o sequencial da tabela cartao_saude_movimento
pl_Sequencial_Movimento = ll_sequencial

Return True
end function

public function boolean of_processa_inativacao (ref string ps_mensagem);Date ldt_Inativacao

ldt_Inativacao = Date(gf_getserverdate())

//Um arquivo FULL $$HEX1$$e900$$ENDHEX$$ enviado 1 vez por m$$HEX1$$ea00$$ENDHEX$$s no final do m$$HEX1$$ea00$$ENDHEX$$s
//Caso o CPF n$$HEX1$$e300$$ENDHEX$$o seja lido nos arquivos nos $$HEX1$$fa00$$ENDHEX$$ltimos 45 dias ser$$HEX1$$e100$$ENDHEX$$ inativado. 
ldt_Inativacao = RelativeDate(ldt_Inativacao, - 45)

Update cartao_saude
Set id_situacao = 'I'
Where cd_convenio 	= :This.il_convenio
	and dh_registro 	< :ldt_inativacao
	and id_situacao 	= 'A'
	and nr_cartao 		= ''	
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack()
	ps_mensagem = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de Inativa$$HEX2$$e700e300$$ENDHEX$$o cartao saude. Convenio: " + String(This.il_convenio) + " Erro: " + SqlCa.SqlErrText
	gvo_Aplicacao.of_Grava_Log(ps_mensagem)	
	Return False
End If	

SqlCa.of_Commit()

Return True
end function

public function boolean of_update_controle_movimento (string ps_empresa, long pl_sequencial_movimento, ref string ps_mensagem);
//Atualiza para processado

Update cartao_saude_movimento
Set id_situacao = 'P',
	dh_fim = getdate()
Where cd_convenio 	= :This.il_convenio
	and nr_sequencial = :pl_Sequencial_Movimento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack()
	ps_mensagem = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de movimento: Empresa: " + ps_Empresa + ". Erro: " + SqlCa.SqlErrText
	gvo_Aplicacao.of_Grava_Log(ps_mensagem)	
	Return False					
End If

Return True
end function

public subroutine of_set_cod_convenio (string as_empresa);Choose Case Upper(as_empresa)
	Case 'CLINIPAM'; 	This.il_Convenio = 54659
	Case 'HAPVIDA'; 	This.il_Convenio = 55080
	Case 'CCG';	 		This.il_Convenio = 55081
End Choose
end subroutine

public function boolean of_atualiza_registros_importados (ref string ps_mensagem);String ls_CPF

Long ll_Contador

//Delete registros com CPFs incompletos
delete from cartao_saude_tmp where len(nr_cpf) <> 11
using sqlCa;
If SqlCa.SqlCode = -1 Then
	SqlCa.of_rollback( )
	ps_mensagem = "Erro no delete do cartao_saude_tmp (CPF invalido), arquivo: "+ This.ivs_nm_arquivo + ' - ' + SqlCa.SqlErrText
	gvo_Aplicacao.of_grava_log(ps_mensagem)
	Return False
End If
SqlCa.of_Commit()

//Update na tabela principal
update cartao_saude 
	set c.dh_registro 	= getdate(), 	
		 c.id_situacao 	= 'A',
		 c.nm_cliente	= a.nm_cliente
from cartao_saude_tmp a
	inner join cartao_saude c
		on c.nr_cpf 		= a.nr_cpf
where c.cd_convenio	= :This.il_Convenio
using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_rollback( )
	ps_mensagem = "Erro no update do cartao saude, arquivo: "+ This.ivs_nm_arquivo + ' - ' + SqlCa.SqlErrText
	gvo_Aplicacao.of_grava_log(ps_mensagem)	
	Return False
End If

//Insert na tabela principal
Insert Into cartao_saude (cd_convenio, nr_cpf, nm_cliente, nr_cartao, id_situacao, dh_registro )
select distinct :This.il_Convenio, a.nr_cpf, a.nm_cliente,  '', 'A', getdate() 
from cartao_saude_tmp a
  where not exists (select * from cartao_saude 
  								  where cd_convenio 	= :This.il_Convenio
									 and nr_cpf 			= a.nr_cpf )
plan '(use ins_by_bulk on)'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_rollback( )
	ps_mensagem = "Erro no insert into cartao saude, arquivo: "+ This.ivs_nm_arquivo + ' - ' + SqlCa.SqlErrText
	gvo_Aplicacao.of_grava_log(ps_mensagem)
	Return False
End If

//limpa a tabela temporaria
delete from cartao_saude_tmp
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_rollback( )
	ps_mensagem = "Erro no delete cartao saude_tmp, arquivo: "+ This.ivs_nm_arquivo + ' - ' + SqlCa.SqlErrText
	gvo_Aplicacao.of_grava_log(ps_mensagem)
	Return False
End If

//Commit para limpar a tabela temp
SqlCa.of_commit( )

Return True
end function

public function boolean of_verifica_arquivo_processado (string as_arquivo, ref boolean ab_arquivo_processado);Integer li_Count

select count(nm_arquivo)
	into :li_Count
from cartao_saude_historico_arquivo
 where cd_convenio = :This.il_convenio
 	and nm_arquivo = :as_arquivo
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then	
	gvo_Aplicacao.of_Grava_Log("Erro ao localizar o arquivo " + as_arquivo + ". Funcao: of_verifica_arquivo_processado(string,boolean) - " +  SqlCa.sqlerrtext)
	Return False	
End If

//Retorna por referencia
ab_arquivo_processado = (li_Count > 0)

//Retorno da funcao
Return True
end function

public function boolean of_processa_arquivos_novo (string ps_empresa, boolean pb_exibe_msg, ref string ps_mensagem);Boolean lb_Sucesso = False
Boolean lb_Arquivo_Processado = False

Integer li_DirList, li_Row
Integer li_Arquivo
Integer li_Qt_Arquivos
Integer li_Qt_Arquivos_Processados
Integer li_Pos_Nm_Arquivo

Long ll_update
Long ll_update_tb_principal
Long ll_Sequencial_Controle_Movimento
Long ll_Total_Registro
Long ll_Linha_Registro

String ls_FileName
String ls_Registro
String ls_log
String ls_CPF
String ls_Existe
String ls_Data_Arquivo
String ls_Nome_Conveniado

String ls_Arquivos[]

blob lbl_Registro
blob lbl_temp
blob lbl_data


String ls_Aux
String ls_insert
String ls_sql_base
String ls_Qt_Registros

//Desenv
//ivs_diretorio_trabalho = 'C:\Sistemas\RO\Arquivos\cartao_saude\CLINIPAM\' 
//ivs_diretorio_processado = 'C:\Sistemas\RO\Arquivos\cartao_saude\processados\CLINIPAM\' 

Try
	li_Dirlist = gf_dir_list (ivs_diretorio_trabalho, '', 0, Ref ls_arquivos[])
	
	If li_Dirlist <= 0 Then
		ps_Mensagem = "Erro no Dirlist ou n$$HEX1$$e300$$ENDHEX$$o existem arquivos no FTP da Clinipam"
		gvo_Aplicacao.of_Grava_Log(ps_mensagem)	
		Return False
	End If
	
	//Qt de Arquivos dispobilizados pelas empresas
	li_Qt_Arquivos = UpperBound( ls_arquivos[] )
	
	//Grava controle importacao
	If li_Qt_Arquivos > 0 Then
		If Not This.of_insert_controle_movimento( ps_empresa, li_Qt_Arquivos, Ref ll_Sequencial_Controle_Movimento, Ref ps_Mensagem ) Then
			Return False
		End If
	End If
		
	gvo_Aplicacao.of_Grava_Log("**** INICIO CARTAO SAUDE " + ps_empresa + " ****")
	
	If Not IsValid( w_Aguarde ) Then Open(w_Aguarde)	
	
	For li_row = 1 To li_Qt_Arquivos
		
		ll_update					= 0
		ll_Linha_Registro 		= 0		
		ll_update_tb_principal	= 0
		
		//Limpa a tabela auxiliar a cada arquivo
		delete from cartao_saude_tmp
		using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			gvo_Aplicacao.of_Grava_Log("Erro no delete cartao_saude_tmp.")
			Return false
		Else
			SqlCa.of_Commit()
		End If		
		
		ls_FileName = ls_Arquivos[li_row]
		
		//Verifica se o arquivo j$$HEX1$$e100$$ENDHEX$$ foi processado.
		If Not This.of_verifica_arquivo_processado(ls_FileName, lb_Arquivo_Processado) Then
			Return False
		End If

		If lb_Arquivo_Processado Then
			li_Qt_Arquivos_Processados++
			FileDelete(This.ivs_diretorio_trabalho + ls_FileName)
			Continue
		End If		
		
		This.ivs_nm_arquivo = ls_FileName
		
		w_Aguarde.Title = ps_Empresa + " - Atualizando registros..."
		
		li_Pos_Nm_Arquivo = Pos(This.ivs_nm_arquivo, '_I_')	
		ls_Qt_Registros = midA(This.ivs_nm_arquivo, li_Pos_Nm_Arquivo + 3)
		ls_Qt_Registros = midA(ls_Qt_Registros, 1, LenA(ls_Qt_Registros) -4 )

		ll_Total_Registro = Long( ls_Qt_Registros )
		w_Aguarde.uo_Progress.of_SetMax( ll_Total_Registro )
		
		gvo_Aplicacao.of_Grava_Log("Arquivo: " + This.ivs_diretorio_trabalho + This.ivs_nm_arquivo)		
		li_Arquivo = FileOpen(This.ivs_diretorio_trabalho + This.ivs_nm_arquivo, LineMode!)
					
		If li_Arquivo = -1 Then
			ps_mensagem = "Erro na abertura do arquivo '" +  This.ivs_nm_arquivo + "'"
			gvo_Aplicacao.of_Grava_Log(ps_mensagem)	
			Return False
		End If
							 						
		ls_sql_base = "insert into cartao_saude_tmp(nr_cpf, nm_cliente) "
		
		DO WHILE FileRead(li_Arquivo, ls_Aux) > 0		  			  			
			//Usado p/ corrigir a quebra de linha a cada leitura do arquivo
			yield()
										
			ll_Linha_Registro++
			ll_update++
			ll_update_tb_principal++
			
			//Pula a primeira linha
			If ll_Linha_Registro = 1 Then
				Continue
			End If

			If LenA(ls_Aux) <= 40 Then
				//Arquivo antigo, sem nome do conveniado
				Exit
			End If

			//ls_Aux = Mid(ls_Aux, ll_Pos)
			ls_CPF 					= Mid(ls_Aux, 18, 11)
			ls_Nome_Conveniado = Trim(Mid(ls_Aux, 30, 60))
			
			If ls_Nome_Conveniado = "" Then
				ls_Nome_Conveniado = "NAO INFORMADO"
			End If
	
			w_Aguarde.Title = ps_Empresa + " - Atualizando registros " + String(ll_Linha_Registro) + " de " +String(ll_Total_Registro)
													
			ls_insert += "select '" + ls_CPF + "' nr_cpf, '" + ls_Nome_Conveniado + "' nm_cliente union "					
		
			If ll_update = 1000 Then
				//Retira o ultimo union da string
				ls_insert = Mid(ls_insert, 1, LenA(ls_insert) - 7 )
					
				ls_insert = ls_sql_base + ls_insert + " plan '(use ins_by_bulk on)'"
				Execute Immediate :ls_insert Using SqlCa;

				If SqlCa.SqlCode = -1 Then
					SqlCa.of_RollBack()
					ps_mensagem = "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o saude, arquivo: "+ This.ivs_nm_arquivo + SqlCa.SqlErrText
					gvo_Aplicacao.of_Grava_Log(ps_mensagem)
					Return False	
				End If
				
				SqlCa.of_Commit()
				
				If Not This.of_atualiza_registros_importados( Ref ps_mensagem ) Then
					gvo_Aplicacao.of_Grava_Log(ps_mensagem)
					gf_ge202_envia_email_automatico (93, 'Erro atualiza$$HEX2$$e700e300$$ENDHEX$$o cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de', ps_mensagem)
					Return False
				End If
				
				ll_update = 0
				ls_insert=""
			End If  
		LOOP
				
		If ls_insert <> "" Then
			//Retira o ultimo union da string
			ls_insert = Mid(ls_insert, 1, LenA(ls_insert) - 7 )
			
			ls_insert = ls_sql_base + ls_insert + " plan '(use ins_by_bulk on)'"
			Execute Immediate :ls_insert Using SqlCa;
	
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack()
				ps_mensagem = "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o saude, arquivo: "+ This.ivs_nm_arquivo + SqlCa.SqlErrText
				gvo_Aplicacao.of_Grava_Log(ps_mensagem)
				Return False	
			End If
			
			SqlCa.of_Commit()
			
			//Atualiza a tabela principal com os ultimos registros do arquivo
			If Not This.of_atualiza_registros_importados( Ref ps_mensagem ) Then
				gvo_Aplicacao.of_Grava_Log(ps_mensagem)
				gf_ge202_envia_email_automatico (93, 'Erro atualiza$$HEX2$$e700e300$$ENDHEX$$o cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de', ps_mensagem)
				Return False
			End If
		End If
		
		//Fecha o arquivo...
		FileClose(li_Arquivo)
		
		//Insere o arquivo na tabela de historico
		insert into cartao_saude_historico_arquivo(cd_convenio, nm_arquivo)
			values( :This.il_Convenio, :This.ivs_nm_arquivo)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_rollback( )
			ps_mensagem = "Erro no insert into cartao_saude_historico_arquivo, arquivo: "+ This.ivs_nm_arquivo + ' - ' + SqlCa.SqlErrText
			gvo_Aplicacao.of_grava_log(ps_mensagem)
			Return False
		End If		
					
		gvo_Aplicacao.of_Grava_Log("Termino leitura: Arquivo: " + This.ivs_nm_arquivo + " Linhas: " +String (ll_Linha_Registro))
			
		//move arquivo para processado
		FileClose(li_Arquivo)
		If FileExists(This.ivs_diretorio_processado + This.ivs_nm_arquivo) Then
			FileDelete(This.ivs_diretorio_processado + This.ivs_nm_arquivo)
		End If
		If FileMove (This.ivs_diretorio_trabalho + This.ivs_nm_arquivo, This.ivs_diretorio_processado + This.ivs_nm_arquivo) > 0 Then
			li_Qt_Arquivos_Processados++
		End If
		
		ls_insert 		= ""
		ls_sql_base 	= ""						
	Next
	
	lb_Sucesso = ( li_Qt_Arquivos_Processados > 0  )
	
	If lb_Sucesso Then
		If Not This.of_update_controle_movimento( ps_empresa, ll_Sequencial_Controle_Movimento, Ref ps_Mensagem) Then
			Return False
		End If
	End If
	
	gvo_Aplicacao.of_Grava_Log("**** TERMINO CARTAO SAUDE " + ps_empresa + " ****")
	
	Return lb_Sucesso

Finally
	//Se houver erro apos a abertura do arquivo, garante o fechamento
	FileClose(li_Arquivo)
	If IsValid( w_Aguarde ) Then Close(w_Aguarde)
End Try
end function

public function boolean of_carrega_parametros ();String ls_porta

uo_parametro_geral lo_Parametro_Geral
lo_Parametro_Geral = Create uo_parametro_geral

lo_Parametro_Geral.ib_Mostra_Mensagem = False

If Not lo_Parametro_Geral.of_Localiza_Parametro('DE_USER_CARTAO_SAUDE', Ref is_user) Then
	Return False
End If

If Not lo_Parametro_Geral.of_Localiza_Parametro('DE_ENDERECO_CARTAO_SAUDE', Ref is_host) Then
	Return False
End If

If Not lo_Parametro_Geral.of_Localiza_Parametro('DE_SENHA_CARTAO_SAUDE', Ref is_pass) Then
	Return False
End If

If Not lo_Parametro_Geral.of_Localiza_Parametro('NR_PORTA_CARTAO_SAUDE', Ref ls_porta) Then
	Return False
End If
If Isnull(ls_porta) = False And Trim(ls_porta) <> '' Then
	il_porta = Long(Trim(ls_porta))
End If

dc_uo_encript lvo_cripto
lvo_cripto = Create dc_uo_encript

is_pass = lvo_cripto.of_decripta( is_pass, 'cartaosaude', true) 

Destroy(lvo_cripto)
Destroy(lo_Parametro_Geral)

Return True
end function

on uo_ge572_cartao_saude.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge572_cartao_saude.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

