HA$PBExportHeader$w_ge318_consulta_conciliacao_pbm.srw
forward
global type w_ge318_consulta_conciliacao_pbm from dc_w_selecao_lista_detalhe
end type
type pb_1 from picturebutton within w_ge318_consulta_conciliacao_pbm
end type
type pb_2 from picturebutton within w_ge318_consulta_conciliacao_pbm
end type
end forward

global type w_ge318_consulta_conciliacao_pbm from dc_w_selecao_lista_detalhe
string tag = "w_ge318_consulta_conciliacao_pbm"
string accessiblename = "w_ge318_consulta_conciliacao_pbm"
integer width = 4119
integer height = 2828
string title = "GE318 - Concilia$$HEX2$$e700e300$$ENDHEX$$o PBM"
pb_1 pb_1
pb_2 pb_2
end type
global w_ge318_consulta_conciliacao_pbm w_ge318_consulta_conciliacao_pbm

type variables
uo_ge318_cliente_benef_epharma ivo_beneficio_epharma 
end variables

forward prototypes
public subroutine wf_localiza_cliente_epharma ()
end prototypes

public subroutine wf_localiza_cliente_epharma ();String lvs_Cliente

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Cliente = dw_1.GetText()
	
ivo_beneficio_epharma.of_Localiza_Cliente(lvs_Cliente)

If ivo_beneficio_epharma.Localizado Then
	dw_1.Object.Cd_Cliente[1] 	= ivo_beneficio_epharma.Cd_Cliente
  	dw_1.Object.Nm_Cliente[1] = ivo_beneficio_epharma.Nm_Cliente
Else

	SetNull(ivo_beneficio_epharma.Cd_Cliente)
	ivo_beneficio_epharma.Nm_Cliente = ""
	
	dw_1.Object.Cd_Cliente[1] 	= ivo_beneficio_epharma.Cd_Cliente
  	dw_1.Object.Nm_Cliente[1] = ivo_beneficio_epharma.Nm_Cliente
End If


end subroutine

on w_ge318_consulta_conciliacao_pbm.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
end on

on w_ge318_consulta_conciliacao_pbm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
end on

event close;call super::close;Destroy(ivo_beneficio_epharma)
end event

event ue_postopen;call super::ue_postopen;Integer lvi_Dia, &
		lvi_Mes, &
		lvi_Ano
		
ivo_beneficio_epharma = Create uo_ge318_cliente_benef_epharma 

lvi_Dia 		= Day(Today())
lvi_Mes 	= Month(Today())
lvi_Ano 	= Year(Today())

If lvi_Dia <= 5 Then
	dw_1.Object.Nr_Dia_Fechamento[1] = 5
End If

If lvi_Dia > 5 and lvi_Dia < 22 Then
	dw_1.Object.Nr_Dia_Fechamento[1] = 22
End If

If lvi_Dia > 22 Then
	dw_1.Object.Nr_Dia_Fechamento[1] = 30
End If

dw_1.Object.Nr_Mes_Fechamento[1] = String(lvi_Mes)
dw_1.Object.Nr_Ano_Fechamento[1] = String(lvi_Ano)
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge318_consulta_conciliacao_pbm
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge318_consulta_conciliacao_pbm
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge318_consulta_conciliacao_pbm
integer x = 27
integer y = 2320
integer width = 4027
integer height = 308
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge318_consulta_conciliacao_pbm
integer x = 27
integer y = 8
integer width = 4023
integer height = 404
integer weight = 700
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge318_consulta_conciliacao_pbm
integer x = 27
integer y = 504
integer width = 4023
integer height = 1804
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge318_consulta_conciliacao_pbm
integer x = 46
integer y = 64
integer width = 3986
integer height = 336
string dataobject = "dw_ge318_selecao"
end type

event dw_1::getfocus;call super::getfocus;This.ivm_Menu.mf_SalvarComo(False)

