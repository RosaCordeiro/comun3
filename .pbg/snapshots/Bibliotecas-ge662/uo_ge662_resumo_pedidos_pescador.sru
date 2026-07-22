HA$PBExportHeader$uo_ge662_resumo_pedidos_pescador.sru
forward
global type uo_ge662_resumo_pedidos_pescador from dc_uo_dw_base
end type
end forward

global type uo_ge662_resumo_pedidos_pescador from dc_uo_dw_base
end type
global uo_ge662_resumo_pedidos_pescador uo_ge662_resumo_pedidos_pescador

forward prototypes
public function boolean of_resumo_pedidos_pescador ()
public function boolean of_insere_registros (date adh_hoje, ref string as_msg)
public function boolean of_envia_email_log (string as_erro)
public function boolean of_envia_email_resumo (date adh_hoje, ref string as_msg)
end prototypes

public function boolean of_resumo_pedidos_pescador ();Boolean	lb_resultado

Date		ldt_Hoje

String	ls_msg

ldt_hoje = Date(gf_GetServerDate())

If Not gf_verifica_dias_uteis(1, ldt_Hoje, lb_resultado)  Then
	of_envia_email_log ('N$$HEX1$$e300$$ENDHEX$$o foi possivel fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o se $$HEX1$$e900$$ENDHEX$$ um dia $$HEX1$$fa00$$ENDHEX$$til')
	Return False
End if

If lb_resultado = False Then
	Return true
End if

If Not of_insere_registros(ldt_hoje,ls_msg) Then
	of_envia_email_log (ls_msg)
	Return False
End if

If Not of_envia_email_resumo(ldt_hoje,ls_msg) Then
	of_envia_email_log (ls_msg)
	Return False
End if


Return true
end function

