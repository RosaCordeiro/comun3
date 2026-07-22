HA$PBExportHeader$w_ge062_consulta_mapa_resumo.srw
forward
global type w_ge062_consulta_mapa_resumo from dc_w_selecao_lista_detalhe
end type
type cb_imprime_mapa from commandbutton within w_ge062_consulta_mapa_resumo
end type
type dw_5 from dc_uo_dw_base within w_ge062_consulta_mapa_resumo
end type
type dw_6 from dc_uo_dw_base within w_ge062_consulta_mapa_resumo
end type
type cb_pendencia from commandbutton within w_ge062_consulta_mapa_resumo
end type
type dw_4 from dc_uo_dw_base within w_ge062_consulta_mapa_resumo
end type
type cb_autentica from commandbutton within w_ge062_consulta_mapa_resumo
end type
type gb_4 from groupbox within w_ge062_consulta_mapa_resumo
end type
end forward

global type w_ge062_consulta_mapa_resumo from dc_w_selecao_lista_detalhe
string accessiblename = "Consulta Mapa Resumo (GE062)"
integer width = 4334
integer height = 1992
string title = "GE062 - Consulta Mapa Resumo"
cb_imprime_mapa cb_imprime_mapa
dw_5 dw_5
dw_6 dw_6
cb_pendencia cb_pendencia
dw_4 dw_4
cb_autentica cb_autentica
gb_4 gb_4
end type
global w_ge062_consulta_mapa_resumo w_ge062_consulta_mapa_resumo

type variables
uo_filial       ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
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

on w_ge062_consulta_mapa_resumo.create
int iCurrent
call super::create
this.cb_imprime_mapa=create cb_imprime_mapa
this.dw_5=create dw_5
this.dw_6=create dw_6
this.cb_pendencia=create cb_pendencia
this.dw_4=create dw_4
this.cb_autentica=create cb_autentica
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprime_mapa
this.Control[iCurrent+2]=this.dw_5
this.Control[iCurrent+3]=this.dw_6
this.Control[iCurrent+4]=this.cb_pendencia
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.cb_autentica
this.Control[iCurrent+7]=this.gb_4
end on

on w_ge062_consulta_mapa_resumo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_imprime_mapa)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.cb_pendencia)
destroy(this.dw_4)
destroy(this.cb_autentica)
destroy(this.gb_4)
end on

event ue_postopen;call super::ue_postopen;dw_1.SetReDraw(False)

ivo_filial = Create uo_filial

IF gvo_parametro.cd_filial <> gvo_parametro.cd_filial_matriz THEN
	dw_1.Object.cd_filial[1] = gvo_parametro.cd_filial
	dw_1.Object.de_filial[1] = gvo_parametro.nm_fantasia_filial
	dw_1.Object.de_filial.protect = 1

	ivo_filial.cd_filial  		= dw_1.Object.cd_filial	[1]
	ivo_filial.nm_fantasia	= dw_1.Object.de_filial	[1]
END IF

dw_1.Object.dt_inicio[1] = gvo_parametro.Of_dh_Movimentacao()
dw_1.Object.dt_final [1] = dw_1.Object.dt_inicio[1]

This.ivm_Menu.ivb_Permite_Imprimir = True

dw_5.Visible = False
dw_6.Visible = False

dw_1.SetReDraw(True)


end event

event close;call super::close;If IsValid(ivo_filial) Then DESTROY(ivo_filial)
end event

event ue_printimmediate;Long	lvl_linha				, &
		lvl_Row				, &
		lvl_row_aliquota	, &
		lvl_filial				, &
		lvl_mapa  			, &
		lvl_nr_mapa_ativo	, &	
		lvl_ecf

String lvs_especie , &
		 lvs_serie

Open(w_ge033_prepara_impressora)

SetPointer(HourGlass!)

dw_6.Reset()

lvl_nr_mapa_ativo = dw_2.Object.nr_mapa[dw_2.GetRow()]

