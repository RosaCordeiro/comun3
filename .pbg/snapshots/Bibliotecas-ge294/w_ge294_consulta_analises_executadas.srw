HA$PBExportHeader$w_ge294_consulta_analises_executadas.srw
forward
global type w_ge294_consulta_analises_executadas from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge294_consulta_analises_executadas from dc_w_selecao_lista_relatorio
string tag = "w_ge294_consulta_analises_executadas"
integer width = 4229
integer height = 1836
string title = "GE294 - Consulta Revis$$HEX1$$f500$$ENDHEX$$es de An$$HEX1$$e100$$ENDHEX$$lises"
end type
global w_ge294_consulta_analises_executadas w_ge294_consulta_analises_executadas

type variables
uo_filial ivo_filial
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

Long lvl_Regiao

If dw_1.GetChild("cd_regiao", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_regiao",0)
	ldw_Child.SetItem(1,"de_regiao","TODAS")
	
	dw_1.Object.cd_regiao[1] = 0
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	dw_1.Object.cd_regiao[1] = lvl_Regiao
Else
	dw_1.Object.cd_regiao[1] = 0	
End If

// Coloca o item TODAS
If dw_1.GetChild("cd_metrica", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_metrica",0)
	ldw_Child.SetItem(1,"de_metrica","TODAS")
	ldw_Child.SetItem(1,"cd_setor","GE")
	If gvo_aplicacao.ivo_seguranca.cd_sistema <> 'DI' Then
		ldw_Child.SetFilter("cd_setor=String('GE') or cd_setor=String('"+gvo_aplicacao.ivo_seguranca.cd_sistema+"')")
		ldw_Child.Filter()
	End If

	dw_1.Object.cd_metrica[1] = 0
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna an$$HEX1$$e100$$ENDHEX$$lise.", StopSign!)
End If
end subroutine

on w_ge294_consulta_analises_executadas.create
call super::create
end on

on w_ge294_consulta_analises_executadas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_filial = Create uo_filial

MaxWidth = 4250
MaxHeight = 9999
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-7)
dw_1.Object.dt_fim	[1] = Today()

wf_insere_padrao()
end event

event close;call super::close;Destroy(ivo_filial)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge294_consulta_analises_executadas
integer x = 3515
integer y = 88
integer width = 613
integer height = 144
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge294_consulta_analises_executadas
integer x = 3488
integer y = 24
integer width = 681
integer height = 232
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge294_consulta_analises_executadas
string tag = "w_ge294_cosulta_analises_executadas"
integer y = 380
integer width = 4123
integer height = 1244
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge294_consulta_analises_executadas
integer width = 3086
integer height = 348
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge294_consulta_analises_executadas
integer width = 3008
integer height = 232
string dataobject = "dw_ge294_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_setcolselection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'nm_filial' 
		If Data <> ivo_filial.nm_fantasia Then
			If Data <> '' Then
				Return 1
			Else				
				ivo_filial.of_inicializa( )
				This.Object.Cd_Filial	[Row] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial	[Row] = ivo_Filial.Nm_Fantasia
			End If
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid( ivo_Filial ) Then
	If ivo_Filial.Cd_Filial <> This.Object.Cd_Filial[ 1 ] Then
		This.Object.Nm_Filial	[ 1 ] = ivo_Filial.Nm_Fantasia
		This.Object.Cd_Filial	[ 1 ] = ivo_Filial.Cd_Filial
	End If
End If

end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial( This.GetText( ) )
				
			If Not ivo_Filial.Localizada Then
				ivo_Filial.of_Inicializa( )
			End If
			
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge294_consulta_analises_executadas
integer y = 452
integer width = 4069
integer height = 1144
string dataobject = "dw_ge294_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//overrride
Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_1.AcceptText( )
lvdh_Inicio	= Datetime(dw_1.Object.dt_inicio	[1], Time('00:00:00'))
lvdh_Fim		= Datetime(dw_1.Object.dt_fim	[1], Time('23:59:59'))

Return This.Retrieve(lvdh_Inicio,lvdh_Fim)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Revisao

Long lvl_Regiao
Long lvl_Metrica
Long lvl_Filial

dw_1.Accepttext( )
lvs_Revisao	= dw_1.Object.id_revisao	[1]
lvl_Regiao	= dw_1.Object.cd_regiao	[1]
lvl_Metrica	= dw_1.Object.cd_metrica	[1]
lvl_Filial		= dw_1.Object.cd_filial		[1]

// Verifica se no filtro o valor preenchido $$HEX1$$e900$$ENDHEX$$ diferente de TODOS
If lvs_Revisao <> 'T' Then
	Choose Case lvs_Revisao
		Case 'A', 'C', 'S', 'N', 'I'
			// Insere filtro no SQL
			This.Of_Appendwhere("coalesce(a.id_revisado,'N') = '"+lvs_Revisao+"'")
		Case 'R'
			// Insere filtro no SQL
			This.Of_Appendwhere("coalesce(a.id_revisado,'N') in ('C','S')")
		Case 'F'
			// Insere filtro no SQL
			This.Of_Appendwhere("coalesce(a.id_revisado,'N') not in ('C','S')")
	End Choose
	
	// Insere texto do filtro no relat$$HEX1$$f300$$ENDHEX$$rio
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Situa$$HEX2$$e700e300$$ENDHEX$$o: '+dw_1.Describe("Evaluate('LookUpDisplay(id_revisao)',1)")
End If

If lvl_Regiao > 0 Then
	This.of_appendwhere("f.cd_regiao = "+String(lvl_Regiao))
End If

if lvl_Filial > 0 Then
	This.of_appendwhere("a.cd_filial = "+String(lvl_Filial))
End If

If lvl_Metrica > 0 Then
	This.of_appendwhere("a.cd_metrica = "+String(lvl_Metrica))
End If

If gvo_aplicacao.ivo_seguranca.cd_sistema <> 'DI' Then
	This.of_appendwhere("((m.cd_setor = '"+gvo_aplicacao.ivo_seguranca.cd_sistema+"') or (m.cd_setor = 'GE'))")
End If

Return AncestorReturnValue
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Datetime lvdh_Revisao

If CurrentRow > 0 Then
	This.Object.de_revisao_footer.Text	= This.Object.de_revisao			[CurrentRow]
	This.Object.nm_usuario_footer.Text	= This.Object.nm_usuario_revisao	[CurrentRow] + ' ('+String(This.Object.nr_matricula_revisao	[CurrentRow])+')'
	lvdh_Revisao								= This.Object.dh_revisao			[CurrentRow]
	If (Not IsNull(lvdh_Revisao)) and (lvdh_Revisao > Datetime('2015/01/01')) Then
		This.Object.dh_revisao_footer.Text	= String(lvdh_Revisao,'dd/mm/yyyy hh:mm')
	Else
		This.Object.dh_revisao_footer.Text	= ''
	End If
Else 
	This.Object.de_revisao_footer.Text 	= ''
	This.Object.nm_usuario_footer.Text	= ''
	This.Object.dh_revisao_footer.Text	= ''
End If
end event

event dw_2::ue_reset;call super::ue_reset;This.Object.de_revisao_footer.Text = ''
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_menu.mf_SalvarComo(pl_linhas > 0)

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge294_consulta_analises_executadas
integer x = 3616
integer y = 44
integer height = 260
end type

