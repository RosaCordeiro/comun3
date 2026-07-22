HA$PBExportHeader$uo_ge473_campanha_sap.sru
forward
global type uo_ge473_campanha_sap from nonvisualobject
end type
end forward

global type uo_ge473_campanha_sap from nonvisualobject
end type
global uo_ge473_campanha_sap uo_ge473_campanha_sap

type variables
uo_ge473_comum io_Comum
				
Long il_Tabela = 59
datetime idh_atual

string is_chave_sap
long il_cd_campanha
string is_ds_campanha
string is_rede_campanha
string is_uf
long il_cd_filial
string is_cd_domicilio
Datetime idh_inicio, idh_termino
string is_id_filial_altera_estoque
string is_cd_campanha_sap
string is_matricula_sap

boolean ib_campanha_nova

dc_uo_ds_base ids_produto_promocao_cad

dc_uo_transacao iuo_SqlCa

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_data_parametro (ref string as_log)
public function boolean of_atualiza_campanha (long al_controle, long al_tabela)
public function boolean of_insere_campanha (long al_campanha, boolean ab_campanha_nova, ref string as_log)
public function boolean of_insere_campanha_filial (long al_campanha, boolean ab_campanha_nova, ref string as_log, long al_controle_pai)
public function boolean of_insere_campanha_produto (long al_campanha, boolean ab_campanha_nova, ref string as_log, long al_controle_pai)
public function boolean of_campanha_nova (ref long al_campanha, ref boolean ab_campanha_nova, ref string as_log)
public function boolean of_abre_conexao (string ps_log)
public function boolean of_proxima_promocao (ref long al_proximo, ref string as_log)
public function boolean of_fecha_conexao ()
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_domicilio=false, lb_filial=false, lb_uf=false

Try	
	If IsNull(is_cd_campanha_sap) Or Trim(is_cd_campanha_sap) = ''  Then
		as_Log	= "O valor informado para o campo CD_CAMPANHA n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	End If	

	if is_cd_campanha_sap <> is_chave_sap Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo da campanha SAP $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP enviado.'
		return false
	end if

	If IsNull(is_rede_campanha) Then
		as_Log	= "Rede(organiza$$HEX1$$e700$$ENDHEX$$ao) da campanha n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
	
	If IsNull(is_ds_campanha) Then
		as_Log	= "Nome da campanha n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
	
	if is_id_filial_altera_estoque= 'X' Then
		is_id_filial_altera_estoque = 'S'
	else
		is_id_filial_altera_estoque = 'N'
	end if
	
	If Not IsNull(is_UF) And Trim(is_UF) <> '' Then
		
		If LenA(is_UF) <> 2 Then
			as_Log	= "Valor inv$$HEX1$$e100$$ENDHEX$$lido para a UF da promo$$HEX2$$e700e300$$ENDHEX$$o."
			Return False			
		End If
		
		lb_uf = True
	end if
	
	If Not IsNull(is_cd_Domicilio) And Trim(is_cd_Domicilio) <> '' Then
		
		if lb_uf = True Then
			as_Log	= "Enviado mais de um tipo de integra$$HEX2$$e700e300$$ENDHEX$$o para promo$$HEX2$$e700e300$$ENDHEX$$o_sos_filial."
			Return False
		else
			lb_domicilio = true
		end if
	end if	

	if il_cd_filial > 0 Then
		
		if lb_uf = True or lb_domicilio = True Then
			as_Log	= "Enviado mais de um tipo de integra$$HEX2$$e700e300$$ENDHEX$$o para promo$$HEX2$$e700e300$$ENDHEX$$o_sos_filial."
			Return False						
		else
			lb_filial = true
		end if
	end if

	Choose Case is_rede_campanha
			
		Case 'CP00'
			is_rede_campanha = 'CP'
			
		Case 'DC00'
			is_rede_campanha = 'DC'
			
		Case 'FA00'
			is_rede_campanha = 'FA'
			
		Case 'MP00'
			is_rede_campanha = 'MP'
			
		Case 'PF00'
			is_rede_campanha = 'PF'
			
		Case 'PP00'
			is_rede_campanha = 'PP'
			
		Case Else
			
			as_log = "O valor [" + is_rede_campanha + "] informado para o campo CD_ORG_VENDAS n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."	
			return false
			
	End Choose

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setNull(il_cd_campanha)
	setNull(is_ds_campanha)
	setNull(is_rede_campanha)
	setNull(is_uf)
	setNull(il_cd_filial)
	setNull(is_cd_domicilio)
	setNull(idh_inicio)
	setnull(idh_termino)
	setNull(is_id_filial_altera_estoque)
	setNull(is_cd_campanha_sap)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
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
											
			uo_ge473_campanha_sap  lo_campanha_sap
			 
			Try
				lo_campanha_sap	= Create uo_ge473_campanha_sap
				lo_campanha_sap.of_atualiza_campanha( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_campanha_sap)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface FornecedorConexao - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log);
