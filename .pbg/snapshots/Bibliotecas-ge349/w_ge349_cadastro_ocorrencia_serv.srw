HA$PBExportHeader$w_ge349_cadastro_ocorrencia_serv.srw
forward
global type w_ge349_cadastro_ocorrencia_serv from dc_w_cadastro_freeform
end type
type dw_2 from dc_uo_dw_base within w_ge349_cadastro_ocorrencia_serv
end type
type gb_2 from groupbox within w_ge349_cadastro_ocorrencia_serv
end type
end forward

global type w_ge349_cadastro_ocorrencia_serv from dc_w_cadastro_freeform
string accessiblename = "Cadastro de Ocorr$$HEX1$$ea00$$ENDHEX$$ncia de Servi$$HEX1$$e700$$ENDHEX$$os (GE349)"
integer width = 2971
integer height = 1880
string title = "GE349 - Cadastro de Ocorr$$HEX1$$ea00$$ENDHEX$$ncia de Servi$$HEX1$$e700$$ENDHEX$$os"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge349_cadastro_ocorrencia_serv w_ge349_cadastro_ocorrencia_serv

type variables
uo_ge349_servico ivo_Servico
uo_ge349_tipo_servico ivo_Tipo
end variables

on w_ge349_cadastro_ocorrencia_serv.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge349_cadastro_ocorrencia_serv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_preopen;call super::ue_preopen;ivo_Servico	= Create uo_GE349_Servico
ivo_Tipo		= Create uo_GE349_Tipo_Servico
end event

event close;call super::close;Destroy(ivo_Servico)
Destroy(ivo_Tipo)
end event

event ue_update;call super::ue_update;//override

dw_1.Accepttext( )
Return (dw_1.Event ue_Update() > -1)

end event

event ue_save;//override
dw_1.Accepttext( )
If This.Event ue_Update() Then Return -1

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)	

end event

event ue_postopen;call super::ue_postopen;dw_2.event ue_AddRow()
dw_2.Retrieve()

dw_1.of_SetMenu(This.ivm_Menu)
dw_2.of_SetMenu(This.ivm_Menu)

dw_1.ivo_Controle_Menu.of_Recuperar(False)
dw_1.ivo_Controle_Menu.of_Incluir(True)
dw_1.ivo_Controle_Menu.of_Excluir(False)

dw_2.ivo_Controle_Menu.of_incluir(False)
dw_2.ivo_Controle_Menu.of_excluir(True)

dw_1.Event GetFocus()

end event

event ue_cancel;call super::ue_cancel;dw_2.Event ue_Cancel()

dw_1.event GetFocus()
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge349_cadastro_ocorrencia_serv
integer y = 1576
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge349_cadastro_ocorrencia_serv
integer y = 1504
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge349_cadastro_ocorrencia_serv
integer width = 1947
integer height = 564
string dataobject = "dw_ge349_cadastro"
boolean vscrollbar = false
end type

event dw_1::ue_key;call super::ue_key;String lvs_Texto

Long lvl_Servico
dw_1.Accepttext( )
If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'nm_servico'
			ivo_Servico.of_localiza(This.GetText())
			
			This.Object.cd_servico	[1] = ivo_Servico.cd_servico
			This.Object.nm_servico	[1] = ivo_Servico.nm_servico
		Case 'de_tipo'
			ivo_Tipo.of_localiza(This.GetText())
			
			This.Object.cd_tipo	[1] = ivo_Tipo.cd_tipo
			This.Object.de_tipo	[1] = ivo_Tipo.de_tipo

	End Choose
End If
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;String lvs_Tipo_Oco

dw_1.Accepttext( )
lvs_Tipo_Oco = dw_1.Object.id_tipo [1]

If lvs_Tipo_Oco = 'S' Then
	// Verifica se o cliente foi localizado e atualiza a DW
	If IsValid(ivo_Servico) Then
		If (ivo_Servico.Localizado)and(dw_1.Object.nm_servico[row] <> '') Then
			If dw_1.Object.cd_servico[row] = ivo_Servico.cd_servico Then
				dw_1.Object.nm_servico[row] = ivo_Servico.nm_servico
			End If
		Else
			ivo_Servico.Of_inicializa()
			dw_1.Object.cd_servico	[row] = ivo_Servico.cd_servico
			dw_1.Object.nm_servico	[row] = ''
		End If
	End If
	ivo_Tipo.Of_inicializa()
	dw_1.Object.cd_tipo	[row] = ivo_Tipo.cd_tipo
	dw_1.Object.de_tipo	[row] = ''
