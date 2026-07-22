HA$PBExportHeader$w_ge457_bloqueio_pedido.srw
forward
global type w_ge457_bloqueio_pedido from dc_w_sheet
end type
type cb_7 from commandbutton within w_ge457_bloqueio_pedido
end type
type cb_1 from commandbutton within w_ge457_bloqueio_pedido
end type
type gb_1 from groupbox within w_ge457_bloqueio_pedido
end type
type dw_1 from dc_uo_dw_base within w_ge457_bloqueio_pedido
end type
type cb_incluir from commandbutton within w_ge457_bloqueio_pedido
end type
type cb_excluir from commandbutton within w_ge457_bloqueio_pedido
end type
type cb_selecionar from commandbutton within w_ge457_bloqueio_pedido
end type
type dw_2 from dc_uo_dw_base within w_ge457_bloqueio_pedido
end type
type gb_2 from groupbox within w_ge457_bloqueio_pedido
end type
end forward

global type w_ge457_bloqueio_pedido from dc_w_sheet
integer width = 3003
integer height = 1848
string title = "GE457 - Bloqueio de Pedido"
long backcolor = 80269524
event ue_retrieve ( )
event type boolean wf_insere_reforco_perini ( )
cb_7 cb_7
cb_1 cb_1
gb_1 gb_1
dw_1 dw_1
cb_incluir cb_incluir
cb_excluir cb_excluir
cb_selecionar cb_selecionar
dw_2 dw_2
gb_2 gb_2
end type
global w_ge457_bloqueio_pedido w_ge457_bloqueio_pedido

type variables
uo_filial ivo_filial
String is_Parametro
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_inclui_reforco_perini ()
end prototypes

event ue_retrieve;dw_2.Event ue_Retrieve()
end event

event type boolean wf_insere_reforco_perini();Long ll_Linha, ll_Linhas, ll_Filial, ll_Linha_Grupo, ll_Linhas_Grupo

String ls_Grupo

TRY
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	If Not  lds.of_ChangeDataObject("ds_ge457_lista_filial_reforco") Then	Return False
	
	dc_uo_ds_base lds_Grupo
	lds_Grupo = Create dc_uo_ds_base
	If Not lds_Grupo.of_ChangeDataObject("ds_ge457_lista_grupo_reforco") Then	Return False
	
	ll_Linhas_Grupo = lds_Grupo.Retrieve()
	
	ll_Linhas  = lds.Retrieve()
	
	Open(w_Aguarde)
			
	For ll_Linha = 1 To ll_Linhas
		
		ll_Filial	= lds.Object.cd_filial[ll_Linha]
		
		For ll_Linha_Grupo = 1 To ll_Linhas_Grupo
			
			ls_Grupo = lds_Grupo.Object.cd_grupo[ll_Linha_Grupo]
			
//			INSERT INTO pedido_filial_reforco_perini( dh_inicio, dh_termino, cd_filial, cd_grupo, cd_curva, qt_dias_reforco)   
//			select '20150615', '20150615', cd_filial, '3', 'B', 1 
//			from vw_filial
//			;
			
			
		Next
		
		
	Next
		
FINALLY
	Destroy lds
	Destroy lds_Grupo
	
	Open(w_Aguarde)
END TRY

Return True
end event

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public subroutine wf_inclui_reforco_perini ();
end subroutine

on w_ge457_bloqueio_pedido.create
int iCurrent
call super::create
this.cb_7=create cb_7
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_incluir=create cb_incluir
this.cb_excluir=create cb_excluir
this.cb_selecionar=create cb_selecionar
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_7
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_incluir
this.Control[iCurrent+6]=this.cb_excluir
this.Control[iCurrent+7]=this.cb_selecionar
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.gb_2
end on

on w_ge457_bloqueio_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_7)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_incluir)
destroy(this.cb_excluir)
destroy(this.cb_selecionar)
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

ivm_Menu.mf_Recuperar(True)

ivo_Filial = Create uo_Filial

wf_Insere_Distribuidora_Default()

//dw_1.Object.nm_fantasia.protect   = 1
dw_1.Object.dh_pedido.protect     = 0

