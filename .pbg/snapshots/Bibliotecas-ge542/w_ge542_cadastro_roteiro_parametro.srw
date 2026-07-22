HA$PBExportHeader$w_ge542_cadastro_roteiro_parametro.srw
forward
global type w_ge542_cadastro_roteiro_parametro from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge542_cadastro_roteiro_parametro from dc_w_cadastro_selecao_lista
integer width = 3749
integer height = 2316
string title = "GE542 - Cadastro Roteiro de Entrega"
end type
global w_ge542_cadastro_roteiro_parametro w_ge542_cadastro_roteiro_parametro

type variables
uo_filial io_Filial
end variables

forward prototypes
public function long wf_proximo_codigo ()
public function boolean wf_filial_disque_entrega (long pl_filial)
end prototypes

public function long wf_proximo_codigo ();Long ll_Ultimo

Select Max(id_parametro) 
Into :ll_Ultimo
from roteiro_parametro
where cd_filial = :io_Filial.cd_filial
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdberror("Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo par$$HEX1$$e200$$ENDHEX$$metro da roteiro_parametro.")
	Return -1
End If

If Sqlca.sqlcode = 0 Then 
	If IsNull(ll_Ultimo) Then	
		ll_Ultimo = 0 
	End If
End If

ll_Ultimo++

Return ll_Ultimo

end function

public function boolean wf_filial_disque_entrega (long pl_filial);String ls_Valor

select vl_parametro
	into :ls_Valor
from parametro_loja where cd_filial = :pl_Filial
and cd_parametro = 'ID_DISQUE_ENTREGA'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Erro ao locar o par$$HEX1$$e200$$ENDHEX$$metro Filial Disque Entrega.")	
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro 'ID_DISQUE_ENTREGA' n$$HEX1$$e300$$ENDHEX$$o foi localizado para a filial " + String(pl_Filial))
		Return False
	Case 0
		Return ( ls_Valor = 'S' )
End Choose

end function

on w_ge542_cadastro_roteiro_parametro.create
call super::create
end on

on w_ge542_cadastro_roteiro_parametro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;If IsValid(io_Filial) Then Destroy(io_Filial)
end event

event ue_postopen;call super::ue_postopen;io_Filial = Create uo_filial
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge542_cadastro_roteiro_parametro
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge542_cadastro_roteiro_parametro
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge542_cadastro_roteiro_parametro
integer width = 1691
integer height = 96
string dataobject = "dw_ge542_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If io_Filial.Localizada Then
				
				If Not wf_filial_disque_entrega(io_Filial.cd_filial) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial selecionada n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativa no Disque Entrega.",Exclamation!)	
					
					io_Filial.of_Inicializa()
					This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
					This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
					
					Return -1
				End If
				
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
				
				dw_2.Event ue_Retrieve()
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		End If
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge542_cadastro_roteiro_parametro
integer y = 232
integer width = 3643
integer height = 1884
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge542_cadastro_roteiro_parametro
integer width = 1765
integer height = 204
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge542_cadastro_roteiro_parametro
integer y = 304
integer width = 3566
integer height = 1764
string dataobject = "dw_ge542_lista_roteiro"
end type

event dw_2::ue_recuperar;//OverRide

Long ll_Filial

dw_1.AcceptText()

ll_FIlial = dw_1.Object.cd_filial[1]

