HA$PBExportHeader$w_ge380_cadastro_promocao.srw
forward
global type w_ge380_cadastro_promocao from dc_w_sheet
end type
type gb_6 from groupbox within w_ge380_cadastro_promocao
end type
type cb_selecao_filiais from commandbutton within w_ge380_cadastro_promocao
end type
type cb_exportar_saldo from commandbutton within w_ge380_cadastro_promocao
end type
type gb_2 from groupbox within w_ge380_cadastro_promocao
end type
type cb_selecao_filial from commandbutton within w_ge380_cadastro_promocao
end type
type dw_4 from dc_uo_dw_base within w_ge380_cadastro_promocao
end type
type dw_2 from dc_uo_dw_base within w_ge380_cadastro_promocao
end type
type dw_5 from dc_uo_dw_base within w_ge380_cadastro_promocao
end type
type dw_7 from dc_uo_dw_base within w_ge380_cadastro_promocao
end type
type dw_3 from dc_uo_dw_base within w_ge380_cadastro_promocao
end type
type dw_8 from dc_uo_dw_base within w_ge380_cadastro_promocao
end type
type dw_9 from dc_uo_dw_base within w_ge380_cadastro_promocao
end type
type cb_importa_produto from commandbutton within w_ge380_cadastro_promocao
end type
type cb_importa_filial from commandbutton within w_ge380_cadastro_promocao
end type
type gb_3 from groupbox within w_ge380_cadastro_promocao
end type
type dw_1 from dc_uo_dw_base within w_ge380_cadastro_promocao
end type
type st_1 from statictext within w_ge380_cadastro_promocao
end type
type st_2 from statictext within w_ge380_cadastro_promocao
end type
type st_3 from statictext within w_ge380_cadastro_promocao
end type
type cb_libera_commerce from commandbutton within w_ge380_cadastro_promocao
end type
type gb_1 from groupbox within w_ge380_cadastro_promocao
end type
end forward

global type w_ge380_cadastro_promocao from dc_w_sheet
integer width = 3621
integer height = 2224
string title = "GE380 - Cadastro de Promo$$HEX2$$e700f500$$ENDHEX$$es"
boolean resizable = false
long backcolor = 80269524
event ue_simula_precos ( )
event ue_copia_promocao ( )
event ue_salva_produtos_excel ( )
gb_6 gb_6
cb_selecao_filiais cb_selecao_filiais
cb_exportar_saldo cb_exportar_saldo
gb_2 gb_2
cb_selecao_filial cb_selecao_filial
dw_4 dw_4
dw_2 dw_2
dw_5 dw_5
dw_7 dw_7
dw_3 dw_3
dw_8 dw_8
dw_9 dw_9
cb_importa_produto cb_importa_produto
cb_importa_filial cb_importa_filial
gb_3 gb_3
dw_1 dw_1
st_1 st_1
st_2 st_2
st_3 st_3
cb_libera_commerce cb_libera_commerce
gb_1 gb_1
end type
global w_ge380_cadastro_promocao w_ge380_cadastro_promocao

type variables
uo_promocao ivo_promocao
uo_produto ivo_produto
dc_uo_ds_base ids

Boolean ivb_Check

Long ivl_linhas
Long ivl_promocao

String ivs_Responsavel
String ivs_promocao_sap
end variables

forward prototypes
public function long wf_proxima_promocao ()
public subroutine wf_localiza_produto ()
public subroutine wf_atualiza_produtos_incluidos_alterados (dc_uo_ds_base ads, ref long al_alteracao)
public subroutine wf_atualiza_produtos_excluidos (dc_uo_ds_base ads, ref long al_alteracao)
public function boolean wf_copia_produto (long al_promocao, ref long al_alteracao)
public function boolean wf_copia_filial (long al_promocao, ref long al_alteracao)
public function boolean wf_salva_pendente ()
public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto, decimal adc_desc_clube)
public function boolean wf_valida_desconto (long pl_row, string ps_dado, ref decimal rdc_desconto)
public function boolean wf_verifica_usuario_alteracao (ref boolean ab_permite_alterar)
public function boolean wf_existe_filiais_desmarcadas ()
public function boolean wf_grava_rede_liberada ()
public function boolean wf_verifica_rede_liberada ()
public function boolean wf_verifica_inclusao_estoque_minimo ()
public subroutine wf_seleciona_filial_planilha ()
public function boolean wf_valida_fronteira ()
public function boolean wf_verifica_desc_maior (boolean al_produto)
public subroutine wf_desabilida_alterar ()
public subroutine wf_desabilita_controles (string as_controle)
public subroutine wf_liberacao_ecommerce_botao (long pl_promocao, date adt_inicio, date adt_termino, date adt_movimento, string ps_utiliza_ecommerce)
end prototypes

event ue_simula_precos();Boolean lvb_Continua = True

Long lvl_Alteracao = 0,&
     lvl_Promocao_SOS

String lvs_Retorno
 
dw_1.AcceptText()

lvl_Promocao_SOS = dw_1.Object.cd_promocao_sos[1]

If Not wf_Salva_Pendente() Then
	If IsNull(lvl_Promocao_SOS) Or lvl_Promocao_SOS = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma promo$$HEX2$$e700e300$$ENDHEX$$o foi selecionada.")
		Return
	End If
	
	// Abre a janela de simula$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$os
	OpenWithParm(w_ge380_Simulacao_Preco, lvl_Promocao_SOS)
	
	lvs_Retorno = Message.StringParm

	// Verifica o retorno da janela
	//If lvs_Retorno = "S" Then
	dw_2.Event ue_Recuperar()
	//End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas.~r~rConfirme antes de continuar.")
End If
end event

event ue_copia_promocao();String lvs_Produto, &
		 lvs_Filial

Long lvl_Promocao, &
     lvl_Alteracao

Open(w_ge380_Copia_Promocao)

str_ge380_promocao st

st = Message.PowerObjectParm

If st.id_Copia = "S" Then
	lvl_Promocao	= st.Cd_Promocao
	lvs_Produto		= st.Id_Produto
	lvs_Filial			= st.Id_Filial
	
	If lvs_Produto = "S" Then
		wf_Copia_Produto(lvl_Promocao, ref lvl_Alteracao)
	End If
	
	If lvs_Filial = "S" Then
		wf_Copia_Filial(lvl_Promocao, ref lvl_Alteracao)
	End If

	If lvl_Alteracao > 0 Then
		ivb_Valida_Salva = True		
		
		ivm_Menu.mf_Confirmar(True)
		ivm_Menu.mf_Cancelar(True)		
	End If	
End If
end event

event ue_salva_produtos_excel();Long lvl_Linha

If dw_2.RowCount() = 0 Then Return

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge380_salva_produtos_excel") Then
	Destroy(lvds)
	Return
End If

SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Preparando Salva em Excel..."

w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())

For lvl_Linha = 1 To dw_2.RowCount()
	lvds.InsertRow(0)
	
	lvds.Object.Cd_Produto 			[lvl_Linha] = dw_2.Object.Cd_Produto 			[lvl_Linha]
	lvds.Object.De_Produto 			[lvl_Linha] = dw_2.Object.De_Produto 			[lvl_Linha]
	lvds.Object.Pc_Desconto			[lvl_Linha] = dw_2.Object.Pc_Desconto			[lvl_Linha]
	lvds.Object.pc_desconto_clube	[lvl_Linha] = dw_2.Object.pc_desconto_clube	[lvl_Linha]
		
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

Close(w_Aguarde)

lvds.of_SaveAs("")

Destroy(lvds)

SetPointer(Arrow!)
end event

public function long wf_proxima_promocao ();Long lvl_Promocao

Select max(cd_promocao_sos) Into :lvl_Promocao
From promocao_sos
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvl_Promocao) Then
			Return lvl_Promocao + 1
		Else
			Return 1
		End If
	Case 100
		Return 1
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da pr$$HEX1$$f300$$ENDHEX$$xima promo$$HEX2$$e700e300$$ENDHEX$$o.")
End Choose
end function

public subroutine wf_localiza_produto ();Long lvl_Linha

ivo_Produto.of_Localiza_Produto(dw_2.GetText())

If ivo_Produto.Localizado Then
	lvl_Linha = dw_2.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_2.RowCount())

	If lvl_Linha < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto selecionado.", StopSign!)
		Return
	End If
	
	If lvl_Linha = 0 Then
		lvl_Linha = dw_2.GetRow()
		
		dw_2.Object.Cd_Produto          [lvl_Linha] = ivo_Produto.Cd_Produto
		dw_2.Object.De_Produto          [lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		dw_2.Object.Vl_Preco_Venda_Atual[lvl_Linha] = ivo_Produto.Vl_Preco_Venda_Atual
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ivo_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionado.", Information!)
	End If
	
	dw_2.Post Event ue_Pos(lvl_Linha, "pc_desconto")	
End If
end subroutine

public subroutine wf_atualiza_produtos_incluidos_alterados (dc_uo_ds_base ads, ref long al_alteracao);Long lvl_Linha, &
     lvl_Produto, &
	  lvl_Find
	  
String lvs_Descricao

Decimal lvdc_Desconto, &
        lvdc_Preco, &
		  lvdc_Desconto_Anterior

For lvl_Linha = 1 To ads.RowCount()
	lvl_Produto   = ads.Object.Cd_Produto          [lvl_Linha]
	lvs_Descricao = ads.Object.De_Produto          [lvl_Linha]
	lvdc_Desconto = ads.Object.Pc_Desconto         [lvl_Linha]
	lvdc_Preco    = ads.Object.Vl_Preco_Venda_Atual[lvl_Linha]
	
	// Para cada produto retornado, verifica se existe na lista anterior
	// Se existir, atualiza o desconto alterado, sen$$HEX1$$e300$$ENDHEX$$o inclui
	
	If Not IsNull(lvl_Produto) Then
		lvl_Find = dw_2.Find("cd_produto = " + String(lvl_Produto), 1, dw_2.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "'.", StopSign!)
			Exit
		End If
		
		If lvl_Find > 0 Then
			lvdc_Desconto_Anterior = dw_2.Object.Pc_Desconto[lvl_Find]
			
			If lvdc_Desconto <> lvdc_Desconto_Anterior Then
				dw_2.Object.Pc_Desconto[lvl_Find] = lvdc_Desconto
				
				al_Alteracao ++
			End If
		Else
			lvl_Find = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Produto          [lvl_Find] = lvl_Produto
			dw_2.Object.De_Produto          [lvl_Find] = lvs_Descricao
			dw_2.Object.Pc_Desconto         [lvl_Find] = lvdc_Desconto
			dw_2.Object.Vl_Preco_Venda_Atual[lvl_Find] = lvdc_Preco			
			dw_2.Object.Vl_Preco_Simulado   [lvl_Find] = 0
			
			al_Alteracao ++
		End If
	End If
Next
end subroutine

public subroutine wf_atualiza_produtos_excluidos (dc_uo_ds_base ads, ref long al_alteracao);Long lvl_Linha, &
     lvl_Produto, &
	  lvl_Find
	  
For lvl_Linha = 1 To dw_2.RowCount()
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Linha]
	
	// Para cada produto da lista anterior, verifica se existe na lista retornada
	// Se n$$HEX1$$e300$$ENDHEX$$o existir, exclui
	
	lvl_Find = ads.Find("cd_produto = " + String(lvl_Produto), 1, ads.RowCount())
	
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "'.", StopSign!)
		Exit
	End If
	
	If lvl_Find = 0 Then
		If dw_2.DeleteRow(lvl_Linha) <> 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o da linha '" + String(lvl_Linha) + "'.", StopSign!)
			Exit
		End If
		
		al_Alteracao ++
		
		// Diminui um do controle do loop devido a linha exclu$$HEX1$$ed00$$ENDHEX$$da da dw
		lvl_Linha --
	End If
