HA$PBExportHeader$w_ge363_agenda_liberacao.srw
forward
global type w_ge363_agenda_liberacao from dc_w_response_ok_cancela
end type
type pb_1 from picturebutton within w_ge363_agenda_liberacao
end type
end forward

global type w_ge363_agenda_liberacao from dc_w_response_ok_cancela
integer width = 2043
integer height = 740
string title = "GE363 - Agenda Libera$$HEX2$$e700e300$$ENDHEX$$o de Pedido para o Estoque Central"
pb_1 pb_1
end type
global w_ge363_agenda_liberacao w_ge363_agenda_liberacao

type variables
uo_filial io_Filial //ge009

String is_Tipo
String is_Tela
String is_Parametro
end variables

forward prototypes
public function boolean wf_grava_agendamento (long al_filial, long al_qt_dias_reforco)
public function boolean wf_verifica_filial_agendada (long al_filial)
end prototypes

public function boolean wf_grava_agendamento (long al_filial, long al_qt_dias_reforco);Long ll_Dia_Semena
Long ll_Achou
Long ll_Qt_Dias_Reforco_Ant

String ls_Mix
String ls_Mix_Ant
String ls_Erro
String ls_Nome_Fantasia
String ls_Descricao_Dia
String ls_Chave
String ls_Operador
String ls_Nulo
String ls_Controlado

dw_1.AcceptText()

SetNull(ls_Nulo)

ll_Dia_Semena				= dw_1.Object.Nr_Dia_Semana					[1]
ls_Mix							= dw_1.Object.Id_Mix_Completo					[1]
ls_Mix_Ant					= dw_1.Object.Id_Mix_Completo_Ant				[1]
ls_Nome_Fantasia			= dw_1.Object.Nm_Fantasia						[1]
ll_Qt_Dias_Reforco_Ant	= dw_1.Object.Qt_Dias_Reforco_Ant				[1]
ls_Controlado				= dw_1.Object.id_pedido_controlado_exclusivo	[1]

Choose Case ll_Dia_Semena
	Case 1
		ls_Descricao_Dia = "DOMINGO"
	Case 2
		ls_Descricao_Dia = "SEGUNDA"
	Case 3
		ls_Descricao_Dia = "TER$$HEX1$$c700$$ENDHEX$$A"
	Case 4
		ls_Descricao_Dia = "QUARTA"
	Case 5
		ls_Descricao_Dia = "QUINTA"
	Case 6
		ls_Descricao_Dia = "SEXTA"
	Case 7
		ls_Descricao_Dia = "S$$HEX1$$c100$$ENDHEX$$BADO"
End Choose

Choose Case is_Tipo
	Case "I"
		
		Select Count(*)
			Into :ll_Achou
		From libera_pedido_filial_estoque
		Where cd_filial = :al_Filial
			And nr_dia_semana = :ll_Dia_Semena
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o agendamento j$$HEX1$$e100$$ENDHEX$$ existe. " + SqlCa.SqlErrText, StopSign!)			
			Return False
		End If
		
		If ll_Achou > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ existe um cadastro para: " + &
										"~rFilial: " + ls_Nome_Fantasia + " (" + String(al_Filial) + ")" + &
										"~rDia da Semana: " + ls_Descricao_Dia, Exclamation!)
			Return False
		End If
		
		Insert Into libera_pedido_filial_estoque(cd_filial, nr_dia_semana, qt_dias_reforco, id_mix_completo, id_pedido_controlado_exclusivo)
			Values(:al_Filial, :ll_Dia_Semena, :al_Qt_Dias_Reforco, :ls_Mix, :ls_Controlado)
		Using SqlCa;
				
	Case "A"
		
		Update libera_pedido_filial_estoque
			Set	qt_dias_reforco 						= 	:al_Qt_Dias_Reforco,
					id_mix_completo 						= 	:ls_Mix,
					id_pedido_controlado_exclusivo	=	:ls_Controlado
			Where cd_filial = :al_Filial
				And nr_dia_semana = :ll_Dia_Semena
		Using SqlCa;
			
	Case "E"
		
		Delete From libera_pedido_filial_estoque
		Where cd_filial = :al_Filial
			And nr_dia_semana = :ll_Dia_Semena
		Using SqlCa;
		
End Choose

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro. " + ls_Erro, StopSign!)
	Return False
End If

ls_Operador = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

ls_Chave = MidA(String(al_Filial) + Space(4), 1, 4) + '@#!' + String(ll_Dia_Semena)

