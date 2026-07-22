HA$PBExportHeader$w_ge378_inativar_produto_via_excel.srw
forward
global type w_ge378_inativar_produto_via_excel from dc_w_selecao_lista_relatorio
end type
type cb_consultar from picturebutton within w_ge378_inativar_produto_via_excel
end type
type cb_inativar from picturebutton within w_ge378_inativar_produto_via_excel
end type
type cb_1 from commandbutton within w_ge378_inativar_produto_via_excel
end type
end forward

global type w_ge378_inativar_produto_via_excel from dc_w_selecao_lista_relatorio
string accessiblename = "Ativar Inativar Produtos na Distribuidora via Excel (GE378)"
integer width = 3502
integer height = 2024
string title = "GE378 - Altera Situa$$HEX2$$e700e300$$ENDHEX$$o Produto Distribuidora via Excel"
cb_consultar cb_consultar
cb_inativar cb_inativar
cb_1 cb_1
end type
global w_ge378_inativar_produto_via_excel w_ge378_inativar_produto_via_excel

on w_ge378_inativar_produto_via_excel.create
int iCurrent
call super::create
this.cb_consultar=create cb_consultar
this.cb_inativar=create cb_inativar
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_consultar
this.Control[iCurrent+2]=this.cb_inativar
this.Control[iCurrent+3]=this.cb_1
end on

on w_ge378_inativar_produto_via_excel.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_consultar)
destroy(this.cb_inativar)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;//inserir + campo em 
DataWindowChild lvdwc

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "00")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODOS")
	
     dw_1.Object.cd_uf[1] = "00"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do grupo.")
End If

If dw_1.Object.id_procedimento[1]  <> "B" Then
	dw_1.Object.dh_fim_situacao.Visible = 0
	dw_1.Object.termino_bloqueio_t.Visible = 0
Else	
	dw_1.Object.dh_fim_situacao.Visible = 1
	dw_1.Object.termino_bloqueio_t.Visible = 1
End If	

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge378_inativar_produto_via_excel
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge378_inativar_produto_via_excel
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge378_inativar_produto_via_excel
integer y = 504
integer width = 3406
integer height = 1324
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge378_inativar_produto_via_excel
integer y = 8
integer width = 2313
integer height = 496
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge378_inativar_produto_via_excel
integer width = 2144
integer height = 396
string dataobject = "dw_ge378_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "id_procedimento"
		If  Data = "B" Then 
			dw_1.Object.dh_fim_situacao.Visible = 1
			dw_1.Object.termino_bloqueio_t.Visible = 1
		Else
			dw_1.Object.dh_fim_situacao.Visible = 0
			dw_1.Object.termino_bloqueio_t.Visible = 0
		End If	
End Choose 
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge378_inativar_produto_via_excel
integer y = 568
integer width = 3346
integer height = 1244
string dataobject = "dw_ge378_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;String lvs_Arquivo 
String lvs_Fornecedor
String lvs_Uf
String lvs_UF_Produto
String lvs_Situacao
String lvs_Situacao_atual

String lvs_Descricao_Produto
String lvs_Produto
String lvs_Apresentacao_Estoque
String lvs_Descricao_Distribuidora
String ls_Motivo

DateTime ldh_Termino_Bloqueio
DateTime ldh_GetDate

Any lva_Dado

Long	lvl_Linhas,&
		lvl_Linha,&
		lvl_Insert,&
		lvl_Produto,&
		lvl_Find,&
		lvl_Linha_Produto
		
dw_2.Reset()

dw_1.Accepttext( )

lvs_Arquivo 			 = dw_1.Object.nm_arquivo    	 				[1]
lvs_Fornecedor 	 = dw_1.Object.cd_fornecedor					[1]
lvs_Uf					 = dw_1.Object.cd_uf     						[1]
ls_Motivo				 = dw_1.Object.de_motivo						[1]
lvs_Situacao 		 =  dw_1.Object.id_procedimento				[1]
ldh_Termino_Bloqueio	 = dw_1.Object.Dh_Fim_Situacao  	[1]

ldh_GetDate = gf_GetServerDate()

If IsNull(lvs_Fornecedor) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma distribuidora",Information!)
	dw_1.Event ue_Pos(1,"cd_fornecedor")
	Return -1
End If

