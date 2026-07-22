HA$PBExportHeader$uo_ge501_marca.sru
forward
global type uo_ge501_marca from nonvisualobject
end type
end forward

global type uo_ge501_marca from nonvisualobject
end type
global uo_ge501_marca uo_ge501_marca

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/catalog/pvt/brand'
string is_tabela = 'MARCA_PRODUTO'
long il_cd_tipo = 1 //1 = Marca

end variables

forward prototypes
private function boolean of_busca_descricao (long pl_cd_marca, ref string ps_ds_marca, ref string ps_log)
private function string of_formata_descricao (long pl_tipo, string ps_ds_marca)
private function boolean of_monta_json (long pl_cd_marca, string ps_ds_marca, ref string ps_json, ref string ps_log)
private function boolean of_altera_marca_site (long pl_cd_marca, long pl_cd_filial, string ps_acao, ref string ps_log)
private function boolean of_verifica_existe_movimento (long pl_cd_marca, long pl_cd_filial, ref boolean pb_existe, ref string ps_log)
public function boolean of_processa_atualizacao_marca (string ps_rede_filial)
end prototypes

private function boolean of_busca_descricao (long pl_cd_marca, ref string ps_ds_marca, ref string ps_log);
Select	 de_marca
Into :ps_ds_marca
From marca_ecommerce
Where cd_marca = :pl_cd_marca;

Choose Case SqlCa.SqlCode
	Case -1
		ps_log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_descricao ' +  '~nProblemas ao consultar a tabela "marca_ecommerce": ~n' + sqlca.sqlerrtext
		Return False
	Case 100
		ps_log = 'A marca [' + string(pl_cd_marca) + '] n$$HEX1$$e300$$ENDHEX$$o foi encontrada na base de dados.'
		return false
End Choose

return true
end function

private function string of_formata_descricao (long pl_tipo, string ps_ds_marca);string ls_resultado

Choose Case pl_tipo
	Case 1
		ls_resultado = wordcap(ps_ds_marca)
	Case 2
		ls_resultado = wordcap(ps_ds_marca)
		ls_resultado = gf_replace(ls_resultado, ' ', '-', 0)
	Case 3
		ls_resultado = lower(ps_ds_marca)
End Choose

return ls_resultado
end function

private function boolean of_monta_json (long pl_cd_marca, string ps_ds_marca, ref string ps_json, ref string ps_log);
ps_json = '{ ' + &
				'"Id": ' + string(pl_cd_marca) +', ' + &
				'"Name": "' + this.of_formata_descricao(1,ps_ds_marca) + '", ' + &
				'"Text": "' + this.of_formata_descricao(1,ps_ds_marca) + '", ' + &
				'"Keywords": "' + this.of_formata_descricao(3,ps_ds_marca) + '", ' + &
				'"SiteTitle": "' + this.of_formata_descricao(1,ps_ds_marca) + '", ' + &
				'"Active": true, "MenuHome": true, "AdWordsRemarketingCode": "","LomadeeCampaignCode": "", "Score": null, ' + &
				'"LinkId": "' + this.of_formata_descricao(2,ps_ds_marca)  + '"' + & 
				' }'

return true
end function

private function boolean of_altera_marca_site (long pl_cd_marca, long pl_cd_filial, string ps_acao, ref string ps_log);DateTime ldt_data
String lvs_Mensagem

ldt_data = gf_Getserverdate()

If ps_acao = 'I' Then
	
	insert into marca_produto_ecommerce (cd_marca, cd_filial_ecommerce, dh_atualizacao_site, id_ecommerce) 
	  values (:pl_cd_marca, :pl_cd_filial, :ldt_data, :is_id_ecommerce);
	
	If sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_altera_marca_site ~n' + 'Problemas ao inserir registro na tabela "marca_produto_ecommerce": ~n' + sqlca.sqlerrtext
		return false
	end if
	
