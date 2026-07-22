HA$PBExportHeader$w_ge190_inclui_distribuidora.srw
forward
global type w_ge190_inclui_distribuidora from dc_w_response_ok_cancela
end type
end forward

global type w_ge190_inclui_distribuidora from dc_w_response_ok_cancela
integer width = 1979
integer height = 752
string title = "GE190 - Inclui Distribuidora"
end type
global w_ge190_inclui_distribuidora w_ge190_inclui_distribuidora

type variables
String is_Responsavel
end variables

forward prototypes
public function boolean wf_verifica_distribuidora_uf_existe (string as_distribuidora, string as_uf)
end prototypes

public function boolean wf_verifica_distribuidora_uf_existe (string as_distribuidora, string as_uf);String ls_Distribuidora
String ls_Uf

Select	cd_distribuidora,
		cd_unidade_federacao
Into	:ls_Distribuidora,
		:ls_Uf
From distribuidora_uf
Where cd_distribuidora = :as_Distribuidora
	And cd_unidade_federacao = :as_Uf
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0		
		If (ls_Distribuidora = as_Distribuidora) And (ls_Uf = as_Uf) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora '" + ls_Distribuidora + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ associada para a UF '" + ls_Uf + "'.")
			Return False
		End If
		
	Case 100
		//N$$HEX1$$e300$$ENDHEX$$o localizou, portanto ser$$HEX1$$e100$$ENDHEX$$ cadastrado
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao consultar a distribuidora e a uf na tabela distribuidora_uf. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_distribuidora_uf_existe")
		Return False
		
End Choose

Return True
end function

on w_ge190_inclui_distribuidora.create
call super::create
end on

on w_ge190_inclui_distribuidora.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;is_Responsavel = Message.StringParm
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge190_inclui_distribuidora
boolean visible = false
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge190_inclui_distribuidora
integer width = 1920
integer height = 512
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge190_inclui_distribuidora
integer y = 72
integer width = 1861
integer height = 420
string dataobject = "dw_ge190_inclui_distribuidora"
end type

event dw_1::itemchanged;call super::itemchanged;// N$$HEX1$$e300$$ENDHEX$$o permitir valor negativo.
Choose Case dwo.Name
	Case "vl_minimo_pedido", "nr_prazo_entrega"
		If Dec(Data) < 0 Then Return 1
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge190_inclui_distribuidora
integer x = 1303
integer y = 544
end type

event cb_ok::clicked;call super::clicked;String	ls_Distribuidora, &
		ls_Uf, &
		ls_Homologando = "S", &
		ls_Chave, &
		ls_Msg_Erro, &
		ls_Nulo
		
Decimal lvde_VL_Minimo_Pedido
Integer lvi_NR_Prazo_Entrega
DateTime lvdh_Horario_Corte

dw_1.AcceptText()

ls_Distribuidora				= dw_1.GetItemString(1, 'Cd_Distribuidora')
ls_Uf							= dw_1.GetItemString(1, 'Cd_Uf')
lvde_VL_Minimo_Pedido	= dw_1.GetItemNumber(1, 'vl_minimo_pedido')
lvi_NR_Prazo_Entrega		= dw_1.GetItemNumber(1, 'nr_prazo_entrega')
lvdh_Horario_Corte		= dw_1.GetItemDateTime(1, 'dh_horario_corte')

If IsNull(ls_Distribuidora) Or ls_Distribuidora = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora.")
	dw_1.Event ue_Pos(1, "cd_distribuidora")
	Return -1
End If

If IsNull(ls_Uf) Or ls_Uf = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a UF.")
	dw_1.Event ue_Pos(1, "cd_uf")
	Return -1
End If

If lvde_VL_Minimo_Pedido = 0 Then SetNull(lvde_VL_Minimo_Pedido)
If lvi_NR_Prazo_Entrega = 0 Then SetNull(lvi_NR_Prazo_Entrega)
If String(lvdh_Horario_Corte, "hh:mm") = "00:00" Then SetNull(lvdh_Horario_Corte)

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a associa$$HEX2$$e700e300$$ENDHEX$$o da distribuidora '" + ls_Distribuidora + "' para a UF '" + ls_Uf + "'?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

If Not wf_Verifica_Distribuidora_Uf_Existe(ls_Distribuidora, ls_Uf) Then
	Return -1
End If

//Estoque Central inclui como 'N$$HEX1$$c300$$ENDHEX$$O HOMOLOGANDO'
If ls_Distribuidora = "053404705" Then
	ls_Homologando = "N"
End If

ls_Chave = ls_Distribuidora + '@#!' + ls_Uf
SetNull(ls_Nulo)

//Se der erro na fun$$HEX2$$e700e300$$ENDHEX$$o de gravar hist$$HEX1$$f300$$ENDHEX$$rico, ela mesma faz o Rollback
If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_UF', ls_Chave, 'ID_HOMOLOGANDO_PEDIDO', ls_Nulo, "S", is_Responsavel, 'I', Ref ls_Msg_Erro, True) Then
	Return -1
End If

Insert Into distribuidora_uf(cd_distribuidora, cd_unidade_federacao, id_homologando_pedido, vl_minimo_pedido, nr_prazo_entrega, dh_horario_corte)
Values(:ls_Distribuidora, :ls_Uf, :ls_Homologando, :lvde_VL_Minimo_Pedido, :lvi_NR_Prazo_Entrega, :lvdh_Horario_Corte)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	SqlCa.of_MsgdbError("Erro ao inserir a distribuidora na distribuidora_uf. Evento clicked")
	Return -1
Else
	SqlCa.of_Commit();
	If ls_Distribuidora <> "053404705" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora '" + ls_Distribuidora + "' associada a UF '" + ls_Uf + "' com status 'PEDIDO ELETR$$HEX1$$d400$$ENDHEX$$NICO EM HOMOLOGA$$HEX2$$c700c300$$ENDHEX$$O'.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Estoque Central associado a UF '" + ls_Uf + "' com status 'FATURAMENTO LIBERADO'.")
	End If
	
	CloseWithReturn(Parent, "OK")
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge190_inclui_distribuidora
integer x = 1637
integer y = 544
end type

