HA$PBExportHeader$uo_ge473_titulo_receber.sru
forward
global type uo_ge473_titulo_receber from nonvisualobject
end type
end forward

global type uo_ge473_titulo_receber from nonvisualobject
end type
global uo_ge473_titulo_receber uo_ge473_titulo_receber

type variables
String is_de_chave_acesso_sap

uo_Titulo ivo_Titulo

Long il_nr_nf
Long il_cd_centro
Long il_cd_portado

DateTime idt_dh_vencimento
//DateTime idt_dh_emissao
DateTime idt_dh_movimento
DateTime idt_dh_sistema
DateTime idt_dh_estorno

String is_nr_titulo
String is_de_serie
String is_de_historico
String is_cd_tipo_documento
String is_nr_matricula_usuario
String is_cd_cliente

Decimal ide_vl_nominal

Long il_Tabela = 138
Long il_nr_requisicao

boolean ib_execucao_simultanea=false

		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_processa_titulo (long al_controle, long al_tabela)
public function boolean of_de_para_usuario (readonly string as_usuario_sap, ref string as_usuario, ref string as_log)
public function boolean of_de_para_filial (readonly string as_centro, ref long al_filial, ref string as_log)
public function boolean of_de_para_portador (readonly string as_portador, ref long al_banco, ref string as_log)
public function boolean of_de_para_cliente (readonly string as_cliente_sap, ref string as_cliente, ref string as_log)
public function boolean of_date_time_ex (string as_valor, string as_coluna, ref datetime adh_valor, ref string as_log)
public function boolean of_insere_movimento_titulo (string ps_titulo, integer pi_nr_movimento, integer pi_tipo_movimento, string ps_responsavel, datetime pdt_sistema, datetime pdt_movimento, decimal pdc_movimento, string ps_historico, long pl_filial, ref string ps_log)
public function boolean of_valida_situacao_estorno_titulo (readonly string as_nr_documento_sap, long al_filial, long al_portador, string as_cliente, string as_tipo, long al_nr_nf, string as_serie, datetime adt_vencimento, ref string as_nr_titulo, ref string as_log, ref boolean ab_estornado)
public function boolean of_valida_situacao_titulo (readonly string as_nr_documento_sap, long al_filial, long al_portador, string as_cliente, string as_tipo, long al_nr_nf, string as_serie, datetime adt_vencimento, ref string as_log)
public function boolean of_insere_titulo (string ps_titulo, long pl_filial, string ps_tipo_titulo, integer pi_portador, datetime pdt_emissao, datetime pdt_vencimento, decimal pdc_nominal, string ps_nr_documento_sap, string ps_cliente, long pl_nr_nf, string ps_serie, string ps_cd_tipo_documento_sap, ref string ps_log)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
			 
	SetNull(is_de_chave_acesso_sap)
	
	SetNull(il_nr_nf)
	SetNull(il_cd_centro)
	SetNull(is_nr_titulo)
	SetNull(is_cd_cliente)
	SetNull(il_cd_portado)
	SetNull(idt_dh_vencimento)
	SetNull(idt_dh_movimento)
	SetNull(idt_dh_sistema)
	SetNull(idt_dh_estorno)
	SetNull(is_de_serie)
	SetNull(is_de_historico)
	SetNull(is_cd_tipo_documento)
	SetNull(is_nr_matricula_usuario)
	SetNull(ide_vl_nominal)
	
	il_Tabela = 138
	ib_execucao_simultanea = false

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando
String ls_id_situacao, ls_erro
Datetime ldh_processamento

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Titulo Receber - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_titulo_receber.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
				
				ll_nr_controle = lds.Object.nr_controle[ll_Linha]
				ls_id_situacao = lds.Object.id_situacao[ll_Linha]
				ldh_processamento = lds.Object.dh_processamento[ll_Linha]
			
				if ls_id_situacao = 'E' and not isnull(ldh_processamento) then
					
					Update interface_sap
					set dh_processamento = null
					where nr_controle = :ll_nr_controle;
					
					if sqlca.sqlcode = -1 then
						ls_erro = sqlca.sqlerrtext
						sqlca.of_rollback( )
						gvo_aplicacao.of_grava_log("Interface Titulo Receber - Erro ao atualizar a tabela interface_sap - uo_ge473_titulo_receber.of_processa_atualizacao" )
					Else
						Sqlca.of_commit( )
					ENd if
					
				End if
			
				uo_ge473_titulo_receber   lo_titulo
				 
				Try
					lo_titulo	= Create uo_ge473_titulo_receber
					lo_titulo.of_processa_titulo( ll_nr_controle,this.il_tabela )
	
				Finally
					Destroy(lo_titulo)
				End Try			
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Titulo Receber - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_titulo_receber.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_processa_titulo (long al_controle, long al_tabela);Boolean lvb_Sucesso = False, lvb_Estornado = False

