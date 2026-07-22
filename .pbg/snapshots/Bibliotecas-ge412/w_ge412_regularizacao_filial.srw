HA$PBExportHeader$w_ge412_regularizacao_filial.srw
forward
global type w_ge412_regularizacao_filial from dc_w_2tab_cadastro_selecao_lista_det
end type
type gb_5 from groupbox within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type gb_4 from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type cb_importar from commandbutton within tabpage_2
end type
type dw_6 from datawindow within tabpage_2
end type
end forward

global type w_ge412_regularizacao_filial from dc_w_2tab_cadastro_selecao_lista_det
string accessiblename = "Regulariza$$HEX2$$e700e300$$ENDHEX$$o de Filiais (GE412)"
integer width = 5819
integer height = 2556
string title = "GE412 - Regulariza$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
end type
global w_ge412_regularizacao_filial w_ge412_regularizacao_filial

type variables
Long il_Lojas
Long il_Linha_Dw_2
Long ivl_linhas

String is_Filiais
String is_Nulo



dc_uo_dw_base dw_1, dw_2, dw_3, dw_4, dw_5

uo_Filial io_Filial //ge009
end variables

forward prototypes
public function boolean wf_altera_documento (long al_filial, long al_documento, date dh_vencimento, string as_protocolo, string as_taxa, string as_psico, date as_vencimento_protocolo)
end prototypes

public function boolean wf_altera_documento (long al_filial, long al_documento, date dh_vencimento, string as_protocolo, string as_taxa, string as_psico, date as_vencimento_protocolo);long ll_Qtde
DateTime ldh_Data_Alteracao		  
String lvs_Matricula,&
			lvs_Nulo, &
			lvs_MSG

// Matricula do usu$$HEX1$$e100$$ENDHEX$$rio
lvs_Matricula = gvo_aplicacao.ivo_seguranca.nr_matricula 
ldh_Data_Alteracao = gf_GetServerDate()

// Verifica se j$$HEX1$$e100$$ENDHEX$$ tem o registro
select count (*) 
into :ll_Qtde
From documento_regulatorio_filial
Where cd_filial =: al_filial
and 	   cd_tipo_documento =:al_documento
Using SqlCA;


If (ll_Qtde=1) Then   
	// Combinado que Somente sera feita Atualiza$$HEX2$$e700e300$$ENDHEX$$o.	
	// 1: Alvar$$HEX1$$e100$$ENDHEX$$ Sanit$$HEX1$$e100$$ENDHEX$$rio
	// 2: CRF
	// 3: AFE
	// 4: ISOTRETINOINA
	
	Update documento_regulatorio_filial
	Set       dh_vencimento=: dh_vencimento,  
			   nr_matricula_alteracao=: lvs_Matricula,
			   dh_alteracao=: ldh_Data_Alteracao,
			   id_protocolo=:as_protocolo,
			   id_taxa=:as_taxa,
			   id_psico=:as_psico,
			   dh_vencimento_protocolo =:as_vencimento_protocolo	
	Where cd_filial =: al_filial
	And 	   cd_tipo_documento =:al_documento
	Using SqlCA;

	If SqlCa.SqlCode = -1 Then
	   lvs_MSG = 	"Atualiza$$HEX2$$e700e300$$ENDHEX$$o com problemas documento_regulatorio_filial '" +&
	   String(al_filial) + "' " + SQLCA.SQLErrText
 	   SqlCa.of_Rollback()
	   MessageBox("Erro", lvs_MSG, StopSign!)
	   Return False
	Else 
		SqlCa.of_commit( )
	End If

End If

Return true
end function

on w_ge412_regularizacao_filial.create
int iCurrent
call super::create
end on

on w_ge412_regularizacao_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_Filial = Create uo_Filial

dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
dw_4 = Tab_1.TabPage_2.dw_4
dw_5 = Tab_1.TabPage_1.dw_5
end event

