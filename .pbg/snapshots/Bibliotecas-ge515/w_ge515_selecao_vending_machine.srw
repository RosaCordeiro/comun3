HA$PBExportHeader$w_ge515_selecao_vending_machine.srw
forward
global type w_ge515_selecao_vending_machine from dc_w_selecao_generica
end type
end forward

global type w_ge515_selecao_vending_machine from dc_w_selecao_generica
integer width = 2898
string title = "GE515 - Sele$$HEX2$$e700e300$$ENDHEX$$o Vending Machine"
end type
global w_ge515_selecao_vending_machine w_ge515_selecao_vending_machine

type variables
uo_Filial io_Filial
end variables

on w_ge515_selecao_vending_machine.create
call super::create
end on

on w_ge515_selecao_vending_machine.destroy
call super::destroy
end on

event close;call super::close;If IsValid( io_Filial ) Then Destroy io_Filial
end event

event open;call super::open;String ls_VM

io_Filial = Create uo_Filial

uo_ge515_vending_machine lo_vending_machine
lo_vending_machine = Create uo_ge515_vending_machine

lo_vending_machine = Message.PowerObjectParm

ls_VM = lo_vending_machine.is_Parametro

If gvo_Parametro.Cd_Filial <> gvo_Parametro.Cd_Filial_Matriz Then
	dw_1.Object.Nm_Fantasia.Protect = 1
	dw_1.Object.Cd_Filial.Protect 		= 1
End If

If Not IsNull( lo_vending_machine.il_filial_retrieve ) Then
	dw_1.Object.Cd_Filial	[ 1 ] = lo_vending_machine.il_filial_retrieve

	io_Filial.of_localiza_codigo( lo_vending_machine.il_filial_retrieve )
	dw_1.Object.Nm_Fantasia[ 1 ] = io_Filial.Nm_Fantasia	
	ivb_Pesquisa_Direta = True
End If

If ls_VM <> "" Then
	dw_1.Object.de_local_vmpay	[1] = ls_VM
	ivb_Pesquisa_Direta = True
End If


end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge515_selecao_vending_machine
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge515_selecao_vending_machine
integer y = 320
integer width = 2825
integer height = 968
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge515_selecao_vending_machine
integer width = 2299
integer height = 288
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge515_selecao_vending_machine
integer width = 2235
integer height = 160
string dataobject = "dw_ge515_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			io_Filial.Of_Inicializa()
			
			This.Object.cd_filial		 	[1] = io_Filial.cd_Filial
			This.Object.nm_fantasia		[1] = io_Filial.Nm_Fantasia
		End If
		
		
End Choose
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = 'nm_fantasia' Then
	cb_Pesquisar.Default = False
	cb_Selecionar.Default = False	
End If

If dwo.Name = 'nm_concorrente' Then
	cb_Pesquisar.Default = True
	cb_Selecionar.Default = False	
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If io_Filial.Localizada Then
				This.Object.nm_Fantasia		[1] = io_Filial.Nm_Fantasia
				This.Object.cd_Filial			[1] = io_Filial.Cd_Filial
				
				This.Event ue_Pos(1,"de_local_vmpay")
			End If
				
	End Choose
	
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge515_selecao_vending_machine
integer y = 392
integer width = 2729
integer height = 868
string dataobject = "dw_ge515_lista"
boolean hscrollbar = true
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_VM
String ls_Ativo

Long ll_Filial

dw_1.AcceptText()

ls_VM				= Trim(dw_1.Object.de_local_vmpay		[1])
ls_Ativo			= dw_1.Object.Id_Situacao					[1]
ll_Filial			= dw_1.Object.cd_Filial 						[1]

If Not IsNull(ls_VM) Then
	This.of_AppendWhere("v.de_local_vmpay like '" + ls_VM + "%'")
End If

If ls_Ativo <> 'T' Then
	This.of_AppendWhere("v.id_situacao = '" + ls_Ativo + "'")
End If

If Not IsNull ( ll_Filial ) Then
	This.of_AppendWhere("v.cd_filial = " + String( ll_Filial ))
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge515_selecao_vending_machine
integer x = 2098
end type

event cb_selecionar::clicked;call super::clicked;Long ll_Nr_vending_machine

dw_2.AcceptText()

If dw_2.GetRow() > 0 Then
	ll_Nr_vending_machine = dw_2.Object.Nr_vending_machine[dw_2.GetRow()]
	CloseWithReturn(Parent, String(ll_Nr_vending_machine))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a Vending Machine.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge515_selecao_vending_machine
integer x = 2487
end type

event cb_cancelar::clicked;call super::clicked;String ls_VM

SetNull(ls_VM)

CloseWithReturn(Parent, ls_VM)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge515_selecao_vending_machine
integer x = 1655
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge515_selecao_vending_machine
integer width = 1367
end type