select de_chave_sap
into :as_chave_sap
from interface_sap
where nr_controle = :al_controle
Using SQLCA;

if sqlca.sqlcode = -1 then 
	as_log = 'Erro ao consultar a tabela "interface_sap": ' + sqlca.sqlerrtext
	return false
end if

as_chave_sap =  gf_Tira_Zero_Esquerda(as_chave_sap)

return True
end function

public function boolean of_data_parametro (ref string as_log);Select dh_movimentacao Into :idh_atual
From parametro 
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		as_log = "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada nos par$$HEX1$$e200$$ENDHEX$$metros."
	Case -1
		as_log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Movimenta$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro: "  +  + sqlca.sqlerrtext
End Choose

Return False
end function

public function boolean of_atualiza_campanha (long al_controle, long al_tabela);dc_uo_ds_base lds

Long ll_Linhas, &
		ll_Linha, ll_registro_pendente
		
String	ls_Log, ls_cd_filial
		
Boolean lb_Sucesso = True		

Try
	
	if Not of_data_parametro(ref ls_log) Then
		lb_sucesso = false
		return false
	end if
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		lb_sucesso = false
		return false
	end if
		
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_registro_pendente = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	
	/*
	 CAMPANHA_PROMOCAO (59)
	 CAMPANHA_PRODUTO (60)	
	*/
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
	
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
	
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
	
		For ll_Linha = 1 To ll_linhas
			
			is_cd_campanha_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_campanha[ll_Linha])
			
			lo_comum.of_localiza_codigo_promocao_legado( is_cd_campanha_sap, il_cd_campanha, ref ls_log)
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Campanha: ' + String(il_cd_campanha), 3 )
			end if
			
			is_ds_campanha = lo_Comum.ids_lista_registros.Object.de_descricao_campanha[ll_Linha]
			is_rede_campanha = lo_Comum.ids_lista_registros.Object.cd_org_vendas[ll_Linha]
			is_uf = lo_Comum.ids_lista_registros.Object.cd_uf[ll_Linha]
			
			ls_cd_filial = lo_Comum.ids_lista_registros.Object.cd_filial[ll_Linha]
			lo_comum.of_localiza_codigo_filial_legado( ls_cd_filial, ref il_cd_filial, ref ls_log)
			
			is_cd_domicilio = lo_Comum.ids_lista_registros.Object.cd_domicilio[ll_Linha]
			if is_cd_domicilio = '0' Then setnull(is_cd_domicilio)
			
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio[ll_Linha], 'DATA INICIO CAMPANHA', ref idh_inicio, ref ls_Log) Then Return False
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino[ll_Linha], 'DATA TERMINO CAMPANHA', ref idh_termino, ref ls_Log) Then Return False
			
			is_id_filial_altera_estoque = lo_Comum.ids_lista_registros.Object.id_filial_altera_estoque[ll_Linha]
			
			is_matricula_sap = 'SAP001'
			
		Next
		
	Else
		lb_sucesso = false
		Return False
	End If	
	
	Destroy(lo_comum)	
	
	If Not This.of_Valida_Dados(Ref ls_Log) Then
		lb_sucesso = false
		return false
	end if
		
	If Not This.of_campanha_nova( ref il_cd_campanha, ref ib_campanha_nova, ref ls_log ) Then
		lb_sucesso = false
		return false
	end if	
	
	If Not This.of_insere_campanha( il_cd_campanha, ib_campanha_nova, ref ls_log) Then
		lb_sucesso = false
		return false
	end if
