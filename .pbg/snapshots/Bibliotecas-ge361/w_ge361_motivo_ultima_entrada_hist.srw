HA$PBExportHeader$w_ge361_motivo_ultima_entrada_hist.srw
forward
global type w_ge361_motivo_ultima_entrada_hist from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge361_motivo_ultima_entrada_hist from dc_w_selecao_lista_relatorio
integer width = 4453
integer height = 2228
string title = "GE361 - Motivo das $$HEX1$$da00$$ENDHEX$$ltimas Entradas"
end type
global w_ge361_motivo_ultima_entrada_hist w_ge361_motivo_ultima_entrada_hist

type variables
uo_gc008_planogramas	io_planogramas	//ge008
uo_ge216_filiais 			ivo_Selecao_filiais
uo_produto					io_Produto

Long il_Lojas

String ivs_filiais
end variables

forward prototypes
public function boolean wf_carrega_informacoes ()
public function boolean wf_dados_promocao (long al_filial, long al_produto, ref string as_id_possui_promo_plan, ref long al_qt_estoque_min)
public function boolean wf_dados_movimentacao (long al_filial, long al_produto, ref date adt_ultima_entrada, ref string as_tipo, ref string as_motivo_entrada)
public function boolean wf_dados_movimentacao_nova (long al_filial, long al_produto, ref date adt_ultima_entrada, ref string as_tipo, ref string as_motivo_entrada, ref long al_qt_movimento)
end prototypes

public function boolean wf_carrega_informacoes ();Date ldt_Ultima_Entrada

Long ll_Linha
Long ll_Filial
Long ll_Produto
Long ll_Qt_Est_Min
Long ll_Qt_Mov

String ls_Possui_Promo_Plan
String ls_Tipo
String ls_Motivo

Try

	dw_2.AcceptText()
	
	w_Aguarde.Title = "Atualizando movimenta$$HEX2$$e700f500$$ENDHEX$$es... Aguarde."
	w_Aguarde.uo_Progress.of_Setmax(dw_2.RowCount())

	For ll_Linha = 1 To dw_2.RowCount()
		ll_Filial		= dw_2.Object.Cd_Filial		[ll_Linha]
		ll_Produto	= dw_2.Object.Cd_Produto	[ll_Linha]
		
//		If Not wf_Dados_Promocao(ll_Filial, ll_Produto, Ref ls_Possui_Promo_Plan, Ref ll_Qt_Est_Min) Then Return False
		
		If Not wf_Dados_Movimentacao_Nova(ll_Filial, ll_Produto, Ref ldt_Ultima_Entrada, Ref ls_Tipo, Ref ls_Motivo, Ref ll_Qt_Mov) Then Return False
		
//		dw_2.Object.Id_Possui_Promocao_Plan	[ll_Linha] = ls_Possui_Promo_Plan
//		dw_2.Object.Qt_Estoque_Minimo			[ll_Linha] = ll_Qt_Est_Min

		dw_2.Object.Dh_Ultima_Entrada			[ll_Linha] = ldt_Ultima_Entrada
		dw_2.Object.Qt_Movimento					[ll_Linha] = ll_Qt_Mov
		dw_2.Object.Tipo_Entrada					[ll_Linha] = ls_Tipo
		dw_2.Object.De_Motivo_Entrada			[ll_Linha] = ls_Motivo
		
		w_Aguarde.Title = "Registro " + String(ll_Linha) + " de " + String(dw_2.RowCount())
		w_Aguarde.uo_Progress.of_Setprogress(ll_Linha)
	Next
	
	Return True
	
Finally
	Close(w_Aguarde)
End Try
end function

public function boolean wf_dados_promocao (long al_filial, long al_produto, ref string as_id_possui_promo_plan, ref long al_qt_estoque_min);Long ll_Achou

Select Count(*)
	Into:ll_Achou
