HA$PBExportHeader$w_ge162_importacao_arquivo.srw
forward
global type w_ge162_importacao_arquivo from dc_w_response
end type
type gb_3 from groupbox within w_ge162_importacao_arquivo
end type
type gb_2 from groupbox within w_ge162_importacao_arquivo
end type
type gb_1 from groupbox within w_ge162_importacao_arquivo
end type
type dw_1 from dc_uo_dw_base within w_ge162_importacao_arquivo
end type
type dw_2 from dc_uo_dw_base within w_ge162_importacao_arquivo
end type
type cb_importar_arquivo from commandbutton within w_ge162_importacao_arquivo
end type
type cb_confirmar from commandbutton within w_ge162_importacao_arquivo
end type
type cb_cancelar from commandbutton within w_ge162_importacao_arquivo
end type
type sle_msg from singlelineedit within w_ge162_importacao_arquivo
end type
end forward

global type w_ge162_importacao_arquivo from dc_w_response
integer width = 3575
integer height = 1896
string title = "GE162 - Importa$$HEX2$$e700e300$$ENDHEX$$o de Produtos de Distribuidoras"
long backcolor = 80269524
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_importar_arquivo cb_importar_arquivo
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
sle_msg sle_msg
end type
global w_ge162_importacao_arquivo w_ge162_importacao_arquivo

forward prototypes
public function boolean wf_seleciona_arquivo (ref string as_arquivo)
public function boolean wf_localiza_produto_nosso (long al_codigo, ref string as_descricao, string as_log)
public function boolean wf_existe_codigo_nosso (string as_distribuidora, long al_produto, string as_uf, string as_log)
public function boolean wf_existe_codigo_distribuidora (string as_distribuidora, string as_produto, string as_uf, string as_log, ref string as_msg)
end prototypes

public function boolean wf_seleciona_arquivo (ref string as_arquivo);String lvs_Arquivo
		 
Integer lvi_Retorno

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                     "Coluna A = Produto~r"     + &
					 "Coluna B = C$$HEX1$$f300$$ENDHEX$$digo na Distribuidora~r" +&
					 "Coluna C = Pre$$HEX1$$e700$$ENDHEX$$o~r" +&
					 "Coluna D = Desconto~r" +&
					 "Coluna E = (A) Ativo ou (I) Inativo~r")

lvi_Retorno = GetFileOpenName("Selecione o Arquivo", as_Arquivo, lvs_Arquivo, "TXT", "Texto (*.TXT),*.TXT,")

If lvi_Retorno = 1 Then	Return True

If lvi_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro na sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
End If

Return False
end function

public function boolean wf_localiza_produto_nosso (long al_codigo, ref string as_descricao, string as_log);Boolean lvb_Sucesso

