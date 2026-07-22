HA$PBExportHeader$w_ge396_manutencao_promocao_futura.srw
forward
global type w_ge396_manutencao_promocao_futura from dc_w_cadastro_selecao_lista
end type
type cb_importa_produto from commandbutton within w_ge396_manutencao_promocao_futura
end type
type dw_3 from dc_uo_dw_base within w_ge396_manutencao_promocao_futura
end type
type st_1 from statictext within w_ge396_manutencao_promocao_futura
end type
end forward

global type w_ge396_manutencao_promocao_futura from dc_w_cadastro_selecao_lista
integer width = 3451
integer height = 2060
string title = "GE396 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Promo$$HEX2$$e700e300$$ENDHEX$$o com Vig$$HEX1$$ea00$$ENDHEX$$ncia Futura"
cb_importa_produto cb_importa_produto
dw_3 dw_3
st_1 st_1
end type
global w_ge396_manutencao_promocao_futura w_ge396_manutencao_promocao_futura

type variables
uo_promocao	io_Promocao	//ge065
uo_produto		io_Produto		//ge001
uo_filial			io_Filial			//ge009

Integer ivl_Linhas
Integer ivl_Nao_Locali

String lvs_Cd_promocao_sap
String lvs_filial_adm_sap
		
end variables

forward prototypes
public function boolean wf_valida_desconto (long pl_row, string ps_dado, ref decimal rdc_desconto)
public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto_futuro, decimal adc_desc_clube_futuro, datetime adt_vigencia_futura)
public function boolean wf_valida_vigencia (long al_linha, string as_dado, ref datetime adh_vigencia_futura)
public subroutine wf_desabilita_controles (string as_tipo)
end prototypes

public function boolean wf_valida_desconto (long pl_row, string ps_dado, ref decimal rdc_desconto);Decimal ldc_Desc

If Not IsNumber( ps_Dado ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do desconto inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String( pl_row ) + "~rValor: " + ps_dado)
	Return False
End If

ldc_Desc = Dec(ps_Dado)

If IsNull(ldc_Desc) or ldc_Desc <= 0 Then ldc_Desc = 0

If ldc_Desc > 99 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do desconto maior que o permitido.~rLinha: " + String(pl_row) + "~rValor: " + ps_dado)
	Return False
End If

rdc_desconto = ldc_Desc

Return True
end function

public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto_futuro, decimal adc_desc_clube_futuro, datetime adt_vigencia_futura);Long 	lvl_Find

lvl_Find = dw_2.Find("cd_produto = " + String(al_produto), 1, dw_2.RowCount())

If lvl_Find = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find para o produto '" + String(al_Produto) + "'.", StopSign!)
	Return False
End If

If lvl_Find > 0 Then
	ivl_Linhas ++
	
   	If dw_2.Object.pc_desconto_futuro[ lvl_Find ] <> adc_desconto_futuro Then
		dw_2.Object.pc_desconto_futuro[ lvl_Find ] = adc_desconto_futuro
	End If
	
	If IsNull(dw_2.Object.pc_desconto_Clube_futuro[ lvl_Find ]) Then dw_2.Object.pc_desconto_Clube_futuro[ lvl_Find ] = 0.00
	
	If dw_2.Object.pc_desconto_Clube_futuro[ lvl_Find ] <> adc_desc_clube_futuro Then
		dw_2.Object.pc_desconto_Clube_futuro[ lvl_Find ] = adc_desc_clube_futuro
	End If
		
	If (Not IsNull(dw_2.Object.Dh_Vigencia_Futuro[ lvl_Find ] <> adt_vigencia_futura)) Or (IsNull(dw_2.Object.Dh_Vigencia_Futuro[ lvl_Find ])) Then
		dw_2.Object.Dh_Vigencia_Futuro[ lvl_Find ] = adt_Vigencia_Futura
	End If
Else
	ivl_Nao_Locali ++
End If

Return True
end function

