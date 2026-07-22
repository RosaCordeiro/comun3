HA$PBExportHeader$w_ge181_relatorio_lancamento_conta.srw
forward
global type w_ge181_relatorio_lancamento_conta from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge181_relatorio_lancamento_conta from dc_w_selecao_lista_relatorio
integer width = 5499
integer height = 1988
string title = "GE181 - Relat$$HEX1$$f300$$ENDHEX$$rio de Lan$$HEX1$$e700$$ENDHEX$$amentos de Caixa por Conta"
boolean resizable = false
long backcolor = 80269524
end type
global w_ge181_relatorio_lancamento_conta w_ge181_relatorio_lancamento_conta

type variables
uo_filial ivo_filial

uo_conta_fluxo_caixa ivo_conta

date ivdt_inicio, &
        ivdt_termino
end variables

forward prototypes
public function boolean wf_verifica_filial_farmagora (long pl_filial_farmagora, ref long pl_filial, ref boolean pb_localizou)
end prototypes

public function boolean wf_verifica_filial_farmagora (long pl_filial_farmagora, ref long pl_filial, ref boolean pb_localizou);pb_localizou = False

Select cd_filial_contabil
 Into :pl_Filial
From cartao_estabelecimento
Where cd_administradora 	= 2
	and cd_filial					= :pl_filial_farmagora
	and id_situacao 			=	'A';
	
Choose Case SqlCa.SQlCode
	Case 0
		If (IsNull(pl_Filial) Or pl_Filial <=0 ) Then 
			pl_Filial = pl_Filial_Farmagora
		End If
		If pl_Filial <> pl_Filial_Farmagora Then
			pb_localizou = True
		End If
	Case 100
		pl_Filial	= pl_Filial_Farmagora
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao localizar a filial cont$$HEX1$$e100$$ENDHEX$$bil da filial[" + String(pl_Filial) + "] - na tabela cartao_estabelecimento.", StopSign!)
		Return False
End Choose

Return True
end function

on w_ge181_relatorio_lancamento_conta.create
call super::create
end on

on w_ge181_relatorio_lancamento_conta.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Object.dt_inicio		[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_termino	[1] = RelativeDate(Today(),-1)
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Conta)
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;ivo_Filial = Create uo_Filial
ivo_Conta  = Create uo_Conta_Fluxo_Caixa

MaxHeight = 9999
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge181_relatorio_lancamento_conta
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge181_relatorio_lancamento_conta
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge181_relatorio_lancamento_conta
integer x = 14
integer y = 488
integer width = 5449
integer height = 1328
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge181_relatorio_lancamento_conta
integer x = 14
integer y = 0
integer width = 1778
integer height = 484
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge181_relatorio_lancamento_conta
integer x = 32
integer y = 56
integer width = 1751
integer height = 416
string dataobject = "dw_ge181_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If

	Case "de_conta"
		If Data <> ivo_Conta.De_Conta_Fluxo_Caixa Then
			Return 1
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia	
End If

If IsValid(ivo_Conta)  Then
	This.Object.De_Conta[1] = ivo_Conta.De_Conta_Fluxo_Caixa
	This.Object.Cd_Conta[1] = ivo_Conta.Cd_Conta_Fluxo_Caixa	
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia	
			End If
			
		Case "de_conta"
			ivo_Conta.of_Localiza_Conta(This.GetText())
			
			If ivo_Conta.Localizado Then
				This.Object.De_Conta[1] = ivo_Conta.De_Conta_Fluxo_Caixa
				This.Object.Cd_Conta[1] = ivo_Conta.Cd_Conta_Fluxo_Caixa	
			End If
		
	End Choose
	
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge181_relatorio_lancamento_conta
integer x = 41
integer y = 556
integer width = 5403
integer height = 1240
string dataobject = "dw_ge181_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Boolean lvb_Localizou = False

Long 	lvl_Filial, &
	  	lvl_Conta, &
		lvl_Filial_Farma