Long lvl_Atualizacao_Pend
Long lvl_Linhas
Long lvl_Linha
Long lvl_Movto_Estorno

String lvs_Log
String lvs_Log_Compl
String lvs_Chave_Controle
String lvs_Titulo
String lvs_dataHora
String lvs_Valor
String lvs_nr_Documento_Estornado

Integer lvi_Movto_Abertura

Try
		
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	Select de_chave_sap
	Into :is_de_chave_acesso_sap
	From interface_sap  i 
	Where i.cd_tabela = 138
		and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		lvs_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	If Not This.of_inicializa_variaveis(Ref lvs_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref lvl_Atualizacao_Pend, Ref lvs_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If lvl_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref lvs_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref lvs_Chave_Controle, Ref lvs_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref lvs_Log) Then
		
		lvl_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(lvl_linhas)
		end if
		
		For lvl_Linha = 1 To lvl_Linhas
			is_de_serie = Trim(lo_Comum.ids_lista_registros.Object.de_serie[lvl_Linha])
			is_de_historico = Trim(lo_Comum.ids_lista_registros.Object.de_historico[lvl_Linha])
			is_cd_tipo_documento = Trim(lo_Comum.ids_lista_registros.Object.cd_tipo_documento[lvl_Linha])
			il_nr_nf = Long(Trim(lo_Comum.ids_lista_registros.Object.nr_nf[lvl_Linha]))
			is_nr_titulo = Trim(lo_Comum.ids_lista_registros.Object.nr_titulo[lvl_Linha])
			il_cd_portado = Long(Trim(lo_Comum.ids_lista_registros.Object.cd_portado[lvl_Linha]))
			lvs_dataHora = Trim(lo_Comum.ids_lista_registros.Object.dh_vencimento[lvl_Linha])
			lvs_valor = Trim(lo_Comum.ids_lista_registros.Object.vl_nominal[lvl_Linha])
			lvs_nr_documento_estornado = Trim(lo_Comum.ids_lista_registros.Object.nr_documento_estornado[lvl_Linha])
			
			lvs_Log_Compl = 'SAP: Tipo['+is_cd_tipo_documento+&
												'], Titulo['+iif(lvs_nr_documento_estornado<>'',lvs_nr_documento_estornado,is_nr_titulo)+&
												'], NFE['+Trim(lo_Comum.ids_lista_registros.Object.nr_nf[lvl_Linha])+&
												'], Valor['+lvs_valor+&
												'], Vencimento['+lvs_dataHora+'].'
			
			//Z1 - Venda de Ativo 
			//Z2 - Estorno de Ativo
			//Z4 - Venda Licitacao
			//Z5 - Estorno Venda Licitacao
			//ZT - Venda de Sucata
			//ZU - Estorno de Venda de Sucata
			If Pos("|Z1|Z2|Z4|Z5|ZT|ZU|","|"+is_cd_tipo_documento+"|") = 0 Then
				lvs_Log = "O tipo de documento '"+is_cd_tipo_documento+"' n$$HEX1$$e300$$ENDHEX$$o foi previsto na interface. O esperado $$HEX1$$e900$$ENDHEX$$ Z1, Z2, Z4, Z5, ZT ou ZU."
				Return False
			End If
			
			//Estorno
			If Pos("|Z2|Z5|ZU|","|"+is_cd_tipo_documento+"|") > 0 And (IsNull(lvs_nr_documento_estornado) Or lvs_nr_documento_estornado = '') Then
				lvs_Log = "Para o tipo de documento 'Z2' $$HEX1$$e900$$ENDHEX$$ preciso informa o campo [nr_documento_estornado]."
				Return False
			End If
			
			If Not This.of_de_para_usuario(Trim(lo_Comum.ids_lista_registros.Object.nr_matricula_usuario[lvl_Linha]), ref is_nr_matricula_usuario, ref lvs_Log) Then Return False
			If Not This.of_de_para_filial(Trim(lo_Comum.ids_lista_registros.Object.cd_centro[lvl_Linha]), ref il_cd_centro, ref lvs_Log) Then Return False		
			
			If Not This.of_de_para_cliente(Trim(lo_Comum.ids_lista_registros.Object.cd_cliente[lvl_Linha]), ref is_cd_cliente, ref lvs_Log) Then Return False
			// De momento n$$HEX1$$e300$$ENDHEX$$o teremos de-para de portador/banco. Fixo 74801
			//If Not This.of_de_para_portador(lo_Comum.ids_lista_registros.Object.cd_portado[lvl_Linha], ref il_cd_portado, ref lvs_Log) Then Return False
			If il_cd_portado <> 74801 Then
				lvs_Log = "C$$HEX1$$f300$$ENDHEX$$digo do portador/banco '"+String(il_cd_portado)+"' n$$HEX1$$e300$$ENDHEX$$o foi previsto na interface. O esperado $$HEX1$$e900$$ENDHEX$$ 74801."
				Return False
			End If
			il_cd_portado = 50 // sicredi
			
			If Not lo_Comum.of_decimal(Trim(lo_Comum.ids_lista_registros.Object.vl_nominal[lvl_Linha]), 'VL_NOMINAL', ref ide_vl_nominal, ref lvs_Log) Then Return False
			
			lvs_dataHora = Trim(lo_Comum.ids_lista_registros.Object.dh_emissao[lvl_Linha])
			If Pos(lvs_dataHora,'-') > 0 Then 
				If Not of_date_time_ex(lvs_dataHora, 'DH_EMISSAO', ref  idt_dh_movimento, ref lvs_Log) Then Return False
			Else
				If Not lo_Comum.of_date_time(lvs_dataHora, 'DH_EMISSAO', ref  idt_dh_movimento, ref lvs_Log) Then Return False
			End If
			
			//N$$HEX1$$e300$$ENDHEX$$o existe na interface atualmente um campo separado para DH_SISTEMA, deveria pegar BKPF.CPUDT e BKPF.CPUTM
			idt_dh_sistema = idt_dh_movimento
			//Remove a hora, pois os campos TITULO_RECEBER.DH_EMISSAO e MOVIMENTO_TITULO_RECEBER.DH_MOVIMENTO n$$HEX1$$e300$$ENDHEX$$o devem conter data
			// o correto seria pegar a data do campo BKPF.BLDAT
			idt_dh_movimento = Datetime(Date(idt_dh_movimento), Time("00:00:00"))
			
			//O campo do SAP est$$HEX1$$e100$$ENDHEX$$ descendo com somente 1 caracter, est$$HEX1$$e100$$ENDHEX$$ cortando a s$$HEX1$$e900$$ENDHEX$$rie, e na matriz a s$$HEX1$$e900$$ENDHEX$$rie $$HEX1$$e900$$ENDHEX$$ 14
			// para n$$HEX1$$e300$$ENDHEX$$o dar problema at$$HEX1$$e900$$ENDHEX$$ ajustarem foi adicionado o tratamento abaixo
			is_de_serie = IIF(il_CD_Centro=2 and is_de_serie='1','14',is_de_serie)
			

			lvs_dataHora = Trim(lo_Comum.ids_lista_registros.Object.dh_vencimento[lvl_Linha])
			If Not lo_Comum.of_date_time(lvs_dataHora, 'DH_VENCIMENTO', ref  idt_dh_vencimento, ref lvs_Log) Then Return False					
									
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Titulo: ' + is_nr_titulo , 3 )
			end if		
			
			Choose Case is_cd_tipo_documento
				Case "Z1","Z4","ZT" //Novo
					//Verifca titulo existente
					If Not of_valida_situacao_titulo(is_nr_titulo, &
															il_cd_centro, &
															il_cd_portado, &
															is_cd_cliente,&
															"CR", &
															il_nr_nf, &
															is_de_serie, &
															idt_dh_vencimento,&
															ref lvs_Log) Then
						Return False
						
					Else
					
						lvs_Titulo = LeftA(ivo_Titulo.Of_Proximo_Titulo(il_cd_centro),11) + 'XX'
							
						If IsNull(lvs_Titulo) Then 
							lvs_Log = "Erro ao gerar o pr$$HEX1$$f300$$ENDHEX$$ximo n$$HEX1$$fa00$$ENDHEX$$mero de t$$HEX1$$ed00$$ENDHEX$$tulo no sistema. Filial " + string(il_cd_centro)
							Return False
						End If
						
						If of_Insere_Titulo(lvs_Titulo, &
												  il_cd_centro, &
												  "CR", &
												  il_cd_portado, &
												  idt_dh_movimento, &
												  idt_dh_vencimento, &
												  ide_vl_nominal, &
												  is_nr_titulo, /*nr_documento_sap*/&
												  is_cd_cliente, &
												  il_nr_nf, &
												  is_de_serie, &
												  is_cd_tipo_documento, &
												  Ref lvs_Log) Then
												  
							lvi_Movto_Abertura = ivo_Titulo.Of_Movto_Abertura()
							
							If lvi_Movto_Abertura <> 0 Then
							
								If of_Insere_Movimento_Titulo(lvs_Titulo, &
																		 1,&
																		 lvi_Movto_Abertura, &
																		 is_nr_matricula_usuario, &
																		 idt_dh_sistema, &
																		 idt_dh_movimento, &
																		 ide_vl_nominal, &
																		 is_de_historico, &
																		 il_cd_centro, &
																		 Ref lvs_Log) Then lvb_Sucesso = True
							End If
							
						End If
					End If
					
				Case "Z2","Z5","ZU" // Estorno
					lvb_Estornado = False
					If Not of_valida_situacao_estorno_titulo(lvs_nr_documento_estornado, &
																		il_cd_centro, &
																		il_cd_portado, &
																		is_cd_cliente,&
																		"CR", &
																		il_nr_nf, &
																		is_de_serie, &
																		idt_dh_vencimento,&
																		ref lvs_Titulo, &
																		ref lvs_Log, &
																		ref lvb_Estornado) Then
						Return False
					Else
						
						// Se j$$HEX1$$e100$$ENDHEX$$ estiver estornado, n$$HEX1$$e300$$ENDHEX$$o precisa inserir movimento de estorno.
						If lvb_Estornado Then
							lvb_Sucesso = True
						Else
							// Atualiza o movimento de abertura para estornado
							Update movimento_titulo_receber
							Set id_estorno = 'S'
							Where nr_titulo           	= :lvs_Titulo
							  and cd_filial_movimento 	= :il_cd_centro
							  and nr_movimento        	= 1
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								lvs_Log = "Erro ao atualizar movimento de abertura do titulo com o nr_documento_sap '" + is_nr_titulo + "'." + SqlCa.SqlErrText
								lvb_Sucesso = False
							ElseIf SqlCa.sqlnrows <= 0 Then
								lvs_Log = "Erro ao atualizar movimento de abertura do titulo com o nr_documento_sap '" + is_nr_titulo + "'. Movimento n$$HEX1$$e300$$ENDHEX$$o encontrado."
								lvb_Sucesso = False
							Else
								
								//Movimento de estono
								lvl_Movto_Estorno = ivo_Titulo.of_Movto_Estorno_Abertura()
								
								If of_Insere_Movimento_Titulo(	lvs_Titulo, &
																		 2,&
																		 lvl_Movto_Estorno, &
																		 is_nr_matricula_usuario, &
																		 idt_dh_sistema, &
																		 idt_dh_movimento, &
																		 ide_vl_nominal, &
																		 is_de_historico, &
																		 il_cd_centro, &
																		 Ref lvs_Log) Then lvb_Sucesso = True
							
							End If
						End If
					End If
					
				Case Else
					//fim
					
			End Choose
			
			//Commit por titulo
			If lvb_Sucesso Then SqlCa.of_Commit()
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if	
			
		Next
		
	End If
	
