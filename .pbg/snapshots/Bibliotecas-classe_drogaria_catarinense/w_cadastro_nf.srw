HA$PBExportHeader$w_cadastro_nf.srw
forward
global type w_cadastro_nf from w_sheet
end type
type dw_1 from u_dw within w_cadastro_nf
end type
type dw_2 from u_dw within w_cadastro_nf
end type
end forward

global type w_cadastro_nf from w_sheet
int Width=1870
int Height=1160
event pfc_deleterow ( )
event pfc_addrow ( )
dw_1 dw_1
dw_2 dw_2
end type
global w_cadastro_nf w_cadastro_nf

type variables
// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas para determinar
// as chaves prim$$HEX1$$e100$$ENDHEX$$rias das tabelas mestre e detalhe
String ivs_Chave_dw1[], &
          ivs_Chave_dw2[]

end variables

forward prototypes
public function integer wf_consiste_salva ()
end prototypes

event pfc_deleterow;dw_2.Event pfc_DeleteRow()
end event

event pfc_addrow;dw_2.Event pfc_AddRow()
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

on w_cadastro_nf.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_cadastro_nf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event pfc_postopen;call super::pfc_postopen;// Determina a ordem de execu$$HEX2$$e700e300$$ENDHEX$$o do pfc_Save() para os objetos
// Declara um array de objetos
PowerObject lvo_Objects[]

// Inicializa o array com os objetos
// que dever$$HEX1$$e300$$ENDHEX$$o fazer parte do pfc_Save com a ordem determinada
lvo_Objects = {dw_1, dw_2}

of_SetUpdateObjects(lvo_Objects)

SetPointer(HourGlass!)

// Insere uma linha na DW mestre
dw_1.Event pfc_AddRow()

// Coloca o foco na DW mestre
dw_1.SetFocus()

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de inclus$$HEX1$$e300$$ENDHEX$$o
ivm_Menu_Janela.m_Editar.m_Incluir.Enabled = True

end event

event cancelar;call super::cancelar;dw_1.Reset()
dw_1.Event pfc_AddRow()

dw_2.Reset()
end event

type dw_1 from u_dw within w_cadastro_nf
int X=32
int Y=28
int Width=1774
int Height=376
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event pfc_preinsertrow;call super::pfc_preinsertrow;Integer lvi_Retorno

// Verifica se houve altera$$HEX2$$e700e300$$ENDHEX$$o
lvi_Retorno = wf_Consiste_Salva()

If lvi_Retorno = 1 Then 
	This.Reset()
	dw_2.Reset()
End If

Return lvi_Retorno
end event

type dw_2 from u_dw within w_cadastro_nf
int X=32
int Y=464
int Width=1774
int Height=376
int TabOrder=20
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event pfc_addrow;call super::pfc_addrow;// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de exclus$$HEX1$$e300$$ENDHEX$$o
ivm_Menu_Janela.m_Editar.m_Excluir.Enabled = True
	
Return AncestorReturnValue
end event

event constructor;call super::constructor;// Habilita a sele$$HEX2$$e700e300$$ENDHEX$$o de linhas da DW
of_SetRowSelect(True)
end event

event editchanged;call super::editchanged;ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = True
ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = True
end event

event pfc_deleterow;call super::pfc_deleterow;Integer lvi_Linha

lvi_Linha = AncestorReturnValue

If lvi_Linha > 0 Then
	If This.RowCount() = 0 Then
		ivm_Menu_Janela.m_Editar.m_ConfirmarOperacao.Enabled = False
		ivm_Menu_Janela.m_Editar.m_CancelarOperacao.Enabled = False
		ivm_Menu_Janela.m_Editar.m_Excluir.Enabled = False
	End If
End If

Return lvi_Linha
end event

