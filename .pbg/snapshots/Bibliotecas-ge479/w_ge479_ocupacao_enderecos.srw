HA$PBExportHeader$w_ge479_ocupacao_enderecos.srw
forward
global type w_ge479_ocupacao_enderecos from dc_w_2tab_consulta_selecao_lista_det
end type
end forward

global type w_ge479_ocupacao_enderecos from dc_w_2tab_consulta_selecao_lista_det
integer width = 3067
integer height = 2392
string title = "GE479 - Ocupa$$HEX2$$e700e300$$ENDHEX$$o dos Endere$$HEX1$$e700$$ENDHEX$$os"
end type
global w_ge479_ocupacao_enderecos w_ge479_ocupacao_enderecos

type variables
uo_produto ivo_Produto
end variables

forward prototypes
public subroutine wf_insere_grupo_todos ()
public function boolean wf_verifica_cds (ref long al_cds[])
end prototypes

public subroutine wf_insere_grupo_todos ();DataWindowChild lvdwc

If Tab_1.TabPage_1.dw_1.GetChild("cd_grupo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_grupo", "0")
	lvdwc.SetItem(1, "de_grupo", "TODOS")
	
	Tab_1.TabPage_1.dw_1.Object.Cd_Grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If
end subroutine

public function boolean wf_verifica_cds (ref long al_cds[]);Long ll_Linha, ll_Linhas

// Recupera os dados da DataStore
dc_uo_ds_base lds_cds
lds_cds = Create dc_uo_ds_base
lds_cds.Of_ChangeDataObject("dw_ge479_lista_cds")

// Executa o Retrieve
If lds_cds.Retrieve() < 0 Then
    Destroy lds_cds
    Return False
End If

// Quantidade de registros
ll_Linhas = lds_cds.RowCount()

// Preenche o array
For ll_Linha = 1 To ll_Linhas
    al_cds[ll_Linha] = lds_cds.GetItemNumber(ll_Linha, "cd_filial")
Next

Destroy lds_cds

Return True
end function

on w_ge479_ocupacao_enderecos.create
call super::create
end on

on w_ge479_ocupacao_enderecos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Produto)


end event

event open;call super::open;ivo_Produto = Create uo_Produto
end event

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_produto 

This.ivm_menu.ivb_Permite_Imprimir = True
//Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)

wf_Insere_Grupo_Todos()



end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge479_ocupacao_enderecos
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge479_ocupacao_enderecos
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge479_ocupacao_enderecos
integer width = 2981
integer height = 2176
end type

event tab_1::selectionchanged;//OverRide
Choose Case newIndex
	Case 1
		Tab_1.TabPage_1.dw_2.of_SetMenu(Parent.ivm_Menu)
		Tab_1.TabPage_1.dw_2.SetFocus()

	Case 2
		Tab_1.TabPage_2.dw_3.reset()
		Tab_1.TabPage_2.dw_3.of_SetMenu(Parent.ivm_Menu)
		Tab_1.TabPage_2.dw_3.SetFocus()		
		Tab_1.TabPage_2.dw_3.event ue_recuperar()
		
End Choose
end event

event tab_1::selectionchanging;
//OverRide
Choose Case newIndex
	Case 1
	Case 2
		
		If Tab_1.TabPage_1.dw_2.GetRow() <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			Return 1
		End If
				
End Choose


end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 2944
integer height = 2060
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 504
integer width = 2213
integer height = 1540
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 2213
integer height = 484
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 1554
integer height = 396
string dataobject = "dw_ge479_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Tab_1.TabPage_1.dw_2.Reset()
Tab_1.TabPage_2.dw_3.Reset()

ivm_Menu.mf_salvarcomo(False)
ivm_Menu.mf_imprimir(False)

Choose Case dwo.Name
	Case "nm_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.Nm_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
			
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	This.Object.Nm_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.nm_produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
	End Choose
End If
end event

event dw_1::editchanged;call super::editchanged;Tab_1.TabPage_1.dw_2.Reset()
Tab_1.TabPage_2.dw_3.Reset()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 560
integer width = 2149
integer height = 1472
string dataobject = "dw_ge479_lista"
end type

event dw_2::constructor;call super::constructor;ivb_ordena_colunas = True

end event

event dw_2::ue_recuperar;//OverRide
				
Long	ll_Produto,&
		ll_Linhas
		
String ls_Endereco,&
		 ls_Sem_Saldo,&
		 ls_Grupo,&
		 ls_cd

Long ll_cd[]
Long ll_null[]

dw_1.AcceptText()

// Campos para os Filtros
ll_Produto		= dw_1.Object.cd_produto					[1]
ls_Endereco		= dw_1.Object.cd_endereco				[1]
ls_Sem_Saldo	= dw_1.Object.id_semsaldo					[1]
ls_Grupo			= dw_1.Object.Cd_Grupo					[1]
ls_CD				= dw_1.Object.cd_centro_distribuicao	[1]

ll_cd[] = ll_null[]

If	ls_CD = "0" Then
	wf_verifica_cds(Ref ll_cd[])
Else
    ll_cd[1] = Long(ls_CD)
End If

// Filtro por Produto
If Not IsNull(ll_Produto) Then
		This.of_appendwhere_subquery( " g.cd_produto = "+String(ll_Produto),10)		
End If

// Para filtro do Endereco
If Not IsNull(ls_Endereco) and ls_Endereco <> "" Then
	This.of_appendwhere_subquery (" a.cd_endereco = '" + String(ls_Endereco)+"'",10)	 
End If


// Para grupo de produtos
If Not IsNull(ls_Grupo) and ls_Grupo <> "0" Then
	This.of_appendwhere_subquery("substring(g.cd_subcategoria, 1, 1) = '" + ls_Grupo + "'", 10)
End If
	
// Para filtro Sem Saldo
If Not IsNull(ls_Sem_Saldo) and ls_Sem_Saldo <> "0" Then
	If ls_Sem_Saldo="S" Then 
		This.of_appendwhere_subquery(" a.cd_endereco not in ( select cd_endereco from wms_localizacao )     ",10)	
	End If
End If

ll_Linhas = dw_2.Retrieve(ll_cd[])

If ll_Linhas	> 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
	This.ivo_Controle_Menu.of_Imprimir(True)
End If
 
Return ll_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;	
String ls_Endereco,&
		 ls_Sem_Saldo,&
		 ls_Grupo
		

dw_1.AcceptText()

// Campos para os Filtros
ls_Sem_Saldo = dw_1.Object.id_semsaldo	[1]
ls_Grupo    	 = dw_1.Object.Cd_Grupo  	[1]


// Para grupo de produtos
If Not IsNull(ls_Grupo) and ls_Grupo <> "0" Then
	If ls_Sem_Saldo = "S" Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para selecionar Grupo de Produtos os Endere$$HEX1$$e700$$ENDHEX$$os n$$HEX1$$e300$$ENDHEX$$o podem estar vazios!")	
		Return -1	
	End If 
End If


Return 1
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 2944
integer height = 2060
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 2917
integer height = 1564
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 2866
integer height = 1492
string dataobject = "dw_ge479_detalhes"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;//OverRide

String ls_Endereco
Long 	 ll_Valor
ls_Endereco = tab_1.tabpage_1.dw_2.object.cd_endereco[tab_1.tabpage_1.dw_2.GetRow()]
ll_Valor = tab_1.tabpage_1.dw_2.object.valor[tab_1.tabpage_1.dw_2.GetRow()]


If ll_Valor  = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este Endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui Produtos!")	
	Return -1
Else
	this.Retrieve (ls_Endereco)
End If


	
Return 1
end event

