HA$PBExportHeader$w_ge438_altera_preco_regional.srw
forward
global type w_ge438_altera_preco_regional from dc_w_cadastro_selecao_lista
end type
type dw_3 from dc_uo_dw_base within w_ge438_altera_preco_regional
end type
type cb_historico_preco_venda from commandbutton within w_ge438_altera_preco_regional
end type
type cb_historico_preco_reposicao from commandbutton within w_ge438_altera_preco_regional
end type
type cb_importa_planilha from commandbutton within w_ge438_altera_preco_regional
end type
type cb_1 from commandbutton within w_ge438_altera_preco_regional
end type
type gb_3 from groupbox within w_ge438_altera_preco_regional
end type
end forward

global type w_ge438_altera_preco_regional from dc_w_cadastro_selecao_lista
integer width = 3552
integer height = 2044
string title = "GE438 - Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o Regionalizado"
dw_3 dw_3
cb_historico_preco_venda cb_historico_preco_venda
cb_historico_preco_reposicao cb_historico_preco_reposicao
cb_importa_planilha cb_importa_planilha
cb_1 cb_1
gb_3 gb_3
end type
global w_ge438_altera_preco_regional w_ge438_altera_preco_regional

type variables
uo_filial 				io_filial				//GE009
uo_produto 			io_produto			//GE001

end variables

forward prototypes
public subroutine wf_verifica_produto_bloqueado ()
public function boolean wf_produto_ja_cadastrado (long pl_filial, long pl_produto)
public function boolean wf_localiza_inf_preco (string as_uf, long al_produto, ref decimal adc_preco_venda_atual, ref datetime adh_preco_venda_atual)
public function boolean wf_localiza_uf (long al_filial, ref string as_uf)
public function boolean wf_verifica_produto_bloqueado (ref string as_produto_bloqueado, string as_uf)
public subroutine wf_preco_atual (long al_produto, long al_filial, long al_linha)
public function boolean wf_verifica_bloqueio (long al_produto, long al_filial, long al_linha, date adt_movimento)
public function integer wf_localiza_produto (long al_filial, long al_produto, ref string as_descricao, ref decimal adc_preco_venda_atual, ref date adt_data_preco_venda_atual, ref string as_matricula_preco_venda_atual, string as_chave, ref decimal adc_fat_conv, ref string as_controle_preco)
end prototypes

public subroutine wf_verifica_produto_bloqueado ();Long ll_Produto
Long ll_Linhas
Long ll_Row

Date ldt_Vigencia

String ls_Uf

dw_1.AcceptText()
dw_2.AcceptText()

ldt_Vigencia = dw_1.Object.dt_inicio_vigencia[1]

SetRedRaw(False)

ll_Linhas = dw_2.RowCount()

For ll_Row = 1 To ll_Linhas
	ll_Produto = dw_2.Object.cd_produto[ll_Row]
	ls_Uf = dw_2.Object.Cd_Unidade_Federacao[ll_Row]
			
	dw_2.Object.id_preco_bloqueado_promocao[ll_Row] = io_Produto.of_verifica_preco_bloqueado_promocao(ll_Produto, ldt_Vigencia, ls_Uf)
	
	If dw_2.Object.id_preco_bloqueado[ll_Row] = 'S' or dw_2.Object.id_preco_bloqueado_promocao[ll_Row] = 'S' Then
		dw_2.Object.id_controle_bloqueado[ll_Row] = 'S'
	Else
		dw_2.Object.id_controle_bloqueado[ll_Row] = 'N'
	End If
Next

SetRedRaw(True)


end subroutine

public function boolean wf_produto_ja_cadastrado (long pl_filial, long pl_produto);Long ll_Produto

Select cd_produto into :ll_Produto
From preco_regionalizado
Where cd_filial  	= :pl_filial
  and cd_produto 	= :pl_produto;

IF SQLCA.Sqlcode = -1 THEN
	SQLCA.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de preco regionalizado.")
	RETURN TRUE
ELSEIF SQLCA.Sqlcode = 0 THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto j$$HEX1$$e100$$ENDHEX$$ esta cadastrado para esta filial.",Information!)
	RETURN TRUE
END IF

RETURN FALSE
end function

public function boolean wf_localiza_inf_preco (string as_uf, long al_produto, ref decimal adc_preco_venda_atual, ref datetime adh_preco_venda_atual);Select vl_preco_venda_atual, dh_preco_venda_atual
	Into :adc_Preco_Venda_Atual, :adh_Preco_Venda_Atual
From produto_uf
Where cd_unidade_federacao = :as_Uf
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pre$$HEX1$$e700$$ENDHEX$$o e a data do pre$$HEX1$$e700$$ENDHEX$$o atual da produto_uf. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_localiza_inf_preco.", StopSign!)
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o pre$$HEX1$$e700$$ENDHEX$$o e a data do pre$$HEX1$$e700$$ENDHEX$$o atual")
		Return False
