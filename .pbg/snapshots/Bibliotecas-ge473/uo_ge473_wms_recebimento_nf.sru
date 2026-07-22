HA$PBExportHeader$uo_ge473_wms_recebimento_nf.sru
forward
global type uo_ge473_wms_recebimento_nf from nonvisualobject
end type
end forward

global type uo_ge473_wms_recebimento_nf from nonvisualobject
end type
global uo_ge473_wms_recebimento_nf uo_ge473_wms_recebimento_nf

type variables
String is_de_chave_acesso_sap

//***cabecalho da nota*****
Boolean	ib_Pedido_Ba = False

String is_de_chave_acesso
String is_de_chave_acesso_original
String is_cd_fornecedor
String is_id_status
String is_nr_recebimento
String is_Pedido_SAP

DateTime idt_dh_nota
DateTime idt_dh_recebimento
Long il_nr_pedido
//*********************

//***Item da Nota*********
Long il_nr_item
Long il_cd_produto
Long il_qt_recebida
Long il_qt_recebida_conversao
Long il_cd_filial
Long il_nr_item_xml

String is_cd_unidade_medida
String is_cd_unidade_medida_conversao
//*********************

Long il_Tabela = 99
Long il_nr_requisicao

boolean ib_execucao_simultanea=false
boolean ib_valida_teste_integrado=false
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_recebimento_nota_fiscal (long al_controle, long al_tabela)
public function boolean of_insere_recebimento_nota_fiscal (ref string as_log)
public function boolean of_insere_recebimento_nota_fiscal_item (ref string as_log, long al_controle_pai)
public function boolean of_verifica_distribuidora_sc (string as_fornecedor, ref string as_mensagem_log)
public function boolean of_insere_cabecalho_pedido_central (string as_fornecedor, long al_condicao, long al_tipo_frete, decimal adc_vlped, string as_situacao, string as_chave_acesso, ref long al_pedido, ref string as_mensagem_log, ref boolean ab_erro)
public function boolean of_atualiza_pedido_distribuidora_produto (long al_produto, long al_qt_faturada, long al_cd_pedido_distribuidora, ref string as_mensagem_log)
public function boolean of_nosso_codigo_produto_distrib (string as_fornecedor, long al_produto, ref string as_mensagem_log)
public function boolean of_localiza_pedido_central (ref string as_log)
public function boolean of_inclui_pedido_central (ref string as_mensagem_log, string as_chave, ref boolean ab_erro)
public function boolean of_insere_itens_pedido_central (long al_pedido, ref string as_mensagem_log, string as_fornecedor, ref boolean ab_erro)
public function boolean of_atualiza_recebimento_sap (ref string as_mensagem_log)
public function boolean of_verifica_pedido_distribuidora_filial (ref string as_mensagem_log)
public function boolean of_verifica_pedido_distribuidora_ba (ref string as_mensagem_log)
public function boolean of_retorna_proxima_chave_valida (ref string as_chave_acesso, ref string as_nr_recebimento, ref string as_log)
public function boolean of_exclui_agendamentos_index_destinadas (string as_de_chave_acesso, string as_nova_de_chave_acesso, ref string as_log)
public function boolean of_verifica_transferencia_loja (string as_de_chave_acesso, ref boolean ab_nf_transferencia_loja, ref string as_log)
public function boolean of_descancela_agendamento_entrega (string as_de_chave_acesso, ref string as_log)
public function boolean of_verifica_pendencia_remessa_cancelada (string as_chave_acesso, ref string as_log)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
			 
	//***cabecalho da nota*****
	SetNull(is_de_chave_acesso)
	SetNull(is_cd_fornecedor)
	SetNull(is_id_status)
	SetNull(is_nr_recebimento)
	SetNull(idt_dh_nota)
	SetNull(idt_dh_recebimento)
	SetNull(il_nr_pedido)
	//*********************
	//***Item da Nota*********
	SetNull(il_cd_produto)
	SetNull(il_nr_item)
	SetNull(il_qt_recebida)
	SetNull(il_cd_filial)
	//**********************

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Recebimento NF - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_wms_recebimento_nf.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
			
				uo_ge473_wms_recebimento_nf   lo_receb
				 
				Try
					lo_receb	= Create uo_ge473_wms_recebimento_nf
					lo_receb.of_atualiza_recebimento_nota_fiscal( lds.Object.nr_controle[ll_Linha],this.il_tabela )
	
				Finally
					Destroy(lo_receb)
				End Try			
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Recebimento NF - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_wms_recebimento_nf.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_recebimento_nota_fiscal (long al_controle, long al_tabela);Boolean lb_erro	= False
Boolean lb_Sucesso = False
Boolean lb_nf_transferencia_loja = False
Boolean lb_sem_pendencia

Long ll_Atualizacao_Pend
Long ll_Linhas
Long ll_nr_pedido_novo

String ls_Log
String ls_Chave_Controle