public function boolean of_insere_registros (date adh_hoje, ref string as_msg);INSERT INTO resumo_pedido_dist (
	dh_emissao,
	qt_filiais_atendidas,
	qt_filiais_nao_atendidas,
	qt_pedidos_gerados_dist_r1,
	qt_demanda_solict_dist_r1,
	vl_demanda_solict_dist_r1,
	qt_demanda_rejeit_dist_r1,
	vl_demanda_rejeit_dist_r1,
	qt_pedidos_gerados_dist_r2,
	qt_demanda_solict_dist_r2,
	vl_demanda_solict_dist_r2,
	qt_demanda_rejeit_dist_r2,
	vl_demanda_rejeit_dist_r2,
	qt_pedidos_conexao,
	qt_demanda_conexao,
	vl_demanda_conexao
)
SELECT
	:adh_hoje,
	//Filiais Atendidas	
	(SELECT COUNT(DISTINCT cd_filial)
	 FROM pedido_filial pf
	 WHERE pf.dh_emissao = :adh_hoje
	   AND pf.id_rateio_estoque_central = 'X'
	   AND pf.id_geracao_matriz = 'S'),
		
	//Filiais N$$HEX1$$e300$$ENDHEX$$o Atendidas	   
	(SELECT COUNT(*) 
	 FROM filial f
	 WHERE f.id_aberta = 'S'
	   AND f.id_pedido_centralizado = 'S' 
	   AND NOT EXISTS (
		   SELECT 1 
		   FROM pedido_filial pf
		   WHERE pf.dh_emissao = :adh_hoje
			 AND pf.id_rateio_estoque_central = 'X'
			 AND pf.id_geracao_matriz = 'S'
			 AND pf.cd_filial = f.cd_filial)),
	
	//Pedidos Gerados para Distribuidoras (Rodada 1)
	(SELECT count(*) 
	 FROM pedido_distribuidora pd
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 1),
	 
	//Demanda Solicitada para Distribuidoras (Rodada 1) 
	(SELECT ISNULL(sum(qt_pedida), 0)
	 FROM pedido_distribuidora pd
	 INNER JOIN pedido_distribuidora_produto pdp
	 ON pd.cd_filial = pdp.cd_filial 
	 AND pd.nr_pedido_distribuidora = pdp.nr_pedido_distribuidora 
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pdp.qt_atendida > 0
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 1),
	 
	//Demanda Solicitada para Distribuidoras (Rodada 1) 
	(SELECT ROUND(ISNULL(sum(qt_pedida * vl_preco_unitario), 0), 2)
	 FROM pedido_distribuidora pd
	 INNER JOIN pedido_distribuidora_produto pdp
	 ON pd.cd_filial = pdp.cd_filial 
	 AND pd.nr_pedido_distribuidora = pdp.nr_pedido_distribuidora 
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pdp.qt_atendida > 0
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 1),
	
	//Demanda Rejeitada pelas Distribuidoras (Rodada 1)
	(SELECT ISNULL(sum(qt_pedida), 0)
	 FROM pedido_distribuidora pd
	 INNER JOIN pedido_distribuidora_produto pdp
	 ON pd.cd_filial = pdp.cd_filial 
	 AND pd.nr_pedido_distribuidora = pdp.nr_pedido_distribuidora 
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pdp.qt_atendida = 0
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 1),
	
	//Demanda Rejeitada pelas Distribuidoras (Rodada 1)
	(SELECT ROUND(ISNULL(sum(qt_pedida * vl_preco_unitario), 0), 2)
	 FROM pedido_distribuidora pd
	 INNER JOIN pedido_distribuidora_produto pdp
	 ON pd.cd_filial = pdp.cd_filial 
	 AND pd.nr_pedido_distribuidora = pdp.nr_pedido_distribuidora 
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pdp.qt_atendida = 0
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 1),
	
	//Pedidos Gerados para Distribuidoras (Rodada 2)
	(SELECT count(*) 
	 FROM pedido_distribuidora pd
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 2),
	 
	//Demanda Solicitada para Distribuidoras (Rodada 2) 
	(SELECT ISNULL(sum(qt_pedida), 0)
	 FROM pedido_distribuidora pd
	 INNER JOIN pedido_distribuidora_produto pdp
	 ON pd.cd_filial = pdp.cd_filial 
	 AND pd.nr_pedido_distribuidora = pdp.nr_pedido_distribuidora 
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pdp.qt_atendida > 0
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 2),
	 
	//Demanda Solicitada para Distribuidoras (Rodada 2) 
	(SELECT ROUND(ISNULL(sum(qt_pedida * vl_preco_unitario), 0), 2)
	 FROM pedido_distribuidora pd
	 INNER JOIN pedido_distribuidora_produto pdp
	 ON pd.cd_filial = pdp.cd_filial 
	 AND pd.nr_pedido_distribuidora = pdp.nr_pedido_distribuidora 
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pdp.qt_atendida > 0
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 2),
	 
	//Demanda Rejeitada pelas Distribuidoras (Rodada 2) 
	(SELECT ISNULL(sum(qt_pedida), 0)
	 FROM pedido_distribuidora pd
	 INNER JOIN pedido_distribuidora_produto pdp
	 ON pd.cd_filial = pdp.cd_filial 
	 AND pd.nr_pedido_distribuidora = pdp.nr_pedido_distribuidora 
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pdp.qt_atendida = 0
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 2),
	
	//Demanda Rejeitada pelas Distribuidoras (Rodada 2)
	(SELECT ROUND(ISNULL(sum(qt_pedida * vl_preco_unitario), 0), 2)
	 FROM pedido_distribuidora pd
	 INNER JOIN pedido_distribuidora_produto pdp
	 ON pd.cd_filial = pdp.cd_filial 
	 AND pd.nr_pedido_distribuidora = pdp.nr_pedido_distribuidora 
	 WHERE pd.dh_emissao = :adh_hoje
	 AND pd.id_situacao NOT IN ('X', 'J','N')
	 AND pdp.qt_atendida = 0
	 AND pd.cd_distribuidora NOT IN ('053404705')
	 AND pd.id_projeto_conexao IS NULL
	 AND pd.nr_rodada = 2),
	 
	 //Pedidos Gerados para Conex$$HEX1$$e300$$ENDHEX$$o	
	(SELECT count(*) 
	 FROM (SELECT pf.cd_filial, pf.nr_pedido_filial, pfp.id_projeto_conexao 
		   FROM pedido_filial pf 
		   INNER JOIN pedido_filial_produto pfp
		   ON pfp.cd_filial = pf.cd_filial 
		   AND pfp.nr_pedido_filial = pf.nr_pedido_filial 
		   WHERE pf.dh_emissao = :adh_hoje
		   AND pfp.id_projeto_conexao IS NOT NULL
		   AND EXISTS (SELECT 1 
					   FROM pedido_conexao pc 
					   WHERE pc.cd_filial = pfp.cd_filial 
					   AND pc.nr_pedido_filial = pfp.nr_pedido_filial 
					   AND pc.id_projeto_conexao = pfp.id_projeto_conexao 
					   AND pc.dh_envio IS NOT NULL)
		   GROUP BY pf.cd_filial, pf.nr_pedido_filial, pfp.id_projeto_conexao) AS pedido_conexao),
	
	//Demanda Solicitada para Conex$$HEX1$$e300$$ENDHEX$$o
	(SELECT ISNULL(sum(pfp.qt_pedida), 0)
	 FROM pedido_filial pf
	 INNER JOIN pedido_filial_produto pfp
	 ON pfp.cd_filial = pf.cd_filial 
	 AND pfp.nr_pedido_filial = pf.nr_pedido_filial 
	 INNER JOIN pedido_filial_distribuicao pfd
	 ON pfd.cd_filial = pfp.cd_filial 
	 AND pfd.nr_pedido_filial = pfp.nr_pedido_filial 
	 AND pfd.cd_produto = pfp.cd_produto 
	 WHERE pf.dh_emissao = :adh_hoje
	 AND pfd.nr_prioridade = 1
	 AND pfp.id_projeto_conexao IS NOT NULL
	 AND EXISTS (SELECT 1 
				FROM pedido_conexao pc 
				WHERE pc.cd_filial = pfp.cd_filial 
				AND pc.nr_pedido_filial = pfp.nr_pedido_filial 
				AND pc.id_projeto_conexao = pfp.id_projeto_conexao 
				AND pc.dh_envio IS NOT NULL)),
				
	//Demanda Solicitada para Conex$$HEX1$$e300$$ENDHEX$$o
	(SELECT ROUND(ISNULL(sum(pfp.qt_pedida * pfd.vl_preco_compra), 0), 2)
	 FROM pedido_filial pf
	 INNER JOIN pedido_filial_produto pfp
	 ON pfp.cd_filial = pf.cd_filial 
	 AND pfp.nr_pedido_filial = pf.nr_pedido_filial 
	 INNER JOIN pedido_filial_distribuicao pfd
	 ON pfd.cd_filial = pfp.cd_filial 
	 AND pfd.nr_pedido_filial = pfp.nr_pedido_filial 
	 AND pfd.cd_produto = pfp.cd_produto 
	 WHERE pf.dh_emissao = :adh_hoje
	 AND pfd.nr_prioridade = 1
	 AND pfp.id_projeto_conexao IS NOT NULL
	 AND EXISTS (SELECT 1 
				FROM pedido_conexao pc 
				WHERE pc.cd_filial = pfp.cd_filial 
				AND pc.nr_pedido_filial = pfp.nr_pedido_filial 
				AND pc.id_projeto_conexao = pfp.id_projeto_conexao 
				AND pc.dh_envio IS NOT NULL))

