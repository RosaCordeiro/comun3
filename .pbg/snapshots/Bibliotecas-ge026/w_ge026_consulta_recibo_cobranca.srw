HA$PBExportHeader$w_ge026_consulta_recibo_cobranca.srw
forward
global type w_ge026_consulta_recibo_cobranca from dc_w_2tab_consulta_selecao_lista_det
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type cb_impressao_recibo from commandbutton within w_ge026_consulta_recibo_cobranca
end type
end forward

global type w_ge026_consulta_recibo_cobranca from dc_w_2tab_consulta_selecao_lista_det
integer width = 3451
integer height = 1928
string title = "GE026 - Consulta de Recibos de Cobran$$HEX1$$e700$$ENDHEX$$a"
cb_impressao_recibo cb_impressao_recibo
end type
global w_ge026_consulta_recibo_cobranca w_ge026_consulta_recibo_cobranca

type variables
uo_cliente ivo_cliente
uo_filial ivo_filial
uo_controle_caixa  ivo_controle_caixa

Integer  ivi_recibo_cheque, &
             ivi_recibo_nf_convenio_problema, &
             ivi_recibo_nf_convenio_parcial, &
             ivi_recibo_titulo_crediario, &
             ivi_recibo_titulo_convenio, &
             ivi_recibo_titulo_conta_corrente, &
             ivi_recibo_outros, &
             ivi_recibo_conta_corrente_conta, &
             ivi_recibo_convenio_conta
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_filial

lvs_filial = Tab_1.TabPage_1.dw_1.GetText()

ivo_filial.Of_Localiza_Filial(lvs_filial)

If ivo_filial.Localizada Then
	
	Tab_1.TabPage_1.dw_1.Object.cd_filial_venda[1] = ivo_filial.cd_filial
   Tab_1.TabPAge_1.dw_1.Object.de_filial[1]       = ivo_filial.nm_fantasia
	
End If

end subroutine

on w_ge026_consulta_recibo_cobranca.create
int iCurrent
call super::create
this.cb_impressao_recibo=create cb_impressao_recibo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_impressao_recibo
end on

on w_ge026_consulta_recibo_cobranca.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_impressao_recibo)
end on

event close;call super::close;If IsValid(ivo_cliente) 				Then Destroy (ivo_cliente)
If IsValid(ivo_filial) 				Then Destroy (ivo_filial)
If IsValid(ivo_controle_caixa) 	Then Destroy (ivo_controle_caixa)
end event

event ue_postopen;call super::ue_postopen;ivm_Menu.mf_Recuperar(True)

long lvl_Filial

lvl_Filial = gvo_Parametro.Of_Filial()

ivo_cliente         = Create uo_cliente
ivo_Filial          = Create uo_filial
ivo_Controle_Caixa  = Create uo_controle_caixa

Tab_1.TabPage_1.dw_1.Object.dt_Emissao_de [1]  = Date(gvo_Parametro.of_dh_Movimentacao())
Tab_1.TabPage_1.dw_1.Object.dt_Emissao_ate[1]  = Date(gvo_Parametro.of_dh_Movimentacao())

ivi_recibo_cheque                 = ivo_Controle_Caixa.of_Recibo_Cheque()
ivi_recibo_nf_convenio_problema   = ivo_Controle_Caixa.of_Recibo_NF_Convenio_Problema()
ivi_recibo_nf_convenio_parcial    = ivo_Controle_Caixa.of_Recibo_NF_Convenio_Parcial()
ivi_recibo_titulo_crediario       = ivo_Controle_Caixa.of_Recibo_Titulo_Crediario()
ivi_recibo_titulo_convenio        = ivo_Controle_Caixa.of_Recibo_Titulo_Convenio()
ivi_recibo_titulo_conta_corrente  = ivo_Controle_Caixa.of_Recibo_Titulo_Conta_Corrente()
ivi_recibo_outros                 = ivo_Controle_Caixa.of_Recibo_Outros()
ivi_recibo_conta_corrente_conta   = ivo_Controle_Caixa.of_Recibo_Conta_Corrente_Conta()
ivi_recibo_convenio_conta         = ivo_Controle_Caixa.of_Recibo_Convenio_Conta()