FOR lvl_linha=1 TO dw_2.RowCount()

	If lvl_nr_mapa_ativo = dw_2.Object.nr_mapa[lvl_linha] Then

		dw_6.Object.dh_data.text 		= String(dw_2.Object.dh_emissao[lvl_linha],"dd/mm/yyyy")
		dw_6.Object.endereco.text 		= dw_2.Object.de_endereco		 [lvl_linha] + ', ' + &
											  	    dw_2.Object.de_bairro			 [lvl_linha]
		dw_6.Object.cidade.text 			= dw_2.Object.nm_cidade			 [lvl_linha]
		dw_6.Object.uf.text 				= dw_2.Object.cd_unidade_federacao	[lvl_linha]
		dw_6.Object.cgc.text 				= gf_colocar_mascara_cgc(dw_2.Object.nr_cgc[lvl_linha])
		dw_6.Object.insc_estadual.text	= dw_2.Object.nr_inscricao_estadual	[lvl_linha]
		dw_6.Object.filial.text 			= dw_2.Object.filial_nm_fantasia		[lvl_linha] + ' (' + &
											 			String(dw_2.Object.mapa_resumo_cd_filial[lvl_linha]) + ')'

		lvl_Row = dw_6.Event ue_AddRow()

		dw_6.Object.nr_mapa		[lvl_Row] = lvl_nr_mapa_ativo
		dw_6.Object.nr_ecf			[lvl_Row] = dw_2.Object.nr_ecf				 	[lvl_linha]
		dw_6.Object.nr_cf_inicial	[lvl_Row] = dw_2.Object.nr_operacao_inicial	[lvl_linha]
		dw_6.Object.nr_cf_final		[lvl_Row] = dw_2.Object.nr_operacao_final		[lvl_linha]
		dw_6.Object.gt_inicial		[lvl_Row] = dw_2.Object.vl_total_geral_inicial	[lvl_linha]
		dw_6.Object.gt_final			[lvl_Row] = dw_2.Object.vl_total_geral_final	[lvl_linha]
		dw_6.Object.cancelamentos	[lvl_Row] = dw_2.Object.vl_cancelamento		[lvl_linha]
		dw_6.Object.descontos		[lvl_Row] = dw_2.Object.vl_desconto			 	[lvl_linha]
		dw_6.Object.contabil			[lvl_Row] = dw_2.Object.vl_contabil			 	[lvl_linha]
		dw_6.Object.isento			[lvl_Row] = dw_2.Object.vl_isenta			 		[lvl_linha]
//		dw_6.Object.nao_incidencia	[lvl_Row] = dw_2.Object.vl_nao_incidencia	 	[lvl_linha]
		dw_6.Object.nao_incidencia	[lvl_Row] = dw_2.Object.vl_st				 		[lvl_linha]
		dw_6.Object.st					[lvl_Row] = dw_2.Object.vl_st				 		[lvl_linha]
		dw_6.Object.reducao_z		[lvl_Row] = dw_2.Object.qt_reducao_z			[lvl_linha]


		lvl_filial		= dw_2.Object.cd_filial		[lvl_Linha]
		lvl_mapa		= dw_2.Object.nr_mapa		[lvl_Linha]
		lvl_ecf		= dw_2.Object.nr_ecf			[lvl_Linha]
		lvs_especie	= dw_2.Object.de_especie	[lvl_Linha]
		lvs_serie		= dw_2.Object.de_serie		[lvl_Linha]

		lvl_row_aliquota = dw_5.Retrieve(lvl_filial,lvl_mapa,lvs_especie,lvs_serie,lvl_ecf)

		FOR lvl_row_aliquota = 1 TO dw_5.RowCount()

			If lvl_row_aliquota = 1 Then
				
				dw_6.Object.nr_ecf			[lvl_Row] = dw_2.Object.nr_ecf				[lvl_linha]
				dw_6.Object.base_calculo	[lvl_Row] = dw_5.Object.vl_base_calculo	[1]
				dw_6.Object.vl_imposto		[lvl_Row] = dw_5.Object.vl_icms				[1]
				dw_6.Object.pc_aliquota		[lvl_Row] = dw_5.Object.pc_aliquota			[1]

			Else

				lvl_Row = dw_6.Event ue_AddRow()

				dw_6.Object.nr_ecf			[lvl_Row] = dw_2.Object.nr_ecf 				[lvl_linha]
				dw_6.Object.base_calculo	[lvl_Row] = dw_5.Object.vl_base_calculo	[lvl_row_aliquota]
				dw_6.Object.vl_imposto		[lvl_Row] = dw_5.Object.vl_icms				[lvl_row_aliquota]
				dw_6.Object.pc_aliquota		[lvl_Row] = dw_5.Object.pc_aliquota			[lvl_row_aliquota]

			End If

		Next
		
	End If

