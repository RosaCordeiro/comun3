HA$PBExportHeader$w_ge069_relatorio_posicao_geral_cr.srw
forward
global type w_ge069_relatorio_posicao_geral_cr from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge069_relatorio_posicao_geral_cr from dc_w_selecao_lista_relatorio
integer width = 2295
integer height = 1752
string title = "GE069 - Relat$$HEX1$$f300$$ENDHEX$$rio de Posi$$HEX2$$e700e300$$ENDHEX$$o Geral de Contas a Receber"
end type
global w_ge069_relatorio_posicao_geral_cr w_ge069_relatorio_posicao_geral_cr

on w_ge069_relatorio_posicao_geral_cr.create
call super::create
end on

on w_ge069_relatorio_posicao_geral_cr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Inicio [1] = Today()
dw_1.Object.Dt_Termino[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino

String lvs_Periodo

lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

lvs_Periodo = String(lvdt_Inicio, "dd/mm/yyyy") + "  at$$HEX1$$e900$$ENDHEX$$  " + String(lvdt_Termino, "dd/mm/yyyy")

dw_3.Object.Periodo_Cabecalho.Text = lvs_Periodo

Return AncestorReturnValue
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge069_relatorio_posicao_geral_cr
integer x = 23
integer y = 172
integer width = 2203
integer height = 1376
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge069_relatorio_posicao_geral_cr
integer x = 18
integer y = 4
integer width = 1193
integer height = 164
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge069_relatorio_posicao_geral_cr
integer x = 41
integer y = 60
integer width = 1161
integer height = 96
string dataobject = "dw_ge069_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge069_relatorio_posicao_geral_cr
integer x = 46
integer y = 224
integer width = 2162
integer height = 1304
string dataobject = "dw_ge069_lista"
end type

event dw_2::ue_recuperar;// Override

Date lvdt_Inicio, &
     lvdt_Termino
	  
dw_1.AcceptText()

lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"dh_vencimento", &
              "vl_nominal", &
              "vl_aberto", &
				  "vl_juros", &
				  "vl_total_receber"}
				  
lvs_Nome = {"Vencimento", &
            "Valor Nominal", &
				"Valor Aberto", &
				"Valor Juros", &
				"Total a Receber"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge069_relatorio_posicao_geral_cr
integer x = 1266
integer y = 16
integer height = 156
integer taborder = 50
string dataobject = "dw_ge069_relatorio"
end type

