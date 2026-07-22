HA$PBExportHeader$w_ge291_relatorio_nf_compra.srw
forward
global type w_ge291_relatorio_nf_compra from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge291_relatorio_nf_compra from dc_w_selecao_lista_relatorio
string tag = "w_ge291_relatorio_nf_compra"
integer width = 4288
integer height = 2028
string title = "GE291 - Relat$$HEX1$$f300$$ENDHEX$$rio de Notas Fiscais de Compra"
long backcolor = 80269524
end type
global w_ge291_relatorio_nf_compra w_ge291_relatorio_nf_compra

type variables
uo_fornecedor ivo_fornecedor
uo_filial ivo_filial
end variables

on w_ge291_relatorio_nf_compra.create
call super::create
end on

on w_ge291_relatorio_nf_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Fornecedor = Create uo_Fornecedor
ivo_Filial		= Create uo_Filial


end event

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;This.ivm_Menu.ivb_Permite_Imprimir = True

ivo_Filial.of_Localiza_Codigo(534)

dw_1.Object.DT_Inicio [1] = Today()
dw_1.Object.Dt_Termino[1] = Today()

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_filial
	dw_1.Object.Nm_filial[1] = ivo_Filial.Nm_Fantasia
End If


end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge291_relatorio_nf_compra
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge291_relatorio_nf_compra
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge291_relatorio_nf_compra
integer x = 23
integer y = 488
integer width = 4192
integer height = 1324
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge291_relatorio_nf_compra
integer x = 23
integer width = 3785
integer height = 464
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge291_relatorio_nf_compra
integer x = 59
integer width = 3694
integer height = 348
string dataobject = "dw_ge291_selecao_nf"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
	End If
End If

If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
		This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fornecedor" Then
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
	ElseIf This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_filial
			This.Object.Nm_filial[1] = ivo_Filial.Nm_Fantasia
		End If
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If

If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge291_relatorio_nf_compra
integer x = 55
integer y = 564
integer width = 4133
integer height = 1216
string dataobject = "dw_ge291_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_NF		, &
	  lvl_Filial

String lvs_Fornecedor, &
		 lvs_Tipo	   , &
		 lvs_Bonificado = "", &
		 lvs_SQL_Confirmada, &
		 lvs_SQL_Pendente, &
		 lvs_SQL

Date lvdt_Inicio, &
     lvdt_Termino

lvs_SQL_Pendente = "select n.cd_filial, " + &
								  "l.nm_fantasia," + &
								  "n.dh_registro," + &  
								  "n.dh_emissao," + &
								  "n.cd_fornecedor," + &   
								  "f.nm_razao_social," + &   
								  "n.nr_nf," + &   
								  "n.de_especie," + &   
								  "n.de_serie," + &   
								  "n.vl_total_produtos," + &   
								  "n.vl_total_nf," + &
								  "isnull(n.id_bonificacao, 'N')," + &
								  "'N' id_confirmada," + &
								  "'      ' nr_matricula_conferente" + &
					    " from nf_compra_pendente n," + &   
							   "fornecedor f," + &
							   "filial l" + &
						 " where f.cd_fornecedor = n.cd_fornecedor" + &
						   " and n.cd_filial     = l.cd_filial"

lvs_SQL_Confirmada = "select n.cd_filial, " + &
								    "l.nm_fantasia," + &
								    "n.dh_movimentacao_caixa," + & 
									"n.dh_emissao," + &
								    "n.cd_fornecedor," + &   
								    "f.nm_razao_social," + &   
								    "n.nr_nf," + &   
								    "n.de_especie," + &   
								    "n.de_serie," + &   
								    "n.vl_total_produtos," + &   
								    "n.vl_total_nf," + &
								    "isnull(n.id_bonificacao, 'N')," + &
								    "'S' id_confirmada," + &  
									 "n.nr_matricula_conferente" + &
						  " from nf_compra n," + &   
							    "fornecedor f," + &
							    "filial l" + &
						  " where f.cd_fornecedor = n.cd_fornecedor" + &
						    " and n.cd_filial     = l.cd_filial"

dw_1.AcceptText()

lvl_NF         = dw_1.Object.Nr_NF        [1]
lvs_Fornecedor = dw_1.Object.Cd_Fornecedor[1]
lvdt_Inicio    = dw_1.Object.Dt_Inicio    [1]
lvdt_Termino   = dw_1.Object.Dt_Termino   [1]
lvs_Tipo			= dw_1.Object.Tipo			[1]
lvl_Filial		= dw_1.Object.Cd_Filial		[1]

Choose Case lvs_Tipo
	Case "P" ; lvs_SQL = lvs_SQL_Pendente
	Case "C" ; lvs_SQL = lvs_SQL_Confirmada
	Case "T" ; lvs_SQL = lvs_SQL_Pendente + " union " + lvs_SQL_Confirmada
End Choose

This.of_ChangeSQL(lvs_SQL)

If dw_1.Object.id_nao_bonificado[1] = 'S' Then
	lvs_Bonificado = lvs_Bonificado + "'N'"
