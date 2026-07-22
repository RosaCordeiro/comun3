HA$PBExportHeader$w_ge480_altera_dia_pedido.srw
forward
global type w_ge480_altera_dia_pedido from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge480_altera_dia_pedido
end type
end forward

global type w_ge480_altera_dia_pedido from dc_w_response_ok_cancela
integer width = 1458
integer height = 644
string title = "GE480 - Inclui/Altera Agendamento do Pedido"
dw_2 dw_2
end type
global w_ge480_altera_dia_pedido w_ge480_altera_dia_pedido

type variables
str_agendamento_pedido st

String is_Novos_Dias_Cad
end variables

forward prototypes
public subroutine wf_dia_semana_pedido ()
public subroutine wf_seleciona_dia_pedido (long al_dia)
public subroutine wf_valida_qtd_dias (ref boolean ab_alteracao, ref long al_contador)
public function boolean wf_grava_alteracao ()
end prototypes

public subroutine wf_dia_semana_pedido ();Long ll_Len
Long ll_Linha

String ls_Caracter

ll_Len = LenA(st.Nr_Dia_Semana)

For ll_Linha = 1 To ll_Len
	ls_Caracter = MidA(st.Nr_Dia_Semana, ll_Linha, 1)
	
	If IsNumber(ls_Caracter) Then
		wf_Seleciona_Dia_Pedido(Long(ls_Caracter))
	End If
Next
end subroutine

public subroutine wf_seleciona_dia_pedido (long al_dia);Choose Case al_Dia
	Case 2
		dw_1.Object.Dia_2[1] = "S"
		dw_1.Object.Dia_2_Ant[1] = "S"
		
	Case 3
		dw_1.Object.Dia_3[1] = "S"
		dw_1.Object.Dia_3_Ant[1] = "S"
		
	Case 4
		dw_1.Object.Dia_4[1] = "S"
		dw_1.Object.Dia_4_Ant[1] = "S"
		
	Case 5
		dw_1.Object.Dia_5[1] = "S"
		dw_1.Object.Dia_5_Ant[1] = "S"
		
	Case 6
		dw_1.Object.Dia_6[1] = "S"
		dw_1.Object.Dia_6_Ant[1] = "S"
End Choose

Return
end subroutine

public subroutine wf_valida_qtd_dias (ref boolean ab_alteracao, ref long al_contador);dw_1.AcceptText()

If (dw_1.Object.Dia_2[1] <> dw_1.Object.Dia_2_Ant[1]) Or (dw_1.Object.Dia_3[1] <> dw_1.Object.Dia_3_Ant[1]) Or (dw_1.Object.Dia_4[1] <> dw_1.Object.Dia_4_Ant[1]) Or + &
	(dw_1.Object.Dia_5[1] <> dw_1.Object.Dia_5_Ant[1]) Or (dw_1.Object.Dia_6[1] <> dw_1.Object.Dia_6_Ant[1]) Then
	ab_Alteracao = True
End If

is_Novos_Dias_Cad = ""

If dw_1.Object.Dia_2[1] = "S" Then
	al_Contador++
	is_Novos_Dias_Cad  = "2"
End If

If dw_1.Object.Dia_3[1] = "S" Then
	al_Contador++
	
	If is_Novos_Dias_Cad <> "" Then
		is_Novos_Dias_Cad += ",3"
	Else
		is_Novos_Dias_Cad = "3"
	End If
End If

If dw_1.Object.Dia_4[1] = "S" Then
	al_Contador++
	
	If is_Novos_Dias_Cad <> "" Then
		is_Novos_Dias_Cad += ",4"
	Else
		is_Novos_Dias_Cad = "4"
	End If
End If

If dw_1.Object.Dia_5[1] = "S" Then
	al_Contador++
	
	If is_Novos_Dias_Cad <> "" Then
		is_Novos_Dias_Cad += ",5"
	Else
		is_Novos_Dias_Cad = "5"
	End If
End If

