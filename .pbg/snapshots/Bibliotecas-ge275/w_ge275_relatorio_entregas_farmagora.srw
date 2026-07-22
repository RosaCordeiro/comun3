HA$PBExportHeader$w_ge275_relatorio_entregas_farmagora.srw
forward
global type w_ge275_relatorio_entregas_farmagora from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge275_relatorio_entregas_farmagora from dc_w_selecao_lista_relatorio
integer width = 3250
integer height = 1800
string title = "GE275 - Relat$$HEX1$$f300$$ENDHEX$$rio das Entregas do e-Commerce"
long backcolor = 80269524
end type
global w_ge275_relatorio_entregas_farmagora w_ge275_relatorio_entregas_farmagora

forward prototypes
public function long wf_entregas (long al_filial, datastore ads_entregas, string as_tipo)
end prototypes

public function long wf_entregas (long al_filial, datastore ads_entregas, string as_tipo);Long ll_Count
Long ll_Find

ll_Find = ads_entregas.find( "p.cd_filial = " +String( al_filial ) + " and p.nm_transportadora = '" + as_tipo + "'", 1, ads_entregas.RowCount() )

If ll_Find > 0 Then
	ll_Count = 	ads_entregas.Object.qt_registro[ ll_Find ]
Else 
	ll_Count = 0
End If

Return ll_Count









//
//If as_Tipo = 'D' Then
//	
//	Select count(*) 
//	Into :lvl_Count
//	From pedido_ecommerce p,
//	     nf_venda n
//	Where p.nm_transportadora 	= 'PRIORIT$$HEX1$$c100$$ENDHEX$$RIA'
//		and p.cd_filial			=:al_Filial
//		and (p.dh_inclusao 	> :adt_Inicio and p.dh_inclusao < :adt_Termino)
//		and p.cd_filial			= n.cd_filial
//		and p.nr_pedido		= n.nr_pedido_ecommerce
//		and n.dh_cancelamento 	is null
//		and n.nr_nf_anexa 		is null
//		and not exists (	select * from nf_devolucao_venda d
//					  		where n.cd_filial	= d.cd_filial_venda
//					   		 and n.nr_nf			= d.nr_nf_venda
//					   		 and n.de_especie	= d.de_especie_venda
//					    		 and n.de_serie		= d.de_serie_venda)
//	  Using SqlCa;
//	
//Else
//	
//	Select count(*) 
//	Into :lvl_Count
//	From pedido_ecommerce p,
//	     nf_venda n
//	Where p.nm_transportadora 	<> 'PRIORIT$$HEX1$$c100$$ENDHEX$$RIA'
//	  and p.cd_filial			=:al_Filial
//	  and (p.dh_inclusao 	>:adt_Inicio and p.dh_inclusao < :adt_Termino)
//  	  and p.cd_filial			= n.cd_filial
//	  and p.nr_pedido			= n.nr_pedido_ecommerce
//	  and not exists (select * from nf_devolucao_venda d
//					  where n.cd_filial		= d.cd_filial_venda
//					    and n.nr_nf			= d.nr_nf_venda
//					    and n.de_especie	= d.de_especie_venda
//					    and n.de_serie		= d.de_serie_venda)
//	Using SqlCa;
//	
//End If
//
//Choose Case SqlCa.SqlCode
//	Case 0
//	Case 100
//	Case -1
//		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da transportadora")
//End Choose
//
//Return lvl_Count
end function

on w_ge275_relatorio_entregas_farmagora.create
call super::create
end on

on w_ge275_relatorio_entregas_farmagora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Movimentacao 

This.ivm_Menu.ivb_Permite_Imprimir = True

lvdt_Movimentacao = Date(gvo_Parametro.of_DH_Movimentacao())

dw_1.Object.dt_Inicio [1] = DateTime(gf_Primeiro_Dia_Mes(lvdt_Movimentacao))

If Day(lvdt_Movimentacao) = 1 Then
	dw_1.Object.dt_Termino [1] = gvo_Parametro.of_DH_Movimentacao()
Else
	dw_1.Object.dt_Termino[1] = DateTime(RelativeDate(lvdt_Movimentacao, -1) )	
End If

