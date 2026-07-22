HA$PBExportHeader$uo_ge473_pedido_liberacao_loja_nova_.sru
forward
global type uo_ge473_pedido_liberacao_loja_nova_ from nonvisualobject
end type
end forward

global type uo_ge473_pedido_liberacao_loja_nova_ from nonvisualobject
end type
global uo_ge473_pedido_liberacao_loja_nova_ uo_ge473_pedido_liberacao_loja_nova_

type variables
uo_ge473_comum io_Comum

String is_cd_parametro[ ] = { "DT_INICIO_GERACAO_PEDIDO_ESTOQUE", "DT_INICIO_GERACAO_PEDIDO_DISTRIBUIDORAS", "BLOQUEIA"}

String is_filial_sap 	     
		   
Long    Il_cd_filial_legado 
 
DateTime	idt_dh_liberacao_estoque_central,  &
                  idt_dh_liberacao_distribuidora

String   is_cd_tipo_bloqueio_controlado 

String  is_tp_alteracao

Boolean ib_tem_bloqueio  // Se tem informa$$HEX2$$e700f500$$ENDHEX$$es de cd_tipo_bloqueio_controlado nos dados lidos em [interface_sap_item]

Boolean ib_Background   //Indica se o ojeto roda via tela ou Background para inibir a barra de progresso em Background

//-- Erro --//
  long    il_nr_controle_erro
  String is_Coluna_erro
  Int      ii_nr_item_erro
              


		
end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_grava_erro_item (long al_controle, string as_coluna, integer ai_nr_item, string as_erro)
public function boolean of_grava_historico_pedidolibera_lojanova (long al_filial, integer ai_nr_parametro, ref string as_log)
protected function boolean of_valida_grava (long al_filial, ref string as_log)
public function boolean of_insere_pedido_liberacao_loja_nova (long al_filial, integer ai_nr_parametro, ref string as_log)
public function boolean of_atualiza_pedido_liberacao_loja_nova (long al_controle, boolean ab_backgraund)
end prototypes

public function boolean of_valida_dados (ref string as_log);Try
		
	
	If IsNull(is_filial_sap) or (Trim(is_filial_sap) = "") Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da filial est$$HEX1$$e100$$ENDHEX$$ nulo."
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
		SetNull( is_filial_sap )	     
					
		SetNull( Il_cd_filial_legado )
		 
		SetNull( idt_dh_liberacao_estoque_central )
		SetNull( idt_dh_liberacao_distribuidora )
		SetNull( is_cd_tipo_bloqueio_controlado ) 
		ib_tem_bloqueio = false 

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: " + lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_grava_erro_item (long al_controle, string as_coluna, integer ai_nr_item, string as_erro);String	ls_Erro

