HA$PBExportHeader$uo_ge615_aviso_email.sru
forward
global type uo_ge615_aviso_email from nonvisualobject
end type
type str_notas from structure within uo_ge615_aviso_email
end type
end forward

type str_notas from structure
	long		cd_filial
	long		nr_nf
	string		de_especie
	string		de_serie
end type

global type uo_ge615_aviso_email from nonvisualobject
end type
global uo_ge615_aviso_email uo_ge615_aviso_email

type variables
String ivs_dias_parametro
end variables

forward prototypes
public function boolean of_atualiza_nf_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
public function boolean of_processa_envio_informacao ()
public function boolean of_localiza_parametro_dias (ref string as_erro)
public function boolean of_processa_envio_contatos ()
public function boolean of_envia_email_contato (string as_cd_tipo, string as_de_tipo, string as_mensagem, dc_uo_ds_base ads_contatos, str_notas astr_notas[])
public function boolean of_atualiza_nf_transf_envio_contatos (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
public subroutine of_mensagem_erro_processo (string as_msg_erro)
public function boolean of_envia_email_motivo (datastore ads_produtos)
end prototypes

public function boolean of_atualiza_nf_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);
Update nf_transferencia
Set  	   dh_informacao_loja = getdate()
Where  cd_filial_destino =:al_filial
And	nr_nf=:al_nota
And    de_serie=:as_serie
And 	de_especie=:as_especie
And    cd_filial_origem  = 534  
Using SqlCA;


Choose Case SqlCa.SqlCode
	Case 0		
		SqlCa.of_commit( )
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi alterado nenhum registro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota. Filial: "+String(al_filial)+" Nota: "+String(al_nota)+" S$$HEX1$$e900$$ENDHEX$$rie: "+as_serie
		SqlCa.of_Rollback()
		Return False
	Case -1
		as_Erro = "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota. Filial: "+String(al_filial)+" Nota: "+String(al_nota)+" S$$HEX1$$e900$$ENDHEX$$rie: "+as_serie+" Erro: " + SqlCa.sqlErrText
		SqlCa.of_Rollback()
		Return False
	End Choose

Return True 
end function

public function boolean of_processa_envio_informacao ();Long ll_Linhas, ll_Linha, ll_Linhas_lj, ll_Linha_lj 
Long ll_Filial, ll_Nota, ll_Produto, ll_Qtd, ll_Pedido, ll_Filial_aux
String lvs_Especie, lvs_Serie, lvs_Produto, lvs_Motivo, lvs_descri_nota, lvs_nm_filial, lvs_mensagem_motivo, lvs_erro, lvs_tipo_pedido
DateTime  ldt_emissao  
Date ldt_data 
Boolean lb_Sucesso

ldt_data = Date(gf_getServerDate())

Try
	dc_uo_ds_base lds_notas
	dc_uo_ds_base lds_filiais
		
	// Lojas
	lds_filiais = create dc_uo_ds_base
	If Not lds_filiais.of_changedataobject( 'ds_ge615_filiais' ) Then		
		lvs_erro 	=	"Erro no ChageDataObject da ds_ge615_filiais." 
		Return False
	End if
		
	
	// Dados das Notas para Envio
	lds_notas = create dc_uo_ds_base
	If Not lds_notas.of_changedataobject( 'ds_ge615_notas_urgente_devolucao_cd' ) Then		
		lvs_erro 	=	"Erro no ChageDataObject da ds_ge615_notas_urgente_devolucao_cd." 
		Return False
	End if

	ll_Linhas_lj = lds_filiais.retrieve(ldt_data)	
	
	// Numero de Dias	
	If Not This.of_localiza_parametro_dias(Ref lvs_erro ) Then 
		Return False
		lvs_erro 	=	"Erro ao localizar o parametro de dias: of_envia_email_motivo  ge615" 
	End If	
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "CD - Filial: Processando Envio Email: Pedido Urgente Filial...."
	w_Aguarde.uo_Progress.of_setmax(ll_Linhas_lj)
	
	If	ll_Linhas_lj  >  0 Then 
		For ll_Linha_lj = 1 To ll_Linhas_lj
			ll_Filial_aux  =  lds_filiais.object.cd_filial_destino[ll_Linha_lj] 		
			
			w_Aguarde.Title = "Enviando e-mail Linha:" + String(ll_Linha_lj) + " de " + String(ll_Linhas_lj)
			w_Aguarde.uo_Progress.of_setprogress(ll_Linha_lj)
			
			// Carrega os dados
			ll_linhas = lds_notas.retrieve(ll_Filial_aux , ldt_data)

			// Para listar notas da filial 
			If ll_Linhas >  0 Then 				
				/// Envia email e depois atualiza registro na nf_transferencia
				If Not This.of_envia_email_motivo (lds_notas) then
					Return False
					lvs_erro = "Erro ao enviar email para loja: of_envia_email_motivo  ge615" 
				End If
			End If 	
		
		Next 			
	End If 		
