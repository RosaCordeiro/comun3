HA$PBExportHeader$w_ge468_relatorio_diversa_cobranca_forn.srw
forward
global type w_ge468_relatorio_diversa_cobranca_forn from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge468_relatorio_diversa_cobranca_forn from dc_w_selecao_lista_relatorio
integer width = 3945
integer height = 2404
string title = "GE468 - Relat$$HEX1$$f300$$ENDHEX$$rio de Notas de Reembolso de Fornecedor"
end type
global w_ge468_relatorio_diversa_cobranca_forn w_ge468_relatorio_diversa_cobranca_forn

type variables
uo_fornecedor		io_Fornecedor
uo_ge216_filiais	ivo_Selecao_filiais
uo_filial 				ivo_filial

String ivs_filiais
end variables

forward prototypes
public subroutine wf_insere_motivo_ajuste_default ()
end prototypes

public subroutine wf_insere_motivo_ajuste_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_motivo_ajuste", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_motivo_ajuste", "XX")
	lvdwc.SetItem(1, "de_motivo_ajuste", "TODOS")
	
	dw_1.Object.Cd_Motivo_Ajuste[1] = 49
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do motivo de ajuste.")
End If
end subroutine

on w_ge468_relatorio_diversa_cobranca_forn.create
call super::create
end on

on w_ge468_relatorio_diversa_cobranca_forn.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;If IsValid(io_Fornecedor) Then Destroy(io_Fornecedor)
If IsValid(ivo_Selecao_filiais) Then Destroy(ivo_Selecao_filiais)
If IsValid(ivo_filial) Then Destroy(ivo_filial)
end event

event ue_preopen;call super::ue_preopen;io_Fornecedor 		= Create uo_fornecedor
ivo_Selecao_filiais	= Create uo_ge216_filiais
ivo_filial 				= Create uo_filial

MaxWidth = 5100
MaxHeight = 9999
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = RelativeDate(Today(), - 1)
dw_1.Object.Dh_Termino	[1] = Today()

wf_Insere_Motivo_Ajuste_Default()

This.ivm_menu.ivb_permite_imprimir = True
end event

event ue_print;//override
dw_2.Event ue_Imprimir_Relatorio(dw_2.Title, 'CL', True)
end event

event ue_printimmediate;//override
dw_2.Event ue_Imprimir_Relatorio(dw_2.Title, 'CL', True)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge468_relatorio_diversa_cobranca_forn
integer x = 37
integer y = 716
integer width = 1815
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge468_relatorio_diversa_cobranca_forn
integer x = 0
integer y = 644
integer width = 1906
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge468_relatorio_diversa_cobranca_forn
integer y = 384
integer width = 3822
integer height = 1796
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge468_relatorio_diversa_cobranca_forn
integer width = 3817
integer height = 356
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge468_relatorio_diversa_cobranca_forn
integer width = 3749
integer height = 240
string dataobject = "dw_ge468_selecao"
end type

event dw_1::ue_key;call super::ue_key;Choose Case Key
	Case KeyEnter!
		If This.GetColumnName() = "nm_razao_social" Then
			io_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If io_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor			[1] = io_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Razao_Social		[1] = io_Fornecedor.Nm_Razao_Social
			Else
				io_Fornecedor.of_Inicializa()
			End If
		End If
End Choose
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_razao_social"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor			[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Razao_Social		[1] = io_Fornecedor.Nm_Razao_Social
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

String ls_Nulo

dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_razao_social"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor			[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Razao_Social		[1] = io_Fornecedor.Nm_Razao_Social
		End If
	
	Case"id_conjunto_filial"
		If Data = 'C' Then
			
			ivs_filiais = ls_Nulo
			
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				
				ivo_Filial.of_Inicializa()
			
//				dw_1.Object.cd_filial  		[1] = ivo_Filial.cd_filial
//				dw_1.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia
				
				ivs_filiais = ivo_Selecao_filiais.ivs_filiais
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge468_relatorio_diversa_cobranca_forn
integer y = 460
integer width = 3753
integer height = 1696
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio de Notas de Reembolso de Fornecedor"
string dataobject = "dw_ge468_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Nota
Long ll_Motivo

String ls_Fornecedor
String ls_Especie
String ls_Serie
String ls_Situacao

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio				[1]
ldh_Termino	= dw_1.Object.Dh_Termino			[1]
ls_Fornecedor 	= dw_1.Object.Cd_Fornecedor		[1]
ll_Nota			= dw_1.Object.Nr_Nf					[1]
ls_Especie		= dw_1.Object.De_Especie			[1]
ls_Serie			= dw_1.Object.De_Serie				[1]
ll_Motivo			= dw_1.Object.Cd_Motivo_Ajuste	[1]
ls_Situacao		= dw_1.Object.Id_Situacao			[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", StopSign!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If Not IsNull(ls_Fornecedor) And ls_Fornecedor <> "" Then
	This.of_AppendWhere("nr_cgc_cpf = '" + io_Fornecedor.Nr_CGC + "'")
End If

If ivs_Filiais <> "" Then
	This.of_AppendWhere("f.cd_filial in (" + ivs_Filiais + ")")
End If

If Not IsNull(ll_Nota) And ll_Nota > 0 Then
	This.of_AppendWhere("n.nr_nf = " + String(ll_Nota))
End If

If Not IsNull(ls_Especie) And ls_Especie <> "" Then
	This.of_AppendWhere("n.de_especie = '" + String(ls_Especie) + "'")
End If

If Not IsNull(ls_Serie) And ls_Serie <> "" Then
	This.of_AppendWhere("n.de_serie = '" + String(ls_Serie) + "'")
End If

If Not IsNull(ll_Motivo) And ll_Motivo > 0 Then
	This.of_AppendWhere("n.cd_motivo_ajuste = " + String(ll_Motivo))
End If

If ls_Situacao <> "T" Then
	If ls_Situacao = "C" Then //Canceladas
		This.of_AppendWhere("n.dh_cancelamento is not null")
	Else //N$$HEX1$$e300$$ENDHEX$$o canceladas
		This.of_AppendWhere("n.dh_cancelamento is null")
	End If
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

DateTime ldh_Inicio
DateTime ldh_Termino

dw_1.AcceptText()

ldh_Inicio	= dw_1.Object.Dh_Inicio		[1]
ldh_Termino= dw_1.Object.Dh_Termino	[1]

ldh_Inicio 	= DateTime(String(ldh_Inicio		, "dd/mm/yyyy 00:00:00"))
ldh_Termino= DateTime(String(ldh_Termino	, "dd/mm/yyyy 23:59:59"))

Return This.Retrieve(ldh_Inicio, ldh_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection( "if( (not isnull( dh_cancelamento )), rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge468_relatorio_diversa_cobranca_forn
integer x = 3945
integer y = 356
integer width = 105
integer height = 108
end type

