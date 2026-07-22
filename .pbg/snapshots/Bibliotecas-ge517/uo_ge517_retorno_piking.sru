HA$PBExportHeader$uo_ge517_retorno_piking.sru
forward
global type uo_ge517_retorno_piking from nonvisualobject
end type
end forward

global type uo_ge517_retorno_piking from nonvisualobject
end type
global uo_ge517_retorno_piking uo_ge517_retorno_piking

type variables
/// PadPicking
uo_ge512_smart_piking lo_pick

String is_Url_Status_Servico
String is_Status_Servico
String is_Url_Envio
String is_Url_Retorno
String is_Key

String is_Json_Envio
String is_Json_Retorno

dc_uo_ds_base lds_logs
end variables
forward prototypes
public function integer wf_receber_picking ()
end prototypes

public function integer wf_receber_picking ();//Receber
lo_pick = Create uo_ge512_smart_piking
datastore lds_lista_envio

Long 	ll_Filial,&
		ll_Pedido,&
		ll_Linha,&
		ll_Linhas,&
		ll_Volume,&
		ll_Linhas_Selecionadas,&
		ll_Esteira

String 	ls_Erro,&
			ls_Retorno,&
			ls_Picking,&
			ls_Cd_Retorno,&
			ls_Ds_Retorno


// Carrega Informa$$HEX2$$e700e300$$ENDHEX$$o URL 
If Not lo_pick.of_busca_url(Ref is_Url_Envio, Ref is_Url_Retorno , Ref is_Url_Status_Servico, Ref ls_erro ) Then 
	//MessageBox("Aviso", "PadPicking: Erro Busca URL Configuracao")
	Return -1
End If 

// Verifica Status Servidor SmartPicking
If Not lo_pick.of_busca_status_servidor ( is_Url_Status_Servico, Ref is_Status_Servico, Ref ls_erro )  Then 
	//MessageBox("Aviso", "PadPicking: Servi$$HEX1$$e700$$ENDHEX$$o Esta Fora / Servidor SmartPicking")
	Return -1
End If

lds_lista_envio = Create datastore
lds_lista_envio.dataobject = 'dw_ge517_lista_envio'
lds_lista_envio.SetTransObject(dc_uo_transacao)
ll_Linhas =lds_lista_envio.retrieve()

// Verifica Status Servidor SmartPicking
If ll_Linhas < 0  Then 
	//MessageBox("Aviso", "Receber Picking: Erro de conex$$HEX1$$e300$$ENDHEX$$o ao banco de dados")
	Return -1
End If


Try

	SetNull(is_Json_Envio)
		
	For ll_Linha = 1 To ll_linhas
		ll_Filial	 			= lds_lista_envio.Object.cd_filial						[ll_Linha]
		ll_Pedido	 			= lds_lista_envio.Object.nr_pedido_distribuidora	[ll_Linha]
		ll_Volume 			= lds_lista_envio.Object.nr_volume			[ll_Linha]
	
		// Montagem Arquivo: Cabe$$HEX1$$e700$$ENDHEX$$alho/Conteudo
		If lo_pick.of_monta_json_arquivo(ll_Filial, ll_Pedido, ll_Volume, Ref ls_Picking, Ref is_Json_Envio )  Then  
			// Autentica e Envia
			If lo_pick.of_autenticacao (is_Key , ref ls_erro, is_Json_Envio ,  ref is_Json_Retorno, 'E') Then 
				/// Insere Registro Tabela Log: Arquivo gerado Clamed
				If lo_pick.of_processa_atualizacoes ('E' , ll_Filial, ll_Pedido, ll_Volume, ls_Picking, is_Json_Retorno,is_Json_Envio, Ref ls_Cd_Retorno, Ref ls_Ds_Retorno) Then 
					 // Caso Envio ao PadPicking Mas Sem Sucesso
					If ls_Cd_Retorno<>'1' Then 
						MessageBox("Aviso", "Reenvio PadPicking"+ " Codigo:"+String(ls_Cd_Retorno) +" Descri$$HEX2$$e700e300$$ENDHEX$$o:"+String(ls_Ds_Retorno))
						Continue
					End If							
				End If 
			End If 
			End If 									
	Next
	
Finally
	Destroy(lo_pick)	
	Destroy(lds_lista_envio)
End Try

Return 1

end function

on uo_ge517_retorno_piking.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge517_retorno_piking.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