Catch ( runtimeerror  lo_rte )
	lvs_Log = "Objeto [uo_ge473_titulo_receber], fun$$HEX2$$e700e300$$ENDHEX$$o [of_processa_titulo]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
		
	If lvb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		If Not IsNull(lvs_Log_Compl) Then lvs_Log = lvs_Log + " "+ lvs_Log_Compl
		lo_Comum.of_grava_erro(al_controle, 179, lvs_Log)
	End If
	
	Destroy lo_Comum	
	
End Try
	
Return True
end function

public function boolean of_de_para_usuario (readonly string as_usuario_sap, ref string as_usuario, ref string as_log);If Trim(as_usuario_sap) = "" or IsNull(as_usuario_sap) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o codigo do Usuario [nr_matricula_usuario]."
	Return False
End If

Select top 1 nr_matricula
Into	:as_usuario
From usuario
Where nr_matricula = :as_usuario_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//OK
	Case 100
		as_usuario = '14330'
		Return True
	Case -1
		as_Log	= "Erro ao localizar o de-para de Usuario SAP e Usuario: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_de_para_filial (readonly string as_centro, ref long al_filial, ref string as_log);String lvs_Filial

If Trim(as_centro) = "" or IsNull(as_centro) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o codigo do Centro [cd_centro]."
	Return False
