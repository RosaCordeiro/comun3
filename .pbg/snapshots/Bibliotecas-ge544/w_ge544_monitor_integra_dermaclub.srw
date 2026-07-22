HA$PBExportHeader$w_ge544_monitor_integra_dermaclub.srw
forward
global type w_ge544_monitor_integra_dermaclub from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
end forward

global type w_ge544_monitor_integra_dermaclub from dc_w_2tab_consulta_selecao_lista_det
integer width = 3598
integer height = 2164
string title = "GE544 - Monitor de Integra$$HEX2$$e700e300$$ENDHEX$$o DermaClub"
end type
global w_ge544_monitor_integra_dermaclub w_ge544_monitor_integra_dermaclub

type variables
dc_uo_dw_base dw_1, dw_2, dw_3, dw_4
end variables

forward prototypes
public subroutine wf_insere_uf_default ()
end prototypes

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

on w_ge544_monitor_integra_dermaclub.create
int iCurrent
call super::create
end on

on w_ge544_monitor_integra_dermaclub.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivl_Altura_1		= 1984
ivl_Largura_1	= 3561

ivl_Altura_2 		= 1984
ivl_Largura_2 	= 3561
end event

event open;call super::open;dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
dw_4 = Tab_1.TabPage_3.dw_4
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Termino	[1] = gvo_Parametro.of_Dh_Movimentacao()

wf_Insere_UF_Default()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge544_monitor_integra_dermaclub
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge544_monitor_integra_dermaclub
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge544_monitor_integra_dermaclub
integer width = 3520
integer height = 1944
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
end on

event tab_1::selectionchanged;call super::selectionchanged;Choose Case NewIndex
	Case 3
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_3.dw_4.SetFocus()
End Choose

SetPointer(Arrow!)
end event

event tab_1::selectionchanging;call super::selectionchanging;SetPointer(HourGlass!)

If NewIndex = 3 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_3.dw_4.Event ue_Retrieve()

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3483
integer height = 1828
cb_1 cb_1
cb_2 cb_2
end type

on tabpage_1.create
this.cb_1=create cb_1
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 440
integer width = 3442
integer height = 1360
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 1527
integer height = 428
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 1445
integer height = 320
string dataobject = "dw_ge544_selecao"
end type

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 512
integer width = 3378
integer height = 1252
string dataobject = "dw_ge544_lista"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

If IsNull(dw_1.Object.Dh_Inicio[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(dw_1.Object.Dh_Termino[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If dw_1.Object.Dh_Inicio[1] > dw_1.Object.Dh_Termino[1] Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior que o t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If dw_1.Object.Cd_UF[1] <> "XX" Then
	This.of_AppendWhere("cd_uf = '" + dw_1.Object.Cd_UF[1] + "'")
End If

If Not IsNull(dw_1.Object.Nr_Campanha[1]) And dw_1.Object.Nr_Campanha[1] > 0 Then
	This.of_AppendWhere("nr_campanha = " + String(dw_1.Object.Nr_Campanha[1]))
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(Long(dw_1.Object.Id_Tipo[1]), dw_1.Object.Dh_Inicio[1], DateTime(Date(dw_1.Object.Dh_Termino[1]), Time('23:59:59')))
end event

event dw_2::constructor;call super::constructor;//This.of_SetRowSelection( "if(cd_produto is null, if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)),  if(getrow() = currentrow(), rgb(139,129,76), rgb(255,236,139)) )", "", False )

//This.of_SetRowSelection( "if(id_vigente = ~"S~", if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)),  if(getrow() = currentrow(), rgb(139,129,76), rgb(255,236,139)) )", "", False )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3483
integer height = 1828
string text = "Produto"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3433
integer height = 1784
string text = "Produto"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3360
integer height = 1696
string dataobject = "dw_ge544_detalhe"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

//This.of_SetRowSelection()
This.of_SetSort()
This.of_SetFilter()

This.of_SetRowSelection("if(isnull(cd_produto), if(getrow() = currentrow(), rgb(174, 174, 0), rgb(255, 255, 128)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255,255,255)))", "", false)
end event

event dw_3::ue_recuperar;//OverRide

dw_2.AcceptText()

Return This.Retrieve(dw_2.Object.Nr_Atualizacao[dw_2.GetRow()])
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type cb_1 from commandbutton within tabpage_1
boolean visible = false
integer x = 1774
integer y = 8
integer width = 960
integer height = 168
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Carga de Produtos DermaClub"
end type

event clicked;//Case '/CPRD' //Carga de Produtos DermaClub
//				lvs_Procedimento =  "EX - CARGA DE PRODUTOS DERMACLUB"
//				If gvo_Aplicacao.of_AppIsRunning(lvs_Procedimento) Then Halt Close
//				dc_w_MDI.Title = lvs_Procedimento
				
			//	uo_ge536_dermaclub_carga lo_Carga
			//	lo_Carga = Create uo_ge536_dermaclub_carga
			//	lo_Carga.of_Processa_Carga_Produto()
		//		Destroy(lo_Carga)
			gf_atualiza_data_execucao_tarefa(160, True)
end event

type cb_2 from commandbutton within tabpage_1
boolean visible = false
integer x = 1778
integer y = 212
integer width = 1157
integer height = 172
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "ENVIO DE INFORMA$$HEX2$$c700c300$$ENDHEX$$O DERMACLUB"
end type

event clicked;//Case '/EDEV' //Envio de Informa$$HEX2$$e700e300$$ENDHEX$$o DermaClub
//				lvs_Procedimento =  "EX - ENVIO DE INFORMA$$HEX2$$c700c300$$ENDHEX$$O DERMACLUB"
//				If gvo_Aplicacao.of_AppIsRunning(lvs_Procedimento) Then Halt Close
//				dc_w_MDI.Title = lvs_Procedimento
//				uo_ge536_dermaclub_envio_info lo_Envio
//				lo_Envio = Create uo_ge536_dermaclub_envio_info
//				lo_Envio.of_Processa_Envio()
//				Destroy(lo_Envio)
				gf_atualiza_data_execucao_tarefa(164, True)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3483
integer height = 1828
long backcolor = 67108864
string text = "Progressivo"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_3
integer x = 27
integer y = 28
integer width = 3429
integer height = 1780
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Desconto Progressivo"
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 69
integer y = 96
integer width = 3360
integer height = 1676
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge544_desc_progressivo"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True

//This.of_SetRowSelection()
This.of_SetSort()
This.of_SetFilter()

This.of_SetRowSelection("if(isnull(cd_produto), if(getrow() = currentrow(), rgb(174, 174, 0), rgb(255, 255, 128)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255,255,255)))", "", false)
end event

event ue_recuperar;//OverRide

dw_2.AcceptText()

Return This.Retrieve(dw_2.Object.Nr_Atualizacao[dw_2.GetRow()])
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

