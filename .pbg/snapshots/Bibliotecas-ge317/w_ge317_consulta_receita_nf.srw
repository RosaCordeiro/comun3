HA$PBExportHeader$w_ge317_consulta_receita_nf.srw
forward
global type w_ge317_consulta_receita_nf from dc_w_response_ok_cancela
end type
type cb_insert from commandbutton within w_ge317_consulta_receita_nf
end type
type cb_delete from commandbutton within w_ge317_consulta_receita_nf
end type
end forward

global type w_ge317_consulta_receita_nf from dc_w_response_ok_cancela
integer width = 1605
integer height = 1108
string title = "CR317 - Consulta Receita NF"
cb_insert cb_insert
cb_delete cb_delete
end type
global w_ge317_consulta_receita_nf w_ge317_consulta_receita_nf

type variables
String	ivs_Especie, &
		ivs_Serie
		
Long 	ivl_Cd_Filial, &
		ivl_Nr_Nf
	
Datetime ivdh_Movto
		
Boolean ivb_Inserir = False
end variables

on w_ge317_consulta_receita_nf.create
int iCurrent
call super::create
this.cb_insert=create cb_insert
this.cb_delete=create cb_delete
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_insert
this.Control[iCurrent+2]=this.cb_delete
end on

on w_ge317_consulta_receita_nf.destroy
call super::destroy
destroy(this.cb_insert)
destroy(this.cb_delete)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
dw_1.of_set_somente_leitura( ivb_Inserir )

If ivb_Inserir Then  
	dw_1.Event ue_AddRow()
End if
end event

event ue_preopen;call super::ue_preopen;String lvs_Parm

lvs_Parm = Message.StringParm

ivl_Cd_Filial 	= Long(MidA(lvs_Parm, 1, 4))
ivl_Nr_Nf		= Long(MidA(lvs_Parm, 5,8))
ivs_Especie 	= Trim(MidA(lvs_Parm, 13,3))
ivs_Serie		= Trim(MidA(lvs_Parm, 16,3))

ivb_Inserir = (Trim(MidA(lvs_Parm, 19,1)) = 'S')

cb_insert.Visible	= ivb_Inserir
cb_delete.Visible	= ivb_Inserir

select dh_movimentacao_caixa
Into :ivdh_Movto
From nf_venda
Where cd_filial = :ivl_Cd_Filial
	And nr_nf = :ivl_Nr_Nf
	And de_especie = :ivs_Especie
	And de_serie = :ivs_Serie
Using SQLCa;
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge317_consulta_receita_nf
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge317_consulta_receita_nf
integer width = 1541
integer height = 856
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge317_consulta_receita_nf
integer width = 1390
integer height = 764
string dataobject = "dw_ge317_lista_receita_nf"
end type

event dw_1::ue_recuperar;// OverRide
Return This.Retrieve(ivl_Cd_Filial, ivl_Nr_Nf, ivs_Especie, ivs_Serie)
end event

event dw_1::ue_addrow;call super::ue_addrow;Long lvl_Linha

If AncestorReturnValue > 0 Then 
	lvl_Linha = This.GetRow()
	This.Object.cd_filial					[ lvl_Linha ] = ivl_cd_filial
	This.Object.nr_nf						[ lvl_Linha ] = ivl_nr_nf
	This.Object.de_serie					[ lvl_Linha ] = ivs_serie
	This.Object.de_especie				[ lvl_Linha ] = ivs_especie
	This.Object.id_situacao				[ lvl_Linha ] = 'R'
	This.Object.id_registro_prescritor	[ lvl_Linha ] = 'M'
	This.Object.cd_uf_prescritor		[ lvl_Linha ] = gf_uf_filial(ivl_cd_filial)
	This.Object.dh_receita				[ lvl_Linha ] = ivdh_Movto

	This.Post Event ue_Pos(lvl_Linha, "nr_registro_prescritor")
End If

cb_delete.Enabled = (This.RowCount() > 0)

Return AncestorReturnValue
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;// N$$HEX1$$e300$$ENDHEX$$o deixa inserir mais que uma linha em branco
If This.RowCount() > 0 Then
	If IsNull(This.Object.nr_registro_prescritor [This.RowCount()] ) Then
		Return 0
	End If
End If

Return AncestorReturnValue
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long lvl_Linha
Long lvl_Receita

String lvs_Prescritor
String lvs_Uf
String lvs_Tipo_Prescritor

Datetime lvdh_Receita

This.Accepttext( )

For lvl_Linha = This.RowCount() To 1 Step -1
	lvl_Receita			= This.Object.nr_receita 				[lvl_Linha]
	lvs_Prescritor		= This.Object.nr_registro_prescritor	[lvl_Linha]
	lvs_Uf					= This.Object.cd_uf_prescritor 			[lvl_Linha]
	lvs_Tipo_Prescritor= This.Object.id_registro_prescritor	[lvl_Linha]
	lvdh_Receita		= This.Object.dh_receita					[lvl_Linha]
	
	If IsNull(lvdh_Receita) or (lvdh_Receita <= Datetime("2000/01/01")) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Informe a data da emiss$$HEX1$$e300$$ENDHEX$$o da receita.")
		This.Event ue_Pos(lvl_Linha, 'dh_receita')
		Return -1
	End If
	
	If IsNull(lvs_Prescritor) or (lvs_Prescritor="") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Informe o prescritor da receita.")
		This.Event ue_Pos(lvl_Linha, 'nr_registro_prescritor')
		Return -1
	End If
	
	If IsNull(lvl_Receita) or (lvl_Receita = 0) Then
		//O n$$HEX1$$fa00$$ENDHEX$$mero receita $$HEX1$$e900$$ENDHEX$$ sequencial e comp$$HEX1$$f500$$ENDHEX$$e a PK
		select max(nr_receita) 
		Into :lvl_Receita
		From receita
		Where cd_filial = :ivl_Cd_Filial
			And nr_receita >= 5000000
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$fa00$$ENDHEX$$mero receita" )
			Return -1
		End If
		
		If IsNull(lvl_Receita) or (lvl_Receita = 0) Then lvl_Receita = 4999999
		
		This.Object.nr_receita [lvl_Linha] = lvl_Receita + 1
	End If
Next 

Return AncestorReturnValue
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge317_consulta_receita_nf
integer x = 919
integer y = 888
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

If ivb_Inserir Then 
	If dw_1.Event ue_update() <= 0 Then
		SQLCa.Of_RollBack( )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel inserir a receita.",Exclamation!)
		Return -1
	Else
		SQLCa.Of_Commit( )
	End If
End If

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge317_consulta_receita_nf
integer x = 1253
integer y = 888
end type

type cb_insert from commandbutton within w_ge317_consulta_receita_nf
integer x = 1408
integer y = 164
integer width = 119
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "+"
end type

event clicked;dw_1.Event ue_AddRow()
dw_1.SetFocus()
end event

type cb_delete from commandbutton within w_ge317_consulta_receita_nf
integer x = 1408
integer y = 260
integer width = 119
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "-"
end type

event clicked;dw_1.Event ue_DeleteRow()
cb_delete.Enabled = (dw_1.RowCount() > 0)
end event

