HA$PBExportHeader$uo_ge473_saldo_estoque_sap.sru
$PBExportComments$objeto de interface da classe planejamento_estoque_sap
forward
global type uo_ge473_saldo_estoque_sap from nonvisualobject
end type
end forward

global type uo_ge473_saldo_estoque_sap from nonvisualobject
end type
global uo_ge473_saldo_estoque_sap uo_ge473_saldo_estoque_sap

type variables
uo_ge473_comum io_Comum

String 	is_cd_produto_sap,     &
		    is_filial_sap 

Long     Il_cd_filial_legado,        &
            Il_cod_produto_legado
			 
      
String  is_tp_alteracao

DateTime	idt_dh_saldo, &
                  idt_dh_atualizacao 

long            il_qt_saldo

Decimal	  idc_vl_custo

//-- Erro --//
  long    il_nr_controle_erro
  String is_Coluna_erro
  Int      ii_nr_item_erro
              


		
end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_atualiza_saldo_estoque_sap (long al_controle)
public function boolean of_insere_saldo_estoque_sap (long al_filial, long al_produto, ref string as_log)
public function boolean of_grava_historico_saldo_estoque_sap (long al_filial, long al_produto, datetime adt_dh_saldo, ref string as_log)
public function boolean of_grava_erro_item (long al_controle, string as_coluna, integer ai_nr_item, string as_erro)
public function boolean of_valida_grava (long al_filial, long al_produto, ref string as_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);Try
		
	If IsNull(is_cd_produto_sap) or Trim(is_cd_produto_sap) = "" Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto do SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If
	
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
	
     SetNull( is_cd_produto_sap )
     SetNull( is_filial_sap )
     SetNull( is_tp_alteracao )
     SetNull( idt_dh_saldo )
     SetNull( idt_dh_atualizacao 	)
     SetNull( il_qt_saldo )
     SetNull( idc_vl_custo	)
     SetNull( Il_cd_filial_legado)
     SetNull( Il_cod_produto_legado ) 	  

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_atualiza_saldo_estoque_sap (long al_controle);dc_uo_ds_base lds

Long	ll_Filial,&
		ll_Produto,&
		ll_Achou,&
		ll_Linhas,&
		ll_Linha, &
		ll_item_ini, &
		ll_item_fim, &
		ll_loop
		
String	ls_Log,&
		ls_Coluna, &
		ls_Vl_Item, &
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
	
	lds	 = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_saldo_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_saldo_estoque_sap]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve( al_controle )
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_saldo_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_saldo_estoque_sap]."
		Return False
	End If
	//
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_saldo_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_saldo_estoque_sap]."
		Return False
	End If	
    //	
	ll_item_ini   = lds.object.nr_item[ 1 ]
	ll_item_fim  = lds.object.nr_item[  lds.rowcount() ]
	//
	 Open(w_aguarde)
	 w_aguarde.Title = "Processando Saldo Estoque SAP.."

	 w_aguarde.uo_Progress.Of_SetMax( ll_item_fim )
      Yield()
     w_aguarde.uo_progress.Of_SetProgress( 1 )	 
	 
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False

for ll_loop = ll_item_ini to ll_item_fim
	 w_aguarde.uo_progress.Of_SetProgress( ll_loop )	 
	 w_aguarde.Title = "Processando Item : " + String( ll_loop ) +" de " + string( ll_item_fim  )
	  //
      lds.setfilter("nr_item = " +  string( ll_loop) )
      lds.filter()	
	 If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	 
	 lb_Sucesso	= True
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
						      End IF
	
				Case 'qt_saldo'
							 il_qt_saldo = long( ls_Vl_Item )
							 If ls_Obrig = 'S' then
							      If isnull( il_qt_saldo )  then 
									   lb_Sucesso	= False
									   ls_Log = "A quantidade de Saldo $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida"
									   Exit
							       End IF
						      End IF 
 
				Case 'dh_atualizacao'
							 If Not io_Comum.of_date_time(ls_Vl_Item, 'DH_ATUALIZACAO', ref idt_dh_atualizacao, ref ls_Log) Then
								lb_Sucesso	= False 
								Exit
							 End if
							 If ls_Obrig = 'S' then
							      If isnull(  idt_dh_atualizacao )  then 
									   lb_Sucesso = False
									   ls_Log = "A data de atualiza$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida"
									   Exit
							       End IF
						      End IF 
						 
				Case 'dh_saldo'
							If Not io_Comum.of_date_time(ls_Vl_Item, 'DH_SALDO', ref  idt_dh_saldo, ref ls_Log) Then
								lb_Sucesso	= False 
								Exit 
							End IF
							If ls_Obrig = 'S' then
							      If isnull( idt_dh_saldo )  then 
									   lb_Sucesso = False
									   ls_Log = "A data do saldo est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida"
									   Exit
							       End IF
						      End IF 							 
							 
					  Case 'vl_custo'
							If Not io_Comum.of_decimal(ls_Vl_Item, 'VL_CUSTO', ref idc_vl_custo, ref ls_Log) Then  
								lb_Sucesso	= False 
								Exit 
							End IF	
							If ls_Obrig = 'S' then
							      If isnull( idc_vl_custo)  then 
									   lb_Sucesso = False
									   ls_Log = "O Valor do Custo est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido"
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
	If not io_Comum.of_Localiza_Codigo_Produto_Legado( is_cd_produto_sap, Ref Il_cod_produto_legado, Ref ls_Log) Then
	   	    lb_Sucesso = false
		    Exit
	End IF
	//		
	If not This.of_grava_historico_saldo_estoque_sap( Il_cd_filial_legado, Il_cod_produto_legado, idt_dh_saldo, Ref ls_Log) Then
		lb_Sucesso = false
		Exit
	End IF
	//		
   If not This.of_valida_grava(Il_cd_filial_legado, Il_cod_produto_legado, Ref ls_Log) Then
		lb_Sucesso = false
		Exit
	End IF
	//		
   If not This.of_Insere_saldo_Estoque_Sap(Il_cd_filial_legado, Il_cod_produto_legado, Ref ls_Log) Then
		lb_Sucesso = false; Exit
	End IF
	//	 
	If not lb_Sucesso then Exit

