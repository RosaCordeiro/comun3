HA$PBExportHeader$w_ge230_item_nf_lote.srw
forward
global type w_ge230_item_nf_lote from dc_w_2tab_cadastro_selecao_lista_det
end type
type cb_imprimir from commandbutton within tabpage_1
end type
end forward

global type w_ge230_item_nf_lote from dc_w_2tab_cadastro_selecao_lista_det
integer x = 5
integer y = 4
integer width = 2907
integer height = 1904
string title = "GE230 - Registro dos lotes de Medicamentos Controlados"
boolean resizable = false
long backcolor = 80269524
end type
global w_ge230_item_nf_lote w_ge230_item_nf_lote

type variables
uo_filial ivo_filial

uo_fornecedor ivo_fornecedor

//uo_parametro_loja ivo_parametro

//uo_parametro_filial ivo_parametro_filial

boolean ivb_bloqueia_alteracao

integer ivi_protect

string ivs_controla_psico

uo_saldo_lote ivo_lista_lotes

long ivl_linha_selecionada

dc_uo_dw_base dw_3

end variables

forward prototypes
public subroutine wf_controle_lote_produto ()
public function long wf_valida_quantidade_lote (string ps_lote)
public function boolean wf_atualiza_nf_transferencia (long al_filial, long al_nota, string as_especie, string as_serie)
public subroutine wf_localiza_fornecedor ()
public subroutine wf_localiza_filial ()
public function boolean wf_atualiza_nf_compra (long al_filial, string al_fornecedor, long al_nota, string as_especie, string as_serie)
public function boolean wf_atualiza_nf_devolucao_compra (long al_filial, long al_nota, string as_especie, string as_serie)
public function boolean wf_atualiza_nf_devolucao_venda (long al_filial, long al_nota, string as_especie, string as_serie, string as_id_origem_nf)
public function string wf_verifica_liberacao_transferencia (long al_filial, long al_nota, string as_especie, string as_serie)
public function string wf_verifica_liberacao_devolucao_compra (long al_filial, long al_nota, string as_especie, string as_serie)
public function string wf_verifica_liberacao_devolucao_venda (long al_filial, long al_nota, string as_especie, string as_serie, string as_id_origem_nf)
public function string wf_verifica_liberacao_compra (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie)
public function boolean wf_atualiza_data_exportacao (string as_tipo)
public function integer wf_valida_lotes_informados (long al_filial, long al_nota, string as_especie, string as_serie)
public function integer wf_valida_lote_informado (long al_filial, long al_nota, string as_especie, string as_serie)
public function integer wf_valida_lote_informado_dev_compra (long al_filial, long al_nota, string as_especie, string as_serie)
public subroutine wf_verifica_saldo_para_alteracao ()
end prototypes

public subroutine wf_controle_lote_produto ();Long ll_row           , &
	 ll_new_row        , & 
	 ll_coluna         , &
	 ll_Quantidade     , &
	 ll_lote           , &
	 ll_Nota           , & 
	 ll_Filial         , &
	 ll_Natureza_Opera , &
	 ll_Produto        , &
	 ll_Qtde_Informada      

String ls_Especie     , &
       ls_Serie       , & 
       ls_Nulo        , &  
       ls_Produto     , &
	   ls_tipo_nota    , &
	   ls_fornecedor   , &
	   ls_id_origem_nf, &
	   ls_Coluna

SetNull(ls_Nulo)

ls_tipo_nota     = Tab_1.tabpage_1.dw_1.Object.id_tipo_nota  [1]

ll_row = dw_3.GetRow()

If ll_row = 0 Then Return

ll_Quantidade        = dw_3.object.quantidade[ll_row]

If ls_tipo_nota = "T" Then
 	ll_Filial  	   	 = dw_3.object.cd_filial_origem    [ll_row]
Else
	ll_Filial  		 = dw_3.object.cd_filial              [ll_row]
End if

If ls_Tipo_Nota = "C" Then
  	ls_fornecedor      = dw_3.object.cd_fornecedor       [ll_row]
End If

If ls_Tipo_Nota = "DV" Then
  	ls_id_origem_nf    = dw_3.Object.id_origem_nf        [ll_row] 
End If

ll_Nota    		      = dw_3.Object.nr_nf			         [ll_row]
ls_Especie 		      = dw_3.Object.de_especie           [ll_row]

ls_Serie   		      = dw_3.Object.de_serie	            [ll_row]
ll_Natureza_Opera     = dw_3.Object.cd_natureza_operacao[ll_row]
ll_Produto		      = dw_3.Object.cd_produto		      [ll_row]
ls_Produto		      = dw_3.object.de_produto    	      [ll_row]

ls_Coluna = dw_3.GetColumnName()

Choose Case ls_Coluna
	Case '13' // Coluna lote
		
//	dw_3.Event ue_pos(ll_row,"qt_lote")
		
	Case 'qt_lote' // Coluna quantidade lote

		Long ll_Sucesso
		
		ll_Sucesso = dw_3.AcceptText()
		
		If ll_Sucesso = -1 Then Return 
		
		ll_Qtde_Informada = dw_3.object.quantidade[ll_row]
		ll_lote           = dw_3.GetItemNumber(ll_row,"qt_lote_produto")		
		
		If ll_lote < ll_Quantidade Then
			
			ll_new_row = dw_3.InsertRow(ll_row +1)
		
			If ls_Tipo_Nota = "T" Then
				dw_3.Object.cd_filial_origem  [ll_new_row]  = ll_Filial
			Else
				dw_3.Object.cd_filial     	 [ll_new_row]   = ll_Filial
			End If
			
			If ls_Tipo_Nota = "C" Then
				dw_3.object.cd_fornecedor   	 [ll_new_row]  = ls_fornecedor
			End If
			
			If ls_Tipo_Nota = "DV" Then
				dw_3.Object.id_origem_nf      [ll_new_row] = ls_id_origem_nf
			End If
								
			dw_3.Object.cd_natureza_operacao [ll_new_row]  = ll_Natureza_Opera		
			dw_3.object.de_produto      	    [ll_new_row]  = ls_Produto
			dw_3.object.quantidade    	    [ll_new_row]  = ll_Quantidade
			dw_3.Object.nr_nf				    [ll_new_row]  = ll_Nota
			dw_3.Object.de_especie           [ll_new_row]  = ls_Especie
			dw_3.Object.de_serie	    	    [ll_new_row]  = ls_Serie
			dw_3.Object.cd_produto		       [ll_new_row]  = ll_Produto
			
			ll_row ++
			
			dw_3.object.qt_lote[ll_row] = ll_Qtde_Informada - ll_lote
			dw_3.object.nr_lote[ll_row] = ls_Nulo
			
			ll_row --
			
			dw_3.ScrollToRow(ll_row)
		
		ElseIf ll_lote > ll_Quantidade Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Quantidade de lote(s) excedeu !",Exclamation!)
				dw_3.object.qt_lote[ll_row] = 0
		End If
		
		dw_3.Event ue_pos(ll_row,"nr_lote")
		
End Choose		

end subroutine

public function long wf_valida_quantidade_lote (string ps_lote);String ls_tipo_nota

Long ll_row         , & 
     ll_quantidade  , & 
     ll_lote

ls_tipo_nota = Tab_1.tabpage_1.dw_1.Object.id_tipo_nota  [1]

ll_row = Tab_1.tabpage_2.dw_3.GetRow()

Choose Case ls_tipo_nota

  Case "T" 
	   	ll_quantidade = Tab_1.tabpage_2.dw_3.object.qt_transferida[ll_row]
  Case "C" 
         ll_quantidade = Tab_1.tabpage_2.dw_3.object.qt_faturada[ll_row]	
  Case "D" 
         ll_quantidade = Tab_1.tabpage_2.dw_3.object.qt_devolvida[ll_row]
  Case "V" 
         ll_quantidade = Tab_1.tabpage_2.dw_3.object.qt_devolvida[ll_row]	
		
