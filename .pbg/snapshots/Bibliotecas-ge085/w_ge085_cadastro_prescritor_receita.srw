HA$PBExportHeader$w_ge085_cadastro_prescritor_receita.srw
forward
global type w_ge085_cadastro_prescritor_receita from dc_w_cadastro_freeform
end type
end forward

global type w_ge085_cadastro_prescritor_receita from dc_w_cadastro_freeform
string accessiblename = "Cadastro de Prescritor de Receitas (GE085)"
integer x = 1454
integer y = 1060
integer width = 1710
integer height = 940
string title = "GE085 - Cadastro de Prescritor de Receitas"
long backcolor = 80269524
end type
global w_ge085_cadastro_prescritor_receita w_ge085_cadastro_prescritor_receita

type variables
uo_prescritor_receita ivo_prescritor

uo_cidade ivo_cidade

String is_Matricula_Alteracao
end variables

forward prototypes
public subroutine wf_localiza_cidade (string ps_parametro)
end prototypes

public subroutine wf_localiza_cidade (string ps_parametro);
ivo_Cidade.of_Localiza_Cidade(ps_parametro)

If ivo_Cidade.Localizada Then
	dw_1.Object.Cd_Cidade[1] = ivo_Cidade.Cd_Cidade
	dw_1.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
End If

end subroutine

on w_ge085_cadastro_prescritor_receita.create
call super::create
end on

on w_ge085_cadastro_prescritor_receita.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;If IsValid( ivo_prescritor ) Then Destroy(ivo_prescritor)
If IsValid( ivo_cidade ) Then Destroy(ivo_cidade)
end event

event ue_save;call super::ue_save;IF AncestorReturnValue = 1 THEN 
	dw_1.Reset()
	dw_1.InsertRow(0)
END IF	

RETURN AncestorReturnValue
end event

event ue_postopen;call super::ue_postopen;If This.il_Retorno = 1 Then
	ivo_prescritor = Create uo_prescritor_receita
	ivo_cidade     = Create uo_cidade
	
	This.ivm_Menu.ivb_Permite_Excluir = False
End If
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge085_cadastro_prescritor_receita
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge085_cadastro_prescritor_receita
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge085_cadastro_prescritor_receita
integer x = 32
integer y = 52
integer width = 1573
integer height = 672
string dataobject = "dw_ge085_prescritor_receita"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_1::constructor;call super::constructor;ivs_Coluna_Sem_Validacao_Salva = {"localizacao"}

This.of_SetColSelection(True)

end event

event dw_1::ue_key;String lvs_Coluna,&
       lvs_Cidade,&
  	   lvs_prescritor

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	Choose Case lvs_Coluna
			
		Case "localizacao"
			
			lvs_prescritor = This.GetText()
			
			ivo_Prescritor.of_Localiza_generica(lvs_Prescritor)
			
			If ivo_Prescritor.Localizado Then
						
				This.Event ue_Retrieve()

			End If
			
		Case "nm_cidade"
			
			lvs_Cidade = This.GetText()
			
			wf_Localiza_Cidade(lvs_Cidade)
						
	End Choose
End If
end event

event dw_1::ue_recuperar;// Override

Return This.Retrieve(ivo_Prescritor.id_registro,ivo_Prescritor.nr_registro,ivo_Prescritor.cd_unidade_federacao)
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

SetNull(lvl_Nulo)

If dwo.Name = 'nm_cidade' Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Cidade.nm_cidade Then
			Return 1
		End If
	Else
		dw_1.Object.cd_cidade[1] = lvl_Nulo
	End If
End If
end event

event dw_1::ue_preupdate;call super::ue_preupdate;String	lvs_Registro, &
		lvs_UF, &
		lvs_ID_Prescritor, &
		lvs_Nome

String lvs_Registro_Anterior, &
		lvs_UF_Anterior, &
		lvs_ID_Prescritor_Anterior
		
Long lvl_Cidade
	   
dw_1.AcceptText()

dw_1.Object.cd_filial_atualizacao[1] = gvo_Parametro.Cd_Filial

lvs_Registro = String(Long(dw_1.object.nr_registro[1]),'00000000')

dw_1.Object.nr_registro  		[1] = lvs_Registro

lvs_UF				= dw_1.Object.cd_unidade_federacao	[1]
lvs_ID_Prescritor	= dw_1.Object.id_registro					[1]
lvs_Registro			= dw_1.Object.nr_registro					[1]
lvl_Cidade			= dw_1.Object.cd_cidade					[1]
lvs_Nome			= Trim(dw_1.Object.Nm_Prescritor		[1])

If IsNull(lvs_UF) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o estado.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "cd_unidade_federacao")
	Return -1
End If

If IsNull(lvs_ID_Prescritor) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o tipo de registro.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "id_registro")
	Return -1
End If

If Long(lvs_Registro) < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o CRM/CRO/CRV.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "nr_registro")
	Return -1
End If

If lvs_ID_Prescritor = 'M' Then //CRM
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido cadastrar/ alterar conselho CRM.~rOs registros s$$HEX1$$e300$$ENDHEX$$o atualizados automaticamente na matriz.", Exclamation!)
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "nr_registro")
	Return -1
End If

lvs_UF_Anterior				= dw_1.Object.cd_unidade_federacao_anterior[1]
lvs_ID_Prescritor_Anterior	= dw_1.Object.id_registro_anterior				[1]
lvs_Registro_Anterior			= dw_1.Object.nr_registro_anterior				[1]

If IsNull( lvs_UF_Anterior ) Then lvs_UF_Anterior = ""
If IsNull( lvs_ID_Prescritor_Anterior ) Then lvs_ID_Prescritor_Anterior = ""
If IsNull( lvs_Registro_Anterior ) Then lvs_Registro_Anterior = ""

If lvs_UF_Anterior <> lvs_UF Or lvs_ID_Prescritor_Anterior <> lvs_ID_Prescritor Or lvs_Registro_Anterior <> lvs_Registro Then

	ivo_prescritor.of_Localiza( lvs_ID_Prescritor, lvs_Registro, lvs_UF )
	
	If ivo_prescritor.Localizado Then
		If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ existe um prescritor cadastrado com os dados do conselho informados.~r~rDeseja visualizar o cadastro existente?", Question!, YesNo!, 2 ) = 1 Then
			Parent.ivb_Valida_Salva = False
			This.Event ue_Retrieve( )
		Else
			MessageBox( "ATEN$$HEX2$$c700c300$$ENDHEX$$O", "CADASTRO N$$HEX1$$c300$$ENDHEX$$O REALIZADO.", StopSign! )		
		End If
		
		Return -1
	End If
End If

If IsNull(lvs_Nome) Or lvs_Nome = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o Nome do Prescritor.")
	dw_1.Event ue_Pos(1, "nm_prescritor")
	Return -1
End If

If IsNull(lvl_Cidade) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a cidade.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "nm_cidade")
	Return -1
End If

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'PC' Then
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "W_GE085_CADASTRO_PRESCRITOR_RECEITA", Ref is_Matricula_Alteracao ) Then
		Return -1
	End If
	
	dw_1.Object.Nr_Matricula_Alteracao[ 1 ] = is_Matricula_Alteracao
End If

Return AncestorReturnValue
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Cidade) Then
	dw_1.Object.cd_cidade[1] = ivo_Cidade.cd_cidade
	dw_1.Object.nm_cidade[1] = ivo_Cidade.nm_cidade
End If

end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge085_cadastro_prescritor_receita
integer x = 14
integer y = 0
integer width = 1627
integer height = 740
integer taborder = 0
end type

