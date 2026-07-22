HA$PBExportHeader$w_ge082_cadastro_modalidade_tef_filial.srw
forward
global type w_ge082_cadastro_modalidade_tef_filial from dc_w_sheet
end type
type gb_2 from groupbox within w_ge082_cadastro_modalidade_tef_filial
end type
type gb_1 from groupbox within w_ge082_cadastro_modalidade_tef_filial
end type
type dw_1 from dc_uo_dw_base within w_ge082_cadastro_modalidade_tef_filial
end type
type dw_2 from dc_uo_dw_base within w_ge082_cadastro_modalidade_tef_filial
end type
type dw_3 from dc_uo_dw_base within w_ge082_cadastro_modalidade_tef_filial
end type
type cb_selecionar from commandbutton within w_ge082_cadastro_modalidade_tef_filial
end type
end forward

global type w_ge082_cadastro_modalidade_tef_filial from dc_w_sheet
int Width=3881
int Height=2024
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
cb_selecionar cb_selecionar
end type
global w_ge082_cadastro_modalidade_tef_filial w_ge082_cadastro_modalidade_tef_filial

type variables
dc_uo_ds_base ids_modalidade

long ivl_linha_anterior
end variables

on w_ge082_cadastro_modalidade_tef_filial.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_selecionar=create cb_selecionar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.cb_selecionar
end on

on w_ge082_cadastro_modalidade_tef_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_selecionar)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_3}
This.wf_SetUpdate_DW(lvo_Update)

ids_modalidade = Create dc_uo_ds_base

If Not ids_Modalidade.of_ChangeDataObject("dw_ge082_restricao_modalidade") Then
	Destroy(ids_Modalidade)
End If

dw_1.Event ue_Retrieve()
dw_2.Event ue_Retrieve()
end event

event close;call super::close;Destroy(ids_modalidade)
end event

type gb_2 from groupbox within w_ge082_cadastro_modalidade_tef_filial
int X=23
int Y=4
int Width=1614
int Height=1684
int TabOrder=20
string Text="Lista de Filiais"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=80269524
int TextSize=-8
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_ge082_cadastro_modalidade_tef_filial
int X=1669
int Y=4
int Width=2144
int Height=1684
int TabOrder=10
string Text="Lista de Modalidades do TEF"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=80269524
int TextSize=-8
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from dc_uo_dw_base within w_ge082_cadastro_modalidade_tef_filial
int X=64
int Y=68
int Width=1550
int Height=1596
int TabOrder=50
boolean BringToTop=true
string DataObject="dw_ge082_lista_filial"
boolean VScrollBar=true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;// If wf_Valida_Salva() = -3 Then
//	This.SetRow(ivl_linha_anterior)
//	dw_2.Event ue_Retrieve()
//	dw_3.Event ue_Recuperar()
	
//	MEssagebox("DD", string(ivl_linha_anterior))
//	Return 3
//Else
	
wf_Valida_Salva()
	
dw_2.Event ue_Retrieve()
dw_3.Event ue_Recuperar()





end event

event clicked;call super::clicked;ivl_linha_anterior = dw_1.GetRow()
end event

type dw_2 from dc_uo_dw_base within w_ge082_cadastro_modalidade_tef_filial
event ue_seleciona_filial ( long cd_filial,  long cd_modalidade,  boolean id_selecao )
int X=1710
int Y=68
int Width=2080
int Height=1596
int TabOrder=40
boolean BringToTop=true
string DataObject="dw_ge082_lista_modalidade"
boolean VScrollBar=true
end type

event ue_seleciona_filial;Long lvl_Find, &
	  lvl_Insert

If id_selecao Then
	lvl_Find = dw_3.Find("cd_filial = " + String(cd_filial) + " and cd_modalidade = " + String(cd_modalidade), 1, dw_3.RowCount()) 
	
	If lvl_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a restri$$HEX2$$e700e300$$ENDHEX$$o para a filial.", StopSign!)
	Else
		If lvl_Find = 0 Then
			lvl_Insert = dw_3.InsertRow(0)
			dw_3.Object.cd_Filial    [lvl_Insert] = cd_filial
			dw_3.Object.cd_Modalidade[lvl_Insert] = cd_modalidade
		End If
	End If