event ue_preopen;call super::ue_preopen;ivl_Largura_1	= 5765
ivl_Altura_1		= 2376

ivl_Largura_2	= 1298
//ivl_Altura_2		= 744
ivl_Altura_2		= 900
end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_4, dw_5}
This.wf_SetUpdate_DW(lvo_Update)

dw_3.InsertRow(0)
dw_5.InsertRow(0)

dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_4.of_SetMenu(This.ivm_Menu)
dw_5.of_SetMenu(This.ivm_Menu)

dw_1.Object.Cd_Tipo_Documento.Protect = 1
dw_1.Object.Dh_Vencimento.Protect = 1
dw_1.Object.Id_Protocolo.Protect = 1
dw_1.Object.Id_Taxa.Protect = 1
dw_5.Object.De_Observacao.Protect = 1
end event

event ue_cancel;//OverRide

dw_3.Event ue_Cancel()
dw_4.Event ue_Cancel()
dw_5.Event ue_Cancel()
end event

event close;call super::close;Destroy(io_Filial)
end event

type dw_visual from dc_w_2tab_cadastro_selecao_lista_det`dw_visual within w_ge412_regularizacao_filial
end type

type gb_aux_visual from dc_w_2tab_cadastro_selecao_lista_det`gb_aux_visual within w_ge412_regularizacao_filial
end type

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge412_regularizacao_filial
integer width = 5742
integer height = 2344
end type

event tab_1::selectionchanged;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		Parent.ivb_Inclusao = False
End Choose
	
Parent.Width  = This.Width + This.X + 75	
Parent.Height = This.Height + This.Y + 155		

dw_1.ivo_Controle_Menu.of_Incluir(False)

SetPointer(Arrow!)
end event

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		If wf_Valida_Salva() > 0 Then
			If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
			dw_2.Event ue_Pos(il_Linha_Dw_2, "cd_filial")
			Return 0
		Else
			Return 1
		End If		
	Case 2
		If Not Parent.ivb_Inclusao Then
			If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
				// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW's de detalhes
				Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
				
				//Utilizado para quando voltar para a aba sele$$HEX2$$e700e300$$ENDHEX$$o o foco esteja na filial que estava selecionada
				If dw_2.RowCount() > 0 Then
					il_Linha_Dw_2 = dw_2.GetRow()
				End If
		
				// Permite a troca do folder
				Return 0
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
				// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
				Return 1
			End If
		End If
End Choose

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer width = 5705
integer height = 2228
gb_5 gb_5
dw_5 dw_5
end type

on tabpage_1.create
this.gb_5=create gb_5
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.dw_5
end on

on tabpage_1.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.dw_5)
end on

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer y = 436
integer width = 5650
integer height = 1516
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
integer width = 2459
integer height = 420
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
integer width = 2377
integer height = 328
string dataobject = "dw_ge412_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;DateTime ldh_Nulo

SetNull(ldh_Nulo)