Try
		
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	Select de_chave_sap
	  Into :is_de_chave_acesso_sap
	  From interface_sap  i 
	 Where i.cd_tabela = :il_Tabela
 	   and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
		
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	ib_valida_teste_integrado = gf_valida_teste_integrado()
	
	If Not ib_valida_teste_integrado then
		If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
		
		//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
		If ll_Atualizacao_Pend = 0 Then Return True
	End If
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	if Not of_verifica_transferencia_loja(is_de_chave_acesso_sap, REF lb_nf_transferencia_loja, REF ls_Log) Then Return False
	
	if lb_nf_transferencia_loja then
		lb_Sucesso	= True
		
		Return True	
	end if
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		If ll_Linhas = 1 Then
			
			is_nr_recebimento		= gf_tira_zero_esquerda(lo_Comum.ids_lista_registros.Object.nr_recebimento[1]	)
			is_de_chave_acesso 	= lo_Comum.ids_lista_registros.Object.de_chave_acesso[1]
			is_cd_fornecedor		= lo_Comum.ids_lista_registros.Object.cd_fornecedor [1]	
			is_Pedido_SAP			= lo_Comum.ids_lista_registros.Object.nr_pedido[1]
			is_id_status			= lo_Comum.ids_lista_registros.Object.id_status[1]	
			il_nr_pedido			= Long(lo_Comum.ids_lista_registros.Object.nr_pedido[1])
			
			is_de_chave_acesso_original	= is_de_chave_acesso
			
			if ib_valida_teste_integrado then				
				If Not of_retorna_proxima_chave_valida(is_de_chave_acesso, is_nr_recebimento, ls_Log) Then
					Return False
				End If
				
				if Not of_exclui_agendamentos_index_destinadas(is_de_chave_acesso_original, is_de_chave_acesso, ls_Log) Then
					Return False
				End If
			end if

			If Not lo_Comum.of_localiza_codigo_fornecedor_legado(gf_tira_zero_esquerda(lo_Comum.ids_lista_registros.Object.cd_fornecedor [1]), Ref is_cd_fornecedor, Ref ls_log) Then Return False
						
			If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_nota[1], 'DH_NOTA', ref  idt_dh_nota, ref ls_Log) Then Return False
			If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_recebimento[1], 'DH_RECEBIMENTO', ref  idt_dh_recebimento, ref ls_Log) Then Return False
									
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Nota Fiscal: ' + is_de_chave_acesso , 3 )
			end if					
					
			////////////////////
			If is_id_status = 'X' then
				If not of_verifica_pendencia_remessa_cancelada (is_de_chave_acesso, Ref ls_log) then
					Return False
				End if
			end if

			If Not This.of_Insere_recebimento_nota_fiscal(Ref ls_Log ) 							Then Return False
			If Not This.of_insere_recebimento_nota_fiscal_item(Ref ls_Log, al_controle) 	Then Return False
			If Not This.of_descancela_agendamento_entrega(is_de_chave_acesso, Ref ls_Log) Then Return False
			
			If il_cd_filial = 534 Then
				// Verifica se existe pedido da BA, neste caso o pedido FOI gerado na PEDIDO_DISTRIBUIDORA e enviado para o SAP.
				If Not This.of_verifica_pedido_distribuidora_ba(REF ls_log) Then Return False
				
				if ib_Pedido_Ba then
					// Precisa incluir na PEDIDO_CENTRAL para poder fazer o recebimento no WMS, o il_nr_pedido recebe o novo PEDIDO_CETRAL
					if Not This.of_inclui_pedido_central(REF ls_log, is_de_chave_acesso, REF lb_erro) then Return False
				Else
					// Aqui pega o nr_pedido da pedido_central conforme o nr_pedido_sap, popula/atualiza  il_nr_pedido
					If Not This.of_localiza_pedido_central(ref ls_Log) Then Return False	
				End If
				
				lb_Sucesso	= True		
			Else
				If Not This.of_verifica_pedido_distribuidora_filial(ref ls_Log) Then Return False
				lb_Sucesso	= True		
			End If
			
			// Atualiza pedido e filial
			If Not This.of_atualiza_recebimento_sap(ref ls_Log) Then Return False
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if	
				
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
		
	End If

Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_wms_recebimento_nf], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_recebimento_nota_fiscal]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
	
End Try
	

Return True
end function

public function boolean of_insere_recebimento_nota_fiscal (ref string as_log);Boolean	lb_valida_teste_integrado
DateTime ldt_dh_recebimento
Long		ll_tem
String	ls_nr_recebimento


If Not ib_valida_teste_integrado Then
	Select dh_recebimento
	Into :ldt_dh_recebimento
	From recebimento_sap
	Where nr_recebimento  = :is_nr_recebimento
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			as_Log	= 'Recebimento de Nota Fiscal [' + is_nr_recebimento + '] j$$HEX1$$e100$$ENDHEX$$ emitido na data [' + String(ldt_dh_recebimento,'dd/mm/yyyy') + '].'
			Return False
		Case 100
		Case -1
			as_Log	= "Erro ao localizar registro na tabela 'recebimento_sap'. N$$HEX1$$fa00$$ENDHEX$$mero do recebimento [" + this.is_nr_recebimento +"]. Erro: "+ SqlCa.SqlErrText
			Return False
	End Choose
End If

Select nr_recebimento
  Into :ls_nr_recebimento
  From recebimento_sap
 Where de_chave_acesso  = :is_de_chave_acesso 
 	and id_situacao <> 'X'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		select 1
		  into :ll_tem
		  from (select 1
		  			 from nf_compra
					where de_chave_acesso	= :is_de_chave_acesso
					
				  union
				  
				  select 1
		  			 from nf_compra_pendente
					where de_chave_acesso	= :is_de_chave_acesso) as notas_compra;
					
		Choose Case SQLCA.SQLCode
			Case 100
				delete from recebimento_sap_log
						where nr_recebimento	= :ls_nr_recebimento;
						
				Choose Case SqlCa.SqlCode
					Case -1
						as_Log	= "Erro ao deletar registro na tabela 'recebimento_sap_log'. Recebimento [" + ls_nr_recebimento +"]. Erro: "+ SqlCa.SqlErrText
						Return False
				End Choose
				
				delete from recebimento_sap_item
						where nr_recebimento	= :ls_nr_recebimento;
						
				Choose Case SqlCa.SqlCode
					Case -1
						as_Log	= "Erro ao deletar registro na tabela 'recebimento_sap_log'. Recebimento [" + ls_nr_recebimento +"]. Erro: "+ SqlCa.SqlErrText
						Return False
				End Choose
				
				delete from recebimento_sap
						where nr_recebimento	= :ls_nr_recebimento;
						
				Choose Case SqlCa.SqlCode
					Case -1
						as_Log	= "Erro ao deletar registro na tabela 'recebimento_sap'. Recebimento [" + ls_nr_recebimento +"]. Erro: "+ SqlCa.SqlErrText
						Return False
				End Choose
			Case -1
				as_Log	= "Erro ao verificar registro na tabela 'nf_compra'. Chave de acesso [" + this.is_de_chave_acesso +"]. Erro: "+ SqlCa.SqlErrText
				Return False
			Case 0
				as_Log	= "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel importar o recebimento. Chave de acesso j$$HEX1$$e100$$ENDHEX$$ possui nota fiscal de compra."
				Return False
		End Choose
	Case 100
		//
	Case -1
		as_Log	= "Erro ao localizar registro na tabela 'nf_compra'. Chave de acesso [" + this.is_de_chave_acesso +"]. Erro: "+ SqlCa.SqlErrText
		Return False
