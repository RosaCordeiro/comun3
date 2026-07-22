HA$PBExportHeader$w_ge322_cadastro_reforco.srw
forward
global type w_ge322_cadastro_reforco from dc_w_selecao_lista_relatorio
end type
type pb_1 from picturebutton within w_ge322_cadastro_reforco
end type
type pb_3 from picturebutton within w_ge322_cadastro_reforco
end type
type cb_marcar_todos from commandbutton within w_ge322_cadastro_reforco
end type
type cb_1 from commandbutton within w_ge322_cadastro_reforco
end type
end forward

global type w_ge322_cadastro_reforco from dc_w_selecao_lista_relatorio
integer width = 3493
integer height = 1896
string title = "GE322 - Cadastro de Refor$$HEX1$$e700$$ENDHEX$$o"
pb_1 pb_1
pb_3 pb_3
cb_marcar_todos cb_marcar_todos
cb_1 cb_1
end type
global w_ge322_cadastro_reforco w_ge322_cadastro_reforco

type variables
String is_filiais, is_nulo

uo_ge216_filiais io_Filiais
end variables

on w_ge322_cadastro_reforco.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_3=create pb_3
this.cb_marcar_todos=create cb_marcar_todos
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_3
this.Control[iCurrent+3]=this.cb_marcar_todos
this.Control[iCurrent+4]=this.cb_1
end on

on w_ge322_cadastro_reforco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_3)
destroy(this.cb_marcar_todos)
destroy(this.cb_1)
end on

event close;call super::close;Destroy io_Filiais
end event

event ue_postopen;call super::ue_postopen;Date ldh_Parametro

io_Filiais = Create uo_ge216_filiais

ldh_Parametro = Date( gf_GetServerDate() )

dw_1.Object.dh_pedido [ 1 ] = ldh_Parametro
//dw_1.Object.dh_termino [ 1 ] = ldh_Parametro
//dw_1.Object.dh_inicio	[ 1 ] = RelativeDate( ldh_Parametro, -5 )

SetNull( is_nulo )
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge322_cadastro_reforco
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge322_cadastro_reforco
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge322_cadastro_reforco
integer x = 23
integer y = 368
integer width = 3392
integer height = 1200
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge322_cadastro_reforco
integer x = 23
integer width = 1989
integer height = 340
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge322_cadastro_reforco
integer x = 59
integer width = 1938
string dataobject = "dw_ge322_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long ll_Lojas

Choose Case dwo.Name
	Case "id_filiais"

		If Data = 'C' Then
				
			is_filiais = is_nulo 
			
			OpenWithParm( w_ge216_selecao_filiais, io_Filiais )
			
			ll_Lojas = Message.DoubleParm
			
			If ll_Lojas > 0 Then is_filiais = io_Filiais.ivs_filiais	
			
		Else
			is_filiais = is_nulo 
		End If
		
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge322_cadastro_reforco
integer x = 64
integer y = 432
integer width = 3323
integer height = 1112
string dataobject = "dw_ge322_lista"
end type

event dw_2::ue_recuperar;//Over
String ls_Tipo, ls_Curva, ls_Grupo

Date ldh_Pedido
//ldh_Inicio, ldh_Termino

dw_1.AcceptText()

//ldh_Inicio	 = dw_1.Object.dh_Inicio 		[ 1 ]
//ldh_Termino = dw_1.Object.dh_Termino 	[ 1 ]
ldh_Pedido	 = dw_1.Object.dh_pedido	 	[ 1 ]
ls_Tipo		 = dw_1.Object.id_Tipo			[ 1 ]
ls_Curva		 =	dw_1.Object.id_curva			[ 1 ] 
ls_Grupo		 = dw_1.Object.id_grupo			[ 1 ] 

If IsNull(ldh_Pedido) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data do pedido.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

//If IsNull( ldh_Inicio ) Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
//	dw_1.Event ue_Pos(1, "dh_inicio")
//	Return -1
//End If
//
//If IsNull( ldh_Termino ) Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
//	dw_1.Event ue_Pos(1, "dh_termino")
//	Return -1
//End If

//If ls_Grupo <> 'T' Then This.of_AppendWhere_subQuery("x.cd_grupo = '" + ls_Grupo + "'", 3 )
If ls_Grupo <> 'T' Then This.of_AppendWhere("x.cd_grupo = '" + ls_Grupo + "'")

//If ls_Curva <> 'T' Then This.of_AppendWhere_subQuery("x.cd_curva = '" + ls_Curva + "'", 3 )
If ls_Curva <> 'T' Then This.of_AppendWhere("x.cd_curva = '" + ls_Curva + "'")

If Not IsNull(is_Filiais) And is_Filiais <> '' Then
	//This.of_AppendWhere_subQuery("x.cd_filial in ( " + is_filiais + " )", 3 )
	This.of_AppendWhere("x.cd_filial in ( " + is_filiais + " )")
End If

If ls_Tipo <> 'T' Then
	This.of_AppendWhere("x.id_tipo_reforco = '" +  ls_Tipo + "'")
End If

Return This.Retrieve( ldh_Pedido)

end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge322_cadastro_reforco
integer x = 2249
integer y = 24
integer width = 210
integer height = 108
end type

