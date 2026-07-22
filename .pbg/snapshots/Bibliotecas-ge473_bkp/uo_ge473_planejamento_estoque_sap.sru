HA$PBExportHeader$uo_ge473_planejamento_estoque_sap.sru
$PBExportComments$objeto de interface da classe planejamento_estoque_sap
forward
global type uo_ge473_planejamento_estoque_sap from nonvisualobject
end type
end forward

global type uo_ge473_planejamento_estoque_sap from nonvisualobject
end type
global uo_ge473_planejamento_estoque_sap uo_ge473_planejamento_estoque_sap

type variables
uo_ge473_comum io_Comum

String	is_cd_produto_sap,                  &
		is_filial_sap,                            &
		is_cd_curva_ABC
		

long       il_qt_dias_cobertura,    &
             il_cd_filial_legado,        &
			il_cd_produto_legado	 
              
String  is_tp_alteracao

Decimal	 idc_qt_demanda_diaria 

DateTime	idh_planejamento

//-- Erro --//
  long    il_nr_controle_erro
  String is_Coluna_erro
  Int      ii_nr_item_erro
end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_atualiza_planejamento_estoque_sap (long al_controle)
public function boolean of_grava_historico_planejamento_estoque (long al_filial, long al_produto, ref string as_log)
public function boolean of_insere_planejamento_estoque_sap (long al_filial, long al_produto, ref string as_log)
public function boolean of_grava_erro_item (long al_controle, string as_coluna, integer ai_nr_item, string as_erro)
public function boolean of_valida_grava (long al_filial, long al_produto, ref string as_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);Try
	SetNull( is_Coluna_erro  )	
	If IsNull(is_cd_produto_sap) or Trim(is_cd_produto_sap) = "" Then
		is_Coluna_erro  = 'cd_produto_sap'
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto do SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If
	
	If IsNull(is_filial_sap) or (Trim(is_filial_sap) = "") Then
		is_Coluna_erro  = 'cd_filial_sap'
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
	SetNull( is_Coluna_erro )
	SetNull( is_cd_produto_sap )
	SetNull( is_filial_sap )
	
	SetNull( idc_qt_demanda_diaria )
	SetNull( il_qt_dias_cobertura )
	SetNull( is_cd_curva_ABC )
	SetNull( idh_planejamento )

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_atualiza_planejamento_estoque_sap (long al_controle);dc_uo_ds_base lds

Long	ll_Filial,&
		ll_Produto,&
		ll_Achou,&
		ll_Linhas,&
		ll_Linha, &
		ll_item_ini, &
		ll_item_fim, &
		ll_loop
		
		
String	ls_Log,&
		ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig, &
		ls_log1, &
		ls_log2
		
Boolean	lb_Sucesso = False		