//		
	If Not This.of_insere_campanha_filial( il_cd_campanha, ib_campanha_nova, ref ls_log, al_controle ) Then 
		lb_sucesso = false
		return false
	end if
//	
	If Not This.of_insere_campanha_produto( il_cd_campanha, ib_campanha_nova, ref ls_log, al_controle ) Then
		lb_sucesso = false
		return false
	end if	
			
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
	end if		
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
end function

public function boolean of_insere_campanha (long al_campanha, boolean ab_campanha_nova, ref string as_log);date ldt_ini_est_minimo, ldt_fim_est_minimo
datetime ldh_inicio_ant, ldh_termino_ant

Try
	
	ldt_ini_est_minimo = relativedate(date(idh_inicio),-7)
	ldt_fim_est_minimo = relativedate(date(idh_termino),-7)
	
	//Se a diferen$$HEX1$$e700$$ENDHEX$$a entre o fim do estoque minimo e o inicio da promo$$HEX2$$e700e300$$ENDHEX$$o for menor que 7 dias, o fim do estoque minimo ser$$HEX1$$e100$$ENDHEX$$ igual ao fim da promo$$HEX2$$e700e300$$ENDHEX$$o.
	if ldt_fim_est_minimo < date(idh_inicio) Then
		ldt_fim_est_minimo = date(idh_termino)	
	end if
	
	If ab_campanha_nova Then
	
		Insert into promocao_sos(	  cd_promocao_sos, 
											  nm_promocao_sos, 
											  id_tipo_promocao, 
											  id_situacao, 
											  dh_inicio, 
											  dh_termino, 
											  id_filial_altera_estoque,
											  cd_promocao_sap,
											  dh_inicio_estoque_minimo,
											  dh_termino_estoque_minimo,
											  cd_unidade_federacao,
											  cd_cidade_ibge,
											  id_rede_filial)
		Values (	:il_cd_campanha, 
					:is_ds_campanha, 
					'N',
					'L',
					:idh_inicio,
					:idh_termino, 
					:is_id_filial_altera_estoque,
					:is_cd_campanha_sap,
					:ldt_ini_est_minimo,
					:ldt_fim_est_minimo,
					:is_UF,
					:is_cd_Domicilio,
					:is_rede_campanha)
		Using SqlCa;
									
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'promocao_sos'. Erro: "+SqlCa.sqlErrText
			Return False
		else
			//Comita para n$$HEX1$$e300$$ENDHEX$$o travar o banco de dados
			SQLCA.of_commit()
		End If		
	Else		
		
		Select dh_inicio, dh_termino
		into :ldh_inicio_ant, :ldh_termino_ant
		from promocao_sos
		where cd_promocao_sos = :il_cd_campanha;
		
		if sqlca.sqlcode = -1 then 
			as_Log	= "Erro ao consultar a tabela 'promocao_sos'. Erro: " + SqlCa.sqlErrText
			Return False
		end if
		
		if ( ldh_inicio_ant <> idh_inicio ) or ( ldh_termino_ant <>  idh_termino ) Then
		
			Update promocao_sos
			Set	dh_inicio = :idh_inicio,
					dh_termino = :idh_termino,
					nm_promocao_sos = :is_ds_campanha,
					id_filial_altera_estoque = :is_id_filial_altera_estoque,
					dh_inicio_estoque_minimo = :ldt_ini_est_minimo,
					dh_termino_estoque_minimo = :ldt_fim_est_minimo
			Where cd_promocao_sos = :il_cd_campanha
			Using SqlCa;
		
		else
				
			Update promocao_sos
				Set	nm_promocao_sos = :is_ds_campanha,
						id_filial_altera_estoque = :is_id_filial_altera_estoque
			Where cd_promocao_sos = :il_cd_campanha
			Using SqlCa;
		
		end if
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no update da tabela 'promocao_sos'. Erro: "+SqlCa.sqlErrText
			Return False
		Else
			//Comita para n$$HEX1$$e300$$ENDHEX$$o travar o banco de dados
			SQLCA.of_commit()
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_sos'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_insere_campanha_filial (long al_campanha, boolean ab_campanha_nova, ref string as_log, long al_controle_pai);Long ll_linhas
Long ll_linha
Long ll_Filial
Long ll_achou
Long ll_controle_filho
Long ll_contador
Long ll_find

