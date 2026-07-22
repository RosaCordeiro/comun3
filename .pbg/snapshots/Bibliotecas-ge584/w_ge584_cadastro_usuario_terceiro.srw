HA$PBExportHeader$w_ge584_cadastro_usuario_terceiro.srw
forward
global type w_ge584_cadastro_usuario_terceiro from dc_w_cadastro_freeform
end type
end forward

global type w_ge584_cadastro_usuario_terceiro from dc_w_cadastro_freeform
string tag = "w_ge584_cadastro_usuario_terceiro"
integer width = 2153
integer height = 720
string title = "GE584 - Cadastro de Usu$$HEX1$$e100$$ENDHEX$$rio Sistema: Terceiro"
boolean ivb_grava_log = true
end type
global w_ge584_cadastro_usuario_terceiro w_ge584_cadastro_usuario_terceiro

type variables
uo_filial ivo_filial
uo_usuario ivo_usuario //ge010
Boolean ib_Retrieve = False

end variables

on w_ge584_cadastro_usuario_terceiro.create
call super::create
end on

on w_ge584_cadastro_usuario_terceiro.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Usuario)
end event

event open;call super::open;ivo_Filial  = Create uo_Filial
ivo_Usuario = Create uo_Usuario

ivo_Usuario.Somente_Terceiros = True 
ivo_Usuario.Somente_Estagiarios = False
ivo_Usuario.of_todos_usuarios( )

dw_1.of_SetMenu(This.ivm_Menu)
end event

event ue_presave;call super::ue_presave;Long ll_Cd_Filial
Long ll_Qtd

String lvs_Cpf, &
		lvs_Nome, &
		ls_Matricula	, &
		ls_matricula_padpicking, &
		ls_achou

dw_1.AcceptText()

ls_matricula_padpicking = dw_1.Object.nr_matricula_padpicking [1]
ls_Matricula	= dw_1.Object.Nr_Matricula		[1]
lvs_Cpf	= dw_1.Object.nr_cpf	[1] 

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'WS' Then 
	ll_Cd_Filial = 534  
End If 

lvs_Nome	= Trim( dw_1.Object.Nm_Usuario	[1] )

If lvs_Nome = '' Or IsNull( lvs_Nome ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o nome do usu$$HEX1$$e100$$ENDHEX$$rio." )
	dw_1.Event ue_Pos( 1, 'nm_usuario' )
	Return False
End If

If ll_Cd_Filial = 0 Or IsNull( ll_Cd_Filial ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha a filial do usu$$HEX1$$e100$$ENDHEX$$rio." )
	dw_1.Event ue_Pos( 1, 'nm_fantasia' )
	Return False
End If

If lvs_Cpf = '' Or IsNull( lvs_Cpf ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o CPF do usu$$HEX1$$e100$$ENDHEX$$rio." )
	dw_1.Event ue_Pos( 1, 'nr_cpf' )
	Return False
End If

If Not gf_Nr_Cpf_Valido( lvs_Cpf ) Then
	dw_1.Event ue_Pos( 1, 'nr_cpf' )
	Return False
End If

If Not gf_Nr_Cpf_Valido(lvs_Cpf) Then
	dw_1.Event ue_Pos(1, 'nr_cpf')
	Return False
End If

// Valida Antes de Salvar: Mesmo CPF
If dw_1.GetItemStatus(1, 0, Primary!) = NewModified! Then
	Select Count(*)
	Into :ll_Qtd
	From usuario
	Where nr_cpf = :lvs_Cpf
	Using SqlCA;

	Choose Case SqlCA.SqlCode
		Case 0
			If ll_Qtd > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ Existe Cadastro com este CPF: " + String(lvs_Cpf))
				dw_1.Event ue_Pos(1, 'nr_cpf')
				Return False
			End If
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a tabela usuario. " + SqlCA.SqlErrText)
			Return False
	End Choose
End If

//Verificar se tem matricula j$$HEX1$$e100$$ENDHEX$$ cadastrada
Select nr_matricula
	Into :ls_achou
	From usuario
	Where nr_matricula = :ls_matricula_padpicking
Using sqlca;

If ls_matricula_padpicking = ls_achou Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Um usu$$HEX1$$e100$$ENDHEX$$rio com esta matr$$HEX1$$ed00$$ENDHEX$$cula j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado.")
	dw_1.Event ue_Pos( 1, 'nr_matricula_padpicking' )
	Return False
End if

dw_1.Object.Cd_Filial_Atualizacao	[1]	= 534
dw_1.Object.Id_Situacao				[1]	= 'A'
dw_1.Object.Dh_Atualizacao_Filial	[1]	= gf_GetServerDate()
dw_1.Object.De_Senha				[1]	= ls_Matricula
dw_1.Object.Id_Isento_Biometria	[1]	= 'N'

Return True
end event

event ue_postopen;call super::ue_postopen;String lvs_Matricula 
ivm_Menu.ivb_Permite_Excluir = False


If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE584_CADASTRO_USUARIO_TERCEIRO", Ref lvs_Matricula) Then 
	Close(This)
	Return	
End If

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'WS' Then 
	dw_1.Object.cd_filial[1] = 534 
	dw_1.Object.cd_filial_atualizacao[1] = 534 	
	dw_1.Object.cd_cargo_rh[1] = '000000790'
End If 
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	dw_1.Event ue_AddRow()
End If

Return 1
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge584_cadastro_usuario_terceiro
integer y = 1072
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge584_cadastro_usuario_terceiro
integer y = 1000
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge584_cadastro_usuario_terceiro
integer x = 69
integer y = 60
integer width = 1979
integer height = 452
string dataobject = "dw_ge584_cadastro"
boolean vscrollbar = false
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna	= This.GetColumnName()

If Key = KeyEnter! Then
	Choose Case lvs_Coluna
		Case "localizacao"
			
			ivo_Usuario.of_Localiza_Usuario(This.GetText())		
						
			If ivo_Usuario.Localizado Then
				dw_1.Event ue_Retrieve()
				ivo_Filial.of_Localiza_Codigo( ivo_Usuario.cd_Filial )
				If ivo_Filial.Localizada Then
					dw_1.Object.Nm_Fantasia	[1]	 = ivo_Filial.Nm_Fantasia
				End If
			End If		
			
	End Choose
End If
end event

event dw_1::ue_addrow;call super::ue_addrow;Long ll_Sequencial

String ls_Matricula

ib_Retrieve = False
ivo_Filial.of_Inicializa()
dw_1.Event ue_Pos( 1, 'nm_usuario' )

Select max( nr_matricula )
Into :ls_Matricula
From usuario
Where substring( nr_matricula, 1, 1 ) = 'T'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Return -1		
	Case 0
		If IsNull( ls_Matricula ) Then
			ls_Matricula = 'T00000'
		End If		
End Choose

ll_Sequencial = Long( MidA( ls_Matricula, 2 ) )
ll_Sequencial++
ls_Matricula = 'T' + RightA( '0000' + String( ll_Sequencial ), 5 )
This.Object.Nr_Matricula[1] = ls_Matricula


Return AncestorReturnValue
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection( True )
This.ivs_Coluna_Sem_Validacao_Salva = {'localizacao'}
end event

event dw_1::ue_recuperar;//OverRide

Integer lvi_Linhas

lvi_Linhas = This.Retrieve( ivo_Usuario.Nr_Matricula )

If lvi_Linhas = 0 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o localizado." )
Else
	ib_Retrieve = True
End If

Return lvi_Linhas
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge584_cadastro_usuario_terceiro
integer width = 2053
integer height = 508
integer taborder = 20
end type

