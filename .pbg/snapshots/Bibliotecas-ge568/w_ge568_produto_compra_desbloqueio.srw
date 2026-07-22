HA$PBExportHeader$w_ge568_produto_compra_desbloqueio.srw
forward
global type w_ge568_produto_compra_desbloqueio from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge568_produto_compra_desbloqueio from dc_w_cadastro_selecao_lista
string tag = "w_ge568_produto_compra_desbloqueio"
integer width = 5330
integer height = 2368
string title = "GE568 - Libera$$HEX2$$e700e300$$ENDHEX$$o de Produtos"
boolean ivb_valida_salva = true
boolean ivb_grava_log = true
end type
global w_ge568_produto_compra_desbloqueio w_ge568_produto_compra_desbloqueio

type variables
uo_produto ivo_produto

uo_fornecedor ivo_fornecedor

uo_unidade_federacao ivo_uf

string is_Produto
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_insere_uf_default ()
public subroutine wf_insere_rede_default ()
public function boolean wf_verifica_configuracao_existe (long al_linha, ref boolean ab_existe)
public subroutine _documentacao ()
public function boolean wf_proximo_codigo (ref long al_proximo_codigo)
public function boolean wf_importa_dados_planilha ()
public function boolean wf_busca_descricao_produto (long al_cd_produto, ref string as_de_produto)
public function boolean wf_busca_descricao_uf (string as_cd_uf, ref string as_nm_uf)
public function boolean wf_busca_descricao_distribuidora (string as_cd_distribuidora, ref string as_nm_fantasia)
end prototypes

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

