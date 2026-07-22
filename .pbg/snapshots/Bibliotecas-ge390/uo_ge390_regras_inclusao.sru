HA$PBExportHeader$uo_ge390_regras_inclusao.sru
forward
global type uo_ge390_regras_inclusao from nonvisualobject
end type
end forward

global type uo_ge390_regras_inclusao from nonvisualobject
end type
global uo_ge390_regras_inclusao uo_ge390_regras_inclusao

type variables
Decimal vl_fator_conversao

Long id_divergencia[]

String cd_grupo_psico
String de_mensagem_erro
String id_geladeira
String de_produto
String de_grupo
String cd_subcategoria
end variables

forward prototypes
public function boolean of_valida_produto (long al_produto)
public subroutine of_inicializa ()
public function long of_movimento_compra (long al_produto)
public function boolean of_grava_produto (long al_produto, string as_uf, boolean ab_mostra_mensagem)
public function boolean of_verifica_produto_ja_incluido (long al_produto, string as_uf)
public function boolean of_valida_inclusao (long al_produto, string as_uf, boolean ab_mostra_mensagem)
public function boolean of_verifica_uf_habilitada (string as_uf, ref string as_id_pedido_exclusivo_falta, ref string as_erro)
end prototypes

public function boolean of_valida_produto (long al_produto);Long ll_Achou

If IsNull(al_Produto) Then Return False

If Not IsNumber(String(al_Produto)) Then Return False

Select g.de_produto + ' : ' + g.de_apresentacao_estoque, g.cd_grupo_psico, coalesce(g.id_geladeira, 'N'), vw.de_grupo, g.vl_fator_conversao, g.cd_subcategoria
	Into :de_produto, :cd_grupo_psico, :id_geladeira, :de_grupo, :vl_fator_conversao, :cd_subcategoria
From produto_geral g
	Inner Join vw_classificacao_produto vw
		On vw.cd_subcategoria = g.cd_subcategoria
Where g.cd_produto = :al_Produto
	And g.id_situacao = 'A'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o produto. " + SqlCa.SqlErrText, StopSign!)
		
End Choose

Return False
end function

public subroutine of_inicializa ();Long ll_Nulo[]

id_divergencia[] = ll_Nulo[]

SetNull(vl_fator_conversao)

SetNull(cd_grupo_psico)
SetNull(de_mensagem_erro)
SetNull(id_geladeira)
SetNull(de_produto)
SetNull(de_grupo)
SetNull(cd_subcategoria)
end subroutine

public function long of_movimento_compra (long al_produto);Long ll_Achou

Date ldh_Limite

//Verifica atendimento via Estoque Central
ldh_Limite = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -90)

Select Count(*) 
Into :ll_Achou
from movimento_estoque m
inner join nf_compra n
	on n.cd_filial = m.cd_filial_movimento
	and n.cd_fornecedor = m.cd_fornecedor
	and n.nr_nf			= m.nr_nf
	and n.de_especie	= m.de_especie
	and n.de_serie		= m.de_serie
inner join pedido_central pc
	on pc.nr_pedido = n.nr_pedido_central
where m.cd_filial_movimento = 534
  	and m.cd_produto = :al_produto
  	and m.dh_movimento >= :ldh_Limite
  	and m.cd_tipo_movimento = 3
  	and coalesce(pc.id_atende_falta_pedido_uf, 'XX') <> 'BA'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a compra do produto no Estoque Central. " + SqlCa.SqlErrText)
	Return -100
End If

Return ll_Achou
end function

public function boolean of_grava_produto (long al_produto, string as_uf, boolean ab_mostra_mensagem);String ls_Exclusivo
String ls_Erro

//O Commit deve ser feito na chamada da fun$$HEX2$$e700e300$$ENDHEX$$o

Select Coalesce(id_pedido_exclusivo_falta, 'N')
	Into :ls_Exclusivo
From produto_uf
Where cd_produto = :al_Produto
And cd_unidade_federacao = :as_uf
Using SqlCa;
	
If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	//Faz o rollback tamb$$HEX1$$e900$$ENDHEX$$m no select porque se os produtos forem atualizados pela planilha, estar$$HEX1$$e100$$ENDHEX$$ no meio de um processo com v$$HEX1$$e100$$ENDHEX$$rios updates
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o 'id_pedido_exclusivo_falta' da tabela produto_uf. " + ls_Erro, StopSign!)
	Return False
End If

If ls_Exclusivo = "N" Then
	Update produto_uf
		Set id_pedido_exclusivo_falta = 'S'
	Where cd_produto = :al_Produto
	And cd_unidade_federacao = :as_uf
	Using SqlCa;
			
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o 'id_exclusivo_pedido_falta_ba' na tabela produto_central. " + ls_Erro, StopSign!)
		Return False
	End If
			
	If Not gf_grava_historico_alteracao_tabela('PRODUTO_UF', String(al_Produto)+'/'+ + as_uf , 'ID_PEDIDO_EXCLUSIVO_FALTA', 'N', 'S', gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Erro, True) Then Return False
		
