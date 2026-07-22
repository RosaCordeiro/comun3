HA$PBExportHeader$w_ge195_download_sefaz.srw
forward
global type w_ge195_download_sefaz from dc_w_base
end type
type st_1 from statictext within w_ge195_download_sefaz
end type
type cb_2 from commandbutton within w_ge195_download_sefaz
end type
type cb_1 from commandbutton within w_ge195_download_sefaz
end type
end forward

global type w_ge195_download_sefaz from dc_w_base
integer width = 1147
integer height = 616
string title = "GE195 - Download SEFAZ"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_ge195_download_sefaz w_ge195_download_sefaz

type prototypes
FUNCTION long ShellExecuteA ( long ll_hWnd, REF String ls_operation, REF String ls_file, REF string ls_parameters, REF string ls_directory, INT nShowCmd) library 'shell32.dll' 
end prototypes

type variables
String is_Chave_Acesso
end variables

on w_ge195_download_sefaz.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
end on

on w_ge195_download_sefaz.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;call super::open;is_Chave_Acesso = Message.StringParm
end event

type st_1 from statictext within w_ge195_download_sefaz
integer x = 73
integer y = 8
integer width = 1705
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "O arquivo deve ser salvo no diret$$HEX1$$f300$$ENDHEX$$rio ~"C:\Sistemas\WS\XML_CTe\~""
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_ge195_download_sefaz
integer x = 841
integer y = 416
integer width = 256
integer height = 100
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

type cb_1 from commandbutton within w_ge195_download_sefaz
integer x = 215
integer y = 160
integer width = 704
integer height = 204
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Site SEFAZ - CT-e"
end type

event clicked;String ls_url 

//ls_url = "http://www.cte.fazenda.gov.br/consulta.aspx?tipoConsulta=completa&tipoConteudo=mCK/KoCqru0="

ls_url = "http://www.cte.fazenda.gov.br/consulta.aspx?tipoConsulta=completa&tipoConteudo=mCK/KoCqru0=&cte="+is_Chave_Acesso

gf_run( "iexplore.exe "+ ls_url)

end event