Next
end subroutine

public function boolean wf_copia_produto (long al_promocao, ref long al_alteracao);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Linha
	  
Decimal lvdc_Desconto

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge380_produto_normal") Then
	Destroy(lvds)
	Return False
End If

lvl_Total = lvds.Retrieve(al_Promocao)

If lvl_Total > 0 Then
	uo_Produto lvo_Produto
	lvo_Produto = Create uo_Produto
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Produto   = lvds.Object.Cd_Produto [lvl_Contador]
		lvdc_Desconto = lvds.Object.Pc_Desconto[lvl_Contador]
		
		lvl_Linha = dw_2.Find("cd_produto = " + String(lvl_Produto), 1, dw_2.RowCount())
		
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "'.")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Linha = 0 Then
		   lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
			
			If lvo_Produto.Localizado Then			
				lvl_Linha = dw_2.InsertRow(0)
				
				dw_2.Object.Cd_Produto [lvl_Linha] = lvl_Produto
				dw_2.Object.Pc_Desconto[lvl_Linha] = lvdc_Desconto
				dw_2.Object.De_Produto [lvl_Linha] = lvo_Produto.ivs_Descricao_Apresentacao_Venda
				
				If lvl_Linha = 1 Then
					dw_2.ivo_Controle_Menu.of_Excluir(True)
				End If
				
				al_Alteracao ++
			End If
		End If
	Next	
	
	Destroy(lvo_Produto)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados para c$$HEX1$$f300$$ENDHEX$$pia.")
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean wf_copia_filial (long al_promocao, ref long al_alteracao);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Filial, &
	  lvl_Linha
	  
	  
dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge380_filial_cadastrada") Then
	Destroy(lvds)
	Return False
End If

lvl_Total = lvds.Retrieve(al_Promocao)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvl_Filial = lvds.Object.Cd_Filial[lvl_Contador]
			
		lvl_Linha = dw_3.Find("cd_filial = " + String(lvl_Filial), 1, dw_3.RowCount())
		
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial '" + String(lvl_Filial) + "'.")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Linha = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(lvl_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizada na lista de sele$$HEX2$$e700e300$$ENDHEX$$o de filiais.")
			lvb_Sucesso = False
			Exit			
		End If
		
		If dw_3.Object.Id_Filial[lvl_Linha] = "N" Then
			dw_3.Object.Id_Filial[lvl_Linha] = "S"
			
			dw_3.Event ue_Seleciona_Filial(lvl_Filial, True)			
			
			al_Alteracao ++
		End If
	Next	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As filiais da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizadas para c$$HEX1$$f300$$ENDHEX$$pia.")
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean wf_salva_pendente ();Long lvl_Modificado

dw_2.AcceptText()

lvl_Modificado = dw_2.ModifiedCount() + dw_2.DeletedCount()
							 
If lvl_Modificado > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto, decimal adc_desc_clube);Long 	lvl_Find, &
     	lvl_Row

lvl_Find = dw_2.Find("cd_produto = " + String(al_produto), 1, dw_2.RowCount())

If lvl_Find = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find para o produto '" + String(al_Produto) + "'.", StopSign!)
	Return False
End If 

If lvl_Find = 0 Then
	
	ivo_Produto.of_Localiza_Codigo_Interno(al_Produto)

	If ivo_Produto.Localizado Then
		
		lvl_Row = dw_2.InsertRow(0) 
		
		dw_2.Object.cd_produto          		[ lvl_Row ] = al_Produto
		dw_2.Object.pc_desconto         		[ lvl_Row ] = adc_desconto
		dw_2.Object.pc_desconto_clube 		[ lvl_Row ] = adc_desc_clube
		dw_2.Object.De_Produto          		[ lvl_Row ] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		dw_2.Object.Vl_Preco_Venda_Atual	[ lvl_Row ] = ivo_Produto.Vl_Preco_Venda_Atual
		
		ivl_Linhas ++
	End If
	
Else
	
   	If dw_2.Object.pc_desconto[ lvl_Find ] <> adc_desconto Then
		dw_2.Object.pc_desconto[ lvl_Find ] = adc_desconto
		ivl_Linhas ++
	End If
	
	If IsNull(dw_2.Object.pc_desconto_Clube[ lvl_Find ]) Then dw_2.Object.pc_desconto_Clube[ lvl_Find ]  = 0.00
	
	If  dw_2.Object.pc_desconto_Clube[ lvl_Find ] <> adc_desc_clube Then
		dw_2.Object.pc_desconto_Clube[ lvl_Find ] = adc_desc_clube
		ivl_Linhas ++
	End If
	
End If

Return True
end function

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

public function boolean wf_verifica_usuario_alteracao (ref boolean ab_permite_alterar);Integer li_contador
String ls_Master
String ls_Alteracao

select x.id_perfil_master, y.id_alteracao
	into :ls_Master, :ls_Alteracao
from ( select p.id_perfil_master
		from perfil_usuario p
			inner join usuario_sistema s
				on s.cd_sistema			= p.cd_sistema
				and s.cd_perfil_usuario 	= p.cd_perfil_usuario
		where p.cd_sistema = :gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
		and s.nr_matricula = :ivs_Responsavel
		) as x,

		( select (Case when count(*) > 0 Then 'S' else 'N' End) as id_alteracao
		from usuario_sistema u
			inner join procedimento_perfil_usuario p
				on p.cd_sistema = u.cd_sistema
				and p.cd_perfil_usuario = u.cd_perfil_usuario
		where u.cd_sistema = :gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
		and p.cd_procedimento = 'W_GE380_LIBERA_ALTERACAO'
		and u.nr_matricula = :ivs_Responsavel
		) as y
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDBError( "Erro ao localizar o perfil usu$$HEX1$$e100$$ENDHEX$$rio. " + SqlCa.SqlErrText )
	Return False
End If

If ls_Master = 'S' Or ls_Alteracao = 'S' Then
	dw_1.Object.t_msg_usuario.Visible = False
	ab_permite_alterar = True
Else
	dw_1.Object.t_msg_usuario.Visible = True
	ab_permite_alterar = False
End If

Return True



end function

public function boolean wf_existe_filiais_desmarcadas ();String ls_Atual, ls_Anterior
Long ll_Row

For ll_Row = 1 To dw_3.RowCount()
	
	ls_Atual 		= dw_3.Object.id_filial 					[ ll_Row ]
	ls_Anterior	= dw_3.Object.id_marcacao_anterior	[ ll_Row ]
	
	If ls_Atual = 'N' And ls_Anterior = 'S' Then  Return True
	
Next

Return False

end function

public function boolean wf_grava_rede_liberada ();Long ll_Achou, ll_Registros

Select count(*) 
Into :ll_Achou
From promocao_sos_rede_filial
Where cd_promocao_sos = :ivo_Promocao.Cd_Promocao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da rede liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.")
	Return False
End If

If ll_Achou = 0 Then
	
	INSERT INTO promocao_sos_rede_filial  ( cd_promocao_sos, id_rede_filial )  
	select distinct p.cd_promocao_sos, v.id_rede
	from promocao_sos_filial p
	inner join vw_filial v on v.cd_filial = p.cd_filial
	where p.cd_promocao_sos = :ivo_Promocao.Cd_Promocao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o da rede liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.")
		Return False
	End If
	
	ll_Registros = Sqlca.SQLNRows 
	
	SqlCa.of_Commit();
	
End If

Return True

end function

public function boolean wf_verifica_rede_liberada ();Long ll_Linha, ll_Linha2, ll_Find

String ls_Rede, ls_Rede_Filial, ls_Nome_Fant

ll_Find = dw_8.Find("id_rede = 'S'", 1, dw_8.RowCount())

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe rede liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	Return False
End If

