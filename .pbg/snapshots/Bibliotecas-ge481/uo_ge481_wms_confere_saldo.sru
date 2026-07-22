HA$PBExportHeader$uo_ge481_wms_confere_saldo.sru
forward
global type uo_ge481_wms_confere_saldo from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_confere_saldo from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long	il_Integracao
Long	 il_cd_produto
String is_Deposito
String is_Material
String is_Somente_Com_Saldo

Long		il_cd_filiais[]
Long		il_cd_produtos[]

dc_uo_ds_base ids_saldo_legado
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos)
public function boolean of_insere_integracao_wmp_sap_detalhe (string as_deposito, long al_filial, long al_produto, ref string as_erro)
public function boolean of_busca_saldo_produto_legado (ref string as_log)
public function boolean of_busca_produtos_filiais_legado (ref st_valida_saldo ast_valida_saldo, ref string as_log)
public function boolean of_grava_integracao_wmp_sap_detalhe (string as_material, string as_saldo, string as_deposito, string as_mensagem, long al_produto_legado, long al_sequencial, ref string as_erro)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">' +& 
						'<soapenv:Header/>' +& 
						'<soapenv:Body>' +& 
						'<exp:MT_CONSULTAR_ESTOQUE_OUT>'  

is_Termino_XML	=	'</exp:MT_CONSULTAR_ESTOQUE_OUT>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_wms_confere_saldo'
is_Objeto = this.classname( )
is_nome_arquivo = 'wms_confere_saldo_xml'
is_Parametro_URL = 'CD_URL_WMS_CONFERE_SALDO'
is_Tipo_Log_Exp = 'WMS_CONFERE_SALDO'
is_Descricao_Tipo_Log = 'WMS_CONFERE_SALDO'
is_Nome_Interface = 'WMS_CONFERE_SALDO'

//Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' ")
end if

//io_sap_comum.is_usuario = 'GRC_INTEGRACAO'
//io_sap_comum.is_senha = 'Grc_1nt3gNfe'
//io_sap_comum.is_usuario = 'Matavares'
//io_sap_comum.is_senha = 'Abap@001'
//io_sap_comum.is_usuario	= 'PO_INTEGRACAO'
//io_sap_comum.is_senha = 'P0_INTEGRACAO$'

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);//override
string ls_centro

ls_centro					= pds_dados.GetItemString(pl_linha,"centro")
is_deposito					= pds_dados.GetItemString(pl_linha,"deposito")
is_material					= pds_dados.GetItemString(pl_linha,"material")
is_somente_com_saldo		= pds_dados.GetItemString(pl_linha,"somente_com_saldo")
il_Integracao				= Long(pds_dados.GetItemString(pl_linha,"cd_chave"))
il_cd_produto				= pds_dados.GetItemNumber(pl_linha,"cd_produto")

If ls_centro = '' or isnull(ls_centro) Then
	ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do centro {centro} n$$HEX1$$e300$$ENDHEX$$o informado.'
	Return False
end if

If IsNull(is_deposito) Then is_deposito = ''
If IsNull(is_material) Then is_material = ''
If ( IsNull(is_somente_com_saldo) Or is_somente_com_saldo <> 'S' ) Then is_somente_com_saldo = ''

ps_xml += 	'<ENTRADA>'+&
				'<CENTRO>'+ls_centro+'</CENTRO>'+&
				'<MATERIAL>'+is_material+'</MATERIAL>'+&
				'<DEPOSITO>'+is_deposito+'</DEPOSITO>'+&
				'<SOMENTE_COM_SALDO>'+is_somente_com_saldo+'</SOMENTE_COM_SALDO>'+&
				'</ENTRADA>'

Return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
long ll_contador_aux = 1
long ll_sequencial = 0
long ll_filial
long ll_cd_produto
long ll_for
long ll_produto_legado
long ll_for_objeto
string ls_saida
string ls_material
string ls_saldo
string ls_deposito
string ls_mensagem
boolean lb_sucesso = true

st_valida_saldo lst_valida_saldo[]
uo_ge481_valida_saldo luo_ge481_valida_saldo

luo_ge481_valida_saldo = Create uo_ge481_valida_saldo

If Not luo_ge481_valida_saldo.of_read_xml(as_xml, ref  lst_valida_saldo ) Then
	Return False
End If

for ll_for_objeto = 1 to UpperBound(lst_valida_saldo)
	//Busca produto legado
	If Not of_busca_produtos_filiais_legado( lst_valida_saldo[ll_for_objeto], ref as_log) Then
		Return False
	End If
	
	ids_saldo_legado = Create dc_uo_ds_base
	
	If Not of_busca_saldo_produto_legado(ref as_log) Then
		Return False
	End If

	for ll_for = 1 to UpperBound(lst_valida_saldo[ll_for_objeto].saida)
		ls_material			= lst_valida_saldo[ll_for_objeto].saida[ll_for].material
		ls_saldo				= lst_valida_saldo[ll_for_objeto].saida[ll_for].saldo
		ls_deposito			= lst_valida_saldo[ll_for_objeto].saida[ll_for].deposito
		ls_mensagem			= lst_valida_saldo[ll_for_objeto].saida[ll_for].mensagem
		ll_produto_legado	= lst_valida_saldo[ll_for_objeto].saida[ll_for].produto_legado
		
		if Upper(ls_mensagem)	= 'OK' then SetNull(ls_mensagem)
		
		ll_sequencial++
		
		If Not of_grava_integracao_wmp_sap_detalhe( ls_material, ls_saldo, ls_deposito, ls_mensagem, ll_produto_legado, ll_sequencial, ref as_log) Then
			lb_sucesso = False
		End If
	next
