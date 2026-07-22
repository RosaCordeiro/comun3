HA$PBExportHeader$w_ge267_consulta_fornecedor.srw
forward
global type w_ge267_consulta_fornecedor from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_1 from commandbutton within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_3
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_5 gb_5
gb_4 gb_4
dw_4 dw_4
dw_5 dw_5
end type
end forward

global type w_ge267_consulta_fornecedor from dc_w_2tab_consulta_selecao_lista_det
integer width = 4553
integer height = 2476
string title = "GE267 - Consulta Fornecedor"
boolean resizable = false
end type
global w_ge267_consulta_fornecedor w_ge267_consulta_fornecedor

type variables
DataWindowChild	idwc_Child

uo_cidade ivo_cidade
uo_fornecedor ivo_fornecedor
uo_ge149_Comprador io_Comprador
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public function boolean wf_verifica_possui_divisao (ref long al_achou)
public subroutine wf_lista_divisao_fornecedor ()
public subroutine wf_carrega_contato ()
end prototypes

public subroutine wf_insere_padrao ();/* Estado */
idwc_Child  = Tab_1.tabpage_1.Dw_1.of_InsertRow_DDDW("cd_uf" )			

idwc_Child.SetItem(1, "cd_unidade_federacao", "T"	)
idwc_Child.SetItem(1, "nm_unidade_federacao", "TODOS")

Tab_1.tabpage_1.dw_1.Object.cd_uf[1] = "T"
end subroutine

public function boolean wf_verifica_possui_divisao (ref long al_achou);String ls_Fornecedor

Tab_1.TabPage_1.dw_2.AcceptText()

ls_Fornecedor = Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]

Select Count(*)
	Into :al_Achou
From fornecedor_divisao
Where cd_fornecedor = :ls_Fornecedor
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao consultar a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_possui_divisao")
	Return False
End If

Return True
end function

public subroutine wf_lista_divisao_fornecedor ();DataWindowChild lvdwc

String ls_SQL, ls_Fornecedor

Tab_1.TabPage_1.dw_2.AcceptText()

ls_Fornecedor = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_1.GetRow()]
	
If Tab_1.TabPage_3.dw_5.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
		
	ls_SQL = " SELECT 	cast(f.nr_divisao as char(5)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao, f.nr_divisao FROM fornecedor_divisao f   " +&
				 " inner join usuario u on u.nr_matricula = f.nr_matricula_comprador " +&
				 " where f.cd_fornecedor = '" + string(ls_Fornecedor) + "'" +&
				 " union " +&
				 " select 'NENHUMA', null"				 
	
	lvdwc.SetSQLSelect(ls_SQL)
		
	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return 
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild divis$$HEX1$$e300$$ENDHEX$$o fornecedor.")
End If
end subroutine

public subroutine wf_carrega_contato ();Long ll_Divisao

String ls_Fornecedor

Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_3.dw_5.AcceptText()

ls_Fornecedor	= Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
ll_Divisao			= Tab_1.TabPage_3.dw_5.Object.Nr_Divisao_Fornecedor[1]
		
Tab_1.TabPage_3.dw_4.of_restoreoriginalsql()
		
If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	Tab_1.TabPage_3.dw_4.of_AppendWhere("nr_divisao_fornecedor = " +  String(ll_Divisao))
Else
	Tab_1.TabPage_3.dw_4.of_AppendWhere("nr_divisao_fornecedor is null ")
End If	

Tab_1.TabPage_3.dw_4.Retrieve(ls_Fornecedor)
end subroutine

on w_ge267_consulta_fornecedor.create
int iCurrent
call super::create
end on

on w_ge267_consulta_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivl_largura_1 = 4496
//ivl_largura_1 = 4096
ivl_largura_2 = 2670
ivl_altura_1 = 2252
ivl_altura_2 = 2125

ivo_fornecedor = Create uo_fornecedor
ivo_cidade		= Create uo_Cidade
end event

event close;call super::close;Destroy(ivo_fornecedor)
Destroy(ivo_cidade)
Destroy(io_Comprador)
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

event open;call super::open;Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_3.dw_4.ivo_Controle_Menu.of_Recuperar(False)

io_Comprador =  Create uo_ge149_Comprador

Tab_1.TabPage_3.dw_5.Event ue_AddRow()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge267_consulta_fornecedor
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge267_consulta_fornecedor
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge267_consulta_fornecedor
integer y = 12
integer width = 4517
integer height = 2292
tabpage_3 tabpage_3
end type

