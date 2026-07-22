HA$PBExportHeader$w_2dw_cadastro_selecao_lista.srw
forward
global type w_2dw_cadastro_selecao_lista from w_sheet
end type
type gb_2 from groupbox within w_2dw_cadastro_selecao_lista
end type
type gb_1 from groupbox within w_2dw_cadastro_selecao_lista
end type
type dw_1 from u_dw within w_2dw_cadastro_selecao_lista
end type
type dw_2 from u_dw within w_2dw_cadastro_selecao_lista
end type
end forward

global type w_2dw_cadastro_selecao_lista from w_sheet
int Width=2350
int Height=1632
event pfc_addrow ( )
event pfc_retrieve ( )
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_2dw_cadastro_selecao_lista w_2dw_cadastro_selecao_lista

type variables
// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para gerenciar 
// a habilita$$HEX2$$e700e300$$ENDHEX$$o das fun$$HEX2$$e700f500$$ENDHEX$$es do menu
// conforme a dw ativa
uo_Controle_Menu_dw ivo_Menu_dw1, &
                                     ivo_Menu_dw2
end variables

forward prototypes
public function integer wf_consiste_salva ()
end prototypes

event pfc_addrow;dw_2.Event pfc_AddRow()
end event

event pfc_retrieve;// Verifica se houveram altera$$HEX2$$e700f500$$ENDHEX$$es na DW de lista
// antes de recuperar as novas informa$$HEX2$$e700f500$$ENDHEX$$es
If wf_Consiste_Salva() = 1 Then
	dw_2.Event pfc_Retrieve()
End If
end event

public function integer wf_consiste_salva ();Integer lvi_Retorno, &
        lvi_Retorno_Salva

SetPointer(HourGlass!)

// Verifica se houve altera$$HEX2$$e700e300$$ENDHEX$$o na DW de detalhes
lvi_Retorno_Salva = wf_Salva()

Choose Case lvi_Retorno_Salva
	Case OK_SEM_PENDENCIAS, &
		  OK_COM_PENDENCIAS, &
		  OK_SUCESSO_UPDATE, &
		  OK_SEM_UPDATE
		  
		// Desabilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False
		ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = False
		
		// Continua
		lvi_Retorno = 1
	Case CANCELAR_ERRO_PENDENCIAS, &
		  CANCELAR_ERRO_UPDATE

		// Desabilita a fun$$HEX2$$e700e300$$ENDHEX$$o de confirma$$HEX2$$e700e300$$ENDHEX$$o
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False

		// N$$HEX1$$e300$$ENDHEX$$o permite
		lvi_Retorno = 0
	Case CANCELAR_UPDATE

		// N$$HEX1$$e300$$ENDHEX$$o permite
		lvi_Retorno = 0
End Choose

Return lvi_Retorno
end function

on w_2dw_cadastro_selecao_lista.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
end on

on w_2dw_cadastro_selecao_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Insere uma linha na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
dw_1.Event pfc_AddRow()
dw_1.SetFocus()
end event

event close;call super::close;Destroy(ivo_Menu_dw1)
Destroy(ivo_Menu_dw2)
end event

event cancelar;call super::cancelar;dw_2.Event Cancelar()
end event

event open;call super::open;// Cria os objetos para o gerenciamento do menu
// conforme a DW ativa
ivo_Menu_dw1 = Create uo_Controle_Menu_dw
ivo_Menu_dw2 = Create uo_Controle_Menu_dw

ivo_Menu_dw1.of_SetMenu(ivm_Menu_Janela)
ivo_Menu_dw2.of_SetMenu(ivm_Menu_Janela)
end event

type gb_2 from groupbox within w_2dw_cadastro_selecao_lista
int X=37
int Y=732
int Width=2258
int Height=704
int TabOrder=10
string Text="Lista"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_2dw_cadastro_selecao_lista
int X=37
int Y=12
int Width=2258
int Height=704
int TabOrder=30
string Text="Par$$HEX1$$e200$$ENDHEX$$metros de Sele$$HEX2$$e700e300$$ENDHEX$$o"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from u_dw within w_2dw_cadastro_selecao_lista
int X=73
int Y=80
int Width=2158
int Height=588
int TabOrder=20
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False
end event

event getfocus;call super::getfocus;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es do menu da janela conforme a DW ativa
ivo_Menu_dw1.of_Atualiza()
end event

type dw_2 from u_dw within w_2dw_cadastro_selecao_lista
event type string formula_clausula_where ( )
int X=82
int Y=808
int Width=2158
int Height=588
int TabOrder=11
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event formula_clausula_where;Return ''
end event

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)

// Determina o tipo de fun$$HEX2$$e700e300$$ENDHEX$$o de cancelamento
ivi_Tipo_Cancelar = RETRIEVE


end event

event pfc_retrieve;call super::pfc_retrieve;Boolean lvb_Habilita

Long lvl_Linhas

String lvs_SQL, &
       lvs_Where

// Verifica qual a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_Where = This.Event Formula_Clausula_Where()

// Se faltar algum par$$HEX1$$e200$$ENDHEX$$metro de preenchimento retorna Erro
If lvs_Where = "ERRO" Then Return -1

// Concatena o SQL original com a condi$$HEX2$$e700e300$$ENDHEX$$o de consulta
lvs_SQL = ivs_SQL_Original + lvs_Where

// Atualiza o SQL da DW
This.Object.Datawindow.Table.Select = lvs_SQL

// Recupera as linhas da DW de lista
// conforme os par$$HEX1$$e200$$ENDHEX$$metros informados na DW de sele$$HEX2$$e700e300$$ENDHEX$$o
lvl_Linhas = This.Event Recuperar()

// Se recuperar alguma linha
If lvl_Linhas > 0 Then
	// Se recuperar mais de uma linha
	If lvl_Linhas > 1 Then
		lvb_Habilita = True
	Else
		lvb_Habilita = False
	End If
	
	// Atualiza o menu de exclus$$HEX1$$e300$$ENDHEX$$o
	ivo_Menu_dw2.of_Excluir(wf_Habilita_Menu("E"))
	
	This.ScrollToRow(1)
	This.SetRow(1)
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!, Ok!)
	ivo_Menu_dw2.of_Excluir(False)
	lvb_Habilita = False
End If

// Atualiza o objeto de controle do menu da DW
ivo_Menu_dw2.of_Incluir(ivo_Menu_dw1.ivb_Incluir)
ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw2.of_Classificar(lvb_Habilita)
ivo_Menu_dw2.of_Filtrar(lvb_Habilita)
ivo_Menu_dw2.of_Localizar(lvb_Habilita)

Return lvl_Linhas
end event

event getfocus;call super::getfocus;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es do menu da janela conforme a DW ativa
ivo_Menu_dw2.of_Incluir(ivo_Menu_dw1.ivb_Incluir)
ivo_Menu_dw2.of_Recuperar(ivo_Menu_dw1.ivb_Recuperar)
ivo_Menu_dw2.of_Atualiza()
end event

event itemchanged;call super::itemchanged;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da opera$$HEX2$$e700e300$$ENDHEX$$o
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled  = True
end event

event editchanged;call super::editchanged;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento da opera$$HEX2$$e700e300$$ENDHEX$$o
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled  = True
end event

event recuperar;call super::recuperar;Return This.Retrieve()
end event