From vw_promocao_estoque_minimo
Where cd_filial = :al_Filial
	And cd_produto = :al_Produto
	And id_tipo_promocao = 'P'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o produto '" + String(al_Produto) + "' est$$HEX1$$e100$$ENDHEX$$ em alguma promo$$HEX2$$e700e300$$ENDHEX$$o de planograma.", StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	as_Id_Possui_Promo_Plan = "S"
Else
	as_Id_Possui_Promo_Plan = "N"
End If

Return True
end function

public function boolean wf_dados_movimentacao (long al_filial, long al_produto, ref date adt_ultima_entrada, ref string as_tipo, ref string as_motivo_entrada);Long ll_Ped_Dist
Long ll_Nr_Nf
Long ll_Filial
Long ll_Pedido_Dist
Long ll_Pedido_Fil
Long ll_Promocao
Long ll_Ped_Emp

String ls_Especie
String ls_Serie
String ls_Fornecedor
String ls_Tipo
String ls_Promocao

SetNull(as_Tipo)

select top 1 m.cd_filial, m.cd_fornecedor, m.nr_nf, m.de_especie, m.de_serie, m.dh_movimento, m.cd_tipo_movimento, t.de_tipo_movimento
	Into :ll_Filial, :ls_Fornecedor, :ll_Nr_Nf, :ls_Especie, :ls_Serie, :adt_Ultima_Entrada, :ls_Tipo, :as_Tipo
From movimento_estoque m
	Inner Join tipo_movimento_estoque t
		On t.cd_tipo_movimento = m.cd_tipo_movimento
where m.cd_filial_movimento = :al_Filial
  and m.cd_tipo_movimento in (3, 5)
  and m.cd_produto = :al_Produto
  and m.dh_movimento in (	select max(x.dh_movimento) 
								from movimento_estoque x
								where x.cd_filial_movimento = :al_Filial
								  and x.dh_movimento >= '20110101'
								  and x.cd_tipo_movimento in (3, 5)
								  and x.cd_produto = :al_Produto)
Order By m.dh_movimento Desc
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		SetNull(adt_ultima_entrada)
		SetNull(as_Motivo_Entrada)
		
		Return True
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque do produto '" + String(al_Produto) + "'.", StopSign!)
		Return False
End Choose

If ll_Nr_Nf > 0 Then
	
	If ls_Tipo = "3" Then
		Select nr_pedido_distribuidora
			Into: ll_Pedido_Dist
		From nf_compra
		Where cd_filial = :al_Filial
			And cd_fornecedor = :ls_Fornecedor
			And nr_nf = :ll_Nr_Nf
			And de_especie = :ls_Especie
			And de_serie = :ls_Serie
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				//
				
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a NF na nf_compra. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_dados_movimentacao. " + SqlCa.SqlErrText, Exclamation!)
				Return False
				
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta da nf_compra. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_dados_movimentacao. " + SqlCa.SqlErrText, StopSign!)
				Return False				
		End Choose
		
	Else
		
		Select nr_pedido_distribuidora
			Into: ll_Pedido_Dist
		From nf_transferencia
		Where cd_filial_origem = :ll_Filial
			And nr_nf = :ll_Nr_Nf
			And de_especie = :ls_Especie
			And de_serie = :ls_Serie
			And cd_filial_destino = :al_Filial
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				//
				
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a NF na nf_transferencia. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_dados_movimentacao. " + SqlCa.SqlErrText, Exclamation!)
				Return False
				
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta da nf_transferencia. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_dados_movimentacao. " + SqlCa.SqlErrText, StopSign!)
				Return False
		End Choose
	End If
End If

If ll_Pedido_Dist > 0 Then

	Select nr_pedido_filial
		Into: ll_Pedido_Fil
	From pedido_distribuidora
	Where cd_filial = :al_Filial
		And nr_pedido_distribuidora = :ll_Pedido_Dist
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			//
			
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada o pedido filial na pedido_distribuidora. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_preenche_campos. " + SqlCa.SqlErrText, Exclamation!)
			Return False
			
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a pedido_distribuidora. " + SqlCa.SqlErrText, StopSign!)
			Return False
	End Choose
