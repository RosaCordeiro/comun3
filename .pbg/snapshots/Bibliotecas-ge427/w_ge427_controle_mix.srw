HA$PBExportHeader$w_ge427_controle_mix.srw
$PBExportComments$FOI TIRADO DO MENU *** NAO UTILIZAR ***
forward
global type w_ge427_controle_mix from dc_w_sheet
end type
type tab_1 from tab within w_ge427_controle_mix
end type
type tabpage_1 from userobject within tab_1
end type
type cb_incluir from picturebutton within tabpage_1
end type
type cb_alterar from picturebutton within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_incluir cb_incluir
cb_alterar cb_alterar
gb_1 gb_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_2
end type
type pb_3 from picturebutton within tabpage_2
end type
type gb_2 from groupbox within tabpage_2
end type
type dw_2 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_1 cb_1
pb_3 pb_3
gb_2 gb_2
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_3
end type
type dw_3 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
end type
type tab_1 from tab within w_ge427_controle_mix
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_ge427_controle_mix from dc_w_sheet
integer width = 1897
integer height = 1588
string title = "GE427 - Controle de Mix"
boolean resizable = false
long backcolor = 80269524
tab_1 tab_1
end type
global w_ge427_controle_mix w_ge427_controle_mix

type variables
dc_uo_dw_base dw_1, &
						dw_2, &
						dw_3
end variables

on w_ge427_controle_mix.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge427_controle_mix.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_2.dw_2
dw_3 = Tab_1.TabPage_3.dw_3

/*--------------------------------------------------------
N$$HEX1$$e300$$ENDHEX$$o Habilitar o Update Properties das DataWindows
N$$HEX1$$e300$$ENDHEX$$o Deletar Mix
N$$HEX1$$e300$$ENDHEX$$o Deletar Filiais
--------------------------------------------------------*/

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_3.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Excluir(False)
Tab_1.TabPage_2.dw_2.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_2.dw_2.ivo_Controle_Menu.of_Excluir(False)
Tab_1.TabPage_3.dw_3.ivo_Controle_Menu.of_Incluir(False)
Tab_1.TabPage_3.dw_3.ivo_Controle_Menu.of_Excluir(False)

Tab_1.TabPage_2.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_3.dw_3.ivo_Controle_Menu.of_SalvarComo(True)

Tab_1.TabPage_1.dw_1.Event ue_Retrieve()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge427_controle_mix
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge427_controle_mix
end type

type tab_1 from tab within w_ge427_controle_mix
integer width = 1870
integer height = 1424
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;/*--------------------------------------------------------
N$$HEX1$$e300$$ENDHEX$$o Habilitar o Update Properties das DataWindows
N$$HEX1$$e300$$ENDHEX$$o Deletar Mix
N$$HEX1$$e300$$ENDHEX$$o Deletar Filiais
--------------------------------------------------------*/


SetPointer(HourGlass!)

LONG lvl_Linha 

lvl_Linha = Tab_1.TabPage_1.dw_1.GetRow()

If NewIndex = 2 Then
	If lvl_Linha > 0 Then
		Tab_1.TabPage_2.dw_2.Event ue_Retrieve()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um mix para visualizar as filiais.", Information!)
		Return 1
	End If	
End If

If NewIndex = 3 Then
	If lvl_Linha > 0 Then
		Tab_1.TabPage_3.dw_3.Event ue_Retrieve()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um mix para visualizar os produtos.", Information!)
		Return 1
	End If	
End If

SetPointer(Arrow!)
end event

event selectionchanged;/*--------------------------------------------------------
N$$HEX1$$e300$$ENDHEX$$o Habilitar o Update Properties das DataWindows
N$$HEX1$$e300$$ENDHEX$$o Deletar Mix
N$$HEX1$$e300$$ENDHEX$$o Deletar Filiais
--------------------------------------------------------*/

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		Tab_1.TabPage_1.dw_1.SetFocus()
	Case 2
		Tab_1.TabPage_2.dw_2.SetFocus()
	Case 3
		Tab_1.TabPage_3.dw_3.SetFocus()
End Choose

SetPointer(Arrow!)

end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1833
integer height = 1308
long backcolor = 80269524
string text = "Mix"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
cb_incluir cb_incluir
cb_alterar cb_alterar
gb_1 gb_1
dw_1 dw_1
end type