end event

event close;call super::close;Destroy(ivo_Filial)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge457_bloqueio_pedido
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge457_bloqueio_pedido
end type

type cb_7 from commandbutton within w_ge457_bloqueio_pedido
boolean visible = false
integer x = 2103
integer y = 236
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "n$$HEX1$$e300$$ENDHEX$$o excluir"
end type

event clicked;Date ldt_Movimento

Date ldt_Inicio, ldt_Termino, ldt_Ultimo_Saldo, ldt_Saldo

Decimal ldc_Venda, ldc_Dev_Venda, ldc_Resultado, ldc_Entradas, ldc_Saidas, ldc_Valor_Estoque
Decimal ldc_Transf_Entrada, ldc_Transf_Saida, ldc_Compra, ldc_Dev_Compra, ldc_Ajuste_Ent, ldc_Ajuste_Saida

Long ll_Filial

String ls_Matricula, ls_MSG

If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("HOMOLOGA_PEDIDO_SIMULTANERO", ref ls_Matricula) Then 
	If ls_Matricula <> '14231' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente a matricula 14231 poder$$HEX1$$e100$$ENDHEX$$ utilizar esta fun$$HEX2$$e700e300$$ENDHEX$$o.")
		Return
	End If
Else
	Return 
End If

//// PPJOINVILLE
//ll_Filial = 773
//ldt_Ultimo_Saldo 		= Date('01/05/2015')
//ldt_Inicio 				= Date('01/06/2015')
//ldt_Termino 			= Date('04/08/2015') // um dia antes no in$$HEX1$$ed00$$ENDHEX$$cio da grava$$HEX1$$e700$$ENDHEX$$ao do resumo

// PIRABEIRABA
ll_Filial = 745
ldt_Ultimo_Saldo 		= Date('01/05/2015')
ldt_Inicio 				= Date('01/06/2015')
ldt_Termino 			= Date('04/08/2015') // um dia antes no in$$HEX1$$ed00$$ENDHEX$$cio da grava$$HEX1$$e700$$ENDHEX$$ao do resumo

// Desenvolvimento
//ll_Filial 				= 773
//ldt_Ultimo_Saldo 	= Date('01/08/2015')
//ldt_Inicio 			= Date('01/09/2015')
//ldt_Termino 		= Date('07/09/2015')

// Valor do saldo no m$$HEX1$$ea00$$ENDHEX$$s anterior
// 01/05/2015
Select coalesce(sum(round(qt_saldo_final * vl_custo_medio, 2)), 0)
Into :ldc_Valor_Estoque
from saldo_produto v
where v.qt_saldo_final > 0
  and v.cd_filial 	=	:ll_Filial
  and v.dh_saldo	=	:ldt_Ultimo_Saldo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o valor do estoque.")
	Return
End If