Select de_produto + ' : ' + de_apresentacao_venda Into :as_Descricao
From produto_geral
Where cd_produto = :al_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		gvo_Aplicacao.of_Grava_Log(as_Log + " - Nosso produto '" + String(al_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o localizado")
		
	Case -1
		gvo_Aplicacao.of_Grava_Log(as_Log + " - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do nosso produto - " + SqlCa.SqlErrText)
End Choose

Return lvb_Sucesso
end function

public function boolean wf_existe_codigo_nosso (string as_distribuidora, long al_produto, string as_uf, string as_log);Boolean lvb_Retorno = True

String lvs_Codigo

Select cd_produto_distribuidora Into :lvs_Codigo
From distribuidora_produto
Where cd_distribuidora     = :as_Distribuidora
  and cd_produto           = :al_Produto
  and cd_unidade_federacao = :as_UF
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If as_Log = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O nosso c$$HEX1$$f300$$ENDHEX$$digo '" + String(al_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ relacionado com o c$$HEX1$$f300$$ENDHEX$$digo '" + &
										 lvs_Codigo + "' da distribuidora.")
		Else
			gvo_Aplicacao.of_Grava_Log(as_Log + " - O nosso c$$HEX1$$f300$$ENDHEX$$digo '" + String(al_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ relacionado com o c$$HEX1$$f300$$ENDHEX$$digo '" + &
										 lvs_Codigo + "' da distribuidora.")
		End If
		
	Case 100
		lvb_Retorno = False
		
	Case -1
		If as_Log = "" Then
			SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto")
		Else
			gvo_Aplicacao.of_Grava_Log(as_Log + " - Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia do nosso c$$HEX1$$f300$$ENDHEX$$digo do produto. - " + SqlCa.SqlErrText)
		End If
End Choose

Return lvb_Retorno
end function

public function boolean wf_existe_codigo_distribuidora (string as_distribuidora, string as_produto, string as_uf, string as_log, ref string as_msg);Boolean lvb_Retorno = True

Long lvl_Codigo

String lvs_Descricao

Select d.cd_produto,
       g.de_produto + ' : ' + g.de_apresentacao_venda
Into :lvl_Codigo,
     :lvs_Descricao
From distribuidora_produto d,
     produto_geral g
Where d.cd_distribuidora         = :as_Distribuidora
  and d.cd_produto_distribuidora = :as_Produto
  and d.cd_unidade_federacao     = :as_UF
  and g.cd_produto = d.cd_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If as_Log = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo '" + as_Produto + "' da distribuidora j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ relacionado com o nosso c$$HEX1$$f300$$ENDHEX$$digo ~r'" + &
										 String(lvl_Codigo) + " - " + lvs_Descricao + "'.")
		Else
			gvo_Aplicacao.of_Grava_Log(as_Log + " - O c$$HEX1$$f300$$ENDHEX$$digo '" + as_Produto + "' da distribuidora j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ relacionado com o nosso c$$HEX1$$f300$$ENDHEX$$digo ~r'" + &
										 String(lvl_Codigo) + " - " + lvs_Descricao + "'.")	
										 
			as_msg = "Produto da distribuidora j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ relacionado com o nosso c$$HEX1$$f300$$ENDHEX$$digo '" + String(lvl_Codigo) + "'."
		End If
		
	Case 100
		lvb_Retorno = False
		
	Case -1
		If as_Log = "" Then
			SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia do C$$HEX1$$f300$$ENDHEX$$digo do Produto na Distribuidora")
		Else
			gvo_Aplicacao.of_Grava_Log(as_Log + " - Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do produto na distribuidora. - " + SqlCa.SqlErrText)			
		End If
End Choose

Return lvb_Retorno
end function

on w_ge162_importacao_arquivo.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_importar_arquivo=create cb_importar_arquivo
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
this.sle_msg=create sle_msg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_importar_arquivo
this.Control[iCurrent+7]=this.cb_confirmar
this.Control[iCurrent+8]=this.cb_cancelar
this.Control[iCurrent+9]=this.sle_msg
end on

on w_ge162_importacao_arquivo.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_importar_arquivo)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
destroy(this.sle_msg)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

