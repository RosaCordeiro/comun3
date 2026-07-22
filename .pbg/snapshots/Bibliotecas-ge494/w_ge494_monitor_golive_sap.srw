HA$PBExportHeader$w_ge494_monitor_golive_sap.srw
forward
global type w_ge494_monitor_golive_sap from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge494_monitor_golive_sap
end type
type cb_executar from commandbutton within w_ge494_monitor_golive_sap
end type
type dw_2 from dc_uo_dw_base within w_ge494_monitor_golive_sap
end type
type cb_simular from commandbutton within w_ge494_monitor_golive_sap
end type
type cb_1 from commandbutton within w_ge494_monitor_golive_sap
end type
type st_loja from statictext within w_ge494_monitor_golive_sap
end type
type gb_1 from groupbox within w_ge494_monitor_golive_sap
end type
end forward

global type w_ge494_monitor_golive_sap from dc_w_response
integer width = 2967
integer height = 1748
string title = "GE494 - Monitor Go Live SAP"
dw_1 dw_1
cb_executar cb_executar
dw_2 dw_2
cb_simular cb_simular
cb_1 cb_1
st_loja st_loja
gb_1 gb_1
end type
global w_ge494_monitor_golive_sap w_ge494_monitor_golive_sap

type variables
uo_filial io_filial
long il_Cd_filiais[], il_nulo[]
string is_nm_filiais[], is_nulo[]

datetime idh_parametro
end variables

forward prototypes
public function boolean wf_gera_log (string ps_texto)
public function boolean wf_executar (boolean pb_simulacao)
end prototypes

public function boolean wf_gera_log (string ps_texto);string ls_data
long ll_linha

ll_linha = dw_2.insertrow(0)

if ps_texto = '' Then
	dw_2.object.ds_texto[ll_linha] = '---------------------------------------------------------------------'
else

	ls_data = String(gf_getserverdate(), 'dd/mm/yyyy hh:mm')
	
	dw_2.object.ds_texto[ll_linha] = '[' + ls_data + '] ' + ps_texto
	
end if

return true
end function

public function boolean wf_executar (boolean pb_simulacao);long ll_for, ll_linhas, ll_cd_filial
string ls_log
boolean lb_sucesso = false

if pb_simulacao = False Then
	if messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Deseja executar a migra$$HEX2$$e700e300$$ENDHEX$$o para o SAP das filiais selecionadas?', question!, yesno!, 2) = 2 Then
		return false
	end if
end if

dw_1.accepttext( )

dw_2.reset()

dc_uo_ds_base lds_filiais

uo_ge494_golive_sap luo_migracao

luo_migracao = create uo_ge494_golive_sap

ll_cd_filial = dw_1.object.cd_filial[1]

ll_linhas = upperbound(il_cd_filiais)

if ( ll_cd_filial = 0 or isnull(ll_cd_filial) ) and ( ll_linhas = 0 )Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Nenhuma filial selecionada.')
	return false
end if 

Try

	luo_migracao.ib_log_monitor = True
	if dw_2.ShareData(luo_migracao.idw_log_monitor) = -1 then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Problemas ao executar o m$$HEX1$$e900$$ENDHEX$$todo ShareData.')
		return false
	end if
	
	idh_parametro = gf_GetServerDate()
	
	if ll_linhas = 0 Then
		
		if Not luo_migracao.of_executar( ll_cd_filial, pb_simulacao, ref ls_log ) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			Return false
		End If
		
	else
	
		for ll_for = 1 to ll_linhas
			
			ll_cd_filial = il_cd_filiais[ll_for]
			
			st_loja.text = String(ll_cd_filial, '000') + ' - '  + String(ll_For)  + ' de ' + String(ll_linhas)
			
			if Not luo_migracao.of_executar( ll_cd_filial, pb_simulacao, ref ls_log ) Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				Return false
			End If
			
			dw_2.SetFocus()
			
			SetRedraw(True)
			Yield()
			
		Next
	
	End if
	
	lb_sucesso = True
	
Finally
	
	ShareDataOff(luo_migracao.idw_log_monitor)
	
	DEstroy(luo_migracao)
	
	if lb_sucesso = True Then
		
		if pb_simulacao = True Then
			wf_gera_log('Filiais validadas com sucesso.')
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Filiais validadas com sucesso.')
		else
			wf_gera_log('Processo executado com sucesso.')
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Processo executado com sucesso.')
		End if
	else
		wf_gera_log('Processo interrompido.')
	End if
	
End Try

return true
end function

on w_ge494_monitor_golive_sap.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_executar=create cb_executar
this.dw_2=create dw_2
this.cb_simular=create cb_simular
this.cb_1=create cb_1
this.st_loja=create st_loja
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_executar
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_simular
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_loja
this.Control[iCurrent+7]=this.gb_1
end on

