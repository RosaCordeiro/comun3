HA$PBExportHeader$uo_ge473_requisicao_mrp_sap.sru
forward
global type uo_ge473_requisicao_mrp_sap from nonvisualobject
end type
end forward

global type uo_ge473_requisicao_mrp_sap from nonvisualobject
end type
global uo_ge473_requisicao_mrp_sap uo_ge473_requisicao_mrp_sap

type variables
uo_ge473_comum io_Comum

String  is_tp_alteracao

//Long    il_cd_filial_legado, &			  
//		  il_cd_produto_legado, &
//		  il_qt_faturada

//String is_cd_produto_sap,    &
//		 is_filial_sap 
//       
		 
String is_id_tipo 

//Int     ii_nr_item , &
//        ii_qt_requisicao 
//       
		 
Long  il_nr_requisicao 

datetime idt_dh_envio, &
              idt_dh_processado 
			  

		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_atualiza_requisicao_mrp_sap (long al_controle)
public function boolean of_valida_dados (string as_log)
public function boolean of_grava_historico_requisicao_mrp_sap (long al_requisicao, ref string as_log)
public function boolean of_insere_requisicao_mrp_sap (long al_requisicao, ref string as_log)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
		 setnull(  is_tp_alteracao  )
		 setnull(  is_id_tipo )
		 setnull(  il_nr_requisicao )
		 setnull(  idt_dh_envio )
		 setnull(  idt_dh_processado )

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_atualiza_requisicao_mrp_sap (long al_controle);dc_uo_ds_base lds

Long	ll_Filial,&
		ll_Produto,&
		ll_nr_requisicao, &
		ll_Achou,&
		ll_Linhas,&
		ll_Linha, &
		ll_item_ini, &
		ll_item_fim, &
		ll_loop
		
String	ls_Log,&
		ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig
		
Boolean	lb_Sucesso = False

Boolean  lb_achou

//Long ll_itemx

Select count(*)
Into :ll_Achou
From 	interface_sap
Where nr_controle = :al_controle
and id_situacao in ('C', 'E')
and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 177, "Erro ao mudar a situacao na tabela interface_sap. Numero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try

	lds		= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_requisicao_mrp_sap], funcaoo [of_atualiza_requisicao_mrp_sap]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve( al_controle )
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_requisicao_mrp_sap], funcao [of_atualiza_requisicao_mrp_sap]."
		Return False
	End If
	//
	If ll_Linhas = 0 Then
		ls_Log = "Nao foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_requisicao_mrp_sap], funcao [of_atualiza_requisicao_mrp_sap]."
		Return False
	End If	
	//	
	ll_item_ini   = lds.object.nr_item[1]
	ll_item_fim  = lds.object.nr_item[  lds.rowcount() ]
	//
	Open(w_aguarde)
	w_aguarde.Title = "Processando Requisicao MRP SAP.."
	
	w_aguarde.uo_Progress.Of_SetMax( ll_item_fim )
	Yield()
	w_aguarde.uo_progress.Of_SetProgress( 1 )	 
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	for ll_loop = ll_item_ini to ll_item_fim
		w_aguarde.uo_progress.Of_SetProgress( ll_loop )	 
		w_aguarde.Title = "Processando Item : " + String( ll_loop ) +" de " + string( ll_item_fim  )
		//
		lds.setfilter("nr_item = " +  string( ll_loop) )
		lds.filter()	
		//	
		If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
		//
		For ll_Linha = 1 To  lds.rowcount()
		
			ls_Coluna 	= lds.Object.cd_coluna		[ll_Linha]
			ls_Vl_Item	= lds.Object.vl_item			[ll_Linha]
			ls_Obrig		= lds.Object.id_obrigatorio	[ll_Linha]
			
			ls_VL_Item = Upper(trim(ls_VL_Item))
			
			If Trim(ls_Vl_Item) = "" Then
				SetNull(ls_Vl_Item)
			End If
			
			If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref ls_Log) Then
				Return False
			End if
			
			Choose Case  Lower(trim( ls_Coluna ))			
				Case 'nr_requisicao'
					il_nr_requisicao = long( ls_Vl_Item )				
				Case 'id_tipo'
					is_id_tipo  =   ls_Vl_Item 				
				Case 'dh_envio'
					If Not io_Comum.of_date_time(ls_Vl_Item, 'DH_ENVIO', ref  idt_dh_envio, ref ls_Log) Then Return False				
				Case 'dh_processado'
					If Not io_Comum.of_date_time( ls_Vl_Item, 'DH_PROCESSADO', ref idt_dh_processado, ref ls_Log) Then Return False			
			End choose
		Next
		
		If isnull( il_nr_requisicao ) then 
			ls_Log = 'Numero da Requuisicao est$$HEX1$$e100$$ENDHEX$$ invalido!'
			Return False
		End IF 
		
		lb_Sucesso	= False
		
		If This.of_valida_dados( Ref ls_Log) Then
			If This.of_grava_historico_requisicao_mrp_sap( il_nr_requisicao, Ref ls_Log ) Then
				If This.of_Insere_requisicao_mrp_sap( il_nr_requisicao, Ref ls_Log ) Then
					lb_Sucesso	= True
				End If
			End If
		End If
		
		If not lb_Sucesso then Exit
	
	Next	
Finally 
	If IsValid(w_aguarde) Then Close( w_aguarde )		
	
	If lb_Sucesso Then
		// SqlCa.of_Commit()  // O commit ser$$HEX1$$e100$$ENDHEX$$ no final da gravacao do $$HEX1$$ed00$$ENDHEX$$tem
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro( al_controle , 177, ls_Log)
	End If
	
	Destroy(lds)