public subroutine wf_insere_rede_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("id_rede_filial", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "id_rede_filial", "XX")
	lvdwc.SetItem(1, "nm_rede_filial", "TODAS")
	
	dw_1.Object.id_rede_filial[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da Rede Filial")
End If
end subroutine

public function boolean wf_verifica_configuracao_existe (long al_linha, ref boolean ab_existe);// funcao para verificar se ja existe registro com as mesmas configuracoes de desbloqueio que o registro que esta sendo incluido/alterado

string	lvs_CRLF = char(13) + char(10), &
			lvs_cd_distribuidora_atual, &
			lvs_cd_uf_atual, &
			lvs_id_rede_filial_atual, &
			lvs_cd_desbloqueio_lista, &
			lvs_sql, &
			lvs_id_existe, &
			lvs_id_rede_filial , &
			lvs_cd_distribuidora , &
			lvs_cd_uf 


long 		lvl_cd_produto_atual, &
			lvl_cd_desbloqueio_atual, &
			lvl_cd_desbloqueio, &
			i

datetime lvdt_inicio_atual, &
			lvdt_termino_atual, &
			lvdt_inicio, &
			lvdt_termino
			
ab_existe = false

lvl_cd_desbloqueio_atual   = dw_2.object.cd_desbloqueio[al_linha]
lvs_cd_distribuidora_atual = dw_2.object.cd_distribuidora[al_linha]
lvs_cd_uf_atual				= dw_2.object.cd_unidade_federacao[al_linha]
lvs_id_rede_filial_atual	= dw_2.object.id_rede_filial[al_linha]
lvl_cd_produto_atual			= dw_2.object.cd_produto[al_linha]
lvdt_inicio_atual				= dw_2.object.dh_inicio[al_linha]
lvdt_termino_atual			= dw_2.object.dh_termino[al_linha]

if isnull(lvs_cd_distribuidora_atual)	then lvs_cd_distribuidora_atual = ''
if isnull(lvs_cd_uf_atual)					then lvs_cd_uf_atual = ''
if isnull(lvs_id_rede_filial_atual)		then lvs_id_rede_filial_atual = ''

if not isnull(lvl_cd_desbloqueio_atual) then lvs_cd_desbloqueio_lista += string(lvl_cd_desbloqueio_atual) + ','

//primeiro, verifica nos registros da propria datawindow se existe registro com os mesmos criterios de bloqueio e com vigencia igual ou intercalada
for i = 1 to dw_2.rowcount()
	if i <> al_linha then
		// compara somente com registros onde data de termino $$HEX1$$e900$$ENDHEX$$ maior ou igual a data atual, ou seja, registros em vigencia ou que serao vigentes no futuro
		if string(dw_2.object.dh_termino[i],'yyyymmdd') >= string(today(),'yyyymmdd') then
			
			lvl_cd_desbloqueio = dw_2.object.cd_desbloqueio[i]
			
			lvs_id_rede_filial = dw_2.object.id_rede_filial[i]
			lvs_cd_distribuidora = dw_2.object.cd_distribuidora[i]
			lvs_cd_uf = dw_2.object.cd_unidade_federacao[i]
			
			if isnull(lvs_id_rede_filial) then lvs_id_rede_filial = ''
			if isnull(lvs_cd_distribuidora ) then lvs_cd_distribuidora = ''
			if isnull(lvs_cd_uf ) then lvs_cd_uf = ''

			if  lvl_cd_produto_atual		 = dw_2.object.cd_produto[i] &
			and lvs_id_rede_filial_atual	 = lvs_id_rede_filial &
			and lvs_cd_distribuidora_atual = lvs_cd_distribuidora &
			and lvs_cd_uf_atual				 = lvs_cd_uf &
			and (  (lvdt_inicio_atual  >= dw_2.object.dh_inicio[i] and lvdt_inicio_atual  <= dw_2.object.dh_termino[i]) &
				 or (lvdt_termino_atual >= dw_2.object.dh_inicio[i] and lvdt_termino_atual <= dw_2.object.dh_termino[i]) &
				 or (lvdt_inicio_atual  <= dw_2.object.dh_inicio[i] and lvdt_termino_atual >= dw_2.object.dh_termino[i])  ) &
			then
			
				ab_existe = true
				dw_2.setrow(al_linha)
				dw_2.scrolltorow(al_linha)
				Messagebox('Configura$$HEX2$$e700e300$$ENDHEX$$o de Libera$$HEX2$$e700e300$$ENDHEX$$o', 'J$$HEX1$$e100$$ENDHEX$$ existe uma ou mais configura$$HEX2$$e700f500$$ENDHEX$$es de libera$$HEX2$$e700e300$$ENDHEX$$o com os mesmos crit$$HEX1$$e900$$ENDHEX$$rios e com vig$$HEX1$$ea00$$ENDHEX$$ncia igual ou sobreposta $$HEX1$$e000$$ENDHEX$$ vig$$HEX1$$ea00$$ENDHEX$$ncia selecionada.' + lvs_CRLF + &
								'Produto:'        + string(lvl_cd_produto_atual) + lvs_CRLF + &
								'Rede: '          + lvs_id_rede_filial_atual     + lvs_CRLF + &
								'UF: '            + lvs_cd_uf_atual              + lvs_CRLF + &
								'Distribuidora: ' + lvs_cd_distribuidora_atual   + lvs_CRLF + &
								'In$$HEX1$$ed00$$ENDHEX$$cio: '        + string(lvdt_inicio_atual,  'dd/mm/yyyy') + lvs_CRLF + &
								'T$$HEX1$$e900$$ENDHEX$$rmino: '       + string(lvdt_termino_atual, 'dd/mm/yyyy'), stopsign! )

				return true
			end if
			
			if not isnull(lvl_cd_desbloqueio) then lvs_cd_desbloqueio_lista += string(lvl_cd_desbloqueio) + ','
		end if
	end if
next

if lvs_cd_desbloqueio_lista <> '' then 
	//remove ultima virgula
	lvs_cd_desbloqueio_lista = left(lvs_cd_desbloqueio_lista, len(lvs_cd_desbloqueio_lista) - 1)
	lvs_cd_desbloqueio_lista = '(' + lvs_cd_desbloqueio_lista + ')'
end if

// verifica diretamente na tabela se existe registro com os mesmos criterios de bloqueio e com vigencia igual ou intercalada
lvs_sql = "select top 1 'S' as id_existe, p.dh_inicio, p.dh_termino &
  from produto_compra_desbloqueio p &
 where coalesce(p.cd_produto, 0)            = "+string(lvl_cd_produto_atual)+" &
	and coalesce(p.id_rede_filial, '')       = '"+lvs_id_rede_filial_atual+"' &
	and coalesce(p.cd_distribuidora, '')     = '"+lvs_cd_distribuidora_atual+"' &
	and coalesce(p.cd_unidade_federacao, '') = '"+lvs_cd_uf_atual+"' &
	and convert(varchar, p.dh_termino, 102) >= convert(varchar, getdate(), 102) &
	and (  ('"+string(lvdt_inicio_atual,'yyyy.mm.dd')+"'  >= convert(varchar, p.dh_inicio, 102) and '"+string(lvdt_inicio_atual,'yyyy.mm.dd')+"'  <= convert(varchar, p.dh_termino, 102))  &
		 or ('"+string(lvdt_termino_atual,'yyyy.mm.dd')+"' >= convert(varchar, p.dh_inicio, 102) and '"+string(lvdt_termino_atual,'yyyy.mm.dd')+"' <= convert(varchar, p.dh_termino, 102))  &
		 or ('"+string(lvdt_inicio_atual,'yyyy.mm.dd')+"'  <= convert(varchar, p.dh_inicio, 102) and '"+string(lvdt_termino_atual,'yyyy.mm.dd')+"' >= convert(varchar, p.dh_termino, 102))  ) "


// retira da verifica$$HEX2$$e700e300$$ENDHEX$$o os registros que foram testados na datawindow.
if lvs_cd_desbloqueio_lista <> '' then
	lvs_sql += " and p.cd_desbloqueio not in " + lvs_cd_desbloqueio_lista
end if

DECLARE cr_cur DYNAMIC CURSOR FOR SQLSA ;
PREPARE SQLSA FROM :lvs_sql;
OPEN DYNAMIC cr_cur;
fetch cr_cur into :lvs_id_existe, :lvdt_inicio, :lvdt_termino;
close cr_cur;

if lvs_id_existe = 'S' then
	ab_existe = true
	dw_2.setrow(al_linha)
	dw_2.scrolltorow(al_linha)
	Messagebox('Configura$$HEX2$$e700e300$$ENDHEX$$o de Libera$$HEX2$$e700e300$$ENDHEX$$o', 'J$$HEX1$$e100$$ENDHEX$$ existe uma ou mais configura$$HEX2$$e700f500$$ENDHEX$$es de libera$$HEX2$$e700e300$$ENDHEX$$o com os mesmos crit$$HEX1$$e900$$ENDHEX$$rios e com vig$$HEX1$$ea00$$ENDHEX$$ncia igual ou sobreposta $$HEX1$$e000$$ENDHEX$$ vig$$HEX1$$ea00$$ENDHEX$$ncia selecionada.' + lvs_CRLF + &
					'Produto:'        + string(lvl_cd_produto_atual)   + lvs_CRLF + &
					'Rede: '          + lvs_id_rede_filial_atual       + lvs_CRLF + &
					'UF: '            + lvs_cd_uf_atual                + lvs_CRLF + &
					'Distribuidora: ' + lvs_cd_distribuidora_atual     + lvs_CRLF + &
					'In$$HEX1$$ed00$$ENDHEX$$cio: '        + string(lvdt_inicio_atual,  'dd/mm/yyyy') + lvs_CRLF + &
					'T$$HEX1$$e900$$ENDHEX$$rmino: '       + string(lvdt_termino_atual, 'dd/mm/yyyy'), stopsign! )
	return true
end if

return true
end function

public subroutine _documentacao ();// GE568 - Libera$$HEX2$$e700e300$$ENDHEX$$o de Produtos
// Interface que mantem as configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio de produtos 
/* 

Nesta interface, ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel criar configura$$HEX2$$e700f500$$ENDHEX$$es de libera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$os por produto, Rede, UF e Distribuidora, 
por um per$$HEX1$$ed00$$ENDHEX$$odo de vig$$HEX1$$ea00$$ENDHEX$$ncia.

Estas configura$$HEX2$$e700f500$$ENDHEX$$es de libera$$HEX2$$e700e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o utilizadas para desbloquear os pedidos junto $$HEX1$$e000$$ENDHEX$$s distribuidoras onde o pre$$HEX1$$e700$$ENDHEX$$o de compra ultrapassar o percentual definido nas 
configura$$HEX2$$e700f500$$ENDHEX$$es de bloqueio, mas por algum motivo de exce$$HEX2$$e700e300$$ENDHEX$$o devem ser liberados para a compra. Ou seja, uma configura$$HEX2$$e700e300$$ENDHEX$$o de libera$$HEX2$$e700e300$$ENDHEX$$o tem prioridade em rela$$HEX2$$e700e300$$ENDHEX$$o 
a configura$$HEX2$$e700e300$$ENDHEX$$o de bloqueio.

Ao criar uma configura$$HEX2$$e700e300$$ENDHEX$$o de libera$$HEX2$$e700e300$$ENDHEX$$o, ser$$HEX1$$e100$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio selecionar ao menos o crit$$HEX1$$e900$$ENDHEX$$rio Produto. 
Feito isso, ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel restringir a configura$$HEX2$$e700e300$$ENDHEX$$o de libera$$HEX2$$e700e300$$ENDHEX$$o por Rede, UF e Distribuidora. 

$$HEX1$$c900$$ENDHEX$$ possivel, por exemplo, cadastrar:

 - uma configura$$HEX2$$e700e300$$ENDHEX$$o de libera$$HEX2$$e700e300$$ENDHEX$$o com o criterio produto selecionado
 - outra configura$$HEX2$$e700e300$$ENDHEX$$o com os crit$$HEX1$$e900$$ENDHEX$$rios Produto e Rede selecionado
 
Neste caso , o sistema dar$$HEX1$$e100$$ENDHEX$$ prioridade para esta $$HEX1$$fa00$$ENDHEX$$ltima, pois ela possui crit$$HEX1$$e900$$ENDHEX$$rios de libera$$HEX2$$e700e300$$ENDHEX$$o mais restritivos em rela$$HEX2$$e700e300$$ENDHEX$$o a primeira

Ao cadastrar um novo crit$$HEX1$$e900$$ENDHEX$$rio de libera$$HEX2$$e700e300$$ENDHEX$$o, inicialmente somente o campo Produto estar$$HEX1$$e100$$ENDHEX$$ disponivel para sele$$HEX2$$e700e300$$ENDHEX$$o. Ap$$HEX1$$f300$$ENDHEX$$s escolher um deles, o campos imediatamente
a direita ficar$$HEX1$$e300$$ENDHEX$$o disponiveis para serem utilizados como crit$$HEX1$$e900$$ENDHEX$$rio de libera$$HEX2$$e700e300$$ENDHEX$$o.

O sistema permitir$$HEX1$$e100$$ENDHEX$$ cadastrar duas configura$$HEX2$$e700f500$$ENDHEX$$es de libera$$HEX2$$e700e300$$ENDHEX$$o iguais, porem o inicio e termino da vigencia n$$HEX1$$e300$$ENDHEX$$o podem se sobrepor.

*/

end subroutine

public function boolean wf_proximo_codigo (ref long al_proximo_codigo);long ll_Linha

Select Max(cd_desbloqueio) 
  Into :al_Proximo_Codigo
  From produto_compra_desbloqueio
 using sqlca;

if sqlca.sqlcode = -1 then
	Messagebox('Erro', 'Erro ao buscar pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo de desbloqueio.' + sqlca.sqlerrtext, stopsign!)
	return false
end if

If IsNull(al_Proximo_Codigo) Then
	al_Proximo_Codigo = 0
End If

al_Proximo_Codigo += 1

Return true
end function

public function boolean wf_importa_dados_planilha ();string	ls_Nulo, &
			ls_cd_produto, &
			ls_cd_uf, &
			ls_id_rede_filial, &
			ls_de_produto, &
			ls_nm_uf, &
			ls_nm_rede_filial, &
			ls_retorno, &
			ls_cd_distribuidora, &
			ls_nm_fantasia

long 		ll_nulo, &
			ll_row

Decimal	ldc_pc_limite

Date		ldh_termino, &
			ldh_inicio

setnull(ls_nulo)
setnull(ll_nulo)

OpenWithParm(w_ge568_inclusao_via_planilha, 'DESBLOQUEIO')

ls_retorno = Message.StringParm

If Trim(ls_retorno) = "" Or IsNull(ls_retorno) Then
	Return false
End If
		
ldh_inicio    = date(left(ls_retorno, pos(ls_retorno, ';') - 1))
ls_retorno    = mid(ls_retorno, pos(ls_retorno, ';') + 1)
ldh_termino   = date(left(ls_retorno, pos(ls_retorno, ';') - 1))
ls_retorno    = mid(ls_retorno, pos(ls_retorno, ';') + 1)

// ignora esta posi$$HEX2$$e700e300$$ENDHEX$$o do arquivo pois o percentual de limite $$HEX1$$e900$$ENDHEX$$ somente utilizado na interface de bloqueio
//ldc_pc_limite = dec(left(ls_retorno, pos(ls_retorno, ';') - 1))
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
		ls_cd_distribuidora = trim(left(ls_retorno, pos(ls_retorno, ',') - 1))
		ls_retorno    = trim(mid(ls_retorno, pos(ls_retorno, ',') + 1, len(ls_retorno)))				
	else
		ls_cd_distribuidora = trim(ls_retorno)
		ls_retorno = ''
	end if

	ll_row = dw_2.event ue_addrow()
	
	If not wf_busca_descricao_produto(long(ls_cd_produto), ref ls_de_produto) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'C$$HEX1$$f300$$ENDHEX$$digo de Produto ' + ls_cd_produto + ' n$$HEX1$$e300$$ENDHEX$$o encontrado no cadastro. ', stopsign!)
		close(w_Aguarde)
		return false
	End If

	dw_2.Object.Cd_Produto[ll_row] = long(ls_Cd_Produto)
	dw_2.Object.De_Produto[ll_row] = ls_de_produto
	
	if ls_id_rede_filial <> '' then
		dw_2.Object.id_rede_filial[ll_row] = ls_id_rede_filial
	end if
	
	if ls_cd_uf <> '' then
		If not wf_busca_descricao_uf(ls_cd_uf, ref ls_nm_uf) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'UF ' + ls_cd_uf + ' n$$HEX1$$e300$$ENDHEX$$o encontrada no cadastro. ', stopsign!)
			close(w_Aguarde)
			return false
		End If

		dw_2.Object.Cd_unidade_federacao[ll_row] = ls_cd_uf
		dw_2.Object.nm_unidade_federacao[ll_row] = ls_nm_uf
	end if

	if ls_cd_distribuidora <> '' then
		If not wf_busca_descricao_distribuidora(ls_cd_distribuidora, ref ls_nm_fantasia) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'UF ' + ls_cd_distribuidora + ' n$$HEX1$$e300$$ENDHEX$$o encontrada no cadastro. ', stopsign!)
			close(w_Aguarde)
			return false
		End If

		dw_2.Object.cd_distribuidora[ll_row] = ls_cd_distribuidora
		dw_2.Object.nm_fantasia[ll_row] = ls_nm_fantasia
	end if
	
	dw_2.Object.dh_inicio[ll_row] = datetime(ldh_inicio)
	dw_2.Object.dh_termino[ll_row] = datetime(ldh_termino)
