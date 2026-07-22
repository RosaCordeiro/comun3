HA$PBExportHeader$w_ge072_selecao_convenio.srw
forward
global type w_ge072_selecao_convenio from dc_w_selecao_generica
end type
end forward

global type w_ge072_selecao_convenio from dc_w_selecao_generica
int X=160
int Width=2153
int Height=1540
boolean TitleBar=true
string Title="GE072 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Conv$$HEX1$$ea00$$ENDHEX$$nios do Epharma"
long BackColor=80269524
end type
global w_ge072_selecao_convenio w_ge072_selecao_convenio

on w_ge072_selecao_convenio.create
call super::create
end on

on w_ge072_selecao_convenio.destroy
call super::destroy
end on

event open;call super::open;String lvs_Convenio
//String lvs_DataObject

lvs_Convenio = Message.StringParm

If Trim(lvs_Convenio) <> "" Then
	dw_1.Object.Nm_Fantasia[1] = lvs_Convenio
	ivb_Pesquisa_Direta = True
End If

// Seleciona a dw que contem somente os convenios da filial

//If gvo_parametro.cd_filial <> gvo_parametro.cd_filial_matriz Then
//	lvs_DataObject = "dw_ge004_lista_filial"
//Else
//	lvs_DataObject = "dw_ge004_lista_matriz"
//End If	
//
//dw_2.of_ChangeDataObject(lvs_DataObject)
//
dw_2.of_SetRowSelection()



end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge072_selecao_convenio
int X=18
int Y=188
int Width=2085
int Height=1100
string Text="Lista de Conv$$HEX1$$ea00$$ENDHEX$$nios"
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge072_selecao_convenio
int X=18
int Y=4
int Width=1723
int Height=176
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge072_selecao_convenio
int X=37
int Y=64
int Width=1696
int Height=100
boolean BringToTop=true
string DataObject="dw_ge072_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge072_selecao_convenio
int X=41
int Y=240
int Width=2034
int Height=1040
boolean BringToTop=true
string DataObject="dw_ge072_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Sql, &
       lvs_Fantasia

dw_1.AcceptText()

lvs_Fantasia = Trim(dw_1.Object.Nm_Fantasia[1])

If lvs_Fantasia <> "" Then
	This.of_AppendWhere("c.nm_convenio like '" + lvs_Fantasia + "%'")
	Return 1
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe algum par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!,Ok!)
	dw_1.SetColumn("nm_fantasia")
	dw_1.SetFocus()	
	Return -1
End If
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge072_selecao_convenio
int X=1408
int Y=1328
int Width=329
boolean BringToTop=true
end type

event cb_selecionar::clicked;Long lvl_Linha,&
	 lvl_Convenio

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Convenio = dw_2.Object.Cd_Convenio[lvl_Linha]
	CloseWithReturn(Parent, lvl_Convenio)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um conv$$HEX1$$ea00$$ENDHEX$$nio na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge072_selecao_convenio
int X=1778
int Y=1328
int Width=329
boolean BringToTop=true
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Convenio

SetNull(lvs_Convenio)

CloseWithReturn(Parent, lvs_Convenio)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge072_selecao_convenio
int X=1056
int Y=1328
int Width=329
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge072_selecao_convenio
int X=27
int Y=1328
int Width=1001
int Height=64
boolean BringToTop=true
long BackColor=80269524
end type

