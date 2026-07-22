HA$PBExportHeader$uo_ge473_co_meta_compras.sru
forward
global type uo_ge473_co_meta_compras from nonvisualobject
end type
end forward

global type uo_ge473_co_meta_compras from nonvisualobject
end type
global uo_ge473_co_meta_compras uo_ge473_co_meta_compras

type variables
uo_ge470_sap_comum io_sap_comum
uo_ge473_comum	io_Comum

Long 	 il_nr_controle_interface_sap

Datetime idt_dh_corrente

Boolean ib_execucao_simultanea	= False
Boolean ib_valida_teste_integrado


Decimal {2}	idc_valor_meta_total
Decimal {2}	idc_valor_meta_comprador

Datetime	idh_data_atualizacao 

String		ivs_grupo_comprador
String 	ivs_nr_matricula_cadastramento
String 	ivs_de_chave_acesso_sap	
String 	ivs_dt_meta_periodo

Long il_nr_requisicao
Long il_Tabela_Pai		= 151
Long il_Tabela_Filho  = 152



end variables

forward prototypes
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_atualiza_meta_comprador (long al_controle_pai, ref string as_log)
public function boolean of_atualiza_meta_periodo (long al_controle, ref string as_log)
public function boolean of_valida_usuario (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_processa_atualizacao_meta (long al_controle)
public function boolean of_atualiza_meta_comprador_periodo (long al_controle_filho, ref string as_log)
end prototypes

public function boolean of_inicializa_variaveis (ref string as_log);Try
	// Dados de Cabe$$HEX1$$e700$$ENDHEX$$alho
	setnull(idh_data_atualizacao)
	setnull(ivs_dt_meta_periodo)
	setnull(idc_valor_meta_total)	
	// Dados de Item
	setnull(ivs_grupo_comprador)
	setnull(idc_valor_meta_comprador)
	setnull(ivs_nr_matricula_cadastramento) 
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True


					
			
end function

public function boolean of_atualiza_meta_comprador (long al_controle_pai, ref string as_log);Long ll_Linhas
Long ll_Linha
Long ll_Controle
Long ll_For
Long ll_Controle_filho

String ls_Coluna
String ls_Vl_Item
String ls_Obrig

Long ll_Produto_Legado
String ls_Produto_Sap
String ls_Id_Apagar

Long  ll_Contador = 0

Try
	uo_ge473_comum lo_Comum2
	lo_Comum2 = Create uo_ge473_comum
	
	SELECT nr_controle
	Into  :ll_Controle_filho
	FROM interface_sap  i 
	Where i.cd_tabela = :il_Tabela_Filho
		and i.cd_tabela_pai = :il_tabela_pai
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao verificar o nr controle filho na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If ll_Controle_filho <= 0 OR isNull(ll_Controle_filho) Then 
		as_Log	= "Numero de controle filho inv$$HEX1$$e100$$ENDHEX$$lido, sem controle filho n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel prosseguir."
		Return False
	End If
	
	// Carrega os Dados
	If lo_Comum2.of_processa_carrega_dados(ll_Controle_filho , ref as_log) Then
		
		ll_Linhas = lo_Comum2.ids_lista_registros.RowCount()
		
		If isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		End if
		
		For ll_for = 1 To ll_linhas

			// Reseta os campos
			SetNull(ivs_grupo_comprador) 					//Grupo de Comprador
			SetNull(ivs_nr_matricula_cadastramento)  	//Matricula Legado
			SetNull(idc_valor_meta_comprador) 			

			// Carrega a Informa$$HEX2$$e700e300$$ENDHEX$$o Comprador
			ivs_grupo_comprador 			=  lo_Comum2.ids_lista_registros.Object.grupo_comprador			[ll_for]
			If Not lo_Comum2.of_decimal( lo_Comum2.ids_lista_registros.Object.valor_meta_comprador	[ll_for] , 'VALOR_META_COMPRADOR' , ref idc_valor_meta_comprador, ref as_log, true) Then Return False
			
			If IsNull(ivs_grupo_comprador) or ivs_grupo_comprador = "" Then 
				as_log = "Grupo do Comprador Esta Vazio or Em Branco"
				Return False 
			End If 	
			
			//Localiza grupo de compradores no legado, retorna uma matricula.
			If Not lo_Comum2.of_Localiza_Codigo_Comprador_Legado(ivs_grupo_comprador, Ref ivs_nr_matricula_cadastramento, Ref as_log) Then Return False
			// Verifica o usuario Retornado
			If Not of_valida_usuario(as_log) Then Return False					
		
			//of_atualiza_meta_comprador_periodo
			If Not This.of_atualiza_meta_comprador_periodo(ll_Controle_filho,Ref as_log) Then Return False
					
			ll_Contador++
		Next
		
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Objeto [uo_ge473_co_meta_compras], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_meta_comprador]. Erro: "+lo_rte.GetMessage( )
	Return False