If IsNull(ll_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma filial.", Exclamation! )
	dw_1.event ue_Pos(1,"nm_fantasia")
	Return -1
End If

Return This.Retrieve( ll_Filial )
end event

event dw_2::itemchanged;call super::itemchanged;DateTime lt_Null

Integer li_Null

SetNull(lt_Null)
SetNull(li_Null)

If dwo.Name = 'id_tipo' Then
	If Data = 'D' Then //Demanda
		This.Object.dh_horario_saida	[row] = lt_Null
//		This.Object.dh_horario_corte	[row] = lt_Null
		This.Object.qt_limite_pedido	[row] = li_Null		
		
	Else
		//Horario Fixo
		This.Object.dh_inicio		[row] = lt_Null
		This.Object.dh_termino	[row] = lt_Null
	End If
		
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_LInhas = 0 Then
	This.Event ue_AddRow()
End If

Return pl_Linhas
end event

event dw_2::ue_preinsertrow;call super::ue_preinsertrow;If IsNull( dw_1.Object.cd_filial[1] ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe uma filial.", Exclamation!)
	Return 0
End If

If This.RowCount() > 0 Then
	If IsNull(This.Object.id_parametro[this.RowCount()]) Then
		Return 0
	End If
End If

Return AncestorReturnValue
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long	ll_Linha, &
		ll_Total, &
		ll_Proximo_Codigo, &
		ll_Find

String ls_Descricao, ls_Tipo, ls_Obs, ls_Dia

Time lt_Saida, lt_Corte, lt_Inicio, lt_Termino

Integer li_Qt_Limite, i, li_Qtde_Aux 

dw_2.AcceptText()

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de linhas da DW
ll_Total = This.RowCount()

For ll_Linha = 1 To ll_Total
	li_Qtde_Aux = 0
	
	ls_Descricao	= Trim( This.Object.de_parametro 		[ll_Linha] )
	lt_Saida		= Time( This.Object.dh_horario_saida	[ll_Linha] )
	lt_Corte		= Time(This.Object.dh_horario_corte		[ll_Linha] )
	li_Qt_Limite	= This.Object.qt_limite_pedido				[ll_Linha]
	ls_Tipo		= This.Object.id_tipo							[ll_Linha]
	lt_Inicio		= Time(This.Object.dh_inicio				[ll_Linha] )
	lt_Termino	= Time(This.Object.dh_termino			[ll_Linha] )
	lt_Termino	= Time(This.Object.dh_termino			[ll_Linha] )
	ls_Dia			= This.Object.id_dia_entrega				[ll_Linha]
	ls_Obs		= This.Object.de_observacao				[ll_Linha]
	//Troca os caracteres especiais
	ls_Obs 		= gf_troca_caracteres_especiais(ls_Obs)
	
	If IsNull( ls_Descricao ) Or ls_Descricao = '' Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha a descri$$HEX2$$e700e300$$ENDHEX$$o da rota de entrega.", Exclamation! )
		This.Event ue_Pos( ll_Linha, 'de_parametro' )
		Return -1
	End If
	
	//Demanda
	If ls_Tipo = 'D' Then
		For i=1 To ll_Total
			If This.Object.id_dia_entrega[i] = ls_Dia Then 
				li_Qtde_Aux++
			End If
		Next
		
		//Tipo: Por demanda s$$HEX1$$f300$$ENDHEX$$ permitir$$HEX1$$e100$$ENDHEX$$ 1 registro por dia de entrega
		If li_Qtde_Aux > 1 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O roteiro " + ls_Descricao + " foi definido Por Demanda, por$$HEX1$$e900$$ENDHEX$$m, existem outros registros com o mesmo dia de entrega.", Exclamation!)
			This.Event ue_Pos(ll_Linha, "id_tipo")
			Return -1
		End If	
		
		If IsNull( lt_Inicio ) Or lt_Inicio <= Time('0:00:00')  Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha corretamente o hor$$HEX1$$e100$$ENDHEX$$rio de in$$HEX1$$ed00$$ENDHEX$$cio da rota de entrega.", Exclamation! )
			This.Event ue_Pos( ll_Linha, 'dh_inicio' )
			Return -1
		End If
		
		If IsNull( lt_Termino ) Or lt_Termino <= Time('0:00:00')  Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha corretamente o hor$$HEX1$$e100$$ENDHEX$$rio de t$$HEX1$$e900$$ENDHEX$$rmino da rota de entrega.", Exclamation! )
			This.Event ue_Pos( ll_Linha, 'dh_termino' )
			Return -1
		End If
		
		If lt_Inicio > lt_Termino Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O hor$$HEX1$$e100$$ENDHEX$$rio de t$$HEX1$$e900$$ENDHEX$$rmino est$$HEX1$$e100$$ENDHEX$$ superior ao hor$$HEX1$$e100$$ENDHEX$$rio de in$$HEX1$$ed00$$ENDHEX$$cio da rota de entrega.", Exclamation! )
			This.Event ue_Pos( ll_Linha, 'dh_horario_corte' )
			Return -1
		End If
		
	Else
		If IsNull( lt_Saida ) Or lt_Saida <= Time('0:00:00')  Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha corretamente o hor$$HEX1$$e100$$ENDHEX$$rio de sa$$HEX1$$ed00$$ENDHEX$$da da rota de entrega.", Exclamation! )
			This.Event ue_Pos( ll_Linha, 'dh_horario_saida' )
			Return -1
		End If
		
		If IsNull( lt_Corte ) Or lt_Corte <= Time('0:00:00')  Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha corretamente o hor$$HEX1$$e100$$ENDHEX$$rio de corte da rota de entrega.", Exclamation! )
			This.Event ue_Pos( ll_Linha, 'dh_horario_corte' )
			Return -1
		End If
		
		If lt_Corte > lt_Saida Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O hor$$HEX1$$e100$$ENDHEX$$rio de corte est$$HEX1$$e100$$ENDHEX$$ superior ao hor$$HEX1$$e100$$ENDHEX$$rio de sa$$HEX1$$ed00$$ENDHEX$$da da rota de entrega.", Exclamation! )
			This.Event ue_Pos( ll_Linha, 'dh_horario_corte' )
			Return -1
		End If
		
		If IsNull( li_Qt_Limite ) Or li_Qt_Limite <= 0 Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha a quantidade limite de pedidos.", Exclamation! )
			This.Event ue_Pos( ll_Linha, 'qt_limite_pedido' )
			Return -1
		End If
	End If
Next

// Localiza a primeira linha sem c$$HEX1$$f300$$ENDHEX$$digo
ll_Linha = This.Find("isnull(id_parametro)", 0, ll_Total)

ll_Proximo_Codigo = wf_Proximo_Codigo()

// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While ll_Linha > 0

	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.id_parametro	[ll_Linha] = ll_Proximo_Codigo
	This.Object.cd_filial			[ll_Linha] = io_Filial.cd_filial

	ll_Linha = This.Find("isnull(id_parametro)", ll_Linha, ll_Total)
Loop

Return 1
end event

event dw_2::constructor;//Over Ride

String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

//Habilita aux$$HEX1$$ed00$$ENDHEX$$lio visual?
If gvo_aplicacao.ivb_Usa_Aux_Visual Then This.of_habilita_aux_visual()

ivi_Tipo_Cancelar = RETRIEVE

end event

