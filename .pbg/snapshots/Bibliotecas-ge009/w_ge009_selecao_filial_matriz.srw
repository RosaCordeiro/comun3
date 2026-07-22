HA$PBExportHeader$w_ge009_selecao_filial_matriz.srw
forward
global type w_ge009_selecao_filial_matriz from dc_w_selecao_generica
end type
end forward

global type w_ge009_selecao_filial_matriz from dc_w_selecao_generica
integer x = 494
integer y = 436
integer width = 2674
integer height = 1728
string title = "GE009 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais (Matriz)"
end type
global w_ge009_selecao_filial_matriz w_ge009_selecao_filial_matriz

type variables
uo_filial		ivo_filial
uo_cidade	ivo_cidade

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

If dw_1.GetChild("id_rede_filial", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"vl_parametro","")
	ldw_Child.SetItem(1,"rede","TODOS")
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' no filtro 'Rede Filial'.", StopSign!)
End If


If dw_1.GetChild("cd_uf", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_unidade_federacao","")
	ldw_Child.SetItem(1,"nm_unidade_federacao","TODAS")
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' no filtro 'UF'.", StopSign!)
End If
end subroutine

on w_ge009_selecao_filial_matriz.create
call super::create
end on

on w_ge009_selecao_filial_matriz.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;ivo_cidade = Create uo_cidade
end event

event close;call super::close;If IsValid(ivo_cidade) Then Destroy(ivo_cidade)
end event

event open;call super::open;STRING lvs_Filial

wf_insere_padrao()

ivo_Filial = Message.PowerObjectParm

lvs_Filial = Upper(ivo_Filial.ivs_Parametro_Selecao)

If Not IsNull(ivo_filial.ivs_Filtro_Situacao) and (ivo_filial.ivs_Filtro_Situacao<>"") Then
	dw_1.Object.id_situacao[1] 			= ivo_filial.ivs_Filtro_Situacao
	dw_1.Object.id_situacao.Protect 	= 1
End If

If Not IsNull(ivo_filial.ivs_Filtro_UF) and (ivo_filial.ivs_Filtro_UF<>"") Then
	dw_1.Object.cd_uf	[1] 			= ivo_filial.ivs_Filtro_UF
	dw_1.Object.cd_uf.Protect 	= 1
End If

// manter a atualiza$$HEX2$$e700e300$$ENDHEX$$o da vari$$HEX1$$e100$$ENDHEX$$vel ivb_Pesquisa_Direta nesse evento devido a chamada no evento pos-event
If lvs_Filial <> "" Then
	dw_1.Object.nm_fantasia[1] = lvs_Filial
	ivb_Pesquisa_Direta = True
End If
//
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge009_selecao_filial_matriz
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge009_selecao_filial_matriz
integer x = 18
integer y = 448
integer width = 2610
integer height = 1056
long backcolor = 80269524
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge009_selecao_filial_matriz
integer x = 18
integer y = 4
integer width = 2606
integer height = 408
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge009_selecao_filial_matriz
integer x = 41
integer y = 64
integer width = 2565
integer height = 324
string dataobject = "dw_ge009_selecao_matriz"
end type

event dw_1::itemchanged;call super::itemchanged;st_Mensagem.Text = ""

Choose Case dwo.Name
	Case "id_rede_filial" 
		dw_1.Object.nm_fantasia[1] = ""
		dw_2.Event ue_Retrieve()
		
	Case "nm_fantasia"
		dw_1.Object.id_rede_filial[1] = ""
		
	Case "nm_cidade"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cidade.nm_cidade Then
				Return 1
			End If
		Else
			ivo_cidade.of_Inicializa()
			
			This.Object.cd_cidade	[ Row ] = ivo_cidade.cd_cidade
			This.Object.nm_cidade	[ Row ] = ivo_cidade.nm_cidade
		End If
		
End Choose
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "nm_fantasia" Then
	dw_1.Object.id_rede_filial[1] = ""
End If


end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName() 	
		Case "nm_cidade"
			ivo_Cidade.of_inicializa( )
			ivo_Cidade.Of_Localiza_cidade( This.GetText() )
			
			This.Object.nm_cidade	[1] = ivo_Cidade.nm_cidade
			This.Object.cd_cidade	[1] = ivo_Cidade.cd_cidade
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Cidade) Then
	This.Object.nm_cidade [ This.GetRow() ] = ivo_cidade.nm_cidade
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge009_selecao_filial_matriz
integer x = 41
integer y = 500
integer width = 2565
integer height = 976
string dataobject = "dw_ge009_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Fantasia,&
		lvs_Rede,&
		lvs_SQL, &
		lvs_Nr_CNPJ, &
		lvs_Situacao, &
		lvs_UF,&
		ls_SAP

