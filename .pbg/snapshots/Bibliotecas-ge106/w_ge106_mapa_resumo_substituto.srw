HA$PBExportHeader$w_ge106_mapa_resumo_substituto.srw
forward
global type w_ge106_mapa_resumo_substituto from dc_w_selecao_lista_detalhe
end type
type dw_4 from dc_uo_dw_base within w_ge106_mapa_resumo_substituto
end type
type cb_1 from commandbutton within w_ge106_mapa_resumo_substituto
end type
end forward

global type w_ge106_mapa_resumo_substituto from dc_w_selecao_lista_detalhe
integer x = 1248
integer y = 804
integer width = 1938
integer height = 1712
string title = "GE106 - Mapa Resumo Substituto"
long backcolor = 80269524
dw_4 dw_4
cb_1 cb_1
end type
global w_ge106_mapa_resumo_substituto w_ge106_mapa_resumo_substituto

type variables
uo_filial       ivo_filial

Boolean ivb_Matriz = True

dc_uo_ds_base ivds_dev

String ivs_Rede
String id_gera_blocoX

dc_uo_transacao rubi

Date dt_inicio_blocox
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public function boolean wf_grava_aliquota ()
public function boolean of_grava_historico_blocox ()
end prototypes

public subroutine wf_localiza_filial ();//
STRING ls_filial	, &
		 lvs_nulo
//
Long   lvl_nulo
//
ls_filial = dw_1.GetText()
//
ivo_filial.Of_Localiza_Filial(ls_filial)
//
If ivo_filial.Localizada Then
	//
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	//
Else
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.cd_filial[1] = lvl_nulo
	dw_1.Object.de_filial[1] = lvs_nulo
	//
	ivo_filial.cd_filial	    = lvl_nulo
	ivo_filial.nm_fantasia   = lvs_nulo	
	//
End If
//
end subroutine

public function boolean wf_grava_aliquota ();long 		ll_filial,&
  			ll_ecf,&
     		ll_mapa,&
			ll_row
			
Decimal{2} ldc_pc_aliq,&
			  ldc_vl_base,&
			  ldc_vl_icms			

ll_filial	= dw_1.object.cd_filial	[1]
ll_mapa	= dw_1.object.nr_mapa	[1]
ll_ecf		= dw_1.object.nr_ecf		[1]

Delete From aliquota_mapa_resumo_ecf
Where cd_filial		= :ll_filial
  and nr_mapa		= :ll_mapa
  and de_especie	= 'MR'
  and de_serie		= '1'
  and nr_ecf			= :ll_ecf
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.Of_MsgDbError('Exclus$$HEX1$$e300$$ENDHEX$$o das Aliquotas do Mapa Resumo.')
	Return False
End If

For ll_Row = 1 To dw_3.RowCount()
	
	ldc_pc_aliq = dw_3.object.pc_icms		[ll_row]
	ldc_vl_base = dw_3.object.vl_base_icms	[ll_row]
	ldc_vl_icms = dw_3.object.vl_icms		[ll_row]
	
	If ldc_pc_aliq = 000.00 Then Continue
	
	Insert Into aliquota_mapa_resumo_ecf
				(cd_filial,
				 nr_mapa,
				 de_especie,
				 de_serie,
				 nr_ecf,
				 pc_aliquota,
				 vl_base_calculo,
				 vl_icms)
	Values (:ll_filial,
			  :ll_mapa,
			  'MR',
			  '1',
			  :ll_ecf,
			  :ldc_pc_aliq,
			  :ldc_vl_base,
			  :ldc_vl_icms);
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_RollBack()
		Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o das Aliquotas de ICMS Mapa Resumo.")
		Return False
	End If
	
Next

Return True
end function

public function boolean of_grava_historico_blocox ();Return True
end function

on w_ge106_mapa_resumo_substituto.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_1
end on

on w_ge106_mapa_resumo_substituto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;Long lvl_Filial, &
	  lvl_Filial_Matriz

String lvs_gerar_blocox, lvs_data_blocox

ivo_Filial  = Create uo_Filial

lvl_Filial 				= gvo_Parametro.of_Filial()
lvl_Filial_Matriz 	= gvo_Parametro.of_Filial_Matriz()

If lvl_Filial <> lvl_Filial_Matriz Then
	ivb_Matriz = False
End If

If ivb_Matriz Then	
	Select vl_parametro
	Into :lvs_gerar_blocox
	From parametro_loja
	Where cd_filial = :lvl_Filial
	And cd_parametro = 'ID_GERA_ARQUIVO_BLOCOX'
	Using SQLCa;
	
	This.id_gera_blocoX = lvs_gerar_blocox
	
	Select vl_parametro
	Into :lvs_data_blocox
	From parametro_loja
	Where cd_filial = :lvl_Filial
	And cd_parametro = 'DT_INICIO_BLOCOX'
	Using SQLCa;
	
	If IsDate(lvs_data_blocox) Then
		This.dt_inicio_blocox = Date(lvs_data_blocox)
	Else
		IsNull(This.dt_inicio_blocox)
	End If	
