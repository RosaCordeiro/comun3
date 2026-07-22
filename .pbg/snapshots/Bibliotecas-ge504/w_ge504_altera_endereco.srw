HA$PBExportHeader$w_ge504_altera_endereco.srw
forward
global type w_ge504_altera_endereco from dc_w_response_ok_cancela
end type
end forward

global type w_ge504_altera_endereco from dc_w_response_ok_cancela
integer width = 2409
integer height = 1688
string title = "GE504 - Altera$$HEX2$$e700e300$$ENDHEX$$o de Endere$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge504_altera_endereco w_ge504_altera_endereco

type variables
Long il_Pedido
Long il_Filial_EC

datawindowchild idwc_transp

string is_datasource

dc_uo_transacao itr_filial
dc_uo_odbc	ivo_Odbc
end variables

forward prototypes
public function boolean wf_conecta_filial (long al_filial_destino)
end prototypes

public function boolean wf_conecta_filial (long al_filial_destino);String ls_Odbc_Destino

is_DataSource = gvo_Aplicacao.ivs_DataSource

itr_filial = create  dc_uo_transacao
ivo_Odbc = create  dc_uo_odbc
		 
itr_filial.of_SetDataBase('postgresql')

// Se estiver conectado desconecta
If itr_filial.of_isConnected() Then itr_filial.of_Disconnect()

ivo_Odbc.of_Atualiza_Odbcs( String(al_Filial_destino) )

ls_Odbc_Destino = ivo_Odbc.of_Localiza(al_Filial_destino)

itr_filial.of_Set_Erro_Saida_Padrao( 'LOG' )

If Not itr_filial.of_Connect( ls_Odbc_Destino, "EC504_" + gvo_Aplicacao.of_UserId( ) ) Then
	// Grava mensagem de erro no log e n$$HEX1$$e300$$ENDHEX$$o continua o processo
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "[ERRO] Conex$$HEX1$$e300$$ENDHEX$$o com a filial: " + String(al_Filial_Destino)  )
	Return False
End If

Return True
end function

on w_ge504_altera_endereco.create
call super::create
end on

on w_ge504_altera_endereco.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve( )
end event

event open;call super::open;String ls_Parametro

ls_Parametro = Message.StringParm

il_Filial_EC	= Long(MID( ls_Parametro, 1, 4 ))
il_Pedido 	= Long(MID( ls_Parametro, 5 ))


end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge504_altera_endereco
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge504_altera_endereco
integer width = 2331
integer height = 1564
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge504_altera_endereco
integer y = 56
integer width = 2281
integer height = 1344
string dataobject = "dw_ge504_altera_endereco"
end type

event dw_1::ue_recuperar;// OverRide
Return This.Retrieve( il_Pedido, il_Filial_EC )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge504_altera_endereco
integer x = 1367
integer y = 1428
integer width = 526
string text = "&Salvar"
end type

event cb_ok::clicked;call super::clicked;Long ll_Retorno, ll_cd_filial, ll_cd_cidade
string ls_nr_cep, ls_de_bairro, ls_cd_uf, ls_nr_endereco, ls_complemento, ls_id_situacao
string ls_nr_cep_novo, ls_de_bairro_novo, ls_cd_uf_novo, ls_nr_endereco_novo, ls_complemento_novo, ls_nr_autorizacao, ls_nr_comprovante
string ls_log, ls_msg
string ls_erro
string ls_operador, ls_chave, lvs_ValorPara
string ls_nr_pedido_loja
string ls_de_endereco, ls_de_endereco_novo
string ls_de_cidade, ls_de_cidade_novo
string ls_cidade_ibge
boolean lb_sucesso = false
boolean ib_PDV_Java = false

uo_ge501_pedido_ecommerce luo_pedido

luo_pedido = create uo_ge501_pedido_ecommerce

ls_erro = ''