on tabpage_1.create
this.cb_incluir=create cb_incluir
this.cb_alterar=create cb_alterar
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.cb_incluir,&
this.cb_alterar,&
this.gb_1,&
this.dw_1}
end on

on tabpage_1.destroy
destroy(this.cb_incluir)
destroy(this.cb_alterar)
destroy(this.gb_1)
destroy(this.dw_1)
end on

type cb_incluir from picturebutton within tabpage_1
integer x = 1061
integer y = 1188
integer width = 384
integer height = 116
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_incluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Retorno, ls_Responsavel

If Not gf_Verifica_Cutover("DH_CUTOVER_MATCH_CODE") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o por esta tela. Utilizar o SAP.", Exclamation!)
	Return -1
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE427_LIBERACAO_PROCEDIMENTO", ref ls_Responsavel) Then 
	Return
End If

OpenWithParm(w_ge427_incluir_mix,"00")

ls_Retorno = Message.StringParm

If Not IsNull( ls_Retorno ) Then dw_1.Retrieve()
end event

type cb_alterar from picturebutton within tabpage_1
integer x = 1463
integer y = 1188
integer width = 347
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_alterar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Long lvl_Mix
String ls_Retorno, ls_Responsavel

If Not gf_Verifica_Cutover("DH_CUTOVER_MATCH_CODE") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o por esta tela. Utilizar o SAP.", Exclamation!)
	Return -1
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE427_LIBERACAO_PROCEDIMENTO", ref ls_Responsavel) Then 
	Return
End If

lvl_Mix = Tab_1.TabPage_1.dw_1.Object.cd_mix_produto[Tab_1.TabPage_1.dw_1.GetRow()]

OpenWithParm(w_ge427_incluir_mix,String(lvl_Mix))

ls_Retorno = Message.StringParm

If Not IsNull( ls_Retorno ) Then dw_1.Retrieve()
end event

type gb_1 from groupbox within tabpage_1
integer x = 14
integer y = 16
integer width = 1797
integer height = 1156
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Mix"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 37
integer y = 76
integer width = 1755
integer height = 1080
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge427_lista_mix"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1833
integer height = 1308
long backcolor = 80269524
string text = "Filiais"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_1 cb_1
pb_3 pb_3
gb_2 gb_2
dw_2 dw_2
end type

on tabpage_2.create
this.cb_1=create cb_1
this.pb_3=create pb_3
this.gb_2=create gb_2
this.dw_2=create dw_2
this.Control[]={this.cb_1,&
this.pb_3,&
this.gb_2,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.cb_1)
destroy(this.pb_3)
destroy(this.gb_2)
destroy(this.dw_2)
end on

type cb_1 from commandbutton within tabpage_2
integer x = 18
integer y = 1192
integer width = 494
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inclui Filial (XLS)"
end type

event clicked;Integer lvi_Arquivo

Long lvl_Linhas
Long lvl_Linha
Long ll_Filial
Long lvl_Mix
Long ll_Achou

String lvs_Path
String lvs_Nome_Arquivo
String lvs_Arquivo
String lvs_Dado
String ls_Responsavel
String ls_Erro
String ls_Nulo

SetNull(ls_Nulo)

lvl_Mix = Tab_1.TabPage_1.dw_1.Object.cd_mix_produto[Tab_1.TabPage_1.dw_1.GetRow()]

If IsNull(lvl_Mix) or lvl_Mix = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum mix foi selecionado.")
	Return
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE427_LIBERACAO_PROCEDIMENTO", ref ls_Responsavel) Then 
	Return
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os dados da planilha dever$$HEX1$$e300$$ENDHEX$$o ser:~r" + "Coluna A = Filial.")
			
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo <> 1 Then Return

lvs_Arquivo = lvs_Path

dc_uo_excel lvo_Excel