End Choose

Insert into recebimento_sap (
	nr_recebimento,
	dh_recebimento,
	dh_nota,
	cd_fornecedor,
	de_chave_acesso,
	nr_pedido,
	id_status,
	dh_inclusao,
	dh_alteracao,
	nr_pedido_sap,
	de_chave_acesso_alterada)
values(
	:this.is_nr_recebimento,
	:this.idt_dh_recebimento,
	:this.idt_dh_nota,
	:this.is_cd_fornecedor,
	:this.is_de_chave_acesso,
	:this.il_nr_pedido,
	:this.is_id_status,
	getDate(),
	getDate(),
	:this.is_Pedido_SAP,
	:this.is_de_chave_acesso_original)
Using SqlCA;
	
If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao inserir registro na tabela 'recebimento_sap'. N$$HEX1$$fa00$$ENDHEX$$mero do recebimento [" + this.is_nr_recebimento +"]. Erro: "+ SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean of_insere_recebimento_nota_fiscal_item (ref string as_log, long al_controle_pai);Long ll_Controle_filho
Long ll_Linha
Long ll_vl_fator_conversao
String ls_Requisicao_Chave

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_Requisicao_Chave
	FROM interface_sap  i 
	Where i.cd_tabela = 100
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho est$$HEX1$$e300$$ENDHEX$$o diferentes."
			Return False
		End If
	End If
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()	
			
			// Chave de acesso da NFe			
			If IsNull(lo_Comum.ids_lista_registros.Object.nr_recebimento[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.nr_recebimento[ll_Linha]) = "" Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do recebimento da Nota Fiscal est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida no filho.' 	
				Return False
			End If
			
			// Chave de acesso da NFe	
			If Not ib_valida_teste_integrado Then
				If Trim(is_nr_recebimento) <> Trim(gf_tira_zero_esquerda(lo_Comum.ids_lista_registros.Object.nr_recebimento[ll_Linha])) Then
					as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do recebimento da Nota Fiscal pai e filho(item) est$$HEX1$$e300$$ENDHEX$$o diferentes.' 	
					Return False
				End If
			End If
			
			il_nr_item					= Long(lo_Comum.ids_lista_registros.Object.nr_item[ll_Linha])
			il_qt_recebida				= Long(gf_replace(lo_Comum.ids_lista_registros.Object.qt_recebida[ll_Linha], '.', ',', 0))
			il_cd_filial				= Long(lo_Comum.ids_lista_registros.Object.cd_centro[ll_Linha])
			il_nr_item_xml				= Long(lo_Comum.ids_lista_registros.Object.nr_item_xml[ll_Linha])
			is_cd_unidade_medida 	= lo_Comum.ids_lista_registros.Object.cd_unidade_medida[ll_Linha]
						
			If Not lo_Comum.of_localiza_codigo_filial_legado(lo_Comum.ids_lista_registros.Object.cd_centro[ll_Linha], Ref il_cd_filial, Ref as_log) Then Return False
			
			If Not lo_Comum.of_localiza_codigo_produto_legado(lo_Comum.ids_lista_registros.Object.cd_produto[ll_Linha], Ref il_cd_produto, Ref as_log) Then Return False
			
			// NR item da tabela
			If IsNull(il_nr_item) or il_nr_item <= 0  Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do item do produto [' + String(il_cd_produto) + '] do recebimento [' + is_nr_recebimento +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If
			
			If IsNull(il_nr_item_xml) or il_nr_item_xml <= 0  Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do item do XML do produto [' + String(il_cd_produto) + '] do recebimento [' + is_nr_recebimento +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If
			
			select vl_fator_conversao
			  into :ll_vl_fator_conversao
			  from produto_geral
			 where cd_produto	= :il_cd_produto;

			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao buscar o fator de convers$$HEX1$$e300$$ENDHEX$$o do produto_geral. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
				Return False
			End If
		
			if ll_vl_fator_conversao > 1 then
				if il_cd_filial <> 534 then
					il_qt_recebida_conversao	= il_qt_recebida * ll_vl_fator_conversao
					is_cd_unidade_medida_conversao	= 'UN'
				else
					il_qt_recebida_conversao	= il_qt_recebida
					is_cd_unidade_medida_conversao	= 'CXU'
				end if
			else
				il_qt_recebida_conversao			= il_qt_recebida
				is_cd_unidade_medida_conversao	= is_cd_unidade_medida
			end if
			
			Insert into recebimento_sap_item
					(	nr_recebimento,
						cd_produto,
						nr_item,
						qt_recebida,
						cd_filial,
						nr_item_xml,
						cd_unidade_medida,
						qt_recebida_original,
						vl_fator_conversao,
						cd_unidade_medida_original)
			values(	:is_nr_recebimento,
						:il_cd_produto,
						:il_nr_item,
						:il_qt_recebida_conversao,
						:il_cd_filial,
						:il_nr_item_xml,
						:is_cd_unidade_medida_conversao,
						:il_qt_recebida,
						:ll_vl_fator_conversao,
						:is_cd_unidade_medida)
			Using SqlCA;
	
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao inserir registro na tabela 'recebimento_sap_item'. Recebimento/Produto [" + is_nr_recebimento + "/" + String(il_cd_produto) + "]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
		Next	
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_wms_recebimento_nf], fun$$HEX2$$e700e300$$ENDHEX$$o [recebimento_sap_item]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_verifica_distribuidora_sc (string as_fornecedor, ref string as_mensagem_log);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From fornecedor f
	Inner Join distribuidora_uf d
		On d.cd_distribuidora = f.cd_fornecedor
Where f.cd_fornecedor = :as_Fornecedor
	And f.cd_fornecedor <> '053404705'
	And f.id_distribuidora = 'S'
	And d.cd_unidade_federacao = 'SC'
	And d.id_homologando_pedido = 'N'
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		If ll_Achou > 0 Then
			Return True
		End If
		
	Case 100
		as_mensagem_log = "O fornecedor que faturou a nota n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ uma distribuidora de SC."
		
	Case -1
		as_mensagem_log = "Erro na localizaca$$HEX2$$e700e300$$ENDHEX$$o do fornecedor em 'SC' ." + SqlCa.SqlErrText		
End Choose

Return False
end function

public function boolean of_insere_cabecalho_pedido_central (string as_fornecedor, long al_condicao, long al_tipo_frete, decimal adc_vlped, string as_situacao, string as_chave_acesso, ref long al_pedido, ref string as_mensagem_log, ref boolean ab_erro);String ls_Frete
String ls_PBM
String ls_Observacao
String ls_Uf

ab_erro = False

ls_PBM = "N"
ls_Observacao = "PEDIDO DE PRODUTOS EXCLUSIVOS PARA A BAHIA"
ls_Uf = "BA"

adc_vlped = Round(adc_vlped, 2)

SetNull(ls_Frete)

uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral

lvo_Parametro.ib_Mostra_Mensagem = False

If Not lvo_Parametro.of_Proximo_Sequencial("NR_ULTIMO_PEDIDO_CENTRAL", ref al_Pedido) Then
	as_mensagem_log = lvo_Parametro.is_Mensagem_Log
	ab_erro = True
	Destroy lvo_Parametro
	Return False
End If

Destroy lvo_Parametro

//------------------Tipo Frete CIF/FOB
If al_Tipo_Frete = 0 Then
	ls_Frete = "CIF"
ElseIf al_Tipo_Frete = 1 Then
	ls_Frete = "FOB"
End If

Insert Into pedido_central( 
		nr_pedido,
		dh_pedido,
		dh_emissao,
		dh_previsao_entrega,
		qt_dias_suprimento,
		cd_fornecedor,
		cd_condicao_pagamento,
		pc_desconto,
		vl_total_pedido,
		id_situacao,
		id_programado,
		nr_matricula_cadastramento,
		id_rede,
		cd_filial,
		de_observacao,
		id_pbm,
		id_tipo_frete,
		de_chave_acesso_nfe,
		id_atende_falta_pedido_uf)
Values(:al_pedido,
		 CONVERT( CHAR( 10 ), getdate(), 111 ),
		 getDate(),
		 CONVERT( CHAR( 10 ), getdate(), 111 ),
		 10,
		 :as_Fornecedor,
		 :al_Condicao,
		 0.00,
		 :adc_vlped,
		 :as_Situacao,
		 'N',
		 '14330',
		 'CIA',
		 534,
		 :ls_Observacao,
		 :ls_PBM,
		 :ls_Frete,
		 :as_chave_acesso,
		 'S')
Using SqlCa;
	
If SqlCa.Sqlcode <> 0 Then
	ab_erro = True
	as_mensagem_log = "Erro no insert do cabe$$HEX1$$e700$$ENDHEX$$alho pedido central. " + SqlCa.SqlErrText
	Return False	
End If

Return True
end function

public function boolean of_atualiza_pedido_distribuidora_produto (long al_produto, long al_qt_faturada, long al_cd_pedido_distribuidora, ref string as_mensagem_log);Update pedido_distribuidora_produto
	Set qt_faturada = :al_Qt_Faturada, 
		 id_situacao = 'F'
Where cd_filial = 534
	And nr_pedido_distribuidora 	= :al_cd_pedido_distribuidora
	And cd_produto 					= :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao atualizar a tabela pedido_distribuidora_produto. " + SqlCa.SqlErrText
	SqlCa.of_Rollback()
	Return False
End If

Return True
end function

public function boolean of_nosso_codigo_produto_distrib (string as_fornecedor, long al_produto, ref string as_mensagem_log);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From distribuidora_produto
Where cd_distribuidora = :as_Fornecedor
	And cd_unidade_federacao = 'SC'
	And cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto " + String(al_Produto) + " na distribuidora " + as_Fornecedor + "."
	Return False
End If

If ll_Achou > 0 Then
	Return True
Else
	as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o relacionamento do produto " + String(al_Produto) + " na distribuidora " + as_Fornecedor + "."
	Return False
End If
end function

public function boolean of_localiza_pedido_central (ref string as_log);If Trim(is_Pedido_SAP) = "" or IsNull(is_Pedido_SAP) Then
	as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o n$$HEX1$$fa00$$ENDHEX$$mero do pedido [nr_pedido_central]."
	Return False
End If

Select nr_pedido
Into	:il_nr_pedido
From pedido_central
Where	nr_pedido_sap = :is_Pedido_SAP
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "Pedido de Compra (" + is_Pedido_SAP + ") ainda n$$HEX1$$e300$$ENDHEX$$o foi importado para o legado."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o Pedido de Compra com o c$$HEX1$$f300$$ENDHEX$$digo SAP (" + is_Pedido_SAP + "): " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_inclui_pedido_central (ref string as_mensagem_log, string as_chave, ref boolean ab_erro);Long ll_Pedido
Long ll_Condicao_Fornecedor
Long ll_Condicao
Long ll_Dias
Long ll_nr_pedido_central

String ls_Mensagem_Erro
String ls_Situacao = "C"
String ls_cd_fornecedor

Decimal	ldc_vl_total_pedido


ab_erro = False

Try	
	select nr_pedido
	  into :ll_Pedido
	  from pedido_central
	 where de_chave_acesso_nfe = :as_chave
	using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			il_nr_pedido = ll_Pedido
			Return True
			
		Case 100
			select a.nr_pedido
			  into :ll_Pedido
			  from pedido_central_chave_acesso_nf a inner join pedido_central p on p.nr_pedido = a.nr_pedido
			 where a.de_chave_acesso = :as_chave
			using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					il_nr_pedido = ll_Pedido
					Return True
					
				Case -1
					ab_erro = True
					as_mensagem_log = "Erro na consulta do pedido central " + as_Chave + ". " + SqlCa.SqlErrText
					Return False
			End Choose
		Case -1
			ab_erro = True
			as_mensagem_log = "Erro na consulta do pedido PBM " + as_Chave + ". " + SqlCa.SqlErrText
			Return False
	End Choose

	select cd_distribuidora,
			 vl_total_pedido
	  into :ls_cd_fornecedor,
	  		 :ldc_vl_total_pedido
	  from pedido_distribuidora
	 where nr_pedido_distribuidora = :il_nr_pedido;
	 
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			ab_erro = True
			as_mensagem_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado o pedido distribuidora."
			Return False
		Case -1
			ab_erro = True
			as_mensagem_log = "Erro ao consultar o pedido distribuidora. " + SqlCa.SqlErrText
			Return False
	End Choose
			  
	select cd_condicao_pagamento
	  into :ll_Condicao_Fornecedor
	  from fornecedor
	 where cd_fornecedor		= :ls_cd_fornecedor
	   and id_distribuidora = 'S'
	 Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			Return False
		Case -1
			ab_erro = True
			as_mensagem_log = "Erro ao localizar a distribuidora no cadastro de fornecedor. " + SqlCa.SqlErrText
			Return False
	End Choose
	
	If Not of_Verifica_Distribuidora_SC(ls_cd_Fornecedor, Ref as_Mensagem_Log) Then Return False

//	If as_cfop <> '5910' Then
		
		/*ll_Dias = DaysAfter( Date(adh_emissao),  Date(adh_vencto ))
				
		select top 1 a.cd_condicao 
		  Into :ll_condicao
		  from condicao_pagamento_parcela a inner join condicao_pagamento b on b.cd_condicao	= a.cd_condicao
		where a.qt_dias_vencimento	= :ll_Dias
		  and b.qt_parcelas 			= 1
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				//OK
			Case 100
				ll_Condicao = ll_Condicao_Fornecedor
			Case -1
				ab_erro = True
				
				as_mensagem_log = "Erro na consulta da condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento utilizando " + String(ll_Dias) + " dias. " + SqlCa.SqlErrText
				
				Return False
		End Choose*/
	/*Else
		// BONIFICADA
		ll_condicao = 50
	End If*/
	
	if of_insere_cabecalho_pedido_central(ls_cd_fornecedor, ll_Condicao_Fornecedor, 0, ldc_vl_total_pedido, ls_Situacao, as_chave, REF ll_nr_pedido_central, REF as_mensagem_log, REF ab_erro) then
		if ab_erro then return false
		
		if of_insere_itens_pedido_central(ll_nr_pedido_central, REF as_mensagem_log, ls_cd_fornecedor, REF ab_erro) then
			if ab_erro then return false
			il_nr_pedido = ll_nr_pedido_central
			return True
		end if
	end if
	
	If Trim(ls_Mensagem_Erro) <> "" Or Not IsNull( ls_Mensagem_Erro ) Then
		as_mensagem_log += ' | ' + ls_Mensagem_Erro
	End If
		
Catch ( runtimeerror  lo_rte )
	as_mensagem_log = "Erro: "+ lo_rte.GetMessage()
End Try
end function

public function boolean of_insere_itens_pedido_central (long al_pedido, ref string as_mensagem_log, string as_fornecedor, ref boolean ab_erro);Boolean lb_PBM
Boolean lb_Reposicao

Decimal ldc_pc_desconto
Decimal ldc_Preco_UN
Decimal ldc_vl_Un
Decimal ldc_vl_desconto = 0
Decimal ldc_vl_desconto_total = 0

Long ll_Total_Itens
Long ll_Row
Long ll_Faturada
Long ll_Produto
Long ll_qt_Pedida

String ls_EAN
String ls_Mensagem_Log
String ls_Insert_Update
String ls_Reposicao_PBM

dc_uo_ds_base lds


ab_erro = False

lds  = Create dc_uo_ds_base
	
If Not lds.of_ChangeDataObject('ds_ge473_lista_produtos_pedido_distribuidora', False) Then 
	gvo_aplicacao.of_grava_log("Interface WMS Recebimento - Erro alterar a DW [ds_ge473_lista_produtos_pedido_distribuidora] - uo_ge473_wms_recebimento_nf.of_insere_itens_pedido_central" )
	Return False
End If

lds.Retrieve(il_nr_pedido)

ll_Total_Itens = lds.RowCount()

// Se for da BA o sistema recebe o n$$HEX1$$fa00$$ENDHEX$$mero do pedido da distribuidora que foi enviado para o SAP

For ll_Row = 1 To ll_Total_Itens
	
	ls_Mensagem_Log		= ""
	lb_PBM 					= False
	ldc_pc_desconto 		= 0
	ldc_Preco_UN			= 0
	
	ll_Faturada	= lds.GetItemNumber(ll_row, 'qt_pedida')
	ll_Produto	= lds.GetItemNumber(ll_row, 'cd_produto')
	
	If Not of_Nosso_Codigo_Produto_Distrib(as_Fornecedor, ll_Produto, Ref ls_Mensagem_Log) Then
		as_Mensagem_Log = ls_Mensagem_Log
		ab_Erro = True
		Return False
	End If
	
	If Not of_atualiza_pedido_distribuidora_produto(ll_Produto, ll_Faturada, il_nr_pedido, Ref ls_Mensagem_Log) Then
		as_Mensagem_Log = ls_Mensagem_Log
		ab_Erro = True
		Return False
	End If
	
	//Verifica Insert/Update
	Select qt_pedida, 
			 vl_preco_unitario
	  Into :ll_qt_Pedida, 
	  		 :ldc_vl_Un
	  From pedido_central_produto
	 Where nr_pedido 	= :al_Pedido
	   and cd_produto = :ll_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			ls_Insert_Update = "U"
		Case 100
			ls_Insert_Update = "I"
		Case -1
			ab_erro = True
			as_mensagem_log = "Erro na consulta 'pedido_central_produto' ( " + String(al_Pedido) + " - " + String( ll_Produto ) + " ) . " + SqlCa.SqlErrText
			Return False	
	End Choose

	ldc_Preco_UN		= lds.GetItemNumber(ll_row, 'vl_preco_unitario')
	
	//Verifica preco UN divergente
	If ls_Insert_Update = "U" And ( ldc_vl_Un <> ldc_Preco_UN ) Then
		as_mensagem_log = "Existem mais de um registro no XML com valores divergentes no vUnCom ' ( " + String(al_Pedido) + " - " + String( ll_Produto ) + " ) EAN: " + ls_EAN
		Return False	
	End If
	
	If ls_Insert_Update = "I" Then
		ldc_pc_desconto	=	 lds.GetItemNumber(ll_row, 'pc_desconto')
		
		ldc_vl_desconto	= Round(ldc_Preco_UN * (ldc_pc_desconto/100), 2)
		
		ldc_vl_desconto_total	= ldc_vl_desconto_total + (ldc_vl_desconto * ll_Faturada)
		
		Insert Into pedido_central_produto(
				nr_pedido,
				cd_produto,
				qt_estoque_momento,
				qt_pedida,
				qt_recebida,
				vl_preco_unitario,
				pc_desconto,
				id_situacao,
				pc_repasse_icms)
		Values(
			:al_Pedido,
			:ll_Produto,
			0,
			:ll_Faturada,
			0,
			:ldc_Preco_UN,
			:ldc_pc_desconto,
			'C',
			null )
		Using SqlCa;
	
		If SqlCa.Sqlcode <> 0 Then
			ab_erro = True
			as_mensagem_log = "Erro no insert do item " + String( ll_Produto ) + " . " + SqlCa.SqlErrText
			Return False	
		End If	
	
	Else
		ll_Faturada	 = ll_qt_Pedida + ll_Faturada
		
		Update pedido_central_produto
			Set qt_pedida 	= :ll_Faturada
		 Where nr_pedido 	= :al_Pedido
		 	and cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.Sqlcode <> 0 Then
			as_mensagem_log = "Erro no update do item " + String( ll_Produto ) + " . " + SqlCa.SqlErrText
			ab_erro = True
			Return False
		End If
	End If
Next

if ldc_vl_desconto_total > 0 then
	update pedido_central
		set pc_desconto = (:ldc_vl_desconto_total / vl_total_pedido) * 100
	 Where nr_pedido 	= :al_Pedido;
	 
	If SqlCa.Sqlcode <> 0 Then
		as_mensagem_log = "Erro no update do desconto. " + SqlCa.SqlErrText
		ab_erro = True
		Return False
	End If
end if

Return True
end function

public function boolean of_atualiza_recebimento_sap (ref string as_mensagem_log);Update recebimento_sap
Set nr_pedido = :il_nr_pedido, cd_filial = :il_cd_filial
Where nr_recebimento =:is_nr_recebimento
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao atualizar a tabela [RECEBIMENTO_SAP]. " + SqlCa.SqlErrText
	SqlCa.of_Rollback()
	Return False
End If

Return True
end function

public function boolean of_verifica_pedido_distribuidora_filial (ref string as_mensagem_log);DateTime ldh_Inicio
String ls_Situacao, ls_id_permite_nota_sem_pedido 


ldh_Inicio = DateTime(RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -100))

// Depois de convertido significa que o pedido que o SAP enviou esta diferente da vari$$HEX1$$e100$$ENDHEX$$vel is_pedido_sap (sem converter para long), 
// neste caso quase 100% que o pedido foi criado pelo SAP, por exemplo, 4500057362
If String(il_nr_pedido) <> String(Long(is_Pedido_SAP)) Then
	as_Mensagem_Log = "Pedido distribuidora enviado pelo SAP '" + String(il_nr_pedido) + "' esta diferente do esperado."
	Return False
End If

select id_permite_nota_sem_pedido 
  into :ls_id_permite_nota_sem_pedido 
  from fornecedor
 where cd_fornecedor	= :is_cd_fornecedor;

Choose Case SqlCa.SqlCode
	Case 100
		as_Mensagem_Log = "O fornecedor " + is_cd_fornecedor + " n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		Return False
	Case -1
		as_Mensagem_Log = "Erro ao localizar o fornecedor " + is_cd_fornecedor + " n$$HEX1$$e300$$ENDHEX$$o foi localizado." + SQLCA.SQLErrText
		Return False
End Choose

Select id_situacao
  Into :ls_Situacao
  From pedido_distribuidora
 Where cd_filial 					 	= :il_cd_filial
	And nr_pedido_distribuidora	= :il_nr_pedido
	And dh_emissao 					>= :ldh_Inicio
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Situacao <> 'F'  and ls_Situacao <> 'C' Then
			as_Mensagem_Log = "A situa$$HEX2$$e700e300$$ENDHEX$$o do pedido distribuidora '" + String(il_nr_pedido) + "' esta diferente do esperado F/C."
			Return False
		End If
		
	Case 100
		if ls_id_permite_nota_sem_pedido = 'S' then
			//SetNull(il_nr_pedido)
			il_nr_pedido	= 0
			
			Return True
		End if

		as_Mensagem_Log = "O pedido recebido do SAP (" + is_Pedido_SAP + ") n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado na tabela [PEDIDO_DISTRIBUIDORA]."
		Return False
	Case -1
		as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido distribuidora " + String(il_nr_pedido)
		Return False
End Choose

Return True
end function

public function boolean of_verifica_pedido_distribuidora_ba (ref string as_mensagem_log);DateTime ldh_Inicio

Long ll_Achou

ldh_Inicio = DateTime(RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -30))

