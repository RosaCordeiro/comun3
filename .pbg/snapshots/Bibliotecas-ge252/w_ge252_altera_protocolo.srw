HA$PBExportHeader$w_ge252_altera_protocolo.srw
forward
global type w_ge252_altera_protocolo from dc_w_base
end type
type dw_1 from dc_uo_dw_base within w_ge252_altera_protocolo
end type
type cb_2 from commandbutton within w_ge252_altera_protocolo
end type
type cb_1 from commandbutton within w_ge252_altera_protocolo
end type
type gb_1 from groupbox within w_ge252_altera_protocolo
end type
end forward

global type w_ge252_altera_protocolo from dc_w_base
string tag = "GE252 - Alterar Protocolo Defeito de F$$HEX1$$e100$$ENDHEX$$brica"
integer width = 2555
integer height = 936
string title = "GE252 - Alterar Protocolo Defeito de F$$HEX1$$e100$$ENDHEX$$brica"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_ge252_altera_protocolo w_ge252_altera_protocolo

type variables
String 	is_Endereco,&
			is_Lote,&
			is_Agrupamento
			
Long 	ll_NrMotivo_Atual,&		
		il_Agrupamento

st_parametros_protocolo ist_parametros_protocolo
end variables

on w_ge252_altera_protocolo.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge252_altera_protocolo.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;call super::open;ist_parametros_protocolo = Message.PowerObjectParm	

dw_1.settransobject(sqlca)
dw_1.retrieve(ist_parametros_protocolo.cd_filial_origem, ist_parametros_protocolo.nr_nf, ist_parametros_protocolo.de_especie, ist_parametros_protocolo.de_serie)
end event

type dw_1 from dc_uo_dw_base within w_ge252_altera_protocolo
integer x = 69
integer y = 40
integer width = 2423
integer height = 660
string dataobject = "dw_ge252_lista_protocolo_update"
end type

type cb_2 from commandbutton within w_ge252_altera_protocolo
integer x = 1833
integer y = 732
integer width = 338
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;long  ll_motivo,&
	   ll_motivo_old,&
		ll_linha,&
		ll_linhas,&
		ll_qtd_utilizado,&
		ll_produto
			 
String ls_Erro,&
		 ls_lote,&
		 ls_protocolo,&
		 ls_protocolo_old

dw_1.AcceptText()

ll_linhas = dw_1.rowcount()

If ll_linha > 0 then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma Altera$$HEX2$$e700e300$$ENDHEX$$o do Protocolo/Defeito?", Question!, YesNo!, 2) = 2 Then
		dw_1.Event ue_Pos(1,"nr_protocolo")
		Return 1			
	End If
End if

For ll_linha = 1 to ll_linhas
	
	ll_produto = dw_1.object.cd_produto[ll_linha]
	ls_lote = dw_1.object.nr_lote[ll_linha]
	ls_protocolo = dw_1.object.nr_protocolo[ll_linha]
	ll_motivo = dw_1.object.cd_motivo_defeito[ll_linha]
	ls_protocolo_old = dw_1.object.protocolo_old[ll_linha]
	ll_motivo_old = dw_1.object.defeito_old[ll_linha]
	ll_qtd_utilizado = dw_1.object.qt_utilizado[ll_linha]
	
	If ll_qtd_utilizado > 0 Then Continue

	If IsNull(ls_protocolo) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o Numero do Protocolo!", Information!)
		dw_1.Event ue_Pos(1, "nr_protocolo")
		Return 1
	End If
	
	If IsNull(ll_motivo) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o Motivo para o Protocolo!", Information!)
		dw_1.Event ue_Pos(1, "cd_motivo_defeito")
		Return 1
	End If
	
    Update item_nf_transferencia_lote_prt
    Set nr_protocolo_defeito = :ls_protocolo, cd_motivo_defeito = :ll_motivo
    Where cd_filial_origem = :ist_parametros_protocolo.cd_filial_origem
    And nr_nf = :ist_parametros_protocolo.nr_nf
    And de_especie = :ist_parametros_protocolo.de_especie
    And de_serie = :ist_parametros_protocolo.de_serie
      //AND cd_natureza_operacao = :ist_parametros_protocolo.cd_natureza_operacao
    And cd_produto = :ll_produto
    And nr_lote = :ls_lote
    And nr_protocolo_defeito = :ls_protocolo_old
	And cd_motivo_defeito = :ll_motivo_old
	USING SqlCA;

	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", "Erro ao atualizar a tabela item_nf_transferencia_lote: " + ls_Erro)		
		Return 1
	End If 
	 
	// Atualizar Registro : Tabela wms_protocolo
	Update wms_protocolo
		Set nr_protocolo 	=:ls_protocolo , cd_motivo_defeito =:ll_motivo
	Where cd_produto	= :ll_produto
	And  nr_lote =:ls_lote
	And nr_protocolo = :ls_protocolo_old
	And cd_motivo_defeito = :ll_motivo_old
	And qt_utilizado = 0
	Using SqlCA;
		
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", "Erro ao atualizar Numero e Motivo do Protocolo no Agrupamento: " + ls_Erro)		
		Return 1
	End If 
Next

SqlCa.of_Commit()

CloseWithReturn(Parent, "S")
end event

type cb_1 from commandbutton within w_ge252_altera_protocolo
integer x = 2181
integer y = 732
integer width = 338
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;Close(Parent)
end event

type gb_1 from groupbox within w_ge252_altera_protocolo
integer x = 23
integer width = 2491
integer height = 720
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