public function boolean wf_valida_vigencia (long al_linha, string as_dado, ref datetime adh_vigencia_futura);If Not IsDate(String(Date(as_Dado))) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vig$$HEX1$$ea00$$ENDHEX$$ncia futura informada $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida." + &
									"~rLinha: " + String(al_Linha) + &
									"~rValor: " + String(Date(as_Dado)), Exclamation!)
	Return False
End If

adh_Vigencia_Futura = DateTime(as_Dado)

If adh_Vigencia_Futura <= gf_GetServerDate() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vig$$HEX1$$ea00$$ENDHEX$$ncia Futura '" + String(adh_Vigencia_Futura, "dd/mm/yyyy") + "' deve ser maior que a data atual." + &
									"~rLinha: " + String(al_Linha) + &
									"~rValor: " + String(Date(as_Dado)), Exclamation!)
	Return False
End If

If adh_Vigencia_Futura < io_Promocao.Dh_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vig$$HEX1$$ea00$$ENDHEX$$ncia Futura '" + String(adh_Vigencia_Futura, "dd/mm/yyyy") + "' $$HEX1$$e900$$ENDHEX$$ menor que a data '" + String(io_Promocao.Dh_Inicio, "dd/mm/yyyy") + "' de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o." + &
									"~rLinha: " + String(al_Linha) + &
									"~rValor: " + String(Date(as_Dado)), Exclamation!)
	Return False
End If

If adh_Vigencia_Futura > io_Promocao.Dh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Vig$$HEX1$$ea00$$ENDHEX$$ncia Futura '" + String(adh_Vigencia_Futura, "dd/mm/yyyy") + "' $$HEX1$$e900$$ENDHEX$$ maior que a data '" + String(io_Promocao.Dh_Termino, "dd/mm/yyyy") + "' de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o." + &
									"~rLinha: " + String(al_Linha) + &
									"~rValor: " + String(Date(as_Dado)), Exclamation!)
	Return False
End If

Return True
end function

public subroutine wf_desabilita_controles (string as_tipo);If as_tipo = 'S' Then 
	cb_importa_produto.enabled = False
	dw_2.ivo_Controle_Menu.of_Incluir(False)
	dw_2.ivm_menu.mf_Confirmar(False)
	dw_2.ivm_Menu.mf_Cancelar(False)		
	dw_2.ivo_Controle_Menu.of_Excluir(False)
	dw_2.ivm_Menu.mf_excluir(False)
	
Else
	cb_importa_produto.enabled = True
	dw_2.ivo_Controle_Menu.of_Incluir(True)
	dw_2.ivm_menu.mf_Confirmar(True)
	dw_2.ivm_Menu.mf_Cancelar(True)		
	dw_2.ivo_Controle_Menu.of_Excluir(True)
	dw_2.ivm_Menu.mf_excluir(True)
End If 
	
	
	
end subroutine

on w_ge396_manutencao_promocao_futura.create
int iCurrent
call super::create
this.cb_importa_produto=create cb_importa_produto
this.dw_3=create dw_3
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importa_produto
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.st_1
end on

on w_ge396_manutencao_promocao_futura.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_importa_produto)
destroy(this.dw_3)
destroy(this.st_1)
end on

event ue_preopen;call super::ue_preopen;io_Promocao	= Create uo_promocao
io_Produto		= Create uo_produto
io_Filial			= Create uo_filial
end event

event close;call super::close;Destroy(io_Promocao)
Destroy(io_Produto)
Destroy(io_Filial)
end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Dw[]
lvo_Dw = {dw_2}
This.wf_SetUpdate_DW(lvo_Dw)

ivm_Menu.mf_Incluir(False)

st_1.Visible = False

dw_1.SetFocus()
end event

event ue_cancel;//OverRide

ivm_Menu.mf_Excluir(False)

dw_2.Event ue_Cancel()

dw_1.Enabled = True

dw_1.SetFocus()

This.ivb_Valida_Salva = False
end event

event ue_preupdate;call super::ue_preupdate;Date ldt_Vigencia_Futu
Date ldt_Vigencia_Futu_Ant
Date ldt_Atual

Decimal ldc_Desc_Futu
Decimal ldc_Desc_Clu_Futu
Decimal ldc_Desc_Futu_Ant
Decimal ldc_Desc_Clu_Futu_Ant