Using SqlCA;

Choose Case SqlCa.SqlCode

	Case -1
		as_msg = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da tabela resumo_pedido_dist! " + SqlCa.SqlErrText
		SQLCA.of_Rollback()
		Return False

	Case 0
		SQLCA.of_Commit()
		Return True
	
	Case 100
		SQLCA.of_Rollback()
		as_msg = "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros a serem atualizados !"
		Return False

End choose

Return True

end function

public function boolean of_envia_email_log (string as_erro);String lvs_data_envio
String ls_Texto_email
String ls_Texto01

s_email str 

ls_Texto01 = "Ocorreram erros na execu$$HEX2$$e700e300$$ENDHEX$$o da tarefa 340 - ES - VISUALIZACAO DE GERACAO DE PEDIDOS  "

lvs_data_envio = String ( RelativeDate (Date (gf_GetServerDate()),-0), "yyyy-mm-dd")
		
ls_Texto_Email = 	"<HTML>"+&
										"<BODY>"+&
										"<BR>"+&										
										"<TABLE border=0>"+&
										"<TR>"+& 
										"<TD>" + ls_Texto01 + "</TD>"+&	
										"</TR>"+& 									
										"<TR>"+& 
										"<TD>" + as_erro + "</TD>"+&	
										"</TR>"										