String ls_filial_sap
String ls_chave_sap_filial, ls_cd_campanha_sap

Boolean lb_Filial = True
Boolean lb_UF = True
Boolean lb_cidade = True
			
Try
	
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_filial
	FROM interface_sap  i 
	Where i.cd_tabela = 61
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If

	ls_chave_sap_filial = gf_Tira_Zero_Esquerda(ls_chave_sap_filial)

	If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
		lb_Filial = False
	End If		
	
	If IsNull(is_UF) or Trim(is_UF) = "" Then
		lb_UF = False
	End If
	
	If IsNull(is_cd_Domicilio) or Trim(is_cd_Domicilio) = "" Then
		lb_cidade = False
	End If
	
	If lb_Filial Then //Promocao por Filial
			
		If lb_UF or lb_Cidade Then
			as_Log	= "Foi retornado mais de um tipo de integra$$HEX2$$e700e300$$ENDHEX$$o para Promocao_sos_filial(Filial x UF x Domicilio)."
			Return False			
		End If	
			
		if ls_chave_sap_filial <> is_chave_sap Then
			as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de filial [' + ls_chave_sap_filial + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de campanha [' + is_chave_sap + '].'
			return false
		end if
		
		uo_ge473_comum lo_Comum
		lo_Comum = Create uo_ge473_comum
				
		If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
			For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
				
				If Not io_Comum.of_Localiza_Codigo_Filial_Legado(lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha], Ref  ll_Filial, Ref as_Log) Then Return False
				
				Select cd_promocao_sos
				Into :ll_Achou
				from promocao_sos_filial
				where cd_promocao_sos = :il_cd_campanha
					and cd_filial = :ll_Filial
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0					
						//J$$HEX1$$e100$$ENDHEX$$ existe 					
						Continue
					Case 100
						
						Insert into promocao_sos_filial(  cd_promocao_sos, 
												  cd_filial,
												  nr_matricula_alteracao)
						Values (	:il_cd_campanha, 
									:ll_Filial,
									:is_matricula_sap  )
						Using SqlCa;
													
						If SqlCa.sqlcode = -1 Then
							as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por filial. Erro: "+SqlCa.sqlErrText
							Return False
						Else
							//Comita para n$$HEX1$$e300$$ENDHEX$$o travar o banco de dados
							SQLCA.of_commit()
						End If
						
					Case -1
						as_Log	= "Erro ao localizar filial na promocao sos. Erro: "+SqlCa.sqlErrText
						Return False
				End Choose							
				
			Next
		Else
			Return False
		End If	
			
		
	End if	
	
	If lb_cidade Then

		if ab_campanha_nova = True Then
			
			select count(*)
				into :ll_achou
				from filial f
					inner join cidade c on (c.cd_cidade = f.cd_cidade)
					Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
				where c.cd_cidade_ibge = :is_cd_Domicilio
					and f.id_situacao = 'A'
					and f.id_rede_filial = :is_rede_campanha
			Using SqlCa;
		
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao consultar tabela 'cidade': "+SqlCa.sqlErrText
				Return False
			End If	
			
			If ll_achou = 0 or isnull(ll_achou) Then
				as_log = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ filiais relacionados ao c$$HEX1$$f300$$ENDHEX$$digo IBGE [' + is_cd_domicilio + '] da rede [' + is_rede_campanha + '].'
				return false
			end if
			
		end if

		INSERT INTO promocao_sos_filial  
			( cd_promocao_sos,   
			  cd_filial,   
			  nr_matricula_alteracao) 
		 select :il_cd_campanha, f.cd_filial, :is_matricula_sap 
					from filial f
						inner join cidade c on (c.cd_cidade = f.cd_cidade)
						Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
					where c.cd_cidade_ibge = :is_cd_Domicilio
						and f.id_situacao = 'A'
						and f.id_rede_filial = :is_rede_campanha
					 	and not exists (select 1
						 					from promocao_sos_filial p
										  where p.cd_promocao_sos = :il_cd_campanha
											 and p.cd_filial  = f.cd_filial)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por cidade. Erro: "+SqlCa.sqlErrText
			Return False
		Else
			//Comita para n$$HEX1$$e300$$ENDHEX$$o travar o banco de dados
			SQLCA.of_commit()
		End If				
		
	End If
			
	If lb_UF Then //Insere por UF
	
		if ab_campanha_nova = True Then
	
			Select Count(*)
			into :ll_achou
					from filial f
					inner join cidade c on (c.cd_cidade = f.cd_cidade)
					Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
			where c.cd_unidade_federacao = :is_UF
					and f.id_situacao = 'A'
					and f.id_rede_filial = :is_rede_campanha
					using SQLCA;

			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao consultar tabela 'cidade': "+SqlCa.sqlErrText
				Return False
			End If	
			
			If ll_achou = 0 or isnull(ll_achou) Then
				as_log = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ filiais relacionados a UF [' + is_uf + '] da rede [' + is_rede_campanha + '].'
				return false
			end if
			
		end if

	  INSERT INTO promocao_sos_filial  
			( cd_promocao_sos,   
			  cd_filial,   
			  nr_matricula_alteracao) 
		 select :il_cd_campanha, f.cd_filial, :is_matricula_sap 
			from filial f
					inner join cidade c on (c.cd_cidade = f.cd_cidade)
					Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
			where c.cd_unidade_federacao = :is_UF
					and f.id_situacao = 'A'
					and f.id_rede_filial = :is_rede_campanha
					and not exists (select 1
											from promocao_sos_filial p
										  where p.cd_promocao_sos = :il_cd_campanha
											and p.cd_filial  = f.cd_filial)
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por UF. Erro: "+SqlCa.sqlErrText
				Return False
			Else
				//Comita para n$$HEX1$$e300$$ENDHEX$$o travar o banco de dados
				SQLCA.of_commit()
			End If
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_filial'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally

