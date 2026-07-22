HA$PBExportHeader$w_ge316_relatorio_saldo_caixa.srw
forward
global type w_ge316_relatorio_saldo_caixa from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge316_relatorio_saldo_caixa from dc_w_selecao_lista_relatorio
integer width = 3415
integer height = 1872
string title = "GE316 - Relat$$HEX1$$f300$$ENDHEX$$rio de Saldos dos Caixas das Filiais"
boolean minbox = false
boolean resizable = false
long backcolor = 80269524
end type
global w_ge316_relatorio_saldo_caixa w_ge316_relatorio_saldo_caixa

type variables
uo_filial ivo_filial
end variables

forward prototypes
public function boolean wf_saldo_avista (string ps_caixa, long pl_controle, ref decimal pdc_saldo)
public function boolean wf_saldo_recarga (string ps_caixa, long pl_controle, ref decimal pdc_saldo)
public function boolean wf_saldo_cartao_credito_debito (string ps_caixa, long pl_controle, ref decimal pdc_saldo)
public function boolean wf_atualiza_saldo_lancamento ()
public function boolean wf_limite_caixa (long pl_filial, datetime pdt_data, ref decimal pl_limite)
public function boolean wf_saldo_outros_debitos (string ps_caixa, long pl_controle, ref decimal pdc_saldo)
end prototypes

public function boolean wf_saldo_avista (string ps_caixa, long pl_controle, ref decimal pdc_saldo);Decimal {2} ldc_Saldo

select sum(vl_lancamento) Into :pdc_Saldo
from lancamento_caixa lc
inner join conta_fluxo_caixa cfc
 on cfc.cd_conta_fluxo_caixa 	= lc.cd_conta_fluxo_caixa
where lc.cd_caixa 					= :ps_caixa
  and lc.nr_controle_caixa 		= :pl_controle
  and cfc.id_credito_debito		= 'C'
  and lc.cd_conta_fluxo_caixa not in (162,163,164,165,171,215)
  and lc.id_estorno <> 'S'
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Valor a vista")
	Return False
End If	

If IsNull(pdc_Saldo) Then pdc_Saldo = 000.00

Return True
end function

public function boolean wf_saldo_recarga (string ps_caixa, long pl_controle, ref decimal pdc_saldo);Decimal {2} ldc_Saldo

select sum(vl_lancamento) Into :pdc_Saldo
from lancamento_caixa
where cd_caixa 				= :ps_caixa
  and nr_controle_caixa 	= :pl_controle
  and cd_conta_fluxo_caixa in (162,163,164,165,171)
  and Upper(id_estorno) <> 'S'
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Valor Recarga")
	Return False
End If	

If IsNull(pdc_Saldo) Then pdc_Saldo = 000.00

Return True
end function

public function boolean wf_saldo_cartao_credito_debito (string ps_caixa, long pl_controle, ref decimal pdc_saldo);Decimal {2} ldc_Saldo

select sum(vl_lancamento) Into :pdc_Saldo
from lancamento_caixa
where cd_caixa 				  = :ps_caixa
  and nr_controle_caixa 	  = :pl_controle
  and cd_conta_fluxo_caixa in ( Select distinct(cd_conta_fluxo_caixa) From cartao_produto )
  and id_estorno <> 'S'
Using Sqlca;

If Sqlca.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Valor Cart$$HEX1$$e300$$ENDHEX$$o Cr$$HEX1$$e900$$ENDHEX$$dito/D$$HEX1$$e900$$ENDHEX$$bito")
	Return False
End If

If IsNull(pdc_Saldo) Then pdc_Saldo = 000.00

Return True
end function

public function boolean wf_atualiza_saldo_lancamento ();Long    ll_row
Long    ll_controle
Long    ll_filial

String  ls_caixa

Decimal {2} ldc_Recebido
Decimal {2} ldc_Avista
Decimal {2} ldc_Recarga
Decimal {2} ldc_Cartao
Decimal {2} ldc_Limite
Decimal {2} ldc_Outros_Debitos

DateTime ldt_Data

If dw_2.RowCount() > 0 Then	
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Calculando percentuais ..."
	w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())
		
	For ll_row = 1 To dw_2.RowCount()
		
		ll_filial   		= dw_2.object.cd_filial            [ll_row]
		ls_caixa    	= dw_2.object.cd_caixa             [ll_row]
		ll_controle 	= dw_2.object.nr_controle_caixa    [ll_row]
		ldt_Data    	= dw_2.object.dh_movimentacao_caixa[ll_row]
		
		If Not wf_saldo_avista(ls_caixa,ll_controle,Ref ldc_Avista) Then Return False
		
		If Not wf_saldo_Recarga(ls_caixa,ll_controle,Ref ldc_Recarga) Then Return False
		
		If Not wf_saldo_Cartao_Credito_Debito(ls_caixa,ll_controle,Ref ldc_Cartao) Then Return False
		
		If Not wf_Saldo_Outros_Debitos(ls_caixa,ll_controle,Ref ldc_Outros_Debitos) Then Return False
		
		If Not wf_Limite_Caixa(ll_filial,ldt_Data,Ref ldc_Limite) Then Return False
		
		ldc_Recebido = (ldc_Avista + ldc_Recarga) - (ldc_Cartao + ldc_Outros_Debitos)
		
		// Por solicita$$HEX2$$e700e300$$ENDHEX$$o do Renato (tesouraria), quando n$$HEX1$$e300$$ENDHEX$$o tiver movimenta$$HEX2$$e700e300$$ENDHEX$$o no caixa os valores n$$HEX1$$e300$$ENDHEX$$o devem compor para a sumariza$$HEX2$$e700e300$$ENDHEX$$o.
		// 24/07/2014
		// Douglas Starosky
		If (ldc_Avista = 0.00 and ldc_Recarga = 0.00 and ldc_Cartao = 0.00 and ldc_Outros_Debitos = 0.00) Then
			dw_2.object.vl_saldo_especie[ll_row] 	= 0.00
			dw_2.object.vl_maximo_caixa [ll_row] 	= 0.00
			If gvo_aplicacao.ivo_seguranca.cd_sistema = "CR" Then dw_2.Object.Vl_Saldo_Final[ll_row]		= 0.00
		Else
			dw_2.object.vl_saldo_especie[ll_row] 	= ldc_Recebido
			dw_2.object.vl_maximo_caixa [ll_row] 	= ldc_Limite
		End If			
		
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
				
	Next
	
	Close(w_Aguarde)
	
