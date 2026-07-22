HA$PBExportHeader$uo_ge473_preco_pmc.sru
forward
global type uo_ge473_preco_pmc from nonvisualobject
end type
end forward

global type uo_ge473_preco_pmc from nonvisualobject
end type
global uo_ge473_preco_pmc uo_ge473_preco_pmc

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
				
long il_tabela = 161

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_busca_fator_conversao (long pl_cd_produto, ref long pl_fator_conversao, ref string ps_log)
public function boolean of_data_parametro (ref string as_log)
public function boolean of_insere_preco_pmc (ref string as_log)
public function boolean of_atualiza_preco_pmc (long al_controle, long al_tabela)
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


	If IsNull(is_UF) or Trim(is_UF) = '' Then
		as_Log = "O campo unidade federa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	if Not IsNull(is_Domicilio_fiscal) And Trim(is_Domicilio_fiscal) <> '' Then
		as_Log = "O campo domicilio fiscal n$$HEX1$$e300$$ENDHEX$$o pode estar preenchido."
		Return False
	end if
	
	If Not IsNull(is_filial_sap) and Trim(is_filial_sap) <> '' Then
		as_Log	= "C$$HEX1$$f300$$ENDHEX$$digo da Filial n$$HEX1$$e300$$ENDHEX$$o pode estar preenchido."
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
	
	If IsNull(idc_preco_maximo) Then
		as_Log	= "O valor do pre$$HEX1$$e700$$ENDHEX$$o m$$HEX1$$e100$$ENDHEX$$ximo n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	end if
	
	If Not IsNull(idc_preco_futuro) and idc_preco_futuro <> 0 Then
		as_Log	= "O valor do pre$$HEX1$$e700$$ENDHEX$$o futuro n$$HEX1$$e300$$ENDHEX$$o pode estar preenchido."
		Return False
	end if
	
	If Not IsNull(idc_preco_clube) and idc_preco_clube <> 0 Then
		as_Log	= "O valor do pre$$HEX1$$e700$$ENDHEX$$o clube n$$HEX1$$e300$$ENDHEX$$o pode estar preenchido."
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
		gvo_aplicacao.of_grava_log("Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_preco_pmc.of_processa_atualizacao" )
		Return
	End If
	
	
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_preco_pmc  lo_preco_pmc
			 
			Try
				lo_preco_pmc	= Create uo_ge473_preco_pmc
				lo_preco_pmc.of_atualiza_preco_pmc( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_preco_pmc)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_preco_pmc.of_processa_atualizacao.")
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

public function boolean of_insere_preco_pmc (ref string as_log);
decimal ldc_vl_preco_atual, ldc_vl_preco_futuro
date ldh_preco_atual, ldh_preco_futuro

long ll_existe

String ls_Matric_Nula, ls_Matric_Futura, ls_Matric_Atual

Setnull(ls_Matric_Futura)
SetNull(ls_Matric_Atual)
SetNull(ls_Matric_Nula)

if idh_inicio_preco <= idh_atual then
	
	ldc_vl_preco_atual 	= idc_preco_maximo
	ldh_preco_atual 		= idh_inicio_preco
	ls_Matric_Atual 	     = 'SAP001'

	setnull(ldc_vl_preco_futuro)
	setnull(ldh_preco_futuro)
		
else
	ldc_vl_preco_futuro 	= idc_preco_maximo
	ldh_preco_futuro 		= idh_inicio_preco
	ls_Matric_Futura 		= 'SAP001'
	
	setnull(ldc_vl_preco_atual)
	setnull(ldh_preco_atual)	
end if		

//Encerramento do PMC
if date(idh_fim_preco) <= idh_atual Then
	ldc_vl_preco_atual = 0
	setnull(ldh_preco_atual)	
end if

Select Count(*)
into :ll_existe
from produto_uf
where cd_produto = :il_produto_legado
and cd_unidade_federacao = :is_uf;
	
if sqlca.sqlcode = -1 then
	as_log = 'Erro ao consultar a tabela "PRODUTO_UF": ' + sqlca.sqlerrtext
	return false
end if	
			
if ll_existe = 0 or isnull(ll_existe) Then
	as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encongrado registro na tabela PRODUTO_UF para o produto ' + string(il_produto_legado) + '(' + is_uf + ').'
	return false
						
else
	
	if idh_inicio_preco <= idh_atual then

		Update produto_uf
		set vl_preco_venda_maximo_sap = :ldc_vl_preco_atual,
			dh_preco_venda_maximo_sap = :ldh_preco_atual,
			vl_preco_venda_maximo = :ldc_vl_preco_atual,
			vl_preco_venda_maximo_fut_sap = null,
			dh_preco_venda_maximo_fut_sap = null,
			nr_matric_preco_venda_futuro = :ls_Matric_Nula
		where cd_produto = :il_produto_legado
		and cd_unidade_federacao = :is_uf;
	
	else
		
		Update produto_uf
			set vl_preco_venda_maximo_fut_sap = :ldc_vl_preco_futuro,
				dh_preco_venda_maximo_fut_sap = :ldh_preco_futuro,
				nr_matric_preco_venda_futuro = 'SAP001'
			where cd_produto = :il_produto_legado
			and cd_unidade_federacao = :is_uf;
	
	end if

	if sqlca.sqlcode = -1 then
		as_log = 'Erro ao atualizar registro na tabela "PRODUTO_UF": ' + sqlca.sqlerrtext
		return false
	end if	

End if

Return True
end function

public function boolean of_atualiza_preco_pmc (long al_controle, long al_tabela);dc_uo_ds_base lds

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
	 PRECO_PMC
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
					 'Interface:<b>' + 'PRECO_PMC' + '</b><br>'+ &
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
			
			if idc_preco_clube >= 100000 Then
				idc_preco_clube = 99999.99
			End if
			
			//
			
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
		
			If Not This.of_insere_preco_pmc( ref ls_log ) Then
				lb_Sucesso	= False
				return false
			end if
			
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

on uo_ge473_preco_pmc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_preco_pmc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum


end event

event destructor;Destroy(io_Comum)

end event

