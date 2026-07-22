HA$PBExportHeader$uo_ge473_preco_transferencia.sru
forward
global type uo_ge473_preco_transferencia from nonvisualobject
end type
end forward

global type uo_ge473_preco_transferencia from nonvisualobject
end type
global uo_ge473_preco_transferencia uo_ge473_preco_transferencia

type variables
uo_ge473_comum io_Comum

String 	is_cd_produto_sap,    &
		    is_filial_sap 
      
String  is_tp_alteracao
String  is_uf_destino

DateTime	idt_dh_saldo, &
                  idt_dh_atualizacao 

long            il_qt_saldo

Decimal	  idc_vl_preco
Decimal	  idc_vl_st

Long il_Tabela = 31

              


		
end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_grava (long al_filial, ref long al_produto, string as_log)
public function boolean of_insere_preco_transferencia (long al_filial, long al_produto, string as_cd_uf_destino, ref string as_log)
public function boolean of_grava_historico_preco_transferencia (long al_filial, string as_uf_destino, long al_produto, ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_preco_transferencia (long al_controle, long al_tabela)
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
	
	If IsNull(is_uf_destino) or (Trim(is_uf_destino) = "") Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da UF  est$$HEX1$$e100$$ENDHEX$$ nulo."
		Return False
	End If
	
	
	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setNull( is_cd_produto_sap )
	setNull( is_filial_sap )
    setNull( is_tp_alteracao )
    setNull( idc_vl_preco	)
    setNull( idc_vl_st)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_valida_grava (long al_filial, ref long al_produto, string as_log);Try
	If IsNull(al_filial)  Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da filial legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If

	If IsNull(al_produto)  Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If
	
	 If isnull( idc_vl_preco ) Then
		 as_Log	= "O valor do preco do produto n$$HEX1$$e300$$ENDHEX$$o pode ser nulo!"
		 Return False
	End If		
	
	If isnull( idc_vl_st ) Then
		 as_Log	= "O valor da st do produto n$$HEX1$$e300$$ENDHEX$$o pode ser nulo!"
		 Return False
	End If		
	
	If isnull( is_uf_destino ) Then
		 as_Log	= "O valor da UF n$$HEX1$$e300$$ENDHEX$$o pode ser nulo!"
		 Return False
	End If			
	
Catch ( runtimeerror   lo_rte )   
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_grava'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_insere_preco_transferencia (long al_filial, long al_produto, string as_cd_uf_destino, ref string as_log);
If is_tp_alteracao = 'A' Then 

		Update preco_transf_estoque_sap 
		   set  vl_preco             = :idc_vl_preco ,
		         vl_st	   				= :idc_vl_st
		Where	cd_filial		= :al_Filial
			And	cd_produto	= :al_Produto
			And 	cd_uf_destino =:as_cd_uf_destino
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar os dados da tabela 'PRECO_TRANSF_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
		
		If SqlCa.SqlNRows <> 1 Then
			as_Log	= "Deveria ter atualizado 1 linha na tabela 'PRECO_TRANSF_ESTOQUE_SAP', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]."
			Return False
		End If
		
End If 
//
If is_tp_alteracao = 'I' then
		Insert into preco_transf_estoque_sap ( cd_filial,cd_produto, cd_uf_destino,  vl_preco,  vl_st)
		values 				     ( :al_filial ,      :al_produto ,	    :as_cd_uf_destino ,     :idc_vl_preco,      :idc_vl_st )
		Using SqlCA;
			
			
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar os dados da tabela 'PRECO_TRANSF_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
			
		If SqlCa.SqlNRows <> 1 Then
			as_Log	= "Deveria ter atualizado 1 linha na tabela 'PRECO_TRANSF_ESTOQUE_SAP', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If
			
End IF

Return True
end function

public function boolean of_grava_historico_preco_transferencia (long al_filial, string as_uf_destino, long al_produto, ref string as_log);Decimal		ldc_vl_preco,&
				ldc_vl_st
	
		
Try			
	Select	  vl_preco,
	           	  vl_st
	Into	  :ldc_vl_preco,
				:ldc_vl_st
	From preco_transf_estoque_sap	
	Where	cd_filial		= :al_Filial
		And	cd_produto	= :al_produto
		And  cd_uf_destino =:as_uf_destino 
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			 is_tp_alteracao= 'A'
		Case 100
			 is_tp_alteracao = 'I'
		Case -1
			as_Log	= "Erro no select da tabela 'PRECO_TRANSF_ESTOQUE_SAP', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_preco_transferencia'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	
	
	If ( ldc_vl_preco <> idc_vl_preco) or (IsNull( ldc_vl_preco ) and Not IsNull(idc_vl_preco )) Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRECO_TRANSF_ESTOQUE_SAP", String(al_Filial) + " @#!"+ String(al_produto), "VL_PRECO", STRING( ldc_vl_preco) , STRING( Idc_vl_preco), 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
	End If

	If ( ldc_vl_st <> idc_vl_st) or (IsNull( ldc_vl_st ) and Not IsNull(idc_vl_st )) Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRECO_TRANSF_ESTOQUE_SAP", String(al_Filial) + " @#!"+ String(al_produto), "VL_ST", STRING( ldc_vl_st) , STRING( Idc_vl_st), 'SAP001', is_tp_alteracao , Ref as_log, True) Then Return False
	End If


Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_preco_transferencia'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_preco_transferencia  lo_preco_transferencia
			 
			Try
				lo_preco_transferencia	= Create uo_ge473_preco_transferencia
				lo_preco_transferencia.of_atualiza_preco_transferencia(lds.Object.nr_controle[ll_Linha] ,  il_Tabela )
			Finally
				Destroy(lo_preco_transferencia)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface FornecedorConexao - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_preco_transferencia (long al_controle, long al_tabela);dc_uo_ds_base lds

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
		ls_Obrig
		
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
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_preco_transferencia], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_preco_transferencia]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_preco_transferencia], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_preco_transferencia]."
		Return False
	End If
	//
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_preco_transferencia], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_preco_transferencia]."
		Return False
	End If	
    //	
	ll_item_ini   = lds.object.nr_item[1]
	ll_item_fim  = lds.object.nr_item[  lds.rowcount() ]
	//
