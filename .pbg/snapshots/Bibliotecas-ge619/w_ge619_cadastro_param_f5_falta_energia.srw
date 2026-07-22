HA$PBExportHeader$w_ge619_cadastro_param_f5_falta_energia.srw
forward
global type w_ge619_cadastro_param_f5_falta_energia from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge619_cadastro_param_f5_falta_energia from dc_w_cadastro_selecao_lista
string tag = "w_ge619_cadastro_param_f5_falta_energia"
integer width = 2779
integer height = 1904
string title = "GE619 - Cadastro de Par$$HEX1$$e200$$ENDHEX$$metros Liberado F5 - Falta Energia"
end type
global w_ge619_cadastro_param_f5_falta_energia w_ge619_cadastro_param_f5_falta_energia

type variables
uo_filial io_Filial

Boolean ib_Alterando = False

Boolean ib_Banco_Producao = False
end variables

forward prototypes
public function boolean wf_atualiza_parametro_central (string as_cd_parametro, long al_filial, string as_vl_parametro_novo)
end prototypes

public function boolean wf_atualiza_parametro_central (string as_cd_parametro, long al_filial, string as_vl_parametro_novo);String ls_Vl_Parametro_Ant
String ls_Erro

Select coalesce(vl_parametro, "")
	Into :ls_Vl_Parametro_Ant
From parametro_loja
Where cd_filial = :al_Filial
	And cd_parametro = :as_Cd_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Vl_Parametro_Ant <> as_Vl_Parametro_Novo Then
			
			Update parametro_loja
				Set vl_parametro = :as_Vl_Parametro_Novo
			Where cd_filial = :al_Filial
				And cd_parametro = :as_Cd_Parametro
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o parametro_loja [" + as_Cd_Parametro + "] para a filial [" + String(al_Filial) + "].~r" + ls_Erro, StopSign!)
				Return False
			End If
			
			If Not gf_Grava_Historico_Alteracao_Tabela("PARAMETRO_LOJA", MidA(String(al_Filial) + Space(4), 1, 4) + '@#!' + as_Cd_Parametro, 'VL_PARAMETRO', ls_Vl_Parametro_Ant, + &
					as_Vl_Parametro_Novo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Erro, True) Then Return False
		End If
		
	Case 100
		Insert Into parametro_loja(cd_filial, cd_parametro, vl_parametro)
			Values(:al_Filial, :as_Cd_Parametro, :as_Vl_Parametro_Novo)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir o parametro_loja [" + as_Cd_Parametro + "] para a filial [" + String(al_Filial) + "].~r" + ls_Erro, StopSign!)
			Return False
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela("PARAMETRO_LOJA", MidA(String(al_Filial) + Space(4), 1, 4) + '@#!' + as_Cd_Parametro, 'VL_PARAMETRO', ls_Vl_Parametro_Ant, + &
					as_Vl_Parametro_Novo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I", Ref ls_Erro, True) Then Return False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o parametro_loja [" + as_Cd_Parametro + "] para a filial [" + String(al_Filial) + "].~r" + ls_Erro, StopSign!)
		Return False
End Choose

Return True
end function

on w_ge619_cadastro_param_f5_falta_energia.create
call super::create
end on

on w_ge619_cadastro_param_f5_falta_energia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;If IsValid(io_Filial) Then Destroy(io_Filial)
end event

event ue_preopen;call super::ue_preopen;io_Filial = Create uo_filial
end event

event ue_postopen;//OverRide

This.ivm_Menu.mf_Excluir(False)
This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Recuperar(True)

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()

//Est$$HEX1$$e100$$ENDHEX$$ habilitado o Aux$$HEX1$$ed00$$ENDHEX$$lio Visual no INI ?
If gvo_aplicacao.ivb_usa_aux_visual Then 
	//Adiciona Linha DW
	If dw_visual.RowCount() = 0 Then dw_visual.Event ue_AddRow()
	//Seta os valores de redimensionamento da tela para compatibilidade com telas redimensionam
	MaxWidth = This.Width
	MaxHeight = This.Height
	//Chama o redimensionamento da tela, onde est$$HEX1$$e100$$ENDHEX$$ tratado onde deve aparecer a DW
	This.Event Resize(0,MaxWidth - 72, MaxHeight)
	//Seta DW visivel
	gb_aux_visual.Visible = True
	dw_visual.Visible = True
	
	Yield()
End If

dw_1.SetFocus()

If gvo_Aplicacao.ivs_DataSource = 'central' Then
	ib_Banco_Producao = True
Else
	ib_Banco_Producao = False
End If
end event

event ue_save;call super::ue_save;Boolean lb_Alteracao = False


Long ll_Linha
Long ll_Filial

String ls_Para
String ls_Erro
String ls_libera_f5

dw_1.AcceptText()
dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	ll_Filial 			= dw_2.Object.Cd_Filial									[ll_Linha]
	
	If gf_Houve_Alteracao_Dw(dw_2, 'liberado_f5', ll_Linha, Ref ls_Para) Then		
		If Not wf_Atualiza_Parametro_Central('ID_LIBERADO_F5_FALTA_ENERGIA', ll_Filial, ls_Para) Then Return -1
	End If
	
	If gf_Houve_Alteracao_Dw(dw_2, 'dt_bloqueio', ll_Linha, Ref ls_Para) Then		
		If Not wf_Atualiza_Parametro_Central('DT_LIBERADO_F5_FALTA_ENERGIA', ll_Filial, ls_Para) Then Return -1
	End If
	

	lb_Alteracao = True
Next

If lb_Alteracao Then
	SqlCa.of_Commit();
	
	dw_1.Enabled = True
	ib_Alterando = False
	
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)
	
	dw_2.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

event ue_cancel;call super::ue_cancel;dw_1.Enabled = True
ib_Alterando = False
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge619_cadastro_param_f5_falta_energia
integer x = 37
integer y = 1216
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge619_cadastro_param_f5_falta_energia
integer x = 0
integer y = 1144
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge619_cadastro_param_f5_falta_energia
integer width = 1728
integer height = 84
string dataobject = "dw_ge619_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If io_Filial.Localizada Then
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
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

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge619_cadastro_param_f5_falta_energia
integer y = 216
integer width = 2665
integer height = 1468
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge619_cadastro_param_f5_falta_energia
integer width = 1797
integer height = 192
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge619_cadastro_param_f5_falta_energia
integer y = 292
integer width = 2569
integer height = 1352
string dataobject = "dw_ge619_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Filial

dw_1.AcceptText()

ll_Filial = dw_1.Object.Cd_Filial[1]

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere_SubQuery("f.cd_filial = " + String(ll_Filial), 3)
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
	SetRedraw(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Parent.ivm_Menu.mf_Excluir(False)
Parent.ivm_Menu.mf_Incluir(False)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::getfocus;//OverRide

This.Post Event ue_SelectText()

This.of_Marca_Coluna_Ativa(This.GetColumnName())

Parent.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Incluir(False)

Return 0
end event

event dw_2::itemchanged;call super::itemchanged;If dwo.Name = "liberado_f5"  Then
	dw_1.Enabled = False
	ib_Alterando = True
End If
end event

