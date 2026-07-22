HA$PBExportHeader$w_ge230_item_nf_lote_response.srw
forward
global type w_ge230_item_nf_lote_response from dc_w_response_ok_cancela
end type
type cb_confirma from commandbutton within w_ge230_item_nf_lote_response
end type
type cb_1 from commandbutton within w_ge230_item_nf_lote_response
end type
type cb_refresh from commandbutton within w_ge230_item_nf_lote_response
end type
end forward

global type w_ge230_item_nf_lote_response from dc_w_response_ok_cancela
integer width = 2866
integer height = 1156
string title = "GE230 - Lan$$HEX1$$e700$$ENDHEX$$amento de Lotes dos Produtos Controlados"
long backcolor = 80269524
cb_confirma cb_confirma
cb_1 cb_1
cb_refresh cb_refresh
end type
global w_ge230_item_nf_lote_response w_ge230_item_nf_lote_response

type variables
uo_ge230_parametro_nota_lote ivo_lote
uo_saldo_lote ivo_lista_lotes

string ivs_tipo
end variables

forward prototypes
public subroutine wf_controle_lote_produto ()
public function boolean wf_atualiza_nf ()
public function integer wf_valida_lote_informado ()
public function integer wf_valida_lote_informado_dev_compra ()
end prototypes

public subroutine wf_controle_lote_produto ();Long   ll_row            , &
	    ll_new_row        , & 
	    ll_coluna         , &
	    ll_Quantidade     , &
	    ll_lote           , &
	    ll_Nota           , & 
	    ll_Filial         , &
	    ll_Natureza_Opera , &
	    ll_Produto        , &
	    ll_Qtde_Informada      

String ls_Especie        , &
       	ls_Serie          , & 
       	ls_Nulo           , &  
       	ls_Produto        , &
	    	ls_tipo_nota      , &
	    	ls_fornecedor     , &
	    	ls_id_origem_nf ,&
		ls_Coluna

SetNull(ls_Nulo)

ls_Tipo_Nota     = ivo_Lote.id_tipo_nota

ll_row = dw_1.GetRow()

If ll_row = 0 Then Return

ll_Quantidade        = dw_1.object.quantidade          [ll_row]

If ls_tipo_nota = "T" Then
 	ll_Filial  	   	 = dw_1.object.cd_filial_origem   [ll_row]
Else
	ll_Filial  		 = dw_1.object.cd_filial             [ll_row]
End if

If ls_Tipo_Nota = "C" Then
  	ls_fornecedor      = dw_1.object.cd_fornecedor      [ll_row]
End If

If ls_Tipo_Nota = "DV" Then
  	ls_id_origem_nf    = dw_1.Object.id_origem_nf       [ll_row] 
End If

ll_Nota    		      = dw_1.Object.nr_nf			       [ll_row]
ls_Especie 		      = dw_1.Object.de_especie          [ll_row]
ls_Serie   		      = dw_1.Object.de_serie	          [ll_row]
ll_Natureza_Opera    = dw_1.Object.cd_natureza_operacao[ll_row]
ll_Produto		      = dw_1.Object.cd_produto		    [ll_row]
ls_Produto		      = dw_1.object.de_produto    	    [ll_row]

//ll_coluna = dw_1.GetColumn()

ls_Coluna = dw_1.GetColumnName()

Choose Case ls_Coluna
	Case '' // Coluna lote
		
