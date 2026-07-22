HA$PBExportHeader$w_ge618_preco_referencia_filial.srw
forward
global type w_ge618_preco_referencia_filial from dc_w_cadastro_freeform
end type
type cb_1 from commandbutton within w_ge618_preco_referencia_filial
end type
end forward

global type w_ge618_preco_referencia_filial from dc_w_cadastro_freeform
string tag = "w_ge618_preco_referencia_filial"
integer width = 2409
integer height = 1088
string title = "GE618 - Pre$$HEX1$$e700$$ENDHEX$$os de Refer$$HEX1$$ea00$$ENDHEX$$ncia Filial"
cb_1 cb_1
end type
global w_ge618_preco_referencia_filial w_ge618_preco_referencia_filial

type variables
Boolean ivb_check
end variables

forward prototypes
public function boolean wf_apaga_dados_filial (long al_filial)
public subroutine wf_verifica_situacao ()
end prototypes

public function boolean wf_apaga_dados_filial (long al_filial);String lvs_Msg

Delete From preco_venda_filial
Where cd_filial=:al_filial 
Using SqlCa;
						
If SqlCa.SqlCode = -1 Then
	lvs_Msg = "Erro ao excluir os registros da tabela PRECO_VENDA_FILIAL. " + SQLCA.SQLErrText + "."
	SqlCa.of_Rollback();
	gvo_Aplicacao.of_Grava_Log(lvs_Msg +"Opera$$HEX2$$e700e300$$ENDHEX$$o da Tela.")
	Return False
Else
	gvo_Aplicacao.of_Grava_Log("Executado::Exclusao:: Pre$$HEX1$$e700$$ENDHEX$$o de Venda Filial: Tela.")
End If 	

Return True 
end function

public subroutine wf_verifica_situacao ();
end subroutine

on w_ge618_preco_referencia_filial.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge618_preco_referencia_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Retrieve()
String ls_Operador


If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("w_ge618_preco_referencia_filial", ref ls_Operador) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o liberado, Solicitar o Acesso!")
	Return
End If


end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge618_preco_referencia_filial
integer x = 206
integer y = 1576
integer width = 384
boolean enabled = false
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge618_preco_referencia_filial
integer x = 187
integer y = 1508
integer width = 443
boolean enabled = false
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge618_preco_referencia_filial
integer x = 37
integer y = 44
integer width = 2299
integer height = 732
string dataobject = "ds_ge618_lista_filial"
end type

event dw_1::doubleclicked;call super::doubleclicked;If dwo.Name = 'id_imagem' Then
	dw_1.accepttext( )
	Long ll_Row	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True 
	End If
	
	For ll_Row = 1 To This.RowCount()				
		dw_1.object.id_filial_seleciona[ll_Row] = lvs_Marcacao		
	Next	
	
End If
end event

event dw_1::constructor;call super::constructor;ivb_UpdateAble = False
This.of_SetRowSelection()
end event

event dw_1::getfocus;call super::getfocus;//This.ivo_Controle_Menu.of_Atualiza()
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "id_filial_seleciona" Then
	If  Data = "S" Then
		
	End If 		
End If
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge618_preco_referencia_filial
integer x = 14
integer y = 0
integer width = 2336
integer height = 796
end type

type cb_1 from commandbutton within w_ge618_preco_referencia_filial
integer x = 2016
integer y = 800
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Processar"
end type

event clicked;String lvs_Msg, lvs_Marcado
Long ll_Linha, ll_Filial, ll_Linhas, ll_Linha_PRD, ll_Linhas_PRD, ll_Produto
Decimal ldc_Preco, ldc_Perc_Desc, ldc_Preco_Liq, ldc_Preco_Liq_Tab

