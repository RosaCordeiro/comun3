HA$PBExportHeader$w_ge101_consulta_trans_almoxarifado.srw
forward
global type w_ge101_consulta_trans_almoxarifado from w_ge101_consulta_venda_produto
end type
end forward

global type w_ge101_consulta_trans_almoxarifado from w_ge101_consulta_venda_produto
integer width = 2939
string title = "GE101 - Consulta Transfer$$HEX1$$ea00$$ENDHEX$$ncias do Almoxarifado"
end type
global w_ge101_consulta_trans_almoxarifado w_ge101_consulta_trans_almoxarifado

type variables
Date ivdh_Inicio
Date ivdh_Termino
end variables

on w_ge101_consulta_trans_almoxarifado.create
call super::create
end on

on w_ge101_consulta_trans_almoxarifado.destroy
call super::destroy
end on

event ue_postopen;//OverRide

Boolean lvb_Sucesso = False

DateTime lvdh_Inicio, &
         lvdh_Termino
			
uo_filiais = Create uo_ge216_filiais 			
			
Select dateadd(month, -12, dh_movimentacao),
		 dh_movimentacao
Into :lvdh_Inicio, 
     :lvdh_Termino
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Datas do par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizadas.", StopSign!)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Datas do Par$$HEX1$$e200$$ENDHEX$$metro")
End Choose

If lvb_Sucesso Then
	dw_1.Event ue_AddRow()
	
	dw_1.Object.Cd_Produto[1] = ivl_Produto
	dw_1.Object.De_Produto[1] = ivs_Descricao
	dw_1.Object.Dt_Inicio [1] = Date("01/" + String(lvdh_Inicio,  "mm/yyyy"))
	dw_1.Object.Dt_Termino[1] = gf_retorna_ultimo_dia_mes( Date(lvdh_Termino) )
			
	dw_2.Post Event ue_Retrieve()
Else
	Close(This)
End If
end event

type pb_help from w_ge101_consulta_venda_produto`pb_help within w_ge101_consulta_trans_almoxarifado
end type

type gb_3 from w_ge101_consulta_venda_produto`gb_3 within w_ge101_consulta_trans_almoxarifado
integer x = 846
integer width = 2053
string text = "Transfer$$HEX1$$ea00$$ENDHEX$$ncias por Filial no M$$HEX1$$ea00$$ENDHEX$$s"
end type

type gb_2 from w_ge101_consulta_venda_produto`gb_2 within w_ge101_consulta_trans_almoxarifado
integer width = 814
string text = "Transfer$$HEX1$$ea00$$ENDHEX$$ncias por M$$HEX1$$ea00$$ENDHEX$$s"
end type

type gb_1 from w_ge101_consulta_venda_produto`gb_1 within w_ge101_consulta_trans_almoxarifado
end type

type dw_1 from w_ge101_consulta_venda_produto`dw_1 within w_ge101_consulta_trans_almoxarifado
end type

type cb_fechar from w_ge101_consulta_venda_produto`cb_fechar within w_ge101_consulta_trans_almoxarifado
end type

type dw_2 from w_ge101_consulta_venda_produto`dw_2 within w_ge101_consulta_trans_almoxarifado
integer width = 763
integer height = 1244
string dataobject = "dw_ge101_lista_transf_almoxarifado"
end type

event dw_2::rowfocuschanged;//OverRide

Date lvdh_Inicio
Date lvdh_Termino

String lvs_Selecao,&
	   lvs_Rede,&
	   lvs_FIliais

If CurrentRow > 0 Then
	dw_1.AcceptText()
	
	lvs_Selecao 	= dw_1.Object.Id_Vendas_Filiais	[1]
	lvs_FIliais		= dw_1.Object.id_filiais 				[1]	
	
	If lvs_Selecao = "S" Then
		lvdh_Inicio 		= Date(This.Object.Dh_Resumo	[CurrentRow])
		lvdh_Termino = gf_retorna_ultimo_dia_mes(lvdh_Inicio)
		
		ivdh_Inicio 		= lvdh_Inicio
		ivdh_Termino	= lvdh_Termino
			
		gb_3.Text = "Transf. por Filial no M$$HEX1$$ea00$$ENDHEX$$s " + String(lvdh_Inicio, "mm/yyyy")
		
		dw_3.of_RestoreOriginalSQL()
					
		dw_3.Event ue_Retrieve()
	End If
End If
end event

event dw_2::ue_recuperar;// Override

Date lvdt_Inicio
Date lvdt_Termino
	  
dw_1.AcceptText()

lvdt_Inicio  	= dw_1.Object.Dt_Inicio		[ 1 ]
lvdt_Termino	= dw_1.Object.Dt_Termino	[ 1 ]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

lvdt_Termino = gf_retorna_ultimo_dia_mes(lvdt_Termino)

Return This.Retrieve(ivl_Produto, lvdt_Inicio, lvdt_Termino)
end event

type dw_3 from w_ge101_consulta_venda_produto`dw_3 within w_ge101_consulta_trans_almoxarifado
integer x = 882
integer width = 1989
integer height = 1248
string dataobject = "dw_ge101_lista_transf_almoxarifado_filial"
end type