Else
	
	lvl_Find = dw_3.Find("cd_filial = " + String(cd_filial) + " and cd_modalidade = " + String(cd_modalidade), 1, dw_3.RowCount()) 	

	If lvl_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o cadastro da modalidade a filial.", StopSign!)
	Else
		If lvl_Find > 0 Then
			dw_3.DeleteRow(lvl_Find)
		End If
	End If
	
End If



end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_postretrieve;Long lvl_Filial,    &
	  lvl_Linha,     &
	  lvl_Linhas,    &
	  lvl_Modalidade,&
	  lvl_Find

lvl_Filial = dw_1.Object.cd_filial[dw_1.GetRow()]

lvl_Linhas = dw_2.RowCount()

ids_Modalidade.Retrieve(lvl_Filial)

For lvl_Linha = 1 To lvl_Linhas
	lvl_Modalidade = dw_2.Object.cd_modalidade[lvl_Linha]
	
	lvl_Find = ids_Modalidade.Find("cd_modalidade =" + String(lvl_Modalidade), 1, ids_Modalidade.RowCount())
	
	If lvl_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a modalidade do tef para a filial.", StopSign!)
	End If
	
	If lvl_Find > 0 Then
		dw_2.Object.id_selecionado[lvl_Linha] = "S"
	Else
		dw_2.Object.id_selecionado[lvl_Linha]  = "N"
	End If
	
Next

Return 1

end event

event itemchanged;call super::itemchanged;Boolean lvb_Selecao

Long lvl_Filial, & 
	  lvl_Modalidade

lvl_Filial     = dw_1.Object.Cd_Filial    [dw_1.GetRow()]
lvl_Modalidade = dw_2.Object.Cd_Modalidade[dw_2.GetRow()]

If Data = "S" Then
	lvb_Selecao = True
Else
	lvb_Selecao = False
End If

This.Event ue_Seleciona_Filial(lvl_Filial, lvl_Modalidade, lvb_Selecao)

Parent.ivb_Valida_Salva = True

Parent.ivm_Menu.mf_Confirmar(True)
//Parent.ivm_Menu.mf_Cancelar(True)

//ivl_linha_anterior = dw_1.GetRow()
end event

type dw_3 from dc_uo_dw_base within w_ge082_cadastro_modalidade_tef_filial
int X=1906
int Y=1776
int Width=526
int Height=240
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_ge082_restricao_modalidade"
boolean VScrollBar=true
end type

event ue_recuperar;// OverRide

Return dw_3.Retrieve(dw_1.Object.cd_filial[dw_1.GetRow()])
end event

type cb_selecionar from commandbutton within w_ge082_cadastro_modalidade_tef_filial
int X=3163
int Y=1712
int Width=649
int Height=108
int TabOrder=50
boolean BringToTop=true
string Text="&Todas Modalidades"
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Boolean lvb_Check = True

Long lvl_Filial,     &
     lvl_Modalidade, &
	  lvl_Linha

String lvs_Selecao = "N"

dw_3.Event ue_Recuperar()

If cb_selecionar.text = '&Todas Modalidades' Then
	lvb_Check = True
	cb_selecionar.text = '&Nenhuma Modalidade'
Else
	lvb_Check = False
	cb_selecionar.text = '&Todas Modalidades'
End If

lvl_Filial = dw_1.Object.cd_Filial[dw_1.GetRow()]

If lvb_Check Then
	lvs_Selecao = "S"
End If

For lvl_Linha = 1 To dw_2.RowCount()
	
	dw_2.Object.id_selecionado[lvl_Linha] = lvs_Selecao
	
	lvl_Modalidade = dw_2.Object.cd_modalidade[lvl_Linha]
	dw_2.Event ue_Seleciona_Filial(lvl_Filial, lvl_Modalidade, lvb_Check)
	
NExt

Parent.ivb_Valida_Salva = True

Parent.ivm_Menu.mf_Confirmar(True)
//Parent.ivm_Menu.mf_Cancelar(True)

//ivl_linha_anterior = dw_1.GetRow()

end event

