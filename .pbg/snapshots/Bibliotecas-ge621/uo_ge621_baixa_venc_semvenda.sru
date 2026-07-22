HA$PBExportHeader$uo_ge621_baixa_venc_semvenda.sru
forward
global type uo_ge621_baixa_venc_semvenda from nonvisualobject
end type
type st_produtos_selecionados from structure within uo_ge621_baixa_venc_semvenda
end type
end forward

type st_produtos_selecionados from structure
	long		cd_produto
	string		de_produto
end type

global type uo_ge621_baixa_venc_semvenda from nonvisualobject
end type
global uo_ge621_baixa_venc_semvenda uo_ge621_baixa_venc_semvenda

type variables
Date				idt_limite_regular, &
					idt_limite_sazonal, &
					idt_ult_entrada

dc_uo_ds_base	ids_filial,    &
					ids_prod_venc, &
					ids_compras,   &
					ids_vendas,    &
					ids_promocoes, &
					ids_processados

Long				il_dias_regular, &
					il_dias_sazonal, &
					il_dias_utima_entrada

Private st_produtos_selecionados	ist_produtos []
end variables

forward prototypes
public function boolean of_executa_processo ()
public function boolean of_obtem_parametros ()
public function boolean of_atualiza_reposicao (long al_filial, long al_produto)
public function boolean of_verifica_compras_recentes (long al_filial, long al_produto, ref boolean ab_tem_compras)
public function boolean of_verifica_vendas_recentes (long al_filial, long al_produto, string as_tipo_reposicao, ref boolean ab_tem_vendas)
public function boolean of_verifica_promocoes (long al_filial, long al_produto, ref boolean ab_tem_promocoes)
public function boolean of_processa_filial (long al_filial, string as_nome_filial)
public function boolean of_envia_email_loja (long al_filial, string as_nome_filial, string as_html_produtos)
public function boolean of_envia_planilha ()
public subroutine of_mensagem_processo (string as_erro_msg)
public function boolean of_cria_ds ()
public function boolean of_atualiza_promocao_planograma (long al_filial, long al_produto)
public function boolean of_grava_historico_exclusao_planograma (long al_filial, long al_produto)
end prototypes

public function boolean of_executa_processo ();// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Long		ll_lin_filial, &
			ll_tot_filial, &
			ll_filial

String	ls_nome_filial

// PROCEDIMENTOS

If not of_obtem_parametros () then
	Return False
End if

//Cria DSs
//
If not of_cria_ds () then
	Return False
End if

//Lista filiais que n$$HEX1$$e300$$ENDHEX$$o rep$$HEX1$$f500$$ENDHEX$$em produto vencido sem venda
//
ll_tot_filial = ids_filial.Retrieve ()

If ll_tot_filial < 0 then
	of_mensagem_processo ('Erro na leitura da lista de filiais')
	Return False
End if

For ll_lin_filial = 1 to ll_tot_filial
	ll_filial      = ids_filial.Object.cd_filial   [ll_lin_filial]
	ls_nome_filial = ids_filial.Object.nm_fantasia [ll_lin_filial]
	
	If not of_processa_filial (ll_filial, ls_nome_filial) then
		Return False
	End if
Next

If ids_processados.RowCount () > 0 then
	If not of_envia_planilha () then
		Return False
	End if
End if

Return True
end function

public function boolean of_obtem_parametros ();// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Date		ldt_hoje
String	ls_par_regular = 'NR_DIAS_REGULAR'
String	ls_par_sazonal = 'NR_DIAS_SAZONAL'
String	ls_par_ult_ent = 'NR_DIAS_ULTIMA_ENTRADA'

// PROCEDIMENTOS

ldt_hoje = Date (gf_GetServerDate ())

SELECT vl_parametro
  INTO :il_dias_regular
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_regular
 USING SQLCA;