Finally		
	Destroy (lds_notas)
	Destroy (lds_filiais) 
	Close(w_Aguarde)
End Try

Return True
end function

public function boolean of_localiza_parametro_dias (ref string as_erro);
SetNull(ivs_dias_parametro) 



Select vl_parametro
Into :ivs_dias_parametro
From wms_parametro
Where cd_parametro   = 'NR_DIAS_AVISO_NF_FATURAMENTO_URGENTE'
Using SqlCa;
	  
If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao localizar parametro de dias : " + SqlCa.sqlErrText
	SqlCa.of_Rollback()
	Return False
End If 

Return True 
end function

public function boolean of_processa_envio_contatos ();//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Boolean			lb_Achou

DateTime 		ldt_ini, &
					ldt_fim, &
					ldt_emissao

dc_uo_ds_base	lds_notas
dc_uo_ds_base	lds_contatos

Long				ll_Linhas,   &
					ll_Linha,    &
					ll_Contatos, &
					ll_Notas,    &
					ll_Lin_nota, &
					ll_Filial,   &
					ll_Nota,     &
					ll_Produto,  &
					ll_Qtd
				
str_notas		lstr_notas [], &
					lstr_nulo  []

String			ls_Tipo,            &
					ls_Tipo_Ant,        &
					ls_De_Tipo,         &
					ls_Especie,         &
					ls_Serie,           &
					ls_Produto,         &
					ls_Motivo,          &
					ls_descri_nota,     &
					ls_nm_filial,       &
					ls_Mensagem_Motivo, &
					ls_erro

//PROCEDIMENTOS
ldt_ini = DateTime (RelativeDate (Date (gf_getServerDate ()), -1), Time ('00:00:00'))
ldt_fim = DateTime (Date (ldt_ini), Time ('23:59:59'))

