HA$PBExportHeader$w_ge437_laboratorios.srw
forward
global type w_ge437_laboratorios from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within w_ge437_laboratorios
end type
type dw_2 from dc_uo_dw_base within w_ge437_laboratorios
end type
type cb_1 from commandbutton within w_ge437_laboratorios
end type
type gb_2 from groupbox within w_ge437_laboratorios
end type
type gb_1 from groupbox within w_ge437_laboratorios
end type
end forward

global type w_ge437_laboratorios from dc_w_sheet
integer width = 2693
integer height = 2168
string title = "GE437 - Cadastro Filial por Projeto Conex$$HEX1$$e300$$ENDHEX$$o"
long backcolor = 80269524
event ue_retrieve ( )
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
gb_2 gb_2
gb_1 gb_1
end type
global w_ge437_laboratorios w_ge437_laboratorios

type variables
uo_filial ivo_filial
uo_ge216_filiais ivo_Selecao_filiais

Boolean ivb_Check

Integer ivi_Salva = 1

String ivs_nulo
String ivs_filiais
end variables

forward prototypes
public subroutine wf_lista_laboratorios ()
public subroutine wf_lista_filiais ()
public function boolean wf_salva_laboratorios ()
public function boolean wf_salva_filiais ()
public function boolean wf_salva_pendente ()
public subroutine wf_set_somente_consulta ()
public function boolean wf_envia_email ()
end prototypes

event ue_retrieve;dw_2.Event ue_Retrieve()
end event

public subroutine wf_lista_laboratorios ();String lvs_Fornecedor

Long lvl_Linhas		,&
        lvl_Linha		,&
	   lvl_Linha2		,&
	   lvl_Linhas2	,&
        lvl_Filial 
		  
dc_uo_ds_base lvds_Laboratorios
lvds_Laboratorios = Create dc_uo_ds_base

dw_1.AcceptText()
lvl_Filial = dw_1.Object.cd_filial[1]

lvds_Laboratorios.of_ChangeDataObject("dw_ge437_laboratorios_base")

lvl_Linhas = lvds_laboratorios.retrieve(lvl_Filial)
lvl_linhas2 = dw_2.RowCount()

For lvl_linha2 = 1 To lvl_Linhas2
	lvs_Fornecedor = dw_2.Object.cd_fornecedor[lvl_Linha2]
	For lvl_Linha = 1 To lvl_Linhas
		If lvds_laboratorios.object.cd_fornecedor[lvl_Linha] =  lvs_fornecedor Then
			dw_2.Object.id_ativo				[lvl_linha2] = "S"
			dw_2.Object.id_ativo_anterior	[lvl_linha2] = "S"
		End If
	Next
Next
end subroutine

public subroutine wf_lista_filiais ();String lvs_Fornecedor

Long lvl_Linhas		,&
        lvl_Linha		,&
	   lvl_Linha2		,&
	   lvl_Linhas2	,&
        lvl_Filial 
		  
dc_uo_ds_base lvds_Filiais
lvds_Filiais = Create dc_uo_ds_base

dw_1.AcceptText()

lvs_Fornecedor	= dw_1.Object.Cd_Laboratorio[1]

If Not lvds_Filiais.of_ChangeDataObject("dw_ge437_filiais_base") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'dw_ge437_filiais_base'.", StopSign!)
	Return	
End If

If dw_1.Object.Id_Conjunto_Filial[1] = "C" Then
	If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
		dw_2.of_AppendWhere("cd_filial in (" + ivs_Filiais + ")")
	End If
End If

lvl_Linhas = lvds_Filiais.retrieve(lvs_Fornecedor)

If lvl_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Retrieve do data store 'dw_ge437_filiais_base'.", StopSign!)
	Return
End If

lvl_linhas2 = dw_2.RowCount()

For lvl_linha2 = 1 To lvl_Linhas2
	lvl_Filial = dw_2.Object.cd_filial[lvl_Linha2]
	For lvl_Linha = 1 To lvl_Linhas
		If lvds_Filiais.object.cd_Filial[lvl_Linha] =  lvl_Filial Then
			dw_2.Object.id_ativo				[lvl_linha2] = "S"
			dw_2.Object.id_ativo_anterior	[lvl_linha2] = "S"
		End If
	Next
Next
end subroutine

public function boolean wf_salva_laboratorios ();Boolean lvb_Retorno = True

Long lvl_Linha                                  ,&
        lvl_Linhas                                   ,&
                   lvl_Filial                                            
                  
String lvs_Fornecedor, ls_Alteracao, ls_Erro
                               
dw_1.AcceptText()
lvl_Filial = dw_1.Object.cd_filial[1]
                                 
