HA$PBExportHeader$w_ge568_inclusao_via_planilha.srw
forward
global type w_ge568_inclusao_via_planilha from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge568_inclusao_via_planilha
end type
end forward

global type w_ge568_inclusao_via_planilha from dc_w_response_ok_cancela
integer width = 2647
integer height = 548
string title = "GE568 - Inclui Produto via Planilha"
cb_1 cb_1
end type
global w_ge568_inclusao_via_planilha w_ge568_inclusao_via_planilha

type variables
string is_origem
end variables

forward prototypes
public function boolean wf_valida_produto (long al_produto, ref boolean ab_achou)
public function boolean wf_le_dados_planilha (string as_arquivo, ref string as_retorno)
public function boolean wf_valida_uf (string as_uf, ref boolean ab_achou)
public function boolean wf_valida_rede (string as_rede, ref boolean ab_achou)
public function boolean wf_valida_distribuidora (string as_distribuidora, ref boolean ab_achou)
end prototypes

public function boolean wf_valida_produto (long al_produto, ref boolean ab_achou);Long ll_Achou

ab_Achou = False

If Not IsNumber(String(al_Produto)) Then Return True

Select Count(*)
	Into: ll_Achou
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ab_Achou = True
End If

Return True
end function

public function boolean wf_le_dados_planilha (string as_arquivo, ref string as_retorno);Boolean lb_AchouProd = False
Boolean lb_AchouUF = False
Boolean lb_AchouRede = False
Boolean lb_AchouDistr = False

Long ll_Linha
Long ll_Linhas
Long ll_cd_Produto
Long ll_Len

string ls_id_rede_filial
string ls_cd_uf
string ls_cd_distribuidora

// coloco uma virgula como primeiro caracter para posteriormente ter uma forma consistente de checar se um codigo de produto ja existe na variavel
as_Retorno = ""

dw_1.AcceptText()

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo a planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
					
			For ll_Linha = 1 To ll_Linhas
				ll_cd_produto       = long(lo_Excel.uo_Lendo_Dados(ll_Linha, "A"))
				ls_id_rede_filial   = string(lo_Excel.uo_Lendo_Dados(ll_Linha, "B"))
				ls_cd_uf            = string(lo_Excel.uo_Lendo_Dados(ll_Linha, "C"))
				ls_cd_distribuidora = string(lo_Excel.uo_Lendo_Dados(ll_Linha, "D"))
				
				if isnull(ll_cd_produto			) then ll_cd_produto = -1
				if isnull(ls_id_rede_filial   ) then ls_id_rede_filial = ''
				if isnull(ls_cd_uf            ) then ls_cd_uf = ''
				if isnull(ls_cd_distribuidora	) then ls_cd_distribuidora = ''
				
				if len(trim(ls_cd_distribuidora)) > 0 then ls_cd_distribuidora = fill('0', 9 - len(ls_cd_distribuidora)) + trim(ls_cd_distribuidora)

				// nao permite informar UF na planilha se nao informou a rede
				if ls_cd_uf <> '' and ls_id_rede_filial = '' then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Linha "+string(ll_linha)+": Informada UF sem informar o crit$$HEX1$$e900$$ENDHEX$$rio anterior (Rede Filial). Processo cancelado.", Exclamation!)
					Return False
				end if
				
				// nao permite informar UF na planilha se nao informou a rede
				if ls_cd_distribuidora <> '' and ls_cd_uf = '' then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Linha "+string(ll_linha)+": Informada Distribuidora sem informar o crit$$HEX1$$e900$$ENDHEX$$rio anterior (UF). Processo cancelado.", Exclamation!)
					Return False
				end if
				
				If Not wf_Valida_Produto(ll_cd_produto, Ref lb_AchouProd)					Then Return False
				If Not wf_Valida_Rede(ls_id_rede_filial, Ref lb_AchouRede)					Then Return False
				If Not wf_Valida_UF(ls_cd_uf, Ref lb_AchouUF)									Then Return False
				If Not wf_Valida_Distribuidora(ls_cd_distribuidora, Ref lb_AchouDistr)	Then Return False
				
				If Not lb_AchouProd Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(ll_cd_produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado. ~rLinha " + String(ll_Linha) + ".", Exclamation!)
					Return False
				End If

				If Not lb_AchouRede Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rede'" + ls_id_rede_filial + "' n$$HEX1$$e300$$ENDHEX$$o localizada. ~rLinha " + String(ll_Linha) + ".", Exclamation!)
					Return False
				End If
				
				If Not lb_AchouUF Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "UF'" + ls_cd_uf + "' n$$HEX1$$e300$$ENDHEX$$o localizada. ~rLinha " + String(ll_Linha) + ".", Exclamation!)
					Return False
				End If
				
				If Not lb_AchouDistr Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora'" + ls_cd_distribuidora + "' n$$HEX1$$e300$$ENDHEX$$o localizada. ~rLinha " + String(ll_Linha) + ".", Exclamation!)
					Return False
				End If
				
				as_retorno += String(ll_cd_produto) + ","
				as_retorno += ls_id_rede_filial + ","
				as_retorno += ls_cd_uf + ","
				as_retorno += ls_cd_distribuidora + ","
			Next
			
			If len(as_retorno) > 1 Then
				// retira a ultima virgula
				ll_Len = LenA(as_retorno)
				as_retorno = MidA(as_retorno, 1, ll_Len -1)
			else
				as_retorno = ""
			End If
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