Try
	// Numero de Dias	
	If Not of_localiza_parametro_dias (Ref ls_Erro) then
		ls_erro = 'Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro de dias: of_processa_envio_contatos  ge615'
		of_mensagem_erro_processo (ls_Erro)
		Return False
	End If	
	
	// Contatos por tipo
	lds_contatos = Create dc_uo_ds_base
	If Not lds_contatos.of_ChangeDataObject ('ds_ge615_contatos_por_tipo') then
		ls_erro = 'Erro no ChageDataObject da ds_ge615_contatos_por_tipo.'
		of_mensagem_erro_processo (ls_Erro)
		Return False
	End if
	
	// Dados das Notas para Envio
	lds_notas = create dc_uo_ds_base
	If Not lds_notas.of_ChangeDataObject ('ds_ge615_notas_fat_urg_para_contatos') then
		ls_erro = 'Erro no ChageDataObject da ds_ge615_notas_fat_urg_para_contatos.'
		of_mensagem_erro_processo (ls_Erro)
		Return False
	End if
	
	ll_Contatos = lds_contatos.Retrieve ()
	
	If ll_Contatos < 1 then
		ls_erro = 'Erro ao localizar os contatos por tipo de pedido: of_processa_envio_contatos ge615'
		of_mensagem_erro_processo (ls_Erro)
		Return False
	End if
	
	ll_Linhas = lds_notas.Retrieve (ldt_ini, ldt_fim)
	
	If ll_Linhas > 0 then
		For ll_Linha = 1 to ll_Linhas
			ls_Tipo = lds_notas.Object.id_tipo_pedido [ll_linha]
			
			If ls_Tipo <> ls_Tipo_Ant then
				If ls_Tipo_Ant <> '' then
					//envia e-mail
					lds_contatos.SetFilter ("id_tipo = '" + ls_Tipo_Ant + "'")
					lds_contatos.Filter ()
					
					If Not of_envia_email_contato (ls_Tipo_Ant, &
															 ls_De_Tipo,  &
															 ls_Mensagem_Motivo,&
															 lds_contatos, &
															 lstr_notas []) then 
						Return False
					End If
					
					lds_contatos.SetFilter ('')
					lds_contatos.Filter ()
					ls_Mensagem_Motivo = ''
					lstr_notas []      = lstr_nulo []
					ll_Notas           = 0
					
				End if
				
				ls_De_Tipo  = lds_notas.Object.de_tipo [ll_linha]
				ls_Tipo_Ant = ls_Tipo
			End if
			
			ll_Filial           = lds_notas.Object.cd_filial      [ll_linha]
			ls_nm_filial        = lds_notas.Object.nm_fantasia    [ll_linha]
			ll_Produto          = lds_notas.Object.cd_produto     [ll_linha]
			ls_Produto          = lds_notas.Object.de_produto     [ll_linha]
			ll_Nota             = lds_notas.Object.nota           [ll_linha]
			ls_Especie          = lds_notas.Object.especie        [ll_linha]
			ls_Serie            = lds_notas.Object.serie          [ll_linha]
			ldt_emissao         = lds_notas.Object.dh_emissao     [ll_linha]
			ll_Qtd              = lds_notas.Object.qt_transferida [ll_linha]
			ls_Motivo           = lds_notas.Object.de_motivo      [ll_linha]
			ls_descri_nota      = String (ll_Nota, '000000') + '-' + ls_Serie + '-' + ls_Especie
			ls_Mensagem_Motivo += '<tr>' + &
										 '<th class="tg-0lax">' + String (ll_Filial) + '-' + ls_nm_filial + '</th>' + &
										 '<th class="tg-0lax">' + String (ls_descri_nota) + '</th>' + &
										 '<th class="tg-0lax">' + String (ldt_emissao, 'dd-mm-yyyy') + '</th>' + &
										 '<th class="tg-0lax">' + String (ll_Produto) + '</th>' + &
										 '<th class="tg-0lax">' + ls_Produto + '</th>' + &
										 '<th class="tg-0lax">' + String (ll_Qtd) + '</th>' + &
										 '<th class="tg-0lax">' + ls_Motivo + '</th>' + &
										 '</tr>'
			
			For ll_Lin_nota = 1 to ll_Notas
				If lstr_Notas [ll_Lin_nota].cd_filial  = ll_Filial  and &
					lstr_Notas [ll_Lin_nota].nr_nf      = ll_Nota    and &
					lstr_Notas [ll_Lin_nota].de_especie = ls_Especie and &
					lstr_Notas [ll_Lin_nota].de_serie   = ls_Serie   then
					lb_Achou = True
					Exit
				End if
			Next
			
			If not lb_Achou then
				ll_Notas ++
				lstr_Notas [ll_Notas].cd_filial  = ll_Filial
				lstr_Notas [ll_Notas].nr_nf      = ll_Nota
				lstr_Notas [ll_Notas].de_especie = ls_Especie
				lstr_Notas [ll_Notas].de_serie   = ls_Serie
			End if
			
			lb_Achou = False
		Next
		
		lds_contatos.SetFilter ("id_tipo = '" + ls_Tipo_Ant + "'")
		lds_contatos.Filter ()
		
		If Not of_envia_email_contato (ls_Tipo_Ant, &
												 ls_De_Tipo,  &
												 ls_Mensagem_Motivo,&
												 lds_contatos, &
												 lstr_notas []) then 
			Return False
		End If

	End if
	
