HA$PBExportHeader$w_ge330_entregou.srw
forward
global type w_ge330_entregou from dc_w_sheet
end type
type cb_3 from commandbutton within w_ge330_entregou
end type
end forward

global type w_ge330_entregou from dc_w_sheet
string tag = "w_ge330_entregou"
integer width = 997
integer height = 364
string title = "GE330 - Envio Entregou.com"
string menuname = ""
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_3 cb_3
end type
global w_ge330_entregou w_ge330_entregou

forward prototypes
public function boolean of_verifica_drivers ()
end prototypes

public function boolean of_verifica_drivers ();Boolean lb_Soap	= True

String ls_Folder
String ls_Erro = ""

String ls_Validar[]

ls_Folder	= gvo_Aplicacao.of_Get_System_Directory()

ls_Validar = {'pbdom120.pbd', 'pbsoapclient120.pbd'}
ls_Folder	= gvo_Aplicacao.of_get_program_files_directory()
				
If Not gf_download_matriz(ls_Validar, ls_Validar, ls_Folder + '\Sybase\Shared\PowerBuilder', 'PB12',  False) Then Return False

lb_Soap	= FileExists( ls_Folder + '\Sybase\Shared\PowerBuilder\pbsoapclient120.pbd' ) And &
			   FileExists( ls_Folder + '\Sybase\Shared\PowerBuilder\pbdom120.pbd' )
				
If Not lb_Soap Then
	ls_Erro = "Arquivo 'pbsoapclient120.pbd' n$$HEX1$$e300$$ENDHEX$$o localizado no Windows."
End If

If ls_Erro <> "" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro + "~r~r          Abra um chamado no Service Desk" + &
												"~r informando este erro e aguarde atendimento", StopSign! )
End If

Return  lb_Soap
end function

on w_ge330_entregou.create
int iCurrent
call super::create
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
end on

on w_ge330_entregou.destroy
call super::destroy
destroy(this.cb_3)
end on

type dw_visual from dc_w_sheet`dw_visual within w_ge330_entregou
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge330_entregou
end type

type cb_3 from commandbutton within w_ge330_entregou
integer x = 64
integer y = 96
integer width = 837
integer height = 98
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Envia Arquivos p/ WebService"
end type

event clicked;If gvo_Aplicacao.ivs_DataSource <> 'central' Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O envio s$$HEX1$$f300$$ENDHEX$$ pode ser feito a partir da base de produ$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o envio do XML para o entregou.com ?", Question!, YesNo!, 2) = 2 Then Return

uo_ge330_agendamento_entrega lo_Agendamento

Try
	lo_Agendamento = Create uo_ge330_agendamento_entrega
	
	lo_Agendamento.of_processa_envio_arquivo_agendamento()
Finally
	Destroy(lo_Agendamento)
End Try
end event