If dw_1.Object.Dia_6[1] = "S" Then
	al_Contador++
	
	If is_Novos_Dias_Cad <> "" Then
		is_Novos_Dias_Cad += ",6"
	Else
		is_Novos_Dias_Cad = "6"
	End If
End If
end subroutine

public function boolean wf_grava_alteracao ();Long ll_Linha
Long ll_Dia

String ls_Erro

Delete From pedido_filial_bloqueio
Where cd_filial = :st.Cd_Filial
	And id_tipo_bloqueio = 'C'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o bloqueio da pedido_filial_bloqueio. " + ls_Erro, StopSign!)
	Return False
End If

dw_2.SetFilter('')
dw_2.Filter()

If is_Novos_Dias_Cad <> "" Then
	dw_2.SetFilter("nr_dia_semana not in (" + is_Novos_Dias_Cad + ")")
	dw_2.Filter()
End If

For ll_Linha = 1 To dw_2.RowCount()
	ll_Dia = dw_2.Object.Nr_Dia_Semana[ll_Linha]
	
	Insert Into pedido_filial_bloqueio(id_tipo_bloqueio, cd_filial, cd_distribuidora, dh_pedido, nr_dia_semana, de_motivo_bloqueio)
		Values('C', :st.Cd_Filial, Null, Null, :ll_Dia, Null)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o bloqueio na tabela pedido_filial_bloqueio. " + ls_Erro, StopSign!)
		Return False
	End If
Next

If is_Novos_Dias_Cad = "" Then
	If Not gf_ge4480_Altera_Parametro_Ped_Conve(st.Cd_Filial, "N") Then Return False
Else
	If Not gf_ge4480_Altera_Parametro_Ped_Conve(st.Cd_Filial, "S") Then Return False
End If

SqlCa.of_Commit();
CloseWithReturn(This, "OK")
end function

on w_ge480_altera_dia_pedido.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ge480_altera_dia_pedido.destroy
call super::destroy
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;st = Message.PowerObjectParm

dw_1.Object.Filial_t.Text = st.Filial

dw_1.Object.Dia_2_Ant[1] = dw_1.Object.Dia_2[1]
dw_1.Object.Dia_3_Ant[1] = dw_1.Object.Dia_3[1]
dw_1.Object.Dia_4_Ant[1] = dw_1.Object.Dia_4[1]
dw_1.Object.Dia_5_Ant[1] = dw_1.Object.Dia_5[1]
dw_1.Object.Dia_6_Ant[1] = dw_1.Object.Dia_6[1]

wf_Dia_Semana_Pedido()

dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge480_altera_dia_pedido
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge480_altera_dia_pedido
integer width = 1362
integer height = 400
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge480_altera_dia_pedido
integer width = 1303
integer height = 304
string dataobject = "dw_ge480_lista_dia"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge480_altera_dia_pedido
integer x = 754
integer y = 436
string text = "OK"
end type

event cb_ok::clicked;call super::clicked;Boolean lb_Alteracao

Long ll_Qt_Dias_Lib

wf_Valida_Qtd_Dias(Ref lb_Alteracao, Ref ll_Qt_Dias_Lib)

If Not lb_Alteracao Then
	cb_Cancelar.Event Clicked()
	Return -1
End If

If ll_Qt_Dias_Lib > 2 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o permitidos mais do que 2 dias na semana para gerar pedido conveni$$HEX1$$ea00$$ENDHEX$$ncia.", Exclamation!)
	dw_1.SetFocus()
	Return -1
End If

If is_Novos_Dias_Cad = "" Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum dia foi selecionado.~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then Return -1
Else	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then Return -1
End If

If Not wf_Grava_Alteracao() Then Return -1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge480_altera_dia_pedido
integer x = 1088
integer y = 436
end type

type dw_2 from dc_uo_dw_base within w_ge480_altera_dia_pedido
boolean visible = false
integer x = 233
integer y = 88
integer taborder = 20
boolean bringtotop = true
string dataobject = "ddw_descricao_dia_semana"
end type