End Try

Return lb_Sucesso
end function

public function boolean of_valida_dados (string as_log);Try


     If IsNull(  il_nr_requisicao  ) or ( Isnumber (String( il_nr_requisicao) ) = False) Then
		as_Log	= "O Numero da Requisicao est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False  
	End If
		
     If IsNull(  is_id_tipo  ) or  trim( is_id_tipo ) = ""  then
		as_Log	= "O Tipo de Requisi$$HEX2$$e700e300$$ENDHEX$$o esta invalido."
		Return False  
	End If

  
     If Isnull(  idt_dh_envio ) or (idt_dh_envio < datetime('2000-01-01 00:00:00'))  then
		as_Log	= "A Data de Envio da Requisicao nao passou na validacao!"
		Return False
	End If	

     If  idt_dh_processado  < datetime('2000-01-01 00:00:00')  then
		as_Log	= "A Data de Processamento esta invalida!"
		Return False
	End If	

 	
Catch ( runtimeerror   lo_rte )   
	as_Log = "Ocorreu erro na funcao 'of_valida_grava'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_grava_historico_requisicao_mrp_sap (long al_requisicao, ref string as_log);
String  ls_id_tipo

DateTime ldt_dh_envio , &
               ldt_dh_processado

Int  li_qt_requisicao 

//------- Trata o Header -------//

Try			

	Select  id_tipo,
	dh_envio,
	dh_processado
	Into    :ls_id_tipo,
	:ldt_dh_envio,
	:ldt_dh_processado 
	From requisicao_mrp_sap	
	Where	nr_requisicao = :al_requisicao
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			is_tp_alteracao = 'A'
		Case 100
			is_tp_alteracao = 'I'
		Case -1
			as_Log	= "Erro no select da tabela 'requisicao_mrp_sap', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_requisicao_mrp_sap'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	IF  is_tp_alteracao = 'A' Then 
		If ( ls_id_tipo	<> is_id_tipo  ) or (IsNull( ls_id_tipo ) and Not IsNull( is_id_tipo )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela("REQUISICAO_MRP_SAP",  String( al_requisicao )  , "ID_TIPO" , String( ls_id_tipo ), String(  is_id_tipo ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
		
		If ( ldt_dh_envio <> idt_dh_envio ) or (IsNull( ldt_dh_envio ) and Not IsNull( idt_dh_envio )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP",  String( al_requisicao )  , "DH_ENVIO" , String( ldt_dh_envio, 'dd/mm/yyyy' ), String( idt_dh_envio, 'dd/mm/yyyy' ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
		
		If ( ldt_dh_processado <> idt_dh_processado  ) or (IsNull( ldt_dh_processado ) and Not IsNull( idt_dh_processado )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP",  String( al_requisicao )  , "DH_PROCESSADO" , String( ldt_dh_processado, 'dd/mm/yyyy' ), String( idt_dh_processado, 'dd/mm/yyyy' ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
	
	End IF
	
	IF  is_tp_alteracao = 'I' Then 
		If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP",  String( al_requisicao ) , "NR_REQUISICAO" ,   "Null" , String( al_requisicao )                            ,  'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP",  String( al_requisicao ) , "ID_TIPO" ,               "Null" , is_id_tipo                                              ,   'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP",  String( al_requisicao ) , "DH_ENVIO" ,            "Null" , String( idt_dh_envio, 'dd/mm/yyyy' )        ,  'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP",  String( al_requisicao ) , "DH_PROCESSADO" , "Null" , String( idt_dh_processado, 'dd/mm/yyyy' ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
	End IF		

Catch ( runtimeerror  lo_rte_header )
	as_Log = "Ocorreu erro ao gravar o Header funcao 'of_grava_historico_requisicao_mrp_sap'. Erro: "+lo_rte_header.GetMessage( )
	Return False						 
End Try		

If isvalid( lo_rte_header ) then destroy lo_rte_header	

Return True
end function

public function boolean of_insere_requisicao_mrp_sap (long al_requisicao, ref string as_log);
If is_tp_alteracao = 'A' Then  

	Update requisicao_mrp_sap 
	set  id_tipo             = :is_id_tipo,
	dh_envio  	      = :idt_dh_envio,
	dh_processado = :idt_dh_processado 
	Where nr_requisicao 	= :al_requisicao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao atualizar os dados da tabela 'requisicao_mrp_sap'. Numero da Requisicao  ["+string(al_requisicao)+"],  Erro: "+ SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.SqlNRows <> 1 Then
		as_Log	= "Deveria ter atualizado 1 linha na tabela 'requisicao_mrp_sap', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). N$$HEX1$$fa00$$ENDHEX$$mero da Requisi$$HEX2$$e700e300$$ENDHEX$$o ["+string( al_requisicao) +"]. "
		Return False
	End If

End If 
			//
If is_tp_alteracao = 'I' then
	Insert into requisicao_mrp_sap (	nr_requisicao,
												id_tipo,
												dh_envio,
												dh_processado )
	values(	:al_requisicao ,
				:is_id_tipo ,	
				:idt_dh_envio ,
				:idt_dh_processado)
	Using SqlCA;
	
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao inserir registro na tabela 'requisicao_mrp_sap'. Numero da Requisicao ["+String(al_requisicao)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.SqlNRows <> 1 Then
		as_Log	= "Deveria ter inserido 1 linha na tabela 'requisicao_mrp_sap', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). N$$HEX1$$fa00$$ENDHEX$$mero Requisi$$HEX2$$e700e300$$ENDHEX$$o ["+string( al_requisicao )+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
						
End IF

Return True
end function

on uo_ge473_requisicao_mrp_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_requisicao_mrp_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

