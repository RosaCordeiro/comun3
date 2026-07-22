HA$PBExportHeader$w_ge372_alteracao_desconto_fornecedor.srw
forward
global type w_ge372_alteracao_desconto_fornecedor from dc_w_cadastro_selecao_lista
end type
type cb_importar from commandbutton within w_ge372_alteracao_desconto_fornecedor
end type
end forward

global type w_ge372_alteracao_desconto_fornecedor from dc_w_cadastro_selecao_lista
integer width = 2322
integer height = 1960
string title = "GE372 - Altera$$HEX2$$e700e300$$ENDHEX$$o de Desconto de Fornecedor"
cb_importar cb_importar
end type
global w_ge372_alteracao_desconto_fornecedor w_ge372_alteracao_desconto_fornecedor

type variables
uo_fornecedor ivo_fornecedor
end variables

forward prototypes
public subroutine wf_lista_divisao_fornecedor ()
end prototypes

public subroutine wf_lista_divisao_fornecedor ();DataWindowChild lvdwc

String ls_SQL, ls_Fornecedor

dw_1.AcceptText()

ls_Fornecedor = dw_1.Object.cd_fornecedor[1]
	
If dw_1.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
		
	ls_SQL = " SELECT 	cast(f.nr_divisao as char(5)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao, f.nr_divisao FROM fornecedor_divisao f   " +&
				 " inner join usuario u on u.nr_matricula = f.nr_matricula_comprador " +&
				 " where f.cd_fornecedor = '" + string(ls_Fornecedor) + "'" +&
				 " union " +&
				 " select 'NENHUMA', null"				 
	
	lvdwc.SetSQLSelect(ls_SQL)
		
	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return 
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild divis$$HEX1$$e300$$ENDHEX$$o fornecedor.")
End If
end subroutine

on w_ge372_alteracao_desconto_fornecedor.create
int iCurrent
call super::create
this.cb_importar=create cb_importar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importar
end on

on w_ge372_alteracao_desconto_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_importar)
end on

event ue_postopen;call super::ue_postopen;ivo_Fornecedor = Create uo_Fornecedor

This.ivm_Menu.mf_Incluir(False)
end event

event close;call super::close;Destroy(ivo_Fornecedor)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge372_alteracao_desconto_fornecedor
integer y = 1372
integer height = 244
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge372_alteracao_desconto_fornecedor
integer y = 1300
integer height = 332
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge372_alteracao_desconto_fornecedor
integer x = 41
integer y = 72
integer width = 2162
integer height = 164
string dataobject = "dw_ge372_selecao"
end type

event dw_1::ue_key;
If key = KeyEnter! Then
	
	If dw_1.GetColumnName() = 'nm_fantasia' Then
		
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Fornecedor.Localizado Then
			This.Object.nm_Fantasia  [1] = ivo_Fornecedor.Nm_Razao_Social
			This.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
			This.SetTabOrder('nr_divisao_fornecedor', 20)
			wf_Lista_Divisao_Fornecedor()
		End If
					
	End If
	
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fantasia  [1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

event dw_1::itemchanged;call super::itemchanged;If This.GetColumnName() = 'nm_fantasia' Then
	If Not IsNull(data) and Trim(data) <> '' Then
		If data <> ivo_Fornecedor.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
		This.Object.nm_fantasia  [1] = ivo_Fornecedor.nm_razao_social
	End If
End If
end event

event dw_1::ue_recuperar;//Override

dw_2.Event ue_Retrieve()

Return 1
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()

Long ll_Nulo

SetNull(ll_Nulo)

This.Object.Nr_Divisao_Fornecedor[1] = ll_Nulo
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge372_alteracao_desconto_fornecedor
integer x = 14
integer y = 396
integer width = 2231
integer height = 1360
integer taborder = 20
long backcolor = 80269524
string text = "Lista de Produtos"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge372_alteracao_desconto_fornecedor
integer x = 14
integer width = 2231
integer height = 248
integer taborder = 30
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge372_alteracao_desconto_fornecedor
integer x = 46
integer y = 468
integer width = 2176
integer height = 1268
integer taborder = 40
string dataobject = "dw_ge372_lista"
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()

String lvs_Coluna[], &
       lvs_Descricao[]

lvs_Coluna    = {"cd_produto", "de_produto", "de_apresentacao_estoque"}
lvs_Descricao = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o", "Apresenta$$HEX2$$e700e300$$ENDHEX$$o de Estoque"}

This.of_SetFilter(lvs_Coluna, lvs_Descricao)


end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Fornecedor

dw_1.AcceptText()

lvs_Fornecedor = dw_1.Object.cd_fornecedor[1]

If IsNull(lvs_Fornecedor) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor.", Information!)
	dw_1.Event ue_Pos(1, "nm_fantasia")
	dw_1.SetFocus()
	Return -1
End If

Return 1


end event

event dw_2::ue_recuperar;// OverRide

Long ll_Divisao

String lvs_Fornecedor

dw_1.AcceptText()

ll_Divisao			= dw_1.Object.Nr_Divisao_Fornecedor	[1]
lvs_Fornecedor	= dw_1.Object.cd_fornecedor				[1]

If Not IsNull(ll_Divisao) Then
	dw_2.of_AppendWhere("pg.cd_produto in ( select cd_produto" + &
														 " from fornecedor_divisao_produto " + &
														 " where cd_fornecedor = '" + lvs_Fornecedor + "'" +&
														 " and nr_divisao = " + String(ll_Divisao) + ")")
End If

Return Retrieve(lvs_Fornecedor)
end event

event dw_2::ue_postretrieve;// OverRide

Boolean lvb_Classificar, &
		  lvb_Filtrar, &
		  lvb_Localizar

If pl_Linhas > 0 Then

	This.ivm_Menu.mf_SalvarComo(True)

	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		This.ivm_Menu.mf_SalvarComo(False)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

ivm_Menu.mf_Filtrar(lvb_Filtrar)
ivm_Menu.mf_Localizar(lvb_Localizar)

Return pl_Linhas
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;If dwo.Name = 'pc_desconto_fornecedor' Then
	This.SelectText(1,7)
End If
 
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long lvl_Linha

Decimal lvdc_Percentual

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	
	For lvl_Linha = 1 To dw_2.RowCount()
		lvdc_Percentual = This.Object.pc_desconto_fornecedor[lvl_Linha]
		
		If lvdc_Percentual < 0.00 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O percentual de desconto deve ser maior ou igual a zero.", Information!)
			Parent.ivm_Menu.mf_Confirmar(False)
			dw_2.Event ue_Pos(lvl_Linha, 'pc_desconto_fornecedor')
			dw_2.SetFocus()
			Return -1
		End If
		
		If lvdc_Percentual > 100.00 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O percentual de desconto n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 100%.", Information!)
			Parent.ivm_Menu.mf_Confirmar(False)
			dw_2.Event ue_Pos(lvl_Linha, 'pc_desconto_fornecedor')
			dw_2.SetFocus()
			Return -1
		End If
	Next
End If

Return 1



end event

event dw_2::losefocus;call super::losefocus;This.ivm_Menu.mf_SalvarComo(False)
end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If
end event

type cb_importar from commandbutton within w_ge372_alteracao_desconto_fornecedor
integer x = 1632
integer y = 280
integer width = 608
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Importar via Excel"
end type

event clicked;Open(w_ge372_importa_desconto_fornecedor)
end event