// Depois de convertido significa que o pedido que o SAP enviou esta diferente da vari$$HEX1$$e100$$ENDHEX$$vel is_pedido_sap (sem converter para long), 
// neste caso quase 100% que o pedido foi criado pelo SAP, por exemplo, 4500057362
If String(il_nr_pedido) <> gf_tira_zero_esquerda(is_Pedido_SAP) Then
	ib_Pedido_Ba = False
	Return True
End If
				
Select Count(*)
  Into :ll_Achou
  From pedido_distribuidora
 Where cd_filial = 534
	And nr_pedido_distribuidora = :il_nr_pedido
	And dh_emissao >= :ldh_Inicio
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pedido distribuidora " + String(il_nr_pedido)
	Return False
End If

If ll_Achou > 0 Then
	ib_Pedido_Ba = True

	Update pedido_distribuidora
		Set id_situacao = 'F', 
			 dh_nota_fiscal = getdate()
  	 Where cd_filial = 534
		And nr_pedido_distribuidora = :il_nr_pedido
		And dh_emissao >= :ldh_Inicio
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Mensagem_Log = "Erro ao gravar o 'id_situacao' da tabela pedido_distrbuidora. " + SqlCa.SqlErrText
		SqlCa.of_Rollback()
		Return False
	End If
Else
	ib_Pedido_Ba = False
