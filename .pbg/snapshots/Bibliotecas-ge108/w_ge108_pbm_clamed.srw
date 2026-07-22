HA$PBExportHeader$w_ge108_pbm_clamed.srw
forward
global type w_ge108_pbm_clamed from dc_w_response_ok_cancela
end type
end forward

global type w_ge108_pbm_clamed from dc_w_response_ok_cancela
integer width = 3319
integer height = 1348
string title = "GE108 - Concluir PBM Clamed"
end type
global w_ge108_pbm_clamed w_ge108_pbm_clamed

type variables
dc_uo_ds_base ids_Produtos

uo_ge108_parametros io_parametro
end variables

forward prototypes
public function boolean wf_verifica_informacoes_receita ()
public function boolean wf_atualiza_cliente_caixa_prd ()
public function boolean wf_carrega_produtos ()
end prototypes

public function boolean wf_verifica_informacoes_receita ();Long ll_Linhas, ll_Row

String ls_Registro, ls_UF, ls_Id_Registro, ls_Receita

Try	
	dw_1.AcceptText()
	
	ll_Linhas = dw_1.RowCount()
	
	For ll_Row = 1 TO ll_Linhas
		ls_Receita = dw_1.Object.id_com_receita[ ll_Row ]
		
		If ls_Receita = "N" Then Continue
		
		ls_Id_Registro 	= dw_1.Object.id_registro_prescritor	[ ll_Row ]
		ls_Registro 		= dw_1.Object.nr_registro_prescritor	[ ll_Row ]
		ls_UF				= dw_1.Object.cd_uf_prescritor		[ ll_Row ]
		
		If IsNull( ls_Id_Registro ) Or Trim(ls_Id_Registro) = "" Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o tipo de registro.", Exclamation!)
			dw_1.Event ue_Pos( ll_Row,"id_registro_prescritor" ) 
			Return False
		End If
		
		If IsNull( ls_Registro ) Or Trim(ls_Registro) = "" Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o n$$HEX1$$fa00$$ENDHEX$$mero do registro.", Exclamation!)
			dw_1.Event ue_Pos( ll_Row,"nr_registro_prescritor" ) 
			Return False
		End If
		
		If long(ls_Registro) <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero de registro inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
			dw_1.Event ue_Pos( ll_Row,"nr_registro_prescritor" ) 
			Return False
		End If		
		
		If IsNull( ls_UF ) Or Trim(ls_UF) = "" Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o Estado.", Exclamation!)
			dw_1.Event ue_Pos( ll_Row,"cd_uf_prescritor" ) 
			Return False
		End If
		
	Next
	
	Return True
	
Finally
	//
End Try

end function

public function boolean wf_atualiza_cliente_caixa_prd ();Long ll_Row, ll_Linhas
Long ll_Sequencial, ll_Seq_Cliente_Caixa

String ls_Registro, ls_UF, ls_Id_Registro, ls_Receita

Try
	dw_1.AcceptText()
	
	ll_Linhas = dw_1.RowCount()
	
	If ll_Linhas = 0 Then 
		Return False
	End If
	
	For ll_Row = 1 TO ll_Linhas				
		ls_Id_Registro 			= dw_1.Object.id_registro_prescritor			[ ll_Row ]
		ls_Registro 				= dw_1.Object.nr_registro_prescritor			[ ll_Row ]
		ls_UF						= dw_1.Object.cd_uf_prescritor				[ ll_Row ]
		ll_Seq_Cliente_Caixa 	= dw_1.Object.nr_sequencial_cliente_caixa	[ ll_Row ]
		ll_Sequencial			= dw_1.Object.nr_Sequencial					[ ll_Row ]
		
		Update cliente_caixa_produto
			set id_registro_prescritor 	= :ls_Id_Registro,
				 nr_registro_prescritor 	= :ls_Registro,
				 cd_uf_prescritor			= :ls_UF,
				 id_pbm_clamed			= 'S'
		Where cd_filial 								= :gvo_Parametro.Cd_Filial
			and nr_sequencial_cliente_caixa 	= :ll_Seq_Cliente_Caixa
			and nr_sequencial						= :ll_Sequencial
		Using SqlCa;
		
		If SqLCa.SqlCode = -1 Then
			SqlCa.of_Rollback( )
			SqlCa.of_MsgDbError( "Erro ao atualizar as informa$$HEX2$$e700f500$$ENDHEX$$es na cliente caixa produto. wf_atualiza_cliente_caixa_prd( )" )
			Return False
		End If
	Next	
	
	SqlCa.of_Commit( )
	
	Return True	
