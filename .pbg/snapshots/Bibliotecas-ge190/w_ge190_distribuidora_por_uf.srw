HA$PBExportHeader$w_ge190_distribuidora_por_uf.srw
forward
global type w_ge190_distribuidora_por_uf from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge190_distribuidora_por_uf
end type
end forward

global type w_ge190_distribuidora_por_uf from dc_w_cadastro_selecao_lista
integer width = 4352
integer height = 2068
string title = "GE190 - Distribuidora por UF"
cb_1 cb_1
end type
global w_ge190_distribuidora_por_uf w_ge190_distribuidora_por_uf

type variables

end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_insere_uf_default ()
public subroutine wf_set_somente_consulta ()
end prototypes

public subroutine wf_insere_distribuidora_default ();Integer lvi_Linha

DataWindowChild lvdwc

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	lvdwc.SetItem(lvi_Linha, "cd_fornecedor", "000000000")
	lvdwc.SetItem(lvi_Linha, "nm_fantasia"  , "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.", StopSign!)
End If
end subroutine

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

public subroutine wf_set_somente_consulta ();String lvs_Mask_Minimo, lvs_Mask_Corte

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CO' Then
	lvs_Mask_Minimo = dw_2.Describe("vl_minimo_pedido.editmask.mask")
	lvs_Mask_Corte = dw_2.Describe("dh_horario_corte.editmask.mask")
	
	dw_2.of_Set_Somente_Leitura(False)
	
	dw_2.Modify("vl_minimo_pedido.editmask.mask = '"+lvs_Mask_Minimo+"'")
	dw_2.Modify("vl_minimo_pedido.editmask.readonly = 'yes'")
	dw_2.Modify("dh_horario_corte.editmask.mask = '"+lvs_Mask_Corte+"'")
	dw_2.Modify("dh_horario_corte.editmask.readonly = 'yes'")
End If
end subroutine

on w_ge190_distribuidora_por_uf.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge190_distribuidora_por_uf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;wf_Insere_Distribuidora_Default()

wf_Insere_Uf_Default()

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CO' Then
	ivm_Menu.mf_Excluir(False)
	cb_1.Visible = False
End If

ivm_Menu.mf_Incluir(False)
end event

event ue_cancel;//OverRide

dw_2.Event ue_Cancel()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge190_distribuidora_por_uf
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge190_distribuidora_por_uf
integer width = 1792
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge190_distribuidora_por_uf
integer x = 55
integer width = 1714
integer height = 244
string dataobject = "dw_ge190_selecao"
end type

event dw_1::ue_cancel;call super::ue_cancel;ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_1::constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Reset()
ivm_Menu.mf_Incluir(False)
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
ivm_Menu.mf_Incluir(False)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge190_distribuidora_por_uf
integer y = 352
integer width = 4247
integer height = 1520
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge190_distribuidora_por_uf
integer width = 1760
integer height = 344
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge190_distribuidora_por_uf
integer x = 73
integer y = 428
integer width = 4183
integer height = 1420
string dataobject = "dw_ge190_lista"
end type

event dw_2::constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::ue_recuperar;//OverRide

String ls_Distribuidora
String ls_Uf
String ls_Homologando

dw_1.AcceptText()

ls_Distribuidora		= dw_1.Object.Cd_Distribuidora			[1]
ls_Uf					= dw_1.Object.Cd_Uf							[1]
ls_Homologando	= dw_1.Object.Id_Homologando_Pedido	[1]

If ls_Distribuidora <> "000000000" Then
	This.of_AppendWhere("d.cd_distribuidora = '" + ls_Distribuidora + "'")
End If

If ls_Uf <> "XX" Then
	This.of_AppendWhere("d.cd_unidade_federacao = '" + ls_Uf + "'")
End If

If ls_Homologando <> "X" Then
	This.of_AppendWhere("d.id_homologando_pedido = '" + ls_Homologando + "'")
End If

Return This.Retrieve()
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long 	ll_Linha, &
		ll_Linha_Ds, &
		ll_Find

String ls_Homologando, &
		ls_ValorPara, &
		ls_Distribuidora, &
		ls_Uf, &
		ls_Uf_Ant, &
		ls_Chave, &
		ls_Msg_Erro, &
		ls_Find, &
		ls_Nulo, &
		ls_Distribuidora_dw1, &
		ls_Uf_dw1

