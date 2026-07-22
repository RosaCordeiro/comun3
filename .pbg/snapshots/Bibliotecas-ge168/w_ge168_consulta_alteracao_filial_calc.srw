HA$PBExportHeader$w_ge168_consulta_alteracao_filial_calc.srw
forward
global type w_ge168_consulta_alteracao_filial_calc from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge168_consulta_alteracao_filial_calc from dc_w_selecao_lista_relatorio
string tag = "w_ge168_consulta_alteracao_filial_calc"
integer width = 4590
integer height = 1920
string title = "GE168 - Consulta da altera$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo C$$HEX1$$e100$$ENDHEX$$lculo de Estoque Base"
end type
global w_ge168_consulta_alteracao_filial_calc w_ge168_consulta_alteracao_filial_calc

type variables
uo_filial 			io_filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();Integer lvi_Nulo

SetNull(lvi_Nulo)

dw_1.AcceptText()

io_Filial.of_Localiza_Filial(dw_1.GetText())

If io_Filial.Localizada Then
	
	dw_1.Object.Cd_Filial[1]   = io_Filial.Cd_Filial
	dw_1.Object.Nm_Fantasia[1] = io_Filial.Nm_Fantasia
Else
	dw_1.Object.Cd_Filial[1]   = lvi_Nulo
	dw_1.Object.Nm_Fantasia[1] = ""
	
End If
end subroutine

on w_ge168_consulta_alteracao_filial_calc.create
call super::create
end on

on w_ge168_consulta_alteracao_filial_calc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_filial	= Create uo_filial
end event

event close;call super::close;Destroy(io_filial)
end event

event ue_postopen;call super::ue_postopen;Boolean lvb_Sucesso = False

DateTime lvdh_Inicio
DateTime lvdh_Termino

Select dateadd(month, -12, dh_movimentacao),
		 dh_movimentacao
Into	:lvdh_Inicio, 
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
	dw_1.Object.Dt_Inicio 	[1] = Date(String(lvdh_Inicio,  "dd/mm/yyyy"))
	dw_1.Object.Dt_Termino	[1] = Date(String(lvdh_Termino, "dd/mm/yyyy"))
End If
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge168_consulta_alteracao_filial_calc
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge168_consulta_alteracao_filial_calc
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge168_consulta_alteracao_filial_calc
integer y = 292
integer width = 4485
integer height = 1432
string text = "Altera$$HEX2$$e700e300$$ENDHEX$$o C$$HEX1$$e100$$ENDHEX$$lculo"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge168_consulta_alteracao_filial_calc
integer width = 1947
integer height = 276
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge168_consulta_alteracao_filial_calc
integer x = 73
integer width = 1847
integer height = 168
string dataobject = "dw_ge168_selecao_alteracao_calc"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'nm_fantasia' Then
		wf_Localiza_Filial()
	End If
End If
	
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

String ls_Nulo

dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	
	SetNull(lvl_Nulo)
	
	If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Filial[1] = lvl_nulo
			Return 0
		End If	
		
	If Data <> io_Filial.Nm_Fantasia Then Return 1
End if
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge168_consulta_alteracao_filial_calc
integer y = 368
integer width = 4439
integer height = 1344
string dataobject = "dw_ge168_lista_alteracao_filial_calc"
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_2::ue_recuperar;// Override

Long ll_filial

dw_1.AcceptText()

ll_filial = dw_1.Object.cd_filial[1]

If Not IsDate(String(dw_1.Object.Dt_Inicio[1])) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(String(dw_1.Object.Dt_Termino[1])) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If Date(dw_1.Object.Dt_Inicio[1]) > Date(dw_1.Object.Dt_Termino[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If ll_filial <> 0 Then
	This.of_AppendWhere_Subquery("h.de_chave Like '" + String(ll_filial,'0000') + "%'", 2)
End If

Return This.Retrieve(DateTime(Date(dw_1.Object.Dt_Inicio[1]), Time("00:00:00")), &
    DateTime(Date(dw_1.Object.Dt_Termino[1]), Time("23:59:59")) )

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;if pl_linhas > 0 then
	ivm_Menu.mf_SalvarComo(true)
else
	ivm_Menu.mf_SalvarComo(false)
end if

return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge168_consulta_alteracao_filial_calc
boolean visible = false
integer x = 2066
integer y = 96
integer width = 169
integer height = 60
end type

