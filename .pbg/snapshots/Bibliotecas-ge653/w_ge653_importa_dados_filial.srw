HA$PBExportHeader$w_ge653_importa_dados_filial.srw
forward
global type w_ge653_importa_dados_filial from dc_w_cadastro_lista
end type
type pb_localiza from picturebutton within w_ge653_importa_dados_filial
end type
type cb_cancelar from commandbutton within w_ge653_importa_dados_filial
end type
type cb_ok from commandbutton within w_ge653_importa_dados_filial
end type
end forward

global type w_ge653_importa_dados_filial from dc_w_cadastro_lista
integer width = 2322
integer height = 584
string title = "GE653 - Importa Dados Filial"
pb_localiza pb_localiza
cb_cancelar cb_cancelar
cb_ok cb_ok
end type
global w_ge653_importa_dados_filial w_ge653_importa_dados_filial

forward prototypes
public function boolean wf_processa_excel (string as_arquivo, ref string as_erro)
end prototypes

public function boolean wf_processa_excel (string as_arquivo, ref string as_erro);Boolean lb_Sucesso = True
Long ll_Linha, ll_Linhas, ll_Achou, ll_Filial, ll_Aux, ll_Contador = 0
String ls_Id_Agrupamento

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o dos dados do excel?" , Question!, OkCancel!, 2) = 2 Then 
	as_Erro = 'Processo abortado, nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi salva.'
	Return False
End If

Try

	SetPointer(HourGlass!)
	
	dc_uo_ds_Base lds_dados_excel
	lds_dados_excel = Create dc_uo_ds_base
	If Not lds_dados_excel.of_ChangeDataObject( 'ds_ge653_dados_excel' ) Then 
		as_Erro = 'Erro no change da ds_ge653_dados_excel.'
		lb_Sucesso = False
		Return lb_Sucesso
	End If
	
	dc_uo_excel lvo_Excel
	lvo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	
	lvo_Excel.uo_referencia_objeto_excel(as_arquivo)
	lvo_Excel.lole_book.ActiveCell.CurrentRegion.Select()
	lvo_Excel.lole_book.Selection.Copy()
	
	ll_Linhas = lds_dados_excel.ImportClipboard() 
	Clipboard("") 
	
	w_aguarde.uo_Progress.Of_SetMax(ll_Linhas)
	
	If ll_Linhas > 0 Then
		
		If IsNumber(String(lds_dados_excel.Object.cd_filial[1])) Then
			ll_Aux = 1
		Else
			ll_Aux = 2
		End If
	
		For ll_linha = ll_Aux to ll_linhas
			w_aguarde.uo_Progress.Of_SetProgress(ll_Linha)
			
			ll_Filial 					= long(lds_dados_excel.Object.cd_filial[ll_linha])
			ls_Id_Agrupamento 	= String(lds_dados_excel.Object.id_novo_porte[ll_linha])
			
			If ll_Filial > 0 Then
			
				SELECT count(*)
				INTO :ll_Achou
				FROM filial
				WHERE cd_filial = :ll_Filial
				Using sqlca;
				
				If SqlCa.SqlCode = -1 Then
					Sqlca.of_rollback()
					as_Erro = "Erro ao consultar tabela de filiais. Filial: " + string(ll_filial) + ' ~r' + SqlCa.SqlErrText
					lb_Sucesso = False
					Exit
				End If
				
				If ll_Achou > 0 Then
					UPDATE filial
					SET id_agrupamento = :ls_Id_Agrupamento
					WHERE cd_filial= :ll_Filial
					Using Sqlca;
	
					If SqlCa.SqlCode = -1 Then
						Sqlca.of_rollback()
						as_Erro = "Erro ao atualizar filial: " + string(ll_filial) + ' ~r' + SqlCa.SqlErrText
						lb_Sucesso = False
						Exit
					End If
				End If
				
	//			ll_Contador++
	//			
	//			If ll_Contador > 50 Then
	//				Sqlca.of_commit()
	//				ll_Contador = 0
	//			End If
	
			Else
				Continue
			End If
		Next
		
	Else
		as_Erro = "Sem dados para importa$$HEX2$$e700e300$$ENDHEX$$o no arquivo excel!" 
		lb_Sucesso = False
	End If
		
Finally
	If IsValid(lvo_Excel) Then Destroy(lvo_Excel)
	If IsValid(lds_dados_excel) Then Destroy(lds_dados_excel)
	
	Close(w_Aguarde)
	
	If lb_Sucesso Then 
		Sqlca.of_commit()
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Processo de importa$$HEX2$$e700e300$$ENDHEX$$o conclu$$HEX1$$ed00$$ENDHEX$$do!')
	Else
		Sqlca.of_rollback()
		as_Erro = 'Processo de importa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o gravou nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o!~r' + as_Erro
	End if
	
End Try

Return lb_Sucesso
end function

on w_ge653_importa_dados_filial.create
int iCurrent
call super::create
this.pb_localiza=create pb_localiza
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_localiza
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_ok
end on

on w_ge653_importa_dados_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_localiza)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
end on

event ue_postopen;call super::ue_postopen;dw_1.event ue_addrow( )
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge653_importa_dados_filial
integer x = 82
integer y = 188
integer width = 1262
integer height = 92
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge653_importa_dados_filial
integer x = 46
integer y = 116
integer width = 1353
integer height = 180
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge653_importa_dados_filial
integer x = 37
integer width = 2030
integer height = 72
string dataobject = "dw_ge653_selecao_arquivo"
boolean vscrollbar = false
boolean livescroll = false
string ivs_cor_linha_padrao = ""
end type

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge653_importa_dados_filial
integer x = 23
integer y = 4
integer width = 2240
integer height = 392
end type

type pb_localiza from picturebutton within w_ge653_importa_dados_filial
string tag = "Localiza o arquivo excel com filial e parametro"
integer x = 2057
integer y = 80
integer width = 128
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\localizar_arquivo.bmp"
end type

event clicked;String lvs_Path, &
       lvs_Nome_Arquivo
		 
Integer lvi_Arquivo

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Somente os dados da coluna A e H ser$$HEX1$$e300$$ENDHEX$$o usados para a importa$$HEX2$$e700e300$$ENDHEX$$o:~r~r" + &
                     "Coluna A = Filial (Legado)" + &
				   "~rColuna H = ID Agupamento." +&
							"~r~r* Todos as c$$HEX1$$e900$$ENDHEX$$lulas devem estar como Texto no excel."+ &
							"~r~r** Somente c$$HEX1$$f300$$ENDHEX$$digos validos de Filiais ser$$HEX1$$e300$$ENDHEX$$o importados.")
		 
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo = 1 Then
	dw_1.Object.nm_arquivo[1] = lvs_Path
	cb_OK.Enabled = True
End If
end event

type cb_cancelar from commandbutton within w_ge653_importa_dados_filial
integer x = 1874
integer y = 228
integer width = 311
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_ge653_importa_dados_filial
integer x = 1509
integer y = 228
integer width = 311
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
end type

event clicked;String ls_Arquivo, ls_Erro

dw_1.AcceptText()

ls_Arquivo = dw_1.Object.nm_arquivo [1]

If Trim(ls_Arquivo) = "" or isnull(ls_Arquivo) or len(trim(ls_Arquivo)) < 4 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um arquivo v$$HEX1$$e100$$ENDHEX$$lido.")
	dw_1.Event ue_Pos(1, "nm_arquivo")
	Return -1
End If

If Not Wf_Processa_Excel(ls_Arquivo, Ref ls_Erro) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro)
	Return -1
End If

Close(Parent)


end event