If ll_Find < 0 Then
	MessageBox("Erro", "Erro no find ao localizar a rede liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
End If


For ll_Linha = 1 To dw_8.RowCount()
	
	If dw_8.Object.id_rede[ll_Linha] = 'N' Then
		
		ls_Rede = dw_8.Object.id_rede_filial[ll_Linha]
		
		For ll_Linha2 = 1 To dw_3.RowCount()
			
			If dw_3.Object.id_filial[ll_Linha2] = 'S' Then
				ls_Rede_Filial = dw_3.Object.vl_parametro[ll_Linha2]
				
				If ls_Rede = ls_Rede_Filial Then
					
					ls_Nome_Fant = dw_3.Object.nm_fantasia[ll_Linha2] + ' - ' + String(dw_3.Object.cd_filial[ll_Linha2]) + ' (' + ls_Rede_Filial + ')'
				
					//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A rede da filial selecionada esta diferente da rede liberada '" + ls_Rede + "' para a promo$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + "Filial: " + ls_Nome_Fant)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A rede da filial selecionada n$$HEX1$$e300$$ENDHEX$$o esta liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + "Filial: " + ls_Nome_Fant, Exclamation!)
					Return False
				End If
			End If
			
		Next 
	End If
	
Next

Return True
end function

public function boolean wf_verifica_inclusao_estoque_minimo ();Long ll_Promocao

String ls_Id_Inclui_Estoque_Min
String ls_SqlErrText

dw_1.AcceptText()

ll_Promocao = dw_1.Object.Cd_Promocao_Sos[1]

Select Coalesce(id_inclui_estoque_minimo, "N")
	Into :ls_Id_Inclui_Estoque_Min
From promocao_sos
Where cd_promocao_sos = :ll_Promocao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao localizar a promo$$HEX2$$e700e300$$ENDHEX$$o na fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_inclusao_estoque_minimo")
	Return False
End If

//Esta fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ utilizada tamb$$HEX1$$e900$$ENDHEX$$m na CO007

If ls_Id_Inclui_Estoque_Min = "S" Then
	Insert Into promocao_sos_estoque_minimo
				(cd_promocao_sos,
				cd_filial,
				cd_produto,
				qt_estoque_minimo,
				nr_matricula_alteracao)
		Select	v.cd_promocao_sos,
				v.cd_filial,
				v.cd_produto,
				1,
				'14330'
	From vw_promocao_estoque_minimo v
		Inner Join resumo_reposicao_estoque r
			On r.cd_filial		= v.cd_filial
			And r.cd_produto	= v.cd_produto
		Inner Join produto_geral g
			On g.cd_produto = v.cd_produto
	Where v.cd_promocao_sos = :ll_Promocao
		And qt_estoque_base = 0
		And v.cd_filial Not In (Select cd_filial
									From parametro_loja x
									Where x.cd_filial = cd_filial
									    And cd_parametro = 'ID_INCLUI_ESTOQUE_MINIMO_AUTOMATICO'
									    And vl_parametro = 'N')
		And substring(g.cd_subcategoria, 1, 1) <> '1'
		And Not Exists (Select *
							From promocao_sos_estoque_minimo m
							Where m.cd_promocao_sos		= v.cd_promocao_sos
							    And m.cd_filial					= v.cd_filial
							    And m.cd_produto				= v.cd_produto)
	Using SqlCa;
	  
	If SqlCa.SqlCode = -1 Then
		ls_SqlErrText = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao Incluir o estoque m$$HEX1$$ed00$$ENDHEX$$nimo autom$$HEX1$$e100$$ENDHEX$$tico. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_inclusao_estoque_minimo " + ls_SqlErrText, StopSign!)
		Return False
	End If
	
	//SqlCa.of_Commit();
End If

Return True
end function

public subroutine wf_seleciona_filial_planilha ();Any la_Dado

Boolean lb_Selecao
Boolean lb_Sucesso = False

Long ll_Linha
Long ll_Linhas
Long ll_Find
Long ll_Filial

String ls_Arquivo,&
		  ls_filial_adm_sap


dw_5.AcceptText()

ls_Arquivo = dw_5.Object.Nm_Arquivo[1]

dc_uo_Excel lo_Excel
lo_Excel = Create dc_uo_Excel

dw_3.SetRedRaw(False)

Open(w_Aguarde)
w_Aguarde.Title = "Importando filiais..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo)) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
	
		For ll_Linha = 1 To ll_Linhas
			
			//C$$HEX1$$f300$$ENDHEX$$digo da filial
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			If Not IsNumber(String(la_Dado)) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo '" + String(la_Dado) + "' da filial inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
				Continue
			End If
			
			If gf_filial_administrada_sap(Long(la_Dado) ,  ls_filial_adm_sap) Then 
				ls_filial_adm_sap = ls_filial_adm_sap
			End If 
			
			If ls_filial_adm_sap='S' Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta filial '" + String(la_Dado) + "' $$HEX1$$e900$$ENDHEX$$ administrada no SAP. Opera$$HEX2$$e700e300$$ENDHEX$$o Inv$$HEX1$$e100$$ENDHEX$$lida!", Exclamation!)
				Continue
			End If 
			
			
			ll_Find = dw_3.Find("cd_filial = " + String(Long(la_Dado)), 1, dw_3.RowCount())
			ll_Filial = Long(la_Dado)
			
			If ll_Find > 0 Then
				If dw_3.Object.Id_Filial[ll_Find] = "N"  Then
					dw_3.Event ue_Seleciona_Filial(ll_Filial, True  )
					dw_3.Object.Id_Filial[ll_Find] = "S"
					lb_Sucesso = True
				End If
			End If
			
			If ll_Find = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a filial na lista de filiais.", Exclamation!)
			End If
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find.", StopSign!)
				lb_Sucesso = False
				Exit
			End If
		Next
	End If
End If

If lb_Sucesso Then
	ivb_Valida_Salva = True
	
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)		
End If

Close(w_Aguarde)
dw_3.SetRedRaw(True)
end subroutine

public function boolean wf_valida_fronteira ();Long ll_Find_1
Long ll_Find_2
Long ll_Find_Desc
Long ll_Promocao

String ls_Nome_Fantasia

/*- Antes de salvar.
- Se a filial 805 estiver selecionada e a promo$$HEX2$$e700e300$$ENDHEX$$o for diferente da 860.
- Se existir algum produto com o percentual maior que zero no desconto normal ou clube mostrar a mensagem abaixo:
  "A filial XXXX que $$HEX1$$e900$$ENDHEX$$ uma filial de fronteira~r. Existem produtos com percentual de desconto normal ou clube maior que zero~r~r. Deseja continuar mesmo assim ?"
- Se a resposta for 'N$$HEX1$$c300$$ENDHEX$$O' ent$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o salva as altera$$HEX2$$e700f500$$ENDHEX$$es.

- Antes de salvar.
- Se a filial 947 estiver selecionada e a promo$$HEX2$$e700e300$$ENDHEX$$o for diferente da 1415.
- Se existir algum produto com o percentual maior que zero no desconto normal ou clube mostrar a mensagem abaixo:  
"A filial XXXX que $$HEX1$$e900$$ENDHEX$$ uma filial de fronteira~r. Existem produtos com percentual de desconto normal ou clube maior que zero~r~r. Deseja continuar mesmo assim ?"
- Se a resposta for 'N$$HEX1$$c300$$ENDHEX$$O' ent$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o salva as altera$$HEX2$$e700f500$$ENDHEX$$es.
*/

dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

ll_Promocao = dw_1.Object.Cd_Promocao_Sos[1]

// Para estas duas 
If ll_Promocao = 860 Or ll_Promocao = 1415 Then Return True

ll_Find_Desc = dw_2.Find("pc_desconto > 0.00 Or pc_desconto_clube > 0.00", 1, dw_2.RowCount())

If ll_Find_Desc > 0 Then
	If ll_Promocao <> 860 Then
		ll_Find_1 = dw_3.Find("id_filial = 'S' And cd_filial = 719", 1, dw_3.RowCount()) + dw_3.Find("id_filial = 'S' And cd_filial = 396", 1, dw_3.RowCount())
		
		If ll_Find_1 > 0 Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Uma das filiais selecionadas $$HEX1$$e900$$ENDHEX$$ de fronteira (MAFRA)." + &
								"~rExistem produtos com percentual de desconto normal ou clube maior que zero." + &
								"~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
				Return False
			End If
		End If
	End If
	
	If ll_Promocao <> 1415 Then
		ll_Find_2 = dw_3.Find("id_filial = 'S' And cd_filial = 778", 1, dw_3.RowCount())
		
		If ll_Find_2 > 0 Then
			ls_Nome_Fantasia = dw_3.Object.Nm_Fantasia[ll_Find_2]
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + ls_Nome_Fantasia + " (778)' $$HEX1$$e900$$ENDHEX$$ uma filial de fronteira." + &
								"~rExistem produtos com percentual de desconto normal ou clube maior que zero." + &
								"~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
				Return False
			End If
		End If
	End If
End If

Return True
end function

public function boolean wf_verifica_desc_maior (boolean al_produto);Return True
end function

public subroutine wf_desabilida_alterar ();
end subroutine

public subroutine wf_desabilita_controles (string as_controle);If as_controle = 'S' Then 

	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promocao foi cadastrada no SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar altera$$HEX2$$e700f500$$ENDHEX$$es, somente no SAP!.", Information!)
	
	cb_importa_produto.enabled  = False				
    cb_importa_filial.enabled = False
	cb_selecao_filial.enabled = False
	cb_selecao_filiais.enabled = False			
	
	dw_1.ivo_Controle_Menu.of_Incluir(False)
	dw_1.ivm_menu.mf_Confirmar(False)
	dw_1.ivm_Menu.mf_Cancelar(False)		
	dw_1.ivo_Controle_Menu.of_Excluir(False)
	
//	dw_1.Object.id_filial_altera_estoque.protect = 1
//	dw_1.Object.id_preco_bloqueado.protect = 1
//	dw_1.Object.id_tipo_encarte.protect = 1
//	dw_1.Object.id_gondola.protect = 1
//	dw_1.Object.nr_promocao_marketing.protect = 1
//	dw_1.Object.dh_inicio_estoque_minimo.protect = 1
//	dw_1.Object.dh_termino_estoque_minimo.protect = 1
//	dw_1.Object.dh_inicio.protect = 1
//	dw_1.Object.dh_termino.protect = 1
//	dw_1.Object.id_situacao.protect = 1
	
	
	
	dw_2.ivo_Controle_Menu.of_Incluir(False)
	dw_2.ivm_menu.mf_Confirmar(False)
	dw_2.ivm_Menu.mf_Cancelar(False)		
	dw_2.ivo_Controle_Menu.of_excluir( False)
	
	dw_3.ivo_Controle_Menu.of_Incluir(False)
	dw_3.ivm_menu.mf_Confirmar(False)
	dw_3.ivm_Menu.mf_Cancelar(False)		
	dw_3.ivo_Controle_Menu.of_excluir( False)

	dw_8.ivm_menu.mf_Confirmar(False)
	dw_8.ivo_Controle_Menu.of_Incluir(False)
	dw_8.ivm_Menu.mf_Cancelar(False)	
	dw_8.ivo_Controle_Menu.of_excluir( False)
		
