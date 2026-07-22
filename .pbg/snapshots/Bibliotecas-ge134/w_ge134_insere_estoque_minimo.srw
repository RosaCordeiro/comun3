HA$PBExportHeader$w_ge134_insere_estoque_minimo.srw
forward
global type w_ge134_insere_estoque_minimo from dc_w_response_ok_cancela
end type
type pb_localiza from picturebutton within w_ge134_insere_estoque_minimo
end type
type dw_2 from datawindow within w_ge134_insere_estoque_minimo
end type
end forward

global type w_ge134_insere_estoque_minimo from dc_w_response_ok_cancela
integer width = 2295
integer height = 500
string title = "GE134 - Insere Estoque M$$HEX1$$ed00$$ENDHEX$$nimo na Promo$$HEX2$$e700e300$$ENDHEX$$o "
long backcolor = 80269524
pb_localiza pb_localiza
dw_2 dw_2
end type
global w_ge134_insere_estoque_minimo w_ge134_insere_estoque_minimo

type variables
uo_produto    ivo_produto

Long ivl_Produtos, &
         ivl_Promocao
			
//Long ivl_Total_Linhas_Permidita= 17000
end variables

forward prototypes
public function boolean wf_verifica_produto_promocao (long al_promocao, long al_produto)
public function boolean wf_verifica_promocao_sos_filial (long al_promocao, long al_filial)
public function boolean wf_inclui_estoque_minimo (long al_promocao, long al_filial, long al_produto, long al_qt_minimo, long al_motivo)
end prototypes

public function boolean wf_verifica_produto_promocao (long al_promocao, long al_produto);Long lvl_Produto

String ls_Erro

Select cd_produto
Into :lvl_Produto
From promocao_sos_produto
Where cd_promocao_sos =: al_Promocao
  and cd_produto      =: al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sele$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(al_Produto) + "' na promo$$HEX2$$e700e300$$ENDHEX$$o SOS '" + String(al_Promocao) + "'. " + ls_Erro, StopSign!)
	Return False
End If

If SqlCa.SqlCode = 100 Then
	SqlCa.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado na promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "'.", Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_verifica_promocao_sos_filial (long al_promocao, long al_filial);Long lvl_Filial

String ls_Erro

Select cd_filial 
Into :lvl_Filial
From promocao_sos_filial
Where cd_promocao_sos = :al_promocao
  and cd_filial       = :al_filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial '" + String(al_Filial) + "' na promo$$HEX2$$e700e300$$ENDHEX$$o SOS '" + String(al_Promocao) + "'. " + ls_Erro, StopSign!)
	Return False
End If

If SqlCa.SqlCode = 100 Then
	SqlCa.of_RollBack();
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + String(al_filial) + "' n$$HEX1$$e300$$ENDHEX$$o faz parte da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "'.", Exclamation!)
	Return False
End If

Return True
end function

public function boolean wf_inclui_estoque_minimo (long al_promocao, long al_filial, long al_produto, long al_qt_minimo, long al_motivo);Long lvl_Produto

String ls_Erro

ivo_Produto.of_Localiza_Codigo_Interno(al_produto)

If Not ivo_Produto.Localizado Then
	SqlCa.of_RollBack();
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado. ", Exclamation!)
	Return False
End If

// Verifica se a filial est$$HEX1$$e100$$ENDHEX$$ cadastrada na promo$$HEX2$$e700e300$$ENDHEX$$o
If Not wf_Verifica_Promocao_SOS_Filial(al_Promocao, al_Filial) Then Return False

// Verifica se o produto est$$HEX1$$e100$$ENDHEX$$ cadastrado na promo$$HEX2$$e700e300$$ENDHEX$$o
If Not wf_Verifica_Produto_Promocao(al_Promocao, al_Produto) Then Return False
	
If al_Motivo = 0 Then	SetNull(al_Motivo)

Select cd_produto
Into :lvl_Produto
From promocao_sos_estoque_minimo
Where cd_promocao_sos	=: al_Promocao
  and cd_filial					=: al_filial
  and cd_produto      			=: al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta para o produto '" + String(al_Produto) + "' na promo$$HEX2$$e700e300$$ENDHEX$$o sos '" + String(al_promocao) + "'. " + ls_Erro, StopSign!)
	Return False
End If

If SqlCa.SqlCode = 0 Then

	Update promocao_sos_estoque_minimo
	Set	qt_estoque_minimo			= :al_qt_minimo,
			qt_estoque_minimo_matriz	= :al_qt_minimo,
			nr_matricula_alteracao		= :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
			cd_motivo_alteracao			= :al_Motivo
	Where cd_promocao_sos	=: al_Promocao
	  and cd_filial					=: al_filial
	  and cd_produto				=: al_Produto
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo para o produto '" + String(al_Produto) + "' na promo$$HEX2$$e700e300$$ENDHEX$$o sos '" + String(al_promocao) + "'. " + ls_Erro, StopSign!)
		Return False
	End If
	
	ivl_Produtos ++
	
Else
	Insert Into promocao_sos_estoque_minimo(cd_promocao_sos, 
														 cd_filial,
														 cd_produto, 
														 qt_estoque_minimo, 
														 id_alterado_filial,
														 qt_estoque_minimo_matriz,
														 nr_matricula_alteracao,
														 cd_motivo_alteracao)
	Values (:al_promocao, 
			  :al_filial,
			  :al_produto,
			  :al_qt_minimo,
			  "N", 
			  :al_qt_minimo,
			  :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
			  :al_Motivo)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo para o produto '" + String(al_Produto) + "' na promo$$HEX2$$e700e300$$ENDHEX$$o sos '" + String(al_promocao) + "'. " + ls_Erro, StopSign!)
		Return False
	End If
	
	ivl_Produtos ++				
