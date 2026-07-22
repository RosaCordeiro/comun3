HA$PBExportHeader$w_ge098_cota_diaria_venda.srw
forward
global type w_ge098_cota_diaria_venda from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge098_cota_diaria_venda from dc_w_selecao_lista_relatorio
integer x = 215
integer y = 220
integer width = 2816
integer height = 1892
string title = "GE098 - Acompanhamento de Cotas Di$$HEX1$$e100$$ENDHEX$$rias de Venda"
long backcolor = 80269524
end type
global w_ge098_cota_diaria_venda w_ge098_cota_diaria_venda

type variables
Uo_Filial ivo_Filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public function string wf_dia_semana (string ps_dia)
public function long wf_valor_cota (long pl_filial, long pl_filial_ate, date pdt_inicio, date pdt_final)
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_filial, &
       lvs_todas
		 
dw_1.AcceptText()
		 
lvs_todas = String(dw_1.Object.id_todas_filiais)

If   lvs_todas = 'S'  Then
	  lvs_filial = 'Todas as Filiais' 
Else 
	  lvs_filial = dw_1.GetText()
End If	  

ivo_filial.Of_Localiza_Filial(lvs_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
   dw_1.Object.filial[1]    = ivo_filial.nm_fantasia
	
End If

end subroutine

public function string wf_dia_semana (string ps_dia);Choose Case UPPER(ps_dia)
	Case "MONDAY"    ; Return "SEGUNDA FEIRA"
	Case "TUESDAY"   ; Return "TER$$HEX1$$c700$$ENDHEX$$A FEIRA"
	Case "WEDNESDAY" ; Return "QUARTA FEIRA"
	Case "THURSDAY"  ; Return "QUINTA FEIRA" 
	Case "FRIDAY"    ; Return "SEXTA FEIRA"
	Case "SATURDAY"  ; Return "S$$HEX1$$c100$$ENDHEX$$BADO"
	Case "SUNDAY"    ; Return "DOMINGO"
	Case Else        ; Return ''
End Choose 
end function

public function long wf_valor_cota (long pl_filial, long pl_filial_ate, date pdt_inicio, date pdt_final);Decimal lvdc_Valor_Cota

Select sum(vl_cota) into :lvdc_Valor_Cota
from cota_filial
where dh_cota  >= :pdt_inicio
  and dh_cota  <= :pdt_final
  and cd_filial between  :pl_filial and :pl_filial_ate
 Using SqlCa; 

If SqlCa.SqlCode =  -1 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o no valor da cota " , StopSign!)	
End IF

Return (lvdc_Valor_Cota)

end function

on w_ge098_cota_diaria_venda.create
call super::create
end on

on w_ge098_cota_diaria_venda.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Filial = Create Uo_Filial
end event

event ue_postopen;call super::ue_postopen;// Habilita os bot$$HEX1$$f500$$ENDHEX$$es de Impress$$HEX1$$e300$$ENDHEX$$o.
This.ivm_Menu.ivb_Permite_Imprimir = True

This.ivm_Menu.mf_Recuperar(True)

Date lvdt_Sistema, &
     lvdt_inicial	, &
	  lvdt_final
	  
Integer lvi_Mes , lvi_ano

Long lvl_Filial, lvl_Filial_Matriz

lvdt_Sistema = Today()
lvdt_inicial = Today()
lvdt_final   = Today()

dw_1.Object.pdt_inicio [1] = lvdt_inicial 
dw_1.Object.pdt_final  [1] = lvdt_final

lvl_Filial        = gvo_Parametro.of_Filial()
lvl_Filial_Matriz = gvo_Parametro.of_Filial_Matriz()

If lvl_Filial <> lvl_Filial_Matriz Then

   dw_1.SetReDraw(False)
	dw_1.Object.cd_filial[1]      = lvl_Filial
	dw_1.Object.filial[1]         = gvo_parametro.nm_fantasia_filial
	dw_1.Object.cd_filial.Protect = 1
	dw_1.Object.filial.Protect    = 1		
	dw_1.SetReDraw(True)

End If
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge098_cota_diaria_venda
integer x = 18
integer y = 268
integer width = 2734
integer height = 1420
integer weight = 700
long backcolor = 79741120
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge098_cota_diaria_venda
integer x = 18
integer y = 0
integer width = 1810
integer height = 260
integer weight = 700
long backcolor = 79741120
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge098_cota_diaria_venda
integer x = 46
integer y = 68
integer width = 1774
integer height = 184
string dataobject = "dw_ge098_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "filial" Then
	If Data <> ivo_filial.nm_fantasia Then Return 1
End If

end event

event dw_1::ue_key;call super::ue_key;STRING	lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "filial" Then
		wf_Localiza_Filial()
	End If
End If

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge098_cota_diaria_venda
integer x = 46
integer y = 320
integer width = 2697
integer height = 1344
string dataobject = "dw_ge098_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.SetRedraw(False)

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"dh_cota", "dia_semana", "vl_cota_prevista", "venda", "per_venda", "cota_acm",&
				  "venda_acm", "per_venda_acm"}
				  