End Choose

ll_lote        = Tab_1.tabpage_2.dw_3.GetItemNumber(ll_row,"qt_lote_produto")	
		
If ll_lote > ll_quantidade       and ls_tipo_nota = "T" Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Quantidade de lotes excede quantidade transferida na Nota fiscal.",Exclamation!)
	Return 1
End If

Return 0


end function

public function boolean wf_atualiza_nf_transferencia (long al_filial, long al_nota, string as_especie, string as_serie);Update nf_transferencia  
 Set id_registro_lote = 'L'
Where nf_transferencia.cd_filial_origem = :al_Filial 
  and nf_transferencia.nr_nf 			    = :al_Nota 
  and nf_transferencia.de_especie 	    =	:as_Especie
  and nf_transferencia.de_serie 		    = :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Nf de Transfer$$HEX1$$ea00$$ENDHEX$$ncia")
	Return False
End If

Return True
end function

public subroutine wf_localiza_fornecedor ();STRING ls_fornecedor

ls_fornecedor = tab_1.tabpage_1.dw_1.GetText()

ivo_fornecedor.Of_Localiza_Fornecedor(ls_fornecedor)

IF ivo_fornecedor.Localizado THEN
	  
	tab_1.tabpage_1.dw_1.Object.cd_fornecedor  [1] = ivo_fornecedor.cd_fornecedor
	tab_1.tabpage_1.dw_1.Object.nm_razao_social[1] = ivo_fornecedor.nm_razao_social

END IF


end subroutine

public subroutine wf_localiza_filial ();
STRING ls_filial

ls_filial = tab_1.tabpage_1.dw_1.GetText()

ivo_filial.Of_Localiza_Filial(ls_filial) 

IF ivo_filial.Localizada THEN
	  
	tab_1.tabpage_1.dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	tab_1.tabpage_1.dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia

END IF


end subroutine

public function boolean wf_atualiza_nf_compra (long al_filial, string al_fornecedor, long al_nota, string as_especie, string as_serie);Update nf_compra  
 Set id_registro_lote = 'L'
Where nf_compra.cd_filial      = :al_Filial 
  and nf_compra.cd_fornecedor  = :al_Fornecedor
  and nf_compra.nr_nf 			 = :al_Nota 
  and nf_compra.cd_fornecedor  = :al_Fornecedor
  and nf_compra.de_especie     =	:as_Especie
  and nf_compra.de_serie 		 = :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Nf de Compra")
	Return False
End If

Return True
end function

public function boolean wf_atualiza_nf_devolucao_compra (long al_filial, long al_nota, string as_especie, string as_serie);Update nf_devolucao_compra  
 Set id_registro_lote = 'L'
Where nf_devolucao_compra.cd_filial      = :al_Filial 
  and nf_devolucao_compra.nr_nf 			  = :al_Nota 
  and nf_devolucao_compra.de_especie     = :as_Especie
  and nf_devolucao_compra.de_serie       = :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Nf de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compra")
	Return False
End If

Return True
end function

public function boolean wf_atualiza_nf_devolucao_venda (long al_filial, long al_nota, string as_especie, string as_serie, string as_id_origem_nf);Update nf_devolucao_venda  
 Set  id_registro_lote = 'L'
Where nf_devolucao_venda.cd_filial      = :al_Filial 
  and nf_devolucao_venda.nr_nf 			 = :al_Nota 
  and nf_devolucao_venda.de_especie     = :as_Especie
  and nf_devolucao_venda.de_serie 	    = :as_serie
  and nf_devolucao_venda.id_origem_nf   = :as_id_origem_nf
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Nf de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Venda")
	Return False
End If

Return True
end function

public function string wf_verifica_liberacao_transferencia (long al_filial, long al_nota, string as_especie, string as_serie);Long lvl_Produto

Select Count(*)
Into :lvl_Produto
From item_nf_transferencia i
Where i.cd_filial_origem = :al_Filial
  and i.nr_nf 		     = :al_Nota
  and i.de_especie		 = :as_Especie
  and i.de_serie		 = :as_Serie
  and exists (Select * From item_nf_transferencia_lote l
			  where i.cd_filial_origem 	   = l.cd_filial_origem
				and i.nr_nf			       = l.nr_nf
				and i.de_especie	       = l.de_especie
			    and i.de_serie             = l.de_serie	
  				and i.cd_natureza_operacao = l.cd_natureza_operacao
				and i.cd_produto		   = l.cd_produto
   				and l.nr_lote = '')
				   
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localizar o lote do produto")
	Return "N"
Else
	If lvl_Produto > 0 Then
		Return "N"		
	End If
End If

Return "S"

end function

public function string wf_verifica_liberacao_devolucao_compra (long al_filial, long al_nota, string as_especie, string as_serie);Long lvl_Produto

Select Count(*)
Into :lvl_Produto
From item_nf_devolucao_compra i
Where i.cd_filial      = :al_Filial
  and i.nr_nf 		     = :al_Nota
  and i.de_especie	  = :as_Especie
  and i.de_serie		  = :as_Serie
  and exists (Select * From item_nf_devolucao_compra_lote l
			  where i.cd_filial        	 = l.cd_filial
				and  i.nr_nf			       = l.nr_nf
				and  i.de_especie	          = l.de_especie
			   and  i.de_serie             = l.de_serie	
  				and  i.cd_natureza_operacao = l.cd_natureza_operacao
				and  i.cd_produto		       = l.cd_produto
   			and  l.nr_lote              = '')
				   
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localizar o lote do produto")
	Return "N"
Else
	If lvl_Produto > 0 Then
		Return "N"		
	End If
End If

Return "S"

end function

public function string wf_verifica_liberacao_devolucao_venda (long al_filial, long al_nota, string as_especie, string as_serie, string as_id_origem_nf);Long lvl_Produto

Select Count(*)
Into :lvl_Produto
From item_nf_devolucao_venda i
Where i.cd_filial      = :al_Filial
  and i.nr_nf 		     = :al_Nota
  and i.de_especie	  = :as_Especie
  and i.de_serie		  = :as_Serie
  and i.id_origem_nf	  = :as_id_origem_nf
  and exists (Select * From item_nf_devolucao_venda_lote l
			  where i.cd_filial        	 = l.cd_filial
				and  i.nr_nf			       = l.nr_nf
				and  i.de_especie	          = l.de_especie
			   and  i.de_serie             = l.de_serie	
  				and  i.cd_natureza_operacao = l.cd_natureza_operacao
				and  i.cd_produto		       = l.cd_produto
				and  i.id_origem_nf		    = l.id_origem_nf
   			and  l.nr_lote              = '')
				   
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localizar o lote do produto")
	Return "N"
Else
	If lvl_Produto > 0 Then
		Return "N"		
	End If
End If

Return "S"

end function

public function string wf_verifica_liberacao_compra (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie);Long lvl_Produto

Select Count(*)
  Into :lvl_Produto
 From item_nf_compra i
Where i.cd_filial     = :al_Filial
  and i.cd_fornecedor = :as_fornecedor 
  and i.nr_nf 		    = :al_Nota
  and i.de_especie	 = :as_Especie
  and i.de_serie	    = :as_Serie
  and exists (Select *
  					 From item_nf_compra_lote l
			  		where i.cd_filial        	  = l.cd_filial
			        and i.cd_fornecedor        = l.cd_fornecedor 
					  and i.nr_nf			        = l.nr_nf
					  and i.de_especie	        = l.de_especie
			    	  and i.de_serie             = l.de_serie	
  					  and i.cd_natureza_operacao = l.cd_natureza_operacao
					  and i.cd_produto		     = l.cd_produto
   			     and l.nr_lote             = '')
				   
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localizar o lote do produto")
	Return "N"
