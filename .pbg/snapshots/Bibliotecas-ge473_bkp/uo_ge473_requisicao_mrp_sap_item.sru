HA$PBExportHeader$uo_ge473_requisicao_mrp_sap_item.sru
forward
global type uo_ge473_requisicao_mrp_sap_item from nonvisualobject
end type
end forward

global type uo_ge473_requisicao_mrp_sap_item from nonvisualobject
end type
global uo_ge473_requisicao_mrp_sap_item uo_ge473_requisicao_mrp_sap_item

type variables
uo_ge473_comum io_Comum

String  is_tp_alteracao

long il_nr_controle_header

Long    il_cd_filial_legado, &			  
		  il_cd_produto_legado

String is_cd_produto_sap,    &
		 is_filial_sap 

String   is_cd_unidade_medida

Int     ii_nr_item 

dec        idc_qt_requisicao 
		 
Long  il_nr_requisicao, &
		il_qt_faturada 
 
datetime	idt_dh_remessa

//-- Erro --//
  long    il_nr_controle_erro
  String is_Coluna_erro
  Int      ii_nr_item_erro

			  
 
		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_dados (string as_log)
public function boolean of_atualiza_requisicao_mrp_sap_item (long al_controle)
public function boolean of_insere_requisicao_mrp_sap_item (long al_requisicao, ref string as_log)
protected function boolean of_grava_historico_requisicao_mrp_sap_it (long al_requisicao, ref string as_log)
public function boolean of_grava_erro_item (long al_controle, string as_coluna, integer ai_nr_item, ref string as_erro)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setnull(  is_tp_alteracao )
	setnull(  is_cd_produto_sap )
	Setnull(  is_cd_unidade_medida)
	Setnull(  idc_qt_requisicao )
	setnull(  is_filial_sap )
	setnull(  ii_nr_item )
	setnull(  il_nr_requisicao )
	setnull(  idt_dh_remessa )
	setnull(  il_qt_faturada )
			 
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_valida_dados (string as_log);Try
	SetNull( is_Coluna_erro )
	If IsNull(il_cd_filial_legado)  Then
		is_Coluna_erro = 'cd_filial_sap'
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da filial legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If

	If IsNull( il_cd_produto_legado)  Then
		is_Coluna_erro = 'cd_produto_sap'
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If

     If IsNull(  il_nr_requisicao  ) or ( Isnumber (String( il_nr_requisicao) ) = False) Then
		is_Coluna_erro = 'nr_requisicao'
		as_Log	= "O N$$HEX1$$fa00$$ENDHEX$$mero da Requisi$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False  
	End If
		
     if Isnull ( ii_nr_item  ) or (isnumber( trim(string( ii_nr_item  ))) = False) Then   
		is_Coluna_erro = 'nr_item'
		as_Log	= "O N$$HEX1$$fa00$$ENDHEX$$mero do Item est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido!"
		Return False
	End If	
	
	If Isnull(  idc_qt_requisicao ) then 
		is_Coluna_erro = 'qt_requisiao'
		as_Log	= "A Quantidade da requisi$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
		Return False
	End If	
		
	If Isnull( is_cd_unidade_medida ) or len(trim( is_cd_unidade_medida ) ) = 0 then
		is_Coluna_erro = 'cd_unidade_medida'
		as_Log	= "A Unidade de Medida est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
		Return False
	End If	
  
     If   idt_dh_remessa   < datetime('2000-01-01 00:00:00')   then
		 is_Coluna_erro = 'dh_remessa'
		 as_Log	= "A Data de Remessa da Requisi$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
		 Return False
	End If	  
 	
Catch ( runtimeerror   lo_rte )   
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_grava'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_atualiza_requisicao_mrp_sap_item (long al_controle);dc_uo_ds_base lds

Long	ll_Filial,&
		ll_Produto,&
		ll_nr_requisicao, &
		ll_Achou,&
		ll_Linhas,&
		ll_Linha, &
		ll_item_ini, &
		ll_item_fim, &
		ll_loop, &
		ll_controle
		
