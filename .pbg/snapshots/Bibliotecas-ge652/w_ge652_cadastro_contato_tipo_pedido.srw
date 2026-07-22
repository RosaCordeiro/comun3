HA$PBExportHeader$w_ge652_cadastro_contato_tipo_pedido.srw
forward
global type w_ge652_cadastro_contato_tipo_pedido from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge652_cadastro_contato_tipo_pedido from dc_w_cadastro_selecao_lista
integer width = 1833
string title = "Contatos por Tipo de Pedido de Distribuidora"
end type
global w_ge652_cadastro_contato_tipo_pedido w_ge652_cadastro_contato_tipo_pedido

type variables
uo_usuario	iuo_usuario
end variables

forward prototypes
public function boolean wf_filtra_tipos ()
end prototypes

public function boolean wf_filtra_tipos ();DataWindowChild	ldwc_Tipos
Long					ll_Linha, &
						ll_Linhas

If dw_1.GetChild ('id_tipo', ldwc_Tipos) <> 1 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na obten$$HEX2$$e700e300$$ENDHEX$$o da lista de tipos de pedido!', StopSign!)
	Return False
End if

//ll_Linhas = ldwc_Tipos.RowCount ()
ldwc_Tipos.SetFilter ("id_devolucao = 'S'")
ldwc_Tipos.Filter ()

Return True
end function

on w_ge652_cadastro_contato_tipo_pedido.create
call super::create
end on

on w_ge652_cadastro_contato_tipo_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;If IsValid (iuo_usuario) then Destroy iuo_usuario
end event

event ue_postopen;call super::ue_postopen;If not wf_filtra_tipos () then
	Post Close (This)
	Return
End if

iuo_usuario = Create uo_usuario

ivm_Menu.mf_incluir (False)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge652_cadastro_contato_tipo_pedido
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge652_cadastro_contato_tipo_pedido
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge652_cadastro_contato_tipo_pedido
integer width = 1381
string dataobject = "dw_ge652_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Reset ()
ivm_Menu.mf_incluir (True)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge652_cadastro_contato_tipo_pedido
integer width = 1737
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge652_cadastro_contato_tipo_pedido
integer width = 1449
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge652_cadastro_contato_tipo_pedido
integer width = 1641
string dataobject = "dw_ge652_lista"
end type

event dw_2::itemchanged;call super::itemchanged;String	ls_Nulo

SetNull(ls_Nulo)

Choose case  dwo.Name 
	Case 'nm_usuario'
		If data = '' or IsNull (data) then
			This.Object.nr_matricula [row] = ls_Nulo
		else
			If data <> iuo_usuario.nm_usuario then Return 1
		End if
		
End choose
end event

event dw_2::ue_addrow;call super::ue_addrow;long ll_Linha

ll_Linha = This.GetRow ()

This.Object.id_tipo [ll_Linha] = dw_1.Object.id_tipo [1]

Return ll_Linha
end event

event dw_2::ue_key;call super::ue_key;Long		ll_Linha
String	ls_Usuario
		
If Key = KeyEnter! then
	If This.GetColumnName () = 'nm_usuario' then
		ll_Linha = This.GetRow ()
		
		ls_Usuario = This.GetText ()
		
		iuo_usuario.of_localiza_usuario (ls_Usuario)
		
		// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio foi localizado e atualiza a DW
		If iuo_usuario.Localizado then
			If iuo_usuario.id_situacao <> 'A' then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A situa$$HEX2$$e700e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ATIVA!', Exclamation!)
				Return
			End if
			
			If This.Find ("nr_matricula = '" + iuo_usuario.nr_matricula + "' and GetRow () <> " + String (ll_Linha), 1, This.RowCount ()) > 0 then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O usu$$HEX1$$e100$$ENDHEX$$rio j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado para este tipo de pedido!', Exclamation!)
				Return
			End if
			
			This.Object.nr_matricula [ll_Linha] = iuo_usuario.nr_matricula
			This.Object.nm_usuario   [ll_Linha] = iuo_usuario.nm_usuario
		else
		
			SetNull (iuo_usuario.nr_matricula)
			iuo_usuario.nm_usuario = ''
			
			This.Object.nr_matricula [ll_Linha] = iuo_usuario.nr_matricula
			This.Object.nm_usuario   [ll_Linha] = iuo_usuario.nm_usuario
			
		End if
	End if
End if
end event

event dw_2::ue_recuperar;//Override

String	ls_Tipo

This.Reset ()

dw_1.AcceptText ()

ls_Tipo = dw_1.Object.id_tipo [1]

Return This.Retrieve (ls_Tipo)
end event