Else
	If lvl_Produto > 0 Then
		Return "N"		
	End If
End If

Return "S"

end function

public function boolean wf_atualiza_data_exportacao (string as_tipo);DateTime lvdh_Movimento

String lvs_Especie, &
	   lvs_Serie, &
	   lvs_fornecedor, &
	   lvs_Origem_NF
			
Long   lvl_Filial, &
       lvl_NF	  , &
	   ll_row
		 
ll_row = Tab_1.TabPage_1.dw_2.GetRow()
		 
//lvdh_Movimento = ivo_Parametro.of_DH_Movimentacao()

lvdh_Movimento = gvo_Parametro.Of_Dh_Movimentacao()

// Compra
If as_Tipo = "C" Then
	
	lvl_filial     = Tab_1.TabPage_1.dw_2.Object.cd_filial      [ll_row]
	lvs_fornecedor = Tab_1.tabpage_1.dw_2.object.cd_fornecedor  [ll_row] 
	lvl_NF         = Tab_1.tabpage_1.dw_2.object.nr_nf          [ll_row]        
	lvs_Especie    = Tab_1.tabpage_1.dw_2.object.de_especie     [ll_row]    
	lvs_Serie      = Tab_1.tabpage_1.dw_2.object.de_serie       [ll_row] 
	
//	Update nf_compra  
//	  Set dh_exportacao = :lvdh_Movimento
//	Where cd_filial     = :lvl_filial 
//	  and cd_fornecedor = :lvs_fornecedor
//	  and nr_nf         = :lvl_nf
//	  and de_especie    = :lvs_especie
//	  and de_serie      = :lvs_serie 
//	Using Sqlca;
//	
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de exporta$$HEX2$$e700e300$$ENDHEX$$o da NF de compra")
//		Return False
//	End If
	
End If

// Transfer$$HEX1$$ea00$$ENDHEX$$ncia
If as_Tipo = "T" Then
	
	lvl_Filial     = Tab_1.TabPage_1.dw_2.Object.cd_filial_origem[ll_row]
	lvl_NF         = Tab_1.tabpage_1.dw_2.object.nr_nf           [ll_row]        
	lvs_Especie    = Tab_1.tabpage_1.dw_2.object.de_especie      [ll_row]    
	lvs_Serie      = Tab_1.tabpage_1.dw_2.object.de_serie        [ll_row] 
	
//	Update nf_transferencia
//	  Set dh_exportacao = :lvdh_Movimento
//	Where cd_filial_origem   = :lvl_filial 
//	  and nr_nf         	 = :lvl_nf
//	  and de_especie    	 = :lvs_especie
//	  and de_serie      	 = :lvs_serie 
//	Using Sqlca;
//	
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de exporta$$HEX2$$e700e300$$ENDHEX$$o da NF de transfer$$HEX1$$ea00$$ENDHEX$$ncia")
//		Return False
//	End If
	
	Update nf_transferencia_online
	  Set dh_transferencia = null
	Where cd_filial_origem   = :lvl_filial 
	  and nr_nf         	    = :lvl_nf
	  and de_especie    	    = :lvs_especie
	  and de_serie      	    = :lvs_serie 
	Using Sqlca;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Transfer$$HEX1$$ea00$$ENDHEX$$ncia online")
		Return False
	End If
		
End If

// Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compras
If as_Tipo = "DC" Then
	lvl_Filial     = Tab_1.TabPage_1.dw_2.Object.cd_filial      [ll_row]
	lvl_NF         = Tab_1.tabpage_1.dw_2.object.nr_nf          [ll_row]        
	lvs_Especie    = Tab_1.tabpage_1.dw_2.object.de_especie     [ll_row]    
	lvs_Serie      = Tab_1.tabpage_1.dw_2.object.de_serie       [ll_row] 
	
//	Update nf_devolucao_compra  
//	  Set dh_exportacao = :lvdh_Movimento
//	Where cd_filial     = :lvl_filial 
//	  and nr_nf         = :lvl_nf
//	  and de_especie    = :lvs_especie
//	  and de_serie      = :lvs_serie 
//	Using Sqlca;
//	
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de exporta$$HEX2$$e700e300$$ENDHEX$$o da NF devolu$$HEX2$$e700e300$$ENDHEX$$o de compra")
//		Return False
//	End If
End If

// Devolu$$HEX2$$e700e300$$ENDHEX$$o de Venda
If as_Tipo = "DV" Then
	lvl_Filial     = Tab_1.TabPage_1.dw_2.Object.cd_filial      [ll_row]
	lvl_NF         = Tab_1.tabpage_1.dw_2.object.nr_nf          [ll_row]        
	lvs_Especie    = Tab_1.tabpage_1.dw_2.object.de_especie     [ll_row]    
	lvs_Serie      = Tab_1.tabpage_1.dw_2.object.de_serie       [ll_row] 
	lvs_Origem_NF  = Tab_1.TabPage_1.dw_2.Object.id_origem_nf   [ll_Row]
	
//	Update nf_devolucao_venda  
//	  Set dh_exportacao = :lvdh_Movimento
//	Where cd_filial     = :lvl_filial 
//	  and nr_nf         = :lvl_nf
//	  and de_especie    = :lvs_especie
//	  and de_serie      = :lvs_serie 
//	  and id_origem_nf  = :lvs_Origem_NF
//	Using Sqlca;
//	
//	If SqlCa.SqlCode = -1 Then
//		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de exporta$$HEX2$$e700e300$$ENDHEX$$o da NF devolu$$HEX2$$e700e300$$ENDHEX$$o de venda")
//		Return False
//	End If
End If

Return True
end function

public function integer wf_valida_lotes_informados (long al_filial, long al_nota, string as_especie, string as_serie);Integer lvi_Retorno = 1

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Produto,&
	 lvl_Qtde,&
	 lvl_Find,&
	 lvl_Insert,&
	 lvl_Qtde_Atual,&
	 lvl_Saldo
	 	 
String lvs_Lote
	 
lvl_Linhas = Tab_1.TabPage_2.dw_3.RowCount()

dc_uo_ds_base lvds 

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge230_lotes") Then
	Destroy(lvds)
	Return -1
End If

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto = Tab_1.TabPage_2.dw_3.Object.cd_produto[lvl_Linha]
	lvs_Lote    = Tab_1.TabPage_2.dw_3.Object.nr_lote   [lvl_Linha]
	lvl_Qtde    = Tab_1.TabPage_2.dw_3.Object.qt_lote   [lvl_Linha]
	
	lvl_Find    = lvds.Find("cd_produto =" + String(lvl_Produto) + " and nr_lote = '" + lvs_Lote + "'", 1, lvds.RowCount())
	
	If lvl_Find = -1 Then
		lvi_Retorno = -1
		Exit
	End If
	
	If lvl_Find = 0 Then
		lvl_Insert = lvds.InsertRow(0)
		lvds.Object.cd_produto[lvl_Insert] = lvl_Produto
		lvds.Object.nr_lote	  [lvl_Insert] = lvs_Lote
		lvds.Object.qt_lote	  [lvl_Insert] = lvl_Qtde
	Else
		lvds.Object.qt_lote	  [lvl_Find] = lvds.Object.qt_lote[lvl_Find] + lvl_Qtde
	End If
Next 

