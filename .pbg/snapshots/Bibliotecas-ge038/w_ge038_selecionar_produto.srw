HA$PBExportHeader$w_ge038_selecionar_produto.srw
forward
global type w_ge038_selecionar_produto from dc_w_selecao_lista_relatorio
end type
type cb_parcial from commandbutton within w_ge038_selecionar_produto
end type
type cb_cancelar from commandbutton within w_ge038_selecionar_produto
end type
type cb_adicionar from commandbutton within w_ge038_selecionar_produto
end type
type cb_remover from commandbutton within w_ge038_selecionar_produto
end type
type cb_total from commandbutton within w_ge038_selecionar_produto
end type
end forward

global type w_ge038_selecionar_produto from dc_w_selecao_lista_relatorio
integer width = 2427
integer height = 1624
string title = "GE038 - Gera$$HEX2$$e700e300$$ENDHEX$$o Arquivo Tabela Produto PAF-ECF"
boolean minbox = false
boolean resizable = false
cb_parcial cb_parcial
cb_cancelar cb_cancelar
cb_adicionar cb_adicionar
cb_remover cb_remover
cb_total cb_total
end type
global w_ge038_selecionar_produto w_ge038_selecionar_produto

type variables
uo_Produto ivo_Produto
end variables

forward prototypes
public function boolean wf_movimento_estoque (date pd_data, string pl_produto, ref long pl_quantidade)
end prototypes

public function boolean wf_movimento_estoque (date pd_data, string pl_produto, ref long pl_quantidade);select sum(qt_movimento) 
	into :pl_quantidade
from movimento_estoque
where dh_movimento >= :pd_data
  and cd_tipo_movimento = 1
  and cd_produto = :pl_produto
//  and de_especie = 'CF'
//  and de_serie = 'ECF'
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o quantidade mov. estoque.')
	Return False
End If

//Sen$$HEX1$$e300$$ENDHEX$$o achou busca a ultima nota de dia anterior ao atual.
If IsNull(pl_quantidade) Then
	pl_quantidade = 0
End If

Return True
end function

on w_ge038_selecionar_produto.create
int iCurrent
call super::create
this.cb_parcial=create cb_parcial
this.cb_cancelar=create cb_cancelar
this.cb_adicionar=create cb_adicionar
this.cb_remover=create cb_remover
this.cb_total=create cb_total
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_parcial
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_adicionar
this.Control[iCurrent+4]=this.cb_remover
this.Control[iCurrent+5]=this.cb_total
end on

on w_ge038_selecionar_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_parcial)
destroy(this.cb_cancelar)
destroy(this.cb_adicionar)
destroy(this.cb_remover)
destroy(this.cb_total)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto

ivo_Produto.of_Inicializa()
end event

event close;call super::close;Destroy(ivo_Produto)
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge038_selecionar_produto
integer y = 224
integer width = 2304
integer height = 1048
integer weight = 700
string facename = "Verdana"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge038_selecionar_produto
integer width = 1929
integer height = 200
integer weight = 700
string facename = "Verdana"
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge038_selecionar_produto
integer x = 64
integer width = 1856
integer height = 108
string dataobject = "dw_ge038_selecao_produto"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If key = keyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "de_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.localizado Then
			dw_1.Object.de_produto[1] = ivo_Produto.de_produto
			dw_1.Object.cd_produto[1] = ivo_Produto.cd_produto
		End If
	End If
	
End If
end event

event dw_1::editchanged;//Override
end event

event dw_1::itemchanged;//Override
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge038_selecionar_produto
integer y = 300
integer width = 2249
integer height = 956
string dataobject = "dw_ge038_pafecf_estoque"
end type

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge038_selecionar_produto
integer x = 2633
integer y = 128
end type

type cb_parcial from commandbutton within w_ge038_selecionar_produto
integer x = 581
integer y = 1304
integer width = 594
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "ESTOQUE &PARCIAL"
end type

event clicked;Boolean lb_Sucesso
Boolean lb_Evidenciado = False

Long ll_File
Long ll_Row
Long ll_ecf
Long ll_Movimentado

String ls_Unidade
String ls_Estoque
String ls_Sinal
String ls_Arquivo_Evidenciado
String ls_Razao_Social
String ls_Tipo
String ls_Marca
String ls_Modelo
String ls_Insc_estadual

