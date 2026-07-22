HA$PBExportHeader$w_ge148_consulta_produto_ativo_bloqueado.srw
forward
global type w_ge148_consulta_produto_ativo_bloqueado from dc_w_consulta_lista
end type
type cb_arquivo from commandbutton within w_ge148_consulta_produto_ativo_bloqueado
end type
type dw_2 from dc_uo_dw_base within w_ge148_consulta_produto_ativo_bloqueado
end type
end forward

global type w_ge148_consulta_produto_ativo_bloqueado from dc_w_consulta_lista
string tag = "w_ge148_consulta_produto_ativo_bloqueado"
integer width = 3625
integer height = 1904
string title = "GE148 - Consulta de Produtos Ativos e Bloqueados"
long backcolor = 80269524
cb_arquivo cb_arquivo
dw_2 dw_2
end type
global w_ge148_consulta_produto_ativo_bloqueado w_ge148_consulta_produto_ativo_bloqueado

on w_ge148_consulta_produto_ativo_bloqueado.create
int iCurrent
call super::create
this.cb_arquivo=create cb_arquivo
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_arquivo
this.Control[iCurrent+2]=this.dw_2
end on

on w_ge148_consulta_produto_ativo_bloqueado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_arquivo)
destroy(this.dw_2)
end on

event ue_postopen;//OverRide

ivo_dbError = Create dc_uo_dbError

This.ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Event ue_Retrieve()
dw_1.SetFocus()

//This.ivm_Menu.mf_Recuperar(True)


end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

type dw_visual from dc_w_consulta_lista`dw_visual within w_ge148_consulta_produto_ativo_bloqueado
end type

type gb_aux_visual from dc_w_consulta_lista`gb_aux_visual within w_ge148_consulta_produto_ativo_bloqueado
end type

type dw_1 from dc_w_consulta_lista`dw_1 within w_ge148_consulta_produto_ativo_bloqueado
integer x = 41
integer y = 84
integer width = 3506
integer height = 1480
string dataobject = "dw_ge148_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_1::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]

lvs_Coluna = {"cd_produto", "de_subgrupo_produto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "SubGrupo"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.ShareData(dw_2)

This.of_SetRowSelection()
end event

event dw_1::ue_recuperar;// OverRide

Date lvdt_Movimento 

lvdt_Movimento = Date(gvo_Parametro.of_dh_movimentacao())

Return This.Retrieve(lvdt_Movimento)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Parent.ivm_Menu.mf_Imprimir(pl_Linhas > 0)
Parent.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)
cb_arquivo.Enabled = (pl_Linhas > 0)

Return pl_Linhas
end event

event dw_1::ue_printimmediate;// OverRide
dw_2.Event ue_PrintImmediate()
end event

event dw_1::ue_reset;call super::ue_reset;Parent.ivm_Menu.mf_Imprimir(False)
Parent.ivm_Menu.mf_SalvarComo(False)
end event

event dw_1::ue_print;call super::ue_print;// OverRide
dw_2.Event ue_Print()
end event

type gb_1 from dc_w_consulta_lista`gb_1 within w_ge148_consulta_produto_ativo_bloqueado
integer x = 14
integer width = 3552
integer height = 1572
integer weight = 700
string facename = "Verdana"
long backcolor = 80269524
string text = "Lista de Produtos"
end type

type cb_arquivo from commandbutton within w_ge148_consulta_produto_ativo_bloqueado
integer x = 2839
integer y = 1604
integer width = 727
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Salvar em arquivo texto"
end type

event clicked;String  lvs_nm_arquivo   , &
        lvs_nm_diretorio , &
		  lvs_diretorio_arquivo

Integer lvi_arquivo      , & 
		  lvi_diretorio

// Pede o nome do diret$$HEX1$$f300$$ENDHEX$$rio
lvi_diretorio = GetFileSaveName("Selecione o caminho do arquivo",lvs_nm_diretorio,&
                lvs_nm_arquivo, "TXT", "Arquivo do Texto (*.TXT),*.TXT,")

// Verifica se a escolha do arquivo deu certo
If lvi_diretorio = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!, Ok!)
	Return 
// verifica se o usu$$HEX1$$e100$$ENDHEX$$rio cancelou a opera$$HEX2$$e700e300$$ENDHEX$$o	
ElseIf lvi_diretorio = 0 Then
	Return
End If

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_nm_arquivo) Then
	If MessageBox("Salvar", "OK para substituir ? " + lvs_diretorio_arquivo, Question!, &
	              OKCancel!) = 1 then 
		FileDelete(lvs_diretorio_arquivo)
	Else
		Return 
   End If   
End If


// Sava em formato Texto
lvi_arquivo = dw_1.SaveAs(lvs_nm_arquivo, Text!, FALSE)

If lvi_arquivo <> 1 Then
	messagebox("ERRO", "Erro ao salvar arquivo. C$$HEX1$$f300$$ENDHEX$$digo: "&
	           + String(SqlCa.SqlCode) + " - " + SqlCa.SqlErrText, StopSign!,Ok!)	
	Return 
End If

end event

type dw_2 from dc_uo_dw_base within w_ge148_consulta_produto_ativo_bloqueado
boolean visible = false
integer x = 2213
integer y = 748
integer width = 594
integer height = 240
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge148_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

