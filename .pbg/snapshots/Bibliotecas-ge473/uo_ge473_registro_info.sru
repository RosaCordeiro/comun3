HA$PBExportHeader$uo_ge473_registro_info.sru
forward
global type uo_ge473_registro_info from nonvisualobject
end type
end forward

global type uo_ge473_registro_info from nonvisualobject
end type
global uo_ge473_registro_info uo_ge473_registro_info

type variables
Boolean	ib_execucao_simultanea
String	is_de_chave_acesso_sap, is_nr_solicitacao
end variables

forward prototypes
public subroutine of_processa_atualizacao (long al_tabela)
public function boolean of_atualiza_registro_info (long al_controle, long al_tabela)
end prototypes

public subroutine of_processa_atualizacao (long al_tabela);Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Imposto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_wms_imposto.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(al_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
			
				uo_ge473_registro_info	lo_registro_info
				 
				Try
					lo_registro_info	= Create uo_ge473_registro_info
					lo_registro_info.of_atualiza_registro_info( lds.Object.nr_controle[ll_Linha],al_tabela )
				Finally
					Destroy(lo_registro_info)
				End Try
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Imposto - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_imposto.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_registro_info (long al_controle, long al_tabela);Boolean 	lb_Sucesso = False
Long 		ll_Atualizacao_Pend, ll_Linhas, ll_for, ll_cd_produto
String 	ls_Log, ls_Chave_Controle, ls_cd_fornecedor_sap, ls_cd_imposto_sap, ls_cd_produto_sap, &
			ls_cd_uf_referencia, ls_cd_fornecedor


lb_Sucesso = True

Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	select de_chave_sap
	  into :is_de_chave_acesso_sap
	  from interface_sap  i 
	 where i.cd_tabela 	= :al_tabela
		and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		lb_Sucesso	= False
		Return False
	End If	

	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False

	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then 
		lb_Sucesso	= False
		Return False
	end if
	
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then 
		lb_Sucesso	= False
		Return False
	end if
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.wf_settext('Solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + is_nr_solicitacao , 3 )
		end if
		
		for ll_for = 1 to ll_Linhas
			ls_cd_fornecedor_sap	= lo_Comum.ids_lista_registros.Object.cd_fornecedor_sap[ll_for]
			ls_cd_imposto_sap		= lo_Comum.ids_lista_registros.Object.cd_imposto_sap[ll_for]
			ls_cd_produto_sap		= lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_for]
			ls_cd_uf_referencia	= lo_Comum.ids_lista_registros.Object.cd_regio[ll_for]
			
			if ls_cd_imposto_sap = '' or IsNull(ls_cd_imposto_sap) then
				ls_Log = "Objeto [uo_ge473_registro_info], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_registro_info]. Erro: Imposto n$$HEX1$$e300$$ENDHEX$$o preenchido dentro do SAP."
				lb_Sucesso	= False
				Return False
			end if
			
			select cd_fornecedor
			into :ls_cd_fornecedor
			from fornecedor
			where cd_fornecedor_sap = :ls_cd_fornecedor_sap;
			
			choose case sqlca.sqlcode
				case -1
					ls_Log = "Objeto [uo_ge473_registro_info], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_registro_info]. Erro: "+sqlca.sqlerrtext
					lb_Sucesso	= False
					Return False
				case 100
					ls_Log = "Objeto [uo_ge473_registro_info], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_registro_info]. Fornecedor SAP" + ls_cd_fornecedor_sap + " n$$HEX1$$e300$$ENDHEX$$o encontrado."
					lb_Sucesso	= False
					Return False
			end choose
			
			ls_cd_produto_sap	= gf_tira_zero_esquerda(ls_cd_produto_sap)
			
			select cd_produto
			into :ll_cd_produto
			from produto_geral
			where cd_produto_sap	= :ls_cd_produto_sap;
			
			choose case sqlca.sqlcode
				case -1
					ls_Log = "Objeto [uo_ge473_registro_info], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_registro_info]. Erro: "+sqlca.sqlerrtext
					lb_Sucesso	= False
					Return False
				case 100
					ls_Log = "Objeto [uo_ge473_registro_info], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_registro_info]. Produto SAP" + ls_cd_produto_sap + " n$$HEX1$$e300$$ENDHEX$$o encontrado."
					lb_Sucesso	= False
					Return False
			end choose

			if ls_cd_uf_referencia = '00' then
				update distribuidora_produto
				set cd_imposto_sap	= :ls_cd_imposto_sap,
					 id_situacao		= 'A'
				where cd_produto	= :ll_cd_produto
				and cd_distribuidora = :ls_cd_fornecedor;
			else
				update distribuidora_produto
				set cd_imposto_sap	= :ls_cd_imposto_sap,
					 id_situacao		= 'A'
				where cd_produto	= :ll_cd_produto
				and cd_distribuidora = :ls_cd_fornecedor
				and cd_unidade_federacao = :ls_cd_uf_referencia;
			end if
			
			choose case sqlca.sqlcode
				case -1
					ls_Log = "Objeto [uo_ge473_registro_info], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_registro_info]. Erro: "+sqlca.sqlerrtext
					lb_Sucesso	= False
					Return False
				case 100
					ls_Log = "Objeto [uo_ge473_registro_info], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_registro_info]. Produto SAP" + ls_cd_produto_sap + " n$$HEX1$$e300$$ENDHEX$$o encontrado."
					lb_Sucesso	= False
					Return False
			end choose			
									
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if	
		next
	End If
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_wms_imposto], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_imposto]. Erro: "+lo_rte.GetMessage( )
	lb_Sucesso	= False
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

on uo_ge473_registro_info.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_registro_info.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

