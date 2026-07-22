HA$PBExportHeader$uo_ge481_sap_pedido_cancelamento.sru
forward
global type uo_ge481_sap_pedido_cancelamento from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_sap_pedido_cancelamento from uo_ge481_subida_generica
end type
global uo_ge481_sap_pedido_cancelamento uo_ge481_sap_pedido_cancelamento

type variables
long il_nr_pedido
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">' + &
				 	 '<soapenv:Header/>' + &
					'<soapenv:Body>' + &
					'   <exp:MT_CancelarPedido_Request>'
							
is_Termino_XML	=	'</exp:MT_CancelarPedido_Request>' +&
							'</soapenv:Body>' +&
							'</soapenv:Envelope>'

is_DS = 'ds_ge481_pedido_distrib_cancel'
is_Objeto = this.classname( )
is_nome_arquivo = 'pedido_cancelamento_xml'
is_Parametro_URL = 'CD_URL_PEDIDO_CANCEL'
is_Tipo_Log_Exp = ''
is_Descricao_Tipo_Log = 'PEDIDO_CANCELAMENTO'
is_Nome_Interface = 'PEDIDO CANCELAMENTO'

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);pds_dados.of_appendwhere_subquery( ' pe.nr_pedido_sap = ' + String(pl_nr_atualizacao) , 1)

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);String ls_nr_pedido

ls_nr_pedido = String(pds_dados.object.nr_pedido[pl_linha])

//il_cd_filial = pds_dados.object.cd_filial[pl_linha]

ps_xml += '<dados>'
ps_xml += '<pedido>' + ls_nr_pedido + '</pedido>'
ps_xml += '</dados>'

return true
end function

protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log);long ll_nr_pedido_sap

il_nr_pedido = pds_itens.object.nr_pedido[pl_linha]
	
Select 1
into :pl_situacao_pendente
from pedido_empurrado
where nr_pedido_sap = :il_nr_pedido
and id_situacao = 'X'
and dh_cancelamento_sap is null;

If SqlCa.SqlCode = -1 Then
	ps_log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_situacao ~nErro ao consultar a tabela 'pedido_empurrado' : " + SqlCa.SqlerrText
	Return False
End If

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);string ls_nr_pedido, ls_item, ls_status, ls_msg
long ll_controle
boolean lb_gravou_erro=false

ll_controle = 1
	
ls_status = of_busca_valor(as_xml, '<tp_mensagem>', ref ll_controle)

if isnull(ls_status) or ls_status = '' Then
//	Exit
end if

if ls_status = 'E' Then //Erro
	
	ls_msg = of_busca_valor(as_xml, '<mensagem>', ref ll_controle)
	
	if Not this.of_atualiza_processado( il_nr_pedido, 'E', ls_msg, ref as_log) then return false
	
else
	if Not this.of_atualiza_processado( il_nr_pedido, 'P', '', ref as_log) then return false
End if

return true
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log);String ls_status

if ls_status = 'P' Then

	Update pedido_empurrado
		Set dh_cancelamento_sap = getdate()
	Where nr_pedido_sap =:il_nr_pedido
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_atualiza_processado ~nProblemas ao atualizar registro da tabela "pedido_empurrado" : ' + SqlCa.SqlerrText
		Return False
	End If

else
	
	Update pedido_empurrado
		Set id_exportacao_sap = 'E', 
			de_erro_envio_sap = :as_mensagem
	Where nr_pedido_sap =:il_nr_pedido
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_atualiza_processado ~nProblemas ao atualizar registro da tabela "pedido_empurrado" : ' + SqlCa.SqlerrText
		Return False
	End If
	
end if

return true
end function

on uo_ge481_sap_pedido_cancelamento.create
call super::create
end on

on uo_ge481_sap_pedido_cancelamento.destroy
call super::destroy
end on

