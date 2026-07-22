HA$PBExportHeader$w_ge116_horario_colaboradores.srw
forward
global type w_ge116_horario_colaboradores from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge116_horario_colaboradores
end type
type cb_marcar from commandbutton within w_ge116_horario_colaboradores
end type
type cb_2 from commandbutton within w_ge116_horario_colaboradores
end type
end forward

global type w_ge116_horario_colaboradores from dc_w_selecao_lista_relatorio
integer width = 1819
integer height = 2060
string title = "GE116 - Relat$$HEX1$$f300$$ENDHEX$$rio de Hor$$HEX1$$e100$$ENDHEX$$rio de Trabalho dos Colaboradores"
string menuname = "m_janelas"
long backcolor = 80269524
cb_1 cb_1
cb_marcar cb_marcar
cb_2 cb_2
end type
global w_ge116_horario_colaboradores w_ge116_horario_colaboradores

type variables
dc_uo_transacao itr_RH

uo_selecao_filiais ivo_Filial

uo_ge216_filiais io_filiais

String ivs_filiais
String ivs_nulo

boolean ivb_check
end variables

forward prototypes
public function string wf_quebras (long pl_linhas)
public function string wf_quebras_parana (long pl_linhas)
public subroutine wf_gera_excel (datawindow pdw_excel)
end prototypes

public function string wf_quebras (long pl_linhas);Choose Case pl_Linhas
	Case 1
		Return "~r~r~r~r~r~r"
		
	Case 2
		Return "~r~r~r~r~r"
		
	Case 3
		Return "~r~r~r~r"
		
	Case 4
		Return "~r~r~r"
		

	Case 5
		Return "~r~r"

	Case 6
		Return "~r~r"

	Case 7
		Return "~r~r"

End Choose

end function

public function string wf_quebras_parana (long pl_linhas);Choose Case pl_Linhas
	Case 1
		Return "~r~r~r~r~r"
		
	Case 2
		Return "~r~r~r~r"
		
	Case 3
		Return "~r~r~r"
		
End Choose

end function

public subroutine wf_gera_excel (datawindow pdw_excel);String ls_Path
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
	 
	 
	 If pdw_Excel.SaveAs( ls_Path, Excel!, True ) = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + ls_Path + "'.")
	 Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + ls_Path + "'.", StopSign!)
	 End If
	 
End If

end subroutine

on w_ge116_horario_colaboradores.create
int iCurrent
call super::create
if this.MenuName = "m_janelas" then this.MenuID = create m_janelas
this.cb_1=create cb_1
this.cb_marcar=create cb_marcar
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_marcar
this.Control[iCurrent+3]=this.cb_2
end on

on w_ge116_horario_colaboradores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_marcar)
destroy(this.cb_2)
end on

event close;call super::close;itr_RH.of_Disconnect()
Destroy itr_RH
Destroy io_Filiais
end event

event open;call super::open;io_Filiais = Create uo_ge216_filiais

If Not gf_conecta_banco_rh(itr_RH, "vetorh_ti") Then
	MessageBox('Falha!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao banco de dados ORACLE_RH.~r~nA tela '+This.Title+' ser$$HEX1$$e100$$ENDHEX$$ encerrada.',Exclamation!)
	Close(This)
End If
end event

event ue_postopen;call super::ue_postopen;dw_3.of_SetTransObject(itr_RH)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge116_horario_colaboradores
integer x = 73
integer y = 1244
integer width = 1637
integer height = 148
string dataobject = "dw_auxilio_visual"
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge116_horario_colaboradores
integer x = 37
integer y = 1172
integer width = 1728
integer height = 236
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aux$$HEX1$$ed00$$ENDHEX$$lio Visual"
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge116_horario_colaboradores
integer y = 256
integer width = 1719
integer height = 1492
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge116_horario_colaboradores
integer width = 1065
integer height = 224
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge116_horario_colaboradores
integer x = 64
integer y = 100
integer width = 1015
integer height = 88
integer taborder = 40
string dataobject = "dw_ge116_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long ll_Lojas

