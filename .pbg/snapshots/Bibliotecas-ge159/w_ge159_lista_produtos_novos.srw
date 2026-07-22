HA$PBExportHeader$w_ge159_lista_produtos_novos.srw
forward
global type w_ge159_lista_produtos_novos from dc_w_selecao_lista_relatorio
end type
type cb_gerar from commandbutton within w_ge159_lista_produtos_novos
end type
type cb_cancelar from commandbutton within w_ge159_lista_produtos_novos
end type
end forward

global type w_ge159_lista_produtos_novos from dc_w_selecao_lista_relatorio
string tag = "w_ge159_lista_produtos_novos"
integer width = 1449
integer height = 652
string title = "GE159 - Lista dos Produtos Novos"
long backcolor = 80269524
cb_gerar cb_gerar
cb_cancelar cb_cancelar
end type
global w_ge159_lista_produtos_novos w_ge159_lista_produtos_novos

type variables
DateTime idh_Data_Atual
end variables

forward prototypes
public function boolean wf_carrega_venda (long al_tipo, long al_produto, ref long al_qt_venda)
public function boolean wf_carrega_saldo (string as_tipo_filial, long al_produto, ref long al_qt_saldo)
public function boolean wf_carrega_dados ()
public function boolean wf_dados_pedido (long al_produto, ref long al_pedido, ref datetime adh_pedido, ref long al_qt_pedida)
public function boolean wf_primeira_entrada_cd (long al_produto, date adt_primeira_compra, ref long al_qt_primeira_compra)
end prototypes

public function boolean wf_carrega_venda (long al_tipo, long al_produto, ref long al_qt_venda);Date ldt_Nova_Data

DateTime ldh_Inicio
DateTime ldh_Fim

Long ll_Mes
Long ll_Ano

//Vendas dos $$HEX1$$fa00$$ENDHEX$$ltimos 6 meses
If al_Tipo = 1 Then

	ll_Mes = Month(Date(idh_Data_Atual))
	ll_Ano = Year(Date(idh_Data_Atual))
	
	If ll_Mes = 1 Then
		ll_Mes = 12
		ll_Ano = ll_Ano - 1
	Else
		ll_Mes = ll_Mes - 1
	End If
	
	ldt_Nova_Data = Date("01/" + String(ll_Mes) + "/" + String(ll_Ano))
	
	ldh_Fim = DateTime(gf_Retorna_Ultimo_Dia_Mes(ldt_Nova_Data))
	
	ldt_Nova_Data = RelativeDate(ldt_Nova_Data, - 180)
	
	ldh_Inicio = DateTime(gf_Primeiro_Dia_Mes(ldt_Nova_Data))
	
	Select coalesce(sum(qt_venda - qt_devolucao_venda), 0)
		Into :al_Qt_Venda
	From resumo_produto
	Where cd_produto = :al_Produto
	  And dh_resumo Between :ldh_Inicio And :ldh_Fim
	 Using SqlCa;
	 
Else
	
	//Vendas do m$$HEX1$$ea00$$ENDHEX$$s corrente
	ldh_Inicio = DateTime(gf_Primeiro_Dia_Mes(Date(idh_Data_Atual)))
	ldh_Fim = DateTime(gf_Retorna_Ultimo_Dia_Mes(Date(idh_Data_Atual)))
	
	Select coalesce(sum(qt_venda - qt_devolucao_venda), 0)
		Into :al_Qt_Venda
	From resumo_produto
	Where cd_produto = :al_Produto
	  And dh_resumo Between :ldh_Inicio And :ldh_Fim
	 Using SqlCa;
	 
End If

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as vendas. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If
end function

public function boolean wf_carrega_saldo (string as_tipo_filial, long al_produto, ref long al_qt_saldo);idh_Data_Atual = gf_GetServerDate()

If as_Tipo_Filial = "EST" Then
	
	Select coalesce(sum(qt_saldo_final), 0)
		Into :al_Qt_Saldo
	From vw_saldo_atual_produto
	Where cd_filial = 534
		And cd_produto = :al_Produto
	Using SqlCa;
	
Else
	
	Select coalesce(sum(qt_saldo_final), 0)
		Into :al_Qt_Saldo
	From vw_saldo_atual_produto
	Where cd_filial <> 534
		And cd_filial <> 1
		And cd_produto = :al_Produto
	Using SqlCa;
	
End If

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta do saldo das filiais/estoque central. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_carrega_dados ();DateTime ldh_Pedido
DateTime ldh_Revisao
DateTime ldh_EB_Inicial
Date ldt_Primeira_Ent_Cd
Date ldt_Primeira_Ent_Dist
Date ldt_Data_Parametro
Date ldt_Data_Servidor

Long ll_Linha
Long ll_Pedido
Long ll_Qt_Pedida
Long ll_Qt_Primeira_Compra
Long ll_Dif_Dias
Long ll_Dif_Fac
Long ll_Qt_Eb_Inicial

