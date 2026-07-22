HA$PBExportHeader$w_mensagem_erro.srw
$PBExportComments$Janela de exibi$$HEX2$$e700e300$$ENDHEX$$o e impress$$HEX1$$e300$$ENDHEX$$o de mensagens de erro
forward
global type w_mensagem_erro from w_response
end type
type dw_1 from u_dw within w_mensagem_erro
end type
type cb_1 from commandbutton within w_mensagem_erro
end type
type cb_2 from commandbutton within w_mensagem_erro
end type
type st_1 from statictext within w_mensagem_erro
end type
type st_2 from statictext within w_mensagem_erro
end type
type st_3 from statictext within w_mensagem_erro
end type
type st_4 from statictext within w_mensagem_erro
end type
type mle_1 from multilineedit within w_mensagem_erro
end type
type em_1 from editmask within w_mensagem_erro
end type
end forward

global type w_mensagem_erro from w_response
int X=146
int Y=0
int Width=1609
int Height=1520
boolean TitleBar=true
string Title="Erro na Aplica$$HEX2$$e700e300$$ENDHEX$$o"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
mle_1 mle_1
em_1 em_1
end type
global w_mensagem_erro w_mensagem_erro

type variables
// $$HEX1$$c100$$ENDHEX$$rea para armazenar o nome da tabela e a sintaxe de
// restri$$HEX2$$e700f500$$ENDHEX$$es de integridade

String ivs_nome_tabela, ivs_sintaxe, ivs_nome_tabela_restr

// $$HEX1$$c100$$ENDHEX$$rea para armazenar a transa$$HEX2$$e700e300$$ENDHEX$$o passada como par$$HEX1$$e200$$ENDHEX$$-
// metro

n_tr ivtr_transacao
end variables

forward prototypes
public function string wf_mensagem_anywhere ()
end prototypes

public function string wf_mensagem_anywhere ();SetPointer(HourGlass!)

String lvs_mensagem_tratada

// Monta a mensagem tratada em fun$$HEX2$$e700e300$$ENDHEX$$o do erro ocorrido

CHOOSE CASE ivtr_transacao.SqlDbCode
	CASE -193
		lvs_mensagem_tratada = "Registro j$$HEX1$$e100$$ENDHEX$$ existente no banco de dados"
	CASE -194
		lvs_mensagem_tratada = "Restri$$HEX2$$e700e300$$ENDHEX$$o de integridade"
	CASE ELSE
		lvs_mensagem_tratada = "Erro inesperado no acesso ao banco de dados"
END CHOOSE

Return lvs_mensagem_tratada

end function

on w_mensagem_erro.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.mle_1=create mle_1
this.em_1=create em_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.mle_1
this.Control[iCurrent+9]=this.em_1
end on

on w_mensagem_erro.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.mle_1)
destroy(this.em_1)
end on

event open;call super::open;SetPointer(HourGlass!)

String lvs_nome_janela_ativa, lvs_mensagem, lvs_nome_banco
Window lvw_janela

// Carrega a vari$$HEX1$$e100$$ENDHEX$$vel de inst$$HEX1$$e200$$ENDHEX$$ncia com a transa$$HEX2$$e700e300$$ENDHEX$$o passada como par$$HEX1$$e200$$ENDHEX$$metro

ivtr_transacao = Message.PowerObjectParm

// Posiciona a janela

This.X = 1000
This.Y = 500

// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o que ir$$HEX1$$e100$$ENDHEX$$ montar as mensagens, de acordo com o banco da transacao

lvs_nome_banco = ivtr_transacao.of_GetName()
CHOOSE CASE lvs_nome_banco
	CASE "Anywhere"
		lvs_mensagem = wf_mensagem_anywhere()
	CASE ELSE
		lvs_mensagem = "Banco de dados " + lvs_nome_banco + &
		               " sem tratamento de mensagem de erro"
END CHOOSE

// Monta a dw e os campos da janela

dw_1.InsertRow(0)
dw_1.SetItem(1, "codigo_erro", ivtr_transacao.SqlDbCode)
em_1.Text = String(ivtr_transacao.SqlDbCode)
dw_1.SetItem(1, "mensagem_banco", ivtr_transacao.SqlErrText)
dw_1.SetItem(1, "mensagem_tratada", lvs_mensagem)
mle_1.Text = lvs_mensagem
dw_1.SetItem(1, "sistema", gnv_app.iapp_object.DisplayName)

// Obt$$HEX1$$e900$$ENDHEX$$m o nome da janela ativa na MDI e comp$$HEX1$$f500$$ENDHEX$$e a dw de relat$$HEX1$$f300$$ENDHEX$$rio de erro

lvw_janela = w_frame.GetActiveSheet()

If IsValid(lvw_janela) Then
	lvs_nome_janela_ativa = lvw_janela.Title
Else
	SetNull(lvs_nome_janela_ativa)
End If

dw_1.SetItem(1, "janela", lvs_nome_janela_ativa)

end event

type dw_1 from u_dw within w_mensagem_erro
int X=14
int Y=12
int Width=3319
int Height=1528
int TabOrder=0
boolean Visible=false
boolean Enabled=false
string DataObject="dw_mensagem_erro"
boolean VScrollBar=false
end type

type cb_1 from commandbutton within w_mensagem_erro
int X=818
int Y=1312
int Width=352
int Height=92
int TabOrder=10
boolean BringToTop=true
string Text="Imprimir"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

// Imprime a dw com as informa$$HEX2$$e700f500$$ENDHEX$$es do erro

dw_1.Print()
end event

type cb_2 from commandbutton within w_mensagem_erro
int X=1189
int Y=1312
int Width=352
int Height=92
int TabOrder=20
boolean BringToTop=true
string Text="Cancelar"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

// Fecha a janela ativa

Close(Parent)
end event

type st_1 from statictext within w_mensagem_erro
int X=137
int Y=36
int Width=1303
int Height=100
boolean Enabled=false
boolean BringToTop=true
string Text="Ocorreu um Erro na Aplica$$HEX2$$e700e300$$ENDHEX$$o"
boolean FocusRectangle=false
long TextColor=128
long BackColor=79741120
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_mensagem_erro
int X=32
int Y=284
int Width=1513
int Height=228
boolean Enabled=false
boolean BringToTop=true
string Text="Por Favor Imprima as Informa$$HEX2$$e700f500$$ENDHEX$$es Abaixo e Encaminhe ao Analista Respons$$HEX1$$e100$$ENDHEX$$vel pelo Sistema."
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_mensagem_erro
int X=32
int Y=636
int Width=302
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="C$$HEX1$$f300$$ENDHEX$$digo:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_mensagem_erro
int X=32
int Y=784
int Width=425
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Mensagem:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_1 from multilineedit within w_mensagem_erro
int X=32
int Y=880
int Width=1513
int Height=336
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_mensagem_erro
int X=329
int Y=624
int Width=297
int Height=100
boolean BringToTop=true
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
string DisplayData=""
boolean DisplayOnly=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