loop

ivm_menu.mf_confirmar(true)
ivm_menu.mf_cancelar(true)


return true
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

public function boolean wf_busca_descricao_distribuidora (string as_cd_distribuidora, ref string as_nm_fantasia);select nm_fantasia
  into :as_nm_fantasia
  from fornecedor
 where cd_fornecedor = :as_cd_distribuidora;

if sqlca.sqlcode = -1 or sqlca.sqlcode = 100 then return false

return true
end function

on w_ge568_produto_compra_desbloqueio.create
call super::create
end on

on w_ge568_produto_compra_desbloqueio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;string ls_Usuario

if Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE568_PRODUTO_COMPRA_DESBLOQUEIO", ref ls_Usuario) Then
	Return close(this)
End If

ivo_Produto 	= Create uo_Produto
ivo_Fornecedor = Create uo_Fornecedor
ivo_uf         = Create uo_unidade_federacao

this.wf_insere_distribuidora_default( )
this.wf_insere_uf_default( )
this.wf_insere_rede_default( )

this.event ue_retrieve()
end event

event close;call super::close;destroy ivo_Produto 	
destroy ivo_Fornecedor 
destroy ivo_uf
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge568_produto_compra_desbloqueio
integer y = 1452
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge568_produto_compra_desbloqueio
integer y = 1380
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge568_produto_compra_desbloqueio
integer x = 59
integer y = 64
integer width = 2885
integer height = 336
string dataobject = "dw_ge568_selecao_desbloqueio"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

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

