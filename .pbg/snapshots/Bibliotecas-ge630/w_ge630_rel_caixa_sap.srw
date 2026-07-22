HA$PBExportHeader$w_ge630_rel_caixa_sap.srw
forward
global type w_ge630_rel_caixa_sap from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge630_rel_caixa_sap from dc_w_selecao_lista_dinamica_relatorio
string title = "GE630 - Relat$$HEX1$$f300$$ENDHEX$$rio Conta Fluxo Caixa"
end type
global w_ge630_rel_caixa_sap w_ge630_rel_caixa_sap

type variables
uo_conta_fluxo_caixa 	ivo_conta_fluxo	//GE187
uo_conta_sap				ivo_conta_sap		//GE187
uo_filial					ivo_filial			//GE063
end variables

on w_ge630_rel_caixa_sap.create
call super::create
end on

on w_ge630_rel_caixa_sap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_conta_fluxo 	= Create uo_conta_fluxo_caixa
ivo_conta_sap		= Create uo_conta_sap
ivo_filial			= Create uo_filial
//Dimens$$HEX1$$f500$$ENDHEX$$es Tela
MaxHeight = 9999
MaxWidth = 2761

//C$$HEX1$$f300$$ENDHEX$$digo na tabela consulta_generica, onde possui os campos
ivl_consulta = 32

//SQL base com a liga$$HEX2$$e700e300$$ENDHEX$$o das tabelas
ivs_SQLBase = 	"~r~n from controle_caixa cc (index idx_data_caixa) " + &
					"~r~n inner join caixa cx (index idx_filial_tipo) " + & 
					"~r~n		on cx.cd_caixa = cc.cd_caixa " + &
					"~r~n inner join integracao_sap isf "+ &
					"~r~n 	on isf.cd_empresa = 1000 "+ &
					"~r~n 	and isf.cd_tabela = Upper('FILIAL') " + &
					"~r~n 	and isf.cd_chave_legado = cast(cx.cd_filial as varchar) " + &
					"~r~n left outer join lancamento_caixa lc " + &
					"~r~n 	on lc.cd_caixa = cc.cd_caixa " + &
					"~r~n 	and lc.nr_controle_caixa = cc.nr_controle_caixa " + &
					"~r~n left outer join conta_fluxo_caixa cf " + &
					"~r~n 	on cf.cd_conta_fluxo_caixa = lc.cd_conta_fluxo_caixa " + &
					"~r~n left outer join conta_sap ccs " + &
					"~r~n 	on ccs.cd_conta_sap = cf.cd_conta_sap " + &
					"~r~n left outer join filial fil " + &
					"~r~n 	on fil.cd_filial = cx.cd_filial " + &
					"~r~n left outer join cidade cfil " + &
					"~r~n 	on cfil.cd_cidade = fil.cd_cidade " + &
					"~r~n left outer join regiao rfil " + &
					"~r~n 	on rfil.cd_regiao = fil.cd_regiao " + &
					"~r~n where cx.id_caixa_geral = Upper('S') "
end event

event close;call super::close;If IsValid(ivo_conta_fluxo) Then Destroy(ivo_conta_fluxo)
If IsValid(ivo_conta_sap) Then Destroy(ivo_conta_sap)
If IsValid(ivo_filial) Then Destroy(ivo_filial)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_inicio	[1] = RelativeDate(Today(), -1)
dw_1.Object.dh_termino	[1] = RelativeDate(Today(), -1)
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge630_rel_caixa_sap
integer y = 1600
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge630_rel_caixa_sap
integer y = 1528
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge630_rel_caixa_sap
integer y = 516
integer width = 2688
integer height = 884
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge630_rel_caixa_sap
integer width = 1952
integer height = 492
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge630_rel_caixa_sap
integer width = 1883
integer height = 388
string dataobject = "dw_ge630_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_Inicializa()
			
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			
		End If	
		
	Case "de_conta_sap"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_conta_sap.de_conta_sap Then
				Return 1
			End If	
		Else			
			ivo_conta_sap.Of_Inicializa()
			
			This.Object.de_conta_sap	[1] = ivo_conta_sap.de_conta_sap
			This.Object.cd_conta_sap	[1] = ivo_conta_sap.cd_conta_sap
			
		End If	
		
	Case "de_conta_fluxo_caixa"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_conta_fluxo.de_conta_fluxo_caixa Then
				Return 1
			End If	
		Else			
			ivo_conta_fluxo.Of_Inicializa()
			
			This.Object.de_conta_fluxo_caixa	[1] = ivo_conta_fluxo.de_conta_fluxo_caixa
			This.Object.cd_conta_fluxo_caixa	[1] = ivo_conta_fluxo.cd_conta_fluxo_caixa
			
		End If	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_conta_sap) Then 
	This.Object.de_conta_sap[1] = ivo_conta_sap.de_conta_sap
End If

If IsValid(ivo_conta_fluxo) Then 
	This.Object.de_conta_fluxo_caixa[1] = ivo_conta_fluxo.de_conta_fluxo_caixa
End If