NEXT

dw_6.GroupCalc()
dw_6.Print(True)

end event

event ue_preopen;call super::ue_preopen;MaxWidth	= 4400
MaxHeight	= 9999
end event

event resize;call super::resize;gb_2.Height	= Newheight - gb_2.Y - gb_3.Height - 72
dw_2.Height	= gb_2.Height - 70
gb_2.Width	= NewWidth - gb_2.X - 50
dw_2.Width	= gb_2.Width - 60

gb_3.Y	= Newheight - gb_3.Height - 25
dw_3.Y	= gb_3.Y + 60
gb_3.Width	= NewWidth - gb_3.X - 50
dw_3.Width	= gb_3.Width - 60

gb_4.Y	= gb_3.Y
dw_4.Y	= dw_3.Y
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge062_consulta_mapa_resumo
integer x = 4256
integer y = 968
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge062_consulta_mapa_resumo
integer x = 4219
integer y = 896
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge062_consulta_mapa_resumo
integer x = 855
integer y = 1436
integer width = 2747
integer height = 356
string text = "Al$$HEX1$$ed00$$ENDHEX$$quotas de ICMS"
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge062_consulta_mapa_resumo
integer x = 18
integer y = 12
integer width = 2523
integer height = 264
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge062_consulta_mapa_resumo
integer x = 14
integer y = 280
integer width = 4256
integer height = 1144
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge062_consulta_mapa_resumo
integer x = 41
integer y = 76
integer width = 2473
integer height = 188
string dataobject = "dw_ge062_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;//
LONG	ll_nulo
//
SETNULL(ll_nulo)
//

Choose case dwo.name 
	Case "de_filial"	
		//
		IF Data = "" OR ISNULL(Data) THEN
			THIS.Object.cd_filial[1] = ll_nulo
			ivo_filial.nm_fantasia 	 = ''
			RETURN 0
		END IF		
		//
		IF Data <> ivo_filial.nm_fantasia THEN RETURN 1
		//
End Choose

end event

event dw_1::losefocus;call super::losefocus;IF IsValid(ivo_filial) THEN
	dw_1.Object.De_filial[1] = ivo_filial.nm_fantasia
END IF
//
end event

event dw_1::ue_key;call super::ue_key;//
STRING	lvs_Coluna
//
IF Key = KeyEnter! THEN
	//
	lvs_Coluna = THIS.GetColumnName()
	//	
	IF lvs_Coluna = "de_filial" THEN
		//
		WF_Localiza_Filial()
	END IF
	//
END IF
//
end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge062_consulta_mapa_resumo
integer x = 50
integer y = 332
integer width = 4206
integer height = 1072
string dataobject = "dw_ge062_lista"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date lvdt_Inicial				, &
     lvdt_final
//
long lvl_cd_filial 			, &
	  lvl_nr_mapa_inicial	, &
	  lvl_nr_mapa_final	 	, &
	  lvl_nr_ecf
