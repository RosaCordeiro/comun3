HA$PBExportHeader$w_ge480_agend_pedido_conveniencia.srw
forward
global type w_ge480_agend_pedido_conveniencia from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge480_agend_pedido_conveniencia
end type
type st_confirmar from statictext within w_ge480_agend_pedido_conveniencia
end type
end forward

global type w_ge480_agend_pedido_conveniencia from dc_w_selecao_lista_relatorio
integer width = 2857
integer height = 1972
string title = "GE480 - Agendamento de Pedido Conveni$$HEX1$$ea00$$ENDHEX$$ncia"
dw_4 dw_4
st_confirmar st_confirmar
end type
global w_ge480_agend_pedido_conveniencia w_ge480_agend_pedido_conveniencia

type variables
str_agendamento_pedido st

uo_ge216_filiais io_Filiais

Long il_Lojas

String is_Filiais
end variables

forward prototypes
public subroutine wf_set_somente_consulta ()
public function boolean wf_carrega_dia_pedido ()
public subroutine wf_retorna_dia_por_extenso (dc_uo_dw_base adw, ref string as_dia_pedido, ref string as_numero_dia_pedido)
end prototypes

public subroutine wf_set_somente_consulta ();dw_2.of_Set_Somente_Leitura(False)
end subroutine

public function boolean wf_carrega_dia_pedido ();Long ll_Linha
Long ll_Filial
Long ll_Linha_dw_4
Long ll_Len

String ls_Bloqueios
String ls_Dia_Extenso
String ls_Numero_Dia_Ped

Try

	dw_1.AcceptText()
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Carregando o dia de gera$$HEX2$$e700e300$$ENDHEX$$o de pedido das filiais..."
	w_aguarde.uo_progress.of_setmax(dw_2.RowCount())
	
	For ll_Linha = 1 To dw_2.RowCount()
		ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]
		
		dw_4.Event ue_Reset()
		
		//Carrega a lista de bloqueio da filial
		If dw_4.Retrieve(ll_Filial) < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a lista de bloqueio na filial " + String(ll_Filial) + ".", StopSign!)
			Return False
		End If
		
		ls_Bloqueios = ""
		ls_Dia_Extenso = ""
		ls_Numero_Dia_Ped = ""
		
		If dw_4.RowCount() > 0 Then
			dw_4.Sort()
			
			For ll_Linha_dw_4 = 1 To dw_4.RowCount()
				ls_Bloqueios += String(dw_4.Object.Nr_Dia_Semana[ll_Linha_dw_4]) + ","
			Next
			
			ll_Len = LenA(ls_Bloqueios)
			ls_Bloqueios = MidA(ls_Bloqueios, 1, ll_Len -1)
			
			dw_3.SetFilter('')
			dw_3.Filter()
			
			dw_3.SetFilter("nr_dia_semana not in (" + String(ls_Bloqueios) + ")")
			dw_3.Filter()
			
			dw_3.SetSort("nr_dia_semana")
			dw_3.Sort()
			
			wf_Retorna_Dia_Por_Extenso(dw_3, Ref ls_Dia_Extenso, Ref ls_Numero_Dia_Ped)
		End If
		
		dw_2.Object.De_Dia_Semana	[ll_Linha] = ls_Dia_Extenso
		dw_2.Object.Nr_Dia_Semana	[ll_Linha] = ls_Numero_Dia_Ped
		
		w_Aguarde.Title = "Filial: " + String(ll_Linha) + " de: " + String(dw_2.RowCount())
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
		
	Return True

Finally
	Close(w_Aguarde)
End Try
end function

public subroutine wf_retorna_dia_por_extenso (dc_uo_dw_base adw, ref string as_dia_pedido, ref string as_numero_dia_pedido);Long ll_Linha
Long ll_Dia_Semana
Long ll_Len

For ll_Linha = 1 To adw.RowCount()
	ll_Dia_Semana = adw.Object.Nr_Dia_Semana[ll_Linha]
	
	Choose Case ll_Dia_Semana
		Case 2
			as_Dia_Pedido += "SEG"
			
			If as_Dia_Pedido <> "" Then
				as_Dia_Pedido += " / "
			End If
			
		Case 3
			as_Dia_Pedido += "TER"
			
			If as_Dia_Pedido <> "" Then
				as_Dia_Pedido += " / "
			End If
			
		Case 4
			as_Dia_Pedido += "QUA"
			
			If as_Dia_Pedido <> "" Then
				as_Dia_Pedido += " / "
			End If
			
		Case 5
			as_Dia_Pedido += "QUI"
			
			If as_Dia_Pedido <> "" Then
				as_Dia_Pedido += " / "
			End If
			
		Case 6
			as_Dia_Pedido += "SEX"
			
			If as_Dia_Pedido <> "" Then
				as_Dia_Pedido += " / "
			End If
	End Choose
	
	as_Numero_Dia_Pedido += String(ll_Dia_Semana) + ","
