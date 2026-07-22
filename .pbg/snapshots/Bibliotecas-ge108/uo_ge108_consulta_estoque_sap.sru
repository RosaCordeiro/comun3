HA$PBExportHeader$uo_ge108_consulta_estoque_sap.sru
forward
global type uo_ge108_consulta_estoque_sap from nonvisualobject
end type
end forward

global type uo_ge108_consulta_estoque_sap from nonvisualobject
end type
global uo_ge108_consulta_estoque_sap uo_ge108_consulta_estoque_sap

forward prototypes
public function string of_busca_valor (string ps_xml, string ps_tag, ref long pl_pos)
public function boolean of_processa_retorno_xml (string ps_xml_retorno, long pl_qt_estoque, ref string ps_log)
public function boolean of_consulta_estoque (long pl_cd_filial, long pl_cd_produto, string ps_url, ref long pl_qt_estoque, ref string ps_log)
end prototypes

public function string of_busca_valor (string ps_xml, string ps_tag, ref long pl_pos);string ls_retorno
string  ls_Xml_Aux
long ll_pos1, ll_pos2

ps_tag = gf_Replace(ps_tag, '/', '', 0)
ps_tag = gf_Replace(ps_tag, '<', '', 0)
ps_tag = gf_Replace(ps_tag, '>', '', 0)

ls_Xml_Aux = ps_xml

ll_pos1 = Pos(ls_Xml_Aux, '<'+ps_tag+'>', pl_pos)
ll_pos2 = Pos(ls_Xml_Aux, '</'+ps_tag+'>', pl_pos)

 ls_retorno = Mid(	ls_Xml_Aux,  ll_pos1 + LenA(ps_tag)+2, ll_pos2 - ( ll_pos1 + LenA(ps_tag)+2))

pl_pos = ll_pos2


return ls_retorno
end function

public function boolean of_processa_retorno_xml (string ps_xml_retorno, long pl_qt_estoque, ref string ps_log);string ls_quantidade
long ll_controle=1
long ll_qt_estoque

ls_quantidade = this.of_busca_valor( ps_xml_retorno, 'qtd_estoque', ll_controle)

ll_qt_estoque = dec(ls_quantidade)

if isnull(ll_qt_estoque) Then ll_qt_estoque = 0

pl_qt_estoque = ll_qt_estoque

return true
end function

public function boolean of_consulta_estoque (long pl_cd_filial, long pl_cd_produto, string ps_url, ref long pl_qt_estoque, ref string ps_log);string ls_xml, ls_xml_retorno
long ll_qt_estoque
uo_ge040_webservice_sap luo_envio

luo_envio = create uo_ge040_webservice_sap

ls_xml =  '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">' + &
			'   <soapenv:Header/>' + &
			'   <soapenv:Body>' + &
			'      <exp:MT_ConsultarEstoque_Request>' 
         
ls_xml += '<cd_centro>' + string(pl_cd_filial) + '</cd_centro>'
ls_xml += '<cd_material>' + string(pl_cd_produto) + '</cd_material>'
			
ls_xml += '</exp:MT_ConsultarEstoque_Request>' + &
				'   </soapenv:Body>' + &
				'</soapenv:Envelope>' 


//Buscar o endere$$HEX1$$e700$$ENDHEX$$o (URL) na matriz

if Not luo_envio.of_envia_webservice( ps_url, ls_xml, ref ls_xml_retorno, ref ps_log) Then
	Return false
end if

If Not this.of_processa_retorno_xml( ls_xml, ref ll_qt_estoque, ref ps_log ) then
	return false
end if

pl_qt_estoque = ll_qt_estoque

return true
end function

on uo_ge108_consulta_estoque_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge108_consulta_estoque_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