do while ldt_Inicio <= ldt_Termino
	
	ldt_Movimento = ldt_Inicio
	
	ldt_Saldo = gf_Primeiro_Dia_Mes(ldt_Inicio)
	
	// venda
	select coalesce(sum(round(i.qt_vendida * s.vl_custo_medio, 2)), 2)
	Into :ldc_Venda
	from nf_venda n
	inner join item_nf_venda i on i.cd_filial = n.cd_filial
										and i.nr_nf		= n.nr_nf
										and i.de_especie	= n.de_especie
										and i.de_serie		= n.de_serie
	inner join saldo_produto s on s.cd_filial = n.cd_filial and s.cd_produto = i.cd_produto
	where n.cd_filial 					= :ll_Filial
	  and n.dh_movimentacao_caixa = :ldt_Movimento
	  and n.de_especie in ('CF', 'NFC')
	  and n.nr_nf_anexa is null
	  and n.dh_cancelamento is null
	  and s.dh_saldo 							= :ldt_Saldo
	 Using SqlCa;
	 
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro venda")
		SqlCa.of_RollBack();
		Exit
	End If 
	
	// devolu$$HEX2$$e700e300$$ENDHEX$$o de venda
	select coalesce(sum(round(i.qt_devolvida * s.vl_custo_medio, 2)), 2)
	Into :ldc_Dev_Venda
	from nf_devolucao_venda n
	inner join item_nf_devolucao_venda i on i.cd_filial = n.cd_filial
										and i.nr_nf		= n.nr_nf
										and i.de_especie	= n.de_especie
										and i.de_serie		= n.de_serie
										and i.id_origem_nf	= n.id_origem_nf
	inner join saldo_produto s on s.cd_filial = n.cd_filial and s.cd_produto = i.cd_produto
	where n.cd_filial 					= :ll_Filial
	  and n.dh_movimentacao_caixa = :ldt_Movimento
	  and n.dh_cancelamento is null
	  and s.dh_saldo 							= :ldt_Saldo
	 Using SqlCa;
	 
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro dev venda")
		SqlCa.of_RollBack();
		Exit
	End If 
	
	// Compra
	select coalesce(sum(round(i.qt_faturada * s.vl_custo_medio, 2)), 2)
	Into :ldc_Compra
	from nf_compra n
	inner join item_nf_compra i on i.cd_filial = n.cd_filial
										and i.cd_fornecedor = n.cd_fornecedor
										and i.nr_nf			= n.nr_nf
										and i.de_especie		= n.de_especie
										and i.de_serie			= n.de_serie
	inner join saldo_produto s on s.cd_filial = n.cd_filial and s.cd_produto = i.cd_produto
	where n.dh_movimentacao_caixa = :ldt_Movimento
	  and n.cd_filial = :ll_Filial
	  and s.dh_saldo 		= :ldt_Saldo
	 Using SqlCa;
	 
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro compra")
		SqlCa.of_RollBack();
		Exit
	End If
	
	// dev compra
	select coalesce(sum(round(i.qt_devolvida * s.vl_custo_medio, 2)), 0)
	Into :ldc_Dev_Compra
	from nf_devolucao_compra n
	inner join item_nf_devolucao_compra i on i.cd_filial = n.cd_filial
										and i.nr_nf			= n.nr_nf
										and i.de_especie		= n.de_especie
										and i.de_serie			= n.de_serie
	inner join saldo_produto s on s.cd_filial = n.cd_filial and s.cd_produto = i.cd_produto
	where n.dh_movimentacao_caixa = :ldt_Movimento
	  and n.cd_filial = :ll_Filial
	  and s.dh_saldo 		= :ldt_Saldo
	using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro dev compra")
		SqlCa.of_RollBack();
		Exit
	End If
		
	// Transfer$$HEX1$$ea00$$ENDHEX$$ncia entrada
	select coalesce(sum(vl_total_nf), 0)
	Into :ldc_Transf_Entrada
	from nf_transferencia
	where cd_filial_destino = :ll_Filial
		and dh_movimentacao_caixa = :ldt_Movimento
		and dh_cancelamento is null
	Using SqlCa;
		
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro transf entrada")
		SqlCa.of_RollBack();
		Exit
	End If
	
	// Transfer$$HEX1$$ea00$$ENDHEX$$ncia sa$$HEX1$$ed00$$ENDHEX$$da
	select coalesce(sum(vl_total_nf), 0)
	Into :ldc_Transf_Saida
	from nf_transferencia
	where cd_filial_origem = :ll_Filial
		and dh_movimentacao_caixa = :ldt_Movimento
		and id_produto_vencido = 'N'
		and dh_cancelamento is null
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro transf entrada")
		SqlCa.of_RollBack();
		Exit
	End If
	
	// ajuste entrada	
	select coalesce(sum(round(qt_ajuste * vl_custo_unitario, 2)), 0) 
	Into :ldc_Ajuste_Ent
	from ajuste_estoque
	where cd_filial_ajuste = :ll_Filial
	  and dh_movimentacao_caixa = :ldt_Movimento
	  and id_entrada_saida = 'E'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro ajuste entrada")
		SqlCa.of_RollBack();
		Exit
	End If
	
	// ajuste saida
	select coalesce(sum(round(qt_ajuste * vl_custo_unitario, 2)), 0) Into :ldc_Ajuste_Saida
	from ajuste_estoque
	where cd_filial_ajuste = :ll_Filial
	  and dh_movimentacao_caixa = :ldt_Movimento
	  and id_entrada_saida = 'S'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro ajuste saida")
		SqlCa.of_RollBack();
		Exit
	End If
	
	// ENTRADAS
	ldc_Valor_Estoque = ldc_Valor_Estoque + ldc_Transf_Entrada + ldc_Ajuste_Ent + ldc_Compra + ldc_Dev_Venda
	
	//SAIDAS
	ldc_Valor_Estoque = ldc_Valor_Estoque - ldc_Venda - ldc_Dev_Compra - ldc_Transf_Saida - ldc_Ajuste_Saida
	
	INSERT INTO a_sergio_resumo_estoque	( dh_resumo, cd_filial, vl_estoque, dh_inclusao )  
	VALUES ( :ldt_Movimento, :ll_Filial, :ldc_Valor_Estoque, '20150908' )
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG = "Erro ao incluir o resumo na a_sergio_resumo_estoque. " + SQLCA.SQLErrText
		SqlCa.of_RollBack();
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG)
		Exit
	End If
			
	ldt_Inicio = RelativeDate (ldt_Inicio, 1)