end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nm_cliente"
		If data <> "" Then
			Return 1
		Else
			
			SetNull(ivo_beneficio_epharma.Cd_Cliente)
			ivo_beneficio_epharma.nm_cliente = ""
			
			This.Object.Cd_Cliente[1] 	= ivo_beneficio_epharma.Cd_Cliente
			This.Object.Nm_Cliente[1] 	= ivo_beneficio_epharma.Nm_Cliente			
		End If	
	Case "cd_convenio"
		If data = "52718" Then
			This.Modify("cliente_t.Visible=1")
			This.Modify("nm_cliente.Visible=1")
			This.Modify("nm_cliente.Visible=1")
			This.Modify("cd_cliente.Visible=1")
			This.Modify("id_apuracao_t.Visible=1")
			This.Modify("dia_t.Visible=1")
			This.Modify("nr_dia_fechamento.Visible=1")
			This.Modify("mes_t.Visible=1")
			This.Modify("nr_mes_fechamento.Visible=1")
			This.Modify("ano_t.Visible=1")
			This.Modify("nr_ano_fechamento.Visible=1"	)
			
			gb_1.Width 		= 4023
			gb_1.Height 	= 404
			
			dw_1.Width 	= 3986
			dw_1.Height 	= 344
		Else
			This.Modify("cliente_t.Visible=0")
			This.Modify("nm_cliente.Visible=0")
			This.Modify("nm_cliente.Visible=0")
			This.Modify("cd_cliente.Visible=0")
			This.Modify("id_apuracao_t.Visible=0")
			This.Modify("dia_t.Visible=0")
			This.Modify("nr_dia_fechamento.Visible=0")
			This.Modify("mes_t.Visible=0")
			This.Modify("nr_mes_fechamento.Visible=0")
			This.Modify("ano_t.Visible=0")
			This.Modify("nr_ano_fechamento.Visible=0"	)
			
			gb_1.Width 		= 2098
			gb_1.Height 	= 344
			
			dw_1.Width 	= 2053
			dw_1.Height 	= 276
			
		End If		
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_beneficio_epharma) Then 
	dw_1.Object.Nm_Cliente[1] = ivo_beneficio_epharma.Nm_Cliente
End If	
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = dw_1.GetColumnName()

Choose Case lvs_Coluna
	Case "nm_cliente"
		If key = KeyEnter! Then	   	 
			Wf_Localiza_Cliente_ePharma()
		End If	
End Choose
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge318_consulta_conciliacao_pbm
integer x = 59
integer y = 580
integer width = 3959
integer height = 1696
string dataobject = "dw_ge318_nenhum"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String 	lvs_Conciliada, &
			lvs_Status, &
			lvs_Tipo_Registro, &
			lvs_Agrupar, &
			lvs_Id_Apuracao, &
			lvs_Cd_Cliente

Long	lvl_Convenio, &
		lvl_Linhas

Date 	lvdt_Venda_De, &
		lvdt_Venda_Ate, &
		lvdt_Fechamento
		
Integer	lvi_Nr_Dia_Fechamento, &
		lvi_Nr_Mes_Fechamento, &
		lvi_Nr_Ano_Fechamento

dw_1.AcceptText()

lvl_Convenio			= dw_1.Object.Cd_Convenio[1]
lvdt_Venda_De		= dw_1.Object.Dt_Inicio[1]
lvdt_Venda_Ate		= dw_1.Object.Dt_Termino[1]
lvs_Conciliada		= dw_1.Object.Id_Conciliado[1]
lvs_Status			= dw_1.Object.Id_Status[1]
lvs_Tipo_Registro	= dw_1.Object.Id_Tipo_Registro[1]

dw_2.Reset()
dw_3.Reset()

