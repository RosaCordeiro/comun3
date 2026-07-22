HA$PBExportHeader$w_ge003_selecao_fornecedor.srw
forward
global type w_ge003_selecao_fornecedor from dc_w_selecao_generica
end type
end forward

global type w_ge003_selecao_fornecedor from dc_w_selecao_generica
integer x = 82
integer y = 376
integer width = 4110
integer height = 1768
string title = "GE003 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Fornecedores"
end type
global w_ge003_selecao_fornecedor w_ge003_selecao_fornecedor

type prototypes

end prototypes

type variables

end variables

on w_ge003_selecao_fornecedor.create
call super::create
end on

on w_ge003_selecao_fornecedor.destroy
call super::destroy
end on

event open;call super::open;String lvs_Fornecedor

lvs_Fornecedor = Message.StringParm

If lvs_Fornecedor <> "" Then
	dw_1.Object.De_Fornecedor[1] = lvs_Fornecedor
	ivb_Pesquisa_Direta = True
End If

If (gvo_Parametro.cd_filial <> gvo_Parametro.cd_filial_matriz) Then
	dw_1.Object.id_ativos.Visible 	= 0
	dw_1.Object.ativos_t.Visible		= 0
Else
	dw_1.Object.id_ativos.Visible 	= 1
	dw_1.Object.ativos_t.Visible		= 1
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge003_selecao_fornecedor
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge003_selecao_fornecedor
integer x = 23
integer y = 420
integer width = 4059
integer height = 1148
long backcolor = 80269524
string text = "Lista de Fornecedores"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge003_selecao_fornecedor
integer x = 23
integer y = 4
integer width = 4059
integer height = 408
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge003_selecao_fornecedor
integer x = 50
integer y = 76
integer width = 2569
integer height = 320
string dataobject = "dw_ge003_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "id_fisica_juridica" Then
	
	If This.Object.Id_Fisica_Juridica[1] = "F" Then 		
		This.Object.Nr_CGC[1] = ''		
	Else		
		This.Object.Nr_CPF[1] = ''		
	End If 	
	
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge003_selecao_fornecedor
integer x = 46
integer y = 472
integer width = 4023
integer height = 1080
string dataobject = "dw_ge003_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Boolean lvb_Ok = False

String lvs_Cd_Fornecedor, &
       lvs_Razao_Social, &
		 lvs_Nr_CGC, &
		 lvs_Nr_CPF, &
 		 lvs_Id_Fisica_Juridica, &
		 lvs_Tipo,&
		 lvs_Cd_Fornecedor_SAP
		 
String ls_Ativos

dw_1.AcceptText()

lvs_Cd_Fornecedor      	= Trim( dw_1.Object.cd_fornecedor				[1] )
lvs_Razao_Social      	 	= Trim( dw_1.Object.de_fornecedor				[1] )
lvs_Nr_CGC             		= Trim( dw_1.Object.nr_cgc						[1] )
lvs_Nr_CPF             		= Trim( dw_1.Object.nr_cpf							[1] )
lvs_Id_Fisica_Juridica	 	= dw_1.Object.Id_Fisica_Juridica					[1]
lvs_Tipo						= dw_1.Object.id_fornecedor_transportadora	[1]
ls_Ativos						= dw_1.Object.id_ativos								[1]
lvs_Cd_Fornecedor_SAP = Trim(dw_1.Object.cd_fornecedor_sap			[1])

//Cancatena Fornecedor
If LenA( TRIM( lvs_Cd_Fornecedor ) ) > 0 Then
	This.of_AppendWhere("cd_fornecedor = '" + lvs_Cd_Fornecedor + "'")
	lvb_Ok = True
End If

//Cancatena Fornecedor SAP
If LenA( TRIM( lvs_Cd_Fornecedor_SAP ) ) > 0 Then
	This.of_AppendWhere("cd_fornecedor_sap = '" + lvs_Cd_Fornecedor_SAP + "'")
	lvb_Ok = True
End If
		 
//Concatena Razao Social		 
If LenA( TRIM( lvs_Razao_Social ) ) > 0 Then
	This.of_AppendWhere("nm_razao_social like '" + lvs_Razao_Social + "%'")
	lvb_Ok = True
End If

//Concatena Pessoa F$$HEX1$$ed00$$ENDHEX$$sica - Jur$$HEX1$$ed00$$ENDHEX$$dica1
If lvs_Id_Fisica_Juridica <> 'T' Then
	This.of_AppendWhere("id_fisica_juridica = '" + lvs_Id_Fisica_Juridica + "'")
	lvb_Ok = True
End If

//Concatena CGC
If LenA( TRIM( lvs_Nr_CGC ) ) > 0 Then
	This.of_AppendWhere("nr_cgc = '" + lvs_Nr_CGC + "'")
	lvb_Ok = True
End If

//Concatena CPF
If LenA( TRIM( lvs_Nr_CPF ) ) > 0 Then
	This.of_AppendWhere("nr_cpf = '" + lvs_Nr_CPF + "'")
	lvb_Ok = True
End If

// Filial
//If gvo_Parametro.cd_filial  <> gvo_Parametro.cd_filial_matriz Then
//	This.of_AppendWhere("(id_situacao = 'A' or id_situacao is null)")
//	lvb_Ok = True
//End If

If ls_Ativos = 'S' Or (gvo_Parametro.cd_filial <> gvo_Parametro.cd_filial_matriz) Then
	This.of_AppendWhere("(f.id_situacao = 'A' or f.id_situacao is null)")
	lvb_Ok = True
End If

//Transportadora ou Fornecedor	
If lvs_Tipo <> "X" Then
	This.of_AppendWhere("id_fornecedor_transportadora = '" + lvs_Tipo + "'")
End If

If lvb_Ok Then
	Return 1
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um par$$HEX1$$e200$$ENDHEX$$metro para sele$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Return -1
End If
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection( "if( id_situacao <> ~"ATIVO~", rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge003_selecao_fornecedor
integer x = 3333
integer y = 1576
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Fornecedor

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Fornecedor = dw_2.Object.Cd_Fornecedor[lvl_Linha]
	CloseWithReturn(Parent, lvs_Fornecedor)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um fornecedor.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge003_selecao_fornecedor
integer x = 3717
integer y = 1576
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Fornecedor

SetNull(lvs_Fornecedor)

CloseWithReturn(Parent, lvs_Fornecedor)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge003_selecao_fornecedor
integer x = 2597
integer y = 1576
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge003_selecao_fornecedor
integer x = 27
integer y = 1576
long backcolor = 80269524
end type

