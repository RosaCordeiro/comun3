HA$PBExportHeader$uo_ge473_requisicao_mrp_sap_nova.sru
forward
global type uo_ge473_requisicao_mrp_sap_nova from nonvisualobject
end type
end forward

global type uo_ge473_requisicao_mrp_sap_nova from nonvisualobject
end type
global uo_ge473_requisicao_mrp_sap_nova uo_ge473_requisicao_mrp_sap_nova

type variables
String is_tp_alteracao
String is_id_tipo 
String is_NR_Requisicao

Long  il_nr_requisicao 

datetime idt_dh_envio

		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_dados (string as_log)
public function boolean of_insere_requisicao_mrp_sap (ref string as_log)
public function boolean of_insere_requisicao_mrp_sap_item (ref string as_log, long al_controle_pai)
public function boolean of_atualiza_requisicao_mrp_sap (long al_controle, string as_chave)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
			 
	setnull(is_tp_alteracao)
	setnull(is_id_tipo) 
	setnull(is_NR_Requisicao)
	setnull(il_nr_requisicao) 
	setnull(idt_dh_envio)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_valida_dados (string as_log); If IsNull(is_NR_Requisicao) or Not Isnumber(is_NR_Requisicao)  Then
	as_Log	= "O n$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida."
	Return False  
End If

il_nr_requisicao = Long(is_NR_Requisicao)
			
  If IsNull(is_id_tipo) or  trim(is_id_tipo) = ""  then
	as_Log	= "Tipo da requisi$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida."
	Return False  
End If

Return True
end function

public function boolean of_insere_requisicao_mrp_sap (ref string as_log);String ls_Tipo
DateTime ldh_Envio

Select id_tipo, dh_envio
Into :ls_Tipo, :ldh_Envio
From requisicao_mrp_sap
Where nr_requisicao  = :il_nr_requisicao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_Log	= 'Requisi$$HEX2$$e700e300$$ENDHEX$$o [' + String(il_nr_requisicao) + '] j$$HEX1$$e100$$ENDHEX$$ cadastra, tipo [' + ls_Tipo + '].'
		Return False
	Case 100
		Insert into requisicao_mrp_sap (nr_requisicao,id_tipo,dh_envio)
		values(:il_nr_requisicao, :is_id_tipo, :idt_dh_envio)
		Using SqlCA;
			
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao inserir registro na tabela 'requisicao_mrp_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da Requisi$$HEX2$$e700e300$$ENDHEX$$o ["+String(il_nr_requisicao)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
	Case -1
		as_Log	= "Erro ao localizar registro na tabela 'requisicao_mrp_sap'. N$$HEX1$$fa00$$ENDHEX$$mero da Requisi$$HEX2$$e700e300$$ENDHEX$$o ["+String(il_nr_requisicao)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_insere_requisicao_mrp_sap_item (ref string as_log, long al_controle_pai);Long ll_Controle_filho
Long ll_Linha
Long ll_NR_Requisicao
Long ll_Filial
Long ll_Produto
Long ll_QT_Requisicao
Long ll_NR_Item_Requisicao

String ls_Unidade_Medida
String ls_Requisicao_Chave

