HA$PBExportHeader$w_ge045_consulta_variacao_venda.srw
forward
global type w_ge045_consulta_variacao_venda from dc_w_selecao_lista_detalhe
end type
type dw_4 from dc_uo_dw_base within w_ge045_consulta_variacao_venda
end type
type cbx_sumarizado from checkbox within w_ge045_consulta_variacao_venda
end type
type dw_5 from dc_uo_dw_base within w_ge045_consulta_variacao_venda
end type
end forward

global type w_ge045_consulta_variacao_venda from dc_w_selecao_lista_detalhe
integer width = 3159
integer height = 1924
string title = "GE045 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos com Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os"
dw_4 dw_4
cbx_sumarizado cbx_sumarizado
dw_5 dw_5
end type
global w_ge045_consulta_variacao_venda w_ge045_consulta_variacao_venda

type variables
uo_filial ivo_filial

boolean ivb_salvar
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();String lvs_Filial

dw_1.AcceptText()

lvs_Filial = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

If ivo_Filial.Localizada Then
	
	dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end subroutine

on w_ge045_consulta_variacao_venda.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cbx_sumarizado=create cbx_sumarizado
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cbx_sumarizado
this.Control[iCurrent+3]=this.dw_5
end on

on w_ge045_consulta_variacao_venda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.cbx_sumarizado)
destroy(this.dw_5)
end on

event ue_postopen;call super::ue_postopen;dw_4.Visible = False
dw_5.Visible = False

ivo_Filial = Create uo_Filial

dw_1.Object.dt_periodo_de [1] = Date(gvo_Parametro.of_Dh_Movimentacao())
dw_1.Object.dt_periodo_ate[1] = Date(gvo_Parametro.of_Dh_Movimentacao())

If gvo_Parametro.of_Filial() <> gvo_Parametro.of_Filial_Matriz() Then
	dw_1.Object.Cd_Filial		[1] = gvo_Parametro.Cd_Filial
	dw_1.Object.Nm_Filial	[1] = gvo_Parametro.Nm_Fantasia_Filial
	dw_1.Object.Nm_Filial.Protect = 1
	cbx_sumarizado.Visible = False
	ivb_Salvar = False
Else
	ivb_Salvar = True
End If

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;If IsValid(ivo_Filial) Then Destroy ivo_Filial 

end event

event ue_printimmediate;call super::ue_printimmediate;If cbx_sumarizado.Checked Then
	dw_5.Event ue_PrintImmediate()
Else
	dw_4.Event ue_PrintImmediate()
End If
end event

event ue_print;call super::ue_print;If cbx_sumarizado.Checked Then
	dw_5.Event ue_Print()
Else
	dw_4.Event ue_Print()
End If
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge045_consulta_variacao_venda
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge045_consulta_variacao_venda
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge045_consulta_variacao_venda
integer x = 23
integer y = 1044
integer width = 3063
integer height = 668
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge045_consulta_variacao_venda
integer x = 23
integer y = 4
integer width = 1495
integer height = 268
integer weight = 700
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge045_consulta_variacao_venda
integer x = 23
integer y = 272
integer width = 3063
integer height = 772
integer taborder = 40
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge045_consulta_variacao_venda
integer x = 46
integer y = 68
integer width = 1449
integer height = 184
integer taborder = 60
string dataobject = "dw_ge045_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nm_filial"
		
		If IsNull(data) or data = "" Then
					
			SetNull(ivo_filial.cd_filial)
			ivo_filial.nm_fantasia = ""
			
			This.Object.cd_filial[row] = ivo_filial.cd_filial
			This.Object.nm_filial[row] = ivo_filial.nm_fantasia
			
		End If
		
		If data <> ivo_filial.nm_fantasia Then
			Return 1
		End If
End Choose

end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If key = KeyEnter! Then
	
	If lvs_Coluna = 'nm_filial' Then
	
		wf_Localiza_Filial()
	End If
	
End If
end event

event dw_1::ue_saveas;// OverRide

If cbx_sumarizado.Checked Then
	dw_2.Event ue_SaveAs()
Else
	dw_3.Event ue_SaveAs()
End If
end event

event dw_1::getfocus;call super::getfocus;If dw_2.RowCount() > 0 Then
	If ivb_Salvar Then
		dw_2.ivo_Controle_Menu.of_SalvarComo(True)
		dw_2.ivo_Controle_Menu.of_Imprimir(True)
	Else
		dw_2.ivo_Controle_Menu.of_SalvarComo(False)	
		dw_2.ivo_Controle_Menu.of_Imprimir(False)
	End If
End If