Next	
//
Finally 
	If IsValid(w_aguarde) Then Close( w_aguarde )		

	If lb_Sucesso Then
		  SqlCa.of_Commit()
	Else
		 ls_log1   = ls_log
		 Ls_Log2 = "Erro no Item "   + trim(string( ll_loop ))  + " Filial SAP: "       + trim(string(  is_filial_sap ))  + &
					   " Produto SAP: " + trim(string( is_cd_produto_sap ))     + " "
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

public function boolean of_insere_saldo_estoque_sap (long al_filial, long al_produto, ref string as_log);
If is_tp_alteracao = 'A' Then 

		Update saldo_estoque_sap 
		   set  qt_saldo             = :il_qt_saldo ,
		         dh_atualizacao	   = :idt_dh_atualizacao,
		         vl_custo              = :idc_vl_custo 
		Where   cd_filial		= :al_Filial
			And  cd_produto	= :al_Produto
			and   dh_saldo      = :idt_dh_saldo
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar os dados da tabela 'SALDO_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
		
		If SqlCa.SqlNRows <> 1 Then
			as_Log	= "Deveria ter atualizado 1 linha na tabela 'SALDO_ESTOQUE_SAP', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]."
			Return False
		End If
		
End If 
//
If is_tp_alteracao = 'I' then
		Insert into saldo_estoque_sap ( cd_filial,
											      cd_produto,
												  qt_saldo,
												  dh_atualizacao,
												  dh_saldo,
												   vl_custo )
												values
												     ( :al_filial ,
												       :al_produto ,	
												       :il_qt_saldo ,
												       :idt_dh_atualizacao ,
												       :idt_dh_saldo ,
												       :idc_vl_custo )
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

public function boolean of_grava_historico_saldo_estoque_sap (long al_filial, long al_produto, datetime adt_dh_saldo, ref string as_log);DateTime	ldt_dh_saldo, &
                  ldt_dh_atualizacao 

long            ll_qt_saldo

Decimal	  ldc_vl_custo
	
