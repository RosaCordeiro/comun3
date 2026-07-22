HA$PBExportHeader$w_ge567_historio_endereco.srw
forward
global type w_ge567_historio_endereco from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge567_historio_endereco from dc_w_selecao_lista_relatorio
integer width = 3826
integer height = 2172
string title = "GE567 - Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o de Endere$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge567_historio_endereco w_ge567_historio_endereco

type variables
uo_produto				io_Produto
end variables

forward prototypes
public subroutine _documentacao ()
end prototypes

public subroutine _documentacao ();
end subroutine

on w_ge567_historio_endereco.create
call super::create
end on

on w_ge567_historio_endereco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Inicio	[1] = Today()
dw_1.Object.Dt_Fim	[1] = Today()
end event

event close;call super::close;Destroy(io_Produto)
end event

event ue_preopen;call super::ue_preopen;io_produto = Create uo_produto
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge567_historio_endereco
integer x = 37
integer y = 608
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge567_historio_endereco
integer x = 0
integer y = 536
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge567_historio_endereco
integer y = 320
integer width = 3712
integer height = 1640
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge567_historio_endereco
integer width = 2030
integer height = 288
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge567_historio_endereco
integer width = 1952
integer height = 204
string dataobject = "dw_ge567_filtro_historico"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			
			io_Produto.of_Localiza_Produto(This.GetText())
						
			If io_Produto.Localizado Then				
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
				
				//dw_2.Event ue_Retrieve()
			Else
				io_Produto.of_Inicializa()
			End If
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge567_historio_endereco
integer y = 388
integer width = 3643
integer height = 1532
string dataobject = "dw_ge567_lista_historico"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date ldt_Inicio
Date ldt_Fim

Long ll_Produto

dw_1.AcceptText()

ldt_Inicio		= dw_1.Object.Dt_Inicio		[1]
ldt_Fim		= dw_1.Object.Dt_Fim		[1]
ll_Produto	= dw_1.Object.Cd_Produto	[1]

If IsNull(ldt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ldt_Fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de fim.")
	dw_1.Event ue_Pos(1, "dt_fim")
	Return -1
End If

If ldt_Inicio > ldt_Fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data de fim.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere("a.cd_produto = " + String(ll_Produto))
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

DateTime ldh_Inicio
DateTime ldh_Fim

dw_1.AcceptText()

ldh_Inicio= Datetime(dw_1.Object.Dt_Inicio	[1], Time('00:00:00'))
ldh_Fim	= Datetime(dw_1.Object.Dt_Fim	[1], Time('23:59:59'))

Return This.Retrieve(ldh_Inicio, ldh_Fim)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge567_historio_endereco
integer x = 1614
integer y = 860
end type