DateTime ldh_Data_Estoque
DateTime	ldh_Data_Movimento

String ls_File = 'C:\Sistemas\CL\Arquivos\PAF-ECF\tabela-estoque-parcial.txt'

FileDelete(ls_File)

uo_Menu_Fiscal lvo_Menu
lvo_Menu = Create uo_Menu_Fiscal

PDV.Of_Modo_Impressora()

PDV.of_nr_ecf(ll_ecf)

dw_2.accepttext()

If Not lvo_Menu.of_Carrega_dados_ecf(ll_ecf) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados da ECF.",StopSign!)
	lb_Sucesso = False
	Return
End If

lvo_Menu.of_data_primeira_venda(ldh_Data_Estoque,ll_ecf)

ll_File = FileOpen(ls_File, LineMode!, Write!, LockWrite!, Append!)

If lvo_Menu.of_inconsistencia_inclusao_exclusao() Then		
	ls_Razao_Social = gf_Replace(gvo_parametro.nm_razao_social, " ", "?", 0) + FillA("?", 50)
Else
	ls_Razao_Social = gvo_parametro.nm_razao_social + Space(50)
End If

If IsNull(lvo_Menu.de_Tipo) Then 
	ls_Tipo += Space(07)
Else				 
	ls_Tipo += LeftA(lvo_Menu.de_Tipo + Space(07) , 07 )
End If

If IsNull(lvo_Menu.de_Marca) Then
	ls_Marca += Space(20)
Else	
	ls_Marca += LeftA(lvo_Menu.de_Marca + Space(20) , 20 )
End If