Try 

	dc_uo_ds_base lds_produto 
	uo_produto lo_produto
	
	lds_produto	= Create dc_uo_ds_base
	lo_produto 	= Create uo_produto
	
	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio - Pre$$HEX1$$e700$$ENDHEX$$o de Venda Filial: Tela.")
	lds_produto.of_ChangeDataObject('ds_ge618_produto')
	ll_Linhas = dw_1.rowcount( )
	
	Open(w_Aguarde)

	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	dw_1.accepttext( )	
	
	For ll_Linha = 1 To ll_Linhas

		lvs_Marcado 	= dw_1.Object.id_filial_seleciona					[ll_Linha]
		ll_Filial 			= dw_1.Object.cd_filial								[ll_Linha]

		If lvs_Marcado  = "S" Then 
			// Exclusao dos dados da Filial
			If Not wf_apaga_dados_filial( ll_Filial) Then 
				Return -1
			End If 	
		
			w_Aguarde.Title = "Pre$$HEX1$$e700$$ENDHEX$$o de Venda: [" + String(ll_Filial) + "] " + String(ll_Linha) + " at$$HEX1$$e900$$ENDHEX$$: " + string(ll_Linhas)
			
			ll_Linhas_PRD = lds_Produto.Retrieve()
	
			Open(w_Aguarde_1)
			w_Aguarde_1.y = 1604
			
			w_Aguarde_1.uo_progress.of_setmax(ll_Linhas_PRD)
						
			For ll_Linha_PRD = 1 To ll_Linhas_PRD
				w_Aguarde_1.Title = "Produtos: " + String(ll_Linha_PRD) + " at$$HEX1$$e900$$ENDHEX$$: " + string(ll_Linhas_PRD)
				ll_Produto = lds_produto.Object.cd_produto[ll_Linha_PRD]
				lo_produto.of_Localiza_Produto(String(ll_Produto))
				
				If lo_produto.Localizado Then
					ldc_Preco 		= lo_produto.of_Preco_Venda_Filial_Matriz( ll_Filial )
					ldc_Perc_Desc	= lo_produto.Of_Desconto_Filial( ll_Filial )
					ldc_Preco_Liq =  round(ldc_Preco * ((100 - ldc_Perc_Desc) / 100), 2)
					
					Select vl_preco_liquido
					Into :ldc_Preco_Liq_Tab
					From preco_venda_filial
					Where cd_produto 	= :ll_Produto
						and cd_filial			= :ll_Filial
					Using SqlCa;
					
					Choose Case SqlCa.SqlCode
						Case 0
							
							If ldc_Preco_Liq_Tab <> ldc_Preco_Liq Then
								
								UPDATE preco_venda_filial  
								SET vl_preco_liquido = :ldc_Preco_Liq, dh_atualizacao = getdate()
								Where cd_produto 	= :ll_Produto
									 and cd_filial 		= :ll_Filial
								Using SqlCa;
								
								If SqlCa.SqlCode = -1 Then
									lvs_Msg = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda da filial. " + SQLCA.SQLErrText + "."
									SqlCa.of_Rollback();
									gvo_Aplicacao.of_Grava_Log(lvs_Msg)
									//gf_ge202_envia_email_automatico(68, '', lvs_Msg, ls_Anexo)
									Return -1
								End If
								
							End If
		
						Case 100
							
							INSERT INTO preco_venda_filial ( cd_produto, cd_filial,  vl_preco_liquido, dh_atualizacao )  
							VALUES ( :ll_Produto,   :ll_Filial, :ldc_Preco_Liq, getdate() )
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								lvs_Msg = "Inclus$$HEX1$$e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda da filial. " + SQLCA.SQLErrText + "."
								SqlCa.of_Rollback();
								gvo_Aplicacao.of_Grava_Log(lvs_Msg)
								//gf_ge202_envia_email_automatico(68, '', lvs_Msg, ls_Anexo)
								Return -1
							End If
							
						Case -1
								lvs_Msg = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o de venda da filial. " + SQLCA.SQLErrText + "."
								SqlCa.of_Rollback();
								gvo_Aplicacao.of_Grava_Log(lvs_Msg)
								//gf_ge202_envia_email_automatico(68, '', lvs_Msg, ls_Anexo)
								Return -1
					End Choose								
				End If			
				w_aguarde_1.uo_progress.of_setprogress(ll_Linha_PRD)
			Next	
			w_aguarde_1.uo_progress.of_reset()		
			SqlCa.of_Commit();		
			w_aguarde.uo_progress.of_setprogress(ll_Linha)			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sem Registros Selecionados! Para processar deve ser selecionado!")			
		End If 		
	Next
Finally
	Destroy(lds_Produto)
	Destroy(lo_Produto)
	Close(w_Aguarde)
	Close(w_Aguarde_1)
	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio - Pre$$HEX1$$e700$$ENDHEX$$o de Venda Filial: Tela.")
End try

dw_1.retrieve()
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processo executado com Sucesso!.")

Return 1
end event