Else

	cb_importa_produto.enabled  = True
    cb_importa_filial.enabled = True
	cb_selecao_filial.enabled = True
	cb_selecao_filiais.enabled = True			
	
	dw_1.ivo_Controle_Menu.of_Incluir(True)
	dw_1.ivm_menu.mf_Confirmar(True)
	dw_1.ivm_Menu.mf_Cancelar(True)		
	dw_1.ivo_Controle_Menu.of_Excluir(True)
	
//	dw_1.Object.id_filial_altera_estoque.protect = 0
//	dw_1.Object.id_preco_bloqueado.protect = 0
//	dw_1.Object.id_tipo_encarte.protect = 0
//	dw_1.Object.id_gondola.protect = 0
//	dw_1.Object.nr_promocao_marketing.protect = 0
//	dw_1.Object.dh_inicio_estoque_minimo.protect = 0
//	dw_1.Object.dh_termino_estoque_minimo.protect = 0
//	dw_1.Object.dh_inicio.protect = 0
//	dw_1.Object.dh_termino.protect = 0
//	dw_1.Object.id_situacao.protect = 0
//		
	
	dw_2.ivo_Controle_Menu.of_Incluir(True)
	dw_2.ivm_menu.mf_Confirmar(True)
	dw_2.ivm_Menu.mf_Cancelar(True)		
	dw_2.ivo_Controle_Menu.of_excluir( True)
	
	dw_3.ivo_Controle_Menu.of_Incluir(True)
	dw_3.ivm_menu.mf_Confirmar(True)
	dw_3.ivm_Menu.mf_Cancelar(True)		
	dw_3.ivo_Controle_Menu.of_excluir( True)

	dw_8.ivm_menu.mf_Confirmar(True)
	dw_8.ivo_Controle_Menu.of_Incluir(True)
	dw_8.ivm_Menu.mf_Cancelar(True)	
	dw_8.ivo_Controle_Menu.of_excluir( True)
End If 
end subroutine

public subroutine wf_liberacao_ecommerce_botao (long pl_promocao, date adt_inicio, date adt_termino, date adt_movimento, string ps_utiliza_ecommerce);Boolean lb_mostra = False
Long ll_Achou

If adt_movimento <= adt_termino Then
	
	Select count(*) 
	Into :ll_Achou
	From promocao_sos_filial
	where cd_promocao_sos = :pl_promocao
  	    and cd_filial in(select cd_filial_preco from ecommerce_rede where id_ecommerce = '2')
	Using SqlCa;
	
	If SqlCa.SqlCode = - 1 Then
		SqlCa.of_MsgDbError("Erro ao localizar as filiais base para precificar o e-commerce.")
		Return
	End If
	
	If ll_Achou > 0 Then lb_mostra = True
	
	If Not lb_mostra Then
		
		Select count(*) 
		Into :ll_Achou
		From promocao_sos
		where cd_promocao_sos = :pl_promocao
		   and coalesce(id_utiliza_ecommerce, 'S') = 'N'
		Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			SqlCa.of_MsgDbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro ID_UTILIZA_ECOMMERCE.")
			Return
		End If
		
		If ll_Achou > 0 Then lb_mostra = True
				
	End If
	
End If

If ps_utiliza_ecommerce = 'S' Then
	cb_libera_commerce.text = 'Bloq. Utiliza$$HEX2$$e700e300$$ENDHEX$$o e-Commerce'
Else
	cb_libera_commerce.text = 'Libera Utiliza$$HEX2$$e700e300$$ENDHEX$$o e-Commerce'
End If

cb_libera_commerce.visible  = lb_mostra	
end subroutine

on w_ge380_cadastro_promocao.create
int iCurrent
call super::create
this.gb_6=create gb_6
this.cb_selecao_filiais=create cb_selecao_filiais
this.cb_exportar_saldo=create cb_exportar_saldo
this.gb_2=create gb_2
this.cb_selecao_filial=create cb_selecao_filial
this.dw_4=create dw_4
this.dw_2=create dw_2
this.dw_5=create dw_5
this.dw_7=create dw_7
this.dw_3=create dw_3
this.dw_8=create dw_8
this.dw_9=create dw_9
this.cb_importa_produto=create cb_importa_produto
this.cb_importa_filial=create cb_importa_filial
this.gb_3=create gb_3
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.cb_libera_commerce=create cb_libera_commerce
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.cb_selecao_filiais
this.Control[iCurrent+3]=this.cb_exportar_saldo
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.cb_selecao_filial
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.dw_5
this.Control[iCurrent+9]=this.dw_7
this.Control[iCurrent+10]=this.dw_3
this.Control[iCurrent+11]=this.dw_8
this.Control[iCurrent+12]=this.dw_9
this.Control[iCurrent+13]=this.cb_importa_produto
this.Control[iCurrent+14]=this.cb_importa_filial
this.Control[iCurrent+15]=this.gb_3
this.Control[iCurrent+16]=this.dw_1
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.cb_libera_commerce
this.Control[iCurrent+21]=this.gb_1
end on

on w_ge380_cadastro_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_6)
destroy(this.cb_selecao_filiais)
destroy(this.cb_exportar_saldo)
destroy(this.gb_2)
destroy(this.cb_selecao_filial)
destroy(this.dw_4)
destroy(this.dw_2)
destroy(this.dw_5)
destroy(this.dw_7)
destroy(this.dw_3)
destroy(this.dw_8)
destroy(this.dw_9)
destroy(this.cb_importa_produto)
destroy(this.cb_importa_filial)
destroy(this.gb_3)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_libera_commerce)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]

lvo_Update = {dw_1, dw_2, dw_4, dw_9}

This.wf_SetUpdate_DW(lvo_Update)
	
ivo_Promocao = Create uo_Promocao
ivo_Produto  = Create uo_Produto

dw_1.Event ue_AddRow()
//dw_1.Object.id_retira_venda_calculo_eb.Visible = 1

dw_1.SetFocus()

dw_5.InsertRow(0)


dw_1.ivo_Controle_Menu.of_Incluir(True)
dw_2.ivo_Controle_Menu.of_Incluir(True)

ivo_Promocao.ivs_Tipo = "N"
end event

event close;call super::close;Destroy(ivo_Promocao)
Destroy(ivo_Produto)
Destroy(ids)
end event

event ue_cancel;call super::ue_cancel;dw_1.Event ue_AddRow()
end event

event ue_preopen;call super::ue_preopen;dw_4.Visible = False
end event

event ue_preupdate;call super::ue_preupdate;Boolean lb_Permite_Alterar

DateTime lvdh_Parametro, &
        		 lvdh_Inicio, &
	      	lvdh_Termino, &
			lvdh_Inicio_Estoque, &
			lvdh_Termino_Estoque, &
			lvdh_Inicio_Anterior,&
			ldt_Minimo_Inicio_DE,&
			ldt_Minimo_Inicio_Ate,&
			ldt_Minimo_Termino_DE
			
Decimal ldc_Desconto, &
			ldc_Desconto_Ant
			
Long 	lvl_Promocao, &
		lvl_Linhas, &
		lvl_Resposta, &
		lvl_Find, &
		ll_Row, &
		ll_Produto, &
		ll_Linha, &
		ll_Estrutura

String lvs_Terminada, &
		 lvs_Promocao_Ecommerce, &
		 ls_Gondola, &
		 ls_Retorno

dw_1.AcceptText()
dw_2.AcceptText()

If Not wf_Verifica_Rede_Liberada() Then Return False

//If Not wf_Verifica_Usuario_Alteracao(Ref lb_Permite_Alterar) Then Return False

If Not lb_Permite_Alterar Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A matricula '" + ivs_Responsavel + "' n$$HEX1$$e300$$ENDHEX$$o tem permiss$$HEX1$$e300$$ENDHEX$$o para realizar altera$$HEX2$$e700f500$$ENDHEX$$es.", Information!)
	Return False
End If

If ivs_promocao_sap<>"0" Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promocao foi cadastrada no SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar altera$$HEX2$$e700f500$$ENDHEX$$es, somente no SAP!.", Information!)
	Return False
End If 
	


If wf_existe_filiais_desmarcadas() Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Existem filiais que foram desmarcadas e ao continuar o estoque m$$HEX1$$ed00$$ENDHEX$$nimo ser$$HEX1$$e100$$ENDHEX$$ perdido.~r~r" + &
										"Deseja continuar?", Question!, YesNo!, 2 ) = 2 Then Return False
End If

lvdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

lvl_Promocao         			= dw_1.Object.Cd_Promocao_SOS          		[ 1 ]
lvdh_Inicio          				= dw_1.Object.Dh_Inicio             					[ 1 ]
lvdh_Termino         			= dw_1.Object.Dh_Termino               			[ 1 ]
lvdh_Inicio_Estoque  			= dw_1.Object.Dh_Inicio_Estoque_Minimo 		[ 1 ]
lvdh_Termino_Estoque 		= dw_1.Object.Dh_Termino_Estoque_Minimo	[ 1 ]
lvs_Terminada        			= dw_1.Object.Id_Terminada             			[ 1 ]
lvdh_Inicio_Anterior 			= dw_1.Object.Dh_Inicio_Anterior       			[ 1 ]
lvs_Promocao_Ecommerce	= dw_1.Object.Id_Promocao_Ecommerce		[ 1 ]
ls_Gondola						= dw_1.Object.Id_gondola							[ 1 ]
	
If lvs_Terminada = "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promo$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ terminou, portanto nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salva.")
	Return False
End If

lvl_Find = dw_2.Find("cd_produto > 0", 1,  dw_2.RowCount() )	

If lvl_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find dw_2.")
	Return False
End If

If lvl_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um produto.")
	Return False
End If

lvl_Find = 0

lvl_Linhas = dw_4.RowCount()
If lvl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma filial.", Information!)
	Return False
ElseIf lvs_Promocao_Ecommerce = "S" Then
	If lvl_Linhas > 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Est$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ uma promo$$HEX2$$e700e300$$ENDHEX$$o eCommerce. ~r~r" + "Selecione apenas a filial 0790 Beira Rio.", Information!)
		Return False
	Else
		lvl_Find = dw_3.Find("cd_filial = 790", 1, dw_3.RowCount())
		
		If IsNull(lvl_Find) Or lvl_Find <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial 0790 Beira Rio.", StopSign!)
			Return False
		End If
				
		If dw_3.Object.Id_Filial[lvl_Find] = 'N' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Est$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ uma promo$$HEX2$$e700e300$$ENDHEX$$o eCommerce. ~r~r" + "Selecione apenas a filial 0790 Beira Rio.", Information!)					
			Return False
		End If
	End If	