Update interface_sap_item
Set	de_erro		 = :as_erro 
Where nr_controle = :al_controle
and     cd_coluna   = :as_coluna
and    nr_item       = :ai_nr_item
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro	=  SqlCa.SqlerrText
	MessageBox("Erro", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do erro na tabela [interface_sap_item]: " +ls_Erro)
	SqlCa.of_Rollback()
	Return False
End If

If SqlCa.SqlnRows > 1 Then 
	MessageBox("Erro", "Foram encontrados mais de um registro para a atualiza$$HEX2$$e700e300$$ENDHEX$$o de erro no item para o controle '" + String( al_controle ) + "'.")
	SqlCa.of_Rollback()
	Return False
End If

SqlCa.of_Commit()

Return True
end function

public function boolean of_grava_historico_pedidolibera_lojanova (long al_filial, integer ai_nr_parametro, ref string as_log);
String ls_vl_parametro

String ls_cd_tipo_bloqueio_controlado 

If not ib_tem_bloqueio and  (ai_nr_parametro = 3 ) then Return True
	
Try	
	Choose Case  ai_nr_parametro
			 Case 1, 2
				
					Select vl_parametro 
					Into : ls_vl_parametro
					FROM parametro_loja 
					where cd_filial		    = :al_Filial
						And cd_parametro = :is_cd_parametro[ ai_nr_parametro ]
					Using SqlCa;
						
						Choose Case SqlCa.sqlcode
							Case 0
								 is_tp_alteracao= 'A'
							Case 100
								 is_tp_alteracao = 'I'
							Case -1
								as_Log	= "Erro no select da tabela [PARAMETRO_LOJA], metodo 'uo_ge473_pedido_liberacao_loja_nova.of_grava_historico_pedidolibera_lojanova'. Erro: "+SqlCa.sqlErrText
								Return False
						End Choose
						
						If  ( is_tp_alteracao <>  'A' )  And  ( is_tp_alteracao <>  'I' ) Then 
								as_Log	= "Erro no select da tabela [PARAMETRO_LOJA] , metodo 'uo_ge473_pedido_liberacao_loja_nova.of_grava_historico_pedidolibera_lojanova'. Erro: "+SqlCa.sqlErrText
								Return False
						End IF		
						
						 If  is_tp_alteracao =  'A' Then 
									 If ( ls_vl_parametro <> string(idt_dh_liberacao_estoque_central, "dd/mm/yyyy" ) ) or (IsNull( ls_vl_parametro ) and Not IsNull( idt_dh_liberacao_estoque_central )) Then
											 If Not gf_Grava_Historico_Alteracao_Tabela("PARAMETRO_LOJA",  String(al_Filial) + " @#! " + is_cd_parametro[ ai_nr_parametro ]  , "VL_PARAMETRO", ls_vl_parametro, String( idt_dh_liberacao_estoque_central, "dd/mm/yyyy" ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
									  End If
							 End IF
					
						 If  is_tp_alteracao =  'I' Then 
								 If  ai_nr_parametro = 1  Then  ls_vl_parametro = string(idt_dh_liberacao_estoque_central, 'dd/mm/yyyy') 
								 If  ai_nr_parametro = 2  Then  ls_vl_parametro = string(idt_dh_liberacao_distribuidora     , 'dd/mm/yyyy') 
			
								 If Not gf_Grava_Historico_Alteracao_Tabela( "PARAMETRO_LOJA",  String(al_Filial) + " @#! " + is_cd_parametro[ ai_nr_parametro ]  , "CD_FILIAL",            "Null", String( al_Filial         ) ,       'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
								 If Not gf_Grava_Historico_Alteracao_Tabela( "PARAMETRO_LOJA",  String(al_Filial) + " @#! " + is_cd_parametro[ ai_nr_parametro ]  , "CD_PARAMETRO",   "Null", is_cd_parametro[ ai_nr_parametro ]  ,  'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
								 If Not gf_Grava_Historico_Alteracao_Tabela( "PARAMETRO_LOJA",  String(al_Filial) + " @#! " + is_cd_parametro[ ai_nr_parametro ]  , "VL_PARAMETRO",   "Null",  ls_vl_parametro ,               'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
						End IF
				Case 3
					
					Select id_bloqueia_pedido_psico  
					Into :  ls_cd_tipo_bloqueio_controlado 
					FROM filial
					where cd_filial = :al_Filial
					Using SqlCa;
						
						Choose Case SqlCa.sqlcode
							Case 0
								 is_tp_alteracao= 'A'
							Case 100
								 is_tp_alteracao = 'I'
							Case -1
								as_Log	= "Erro no select da tabela [FILIAL], metodo 'uo_ge473_pedido_liberacao_loja_nova.of_grava_historico_pedidolibera_lojanova'. Erro: "+SqlCa.sqlErrText
								Return False
						End Choose
						
						If  ( is_tp_alteracao <>  'A' )   Then 
								as_Log	= "Filial legado n$$HEX1$$e300$$ENDHEX$$o encontrada na tabela [Filial]  "+SqlCa.sqlErrText
								Return False
						End IF		
						
					    If  ( ls_cd_tipo_bloqueio_controlado <> Is_cd_tipo_bloqueio_controlado ) or (IsNull(  ls_cd_tipo_bloqueio_controlado ) and Not IsNull(  Is_cd_tipo_bloqueio_controlado)) Then
							  If Not gf_Grava_Historico_Alteracao_Tabela("FILIAL",  String(al_Filial)  , "CD_TIPO_BLOQUEIO_CONTROLADO",  Ls_cd_tipo_bloqueio_controlado, Is_cd_tipo_bloqueio_controlado, 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
						End If
	
		End Choose				
	
Catch ( runtimeerror  lo_rte )
	  as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge473_pedido_liberacao_loja_nova.of_grava_historico_pedidolibera_lojanova'. Erro: " + lo_rte.GetMessage( )
	  Return False						 
End Try		

Return True
end function

protected function boolean of_valida_grava (long al_filial, ref string as_log);
	 Exception lo_Exp
	 lo_Exp = CREATE Exception
     lo_Exp.setMessage( "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_grava'. Erro: " )
	  
Try
	If IsNull( al_filial )  Then
		    as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da filial legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
			lo_Exp.setMessage( as_Log )
		    THROW (lo_Exp )
	End If

	If isnull( idt_dh_liberacao_estoque_central ) or idt_dh_liberacao_estoque_central < datetime('1901-01-01 00:00:00')  Then
		  is_Coluna_erro = 'dh_liberacao_estoque_central'
		  as_Log	= "A data liberacao_estoque_central est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
		  lo_Exp.setMessage( as_Log )
		  THROW (lo_Exp )
	End If	
	 
	If isnull( idt_dh_liberacao_distribuidora )  or idt_dh_liberacao_distribuidora < datetime('1901-01-01 00:00:00')  Then
		  is_Coluna_erro = 'idt_dh_liberacao_distribuidora'
		  as_Log	= "A data liberacao_distribuidora est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
		  lo_Exp.setMessage( as_Log )
		  THROW (lo_Exp )
	End If	

	If not isnull( is_cd_tipo_bloqueio_controlado)  Then
		If trim( is_cd_tipo_bloqueio_controlado ) <> '1' and trim( is_cd_tipo_bloqueio_controlado ) <> '2' and  trim( is_cd_tipo_bloqueio_controlado ) <> '3' Then
 		        is_Coluna_erro = 'cd_tipo_bloqueio_controlado'
		        as_Log  = "O tipo de bloqueio, se informado, deve ser 1 ou 2 ou 3 - O valor informado est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido"
			    lo_Exp.setMessage( as_Log )
		         THROW (lo_Exp )
		End IF		  
	End If	
	
Catch ( Throwable   lo_rte )   
	as_Log =  lo_Exp.GetMessage( ) + "  " + lo_rte.GetMessage( )
	If Isvalid( lo_Exp ) Then Destroy lo_Exp
	Return False						 
End Try
//
If Isvalid( lo_Exp ) Then Destroy lo_Exp
Return True
end function

public function boolean of_insere_pedido_liberacao_loja_nova (long al_filial, integer ai_nr_parametro, ref string as_log);
String ls_vl_parametro

	Choose Case  ai_nr_parametro
			 Case 1, 2
                     If ai_nr_parametro = 1 Then 
						ls_vl_parametro = String( idt_dh_liberacao_estoque_central , "dd/mm/yyyy" )
					End If
                      If ai_nr_parametro = 2 Then 
						ls_vl_parametro = String( idt_dh_liberacao_distribuidora , "dd/mm/yyyy" )
					 End If
					 //
 					 If is_tp_alteracao = 'A' Then 
						
								Update parametro_loja
									set  vl_parametro = : ls_vl_parametro
								Where   cd_filial		  = :al_Filial
									And  cd_parametro = :is_cd_parametro[ ai_nr_parametro ]
								Using SqlCa;
								
								If SqlCa.SqlCode = -1 Then
									as_Log	= "Erro ao atualizar os dados da tabela [PARAMETRO_SAP]. C$$HEX1$$f300$$ENDHEX$$digo FILIAL " + String( al_Filial )+" . Erro: "+ SqlCa.SqlErrText
									Return False
								End If
								
								If SqlCa.SqlNRows <> 1 Then
									as_Log	= "Deveria ter atualizado 1 linha na tabela [PARAMETRO_SAP], mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s).  fILIAL " +String(al_Filial )+"]."
									Return False
								End If
								
						End If 
						//
						If is_tp_alteracao = 'I' Then
								Insert into parametro_loja
								            ( cd_filial,
									          cd_parametro,
											 vl_parametro)
								    Values
											  ( :al_filial ,
												:is_cd_parametro[ ai_nr_parametro ] ,	
												:ls_vl_parametro)
								      Using SqlCA;
									
									
									If SqlCa.SqlCode = -1 Then
										as_Log	= "Erro ao atualizar os dados da tabela [PARAMETRO_LOJA]. filial "+String( al_filial )+" . Erro: "+ SqlCa.SqlErrText
										Return False
									End If
									
									If SqlCa.SqlNRows <> 1 Then
										    as_Log	= "Deveria ter atualizado 1 linha na tabela [PARAMETRO_LOJA], mas a tentativa de atualizar foi de " + &
										                       String(SqlCa.SqlNRows)+" linha(s). Filial:  " + String( al_filial )+"  " + "Paramentro" + & 
													          is_cd_parametro[ ai_nr_parametro ] + ". Erro: "+ SqlCa.SqlErrText
										      Return False
									End If
						      End IF
					case 3
						If is_tp_alteracao = 'A' Then 
						
								Update filial
									set id_bloqueia_pedido_psico = :is_cd_tipo_bloqueio_controlado
								Where   cd_filial		  = :al_Filial
								Using SqlCa;
								
								If SqlCa.SqlCode = -1 Then
									as_Log	= "Erro ao atualizar os dados da tabela [PARAMETRO_SAP]. C$$HEX1$$f300$$ENDHEX$$digo FILIAL " + String( al_Filial )+" . Erro: "+ SqlCa.SqlErrText
									Return False
								End If
								
								If SqlCa.SqlNRows <> 1 Then
									as_Log	= "Deveria ter atualizado 1 linha na tabela [PARAMETRO_SAP], mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s).  fILIAL " +String(al_Filial )+"]."
									Return False
								End If
								
						End If 
						//
						If is_tp_alteracao = 'I' Then
								Insert into parametro_loja
								            ( cd_filial,
									          cd_parametro,
											 vl_parametro)
								    Values
											  ( :al_filial ,
												:is_cd_parametro[ ai_nr_parametro ] ,	
												:ls_vl_parametro)
								      Using SqlCA;
									
									
									If SqlCa.SqlCode = -1 Then
										as_Log	= "Erro ao atualizar os dados da tabela [Filial]. filial "+String( al_filial )+" . Erro: "+ SqlCa.SqlErrText
										Return False
									End If
									
									If SqlCa.SqlNRows <> 1 Then
										    as_Log	= "Deveria ter atualizado 1 linha na tabela [PARAMETRO_LOJA], mas a tentativa de atualizar foi de " + &
										                       String(SqlCa.SqlNRows)+" linha(s). Filial:  " + String( al_filial )+"  " + "Paramentro" + & 
													          is_cd_parametro[ ai_nr_parametro ] + ". Erro: "+ SqlCa.SqlErrText
										      Return False
									End If
						      End IF						
						
		End Choose


Return True
end function

public function boolean of_atualiza_pedido_liberacao_loja_nova (long al_controle, boolean ab_backgraund);dc_uo_ds_base lds

Long	ll_Filial,&
		ll_Produto,&
		ll_Achou,&
		ll_Linhas,&
		ll_Linha, &
		ll_item_ini, &
		ll_item_fim, &
		ll_loop
		
Int     li_loop_param

String	ls_Log,&
		ls_Coluna, &
		ls_Vl_Item, &
		ls_Obrig, &
		ls_log1, &
		ls_log2
		
Boolean	lb_Sucesso = False		
ib_Background = ab_BackGraund

Select count(*)
Into :ll_Achou
From 	interface_sap
Where nr_controle = :al_controle
    and id_situacao in ('C', 'E')
    and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 177, "Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ registros para processar na tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try
	
	lds	 = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores] - m$$HEX1$$e900$$ENDHEX$$todo 'uo_ge473_pedido_liberacao_loja_nova.of_atualiza_pedido_liberacao_loja_nova'."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve( al_controle )
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores] - M$$HEX1$$e900$$ENDHEX$$todo 'uo_ge473_pedido_liberacao_loja_nova.of_atualiza_pedido_liberacao_loja_nova'."
		Return False
	End If
	//
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve da DW [ds_ge473_lista_valores]. M$$HEX1$$e900$$ENDHEX$$todo 'uo_ge473_pedido_liberacao_loja_nova.of_atualiza_pedido_liberacao_loja_nova'."
		Return False
	End If	
    //	
	ll_item_ini   = lds.object.nr_item[ 1 ]
	ll_item_fim  = lds.object.nr_item[  lds.rowcount() ]
	//
	IF not ib_Background Then
  	       Open(w_aguarde)
	        w_aguarde.Title = "Processando Pedido de Libera$$HEX2$$e700e300$$ENDHEX$$o Loja Nova.."

	         w_aguarde.uo_Progress.Of_SetMax( ll_item_fim )
             Yield()
             w_aguarde.uo_progress.Of_SetProgress( 1 )	 
	End IF
	//
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False

for ll_loop = ll_item_ini to ll_item_fim
	 If not ib_Background Then
	        w_aguarde.uo_progress.Of_SetProgress( ll_loop )	 
	        w_aguarde.Title = "Processando Item : " + String( ll_loop ) +" de " + string( ll_item_fim  )
	 End IF		  
	  //
      lds.setfilter("nr_item = " +  string( ll_loop) )
      lds.filter()	
	  If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	 
	  lb_Sucesso	= True
	  ib_tem_bloqueio = False
      For ll_Linha = 1 To  lds.rowcount()
	
			ls_Coluna 	= lds.Object.cd_coluna		[ll_Linha]
			ls_Vl_Item	= lds.Object.vl_item			[ll_Linha]
			ls_Obrig		= lds.Object.id_obrigatorio	[ll_Linha]
			
			ls_VL_Item = Upper(ls_VL_Item)
			
			If Trim(ls_Vl_Item) = "" Then
				SetNull(ls_Vl_Item)
			End If
			
			If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref ls_Log) Then
				Return False
			End if
			il_nr_controle_erro = al_controle
			is_Coluna_erro = ls_Coluna
			Choose Case  Lower(ls_Coluna)
				 Case 'cd_filial_sap'
							  is_filial_sap =   ls_Vl_Item 
							  If ls_Obrig = 'S' then
								  If isnull( is_filial_sap ) or len(trim(is_filial_sap)) < 4  or not isnumber( is_filial_sap ) then 
									   lb_Sucesso	= False
									   ls_Log = "Codigo da filial SAP n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido"
									   Exit
								  End IF
							  End IF
				Case 'dh_liberacao_estoque_central'
							If Not io_Comum.of_date_time( ls_Vl_Item, 'DH_LIBERACAO_ESTOQUE_CENTRAL', ref idt_dh_liberacao_estoque_central, ref ls_Log) Then
								lb_Sucesso	= False 
								Exit
							 End if
							 If ls_Obrig = 'S' then
							      If isnull( idt_dh_liberacao_estoque_central ) then 
									   lb_Sucesso	= False
									   ls_Log = "Data de Libera$$HEX2$$e700e300$$ENDHEX$$o do Estoque Central est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida."
									   Exit
							       End IF
						      End IF
	
				Case 'dh_liberacao_distribuidora'
							If Not io_Comum.of_date_time( ls_Vl_Item, 'DH_LIBERACAO_DISTRIBUIDORA', ref idt_dh_liberacao_distribuidora, ref ls_Log) Then
								lb_Sucesso	= False 
								Exit
							 End if
							 If ls_Obrig = 'S' then
							      If isnull( idt_dh_liberacao_distribuidora )  then 
									   lb_Sucesso	= False
									   ls_Log = "Data de Libera$$HEX2$$e700e300$$ENDHEX$$o Distribuidora est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida."
									   Exit
							       End IF
						      End IF 
 
				Case 'cd_tipo_bloqueio_controlado'
					          ib_tem_bloqueio = True
					          is_cd_tipo_bloqueio_controlado = trim( ls_Vl_Item )
								 
							 If ls_Obrig = 'S' then
							      If isnull( is_cd_tipo_bloqueio_controlado ) then 
									   lb_Sucesso = False
									   ls_Log = "O c$$HEX1$$f300$$ENDHEX$$digo do Tipo de Bloqueio controlado est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
									   Exit
							       End IF
						      End IF 
		
			End choose
    Next		

    If not lb_Sucesso then Exit

    If not This.of_Valida_Dados(Ref ls_Log) Then 
		lb_Sucesso = false; Exit
	End IF
	//
	If not io_Comum.of_Localiza_Codigo_Filial_Legado(is_filial_sap, Ref  Il_cd_filial_legado, Ref ls_Log) Then
		lb_Sucesso = false 
		Exit
	End IF
	//
     If not This.of_valida_grava(Il_cd_filial_legado, Ref ls_Log) Then
 		 lb_Sucesso = false
 	      Exit
 	End IF
	For li_loop_param = 1 to UpperBound( is_cd_parametro )
				If not This.of_grava_historico_PedidoLibera_lojaNova( Il_cd_filial_legado,  li_loop_param, Ref ls_Log) Then
					lb_Sucesso = false
					Exit
				End IF
 			      //		
			    If not This.of_insere_Pedido_Liberacao_loja_nova( Il_cd_filial_legado,  li_loop_param,  Ref ls_Log) Then
			 		lb_Sucesso = false
					Exit
			 	End IF
	  Next
	
	If not lb_Sucesso then Exit

Next	
//
Finally 
	If IsValid(w_aguarde) Then Close( w_aguarde )		

	If lb_Sucesso Then
		  SqlCa.of_Commit()
	Else
		 ls_log1   = ls_log
		 Ls_Log2 = "Erro no Item "   + trim(string( ll_loop ))  + " Filial SAP: "  + trim(string(  is_filial_sap )) 
				 //
				 SqlCA.of_RollBack()			
				 //
                   of_grava_erro_item( al_controle, is_Coluna_erro, ll_loop ,  ls_log )
				 //		 
				 If not isnull ( ls_Log2 ) Then  ls_Log = ls_Log2 +  ls_Log1
				 io_Comum.of_grava_erro(al_controle, 177, ls_Log)
				 //
				 If not isnull(ls_Log2 ) Then  ls_Log =  ls_Log2 + ls_Log1
				 io_Comum.of_grava_erro( al_controle, 177, ls_Log)
				 //
	End If
		
	Destroy(lds)
End Try

Return lb_Sucesso
end function

on uo_ge473_pedido_liberacao_loja_nova_.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_pedido_liberacao_loja_nova_.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