Elseif ps_acao = 'U' then
	
	update marca_produto_ecommerce 
	      set dh_atualizacao_site = :ldt_data 
	 where cd_marca = :pl_cd_marca
	 	 and cd_filial_ecommerce 	= :pl_cd_filial
		  and id_ecommerce = :is_id_ecommerce;
	
	If sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_altera_marca_site ~n' + 'Problemas ao atualizar registro na tabela "marca_produto_ecommerce": ~n' + sqlca.sqlerrtext
		return false
	end if
	
End If
	
Return True

end function

private function boolean of_verifica_existe_movimento (long pl_cd_marca, long pl_cd_filial, ref boolean pb_existe, ref string ps_log);Long ll_existe

Select count(*)
   Into :ll_existe
  From marca_produto_ecommerce
Where cd_marca =:pl_cd_marca
    And cd_filial_ecommerce =:pl_cd_filial
	and id_ecommerce = :is_id_ecommerce;
	
if SqlCa.SqlCode = -1 then
	ps_log =  is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_existe_movimento ' +  '~nProblemas ao consultar a tabela "marca_produto_ecommerce": ~n' + sqlca.sqlerrtext
	Return False
end if

if ll_existe = 0 or isnull(ll_existe) Then
	pb_existe = false
else
	pb_existe = true
end if

Return true

end function

public function boolean of_processa_atualizacao_marca (string ps_rede_filial);String ls_ds_marca
String ls_json
String ls_retorno
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao

long ll_linhas
Long ll_for
long ll_cd_marca
Long ll_cd_filial
Long ll_Seq_Log

boolean lb_existe_movimento
boolean lb_sucesso=false
datetime ldt_inicio, ldt_termino

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
	
	if not lds_dados.of_changedataobject( 'ds_ge501_marca_log' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_marca ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_marca_log'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_marca, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
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
		
		w_Aguarde.Title = "Atualizando MARCA no eCommerce - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		// Pega o c$$HEX1$$f300$$ENDHEX$$digo da marca
		ll_cd_marca = long(lds_dados.object.de_chave[ll_for])
		luo_comum_vtex.il_cd_marca = ll_cd_marca
		
		//Busca descri$$HEX2$$e700e300$$ENDHEX$$o da Marca
		If Not this.of_busca_descricao( ll_cd_marca, ref ls_ds_marca, ref ls_Log ) Then  return false
		luo_comum_vtex.is_de_marca = ls_ds_marca
		
//		ls_Log = 'ERRO MARCA'
//		return false

		//Monta o arquivo JSON
		if not this.of_monta_json( ll_cd_marca, ls_ds_marca, ref ls_json, ref ls_Log ) Then return false
		luo_comum_vtex.is_json = ls_json

		//Verifica se ser$$HEX1$$e100$$ENDHEX$$ uma Inclus$$HEX1$$e300$$ENDHEX$$o ou Altera$$HEX2$$e700e300$$ENDHEX$$o na VTEX.
		If not this.of_verifica_existe_movimento( ll_cd_marca, ll_cd_filial, ref lb_existe_movimento, ref ls_Log ) then return false
				
		if lb_existe_movimento Then //Altera$$HEX2$$e700e300$$ENDHEX$$o
			if not luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + string(ll_cd_marca), ref ls_retorno, ref ls_Log ) Then return false
		else //Inclusao
			if not luo_comum_vtex.of_post( ls_json, is_id_interface, ref ls_retorno, ref ls_Log ) Then return false
		end if
		
		//Se retornou erro apenas na interface da VTEX, grava log e passa para o proximo registro.
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Altera situacao para Processado
		If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'S', is_tabela, ll_cd_filial, String(ll_cd_marca), ref ls_Log ) Then return false
		
		if lb_existe_movimento Then
			if not this.of_altera_marca_site( ll_cd_marca, ll_cd_filial, 'U', ref ls_Log ) Then return false
		else
			if not this.of_altera_marca_site( ll_cd_marca, ll_cd_filial, 'I', ref ls_Log )	Then return false
		end if
		
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

on uo_ge501_marca.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_marca.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

