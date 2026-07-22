HA$PBExportHeader$w_ge568_produto_compra_bloqueio.srw
forward
global type w_ge568_produto_compra_bloqueio from dc_w_2tab_cadastro_selecao_lista_det
end type
end forward

global type w_ge568_produto_compra_bloqueio from dc_w_2tab_cadastro_selecao_lista_det
string tag = "w_ge568_produto_compra_bloqueio"
integer width = 5595
integer height = 2188
string title = "GE568 - Bloqueio de Produtos"
boolean ivb_valida_salva = true
boolean ivb_grava_log = true
long ivl_altura_1 = 2008
long ivl_altura_2 = 2008
long ivl_largura_1 = 5559
long ivl_largura_2 = 5559
end type
global w_ge568_produto_compra_bloqueio w_ge568_produto_compra_bloqueio

type variables
uo_produto ivo_produto

uo_unidade_federacao ivo_uf

string is_Produto
end variables

forward prototypes
public subroutine wf_insere_grupo_default ()
public subroutine wf_insere_lei_generico_default ()
public subroutine wf_insere_uf_default ()
public function boolean wf_update_pc_limite_geral ()
public subroutine wf_insere_rede_default ()
public function boolean wf_verifica_configuracao_existe (long al_linha, ref boolean ab_existe)
public subroutine _documentacao ()
public function boolean wf_proximo_codigo (ref long al_proximo_codigo)
public function boolean wf_busca_descricao_produto (long al_cd_produto, ref string as_de_produto)
public function boolean wf_busca_descricao_uf (string as_cd_uf, ref string as_nm_uf)
public function boolean wf_busca_descricao_rede (string as_id_rede_filial, ref string as_nm_rede_filial)
public function boolean wf_importa_dados_planilha ()
end prototypes

public subroutine wf_insere_grupo_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If tab_1.tabpage_1.dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_grupo", "X")
	lvdwc.SetItem(1, "de_grupo", "TODOS")
	
	tab_1.tabpage_1.dw_1.Object.Cd_grupo[1] = "X"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Grupo.")
End If

end subroutine

public subroutine wf_insere_lei_generico_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If tab_1.tabpage_1.dw_1.GetChild("id_lei_generico", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "id_lei_generico", "X")
	lvdwc.SetItem(1, "de_lei_generico", "TODOS")
	
	tab_1.tabpage_1.dw_1.Object.id_lei_generico[1] = "X"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Lei Gen$$HEX1$$e900$$ENDHEX$$rico")