Finally	
	
End Try
end function

public function boolean wf_carrega_produtos ();Long ll_Row, ll_Linhas, ll_Insert, ll_Produto

Try
	dw_1.Reset()
	
	ll_Linhas = ids_Produtos.RowCount()
	
	For ll_Row = 1  To ll_Linhas
		ll_Produto = ids_Produtos.Object.cd_produto	[ ll_Row ]
		
		If IsNull( ll_Produto ) Then Continue
		
		ll_Insert = dw_1.InsertRow(0)
		
		dw_1.Object.cd_filial								[ ll_Insert ] = ids_Produtos.Object.cd_filial								[ ll_Row ]
		dw_1.Object.nr_sequencial_cliente_caixa	[ ll_Insert ] = ids_Produtos.Object.nr_sequencial_cliente_caixa		[ ll_Row ]
		dw_1.Object.nr_sequencial						[ ll_Insert ] = ids_Produtos.Object.nr_sequencial						[ ll_Row ]
		dw_1.Object.cd_produto							[ ll_Insert ] = ll_Produto
		dw_1.Object.de_produto							[ ll_Insert ] = ids_Produtos.Object.de_produto							[ ll_Row ]
		dw_1.Object.qt_produto							[ ll_Insert ] = ids_Produtos.Object.qt_produto							[ ll_Row ]
		
		dw_1.Object.id_com_receita					[ ll_Insert ] 	= ids_Produtos.Object.id_com_receita					[ ll_Row ]
		dw_1.Object.id_registro_prescritor			[ ll_Insert ] 	= ids_Produtos.Object.id_registro_prescritor			[ ll_Row ]
		dw_1.Object.nr_registro_prescritor			[ ll_Insert ] 	= ids_Produtos.Object.nr_registro_prescritor			[ ll_Row ]
		dw_1.Object.cd_uf_prescritor					[ ll_Insert ] 	= ids_Produtos.Object.cd_uf_prescritor					[ ll_Row ]
				
	Next

Catch ( RuntimeError e )	
	MessageBox("Erro", e.GetMessage() )
	
Finally
	Return True
End Try
end function

on w_ge108_pbm_clamed.create
call super::create
end on

on w_ge108_pbm_clamed.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;ids_Produtos = Create dc_uo_Ds_Base
ids_Produtos.of_ChangeDataObject("dw_ge108_lista_produtos_pbm_clamed")

ids_Produtos = Message.PowerObjectParm
			
end event

event ue_postopen;call super::ue_postopen;io_parametro = Create uo_ge108_parametros

io_parametro.ids.of_changeDataObject("dw_ge108_lista_produtos_pbm_clamed")

wf_carrega_produtos()
end event

event close;call super::close;If IsValid( ids_Produtos ) Then Destroy ids_Produtos
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_pbm_clamed
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_pbm_clamed
integer width = 3264
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_pbm_clamed
integer y = 60
integer width = 3205
integer height = 1048
string dataobject = "dw_ge108_lista_produtos_pbm_clamed"
boolean vscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;String ls_Null

If dwo.Name = "id_com_receita" Then
	If Data = "N" Then
		SetNull( ls_Null )
		dw_1.Object.id_registro_prescritor 	[ row ] = ls_Null
		dw_1.Object.nr_registro_prescritor 	[ row ] = ls_Null
		dw_1.Object.cd_uf_prescritor			[ row ] = ls_Null
		
		dw_1.AcceptText()
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_pbm_clamed
integer x = 2642
integer y = 1148
end type

event cb_ok::clicked;call super::clicked;Integer li_Retorno

If Not wf_verifica_informacoes_receita( ) Then Return -1

If Not wf_Atualiza_Cliente_Caixa_Prd( ) Then Return -1

//Vai a dw_2 atendimento
li_Retorno = dw_1.RowsCopy(1, dw_1.RowCount(), Primary!, io_parametro.ids, 1, Primary!)

If li_Retorno < 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na fun$$HEX2$$e700e300$$ENDHEX$$o RowsCopy." )
	Return -1
End If

io_parametro.Retorno = "OK"

CloseWithReturn( Parent, io_parametro )


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_pbm_clamed
integer x = 2976
integer y = 1148
end type

event cb_cancelar::clicked;SetNull( io_parametro.Retorno )

CloseWithReturn( Parent, io_parametro )

end event