Choose Case is_Tipo
	Case "I"
		If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'QT_DIAS_REFORCO', ls_Nulo, String(al_Qt_Dias_Reforco), ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'ID_MIX_COMPLETO', ls_Nulo, ls_Mix, ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False
		If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'ID_PEDIDO_CONTROLADO_EXCLUSIVO', ls_Nulo, ls_Controlado, ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False
	Case "A"
		If ll_Qt_Dias_Reforco_Ant <> al_Qt_Dias_Reforco Then
			If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'QT_DIAS_REFORCO', String(ll_Qt_Dias_Reforco_Ant), String(al_Qt_Dias_Reforco), ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False
		End If
		
		If ls_Mix_Ant <> ls_Mix Then
			If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'ID_MIX_COMPLETO', ls_Mix_Ant, ls_Mix, ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False
		End If
		
		If dw_1.Object.id_pedido_controlado_exclusivo_ant[1] <> ls_Controlado Then
			If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'ID_PEDIDO_CONTROLADO_EXCLUSIVO', dw_1.Object.id_pedido_controlado_exclusivo_ant[1], ls_Controlado, ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False
		End If
		
	Case "E"
		If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'QT_DIAS_REFORCO', String(al_Qt_Dias_Reforco), ls_Nulo, ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False		
		If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'ID_MIX_COMPLETO', ls_Mix, ls_Nulo, ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False		
		If Not gf_Grava_Historico_Alteracao_Tabela('LIBERA_PEDIDO_FILIAL_ESTOQUE', ls_Chave, 'ID_PEDIDO_CONTROLADO_EXCLUSIVO', dw_1.Object.id_pedido_controlado_exclusivo_ant[1], ls_Nulo, ls_Operador, is_Tipo, Ref ls_Erro, True) Then Return False		
End Choose

SqlCa.of_Commit();

If is_Tipo = "A" Or is_Tipo = "I" Then
	If ls_Mix = "N" And (ls_Mix <> ls_Mix_Ant Or IsNull(ls_Mix_Ant)) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ser$$HEX1$$e100$$ENDHEX$$ liberado somente o atendimento de: MEDICAMENTOS GEN$$HEX1$$c900$$ENDHEX$$RICOS, MIX BEAUTY e PRODUTOS DE MARCA PR$$HEX1$$d300$$ENDHEX$$PRIA.")
	End If
End If

Return True
end function

public function boolean wf_verifica_filial_agendada (long al_filial);String ls_Parametro

Select vl_parametro
	Into :ls_Parametro
From parametro_loja
	Where cd_parametro = 'DT_INICIO_GERACAO_PEDIDO_ESTOQUE'
		And cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Parametro = "31/12/2099" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi agendada a data de gera$$HEX2$$e700e300$$ENDHEX$$o do pedido do Estoque Central para a filial.")
			Return False
		End If
		
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro 'DT_INICIO_GERACAO_PEDIDO_ESTOQUE' da filial.", Exclamation!)
		
	Case -1		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se a filial j$$HEX1$$e100$$ENDHEX$$ tem pedido agendado. " + SqlCa.SqlErrText, StopSign!)
		
End Choose

Return False
end function

on w_ge363_agenda_liberacao.create
int iCurrent
call super::create
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
end on

on w_ge363_agenda_liberacao.destroy
call super::destroy
destroy(this.pb_1)
end on

event ue_preopen;call super::ue_preopen;io_Filial = Create uo_filial
end event

event close;call super::close;Destroy(io_Filial)
end event

event ue_postopen;call super::ue_postopen;st_parametros_agend_ped str

str = Message.PowerObjectParm

is_Tipo = str.Id_Tipo
is_Tela = str.Id_Tela

If is_Tipo = "A" Or is_Tipo = "E" Then
	dw_1.Object.Cd_Filial										[1] = str.Cd_Filial
	dw_1.Object.Nm_Fantasia								[1] = str.Nm_Fantasia
	dw_1.Object.Nr_Dia_Semana							[1] = str.Nr_Dia_Semana
	dw_1.Object.Qt_Dias_Reforco							[1] = str.Qt_Dias_Reforco
	dw_1.Object.Qt_Dias_Reforco_Ant						[1] = str.Qt_Dias_Reforco
	dw_1.Object.Id_Mix_Completo							[1] = str.Id_Mix_Completo
	dw_1.Object.Id_Mix_Completo_Ant					[1] = str.Id_Mix_Completo
	dw_1.Object.id_pedido_controlado_exclusivo		[1] = str.id_pedido_controlado_exclusivo
	dw_1.Object.id_pedido_controlado_exclusivo_ant	[1] = str.id_pedido_controlado_exclusivo
				
	If is_Tipo = "A" Then
		dw_1.SetTabOrder('nm_fantasia', 0)
		dw_1.SetTabOrder('nr_dia_semana', 0)
		dw_1.Object.Acao.Text = "ALTERA$$HEX2$$c700c300$$ENDHEX$$O"
	Else
		dw_1.Object.Acao.Text = "EXCLUS$$HEX1$$c300$$ENDHEX$$O"
		dw_1.Enabled = False
	End If
	