End If

Select top 1 cd_chave_legado
Into	:lvs_Filial
From integracao_sap
Where cd_tabela = 'FILIAL' 
and cd_chave_sap = :as_centro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//OK
		al_filial = Long(lvs_Filial)
	Case 100
		as_Log	= "De-para de Centro e Filial  n$$HEX1$$e300$$ENDHEX$$o foi localizado. [cd_centro]"
		Return False
	Case -1
		as_Log	= "Erro ao localizar o de-para de Centro e Filial: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_de_para_portador (readonly string as_portador, ref long al_banco, ref string as_log);String lvs_banco

If Trim(as_portador) = "" or IsNull(as_portador) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o codigo do Portador (banco) [cd_portado]."
	Return False
End If

Select top 1 cd_chave_legado
Into	:lvs_banco
From integracao_sap
Where cd_tabela = 'PORTADOR' 
and cd_chave_sap = :as_portador
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//OK
		al_banco = Long(lvs_banco)
	Case 100
		as_Log	= "De-para de Portador e Banco n$$HEX1$$e300$$ENDHEX$$o foi localizado. [cd_portado]"
		Return False
	Case -1
		as_Log	= "Erro ao localizar o de-para de Portador e Banco: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_de_para_cliente (readonly string as_cliente_sap, ref string as_cliente, ref string as_log);If Trim(as_cliente_sap) = "" or IsNull(as_cliente_sap) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o codigo do Cliente [cd_cliente]."
	Return False