String	ls_Log,&
		ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig, &
		ls_log1, &
		ls_log2
		
Boolean	lb_Sucesso = False

Boolean  lb_achou
//
    il_nr_controle_header = al_controle 	
	al_controle++
//
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
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_requisicao_mrp_sap_item], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_requisicao_mrp_sap_item]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve( al_controle )
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_requisicao_mrp_sap_item], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_requisicao_mrp_sap_item]."
		Return False
	End If
	//
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_requisicao_mrp_sap_item], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_requisicao_mrp_sap_item]."
		Return False
	End If	
	//	
	ll_item_ini   = lds.object.nr_item[1]
	ll_item_fim  = lds.object.nr_item[  lds.rowcount() ]
	//

	Open( w_aguarde )
	w_aguarde.Title = "Processando Requisi$$HEX2$$e700e300$$ENDHEX$$o MRP SAP Item.."
	
	w_aguarde.uo_Progress.Of_SetMax( ll_item_fim )
	Yield()
	w_aguarde.uo_progress.Of_SetProgress( 1 )	 
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	 lb_Sucesso	= True
	for ll_loop = ll_item_ini to ll_item_fim
		//
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
              //
			ls_VL_Item = Upper(trim(ls_VL_Item))
			
			If Trim(ls_Vl_Item) = "" Then
				SetNull(ls_Vl_Item)
			End If
			
			If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref ls_Log) Then
				Return False
			End if
			//
			il_nr_controle_erro = al_controle
			is_Coluna_erro = ls_Coluna
              //
			Choose Case  Lower(trim( ls_Coluna ))
				Case 'nr_requisicao'
					    il_nr_requisicao = long( ls_Vl_Item )
					    If ls_Obrig = 'S' then
								If isnull( il_nr_requisicao ) then 
										lb_Sucesso	= False
										ls_Log = "O N$$HEX1$$fa00$$ENDHEX$$mero da requisi$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ Inv$$HEX1$$e100$$ENDHEX$$lido"
										Exit
								  End IF
						 End IF

				Case 'nr_item'
					    ii_nr_item = integer( ls_Vl_Item )
					    If ls_Obrig = 'S' then
								If isnull( ii_nr_item ) then 
										lb_Sucesso	= False
										ls_Log = "O N$$HEX1$$fa00$$ENDHEX$$mero do Item est$$HEX1$$e100$$ENDHEX$$ Inv$$HEX1$$e100$$ENDHEX$$lido"
										Exit
								  End IF
						 End IF
				
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
				
				Case  'qt_requisicao'
					     If Not io_Comum.of_decimal(ls_Vl_Item, 'QT_REQUISICAO', ref idc_qt_requisicao, ref ls_Log) Then 
						       lb_Sucesso = False
						       Exit
					     End IF
						 If ls_Obrig = 'S' then
							  If isnull(  idc_qt_requisicao ) then 
									lb_Sucesso	= False
									ls_Log = "A Quantidade da Requisi$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$ria e est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida!"
									Exit
								 End IF
						  End If
						  
				Case 'cd_unidade_medida'
					     is_cd_unidade_medida = ls_Vl_Item
						 If ls_Obrig = 'S' then
							  If isnull(  is_cd_unidade_medida  ) then 
									lb_Sucesso	= False
									ls_Log = "A Unidade de Medida est$$HEX1$$e100$$ENDHEX$$ nula ou inv$$HEX1$$e100$$ENDHEX$$lida!"
									Exit
							   End IF
						   End If
				
				Case 'dh_remessa'
					   If Not io_Comum.of_date_time(ls_Vl_Item, 'DH_REMESSA', ref idt_dh_remessa, ref ls_Log) Then 
							lb_Sucesso	= False
				              Exit
						End If
						If ls_Obrig = 'S' then
							  If isnull( idt_dh_remessa  ) then 
									lb_Sucesso	= False
									ls_Log = "A Data da Remessa $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$ria e est$$HEX1$$e100$$ENDHEX$$ nulo ou inv$$HEX1$$e100$$ENDHEX$$lida!"
									Exit
							   End IF
						 End If
						
				Case 'qt_faturada'
					     il_qt_faturada = long( ls_Vl_Item )
						If ls_Obrig = 'S' then
							  If isnull(  il_qt_faturada   ) then 
									lb_Sucesso	= False
									ls_Log = "A Quantidade Faturada $$HEX1$$e900$$ENDHEX$$ Obrigat$$HEX1$$f300$$ENDHEX$$ria e est$$HEX1$$e100$$ENDHEX$$ nulo ou inv$$HEX1$$e100$$ENDHEX$$lida!"
									Exit
							   End IF
						 End If
			
			End choose
		Next	
		//
		If not lb_Sucesso then Exit
		//
		If isnull( il_nr_requisicao ) then 
			ls_Log = 'N$$HEX1$$fa00$$ENDHEX$$mero da Requuisi$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido!'
			lb_Sucesso	= False
			Exit
		End IF 
		//
		If Not io_Comum.of_Localiza_Codigo_Filial_Legado( is_filial_sap , Ref il_cd_Filial_legado, Ref ls_Log) Then  
			  lb_Sucesso = false 
			  Exit
		End IF
		 //
		If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref il_cd_Produto_legado, Ref ls_Log) Then 
			  lb_Sucesso = false 
			  Exit
		End IF
		 //
		If Not This.of_valida_dados( Ref ls_Log) Then
			  lb_Sucesso = false 
			  Exit
		End IF
		//	
		If Not This.of_grava_historico_requisicao_mrp_sap_it( il_nr_requisicao, Ref ls_Log ) Then
			  lb_Sucesso = false 
			  Exit
		End IF
		//	
		If Not This.of_Insere_requisicao_mrp_sap_item( il_nr_requisicao, Ref ls_Log ) Then
			  lb_Sucesso = false 
			  Exit
		End IF
		//	
		If not lb_Sucesso then Exit
	
	Next	