Long lvl_Cidade
	
dw_1.AcceptText()

lvs_Fantasia 	= Trim(dw_1.Object.Nm_Fantasia[1])
lvs_Rede     		= dw_1.Object.id_rede_filial	[1]
lvs_Nr_CNPJ		= dw_1.Object.NR_CNPJ			[1]
lvl_Cidade		= dw_1.Object.cd_cidade		[1]
lvs_UF			= dw_1.Object.cd_uf				[1]
lvs_Situacao		= dw_1.Object.id_situacao		[1]
ls_SAP			= dw_1.Object.cd_filial_sap		[1]

If lvs_Fantasia <> "" Then
	This.of_AppendWhere("((f.nm_fantasia like '" + lvs_Fantasia + "%') or f.cd_filial in (select cast(i1.cd_chave_legado as integer) from integracao_sap i1 where cd_tabela = 'FILIAL' and cd_empresa = 1000 and cd_chave_sap = '"+lvs_Fantasia+"')"+ &
										IIF(IsNumber(lvs_Fantasia), " or f.cd_filial = "+lvs_Fantasia+")", ")"))
End If

If Not IsNull(lvs_Situacao) and (lvs_Situacao<>"") Then
	This.Of_AppendWhere("f.id_situacao='"+lvs_Situacao+"'")
End If

If Not IsNull(lvs_UF) and (lvs_UF<>"") Then
	This.Of_AppendWhere("c.cd_unidade_federacao='"+lvs_UF+"'")
End If

If Not IsNull(lvl_Cidade) and (lvl_Cidade>0) Then
	This.Of_AppendWhere("f.cd_cidade="+String(lvl_Cidade))
End If

If lvs_Nr_CNPJ <> "" Then
	This.of_AppendWhere("f.nr_cgc = '" + lvs_Nr_CNPJ + "'")
End If

If ivo_Filial.ivs_Centralizadora = "S" Then
	This.of_AppendWhere("f.id_regional = 'S'")	
End If

If Not IsNull(ls_SAP) and trim(ls_SAP) <> '' Then
	This.of_AppendWhere("f.cd_filial = (select cast(cd_chave_legado as numeric) from integracao_sap where cd_tabela = 'FILIAL' and cd_chave_sap = '" + trim(ls_SAP) + "')  ")
End If

// N$$HEX1$$e300$$ENDHEX$$o mostra filiais DrogaExpress
//If gvo_parametro.cd_Filial <> gvo_parametro.cd_filial_matriz Then
//	This.of_AppendWhere("cd_filial_sede_drogaexpress is null")
//End If

// Todas
If lvs_Rede <> "" Then
	This.of_AppendWhere( "f.id_rede_filial = '" + lvs_Rede + "'" )
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge009_selecao_filial_matriz
integer x = 1865
integer y = 1520
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Filial

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Filial = dw_2.Object.Cd_Filial[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Filial))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma filial.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge009_selecao_filial_matriz
integer x = 2258
integer y = 1520
end type

event cb_cancelar::clicked;call super::clicked;STRING lvs_Filial

SetNull(lvs_Filial)

CloseWithReturn(Parent, lvs_Filial)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge009_selecao_filial_matriz
integer x = 1371
integer y = 1520
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge009_selecao_filial_matriz
integer x = 23
integer y = 1532
integer width = 1207
long backcolor = 80269524
end type