End If
end subroutine

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If tab_1.tabpage_1.dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	tab_1.tabpage_1.dw_1.Object.Cd_UF[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

public function boolean wf_update_pc_limite_geral ();decimal	lvdc_pc_limite_geral
string	lvs_msg

if tab_1.tabpage_2.dw_3.rowcount() > 0 then
	
	lvdc_pc_limite_geral = tab_1.tabpage_2.dw_3.getitemdecimal(1, 'pc_limite_geral')
	
	if lvdc_pc_limite_geral < 85 then
		Messagebox('Erro', 'O percentual de limite de pre$$HEX1$$e700$$ENDHEX$$o geral deve ser igual ou superior a 85%. ', stopsign!)
		return false
	end if
	  
	update parametro_geral
		set vl_parametro = convert(varchar, str_replace(:lvdc_pc_limite_geral,'.',','))
	 where cd_parametro = 'PC_LIMITE_ACEITE_PRECO_DISTRIB';
	
	if sqlca.sqlcode = -1 then
		lvs_msg = sqlca.sqlerrtext
	//	sqlca.of_rollback( ) 
		Messagebox('Erro', 'Erro ao buscar o percentual de limite de pre$$HEX1$$e700$$ENDHEX$$o geral. ' + lvs_msg)
		return false
	end if 

end if
	
return true

end function

public subroutine wf_insere_rede_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If tab_1.tabpage_1.dw_1.GetChild("id_rede_filial", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "id_rede_filial", "XX")
	lvdwc.SetItem(1, "nm_rede_filial", "TODAS")
	
	tab_1.tabpage_1.dw_1.Object.id_rede_filial[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da Rede Filial")
End If

end subroutine

public function boolean wf_verifica_configuracao_existe (long al_linha, ref boolean ab_existe);// funcao para verificar se ja existe registro com as mesmas configuracoes de bloqueio que o registro que esta sendo incluido/alterado

string	lvs_CRLF = char(13) + char(10), &
			lvs_cd_uf_atual, &
			lvs_id_rede_filial_atual, &
			lvs_id_lei_generico_atual, &
			lvs_cd_grupo_atual, &
			lvs_cd_bloqueio_lista, &
			lvs_sql, &
			lvs_id_existe, &
			lvs_cd_grupo, &
			lvs_cd_uf, &
			lvs_id_rede_filial, &
			lvs_id_lei_generico
			
long 		lvl_cd_produto_atual, &
			lvl_cd_bloqueio_atual, &
			lvl_cd_bloqueio, &
			lvl_cd_produto, &
			i

datetime lvdt_inicio_atual, &
			lvdt_termino_atual, &
			lvdt_inicio, &
			lvdt_termino
			
ab_existe = false

lvl_cd_bloqueio_atual   	= tab_1.tabpage_1.dw_2.object.cd_bloqueio[al_linha]
lvs_cd_grupo_atual 			= tab_1.tabpage_1.dw_2.object.cd_grupo[al_linha]
lvs_cd_uf_atual				= tab_1.tabpage_1.dw_2.object.cd_unidade_federacao[al_linha]
lvs_id_rede_filial_atual	= tab_1.tabpage_1.dw_2.object.id_rede_filial[al_linha]
lvs_id_lei_generico_atual	= tab_1.tabpage_1.dw_2.object.id_lei_generico[al_linha]
lvl_cd_produto_atual			= tab_1.tabpage_1.dw_2.object.cd_produto[al_linha]
lvdt_inicio_atual				= tab_1.tabpage_1.dw_2.object.dh_inicio[al_linha]
lvdt_termino_atual			= tab_1.tabpage_1.dw_2.object.dh_termino[al_linha]

if isnull(lvs_cd_grupo_atual) 			then lvs_cd_grupo_atual = ''
if isnull(lvs_cd_uf_atual)					then lvs_cd_uf_atual = ''
if isnull(lvs_id_rede_filial_atual)		then lvs_id_rede_filial_atual = ''
if isnull(lvs_id_lei_generico_atual)	then lvs_id_lei_generico_atual = ''
if isnull(lvl_cd_produto_atual)			then lvl_cd_produto_atual = 0

if not isnull(lvl_cd_bloqueio_atual) then lvs_cd_bloqueio_lista += string(lvl_cd_bloqueio_atual) + ','

//primeiro, verifica nos registros da propria datawindow se existe registro com os mesmos criterios de bloqueio e com vigencia igual ou intercalada
for i = 1 to tab_1.tabpage_1.dw_2.rowcount()
	if i <> al_linha then

		// compara somente com registros onde data de termino $$HEX1$$e900$$ENDHEX$$ maior ou igual a data atual, ou seja, registros em vigencia ou que serao vigentes no futuro
		if string(tab_1.tabpage_1.dw_2.object.dh_termino[i],'yyyymmdd') >= string(today(),'yyyymmdd') then
			
			lvl_cd_bloqueio      = tab_1.tabpage_1.dw_2.object.cd_bloqueio[i]

			lvs_cd_grupo 			= tab_1.tabpage_1.dw_2.object.cd_grupo[i]
			lvs_cd_uf				= tab_1.tabpage_1.dw_2.object.cd_unidade_federacao[i]
			lvs_id_rede_filial	= tab_1.tabpage_1.dw_2.object.id_rede_filial[i]
			lvs_id_lei_generico	= tab_1.tabpage_1.dw_2.object.id_lei_generico[i]
			lvl_cd_produto			= tab_1.tabpage_1.dw_2.object.cd_produto[i]

			if isnull(lvs_cd_grupo) 			then lvs_cd_grupo = ''
			if isnull(lvs_cd_uf)					then lvs_cd_uf = ''
			if isnull(lvs_id_rede_filial)		then lvs_id_rede_filial = ''
			if isnull(lvs_id_lei_generico)	then lvs_id_lei_generico = ''
			if isnull(lvl_cd_produto)			then lvl_cd_produto = 0

			if  lvl_cd_produto_atual		= lvl_cd_produto &
			and lvs_cd_grupo_atual        = lvs_cd_grupo &
			and lvs_id_rede_filial_atual	= lvs_id_rede_filial &
			and lvs_id_lei_generico_atual	= lvs_id_lei_generico &
			and lvs_cd_uf_atual				= lvs_cd_uf &
			and (  (lvdt_inicio_atual  >= tab_1.tabpage_1.dw_2.object.dh_inicio[i] and lvdt_inicio_atual  <= tab_1.tabpage_1.dw_2.object.dh_termino[i]) &
				 or (lvdt_termino_atual >= tab_1.tabpage_1.dw_2.object.dh_inicio[i] and lvdt_termino_atual <= tab_1.tabpage_1.dw_2.object.dh_termino[i]) &
				 or (lvdt_inicio_atual  <= tab_1.tabpage_1.dw_2.object.dh_inicio[i] and lvdt_termino_atual >= tab_1.tabpage_1.dw_2.object.dh_termino[i])  ) &
			then
				ab_existe = true
				tab_1.tabpage_1.dw_2.setrow(al_linha)
				tab_1.tabpage_1.dw_2.scrolltorow(al_linha)
				Messagebox('Configura$$HEX2$$e700e300$$ENDHEX$$o de Bloqueio', 'J$$HEX1$$e100$$ENDHEX$$ existe uma ou mais configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio com os mesmos crit$$HEX1$$e900$$ENDHEX$$rios e com vig$$HEX1$$ea00$$ENDHEX$$ncia igual ou sobreposta $$HEX1$$e000$$ENDHEX$$ vig$$HEX1$$ea00$$ENDHEX$$ncia selecionada.' + lvs_CRLF + &
								'Produto:'        + string(lvl_cd_produto_atual) + lvs_CRLF + &
								'Grupo: '         + lvs_cd_grupo_atual           + lvs_CRLF + &
								'Rede: '          + lvs_id_rede_filial_atual     + lvs_CRLF + &
								'UF: '            + lvs_cd_uf_atual              + lvs_CRLF + &
								'Lei Generico: '  + lvs_id_lei_generico_atual    + lvs_CRLF + &
								'In$$HEX1$$ed00$$ENDHEX$$cio: '        + string(lvdt_inicio_atual,  'dd/mm/yyyy') + lvs_CRLF + &
								'T$$HEX1$$e900$$ENDHEX$$rmino: '       + string(lvdt_termino_atual, 'dd/mm/yyyy'), stopsign! )
				return true
			end if
			
			if not isnull(lvl_cd_bloqueio) then lvs_cd_bloqueio_lista += string(lvl_cd_bloqueio) + ','
		end if
	end if
next

if lvs_cd_bloqueio_lista <> '' then 
	//remove ultima virgula
	lvs_cd_bloqueio_lista = left(lvs_cd_bloqueio_lista, len(lvs_cd_bloqueio_lista) - 1)
	lvs_cd_bloqueio_lista = '(' + lvs_cd_bloqueio_lista + ')'
end if

// verifica diretamente na tabela se existe registro com os mesmos criterios de bloqueio e com vigencia igual ou intercalada
lvs_sql = "select top 1 'S' as id_existe, p.dh_inicio, p.dh_termino &
  from produto_compra_bloqueio p &
 where coalesce(p.cd_produto,0)            = "+string(lvl_cd_produto_atual) + "&
	and coalesce(p.cd_grupo,'')             = '"+lvs_cd_grupo_atual+"' &
	and coalesce(p.id_rede_filial,'')       = '"+lvs_id_rede_filial_atual +"' &
	and coalesce(p.id_lei_generico,'')      = '"+lvs_id_lei_generico_atual +"' &
	and coalesce(p.cd_unidade_federacao,'') = '"+lvs_cd_uf_atual +"'&
	and convert(varchar, p.dh_termino, 102) >= convert(varchar, getdate(), 102) &
	and (  ('"+string(lvdt_inicio_atual, 'yyyy.mm.dd')+"' >= p.dh_inicio and '"+string(lvdt_inicio_atual, 'yyyy.mm.dd')+"' <= p.dh_termino) &
		 or ('"+string(lvdt_termino_atual,'yyyy.mm.dd')+"' >= p.dh_inicio and '"+string(lvdt_termino_atual,'yyyy.mm.dd')+"' <= p.dh_termino) &
		 or ('"+string(lvdt_inicio_atual, 'yyyy.mm.dd')+"' <= p.dh_inicio and '"+string(lvdt_termino_atual,'yyyy.mm.dd')+"' >= p.dh_termino)  ) "
 
// retira da verifica$$HEX2$$e700e300$$ENDHEX$$o os registros que foram testados na datawindow.
if lvs_cd_bloqueio_lista <> '' then
	lvs_sql += " and p.cd_bloqueio not in " + lvs_cd_bloqueio_lista
end if

DECLARE cr_cur DYNAMIC CURSOR FOR SQLSA ;
PREPARE SQLSA FROM :lvs_sql;
OPEN DYNAMIC cr_cur;
fetch cr_cur into :lvs_id_existe, :lvdt_inicio, :lvdt_termino;
close cr_cur;

if lvs_id_existe = 'S' then
	ab_existe = true
	tab_1.tabpage_1.dw_2.setrow(al_linha)
	tab_1.tabpage_1.dw_2.scrolltorow(al_linha)
	Messagebox('Configura$$HEX2$$e700e300$$ENDHEX$$o de Bloqueio', 'J$$HEX1$$e100$$ENDHEX$$ existe uma ou mais configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio com os mesmos crit$$HEX1$$e900$$ENDHEX$$rios e com vig$$HEX1$$ea00$$ENDHEX$$ncia igual ou sobreposta $$HEX1$$e000$$ENDHEX$$ vig$$HEX1$$ea00$$ENDHEX$$ncia selecionada.' + lvs_CRLF + &
					'Produto:'        + string(lvl_cd_produto_atual) + lvs_CRLF + &
					'Grupo: '         + lvs_cd_grupo_atual           + lvs_CRLF + &
					'Rede: '          + lvs_id_rede_filial_atual     + lvs_CRLF + &
					'UF: '            + lvs_cd_uf_atual              + lvs_CRLF + &
					'Lei Generico: '  + lvs_id_lei_generico_atual    + lvs_CRLF + &
					'In$$HEX1$$ed00$$ENDHEX$$cio: '        + string(lvdt_inicio_atual,  'dd/mm/yyyy') + lvs_CRLF + &
					'T$$HEX1$$e900$$ENDHEX$$rmino: '       + string(lvdt_termino_atual, 'dd/mm/yyyy'), stopsign! )
	return true
end if

return true

end function

public subroutine _documentacao ();// GE568 - Bloqueio de Produtos
// Interface que mantem as configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio de produtos 
/* 

Na primeira aba desta interface, ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel criar configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio de pre$$HEX1$$e700$$ENDHEX$$os por produto, grupo, Rede, UF e Lei Gen$$HEX1$$e900$$ENDHEX$$rico, 
por um per$$HEX1$$ed00$$ENDHEX$$odo de vig$$HEX1$$ea00$$ENDHEX$$ncia, definindo o percentual de limite de pre$$HEX1$$e700$$ENDHEX$$o de compra para os produtos que se encaixam nos crit$$HEX1$$e900$$ENDHEX$$rios da configura$$HEX2$$e700e300$$ENDHEX$$o
de bloqueio. 

Estas configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio ser$$HEX1$$e300$$ENDHEX$$o utilizadas para bloquear os pedidos junto $$HEX1$$e000$$ENDHEX$$s distribuidoras onde o pre$$HEX1$$e700$$ENDHEX$$o de compra ultrapassar o percentual definido na configura$$HEX2$$e700e300$$ENDHEX$$o.

Ao criar uma configura$$HEX2$$e700e300$$ENDHEX$$o de bloqueio, ser$$HEX1$$e100$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio selecionar um ao menos o crit$$HEX1$$e900$$ENDHEX$$rio Produto ou o cirt$$HEX1$$e900$$ENDHEX$$rio Grupo (apenas 1 deles, nunca os 2 ao mesmo tempo). 
Feito isso, ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel restringir a configura$$HEX2$$e700e300$$ENDHEX$$o de bloqueio por Rede, UF ou Lei Gen$$HEX1$$e900$$ENDHEX$$rico. 

$$HEX1$$c900$$ENDHEX$$ possivel, por exemplo, cadastrar:

 - uma configura$$HEX2$$e700e300$$ENDHEX$$o de bloqueio para o produto 636
 - e outra configura$$HEX2$$e700e300$$ENDHEX$$o para o grupo Medicamento. 

Sabendo que o produto em quest$$HEX1$$e300$$ENDHEX$$o pertence ao grupo Medicamento, ambas as configura$$HEX2$$e700f500$$ENDHEX$$es de percentual poderiam impactar este produto. 
Neste caso, o sistema dar$$HEX1$$e100$$ENDHEX$$ prioridade para a configura$$HEX2$$e700e300$$ENDHEX$$o de bloqueio por produto, que $$HEX1$$e900$$ENDHEX$$ a configura$$HEX2$$e700e300$$ENDHEX$$o mais individualizada/restritiva, 
para definir o percentual de bloqueio para o produto 636.

No caso de haver duas configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio 
 - uma com o criterio produto selecionado
 - e outra com os crit$$HEX1$$e900$$ENDHEX$$rios Produto e Rede selecionado
 
Neste caso , o sistema dar$$HEX1$$e100$$ENDHEX$$ prioridade para esta $$HEX1$$fa00$$ENDHEX$$ltima, pois ela possui crit$$HEX1$$e900$$ENDHEX$$rios de bloqueio mais restritivos em rela$$HEX2$$e700e300$$ENDHEX$$o a primeira

Se o primeiro criterio para a configura$$HEX2$$e700e300$$ENDHEX$$o de bloqueio for um produto, o crit$$HEX1$$e900$$ENDHEX$$rio Lei Generico automaticamente ser$$HEX1$$e100$$ENDHEX$$ desabilitado, pois n$$HEX1$$e300$$ENDHEX$$o faz sentido 
escolher ambos os crit$$HEX1$$e900$$ENDHEX$$rios ao mesmo tempo.

Ao cadastrar um novo crit$$HEX1$$e900$$ENDHEX$$rio de bloqueio, inicialmente somente os campos Produto e Grupo estar$$HEX1$$e300$$ENDHEX$$o disponiveis para sele$$HEX2$$e700e300$$ENDHEX$$o. Ap$$HEX1$$f300$$ENDHEX$$s escolher um deles, o campos imediatamente
a direita ficar$$HEX1$$e300$$ENDHEX$$o disponiveis para serem utilizados como crit$$HEX1$$e900$$ENDHEX$$rio de bloqueio.

O sistema permitira cadastrar duas configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio iguais, porem o inicio e termino da vigencia n$$HEX1$$e300$$ENDHEX$$o podem se sobrepor.

Na segunda aba da interface, ser$$HEX1$$e100$$ENDHEX$$ possivel manter o percentual geral de limite de pre$$HEX1$$e700$$ENDHEX$$os. Este percentual sera utilizado sempre que n$$HEX1$$e300$$ENDHEX$$o houver uma configura$$HEX2$$e700e300$$ENDHEX$$o de bloqueio mais 
restritiva.
*/

end subroutine

public function boolean wf_proximo_codigo (ref long al_proximo_codigo);long ll_Linha

Select Max(cd_bloqueio) 
  Into :al_Proximo_Codigo
  From produto_compra_bloqueio
 using sqlca;

if sqlca.sqlcode = -1 then
	Messagebox('Erro', 'Erro ao buscar pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo de bloqueio.' + sqlca.sqlerrtext, stopsign!)
	return false
end if

If IsNull(al_Proximo_Codigo) Then
	al_Proximo_Codigo = 0
End If

al_Proximo_Codigo += 1

Return true

end function

public function boolean wf_busca_descricao_produto (long al_cd_produto, ref string as_de_produto);select de_produto + ' ' + de_apresentacao_estoque
  into :as_de_produto
  from produto_geral
 where cd_produto = :al_cd_produto;

if sqlca.sqlcode = -1 or sqlca.sqlcode = 100 then return false

return true
end function

public function boolean wf_busca_descricao_uf (string as_cd_uf, ref string as_nm_uf);select nm_unidade_federacao
  into :as_nm_uf
  from unidade_federacao
 where cd_unidade_federacao = :as_cd_uf;

if sqlca.sqlcode = -1 or sqlca.sqlcode = 100 then return false

return true
end function

public function boolean wf_busca_descricao_rede (string as_id_rede_filial, ref string as_nm_rede_filial);select nm_rede_filial
  into :as_nm_rede_filial
  from rede_filial
 where id_rede_filial = :as_id_rede_filial;

if sqlca.sqlcode = -1 or sqlca.sqlcode = 100 then return false

return true
end function

public function boolean wf_importa_dados_planilha ();string	ls_Nulo, &
			ls_cd_produto, &
			ls_cd_uf, &
			ls_id_rede_filial, &
			ls_de_produto, &
			ls_nm_uf, &
			ls_nm_rede_filial, &
			ls_retorno

long 		ll_nulo, &
			ll_row

Decimal	ldc_pc_limite

Date		ldh_termino, &
			ldh_inicio

setnull(ls_nulo)
setnull(ll_nulo)

OpenWithParm(w_ge568_inclusao_via_planilha, '')

ls_retorno = Message.StringParm

If Trim(ls_retorno) = "" Or IsNull(ls_retorno) Then
	Return false
End If
		
ldh_inicio    = date(left(ls_retorno, pos(ls_retorno, ';') - 1))
ls_retorno    = mid(ls_retorno, pos(ls_retorno, ';') + 1)
ldh_termino   = date(left(ls_retorno, pos(ls_retorno, ';') - 1))
ls_retorno    = mid(ls_retorno, pos(ls_retorno, ';') + 1)

ldc_pc_limite = dec(left(ls_retorno, pos(ls_retorno, ';') - 1))
ls_retorno    = mid(ls_retorno, pos(ls_retorno, ';') + 1)

do while ls_retorno <> ''
	
	ls_cd_produto = trim(left(ls_retorno, pos(ls_retorno, ',') - 1))
	ls_retorno    = trim(mid(ls_retorno, pos(ls_retorno, ',') + 1, len(ls_retorno)))				

	ls_id_rede_filial = trim(left(ls_retorno, pos(ls_retorno, ',') - 1))
	ls_retorno    = trim(mid(ls_retorno, pos(ls_retorno, ',') + 1, len(ls_retorno)))				
	
	ls_cd_uf      = trim(left(ls_retorno, pos(ls_retorno, ',') - 1))
	ls_retorno    = trim(mid(ls_retorno, pos(ls_retorno, ',') + 1, len(ls_retorno)))				

	// o ultimo campo $$HEX1$$e900$$ENDHEX$$ a distribuidora, utilizada somente no desbloqueio, portanto ignora aqui, apenas remove a proxima virgula da string
	if pos(ls_retorno, ',') > 0 then
		//ls_cd_distribuidora = trim(left(ls_retorno, pos(ls_retorno, ',') - 1))
		ls_retorno    = trim(mid(ls_retorno, pos(ls_retorno, ',') + 1, len(ls_retorno)))				
	else
		//ls_cd_distribuidora = trim(ls_retorno)
		ls_retorno = ''
	end if

	ll_row = tab_1.tabpage_1.dw_2.event ue_addrow()
	
	If not wf_busca_descricao_produto(long(ls_cd_produto), ref ls_de_produto) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'C$$HEX1$$f300$$ENDHEX$$digo de Produto ' + ls_cd_produto + ' n$$HEX1$$e300$$ENDHEX$$o encontrado no cadastro. ', stopsign!)
		close(w_Aguarde)
		return false
	End If

	tab_1.tabpage_1.dw_2.Object.Cd_Produto[ll_row] = long(ls_Cd_Produto)
	tab_1.tabpage_1.dw_2.Object.De_Produto[ll_row] = ls_de_produto
	
	if ls_id_rede_filial <> '' then
		tab_1.tabpage_1.dw_2.Object.id_rede_filial[ll_row] = ls_id_rede_filial
	end if
	
	if ls_cd_uf <> '' then
		If not wf_busca_descricao_uf(ls_cd_uf, ref ls_nm_uf) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'UF ' + ls_cd_uf + ' n$$HEX1$$e300$$ENDHEX$$o encontrada no cadastro. ', stopsign!)
			close(w_Aguarde)
			return false
		End If

		tab_1.tabpage_1.dw_2.Object.Cd_unidade_federacao[ll_row] = ls_cd_uf
		tab_1.tabpage_1.dw_2.Object.nm_unidade_federacao[ll_row] = ls_nm_uf
	end if
	
	tab_1.tabpage_1.dw_2.Object.dh_inicio[ll_row] = datetime(ldh_inicio)
	tab_1.tabpage_1.dw_2.Object.dh_termino[ll_row] = datetime(ldh_termino)
	tab_1.tabpage_1.dw_2.Object.pc_limite_preco[ll_row] = ldc_pc_limite
