HA$PBExportHeader$uo_ge501_filial.sru
forward
global type uo_ge501_filial from nonvisualobject
end type
end forward

global type uo_ge501_filial from nonvisualobject
end type
global uo_ge501_filial uo_ge501_filial

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/dataentities/SL/documents'
string is_tabela = 'FILIAL'
String is_Codigo_Filial_Vtex

long il_cd_tipo = 14 //1 = FILIAL
Long il_Filial

Boolean ib_Excluir_Cadastro
Boolean ib_Inclusao
end variables

forward prototypes
public function boolean of_processa_atualizacao_filial (string ps_rede_filial)
private function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_horario (string as_parametro, ref string as_horario_formatado, ref string ps_log)
end prototypes

public function boolean of_processa_atualizacao_filial (string ps_rede_filial);String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_json
String ls_retorno

long ll_linhas
Long ll_for
Long ll_cd_filial
Long ll_Seq_Log
boolean lb_sucesso=false

DateTime ldh_Data_Nula

dc_uo_ds_base lds_dados
uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	
	Open(w_Aguarde)

	luo_comum_vtex = create uo_ge501_comum
	lds_dados = create dc_uo_ds_base
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_Log ) Then return false
	
	if not lds_dados.of_changedataobject( 'ds_ge501_filial_log' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_marca ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_marca_log'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_filial, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If

	//Altera situacao para pendente
	If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'P', is_tabela, ll_cd_filial, '', ref ls_Log ) Then return false
	
	ll_linhas = lds_dados.retrieve( is_id_ecommerce, ll_cd_filial)
	
	if ll_linhas < 0 Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_marca ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_marca_log'
		return false
	end if

	If ll_Linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	ls_Situacao = 'P'
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_Aguarde.Title = "Atualizando FILIAL no eCommerce - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		// Pega o c$$HEX1$$f300$$ENDHEX$$digo da filial
		il_Filial = long(lds_dados.object.de_chave[ll_for])
		luo_comum_vtex.il_cd_filial_pedido = il_Filial
	
		//Monta o arquivo JSON
		if not this.of_monta_json(ref ls_json, ref ls_Log ) Then return false
		
		if ls_log <> '' and not isnull(ls_log) Then
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		luo_comum_vtex.is_json = ls_json

		luo_comum_vtex.is_url = luo_comum_vtex.is_url_master_data
		
		// Exclui o cadastro existente
		If ib_Excluir_Cadastro Then
			if not luo_comum_vtex.of_del(is_id_interface + '/' + is_Codigo_Filial_Vtex, ref ls_retorno, ref ls_Log ) Then return false
		Else
			// Inclui e/ou atualiza
			if not luo_comum_vtex.of_put( ls_json, is_id_interface, ref ls_retorno, ref ls_Log ) Then return false
			
			If ib_Inclusao Then
				
				ls_retorno = Mid(ls_retorno, 4)
				
				If Len(ls_retorno) > 40 Then
					ls_Log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_filial ' +  '~nID maior que o esperado.'
					Return False	
				End If
				
				//ID criado no masterdata
				update parametro_loja
				set vl_parametro = :ls_retorno
				where cd_filial = :il_Filial
				  and cd_parametro = 'CD_FILIAL_VTEX'
				 Using SqlCa;
				 
				 If SqlCa.SqlCode = - 1 Then
					ls_Log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_filial ' +  '~nProblemas na atualiza$$HEX2$$e700e300$$ENDHEX$$o da tabela "PARAMETRO_LOJA": ~n' + sqlca.sqlerrtext
					Return False
				 End If
				 
				 If Sqlca.SQLNRows <> 1 Then
					ls_Log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_filial ' +  '~nProblemas na atualiza$$HEX2$$e700e300$$ENDHEX$$o da tabela "PARAMETRO_LOJA" - n$$HEX1$$e300$$ENDHEX$$o houve atualiza$$HEX2$$e700e300$$ENDHEX$$o.'
					Return False
				 End If
			End If
		End If
		
		//Se retornou erro apenas na interface da VTEX, grava log e passa para o proximo registro.
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Altera situacao para Processado
		If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'S', is_tabela, ll_cd_filial, String(il_Filial), ref ls_Log ) Then return false
		
		//sqlca.of_Commit( )
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde.uo_progress.of_setprogress(ll_for)
		
	next
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	destroy(lds_dados)
	destroy(luo_comum_vtex)
	
	Close(w_Aguarde)
	