Select count(*)
Into :ll_Achou
From 	interface_sap
Where nr_controle = :al_controle
	 and id_situacao in ('C', 'E')
	and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 177, "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try
		lds		= Create dc_uo_ds_base
		
		If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
			ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_planejamento_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_planejamento_estoque_sap]."
			Return False
		End If
		
		ll_Linhas = lds.Retrieve(al_controle)
		
		If ll_Linhas < 0 Then
			ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_planejamento_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_planejamento_estoque_sap]."
			Return False
		End If
		//
		 If ll_Linhas = 0 Then
			ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_planejamento_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_planejamento_estoque_sap]."
			Return False
		 End If	
		 //	
		 ll_item_ini   = lds.object.nr_item[1]
		 ll_item_fim  = lds.object.nr_item[  lds.rowcount() ]
		  //
		  Open( w_aguarde )
		  w_aguarde.Title = "Processando Planejamento Estoque SAP.."
	
		  w_aguarde.uo_Progress.Of_SetMax( ll_item_fim )
		  Yield()
		  w_aguarde.uo_progress.Of_SetProgress( 1 )	 
	 
	     If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
      	 If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
          lb_Sucesso	= True
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
						
						ls_VL_Item = Upper(ls_VL_Item)
						
						If Trim(ls_Vl_Item) = "" Then
							SetNull(ls_Vl_Item)
						End If
						
						If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref ls_Log) Then
							Return False
						End if
						
						Choose Case  Lower(ls_Coluna)
							 Case 'cd_filial_sap'
										 is_filial_sap =   ls_Vl_Item 
									  If ls_Obrig = 'S' then
										  If isnull( is_filial_sap ) or len(trim(is_filial_sap)) < 2  or not isnumber( is_filial_sap ) then 
												lb_Sucesso	= False
												ls_Log = "Codigo da filial SAP n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido"
												Exit
										  End IF
									  End IF
								
							Case 'cd_produto_sap'
										 is_cd_produto_sap =  ls_Vl_Item 
									  If ls_Obrig = 'S' then
										  If isnull( is_cd_produto_sap ) or len(trim( is_cd_produto_sap )) < 2  or not isnumber( is_cd_produto_sap ) then 
												lb_Sucesso	= False
												ls_Log = "Codigo do Produto SAP n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido"
												Exit
											 End IF
										  End If
							Case 'qt_demanda_diaria'
										If Not io_Comum.of_decimal(ls_Vl_Item, 'QT_DEMANDA_DIARIA', ref idc_qt_demanda_diaria, ref ls_Log) Then 
											lb_Sucesso	= False 
											Exit
										End if
												  //
										If ls_Obrig = 'S' then
											If isnull( idc_qt_demanda_diaria )  then 
												lb_Sucesso	= False
												ls_Log = "A quantidade Demanda Di$$HEX1$$e100$$ENDHEX$$ria est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
												Exit
											 End IF
										 End IF 
					
								Case 'qt_dias_cobertura'
										il_qt_dias_cobertura = long( ls_Vl_Item )
										If ls_Obrig = 'S' then
											If isnull( il_qt_dias_cobertura )  then 
												lb_Sucesso	= False
												ls_Log = "A Quantidade De Dias de Cobertura est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
												Exit
											 End IF
										 End IF 						
										
							 case 'cd_curva_abc'			
										is_cd_curva_abc =   ls_Vl_Item 
										If ls_Obrig = 'S' then
											If isnull( is_cd_curva_abc )  then 
												lb_Sucesso	= False
												ls_Log = "A Curva ABC $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$ria e est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
												Exit
											 End IF
										End IF 						
									
							Case 'dh_planejamento'
									 If Not io_Comum.of_date_time(ls_Vl_Item, 'dh_planejamento', ref idh_planejamento, ref ls_Log) Then  
										   lb_Sucesso = False	
									       Exit
									  End IF				
									  If ls_Obrig = 'S' then
											If isnull(  idh_planejamento)  then 
												lb_Sucesso	= False
												ls_Log = "A Curva ABC $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$ria e est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
												Exit
											 End IF
									   End IF 						
									  
						End choose
				Next		
			 
				If not lb_Sucesso then Exit
						
				If Not This.of_Valida_Dados(Ref ls_Log) Then
					lb_Sucesso = false 
					Exit
				End IF
				  //
				  If Not io_Comum.of_Localiza_Codigo_Filial_Legado(is_filial_sap, Ref ll_Filial, Ref ls_Log) Then
					lb_Sucesso = false 
					Exit
				End IF
				  //
				If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref ll_Produto, Ref ls_Log) Then
					lb_Sucesso = false 
					Exit
				End IF
				  //
				If Not This.of_grava_historico_planejamento_estoque(ll_Filial, ll_Produto, Ref ls_Log) Then
					lb_Sucesso = false 
					Exit
				End IF
				  //
				If Not This.of_valida_grava(ll_Filial, ll_Produto, Ref ls_Log) Then
					lb_Sucesso = false 
					Exit
				End IF
				  //
				If Not This.of_Insere_Planejamento_Estoque_Sap(ll_Filial, ll_Produto, Ref ls_Log) Then
					lb_Sucesso = false 
					Exit
				 End IF
				  //
				 If not lb_Sucesso then Exit
		Next	

