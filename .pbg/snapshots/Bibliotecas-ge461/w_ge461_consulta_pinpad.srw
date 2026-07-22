HA$PBExportHeader$w_ge461_consulta_pinpad.srw
forward
global type w_ge461_consulta_pinpad from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge461_consulta_pinpad from dc_w_selecao_lista_relatorio
integer width = 5248
integer height = 2528
string title = "GE461 - Consulta Controle Pin Pad"
end type
global w_ge461_consulta_pinpad w_ge461_consulta_pinpad

type variables
uo_filial io_Filial //ge009
end variables

on w_ge461_consulta_pinpad.create
call super::create
end on

on w_ge461_consulta_pinpad.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;io_Filial = Create uo_filial
end event

event close;call super::close;Destroy(io_Filial)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = Date(gf_GetServerDate())
dw_1.Object.Dh_Termino	[1] = Date(gf_GetServerDate())
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge461_consulta_pinpad
integer x = 37
integer y = 872
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge461_consulta_pinpad
integer x = 0
integer y = 800
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge461_consulta_pinpad
integer y = 524
integer width = 5120
integer height = 1800
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge461_consulta_pinpad
integer width = 1851
integer height = 492
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge461_consulta_pinpad
integer x = 59
integer y = 80
integer width = 1737
integer height = 400
string dataobject = "dw_ge461_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then	
	If This.GetColumnName() = 'nm_fantasia' Then
	
		io_Filial.of_Localiza_Filial( This.GetText() )
		
		If io_Filial.Localizada Then
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			
		Else
			
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge461_consulta_pinpad
integer y = 576
integer width = 5051
integer height = 1732
string dataobject = "dw_ge461_lista"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Filial

String ls_Marca
String ls_Nr_Serie
String ls_De_Modelo

dw_1.AcceptText()

ll_Filial		= dw_1.Object.Cd_Filial						[1]
ls_Marca	= dw_1.Object.De_Marca					[1]
ldh_Inicio	= DateTime(dw_1.Object.Dh_Inicio		[1], Time('00:00:00'))
ldh_Termino= DateTime(dw_1.Object.Dh_Termino	[1], Time('23:59:59'))
ls_Nr_Serie	=dw_1.Object.nr_serie					[1]
ls_De_Modelo	=dw_1.Object.de_modelo					[1]


If Not IsNull(ls_Nr_Serie) Then
	This.of_AppendWhere("c.nr_serie  like '%" + String(ls_Nr_Serie) + "%'")
End If

If Not IsNull(ls_De_Modelo) Then
	This.of_AppendWhere("c.de_modelo like '%" + String(ls_De_Modelo) + "%'")
End If


If Not IsNull(ll_Filial) Then
	This.of_AppendWhere("c.cd_filial = " + String(ll_Filial))
End If

If Not IsNull(ls_Marca) And Trim(ls_Marca) <> "" Then
	This.of_AppendWhere("c.de_marca like '%" + ls_Marca + "%'")
End If

If IsNull(ldh_Inicio) And Not IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If Not IsNull(ldh_Inicio) And IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If Not IsNull(ldh_Inicio) And Not IsNull(ldh_Termino) Then
	If Date(ldh_Inicio) > Date(gf_GetServerDate()) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data atual.")
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return -1
	End If
	
	If Date(ldh_Inicio) > Date(ldh_Termino) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return -1
	End If
	
	This.of_AppendWhere("c.dh_ultima_utilizacao >= '" + String(ldh_Inicio, "yyyymmdd hh:mm:ss") + "' and c.dh_ultima_utilizacao <= '" + String(ldh_Termino, "yyyymmdd hh:mm:ss") + "'")
End If

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge461_consulta_pinpad
integer x = 4384
integer y = 60
end type