end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
		Case "nm_filial"
			ivo_filial.Of_Localiza_Filial(This.GetText()) 
			
			If Not ivo_filial.Localizada Then ivo_filial.Of_inicializa( )
				  
			This.Object.cd_filial	[1] = ivo_filial.cd_filial
			This.Object.nm_filial	[1] = ivo_filial.nm_fantasia

		Case "de_conta_sap"
			ivo_conta_sap.Of_Localiza(This.GetText()) 
			
			If Not ivo_conta_sap.Localizada Then ivo_conta_sap.Of_inicializa( )
				  
			This.Object.cd_conta_sap	[1] = ivo_conta_sap.cd_conta_sap
			This.Object.de_conta_sap	[1] = ivo_conta_sap.de_conta_sap

		Case "de_conta_fluxo_caixa"
			ivo_conta_fluxo.Of_Localiza_conta(This.GetText())
			
			If Not ivo_conta_fluxo.localizado Then ivo_conta_fluxo.Of_inicializa( )
				  
			This.Object.cd_conta_fluxo_caixa	[1] = ivo_conta_fluxo.cd_conta_fluxo_caixa
			This.Object.de_conta_fluxo_caixa	[1] = ivo_conta_fluxo.de_conta_fluxo_caixa
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge630_rel_caixa_sap
integer y = 592
integer width = 2619
integer height = 776
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Datetime lvdh_Inicio, &
			lvdh_Fim

Long	lvl_Conta_Fluxo, &
		lvl_Filial
		
String	lvs_Conta_Sap, &
			lvs_So_Numerario, &
			lvs_Tipo_Conta

dw_1.AcceptText()

lvdh_Inicio			= dw_1.Object.dh_inicio					[1]
lvdh_Fim				= dw_1.Object.dh_termino				[1]
lvl_Conta_Fluxo	= dw_1.Object.cd_conta_fluxo_caixa	[1]
lvl_Filial			= dw_1.Object.cd_filial					[1]
lvs_Conta_Sap		= dw_1.Object.cd_conta_sap				[1]
lvs_So_Numerario	= dw_1.Object.id_numerario				[1]
lvs_Tipo_Conta		= dw_1.Object.id_tipo_conta			[1]

If IsNull(lvdh_Inicio) or lvdh_Inicio < Datetime('2000/01/01') Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe uma data de in$$HEX1$$ed00$$ENDHEX$$cio.', Exclamation!)
	dw_1.Event ue_Pos(1, 'dh_inicio')
	Return -1
ElseIf IsNull(lvdh_Fim) or lvdh_Fim < Datetime('2000/01/01') Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe uma data de t$$HEX1$$e900$$ENDHEX$$rmino.', Exclamation!)
	dw_1.Event ue_Pos(1, 'dh_termino')
	Return -1
ElseIf lvdh_Fim < lvdh_Inicio Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe uma data de t$$HEX1$$e900$$ENDHEX$$rmino maior que o in$$HEX1$$ed00$$ENDHEX$$cio.', Exclamation!)
	dw_1.Event ue_Pos(1, 'dh_termino')
	Return -1
ElseIf DaysAfter(Date(lvdh_Inicio), Date(lvdh_Fim)) > 40 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O intervalo entre data in$$HEX1$$ed00$$ENDHEX$$cio e fim n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 40 dias.', Exclamation!)
	dw_1.Event ue_Pos(1, 'dh_termino')
	Return -1
ElseIf Date(lvdh_Inicio) > Today() Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'As informa$$HEX2$$e700f500$$ENDHEX$$es de caixa n$$HEX1$$e300$$ENDHEX$$o existem para datas futuras.', Exclamation!)
	dw_1.Event ue_Pos(1, 'dh_inicio')
	Return -1
Else
	This.Of_AppendWhere( "cc.dh_movimentacao_caixa >= '"+String(lvdh_Inicio,'YYYY.MM.DD')+"'")
	This.Of_AppendWhere( "cc.dh_movimentacao_caixa <= '"+String(lvdh_Fim,'YYYY.MM.DD')+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdh_Fim,'DD/MM/YYYY')	
End If


If lvl_Filial > 0 Then
	This.Of_AppendWhere( "cx.cd_filial = "+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_Fantasia+' ('+String(lvl_Filial)+')'	
End If

If lvl_Conta_Fluxo > 0 Then
	This.Of_AppendWhere( "lc.cd_conta_fluxo_caixa = "+String(lvl_Conta_Fluxo))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Conta Fluxo: '+ivo_conta_fluxo.de_conta_fluxo_caixa+' ('+String(lvl_Conta_Fluxo)+')'	
ElseIf lvs_Tipo_Conta<>'' Then
	This.Of_AppendWhere( "cf.id_tipo_conta='"+lvs_Tipo_Conta+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Conta Fluxo: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_conta)',1)")
End If

If gf_coalesce(lvs_Conta_Sap,'')<>'' Then
	This.Of_AppendWhere( "cf.cd_conta_sap = '"+lvs_Conta_Sap+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Conta SAP: '+ivo_conta_sap.de_conta_sap+' ('+lvs_Conta_Sap+')'	
End If

If lvs_So_Numerario='S' Then
	This.Of_AppendWhere( "cf.cd_tipo_numerario_sap is not null")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = '[ X ] Somente N$$HEX1$$fa00$$ENDHEX$$mer$$HEX1$$e100$$ENDHEX$$rios SAP'	
End If

string lvs_SQL
lvs_SQL = This.GetSQLSelect()

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge630_rel_caixa_sap
integer x = 2199
integer y = 28
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge630_rel_caixa_sap
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge630_rel_caixa_sap
end type