End If

Select top 1 cd_cliente
Into	:as_cliente
From cliente
Where cd_cliente_sap = :as_cliente_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//OK
	Case 100
		as_Log	= "De-para de Cliente SAP e Cliente n$$HEX1$$e300$$ENDHEX$$o foi localizado. [cd_cliente]"
		Return False
	Case -1
		as_Log	= "Erro ao localizar o de-para de Cliente SAP e Cliente: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_date_time_ex (string as_valor, string as_coluna, ref datetime adh_valor, ref string as_log);If Trim(as_Valor) =  ''  or isnull( as_Valor ) Then
	SetNull( adh_valor )
Else
	Exception lo_Exp
	lo_Exp = CREATE Exception
	lo_Exp.setMessage("O campo nao contem uma data")
	
	Try
		//20210423-085315
		If len( trim( as_Valor ) ) = 15 Then
			as_Valor = Mid(as_Valor, 1, 4) + '/' + Mid(as_Valor, 5, 2) + '/' + Mid(as_Valor, 7, 2) + ' ' +  Mid(as_Valor, 10, 2) + ':' +  Mid(as_Valor, 12, 2) + ':' +  Mid(as_Valor, 14, 2)
		End If
				
		If len( trim( as_Valor ) ) <> 19 then
			THROW (lo_Exp )
		End IF 
		//
		adh_valor = DateTime(as_Valor)
		//
		If isnull( adh_valor)  then 
			THROW (lo_Exp )
		End IF 
	
	Catch  (Throwable lo_rte )
		as_Log = "O valor informado '" + as_valor + "' para o campo '" + as_coluna + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido. Erro: "+lo_rte.GetMessage( )
		If Isvalid( lo_Exp ) Then Destroy  lo_Exp
		If Isvalid(  lo_rte ) Then Destroy  lo_rte
		Return False						 
	End Try