Else
	// Verifica se o cliente foi localizado e atualiza a DW
	If IsValid(ivo_Tipo) Then
		If (ivo_Tipo.Localizado)and(dw_1.Object.de_tipo[row] <> '') Then
			If dw_1.Object.cd_tipo[row] = ivo_Tipo.cd_tipo Then
				dw_1.Object.de_tipo[row] = ivo_Tipo.de_tipo
			End If
		Else
			ivo_Tipo.Of_inicializa()
			dw_1.Object.cd_tipo	[row] = ivo_Tipo.cd_tipo
			dw_1.Object.de_tipo	[row] = ''
		End If
	End If
	ivo_Servico.Of_inicializa()
	dw_1.Object.cd_servico	[row] = ivo_Servico.cd_servico
	dw_1.Object.nm_servico	[row] = ''
End If
end event

event dw_1::losefocus;call super::losefocus;String lvs_Tipo_Oco

dw_1.Accepttext( )
lvs_Tipo_Oco = dw_1.Object.id_tipo [1]

If lvs_Tipo_Oco = 'S' Then
	// Verifica se o cliente foi localizado e atualiza a DW
	If IsValid(ivo_Servico) Then
		If ivo_Servico.Localizado Then
			dw_1.Object.cd_servico	[1] = ivo_Servico.cd_servico
			dw_1.Object.nm_servico	[1] = ivo_Servico.nm_servico
		Else 
			ivo_Servico.Of_Inicializa()
			dw_1.Object.cd_servico	[1] = ivo_Servico.cd_servico
			dw_1.Object.nm_servico	[1] = ''
		End If
	End If
Else
	// Verifica se o cliente foi localizado e atualiza a DW
	If IsValid(ivo_Tipo) Then
		If ivo_Tipo.Localizado Then
			dw_1.Object.cd_tipo	[1] = ivo_Tipo.cd_tipo
			dw_1.Object.de_tipo	[1] = ivo_Tipo.de_tipo
		Else 
			ivo_Servico.Of_Inicializa()
			dw_1.Object.cd_tipo	[1] = ivo_Tipo.cd_tipo
			dw_1.Object.de_tipo	[1] = ''
		End If
	End If
End If
end event

event dw_1::ue_update;//override
String lvs_Observacao
String lvs_Status
String lvs_Tipo

Long lvl_Servico
Long lvl_Tipo
Long lvl_Linha

Datetime lvdh_Previsao

Boolean lvb_OK = True

If This.Event ue_PreUpdate() = -1 Then Return -1

dc_uo_ds_base lvds_Servico
lvds_Servico = Create dc_uo_ds_base
lvds_Servico.of_changedataobject('dw_ge349_lista_servico')

dw_1.Accepttext( )

lvl_Servico 		= dw_1.Object.cd_servico		[1]
lvl_Tipo	 		= dw_1.Object.cd_tipo			[1]
lvs_Tipo			= dw_1.Object.id_tipo			[1]
lvdh_Previsao	= dw_1.Object.dh_previsao		[1]
lvs_Status		= dw_1.Object.id_status 		[1]
lvs_Observacao	= dw_1.Object.de_observacao 	[1]

If lvs_Tipo = 'S' Then
	lvds_Servico.of_appendwhere("s.cd_servico="+String(lvl_Servico))
Else
	lvds_Servico.of_appendwhere("s.cd_tipo="+String(lvl_Tipo))
End If
lvds_Servico.Retrieve()

For lvl_Linha = 1 To lvds_Servico.RowCount()
	lvl_Servico 		= lvds_Servico.Object.cd_servico	[lvl_Linha]
	
	If (lvdh_Previsao = DateTime("01/01/1900 00:00:00")) Then 
		SetNull(lvdh_Previsao)
	Else 
		lvdh_Previsao	= Datetime(Today(),Time(lvdh_Previsao))
	End If

	Insert Into ocorrencia_servico (cd_servico,dh_ocorrencia,dh_previsao,id_status,de_observacao)
	Values (:lvl_Servico,GetDate(),:lvdh_Previsao,:lvs_Status,:lvs_Observacao)
	Using SQLCa;
	
	lvb_OK = (SQLCa.SQLCode = 0)
	If Not(lvb_OK) Then Exit
Next

If lvb_OK Then
	SQLCa.of_commit( )
	This.Reset()
	This.Event ue_AddRow()
	dw_2.Reset()
	dw_2.Event ue_AddRow()
	dw_2.Retrieve()
Else 
	SQLCa.of_rollback( )
	SQLCa.of_msgdberror( )
End If

Destroy(lvds_Servico)

Return 1
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Datetime lvdh_Previsao

Long lvl_Servico
Long lvl_Tipo

String lvs_Tipo

Time lt_Now

dw_1.Accepttext( )