try

	lvo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If lvl_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
			
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a inclus$$HEX1$$e300$$ENDHEX$$o das filiais da planilha no MIX (" + STring(lvl_Mix) + ") ?", Question!, YesNo!, 2) = 2 Then
				Return 
			End If
	
			For lvl_Linha = 1 To lvl_Linhas
				
				w_Aguarde.Title = "Incluindo Filial " + String(lvl_Linha) + " de: " + string(lvl_Linhas)
								
				lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A"))
		
				If IsNumber(lvs_Dado) Then
					ll_Filial = Long(lvs_Dado)
					
					select cd_filial
					Into :ll_Achou
					from mix_produto_filial
					where cd_filial 				= :ll_Filial
					   and cd_mix_produto 	= :lvl_Mix
					Using SqlCa;
					
					Choose Case SqlCa.SqlCode
						Case 0
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial [" + String(ll_Filial) + "] j$$HEX1$$e100$$ENDHEX$$ esta cadastrada no mix.")
							w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
							Continue
						Case 100
							
							Select cd_filial
							Into :ll_Achou
							From filial 
							Where cd_filial = :ll_Filial
							Using SqlCa;
							
							Choose Case SqlCa.SqlCode
							Case 0
							Case 100
								SqlCa.of_RollBack();
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(ll_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizada")
								Return
							Case -1
								ls_Erro = "Erro ao localizar a filial. " +  SQLCA.SQLErrText
								SqlCa.of_RollBack();
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)
								Return
							End Choose
							
							INSERT INTO mix_produto_filial ( cd_filial, cd_mix_produto )  
 							VALUES ( :ll_Filial, :lvl_Mix)
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								ls_Erro = "Erro ao incluir a filial '"  + String(ll_Filial) + "' no mix '" + String(lvl_Mix) + "'. " +  SQLCA.SQLErrText
								SqlCa.of_RollBack();
								Return
							End If
																					
							If Not gf_grava_historico_alteracao_tabela('MIX_PRODUTO_FILIAL', +&
																				  string(ll_Filial) + '@#!' + string(lvl_Mix), +&
																				  'CD_FILIAL', +&
																				  ls_Nulo, +&
																				  string(ll_Filial) + '-' + string(lvl_Mix), +&
																				  ls_Responsavel, 'I', ref ls_Erro, False) Then
								SqlCa.of_RollBack();
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)
								Return												  
							End If
						
						Case -1
							ls_Erro = "Erro ao localizar o produto no mix. " +  SQLCA.SQLErrText
							SqlCa.of_RollBack();
							Return
					End Choose
				Else
					SqlCa.of_RollBack();
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(lvl_Linha) + "~rValor: " + lvs_Dado)
					Return
				End If //Produto
				
				w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
				
			Next
			
			SqlCa.of_Commit();
			
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filiais foram inclu$$HEX1$$ed00$$ENDHEX$$das com sucesso.")
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi encontrada na planilha.")
		End If //Linha
	
	End If //Excel

finally
	Close(w_Aguarde)
	Destroy(lvo_Excel)
end try
end event

type pb_3 from picturebutton within tabpage_2
integer x = 1435
integer y = 1188
integer width = 375
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_incluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_mix, ls_Retorno, ls_Responsavel

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE427_LIBERACAO_PROCEDIMENTO", ref ls_Responsavel) Then 
	Return
End If

ls_mix = String( dw_1.Object.cd_mix_produto[ dw_1.GetRow() ] )

OpenWithParm( w_ge427_incluir_filial, ls_mix )

ls_Retorno = Message.StringParm

If Not IsNull( ls_Retorno ) Then dw_2.Retrieve( Long(ls_mix) )
end event

type gb_2 from groupbox within tabpage_2
integer x = 14
integer y = 16
integer width = 1797
integer height = 1156
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Filial"
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 76
integer width = 1755
integer height = 1080
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge427_lista_filial_mix"
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide

Long lvl_Mix

lvl_Mix = Tab_1.TabPage_1.dw_1.Object.cd_mix_produto[Tab_1.TabPage_1.dw_1.GetRow()]

Return This.Retrieve(lvl_Mix)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_postretrieve;call super::ue_postretrieve;//If pl_Linhas > 0 Then
//	This.ivm_Menu.mf_SalvarComo(True)
//Else
//	This.ivm_Menu.mf_SalvarComo(False)
//End If
//
Return pl_Linhas
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1833
integer height = 1308
long backcolor = 80269524
string text = "Produtos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_3 gb_3
dw_3 dw_3
end type

on tabpage_3.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.Control[]={this.gb_3,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.gb_3)
destroy(this.dw_3)
end on

type gb_3 from groupbox within tabpage_3
integer x = 14
integer y = 16
integer width = 1797
integer height = 1248
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_3
integer x = 41
integer y = 76
integer width = 1751
integer height = 1172
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge427_lista_produto_mix"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;// OverRide

Long lvl_Mix

lvl_Mix = Tab_1.TabPage_1.dw_1.Object.cd_mix_produto[Tab_1.TabPage_1.dw_1.GetRow()]

Return This.Retrieve(lvl_Mix)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

