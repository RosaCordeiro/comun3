HA$PBExportHeader$w_ge322_incluir_reforco.srw
forward
global type w_ge322_incluir_reforco from dc_w_response_ok_cancela
end type
type pb_1 from picturebutton within w_ge322_incluir_reforco
end type
type pb_2 from picturebutton within w_ge322_incluir_reforco
end type
end forward

global type w_ge322_incluir_reforco from dc_w_response_ok_cancela
integer width = 2226
integer height = 624
string title = "GE322 - Cadastro Refor$$HEX1$$e700$$ENDHEX$$o Pedido"
pb_1 pb_1
pb_2 pb_2
end type
global w_ge322_incluir_reforco w_ge322_incluir_reforco

type variables
uo_ge216_filiais io_Filiais

String 	is_filiais,&
			is_nulo,&
			is_Responsavel
end variables

on w_ge322_incluir_reforco.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
end on

on w_ge322_incluir_reforco.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_2)
end on

event ue_postopen;call super::ue_postopen;Date ldh_Parametro

io_Filiais = Create uo_ge216_filiais
 
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE322_INCLUIR_REFORCO", ref is_Responsavel) Then
	Close(This)
	Return
End If


SetNull( is_nulo )

ldh_Parametro = Date( gf_getServerDate() )

dw_1.Object.dh_inicio 	[ 1 ] = ldh_Parametro
dw_1.Object.dh_termino	[ 1 ] = ldh_Parametro 
end event

event close;call super::close;Destroy io_Filiais
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge322_incluir_reforco
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge322_incluir_reforco
integer width = 2167
integer height = 396
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge322_incluir_reforco
integer y = 104
integer width = 2103
integer height = 248
string dataobject = "dw_ge322_incluir_reforco"
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

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge322_incluir_reforco
boolean visible = false
integer x = 37
integer y = 580
boolean enabled = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge322_incluir_reforco
boolean visible = false
integer x = 370
integer y = 580
boolean enabled = false
end type

type pb_1 from picturebutton within w_ge322_incluir_reforco
integer x = 1751
integer y = 416
integer width = 439
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_cancelar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type pb_2 from picturebutton within w_ge322_incluir_reforco
integer x = 1271
integer y = 416
integer width = 462
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Boolean lb_Sucesso

Date ldt_Inicio, ldt_Termino, ldt_Parametro
Long ll_Row, ll_Filiais, ll_Filial, ll_Cont
String ls_Grupo, ls_MSG, ls_tipo, ls_Curva, ls_Aux, ls_NOVO_CALCULO_EB, ls_UF
Integer li_Dias, li_Curvas, li_Row_Curva, li_Row_Grupo, li_Grupos

dw_1.AcceptText()

ldt_Inicio			= dw_1.Object.dh_inicio		[ 1 ]
ldt_Termino 	= dw_1.Object.dh_termino	[ 1 ]
ls_tipo			= dw_1.Object.id_Tipo		[ 1 ]
ls_Curva			= dw_1.Object.id_curva		[ 1 ]
li_Dias			= dw_1.Object.id_dias		[ 1 ]
ls_Grupo			= dw_1.Object.id_grupo		[ 1 ]

