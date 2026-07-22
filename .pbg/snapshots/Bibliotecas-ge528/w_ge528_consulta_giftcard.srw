HA$PBExportHeader$w_ge528_consulta_giftcard.srw
forward
global type w_ge528_consulta_giftcard from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge528_consulta_giftcard from dc_w_selecao_lista_relatorio
string tag = "w_ge528_consulta_giftcard_analitico"
integer width = 4448
integer height = 1868
string title = "GE528 - Consulta Vendas GiftCard"
end type
global w_ge528_consulta_giftcard w_ge528_consulta_giftcard

type variables
uo_filial ivo_filial
Boolean lb_Salvar  = False
end variables

forward prototypes
public function boolean wf_insere_padrao ()
end prototypes

public function boolean wf_insere_padrao ();DataWindowChild lvdwc1

If dw_1.GetChild("cartao", lvdwc1) = 1 Then
	lvdwc1.InsertRow(1)
	
	lvdwc1.SetItem(1, "id_cartao", 0)
	lvdwc1.SetItem(1, "descricao_cartao", "TODOS")
	
	dw_1.Object.cartao[1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Cartao.")
End If



If dw_1.GetChild("formapgto", lvdwc1) = 1 Then
	lvdwc1.InsertRow(1)
	
	lvdwc1.SetItem(1, "id_forma_pagamento", "TD")
	lvdwc1.SetItem(1, "de_descricao_forma_pagamento", "TODOS")
	
	dw_1.Object.formapgto[1] = "TD"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Forma Pagamento.")
End If

dw_1.accepttext( )

Return True 
end function

on w_ge528_consulta_giftcard.create
call super::create
end on

on w_ge528_consulta_giftcard.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Filial		= Create uo_Filial



end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;Date lvdt_Parametro

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

dw_1.Object.dt_inicio[1] = RelativeDate(lvdt_Parametro , -1) 
dw_1.Object.dt_termino[1] = lvdt_Parametro


wf_insere_padrao()






end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge528_consulta_giftcard
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge528_consulta_giftcard
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge528_consulta_giftcard
integer x = 32
integer y = 456
integer width = 4370
integer height = 1216
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge528_consulta_giftcard
integer width = 2139
integer height = 440
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge528_consulta_giftcard
integer width = 2002
integer height = 344
string dataobject = "dw_ge528_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
	
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial 
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If	
	End Choose
End If



end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge528_consulta_giftcard
integer x = 59
integer y = 520
integer width = 3744
integer height = 1104
string dataobject = "dw_ge528_lista_gifcard"
boolean maxbox = true
end type

event dw_2::ue_recuperar;//OverRide
DateTime	ldh_Inicio,&
				ldh_Fim

Long ll_Filial
Long ll_Linhas
Long ls_Dw_Largura
Long ll_Cartao

String ls_Dw
String lvs_FormaPgto
String ls_Estorno

dw_1.AcceptText()

ldh_Inicio		= Datetime(dw_1.Object.dt_inicio				[1])
ldh_Fim			= Datetime(dw_1.Object.dt_termino			[1])
ll_Filial			= dw_1.Object.cd_filial							[1]
lvs_FormaPgto	= dw_1.Object.formapgto						[1]
ll_Cartao			= dw_1.Object.cartao								[1]
ls_Estorno 		= dw_1.Object.id_estorno 						[1]

If dw_1.Object.Id_Tipo[1] = "A" Then
	ls_Dw = "dw_ge528_lista_gifcard_analitica"
	ls_Dw_Largura = 4340
	dw_2.HScrollBar = TRUE
Else
	ls_Dw = "dw_ge528_lista_gifcard"
	ls_Dw_Largura = 3721
	dw_2.HScrollBar = FALSE
End If

If This.DataObject <> ls_Dw Then
	dw_2.setRedraw(False)
	If Not dw_2.of_ChangeDataObject(ls_Dw) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no change data object da dw '" + ls_Dw + "'.", StopSign!)
		Return 1
	End If
	
	This.Width  = ls_Dw_Largura		
	
	This.of_SetRowSelection()
	This.GroupCalc()
	dw_2.setRedraw(True)
End If

If Not IsNull(ldh_Inicio) and Not IsNull(ldh_Fim) Then
	If ldh_Inicio > ldh_Fim Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data final.")
		dw_1.SetColumn("dt_inicio")
		Return 1
	End If
End If

If ls_Estorno = 'S' Then
	This.of_appendwhere( "lc.id_estorno = 'X' ")
End If

If Not IsNull(ll_Filial) or ll_Filial>0 Then
	This.of_AppendWhere("  a.cd_filial = "+String(ll_Filial))
End If

If lvs_FormaPgto<>"TD" Then
	This.of_AppendWhere("  a.cd_forma_pagamento = '"+String(lvs_FormaPgto)+"'")
End If

If ll_Cartao > 0  Then
	This.of_AppendWhere("  a.cd_cartao = "+String(ll_Cartao))
End If

This.Retrieve(ldh_Inicio,ldh_Fim)

This.of_SetRowSelection( "if(id_estorno = ~"SIM~", rgb(255, 140, 105), " + This.ivs_Cor_Linha_Padrao + ")", "", False )

This.ivo_Controle_Menu.of_SalvarComo(True)

Return 1 
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge528_consulta_giftcard
boolean visible = false
integer x = 3616
integer y = 36
end type

