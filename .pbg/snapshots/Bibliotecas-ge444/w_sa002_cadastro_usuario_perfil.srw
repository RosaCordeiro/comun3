HA$PBExportHeader$w_sa002_cadastro_usuario_perfil.srw
forward
global type w_sa002_cadastro_usuario_perfil from dc_w_sheet
end type
type tv_1 from treeview within w_sa002_cadastro_usuario_perfil
end type
type dw_1 from dc_uo_dw_base within w_sa002_cadastro_usuario_perfil
end type
type gb_1 from groupbox within w_sa002_cadastro_usuario_perfil
end type
end forward

global type w_sa002_cadastro_usuario_perfil from dc_w_sheet
string tag = "SA002 - Cadastro de Usu$$HEX1$$e100$$ENDHEX$$rios por Perfil"
integer width = 3657
integer height = 1612
string title = "SA002 - Cadastro de Usu$$HEX1$$e100$$ENDHEX$$rios por Perfil"
event ue_addrow ( )
tv_1 tv_1
dw_1 dw_1
gb_1 gb_1
end type
global w_sa002_cadastro_usuario_perfil w_sa002_cadastro_usuario_perfil

type variables
uo_usuario 			ivo_usuario			//GE010
uo_servicedesk		ivo_servicedesk		//GE359

String ivs_sistema
String ivs_Perfil

Integer ivi_perfil

long ivl_handle

integer ivi_level

string ivs_label

boolean ivb_children

String ivs_Log_Incl = ""
String ivs_Log_Excl = ""
end variables

forward prototypes
public subroutine wf_mostra_perfis (string as_sistema, long al_handle)
public subroutine wf_mostra_sistemas ()
public function boolean wf_verifica_perfil_existe (string ps_matricula, string ps_sistema)
end prototypes

event ue_addrow();dw_1.Event ue_AddRow()
end event

public subroutine wf_mostra_perfis (string as_sistema, long al_handle);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle, &
	  lvl_Codigo

String lvs_Descricao, &
       lvs_Label

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ddw_perfil_usuario") Then 
	Destroy(lvds_1)
	Return
End If

lvl_Total = lvds_1.Retrieve(as_Sistema)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvl_Codigo    	= lvds_1.Object.Cd_Perfil_Usuario[lvl_Contador]
		lvs_Descricao 	= lvds_1.Object.De_Perfil_Usuario[lvl_Contador]
			
		lvs_Label = as_Sistema + ". Perfil: " + Right(String(lvl_Codigo, "00"), 2) + " - " + lvs_Descricao

		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(al_Handle, lvs_Label, 4)
		Else
			lvl_Handle = tv_1.InsertItemLast(al_Handle, lvs_Label, 4)	
		End If
	Next
End If

Destroy(lvds_1)
end subroutine

public subroutine wf_mostra_sistemas ();Long lvl_Total, &
     lvl_Contador, &
	  lvl_Handle

String lvs_Codigo, &
       lvs_Descricao, &
       lvs_Label

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ddw_sistema") Then  //Fica nas DDW Comuns
	Destroy(lvds_1)
	Return
End If

lvds_1.of_appendwhere("coalesce(id_loja,'N')='N'")
lvds_1.of_appendwhere("coalesce(id_controle_acesso,'N')='S'")
lvl_Total = lvds_1.Retrieve()

lvds_1.SetSort("cd_sistema")
lvds_1.Sort()

If lvl_Total > 0 Then
	
	For lvl_Contador = 1 To lvl_Total
		lvs_Codigo    	= lvds_1.Object.Cd_Sistema	[lvl_Contador]
		lvs_Descricao 	= lvds_1.Object.Nm_Sistema	[lvl_Contador]
		
		lvs_Label = Right(lvs_Codigo, 2) + " - " + lvs_Descricao

		If lvl_Contador = 1 Then
			lvl_Handle = tv_1.InsertItemFirst(0, lvs_Label, 1)
		Else
			lvl_Handle = tv_1.InsertItemLast(0, lvs_Label, 1)	
		End If

		If lvl_Handle > 0 Then
			wf_Mostra_Perfis(lvs_Codigo, lvl_Handle)
		Else	
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inser$$HEX2$$e700e300$$ENDHEX$$o do sistema '" + lvs_Label + "' na lista.", StopSign!)
		End If
	Next

	tv_1.SelectItem(1)
	tv_1.SetFocus()
	
	lvl_Handle = tv_1.FindItem(RootTreeItem!, 0)
	
	tv_1.CollapseItem(lvl_Handle)
End If

Destroy(lvds_1)
end subroutine

public function boolean wf_verifica_perfil_existe (string ps_matricula, string ps_sistema);String ls_Nome_Perfil

Boolean lb_Sucesso = False