End If

Return True
end function

public function boolean of_retorna_proxima_chave_valida (ref string as_chave_acesso, ref string as_nr_recebimento, ref string as_log);Long		ll_nr_nf, ll_serie_antiga, ll_serie_nova, ll_count_recebimento
String	ls_nova_serie, ls_serie_antiga


select nr_nf
  into :ll_nr_nf
  from (select nr_nf  
  			 from nf_compra
		   where de_chave_acesso	= :as_chave_acesso
		  union
		  select nr_nf
  			 from nf_compra_pendente
		   where de_chave_acesso	= :as_chave_acesso) as nf;

Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao buscar a nf com chave de acesso. ' + SQLCA.SQLErrText
		Return False
End Choose

ll_count_recebimento	= 0
		
select count(*)
  into :ll_count_recebimento
  from recebimento_sap
 where de_chave_acesso_alterada = :as_chave_acesso;
 
Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao buscar o recebimento_sap com chave de acesso. ' + SQLCA.SQLErrText
		Return False
	Case 0	
		If ll_count_recebimento = 0 Then
			ls_nova_serie	= 'XX0'
		Else
			ll_serie_nova	= ll_count_recebimento + 1
			
			if ll_serie_nova > 99 then
				as_log	= 'Esse recebimento j$$HEX1$$e100$$ENDHEX$$ foi testado o limite de vezes permitido. Favor importar um novo recebimento.'
				Return False
			end if
			
			ls_nova_serie		= Right('XX' + String(ll_serie_nova), 3)
		End If
		
		as_chave_acesso	= Mid(as_chave_acesso, 1, 22) + ls_nova_serie + Mid(as_chave_acesso, 26, 19)
		as_nr_recebimento	= Mid(as_nr_recebimento, 1, 2) + ls_nova_serie + Mid(as_nr_recebimento, 6, 20)
		
		Return True
	Case 100
		Return True