event dw_1::itemchanged;call super::itemchanged;string	ls_Nulo, &
			ls_cd_produto, &
			ls_retorno
			
long 		ll_nulo, &
			ll_row

date		ldh_termino

setnull(ls_nulo)
setnull(ll_nulo)

dw_2.Event ue_Reset()

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
		Else
			ls_retorno = ""
		end if
		
	case "id_ativos"
		If Data = "S" Then this.object.id_futuros[1] = 'N'

	case "id_futuros"
		If Data = "S" Then this.object.id_ativos[1] = 'N'
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

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

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge568_produto_compra_desbloqueio
integer y = 456
integer width = 5230
integer height = 1708
string text = "Configura$$HEX2$$e700f500$$ENDHEX$$es de Libera$$HEX2$$e700e300$$ENDHEX$$o"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge568_produto_compra_desbloqueio
integer width = 2930
integer height = 428
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge568_produto_compra_desbloqueio
integer x = 55
integer y = 532
integer width = 5207
integer height = 1588
string dataobject = "dw_ge568_lista_desbloqueio"
boolean ivb_ordena_colunas = true
boolean ivb_updateable = true
boolean ivb_grava_log = true
end type

event dw_2::ue_key;call super::ue_key;string	ls_null, ls_col
long		ll_null
datetime	ldh_null