Choose Case dwo.Name
	Case "id_filiais"
		
		If Data = 'C' Then
			
			il_Lojas = 0
		
			is_Filiais = is_Nulo
	
			uo_ge216_filiais uo_filiais			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			il_Lojas = Message.DoubleParm
			
			If il_Lojas > 0 Then
				is_Filiais = uo_Filiais.ivs_filiais
				
				io_Filial.of_Inicializa()
	
				This.Object.cd_Filial	[1] = io_Filial.cd_Filial
				This.Object.nm_Fantasia	[1] = io_Filial.nm_Fantasia				
			Else
				This.Object.id_filiais	[1] = "T"	
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
		End If
		
		Case "nm_fantasia"
			If Not IsNull(Data) and Trim(Data) <> "" Then
				If Data <> io_Filial.nm_Fantasia Then
					Return 1
				End If
			Else
				io_Filial.of_Inicializa()
				
				This.Object.cd_Filial			[1] = io_Filial.cd_Filial
				This.Object.nm_Fantasia		[1] = io_Filial.nm_Fantasia
			End If
		
	Case "cd_tipo_documento"
		dw_1.Object.Id_Protocolo.Visible = True
		dw_1.Object.Id_Protocolo_t.Visible = True
	
		dw_1.Object.Id_Taxa.Visible = True
		dw_1.Object.Id_Taxa_t.Visible = True
		
		dw_1.Object.Id_Protocolo	[1] = "T"
		dw_1.Object.Id_Taxa			[1] = "T"
		
		If Data = String(4) Then
			dw_1.Object.Id_Protocolo.Visible = False
			dw_1.Object.Id_Protocolo_t.Visible = False
			
			dw_1.Object.Id_Taxa.Visible = False
			dw_1.Object.Id_Taxa_t.Visible = False
		End If
			
	Case "id_vencimento"
			
		//Controles de tela. Desabilita e habilita os list box
		If Data = "V" Then
			dw_1.Object.Cd_Tipo_Documento.Protect = 0
			dw_1.Object.Dh_Vencimento.Protect = 0
			dw_1.Object.Id_Protocolo.Protect = 0
			dw_1.Object.Id_Taxa.Protect = 0
			dw_1.Modify("cd_tipo_documento.background.color =16777215~trgb(255.255.255)")
			dw_1.Modify("dh_vencimento.background.color =16777215~trgb(255.255.255)")
			dw_1.Modify("id_protocolo.background.color =16777215~trgb(255.255.255)")
			dw_1.Modify("id_taxa.background.color =16777215~trgb(255.255.255)")
			
			dw_1.Object.Dh_Vencimento[1] = gf_GetServerDate()
		Else
			dw_1.Object.Cd_Tipo_Documento.Protect = 1
			dw_1.Object.Dh_Vencimento.Protect = 1
			dw_1.Object.Id_Protocolo.Protect = 1
			dw_1.Object.Id_Taxa.Protect = 1
			dw_1.Modify("cd_tipo_documento.background.color =12698049~trgb(205.205.205)")
			dw_1.Modify("dh_vencimento.background.color =12698049~trgb(205.205.205)")
			dw_1.Modify("id_protocolo.background.color =12698049~trgb(205.205.205)")
			dw_1.Modify("id_taxa.background.color =12698049~trgb(205.205.205)")
			
			//Valores default
			dw_1.Object.Cd_Tipo_Documento[1] = 1
			dw_1.Object.Dh_Vencimento[1] = ldh_Nulo
			dw_1.Object.Id_Protocolo[1] = "T"
			dw_1.Object.Id_Taxa[1] = "T"
		End If
End Choose

dw_2.Reset()
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Filial.nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.cd_Filial			[1] = io_Filial.cd_Filial
			This.Object.nm_Fantasia		[1] = io_Filial.nm_Fantasia
		End If
End Choose

dw_2.Reset()
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
	
		io_Filial.of_Localiza_Filial( This.GetText() )
	
		If io_Filial.Localizada Then
			This.Object.cd_Filial		[1] = io_Filial.cd_Filial
			This.Object.nm_Fantasia	[1] = io_Filial.nm_Fantasia
			
			This.Object.id_filiais	[1] = "T"		
			is_filiais = is_nulo
		End If
	End If
End If

dw_2.Reset()
end event

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer y = 516
integer width = 5568
integer height = 1412
string dataobject = "dw_ge412_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Vencimento

Long ll_Tipo
Long ll_Filial

String ls_Conjunto
String ls_Id_Venc
String ls_Protocolo
String ls_Taxa

dw_1.AcceptText()

ls_Conjunto			= dw_1.Object.Id_Filiais					[1]
ll_Tipo				= dw_1.Object.Cd_Tipo_Documento	[1]
ls_Id_Venc			= dw_1.Object.Id_Vencimento			[1]
ldh_Vencimento	= dw_1.Object.Dh_Vencimento			[1]
ls_Protocolo			= dw_1.Object.Id_Protocolo				[1]
ls_Taxa				= dw_1.Object.Id_Taxa					[1]
ll_Filial				= dw_1.Object.Cd_Filial					[1]