Long ll_Linha
Long ll_Promocao
Long ll_Produto

String ls_Chave
String ls_Erro
String ls_Para

dw_1.AcceptText()
dw_2.AcceptText()

ldt_Atual = Date(gf_GetServerDate())

ll_Promocao = dw_1.Object.Cd_Promocao_Sos[1]



For ll_Linha = 1 To dw_2.RowCount()
	ldc_Desc_Futu 				= dw_2.Object.Pc_Desconto_Futuro				[ll_Linha]
	ldc_Desc_Futu_Ant 		= dw_2.Object.Pc_Desconto_Futuro_Ant			[ll_Linha]
	ldc_Desc_Clu_Futu			= dw_2.Object.Pc_Desconto_Clube_Futuro		[ll_Linha]
	ldc_Desc_Clu_Futu_Ant	= dw_2.Object.Pc_Desconto_Clube_Futuro_Ant[ll_Linha]	
	ldt_Vigencia_Futu			= Date(dw_2.Object.Dh_Vigencia_Futuro		[ll_Linha])
	ldt_Vigencia_Futu_Ant	= Date(dw_2.Object.Dh_Vigencia_Futuro_Ant	[ll_Linha])
		
	//Se teve altera$$HEX2$$e700e300$$ENDHEX$$o em algum campo da linha do for
	If gf_Houve_Alteracao_Dw(dw_2, 'PC_DESCONTO_FUTURO', ll_Linha, Ref ls_Para) Or &
			gf_Houve_Alteracao_Dw(dw_2, 'PC_DESCONTO_CLUBE_FUTURO', ll_Linha, Ref ls_Para) Or &
				gf_Houve_Alteracao_Dw(dw_2, 'DH_VIGENCIA_FUTURO', ll_Linha, Ref ls_Para) Then	
	
		ll_Produto = dw_2.Object.Cd_Produto[ll_Linha]

		// Valida data futura
		If  IsNull(ldt_Vigencia_Futu) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe data de vig$$HEX1$$ea00$$ENDHEX$$ncia futura.")
			dw_2.Event ue_Pos(ll_Linha, "dh_vigencia_futuro")
			Return False
		End If
				
		ls_Chave = MidA(String(ll_Promocao) + Space(5), 1, 5) + '@#!' + String(ll_Produto)
		
		//pc_desconto
		If gf_Houve_Alteracao_Dw(dw_2, 'PC_DESCONTO_FUTURO', ll_Linha, Ref ls_Para) Then
			If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO', ls_Chave, 'PC_DESCONTO_FUTURO', String(ldc_Desc_Futu_Ant), &
				ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then
				Return False
			End If
		End If
		
		//pc_desconto_clube
		If gf_Houve_Alteracao_Dw(dw_2, 'PC_DESCONTO_CLUBE_FUTURO', ll_Linha, Ref ls_Para) Then
			If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO', ls_Chave, 'PC_DESCONTO_CLUBE_FUTURO', String(ldc_Desc_Clu_Futu_Ant), &
				ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then
				Return False
			End If
		End If
		
		//dh_vigencia_futuro
		If gf_Houve_Alteracao_Dw(dw_2, 'DH_VIGENCIA_FUTURO', ll_Linha, Ref ls_Para) Then
			If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO', ls_Chave, 'DH_VIGENCIA_FUTURO', String(Date(ldt_Vigencia_Futu_Ant)), &
				ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then
				Return False
			End If
		End If
		
		//Se for alterado somente o desconto, $$HEX1$$e900$$ENDHEX$$ incrementado 1 dia
		If ldc_Desc_Futu >=0.00 Or ldc_Desc_Clu_Futu >=0.00 Then
			If (IsNull(ldt_Vigencia_Futu)) Or (ldt_Vigencia_Futu < ldt_Atual) Then
				dw_2.Object.Dh_Vigencia_Futuro[ll_Linha] = RelativeDate(ldt_Atual, 1)
			End If
		End If
				
		dw_2.Object.Nr_Matricula_Alteracao_Futuro[ll_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	End If
Next

Return True
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	dw_2.Event ue_Retrieve()
	dw_1.Enabled = True
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge396_manutencao_promocao_futura
integer x = 37
integer y = 992
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge396_manutencao_promocao_futura
integer x = 0
integer y = 920
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge396_manutencao_promocao_futura
integer width = 3278
integer height = 268
string dataobject = "dw_ge396_selecao"
end type

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_promocao_sos" Then
				
		io_Promocao.of_Localiza(This.GetText())
		
		If Not io_Promocao.Localizado Then
			io_Promocao.of_Inicializa()
		End If
		
		// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap (  io_Promocao.Cd_Promocao  ,  lvs_Cd_promocao_sap ) Then 
	 	    If 	Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String( io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				st_1.Visible = True
				st_1.Text = "Promocao criado no SAP opera$$HEX2$$e700e300$$ENDHEX$$o nao permitida!!."				
			End If				
		End If 
		
			
		This.Object.Cd_Promocao_Sos				[1] = io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos				[1] = io_Promocao.Nm_Promocao
		This.Object.Dh_Inicio								[1] = io_Promocao.Dh_Inicio
		This.Object.Dh_Termino							[1] = io_Promocao.Dh_Termino
		This.Object.Dh_Inicio_Estoque_Minimo		[1] = io_Promocao.Dh_Inicio_Estoque_Minimo
		This.Object.Dh_Termino_Estoque_Minimo	[1] = io_Promocao.Dh_Termino_Estoque_Minimo
		This.Object.cd_promocao_sap 					[1] = lvs_Cd_promocao_sap	
		
		
		If io_Promocao.Id_Tipo_Promocao <> "C" And io_Promocao.Id_Tipo_Promocao <> "V" And io_Promocao.Id_Tipo_Promocao <> "N"Then
			dw_2.Enabled = False
			st_1.Visible = True
			st_1.Text = "Somente as promo$$HEX2$$e700f500$$ENDHEX$$es do tipo NORMAL, PBM CLAMED e VINCULADA podem ser alteradas."
			Return -1
		End If
		
		//Promo$$HEX2$$e700e300$$ENDHEX$$o fora da vig$$HEX1$$ea00$$ENDHEX$$ncia ou com vencimento para o dia atual, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a altera$$HEX2$$e700e300$$ENDHEX$$o
		If Date(io_Promocao.Dh_Termino) <= Date(gf_GetServerDate()) Then
			dw_2.Enabled = False
			
			st_1.Visible = True
			st_1.Text = "Promo$$HEX2$$e700e300$$ENDHEX$$o fora da vig$$HEX1$$ea00$$ENDHEX$$ncia ou com vencimento para o dia atual. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida altera$$HEX2$$e700e300$$ENDHEX$$o."
		Else
			dw_2.Enabled = True
			st_1.Visible = False
		End If
	End If
	
	If This.GetColumnName() = "de_produto" Then
		
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If Not io_Produto.Localizado Then
			io_Produto.of_Inicializa()
		End If
		
		This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
		This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
		
	If This.GetColumnName() = "nm_fantasia" Then
		
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If io_Filial.Localizada Then
			
			If gf_filial_administrada_sap( io_Filial.Cd_Filial , lvs_filial_adm_sap) Then 
				If	lvs_filial_adm_sap = 'S' Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A Filial : '" + String( io_Filial.cd_filial  ) + "' esta sendo Administrada no SAP." + &
								"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				End If 
			End If 
			
			
			dw_1.Object.Cd_Filial			[1] = io_Filial.Cd_Filial
			dw_1.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia			
		Else
			io_Filial.of_Inicializa()
		End If
	End If	
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
st_1.Visible = False

If dwo.Name = "nm_promocao_sos" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Promocao.Nm_Promocao Then
			Return 1
		End If
	Else
		io_Promocao.of_Inicializa()
		
				// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap (  io_Promocao.Cd_Promocao  ,  lvs_Cd_promocao_sap ) Then 
	 	    If 	Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String( io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				st_1.Visible = True
				st_1.Text = "Promocao criado no SAP opera$$HEX2$$e700e300$$ENDHEX$$o nao permitida!!."				
			End If 
		End If 
		
		This.Object.cd_promocao_sap 					[1] = lvs_Cd_promocao_sap	
		This.Object.Cd_Promocao_Sos					[1]	= io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos				[1]	= io_Promocao.Nm_Promocao
		This.Object.Cd_Promocao_Sos					[1] = io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos				[1] = io_Promocao.Nm_Promocao
		This.Object.Dh_Inicio								[1] = io_Promocao.Dh_Inicio
		This.Object.Dh_Termino							[1] = io_Promocao.Dh_Termino
		This.Object.Dh_Inicio_Estoque_Minimo		[1] = io_Promocao.Dh_Inicio_Estoque_Minimo
		This.Object.Dh_Termino_Estoque_Minimo	[1] = io_Promocao.Dh_Termino_Estoque_Minimo
	End If
End If

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.De_Produto Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
		This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		If gf_filial_administrada_sap( io_Filial.Cd_Filial , lvs_filial_adm_sap) Then 
			If	lvs_filial_adm_sap = 'S' Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A Filial : '" + String( io_Filial.cd_filial  ) + "' esta sendo Administrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)									
			End If 
		End If 
		
		This.Object.Cd_Filial			[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia		[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_promocao_sos" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Promocao.Nm_Promocao Then
			Return 1
		End If
	Else
		io_Promocao.of_Inicializa()
		
		// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap (  io_Promocao.Cd_Promocao  ,  lvs_Cd_promocao_sap ) Then 
	 	    If 	Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String( io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)									
				st_1.Visible = True
				st_1.Text = "Promocao criado no SAP opera$$HEX2$$e700e300$$ENDHEX$$o nao permitida!!."
			End If 
		End If 

		This.Object.cd_promocao_sap 					[1] = lvs_Cd_promocao_sap	
		This.Object.Cd_Promocao_Sos					[1]	= io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos				[1]	= io_Promocao.Nm_Promocao
		This.Object.Cd_Promocao_Sos					[1] = io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos				[1] = io_Promocao.Nm_Promocao
		This.Object.Dh_Inicio								[1] = io_Promocao.Dh_Inicio
		This.Object.Dh_Termino							[1] = io_Promocao.Dh_Termino
		This.Object.Dh_Inicio_Estoque_Minimo		[1] = io_Promocao.Dh_Inicio_Estoque_Minimo
		This.Object.Dh_Termino_Estoque_Minimo	[1] = io_Promocao.Dh_Termino_Estoque_Minimo
	End If
End If

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.De_Produto Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
		This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		If gf_filial_administrada_sap( io_Filial.Cd_Filial , lvs_filial_adm_sap) Then 
			If	lvs_filial_adm_sap = 'S' Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A Filial : '" + String( io_Filial.cd_filial  ) + "' esta sendo Administrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)									
			End If 
		End If 
		
		
		This.Object.Cd_Filial			[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia		[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge396_manutencao_promocao_futura
integer y = 404
integer width = 3351
integer height = 1332
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge396_manutencao_promocao_futura
integer width = 3351
integer height = 380
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge396_manutencao_promocao_futura
integer y = 480
integer width = 3278
integer height = 1228
string dataobject = "dw_ge396_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Promocao
Long ll_Produto
Long ll_Filial

dw_1.AcceptText()

ll_Promocao	= dw_1.Object.Cd_Promocao_Sos	[1]
ll_Produto	= dw_1.Object.Cd_Produto			[1]
ll_Filial		= dw_1.Object.Cd_Filial				[1]

If IsNull(ll_Promocao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a promo$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "nm_promocao_sos")
	Return -1
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere("p.cd_produto = " + String(ll_Produto))
End If

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere("f.cd_filial = " + String(ll_Filial))
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Cd_Promocao_Sos[1])
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::itemchanged;call super::itemchanged;Date ldt_Nulo
Date ldt_Atual

DateTime ldh_Vigencia_Futu

ivm_Menu.mf_Excluir(False)

dw_2.AcceptText()


If gf_promocao_sap ( io_Promocao.Cd_Promocao ,  lvs_Cd_promocao_sap ) Then 			
	If Long(lvs_Cd_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	    wf_desabilita_controles('S')
	Else
   		ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')	

		Choose Case dwo.name
			Case "pc_desconto_futuro"
					If Dec(data) < 0 Or Dec(data) >= 100 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto informado inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
							This.Object.pc_desconto_futuro[ Row ] = 0.00
							Return 1
					End If
						ldt_Atual = Date(gf_GetServerDate())
										
						If dw_2.Object.Pc_Desconto_Futuro[Row] >= 0.00 Or dw_2.Object.Pc_Desconto_Clube_Futuro[Row] >= 0.00 Then
							If (IsNull(dw_2.Object.Dh_Vigencia_Futuro[Row])) Or (dw_2.Object.Dh_Vigencia_Futuro[Row] < DateTime(ldt_Atual)) Then
								dw_2.Object.Dh_Vigencia_Futuro[Row] = DateTime(RelativeDate(ldt_Atual, 1))
							End If
						End If			
						
			Case "pc_desconto_clube_futuro"
					If Dec(data) < 0 Or Dec(data) >= 100 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto do clube inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
						This.Object.pc_desconto_clube_futuro[ Row ] = 0.00
						Return 1
					End If
						
					ldt_Atual = Date(gf_GetServerDate())
						
					If dw_2.Object.Pc_Desconto_Futuro[Row] >= 0.00 Or dw_2.Object.Pc_Desconto_Clube_Futuro[Row] >= 0.00 Then
						If (IsNull(dw_2.Object.Dh_Vigencia_Futuro[Row])) Or (dw_2.Object.Dh_Vigencia_Futuro[Row] < DateTime(ldt_Atual)) Then
							dw_2.Object.Dh_Vigencia_Futuro[Row] = DateTime(RelativeDate(ldt_Atual, 1))
						End If
					End If
						
			Case "dh_vigencia_futuro"
					If Not wf_Valida_Vigencia(Row, String(DateTime(Data)), Ref ldh_Vigencia_Futu) Then
						SetNull(ldt_Nulo)
						This.Object.Dh_Vigencia_Futuro[ Row ] = ldt_Nulo
						Return 1
					End If
		End Choose
	End If 
End If 


end event

event dw_2::editchanged;call super::editchanged;ivm_Menu.mf_Excluir(False)
dw_1.Enabled = False

If gf_promocao_sap ( io_Promocao.Cd_Promocao ,  lvs_Cd_promocao_sap ) Then 			
	If Long(lvs_Cd_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	    wf_desabilita_controles('S')
	Else
       	ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')	
	End If 
End If 
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_Excluir(False)

If pl_linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::losefocus;call super::losefocus;ivm_Menu.mf_Excluir(False)
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;ivm_Menu.mf_Excluir(False)
end event

event dw_2::getfocus;call super::getfocus;ivm_Menu.mf_Excluir(False)
end event

type cb_importa_produto from commandbutton within w_ge396_manutencao_promocao_futura
integer x = 2537
integer y = 356
integer width = 818
integer height = 96
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Atualizar via Planilha (.XLS)"
end type

event clicked;DateTime ldh_Vigencia_Futura

Decimal	lvdc_Desconto_Futu, &
			lvdc_Desconto_Clube_Futu

Integer lvi_Arquivo

Long	lvl_Linhas, &
	  	lvl_Linha, &
	  	lvl_Produto, &
	  	lvl_Promocao

String	lvs_Path, &
       	lvs_Nome_Arquivo, &
		lvs_Arquivo, &
		lvs_Dado, &
		lvs_Msg
		  
dw_1.AcceptText()

If ivb_Valida_Salva Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes, salve ou desfa$$HEX1$$e700$$ENDHEX$$a para prosseguir.")
	Return -1
End If

lvl_Promocao = dw_1.Object.cd_promocao_sos[1]

If IsNull(lvl_Promocao) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	dw_1.SetFocus()
	Return
End If

// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
If gf_promocao_sap (  io_Promocao.Cd_Promocao  ,  lvs_Cd_promocao_sap ) Then 
    If 	Long(lvs_Cd_promocao_sap) > 0  Then 					
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String( io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
						"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
		Return -1
	End If 
End If 



dw_2.Event ue_Retrieve()

If io_Promocao.Id_Tipo_Promocao <> "C" And io_Promocao.Id_Tipo_Promocao <> "V" And io_Promocao.Id_Tipo_Promocao <> "N" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente as promo$$HEX2$$e700f500$$ENDHEX$$es do tipo NORMAL, PBM CLAMED e VINCULADA podem ser alteradas.")
	Return -1
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Para importar a planilha de produtos os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A = Produto~r" + &
					"Coluna B = Desconto Futuro~r" + &
					"Coluna C = Desconto do Clube Futuro~r" + &
					"Coluna D = Vig$$HEX1$$ea00$$ENDHEX$$ncia Futura (Dia/M$$HEX1$$ea00$$ENDHEX$$s/Ano)")
			
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo <> 1 Then Return

ivl_Linhas = 0
ivl_Nao_Locali = 0

dw_3.Object.nm_arquivo[1] = lvs_Path

lvs_Msg = "Importar os produtos com os descontos do arquivo selecionado ?"
		  
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

Try

	dw_2.SetRedRaw(False)
	
	dw_3.AcceptText()
	
	lvs_Arquivo = dw_3.Object.nm_arquivo[1]
	
	dc_uo_excel lvo_Excel
	lvo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A")
		
		If lvl_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
			For lvl_Linha = 1 To lvl_Linhas
				
				lvdc_Desconto_Futu 			= 0.00
				lvdc_Desconto_Clube_Futu 	= 0.00
				
				lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A"))
		
				If IsNumber(lvs_Dado) Then
					lvl_Produto = Long(lvs_Dado)
		
					//Desconto Futuro
					lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B"))
					
					If Not wf_valida_desconto( lvl_Linha, lvs_Dado, Ref lvdc_Desconto_Futu) Then Exit
							
					//Desconto Clube Futuro
					lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C"))
					
					If Not wf_valida_desconto( lvl_Linha, lvs_Dado, Ref lvdc_Desconto_Clube_Futu) Then Exit
					
					//Vig$$HEX1$$ea00$$ENDHEX$$ncia Futura
					lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "D"))
					
					If Not wf_Valida_Vigencia(lvl_Linha, lvs_Dado, Ref ldh_Vigencia_Futura) Then Exit
					
					//Inclui Promocao_SOS_produto
					If Not wf_Inclui_Promocao_SOS_Produto(lvl_Produto, lvdc_Desconto_Futu, lvdc_Desconto_Clube_Futu, ldh_Vigencia_Futura) Then Exit
					
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(lvl_Linha) + "~rValor: " + lvs_Dado)
					Exit
				End If //Produto
				
				w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
			Next
		
			If ivl_Linhas > 0 Then
				Parent.ivm_Menu.mf_Confirmar(True)
				Parent.ivm_Menu.mf_Cancelar(True)
				Parent.ivb_Valida_Salva = True
				dw_1.Enabled = False
			End If
			
			If ivl_Nao_Locali > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Um ou mais produtos da planilha n$$HEX1$$e300$$ENDHEX$$o foram localizados na promo$$HEX2$$e700e300$$ENDHEX$$o.")
			End If
		End If //Linha
	End If //Excel
	
	Return 1
	
Finally
	Close(w_Aguarde)
	dw_2.SetRedRaw(True)
	If IsValid(lvo_Excel) Then Destroy(lvo_Excel)
	ivm_Menu.mf_Excluir(False)
End Try
end event

type dw_3 from dc_uo_dw_base within w_ge396_manutencao_promocao_futura
boolean visible = false
integer y = 460
integer width = 1838
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge380_selecao_arquivo"
end type

type st_1 from statictext within w_ge396_manutencao_promocao_futura
integer x = 41
integer y = 1768
integer width = 3337
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "text"
boolean focusrectangle = false
end type

