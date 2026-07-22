HA$PBExportHeader$uo_saldo_lote.sru
forward
global type uo_saldo_lote from nonvisualobject
end type
end forward

global type uo_saldo_lote from nonvisualobject
end type
global uo_saldo_lote uo_saldo_lote

type variables
dc_uo_ds_base ivds_lote_lancado
end variables

forward prototypes
public subroutine of_preenche_lista (dc_uo_dw_base pdw_datawindow, long pl_nota, long pl_produto)
public subroutine of_lote_lancado (dc_uo_dw_base pdw_lotes)
public subroutine of_preenche_lista_matriz (dc_uo_dw_base pdw_datawindow, long pl_filial, long pl_produto)
public subroutine of_preenche_lista (dc_uo_dw_base pdw_datawindow, long pl_produto)
public subroutine of_lote_lancado (dc_uo_dw_base pdw_lotes, long pl_produto)
public function boolean of_lote_unico (dc_uo_dw_base pdw_lotes, long pl_produto, date pdt_dispensacao)
public function boolean of_valida_qtde_lote (dc_uo_dw_base pdw_datawindow, long pl_produto, date pdt_dispensacao)
public function boolean of_dedus_entradas (long pl_produto, string ps_lote, date pdt_dispensacao, ref long pl_qtde, ref boolean pb_entrou)
public subroutine of_preenche_lista (dc_uo_dw_base pdw_datawindow, long pl_produto, string ps_datastore)
end prototypes

public subroutine of_preenche_lista (dc_uo_dw_base pdw_datawindow, long pl_nota, long pl_produto);DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row
		  
Long lvl_Linha, &
     lvl_Total,&
	 lvl_Itens,&
	 lvl_Item,&
	 lvl_Insert
	  
String lvs_Lote,&
	   lvs_Lote_Informado

dc_uo_ds_base lvds_1

lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject("ds_ge092_lote_compra") Then
	Destroy(lvds_1)
	Return
End If

lvds_1.Retrieve(pl_Nota, pl_Produto)

If pdw_datawindow.GetChild("nr_lote", lvdwc) = 1 Then
	
	// Limpa os lotes informados
	lvl_Itens = lvdwc.RowCount()
	
	For lvl_Item = 1 To lvl_Itens
		lvdwc.DeleteRow(lvl_Item)
	Next
		
	lvl_Total = lvds_1.RowCount()
	lvl_Itens = lvdwc.RowCount()
	
	For lvl_Item = 1 To lvl_Itens
		lvdwc.DeleteRow(lvl_Item)
	Next
	
	For lvl_Linha = 1 To lvl_Total		
		lvs_Lote = lvds_1.Object.Nr_Lote[lvl_Linha]
		
		If lvs_Lote_Informado <> lvs_Lote Then
			lvl_Insert = lvdwc.InsertRow(0)
			lvdwc.SetItem(lvl_Insert, "nr_lote", lvs_Lote)
		End If
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild.")
End If

Destroy(lvds_1)
end subroutine

public subroutine of_lote_lancado (dc_uo_dw_base pdw_lotes);Long lvl_Linha, &
	  lvl_Total, &
	  lvl_Qtde, &
	  lvl_Insert, &
	  lvl_produto
	  
String lvs_Lote

lvl_Total = pdw_Lotes.RowCount()

This.ivds_Lote_Lancado.Reset()

For lvl_Linha = 1 To lvl_Total
	lvl_produto = pdw_Lotes.Object.Cd_Produto[lvl_Linha]
	lvs_Lote    = pdw_Lotes.Object.Nr_Lote	  [lvl_Linha]
	lvl_Qtde		= pdw_Lotes.Object.Qt_Lote	  [lvl_Linha]
	
	lvl_Insert = This.ivds_Lote_Lancado.InsertRow(0)
	
	This.ivds_Lote_Lancado.Object.Cd_Produto[lvl_Insert] = lvl_produto
	This.ivds_Lote_Lancado.Object.Nr_Lote	 [lvl_Insert] = lvs_Lote
	This.ivds_Lote_Lancado.Object.Qt_Lote	 [lvl_Insert] = lvl_Qtde
Next
end subroutine

public subroutine of_preenche_lista_matriz (dc_uo_dw_base pdw_datawindow, long pl_filial, long pl_produto);DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row
		  
Long lvl_Linha, &
     lvl_Total,&
	 lvl_Itens,&
	 lvl_Item,&
	 lvl_Insert
	  
String lvs_Lote,&
	   lvs_Lote_Informado

dc_uo_ds_base lvds_1

lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject("ds_ge092_saldo_lote_matriz") Then
	Destroy(lvds_1)
	Return
End If

lvds_1.Retrieve(pl_Filial, pl_Produto)

