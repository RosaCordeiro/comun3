HA$PBExportHeader$uo_ge255_pedido_almoxarifado.sru
forward
global type uo_ge255_pedido_almoxarifado from nonvisualobject
end type
end forward

global type uo_ge255_pedido_almoxarifado from nonvisualobject
end type
global uo_ge255_pedido_almoxarifado uo_ge255_pedido_almoxarifado

type variables
dc_uo_transacao itr_filial

dc_uo_ds_base ids_Filial

dc_uo_odbc io_odbc

uo_smtp io_smtp
end variables

forward prototypes
public subroutine of_envia_email (long pl_filial, string ps_mensagem)
public function boolean of_importa_itens (long pl_filial, ref string ps_mensagem)
public function boolean of_importa_cabecalho (long pl_filial, ref long pl_linhas, ref string ps_mensagem)
public function boolean of_busca_pedidos (long pl_filial, ref string ps_mensagem)
public function boolean of_conecta_filial (long pl_filial, ref string ps_erro)
end prototypes

public subroutine of_envia_email (long pl_filial, string ps_mensagem);String ls_Assunto

ls_Assunto = "Pedido Almoxarifado - Filial " + String(pl_Filial)

gf_ge202_envia_email_automatico( 15, ls_Assunto, ps_Mensagem, {''} )                                                   
end subroutine

public function boolean of_importa_itens (long pl_filial, ref string ps_mensagem);Boolean lb_Sucesso = True

Long ll_Linha_Filial
Long ll_Row
Long ll_Pedido
Long ll_Produto
Long ll_qtPedida

String ls_Chave

Decimal ldc_Custo
Decimal ldc_Total_Pedido

Try

	ids_Filial.Reset()
	ids_Filial.of_ChangeDataObject( "ds_ge255_itens_filial" )
	ll_Linha_Filial = ids_Filial.Retrieve( )
		
	Choose Case ll_Linha_Filial
		Case 0 
			//N$$HEX1$$e300$$ENDHEX$$o existe pedidos com a situacao 'C' na filial - Continua o processo sem importar os itens
		Case -1
			ps_Mensagem = "Erro no Retrieve na filial " + String ( pl_Filial )
			lb_Sucesso = False
					
		Case is > 0  //Tem pedidos - exporta p/ matriz
			
			For ll_Row = 1 To ll_Linha_Filial
				
				ldc_Custo			= 0.00
				ls_Chave		 	= ""
				
				ll_Pedido 			= ids_Filial.Object.nr_pedido					[ ll_Row ]
				ll_Produto			= ids_Filial.Object.cd_produto				[ ll_Row ]
				ll_qtPedida			= ids_Filial.Object.qt_pedida					[ ll_Row ]
				
				ls_Chave			= "(" + String(pl_Filial) + " - " + String(ll_Pedido) + " - " + String( ll_Produto ) + ")"
				
				Select vl_custo_medio 
				Into :ldc_Custo
				From vw_saldo_atual_produto
				Where cd_filial = 534
				    and cd_produto = :ll_Produto
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0
						If IsNull(ldc_Custo) Then ldc_Custo = 0
					Case 100
						ldc_Custo = 0
					Case -1
						ps_Mensagem = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Custo do Produto: " + String(ll_Produto, "000000") + " - " + SqlCa.SqlErrText
						lb_Sucesso = False
						Exit
				End Choose

				Insert pedido_almoxarifado_produto(
					cd_filial,
					nr_pedido,
					cd_produto,
					qt_pedida,
					qt_atendida,
					qt_separada,
					qt_faturada,
					vl_custo_unitario)
				Values(:pl_Filial,
					:ll_Pedido,
					:ll_Produto,
					:ll_qtPedida,
					:ll_qtPedida,
					0,
					0,
					:ldc_Custo)
				Using SqlCa;
					
				If SqlCa.SqlCode = -1 Then
					ps_Mensagem = "Erro no insert tb pedido_almoxarifado_produto. Chave:" + ls_Chave + " - " + SqlCa.SqlErrText
					lb_Sucesso = False
					Exit
				Else
				
					ldc_Total_Pedido = ldc_Total_Pedido + Round(ll_qtPedida * ldc_Custo, 2)
						
					// Se for o $$HEX1$$fa00$$ENDHEX$$ltimo produto do pedido atualiza o cabe$$HEX1$$e700$$ENDHEX$$alho
					If ll_Row = ll_Linha_Filial Then
												
						Update pedido_almoxarifado
						Set vl_total_pedido =:ldc_Total_Pedido
						Where cd_filial 		=:pl_Filial
							 and nr_pedido 	=:ll_Pedido
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							ps_Mensagem = "Erro na atualizacao valor pedido tb pedido_almoxarifado. Chave:" + "(" +  String(pl_Filial, "0000") + "-" + String(ll_Pedido, "0000000") + ") "
							lb_Sucesso = False
						End If
						
					End If
					
				End If		
								
			Next
						
	End Choose
	
Finally
	Return lb_Sucesso
End Try
end function

public function boolean of_importa_cabecalho (long pl_filial, ref long pl_linhas, ref string ps_mensagem);Long ll_Linha_Filial, ll_Row

Boolean lb_Sucesso = True

Long ll_Filial, ll_Pedido
String ls_Situacao, ls_Matricula_Cancelamento, ls_Matricula_Cadastramento, ls_Chave
Datetime ldh_Emissao, ldh_Cancelamento