End Choose
end function

public function boolean wf_localiza_uf (long al_filial, ref string as_uf);Select cd_uf
	Into :as_Uf
From vw_filial
Where cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a UF da filial na wf_filial. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_localiza_uf.", StopSign!)
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar a uf da filial.")
		Return False
End Choose
end function

public function boolean wf_verifica_produto_bloqueado (ref string as_produto_bloqueado, string as_uf);Date lvdt_Vigencia

String lvs_Bloqueio_Promocao
String ls_Mensagem

dw_1.AcceptText()
dw_2.AcceptText()

lvdt_Vigencia = dw_1.Object.dt_inicio_vigencia[1]

lvs_Bloqueio_Promocao = io_Produto.of_verifica_preco_bloqueado_promocao(io_Produto.cd_produto, lvdt_Vigencia, as_Uf)

If io_Produto.id_preco_bloqueado = 'S' or lvs_Bloqueio_Promocao = 'S' Then
	as_Produto_Bloqueado = 'S'
Else
	as_Produto_Bloqueado = 'N'
End If

//If as_Produto_Bloqueado = 'S' Then
//	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Este produto est$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado no cadastro de produto ou em alguma promo$$HEX2$$e700e300$$ENDHEX$$o.~r"+&
//					  "Produto : (" + String(io_Produto.cd_produto) + ") " + io_Produto.ivs_Descricao_Apresentacao_Estoque + ".~r~r" +&
//			     		"Deseja inclu$$HEX1$$ed00$$ENDHEX$$-lo mesmo assim ?",Question!, YesNo!, 2) = 1 Then 
//	  as_Produto_Bloqueado = 'N'					  
//	Else
//		Return False
//	End If
//End If

If io_Produto.id_preco_bloqueado = "S" And lvs_Bloqueio_Promocao = "S" Then
	ls_Mensagem = "~rest$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado no cadastro de produtos e na promo$$HEX2$$e700e300$$ENDHEX$$o."
End If	
	
If io_Produto.id_preco_bloqueado = "S" And lvs_Bloqueio_Promocao = "N" Then
	ls_Mensagem = "~rest$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado no cadastro de produtos."
End If	

If io_Produto.id_preco_bloqueado = "N" And lvs_Bloqueio_Promocao = "S" Then
	ls_Mensagem = "~rest$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado na promo$$HEX2$$e700e300$$ENDHEX$$o."
End If	

If io_Produto.id_preco_bloqueado = "S" Or lvs_Bloqueio_Promocao = "S" Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto " + io_Produto.ivs_Descricao_Apresentacao_Estoque + " (" + String(io_Produto.cd_produto) + ")" + &
						ls_Mensagem + "~r~rDeseja inclu$$HEX1$$ed00$$ENDHEX$$-lo mesmo assim ?", Question!, YesNo!, 2) = 2 Then 
		as_Produto_Bloqueado = 'S'
		Return False
	Else
		as_Produto_Bloqueado = 'N'
	End If
End If

Return True
end function

public subroutine wf_preco_atual (long al_produto, long al_filial, long al_linha);io_produto.of_Localiza_Produto(String(al_produto))

If io_produto.Localizado Then
	
	If Isnull(dw_2.Object.vl_preco_atual[al_linha]) Then
		dw_2.Object.vl_preco_atual			[al_linha] = round(io_produto.of_Preco_Venda_Filial_Matriz( al_filial ) * io_produto.vl_fator_conversao, 2)
	End If
	
	dw_2.Object.pc_desconto_atual	[al_linha] = io_produto.Of_Desconto_Filial( al_filial )
													
	//lvdc_Desconto_Clube = ivo_Produto.of_Desconto_Clube_Filial(lvl_Filial)
	//If lvdc_Desconto_Clube = 0 Then lvdc_Desconto_Clube = lvl_Nulo 
	//This.Object.pc_desconto_clube[lvl_Linha] = lvdc_Desconto_Clube
End If

end subroutine

public function boolean wf_verifica_bloqueio (long al_produto, long al_filial, long al_linha, date adt_movimento);Long ll_Achou

//select count(*)
//Into :ll_Achou
//from vw_promocao_estoque_minimo v
//where v.cd_produto = :al_produto
//  and v.cd_filial = :al_filial
//  and v.id_preco_bloqueado = 'S' 
//  and v.id_situacao = 'L'
//Using SqlCa;

select count(*)
Into :ll_Achou
from promocao_sos x
inner join promocao_sos_produto y
	on y.cd_promocao_sos		= x.cd_promocao_sos 
inner join promocao_sos_filial f
	on f.cd_promocao_sos = x.cd_promocao_sos
where x.dh_inicio 			  <= :adt_movimento
 and (x.dh_termino is null or x.dh_termino >= :adt_movimento)
 and x.id_preco_bloqueado	= 'S' 
 and x.id_situacao				= 'L'
 and f.cd_filial 					=	:al_filial
 and y.cd_produto				=	:al_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o.")
	Return False
