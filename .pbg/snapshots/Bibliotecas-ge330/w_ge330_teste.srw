HA$PBExportHeader$w_ge330_teste.srw
forward
global type w_ge330_teste from dc_w_sheet
end type
type cb_3 from commandbutton within w_ge330_teste
end type
end forward

global type w_ge330_teste from dc_w_sheet
integer width = 1989
integer height = 1508
string menuname = ""
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_3 cb_3
end type
global w_ge330_teste w_ge330_teste

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

on w_ge330_teste.create
int iCurrent
call super::create
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
end on

on w_ge330_teste.destroy
call super::destroy
destroy(this.cb_3)
end on

type dw_visual from dc_w_sheet`dw_visual within w_ge330_teste
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge330_teste
end type

type cb_3 from commandbutton within w_ge330_teste
integer x = 512
integer y = 360
integer width = 837
integer height = 112
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

event clicked;uo_ge330_agendamento_entrega lo_Agendamento

Try
	lo_Agendamento = Create uo_ge330_agendamento_entrega
	
	lo_Agendamento.of_processa_envio_arquivo_agendamento()
Finally
	Destroy(lo_Agendamento)
End Try
end event

