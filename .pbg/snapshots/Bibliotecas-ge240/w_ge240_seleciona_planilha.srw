HA$PBExportHeader$w_ge240_seleciona_planilha.srw
forward
global type w_ge240_seleciona_planilha from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge240_seleciona_planilha
end type
end forward

global type w_ge240_seleciona_planilha from dc_w_response_ok_cancela
string tag = "w_ge240_seleciona_planilha"
integer width = 2158
integer height = 428
string title = "GE240 - Seleciona Dados Planilha"
cb_1 cb_1
end type
global w_ge240_seleciona_planilha w_ge240_seleciona_planilha

type variables
dc_uo_ds_base ids
uo_produto ivo_produto
end variables

forward prototypes
public function boolean wf_le_dados_planilha (string as_arquivo)
public function boolean wf_valida_filial (long al_filial, ref string as_filial)
public function boolean wf_localiza_dados (long al_filial, long al_produto, ref decimal adc_custo_atual)
public function boolean wf_valida_produto (long al_produto, ref string as_descricao, ref decimal adc_vl_fator_conversao)
end prototypes

public function boolean wf_le_dados_planilha (string as_arquivo);Long ll_Filial,& 
	   ll_Produto,&
	   ll_Linha,&
	   ll_Linhas,&
	   ll_Linha_Dw

String ls_De_Motivo, &
		 ls_Nm_Filial,&
		 ls_Nm_Produto

Decimal ldc_vl_custo_atual
Decimal ldc_vl_custo_novo
Decimal ldc_vl_fator_conversao
Decimal ldc_vl_preco_venda
Decimal ldc_pc_desconto
Decimal ldc_vl_preco_unitario

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo a planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o Arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
					
			For ll_Linha = 1 To ll_Linhas

				// Dados do Arquivo
				ll_Filial 						= lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				ll_Produto					= lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
				// Localiza o Produto
				ivo_Produto.of_Localiza_Produto(String(ll_Produto))
				
				If ivo_Produto.Localizado Then 
				
					// Buscar Nome Filial
					If Not wf_valida_filial(ll_Filial, Ref ls_Nm_Filial) Then 
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Registro Sem Filial ou Inv$$HEX1$$e100$$ENDHEX$$lida. Na Linha:" + String(ll_Linha),StopSign!,OK!)
						Return False
					End If 
				
					ldc_vl_custo_novo			= lo_Excel.uo_Lendo_Dados(ll_Linha, "C") 
					ls_De_Motivo				= lo_Excel.uo_Lendo_Dados(ll_Linha, "D")
					ldc_pc_desconto			= ivo_Produto.Of_Desconto_Filial( ll_Filial )
					ldc_vl_preco_unitario 		= ivo_Produto.of_Preco_Venda_Filial_Matriz( ll_Filial )
					ldc_vl_preco_unitario		= ivo_Produto.of_Preco_Venda_Filial_Matriz( ll_Filial )
					ldc_pc_desconto			= ivo_Produto.Of_Desconto_Filial( ll_Filial )
	
					// Busca Nome Produto
					If Not wf_valida_produto(ll_Produto, Ref ls_Nm_Produto, Ref ldc_vl_fator_conversao) Then Return False
					// Busca Custo Atual Produto/Loja
					If Not wf_localiza_dados(ll_Filial, ll_Produto,  Ref ldc_vl_custo_atual) Then Return False
	
					// Valida Motivo
					If IsNull(ls_De_Motivo) or ls_De_Motivo = '' Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Registro Sem Motivo. Na Linha:" +String(ll_Linha)+" !",StopSign!,OK!)
						Return False
					End If
	
					// Valida Custo
					If IsNull(ldc_vl_custo_novo) or ldc_vl_custo_novo = 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Registro Sem Valor Novo Custo. Na Linha:" + String(ll_Linha),StopSign!,OK!)
						Return False
					End If	
				
	
					// Adiciona registros
					ll_Linha_Dw  												= ids.InsertRow(0) 
					ids.Object.cd_filial			 		[ll_Linha_Dw] 		= ll_Filial
					ids.Object.nm_fantasia			[ll_Linha_Dw] 		= ls_Nm_Filial
					ids.Object.cd_produto				[ll_Linha_Dw] 		= ll_Produto
					ids.Object.de_produto			[ll_Linha_Dw] 		= ls_Nm_Produto
					ids.Object.vl_custo_atual			[ll_Linha_Dw] 		= ldc_vl_custo_atual		
					ids.Object.de_motivo				[ll_Linha_Dw] 		= ls_De_Motivo		
					ids.Object.vl_custo_novo			[ll_Linha_Dw] 		= ldc_vl_custo_novo		
					ids.Object.vl_fator_conversao  	[ll_Linha_Dw]   	= ldc_vl_fator_conversao
					ids.Object.pc_desconto  			[ll_Linha_Dw]   	= ldc_pc_desconto
					ids.Object.vl_preco_unitario  	[ll_Linha_Dw]   	= ldc_vl_preco_unitario	
					
				End If 
			
			Next			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha est$$HEX1$$e100$$ENDHEX$$ em branco.")
			Return False
		End If
	End If
	
Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try
end function