If ls_Conjunto <> "T" Then
	If il_Lojas > 0 Then
		dw_2.of_AppendWhere_SubQuery("f.cd_filial in (" + is_Filiais + ")", 12)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma filial.")
		Return -1
	End If
End If

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	dw_2.of_AppendWhere_SubQuery("f.cd_filial = " + String(ll_Filial), 12)
End If

If ls_Id_Venc <> "T" Then
	
	If IsNull(ldh_Vencimento) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de vencimento.", Exclamation!)
		dw_1.Event ue_Pos(1, "dh_vencimento")
		Return -1
	End If
	
	If ll_Tipo > 0 Then
		dw_2.of_AppendWhere_SubQuery("exists (select * from  documento_regulatorio_filial a" + &
													" where a.cd_filial = f.cd_filial" + &
													" and a.cd_tipo_documento = " + String(ll_Tipo) + &
													" and (a.dh_vencimento is null or dh_vencimento <= '" + String(ldh_Vencimento, "yyyymmdd") + "'))", 12)
	End If
		
	If ls_Protocolo <> "T" Then
		dw_2.of_AppendWhere_SubQuery(" a.id_protocolo = '" + ls_Protocolo + "'", 13)
	End If
	
	If ls_Taxa <> "T" Then
		dw_2.of_AppendWhere_SubQuery(" a.id_taxa = '" + ls_Taxa + "'", 13)
	End If
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
	dw_5.Object.De_Observacao.Protect = 0
Else
	dw_5.Object.De_Observacao.Protect = 1
End If

dw_1.ivo_Controle_Menu.of_Incluir(False)

Return pl_Linhas
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_5.Event ue_Retrieve()
End If
end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer width = 5705
integer height = 2228
gb_4 gb_4
dw_4 dw_4
cb_importar cb_importar
dw_6 dw_6
end type

on tabpage_2.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.cb_importar=create cb_importar
this.dw_6=create dw_6
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_importar
this.Control[iCurrent+4]=this.dw_6
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.cb_importar)
destroy(this.dw_6)
end on

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer width = 1051
integer height = 184
integer weight = 700
string facename = "Verdana"
string text = "Documentos"
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer x = 59
integer width = 974
integer height = 92
string dataobject = "dw_ge412_filtro_detalhe"
end type

event dw_3::itemchanged;call super::itemchanged;This.ivs_Coluna_Sem_Validacao_Salva = {"cd_tipo_documento"}

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

SetRedraw(False)

Choose Case dwo.Name
	Case "cd_tipo_documento"
		
		dw_4.Object.Id_Protocolo.Visible = True
		dw_4.Object.Id_Protocolo_t.Visible = True
	
		dw_4.Object.Id_Taxa.Visible = True
		dw_4.Object.Id_Taxa_t.Visible = True
		
		dw_4.Object.Id_Psico.Visible = True
		dw_4.Object.Id_Psico_t.Visible = True
		
		dw_4.Object.Dh_Vencimento_Protocolo.Visible = False
		
		Choose Case Data
				
			Case String(2), String(3)
				dw_4.Object.Id_Psico.Visible = False
				dw_4.Object.Id_Psico_t.Visible = False
				
				dw_4.Object.Dh_Vencimento_Protocolo.Visible = False
				
			Case String(4)
				dw_4.Object.Id_Protocolo.Visible = False
				dw_4.Object.Id_Protocolo_t.Visible = False
				
				dw_4.Object.Id_Taxa.Visible = False
				dw_4.Object.Id_Taxa_t.Visible = False
				
				dw_4.Object.Id_Psico.Visible = False
				dw_4.Object.Id_Psico_t.Visible = False
				
				dw_4.Object.Dh_Vencimento_Protocolo.Visible = False
				
		End Choose
				
		dw_4.Event ue_Retrieve()		
End Choose