End try

return true
end function

private function boolean of_monta_json (ref string ps_json, ref string ps_log);String ls_Bairro
String ls_CEP
String ls_Cidade
String ls_Complemento
String ls_Endereco
String ls_Estado
String ls_Horario
String ls_latitude
String ls_Longetude
String ls_Nome_Fantasia
String ls_Numero
String ls_DDD
String ls_Telefone
String ls_Situacao 
String ls_Fone_Formatado
String ls_Transf
String ls_Horario_Formatado
String ls_situacao_ecommerce

Decimal ldc_Venda

ib_Excluir_Cadastro 	= False
ib_Inclusao 				= False

select f.de_bairro,
		 f.nr_cep,
		 c.nm_cidade,
		 f.de_complemento_endereco,
		 f.de_endereco,
		 u.nm_unidade_federacao,
		 '',
		 f.nr_latitude,
		 f.nr_longitude,
		 f.nm_fantasia,
		 f.nr_endereco,
		 coalesce(f.nr_ddd_telefone, ''), 
		 coalesce(f.nr_telefone, ''),
		 p.vl_parametro,
		 f.id_situacao,
		 (select sum(vl_venda_avista) from resumo_movimento_estoque
			where cd_filial = :il_Filial
  			    and dh_resumo >= (select dateadd(day, -10, dh_movimentacao) 
										   from parametro 
										   where id_parametro = '1')) vl_venda,
		coalesce(f.id_recebe_nf_transferencia, 'N') id_recebe_nf_transferencia,
		ef.id_situacao
Into 	:ls_Bairro,
		:ls_CEP,
		:ls_Cidade,
		:ls_Complemento,
		:ls_Endereco,
		:ls_Estado,
		:ls_Horario,
		:ls_latitude,
		:ls_Longetude,
		:ls_Nome_Fantasia,
		:ls_Numero,
		 :ls_DDD,
		:ls_Telefone,
		:is_Codigo_Filial_Vtex,
		:ls_Situacao,
		:ldc_Venda,
		:ls_Transf,
		:ls_situacao_ecommerce
from filial f
inner join cidade c
	on c.cd_cidade = f.cd_cidade
inner join unidade_federacao u
	on u.cd_unidade_federacao = c.cd_unidade_federacao
left outer join parametro_loja p
	on p.cd_filial = f.cd_filial
	and p.cd_parametro = 'CD_FILIAL_VTEX'
left outer join ecommerce_rede_filial ef on ef.cd_filial = f.cd_filial and ef.id_ecommerce = :is_id_ecommerce and ef.id_situacao = 'A'
where f.cd_filial = :il_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		ps_log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_mota_json ' +  '~nProblemas ao consultar a tabela "filial": ~n' + sqlca.sqlerrtext
		Return False
	Case 100
		ps_log = 'A filial [' + string(il_Filial) + '] n$$HEX1$$e300$$ENDHEX$$o foi encontrada na base de dados.'
		return false
End Choose

if ls_situacao_ecommerce = '' or isnull(ls_situacao_ecommerce) or ls_situacao_ecommerce = 'I' Then
	ps_log = 'A filial [' + string(il_Filial) + '] est$$HEX1$$e100$$ENDHEX$$ inativa para o Ecommerce.'
	return True
end if

ls_Cidade			= wordcap(ls_Cidade) 
ls_Estado			= wordcap(ls_Estado) 
ls_Endereco			= wordcap(ls_Endereco)
ls_Nome_Fantasia	= wordcap(ls_Nome_Fantasia)
ls_Bairro				= wordcap(ls_Bairro)

If Not of_horario('DE_HORARIO_1', ref ls_Horario_Formatado, ref ps_log) Then Return False
If Trim(ls_Horario_Formatado) <> '' Then ls_Horario = ls_Horario_Formatado