End If

If IsNull(lvdh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return False
End If	

If Not IsNull(lvdh_Termino) Then
	If lvdh_Termino < lvdh_Inicio Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
		dw_1.Event ue_Pos(1, "dh_termino")
		Return False	
	End If
End If
	
If Not IsNull(lvdh_Termino_Estoque) Then
	If IsNull(lvdh_Inicio_Estoque) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo.", Information!)
		dw_1.Event ue_Pos(1, "dh_inicio_estoque_minimo")
		Return False
	End If	
End If

If Not IsNull(lvdh_Inicio_Estoque) Then
	If Not IsNull(lvdh_Termino_Estoque) Then
		If lvdh_Termino_Estoque < lvdh_Inicio_Estoque Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo.", Information!)
			dw_1.Event ue_Pos(1, "dh_termino_estoque_minimo")
			Return False	
		End If
	End If
End If 

If Not IsNull(lvdh_Termino) Then
	If Not IsNull(lvdh_Termino_Estoque) Then
		If lvdh_Termino_Estoque > lvdh_Termino Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
			dw_1.Event ue_Pos(1, "dh_termino_estoque_minimo")
			Return False	
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ definida, portanto a data de t$$HEX1$$e900$$ENDHEX$$rmino para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser informada.", Information!)
		dw_1.Event ue_Pos(1, "dh_termino_estoque_minimo")
		Return False	
	End If
End If

If IsNull(lvl_Promocao) or (Not IsNull(lvl_Promocao) and lvdh_Inicio <> lvdh_Inicio_Anterior) Then
	If lvdh_Inicio < lvdh_Parametro Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser maior ou igual a '" + String(lvdh_Parametro, "dd/mm/yyyy") + "'.", Information!)
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return False
	End If
End If

If lvdh_Termino < lvdh_Parametro Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que '" + String(lvdh_Parametro, "dd/mm/yyyy") + "'.", Information!)
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deveria ser maior ou igual a '" + String(lvdh_Parametro, "dd/mm/yyyy") + "'. ~r~r" + &
	                         "Confirma grava$$HEX2$$e700e300$$ENDHEX$$o assim mesmo ?", Question!, YesNo!, 2) = 2 Then	
									 
		dw_1.Event ue_Pos(1, "dh_termino")
		Return False	
	End If
End If

ldt_Minimo_Inicio_DE 		= DateTime(RelativeDate (Date(lvdh_Inicio), -7))
ldt_Minimo_Inicio_Ate		= lvdh_Inicio // In$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o.

If lvdh_Inicio_Estoque < ldt_Minimo_Inicio_DE or lvdh_Inicio_Estoque > ldt_Minimo_Inicio_Ate Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data para o in$$HEX1$$ed00$$ENDHEX$$cio da reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve estar entre '" +&
						String(ldt_Minimo_Inicio_DE, 'dd/mm/yyyy') + "' (sete dias antes no in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o) at$$HEX1$$e900$$ENDHEX$$ '" +&
						String(ldt_Minimo_Inicio_Ate, 'dd/mm/yyyy') +&
						"' (in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o).~r~rDeseja continuar mesmo assim ?", Question!, YesNo!, 2) = 2 Then
		Return False
	End If
End If

ldt_Minimo_Termino_DE 	= DateTime(RelativeDate (Date(lvdh_Termino), -7))

If lvdh_Termino_Estoque >  ldt_Minimo_Termino_DE Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O t$$HEX1$$e900$$ENDHEX$$rmino da reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser pelo menos sete dias antes do t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o.~r~r" +&
						"Deseja continuar mesmo assim ?", Question!, YesNo!, 2)  = 2 Then
		Return False
	End If	
End If

If lvs_Promocao_Ecommerce = 'S' Then
	lvl_Resposta = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Est$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ uma promoc$$HEX1$$e300$$ENDHEX$$o eCommerce. ~r~r" + "Deseja confirmar essa opera$$HEX2$$e700e300$$ENDHEX$$o?",Question!,YesNo!)
	If lvl_Resposta = 2 Then
		Return False
	End If
End If

If Not gf_ge380_Alerta_Desconto(dw_2, dw_1.Object.id_tipo_promocao[1]) Then Return False

If dw_2.RowCount() > 0 Then
	If ls_Gondola = 'S' Then
	
		lvl_Find = 0
		
		lvl_Find = dw_2.Find("pc_desconto > 0.00", 1, dw_2.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
			Return False
		End If
		
		If lvl_Find > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Promo$$HEX2$$e700e300$$ENDHEX$$o do tipo G$$HEX1$$f400$$ENDHEX$$ndola.~r~rNenhum produto pode ter desconto.")
			dw_2.Event ue_Pos(lvl_Find, "pc_desconto")
			Return False
		End If
		
		lvl_Find = 0
		
		lvl_Find = dw_2.Find("pc_desconto_clube > 0.00", 1, dw_2.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
			Return False
		End If
		
		If lvl_Find > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Promo$$HEX2$$e700e300$$ENDHEX$$o do tipo G$$HEX1$$f400$$ENDHEX$$ndola.~r~rNenhum produto pode ter desconto clube.")
			dw_2.Event ue_Pos(lvl_Find, "pc_desconto_clube")
			Return False
		End If
		
		dw_1.Object.id_tipo_promocao[1] = 'G'
	Else		
		dw_1.Object.id_tipo_promocao[1] = 'N'
	End If
	
	Try
		
		dc_uo_ds_base lds
		lds = Create dc_uo_ds_base
		
		str_ge380_desc_infe_outra_promo st
		
		If Not lds.of_ChangeDataObject("ds_ge380_desc_inferior_outra_promo") Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data store 'ds_ge380_desc_inferior_outra_promo'.", StopSign!)
			Return False
		End If
		
		//Percorre os produtos da promo$$HEX2$$e700e300$$ENDHEX$$o
		For ll_Row = 1 To dw_2.RowCount()
			ll_Produto			= dw_2.Object.Cd_Produto				[ll_Row]
			ldc_Desconto		= dw_2.Object.Pc_Desconto				[ll_Row]
			ldc_Desconto_Ant	= dw_2.Object.Pc_Desconto_Anterior	[ll_Row]
			
			If ldc_Desconto <> ldc_Desconto_Ant Then
			
				lds.Reset()
				
				If lds.Retrieve(ll_Produto) < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar os dados do produto '" + String(ll_Produto) + "'. Data store 'ds_ge380_desc_inferior_outra_promo'.", StopSign!)
					Return False
				End If
				
				lds.AcceptText()
				
				//Percorre os produtos de outra promo$$HEX2$$e700e300$$ENDHEX$$o
				For ll_Linha = 1 To lds.RowCount()
									
					//Se for a promo$$HEX2$$e700e300$$ENDHEX$$o que est$$HEX1$$e100$$ENDHEX$$ sendo alterada n$$HEX1$$e300$$ENDHEX$$o mostra no alerta
					If lds.Object.Cd_Promocao_Sos[ll_Linha] = lvl_Promocao Then Continue
									
					If ldc_Desconto > lds.Object.Pc_Desconto_Atual[ll_Linha] Then					
						ll_Estrutura++
						
						st.Cd_Produto			[ ll_Estrutura ] = lds.Object.Cd_Produto				[ll_Linha]
						st.De_Produto			[ ll_Estrutura ] = lds.Object.De_Produto				[ll_Linha]
						st.Pc_Desconto_Atual	[ ll_Estrutura ] = lds.Object.Pc_Desconto_Atual		[ll_Linha]
						st.Cd_Promocao_Sos	[ ll_Estrutura ] = lds.Object.Cd_Promocao_Sos		[ll_Linha]
						st.Nm_Promocao_Sos	[ ll_Estrutura ] = lds.Object.Nm_Promocao_Sos	[ll_Linha]
						st.Dh_Inicio				[ ll_Estrutura ] = lds.Object.Dh_Inicio					[ll_Linha]
						st.Dh_Termino			[ ll_Estrutura ] = lds.Object.Dh_Termino				[ll_Linha]
						st.Pc_Desconto			[ ll_Estrutura ] = ldc_Desconto
					End If
				Next
			End If //If ldc_Desconto <> ldc_Desconto_Ant Then
		Next
		
	Finally
		If IsValid(lds) Then Destroy(lds)
	End Try
End If

If UpperBound(st.Cd_Produto[]) > 0 Then
	OpenWithParm(w_ge380_desc_prd_inferior_outra_promo, st)
	
	ls_Retorno = Message.StringParm
	
	If IsNull(ls_Retorno) Then Return False
End If

If IsNull(lvl_Promocao) Then
	lvl_Promocao = wf_Proxima_Promocao()
	
	dw_1.Object.Cd_Promocao_SOS[1] = lvl_Promocao
End If

//Habilita Bot$$HEX1$$e300$$ENDHEX$$o Saldo Produto
cb_exportar_saldo.Enabled = True

Return True
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	dw_1.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

event open;call super::open;ids = Create dc_uo_ds_base

If Not ids.of_ChangeDataObject("ds_ge380_produto_normal") Then
	Destroy(ids)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge380_produto_normal'.", StopSign!)
	Return -1
End If

SetNull(ivs_Responsavel)
Boolean lb_Permite_alterar

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE380_LIBERACAO_PROCEDIMENTO", ref ivs_Responsavel) Then 
	Return Close( This )
End If

//If Not wf_verifica_usuario_alteracao(Ref lb_Permite_alterar) Then Return Close( This )


end event

event ue_update;call super::ue_update;If Not wf_Valida_Fronteira() Then Return False

//If Not wf_Verifica_Inclusao_Estoque_Minimo() Then Return False

If Not gf_ge065_Historico_Exclusao_Produto(ids, dw_2, "S") Then Return False

Return True
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge380_cadastro_promocao
integer y = 1424
integer height = 144
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge380_cadastro_promocao
integer y = 1360
integer height = 232
end type

type gb_6 from groupbox within w_ge380_cadastro_promocao
integer x = 3081
integer y = 36
integer width = 443
integer height = 552
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Rede Libera"
borderstyle borderstyle = styleraised!
end type

type cb_selecao_filiais from commandbutton within w_ge380_cadastro_promocao
integer x = 3072
integer y = 644
integer width = 480
integer height = 100
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
end type

event clicked;Boolean lvb_Sucesso = True

Long	lvl_Lojas,&
		lvl_Linha,&
		lvl_Linhas,&
		lvl_Filial,&
		lvl_Find

uo_ge216_filiais uo_filiais

uo_Filiais = Create uo_ge216_filiais

OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)

lvl_Lojas = Message.DoubleParm

//*****************

If lvl_Lojas > 0 Then
	
	lvl_Linhas = UpperBound(uo_Filiais.ivl_filial[])
	
	For lvl_Linha = 1 To lvl_Linhas
		lvl_Filial = uo_Filiais.ivl_filial[lvl_Linha]
		lvl_Find = dw_3.Find("cd_filial = " + String(lvl_Filial), 1, dw_3.RowCount())
		
		If lvl_Find > 0 Then
			// Se a filial n$$HEX1$$e300$$ENDHEX$$o tiver marcada o sistema vai marcar
			If dw_3.Object.Id_Filial[lvl_Find] = "N" and dw_3.Object.id_adm_sap[lvl_Find]    = "N"  Then
				dw_3.Event ue_Seleciona_Filial(lvl_Filial, True   )
				dw_3.Object.Id_Filial[lvl_Find] = "S"
			End If
		Else
			If lvl_Find = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + String(lvl_Filial) + " selecionada n$$HEX1$$e300$$ENDHEX$$o foi localizada na lista de filiais.")
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial '" + String(lvl_Filial) + "'")
				lvb_Sucesso = False
				Exit
			End If
		End If
		
	Next
		
