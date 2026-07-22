HA$PBExportHeader$w_ge569_almoxarifado_pedido_compra.srw
forward
global type w_ge569_almoxarifado_pedido_compra from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge569_almoxarifado_pedido_compra from dc_w_selecao_lista_relatorio
string tag = "w_ge569_almoxarifado_pedido_compra"
integer width = 4850
integer height = 3188
string title = "GE569 - Sugest$$HEX1$$e300$$ENDHEX$$o de Compra Almoxarifado"
end type
global w_ge569_almoxarifado_pedido_compra w_ge569_almoxarifado_pedido_compra

type variables
uo_Fornecedor  	ivo_Fornecedor
uo_produto 			ivo_produto
String is_in_subgrupo
String ivs_in_divisao
end variables

forward prototypes
public subroutine wf_selecionar_subgrupo_almoxarifado ()
public function boolean wf_media_dia_mes (long al_cd_produto, ref decimal adc_media_dia, ref decimal adc_media_mes)
public function boolean wf_verificar_produto_amoxarifado (long al_cd_produto)
public subroutine _documentacao ()
public function boolean wf_carrega_falta (long al_produto, ref long al_qtd)
public function boolean wf_selecionar_divisao (string as_fornecedor)
public function integer wf_possui_divisao (string ps_cd_fornecedor)
public subroutine wf_lista_divisao_fornecedor ()
public function boolean wf_venda_diaria_almoxarifado (long al_cd_produto, ref decimal ad_venda_diaria, ref decimal ad_venda_mes)
public function boolean wf_qtd_pedido_colocado (long al_cd_produto, ref long al_qtd_pedida, string as_cd_fornecedor, ref long al_qtd_recebida)
end prototypes

public subroutine wf_selecionar_subgrupo_almoxarifado ();str_subgrupo lstr_subgrupo

Long ll_Linha


OpenWithParm(w_ge569_subgrupo_almoxarifado, lstr_subgrupo)
	
lstr_subgrupo = Message.PowerObjectParm

If IsNull(lstr_subgrupo) Then
	dw_1.object.de_subgrupo[1] = ''
	Return 
End If

dw_1.object.cd_subgrupo[1] = ''

If UpperBound(lstr_subgrupo.cd_subgrupo) = 1 Then
	dw_1.object.de_subgrupo[1] = lstr_subgrupo.de_subgrupo[1]
	dw_1.object.cd_subgrupo[1] = lstr_subgrupo.cd_subgrupo[1]
Else
	dw_1.object.de_subgrupo[1] = lstr_subgrupo.de_subgrupo_in
End If	

is_in_subgrupo = ''	
	
If IsValid(lstr_subgrupo) Then		
	For ll_Linha = 1 To UpperBound(lstr_subgrupo.cd_subgrupo)
		If ll_Linha <  UpperBound(lstr_subgrupo.cd_subgrupo) Then
			is_in_subgrupo = is_in_subgrupo + lstr_subgrupo.cd_subgrupo[ll_Linha] + ', '
		Else
			is_in_subgrupo = is_in_subgrupo + lstr_subgrupo.cd_subgrupo[ll_Linha]
		End If
	Next
End If

end subroutine

public function boolean wf_media_dia_mes (long al_cd_produto, ref decimal adc_media_dia, ref decimal adc_media_mes);Long ll_qtd_transf1
Long ll_qtd_transf2
Long ll_dias, ll_qtd_transferida
Dec ldc_media_dia, ldc_soma_qt_fat
Dec ldc_media_mes
DateTime ldh_inicio, ldh_terminio
String ls1, ls2

///ldh_inicio			=	DateTime(String(RelativeDate( Today() , - 91 )) +  " 00:00:00.000"  )
///ldh_terminio 	=	DateTime(String( Today() ) + " 23:59:59.000")