End If

If Isvalid( lo_Exp ) Then Destroy  lo_Exp
If Isvalid( lo_rte )  Then Destroy  lo_rte

Return True
end function

public function boolean of_insere_movimento_titulo (string ps_titulo, integer pi_nr_movimento, integer pi_tipo_movimento, string ps_responsavel, datetime pdt_sistema, datetime pdt_movimento, decimal pdc_movimento, string ps_historico, long pl_filial, ref string ps_log);INSERT INTO movimento_titulo_receber( nr_titulo,   
												  nr_movimento,   
												  cd_tipo_movimento,   
												  nr_matricula_responsavel,   
												  dh_sistema,   
												  dh_movimento,   
												  dh_credito,   
												  vl_movimento,   
												  vl_multa_recebida,   
												  vl_juros_recebidos,   
												  vl_desconto_concedido,   
												  vl_despesas_recebidas,   
												  id_estorno,   
												  de_historico,   
												  nr_recibo_cobranca,   
												  cd_filial_movimento,   
												  nr_matric_juros_desconto,   
												  cd_filial_atualizacao,   
												  dh_atualizacao_filial )  
VALUES (:ps_Titulo,   
		  :pi_nr_movimento,   
		  :pi_Tipo_Movimento,   
		  :ps_Responsavel,   
		  :pdt_Sistema,   
		  :pdt_Movimento,   
		  :pdt_Movimento,   
		  :pdc_Movimento,    
		  0.00,    
		  0.00,   
		  0.00,   
		  0.00,   
		  'N',   
		  :ps_Historico,   
		  null,   
		  :pl_Filial,   
		  null,   
		  null,   
		  null )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do movimento t$$HEX1$$ed00$$ENDHEX$$tulo receber. " + SqlCa.sqlerrtext
	Return False
End If

Return True
end function

public function boolean of_valida_situacao_estorno_titulo (readonly string as_nr_documento_sap, long al_filial, long al_portador, string as_cliente, string as_tipo, long al_nr_nf, string as_serie, datetime adt_vencimento, ref string as_nr_titulo, ref string as_log, ref boolean ab_estornado);String lvs_Sit
Decimal lvdc_vl_Recebido

// Procura um t$$HEX1$$ed00$$ENDHEX$$tulo da mesma filial, portador, tipo, cliente, documento SAP e data de vencimento.

Select top 1 nr_titulo, 
		id_situacao,
		vl_recebido
Into	:as_nr_titulo,
		:lvs_Sit,
		:lvdc_vl_Recebido
From titulo_receber
Where cd_filial 			= :al_filial
	And cd_portador 		= :al_portador
	And id_tipo_titulo 	= :as_tipo
	And cd_cliente 		= :as_cliente
	And nr_documento_sap = :as_nr_documento_sap
/*	And nr_nf 				= :al_nr_nf   
	And de_especie 		= 'NFE'   
	And de_serie 			= :as_serie*/
	And dh_vencimento		= :adt_vencimento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0 //  Encontrou
		
		// J$$HEX1$$e100$$ENDHEX$$ estornado
		If lvs_Sit = 'E' And lvdc_vl_Recebido = 0 Then
			ab_Estornado = True
			Return True
		End If
		
		// N$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ mais aberto ou j$$HEX1$$e100$$ENDHEX$$ teve algum valor recebido
		If lvs_Sit <> "A" or lvdc_vl_Recebido > 0 Then
			as_Log = "Somente t$$HEX1$$ed00$$ENDHEX$$tulos em aberto e com nenhum valor recebido podem ser estornados."
			Return False
		End If
		
	Case 100
		as_Log = "T$$HEX1$$ed00$$ENDHEX$$tulo n$$HEX1$$e300$$ENDHEX$$o encontrado na tabela titulo_receber para o nr_documento_sap '"+as_nr_documento_sap+"'. Estorno cancelado."
		Return False
		
	Case -1
		as_Log = "Erro ao localizar o t$$HEX1$$ed00$$ENDHEX$$tulo na tabela titulo_receber para o nr_documento_sap '"+as_nr_documento_sap+"'" + SqlCa.SqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_valida_situacao_titulo (readonly string as_nr_documento_sap, long al_filial, long al_portador, string as_cliente, string as_tipo, long al_nr_nf, string as_serie, datetime adt_vencimento, ref string as_log);String lvs_nr_titulo

