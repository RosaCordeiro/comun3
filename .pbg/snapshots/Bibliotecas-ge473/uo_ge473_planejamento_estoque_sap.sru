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

String	is_cd_produto_sap, &
		is_filial_sap, &
		is_cd_curva_ABC

long il_qt_dias_cobertura, &
		il_cd_filial_legado, &
		il_cd_produto_legado

Long il_Tabela = 28
String is_tp_alteracao

Decimal idc_qt_demanda_diaria 

DateTime idh_planejamento

//-- Erro --//
long il_nr_controle_erro
String is_Coluna_erro
Int ii_nr_item_erro
end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_grava_historico_planejamento_estoque (long al_filial, long al_produto, ref string as_log)
public function boolean of_insere_planejamento_estoque_sap (long al_filial, long al_produto, ref string as_log)
public function boolean of_valida_grava (long al_filial, long al_produto, ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_planejamento_estoque_sap (long al_controle, long al_tabela)
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
	
Catch ( runtimeerror lo_rte )
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

public function boolean of_grava_historico_planejamento_estoque (long al_filial, long al_produto, ref string as_log);DateTime	ldh_planejamento
long            ll_qt_dias_cobertura
String         ls_cd_curva_ABC 
Decimal	   ldc_qt_demanda_diaria 
	
Try			
	SetNull ( is_Coluna_erro )
	
	Select	  qt_demanda_diaria,
	           qt_dias_cobertura,
			  cd_curva_abc,
	           dh_planejamento 
	Into	 :ldc_qt_demanda_diaria ,
	          :ll_qt_dias_cobertura,
			 :ls_cd_curva_ABC,
			 :ldh_planejamento 
	From planejamento_estoque_sap	
	Where cd_filial	= :al_Filial
		And cd_produto = :al_produto
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
			
End IF

Return True
end function

public function boolean of_valida_grava (long al_filial, long al_produto, ref string as_log);Try

	If IsNull(al_filial)  Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o encontrado a Filial no legado correspondente a filial SAP. "
		Return False  
	End If

	If IsNull(al_produto)  Then
		as_Log	= " N$$HEX1$$e300$$ENDHEX$$o encontrado o C$$HEX1$$f300$$ENDHEX$$digo do Produto Legado para o C$$HEX1$$f300$$ENDHEX$$digo do Produto SAP."
		Return False  
	End If

	If IsNull(idc_qt_demanda_diaria ) Then
		as_Log = "A Quantidade de Demanda Di$$HEX1$$e100$$ENDHEX$$ria n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If

	If IsNull( il_qt_dias_cobertura ) Then
		as_Log = "A Quantidade Dias de Cobertura n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	
	
	If IsNull( is_cd_curva_ABC ) Then is_cd_curva_ABC = 'X'
	 
	If IsNull( is_cd_curva_ABC )    Then
		as_Log	= "A Curva ABC do produto n$$HEX1$$e300$$ENDHEX$$o foi nformada ou est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida."
		Return False
	End If		
	
	If IsNull( idh_planejamento ) or idh_planejamento < datetime('1901-01-01 00:00:00')  Then
		as_Log	= "Data do planejamento estoque inv$$HEX1$$e100$$ENDHEX$$lida."
		Return False
	End If		
	
Catch ( runtimeerror   lo_rte )   
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_grava'. Erro: "+lo_rte.GetMessage( )
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
		gvo_aplicacao.of_grava_log("Interface Planejamento estoque SAP - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_planejamento_estoque_sap.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_planejamento_estoque_sap  lo_planejamento_estoque_sap
			 
			Try
				lo_planejamento_estoque_sap	= Create uo_ge473_planejamento_estoque_sap
				lo_planejamento_estoque_sap.of_atualiza_planejamento_estoque_sap(lds.Object.nr_controle[ll_Linha] ,  il_Tabela )
			Finally
				Destroy(lo_planejamento_estoque_sap)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Planejamento estoque SAP - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_planejamento_estoque_sap.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try

end subroutine

public function boolean of_atualiza_planejamento_estoque_sap (long al_controle, long al_tabela);dc_uo_ds_base lds

Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente
		
String	ls_Log
String ls_inicio, ls_fim, ls_alteracao
Boolean	lb_Sucesso = True		

Try
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		lb_sucesso = false
		return false
	end if
		
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_registro_pendente = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	//if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	 
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		ll_linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		For ll_Linha = 1 To ll_linhas
			
			this.of_inicializa_variaveis( ref ls_log )

			is_filial_sap = lo_Comum.ids_lista_registros.object.cd_filial_sap[ll_linha]
			is_cd_produto_sap = lo_Comum.ids_lista_registros.object.cd_produto_sap[ll_linha]
			il_qt_dias_cobertura = long(lo_Comum.ids_lista_registros.object.qt_dias_cobertura[ll_linha])
			is_cd_curva_abc = lo_Comum.ids_lista_registros.object.cd_curva_abc[ll_linha]
			
			If Not io_Comum.of_Localiza_Codigo_Filial_Legado(is_filial_sap, Ref il_cd_filial_legado, Ref ls_Log) Then
				lb_Sucesso = false 
				return false
			End IF
				
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref il_cd_Produto_legado, Ref ls_Log) Then
				lb_Sucesso = false 
				return false
			End IF
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Filial: ' + String(il_cd_filial_legado), 3 )
				w_aguarde_3.wf_settext('Produto: ' + String(il_cd_Produto_legado), 4 )
			end if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.object.qt_demanda_diaria[ll_linha], 'QT_DEMANDA_DIARIA', ref idc_qt_demanda_diaria, ref ls_Log) Then Return False
			If Not io_Comum.of_Date_Time(lo_Comum.ids_lista_registros.object.dh_planejamento[ll_linha], 'DATA DE PLANEJAMENTO', ref idh_planejamento, ref ls_Log) Then Return False
			
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
			
			If Not This.of_grava_historico_planejamento_estoque(il_cd_filial_legado, il_cd_produto_legado, Ref ls_Log) Then
				lb_Sucesso = false 
				return false
			End IF

			If Not This.of_valida_grava(il_cd_filial_legado, il_cd_produto_legado, Ref ls_Log) Then
				lb_Sucesso = false 
				return false
			End IF

			If Not This.of_Insere_Planejamento_Estoque_Sap(il_cd_filial_legado, il_cd_produto_legado, Ref ls_Log) Then
				lb_Sucesso = false 
				return false
			 End IF
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
			end if
			
		Next
		
	Else
		lb_sucesso = false
		Return False
	End If	
	
	Destroy(lo_comum)	
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 176, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
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