Return AncestorReturnValue
end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge045_consulta_variacao_venda
integer x = 55
integer y = 348
integer width = 3008
integer height = 676
integer taborder = 50
string dataobject = "dw_ge045_listadw2"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime	lvdt_Inicio, &
			lvdt_Termino
			
Long lvl_Filial

dw_1.AcceptText()

lvl_Filial  	= dw_1.Object.Cd_Filial		 [1]
lvdt_Inicio		= dw_1.Object.dt_periodo_de [1]
lvdt_Termino	= dw_1.Object.dt_periodo_ate[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", StopSign!)
	dw_1.Event ue_Pos(1,"dt_periodo_de")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1,"dt_periodo_ate")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de inicio.", StopSign!)
	dw_1.Event ue_Pos(1,"dt_periodo_ate")
	Return -1	
End If

This.ShareData(dw_5)

If IsNull(lvl_Filial) Then
	If Not cbx_sumarizado.Checked Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Sem a sele$$HEX2$$e700e300$$ENDHEX$$o de uma filial a emiss$$HEX1$$e300$$ENDHEX$$o relat$$HEX1$$f300$$ENDHEX$$rio pode demorar.~r~nDeseja prosseguir sem informar a filial?", Information!,YesNo!,2)=2 Then
			dw_1.Event ue_Pos(1,"nm_filial")
			Return -1
		End If
	End If			
Else
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
End If

This.of_AppendWhere(" n.dh_movimentacao_caixa >= '" + String(lvdt_Inicio ,"YYYYMMDD") + "'")
This.of_AppendWhere(" n.dh_movimentacao_caixa <= '" + String(lvdt_Termino,"YYYYMMDD") + "'")

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;//SORT E FILTER DA CLASSE NOVA 
//CONSTRUCTOR DA DW_2

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nr_nf", "de_especie", "de_serie","dh_emissao","dh_movimentacao_caixa","id_tipo_venda", "usuario_usuario_liberacao"}

lvs_Nome = {"nota", "esp$$HEX1$$e900$$ENDHEX$$cie", "s$$HEX1$$e900$$ENDHEX$$rie","emiss$$HEX1$$e300$$ENDHEX$$o","data de movimenta$$HEX2$$e700e300$$ENDHEX$$o","tipo de venda","usu$$HEX1$$e100$$ENDHEX$$rio"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		 

end event

event dw_2::ue_saveas;// OverRide
String	lvs_Arquivo, &
		lvs_Diretorio

Integer lvi_Retorno
	
If cbx_sumarizado.Checked Then	
	// Verifica o nome do arquivo
	If Trim(This.ivs_Arquivo_SalvarComo) = "" or IsNull(This.ivs_Arquivo_SalvarComo) Then
		lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
												lvs_Diretorio, &
												lvs_Arquivo, &
												"XLS", "Arquivos do Excel (*.XLS),*.XLS,")
		
		If lvi_Retorno = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
			Return 
		Else
			If lvi_Retorno = 0 Then Return
		End If
	Else
		lvs_Diretorio = This.ivs_Arquivo_SalvarComo
	End If
	
	lvs_Diretorio = Upper(lvs_Diretorio)
	
	// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
	If FileExists(lvs_Diretorio) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
			If Not FileDelete(lvs_Diretorio) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
				Return
			End If
		Else
			Return 
		End If   
	End If
	
	// Salva o arquivo
	lvi_Retorno = This.SaveAs(lvs_Diretorio, Excel!, True)
	
	If lvi_Retorno <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
		Return 
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
	End If
Else
	dw_3.Event ue_SaveAs()
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Double lvd_Liquido, &
		 lvd_Praticado
		 
Long	lvl_Linha

If This.RowCount() > 0 Then
	This.ivo_Controle_Menu.of_Imprimir(True)
	This.ivo_Controle_Menu.of_Classificar(True)
	This.ivo_Controle_Menu.of_Filtrar(True)
	
	If ivb_Salvar Then
		This.ivm_Menu.mf_SalvarComo(True)
	Else
		This.ivm_Menu.mf_SalvarComo(False)
	End If
	
	If cbx_sumarizado.Checked Then
		For lvl_Linha = 1 To This.RowCount()
			lvd_Liquido		= This.Object.preco_liquido	[lvl_Linha]
			lvd_Praticado	= This.Object.preco_praticado	[lvl_Linha]
			
			This.Object.pc_desc[lvl_Linha] = Round( (((lvd_Liquido - lvd_Praticado) /  lvd_Liquido) * 100), 2)
		Next
	End If
Else
	This.ivo_Controle_Menu.of_Imprimir(False)
	This.ivo_Controle_Menu.of_Classificar(False)
	This.ivo_Controle_Menu.of_Filtrar(False)