next

If lb_sucesso Then	
	If IsNull(is_deposito) or is_deposito = '' Then
		ll_filial = 534
		ls_deposito = '0001'
		If of_insere_integracao_wmp_sap_detalhe( ls_deposito, ll_filial, ll_cd_produto, ref as_log) Then
			ll_filial = 1
			ls_deposito = '0002'
			If Not of_insere_integracao_wmp_sap_detalhe( ls_deposito, ll_filial, ll_cd_produto, ref as_log) Then
				lb_sucesso = false
			End If
		Else
			lb_sucesso = false
		End If
		
	Else
		Choose Case is_deposito 
			Case '0001' 
				ll_filial = 534
			Case '0002'
				ll_filial = 1
			Case Else
				lb_sucesso = false
				as_log = "Dep$$HEX1$$f300$$ENDHEX$$sito {"+is_deposito+"} n$$HEX1$$e300$$ENDHEX$$o cadastrado." 
		End Choose
		
		If lb_sucesso Then
			If Not of_insere_integracao_wmp_sap_detalhe( is_deposito, ll_filial, ll_cd_produto,ref as_log) Then
				lb_sucesso = false
			End If
		End If
	End If
End If

If lb_sucesso Then
	Update wms_int_sap 
	Set id_situacao = 'I', dh_envio_sap = GetDate()
	Where nr_integracao = :il_Integracao
	Using SQLCA;
	
	If SqlCa.SqlCode = -1 Then
		as_log = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o e data de envio na {wms_int_sap} '_of_processa_retorno_xml': " + SqlCa.SqlerrText
		Return False
	End If
Else
	as_log = Left(as_log,250)
	Update wms_int_sap 
	Set id_situacao = 'E', dh_envio_sap = GetDate(), de_erro = :as_log
	Where nr_integracao = :il_Integracao
	Using SQLCA;
	
	If SqlCa.SqlCode = -1 Then
		as_log = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o e data de envio na {wms_int_sap} '_of_processa_retorno_xml': " + SqlCa.SqlerrText
		Return False
	End If
	
End If
	

Return lb_sucesso
end function

public function string of_busca_valor (string as_xml, string as_tag, ref long al_pos);//override
string ls_retorno
string  ls_Xml_Aux
long ll_pos1, ll_pos2

as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '<', '', 0)
as_Tag = gf_Replace(as_Tag, '>', '', 0)

ls_Xml_Aux = as_xml

ll_pos1 = Pos(ls_Xml_Aux, '<'+as_tag+'>', al_pos)
If ll_pos1 > 0 Then
	ll_pos2 = Pos(ls_Xml_Aux, '</'+as_tag+'>', ll_pos1)
	
	ls_retorno = Mid(	ls_Xml_Aux,  ll_pos1 + LenA(as_tag)+2, ll_pos2 - ( ll_pos1 + LenA(as_tag)+2))
	
	al_pos = ll_pos2
Else
	ls_retorno = ''
End If

return ls_retorno
end function

public function boolean of_insere_integracao_wmp_sap_detalhe (string as_deposito, long al_filial, long al_produto, ref string as_erro);Long		ll_Linha, &
			ll_Total, &
			ll_cd_produto, &
			ll_nr_sequencial, &
			ll_qt_saldo_final
String	ls_todos_produtos

dc_uo_ds_base lds_saldo_legado


Try		
	lds_saldo_legado = Create dc_uo_ds_base
	
	If Not lds_saldo_legado.of_ChangeDataObject("ds_ge481_wms_confere_saldo_legado", False) Then
		as_erro = "Erro ao alterar a DW 'ds_ge481_wms_confere_saldo_legado'" 
		Return False
	End If
	
	if il_cd_produto = 0 or IsNull(il_cd_produto) then 
		ls_todos_produtos = 'S'
	else
		ls_todos_produtos = 'N'
	end if
	
	ll_total = lds_saldo_legado.Retrieve( al_filial, il_Integracao, il_cd_produto, as_deposito, ls_todos_produtos)
	
	for ll_linha = 1 to ll_total		
		if ll_linha = 1 then 
			select coalesce(max(nr_sequencial),0) 
			  into :ll_nr_sequencial
			  from wms_int_sap_detalhe
			 where nr_integracao = :il_Integracao;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro	= "Erro ao buscar o sequencial da tabela {wms_int_sap_detalhe}. Erro: "+SqlCa.SqlErrText
				Return False
			End If
		end if
		
		ll_cd_produto		= lds_saldo_legado.getitemnumber( ll_linha, "cd_produto")
		ll_qt_saldo_final	= lds_saldo_legado.getitemnumber( ll_linha, "qt_saldo_final")
		
		if ll_qt_saldo_final = 0 and is_somente_com_saldo = 'S' then continue
		
		ll_nr_sequencial++
	
		insert into wms_int_sap_detalhe ( nr_integracao, &
													nr_sequencial, &
													cd_produto, &
													qt_lote, &
													cd_deposito_sap_entrada, &
													cd_produto_sap, &
													qt_saldo_legado ) 
		values (	:il_Integracao, &
					:ll_nr_sequencial, &
					:ll_cd_produto, &
					null, &
					:as_deposito, &
					null, &
					:ll_qt_saldo_final )
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro	= "Erro ao inserir registros de produtos com saldo no legado tabela {wms_int_sap_detalhe}. Erro: "+SqlCa.SqlErrText
			Return False
		End If
		
	Next

