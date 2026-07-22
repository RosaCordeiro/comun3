HA$PBExportHeader$w_ge453_reservas_produto_filial.srw
forward
global type w_ge453_reservas_produto_filial from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge453_reservas_produto_filial from dc_w_selecao_lista_relatorio
string tag = "w_ge453_reservas_produto_filial"
integer x = 215
integer y = 220
integer width = 4635
integer height = 1876
string title = "GE453 - Relat$$HEX1$$f300$$ENDHEX$$rio de Reservas de Produtos"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
long backcolor = 80269524
end type
global w_ge453_reservas_produto_filial w_ge453_reservas_produto_filial

type variables
uo_produto ivo_Produto
uo_filial       ivo_filial

DataWindowChild	idwc_Child
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_produto ()
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_localiza_filial ();STRING ls_filial	, &
		 lvs_nulo

Long   lvl_nulo

ls_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(ls_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.nm_filial[1] = ivo_filial.nm_fantasia
	
Else
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.cd_filial[1] 		= lvl_nulo
	dw_1.Object.nm_filial[1] 	= lvs_nulo
	
	ivo_filial.cd_filial	    		= lvl_nulo
	ivo_filial.nm_fantasia   	= lvs_nulo	
	
End If
end subroutine

public subroutine wf_localiza_produto ();Long lvl_nulo

String lvs_Produto , &
		 lvs_nulo

lvs_Produto = dw_1.GetText()

ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
Else
	
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.Cd_Produto[1] = lvl_nulo
	dw_1.Object.De_Produto[1] = lvs_nulo
	
	ivo_Produto.Cd_Produto								= lvl_nulo
	ivo_Produto.ivs_Descricao_Apresentacao_Venda = lvs_nulo
	
End If
end subroutine

public subroutine wf_insere_padrao ();/* Regiao */
idwc_Child  = dw_1.of_InsertRow_DDDW("cd_regiao" )			

idwc_Child.SetItem(1, "cd_regiao", 0	)
idwc_Child.SetItem(1, "de_regiao", "TODAS")

dw_1.Object.cd_regiao[1] = 0

end subroutine

on w_ge453_reservas_produto_filial.create
call super::create
end on

on w_ge453_reservas_produto_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_produto)
Destroy(ivo_filial)

end event

event ue_postopen;call super::ue_postopen;//ivb_Impressao = True
ivo_produto   	= Create uo_produto
ivo_filial	  		= Create uo_filial

This.ivm_Menu.ivb_Permite_Imprimir = True

wf_insere_padrao()

dw_1.Object.Dt_Periodo_De[1] 	= Date(String(gf_primeiro_dia_mes(Today()),'dd/mm')+'/'+ String(Year(Today())))
dw_1.Object.Dt_Periodo_Ate[1] 	= Today()

end event

event ue_preopen;call super::ue_preopen;MaxHeight = 9999
end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge453_reservas_produto_filial
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge453_reservas_produto_filial
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge453_reservas_produto_filial
integer x = 14
integer y = 420
integer width = 4590
integer height = 1284
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge453_reservas_produto_filial
integer x = 14
integer y = 0
integer width = 1879
integer height = 420
integer weight = 700
long backcolor = 79741120
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge453_reservas_produto_filial
integer x = 41
integer y = 68
integer width = 1833
integer height = 344
string dataobject = "dw_ge453_selecao"
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
	Case "nm_filial"	
		
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
	dw_1.Object.Nm_filial[1] = ivo_filial.nm_fantasia
END IF
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
		
	Choose Case lvs_Coluna 
		Case "de_produto" ; WF_Localiza_Produto()
		Case "nm_filial"  ;  WF_Localiza_Filial()
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge453_reservas_produto_filial
integer x = 46
integer y = 468
integer width = 4521
integer height = 1212
string dataobject = "dw_ge453_lista"
boolean controlmenu = true
boolean hsplitscroll = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

//This.Sort()
//This.GroupCalc()

Return pl_Linhas

end event

event dw_2::ue_recuperar;//OverRide

Date 	lvdt_Periodo_De, &
		lvdt_Periodo_Ate