loop

ivm_menu.mf_confirmar(true)
ivm_menu.mf_cancelar(true)


return true
end function

event close;call super::close;destroy ivo_Produto 	
destroy ivo_uf
end event

event open;call super::open;dc_uo_dw_Base lvo_Update[]

string ls_Usuario

if Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE568_PRODUTO_COMPRA_BLOQUEIO", ref ls_Usuario) Then
	Return close(this)
End If

ivo_Produto 	= Create uo_Produto
ivo_uf         = Create uo_unidade_federacao

this.wf_insere_lei_generico_default( )
this.wf_insere_uf_default( )
this.wf_insere_grupo_default( )
this.wf_insere_rede_default( )

lvo_Update = {Tab_1.TabPage_2.dw_3, Tab_1.TabPage_1.dw_2}
This.wf_SetUpdate_DW(lvo_Update)

this.post event ue_retrieve()
end event

on w_ge568_produto_compra_bloqueio.create
call super::create
end on

on w_ge568_produto_compra_bloqueio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_addrow;// override
Tab_1.TabPage_1.dw_2.Event ue_AddRow()

end event

event ue_retrieve;If not wf_Valida_Salva() > 0 Then
	Return
End If

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
Tab_1.selectedtab = 1
Tab_1.TabPage_1.dw_2.setfocus()
end event