If lvl_Filial <> gvo_parametro.of_filial_matriz() Then
	
	Tab_1.TabPage_1.dw_1.Object.cd_filial_venda[1] = lvl_Filial
	Tab_1.TabPage_1.dw_1.Object.de_filial[1]       = gvo_parametro.nm_fantasia_filial
	Tab_1.TabPage_1.dw_1.Object.de_filial.Protect  = 1		
	
End If

ivm_Menu.ivb_Permite_Imprimir = True

ivm_Menu.mf_Imprimir(False)
end event

event ue_printimmediate;call super::ue_printimmediate;String lvs_DataObject = "dw_ge026_relatorio_"

Integer lvi_cd_tipo_recibo

Tab_1.TabPage_1.dw_4.ShareDataOff( )

If IsNull(Tab_1.TabPage_1.dw_1.Object.cd_tipo_recibo[1]) Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o tipo de Recibo para impress$$HEX1$$e300$$ENDHEX$$o dos dados.",Information!,OK!)
	Tab_1.TabPage_1.dw_1.SetColumn("cd_tipo_recibo")
	Tab_1.TabPage_1.dw_1.SetFocus()
	Return
End If

lvi_cd_tipo_recibo  = Tab_1.TabPage_1.dw_1.Object.cd_tipo_recibo[1]

If IsNull(Tab_1.TabPage_1.dw_1.Object.de_filial[1]) Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar a filial para impress$$HEX1$$e300$$ENDHEX$$o dos dados.",Information!,OK!)

	Tab_1.TabPage_1.dw_1.SetColumn("de_filial")
	Tab_1.TabPage_1.dw_1.SetFocus()
	Return
End If

// Titulo Credi$$HEX1$$e100$$ENDHEX$$rio/Conta-Corrente
If (lvi_Cd_Tipo_Recibo = ivi_recibo_titulo_crediario) or +& 
	(lvi_Cd_Tipo_Recibo = ivi_recibo_titulo_conta_corrente) Then
	
	lvs_DataObject += "tit"
	
// T$$HEX1$$ed00$$ENDHEX$$tulo Conv$$HEX1$$ea00$$ENDHEX$$nio
ElseIf (lvi_Cd_Tipo_Recibo = ivi_recibo_titulo_convenio) Then
		
	lvs_DataObject += "tit_conv"

// Cheque
ElseIf(lvi_Cd_Tipo_Recibo = ivi_recibo_cheque) Then
	
	lvs_DataObject += "cheques"	
		
// NF Convenio
ElseIf (lvi_Cd_Tipo_Recibo = ivi_recibo_nf_convenio_problema) or +&
	    (lvi_Cd_Tipo_Recibo = ivi_recibo_nf_convenio_parcial) Then
	   
   lvs_DataObject += "nf"	
	
ElseIf (lvi_Cd_Tipo_Recibo = ivi_recibo_conta_corrente_conta) or +&
	    (lvi_Cd_Tipo_Recibo = ivi_recibo_convenio_conta) Then
	   
// Conta-Corrente - Conv$$HEX1$$ea00$$ENDHEX$$nio
	lvs_DataObject += "cc_cv_conta"
		
Else
// Outros
	lvs_DataObject += "outros"
End If

Tab_1.TabPage_1.dw_4.of_ChangeDataObject(lvs_DataObject)

Tab_1.TabPage_1.dw_4.Event ue_Retrieve()

If Tab_1.TabPage_1.dw_4.RowCount() > 0 Then
	Tab_1.TabPage_1.dw_4.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem dados para impress$$HEX1$$e300$$ENDHEX$$o.", Information!,OK!)
End If
end event

event ue_print;call super::ue_print;This.Event ue_PrintImmediate()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge026_consulta_recibo_cobranca
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge026_consulta_recibo_cobranca
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge026_consulta_recibo_cobranca
integer x = 9
integer y = 4
integer width = 3387
integer height = 1724
long backcolor = 79741120
end type

event tab_1::selectionchanging;//OverRide
SetPointer(HourGlass!)

LONG    lvl_Linha, &
        lvl_Linhas

Integer lvi_Cd_Tipo_Recibo

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

