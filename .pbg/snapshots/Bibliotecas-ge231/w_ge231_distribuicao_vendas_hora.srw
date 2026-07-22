HA$PBExportHeader$w_ge231_distribuicao_vendas_hora.srw
forward
global type w_ge231_distribuicao_vendas_hora from dc_w_selecao_lista_relatorio
end type
type cb_gerar from commandbutton within w_ge231_distribuicao_vendas_hora
end type
end forward

global type w_ge231_distribuicao_vendas_hora from dc_w_selecao_lista_relatorio
integer width = 2770
integer height = 1648
string title = "GE231 - Distribui$$HEX2$$e700e300$$ENDHEX$$o de Vendas"
boolean resizable = false
cb_gerar cb_gerar
end type
global w_ge231_distribuicao_vendas_hora w_ge231_distribuicao_vendas_hora

type variables
uo_filial ivo_filial

DataStore ivds_1

dc_uo_transacao SqlCa_Aux
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();String lvs_Filial

dw_1.AcceptText()

lvs_Filial = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

If ivo_Filial.Localizada Then
	
	dw_1.Object.Cd_Filial[1]   = ivo_Filial.Cd_Filial
	dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
	
End If


end subroutine

on w_ge231_distribuicao_vendas_hora.create
int iCurrent
call super::create
this.cb_gerar=create cb_gerar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
end on

on w_ge231_distribuicao_vendas_hora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_gerar)
end on

event open;call super::open;ivo_Filial 	= Create Uo_Filial
ivds_1     	= Create DataStore

SqlCa_Aux   = Create dc_uo_transacao

SqlCa_Aux = SqlCa;

SqlCa_Aux.AutoCommit = True

Connect Using SqlCa_Aux;

/*------------------------------------------------------------
Wagner
N$$HEX1$$e300$$ENDHEX$$o usar esta GE em Sistemas que utilizam PFC
Motivo: Objeto SQLCA est$$HEX1$$e100$$ENDHEX$$ vinculado ao n_tr
---------------------------------------------------------------*/


end event

event close;call super::close;Destroy ivo_Filial
Destroy ivds_1

//SqlCa   = Create dc_uo_transacao

SqlCa = SqlCa_Aux;

SqlCa.AutoCommit = True

Connect Using SqlCa;



end event

event ue_postopen;call super::ue_postopen;Date lvdt_Data

lvdt_Data = Date(gvo_Parametro.of_dh_movimentacao())

dw_1.Object.Dt_Inicio[1] = RelativeDate(lvdt_Data, -1)
dw_1.Object.Dt_Fim   [1] = lvdt_Data

This.ivm_Menu.ivb_Permite_Imprimir = True

 
end event

event ue_preprint;//OverRide
Long lvl_Linhas

dw_3.Event ue_Retrieve()

lvl_Linhas = dw_3.RowCount()

Return lvl_Linhas
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge231_distribuicao_vendas_hora
integer x = 18
integer y = 364
integer width = 2720
integer height = 1108
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge231_distribuicao_vendas_hora
integer x = 14
integer y = 0
integer width = 1801
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge231_distribuicao_vendas_hora
integer x = 50
integer y = 64
integer width = 1728
integer height = 264
string dataobject = "dw_ge231_selecao"
end type

event dw_1::ue_key;String lvs_Coluna

lvs_Coluna = GetColumnName()

If key = keyEnter! Then
	
	If lvs_Coluna = "nm_fantasia" Then
		
		wf_Localiza_Filial()
		
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

SetNull(lvl_Nulo)

If dwo.Name = "nm_fantasia" Then
		
	If Data = "" Or ISNULL(Data) Then
		This.Object.Cd_Filial[1] = lvl_nulo
		Return 0
	End If

	If Data <> ivo_Filial.Nm_Fantasia Then Return 1
	
End If

cb_gerar.Enabled = False
end event

event dw_1::editchanged;call super::editchanged;cb_gerar.Enabled = False
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge231_distribuicao_vendas_hora
integer x = 50
integer y = 428
integer width = 2656
integer height = 1004
string dataobject = "dw_ge231_grafico_horario_cliente"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;If dw_1.Object.Tipo_Rel[1] = "C" Then
	
	This.DataObject = "dw_ge231_grafico_horario_cliente"
	This.SetTransObject(SqlCa)
	
	dw_3.DataObject = "dw_ge231_relatorio_cliente"
	dw_3.SetTransObject(SqlCa)
	
	ivds_1.DataObject = "dw_ge231_vendas_horario_cliente"
	ivds_1.SetTransObject(SqlCa)
	
Else
	
	This.DataObject = "dw_ge231_grafico_horario_valor"
	This.SetTransObject(SqlCa)
	
	dw_3.DataObject = "dw_ge231_relatorio_valor"
	dw_3.SetTransObject(SqlCa)
	
	ivds_1.DataObject = "dw_ge231_vendas_horario_valor"
	ivds_1.SetTransObject(SqlCa)
	