Decimal lvde_Minimo_Pedido

Integer 	lvi_NR_Prazo_Entrega, &
			lvi_Null

DateTime 	lvdh_Horario_Corte, &
				lvdh_Null

SetNull(lvi_Null)
SetNull(lvdh_Null)

This.AcceptText()

For ll_Linha = 1 To This.RowCount()
	
	ls_Distribuidora		= This.Object.Cd_Distribuidora			[ll_Linha]
	ls_Uf					= This.Object.Cd_Unidade_Federacao[ll_Linha]
	ls_Chave				= ls_Distribuidora + '@#!' + ls_Uf
	
	Select id_homologando_pedido, coalesce(vl_minimo_pedido,0), coalesce(nr_prazo_entrega,0), coalesce(dh_horario_corte, Cast("01/01/1900 00:00:00" as datetime))
		Into :ls_Homologando, :lvde_Minimo_Pedido, :lvi_NR_Prazo_Entrega, :lvdh_Horario_Corte
	From distribuidora_uf
	Where cd_distribuidora = :ls_Distribuidora
		And cd_unidade_federacao = :ls_Uf
	Using SqlCa;
	
	If gf_Houve_Alteracao_Dw(This, 'ID_HOMOLOGANDO_PEDIDO', ll_Linha, Ref ls_ValorPara) Then
		Choose Case SqlCa.SqlCode
			Case 0
				//Se for alterado id_homologando de 'N' para 'S' ser$$HEX1$$e100$$ENDHEX$$ mostrada a mensagem abaixo
				If ls_ValorPara = "S" Then
					If ls_Homologando = "N" Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Est$$HEX1$$e100$$ENDHEX$$ sendo alterado o status da distribuidora '" + ls_Distribuidora + "' UF '" + ls_Uf + &
											"~rde 'FATURAMENTO LIBERADO' para 'PEDIDO ELETR$$HEX1$$d400$$ENDHEX$$NICO EM HOMOLOGA$$HEX2$$c700c300$$ENDHEX$$O'. Deseja Continuar?", Question!, YesNo!, 2) = 2 Then
							Return -1
						End If
					End If
				End If
				
				//Se houve altera$$HEX2$$e700e300$$ENDHEX$$o grava hist$$HEX1$$f300$$ENDHEX$$rico
				If ls_Homologando <> ls_ValorPara Then
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_UF', ls_Chave, 'ID_HOMOLOGANDO_PEDIDO', ls_Homologando, ls_ValorPara, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Msg_Erro, True) Then
						Return -1
					End If
				End If
								
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o id_homologando_pedido da tabela distribuidora_uf." +&
								"~rDistribuidora '" + ls_Distribuidora + "' UF '" + ls_Uf + "'", Exclamation!)
				Return -1
				
			Case -1
				SqlCa.of_MsgdbError("Erro ao localizar o id_homologando_pedido da tabela distribuidora_uf")
				Return -1					
		End Choose
			
	End If		
	
	//// Hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o
	// Valor M$$HEX1$$ed00$$ENDHEX$$nimo de pedido de compra
	If SqlCa.SqlCode = 0 And Not IsNull(This.GetItemNumber(ll_Linha, 'vl_minimo_pedido')) Then
		If lvde_Minimo_Pedido <> This.GetItemNumber(ll_Linha, 'vl_minimo_pedido') Then
			If lvde_Minimo_Pedido = 0 Then SetNull(lvde_Minimo_Pedido)
			If This.GetItemNumber(ll_Linha, 'vl_minimo_pedido') = 0 Then This.SetItem(ll_Linha, "vl_minimo_pedido", lvi_Null)
			If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_UF', ls_Chave, 'VL_MINIMO_PEDIDO', String(lvde_Minimo_Pedido), String(This.GetItemNumber(ll_Linha, 'vl_minimo_pedido')), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Msg_Erro, True) Then
				Return -1
			End If
		End If
	End If
	
	// Prazo de Entrega
	If SqlCa.SqlCode = 0 And Not IsNull(This.GetItemNumber(ll_Linha, 'nr_prazo_entrega')) Then
		If lvi_NR_Prazo_Entrega <> This.GetItemNumber(ll_Linha, 'nr_prazo_entrega') Then
			If lvi_NR_Prazo_Entrega = 0 Then SetNull(lvi_NR_Prazo_Entrega)
			If This.GetItemNumber(ll_Linha, 'nr_prazo_entrega') = 0 Then This.SetItem(ll_Linha, "nr_prazo_entrega", lvi_Null)
			If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_UF', ls_Chave, 'NR_PRAZO_ENTREGA', String(lvi_NR_Prazo_Entrega), String(This.GetItemNumber(ll_Linha, 'nr_prazo_entrega')), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Msg_Erro, True) Then
				Return -1
			End If
		End If
	End If
	
	// Hor$$HEX1$$e100$$ENDHEX$$rio de Corte
	If SqlCa.SqlCode = 0 And Not IsNull(This.GetItemDateTime(ll_Linha, 'dh_horario_corte')) Then
		If lvdh_Horario_Corte <> This.GetItemDateTime(ll_Linha, 'dh_horario_corte') Then
			If String(lvdh_Horario_Corte, "hh:mm") = "00:00" Then SetNull(lvdh_Horario_Corte)
			If String(This.GetItemDateTime(ll_Linha, 'dh_horario_corte'), "hh:mm") = "00:00" Then This.SetItem(ll_Linha, "dh_horario_corte", lvdh_Null)
			If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_UF', ls_Chave, 'DH_HORARIO_CORTE', String(lvdh_Horario_Corte), String(This.GetItemDateTime(ll_Linha, 'dh_horario_corte')), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Msg_Erro, True) Then
				Return -1
			End If
		End If
	End If
	