Finally
	Destroy lo_Comum2	
End Try

Return True
end function

public function boolean of_atualiza_meta_periodo (long al_controle, ref string as_log);Decimal  ldc_ValorMetaAtual
String     lvs_Chave
Boolean  lb_Apaga_MetaComprador = False
Boolean  lb_Apaga_Meta = False

SetNull(lvs_Chave)

// Apaga Tudo do Periodo : META_COMPRA_COMPRADOR
Delete from meta_compra_comprador  Where dh_meta  = :ivs_dt_meta_periodo  
Using SqlCA;

Choose Case SqlCa.sqlcode
	Case -1 
		as_log = "Erro ao verificar Meta Periodo Total. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	Case 0, 100
		lb_Apaga_MetaComprador = True 		
End Choose 		

// Apaga Todo Periodo : META_COMPRA
Delete from 	meta_compra Where  dh_meta  = :ivs_dt_meta_periodo
Using SqlCA;	

Choose Case SqlCa.sqlcode
	Case -1 
		as_log = "Erro ao verificar Meta Periodo Total. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	Case 0,100
		lb_Apaga_Meta = True 
End Choose 		

// Insere a Meta do Periodo
If lb_Apaga_MetaComprador and lb_Apaga_Meta Then 
	Insert into meta_compra(dh_meta, vl_meta ) values (:ivs_dt_meta_periodo, :idc_valor_meta_total)
	Using SqlCA;

	If SqlCa.sqlcode = -1 Then
		as_log = "Erro ao Criar Meta Periodo Total. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If 	
		
	lvs_Chave = Mid(ivs_dt_meta_periodo, 9, 2) + '/' + Mid(ivs_dt_meta_periodo, 6, 2) + '/' + Mid(ivs_dt_meta_periodo, 1, 4)
	// Log Alteracao
	If Not gf_Grava_Historico_Alteracao_Tabela('META_COMPRA', lvs_Chave, 'VL_META',"", String(idc_valor_meta_total), '14330', "I", Ref as_log, True) Then 
		as_log = "Erro ao gravar historico tabela META COMPRA."
		Return False
	End if
	
	Return True 	
	
Else
	Return False
End If 
end function

public function boolean of_valida_usuario (ref string as_log);Long	ll_exists

Select 1
Into :ll_exists
From usuario
Where nr_matricula	= :ivs_nr_matricula_cadastramento;
 
Choose Case SQLCA.SQLCode 
	Case -1
		as_Log  = "Erro ao localizar o usu$$HEX1$$e100$$ENDHEX$$rio " + ivs_nr_matricula_cadastramento + ". Erro: " + SQLCA.SQLErrText
		Return False
	Case 100
		as_Log	= 'A matr$$HEX1$$ed00$$ENDHEX$$cula ' + ivs_nr_matricula_cadastramento + ' associada ao comprador com c$$HEX1$$f300$$ENDHEX$$digo SAP ' + ivs_grupo_comprador + " n$$HEX1$$e300$$ENDHEX$$o foi localizada na tabela 'USUARIO'"
		Return False
End Choose

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas, ll_Linha, ll_nr_controle, ll_controles_gerando
dc_uo_ds_base lds 

Try 
	lds  = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject('ds_ge473_lista_meta_compras', False) Then 
		gvo_aplicacao.of_grava_log("Interface Meta de Compras - Erro alterar a DS [ds_ge473_lista_meta_compras] - uo_ge473_co_meta_compras.of_processa_atualizacao" )
		Return
	End If
	ll_Linhas = lds.Retrieve(il_Tabela_Pai)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			uo_ge473_co_meta_compras lo_meta
			Try
				lo_meta	= Create uo_ge473_co_meta_compras
		          lo_meta.of_processa_atualizacao_meta(lds.Object.nr_controle[ll_Linha])
			Finally
				Destroy(lo_meta)
			End Try					
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Meta de Compras - Erro ao recuperar os dados da DS [ds_ge473_lista_meta_compras] - uo_ge473_co_meta_compras.of_processa_atualizacao.")
	End If	
Finally
	Destroy lds
End Try
end subroutine

public function boolean of_processa_atualizacao_meta (long al_controle);dc_uo_ds_base lds

Boolean	lb_Sucesso = False

Long	ll_Linhas,&
		ll_Linha,&
		ll_Atualizacao_Pend,&
		ll_Achou,&
		ll_Nr_Item
	
	
String	ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig		
		
String ls_Log