Choose Case lvl_Convenio 
	Case 52718 // e-Pharma

		dw_2.DataObject = "dw_ge318_lista_agrupada_epharma"
		dw_3.DataObject = "dw_ge318_lista_dw3_epharma"

		lvi_Nr_Dia_Fechamento 	= dw_1.Object.Nr_Dia_Fechamento[1]
		lvi_Nr_Mes_Fechamento	= Integer(dw_1.Object.Nr_Mes_Fechamento[1])
		lvi_Nr_Ano_Fechamento	= Integer(dw_1.Object.Nr_Ano_Fechamento[1])
		lvs_Cd_Cliente				= dw_1.Object.Cd_Cliente[1]
		lvs_Id_Apuracao			= dw_1.Object.Id_Apuracao_t[1] // P - Pagamento / V - Vendas / S - Servi$$HEX1$$e700$$ENDHEX$$os
		
		If lvs_Id_Apuracao <> 'P' Then
			lvi_Nr_dia_Fechamento = 0
		End If
		
	Case 52568 // TRN
		dw_2.DataObject = "dw_ge318_lista_agrupada_trn"		
		dw_3.DataObject = "dw_ge318_lista_dw3_padrao"
		
	Case 52575,53724,53725 // Vida Link
		dw_2.DataObject = "dw_ge318_lista_agrupada_vida_link"		
		dw_3.DataObject = "dw_ge318_lista_dw3_padrao"

	Case 52349 // Funcional Card
		dw_2.DataObject = "dw_ge318_lista_agrupada_funcional_card"		
		dw_3.DataObject = "dw_ge318_lista_dw3_padrao"
		
	Case else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Conv$$HEX1$$ea00$$ENDHEX$$nio n$$HEX1$$e300$$ENDHEX$$o preparado para consulta.", Exclamation!)
		Return -1
End Choose

dw_2.SetTransObject(SqlCa)
dw_3.SetTransObject(SqlCa)