End If

If lvb_Sucesso Then
	Parent.ivb_Valida_Salva = True
	
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)		
End If

//For lvl_Linha = 1 To dw_3.RowCount()
//	If lvb_Selecao Then
//		If dw_3.Object.Id_Filial[lvl_Linha] = "N" Then
//			dw_3.Object.Id_Filial[lvl_Linha] = "S"
//			dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], True)
//		End If
//	Else
//		If dw_3.Object.Id_Filial[lvl_Linha] = "S" Then
//			dw_3.Object.Id_Filial[lvl_Linha] = "N"
//			dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], False)
//		End If
//	End If
//Next

//*****************


Destroy(uo_Filiais)
end event

type cb_exportar_saldo from commandbutton within w_ge380_cadastro_promocao
string tag = "Exporta Saldo dos Produtos das Filiais"
integer x = 704
integer y = 644
integer width = 480
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Saldo (.XLS)"
end type

event clicked;String lvs_Path,&
		lvs_Arquivo,&
		lvs_Promocao

Long	lvl_Promocao

Integer lvi_Retorno

SetPointer(HourGlass!)

//Retrieve
dw_7.Event ue_Recuperar()

SetPointer(Arrow!)

If dw_7.RowCount() > 0 Then
	
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exporta$$HEX2$$e700e300$$ENDHEX$$o (XLS) do saldo produtos da promo$$HEX2$$e700e300$$ENDHEX$$o ?", Question!, YesNo!, 2) = 2 Then
		Return
	End If
				
	lvl_Promocao = dw_1.Object.cd_promocao_sos [1]
	
	//Teste
	lvs_Path = 'C:\Sistemas\CO\Arquivos\Saldo_Promocao_' + String(lvl_Promocao) + '.txt'
	
	//Salva em Excel
	If dw_7.SaveAs(lvs_Path, text!, True) = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
	End If

Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi localizado.")
End If
end event

type gb_2 from groupbox within w_ge380_cadastro_promocao
integer x = 14
integer y = 784
integer width = 2034
integer height = 1152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos "
borderstyle borderstyle = styleraised!
end type

type cb_selecao_filial from commandbutton within w_ge380_cadastro_promocao
integer x = 2574
integer y = 644
integer width = 480
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Todas Filiais"
end type

event clicked;Long lvl_Linha

Boolean lvb_Selecao

String lvs_Titulo,&
			lvs_filial_adm_sap


If This.Text = "&Todas Filiais" Then
	lvs_Titulo  = "&Nenhuma Filial"
	lvb_Selecao = True
Else
	lvs_Titulo  = "&Todas Filiais"
	lvb_Selecao = False
End If

For lvl_Linha = 1 To dw_3.RowCount()
	lvs_filial_adm_sap = dw_3.Object.id_adm_sap[lvl_Linha]
	If lvb_Selecao Then
		If dw_3.Object.Id_Filial[lvl_Linha] = "N" and lvs_filial_adm_sap = "N" Then
			dw_3.Object.Id_Filial[lvl_Linha] = "S"
			dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], True    )
		End If
	Else
		If dw_3.Object.Id_Filial[lvl_Linha] = "S" and lvs_filial_adm_sap ="N" Then
			dw_3.Object.Id_Filial[lvl_Linha] = "N"
			dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], False  )
		End If
	End If
Next

This.Text = lvs_Titulo

Parent.ivb_Valida_Salva = True

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)		
end event

type dw_4 from dc_uo_dw_base within w_ge380_cadastro_promocao
boolean visible = false
integer x = 2839
integer y = 364
integer width = 151
integer height = 88
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_ge380_filial_cadastrada"
end type

event ue_postretrieve;Long lvl_Contador, &
     lvl_Find, &
	  lvl_Filial