setnull(ll_null)
setnull(ls_null)
setnull(ldh_null)


If Key = KeyEscape! Then
	ls_col = this.getcolumnname()
	
	choose case ls_col
		case 'de_produto'
			this.setitem(this.getrow(), 'de_produto', ls_null)
			this.setitem(this.getrow(), 'cd_produto', ll_null)
			this.setitem(this.getrow(), 'id_rede_filial', ls_null)
			this.setitem(this.getrow(), 'nm_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'cd_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'nm_fantasia', ls_null)
			this.setitem(this.getrow(), 'cd_distribuidora', ls_null)
			this.post event itemchanged(this.getrow(), this.object.cd_produto, '')
			
		case 'id_rede_filial'
			this.setitem(this.getrow(), 'id_rede_filial', ls_null)
			this.setitem(this.getrow(), 'nm_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'cd_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'nm_fantasia', ls_null)
			this.setitem(this.getrow(), 'cd_distribuidora', ls_null)
			this.post event itemchanged(this.getrow(), this.object.id_rede_filial, '')

		case 'nm_unidade_federacao'
			this.setitem(this.getrow(), 'nm_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'cd_unidade_federacao', ls_null)
			this.setitem(this.getrow(), 'nm_fantasia', ls_null)
			this.setitem(this.getrow(), 'cd_distribuidora', ls_null)
			this.post event itemchanged(this.getrow(), this.object.cd_unidade_federacao, '')

		case 'nm_fantasia'
			this.setitem(this.getrow(), 'nm_fantasia', ls_null)
			this.setitem(this.getrow(), 'cd_distribuidora', ls_null)
			this.post event itemchanged(this.getrow(), this.object.cd_distribuidora, '')
		
		case 'dh_inicio', 'dh_termino'
			this.setitem(this.getrow(), ls_col, ldh_null)
			this.post event itemchanged(this.getrow(), this.object.dh_inicio, '')
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
			
			this.post event editchanged(this.getrow(), this.object.de_produto, ivo_Produto.ivs_Descricao_Apresentacao_Estoque)
		End If
	End If

	If This.GetColumnName() = "nm_unidade_federacao" Then
		
		ivo_uf.of_Localiza_uf(This.GetText())
		
		If ivo_uf.Localizado Then
			
			This.Object.cd_unidade_federacao[This.GetRow()] = ivo_uf.cd_unidade_federacao
			This.Object.nm_unidade_federacao[This.GetRow()] = ivo_uf.nm_unidade_federacao
			
			this.post event editchanged(this.getrow(), this.object.nm_unidade_federacao, ivo_uf.nm_unidade_federacao)
		End If
	End If

	If This.GetColumnName() = "nm_fantasia" Then
		
		ivo_fornecedor.of_Localiza_fornecedor(This.GetText())
		
		If ivo_fornecedor.Localizado Then
			
			This.Object.nm_fantasia[This.GetRow()]      = ivo_fornecedor.nm_fantasia
			This.Object.cd_distribuidora[This.GetRow()] = ivo_fornecedor.cd_fornecedor
				
			this.post event editchanged(this.getrow(), this.object.nm_fantasia, ivo_fornecedor.nm_fantasia)
		End If
	End If
	
	this.post setrow(this.getrow())
End If
end event

event dw_2::editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)