lvl_Linhas = dw_2.RowCount()
Delete from filial_projeto_conexao where cd_filial = :lvl_Filial
Using SQLCA;

If SQLCA.SQlCode = -1 Then
                MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao Excluir Fornecedores")
                SQLCA.of_Rollback()
                Return False 
End If

For lvl_linha = 1 To lvl_Linhas
                
                lvs_Fornecedor = dw_2.Object.cd_fornecedor[lvl_Linha]
                
                If dw_2.Object.id_ativo[lvl_Linha] = 'S' Then
                               Insert Into filial_projeto_conexao (cd_filial , cd_fornecedor)
                               Values(:lvl_Filial, :lvs_Fornecedor)
                               Using SQLCA;
                               
                               If SQLCA.SQlCode = -1 Then
                                               ls_Erro = SqlCa.SqlErrText
                                               MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao incluir Fornecedor." + ls_Erro, StopSign!)
                                               lvb_Retorno      = False
                                               Exit
                               End If    
                End If 
                
                If dw_2.Object.id_ativo_anterior[lvl_Linha] <> dw_2.Object.id_ativo[lvl_Linha] Then
                               
                               If dw_2.Object.id_ativo_anterior[lvl_Linha] = 'S'  and dw_2.Object.id_ativo[lvl_Linha] = 'N'  Then
                                               // Exclus$$HEX1$$e300$$ENDHEX$$o
                                               dw_2.Object.id_ativo_anterior[lvl_Linha] = 'N'
                                               ls_Alteracao = 'D'
                               End If
                               
                               If dw_2.Object.id_ativo_anterior[lvl_Linha] = 'N' and dw_2.Object.id_ativo[lvl_Linha] = 'S'   Then
                                               // Inclus$$HEX1$$e300$$ENDHEX$$o
                                               dw_2.Object.id_ativo_anterior[lvl_Linha] = 'S'
                                               ls_Alteracao = 'I'
                               End If
                               
                               Insert Into historico_filial_conexao (cd_filial , cd_fornecedor, dh_alteracao, id_alteracao, nr_matricula )
                               Values(:lvl_Filial, :lvs_Fornecedor, getdate(), :ls_Alteracao, :gvo_aplicacao.ivo_seguranca.nr_matricula  )
                               Using SQLCA;
                               
                               If SQLCA.SQlCode = -1 Then 
                                               MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao incluir o hist$$HEX1$$f300$$ENDHEX$$rico da filial conex$$HEX1$$e300$$ENDHEX$$o")
                                               lvb_Retorno      = False
                                               Exit
                               End If                                 
                End If
                
Next

If lvb_Retorno Then
                SQLCA.of_Commit();
Else
                SQLCA.of_Rollback();
End If

return lvb_Retorno

end function

public function boolean wf_salva_filiais ();Boolean lvb_Retorno = True

Long lvl_Linha
Long lvl_Linhas
Long lvl_Filial
Long ll_Achou
	  
String lvs_Fornecedor
String ls_Alteracao
String ls_Erro
		
dw_1.AcceptText()
dw_2.AcceptText()

lvs_Fornecedor = dw_1.Object.cd_laboratorio[1]
		  
lvl_Linhas = dw_2.RowCount()

