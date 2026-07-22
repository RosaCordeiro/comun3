HA$PBExportHeader$w_ge369_importacao_arquivo.srw
forward
global type w_ge369_importacao_arquivo from dc_w_response
end type
type gb_2 from groupbox within w_ge369_importacao_arquivo
end type
type gb_1 from groupbox within w_ge369_importacao_arquivo
end type
type dw_1 from dc_uo_dw_base within w_ge369_importacao_arquivo
end type
type dw_2 from dc_uo_dw_base within w_ge369_importacao_arquivo
end type
type cb_importar_arquivo from commandbutton within w_ge369_importacao_arquivo
end type
type cb_confirmar from commandbutton within w_ge369_importacao_arquivo
end type
type cb_cancelar from commandbutton within w_ge369_importacao_arquivo
end type
end forward

global type w_ge369_importacao_arquivo from dc_w_response
integer width = 4005
integer height = 1784
string title = "GE369 - Importa$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os"
boolean controlmenu = false
long backcolor = 80269524
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_importar_arquivo cb_importar_arquivo
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
end type
global w_ge369_importacao_arquivo w_ge369_importacao_arquivo

type variables
date ivdt_parametro
end variables

forward prototypes
public function boolean wf_seleciona_arquivo (ref string as_arquivo)
public function boolean wf_existe_alteracao ()
public function boolean wf_verifica_produto_promocao (long al_produto, ref string as_bloqueio_promocao)
public function boolean wf_localiza_produto (any an_codigo, ref long al_produto, string as_uf, ref string as_descricao, ref decimal adc_preco_fabrica, ref decimal adc_preco_venda, ref string as_bloqueado_cadastro, ref string as_bloqueado_promocao, string as_log, ref string as_situacao)
public function boolean wf_verifica_produto_bloqueio_promocao (long al_produto, ref string as_bloqueio_promocao, string as_log, string al_uf)
end prototypes

public function boolean wf_seleciona_arquivo (ref string as_arquivo);String lvs_Arquivo
		 
Integer lvi_Retorno

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                     "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto(CIA) ou C$$HEX1$$f300$$ENDHEX$$digo de Barras~r"     + &
					 "Coluna B = Pre$$HEX1$$e700$$ENDHEX$$o de Reposi$$HEX2$$e700e300$$ENDHEX$$o~r")
//					 "Coluna C = Pre$$HEX1$$e700$$ENDHEX$$o de Venda~r")

lvi_Retorno = GetFileOpenName("Selecione o Arquivo", as_Arquivo, lvs_Arquivo, "XLS", "Excel (*.XLS),*.XLS,")

If lvi_Retorno = 1 Then	Return True

If lvi_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro na sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
End If

Return False
end function

public function boolean wf_existe_alteracao ();Long lvl_Linha

lvl_Linha = dw_2.Find("id_alterar = 'S'", 1, dw_2.RowCount())

If lvl_Linha > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_verifica_produto_promocao (long al_produto, ref string as_bloqueio_promocao);Long lvl_Achou

Select y.cd_produto
Into :lvl_Achou
From promocao_sos x, 
     promocao_sos_produto y,
     parametro p
Where x.dh_inicio 		   <= p.dh_movimentacao 
  and (x.dh_termino is null or x.dh_termino >= p.dh_movimentacao)
  and x.id_preco_bloqueado = 'S' 
  and x.id_situacao 	   = 'L'
  and y.cd_promocao_sos    = x.cd_promocao_sos 
  and y.cd_produto 		   = g.cd_produto
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		as_Bloqueio_Promocao = "S"
	Case 100
		as_Bloqueio_Promocao = "N"
	Case -1
		
End Choose 

Return True

end function

public function boolean wf_localiza_produto (any an_codigo, ref long al_produto, string as_uf, ref string as_descricao, ref decimal adc_preco_fabrica, ref decimal adc_preco_venda, ref string as_bloqueado_cadastro, ref string as_bloqueado_promocao, string as_log, ref string as_situacao);Boolean lvb_Sucesso = False

Long lvl_Produto 

String lvs_Barras

