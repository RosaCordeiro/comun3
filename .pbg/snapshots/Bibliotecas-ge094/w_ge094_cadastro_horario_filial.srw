HA$PBExportHeader$w_ge094_cadastro_horario_filial.srw
forward
global type w_ge094_cadastro_horario_filial from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge094_cadastro_horario_filial from dc_w_cadastro_selecao_lista
integer width = 1577
integer height = 1304
string title = "GE094 - Cadastro de Hor$$HEX1$$e100$$ENDHEX$$rio de Funcionamento de Filial"
boolean resizable = false
end type
global w_ge094_cadastro_horario_filial w_ge094_cadastro_horario_filial

type variables
uo_Filial ivo_Filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_Filial

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio
lvs_Filial = dw_1.GetText()
ivo_Filial.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial  [1] = ivo_Filial.Cd_Filial
  	dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
Else

	SetNull(ivo_Filial.Cd_Filial)
	ivo_Filial.Nm_Fantasia = ""
	
	dw_1.Object.Cd_Filial  [1] = ivo_Filial.Cd_Filial
  	dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
End If
end subroutine

on w_ge094_cadastro_horario_filial.create
call super::create
end on

on w_ge094_cadastro_horario_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Filial = Create uo_Filial
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_save;//OverRide
Long lvl_Filial, &
	  lvl_Total , &
	  lvl_Linha , &
	  lvl_Find
	  
String lvs_String, &
		 lvs_Cd_Parametro
		 
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Filial = dw_1.Object.Cd_Filial[1]
lvl_Total  = dw_2.RowCount()

Delete From parametro_loja
 Where cd_parametro like 'DE_HORARIO_%'
   And cd_filial = :lvl_Filial
 Using SqlCa;
 
 If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError('EXCLUS$$HEX1$$c300$$ENDHEX$$O DOS HOR$$HEX1$$c100$$ENDHEX$$RIOS')
	SqlCa.of_RollBack()
	Return -1
 End If
 
lvl_Find = dw_2.Find( "dia = '10'", 1, lvl_Total )
If lvl_Find = 0 Then
	 For lvl_Linha = 1 To lvl_Total
		lvs_String = String(dw_2.Object.Dia	  [lvl_Linha]) + &
						 dw_2.Object.Hr_Abertura  [lvl_Linha]  + &
						 dw_2.Object.Mn_Abertura  [lvl_Linha]  + &
						 dw_2.Object.Hr_Fechamento[lvl_Linha]  + &
						 dw_2.Object.Mn_Fechamento[lvl_Linha]
						 
		lvs_Cd_Parametro = 'DE_HORARIO_' + String(lvl_Linha)
		Insert into parametro_loja(
					cd_filial,
					cd_parametro,
					vl_parametro)
		  Values(:lvl_Filial,
					:lvs_Cd_Parametro,
					:lvs_String)
			Using SqlCa;
			
		If Sqlca.SqlCode = -1 Then
			SqlCa.of_MsgDbError('INCLUS$$HEX1$$c300$$ENDHEX$$O DOS HOR$$HEX1$$c100$$ENDHEX$$RIOS')
			SqlCa.of_RollBack()
			Return -1
		End If
		
	 Next
	 
	Update filial
	  Set id_24horas = 'N'
	Where cd_filial = :lvl_Filial
	Using SqlCa;
			
	If Sqlca.SqlCode = -1 Then
		SqlCa.of_MsgDbError('ATUALIZA$$HEX2$$c700c300$$ENDHEX$$O DA TABELA FILIAL')
		SqlCa.of_RollBack()
		Return -1
	End If
	
Else
	Insert into parametro_loja(
					cd_filial,
					cd_parametro,
					vl_parametro)
		  Values(:lvl_Filial,
					'DE_HORARIO_1',
					'1000000000')
			Using SqlCa;
			
	If Sqlca.SqlCode = -1 Then
		SqlCa.of_MsgDbError('INCLUS$$HEX1$$c300$$ENDHEX$$O DOS HOR$$HEX1$$c100$$ENDHEX$$RIOS')
		SqlCa.of_RollBack()
		Return -1
	End If
		
	Update filial
	  Set id_24horas = 'S'
	Where cd_filial = :lvl_Filial
	Using SqlCa;
			
	If Sqlca.SqlCode = -1 Then
		SqlCa.of_MsgDbError('ATUALIZA$$HEX2$$c700c300$$ENDHEX$$O DA TABELA FILIAL')
		SqlCa.of_RollBack()
		Return -1
	End If
	
End If
 
SqlCa.of_Commit()

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)	

dw_2.Event ue_Recuperar()
Return 1
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge094_cadastro_horario_filial
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge094_cadastro_horario_filial
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge094_cadastro_horario_filial
integer x = 27
integer y = 68
integer width = 1499
integer height = 80
string dataobject = "dw_ge094_selecao"
end type

event dw_1::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'nm_fantasia' Then
		wf_Localiza_Filial()
	End If
	
End If
end event

event dw_1::editchanged;call super::editchanged;Long lvl_nulo

String lvs_nulo

SetNull(lvs_Nulo)
SetNull(lvl_Nulo)


Choose Case dwo.Name 
	Case "nm_fantasia"
	
		dw_2.Event ue_Reset()
		
		SetNull(lvl_Nulo)
		This.Object.Cd_Filial[1] = lvl_nulo
		Return 0
		
		If Data <> ivo_Filial.Nm_Fantasia Then Return 1
		
End Choose
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_fantasia" Then
	If Data <> ivo_Filial.Nm_Fantasia Then
		Return 1
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_fantasia[1] = ivo_Filial.Nm_Fantasia
	This.Object.Cd_Filial  [1] = ivo_Filial.Cd_Filial
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge094_cadastro_horario_filial
integer x = 9
integer y = 172
integer width = 1527
integer height = 944
integer weight = 700
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge094_cadastro_horario_filial
integer x = 5
integer width = 1536
integer height = 160
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge094_cadastro_horario_filial
integer x = 37
integer y = 224
integer width = 1486
integer height = 884
string dataobject = "dw_ge094_lista"
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;If IsNull(dw_1.Object.Cd_Filial[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a Filial.")
	dw_1.Event ue_Pos(1,"nm_fantasia")
	Return -1
End If

dw_2.of_AppendWhere("cd_filial = " + String(dw_1.Object.Cd_Filial[1]))
Return AncestorReturnValue
end event

event dw_2::itemchanged;call super::itemchanged;Choose Case dwo.Name 
	Case "dia"
		If Data = "10" Then //24 Horas
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Se a op$$HEX2$$e700e300$$ENDHEX$$o selecionada for 24 Horas, as demais ser$$HEX1$$e300$$ENDHEX$$o exclu$$HEX1$$ed00$$ENDHEX$$das.")
		End If
		
End Choose
end event