For lvl_linha = 1 To lvl_Linhas
	
	lvl_Filial = dw_2.Object.cd_Filial[lvl_Linha]
	
	If dw_2.Object.id_ativo_anterior[lvl_Linha] <> dw_2.Object.id_ativo[lvl_Linha] Then
		
		If dw_2.Object.id_ativo_anterior[lvl_Linha] = 'S'  and dw_2.Object.id_ativo[lvl_Linha] = 'N'  Then
			// Exclus$$HEX1$$e300$$ENDHEX$$o			
			Delete From filial_projeto_conexao
			Where cd_filial = :lvl_Filial
				And cd_fornecedor = :lvs_Fornecedor
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir a filial '" + String(lvl_Filial) + "'. " + ls_Erro, StopSign!)
				lvb_Retorno = False
				Exit
			End If
			
			dw_2.Object.id_ativo_anterior[lvl_Linha] = 'N'
			ls_Alteracao = 'D'
			
		End If
		
		If dw_2.Object.id_ativo_anterior[lvl_Linha] = 'N' and dw_2.Object.id_ativo[lvl_Linha] = 'S'   Then
			// Inclus$$HEX1$$e300$$ENDHEX$$o		
			Select Count(*)
				Into :ll_Achou
			From filial_projeto_conexao
			Where cd_filial = :lvl_Filial
				And cd_fornecedor = :lvs_Fornecedor
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se a filial '" + String(lvl_Filial) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ no projeto conex$$HEX1$$e300$$ENDHEX$$o. " + ls_Erro, StopSign!)
				lvb_Retorno = False
				Exit
			End If
		
			If ll_Achou = 0 Then
				Insert Into filial_projeto_conexao(cd_filial, cd_fornecedor)
						Values(:lvl_Filial, :lvs_Fornecedor)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SqlErrText
					SqlCa.of_Rollback();
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se a filial '" + String(lvl_Filial) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ no projeto conex$$HEX1$$e300$$ENDHEX$$o. " + ls_Erro, StopSign!)
					lvb_Retorno = False
					Exit
				End If
				
				dw_2.Object.id_ativo_anterior[lvl_Linha] = 'S'
				ls_Alteracao = 'I'
				
			End If
		End If
		
		Insert Into historico_filial_conexao(cd_filial , cd_fornecedor, dh_alteracao, id_alteracao, nr_matricula )
		Values(:lvl_Filial, :lvs_Fornecedor, getdate(), :ls_Alteracao, :gvo_aplicacao.ivo_seguranca.nr_matricula  )
		Using SqlCa;
		
		If SqlCa.SQlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao incluir o hist$$HEX1$$f300$$ENDHEX$$rico da filial conex$$HEX1$$e300$$ENDHEX$$o. " + ls_Erro, StopSign!)
			lvb_Retorno = False
			Exit
		End If
		
		
	End If
Next

If lvb_Retorno Then
	SqlCa.of_Commit();
End If

Return lvb_Retorno
end function

public function boolean wf_salva_pendente ();Long lvl_Modificado

dw_2.AcceptText()

lvl_Modificado = dw_2.ModifiedCount() + dw_2.DeletedCount()
							 
If lvl_Modificado > 0 Then
	Return True
Else
	Return False
End If

end function

public subroutine wf_set_somente_consulta ();dw_2.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

public function boolean wf_envia_email ();String lvs_Msg, lvs_id_ativo, lvs_html_cabecalho, lvs_html_detalhes, lvs_codigo, lvs_projeto, lvs_van, lvs_html_rodape, lvs_html, lvs_de_filial
Long lvl_cont, lvl_row, lvl_cd_filial
DateTime ldh_data

String lvs_log

lvl_cd_filial	= dw_1.object.cd_filial[1]
lvs_de_filial	= dw_1.object.nm_fantasia[1]

ldh_data = DateTime(String(Today(),"dd/mm/yyyy hh:mm"))

lvs_html_cabecalho =	'<HTML>'																							+ &
							'<BODY>'																							+ &
							'<BR>'																								+ &										
							'<TABLE border=0>'																				+ &
								'<TR>'																							+ & 
									'<TD><B>Projeto Conex$$HEX1$$e300$$ENDHEX$$o<B></TD>'												+ &
								'</TR>'																							+ &
								'<TR>'																							+ & 
									'<TD><B>Data Envio e-mail:<B> ' + string(ldh_data) + '</TD>'				+ & 	
								'</TR>'																							+ &
								'<TR>'																							+ & 
									'<TD><B>Filial:<B> ' + string(lvl_cd_filial) + ' - ' + lvs_de_filial + '</TD>'	+ & 	
								'</TR>'																							+ &																		
								'<TR>'																							+ & 
									'<TD><B>' + 'COMPRAS:  Menu Cadastro -> Conex$$HEX1$$e300$$ENDHEX$$o -> Filiais por Projeto' + '<B> </TD>'	+ & 	
								'</TR>'																							+ &
							'</TABLE><BR></BR>'																			+ &										
							'<TABLE>'																							+ & 
								'<TR bgcolor="#ffff66">' 																	+ &
									'<TH STYLE="border:1px solid black">C$$HEX1$$f300$$ENDHEX$$digo</TH>'								+ & 
									'<TH STYLE="border:1px solid black">Projeto</TH>'								+ &
									'<TH STYLE="border:1px solid black">Van</TH>'									+ & 
								'</TR>'

lvl_row = dw_2.rowcount()

For lvl_cont = 1 To lvl_row

	lvs_id_ativo 	= dw_2.Object.id_ativo[lvl_cont]
	lvs_codigo	= dw_2.Object.cd_fornecedor[lvl_cont]
	lvs_projeto	= dw_2.Object.fornecedor_nm_fantasia[lvl_cont] 
	lvs_van		= Trim(dw_2.Object.de_projeto_conexao[lvl_cont])
	
	
	If lvs_id_ativo = 'S' Then

		 lvs_html_detalhes += '<TR >'																				+ &
										'<TD STYLE="border:1px solid black; border-collapse: collapse">' + Trim(lvs_codigo)	+ '</TD>'  	+ &
										'<TD STYLE="border:1px solid black; border-collapse: collapse">' + Trim(lvs_projeto)	+ '</TD>'	+ &
										'<TD STYLE="border:1px solid black; border-collapse: collapse">' + Trim(lvs_van)		+ '</TD>'	+ &
									'</TR>'								
	End If									


