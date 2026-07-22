HA$PBExportHeader$w_ge459_lead_time_distribuidora.srw
forward
global type w_ge459_lead_time_distribuidora from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge459_lead_time_distribuidora from dc_w_selecao_lista_relatorio
string tag = "w_ge459_lead_time_distribuidora"
integer width = 5650
integer height = 2744
string title = "GE459 - Lead Time das Distribuidoras"
end type
global w_ge459_lead_time_distribuidora w_ge459_lead_time_distribuidora

type variables
uo_filial io_Filial
end variables

forward prototypes
public subroutine wf_set_somente_consulta ()
public subroutine wf_insere_distribuidora_default ()
end prototypes

public subroutine wf_set_somente_consulta ();dw_2.of_Set_Somente_Leitura(False)
end subroutine

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

on w_ge459_lead_time_distribuidora.create
call super::create
end on

on w_ge459_lead_time_distribuidora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;wf_Insere_Distribuidora_Default()

dw_1.Object.Dh_Emissao_Ini	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Emissao_Fim	[1] = dw_1.Object.Dh_Emissao_Ini[1]
end event

event close;call super::close;Destroy(io_Filial)
end event

event ue_preopen;call super::ue_preopen;io_Filial = Create uo_filial

MaxHeight = 9999
MaxWidth = 9999
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge459_lead_time_distribuidora
integer x = 37
integer y = 848
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge459_lead_time_distribuidora
integer x = 0
integer y = 776
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge459_lead_time_distribuidora
integer y = 544
integer width = 5531
integer height = 1984
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge459_lead_time_distribuidora
integer width = 1883
integer height = 508
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge459_lead_time_distribuidora
integer width = 1815
integer height = 392
string dataobject = "dw_ge459_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If Not io_Filial.Localizada Then
			io_Filial.of_Inicializa()
		End If
		
		This.Object.Cd_Filial		[1]	= io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1]	= io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge459_lead_time_distribuidora
integer x = 73
integer y = 620
integer width = 5445
integer height = 1884
string dataobject = "dw_ge459_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Filial
Long ll_Qt_Prazo
Long ll_NF

DateTime ldh_Emissao_Ini
DateTime ldh_Emissao_Fim
DateTime ldh_Receb_Ini
DateTime ldh_Receb_Fim

String ls_Distribuidora

dw_1.AcceptText()

ll_Filial				= dw_1.Object.Cd_Filial									[1]
ldh_Emissao_Ini	= DateTime(dw_1.Object.Dh_Emissao_Ini			[1], Time('00:00:00'))
ldh_Emissao_Fim	= DateTime(dw_1.Object.Dh_Emissao_Fim			[1], Time('23:59:59'))
ldh_Receb_Ini		= DateTime(dw_1.Object.Dh_Recebimento_Ini		[1], Time('00:00:00'))
ldh_Receb_Fim		= DateTime(dw_1.Object.Dh_Recebimento_Fim	[1], Time('23:59:59'))
ls_Distribuidora		= dw_1.Object.Cd_Distribuidora						[1]
ll_Qt_Prazo			= dw_1.Object.Qt_Prazo									[1]
ll_NF					= dw_1.Object.Nr_NF										[1]

If IsNull(ldh_Emissao_Ini) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da emiss$$HEX1$$e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "dh_emissao_ini")
	Return -1
End If

If IsNull(ldh_Emissao_Fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da emiss$$HEX1$$e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "dh_emissao_fim")
	Return -1
End If

If ldh_Emissao_Ini > ldh_Emissao_Fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da emiss$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_emissao_fim")
	Return -1
End If

This.of_AppendWhere("b.dh_recebimento >= '" + String(ldh_Emissao_Ini, "yyyy/mm/dd hh:mm:ss") + "' and b.dh_recebimento <= '" + String(ldh_Emissao_Fim, "yyyy/mm/dd hh:mm:ss") + "'")

If Not IsNull(ldh_Receb_Ini) And Not IsNull(ldh_Receb_Fim) Then
	If ldh_Receb_Ini > ldh_Receb_Fim Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio do recebimento n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
		dw_1.Event ue_Pos(1, "dh_recebimento_fim")
		Return -1
	End If
End If

If Not IsNull(ldh_Receb_Ini) Then
	This.of_AppendWhere("a.dh_recebimento >= '" + String(ldh_Receb_Ini, "yyyy/mm/dd") + "'")
End If

If Not IsNull(ldh_Receb_Fim) Then	
	This.of_AppendWhere("a.dh_recebimento <= '" + String(ldh_Receb_Fim, "yyyy/mm/dd") + "'")
End If

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere("c.cd_filial = " + String(ll_Filial))
End If

If ls_Distribuidora <> "000000000" Then
	If ls_Distribuidora <> "053404705" Then
		This.of_AppendWhere("f.cd_fornecedor = '" + ls_Distribuidora + "'")
	Else
		//Procura o EC
		This.of_AppendWhere("b.nr_cgc_origem = '84683481019943'")
	End If
End If

If ll_Qt_Prazo > 0 Then
	This.of_AppendWhere("datediff(hh, b.dh_emissao, a.dh_recebimento) >= " + String(ll_Qt_Prazo))
End If

If Not IsNull(ll_NF) And ll_NF > 0 Then
	This.of_AppendWhere("cast(substring(a.de_chave_acesso, 26, 9) as integer) = " + String(ll_NF))
End If

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge459_lead_time_distribuidora
integer x = 2798
integer y = 1412
end type