End If

dw_2.GroupCalc()
dw_2.Sort()

Return True
end function

public function boolean wf_limite_caixa (long pl_filial, datetime pdt_data, ref decimal pl_limite);
SetNull(pl_limite)

Select vl_limite Into :pl_limite
From historico_limite_caixa_filial
where cd_filial = :pl_filial
  and ( dh_inicio <= :pdt_data and ( dh_termino = null or dh_termino >= :pdt_data ) )
Using Sqlca;

If Sqlca.sqlcode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do limite de caixa da filial.")
	Return False
End If

If IsNull(pl_Limite) Then pl_Limite = 000.00

Return True



end function

public function boolean wf_saldo_outros_debitos (string ps_caixa, long pl_controle, ref decimal pdc_saldo);Decimal {2} ldc_Saldo

select sum(vl_lancamento) Into :pdc_Saldo
from lancamento_caixa lc
inner join conta_fluxo_caixa cfc
 on cfc.cd_conta_fluxo_caixa 	= lc.cd_conta_fluxo_caixa
where lc.cd_caixa 					= :ps_caixa
  and lc.nr_controle_caixa 		= :pl_controle
  and cfc.id_credito_debito		= 'D'
  and cfc.id_tipo_conta 	not in ('D','S')
  and lc.cd_conta_fluxo_caixa not in ( Select distinct(cd_conta_fluxo_caixa) From cartao_produto)
  and lc.cd_conta_fluxo_caixa not in (10, 122, 214)
  and lc.id_estorno <> 'S';
  
If Sqlca.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Valor Saldo D$$HEX1$$e900$$ENDHEX$$bito")
	Return False
End If

If IsNull(pdc_Saldo) Then pdc_Saldo = 000.00

Return True
end function

on w_ge316_relatorio_saldo_caixa.create
call super::create
end on

on w_ge316_relatorio_saldo_caixa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Filial = Create uo_Filial

dw_1.Object.Dt_Inicio [1] = Today()
dw_1.Object.Dt_Termino[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True

This.ivm_Menu.mf_SalvarComo(True)

end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_retrieve;call super::ue_retrieve;
wf_Atualiza_Saldo_Lancamento()
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge316_relatorio_saldo_caixa
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge316_relatorio_saldo_caixa
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge316_relatorio_saldo_caixa
integer x = 23
integer y = 268
integer width = 3346
integer height = 1428
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge316_relatorio_saldo_caixa
integer x = 23
integer y = 8
integer width = 1842
integer height = 252
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge316_relatorio_saldo_caixa
integer x = 46
integer y = 68
integer width = 1806
integer height = 172
string dataobject = "dw_ge316_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

String lvs_Nulo

If dwo.Name = "nm_filial" Then
	If Trim(Data) <> ""  Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		SetNull(ivo_Filial.Cd_Filial)
		SetNull(ivo_Filial.Nm_Fantasia)
		
		This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
		This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge316_relatorio_saldo_caixa
integer x = 46
integer y = 320
integer width = 3305
integer height = 1352
string dataobject = "dw_ge316_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// Override

Date 	lvdt_Inicio, &
     	lvdt_Termino
	  
lvdt_Inicio  		= dw_1.Object.Dt_Inicio [1]
lvdt_Termino 	= dw_1.Object.Dt_Termino[1]

If Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

This.Retrieve(lvdt_Inicio, lvdt_Termino)

Return This.RowCount()
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial

dw_1.AcceptText()

lvl_Filial = dw_1.Object.Cd_Filial[1]

If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
	This.of_AppendWhere("cx.cd_filial = " + String(lvl_Filial))
End If

Return 1
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nm_fantasia", &
              "nr_controle_caixa", &
				  "dh_movimentacao_caixa", &
				  "vl_saldo_final",&
				  "percentual",&
				  "vl_saldo_especie"}

lvs_Nome = {"Filial", &
				"Controle", &
				"Data", &
				"Saldo Esp$$HEX1$$e900$$ENDHEX$$cie",&
				"Percentual",&
				"Saldo Final"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.ivb_Ordena_Colunas = True

This.of_SetFilter(lvs_Coluna, lvs_Nome)


end event

event dw_2::doubleclicked;Long ll_filial

If dwo.name = 'vl_maximo_caixa' Then 
	
	If row > 0 Then
		
		ll_filial = This.object.cd_filial[row]
			
		OpenWithParm(w_ge316_historico_limite_caixa,String(ll_filial))
	
	End If
	
End If


	
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_salvarcomo( pl_linhas > 0 )

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge316_relatorio_saldo_caixa
integer x = 2642
integer y = 24
integer width = 526
integer height = 236
integer taborder = 50
string dataobject = "dw_ge316_relatorio"
end type

event dw_3::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino
	
lvdt_Inicio 	 	= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

This.Object.t_Periodo.Text = String(lvdt_Inicio , "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
									  	String(lvdt_Termino, "dd/mm/yyyy")
									  
Return AncestorReturnValue
end event