//If lvs_uf = '00'  Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a unidade federa$$HEX2$$e700e300$$ENDHEX$$o",Information!)
//	dw_1.Event ue_Pos(1,"cd_uf")
//	Return -1
//End If

If isNull(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione o arquivo a ser importado.",Information!)
	dw_1.Event ue_Pos(1,"nm_arquivo")
	Return -1
End If

If IsNull( ls_Motivo ) Or Trim( ls_Motivo ) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.",Information!)
	dw_1.Event ue_Pos(1,"de_motivo")
	Return -1
End If

If Len(ls_Motivo) < 5 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe pelo menos 5 caract$$HEX1$$e900$$ENDHEX$$res no motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.",Information!)
	dw_1.Event ue_Pos(1,"de_motivo")
	Return -1	
End If

If lvs_Situacao = 'B'  Then
		If IsNull(ldh_Termino_Bloqueio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data fim do bloqueio.")
			dw_1.Event ue_Pos(1,"dh_fim_situacao")
			Return -1
		End If
		If ldh_Termino_Bloqueio <= ldh_GetDate Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do bloqueio n$$HEX1$$e300$$ENDHEX$$o pode ser igual ou inferior a hoje.")
			dw_1.Event ue_Pos(1,"dh_fim_situacao")
			Return -1
		End If
End if

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge378_distribuidora_produto") Then
	Destroy(lvds)
	Return -1
End If

dc_uo_excel lvo_Excel
lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		//esconder execu$$HEX2$$e700e300$$ENDHEX$$o
		dw_2.SetRedRaw(false) 
		
		If lvs_UF <> '00' Then
			lvds.of_AppendWhere("d.cd_unidade_federacao = '" + lvs_UF + "'")
		End If
		
		For lvl_Linha = 1 To lvl_Linhas
			
			w_Aguarde.title = "Recuperando Informa$$HEX2$$e700f500$$ENDHEX$$es da Planilha. " + &
	                 String(lvl_Linha) + " de " + String(lvl_Linhas) + "."
			
			lva_Dado 	= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
			lvs_Produto 	= String(lva_Dado)
			
			lva_Dado 						= lvo_Excel.uo_Lendo_Dados(lvl_linha,"B")
			lvs_Descricao_Distribuidora 	= Upper(String(lva_Dado))
	
			lvds.Retrieve(lvs_Fornecedor, lvs_Produto, lvs_Situacao)
						
			For lvl_Linha_Produto = 1 To  lvds.Rowcount()
				
				lvl_Produto 						= lvds.Object.cd_produto							[lvl_Linha_Produto]
				lvs_Descricao_Produto		= lvds.Object.de_produto							[lvl_Linha_Produto]
				lvs_Apresentacao_Estoque 	= lvds.Object.de_apresentacao_estoque			[lvl_Linha_Produto]
				lvs_UF_Produto					= lvds.Object.cd_unidade_federacao				[lvl_Linha_Produto]
				lvs_Situacao_atual				= lvds.Object.id_situacao							[lvl_Linha_Produto]
				
				//trazer apenas um resultado - Ignora os resultados repetidos
				//lvl_Find = dw_2.Find("cd_produto = " + string(lvl_Produto) + " and cd_unidade_federacao = '" + lvs_UF_Produto + "'", 1, dw_2.RowCount())
				
				If lvl_Find = 0 Then 
					lvl_Insert = dw_2.InsertRow(0)
					dw_2.Object.cd_unidade_federacao[lvl_Insert] 	= lvs_UF_Produto
					dw_2.Object.cd_produto[lvl_Insert] 					= lvl_Produto
					dw_2.Object.de_produto[lvl_Insert] 					= lvs_Descricao_Produto + " : " + lvs_Apresentacao_Estoque
					dw_2.Object.de_produto_distribuidora[lvl_Insert] 	= lvs_Descricao_Distribuidora
					dw_2.Object.id_situacao_atual	          [lvl_Insert] 	= lvs_Situacao_atual
					
				End If
				
			Next
						
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
		
		dw_2.Sort()
		dw_2.SetRedRaw(true) 
		
		If dw_2.RowCount() > 0 Then
			cb_inativar.Enabled = True
		Else
			cb_inativar.Enabled = False
		End If
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui produtos .")
	End If
End If

Close(w_Aguarde)

Destroy(lvo_Excel)
Destroy(lvds)

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge378_inativar_produto_via_excel
integer x = 3186
integer y = 24
integer width = 64
integer height = 208
end type

type cb_consultar from picturebutton within w_ge378_inativar_produto_via_excel
integer x = 2071
integer y = 236
integer width = 110
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\icon_search.PNG"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String lvs_Arquivo
String lvs_Nome

Integer lvi_Retorno 

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A planilha deve estar da seguinte forma:~r~r" + &
                     	 "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto na Distribuidora~r"     + &
					 "Coluna B = Descri$$HEX2$$e700e300$$ENDHEX$$o do Produto na Distribuidora~r")
///					 DATA 
						  
lvi_Retorno = GetFileOpenName("Seleciona o arquivo", lvs_Arquivo, lvs_Nome, "XLS", "Excel (*.XLS),*.XLS,Excel (*.XLSX), *.XLSX,")

If lvi_Retorno = 1 Then
	dw_1.Object.nm_arquivo[1] = Upper(lvs_Arquivo)
Else
	Return -1
End If
end event

type cb_inativar from picturebutton within w_ge378_inativar_produto_via_excel
integer x = 2981
integer y = 376
integer width = 462
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar_desabilitado.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Boolean lvb_Sucesso = True

Long 	lvl_Produto,&
		lvl_Linha
		
String lvs_Distribuidora
String lvs_Uf
String lvs_Matricula
String ls_Motivo
String ls_Procedimento

DateTime ldh_Fim_Situacao


dw_1.AcceptText()
dw_2.AcceptText()

lvs_Distribuidora	 =	dw_1.Object.cd_fornecedor			[1]
ls_Motivo				 =	dw_1.Object.de_motivo				[1]
ls_Procedimento	 =	dw_1.Object.id_procedimento		[1]
ldh_Fim_Situacao	 = dw_1.Object.Dh_Fim_Situacao		[1]
lvs_Matricula 		 = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

If not ls_Procedimento = 'B'  Then	SetNull(ldh_Fim_Situacao)	

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o dos produtos ?", Question! , YesNo!, 2) = 1 Then
		
	SetPointer(HourGlass!)

	For lvl_Linha = 1 to dw_2.rowcount()
	
		If dw_2.Object.id_situacao[lvl_Linha] = 'S' Then
			
			lvl_Produto 	= dw_2.Object.cd_produto					[lvl_Linha]
			lvs_Uf			= dw_2.Object.cd_unidade_federacao	[lvl_Linha]
			
			 UPDATE distribuidora_produto  
				  SET id_situacao 							 = :ls_Procedimento,
						dh_alteracao_situacao 			 = getdate(),   
						nr_matric_alteracao_situacao 	 =: lvs_Matricula,   
						de_alteracao_situacao 			 =: ls_Motivo,
						dh_alteracao_situacao_termino = :ldh_Fim_Situacao,
						id_situacao_anterior				 = id_situacao
				Where cd_distribuidora					=: lvs_Distribuidora
					and cd_produto							=: lvl_Produto
					and cd_unidade_federacao 			=: lvs_UF
				Using SqlCa;
			
				If SQLCA.SQlCode = -1 Then 
					SqlCa.of_MsgDBError("Erro ao atualizar o produto '" + String(lvl_produto) + "' na distribuidora.")
					lvb_Sucesso = False
					Exit
				End If			
		End If
	Next

			
	If lvb_Sucesso  Then
		SQLCA.of_Commit();
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A situa$$HEX2$$e700e300$$ENDHEX$$o dos produtos foi alterada com sucesso.')
	Else
		SQLCA.of_Rollback();
	End If	
	
	dw_1.Reset()
	dw_2.Reset()
	dw_1.Event ue_AddRow()
	This.Enabled = False
	
	SetPointer(Arrow!)
	
End If

Return 1
end event

type cb_1 from commandbutton within w_ge378_inativar_produto_via_excel
boolean visible = false
integer x = 2624
integer y = 244
integer width = 823
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Ativa Produtos uo_ge162"
end type

event clicked;uo_ge162_desbloquear_produto  lo_Teste

Try
	
	lo_Teste = Create uo_ge162_desbloquear_produto
	lo_Teste.of_desbloqueia_produto_distribuidora()
	
Finally
	Destroy(lo_Teste)

End Try

end event

