HA$PBExportHeader$w_ge352_cadastro_telefones.srw
forward
global type w_ge352_cadastro_telefones from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge352_cadastro_telefones from dc_w_cadastro_selecao_lista
integer width = 4777
integer height = 1724
string title = "GE352 - Cadastro de Telefones da Empresa"
end type
global w_ge352_cadastro_telefones w_ge352_cadastro_telefones

type variables
uo_centro_custo ivo_centro_custo
end variables

forward prototypes
public subroutine wf_localiza_centro_custo ()
public subroutine wf_insere_padrao ()
public function long wf_retorna_minimo_caracteres (string ps_tipo, long pl_operadora)
public function boolean wf_valida_telefone_novo (long pl_linha)
end prototypes

public subroutine wf_localiza_centro_custo ();STRING lvs_Centro_Custo

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio
lvs_Centro_Custo = dw_1.GetText()
ivo_Centro_Custo.of_Localiza_Centro_Custo(lvs_Centro_Custo)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Centro_Custo.Localizada Then
	dw_1.Object.Cd_Centro_Custo[1] = ivo_Centro_Custo.Cd_Centro_Custo
  	dw_1.Object.De_Centro_Custo[1] = ivo_Centro_Custo.De_Centro_Custo
	  
	// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de inclus$$HEX1$$e300$$ENDHEX$$o
	This.ivm_Menu.mf_Incluir(True)
Else

	SetNull(ivo_Centro_Custo.Cd_Centro_Custo)
	ivo_Centro_Custo.de_Centro_Custo = ""
	
	dw_1.Object.Cd_Centro_Custo[1] = ivo_Centro_Custo.Cd_Centro_Custo
  	dw_1.Object.De_Centro_Custo[1] = ivo_Centro_Custo.De_Centro_Custo
	  
	// Desabilita a fun$$HEX2$$e700e300$$ENDHEX$$o de inclus$$HEX1$$e300$$ENDHEX$$o
	This.ivm_Menu.mf_Incluir(False)
End If
end subroutine

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

Long lvl_null

