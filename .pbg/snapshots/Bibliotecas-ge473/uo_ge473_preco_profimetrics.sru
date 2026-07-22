HA$PBExportHeader$uo_ge473_preco_profimetrics.sru
forward
global type uo_ge473_preco_profimetrics from nonvisualobject
end type
end forward

global type uo_ge473_preco_profimetrics from nonvisualobject
end type
global uo_ge473_preco_profimetrics uo_ge473_preco_profimetrics

type variables
uo_ge473_comum io_Comum

Boolean ib_continue = False

String is_canal_distribuicao,&
		is_domicilio_fiscal,&
		is_organizacao_venda,&
		is_produto_sap,&
		is_filial_sap,&
		is_uf,&
		is_unidade_medida

Long il_produto_legado, il_filial_legado

datetime idh_fim_preco

Date idh_atual
Date idh_inicio_preco

decimal idc_preco_futuro, idc_preco_maximo, idc_preco_clube

String is_matricula_sap = 'SAP001', is_chave_sap
				
long il_tabela = 160

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_busca_fator_conversao (long pl_cd_produto, ref long pl_fator_conversao, ref string ps_log)
public function boolean of_data_parametro (ref string as_log)
public function boolean of_valida_parametro_preco_sap (long pl_cd_filial, ref string ps_log)
public function boolean of_atualiza_preco_profimetrics (long al_controle, long al_tabela)
public function boolean of_insere_produto_uf (ref string ps_log)
public function boolean of_insere_preco_regionalizado (ref string ps_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);boolean lb_existe = false
long ll_existe