SetRedraw(True)
end event

event dw_3::editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;dw_4.ivo_Controle_Menu.of_Incluir(False)

Return pl_Linhas
end event

type gb_5 from groupbox within tabpage_1
integer x = 27
integer y = 1960
integer width = 2642
integer height = 256
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Observa$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 50
integer y = 2024
integer width = 2597
integer height = 184
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge412_observacao"
end type

event ue_recuperar;//OverRide

Long ll_Linha
Long ll_Filial

dw_2.AcceptText()

ll_Linha = dw_2.GetRow()

ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]

Return This.Retrieve(ll_Filial)
end event

event ue_preupdate;call super::ue_preupdate;Long ll_Linha
Long ll_Filial

dw_2.AcceptText()
This.AcceptText()

ll_Linha = dw_2.GetRow()

ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]

If IsNull(This.Object.De_Observacao[1]) Then
	This.Object.De_Observacao[1] = ""
End If

This.Object.Cd_Filial[1] = ll_Filial

Return 1
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas = 0 Then
	This.InsertRow(0)
End If

Return pl_Linhas
end event

event editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

type gb_4 from groupbox within tabpage_2
integer x = 23
integer y = 196
integer width = 1216
integer height = 556
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 59
integer y = 260
integer width = 1152
integer height = 352
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge412_detalhe"
end type

event ue_recuperar;//OverRide

Long ll_Linha
Long ll_Filial
Long ll_Tipo

dw_2.AcceptText()
dw_3.AcceptText()

ll_Linha = dw_2.GetRow()

ll_Filial = dw_2.Object.Cd_Filial				[ll_Linha]
ll_Tipo = dw_3.Object.Cd_Tipo_Documento	[1]

Return This.Retrieve(ll_Filial, ll_Tipo)
end event

event editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

event itemchanged;call super::itemchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)

Date ldt_Dia_Corrente

Choose Case dwo.Name
	Case "id_protocolo"
		
		If Data = "S" Then
			If dw_3.Object.Cd_Tipo_Documento[1] = 1 Then
				dw_4.Object.Dh_Vencimento_Protocolo.Visible = True
				
				ldt_Dia_Corrente = Date(gf_GetServerDate())
				ldt_Dia_Corrente = RelativeDate(ldt_Dia_Corrente, 90)
				
				dw_4.Object.Dh_Vencimento_Protocolo[1] = DateTime(ldt_Dia_Corrente)
			Else
				dw_4.Object.Dh_Vencimento_Protocolo.Visible = False
			End If
		Else
			dw_4.Object.Dh_Vencimento_Protocolo.Visible = False
		End If
End Choose
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas = 0 Then
	This.InsertRow(0)
End If

If dw_3.Object.Cd_Tipo_Documento[1] = 1 Then
	If dw_4.Object.Id_Protocolo[1] = "S" Then
		dw_4.Object.Dh_Vencimento_Protocolo.Visible = True
	Else
		dw_4.Object.Dh_Vencimento_Protocolo.Visible = False
	End If
Else
	dw_4.Object.Dh_Vencimento_Protocolo.Visible = False
End If

dw_4.ivo_Controle_Menu.of_Incluir(False)

Return pl_Linhas
end event

event ue_preupdate;call super::ue_preupdate;DateTime ldh_Vencimento
DateTime ldh_Dia_Corrente
DateTime ldh_Vencimento_Protocolo
DateTime ldh_Nulo

Long ll_Tipo
Long ll_Linha
Long ll_Filial
Long ll_Filial_Dw_2

String ls_Nulo
String ls_Protocolo
String ls_Taxa
String ls_Psico
String ls_ValorPara

dw_2.AcceptText()
dw_4.AcceptText()

SetNull(ls_Nulo)
SetNull(ldh_Nulo)

ll_Linha = dw_2.GetRow()
ldh_Dia_Corrente = DateTime(Date(gf_GetServerDate()))