Finally 
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		ls_log1   = ls_log
		Ls_Log2 = "Erro no $$HEX1$$ed00$$ENDHEX$$tem "   + trim(string( ll_loop ))   + " Filial SAP: "          + trim(string(  is_filial_sap )) + &
		" Produto SAP: " + trim(string( is_cd_produto_sap )) + " Controle Header: " + trim(string(il_nr_controle_header))    + &
		" Requisi$$HEX2$$e700e300$$ENDHEX$$o: "    + trim( string( il_nr_requisicao ) )   + " "
		//
		SqlCA.of_RollBack()			
		//
		of_grava_erro_item( al_controle, is_Coluna_erro, ll_loop ,  ls_log )
		//		 
		If not isnull ( ls_Log2 ) Then  ls_Log = ls_Log2 +  ls_Log1
		io_Comum.of_grava_erro(al_controle, 177, ls_Log)
		//
		If not isnull(ls_Log2 ) Then  ls_Log =  ls_Log2 + ls_Log1
		io_Comum.of_grava_erro( il_nr_controle_header, 177, ls_Log)
		//
	End If
	
	Destroy(lds)
	
	If IsValid(w_aguarde) Then Close( w_aguarde )		
End Try

Return lb_Sucesso
end function

public function boolean of_insere_requisicao_mrp_sap_item (long al_requisicao, ref string as_log);
Long ll_qt_requisicao

 ll_qt_requisicao =  int( idc_qt_requisicao )