event tab_1::selectionchanged;call super::selectionchanged;//Override

SetPointer(HourGlass!)

Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_3.dw_5.AcceptText()

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
		Tab_1.TabPage_1.dw_2.ivm_menu.mf_salvarcomo(Tab_1.TabPage_1.dw_2.RowCount()>0)
		
		Tab_1.TabPage_3.dw_5.Reset()
		Tab_1.TabPage_3.dw_5.InsertRow(0)
		Tab_1.TabPage_3.dw_5.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		Tab_1.TabPage_1.dw_2.ivm_menu.mf_salvarcomo(False)
	Case 3
		
		This.Width  = 3500
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_3.dw_4.Width	= 3350
		Tab_1.TabPage_3.gb_4.Width 	= 3400
		Tab_1.TabPage_3.Width  		= 3450
		
		Tab_1.TabPage_3.dw_4.SetFocus()
		Tab_1.TabPage_3.dw_4.ivm_menu.mf_salvarcomo(Tab_1.TabPage_3.dw_4.RowCount()>0)
				
		wf_Lista_Divisao_Fornecedor()
		
		wf_Carrega_Contato()
End Choose
	
Parent.Width  = This.Width + 65
Parent.Height = This.Height + 145

SetPointer(Arrow!)
end event

on tab_1.create
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
end on

event tab_1::selectionchanging;//OverRide
SetPointer(HourGlass!)

Choose Case NewIndex
	Case 2
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
		
	Case 3
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
			Tab_1.TabPage_3.dw_5.Event ue_Retrieve()
			Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
	
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os contatos.", StopSign!)
			Return 1
		End If
End Choose	

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4480
integer height = 2176
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 508
integer width = 4439
integer height = 1652
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 4000
integer height = 492
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 3918
integer height = 404
string dataobject = "dw_ge267_selecao"
end type

