HA$PBExportHeader$w_1dw_cadastro_freeform.srw
forward
global type w_1dw_cadastro_freeform from w_sheet
end type
type dw_1 from u_dw within w_1dw_cadastro_freeform
end type
end forward

global type w_1dw_cadastro_freeform from w_sheet
int Width=1952
int Height=1156
event pfc_addrow ( )
event pfc_retrieve ( )
dw_1 dw_1
end type
global w_1dw_cadastro_freeform w_1dw_cadastro_freeform

forward prototypes
public function integer wf_consiste_salva ()
end prototypes

event pfc_addrow;If wf_Consiste_Salva() = 1 Then
	dw_1.Reset()
	dw_1.Event pfc_AddRow()
End If
end event

event pfc_retrieve;If wf_Consiste_Salva() = 1 Then
	dw_1.Event pfc_Retrieve()
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

on w_1dw_cadastro_freeform.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_1dw_cadastro_freeform.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

// Insere uma linha para inser$$HEX2$$e700e300$$ENDHEX$$o de um novo registro na DW
dw_1.Event pfc_AddRow()
dw_1.SetFocus()

wf_Habilita_Menu("I")
end event

event cancelar;SetPointer(HourGlass!)

// Chama o evento de cancelamento da DW
dw_1.Event Cancelar()

ib_DisableCloseQuery = True
end event

event pfc_postupdate;call super::pfc_postupdate;If AncestorReturnValue = 1 Then
	// Ap$$HEX1$$f300$$ENDHEX$$s o t$$HEX1$$e900$$ENDHEX$$rmino do evento de salva da janela
	// executa o evento cancelar para preparar a inser$$HEX2$$e700e300$$ENDHEX$$o
	// de uma nova linha na DW
	This.Event Cancelar()
End If

Return AncestorReturnValue
end event

type dw_1 from u_dw within w_1dw_cadastro_freeform
int X=32
int Y=24
int Width=1701
int Height=944
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event itemerror;call super::itemerror;// Passa pela valida$$HEX2$$e700e300$$ENDHEX$$o de erro p/ n$$HEX1$$e300$$ENDHEX$$o dar problema na inclus$$HEX1$$e300$$ENDHEX$$o do registro
Return 1
end event

event editchanged;call super::editchanged;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = True
end event

event itemchanged;call super::itemchanged;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento
ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = True
end event

event constructor;call super::constructor;SetPointer(HourGlass!)

// Estabelece o tipo de a$$HEX2$$e700e300$$ENDHEX$$o no cancelamento
ivi_Tipo_Cancelar = ADDROW
end event

event pfc_addrow;call super::pfc_addrow;ib_DisableCloseQuery = True

Return AncestorReturnValue
end event