Finally		
	If IsValid (lds_notas)    then Destroy lds_notas
	If IsValid (lds_contatos) then Destroy lds_contatos
End Try

Return True
end function

public function boolean of_envia_email_contato (string as_cd_tipo, string as_de_tipo, string as_mensagem, dc_uo_ds_base ads_contatos, str_notas astr_notas[]);//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Long		ll_Filial, &
			ll_Linha,  &
			ll_Linhas, &
			ll_Nota,   &
			ll_Mensagem

s_email	lst_Email

String	ls_Msg,     &
			ls_html,    &
			ls_especie, &
			ls_serie,   &
			ls_erro
			
//PROCEDIMENTOS
ls_html = '<style type="text/css">' + &
				".tg  {border-collapse:collapse;border-spacing:0;}" + &
				".tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:10px;  overflow:hidden;padding:10px 5px;word-break:normal;}" + &
				".tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:10px;  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}" + &
				".tg .tg-0lax{text-align:left;vertical-align:top}" + &
			 "</style>" + &
			 '<table class="tg">' + &
				'<thead>' + &
					'<tr>' + &
						'<th class="tg-0lax">Filial</th>'       + &
						'<th class="tg-0lax">Nota</th>'         + &
						'<th class="tg-0lax">Data Emissao</th>' + &
						'<th class="tg-0lax">C$$HEX1$$f300$$ENDHEX$$digo</th>'       + &
						'<th class="tg-0lax">Descri$$HEX2$$e700e300$$ENDHEX$$o</th>'    + &
						'<th class="tg-0lax">Quantidade</th>'   + &
						'<th class="tg-0lax">Motivo</th>'       + &
					'</tr>' + &
					as_mensagem + &
				'</thead>' + &
			 '</table>'

ls_Msg =	'As notas abaixo foram enviadas para as respectivas lojas ontem.<br><br>' + &
			'<strong>Nota Transfer$$HEX1$$ea00$$ENDHEX$$ncia $$HEX1$$1320$$ENDHEX$$ Faturamento Urgente - DEVOLU$$HEX2$$c700c300$$ENDHEX$$O ' + as_de_tipo + '</strong><br><br>' + &
			"A Filial receber$$HEX1$$e100$$ENDHEX$$ o volume dentro de " + String (ivs_dias_parametro) + " tr$$HEX1$$ea00$$ENDHEX$$s dias $$HEX1$$fa00$$ENDHEX$$teis ap$$HEX1$$f300$$ENDHEX$$s a emiss$$HEX1$$e300$$ENDHEX$$o da nota fiscal<br>" + &
			ls_html+"<br>"

lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

ll_Linhas = ads_contatos.RowCount ()

For ll_Linha = 1 to ll_Linhas
	lst_email.ps_to [ll_Linha] = ads_contatos.Object.de_endereco_email [ll_linha]
Next

Choose case as_cd_tipo
	case 'E'
		ll_Mensagem = 346
	case 'S', 'T'
		ll_Mensagem = 350
End choose

If Not gf_ge202_envia_email_padrao (ll_Mensagem, lst_Email) then
	of_mensagem_erro_processo ('Erro no envio da mensagem aos contatos por tipo de pedido')
	Return False
End If

ll_Linhas = UpperBound (astr_notas[])

For ll_Linha = 1 To ll_Linhas
	
	ll_Filial  = astr_notas [ll_linha].cd_filial
	ll_Nota    = astr_notas [ll_linha].nr_nf
	ls_especie = astr_notas [ll_linha].de_especie
	ls_serie   = astr_notas [ll_linha].de_serie
	
	If Not of_atualiza_nf_transf_envio_contatos (ll_filial,  &
																ll_Nota,    &
																ls_especie, &
																ls_serie,   &
																Ref ls_erro) then
		Return False
	End if