Try			
	Select	  qt_saldo,
	           dh_atualizacao,
			  vl_custo
	Into	 :ll_qt_saldo,
	          :ldt_dh_atualizacao,
			 :ldc_vl_custo 
	From saldo_estoque_sap	
	Where	cd_filial		= :al_Filial
		And	cd_produto	= :al_produto
		And   dh_saldo      = :adt_dh_saldo
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			 is_tp_alteracao= 'A'
		Case 100
			 is_tp_alteracao = 'I'
		Case -1
			as_Log	= "Erro no select da tabela 'SALDO_ESTOQUE_SAP', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_saldo_estoque_sap'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	If  ( is_tp_alteracao <>  'A' )  And  ( is_tp_alteracao <>  'I' ) Then 
			as_Log	= "Erro no select da tabela 'SALDO_ESTOQUE_SAP', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_saldo_estoque_sap'. Erro: "+SqlCa.sqlErrText
			Return False
	End IF		
	
    If  is_tp_alteracao =  'A' Then 
		If ( ll_qt_saldo	<> il_qt_saldo  ) or (IsNull( ll_qt_saldo ) and Not IsNull( il_qt_saldo)) Then
			If Not gf_Grava_Historico_Alteracao_Tabela("SALDO_ESTOQUE_SAP",  String(al_Filial) + " @#! " + String(al_produto) + " @#! " + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "QT_SALDO", String(ll_qt_saldo), String( il_qt_saldo ), 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
		End If
		
		If ( ldt_dh_atualizacao <> idt_dh_atualizacao ) or (IsNull( ldt_dh_atualizacao  ) and Not IsNull( idt_dh_atualizacao  )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela( "SALDO_ESTOQUE_SAP" ,  String(al_Filial) + " @#! " + String(al_produto) + " @#! " + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "DH_ATUALIZACAO",  string( ldt_dh_atualizacao, "dd/mm/yyyy")  , string( idt_dh_atualizacao, 'dd/mm/yyyy') , 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
		End If
		
		If ( ldc_vl_custo <> idc_vl_custo) or (IsNull( ldc_vl_custo ) and Not IsNull(idc_vl_custo )) Then
			If Not gf_Grava_Historico_Alteracao_Tabela("SALDO_ESTOQUE_SAP", String(al_Filial) + " @#! "+ String(al_produto) + " @#! "  + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "VL_CUSTO", STRING( ldc_vl_custo) , STRING( Idc_vl_custo), 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
		End If
	End IF

    If  is_tp_alteracao =  'I' Then 
			If Not gf_Grava_Historico_Alteracao_Tabela( "SALDO_ESTOQUE_SAP",  String(al_Filial) + " @#! " + String(al_produto) + " @#! " + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "CD_FILIAL",            "Null", String( al_Filial         ) ,                             'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
			If Not gf_Grava_Historico_Alteracao_Tabela( "SALDO_ESTOQUE_SAP",  String(al_Filial) + " @#! " + String(al_produto) + " @#! " + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "CD_PRODUTO",       "Null", String( al_produto     ) ,                            'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
			If Not gf_Grava_Historico_Alteracao_Tabela( "SALDO_ESTOQUE_SAP",  String(al_Filial) + " @#! " + String(al_produto) + " @#! " + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "DH_SALDO",           "Null", String( adt_dh_saldo ) ,                             'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
			If Not gf_Grava_Historico_Alteracao_Tabela( "SALDO_ESTOQUE_SAP",  String(al_Filial) + " @#! " + String(al_produto) + " @#! " + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "QT_SALDO",           "Null", String( il_qt_saldo ),                                  'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
			If Not gf_Grava_Historico_Alteracao_Tabela( "SALDO_ESTOQUE_SAP",  String(al_Filial) + " @#! " + String(al_produto) + " @#! " + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "DH_ATUALIZACAO", "Null", String( idt_dh_atualizacao, 'dd/mm/yyyy') , 'SAP001',  is_tp_alteracao , Ref as_log, True) Then Return False
			If Not gf_Grava_Historico_Alteracao_Tabela( "SALDO_ESTOQUE_SAP",  String(al_Filial) + " @#! " + String(al_produto) + " @#! " + String( adt_dh_saldo, "dd/mm/yyyy hh:mm:ss"), "VL_CUSTO",            "Null", String( Idc_vl_custo),                                 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False

	End IF

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_saldo_estoque_sap'. Erro: "+lo_rte.GetMessage( )
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

public function boolean of_valida_grava (long al_filial, long al_produto, ref string as_log);Try
	If IsNull(al_filial)  Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da filial legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False   
	End If

	If IsNull(al_produto)  Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If

	If IsNull( il_qt_saldo  )   Then
		is_Coluna_erro = 'qt_saldo'
		as_Log	= "A quantidade de disponivel n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
     //
	If  idt_dh_atualizacao < datetime('1901-01-01 00:00:00')  Then
		is_Coluna_erro = 'dh_atualizacao'
		as_Log	= "A data e hora da informa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lida!"
		Return False
	End If	
	 
	If IsNull( idt_dh_saldo ) or idt_dh_saldo < datetime('1901-01-01 00:00:00')  Then
		is_Coluna_erro = 'dh_saldo'
		as_Log	= "A data do saldo do produto na filial tem que ser uma data v$$HEX1$$e100$$ENDHEX$$lida!"
		Return False
	End If		
	
	 If isnull( idc_vl_custo ) Then
		 is_Coluna_erro = 'vl_custo'
		 as_Log	= "O valor do custo do produto n$$HEX1$$e300$$ENDHEX$$o pode ser nulo!"
		 Return False
	End If		
	
Catch ( runtimeerror   lo_rte )   
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_grava'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

on uo_ge473_saldo_estoque_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_saldo_estoque_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