loop

SqlCa.of_Commit()

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Execu$$HEX2$$e700e300$$ENDHEX$$o terminada.")


//ldc_Entradas 	= ldc_Transf_Entrada + ldc_Ajuste_Ent + ldc_Compra + ldc_Dev_Venda
//ldc_Saidas		= ldc_Venda + ldc_Dev_Compra + ldc_Transf_Saida + ldc_Ajuste_Saida

//ldc_Resultado = ldc_Entradas - ldc_Saidas

end event

type cb_1 from commandbutton within w_ge457_bloqueio_pedido
boolean visible = false
integer x = 494
integer y = 1528
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "EB Perini"
end type

event clicked;string ls_teste

//dc_uo_ftp uo
//
//uo = Create dc_uo_ftp
//
//If uo.of_Conecta_FTP("BK", '0343_01', 'pdv2', 'pdv2', ref ls_teste) then
//	
//End If

//destroy(uo)

//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Verificar a data das vendas dos produtos zazonais.~r~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_vendas", Exclamation!)
//
//uo_ge235_estoque_central  uo
//
//uo = Create uo_ge235_estoque_central
//
//uo.of_atualiza_estoque_base()
//
//Destroy(uo)
end event

type gb_1 from groupbox within w_ge457_bloqueio_pedido
integer x = 18
integer y = 8
integer width = 1925
integer height = 412
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge457_bloqueio_pedido
integer x = 37
integer y = 56
integer width = 1888
integer height = 328
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge457_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;Date lvdt_Nulo

Integer lvi_Nulo

SetNull(lvdt_Nulo)
SetNull(lvi_Nulo)

If This.GetColumnName() = "id_tipo_bloqueio" Then
	ivo_Filial.of_Inicializa()
	
	This.Object.cd_filial  [1] = ivo_Filial.cd_filial
	This.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
	
	//Verifica se vai ser atulizado no SAP
	If Not gf_filial_administrada_sap( ivo_Filial.cd_filial , Ref is_Parametro) Then
		Return 1
	End If
			
	If is_Parametro = "S" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String( ivo_Filial.cd_filial )+" deve ser utilizado o SAP.")
		cb_excluir.enabled = False
		cb_7.enabled = False
		cb_selecionar.enabled = False
		cb_incluir.enabled = False
		Return 1				
	Else
		cb_excluir.enabled = True
		cb_7.enabled = True 
		cb_selecionar.enabled = True
		cb_incluir.enabled = True
		This.Object.dh_pedido    [1] = lvdt_Nulo
		This.Object.nr_dia_semana[1] = lvi_Nulo
	End If 	
	
End If

dw_2.Event ue_Reset()
end event

event itemchanged;call super::itemchanged;String lvs_Tipo

Date lvdt_Nulo

Integer lvi_Nulo

dw_1.AcceptText()