If is_tp_alteracao = 'A' Then  

	Update requisicao_mrp_sap_item 
		set  cd_filial  	             = :il_cd_filial_legado,
			  cd_produto             = :il_cd_produto_legado,
			  qt_requisicao          = :ll_qt_requisicao,
			  cd_unidade_medida = :is_cd_unidade_medida ,
			  dh_remessa            = :idt_dh_remessa
	Where nr_requisicao 	= :al_requisicao
		and   nr_item        =  :ii_nr_item
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao atualizar os dados da tabela 'requisicao_mrp_sap_item'. N$$HEX1$$fa00$$ENDHEX$$mero da Requisi$$HEX2$$e700e300$$ENDHEX$$o  ["+string(al_requisicao)+"],  Erro: "+ SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.SqlNRows <> 1 Then
		as_Log	= "Deveria ter atualizado 1 linha na tabela 'requisicao_mrp_sap_item', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). N$$HEX1$$fa00$$ENDHEX$$mero da Requisi$$HEX2$$e700e300$$ENDHEX$$o ["+string( al_requisicao) +"]. "
		Return False
	End If
					
End If 
//
If is_tp_alteracao  = 'I' then
 
	Insert into requisicao_mrp_sap_item(	nr_requisicao,
													nr_item,
													cd_filial,
													cd_produto,
													qt_requisicao,
													cd_unidade_medida,
													dh_remessa,
													qt_faturada)
		values(	:il_nr_requisicao,   
					:ii_nr_item,
					:il_cd_filial_legado,
					:il_cd_produto_legado,
					:ll_qt_requisicao,
					:is_cd_unidade_medida ,
					:idt_dh_remessa,
					Null   )
	Using SqlCA;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao inserir registro na tabela 'requisicao_mrp_sap_item'. N$$HEX1$$fa00$$ENDHEX$$mero da Requisi$$HEX2$$e700e300$$ENDHEX$$o ["+String(al_requisicao)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.SqlNRows <> 1 Then
		as_Log	= "Deveria ter inserido 1 linha na tabela 'requisicao_mrp_sap_item', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). N$$HEX1$$fa00$$ENDHEX$$mero Requisi$$HEX2$$e700e300$$ENDHEX$$o ["+string( al_requisicao )+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
						
End IF

Return True
end function

protected function boolean of_grava_historico_requisicao_mrp_sap_it (long al_requisicao, ref string as_log);
String  ls_id_tipo, &
          ls_cd_unidade_medida

String ls_cd_produto_sap,    &
		 ls_filial_sap 
 
DateTime ldt_dh_envio , &
               ldt_dh_processado , &
		      ldt_dh_remessa

Long ll_item, &
        ll_cd_filial_legado, &			  
	    ll_cd_produto_legado, &
	    ll_qt_faturada, &
         ll_qt_requisicao 

Int li_nr_item

//------- Trata os Itens -------//
Try			
	setnull( is_tp_alteracao )
	//
	Select cd_filial,
			cd_produto,
			qt_requisicao,
			cd_unidade_medida,
			dh_remessa,
			qt_faturada 
	Into :ll_cd_filial_legado,
       	  :ll_cd_produto_legado,
	       :ll_qt_requisicao,
	       :ls_cd_unidade_medida,
	       :ldt_dh_remessa,
	       :ll_qt_faturada 
	From requisicao_mrp_sap_item	
	Where nr_requisicao = :al_requisicao
	and     nr_item         =  :ii_nr_item
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			is_tp_alteracao = 'A'
		Case 100
			is_tp_alteracao = 'I'
		Case -1
			as_Log  =  "Erro no select da tabela 'requisicao_mrp_sap_item', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_requisicao_mrp_sap_it'. Erro: "+SqlCa.sqlErrText
		Return False
	End Choose
	
	If ( is_tp_alteracao   <>  'A'  ) and  ( is_tp_alteracao   <>  'I'  ) Then 
		as_Log  =  "Erro no select da tabela 'requisicao_mrp_sap_item', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_requisicao_mrp_sap_it'."
		If not isnull( SqlCa.sqlErrText ) Then as_Log  =  as_Log  + " Erro: " + SqlCa.sqlErrText 
		Return False
	End IF				
	//
	IF  is_tp_alteracao = 'A' Then 
	
		If ( ll_cd_filial_legado <> Il_cd_filial_legado  ) or (IsNull( ll_cd_filial_legado ) and Not IsNull( il_cd_filial_legado )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "CD_FILIAL" , String( ll_cd_filial_legado ), String( il_cd_filial_legado ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
		
		If ( ll_cd_produto_legado <> il_cd_produto_legado  ) or (IsNull( ll_cd_produto_legado ) and Not IsNull( il_cd_produto_legado )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "CD_PRODUTO" , String( ll_cd_produto_legado ), String( il_cd_produto_legado ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
		
		If ( ll_qt_requisicao <> int( idc_qt_requisicao ) ) or ( IsNull( ll_qt_requisicao  ) and Not IsNull( int( idc_qt_requisicao) )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "QT_REQUISICAO" , String( ll_qt_requisicao ), String(int(idc_qt_requisicao) ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
		
		If ( ls_cd_unidade_medida <> is_cd_unidade_medida ) or ( IsNull( ls_cd_unidade_medida  ) and Not IsNull( is_cd_unidade_medida )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "CD_UNIDADE_MEDIDA" , ls_cd_unidade_medida,   is_cd_unidade_medida, 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
		
		If ( ldt_dh_remessa  <> idt_dh_remessa ) or ( IsNull( ldt_dh_remessa  ) and Not IsNull( idt_dh_remessa )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela( "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "DH_REMESSA" , string( ldt_dh_remessa, 'dd/mm/yyyy'), string( idt_dh_remessa, 'dd/mm/yyyy') , 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
	
	End IF
	
	IF  is_tp_alteracao = 'I' Then 
	
		If Not gf_Grava_Historico_Alteracao_Tabela(  "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "NR_REQUISICAO" ,         "Null"  ,  String( il_nr_requisicao ) ,                     'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela(  "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "NR_ITEM" ,                   "Null"  ,  String( ii_nr_item ),                               'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela(  "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "CD_FILIAL" ,                  "Null"  ,  String( il_cd_filial_legado ),                   'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela(  "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "CD_PRODUTO" ,            "Null"  ,  String( il_cd_produto_legado ),               'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela(  "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "QT_REQUISICAO" ,        "Null"  ,  String(int( idc_qt_requisicao) ),               'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela(  "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "CD_UNIDADE_MEDIDA" , "Null"  ,  is_cd_unidade_medida,                         'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela(  "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "DH_REMESSA" ,             "Null"  ,  string( idt_dh_remessa, 'dd/mm/yyyy' ) , 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela(  "REQUISICAO_MRP_SAP_ITEM",  String( al_requisicao )  , "QT_FATURADA" ,           "Null"  ,  "Null" ,                                                 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
	
	End IF		

Catch ( runtimeerror  lo_rte_item )
	as_Log = "Ocorreu erro ao gravar do item fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_requisicao_mrp_sap'. Erro: "+lo_rte_item.GetMessage( )
	Return False						 
End Try		

If isvalid( lo_rte_item ) then destroy lo_rte_item

Return True
end function

public function boolean of_grava_erro_item (long al_controle, string as_coluna, integer ai_nr_item, ref string as_erro);String	ls_Erro

Update interface_sap_item
    Set	    de_erro		 = :as_erro 
Where nr_controle = :al_controle
    and     cd_coluna   = :as_coluna
    and    nr_item       = :ai_nr_item
   Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro	=  SqlCa.SqlerrText
	as_erro =   "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do erro na tabela [interface_sap_item]: " + ls_Erro 
    SqlCa.of_Rollback()
	Return False
End If

If SqlCa.SqlnRows > 1 Then 
	as_erro =   "Foram encontrados mais de um registro para a atualiza$$HEX2$$e700e300$$ENDHEX$$o de erro no item para o controle '" + String( al_controle )  
	SqlCa.of_Rollback()
	Return False
End If

SqlCa.of_Commit()

Return True
end function

on uo_ge473_requisicao_mrp_sap_item.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_requisicao_mrp_sap_item.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

