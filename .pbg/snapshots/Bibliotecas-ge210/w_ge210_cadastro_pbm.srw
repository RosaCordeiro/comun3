HA$PBExportHeader$w_ge210_cadastro_pbm.srw
forward
global type w_ge210_cadastro_pbm from dc_w_cadastro_lista
end type
type dw_2 from dc_uo_dw_base within w_ge210_cadastro_pbm
end type
type st_1 from statictext within w_ge210_cadastro_pbm
end type
type gb_2 from groupbox within w_ge210_cadastro_pbm
end type
end forward

global type w_ge210_cadastro_pbm from dc_w_cadastro_lista
string tag = "w_ge210_cadastro_pbm"
string accessiblename = "Cadastro de PBM e Produtos (GE210)"
integer x = 800
integer width = 3598
integer height = 2644
string title = "GE210 - Cadastro de PBM e Produtos"
dw_2 dw_2
st_1 st_1
gb_2 gb_2
end type
global w_ge210_cadastro_pbm w_ge210_cadastro_pbm

type variables
uo_Convenio ivo_Convenio
uo_Produto ivo_Produto

Boolean ib_PBM_DermaClub = False
end variables

forward prototypes
public function integer wf_proximo_pbm ()
public subroutine wf_gera_excel (datastore pds_excel)
public subroutine wf_set_somente_consulta ()
public subroutine wf_somente_leitura (boolean pb_permite_alterar, dc_uo_dw_base adw)
end prototypes

public function integer wf_proximo_pbm ();Long lvl_Proximo

Select Max(cd_pbm)
  Into :lvl_Proximo
From pbm
Using SQLCa;

Choose Case SQLCa.SQLCode 
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo do PBM.")
		Return -1
	Case 100
		lvl_Proximo = 1
	Case 0
		lvl_Proximo++
End Choose

Return lvl_Proximo
end function

public subroutine wf_gera_excel (datastore pds_excel);String ls_Path
String ls_Arquivo

Integer li_Retorno

li_retorno = GetFileSaveName('Arquivo', ls_Path, ls_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')

If li_retorno = 1 Then
	 
	 // Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
	 If FileExists(ls_Path) Then
		 If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + ls_Path + "' existente ?", Question!, YesNo!, 1) =  1 Then 
			  If Not FileDelete(ls_Path) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + ls_Path + "'.", StopSign!)
					Return
			  End If
		Else
			  Return 
		 End If   
	 End If
	 
	 
	 If pds_Excel.SaveAs( ls_Path, Excel!, True ) = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + ls_Path + "'.")
	 Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + ls_Path + "'.", StopSign!)
	 End If
	 
End If


end subroutine

public subroutine wf_set_somente_consulta ();dw_1.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
dw_2.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

public subroutine wf_somente_leitura (boolean pb_permite_alterar, dc_uo_dw_base adw);Boolean lvb_Protect

Long lvl_Count
Long lvl_Campo

String lvs_Coluna
String lvs_Tipo

If Not pb_permite_alterar Then
	lvb_Protect = True
Else
	lvb_Protect = False
End If

lvl_Count = Long(adw.Describe("DataWindow.Column.Count"))

For lvl_Campo = 1 To lvl_Count
	lvs_Coluna = "#"+String(lvl_Campo)+".Name"
	lvs_Coluna = adw.Describe(lvs_Coluna) 
	
//	lvb_Protect = True
//	For lvl_Coluna = 1 To UpperBound(This.ivs_Coluna_Sem_Validacao_Salva) 
//		If lvs_Coluna = ivs_Coluna_Sem_Validacao_Salva[lvl_Coluna] Then
//			lvb_Protect = False
//			Exit
//		End If
//	Next
	
	lvs_Tipo = Lower(adw.Describe(lvs_Coluna+".Edit.Style"))
	
	If lvb_Protect  Then		
		If (lvs_Tipo = 'editmask') or (lvs_Tipo = 'edit') Then
			adw.Modify(lvs_Coluna+".Edit.DisplayOnly=Yes")  
		Else
			adw.Modify(lvs_Coluna+".Protect='1~t1'")  
		End If
		
	Else
		
		If (lvs_Tipo = 'editmask') or (lvs_Tipo = 'edit') Then
			adw.Modify(lvs_Coluna+".Edit.DisplayOnly=No")  
		Else
			adw.Modify(lvs_Coluna+".Protect='0~t0'")  
		End If
	End If