End If

If ll_Pedido_Fil > 0 Then
			
	Select Top 1 b.nr_pedido_empurrado, p.cd_promocao_sos, s.nm_promocao_sos
		Into :ll_Ped_Emp, :ll_Promocao, :ls_Promocao
	from pedido_distribuidora a
	inner join pedido_distribuidora_produto b
		on b.cd_filial = a.cd_filial
		and b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
	inner join pedido_filial_produto p
		on p.cd_filial = a.cd_filial	
		and p.nr_pedido_filial = a.nr_pedido_filial
		and p.cd_produto = b.cd_produto
	left outer join promocao_sos s
		on s.cd_promocao_sos = p.cd_promocao_sos
	where a.cd_filial 						= :al_Filial
	  and a.nr_pedido_filial 				= :ll_Pedido_Fil
	  and b.cd_produto    					= :al_produto
	 Using SqlCa;
	 
	 Choose Case SqlCa.SqlCode
		Case 0
			//
			
		Case 100
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pedido_filial. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_preenche_campos.", Exclamation!)
//			Return False
			
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o e o n$$HEX1$$fa00$$ENDHEX$$mero do pedido empurrado. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_preenche_campos. " + SqlCa.SqlErrText, StopSign!)
			Return False
	 End Choose
End If

If ll_Ped_Emp > 0 Or ll_Promocao > 0 Then
	If ll_Ped_Emp > 0 Then
		as_Motivo_Entrada = "PEDIDO EMPURRADO"
	End If
	
	If ll_Promocao > 0 Then
		as_Motivo_Entrada = "PROMO$$HEX2$$c700c300$$ENDHEX$$O - " + ls_Promocao + " (" + String(ll_Promocao) + ")"
	End If

Else
	as_Motivo_Entrada = "ESTOQUE BASE"
End If
end function

public function boolean wf_dados_movimentacao_nova (long al_filial, long al_produto, ref date adt_ultima_entrada, ref string as_tipo, ref string as_motivo_entrada, ref long al_qt_movimento);Long ll_Ped_Dist
Long ll_Nr_Nf
Long ll_Filial
Long ll_Pedido_Dist
Long ll_Pedido_Fil
Long ll_Promocao
Long ll_Ped_Emp
Long ll_Find
Long ll_Tipo

String ls_Especie
String ls_Serie
String ls_Fornecedor
String ls_Promocao

SetNull(as_Tipo)
SetNull(adt_ultima_entrada)
SetNull(as_Motivo_Entrada)