If pdw_datawindow.GetChild("nr_lote", lvdwc) = 1 Then
	
	lvdwc.Reset()
	
	// Limpa os lotes informados
	lvl_Itens = lvdwc.RowCount()
	
	For lvl_Item = 1 To lvl_Itens
		lvdwc.DeleteRow(lvl_Item)
	Next
		
	lvl_Total = lvds_1.RowCount()
	lvl_Itens = lvdwc.RowCount()
	
	For lvl_Item = 1 To lvl_Itens
		lvdwc.DeleteRow(lvl_Item)
	Next
							
	For lvl_Linha = 1 To lvl_Total		
		lvs_Lote = lvds_1.Object.Nr_Lote[lvl_Linha]
		
		If lvs_Lote_Informado <> lvs_Lote Then
			lvl_Insert = lvdwc.InsertRow(0)
			lvdwc.SetItem(lvl_Insert, "nr_lote", lvs_Lote)
		End If
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild.")
End If

Destroy(lvds_1)
end subroutine

public subroutine of_preenche_lista (dc_uo_dw_base pdw_datawindow, long pl_produto);This.of_Preenche_Lista( pdw_Datawindow, pl_Produto, "ds_ge092_saldo_lote" )
end subroutine

public subroutine of_lote_lancado (dc_uo_dw_base pdw_lotes, long pl_produto);Long lvl_Linha, &
	  lvl_Total, &
	  lvl_Qtde, &
	  lvl_Qtde_E, &
	  lvl_Insert, &
	  lvl_produto
	  
String lvs_Lote

lvl_Total = pdw_Lotes.RowCount()

This.ivds_Lote_Lancado.Reset()

For lvl_Linha = 1 To lvl_Total
	
	lvl_produto = pdw_Lotes.Object.Cd_Produto[lvl_Linha]
	lvs_Lote    = pdw_Lotes.Object.Nr_Lote	  [lvl_Linha]
	lvl_Qtde		= pdw_Lotes.Object.Qt_Lote	  [lvl_Linha]
	
	lvl_Insert = This.ivds_Lote_Lancado.InsertRow(0)
	
	This.ivds_Lote_Lancado.Object.Cd_Produto[lvl_Insert] = lvl_produto
	This.ivds_Lote_Lancado.Object.Nr_Lote	 [lvl_Insert] = lvs_Lote
	This.ivds_Lote_Lancado.Object.Qt_Lote	 [lvl_Insert] = lvl_Qtde
Next
end subroutine

public function boolean of_lote_unico (dc_uo_dw_base pdw_lotes, long pl_produto, date pdt_dispensacao);Long lvl_Linha, &
	  lvl_Total, &
	  lvl_Total_Itens, &
	  lvl_Qtde, &
	  lvl_Find
	  
String lvs_Lote

lvl_Total = pdw_Lotes.RowCount()

For lvl_Linha = 1 To lvl_Total
	IF lvl_Linha >= lvl_Total THEN EXIT
	
	lvs_Lote = pdw_Lotes.Object.Nr_Lote[lvl_Linha]
	
	lvl_Find = pdw_Lotes.Find("nr_lote = '" + lvs_Lote + "' and qt_lote > 0", lvl_Linha+1, lvl_Total)
	
	If lvl_Find > 0 Then
		
		lvl_Qtde = pdw_Lotes.Object.Qt_Lote[lvl_Find]
		pdw_Lotes.Object.Qt_Lote[lvl_Linha] = pdw_Lotes.Object.Qt_Lote[lvl_Linha] + lvl_Qtde
		pdw_Lotes.Object.Qt_Lote[lvl_Find]  = 0		
	
		lvl_Linha --
	End If
Next

lvl_Find = pdw_Lotes.Find("qt_lote = 0", 1, lvl_Total)

Do While lvl_Find > 0
	pdw_Lotes.DeleteRow(lvl_Find)
	lvl_Find++
	
	If lvl_Find > lvl_Total THEN EXIT
	
	lvl_Find = pdw_Lotes.Find("qt_lote = 0", 1, lvl_Total)

Loop

Return of_Valida_Qtde_Lote(pdw_lotes, pl_Produto, pdt_dispensacao)
end function

public function boolean of_valida_qtde_lote (dc_uo_dw_base pdw_datawindow, long pl_produto, date pdt_dispensacao);Long lvl_Linha, &
	  lvl_total, &
	  lvl_Qtde , &
	  lvl_Qtde_E , &
	  lvl_Qtde_Saldo, &
	  lvl_Find

Boolean lb_Entrou_Apos

String lvs_Lote

lvl_Total = pdw_datawindow.RowCount()