dw_1.Enabled = False
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto

String lvs_Distribuidora
String lvs_uf
String lvs_rede_filial
String lvs_id_ativos
String lvs_id_futuros

dw_1.AcceptText()

lvs_Distribuidora				= dw_1.Object.Cd_Distribuidora	[1]
lvl_Produto						= dw_1.Object.Cd_Produto			[1]
lvs_UF							= dw_1.Object.Cd_UF					[1]
lvs_rede_filial				= dw_1.Object.id_rede_filial		[1]
lvs_id_ativos					= dw_1.Object.id_ativos				[1]
lvs_id_futuros					= dw_1.Object.id_futuros			[1]

If Not IsNull(lvs_Distribuidora) and lvs_Distribuidora <> "000000000" Then
	This.of_AppendWhere("p.cd_distribuidora = '" + lvs_Distribuidora + "'")
End If
	
If is_Produto = "" Then
	If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
		This.of_AppendWhere("p.cd_produto = " + String(lvl_Produto))
	End If
else
	This.of_AppendWhere("p.cd_produto in (" + is_Produto + ")")
end if

If Not IsNull(lvs_rede_filial) and Trim(lvs_rede_filial) <> "XX" Then
	This.of_AppendWhere("p.id_rede_filial = '" + lvs_rede_filial + "'")
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
		lvl_cd_desbloqueio, &
		lvl_count

