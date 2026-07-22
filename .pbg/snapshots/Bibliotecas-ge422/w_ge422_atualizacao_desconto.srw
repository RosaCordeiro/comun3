HA$PBExportHeader$w_ge422_atualizacao_desconto.srw
forward
global type w_ge422_atualizacao_desconto from dc_w_response_ok_cancela
end type
end forward

global type w_ge422_atualizacao_desconto from dc_w_response_ok_cancela
integer width = 2597
integer height = 1452
string title = "GE422 - Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Desconto"
end type
global w_ge422_atualizacao_desconto w_ge422_atualizacao_desconto

type variables
uo_Produto io_produto
end variables

forward prototypes
public function integer wf_importa_xls ()
end prototypes

public function integer wf_importa_xls ();String ls_Nm_Arquivo
String ls_Path, ls_Barras, ls_laboratorio

Integer li_arquivo

Long ll_Row, ll_Total
Long ll_Linha_Nova
Long ll_Produto

Boolean lb_Sucesso = True

Decimal ldc_Atual, ldc_Anterior

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
				   "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo de Barras~r" +&	
                     "Coluna B = Desconto (%).~r" )

li_arquivo = GetFileOpenName("Selecione o arquivo", &
										   ls_Path, &
										   ls_Nm_Arquivo  , & 
											"XLS"           , &
     	                        			   	"Arquivo Excel (*.XLS),*.XLS")
											
									
If li_Arquivo < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao abrir o arquivo '" + ls_Nm_Arquivo + "'.")
	Return -1
End If

If li_Arquivo = 0 Then
	Return -1
End If

Try											
											
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo dados do arquivo : '" + Upper( ls_Nm_Arquivo ) + "'."
	
	dc_uo_Excel lo_Excel
	lo_Excel = Create dc_uo_Excel
	
	lo_Excel.uo_Referencia_Objeto_Excel( ls_Path )
	ll_Total = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Total )
	
	dw_1.SetRedraw( False )
	
	SetPointer(HourGlass!)
	
	For ll_Row = 1 To ll_Total
		
		w_Aguarde.uo_Progress.of_SetProgress( ll_Row )
		
		//A - Codigo Barras	
		ls_Barras = String( lo_Excel.uo_Lendo_Dados( ll_Row, "A") )
		
		io_produto.of_localiza_codigo_barras( ls_Barras )
		
		If Not io_produto.Localizado Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + ls_Barras + " n$$HEX1$$e300$$ENDHEX$$o foi localizado.~rLinha: " + String(ll_Row))
			lb_Sucesso = False
			Exit
		End If
		
	//	If io_Produto.id_Situacao <> "A" Then
	//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto com situa$$HEX2$$e700e300$$ENDHEX$$o diferente de 'ATIVO' n$$HEX1$$e300$$ENDHEX$$o pode ser selecionado.~rProduto " + String(io_Produto.cd_produto) + ".~rLinha: " +String(ll_Row))
	//		Exit
	//	End If
				
		//Leitura da coluna B - Desconto
		ldc_Atual = Dec( lo_Excel.uo_Lendo_Dados( ll_Row, "B") )
		
		ldc_Atual = Round(ldc_Atual, 2)
		
		If ldc_Atual < 0 Or ldc_Atual > 100 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto Inv$$HEX1$$e100$$ENDHEX$$lido: " + String(ldc_Atual) + ".~rLinha: " + String(ll_Row))
			lb_Sucesso = False
			Exit
		End If
		
		select f.nm_fantasia + ' (' + g.cd_fornecedor_usual + ')',
				c.pc_desconto_conexao
		Into :ls_laboratorio,
				:ldc_anterior
		from produto_geral g
			inner join produto_central c
				on c.cd_produto = g.cd_produto
			inner join fornecedor f
				on f.cd_fornecedor = g.cd_fornecedor_usual
		where g.cd_produto = :io_produto.cd_produto
		Using SqlCa;
			
		Choose Case SqlCa.SqlCode
			Case -1 
				SqlCa.of_MsgDBError("Erro ao localizar o fornecedor usual do produto: " + String(io_produto.cd_produto) + ".~rLinha: " + String(ll_Row) + "." + SqlCa.SqlErrText)
				lb_Sucesso = False
				Exit
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi localizado o fornecedor do produto: " + String(io_produto.cd_produto) )
				lb_Sucesso = False
				Exit
		End Choose
		
		//If ldc_Atual = ldc_anterior Then Continue
		
		Update produto_central
			Set pc_desconto_conexao = :ldc_atual
			where cd_produto = :io_produto.cd_produto
		Using SqlCa;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDBError("Erro no update pc_desconto_conexao, produto: " + String(io_produto.cd_produto) + ".~rLinha: " + String(ll_Row) + "." + SqlCa.SqlErrText )
			SqlCa.of_Rollback()
			lb_Sucesso = False
			Exit
		Else
			SqlCa.of_Commit()
		End If
				
		ll_Linha_Nova = dw_1.Event ue_AddRow()
		
		dw_1.Object.cd_Produto					[ ll_Linha_Nova ] = io_Produto.cd_produto
		dw_1.Object.de_Produto  				[ ll_Linha_Nova ] = io_Produto.de_produto + " : " + io_Produto.De_Apresentacao_Estoque
		dw_1.Object.nm_fantasia				[ ll_Linha_Nova ] = ls_laboratorio
		dw_1.Object.pc_desconto_anterior	[ ll_Linha_Nova ] = ldc_Anterior
		dw_1.Object.pc_desconto_atual		[ ll_Linha_Nova ] = ldc_Atual
				
		Yield()	 
			 
	Next
	
	If Not lb_Sucesso Then Return -1
	
	dw_1.Event ue_Pos( ll_Linha_Nova, "cd_produto" )
	
	dw_1.SetRedraw( True )
	
	dw_1.setSort( "nm_fantasia a, cd_Produto a" )
	dw_1.Sort()
	
	dw_1.of_SetRowSelection()
	
	SetPointer(Arrow!)
	
Finally
	Destroy( lo_Excel )
	Close( w_Aguarde )
End Try
end function

on w_ge422_atualizacao_desconto.create
call super::create
end on

on w_ge422_atualizacao_desconto.destroy
call super::destroy
end on

event ue_postopen;//OverRide
io_produto = Create uo_Produto

If wf_importa_xls() = -1 Then CloseWithReturn(This, "")
end event

event close;call super::close;If IsValid(io_produto) Then Destroy io_produto
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge422_atualizacao_desconto
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge422_atualizacao_desconto
integer width = 2537
integer height = 1228
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge422_atualizacao_desconto
integer width = 2478
integer height = 1132
string dataobject = "dw_ge422_lista_desconto_novo"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge422_atualizacao_desconto
integer x = 2254
integer y = 1252
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge422_atualizacao_desconto
boolean visible = false
integer x = 1609
integer y = 1252
end type