For lvl_Contador = 1 To dw_3.RowCount()
	lvl_Filial = dw_3.Object.Cd_Filial[lvl_Contador]
	
	If This.RowCount() > 0 Then
		lvl_Find = This.Find("cd_filial = " + String(lvl_Filial), 1, This.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da lista das filiais da promo$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
			Return pl_Linhas
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		dw_3.Object.Id_Filial						[lvl_Contador] = "S"
		dw_3.Object.Id_marcacao_anterior	[lvl_Contador] = "S"
	Else
		dw_3.Object.Id_Filial						[lvl_Contador] = "N"
		dw_3.Object.Id_marcacao_anterior	[lvl_Contador] = "N"
	End If
Next

Return pl_Linhas
end event

event ue_recuperar;// Override
Long lvl_Promocao

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Promocao
	  
lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS[lvl_Linha] = lvl_Promocao
	End If
Next

Return 1
end event

type dw_2 from dc_uo_dw_base within w_ge380_cadastro_promocao
integer x = 41
integer y = 840
integer width = 1984
integer height = 1076
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge380_produto_normal"
boolean vscrollbar = true
end type

event ue_recuperar;// Override
Long lvl_Promocao

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event editchanged;call super::editchanged;//
//If ivl_promocao_sap >0 Then 
//	Parent.ivm_Menu.mf_Confirmar(False)
//	Parent.ivm_Menu.mf_Cancelar(False)
//	cb_exportar_saldo.Enabled = False
//Else
//	Parent.ivm_Menu.mf_Confirmar(True)
//	Parent.ivm_Menu.mf_Cancelar(True)
//	cb_exportar_saldo.Enabled = True
//End If 

If gf_promocao_sap ( ivl_promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
   	   wf_desabilita_controles('S')
	Else
   	   wf_desabilita_controles('N')
	End If 				
End If 
end event

event ue_preupdate;call super::ue_preupdate;Date lvdt_Alteracao

DateTime lvdh_Atual
DateTime lvdh_Inicio

Long lvl_Linha
Long lvl_Promocao
	  
dw_1.AcceptText()
dw_2.AcceptText()

lvdh_Atual = gvo_Parametro.of_Dh_Movimentacao()

lvdh_Inicio = dw_1.Object.dh_inicio[1] 
If Date(lvdh_Inicio) = Date(lvdh_Atual) Then 
	lvdt_Alteracao = Date(lvdh_Atual)
Else	
	lvdt_Alteracao = RelativeDate(Date(lvdh_Atual), 1)
End If 

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

For lvl_Linha = 1 To This.RowCount()
	
	If IsNull(This.Object.cd_produto[lvl_Linha]) Then
		This.DeleteRow(lvl_Linha)
		Continue
	End If
	
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS		[ lvl_Linha ] = lvl_Promocao
		This.Object.Dh_Alteracao  				[ lvl_Linha ] = lvdt_Alteracao
		This.Object.nr_matricula_alteracao	[ lvl_Linha ] = ivs_Responsavel
	Else
		If (This.Object.Pc_Desconto[lvl_Linha] <> This.Object.Pc_Desconto_Anterior[lvl_Linha]) Or &
			(This.Object.pc_desconto_clube[lvl_Linha] <> This.Object.pc_desconto_clube_anterior[lvl_Linha]) Then
				This.Object.Dh_Alteracao						[ lvl_Linha ] = lvdt_Alteracao
				This.Object.nr_matricula_alteracao			[ lvl_Linha ] = ivs_Responsavel
				This.Object.pc_desconto_clube_anterior		[ lvl_Linha ] = This.Object.pc_desconto_clube	[ lvl_Linha ]
				This.Object.Pc_Desconto_Anterior				[ lvl_Linha ] = This.Object.Pc_Desconto			[ lvl_Linha ]
		End If
	End If
Next

Return 1
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()

	Choose Case lvs_Coluna
		Case "de_produto"		
			wf_Localiza_Produto()	
			
		Case "pc_desconto_clube"
			This.Event ue_AddRow()
	End Choose
End If

If Key = KeyF2! Then
	Event ue_Simula_Precos()
End If

If Key = KeyF3! Then
	Event ue_Copia_Promocao()
End If

If Key = KeyF4! Then
	Event ue_Salva_Produtos_Excel()
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull(cd_produto)", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto", "de_produto", "pc_desconto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o", "Desconto (%)"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()

dw_2.of_SetRowSelection( "if(pc_desconto > 75.00 or pc_desconto_clube > 75.00,  if(getrow() = currentrow(), rgb(255, 0, 0), rgb(255,255,255)),  if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "if( pc_desconto > 75.00 or pc_desconto_clube > 75.00, RGB(255,0, 0), RGB(0,0,0))", False )
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then	
	This.ivo_Controle_Menu.of_Excluir(True)	
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then 
		This.ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;ids.Reset()

If pl_Linhas > 0  Then
	
	If Long(ivs_promocao_sap)  >0 Then 
		This.ivo_Controle_Menu.of_Excluir(False)
		This.ivo_Controle_Menu.of_Filtrar(False)
		This.ivo_Controle_Menu.of_Classificar(False)
	Else
		This.ivo_Controle_Menu.of_Excluir(True)
		This.ivo_Controle_Menu.of_Filtrar(True)
		This.ivo_Controle_Menu.of_Classificar(True)
		
		If dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, ids, 1, Primary!) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy.", StopSign!)
			Return -1
		End If
	End If 
	
Else
	This.ivo_Controle_Menu.of_Excluir(False)
	This.ivo_Controle_Menu.of_Filtrar(False)
	This.ivo_Controle_Menu.of_Classificar(False)
End If

Return pl_Linhas
end event

event itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "pc_desconto"
		If Dec(data) < 0 Or Dec(data) >= 100 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto informado inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			This.Object.pc_desconto[ Row ] = 0.00
			Return 1
		End If
		
	Case "pc_desconto_clube"
		If Dec(data) < 0 Or Dec(data) >= 100 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto do clube inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			This.Object.pc_desconto_clube[ Row ] = 0.00
			Return 1
		End If	
		
End Choose
end event

type dw_5 from dc_uo_dw_base within w_ge380_cadastro_promocao
boolean visible = false
integer x = 46
integer y = 1208
integer width = 1975
integer height = 96
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge380_selecao_arquivo"
end type

type dw_7 from dc_uo_dw_base within w_ge380_cadastro_promocao
boolean visible = false
integer x = 2857
integer y = 544
integer width = 137
integer height = 108
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string dataobject = "ds_ge380_saldo_produto"
end type

event ue_recuperar;//OverRide

Long lvl_Promocao

dw_1.AcceptText()

lvl_Promocao = dw_1.Object.cd_promocao_sos	[1]

Return Retrieve(lvl_Promocao)
end event

type dw_3 from dc_uo_dw_base within w_ge380_cadastro_promocao
event ue_seleciona_filial ( long pl_filial,  boolean pb_selecao )
event ue_mousemove pbm_mousemove
integer x = 2107
integer y = 840
integer width = 1435
integer height = 1076
integer taborder = 50
string dataobject = "dw_ge380_filial"
boolean vscrollbar = true
end type

event ue_seleciona_filial(long pl_filial, boolean pb_selecao);Long lvl_Linha

lvl_Linha = dw_4.Find("cd_filial = " + String(pl_Filial), 1, dw_4.RowCount())

If lvl_Linha > 0 Then
	If pb_Selecao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(pl_Filial) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	Else
		dw_4.DeleteRow(lvl_Linha)
	End If
Else
	If pb_Selecao Then
		lvl_Linha = dw_4.InsertRow(0)	
		dw_4.Object.Cd_Filial[lvl_Linha] = pl_Filial
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(pl_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	End If
End If

end event

event ue_mousemove;//If This.RowCount() > 0 Then
//	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and &
//		  ypos >= 0 and ypos < 40 Then	 
//		
//		st_confirmar.Visible = True
//		
//		If ivb_Check Then
//			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
//		Else
//			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
//		End If
//	Else
//		st_confirmar.Visible = False
//	End If
//End If
end event

event itemchanged;call super::itemchanged;Boolean lvb_Selecao
String lvs_adm_sap

If Data = "S" Then
	lvb_Selecao = True
Else
	lvb_Selecao = False
End If


This.Event ue_Seleciona_Filial(This.Object.Cd_Filial[Row], lvb_Selecao )
cb_exportar_saldo.Enabled = False

If Long(ivs_promocao_sap) >0 Then 
	Parent.ivb_Valida_Salva = False
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
Else
	Parent.ivb_Valida_Salva = True
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)
	
End If
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_preretrieve;call super::ue_preretrieve;String lvs_Rede

//dw_6.AcceptText()
//
//lvs_Rede = dw_6.Object.id_tipo[1]
//
//If lvs_Rede <> 'TD' Then
//	This.of_AppendWhere("p.vl_parametro = '" + lvs_Rede + "'")
//End If
//
//cb_Selecao_Filial.Text = "&Todas Filiais"

return 1
end event

event constructor;call super::constructor;ivb_Ordena_Colunas = True
end event

event ue_key;call super::ue_key;If Key = KeyF2! Then
	Event ue_Simula_Precos()
End If

If Key = KeyF3! Then
	Event ue_Copia_Promocao()
End If

If Key = KeyF4! Then
	Event ue_Salva_Produtos_Excel()
End If
end event

event editchanged;call super::editchanged;
//If ivl_promocao_sap >0 Then 
//	Parent.ivm_Menu.mf_Confirmar(False)
//	Parent.ivm_Menu.mf_Cancelar(False)
//	cb_exportar_saldo.Enabled = False
//End If 
//
//


If gf_promocao_sap ( ivl_promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
   	   wf_desabilita_controles('S')
	Else
   	   wf_desabilita_controles('N')
	End If 				
End If 
end event

type dw_8 from dc_uo_dw_base within w_ge380_cadastro_promocao
event ue_seleciona_rede ( string ps_rede,  boolean pb_selecao )
integer x = 3118
integer y = 100
integer width = 375
integer height = 464
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge380_rede"
boolean vscrollbar = true
end type

event ue_seleciona_rede(string ps_rede, boolean pb_selecao);Long lvl_Linha

lvl_Linha = dw_9.Find("id_rede_filial = '" + ps_Rede + "'", 1, dw_9.RowCount())

If lvl_Linha > 0 Then
	If pb_Selecao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A rede '" + ps_Rede + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	Else
		dw_9.DeleteRow(lvl_Linha)
	End If
Else
	If pb_Selecao Then
		lvl_Linha = dw_9.InsertRow(0)			
		
		dw_9.Object.id_rede_filial[lvl_Linha] = ps_Rede
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rede '" + ps_Rede + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	End If
End If
end event

event itemchanged;call super::itemchanged;Boolean lvb_Selecao

If Data = "S" Then
	lvb_Selecao = True
Else
	lvb_Selecao = False
End If

This.Event ue_Seleciona_Rede(This.Object.id_rede_filial[Row], lvb_Selecao)


If Long(ivs_promocao_sap) >0 Then 
	Parent.ivb_Valida_Salva = False
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
Else
	Parent.ivb_Valida_Salva = True
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)	
End If 
end event

event ue_preinsertrow;// OverRide

Return 0
end event

type dw_9 from dc_uo_dw_base within w_ge380_cadastro_promocao
boolean visible = false
integer x = 2834
integer y = 248
integer width = 178
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge380_rede_cadastrada"
end type

event ue_recuperar;// Override
Long lvl_Promocao

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Promocao
	  
lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS[lvl_Linha] = lvl_Promocao
	End If
Next

Return 1
end event

event ue_postretrieve;call super::ue_postretrieve;Long 	lvl_Contador, &
     	lvl_Find
	  
String ls_Rede

For lvl_Contador = 1 To dw_8.RowCount()
	ls_Rede = dw_8.Object.id_rede_filial[lvl_Contador]
	
	If This.RowCount() > 0 Then
		lvl_Find = This.Find("id_rede_filial = '" + ls_Rede + "'", 1, This.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da lista de redes liberadas.", StopSign!)
			Return pl_Linhas
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		dw_8.Object.id_rede	[lvl_Contador] = "S"
	Else
		dw_8.Object.id_rede	[lvl_Contador] = "N"
	End If
Next

Return pl_Linhas
end event

type cb_importa_produto from commandbutton within w_ge380_cadastro_promocao
integer x = 18
integer y = 644
integer width = 658
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir Produto (.XLS)"
end type

event clicked;String lvs_Path,         &
       lvs_Nome_Arquivo, &
		 lvs_Arquivo,      &
		 lvs_Dado,         &
		 lvs_Msg,          &
		 lvs_Nulo
		 
Integer lvi_Arquivo

Decimal lvdc_Desconto
Decimal lvdc_Desconto_Clube
Decimal lvdc_Retorno

Long lvl_Linhas,   & 
	  lvl_Linha,    &
	  lvl_Produto,  &
	  lvl_Promocao
	  
Integer lvi_Retorno, &
        lvi_Nulo
		  
dw_1.AcceptText()

lvl_Promocao = dw_1.Object.cd_promocao_sos[1]

If IsNull(lvl_Promocao) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	dw_1.Event ue_Pos(1, "de_localizacao")
	Return
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Para importar a planilha de produtos os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A = Produto.~r" + &
					"Coluna B = Desconto. ~r" + &
					"Coluna C = Desconto do Clube")
			
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo <> 1 Then Return

ivl_Linhas = 0

dw_5.Object.nm_arquivo[1] = lvs_Path

lvs_Msg = "Importar os produtos com os descontos do arquivo selecionado ?"
		  
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

dw_2.SetRedRaw(False)

dw_5.AcceptText()

lvs_Arquivo = dw_5.Object.nm_arquivo [1]

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
			
			lvdc_Desconto 			= 0.00
			lvdc_Desconto_clube 	= 0.00
			
			lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A"))
	
			If IsNumber(lvs_Dado) Then
				lvl_Produto = Long(lvs_Dado)
	
				//Desconto
				lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B"))
				
				If Not wf_valida_desconto( lvl_Linha, lvs_Dado, Ref lvdc_Desconto) Then Exit
						
				//Desconto Clube
				lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C"))
				
				If Not wf_valida_desconto( lvl_Linha, lvs_Dado, Ref lvdc_Desconto_clube) Then Exit
				
				//Inclui Promocao_SOS_produto
				If Not wf_Inclui_Promocao_SOS_Produto(lvl_Produto, lvdc_Desconto, lvdc_Desconto_Clube) Then
					Exit
				End If
				
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
		End If

	End If //Linha

End If //Excel

Close(w_Aguarde)

dw_2.SetRedRaw(True)

Destroy(lvo_Excel)
end event

type cb_importa_filial from commandbutton within w_ge380_cadastro_promocao
integer x = 2075
integer y = 644
integer width = 480
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Filial (.XLS)"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para importar a planilha de filiais os dados devem estar da seguinte forma: (SEM CABE$$HEX1$$c700$$ENDHEX$$ALHO)~r" + &
				"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da Filial" )
				
li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_5.Object.Nm_Arquivo[1] = Upper(ls_Arquivo)
	wf_Seleciona_Filial_Planilha()
Else
	SetNull(ls_Nulo)
	dw_5.Object.Nm_Arquivo[1] = ls_Nulo
End If
end event

type gb_3 from groupbox within w_ge380_cadastro_promocao
integer x = 2075
integer y = 784
integer width = 1486
integer height = 1152
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filiais"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge380_cadastro_promocao
integer x = 37
integer y = 52
integer width = 3040
integer height = 548
string dataobject = "dw_ge380_promocao"
end type

event constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}