Select	top 1 nr_titulo
Into	:lvs_nr_titulo
From titulo_receber
Where cd_filial 			= :al_filial
	And cd_portador 		= :al_portador
	And id_tipo_titulo 	= :as_tipo
	And cd_cliente 		= :as_cliente
	And nr_documento_sap = :as_nr_documento_sap
/*	And nr_nf 				= :al_nr_nf   
	And de_especie 		= 'NFE'   
	And de_serie 			= :as_serie*/
	And dh_vencimento 	= :adt_vencimento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//OK
		If Not IsNull(lvs_nr_titulo) And lvs_nr_titulo <> "" Then
			as_Log = "T$$HEX1$$ed00$$ENDHEX$$tulo SAP ("+as_nr_documento_sap+") j$$HEX1$$e100$$ENDHEX$$ gravado na tabela titulo_receber com o n$$HEX1$$fa00$$ENDHEX$$mero: "+lvs_nr_titulo
			Return False
		End If
	Case 100
		//OK pode inserir
	Case -1
		as_Log	= "Erro ao localizar o tilulo na tabela titulo_receber" + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_insere_titulo (string ps_titulo, long pl_filial, string ps_tipo_titulo, integer pi_portador, datetime pdt_emissao, datetime pdt_vencimento, decimal pdc_nominal, string ps_nr_documento_sap, string ps_cliente, long pl_nr_nf, string ps_serie, string ps_cd_tipo_documento_sap, ref string ps_log);Long lvl_Filial_NF

If pl_nr_nf > 0 Then
	lvl_Filial_NF = pl_filial
Else
	SetNull(lvl_Filial_NF)
End If

INSERT INTO titulo_receber ( nr_titulo,   
									  cd_filial,   
									  id_tipo_titulo,   
									  cd_portador,   
									  dh_emissao,   
									  dh_vencimento,   
									  dh_calculo_juros,   
									  vl_nominal,   
									  vl_multa_recebida,   
									  vl_juros_recebidos,   
									  vl_desconto_concedido,   
									  vl_despesas_pagas,   
									  vl_despesas_recebidas,   
									  vl_recebido,   
									  vl_aberto,   
									  id_situacao,   
									  id_carne_bloqueto,   
									  id_protesto,   
									  nr_titulo_banco,   
									  dh_baixa,   
									  cd_convenio,   
									  cd_cliente,   
									  cd_filial_nf,   
									  nr_nf,   
									  de_especie,   
									  de_serie,   
									  nr_titulo_as400,   
									  nr_remessa,   
									  dh_controle_atualizacao_filial,   
									  dh_venda_inicial,   
									  dh_venda_final,   
									  cd_filial_atualizacao,   
									  dh_atualizacao_filial,   
									  cd_fornecedor,   
									  id_perdas_lucros,
									  nr_documento_sap,
									  de_referencia_sap,
									  cd_tipo_documento_sap)  
VALUES (:ps_Titulo,   
		  :pl_Filial,   
		  :ps_Tipo_Titulo,   
		  :pi_Portador,   
		  :pdt_Emissao,   
		  :pdt_Vencimento,   
		  :pdt_Vencimento,   
		  :pdc_Nominal,   
		  0.00,
		  0.00,
		  0.00,   
		  0.00,   
		  0.00,   
		  0.00,   
		  :pdc_Nominal,   
		  'A',   
		  'B',   
		  'N',  
		  null,   
		  null,   
		  null,   
		  :ps_Cliente,   
		  :lvl_Filial_NF,   
		  :pl_Nr_NF,   
		  'NFE',   
		  :ps_Serie,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,
		  :ps_nr_documento_sap,
		  cast(:pl_Nr_NF as varchar),
		  :ps_cd_tipo_documento_sap)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo. " + SqlCa.sqlerrtext
	Return False
End If

Return True
end function

on uo_ge473_titulo_receber.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_titulo_receber.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Destroy(ivo_Titulo)
end event

event constructor;ivo_Titulo   = Create uo_Titulo
end event