// Se for o c$$HEX1$$f300$$ENDHEX$$digo interno
If LenA(String(an_Codigo)) <= 6 Then
	
	lvl_Produto = Long(an_Codigo)
	
	Select g.cd_produto,
		   g.de_produto + ' : ' + g.de_apresentacao_venda,
		   u.vl_preco_reposicao,
		   u.vl_preco_venda_atual,
		   g.id_preco_bloqueado,
		  (CASE g.id_situacao
			WHEN  'A' THEN 'ATIVO'
			WHEN 'I' THEN 'INATIVO'
			WHEN 'P' THEN 'PENDENTE'
			ELSE g.id_situacao
			END) id_situacao			
	Into :al_Produto,
		 :as_Descricao,
		 :adc_Preco_Fabrica,
		 :adc_Preco_Venda,
		 :as_Bloqueado_Cadastro,
		 :as_Situacao
	From produto_geral g,
		 produto_uf u
	Where g.cd_produto = :lvl_Produto
	  and u.cd_produto = g.cd_produto
	  and u.cd_unidade_federacao = :as_UF
	Using SqlCa;
Else
	// C$$HEX1$$f300$$ENDHEX$$digo de barras
	lvs_Barras = String(an_Codigo)
	
	Select g.cd_produto,
		   g.de_produto + ' : ' + g.de_apresentacao_venda,
		   u.vl_preco_reposicao,
		   u.vl_preco_venda_atual,
		   g.id_preco_bloqueado,
		    (CASE g.id_situacao
			WHEN  'A' THEN 'ATIVO'
			WHEN 'I' THEN 'INATIVO'
			WHEN 'P' THEN 'PENDENTE'
			ELSE g.id_situacao
			END) id_situacao	
	Into :al_Produto,
		 :as_Descricao,
		 :adc_Preco_Fabrica,
		 :adc_Preco_Venda,
		 :as_Bloqueado_Cadastro,
		 :as_Situacao
	From produto_geral g,
		 produto_uf u
	Where g.cd_produto in (Select cd_produto 
						   From codigo_barras_produto
						   Where de_codigo_barras = :lvs_Barras)
	  and u.cd_produto = g.cd_produto
	  and u.cd_unidade_federacao = :as_UF
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
		// Verifica se o produto esta bloqueado em alguma promo$$HEX2$$e700e300$$ENDHEX$$o vigente
		/*Alteracao: Adicionado o par$$HEX1$$e200$$ENDHEX$$metro UF na fun$$HEX2$$e700e300$$ENDHEX$$o: 
		If wf_Verifica_Produto_Bloqueio_Promocao(al_Produto, Ref as_Bloqueado_Promocao, as_Log) Then*/
		If wf_Verifica_Produto_Bloqueio_Promocao(al_Produto, Ref as_Bloqueado_Promocao, as_Log, as_UF) Then
			lvb_Sucesso = True
		End If
	
	Case 100
		gvo_Aplicacao.of_Grava_Log(as_Log + " - Produto '" + String(an_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o localizado")
		as_Descricao = Upper("Produto '" + String(an_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o localizado")
	Case -1
		gvo_Aplicacao.of_Grava_Log(as_Log + " - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do nosso produto - " + SqlCa.SqlErrText)
End Choose

Return lvb_Sucesso
end function

public function boolean wf_verifica_produto_bloqueio_promocao (long al_produto, ref string as_bloqueio_promocao, string as_log, string al_uf);Long lvl_Achou

/* Alteracao: Substituida Consulta Abaixo pela View: vw_promocao_estoque_minimo
Select count(y.cd_produto)
Into :lvl_Achou
From promocao_sos x, 
     promocao_sos_produto y,
     parametro p     
Where x.dh_inicio 		   <= p.dh_movimentacao 
  and (x.dh_termino is null or x.dh_termino >= p.dh_movimentacao)
  and x.id_preco_bloqueado = 'S' 
  and x.id_situacao 	   = 'L'
  and y.cd_promocao_sos    = x.cd_promocao_sos 
  and y.cd_produto		   = :al_Produto
Using SqlCa;*/


select count(v.cd_produto)
Into :lvl_Achou
from vw_promocao_estoque_minimo v
where v.cd_produto = :al_Produto
and v.cd_uf = :al_UF  
and v.id_preco_bloqueado = 'S' 
and v.id_situacao = 'L'
Using SqlCa;




If SqlCa.SqlCode = - 1 Then
	gvo_Aplicacao.of_Grava_Log(as_Log + " - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do nosso produto - " + SqlCa.SqlErrText)
	Return False
End If

If Isnull(lvl_Achou) Then lvl_Achou = 0 

If lvl_Achou > 0 Then
	as_Bloqueio_Promocao = "S"
Else
	as_Bloqueio_Promocao = "N"
End If

//Choose Case SqlCa.SqlCode 
//	Case 0
//		as_Bloqueio_Promocao = "S"
//	Case 100
//		as_Bloqueio_Promocao = "N"
//	Case -1
//		gvo_Aplicacao.of_Grava_Log(as_Log + " - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do nosso produto - " + SqlCa.SqlErrText)
//		lvb_Sucesso = False
//End Choose 

Return True

end function

on w_ge369_importacao_arquivo.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_importar_arquivo=create cb_importar_arquivo
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_importar_arquivo
this.Control[iCurrent+6]=this.cb_confirmar
this.Control[iCurrent+7]=this.cb_cancelar
end on

on w_ge369_importacao_arquivo.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_importar_arquivo)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

ivdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

dw_1.Object.Dt_Inicio_Vigencia[1] = RelativeDate(ivdt_Parametro, 1)
end event

type pb_help from dc_w_response`pb_help within w_ge369_importacao_arquivo
end type

type gb_2 from groupbox within w_ge369_importacao_arquivo
integer x = 23
integer y = 180
integer width = 3959
integer height = 1368
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge369_importacao_arquivo
integer x = 23
integer width = 2437
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge369_importacao_arquivo
integer x = 50
integer y = 56
integer width = 2386
integer height = 104
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge369_selecao_importacao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_uo_dw_base within w_ge369_importacao_arquivo
integer x = 32
integer y = 232
integer width = 3931
integer height = 1288
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge369_importacao_salva"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection("", "if(id_erro = ~"N~", rgb(0,0,0), rgb(255,0,0))")
end event

event itemchanged;call super::itemchanged;String lvs_Bloqueio,&
	   lvs_MSG

If dwo.Name = "id_alterar" Then
	lvs_Bloqueio = This.Object.Id_Bloqueado[Row]
	
//	If Data = "S" and lvs_Bloqueio <> "N" Then
//		Return 1
//	End If

	If Data = "S" and lvs_Bloqueio <> "N" Then
		
		lvs_MSG = "O produto esta bloqueado. ~r~rDeseja alterar o pre$$HEX1$$e700$$ENDHEX$$o mesmo assim ?"
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_MSG , Question!, YesNo!, 2) = 2 Then
			Return 1
		End If
	End If
End If

end event

event rowfocuschanged;call super::rowfocuschanged;String lvs_Bloqueio, &
       lvs_Descricao
		 
If CurrentRow > 0 Then
	lvs_Bloqueio = This.Object.id_bloqueado[CurrentRow]
	
	If lvs_Bloqueio <> "N" Then
		Choose Case lvs_Bloqueio
			Case "1"  ; lvs_Descricao = "BLOQUEADO NO CADASTRO"
			Case "2"  ; lvs_Descricao = "BLOQUEADO NA PROMO$$HEX2$$c700c300$$ENDHEX$$O"
			Case "3"  ; lvs_Descricao = "BLOQUEADO NO CADASTRO E NA PROMO$$HEX2$$c700c300$$ENDHEX$$O"
			Case "4"  ; lvs_Descricao = "ERRO NA IMPORTA$$HEX2$$c700c300$$ENDHEX$$O"
			Case Else ; lvs_Descricao = "BLOQUEIO N$$HEX1$$c300$$ENDHEX$$O PREVISTO"
		End Choose
	Else
		lvs_Descricao = ""
	End If
	
	This.Object.t_Descricao_Bloqueio.Text = lvs_Descricao




End If

end event

type cb_importar_arquivo from commandbutton within w_ge369_importacao_arquivo
integer x = 2491
integer y = 68
integer width = 608
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Importar Arquivo"
end type

event clicked;Any lva_Dado

String lvs_Arquivo, &
		 lvs_Descricao, &
		 lvs_Chave_Log, &
		 lvs_Alterar, &
		 lvs_Erro, &
		 lvs_UF,&
		 lvs_Bloqueio_Cadastro,&
		 lvs_Bloqueio_Promocao,&
		 lvs_Bloqueio = "N",&
		 lvs_Situacao

Long lvl_Total, &
	 lvl_Linha, &
     lvl_Produto,&
	 lvl_Linhas
	  
Decimal{2} lvdc_Fabrica_Atual, &
           lvdc_Fabrica_Novo, &
		   lvdc_Venda_Atual, &
           lvdc_Venda_Novo        

Boolean lvb_Erro

dw_1.AcceptText()

lvs_UF = dw_1.Object.Cd_UF[1]

If IsNull(lvs_UF) or lvs_UF = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a U.F. para a qual os produtos ser$$HEX1$$e300$$ENDHEX$$o importados.")
	dw_1.Event ue_Pos(1, "cd_uf")
	Return
End If

If Not wf_Seleciona_Arquivo(ref lvs_Arquivo) Then Return

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
End If
		
If lvl_Linhas > 0 Then
	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Importa$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os")
	gvo_Aplicacao.of_Grava_Log("Arquivo: " + lvs_Arquivo)
	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
	
	dw_2.Reset()
	
	For lvl_Linha = 1 To lvl_Linhas
		
		// Produto
		lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
		
		lvs_Chave_Log = "Linha " + String(lvl_Linha)
								
		lvs_Alterar  = "S"
		lvs_Bloqueio = "N"
		
		lvdc_Fabrica_Atual = 0
		lvdc_Venda_Atual   = 0
		
		If Not wf_Localiza_Produto(lva_Dado, &
								   ref lvl_Produto,&
								   lvs_UF, &
								   ref lvs_Descricao, &
								   ref lvdc_Fabrica_Atual, &
								   ref lvdc_Venda_Atual, &
								   ref lvs_Bloqueio_Cadastro,&
								   ref lvs_Bloqueio_Promocao,&
								   lvs_Chave_Log,&
								   lvs_Situacao	) Then
			//lvs_Descricao = ""
			lvl_Produto = 0
			lvs_Alterar = "N"
		End If
		
		If lvs_Alterar = "N" Then 
			lvs_Erro = "S"
		Else
			lvs_Erro = "N"
		End If
		
		If lvs_Alterar = "N" Then lvb_Erro = True
		
		If lvs_Bloqueio_Cadastro = "S" and lvs_Bloqueio_Promocao = "S" Then 
			lvs_Bloqueio = "3"
			lvs_Alterar  = "N"
		End If
		
		If lvs_Bloqueio_Cadastro = "N" and lvs_Bloqueio_Promocao = "N" Then
			lvs_Bloqueio = "N"
		End If
		
		If lvs_Bloqueio_Cadastro = "S" and lvs_Bloqueio_Promocao = "N" Then
			lvs_Bloqueio = "1"
			lvs_Alterar  = "N"
		End If
		
		If lvs_Bloqueio_Cadastro = "N" and lvs_Bloqueio_Promocao = "S" Then
			lvs_Bloqueio = "2"
			lvs_Alterar  = "N"
		End If
		
		If lvs_Erro = "S" Then
			lvs_Bloqueio = "4"
			lvs_Alterar  = "N"
		End If
				
		// Pre$$HEX1$$e700$$ENDHEX$$o de F$$HEX1$$e100$$ENDHEX$$brica Novo
		lva_Dado    	  = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
		lvdc_Fabrica_Novo = Dec(lva_Dado)
		
		// Pre$$HEX1$$e700$$ENDHEX$$o de Venda Novo
//		lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
//		lvdc_Venda_Novo = Dec(lva_Dado)
							
		If IsNull(lvdc_Fabrica_Novo) Then lvdc_Fabrica_Novo = 0
		If IsNull(lvdc_Venda_Novo)   Then lvdc_Venda_Novo   = 0

		dw_2.InsertRow(0)
		
		dw_2.Object.Nr_Linha        	 	 [lvl_Linha] = lvl_Linha
		dw_2.Object.Cd_Produto      	 [lvl_Linha] = lvl_Produto
		dw_2.Object.De_Produto      	 [lvl_Linha] = lvs_Descricao
		dw_2.Object.Vl_Fabrica_Atual	 [lvl_Linha] = lvdc_Fabrica_Atual
		dw_2.Object.Vl_Fabrica_Novo 	 [lvl_Linha] = lvdc_Fabrica_Novo
//		dw_2.Object.Vl_Venda_Atual  	 [lvl_Linha] = lvdc_Venda_Atual
//		dw_2.Object.Vl_Venda_Novo   	 [lvl_Linha] = lvdc_Venda_Novo		
		dw_2.Object.Id_Alterar      	 	 [lvl_Linha] = lvs_Alterar
		dw_2.Object.Id_Erro         	 	 [lvl_Linha] = lvs_Erro
		dw_2.Object.id_bloqueado		 [lvl_Linha] = lvs_Bloqueio
		
		
		// Adicionado Situacao e Bloqueado Promo$$HEX2$$e700e300$$ENDHEX$$o
		dw_2.Object.id_situacao		 	 [lvl_Linha] = lvs_Situacao
		If 	lvs_Bloqueio_Promocao="S" Then 
			 dw_2.Object.id_bloqueado_promocao [lvl_Linha] = "S"
		Else
			 dw_2.Object.id_bloqueado_promocao [lvl_Linha] = "N"
		End If		

						
					
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
	
	gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino da Importa$$HEX2$$e700e300$$ENDHEX$$o de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$os")
	
	If Not lvb_Erro Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo realizada com sucesso.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreram erros durante a importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo.~r" + &
									 "Verifique o arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o '" + gvo_Aplicacao.ivs_Arquivo_Log + "'.")
	End If
End If

Destroy(lvo_Excel)

Close(w_Aguarde)
SetPointer(Arrow!)
end event

type cb_confirmar from commandbutton within w_ge369_importacao_arquivo
integer x = 2990
integer y = 1572
integer width = 411
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Con&firmar"
end type

event clicked;Boolean lvb_Sucesso = True

String lvs_UF, &
		 lvs_Alterar
		 
Boolean lvb_Alterar_Fabrica
//		  lvb_Alterar_Venda

Long lvl_Total, &
     lvl_Linha, &
	  lvl_Produto
	  
Decimal lvdc_Fabrica_Novo, &
		  lvdc_Fabrica_Atual
//        lvdc_Venda_Novo, &
//		  lvdc_Venda_Atual
		  
Date lvdt_Vigencia

dw_1.AcceptText()
dw_2.AcceptText()

If Not wf_Existe_Alteracao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo um produto para altera$$HEX2$$e700e300$$ENDHEX$$o.")
	Return
End If

lvs_UF        = dw_1.Object.Cd_UF             [1]
lvdt_Vigencia = dw_1.Object.Dt_Inicio_Vigencia[1]

If IsNull(lvs_UF) or lvs_UF = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a U.F. para a qual os produtos ser$$HEX1$$e300$$ENDHEX$$o importados.")
	dw_1.Event ue_Pos(1, "cd_uf")
	Return
End If

If IsNull(lvdt_Vigencia) or Not IsDate(String(lvdt_Vigencia, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe corretamente a data de in$$HEX1$$ed00$$ENDHEX$$cio da vig$$HEX1$$ea00$$ENDHEX$$ncia para os pre$$HEX1$$e700$$ENDHEX$$os de venda alterados.")
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return
End If

If lvdt_Vigencia <= ivdt_Parametro Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio da vig$$HEX1$$ea00$$ENDHEX$$ncia deve ser maior ou igual a '" + &
	                      String(RelativeDate(ivdt_Parametro, 1), "dd/mm/yyyy") + "'.")
								 
	dw_1.Event ue_Pos(1, "dt_inicio_vigencia")
	Return
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Alterando os Produtos..."

lvl_Total = dw_2.RowCount()
w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Linha = 1 To lvl_Total
	lvl_Produto       = dw_2.Object.Cd_Produto     [lvl_Linha]
	lvdc_Fabrica_Novo = dw_2.Object.Vl_Fabrica_Novo[lvl_Linha]
//	lvdc_Venda_Novo   = dw_2.Object.Vl_Venda_Novo  [lvl_Linha]
	lvs_Alterar       = dw_2.Object.Id_Alterar     [lvl_Linha]
	
	If lvs_Alterar = "S" Then
	
		Select vl_preco_reposicao
//			   vl_preco_venda_atual
		Into :lvdc_Fabrica_Atual
//			 :lvdc_Venda_Atual
		From produto_uf
		Where cd_unidade_federacao = :lvs_UF
		  and cd_produto           = :lvl_Produto
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				lvb_Alterar_Fabrica = False
//				lvb_Alterar_Venda   = False
				
//				If IsNull(lvdc_Venda_Atual) Then lvdc_Venda_Atual = 0
				
				If lvdc_Fabrica_Novo > 0 and lvdc_Fabrica_Novo <> lvdc_Fabrica_Atual Then
					lvb_Alterar_Fabrica = True
				End If
	
//				If lvdc_Venda_Novo > 0 and lvdc_Venda_Novo <> lvdc_Venda_Atual Then
//					lvb_Alterar_Venda = True
//				End If
	
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado para altera$$HEX2$$e700e300$$ENDHEX$$o.")
				dw_2.Event ue_Pos(lvl_Linha, "vl_fabrica_novo")
				lvb_Sucesso = False
				Exit
				
			Case -1
				SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto '" + String(lvl_Produto) + "'")
				dw_2.Event ue_Pos(lvl_Linha, "vl_fabrica_novo")
				lvb_Sucesso = False
				Exit
		End Choose
		
//		If lvb_Alterar_Fabrica Then //or lvb_Alterar_Venda
//			If lvb_Alterar_Fabrica Then //and lvb_Alterar_Venda
//				Update produto_uf
//				Set vl_preco_reposicao           = :lvdc_Fabrica_Novo,
//					 dh_preco_reposicao           = getdate(),
//					 nr_matricula_preco_reposicao = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
//					 vl_preco_venda_futuro        = :lvdc_Venda_Novo,
//					 dh_preco_venda_futuro        = :lvdt_Vigencia,
//					 nr_matric_preco_venda_futuro = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
//				Where cd_unidade_federacao = :lvs_UF
//				  and cd_produto           = :lvl_Produto
//				Using SqlCa;
//			End If
			
			If lvb_Alterar_Fabrica Then //and Not lvb_Alterar_Venda 
				Update produto_uf
				Set vl_preco_reposicao           = :lvdc_Fabrica_Novo,
					 dh_preco_reposicao           = getdate(),
					 nr_matricula_preco_reposicao = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
				Where cd_unidade_federacao = :lvs_UF
				  and cd_produto           = :lvl_Produto
				Using SqlCa;
			End If
			
//			If Not lvb_Alterar_Fabrica and lvb_Alterar_Venda  Then
//				Update produto_uf
//				Set vl_preco_venda_futuro        = :lvdc_Venda_Novo,
//					 dh_preco_venda_futuro        = :lvdt_Vigencia,
//					 nr_matric_preco_venda_futuro = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
//				Where cd_unidade_federacao = :lvs_UF
//				  and cd_produto           = :lvl_Produto
//				Using SqlCa;
//			End If
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Produto '" + String(lvl_Produto) + "'")
				dw_2.Event ue_Pos(lvl_Linha, "vl_fabrica_novo")
				lvb_Sucesso = False
				Exit
			End If	
		End If
//	End If
		
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

Close(w_Aguarde)

If lvb_Sucesso Then
	SqlCa.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos foram alterados com sucesso!")
	SetPointer(Arrow!)
	Close(Parent)
Else
	SqlCa.of_RollBack()
End If

SetPointer(Arrow!)
end event

type cb_cancelar from commandbutton within w_ge369_importacao_arquivo
integer x = 3433
integer y = 1572
integer width = 411
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