type dw_visual from dc_w_2tab_cadastro_selecao_lista_det`dw_visual within w_ge568_produto_compra_bloqueio
end type

type gb_aux_visual from dc_w_2tab_cadastro_selecao_lista_det`gb_aux_visual within w_ge568_produto_compra_bloqueio
end type

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge568_produto_compra_bloqueio
integer x = 5
integer y = 4
integer width = 5536
integer height = 1976
end type

event tab_1::selectionchanging;// override
end event

event tab_1::selectionchanged;call super::selectionchanged;if newindex = 2 then
	ivm_Menu.mf_incluir(false)
	ivm_Menu.mf_excluir(false)
end if
end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer width = 5499
integer height = 1860
string text = "Configura$$HEX2$$e700e300$$ENDHEX$$o de Bloqueio"
end type

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer y = 452
integer width = 5454
integer height = 1388
string text = "Configura$$HEX2$$e700f500$$ENDHEX$$es de Bloqueio"
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
integer width = 3223
integer height = 408
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
integer x = 55
integer y = 104
integer width = 3159
integer height = 272
string dataobject = "dw_ge568_selecao_bloqueio"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;tab_1.tabpage_1.dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;

tab_1.tabpage_1.dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	Case "id_planilha"
		If Data = "S" Then
			wf_importa_dados_planilha()
		end if
	
	case "id_ativos"
		If Data = "S" Then this.object.id_futuros[1] = 'N'

	case "id_futuros"
		If Data = "S" Then this.object.id_ativos[1] = 'N'
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;tab_1.tabpage_1.dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				
			End If
		
	End Choose
