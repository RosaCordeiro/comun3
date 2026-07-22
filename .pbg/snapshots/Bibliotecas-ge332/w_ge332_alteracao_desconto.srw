HA$PBExportHeader$w_ge332_alteracao_desconto.srw
forward
global type w_ge332_alteracao_desconto from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within w_ge332_alteracao_desconto
end type
type gb_1 from groupbox within w_ge332_alteracao_desconto
end type
end forward

global type w_ge332_alteracao_desconto from dc_w_sheet
string accessiblename = "Altera$$HEX2$$e700e300$$ENDHEX$$o de Desconto (GE332)"
integer width = 1518
integer height = 420
string title = "GE332 - Altera$$HEX2$$e700f500$$ENDHEX$$es de Descontos"
dw_1 dw_1
gb_1 gb_1
end type
global w_ge332_alteracao_desconto w_ge332_alteracao_desconto

forward prototypes
public subroutine wf_imprime_relatorio ()
public function boolean wf_valida_periodo (ref date adt_inicio, ref date adt_termino)
public subroutine wf_gera_excel ()
end prototypes

public subroutine wf_imprime_relatorio ();Date ldt_Inicio
Date ldt_Termino

Long ll_Linhas

dw_1.AcceptText()

If Not wf_Valida_Periodo( Ref ldt_Inicio, Ref ldt_Termino ) Then Return

dc_uo_ds_base lds_Relatorio
lds_Relatorio = Create dc_uo_ds_base

lds_Relatorio.of_ChangeDataObject("dw_ge332_rel_alteracao_desconto")

ll_Linhas = lds_Relatorio.Retrieve(ldt_Inicio, RelativeDate(ldt_Termino,1))

If ll_Linhas > 0 Then
	lds_Relatorio.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para serem impressas." )
End If

Destroy lds_Relatorio


end subroutine

public function boolean wf_valida_periodo (ref date adt_inicio, ref date adt_termino);Date ldt_Inicio
Date ldt_Termino

dw_1.AcceptText()

ldt_Inicio  		= dw_1.Object.dh_inicio		[1]
ldt_Termino 	= dw_1.Object.dh_Termino	[1]

If IsNull(ldt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1,"dh_inicio")
	Return False
End If

If IsNull(ldt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	dw_1.Event ue_Pos(1,"dh_termino")
	Return False
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor do que a data de t$$HEX1$$e900$$ENDHEX$$mino.", Information!)
	dw_1.Event ue_Pos(1,"dh_inicio")
	Return False
End If

adt_Inicio		= ldt_Inicio
adt_Termino	= ldt_Termino

Return True
end function

public subroutine wf_gera_excel ();Long ll_Linhas

Date ldt_Inicio, ldt_Termino

String ls_Diretorio, ls_Arquivo

If Not wf_Valida_Periodo( Ref ldt_Inicio, Ref ldt_Termino ) Then Return

ls_Diretorio 		= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
ls_Arquivo 			= ls_Diretorio + "AlteracaoDesconto_" + String( ldt_Inicio, 'ddmmyy' ) + "_" + String( ldt_Termino, 'ddmmyy' )

dc_uo_ds_base lds_Relatorio
lds_Relatorio = Create dc_uo_ds_base

lds_Relatorio.of_ChangeDataObject("dw_ge332_rel_alteracao_desconto")

ll_Linhas = lds_Relatorio.Retrieve(ldt_Inicio, RelativeDate(ldt_Termino,1))

Choose Case ll_Linhas
	
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi localizada." )
		
	Case is < 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw dw_ge332_rel_alteracao_desconto " )
		
	Case is > 63000	//TEXTO
		If lds_Relatorio.SaveAs( ls_Arquivo + '.txt', TEXT!, True ) > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo salvo com sucesso.~r~rLocal: " + ls_Arquivo + '.txt')
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + ls_Arquivo + "'.txt" )
		End If

		
	Case Else //Excel
		If lds_Relatorio.SaveAs( ls_Arquivo + '.xls', EXCEL!, True ) > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo salvo com sucesso.~r~rLocal: " + ls_Arquivo + '.xls')
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + ls_Arquivo + "'.xls" )
		End If
	
End Choose

Destroy lds_Relatorio

end subroutine

on w_ge332_alteracao_desconto.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
end on

on w_ge332_alteracao_desconto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;Dw_1.Event ue_AddRow()

dw_1.Object.Dh_Inicio		[1] = RelativeDate(Today(), -1)
dw_1.Object.Dh_Termino	[1] = Today()

ivm_Menu.mf_Imprimir(True)

ivm_Menu.mf_SalvarComo(True)
end event

event open;call super::open;ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_print;call super::ue_print;wf_imprime_relatorio()
end event

event ue_printimmediate;call super::ue_printimmediate;wf_imprime_relatorio()
end event

event ue_saveas;call super::ue_saveas;wf_gera_excel()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge332_alteracao_desconto
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge332_alteracao_desconto
end type

type dw_1 from dc_uo_dw_base within w_ge332_alteracao_desconto
integer x = 137
integer y = 88
integer width = 1221
integer height = 76
integer taborder = 20
string dataobject = "dw_ge332_selecao"
end type

type gb_1 from groupbox within w_ge332_alteracao_desconto
integer x = 23
integer y = 12
integer width = 1426
integer height = 196
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