End If

This.Sort()

Return AncestorReturnValue
end event

event dw_2::rowfocuschanged;//OverRide
If ivb_Selecao_Linhas Then
	This.SelectRow(0, False)
	This.SelectRow(CurrentRow, True)
End If

//call super::rowfocuschanged;
If Not cbx_sumarizado.Checked Then
	If CurrentRow > 0 Then
		dw_3.Event ue_Retrieve()
	End If
End If

If This.RowCount() > 0 Then
	This.ivo_Controle_Menu.of_Classificar(True)
	This.ivo_Controle_Menu.of_Filtrar(True)
	This.ivo_Controle_Menu.of_Imprimir(True)

	If ivb_Salvar Then
		This.ivo_Controle_Menu.of_SalvarComo(True)
	Else
		This.ivo_Controle_Menu.of_SalvarComo(False)	
	End If
	
Else
	This.ivo_Controle_Menu.of_Classificar(False)
	This.ivo_Controle_Menu.of_Filtrar(False)
	This.ivo_Controle_Menu.of_Imprimir(False)
End If
end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 Then
	This.ivo_Controle_Menu.of_Classificar(True)
	This.ivo_Controle_Menu.of_Filtrar(True)
	This.ivo_Controle_Menu.of_Imprimir(True)

	If ivb_Salvar Then
		This.ivo_Controle_Menu.of_SalvarComo(True)
	Else
		This.ivo_Controle_Menu.of_SalvarComo(False)	
	End If
	
Else
	This.ivo_Controle_Menu.of_Classificar(False)
	This.ivo_Controle_Menu.of_Filtrar(False)
	This.ivo_Controle_Menu.of_Imprimir(False)
End If

Return AncestorReturnValue


end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge045_consulta_variacao_venda
integer x = 64
integer y = 1112
integer width = 2729
integer height = 576
integer taborder = 70
string dataobject = "dw_ge045_listadw3"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_3::ue_recuperar;//OverRide

LONG ll_row	, ll_Linhas
		  
ll_row = dw_2.GetRow()

IF ll_row <= 0 THEN RETURN 0

RETURN THIS.Retrieve(dw_2.Object.cd_filial [ll_row], &
						   dw_2.Object.nr_nf	  	 [ll_row], &
						   dw_2.Object.de_especie[ll_row], &
						   dw_2.Object.de_serie	 [ll_row])

end event

event dw_3::ue_saveas;// Override
Date	lvdt_Inicio,&
		lvdt_Termino

Long	lvl_Linha,&
		lvl_Filial
	 
If This.RowCount() = 0 Then Return

lvdt_Inicio		= Date(dw_1.Object.dt_periodo_de [1])
lvdt_Termino	= Date(dw_1.Object.dt_periodo_ate[1])
lvl_Filial			= dw_1.Object.cd_filial[1]

dc_uo_ds_Base lvds

lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("ds_ge045_excel") Then 
	Destroy(lvds)
	Return
End If

SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Preparando Salva em Excel..."

If (Not IsNull(lvl_Filial))and(lvl_Filial > 0) Then
	lvds.of_appendwhere('nf.cd_filial='+String(lvl_Filial))
else
	lvds.of_appendwhere('nf.cd_filial > 0')
End If

lvds.ReTrieve(lvdt_Inicio, lvdt_Termino)

If lvds.RowCount() > 0 Then
	lvds.of_SaveAs("")
End If

Close(w_Aguarde)

SetPointer(Arrow!)

Destroy(lvds)
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If dw_2.RowCount() > 0 Then
	If ivb_Salvar Then
		dw_2.ivm_Menu.mf_SalvarComo(True)
		dw_2.ivm_Menu.mf_Classificar(True)
		dw_2.ivm_Menu.mf_Filtrar(True)
		dw_2.ivm_Menu.mf_Imprimir(True)
	Else
		dw_2.ivm_Menu.mf_SalvarComo(False)	
		dw_2.ivm_Menu.mf_Classificar(False)
		dw_2.ivm_Menu.mf_Filtrar(False)
		dw_2.ivm_Menu.mf_Imprimir(False)
	End If
End If

This.Sort()

Return AncestorReturnValue
end event

event dw_3::getfocus;call super::getfocus;If dw_2.RowCount() > 0 Then
	dw_2.ivo_Controle_Menu.of_Imprimir(True)
	
	If ivb_Salvar Then
		dw_2.ivo_Controle_Menu.of_SalvarComo(True)
	Else
		dw_2.ivo_Controle_Menu.of_SalvarComo(False)
	End If

