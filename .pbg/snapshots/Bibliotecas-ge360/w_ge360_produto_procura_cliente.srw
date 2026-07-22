HA$PBExportHeader$w_ge360_produto_procura_cliente.srw
forward
global type w_ge360_produto_procura_cliente from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge360_produto_procura_cliente from dc_w_selecao_lista_relatorio
integer x = 215
integer y = 220
integer width = 4613
integer height = 1900
string title = "GE360 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos Procurados pelos Clientes"
long backcolor = 80269524
end type
global w_ge360_produto_procura_cliente w_ge360_produto_procura_cliente

type variables
uo_produto ivo_Produto
uo_filial       ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_produto ()
end prototypes

public subroutine wf_localiza_filial ();//
STRING ls_filial	, &
		 lvs_nulo
//
Long   lvl_nulo
//
ls_filial = dw_1.GetText()
//
ivo_filial.Of_Localiza_Filial(ls_filial)
//
If ivo_filial.Localizada Then
	//
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	//
Else
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.cd_filial[1] = lvl_nulo
	dw_1.Object.de_filial[1] = lvs_nulo
	//
	ivo_filial.cd_filial	    = lvl_nulo
	ivo_filial.nm_fantasia   = lvs_nulo	
	//
End If
//
end subroutine

public subroutine wf_localiza_produto ();Long lvl_nulo
//
String lvs_Produto , &
		 lvs_nulo
//
lvs_Produto = dw_1.GetText()
//
ivo_Produto.of_Localiza_Produto(lvs_Produto)
//
If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
Else
	//
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.Cd_Produto[1] = lvl_nulo
	dw_1.Object.De_Produto[1] = lvs_nulo
	//
	ivo_Produto.Cd_Produto								= lvl_nulo
	ivo_Produto.ivs_Descricao_Apresentacao_Venda = lvs_nulo
	//
End If
end subroutine

on w_ge360_produto_procura_cliente.create
call super::create
end on

on w_ge360_produto_procura_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_produto)
Destroy(ivo_filial)

end event

event ue_postopen;call super::ue_postopen;If gvo_parametro.cd_filial <> gvo_parametro.cd_filial_matriz Then
	dw_1.Object.cd_filial	[1] = gvo_parametro.cd_filial
	dw_1.Object.de_filial	[1] = gvo_parametro.nm_fantasia_filial
	dw_1.Object.de_filial.protect = 1

	ivo_filial.cd_filial   		= dw_1.Object.cd_filial	[1]
	ivo_filial.nm_fantasia	= dw_1.Object.de_filial	[1]
End If

dw_1.Object.dt_periodo_de	[1] = Date('01/'+ String(Month(Today()),'00')+  '/' + String(Year (Today()),'0000'))
dw_1.Object.dt_periodo_ate[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True

end event

event ue_preopen;call super::ue_preopen;ivo_produto	= Create uo_produto
ivo_filial		= Create uo_filial

MaxHeight = 9999
end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

event ue_print;//override
dw_2.event ue_imprimir_relatorio("Produtos Procurados em Falta", "CL", False)
end event

event ue_printimmediate;//override
dw_2.event ue_imprimir_relatorio("Produtos Procurados em Falta", "CL", True)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge360_produto_procura_cliente
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge360_produto_procura_cliente
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge360_produto_procura_cliente
integer x = 14
integer y = 416
integer width = 4539
integer height = 1280
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge360_produto_procura_cliente
integer x = 14
integer y = 0
integer width = 1746
integer height = 404
integer weight = 700
long backcolor = 79741120
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge360_produto_procura_cliente
integer x = 41
integer y = 68
integer width = 1701
integer height = 328
string dataobject = "dw_ge360_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long	ll_nulo

SetNull(ll_nulo)

Choose case dwo.name 
	Case "de_produto"	
		
		IF Data = "" OR ISNULL(Data) THEN
			THIS.Object.cd_produto[1] 							= ll_nulo
			ivo_Produto.ivs_Descricao_Apresentacao_Venda = ''
			RETURN 0
		END IF		
		
		IF Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then RETURN 1
	Case "de_filial"	
		
		IF Data = "" OR ISNULL(Data) THEN
			THIS.Object.cd_filial[1] = ll_nulo
			ivo_filial.nm_fantasia 	 = ''
			RETURN 0
		END IF		
		
		IF Data <> ivo_filial.nm_fantasia THEN RETURN 1
		
End Choose
end event

event dw_1::losefocus;call super::losefocus;IF IsValid(ivo_produto) THEN
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
END IF

IF IsValid(ivo_filial) THEN
	dw_1.Object.De_filial[1] = ivo_filial.nm_fantasia
END IF
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
		
	Choose Case lvs_Coluna 
		Case "de_produto" ; WF_Localiza_Produto()
		Case "de_filial"  ;  WF_Localiza_Filial()
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge360_produto_procura_cliente
integer x = 46
integer width = 4480
integer height = 1208
string dataobject = "dw_ge360_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

This.SetRedraw(True)

Return pl_Linhas

end event

event dw_2::ue_recuperar;//OverRide
Date lvdt_Inicio,&
	 lvdt_Termino

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.dt_periodo_de	[1]
lvdt_Termino	= dw_1.Object.dt_periodo_ate	[1]

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date lvdt_Inicio,&
	 lvdt_Termino

Long lvl_Filial, &
	 lvl_Produto
	 
String lvs_Marcada
	 
dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.dt_periodo_de				[1]
lvdt_Termino	= dw_1.Object.dt_periodo_ate				[1]
lvl_Filial			= dw_1.Object.cd_filial						[1]
lvl_Produto		= dw_1.Object.cd_produto					[1]
lvs_Marcada		= dw_1.Object.id_somente_marcados	[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_periodo_de")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_periodo_ate")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor que a de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_periodo_de")
	Return -1
End If

This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) + 1 ] = "Per$$HEX1$$ed00$$ENDHEX$$odo: "+String(lvdt_Inicio,"DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdt_Termino,"DD/MM/YYYY")

If Not IsNull(lvl_Filial) Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) + 1 ] = "Filial: "+ivo_filial.nm_fantasia+" ("+String(ivo_filial.cd_filial)+")"
	This.Of_appendwhere("ppc.cd_filial = " + String(lvl_Filial) )