Else
	
	//Se a tela for aberta pela CO041, ir$$HEX1$$e100$$ENDHEX$$ cair nesta condi$$HEX2$$e700e300$$ENDHEX$$o
	If Not IsNull(str.Cd_Filial) And str.Cd_Filial > 0 Then
		dw_1.Object.Cd_Filial			[1] = str.Cd_Filial
		dw_1.Object.Nm_Fantasia	[1] = str.Nm_Fantasia
		dw_1.SetTabOrder('nm_fantasia', 0)
	End If
	
	dw_1.Object.Acao.Text = "INCLUS$$HEX1$$c300$$ENDHEX$$O"	
	dw_1.Object.Qt_Dias_Reforco[1] = 0
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge363_agenda_liberacao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge363_agenda_liberacao
integer width = 1961
integer height = 508
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge363_agenda_liberacao
integer width = 1906
integer height = 420
string dataobject = "dw_ge363_selecao_response"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		
		//Verifica se vai ser atulizado no SAP
		If Not gf_filial_administrada_sap(io_Filial.Cd_Filial   , Ref is_Parametro) Then
			Return 1
		End If
				
		If is_Parametro = "S" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(io_Filial.Cd_Filial  )+" deve ser utilizado o SAP.")				
			Return 1				
		End If 
		
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		
		//Verifica se vai ser atulizado no SAP
		If Not gf_filial_administrada_sap(io_Filial.Cd_Filial   , Ref is_Parametro) Then
			Return 1
		End If
				
		If is_Parametro = "S" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(io_Filial.Cd_Filial  )+" deve ser utilizado o SAP.")				
			Return 1				
		End If 
		
		
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If Not io_Filial.Localizada Then
			io_Filial.of_Inicializa()
		End If
		
		This.Object.Cd_Filial		[1]	= io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1]	= io_Filial.Nm_Fantasia
		
		//Verifica se vai ser atulizado no SAP
		If Not gf_filial_administrada_sap(io_Filial.Cd_Filial   , Ref is_Parametro) Then
			Return 1
		End If
				
		If is_Parametro = "S" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(io_Filial.Cd_Filial  )+" deve ser utilizado o SAP.")				
			Return 1				
		End If 
		
	End If
End If



end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge363_agenda_liberacao
integer x = 1344
integer y = 528
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Filial
Long ll_Qt_Dias_Reforco

dw_1.AcceptText()

ll_Filial					= dw_1.Object.Cd_Filial				[1]
ll_Qt_Dias_Reforco	= dw_1.Object.Qt_Dias_Reforco	[1]

If is_Tipo = "A" Or is_Tipo = "I" Then
	If IsNull(ll_Filial) Or ll_Filial = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
		dw_1.Event ue_Pos(1, "nm_fantasia")
		Return -1
	End If
	
	If io_Filial.Cd_Unidade_Federacao <> "BA" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente filiais da Bahia podem ser inclu$$HEX1$$ed00$$ENDHEX$$das nesta rotina.")
		dw_1.Event ue_Pos(1, "nm_fantasia")
		Return -1
	End If
	
	//If Not wf_Verifica_Filial_Agendada(ll_Filial) Then Return -1
	
	If IsNull(ll_Qt_Dias_Reforco) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade de dias de refor$$HEX1$$e700$$ENDHEX$$o.")
		dw_1.Event ue_Pos(1, "qt_dias_reforco")
		Return -1
	End If
	
Else
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o do registro?", Question!, YesNo!, 2) = 2 Then Return -1
End If

If Not wf_Grava_Agendamento(ll_Filial, ll_Qt_Dias_Reforco) Then Return -1

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge363_agenda_liberacao
integer x = 1678
integer y = 528
end type

event cb_cancelar::clicked;String lvs_Retorno

If is_Tela = "CO041" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deve ser agendado um dia da semana para a gera$$HEX2$$e700e300$$ENDHEX$$o do pedido do Estoque Central.")
	Return -1
End If

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type pb_1 from picturebutton within w_ge363_agenda_liberacao
integer x = 905
integer y = 384
integer width = 114
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question_1.png"
alignment htextalign = left!
end type

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Recebe do Perini controlados exclusivos para atender as faltas da Bahia.~r" + "Somente se a loja n$$HEX1$$e300$$ENDHEX$$o estiver liberada para receber controlados das distribuidoras.") 
end event