Finally
	If IsValid(w_aguarde) Then Close( w_aguarde )		

	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
			 ls_log1   = ls_log
		     Ls_Log2 = "Erro no Item "   + trim(string( ll_loop ))  + " Filial SAP: "  + trim(string(  is_filial_sap ))  + &
					       " Produto SAP: " + trim(string( is_cd_produto_sap ))         + " "
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
	
	End If
		
	Destroy(lds)
End Try

Return lb_Sucesso
end function

public function boolean of_grava_historico_planejamento_estoque (long al_filial, long al_produto, ref string as_log);DateTime	ldh_planejamento

long            ll_qt_dias_cobertura

String         ls_cd_curva_ABC 

Decimal	   ldc_qt_demanda_diaria 
	
Try			
	SetNull ( is_Coluna_erro )
	//
	Select	  qt_demanda_diaria,
	           qt_dias_cobertura,
			  cd_curva_abc,
	           dh_planejamento 
	Into	 :ldc_qt_demanda_diaria ,
	          :ll_qt_dias_cobertura,
			 :ls_cd_curva_ABC,
			 :ldh_planejamento 
	From planejamento_estoque_sap	
	Where	cd_filial		= :al_Filial
		And	cd_produto	= :al_produto
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			 is_tp_alteracao= 'A'
		Case 100
			 is_tp_alteracao = 'I'
		Case -1
			as_Log	= "Erro no select da tabela 'planejamento_estoque_sap', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_planejamento_estoque'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	 If ( is_tp_alteracao <> 'A' ) And ( is_tp_alteracao <> 'I' ) Then 
			as_Log	= "Erro no select da tabela 'planejamento_estoque_sap', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_planejamento_estoque'. Erro: "+SqlCa.sqlErrText
			Return False
      End IF	
		
	If is_tp_alteracao = 'A' Then 
			If ( ldc_qt_demanda_diaria	<> idc_qt_demanda_diaria ) or (IsNull( ldc_qt_demanda_diaria ) and Not IsNull( ldc_qt_demanda_diaria  )) Then
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP",  String(al_Filial) + " @#!" + String(al_produto), "QT_DEMANDA_DIARIA", String( ldc_qt_demanda_diaria ), String( idc_qt_demanda_diaria ), 'SAP001', is_tp_alteracao  , Ref as_log, True) Then Return False
			End If
			
			If ( ll_qt_dias_cobertura	<> il_qt_dias_cobertura  ) or (IsNull(  ll_qt_dias_cobertura ) and Not IsNull( il_qt_dias_cobertura)) Then
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP",  String(al_Filial) + " @#!" + String(al_produto), "QT_DIAS_COBERTURA", String(ll_qt_dias_cobertura), String( il_qt_dias_cobertura ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
			End If
			
			If ( ls_cd_curva_ABC <> is_cd_curva_ABC ) or (IsNull( ls_cd_curva_ABC  ) and Not IsNull(  is_cd_curva_ABC  )) Then
				If Not gf_Grava_Historico_Alteracao_Tabela( "PLANEJAMENTO_ESTOQUE_SAP" ,  String(al_Filial) + " @#!" + String(al_produto), "CD_CURVA_ABC",   ls_cd_curva_ABC  ,   ls_cd_curva_ABC , 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
			End If
			
			If (ldh_planejamento <> idh_planejamento) or (IsNull( ldh_planejamento ) and Not IsNull(idh_planejamento)) Then
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#!"+ String(al_produto), "DH_PLANEJAMENTO", String(ldh_planejamento, "dd/mm/yyyy"), String(idh_planejamento, "dd/mm/yyyy"), 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
			End If
			
   End IF		

	If is_tp_alteracao = 'I' Then 
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto), "CD_FILIAL",                                  "Null" , String( al_Filial ),                                   'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto), "CD_PRODUTO",                            "Null" , String( al_produto ),                               'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto), "QT_DEMANDA_DIARIA",                "Null" , String( idc_qt_demanda_diaria ),             'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto), "QT_DIAS_COBERTURA",                "Null" , String( il_qt_dias_cobertura ),                 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto), "CD_CURVA_ABC",                         "Null" , is_cd_curva_ABC ,                                  'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto), "DH_PLANEJAMENTO",                    "Null" , String(idh_planejamento, "dd/mm/yyyy"), 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto), "ID_ALTERACAO_ESTOQUE_BASE", "Null" , "Null",                                                     'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
				If Not gf_Grava_Historico_Alteracao_Tabela("PLANEJAMENTO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto), "ID_BLOQUEIA_GERACAO_PEDIDO", "Null" , "Null",                                                    'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
    End IF		
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_planejamento_estoque'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True
end function

public function boolean of_insere_planejamento_estoque_sap (long al_filial, long al_produto, ref string as_log);
SetNull( is_Coluna_erro )
If is_tp_alteracao = 'A' Then 

		Update planejamento_estoque_sap
		          set qt_demanda_diaria  = :idc_qt_demanda_diaria ,
		               qt_dias_cobertura    = :il_qt_dias_cobertura,
		               cd_curva_abc          = :is_cd_curva_ABC,
		               dh_planejamento     = :idh_planejamento 
		Where	cd_filial		= :al_Filial
			And	cd_produto	= :al_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar os dados da tabela 'PLANEJAMENTO_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
		
		If SqlCa.SqlNRows <> 1 Then
			as_Log	= "Deveria ter atualizado 1 linha na tabela 'PLANEJAMENTO_ESTOQUE_SAP', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]."
			Return False
		End If
		
End If 
//
If is_tp_alteracao = 'I' then
		Insert into planejamento_estoque_sap ( cd_filial,
												             cd_produto,
															qt_demanda_diaria,
															qt_dias_cobertura,
															cd_curva_abc,
															dh_planejamento,
															id_alteracao_estoque_base,
															id_bloqueia_geracao_pedido)
															values
															(:al_filial ,
															 :al_produto ,	
															 :idc_qt_demanda_diaria ,
															 :il_qt_dias_cobertura,
															 :is_cd_curva_ABC,
															 :idh_planejamento,
															 Null,
															 Null)
															 Using SqlCA;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao atualizar os dados da tabela 'SALDO_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
			If SqlCa.SqlNRows <> 1 Then
				as_Log	= "Deveria ter atualizado 1 linha na tabela 'SALDO_ESTOQUE_SAP', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
End IF

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

public function boolean of_valida_grava (long al_filial, long al_produto, ref string as_log);Try
	SetNull( is_Coluna_erro )
	//
	If IsNull(al_filial)  Then
		is_Coluna_erro  = 'cd_filial_sap'
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o encontrado a Filial no legado correspondente a filial SAP. "
		Return False  
	End If

	If IsNull(al_produto)  Then
		is_Coluna_erro  =  'cd_produto_sap'
		as_Log	= " N$$HEX1$$e300$$ENDHEX$$o encontrado o C$$HEX1$$f300$$ENDHEX$$digo do Produto Legado para o C$$HEX1$$f300$$ENDHEX$$digo do Produto SAP."
		Return False  
	End If

	If IsNull(idc_qt_demanda_diaria )   Then
		is_Coluna_erro  =  'qt_demanda_diaria'
		as_Log	= "A Quantidade de Demanda Di$$HEX1$$e100$$ENDHEX$$ria n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If

	If IsNull( il_qt_dias_cobertura )   Then
		is_Coluna_erro  =  'qt_dias_cobertura'
		as_Log	= "A Quantidade Dias de Cobertura n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	
	 
	If IsNull( is_cd_curva_ABC )    Then
		is_Coluna_erro  =  'cd_curva_abc'	
		as_Log	= "A Curva ABC do produto n$$HEX1$$e300$$ENDHEX$$o foi nformada ou est$$HEX1$$e100$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lida!"
		Return False
	End If		
	
	If IsNull( idh_planejamento ) or idh_planejamento < datetime('1901-01-01 00:00:00')  Then
		is_Coluna_erro  =  'dh_planejamento'
		as_Log	= "A data do planejamento estoque tem que ser uma data v$$HEX1$$e100$$ENDHEX$$lida v$$HEX1$$e100$$ENDHEX$$lida!"
		Return False
	End If		
	
Catch ( runtimeerror   lo_rte )   
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_grava'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

on uo_ge473_planejamento_estoque_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_planejamento_estoque_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