lvs_Nome = {"dia", "dia semana", "dia cota", "venda", "perc venda", &
            "cota acumulada", "venda acumulada", "perc venda acumulada"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_recuperar;//OverRide
Long lvl_Filial, &
     lvl_filial_ate 

String  lvs_todas_filiais

Integer lvi_mes, &
        lvi_ano
Date    lvdt_inicio, &
        lvdt_final 
	  
Decimal lvdc_Valor_Cota

This.Reset()

dw_1.AcceptText()

lvdt_inicio		= dw_1.Object.pdt_inicio			[1]
lvdt_final			= dw_1.Object.pdt_final			[1]
lvs_todas_filiais	= dw_1.Object.id_todas_filiais	[1]
lvl_Filial			= dw_1.Object.cd_filial			[1]
lvl_filial_ate		= dw_1.Object.cd_filial			[1]

If    lvs_todas_filiais = 'S' Then
	   lvl_filial  = 0
	   lvl_filial_ate = 999	
Else
      If   Isnull(dw_1.Object.filial[1]) Then
	        messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deve ser informado a filial para impress$$HEX1$$e300$$ENDHEX$$o dos dados.",Information!)
	        dw_1.SetColumn("filial")
	        dw_1.SetFocus()
	        return 0
		End If
End If

//If   Len(string(lvi_ano)) < 4 Then
//	  messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O ano informado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido.", Information!)
//	  dw_1.SetColumn("ano")
//	  dw_1.SetFocus()
//	  return -1
//Else 
//	  If   Len(string(lvi_ano)) = 4 and not isnull(dw_1.Object.cd_filial[1])Then
//     If   Len(string(lvi_ano)) = 4  Then
	       
//			 lvl_Filial = dw_1.Object.cd_filial[1]

	
lvdc_Valor_Cota = wf_valor_cota(lvl_Filial, lvl_filial_ate, lvdt_inicio, lvdt_final)

If   lvdc_Valor_Cota > 0 Then
     This.SetRedraw(False)
     Return This.Retrieve(lvl_Filial, lvl_filial_ate, lvdt_inicio, lvdt_final)		
Else 
     MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cota da filial " + String(lvl_filial) + " at$$HEX1$$e900$$ENDHEX$$ " + String(lvl_filial_ate) + " do m$$HEX1$$ea00$$ENDHEX$$s " + &                      				
	              String(lvi_mes) + " e ano " + String(lvi_ano) + " n$$HEX1$$e300$$ENDHEX$$o cadastrada.", Information!,Ok!)
	  Return -1
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;SetPointer(HourGlass!)

Integer lvi_mes, lvi_ano,lvi_contador
		  
Long lvl_Total_Clientes

Decimal{2} lvdc_Vendas, &
			  lvdc_Venda_Liquida, &
			  lvdc_Total_Venda_Tot = 0, &
			  lvdc_Dev_Venda, &
			  lvdc_Cota_Acm, &
			  lvdc_Perc_Venda, &
			  lvdc_Perc_Venda_Acm, &
			  lvdc_Cota_Prevista
			  
Long lvl_filial, &
     lvl_filial_ate 

Date lvdt_Data  , &
     lvdt_inicio, &
	  lvdt_final

String lvs_Dia_Semana, &
       lvs_todas_filiais

dw_1.AcceptText()

lvs_todas_filiais = dw_1.Object.id_todas_filiais[1]

If    lvs_todas_filiais = 'S' Then
      lvl_Filial		= 0
      lvl_filial_ate= 999
Else 		
      lvl_Filial		= dw_1.Object.cd_filial[1]
      lvl_filial_ate= dw_1.Object.cd_filial[1]