End Choose
end function

public function boolean of_exclui_agendamentos_index_destinadas (string as_de_chave_acesso, string as_nova_de_chave_acesso, ref string as_log);Long	ll_nr_pedido


delete from nf_agendamento_ent_item_lote 
		where de_chave_acesso = :as_de_chave_acesso;

if SQLCA.SQLCode = -1 then
	as_log	= "Erro ao excluir nf_agendamento_ent_item_lote " + SQLCA.SQLErrText
	Return False
end if
		
delete from nf_agendamento_ent_item 
		where de_chave_acesso = :as_de_chave_acesso;

if SQLCA.SQLCode = -1 then
	as_log	= "Erro ao excluir nf_agendamento_ent_item " + SQLCA.SQLErrText
	Return False
end if
		
delete from nf_agendamento_ent_titulo 
		where de_chave_acesso = :as_de_chave_acesso;
		
if SQLCA.SQLCode = -1 then
	as_log	= "Erro ao excluir nf_agendamento_ent_titulo " + SQLCA.SQLErrText
	Return False
end if
		
delete from nf_agendamento_ent 
		where de_chave_acesso = :as_de_chave_acesso;
		
if SQLCA.SQLCode = -1 then
	as_log	= "Erro ao excluir nf_agendamento_ent " + SQLCA.SQLErrText
	Return False