lvdh_Previsao 	= This.Object.dh_previsao	[ 1 ]
lvl_Servico		= This.Object.cd_servico		[ 1 ]
lvl_Tipo			= This.Object.cd_tipo			[ 1 ]
lvs_Tipo			= This.Object.id_tipo			[ 1 ]
lt_Now			= Time( gf_GetServerDate() )

If (Time(lvdh_Previsao) < lt_Now And lvdh_Previsao <> DateTime("01/01/1900 00:00:00") ) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Previs$$HEX1$$e300$$ENDHEX$$o de retorno inv$$HEX1$$e100$$ENDHEX$$lida.',Exclamation!)
	This.Event ue_Pos(1,'dh_previsao')
	Return -1	
End If

If SecondsAfter( lt_Now, Time(lvdh_Previsao)) > 83200 And lvdh_Previsao <> DateTime("01/01/1900 00:00:00") Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','A previs$$HEX1$$e300$$ENDHEX$$o de retorno n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 12 horas.',Exclamation!)
	This.Event ue_Pos(1,'dh_previsao')
	Return -1
End If

If lvs_Tipo = 'S' Then
	If Not(lvl_Servico > 0) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Preencha o servico corretamente.',Exclamation!)
		This.Event ue_Pos(1,'nm_servico')
		Return -1
	End If
Else 
	If Not( lvl_Tipo > 0) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Preencha o tipo de servi$$HEX1$$e700$$ENDHEX$$o corretamente.',Exclamation!)
		This.Event ue_Pos(1,'de_tipo')
		Return -1
	End If
End If

Return AncestorReturnValue
end event

event dw_1::ue_addrow;call super::ue_addrow;Datetime ldh_Previsao
DateTime ldh_Parametro

ldh_Parametro = gf_GetServerDate()

ldh_Previsao = DateTime( Date(ldh_Parametro), RelativeTime(Time(ldh_Parametro), 300 ) )

This.Object.dh_ocorrencia 	[ 1 ] = ldh_Parametro
This.Object.dh_previsao		[ 1 ] = ldh_Previsao

This.Event ue_Pos( 1, 'nm_servico' )

Return AncestorReturnValue
end event

event dw_1::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Incluir(True)
This.ivo_Controle_Menu.of_Excluir(False)

end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge349_cadastro_ocorrencia_serv
integer width = 2043
integer height = 688
integer weight = 700
string facename = "Verdana"
string text = "Cadastro"
end type

type dw_2 from dc_uo_dw_base within w_ge349_cadastro_ocorrencia_serv
integer x = 69
integer y = 784
integer width = 2811
integer height = 868
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge349_servicos_ativos"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_Excluir(pl_Linhas > 0)

Return pl_Linhas
	

end event

event ue_predeleterow;//OverRide
Long ll_Servico
String ls_Servico
DateTime ldh_Ocorrencia

This.Accepttext( )

// N$$HEX1$$e300$$ENDHEX$$o deixar excluir uma linha em branco
If This.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum registro selecionado para ser exclu$$HEX1$$ed00$$ENDHEX$$do.", Exclamation!)
	Return false
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma exclus$$HEX1$$e300$$ENDHEX$$o do registro ?", Question!, YesNo!, 2) = 2 Then
	Return False
End If

ll_Servico 		= dw_2.Object.cd_servico 		[This.getRow()]
ls_Servico 		= dw_2.Object.nm_servico 		[This.getRow()]
ldh_Ocorrencia = dw_2.Object.dh_ocorrencia	[This.getRow()]

delete from ocorrencia_servico
	where cd_servico 			= :ll_servico
		and dh_ocorrencia 	= :ldh_Ocorrencia
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdberror("Erro ao excluir o servi$$HEX1$$e700$$ENDHEX$$o " + ls_Servico + ".")
	SqlCa.of_rollback( )
End If

Return true
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_incluir(False)
This.ivo_Controle_Menu.of_excluir(True)
end event

event rowfocuschanged;call super::rowfocuschanged;This.ivo_Controle_Menu.of_incluir(False)
This.ivo_Controle_Menu.of_excluir(True)
end event

event ue_cancel;//OverRide
SqlCa.of_rollback( );

SetPointer(HourGlass!)

// Desabilita os menus de confirma e cancela
If Not IsNull(ivm_Menu) Then
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ivm_Menu.m_Editar.m_Desfazer.Enabled = False
End If

This.Reset()
This.Event ue_Retrieve()

SetPointer(Arrow!)
end event

type gb_2 from groupbox within w_ge349_cadastro_ocorrencia_serv
integer x = 37
integer y = 712
integer width = 2871
integer height = 964
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Ocorr$$HEX1$$ea00$$ENDHEX$$ncias Ativas"
borderstyle borderstyle = styleraised!
end type