End If

Return True
end function

on w_ge134_insere_estoque_minimo.create
int iCurrent
call super::create
this.pb_localiza=create pb_localiza
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_localiza
this.Control[iCurrent+2]=this.dw_2
end on

on w_ge134_insere_estoque_minimo.destroy
call super::destroy
destroy(this.pb_localiza)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;cb_OK.Enabled = False

ivo_Produto  = Create uo_Produto

ivl_Promocao = Long(Message.StringParm)


end event

event close;call super::close;Destroy(ivo_Produto)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge134_insere_estoque_minimo
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge134_insere_estoque_minimo
integer width = 2203
integer height = 252
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge134_insere_estoque_minimo
integer x = 37
integer y = 60
integer width = 2030
integer height = 160
string dataobject = "dw_ge134_selecao_arquivo"
boolean livescroll = false
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge134_insere_estoque_minimo
integer x = 1573
integer y = 284
end type

event cb_ok::clicked;Boolean lvb_Sucesso = True
Boolean lvb_Sucesso_Linha = False

String lvs_Arquivo, &
		 lvs_Dado,    &
		 lvs_Msg

Long lvl_Linhas,   & 
	  lvl_Linha,    &
	  lvl_Produto,  &
	  lvl_Filial,   &
	  lvl_QT_Minimo, &
	  ll_Motivo

dw_1.AcceptText()
dw_2.AcceptText()

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "GC" Then
	If dw_1.Object.Cd_Motivo[1] = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.")
		dw_1.Event ue_Pos(1, "cd_motivo")
		Return -1
	End If
End If

lvs_Arquivo = dw_1.Object.nm_arquivo [1]

lvs_Msg = "Importar os estoques m$$HEX1$$ed00$$ENDHEX$$nimos para os produtos do arquivo selecionado ? ~r" +&
			 "Promo$$HEX2$$e700e300$$ENDHEX$$o: '" + String(ivl_Promocao) + "'."

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

SetPointer(HourGlass!)

lvo_Excel.uo_referencia_objeto_excel(lvs_arquivo)

lvo_Excel.lole_book.ActiveCell.CurrentRegion.Select()

lvo_Excel.lole_book.Selection.Copy()

lvl_Linhas = dw_2.ImportClipboard() 

Open(w_Aguarde)

w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
For lvl_Linha = 1 To lvl_Linhas 
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	
	//Limpa variaveis por seguran$$HEX1$$e700$$ENDHEX$$a
	SetNull(lvl_Filial)
	SetNull(lvl_Produto) 
	SetNull(lvl_QT_Minimo)

	lvl_Filial = dw_2.Object.cd_filial[lvl_Linha]
	lvl_Produto = dw_2.Object.cd_produto[lvl_Linha]
	lvl_QT_Minimo = dw_2.Object.qt_estoque_minimo[lvl_Linha]
	
	If IsNull(lvl_QT_Minimo) or lvl_QT_Minimo < 1 Then lvl_QT_Minimo = 0
				 
	If Not wf_Inclui_Estoque_Minimo(ivl_Promocao, lvl_Filial, lvl_Produto, lvl_QT_Minimo, dw_1.Object.Cd_Motivo[1]) Then
		 lvb_Sucesso = False
		 lvb_Sucesso_Linha = False					 
	Else
		 lvb_Sucesso_Linha = True
	End If 
	
	// Novo Controle: Comitar Linha a Linha
	If lvb_Sucesso_Linha Then 
		SqlCa.of_Commit()
	Else
		SqlCa.of_RollBack()
		Close(w_Aguarde)
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na Atualiza$$HEX2$$e700e300$$ENDHEX$$o. Linha do Arquivo Nro:'" + String(lvl_Linha) + "' Loja:'" + String(lvl_Filial) + " Produto:" + String(lvl_Produto), Information!)
		Destroy(lvo_Excel)
		Close(Parent)	
		Exit	
	End If 
	
Next

//Limpa o clipboard
Clipboard('')	

If lvb_Sucesso and lvb_Sucesso_Linha Then 
	Close(w_Aguarde)
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foi atualizado o estoque m$$HEX1$$ed00$$ENDHEX$$nimo de '" + String(ivl_Produtos) + "' produtos da promo$$HEX2$$e700e300$$ENDHEX$$o '" + &
					String(ivl_Promocao) + "'. ~r" + "Opera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.", Information!)
	Destroy(lvo_Excel)
	Close(Parent)				
Else
	SqlCa.of_RollBack()
	Close(w_Aguarde)
End If

Destroy(lvo_Excel)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge134_insere_estoque_minimo
integer x = 1915
integer y = 284
end type

type pb_localiza from picturebutton within w_ge134_insere_estoque_minimo
string tag = "Localiza o arquivo com os produtos da promo$$HEX2$$e700e300$$ENDHEX$$o."
integer x = 2057
integer y = 48
integer width = 128
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\localizar_arquivo.bmp"
end type

event clicked;String lvs_Path, &
       lvs_Nome_Arquivo
		 
Integer lvi_Arquivo

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                     "Coluna A = Filial.~r" + &
							"Coluna B = Produto. ~r" + &
							"Coluna C = Estoque M$$HEX1$$ed00$$ENDHEX$$nimo.")
		 
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo = 1 Then
	dw_1.Object.nm_arquivo[1] = lvs_Path
	cb_OK.Enabled = True
End If
end event

type dw_2 from datawindow within w_ge134_insere_estoque_minimo
event ue_reset ( )
boolean visible = false
integer x = 59
integer y = 288
integer width = 1349
integer height = 100
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge134_importa_dados_excel"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_reset();This.Reset()
end event