ll_Find = dw_3.Find("cd_filial_movimento = " + String(al_Filial) + " and cd_produto = " + String(al_Produto), 1, dw_3.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_3 para a filial " + String(al_Filial) + " e produto " + String(al_Produto))
	Return False
End If

If ll_Find > 0 Then
	ll_Filial 					= dw_3.Object.Cd_Filial					[ll_Find]
	ls_Fornecedor 			= dw_3.Object.Cd_Fornecedor			[ll_Find]
	ll_Nr_Nf 					= dw_3.Object.Nr_Nf						[ll_Find]
	ls_Especie 				= dw_3.Object.De_Especie				[ll_Find]
	ls_Serie 					= dw_3.Object.De_Serie					[ll_Find]
	adt_Ultima_Entrada	= Date(dw_3.Object.Dh_Movimento	[ll_Find])
	ll_Tipo 					= dw_3.Object.Cd_Tipo_Movimento	[ll_Find]
	as_Tipo 					= dw_3.Object.De_Tipo_Movimento	[ll_Find]
	al_Qt_Movimento		= dw_3.Object.Qt_Movimento			[ll_Find]
End If

If ll_Find = 0 Then Return True

If ll_Tipo = 3 Then
	
	Select Top 1 b.nr_pedido_empurrado, p.cd_promocao_sos, s.nm_promocao_sos
		Into :ll_Ped_Emp, :ll_Promocao, :ls_Promocao
	from pedido_distribuidora a
	inner join pedido_distribuidora_produto b
		on b.cd_filial = a.cd_filial
		and b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
	inner join pedido_filial_produto p
		on p.cd_filial = a.cd_filial	
		and p.nr_pedido_filial = a.nr_pedido_filial
		and p.cd_produto = b.cd_produto
	left outer join promocao_sos s
		on s.cd_promocao_sos = p.cd_promocao_sos
	where a.cd_filial 						= :al_Filial
	  and b.cd_produto    					= :al_Produto
	  and a.nr_pedido_filial 				in (Select z.nr_pedido_filial
														From nf_compra x
															inner join pedido_distribuidora y
																on y.cd_filial = x.cd_filial
																and y.nr_pedido_distribuidora = x.nr_pedido_distribuidora
															inner join pedido_distribuidora_produto pp
																on pp.cd_filial = a.cd_filial
																and pp.nr_pedido_distribuidora = b.nr_pedido_distribuidora
																and pp.cd_produto = b.cd_produto
															inner join pedido_filial z
																on z.cd_filial = x.cd_filial
																and z.nr_pedido_filial = y.nr_pedido_filial
														Where x.cd_filial = :al_Filial
															And x.cd_fornecedor = :ls_Fornecedor
															And x.nr_nf = :ll_Nr_Nf
															And x.de_especie = :ls_Especie
															And x.de_serie = :ls_Serie)
													Using SqlCa;
													
Else
													
	Select Top 1 b.nr_pedido_empurrado, p.cd_promocao_sos, s.nm_promocao_sos
		Into :ll_Ped_Emp, :ll_Promocao, :ls_Promocao
	from pedido_distribuidora a
	inner join pedido_distribuidora_produto b
		on b.cd_filial = a.cd_filial
		and b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
	inner join pedido_filial_produto p
		on p.cd_filial = a.cd_filial	
		and p.nr_pedido_filial = a.nr_pedido_filial
		and p.cd_produto = b.cd_produto
	left outer join promocao_sos s
		on s.cd_promocao_sos = p.cd_promocao_sos
	where a.cd_filial 						= :al_Filial
	  and b.cd_produto    					= :al_Produto
	  and a.nr_pedido_filial 				in (Select z.nr_pedido_filial
														From nf_transferencia x
															inner join pedido_distribuidora y
																on y.cd_filial = x.cd_filial_destino
																and y.nr_pedido_distribuidora = x.nr_pedido_distribuidora
															inner join pedido_distribuidora_produto pp
																on pp.cd_filial = a.cd_filial
																and pp.nr_pedido_distribuidora = b.nr_pedido_distribuidora
																and pp.cd_produto = b.cd_produto
															inner join pedido_filial z
																on z.cd_filial = x.cd_filial_destino
																and z.nr_pedido_filial = y.nr_pedido_filial
														Where x.cd_filial_origem = :ll_Filial
															And x.nr_nf = :ll_Nr_Nf
															And x.de_especie = :ls_Especie
															And x.de_serie = :ls_Serie
                                                            		And x.cd_filial_destino = :al_Filial)
													Using SqlCa;
													
End If

If SqlCa.SqlCode = - 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o e o n$$HEX1$$fa00$$ENDHEX$$mero do pedido empurrado para o produto " + String(al_Produto) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o wf_preenche_campos. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Ped_Emp > 0 Or ll_Promocao > 0 Then
	If ll_Ped_Emp > 0 Then
		as_Motivo_Entrada = "PEDIDO EMPURRADO"
	End If
	
	If ll_Promocao > 0 Then
		as_Motivo_Entrada = "PROMO$$HEX2$$c700c300$$ENDHEX$$O - " + ls_Promocao + " (" + String(ll_Promocao) + ")"
	End If

Else
	as_Motivo_Entrada = "ESTOQUE BASE"
End If
end function

on w_ge361_motivo_ultima_entrada_hist.create
call super::create
end on

on w_ge361_motivo_ultima_entrada_hist.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(io_Planogramas)
Destroy(io_Produto)
Destroy(ivo_Selecao_filiais)
end event

event ue_preopen;call super::ue_preopen;io_Planogramas = Create uo_gc008_planogramas
io_Produto = Create uo_Produto
ivo_Selecao_filiais = Create uo_ge216_filiais

MaxWidth = 11000
Maxheight = 9999
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Fim_Mov	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Movimento	[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Fim_Mov[1]), -3))
end event