//
dw_1.AcceptText()	
//
lvdt_Inicial  				= dw_1.Object.dt_inicio			[1]
lvdt_final    				= dw_1.Object.dt_final			[1]
lvl_cd_filial 				= dw_1.Object.cd_filial			[1]
lvl_nr_mapa_inicial	= dw_1.Object.nr_mapa_de 	[1]
lvl_nr_mapa_final 		= dw_1.Object.nr_mapa_ate	[1]
lvl_nr_ecf				= dw_1.Object.nr_ecf				[1]
//
If IsNull(lvdt_Inicial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o per$$HEX1$$ed00$$ENDHEX$$odo inicial.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return 0
End If
//
If IsNull(lvdt_final) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o per$$HEX1$$ed00$$ENDHEX$$odo final.", Information!)
	dw_1.Event ue_Pos(1, "dt_final")	
	Return 0
End If

If lvdt_Inicial > lvdt_final Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo final deve ser maior que o per$$HEX1$$ed00$$ENDHEX$$odo inicial.", Information!)
	dw_1.Event ue_Pos(1, "dt_final")	
	Return 0
End If
//
This.of_AppendWhere("mapa_resumo.dh_emissao between " + " '" 			+ &
       						String(lvdt_inicial,"yyyymmdd") + "' and '" 	+ &
								String(lvdt_final  ,"yyyymmdd") + "'" )

// Se for na matriz
If gvo_parametro.Of_filial() = gvo_parametro.Of_filial_matriz() Then
	If Not IsNull(lvl_cd_filial) Then
		This.of_AppendWhere("mapa_resumo.cd_filial = " + String(lvl_cd_filial))
	End If
End If
//
If Not IsNull(lvl_nr_mapa_inicial) Then 
	//
	This.of_AppendWhere("mapa_resumo.nr_mapa >= " + String(lvl_nr_mapa_inicial))
	//
End If
//
If Not IsNull(lvl_nr_mapa_final) Then 
	This.of_AppendWhere("mapa_resumo.nr_mapa <= " + String(lvl_nr_mapa_final))
End If

If Not IsNull(lvl_nr_ecf) Then 
	This.of_AppendWhere("mapa_resumo_ecf.nr_ecf = " + String(lvl_nr_ecf))
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;String ls_autenticar
If ancestorReturnValue > 0 Then
	If gvo_parametro.Of_filial() <> gvo_parametro.Of_filial_matriz() THEN
		cb_imprime_mapa.Enabled = True
		
		uo_Parametro_Filial lvo_Parametro
		lvo_Parametro = Create uo_Parametro_Filial
		lvo_Parametro.of_Localiza_Parametro("ID_AUTENTICA_DOCUMENTO", ref ls_autenticar, False)
		Destroy(lvo_Parametro)		
		
		If Upper(Trim(ls_autenticar)) = 'S' Then
			cb_autentica.Visible = True
		Else
			cb_autentica.Visible = False
		End If
	End If
End If

Return ancestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge062_consulta_mapa_resumo
integer x = 878
integer y = 1496
integer width = 2693
integer height = 264
integer taborder = 100
boolean enabled = false
string dataobject = "dw_ge062_aliq"
boolean vscrollbar = true
end type

event dw_3::ue_preretrieve;call super::ue_preretrieve;//
If dw_2.RowCount() > 0 Then Return 1
//
Return 0

end event

event dw_3::ue_recuperar;// OVERRIDE
Long 	lvl_filial	, &
	 	lvl_mapa  	, &
		lvl_ecf     , &
		lvl_Reg     , &
		lvl_Linhas  , &
		lvl_Aliquota, &
		lvl_Row

String lvs_especie, &
		 lvs_serie

Decimal lvdc_Vl_Base, &
        lvdc_Vl_Icms

lvl_Linhas = dw_2.GetRow() 

If lvl_Linhas = 0 Then Return 0

lvl_filial		= dw_2.Object.cd_filial		[lvl_Linhas]
lvl_mapa  	= dw_2.Object.nr_mapa		[lvl_Linhas]
lvl_ecf  		= dw_2.Object.nr_ecf			[lvl_Linhas]
lvs_especie	= dw_2.Object.de_especie	[lvl_Linhas]
lvs_serie		= dw_2.Object.de_serie		[lvl_Linhas]

This.Retrieve(lvl_filial,lvl_mapa,lvl_ecf,lvs_especie,lvs_serie)
/*dw_5.Retrieve(lvl_filial,lvl_mapa,lvs_especie,lvs_serie,lvl_ecf)

lvl_Reg = dw_5.RowCount()

If lvl_Reg > 0 Then
	//
	This.SetReDraw(False)
	This.Reset()
	This.InsertRow(0)
	//
	For lvl_Row=1 To lvl_Reg
		//
		lvl_Aliquota		= dw_5.object.pc_aliquota		[lvl_row]
		lvdc_Vl_Base	= dw_5.object.vl_base_calculo	[lvl_row]
		lvdc_Vl_Icms	= dw_5.object.vl_icms			[lvl_row]
		//
		Choose Case lvl_Aliquota
			Case 7	
				This.Object.vl_base_icm07   	[1] = lvdc_Vl_Base
				This.Object.vl_imposto_icm07	[1] = lvdc_Vl_Icms
			Case 12
				This.Object.vl_base_icm12   	[1] = lvdc_Vl_Base
				This.Object.vl_imposto_icm12	[1] = lvdc_Vl_Icms
			Case 17
				This.Object.vl_base_icm17   	[1] = lvdc_Vl_Base
				This.Object.vl_imposto_icm17	[1] = lvdc_Vl_Icms
			Case 18
				This.Object.vl_base_icm18   	[1] = lvdc_Vl_Base
				This.Object.vl_imposto_icm18	[1] = lvdc_Vl_Icms
			Case 25
				This.Object.vl_base_icm25   	[1] = lvdc_Vl_Base
				This.Object.vl_imposto_icm25	[1] = lvdc_Vl_Icms
		End Choose
		//
	Next
	//
	This.SetReDraw(True)
	//
Else
	//
	This.Object.vl_base_icm07   	[1] = 0
	This.Object.vl_imposto_icm07	[1] = 0
	This.Object.vl_base_icm12   	[1] = 0
	This.Object.vl_imposto_icm12	[1] = 0
	This.Object.vl_base_icm17   	[1] = 0
	This.Object.vl_imposto_icm17	[1] = 0
	This.Object.vl_base_icm18   	[1] = 0
	This.Object.vl_imposto_icm18	[1] = 0
	This.Object.vl_base_icm25  		[1] = 0
	This.Object.vl_imposto_icm25	[1] = 0
	//
End If*/

dw_4.Reset()
dw_4.InsertRow(0)
dw_4.object.vl_isentas      		[1] = dw_2.object.vl_isenta        [lvl_Linhas]
dw_4.object.vl_n_tributaveis	[1] = dw_2.object.vl_nao_incidencia[lvl_Linhas]

Return 1
end event

type cb_imprime_mapa from commandbutton within w_ge062_consulta_mapa_resumo
boolean visible = false
integer x = 3346
integer y = 176
integer width = 558
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imprime Mapa"
end type

event clicked;Long lvl_linha				, &
	  lvl_linha_inclusa	, &
	  lvl_linha_aliquota	, &
	  lvl_filial			, &
 	  lvl_mapa  			, &
	  lvl_nr_mapa_ativo	, &	
	  lvl_ecf
//
String lvs_especie , &
		 lvs_serie
//
OPEN(w_ge033_prepara_impressora)
//
SetPointer(HourGlass!)
//
dw_6.Reset()
//
lvl_nr_mapa_ativo = dw_2.Object.nr_mapa[dw_2.GetRow()]
//
FOR lvl_linha=1 TO dw_2.RowCount()
	//
	If lvl_nr_mapa_ativo = dw_2.Object.nr_mapa[lvl_linha] Then
		//
		dw_6.Object.dh_data.text 			= String(dw_2.Object.dh_emissao			[lvl_linha],"dd/mm/yyyy")
		dw_6.Object.endereco.text 			= dw_2.Object.de_endereco				[lvl_linha] + ', ' + &
													 	 dw_2.Object.de_bairro					[lvl_linha]
		dw_6.Object.cidade.text 				= dw_2.Object.nm_cidade					[lvl_linha]
		dw_6.Object.uf.text 					= dw_2.Object.cd_unidade_federacao	[lvl_linha]
		dw_6.Object.cgc.text 					= gf_colocar_mascara_cgc(dw_2.Object.nr_cgc[lvl_linha])
		dw_6.Object.insc_estadual.text 	= dw_2.Object.nr_inscricao_estadual		[lvl_linha]
		dw_6.Object.filial.text 				= dw_2.Object.filial_nm_fantasia	  		[lvl_linha] + ' (' + &
														 String(dw_2.Object.mapa_resumo_cd_filial[lvl_linha]) + ')'
		//
		lvl_linha_inclusa = dw_6.Event ue_AddRow()
		dw_6.Object.nr_ecf        	[lvl_linha_inclusa] = dw_2.Object.nr_ecf						[lvl_linha]
		dw_6.Object.nr_cf_inicial	[lvl_linha_inclusa] = dw_2.Object.nr_operacao_inicial	[lvl_linha]
		dw_6.Object.nr_cf_final		[lvl_linha_inclusa] = dw_2.Object.nr_operacao_final		[lvl_linha]
		dw_6.Object.gt_inicial		[lvl_linha_inclusa] = dw_2.Object.vl_total_geral_inicial	[lvl_linha]
		dw_6.Object.gt_final			[lvl_linha_inclusa] = dw_2.Object.vl_total_geral_final		[lvl_linha]
		dw_6.Object.cancelamentos	[lvl_linha_inclusa] = dw_2.Object.vl_cancelamento		[lvl_linha]
		dw_6.Object.descontos		[lvl_linha_inclusa] = dw_2.Object.vl_desconto				[lvl_linha]
		dw_6.Object.contabil			[lvl_linha_inclusa] = dw_2.Object.vl_contabil				[lvl_linha]
		dw_6.Object.isento			[lvl_linha_inclusa] = dw_2.Object.vl_isenta					[lvl_linha]
		dw_6.Object.nao_incidencia	[lvl_linha_inclusa] = dw_2.Object.vl_nao_incidencia		[lvl_linha]
		dw_6.Object.st					[lvl_linha_inclusa] = dw_2.Object.vl_st						[lvl_linha]
		dw_6.Object.reducao_z		[lvl_linha_inclusa] = dw_2.Object.qt_reducao_z			[lvl_linha]
		//
		// *************************************
		//
		lvl_filial		= dw_2.Object.cd_filial		[lvl_Linha]
		lvl_mapa  	= dw_2.Object.nr_mapa		[lvl_Linha]
		lvl_ecf		= dw_2.Object.nr_ecf			[lvl_Linha]
		lvs_especie	= dw_2.Object.de_especie	[lvl_Linha]
		lvs_serie		= dw_2.Object.de_serie		[lvl_Linha]
		//
		lvl_linha_aliquota = dw_5.Retrieve(lvl_filial,lvl_mapa,lvs_especie,lvs_serie,lvl_ecf)
		//
		FOR lvl_linha_aliquota = 1 TO dw_5.RowCount()
			//
			If lvl_linha_aliquota = 1 Then
				//
				If dw_5.Object.vl_icms[1] > 0 Then
					dw_6.Object.nr_ecf			[lvl_linha_inclusa] = dw_2.Object.nr_ecf				[lvl_linha]
					dw_6.Object.base_calculo	[lvl_linha_inclusa] = dw_5.Object.vl_base_calculo	[1]
					dw_6.Object.vl_imposto		[lvl_linha_inclusa] = dw_5.Object.vl_icms			[1]
					dw_6.Object.pc_aliquota		[lvl_linha_inclusa] = dw_5.Object.pc_aliquota		[1]
				Else
					dw_6.Object.nr_ecf			[lvl_linha_inclusa] = dw_2.Object.nr_ecf				[lvl_linha]
					dw_6.Object.base_calculo	[lvl_linha_inclusa] = 0
					dw_6.Object.vl_imposto		[lvl_linha_inclusa] = 0
					dw_6.Object.pc_aliquota		[lvl_linha_inclusa] = 0
				End If
				//
			Else
				//
				lvl_linha_inclusa = dw_6.Event ue_AddRow()
				dw_6.Object.nr_ecf			[lvl_linha_inclusa] = dw_2.Object.nr_ecf				[lvl_linha]
				dw_6.Object.base_calculo	[lvl_linha_inclusa] = dw_5.Object.vl_base_calculo	[lvl_linha_aliquota]
				dw_6.Object.vl_imposto		[lvl_linha_inclusa] = dw_5.Object.vl_icms			[lvl_linha_aliquota]
				dw_6.Object.pc_aliquota		[lvl_linha_inclusa] = dw_5.Object.pc_aliquota		[lvl_linha_aliquota]
				//
			End If
			//
		Next
		//
	End If
	//
NEXT
//
// Imprime o mapa resumo

dw_6.GroupCalc()
dw_6.Print(True)

end event

type dw_5 from dc_uo_dw_base within w_ge062_consulta_mapa_resumo
integer x = 3438
integer y = 56
integer width = 315
integer height = 112
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_ge062_aliquotas"
boolean vscrollbar = true
end type

type dw_6 from dc_uo_dw_base within w_ge062_consulta_mapa_resumo
integer x = 3621
integer y = 20
integer width = 279
integer height = 112
integer taborder = 80
boolean bringtotop = true
string dataobject = "dw_ge062_formulario"
boolean vscrollbar = true
end type

type cb_pendencia from commandbutton within w_ge062_consulta_mapa_resumo
integer x = 2903
integer y = 176
integer width = 411
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Pend$$HEX1$$ea00$$ENDHEX$$ncias"
end type

event clicked;Date lvdt_Inicial,&
     lvdt_final
	  
String ls_Parm
	  
dw_1.AcceptText()	  

lvdt_Inicial = dw_1.Object.dt_inicio[1]
lvdt_final   = dw_1.Object.dt_final [1]

ls_Parm = String(lvdt_Inicial,'yyyy/mm/dd')+";"+String(lvdt_final,'yyyy/mm/dd')

OpenWithParm(w_ge062_mapa_pendente,ls_Parm)




end event

type dw_4 from dc_uo_dw_base within w_ge062_consulta_mapa_resumo
integer x = 55
integer y = 1520
integer width = 745
integer height = 240
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge062_detalhe"
end type

type cb_autentica from commandbutton within w_ge062_consulta_mapa_resumo
boolean visible = false
integer x = 2903
integer y = 40
integer width = 411
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Autenticar"
end type

event clicked;String ls_Matricula

Date ldt_Inicial, &
     ldt_final

Long ll_linhas, &
	   ll_filial, &
	   ll_sequencial

dw_1.AcceptText()	

ldt_Inicial = dw_1.Object.dt_inicio[1]
ldt_final   = dw_1.Object.dt_final  [1]
ll_filial = gvo_parametro.Of_filial()

If dw_2.RowCount() > 0 Then
	
//Verifica se existe autentica$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ criada para o documento.
	SELECT nr_sequencial
	INTO	:ll_Sequencial
	FROM autenticacao_documento
	WHERE cd_filial = :ll_filial
	AND	dh_movimentacao = :ldt_inicial
	AND 	de_procedimento = 'MAPA_RESUMO'
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_RollBack()
			SqlCa.of_MsgDbError()
			Return -1					
		
		Case 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Per$$HEX1$$ed00$$ENDHEX$$odo informado j$$HEX1$$e100$$ENDHEX$$ foi autenticado!", Information!)						
			Return -1
	End Choose				

	If DaysAfter(ldt_Inicial, ldt_final) = 0 Then
		
		dc_uo_ds_Base lvds_pendencias
		lvds_pendencias = Create dc_uo_ds_Base
		
		If Not lvds_pendencias.of_ChangeDataObject("dw_ge062_mapa_pendente_filial") Then
			Destroy(lvds_pendencias)
			Return -1
		End If	
		
		ll_Linhas = lvds_pendencias.Retrieve(ldt_Inicial, ldt_final)	
		
		Destroy(lvds_pendencias)	
		
		If ll_Linhas = 0 Then			
			If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("AUTENTICACAO_DOCUMENTO", ref ls_Matricula) Then 
				Return -1
			End If
			
			If gvo_Aplicacao.ivo_Seguranca.ivb_liberacao_com_biometria Then
				//Grava as informacoes do relatorio
				Insert Into autenticacao_documento(
					cd_filial,
					dh_movimentacao,				
					de_procedimento,
					nr_matricula_execucao,
					dh_execucao
					)
				 Values( :ll_filial,
							 :ldt_inicial,
							 'MAPA_RESUMO',
							 :ls_Matricula,
							 getdate()
							 )
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case -1
						SqlCa.of_RollBack()
						SqlCa.of_MsgDbError()
						Return -1
						
					Case Else
						SqlCa.of_Commit()
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Autentica$$HEX2$$e700e300$$ENDHEX$$o do documento gravada com sucesso!", Information!)
						Return
				End Choose						
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Autentica$$HEX2$$e700e300$$ENDHEX$$o do documento s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ gravada quando $$HEX1$$e900$$ENDHEX$$ feita a identifica$$HEX2$$e700e300$$ENDHEX$$o BIOM$$HEX1$$c900$$ENDHEX$$TRICA! ~n" + &
											 "Se a autentica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o for feita, o processo de impress$$HEX1$$e300$$ENDHEX$$o/assinatura/envio do relat$$HEX1$$f300$$ENDHEX$$rio deve ser feito!", Exclamation!)
				Return -1
			End If
		Else
			//Mensagem que n$$HEX1$$e300$$ENDHEX$$o pode ter pend$$HEX1$$ea00$$ENDHEX$$ncias para o dia
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Per$$HEX1$$ed00$$ENDHEX$$odo informado possui pend$$HEX1$$ea00$$ENDHEX$$ncias, autentica$$HEX2$$e700e300$$ENDHEX$$o N$$HEX1$$c300$$ENDHEX$$O registrada!", Exclamation!)
			Return -1
		End If
	Else
		//Informa que o periodo de consulta deve ser somente para 1 dia.
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Per$$HEX1$$ed00$$ENDHEX$$odo consultado deve ser de apenas um dia!", Exclamation!)	
		Return -1
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Sem informa$$HEX2$$e700f500$$ENDHEX$$es para autentica$$HEX2$$e700e300$$ENDHEX$$o!", Exclamation!)	
	Return -1	
End If
end event

type gb_4 from groupbox within w_ge062_consulta_mapa_resumo
integer x = 18
integer y = 1436
integer width = 800
integer height = 356
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "N$$HEX1$$e300$$ENDHEX$$o Trib. / Isento"
borderstyle borderstyle = styleraised!
end type