event dw_1::ue_key;call super::ue_key;Long lvl_Cidade

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.id_selecao_cadastro = "S"
			
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
						
			If ivo_Fornecedor.Localizado Then
				This.Object.cd_fornecedor [1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.nm_fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
				This.Object.cd_fornecedor_sap[1] = ivo_fornecedor.cd_fornecedor_sap
				
				lvl_Cidade = This.Object.cd_cidade[1]
				If (lvl_Cidade > 0)and(lvl_Cidade <>ivo_fornecedor.cd_cidade) then
					ivo_cidade.of_Inicializa()
					
					This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
					This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade			
				End If
				This.Object.cd_uf	[1] = "T"
			End If
		Case "nm_cidade"
			ivo_Cidade.of_Localiza_Cidade(This.GetText())
			
			If ivo_Cidade.Localizada Then
				This.Object.Cd_Cidade	[1] = ivo_Cidade.Cd_Cidade
				This.Object.Nm_Cidade	[1] = ivo_Cidade.Nm_Cidade
				This.Object.cd_uf			[1] = ivo_Cidade.Cd_Unidade_Federacao
			End If
			
		Case "nm_comprador"
			io_Comprador.of_Localiza_Comprador(This.GetText())
			
			If io_Comprador.Localizado Then
				This.Object.Nr_Matricula		[1] = io_Comprador.Nr_Matricula
				This.Object.Nm_Comprador	[1] = io_Comprador.Nm_Usuario
			Else
				io_Comprador.of_Inicializa()
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_fornecedor.of_Inicializa()
			
			This.Object.cd_fornecedor		[1] = ivo_fornecedor.cd_fornecedor
			This.Object.nm_fornecedor		[1] = ivo_fornecedor.nm_fantasia
			This.Object.cd_fornecedor_sap [1] = ivo_fornecedor.cd_fornecedor_sap	 
		End If
	Case "nm_cidade"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cidade.nm_cidade Then
				Return 1
			End If
		Else
			ivo_cidade.of_Inicializa()
			
			This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
			This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade
		End If
	Case "cd_uf"
		ivo_cidade.of_Inicializa()
		
		This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
		This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade
		
	Case "nm_comprador"		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula		[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Comprador	[1] = io_Comprador.Nm_Usuario
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_fornecedor) Then
	This.Object.Nm_Fornecedor[1] = ivo_fornecedor.Nm_Razao_Social
End If

If IsValid(ivo_cidade) Then
	This.Object.nm_cidade [1] = ivo_cidade.nm_cidade
End If
end event

event dw_1::constructor;call super::constructor;This.of_setcolselection(True)
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_reset()

Choose Case dwo.Name
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_fornecedor.of_Inicializa()
			This.Object.cd_fornecedor		[1] = ivo_fornecedor.cd_fornecedor
			This.Object.nm_fornecedor		[1] = ivo_fornecedor.nm_fantasia
			This.Object.cd_fornecedor_sap[1]  = ivo_fornecedor.cd_fornecedor_sap
		End If
	Case "nm_cidade"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cidade.nm_cidade Then
				Return 1
			End If
		Else
			ivo_cidade.of_Inicializa()
			
			This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
			This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade
		End If
	Case "cd_uf"
		ivo_cidade.of_Inicializa()
		
		This.Object.cd_cidade	[1] = ivo_cidade.cd_cidade
		This.Object.nm_cidade	[1] = ivo_cidade.nm_cidade
		
	Case "nm_comprador"		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula		[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Comprador	[1] = io_Comprador.Nm_Usuario
		End If
End Choose
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 55
integer y = 572
integer width = 4389
integer height = 1560
string dataobject = "dw_ge267_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Cidade

String lvs_UF
String lvs_Natureza
String lvs_Situacao
String lvs_Distribuidora
String lvs_Fornecedor
String ls_Nr_Matricula
String ls_Utiliza_Agend_Entrega
String ls_Cd_Fornecedor_SAP
String lvs_Fabricante
String lvs_Simples
String lvs_Reg_Especial

Parent.dw_1.accepttext( )

lvs_UF							= Parent.dw_1.Object.cd_uf										[1]
lvs_Natureza					= Parent.dw_1.Object.id_fisica_juridica						[1]
lvs_Situacao						= Parent.dw_1.Object.id_situacao								[1]
lvl_Cidade						= Parent.dw_1.Object.cd_cidade								[1]
lvs_Fornecedor					= Parent.dw_1.Object.cd_fornecedor							[1]
lvs_Distribuidora				= Parent.dw_1.Object.id_distribuidora						[1]
ls_Nr_Matricula					= Parent.dw_1.Object.Nr_Matricula							[1]
ls_Utiliza_Agend_Entrega	= Parent.dw_1.Object.Id_Utiliza_Agendamento_Entrega	[1]
ls_Cd_Fornecedor_SAP		= Parent.dw_1.Object.cd_fornecedor_sap					[1]
lvs_Fabricante					= Parent.dw_1.Object.id_atividade_economica				[1]
lvs_Simples						= Parent.dw_1.Object.id_regime_tributario					[1]
lvs_Reg_Especial				= Parent.dw_1.Object.id_regime_especial					[1]

If lvl_Cidade > 0 Then
	This.of_appendwhere("f.cd_cidade = "+String(lvl_Cidade))
ElseIf lvs_UF <> "T" Then
	This.of_appendwhere("c.cd_unidade_federacao ='"+lvs_UF+"'")
End If

If Trim(lvs_Fornecedor)<>"" Then
	This.of_appendwhere("f.cd_fornecedor='"+lvs_Fornecedor+"'")
End If

If Trim(ls_Cd_Fornecedor_SAP)<>"" Then
	This.of_appendwhere("f.cd_fornecedor_sap='"+ls_Cd_Fornecedor_SAP+"'")
End If

If lvs_Distribuidora = "S" Then
	This.of_appendwhere("f.id_distribuidora='"+lvs_Distribuidora+"'")
End If

If lvs_Situacao <> "T" Then
	This.of_appendwhere("coalesce(f.id_situacao,'A')='"+lvs_Situacao+"'")
End If

If lvs_Natureza <> "T" Then
	This.of_appendwhere("f.id_fisica_juridica='"+lvs_Natureza+"'")
End If

If lvs_Fabricante <> "" Then
	This.of_appendwhere("coalesce(f.id_atividade_economica,'0')='"+lvs_Fabricante+"'")
End If

If Not IsNull(ls_Nr_Matricula) And ls_Nr_Matricula <> "" Then
	This.of_Appendwhere("(f.nr_matricula_comprador = '" + ls_Nr_Matricula + "' or cd_fornecedor in (select cd_fornecedor from fornecedor_divisao where nr_matricula_comprador = '" + ls_Nr_Matricula + "'))")
End If

If ls_Utiliza_Agend_Entrega = "S" Then
	This.of_AppendWhere("f.id_utiliza_agendamento_entrega = 'S'")
End If

If lvs_Simples <> "" Then
	This.of_AppendWhere("coalesce(f.id_regime_tributario,'2') ='"+lvs_Simples+"'")
End If

If lvs_Reg_Especial <> "" Then
	This.of_AppendWhere("coalesce(f.id_regime_especial,'N') ='"+lvs_Reg_Especial+"'")
End If

This.ivm_menu.mf_salvarcomo(False)

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_Imprimir(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivo_controle_menu.of_salvarcomo(False)
This.ivo_controle_menu.of_imprimir(False)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4480
integer height = 2176
cb_1 cb_1
end type

on tabpage_2.create
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_1)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 1989
integer height = 1952
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 1906
integer height = 1872
string dataobject = "dw_ge267_detalhes_fornecedor"
end type

event dw_3::ue_recuperar;//override
Long lvl_Linha

String lvs_Fornecedor

lvl_Linha 			= Tab_1.Tabpage_1.dw_2.GetRow()
lvs_Fornecedor	= Tab_1.Tabpage_1.dw_2.Object.cd_fornecedor [lvl_Linha]

Return This.Retrieve(lvs_Fornecedor)
end event

event dw_3::itemchanged;call super::itemchanged;Return 0
end event

event dw_3::constructor;call super::constructor;This.Of_SetColSelection(True)
end event

event dw_3::clicked;call super::clicked;Tab_1.TabPage_1.dw_2.AcceptText()

If dwo.Name = "b_1" Then
	st_fornecedor str //ge192
	
	str.Cd_Fornecedor = Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
	
	OpenWithParm(w_ge192_lista_divisao, str)
End If
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;Long ll_Achou

If pl_Linhas > 0 Then
	If Not wf_Verifica_Possui_Divisao(Ref ll_Achou) Then
		Return -1
	End If
		
	If ll_Achou > 0 Then
		This.Object.Comprador_t.Visible = True
		This.Object.B_1.Visible = True
		This.Object.Nm_Comprador.Visible = False
	Else
		This.Object.Comprador_t.Visible = False
		This.Object.B_1.Visible = False
		This.Object.Nm_Comprador.Visible = True
	End If
End If
end event

type cb_1 from commandbutton within tabpage_2
integer x = 2057
integer y = 48
integer width = 526
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Consulta Hist$$HEX1$$f300$$ENDHEX$$rico"
end type

event clicked;Tab_1.TabPage_2.dw_3.AcceptText()

st_ge382_parametros str

str.Tabela[1] = 'FORNECEDOR'
str.Chave = Tab_1.TabPage_2.dw_3.Object.Cd_Fornecedor[1]

OpenWithParm(w_ge382_historico_alteracao, str)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4480
integer height = 2176
long backcolor = 67108864
string text = "Contatos"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_5 gb_5
gb_4 gb_4
dw_4 dw_4
dw_5 dw_5
end type

on tabpage_3.create
this.gb_5=create gb_5
this.gb_4=create gb_4
this.dw_4=create dw_4
this.dw_5=create dw_5
this.Control[]={this.gb_5,&
this.gb_4,&
this.dw_4,&
this.dw_5}
end on

on tabpage_3.destroy
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.dw_5)
end on

type gb_5 from groupbox within tabpage_3
integer x = 27
integer y = 8
integer width = 2034
integer height = 156
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within tabpage_3
integer x = 23
integer y = 164
integer width = 3397
integer height = 1448
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Contatos"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 41
integer y = 232
integer width = 3333
integer height = 1360
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge267_contatos"
boolean vscrollbar = true
end type

event ue_recuperar;//override
Long lvl_Linha

String lvs_Fornecedor

lvl_Linha 			= Tab_1.Tabpage_1.dw_2.GetRow()
lvs_Fornecedor	= Tab_1.Tabpage_1.dw_2.Object.cd_fornecedor [lvl_Linha]

Return This.Retrieve(lvs_Fornecedor)
end event

event constructor;call super::constructor;This.Of_SetRowSelection()
end event

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 56
integer width = 2011
integer height = 92
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge267_divisao_contato"
end type

event itemchanged;call super::itemchanged;wf_Carrega_Contato()
end event

