HA$PBExportHeader$uo_ge501_pedido_devolucao.sru
forward
global type uo_ge501_pedido_devolucao from nonvisualobject
end type
end forward

global type uo_ge501_pedido_devolucao from nonvisualobject
end type
global uo_ge501_pedido_devolucao uo_ge501_pedido_devolucao

type variables
string is_datasource

string is_objeto
string is_id_ecommerce = '2' //VTEX

string is_id_interface = 'api/oms/pvt/orders/'
string is_rede_filial

string is_time
string is_valor
string is_especie_nf
string is_serie_nf
string is_origem_nf

long il_cd_tipo = 20
long il_cd_filial
long il_filial_nf

decimal idc_Valor_NF

long il_Nota



dc_uo_ds_base ids_pedidos




end variables

forward prototypes
public function boolean of_processa_devolucao_pedido (string ps_rede_filial)
public function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_entrega_cancelamento (long pl_cd_filial, long pl_nr_pedido, string ps_id_pedido, ref string ps_log)
end prototypes

public function boolean of_processa_devolucao_pedido (string ps_rede_filial);DateTime ldt_Emissao

String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_retorno
String ls_Json
String ls_Situacao
String ls_Interface
String ls_Pedido_Ecommerce
String ls_id_pedido_entrega
String ls_id_tipo_entrega
String ls_id_registro_log

Long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_Filial_Site
Long ll_Filial
Long ll_Filial_Ecommerce
Long ll_Pedido_ERP

boolean lb_sucesso=false

DateTime ldh_Data_Nula
Datetime ldh_log_inicio

uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	Open(w_ge501_Aguarde)
	
	w_Ge501_Aguarde.Title = "Vtex - Devolu$$HEX2$$e700e300$$ENDHEX$$o Pedido"

	luo_comum_vtex = create uo_ge501_comum
	ids_pedidos = create dc_uo_ds_base
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref il_cd_filial, ref ls_Log ) Then return false
	
	setnull(ls_id_registro_log)
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	if not ids_pedidos.of_changedataobject( 'ds_ge501_pedido_devolucao' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_devolucao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_status_rastreio'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_devolucao_pedido, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If

	ll_linhas = ids_pedidos.retrieve( ps_rede_filial )

	if ll_linhas < 0 Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_devolucao_pedido ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_pedido_status Erro: ' + sqlca.is_lasterrortext
		return false
	end if

	If ll_Linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(il_cd_filial, il_cd_Tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_log = ''

		luo_comum_vtex.of_limpa_variaveis( )
		
		ll_Pedido_ERP					= ids_pedidos.object.nr_pedido					[ll_for]
		ls_Pedido_Ecommerce 		= ids_pedidos.object.nr_pedido_ecommerce	[ll_for]
		ll_Filial	 						= ids_pedidos.Object.cd_filial						[ll_for]
		ll_Filial_Ecommerce 			= ids_pedidos.Object.cd_filial_ecommerce		[ll_for]
		idc_Valor_NF	 				= ids_pedidos.Object.vl_total_nf					[ll_for]
		ldt_Emissao						= ids_pedidos.Object.dh_emissao 					[ll_for]
		
		il_filial_nf						= ids_pedidos.Object.cd_filial_nf 					[ll_for]
		il_Nota							= ids_pedidos.Object.nr_nf							[ll_for]
		is_especie_nf					= ids_pedidos.Object.de_especie 					[ll_for]
		is_serie_nf						= ids_pedidos.Object.de_serie	 					[ll_for]
		is_origem_nf					= ids_pedidos.Object.id_origem_nf				[ll_for]
			
		ls_id_pedido_entrega			= ids_pedidos.Object.id_pedido_equilibrium		[ll_for]
		ls_id_tipo_entrega				= ids_pedidos.Object.id_tipo_entrega				[ll_for]
			
		w_Ge501_Aguarde.Title = "Vtex - Devolu$$HEX2$$e700e300$$ENDHEX$$o Pedido - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = 'Pedido: ' + ls_Pedido_Ecommerce
		
//		If ls_Pedido_Ecommerce <> '1067842519239-01' Then
//			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
//			Continue
//		End If

		
		If ll_Filial = 454 Then
			ll_Filial_Site = ll_Filial_Ecommerce
		Else
			ll_Filial_Site = ll_Filial
		End If
								
		//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
		if Not luo_comum_vtex.of_parametros_ecommerce_filial(ll_Filial_Site, ps_rede_filial, is_id_ecommerce, ref ls_log ) Then return false
		
		// "2019-02-07T02:00:00.000Z",
		is_time =  Mid(String(ldt_Emissao,'yyyy-mm-dd hh:mm:ss'), 1, 10)  + 'T' + Mid(String(ldt_Emissao,'yyyy-mm-dd hh:mm:ss'), 12, 8) + '.000Z'
		
		If Not This.of_monta_json(ls_Json, ref ls_Log) Then
			luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			If Not gf_ge501_RollBack(SQLCA) Then Return False
			Continue
		End If
								
		luo_comum_vtex.is_nr_pedido_ecommerce = ls_Pedido_Ecommerce
		luo_comum_vtex.il_cd_filial_pedido 			= ll_Filial_Site
		luo_comum_vtex.is_json 						= ls_Json
				
		//Envia os dados para o site.
		luo_comum_vtex.of_post( ls_json, is_id_interface + iif(ps_rede_filial = 'FA', '', 'SLR-') + ls_Pedido_Ecommerce + '/invoice' , ref ls_retorno, ref ls_log ) 
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			If Not gf_ge501_RollBack(SQLCA) Then Return False
			Continue
		end if
		
		//Cancela a entrega do pedido - Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium
		if ls_id_tipo_entrega = 'EXP' or ls_id_tipo_entrega = 'ECM' Then
			
			this.of_entrega_cancelamento(ll_filial_ecommerce, ll_Pedido_ERP, ls_id_pedido_entrega, ref ls_log )
			
			If ls_Log <> '' and not isnull(ls_Log) Then
				luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				If Not gf_ge501_RollBack(SQLCA) Then Return False
				Continue
			end if
			
		end if
				
		Update pedido_ecommerce_auxiliar 
		set 	dh_devolucao = getdate()
		where cd_filial_ecommerce = :ll_Filial_Ecommerce
			and nr_pedido				= :ll_Pedido_ERP
		Using SqlCa;

		If SqlCa.SqlCode = -1 Then
			ls_log = 	'Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido": ~n' + SqlCa.sqlerrtext
			Return False
		End If
						
		If Not gf_ge501_commit(SQLCA) Then Return False
				
		if Not luo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
		
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_Situacao = 'E'
		
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )	
		
	destroy(ids_pedidos)
	destroy(luo_comum_vtex)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

public function boolean of_monta_json (ref string ps_json, ref string ps_log);//	ps_json = '{"type":"Input",' +&
//					  '"issuanceDate":"' + is_time +  '",' +&
//					  '"invoiceNumber":"' + String(il_Nota) +'",' +&
//					  '"invoiceValue":"' + is_valor + '"}'		

Decimal	ldc_Valor
Decimal	ldc_Total
Decimal ldc_Frete

Long ll_Linhas
Long ll_Linha
Long ll_Qtde
Long ll_Produto

String ls_Itens
String ls_SKU

dc_uo_ds_base lds 

try
	lds = create dc_uo_ds_base
	
	if not lds.of_changedataobject( 'ds_ge501_pedido_devolucao_nfd_item' , false) Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_monta_json ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_devolucao_nfd_item'
		return false
	end if
	
	ll_Linhas = lds.Retrieve(il_filial_nf, il_Nota, is_especie_nf, is_serie_nf, is_origem_nf)
	
	If ll_Linhas > 0 Then
		
		ps_json = '{"type":"Input",' +&
					  '"issuanceDate":"' + is_time +  '",' +&
					  '"invoiceNumber":"' + String(il_Nota) +'",' 
		
		ls_Itens =   '"items": ['
		
		For ll_Linha = 1 to ll_Linhas
			
			ls_SKU 		= lds.Object.cd_sku			[ll_Linha]
			ll_Qtde 		= lds.Object.qt_devolvida	[ll_Linha]
			ldc_Valor		= lds.Object.vl_preco			[ll_Linha]
			ll_Produto	= lds.Object.cd_produto		[ll_Linha]
			
			If ldc_Valor = 0.01 Then
				ldc_Valor = 0.00
				idc_Valor_NF = idc_Valor_NF - (0.01 * ll_Qtde)
			End If
									
			ldc_Total += Round(ll_Qtde * ldc_Valor, 2)
			
			If ll_Produto <> 712055 Then
				
				ls_Itens += '{' +&
								'"id": "' + ls_SKU +  '",'+&
								'"quantity": ' + String(ll_Qtde) + ','+&
								'"price": '+ gf_replace(String(ldc_Valor), ',', '', 0 ) + &
								'},'
			End If			
			
		Next
		
		If idc_Valor_NF <> ldc_Total Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_monta_json ~n' + 'O total dos itens calculados esta diferente do valor da devolu$$HEX2$$e700e300$$ENDHEX$$o'
			return false
		End If
		
		is_valor = gf_replace(String(idc_Valor_NF), ',', '', 0 )
		
		ls_Itens += ' ],'
		
		// Retira a ultima virgula
		ls_Itens = gf_Replace(ls_Itens, '}, ]', '} ]', 0)
		
		ps_json += 	ls_Itens +&
						'"invoiceValue": ' + is_valor + '}'
		
	ElseIf ll_Linhas = 0 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_monta_json ~n' + 'Nenhum produto foi encontrado na NFD'
		return false
	Else	
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_monta_json ~n' + 'Erro ao recuperar os dados da datawindow: ds_ge501_pedido_devolucao_nfd_item. Erro:' + lds.ivo_dbError.ivs_SqlErrText
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_json'. Erro: "+lo_rte.GetMessage( )
	Return False			
	
finally
	Destroy lds
end try

Return True

//{
//   "type": "Output",
//   "invoiceNumber": "NFe-00001",
//   "courier": "",
//   "trackingNumber": "",
//   "trackingUrl": "",
//   "items": [
//      {
//         "id": "345117",
//         "quantity": 1,
//         "price": 9003
//      }
//   ],
//   "issuanceDate": "2013-11-21T00:00:00",
//   "invoiceValue": 9508
//}
end function

public function boolean of_entrega_cancelamento (long pl_cd_filial, long pl_nr_pedido, string ps_id_pedido, ref string ps_log);string ls_status

uo_ge509_cancelamento luo_cancel
uo_ge509_status luo_status

Try
	
	//Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium
	
	luo_cancel = create uo_ge509_cancelamento
	luo_status = create uo_ge509_status

	//cancela o pedido
	if Not luo_cancel.of_processa_cancelamento( ps_id_pedido, ref ps_log ) Then return false

	//Busca o status do pedido pra certificar que foi cancelado.
	if Not luo_status.of_processa_status( pl_cd_filial, pl_nr_pedido, ps_id_pedido, ref ls_status, ref ps_log ) Then return false

	if ls_status <> 'CANCELADO' or isnull(ls_status) or ls_status = '' Then
		ps_log = is_objeto + ' - Falha ao realizar o cancelamento da entrega do pedido: Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - Pedido ' + ps_id_pedido
		return false
	end if
	
Finally
	
	destroy(luo_cancel)
	destroy(luo_status)
	
End Try

return true
end function

on uo_ge501_pedido_devolucao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_pedido_devolucao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