If lvi_Retorno = 1 Then
	lvl_Linha  = 0
	lvl_Linhas = lvds.RowCount()
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Produto = lvds.Object.cd_produto[lvl_Linha]
		lvs_Lote    = lvds.Object.nr_lote	[lvl_Linha]
		lvl_Qtde    = lvds.Object.qt_lote	[lvl_Linha]
		
		Select qt_lote 
		Into :lvl_Qtde_Atual
		From item_nf_transferencia_lote
		Where cd_filial_origem = :al_Filial
		  and nr_nf			   = :al_Nota
		  and de_especie	   = :as_Especie
		  and de_serie		   = :as_Serie
		  and cd_produto	   = :lvl_Produto
		  and nr_lote		   = :lvs_Lote
		Using SqlCa;
				
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da qtde atual do lote.")
			lvi_Retorno = -1 
			Exit
		End If
		
		If SqlCa.SqlCode = 100 Then
			lvl_Qtde_Atual = 0
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
		
		If SqlCa.SqlCode = 100 Then lvl_Saldo = 0
		
		lvl_Saldo = lvl_Saldo + lvl_Qtde_Atual
		
		If lvl_Qtde > lvl_Saldo Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo insuficiente para o lote '" + lvs_Lote +  "'.", Exclamation!)
			lvi_Retorno = -1
			Exit
		End If
	Next
End If

Return lvi_Retorno
end function

public function integer wf_valida_lote_informado (long al_filial, long al_nota, string as_especie, string as_serie);Integer lvi_Retorno = 1

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Produto,&
	 lvl_Qtde,&
	 lvl_Find,&
	 lvl_Qtde_Atual,&
	 lvl_Saldo
	 	 
String lvs_Lote
	 
lvl_Linhas = Tab_1.TabPage_2.dw_3.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto = Tab_1.TabPage_2.dw_3.Object.cd_produto[lvl_Linha]
	lvs_Lote    = Tab_1.TabPage_2.dw_3.Object.nr_lote   [lvl_Linha]
	lvl_Qtde    = Tab_1.TabPage_2.dw_3.Object.qt_lote   [lvl_Linha]
	
	If lvl_Linha < lvl_Linhas Then
		lvl_Find    = Tab_1.TabPage_2.dw_3.Find("cd_produto =" + String(lvl_Produto) + " and nr_lote = '" + lvs_Lote + "'", lvl_Linha + 1, lvl_Linhas)
		
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto da Data Window.")
			lvi_Retorno = -1
			Exit
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		//al_Find = lvl_Find
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote '" + lvs_Lote + "' foi informado mais de uma vez.", Exclamation!)
		lvi_Retorno = -1
		Exit
	Else
		
		Select qt_lote 
		Into :lvl_Qtde_Atual
		From item_nf_transferencia_lote
		Where cd_filial_origem = :al_Filial
		  and nr_nf			   = :al_Nota
		  and de_especie	   = :as_Especie
		  and de_serie		   = :as_Serie
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

public function integer wf_valida_lote_informado_dev_compra (long al_filial, long al_nota, string as_especie, string as_serie);Integer lvi_Retorno = 1

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Produto,&
	 lvl_Qtde,&
	 lvl_Find,&
	 lvl_Qtde_Atual,&
	 lvl_Saldo
	 	 
String lvs_Lote
	 
lvl_Linhas = Tab_1.TabPage_2.dw_3.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto = Tab_1.TabPage_2.dw_3.Object.cd_produto[lvl_Linha]
	lvs_Lote    = Tab_1.TabPage_2.dw_3.Object.nr_lote   [lvl_Linha]
	lvl_Qtde    = Tab_1.TabPage_2.dw_3.Object.qt_lote   [lvl_Linha]
	
	If lvl_Linha < lvl_Linhas Then
		lvl_Find    = Tab_1.TabPage_2.dw_3.Find("cd_produto =" + String(lvl_Produto) + " and nr_lote = '" + lvs_Lote + "'", lvl_Linha + 1, lvl_Linhas)
		
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto da Data Window.")
			lvi_Retorno = -1
			Exit
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		//al_Find = lvl_Find
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote '" + lvs_Lote + "' foi informado mais de uma vez.", Exclamation!)
		lvi_Retorno = -1
		Exit
	Else
		
		Select qt_lote 
		  Into :lvl_Saldo
		  From saldo_produto_lote
		 Where cd_filial = 534
		  and cd_produto = :lvl_Produto
		  and nr_lote	 = :lvs_Lote
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

public subroutine wf_verifica_saldo_para_alteracao ();dc_uo_dw_base lvdw_1, &
					 lvdw_2, &
		              lvdw_3

String lvs_Tipo_NF
String lvs_Especie
String lvs_Serie
String lvs_Lote
String lvs_Mensagem = ""

Long lvl_Nota
Long lvl_Filial
Long lvl_Linha
Long lvl_Linhas
Long lvl_Produto
Long lvl_Qt_Saldo_Lote

lvdw_1 = Tab_1.TabPage_1.dw_1
lvdw_2 = Tab_1.TabPage_1.dw_2
lvdw_3 = Tab_1.TabPage_2.dw_3

lvdw_1.AcceptText()
lvdw_2.AcceptText()
lvdw_3.AcceptText()

lvs_Tipo_NF = lvdw_1.Object.id_tipo_nota[1]

lvl_Linha = lvdw_2.GetRow()

If ( lvs_Tipo_NF <> 'C' ) Or ( lvdw_2.Object.De_Tipo_Mvto[ lvl_Linha ] = 'TRANSF' ) Then
	Return
End If

lvl_Linhas = lvdw_3.RowCount()

For lvl_Linha = 1 to lvl_Linhas

	lvl_Filial  = lvdw_3.Object.item_nf_compra_cd_filial	[lvl_Linha]
	lvl_Nota	   = lvdw_3.Object.item_nf_compra_nr_nf		[lvl_Linha]
	lvs_Especie = lvdw_3.Object.item_nf_compra_de_especie	[lvl_Linha]
	lvs_Serie   = lvdw_3.Object.item_nf_compra_de_serie	[lvl_Linha]
	lvl_Produto = lvdw_3.Object.cd_produto						[lvl_Linha]
	lvs_Lote		= lvdw_3.Object.nr_lote							[lvl_Linha]
	
	If Trim(lvs_Lote) = "" Or IsNull(lvs_Lote) Then
		lvdw_3.Object.Protege[lvl_Linha] = 'L'
	Else
	
		select qt_lote
		  into :lvl_Qt_Saldo_Lote
		  from item_nf_compra_lote a
		 where cd_filial  = :lvl_Filial
			and nr_nf      = :lvl_Nota
			and de_especie = :lvs_Especie
			and de_serie   = :lvs_Serie
			and cd_produto = :lvl_Produto
			and nr_lote    = :lvs_Lote
			and qt_lote <= (select qt_lote from saldo_produto_lote b where b.cd_produto = a.cd_produto and b.nr_lote = a.nr_lote)
		 using sqlca;
		 
		 Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_MsgDbError()
				Return
				
			Case 100
				lvs_Mensagem +=  "J$$HEX1$$e100$$ENDHEX$$ houve movimento de sa$$HEX1$$ed00$$ENDHEX$$da do produto " + string(lvl_Produto) + " de lote " + lvs_Lote + ".~r"
				lvdw_3.Object.Protege[lvl_Linha] = 'P'
				
		 End Choose
	End If
	 
Next

If lvs_Mensagem <> "" Then
	lvdw_3.Object.st_Legenda.Visible = 1
End If
end subroutine

on w_ge230_item_nf_lote.create
int iCurrent
call super::create
end on

on w_ge230_item_nf_lote.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;// OverRide

String lvs_Controla_Psico

Date lvdh_Movimento,&
     lvdh_Parametro


dw_3 = Tab_1.TabPage_2.dw_3

ivo_dbError = Create dc_uo_dbError