ls_Texto_Email		= ls_Texto_Email +"</TABLE></BODY></HTML>" 
str.ps_Mensagem	= ls_Texto_Email	
str.pb_Assinatura	= True
gf_ge202_envia_email_padrao(340, str)

Return True 
end function

public function boolean of_envia_email_resumo (date adh_hoje, ref string as_msg);Decimal	ldc_Vl_Demanda_conexao		
Decimal	ldc_Vl_Demanda_sol_dist_r1	
Decimal	ldc_Vl_Demanda_rej_dist_r1	
Decimal	ldc_Vl_Demanda_sol_dist_r2	
Decimal	ldc_Vl_Demanda_rej_dist_r2	

Long	ll_Qt_Pedidos_gerados_dist_r1
Long	ll_Qt_Demanda_sol_dist_r1	
Long	ll_Qt_Demanda_rej_dist_r1	
Long	ll_Qt_Pedidos_gerados_dist_r2
Long	ll_Qt_Demanda_sol_dist_r2	
Long	ll_Qt_Demanda_rej_dist_r2	
Long	ll_Qt_Pedidos_conexao		
Long	ll_Qt_Demanda_conexao
Long	ll_Qt_Filiais_atendidas
Long	ll_Qt_Filiais_nao_atendidas

String	ls_Texto_email
String	ls_Titulo
String	ls_Data

String	ls_Demanda_Sol_R1
String	ls_Demanda_Rej_R1
String	ls_Demanda_Sol_R2
String	ls_Demanda_Rej_R2
String	ls_Demanda_Conexao

String	ls_Obs_Sol_R1
String	ls_Obs_Rej_R1
String	ls_Obs_Sol_R2
String	ls_Obs_Rej_R2
String	ls_Obs_Conexao_Ped
String	ls_Obs_Conexao_Dem

s_email	str	

ls_Titulo = "Consolidador de Pedidos para Distribuidoras"

ls_Texto_Email =	"<HTML>" + &
				"<BODY style='font-family: Arial, sans-serif; font-size: 12px;'>" + &
				"<H3 style='margin-bottom: 5px;'>" + ls_Titulo + " " + string(adh_hoje) + "</H3>" + &
				"<BR/>" + &
				"<TABLE border='1' cellpadding='5' style='border-collapse: collapse; width: auto;'>" + &
				"<TR style='background-color: #f2f2f2;'>" + &
				"<TH style='text-align: left; width: 40%;'>Indicador</TH>" + &
				"<TH style='text-align: left; width: 20%;'>Valor</TH>" + &
				"<TH style='text-align: left; width: 40%;'>Observa$$HEX2$$e700f500$$ENDHEX$$es</TH>" + &
				"</TR>"