ll_Filial_Dw_2					= dw_2.Object.Cd_Filial							[ll_Linha]
ll_Tipo							= dw_3.Object.Cd_Tipo_Documento			[1]
ll_Filial							= dw_4.Object.Cd_Filial							[1]
ldh_Vencimento				= dw_4.Object.Dh_Vencimento					[1]
ls_Protocolo						= dw_4.Object.Id_Protocolo						[1]
ls_Taxa							= dw_4.Object.Id_Taxa							[1]
ls_Psico							= dw_4.Object.Id_Psico							[1]
ldh_Vencimento_Protocolo	= dw_4.Object.Dh_Vencimento_Protocolo	[1]

If (gf_Houve_Alteracao_Dw(This, 'DH_VENCIMENTO', 1, Ref ls_ValorPara)) Then
	If ldh_Vencimento < ldh_Dia_Corrente Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de vencimento n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data corrente.", Exclamation!)
		dw_4.Event ue_Pos(1, "dh_vencimento")
		Return -1
	End If
End If

//Se for filial nova pega o c$$HEX1$$f300$$ENDHEX$$digo da filial selecionada na dw_2
If (IsNull(ll_Filial)) Or (ll_Filial = 0) Then
	ll_Filial = ll_Filial_Dw_2
End If

//S$$HEX1$$f300$$ENDHEX$$ existe psico quando for Alvar$$HEX1$$e100$$ENDHEX$$
If ll_Tipo <> 1 Then
	ls_Psico = ls_Nulo
End If

//Alvar$$HEX1$$e100$$ENDHEX$$ tem a data de vencimento do documento (dh_vencimento) e a data de vencimento do procotolo (dh_vencimento_protocolo)
If (gf_Houve_Alteracao_Dw(This, 'DH_VENCIMENTO_PROTOCOLO', 1, Ref ls_ValorPara)) Then
	If (ll_Tipo = 1) And (ls_Protocolo = "S") Then
		If ldh_Vencimento_Protocolo < ldh_Dia_Corrente Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de vencimento do protocolo n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data corrente.", Exclamation!)
			dw_4.Event ue_Pos(1, "dh_vencimento_protocolo")
			Return -1
		End If
	End If
End If

If ll_Tipo = 1 Then
	If ls_Protocolo = "S" And IsNull(ldh_Vencimento_Protocolo) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Protocolo est$$HEX1$$e100$$ENDHEX$$ como 'SIM', portanto dever$$HEX1$$e100$$ENDHEX$$ ser preenchida a data de vencimento do protocolo.", Exclamation!)
		dw_4.Event ue_Pos(1, "dh_vencimento_protocolo")
		Return -1
	End If
End If

//Se o tipo for Isotretino$$HEX1$$ed00$$ENDHEX$$na somente a data de vencimento ser$$HEX1$$e100$$ENDHEX$$ preenchida
If ll_Tipo = 4 Then
	ls_Protocolo	= ls_Nulo
	ls_Taxa		= ls_Nulo
End If

dw_4.Object.Cd_Filial						[1] = ll_Filial
dw_4.Object.Cd_Tipo_Documento		[1] = ll_Tipo
dw_4.Object.Dh_Vencimento			[1] = ldh_Vencimento
dw_4.Object.Id_Protocolo				[1] = ls_Protocolo
dw_4.Object.Id_Taxa						[1] = ls_Taxa
dw_4.Object.Id_Psico						[1] = ls_Psico
dw_4.Object.Nr_Matricula_Alteracao	[1] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
dw_4.Object.Dh_Alteracao				[1] = gf_GetServerDate()

If (ll_Tipo = 1) And (ls_Protocolo = "S") Then
	dw_4.Object.Dh_Vencimento_Protocolo[1] = ldh_Vencimento_Protocolo
Else
	dw_4.Object.Dh_Vencimento_Protocolo[1] = ldh_Nulo
End If

Return 1
end event

type cb_importar from commandbutton within tabpage_2
integer x = 59
integer y = 628
integer width = 494
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar (.XLS)"
end type