Next
			
Return True
end function

public function boolean of_atualiza_nf_transf_envio_contatos (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);UPDATE nf_transferencia
	SET dh_envio_fat_urg_contato = GETDATE ()
 WHERE cd_filial_destino = :al_filial
	AND nr_nf             = :al_nota
	AND de_serie          = :as_serie
	AND de_especie        = :as_especie
	AND cd_filial_origem  = 534  
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case 0		
		SQLCA.of_Commit ()
	Case 100
		as_Erro = 'A nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o foi encontrada para o registro do envio do e-mail para os respons$$HEX1$$e100$$ENDHEX$$veis por tipo de pedido da nota. ' + &
					 'Filial: ' + String (al_filial) + ' Nota: ' + String (al_nota) + ' Esp$$HEX1$$e900$$ENDHEX$$cie: ' + as_especie + ' S$$HEX1$$e900$$ENDHEX$$rie: ' + as_serie
		SQLCA.of_Rollback ()
		of_mensagem_erro_processo (as_Erro)
		Return False
	Case -1
		as_Erro = 'Erro ao atualizar a data de envio do e-mail para os respons$$HEX1$$e100$$ENDHEX$$veis por tipo de pedido na nota. ' + &
					 'Filial: ' + String (al_filial) + ' Nota: ' + String (al_nota) + ' Esp$$HEX1$$e900$$ENDHEX$$cie: ' + as_especie + ' S$$HEX1$$e900$$ENDHEX$$rie: ' + as_serie + &
					 ' Erro: ' + SQLCA.sQLErrText
		SQLCA.of_Rollback ()
		of_mensagem_erro_processo (as_Erro)
		Return False
	End Choose

Return True
end function

public subroutine of_mensagem_erro_processo (string as_msg_erro);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

String	ls_Msg

s_email	lst_Email					

// PROCEDIMENTOS

ls_Msg =	'<b>ATEN$$HEX2$$c700c300$$ENDHEX$$O!!!!!'                                                                              + '<br><br>' + &
			'<b>Faturamento urgente: Erro no envio de mensagem para os contatos por tipo de distribuidora' + '<br></b>' + &
			'<b>Sistema ExportacaoSupply'                                                                  + '<br></b>' + &
			'<b>Mensagem: ' + as_msg_erro                                                                  + '<br></b>'
			
lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

gf_ge202_envia_email_padrao (347, lst_Email)

Return
end subroutine

public function boolean of_envia_email_motivo (datastore ads_produtos);DateTime			ldh_emissao

dc_uo_ds_base	lds_Tipos_Pedido

String			ls_Msg,         &
					ls_Loja,        &
					ls_html,        &
					ls_especie,     &
					ls_serie,       &
					ls_erro,        &
					ls_nm_filial,   &
					ls_Produto,     &
					ls_Motivo,      &
					ls_descri_nota, &
					ls_Tipo_Pedido, &
					ls_Texto_1,     &
					ls_Texto_2,     &
					ls_Texto_3,     &
					ls_mensagem_motivo
					
Long				ll_Filial,    &
					ll_Nota,      &
					ll_Nota_Ant,  &
					ll_Produto,   &
					ll_Qtd,       &
					ll_Lin_Prod,  &
					ll_Tot_Prods, &
					ll_Lin_Tipo,  &
					ll_Tot_TIpos
					
s_email			lst_Email

//
//PROCEDIMENTOS
//

lds_Tipos_Pedido = Create dc_uo_ds_base

If not lds_Tipos_Pedido.of_ChangeDataObject ('ddw_tipo_pedido_dist_fat_urg') then
	Return False
End if

If lds_Tipos_Pedido.Retrieve () < 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na obten$$HEX2$$e700e300$$ENDHEX$$o da lista de tipos de pedidos de distribuidora!', StopSign!)
	Return False
End if

lds_Tipos_Pedido.SetFilter ("id_devolucao = 'S'")
lds_Tipos_Pedido.Filter ()
ll_Tot_TIpos = lds_Tipos_Pedido.RowCount ()