Next

ll_Len = LenA(as_Dia_Pedido)
as_Dia_Pedido = MidA(as_Dia_Pedido, 1, ll_Len -3)

ll_Len = LenA(as_Numero_Dia_Pedido)
as_Numero_Dia_Pedido = MidA(as_Numero_Dia_Pedido, 1, ll_Len -1)
end subroutine

on w_ge480_agend_pedido_conveniencia.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.st_confirmar
end on

on w_ge480_agend_pedido_conveniencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.st_confirmar)
end on

event ue_postopen;call super::ue_postopen;wf_Set_Somente_Consulta()

dw_3.Event ue_Retrieve()

dw_1.Event ue_Pos(1, "cd_distribuidora")
end event

event ue_preopen;call super::ue_preopen;io_Filiais = Create uo_ge216_filiais
end event

event close;call super::close;Destroy(io_Filiais)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge480_agend_pedido_conveniencia
integer x = 37
integer y = 620
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge480_agend_pedido_conveniencia
integer x = 0
integer y = 548
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge480_agend_pedido_conveniencia
integer y = 316
integer width = 2738
integer height = 1436
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge480_agend_pedido_conveniencia
integer width = 1760
integer height = 276
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge480_agend_pedido_conveniencia
integer width = 1691
integer height = 160
string dataobject = "dw_ge480_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_Nulo

Choose Case dwo.Name
	Case "id_filiais"
		
		is_filiais = ls_Nulo
		
		If Data = 'C' Then
			
			OpenWithParm(w_ge216_selecao_filiais, io_Filiais)
			
			il_Lojas = Message.DoubleParm
			
			If il_Lojas > 0 Then
				is_Filiais = io_Filiais.ivs_filiais
//			Else
//				This.Object.id_filiais[1] = "N"
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			is_Filiais = io_Filiais.ivs_filiais
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge480_agend_pedido_conveniencia
integer y = 392
integer width = 2674
integer height = 1340
string dataobject = "dw_ge480_lista"
end type

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Cd_Distribuidora[1])
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	If Not wf_Carrega_Dia_Pedido() Then Return -1
	
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

If IsNull(dw_1.Object.Cd_Distribuidora[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora.", Exclamation!)
	dw_1.Event ue_Pos(1, "cd_distribuidora")
	Return -1
End If

If Not IsNull(is_Filiais) And is_Filiais <> "" Then
	This.of_AppendWhere("fd.cd_filial in(" + is_Filiais + ")")
End If

str_agendamento_pedido st_nulo

st = st_nulo

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::doubleclicked;call super::doubleclicked;String ls_Retorno
String ls_Responsavel

If row > 0 Then

	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE480_ALTERA_DATA_AGENDAMENTO", Ref ls_Responsavel) Then
		Return -1
	End If	
	
	st.Filial 				= This.Object.Nm_Fantasia		[row] + " (" + String(This.Object.Cd_Filial[row]) + ")"
	st.Cd_Filial			= This.Object.Cd_Filial			[row]
	st.Nr_Dia_Semana	= This.Object.Nr_Dia_Semana	[row]

	OpenWithParm(w_ge480_altera_dia_pedido, st)
	
	ls_Retorno = Message.StringParm
	
	If ls_Retorno = "OK" Then
		This.Event ue_Retrieve()
	End If
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge480_agend_pedido_conveniencia
boolean visible = false
integer x = 640
integer y = 804
integer width = 654
integer height = 512
string dataobject = "ddw_descricao_dia_semana"
end type

type dw_4 from dc_uo_dw_base within w_ge480_agend_pedido_conveniencia
boolean visible = false
integer x = 1984
integer y = 888
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge480_lista_bloqueio"
end type

event ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Cd_Distribuidora[1])
end event

type st_confirmar from statictext within w_ge480_agend_pedido_conveniencia
integer x = 1815
integer y = 224
integer width = 965
integer height = 68
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "Duplo clique para alterar o agendamento"
alignment alignment = center!
boolean focusrectangle = false
end type