public function boolean wf_valida_filial (long al_filial, ref string as_filial);Long ll_cd_filial

Select cd_filial, nm_fantasia
	Into :ll_cd_filial, :as_filial
From filial
Where cd_filial = :al_Filial
	And id_situacao = 'A'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o c$$HEX1$$f300$$ENDHEX$$digo da filial '" + String(al_Filial) + "'. " + SqlCa.SqlErrText, StopSign!)
		Return False
	Case 0 
		If ll_cd_filial > 0 Then Return True 
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizada ou inativa.", Exclamation!)
		Return False
End Choose




Return True
end function

public function boolean wf_localiza_dados (long al_filial, long al_produto, ref decimal adc_custo_atual);
// 0.00 as vl_unitario,
///		  0.00 as pc_desconto


select  vl_custo_medio
Into   :adc_custo_atual  
from vw_saldo_atual_produto
where cd_filial  =:al_filial
AND cd_produto=:al_produto
Using SqlCA;



Return True 



end function

public function boolean wf_valida_produto (long al_produto, ref string as_descricao, ref decimal adc_vl_fator_conversao);
 
 select (g.de_produto +':'+g.de_apresentacao_venda) as de_produto , vl_fator_conversao
 Into :as_descricao, :adc_vl_fator_conversao 
 from produto_geral g
 where g.cd_produto  = :al_produto
 Using SqlCA;
 
 
 Return True 
end function

on w_ge240_seleciona_planilha.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge240_seleciona_planilha.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;ids = Create dc_uo_ds_base
ivo_Produto = Create uo_Produto
ids = Message.PowerObjectParm
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge240_seleciona_planilha
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge240_seleciona_planilha
integer width = 2075
integer height = 184
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge240_seleciona_planilha
integer width = 2016
integer height = 92
string dataobject = "dw_ge240_selecao_arquivo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge240_seleciona_planilha
integer x = 1449
integer y = 216
integer weight = 700
end type

event cb_ok::clicked;call super::clicked;String ls_Arquivo

dw_1.AcceptText()

ls_Arquivo = dw_1.Object.De_Arquivo[1]

If IsNull(ls_Arquivo) Or Trim(ls_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma planilha foi selecionada.")
	Return -1
End If

If Not wf_Le_Dados_Planilha(ls_Arquivo) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas Na Leitura/Processamento do Arquivo.")
	Return -1
End If 

Destroy(ivo_produto)
CloseWithReturn(Parent, ids)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge240_seleciona_planilha
integer x = 1787
integer y = 216
end type

event cb_cancelar::clicked;//OverRide

ids.Reset()
Destroy(ivo_Produto)
CloseWithReturn(Parent, ids)
end event

type cb_1 from commandbutton within w_ge240_seleciona_planilha
integer x = 23
integer y = 216
integer width = 526
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Seleciona Arquivo"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r~r" + &
							+ "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo da Filial~r~r" + &
							+ "Coluna B = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r~r" + &
							+ "Coluna C = Valor Custo Novo~r~r" + &
							+ "Coluna D = Motivo"  ) 

li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	cb_Ok.Enabled = True
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
	cb_Ok.Enabled = False
End If
end event