Select p.de_perfil_usuario
Into :ls_Nome_Perfil
From	perfil_usuario as p
Inner Join usuario_sistema as u
On 	u.cd_sistema			= p.cd_sistema
And	u.cd_perfil_usuario	= p.cd_perfil_usuario
Where	u.cd_sistema		= :ps_sistema
And		u.nr_matricula		= :ps_matricula
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case -1
		Sqlca.of_MsgDbError()
		
	Case 100
		lb_Sucesso = True
		
	Case 0
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este usu$$HEX1$$e100$$ENDHEX$$rio est$$HEX1$$e100$$ENDHEX$$ cadastrado para o perfil " + ls_Nome_Perfil + ".")
		
End Choose

Return lb_Sucesso
end function

on w_sa002_cadastro_usuario_perfil.create
int iCurrent
call super::create
this.tv_1=create tv_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_sa002_cadastro_usuario_perfil.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tv_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event close;call super::close;Destroy(ivo_usuario)
Destroy(ivo_servicedesk)
end event

event ue_cancel;call super::ue_cancel;This.ivm_Menu.mf_Excluir(True)
This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)

dw_1.Retrieve(ivs_sistema,ivi_perfil)
end event

event ue_postopen;call super::ue_postopen;ivo_usuario.of_todos_usuarios( )

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

SetPointer(HourGlass!)
wf_Mostra_Sistemas()
SetPointer(Arrow!)
end event

event ue_presave;call super::ue_presave;Long ll_Linha

String ls_Usuario

ll_Linha = dw_1.RowCount()

If ll_Linha > 0 Then
	ls_Usuario = dw_1.Object.Nm_Usuario[ll_Linha]
	
	If IsNull(ls_Usuario) Then
		dw_1.DeleteRow(ll_Linha)
	End If
End If

Return AncestorReturnValue
end event

event ue_preopen;call super::ue_preopen;ivo_usuario 		= Create uo_usuario
ivo_servicedesk	= Create uo_servicedesk
end event