Next	

lvs_html_rodape =		'</TABLE>'	+ &
							'</BODY>'	+ &	
							'</HTML>'


lvs_html = lvs_html_cabecalho + lvs_html_detalhes + lvs_html_rodape 

s_email lst_Email

lvs_Msg = lvs_html

lst_Email.ps_mensagem = lvs_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao( 274  , lst_Email ) Then
   Return False	
End If



Return True
end function

on w_ge437_laboratorios.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge437_laboratorios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

ivm_Menu.mf_Recuperar(True)

ivo_Filial				= Create uo_Filial
ivo_Selecao_filiais	= Create uo_ge216_filiais

dw_1.Object.Filial_t.Visible = 0
dw_1.Object.Id_Conjunto_Filial.Visible = 0
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Selecao_filiais)
end event

event open;call super::open;ivo_filial = Create uo_Filial 
end event

event ue_save;//OverRide

SetPointer(HourGlass!)

If ivi_Salva = 1 Then
	wf_Salva_Laboratorios()
Else
	wf_Salva_Filiais()
End If

If  Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o"," Voc$$HEX1$$ea00$$ENDHEX$$ esta fazendo uma altera$$HEX2$$e700e300$$ENDHEX$$o dos dados. Deseja enviar email com as altera$$HEX2$$e700f500$$ENDHEX$$es?",Exclamation!, YESNO!, 2) = 1 Then
	wf_envia_email()
End If

dw_2.ResetUpdate()

SetPointer(Arrow!)

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)	

Return 1
end event

event closequery;call super::closequery;//OverRide

Integer li_Retorno

If wf_Salva_Pendente() Then
	li_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas.~r~r" +&
										"Deseja salvar antes de continuar ?", Question!, YesNoCancel!, 3)
	If li_Retorno = 1 Then
		This.Event ue_Save()
	ElseIf li_Retorno = 2 Then
		// Fecha
		Return 0
	Else
		//N$$HEX1$$e300$$ENDHEX$$o fecha - cancel
		Return 1
	End If
Else
	// Fecha
	Return 0
End If


end event