If IsNull(ldt_Inicio) Or IsNull(ldt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o per$$HEX1$$ed00$$ENDHEX$$odo corretamente.")
	Return 
End If

If ldt_Inicio < Date(gf_getServerDate() ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data de hoje.")
	Return 
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, 'dh_inicio')
	Return 
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a inclus$$HEX1$$e300$$ENDHEX$$o do refor$$HEX1$$e700$$ENDHEX$$o no pedido ?", Question!, YesNo!, 2) = 2 Then Return

ldt_Parametro = Date(gf_getServerDate() )

TRY
	
	Open(w_Aguarde)
	
	dc_uo_ds_base lds
	dc_uo_ds_base lds_Grupo
	
	lds 			= Create dc_uo_ds_base
	lds_Grupo 	= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("dw_ge322_lista_filial") Then Return
	If Not lds_Grupo.of_ChangeDataObject("ddw_grupo") Then	Return
	
	//lds.of_AppendWhere( "filial.id_pedido_centralizado = 'S' and filial.id_situacao = 'A'")
	
	If Not IsNull( is_filiais ) And is_filiais <> '' Then  lds.of_AppendWhere( "f.cd_filial in ( " + is_filiais + " )" )
	
	If ls_Grupo = 'T' Then
		lds_Grupo.of_AppendWhere("grupo.cd_grupo in ( '1','2','3' )")
	Else
		lds_Grupo.of_AppendWhere("grupo.cd_grupo = '" + ls_Grupo + "'") 
	End If
	
	li_Grupos		 		= lds_Grupo.Retrieve()
	ll_Filiais	  			= lds.Retrieve()
	
	If li_Grupos < 0 Then
		ls_msg = "Erro no Retrieve ddw_grupo."
		Return
	End If
	
	If ll_Filiais < 0 Then
		ls_msg = "Erro no Retrieve filiais."
		Return
	End If
	
	li_Curvas				= LenA( ls_Curva )
	
	w_Aguarde.Title = 'Inserindo refor$$HEX1$$e700$$ENDHEX$$o, aguarde...'
	w_Aguarde.uo_progress.of_SetMax( ll_Filiais )
	
	ll_Cont = 0
	
	For ll_Row = 1 To ll_Filiais
		w_Aguarde.uo_progress.of_SetProgress( ll_Row )

		ll_Filial		= lds.Object.cd_filial[ ll_Row ]
		ls_UF 			= lds.Object.cd_unidade_federacao[ ll_Row ]
				
//		// Libera temporariamente o bloqueio para as lojas que est$$HEX1$$e300$$ENDHEX$$o no novo calculo do EB.
//		If ldt_Parametro > Date("31/03/2017") Then
//			If Not gf_utiliza_novo_calculo_eb(ll_Filial, ref ls_NOVO_CALCULO_EB) Then
//				SqlCa.of_Rollback()
//				Return
//			End If 
//		Else
//			ls_NOVO_CALCULO_EB = 'N'
//		End If
//		
//		If ls_NOVO_CALCULO_EB = 'S' Then Continue
		
		lb_Sucesso 	= False
				
		For li_Row_Grupo = 1 To li_Grupos
			
			ls_Grupo = lds_Grupo.Object.cd_grupo[ li_Row_Grupo ]
			
			ls_Aux = ls_Curva
			
			For li_Row_Curva = 1 To li_Curvas
				
				ls_Aux = Mid( ls_Curva, li_Row_Curva, 1 )
				
//				If ls_Aux = 'E' and ls_UF <> 'BA' Then
//					
//					If ll_Cont = 0 Then
//						ll_Cont ++
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a inclus$$HEX1$$e300$$ENDHEX$$o de refor$$HEX1$$e700$$ENDHEX$$o na curva E para as lojas diferentes da UF BA.")
//					End If
//					
//					//OK
//					lb_Sucesso = True
//					Continue
//				End If				
									
				INSERT INTO pedido_filial_reforco  ( dh_inicio, dh_termino, cd_filial, cd_grupo, cd_curva, qt_dias_reforco, id_tipo_reforco, nr_matricula_responsavel )  
				values ( :ldt_Inicio, :ldt_termino, :ll_Filial, :ls_Grupo, :ls_Aux, :li_Dias, :ls_tipo, :is_Responsavel)
				Using SqlCa;				
				
				If SqlCa.Sqlcode = -1 Then
					ls_Msg = "Erro ao inserir o refor$$HEX1$$e700$$ENDHEX$$o do pedido. " + SqlCa.SQLErrText
					lb_Sucesso = False
					Exit
				End If
				
				//OK
				lb_Sucesso = True
				
			Next
			
			If Not lb_Sucesso Then Exit
		
		Next
		
		If Not lb_Sucesso Then Exit
		
	Next
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
		ls_Msg = "Refor$$HEX1$$e700$$ENDHEX$$o cadastrado com sucesso."
		
		CloseWithReturn(Parent, "S")
	Else
		SqlCa.of_Rollback()
	End If
		
FINALLY
	If IsValid( lds ) Then Destroy lds
	If IsValid( lds_Grupo ) Then Destroy lds_Grupo
	
	Close(w_Aguarde)
	
	If Not IsNull(ls_Msg) And ls_Msg <> '' Then messageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Msg )
	
END TRY


end event