End If
end event

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer x = 32
integer y = 512
integer width = 5435
integer height = 1300
string title = "GE568 - Bloqueio de Produtos"
string dataobject = "dw_ge568_lista_bloqueio"
boolean ivb_ordena_colunas = true
boolean ivb_updateable = true
boolean ivb_grava_log = true
end type

event dw_2::itemchanged;call super::itemchanged;string	lvs_obj, &
			ls_null
long		ll_null

setnull(ll_null)
setnull(ls_null)

lvs_obj = dwo.name 

// se selecionar um produto como criterio, limpa grupo e lei generico, pois nao faz sentido te-los como criterio juntamente com o produto
if lvs_obj = 'de_produto' then
	this.object.cd_grupo[row] = ls_null
	this.object.id_lei_generico[row] = ls_null
end if

if lvs_obj = 'cd_grupo' then
	this.object.cd_produto[row] = ll_null
	this.object.de_produto[row] = ls_null
end if

if lvs_obj = 'dh_termino' then
	if left(data,10) < string(today(), 'yyyy-mm-dd') then
		if Messagebox('Vig$$HEX1$$ea00$$ENDHEX$$ncia', 'A Data de T$$HEX1$$e900$$ENDHEX$$rmino da Vig$$HEX1$$ea00$$ENDHEX$$ncia $$HEX1$$e900$$ENDHEX$$ menor que a data de hoje, o que significa que voc$$HEX1$$ea00$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ desativando esta Configura$$HEX2$$e700e300$$ENDHEX$$o de Bloqueio e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ mais alter$$HEX1$$e100$$ENDHEX$$-la. Deseja prosseguir?', question!, yesno!) = 2 then
			// rejeita o valor 
			return 2
		end if
	end if