Else
	uo_Parametro_Filial lvo_Parametro
	lvo_Parametro = Create uo_Parametro_Filial

	lvo_Parametro.of_Localiza_Parametro("ID_GERA_ARQUIVO_BLOCOX", ref This.id_gera_blocoX, False)	
	lvo_Parametro.of_Localiza_Parametro("DT_INICIO_BLOCOX", ref lvs_data_blocox, False)
	If IsDate(lvs_data_blocox) Then
		This.dt_inicio_blocox = Date(lvs_data_blocox)
	Else
		IsNull(This.dt_inicio_blocox)
	End If		
	
	Destroy(lvo_Parametro)
End if

This.ivm_Menu.ivb_Permite_Imprimir = True

ivm_Menu.mf_Recuperar(True)
ivm_Menu.ivb_Permite_Imprimir = True

If Not ivb_Matriz Then
	dw_1.Object.dt_periodo[1]     	= Today()
	dw_1.Object.Cd_Filial[1]      	= gvo_Parametro.of_Filial()
	dw_1.Object.De_Filial[1]      	= gvo_Parametro.Nm_Fantasia_Filial
	dw_1.Object.Cd_Filial.Protect 	= 1
	dw_1.Object.De_Filial.Protect 	= 1
Else
	If ivb_Matriz Then
		dw_1.Object.dt_periodo[1]  = gvo_parametro.Of_dh_Movimentacao()
	End If
End If





	  

end event

event close;call super::close;If IsValid(ivo_filial) Then DESTROY(ivo_filial)
end event

event ue_print;This.Event ue_PrintImmediate()
end event

event ue_printimmediate;Open(w_ge033_prepara_impressora)
dw_4.Event ue_PrintImmediate()
end event

event ue_saveas;dw_4.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge106_mapa_resumo_substituto
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge106_mapa_resumo_substituto
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge106_mapa_resumo_substituto
integer x = 1029
integer y = 340
integer width = 827
integer height = 1032
string text = "Al$$HEX1$$ed00$$ENDHEX$$quotas de ICMS"
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge106_mapa_resumo_substituto
integer x = 32
integer width = 1824
integer height = 296
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge106_mapa_resumo_substituto
integer x = 32
integer y = 340
integer width = 937
integer height = 1028
string text = "Mapa Resumo"
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge106_mapa_resumo_substituto
integer x = 59
integer y = 88
integer width = 1765
integer height = 192
string dataobject = "dw_ge106_selecao"
end type

event dw_1::editchanged;//Override

If dwo.name <> 'nr_mapa' Then
	dw_2.Event ue_Reset()
	dw_3.Event ue_Reset()
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

dw_1.AcceptText()

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
		
	If lvs_Coluna = "de_filial" Then
			ivo_filial.of_localiza_filial(dw_1.GetText())
			dw_1.object.cd_filial[1] = ivo_Filial.cd_filial
			dw_1.object.de_filial[1] = ivo_filial.nm_fantasia
		
	End If
End If
	
			


	
	


		

end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_filial" Then
	If Data <> ivo_Filial.Nm_Fantasia Then Return 1
End If


end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge106_mapa_resumo_substituto
integer x = 73
integer y = 420
integer width = 850
integer height = 928
integer taborder = 0
string dataobject = "dw_ge106_mapa_resumo"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_2::ue_recuperar;//OVERRIDE

DateTime ldt_Movimento
Date     ldt_Periodo

long 		ll_ecf,&
     		ll_mapa,&
     		ll_retorno,&
	 		ll_coo_inicial,&
     		ll_coo_final,&
     		ll_reducao_z,&
			ll_filial,&
			lvl_filial,&
			ll_qt_reinicio_z,&
			ll_qt_reinicio_z_gravado,&
			ll_reducao_z_gravado,&
			ll_coo_final_gravado		
			  	 
Decimal 	ldc_gt_inicial,&
			ldc_venda_bruta,&
			ldc_venda_liquida,&
			ldc_cancelamento,&
			ldc_gt_final,&
			ldc_gt_final_gravado
		
String		ls_situacao_ecf, &
			ls_uf,&
			ls_substituto
			
DateTime ldh_emissao,&
			 ldh_reducao,&
			 ldh_reducao_gravado
			 
dw_1.AcceptText()	

ldt_periodo	= dw_1.Object.dt_periodo	[1]
ll_ecf			= dw_1.Object.nr_ecf			[1]
lvl_filial		= dw_1.Object.cd_filial		[1]
ll_filial		= gvo_parametro.cd_filial