Try
	
	ids_Filial.Reset()
	
	ids_Filial.of_ChangeDataObject( "ds_ge255_pedidos" )
	ll_Linha_Filial = ids_Filial.Retrieve( )
		
	Choose Case ll_Linha_Filial
		Case 0 
			//N$$HEX1$$e300$$ENDHEX$$o existe pedidos com a situacao 'C' na filial - Continua o processo sem importar os itens
			ps_Mensagem = "Nenhum pedido do almoxarifado para ser exportado"
			lb_Sucesso = False
		Case -1
			ps_Mensagem = "Erro no Retrieve na filial " + String ( pl_Filial )
			lb_Sucesso 	= False
			
		Case is > 0  //Se tem pedidos - exporta p/ matriz
			
			For ll_Row = 1 To ll_Linha_Filial
							
				ll_Filial 									= ids_Filial.Object.cd_filial									[ ll_Row ] 
				ll_Pedido 								= ids_Filial.Object.nr_pedido 							[ ll_Row ] 
				ldh_Emissao 							= ids_Filial.Object.dh_emissao 							[ ll_Row ] 
							
				ls_Chave = "(" + String(ll_Filial) + " - " + String(ll_Pedido) + " - " + String(ldh_Emissao) + ")"
							
				Insert into pedido_almoxarifado(
							cd_filial,   
        						nr_pedido,   
							dh_emissao,  
							id_situacao,
							vl_total_pedido)
				  Values(:ll_filial,
        						:ll_Pedido,
							:ldh_Emissao,  
							'C',   
							0) // S$$HEX1$$f300$$ENDHEX$$ exporta para a matriz os pedidos colocados
				using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ps_Mensagem = "Erro no insert tb pedido_almoxarifado. Chave: " + ls_Chave + " - " + SqlCa.SqlErrText
					lb_Sucesso = False
					Exit
				End If
			
			Next		
				
	End Choose
	
Finally
	pl_Linhas = ll_Linha_Filial
	Return lb_Sucesso
End Try
end function

public function boolean of_busca_pedidos (long pl_filial, ref string ps_mensagem);Boolean lb_Sucesso 		= False

Long ll_Linhas_Pedido

String ls_Mensagem

Try	
	
	If of_importa_cabecalho(pl_Filial, Ref ll_Linhas_Pedido, Ref ps_Mensagem) Then
		
		If of_Importa_itens(pl_Filial, Ref ps_Mensagem) Then
			
			lb_Sucesso = True
			
		End If
		
	End If

	If lb_Sucesso Then
		SqlCa.of_Commit();
		
		update pedido_almoxarifado
			set id_situacao = 'E', dh_exportacao = getdate()
		 where id_situacao = 'C'
		 Using itr_filial;
	
		If SqlCa.SqlCode = -1 Then
			ps_Mensagem = "Foi gravado na matriz o total de " + String(ll_Linhas_Pedido) + " pedido(s), por$$HEX1$$e900$$ENDHEX$$m, ocorreu um erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do(s) pedido(s) de 'C' para 'E' na filial: " + String(pl_Filial) + " . " + SqlCa.SqlErrText
			itr_filial.of_Rollback();
		ElseIf SqlCa.SqlCode = 0 Then
			itr_filial.of_Commit();
		End If
		
	Else
		If ll_Linhas_Pedido > 0 Then SqlCa.of_Rollback();
	End If
	
	//Envia Email - Erros
	//If Trim(ps_mensagem) <> "" And Not IsNull(ps_mensagem) And upper(ps_mensagem) <> "NENHUM PEDIDO DO ALMOXARIFADO PARA SER EXPORTADO" Then of_Envia_Email(pl_Filial, ps_mensagem)

Finally
	Return lb_Sucesso
End Try


end function

public function boolean of_conecta_filial (long pl_filial, ref string ps_erro);String	ls_Odbc, &
		ls_Erro

ls_Odbc = String( pl_Filial, '0000' )

//Desenvolvimento
//ls_Odbc = "0000_loja"

If itr_Filial.of_isConnected() Then itr_Filial.of_Disconnect()
	
If Not io_Odbc.of_Localiza_Parametro_Odbc( pl_Filial, ref ps_Erro ) Then
	ps_Erro += " - Filial: " + ls_Odbc
	gvo_Aplicacao.of_Grava_Log( ps_Erro )
	Return False
End If

If Not io_Odbc.of_Connect( ls_Odbc, 'dbo', 'teste') Then
	ps_Erro = "Erro ao se conectar com a filial de destino: " + ls_Odbc
	gvo_Aplicacao.of_Grava_Log( ps_Erro )
	Return False
End If
	
If Not itr_Filial.of_Connect( ls_Odbc, 'TRANSF' ) Then
	itr_Filial.of_LogDbError( gvo_Aplicacao.ivi_Log )
	Return False
End If

ids_Filial.of_SetTransObject(itr_Filial)
		
Return True

end function

on uo_ge255_pedido_almoxarifado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge255_pedido_almoxarifado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_Filial	 				= Create dc_uo_ds_base
io_odbc					= Create dc_uo_odbc
io_smtp 				= Create uo_smtp

itr_filial = Create dc_uo_transacao
itr_filial.of_SetDataBase('anywhere')
end event

event destructor;Destroy ids_Filial
Destroy io_smtp

If itr_filial.of_isConnected() Then itr_filial.of_DisConnect()

Destroy itr_filial
Destroy io_odbc
end event