ll_Filial    = ads_produtos.Object.cd_filial   [1]
ls_nm_filial = ads_produtos.Object.nm_fantasia [1]

For ll_Lin_Tipo = 1 to ll_Tot_TIpos
	ls_Tipo_Pedido = lds_Tipos_Pedido.Object.id_tipo [ll_Lin_Tipo]
	
	ads_produtos.SetFilter ("id_tipo_pedido = '" + ls_Tipo_Pedido + "'")
	ads_produtos.Filter ()
	
	ll_Tot_Prods = ads_produtos.RowCount ()
	
	If ll_Tot_Prods > 0 then
		ls_mensagem_motivo = ''
		
		For ll_Lin_Prod = 1 to ll_Tot_Prods
			ll_Produto          = ads_produtos.object.cd_produto     [ll_Lin_Prod]
			ls_Produto          = ads_produtos.object.de_produto     [ll_Lin_Prod]
			ll_Nota             = ads_produtos.object.nota           [ll_Lin_Prod]
			ls_Especie          = ads_produtos.object.especie        [ll_Lin_Prod]
			ls_Serie            = ads_produtos.object.serie          [ll_Lin_Prod]
			ldh_emissao         = ads_produtos.object.dh_emissao     [ll_Lin_Prod]
			ll_Qtd              = ads_produtos.object.qt_transferida [ll_Lin_Prod]
			ls_Motivo           = ads_produtos.object.de_motivo      [ll_Lin_Prod]
			ls_descri_nota      = String (ll_Nota, '000000') + '-' + ls_Serie + '-' + ls_Especie
			ls_mensagem_motivo += '<tr>' + &
											'<th class="tg-0lax">' + String (ls_descri_nota) + '</th>' + &
											'<th class="tg-0lax">' + String (ldh_emissao, 'dd-mm-yyyy') + '</th>' + &
											'<th class="tg-0lax">' + String (ll_Produto) + '</th>' + &
											'<th class="tg-0lax">' + ls_Produto + '</th>' + &
											'<th class="tg-0lax">' + String (ll_Qtd) + '</th>' + &
											'<th class="tg-0lax">' + ls_Motivo + '</th>' + &
										 '</tr>'
		Next
		
		ls_html = '<style type="text/css">' + &
					'.tg  {border-collapse:collapse;border-spacing:0;}' + &
					'.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:10px;' + &
					'  overflow:hidden;padding:10px 5px;word-break:normal;}' + &
					'.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:10px;' + &
					'  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}' + &
					'.tg .tg-0lax{text-align:left;vertical-align:top}' + &
					'</style>' + &
					'<table class="tg">' + &
						'<thead>' + &
							'<tr>' + &
								'<th class="tg-0lax">Nota</th>' + &
								'<th class="tg-0lax">Data Emiss$$HEX1$$e300$$ENDHEX$$o</th>' + &
								'<th class="tg-0lax">C$$HEX1$$f300$$ENDHEX$$digo</th>' + &
								'<th class="tg-0lax">Descri$$HEX2$$e700e300$$ENDHEX$$o</th>' + &
								'<th class="tg-0lax">Quantidade</th>' + &
								'<th class="tg-0lax">Motivo</th>' + &
							'</tr>' + &
							ls_mensagem_motivo + &
						'</thead>' + &
					'</table>'
		
		ls_Loja = String (ll_filial) + ' - ' + ls_nm_filial
		
		Choose case ls_Tipo_Pedido
			case 'E'	//Excesso
				ls_Texto_1 = 'DA RETIRADA DE EXCESSO'
				ls_Texto_2 = 'retirada de excesso'
				ls_Texto_3 = '<strong>' + 'E-mail:' + '</strong>' + ' excesso.perini@clamed.com.br / leticia.vieira@clamed.com.br' + '<br>' + &
								 '<strong>' + 'Telefone:' + '</strong>' + ' (47) 3461-9789'
				
			case 'S'	//Segregado
				ls_Texto_1 = 'SEGREGADOS'
				ls_Texto_2 = 'Segregados'
				ls_Texto_3 = '<strong>' + 'E-mail:' + '</strong>' + ' devolucao@clamed.com.br / rosangela.borba@clamed.com.br' + '<br>' + &
								 '<strong>' + 'Telefone:' + '</strong>' + ' (47) 3461-9740'
				
			case 'T'	//Segregado Transf
				ls_Texto_1 = 'SEGREGADOS TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA CD'
				ls_Texto_2 = 'Segregados Transfer$$HEX1$$ea00$$ENDHEX$$ncia'
				ls_Texto_3 = '<strong>' + 'E-mail:' + '</strong>' + ' carla.junglos@clamed.com.br' + '<br>' + &
								 '<strong>' + 'Telefone:' + '</strong>' + ' (47) 3461-9740'
				
		End choose
		
		ls_Msg =	' DEVOLU$$HEX2$$c700c300$$ENDHEX$$O ' + ls_Texto_1 + '<br>' + &
					' Nota Transfer$$HEX1$$ea00$$ENDHEX$$ncia $$HEX1$$1320$$ENDHEX$$ Faturamento Urgente<br>' + &
					' Loja: ' + ls_Loja + '<br>' + &
					ls_html + '<br>' + &
					'<p><strong>' + ' Orienta$$HEX2$$e700f500$$ENDHEX$$es sobre a transfer$$HEX1$$ea00$$ENDHEX$$ncia:' + '</strong></p>' + &
					'<p>' + ' Nos casos em que o motivo da transfer$$HEX1$$ea00$$ENDHEX$$ncia for "falta", n$$HEX1$$e300$$ENDHEX$$o haver$$HEX1$$e100$$ENDHEX$$ envio de volume f$$HEX1$$ed00$$ENDHEX$$sico, ' + &
					'apenas a transfer$$HEX1$$ea00$$ENDHEX$$ncia do saldo correspondente.' + '</p>' + &
					' Para os demais motivos, o volume ser$$HEX1$$e100$$ENDHEX$$ enviado $$HEX1$$e000$$ENDHEX$$ filial em at$$HEX1$$e900$$ENDHEX$$ ' + &
					'<strong>' + 'tr$$HEX1$$ea00$$ENDHEX$$s dias $$HEX1$$fa00$$ENDHEX$$teis' + '</strong>' + &
					' ap$$HEX1$$f300$$ENDHEX$$s a emiss$$HEX1$$e300$$ENDHEX$$o da nota fiscal.' + '<br>' + &
					'<p>' + ' Em caso de d$$HEX1$$fa00$$ENDHEX$$vidas sobre essa transfer$$HEX1$$ea00$$ENDHEX$$ncia, entre em contato com setor de ' + &
					ls_Texto_2 + ' pelos canais abaixo:' + '<br>' + &
					ls_Texto_3 + '</strong></p><br>'
		
		lst_Email.ps_mensagem	= ls_Msg
		lst_Email.pb_assinatura = True
		lst_email.ps_to [1]     = String (ll_filial, '0000') + '@clamedlocal.com.br'
		If Not gf_ge202_envia_email_padrao (235, lst_Email) then
			Return False
		End if
		
		ll_Nota_Ant = 0
		
		For ll_Lin_Prod = 1 to ll_Tot_Prods
			ll_Nota    = ads_produtos.Object.nota    [ll_Lin_Prod]
			ls_especie = ads_produtos.Object.especie [ll_Lin_Prod]
			ls_serie   = ads_produtos.Object.serie   [ll_Lin_Prod]
			
			If ll_Nota <> ll_Nota_Ant then
				If Not This.of_atualiza_nf_transferencia (ll_filial,  &
																		ll_Nota ,   &
																		ls_especie, &
																		ls_serie,   &
																		Ref ls_erro) then
					Return False
				End if
				
				ll_Nota_Ant = ll_Nota
			End if
		Next
	End if
Next

Return True
end function

on uo_ge615_aviso_email.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge615_aviso_email.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