NEXT	
end subroutine

on w_ge210_cadastro_pbm.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.st_1=create st_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.gb_2
end on

on w_ge210_cadastro_pbm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.gb_2)
end on

event ue_postopen;//Override
Integer lvl_PxWidth
Integer lvl_PxHeight
Integer lvl_UnWidth
Integer lvl_UnHeight

ivo_dbError = Create dc_uo_dbError

This.ivm_Menu.mf_Incluir(True)
This.ivm_Menu.mf_Recuperar(True)

dw_1.Event ue_Retrieve()
dw_2.Event ue_Retrieve()
dw_1.SetFocus()

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1, dw_2}
This.wf_SetUpdate_DW(lvo_Update)

/* Redimensiona Tela */
If (MaxWidth > 0)or(MaxHeight>0) Then
	gvo_aplicacao.of_retorna_resolucao_monitor(lvl_PxWidth,lvl_PxHeight)
	
	lvl_UnWidth	= PixelsToUnits(lvl_PxWidth,XPixelsToUnits!)
	lvl_UnHeight	= PixelsToUnits(lvl_PxHeight,YPixelsToUnits!)
	
	If (lvl_PxWidth <> 800)and(MaxWidth > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnWidth >= MaxWidth Then //Maior que tamanho ideal
			This.Width = MaxWidth
		Else 
			This.Width = lvl_UnWidth - 50
		End If
	End If
	
	If (lvl_PxHeight <> 600)and(MaxHeight > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnHeight >= MaxHeight Then //Maior que tamanho ideal
			This.Height = MaxHeight
		Else 
			This.Height = lvl_UnHeight - 650
		End If
	End If
End If

//Verifica se no grupo de acesso a tela est$$HEX1$$e100$$ENDHEX$$ sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o
// e seta como somente leitura os campos
wf_set_somente_consulta()
end event

event ue_save;call super::ue_save;dw_1.Enabled = True

Return AncestorReturnValue
end event

event ue_cancel;call super::ue_cancel;dw_1.Enabled = True

dw_1.Event ue_Retrieve()
end event

event ue_saveas;call super::ue_saveas;Long ll_Linhas

dc_uo_ds_Base lds_Excel
lds_Excel = Create dc_uo_ds_Base

If Not lds_Excel.of_ChangeDataObject("dw_ge210_excel") Then
	Destroy lds_Excel
	Return
End If

ll_Linhas = lds_Excel.Retrieve()

If ll_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve da DW dw_ge210_excel")
	Return
End If

If ll_Linhas > 0 Then wf_gera_excel( lds_Excel )	

Destroy lds_Excel

Return
end event

event ue_preopen;call super::ue_preopen;ivo_Convenio = Create uo_Convenio
ivo_Produto = Create uo_Produto

ivb_grava_log = True

MaxWidth = 5800
MaxHeight = 2464
end event

event resize;call super::resize;If MaxWidth > 0 Then
	//Ajusta a largura do GroupBox com a nova largura da tela - 30
	gb_2.Width = NewWidth - gb_2.X - 30
	gb_1.Width = NewWidth - gb_1.X - 30
	//Ajusta a largura da Datawindow com a nova largura da tela - 80
	Dw_2.Width = NewWidth - Dw_2.X - 80
	Dw_1.Width = NewWidth - Dw_1.X - 80
End If

If MaxHeight > 0 Then
	//Ajusta a altura do GroupBox com a nova altura da tela - altura dos filtros
	gb_2.Height = NewHeight - gb_2.Y - 30
	//Ajusta a altura da Datawindow com a nova altura da tela - altura dos filtros
	Dw_2.Height = NewHeight - Dw_2.Y - 80
End If
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge210_cadastro_pbm
integer y = 1292
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge210_cadastro_pbm
integer x = 27
integer y = 1900
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge210_cadastro_pbm
integer x = 73
integer y = 64
integer width = 3433
integer height = 1116
string dataobject = "dw_ge210_cadastro_pbm"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_1::ue_key;call super::ue_key;Long lvl_Nulo
Long lvl_Linha

String lvs_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)

If Key = KeyEnter! Then
	If This.getColumnName() = "nm_fantasia" Then
		lvl_Linha = This.GetRow()
		
		ivo_Convenio.of_Localiza_Convenio(This.GetText())
		
		If ivo_Convenio.localizado Then
			This.Object.cd_convenio[lvl_Linha] = ivo_Convenio.cd_convenio
			This.Object.nm_fantasia[lvl_Linha] = ivo_Convenio.nm_fantasia
		Else
			This.Object.cd_convenio[lvl_Linha] = lvl_Nulo
			This.Object.nm_fantasia[lvl_Linha] = lvs_Nulo
		End If
	End If	
End If
end event

event dw_1::ue_postretrieve;//Override
Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

Long	lvl_Linha, &
		lvl_Convenio

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Excluir = True
	
	ivm_Menu.mf_SalvarComo(True)

	This.SetRow(1)
	This.SetFocus()
Else
	This.Event ue_AddRow()
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(lvb_Excluir)

If ib_PBM_DermaClub Then
	Parent.ivm_Menu.mf_Excluir(False)
Else
	Parent.ivm_Menu.mf_Excluir(True)
End If

Return pl_Linhas
end event

event dw_1::ue_deleterow;call super::ue_deleterow;If This.RowCount() <= 0 Then
	This.Event ue_AddRow()
End If

dw_2.Event ue_Retrieve()

ivm_Menu.mf_Classificar(True)
ivm_Menu.mf_Filtrar(True)

Return AncestorReturnValue
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo
String lvs_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)

