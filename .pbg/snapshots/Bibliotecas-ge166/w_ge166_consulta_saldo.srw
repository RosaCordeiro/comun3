HA$PBExportHeader$w_ge166_consulta_saldo.srw
forward
global type w_ge166_consulta_saldo from dc_w_selecao_lista_detalhe
end type
type cb_1 from commandbutton within w_ge166_consulta_saldo
end type
end forward

global type w_ge166_consulta_saldo from dc_w_selecao_lista_detalhe
integer width = 2537
integer height = 2000
string title = "GE166 - Consulta saldo de produtos"
boolean minbox = false
boolean resizable = false
cb_1 cb_1
end type
global w_ge166_consulta_saldo w_ge166_consulta_saldo

type variables
uo_produto ivo_produto
end variables

forward prototypes
public subroutine wf_localiza_produto ()
end prototypes

public subroutine wf_localiza_produto ();String  lvs_Produto

Long    lvl_Find,&
		  lvl_Linha
		  
SetPointer(HourGlass!)		  
		  
lvs_Produto = Trim(dw_1.GetText())

ivo_Produto.of_localiza_produto(lvs_produto,false)

SetPointer(Arrow!)

If ivo_Produto.Localizado Then
	
	dw_1.Object.cd_produto[1] = ivo_Produto.cd_produto
	
	// Produto almoxarifado
	If Mid(ivo_Produto.cd_subcategoria, 1,1) = '5' Then
		dw_1.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	Else
		dw_1.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
	End If	
								
	//Habilita menu para faturamento
	ivm_Menu.mf_Recuperar(True)
	ivm_Menu.mf_salvarcomo(True)
	
	//Carrega saldos do produto
	dw_2.Event ue_Recuperar()
	dw_2.SetFocus()
	
	lvl_Linha = dw_2.rowcount( )
	If lvl_Linha  >0  Then 
		cb_1.Enabled =True		
		ivm_Menu.mf_salvarcomo(True)	
	Else
		cb_1.Enabled =False
		ivm_Menu.mf_salvarcomo(False)
	End If 
Else	
	Beep(10)
	Beep(10)
	Beep(10)
	cb_1.Enabled =False
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.",Exclamation!)
	
End If
end subroutine

on w_ge166_consulta_saldo.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge166_consulta_saldo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto


ivm_Menu.mf_Recuperar(True)
ivm_Menu.mf_salvarcomo(True)
ivm_Menu.mf_imprimir(True)	

cb_1.Enabled =False

end event

event close;call super::close;Destroy(ivo_Produto)
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge166_consulta_saldo
integer y = 1328
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge166_consulta_saldo
integer y = 1256
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge166_consulta_saldo
boolean visible = false
integer y = 1168
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge166_consulta_saldo
integer width = 2231
integer height = 244
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge166_consulta_saldo
integer y = 300
integer width = 2464
integer height = 1416
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge166_consulta_saldo
integer x = 64
integer y = 68
integer width = 2171
integer height = 172
string dataobject = "dw_ge166_selecao"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna
lvs_Coluna = This.GetColumnName()

Choose Case lvs_Coluna
	Case "de_produto"
		If Key = KeyEnter! Then wf_localiza_produto()
End Choose



end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge166_consulta_saldo
integer y = 356
integer width = 2409
integer height = 1344
string dataobject = "dw_ge166_saldo_produto_filiais"
end type

event dw_2::ue_recuperar;//OVERRIDE

Long lvl_Produto

String ls_CD

dw_1.AcceptText()

lvl_Produto 	= dw_1.Object.cd_produto	[1]
ls_CD 		= dw_1.Object.id_cd			[1]

This.of_RestoreOriginalSql()

// Produto almoxarifado
If Mid(ivo_Produto.cd_subcategoria, 1,1) = '5' Then
	This.of_AppendWhere("filial.id_centro_distribuicao = 'S'")
End If

If ls_CD = 'S' Then
	This.of_AppendWhere("(filial.id_centro_distribuicao = 'S' or vw_saldo_atual_produto.cd_filial in (1))")
End If

This.Retrieve(lvl_Produto)

Return This.RowCount()
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("", "if( id_estoque_central  = ~"S~", RGB(255,0, 0), RGB(0,0,0))")

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas  > 0 Then 
	ivm_Menu.mf_salvarcomo(True)
	ivm_Menu.mf_imprimir(True)
Else
	ivm_Menu.mf_salvarcomo(False)
	ivm_Menu.mf_imprimir(False)
End If 

If pl_Linhas > 0 Then 
	cb_1.Enabled =True
Else
	cb_1.Enabled =False
End If 	

Return pl_linhas
end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge166_consulta_saldo
boolean visible = false
integer y = 1236
end type

event dw_3::ue_recuperar;//OVERRIDE

Return 1
end event

type cb_1 from commandbutton within w_ge166_consulta_saldo
integer x = 32
integer y = 1720
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string text = "Imprimir"
end type

event clicked;Long  ll_Linhas

ll_Linhas = dw_2.rowcount( )

If ll_Linhas  > 0 Then 
	If PrintSetup() = -1 Then
		MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
		Return 1
	End If
	dw_2.print( )
	MessageBox("Aviso", "Impres$$HEX1$$e300$$ENDHEX$$o com Sucesso!")
Else
	MessageBox("Aviso", "Sem Registros para Impress$$HEX1$$e300$$ENDHEX$$o!")	
End If 

Return 1

end event

