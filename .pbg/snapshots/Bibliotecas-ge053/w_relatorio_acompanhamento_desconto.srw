HA$PBExportHeader$w_relatorio_acompanhamento_desconto.srw
forward
global type w_relatorio_acompanhamento_desconto from dc_w_selecao_lista_relatorio
end type
end forward

global type w_relatorio_acompanhamento_desconto from dc_w_selecao_lista_relatorio
integer width = 3630
integer height = 1908
string title = "GE053 - Relat$$HEX1$$f300$$ENDHEX$$rio de Acompanhamento de Descontos"
end type
global w_relatorio_acompanhamento_desconto w_relatorio_acompanhamento_desconto

type variables
uo_filial ivo_filial
uo_ge053_acompanhamento_desconto ivo_desconto
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_prepara_excel (ref dc_uo_ds_base ads)
public subroutine wf_atualiza_venda_sem_desconto ()
public function boolean wf_venda_sem_desconto (long al_filial, date adt_inicio, date adt_termino, ref decimal adc_venda)
public function boolean wf_devolucao_sem_desconto (long al_filial, date adt_inicio, date adt_termino, ref decimal adc_devolucao)
public subroutine wf_atualiza_regiao ()
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_filial

lvs_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(lvs_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
   dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	
End If

end subroutine

public subroutine wf_prepara_excel (ref dc_uo_ds_base ads);Long lvl_linha

ads.Reset()

For lvl_linha = 1 To dw_2.RowCount()
	ads.InsertRow(0)
	
	ads.Object.Cd_Filial            [lvl_Linha] = dw_2.Object.Cd_Filial             [lvl_Linha]
	ads.Object.Nm_Fantasia          [lvl_Linha] = dw_2.Object.Nm_Fantasia           [lvl_Linha]
	ads.Object.Vl_Venda_Bruta       [lvl_Linha] = dw_2.Object.Vl_Venda_Bruta_Final  [lvl_Linha]
	ads.Object.Vl_Venda_Tabela      [lvl_Linha] = dw_2.Object.Vl_Venda_Tabela_Final [lvl_Linha]
	ads.Object.Vl_Venda_Liquida     [lvl_Linha] = dw_2.Object.Vl_Venda_Liquida_Final[lvl_Linha]
	ads.Object.Vl_Venda_Servicos    [lvl_Linha] = dw_2.Object.Vl_Venda_Sem_Desconto [lvl_Linha]
	ads.Object.Pc_Desconto_Geral    [lvl_Linha] = dw_2.Object.Pc_Desconto_Geral     [lvl_Linha]
	ads.Object.Pc_Desconto_Comercial[lvl_Linha] = dw_2.Object.Pc_Desconto_Comercial [lvl_Linha]
	ads.Object.Pc_Desconto_Filial   [lvl_Linha] = dw_2.Object.Pc_Desconto_Filial    [lvl_Linha]
	ads.Object.Id_Rede				[lvl_Linha]  = dw_2.Object.Id_Rede_Filial[lvl_Linha]
	ads.Object.Cd_Regiao				[lvl_Linha]  = dw_2.Object.Cd_Regiao[lvl_Linha]
Next
end subroutine

public subroutine wf_atualiza_venda_sem_desconto ();Date lvdt_Inicio, &
     lvdt_Termino
	  	
Long lvl_Filial, &
     lvl_Total, &
	  lvl_Contador
	  
Decimal lvdc_Venda, &
        lvdc_Devolucao

String lvs_Verificar

lvdt_Inicio   = dw_1.Object.Dt_Inicio            [1]
lvdt_Termino  = dw_1.Object.Dt_Termino           [1]
lvs_Verificar = dw_1.Object.Id_Venda_Sem_Desconto[1]

If lvs_Verificar = "N" Then Return

lvl_Total = dw_2.RowCount()

Open(w_Aguarde)
w_Aguarde.Title = "Verificando as Vendas de Servi$$HEX1$$e700$$ENDHEX$$os..."

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

dw_2.SetRedraw(False)

For lvl_Contador = 1 To lvl_Total
	lvl_Filial = dw_2.Object.Cd_Filial[lvl_Contador]
	
	If Not ivo_Desconto.of_Venda_Sem_Desconto(lvl_Filial, lvdt_Inicio, lvdt_Termino, ref lvdc_Venda) Then Exit
	
	If Not ivo_Desconto.of_Devolucao_Sem_Desconto(lvl_Filial, lvdt_Inicio, lvdt_Termino, ref lvdc_Devolucao) Then Exit
	
	dw_2.Object.Vl_Venda_Sem_Desconto[lvl_Contador] = lvdc_Venda - lvdc_Devolucao
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)	
Next