End If


This.SetRedraw(False)

lvdt_inicio	= dw_1.Object.pdt_inicio	[1]
lvdt_final		= dw_1.Object.pdt_final	[1]

For lvi_contador = 1 To This.Rowcount()
	
	lvdt_Data = Date(This.Object.Dh_Cota[lvi_Contador])
	
	lvdc_Vendas				= 0
	lvdc_Dev_Venda		= 0
	lvdc_Venda_Liquida	= 0
	lvdc_Cota_Prevista		= 0
	lvdc_Perc_Venda		= 0

	Select sum(vl_venda_avista      + vl_venda_crediario      + &
	        vl_venda_convenio       + vl_venda_conta_corrente + &
			  vl_venda_cartao_credito + vl_venda_cartao_debito  + &
			  vl_venda_cheque_avista  + vl_venda_cheque_aprazo),
			  sum(vl_devolucao_venda)
	 Into  :lvdc_Vendas,
			 :lvdc_Dev_Venda
	From   resumo_movimento_estoque
	Where  dh_resumo = :lvdt_Data   and
	       cd_filial between :lvl_filial and :lvl_filial_ate  	
	Using  SqlCa; 

	If SqlCa.SqlCode =  -1 Then
		messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o dos totais do dia " + String(lvdt_Data, "DD/MM/YYYY") + ".", StopSign!)
		Return -1
	End IF

	If IsNull(lvdc_Vendas)    Then lvdc_Vendas    = 0
	If IsNull(lvdc_Dev_Venda) Then lvdc_Dev_Venda = 0
		
	lvdc_Cota_Prevista			= dw_2.Object.Vl_Cota_prevista[lvi_Contador]
	lvdc_Venda_Liquida		= lvdc_Vendas - lvdc_Dev_Venda
	lvdc_Total_Venda_Tot	= lvdc_Total_Venda_Tot + lvdc_Venda_Liquida
	lvdc_Cota_Acm				= lvdc_Cota_Acm + lvdc_Cota_Prevista
	
	If lvdc_Cota_Prevista > 0 Then
		lvdc_Perc_Venda      = Round((lvdc_Venda_Liquida / lvdc_Cota_Prevista) *100,2)
		lvdc_Perc_Venda_Acm  = Round((lvdc_Total_Venda_Tot / lvdc_Cota_Acm) *100,2)
	End If
	
	dw_2.Object.Venda				[lvi_Contador] = lvdc_Venda_Liquida
	dw_2.Object.Venda_Acm		[lvi_Contador] = lvdc_Total_Venda_Tot
	dw_2.Object.Cota_Acm			[lvi_Contador] = lvdc_Cota_Acm	
	dw_2.Object.Perc_Venda		[lvi_Contador] = lvdc_Perc_Venda
	dw_2.Object.Perc_Venda_Acm	[lvi_Contador] = lvdc_Perc_Venda_Acm
	
	lvs_Dia_Semana                       = Upper(DayName(lvdt_Data))
	dw_2.Object.Dia_Semana[lvi_Contador] = wf_Dia_Semana(lvs_Dia_Semana)
	
Next

This.ivm_Menu.mf_SalvarComo(lvi_contador > 0)	

This.SetRedraw(True)

SetPointer(Arrow!)
	
Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)	
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge098_cota_diaria_venda
integer x = 2011
integer y = 28
integer width = 407
integer height = 196
integer taborder = 50
string dataobject = "dw_ge098_relatorio"
boolean hscrollbar = true
end type

event dw_3::ue_preprint;call super::ue_preprint;Integer lvi_Mes, &
        lvi_Ano
		  
String lvs_Periodo, &
       lvs_todas, &
		 lvs_filial

lvi_Mes   = dw_1.Object.Mes[1]
lvi_Ano   = dw_1.Object.Ano[1]
lvs_todas = dw_1.Object.id_todas_filiais[1]

If   lvs_todas = 'S' Then    
     dw_3.Object.texto_filial.Text = 'Todas as Filiais'
Else
	  lvs_filial = dw_1.Object.filial[1]
	  dw_3.Object.texto_filial.Text = lvs_filial
End If
	  

lvs_Periodo = gf_Mes_Extenso(lvi_Mes) + " / " + String(lvi_Ano, "0000")

dw_3.Object.Periodo_Cabecalho.Text = lvs_Periodo

Return AncestorReturnValue
end event