Select coalesce(sum(qt_faturada), 0 ) as qt_transf1
Into :ll_qtd_transf1
From	nf_almoxarifado p 
Inner Join item_nf_almoxarifado pp 	on 	pp.nr_nf			= p.nr_nf
Inner Join produto_geral g 			ON 	g.cd_produto	= pp.cd_produto	
inner join parametro x
		on x.id_parametro = '1' 
Where g.cd_produto =:al_cd_produto
and p.dh_movimentacao_caixa >= dateadd(day, -91, x.dh_movimentacao)
And p.dh_cancelamento	is null
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Erro ao totalizar quantidade transfeirada - 1!',stopsign!)	
	Return False
End If	

Select  coalesce(sum(qt_transferida), 0 ) as qt_transf2
Into :ll_qtd_transf2
From nf_transferencia p  
Inner Join item_nf_transferencia pp on  	pp.cd_filial_origem	= p.cd_filial_origem 	
		And pp.nr_nf					= p.nr_nf 				
		And pp.de_especie  		= p.de_especie
		And pp.de_serie 				= p.de_serie					
inner join parametro x
		on x.id_parametro = '1' 		
Where 	 p.dh_movimentacao_caixa >= dateadd(day, -91, x.dh_movimentacao)
And p.cd_filial_origem = 534  
And p.id_almoxarifado = 'S'
And pp.cd_produto =:al_cd_produto
And p.dh_cancelamento	is null
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Erro ao totalizar quantidade transfeirada - 2!',stopsign!)	
	Return False
End If

If IsNull(ll_qtd_transf1) Then ll_qtd_transf1 = 0
If IsNull(ll_qtd_transf2) Then ll_qtd_transf2 = 0

ll_qtd_transferida = ll_qtd_transf1 + ll_qtd_transf2

// Calculo Dia e M$$HEX1$$ea00$$ENDHEX$$s
ldc_soma_qt_fat 	= 	ll_qtd_transferida
adc_media_dia 	= 	round(ldc_soma_qt_fat / 90, 2)
adc_media_mes	=	round(adc_media_dia * 30,2)	


Return True
end function

public function boolean wf_verificar_produto_amoxarifado (long al_cd_produto);long ll_existe
 
 Select count(1)
    Into :ll_existe
 From produto_geral d   
 Inner join vw_classificacao_produto As cp On cp.cd_subcategoria = d.cd_subcategoria
 Where cp.cd_grupo = '5'
    And d.cd_produto =:al_cd_produto
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao acessar tabela Produto Geral.",stopsign!)
	Return False
End If

If ll_existe = 0 Then
	Return False
End If	

Return True






end function

public subroutine _documentacao ();/*	  Objetivo: Objetivo desse relat$$HEX1$$f300$$ENDHEX$$rio $$HEX1$$e900$$ENDHEX$$ ter sugest$$HEX1$$e300$$ENDHEX$$o de compra de produtos para almoxarifado
	Chamado: 1090485
Respons$$HEX1$$e100$$ENDHEX$$vel: Saulo Braga

Tabelas: 
			-	resumo_reposicao_estoque
			-	filial
			-	produto_central
			-	produto_geral
			-	vw_porte_filial
			-	vw_saldo_atual_produto
			-	fornecedor
			- 	vw_classificacao_produto
			- 	mix_produto_filial
			-	nf_almoxarifado
			-	item_nf_almoxarifado
			-	item_nf_transferencia
			-	nf_transferencia
			-	pedido_central 
			-	pedido_central_produto 
			-	nf_almoxarifado
			-	item_nf_almoxarifado
			- 	parametro 


*/






end subroutine

public function boolean wf_carrega_falta (long al_produto, ref long al_qtd);
Select   coalesce (   	sum(pp.qt_pedida - (Case
										When pp.qt_atendida < 0 Then 0
										Else pp.qt_atendida
									End)) ,  0 )   	As falta
Into :al_qtd									
From pedido_almoxarifado p
Inner Join pedido_almoxarifado_produto As pp
	On pp.cd_filial		= p.cd_filial
   And pp.nr_pedido	= p.nr_pedido
Inner Join produto_geral As g
	On g.cd_produto = pp.cd_produto
