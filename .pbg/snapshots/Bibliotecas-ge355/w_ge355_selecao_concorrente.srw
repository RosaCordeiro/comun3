HA$PBExportHeader$w_ge355_selecao_concorrente.srw
forward
global type w_ge355_selecao_concorrente from dc_w_selecao_generica
end type
end forward

global type w_ge355_selecao_concorrente from dc_w_selecao_generica
integer x = 704
integer y = 436
integer width = 2752
integer height = 1596
string title = "GE355 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Concorrente"
end type
global w_ge355_selecao_concorrente w_ge355_selecao_concorrente

type variables
uo_Filial io_Filial
end variables

on w_ge355_selecao_concorrente.create
call super::create
end on

on w_ge355_selecao_concorrente.destroy
call super::destroy
end on

event open;call super::open;String ls_Concorrente

io_Filial = Create uo_Filial

uo_ge355_concorrente lo_Concorrente
lo_Concorrente = Create uo_ge355_concorrente

lo_Concorrente = Message.PowerObjectParm

ls_Concorrente = lo_Concorrente.is_Parametro

If gvo_Parametro.Cd_Filial <> gvo_Parametro.Cd_Filial_Matriz Then
	dw_1.Object.Nm_Fantasia.Protect = 1
	dw_1.Object.Cd_Filial.Protect 		= 1
End If

If Not IsNull( lo_Concorrente.il_filial_retrieve ) Then
	dw_1.Object.Cd_Filial	[ 1 ] = lo_Concorrente.il_filial_retrieve

	io_Filial.of_localiza_codigo( lo_Concorrente.il_filial_retrieve )
	dw_1.Object.Nm_Fantasia[ 1 ] = io_Filial.Nm_Fantasia
	
End If

If ls_Concorrente <> "" Then
	dw_1.Object.Nm_Concorrente[1] = ls_Concorrente
	ivb_Pesquisa_Direta = True
End If


end event

event close;call super::close;If IsValid( io_Filial ) Then Destroy io_Filial
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge355_selecao_concorrente
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge355_selecao_concorrente
integer x = 18
integer y = 268
integer width = 2697
integer height = 1108
long backcolor = 80269524
string text = "Lista de Concorrentes"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge355_selecao_concorrente
integer x = 18
integer y = 4
integer width = 2459
integer height = 252
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge355_selecao_concorrente
integer x = 41
integer y = 64
integer width = 2414
integer height = 168
string dataobject = "dw_ge355_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If io_Filial.Localizada Then
				This.Object.nm_Fantasia		[1] = io_Filial.Nm_Fantasia
				This.Object.cd_Filial			[1] = io_Filial.Cd_Filial
				
				This.Event ue_Pos(1,"nm_concorrente")
			End If
				
	End Choose
	
End If
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

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge355_selecao_concorrente
integer x = 41
integer y = 320
integer width = 2651
integer height = 1040
string dataobject = "dw_ge355_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Concorrente
String ls_Ativo

Long ll_Filial

dw_1.AcceptText()

ls_Concorrente	= Trim(dw_1.Object.Nm_Concorrente	[1])
ls_Ativo			= dw_1.Object.Id_Situacao					[1]
ll_Filial			= dw_1.Object.cd_Filial 						[1]

If Not IsNull(ls_Concorrente) Then
	This.of_AppendWhere("c.nm_concorrente like '" + ls_Concorrente + "%'", 1)
	This.of_AppendWhere("c.nm_concorrente like '" + ls_Concorrente + "%'", 2)
End If

If ls_Ativo <> 'T' Then
	This.of_AppendWhere("c.id_situacao = '" + ls_Ativo + "'", 1)
	This.of_AppendWhere("c.id_situacao = '" + ls_Ativo + "'", 2)
End If

If Not IsNull ( ll_Filial ) Then
	This.of_AppendWhere("f.cd_filial = " + String( ll_Filial ), 2)
End If

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge355_selecao_concorrente
integer x = 1957
integer y = 1396
end type

event cb_selecionar::clicked;call super::clicked;Long ll_Concorrente

dw_2.AcceptText()

If dw_2.GetRow() > 0 Then
	ll_Concorrente = dw_2.Object.Cd_Concorrente[dw_2.GetRow()]
	CloseWithReturn(Parent, String(ll_Concorrente))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um concorrente.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge355_selecao_concorrente
integer x = 2345
integer y = 1396
end type

event cb_cancelar::clicked;call super::clicked;String ls_Concorrente

SetNull(ls_Concorrente)

CloseWithReturn(Parent, ls_Concorrente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge355_selecao_concorrente
integer x = 1545
integer y = 1396
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge355_selecao_concorrente
integer x = 27
integer y = 1408
integer width = 992
long backcolor = 80269524
end type

