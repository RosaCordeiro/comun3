HA$PBExportHeader$w_ge307_relatorio_recarga_online.srw
forward
global type w_ge307_relatorio_recarga_online from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge307_relatorio_recarga_online from dc_w_selecao_lista_relatorio
string tag = "w_ge307_relatorio_recarga_online"
string accessiblename = "Relat$$HEX1$$f300$$ENDHEX$$rio Recarga de Celular OnLine (GE307)"
integer x = 407
integer y = 248
integer width = 2939
integer height = 1988
string title = "GE307 - Acompanhamento de Vendas: Recarga Celular ON-LINE"
boolean minbox = false
boolean resizable = false
long backcolor = 80269524
end type
global w_ge307_relatorio_recarga_online w_ge307_relatorio_recarga_online

type variables
uo_filial ivo_filial
end variables

forward prototypes
public subroutine wf_atualiza_filial ()
public subroutine wf_insere_default ()
end prototypes

public subroutine wf_atualiza_filial ();dw_1.Object.Cd_Filial[1]   = ivo_Filial.Cd_Filial
dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
end subroutine

public subroutine wf_insere_default ();Integer li_Linha

DataWindowChild lvdwc

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	li_Linha = lvdwc.InsertRow(1)
	
	lvdwc.SetItem(li_Linha, "cd_unidade_federacao", "00")
	lvdwc.SetItem(li_Linha, "nm_unidade_federacao"  , "TODAS")
	
	dw_1.Object.cd_uf[1] = "00"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild U.F.", StopSign!)
End If

If dw_1.GetChild('nm_operadora', lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	lvdwc.SetItem(1,"nm_operadora","TODAS")
	
	dw_1.object.nm_operadora[1] = 'TODAS'
Else
	MessageBox("Erro","Erro no GetChild Operadora.")
End If
end subroutine

on w_ge307_relatorio_recarga_online.create
call super::create
end on

on w_ge307_relatorio_recarga_online.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;wf_insere_default()

dw_1.Object.Dt_Inicio 	[1] = gf_primeiro_dia_mes(Today())
dw_1.Object.Dt_Termino	[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_preopen;call super::ue_preopen;ivo_Filial = Create uo_Filial
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge307_relatorio_recarga_online
integer x = 18
integer y = 516
integer width = 2885
integer height = 1296
integer taborder = 0
integer weight = 700
string text = "Lista Recargas"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge307_relatorio_recarga_online
integer x = 23
integer y = 4
integer width = 1710
integer height = 500
integer taborder = 0
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge307_relatorio_recarga_online
integer x = 41
integer y = 60
integer width = 1646
integer height = 424
integer taborder = 10
string dataobject = "dw_ge307_selecao"
end type

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_fantasia" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		wf_Atualiza_Filial()
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Filial

If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		lvs_Filial = This.GetText()
		
		ivo_Filial.of_Localiza_Filial(lvs_Filial)
		
		If ivo_Filial.Localizada Then
			wf_Atualiza_Filial()
		End If
	End If
End If
end event

event dw_1::getfocus;call super::getfocus;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge307_relatorio_recarga_online
integer x = 46
integer y = 584
integer width = 2825
integer height = 1216
integer taborder = 20
string dataobject = "dw_ge307_lista_detalhe"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//override
Date    	lvdt_Inicio,&
        		lvdt_Termino
	  		  
dw_1.AcceptText()

lvdt_Inicio  		= dw_1.Object.dt_inicio 				[1]
lvdt_Termino 	= dw_1.Object.dt_termino			[1]

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::constructor;call super::constructor;This.Of_SetRowselection( )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(This.RowCount() > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date    	lvdt_Inicio,&
        		lvdt_Termino
	  
Long    lvl_Filial
	  
Integer 	lvi_Retorno,&
        		lvi_Row

String ls_UF		  
		  
String  	lvs_Apres,&
        		lvs_Operadora, &
			lvs_Conciliado = 'T'
		  
DataWindowChild dw_operadora
		  
dw_1.AcceptText()

lvi_Retorno = dw_1.GetChild('nm_operadora', dw_operadora)

If lvi_Retorno = -1 Then MessageBox("Erro","Erro no GetChild.")

lvs_Operadora = dw_operadora.GetItemString(dw_operadora.GetRow(),"nm_operadora")
	  
lvdt_Inicio  		= dw_1.Object.dt_inicio 				[1]
lvdt_Termino 	= dw_1.Object.dt_termino			[1]
lvs_Conciliado 	= dw_1.Object.Id_Conciliado		[1]
lvl_Filial   		= dw_1.Object.cd_filial 				[1]
lvs_Apres    		= dw_1.Object.id_apresentacao	[1]
ls_UF				= dw_1.Object.cd_uf					[1]

Choose Case lvs_Apres
	Case 'D'	// Detalhado
		dw_2.of_ChangeDataObject('dw_ge307_lista_detalhe')
		dw_3.of_ChangeDataObject('dw_ge307_relatorio_detalhe')
		
	Case 'R' // Resumido
		dw_2.of_ChangeDataObject('dw_ge307_lista_resumo')
		dw_3.of_ChangeDataObject('dw_ge307_relatorio_resumo')
		
	Case Else // Normal
		dw_2.of_ChangeDataObject('dw_ge307_lista')
		dw_3.of_ChangeDataObject('dw_ge307_relatorio')
		
End Choose
This.Of_SetRowSelection()

This.ShareData(dw_3)

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

If lvs_Operadora <> 'TODAS' Then
	dw_2.of_AppendWhere("de_concessionaria = '" + lvs_Operadora + "'" )
End If

If lvs_Conciliado <> 'T' Then
	dw_2.of_AppendWhere("rc.id_conciliada = '" + lvs_Conciliado + "'" )
End If

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	dw_2.of_AppendWhere("rc.cd_filial = " + String(lvl_Filial))
End If

//UF
If ls_UF <> "00" Then
	dw_2.of_AppendWhere("rc.cd_filial in ( select f.cd_filial from filial f inner join cidade c on c.cd_cidade = f.cd_cidade 	where c.cd_unidade_federacao = '" + ls_UF + "' )" )
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge307_relatorio_recarga_online
integer x = 2514
integer y = 340
integer width = 389
integer height = 100
integer taborder = 0
string dataobject = "dw_ge307_relatorio_detalhe"
boolean vscrollbar = false
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino
	  
lvdt_Inicio		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

This.Object.Periodo_t.Text = 	String(lvdt_Inicio , "dd/mm/yyyy") + "  $$HEX1$$e000$$ENDHEX$$ " + &
                             				String(lvdt_Termino, "dd/mm/yyyy")

Return AncestorReturnValue
end event

event dw_3::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