Try	

	If IsNull(is_canal_distribuicao) Then
		as_Log	= "Canal de distribui$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	

	If IsNull(is_organizacao_venda) Then
		as_Log	= "Organiza$$HEX2$$e700e300$$ENDHEX$$o Venda n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	
	
	if Not IsNull(is_Domicilio_fiscal) And Trim(is_Domicilio_fiscal) <> '' Then
		as_Log = "O campo domicilio fiscal n$$HEX1$$e300$$ENDHEX$$o pode estar preenchido."
		Return False
	end if
	
	If (Not IsNull(is_filial_sap) and Trim(is_filial_sap) <> '') and (Not IsNull(is_UF) And Trim(is_UF) <> '') Then
		as_Log	= "C$$HEX1$$f300$$ENDHEX$$digo da Filial e Unidade Federa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o podem estar preenchidos ao mesmo tempo."
		Return False
	end if
	
	If (IsNull(is_filial_sap) or Trim(is_filial_sap) = '') and (IsNull(is_UF) or Trim(is_UF) = '') Then
		as_Log	= "C$$HEX1$$f300$$ENDHEX$$digo da Filial ou Unidade Federa$$HEX2$$e700e300$$ENDHEX$$o devem ser preenchidos."
		Return False
	end if
	
	If IsNull(is_unidade_medida) or Trim(is_unidade_medida) = '' Then
		as_Log	= "A Unidade de Medida de Venda n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	If IsNull(idh_inicio_preco) Then
		as_Log	= "A data de in$$HEX1$$ed00$$ENDHEX$$cio do pre$$HEX1$$e700$$ENDHEX$$o de venda n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	If IsNull(idh_fim_preco) Then
		as_Log	= "A data final do pre$$HEX1$$e700$$ENDHEX$$o de venda n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	If IsNull(idc_preco_futuro) Then
		as_Log	= "O valor do pre$$HEX1$$e700$$ENDHEX$$o futuro n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	If IsNull(idc_preco_clube) Then
		as_Log	= "O valor do pre$$HEX1$$e700$$ENDHEX$$o clube n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	if is_canal_distribuicao <> 'LF' and is_canal_distribuicao <> 'EC' Then
		as_log = 'Canal de distribui$$HEX2$$e700e300$$ENDHEX$$o ['+ is_canal_distribuicao + '] est$$HEX1$$e100$$ENDHEX$$ diferente do esperado [LF - Loja F$$HEX1$$ed00$$ENDHEX$$sica; EC - eCommerce].'
		return false
	end if

	Choose Case is_organizacao_venda
			
		Case 'CP00'
			is_organizacao_venda = 'CP'
			
		Case 'DC00'
			is_organizacao_venda = 'DC'
			
		Case 'FA00'
			is_organizacao_venda = 'FA'
			
		Case 'MP00'
			is_organizacao_venda = 'MP'
			
		Case 'PF00'
			is_organizacao_venda = 'PF'
			
		Case 'PP00'
			is_organizacao_venda = 'PP'
			
		Case Else
			
			as_log = "O valor [" + is_organizacao_venda + "] informado para o campo CD_ORGANIZACAO_VENDA n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."	
			return false
			
	End Choose
	
	ib_continue = False 

	//
	if is_canal_distribuicao = 'LF' then

		If Not IsNull(is_UF) And Trim(is_UF) <> '' And is_UF <> 'SP' Then
			
			if is_organizacao_venda <> 'PP' Then
				ib_continue = True
				Return True
			end if
				
		end if

		if il_filial_legado > 0 Then
			
			select Count(*)
			into :ll_existe
			from parametro_loja p
				inner join filial f on (f.cd_filial = p.cd_filial)
			where p.cd_filial = :il_filial_legado
			and p.cd_parametro = 'ID_ADM_FILIAL_SAP'
			and p.vl_parametro = 'S'
			and f.id_situacao = 'A';
			
			if sqlca.sqlcode = -1 then
				as_log = 'Erro ao consultar a tabela "PARAMETRO_LOJA": ' + sqlca.sqlerrtext
				return false
			end if
			
			if ll_existe = 0 or isnull(ll_existe) Then
				as_log = 'A filial [' + string(il_filial_legado) + '] n$$HEX1$$e300$$ENDHEX$$o possui o administrativo integrado ao SAP ou est$$HEX1$$e100$$ENDHEX$$ com situa$$HEX2$$e700e300$$ENDHEX$$o inativa.'
				return false
			end if
			
		end if
		
	End if

	if il_filial_legado > 0 Then
		
		//Se a vig$$HEX1$$ea00$$ENDHEX$$ncia do pre$$HEX1$$e700$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ terminou, ignora o registro e passa para o pr$$HEX1$$f300$$ENDHEX$$ximo.
		if date(idh_fim_preco) < idh_atual Then
			ib_continue = True
			return true
		end if
		
	end if

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setnull(is_canal_distribuicao)
	setnull(is_domicilio_fiscal)
	setnull(is_organizacao_venda)
	setnull(is_produto_sap)
	setnull(is_uf)
	setnull(is_unidade_medida)
	setnull(idh_inicio_preco)
	setnull(idh_fim_preco)
	setnull(idc_preco_futuro)
	setnull(idc_preco_maximo)
	setnull(idc_preco_clube)
	setnull(il_filial_legado)
	setnull(il_produto_legado)
	setnull(is_filial_sap)
	
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
		gvo_aplicacao.of_grava_log("Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_preco_profimetrics.of_processa_atualizacao" )
		Return
	End If
	
	
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_preco_profimetrics  lo_preco_prof
			 
			Try
				lo_preco_prof	= Create uo_ge473_preco_profimetrics
				lo_preco_prof.of_atualiza_preco_profimetrics( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_preco_prof)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_preco_profimetrics.of_processa_atualizacao.")
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

public function boolean of_busca_fator_conversao (long pl_cd_produto, ref long pl_fator_conversao, ref string ps_log);select vl_fator_conversao
into :pl_fator_conversao
from produto_geral
where cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "PRODUTO_GERAL" (of_busca_fator_conversao): ' + sqlca.sqlerrtext
	return false
end if

return true
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

public function boolean of_valida_parametro_preco_sap (long pl_cd_filial, ref string ps_log);string ls_vl_parametro

select vl_parametro
into :ls_vl_parametro
from parametro_loja 
where cd_filial = :pl_cd_filial
and cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_PRECO_SAP';

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela parametro_loja: ' + sqlca.sqlerrtext
	return false