Else
		
	If ab_Mostra_Mensagem Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto " + String(al_Produto) + " da UF "+as_uf+" j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na lista de produtos exclusivos da Bahia.")
	End If
End If

Return True
end function

public function boolean of_verifica_produto_ja_incluido (long al_produto, string as_uf);String ls_Exclusivo

Select Coalesce(id_pedido_exclusivo_falta, 'N')
	Into: ls_Exclusivo
From produto_uf
Where cd_produto = :al_Produto
And cd_unidade_federacao = :as_uf
Using SqlCa;

If SqlCa.SqlCode = -1 Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se o produto j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ exclusivo." + SqlCa.SqlErrText)
	Return False
End If
	
If ls_Exclusivo = "S" Then
	Return False
Else
	Return True
End If
end function

public function boolean of_valida_inclusao (long al_produto, string as_uf, boolean ab_mostra_mensagem);DateTime ldh_Limite

Long ll_Achou

/* C$$HEX1$$f300$$ENDHEX$$digos de diverg$$HEX1$$ea00$$ENDHEX$$ncias
1 - Produto atendido via Estoque Central
2 - Atendimento via Distribuidora (Medicamento N$$HEX1$$c300$$ENDHEX$$O CONTROLADO)
3 - Atendimento via Distribuidora (Medicamento CONTROLADO)
4 - Produto do tipo Geladeira
5 - Categoria 308003 (Fraldas)*/

//Produto de geladeira n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido
If id_geladeira = "S" Then
	If Not ab_Mostra_Mensagem Then
		id_divergencia[UpperBound(id_divergencia[]) + 1] = 4
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto $$HEX1$$e900$$ENDHEX$$ do tipo GELADEIRA. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida a inclus$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
		Return False
	End If
End If

//Verifica categoria / subcategoria
If Mid(This.Cd_Subcategoria, 1, 6) = "308003" Or This.Cd_Subcategoria = '307003002' Then
	If Not ab_Mostra_Mensagem Then
		id_divergencia[UpperBound(id_divergencia[]) + 1] = 5
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a inclus$$HEX1$$e300$$ENDHEX$$o de produto da categoria Fraldas.", Exclamation!)
		Return False
	End If
End If


//validar daqui pra baixo 


//Verifica atendimento via distribuidora na Bahia
Select Count(*)
	Into :ll_Achou
From distribuidora_produto p
	Inner Join distribuidora_uf u
		On u.cd_distribuidora = p.cd_distribuidora
		And u.cd_unidade_federacao = p.cd_unidade_federacao
Where p.cd_produto = :al_Produto
	And p.id_situacao = 'A'
	And p.cd_unidade_federacao = :as_uf
	And u.id_homologando_pedido = 'N'
	And p.qt_estoque_disponivel > 0
	And p.cd_distribuidora <> (select cd_distribuidora_estoque from parametro)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se o produto $$HEX1$$e900$$ENDHEX$$ atendido via distribuidora. " + SqlCa.SqlErrText)
	Return False
End If

//Se for atendido por distribudora e N$$HEX1$$c300$$ENDHEX$$O for psico, N$$HEX1$$c300$$ENDHEX$$O permite gravar o produto na exclusividade
//Se for atendido por distribuidora e for psico, pergunta ao usu$$HEX1$$e100$$ENDHEX$$rio se o produto ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do
If ll_Achou > 0 Then	
	
	If Not IsNull(cd_grupo_psico) And cd_grupo_psico <> "" Then
		If Not ab_mostra_mensagem Then
			id_divergencia[UpperBound(id_divergencia[]) + 1] = 3
		Else
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto CONTROLADO atendido via distribuidora.~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return False
		End If
	Else
		If Not ab_Mostra_Mensagem Then
			id_divergencia[UpperBound(id_divergencia[]) + 1] = 2
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto N$$HEX1$$c300$$ENDHEX$$O CONTROLADO atendido via distribuidora. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida a inclus$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
			Return False
		End If
	End If
End If

ll_Achou = of_movimento_compra(al_produto)

If ll_Achou = -100 Then Return False

//Se o produto foi atendido pelo CD nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses, pergunta ao usu$$HEX1$$e100$$ENDHEX$$rio se o produto ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na exclusividade
If ll_Achou > 0 Then	
	If Not ab_mostra_mensagem Then	
		id_divergencia[UpperBound(id_divergencia[]) + 1] = 1
	Else
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto teve compra do Estoque Central nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses.~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return False
	End If
End If

Return True
end function

public function boolean of_verifica_uf_habilitada (string as_uf, ref string as_id_pedido_exclusivo_falta, ref string as_erro);SELECT COALESCE(id_pedido_exclusivo_falta, 'N')
INTO :as_id_pedido_exclusivo_falta
FROM unidade_federacao
WHERE cd_unidade_federacao = :as_uf
USING SqlCa;

If SqlCa.SqlCode = -1 Then
	as_erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

Return true
end function

on uo_ge390_regras_inclusao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge390_regras_inclusao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