End If

If Not IsNull(lvl_Produto) Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) + 1 ] = "Produto: "+ivo_Produto.ivs_descricao_apresentacao_venda+" ("+String(lvl_Produto)+")"
	This.Of_appendwhere("ppc.cd_produto = " + String(lvl_Produto) )
End If

If lvs_Marcada = "S" Then
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) + 1 ] = "Considerar Somente Marcadas: SIM"
	This.Of_appendwhere("coalesce(ppc.id_tipo,'A')<>'A'")
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]


lvs_Coluna = {"cd_produto","produto","de_grupo_produto","cd_classe_reposicao", "id_situacao", "vl_preco_venda_atual", "qt_consulta", "vl_total_consulta", &
					  "qt_recebida", "vl_total_recebido", "qt_substituido", "vl_total_subtituido"}
	
lvs_Nome = {"Cod. Produto","Descri$$HEX2$$e700e300$$ENDHEX$$o Produto","Grupo Produto","Classe Reposi$$HEX2$$e700e300$$ENDHEX$$o","Situa$$HEX2$$e700e300$$ENDHEX$$o Produto", "Valor Venda Atual", "Qtde Venda Perdida", "Valor Venda Perdida", &
				 "Qtde Venda Recebido Outra Filial", "Valor Venda Recebido Outra Filial", "Qtde Venda Substitu$$HEX1$$ed00$$ENDHEX$$da", "Valor Venda Substitu$$HEX1$$ed00$$ENDHEX$$da"}

dw_2.of_SetSort(lvs_Coluna, lvs_Nome)
dw_2.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge360_produto_procura_cliente
integer x = 3214
integer y = 24
integer width = 521
integer height = 312
integer taborder = 50
boolean hscrollbar = true
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio	, &
     lvdt_Termino

String lvs_filial , &
		 lvs_produto

lvdt_Inicio		= dw_1.Object.dt_periodo_de [1]
lvdt_Termino	= dw_1.Object.dt_periodo_ate[1]

dw_3.Object.st_Periodo.Text = String(lvdt_Inicio , "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
									   String(lvdt_Termino, "dd/mm/yyyy")

If Not IsNull(dw_1.Object.cd_filial) Then
	dw_3.Object.st_filial.Text = dw_1.Object.de_filial[1] + ' (' + &
								 String(dw_1.Object.cd_filial[1])  + ')'
Else
	dw_3.Object.st_filial.Text = 'TODAS'
End If

If Not IsNull(dw_1.Object.cd_produto) Then
	dw_3.Object.st_produto.Text = dw_1.Object.de_produto[1] + ' (' + &
								  String(dw_1.Object.cd_produto[1])  + ')'
Else
	dw_3.Object.st_produto.Text = 'TODOS'
End If

dw_3.Sort()
dw_3.GroupCalc()

Return AncestorReturnValue
end event