If dwo.Name = "nm_fantasia" Then
	ivo_Convenio.of_Localiza_Codigo(This.Object.cd_convenio[row])
	
	If ivo_Convenio.Localizado Then
		If Trim(Data) = "" Then
			This.Object.cd_convenio[Row] = lvl_Nulo
			This.Object.nm_Fantasia[Row] = lvs_Nulo
			Return -1
		Else
			If ivo_Convenio.nm_fantasia <> Data Then
				This.Object.nm_Fantasia[Row] = ivo_Convenio.nm_fantasia
				Return 1
			End If
		End If
	End If
End If


end event

event dw_1::ue_addrow;call super::ue_addrow;//Long lvl_Linha
//Long lvl_Find
//Long lvl_Proximo
//
//If AncestorReturnValue > 0 Then
//	lvl_Linha = This.RowCount()
//	
//	lvl_Proximo = wf_Proximo_PBM()
//	
//	If lvl_Proximo < 0 Then
//		Return -1
//	End If
//	
//	lvl_Find = This.Find("cd_pbm = " + String(lvl_Proximo), 1, lvl_Linha)
//	
//	If lvl_Find > 0 Then
//		lvl_Proximo = This.Object.cd_Max_Pbm[This.RowCount()]
//		lvl_Proximo++
//	End If
//		
//	This.Object.cd_pbm[lvl_Linha] = lvl_Proximo	
//End If

dw_1.AcceptText()

wf_Somente_leitura(True, dw_1)
ib_PBM_DermaClub = False
st_1.Visible = False

Return AncestorReturnValue
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;String lvs_PBM

If This.RowCount() > 0 Then
	This.AcceptText()
	lvs_PBM = This.Object.nm_PBM[This.RowCount()]
	
	If IsNull(lvs_PBM) Or Trim(lvs_PBM) = "" Then
		Return -1
	End If 