type pb_help from dc_w_response`pb_help within w_ge162_importacao_arquivo
end type

type gb_3 from groupbox within w_ge162_importacao_arquivo
integer x = 18
integer y = 1584
integer width = 2578
integer height = 188
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Mensagem"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge162_importacao_arquivo
integer x = 18
integer y = 260
integer width = 3506
integer height = 1288
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

type gb_1 from groupbox within w_ge162_importacao_arquivo
integer x = 18
integer width = 1655
integer height = 244
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

type dw_1 from dc_uo_dw_base within w_ge162_importacao_arquivo
integer x = 46
integer y = 52
integer width = 1618
integer height = 176
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge162_selecao_importacao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_uo_dw_base within w_ge162_importacao_arquivo
integer x = 46
integer y = 312
integer width = 3456
integer height = 1216
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge162_importacao_salva"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection("", "if(id_erro = ~"N~", rgb(0,0,0), rgb(255,0,0))")
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	If dw_2.Object.id_erro[CurrentRow] = "S" Then
		sle_msg.text = String(dw_2.Object.de_msg[CurrentRow])
	End If
End If
end event

type cb_importar_arquivo from commandbutton within w_ge162_importacao_arquivo
integer x = 2917
integer y = 164
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

event clicked;String lvs_Arquivo, &
       lvs_Distribuidora, &
       lvs_Situacao, &
		 lvs_Produto, &
		 lvs_Descricao, &
		 lvs_Chave_Log, &
		 lvs_Incluir, &
		 lvs_Erro, &
		 lvs_UF,&
		 lvs_MSG

Long lvl_Total, &
	  lvl_Linha, &
     lvl_Produto
	  
Decimal lvdc_Preco, &
        lvdc_Desconto

Boolean lvb_Erro

dw_1.AcceptText()

lvs_Distribuidora = dw_1.Object.Cd_Distribuidora[1]
lvs_UF            = dw_1.Object.Cd_UF           [1]

If IsNull(lvs_Distribuidora) or lvs_Distribuidora = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora para a qual os produtos ser$$HEX1$$e300$$ENDHEX$$o importados.")
	dw_1.Event ue_Pos(1, "cd_distribuidora")
	Return
End If

If IsNull(lvs_UF) or lvs_UF = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a U.F. para a qual os produtos ser$$HEX1$$e300$$ENDHEX$$o importados.")
	dw_1.Event ue_Pos(1, "cd_uf")
	Return
End If

If Not wf_Seleciona_Arquivo(ref lvs_Arquivo) Then Return

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge162_importacao_base") Then
	Destroy(lvds)
	Return
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo..."

lvl_Total = lvds.of_ImportFile(lvs_Arquivo)

If lvl_Total > 0 Then
	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Importa$$HEX2$$e700e300$$ENDHEX$$o de Produtos de Distribuidoras")
	gvo_Aplicacao.of_Grava_Log("Arquivo: " + lvs_Arquivo)
	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	dw_2.Reset()
	
	For lvl_Linha = 1 To lvl_Total
		lvl_Produto   = lvds.Object.Cd_Produto              [lvl_Linha]
		lvs_Produto   = lvds.Object.Cd_Produto_Distribuidora[lvl_Linha]
		lvdc_Preco    = lvds.Object.Vl_Preco                [lvl_Linha]
		lvdc_Desconto = lvds.Object.Pc_Desconto             [lvl_Linha]
		lvs_Situacao  = lvds.Object.Id_Situacao             [lvl_Linha]
		
		lvs_Chave_Log = "Linha " + String(lvl_Linha)
		
		lvs_Incluir = "S"
		
		If Not wf_Localiza_Produto_Nosso(lvl_Produto, ref lvs_Descricao, lvs_Chave_Log) Then
			lvs_Descricao = ""
			lvs_Incluir = "N"
		End If
		
		If IsNull(lvs_Produto) or Trim(lvs_Produto) = "" Then
			gvo_Aplicacao.of_Grava_Log(lvs_Chave_Log + " - Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto na distribuidora")
			dw_2.Object.de_msg[lvl_Linha]  = "Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto na distribuidora"
			lvs_Incluir = "N"
		End If
		
		If IsNull(lvdc_Preco) or lvdc_Preco <= 0 Then
			gvo_Aplicacao.of_Grava_Log(lvs_Chave_Log + " - O pre$$HEX1$$e700$$ENDHEX$$o do produto deve ser maior que zero")
			dw_2.Object.de_msg[lvl_Linha]  = "O pre$$HEX1$$e700$$ENDHEX$$o do produto deve ser maior que zero"
			lvs_Incluir = "N"
		End If

		If wf_Existe_Codigo_Nosso(lvs_Distribuidora, lvl_Produto, lvs_UF, lvs_Chave_Log) Then
			lvs_Incluir = "N"
		End If
		
		If wf_Existe_Codigo_Distribuidora(lvs_Distribuidora, lvs_Produto, lvs_UF, lvs_Chave_Log, Ref lvs_MSG) Then
			lvs_Incluir = "N"
		End If
		
		dw_2.Object.de_msg[lvl_Linha] = lvs_Msg
		
		If IsNull(lvs_Situacao) Then lvs_Situacao = "A"
		
		If lvs_Situacao <> "A" and lvs_Situacao <> "I" Then
			gvo_Aplicacao.of_Grava_Log(lvs_Chave_Log + " - A situa$$HEX2$$e700e300$$ENDHEX$$o deve ser A - Ativo ou I - Inativo")
			lvs_Incluir = "N"
		End If
		
		If IsNull(lvdc_Desconto) Then lvdc_Desconto = 0
		
		If lvs_Incluir = "N" Then 
			lvs_Erro = "S"
		Else
			lvs_Erro = "N"
		End If
		
		dw_2.InsertRow(0)
		
		dw_2.Object.Nr_Linha                [lvl_Linha] = lvl_Linha
		dw_2.Object.Cd_Produto              [lvl_Linha] = lvl_Produto
		dw_2.Object.De_Produto              [lvl_Linha] = lvs_Descricao
		dw_2.Object.Cd_Produto_Distribuidora[lvl_Linha] = lvs_Produto   
		dw_2.Object.Vl_Preco_Atual          [lvl_Linha] = lvdc_Preco
		dw_2.Object.Pc_Desconto_Atual       [lvl_Linha] = lvdc_Desconto
		dw_2.Object.Id_Situacao             [lvl_Linha] = lvs_Situacao
		dw_2.Object.Id_Incluir              [lvl_Linha] = lvs_Incluir
		dw_2.Object.Id_Erro                 [lvl_Linha] = lvs_Erro
		
		If lvs_Incluir = "N" Then lvb_Erro = True
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
	
	gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino da Importa$$HEX2$$e700e300$$ENDHEX$$o de Produtos de Distribuidoras")
	
	If Not lvb_Erro Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo realizada com sucesso.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreram erros durante a importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo.~r" + &
									 "Verifique o arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o '" + gvo_Aplicacao.ivs_Arquivo_Log + "'.")
	End If
End If

Destroy(lvds)

Close(w_Aguarde)
SetPointer(Arrow!)
end event

type cb_confirmar from commandbutton within w_ge162_importacao_arquivo
integer x = 2670
integer y = 1676
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

String lvs_Distribuidora, &
       lvs_Produto, &
		 lvs_Situacao, &
		 lvs_Incluir, &
		 lvs_UF,&
		 lvs_MSG

Long lvl_Total, &
     lvl_Linha, &
	  lvl_Produto
	  
Decimal lvdc_Preco, &
        lvdc_Desconto

DateTime lvdh_GetDate

dw_1.AcceptText()
dw_2.AcceptText()

lvs_Distribuidora = dw_1.Object.Cd_Distribuidora[1]
lvs_UF            = dw_1.Object.Cd_UF           [1]

If IsNull(lvs_Distribuidora) or lvs_Distribuidora = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora para a qual os produtos ser$$HEX1$$e300$$ENDHEX$$o importados.")
	dw_1.Event ue_Pos(1, "cd_distribuidora")
	Return
End If

If IsNull(lvs_UF) or lvs_UF = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a U.F. para a qual os produtos ser$$HEX1$$e300$$ENDHEX$$o importados.")
	dw_1.Event ue_Pos(1, "cd_uf")
	Return
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Incluindo os Produtos..."

lvl_Total = dw_2.RowCount()
w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Linha = 1 To lvl_Total
	lvl_Produto   = dw_2.Object.Cd_Produto              [lvl_Linha]
	lvs_Produto   = dw_2.Object.Cd_Produto_Distribuidora[lvl_Linha]
	lvdc_Preco    = dw_2.Object.Vl_Preco_Atual          [lvl_Linha]
	lvdc_Desconto = dw_2.Object.Pc_Desconto_Atual       [lvl_Linha]
	lvs_Situacao  = dw_2.Object.Id_Situacao             [lvl_Linha]	
	lvs_Incluir   = dw_2.Object.Id_Incluir              [lvl_Linha]	
	
	If lvs_Incluir = "S" Then
		If IsNull(lvs_Produto) or Trim(lvs_Produto) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto na distribuidora.")
			dw_2.Event ue_Pos(lvl_Linha, "cd_produto_distribuidora")
			lvb_Sucesso = False
			Exit
		End If
		
		If IsNull(lvdc_Preco) or lvdc_Preco <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o do produto deve ser maior que zero.")
			dw_2.Event ue_Pos(lvl_Linha, "vl_preco_atual")
			lvb_Sucesso = False
			Exit
		End If

		If wf_Existe_Codigo_Nosso(lvs_Distribuidora, lvl_Produto, lvs_UF, "") Then
			dw_2.Event ue_Pos(lvl_Linha, "cd_produto_distribuidora")
			lvb_Sucesso = False
			Exit
		End If
		
		If wf_Existe_Codigo_Distribuidora(lvs_Distribuidora, lvs_Produto, lvs_UF, "", lvs_MSG) Then
			dw_2.Event ue_Pos(lvl_Linha, "cd_produto_distribuidora")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvs_Situacao <> "A" and lvs_Situacao <> "I" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A situa$$HEX2$$e700e300$$ENDHEX$$o deve ser A - Ativo ou I - Inativo.")
			dw_2.Event ue_Pos(lvl_Linha, "id_situacao")
			lvb_Sucesso = False
			Exit
		End If
		
		lvdh_GetDate = gf_GetServerDate()
		
		Insert Into distribuidora_produto (cd_distribuidora,   
													  cd_produto,   
													  cd_unidade_federacao,
													  cd_produto_distribuidora,   
													  vl_preco_atual,   
													  pc_desconto_atual,   
													  vl_preco_anterior,   
													  pc_desconto_anterior,   
													  dh_alteracao_preco_desconto,   
													  nr_matric_alteracao_preco,   
													  dh_inclusao,   
													  id_situacao,   
													  dh_alteracao_situacao,   
													  nr_matric_alteracao_situacao)
		Values (:lvs_Distribuidora,   
				  :lvl_Produto,
				  :lvs_UF, 
				  :lvs_Produto,   
				  :lvdc_Preco,   
				  :lvdc_Desconto,   
				  0,   
				  0,   
				  :lvdh_GetDate,
				  :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
				  :lvdh_GetDate,
				  :lvs_Situacao,
				  :lvdh_GetDate,
				  :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Produto Distribuidora")
			
			dw_2.Event ue_Pos(lvl_Linha, "cd_produto_distribuidora")
			lvb_Sucesso = False
			Exit
		End If	
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

Close(w_Aguarde)

If lvb_Sucesso Then
	SqlCa.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos inclu$$HEX1$$ed00$$ENDHEX$$dos com sucesso.")
	SetPointer(Arrow!)
	Close(Parent)
Else
	SqlCa.of_RollBack()
End If

SetPointer(Arrow!)
end event

type cb_cancelar from commandbutton within w_ge162_importacao_arquivo
integer x = 3113
integer y = 1676
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

type sle_msg from singlelineedit within w_ge162_importacao_arquivo
integer x = 59
integer y = 1652
integer width = 2491
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean autohscroll = false
end type

