HA$PBExportHeader$dc_w_sort_dw.srw
forward
global type dc_w_sort_dw from dc_w_response
end type
type gb_2 from groupbox within dc_w_sort_dw
end type
type gb_1 from groupbox within dc_w_sort_dw
end type
type dw_1 from dc_uo_dw_base within dc_w_sort_dw
end type
type dw_2 from dc_uo_dw_base within dc_w_sort_dw
end type
type uo_selecao from dc_uo_barra_selecao_vertical within dc_w_sort_dw
end type
type cb_ok from commandbutton within dc_w_sort_dw
end type
type cb_cancelar from commandbutton within dc_w_sort_dw
end type
type uo_selecao_move from dc_uo_barra_selecao within dc_w_sort_dw
end type
end forward

global type dc_w_sort_dw from dc_w_response
integer x = 270
integer y = 600
integer width = 3657
integer height = 1376
string title = "Classifica$$HEX2$$e700e300$$ENDHEX$$o de Dados"
boolean controlmenu = false
long backcolor = 80269524
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
uo_selecao uo_selecao
cb_ok cb_ok
cb_cancelar cb_cancelar
uo_selecao_move uo_selecao_move
end type
global dc_w_sort_dw dc_w_sort_dw

type variables
dc_uo_sort_dw ivo_sort
end variables

forward prototypes
public function boolean wf_grava_classificacao_padrao ()
public function boolean wf_carrega_classificacao_padrao ()
end prototypes

public function boolean wf_grava_classificacao_padrao ();Long ll_Linha

String ls_Coluna
String ls_Nome
String ls_Ordem
String ls_Bloqueio
String ls_Msg

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "GC" Then
	If Not IsNull(gvo_Aplicacao.ivs_Procedimento_Sistema) And Trim(gvo_Aplicacao.ivs_Procedimento_Sistema) <> "" Then
		
		Try
			
			//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o no banco de dados
			dc_uo_transacao lo_SqlCa
			lo_SqlCa = Create dc_uo_transacao
			lo_SqlCa.ivs_database = "SYBASE"
			
			If lo_SqlCa.of_Connect("") Then
				
				Delete From classificacao_padrao_usuario
				Where cd_sistema = :gvo_Aplicacao.ivo_seguranca.cd_sistema
					And cd_procedimento = :gvo_Aplicacao.ivs_Procedimento_Sistema
					And nr_matricula = :gvo_Aplicacao.ivo_seguranca.Nr_Matricula
				Using lo_SqlCa;
					
				If lo_SqlCa.SqlCode = -1 Then
					ls_Msg = "Exclus$$HEX1$$e300$$ENDHEX$$o da classifica$$HEX2$$e700e300$$ENDHEX$$o padr$$HEX1$$e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio. " + lo_SqlCa.SqlErrText
					lo_SqlCa.of_Rollback()
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Msg, StopSign!)
					Return False
				End If
				 
				 For ll_Linha = 1 To dw_2.RowCount()
				  
					  ls_Coluna		= dw_2.Object.Coluna	[ll_Linha]
					  ls_Nome		= dw_2.Object.Nome		[ll_Linha]
					  ls_Ordem		= dw_2.Object.Ordem	[ll_Linha]
					  ls_Bloqueio	= dw_2.Object.Bloqueio	[ll_Linha]
					  
					  Insert Into classificacao_padrao_usuario (	  cd_sistema,
																			  cd_procedimento,
																			  nr_matricula,
																			  nr_sequencia,
																			  de_coluna,
																			  de_nome_coluna,
																			  id_ordem,
																			  id_bloqueio )
						 Values (	 :gvo_Aplicacao.ivo_seguranca.cd_sistema,
									 :gvo_Aplicacao.ivs_Procedimento_Sistema,
									 :gvo_Aplicacao.ivo_seguranca.Nr_Matricula,
									 :ll_Linha,
									 :ls_Coluna,
									 :ls_Nome,
									 :ls_Ordem,
									 :ls_Bloqueio )
					  Using lo_SqlCa;
					  
					If lo_SqlCa.Sqlcode = -1 Then
						ls_Msg = "Inclus$$HEX1$$e300$$ENDHEX$$o do classifica$$HEX2$$e700e300$$ENDHEX$$o padr$$HEX1$$e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio. " + lo_SqlCa.SqlErrText
						lo_SqlCa.of_Rollback()
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Msg, StopSign!)
						Return False
					End If
			 	Next
			
				lo_SqlCa.of_Commit()
				
				gvo_Aplicacao.ivs_Procedimento_Sistema = ""
			End If
			
		Finally
			If IsValid(lo_SqlCa) Then Destroy(lo_SqlCa)
		End Try
	End If
End If
end function