If IsNull(lvl_Convenio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Informe o Conv$$HEX1$$ea00$$ENDHEX$$nio PBM para recupera$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es.",Exclamation!)
	dw_1.Event ue_Pos(1,"cd_convenio")
	Return -1
End If

If IsNull(lvdt_Venda_De) and lvs_Id_Apuracao <> "P"  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Informe a Data de In$$HEX1$$ed00$$ENDHEX$$cio para recupera$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es.",Exclamation!)
	dw_1.Event ue_Pos(1,"dt_inicio")	
	Return -1
End If

If IsNull(lvdt_Venda_Ate) and lvs_Id_Apuracao <> "P" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Informe a Data de T$$HEX1$$e900$$ENDHEX$$rmino para recupera$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es.",Exclamation!)
	dw_1.Event ue_Pos(1,"dt_termino")		
	Return -1
End If

// Situa$$HEX2$$e700e300$$ENDHEX$$o T = Todas
If lvs_Conciliada <> 'T' Then
	If lvs_Conciliada = 'E' Then
		This.of_AppendWhere("vpp.id_conciliada is null",1)
		This.of_AppendWhere("cpp.id_conciliada is null",2)		
	Else
		This.of_AppendWhere("vpp.id_conciliada = '" + TRIM(lvs_Conciliada) + "'",1)
		This.of_AppendWhere("cpp.id_conciliada = '" + TRIM(lvs_Conciliada) + "'",2)				
	End If
End If	

// Status "-1" Cancelada, "0" Pendente, "1" Confirmada, "2" Sondada e Pendente
If lvs_Status <> 'T' Then
	This.of_AppendWhere("cpp.id_status = '" + TRIM(lvs_Status)  + "'",1)
	This.of_AppendWhere("cpp.id_status = '" + TRIM(lvs_Status)  + "'",2)
End If	

If lvs_Tipo_Registro <> 'T' Then
	This.of_AppendWhere("cpp.id_tipo_registro = '" + TRIM(lvs_Tipo_Registro) + "'",1)
	This.of_AppendWhere("cpp.id_tipo_registro = '" + TRIM(lvs_Tipo_Registro) + "'",2)	
End If

If lvs_Cd_Cliente <> '' Then
	This.of_AppendWhere("ceb.cd_cliente = '" + lvs_Cd_Cliente  + "'",1)
	This.of_AppendWhere("ceb.cd_cliente = '" + lvs_Cd_Cliente  + "'",2)
	
	This.of_AppendWhere("ceb.cd_cliente = '" + lvs_Cd_Cliente  + "'",4)		
End if

lvdt_Fechamento = Date(String(lvi_Nr_Dia_Fechamento) + '/' + String(lvi_Nr_Mes_Fechamento) + '/' + String(lvi_Nr_Ano_Fechamento))

Choose Case lvl_Convenio 
	Case 52718 // e-Pharma
		lvl_Linhas = This.Retrieve(lvl_Convenio, lvdt_Venda_De, lvdt_Venda_Ate, lvi_Nr_dia_Fechamento, lvs_Id_Apuracao, lvi_Nr_Ano_Fechamento, lvdt_Fechamento)			
	Case 52568, 52575, 53724, 53725, 52349 // TRN / Vida Link / Funcional Card
		lvl_Linhas = This.Retrieve(lvl_Convenio, lvdt_Venda_De, lvdt_Venda_Ate)
End Choose

// Tratamento devido a classe retornar apenas integer 32768
If lvl_Linhas > 1 Then
	lvl_Linhas = 10
End If

Return lvl_Linhas
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"venda_pbm_cd_filial","filial_nm_fantasia","venda_pbm_dh_venda","venda_pbm_nr_nf","nr_cupom","conciliacao_pbm_produto_nr_nsu", "venda_pbm_nr_autorizacao",&
			    "venda_pbm_produto_cd_produto", "conciliacao_pbm_produto_ds_produto","conciliacao_pbm_produto_nm_cliente"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo da Filial", "Descri$$HEX2$$e700e300$$ENDHEX$$o da Filial","Data da Venda","Nr. NF","Nr. Cupom","Nr. NSU", "Nr. Autoriza$$HEX2$$e700e300$$ENDHEX$$o", &
	    "C$$HEX1$$f300$$ENDHEX$$d. do Produto", "Desc. do Produto","Desc. do Conv$$HEX1$$ea00$$ENDHEX$$nio"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

//This.of_SetRowSelection("", 'if( id_situacao = "I", RGB(255,0, 0), RGB(0,0,0) )')

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivm_Menu.mf_SalvarComo(true)
	This.of_SetRowSelection()
Else
	dw_2.DataObject = "dw_ge318_nenhum"  
	dw_3.DataObject = "dw_ge318_nenhum"

	dw_2.SetTransObject(SqlCa)
	dw_3.SetTransObject(SqlCa)

End If 

Return pl_Linhas
end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If
end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge318_consulta_conciliacao_pbm
integer x = 69
integer y = 2376
integer width = 3959
integer height = 232
string dataobject = "dw_ge318_nenhum"
end type

event dw_3::ue_retrieve;// OverRide
Date 	lvdt_Venda
		
Long	lvl_Convenio, &
		lvl_Linha, &
		lvl_Produto

String	lvs_Cupom_Conc

dw_2.AcceptText()

lvl_Linha = dw_2.GetRow()

lvl_Convenio 		= dw_1.Object.Cd_Convenio[1]
lvdt_Venda		 	= Date(dw_2.Object.Dh_Transacao[lvl_Linha])
lvs_Cupom_Conc	= dw_2.Object.Nr_Cupom_Conc[lvl_Linha]
lvl_Produto			= dw_2.Object.Cd_Produto[lvl_Linha]

Return This.Retrieve(lvl_Convenio, lvdt_Venda,  lvs_Cupom_Conc, lvl_Produto)

end event

event dw_3::getfocus;call super::getfocus;This.ivm_Menu.mf_SalvarComo(False)
end event

type pb_1 from picturebutton within w_ge318_consulta_conciliacao_pbm
integer x = 32
integer y = 420
integer width = 96
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Contas_Receber\Figuras\Contrair16Cinza.bmp"
alignment htextalign = left!
end type

event clicked;If dw_2.DataObject = "dw_ge318_lista_agrupada" Then
	dw_2.ExpandLevel(2)
End If
end event

type pb_2 from picturebutton within w_ge318_consulta_conciliacao_pbm
integer x = 123
integer y = 420
integer width = 96
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Contas_Receber\Figuras\Expandir16Cinza.bmp"
alignment htextalign = left!
end type

event clicked;If dw_2.DataObject = "dw_ge318_lista_agrupada" Then
	dw_2.ExpandLevel(1)
End If
end event