ENd if

if isnull(ls_vl_parametro) or ls_vl_parametro = '' Then
	ps_log = 'O par$$HEX1$$e200$$ENDHEX$$metro ID_UTILIZA_NOVO_CALCULO_PRECO_SAP n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ configurado para a filial ' + string(pl_cd_filial) + '.'
	Return false
End if 

if ls_vl_parametro <> 'S' Then
	ps_log = 'O par$$HEX1$$e200$$ENDHEX$$metro ID_UTILIZA_NOVO_CALCULO_PRECO_SAP est$$HEX1$$e100$$ENDHEX$$ configurado diferente do esperado "S". Interface n$$HEX1$$e300$$ENDHEX$$o habilitada para a filial ' + string(pl_cd_filial) + '.'
	Return false
ENd if

return true
end function

public function boolean of_atualiza_preco_profimetrics (long al_controle, long al_tabela);dc_uo_ds_base lds

Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente, ll_fator_conversao
		
String	ls_Log, ls_Msg_Email

Datetime ldh_Data_Inicio
		
Boolean	lb_Sucesso = True		

Try
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		lb_sucesso = false
		return false
	end if
		
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_registro_pendente = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	
	/*
	 PRECO_REGULAR_PROFIMETRCIS(160)
	*/
	
	If Not This.of_data_parametro(ref ls_log) Then Return False
	 
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
			
			is_canal_distribuicao = lo_Comum.ids_lista_registros.Object.cd_canal_distribuicao[ll_Linha]
			is_domicilio_fiscal = lo_Comum.ids_lista_registros.Object.cd_domicilio_fiscal[ll_Linha]
			is_organizacao_venda = lo_Comum.ids_lista_registros.Object.cd_organizacao_venda[ll_Linha]
			is_uf = lo_Comum.ids_lista_registros.Object.cd_unidade_federacao[ll_Linha]
			is_unidade_medida = lo_Comum.ids_lista_registros.Object.cd_unidade_medida_venda[ll_Linha]
			
			is_filial_sap = lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha]
			
			if not isnull(is_filial_sap) and is_filial_sap <> '' Then
				If Not io_Comum.of_Localiza_Codigo_Filial_Legado(is_filial_sap, Ref il_filial_legado, Ref ls_Log) Then 
					lb_sucesso = false
					Return False
				end if
			end if
			
			is_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(is_produto_sap) Then is_produto_sap = ''
			
			//Se o produto n$$HEX1$$e300$$ENDHEX$$o existir no legado: Envia email e continua o processo.
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(is_produto_sap, Ref il_produto_legado, Ref ls_Log) Then 
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
				end if
				
				ls_Msg_Email = 'Houveram problemas na interface de descida do SAP . <br>'+ &
					 'Interface:<b>' + 'PRECO_REGULAR_PROFIMETRICS' + '</b><br>'+ &
					 'Controle:' + String(al_Controle) + ' <br>'+ &
					 '</ul></ul>'+&
					ls_log

				gf_ge202_envia_email_automatico(183 , '', ls_Msg_Email, {''})

				Continue
				
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Filial: ' + String(il_filial_legado), 3 )
				w_aguarde_3.wf_settext('Produto: ' + String(il_produto_legado), 4 )
			end if
			
			If Not of_busca_fator_conversao(il_produto_legado, ref ll_fator_conversao, ref ls_log) Then 
				lb_sucesso = false
				Return False
			end if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_venda_futuro[ll_Linha], 'PRE$$HEX1$$c700$$ENDHEX$$O FUTURO', ref idc_preco_futuro, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			idc_preco_futuro = Round( idc_preco_futuro*ll_fator_conversao,2)
			
			if idc_preco_futuro >= 100000 Then
				idc_preco_futuro = 99999.99
			End if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_venda_maximo[ll_Linha], 'PRE$$HEX1$$c700$$ENDHEX$$O M$$HEX1$$c100$$ENDHEX$$XIMO', ref idc_preco_maximo, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			idc_preco_maximo = Round( idc_preco_maximo*ll_fator_conversao,2)
			
			if idc_preco_maximo >= 100000 Then
				idc_preco_maximo = 99999.99
			End if
			
			//Preco Clube
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_clube[ll_Linha], 'PRE$$HEX1$$c700$$ENDHEX$$O CLUBE', ref idc_preco_clube, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
			
			idc_preco_clube = Round( idc_preco_clube*ll_fator_conversao,2)
			//
			if idc_preco_clube >= 100000 Then
				idc_preco_clube = 99999.99
			End if
			
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio_preco_venda[ll_Linha], 'DATA INICIO PRECO VENDA', ref ldh_Data_Inicio, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
		
			idh_inicio_preco = Date(ldh_Data_Inicio)
			
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_fim_preco_venda[ll_Linha], 'DATA FIM PRECO VENDA', ref idh_fim_preco, ref ls_Log) Then 
				lb_sucesso = false
				Return False
			end if
		
			If Not This.of_Valida_Dados(Ref ls_Log) Then
				lb_sucesso = false
				return false
			end if
			
			If ib_continue Then 
				ib_continue = false
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
				end if
				
				Continue
			end if
		
			if (il_filial_legado > 0 and not isnull(il_filial_legado)) or this.is_canal_distribuicao = 'EC' Then
				
				if il_filial_legado > 0 Then
					If Not This.of_valida_parametro_preco_sap( il_filial_legado, ref ls_log) Then
						lb_sucesso = false
						return false
					end if
				ENd if
				
				if Not this.of_insere_preco_regionalizado( ref ls_log) Then
					lb_Sucesso	= False
					return false
				ENd if
				
			Else
					
				if Not this.of_insere_produto_uf( ref ls_log) then
					lb_Sucesso	= False
					return false
				End if
					
			End if
			
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
		io_Comum.of_grava_erro(al_controle, 183, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
end function

public function boolean of_insere_produto_uf (ref string ps_log);decimal ldc_vl_preco_venda_atual
decimal ldc_vl_preco_venda_futuro

date ldh_preco_atual
date ldh_preco_futuro 

string ls_Matric_Futura

Try
		
	if idh_inicio_preco <= idh_atual then
	
		ldc_vl_preco_venda_atual = idc_preco_futuro
		ldh_preco_atual 		= idh_inicio_preco
	
		setnull(ldc_vl_preco_venda_futuro)
		setnull(ldh_preco_futuro)
	
		Update produto_uf
			Set 	vl_preco_venda_atual_sap 			= null,
					vl_preco_venda_atual 				=:ldc_vl_preco_venda_atual,
					
					dh_preco_venda_atual_sap 			= null,
					dh_preco_venda_atual 				= :ldh_preco_atual,
												
					vl_preco_venda_futuro_sap 			= null,
					vl_preco_venda_futuro 				= :ldc_vl_preco_venda_futuro,
						 
					dh_preco_venda_futuro_sap 		= null,
					dh_preco_venda_futuro 				= :ldh_preco_futuro,
					
					nr_matric_preco_venda_fut_sap	= null,				
					nr_matric_preco_venda_futuro		= null
						
			where cd_unidade_federacao = :is_UF
				and cd_produto = :il_produto_legado;


	Else
		
		ldc_vl_preco_venda_futuro = idc_preco_futuro
		ldh_preco_futuro 		= idh_inicio_preco
		ls_Matric_Futura 		= 'SAP001'
		
		setnull(ldc_vl_preco_venda_atual)
		setnull(ldh_preco_atual)	
		
		Update produto_uf
			Set 	vl_preco_venda_futuro_sap 			= null,
					vl_preco_venda_futuro 				= :ldc_vl_preco_venda_futuro,
					
					dh_preco_venda_futuro_sap 		= null,
					dh_preco_venda_futuro		 		= :ldh_preco_futuro,
					
					nr_matric_preco_venda_fut_sap	= null,					
					nr_matric_preco_venda_futuro		= :ls_Matric_Futura,
					
					vl_preco_venda_atual_sap 			= null,
					dh_preco_venda_atual_sap 			= null		
					
			where cd_unidade_federacao = :is_UF
				and cd_produto = :il_produto_legado;

	End If
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao atualizar registro na tabela "PRODUTO_UF": ' + sqlca.sqlerrtext
		return false
	end if				
				
	if sqlca.sqlnrows = 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro na tabela "PRODUTO_UF" para o produto [' + string(il_produto_legado) + '] e UF [' + is_UF + '].'
		return false
	end if
		
	// Pega o pre$$HEX1$$e700$$ENDHEX$$o de venda de SC e replica para os demais estados, este processo $$HEX1$$e900$$ENDHEX$$ igual ao que t$$HEX1$$ed00$$ENDHEX$$nhamos no legado,
	// agora os pre$$HEX1$$e700$$ENDHEX$$os de venda s$$HEX1$$f300$$ENDHEX$$ podem ser cadastrados no SAP		
	If is_UF = 'SC' Then
		//	Come$$HEX1$$e700$$ENDHEX$$a a valer assim que o pre$$HEX1$$e700$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ atualizado, pois isso s$$HEX1$$f300$$ENDHEX$$ vai acontecer quando for um 
		//	produto novo, mesmo que j$$HEX1$$e100$$ENDHEX$$ acontece no legado.
		update produto_uf
		set vl_preco_venda_atual = :idc_preco_futuro, dh_preco_venda_atual = :idh_atual
		where cd_produto = :il_produto_legado
			and cd_unidade_federacao not in ('SC','PR','RS','MS','SP')
			and vl_preco_venda_atual = 0.00
		Using SqlCa;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Erro ao atualizar o registro na tabela "PRODUTO_UF (PRECO VENDA ATUAL)": ' + sqlca.sqlerrtext
			return false
		end if			
		  
	End If
		
Finally
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'of_insere_produto_uf: ' + ps_log
End Try

Return true
end function

public function boolean of_insere_preco_regionalizado (ref string ps_log);long ll_existe

decimal ldc_vl_preco_clube_atual
decimal ldc_vl_preco_clube_futuro
decimal ldc_vl_preco_venda_atual

String ls_cd_uf_ecommerce
string ls_Matric_Futura, ls_Matric_Atual

date ldh_preco_atual, ldh_preco_futuro

Try
	
	if this.is_canal_distribuicao = 'EC'	then
		
//		if this.is_organizacao_venda <> 'FA' Then
//			ps_log = 'Rede ECOMMERCE [' + this.is_organizacao_venda + '] n$$HEX1$$e300$$ENDHEX$$o prevista na integra$$HEX2$$e700e300$$ENDHEX$$o.'
//			return false
//		End if
		
		select cd_filial_ecommerce
		into :il_filial_legado
		from ecommerce_rede 
		where id_ecommerce = '2' 
		and id_rede_filial = :this.is_organizacao_venda;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Erro ao consultar registro na tabela "ECOMMERCE_REDE": ' + sqlca.sqlerrtext
			return false
		end if		
		
		If Not This.of_valida_parametro_preco_sap( il_filial_legado, ref ps_log) Then return false
		
//		Select cd_unidade_federacao
//		into :ls_cd_uf_ecommerce
//		from filial f inner join cidade c on c.cd_cidade = f.cd_cidade
//		where f.cd_filial = :il_filial_legado;
//		
//		if sqlca.sqlcode = -1 then
//			ps_log = 'Erro ao consultar registro na tabela "FILIAL/CIDADE": ' + sqlca.sqlerrtext
//			return false
//		end if	
//		
//		if isnull(ls_cd_uf_ecommerce) or ls_cd_uf_ecommerce = '' Then
//			ps_log = 'A UF da filial ecommerce [' + string(il_filial_legado) + '] n$$HEX1$$e300$$ENDHEX$$o foi encontrada.'
//			return false
//		End if
		
	End if
	
	ldc_vl_preco_venda_atual = idc_preco_futuro
	
	if idh_inicio_preco <= idh_atual then
	
		ldc_vl_preco_clube_atual = idc_preco_clube
		ldh_preco_atual 		= idh_inicio_preco
		ls_Matric_Atual 	     = 'SAP001'
	
		setnull(ldc_vl_preco_clube_futuro)
		setnull(ldh_preco_futuro)
		setnull(ls_Matric_Futura)
		
	else
		ldc_vl_preco_clube_futuro = idc_preco_clube
		ldh_preco_futuro 		= idh_inicio_preco
		ls_Matric_Futura 		= 'SAP001'
		
		setnull(ldc_vl_preco_clube_atual)
		setnull(ldh_preco_atual)
		setnull(ls_Matric_Atual)
	end if	
	
	Select Count(*)
		into :ll_existe
		from preco_regionalizado
		where cd_filial = :il_filial_legado
			and cd_produto = :il_produto_legado;
		
	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao consultar a tabela "PRECO_REGIONALIZADO": ' + sqlca.sqlerrtext
		return false
	end if	
				
	if ll_existe = 0 or isnull(ll_existe) Then
		
		If IsNull(ls_Matric_Atual) then
			ls_Matric_Atual = 'SAP001'
		end if
		
		if IsNull(ldc_vl_preco_clube_atual) Then
			ldc_vl_preco_clube_atual = 0
		End if
		
		Insert into preco_regionalizado(cd_filial,
												cd_produto,
												vl_preco_clube_futuro,
												dh_preco_venda_futuro,
												vl_preco_clube_atual,
												dh_preco_venda_atual,
												dh_fim_preco_venda,
												nr_matric_preco_venda_atual,
												nr_matric_preco_venda_futuro,
												vl_preco_venda_atual)
		Values(:il_filial_legado,
				:il_produto_legado,
				:ldc_vl_preco_clube_futuro,
				:ldh_preco_futuro,
				:ldc_vl_preco_clube_atual,
				:idh_atual,
				:idh_fim_preco,
				:ls_Matric_atual,
				:ls_Matric_Futura,
				:ldc_vl_preco_venda_atual);
				
		If sqlca.sqlcode = -1 then 
			ps_log = 'Erro ao inserir registro na tabela "PRECO_REGIONALIZADO": ' + sqlca.sqlerrtext
			return false
		end if
							
	else
		
		if idh_inicio_preco <= idh_atual then
	
			Update preco_regionalizado
			set vl_preco_venda_atual = :ldc_vl_preco_venda_atual,
				vl_preco_clube_atual 			= :ldc_vl_preco_clube_atual,
				dh_preco_venda_atual 			= :ldh_preco_atual,
				vl_preco_clube_futuro 			= :ldc_vl_preco_clube_futuro,
				dh_preco_venda_futuro 			= :ldh_preco_futuro,
				dh_fim_preco_venda 				= :idh_fim_preco,
				nr_matric_preco_venda_futuro = null
			where cd_filial = :il_filial_legado
			and cd_produto = :il_produto_legado;
		
		else
			
			Update preco_regionalizado
				set vl_preco_venda_futuro = :ldc_vl_preco_venda_atual,
					vl_preco_clube_futuro = :ldc_vl_preco_clube_futuro,
					dh_preco_venda_futuro = :ldh_preco_futuro,
					dh_fim_preco_venda = :idh_fim_preco,
					nr_matric_preco_venda_futuro = 'SAP001'
				where cd_filial = :il_filial_legado
				and cd_produto = :il_produto_legado;
		
		end if
	
		if sqlca.sqlcode = -1 then
			ps_log = 'Erro ao atualizar registro na tabela "PRECO_REGIONALIZADO": ' + sqlca.sqlerrtext
			return false
		end if	
		
	ENd if

Finally
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'of_insere_preco_regionalizado: ' + ps_log
End Try

return true
end function

on uo_ge473_preco_profimetrics.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_preco_profimetrics.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

