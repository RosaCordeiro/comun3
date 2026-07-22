HA$PBExportHeader$w_ge435_prazo_solic_doc.srw
forward
global type w_ge435_prazo_solic_doc from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge435_prazo_solic_doc from dc_w_cadastro_selecao_lista
integer width = 2107
integer height = 2112
string title = "GE435 - Prazo de Solicita$$HEX2$$e700e300$$ENDHEX$$o de Documenta$$HEX2$$e700e300$$ENDHEX$$o por Cidade"
end type
global w_ge435_prazo_solic_doc w_ge435_prazo_solic_doc

type variables
uo_Cidade	io_Cidade	//ge008
uo_Filial		io_Filial		//ge009
end variables

forward prototypes
public subroutine wf_insere_uf_default ()
end prototypes

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_unidade_federacao", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_Unidade_Federacao[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

on w_ge435_prazo_solic_doc.create
call super::create
end on

on w_ge435_prazo_solic_doc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;wf_Insere_UF_Default()
dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivo_Controle_Menu.of_Excluir(False)
end event

event open;call super::open;io_Cidade	= Create uo_Cidade
io_Filial		= Create uo_Filial
end event

event close;call super::close;Destroy(io_Cidade)
Destroy(io_Filial)
end event

event ue_cancel;//OverRide

dw_2.Event ue_Cancel()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge435_prazo_solic_doc
integer y = 1416
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge435_prazo_solic_doc
integer y = 1344
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge435_prazo_solic_doc
integer width = 1746
integer height = 244
string dataobject = "dw_ge435_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.cd_Filial			[1] = io_Filial.cd_Filial
			This.Object.Nm_Fantasia		[1] = io_Filial.nm_Fantasia
		End If
		
	Case "nm_cidade"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Cidade.Nm_Cidade Then
				Return 1
			End If
		Else
			io_Cidade.of_Inicializa()
			
			This.Object.Cd_Cidade	[1] = io_Cidade.Cd_Cidade
			This.Object.Nm_Cidade	[1] = io_Cidade.Nm_Cidade
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.cd_Filial			[1] = io_Filial.cd_Filial
			This.Object.Nm_Fantasia		[1] = io_Filial.nm_Fantasia
		End If
		
	Case "nm_cidade"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Cidade.Nm_Cidade Then
				Return 1
			End If
		Else
			io_Cidade.of_Inicializa()
			
			This.Object.Cd_Cidade	[1] = io_Cidade.Cd_Cidade
			This.Object.Nm_Cidade	[1] = io_Cidade.Nm_Cidade
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If io_Filial.Localizada Then
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		Else
			io_Filial.of_Inicializa()
		End If		
	End If
	
	If This.GetColumnName() = "nm_cidade" Then
		io_Cidade.of_Localiza_Cidade(This.GetText())
		
		If io_Cidade.Localizada Then
			This.Object.Cd_Cidade		[1] = io_Cidade.Cd_Cidade
			This.Object.Nm_Cidade		[1] = io_Cidade.Nm_Cidade
		Else
			io_Cidade.of_Inicializa()
		End If		
	End If
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge435_prazo_solic_doc
integer y = 372
integer width = 1993
integer height = 1524
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge435_prazo_solic_doc
integer width = 1815
integer height = 352
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge435_prazo_solic_doc
integer y = 448
integer width = 1915
integer height = 1424
string dataobject = "dw_ge435_lista"
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_recuperar;//OverRide

Long ll_Filial
Long ll_Cidade

String ls_Uf

dw_1.AcceptText()

ll_Filial	= dw_1.Object.Cd_Filial						[1]
ls_Uf		= dw_1.Object.Cd_Unidade_Federacao	[1]
ll_Cidade	= dw_1.Object.Cd_Cidade					[1]

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere("f.cd_filial = " + String(ll_Filial))
End If

If ls_Uf <> "XX" Then
	This.of_AppendWhere("c.cd_unidade_federacao = '" + ls_Uf + "'")
End If

If Not IsNull(ll_Cidade) And ll_Cidade > 0 Then
	This.of_AppendWhere("c.cd_cidade = " + String(ll_Cidade))
End If

Return This.Retrieve()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_1.ivo_Controle_Menu.of_Excluir(False)

Return pl_Linhas
end event