//	dw_1.Event ue_pos(ll_row,"qt_lote")
		
	Case "qt_lote" // Coluna quantidade lote

		Long ll_Sucesso
		
		ll_Sucesso = dw_1.AcceptText()
		
		If ll_Sucesso = -1 Then Return 
		
		ll_Qtde_Informada = dw_1.object.quantidade[ll_row]
		ll_lote           = dw_1.GetItemNumber(ll_row,"qt_lote_produto")		
		
		If ll_lote < ll_Quantidade Then
			
			ll_new_row = dw_1.InsertRow(ll_row +1)
		
			If ls_Tipo_Nota = "T" Then
				dw_1.Object.cd_filial_origem [ll_new_row]  = ll_Filial
			Else
				dw_1.Object.cd_filial     	  [ll_new_row]  = ll_Filial
			End If
			
			If ls_Tipo_Nota = "C" Then
				dw_1.object.cd_fornecedor    [ll_new_row]  = ls_fornecedor
			End If
			
			If ls_Tipo_Nota = "DV" Then
				dw_1.Object.id_origem_nf     [ll_new_row]  = ls_id_origem_nf
			End If
								
			dw_1.Object.cd_natureza_operacao[ll_new_row]  = ll_Natureza_Opera		
			dw_1.object.de_produto      	  [ll_new_row]  = ls_Produto
			dw_1.object.quantidade    	     [ll_new_row]  = ll_Quantidade
			dw_1.Object.nr_nf				     [ll_new_row]  = ll_Nota
			dw_1.Object.de_especie      	  [ll_new_row]  = ls_Especie
			dw_1.Object.de_serie	    	     [ll_new_row]  = ls_Serie
			dw_1.Object.cd_produto		     [ll_new_row]  = ll_Produto
			
			ll_row ++
			
			dw_1.object.qt_lote[ll_row] = ll_Qtde_Informada - ll_lote
			dw_1.object.nr_lote[ll_row] = ls_Nulo
			
			//ll_row --
			
			dw_1.ScrollToRow(ll_row)
		
		ElseIf ll_lote > ll_Quantidade Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Quantidade de lote(s) excedeu !",Exclamation!)
				dw_1.object.qt_lote[ll_row] = 0
		End If
		
		dw_1.Event ue_pos(ll_row,"nr_lote")
		
End Choose		

end subroutine

public function boolean wf_atualiza_nf ();//If ivo_Lote.id_Tipo_Nota = "T" Then
//	Update nf_transferencia_online
//	  Set dh_transferencia = null
//	Where cd_filial_origem  = :ivo_Lote.cd_filial
//	  and nr_nf         	= :ivo_Lote.nr_nf
//	  and de_especie    	= :ivo_Lote.de_especie
//	  and de_serie      	= :ivo_Lote.de_serie
//	Using Sqlca;
//	
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Transfer$$HEX1$$ea00$$ENDHEX$$ncia online")
//		Return False
//	End If
//End If
		
Return True
end function

public function integer wf_valida_lote_informado ();Integer lvi_Retorno = 1

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Produto,&
	 lvl_Qtde,&
	 lvl_Find,&
	 lvl_Qtde_Atual,&
	 lvl_Saldo
	 	 
String lvs_Lote
	 
lvl_Linhas = dw_1.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto = dw_1.Object.cd_produto[lvl_Linha]
	lvs_Lote    = dw_1.Object.nr_lote   [lvl_Linha]
	lvl_Qtde    = dw_1.Object.qt_lote   [lvl_Linha]
	
	If lvl_Linha < lvl_Linhas Then
		lvl_Find    = dw_1.Find("cd_produto =" + String(lvl_Produto) + " and nr_lote = '" + lvs_Lote + "'", lvl_Linha + 1, lvl_Linhas)
		
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto da Data Window.")
			lvi_Retorno = -1
			Exit
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote '" + lvs_Lote + "' foi informado mais de uma vez.", Exclamation!)
		lvi_Retorno = -1
		Exit
	Else
		
		Select qt_lote 
		Into :lvl_Qtde_Atual
		From item_nf_transferencia_lote
		Where cd_filial_origem = :ivo_Lote.cd_filial
		  and nr_nf			   = :ivo_Lote.nr_nf
		  and de_especie	   = :ivo_Lote.de_especie
		  and de_serie		   = :ivo_Lote.de_serie
		  and cd_produto	   = :lvl_Produto
		  and nr_lote		   = :lvs_Lote
		Using SqlCa;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da qtde atual do lote.")
			lvi_Retorno = -1 
			Exit
		End If
		
		Select qt_lote 
		Into :lvl_Saldo
		From saldo_produto_lote
		Where cd_produto = :lvl_Produto
		  and nr_lote	 = :lvs_Lote
	    Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do lote do produto.")
			lvi_Retorno = -1 
			Exit
		End If
		
		lvl_Saldo = lvl_Saldo + lvl_Qtde_Atual
		
		If lvl_Qtde > lvl_Saldo Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo insuficiente para o lote '" + lvs_Lote +  "'.", Exclamation!)
			lvi_Retorno = -1
			Exit
		End If
	End if