// exclui o item TODAS
DataWindowChild ldw_Child
dw_1.GetChild("cd_filial_ecommerce", ldw_Child)
ldw_Child.deleterow( 1 ) 

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge275_relatorio_entregas_farmagora
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge275_relatorio_entregas_farmagora
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge275_relatorio_entregas_farmagora
integer x = 23
integer y = 284
integer width = 3163
integer height = 1308
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge275_relatorio_entregas_farmagora
integer x = 23
integer y = 8
integer width = 1271
integer height = 264
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge275_relatorio_entregas_farmagora
integer x = 50
integer y = 68
integer width = 1211
integer height = 180
string dataobject = "dw_ge275_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge275_relatorio_entregas_farmagora
integer x = 55
integer y = 352
integer width = 3109
integer height = 1220
string dataobject = "dw_ge275_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Filial,&
	 lvl_Linha

Long ll_Filial_EC

Date lvdt_Inicio,&
	 lvdt_Termino
	 
This.ivm_Menu.mf_SalvarComo(False)

Try

	If pl_Linhas > 0 Then
		
		lvdt_Inicio 		= RelativeDate(Date(dw_1.Object.dt_inicio[1]), -1)
		lvdt_Termino 	= RelativeDate(Date(dw_1.Object.dt_termino[1]), +1)
		ll_Filial_EC		= dw_1.Object.cd_filial_Ecommerce[1]		
		
		dc_uo_ds_base ldS_Entregas
		lds_Entregas = Create dc_uo_ds_base
		
		If Not lds_Entregas.of_changedataobject( "ds_ge275_entregas" ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no of_changedataobject ds_ge275_entregas.")
			Return -1
		End If
		
		//Retrieve
		lds_Entregas.Retrieve( lvdt_Inicio, lvdt_Termino, ll_Filial_EC  )
			
		For lvl_Linha = 1 To pl_Linhas
			lvl_Filial = dw_2.Object.cd_filial[lvl_Linha]	
			
			dw_2.Object.qt_retirada_loja	[lvl_Linha] = wf_entregas(lvl_Filial, lds_Entregas, 'RETIRAR NA LOJA')
			dw_2.Object.qt_total_express	[lvl_Linha] = wf_entregas(lvl_Filial, lds_Entregas, 'TOTAL EXPRESS')
			dw_2.Object.qt_pac				[lvl_Linha] = wf_entregas(lvl_Filial, lds_Entregas, 'PAC')
			dw_2.Object.qt_sedex			[lvl_Linha] = wf_entregas(lvl_Filial, lds_Entregas, 'SEDEX')
		Next
		
		This.ivm_Menu.mf_SalvarComo(True)
		
	End If

	Return pl_Linhas
	
Finally
	If IsValid(lds_Entregas) Then Destroy lds_Entregas		
End Try
end event

event dw_2::ue_recuperar;// OverRide

DateTime lvdt_Inicio,&
		 lvdt_Termino

Long ll_FIlial_EC

dw_1.AcceptText()

lvdt_Inicio 			= dw_1.Object.dt_inicio					[1]
lvdt_Termino 		= dw_1.Object.dt_termino				[1]
ll_FIlial_EC			= dw_1.Object.cd_filial_ecommerce 	[1]

If Isnull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Isnull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

dw_2.of_AppendWhere("p.dh_inclusao >= '" + String(lvdt_Inicio, "yyyy/mm/dd") + " 00:00:00" +&
					"' and p.dh_inclusao <= '" + String(lvdt_Termino, "yyyy/mm/dd") + " 23:59:59" + "'", 1)

Return This.Retrieve( ll_FIlial_EC )
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge275_relatorio_entregas_farmagora
integer x = 1833
integer y = 76
integer height = 128
string dataobject = "dw_ge275_lista_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;this.Object.t_periodo.Text = string(dw_1.Object.dt_inicio[1],"dd/mm/yyyy")+&
                             ' at$$HEX1$$e900$$ENDHEX$$ '+string(dw_1.Object.dt_termino[1],"dd/mm/yyyy")
									  
this.Object.t_rede.Text	= dw_1.Describe("Evaluate('LookUpDisplay(cd_filial_ecommerce)', 1)")								  
									  
return AncestorReturnValue
end event