type dw_visual from dc_w_sheet`dw_visual within w_ge437_laboratorios
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge437_laboratorios
end type

type dw_1 from dc_uo_dw_base within w_ge437_laboratorios
integer x = 50
integer y = 68
integer width = 2007
integer height = 244
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge437_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event itemchanged;call super::itemchanged;Long lvl_Lojas

Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial  		[1] = ivo_Filial.Cd_Filial
			This.Object.nm_fantasia	[1] = ivo_Filial.Nm_Fantasia
		End If
		
		dw_1.Object.Filial_t.Visible = 0
		dw_1.Object.Id_Conjunto_Filial.Visible = 0
		dw_1.Object.Id_Conjunto_Filial[1] = "T"
		
	Case "cd_laboratorio"
		ivo_Filial.of_Inicializa()
			
		This.Object.Cd_Filial  		[1] = ivo_Filial.Cd_Filial
		This.Object.nm_fantasia	[1] = ivo_Filial.Nm_Fantasia
		
		dw_1.Object.Filial_t.Visible = 1
		dw_1.Object.Id_Conjunto_Filial.Visible = 1
		dw_1.Object.Id_Conjunto_Filial[1] = "T"
		
	Case "id_conjunto_filial"
		
		ivs_filiais = ivs_nulo 
		
		If Data = 'C' Then
							
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				
				ivo_Filial.of_Inicializa()
			
				dw_1.Object.cd_filial			[1] = ivo_Filial.cd_filial
				dw_1.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia
					
				ivs_filiais = ivo_Selecao_filiais.ivs_filiais
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")					
			End If

		End If

End Choose

dw_2.Event ue_Reset()
end event

event ue_key;String lvs_Coluna 

dw_1.AcceptText()

lvs_Coluna = dw_1.GetColumnName()

If Key = KeyEnter! Then	
	If lvs_Coluna = "nm_fantasia" Then
		
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_Filial			[1] = ivo_Filial.Cd_Filial
			This.Object.nm_Fantasia		[1] = ivo_Filial.nm_fantasia		
			This.Object.cd_laboratorio	[1] = '000000000'
			
			dw_1.Object.Filial_t.Visible = 0
			dw_1.Object.Id_Conjunto_Filial.Visible = 0
			dw_1.Object.Id_Conjunto_Filial[1] = "T"
		End If
	End If
End If
end event

type dw_2 from dc_uo_dw_base within w_ge437_laboratorios
integer x = 55
integer y = 440
integer width = 2528
integer height = 1496
integer taborder = 30
string dataobject = "dw_ge437_laboratorios"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

event ue_postretrieve;call super::ue_postretrieve;If Not IsNull(dw_1.Object.cd_filial[1]) then
	wf_Lista_laboratorios()
Else
	wf_Lista_Filiais()
End If

dw_2.ResetUpdate( )

If pl_Linhas > 0 Then
	ivm_Menu.mf_SalvarComo(True)
	wf_Set_Somente_Consulta()
Else
	ivm_Menu.mf_SalvarComo(False)
End If

This.SetFocus()

Return AncestorReturnValue
end event

event ue_preretrieve;call super::ue_preretrieve;This.of_RestoreOriginalSQL()

dw_1.AcceptText()

If IsNull(dw_1.Object.cd_Filial[1]) and dw_1.Object.cd_laboratorio[1] = '000000000'  Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Informe a filial ou selecione o projeto.')
	Return -1 
End If

If Not IsNull(dw_1.Object.cd_Filial[1]) Then
	dw_2.of_ChangeDataObject("dw_ge437_laboratorios")
	ivi_Salva = 1
Else
	dw_2.of_ChangeDataObject("dw_ge437_filiais")
	ivi_Salva = 2
	
	If dw_1.Object.Id_Conjunto_Filial[1] = "C" Then
		If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
			dw_2.of_AppendWhere("cd_filial in (" + ivs_Filiais + ")")
		End If
	End If
End If

This.of_SetRowSelection()

Return AncestorReturnValue
end event

event itemchanged;call super::itemchanged;ivm_Menu.mf_Confirmar(True)
end event

event clicked;call super::clicked;String ls_DW, ls_Lab, ls_Filial, ls_Parametro

dw_1.AcceptText()

If dwo.name = 'p_localizar' Then
	
	If wf_Salva_Pendente() Then
		
		 MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas.")
		
//		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas.~r~r" + &
//						  "Deseja imprimir mesmo assim ?", Question!, YesNo!, 2) = 2 Then
//			lvb_Imprimir = False
//		End If
	End If
		
	
	ls_DW = dw_2.DataObject
	
	If ls_DW = "dw_ge437_filiais" Then
		ls_Lab 	= dw_1.Object.cd_laboratorio[1]
		ls_Filial 	= String(dw_2.Object.cd_Filial[dw_2.GetRow()], "0000")
	Else
		ls_Filial 	= String(dw_1.Object.cd_Filial[1], "0000")
		ls_Lab 	= dw_2.Object.cd_fornecedor[dw_2.GetRow()]
	End If
	
	//ls_Parametro = ls_Filial + ls_Lab
	
	OpenWithParm(w_ge437_historico, ls_Filial + ls_Lab)
End If
end event

event doubleclicked;call super::doubleclicked;dw_2.AcceptText()

If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	If This.RowCount() > 0 Then
		For lvl_Row = 1 To This.RowCount()				
			This.Object.Id_Ativo[lvl_Row] = lvs_Marcacao
		Next
		
		ivm_Menu.mf_Confirmar(True)
	End If
End If
end event

type cb_1 from commandbutton within w_ge437_laboratorios
boolean visible = false
integer x = 2121
integer y = 252
integer width = 475
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Marcar Todos"
end type

event clicked;Long ll_Linha

String ls_Selecao

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	If cb_1.Text = "Marcar Todos" Then
		ls_Selecao = 'S'
		cb_1.Text = "Desmarcar Todos"
	Else
		ls_Selecao = 'N	'
		cb_1.Text = "Marcar Todos"
	End If
	
	For ll_Linha = 1 To dw_2.RowCount()
		dw_2.Object.Id_Ativo[ll_Linha] = ls_Selecao
//		dw_2.Event itemchanged(ll_Linha, "id_ativo", ls_Selecao)
	Next
	
	ivm_Menu.mf_Confirmar(True)
	ivb_Valida_Salva = True
End If
end event

type gb_2 from groupbox within w_ge437_laboratorios
integer x = 23
integer y = 368
integer width = 2592
integer height = 1600
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge437_laboratorios
integer x = 23
integer y = 4
integer width = 2066
integer height = 348
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

