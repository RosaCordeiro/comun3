HA$PBExportHeader$uo_ge481_clientes_excluidos.sru
forward
global type uo_ge481_clientes_excluidos from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_clientes_excluidos from uo_ge481_subida_generica
integer ii_contador_xml = 1
boolean ib_usa_cabecalho = false
end type
global uo_ge481_clientes_excluidos uo_ge481_clientes_excluidos

type variables
string is_cpf_cliente
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">' + &
						'   <soapenv:Header/>'+ &
						'   <soapenv:Body>'+ &
					    '  <imp:MT_REQUEST_DADOS_LGPD>'
							
is_Termino_XML	=	'      </imp:MT_REQUEST_DADOS_LGPD>' + &
							'	</soapenv:Body>' + &
							'</soapenv:Envelope>'

is_DS = 'ds_ge481_clientes_excluidos'
is_Objeto = this.classname( )
is_nome_arquivo = 'clientes_excluidos_xml'
is_Parametro_URL = 'CD_URL_CLIENTES_EXCLUIDOS'
is_Tipo_Log_Exp = '155'
is_Descricao_Tipo_Log = 'CLIENTES_EXCLUIDOS'
is_Nome_Interface = 'CLIENTES EXCLUIDOS'

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);
is_cpf_cliente = ''

is_cpf_cliente = pds_dados.object.cd_chave[pl_linha]

ps_xml += '<CPF>' + is_cpf_cliente + '</CPF>'


return true

end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);string ls_retorno,  ls_mensagem
long ll_pos = 1

ls_retorno = this.of_busca_valor( as_xml, 'ELIMINADO', ref ll_pos )
ls_mensagem = this.of_busca_valor( as_xml, 'MSG', ref ll_pos )

if ls_retorno = 'X' Then
	
	Update cliente_exclusao
	set dh_envio_sap = getdate()
	where nr_cpf = :is_cpf_cliente;
	
	if sqlca.sqlcode = -1 then
		as_log = 'Problemas ao atualizar a tabela "cliente_exclusao": ' + sqlca.sqlerrtext
		return false
	end if
	
else
	
	as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel excluir o cliente ' + is_cpf_cliente + ': ' + ls_mensagem
	return false
	
end if

return true
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//

return true
end function

on uo_ge481_clientes_excluidos.create
call super::create
end on

on uo_ge481_clientes_excluidos.destroy
call super::destroy
end on