event open;call super::open;ivb_permite_fechar = false
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge361_motivo_ultima_entrada_hist
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge361_motivo_ultima_entrada_hist
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge361_motivo_ultima_entrada_hist
integer y = 288
integer width = 4325
integer height = 1712
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge361_motivo_ultima_entrada_hist
integer width = 3387
integer height = 268
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge361_motivo_ultima_entrada_hist
integer width = 3323
integer height = 168
string dataobject = "dw_ge361_selecao_hist"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If dw_1.GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If Not io_Produto.Localizado Then
			io_Produto.of_Inicializa()
		End If
		
		If io_Produto.Localizado Then
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Long ll_Null[]

String ls_Nulo

dw_2.Event ue_Reset()

SetNull(ls_Nulo)

Choose Case dwo.Name
	Case "id_conjunto_filial"
		
		ivs_filiais = ls_Nulo
		il_Lojas = 0
		
		If Data = 'C' Then
							
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_filiais)
			
			il_Lojas = Message.DoubleParm
			
			If il_Lojas > 0 Then				
				ivs_filiais = ivo_Selecao_filiais.ivs_filiais				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")					
			End If
		End If
	
	Case "id_planogramas"
		
		If Data = 'C' Then
			io_planogramas.il_Analise = 0
			
			OpenWithParm( w_gc008_selecao_planograma, io_planogramas )
			io_planogramas = Message.PowerObjectParm
							
			If IsNull( io_planogramas.is_Planogramas ) Or io_planogramas.is_Planogramas = "" Then 
				This.Object.id_planogramas[ 1 ] = "T"
				Return 1
			End If
				
		Else
			io_planogramas.il_planogramas[] 	= ll_Null[]
			io_planogramas.is_Planogramas	= ""			
		End If		
End Choose
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge361_motivo_ultima_entrada_hist
integer y = 364
integer width = 4247
integer height = 1600
string dataobject = "dw_ge361_lista_hist"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Movimento
DateTime ldh_Limite

Long ll_Produto

String ls_Planograma
String ls_Conjunto

dw_1.AcceptText()

ls_Planograma	= dw_1.Object.Id_Planogramas	[1]
ldh_Movimento	= dw_1.Object.Dh_Movimento		[1]
ls_Conjunto		= dw_1.Object.Id_Conjunto_Filial	[1]
ll_Produto		= dw_1.Object.Cd_Produto			[1]

If (IsNull(ldh_Movimento)) Or (ldh_Movimento > gvo_Parametro.of_Dh_Movimentacao()) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data v$$HEX1$$e100$$ENDHEX$$lida.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_movimento")
	Return -1
End If

//ldh_Limite = DateTime(RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -365))

//If ldh_Movimento < ldh_Limite Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo limite para consulta $$HEX1$$e900$$ENDHEX$$ de 365 dias.", Exclamation!)
//	dw_1.Event ue_Pos(1, "dh_movimento")
//	Return -1
//End If

If ls_Conjunto = "N" Or (ls_Conjunto = "C" And il_Lojas = 0) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe ao menos uma filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "id_conjunto_filial")
	Return -1