end if

delete from nfe_destinadas 
		where de_chave_acesso = :as_de_chave_acesso;
		
if SQLCA.SQLCode = -1 then
	as_log	= "Erro ao excluir nfe_destinadas " + SQLCA.SQLErrText
	Return False
end if

delete from nfe_indexacao_item 
		where id_nf = :as_de_chave_acesso;

if SQLCA.SQLCode = -1 then
	as_log	= "Erro ao excluir nfe_indexacao_item " + SQLCA.SQLErrText
	Return False
end if
		
delete from nfe_indexacao 
		where id_nf = :as_de_chave_acesso;

if SQLCA.SQLCode = -1 then
	as_log	= "Erro ao excluir nfe_indexacao " + SQLCA.SQLErrText
	Return False
end if

update pedido_central
	set de_chave_acesso_nfe = null
 Where de_chave_acesso_nfe = :as_de_chave_acesso
 Using SqlCa;

if SQLCA.SQLCode = -1 then
	as_log	= "Atualizar pedido central " + SQLCA.SQLErrText
	Return False
end if

Return True
end function

public function boolean of_verifica_transferencia_loja (string as_de_chave_acesso, ref boolean ab_nf_transferencia_loja, ref string as_log);Long	ll_exists


select top 1 1
  into :ll_exists
  from nf_transferencia_nfe
 where cd_filial_origem <> 534
 	and de_chave_acesso	= :as_de_chave_acesso;
	 