Else
	If ll_Achou > 0 Then
		dw_2.Object.id_bloqueado_promocao		[al_linha] = 'S'
		dw_2.Object.id_bloqueado_promocao_ant	[al_linha] = 'S'
	Else
		dw_2.Object.id_bloqueado_promocao		[al_linha] = 'N'
		dw_2.Object.id_bloqueado_promocao_ant	[al_linha] = 'N'
	End If
End If

Return True
end function

public function integer wf_localiza_produto (long al_filial, long al_produto, ref string as_descricao, ref decimal adc_preco_venda_atual, ref date adt_data_preco_venda_atual, ref string as_matricula_preco_venda_atual, string as_chave, ref decimal adc_fat_conv, ref string as_controle_preco);Select g.de_produto + ' : ' + g.de_apresentacao_estoque,
		u.vl_preco_venda_atual,
		u.dh_preco_venda_atual,
		u.nr_matric_preco_venda_atual,
		g.vl_fator_conversao,
		coalesce(pa.id_controle_preco, 'L') id_controle_preco
Into :as_Descricao	, :adc_preco_venda_atual, :adt_data_preco_venda_atual,  :as_matricula_preco_venda_atual, :adc_fat_conv, :as_controle_preco
From produto_geral g
inner join produto_uf u
	on u.cd_produto = g.cd_produto
inner join produto_central pc
	on pc.cd_produto = g.cd_produto
left outer join produto_abcfarma pa
	on pa.cd_produto_abcfarma = pc.cd_produto_abcfarma	
Where g.cd_produto = :al_produto
	and u.cd_unidade_federacao in (select c.cd_unidade_federacao from filial f
											inner join cidade c
												on c.cd_cidade = f.cd_cidade
											where f.cd_filial = :al_filial)
Using SqlCa;

Choose Case SqlCa.SqlCode
Case 0
	Return 0
Case 100
	gvo_Aplicacao.of_Grava_Log(as_chave + " - Produto '" + String(al_produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado")
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", as_chave + " - Produto '" + String(al_produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	//as_Descricao = Upper("Produto '" + String(al_produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado")
	Return 100
Case -1
	gvo_Aplicacao.of_Grava_Log(as_chave + " - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do nosso produto - " + SqlCa.SqlErrText)
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", as_chave + " - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do nosso produto - " + SqlCa.SqlErrText, StopSign!)
	Return -1
End Choose


end function

on w_ge438_altera_preco_regional.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_historico_preco_venda=create cb_historico_preco_venda
this.cb_historico_preco_reposicao=create cb_historico_preco_reposicao
this.cb_importa_planilha=create cb_importa_planilha
this.cb_1=create cb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_historico_preco_venda
this.Control[iCurrent+3]=this.cb_historico_preco_reposicao
this.Control[iCurrent+4]=this.cb_importa_planilha
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_3
end on

on w_ge438_altera_preco_regional.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.cb_historico_preco_venda)
destroy(this.cb_historico_preco_reposicao)
destroy(this.cb_importa_planilha)
destroy(this.cb_1)
destroy(this.gb_3)
end on

event close;call super::close;Destroy(io_Filial)
Destroy(io_Produto)

end event

event open;call super::open;io_filial  		= Create uo_Filial
io_produto 	= Create uo_Produto

This.ivb_Valida_Salva = False
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio_vigencia[1] = RelativeDate(Date(gvo_Parametro.Dh_Movimentacao), 1)

dw_3.Event ue_AddRow()

dw_1.SetFocus()
end event

event ue_save;call super::ue_save;If AncestorReturnValue > 0 Then
	dw_2.Reset()
	dw_3.Reset()
	dw_3.Event ue_AddRow()
	dw_2.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

event ue_cancel;call super::ue_cancel;dw_1.Object.dt_inicio_vigencia[1] = RelativeDate(Date(gvo_Parametro.Dh_Movimentacao), 1)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge438_altera_preco_regional
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge438_altera_preco_regional
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge438_altera_preco_regional
integer x = 64
integer y = 76
integer width = 2656
integer height = 100
string dataobject = "dw_ge438_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Boolean lb_Reset = False

Choose Case dwo.Name
	Case "nm_fantasia"
		If Trim(Data) <> "" Then
			If Data <> io_Filial.nm_fantasia Then
				Return 1
			End If		
		Else
			io_Filial.Of_Inicializa()

			This.Object.Cd_Filial  		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_fantasia
		End If
							
End Choose