If IsNull(ll_ecf) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o numero ECF.", Information!)
	dw_1.Event ue_Pos(1, "dt_periodo")
	Return 0
End If

If IsNull(ldt_periodo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o per$$HEX1$$ed00$$ENDHEX$$odo.", Information!)
	dw_1.Event ue_Pos(1, "dt_periodo")
	Return 0
End If

//Verifica se a ECF selecionada est$$HEX1$$e100$$ENDHEX$$ com status (L)iberada para uso

// Filial
If Not ivb_matriz then
	Select id_situacao Into :ls_situacao_ecf
	From impressora_fiscal
	Where nr_ecf = :ll_ecf
	Using Sqlca;
Else	
	// Matriz
	ll_Filial = lvl_filial
	Select id_situacao Into :ls_situacao_ecf
	From impressora_fiscal
	Where nr_ecf  	= :ll_ecf
	  and cd_filial = :lvl_filial
	Using Sqlca;
	ll_Filial = lvl_filial
End If

If Sqlca.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar cadastro da ECF.", Information!)
	Return 0
End If
If IsNull(ls_situacao_ecf) or ls_situacao_ecf <> "L" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "ECF " + String(ll_ecf) + " n$$HEX1$$e300$$ENDHEX$$o liberada para uso na filial.", Information!)
	Return 0
End If


//Select nr_mapa,
//       dh_movimentacao_caixa
// Into :ll_mapa,
//      :ldt_movimento
//from mapa_resumo
//where cd_filial  = :gvo_parametro.cd_filial
//  and nr_mapa    = ( select Max(mr.nr_mapa)
//                       from mapa_resumo mr,
//					        mapa_resumo_ecf mre
//					  where mr.cd_filial  = mre.cd_filial
//					    and mr.nr_mapa    = mre.nr_mapa
//						and mr.de_especie = mre.de_especie
//						and mr.de_serie   = mre.de_serie
//					    and mr.cd_filial  = :gvo_parametro.cd_filial
//						and mr.dh_emissao < :ldt_periodo
//						and mre.nr_ecf    = :ll_ecf )
//Using Sqlca;

Select nr_mapa
 Into :ll_mapa
from mapa_resumo
where cd_filial  = :ll_filial
  and dh_emissao = :ldt_periodo
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar n$$HEX1$$fa00$$ENDHEX$$mero do mapa resumo ECF.", Information!)
	Return 0
End If

If Sqlca.Sqlcode = 100 Then
	
	Select Max(nr_mapa)
	 Into :ll_mapa
	from mapa_resumo
	where cd_filial  = :ll_filial
	Using Sqlca;
	
	If Sqlca.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar n$$HEX1$$fa00$$ENDHEX$$mero do mapa resumo ECF.", Information!)
		Return 0
	End If
	
	ll_mapa ++
	
	Select nr_operacao_final,
	    vl_total_geral_final,
	    qt_reducao_z,
		 nr_operacao_final,
		 qt_reinicio_z
  Into :ll_coo_inicial,
	 	 :ldc_gt_inicial,
	 	 :ll_reducao_z,
		 :ll_coo_inicial,
		 :ll_qt_reinicio_Z
	From mapa_resumo_ecf m
	Where m.cd_filial = :ll_filial
	  and m.nr_ecf    = :ll_ecf
	  and m.nr_mapa   = ( Select max(nr_mapa)
									From mapa_resumo
								  Where cd_filial  = :ll_filial
									 and dh_emissao < :ldt_periodo )								
	Using Sqlca;
	
	If Sqlca.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar totalizadores do mapa resumo : " + String(ll_mapa), Information!)
		Return 0
	End If	
		
Else
	
	Select nr_operacao_final,
	    vl_total_geral_final,
	    qt_reducao_z,
		 nr_operacao_final,
		 qt_reinicio_z
  Into :ll_coo_inicial,
	 	 :ldc_gt_inicial,
	 	 :ll_reducao_z,
		 :ll_coo_inicial,
		 :ll_qt_reinicio_z
	From mapa_resumo_ecf m
	Where m.cd_filial = :ll_filial
	  and m.nr_ecf    = :ll_ecf
	  and m.nr_mapa   = ( Select max(nr_mapa)
									From mapa_resumo_ecf
								  Where cd_filial = :ll_filial
									 and nr_ecf    = :ll_ecf
									 and nr_mapa   < :ll_mapa )								
	Using Sqlca;
	
	If Sqlca.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar totalizadores do mapa resumo: " + String(ll_mapa), Information!)
		Return 0
	End If
	
End If	

dw_1.object.nr_mapa[1] = ll_mapa
//Filial
If Not ivb_matriz then
	Select max(nr_operacao_ecf)
	Into :ll_coo_final
	From nf_venda
	Where cd_filial				= :ll_Filial
	 and dh_movimentacao_caixa = :ldt_periodo
	 and nr_ecf 				= :ll_ecf
	 and de_especie		= 'CF'
	Using Sqlca;
