HA$PBExportHeader$w_ge421_relatorio_transf_entre_filiais.srw
forward
global type w_ge421_relatorio_transf_entre_filiais from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge421_relatorio_transf_entre_filiais from dc_w_selecao_lista_relatorio
integer width = 2400
integer height = 1908
string title = "GE421 - Relat$$HEX1$$f300$$ENDHEX$$rio de Transfer$$HEX1$$ea00$$ENDHEX$$ncias entre Filiais"
end type
global w_ge421_relatorio_transf_entre_filiais w_ge421_relatorio_transf_entre_filiais

forward prototypes
public function boolean wf_atualiza_entradas ()
end prototypes

public function boolean wf_atualiza_entradas ();Date lvdt_Inicio, &
     lvdt_Termino

Long lvl_Total, &
     lvl_Row, &
	  lvl_Find, &
	  lvl_Filial, &
	  lvl_Linha_Nova
	  
Decimal{2} lvdc_Saidas, &
           lvdc_Entradas

String lvs_Fantasia, &
       lvs_Descricao, &
		 lvs_Grupo
		 
dc_uo_ds_base lvds_Entradas
lvds_Entradas = Create dc_uo_ds_base

If Not lvds_Entradas.of_ChangeDataObject("ds_ge421_lista_entradas") Then Return False

dw_1.AcceptText()

lvdt_Inicio  = dw_1.Object.Dt_Inicio[1]
lvdt_Termino = dw_1.Object.Dt_Fim[1]

w_Aguarde.Title = "Atualizando Entradas das Filiais..."

lvl_Total = lvds_Entradas.Retrieve(lvdt_Inicio, lvdt_Termino)

If lvl_Total > 0 Then
	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Row = 1 To lvl_Total
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)
		
		lvl_Filial    = lvds_Entradas.Object.Cd_Filial[lvl_Row]
		lvs_Fantasia  = lvds_Entradas.Object.Nm_Fantasia[lvl_Row]
		lvs_Grupo     = lvds_Entradas.Object.Cd_Grupo[lvl_Row]
		lvs_Descricao = lvds_Entradas.Object.De_Grupo[lvl_Row]
		lvdc_Entradas = lvds_Entradas.Object.Vl_Entradas[lvl_Row]
		lvdc_Saidas   = lvds_Entradas.Object.Vl_Saidas[lvl_Row]
				
		If lvl_Filial = 1 Then
			lvl_Find = dw_2.Find("cd_filial = 534 and cd_grupo = '" +lvs_Grupo + "'", 1 ,dw_2.RowCount())						  
		Else					
			lvl_Find = dw_2.Find("cd_filial = " + String(lvl_Filial) + " and cd_grupo = '" + &
						  lvs_Grupo + "'", 1 ,dw_2.RowCount())
		End If
		
		If lvl_Find > 0 Then
			
			dw_2.Object.Vl_Entradas[lvl_Find] = dw_2.Object.Vl_Entradas[lvl_Find] + lvdc_Entradas
			dw_2.Object.Vl_Saidas[lvl_Find]   = dw_2.Object.Vl_Saidas[lvl_Find] +lvdc_Saidas
			
		ElseIf lvl_Find = 0 Then
			lvl_Linha_Nova = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Filial[lvl_Linha_Nova]   = lvl_Filial
			dw_2.Object.Nm_Fantasia[lvl_Linha_Nova] = lvs_Fantasia
			dw_2.Object.Cd_Grupo[lvl_Linha_Nova]    = lvs_Grupo
			dw_2.Object.De_Grupo[lvl_Linha_Nova]    = lvs_Descricao
			dw_2.Object.Vl_Entradas[lvl_Linha_Nova] = lvdc_Entradas
			dw_2.Object.Vl_Saidas[lvl_Linha_Nova]   = lvdc_Saidas			
			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find ao localizar a filial: " + String(lvl_Filial) + &
			           " e no grupo: " + lvs_Grupo, StopSign!)
			Return False
		End If
	Next	
End If

Return True
end function

on w_ge421_relatorio_transf_entre_filiais.create
call super::create
end on

on w_ge421_relatorio_transf_entre_filiais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Inicio[1] = Today()
dw_1.Object.Dt_Fim[1]    = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_preprint;call super::ue_preprint;dw_1.AcceptText()

dw_3.Object.Dt_Periodo.Text = String(dw_1.Object.Dt_Inicio[1], "dd/mm/yyyy") + " at$$HEX1$$e900$$ENDHEX$$:" + &
                              String(dw_1.Object.Dt_Fim[1],"dd/mm/yyyy")

Return AncestorReturnValue
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge421_relatorio_transf_entre_filiais
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge421_relatorio_transf_entre_filiais
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge421_relatorio_transf_entre_filiais
integer x = 14
integer y = 192
integer width = 2336
integer height = 1516
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge421_relatorio_transf_entre_filiais
integer x = 14
integer y = 0
integer width = 1271
integer height = 188
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge421_relatorio_transf_entre_filiais
integer x = 55
integer y = 68
integer width = 1221
integer height = 104
string dataobject = "dw_ge421_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge421_relatorio_transf_entre_filiais
integer x = 46
integer y = 268
integer width = 2267
integer height = 1408
string dataobject = "dw_ge421_lista_saidas"
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_Inicio, &
     lvdt_Termino
	  
dw_1.AcceptText()

lvdt_Inicio  = dw_1.Object.Dt_Inicio[1]
lvdt_Termino = dw_1.Object.Dt_Fim[1]

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando Informa$$HEX2$$e700f500$$ENDHEX$$es... Favor Aguardar..."

This.SetRedraw(False)

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Boolean lvb_Sucesso = True

If Not wf_Atualiza_Entradas() Then lvb_Sucesso = False

Close(w_Aguarde)
This.SetRedraw(True)	

This.GroupCalc()
This.Sort()

If Not lvb_Sucesso Then Return -1

If This.RowCount() > 0 Then
	
	This.ivm_Menu.mf_SalvarComo(True)
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge421_relatorio_transf_entre_filiais
integer x = 1408
integer y = 40
integer height = 120
string dataobject = "dw_ge421_relatorio"
end type