end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			
			io_Filial.of_Localiza_Filial( This.GetText() )
					
			If io_Filial.Localizada Then   
				dw_1.Object.Cd_Filial    		[1] = io_Filial.Cd_Filial
				dw_1.Object.Nm_Fantasia  	[1] = io_Filial.Nm_Fantasia
			End If
			
			dw_2.Event ue_Retrieve()
				
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
dw_3.Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge438_altera_preco_regional
integer y = 228
integer width = 3429
integer height = 1184
string text = "Produtos com Pre$$HEX1$$e700$$ENDHEX$$o de Venda Regionalizado"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge438_altera_preco_regional
integer width = 2706
integer height = 188
string text = "Par$$HEX1$$e200$$ENDHEX$$metros para Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os"
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge438_altera_preco_regional
integer x = 73
integer y = 296
integer width = 3360
integer height = 1068
string dataobject = "dw_ge438_lista"
end type

event dw_2::editchanged;call super::editchanged;IF dwo.name = "vl_preco_venda_futuro" THEN
	This.ivm_Menu.mf_Confirmar(True)
	This.ivm_Menu.mf_Cancelar(True)
END IF
end event

event dw_2::itemchanged;call super::itemchanged;Datetime ldh_Nulo

String   ls_Nulo

Decimal {2} ldc_Preco_Venda_Futuro
			
Choose Case dwo.Name
	Case "vl_preco_venda_futuro"

		ldc_Preco_Venda_Futuro = Dec(Data)

		This.Object.Nr_Matric_Preco_Venda_Futuro	[Row] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		//This.Object.Id_Alterado						 	[Row] = "S"

	Case "de_produto"	
		If IsNull(This.Object.cd_produto[Row]) THEN
			Return 1
		End If
	Case "id_bloqueado_promocao"
		If Data = "N" and dw_2.Object.id_bloqueado_promocao_ant[row] = 'S' Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto est$$HEX1$$e100$$ENDHEX$$ com o pre$$HEX1$$e700$$ENDHEX$$o bloqueado na promo$$HEX2$$e700e300$$ENDHEX$$o." +&
								"~r~rDeseja alterar o pre$$HEX1$$e700$$ENDHEX$$o mesmo assim ?", Question!, YesNo!, 2) = 2 Then 
				Return 1
			End If		
		End If
END CHOOSE


end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;BOOLEAN lvb_Exclusao

String lvs_Controle_Bloqueado

IF currentrow > 0 THEN
	
//	IF TRIM(THIS.Object.de_produto[currentrow]) = "" THEN
//		lvb_Exclusao = TRUE
//	ELSE
//		lvb_Exclusao = FALSE
//	END IF
//	
//	ivm_Menu.mf_Excluir(lvb_Exclusao)
	
	dw_2.AcceptText()

	lvs_Controle_Bloqueado = This.Object.id_bloqueado_promocao[This.GetRow()]
	
//	If  lvs_Controle_Bloqueado = 'S' Then
//		This.Object.vl_preco_venda_futuro.Protect = 1
//	Else
//		This.Object.vl_preco_venda_futuro.Protect = 0
//	End If
			
	dw_3.Retrieve(dw_1.Object.cd_filial[1], This.Object.cd_Produto[ currentRow ])

END IF	
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Date lvdt_Vigencia

Integer lvi_Linha

Long ll_Filial, ll_Find

Decimal ldc_Nulo

String ls_Nulo

SetNull(ldc_Nulo)
SetNull(ls_Nulo)

dw_1.AcceptText()

lvdt_Vigencia	= dw_1.Object.dt_inicio_vigencia[1]
ll_Filial			= dw_1.Object.Cd_Filial[1]

If IsNull(ll_Filial) Or ll_Filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
	This.Event ue_Pos(lvi_Linha, "cd_filial")	
	Return -1
End If