Else //Matriz
	Select max(nr_coo_ecf)
	Into :ll_coo_final
	From nf_venda
	Where cd_filial				= :ll_Filial
	 and dh_movimentacao_caixa = :ldt_periodo
	 and nr_ecf 				= :ll_ecf
	 and de_especie		= 'CF'
	Using Sqlca;
End If

If Sqlca.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar COO final: " + String(ll_mapa), Information!)
	Return 0
End If

//Data hora emissao ultima venda
If Not ivb_matriz then
	Select dh_emissao
	Into :ldh_emissao
	From nf_venda
	Where cd_filial				= :ll_Filial
	 and dh_movimentacao_caixa = :ldt_periodo
	 and nr_ecf 				= :ll_ecf
	 and de_especie		= 'CF'
	 and nr_operacao_ecf = :ll_coo_final
	Using Sqlca;
Else //Matriz
	Select dh_emissao
	Into :ldh_emissao
	From nf_venda
	Where cd_filial				= :ll_Filial
	 and dh_movimentacao_caixa = :ldt_periodo
	 and nr_ecf 				= :ll_ecf
	 and de_especie		= 'CF'
	 and nr_coo_ecf = :ll_coo_final	 
	Using Sqlca;
End If

If Sqlca.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar emiss$$HEX1$$e300$$ENDHEX$$o COO: " + String(ll_mapa), Information!)
	Return 0
End If

ldh_reducao = gf_relative_datetime(ldh_emissao, 600)

//Verifica Valor total bruto
Select sum(vl_total_nf_bruto)
  Into :ldc_venda_bruta
From nf_venda
Where cd_filial             = :ll_Filial
	and dh_movimentacao_caixa = :ldt_periodo
	and nr_ecf                = :ll_ecf
	and de_especie		= 'CF'
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar totalizadores de venda.", Information!)
	Return 0
End If

//Verifica Valor total liquido
Select sum(vl_total_nf) 
  Into :ldc_venda_liquida
From nf_venda
Where cd_filial             = :ll_Filial
	and dh_movimentacao_caixa = :ldt_periodo
	and nr_ecf                = :ll_ecf
	and dh_cancelamento is null
	 and de_especie		= 'CF'
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar totalizadores de venda.", Information!)
	Return 0
End If

//Verifica itens cancelados
If Not ivb_matriz then
	select sum(l.qt_cancelada * (round(p.vl_preco_venda_atual /coalesce(p.vl_fator_conversao,1),2)))
		Into :ldc_cancelamento
	from log_cancelamento_fiscal l
	inner join produto_geral p
		on p.cd_produto = l.cd_produto
	where l.dh_movimentacao_caixa =:ldt_periodo 
		and l.cd_filial = :ll_Filial
		and l.nr_ecf = :ll_ecf
		//and l.de_especie		= 'CF'
		and coalesce(l.de_especie,'') <> 'NFC'
		and l.nr_coo <> l.nr_ecf		
	Using Sqlca;
Else
	ls_uf = gf_uf_filial(ll_Filial)
	select sum(l.qt_cancelada * (round(pu.vl_preco_venda_atual /coalesce(p.vl_fator_conversao,1),2)))
		Into :ldc_cancelamento
	from log_cancelamento_fiscal l
	inner join produto_geral p
		on p.cd_produto = l.cd_produto
	inner join produto_uf pu
		on pu.cd_produto = l.cd_produto
	where l.dh_movimentacao_caixa =:ldt_periodo 
		and l.cd_filial = :ll_Filial
		and l.nr_ecf = :ll_ecf	
		//and l.de_especie		= 'CF'
		and coalesce(l.de_especie,'') <> 'NFC'
		and l.nr_coo <> l.nr_ecf		
		and pu.cd_unidade_federacao = :ls_uf
	Using Sqlca;
End If
If Sqlca.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar totalizadores de cancelamento.", Information!)
	Return 0
End If

If IsNull(ldc_cancelamento) Then ldc_cancelamento = 000.00

ldc_venda_bruta += ldc_cancelamento

ldc_gt_final = ldc_gt_inicial + ldc_venda_bruta

//Verifica se j$$HEX1$$e100$$ENDHEX$$ existe um mapa resumo ecf gravado que n$$HEX1$$e300$$ENDHEX$$o seja substituto e usa algumas informa$$HEX2$$e700f500$$ENDHEX$$es dele, porque s$$HEX1$$e300$$ENDHEX$$o informa$$HEX2$$e700f500$$ENDHEX$$es que vieram do ECF.
Select nr_operacao_final,
	 vl_total_geral_final,
	 qt_reducao_z,
	 qt_reinicio_z,
	dh_reducao,
	id_substituto