dc_uo_ds_base lds_resumo_pescador
lds_resumo_pescador = Create dc_uo_ds_base
lds_resumo_pescador.Of_ChangeDataObject('ds_ge662_resumo_pedidos_pescador')
lds_resumo_pescador.Retrieve(adh_hoje)

ll_Qt_Filiais_atendidas				= lds_resumo_pescador.Object.qt_filiais_atendidas			[1]
ll_Qt_Filiais_nao_atendidas		= lds_resumo_pescador.Object.qt_filiais_nao_atendidas		[1]
ll_Qt_Pedidos_gerados_dist_r1		= lds_resumo_pescador.Object.qt_pedidos_gerados_dist_r1	[1]
ll_Qt_Demanda_sol_dist_r1			= lds_resumo_pescador.Object.qt_demanda_solict_dist_r1	[1]
ldc_Vl_Demanda_sol_dist_r1			= lds_resumo_pescador.Object.vl_demanda_solict_dist_r1	[1]
ll_Qt_Demanda_rej_dist_r1			= lds_resumo_pescador.Object.qt_demanda_rejeit_dist_r1	[1]
ldc_Vl_Demanda_rej_dist_r1			= lds_resumo_pescador.Object.vl_demanda_rejeit_dist_r1	[1]	
ll_Qt_Pedidos_gerados_dist_r2		= lds_resumo_pescador.Object.qt_pedidos_gerados_dist_r2	[1]
ll_Qt_Demanda_sol_dist_r2			= lds_resumo_pescador.Object.qt_demanda_solict_dist_r2	[1]
ldc_Vl_Demanda_sol_dist_r2			= lds_resumo_pescador.Object.vl_demanda_solict_dist_r2	[1]	
ll_Qt_Demanda_rej_dist_r2			= lds_resumo_pescador.Object.qt_demanda_rejeit_dist_r2	[1]
ldc_Vl_Demanda_rej_dist_r2			= lds_resumo_pescador.Object.vl_demanda_rejeit_dist_r2	[1]
ll_Qt_Pedidos_conexao				= lds_resumo_pescador.Object.qt_pedidos_conexao				[1]
ll_Qt_Demanda_conexao				= lds_resumo_pescador.Object.qt_demanda_conexao				[1]
ldc_Vl_Demanda_conexao				= lds_resumo_pescador.Object.vl_demanda_conexao				[1]

ls_Obs_Sol_R1 = "Aumento da demanda acima de x% (y%)"
ls_Obs_Rej_R1 = "Aumento da demanda acima de x% (y%)"
ls_Obs_Sol_R2 = "Aumento da demanda acima de x% (y%)"
ls_Obs_Rej_R2 = "Aumento da demanda acima de x% (y%)"
ls_Obs_Conexao_Ped = "Diminui$$HEX2$$e700e300$$ENDHEX$$o da demanda abaixo de x% (y%)"
ls_Obs_Conexao_Dem = "Diminui$$HEX2$$e700e300$$ENDHEX$$o da demanda abaixo de x% (y%)"

ls_Demanda_Sol_R1		= String(ll_Qt_Demanda_sol_dist_r1, "#,##0") + " / R$ " + String(ldc_Vl_Demanda_sol_dist_r1, "#,##0.00")
ls_Demanda_Rej_R1		= String(ll_Qt_Demanda_rej_dist_r1, "#,##0") + " / R$ " + String(ldc_Vl_Demanda_rej_dist_r1, "#,##0.00")
ls_Demanda_Sol_R2		= String(ll_Qt_Demanda_sol_dist_r2, "#,##0") + " / R$ " + String(ldc_Vl_Demanda_sol_dist_r2, "#,##0.00")
ls_Demanda_Rej_R2		= String(ll_Qt_Demanda_rej_dist_r2, "#,##0") + " / R$ " + String(ldc_Vl_Demanda_rej_dist_r2, "#,##0.00")
ls_Demanda_Conexao	= String(ll_Qt_Demanda_conexao, "#,##0") + " / R$ " + String(ldc_Vl_Demanda_conexao, "#,##0.00")