Inner join parametro x
		on x.id_parametro = '1' 	
Where  p.dh_importacao >= dateadd(day, -1, x.dh_movimentacao)    
    And (pp.qt_pedida - pp.qt_atendida > 0)
    And p.id_situacao Not In ('C', 'X')
    And g.cd_produto =:al_produto
Using SqlCA;	 

If Sqlca.Sqlcode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Erro ao atualizar quantidade falta!',stopsign!)	
	Return False
End If	




Return True 
end function

public function boolean wf_selecionar_divisao (string as_fornecedor);


str_divisao_fornecedor lstr_divisao_fornecedor

Long ll_Linha

If IsNull(dw_1.Object.Cd_Fornecedor[dw_1.GetRow()]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum fornecedor foi selecionado.")
	Return False
End If
	
If wf_Possui_Divisao(dw_1.Object.Cd_Fornecedor[dw_1.GetRow()]) <> 1 Then Return False
	
lstr_divisao_fornecedor.cd_fornecedor 					= dw_1.Object.cd_fornecedor[dw_1.GetRow()]
lstr_divisao_fornecedor.id_selecao_varias_divisoes 	= 'N'
	
OpenWithParm(w_ge564_divisao_fornecedor, lstr_divisao_fornecedor)
	
lstr_divisao_fornecedor = Message.PowerObjectParm

If IsNull(lstr_divisao_fornecedor) Then
	dw_1.object.de_divisao_fornecedor[1] = 'TODOS'
	Return False
End If

If UpperBound(lstr_divisao_fornecedor.nr_divisao) = 1 Then
	dw_1.object.de_divisao_fornecedor[1] = lstr_divisao_fornecedor.de_divisao[1]
Else
	dw_1.object.de_divisao_fornecedor[1] = lstr_divisao_fornecedor.nr_divisoes_in
End If	

ivs_in_divisao = ''	
	
If IsValid(lstr_divisao_fornecedor) Then		
	For ll_Linha = 1 To UpperBound(lstr_divisao_fornecedor.nr_divisao)
		If ll_Linha <  UpperBound(lstr_divisao_fornecedor.nr_divisao) Then
			ivs_in_divisao = ivs_in_divisao + String(lstr_divisao_fornecedor.nr_divisao[ll_Linha]) + ', '
		Else
			ivs_in_divisao = ivs_in_divisao + String(lstr_divisao_fornecedor.nr_divisao[ll_Linha])
		End If
	Next
End If


Return True
end function

public function integer wf_possui_divisao (string ps_cd_fornecedor);


Long ll_Achou

Select Count(*)
	Into: ll_Achou
From fornecedor_divisao
Where cd_fornecedor = :ps_cd_Fornecedor
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se o fornecedor possui divis$$HEX1$$e300$$ENDHEX$$o. " + SqlCa.SqlErrText, StopSign!)
	Return -1	
End If

If ll_Achou > 0 Then
	Return 1
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor n$$HEX1$$e300$$ENDHEX$$o possui divis$$HEX1$$e300$$ENDHEX$$o.")
	Return 0 //N$$HEX1$$e300$$ENDHEX$$o possui divis$$HEX1$$e300$$ENDHEX$$o, ent$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o abre a tela response w_ge003_divisao_fornecedor
End If
end function

public subroutine wf_lista_divisao_fornecedor ();


DataWindowChild lvdwc

String ls_SQL, ls_Fornecedor

dw_1.AcceptText()

ls_Fornecedor = dw_1.Object.cd_fornecedor[1]
	
If dw_1.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
		
	ls_SQL = " SELECT 	cast(f.nr_divisao as char(5)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao, f.nr_divisao FROM fornecedor_divisao f   " +&
				 " inner join usuario u on u.nr_matricula = f.nr_matricula_comprador " +&
				 " where f.cd_fornecedor = '" + string(ls_Fornecedor) + "'" +&
				 " union " +&
				 " select 'NENHUMA', null"	
	
	lvdwc.SetSQLSelect(ls_SQL)
		
	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return 
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild divis$$HEX1$$e300$$ENDHEX$$o fornecedor.")
End If
end subroutine

public function boolean wf_venda_diaria_almoxarifado (long al_cd_produto, ref decimal ad_venda_diaria, ref decimal ad_venda_mes);Long ll_Transferencia
Long ll_Ajuste_E
Long ll_Ajuste_S
Long ll_Transferencia_Almox

//verificar as transfer$$HEX1$$ea00$$ENDHEX$$ncias do produto nos $$HEX1$$fa00$$ENDHEX$$ltimos 90 dias
Select COALESCE(sum(qt_faturada) , 0 )
	Into :ll_Transferencia
From	nf_almoxarifado p  
Inner join item_nf_almoxarifado pp 
		on pp.nr_nf = p.nr_nf 
Inner join parametro x
		on x.id_parametro = '1' 
Where p.dh_cancelamento	is null 
	And p.dh_movimentacao_caixa >= dateadd(day, -91, x.dh_movimentacao)
	And pp.cd_produto = :al_cd_produto
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDBError("Erro ao localizar a qt transferida do produto " + String(al_cd_produto) + ". " + SqlCa.SQLErrText)
	Return False
End If


Select COALESCE(sum(qt_transferida) , 0 )
	Into :ll_Transferencia_Almox
From	nf_transferencia p  
Inner Join item_nf_transferencia pp 
		on pp.cd_filial_origem = p.cd_filial_origem
		and pp.nr_nf = p.nr_nf 
		and pp.de_especie = p.de_especie
		and pp.de_serie	= p.de_serie
Inner join parametro x
		on x.id_parametro = '1' 
Where p.cd_filial_origem = 534
	and p.dh_movimentacao_caixa >= dateadd(day, -91, x.dh_movimentacao)
	and p.id_almoxarifado = 'S'
    and p.dh_cancelamento	is null 
	and pp.cd_produto = :al_cd_produto
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDBError("Erro ao localizar a qt transferida do produto " + String(al_cd_produto) + ". " + SqlCa.SQLErrText)
	Return False
End If

ll_Transferencia = ll_Transferencia + ll_Transferencia_Almox
 
select COALESCE( qt_entrada , 0 ), COALESCE( qt_saida , 0 )
	Into :ll_Ajuste_E, :ll_Ajuste_S
From (select Sum(a.qt_ajuste) as qt_entrada
			from ajuste_estoque a, parametro x 
		 Where x.id_parametro = '1' 
			 and a.dh_movimentacao_caixa between dateadd(day, -91, x.dh_movimentacao) and dateadd(day, -1, x.dh_movimentacao )  
			 and a.id_entrada_saida = 'E'
			 and a.cd_produto = :al_cd_produto
			 and a.cd_filial_ajuste = x.cd_filial_matriz ) as entrada,

		 (select Sum(b.qt_ajuste) as qt_saida
			from ajuste_estoque b, parametro x 
		 Where x.id_parametro = '1' 
			 and b.dh_movimentacao_caixa between dateadd(day, -91, x.dh_movimentacao) and dateadd(day, -1, x.dh_movimentacao )  
			 and b.id_entrada_saida = 'S'
			 and b.cd_produto = :al_cd_produto
			 and b.cd_filial_ajuste = x.cd_filial_matriz ) as saida
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDBError("Erro ao localizar os ajustes de estoque do produto " + String(al_cd_produto) + ". " + SqlCa.SQLErrText)
	Return False
End If

//Se o resultado da conta qt_ajuste_saida - qt_ajuste_entrada for maior que zero, este valor ter$$HEX1$$e100$$ENDHEX$$ que ser somado na quantidade transferida;
If (ll_Ajuste_S - ll_Ajuste_E) > 0 Then ll_Transferencia = ll_Transferencia + (ll_Ajuste_S - ll_Ajuste_E)

// Venda Di$$HEX1$$e100$$ENDHEX$$ria
ad_venda_diaria = Round(ll_Transferencia / 90, 2)
ad_venda_mes	=	round(ad_venda_diaria * 30,2)	


Return True
end function

public function boolean wf_qtd_pedido_colocado (long al_cd_produto, ref long al_qtd_pedida, string as_cd_fornecedor, ref long al_qtd_recebida);Long ll_qtd_pedida, ll_qtd_recebida

DateTime  ldh_inicio, ldh_terminio

ldh_inicio			=	DateTime(String(RelativeDate( Today() , - 190 )) +  " 00:00:00.000"  )
ldh_terminio 	=	DateTime(String( Today() ) + " 23:59:59.000")


Select coalesce( SUM(b.qt_pedida) , 0 )    ,    (coalesce( Sum(b.qt_recebida),0) - coalesce(sum(b.qt_devolvida),0))
Into :ll_qtd_pedida , :ll_qtd_recebida
From pedido_central a
Inner join pedido_central_produto b on a.nr_pedido  = b.nr_pedido 
Inner join fornecedor f1 on f1.cd_fornecedor  = a.cd_fornecedor 
Where a.id_situacao  = 'C'
And a.dh_pedido  		BETWEEN :ldh_inicio and :ldh_terminio
And b.cd_produto 		=:al_cd_produto
Using Sqlca;	

If Sqlca.Sqlcode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Erro ao acessar a tabela de Pedido Central de Produto.',stopsign!)
	Return False
End If

al_qtd_pedida = ll_qtd_pedida
al_qtd_recebida = ll_qtd_recebida
	
Return True	
end function

on w_ge569_almoxarifado_pedido_compra.create
call super::create
end on

on w_ge569_almoxarifado_pedido_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Fornecedor = Create uo_Fornecedor

ivo_produto = Create uo_produto
end event

event close;call super::close;Destroy ivo_Fornecedor

Destroy ivo_produto
end event

event ue_postopen;call super::ue_postopen;dw_1.object.id_situacao[1] = 'T'
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge569_almoxarifado_pedido_compra
integer x = 2674
integer y = 1804
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge569_almoxarifado_pedido_compra
integer x = 2638
integer y = 1732
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge569_almoxarifado_pedido_compra
integer y = 580
integer width = 4759
integer height = 2408
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge569_almoxarifado_pedido_compra
integer x = 41
integer width = 2501
integer height = 552
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge569_almoxarifado_pedido_compra
integer width = 2350
integer height = 432
string dataobject = "dw_ge569_selecao"
end type

event dw_1::ue_key;call super::ue_key;String ls_Coluna
String ls_subgrupo,&
		 lvs_fornecedor
Long ll_cd_produto

If Key = KeyEnter! Then
	ls_Coluna = This.GetColumnName()
	
	Choose Case ls_Coluna 
		
		Case "de_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.de_fornecedor	[1] = ivo_Fornecedor.Nm_Razao_Social
			End If	
	
	
		Case "de_divisao_fornecedor"
			    lvs_fornecedor = This.Object.Cd_Fornecedor[1] 
				wf_selecionar_divisao(lvs_fornecedor)
	
	
		Case "de_produto"
			ivo_produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				
				This.Object.Cd_Produto	[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If	
			
			If Not wf_verificar_produto_amoxarifado(ivo_Produto.Cd_Produto)  Then
				
				ivo_Produto.of_inicializa( )
				
				This.Object.Cd_Produto	[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto n$$HEX1$$e300$$ENDHEX$$o pertence ao almoxarifado.",information!)
				Return
			End If

		Case "de_subgrupo"
	
	   		wf_selecionar_subgrupo_almoxarifado()
	
	
	End Choose
End If
end event

event dw_1::itemchanged;String ls_de_subgrupo
Long ll_cd_produto


dw_2.reset()

Choose Case dwo.Name
	Case "de_produto"
		
//		ll_cd_produto = ivo_produto.cd_produto
//			
//		If Not wf_verificar_produto_amoxarifado(ll_cd_produto)  Then
//			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto n$$HEX1$$e300$$ENDHEX$$o pertence ao almoxarifado.",information!)
//			Return
//		End If	
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			
		End If
	Case "de_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_fornecedor.of_Inicializa()
			
			This.Object.Cd_fornecedor	[1] = ivo_fornecedor.Cd_fornecedor
			This.Object.De_fornecedor	[1] = ivo_fornecedor.nm_fantasia
			
		End If
	Case "de_subgrupo"

         dw_1.AcceptText()

		ls_de_subgrupo = dw_1.Object.de_subgrupo[1]

		If ls_de_subgrupo = '' Then
			dw_1.Object.cd_subgrupo[1] = ''
		Else
   			wf_selecionar_subgrupo_almoxarifado()	
		End If
End Choose



end event

event dw_1::editchanged;call super::editchanged;long ll_dias_estoque_ini, ll_dias_estoque_fim
long ll_dias_suprimentos_ini, ll_dias_suprimentos_fim

This.AcceptText()

ll_dias_estoque_ini 		= This.Object.dias_estoque_ini[1]
ll_dias_estoque_fim 		= This.Object.dias_estoque_fim[1]
ll_dias_suprimentos_ini 	= This.Object.dias_supri_ini[1]
ll_dias_suprimentos_fim 	= This.Object.dias_supri_fim[1]

If ll_dias_estoque_ini < 0 Or ll_dias_estoque_fim < 0 then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar faixa do valor positivo para Dias Estoque.",information!)
	If ll_dias_estoque_ini < 0 Then This.Object.dias_estoque_ini[1]	= 0 
	If ll_dias_estoque_fim < 0 Then This.Object.dias_estoque_fim[1]	= 0
	Return
End If	

If ll_dias_suprimentos_ini < 0 or ll_dias_suprimentos_fim < 0 then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar faixa valor positivo para Dias Suprimento.",information!)
	If	ll_dias_suprimentos_ini < 0 Then This.Object.dias_supri_ini[1] = 0
	If	ll_dias_suprimentos_fim 	< 0 Then  This.Object.dias_supri_fim[1] = 0
	Return
End If	

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge569_almoxarifado_pedido_compra
integer x = 55
integer y = 652
integer width = 4727
integer height = 2320
string dataobject = "dw_ge569_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//Overrider
String ls_cd_fornecedor, &
          ls_id_situacao, &
		 ls_cd_subgrupo	 
			 
Long ll_cd_produto, &
	   ll_dias_estoque, &
	   ll_dias_suprimento		

long ll_dias_estoque_ini, ll_dias_estoque_fim
long ll_dias_suprimentos_ini, ll_dias_suprimentos_fim


dw_1.AcceptText()

ls_cd_fornecedor		=	dw_1.Object.cd_fornecedor[1]
ll_cd_produto			=	dw_1.Object.cd_produto[1]

ls_cd_subgrupo 		=	dw_1.Object.cd_subgrupo[1]
//ll_dias_estoque			=	dw_1.Object.dias_estoque[1]
//ll_dias_suprimento		=	dw_1.Object.dias_suprimento[1]

//If dw_2.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
//	ll_linhas = lvdwc.RowCount()
//	For lvl_cont = 1 To ll_linhas
//		lvs_divisao_fornecedor[ll_linhas] = ''
//	Next	
//End If 	




If Not IsNull(ls_cd_fornecedor) Or ls_cd_fornecedor <> '' Then
	This.of_AppendWhere(" f1.cd_fornecedor = '" + ls_cd_fornecedor +"'")
End If

If ll_cd_produto > 0  Then
	This.of_AppendWhere(" c.cd_produto = " + String(ll_cd_produto) )
End If


If ls_cd_subgrupo <> ''  Then
	This.of_AppendWhere(" cp.cd_subgrupo in ( '" + is_in_subgrupo + "')" )
End If

ll_dias_estoque_ini 		= dw_1.Object.dias_estoque_ini[1]
ll_dias_estoque_fim 		= dw_1.Object.dias_estoque_fim[1]
ll_dias_suprimentos_ini 	= dw_1.Object.dias_supri_ini[1]
ll_dias_suprimentos_fim 	= dw_1.Object.dias_supri_fim[1]

If IsNull(ll_dias_estoque_ini)			Then ll_dias_estoque_ini			= 0
If IsNull(ll_dias_estoque_fim) 		Then ll_dias_estoque_fim		= 0
If IsNull(ll_dias_suprimentos_ini) 	Then ll_dias_suprimentos_ini 	= 0
If IsNull(ll_dias_suprimentos_fim) 	Then ll_dias_suprimentos_fim 	= 0

If ( ll_dias_estoque_ini > 0 And ll_dias_estoque_fim = 0 ) Or ( ll_dias_estoque_ini = 0 And ll_dias_estoque_fim > 0 )then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar faixa para Dias Estoque.",information!)
	Return -1
End If	

If ( ll_dias_suprimentos_ini > 0 And ll_dias_suprimentos_fim = 0 ) Or ( ll_dias_suprimentos_ini = 0 And ll_dias_suprimentos_fim > 0 ) then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar faixa valor positivo para Dias Suprimento.",information!)
	Return -1
End If	

If Len(ivs_in_divisao) > 0 Then
	This.of_AppendWhere(" d.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_cd_fornecedor + "' and nr_divisao in (" + ivs_in_divisao + ") )")
End If



Return This.Retrieve()
end event

event dw_2::ue_postretrieve;// Overrider
String ls_cd_fornecedor

Long ll_cont, ll_row
Long	ll_dias_estoque			&
	,	ll_qt_saldo_final		&
	, 	ll_cd_produto			&
	,	ll_pedido_colocado	&
	,	ll_saldo_final			&
	,	ll_sugestao_compra	&
	, 	ll_cd_filial				&
	, 	ll_Qtd_Falta				&
	, 	ll_Dias_Suprimento   &
	,   ll_qtd_recebida
	

Long ll_filtro_dias_estoque_ini, ll_filtro_dias_estoque_fim
Long ll_filtro_dias_suprimento_ini, ll_filtro_dias_suprimento_fim

Dec ldc_venda_diaria			

Dec ldc_media_dia, ldc_media_mes, ll_perc_ruptura

dw_2.setFilter("")
dw_2.Filter()
dw_1.accepttext( )

ll_row = dw_2.rowcount()
ll_Dias_Suprimento	=	dw_1.Object.nr_dias_suprimento[1]

If Not IsValid(w_aguarde) then
	Open(w_aguarde)
End If	
		
w_aguarde.Title = "Gerando Relat$$HEX1$$f300$$ENDHEX$$rio..."
w_aguarde.uo_progress.of_reset()
w_aguarde.uo_progress.Of_SetMax(ll_row)		

For ll_cont = 1 To ll_row

	ll_cd_produto 		= dw_2.Object.cd_produto[ll_cont]
	ls_cd_fornecedor 	= dw_2.Object.cd_fornecedor_usual[ll_cont]

	w_aguarde.Title = "Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es..."  

	// Calcula Media dia e m$$HEX1$$ea00$$ENDHEX$$s
	//If Not wf_media_dia_mes(ll_cd_produto,ldc_media_dia, ldc_media_mes)  Then
	//	Return -1	
	//End If
  	
	 // Calcula Dias de Estoque     
	If Not wf_venda_diaria_almoxarifado(  ll_cd_produto, Ref ldc_venda_diaria, Ref ldc_media_mes   ) Then
		Return -1
	End If
	  
	dw_2.Object.media_dia	[ll_cont]	=	ldc_venda_diaria
	dw_2.Object.media_mes	[ll_cont]	=	ldc_media_mes 

	
	// Pedido Colocado
	If Not wf_qtd_pedido_colocado(ll_cd_produto, Ref ll_pedido_colocado,ls_cd_fornecedor, Ref ll_qtd_recebida  ) Then
		Return -1
  	End If
	dw_2.Object.Qtd_Pedido[ll_cont]		=	ll_pedido_colocado
	dw_2.Object.qtd_recebida[ll_cont]	=	ll_qtd_recebida
	
	
	
	DateTime ldh_Inicio
	long ll_Saldo_Trans
	
	ldh_Inicio = gf_GetServerDate()
	ldh_Inicio = DateTime(RelativeDate(Date(ldh_Inicio), -30))

	If Not gf_Saldo_Transito_Ec(ldh_Inicio, ll_cd_produto, Ref ll_Saldo_Trans) Then  Return -1
	
	ll_qt_saldo_final	=	dw_2.Object.qt_saldo_final[ll_cont]
	If ldc_venda_diaria > 0 Then
		ll_dias_estoque		=	( ll_qt_saldo_final + ll_Saldo_Trans ) / ldc_venda_diaria
	End If
	dw_2.Object.dias_estoque[ll_cont]	=	ll_dias_estoque
	
		
	// Sugest$$HEX1$$e300$$ENDHEX$$o de Compra
	ll_qt_saldo_final = dw_2.Object.qt_saldo_final[ll_cont]
	//Calcula a quantidade sugerida
	ll_sugestao_compra = Round(ldc_media_mes * ll_Dias_Suprimento, 0) - ll_qt_saldo_final		
	///ll_sugestao_compra = Round(ldc_venda_diaria * ll_Dias_Suprimento, 0) - ll_qt_saldo_final
	If ll_sugestao_compra < 0 Then 
		dw_2.object.sugestao_compra[ll_cont] = 0
	Else
		dw_2.object.sugestao_compra[ll_cont] = ll_sugestao_compra
	End If 
	
	
	If Not wf_carrega_falta(ll_cd_produto , Ref ll_Qtd_Falta ) Then 
		Return -1 
	End If 
	dw_2.Object.qtd_falta[ll_cont]	=	ll_Qtd_Falta
	
	w_aguarde.uo_progress.Of_SetProgress(ll_cont)		
Next	
Close(w_Aguarde)


ll_filtro_dias_estoque_ini 			= dw_1.Object.dias_estoque_ini[1]
ll_filtro_dias_estoque_fim 			= dw_1.Object.dias_estoque_fim[1]
ll_filtro_dias_suprimento_ini			= dw_1.Object.dias_supri_ini[1]
ll_Filtro_dias_suprimento_fim		= dw_1.Object.dias_supri_fim[1]

If ll_filtro_dias_estoque_ini > 0 and ll_filtro_dias_estoque_fim > 0 then
	dw_2.setFilter("dias_estoque >= " + string(ll_filtro_dias_estoque_ini) + " and dias_estoque <= " + string(ll_filtro_dias_estoque_fim) )
	dw_2.Filter()
End If

//If ll_filtro_dias_suprimento_ini > 0 and ll_filtro_dias_suprimento_fim > 0 Then
//	dw_2.setFilter("dias_suprimento >= " + string(ll_filtro_dias_suprimento_ini) + " and dias_suprimento <= " + string(ll_filtro_dias_suprimento_fim))
//	dw_2.Filter()
//End If
////dw_2.of_SetRowSelection("if ( dias_estoque <= 25 , rgb(255, 0 , 0), if( dias_estoque >= 21  and dias_estoque <=60, rgb(255, 255, 255),rgb(255, 255, 255)))" , "if ( dias_estoque >= 61 , rgb(255, 255,255), rgb(255, 255, 255))")

dw_2.Sort()
dw_2.GroupCalc()

If ll_row > 0 then
	ivm_Menu.mf_salvarcomo( True)
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados n$$HEX1$$e300$$ENDHEX$$o retornados.",information!)
	ivm_Menu.mf_salvarcomo( False )
End If	

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge569_almoxarifado_pedido_compra
integer x = 2784
integer y = 56
end type

