HA$PBExportHeader$w_ge434_libera_novo_calculo_eb.srw
forward
global type w_ge434_libera_novo_calculo_eb from dc_w_cadastro_freeform
end type
type cb_1 from commandbutton within w_ge434_libera_novo_calculo_eb
end type
end forward

global type w_ge434_libera_novo_calculo_eb from dc_w_cadastro_freeform
string tag = "w_ge434_libera_novo_calculo_eb"
integer width = 1691
integer height = 720
string title = "GE434 - Libera Novo Calculo EB"
cb_1 cb_1
end type
global w_ge434_libera_novo_calculo_eb w_ge434_libera_novo_calculo_eb

type variables
uo_filial io_filial
end variables

forward prototypes
public function boolean wf_localiza_parametro ()
public function boolean wf_salva ()
public function boolean wf_perfil_estoque (long pl_filial, ref long pl_perfil)
end prototypes

public function boolean wf_localiza_parametro ();String ls_Parametro, ls_Data

Select coalesce(vl_parametro, 'N')
Into :ls_Parametro
From parametro_loja
Where cd_filial = :io_filial.cd_filial
	and cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Parametro <> 'S' and ls_Parametro <> 'N' Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O par$$HEX1$$e200$$ENDHEX$$metro encontrado esta diferente do esperado.")
			Return False
		End If
	Case 100
		ls_Parametro = 'N'
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'.")
		Return False
End Choose


Select coalesce(vl_parametro, '01/01/1900')
Into :ls_Data
From parametro_loja
Where cd_filial = :io_filial.cd_filial
	and cd_parametro = 'DH_INICIO_NOVO_CALCULO_EB'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsDate(ls_Data) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data do par$$HEX1$$e200$$ENDHEX$$metro $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.")
			Return False
		End If
	Case 100
		
		// Desfazer qualquer altera$$HEX2$$e700e300$$ENDHEX$$o que tenha sido realizada e n$$HEX1$$e300$$ENDHEX$$o foi salva
		SqlCa.of_RollBack();
		
		 INSERT INTO parametro_loja  ( cd_filial,   cd_parametro,   vl_parametro )  
		 VALUES ( :io_filial.cd_filial,   'DH_INICIO_NOVO_CALCULO_EB',   '01/01/1900' )
		 Using SqlCa;
		 
		 If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'DH_INICIO_NOVO_CALCULO_EB'.")
			Return False
		End If			
		
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'DH_INICIO_NOVO_CALCULO_EB'.")
		Return False
End Choose

dw_1.AcceptText()

dw_1.Object.id_libera				[1] = ls_Parametro
dw_1.Object.id_libera_anterior	[1] = ls_Parametro
dw_1.Object.dh_inicio_calculo	[1] = Date(ls_Data)
end function

public function boolean wf_salva ();Date lvdt_Recalculo, lvdt_Movimentacao, lvdt_Data_Limite

Long ll_Filial, ll_Perfil

String ls_Responsavel, ls_Libera, ls_Achou, ls_MSG, ls_Chave, ls_MSG_Email, ls_Nome_Resp, ls_Anexo[]

dw_1.AcceptText()

ll_Filial					= dw_1.Object.cd_filial		[1]
lvdt_Recalculo 	  		= dw_1.Object.dh_recalculo[1]
ls_Libera					= dw_1.Object.id_libera		[1]

lvdt_Movimentacao 	= Date(gvo_Parametro.of_DH_Movimentacao())

ls_Responsavel = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

// Se houve altera$$HEX2$$e700e300$$ENDHEX$$o
If dw_1.Object.id_libera_anterior	[1] = dw_1.Object.id_libera[1] Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'N$$HEX1$$e300$$ENDHEX$$o houveram altera$$HEX2$$e700f500$$ENDHEX$$es.')
	Return True
End If

Select nm_usuario 
Into :ls_Nome_Resp
From usuario
Where nr_matricula = :ls_Responsavel
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio.")
	Return False
End If	

ls_Chave = String(ll_Filial, '0000') + '@#!ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'