event clicked;Integer lvi_Arquivo

long 	ll_Linhas,&
		ll_Linha,&
		ll_Tipo_Documento,&
		ll_Filial			
			
String 	lvs_Protocolo,&			
			lvs_Taxa,&
			lvs_Psico,&			
			lvs_Path,&
			lvs_Nome_Arquivo,&
			lvs_Msg,&
			lvs_Dado,&
			lvs_Arquivo,&
			lvs_Nulo			
			
Date	ldh_Vencimento,& 
		ldh_Vencimento_Protocolo,&
		ldh_Data_Alteracao,&
		ldh_Nulo		

SetNull(lvs_Nulo)
SetNull(ldh_Nulo)

ldh_Data_Alteracao = Date(gf_GetServerDate())
dw_4.accepttext( )

// Mensagem para Orienta$$HEX2$$e700e300$$ENDHEX$$o: Layout
MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Para atualizar os dados existentes devem estar da seguinte forma:~r~r" + &
                     	"Coluna A = *Filial.~r" + &
                     	"Coluna B = *Tipo   ( 1-Alvar$$HEX1$$e100$$ENDHEX$$, 2-CRF, 3-AFE, 4-ISOTRETINOINA.~r" + &
			      	"Coluna C = Vencimento.~r" + &
			      	"Coluna D = Protocolo.~r" + &	
			      	"Coluna E = Taxa.~r" + &	
			      	"Coluna F = Taxa.~r" + &	
					"Coluna G = Data Vencimento Protocolo")

lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo <> 1 Then Return

ivl_Linhas = 0
dw_6.Object.nm_arquivo[1] = lvs_Path

lvs_Msg = "Importar a planilha com os dados para as Filiais ?"
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

dw_6.AcceptText()
lvs_Arquivo = dw_6.Object.nm_arquivo [1]

dc_uo_excel lvo_Excel
lvo_Excel = Create dc_uo_excel
Open(w_Aguarde)