End Try	

Return True
end function

public function boolean of_insere_campanha_produto (long al_campanha, boolean ab_campanha_nova, ref string as_log, long al_controle_pai);Long ll_linhas
Long ll_linha
Long ll_produto
Long ll_achou
Long ll_controle_filho
Long ll_qt_minimo
Long ll_cd_desconto
Long ll_cd_desconto_clube
Long ll_row
Long ll_find

DateTime ldt_inicio
DateTime ldt_termino
DateTime ldt_alteracao
DateTime ldt_vigencia_futuro

Date ldt_futuro

Decimal ldc_pc_desconto
Decimal ldc_pc_desconto_clube
Decimal ldc_pc_desconto_futuro
Decimal ldc_pc_desconto_clube_futuro

String ls_produto_sap, ls_chave_sap_prod, ls_cd_promocao_sap, ls_id_finaliza_produto, ls_produto_sap_dw

datastore lds_dados, lds_desconto, lds_desconto_clube

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_prod
	FROM interface_sap  i 
	Where i.cd_tabela = 60
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	ls_chave_sap_prod = gf_Tira_Zero_Esquerda(ls_chave_sap_prod)
	
	if (ll_controle_filho = 0 or isnull(ll_controle_filho) ) Then
		if ab_campanha_nova = True Then
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ informa$$HEX2$$e700f500$$ENDHEX$$es de produto na tabela interface_sap."
			return false
		end if
	end if
	
	if ls_chave_sap_prod <> is_chave_sap Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de produto [' + ls_chave_sap_prod + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle da Campanha [' + is_chave_sap + '].'
		return false
	end if
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then	
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()

			//Armazeno o c$$HEX1$$f300$$ENDHEX$$digo do produto como est$$HEX1$$e100$$ENDHEX$$ na DW, para utilizar no FIND mais adiante.
			ls_produto_sap_dw = lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha]
			
			ls_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(ls_produto_sap) Then ls_produto_sap = ''
			
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(ls_produto_sap, Ref ll_Produto, Ref as_Log) Then
				Return False
			End If			
			
			ls_id_finaliza_produto = lo_Comum.ids_lista_registros.Object.id_finaliza_produto[ll_Linha]
			
			ldt_alteracao = idh_atual
		
			Select cd_promocao_sos
			Into :ll_Achou
			from promocao_sos_produto
			where cd_promocao_sos = :il_cd_campanha
				and cd_produto = :ll_produto
			Using SqlCa;

			Choose Case SqlCa.SqlCode
					
				Case 0
					
					if ls_id_finaliza_produto = 'X' Then
						
						Delete from promocao_sos_produto
							where cd_promocao_sos = :il_cd_campanha
								and cd_produto = :ll_produto
							Using SqlCa;
							
						If SqlCa.SqlCode = -1 Then
							as_Log	= "Erro ao excluir registro da tabela 'PROMOCAO_SOS_PRODUTO': "+SqlCa.sqlErrText
							Return False
						else
							//Comita para n$$HEX1$$e300$$ENDHEX$$o travar o banco de dados
							SQLCA.of_commit()
						End If
					
					end if
					
				Case 100
												
					if ls_id_finaliza_produto = 'X' Then Continue
					
					insert into promocao_sos_produto(
							cd_promocao_sos, 
							cd_produto, 
							pc_desconto, 
							dh_alteracao, 
							nr_matricula_alteracao, 
							pc_desconto_clube,
							pc_desconto_futuro,
							pc_desconto_clube_futuro)
					values (	:il_cd_campanha,  
								:ll_Produto,
								0, 
								:ldt_alteracao, 
								:is_matricula_sap, 
								0,
								0,
								0)
					Using SqlCA;
						
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro no insert da tabela 'PROMOCAO_SOS_PRODUTO'. Erro: "+SqlCa.sqlErrText
						Return False
					Else
						//Comita para n$$HEX1$$e300$$ENDHEX$$o travar o banco de dados
						SQLCA.of_commit()
					End If
					
				Case -1
					as_Log	= "Erro no select da tabela 'PROMOCAO_SOS_PRODUTO'. Erro: "+SqlCa.sqlErrText
					Return False
			End Choose				
			
		Next	
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_produto'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_campanha_nova (ref long al_campanha, ref boolean ab_campanha_nova, ref string as_log);Long ll_promocao
String ls_cd_uf, ls_cd_cidade, ls_rede_filial