Choose Case dwo.Name
	Case "id_tipo"
		
		If Data = 'CF' Then
		
			ivs_filiais = ivs_nulo 
						
			OpenWithParm(w_ge216_selecao_filiais, io_Filiais)
			
			ll_Lojas = Message.DoubleParm
			
			If ll_Lojas > 0 Then
				ivs_filiais = io_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
		
		End If

End Choose 
		
cb_Marcar.Text = "Marcar &Todas"
cb_Marcar.Enabled = False
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge116_horario_colaboradores
event ue_mousemove pbm_mousemove
integer x = 64
integer y = 320
integer width = 1655
integer height = 1400
integer taborder = 50
string dataobject = "dw_ge116_lista_filiais"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Rede

dw_1.AcceptText()

ls_Rede = dw_1.Object.Id_Tipo[1]

If ls_Rede <> 'TD' Then
	This.of_AppendWhere("f.cd_filial in (" + ivs_filiais + ")")
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	cb_Marcar.Enabled = True
Else
	cb_Marcar.Enabled = False
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge116_horario_colaboradores
integer x = 978
integer y = 1248
integer height = 236
integer taborder = 60
string dataobject = "dw_ge116_relatorio"
end type

type cb_1 from commandbutton within w_ge116_horario_colaboradores
integer x = 1143
integer y = 24
integer width = 613
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Imprimir"
end type

event clicked;Long 	ll_Empresa  , &
		ll_Tipo     	, &
		ll_Matricula	, &
		ll_Filial   		, &
		ll_Linha    	, &
		ll_Linhas   	, &
		ll_Linha_Col	, &
		ll_Linhas_Col, &
		ll_Linha_Aux	, &
		lvl_Cidade
	  
String ls_Texto, &
		 ls_Imprimir, &
		 ls_Append

ll_Linhas = dw_2.RowCount()

SetNull(ls_Append)

dw_3.of_ChangeDataObject('dw_ge116_relatorio')
dw_3.of_SetTransObject(itr_RH)

For ll_Linha = 1 To ll_Linhas	
	
	ls_Imprimir = dw_2.Object.Id_Imprimir[ll_Linha]
	
	If ls_Imprimir = "S" Then
		ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]
		
		If IsNull(ls_Append) Then
			ls_Append = String(ll_Filial)
		Else
			ls_Append += "," + String(ll_Filial)
		End If
		
	End If

Next

If Not IsNull(ls_Append) Then
	dw_3.of_AppendWhere('fil_sybase in (' + ls_Append + ')') 
	
	ll_Linhas_Col =dw_3.Retrieve(1, 1)
	
	If ll_Linhas_Col > 0 Then
		
		For ll_Linha = 1 To ll_Linhas	
			ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]
			
			For ll_Linha_Aux = 1 To dw_3.RowCount()
				If dw_3.Object.fil_sybase[ll_Linha_Aux] = ll_Filial Then
					dw_3.Object.nm_fantasia[ll_Linha_Aux] = dw_2.Object.Nm_Fantasia[ll_Linha]
				End If
			Next
			
		Next
		
		For ll_Linha_Col = 1 To ll_Linhas_Col
			ll_Matricula = dw_3.Object.Matricula[ll_Linha_Col]
			
			DECLARE sp_quadro procedure for sp_monta_quadro_horarios 
			  ( p_empresa			=> 1,
				p_tipo					=> 1,
				p_matricula			=> :ll_Matricula
			  )
			 Using itr_RH;	
			 
			Execute sp_quadro;
			
			Fetch sp_quadro Into :ls_Texto;
			
			Close sp_Quadro;
			
			Choose Case itr_RH.SqlCode
				Case -1
					itr_RH.of_MsgDbError()
					Return -1
			End Choose
			
			dw_3.Object.Horario[ll_Linha_Col] = ls_Texto
		Next
		
		//dw_3.Object.t_Filial.Text  = dw_2.Object.Nm_Fantasia[ll_Linha] + ' (' + String(ll_Filial) + ')'
		dw_3.Event ue_PrintImmediate()		
	End If
	