If NewIndex = 2 Then
	
	If lvl_Linha > 0 Then
		
		lvi_Cd_Tipo_Recibo = Tab_1.TabPage_1.dw_2.Object.cd_tipo_recibo[lvl_Linha]
		
		//Verifica se existe a necessidade de troca de dw 
		//conforme o tipo de nf de venda selecionado
		
		// Titulo Credi$$HEX1$$e100$$ENDHEX$$rio / Conta-Corrente
		If (lvi_Cd_Tipo_Recibo = ivi_recibo_titulo_crediario) or +& 
		   (lvi_Cd_Tipo_Recibo = ivi_recibo_titulo_conta_corrente) Then
			Tab_1.TabPage_2.dw_3.DataObject = "dw_ge026_detalhe_tit_cc_cr"
			Tab_1.TabPage_2.dw_3.SetTransObject(SqlCa)
		End If
		
		// Titulo Conv$$HEX1$$ea00$$ENDHEX$$nio
		If (lvi_Cd_Tipo_Recibo = ivi_recibo_titulo_convenio) Then
			Tab_1.TabPage_2.dw_3.DataObject = "dw_ge026_detalhe_tit_conv"
			Tab_1.TabPage_2.dw_3.SetTransObject(SqlCa)
		End If
		
		// Cheque			
		If (lvi_Cd_Tipo_Recibo = ivi_recibo_cheque) Then
		   Tab_1.TabPage_2.dw_3.DataObject = "dw_ge026_detalhe_ch"
			Tab_1.TabPage_2.dw_3.SetTransObject(SqlCa)
					
		End If
		
		// NF Convenio			
		If (lvi_Cd_Tipo_Recibo = ivi_recibo_nf_convenio_problema) or +&
         (lvi_Cd_Tipo_Recibo = ivi_recibo_nf_convenio_parcial) Then
			Tab_1.TabPage_2.dw_3.DataObject = "dw_ge026_detalhe_nf"
			Tab_1.TabPage_2.dw_3.SetTransObject(SqlCa)
		End If			
		
		// Conta-Corrente e Conv$$HEX1$$ea00$$ENDHEX$$nio por Conta
		If (lvi_Cd_Tipo_Recibo = ivi_recibo_convenio_conta) or +&
		   (lvi_Cd_Tipo_Recibo = ivi_recibo_conta_corrente_conta) Then
			Tab_1.TabPage_2.dw_3.DataObject = "dw_ge026_detalhe_cc_cv_conta"
			Tab_1.TabPage_2.dw_3.SetTransObject(SqlCa)
		End If			
		
		// Outros
		If (lvi_Cd_Tipo_Recibo = ivi_recibo_outros) Then
			Tab_1.TabPage_2.dw_3.DataObject = "dw_ge026_detalhe_outros"
			Tab_1.TabPage_2.dw_3.SetTransObject(SqlCa)
		End If
		
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()	
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!, Ok!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	
	End If
End If		

SetPointer(Arrow!)
end event

event tab_1::constructor;call super::constructor;// Determina as dimens$$HEX1$$f500$$ENDHEX$$es dos folders
// Sele$$HEX2$$e700e300$$ENDHEX$$o
ivl_Largura_1 = 3387
ivl_Altura_1  = 1724

// Detalhes
ivl_Largura_2 = 1755
ivl_Altura_2  = 1240
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3351
integer height = 1608
dw_4 dw_4
end type

on tabpage_1.create
this.dw_4=create dw_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_4)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 368
integer width = 3291
integer height = 1216
long backcolor = 79741120
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3291
integer height = 252
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer y = 64
integer width = 3205
integer height = 184
string dataobject = "dw_ge026_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;This.AcceptText()

If dwo.Name = "de_filial" Then
	If Data <> ivo_filial.nm_fantasia Then Return 1
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "de_filial" Then
		wf_Localiza_Filial()
	End If
End If

end event

event dw_1::ue_addrow;call super::ue_addrow;This.SetTransObject(SqlCa)

This.of_Populate_DDDW("cd_tipo_recibo")

Return AncestorReturnValue
end event

event dw_1::ue_populate_dddw;call super::ue_populate_dddw;pdwc_DDDW.SetTransObject(SqlCa)