Next 

Return lvi_Retorno
end function

public function integer wf_valida_lote_informado_dev_compra ();Integer lvi_Retorno = 1

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Produto,&
	 lvl_Qtde,&
	 lvl_Find,&
	 lvl_Qtde_Atual,&
	 lvl_Saldo
	 	 
String lvs_Lote
	 
lvl_Linhas = dw_1.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto = dw_1.Object.cd_produto[lvl_Linha]
	lvs_Lote    = dw_1.Object.nr_lote   [lvl_Linha]
	lvl_Qtde    = dw_1.Object.qt_lote   [lvl_Linha]
	
	If lvl_Linha < lvl_Linhas Then
		lvl_Find    = dw_1.Find("cd_produto =" + String(lvl_Produto) + " and nr_lote = '" + lvs_Lote + "'", lvl_Linha + 1, lvl_Linhas)
		
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto da DataWindow.")
			lvi_Retorno = -1
			Exit
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote '" + lvs_Lote + "' foi informado mais de uma vez.", Exclamation!)
		lvi_Retorno = -1
		Exit
	Else
		
		Select qt_lote 
		  Into :lvl_Saldo
		  From saldo_produto_lote
		 Where  cd_filial = 534
		   And cd_produto = :lvl_Produto
		   And nr_lote	   = :lvs_Lote
			And qt_lote    > 0
	    Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do lote do produto.")
			lvi_Retorno = -1 
			Exit
		End If
		
		If lvl_Qtde > lvl_Saldo Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo insuficiente para o lote '" + lvs_Lote +  "'.", Exclamation!)
			lvi_Retorno = -1
			Exit
		End If
	End if
Next 

Return lvi_Retorno
end function

on w_ge230_item_nf_lote_response.create
int iCurrent
call super::create
this.cb_confirma=create cb_confirma
this.cb_1=create cb_1
this.cb_refresh=create cb_refresh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_confirma
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_refresh
end on

on w_ge230_item_nf_lote_response.destroy
call super::destroy
destroy(this.cb_confirma)
destroy(this.cb_1)
destroy(this.cb_refresh)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

ivo_Lote 		 = Create uo_ge230_parametro_nota_lote 
ivo_Lista_lotes = Create uo_saldo_lote 

ivo_Lote = Message.PowerObjectParm	

String lvs_DW

ivs_Tipo = ivo_Lote.id_Tipo_Nota

Choose Case ivo_Lote.id_Tipo_Nota
	Case "T"  ; lvs_DW = "dw_ge230_detalhes"                  // Transfer$$HEX1$$ea00$$ENDHEX$$ncia
	Case "C"  ; lvs_DW = "dw_ge230_detalhes_compra"           // Compra
	Case "DC" ; lvs_DW = "dw_ge230_detalhes_devolucao_compra" // Devolu$$HEX2$$e700e300$$ENDHEX$$o Compra
	Case "DV" ; lvs_DW = "dw_ge230_detalhes_devolucao_venda"  // Devolu$$HEX2$$e700e300$$ENDHEX$$o Venda
		
	Case Else 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de nota n$$HEX1$$e300$$ENDHEX$$o defenida '" + ivo_Lote.id_Tipo_Nota + "'.")
		Return
End Choose

If Not dw_1.of_ChangeDataObject(lvs_Dw) Then
	Return
End If

dw_1.Event ue_Retrieve()

If dw_1.RowCount() = 0 Then
	ivo_Lote.ivb_Sucesso = True
	Close(This)
	Return
End If
end event

event ue_save;call super::ue_save;ivo_Lote.ivb_Sucesso = False

If AncestorReturnValue = 1 Then
	
//	// Transfer$$HEX1$$ea00$$ENDHEX$$ncia
//	If ivo_Lote.id_Tipo_Nota = "T" Then
//		LF_GE096_Transferencia_Online()
//	End If
	
	ivo_Lote.ivb_Sucesso = True
	Close(This)
	