end if

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
End If


end event

event dw_2::ue_key;call super::ue_key;string	ls_null, ls_col
long		ll_null
datetime ldh_null

setnull(ll_null)
setnull(ls_null)
setnull(ldh_null)


If Key = KeyEscape! Then
	ls_col = this.getcolumnname()
	
	choose case ls_col
		case 'de_produto'
			this.setitem(this.getrow(), 'de_produto', ls_null)
			this.setitem(this.getrow(), 'cd_produto', ll_null)
			
			if isnull(this.object.cd_grupo[this.getrow()]) then
				this.setitem(this.getrow(), 'id_rede_filial', ls_null)
				this.setitem(this.getrow(), 'nm_unidade_federacao', ls_null)
				this.setitem(this.getrow(), 'cd_unidade_federacao', ls_null)
				this.setitem(this.getrow(), 'id_lei_generico', ls_null)
			end if
			
		case 'cd_grupo'
			this.setitem(this.getrow(), 'cd_grupo', ls_null)

			if isnull(this.object.cd_produto[this.getrow()]) then
				this.setitem(this.getrow(), 'id_rede_filial', ls_null)
				this.setitem(this.getrow(), 'nm_unidade_federacao', ls_null)
				this.setitem(this.getrow(), 'cd_unidade_federacao', ls_null)
				this.setitem(this.getrow(), 'id_lei_generico', ls_null)
			end if
		
		case 'id_rede_filial'
			this.setitem(this.getrow(), 'id_rede_filial', ls_null)
			this.setitem(this.getrow(), 'nm_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'cd_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'id_lei_generico', ls_null)

		case 'nm_unidade_federacao'
			this.setitem(this.getrow(), 'nm_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'cd_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'id_lei_generico', ls_null)

		case 'id_lei_generico'
			this.setitem(this.getrow(), 'id_lei_generico', ls_null)

		case 'dh_inicio', 'dh_termino'
			this.setitem(this.getrow(), ls_col, ldh_null)
	
	end choose
	
	ivm_Menu.mf_confirmar(true)
	ivm_Menu.mf_cancelar(true)
	
	dw_1.Enabled = False	
end if

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			
			This.Object.de_produto[This.GetRow()] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			This.Object.cd_produto[This.GetRow()] = ivo_Produto.cd_produto
			is_Produto = ""
			
			this.post event itemchanged(this.getrow(), this.object.de_produto, ivo_Produto.ivs_Descricao_Apresentacao_Estoque)
			
		End If
	End If

	
	
	If This.GetColumnName() = "nm_unidade_federacao" Then
		
		ivo_uf.of_Localiza_uf(This.GetText())
		
		If ivo_uf.Localizado Then
			
			This.Object.cd_unidade_federacao[This.GetRow()] = ivo_uf.cd_unidade_federacao
			This.Object.nm_unidade_federacao[This.GetRow()] = ivo_uf.nm_unidade_federacao
			
			this.post event itemchanged(this.getrow(), this.object.nm_unidade_federacao, ivo_uf.nm_unidade_federacao)
		End If
	End If
End If

end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto

String lvs_uf
String lvs_grupo
String lvs_id_lei_generico
String lvs_id_rede_filial
String lvs_id_ativos
String lvs_id_futuros

tab_1.tabpage_1.dw_1.AcceptText()

lvs_id_rede_filial		   = tab_1.tabpage_1.dw_1.Object.id_rede_filial	[1]
lvs_id_lei_generico		   = tab_1.tabpage_1.dw_1.Object.id_lei_generico[1]
lvl_Produto						= tab_1.tabpage_1.dw_1.Object.Cd_Produto		[1]
lvs_UF							= tab_1.tabpage_1.dw_1.Object.Cd_UF				[1]
lvs_Grupo						= tab_1.tabpage_1.dw_1.Object.Cd_grupo			[1]
lvs_id_ativos					= tab_1.tabpage_1.dw_1.Object.id_ativos		[1]
lvs_id_futuros					= tab_1.tabpage_1.dw_1.Object.id_futuros		[1]

If Not IsNull(lvs_id_lei_generico) and lvs_id_lei_generico <> 'X' Then
	This.of_AppendWhere("p.id_lei_generico = '" + lvs_id_lei_generico + "'")
End If
	
If Not IsNull(lvs_id_rede_filial) and lvs_id_rede_filial <> 'XX' Then
	This.of_AppendWhere("p.id_rede_filial = '" + lvs_id_rede_filial + "'")
End If
	
If is_Produto = "" Then
	If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
		This.of_AppendWhere("p.cd_produto = " + String(lvl_Produto))
	End If
else
	This.of_AppendWhere("p.cd_produto in (" + is_Produto + ")")
end if

If Not IsNull(lvs_grupo) and Trim(lvs_grupo) <> "X" Then
	This.of_AppendWhere("p.cd_grupo = '" + lvs_grupo + "'")
End If

If Not IsNull(lvs_UF) and Trim(lvs_UF) <> "XX" Then
	This.of_AppendWhere("p.cd_unidade_federacao = '" + lvs_UF + "'")
End If

If lvs_id_ativos = 'S' Then
	This.of_AppendWhere("'"+string(today(), 'yyyy-mm-dd')+"' between p.dh_inicio and p.dh_termino")
End If

If lvs_id_futuros = 'S' Then
	This.of_AppendWhere("'"+string(today(), 'yyyy-mm-dd')+"' < p.dh_inicio ")