// Inicio Leitura Arquivo :  Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	ll_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
	
		For ll_Linha = 1 To ll_Linhas
								
			// Lendo os campos do Excel
			ll_Filial	 					= lvo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			ll_Tipo_Documento		=  lvo_Excel.uo_Lendo_Dados(ll_Linha, "B")
			ldh_Vencimento			= Date(lvo_Excel.uo_Lendo_Dados(ll_Linha, "C"))
			lvs_Protocolo				= String(lvo_Excel.uo_Lendo_Dados(ll_Linha, "D"))
			lvs_Taxa 	 				= String(lvo_Excel.uo_Lendo_Dados(ll_Linha, "E"))
			lvs_Psico					= String(lvo_Excel.uo_Lendo_Dados(ll_Linha, "F"))
			ldh_Vencimento_Protocolo =  Date(lvo_Excel.uo_Lendo_Dados(ll_Linha, "G"))
		     		 
			 			 
			// Valida$$HEX2$$e700f500$$ENDHEX$$es B$$HEX1$$e100$$ENDHEX$$sicas
			If IsNull(ll_Filial)  or  IsNull(ll_Tipo_Documento) or IsNull(ldh_Vencimento)   Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial/Tipo/Data de Vencimento est$$HEX1$$e300$$ENDHEX$$o invalidos.~rLinha do Arquivo: " + String(ll_Linha) + "~rLoja: " + String(ll_Filial))
				Exit
			End IF
			
			If (ll_Tipo_Documento<=0 or ll_Tipo_Documento>4) Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de Documento Inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha do Arquivo : " + String(ll_Linha) + "~rLoja: " + String(ll_Tipo_Documento))
				Exit
			End If 
						

				
			// Valida$$HEX2$$e700e300$$ENDHEX$$o para Tipo :  Alvar$$HEX1$$e100$$ENDHEX$$ Sanit$$HEX1$$e100$$ENDHEX$$rio
			If (ll_Tipo_Documento=1) Then 

				If lvs_Protocolo = "S" and  IsNull(ldh_Vencimento_Protocolo) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alvar$$HEX1$$e100$$ENDHEX$$ Sanit$$HEX1$$e100$$ENDHEX$$rio:Protocolo est$$HEX1$$e100$$ENDHEX$$ como 'SIM', portanto dever$$HEX1$$e100$$ENDHEX$$ ser preenchida a data de vencimento do protocolo.~rLinha do Arquivo: " + String(ll_Linha) + "~rLoja: " + String(ll_Filial))
					Exit
				End If
			
				/*If lvs_Protocolo = "S" and ldh_Vencimento_Protocolo < ldh_Data_Alteracao Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alvar$$HEX1$$e100$$ENDHEX$$ Sanit$$HEX1$$e100$$ENDHEX$$rio:A data de vencimento do protocolo n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data corrente.~rLinha do Arquivo: " + String(ll_Linha) + "~rLoja: " + String(ll_Filial))
					Exit
				End If*/		
								
				If (IsNull(lvs_Protocolo) or IsNull(lvs_Psico) or IsNull(lvs_Taxa)) Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alvar$$HEX1$$e100$$ENDHEX$$ Sanit$$HEX1$$e100$$ENDHEX$$rio:Protocolo/Taxa/Psico esta vazio, dever$$HEX1$$e100$$ENDHEX$$ ser preenchida (S/N).~rLinha do Arquivo: " + String(ll_Linha) + "~rLoja: " + String(ll_Filial))
			   		Exit
				End If 							
			End If 
				
			If (ll_Tipo_Documento=2 or ll_Tipo_Documento=3) Then 

				If (IsNull(lvs_Protocolo) or IsNull(lvs_Taxa)) Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "CRF/AFE:Taxa/Psico esta vazio , dever$$HEX1$$e100$$ENDHEX$$ ser preenchida (S/N).~rLinha do Arquivo: " + String(ll_Linha) + "~rLoja: " + String(ll_Filial))
			   		Exit
				End If 					
			End If 	
			
			
			//Se o tipo for Isotretino$$HEX1$$ed00$$ENDHEX$$na somente a data de vencimento ser$$HEX1$$e100$$ENDHEX$$ preenchida
			If ll_Tipo_Documento = 4 Then
					lvs_Protocolo	= lvs_Nulo
					lvs_Taxa		= lvs_Nulo
					lvs_Psico		= lvs_Nulo					
			End If		  
						
			//S$$HEX1$$f300$$ENDHEX$$ existe psico quando for Alvar$$HEX1$$e100$$ENDHEX$$
			If ll_Tipo_Documento <> 1 Then
			   	
				If (ldh_Vencimento < ldh_Data_Alteracao) Then   // N$$HEX1$$e300$$ENDHEX$$o valida datas para Alvar$$HEX1$$e100$$ENDHEX$$
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de vencimento n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data corrente.~rLinha do Arquivo: " + String(ll_Linha) + "~rLoja: " + String(ll_Filial))
					Exit
				End If				
				
				lvs_Psico = lvs_Nulo
			   	ldh_Vencimento_Protocolo = ldh_Nulo
			End If
							
			// Acessa Fun$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o	
			If Not wf_altera_documento(ll_Filial, ll_Tipo_Documento,ldh_Vencimento, lvs_Protocolo, lvs_Taxa, lvs_Psico, ldh_Vencimento_Protocolo ) Then 
			   MessageBox("Erro", "Erro na Atualiza$$HEX2$$e700e300$$ENDHEX$$o!", StopSign!)
			   Exit
			End If 	
			
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			
		Next
	End If    /// Final Linha

End If //Final Excel

Close(w_Aguarde)
Destroy(lvo_Excel)


end event

type dw_6 from datawindow within tabpage_2
boolean visible = false
integer x = 32
integer y = 768
integer width = 1961
integer height = 92
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge412_selecao_arquivo"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