If Isnull(lvdt_Recalculo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo corretamente.")
	dw_1.Event ue_Pos(1, "dh_recalculo")
	Return False
End If

lvdt_Data_Limite = RelativeDate(lvdt_Movimentacao, 30)
If lvdt_Recalculo > lvdt_Data_Limite Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do rec$$HEX1$$e100$$ENDHEX$$lculo n$$HEX1$$e300$$ENDHEX$$o pode maior que '" + String(lvdt_Data_Limite, "dd/mm/yyyy") +  "'.")
	dw_1.Event ue_Pos(1, "dh_recalculo")
	Return False
End If	
		
If lvdt_Recalculo <= lvdt_Movimentacao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do rec$$HEX1$$e100$$ENDHEX$$lculo deve ser maior que a data atual '" + String(lvdt_Movimentacao, "dd/mm/yyyy") + "'.")
	dw_1.Event ue_Pos(1, "dh_recalculo")
	Return False
End If

If Day(lvdt_Recalculo) = 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o pode ser programado rec$$HEX1$$e100$$ENDHEX$$lculo para o primeiro dia do m$$HEX1$$ea00$$ENDHEX$$s.")
	dw_1.Event ue_Pos(1, "dh_recalculo")
	Return False
End If

If Not lf_ge425_limite_agendamentos(1, lvdt_Recalculo) Then Return False

Select coalesce(vl_parametro, 'N')
Into :ls_Achou
From parametro_loja
Where cd_filial = :ll_Filial
	and cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update parametro_loja
		Set vl_parametro = :ls_Libera
		Where cd_filial = :ll_Filial
			and cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'.")
			Return False
		End If	
		
		If Not gf_Grava_Historico_Alteracao_Tabela('PARAMETRO_LOJA', ls_Chave, 'VL_PARAMETRO', ls_Achou,&
														ls_Libera, ls_Responsavel, 'A', ref ls_MSG, True) Then
			SqlCa.of_RollBack();
			Return False
		End If
		
	Case 100
		
		 INSERT INTO parametro_loja  ( cd_filial,   cd_parametro,   vl_parametro )  
		 VALUES ( :ll_Filial,   'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE',   :ls_Libera )
		 Using SqlCa;
		 
		 If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'.")
			Return False
		End If	
		
		If Not gf_Grava_Historico_Alteracao_Tabela('PARAMETRO_LOJA', ls_Chave, 'VL_PARAMETRO', ls_Achou,&
														ls_Libera, ls_Responsavel, 'A', ls_MSG, True) Then
			SqlCa.of_RollBack();
			Return False
		End If
		
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'.")
		Return False
End Choose

ls_Achou = ""

Select coalesce(vl_parametro, 'N')
Into :ls_Achou
From parametro_loja
Where cd_filial = :ll_Filial
	and cd_parametro = 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update parametro_loja
			Set vl_parametro = 'S'
		Where cd_filial = :ll_Filial
			And cd_parametro = 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'.")
			Return False
		End If
		
	Case 100
		
		 INSERT INTO parametro_loja  ( cd_filial, cd_parametro, vl_parametro )  
		 VALUES ( :ll_Filial, 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL', 'S')
		 Using SqlCa;
		 
		 If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'.")
			Return False
		End If
		
	Case -1
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'.")
		Return False
End Choose

// INICIO MEDIANA
Select coalesce(vl_parametro, 'N')
Into :ls_Achou
From parametro_loja
Where cd_filial = :ll_Filial
	and cd_parametro = 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update parametro_loja
			Set vl_parametro = 'S'
		Where cd_filial = :ll_Filial
			And cd_parametro = 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'.")
			Return False
		End If
		
	Case 100
		
		 INSERT INTO parametro_loja  ( cd_filial, cd_parametro, vl_parametro )  
		 VALUES ( :ll_Filial, 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE', 'S')
		 Using SqlCa;
		 
		 If SqlCa.Sqlcode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'.")
			Return False
		End If
		
	Case -1
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'.")
		Return False
End Choose
// TERMINO MEDIANA

ls_MSG_Email = "Filial: " + String(ll_Filial)  +  " - Altera$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE' de: '" + ls_Achou + "' para: '" + ls_Libera+ "'. <br>Respons$$HEX1$$e100$$ENDHEX$$vel: " + ls_Nome_Resp

gf_ge202_envia_email_automatico(89, 'Novo C$$HEX1$$e100$$ENDHEX$$lculo do EB', ls_MSG_Email, ls_Anexo[])
				
Update parametro_reposicao_estoque 
Set 	dh_inicio_periodo_1  				= dateadd(day, -84, :lvdt_Recalculo), 
		dh_termino_periodo_1 			= dateadd(day, -71, :lvdt_Recalculo),   
		dh_inicio_periodo_2  				= dateadd(day, -70, :lvdt_Recalculo),   
		dh_termino_periodo_2 			= dateadd(day, -57, :lvdt_Recalculo),   
		dh_inicio_periodo_3  				= dateadd(day, -56, :lvdt_Recalculo),   
		dh_termino_periodo_3 			= dateadd(day, -43, :lvdt_Recalculo),   
		dh_inicio_periodo_4  				= dateadd(day, -42, :lvdt_Recalculo),   
		dh_termino_periodo_4 			= dateadd(day, -29, :lvdt_Recalculo),   
		dh_inicio_periodo_5  				= dateadd(day, -28, :lvdt_Recalculo),   
		dh_termino_periodo_5 			= dateadd(day, -15, :lvdt_Recalculo),   
		dh_inicio_periodo_6  				= dateadd(day, -14, :lvdt_Recalculo),   
		dh_termino_periodo_6 			= dateadd(day,  -1, :lvdt_Recalculo),   
		id_periodos_atualizados 			= 'S',   
		dh_proximo_calculo      			= :lvdt_Recalculo,
		nr_matricula_proximo_recalculo 	= :ls_Responsavel
From parametro_reposicao_estoque p
Where p.id_tipo_reposicao = 'E' 
  and p.cd_filial = :ll_Filial
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo")
	Return False
End If
		  
Update parametro_reposicao_estoque 
Set dh_inicio_periodo_1  			= dateadd(day, -365, :lvdt_Recalculo), 
	dh_termino_periodo_1 			= dateadd(day, -352, :lvdt_Recalculo),   
	dh_inicio_periodo_2  				= dateadd(day, -351, :lvdt_Recalculo),   
	dh_termino_periodo_2 			= dateadd(day, -338, :lvdt_Recalculo),   
	dh_inicio_periodo_3  				= dateadd(day,  -56, :lvdt_Recalculo),   
	dh_termino_periodo_3 			= dateadd(day,  -43, :lvdt_Recalculo),   
	dh_inicio_periodo_4  				= dateadd(day,  -42, :lvdt_Recalculo),   
	dh_termino_periodo_4 			= dateadd(day,  -29, :lvdt_Recalculo),   
	dh_inicio_periodo_5  				= dateadd(day,  -28, :lvdt_Recalculo),   
	dh_termino_periodo_5 			= dateadd(day,  -15, :lvdt_Recalculo),   
	dh_inicio_periodo_6  				= dateadd(day,  -14, :lvdt_Recalculo),   
	dh_termino_periodo_6 			= dateadd(day,   -1, :lvdt_Recalculo),   
	id_periodos_atualizados 			= 'S',   
	dh_proximo_calculo      			= :lvdt_Recalculo,
	nr_matricula_proximo_recalculo 	= :ls_Responsavel
From parametro_reposicao_estoque p
Where p.id_tipo_reposicao = 'S' and
	  p.cd_filial =:ll_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack();
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo.")
	Return False
End If
	
If dw_1.Object.id_libera_anterior	[1] = 'N' and dw_1.Object.id_libera[1] = 'S' Then
	If Not lf_ge413_insere_limite_alteracao_eb(ll_Filial) Then Return False
	If Not wf_perfil_estoque(ll_Filial, Ref ll_Perfil) Then Return False
Else
	ll_Perfil = 6
End If
	
Update filial
Set cd_perfil_estoque = :ll_Perfil
Where cd_filial = :ll_Filial
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_RollBack();
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do perfil de estoque da filial.")
End If

SqlCa.of_Commit();

Return True
end function

public function boolean wf_perfil_estoque (long pl_filial, ref long pl_perfil);String ls_Uf
String ls_Erro
String ls_Perfil
String ls_Parametro

Select cd_uf
	Into :ls_Uf
From vw_filial
Where cd_filial = :pl_filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a UF da filial na vw_filial.")
		Return False
		
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a UF da filial. " + ls_Erro, StopSign!)
		Return False
End Choose

ls_Parametro = 'CD_PERFIL_ESTOQUE_UF_' + ls_Uf

Select vl_parametro
	Into :ls_Perfil
From parametro_geral
	Where cd_parametro = :ls_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		pl_perfil = Long(ls_Perfil)
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro da UF '" + ls_Uf+ "'.")
		Return False
		
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro '" + ls_Parametro + "'. " + ls_Erro)
		Return False
End Choose

Return True
end function

on w_ge434_libera_novo_calculo_eb.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge434_libera_novo_calculo_eb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;//OverRide

ivo_dbError = Create dc_uo_dbError

//Registra Tela para Controle de Inatividade
If (Not(ivb_permite_fechar)) and (IsValid(gvo_Aplicacao)) Then
	If gvo_Aplicacao.ivb_Usa_Timer_Out Then
		gvo_Aplicacao.of_insere_tela(This.Title)
	End If
End If

// Insere a tela response do array de responses abertas
// Necess$$HEX1$$e100$$ENDHEX$$rio a armazenagem para fechar as telas por inatividade
If IsValid(gvo_Aplicacao) Then
	If gvo_Aplicacao.ivb_usa_timer_out Then
		If This.WindowType = Response! Then
			gvo_Aplicacao.of_insere_response(This)
		End if
	End If
End If

//Verifica se no grupo de acesso a tela est$$HEX1$$e100$$ENDHEX$$ sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o
// e seta como somente leitura os campos
wf_set_somente_consulta()

Integer lvl_PxWidth
Integer lvl_PxHeight
Integer lvl_UnWidth
Integer lvl_UnHeight

If (MaxWidth > 0)or(MaxHeight>0) Then
	gvo_aplicacao.of_retorna_resolucao_monitor(lvl_PxWidth,lvl_PxHeight)
	
	lvl_UnWidth	= PixelsToUnits(lvl_PxWidth,XPixelsToUnits!)
	lvl_UnHeight	= PixelsToUnits(lvl_PxHeight,YPixelsToUnits!)
	
	If (lvl_PxWidth <> 800)and(MaxWidth > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnWidth >= MaxWidth Then //Maior que tamanho ideal
			This.Width = MaxWidth
		Else 
			This.Width = lvl_UnWidth - 50
		End If
	End If
	
	If (lvl_PxHeight <> 600)and(MaxHeight > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnHeight >= MaxHeight Then //Maior que tamanho ideal
			This.Height = MaxHeight
		Else 
			This.Height = lvl_UnHeight - 650
		End If
	End If
End If

dw_1.Event ue_AddRow()
dw_1.SetFocus()

//dc_uo_dw_Base lvo_Update[]
//lvo_Update = {dw_1}
//This.wf_SetUpdate_DW(lvo_Update)

//This.ivm_Menu.mf_Incluir(True)
//This.ivm_Menu.mf_Recuperar(True)


This.ivm_Menu.mf_Recuperar(True)

io_Filial  = Create uo_Filial
end event

event close;call super::close;Destroy(io_Filial)
end event

event ue_save;//OverRide

If wf_salva() Then
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)	
	
	dw_1.Reset()
	
	dw_1.Event ue_AddRow()
	dw_1.SetFocus()
End If

Return 1

end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge434_libera_novo_calculo_eb
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge434_libera_novo_calculo_eb
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge434_libera_novo_calculo_eb
integer x = 69
integer y = 80
integer width = 1509
integer height = 380
string dataobject = "dw_ge434_cadastro"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If  This.GetColumnName() = 'de_localizacao' Then
		io_Filial.of_Localiza_Filial(This.GetText())
			
		If io_Filial.Localizada Then
			This.Object.Cd_Filial		[1]		= io_Filial.Cd_Filial
			This.Object.nm_fantasia	[1] 	= io_Filial.Nm_Fantasia
			
			wf_localiza_parametro()
		
			dw_1.Object.de_localizacao[1] = ''
			dw_1.Event ue_Pos(1, "id_libera")
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;This.AcceptText()

If  dwo.Name = 'id_libera' Then
	If Data = 'N' and This.Object.id_libera_anterior[1] = 'S' Then
		If dw_1.Object.dh_inicio_calculo[1]  <> Date("01/01/1900") Then
			If dw_1.Object.dh_inicio_calculo	[1] <= Date(gvo_Parametro.of_DH_Movimentacao()) Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser retirada do novo c$$HEX1$$e100$$ENDHEX$$lculo.~r~r$$HEX1$$da00$$ENDHEX$$ltimo c$$HEX1$$e100$$ENDHEX$$lculo (novo c$$HEX1$$e100$$ENDHEX$$lculo): " + string(dw_1.Object.dh_inicio_calculo	[1], "dd/mm/yyyy"))
				dw_1.Reset()
				dw_1.Event ue_AddRow()
				//dw_1.Event ue_Pos(1, 'de_localizacao')
				//Return 1	
			End If
		End If
	End If
End If
				
	

end event

event dw_1::constructor;call super::constructor;ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}

This.of_SetColSelection(True)
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge434_libera_novo_calculo_eb
integer width = 1563
integer height = 480
end type

type cb_1 from commandbutton within w_ge434_libera_novo_calculo_eb
boolean visible = false
integer x = 1047
integer y = 368
integer width = 457
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Libera Lojas"
end type

event clicked;String ls_Resp

// Declara$$HEX2$$e700e300$$ENDHEX$$o vari$$HEX1$$e100$$ENDHEX$$veis de destino
Long ll_Filial, ll_Perfil, ll_Total_Lojas

String ls_Chave, ls_MSG

//If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CO202_LIBERACAO_PROCEDIMENTO", ref ls_Resp) Then 
//	Return
//End If
//
//If ls_Resp <> '14231' Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o autorizado")
//	Return
//End If

If gvo_Aplicacao.ivs_DataSource = 'central' Then Return

Open(w_Aguarde)

DECLARE lcu_filial CURSOR FOR
select cd_filial from parametro_loja
where cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
  and vl_parametro = 'N' 
  and cd_filial in (select cd_filial from filial where id_pedido_centralizado = 'S' and id_situacao = 'A')
 // and cd_filial = 26
  ;


// Abrindo o cursor
OPEN lcu_filial;

// Buscar a primeira linha do resultado
FETCH lcu_filial INTO :ll_Filial;

// Repetir Enquanto Houver Linhas
DO WHILE SQLCA.sqlcode = 0
	
	ls_Chave = String(ll_Filial, '0000') + '@#!ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
	
	Update parametro_loja
	Set vl_parametro = 'S'
	Where cd_filial = :ll_Filial
		and cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVO_CALCULO_ESTOQUE_BASE'.")
		Return
	End If	
	
	If Not gf_Grava_Historico_Alteracao_Tabela('PARAMETRO_LOJA', ls_Chave, 'VL_PARAMETRO', 'N',&
													'S', '14231', 'A', ls_MSG, True) Then
		SqlCa.of_RollBack();
		Return
	End If
	
	Update parametro_loja
		Set vl_parametro = 'S'
	Where cd_filial = :ll_Filial
		And cd_parametro = 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_NOVO_CALCULO_EB_CALCULO_QUINZENAL'.")
		Return
	End If
	
	Update parametro_loja
		Set vl_parametro = 'S'
	Where cd_filial = :ll_Filial
		And cd_parametro = 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_MEDIANA_CALCULO_ESTOQUE_BASE'.")
		Return
	End If

	If Not lf_ge413_insere_limite_alteracao_eb(ll_Filial) Then Return
	
	If Not wf_perfil_estoque(ll_Filial, Ref ll_Perfil) Then 
		SqlCa.of_RollBack();
		Return
	End If
	
	Update filial
	Set cd_perfil_estoque = :ll_Perfil
	Where cd_filial = :ll_Filial
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		SqlCa.of_RollBack();
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do perfil de estoque da filial.")
	End If
	
	FETCH lcu_filial INTO :ll_Filial;
LOOP

// No fim fechar o cursor
CLOSE lcu_filial;

SqlCa.of_Commit();

Close(w_Aguarde)

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Terminou.")
end event