pdwc_DDDW.Retrieve(gvo_parametro.of_filial())
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 46
integer y = 424
integer width = 3241
integer height = 1136
string dataobject = "dw_ge026_lista"
end type

event dw_2::ue_retrieve;call super::ue_retrieve;If AncestorReturnValue > 0 Then 
	This.Event RowFocusChanged(1)
End if	

Return AncestorReturnValue 
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Recibo, &
		 lvs_Emissao_de, &
       lvs_Emissao_ate

Long lvl_cd_Filial

Integer lvi_cd_Tipo_Recibo
	
Tab_1.TabPage_1.dw_1.AcceptText()

lvs_Recibo         = Trim(Tab_1.TabPage_1.dw_1.Object.nr_recibo[1])
lvs_Emissao_de     = String(Tab_1.TabPage_1.dw_1.Object.dt_Emissao_de[1], "YYYYMMDD")
lvs_Emissao_ate    = String(Tab_1.TabPage_1.dw_1.Object.dt_emissao_ate[1], "YYYYMMDD")
lvl_cd_Filial      = Tab_1.TabPage_1.dw_1.Object.Cd_Filial_venda[1]

lvi_cd_Tipo_Recibo = Tab_1.TabPage_1.dw_1.Object.cd_tipo_recibo[1]

If Not IsNull(lvs_Recibo) and lvs_Recibo <> "" Then
	This.of_Appendwhere(" recibo_cobranca.nr_recibo_cobranca = '" + lvs_Recibo + "'")
End If

If Not IsNull(lvs_Emissao_de) Then 
	This.of_Appendwhere(" recibo_cobranca.dh_emissao >= '" + lvs_Emissao_de + "'")
End If

If Not IsNull(lvs_Emissao_ate) Then 
	This.of_Appendwhere(" recibo_cobranca.dh_emissao <= '" + lvs_Emissao_ate + "'")
End If	

If Not IsNull(lvl_cd_Filial) and lvl_cd_Filial > 0 Then
	This.of_Appendwhere(" recibo_cobranca.cd_filial = " + String(lvl_cd_Filial))
End If

If Not IsNull(lvi_cd_Tipo_Recibo) and lvi_cd_Tipo_Recibo > 0 Then
	This.of_Appendwhere(" tipo_recibo_cobranca.cd_tipo_recibo = " + String(lvi_cd_Tipo_Recibo))
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;// OverRide

Long lvl_Linhas

lvl_linhas = This.Retrieve()

If lvl_linhas > 0 Then
	cb_impressao_recibo.Enabled = True
Else
	cb_impressao_recibo.Enabled = False
End If

Return lvl_linhas
end event

event dw_2::constructor;call super::constructor;//SORT E FILTER DA CLASSE NOVA 
//CONSTRUCTOR DA DW_2

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nr_recibo_cobranca", "dh_emissao", "de_tipo_recibo", "vl_nominal", "vl_juros",&
              "vl_desconto", "vl_recebido"}

