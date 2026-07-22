HA$PBExportHeader$uo_ge473_grupo_mercadorias.sru
forward
global type uo_ge473_grupo_mercadorias from nonvisualobject
end type
end forward

global type uo_ge473_grupo_mercadorias from nonvisualobject
end type
global uo_ge473_grupo_mercadorias uo_ge473_grupo_mercadorias

type variables
Boolean 	ib_execucao_simultanea=false
Long 		il_tabela = 137
Long 		il_nr_requisicao
String	is_de_chave_acesso_sap

end variables

forward prototypes
public subroutine of_processa_atualizacao (long al_tabela)
public function boolean of_atualiza_grupo_mercadorias (long al_controle, long al_tabela)
end prototypes

public subroutine of_processa_atualizacao (long al_tabela);Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Grupo Mercadorias - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_grupo_mercadorias.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(al_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			uo_ge473_grupo_mercadorias	luo_ge473_grupo_mercadorias
			 
			Try
				luo_ge473_grupo_mercadorias	= Create uo_ge473_grupo_mercadorias
				luo_ge473_grupo_mercadorias.of_atualiza_grupo_mercadorias( lds.Object.nr_controle[ll_Linha],al_tabela )

			Finally
				Destroy(luo_ge473_grupo_mercadorias)
			End Try
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Grupo Mercadorias - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_grupo_mercadorias.of_processa_atualizacao")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_grupo_mercadorias (long al_controle, long al_tabela);Boolean 	lb_Sucesso = False
Date		ld_dh_inicio_vigencia, ld_dh_fim_vigencia
DateTime	ldt_data_atual
Long 		ll_Atualizacao_Pend, ll_Linhas, ll_for, ll_nivel_hierarquia
String 	ls_Log, ls_Chave_Controle, ls_cd_grupo_mercadoria, ls_cd_grupo_mercadoria_primeiro_n, &
			ls_cd_grupo_mercadoria_quarto_n, ls_cd_grupo_mercadoria_quinto_n, ls_cd_grupo_mercadoria_segundo_n, &
			ls_cd_grupo_mercadoria_sexto_n, ls_cd_grupo_mercadoria_terceiro_n, ls_de_grupo_mercadoria, &
			ls_de_grupo_mercadoria_primeiro_n, ls_de_grupo_mercadoria_quarto_n, ls_de_grupo_mercadoria_quinto_n, &
			ls_de_grupo_mercadoria_segundo_n, ls_de_grupo_mercadoria_sexto_n, ls_de_grupo_mercadoria_terceiro_n, &
			ls_fim_vigencia, ls_inicio_vigencia, ls_id_hierarquia


Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
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
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		for ll_for = 1 to ll_linhas
			ls_cd_grupo_mercadoria					= lo_Comum.ids_lista_registros.Object.cd_grupo_mercadoria[ll_for]
			ls_cd_grupo_mercadoria_primeiro_n	= lo_Comum.ids_lista_registros.Object.cd_grupo_mercadoria_primeiro_n[ll_for]
			ls_cd_grupo_mercadoria_quarto_n	= lo_Comum.ids_lista_registros.Object.cd_grupo_mercadoria_quarto_n[ll_for]
			ls_cd_grupo_mercadoria_quinto_n	= lo_Comum.ids_lista_registros.Object.cd_grupo_mercadoria_quinto_n[ll_for]
			ls_cd_grupo_mercadoria_segundo_n	= lo_Comum.ids_lista_registros.Object.cd_grupo_mercadoria_segundo_n[ll_for]
			ls_cd_grupo_mercadoria_sexto_n		= lo_Comum.ids_lista_registros.Object.cd_grupo_mercadoria_sexto_n[ll_for]
			ls_cd_grupo_mercadoria_terceiro_n	= lo_Comum.ids_lista_registros.Object.cd_grupo_mercadoria_terceiro_n[ll_for]
			ls_de_grupo_mercadoria					= gf_retira_acentos(lo_Comum.ids_lista_registros.Object.de_grupo_mercadoria[ll_for])
			ls_de_grupo_mercadoria_primeiro_n	= gf_retira_acentos(lo_Comum.ids_lista_registros.Object.de_grupo_mercadoria_primeiro_n[ll_for])
			ls_de_grupo_mercadoria_quarto_n	= gf_retira_acentos(lo_Comum.ids_lista_registros.Object.de_grupo_mercadoria_quarto_n[ll_for])
			ls_de_grupo_mercadoria_quinto_n	= gf_retira_acentos(lo_Comum.ids_lista_registros.Object.de_grupo_mercadoria_quinto_n[ll_for])
			ls_de_grupo_mercadoria_segundo_n	= gf_retira_acentos(lo_Comum.ids_lista_registros.Object.de_grupo_mercadoria_segundo_n[ll_for])
			ls_de_grupo_mercadoria_sexto_n		= gf_retira_acentos(lo_Comum.ids_lista_registros.Object.de_grupo_mercadoria_sexto_n[ll_for])
			ls_de_grupo_mercadoria_terceiro_n	= gf_retira_acentos(lo_Comum.ids_lista_registros.Object.de_grupo_mercadoria_terceiro_n[ll_for])
			ls_fim_vigencia								=	lo_Comum.ids_lista_registros.Object.dh_fim_vigencia[ll_for]
			ls_inicio_vigencia 							= lo_Comum.ids_lista_registros.Object.dh_inicio_vigencia[ll_for]
			ls_id_hierarquia							= lo_Comum.ids_lista_registros.Object.id_hierarquia[ll_for]
						
			ld_dh_fim_vigencia = date(Left(ls_fim_vigencia, 4) + '-' + Mid(ls_fim_vigencia, 5, 2) + '-'  + Right(ls_fim_vigencia, 2)  )
			ld_dh_inicio_vigencia = date(Left(ls_inicio_vigencia, 4) + '-' + Mid(ls_inicio_vigencia, 5, 2) + '-'  + Right(ls_inicio_vigencia, 2)  )
			
			if ls_id_hierarquia = 'X' then
				if Not IsNull(ls_cd_grupo_mercadoria_primeiro_n) and Trim(ls_cd_grupo_mercadoria_primeiro_n) <> '' then
					ll_nivel_hierarquia	= 1
				elseif Not IsNull(ls_cd_grupo_mercadoria_segundo_n) and Trim(ls_cd_grupo_mercadoria_segundo_n) <> '' then
					ll_nivel_hierarquia = 2
				elseif Not IsNull(ls_cd_grupo_mercadoria_terceiro_n) and Trim(ls_cd_grupo_mercadoria_terceiro_n) <> '' then
					ll_nivel_hierarquia = 3
				elseif Not IsNull(ls_cd_grupo_mercadoria_quarto_n) and Trim(ls_cd_grupo_mercadoria_quarto_n) <> '' then
					ll_nivel_hierarquia = 4
				elseif Not IsNull(ls_cd_grupo_mercadoria_quinto_n) and Trim(ls_cd_grupo_mercadoria_quinto_n) <> '' then
					ll_nivel_hierarquia = 5
				elseif Not IsNull(ls_cd_grupo_mercadoria_sexto_n) and Trim(ls_cd_grupo_mercadoria_sexto_n) <> '' then
					ll_nivel_hierarquia = 6
				end if
				
				choose case ll_nivel_hierarquia
					Case 1
						update grupo_mercadorias
						set de_grupo_primeiro_nivel	= :ls_de_grupo_mercadoria_primeiro_n
						where cd_grupo_primeiro_nivel = :ls_cd_grupo_mercadoria;
						
						if SQLCA.SQLCode = -1 then
							ls_Log  = "Problema ao atualizar os grupos de mercadoria da hierarquia " + ls_cd_grupo_mercadoria + ".~r~rErro: " + SQLCA.SQLErrText
							Return False
						end if
					Case 2						
						update grupo_mercadorias
						set de_grupo_segundo_nivel	= :ls_de_grupo_mercadoria_segundo_n
						where cd_grupo_segundo_nivel = :ls_cd_grupo_mercadoria;
						
						if SQLCA.SQLCode = -1 then
							ls_Log  = "Problema ao atualizar os grupos de mercadoria da hierarquia " + ls_cd_grupo_mercadoria + ".~r~rErro: " + SQLCA.SQLErrText
							Return False
						end if
					Case 3
						update grupo_mercadorias
						set de_grupo_terceiro_nivel	= :ls_de_grupo_mercadoria_terceiro_n
						where cd_grupo_terceiro_nivel = :ls_cd_grupo_mercadoria;
						
						if SQLCA.SQLCode = -1 then
							ls_Log  = "Problema ao atualizar os grupos de mercadoria da hierarquia " + ls_cd_grupo_mercadoria + ".~r~rErro: " + SQLCA.SQLErrText
							Return False
						end if
					Case 4
						update grupo_mercadorias
						set de_grupo_quarto_nivel	= :ls_de_grupo_mercadoria_quarto_n
						where cd_grupo_quarto_nivel = :ls_cd_grupo_mercadoria;
						
						if SQLCA.SQLCode = -1 then
							ls_Log  = "Problema ao atualizar os grupos de mercadoria da hierarquia " + ls_cd_grupo_mercadoria + ".~r~rErro: " + SQLCA.SQLErrText
							Return False
						end if
					Case 5
						update grupo_mercadorias
						set de_grupo_quinto_nivel	= :ls_de_grupo_mercadoria_quinto_n
						where cd_grupo_quinto_nivel = :ls_cd_grupo_mercadoria;
						
						if SQLCA.SQLCode = -1 then
							ls_Log  = "Problema ao atualizar os grupos de mercadoria da hierarquia " + ls_cd_grupo_mercadoria + ".~r~rErro: " + SQLCA.SQLErrText
							Return False
						end if
					Case 6
						update grupo_mercadorias
						set de_grupo_sexto_nivel	= :ls_de_grupo_mercadoria_sexto_n
						where cd_grupo_sexto_nivel = :ls_cd_grupo_mercadoria;
						
						if SQLCA.SQLCode = -1 then
							ls_Log  = "Problema ao atualizar os grupos de mercadoria da hierarquia " + ls_cd_grupo_mercadoria + ".~r~rErro: " + SQLCA.SQLErrText
							Return False
						end if

					Case else
						ls_Log  = "Altera$$HEX2$$e700e300$$ENDHEX$$o/Cria$$HEX2$$e700e300$$ENDHEX$$o de grupo de mercadoria marcado como hierarquia.~r~rErro: " + SQLCA.SQLErrText
						Return False
				End Choose
			end if
			
			ldt_data_atual = gf_getserverdate()
			
			delete from grupo_mercadorias
					where cd_grupo	= :ls_cd_grupo_mercadoria
			using SQLCA;
			
			if SQLCA.SQLCode = -1 then
				ls_Log  = "Erro ao deletar registro no grupo_mercadorias" + SQLCA.SQLErrText
				Return False
			end if
			
			if ls_id_hierarquia = 'X' then continue
			
		  	INSERT INTO grupo_mercadorias  
						  (cd_grupo,
							cd_grupo_primeiro_nivel,
							cd_grupo_quarto_nivel,
							cd_grupo_quinto_nivel,
							cd_grupo_segundo_nivel,
							cd_grupo_sexto_nivel,
							cd_grupo_terceiro_nivel,
							de_grupo,
							de_grupo_primeiro_nivel,
							de_grupo_quarto_nivel,
							de_grupo_quinto_nivel,
							de_grupo_segundo_nivel,
							de_grupo_sexto_nivel,
							de_grupo_terceiro_nivel,
							dh_fim_validade,
							dh_inicio_validade)  
				 VALUES (:ls_cd_grupo_mercadoria,
							:ls_cd_grupo_mercadoria_primeiro_n,
							:ls_cd_grupo_mercadoria_quarto_n,
							:ls_cd_grupo_mercadoria_quinto_n,
							:ls_cd_grupo_mercadoria_segundo_n,
							:ls_cd_grupo_mercadoria_sexto_n,
							:ls_cd_grupo_mercadoria_terceiro_n,
							:ls_de_grupo_mercadoria,
							:ls_de_grupo_mercadoria_primeiro_n,
							:ls_de_grupo_mercadoria_quarto_n,
							:ls_de_grupo_mercadoria_quinto_n,
							:ls_de_grupo_mercadoria_segundo_n,
							:ls_de_grupo_mercadoria_sexto_n,
							:ls_de_grupo_mercadoria_terceiro_n,
							:ld_dh_fim_vigencia,
							:ld_dh_inicio_vigencia);
							  
			if SQLCA.SQLCode = -1 then
				ls_Log  = "Erro ao inserir registro na grupo_mercadorias " + SQLCA.SQLErrText
				Return False
			end if
		next	
		
		lb_Sucesso = true
	End If

Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_grupo_mercadorias], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_grupo_mercadorias]. Erro: "+lo_rte.GetMessage( )
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

on uo_ge473_grupo_mercadorias.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_grupo_mercadorias.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