on w_ge494_monitor_golive_sap.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_executar)
destroy(this.dw_2)
destroy(this.cb_simular)
destroy(this.cb_1)
destroy(this.st_loja)
destroy(this.gb_1)
end on

event open;call super::open;io_Filial = Create uo_Filial

dw_1.insertrow(1)

dw_1.setfocus()

If  gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "EX" Then
	cb_executar.Visible = True
End If

// N$$HEX1$$e300$$ENDHEX$$o fecha a tela por inatividade
ivb_permite_fechar = false
end event

event ue_preopen;call super::ue_preopen;ivb_permite_fechar = False
end event

type pb_help from dc_w_response`pb_help within w_ge494_monitor_golive_sap
end type

type dw_1 from dc_uo_dw_base within w_ge494_monitor_golive_sap
integer x = 82
integer y = 76
integer width = 1582
integer height = 184
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge494_filtro"
end type

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_filial"
			
			dw_2.reset()
			il_cd_filiais = il_nulo
			is_nm_filiais = is_nulo
			
			io_Filial.of_Localiza_Filial(This.GetText())
	
			If io_Filial.Localizada Then
				This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial 
				This.Object.Nm_Filial	[1] = io_Filial.Nm_Fantasia
				
				wf_gera_log('Filial Selecionada:')
				wf_gera_log(String(io_Filial.Cd_Filial ) + ' - ' +  io_Filial.Nm_Fantasia )
				wf_gera_log('')
				
			End If	
		End Choose
End If
end event

event itemchanged;call super::itemchanged;long ll_lojas, ll_for, ll_nulo
string ls_nulo

setnull(ls_nulo)
setnull(ll_nulo)

If dwo.Name = "nm_filial" Then
	
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 2
		End If
	Else
		io_Filial.of_Inicializa()
			
		This.Object.Cd_Filial[1] = ll_nulo
		This.Object.Nm_Filial[1] = ls_nulo
	End If
End If

If dwo.Name = "id_filiais" Then
	
	dw_2.reset()
	il_cd_filiais = il_nulo
	is_nm_filiais = is_nulo
	
	This.Object.Cd_Filial[1] = ll_nulo
	This.Object.Nm_Filial[1] = ls_nulo
	
	If Data = 'C' Then
		uo_ge216_filiais uo_filiais
		
		uo_Filiais = Create uo_ge216_filiais
		
		OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
		
		ll_Lojas = Message.DoubleParm
		
		If ll_Lojas > 0 Then
			il_Cd_filiais = uo_Filiais.cd_filial
			is_nm_filiais = uo_filiais.nm_fantasia
			
			If uo_Filiais.ib_todas_filiais Then
				//ivs_filiais = ivs_filiais + ',2,534' 
			End If
			
			for ll_for = 1 to upperbound(il_cd_filiais)
				
				if ll_for = 1 Then
					wf_gera_log('Filiais Selecionadas:')
				end if
				
				wf_gera_log(String(il_cd_filiais[ll_for]) + ' - ' + is_nm_filiais[ll_for])
				
			next
			wf_gera_log('')
			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
		End If
		
		Destroy(uo_Filiais)
	End If
End If
end event

event constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type cb_executar from commandbutton within w_ge494_monitor_golive_sap
boolean visible = false
integer x = 2021
integer y = 60
integer width = 402
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Executar"
end type

event clicked;wf_executar(false)
end event

type dw_2 from dc_uo_dw_base within w_ge494_monitor_golive_sap
integer x = 82
integer y = 296
integer width = 2793
integer height = 1184
integer taborder = 20
boolean bringtotop = true
string title = "Log Execu$$HEX2$$e700e300$$ENDHEX$$o"
string dataobject = "dw_ge494_log"
boolean vscrollbar = true
boolean border = true
end type

type cb_simular from commandbutton within w_ge494_monitor_golive_sap
integer x = 2482
integer y = 60
integer width = 402
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Simular"
end type

event clicked;wf_executar(True)
end event

type cb_1 from commandbutton within w_ge494_monitor_golive_sap
integer x = 2400
integer y = 1536
integer width = 526
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Arquivo Log"
end type

event clicked;Integer lvi_Retorno

string ls_path, ls_file

int li_rc

Long ll_Linhas

Long ll_Filial

dw_1.AcceptText()

ll_Filial = dw_1.Object.cd_filial[1]

If IsNull(ll_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma filial para salvar o arquivo.")
	Return
End If

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

lds.of_ChangeDataObject("ds_ge494_log_extrair")

ll_Linhas = lds.retrieve(ll_Filial, idh_parametro)

If  ll_Linhas <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para serem salvas no arquivo.")
	Return
End If

lds.of_saveAs("")
end event

type st_loja from statictext within w_ge494_monitor_golive_sap
integer x = 82
integer y = 1548
integer width = 1874
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
long bordercolor = 255
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge494_monitor_golive_sap
integer x = 27
integer y = 4
integer width = 2898
integer height = 1512
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