event dw_3::ue_recuperar;//OverRide

Date lvdt_Inicio
Date lvdt_Termino

Long ll_Linha

String ls_Conjunto

dw_1.AcceptText()
dw_2.AcceptText()

If dw_2.GetRow() > 0 Then
	
	ll_Linha = dw_2.GetRow()
	
	lvdt_Inicio 		= Date(dw_2.Object.Dh_Resumo[ll_Linha])
	lvdt_Termino	= gf_retorna_ultimo_dia_mes(lvdt_Inicio)
	ls_Conjunto		= dw_1.Object.Id_Filiais		[1]
	
	If ls_Conjunto = "C" Then
		If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
			This.of_AppendWhere_SubQuery("f.cd_filial in (" + ivs_Filiais + ")", 1)
			This.of_AppendWhere_SubQuery("f.cd_filial in (" + ivs_Filiais + ")", 2)
			This.of_AppendWhere_SubQuery("p.cd_filial_origem in (" + ivs_Filiais + ")", 3)
		End If
	End If
	
	Return This.Retrieve(lvdt_Inicio, lvdt_Termino, ivl_Produto)
Else
	Return 0
End If
end event

type cb_consultar from w_ge101_consulta_venda_produto`cb_consultar within w_ge101_consulta_trans_almoxarifado
end type

event cb_consultar::clicked;//OverRide

dw_2.Event ue_Retrieve()
dw_3.Event ue_Retrieve()
end event

type cb_1 from w_ge101_consulta_venda_produto`cb_1 within w_ge101_consulta_trans_almoxarifado
end type

event cb_1::clicked;//OverRide

DateTime lvdh_Base

Long lvl_Linha

dc_uo_ds_base lvds_1

uo_Produto lvo_Produto

String lvs_Produto, &
		 lvs_Selecao

lvs_Selecao = dw_1.Object.Id_Vendas_Filiais[1]

If lvs_Selecao <> "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A op$$HEX2$$e700e300$$ENDHEX$$o 'mostrar vendas por filial' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ marcada.")
	Return
Else	
	lvl_Linha = dw_3.RowCount()
	
	If lvl_Linha < 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.")
		Return
	Else
		lvds_1 = Create dc_uo_ds_base
		lvo_Produto = Create uo_Produto
		lvo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)
		lvs_Produto = lvo_Produto.De_Produto + " : " + lvo_Produto.De_Apresentacao_Venda
		
		lvds_1.of_ChangeDataObject("dw_ge101_rel_transf_almoxarifado")
	
		lvds_1.Retrieve( ivdh_Inicio, ivdh_Termino, ivl_Produto )
		
		lvds_1.Object.st_Mes.Text = String(ivdh_Inicio, "mm/yyyy")
		lvds_1.Object.Cabecalho_Produto.Text = lvs_Produto + " (" + String(ivl_produto) + ")"
		lvds_1.of_Print(False)
			
		Destroy(lvds_1)
		Destroy(lvo_Produto)
	End If
End If
end event

type cb_2 from w_ge101_consulta_venda_produto`cb_2 within w_ge101_consulta_trans_almoxarifado
end type

