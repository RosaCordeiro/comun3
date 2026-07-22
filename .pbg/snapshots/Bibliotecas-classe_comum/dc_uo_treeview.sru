HA$PBExportHeader$dc_uo_treeview.sru
forward
global type dc_uo_treeview from treeview
end type
end forward

global type dc_uo_treeview from treeview
int Width=494
int Height=360
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string PictureName[]={"Custom039!",&
"Custom050!",&
"Custom035!",&
"Search!"}
long PictureMaskColor=79741120
long StatePictureMaskColor=536870912
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global dc_uo_treeview dc_uo_treeview

event selectionchanged;TreeViewItem ltvi

If This.GetItem(NewHandle, ltvi) = 1 Then
	ltvi.Bold = True
	
	If Not ltvi.Children Then
		ltvi.SelectedPictureIndex = 3
	End If
	
	This.SetItem(NewHandle, ltvi)
	
	If This.GetItem(OldHandle, ltvi) = 1 Then
		ltvi.Bold = False
		
		This.SetItem(OldHandle, ltvi)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getitem para atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista.", StopSign!)
End If
end event

event itemcollapsed;TreeViewItem ltvi

If This.GetItem(Handle, ltvi) = 1 Then
	ltvi.SelectedPictureIndex = 1
	ltvi.PictureIndex = 1
	
	This.SetItem(Handle, ltvi)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getitem para atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista.", StopSign!)
End If
end event

event itemexpanded;TreeViewItem ltvi

If This.GetItem(Handle, ltvi) = 1 Then
	ltvi.SelectedPictureIndex = 2	
	ltvi.PictureIndex = 2
	
	This.SetItem(Handle, ltvi)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getitem para atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista.", StopSign!)
End If
end event