type dw_visual from dc_w_sheet`dw_visual within w_sa002_cadastro_usuario_perfil
integer x = 69
integer y = 2240
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_sa002_cadastro_usuario_perfil
integer x = 32
integer y = 2168
end type

type tv_1 from treeview within w_sa002_cadastro_usuario_perfil
integer x = 14
integer y = 28
integer width = 1522
integer height = 1380
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
borderstyle borderstyle = stylelowered!
string picturename[] = {"Custom039!","Custom050!","Custom035!","Search!"}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event itemexpanded;//OverRide

TreeViewItem ltvi

This.GetItem(handle, ltvi)

If ltvi.Level = 1 Then
	ltvi.PictureIndex 			= 2
	ltvi.SelectedPictureIndex 	= 2
End If

This.SetItem(handle, ltvi)
end event

event selectionchanging;//If wf_Valida_Salva() = -3 Then
//	Return 1
//End If
//
//dw_1.Reset()
end event

event selectionchanged;//OverRide

TreeViewItem ltvi

Parent.ivm_Menu.mf_Confirmar(False)
Parent.ivm_Menu.mf_Cancelar (False)
		
If This.GetItem(NewHandle, ltvi) = 1 Then
	
	ivl_Handle   		= NewHandle
	ivi_Level    		= ltvi.Level
	ivs_Label    		= ltvi.Label
	ivb_Children 	= ltvi.Children
	
	If ivi_Level = 2 Then
		ivs_Sistema	= Mid(ivs_Label, 1, 2)
		ivs_Perfil		= String(Mid(ivs_Label, 13))
		ivi_Perfil 		= Long(String(Mid(ivs_Perfil, 1, 2)))	
		
		dw_1.Retrieve(ivs_Sistema,ivi_Perfil)
		Parent.ivm_Menu.mf_Incluir(True)
			
	Else
		Parent.ivm_Menu.mf_Incluir(False)
		Parent.ivm_Menu.mf_Excluir(False)
	End If
	
	ltvi.Bold = True
	
	If ivi_Level > 1 Then
		ltvi.SelectedPictureIndex = 3	
	End If
	
	This.SetItem(NewHandle, ltvi)
	
	If This.GetItem(OldHandle, ltvi) = 1 Then
		ltvi.Bold = False
		
		This.SetItem(OldHandle, ltvi)
	End If
	
	dw_1.SetFocus()
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getitem para atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista.", StopSign!)
End If
end event

event itemcollapsed;//OverRide

TreeViewItem ltvi

This.GetItem(handle, ltvi)

If ltvi.Level = 1 Then
	ltvi.PictureIndex 			= 1
	ltvi.SelectedPictureIndex	= 1
End If

This.SetItem(handle, ltvi)
end event

type dw_1 from dc_uo_dw_base within w_sa002_cadastro_usuario_perfil
integer x = 1591
integer y = 64
integer width = 1979
integer height = 1320
string dataobject = "dw_sa002_usuario_perfil"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar (True)
end event

event getfocus;call super::getfocus;If This.RowCount() > 0 Then
	Parent.ivm_Menu.mf_Excluir(True)
End If
end event

event itemchanged;call super::itemchanged;Long lvl_Linha

lvl_Linha = dw_1.GetRow()

If Dwo.Name = "nr_matricula" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <>  ivo_Usuario.Nm_Usuario Then
			Return 1
		End If
	Else
		dw_1.Object.Nr_Matricula[lvl_Linha] = ""
		dw_1.Object.Nm_Usuario[lvl_Linha] = ""
	End If		
End If
	
Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event losefocus;call super::losefocus;Parent.ivm_Menu.mf_Excluir(False)

end event

event ue_key;call super::ue_key;String	lvs_Sistema, &
		lvs_Matricula, &
		lvs_Usuario, &
		lvs_Nulo
		 
Integer lvi_Linha

Boolean lvb_Ok = True

If key = KeyEnter! Then 
	Choose Case This.GetColumnName()
		Case "nm_usuario"
			
			lvs_Matricula	= This.GetText()
			lvi_Linha			= This.GetRow()
				
			ivo_Usuario.Of_Localiza_Usuario(lvs_Matricula)
			
			If ivo_Usuario.Localizado Then
				If ivo_usuario.Id_Situacao = 'I'  Then
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Usu$$HEX1$$e100$$ENDHEX$$rio " +  ivo_Usuario.Nm_Usuario + " (" + ivo_usuario.Nr_Matricula + ")" + " est$$HEX1$$e100$$ENDHEX$$ inativo.",Exclamation!)
					lvb_Ok = False

				ElseIf ivo_usuario.Id_Situacao <> 'A'  Then
					If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Usu$$HEX1$$e100$$ENDHEX$$rio " +  ivo_Usuario.Nm_Usuario + " (" + ivo_usuario.Nr_Matricula + ")" + " est$$HEX1$$e100$$ENDHEX$$ "+IIF(ivo_usuario.Id_Situacao="F","afastado","bloqueado")+".~r~nDeseja continuar?",Exclamation!, YesNo!, 2) = 2 Then
						lvb_Ok = False
					End If
				End If
				
				If Not lvb_Ok Then
					ivo_Usuario.of_inicializa( )
			
					dw_1.Object.Nr_Matricula		[lvi_Linha] = ivo_Usuario.Nr_Matricula
					dw_1.Object.Nm_Usuario		[lvi_Linha] = ivo_Usuario.Nm_Usuario
					
					ivm_Menu.mf_Confirmar(False)
					ivm_Menu.mf_Cancelar(False)
				
					Return -1
				End If
				
				If wf_verifica_perfil_existe(lvs_Matricula, ivs_Sistema) Then
					dw_1.Object.Nr_Matricula		[lvi_Linha] = ivo_Usuario.Nr_Matricula
					dw_1.Object.Nm_Usuario		[lvi_Linha] = ivo_Usuario.Nm_Usuario
					dw_1.Object.Cd_Sistema		[lvi_Linha] = ivs_Sistema
					dw_1.Object.Cd_Perfil_Usuario	[lvi_Linha] = ivi_Perfil
					
					This.Post Event ue_pos(lvi_Linha, "nr_chamado")
				Else
					ivm_Menu.mf_Confirmar(False)
					ivm_Menu.mf_Cancelar(False)
				End If
			Else
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o localizado.",Exclamation!)
				ivm_Menu.mf_Confirmar(False)
				ivm_Menu.mf_Cancelar(False)
				Return -1
			End If	
	End Choose
End If		
end event

event ue_preinsertrow;call super::ue_preinsertrow;Long ll_Linha

String ls_Usuario

ll_Linha = RowCount()

If ll_Linha > 0 Then
	ls_Usuario = dw_1.Object.Nm_Usuario[ll_Linha]
	
	If IsNull(ls_Usuario) Then
		Return - 1
	End If
End If

Return AncestorReturnValue
end event

event rowfocuschanged;call super::rowfocuschanged;String lvs_Matricula

If CurrentRow > 0 Then
	This.Accepttext( )
	
	lvs_Matricula = This.Object.nr_matricula [CurrentRow]
	
	If (Not IsNull(lvs_Matricula)) and (lvs_Matricula<>"") Then
		ivo_usuario.of_localiza_matricula( lvs_Matricula )
	Else
		ivo_usuario.of_inicializa( )
	End If
End If
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_linha
Long lvl_Chamado

String lvs_Nome
String lvs_Matricula

ivs_Log_Incl = ""
ivs_Log_Excl = ""

lvl_linha = This.GetNextModified(0,Primary!)
Do While lvl_linha > 0
	If This.GetItemStatus(lvl_linha,"nr_matricula",Primary!) <> NotModified! Then
		lvs_Nome 		= This.Object.nm_usuario	[lvl_linha]
		lvs_Matricula	= This.Object.nr_matricula	[lvl_linha]
		lvl_Chamado	= This.Object.nr_chamado	[lvl_linha]
		
		If IsNull(lvl_Chamado) or lvl_Chamado = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Informe o chamado que solicita acesso ao perfil "+ivs_Perfil+" do sistema "+ivs_sistema+" para o usu$$HEX1$$e100$$ENDHEX$$rio "+lvs_Nome+".",Exclamation!)
			This.Event ue_Pos(lvl_linha, "nr_chamado")
			Return -1
		End If
		
		If Not ivo_servicedesk.of_localiza_codigo( lvl_Chamado ) Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o chamado "+String(lvl_Chamado)+".~r~r"+ &
								"Deseja continuar mesmo assim?",Question!,Yesno!,2) = 2 Then
				This.Event ue_Pos(lvl_linha, "nr_chamado")
				Return -1
			End If
		End If
		
		ivs_Log_Incl += '<table border=1 style="font-size:xx-small; font-family: verdana;">'+ &
								"<tr><td><b>Usu$$HEX1$$e100$$ENDHEX$$rio Sistema:</b></td><td>"+lvs_Nome+" ("+lvs_Matricula+")</td></tr>"+ &
								"<tr><td><b>Chamado:</b></td><td>"+String(lvl_Chamado)+"</td></tr>"+&
								IIF(Not IsNull(ivo_servicedesk.nm_usuario),"<tr><td><b>Usu$$HEX1$$e100$$ENDHEX$$rio Chamado:</b></td><td>"+ivo_servicedesk.nm_usuario+"</td></tr>","")+&
								IIF(Not IsNull(ivo_servicedesk.De_Chamado), "<tr><td><b>Texto Chamado:</b></td><td>"+ivo_servicedesk.De_Chamado+"</td></tr>","")+&
							 "</table><br />"
	End If
	lvl_linha = This.GetNextModified(lvl_linha,Primary!)
Loop

For lvl_linha = 1 To This.DeletedCount()
	lvs_Nome 		= This.GetItemString(lvl_linha,"nm_usuario",Delete!,True)
	lvs_Matricula	= This.GetItemString(lvl_linha,"nr_matricula",Delete!,True)
	ivs_Log_Excl 	+= IIF(Trim(ivs_Log_Excl)<>"","</li><li>","")+lvs_Nome+" ("+lvs_Matricula+")"
Next

Return AncestorReturnValue
end event

event ue_update;call super::ue_update;String lvs_Mensagem
String lvs_Sistema

If AncestorReturnValue >= 0 Then
	If Trim(ivs_Log_Incl)<>"" or Trim(ivs_Log_Excl)<>"" Then
		select nm_sistema
		Into :lvs_Sistema
		From sistema
		Where cd_sistema  = :ivs_sistema
		Using SQLCa;
		
		If IsNull(lvs_Sistema) Then lvs_Sistema = ""
		
		lvs_Mensagem = 	"Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio,<br><br>"+ &
								"O usu$$HEX1$$e100$$ENDHEX$$rio "+gvo_aplicacao.ivo_seguranca.nm_usuario+" ("+gvo_aplicacao.ivo_seguranca.nr_matricula+") alterou os usu$$HEX1$$e100$$ENDHEX$$rio(s) com permiss$$HEX1$$e300$$ENDHEX$$o ao sistema "+lvs_Sistema+" ("+ivs_sistema+") no perfil "+ivs_Perfil+":<br>"+ &
								IIF(ivs_Log_Incl<>"","<br /><b>INCLUS$$HEX1$$c300$$ENDHEX$$O:</b><br /><br /><ul>"+ivs_Log_Incl+"</ul>","")+ &
								IIF(ivs_Log_Excl<>"","<br /><b>EXCLUS$$HEX1$$c300$$ENDHEX$$O:</b><br /><ul><li>"+ivs_Log_Excl+"</li></ul>","")+ &
								"<br /><br /><b>Database: </b>"+SQLCa.Database
		gf_ge202_envia_email_automatico(106,'Manuten$$HEX2$$e700e300$$ENDHEX$$o Permiss$$HEX1$$e300$$ENDHEX$$o Sistema',lvs_Mensagem)
	End If
End If

Return AncestorReturnValue
end event

event ue_cancel;call super::ue_cancel;ivs_Log_Incl = ""
ivs_Log_Excl = ""
end event

type gb_1 from groupbox within w_sa002_cadastro_usuario_perfil
integer x = 1559
integer width = 2030
integer height = 1408
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