End If

Return 1
end event

event dw_2::ue_preupdate;call super::ue_preupdate;long	ll_Proximo_Codigo, &
		ll_Linha, &
    	ll_Total, &
		i, &
		lvl_count, &
		lvl_cd_bloqueio

boolean lvb_existe

dwitemstatus ldw_itemstatus

this.accepttext()

for i = 1 to this.rowcount()
	ldw_itemstatus  = this.getitemstatus(i, 0, primary!)
	lvl_cd_bloqueio = this.object.cd_bloqueio[i]
	
	if ldw_itemstatus = datamodified! then
		
		if this.getitemstatus(i, 'cd_produto', primary!) = datamodified! &
		or this.getitemstatus(i, 'cd_grupo', primary!) = datamodified! &
		or this.getitemstatus(i, 'cd_unidade_federacao', primary!) = datamodified! &
		or this.getitemstatus(i, 'id_lei_generico', primary!) = datamodified! &
		or this.getitemstatus(i, 'id_rede_filial', primary!) = datamodified! &
		or this.getitemstatus(i, 'pc_limite_preco', primary!) = datamodified! then
		
			// se $$HEX1$$e900$$ENDHEX$$ uma configuracao ja existente, nao permite alterar criterios e percentual se ela ja tiver sido aplicada em algum pedido
			// pode alterar somente datas de vigencia para poder finalizar a configuracao em questao e criar outra se for o caso
			if this.object.id_aplicado[i] = 'S' then
				Messagebox('Erro', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel alterar a configura$$HEX2$$e700e300$$ENDHEX$$o de bloqueio pois ela j$$HEX1$$e100$$ENDHEX$$ foi aplicada nos pedidos. ', stopsign!)
				This.setrow(i)
				this.setcolumn('de_produto')
				return -1
			end if
		end if
	end if
	
	if ldw_itemstatus = new! or ldw_itemstatus = newmodified! or ldw_itemstatus = datamodified! then
		if isnull(this.object.cd_produto[i]) and isnull(this.object.cd_grupo[i]) then
			Messagebox('Erro', 'Selecione ao menos um produto ou um grupo como crit$$HEX1$$e900$$ENDHEX$$rio de bloqueio para continuar.', stopsign!)
			This.setrow(i)
			this.setcolumn('de_produto')
			return -1
		end if
		
		if isnull(this.object.dh_inicio[i]) then
			Messagebox('Erro', 'Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio para continuar.', stopsign!)
			This.setrow(i)
			this.setcolumn('dh_inicio')
			return -1
		end if			
		
		if isnull(this.object.dh_termino[i]) then
			Messagebox('Erro', 'Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino para continuar.', stopsign!)
			This.setrow(i)
			this.setcolumn('dh_termino')
			return -1
		end if
		
		if string(this.object.dh_inicio[i], 'yyyymmdd') > string(this.object.dh_termino[i], 'yyyymmdd') then
			Messagebox('Erro', 'A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data final.', stopsign!)
			This.setrow(i)
			this.setcolumn('dh_inicio')
			return -1
		end if

		if isnull(this.object.pc_limite_preco[i]) then
			Messagebox('Erro', 'Informe o Limite de Pre$$HEX1$$e700$$ENDHEX$$o para continuar.', stopsign!)
			This.setrow(i)
			this.setcolumn('pc_limite_preco')
			return -1
		end if

		// verifica se ja existe configuracao de bloqueio com mesmos criterios e mesmo periodo ou com periodos que se sobrepoem
		// faz esta verifica$$HEX2$$e700e300$$ENDHEX$$o somente se a data de termino for maior ou igual a data de hoje.
		if string(this.object.dh_termino[i], 'yyyymmdd') >= string(today(), 'yyyymmdd') then
			if not wf_verifica_configuracao_existe(i, lvb_existe) then return -1
			// se ja existe configura$$HEX2$$e700e300$$ENDHEX$$o, nao permite gravar
			if lvb_existe then return -1
		end if
		
	end if
	
next

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de linhas da DW
ll_Total = This.RowCount()

// Localiza a primeira linha sem c$$HEX1$$f300$$ENDHEX$$digo
ll_Linha = This.Find("isnull(cd_bloqueio)", 0, ll_Total)

if not wf_Proximo_Codigo(ll_Proximo_Codigo) then return -1
	
// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While ll_Linha > 0
	
	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.cd_bloqueio[ll_Linha] = ll_Proximo_Codigo
	
	ll_Linha = This.Find("isnull(cd_bloqueio)", ll_Linha, ll_Total)
	
	ll_Proximo_Codigo ++
Loop

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivi_Tipo_Cancelar = RETRIEVE

end event

event dw_2::getfocus;call super::getfocus;if this.rowcount() > 0 then
	if this.object.id_aplicado[this.getrow()] = 'N' then
		ivm_menu.mf_excluir(true)
	else
		ivm_menu.mf_excluir(false)
	end if
else
	ivm_menu.mf_excluir(false)
end if


end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;if this.rowcount() > 0 and this.getrow() > 0 then
	ivm_menu.mf_excluir(this.object.id_aplicado[this.getrow()] = 'N')
else
	ivm_menu.mf_excluir(false)
end if
end event

event dw_2::ue_addrow;call super::ue_addrow;ivb_Valida_Salva = true

return ancestorreturnvalue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;if pl_linhas > 0 then
	ivm_Menu.post mf_SalvarComo(true)
else
	ivm_Menu.post mf_SalvarComo(false)
end if

return 1
end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer width = 5499
integer height = 1860
string text = "Bloqueio Geral"
end type

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer width = 1326
integer height = 208
string text = "Bloqueio Geral"
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer x = 50
integer width = 1275
integer height = 108
string dataobject = "dw_ge568_percentual_geral"
boolean ivb_updateable = true
boolean ivb_grava_log = true
end type

event dw_3::itemchanged;call super::itemchanged;if dwo.name = 'pc_limite_geral' then
	this.setitem(1, 'vl_parametro', data)
end if
end event

event dw_3::ue_preupdate;call super::ue_preupdate;this.accepttext()

if this.object.pc_limite_geral[1] < 85 then
	Messagebox('Erro', 'O Limite Geral n$$HEX1$$e300$$ENDHEX$$o pode ser inferior a 85%')
	return -1
end if
end event

event dw_3::ue_saveas;String	lvs_Arquivo, &
		lvs_Diretorio, &
		lvs_Extensao

Integer lvi_Retorno

MensagemErro = ""

// Verifica o nome do arquivo
lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
										lvs_Diretorio, 	&
										lvs_Arquivo, 	&
										"XLS", 			&
										"Arquivos Excel (*.XLS),*.XLS,Arquivos Excel Formatado (*.XLS),*.XLSF" 	+ &
										",Arquivos Excel (*.XLSX),*.XLSX,Arquivos CSV (*.CSV),*.CSV"	+ &
										",Arquivos PDF (*.PDF),*.PDF,Arquivos HTML (*.HTML),*.HTML" 		+ &
										",Arquivos Texto (*.TXT),*.TXT")