Next

//Verifica exclus$$HEX1$$e300$$ENDHEX$$o

ls_Distribuidora_dw1	= dw_1.Object.Cd_Distribuidora	[1]
ls_Uf_dw1				= dw_1.Object.Cd_Uf					[1]

ll_Linha = 0
SetNull(ls_Nulo)

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

For ll_Linha = 1 To dw_2.RowCount()

	ls_Uf = This.Object.Cd_Unidade_Federacao[ll_Linha]
	
	If ls_Uf = ls_Uf_Ant Then Continue

	If Not lds.of_ChangeDataObject("ds_ge190_lista_uf") Then Return -1
	
	If ls_Distribuidora_dw1 <> "000000000" Then
		lds.of_AppendWhere("d.cd_distribuidora = '" + ls_Distribuidora_dw1 + "'")
	End If
	
	lds.Retrieve(ls_Uf)

	If lds.RowCount() > 0 Then
		For ll_Linha_Ds = 1 To lds.RowCount()
			ls_Find = ("cd_distribuidora = '" + lds.Object.Cd_Distribuidora[ll_Linha_Ds] + "' and cd_unidade_federacao = '" + ls_Uf + "'")
					
			ll_Find = dw_2.Find(ls_Find, 1, dw_2.RowCount())
			
			If ll_Find = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na fun$$HEX2$$e700e300$$ENDHEX$$o Find.", StopSign!)
				Destroy(lds)
				Return -1
			End If
			
			If ll_Find = 0 Then
				ls_Chave = lds.Object.Cd_Distribuidora[ll_Linha_Ds] + '@#!' + ls_Uf
				
				If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_UF', ls_Chave, 'ID_HOMOLOGANDO_PEDIDO', lds.Object.Id_Homologando_Pedido[ll_Linha_Ds], ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Msg_Erro, True) Then
					Destroy(lds)
					Return -1
				End If
			End If							
		Next
		
		ls_Uf_Ant = ls_Uf
	End If
Next

Destroy(lds)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CO' Then
	ivm_Menu.mf_Excluir(False)
End If

If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;// N$$HEX1$$e300$$ENDHEX$$o permitir valor negativo.
Choose Case dwo.Name
	Case "vl_minimo_pedido", "nr_prazo_entrega"
		If Dec(Data) < 0 Then Return 1
End Choose
end event

type cb_1 from commandbutton within w_ge190_distribuidora_por_uf
integer x = 1824
integer y = 244
integer width = 571
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir Distribuidora"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge190_inclui_distribuidora, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Retrieve()
	dw_2.SetFocus()
End If
end event