//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
If lvo_Menu.of_inconsistencia_impressora_fiscal(ll_ecf) Then					
	ls_Modelo = FillA("?", 20)
	ls_Modelo = gf_Replace(LeftA( lvo_Menu.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
	lb_Evidenciado = True			
Else
	ls_Modelo += LeftA(lvo_Menu.de_Modelo + Space(20) , 20 )
End If


/*If IsNull(lvo_Menu.de_Modelo) Then 
	ls_Modelo += Space(20)
Else				 
	ls_Modelo += Left(lvo_Menu.de_Modelo + Space(20) , 20 )
End If*/

If IsNull(ldh_Data_Estoque) Then
//	ldh_Data_Estoque = ()
End If

ls_Insc_Estadual = gf_replace(gvo_parametro.nr_inscricao_estadual,'.','',0)

//Buscar data e horas corretas.
If FileWrite(ll_File,'E1' + &
                      LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
							 LeftA(ls_Insc_Estadual+Space(14),14) + &
							 Space(14) + &
							 LeftA(ls_Razao_Social, 50) + &
							 LeftA(lvo_Menu.nr_Serie + Space(20),20) + &
							 LeftA(lvo_Menu.id_MfAdicional, 1) + &
							 ls_Tipo + ls_Marca + ls_Modelo + &
							 String(ldh_Data_Estoque,'yyyymmdd') + & 
							 String(ldh_Data_Estoque,'hhmmss')) <> -1 Then
							 
	Open(w_Aguarde)
	w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())
	
	For ll_Row = 1 To dw_2.RowCount()
		
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
		
		//Verifica se teve movimentacao de estoque no dia para calcular o saldo
		ldh_Data_Movimento = dw_2.object.dh_ultima_venda[ll_row]
		If Date(ldh_Data_Estoque) = Date(ldh_Data_Movimento) Then
			If wf_movimento_estoque(Date(ldh_Data_Estoque),String(dw_2.object.cd_produto[ll_row],'000000'),ll_Movimentado) Then
				ls_Estoque = Trim(String(dw_2.object.qt_saldo_final[ll_row] + ll_Movimentado))
			End If
		Else		
			ls_Estoque = Trim(String(dw_2.object.qt_saldo_final[ll_row]))
		End If
		
		If Dec(ls_Estoque) < 0 Then
			ls_Estoque = gf_Replace(ls_Estoque,"-","0",0)
			ls_Sinal = "-"
		Else
			ls_Sinal = "+"
		End If
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If lvo_Menu.of_inconsistencia_produto_geral(dw_2.object.cd_produto[ll_row]) Then
			ls_Unidade = FillA("?", 6)
			lb_Evidenciado = True			
		ElseIf lvo_Menu.of_inconsistencia_saldo_produto(dw_2.object.cd_produto[ll_row], Today(), False, 0) Then
			ls_Unidade = FillA("?", 6)
			lb_Evidenciado = True
		End If		
				
		If FileWrite(ll_File,'E2' + &
                      LeftA(gvo_parametro.nr_cgc + Space(14) ,14) + &
							 LeftA(String(dw_2.object.cd_produto[ll_row],'000000') + Space(14) ,14) + &
							 LeftA(dw_2.object.de_produto[ll_row] + Space(50) ,50) + &
							 LeftA(dw_2.object.cd_un[ll_row] + ls_Unidade ,06) + &
							 ls_Sinal + &
							 RightA('000000000'+ ls_Estoque,09)) = -1 Then
							 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E2 da tabela produto.",StopSign!)
			lb_Sucesso = False
			Exit	
		Else
			lb_Sucesso = True
				
		End If
		
	Next
	
	If lb_Sucesso Then
		
		If FileWrite(ll_File,'E9' + &
							 LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
							 LeftA(ls_Insc_Estadual+Space(14),14) + &
							 String(dw_2.RowCount(),'000000') ) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E9 da tabela produto.",StopSign!)
			
		Else
			
			If IsValid(w_Aguarde) Then Close(w_Aguarde)
			
			FileClose(ll_File)
			
			If lb_Evidenciado Then
				ls_Arquivo_Evidenciado = MidA(ls_File, 1, LenA(ls_File) - 4) + "_evid_" + String(Today(),"DDMMYYhhmmss") + ".txt"
				If lvo_Menu.of_Renomeia_Arquivo(ls_File, ls_Arquivo_Evidenciado, True) Then	
					ls_File = ls_Arquivo_Evidenciado
				Else
					lb_Sucesso = False
				End If
			End If 
			
			If lvo_Menu.of_Assinatura_Digital(ls_File) Then
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
					Run('Notepad.exe ' + ls_File )
				End If
			End If	
			
		End If
		
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E1 da tabela produto.",StopSign!)
End If	

FileClose(ll_File)
Destroy(lvo_Menu)

If IsValid(w_Aguarde) Then Close(w_Aguarde)			
end event

type cb_cancelar from commandbutton within w_ge038_selecionar_produto
integer x = 2016
integer y = 1308
integer width = 325
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;Close(Parent)
end event

type cb_adicionar from commandbutton within w_ge038_selecionar_produto
integer x = 2016
integer y = 76
integer width = 325
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Adicionar"
end type

event clicked;Long lvl_Saldo
Long lvl_Linha

DateTime lvdh_Periodo
DateTime lvdh_Movimento

If IsNull(ivo_Produto.cd_produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Localize um produto antes de adicionar.")
	dw_1.SetFocus()
	Return -1
End If


lvl_Linha = dw_2.Find("cd_produto = " + String(ivo_Produto.cd_produto), 1, dw_2.RowCount())

If lvl_Linha = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao tentar localizar o produto.")
	Return -1
ElseIf lvl_Linha > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto j$$HEX1$$e100$$ENDHEX$$ foi adicionado.")
	ivo_Produto.of_Inicializa()
	dw_1.Object.cd_produto[1] = ivo_Produto.cd_produto
	dw_1.Object.de_produto[1] = ivo_Produto.de_produto	
	dw_1.SetFocus()
	Return -1
End If

lvdh_Periodo = DateTime(Date(String(Today(), "01/MM/YYYY")))

Select saldo_produto.qt_saldo_final, produto_loja.dh_ultima_venda
  Into :lvl_Saldo, :lvdh_Movimento
  From saldo_produto, produto_loja
 Where saldo_produto.cd_produto = :ivo_Produto.cd_produto
   and saldo_produto.cd_produto = produto_loja.cd_produto
   and saldo_produto.dh_saldo >=  :lvdh_Periodo
 Using SQLCa;
 
 If SQLCA.SQLCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o saldo do produto")
	dw_1.SetFocus()
	Return -1
 End If

lvl_Linha = dw_2.InsertRow(0)

dw_2.Object.cd_produto		[lvl_Linha] = ivo_Produto.cd_produto
dw_2.Object.de_produto		[lvl_Linha] = ivo_Produto.de_produto
dw_2.Object.cd_un				[lvl_Linha] = ivo_Produto.Cd_Unidade_Medida_Venda
dw_2.Object.qt_saldo_final	[lvl_Linha] = lvl_saldo
dw_2.Object.dh_ultima_venda[lvl_Linha] = lvdh_Movimento

dw_2.Sort()

ivo_Produto.of_Inicializa()

dw_1.Object.cd_produto[1] = ivo_Produto.cd_produto
dw_1.Object.de_produto[1] = ivo_Produto.de_produto

dw_1.SetFocus()

end event

type cb_remover from commandbutton within w_ge038_selecionar_produto
integer x = 37
integer y = 1300
integer width = 325
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Remover"
end type

event clicked;If dw_2.RowCount() > 0 Then
	dw_2.DeleteRow(dw_2.GetRow())
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto para remover.")
End If
end event

type cb_total from commandbutton within w_ge038_selecionar_produto
integer x = 1193
integer y = 1304
integer width = 594
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "ESTOQUE &TOTAL"
end type

event clicked;Boolean lb_Sucesso
Boolean lb_Evidenciado = False

Long ll_File
Long ll_Row
Long ll_ecf
Long ll_Movimentado

String ls_Unidade
String ls_Estoque
String ls_Sinal
String ls_Razao_Social
String ls_Tipo
String ls_Marca
String ls_Modelo
String ls_Insc_Estadual

DateTime ldh_Data_Estoque
DateTime	ldh_Data_Movimento

String ls_File = 'C:\Sistemas\CL\Arquivos\PAF-ECF\tabela-estoque-total.txt'

String ls_Arquivo_Evidenciado

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

uo_Menu_Fiscal lvo_Menu
lvo_Menu = Create uo_Menu_Fiscal

PDV.Of_Modo_Impressora()

PDV.of_nr_ecf(ll_ecf)

If Not lvo_Menu.of_Carrega_dados_ecf(ll_ecf) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados da ECF.",StopSign!)
	lb_Sucesso = False
	Return
End If

lvo_Menu.of_data_primeira_venda(ldh_Data_Estoque, ll_ecf)

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_estoque') Then 
	Destroy(lvo_Menu)
	Return
End If

lvds_1.Retrieve()

FileDelete(ls_File)

ll_File = FileOpen(ls_File, LineMode!, Write!, LockWrite!, Append!)

If lvo_Menu.of_inconsistencia_inclusao_exclusao() Then		
	ls_Razao_Social = gf_Replace(gvo_parametro.nm_razao_social, " ", "?", 0) + FillA("?", 50)
Else
	ls_Razao_Social = gvo_parametro.nm_razao_social + Space(50)
End If

If IsNull(lvo_Menu.de_Tipo) Then 
	ls_Tipo += Space(07)
Else				 
	ls_Tipo += LeftA(lvo_Menu.de_Tipo + Space(07) , 07 )
End If

If IsNull(lvo_Menu.de_Marca) Then
	ls_Marca += Space(20)
Else	
	ls_Marca += LeftA(lvo_Menu.de_Marca + Space(20) , 20 )
End If

//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
If lvo_Menu.of_inconsistencia_impressora_fiscal(ll_ecf) Then					
	ls_Modelo = FillA("?", 20)
	ls_Modelo = gf_Replace(LeftA( lvo_Menu.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
	lb_Evidenciado = True			
Else
	ls_Modelo += LeftA(lvo_Menu.de_Modelo + Space(20) , 20 )
End If

/*If IsNull(lvo_Menu.de_Modelo) Then 
	ls_Modelo += Space(20)
Else				 
	ls_Modelo += Left(lvo_Menu.de_Modelo + Space(20) , 20 )
End If*/

If IsNull(ldh_Data_Estoque) Then
//	ldh_Data_Estoque = ()
End If

ls_Insc_Estadual = gf_replace(gvo_parametro.nr_inscricao_estadual,'.','',0)

If FileWrite(ll_File,'E1' + &
                      LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
							 LeftA(ls_Insc_Estadual+Space(14),14) + &
							 Space(14) + &
							 LeftA(ls_Razao_Social, 50) + &
							 LeftA(lvo_Menu.nr_Serie + Space(20),20) + &
							 LeftA(lvo_Menu.id_MfAdicional, 1) + &
							 ls_Tipo + ls_Marca + ls_Modelo + &
							 String(ldh_Data_Estoque,'yyyymmdd') + & 
							 String(ldh_Data_Estoque,'hhmmss')) <> -1 Then
							 
	Open(w_Aguarde)
	w_Aguarde.uo_Progress.of_SetMax(lvds_1.RowCount())
	
	For ll_Row = 1 To lvds_1.RowCount()
		
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
		
		ldh_Data_Movimento = lvds_1.object.dh_ultima_venda[ll_row]
		If Date(ldh_Data_Estoque) = Date(ldh_Data_Movimento) Then
			If wf_movimento_estoque(Date(ldh_Data_Estoque),String(lvds_1.object.cd_produto[ll_row],'000000'),ll_Movimentado) Then
				ls_Estoque = Trim(String(lvds_1.object.qt_saldo_final[ll_row] + ll_Movimentado))
			End If
		Else		
			ls_Estoque = Trim(String(lvds_1.object.qt_saldo_final[ll_row]))
		End If
		
		If Dec(ls_Estoque) < 0 Then
			ls_Estoque = gf_Replace(ls_Estoque,"-","0",0)
			ls_Sinal = "-"
		Else
			ls_Sinal = "+"
		End If
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
				
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If lvo_Menu.of_inconsistencia_produto_geral(lvds_1.object.cd_produto[ll_row]) Then
			ls_Unidade = FillA("?", 6)
			lb_Evidenciado = True
		ElseIf lvo_Menu.of_inconsistencia_saldo_produto(lvds_1.object.cd_produto[ll_row], Today(), False, 0) Then
			ls_Unidade = FillA("?", 6)
			lb_Evidenciado = True
		End If		
		
		If FileWrite(ll_File,'E2' + &
                      LeftA(gvo_parametro.nr_cgc + Space(14) ,14) + &
							 LeftA(String(lvds_1.object.cd_produto[ll_row],'000000') + Space(14) ,14) + &
							 LeftA(lvds_1.object.de_produto[ll_row] + Space(50) ,50) + &
							 LeftA(lvds_1.object.cd_un[ll_row] + ls_Unidade ,06) + &
							 ls_Sinal + &
							 RightA('000000000'+ ls_Estoque,09)) = -1 Then
							 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E2 da tabela produto.",StopSign!)
			lb_Sucesso = False
			Exit	
		Else
			lb_Sucesso = True
				
		End If
		
	Next
	
	If lb_Sucesso Then
		
		If FileWrite(ll_File,'E9' + &
							 LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
							 LeftA(ls_Insc_Estadual+Space(14),14) + &
							 String(lvds_1.RowCount(),'000000') ) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E9 da tabela produto.",StopSign!)
			
		Else
			
			If IsValid(w_Aguarde) Then Close(w_Aguarde)
			
			FileClose(ll_File)
			
			If lb_Evidenciado Then
				ls_Arquivo_Evidenciado = MidA(ls_File, 1, LenA(ls_File) - 4) + "_evid_" + String(Today(),"DDMMYYhhmmss") + ".txt"
				If lvo_Menu.of_Renomeia_Arquivo(ls_File, ls_Arquivo_Evidenciado, True) Then	
					ls_File = ls_Arquivo_Evidenciado
				Else
					lb_Sucesso = False
				End If
			End If 
			
			If lvo_Menu.of_Assinatura_Digital(ls_File) Then
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo gerado com sucesso no diret$$HEX1$$f300$$ENDHEX$$rio: '" + ls_File + "'.~r~rVisualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
					Run('Notepad.exe ' + ls_File )
				End If
			End If	
			
			
		End If
		
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E1 da tabela produto.",StopSign!)
End If	

FileClose(ll_File)
Destroy(lvo_Menu)

If IsValid(w_Aguarde) Then Close(w_Aguarde)			

Destroy(lvds_1)
end event