End If
end event

type cb_marcar from commandbutton within w_ge116_horario_colaboradores
integer x = 1184
integer y = 1764
integer width = 571
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Marcar &Todas"
end type

event clicked;String ls_Selecao

Long ll_Linha


If This.Text = "Marcar &Todas" Then
	This.Text = "Desmarcar &Todas"
	ls_Selecao = "S"
Else
	This.Text = "Marcar &Todas"
	ls_Selecao = "N"
End If

For ll_Linha = 1 To dw_2.RowCount()
	dw_2.Object.Id_Imprimir[ll_Linha] = ls_Selecao
Next
end event

type cb_2 from commandbutton within w_ge116_horario_colaboradores
integer x = 1143
integer y = 140
integer width = 613
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exportar para Excel"
end type

event clicked;Long ll_Empresa  , &
     ll_Tipo     , &
	  ll_Matricula, &
	  ll_Filial   , &
	  ll_Linha    , &
	  ll_Linhas   , &
	  ll_Linha_Col, &
	  ll_Linhas_Col, &
	  ll_Linha_Aux, &
	  lvl_Cidade
	  
String ls_Texto = space(200) , &
		 ls_Imprimir, &
		 ls_Append

ll_Linhas = dw_2.RowCount()

If dw_2.Find("id_imprimir = 'S' ",1, ll_Linhas ) <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione pelo menos um filial.")
	Return -1	
End If

SetNull(ls_Append)

dw_3.of_ChangeDataObject('dw_ge116_relatorio')
dw_3.of_SetTransObject(itr_RH)

For ll_Linha = 1 To ll_Linhas	
	
	ls_Imprimir = dw_2.Object.Id_Imprimir[ll_Linha]
	
	If ls_Imprimir = "S" Then
		ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]
		
		If IsNull(ls_Append) Then
			ls_Append = String(ll_Filial)
		Else
			ls_Append += "," + String(ll_Filial)
		End If
		
	End If

Next

If Not IsNull(ls_Append) Then
	dw_3.of_AppendWhere('fil_sybase in (' + ls_Append + ')') 
	
	ll_Linhas_Col =dw_3.Retrieve(1, 1)
	
	If ll_Linhas_Col > 0 Then
		
		For ll_Linha = 1 To ll_Linhas	
			ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]
			
			For ll_Linha_Aux = 1 To dw_3.RowCount()
				If dw_3.Object.fil_sybase[ll_Linha_Aux] = ll_Filial Then
					dw_3.Object.nm_fantasia[ll_Linha_Aux] = dw_2.Object.Nm_Fantasia[ll_Linha]
				End If
			Next
			
		Next
		
		For ll_Linha_Col = 1 To ll_Linhas_Col
			ll_Matricula = dw_3.Object.Matricula[ll_Linha_Col]
			
		/*	Declare sp_quadro procedure For sp_monta_quadro_horarios
				@empresa			= 1,
				@tipo					= 1,
				@matricula			= :ll_Matricula, 
				@texto_completo	= :ls_Texto
			 Using itr_RH;*/
			 
			DECLARE sp_quadro procedure for sp_monta_quadro_horarios 
			  ( p_empresa			=> 1,
				p_tipo					=> 1,
				p_matricula			=> :ll_Matricula
			  )
			 Using itr_RH;
			 
			Execute sp_quadro;
			
			Fetch sp_quadro Into :ls_Texto;
			
			Close sp_Quadro;
			
			Choose Case itr_RH.SqlCode
				Case -1
					itr_RH.of_MsgDbError()
					Exit
			End Choose
			
			dw_3.Object.Horario[ll_Linha_Col] = ls_Texto
		Next
		
		wf_gera_excel(dw_3)

	End If
	
End If
end event