SetNull(lvdt_Nulo)
SetNull(lvi_Nulo)

Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial  [1] = ivo_Filial.Cd_Filial
			This.Object.nm_fantasia[1] = ivo_Filial.Nm_Fantasia
		End If
End Choose

lvs_Tipo = dw_1.Object.id_tipo_bloqueio[1]
If This.GetColumnName() = "id_tipo_bloqueio" Then
	ivo_Filial.of_Inicializa()
	
	This.Object.cd_filial    [1] = ivo_Filial.cd_filial
	This.Object.nm_fantasia  [1] = ivo_Filial.nm_fantasia
	This.Object.dh_pedido    [1] = lvdt_Nulo
End If


dw_2.Event ue_Reset()
end event

event ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_filial  [1] = ivo_Filial.cd_filial
			This.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
			
			//Verifica se vai ser atulizado no SAP
			If Not gf_filial_administrada_sap( ivo_Filial.cd_filial , Ref is_Parametro) Then
				Return 1
			End If
			
			If is_Parametro = "S" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String( ivo_Filial.cd_filial )+" deve ser utilizado o SAP.")
				cb_excluir.enabled = False
				cb_7.enabled = False
				cb_selecionar.enabled = False
				cb_incluir.enabled = False
				Return 1				
			Else
				cb_excluir.enabled = True
				cb_7.enabled = True 
				cb_selecionar.enabled = True
				cb_incluir.enabled = True
			End If 
			
		End IF
	End If
End If



end event

event losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
End If
end event

type cb_incluir from commandbutton within w_ge457_bloqueio_pedido
integer x = 2427
integer y = 1536
integer width = 498
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir Bloqueio"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge457_inclui_bloqueio, "")

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Event ue_Retrieve()
End If
end event

type cb_excluir from commandbutton within w_ge457_bloqueio_pedido
integer x = 1906
integer y = 1536
integer width = 507
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Excluir Bloqueio"
end type

event clicked;Boolean lvb_Sucesso = True

DateTime ldh_Pedido

Long	lvl_Find,&
	 	lvl_Linha,&
	 	lvl_Bloqueio, &
	 	ll_Filial

String lvs_Excluir
String ls_De
String ls_Distribuidora
String ls_Erro
String ls_Chave
String ls_Nulo

dw_1.AcceptText()

lvl_Find = dw_2.Find("id_excluir = 'S'", 1, dw_2.RowCount())

If lvl_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o bloqueio para a exclus$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
	Return -1
End If

If lvl_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum bloqueio foi selecionado para exclus$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	Return -1
End If

//Se o tipo de bloqueio selecionado for distribuidora
If dw_1.Object.Id_Tipo_Bloqueio[1] = "DD" Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "RO" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente a T.I. poder$$HEX1$$e100$$ENDHEX$$ excluir o bloqueio de distribuidora.", Exclamation!)
		Return -1
	End If
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o dos bloqueios selecionados ?", Question!, YesNo!, 2) = 2 Then Return

lvl_Find = dw_2.Find("dh_pedido = DateTime('" + String(gvo_Parametro.of_Dh_Movimentacao(), "yyyy/mm/dd") + "')", 1, dw_2.RowCount())

If lvl_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se est$$HEX1$$e100$$ENDHEX$$ sendo exclu$$HEX1$$ed00$$ENDHEX$$do algum bloqueio do dia atual.", StopSign!)
	Return -1
End If

If lvl_Find > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem bloqueios do dia atual que ser$$HEX1$$e300$$ENDHEX$$o exclu$$HEX1$$ed00$$ENDHEX$$dos. ~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then Return -1
End If

SetNull(ls_Nulo)