End If

If ls_Conjunto = "C" And il_Lojas > 0 Then
	This.of_AppendWhere_SubQuery("s.cd_filial in (" + ivs_Filiais + ")", 1)
End If

If ls_Planograma = "C" Then	
	This.of_AppendWhere_SubQuery("g.cd_planograma in (" + io_planogramas.is_Planogramas + ")", 1)
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere_SubQuery("s.cd_produto = " + String(ll_Produto), 1)
End If

This.SetSort("")
This.Sort()
	
This.SetSort("cd_filial, cd_produto")
This.Sort()

Return 1
end event

event dw_2::ue_recuperar;//OverRide

Date ldt_Atual
Date ldt_Primeiro_Dia_Mes
Date ldt_Primeiro_Dia_Mes_Ant
Date ldt_Termino

Long ll_Mes
Long ll_Ano

dw_1.AcceptText()

Open(w_Aguarde)
	
w_Aguarde.Title = "Carregando Lista Principal... Aguarde."

ldt_Atual = gf_Primeiro_Dia_Mes(Today())
ldt_Primeiro_Dia_Mes = gf_Primeiro_Dia_Mes(Date(dw_1.Object.Dh_Fim_Mov[1]))

ll_Mes = Month(Date(dw_1.Object.Dh_Fim_Mov[1]))
ll_Ano = Year(Date(dw_1.Object.Dh_Fim_Mov[1]))

If ll_Mes = 1 Then
	ll_Mes = 12
	ll_Ano --
Else
	ll_Mes --
End If

ldt_Primeiro_Dia_Mes_Ant = Date("01/" + String(ll_Mes) + "/" + String(ll_Ano))

ldt_Termino = RelativeDate(Date(dw_1.Object.Dh_Fim_Mov[1]), 1)

Return This.Retrieve(ldt_Atual, dw_1.Object.Dh_Movimento[1], dw_1.Object.Dh_Fim_Mov[1], ldt_Primeiro_Dia_Mes, ldt_Primeiro_Dia_Mes_Ant, DateTime(ldt_Termino))
end event

event dw_2::constructor;call super::constructor;//This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_3.Event ue_Retrieve()
	
	If Not wf_Carrega_Informacoes() Then Return -1
	
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
	
	This.SetSort("")
	This.Sort()
	
	This.SetSort("nm_fantasia, de_produto")
	This.Sort()
	This.GroupCalc()
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
	
	Close(w_Aguarde)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge361_motivo_ultima_entrada_hist
integer x = 2670
integer y = 1072
string dataobject = "dw_ge361_lista_movimento_hist"
end type

event dw_3::ue_recuperar;//OverRide

Date ldt_Termino

dw_1.AcceptText()

w_Aguarde.Title = "Carregando Movimenta$$HEX2$$e700f500$$ENDHEX$$es... Aguarde."

ldt_Termino = RelativeDate(Date(dw_1.Object.Dh_Fim_Mov[1]), 1)

Return This.Retrieve(dw_1.Object.Dh_Movimento[1], DateTime(ldt_Termino))
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

If dw_1.Object.Id_Conjunto_Filial[1] = "C" And il_Lojas > 0 Then
	dw_3.of_AppendWhere("m.cd_filial_movimento in (" + ivs_Filiais + ")")
End If

If dw_1.Object.Id_Planogramas[1] = "C" Then
	dw_3.of_AppendWhere("g.cd_planograma in (" + io_planogramas.is_Planogramas + ")")
Else
	dw_3.of_AppendWhere("g.cd_planograma Is Not Null")
End If

If Not IsNull(dw_1.Object.Cd_Produto[1]) And dw_1.Object.Cd_Produto[1] > 0 Then
	dw_3.of_AppendWhere("m.cd_produto = " + String(dw_1.Object.Cd_Produto[1]))
End If

Return 1
end event