If IsNull( lvdt_Vigencia ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de vig$$HEX1$$ea00$$ENDHEX$$ncia", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return -1	
End If

If lvdt_Vigencia < RelativeDate(Date(gvo_Parametro.Dh_Movimentacao), 1) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de vig$$HEX1$$ea00$$ENDHEX$$ncia deve ser maior ou igual a data de amanh$$HEX1$$e300$$ENDHEX$$.", Information!)	  
	dw_1.SetColumn("dt_inicio_vigencia")
	dw_1.SetFocus()
	Return -1	  
End If

For lvi_Linha = 1 To This.RowCount()
	
	If Not IsNull(This.Object.vl_preco_venda_futuro[lvi_Linha]) and This.Object.vl_preco_venda_futuro[lvi_Linha] = 0.00 Then
		This.Object.vl_preco_venda_futuro			[lvi_Linha]	= ldc_Nulo
		This.Object.Nr_Matric_Preco_Venda_Futuro	[lvi_Linha] 	= ls_Nulo
		
		If This.Object.id_controle_preco[lvi_Linha] <> 'L' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto esta vinculado ao cadastro ABCFARMA. ~r~rO pre$$HEX1$$e700$$ENDHEX$$o de venda (PMC) n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser alterado.", Exclamation!)
			dw_2.Event ue_Pos(lvi_Linha, 'vl_preco_venda_futuro')
			Return -1	  
		End If
	End If
	
	If This.Object.id_bloqueado_promocao[lvi_Linha] <> "S" Then
		
		If Not IsNull(This.Object.vl_preco_venda_futuro[lvi_Linha]) and This.Object.vl_preco_venda_futuro[lvi_Linha] > 0.00 Then
			This.Object.Dh_Preco_Venda_Futuro[lvi_Linha] = dw_1.Object.Dt_Inicio_Vigencia[1]
		End If
	
		If IsNull(This.Object.Dh_Preco_Venda_Atual[lvi_Linha]) Then
			This.Object.Dh_Preco_Venda_Atual[lvi_Linha] = This.Object.Dh_Preco_Venda_Futuro[lvi_Linha]
		End If
		
	End If
	
	//vl_preco_venda_futuro_ant
	If (This.Object.vl_preco_venda_futuro[lvi_Linha] > This.Object.vl_preco_atual[lvi_Linha])  and  (This.Object.vl_preco_venda_futuro[lvi_Linha] > This.Object.vl_preco_venda_futuro_ant[lvi_Linha]) Then
		If This.Object.pc_diferenca[lvi_Linha] > 10.00 Then
			
			If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O valor do pre$$HEX1$$e700$$ENDHEX$$o futuro ser$$HEX1$$e100$$ENDHEX$$ 10% maior que o pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido atual ?",  Question!, YesNo!, 2) <> 1 Then
				dw_2.Event ue_Pos(lvi_Linha, 'vl_preco_venda_futuro')
				Return -1	  
			End If
		End If		
	End If	

Next

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Boolean lb_Habilita = False

Long ll_Linha, ll_Filial

Date ldh_Movimento

If pl_Linhas > 0 Then
	
	dw_1.AcceptText()
	
	ll_Filial = dw_1.Object.cd_filial[1]
		
	lb_Habilita = True

	This.SetFocus()
	
	Open(w_Aguarde)
	
	w_aguarde.uo_progress.of_setmax(pl_Linhas)
	
	ldh_Movimento = Date(gf_GetServerDate())
	
	w_Aguarde.Title = "Verificando o Pre$$HEX1$$e700$$ENDHEX$$o Atual e o Bloqueio de Promo$$HEX2$$e700e300$$ENDHEX$$o"
	
	For ll_Linha = 1 To pl_Linhas
				
		wf_verifica_bloqueio(dw_2.Object.cd_produto[ll_Linha], ll_Filial, ll_Linha, ldh_Movimento)
		wf_preco_atual(dw_2.Object.cd_produto[ll_Linha], ll_Filial, ll_Linha)
		
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	Close(w_Aguarde)
	
	dw_2.Event RowFocusChanged(1)
End If 	

ivm_Menu.mf_Classificar	(lb_Habilita)
ivm_Menu.mf_Filtrar		(lb_Habilita)
ivm_Menu.mf_Localizar	(lb_Habilita)
ivm_Menu.mf_Imprimir	(lb_Habilita)
ivm_Menu.mf_excluir		(lb_Habilita)
//ivm_Menu.mf_Incluir		(lb_Habilita)

cb_Historico_Preco_Reposicao.Enabled  		= lb_Habilita
cb_Historico_Preco_Venda.Enabled      		= lb_Habilita

Return pl_Linhas
end event

event dw_2::ue_key;call super::ue_key;Date ldh_Nulo, ldh_Movimento

DateTime ldh_Preco_Venda_Atual

Decimal ldc_Preco_Venda_Atual

Long ll_Row
Long ll_Find
Long ll_Filial

String ls_Produto_Bloqueado
String ls_Uf

String ls_Descricao, ls_Matric_Preco_Venda_Atual, ls_Chave_Log, ls_controle_preco
Decimal lvdc_Venda_Atual, ldc_Fat_Conv
Date ldt_Data_Preco_Venda_Atual
Integer lvi_Retorno

dw_1.AcceptText()

ll_Filial = dw_1.Object.cd_filial[1]

ll_Row	= This.GetRow()
SetNull(ldh_Nulo)

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			
			//Obriga a informar a filial, j$$HEX1$$e100$$ENDHEX$$ que abaixo precisar$$HEX1$$e100$$ENDHEX$$ do c$$HEX1$$f300$$ENDHEX$$digo da filial para fazer as demais consultas.
			If IsNull(dw_1.Object.Cd_Filial[1]) Or dw_1.Object.Cd_Filial[1] = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
				dw_1.Event ue_Pos(1, "nm_fantasia")
				Return -1
			End If
			
			io_Produto.of_Localiza_Produto( This.GetText() )
			
			If io_Produto.Localizado Then
			
				ll_Find = dw_2.Find("cd_produto = " + String(io_Produto.cd_produto) ,1 , This.RowCount() )
	
				If ll_Find > 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O Produto '"+ String(io_Produto.cd_produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na lista.",Information!)
					Return -1
				Else
					If wf_produto_ja_cadastrado( ll_Filial, io_Produto.cd_produto ) Then
						Return -1
					End If
				End If
				
				If Not wf_Localiza_Uf(ll_Filial, Ref ls_Uf) Then
					Return -1
				End If
				
				ldh_Movimento = Date(gf_GetServerDate())
				
				If wf_Verifica_Bloqueio(io_Produto.Cd_Produto, ll_Filial, ll_Row, ldh_Movimento ) Then	
										
					lvi_Retorno = wf_localiza_produto(	ll_Filial, &
																	io_Produto.Cd_Produto, &
																	ref ls_Descricao, &
																	ref lvdc_Venda_Atual,& 
																	ref ldt_Data_Preco_Venda_Atual, &
																	ref ls_Matric_Preco_Venda_Atual,&
																	ls_Chave_Log, ref ldc_Fat_Conv, ref ls_controle_preco)
					
					// Erro no Select									
					If lvi_Retorno = -1 Then 
						Return -1
					End If					
					
					dw_2.Object.Cd_Produto             					[ll_Row] = io_Produto.Cd_Produto
					dw_2.Object.De_Produto             					[ll_Row] = ls_Descricao
					dw_2.Object.cd_filial              						[ll_Row] = ll_Filial
					
					dw_2.Object.vl_preco_atual			   				[ll_Row] = lvdc_Venda_Atual
					
					dw_2.Object.dh_preco_venda_atual   			[ll_Row] = ldt_Data_Preco_Venda_Atual
					dw_2.Object.nr_matric_preco_venda_atual   	[ll_Row] = ls_Matric_Preco_Venda_Atual
					
					dw_2.Object.vl_preco_venda_futuro  				[ll_Row] = 000.00
					dw_2.Object.dh_preco_venda_futuro  			[ll_Row] = ldh_Nulo
					dw_2.Object.nr_matric_preco_venda_futuro   	[ll_Row] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
					
					dw_2.Object.id_controle_preco            			[ll_Row] = ls_controle_preco	
				Else
					Return -1
				End If
				
				//Se n$$HEX1$$e300$$ENDHEX$$o tiver o registro de valor e data de pre$$HEX1$$e700$$ENDHEX$$o, prenche com os valores da produto_uf
				If IsNull(dw_2.Object.Vl_Preco_Venda_Atual[ll_Row]) Or IsNull(dw_2.Object.Dh_Preco_Venda_Atual[ll_Row]) Then
					
					If Not wf_Localiza_Inf_Preco(ls_Uf, io_Produto.Cd_Produto, Ref ldc_Preco_Venda_Atual, Ref ldh_Preco_Venda_Atual) Then
						Return -1
					End If
					
					If IsNull(dw_2.Object.Vl_Preco_Venda_Atual[ll_Row]) Or dw_2.Object.Vl_Preco_Venda_Atual[ll_Row] = 0 Then
						dw_2.Object.Vl_Preco_Venda_Atual[ll_Row] = ldc_Preco_Venda_Atual
					End If
					
					If IsNull(dw_2.Object.Dh_Preco_Venda_Atual[ll_Row]) Then
						dw_2.Object.Dh_Preco_Venda_Atual[ll_Row] = ldh_Preco_Venda_Atual
					End If
				End If
				//
											
				If Not IsNull(This.Object.cd_produto[This.GetRow()]) and Trim(This.Object.de_produto[This.GetRow()]) <> "" Then
					//This.Object.vl_preco_venda_futuro.Protect = 0
					dw_2.Event Ue_Pos(ll_Row, "vl_preco_venda_futuro")
				Else
					//This.Object.vl_preco_venda_futuro.Protect = 1
				End If
					
			End If
		
	End Choose
	
End If
end event

event dw_2::ue_addrow;call super::ue_addrow;IF AncestorReturnValue > 0 THEN

	dw_2.SetRow(AncestorReturnValue)
	dw_2.ScrollToRow(AncestorReturnValue)
	dw_2.Object.de_produto[AncestorReturnValue] = ""
	dw_2.SetColumn("de_produto")

	ivm_Menu.mf_Excluir(True)

END IF

RETURN AncestorReturnValue
end event

event dw_2::ue_recuperar;//OverRide

Long    	ll_Filial	
String  	ls_Produto

dw_1.AcceptText()

ll_Filial 		= dw_1.Object.Cd_Filial		[1]
ls_Produto 	= dw_1.Object.De_Produto	[1]

If IsNull ( ll_Filial ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma filial.")
	dw_1.Event Ue_Pos(1, "cd_filial")
	Return -1
End If

If Not IsNull(ls_Produto) Then
	This.Of_AppendWhere("p.de_produto like '" + ls_Produto + "%'")
End if

Return This.Retrieve( ll_Filial )


end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]	 , &
		 lvs_Bloqueio[]
		 
lvs_Nome   = {"C$$HEX1$$f300$$ENDHEX$$digo","Descri$$HEX2$$e700e300$$ENDHEX$$o","Pre$$HEX1$$e700$$ENDHEX$$o Atual","Pre$$HEX1$$e700$$ENDHEX$$o Novo"}

lvs_Coluna = {"cd_produto","de_produto","vl_preco_venda_atual","vl_preco_venda_futuro"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		

This.of_SetRowSelection()

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preinsertrow;call super::ue_preinsertrow;If dw_2.RowCount() > 0 Then
	If IsNull(dw_2.Object.de_produto[dw_2.GetRow()]) Then Return 0
End IF

Return 1
end event

type dw_3 from dc_uo_dw_base within w_ge438_altera_preco_regional
integer x = 50
integer y = 1504
integer width = 3383
integer height = 180
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge438_detalhe"
end type

event ue_recuperar;call super::ue_recuperar;Integer lvi_Linha_Ativa
Integer lvi_Linhas

//Long lvl_Produto 
////
//lvi_Linha_Ativa = dw_2.GetRow()
////
//If lvi_Linha_Ativa > 0 Then
//	lvl_Produto = dw_2.Object.Cd_Produto[lvi_Linha_Ativa]
//	
//	lvi_Linhas = This.Retrieve(dw_1.Object.cd_filial[1],lvl_Produto)
//Else
//	This.Reset()
//End If
//
Return lvi_Linhas 

end event

type cb_historico_preco_venda from commandbutton within w_ge438_altera_preco_regional
integer x = 41
integer y = 1732
integer width = 823
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico Pre$$HEX1$$e700$$ENDHEX$$o &Venda"
end type

event clicked;INTEGER lvi_Row 

LONG    lvl_Cd_Produto 

lvi_Row = Parent.dw_2.GetRow()

If lvi_Row > 0 Then
	lvl_Cd_Produto = Parent.dw_2.Object.Cd_Produto[lvi_Row]
	
	OpenWithParm(w_ge120_Historico_Preco_Venda, String(lvl_Cd_Produto))
End If
end event

type cb_historico_preco_reposicao from commandbutton within w_ge438_altera_preco_regional
integer x = 905
integer y = 1732
integer width = 823
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico Pre$$HEX1$$e700$$ENDHEX$$o &F$$HEX1$$e100$$ENDHEX$$brica"
end type

event clicked;INTEGER lvi_Row 

LONG    lvl_Cd_Produto 

lvi_Row = Parent.dw_2.GetRow()

If lvi_Row > 0 Then
	lvl_Cd_Produto = Parent.dw_2.Object.Cd_Produto[lvi_Row]

	OpenWithParm(w_ge120_Historico_Preco_Reposicao, String(lvl_Cd_Produto))
End If
end event

type cb_importa_planilha from commandbutton within w_ge438_altera_preco_regional
integer x = 2633
integer y = 1732
integer width = 823
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Planilha"
end type

event clicked;Boolean lvb_Erro = False

Any lva_Dado

Date ldt_Data_Preco_Venda_Atual, ldt_Inicio_Vigencia, ldh_Movimento

Integer li_Retorno

String ls_Arquivo, ls_Arquivo_Sel, ls_Chave_Log, ls_Descricao, ls_Matric_Preco_Venda_Atual, ls_controle_preco
		 
Integer lvi_Retorno

Long ll_Linhas, ll_Linha, ll_Insert, ll_Filial, ll_Produto, ll_Find

Decimal lvdc_Venda_Atual, lvdc_Venda_Novo, ldc_Fat_Conv

dw_1.AcceptText()

ll_Filial 					= dw_1.Object.cd_filial[1]
ldt_Inicio_Vigencia 	= dw_1.Object.dt_inicio_vigencia[1]	

If IsNull(ll_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "nm_fantasia")
	Return
End If

If IsNull(ldt_Inicio_Vigencia) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do in$$HEX1$$ed00$$ENDHEX$$cio da vig$$HEX1$$ea00$$ENDHEX$$ncia.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return
End If

If ldt_Inicio_Vigencia < RelativeDate(Date(gvo_Parametro.Dh_Movimentacao), 1) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de vig$$HEX1$$ea00$$ENDHEX$$ncia deve ser maior ou igual a data de amanh$$HEX1$$e300$$ENDHEX$$.", Information!)	  
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                   "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r"     + &
				 "Coluna B = Pre$$HEX1$$e700$$ENDHEX$$o de Venda~r")

lvi_Retorno = GetFileOpenName("Selecione o arquivo", ls_Arquivo_Sel, ls_Arquivo, "XLS", "Excel (*.XLS),*.XLS,")

If li_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro na sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
	Return 
End If

If lvi_Retorno = 0 Then Return

ldh_Movimento = Date(gf_GetServerDate())

dc_uo_excel lvo_Excel

try
	
	SetPointer(HourGlass!)
	Open(w_Aguarde)
	
	dw_2.SetRedraw (False)
	
	lvo_Excel = Create dc_uo_excel
	
	w_Aguarde.Title = "Importando o Arquivo..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lvo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo_Sel) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	End If
			
	If ll_Linhas > 0 Then
		gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Importa$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os")
		gvo_Aplicacao.of_Grava_Log("Arquivo: " + ls_Arquivo_Sel)
		
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			
			ls_Chave_Log = "Linha - " + String(ll_Linha)
			
			// Produto
			lva_Dado    = lvo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			// Se existir problema continua para o pr$$HEX1$$f300$$ENDHEX$$ximo produto
			If Not IsNumber(String(lva_Dado)) Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto informado na linha [" + String(ll_Linha) + "] $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
				gvo_Aplicacao.of_Grava_Log(ls_Chave_Log + " - Produto [" + String(ll_Linha) + "] $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.")
				lvb_Erro = True
				Continue
			End If
			
			ll_Produto = Long(lva_Dado)
			
			lvi_Retorno = wf_localiza_produto(	ll_Filial, &
															ll_Produto, &
															ref ls_Descricao, &
															ref lvdc_Venda_Atual,& 
															ref ldt_Data_Preco_Venda_Atual, &
															ref ls_Matric_Preco_Venda_Atual,&
															ls_Chave_Log, ref ldc_Fat_Conv, ref ls_controle_preco)
												
			// Erro no Select									
			If lvi_Retorno = -1 Then 
				lvb_Erro = True
				Return
			End If
			
			// Produto n$$HEX1$$e300$$ENDHEX$$o localizado
			If lvi_Retorno = 100 Then 
				lvb_Erro = True
				Continue
			End If
						
			// Pre$$HEX1$$e700$$ENDHEX$$o de Venda Novo
			lva_Dado    			= lvo_Excel.uo_Lendo_Dados(ll_Linha, "B")
			lvdc_Venda_Novo 	= Dec(lva_Dado)
								
			If IsNull(lvdc_Venda_Novo)   Then lvdc_Venda_Novo   = 0
			
//			If ldc_Fat_Conv > 1 Then
//				lvdc_Venda_Novo = Round(lvdc_Venda_Novo * ldc_Fat_Conv, 2)
//			End If
			
			ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto), 1,  dw_2.RowCount())
			
			If ll_Find > 0 Then
				ll_Insert = ll_Find
			ElseIf ll_Find = 0 Then
				ll_Insert = dw_2.InsertRow(0)
		
				dw_2.Object.Cd_Produto      	 					[ll_Insert] = ll_Produto
				dw_2.Object.De_Produto      	 					[ll_Insert] = ls_Descricao
				dw_2.Object.vl_preco_venda_atual				[ll_Insert] = lvdc_Venda_Atual
				dw_2.Object.nr_matric_preco_venda_atual		[ll_Insert] = ls_Matric_Preco_Venda_Atual
				dw_2.Object.dh_preco_venda_atual				[ll_Insert] = ldt_Data_Preco_Venda_Atual
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto da DW.", StopSign!)
				Return
			End If
			
			If Not wf_verifica_bloqueio(ll_Produto, ll_Filial, ll_Insert, ldh_Movimento) Then Return
			
			dw_2.Object.cd_filial						   	 		[ll_Insert] = ll_Filial
			dw_2.Object.vl_preco_venda_futuro   	 		[ll_Insert] = lvdc_Venda_Novo
			dw_2.Object.dh_preco_venda_futuro   	 		[ll_Insert] = ldt_Inicio_Vigencia
			dw_2.Object.nr_matric_preco_venda_futuro	[ll_Insert] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
			dw_2.Object.id_controle_preco						[ll_Insert] = ls_controle_preco
						
			wf_preco_atual(ll_Produto, ll_Filial, ll_Insert)
			
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			
		Next
		
		ivb_Valida_Salva = True
		
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)
		
		gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino da Importa$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os")
		
		If Not lvb_Erro Then
			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo realizada com sucesso.")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreram erros durante a importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo.~r" + &
										 "Verifique o arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o '" + gvo_Aplicacao.ivs_Arquivo_Log + "'.", StopSign!)
		End If

	End If

finally
	Destroy(lvo_Excel)
	Close(w_Aguarde)
	dw_2.SetRedraw (True)
	SetPointer(Arrow!)
end try


end event

type cb_1 from commandbutton within w_ge438_altera_preco_regional
integer x = 1769
integer y = 1732
integer width = 823
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Produto via Planilha"
end type

event clicked;OpenWithParm(w_ge438_exclui_prd_via_planilha, "")
end event

type gb_3 from groupbox within w_ge438_altera_preco_regional
integer x = 37
integer y = 1428
integer width = 3429
integer height = 288
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados Anteriores $$HEX1$$e000$$ENDHEX$$ Altera$$HEX2$$e700e300$$ENDHEX$$o"
end type