End If

If dw_1.Object.id_com_custo[1] = 'S' Then
	If lvs_Bonificado <> "" Then
		lvs_Bonificado = lvs_Bonificado + ","
	End If
	lvs_Bonificado = lvs_Bonificado + "'C'"
End If

If dw_1.Object.id_sem_custo[1] = 'S' Then
	If lvs_Bonificado <> "" Then
		lvs_Bonificado = lvs_Bonificado + ","
	End If
	lvs_Bonificado = lvs_Bonificado + "'S'"	
End If

If lvs_Bonificado = "" Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pelo menos uma op$$HEX2$$e700e300$$ENDHEX$$o de bonifica$$HEX2$$e700e300$$ENDHEX$$o deve ser selecionada.")
	Return -1
End If

If lvs_Bonificado <> "" Then
	If lvs_Tipo = 'T' Then
		This.of_AppendWhere("isnull(n.id_bonificacao, 'N') in (" + lvs_Bonificado + ")" , 1)
		This.of_AppendWhere("isnull(n.id_bonificacao, 'N') in (" + lvs_Bonificado + ")" , 2)
	Else
		This.of_AppendWhere("isnull(n.id_bonificacao, 'N') in (" + lvs_Bonificado + ")")
	End If
End If

If Not IsNull(lvl_NF) and lvl_NF > 0 Then
	If lvs_Tipo = 'T' Then
		This.of_AppendWhere("n.nr_nf = " + String(lvl_NF) , 1)
		This.of_AppendWhere("n.nr_nf = " + String(lvl_NF) , 2)
	Else
		This.of_AppendWhere("n.nr_nf = " + String(lvl_NF))
	End If
End If
	  
If Not IsNull(lvl_Filial) Then
	If lvs_Tipo = 'T' Then
		This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial) , 1)
		This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial) , 2)
	Else
		This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
	End If
End If

If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
	If lvs_Tipo = 'T' Then
		This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'" , 1)
		This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'" , 2)
	Else
		This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'")
	End If
End If

If IsDate(String(lvdt_Inicio, "dd/mm/yyyy")) Then
	
	Choose Case lvs_Tipo
		Case 'T'
			This.of_AppendWhere("convert(char(8),n.dh_registro,112) >= '" + String(lvdt_Inicio, "yyyymmdd") + "'" , 1)
			This.of_AppendWhere("n.dh_movimentacao_caixa >= '" + String(lvdt_Inicio, "yyyy/mm/dd") + "'" , 2)
		Case 'C'
			This.of_AppendWhere("n.dh_movimentacao_caixa >= '" + String(lvdt_Inicio, "yyyy/mm/dd") + "'")
		Case 'P'
			This.of_AppendWhere("convert(char(8),n.dh_registro,112) >= '" + String(lvdt_Inicio, "yyyymmdd") + "'")
	End Choose
	
End If


If IsDate(String(lvdt_Termino, "dd/mm/yyyy")) Then
 	Choose Case lvs_Tipo
		Case 'T'
			This.of_AppendWhere("convert(char(8),n.dh_registro,112) <= '" + String(lvdt_Termino, "yyyymmdd") + "'" , 1)
			This.of_AppendWhere("n.dh_movimentacao_caixa <= '" + String(lvdt_Termino, "yyyy/mm/dd") + "'" , 2)
		Case 'C'
			This.of_AppendWhere("n.dh_movimentacao_caixa <= '" + String(lvdt_Termino, "yyyy/mm/dd") + "'")
		Case 'P'
			This.of_AppendWhere("convert(char(8),n.dh_registro,112) <= '" + String(lvdt_Termino, "yyyymmdd") + "'")
	End Choose
End If

Return 1
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]	 , &
		 lvs_Bloqueio[]
		 
lvs_Nome   = {"C$$HEX1$$f300$$ENDHEX$$digo da Filial","Data","Fornecedor","Raz$$HEX1$$e300$$ENDHEX$$o Social","Nota","Total Produtos","Total Nota","Bonifica$$HEX2$$e700e300$$ENDHEX$$o","Confirma$$HEX2$$e700e300$$ENDHEX$$o"}

lvs_Coluna = {"cd_filial","dh_registro","cd_fornecedor","razao_social","nr_nf","vl_total_produtos","vl_total_nf","id_bonificacao","id_confirmada"}

lvs_Bloqueio = {"S","N","N","N","N","N","N","N","N"}

This.of_SetSort(lvs_Coluna, lvs_Nome, lvs_Bloqueio)
This.of_SetFilter(lvs_Coluna, lvs_Nome)	

ivb_ordena_colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge291_relatorio_nf_compra
integer x = 1998
integer y = 100
integer width = 279
integer height = 220
integer taborder = 50
string dataobject = "dw_ge291_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;This.Object.Inicio.Text	= String(dw_1.Object.dt_inicio 		[1], "dd/mm/yyyy")
This.Object.Fim.Text		= String(dw_1.Object.dt_Termino	[1], "dd/mm/yyyy")

Return AncestorReturnValue
end event

