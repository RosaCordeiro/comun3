HA$PBExportHeader$uo_ge473_arvore_mercadologica.sru
forward
global type uo_ge473_arvore_mercadologica from nonvisualobject
end type
end forward

global type uo_ge473_arvore_mercadologica from nonvisualobject
end type
global uo_ge473_arvore_mercadologica uo_ge473_arvore_mercadologica

type variables
Boolean 	ib_execucao_simultanea=false
Long 		il_tabela = 146 // 132
Long 		il_nr_requisicao
String	is_de_chave_acesso_sap

end variables

forward prototypes
public function boolean of_atualiza_arvore_mercadologica (long al_controle, long al_tabela)
public subroutine of_processa_atualizacao (long al_tabela)
end prototypes

public function boolean of_atualiza_arvore_mercadologica (long al_controle, long al_tabela);Boolean 	lb_Sucesso = False
DateTime	ldt_dh_inicio_validade, ldt_dh_termino_validade, ldt_data_atual
Long 		ll_Atualizacao_Pend, ll_Linhas, ll_for, ll_Controle_filho
String 	ls_Log, ls_Chave_Controle, ls_abobora, ls_cd_arvore_mercadologica, ls_cd_hierarquia, &
			ls_cd_hiernode1, ls_cd_hiernode2, ls_cd_hiernode3, ls_cd_hiernode4, ls_cd_hiernode5, &
			ls_cd_hiernode6, ls_de_arvore_mercadologica, ls_de_hierarquia, ls_de_hiernode1, &
			ls_de_hiernode2, ls_de_hiernode3, ls_de_hiernode4, ls_de_hiernode5, ls_de_hiernode6				


Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	uo_ge473_comum lo_Comum2
	lo_Comum2 = Create uo_ge473_comum
	
	Select de_chave_sap
	  Into :is_de_chave_acesso_sap
	  From interface_sap  i 
	 Where i.cd_tabela = :il_Tabela
		and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
		
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	Select nr_controle
	Into :ll_Controle_filho
	From interface_sap  i 
	Where i.cd_tabela 		= 132
	And i.nr_controle_pai 	= :al_controle
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		ls_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If lo_Comum2.of_processa_carrega_dados(ll_Controle_filho , ref ls_Log) Then
		
		ll_Linhas = lo_Comum2.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		for ll_for = 1 to ll_linhas
			ls_abobora 						= lo_Comum2.ids_lista_registros.Object.abobora[ll_for] //vai vir a data de envio do sap, mas nao esta sendo usada pra nada.
			ls_cd_arvore_mercadologica	= lo_Comum2.ids_lista_registros.Object.cd_arvore_mercadologica[ll_for]
			ls_cd_hierarquia				= lo_Comum2.ids_lista_registros.Object.cd_hierarquia[ll_for]
			ls_cd_hiernode1				= lo_Comum2.ids_lista_registros.Object.cd_hiernode1[ll_for]
			ls_cd_hiernode2				= lo_Comum2.ids_lista_registros.Object.cd_hiernode2[ll_for]
			ls_cd_hiernode3				= lo_Comum2.ids_lista_registros.Object.cd_hiernode3[ll_for]
			ls_cd_hiernode4				= lo_Comum2.ids_lista_registros.Object.cd_hiernode4[ll_for]
			ls_cd_hiernode5				= lo_Comum2.ids_lista_registros.Object.cd_hiernode5[ll_for]
			ls_cd_hiernode6				= lo_Comum2.ids_lista_registros.Object.cd_hiernode6[ll_for]
			ls_de_arvore_mercadologica	= lo_Comum2.ids_lista_registros.Object.de_arvore_mercadologica[ll_for]
			ls_de_hierarquia				= lo_Comum2.ids_lista_registros.Object.de_hierarquia[ll_for]
			ls_de_hiernode1				= lo_Comum2.ids_lista_registros.Object.de_hiernode1[ll_for]
			ls_de_hiernode2				= lo_Comum2.ids_lista_registros.Object.de_hiernode2[ll_for]
			ls_de_hiernode3				= lo_Comum2.ids_lista_registros.Object.de_hiernode3[ll_for]
			ls_de_hiernode4				= lo_Comum2.ids_lista_registros.Object.de_hiernode4[ll_for]
			ls_de_hiernode5				= lo_Comum2.ids_lista_registros.Object.de_hiernode5[ll_for]
			ls_de_hiernode6				= lo_Comum2.ids_lista_registros.Object.de_hiernode6[ll_for]
			ldt_dh_inicio_validade		= DateTime(lo_Comum2.ids_lista_registros.Object.dh_inicio_validade[ll_for])
			ldt_dh_termino_validade		= DateTime(lo_Comum2.ids_lista_registros.Object.dh_termino_validade[ll_for])
			
			ldt_data_atual = gf_getserverdate()
			
			delete from arvore_mercadologica
					where cd_arvore_mercadologica = :ls_cd_arvore_mercadologica
			using SQLCA;
			
			if SQLCA.SQLCode = -1 then
				ls_Log  = "Erro ao deletar registro na arvore_mercadologica " + SQLCA.SQLErrText
				Return False
			end if
			
		  	INSERT INTO arvore_mercadologica  
							( cd_arvore_mercadologica,   
							  de_arvore_mercadologica,   
							  cd_hiernode1,   
							  de_hiernode1,   
							  cd_hiernode2,   
							  de_hiernode2,   
							  cd_hiernode3,   
							  de_hiernode3,   
							  cd_hiernode4,   
							  de_hiernode4,   
							  cd_hiernode5,   
							  de_hiernode5,   
							  cd_hiernode6,   
							  de_hiernode6,   
							  dh_inicio_validade,   
							  dh_termino_validade,   
							  dh_inclusao )  
				  VALUES ( :ls_cd_arvore_mercadologica,   
							  :ls_de_arvore_mercadologica,   
							  :ls_cd_hiernode1,   
							  :ls_de_hiernode1,   
							  :ls_cd_hiernode2,   
							  :ls_de_hiernode2,   
							  :ls_cd_hiernode3,   
							  :ls_de_hiernode3,   
							  :ls_cd_hiernode4,   
							  :ls_de_hiernode4,   
							  :ls_cd_hiernode5,   
							  :ls_de_hiernode5,   
							  :ls_cd_hiernode6,   
							  :ls_de_hiernode6,   
							  :ldt_dh_inicio_validade,   
							  :ldt_dh_termino_validade,   
							  :ldt_data_atual)  ;
							  
			if SQLCA.SQLCode = -1 then
				ls_Log  = "Erro ao inserir registro na arvore_mercadologica " + SQLCA.SQLErrText
				Return False
			end if
		next	
		
		lb_Sucesso = true
	End If

Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_wms_movimento_estoque_confirmacao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_confirmacao_mov_estoque]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum2.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum
	Destroy lo_Comum2
	
End Try
	

Return True
end function

public subroutine of_processa_atualizacao (long al_tabela);Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Arvore mercadologica - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_retira_excesso_estoque.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(al_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			uo_ge473_arvore_mercadologica	luo_ge473_arvore_mercadologica
			 
			Try
				luo_ge473_arvore_mercadologica	= Create uo_ge473_arvore_mercadologica
				luo_ge473_arvore_mercadologica.of_atualiza_arvore_mercadologica( lds.Object.nr_controle[ll_Linha],al_tabela )

			Finally
				Destroy(luo_ge473_arvore_mercadologica)
			End Try
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Arvore mercadologica - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_retira_excesso_estoque.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

on uo_ge473_arvore_mercadologica.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_arvore_mercadologica.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

