HA$PBExportHeader$w_tv_1dw_cadastro_lista.srw
forward
global type w_tv_1dw_cadastro_lista from w_sheet
end type
type dw_1 from u_dw within w_tv_1dw_cadastro_lista
end type
type tv_1 from u_tvs within w_tv_1dw_cadastro_lista
end type
end forward

global type w_tv_1dw_cadastro_lista from w_sheet
int Width=2743
int Height=1588
event pfc_addrow ( )
dw_1 dw_1
tv_1 tv_1
end type
global w_tv_1dw_cadastro_lista w_tv_1dw_cadastro_lista

type variables

end variables

event pfc_addrow;// Executa o evento AddRow da DW
dw_1.Event pfc_AddRow()
end event

on w_tv_1dw_cadastro_lista.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.tv_1=create tv_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.tv_1
end on

on w_tv_1dw_cadastro_lista.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.tv_1)
end on

event cancelar;call super::cancelar;SetPointer(HourGlass!)

// Chama o evento de cancelamento da DW
dw_1.Event cancelar()
end event

type dw_1 from u_dw within w_tv_1dw_cadastro_lista
int X=1029
int Y=12
int Width=1678
int Height=1388
int TabOrder=11
boolean BringToTop=true
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=false
end type

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)

// Determina qual o tipo de a$$HEX2$$e700e300$$ENDHEX$$o da fun$$HEX2$$e700e300$$ENDHEX$$o de cancelamento
ivi_Tipo_Cancelar = RETRIEVE
end event

event pfc_retrieve;call super::pfc_retrieve;Boolean ivb_Habilita
Long lvl_Linhas

// Recupera as linhas conforme a linha selecionada na TreeView
lvl_Linhas = This.Event Recuperar()

If lvl_Linhas > 0 Then
	// Se recuperar mais de uma linha
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de localiza$$HEX2$$e700e300$$ENDHEX$$o, filtro e classifica$$HEX2$$e700e300$$ENDHEX$$o
	If lvl_Linhas > 1 Then
		ivb_Habilita = True
	Else
		ivb_Habilita = False
	End If
	
	// Habilita o menu de exclus$$HEX1$$e300$$ENDHEX$$o conforme o n$$HEX1$$ed00$$ENDHEX$$vel de acesso do usu$$HEX1$$e100$$ENDHEX$$rio
	wf_Habilita_Menu("E")
Else
	ivb_Habilita = False
	ivm_Menu_Janela.m_Editar.m_Excluir.Enabled = False
End If

ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = ivb_Habilita
ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = ivb_Habilita
ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = ivb_Habilita

Return lvl_Linhas
end event

event editchanged;call super::editchanged;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = True
end event

event itemchanged;call super::itemchanged;// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = True
end event

event pfc_addrow;call super::pfc_addrow;SetPointer(HourGlass!)

// Se existir mais de uma linha na DW
If This.RowCount() > 1 Then
	// Habilita as fun$$HEX2$$e700f500$$ENDHEX$$es de classifica$$HEX2$$e700e300$$ENDHEX$$o, filtro e localiza$$HEX2$$e700e300$$ENDHEX$$o
	ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = True
	ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = True

	// Habilita o menu de exclus$$HEX1$$e300$$ENDHEX$$o conforme o n$$HEX1$$ed00$$ENDHEX$$vel de acesso do usu$$HEX1$$e100$$ENDHEX$$rio
	wf_Habilita_Menu("E")
End If

Return AncestorReturnValue
end event

type tv_1 from u_tvs within w_tv_1dw_cadastro_lista
int X=14
int Y=12
int Width=997
int Height=1388
int TabOrder=11
boolean BringToTop=true
BorderStyle BorderStyle=StyleRaised!
long PictureMaskColor=79741120
long TextColor=8388608
long BackColor=16777215
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event selectionchanged;call super::selectionchanged;SetPointer(HourGlass!)

// Recupera as linhas da DW
// conforme a linha selecionada na TreeView
dw_1.Event pfc_Retrieve()

// Habilita o bot$$HEX1$$e300$$ENDHEX$$o de incluir do menu
If ivi_nivel = 2 Then
	wf_Habilita_Menu("I")
Else
	ivm_menu_janela.m_editar.m_incluir.Enabled = False
End If


end event

event selectionchanging;SetPointer(HourGlass!)

Integer lvi_Retorno_Salva

// Verifica se houveram altera$$HEX2$$e700f500$$ENDHEX$$es na DW
// com rela$$HEX2$$e700e300$$ENDHEX$$o a linha selecionada na TreeView
lvi_Retorno_Salva = wf_Salva()

Choose Case lvi_Retorno_Salva
	Case OK_SEM_PENDENCIAS, &
		  OK_COM_PENDENCIAS, &
		  OK_SUCESSO_UPDATE, &
		  OK_SEM_UPDATE
		  
		// Desabilita as fun$$HEX2$$e700f500$$ENDHEX$$es de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False
		ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = False
		
		// Permite a troca de sele$$HEX2$$e700e300$$ENDHEX$$o
		Return 0
	Case CANCELAR_ERRO_PENDENCIAS, &
		  CANCELAR_ERRO_UPDATE

		// Desabilita a fun$$HEX2$$e700e300$$ENDHEX$$o de confirma$$HEX2$$e700e300$$ENDHEX$$o
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False

		// N$$HEX1$$e300$$ENDHEX$$o permite a troca de sele$$HEX2$$e700e300$$ENDHEX$$o
		Return 1		  
	Case CANCELAR_UPDATE

		// N$$HEX1$$e300$$ENDHEX$$o permite a troca de sele$$HEX2$$e700e300$$ENDHEX$$o
		Return 1
End Choose
end event