For lvl_Linha = 1 To lvl_Total	
	lb_Entrou_Apos = False

	lvs_Lote = pdw_datawindow.Object.Nr_Lote[lvl_Linha]
	lvl_Qtde = pdw_datawindow.Object.Qt_Lote[lvl_Linha]
	
	lvl_Find = ivds_Lote_Lancado.Find("cd_produto = " + String(pl_produto) + " and nr_lote = '" + lvs_Lote + "'", 1, ivds_Lote_Lancado.RowCount())
	
	Select qt_lote
	 Into :lvl_Qtde_Saldo
	  From saldo_produto_lote
	 Where cd_produto = :pl_produto
	   And nr_lote    = :lvs_Lote
	 Using SqlCa;
	 
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo produto lote")
		Return False
	 Else
		If lvl_Find > 0 Then
			lvl_Qtde_Saldo = lvl_Qtde_Saldo + ivds_Lote_Lancado.Object.Qt_Lote[lvl_Find]
		End If
		
		If Not of_Dedus_Entradas(pl_produto, lvs_Lote, pdt_dispensacao, Ref lvl_Qtde_Saldo, Ref lb_Entrou_Apos) Then
			Return False
		End If
		
		If lvl_Qtde > lvl_Qtde_Saldo Then
			If Not lb_Entrou_Apos Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo insuficiente do lote '" + lvs_Lote + "'.")
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "                           Verifique os lotes lan$$HEX1$$e700$$ENDHEX$$ados.~r" + &
											 "Lotes adquiridos numa data posterior a venda, n$$HEX1$$e300$$ENDHEX$$o podem ser usados.")	
			End If
			
			Return False
			
		End If
	 End If
		
Next

Return True
end function

public function boolean of_dedus_entradas (long pl_produto, string ps_lote, date pdt_dispensacao, ref long pl_qtde, ref boolean pb_entrou);Long lvl_Linha, &
	  lvl_Total, &
	  lvl_qtde_E
  
pb_entrou = False

//Estoque N$$HEX1$$e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tica
Select sum(qt_lote)
  Into :lvl_Qtde_E
  From nf_compra           n,
		 item_nf_compra_lote l
 Where n.dh_atualizacao_estoque >= :pdt_Dispensacao +1
	And l.cd_filial     = n.cd_filial
	And l.cd_fornecedor = n.cd_fornecedor
	And l.nr_nf         = n.nr_nf
	And l.de_especie    = n.de_especie
	And l.de_serie      = n.de_serie
	And l.cd_produto    = :pl_produto
	And l.nr_lote       = :ps_Lote
	AND (n.id_estoque_automatico = 'N' and n.dh_atualizacao_estoque is not null)
 Using SqlCa;
	
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Return False
		
	Case 0 //Estoque N$$HEX1$$e300$$ENDHEX$$o Autom$$HEX1$$e100$$ENDHEX$$tica
		If Not IsNull(lvl_Qtde_E) Then
			pb_entrou = True
			pl_Qtde = pl_Qtde - lvl_Qtde_E
		End If
		
		//Estoque Autom$$HEX1$$e100$$ENDHEX$$tico
		Select sum(qt_lote)
		  Into :lvl_Qtde_E
		  From nf_compra           n,
				 item_nf_compra_lote l
		 Where n.dh_movimentacao_caixa >= :pdt_Dispensacao +1
			And l.cd_filial     = n.cd_filial
			And l.cd_fornecedor = n.cd_fornecedor
			And l.nr_nf         = n.nr_nf
			And l.de_especie    = n.de_especie
			And l.de_serie      = n.de_serie
			And l.cd_produto    = :pl_produto
			And l.nr_lote       = :ps_Lote
			AND (n.id_estoque_automatico <> 'N' or n.id_estoque_automatico is null)
		 Using SqlCa;
			
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_MsgDbError()
				Return False
				
			Case 0 //Estoque Autom$$HEX1$$e100$$ENDHEX$$tico
				If Not IsNull(lvl_Qtde_E) Then
					pb_entrou = True
					pl_Qtde = pl_Qtde - lvl_Qtde_E
				End If
				
		End Choose				
			
End Choose