Choose Case SQLCA.SQLCode
	Case -1
		as_log	= "Erro ao consultar a nf_transferencia_nfe. " + SQLCA.SQLErrText
		
		Return False
	Case 100
		ab_nf_transferencia_loja	= False
	Case 0
		ab_nf_transferencia_loja	= True
End Choose

Return True
end function

public function boolean of_descancela_agendamento_entrega (string as_de_chave_acesso, ref string as_log);Long ll_Achou

Select Coalesce(Count(*),0)  
Into :ll_Achou
From	nf_agendamento_ent
where de_chave_acesso	=:as_de_chave_acesso
and     dh_cancelamento_agendamento  is not null 
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
		If ll_Achou >0 Then 
				Update nf_agendamento_ent
				Set dh_cancelamento_agendamento	= null,
					 nr_matricula_canc_agendamento	= null,
					 de_motivo_canc_agendamento  	= null
				Where de_chave_acesso = :as_de_chave_acesso
				Using SqlCa;
		
				If SqlCa.SqlCode = -1 Then
					as_log = "Erro ao descancelar o agendamento"+SqlCa.SqlErrText
					SqlCa.of_Rollback()
					Return False
				End If	
		End If 						
	Case -1
		as_log = "Erro ao localizar agendamento cancelado tabela [NF_AGENDAMENTO_ENT]. " + SqlCa.SqlErrText
		SqlCa.of_Rollback()
		Return False
End Choose

Return True 
end function

public function boolean of_verifica_pendencia_remessa_cancelada (string as_chave_acesso, ref string as_log);Integer	li_pendencia
Long		ll_lote
Long		ll_nf
String	ls_especie
String	ls_serie

//
//	Lista as pend$$HEX1$$ea00$$ENDHEX$$ncias existentes para a remessa cancelada
//

as_log = 'Chave de acesso ' + as_chave_acesso + ' (remessa cancelada):~n~r'

//Verifica se existe agendamento de entrega para a chave de acesso

SELECT TOP 1
		 nr_nf
	  , de_especie
	  , de_serie
  INTO :ll_nf
	  , :ls_especie
	  , :ls_serie
  FROM nf_agendamento_ent
 WHERE de_chave_acesso = :as_chave_acesso
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_log = 'Erro ao verificar se existe agendamento de entrega para a chave de acesso: ' + as_chave_acesso + '. Erro: ' + SQLCA.SQLErrText
		Return False
	case 0
		li_pendencia ++
		as_log       += 'Agendamento de entrega: NF ' + String (ll_nf) + '/' + ls_especie + '/' + ls_serie + '.~n'
End choose

//Verifica se existe uma nota de compra pendente

SELECT TOP 1
		 nr_nf
	  , de_especie
	  , de_serie
  INTO :ll_nf
	  , :ls_especie
	  , :ls_serie
  FROM nf_compra_pendente
 WHERE de_chave_acesso = :as_chave_acesso
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_log = 'Erro ao verificar se existe NF de compra pendente para a chave de acesso: ' + as_chave_acesso + '. Erro: ' + SQLCA.SQLErrText
		Return False
	case 0
		li_pendencia ++
		as_log       += 'NF de compra pendente: ' + String (ll_nf) + '/' + ls_especie + '/' + ls_serie + '.~n'
End choose

//Verifica se existe uma nota de compra

SELECT TOP 1
		 nr_nf
	  , de_especie
	  , de_serie
  INTO :ll_nf
	  , :ls_especie
	  , :ls_serie
  FROM nf_compra
 WHERE de_chave_acesso = :as_chave_acesso
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_log = 'Erro ao verificar se existe NF de compra para a chave de acesso: ' + as_chave_acesso + '. Erro: ' + SQLCA.SQLErrText
		Return False
	case 0
		li_pendencia ++
		as_log       += 'NF de compra: ' + String (ll_nf) + '/' + ls_especie + '/' + ls_serie + '.~n'
End choose

//Verifica se existe um lote de recebimento

SELECT TOP 1
		 lr.nr_lote
	  , nfc.nr_nf
	  , nfc.de_especie
	  , nfc.de_serie
  INTO :ll_lote
	  , :ll_nf
	  , :ls_especie
	  , :ls_serie
  FROM lote_recebimento lr
		 INNER JOIN lote_recebimento_nf lrn
					ON	 lrn.nr_lote = lr.nr_lote
		 INNER JOIN nf_compra nfc
					ON  nfc.cd_fornecedor = lr.cd_fornecedor
					AND nfc.nr_nf         = lrn.nr_nf
					AND nfc.de_especie    = lrn.de_especie
					AND nfc.de_serie      = lrn.de_serie
 WHERE nfc.de_chave_acesso = :as_chave_acesso
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_log = 'Erro ao verificar se existe lote de recebimento para a NF com chave de acesso: ' + as_chave_acesso + '. Erro: ' + SQLCA.SQLErrText
		Return False
	case 0
		li_pendencia ++
		as_log       += 'Ordem de recebimento: ' + String (ll_lote)
End choose

If li_pendencia > 0 then
	Return False
End if

as_log = ''

Return True
end function

on uo_ge473_wms_recebimento_nf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_wms_recebimento_nf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