This.of_SetColSelection(True)
end event

event editchanged;// Override

dw_1.AcceptText()
ivl_promocao = This.Object.Cd_Promocao_SOS[1]

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
		
		If gf_promocao_sap ( ivl_promocao ,  ivs_promocao_sap ) Then 			
				If Long(ivs_promocao_sap)>0 Then 
		       	   wf_desabilita_controles('S')
				Else
		       	   wf_desabilita_controles('N')
				End If 				
		End If 
		
		//Parent.ivm_Menu.mf_Confirmar(True)
		//Parent.ivm_Menu.mf_Cancelar(True)		
		
		cb_exportar_saldo.Enabled = False
		
	End If
End If

If dwo.Name = "dh_inicio" Then
	If IsNull(dw_1.Object.Cd_Promocao_Sos[1]) Then
		If Not IsNull(Data) And IsDate(Data) Then
			dw_1.Object.Dh_Inicio_Estoque_Minimo		[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Inicio		[1]), - 7))
		End If
	End If
End If

If dwo.Name = "dh_termino" Then
	If IsNull(dw_1.Object.Cd_Promocao_Sos[1]) Then
		If Not IsNull(Data) And IsDate(Data) Then
			dw_1.Object.Dh_Inicio_Estoque_Minimo		[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Inicio		[1]), - 7))
			dw_1.Object.Dh_Termino_Estoque_Minimo	[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Termino	[1]), - 7))
		End If
	End If
End If
end event

event ue_key;String lvs_Promocao


If Key = KeyEnter! Then
	If This.GetColumnName() = "de_localizacao" Then
		lvs_Promocao = This.GetText()

		ivo_Promocao.of_Localiza(lvs_Promocao)

		If ivo_Promocao.Localizado Then
			
			dw_8.Reset()
			dw_8.Event ue_Retrieve()
			
			If Not wf_Grava_Rede_liberada() Then Return
			
			This.Object.Cd_Promocao_SOS[1] = ivo_Promocao.Cd_Promocao
			
			If gf_promocao_sap ( This.Object.Cd_Promocao_SOS[1] ,  ivs_promocao_sap ) Then 			
				If Long (ivs_promocao_sap) >0 Then 
		       	   wf_desabilita_controles('S')
				Else
		       	   wf_desabilita_controles('N')
				End If 
			End If 
			
			dw_3.Event ue_Retrieve()
			This.Event ue_Retrieve()
			cb_exportar_saldo.Enabled = True
			
		End If
	End If
End If

If Key = KeyF2! Then
	Event ue_Simula_Precos()
End If

If Key = KeyF3! Then
	Event ue_Copia_Promocao()
End If

If Key = KeyF4! Then
	Event ue_Salva_Produtos_Excel()
End If
end event

event ue_recuperar;// Override

Long lvl_Promocao
Long lvl_Promocao_Sap

This.AcceptText()

lvl_Promocao = This.Object.Cd_Promocao_SOS[1]


If IsNull(lvl_Promocao) or lvl_Promocao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o para recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es.", Information!)
	Return -1
End If


Return This.Retrieve(lvl_Promocao)
end event

event ue_postretrieve;Date 	lvdh_Atual, &
    		lvdh_Inicio, &
		lvdh_Termino

Long ll_Promocao

dw_1.AcceptText()

If pl_Linhas > 0 Then
	
	ll_Promocao 	= This.Object.cd_promocao_sos	[1]
	lvdh_Inicio  		= Date(This.Object.Dh_Inicio      			[1])
	lvdh_Termino 	= Date(This.Object.Dh_Termino     		[1])
	lvdh_Atual   		= Date(This.Object.Dh_Movimentacao	[1])
	
	wf_liberacao_ecommerce_botao(ll_Promocao, lvdh_Inicio, lvdh_Termino, lvdh_Atual, This.Object.id_utiliza_ecommerce	[1])
		
	If lvdh_Inicio <= lvdh_Atual Then
		This.Object.Dh_Inicio.Protect = 1
		//dw_3.Object.Id_Filial.Protect = 1
		
		//cb_Selecao_Filial.Enabled = False
	Else
		This.Object.Dh_Inicio.Protect = 0
		dw_3.Object.Id_Filial.Protect = 0
		
		cb_Selecao_Filial.Enabled = True
	End If
			
	dw_2.Event ue_Retrieve()
	dw_4.Event ue_Retrieve()
	dw_9.Event ue_Retrieve()
			
	If lvdh_Atual > lvdh_Termino Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promo$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ terminou, portanto nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salva.")		
		
		This.Object.Id_Terminada[1] = "S"
	End If
		
	This.SetFocus()
End If

Return pl_LInhas
end event

event ue_preretrieve;call super::ue_preretrieve;If wf_Valida_Salva() < 0 Then
	Return -1
Else
	Return 1
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If wf_Valida_Salva() < 0 Then
	Return -1
Else
	This.Reset()
	Return 1
End If
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.Object.Dh_Inicio.Protect  		= 0
	This.Object.Dh_Termino.Protect 	= 0
//	This.Object.id_retira_venda_calculo_eb.Visible = 1
	
	dw_3.Object.Id_Filial.Protect 		= 0
		
	cb_Selecao_Filial.Enabled = True
	
	Parent.ivb_Valida_Salva = False
	
	dw_2.Reset()
	dw_3.Reset()
	dw_3.Event ue_Retrieve()
	dw_8.Event ue_Retrieve()
	dw_4.Reset()
	dw_9.Reset()

	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
End If

Return AncestorReturnValue
end event

event itemchanged;// Override

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	
	
//	Parent.ivm_Menu.mf_Confirmar(True)
	//Parent.ivm_Menu.mf_Cancelar(True)		
	
	If gf_promocao_sap ( This.Object.Cd_Promocao_SOS[1] ,  ivs_promocao_sap ) Then 			
		If Long(ivs_promocao_sap)>0 Then 
			ivw_ParentWindow.ivb_Valida_Salva = False
       	   wf_desabilita_controles('S')		
		Else
			ivw_ParentWindow.ivb_Valida_Salva =True 
       	   wf_desabilita_controles('N')					
		End If 			
	End If 
	
	
End If


end event

event ue_deleterow;// OverRide

dw_2.SetFocus()

dw_2.Event ue_DeleteRow()

Return True


end event

event ue_preupdate;call super::ue_preupdate;This.Object.Nr_Matricula_Alteracao[1] = ivs_Responsavel

Return AncestorReturnValue
end event

type st_1 from statictext within w_ge380_cadastro_promocao
integer x = 27
integer y = 1972
integer width = 997
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Simula Pre$$HEX1$$e700$$ENDHEX$$os dos Produtos [F2]"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge380_cadastro_promocao
integer x = 1038
integer y = 1972
integer width = 923
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Copia de Outra Promo$$HEX2$$e700e300$$ENDHEX$$o [F3]"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ge380_cadastro_promocao
integer x = 1979
integer y = 1972
integer width = 905
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Salva Produtos em Excel [F4]"
boolean focusrectangle = false
end type

type cb_libera_commerce from commandbutton within w_ge380_cadastro_promocao
boolean visible = false
integer x = 1207
integer y = 644
integer width = 855
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Libera e-Commerce"
end type

event clicked;Long ll_Promocao

String ls_Utiliza_Ecommerce
String ls_Mensagem
String ls_Flag
String ls_Log
String ls_Text

dw_1.AcceptText()

If dw_1.RowCount() = 0 Then Return
	
ls_Utiliza_Ecommerce 	= dw_1.Object.id_utiliza_ecommerce	[1]
ll_Promocao					= dw_1.Object.cd_promocao_sos		[1]

If ls_Utiliza_Ecommerce = 'N' Then
	ls_Mensagem = "Deseja liberar a utiliza$$HEX2$$e700e300$$ENDHEX$$o das condi$$HEX2$$e700f500$$ENDHEX$$es da promo$$HEX2$$e700e300$$ENDHEX$$o [" + String(ll_Promocao) + "] para o e-Commerce ?"
	ls_Flag = 'S'
	ls_Text = 'Bloq. Utiliza$$HEX2$$e700e300$$ENDHEX$$o e-Commerce'
Else
	ls_Mensagem = "Deseja bloquear a utiliza$$HEX2$$e700e300$$ENDHEX$$o das condi$$HEX2$$e700f500$$ENDHEX$$es da promo$$HEX2$$e700e300$$ENDHEX$$o [" + String(ll_Promocao) + "] para o e-Commerce ?"
	ls_Flag = 'N'
	ls_Text = 'Libera Utiliza$$HEX2$$e700e300$$ENDHEX$$o e-Commerce'
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Question!, YesNo!, 2) = 1 Then
	
	cb_libera_commerce.text = ls_Text
	
	update promocao_sos
	set id_utiliza_ecommerce = :ls_Flag
	where cd_promocao_sos = :ll_Promocao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao mudar o par$$HEX1$$e200$$ENDHEX$$metro ID_UTILIZA_ECOMMERCE.")
		SqlCa.of_RollBack()
	End If
	
	If gf_grava_historico_alteracao_tabela(	'PROMOCAO_SOS', &
														String(ll_Promocao),& 
														'ID_UTILIZA_ECOMMERCE', &
														ls_Utiliza_Ecommerce, &
														ls_Flag, &
														gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, &
														'A', ref ls_Log, True) Then
		SqlCa.of_Commit()
		dw_1.Event ue_Recuperar()
	End If
End If

	

end event

type gb_1 from groupbox within w_ge380_cadastro_promocao
integer x = 14
integer width = 3543
integer height = 628
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Promo$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