ldt_Data_Servidor = Date(gf_GetServerdate())

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	
	SetNull(ll_Dif_Dias)
	SetNull(ll_Dif_Fac)
	SetNull(ll_Qt_Primeira_Compra)
	
	If Not wf_Dados_Pedido( dw_2.Object.Cd_Produto[ll_Linha], Ref ll_Pedido, Ref ldh_Pedido, Ref ll_Qt_Pedida ) Then Return False
	
	dw_2.Object.Nr_Pedido_Ec	[ll_Linha] = ll_Pedido
	dw_2.Object.Dh_Pedido_Ec	[ll_Linha] = Date(ldh_Pedido)
	dw_2.Object.Qt_Pedida_Ec	[ll_Linha] = ll_Qt_Pedida
	
	ldt_Primeira_Ent_Cd	= dw_2.Object.Dh_Primeira_Compra_Cd					[ll_Linha]
	ldt_Primeira_Ent_Dist	= dw_2.Object.Dh_Primeira_Compra_Distrib			[ll_Linha]
	ldh_Revisao				= DateTime(dw_2.Object.Dh_Revisao_Fiscal			[ll_Linha])
	ldh_EB_Inicial			= DateTime(dw_2.Object.Dh_Estoque_Base_Inicial	[ll_Linha])
	
	If Not IsNull(ldt_Primeira_Ent_Cd) Then
		If Not wf_Primeira_Entrada_Cd(dw_2.Object.Cd_Produto[ll_Linha], ldt_Primeira_Ent_Cd, Ref ll_Qt_Primeira_Compra) Then Return False		
	End If
	
	dw_2.Object.Qt_Primeira_Entrada_Cd[ll_Linha] = ll_Qt_Primeira_Compra
	
	If IsNull(ldt_Primeira_Ent_Cd) 	Then ldt_Primeira_Ent_Cd  = Date("01/01/1900'")
	If IsNull(ldt_Primeira_Ent_Dist) Then ldt_Primeira_Ent_Dist = Date("01/01/1900'")
	
	If ldt_Primeira_Ent_Cd <> Date("01/01/1900'") or ldt_Primeira_Ent_Dist <>  Date("01/01/1900'") Then
		If ldt_Primeira_Ent_Cd > ldt_Primeira_Ent_Dist Then
			ldt_Data_Parametro = ldt_Primeira_Ent_Cd
		Else
			ldt_Data_Parametro = ldt_Primeira_Ent_Dist
		End If
		
		ll_Dif_Fac	= DaysAfter(Date(ldh_EB_Inicial), Date(ldt_Data_Parametro ))
	Else
		ldt_Data_Parametro = ldt_Data_Servidor
	End If
	
	ll_Dif_Dias	= DaysAfter(Date(ldh_Revisao), Date(ldt_Data_Parametro ))
	
//	If Not IsNull(ldt_Primeira_Ent_Cd) Or Not IsNull(ldt_Primeira_Ent_Dist) Then
//	
//		//Verifica qual $$HEX1$$e900$$ENDHEX$$ a menor data para comparar com a revis$$HEX1$$e300$$ENDHEX$$o fiscal e com o primeiro eb cadastrado
//		If IsNull(ldt_Primeira_Ent_Cd) And Not IsNull(ldt_Primeira_Ent_Dist) Then
//			ll_Dif_Dias	= DaysAfter(Date(ldh_Revisao), Date(ldt_Primeira_Ent_Dist ))
//			ll_Dif_Fac	= DaysAfter(Date(ldh_EB_Inicial), Date(ldt_Primeira_Ent_Dist ))
//			
//		ElseIf Not IsNull(ldt_Primeira_Ent_Cd) And IsNull(ldt_Primeira_Ent_Dist) Then
//			ll_Dif_Dias	= DaysAfter(Date(ldh_Revisao), Date(ldt_Primeira_Ent_Cd ))
//			ll_Dif_Fac	= DaysAfter(Date(ldh_EB_Inicial), Date(ldt_Primeira_Ent_Cd ))
//			
//		Else
//			
//			If ldt_Primeira_Ent_Cd >= ldt_Primeira_Ent_Dist Then
//				ll_Dif_Dias	= DaysAfter(Date(ldh_Revisao), Date(ldt_Primeira_Ent_Dist ))
//				ll_Dif_Fac	= DaysAfter(Date(ldh_EB_Inicial), Date(ldt_Primeira_Ent_Dist ))
//			Else
//				ll_Dif_Dias	= DaysAfter(Date(ldh_Revisao), Date(ldt_Primeira_Ent_Cd ))
//				ll_Dif_Fac	= DaysAfter(Date(ldh_EB_Inicial), Date(ldt_Primeira_Ent_Cd ))
//			End If
//		End If
//	End If
	
	dw_2.Object.Qt_Dias_Sem_Entrada				[ll_Linha] = ll_Dif_Dias
	dw_2.Object.Dif_Primeira_Ent_Primeiro_Fac	[ll_Linha] = ll_Dif_Fac