dc_uo_dw_Base lvo_Update[]
lvo_Update = {Tab_1.TabPage_2.dw_3}
This.wf_SetUpdate_DW(lvo_Update)

ivo_Filial     		 = Create uo_filial
ivo_Fornecedor 		 = Create uo_fornecedor
//ivo_parametro  		 = Create uo_Parametro_Loja
//ivo_parametro_filial  = Create uo_parametro_filial 
ivo_Lista_Lotes       = Create uo_saldo_lote 

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Recuperar(False)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Incluir(False)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.SetFocus()

Tab_1.tabpage_1.dw_1.object.dt_inicio [1] = gf_getserverdate()
Tab_1.tabpage_1.dw_1.object.dt_termino[1] = gf_getserverdate()

Tab_1.TabPage_1.dw_1.Object.de_filial.Protect 		 = 0
Tab_1.TabPage_1.dw_1.Object.nm_razao_social.Protect = 1
Tab_1.TabPage_1.dw_1.Object.nr_pedido.Protect       = 1

ivl_Linha_Selecionada = 0

// Par$$HEX1$$e200$$ENDHEX$$metro utilizado para fazer o controle dos produtos controlados.
//If Not ivo_parametro_filial.of_Localiza_Parametro("ID_CONTROLA_PSICO", Ref ivs_Controla_Psico) Then Return


ivs_Controla_Psico = 'S'

end event

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_fornecedor)
//Destroy(ivo_Parametro)
//Destroy(ivo_parametro_filial)
Destroy(ivo_Lista_Lotes)

end event

event ue_cancel;//Override

SetPointer(HourGlass!)

// Desabilita os menus de confirma e cancela
If Not IsNull(ivm_Menu) Then
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ivm_Menu.m_Editar.m_Desfazer.Enabled = False
End If

Tab_1.tabpage_2.dw_3.Event ue_Recuperar()

SetPointer(Arrow!)

end event

event ue_presave;call super::ue_presave;Long   ll_row         , &       
       ll_quantidade  , &
       ll_total_lotes , &
       ll_lote

String ls_Produto     , &
       ls_Lote        , &
       ls_tipo_nota    

Tab_1.tabpage_2.dw_3.AcceptText()

ls_tipo_nota  = Tab_1.tabpage_1.dw_1.Object.id_tipo_nota  [1]

