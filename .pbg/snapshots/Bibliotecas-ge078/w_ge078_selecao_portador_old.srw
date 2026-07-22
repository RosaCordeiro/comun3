HA$PBExportHeader$w_ge078_selecao_portador_old.srw
forward
global type w_ge078_selecao_portador_old from dc_w_selecao_generica
end type
end forward

global type w_ge078_selecao_portador_old from dc_w_selecao_generica
int Width=2619
int Height=1528
boolean TitleBar=true
string Title="GE078 - Sele$$HEX2$$e700e300$$ENDHEX$$o do Portador"
long BackColor=80269524
end type
global w_ge078_selecao_portador_old w_ge078_selecao_portador_old

type variables
uo_filial ivo_filial
end variables

on w_ge078_selecao_portador_old.create
call super::create
end on

on w_ge078_selecao_portador_old.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

ivo_Filial = Create uo_Filial

lvs_Parametro = Message.StringParm

If lvs_Parametro <> "" Then
	dw_1.Object.de_portador[1] = lvs_Parametro
	ivb_Pesquisa_Direta = True
End IF



end event

event close;call super::close;Destroy(ivo_Filial)
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge078_selecao_portador_old
int X=18
int Y=288
int Width=2551
int Height=1000
string Text="Lista de Portador"
long BackColor=80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge078_selecao_portador_old
int X=23
int Width=1678
int Height=252
long BackColor=80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge078_selecao_portador_old
int X=41
int Y=72
int Width=1650
int Height=180
boolean BringToTop=true
string DataObject="dw_ge078_selecao_portador"
end type

event dw_1::ue_key;String lvs_Coluna,&
		 lvs_Filial

lvs_Coluna = dw_1.GetColumnName()

If Key = KeyEnter! Then
	
	If lvs_Coluna = "nm_fantasia" Then
				
		lvs_Filial = This.GetText()
		
		ivo_Filial.Of_Localiza_Filial(lvs_Filial)
		
		If ivo_Filial.Localizada Then
			dw_1.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
			dw_1.Object.cd_filial  [1] = ivo_Filial.cd_filial
		End If
			
	End If
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If lvs_Coluna =  "nm_fantasia" Then
		
	If Data <> ivo_Filial.nm_fantasia Then
		Return 1
	End If
	
End If


end event

event dw_1::editchanged;call super::editchanged;String lvs_Coluna, &
		 lvs_Nulo
		 
Long lvl_Nulo

lvs_Coluna = This.GetColumnName()

If lvs_Coluna = "de_portador" Then
	
	SetNull(lvs_Nulo)
	SetNull(lvl_Nulo)
	
	dw_1.Object.cd_filial  [1] = lvl_Nulo
	dw_1.Object.nm_fantasia[1] = lvs_Nulo
	
End If

end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge078_selecao_portador_old
int X=59
int Y=356
int Width=2487
int Height=912
boolean BringToTop=true
string DataObject="dw_ge078_lista_portador"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Portador

Long lvl_Cidade

dw_1.AcceptText()

lvs_Portador = dw_1.Object.de_portador[1] 
lvl_Cidade	 = dw_1.Object.cd_filial  [1]

If Not IsNull(lvs_Portador) or lvs_Portador <> "" Then
	This.of_AppendWhere("portador.de_portador like '" + lvs_Portador + "%'") 
End If

If Not IsNull(lvl_Cidade) Then
	This.of_AppendWhere("portador.cd_filial =" + String(lvl_Cidade))
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge078_selecao_portador_old
int X=1819
boolean BringToTop=true
end type

event cb_selecionar::clicked;Long lvl_Linha, &
	  lvl_Portador

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Portador = dw_2.Object.cd_portador[lvl_Linha]
	CloseWithReturn(Parent, lvl_Portador)
Else 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o portador.",Information!, Ok!)
	dw_2.SetFocus()
End If





end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge078_selecao_portador_old
int X=2208
boolean BringToTop=true
end type

event cb_cancelar::clicked;String lvs_Portador

SetNull(lvs_Portador)

CloseWithReturn(Parent, lvs_Portador)

end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge078_selecao_portador_old
int X=1344
boolean BringToTop=true
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge078_selecao_portador_old
boolean BringToTop=true
long BackColor=80269524
end type