End If

If dw_1.Object.Cd_Filial[1] = 0 or IsNull(dw_1.Object.Cd_Filial[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deve ser informado a filial para recupera$$HEX2$$e700e300$$ENDHEX$$o dos dados.",Information!,Ok!)
	dw_1.SetColumn("nm_fantasia") 
	dw_1.SetFocus()
	Return -1
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//OverRide

Long lvl_Filial, &
     lvl_Linhas

DateTime lvdt_Inicio, &
         lvdt_Termino
			
String lvs_Tipo
	  
dw_1.AcceptText()

lvl_Filial   		= dw_1.Object.Cd_Filial[1]
lvdt_Inicio  		= DateTime(dw_1.Object.Dt_Inicio[1])
lvdt_Termino 	= DateTime(dw_1.Object.Dt_Fim[1])
lvs_Tipo     		= dw_1.Object.Tipo_Rel[1]

lvl_Linhas = This.Retrieve(lvs_Tipo, lvdt_Inicio, lvdt_Termino, lvl_Filial)

If lvl_Linhas > 0 Then
	
	If ivds_1.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Filial) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recupar as informa$$HEX2$$e700e300$$ENDHEX$$oes.", Information!)
		Return lvl_Linhas
	End If
	
End If

Return lvl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ShareDataOff()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	cb_gerar.Enabled = True
Else
	cb_gerar.Enabled = False
End If

Return pl_Linhas

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge231_distribuicao_vendas_hora
integer x = 2167
integer y = 36
integer width = 448
integer height = 284
integer taborder = 50
string dataobject = "dw_ge231_relatorio_cliente"
end type

event dw_3::ue_recuperar;//OverRide
Long lvl_Filial, &
     lvl_Linhas

DateTime lvdt_Inicio, &
         lvdt_Termino
			
String lvs_Tipo
	  
dw_1.AcceptText()

lvl_Filial   		= dw_1.Object.Cd_Filial[1]
lvdt_Inicio		= DateTime(dw_1.Object.Dt_Inicio[1])
lvdt_Termino 	= DateTime(dw_1.Object.Dt_Fim[1])
lvs_Tipo     		= dw_1.Object.Tipo_Rel[1]

lvl_Linhas = This.Retrieve(lvs_Tipo, lvdt_Inicio, lvdt_Termino, lvl_Filial)

If lvl_Linhas > 0 Then
	
	dw_3.Object.Periodo.Text = String(lvdt_Inicio, "DD/MM/YYYY") + " at$$HEX1$$e900$$ENDHEX$$: " + String(lvdt_Termino, "DD/MM/YYYY")
	dw_3.Object.Filial.Text  = dw_1.Object.Nm_Fantasia[1] + " - " + String(lvl_Filial, "0000")
	
	If lvs_Tipo = 'C' Then
		dw_3.Object.Tipo.Text = "CLIENTES"
	Else
		dw_3.Object.Tipo.Text = "VALOR"
	End If
End If

Return lvl_Linhas
end event

type cb_gerar from commandbutton within w_ge231_distribuicao_vendas_hora
integer x = 1339
integer y = 228
integer width = 425
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Gerar Arquivo"
end type

event clicked;Boolean lvb_Grava = True

String	lvs_Tipo_Relatorio	, &
		lvs_Filial				, &
		lvs_Arquivo			, &
		lvs_Inicio				, &
		lvs_Fim	

lvs_Filial         		= String(dw_1.Object.Cd_Filial	[1], "000")
lvs_Tipo_Relatorio = dw_1.Object.Tipo_Rel[1]
lvs_Inicio         		= String(dw_1.Object.Dt_Inicio	[1], "DDMMYY")
lvs_Fim            	= String(dw_1.Object.Dt_Fim	[1], "DDMMYY")

If lvs_Tipo_Relatorio = 'C'Then
	lvs_Arquivo = lvs_Filial + "_" + 'ven_cli' + "_" + lvs_Inicio + "_a_" + lvs_Fim
Else
	lvs_Arquivo = lvs_Filial + "_" + 'ven_vl' + "_" + lvs_Inicio + "_a_" + lvs_Fim
End If

OpenWithParm(w_ge231_selecao_diretorio, lvs_Arquivo)

String lvs_Caminho

Integer lvi_Retorno

lvs_Caminho = Message.StringParm

If lvs_Caminho <> "" Then
	If FileExists(lvs_Caminho) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O arquivo especificado j$$HEX1$$e100$$ENDHEX$$ existe. Deseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?",Question!,YesNO!,2) = 2 Then
			lvb_Grava = False
		End If
	End If		
End If

If lvb_Grava Then
	
	lvi_retorno = ivds_1.SaveAs(lvs_Caminho, Excel!, True)
	
	If lvi_retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao salvar o arquivo. Confira o nome e tente novamente.", StopSign!, Ok!)
		Return
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso.",Information!,Ok!)
	End If
End If
end event