End If

Return 1
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;//If ivw_ParentWindow.ivb_Valida_Salva Then
//	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Para alterar a linha selecionada $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio confirmar as altera$$HEX2$$e700f500$$ENDHEX$$es.~r" + &
//										"Deseja descartar as altera$$HEX2$$e700f500$$ENDHEX$$es realizadas?", Question!, YesNo!) = 2 Then
//		
//		This.Event ue_Pos(lvl_Linha_dw1, "nm_pbm")
//		Return -1
//	End If
//End If
//
//lvl_Linha_dw1 = currentrow

dw_1.AcceptText()

If dw_1.Object.Id_Tipo[CurrentRow] = "D" Then
	wf_Somente_Leitura(False, dw_1)
	ib_PBM_DermaClub = True
	st_1.Visible = True
Else
	wf_Somente_Leitura(True, dw_1)
	ib_PBM_DermaClub = False
	st_1.Visible = False
End If

dw_2.Event ue_Retrieve()
end event

event dw_1::getfocus;call super::getfocus;//If Not This.Enabled Then	
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Para alterar a linha selecionada $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio confirmar ou cancelar as altera$$HEX2$$e700f500$$ENDHEX$$es.~r", Information!)
//End If

If This.RowCount() > 0 Then	
	Parent.ivm_Menu.mf_Excluir(True)
End If
end event

event dw_1::ue_predeleterow;//Override

Boolean lvb_Sucesso

Long lvl_Produto

dw_1.AcceptText()

lvb_Sucesso = True

If dw_2.RowCount() = 1 Then
	lvl_Produto = dw_2.Object.cd_produto[1]
	If Not IsNull(lvl_Produto) Then
		lvb_Sucesso = False
	End If
ElseIf dw_2.RowCount() > 1 Then
	lvb_Sucesso = False
End If

If Not lvb_Sucesso Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Para excluir um PBM $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio excluir todos os produtos que perten$$HEX1$$e700$$ENDHEX$$am a esse PBM.")
	Return False
End If

If dw_1.Object.Id_Tipo[dw_1.GetRow()] = "D" Then
	Return False
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma exclus$$HEX1$$e300$$ENDHEX$$o do registro ?", Question!, YesNo!, 2) = 2 Then
	Return False
Else
	Return True
End If
end event

event dw_1::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()

String lvs_Coluna[]
String lvs_Nome[]

lvs_Coluna = {	"cd_pbm", &
					"nm_pbm", &
					"nm_fantasia", &
					"cd_convenio",&
					"de_observacao"}
							 
lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo do PBM", &
				  "Nome do PBM", &
				  "Nome do Conv$$HEX1$$ea00$$ENDHEX$$nio", &
				  "C$$HEX1$$f300$$ENDHEX$$digo do Conv$$HEX1$$ea00$$ENDHEX$$nio",&
				  "Observa$$HEX2$$e700e300$$ENDHEX$$o"}
						  
This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)		
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long lvl_Linha
Long lvl_PBM
Long lvl_Max
Long ll_Convenio

String lvs_Nome

For lvl_Linha = 1 To This.RowCount()
	lvs_Nome 	= This.Object.nm_pbm[lvl_linha]
	lvl_PBM 		= This.Object.cd_pbm[lvl_Linha]
	ll_Convenio	= This.Object.cd_convenio[lvl_Linha]
	
	If IsNull(lvs_Nome) Or Trim(lvs_Nome) = "" Then
		If This.RowCount() = 1 Then
			Return 1
		End If
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o nome do PBM corretamente.")
		This.Event ue_Pos(lvl_Linha, "nm_pbm")
		Return -1
	End If
	
	If IsNull(ll_Convenio) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o conv$$HEX1$$ea00$$ENDHEX$$nio.")
		This.Event ue_Pos(lvl_Linha, "nm_fantasia")
		Return -1
	End If	
	
	If IsNull(lvl_PBM) Then
		lvl_Max = This.Object.cd_Max_Pbm[This.RowCount()]
		If IsNull(lvl_Max) Then lvl_Max = 0
		lvl_Max++
		This.Object.cd_pbm[lvl_Linha] = lvl_Max
	End If