If lvi_Retorno = -1 Then
	MensagemErro = "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo."
	If ExibeMensagem Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", MensagemErro, StopSign!)
	Return 
Else
	If lvi_Retorno = 0 Then Return
End If

lvs_Diretorio = Upper( lvs_Diretorio )
lvs_Diretorio = gf_replace(lvs_Diretorio,'.XLSF','.XLS',0)

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If ExibeMensagem Then 
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
			If Not FileDelete(lvs_Diretorio) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
				Return
			End If
		Else
			Return 
		End If   
	Else
		If Not FileDelete(lvs_Diretorio) Then 
			MensagemErro = "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'."
			Return
		End If
	End If
End If

// Salva o arquivo
lvs_Extensao = gf_replace(Mid(lvs_Arquivo,Len(lvs_Arquivo)-3,4),'.','',0)

lvs_Extensao = Upper( lvs_Extensao )

If (lvs_Extensao = 'XLS') or (lvs_Extensao = 'XLSF') then
	If tab_1.tabpage_1.dw_2.RowCount() > 65000 Then
		If ExibeMensagem Then 
			If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',	'Este relat$$HEX1$$f300$$ENDHEX$$rio excede o limite de 65.000 linhas do formato Excel (XLS).~r~n'+ &
												'O arquivo n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salvo neste formato.~r~n~r~n'+ &
												'Deseja selecionar outro formato?',Question!, YesNo!,1)=1 Then 
				tab_1.tabpage_1.dw_2.Event ue_SaveAs()
				Return
			Else
				Return
			End If
		Else
			lvs_Extensao = "CSV"
			lvs_Arquivo  = gf_replace(lvs_Diretorio,'.XLS','.CSV',0)
		End If
	End If
End If

Open(w_aguarde_1)
If IsValid(w_aguarde_1) Then w_aguarde_1.Title = 'Aguarde... Salvando...'
Choose Case lvs_Extensao
	Case 'XLS'
		lvi_Retorno = tab_1.tabpage_1.dw_2.SaveAs(lvs_Diretorio, Excel8!, True)
	Case 'XLSX'
		lvi_Retorno = tab_1.tabpage_1.dw_2.SaveAs(lvs_Diretorio, XLSX!, True)
	Case 'CSV'
		//lvi_Retorno = tab_1.tabpage_1.dw_2.SaveAs(lvs_Diretorio, CSV!, True,EncodingUTF8!)
		lvi_Retorno = tab_1.tabpage_1.dw_2.SaveAsFormattedText(lvs_Diretorio, EncodingANSI!, ";")
	Case 'PDF'
		//lvi_Retorno = tab_1.tabpage_1.dw_2.SaveAs(lvs_Diretorio, PDF!, True)
		lvi_Retorno = tab_1.tabpage_1.dw_2.of_Exporta_PDF(lvs_Diretorio)
	Case 'HTML'
		lvi_Retorno = tab_1.tabpage_1.dw_2.SaveAs(lvs_Diretorio, HTMLTable!, True)
	Case 'TXT'
		lvi_Retorno = tab_1.tabpage_1.dw_2.SaveAs(lvs_Diretorio, Text!, True,EncodingUTF8!)
	Case 'XLSF'
		If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetMax(2)
		If tab_1.tabpage_1.dw_2.SaveAs( lvs_Diretorio, HTMLTable!, True ) = 1 Then
			If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetProgress(1)
			// Converte arquivo HTML para Excel
			OLEObject Excel 
			Excel = Create OLEObject 
			
			If Excel.ConnectToNewObject('Excel.Application') = 0 Then
				Excel.Application.DisplayAlerts = False
				Excel.Application.Workbooks.Open(lvs_Diretorio)
				Excel.Application.Workbooks( 1 ).Parent.Windows( Excel.Application.Workbooks( 1 ).Name ).Visible = True
				Excel.Application.Workbooks( 1 ).SaveAs(lvs_Diretorio, 56 ) 
				Excel.Application.Workbooks( 1 ).Close()
				Excel.DisconnectObject()
			
				Destroy(Excel)
				lvi_Retorno = 1
			Else
				Destroy(Excel)
				lvi_Retorno = -1
			End If
			If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetProgress(2)
		Else
			lvi_Retorno = -1
		End If
End Choose
If IsValid(w_aguarde_1) Then Close(w_aguarde_1)

If lvi_Retorno <> 1 Then
	MensagemErro = "Erro ao salvar o arquivo '" + lvs_Diretorio + "'."
	If ExibeMensagem Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", MensagemErro, StopSign!)	
	Return 
Else
	MensagemErro = ""
	If ExibeMensagem Then Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
End If
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;return ancestorreturnvalue
end event

event dw_3::ue_deleterow;// override - nao exclui registro da dw_3
return true
end event

event dw_3::ue_addrow;// override - nao inclui registro da dw_3

return 1
end event