public function boolean wf_carrega_classificacao_padrao ();Long ll_Linha

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "GC" Then
	If Not IsNull(gvo_Aplicacao.ivs_Procedimento_Sistema) And Trim(gvo_Aplicacao.ivs_Procedimento_Sistema) <> "" Then
		
		Try
		
			dc_uo_ds_base lds
			lds = Create dc_uo_ds_base
			
			If Not lds.of_ChangeDataObject("ds_sort_classificacao_padrao_usuario") Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_sort_classificacao_padrao_usuario'.", StopSign!)
				Return False
			End If
			
			lds.Retrieve(gvo_Aplicacao.ivo_Seguranca.Cd_Sistema, gvo_Aplicacao.ivs_Procedimento_Sistema, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)
			
			dw_2.Reset()
			
			For ll_Linha = 1 To lds.RowCount()
				dw_2.InsertRow(0)
				
				dw_2.Object.Coluna	[ll_Linha] = lds.Object.De_Coluna			[ll_Linha]
				dw_2.Object.Nome	[ll_Linha] = lds.Object.De_Nome_Coluna	[ll_Linha]
				dw_2.Object.Ordem	[ll_Linha] = lds.Object.Id_Ordem			[ll_Linha]
				dw_2.Object.Bloqueio	[ll_Linha] = lds.Object.Id_Bloqueio			[ll_Linha]
			Next
		
		Finally
			If IsValid(lds) Then Destroy(lds)
		End Try
	End If
End If

Return True
end function

on dc_w_sort_dw.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.uo_selecao=create uo_selecao
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
this.uo_selecao_move=create uo_selecao_move
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.uo_selecao
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.cb_cancelar
this.Control[iCurrent+8]=this.uo_selecao_move
end on

on dc_w_sort_dw.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.uo_selecao)
destroy(this.cb_ok)
destroy(this.cb_cancelar)
destroy(this.uo_selecao_move)
end on

event open;call super::open;ivo_Sort = Create dc_uo_Sort_DW

ivo_Sort = Message.PowerObjectParm
end event

event ue_postopen;call super::ue_postopen;If gvo_aplicacao.ivo_Seguranca.Cd_Sistema = 'RL' Then
	pb_Help.Visible = True
End If

ivo_Sort.ivds_1.RowsCopy(1, ivo_Sort.ivds_1.RowCount(), Primary!, dw_1, 1, Primary!)
ivo_Sort.ivds_2.RowsCopy(1, ivo_Sort.ivds_2.RowCount(), Primary!, dw_2, 1, Primary!)

If Not wf_Carrega_Classificacao_Padrao() Then Return

uo_Selecao.of_Habilita()
uo_selecao_move.of_Habilita()

dw_1.SetFocus()


end event

type pb_help from dc_w_response`pb_help within dc_w_sort_dw
integer x = 23
integer y = 1152
end type

event pb_help::clicked;call super::clicked;If gvo_aplicacao.ivo_Seguranca.Cd_Sistema = 'RL' Then
	wf_Help( "barra_menu_classificar" )
End If
end event

type gb_2 from groupbox within dc_w_sort_dw
integer x = 1568
integer y = 8
integer width = 1883
integer height = 1132
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Selecionada"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within dc_w_sort_dw
integer x = 18
integer y = 8
integer width = 1358
integer height = 1132
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dispon$$HEX1$$ed00$$ENDHEX$$vel"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within dc_w_sort_dw
integer x = 50
integer y = 60
integer width = 1303
integer height = 1056
integer taborder = 30
boolean bringtotop = true
string dataobject = "dc_dw_sort_disponivel"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;uo_Selecao.ivs_Find = "coluna = '" + This.Object.Coluna[CurrentRow] + "'"
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type dw_2 from dc_uo_dw_base within dc_w_sort_dw
integer x = 1600
integer y = 60
integer width = 1829
integer height = 1060
integer taborder = 40
boolean bringtotop = true
string dataobject = "dc_dw_sort_aplicado"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection("", "if(bloqueio = ~"S~", rgb(255,0,0), rgb(0,0,0))")
end event

event ue_addrow;call super::ue_addrow;uo_selecao_move.of_Habilita()

Return AncestorReturnValue
end event

type uo_selecao from dc_uo_barra_selecao_vertical within dc_w_sort_dw
integer x = 1403
integer y = 120
integer taborder = 50
boolean bringtotop = true
boolean border = false
long backcolor = 79741120
end type

on uo_selecao.destroy
call dc_uo_barra_selecao_vertical::destroy
end on

event constructor;call super::constructor;This.idw_Origem 	= dw_1
This.idw_Destino	= dw_2
end event

event ue_permite_deselecionar;// Override

String lvs_Coluna, &
       lvs_Bloqueio

lvs_Coluna   = idw_Destino.Object.Nome    [ai_Linha]
lvs_Bloqueio = idw_Destino.Object.Bloqueio[ai_Linha]

If lvs_Bloqueio = "S" Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A coluna '" + Upper(lvs_Coluna) + "' n$$HEX1$$e300$$ENDHEX$$o pode ser retirada da classifica$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Return False
End If

Return True

end event

type cb_ok from commandbutton within dc_w_sort_dw
integer x = 2697
integer y = 1160
integer width = 366
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
boolean default = true
end type

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

event clicked;If Not wf_Grava_Classificacao_Padrao() Then Return -1

ivo_Sort.ivds_2.Reset()

dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, ivo_Sort.ivds_2, 1, Primary!)

CloseWithReturn(Parent, "S")
end event

type cb_cancelar from commandbutton within dc_w_sort_dw
integer x = 3086
integer y = 1160
integer width = 366
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

event clicked;gvo_Aplicacao.ivs_Procedimento_Sistema = ""

CloseWithReturn(Parent, "N")
end event

type uo_selecao_move from dc_uo_barra_selecao within dc_w_sort_dw
integer x = 3470
integer y = 120
integer taborder = 40
boolean bringtotop = true
end type

on uo_selecao_move.destroy
call dc_uo_barra_selecao::destroy
end on

event constructor;call super::constructor;This.idw = dw_2
end event