For lvl_Linha = 1 To dw_2.RowCount()
	
	lvs_Excluir = dw_2.Object.id_excluir[lvl_Linha]
	
	If lvs_Excluir = 'S' Then
		
		lvl_Bloqueio = dw_2.Object.nr_bloqueio	[lvl_Linha]
		ll_Filial		= dw_2.Object.Cd_Filial		[lvl_Linha]
				
		Delete pedido_filial_bloqueio
		Where nr_bloqueio = :lvl_Bloqueio
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o bloqueio '" + String(lvl_Bloqueio) + "'. " + ls_Erro, StopSign!)
			lvb_Sucesso = False
			Exit
		End If
		
		ls_Distribuidora	= dw_2.Object.Cd_Distribuidora	[lvl_Linha]		
		ldh_Pedido		= dw_2.Object.Dh_Pedido			[lvl_Linha]
		
		//Grava hist$$HEX1$$f300$$ENDHEX$$rico somente na exclus$$HEX1$$e300$$ENDHEX$$o do bloqueio de filial
		If Not IsNull(ll_Filial) And ll_Filial > 0 Then
			ls_Chave = 'CD_FILIAL@#!CD_DISTRIBUIDORA@#!DH_PEDIDO'
			ls_De = MidA(String(ll_Filial) + Space(4), 1, 4) + "@#!" + ls_Distribuidora + "@#!" + String(ldh_Pedido, "dd/mm/yyyy")
			
			If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_FILIAL_BLOQUEIO', ls_Chave, 'NR_BLOQUEIO', ls_De, ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then Return -1
		End If	
	End If
Next

If lvb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os bloqueios foram exclu$$HEX1$$ed00$$ENDHEX$$dos com sucesso.")
	dw_2.Event ue_Retrieve()
Else
	SqlCa.of_RollBack();
End If
end event

type cb_selecionar from commandbutton within w_ge457_bloqueio_pedido
boolean visible = false
integer x = 1015
integer y = 1536
integer width = 567
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Marcar Todos"
end type

event clicked;Integer lvi_Linha

String lvs_Texto,&
	   lvs_ID

lvs_Texto = cb_selecionar.text

If lvs_Texto = "&Marcar Todos" Then
	lvs_ID = "S"
	cb_selecionar.text = "&Desmarcar Todos"
Else
	lvs_ID = "N"
	cb_selecionar.text = "&Marcar Todos"
End If

For lvi_Linha = 1 To dw_2.RowCount()
	dw_2.Object.id_excluir[lvi_Linha] = lvs_ID
Next




end event

type dw_2 from dc_uo_dw_base within w_ge457_bloqueio_pedido
integer x = 55
integer y = 504
integer width = 2853
integer height = 980
integer taborder = 30
string dataobject = "dw_ge457_lista_filial_data"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_postretrieve;call super::ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Return pl_Linhas
end event

event ue_preretrieve;call super::ue_preretrieve;Boolean lvb_Sucesso = True

Date lvdt_Pedido

Integer lvi_Dia

Long lvl_Filial

String lvs_DW,&
	   lvs_Tipo,&
	   lvs_Distribuidora

dw_1.AcceptText()

lvl_Filial  	  = dw_1.Object.cd_filial		[1]
lvs_Tipo    	  = dw_1.Object.id_tipo_bloqueio[1]
lvdt_Pedido 	  = dw_1.Object.dh_pedido       [1]
lvs_Distribuidora = dw_1.Object.cd_distribuidora[1]

Choose Case lvs_Tipo
	Case "FD" ; lvs_DW = "dw_ge457_lista_filial_data"
	Case "DD" ; lvs_DW = "dw_ge457_lista_distribuidora_data"
	Case Else 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo n$$HEX1$$e300$$ENDHEX$$o definido '" + lvs_Tipo + "'.")
		Return -1
End Choose

If This.DataObject <> lvs_DW Then
	If Not This.of_ChangeDataObject(lvs_DW) Then	Return -1

	This.of_SetRowSelection()
End If

If Not IsNull(lvl_Filial)  Then
	This.of_AppendWhere("p.cd_filial = " + String(lvl_Filial))
End If

If Not IsNull(lvdt_Pedido) Then
	This.of_AppendWhere("p.dh_pedido = '" + String(lvdt_Pedido, "yyyy/mm/dd") + "'")
End If

If lvs_Distribuidora <> "000000000" Then
	This.of_AppendWhere("p.cd_distribuidora = '" + lvs_Distribuidora + "'")
End If

Return 1
end event

type gb_2 from groupbox within w_ge457_bloqueio_pedido
integer x = 18
integer y = 444
integer width = 2907
integer height = 1064
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