End If

Return AncestorReturnValue
end event

event ue_presave;call super::ue_presave;
Long ll_row
Long ll_quantidade
Long ll_total_lotes
Long ll_lote

String ls_Produto
String ls_Lote

dw_1.AcceptText()

For ll_row = 1 To dw_1.RowCount()

	ll_quantidade = dw_1.object.quantidade[ll_row]
	ls_lote       = dw_1.object.nr_lote   [ll_row]
	ll_lote       = dw_1.object.qt_lote   [ll_row]
	
	ll_total_lotes = dw_1.GetItemNumber(ll_row,"qt_lote_produto")
	
	ls_Produto     = dw_1.object.de_produto[ll_row]
	
	If ll_quantidade <> ll_total_lotes Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + ls_Produto + " possui inconsist$$HEX1$$ea00$$ENDHEX$$ncias.",Exclamation!)
		dw_1.Event ue_Pos(ll_Row, "qt_lote")
		Return False
	End If
	
	If IsNull(ls_Lote) or Trim(ls_Lote) = '' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + ls_Produto + " possui inconsist$$HEX1$$ea00$$ENDHEX$$ncias.",Exclamation!)
		dw_1.Event ue_Pos(ll_Row, "nr_lote")
		Return False
	End If
	
	If ll_lote = 0 Then
		dw_1.DeleteRow(ll_row)
		ll_row --
		Continue
	End If	
	
	Choose Case ivo_Lote.id_tipo_nota
		
		Case "T" 			
			If IsNull(dw_1.object.cd_filial_origem[ll_row]) Then
				dw_1.object.cd_filial_origem    [ll_row] = dw_1.object.item_nf_transferencia_cd_filial_origem[ll_row]
				dw_1.object.nr_nf               [ll_row] = dw_1.object.item_nf_transferencia_nr_nf           [ll_row]
				dw_1.object.de_especie          [ll_row] = dw_1.object.item_nf_transferencia_de_especie      [ll_row]
				dw_1.object.de_serie            [ll_row] = dw_1.object.item_nf_transferencia_de_serie        [ll_row]
				dw_1.object.cd_natureza_operacao[ll_row] = dw_1.object.item_nf_transferencia_cd_natureza     [ll_row]
				dw_1.object.cd_produto          [ll_row] = dw_1.object.item_nf_transferencia_cd_produto      [ll_row]		
			End If				
	
		Case "C" 			
			If IsNull(dw_1.object.cd_filial    [ll_row]) Then
				dw_1.object.cd_filial           [ll_row] = dw_1.object.item_nf_compra_cd_filial              [ll_row]
				dw_1.object.cd_fornecedor       [ll_row] = dw_1.object.item_nf_compra_cd_fornecedor          [ll_row]
				dw_1.object.nr_nf               [ll_row] = dw_1.object.item_nf_compra_nr_nf                  [ll_row]
				dw_1.object.de_especie          [ll_row] = dw_1.object.item_nf_compra_de_especie             [ll_row]
				dw_1.object.de_serie            [ll_row] = dw_1.object.item_nf_compra_de_serie               [ll_row]
				dw_1.object.cd_natureza_operacao[ll_row] = dw_1.object.item_nf_compra_cd_natureza            [ll_row]
				dw_1.object.cd_produto          [ll_row] = dw_1.object.item_nf_compra_cd_produto             [ll_row]		
			End If					
		
	    Case "DC" 		
			If IsNull(dw_1.object.cd_filial    [ll_row]) Then
				dw_1.object.cd_filial           [ll_row] = dw_1.object.item_nf_devolucao_compra_cd_filial    [ll_row]
				dw_1.object.nr_nf               [ll_row] = dw_1.object.item_nf_devolucao_compra_nr_nf        [ll_row]
				dw_1.object.de_especie          [ll_row] = dw_1.object.item_nf_devolucao_compra_de_especie   [ll_row]
				dw_1.object.de_serie            [ll_row] = dw_1.object.item_nf_devolucao_compra_de_serie     [ll_row]
				dw_1.object.cd_natureza_operacao[ll_row] = dw_1.object.item_nf_devolucao_compra_cd_natureza_operacao  [ll_row]
				dw_1.object.cd_produto          [ll_row] = dw_1.object.item_nf_devolucao_compra_cd_produto   [ll_row]	
			End If				
				
			If wf_Valida_Lote_Informado_Dev_Compra() < 0 Then
				Return False
			End If
			
		Case "DV" 		
			If IsNull(dw_1.object.cd_filial    [ll_row]) Then
				dw_1.object.cd_filial           [ll_row] = dw_1.object.item_nf_devolucao_venda_cd_filial    [ll_row]
				dw_1.object.nr_nf               [ll_row] = dw_1.object.item_nf_devolucao_venda_nr_nf        [ll_row]
				dw_1.object.de_especie          [ll_row] = dw_1.object.item_nf_devolucao_venda_de_especie   [ll_row]
				dw_1.object.de_serie            [ll_row] = dw_1.object.item_nf_devolucao_venda_de_serie     [ll_row]
				dw_1.object.cd_natureza_operacao[ll_row] = dw_1.object.item_nf_devolucao_venda_cd_natureza_operacao  [ll_row]
				dw_1.object.cd_produto          [ll_row] = dw_1.object.item_nf_devolucao_venda_cd_produto   [ll_row]		
				dw_1.object.id_origem_nf        [ll_row] = dw_1.object.item_nf_devolucao_venda_id_origem_nf [ll_row]		
			End If
			
		End Choose		
		
