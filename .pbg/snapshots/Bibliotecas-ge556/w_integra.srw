HA$PBExportHeader$w_integra.srw
forward
global type w_integra from dc_w_sheet
end type
type cb_1 from commandbutton within w_integra
end type
end forward

global type w_integra from dc_w_sheet
cb_1 cb_1
end type
global w_integra w_integra

on w_integra.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_integra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

type dw_visual from dc_w_sheet`dw_visual within w_integra
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_integra
end type

type cb_1 from commandbutton within w_integra
integer x = 64
integer y = 68
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "token"
end type

event clicked;Blob lb_args
Long ll_length, ll_Sucesso
String ls_headers
String ls_url
String ls_argumentos
String ls_Retorno
String ls_Mensagem

inet intranet
uo_internetresult result
//grant_Type=client_credentials&client_Id=92AB0142-51D9-4632-AFED-2B1294F2185B&client_Secret=zsII9M&UBPS2w$Us
ls_url = 'https://api-mng.interplayers.com.br/gip-scs-svc/token'
ls_argumentos = "client_credentials&client_Id=92AB0142-51D9-4632-AFED-2B1294F2185B&client_Secret=zsII9M&UBPS2w$Us"

lb_args	= blob( ls_argumentos, EncodingANSI! )
ll_length 	= Len(lb_args)
ls_headers = "Content-Type: " + &
				 "application/x-www-form-urlencoded~n" + &
				 "Content-Length: " + String( ll_length ) + "~n~n"

ll_Sucesso = intranet.PostURL( ls_url,lb_args,ls_headers, result )

ls_Retorno = result.is_data

If ll_Sucesso <> 1 Then
	Choose Case ll_Sucesso
		Case -1 
			ls_Mensagem = 'General error'			
		Case -2
			ls_Mensagem = 'Invalid URL'			
		Case -4
			ls_Mensagem = 'Cannot connect to the Internet'			
		Case -6
			ls_Mensagem = 'Internet request failed'			
	End Choose
End If
end event

