HA$PBExportHeader$w_ge300_sugestao_compra.srw
forward
global type w_ge300_sugestao_compra from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge300_sugestao_compra from dc_w_selecao_lista_relatorio
string tag = "w_ge300_sugestao_compra"
integer width = 3639
integer height = 2080
string title = "GE300 - Relat$$HEX1$$f300$$ENDHEX$$rio de Sugest$$HEX1$$e300$$ENDHEX$$o de Compra"
end type
global w_ge300_sugestao_compra w_ge300_sugestao_compra

type variables
Date ivdt_Inicio, &
     ivdt_Termino

end variables

forward prototypes
public subroutine wf_verifica_ajuste ()
public subroutine wf_em_separacao ()
end prototypes

public subroutine wf_verifica_ajuste ();Long lvl_Linhas,&
		lvl_Linha,&
		lvl_Produto,&
		lvl_Qtde,&
		lvl_Find,&
		lvl_Insert, &
		lvl_dias, & 
		lvl_saldo
		
		
String lvs_Entrada_Saida, &
         lvs_descricao, &
		lvs_de_subgrupo, &
		lvs_cd_grupo,&
		lvs_apresentacao_estoque,& 
		lvs_apresentacao_venda
		
Date dt_inicio, &
		dt_termino
		
Decimal lvdc_soma_qt_fat  

dw_1.AcceptText()

dt_Inicio 		 =  dw_1.Object.dt_Inicio  	[1]
dt_Termino	 =  dw_1.Object.dt_Termino[1]
		
dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

If Not lvds.of_changedataobject("ds_ge300_lista_ajuste") Then
	Destroy(lvds)
	Return
End If

lvds.Retrieve(dt_inicio, dt_termino)

lvl_Linhas = lvds.RowCount()

lvl_dias                               = DaysAfter(dt_Inicio, dt_Termino)

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto 						= lvds.Object.cd_produto		[lvl_Linha]
	lvs_Entrada_Saida				= lvds.Object.id_entrada_saida[lvl_Linha]
     lvl_Qtde           				= lvds.Object.qt_ajuste			[lvl_Linha]
	lvs_descricao					= lvds.Object.de_produto		[lvl_Linha]
	lvs_cd_grupo 					= lvds.Object.cd_subgrupo		[lvl_Linha]
	lvs_de_subgrupo 				= lvds.Object.de_subgrupo		[lvl_Linha]
	lvs_apresentacao_estoque   = lvds.Object.de_apresentacao_estoque[lvl_Linha]
	lvs_apresentacao_venda      = lvds.Object.de_apresentacao_venda [lvl_Linha]
	lvl_saldo                             = lvds.Object.saldo	[lvl_Linha]
		
	lvl_Find = dw_2.Find("cd_produto = " + string(lvl_Produto),1 , dw_2.RowCount())
		 
	If lvl_Find > 0 Then
		If lvs_Entrada_Saida = 'E' Then
			dw_2.Object.ajuste_entrada[lvl_Find] = lvl_Qtde
		Else
			dw_2.Object.ajuste_saida[lvl_Find] = lvl_Qtde
		End If
	End If
	
	If lvl_Find = 0 Then
		lvl_Insert = dw_2.InsertRow(0)
		
		If lvl_Insert > 0 Then
			
			dw_2.Object.cd_produto						[lvl_Insert] = lvl_Produto
			dw_2.Object.de_produto						[lvl_Insert] = lvs_descricao
			dw_2.Object.cd_subgrupo					[lvl_Insert] = lvs_cd_grupo
			dw_2.Object.de_subgrupo					[lvl_Insert] = lvs_de_subgrupo
			dw_2.Object.de_apresentacao_estoque  [lvl_Insert] = lvs_apresentacao_estoque
			dw_2.Object.de_apresentacao_venda     [lvl_Insert] = lvs_apresentacao_venda
			dw_2.Object.saldo                                [lvl_Insert] = lvl_saldo 
			dw_2.Object.qt_transf                           [lvl_Insert] = 0
			dw_2.Object.dt_ini				 				[lvl_Insert] = String(dt_Inicio) 
			dw_2.Object.dt_Ter							[lvl_Insert] = String(dt_Termino)	
			dw_2.Object.nr_dias							[lvl_Insert] =  lvl_dias
			dw_2.Object.media_dia                         [lvl_Insert] = 0
		    dw_2.Object.media_mes                        [lvl_Insert]  = 0
			
			
			If lvs_Entrada_Saida = 'E' Then
				dw_2.Object.ajuste_entrada[lvl_Insert] 	= lvl_Qtde
				dw_2.Object.ajuste_saida[lvl_Insert] 		= 0
			Else
				dw_2.Object.ajuste_entrada[lvl_Insert] 	= 0
				dw_2.Object.ajuste_saida[lvl_Insert] 		= lvl_Qtde
			End If
		End If
	End If
	
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto.", StopSign!)
		Exit
	End If 
		
Next

Destroy(lvds)
end subroutine

public subroutine wf_em_separacao ();Long ll_Linha, ll_Produto, ll_Qtde_Transf, ll_Qtde_Separacao, ll_Qtde_Ped_Separacao

Date ldt_Movimento 

ldt_Movimento = RelativeDate ( Date(gf_GetServerDate()), -5 )