dw_2.GroupCalc()

dw_2.SetRedraw(True)

Close(w_Aguarde)
end subroutine

public function boolean wf_venda_sem_desconto (long al_filial, date adt_inicio, date adt_termino, ref decimal adc_venda);Select sum(round(round(i.vl_preco_praticado * i.qt_vendida, 2) * ((100 - n.pc_desconto) / 100), 2))
Into :adc_Venda
From nf_venda n (index idx_data_filial),
	  item_nf_venda i (index pk_item_nf_venda),
	  produto_geral p (index pk_produto_geral)
Where n.cd_filial = :al_Filial
  and n.dh_movimentacao_caixa between :adt_Inicio and :adt_Termino
  and n.dh_cancelamento is null
  and n.nr_nf_anexa     is null
  and i.cd_filial  = n.cd_filial
  and i.nr_nf      = n.nr_nf
  and i.de_especie = n.de_especie
  and i.de_serie   = n.de_serie
  and p.cd_subcategoria like '7%' 
  and p.cd_produto = i.cd_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas sem Desconto da Filial '" + String(al_Filial) + "'")
	Return False
End If

If IsNull(adc_Venda) Then adc_Venda = 0

Return True

end function

public function boolean wf_devolucao_sem_desconto (long al_filial, date adt_inicio, date adt_termino, ref decimal adc_devolucao);Select sum(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto) / 100), 2) * i.qt_devolvida, 2) * ((100 - n.pc_desconto) / 100), 2))
Into :adc_Devolucao
From nf_devolucao_venda n,
     item_nf_devolucao_venda i
Where n.cd_filial = :al_Filial
  and n.dh_movimentacao_caixa between :adt_Inicio and :adt_Termino
  and n.dh_cancelamento is null
  and i.cd_filial  = n.cd_filial
  and i.nr_nf      = n.nr_nf
  and i.de_especie = n.de_especie
  and i.de_serie   = n.de_serie
//  and i.cd_produto in (select cd_produto from produto_geral where substring(cd_subcategoria, 1, 1) in ('6', '7'))
  and i.cd_produto in (select cd_produto from produto_geral where cd_subcategoria like '7%')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Devolu$$HEX2$$e700f500$$ENDHEX$$es sem Desconto da Filial '" + String(al_Filial) + "'")
	Return False
End If

If IsNull(adc_Devolucao) Then adc_Devolucao = 0

Return True
end function

public subroutine wf_atualiza_regiao ();String lvs_Fantasia

Long lvl_Linha

For lvl_Linha = 1 To dw_2.RowCount()
	
	lvs_Fantasia = MidA(dw_2.Object.nm_fantasia[lvl_Linha], 1,1)
	
	Choose Case lvs_Fantasia
		Case '1'
			dw_2.Object.de_regiao[lvl_Linha] = '1'
			dw_2.Object.de_empresa[lvl_Linha] = 'D'
		Case '2'
			dw_2.Object.de_regiao[lvl_Linha] = '2'
			dw_2.Object.de_empresa[lvl_Linha] = 'D'
		Case '3'
			dw_2.Object.de_regiao[lvl_Linha] = '3'
			dw_2.Object.de_empresa[lvl_Linha] = 'D'
		Case '4'
			dw_2.Object.de_regiao[lvl_Linha] = '4'
			dw_2.Object.de_empresa[lvl_Linha] = 'D'
		Case 'F'
			dw_2.Object.de_regiao[lvl_Linha] = '5'
			dw_2.Object.de_empresa[lvl_Linha] = 'X'
		Case 'M'
			dw_2.Object.de_regiao[lvl_Linha] = '6'
			dw_2.Object.de_empresa[lvl_Linha] = 'X'
		Case Else
			dw_2.Object.de_regiao[lvl_Linha] = 'N$$HEX1$$c300$$ENDHEX$$O IDENTIFICADA'	
			dw_2.Object.de_empresa[lvl_Linha] = 'X'
	End Choose
Next


	  
	  






end subroutine

on w_relatorio_acompanhamento_desconto.create
call super::create
end on

on w_relatorio_acompanhamento_desconto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Inicio, &
     lvdt_Parametro

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

lvdt_Inicio = Date("01/" + MidA(String(lvdt_Parametro,"dd/mm/yyyy"), 4))

dw_1.Object.Dt_Inicio		[1] = lvdt_Inicio
dw_1.Object.Dt_Termino	[1] = lvdt_Parametro

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_desconto)
end event

event ue_saveas;dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If lvds_1.of_ChangeDataObject("dw_ge053_excel") Then
	wf_Prepara_Excel(ref lvds_1)
	
	lvds_1.of_SaveAs("")	
End If