Next

If Not wf_Atualiza_Nf() Then Return False

Long ll_Fil
Long ll_mod
Long ll_del

ll_row = dw_1.RowCount()
ll_fil = dw_1.FilteredCount()
ll_mod = dw_1.ModifiedCount()
ll_del = dw_1.DeletedCount()

ll_del = ll_del

Return True
end event

event close;call super::close;Destroy(ivo_Lista_Lotes)
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge230_item_nf_lote_response
integer y = 8
integer width = 2798
integer height = 908
integer weight = 700
string facename = "Verdana"
long backcolor = 80269524
string text = "Lista de Produtos"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge230_item_nf_lote_response
integer x = 50
integer y = 76
integer width = 2743
integer height = 808
string dataobject = "dw_ge230_detalhes"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;// OverRide
Long ll_Retorno

Choose Case ivo_Lote.id_Tipo_Nota
	Case "T"  //Transfer$$HEX1$$ea00$$ENDHEX$$ncia
		Return This.Retrieve(ivo_Lote.cd_filial, ivo_Lote.nr_nf, ivo_Lote.de_especie, ivo_Lote.de_serie)  
	Case "C"  //Compra
		Return This.Retrieve(ivo_Lote.cd_filial, ivo_Lote.cd_fornecedor, ivo_Lote.nr_nf, ivo_Lote.de_especie, ivo_Lote.de_serie)  
	Case "DC" //Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compra
		/* Gambiarra - 11/02/2013
		* Os lotes para os produtos devolvidos em sua totalidade, s$$HEX1$$e300$$ENDHEX$$o lan$$HEX1$$e700$$ENDHEX$$ados via trigger
		* a tela s$$HEX1$$f300$$ENDHEX$$ abre para os lotes em branco.
		*/
		//This.of_AppendWhere( "trim( l.nr_lote ) = '' " )
		Return This.Retrieve(ivo_Lote.cd_filial, ivo_Lote.nr_nf, ivo_Lote.de_especie, ivo_Lote.de_serie) 		
		/* */
	Case "DV" //Devolu$$HEX2$$e700e300$$ENDHEX$$o de Venda
		Return This.Retrieve(ivo_Lote.cd_filial, ivo_Lote.nr_nf, ivo_Lote.de_especie, ivo_Lote.de_serie, ivo_Lote.id_origem_nf)  	
End Choose


end event

event dw_1::editchanged;call super::editchanged;cb_confirma.Enabled = True
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nr_lote"
		If IsNull(data) or Trim(data) = '' Then
			Return 1
		End If
	Case 	"qt_lote"
		If Long(data) = 0 Then
			Return 1
		End If	
