HA$PBExportHeader$w_ge107_cadastro_estoque_outras_filiais.srw
forward
global type w_ge107_cadastro_estoque_outras_filiais from dc_w_cadastro_lista
end type
end forward

global type w_ge107_cadastro_estoque_outras_filiais from dc_w_cadastro_lista
string accessiblename = "Cadastro de Ordem de Exibi$$HEX2$$e700e300$$ENDHEX$$o das Filiais na Consulta de Estoque (GE107)"
integer width = 3026
integer height = 1976
string title = "GE107 - Cadastro de Ordem de Exibi$$HEX2$$e700e300$$ENDHEX$$o das Filiais na Consulta de Estoque"
end type
global w_ge107_cadastro_estoque_outras_filiais w_ge107_cadastro_estoque_outras_filiais

on w_ge107_cadastro_estoque_outras_filiais.create
call super::create
end on

on w_ge107_cadastro_estoque_outras_filiais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso." )
	Close( This )
	Return 1
End If
end event

event ue_postopen;call super::ue_postopen;//ivm_menu.ivb_permite_excluir = False
//ivm_menu.ivb_permite_incluir = False

dw_1.ivo_Controle_Menu.of_excluir( False)
dw_1.ivo_Controle_Menu.of_Incluir( False)
dw_1.ivo_Controle_Menu.of_Recuperar( False)
end event

event ue_cancel;call super::ue_cancel;dw_1.ivo_Controle_Menu.of_excluir( False)
dw_1.ivo_Controle_Menu.of_Incluir( False)
dw_1.ivo_Controle_Menu.of_Recuperar( False)
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge107_cadastro_estoque_outras_filiais
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge107_cadastro_estoque_outras_filiais
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge107_cadastro_estoque_outras_filiais
integer x = 55
integer y = 56
integer width = 2839
integer height = 1668
string dataobject = "dw_ge107_cadastro_lista"
end type

event dw_1::constructor;call super::constructor;String lvs_Coluna[]
String lvs_Nome[]

This.of_SetRowSelection( )

This.ivb_Ordena_colunas = True

lvs_Coluna = {"cd_filial_destino", "nm_fantasia", "nm_cidade" }

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo Filial", "Nome Fantasia", "Nome da Cidade" }

This.of_SetFilter(lvs_Coluna, lvs_Nome)		 

end event

event dw_1::ue_recuperar;//OverRide
Return This.Retrieve( gvo_Parametro.ivs_uf_filial )
end event

event dw_1::editchanged;call super::editchanged;Parent.ivb_Valida_Salva = True
end event

event dw_1::itemchanged;call super::itemchanged;Parent.ivb_Valida_Salva = True
end event

event dw_1::ue_update;call super::ue_update;Long ll_Linha
Long ll_Linhas
Long ll_Ordem_Original
Long ll_Ordem_Nova
Long ll_Filial_Destino

dw_1.AcceptText( )

ll_Linhas = dw_1.RowCount( )

For ll_Linha = 1 To ll_Linhas
	ll_Ordem_Nova 	= dw_1.Object.Nr_Ordem				[ ll_Linha ]
	ll_Ordem_Original = dw_1.Object.Nr_Ordem_Original	[ ll_Linha ]
	ll_Filial_Destino		= dw_1.Object.Cd_Filial_Destino		[ ll_Linha ]
	
	If ll_Ordem_Nova <> ll_Ordem_Original Then
		
		SELECT nr_ordem
		INTO :ll_Ordem_Original
		FROM estoque_outras_filiais_ordenacao
		WHERE cd_filial			= dbo.uf_filial_parametro( )
		AND cd_filial_destino	= :ll_Filial_Destino
		USING SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_Rollback( )
				SqlCa.of_MsgDbError( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da ordena$$HEX2$$e700e300$$ENDHEX$$o de consulta de estoque de outras filiais" )
				Return -1
				
			Case 0
				UPDATE estoque_outras_filiais_ordenacao
				SET nr_ordem = :ll_Ordem_Nova
				WHERE cd_filial			= dbo.uf_filial_parametro( )
				AND cd_filial_destino	= :ll_Filial_Destino
				USING SqlCa;
				
			Case 100
				INSERT INTO estoque_outras_filiais_ordenacao (cd_filial, cd_filial_destino, nr_ordem )
				VALUES ( dbo.uf_filial_parametro( ), :ll_Filial_Destino, :ll_Ordem_Nova )
				USING SqlCa;	
		End Choose
		
		// Testa o insert/update
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback( )
			SqlCa.of_MsgDbError( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da ordena$$HEX2$$e700e300$$ENDHEX$$o de consulta de estoque de outras filiais" )
			Return -1
		End If		
	End If	
Next

Return 1
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge107_cadastro_estoque_outras_filiais
integer width = 2912
integer height = 1748
end type