//Devolu$$HEX2$$e700f500$$ENDHEX$$es
If pb_entrou Then
	Select sum(qt_lote)
	  Into :lvl_Qtde_E
	  From nf_devolucao_compra           n,
			 item_nf_devolucao_compra_lote l				  		 
	 Where n.dh_movimentacao_caixa >= :pdt_Dispensacao +1
		And l.cd_filial  = n.cd_filial
		And l.nr_nf      = n.nr_nf
		And l.de_especie = n.de_especie
		And l.de_serie   = n.de_serie
		And n.dh_cancelamento is null
		And l.cd_produto = :pl_produto
		And l.nr_lote    = :ps_Lote
		And n.nr_nf_compra in ( Select distinct n.nr_nf
										  From nf_compra           n,
												 item_nf_compra_lote l
										 Where n.dh_atualizacao_estoque >= :pdt_Dispensacao +1
											And l.cd_filial     = n.cd_filial
											And l.cd_fornecedor = n.cd_fornecedor
											And l.nr_nf         = n.nr_nf
											And l.de_especie    = n.de_especie
											And l.de_serie      = n.de_serie
											And l.cd_produto    = :pl_produto
											And l.nr_lote       = :ps_Lote
											AND (n.id_estoque_automatico = 'N' and n.dh_atualizacao_estoque is not null)
											
										Union
											
										Select distinct n.nr_nf
										  From nf_compra           n,
												 item_nf_compra_lote l
										 Where n.dh_movimentacao_caixa >= :pdt_Dispensacao +1
											And l.cd_filial     = n.cd_filial
											And l.cd_fornecedor = n.cd_fornecedor
											And l.nr_nf         = n.nr_nf
											And l.de_especie    = n.de_especie
											And l.de_serie      = n.de_serie
											And l.cd_produto    = :pl_produto
											And l.nr_lote       = :ps_Lote
											AND (n.id_estoque_automatico <> 'N' or n.id_estoque_automatico is null)
											)
	 Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			Return False
				
		Case 0
			If Not IsNull(lvl_Qtde_E) Then
				pl_Qtde = pl_Qtde + lvl_Qtde_E
			End If
		
	End Choose
	
End If

If pb_Entrou Then
	Select sum(qt_lote)
	  Into :lvl_Qtde_E
	  From lancamento_psico              n,
			 lancamento_psico_produto_lote l
	 Where n.dh_dispensacao > :pdt_Dispensacao
		And l.cd_filial      = n.cd_filial
		And l.nr_nf          = n.nr_nf
		And l.de_especie     = n.de_especie
		And l.de_serie       = n.de_serie
		And l.nr_nsr         = n.nr_nsr
		And l.cd_produto     = :pl_produto
		And l.nr_lote        = :ps_Lote
	 Using SqlCa;
	 
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			Return False
				
		Case 0
			If Not IsNull(lvl_Qtde_E) Then
				pl_Qtde = pl_Qtde + lvl_Qtde_E
			End If
		
	End Choose
		
End If
		
If pb_Entrou Then
	Select sum(qt_lote)
	  Into :lvl_Qtde_E
	  From nf_transferencia           n,
	       item_nf_transferencia_lote l,
			 parametro                  p
	 Where n.dh_movimentacao_caixa > :pdt_Dispensacao
		And l.cd_filial_origem = n.cd_filial_origem
		And l.nr_nf          = n.nr_nf
		And l.de_especie     = n.de_especie
		And l.de_serie       = n.de_serie
		And n.cd_filial_origem <> p.cd_filial
		And l.cd_produto       = :pl_produto
		And l.nr_lote          = :ps_Lote
		And p.id_parametro     = '1'
	 Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			Return False
				
		Case 0
			If Not IsNull(lvl_Qtde_E) Then
				pl_Qtde = pl_Qtde + lvl_Qtde_E
			End If
		
	End Choose
	
End If

Return True
end function

public subroutine of_preenche_lista (dc_uo_dw_base pdw_datawindow, long pl_produto, string ps_datastore);DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row
		  
Long lvl_Linha, &
     lvl_Total,&
	  lvl_Itens,&
	  lvl_Item,&
	  lvl_Insert
	  
String lvs_Lote,&
	    lvs_Lote_Informado

dc_uo_ds_base lvds_1

lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject( ps_DataStore ) Then
	Destroy(lvds_1)
	Return
End If

lvl_Total = lvds_1.Retrieve(pl_Produto)

If pdw_datawindow.GetChild("nr_lote", lvdwc) = 1 Then
	
	// Limpa os lotes informados
	lvl_Itens = lvdwc.RowCount()
	
	For lvl_Item = 1 To lvl_Itens
		lvdwc.DeleteRow(lvl_Item)
	Next
		
	lvl_Total = lvds_1.RowCount()
	lvl_Itens = lvdwc.RowCount()
	
	For lvl_Item = 1 To lvl_Itens
		lvdwc.DeleteRow(lvl_Item)
	Next
	
	For lvl_Linha = 1 To lvl_Total		
		lvs_Lote = lvds_1.Object.Nr_Lote[lvl_Linha]
		
		If lvs_Lote_Informado <> lvs_Lote Then
			lvl_Insert = lvdwc.InsertRow(0)
			lvdwc.SetItem(lvl_Insert, "nr_lote", lvs_Lote)
		End If
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild.")
End If

Destroy(lvds_1)
end subroutine

on uo_saldo_lote.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_saldo_lote.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivds_lote_lancado = Create dc_uo_ds_base
ivds_lote_lancado.of_ChangeDataObject("ds_ge092_lote_lancado")
end event

event destructor;Destroy(ivds_lote_lancado)
end event