Open(w_Aguarde)

w_Aguarde.Title = "Verificando a quantidade em separa$$HEX2$$e700e300$$ENDHEX$$o..."

For ll_Linha = 1 To dw_2.RowCount()
	ll_Produto = dw_2.Object.cd_produto[ll_Linha]
	
	Select coalesce(sum(qt_transferida), 0)
	Into :ll_Qtde_Transf
	from nf_transferencia n
	inner join item_nf_transferencia i
		on i.cd_filial_origem = n.cd_filial_origem
		and i.nr_nf		= n.nr_nf
		and i.de_especie 	= n.de_especie
		and i.de_serie		= n.de_serie
	where n.dh_movimentacao_caixa >= :ldt_Movimento
		and n.cd_filial_origem 					= 534
		and n.dh_cancelamento 					is null
		and n.dh_atualizacao_mov_estoque 	is null
		and i.cd_produto 							= :ll_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo pendente da nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia.")
		Return
	End If

	SELECT coalesce(sum(b.qt_pedida * b.qt_caixa_padrao), 0) 
	Into :ll_Qtde_Separacao
	FROM wms_lista_separacao a
	INNER JOIN wms_lista_separacao_produto b ON b.cd_filial = a.cd_filial
											AND b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
											AND b.nr_volume = a.nr_volume 
	WHERE a.dh_termino_conferencia is null
	  	AND a.dh_cancelamento is null
	 	AND a.dh_geracao >= :ldt_Movimento
	  	AND b.cd_produto =:ll_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo pendente.")
		Return
	End If
	
	SELECT coalesce(sum(b.qt_pedida * b.qt_caixa_padrao), 0) 
	Into :ll_Qtde_Ped_Separacao
	FROM wms_lista_separacao a
	INNER JOIN wms_lista_separacao_produto b ON b.cd_filial = a.cd_filial
											AND b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
											AND b.nr_volume = a.nr_volume 
	INNER JOIN pedido_distribuidora p
		on p.cd_filial = a.cd_filial
		and p.nr_pedido_distribuidora = a.nr_pedido_distribuidora
	WHERE a.dh_termino_conferencia is not null
	  	AND a.dh_cancelamento is null
	 	AND a.dh_geracao >= :ldt_Movimento
	  	AND b.cd_produto =:ll_Produto
		AND p.id_situacao in ('S', 'T')
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo pendente - PEDIDO EM SEPARACAO.")
		Return
	End If
	
	dw_2.Object.qt_separacao[ll_Linha] = ll_Qtde_Transf + ll_Qtde_Separacao + ll_Qtde_Ped_Separacao
	  
Next

Close(w_Aguarde)
end subroutine

on w_ge300_sugestao_compra.create
call super::create
end on

on w_ge300_sugestao_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio		[1] = RelativeDate(Today(), -1)
dw_1.Object.dt_termino	[1] = Today()

end event

event ue_preopen;call super::ue_preopen;MaxWidth	= 6500
MaxHeight	= 2000
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge300_sugestao_compra
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge300_sugestao_compra
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge300_sugestao_compra
integer y = 224
integer width = 3534
integer height = 1652
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge300_sugestao_compra
integer width = 1294
integer height = 208
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge300_sugestao_compra
integer y = 96
integer width = 1239
integer height = 88
string dataobject = "dw_ge300_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge300_sugestao_compra
integer y = 284
integer width = 3461
integer height = 1564
string dataobject = "dw_ge300_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;dw_1.AcceptText()

ivdt_Inicio  	  = dw_1.Object.dt_Inicio    [1]
ivdt_Termino = dw_1.Object.dt_Termino[1]

If IsNull(ivdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ivdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If ivdt_Inicio > ivdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior ou igual a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

Return This.Retrieve(ivdt_Inicio, ivdt_Termino)
end event

event dw_2::ue_postretrieve;Long lvl_linhas, &
	   lvl_linha, &
	   lvl_dias
		
Decimal lvdc_soma_qt_fat	, &
 	   lvdc_media_dia
		 

lvl_linhas = dw_2.rowCount( )

If lvl_linhas > 0 Then

	For lvl_linha = 1 To lvl_linhas
		
		lvdc_soma_qt_fat = dw_2.Object.qt_transf[lvl_linha]
		lvl_dias = DaysAfter(ivdt_Inicio, ivdt_Termino )
		dw_2.Object.dt_ini[lvl_linha] = String(ivdt_Inicio) 
		dw_2.Object.dt_ter[lvl_linha] = String(ivdt_Termino)
		dw_2.Object.nr_dias[lvl_linha] =  lvl_dias
		lvdc_media_dia = round(lvdc_soma_qt_fat/lvl_dias, 2)
	     dw_2.Object.media_dia[lvl_linha] = lvdc_media_dia
		dw_2.Object.media_mes[lvl_linha] = round(lvdc_media_dia * 30,2)
		
	Next
	
	wf_Verifica_Ajuste()
	
	wf_Em_Separacao()
	
	This.Sort()
	This.GroupCalc()
	
	This.ivm_Menu.mf_SalvarComo(True)	

End If

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge300_sugestao_compra
integer x = 2135
integer y = 20
integer width = 928
integer height = 160
end type