/*Grupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_operadora" )			

ldwc_Child.SetItem(1, "cd_operadora", lvl_null	)
ldwc_Child.SetItem(1, "nm_operadora", "TODAS")

dw_1.Object.cd_operadora[1] = lvl_null
end subroutine

public function long wf_retorna_minimo_caracteres (string ps_tipo, long pl_operadora);Choose Case ps_tipo
	Case 'C'
		Return 9
	Case 'N', 'F'
		If pl_operadora = 93 Then 
			Return 7
		Else
			Return 8
		End If
	Case Else
		Return 4
End Choose

end function

public function boolean wf_valida_telefone_novo (long pl_linha);long ll_existe

string ls_nr_ddd
string ls_nr_telefone
string ls_nulo

if pl_linha = 0 or isnull(pl_linha) then return true

ls_nr_ddd = trim(dw_2.getitemString(pl_linha, 'nr_ddd'))
ls_nr_telefone = trim(dw_2.getitemString(pl_linha, 'nr_telefone'))

if isnull(ls_nr_ddd) or ls_nr_ddd = '' or isnull(ls_nr_telefone) or ls_nr_telefone = '' Then return true

setnull(ls_nulo)

select count(*)
	into :ll_existe
from telefone_drogaria
where nr_ddd = :ls_nr_ddd
	and nr_telefone = :ls_nr_telefone;
	
if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar a tabela telefone_drogaria: ' + sqlca.sqlerrtext)
	return false
ENd if

if Not isnull(ll_existe) and ll_existe > 0 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O n$$HEX1$$fa00$$ENDHEX$$mero de telefone informado j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado no sistema: (' + ls_nr_ddd + ') ' + ls_nr_telefone)
	dw_2.setitem(pl_linha, 'nr_ddd', ls_nulo)
	dw_2.setitem(pl_linha, 'nr_telefone', ls_nulo)
	dw_2.setcolumn('nr_ddd')
	dw_2.setfocus()
End if

return true
end function

on w_ge352_cadastro_telefones.create
call super::create
end on

on w_ge352_cadastro_telefones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_centro_custo)
end event

event open;call super::open;ivo_centro_custo = Create uo_centro_custo
end event

event ue_preopen;call super::ue_preopen;//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
MaxWidth	= 4840

//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
//Neste caso como s$$HEX1$$e300$$ENDHEX$$o muitos registros o sistema ajusta ao m$$HEX1$$e100$$ENDHEX$$ximo poss$$HEX1$$ed00$$ENDHEX$$vel da tela
MaxHeight	= 9999
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge352_cadastro_telefones
integer y = 1624
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge352_cadastro_telefones
integer y = 1552
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge352_cadastro_telefones
integer x = 46
integer y = 52
integer width = 3099
integer height = 180
string dataobject = "dw_ge352_parametro_selecao_telefone"
end type

event dw_1::editchanged;call super::editchanged;Long lvl_nulo

String lvs_nulo

SetNull(lvs_Nulo)
SetNull(lvl_Nulo)


Choose Case dwo.Name 
	Case "de_centro_custo"
	
		dw_2.Event ue_Reset()
		
		SetNull(lvl_Nulo)
		This.Object.Cd_Centro_Custo[1] = lvl_nulo
		Return 0
		
		If Data <> ivo_Centro_Custo.De_Centro_Custo Then Return 1
		
End Choose
end event

event dw_1::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'de_centro_custo' Then
		wf_Localiza_Centro_Custo()
	End If
	
End If
end event

event dw_1::ue_saveas;// OverRide
dw_2.Event ue_SaveAs()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge352_cadastro_telefones
integer x = 27
integer y = 244
integer width = 4686
integer height = 1280
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge352_cadastro_telefones
integer x = 27
integer y = 0
integer width = 3127
integer height = 240
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge352_cadastro_telefones
integer x = 50
integer y = 296
integer width = 4654
integer height = 1216
string dataobject = "dw_ge352_lista_telefone"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;call super::ue_recuperar;//OverRide
Long lvl_Centro_Custo
Long lvl_Operadora

String lvs_DDD,&
		 lvs_Telefone,&
		 lvs_Situacao
		 

dw_1.AcceptText()

lvl_Centro_Custo	= dw_1.Object.Cd_Centro_Custo	[1]
lvs_DDD				= dw_1.Object.Nr_DDD			 	[1]
lvs_Telefone		= dw_1.Object.Nr_Telefone	 		[1]
lvl_Operadora		= dw_1.Object.cd_operadora	 	[1]
lvs_Situacao			= dw_1.Object.id_situacao		 	[1]

If Not IsNull(lvl_centro_custo) and lvl_centro_custo <> 0 Then
	This.of_AppendWhere("t.cd_centro_custo = " + String(lvl_centro_custo))
End If

If Not IsNull(lvl_Operadora) and lvl_Operadora <> 0 Then
	This.of_AppendWhere("t.cd_operadora = " + String(lvl_Operadora))
End If

If lvs_Situacao <> "T" Then
	If lvs_Situacao = "0" Then	
		This.of_AppendWhere("t.id_situacao <> '3'")
	Else
		This.of_AppendWhere("t.id_situacao = '" + lvs_Situacao + "'")
	End If
End If

If Not IsNull(lvs_DDD) and lvs_DDD <> "" Then
	This.of_AppendWhere("t.nr_ddd = '" + lvs_DDD + "'")
End If

If Not IsNull(lvs_Telefone) and lvs_Telefone <> "" Then
	This.of_AppendWhere("t.nr_telefone like '" + Trim(lvs_Telefone) + "%'")
End If

Return This.Retrieve()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivm_Menu.mf_Excluir(True)
	ivm_Menu.mf_SalvarComo(True)
Else
	ivm_Menu.mf_Excluir(False)
	ivm_Menu.mf_SalvarComo(False)	
End If

Return 1
end event

event dw_2::ue_key;Long lvl_Linha

If Key = KeyEnter! Then
	If dw_2.GetColumnName() = "nm_fantasia" Then
		
		lvl_Linha = dw_2.GetRow()
		
		ivo_Centro_Custo.of_Localiza_Centro_Custo(This.GetText())
		
		If ivo_Centro_Custo.Localizada Then
			dw_2.Object.cd_centro_custo[lvl_Linha] = ivo_Centro_Custo.cd_centro_custo
			dw_2.Object.nm_fantasia		[lvl_Linha] = ivo_Centro_Custo.de_centro_custo
		End If
	End If
End If
end event

event dw_2::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	
	Long lvl_Centro	
	dw_1.AcceptText()	
	lvl_Centro = dw_1.Object.Cd_Centro_Custo[1]
	
	If Not IsNull(lvl_Centro) Then
		This.Object.Cd_Centro_Custo	[AncestorReturnValue] = lvl_Centro
		This.Object.Nm_Fantasia			[AncestorReturnValue] = ivo_Centro_Custo.De_Centro_Custo
	End If	
End If

Return AncestorReturnValue
end event

event dw_2::ue_preinsertrow;call super::ue_preinsertrow;// N$$HEX1$$e300$$ENDHEX$$o deixa inserir mais que uma linha em branco
If This.RowCount() > 0 Then
	If IsNull(This.Object.Nr_DDD[This.RowCount()]) OR IsNull(This.Object.Nr_Telefone[This.RowCount()]) Then
		Return -1
	End If
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nr_ddd","nr_telefone","de_telefone", "de_email", "nr_ramal","id_tipo",&
              "id_situacao", "cd_centro_custo","nm_fantasia"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo de $$HEX1$$c100$$ENDHEX$$rea","N$$HEX1$$ba00$$ENDHEX$$ do Telefone","Descri$$HEX2$$e700e300$$ENDHEX$$o", "E-mail", "Ramal","Tipo",&
            "Situa$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do Centro de Custo","Nome do Centro de Custo"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection("", 'if( id_situacao = "3", RGB(255,0, 0), RGB(0,0,0) )')

This.ivb_Ordena_Colunas = True
end event

event dw_2::itemfocuschanged;//override
String lvs_Aux
String lvs_Telefone

Long lvl_Char

This.Post Event ue_SelectText()

This.of_Desmarca_Coluna_Ativa()

If dwo.Type = "column" Then
	This.of_Marca_Coluna_Ativa(dwo.Name)
End If

If gvo_aplicacao.ivb_usa_aux_visual Then
	lvs_Aux = This.GetItemString(Row,'nr_ddd') + ' '+This.GetItemString(Row,'nr_telefone')
	For lvl_Char = 1 To Len(lvs_Aux)
		lvs_Telefone += ' ' + Mid(lvs_Aux,lvl_Char,1)
	Next 
	wf_set_descricao_nao_visual('Telefone '+lvs_Telefone+', Coluna ' + This.of_Titulo_Coluna(Dwo.Name)+'.')
End If

Return 0
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long lvl_Centro
Long lvl_Linha
Long lvl_Operadora

String lvs_Situacao
String lvs_Descricao
String lvs_DDD
String lvs_Telefone
String lvs_Tipo

For lvl_Linha = 1 To This.RowCount()
	
	lvs_DDD			= This.Object.nr_ddd					[lvl_Linha]
	lvs_Telefone	= This.Object.nr_telefone			[lvl_Linha]
	lvl_Centro		= This.Object.Cd_Centro_Custo	[lvl_Linha]
	lvs_Situacao		= This.Object.id_situacao			[lvl_Linha]
	lvl_Operadora	= This.Object.cd_operadora			[lvl_Linha]
	lvs_Descricao	= This.Object.de_telefone			[lvl_Linha]
	lvs_Tipo			= This.Object.id_tipo					[lvl_Linha]
	
	If IsNull(lvs_DDD) or (Len(gf_retorna_so_numeros(lvs_DDD)) < 2) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um DDD v$$HEX1$$e100$$ENDHEX$$lido para o telefone.", Exclamation!)
		This.Event ue_Pos(lvl_Linha, 'nr_ddd')
		Return -1
	End If
	
	If IsNull(lvs_Telefone) or (Len(gf_retorna_so_numeros(lvs_Telefone)) < wf_retorna_minimo_caracteres(lvs_Tipo, lvl_Operadora)) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um n$$HEX1$$fa00$$ENDHEX$$mero v$$HEX1$$e100$$ENDHEX$$lido para o telefone.", Exclamation!)
		This.Event ue_Pos(lvl_Linha, 'nr_telefone')
		Return -1
	End If
	
	If IsNull(lvs_Descricao) or (Trim(lvs_Descricao) = "") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma descri$$HEX2$$e700e300$$ENDHEX$$o para o telefone.", Exclamation!)
		This.Event ue_Pos(lvl_Linha, 'de_telefone')
		Return -1
	End If
	
	If IsNull(lvs_Situacao) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma situa$$HEX2$$e700e300$$ENDHEX$$o para o telefone.", Exclamation!)
		This.Event ue_Pos(lvl_Linha, 'id_situacao')
		Return -1
	End If
	
	If IsNull(lvl_Operadora) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma operadora para o telefone.", Exclamation!)
		This.Event ue_Pos(lvl_Linha, 'cd_operadora')
		Return -1
	End If
	
	If IsNull(lvl_Centro) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um centro de custo para o telefone.", Exclamation!)
		This.Event ue_Pos(lvl_Linha, 'nm_fantasia')
		Return -1
	End If
Next

Return AncestorReturnValue
end event

event dw_2::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case 'nr_ddd', 'nr_telefone'
		
		if ( dw_2.getitemstatus( row, 0, primary!) = NewModified! ) or ( dw_2.getitemstatus( row, 0, primary!) = New! ) Then
			post wf_valida_telefone_novo(row)
		ENd if
		
End Choose
end event