If Not of_horario('DE_HORARIO_2', ref ls_Horario_Formatado, ref ps_log) Then Return False
If Trim(ls_Horario_Formatado) <> '' Then ls_Horario += ',' + ls_Horario_Formatado

If Not of_horario('DE_HORARIO_3', ref ls_Horario_Formatado, ref ps_log) Then Return False
If Trim(ls_Horario_Formatado) <> '' Then ls_Horario += ',' + ls_Horario_Formatado

If Not of_horario('DE_HORARIO_4', ref ls_Horario_Formatado, ref ps_log) Then Return False
If Trim(ls_Horario_Formatado) <> '' Then ls_Horario += ',' + ls_Horario_Formatado

If Not of_horario('DE_HORARIO_5', ref ls_Horario_Formatado, ref ps_log) Then Return False
If Trim(ls_Horario_Formatado) <> '' Then ls_Horario += ',' + ls_Horario_Formatado

If Trim(ls_DDD) <> '' Then
	ls_Fone_Formatado = '(' + ls_DDD + ') '
End If

If Trim(ls_Telefone) <> '' Then
	ls_Fone_Formatado += ls_Telefone
Else
	ls_Fone_Formatado = ''
End If

ls_Complemento 	= iif(Isnull(ls_Complemento), '', ls_Complemento)
ls_Horario 			= iif(Isnull(ls_Horario), '', ls_Horario)
ls_latitude 			= iif(Isnull(ls_latitude), '', ls_latitude)
ls_Longetude 		= iif(Isnull(ls_Longetude), '', ls_Longetude)
ls_Numero 			= iif(Isnull(ls_Numero), '', ls_Numero)

// Se a loja n$$HEX1$$e300$$ENDHEX$$o tiver l$$HEX1$$e100$$ENDHEX$$ faz o cadastro, caso contr$$HEX1$$e100$$ENDHEX$$rio atualiza
If Len(is_Codigo_Filial_Vtex) < 36 or IsNull(is_Codigo_Filial_Vtex) Then
	// Recebe transfer$$HEX1$$ea00$$ENDHEX$$ncia e teve pelo menos 500,00 de venda nos ultimos 10 dias
	If ls_Transf = 'S' and ldc_Venda >= 500.00 Then
		ib_Inclusao 	= True
		ps_json 		= '{'
	End If
Else
	
	If ls_Situacao = 'I' or ls_Transf = 'N' or ldc_Venda < 500.00 Then
		ib_Excluir_Cadastro = True
		Return True
	End If
	
	ps_json = '{' + &
				 '"id": "' + is_Codigo_Filial_Vtex + '",'
End If

ps_json += '"bairro": "' + ls_Bairro + '",' + &
       			'"cep": "' + ls_CEP + '",' + &
        			'"cidade": "' + ls_Cidade + '",' + &
        			'"complemento": null,'+ &
        			'"endereco": "' + ls_Endereco + '",' + &
			  	'"estado": "' + ls_Estado + '",' + &
			  	'"horario": "' + ls_Horario + '",' + &
			  	'"latitude": "' +ls_latitude + '",' + &
			 	'"longitude": "' + ls_Longetude + '",' + &
			  	'"nome": "' + ls_Nome_Fantasia + '",' + &
			  	'"numero": "' + ls_Numero + '",' + &
			  	'"telefone": "' + ls_Fone_Formatado + '"}'
				  
If IsNull(ps_json) or Trim(ps_json) = '' Then
	ps_log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_mota_json ' +  '~nJson nulo ou vazio.'
	return false
End If

return true
end function

public function boolean of_horario (string as_parametro, ref string as_horario_formatado, ref string ps_log);String ls_Parametro

select vl_parametro
Into 	:ls_Parametro
from parametro_loja
where cd_filial = :il_Filial
	and cd_parametro = :as_parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_horario_formatado = gf_Horario_Filial(ls_Parametro)
	Case 100
		as_horario_formatado = ''
	Case -1
		ps_log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_mota_json ' +  '~nProblemas ao consultar a tabela "parametro_loja": ~n' + sqlca.sqlerrtext
		Return False
End Choose

Return True
end function

on uo_ge501_filial.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_filial.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