type pb_1 from picturebutton within w_ge322_cadastro_reforco
integer x = 3035
integer y = 1584
integer width = 375
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_incluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String 	ls_Retorno

openWithParm(  w_ge322_incluir_reforco, is_filiais )

ls_Retorno = Message.StringParm

If ls_Retorno = 'S' Then dw_2.Event ue_Retrieve()


end event

type pb_3 from picturebutton within w_ge322_cadastro_reforco
integer x = 2629
integer y = 1588
integer width = 375
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_excluir.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_excluir_desabilitado.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Boolean lb_Sucesso

Long 	i,&
		ll_Filial,&
		ll_Linhas,&
		ll_Reforco

String 	ls_Tipo,&
			ls_Grupo,&
			ls_Curva,&
			ls_Matricula,&
			ls_Erro,&
			ls_chave,&
			ls_Dias_Reforco

DateTime 	ldh_Inicio,&
				ldh_Termino

ll_Linhas =  dw_2.RowCount()

If dw_2.Find( "id_marcado = 'S'", 1, ll_Linhas ) <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum registro foi selecionado.")
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma a exclus$$HEX1$$e300$$ENDHEX$$o dos registros selecionados ?", Question!, yesNo!, 2) = 2 Then Return

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE322_EXCLUIR_REFORCO", ref ls_Matricula) Then Return

Open(w_Aguarde)

w_Aguarde.Title = 'Excluindo os refor$$HEX1$$e700$$ENDHEX$$os ...'

For i = 1 To ll_Linhas
	
	If dw_2.Object.id_marcado	[ i ] = 'N' Then Continue

	lb_Sucesso = False
	
	//ls_Tipo 			= dw_2.Object.id_tipo			[ i ]
	ll_Filial				= dw_2.Object.cd_filial			[ i ]
	ls_grupo				= dw_2.Object.cd_grupo			[ i ]
	ls_curva				= dw_2.Object.cd_curva			[ i ]
	ldh_Inicio			= dw_2.Object.dh_inicio			[ i ]
	ldh_Termino 		= dw_2.Object.dh_termino		[ i ]
	ls_Tipo				= dw_2.Object.id_tipo_reforco	[ i ]
	ll_Reforco			= dw_2.Object.nr_reforco		[ i ]
	ls_Dias_Reforco	= String(dw_2.Object.qt_dias_reforco	[ i ])
	
	delete pedido_filial_reforco
	where nr_reforco = :ll_Reforco
	Using SqlCa;
		
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o registro. " + ls_Erro, StopSign!)
		lb_Sucesso = False
		Exit
	End If
	
	//---------------Grava hist$$HEX1$$f300$$ENDHEX$$rico da exclus$$HEX1$$e300$$ENDHEX$$o------------------------
	ls_chave = String(ll_Filial)+"@#!"+ls_grupo+"@#!"+ls_curva+"@#!"+ls_Tipo
	
	Insert Into historico_alteracao_tabela(nm_tabela,&
													de_chave,&
													nm_coluna,&
													de_alteracao_de,&
													nr_matric_alteracao,&
													id_alteracao)
	Values (	"PEDIDO_FILIAL_REFORCO",&
				:ls_chave,&
				"QT_DIAS_REFORCO",&
				:ls_Dias_Reforco,&
				:ls_Matricula,&
				"E")
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es. " + ls_Erro, StopSign!)
		lb_Sucesso = False
		Exit
	End If
     //-----------------------------------------------------------------------
	
	//OK
	lb_Sucesso = True
	
Next

If lb_Sucesso Then 
	SqlCa.of_Commit()
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Registros exclu$$HEX1$$ed00$$ENDHEX$$dos com sucesso.")
End If

Close(w_Aguarde)

dw_2.Event ue_Retrieve()

end event

type cb_marcar_todos from commandbutton within w_ge322_cadastro_reforco
integer x = 23
integer y = 1584
integer width = 530
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Marcar Todas"
end type

event clicked;String ls_Selecao
Long i

If dw_2.RowCount() = 0 Then Return

If This.Text = "&Marcar Todas" Then
	This.Text = "&Desmarcar Todas"
	ls_Selecao = "S"
Else
	This.Text = "&Marcar Todas"
	ls_Selecao = "N"
End If

For i = 1 To dw_2.RowCount()
	dw_2.Object.id_marcado[ i ] = ls_Selecao
Next
end event

type cb_1 from commandbutton within w_ge322_cadastro_reforco
boolean visible = false
integer x = 617
integer y = 1592
integer width = 974
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Todos os Refor$$HEX1$$e700$$ENDHEX$$os (revisar)"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Todos os refor$$HEX1$$e700$$ENDHEX$$os ser$$HEX1$$e300$$ENDHEX$$o excluidos. Deseja continuar mesmo assim ?",Question!,YesNo!,2)=2 Then Return

Delete pedido_filial_reforco_perini
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Erro ao excluir todos os refor$$HEX1$$e700$$ENDHEX$$os.")
Else
	SqlCa.of_Commit();
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Todos os refor$$HEX1$$e700$$ENDHEX$$os foram excluidos.")
End If

end event

