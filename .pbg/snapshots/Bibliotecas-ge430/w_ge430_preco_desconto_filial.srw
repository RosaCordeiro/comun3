HA$PBExportHeader$w_ge430_preco_desconto_filial.srw
forward
global type w_ge430_preco_desconto_filial from dc_w_sheet
end type
type cb_1 from commandbutton within w_ge430_preco_desconto_filial
end type
type dw_1 from dc_uo_dw_base within w_ge430_preco_desconto_filial
end type
type gb_1 from groupbox within w_ge430_preco_desconto_filial
end type
end forward

global type w_ge430_preco_desconto_filial from dc_w_sheet
integer width = 1888
integer height = 700
string title = "GE430 - Pre$$HEX1$$e700$$ENDHEX$$os e Produtos Filial"
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge430_preco_desconto_filial w_ge430_preco_desconto_filial

type variables
uo_filial ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_insere_grupo_default ()
end prototypes

public subroutine wf_localiza_filial ();dw_1.AcceptText()

ivo_filial.of_Localiza_Filial(dw_1.GetText())

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial	[1]	= ivo_Filial.Cd_Filial
	dw_1.Object.nm_filial	[1]	= ivo_Filial.nm_fantasia
End If
end subroutine

public subroutine wf_insere_grupo_default ();DataWindowChild lvdwc

Integer 	lvi_Retorno,&
        		lvi_Row

If dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_grupo", "0")
	lvdwc.SetItem(1, "de_grupo", "TODOS")
	
	dw_1.Object.cd_grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If
end subroutine

on w_ge430_preco_desconto_filial.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_ge430_preco_desconto_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;ivo_filial = Create uo_filial

dw_1.Event ue_AddRow() 
dw_1.SetFocus()


wf_insere_grupo_default()
end event

event close;call super::close;Destroy ivo_Filial
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge430_preco_desconto_filial
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge430_preco_desconto_filial
end type

type cb_1 from commandbutton within w_ge430_preco_desconto_filial
integer x = 1339
integer y = 372
integer width = 471
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;String lvs_Arquivo, lvs_Grupo, lvs_Tipo 

uo_Produto ivo_Produto 
ivo_Produto = Create uo_Produto

Decimal{2}	lvdc_Preco, &
				lvdc_Desconto, &
				lvdc_Preco_Promocao,&
				lvdc_Desconto_Clube
				
Long	lvl_Linha, &
		lvl_Linhas, &
		lvl_Filial, &	
		lvl_Produto
		
dw_1.AcceptText()
		
lvl_Filial		= dw_1.Object.cd_filial[1]
lvs_Grupo 	= dw_1.Object.cd_grupo[1]
lvs_tipo		= dw_1.Object.de_situacao[1]

If IsNull(lvl_Filial)Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial corretamente.")
	dw_1.Event ue_Pos(1, "nm_filial")
	dw_1.SetFocus()
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o da planilha ?", Question!, YesNo!, 2) = 2 Then
	Return
End IF

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject("ds_ge430_produtos") Then
	Destroy(lvds_1)
	Destroy(ivo_Produto)
End If

If lvs_Grupo <> '0' Then
	lvds_1.of_AppendWhere("substring(cd_subcategoria,1,1) = '" + lvs_Grupo + "'")
End If

If lvs_Tipo <> 'T' Then
	lvds_1.of_AppendWhere("id_situacao = '" + lvs_Tipo + "'")
End If

lvds_1.Retrieve()

SetPointer(HourGlass!)

lvl_Linhas = lvds_1.RowCount()

Open(w_Aguarde)
w_Aguarde.Title = "Gerando o Arquivo..."

w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto = lvds_1.Object.cd_produto[lvl_Linha]
	
	ivo_Produto.of_Localiza_Produto(String(lvl_Produto))
	
	If ivo_Produto.Localizado Then
		lvdc_Preco				= ivo_Produto.of_Preco_Venda_Filial_Matriz(lvl_Filial)
		lvdc_Desconto			= ivo_Produto.Of_Desconto_Filial(lvl_Filial)
		lvdc_Preco_Promocao	= Round(lvdc_Preco - (lvdc_Preco * (lvdc_Desconto / 100)), 2)
		
		lvds_1.Object.vl_preco				[lvl_Linha] = String(lvdc_Preco)
		lvds_1.Object.pc_desconto			[lvl_Linha] = String(lvdc_Desconto)
		lvds_1.Object.vl_preco_calculado	[lvl_Linha] = String(lvdc_Preco_Promocao)
		
		lvdc_Desconto_Clube    = ivo_Produto.of_Desconto_Clube_Filial(lvl_Filial)
	
		lvds_1.Object.pc_desconto_clube[lvl_Linha] = string(lvdc_Desconto_Clube)
	End If

	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

lvs_Arquivo = "c:\sistemas\co\arquivos\produto_" + string(lvl_Filial) + ".xls"

Close(w_Aguarde)

lvds_1.of_saveAs("")
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar o arquivo em excel. '" + lvs_Arquivo + "'")
//Else
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi gerado com sucesso.~r~r" + lvs_Arquivo)
//End If


SetPointer(Arrow!)

Destroy(lvds_1)
Destroy(ivo_Produto)

Return
end event

type dw_1 from dc_uo_dw_base within w_ge430_preco_desconto_filial
integer x = 59
integer y = 72
integer width = 1723
integer height = 240
integer taborder = 20
string dataobject = "dw_ge430_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If key = KeyEnter! Then
	
	wf_Localiza_Filial()
	
End If
end event

event itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
		This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
	End If
End If
end event

event losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

type gb_1 from groupbox within w_ge430_preco_desconto_filial
integer x = 27
integer y = 12
integer width = 1778
integer height = 332
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
borderstyle borderstyle = styleraised!
end type