//	  Open(w_aguarde)
//	  w_aguarde.Title = "Processando Saldo Estoque SAP.."

//	w_aguarde.uo_Progress.Of_SetMax( ll_item_fim )
//     Yield()
//     w_aguarde.uo_progress.Of_SetProgress( 1 )	 
	 
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False

for ll_loop = ll_item_ini to ll_item_fim
	
	 //w_aguarde.uo_progress.Of_SetProgress( ll_loop )	 
	 //w_aguarde.Title = "Processando Item : " + String( ll_loop ) +" de " + string( ll_item_fim  )
	 
	 
	  //
      lds.setfilter("nr_item = " +  string( ll_loop) )
      lds.filter()	
	 If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	 
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
				
			Case 'cd_produto_sap'
				       is_cd_produto_sap =  ls_Vl_Item 

			Case 'cd_uf_destino'
				       is_uf_destino = ls_Vl_Item 
		
          Case 'vl_preco'
					   If Not io_Comum.of_decimal(ls_Vl_Item, 'VL_PRECO', ref idc_vl_preco, ref ls_Log) Then Return False
					  
           Case 'vl_st'
					   If Not io_Comum.of_decimal(ls_Vl_Item, 'VL_ST', ref idc_vl_st, ref ls_Log) Then Return False

		End choose
		
		
Next		
		 lb_Sucesso	= False
		 
		 If This.of_Valida_Dados(Ref ls_Log) Then
				If io_Comum.of_Localiza_Codigo_Filial_Legado(is_filial_sap, Ref ll_Filial, Ref ls_Log) Then
					If io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref ll_Produto, Ref ls_Log) Then
						If This.of_grava_historico_preco_transferencia(ll_Filial, is_uf_destino, ll_Produto, Ref ls_Log) Then
							  If This.of_valida_grava(ll_Filial,    ll_Produto, Ref ls_Log) Then
								 If This.of_Insere_preco_transferencia(ll_Filial, ll_Produto, is_uf_destino , Ref ls_Log) Then
										  lb_Sucesso	= True
								  End If
							  End If
						End If
					End If
				End If
		 End If
		 
	If not lb_Sucesso then Exit

Next	
Finally 
//	If IsValid(w_aguarde) Then Close( w_aguarde )		

	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 177, ls_Log)
	End If
		
	Destroy(lds)
	
End Try

Return lb_Sucesso
end function

on uo_ge473_preco_transferencia.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_preco_transferencia.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

