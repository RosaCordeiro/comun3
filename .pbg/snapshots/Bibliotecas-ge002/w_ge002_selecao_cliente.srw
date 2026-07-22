HA$PBExportHeader$w_ge002_selecao_cliente.srw
forward
global type w_ge002_selecao_cliente from dc_w_selecao_generica
end type
end forward

global type w_ge002_selecao_cliente from dc_w_selecao_generica
integer x = 379
integer y = 436
integer width = 3250
integer height = 1532
string title = "GE002 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Clientes"
end type
global w_ge002_selecao_cliente w_ge002_selecao_cliente

type variables
uo_cliente ivo_cliente
uo_cidade ivo_cidade
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/* Ordena para aparecer primeiro os estados que a empresa tem filial*/
If dw_1.GetChild("cd_uf", ldwc_Child) > 0 Then
	ldwc_Child.SetSort("nr_ordem asc, nm_unidade_federacao asc")
	ldwc_Child.Sort()
End If

/*Grupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			
ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD"	)
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf [1] = "TD"

end subroutine

on w_ge002_selecao_cliente.create
call super::create
end on

on w_ge002_selecao_cliente.destroy
call super::destroy
end on

event open;call super::open;String lvs_Cliente

ivo_Cliente = Message.PowerObjectParm

lvs_Cliente = ivo_Cliente.ivs_Parametro

If lvs_Cliente <> "" Then
	dw_1.Object.Nm_Cliente[1] = lvs_Cliente
	This.ivb_Pesquisa_Direta = True
End If
end event

event ue_preopen;call super::ue_preopen;ivo_cidade = Create uo_cidade
end event

event close;call super::close;Destroy(ivo_cidade)
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge002_selecao_cliente
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge002_selecao_cliente
integer y = 360
integer width = 3182
integer height = 928
long backcolor = 80269524
string text = "Lista de Clientes"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge002_selecao_cliente
integer y = 16
integer width = 2825
integer height = 336
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge002_selecao_cliente
integer x = 46
integer width = 2798
integer height = 260
string dataobject = "dw_ge002_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case 'nm_cidade' 
		If Data <> ivo_cidade.nm_cidade Then
			If Data <> '' Then
				Return 1
			Else
				ivo_cidade.of_inicializa( )
				This.Object.cd_cidade	[Row] = ivo_cidade.cd_cidade
				This.Object.nm_cidade	[Row] = ivo_cidade.nm_cidade
			End If
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key=KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'nm_cidade'
			ivo_cidade.Of_inicializa( )
			ivo_cidade.of_localiza_cidade( This.GetText() )
			
			This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
			This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade		
			
			This.Post Event ue_pos(1,"nm_cliente")
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_cidade) Then
	This.Object.nm_cidade [1] = ivo_cidade.nm_cidade
End If
end event

event dw_1::editchanged;call super::editchanged;If Dwo.Name = 'nm_cidade'	Then
	cb_pesquisar.Default = False
End If
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;cb_pesquisar.Default = True
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge002_selecao_cliente
integer x = 55
integer y = 412
integer width = 3136
integer height = 856
string dataobject = "dw_ge002_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Nome, &
		 lvs_CPF, &
		 lvs_CGC, &
		 lvs_UF, &
		 lvs_Cli_SAP
		 
Long lvl_Cidade
		 
Boolean lvb_Filtro = False
		 
dw_1.AcceptText()

lvs_Nome		= dw_1.Object.Nm_Cliente		[1]
lvs_CPF		= dw_1.Object.Nr_CPF				[1]
lvs_CGC		= dw_1.Object.Nr_CGC				[1]
lvl_Cidade	= dw_1.Object.cd_cidade			[1]
lvs_UF		= dw_1.Object.cd_uf				[1]
lvs_Cli_SAP	= dw_1.Object.cd_cliente_sap	[1]

If Not IsNull(lvs_Nome) and Trim(lvs_Nome) <> "" Then
	ivo_Cliente.of_AppendWhere_Nome_Cliente( This, lvs_Nome ) // Tratamento para quando o banco de dados for PostgreSQL
	
	lvb_Filtro = (Len(Trim(lvs_Nome)) >= 5)
End If

If Not IsNull(lvs_CPF) and Trim(lvs_CPF) <> "" Then
	// Somente o CPF ou somente o CNPJ pode ser preenchido
	If Not IsNull(lvs_CGC) And Trim(lvs_CGC) <> "" Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe somente o CPF ou somente o CNPJ para realizar a consulta.", StopSign! )
		Return -1
	End If
	
	// Caso o CPF tenha sido informado, o mesmo deve estar completo e ser v$$HEX1$$e100$$ENDHEX$$lido
	If Not gf_Valida_CPF( lvs_CPF ) Then Return -1
	
	This.of_AppendWhere("nr_cpf_cgc = '" + lvs_CPF + "'")
	
	lvb_Filtro = True
End If

If Not IsNull(lvs_CGC) and Trim(lvs_CGC) <> "" Then
	// Caso o CNPJ tenha sido informado, o mesmo deve estar completo e ser v$$HEX1$$e100$$ENDHEX$$lido
	If Not gf_CGC_Valido( lvs_CGC ) Then Return -1
	
	This.of_AppendWhere("nr_cpf_cgc = '" + lvs_CGC + "'")
	
	lvb_Filtro = True
End If

// Verifica a necessidade de filtrar o tipo do cliente
If ivo_Cliente.ivs_Tipo_Cliente <> "" Then
	If ivo_Cliente.ivs_Tipo_Cliente = "CL" Then
		This.of_AppendWhere("id_tipo_cliente in ('RC', 'CC')")
	Else
		This.of_AppendWhere("id_tipo_cliente = '" + ivo_Cliente.ivs_Tipo_Cliente + "'")		
	End If
End If

// Verifica a necessidade de filtrar a pessoa do cliente
If ivo_Cliente.ivs_Fisica_Juridica <> "" Then
	This.of_AppendWhere("id_fisica_juridica = '" + ivo_Cliente.ivs_Fisica_Juridica + "'")
End If

If Not IsNull(lvl_Cidade) and (lvl_Cidade > 0) Then
	This.of_AppendWhere("cd_cidade = " + String(lvl_Cidade))	
End If

If lvs_Cli_SAP <> "" Then
	This.of_AppendWhere("cd_cliente_sap = '" + lvs_Cli_SAP+"'")
	
	lvb_Filtro = True
End If

If lvs_UF<>"TD" Then
	This.of_AppendWhere("cd_cidade in (select c1.cd_cidade from cidade c1 where c1.cd_unidade_federacao = '" +lvs_UF+"')")	
End If

If Not lvb_Filtro Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Com os filtros informados a pesquisa ir$$HEX1$$e100$$ENDHEX$$ demorar.~rDeseja continuar mesmo assim?",Question!,YesNo!,2)=2 Then	Return -1
End If

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge002_selecao_cliente
integer x = 2441
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Cd_Cliente

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Cd_Cliente = dw_2.Object.Cd_Cliente[lvl_Linha]
	CloseWithReturn(Parent, lvs_Cd_Cliente)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cliente.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge002_selecao_cliente
integer x = 2839
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Cd_Cliente

SetNull(lvs_Cd_Cliente)

CloseWithReturn(Parent, lvs_Cd_Cliente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge002_selecao_cliente
event ue_altera_default ( boolean pb_default )
integer x = 1970
end type

event cb_pesquisar::ue_altera_default(boolean pb_default);This.Default = pb_default
end event

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge002_selecao_cliente
integer x = 41
integer y = 1328
integer width = 1467
long backcolor = 80269524
end type

