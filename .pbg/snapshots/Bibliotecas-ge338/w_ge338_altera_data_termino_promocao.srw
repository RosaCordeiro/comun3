HA$PBExportHeader$w_ge338_altera_data_termino_promocao.srw
forward
global type w_ge338_altera_data_termino_promocao from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge338_altera_data_termino_promocao
end type
end forward

global type w_ge338_altera_data_termino_promocao from dc_w_cadastro_selecao_lista
integer width = 3054
integer height = 1776
string title = "GE338 - Altera Data de T$$HEX1$$e900$$ENDHEX$$rmino de Promo$$HEX2$$e700e300$$ENDHEX$$o"
cb_1 cb_1
end type
global w_ge338_altera_data_termino_promocao w_ge338_altera_data_termino_promocao

type variables
uo_Promocao io_Promocao

Boolean ivb_Check

DateTime idh_Atual
end variables

forward prototypes
public function boolean wf_le_dados_planilha (boolean ab_mostra_mensagem)
end prototypes

public function boolean wf_le_dados_planilha (boolean ab_mostra_mensagem);Any la_Dado

DateTime ldh_Termino_Novo
DateTime ldh_Termino

Long ll_Linha
Long ll_Linhas
Long ll_Promocao
Long ll_Find
Long ll_Linha_Dw = 0
String   lvs_Cd_promocao_sap

String ls_Arquivo


dw_1.AcceptText()

If Not gf_Data_Parametro(Ref idh_Atual) Then
	Return False
End If

dc_uo_excel lo_Excel
lo_Excel = Create dc_uo_excel

ls_Arquivo = dw_1.Object.De_Arquivo[1]

Open(w_Aguarde)
w_Aguarde.Title = "Importando o arquivo..."

SetRedraw(False)

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
	
	// C$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
					
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			If Not IsNumber(String(la_Dado)) Then
				If ab_Mostra_Mensagem Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo '" + String(la_Dado) + "' da promo$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido.")
				End If
				
				Continue
			End If
			
			ll_Find = dw_2.Find("cd_promocao_sos = " + String(la_Dado), 1, dw_2.RowCount())
			
			If ll_Find > 0 Then
				If ab_Mostra_Mensagem Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(la_Dado) + "' foi informada mais de uma vez na planilha." + &
									"~rSomente o primeiro registro ser$$HEX1$$e100$$ENDHEX$$ considerado.", Exclamation!)
				End If
				
				Continue
			End If
	
			ll_Promocao = Long(la_Dado)
		
			io_Promocao.of_Localiza_Codigo(ll_Promocao)
			
			If Not io_Promocao.Localizado Then
				If ab_Mostra_Mensagem Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(ll_Promocao) + "'.", Exclamation!)
				End If
				
				Continue
			End If
			
			// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
			If gf_promocao_sap ( ll_Promocao  ,  lvs_Cd_promocao_sap ) Then 
	 		    If Long(lvs_Cd_promocao_sap) > 0  Then 					
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(la_Dado) + "' foi cadastrada no SAP." + &
								"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
					Continue	
				End If 
			End If 
			
						
			//Nova data de t$$HEX1$$e900$$ENDHEX$$rmino que $$HEX1$$e900$$ENDHEX$$ informada na planilha
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
					
			If Not IsDate(String(Date(la_Dado))) Then
				If ab_Mostra_Mensagem Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino '" + String(la_Dado) + "' da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(ll_Promocao) + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.~rRegistro n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na tela.", Exclamation!)
				End If
				
				Continue
			End If
			
			ldh_Termino_Novo = DateTime(la_Dado)
					
			ll_Linha_Dw++
			dw_2.Object.Cd_Promocao_Sos				[ll_Linha_Dw] = ll_Promocao
			dw_2.Object.Nm_Promocao_Sos				[ll_Linha_Dw] = io_Promocao.Nm_Promocao
			dw_2.Object.Dh_Termino						[ll_Linha_Dw] = io_Promocao.Dh_Termino
			dw_2.Object.Dh_Termino_Novo				[ll_Linha_Dw] = ldh_Termino_Novo
			dw_2.Object.Dh_Termino_Estoque_Minimo	[ll_Linha_Dw] = io_Promocao.Dh_Termino_Estoque_Minimo
			dw_2.Object.Dh_Atual							[ll_Linha_Dw] = idh_Atual
			
			If io_Promocao.Dh_Termino < idh_Atual Then //Fora da vig$$HEX1$$ea00$$ENDHEX$$ncia
				dw_2.Object.Id_Atualiza			[ll_Linha_Dw] = "N"
				dw_2.Object.Id_Fora_Vigencia	[ll_Linha_Dw] = "S"
			ElseIf ldh_Termino_Novo < idh_Atual Then //Nova data de t$$HEX1$$e900$$ENDHEX$$rmino $$HEX1$$e900$$ENDHEX$$ menor que a data corrente
				dw_2.Object.Id_Atualiza			[ll_Linha_Dw] = "N"
				dw_2.Object.Id_Fora_Vigencia	[ll_Linha_Dw] = "N"
			Else //Passou na valida$$HEX2$$e700e300$$ENDHEX$$o
				dw_2.Object.Id_Atualiza			[ll_Linha_Dw] = "S"
				dw_2.Object.Id_Fora_Vigencia	[ll_Linha_Dw] = "N"
			End If
		Next
	End If
End If

SetRedraw(True)

dw_2.SetFocus()
dw_2.Sort()
dw_2.GroupCalc()

