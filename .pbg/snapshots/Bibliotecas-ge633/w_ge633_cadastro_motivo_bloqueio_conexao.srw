HA$PBExportHeader$w_ge633_cadastro_motivo_bloqueio_conexao.srw
$PBExportComments$Cadastro de Cidades
forward
global type w_ge633_cadastro_motivo_bloqueio_conexao from dc_w_cadastro_lista
end type
end forward

global type w_ge633_cadastro_motivo_bloqueio_conexao from dc_w_cadastro_lista
string tag = "w_ge633_cadastro_motivo_bloqueio_conexao"
integer width = 1760
integer height = 1256
string title = "GE633 - Cadastro de Motivo Bloqueio Conex$$HEX1$$e300$$ENDHEX$$o"
end type
global w_ge633_cadastro_motivo_bloqueio_conexao w_ge633_cadastro_motivo_bloqueio_conexao

forward prototypes
public function integer wf_ultimo_codigo ()
end prototypes

public function integer wf_ultimo_codigo ();Integer lvi_Ultimo

Select Max(cd_motivo) into :lvi_Ultimo
from motivo_bloqueio_conexao
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo c$$HEX1$$f300$$ENDHEX$$digo de cidade")
		Return -1
	Case 0
	
		If IsNull(lvi_Ultimo) Then
			lvi_Ultimo = 0 		
		End If	
End Choose

Return lvi_Ultimo
end function

on w_ge633_cadastro_motivo_bloqueio_conexao.create
call super::create
end on

on w_ge633_cadastro_motivo_bloqueio_conexao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;String ls_operador

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE633_CADASTRO_MOTIVO_BLOQUEIO_CONEXAO", ref ls_Operador) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o liberado, Solicitar o Acesso!")
	Close(This)
	Return
End If

gvo_Aplicacao.ivo_Seguranca.of_Localiza_Usuario(ls_Operador)

ivm_Menu.mf_SalvarComo(True)
end event

event ue_presave;call super::ue_presave;Long ll_linha

String ls_de_motivo 


dw_1.AcceptText()


If dw_1.RowCount() > 0 Then
	For ll_linha = 1 To dw_1.RowCount()
		ls_de_motivo = dw_1.Object.de_motivo 	[ll_linha]
		
		If Isnull(ls_de_motivo) Or ls_de_motivo = " " Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor inserir um texto", Exclamation!)
			Return false
		End If
	Next
End If	

Return True
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge633_cadastro_motivo_bloqueio_conexao
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge633_cadastro_motivo_bloqueio_conexao
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge633_cadastro_motivo_bloqueio_conexao
integer x = 50
integer y = 56
integer width = 1595
integer height = 944
string dataobject = "dw_ge633_lista"
boolean ivb_ordena_colunas = true
end type

event dw_1::ue_preupdate;call super::ue_preupdate;Integer lvi_Proximo_Codigo

Long  lvl_Linha, &
      lvl_Total

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de linhas da DW
lvl_Total = This.RowCount()

// Localiza a primeira linha sem c$$HEX1$$f300$$ENDHEX$$digo
lvl_Linha = This.Find("isnull(cd_motivo)", 0, lvl_Total)

lvi_Proximo_Codigo = wf_Ultimo_Codigo()

If lvi_Proximo_Codigo = -1 Then Return -1
	
// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While lvl_Linha > 0
	lvi_Proximo_Codigo ++
	
	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.cd_motivo[lvl_Linha] = lvi_Proximo_Codigo
	
	lvl_Linha = This.Find("isnull(cd_motivo)", lvl_Linha, lvl_Total)
Loop

Return 1
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge633_cadastro_motivo_bloqueio_conexao
integer x = 14
integer y = 0
integer width = 1673
integer height = 1028
end type