lvs_Nome = {"n$$HEX1$$fa00$$ENDHEX$$mero recibo", "data emiss$$HEX1$$e300$$ENDHEX$$o", "tipo recibo", "valor nominal", &
            "valor juros", "valor desconto", "valor recebido"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		 

end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3351
integer height = 1608
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
boolean visible = false
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 37
integer y = 60
integer width = 1646
string dataobject = "dw_ge026_detalhe_nf"
end type

event dw_3::ue_recuperar;// OverRide

String  lvs_Nr_Recibo_Cobranca
	  
Integer lvi_Linha_Ativa
		  
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvs_Nr_Recibo_cobranca = Tab_1.TabPage_1.dw_2.Object.nr_recibo_cobranca[lvi_Linha_Ativa]

Return This.Retrieve(lvs_Nr_Recibo_Cobranca)

end event

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 1550
integer y = 204
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge026_relatorio_nf"
end type

event ue_preretrieve;call super::ue_preretrieve;String lvs_Recibo, &
		 lvs_Emissao_de, &
		 lvs_Emissao_ate
		 
Integer lvi_cd_tipo_recibo

Long lvl_cd_filial

Tab_1.TabPage_1.dw_1.AcceptText()

lvs_Recibo         = Trim(Tab_1.TabPage_1.dw_1.Object.nr_recibo[1])
lvi_cd_tipo_recibo = Tab_1.TabPage_1.dw_1.Object.cd_tipo_recibo[1]

lvl_cd_filial   = Tab_1.TabPage_1.dw_1.Object.cd_filial_venda[1]
lvs_Emissao_de  = String(Tab_1.TabPage_1.dw_1.Object.dt_emissao_de [1], "YYYYMMDD")
lvs_Emissao_ate = String(Tab_1.TabPage_1.dw_1.Object.dt_emissao_ate[1], "YYYYMMDD")

If Not IsNull(lvs_Recibo) and lvs_Recibo <> "" Then
	This.of_Appendwhere(" recibo_cobranca.nr_recibo_cobranca = '" + lvs_Recibo + "'")
End If

If Not IsNull(lvl_cd_Filial) and lvl_cd_Filial > 0 Then
	This.of_Appendwhere(" recibo_cobranca.cd_filial = " + String(lvl_cd_Filial))
	This.Object.filial_t.Text 	  = STRING(Tab_1.TabPage_1.dw_1.Object.cd_filial_venda[1])
	This.Object.de_filial_t.Text = Tab_1.TabPage_1.dw_1.Object.de_filial		         [1]
End If

If Not IsNull(lvi_cd_tipo_Recibo) and lvi_cd_Tipo_Recibo > 0 Then
	This.of_Appendwhere(" recibo_cobranca.cd_tipo_recibo = " + String(lvi_cd_tipo_recibo))
End If

Return AncestorReturnValue
end event

event ue_recuperar;// OVERRIDE

String lvs_Emissao_de, &
       lvs_Emissaode, &
       lvs_Emissao_ate, &
		 lvs_Emissaoate

Integer  lvi_cd_tipo_recibo

lvi_cd_tipo_recibo = Tab_1.TabPage_1.dw_1.Object.cd_tipo_recibo[1]
lvs_Emissaode      = String(Tab_1.TabPage_1.dw_1.Object.dt_emissao_de [1], "DD/MM/YYYY")
lvs_Emissaoate     = String(Tab_1.TabPage_1.dw_1.Object.dt_emissao_ate[1], "DD/MM/YYYY")

lvs_Emissao_de  = String(Tab_1.TabPage_1.dw_1.Object.dt_Emissao_de[1], "YYYYMMDD")
lvs_Emissao_ate = String(Tab_1.TabPage_1.dw_1.Object.dt_emissao_ate[1], "YYYYMMDD")

dw_4.Object.periodo_t.Text = lvs_Emissaode + " at$$HEX1$$e900$$ENDHEX$$ " + lvs_Emissaoate

If (lvi_cd_tipo_recibo =  ivi_recibo_titulo_crediario) Then
	dw_4.Object.text_t.Text = "Registro de Cobran$$HEX1$$e700$$ENDHEX$$a de T$$HEX1$$ed00$$ENDHEX$$tulos de Credi$$HEX1$$e100$$ENDHEX$$rio"
End If

If (lvi_cd_tipo_recibo =  ivi_recibo_titulo_conta_corrente) Then
	dw_4.Object.text_t.Text = "Registro de Cobran$$HEX1$$e700$$ENDHEX$$a de T$$HEX1$$ed00$$ENDHEX$$tulos de Conta-Corrente"
End If

If (lvi_cd_tipo_recibo =  ivi_recibo_conta_corrente_conta) Then
	dw_4.Object.text_t.Text = "Registro de Cobran$$HEX1$$e700$$ENDHEX$$a de Conta-Corrente por Conta"
End If

If (lvi_cd_tipo_recibo =  ivi_recibo_convenio_conta) Then
	dw_4.Object.text_t.Text = "Registro de Cobran$$HEX1$$e700$$ENDHEX$$a de Conv$$HEX1$$ea00$$ENDHEX$$nio por Conta"
End If

Return This.Retrieve(lvs_Emissao_de, lvs_Emissao_ate)
end event

type cb_impressao_recibo from commandbutton within w_ge026_consulta_recibo_cobranca
integer x = 2683
integer y = 396
integer width = 658
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Imprimir Recibo (ECF)"
end type

event clicked;SetPointer(HourGlass!)

String  lvs_Recibo,&
        	  lvs_Diretorio,&
  	    	  lvs_Log,&
		  lvs_titulo	   

Long    lvl_linha,&
        lvl_Coluna

Integer lvi_cd_tipo_recibo

Boolean lvb_Recibo
		  
lvl_linha          		= Tab_1.TabPage_1.dw_2.GetRow()
lvi_cd_tipo_recibo = Tab_1.TabPage_1.dw_2.Object.cd_tipo_recibo[lvl_linha]
lvs_titulo 			= Tab_1.TabPage_1.dw_2.Object.nr_titulo[lvl_linha]

If lvl_linha < 1 Then Return

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Para imprimir o recibo de cobran$$HEX1$$e700$$ENDHEX$$a selecionado $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que " + &
                     "somente o sistema de Retaguarda esteja operando agora. Portanto feche todas as " + &
							"janelas do caixa que eventualmente estejam ativas.",Exclamation!)
							