ls_Texto_Email += "<TR>" + &
				"<TD style='padding: 5px'>Filiais Atendidas</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + String(ll_Qt_Filiais_atendidas, "#,##0") + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de filiais que tiveram pedidos gerados no dia</TD>" + &
				"</TR>" + &				  
				"<TR>" + &
				"<TD style='padding: 5px'>Filiais N$$HEX1$$e300$$ENDHEX$$o Atendidas</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + String(ll_Qt_Filiais_nao_atendidas, "#,##0") + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de filiais que n$$HEX1$$e300$$ENDHEX$$o tiveram pedidos gerados no dia</TD>" + &
				"</TR>" + &				
				"<TR>" + &
				"<TD style='padding: 5px'>Pedidos Gerados para Distribuidoras (Rodada 1)</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + String(ll_Qt_Pedidos_gerados_dist_r1, "#,##0") + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de pedidos Gerados para as Distribuidoras apenas na Rodada 01</TD>" + &
				"</TR>" + &			  
				"<TR>" + &
				"<TD style='padding: 5px'>Demanda Solicitada para Distribuidoras (Rodada 1)</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + ls_Demanda_Sol_R1 + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de pedidos realizados as distribuidoras Rodada 01/ Valor total</TD>" + &
				"</TR>" + &
				"<TR>" + &
				"<TD style='padding: 5px'>Demanda Rejeitada pelas Distribuidoras (Rodada 1)</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + ls_Demanda_Rej_R1 + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de pedidos rejeitados a distribuidoras Rodada 01/ Valor total</TD>" + &
				"</TR>" + &
				"<TR>" + &
				"<TD style='padding: 5px'>Pedidos Gerados para Distribuidoras (Rodada 2)</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + String(ll_Qt_Pedidos_gerados_dist_r2, "#,##0") + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de pedidos Gerados para as Distribuidoras apenas na Rodada 02</TD>" + &
				"</TR>" + &
				"<TR>" + &
				"<TD style='padding: 5px'>Demanda Solicitada para Distribuidoras (Rodada 2)</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + ls_Demanda_Sol_R2 + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de pedidos realizados as distribuidoras Rodada 02/ Valor total</TD>" + &
				"</TR>" + &
				"<TR>" + &
				"<TD style='padding: 5px'>Demanda Rejeitada pelas Distribuidoras (Rodada 2)</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + ls_Demanda_Rej_R2 + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de pedidos rejeitados a distribuidoras Rodada 02/ Valor total</TD>" + &
				"</TR>" + &
				"<TR>" + &
				"<TD style='padding: 5px'>Pedidos Gerados para Conex$$HEX1$$e300$$ENDHEX$$o</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + String(ll_Qt_Pedidos_conexao, "#,##0") + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de Pedidos Gerados para o projeto Conex$$HEX1$$e300$$ENDHEX$$o</TD>" + &
				"</TR>" + &
				"<TR>" + &
				"<TD style='padding: 5px'>Demanda Solicitada para Conex$$HEX1$$e300$$ENDHEX$$o</TD>" + &
				"<TD style='padding: 5px; text-align: left'>" + ls_Demanda_Conexao + "</TD>" + &
				"<TD style='padding: 5px'>Quantidade de pedidos gerados ao projeto conex$$HEX1$$e300$$ENDHEX$$o/ Valor total</TD>" + &
				"</TR>"

ls_Texto_Email += "</TABLE></BODY></HTML>" 

Destroy lds_resumo_pescador

str.ps_Mensagem	= ls_Texto_Email	
str.pb_Assinatura	= True
gf_ge202_envia_email_padrao(351, str)

Return true
end function

on uo_ge662_resumo_pedidos_pescador.create
call super::create
end on

on uo_ge662_resumo_pedidos_pescador.destroy
call super::destroy
end on