For ll_row = 1 To Tab_1.tabpage_2.dw_3.RowCount()
	
	ll_quantidade = Tab_1.tabpage_2.dw_3.object.quantidade[ll_row]
	ls_lote       = Tab_1.tabpage_2.dw_3.object.nr_lote   [ll_row]
	ll_lote       = Tab_1.tabpage_2.dw_3.object.qt_lote   [ll_row]
	
	ll_total_lotes = Tab_1.tabpage_2.dw_3.GetItemNumber(ll_row,"qt_lote_produto")
	
	ls_Produto     = Tab_1.tabpage_2.dw_3.object.de_produto[ll_row]
		
	If ll_Quantidade <> ll_total_lotes Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + ls_Produto + " possui inconsist$$HEX1$$ea00$$ENDHEX$$ncias.",Exclamation!)
		Tab_1.tabpage_2.dw_3.Event ue_Pos(ll_Row, "qt_lote")
		Return False
	End If
	
	If IsNull(ls_Lote) or Trim(ls_Lote) = '' Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto " + ls_Produto + " possui inconsist$$HEX1$$ea00$$ENDHEX$$ncias.",Exclamation!)
		Tab_1.tabpage_2.dw_3.Event ue_Pos(ll_Row, "nr_lote")
		Return False
	End If
	
	If ll_lote = 0 Then
		Tab_1.tabpage_2.dw_3.DeleteRow(ll_row)
		ll_row --
		Continue
	End If	
	
	Choose Case ls_tipo_nota
			
		Case "T" 			
			If IsNull(Tab_1.tabpage_2.dw_3.object.cd_filial_origem[ll_row]) Then
				Tab_1.tabpage_2.dw_3.object.cd_filial_origem    [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_transferencia_cd_filial_origem[ll_row]
				Tab_1.tabpage_2.dw_3.object.nr_nf               [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_transferencia_nr_nf           [ll_row]
				Tab_1.tabpage_2.dw_3.object.de_especie          [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_transferencia_de_especie      [ll_row]
				Tab_1.tabpage_2.dw_3.object.de_serie            [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_transferencia_de_serie        [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_natureza_operacao[ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_transferencia_cd_natureza     [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_produto          [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_transferencia_cd_produto      [ll_row]		
			End If				

      Case "C" 			
			If IsNull(Tab_1.tabpage_2.dw_3.object.cd_filial    [ll_row]) Then
				Tab_1.tabpage_2.dw_3.object.cd_filial           [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_compra_cd_filial              [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_fornecedor       [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_compra_cd_fornecedor          [ll_row]
				Tab_1.tabpage_2.dw_3.object.nr_nf               [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_compra_nr_nf                  [ll_row]
				Tab_1.tabpage_2.dw_3.object.de_especie          [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_compra_de_especie             [ll_row]
				Tab_1.tabpage_2.dw_3.object.de_serie            [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_compra_de_serie               [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_natureza_operacao[ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_compra_cd_natureza            [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_produto          [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_compra_cd_produto             [ll_row]		
			End If					
	
      Case "DC" 		
			If IsNull(Tab_1.tabpage_2.dw_3.object.cd_filial    [ll_row]) Then
				Tab_1.tabpage_2.dw_3.object.cd_filial           [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_compra_cd_filial    [ll_row]
				Tab_1.tabpage_2.dw_3.object.nr_nf               [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_compra_nr_nf        [ll_row]
				Tab_1.tabpage_2.dw_3.object.de_especie          [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_compra_de_especie   [ll_row]
				Tab_1.tabpage_2.dw_3.object.de_serie            [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_compra_de_serie     [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_natureza_operacao[ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_compra_cd_natureza_operacao  [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_produto          [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_compra_cd_produto   [ll_row]		
			End If				
			
      Case "DV" 		
			If IsNull(Tab_1.tabpage_2.dw_3.object.cd_filial    [ll_row]) Then
				Tab_1.tabpage_2.dw_3.object.cd_filial           [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_venda_cd_filial    [ll_row]
				Tab_1.tabpage_2.dw_3.object.nr_nf               [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_venda_nr_nf        [ll_row]
				Tab_1.tabpage_2.dw_3.object.de_especie          [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_venda_de_especie   [ll_row]
				Tab_1.tabpage_2.dw_3.object.de_serie            [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_venda_de_serie     [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_natureza_operacao[ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_venda_cd_natureza_operacao  [ll_row]
				Tab_1.tabpage_2.dw_3.object.cd_produto          [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_venda_cd_produto   [ll_row]		
				Tab_1.tabpage_2.dw_3.object.id_origem_nf        [ll_row] = Tab_1.tabpage_2.dw_3.object.item_nf_devolucao_venda_id_origem_nf [ll_row]		
			End If									
			
	End Choose		
				
Next

If Not wf_Atualiza_Data_Exportacao(ls_tipo_nota) Then	Return False

Long ll_Fil
Long ll_mod
Long ll_del

ll_row = tab_1.tabpage_2.dw_3.RowCount()
ll_fil = tab_1.tabpage_2.dw_3.FilteredCount()
ll_mod = tab_1.tabpage_2.dw_3.ModifiedCount()
ll_del = tab_1.tabpage_2.dw_3.DeletedCount()

ll_del = ll_del

Return True
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then

//	String ls_Tipo_Nota
//
//	ls_Tipo_Nota = Tab_1.tabpage_1.dw_1.Object.id_tipo_nota[1]
//	
//	If ls_Tipo_Nota = "T" Then
//		LF_GE096_Transferencia_Online()
//	End If	
	
End If	

Return AncestorReturnValue 
end event

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge230_item_nf_lote
integer y = 0
integer width = 2862
integer height = 1732
string facename = "Verdana"
end type

event tab_1::selectionchanged;//Override

end event

event tab_1::selectionchanging;// OverRide

Boolean lvb_Bloqueia

Date lvdh_Parametro,&
	 lvdh_Emissao,&
	 lvdh_Movimentacao_Caixa

String lvs_Registro_Lote, &
       lvs_tipo_nota, &
	   lvs_MsgExpirou = "A data para altera$$HEX2$$e700e300$$ENDHEX$$o dos lotes j$$HEX1$$e100$$ENDHEX$$ expirou."

SetPointer(HourGlass!)

If NewIndex = 2 Then
     lvs_tipo_nota   = Tab_1.TabPage_1.dw_1.Object.id_tipo_nota[1]
End If

Choose Case NewIndex
	Case 1
		If wf_Valida_Salva() > 0 Then
			If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then Tab_1.TabPage_1.dw_2.Event ue_Retrieve()					                                  			
			Return 0
		Else
			Return 1
		End If		
		
	Case 2					
		If Not Parent.ivb_Inclusao Then
			
		ivl_Linha_Selecionada = Tab_1.TabPage_1.dw_2.GetRow()
			
		If ivl_Linha_Selecionada > 0 Then
			
			lvdh_Movimentacao_Caixa = Date(gvo_Parametro.of_Dh_Movimentacao())
			
			Tab_1.TabPage_1.dw_2.AcceptText()
			
		    lvs_Registro_Lote = Tab_1.TabPage_1.dw_2.Object.id_liberado                [ivl_Linha_Selecionada]
			lvdh_Emissao 	   = Date(Tab_1.TabPage_1.dw_2.Object.dh_movimentacao_caixa[ivl_Linha_Selecionada])
			
			// 4 dias 
			lvdh_Parametro    = RelativeDate(lvdh_Movimentacao_Caixa, -3)
									
			If lvs_Registro_Lote = "S" Then
			
				If ivs_Controla_Psico = "S" Then
					lvb_Bloqueia = True // Bloqueia
					ivi_Protect  = 1    // Protege
				Else
					lvb_Bloqueia = False // Desbloqueia
					ivi_Protect  = 0 	 // Desprotege
				End If
				
				// Compra ou Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compra
				If lvs_Tipo_Nota = "C" or lvs_Tipo_Nota = "DC" Then
					If lvb_Bloqueia Then
						If lvdh_Emissao >= lvdh_Parametro Then
							lvb_Bloqueia = False
							ivi_Protect  = 0 // Desprotege
						End If
					End If
				Else
					If lvdh_Emissao = lvdh_Movimentacao_Caixa Then
						If lvb_Bloqueia Then
							lvb_Bloqueia = False
							ivi_Protect  = 0 // Desprotege
						End If
					End If
				End If
				
				/****** Gambiarra - 10/04/2008 ******/
				IF lvb_Bloqueia Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_MsgExpirou, Exclamation!)
				Else
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os lotes desta nota j$$HEX1$$e100$$ENDHEX$$ foram informados.~r~r" +&
								  "Deseja alterar ?", Question!, YesNo!, 2) = 2 Then
						// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder						
						Return 1
					End If
				End If
			Else
				ivi_Protect  = 0 
			End If
			
			If  lvs_Tipo_Nota = "DC"  Then
				If Not IsNull(Tab_1.TabPage_1.dw_2.Object.id_situacao_nfe[ivl_Linha_Selecionada]) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nota j$$HEX1$$e100$$ENDHEX$$ foi enviada ao SEFAZ.", Exclamation!)
					ivi_Protect  = 1    // Protege
					// Permite a troca do folder
					//Return 0
				End IF
			End If
			
			// Verificar a possibilidade e alterar os lotes
			If lvs_Tipo_Nota = "C" Then
				ivi_Protect  = 1    // Protege
			End If
							
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW's de detalhes
			Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
			
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
	End If
End Choose

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer y = 104
integer width = 2825
integer height = 1612
cb_imprimir cb_imprimir
end type

on tabpage_1.create
this.cb_imprimir=create cb_imprimir
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_imprimir)
end on

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer x = 9
integer y = 460
integer width = 2802
integer height = 1144
integer weight = 700
string facename = "Verdana"
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
integer x = 9
integer width = 2057
integer height = 432
integer weight = 700
string facename = "Verdana"
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
integer x = 37
integer y = 64
integer width = 2007
integer height = 364
string dataobject = "dw_ge230_selecao_nf_transferencia"
end type

event dw_1::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;String lvs_Coluna, &
       lvs_Tipo_NF

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna 
			
		Case "de_filial"
			
			WF_Localiza_Filial()

		Case "nm_razao_social"
			
			WF_Localiza_Fornecedor()
			
	End Choose
	
End If

end event

event dw_1::itemchanged;call super::itemchanged;If This.GetColumnName() = "id_tipo_nota" Then	
	If Data = "C" Then // Compra
		This.Object.de_filial.Protect       = 1
		This.Object.nm_razao_social.Protect = 0
		This.Object.nr_pedido.Protect       = 0
	Else
		If Data = "DV" Then // Devolu$$HEX2$$e700e300$$ENDHEX$$o de Venda
			This.Object.de_filial.Protect 		  = 1
			This.Object.nm_razao_social.Protect   = 1
			This.Object.nr_pedido.Protect         = 1
		Else
			This.Object.de_filial.Protect 		  = 0
			This.Object.nm_razao_social.Protect   = 1
			This.Object.nr_pedido.Protect         = 1
		End If
	End If  
End If

If This.GetColumnName() = "nm_razao_social" Then

	If Not IsNull(Data) and Trim(Data) <> "" Then
	   If Trim(Data) <> ivo_Fornecedor.nm_razao_social Then
		   Return 1
	   End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.cd_fornecedor  [1] = ivo_Fornecedor.cd_fornecedor
		This.Object.nm_razao_social[1] = ivo_Fornecedor.nm_razao_social
	End If

End If


dw_2.Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.nm_razao_social[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer x = 46
integer y = 512
integer width = 2747
integer height = 1064
string dataobject = "dw_ge230_lista_nf_transferencia"
end type

event dw_2::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event dw_2::ue_recuperar;// Override
String lvs_Especie, &
		 lvs_Serie, &
		 lvs_Situacao,&
		 lvs_Urgente,&
		 lvs_Tipo_NF,&
		 lvs_fornecedor,&
		 lvs_DW
			
Long   lvl_Filial, &
       lvl_NF, &
		 lvl_nr_pedido

Date   lvdh_Inicio, &
       lvdh_Termino	
		
// Verifica quais os par$$HEX1$$e200$$ENDHEX$$metros informados
dw_1.AcceptText()

lvl_Filial          = dw_1.Object.Cd_Filial     [1]
lvl_NF              = dw_1.Object.Nr_NF	      [1]
lvs_Especie         = dw_1.Object.De_Especie    [1]
lvs_Serie           = dw_1.Object.De_Serie      [1]
lvdh_Inicio         = dw_1.Object.Dt_Inicio     [1]
lvdh_Termino        = dw_1.Object.Dt_Termino    [1]
lvs_Tipo_NF		     = dw_1.Object.id_tipo_nota  [1]
lvs_fornecedor      = dw_1.Object.cd_fornecedor [1]
lvl_nr_pedido       = dw_1.Object.nr_pedido     [1]

Choose Case lvs_Tipo_NF
	Case "T"
		lvs_DW = "dw_ge230_lista_nf_transferencia"
	Case "C"
		lvs_DW = "dw_ge230_lista_nf_compra"
	Case "DC"
		lvs_DW = "dw_ge230_lista_nf_devolucao_compra"
	Case "DV"
		lvs_DW = "dw_ge230_lista_nf_devolucao_venda"
End Choose

If Not dw_2.of_ChangeDataObject(lvs_DW) Then
	Return -1
End If

If lvs_Tipo_NF = "T" Then
	If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
		This.of_AppendWhere("n.cd_filial_destino = " + String(lvl_Filial))   
	End If
End If

If Not IsNull(lvl_NF) and lvl_NF > 0 Then
	This.of_AppendWhere("n.nr_nf = " + String(lvl_NF) )
End If

If Not IsNull(lvs_Especie) and lvs_Especie <> "" Then
	This.of_AppendWhere("n.de_especie = '" + lvs_Especie + "'" )
End If

If Not IsNull(lvs_Serie) and lvs_Serie <> "" Then
	This.of_AppendWhere("n.de_serie = '" + lvs_Serie + "'" )
End If

If lvs_Tipo_NF = "C" OR lvs_Tipo_NF = "DC" Then 
     If Not IsNull(lvs_fornecedor) and lvs_Fornecedor <> "" Then
	     This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'" )
     End If
End If	  

If lvs_Tipo_NF = "C" Then 
     If Not IsNull(lvl_nr_pedido) and lvl_nr_pedido > 0 Then
	     This.of_AppendWhere("n.nr_pedido_distribuidora = " + String(lvl_nr_pedido))
     End If
End If	  
  
Return dw_2.Retrieve(lvdh_Inicio, lvdh_Termino)

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;//This.of_SetRowSelection("", "if( not isnull( dh_cancelamento ), RGB(255,0, 0), RGB(0,0,0) )")

Long   lvl_Linha,&
	    lvl_Nota,&
	    lvl_Filial

String lvs_Liberado,&
	   lvs_Tipo_Nota,&
	   lvs_Especie,&
	   lvs_Serie,&
	   lvs_Origem_NF,&
	   lvs_Fornecedor
	   
Tab_1.TabPage_1.dw_1.AcceptText()
	   
lvs_Tipo_Nota = Tab_1.TabPage_1.dw_1.Object.id_tipo_nota[1]

This.of_SetRowSelection()

If pl_Linhas > 0 Then
	
	For lvl_Linha = 1 To pl_Linhas 
		
		If lvs_Tipo_Nota = "T" Then
			lvl_Filial   = Tab_1.TabPage_1.dw_2.Object.cd_filial_origem[lvl_Linha]
		Else
			lvl_Filial   = Tab_1.TabPage_1.dw_2.Object.cd_filial       [lvl_Linha]
		End If
		
		lvl_Nota     = Tab_1.TabPage_1.dw_2.Object.nr_nf		   [lvl_Linha]
		lvs_Especie  = Tab_1.TabPage_1.dw_2.Object.de_especie      [lvl_Linha]
		lvs_Serie    = Tab_1.TabPage_1.dw_2.Object.de_serie        [lvl_Linha]		
				
		Choose Case lvs_Tipo_Nota
				
			Case "T"
				lvs_Liberado = wf_Verifica_Liberacao_Transferencia(lvl_Filial,lvl_Nota,lvs_Especie,lvs_Serie)
				dw_2.Object.id_liberado[lvl_Linha] = lvs_Liberado
			
			Case "C"
				lvs_Fornecedor = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[lvl_Linha]		
				lvs_Liberado = wf_Verifica_Liberacao_Compra(lvl_Filial,lvs_Fornecedor,lvl_Nota,lvs_Especie,lvs_Serie)
				dw_2.Object.id_liberado[lvl_Linha] = lvs_Liberado
				
			Case "DC"
				lvs_Liberado = wf_Verifica_Liberacao_Devolucao_Compra(lvl_Filial,lvl_Nota,lvs_Especie,lvs_Serie)
				dw_2.Object.id_liberado[lvl_Linha] = lvs_Liberado
				
			Case "DV"
				lvs_Origem_NF = Tab_1.TabPage_1.dw_2.Object.id_origem_nf[lvl_Linha]
				lvs_Liberado  = wf_Verifica_Liberacao_Devolucao_Venda(lvl_Filial,lvl_Nota,lvs_Especie,lvs_Serie,lvs_Origem_NF)
				dw_2.Object.id_liberado[lvl_Linha] = lvs_Liberado

		End Choose
	Next
End If

If ivl_Linha_Selecionada > 0 Then
	This.SetRow(ivl_Linha_Selecionada)
	This.Event RowFocusChanged(ivl_Linha_Selecionada)
	This.SetFocus()
End If

Return pl_Linhas
end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer y = 104
integer width = 2825
integer height = 1612
end type

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer x = 9
integer width = 2798
integer height = 1592
string facename = "Verdana"
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer x = 46
integer y = 60
integer width = 2743
integer height = 1508
string dataobject = "dw_ge230_detalhes"
boolean vscrollbar = true
end type

event dw_3::constructor;call super::constructor;//This.of_SetColSelection(True)


end event

event dw_3::ue_key;Choose Case key
	Case KeyEnter!
		wf_controle_lote_produto()
End Choose
end event

event dw_3::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nr_lote"
		If IsNull(data) or Trim(data) = '' Then
			Return 1
		End If
	Case 	"qt_lote"
		If Long(data) = 0 Then
			Return 1
		End If	
		// Return wf_valida_quantidade_lote(data)	
End Choose		
end event

event dw_3::ue_recuperar;//Override

Long ll_linha
Long ll_filial
Long ll_nota

String ls_especie
String ls_serie
String ls_tipo_nota
String ls_DW
String ls_fornecedor
String ls_id_origem_nf

Tab_1.tabpage_1.dw_1.AcceptText()

ls_tipo_nota     = Tab_1.tabpage_1.dw_1.Object.id_tipo_nota  [1]

ll_linha = Tab_1.tabpage_1.dw_2.GetRow()

Choose Case ls_tipo_nota
	Case "T"
		ls_DW = "dw_ge230_detalhes"
	Case "C"
		ls_DW = "dw_ge230_detalhes_compra"
		//If Tab_1.tabpage_1.dw_2.object.De_Tipo_Mvto[ ll_linha ] = 'TRANSF' Then
		//	ls_DW = "dw_ge230_detalhes_transferencia_entrada"
		//End If
		
	Case "DC"
		ls_DW = "dw_ge230_detalhes_devolucao_compra"
    Case "DV"
		ls_DW = "dw_ge230_detalhes_devolucao_venda"
End Choose

If Not dw_3.of_ChangeDataObject(ls_DW) Then
	Return -1
End If

If ll_linha > 0 Then
	
	If ls_Tipo_Nota   = "DV" Then
	   ls_id_origem_nf = Tab_1.tabpage_1.dw_2.object.id_origem_nf    [ll_linha]			
	End If
	   
	If ls_Tipo_Nota   = "C" Then
		ls_fornecedor  = Tab_1.tabpage_1.dw_2.object.cd_fornecedor   [ll_linha]
	End If
	
	If ls_Tipo_Nota = "T" Then
	   ll_filial = Tab_1.tabpage_1.dw_2.object.cd_filial_origem[ll_linha]
	Else
		ll_filial = Tab_1.tabpage_1.dw_2.object.cd_filial[ll_linha]
	End If
	
    ll_nota		= Tab_1.tabpage_1.dw_2.object.nr_nf			[ll_linha]
    ls_especie	= Tab_1.tabpage_1.dw_2.object.de_especie	[ll_linha]
    ls_serie		= Tab_1.tabpage_1.dw_2.object.de_serie		[ll_linha]  
			  
	If ls_tipo_nota = "C" Then
		If Tab_1.tabpage_1.dw_2.object.De_Tipo_Mvto[ ll_linha ] = 'TRANSF' Then
			This.Retrieve(ll_filial, ll_nota, ls_especie, ls_serie) 
		Else
			This.Retrieve(ll_filial, ls_fornecedor, ll_nota, ls_especie, ls_serie) 
		End If
	ElseIf  ls_tipo_nota = "DV" Then 
		   This.Retrieve(ll_filial, ll_nota, ls_especie, ls_serie, ls_id_origem_nf) 			
		Else 
		   // "T", "DC"
		   This.Retrieve(ll_filial, ll_nota, ls_especie, ls_serie)
		End If	  
End If 

Return This.RowCount()
end event

event dw_3::ue_predeleterow;// OverRide
Long lvl_Linha,&
	 lvl_Produto_Atual,&
	 lvl_Produto_Anterior
	 
If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma exclus$$HEX1$$e300$$ENDHEX$$o do registro ?", Question!, YesNo!, 2) = 2 Then
	Return False
Else
	
	If Tab_1.TabPage_2.dw_3.RowCount() = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a exclus$$HEX1$$e300$$ENDHEX$$o deste registro.")
		Return False
	Else
		If This.Getrow() = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a exclus$$HEX1$$e300$$ENDHEX$$o deste registro.")
			Return False
		Else
			lvl_Produto_Atual    = Tab_1.TabPage_2.dw_3.Object.cd_produto[This.Getrow()]
			lvl_Produto_Anterior = Tab_1.TabPage_2.dw_3.Object.cd_produto[This.Getrow() - 1]
			
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

event dw_3::ue_postretrieve;call super::ue_postretrieve;String lvs_Tipo_NF

Long lvl_Linha

lvs_Tipo_NF = Tab_1.TabPage_1.dw_1.Object.id_tipo_nota[1]

If pl_Linhas > 0 Then
	
	If lvs_Tipo_NF <> "C" Then
		This.Object.nr_lote.protect = ivi_Protect
		This.Object.qt_lote.protect = ivi_Protect
		
		If ivi_Protect = 1 Then
			This.ivo_Controle_Menu.of_Excluir(False)
		End If
		
	End If
	
	If lvs_Tipo_NF = "C" Then
		
		If ivi_Protect = 1 Then
			
			For lvl_Linha = 1 To pl_Linhas
				Tab_1.TabPage_2.dw_3.Object.Protege[lvl_Linha] = 'P'
			Next
		End If
		
		wf_Verifica_Saldo_Para_Alteracao()
		
	End If
	
End If

Return pl_Linhas
end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;Long lvl_Produto, &
	  lvl_Nota

String lvs_Tipo_NF

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()

lvs_Tipo_NF = Tab_1.TabPage_1.dw_1.Object.id_tipo_nota[1]
lvl_Nota    = Tab_1.TabPage_1.dw_2.Object.Nr_Nf[ivl_linha_selecionada]

If This.GetRow() > 0 Then
	lvl_Produto = This.Object.cd_produto[This.GetRow()]
End If

Choose Case lvs_Tipo_NF
	Case "T"
		ivo_Lista_Lotes.of_Preenche_Lista_Matriz(This, 534, lvl_Produto)
	
	Case "DC"
		// 12/03/2013 - Sergio
		// no futuro utilizar a of_preenche_lista onde $$HEX1$$e900$$ENDHEX$$ passado a nota de compra de origem 
		// neste caso o sistema s$$HEX1$$f300$$ENDHEX$$ vai listar os lotes da nf de compra
		
		//ivo_Lista_Lotes.of_Preenche_Lista(This, lvl_Nota, lvl_Produto)
		
		ivo_Lista_Lotes.of_Preenche_Lista_Matriz(This, 534, lvl_Produto)
		
		
	Case "C"
		String lvs_Protege
		
		If This.GetRow() > 0 Then
			
			lvs_Protege = This.Object.protege[This.GetRow()]
			
			If lvs_Protege = "P" Then
				This.ivo_Controle_Menu.of_Excluir(False)
			Else
				This.ivo_Controle_Menu.of_Excluir(True)
			End If
			
		End If
		
End Choose

end event

event dw_3::ue_preupdate;call super::ue_preupdate;Integer lvi_Retorno = 1

Long lvl_Linha,&
	 lvl_Filial,&
	 lvl_Nota
	 
String lvs_Tipo_NF,&
	   lvs_Especie,&
	   lvs_Serie

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

lvs_Tipo_NF   = Tab_1.TabPage_1.dw_1.Object.id_tipo_nota    [1]

lvl_Linha     = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Nota    = Tab_1.TabPage_1.dw_2.Object.nr_nf		 [lvl_Linha]
lvs_Especie	= Tab_1.TabPage_1.dw_2.Object.de_especie[lvl_Linha]
lvs_Serie	= Tab_1.TabPage_1.dw_2.Object.de_serie  [lvl_Linha]
		
// Nota de Transfer$$HEX1$$ea00$$ENDHEX$$ncia
Choose Case lvs_Tipo_NF
	Case "T"
		lvl_Filial  = Tab_1.TabPage_1.dw_2.Object.cd_filial_origem[lvl_Linha]
		lvi_Retorno = wf_Valida_Lote_Informado(lvl_Filial, lvl_Nota, lvs_Especie, lvs_Serie)
	Case "DC"
		lvl_Filial  = Tab_1.TabPage_1.dw_2.Object.cd_filial[lvl_Linha]
		lvi_Retorno = wf_Valida_Lote_Informado_Dev_Compra(lvl_Filial, lvl_Nota, lvs_Especie, lvs_Serie)		
		
	Case "C"
		For lvl_Linha = 1 To This.RowCount()
			This.Object.Nr_Lote[lvl_Linha] = Trim(This.Object.Nr_Lote[lvl_Linha])
		Next
		
End Choose

Return lvi_Retorno
end event

type cb_imprimir from commandbutton within tabpage_1
boolean visible = false
integer x = 2537
integer y = 8
integer width = 283
integer height = 124
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Emitir NF."
end type

event clicked;Long ll_row
	 
String lvs_parametro
  
UO_NOTA_FISCAL luo_nf

luo_nf = Create UO_NOTA_FISCAL

ll_row = Tab_1.tabpage_1.dw_2.GetRow()

If ll_row = 0 Then Return

//If Not ISNULL(Tab_1.TabPage_1.dw_2.object.dh_cancelamento [ll_row]) THEN
//	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota Fiscal Cancelada. N$$HEX1$$e300$$ENDHEX$$o pode ser Listada.", StopSign!)
//	return  
//End If

If Tab_1.TabPage_1.dw_2.object.id_registro_lote[ll_row] = "S" Then 
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nota Fiscal n$$HEX1$$e300$$ENDHEX$$o Liberada para Impress$$HEX1$$e300$$ENDHEX$$o. Verifique as Pend$$HEX1$$ea00$$ENDHEX$$ncias.")	
	return
End If

luo_nf.Emitir_Nf_Transferencia(Tab_1.TabPage_1.dw_2.Object.Cd_Filial_Origem[ll_row], &
										 Tab_1.TabPage_1.dw_2.Object.Nr_NF	         [ll_row], &
										 Tab_1.TabPage_1.dw_2.Object.De_Especie		[ll_row], &
										 Tab_1.TabPage_1.dw_2.Object.De_Serie	   	[ll_row])
			
Destroy(luo_nf)

lvs_parametro = String(Tab_1.TabPage_1.dw_2.Object.Cd_Filial_Origem[ll_row],"0000") + &
					 String(Tab_1.TabPage_1.dw_2.Object.Nr_NF[ll_row])
					 
//OpenWithParm(w_rl004_emissao_etiqueta_transferencia, lvs_parametro)




end event