Next

Return True
end function

public function boolean wf_dados_pedido (long al_produto, ref long al_pedido, ref datetime adh_pedido, ref long al_qt_pedida);SetNull(al_Pedido)
SetNull(adh_Pedido)
SetNull(al_Qt_Pedida)

Select Min(nr_pedido)
	Into :al_Pedido
From pedido_central_produto
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o pedido para o produto " + String(al_Produto) + ".", StopSign!)
	Return False
End If

If al_Pedido > 0 Then
	
	Select	p.dh_pedido,
			pp.qt_pedida
		Into	:adh_Pedido,
				:al_Qt_Pedida
	From pedido_central p
		Inner Join pedido_central_produto pp
			On pp.nr_pedido = p.nr_pedido
	Where p.nr_pedido = :al_Pedido
		And pp.cd_produto = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a quantidade pedida do produto " + String(al_Produto) + "." + SqlCa.SqlErrText, StopSign!)
		Return False
	End If
End If

Return True
end function

public function boolean wf_primeira_entrada_cd (long al_produto, date adt_primeira_compra, ref long al_qt_primeira_compra);Select sum(i.qt_faturada)
Into :al_qt_primeira_compra
From nf_compra n
Inner join item_nf_compra i
	on i.cd_filial 			= n.cd_filial
 	and i.cd_fornecedor 	= n.cd_fornecedor
	and i.nr_nf				= n.nr_nf
	and i.de_especie 		= n.de_especie
	and i.de_serie			= n.de_serie
Where n.cd_filial 						= 534
    and n.dh_movimentacao_caixa 	= :adt_primeira_compra
    and i.cd_produto					= :al_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a primeira compra do CD do produto " + String(al_Produto) + ".", StopSign!)
	Return False
End If

Return True
end function

on w_ge159_lista_produtos_novos.create
int iCurrent
call super::create
this.cb_gerar=create cb_gerar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
this.Control[iCurrent+2]=this.cb_cancelar
end on

on w_ge159_lista_produtos_novos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_gerar)
destroy(this.cb_cancelar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_inicio 	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.dh_termino	[1] = gvo_Parametro.of_Dh_Movimentacao()

This.ivm_Menu.mf_Recuperar(False)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge159_lista_produtos_novos
integer x = 0
integer y = 436
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge159_lista_produtos_novos
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge159_lista_produtos_novos
boolean visible = false
integer x = 0
integer y = 356
integer height = 948
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge159_lista_produtos_novos
integer x = 23
integer y = 8
integer width = 1344
integer height = 324
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge159_lista_produtos_novos
integer x = 46
integer y = 64
integer width = 1312
integer height = 260
string dataobject = "dw_ge159_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge159_lista_produtos_novos
boolean visible = false
integer x = 32
integer y = 432
integer height = 840
string dataobject = "dw_ge159_lista_nova"
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_Inicio
Date lvdt_Termino
	 
String lvs_Situacao
String ls_Faceamento

dw_1.AcceptText()
	 
lvdt_Inicio		= dw_1.Object.dh_inicio  		[1]
lvdt_Termino	= dw_1.Object.dh_termino		[1]
lvs_Situacao		= dw_1.Object.id_situacao		[1]
ls_Faceamento	= dw_1.Object.Id_Faceamento	[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If lvs_Situacao <> "T" Then
	dw_2.of_AppendWhere_SubQuery("pg.id_situacao = '" + lvs_Situacao + "'", 3)
End If

Choose Case ls_Faceamento
	Case "T" //Todos
		
	Case "C" //Produtos COM faceamento
		dw_2.of_AppendWhere_SubQuery("pc.dh_estoque_base_inicial is not null", 3)
		
	Case "S" //Produtos SEM faceamento
		dw_2.of_AppendWhere_SubQuery("pc.dh_estoque_base_inicial is null", 3)
		
End Choose

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge159_lista_produtos_novos
integer x = 1449
integer y = 56
integer height = 164
integer taborder = 50
end type

type cb_gerar from commandbutton within w_ge159_lista_produtos_novos
integer x = 535
integer y = 356
integer width = 462
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Gerar Planilha"
end type

event clicked;Integer lvi_Retorno

String lvs_Path,&
	   lvs_Arquivo

dw_2.Event ue_Retrieve()

If dw_2.RowCount() > 0 Then
	If Not wf_Carrega_Dados() Then Return -1
	
	lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
	
	If lvi_retorno = 1 Then
		
		If dw_2.SaveAs(lvs_Path, Excel!, True) = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
		End If
	End If
End If
end event

type cb_cancelar from commandbutton within w_ge159_lista_produtos_novos
integer x = 1019
integer y = 356
integer width = 352
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;Close(Parent)
end event