If IsValid(lo_Excel) Then Destroy(lo_Excel)
ivm_Menu.mf_Excluir(False)
Close(w_Aguarde)

Return True
end function

on w_ge338_altera_data_termino_promocao.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge338_altera_data_termino_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Recuperar(False)
end event

event ue_save;//OverRide

Boolean lb_Sucesso = True

DateTime ldh_Termino
DateTime ldh_Termino_Novo
DateTime ldh_Termino_Min
DateTime ldh_Est_Min_De

Long ll_Linha
Long ll_Promocao

String ls_Erro
String ls_Atualiza
String ls_Msg

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	
	ls_Atualiza = dw_2.Object.Id_Atualiza[ll_Linha]
	
	If ls_Atualiza = "S" Then
	
		ll_Promocao			= dw_2.Object.Cd_Promocao_Sos					[ll_Linha]
		ldh_Termino		= dw_2.Object.Dh_Termino							[ll_Linha]
		ldh_Termino_Novo	= dw_2.Object.Dh_Termino_Novo					[ll_Linha]
		ldh_Termino_Min 	= DateTime(RelativeDate(Date(ldh_Termino_Novo), -7))
		ldh_Est_Min_De	= dw_2.Object.Dh_Termino_Estoque_Minimo	[ll_Linha]
		
		If ldh_Termino <> ldh_Termino_Novo Then
			
			If ldh_Termino_Novo < idh_Atual Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de t$$HEX1$$e900$$ENDHEX$$rmino '" + String(Date(ldh_Termino_Novo)) + "' da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(ll_Promocao) + "' n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data corrente.", Exclamation!)
				dw_2.Event ue_Pos(ll_Linha, "dh_termino_novo")
				lb_Sucesso = False
				Exit
			End If
					
			Update promocao_sos
				Set	dh_termino = :ldh_Termino_Novo,
						dh_termino_estoque_minimo = :ldh_Termino_Min,
						nr_matricula_alteracao = :gvo_Aplicacao.ivo_Seguranca.Nr_matricula
			Where cd_promocao_sos = :ll_Promocao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_MsgdbError("Erro ao atualizar a data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(ll_Promocao) + "'." + SqlCa.SqlErrText)
				lb_Sucesso = False
				Exit
			End If
					
			If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS', String(ll_Promocao), 'DH_TERMINO', String(ldh_Termino), String(ldh_Termino_Novo), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Msg, True) Then
				lb_Sucesso = False
				Exit
			End If
			
			If ldh_Est_Min_De <> ldh_Termino_Min Then
				If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS', String(ll_Promocao), 'DH_TERMINO_ESTOQUE_MINIMO', String(ldh_Est_Min_De), String(ldh_Termino_Min), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Msg, True) Then
					lb_Sucesso = False
					Exit
				End If
			End If
		End If
	End If
Next

If lb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualizado com sucesso.")
	
	ivb_Valida_Salva = False
	ivm_Menu.mf_Cancelar(False)
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Excluir(False)
	
	dw_1.Event ue_Reset()
	dw_2.Event ue_Reset()
	
	dw_1.Event ue_AddRow()
	
	Return 1
Else
	SqlCa.of_RollBack();
	Return -1
End If
end event

event close;call super::close;Destroy(io_Promocao)
end event

event open;call super::open;io_Promocao = Create uo_Promocao
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge338_altera_data_termino_promocao
integer x = 37
integer y = 880
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge338_altera_data_termino_promocao
integer x = 0
integer y = 808
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge338_altera_data_termino_promocao
integer width = 2615
integer height = 88
string dataobject = "dw_ge338_selecao"
end type

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge338_altera_data_termino_promocao
integer y = 208
integer width = 2935
integer height = 1236
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge338_altera_data_termino_promocao
integer width = 2683
integer height = 196
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge338_altera_data_termino_promocao
integer y = 284
integer width = 2866
integer height = 1120
string dataobject = "dw_ge338_lista"
end type

event dw_2::itemchanged;call super::itemchanged;This.AcceptText()

ivb_Valida_Salva = True

If dwo.Name = "id_atualiza" Then
	If Data = 'S' Then		
		If This.Object.Dh_Termino_Novo[This.GetRow()] < idh_Atual Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "T$$HEX1$$e900$$ENDHEX$$rmino Novo n$$HEX1$$e300$$ENDHEX$$o pode ser menor do que a data corrente.", Exclamation!)
			This.Event ue_Pos(This.GetRow(), "dh_termino_novo")
			Return 1
		End If
	End If
End If
end event

event dw_2::editchanged;call super::editchanged;ivb_Valida_Salva = True
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()				
		This.Object.Id_Selecao[lvl_Row] = lvs_Marcacao		
	Next
End If
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type cb_1 from commandbutton within w_ge338_altera_data_termino_promocao
integer x = 41
integer y = 1464
integer width = 507
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Planilha"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada. Deseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then
		Return -1
	Else
		dw_2.Reset()
	End If
End If
	
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r" + &
				"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o" + &
				"~rColuna B = Data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o (DIA/M$$HEX1$$ca00$$ENDHEX$$S/ANO)"+&
				"Aten$$HEX2$$e700e300$$ENDHEX$$o:  Promocao com filial Administrada no SAP, deve ser feito no SAP!" )
				
li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	If Not wf_Le_Dados_Planilha(True) Then
		Return -1
	End If
	
	ivb_Valida_Salva = True
	ivm_Menu.mf_Cancelar(True)
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Excluir(False)
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
End If
end event