Else
	dw_2.ivo_Controle_Menu.of_Imprimir(False)
End If

Return AncestorReturnValue
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

type dw_4 from dc_uo_dw_base within w_ge045_consulta_variacao_venda
integer x = 2030
integer y = 16
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge045_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preretrieve;call super::ue_preretrieve;String lvs_dataini, &
       lvs_datafim, &
		 lvs_Nm_Filial
			
Long lvl_Filial

dw_1.AcceptText()

lvl_Filial    		= dw_1.Object.Cd_Filial	[1]
lvs_Nm_Filial	= dw_1.Object.Nm_Filial	[1]
lvs_dataini		= STRING(dw_1.Object.dt_periodo_de [1], "YYYYMMDD")
lvs_datafim		= STRING(dw_1.Object.dt_periodo_ate[1], "YYYYMMDD")

This.of_AppendWhere(" nf_venda.dh_movimentacao_caixa >= '" + lvs_dataini + "'")
This.of_AppendWhere(" nf_venda.dh_movimentacao_caixa <= '" + lvs_datafim + "'")
This.of_AppendWhere(" nf_venda.cd_filial = " + String(lvl_Filial))

dw_4.Object.periodo_t.Text = String(dw_1.Object.dt_periodo_de[1], "DD/MM/YYYY") + &
                             " $$HEX1$$e000$$ENDHEX$$ " + String(dw_1.Object.dt_periodo_ate[1], "DD/MM/YYYY")
									  
dw_4.Object.st_filial.Text = String(lvl_Filial, "0000") + " - " + lvs_Nm_Filial

RETURN AncestorReturnValue
end event

event ue_preprint;call super::ue_preprint;This.Event ue_Retrieve()
	
This.Sort()

If This.RowCount() > 0 Then
	Return 1
Else
	Return -1
End If
end event

type cbx_sumarizado from checkbox within w_ge045_consulta_variacao_venda
integer x = 1545
integer y = 156
integer width = 443
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sumarizado ?"
boolean lefttext = true
end type

event clicked;String lvs_Coluna[], &
       lvs_Nome[]
		 
If This.Checked Then
	dw_2.of_ChangeDataObject("dw_ge045_sumarizado")
	lvs_Coluna = {"cd_filial", "nm_fantasia", "preco_liquido","preco_praticado","qtde", "pc_desc"}
	lvs_Nome = {"Filial", "Nome Fantasia", "Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio","Pre$$HEX1$$e700$$ENDHEX$$o Praticado","Quantidade", "Desconto"}
	dw_2.Width		= 2386
	dw_2.Height		= 1344
	gb_2.Width		= 2441
	gb_2.Height		= 1440
	Parent.Width	= 2537
	gb_3.Visible	= False
	dw_3.Visible	= False
Else
	dw_2.of_ChangeDataObject("dw_ge045_listadw2")	
	lvs_Coluna = {"nr_nf", "de_especie", "de_serie","dh_emissao","dh_movimentacao_caixa","id_tipo_venda", "usuario_usuario_liberacao"}
	lvs_Nome = {"nota", "esp$$HEX1$$e900$$ENDHEX$$cie", "s$$HEX1$$e900$$ENDHEX$$rie","emiss$$HEX1$$e300$$ENDHEX$$o","data de movimenta$$HEX2$$e700e300$$ENDHEX$$o","tipo de venda","usu$$HEX1$$e100$$ENDHEX$$rio"}
	dw_2.Width		= 3008
	dw_2.Height		= 676
	gb_2.Width		= 3063
	gb_2.Height		= 772
	Parent.Width	= 3159
	gb_3.Visible	= True
	dw_3.Visible	= True
End If

dw_2.ivm_Menu.mf_SalvarComo(False)
dw_2.ivo_Controle_Menu.of_Imprimir(False)

dw_2.of_SetSort(lvs_Coluna, lvs_Nome)
dw_2.of_SetFilter(lvs_Coluna, lvs_Nome)		 

dw_2.Event ue_Reset()
dw_3.Event ue_Reset()

dw_2.of_SetRowSelection()
end event

type dw_5 from dc_uo_dw_base within w_ge045_consulta_variacao_venda
integer x = 2601
integer y = 16
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge045_relatorio_sumarizado"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;DateTime	lvdt_Inicio, &
			lvdt_Termino

Long lvl_Linha

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.dt_periodo_de [1]
lvdt_Termino	= dw_1.Object.dt_periodo_ate[1]

dw_5.Object.st_periodo.Text = String(lvdt_Inicio,"DD/MM/YYYY") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdt_Termino,"DD/MM/YYYY")

Return AncestorReturnValue
end event