boolean	lvb_existe 

dwitemstatus ldw_itemstatus

this.accepttext()

for i = 1 to this.rowcount()
	ldw_itemstatus     = this.getitemstatus(i, 0, primary!)
	lvl_cd_desbloqueio = this.object.cd_desbloqueio[i]
	
	if ldw_itemstatus = datamodified! then
		if this.getitemstatus(i, 'cd_produto', primary!) = datamodified! &
		or this.getitemstatus(i, 'id_rede_filial', primary!) = datamodified!  &
		or this.getitemstatus(i, 'cd_unidade_federacao', primary!) = datamodified! &
		or this.getitemstatus(i, 'cd_distribuidora', primary!) = datamodified! then
		
			// se $$HEX1$$e900$$ENDHEX$$ uma configuracao ja existente, nao permite alterar criterios se ela ja tiver sido aplicada em algum pedido
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
		if isnull(this.object.cd_produto[i]) then
			Messagebox('Erro', 'Selecione um produto para continuar.', stopsign!)
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
		
		// verifica se ja existe configuracao de desbloqueio com mesmos criterios e mesmo periodo ou com periodos que se sobrepoem
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
ll_Linha = This.Find("isnull(cd_desbloqueio)", 0, ll_Total)

if not wf_Proximo_Codigo(ll_Proximo_Codigo) then return -1
	
// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While ll_Linha > 0
	
	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.cd_desbloqueio[ll_Linha] = ll_Proximo_Codigo
	
	ll_Linha = This.Find("isnull(cd_desbloqueio)", ll_Linha, ll_Total)
	
	ll_Proximo_Codigo ++
Loop

end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;if this.rowcount() > 0 and this.getrow() > 0 then
	ivm_menu.mf_excluir(this.object.id_aplicado[this.getrow()] = 'N')
else
	ivm_menu.mf_excluir(false)
end if
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

event dw_2::itemchanged;call super::itemchanged;

if dwo.name = 'dh_termino' then
	if left(data,10) < string(today(), 'yyyy-mm-dd') then
		if Messagebox('Vig$$HEX1$$ea00$$ENDHEX$$ncia', 'A Data de T$$HEX1$$e900$$ENDHEX$$rmino da Vig$$HEX1$$ea00$$ENDHEX$$ncia $$HEX1$$e900$$ENDHEX$$ menor que a data de hoje, o que significa que voc$$HEX1$$ea00$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ desativando esta Configura$$HEX2$$e700e300$$ENDHEX$$o de Bloqueio e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ mais alter$$HEX1$$e100$$ENDHEX$$-la. Deseja prosseguir?', question!, yesno!) = 2 then
			// rejeita o valor 
			return 2
		end if
	end if
end if

end event

event dw_2::ue_update;call super::ue_update;if ancestorReturnValue > 0 then
	dw_1.Enabled = true
end if

return ancestorReturnValue
end event

event dw_2::ue_cancel;call super::ue_cancel;dw_1.Enabled = true
end event

event dw_2::ue_addrow;call super::ue_addrow;parent.ivb_Valida_Salva = true

return ancestorreturnvalue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;if pl_linhas > 0 then
	ivm_Menu.mf_SalvarComo(true)
else
	ivm_Menu.mf_SalvarComo(false)
end if

return 1
end event