Try
	
	Select cd_promocao_sos, cd_unidade_federacao, cd_cidade_ibge, id_rede_filial
	Into	:ll_promocao, :ls_cd_uf, :ls_cd_cidade, :ls_rede_filial
	From promocao_sos
	Where cd_promocao_sap = :is_cd_campanha_sap
	Using SqlCa;
		
	Choose Case SqlCa.sqlcode
		Case 0
			
			If ( (ls_cd_uf = is_uf) or (isnull(ls_cd_uf) and isnull(is_uf)) ) & 
				And ( (ls_cd_cidade = is_cd_domicilio) or ( isnull(ls_cd_cidade) and isnull(is_cd_domicilio) ) ) & 
				And ( (ls_rede_filial = is_rede_campanha) or (isnull(ls_rede_filial) and isnull(is_rede_campanha)) ) Then 

				ab_campanha_nova = False
				al_campanha = ll_promocao
				
			else
				
				as_log = 'J$$HEX1$$e100$$ENDHEX$$ existe uma Campanha com o mesmo c$$HEX1$$f300$$ENDHEX$$digo mas com UF, domic$$HEX1$$ed00$$ENDHEX$$lio fiscal ou Rede diferentes.'
				return false
				
			end if
			
		Case 100
			ab_campanha_nova	= True
			
			If Not of_proxima_promocao(ref al_campanha, ref as_Log) Then Return False
			