Choose case SQLCA.SQLCode
	case 0
		idt_limite_regular = RelativeDate (ldt_hoje, il_dias_regular * -1)
	
	case is < 0
		of_mensagem_processo ('Erro na leitura do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_regular + ': ' + SQLCA.SQLErrText)
		Return False
	case 100
		of_mensagem_processo ('O par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_regular + ' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado')
		Return False
End choose

SELECT vl_parametro
  INTO :il_dias_sazonal
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_sazonal
 USING SQLCA;

Choose case SQLCA.SQLCode
	case 0
		idt_limite_sazonal = RelativeDate (ldt_hoje, il_dias_sazonal * -1)
	
	case is < 0
		of_mensagem_processo ('Erro na leitura do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_sazonal + ': ' + SQLCA.SQLErrText)
		Return False
	case 100
		of_mensagem_processo ('O par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_sazonal + ' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado')
		Return False
End choose

SELECT vl_parametro
  INTO :il_dias_utima_entrada
  FROM parametro_geral
 WHERE cd_parametro = :ls_par_ult_ent
 USING SQLCA;

Choose case SQLCA.SQLCode
	case 0
		idt_ult_entrada = RelativeDate (ldt_hoje, il_dias_utima_entrada * -1)
	
	case is < 0
		of_mensagem_processo ('Erro na leitura do par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_ult_ent + ': ' + SQLCA.SQLErrText)
		Return False
	case 100
		of_mensagem_processo ('O par$$HEX1$$e200$$ENDHEX$$metro ' + ls_par_ult_ent + ' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado')
		Return False
End choose

Return True
end function

public function boolean of_atualiza_reposicao (long al_filial, long al_produto);String	ls_erro

UPDATE resumo_reposicao_estoque
	SET qt_estoque_base_inicial = 0
	  , qt_estoque_base         = 0
	  , qt_estoque_minimo       = 0
	  , dh_alteracao            = GETDATE ()
	  , id_alteracao            = 'M'
	  , nr_matricula_alteracao  = '14330'
	  , de_motivo_alteracao     = 'PRODUTO SEM VENDA BAIXADO COMO VENCIDO'
	  , id_importacao_sap       = 'N'
	  , dh_termino_bloqueio     = NULL
	  , cd_motivo_alteracao_sap = 68
 WHERE cd_filial  = :al_filial
	AND cd_produto = :al_produto
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	ls_erro = SQLCA.SQLErrText
	SQLCA.of_RollBack ()
	of_mensagem_processo ('Erro ao atualizar o resumo de reposi$$HEX2$$e700e300$$ENDHEX$$o de estoque do produto ' + String (al_produto) + ' na filial ' + String (al_filial) + ': ' + ls_erro)
	Return False
End if

Return True
end function

public function boolean of_verifica_compras_recentes (long al_filial, long al_produto, ref boolean ab_tem_compras);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Long	ll_tot_lin_compras

// PROCEDIMENTOS

ll_tot_lin_compras = ids_compras.Retrieve (al_filial, al_produto, idt_ult_entrada)

If ll_tot_lin_compras < 0 then
	of_mensagem_processo ('Erro na leitura das compras recentes')
	Return False
End if

ab_tem_compras = ll_tot_lin_compras > 0

Return True
end function

public function boolean of_verifica_vendas_recentes (long al_filial, long al_produto, string as_tipo_reposicao, ref boolean ab_tem_vendas);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Long	ll_tot_lin_vendas

// PROCEDIMENTOS

ll_tot_lin_vendas = ids_vendas.Retrieve (al_filial, al_produto, as_tipo_reposicao, idt_limite_regular, idt_limite_sazonal)

If ll_tot_lin_vendas < 0 then
	of_mensagem_processo ('Erro na leitura das vendas recentes')
	Return False
End if

ab_tem_vendas = ll_tot_lin_vendas > 0

Return True
end function

public function boolean of_verifica_promocoes (long al_filial, long al_produto, ref boolean ab_tem_promocoes);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Long	ll_tot_lin_promocoes

// PROCEDIMENTOS

ll_tot_lin_promocoes = ids_promocoes.Retrieve (al_filial, al_produto)

If ll_tot_lin_promocoes < 0 then
	of_mensagem_processo ('Erro na leitura das promo$$HEX2$$e700f500$$ENDHEX$$es vigentes')
	Return False
End if

ab_tem_promocoes = ll_tot_lin_promocoes > 0

Return True
end function

public function boolean of_processa_filial (long al_filial, string as_nome_filial);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Boolean							lb_tem_compras,    &
									lb_tem_vendas,     &
									lb_tem_promocoes

Long								ll_lin_prod,       &
									ll_tot_lin_venc,   &
									ll_produto,        &
									ll_lin_sel,        &
									ll_lin_proc,       &
									ll_lin_planilha
					
String							ls_tipo_reposicao, &
									ls_de_produto,     &
									ls_html_produtos
					
st_produtos_selecionados	lst_vazia []

// PROCEDIMENTOS

ist_produtos [] = lst_vazia []

//Carrega produtos vencidos e baixados (1o crit$$HEX1$$e900$$ENDHEX$$rio)
//
ll_tot_lin_venc = ids_prod_venc.Retrieve (al_filial)

If ll_tot_lin_venc < 0 then
	of_mensagem_processo ('Erro na leitura dos produtos vencidos com baixa')
	Return False
End if

Open(w_Aguarde)
w_Aguarde.Title = "Verificando Vencidos Baixa"
w_Aguarde.uo_Progress.of_setmax(ll_tot_lin_venc)

Try
	For ll_lin_prod = 1 to ll_tot_lin_venc
		ll_produto        = ids_prod_venc.Object.cd_produto        [ll_lin_prod]
		ls_de_produto     = ids_prod_venc.Object.de_produto        [ll_lin_prod]
		ls_tipo_reposicao = ids_prod_venc.Object.id_tipo_reposicao [ll_lin_prod]
		
		
		w_Aguarde.Title = "Verificando Vencidos Baixa: Filial:"+String(al_filial)+" Produto:"+String(ll_produto)
		w_Aguarde.uo_Progress.of_setprogress(ll_lin_prod)
		
		//
		//O produto deve ter compras recentes (2o crit$$HEX1$$e900$$ENDHEX$$rio)
		//	
		/*w_Aguarde.Title = "Compras: Verificando Vencidos Baixa: Filial:"+String(al_filial)+" Produto:"+String(ll_produto)
		If not of_verifica_compras_recentes (al_filial, ll_produto, Ref lb_tem_compras) then
			Return False
		End if
		
		If not lb_tem_compras then
			Continue
		End if
		*/
		
		//
		//O produto n$$HEX1$$e300$$ENDHEX$$o deve ter vendas n$$HEX1$$e300$$ENDHEX$$o prestes recentes (3o crit$$HEX1$$e900$$ENDHEX$$rio)
		//
		w_Aguarde.Title = "Vendas Vencidos Baixa: Filial:"+String(al_filial)+" Produto:"+String(ll_produto)
		If not of_verifica_vendas_recentes (al_filial, ll_produto, ls_tipo_reposicao, Ref lb_tem_vendas) then
			Return False
		End if
		
		If lb_tem_vendas then
			Continue
		End if
		
		//
		//O produto deve ter promo$$HEX2$$e700f500$$ENDHEX$$es vigentes (4o crit$$HEX1$$e900$$ENDHEX$$rio)
		//
		w_Aguarde.Title = "Promo$$HEX2$$e700f500$$ENDHEX$$es Vencidos Baixa: Filial:"+String(al_filial)+" Produto:"+String(ll_produto)
		If not of_verifica_promocoes (al_filial, ll_produto, Ref lb_tem_promocoes) then
			Return False
		End if
		
		If not lb_tem_promocoes then
			Continue
		End if
		
		//	se atender os 4 crit$$HEX1$$e900$$ENDHEX$$rios, PROCESSA O PRODUTO/FILIAL
		w_Aguarde.Title = "Alteracao EB Vencidos Baixa: Filial:"+String(al_filial)+" Produto:"+String(ll_produto)
		If not of_atualiza_reposicao (al_filial, ll_produto) then
			Return False
		End if
		
		//	EXCLUI O ESTOQUE M$$HEX1$$cd00$$ENDHEX$$NIMO DE PLANOGRAMA
		w_Aguarde.Title = "Exclusao Min.Planograma Vencidos Baixa: Filial:"+String(al_filial)+" Produto:"+String(ll_produto)
		If not of_atualiza_promocao_planograma (al_filial, ll_produto) then
			Return False
		End if
		
		ll_lin_sel ++
		ist_produtos [ll_lin_sel].cd_produto = ll_produto
		ist_produtos [ll_lin_sel].de_produto = ls_de_produto
	Next
	
	If ll_lin_sel > 0 then
		
		For ll_lin_proc = 1 to ll_lin_sel
			ll_lin_planilha = ids_processados.InsertRow (0)
			
			ids_processados.Object.filial            [ll_lin_planilha] = al_filial
			ids_processados.Object.nome_filial       [ll_lin_planilha] = as_nome_filial
			ids_processados.Object.produto           [ll_lin_planilha] = ist_produtos [ll_lin_proc].cd_produto
			ids_processados.Object.descricao_produto [ll_lin_planilha] = ist_produtos [ll_lin_proc].de_produto
			
			ls_html_produtos +=  '<tr>' + &
											'<th class="tg-0lax">' + String (ist_produtos [ll_lin_proc].cd_produto) + '</th>' + &
											'<th class="tg-0lax">' + ist_produtos [ll_lin_proc].de_produto          + '</th>' + &
										'</tr>'
		Next
		
		If not of_envia_email_loja (al_filial, as_nome_filial, ls_html_produtos) then
			SQLCA.of_Rollback ()
			Return False
		End if
		
		SQLCA.of_Commit ()
		
	End if
Finally
	Close (w_Aguarde)
End Try

Return True
end function

public function boolean of_envia_email_loja (long al_filial, string as_nome_filial, string as_html_produtos);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

String	ls_Msg,  &
			ls_Loja, &
			ls_html, &
			ls_produtos
			
s_email	lst_Email

// PROCEDIMENTOS

ls_html =	'<style type="text/css">' + &
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
							'<th class="tg-0lax">Produto</th>' + &
							'<th class="tg-0lax">Descri$$HEX2$$e700e300$$ENDHEX$$o do produto</th>' + &
						'</tr>' + &
						as_html_produtos + &
					'</thead>' + &
				'</table>'

ls_Loja = String (al_filial) + ' - ' + as_nome_filial

ls_Msg =	' Caro gerente,' + '<br>' + &
			' Os produtos abaixo tiveram seus estoques zerados, tanto estoque base, m$$HEX1$$ed00$$ENDHEX$$nimo de promo$$HEX2$$e700e300$$ENDHEX$$o e planograma, por terem' + &
			' sidos baixados como vencidos e n$$HEX1$$e300$$ENDHEX$$o terem movimenta$$HEX2$$e700e300$$ENDHEX$$o na loja nos $$HEX1$$fa00$$ENDHEX$$ltimos ' + String (il_dias_regular) + ' dias:' + '<br><br>' + &
			' Loja: ' + ls_Loja + '<br>' + &			
			ls_html + '<br>'

lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True
//lst_email.ps_to [1]     = String (al_filial, '0000') + '@clamedlocal.com.br'

If Not gf_ge202_envia_email_padrao (315, lst_Email) then
	Return False
End if

Return True
end function

public function boolean of_envia_planilha ();// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Integer	li_loop

Long		ll_tot_lin

String	lvs_Path, &
			ls_Msg, &
			ls_anexo [], &
			ls_titulo, &
			ls_arquivo

// PROCEDIMENTOS

ls_arquivo = 'Baixa_produtos_vencidos-' + String (Now (), 'yyyymmdd_hhmmss')

ll_tot_lin = ids_processados.RowCount ()

If ll_tot_lin > 65000 then
	ls_arquivo += '.txt'
else
	ls_arquivo += '.xls'
End if

lvs_Path = ProfileString (gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'Diretorio', '')

If lvs_Path = '' Then
	of_mensagem_processo ('O diret$$HEX1$$f300$$ENDHEX$$rio default n$$HEX1$$e300$$ENDHEX$$o foi encontrado no arquivo INI da aplica$$HEX2$$e700e300$$ENDHEX$$o.')
	Return False
End if

lvs_Path = Trim (lvs_Path)

If Mid (lvs_Path, Len (lvs_Path), 1) <> '\' then
	lvs_Path += '\'
End if

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists (lvs_Path + ls_arquivo) Then
	If Not FileDelete (lvs_Path + ls_arquivo) Then
		of_mensagem_processo ('Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo ' + lvs_Path)
		Return False
	End If   
End If

If ll_tot_lin > 65000 then
	If ids_processados.SaveAs (lvs_Path + ls_arquivo, Text!, True) = -1 then
		of_mensagem_processo ('Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo ' + lvs_Path + ls_arquivo)
		Return False
	End if
else
	If ids_processados.SaveAs (lvs_Path + ls_arquivo, Excel8!, True) = -1 then
		of_mensagem_processo ('Erro na grava$$HEX2$$e700e300$$ENDHEX$$o da planilha ' + lvs_Path + ls_arquivo)
		Return False
	End if
End if


Do until FileExists (lvs_Path + ls_arquivo)
	If li_loop = 12 then Exit
	Idle (5)
	li_loop ++
Loop

If Not FileExists (lvs_Path + ls_arquivo) then
	of_mensagem_processo ('Erro na grava$$HEX2$$e700e300$$ENDHEX$$o da planilha ' + lvs_Path + ls_arquivo)
	Return False
End if
		
ls_titulo = ''
ls_msg    = 'Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio(a),' + '<br><br>' + &
				'Segue em anexo a lista da baixa de produtos vencidos sem venda, por filial, gerada hoje.' + '<br><br>' + &
				'A sele$$HEX2$$e700e300$$ENDHEX$$o das filiais e produtos levou em considera$$HEX2$$e700e300$$ENDHEX$$o os seguintes par$$HEX1$$e200$$ENDHEX$$metros:' + '<br>' + &
				'- Produtos prestes n$$HEX1$$e300$$ENDHEX$$o vendidos, baixados e de distribuidoras sem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o;' + '<br>' + &
				'- Data limite para verifica$$HEX2$$e700e300$$ENDHEX$$o de vendas de produto regular  : ' + String (idt_limite_regular, 'dd/mm/yyyy') + ' ($$HEX1$$fa00$$ENDHEX$$ltimos ' + String (il_dias_regular) + ' dias);' + '<br>' + &
				'- Data limite para verifica$$HEX2$$e700e300$$ENDHEX$$o de vendas de produto sazonal  : ' + String (idt_limite_sazonal, 'dd/mm/yyyy') + ' ($$HEX1$$fa00$$ENDHEX$$ltimos ' + String (il_dias_sazonal) + ' dias).'
					
//				'A lista da baixa de produtos vencidos sem venda, por filial, gerada hoje, pode ser encontrada no arquivo ' + lvs_Path + ls_arquivo + '<br><br>' + &
//				'- Data limite para $$HEX1$$fa00$$ENDHEX$$ltima entrada do produto na loja: ' + String (idt_ult_entrada, 'dd/mm/yyyy') + ' ($$HEX1$$fa00$$ENDHEX$$ltimos ' + String (il_dias_utima_entrada) + ' dias);' + '<br>' + &

ls_anexo [1] = lvs_Path + ls_arquivo

If Not gf_ge202_envia_email_automatico (313, ls_titulo, ls_Msg, ls_anexo [], False) Then
	Return False
End if

Return True
end function

public subroutine of_mensagem_processo (string as_erro_msg);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

String	ls_Msg

s_email	lst_Email					

// PROCEDIMENTOS

ls_Msg =	'<b>ATEN$$HEX2$$c700c300$$ENDHEX$$O!!!!!'                 + '<br><br>' + &
			'<b>Baixa de produtos vencidos'   + '<br></b>' + &
			'<b>Sistema GEST$$HEX1$$c300$$ENDHEX$$O DE CATEGORIAS' + '<br></b>' + &
			'<b>Mensagem: ' + as_erro_msg     + '<br></b>'
			
lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

gf_ge202_envia_email_padrao (314, lst_Email)

Return
end subroutine

public function boolean of_cria_ds ();If not ids_filial.of_ChangeDataObject ('ds_ge621_filial') then
	Return False
End if

If not ids_prod_venc.of_ChangeDataObject ('ds_ge621_produto_vencido_baixa') then
	Return False
End if

If not ids_compras.of_ChangeDataObject ('ds_ge621_compras_recentes') then
	Return False
End if

If not ids_promocoes.of_ChangeDataObject ('ds_ge621_promocoes') then
	Return False
End if

If not ids_vendas.of_ChangeDataObject ('ds_ge621_vendas_recentes') then
	Return False
End if

If not ids_processados.of_ChangeDataObject ('ds_ge621_fil_prod_processados') then
	Return False
End if

Return True
end function

public function boolean of_atualiza_promocao_planograma (long al_filial, long al_produto);String ls_Erro

If not of_grava_historico_exclusao_planograma (al_filial, al_produto) then
	Return False
End if

DELETE FROM promocao_sos_estoque_minimo
 WHERE qt_estoque_minimo > 0 
	AND cd_filial         = :al_filial
	AND cd_produto        = :al_produto
	AND cd_promocao_sos   IN (SELECT cd_promocao_sos
										 FROM promocao_sos
										WHERE id_situacao = 'L'
										  AND id_tipo_promocao = 'P' 
										  AND cd_promocao_sap IS NULL
										  AND CAST (dh_termino AS DATE) >= CAST (GETDATE () AS DATE))
 USING SQLCA;

If SQLCA.SQLCode < 0 then
	ls_erro = SQLCA.SQLErrText
	SQLCA.of_RollBack ()
	of_mensagem_processo ('Erro ao atualizar o minimo promocao planograma ' + String (al_produto) + ' na filial ' + String (al_filial) + ': ' + ls_erro)
	Return False
End if

Return True
end function

public function boolean of_grava_historico_exclusao_planograma (long al_filial, long al_produto);DateTime	ldh_Alteracao
String	ls_Erro

ldh_Alteracao = gf_GetServerDate ()

INSERT INTO historico_promocao_estoque_min
		(	cd_promocao
		,	cd_filial
		,	cd_produto
		,	dh_alteracao
		,	qt_estoque_minimo_anterior
		,	qt_estoque_minimo_atual
		,  id_alterado_filial_atual
		,	id_tipo_alteracao
		,	nr_matricula_alteracao
		,	cd_motivo_alteracao
		)
	SELECT	cd_promocao_sos
			,	:al_Filial
			,	:al_Produto
			,	:ldh_Alteracao
			,	qt_estoque_minimo
			,  0
			,  'N'
			,	'D'
			,	'14330'
			,	49
	  FROM promocao_sos_estoque_minimo
	 WHERE qt_estoque_minimo > 0 
		AND cd_filial         = :al_filial
		AND cd_produto        = :al_produto
		AND cd_promocao_sos   IN (SELECT cd_promocao_sos
											 FROM promocao_sos
											WHERE id_situacao = 'L'
											  AND id_tipo_promocao = 'P' 
											  AND cd_promocao_sap IS NULL
											  AND CAST (dh_termino AS DATE) >= CAST (GETDATE () AS DATE))
 USING SQLCA;

If SQLCA.SQLCode = -1 Then
	ls_Erro = SQLCA.SQLErrText
	SQLCA.of_Rollback ()
	of_mensagem_processo ('Erro ao gravar o hist$$HEX1$$f300$$ENDHEX$$rico de exclus$$HEX1$$e300$$ENDHEX$$o de promo$$HEX2$$e700f500$$ENDHEX$$es do produto ' + String (al_Produto) + ' da filial ' + String (al_Filial) + ': ' + ls_Erro)
	Return False
End if

Return True
end function

on uo_ge621_baixa_venc_semvenda.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge621_baixa_venc_semvenda.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_filial      = Create dc_uo_ds_base
ids_prod_venc   = Create dc_uo_ds_base
ids_compras     = Create dc_uo_ds_base
ids_vendas      = Create dc_uo_ds_base
ids_promocoes   = Create dc_uo_ds_base
ids_processados = Create dc_uo_ds_base
end event

event destructor;Destroy ids_filial
Destroy ids_prod_venc
Destroy ids_compras
Destroy ids_vendas
Destroy ids_promocoes
Destroy ids_processados
end event