Select count(*)
Into :ll_Achou
From 	interface_sap i
Where i.cd_tabela = :il_Tabela_Pai
	and nr_controle = :al_controle
	 and id_situacao in ('C', 'E')
	and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 175, "Erro ao verificar controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try
	lds		= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_co_meta_compras], fun$$HEX2$$e700e300$$ENDHEX$$o [of_processa_atualizacao_meta]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_co_meta_compras], fun$$HEX2$$e700e300$$ENDHEX$$o [of_processa_atualizacao_meta]."
		Return False
	End If
	
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_co_meta_compras], fun$$HEX2$$e700e300$$ENDHEX$$o [of_processa_atualizacao_meta]."
		Return False
	End If	
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False

	ib_valida_teste_integrado = gf_valida_teste_integrado()



	If Not ib_valida_teste_integrado then
		If Not io_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
		
		//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
		If ll_Atualizacao_Pend = 0 Then Return True
	End If
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then 
		lb_Sucesso = False
		Return False
	End If	

	For ll_Linha = 1 To ll_Linhas
		ls_Coluna 	= lds.Object.cd_coluna		[ll_Linha]
		ls_Vl_Item	= Upper(lds.Object.vl_item	[ll_Linha])
		ls_Obrig		= lds.Object.id_obrigatorio	[ll_Linha]
		ll_Nr_Item 	= lds.Object.nr_item			[ll_Linha]

		If Trim(ls_Vl_Item) = "" Then
			SetNull(ls_Vl_Item)
		End If
		
		If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref ls_Log) Then
			Return False
		End if
		
		Choose Case  Lower(ls_Coluna)
			Case 'dh_periodo'
				ivs_dt_meta_periodo = ls_Vl_Item + String('01') 
				If len( trim( ivs_dt_meta_periodo ) ) = 8 Then
					ivs_dt_meta_periodo = Mid(ivs_dt_meta_periodo, 1, 4) + '-' + Mid(ivs_dt_meta_periodo, 5, 2) + '-' + Mid(ivs_dt_meta_periodo, 7, 2)
				End If
			Case 'valor_meta_total'				
				If Not io_Comum.of_decimal(lds.Object.vl_item	[ll_Linha] , ls_Coluna , ref idc_valor_meta_total, ref ls_Log, true) Then Return False
		End Choose
	Next
	
	// Faz Atualiza$$HEX2$$e700e300$$ENDHEX$$o: META_COMPRA
	If of_atualiza_meta_periodo(al_controle , Ref ls_Log) Then 
		// Faz Atualiza$$HEX2$$e700e300$$ENDHEX$$o: META_COMPRA_COMPRADOR
		If of_atualiza_meta_comprador (al_controle , Ref ls_Log) Then  
			lb_Sucesso  = True 						
		End If 		
	End If 
	
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_co_meta_compras], fun$$HEX2$$e700e300$$ENDHEX$$o [of_processa_atualizacao_meta]. Erro: "+lo_rte.GetMessage( )
	Return False			
Finally
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 175, ls_Log)
	End If
	Destroy(lds)	
End Try

Return lb_Sucesso
end function

public function boolean of_atualiza_meta_comprador_periodo (long al_controle_filho, ref string as_log);Try 
	Decimal 	ldc_Meta_Anterior
	String 	lvs_Chave

	SetNull(lvs_Chave)
	
	Insert into meta_compra_comprador(dh_meta,nr_matricula_comprador,vl_meta ) Values  (:ivs_dt_meta_periodo, :ivs_nr_matricula_cadastramento,:idc_valor_meta_comprador)
	Using SqlCA;
		
	If SqlCa.sqlcode = -1 Then
		as_log	= "Erro ao cadastrar meta do comprador no periodo. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_filho)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If

	// Log Alteracao
	lvs_Chave = Mid(ivs_dt_meta_periodo, 9, 2) + '/' + Mid(ivs_dt_meta_periodo, 6, 2) + '/' + Mid(ivs_dt_meta_periodo, 1, 4)+"@#!"+ivs_nr_matricula_cadastramento
	If Not gf_Grava_Historico_Alteracao_Tabela('META_COMPRA_COMPRADOR', lvs_Chave, 'VL_META', '', String(idc_valor_meta_comprador), '14330', "I", Ref as_log, True) Then Return False
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Objeto [uo_ge473_co_meta_comprador], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_meta_comprador_periodo]. Erro: "+lo_rte.GetMessage( )
	Return False			
Finally
	//Destroy lo_Comum2	
End Try

Return True 
end function

on uo_ge473_co_meta_compras.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_co_meta_compras.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_sap_comum = Create uo_ge470_sap_comum
io_Comum	= Create uo_ge473_comum	
end event

event destructor;Destroy io_sap_comum
Destroy io_Comum
end event

