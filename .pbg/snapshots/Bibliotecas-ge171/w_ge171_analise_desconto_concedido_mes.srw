HA$PBExportHeader$w_ge171_analise_desconto_concedido_mes.srw
forward
global type w_ge171_analise_desconto_concedido_mes from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge171_analise_desconto_concedido_mes from dc_w_selecao_lista_relatorio
string tag = "w_ge171_analise_desconto_concedido_mes"
integer width = 3145
integer height = 1844
string title = "GE171 - An$$HEX1$$e100$$ENDHEX$$lise de Desconto Concedido no M$$HEX1$$ea00$$ENDHEX$$s"
long backcolor = 80269524
end type
global w_ge171_analise_desconto_concedido_mes w_ge171_analise_desconto_concedido_mes

type variables
dc_uo_transacao_desconto sybase
end variables

forward prototypes
public function boolean wf_conecta_banco ()
end prototypes

public function boolean wf_conecta_banco ();Sybase.ivs_DataBase = 'SYBASE'

If Not Sybase.of_Connect('central', 'CO') Then Return False

Return True
end function

on w_ge171_analise_desconto_concedido_mes.create
call super::create
end on

on w_ge171_analise_desconto_concedido_mes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_inicio[1] = gf_Primeiro_Dia_Mes(Date(gvo_Parametro.of_DH_Movimentacao()))

Sybase = Create dc_uo_transacao_desconto

If Not wf_Conecta_Banco() Then
	Close(This)
End If

This.ivm_Menu.ivb_Permite_Imprimir = True









end event

event close;call super::close;Sybase.of_Disconnect( )
Destroy(Sybase)
end event

event ue_preopen;call super::ue_preopen;ivb_permite_fechar = False
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge171_analise_desconto_concedido_mes
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge171_analise_desconto_concedido_mes
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge171_analise_desconto_concedido_mes
integer x = 18
integer y = 184
integer width = 3067
integer height = 1456
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge171_analise_desconto_concedido_mes
integer x = 23
integer y = 8
integer width = 622
integer height = 168
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge171_analise_desconto_concedido_mes
integer x = 46
integer y = 60
integer width = 581
integer height = 100
string dataobject = "dw_ge171_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge171_analise_desconto_concedido_mes
integer x = 50
integer y = 228
integer width = 3008
integer height = 1388
string dataobject = "dw_ge171_lista"
end type

event dw_2::ue_recuperar;// OverRide

DateTime lvdt_Inicio,&
	 	 lvdt_Termino
		  
Long lvl_Linhas

dw_1.AcceptText()

lvdt_Inicio		= DateTime(dw_1.Object.dh_inicio[1])
lvdt_Termino	= DateTime(gf_Calcula_Ultimo_Dia_Mes(Month(Date(lvdt_Inicio)), Year(Date(lvdt_Inicio))))

//lvdt_Termino = DateTime(Date("01/06/2009"))

dw_2.of_SetTransObject(sybase)

Open(w_aguarde)
w_aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es... Aguarde...'
lvl_Linhas = dw_2.Retrieve(lvdt_Inicio, lvdt_Termino)
Close(w_aguarde)

Return lvl_Linhas

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge171_analise_desconto_concedido_mes
integer x = 2528
integer y = 0
integer height = 204
integer taborder = 50
string dataobject = "dw_ge171_relatorio"
end type