Try
	
	dw_1.accepttext( )
	
	ls_chave = dw_1.object.nr_pedido_ecommerce[1]	
	
	ls_nr_cep = dw_1.object.nr_cep[1]	
	ls_cd_uf = dw_1.object.cd_uf[1]
	ls_de_bairro = dw_1.object.de_bairro[1]
	ls_nr_endereco = dw_1.object.nr_endereco[1]
	ls_complemento = dw_1.object.de_complemento[1]
	ls_id_situacao	= dw_1.object.id_situacao[1]
	ls_de_endereco = dw_1.object.de_endereco[1]
	ls_de_cidade = dw_1.object.de_cidade[1]
	
	ls_nr_cep_novo = dw_1.object.nr_cep_novo[1]
	ls_cd_uf_novo = dw_1.object.cd_uf_novo[1]
	ls_de_bairro_novo = dw_1.object.de_bairro_novo[1]
	ls_nr_endereco_novo = dw_1.object.nr_endereco_novo[1]
	ls_complemento_novo = dw_1.object.de_complemento_novo[1]
	ls_de_endereco_novo = dw_1.object.de_endereco_novo[1]
	ls_de_cidade_novo = dw_1.object.de_cidade_novo[1]
	
	ls_nr_autorizacao = dw_1.object.nr_autorizacao_cartao_credito[1]
	ls_nr_comprovante = dw_1.object.nr_comprovante_cartao_credito[1]
	
	ls_nr_pedido_loja = dw_1.object.nr_pedido_drogaexpress[1]
	ll_cd_filial = dw_1.object.cd_filial[1]

	if Trim(ls_nr_cep_novo) = '' or isnull(ls_nr_cep_novo) Then ls_nr_cep_novo = ls_nr_cep
	if Trim(ls_cd_uf_novo) = '' or isnull(ls_cd_uf_novo) Then ls_cd_uf_novo = ls_cd_uf
	if Trim(ls_de_bairro_novo) = '' or isnull(ls_de_bairro_novo) Then ls_de_bairro_novo = ls_de_bairro
	if Trim(ls_nr_endereco_novo) = '' or isnull(ls_nr_endereco_novo) Then ls_nr_endereco_novo = ls_nr_endereco
	if Trim(ls_complemento_novo) = '' or isnull(ls_complemento_novo) Then ls_complemento_novo = ls_complemento
	if Trim(ls_de_endereco_novo) = '' or isnull(ls_de_endereco_novo) Then ls_de_endereco_novo = ls_de_endereco
	if Trim(ls_de_cidade_novo) = '' or isnull(ls_de_cidade_novo) Then ls_de_cidade_novo = ls_de_cidade
	
	luo_pedido.is_bairro_ent = ls_de_bairro_novo
	luo_pedido.is_cep_ent = ls_nr_cep_novo
	luo_pedido.is_uf_ent = ls_cd_uf_novo
	luo_pedido.is_numero_ent = ls_nr_endereco_novo
	
	if Not luo_pedido.of_valida_endereco( ref ls_msg, ref ls_log ) Then
		if ls_log <> '' and not isnull(ls_log) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log )
		elseif ls_msg <> '' and not isnull(ls_msg) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg )
		end if
		
		return -1
	end if
	
	gf_retorna_cidade(ls_nr_cep_novo, ls_de_cidade_novo, ls_cd_uf_novo, ref ll_cd_cidade, ref ls_cidade_ibge, ref ls_log )	
	if ls_log <> '' and not isnull(ls_log) Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log )
		return -1
	end if
	
	//Se a situacao for endereco invalido, alterada para Aprovado.
	if ls_id_situacao = 'I' then
		ls_id_situacao = 'A'
	ENd if
	
	If Not gf_retorna_loja_pdv_novo(ll_cd_filial, ref ib_PDV_Java, ref ls_erro ) Then
		ls_erro = "Erro ao conferir se a filial $$HEX1$$e900$$ENDHEX$$ PDV Java " + ls_erro
		return -1
	End If
	
	If Not ib_PDV_Java Then
		//Atualiza na base da filial
		if Not wf_conecta_filial(ll_cd_filial) then 
			return -1
		end if
		
		update pedido_drogaexpress
					set nr_cep_entrega = :ls_nr_cep_novo,
						cd_uf_entrega = :ls_cd_uf_novo,
						de_complemento_endereco = :ls_complemento_novo,
						de_bairro_entrega = :ls_de_bairro_novo,
						nr_endereco_entrega = :ls_nr_endereco_novo,
						nm_cidade_entrega = :ls_de_cidade_novo,
						de_endereco_entrega = :ls_de_endereco_novo
			Where nr_pedido_ecommerce = :il_Pedido
			Using itr_filial;
		
		if itr_filial.sqlcode = -1 then
			ls_erro = 'Problemas ao atualizar a tabela "pedido_drogaexpress": ' + itr_filial.sqlerrtext
			gvo_Aplicacao.ivs_DataSource = is_DataSource 
			return -1
		end if
		
		itr_filial.of_commit( )
		
		If itr_filial.of_isConnected() Then itr_filial.of_Disconnect()
		
		gvo_Aplicacao.ivs_DataSource = is_DataSource 
	End If
	
	//Atualizar na base central
	Update pedido_ecommerce
	set nr_cep_ent = :ls_nr_cep_novo,
		de_bairro_ent = :ls_de_bairro_novo,
		cd_uf_ent = :ls_cd_uf_novo,
		nr_endereco_ent = :ls_nr_endereco_novo,
		de_complemento_ent = :ls_complemento_novo,
		id_situacao = :ls_id_situacao,
		de_endereco_ent = :ls_de_endereco_novo,
		de_cidade_ent = :ls_de_cidade_novo
	where nr_pedido = :il_Pedido
		and cd_filial_ecommerce = :il_Filial_EC;
	
	If sqlca.sqlcode = -1 then 
		ls_erro = 'Problemas ao atualizar a tabela "pedido_ecommerce": ' + sqlca.sqlerrtext
		return -1
	end if
	
	Update pedido_ecommerce_endereco
	set nr_cep = :ls_nr_cep_novo,
		de_bairro = :ls_de_bairro_novo,
		cd_uf = :ls_cd_uf_novo,
		nr_endereco = :ls_nr_endereco_novo,
		de_complemento = :ls_complemento_novo,
		de_endereco = :ls_de_endereco_novo,
		de_cidade = :ls_de_cidade_novo,
		cd_cidade = :ll_cd_cidade
	where nr_pedido = :il_Pedido
		and cd_filial_ecommerce = :il_Filial_EC
		and cd_tipo_endereco = 2;

	If sqlca.sqlcode = -1 then 
		ls_erro = 'Problemas ao atualizar a tabela "pedido_ecommerce_endereco": ' + sqlca.sqlerrtext
		return -1
	end if
	
	ls_Operador = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

	if ls_nr_cep <> ls_nr_cep_novo and not isnull(ls_nr_cep_novo) then
		 If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_ECOMMERCE', ls_Chave, 'NR_CEP', ls_nr_cep, ls_nr_cep_novo, ls_Operador, 'A', Ref ls_Erro, True) Then
			return -1
		End if
	end if
	
	if ls_cd_uf <> ls_cd_uf_novo and not isnull(ls_cd_uf_novo) then
		 If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_ECOMMERCE', ls_Chave, 'CD_UF', ls_cd_uf, ls_cd_uf_novo, ls_Operador, 'A', Ref ls_Erro, True) Then
			return -1
		End if
	end if
	
	if ls_de_bairro <> ls_de_bairro_novo and not isnull(ls_de_bairro_novo) then
		 If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_ECOMMERCE', ls_Chave, 'DE_BAIRRO', ls_de_bairro, ls_de_bairro_novo, ls_Operador, 'A', Ref ls_Erro, True) Then
			return -1
		End if
	end if
	
	if ls_nr_endereco <> ls_nr_endereco_novo and not isnull(ls_nr_endereco_novo) then
		 If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_ECOMMERCE', ls_Chave, 'NR_ENDERECO', ls_nr_endereco, ls_nr_endereco_novo, ls_Operador, 'A', Ref ls_Erro, True) Then
			return -1
		End if
	end if
	
	if ls_complemento <> ls_complemento_novo and not isnull(ls_complemento_novo) then
		 If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_ECOMMERCE', ls_Chave, 'DE_COMPLEMENTO', ls_complemento, ls_complemento_novo, ls_Operador, 'A', Ref ls_Erro, True) Then
			return -1
		End if
	end if
	
	if ls_de_endereco <> ls_de_endereco_novo and not isnull(ls_de_endereco_novo) then
		 If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_ECOMMERCE', ls_Chave, 'DE_ENDERECO', ls_de_endereco, ls_de_endereco_novo, ls_Operador, 'A', Ref ls_Erro, True) Then
			return -1
		End if
	end if
	
	if ls_de_cidade <> ls_de_cidade_novo and not isnull(ls_de_cidade_novo) then
		 If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_ECOMMERCE', ls_Chave, 'DE_CIDADE', ls_de_cidade, ls_de_cidade_novo, ls_Operador, 'A', Ref ls_Erro, True) Then
			return -1
		End if
	end if
	
	SQLCA.of_commit( )
	
	lb_sucesso = true
	
Finally
	
	if lb_sucesso = false Then
		SQLCA.of_rollback( )
		itr_filial.of_rollback( )
		
		if ls_erro <> '' and not isnull(ls_erro) then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',  ls_erro )
		End if
		
	ENd if
	
	Destroy(luo_pedido)
	if isvalid( itr_filial ) then destroy(itr_filial)
	if isvalid( ivo_Odbc ) then destroy(ivo_Odbc)
	
	if lb_sucesso = True then
		CloseWithReturn(Parent, 1)
	end if
	
End Try
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge504_altera_endereco
integer x = 1957
integer y = 1432
end type

event cb_cancelar::clicked;// OverRide
CloseWithReturn(Parent, -1)
end event