//			select max(COALESCE(cd_promocao_sos,0)) +1
//				Into :ll_promocao
//			From promocao_sos
//			Using SqlCa;
//		
//			If SqlCa.SqlCode = -1 Then
//				as_Log	= "Erro ao buscar codigo da nova promo$$HEX2$$e700e300$$ENDHEX$$o. Erro: "+SqlCa.sqlErrText
//				Return False				
//			Else
//				al_campanha = ll_promocao
//			End If			
		
		Case -1
			as_Log	= "Erro ao verificar se a promo$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ nova. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_promocao_nova'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True

end function

public function boolean of_abre_conexao (string ps_log);if Not isvalid(iuo_SqlCa) Then
	iuo_SqlCa = create dc_uo_transacao
	iuo_SqlCa.ivs_database = "SYBASE"
end if

if Not iuo_SqlCa.of_isconnected() Then

	If Not iuo_SqlCa.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE473 - Interface Promo$$HEX2$$e700e300$$ENDHEX$$o SAP') Then
		ps_log =  'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_abre_conexao ~n' + "Erro ao conectar no Sybase."
		Return False
	End If
	
end if

return true
end function

public function boolean of_proxima_promocao (ref long al_proximo, ref string as_log);String ls_Ultimo, ls_Proximo

Boolean lb_Sucesso = True

try
	If Not of_Abre_conexao(ref as_log) Then Return False

	Select vl_parametro Into :ls_Ultimo
	From parametro_geral
	Where cd_parametro = 'CD_PROMOCAO_SOS'
	Using iuo_SqlCa;
	
	Choose Case iuo_SqlCa.SqlCode
		Case 0
		Case 100
			as_log = "Par$$HEX1$$e200$$ENDHEX$$metro 'CD_PROMOCAO_SOS' n$$HEX1$$e300$$ENDHEX$$o localizado."
			Return False
		Case -1
			as_log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro  'CD_PROMOCAO_SOS': " + iuo_SqlCa.SqlerrText
			Return False		
	End Choose
	
	al_Proximo = Long(ls_Ultimo) + 1
	
	ls_Proximo = String(al_Proximo)
	
	Update parametro_geral
	Set vl_parametro = :ls_Proximo
	Where cd_parametro = 'CD_PROMOCAO_SOS'
	  and vl_parametro = :ls_Ultimo
	Using iuo_SqlCa;
	
	If iuo_SqlCa.SqlCode = -1 Then
		as_log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro  'CD_PROMOCAO_SOS': " + iuo_SqlCa.SqlerrText
		Return False
	Else	
		If iuo_SqlCa.SqlnRows = 0 Then
			lb_Sucesso = of_proxima_promocao(ref al_Proximo, as_Log)
		End If
	End If
	
	If lb_Sucesso Then
		iuo_SqlCa.of_Commit();
	End If
	
finally
	of_fecha_conexao()
end try

Return lb_Sucesso
end function

public function boolean of_fecha_conexao ();if isvalid(iuo_SqlCa) Then
	iuo_SqlCa.of_disconnect( )
	destroy(iuo_SqlCa)
end if

return true
end function

on uo_ge473_campanha_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_campanha_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum

ids_produto_promocao_cad = Create dc_uo_ds_base
ids_produto_promocao_cad.of_ChangeDataObject("ds_ge473_produto_promocao_cad")

end event

event destructor;Destroy(io_Comum)
Destroy ids_produto_promocao_cad
end event