Finally
	Destroy(lds_saldo_legado)
End Try

Return True

end function

public function boolean of_busca_saldo_produto_legado (ref string as_log);If Not ids_saldo_legado.of_ChangeDataObject("ds_ge481_wms_saldo_produtos", False) Then
	as_log = "Erro ao alterar a DW 'ds_ge481_wms_saldo_produtos'" 
	Return False
End If

ids_saldo_legado.Retrieve(il_cd_filiais, il_cd_produtos)

return true
end function

public function boolean of_busca_produtos_filiais_legado (ref st_valida_saldo ast_valida_saldo, ref string as_log);Long		ll_for
Long		ll_cd_filial
Long		ll_cd_produto
Long		ll_retorno
String	ls_deposito
String	ls_material

uo_ge040_array	luo_ge040_array


for ll_for = 1 to UpperBound(ast_valida_saldo.saida)
	ls_material	= ast_valida_saldo.saida[ll_for].material
	ls_deposito	= ast_valida_saldo.saida[ll_for].deposito
	
	if ls_deposito = '0001' then
		ll_cd_filial = 534
	elseif ls_deposito = '0002' then
		ll_cd_filial = 1
	else
		ll_cd_filial = 0
	end if
	
	ll_retorno = luo_ge040_array.uo_find(il_cd_filiais, ll_cd_filial)
	
	if ll_retorno = 0 then
		il_cd_filiais[UpperBound(il_cd_filiais) + 1]	= ll_cd_filial
	end if
	
	SetNull(ll_cd_produto)
	
	Select cd_produto
	  Into :ll_cd_produto 
	  From produto_geral
	 Where cd_produto_sap = :ls_material
	  Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log = "Erro ao buscar o c$$HEX1$$f300$$ENDHEX$$digo do produto no legado {produto_geral} " + SqlCa.SqlerrText
		Return False
	End If
	
	if IsNull(ll_cd_produto) then ll_cd_produto = 0
	
	ll_retorno = luo_ge040_array.uo_find(il_cd_produtos, ll_cd_produto)
	
	if ll_retorno = 0 then
		il_cd_produtos[UpperBound(il_cd_produtos) + 1]	= ll_cd_produto
	end if
	
	ast_valida_saldo.saida[ll_for].produto_legado	= ll_cd_produto
next

return true
end function

public function boolean of_grava_integracao_wmp_sap_detalhe (string as_material, string as_saldo, string as_deposito, string as_mensagem, long al_produto_legado, long al_sequencial, ref string as_erro);Long	ll_nr_integracao, &
		ll_qt_saldo_legado, &
		ll_qt_lote, &
		ll_cd_filial, &
		ll_find

ll_qt_lote = Long(gf_replace(as_saldo,'.',',',0))

Choose Case as_deposito
	Case "0001"
		ll_cd_filial = 534
	Case "0002"
		ll_cd_filial = 1
	Case Else
		ll_cd_filial = -1
End Choose

ll_find	= ids_saldo_legado.Find("cd_produto	= " + String(al_produto_legado) + " and cd_filial = " + String(ll_cd_filial), 0, ids_saldo_legado.RowCount())

if ll_find > 0 then
	ll_qt_saldo_legado	= ids_saldo_legado.GetItemNumber(ll_find, 'qt_saldo_final')
else
	ll_qt_saldo_legado	= 0
end if

//Grava wms_int_sap
INSERT INTO wms_int_sap_detalhe
            (nr_integracao,
             nr_sequencial,
             cd_produto_sap,
             cd_produto,
             cd_deposito_sap_entrada,
             qt_lote,
             de_erro,
				 qt_saldo_legado)
VALUES  (:il_Integracao,
			:al_sequencial,
		   :as_material,
			:al_produto_legado,
			:as_deposito,
			:ll_qt_lote,
			:as_mensagem,
			:ll_qt_saldo_legado) 
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro	= "Erro ao gravar na tabela {wms_int_sap_detalhe}. Erro: "+SqlCa.SqlErrText
	Return False
End If

Return True

end function

on uo_ge481_wms_confere_saldo.create
call super::create
end on

on uo_ge481_wms_confere_saldo.destroy
call super::destroy
end on