public function boolean wf_valida_uf (string as_uf, ref boolean ab_achou);Long ll_Achou

ab_Achou = False

as_uf = upper(trim(as_uf))

//se campo estiver em branco, retorna true, pois n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um campo obrigatorio da planilha
if len(as_uf) = 0 or isnull(as_uf) then 
	ab_achou = true
	return true
end if

//codigo da UF tem que ter sempre 2 caracteres, se for diferente disso, retorna false
if len(as_uf) <> 2 then return false

Select Count(*)
  Into :ll_Achou
  From unidade_federacao
 Where cd_unidade_federacao = :as_uf
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar UF. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ab_Achou = True
End If

Return True
end function

public function boolean wf_valida_rede (string as_rede, ref boolean ab_achou);Long ll_Achou

ab_Achou = False

as_rede = trim(as_rede)

//se campo estiver em branco, retorna true, pois n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um campo obrigatorio da planilha
if len(as_rede) = 0 or isnull(as_rede) then 
	ab_achou = true
	return true
end if

Select Count(*)
  Into :ll_Achou
  From rede_filial
 Where id_rede_filial = :as_rede
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar Rede. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ab_Achou = True
End If

Return True
end function

public function boolean wf_valida_distribuidora (string as_distribuidora, ref boolean ab_achou);Long ll_Achou

ab_Achou = False

as_distribuidora = trim(as_distribuidora)

//se campo estiver em branco, retorna true, pois n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um campo obrigatorio da planilha
if len(as_distribuidora) = 0 or isnull(as_distribuidora) then 
	ab_achou = true
	return true
end if

Select Count(*)
  Into :ll_Achou
  From fornecedor
 Where cd_fornecedor = :as_distribuidora
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar Distribuidora. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ab_Achou = True
End If

Return True
end function

on w_ge568_inclusao_via_planilha.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge568_inclusao_via_planilha.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;is_origem = message.stringparm

if is_origem = 'DESBLOQUEIO' then
	dw_1.object.pc_limite.visible = '0'
	dw_1.object.pc_limite_t.visible = '0'
end if
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge568_inclusao_via_planilha
integer taborder = 80
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge568_inclusao_via_planilha
integer y = 8
integer width = 2583
integer height = 284
integer taborder = 70
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge568_inclusao_via_planilha
integer y = 76
integer width = 2523
integer height = 184
integer taborder = 30
string dataobject = "dw_ge568_selecao_arquivo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge568_inclusao_via_planilha
integer x = 1961
integer y = 328
integer taborder = 50
end type

event cb_ok::clicked;call super::clicked;String ls_Arquivo
String ls_Produto
String ls_retorno

dw_1.AcceptText()

if string(dw_1.object.dh_termino[1], 'yyyymmdd') < string(today(), 'yyyymmdd') then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de fim da vig$$HEX1$$ea00$$ENDHEX$$ncia deve ser igual ou maior que a data de hoje.")
	Return -1
end if

if dw_1.object.pc_limite.visible = '1' then
	if dw_1.object.pc_limite[1] = 0 then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um percentual de limite v$$HEX1$$e100$$ENDHEX$$lido para continuar.")
		Return -1
	end if
end if

ls_Arquivo = dw_1.Object.De_Arquivo[1]

If IsNull(ls_Arquivo) Or Trim(ls_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma planilha foi selecionada.")
	Return -1
End If

If Not wf_Le_Dados_Planilha(ls_Arquivo, Ref ls_Produto) Then Return -1

ls_retorno = string(dw_1.object.dh_inicio[1], 'dd/mm/yyyy') + ';' + string(dw_1.object.dh_termino[1], 'dd/mm/yyyy') + ';' 

if is_origem <> 'DESBLOQUEIO' then ls_retorno += string(dw_1.object.pc_limite[1]) 

ls_retorno += ';' 

ls_retorno += ls_produto

CloseWithReturn(Parent, ls_retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge568_inclusao_via_planilha
integer x = 2295
integer y = 328
integer taborder = 60
end type

type cb_1 from commandbutton within w_ge568_inclusao_via_planilha
integer x = 37
integer y = 328
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
String ls_mensagem

dw_1.AcceptText()

ls_mensagem =	"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto (obrigat$$HEX1$$f300$$ENDHEX$$rio)" + char(13) + char(10) + &
					"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo da Rede (opcional)"       + char(13) + char(10) + & 
					"Coluna C = C$$HEX1$$f300$$ENDHEX$$digo da UF (opcional)" 

if is_origem = 'DESBLOQUEIO' then
	ls_mensagem += char(13) + char(10) + "Coluna D = C$$HEX1$$f300$$ENDHEX$$digo da Distribuidora (opcional)"
end if


MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r~r" + &
							 ls_mensagem)

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