lvs_recibo = Trim(tab_1.tabpage_1.dw_2.Object.nr_recibo_cobranca[lvl_linha])

	// Recibo tipo cheque	
If (lvi_cd_tipo_recibo = ivi_recibo_cheque) Then

	lvb_Recibo = ivo_Controle_Caixa.of_imprime_recibo_cheque(lvs_recibo)
	
	// Recibo tipo T$$HEX1$$ed00$$ENDHEX$$tulo Credi$$HEX1$$e100$$ENDHEX$$rio e Conta-Corrente
ElseIf (lvi_cd_tipo_recibo = ivi_recibo_titulo_crediario) or &
  	    (lvi_cd_tipo_recibo = ivi_recibo_titulo_conta_corrente) Then

	lvb_Recibo = ivo_Controle_Caixa.of_imprime_recibo_titulo_cc_cr(lvs_recibo)

	// Recibo tipo T$$HEX1$$ed00$$ENDHEX$$tulo Conv$$HEX1$$ea00$$ENDHEX$$nio
ElseIf (lvi_cd_tipo_recibo = ivi_recibo_titulo_convenio) Then

	lvb_Recibo = ivo_Controle_Caixa.of_imprime_recibo_titulo_cv(lvs_recibo)
	
	// Recibo tipo Nota Fiscal	   	
ElseIf (lvi_cd_tipo_recibo = ivi_recibo_nf_convenio_problema) or & 
	    (lvi_cd_tipo_recibo = ivi_recibo_nf_convenio_parcial)  Then

  	lvb_Recibo = ivo_Controle_Caixa.of_imprime_recibo_nota(lvs_recibo)
   
	// Outros	
ElseIf (lvi_cd_tipo_recibo = ivi_recibo_outros) Then
	
	lvb_Recibo = ivo_Controle_Caixa.of_imprime_recibo_outros(lvs_recibo)	
	
	// Conv$$HEX1$$ea00$$ENDHEX$$nio por Conta
ElseIf (lvi_cd_tipo_recibo = ivi_recibo_convenio_conta) Then
	
	lvb_Recibo = ivo_Controle_Caixa.of_Imprime_recibo_cv_cc_conta(lvs_recibo,'CV')
	
	// Conta-Corrente por Conta
ElseIf (lvi_cd_tipo_recibo = ivi_recibo_conta_corrente_conta) Then
	
	lvb_Recibo = ivo_Controle_Caixa.of_Imprime_Recibo_cv_cc_conta(lvs_recibo,'CC')
		
End If

If lvb_Recibo Then
	PDV = Create uo_pdv	
	Sitef = Create uo_Sitef
	PDV.Of_Modo_Impressora()	
	
	If PDV.of_abreporta() Then
		
		If lvs_titulo = "VALECAIXA" Then
			PDV.of_emite_comprovante("",ivo_Controle_Caixa.is_dados_recibo)
		Else
			PDV.of_emite_comprovante("VIA RECIBO",ivo_Controle_Caixa.is_dados_recibo)			
		End If
		PDV.of_FechaPorta()
		
	End If

	Destroy(PDV)
	Destroy(Sitef)

End If

SetPointer(Arrow!)
end event