DateTime ldh_Remessa

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_Requisicao_Chave
	FROM interface_sap  i 
	Where i.cd_tabela = 30
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNumber(ls_Requisicao_Chave) Then
		If Long(ls_Requisicao_Chave) <> il_nr_requisicao Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o informado na chave da INTERFACE_SAP pai e filho est$$HEX1$$e300$$ENDHEX$$o diferentes."
			Return False
		End If
	Else
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o informado na INTERFACE_SAP do filho est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	End If
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			// Requisi$$HEX2$$e700e300$$ENDHEX$$o			
			If IsNull(lo_Comum.ids_lista_registros.Object.nr_requisicao[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.nr_requisicao[ll_Linha]) = '' Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido.' 	
				Return False
			End If
			
			ll_NR_Requisicao = Long(lo_Comum.ids_lista_registros.Object.nr_requisicao[ll_Linha])
			
			If ll_NR_Requisicao <> Long(ls_Requisicao_Chave) Then
				as_Log = 'N$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o da INTERFACE_SAP_ITEM esta diferente da informada no cabe$$HEX1$$e700$$ENDHEX$$alho.'
//				as_Log = 'N$$HEX1$$fa00$$ENDHEX$$mero da requis$$HEX1$$e300$$ENDHEX$$o do item [' + String(ll_NR_Requisicao) + '] est$$HEX1$$e100$$ENDHEX$$ diferente do cabe$$HEX1$$e700$$ENDHEX$$alho ['  + String(il_nr_requisicao) + '], registro pai.'
				Return False
			End If
			// Requisi$$HEX2$$e700e300$$ENDHEX$$o			
			
			// NR item da requisi$$HEX2$$e700e300$$ENDHEX$$o
			If IsNull(lo_Comum.ids_lista_registros.Object.nr_item[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.nr_item[ll_Linha]) = '' Then
				as_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do item do produto [' + String(ll_Produto) + '] da requisi$$HEX2$$e700e300$$ENDHEX$$o [' + String(ll_NR_Requisicao) +  '] inv$$HEX1$$e100$$ENDHEX$$lido.' 	 	
				Return False
			End If
			
			ll_NR_Item_Requisicao = Long(lo_Comum.ids_lista_registros.Object.nr_item[ll_Linha])
			// NR item da requisi$$HEX2$$e700e300$$ENDHEX$$o
			
			// Filial
			If Not lo_Comum.of_Localiza_Codigo_Filial_Legado( lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha] , Ref ll_Filial, Ref as_Log) Then Return False
			
			// Produto
			If Isnull(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha]) = '' Then
				as_Log = 'C$$HEX1$$f300$$ENDHEX$$digo do produto da requis$$HEX1$$e300$$ENDHEX$$o [' + String(ll_NR_Requisicao) + '] inv$$HEX1$$e100$$ENDHEX$$lido.'
				Return False
			End If
						
			If Not lo_Comum.of_Localiza_Codigo_Produto_Legado(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha], Ref ll_Produto, Ref as_Log) Then Return False
			// Produto
			
			// Quantidade da requi$$HEX2$$e700e300$$ENDHEX$$o
			If IsNull(lo_Comum.ids_lista_registros.Object.qt_requisicao[ll_Linha]) or Trim(lo_Comum.ids_lista_registros.Object.qt_requisicao[ll_Linha]) = '' Then
				as_log = 'Quantidade da requisi$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido.' 	
				Return False
			End If
			
			ll_QT_Requisicao = Long(lo_Comum.ids_lista_registros.Object.qt_requisicao[ll_Linha])
			// Quantidade da requisa$$HEX2$$e700e300$$ENDHEX$$o
			
			// Unidade de medida			
			ls_Unidade_Medida = lo_Comum.ids_lista_registros.Object.cd_unidade_medida[ll_Linha]
			
			If IsNull(ls_Unidade_Medida) or Trim(ls_Unidade_Medida) = '' Then
				as_log = 'Unidade de medida do produto ' + String(ll_Produto) + ' da requisi$$HEX2$$e700e300$$ENDHEX$$o ' + String(ll_NR_Requisicao) +  ' inv$$HEX1$$e100$$ENDHEX$$lido.' 	
				Return False
			End If
			// Unidade de medida
			
			// Data da remessa
			If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_remessa[ll_Linha], 'DH_REMESSA', ref ldh_Remessa, ref as_Log) Then Return False
						
			Insert into requisicao_mrp_sap_item(	nr_requisicao,
															nr_item,
															cd_filial,
															cd_produto,
															qt_requisicao,
															cd_unidade_medida,
															dh_remessa)
			values(	:ll_NR_Requisicao,   
						:ll_NR_Item_Requisicao,
						:ll_Filial,
						:ll_Produto,
						:ll_QT_Requisicao,
						:ls_Unidade_Medida ,
						:ldh_Remessa)
			Using SqlCA;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao inserir registro na tabela 'requisicao_mrp_sap_item'. Requisi$$HEX2$$e700e300$$ENDHEX$$o/Produto ["+String(ll_NR_Requisicao)+ "/" + String(ll_Produto) + "]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
		Next	
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_requisicao_mrp_sap_nova], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_requisicao_mrp_sap_item]. Erro: "+lo_rte.GetMessage( )
//	"Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_produto'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_atualiza_requisicao_mrp_sap (long al_controle, string as_chave);Boolean lb_Sucesso = False

Long ll_Atualizacao_Pend
Long ll_Linhas

String ls_Log

Try
	
	Open(w_aguarde)
	w_aguarde.Title = "Processando Requisicao MRP SAP.."
		
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If ll_Linhas = 1 Then
			
			is_NR_Requisicao 	= lo_Comum.ids_lista_registros.Object.nr_requisicao	[1]				
			is_id_tipo  		 	= lo_Comum.ids_lista_registros.Object.id_tipo			[1]		
								
			If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_envio[1], 'DH_ENVIO', ref  idt_dh_envio, ref ls_Log) Then Return False				
					
			If This.of_valida_dados( Ref ls_Log) Then
				
				If IsNumber(as_chave) Then
					If Long(as_chave) <> il_nr_requisicao Then
						ls_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o informado na chave esta diferente da requisi$$HEX2$$e700e300$$ENDHEX$$o da INTERFACE_SAP_ITEM."
						Return False
					End If
				Else
					ls_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o informado na INTERFACE_SAP do pai est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
					Return False
				End If
				
				If This.of_Insere_requisicao_mrp_sap(Ref ls_Log ) Then
					If This.of_insere_requisicao_mrp_sap_item(Ref ls_Log, al_controle) Then
						lb_Sucesso	= True
					End If
				End If
			End If
						
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
		
	End If

Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_requisicao_mrp_sap_nova], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_requisicao_mrp_sap]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
	
	If IsValid(w_aguarde) Then Close( w_aguarde )
End Try
	

Return True
end function

on uo_ge473_requisicao_mrp_sap_nova.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_requisicao_mrp_sap_nova.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