String lvs_Estorno, &
		lvs_Considera_Cx, &
		lvs_somente_ecommerce, &
		lvs_dw, &
		lvs_dw_relatorio

dw_1.AcceptText()

lvl_Filial   			= dw_1.Object.Cd_Filial [1]
ivdt_Inicio  			= dw_1.Object.Dt_Inicio [1]
ivdt_Termino 		= dw_1.Object.Dt_Termino[1]
lvs_Estorno  		= dw_1.Object.id_estorno[1]
lvl_Conta	 			= dw_1.Object.Cd_Conta[1]
lvs_Considera_Cx	= dw_1.Object.Id_Considera_Cx_Geral[1]
lvs_somente_ecommerce = dw_1.Object.Id_ecommerce[1]

lvs_dw 			  = 'dw_ge181_lista'
lvs_dw_relatorio = 'dw_ge181_relatorio'

If lvs_somente_ecommerce = 'E' Then
	lvs_dw 				+= '_ecommerce'
	lvs_dw_relatorio	+= '_ecommerce'
End If
If lvs_somente_ecommerce = 'N' Then
	lvs_dw 				+= '_sem_ecommerce'
	lvs_dw_relatorio	+= '_sem_ecommerce'
End If

This.of_ChangeDataObject(lvs_dw)
dw_3.of_ChangeDataObject(lvs_dw_relatorio)
This.of_setRowSelection() 
This.ShareData(dw_3)

If Not IsDate(String(ivdt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(String(ivdt_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	
	If wf_Verifica_Filial_Farmagora(lvl_Filial, ref lvl_Filial_Farma, ref lvb_Localizou) Then
		
		This.of_AppendWhere_SubQuery("x.cd_filial = " + String(lvl_Filial_Farma), 2)
		
		If lvb_Localizou Then
			This.of_AppendWhere("l.de_historico = '%*' ")
		End If		
	End If
End If

If IsNull(lvl_Conta) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a conta.", Exclamation!)
	dw_1.Event ue_Pos(1, "de_conta")
	Return -1
End If

This.of_AppendWhere_SubQuery("l.cd_conta_fluxo_caixa = " + String(lvl_Conta), 2)

If lvs_Considera_Cx = 'N' Then
	This.of_AppendWhere_SubQuery(("x.id_caixa_geral = 'N'"), 2)
End If

If lvs_estorno <> 'T' Then
	This.of_AppendWhere_SubQuery(("l.id_estorno = '" + lvs_estorno + "'"), 2)
End If

Return 1
end event

event dw_2::ue_recuperar;//Override

Return This.Retrieve(ivdt_inicio,ivdt_termino)
end event

event dw_2::constructor;call super::constructor;String	lvs_Coluna[], &
		lvs_Nome[]
		 
lvs_Coluna = {"cd_caixa", "cd_filial", "nm_fantasia", "dh_movimentacao_caixa", "vl_lancamento", "id_estorno","nr_controle_caixa","de_historico", "vl_liquido"}

lvs_Nome = {"Caixa", "Filial", "Nome Fantasia", "Data", "Valor", "Estorno", "Controle Caixa", "Hist$$HEX1$$f300$$ENDHEX$$rico", "Valor L$$HEX1$$ed00$$ENDHEX$$quido"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.SetFocus()
End If

ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;ivm_Menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge181_relatorio_lancamento_conta
integer x = 2629
integer y = 16
integer height = 280
string dataobject = "dw_ge181_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;dw_1.AcceptText()

dw_3.Object.Periodo.Text = String(ivdt_inicio, "DD/MM/YYYY") + " $$HEX1$$e000$$ENDHEX$$ " + &
                           String(ivdt_termino, "DD/MM/YYYY")

dw_3.Object.Conta.Text = String(dw_1.Object.de_conta[1]) + " (" + String(dw_1.Object.cd_conta[1]) + ")" 

Return AncestorReturnValue
end event