Next
end event

event dw_1::losefocus;call super::losefocus;Long lvl_Linha

String lvs_Nome

For lvl_Linha = 1 To This.RowCount()
	lvs_Nome = This.Object.nm_pbm[lvl_linha]
	
	If IsNull(lvs_Nome) Or Trim(lvs_Nome) = "" Then
		This.Event ue_Pos(lvl_Linha, "nm_pbm")
		Return -1
	End If
Next
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge210_cadastro_pbm
integer width = 3506
integer height = 1188
integer taborder = 0
integer weight = 700
string text = "Lista de PBM"
end type

type dw_2 from dc_uo_dw_base within w_ge210_cadastro_pbm
integer x = 64
integer y = 1280
integer width = 3442
integer height = 1144
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge210_cadastro_produto_pbm"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_key;call super::ue_key;Long lvl_Nulo
Long lvl_Linha
Long lvl_Find

String lvs_Nulo

SetNull(lvl_Nulo)
SetNull(lvs_Nulo)

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		
		lvl_Linha = This.GetRow()
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			lvl_Find = This.Find("cd_produto = " + String(ivo_produto.cd_produto), 1, This.RowCount())
			If lvl_Find > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O Produto (" + String(ivo_produto.cd_produto) + ") " + ivo_Produto.de_produto + " j$$HEX1$$e100$$ENDHEX$$ foi incluso nesse PBM.")
				This.Object.cd_produto[lvl_Linha] = lvl_Nulo
				This.Object.de_produto[lvl_Linha] = lvs_Nulo
				Return -1
			End If
			This.Object.cd_produto[lvl_Linha] = ivo_produto.cd_produto
			This.Object.de_produto[lvl_Linha] = ivo_Produto.de_produto + " : " + ivo_Produto.de_apresentacao_venda
		Else
			This.Object.cd_produto[lvl_Linha] = lvl_Nulo
			This.Object.de_produto[lvl_Linha] = lvs_Nulo
		End If
	End If	
End If
end event

event ue_recuperar;//Override

Long lvl_Linha
Long lvl_PBM

If dw_1.RowCount() > 0 Then
	lvl_Linha = dw_1.GetRow()
	
	If lvl_Linha > 0 Then 
		lvl_PBM = dw_1.Object.cd_pbm[lvl_Linha] 
		Return This.Retrieve(lvl_PBM)
	End If 
End If

Return 0
end event

event ue_postretrieve;call super::ue_postretrieve;//Override
Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

Long	lvl_Linha, &
		lvl_Produto

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar	= IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Excluir = True
	
	ivm_Menu.mf_SalvarComo(True)
Else
	This.Event ue_AddRow()
End If

//Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
//Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
//Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
//Parent.ivm_Menu.mf_Excluir(lvb_Excluir)

If ib_PBM_DermaClub Then
	Parent.ivm_Menu.mf_Excluir(False)
Else
	Parent.ivm_Menu.mf_Excluir(True)
End If

Return pl_Linhas
end event

event ue_preinsertrow;call super::ue_preinsertrow;Long lvl_Produto

If This.RowCount() > 0 Then
	This.AcceptText()
	lvl_Produto = This.Object.cd_produto[This.RowCount()]
	
	If IsNull(lvl_Produto) Or lvl_Produto = 0 Then
		Return -1
	End If 
End If

Return 1
end event

event ue_deleterow;call super::ue_deleterow;If This.RowCount() = 0 Then
	This.Event ue_AddRow()
End If

ivm_Menu.mf_Classificar(True)
ivm_Menu.mf_Filtrar(True)

Return AncestorReturnValue
end event

event ue_preupdate;call super::ue_preupdate;//Override
Long lvl_Linha
Long lvl_PBM
Long lvl_Produto