End Choose		

cb_confirma.Enabled = True
end event

event dw_1::ue_key;call super::ue_key;Choose Case key
	Case KeyEnter!
		wf_controle_lote_produto()
End Choose
end event

event dw_1::ue_predeleterow;// OverRide
Long lvl_Linha,&
	 lvl_Produto_Atual,&
	 lvl_Produto_Anterior
	 
If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma exclus$$HEX1$$e300$$ENDHEX$$o do registro ?", Question!, YesNo!, 2) = 2 Then
	Return False
Else
	
	If dw_1.RowCount() = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a exclus$$HEX1$$e300$$ENDHEX$$o deste registro.")
		Return False
	Else
		If This.Getrow() = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a exclus$$HEX1$$e300$$ENDHEX$$o deste registro.")
			Return False
		Else
			lvl_Produto_Atual    = dw_1.Object.cd_produto[This.Getrow()]
			lvl_Produto_Anterior = dw_1.Object.cd_produto[This.Getrow() - 1]
			
			If lvl_Produto_Atual = lvl_Produto_Anterior Then
				Return True
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a exclus$$HEX1$$e300$$ENDHEX$$o deste registro.")
				Return False
			End If
		End If
	End If
		
End If

Return True

end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;This.of_SetColSelection(True)

Return AncestorReturnValue
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;Long lvl_Produto, &
	  lvl_Nota

If This.GetRow() > 0 Then
	//  Nota de Transfer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Produto = This.Object.cd_produto[This.GetRow()]

	Choose Case ivs_Tipo
		Case "T"
			ivo_Lista_Lotes.of_Preenche_Lista_Matriz(This, 534,  lvl_Produto)
			
		Case "DC"
			//lvl_Nota = This.Object.nr_nf[1]
			//ivo_Lista_Lotes.of_Preenche_Lista(This, lvl_Nota, lvl_Produto)
			ivo_Lista_Lotes.of_Preenche_Lista_Matriz(This, 534,  lvl_Produto)
	End Choose
End If
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Integer lvi_Retorno = 1

// Nota de Transfer$$HEX1$$ea00$$ENDHEX$$ncia
Choose Case ivo_Lote.id_Tipo_Nota
	Case "T"
		lvi_Retorno = wf_Valida_Lote_Informado()	
	
	Case "DC"
//		lvi_Retorno = wf_Valida_Lote_Informado_Dev_Compra()
End Choose

Return lvi_Retorno
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge230_item_nf_lote_response
boolean visible = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge230_item_nf_lote_response
boolean visible = false
end type

type cb_confirma from commandbutton within w_ge230_item_nf_lote_response
integer x = 2441
integer y = 940
integer width = 375
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
string text = "&Confirmar"
end type

event clicked;Parent.Event ue_Save()
end event

type cb_1 from commandbutton within w_ge230_item_nf_lote_response
integer x = 1975
integer y = 940
integer width = 425
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Excluir Lote"
end type

event clicked;dw_1.Event ue_DeleteRow()
end event

type cb_refresh from commandbutton within w_ge230_item_nf_lote_response
integer x = 46
integer y = 940
integer width = 613
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar Lista"
end type

event clicked;Long	ll_Produto, &
		ll_Linha, &
		ll_Nota

dw_1.AcceptText()
ll_Linha = dw_1.GetRow()

If ll_Linha > 0 Then
	ll_Produto = dw_1.Object.Cd_Produto[ ll_Linha ]

	Choose Case ivs_Tipo
		//  Transfer$$HEX1$$ea00$$ENDHEX$$ncia
		Case "T"
			ivo_Lista_Lotes.of_Preenche_Lista_Matriz( dw_1, 534, ll_Produto )
			
		//  Dev. Compra
		Case "DC"
			ivo_Lista_Lotes.of_Preenche_Lista_Matriz( dw_1, 534, ll_Produto )
//			ll_Nota = dw_1.Object.Nr_Nf[1]
//			ivo_Lista_Lotes.of_Preenche_Lista( dw_1, ll_Nota, ll_Produto )
			
	End Choose
End If
end event