Destroy(lvds_1)
end event

event ue_preopen;call super::ue_preopen;ivo_Filial 			= Create uo_Filial
ivo_desconto	= Create uo_ge053_Acompanhamento_Desconto
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_relatorio_acompanhamento_desconto
integer x = 14
integer y = 332
integer width = 3557
integer height = 1372
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_relatorio_acompanhamento_desconto
integer x = 14
integer y = 4
integer width = 1824
integer height = 316
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_relatorio_acompanhamento_desconto
integer x = 41
integer y = 60
integer width = 1787
integer height = 248
string dataobject = "dw_ge053_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long    lvl_nulo
SetNull(lvl_Nulo)

Choose Case dwo.Name
	Case "de_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_filial.nm_fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_Filial[1] = lvl_Nulo
			ivo_filial.nm_fantasia   = ''
		End If
End Choose


end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then	
	Choose Case GetColumnName()			
		Case "de_filial"
			wf_localiza_filial()			
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	dw_1.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
End If	
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_relatorio_acompanhamento_desconto
integer x = 41
integer y = 376
integer width = 3506
integer height = 1308
string dataobject = "dw_ge053_lista"
end type

event dw_2::ue_recuperar;// Override

Date lvdt_Inicio, &
     lvdt_Termino
	  	
Long lvl_Filial	

dw_1.AcceptText()	

lvl_Filial   = dw_1.Object.Cd_Filial [1]
lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_AppendWhere("r.cd_filial = " + String(lvl_Filial))
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", &
				  "cd_regiao",&
              	  "nm_fantasia", &
				  "vl_venda_bruta_final", &
				  "vl_venda_tabela_final", &
				  "vl_venda_liquida_final", &
				  "vl_venda_sem_desconto", &
				  "pc_desconto_geral", &
				  "pc_desconto_comercial", &
				  "pc_desconto_filial"}

lvs_Nome = {"Filial", &
				"Regi$$HEX1$$e300$$ENDHEX$$o",&
            		"Fantasia", &
				"Venda Bruta", &
				"Venda Tabela", &
				"Venda L$$HEX1$$ed00$$ENDHEX$$quida", &
				"Venda de Servi$$HEX1$$e700$$ENDHEX$$os", &
				"Desconto Geral", &
				"Desconto Comercial", &
				"Desconto Filial"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	wf_Atualiza_Venda_Sem_Desconto()
	
	//wf_Atualiza_Regiao()
End If

This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_relatorio_acompanhamento_desconto
integer x = 2528
integer y = 24
integer width = 617
integer height = 304
integer taborder = 50
string dataobject = "dw_ge053_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;String lvs_Fantasia

Date	lvdt_Inicio, &
		lvdt_Termino
	  
Long lvl_Linha

If AncestorReturnValue > 0 Then

	For lvl_Linha = 1 To dw_3.RowCount()
		
		lvs_Fantasia = MidA(dw_3.Object.nm_fantasia[lvl_Linha], 1,1)
		
		Choose Case lvs_Fantasia
			Case '1'
				dw_3.Object.de_regiao[lvl_Linha] = '1'
			Case '2'
				dw_3.Object.de_regiao[lvl_Linha] = '2'
			Case '3'
				dw_3.Object.de_regiao[lvl_Linha] = '3'
			Case '4'
				dw_3.Object.de_regiao[lvl_Linha] = '4'
			Case 'F'
				dw_3.Object.de_regiao[lvl_Linha] = '5'
			Case 'M'
				dw_3.Object.de_regiao[lvl_Linha] = '6'
			Case Else
				dw_3.Object.de_regiao[lvl_Linha] = '7'
		End Choose
	Next
	
	dw_3.Sort()
	dw_3.GroupCalc()

End If
	
lvdt_Inicio  		= dw_1.Object.Dt_Inicio [1]
lvdt_Termino 	= dw_1.Object.Dt_Termino[1]

This.Object.t_Periodo.Text = String(lvdt_Inicio , "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
									  String(lvdt_Termino, "dd/mm/yyyy")

//This.Object.Vl_Total_Venda_Sem_Desconto.Text = String(dw_2.Object.Vl_Total_Venda_Sem_Desconto[1], "0,000.00")
//This.Object.Pc_Total_Desconto_Geral.Text     = String(dw_2.Object.Pc_Total_Desconto_Geral    [1], "0.00")
//This.Object.Pc_Total_Desconto_Comercial.Text = String(dw_2.Object.Pc_Total_Desconto_Comercial[1], "0.00")
//This.Object.Pc_Total_Desconto_Filial.Text    = String(dw_2.Object.Pc_Total_Desconto_Filial   [1], "0.00")

Return AncestorReturnValue
end event