If dw_1.RowCount() > 0 Then
	lvl_PBM = dw_1.Object.cd_pbm[dw_1.GetRow()] 
	
	For lvl_Linha = 1 To This.RowCount()
		lvl_Produto = This.Object.cd_produto[lvl_Linha]
		
		If IsNull(lvl_Produto) Then
			This.DeleteRow(lvl_Linha)
			Continue
		End If
		
		This.Object.cd_pbm[lvl_Linha] = lvl_PBM
	Next
	
	Return 1
End If

Return -1
end event

event getfocus;call super::getfocus;Long lvl_Linha

String lvs_Nome

dw_1.AcceptText()
For lvl_Linha = 1 To dw_1.RowCount()
	lvs_Nome = dw_1.Object.nm_pbm[lvl_linha]
	
	If IsNull(lvs_Nome) Or Trim(lvs_Nome) = "" Then
		dw_1.Event ue_Pos(lvl_Linha, "nm_pbm")
		Return -1
	End If
Next

Parent.ivm_Menu.mf_Recuperar(False)

If This.RowCount() > 0 Then	
	If ib_PBM_DermaClub Then
		Parent.ivm_Menu.mf_Excluir(False)
	Else
		Parent.ivm_Menu.mf_Excluir(True)
	End If
End If

end event

event losefocus;call super::losefocus;Parent.ivm_Menu.mf_Recuperar(True)
end event

event itemchanged;call super::itemchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

dw_1.Enabled = False
end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

dw_1.Enabled = False
end event

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()

String lvs_Coluna[]
String lvs_Nome[]

lvs_Coluna = {	"cd_produto", &
					"de_produto", &
					"vl_preco_fixo", &
					"pc_desconto", &
					"id_gratis", &
					"id_caixa_bonus", &
					"de_observacao"}
						  
lvs_Nome = {	"C$$HEX1$$f300$$ENDHEX$$digo do Produto", &
					"Descri$$HEX2$$e700e300$$ENDHEX$$o", &
					"Valor", &
					"Percentual de Desconto", &
					"Gratuito?", &
					"Caixa Bonus?", &
					"Observacao"}		
				  
			
This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)		
end event

event ue_predeleterow;call super::ue_predeleterow;Long lvl_Linhas
Long lvl_Produto

dw_1.AcceptText()

lvl_Linhas = This.RowCount() 

If lvl_Linhas > 1 Then
	dw_1.Enabled = False
ElseIf lvl_Linhas = 1 Then
	This.AcceptText()
	lvl_Produto = This.Object.cd_produto[1]
	
	If Not IsNull(lvl_Produto) And lvl_Produto > 0 Then
		dw_1.Enabled = False
	End If 
End If

If dw_1.Object.Id_Tipo[dw_1.GetRow()] = "D" Then
	Return False
End If

Return True
end event

event rowfocuschanged;call super::rowfocuschanged;dw_1.AcceptText()

If CurrentRow > 0 Then
	If ib_PBM_DermaClub Then
		wf_Somente_Leitura(False, dw_2)
	Else
		wf_Somente_Leitura(True, dw_2)
	End If
End If
end event

event ue_addrow;call super::ue_addrow;dw_1.AcceptText()

If dw_1.Object.Id_Tipo[dw_1.GetRow()] = "D" Then
	wf_Somente_Leitura(False, dw_2)
	ib_PBM_DermaClub = True
Else
	wf_Somente_Leitura(True, dw_2)
	ib_PBM_DermaClub = False
End If

Return AncestorReturnValue
end event

type st_1 from statictext within w_ge210_cadastro_pbm
integer x = 2930
integer y = 1220
integer width = 1545
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "Dados do PBM DermaClub n$$HEX1$$e300$$ENDHEX$$o podem ser alterados"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_ge210_cadastro_pbm
integer x = 27
integer y = 1224
integer width = 3506
integer height = 1216
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos do PBM"
borderstyle borderstyle = styleraised!
end type