Long 	lvl_Filial, &
	 	lvl_Produto, &
		lvl_Regiao

dw_1.AcceptText()

lvdt_Periodo_De	= dw_1.Object.Dt_Periodo_De	[1]
lvdt_Periodo_Ate	= dw_1.Object.Dt_Periodo_Ate	[1]
lvl_Filial				= dw_1.Object.cd_filial			[1]
lvl_Produto			= dw_1.Object.cd_produto		[1]
lvl_Regiao			= dw_1.Object.cd_regiao		[1]

If Not IsNull(lvl_Filial) Then
	This.Of_appendwhere("f.cd_filial = " + String(lvl_Filial), 1)
	This.Of_appendwhere("f.cd_filial = " + String(lvl_Filial), 2)
End If

If Not IsNull(lvl_Produto) Then
	This.Of_appendwhere("ccp.cd_produto = " + String(lvl_Produto), 1)
	This.Of_appendwhere("ccp.cd_produto = " + String(lvl_Produto), 2)	
End If

If lvl_Regiao > 0 Then
	This.Of_AppendWhere('f.cd_regiao = '+String(lvl_Regiao), 1)
	This.Of_AppendWhere('f.cd_regiao = '+String(lvl_Regiao), 2)
End If

Return This.Retrieve(lvdt_Periodo_De, lvdt_Periodo_Ate)
end event

event dw_2::constructor;call super::constructor;String 	lvs_Coluna[], &
       		lvs_Nome[]
		 
lvs_Coluna = {"tipo","cd_regiao","cd_filial","nm_fantasia","dh_movimentacao","dh_inicio_reserva","dh_termino_reserva","cd_produto","de_produto","nm_cliente","usuario_cliente_funcionario", &
                     "qt_produto","nr_matricula_vendedor","usuario_resp_reserval"}
	
lvs_Nome = {"Tipo Reserva","Regi$$HEX1$$e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$d. Filial","Filial","Movimento","In$$HEX1$$ed00$$ENDHEX$$cio Reserva", "T$$HEX1$$e900$$ENDHEX$$rmino Reserva", "C$$HEX1$$f300$$ENDHEX$$d. Produto", "Produto", "Cliente", "Usu$$HEX1$$e100$$ENDHEX$$rio Cliente", "Qtde Produto Reserva","Matr$$HEX1$$ed00$$ENDHEX$$c. Resp. Reserva","Usu$$HEX1$$e100$$ENDHEX$$rio Resp. Reserva"}

dw_2.of_SetSort(lvs_Coluna, lvs_Nome)
dw_2.of_SetFilter(lvs_Coluna, lvs_Nome)

This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date 	lvdt_Periodo_De, &
		lvdt_Periodo_Ate
		
		
dw_1.AcceptText()

lvdt_Periodo_De	= dw_1.Object.Dt_Periodo_De[1]
lvdt_Periodo_Ate	= dw_1.Object.Dt_Periodo_Ate[1]

If IsNull(lvdt_Periodo_De) or Not IsDate(String(lvdt_Periodo_De)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_periodo_de")
	Return -1
End If

If IsNull(lvdt_Periodo_Ate) or Not IsDate(String(lvdt_Periodo_Ate)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_periodo_ate")	
	Return -1
End If

If lvdt_Periodo_De > lvdt_Periodo_Ate Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_credito_ate")	
	Return -1
End If

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge453_reservas_produto_filial
integer x = 3511
integer y = 28
integer width = 521
integer height = 312
integer taborder = 50
string dataobject = "dw_ge453_relatorio"
boolean hscrollbar = true
end type

event dw_3::ue_preprint;call super::ue_preprint;Date 	lvdt_Inicio	, &
     	lvdt_Termino

lvdt_Inicio		= dw_1.Object.dt_periodo_de [1]
lvdt_Termino	= dw_1.Object.dt_periodo_ate[1]

dw_3.Object.st_filtro.Text = 'Per$$HEX1$$ed00$$ENDHEX$$odo: ' + 	String(lvdt_Inicio , "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
									   					String(lvdt_Termino, "dd/mm/yyyy")
dw_3.Sort()
dw_3.GroupCalc()

Return AncestorReturnValue
end event