Into :ll_coo_final_gravado,
	 :ldc_gt_final_gravado,
	 :ll_reducao_z_gravado,
	 :ll_qt_reinicio_z_gravado,
	 :ldh_reducao_gravado,
	 :ls_substituto
From mapa_resumo_ecf m
Where m.cd_filial = :ll_filial
  and m.nr_ecf    = :ll_ecf
  and m.nr_mapa   = :ll_mapa
  //and (m.id_substituto = null or m.id_substituto = 'N')
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar mapa resumo ecf existente: " + String(ll_mapa), Information!)
		Return 0
	Case 0
		If ls_substituto <> 'S' Or IsNull(ls_substituto)  Then
			If ll_coo_final_gravado > 0 Then ll_coo_final = ll_coo_final_gravado
			//If ll_reducao_z_gravado > 0 Then ll_reducao_z = ll_reducao_z_gravado
			ldc_gt_final = ldc_gt_final_gravado
			ll_qt_reinicio_z = ll_qt_reinicio_z_gravado
			ldh_reducao = ldh_reducao_gravado
		End If 
	Case 100	
		
End Choose

dw_2.Reset()
dw_2.InsertRow(0)
dw_2.object.mapa				[1] = ll_mapa
dw_2.object.coo_inicial		[1] = ll_coo_inicial+1
dw_2.object.coo_final			[1] = ll_coo_final
dw_2.object.gt_inicial			[1] = ldc_gt_inicial
dw_2.object.gt_final			[1] = ldc_gt_final
dw_2.object.cancelamento	[1] = ldc_cancelamento
dw_2.object.venda_bruta	[1] = ldc_venda_bruta
dw_2.object.venda_liquida	[1] = ldc_venda_liquida
dw_2.object.desconto			[1] = ldc_venda_bruta - ( ldc_venda_liquida + ldc_cancelamento )
dw_2.object.isento			[1] = 000.00 
dw_2.object.st					[1] = 000.00
dw_2.object.reducao			[1] = ll_reducao_z + 1
dw_2.object.qt_reinicioz		[1] = ll_qt_reinicio_z
dw_2.object.dh_reducao		[1] = ldh_reducao

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_SalvarComo(pl_linhas > 0)
This.ivm_menu.mf_Imprimir(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
This.ivm_menu.mf_Imprimir(False)

end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge106_mapa_resumo_substituto
integer x = 1070
integer y = 408
integer width = 745
integer height = 908
integer taborder = 0
string dataobject = "dw_ge106_aliquota_icms"
end type

event dw_3::ue_recuperar;//OVERRIDE

Date lvdt_periodo

Long lvl_ecf,&
     lvl_filial, &
	  lvl_contador, &
	  lvl_linhas
	  
Decimal lvdc_pc_icms  , &
        lvdc_vl_base  , &
		  lvdc_somatoria, &
		  lvdc_diferenca

String lvs_cd_st

dw_1.AcceptText()


	
lvl_filial = dw_1.Object.cd_filial   [1]                       
	
lvl_ecf      = dw_1.Object.nr_ecf    [1]
lvdt_periodo = dw_1.Object.dt_periodo[1]

lvl_Linhas = dw_3.Retrieve(lvl_filial,lvl_ecf,lvdt_periodo)

lvdc_somatoria = 0.00

For lvl_contador = 1 to lvl_Linhas

	lvdc_pc_icms = dw_3.Object.pc_icms[lvl_contador]
	lvdc_vl_base = dw_3.Object.vl_base_icms[lvl_contador]
	lvs_cd_st    = dw_3.Object.cd_situacao_tributaria[lvl_contador]

	lvdc_somatoria += lvdc_vl_base

	If lvdc_pc_icms = 0.00 Then
		If lvs_cd_st = '04' Then
			dw_2.Object.isento[1] = lvdc_vl_base
		Else
			dw_2.Object.st[1] = lvdc_vl_base
		End If
	End If
Next
lvdc_diferenca = dw_2.Object.venda_liquida[1] - lvdc_somatoria

If lvdc_diferenca > 0.00 Then
	If dw_2.Object.st[1] > 0 Then
		dw_2.Object.st[1] = dw_2.Object.st[1] + lvdc_diferenca
	Else
		dw_2.Object.isento[1] = dw_2.Object.isento[1] + lvdc_diferenca
	End If
End If
If lvdc_diferenca < 0.00 Then
	If dw_2.Object.st[1] >= (lvdc_diferenca * (-1)) Then
		dw_2.Object.st[1] = dw_2.Object.st[1] + lvdc_diferenca
	ElseIf dw_2.Object.isento[1] >= (lvdc_diferenca * (-1)) Then
		dw_2.Object.isento[1] = dw_2.Object.isento[1] + lvdc_diferenca
	ElseIf dw_3.Object.vl_base_icms[1] >= (lvdc_diferenca * (-1)) Then
		dw_3.Object.vl_base_icms[1] = dw_3.Object.vl_base_icms[1] + lvdc_diferenca
	End If
End If

//	Long ll_find
//	// Localiza Isentas
//	ll_find = dw_3.Find("cd_situacao_tributaria = '04'",1,dw_3.RowCount())
//	If ll_find > 0 Then
//		dw_2.object.isento[1] = dw_3.object.vl_base_icms[ll_find]
//	End If	
//	// Localiza ST
//	ll_find = dw_3.Find("cd_situacao_tributaria = '06'",1,dw_3.RowCount())
//	If ll_find > 0 Then
//		dw_2.object.st[1] = dw_3.object.vl_base_icms[ll_find]
//	End If	


Return lvl_linhas
end event

type dw_4 from dc_uo_dw_base within w_ge106_mapa_resumo_substituto
boolean visible = false
integer x = 923
integer y = 1256
integer width = 983
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge106_relatorio_mapa_resumo"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.Visible = False
end event

event ue_preprint;call super::ue_preprint;Long	lvl_linha				, &
		lvl_linha_inclusa	, &
		lvl_linha_aliquota	, &
		lvl_filial				, &
		lvl_mapa				, &
		lvl_ecf				, &
		lvl_controla_linha
	  
Date ldt_periodo

This.Event ue_Retrieve()

dw_1.AcceptText()	

lvl_mapa		= dw_2.Object.mapa			[1]
ldt_periodo	= dw_1.Object.dt_periodo	[1]
lvl_ecf		= dw_1.Object.nr_ecf			[1]
lvl_filial		= dw_1.Object.cd_filial		[1]

//Localiza dados filial
ivo_filial.of_localiza_codigo(lvl_filial)

This.Object.dh_data.text 		= String(ldt_periodo,"dd/mm/yyyy")
This.Object.endereco.text 		= ivo_filial.de_endereco + ', ' + ivo_filial.de_bairro
This.Object.cidade.text 			= ivo_filial.nm_cidade
This.Object.uf.text					= gvo_parametro.ivs_uf_filial
This.Object.cgc.text				= gf_colocar_mascara_cgc(ivo_filial.nr_cgc)
This.Object.insc_estadual.text	= ivo_filial.nr_inscricao_estadual
This.Object.filial.text				= ivo_filial.nm_fantasia + ' (' + String(ivo_filial.cd_filial) + ')'

Return This.RowCount()
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()

Parent.ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event ue_recuperar;//override
Long	lvl_linha				, &
		lvl_linha_inclusa	, &
		lvl_linha_aliquota	, &
		lvl_filial				, &
		lvl_mapa				, &
		lvl_ecf				, &
		lvl_controla_linha
	  
Date ldt_periodo

dw_1.AcceptText()	

lvl_mapa		= dw_2.Object.mapa			[1]
ldt_periodo	= dw_1.Object.dt_periodo	[1]
lvl_ecf		= dw_1.Object.nr_ecf			[1]
lvl_filial		= dw_1.Object.cd_filial		[1]

SetPointer(HourGlass!)

//Localiza dados filial
ivo_filial.of_localiza_codigo(lvl_filial)

lvl_linha_inclusa = dw_4.InsertRow(0)

dw_4.Object.nr_mapa		[lvl_linha_inclusa] = lvl_mapa
dw_4.Object.nr_ecf			[lvl_linha_inclusa] = lvl_ecf
dw_4.Object.nr_cf_inicial	[lvl_linha_inclusa] = dw_2.Object.coo_inicial		[1]
dw_4.Object.nr_cf_final		[lvl_linha_inclusa] = dw_2.Object.coo_final			[1]
dw_4.Object.gt_inicial		[lvl_linha_inclusa] = dw_2.Object.gt_inicial			[1]
dw_4.Object.gt_final			[lvl_linha_inclusa] = dw_2.Object.gt_final			[1]
dw_4.Object.cancelamentos	[lvl_linha_inclusa] = dw_2.Object.cancelamento	[1]
dw_4.Object.descontos		[lvl_linha_inclusa] = dw_2.Object.desconto			[1]
dw_4.Object.contabil			[lvl_linha_inclusa] = dw_2.Object.venda_liquida	[1]
dw_4.Object.isento			[lvl_linha_inclusa] = dw_2.Object.isento				[1]
dw_4.Object.nao_incidencia	[lvl_linha_inclusa] = 000.00
dw_4.Object.st					[lvl_linha_inclusa] = dw_2.Object.st					[1]
dw_4.Object.reducao_z		[lvl_linha_inclusa] = dw_2.Object.reducao			[1]
dw_4.Object.nr_ecf			[lvl_linha_inclusa] = lvl_ecf
dw_4.Object.base_calculo	[lvl_linha_inclusa] = 000.00
dw_4.Object.vl_imposto		[lvl_linha_inclusa] = 000.00
dw_4.Object.pc_aliquota		[lvl_linha_inclusa] = 000.00

//***********************************
Decimal {2} ldc_valor_icms

lvl_controla_linha = 1

FOR lvl_linha_aliquota = 1 TO dw_3.RowCount()
	
	ldc_valor_icms = ( dw_3.Object.vl_base_icms[lvl_linha_aliquota] * ( dw_3.Object.pc_icms[lvl_linha_aliquota] / 100 ) )

	If dw_3.Object.pc_icms[lvl_linha_aliquota] <> 000.00 Then
		If lvl_controla_linha > 1 Then
			dw_4.InsertRow(0)
		End If
		dw_4.Object.nr_ecf			[lvl_controla_linha] = lvl_ecf
		dw_4.Object.base_calculo	[lvl_controla_linha] = dw_3.Object.vl_base_icms	[lvl_linha_aliquota]
		dw_4.Object.pc_aliquota		[lvl_controla_linha] = dw_3.Object.pc_icms			[lvl_linha_aliquota]
		dw_4.Object.vl_imposto		[lvl_controla_linha] = dw_3.Object.vl_icms			[lvl_linha_aliquota]
		lvl_controla_linha ++
	End If

Next

Return This.RowCount()
end event

event ue_preretrieve;call super::ue_preretrieve;This.Reset()

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;// Imprime o mapa resumo
This.GroupCalc()

Return AncestorReturnValue
end event

type cb_1 from commandbutton within w_ge106_mapa_resumo_substituto
integer x = 32
integer y = 1392
integer width = 626
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gravar Mapa Resumo"
end type

event clicked;
DateTime ldt_Movimento
DateTime ldh_reducao
Date     ldt_Periodo

long	ll_filial,&
		lvl_filial,&
		ll_ecf,&
		ll_mapa,&
		ll_retorno,&
		ll_coo_inicial,&
		ll_coo_final,&
		ll_reducao_z,&
		ll_reinicio_z,&
		lvl_seq
	 
Decimal 	ldc_gt_inicial,&
			ldc_gt_final,&
			ldc_venda_bruta,&
			ldc_venda_liquida,&
			ldc_cancelamento,&
			ldc_desconto,&
			ldc_isento,&
			ldc_st,&
			ll_reducao
		
String  	ls_situacao_ecf

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja gravar Mapa Resumo ?",Question!,YesNo!,2) = 2 Then Return



dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

ldt_periodo 		= dw_1.Object.dt_periodo   [1]
ll_ecf 				= dw_1.object.nr_ecf			[1]
ll_filial			= dw_1.object.cd_filial		[1]

ll_mapa				= dw_2.object.mapa				[1]
ll_coo_inicial		= dw_2.object.coo_inicial		[1]
ll_coo_final			= dw_2.object.coo_final			[1]
ldc_gt_inicial		= dw_2.object.gt_inicial			[1]
ldc_gt_final 			= dw_2.object.gt_final			[1]
ldc_cancelamento	= dw_2.object.cancelamento	[1]
ldc_venda_bruta	= dw_2.object.venda_bruta		[1]
ldc_venda_liquida	= dw_2.object.venda_liquida	[1]
ldc_desconto		= dw_2.object.desconto			[1]
ldc_isento			= dw_2.object.isento				[1]
ldc_st					= dw_2.object.st					[1]
ll_reducao			= dw_2.object.reducao			[1]
ll_reinicio_z			= dw_2.object.qt_reinicioz		[1]
ldh_reducao			= dw_2.object.dh_reducao		[1]

If Isnull(ll_coo_inicial) Then ll_coo_inicial = 0

If IsNull(ll_coo_final) Then ll_coo_final = 0

If IsNull(ll_mapa) Then ll_mapa = 0

If IsNull(ldc_gt_inicial) Then ldc_gt_inicial = 0

If IsNull(ldc_cancelamento) Then ldc_cancelamento = 0

If IsNull(ldc_venda_bruta	) Then ldc_venda_bruta	 = 0

If IsNull(ldc_venda_liquida) Then ldc_venda_liquida = 0

If IsNull(ldc_desconto) Then ldc_desconto = 0

If IsNull(ldc_isento) Then ldc_isento = 0

If IsNull(ldc_st) Then ldc_st = 0

If IsNull(ldc_gt_final) Then ldc_gt_final = 0

If IsNull(ll_reducao) Then ll_reducao = 0

If Isnull(ll_reinicio_z) Then ll_reinicio_z = 0

Select nr_mapa Into :ll_Mapa
From mapa_resumo_ecf
Where cd_filial = :ll_filial
  and nr_mapa   = :ll_mapa
  and nr_ecf    = :ll_ecf
Using Sqlca;

Choose Case Sqlca.Sqlcode
	Case -1	
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo")
		Return
	Case 0
		
			Update mapa_resumo_ecf
			Set nr_operacao_inicial  	= :ll_coo_inicial,
			    nr_operacao_final    	= :ll_coo_final,
				 vl_total_geral_inicial	= :ldc_gt_inicial,
				 vl_total_geral_final	= :ldc_gt_final,
				 vl_cancelamento      	= :ldc_cancelamento,
				 vl_desconto		    = :ldc_desconto,
				 vl_contabil          	= :ldc_venda_liquida,
				 vl_isenta            	= :ldc_isento,
				 vl_st                	= :ldc_st,
				 qt_reducao_z         	= :ll_reducao,
				 vl_nao_incidencia	 	= vl_nao_incidencia,
				 qt_cupom_cancelado  	= qt_cupom_cancelado,
				 id_substituto			= 'S'
			Where cd_filial  = :ll_filial
			  and nr_mapa    = :ll_Mapa
			  and de_especie = 'MR'
			  and de_serie   = '1'
			  and nr_ecf     = :ll_ecf
			Using Sqlca;

			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_RollBack()
				Sqlca.Of_MsgDbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo ECF.")
				Return
			End If

	Case 100		
		
		Select nr_mapa Into :ll_Mapa
		From mapa_resumo
		Where cd_filial = :ll_filial
		  and nr_mapa   = :ll_mapa
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo")
			Return
		End If	
		
		ll_mapa = dw_2.object.mapa[1]
				
		If Sqlca.SqlCode = 100 Then
		
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Mapa Resumo Geral Inexistente. Favor avisar ao CPD !",Stopsign!)	
			Return
//  			Insert Into mapa_resumo
//					 (cd_filial,
//					  nr_mapa,
//					  de_especie,
//					  de_serie,
//					  dh_emissao)
//			Values (:ll_filial,
//					  :ll_Mapa,
//					  'MR',
//					  '1',
//					  :ldt_periodo)
//			Using Sqlca;
//			
//			If Sqlca.Sqlcode = -1 Then
//				Sqlca.of_RollBack()
//				Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
//				Return
//			End If
			
		End If	
			
		Insert Into mapa_resumo_ecf
				( cd_filial,   
				  nr_mapa,   
				  de_especie,   
				  de_serie,   
				  nr_ecf,
				  nr_operacao_inicial,
				  nr_operacao_final,
				  vl_total_geral_inicial,
				  vl_total_geral_final,
				  vl_cancelamento,
				  vl_desconto,
				  vl_contabil,
				  vl_isenta,
				  vl_nao_incidencia,
				  vl_st,
				  qt_reducao_z,
				  qt_cupom_cancelado,
				  dh_reducao,
				  qt_reinicio_z,
				  id_substituto)
		Values ( :ll_filial,
					:ll_Mapa,   
					'MR',
					'1',   
					:ll_ecf,
					:ll_coo_inicial,
					:ll_coo_final,
					:ldc_gt_inicial,
					:ldc_gt_final,
					:ldc_cancelamento,
					:ldc_desconto,
					:ldc_venda_liquida,
					:ldc_isento,
					000.00,
					:ldc_st,
					:ll_reducao,
					0,					
					:ldh_reducao,
					:ll_reinicio_z,
					'S')
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_RollBack()
			Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
			Return
		End If
		
End Choose

If Not wf_Grava_Aliquota() Then Return
//Grava registro para envio do BlocoX, mapa gravado pela matriz n$$HEX1$$e300$$ENDHEX$$o grave registro, devido controle sequencial da loja
If Trim(id_gera_blocoX) = 'S' And Not ivb_Matriz And Date(ldt_Periodo) >= dt_inicio_blocox Then
	
	Select nr_sequencial
	Into  :lvl_seq
	  From historico_envio_arquivo_paf
	 Where cd_filial    = :ll_filial 
	 	and cd_tipo = 'RZ' 
		and nr_ecf = :ll_ecf 
		and nr_mapa_resumo  = :ll_mapa 
		and qt_reducao_z = :ll_reducao
	 Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_RollBack()
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
		Return
	End If
	
	If Isnull(lvl_seq) Or lvl_seq = 0 Then	
		Insert Into historico_envio_arquivo_paf
				( cd_filial,   
				  cd_tipo,
				  qt_reducao_z,
				  nr_ecf,				  
				  nr_mapa_resumo,
				  dh_movimento,
				  id_situacao,
				  id_enviado_matriz)
		Values ( :ll_filial,
					'RZ',
					:ll_reducao,
					:ll_ecf,					
					:ll_Mapa,
					:ldt_Periodo,
					'P',
					'N')
		Using Sqlca;	
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_RollBack()
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
			Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
			Return
		End If
	End If
End If

Sqlca.of_Commit()
	
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Mapa gravado com sucesso !")	
end event

