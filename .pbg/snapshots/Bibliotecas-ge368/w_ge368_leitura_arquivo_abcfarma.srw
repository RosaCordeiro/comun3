HA$PBExportHeader$w_ge368_leitura_arquivo_abcfarma.srw
forward
global type w_ge368_leitura_arquivo_abcfarma from dc_w_response
end type
type gb_1 from groupbox within w_ge368_leitura_arquivo_abcfarma
end type
type cb_gravar from commandbutton within w_ge368_leitura_arquivo_abcfarma
end type
type cb_ler_arquivo from commandbutton within w_ge368_leitura_arquivo_abcfarma
end type
type cb_sair from commandbutton within w_ge368_leitura_arquivo_abcfarma
end type
type cb_procurar from commandbutton within w_ge368_leitura_arquivo_abcfarma
end type
type dw_1 from dc_uo_dw_base within w_ge368_leitura_arquivo_abcfarma
end type
type gb_2 from groupbox within w_ge368_leitura_arquivo_abcfarma
end type
type dw_2 from dc_uo_dw_base within w_ge368_leitura_arquivo_abcfarma
end type
type cb_ler_webservice from commandbutton within w_ge368_leitura_arquivo_abcfarma
end type
type cb_exportar_excel from commandbutton within w_ge368_leitura_arquivo_abcfarma
end type
type cb_validar from commandbutton within w_ge368_leitura_arquivo_abcfarma
end type
end forward

global type w_ge368_leitura_arquivo_abcfarma from dc_w_response
integer width = 3995
integer height = 1904
string title = "GE368 - Leitura do Arquivo ABC Farma"
long backcolor = 80269524
gb_1 gb_1
cb_gravar cb_gravar
cb_ler_arquivo cb_ler_arquivo
cb_sair cb_sair
cb_procurar cb_procurar
dw_1 dw_1
gb_2 gb_2
dw_2 dw_2
cb_ler_webservice cb_ler_webservice
cb_exportar_excel cb_exportar_excel
cb_validar cb_validar
end type
global w_ge368_leitura_arquivo_abcfarma w_ge368_leitura_arquivo_abcfarma

type variables
dc_uo_ds_base ids_Laboratorios

Boolean	ib_Guia_Da_Farmacia

Date	idt_Parametro
end variables

forward prototypes
public subroutine wf_corrige_decimais ()
public function boolean wf_abre_arquivo (string as_arquivo, ref integer ai_arquivo)
public function boolean wf_processa_importacao (string as_arquivo)
public function boolean wf_processa_arquivo (string as_arquivo, integer ai_arquivo)
public function boolean wf_processa_detalhe (string as_registro)
public function boolean wf_decimal (string as_valor, ref decimal adc_valor)
public function boolean wf_replace_unicode (ref string as_json, ref string as_erro)
public function boolean wf_abcfarma_webservice (long al_pagina, ref string as_json, ref string as_erro)
public function boolean wf_processa_retorno_webservice (string as_json, ref long al_pagina, ref long al_total_pagina, ref long al_total_itens, ref string as_erro)
public function boolean wf_inativa_cod_barras ()
public subroutine wf_exporta_planilha (datetime ldh_periodo)
public function boolean wf_processa_detalhe_guia_da_farmacia (string as_registro)
end prototypes

public subroutine wf_corrige_decimais ();Long lvl_Linha

Open(w_Aguarde)
w_Aguarde.Title = "Corrigindo Valores Decimais..."

w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())

For lvl_Linha = 1 To dw_2.RowCount()
	dw_2.Object.Med_Pco12[lvl_Linha] = dw_2.Object.Med_Pco12[lvl_Linha] / 100
	dw_2.Object.Med_Pla12[lvl_Linha] = dw_2.Object.Med_Pla12[lvl_Linha] / 100
	dw_2.Object.Med_Fra12[lvl_Linha] = dw_2.Object.Med_Fra12[lvl_Linha] / 100
	
	dw_2.Object.Med_Pco17[lvl_Linha] = dw_2.Object.Med_Pco17[lvl_Linha] / 100
	dw_2.Object.Med_Pla17[lvl_Linha] = dw_2.Object.Med_Pla17[lvl_Linha] / 100
	dw_2.Object.Med_Fra17[lvl_Linha] = dw_2.Object.Med_Fra17[lvl_Linha] / 100
	
	dw_2.Object.Med_Pco18[lvl_Linha] = dw_2.Object.Med_Pco18[lvl_Linha] / 100
	dw_2.Object.Med_Pla18[lvl_Linha] = dw_2.Object.Med_Pla18[lvl_Linha] / 100
	dw_2.Object.Med_Fra18[lvl_Linha] = dw_2.Object.Med_Fra18[lvl_Linha] / 100
	
	dw_2.Object.Med_Pco20[lvl_Linha] = dw_2.Object.Med_Pco20[lvl_Linha] / 100
	dw_2.Object.Med_Pla20[lvl_Linha] = dw_2.Object.Med_Pla20[lvl_Linha] / 100
	dw_2.Object.Med_Fra20[lvl_Linha] = dw_2.Object.Med_Fra20[lvl_Linha] / 100
	
	dw_2.Object.Med_IPI  [lvl_Linha] = dw_2.Object.Med_IPI  [lvl_Linha] / 100
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

Close(w_Aguarde)
end subroutine

public function boolean wf_abre_arquivo (string as_arquivo, ref integer ai_arquivo);ai_Arquivo = FileOpen(as_Arquivo, LineMode!, Read!, LockRead!)

If ai_Arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na Abertura do Arquivo '" + as_Arquivo + "'.")
	Return False
End If

Return True
end function

public function boolean wf_processa_importacao (string as_arquivo);Integer li_Arquivo

Try
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Importando planilha... Aguarde."

	If Not wf_Abre_Arquivo(as_Arquivo, Ref li_Arquivo) Then Return False
	
	If Not wf_Processa_Arquivo(as_Arquivo, li_Arquivo) Then Return False

	Return True
	
Finally
	FileClose(li_Arquivo)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
End Try
end function

public function boolean wf_processa_arquivo (string as_arquivo, integer ai_arquivo);Integer li_Read

String ls_Registro

ids_Laboratorios.Reset()

li_Read = FileRead(ai_Arquivo, ls_Registro)

If li_Read <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na primeira leitura do arquivo '" + as_Arquivo + "'.", StopSign!)
	Return False
End If


	
Do While li_Read > 0
	
	If ib_Guia_Da_Farmacia Then
		If Not wf_Processa_Detalhe_Guia_Da_Farmacia(ls_Registro) Then Return False
	Else
		If Not wf_Processa_Detalhe(ls_Registro) Then Return False
	End If
	
	li_Read = FileRead(ai_Arquivo, ls_Registro)
Loop

Return True
end function

public function boolean wf_processa_detalhe (string as_registro);Date ldt_Vigencia

Decimal ldc_ICMS_Fab_20
Decimal ldc_ICMS_Ven_20
Decimal ldc_ICMS_Fra_20

Decimal ldc_ICMS_Fab_18
Decimal ldc_ICMS_Ven_18
Decimal ldc_ICMS_Fra_18

Decimal ldc_ICMS_Fab_17
Decimal ldc_ICMS_Ven_17
Decimal ldc_ICMS_Fra_17

Decimal ldc_ICMS_Fab_12
Decimal ldc_ICMS_Ven_12
Decimal ldc_ICMS_Fra_12
Decimal ldc_Nulo

Decimal ldc_Ipi

Long ll_Linha

String ls_Produto
String ls_Nm_Lab
String ls_Desc_Prd
String Apres_Prd

String ls_ICMS_Fab_20
String ls_ICMS_Ven_20
String ls_ICMS_Fra_20

String ls_ICMS_Fab_18
String ls_ICMS_Ven_18
String ls_ICMS_Fra_18

String ls_ICMS_Fab_17
String ls_ICMS_Ven_17
String ls_ICMS_Fra_17

String ls_ICMS_Fab_12
String ls_ICMS_Ven_12
String ls_ICMS_Fra_12

String ls_Ipi
String ls_Vigencia
String ls_Ean
String ls_Tipo_Med
String ls_NCM
String ls_DCB
String ls_Registro_Ms
String ls_Ctr
String ls_Campo_Logi

ls_Produto	= MidA(as_Registro, 1, 9)
ls_Ctr			= MidA(as_Registro, 10, 1)
ls_Nm_Lab	= MidA(as_Registro, 17, 30)
ls_Desc_Prd	= MidA(as_Registro, 47, 45)
Apres_Prd	= MidA(as_Registro, 92, 45)

ls_ICMS_Fab_20	= MidA(as_Registro, 137, 11)
ls_ICMS_Ven_20	= MidA(as_Registro, 148, 11)
ls_ICMS_Fra_20	= MidA(as_Registro, 159, 11)

ls_ICMS_Fab_18	= MidA(as_Registro, 170, 11)
ls_ICMS_Ven_18	= MidA(as_Registro, 181, 11)
ls_ICMS_Fra_18	= MidA(as_Registro, 192, 11)

ls_ICMS_Fab_17	= MidA(as_Registro, 203, 11)
ls_ICMS_Ven_17	= MidA(as_Registro, 214, 11)
ls_ICMS_Fra_17	= MidA(as_Registro, 225, 11)

ls_ICMS_Fab_12	= MidA(as_Registro, 269, 11)
ls_ICMS_Ven_12	= MidA(as_Registro, 280, 11)
ls_ICMS_Fra_12	= MidA(as_Registro, 291, 11)

ls_Ipi				= MidA(as_Registro, 437, 5)
ls_Vigencia		= MidA(as_Registro, 442, 8)
ls_Campo_Logi	= MidA(as_Registro, 450, 1)
ls_Ean			= MidA(as_Registro, 452, 13)
ls_Tipo_Med	= MidA(as_Registro, 528, 20)
ls_NCM			= MidA(as_Registro, 549, 10)
ls_DCB			= MidA(as_Registro, 559, 90)
ls_Registro_Ms	= MidA(as_Registro, 465, 13)

If Not IsNumber(ls_Produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto '" + ls_Produto + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	Return False
End If

//20%
If Not wf_Decimal(ls_ICMS_Fab_20, Ref ldc_ICMS_Fab_20) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS do laborat$$HEX1$$f300$$ENDHEX$$rio 20% '" + ls_ICMS_Fab_20 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_ICMS_Ven_20, Ref ldc_ICMS_Ven_20) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS de venda 20% '" + ls_ICMS_Ven_20 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_ICMS_Fra_20, Ref ldc_ICMS_Fra_20) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS fra$$HEX2$$e700e300$$ENDHEX$$o da venda 20% '" + ls_ICMS_Fra_20 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

//18%
If Not wf_Decimal(ls_ICMS_Fab_18, Ref ldc_ICMS_Fab_18) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS do laborat$$HEX1$$f300$$ENDHEX$$rio 18% '" + ls_ICMS_Fab_18 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_ICMS_Ven_18, Ref ldc_ICMS_Ven_18) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS de venda 18% '" + ls_ICMS_Ven_18 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_ICMS_Fra_18, Ref ldc_ICMS_Fra_18) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS fra$$HEX2$$e700e300$$ENDHEX$$o da venda 18% '" + ls_ICMS_Fra_18 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

//17%
If Not wf_Decimal(ls_ICMS_Fab_17, Ref ldc_ICMS_Fab_17) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS do laborat$$HEX1$$f300$$ENDHEX$$rio 17% '" + ls_ICMS_Fab_17 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_ICMS_Ven_17, Ref ldc_ICMS_Ven_17) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS de venda 17% '" + ls_ICMS_Ven_17 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_ICMS_Fra_17, Ref ldc_ICMS_Fra_17) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS fra$$HEX2$$e700e300$$ENDHEX$$o da venda 17% '" + ls_ICMS_Fra_17 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

//12%
If Not wf_Decimal(ls_ICMS_Fab_12, Ref ldc_ICMS_Fab_12) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS do laborat$$HEX1$$f300$$ENDHEX$$rio 12% '" + ls_ICMS_Fab_12 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_ICMS_Ven_12, Ref ldc_ICMS_Ven_12) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS de venda 12% '" + ls_ICMS_Ven_12 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_ICMS_Fra_12, Ref ldc_ICMS_Fra_12) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Al$$HEX1$$ed00$$ENDHEX$$quota de ICMS fra$$HEX2$$e700e300$$ENDHEX$$o da venda 12% '" + ls_ICMS_Fra_12 + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Decimal(ls_Ipi, Ref ldc_Ipi) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Percentual de IPI '" + ls_Ipi + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	Return False
End If

If Not IsNumber(ls_Vigencia) And LenA(ls_Vigencia) <> 8 Then
	SetNull(ls_Vigencia)
End If

If Not IsNumber(ls_Ean) Then
	SetNull(ls_Ean)
End If

If Not IsNumber(ls_NCM) Then
	SetNull(ls_NCM)
End If

If Not IsNumber(ls_Registro_Ms) Then
	SetNull(ls_Registro_Ms)
End If

If Trim(ls_NCM) = "" Then SetNull(ls_NCM)
If Trim(ls_DCB) = "" Then SetNull(ls_DCB)
If Trim(ls_Registro_Ms) = "" Then SetNull(ls_Registro_Ms)

ls_Vigencia = MidA(ls_Vigencia, 1, 2) + "/" + MidA(ls_Vigencia, 3, 2) + "/" + MidA(ls_Vigencia, 5, 4)

ldt_Vigencia = Date(ls_Vigencia)

SetNull(ldc_Nulo)

ll_Linha = dw_2.InsertRow(0)

dw_2.Object.Med_Abc	[ll_Linha] = ls_Produto
dw_2.Object.Med_Ctr		[ll_Linha] = ls_Ctr
dw_2.Object.Lab_Nom	[ll_Linha] = Trim(ls_Nm_Lab)
dw_2.Object.Med_Des	[ll_Linha] = Trim(ls_Desc_Prd)
dw_2.Object.Med_Apr	[ll_Linha] = Trim(Apres_Prd)

dw_2.Object.Med_Pla20	[ll_Linha] = ldc_ICMS_Fab_20
dw_2.Object.Med_Pco20	[ll_Linha] = ldc_ICMS_Ven_20
dw_2.Object.Med_Fra20	[ll_Linha] = ldc_ICMS_Fra_20

dw_2.Object.Med_Pla19	[ll_Linha] = ldc_Nulo
dw_2.Object.Med_Pco19	[ll_Linha] = ldc_Nulo
dw_2.Object.Med_Fra19	[ll_Linha] = ldc_Nulo

dw_2.Object.Med_Pla18	[ll_Linha] = ldc_ICMS_Fab_18
dw_2.Object.Med_Pco18	[ll_Linha] = ldc_ICMS_Ven_18
dw_2.Object.Med_Fra18	[ll_Linha] = ldc_ICMS_Fra_18

dw_2.Object.Med_Pla17	[ll_Linha] = ldc_ICMS_Fab_17
dw_2.Object.Med_Pco17	[ll_Linha] = ldc_ICMS_Ven_17
dw_2.Object.Med_Fra17	[ll_Linha] = ldc_ICMS_Fra_17

dw_2.Object.Med_Pla12	[ll_Linha] = ldc_ICMS_Fab_12
dw_2.Object.Med_Pco12	[ll_Linha] = ldc_ICMS_Ven_12
dw_2.Object.Med_Fra12	[ll_Linha] = ldc_ICMS_Fra_12

dw_2.Object.Med_Ipi			[ll_Linha] = ldc_IPI
dw_2.Object.Med_Dtvig		[ll_Linha] = ldt_Vigencia
dw_2.Object.Exp_13			[ll_Linha] = ls_Campo_Logi
dw_2.Object.Med_Barra		[ll_Linha] = Trim(ls_Ean)
dw_2.Object.Med_Tipmed	[ll_Linha] = Trim(ls_Tipo_Med)
dw_2.Object.Med_NCM		[ll_Linha] = Trim(ls_NCM)
dw_2.Object.Med_DCB		[ll_Linha] = Trim(ls_DCB)
dw_2.Object.Med_Regims	[ll_Linha] = Trim(ls_Registro_Ms)

Return True
end function

public function boolean wf_decimal (string as_valor, ref decimal adc_valor);String lvs_Temp

If IsNumber(as_Valor) Then
	lvs_Temp = LeftA(as_Valor, LenA(as_Valor) - 2) + "," + RightA(as_Valor, 2)
	
	adc_Valor = Dec(lvs_Temp)
	Return True
Else
	Return False
End If
end function

public function boolean wf_replace_unicode (ref string as_json, ref string as_erro);String	ls_Caracteres[],&
		ls_Unicode[],&
		ls_Unicode_Aux,&
		ls_Caracter_Aux
		
Long ll_i

Try
		
	ls_Caracteres	[] = {"$$HEX1$$e100$$ENDHEX$$", "$$HEX1$$e000$$ENDHEX$$", "$$HEX1$$e200$$ENDHEX$$", "$$HEX1$$e300$$ENDHEX$$", "$$HEX1$$e400$$ENDHEX$$", "$$HEX1$$c100$$ENDHEX$$", "$$HEX1$$c000$$ENDHEX$$", "$$HEX1$$c200$$ENDHEX$$", "$$HEX1$$c300$$ENDHEX$$", "$$HEX1$$c400$$ENDHEX$$", "$$HEX1$$e900$$ENDHEX$$", "$$HEX1$$e800$$ENDHEX$$", "$$HEX1$$ea00$$ENDHEX$$", "$$HEX1$$c900$$ENDHEX$$", "$$HEX1$$c800$$ENDHEX$$", "$$HEX1$$ca00$$ENDHEX$$",&
								"$$HEX1$$cb00$$ENDHEX$$", "$$HEX1$$ed00$$ENDHEX$$", "$$HEX1$$ec00$$ENDHEX$$", "$$HEX1$$ee00$$ENDHEX$$", "$$HEX1$$ef00$$ENDHEX$$", "$$HEX1$$cd00$$ENDHEX$$", "$$HEX1$$cc00$$ENDHEX$$", "$$HEX1$$ce00$$ENDHEX$$", "$$HEX1$$cf00$$ENDHEX$$", "$$HEX1$$f300$$ENDHEX$$", "$$HEX1$$f200$$ENDHEX$$", "$$HEX1$$f400$$ENDHEX$$", "$$HEX1$$f500$$ENDHEX$$", "$$HEX1$$f600$$ENDHEX$$", "$$HEX1$$d300$$ENDHEX$$", "$$HEX1$$d200$$ENDHEX$$",&
								"$$HEX1$$d400$$ENDHEX$$", "$$HEX1$$d500$$ENDHEX$$", "$$HEX1$$d600$$ENDHEX$$", "$$HEX1$$fa00$$ENDHEX$$", "$$HEX1$$f900$$ENDHEX$$", "$$HEX1$$fb00$$ENDHEX$$", "$$HEX1$$fc00$$ENDHEX$$", "$$HEX1$$da00$$ENDHEX$$", "$$HEX1$$d900$$ENDHEX$$", "$$HEX1$$db00$$ENDHEX$$", "$$HEX1$$e700$$ENDHEX$$", "$$HEX1$$c700$$ENDHEX$$", "$$HEX1$$f100$$ENDHEX$$", "$$HEX1$$d100$$ENDHEX$$", "&", "'"}
	ls_Unicode		[] = {"\u00e1","\u00e0", "\u00e2", "\u00e3", "\u00e4", "\u00c1", "\u00c0", "\u00c2", "\u00c3", "\u00c4", "\u00e9", "\u00e8", "\u00ea", "\u00c9", "\u00c8", "\u00ca",&
								"\u00cb", "\u00ed", "\u00ec", "\u00ee", "\u00ef", "\u00cd", "\u00cc", "\u00ce", "\u00cf", "\u00f3", "\u00f2", "\u00f4", "\u00f5", "\u00f6", "\u00d3", "\u00d2",&
								"\u00d4", "\u00d5", "\u00d6", "\u00fa", "\u00f9", "\u00fb", "\u00fc", "\u00da", "\u00d9", "\u00db", "\u00e7", "\u00c7", "\u00f1", "\u00d1", "\u0026", "\u0027"}
								
	For ll_i = 1 To UpperBound(ls_Unicode[])
		ls_Unicode_Aux		= ls_Unicode[ll_i]
		
		If Pos(as_Json, ls_Unicode_Aux) > 0 Then
			ls_Caracter_Aux	= ls_Caracteres[ll_i]
			
			as_Json	= gf_Replace(as_Json, ls_Unicode_Aux, ls_Caracter_Aux, 0)
			
			ll_i --
		End If	
	Next
Catch (RuntimeError rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o wf_replace_unicode.~rErro: " + rte.getMessage()
	Return False
End Try	

Return True							
 

end function

public function boolean wf_abcfarma_webservice (long al_pagina, ref string as_json, ref string as_erro);//String ls_url
//String ls_argumentos
//String ls_headers
//
//Long ll_length
//Long ll_sucesso
//
//Blob lb_Args
//
//inet lo_Inet
//uo_internetresult lo_Result
//
//Try
//	Try
//		lo_Inet	= Create inet
//		lo_Result	= Create	uo_internetresult
//	
//		ls_url	= "https://webserviceabcfarma.org.br/webservice/"
//		
//		ls_argumentos = "cnpj_cpf=84683481000177&senha=acessoadmin&cnpj_sh=84683481000177&pagina="+String(al_Pagina)
//		
//		
//		lb_args	= blob( ls_argumentos, EncodingANSI! )
//		ll_length 	= Len(lb_Args)
//
//		ls_headers =	"Content-Type: application/x-www-form-urlencoded~n"+&
//							"Content-Length: " + String( ll_length ) + "~n~n"
//		
//		ll_Sucesso = lo_Inet.PostURL( ls_Url, lb_Args, ls_Headers, lo_Result )
//		
//		If ll_Sucesso <> 1 Then
//			Choose Case ll_Sucesso
//				Case -1 
//					as_Erro = 'General error'			
//				Case -2
//					as_Erro = 'Invalid URL'			
//				Case -4
//					as_Erro = 'Cannot connect to the Internet'
//				Case -5
//					as_Erro = 'Unsupported secure (HTTPS) connection attempted'
//				Case -6
//					as_Erro = 'Problema com Acesso ao Web Service (Internet request failed)'			
//			End Choose
//			
//			Return False
//		End If
//		
//		as_Json = lo_Result.is_data
//		
//	Catch (RuntimeError rte)
//		as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o wf_abcfarma_webservice.~rErro: " + rte.getMessage()
//		Return False
//	End Try	
//	
//Finally
//	Destroy(lo_Inet)
//	Destroy(lo_Result)
//End Try
//
//Return True
//


String	ls_Url,&
		ls_Argumentos,&
		ls_Status_Text
		
Long ll_Status_Code

OleObject lo_Http

Try
	Try
		lo_Http = CREATE oleobject
		
		lo_Http.ConnectToNewObject("Msxml2.XMLHTTP.6.0")
		
		ls_Url= "https://webserviceabcfarma.org.br/webservice/"
		
		ls_Argumentos	="cnpj_cpf=84683481000177&senha=acessoadmin&cnpj_sh=84683481000177&pagina="+String(al_Pagina)
		
		lo_Http.open ("POST",ls_Url, false)
		
		lo_Http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		lo_Http.setRequestHeader( "Authorization", "put here your auth code if any" )
		
		lo_Http.send(ls_Argumentos)
		
		ls_Status_Text = lo_Http.StatusText
		ll_Status_Code =  lo_Http.Status
		
		If ll_Status_Code > 200 Then
			as_Erro = "Erro no retorno do Web Service.~r~nC$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ "~r~nDescri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
			Return False
		Else
			as_Json = lo_Http.ResponseText
		End If
	
		lo_Http.DisconnectObject()
		
	Finally
		Destroy( lo_Http)
	End Try
	
Catch (RuntimeError rte)
	as_Erro = "Ocorreu erro ao consultar o WebService.~r~rErro: " + rte.getMessage()
	Return False
End Try


Return True

end function

public function boolean wf_processa_retorno_webservice (string as_json, ref long al_pagina, ref long al_total_pagina, ref long al_total_itens, ref string as_erro);uo_ge073_json	lo_Json

String	ls_Parte_Json,&
		ls_Dados_Campos,&
		ls_Id_Produto,&
		ls_Id_Regime_Preco,&
		ls_Nome_Fabricante,&
		ls_Nome,&
		ls_Descricao,&
		ls_Novo,&
		ls_EAN,&
		ls_Descricao_Tipo_Produto,&
		ls_NCM,&
		ls_DCB,&
		ls_Registro_Anvisa,&
		ls_Erro_Codigo,&
		ls_Erro_Mensagem

Decimal	ldc_Zero,&
			ldc_PF_20,&
			ldc_PMC_20,&
			ldc_PF_18,&
			ldc_PMC_18,&
			ldc_PF_17,&
			ldc_PMC_17,&
			ldc_PF_12,&
			ldc_PMC_12,&
			ldc_Percentual_IPI

Date ldt_Data_Vigencia

Long	ll_Linha,&
		ll_Count,&
		ll_Total_Data,&
		ll_Pos_1,&
		ll_Pos_2,&
		ll_Lenght

Try
	Try
		Open(w_Aguarde_1)
		
		w_Aguarde_1.y	 = w_Aguarde_1.y	+ 500
		
		w_Aguarde_1.Title = "Importando produtos... Aguarde."
	
		lo_Json = Create uo_ge073_json
		
		If Pos(as_Json, '"error_code"') > 0 Then
			ls_Erro_Codigo			= Trim(lo_Json.of_busca_conteudo_campo(as_Json, 'error_code'))
			ls_Erro_Mensagem	= Trim(lo_Json.of_busca_conteudo_campo(as_Json, 'error_message'))
		
			as_Erro = ls_Erro_Codigo + " - "+ ls_Erro_Mensagem
			Return False
		End If
		
		al_Pagina					= Long(lo_Json.of_busca_conteudo_campo(as_Json, 'pagina'))
		al_Total_Pagina			= Long(lo_Json.of_busca_conteudo_campo(as_Json, 'total_paginas'))
		ll_Total_Data				= Long(lo_Json.of_busca_conteudo_campo(as_Json, 'total_data'))
		al_Total_Itens				= Long(lo_Json.of_busca_conteudo_campo(as_Json, 'total_itens'))
		
		ll_Count = 0
		
		w_Aguarde_1.uo_Progress.of_SetMax(ll_Total_Data)
		
		//Dados dos produtos
		lo_Json.of_divide_grupo_json_tag(as_json, 'data', Ref ls_Parte_Json,']}')
	
		//Do While lo_Json.of_divide_grupo_json_completo(ls_Parte_Json, Ref ls_Dados_Campos,'{')
		Do While Pos(ls_Parte_Json, '{') > 0
			ll_Pos_1	= Pos(ls_Parte_Json, '{')
			ll_Pos_2	= Pos(ls_Parte_Json, '}')
			ll_Lenght	= Len( '}')
			
			ls_Dados_Campos	= Mid(ls_Parte_Json, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)
				
			ll_Count ++
			
			w_Aguarde_1.Title = "Importando produtos... "+String(ll_Count)+" de "+String(ll_Total_Data)+"."
			w_Aguarde_1.uo_Progress.of_SetProgress(ll_Count)
	
			ls_Id_Produto					= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'ID_PRODUTO')
			ls_Id_Regime_Preco			= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'ID_REGIME_PRECO')
			ls_Nome_Fabricante			= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'NOME_FABRICANTE')
			ls_Nome							= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'NOME')
			ls_Descricao						= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'DESCRICAO')
			
			ldc_PF_20						= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PF_20'), '.', ',', 0))
			ldc_PMC_20						= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PMC_20'), '.', ',', 0))
			ldc_PF_18						= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PF_18'), '.', ',', 0))
			ldc_PMC_18						= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PMC_18'), '.', ',', 0))
			ldc_PF_17						= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PF_17'), '.', ',', 0))
			ldc_PMC_17						= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PMC_17'), '.', ',', 0))
			ldc_PF_12						= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PF_12'), '.', ',', 0))
			ldc_PMC_12						= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PMC_12'), '.', ',', 0))
			ldc_Percentual_IPI				= Dec(gf_Replace(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'PERCENTUAL_IPI'), '.', ',', 0))
			ldt_Data_Vigencia				= Date(lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'DATA_VIGENCIA'))
			ls_Novo							= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'NOVO')
			ls_EAN							= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'EAN')
			ls_Descricao_Tipo_Produto	= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'DESCRICAO_TIPO_PRODUTO')
			ls_NCM							= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'NCM')
			ls_DCB							= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'DCB')
			ls_Registro_Anvisa				= lo_Json.of_busca_conteudo_campo(ls_Dados_Campos, 'REGISTRO_ANVISA')
			
			
			ll_Linha = dw_2.InsertRow(0)
	
			dw_2.Object.Med_Abc		[ll_Linha] = ls_Id_Produto
			dw_2.Object.Med_Ctr			[ll_Linha] = ls_Id_Regime_Preco
			dw_2.Object.Lab_Nom		[ll_Linha] = Trim(ls_Nome_Fabricante)
			dw_2.Object.Med_Des		[ll_Linha] = Trim(ls_Nome)
			dw_2.Object.Med_Apr		[ll_Linha] = Trim(ls_Descricao)
			
			dw_2.Object.Med_Pla20		[ll_Linha] = ldc_PF_20
			dw_2.Object.Med_Pco20		[ll_Linha] = ldc_PMC_20
			dw_2.Object.Med_Fra20		[ll_Linha] = 0.00
			
			dw_2.Object.Med_Pla18		[ll_Linha] = ldc_PF_18
			dw_2.Object.Med_Pco18		[ll_Linha] = ldc_PMC_18
			dw_2.Object.Med_Fra18		[ll_Linha] = 0.00
			
			dw_2.Object.Med_Pla17		[ll_Linha] = ldc_PF_17
			dw_2.Object.Med_Pco17		[ll_Linha] = ldc_PMC_17
			dw_2.Object.Med_Fra17		[ll_Linha] = 0.00
			
			dw_2.Object.Med_Pla12		[ll_Linha] = ldc_PF_12
			dw_2.Object.Med_Pco12		[ll_Linha] = ldc_PMC_12
			dw_2.Object.Med_Fra12		[ll_Linha] = 0.00
			
			dw_2.Object.Med_Ipi			[ll_Linha] = ldc_Percentual_IPI
			dw_2.Object.Med_Dtvig		[ll_Linha] = ldt_Data_Vigencia
			dw_2.Object.Exp_13			[ll_Linha] = ls_Novo
			dw_2.Object.Med_Barra		[ll_Linha] = Trim(ls_EAN)
			dw_2.Object.Med_Tipmed	[ll_Linha] = Trim(ls_Descricao_Tipo_Produto)
			dw_2.Object.Med_NCM		[ll_Linha] = Trim(ls_NCM)
			dw_2.Object.Med_DCB		[ll_Linha] = Trim(ls_DCB)
			dw_2.Object.Med_Regims	[ll_Linha] = ls_Registro_Anvisa
			
			//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida
			ls_Parte_Json = gf_Replace(ls_Parte_Json, ls_Dados_Campos, '', 0)
		Loop
		
	Catch (RuntimeError rte)
		as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o wf_processa_retorno_webservice.~rErro: " + rte.getMessage()
		Return False
	End Try
Finally
	Destroy(lo_Json)
	Close(w_Aguarde_1)
End Try

Return True
end function

public function boolean wf_inativa_cod_barras ();Long  ll_Cd_Produto,&
		ll_Cd_Produto_AbcFarma,&
		ll_Total1,&
		ll_Contador1,&
		ll_Total2,&
		ll_Contador2,&
		ll_minCodigoAbcFarma,&
		ll_Repetidos

String ls_De_Cod_Barras,&
		ls_Id_Situacao,&
		ls_Id_Principal

DateTime ldh_Atualizacao,&
				ldh_Vigencia,&
				ldh_vigencia_min,&
				ldh_vigencia_max
				
Decimal	ldc_fator_conversao,&
			ldc_preco_fabricante,&
			ldc_max_precoFabricante,&
			ldc_min_precoFabricante,&
			ldc_preco_venda_maximo		

Try
	// Busca Data Maxima de Atualiza$$HEX2$$e700e300$$ENDHEX$$o
	select max(dh_atualizacao)
	into :ldh_atualizacao
	from produto_abcfarma
	using SqlCA;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack()
		SqlCa.of_MsgdbError("Erro busca data Maxima Abc Farma")
		Return false   
	End If

	// Dw Com inform$$HEX2$$e700f500$$ENDHEX$$es : Primeira Atualizacao
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("dw_ge368_lista_cod_barras") Then
		SqlCa.of_Rollback()
		Return False
	End If
		
	SetPointer(HourGlass!)
	Open(w_Aguarde)
	w_Aguarde.Title = "Validando Duplicidades Dados ABC Farma..."

	ll_Total1 = lvds_1.Retrieve(Date(ldh_atualizacao))
	
	If ll_Total1 < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da 'dw_ge368_lista_cod_barras'.")
		Return false  
	End If
	
	// Dw Com inform$$HEX2$$e700f500$$ENDHEX$$es : Segunda Atualizacao
	dc_uo_ds_Base lvds_2
	lvds_2 = Create dc_uo_ds_Base
	If Not lvds_2.of_ChangeDataObject("dw_ge368_lista_cod_barras_datas") Then
		SqlCa.of_Rollback()
		Return False
	End If
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Total1)	

	// Loop de Atualiza$$HEX2$$e700e300$$ENDHEX$$o 1
	For ll_Contador1 = 1 To ll_Total1
		 ls_De_Cod_Barras		= lvds_1.Object.de_codigo_barras			[ll_Contador1]
		 ldh_vigencia				= lvds_1.Object.dh_vigencia					[ll_Contador1]	 
		 ls_Id_Principal				= lvds_1.Object.id_principal					[ll_Contador1]   
		 ls_Id_Situacao				= lvds_1.Object.id_situacao					[ll_Contador1]   
		 ldc_fator_conversao		= lvds_1.Object.vl_fator_conversao		[ll_Contador1]   
		 ldc_preco_fabricante		= lvds_1.Object.vl_preco_fabricante		[ll_Contador1]   
		 ll_cd_produto_abcfarma	= lvds_1.Object.cd_produto_abcfarma	[ll_Contador1]   
		 ll_Cd_Produto				= lvds_1.Object.cd_produto					[ll_Contador1]
		 ll_Repetidos				= lvds_1.Object.qt_repetido					[ll_Contador1]
		 
		 
		 If ll_Cd_Produto = 731136 Then
			ll_Cd_Produto = 731136
		End If
		
		If ll_Cd_Produto = 728639 Then
			ll_Cd_Produto = 728639
		End If
	 				 
		 // Primeira Regra:  Produto Inativo Elimina
		 If ls_Id_Situacao = 'I' Then 
			Update produto_abcfarma
			set 	  de_codigo_barras = de_codigo_barras + '_I'
			where  de_codigo_barras =:ls_De_Cod_Barras
			and      dh_atualizacao >= :ldh_atualizacao
			and 	  cd_produto_abcfarma =:ll_cd_produto_abcfarma
			and      de_codigo_barras not like '%I%'
			Using SqlCA;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack()
				SqlCa.of_MsgdbError("Erro atualiza inativos Abc Farma")
				Return false   
			End If
			
			If SqlCa.SqlNrows <> 1 Then
				SqlCa.of_RollBack()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deveria ter atualizado 1 registro mas atualizou "+String(SqlCa.SqlNrows)+" registros. Produto ABCFarma: "+String(ll_cd_produto_abcfarma)+".")
				Return false   
			End If
			
			SqlCa.of_Commit();
		Else
			
			//Produto com fator de convers$$HEX1$$e300$$ENDHEX$$o maior do que um e repetido. Considera apenas o produto com maior valor
			If (ldc_fator_conversao > 1) and (ll_Repetidos > 1) Then
				ll_Total2 = lvds_2.Retrieve(Date(ldh_atualizacao), ll_Cd_Produto)
				
				If ll_Total1 < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da 'dw_ge368_lista_cod_barras_datas'.")
					Return false  
				End If
				
				For ll_Contador2 = 1 To ll_Total2
					If ll_Contador2 > 1 Then
						
						ls_De_Cod_Barras				= lvds_2.Object.de_codigo_barras				[ll_Contador2]
						ll_cd_produto_abcfarma		= lvds_2.Object.cd_produto_abcfarma		[ll_Contador2]
						ldc_preco_venda_maximo	= lvds_2.Object.vl_preco_venda_maximo	[ll_Contador2]
						
						Update produto_abcfarma
						set 	  de_codigo_barras = de_codigo_barras + '_I'
						where  de_codigo_barras		=		:ls_De_Cod_Barras
						and      dh_atualizacao			>=	:ldh_atualizacao
						and      cd_produto_abcfarma	=		:ll_cd_produto_abcfarma 
						and      de_codigo_barras		not like '%I%'
						Using SqlCA;
						
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_RollBack()
							SqlCa.of_MsgdbError("Erro atualiza inativos Abc Farma")
							Return false   
						End If
						
						If SqlCa.SqlNrows <> 1 Then
							SqlCa.of_RollBack()
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deveria ter atualizado 1 registro mas atualizou "+String(SqlCa.SqlNrows)+" registros. Produto ABCFarma: "+String(ll_cd_produto_abcfarma)+".")
							Return false   
						End If
						
						SqlCa.of_Commit();
					End If
				Next
			End If
			
			//Produto sem fator de convers$$HEX1$$e300$$ENDHEX$$o e repetido
			If (ldc_fator_conversao = 1) and (ll_Repetidos > 1) and (ls_Id_Principal <> "S") Then
				Update produto_abcfarma
				set 	  de_codigo_barras = de_codigo_barras + '_I'
				where  de_codigo_barras		=		:ls_De_Cod_Barras
				and      dh_atualizacao			>=	:ldh_atualizacao
				and      cd_produto_abcfarma	=		:ll_cd_produto_abcfarma 
				and      de_codigo_barras		not like '%I%'
				Using SqlCA;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_RollBack()
					SqlCa.of_MsgdbError("Erro atualiza inativos Abc Farma")
					Return false   
				End If
				
				If SqlCa.SqlNrows <> 1 Then
					SqlCa.of_RollBack()
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deveria ter atualizado 1 registro mas atualizou "+String(SqlCa.SqlNrows)+" registros. Produto ABCFarma: "+String(ll_cd_produto_abcfarma)+".")
					Return false   
				End If
				
				SqlCa.of_Commit();	
			End If
			
			
			
//			// Segunda Regra:  Produto Ativo / EAN Duplicado / Pega Menor Vig$$HEX1$$ea00$$ENDHEX$$ncia e Inativa
//			ll_Total2 = lvds_2.Retrieve(Date(ldh_atualizacao), ls_De_Cod_Barras )
//	
//			If ll_Total2>0 Then 
//				For ll_Contador2=1 To ll_Total2
//					ldh_vigencia_max				=  lvds_2.Object.dh_vigencia_max		[ll_Contador2]		 
//					ldh_vigencia_min				= lvds_2.Object.dh_vigencia_min		[ll_Contador2]		
//					ll_minCodigoAbcFarma		=  lvds_2.Object.cd_prdAbcfarma		[ll_Contador2]		
//					ldc_max_precoFabricante	=  lvds_2.Object.max_preco				[ll_Contador2]		
//					ldc_min_precoFabricante		=  lvds_2.Object.min_preco				[ll_Contador2]		
//									
//					// Valida Datas diferentes: Inutiliza a menor data			
//					If ldh_vigencia_min <> ldh_vigencia_max Then 
//						Update produto_abcfarma
//						set 	  de_codigo_barras = de_codigo_barras + '_I'
//						where  de_codigo_barras =:ls_De_Cod_Barras
//						and      dh_atualizacao>=:ldh_atualizacao
//						and      dh_vigencia=:ldh_vigencia_min 
//						and      de_codigo_barras not like '%I%'
//						Using SqlCA;
//						
//						If SqlCa.SqlCode = -1 Then
//							SqlCa.of_RollBack()
//							SqlCa.of_MsgdbError("Erro atualiza inativos Abc Farma")
//							Return false   
//						End If				
//						SqlCa.of_Commit();
//					Else 
//						// Datas Iguais, Preco Maior : Inutiliza Registro Codigo Menor
//						If ldc_max_precoFabricante = ldc_min_precoFabricante Then 
//							Update produto_abcfarma
//							set 	  de_codigo_barras = de_codigo_barras + '_I'
//							where  de_codigo_barras =:ls_De_Cod_Barras
//							and      dh_atualizacao>=:ldh_atualizacao
//							and      de_codigo_barras not like '%I%'
//							and 	  cd_produto_abcfarma=:ll_minCodigoAbcFarma
//							Using SqlCA;
//						
//							If SqlCa.SqlCode = -1 Then
//								SqlCa.of_RollBack()
//								SqlCa.of_MsgdbError("Erro atualiza inativos Abc Farma")
//								Return false   
//							End If				
//							SqlCa.of_Commit();
//						End If 				
//					End If							
//				Next	
//			End If 
		End If 	
		w_Aguarde.uo_Progress.of_SetProgress(ll_Contador1)
	Next 
catch (runtimeerror lo_erro)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar dados inconsistentes ABC Farma. '" +  lo_erro.GetMessage() + "'.", StopSign!)
	Return False
finally
	Close(w_Aguarde)
End try

SetPointer(Arrow!)
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processo executado com sucesso.")

Return True
end function

public subroutine wf_exporta_planilha (datetime ldh_periodo);Long ll_Linhas
String ls_Diretorio, ls_Arquivo

dc_uo_ds_base lds_Relatorio
lds_Relatorio = Create dc_uo_ds_base

lds_Relatorio.of_ChangeDataObject("dw_ge368_lista_dados_excel")

ll_Linhas = lds_Relatorio.Retrieve(Date(ldh_periodo))

ls_Diretorio 		= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
ls_Arquivo 		= ls_Diretorio + "AlteracaoDesconto_" + String( ldh_periodo, 'ddmmyy_hh_mm_ss' )

Choose Case ll_Linhas
	
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi localizada." )
		
	Case is < 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw dw_ge368_lista_dados_excel " )
		
	Case is > 63000	//TEXTO
		If lds_Relatorio.SaveAs( ls_Arquivo + '.txt', TEXT!, True ) > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processo Finalizado: Arquivo salvo com sucesso.~r~rLocal: " + ls_Arquivo + '.txt')
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + ls_Arquivo + "'.txt" )
		End If

		
	Case Else //Excel
		If lds_Relatorio.SaveAs( ls_Arquivo + '.xls', EXCEL!, True ) > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Processo Finalizado : Arquivo salvo com sucesso.~r~rLocal: " + ls_Arquivo + '.xls')
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + ls_Arquivo + "'.xls" )
		End If
	
End Choose

Destroy lds_Relatorio

end subroutine

public function boolean wf_processa_detalhe_guia_da_farmacia (string as_registro);Long	ll_Posicao_Inicio,&
		ll_Posicao_Fim,&
		ll_Linha,&
		ll_Linha_Laboratorio,&
		ll_Find

String	ls_Codigo_Linha,&
		ls_Codigo_Prd,&
		ls_Nm_Produto,&
		ls_Cd_Laboratorio,&
		ls_Cd_Tipo_Prd,&
		ls_Cd_Portaria,&
		ls_Cd_Principio_Ativo,&
		ls_Generico,&
		ls_Classificacao_Fiscal,&
		ls_Codigo_Apresentacao,&
		ls_Sequencia,&
		ls_Apresentacao,&
		ls_Data_Inclusao,&
		ls_GGREM,&
		ls_Cd_ANVISA,&
		ls_EAN_ANVISA,&
		ls_Regist_Minist_Saude,&
		ls_Cd_ATC,&
		ls_Fracao,&
		ls_Cd_Apresent_Base,&
		ls_Cd_Apr_Base_Antigo,&
		ls_Fator_Divisao,&
		ls_Cd_Grupo_Anatomico,&
		ls_Cd_Grupo_Terapeut,&
		ls_Cd_Grupo_Farmacol,&
		ls_Cd_Grupo_Quimico,&
		ls_Tp_Preco,&
		ls_Liberado_Fabricante,&
		ls_Prd_Hospitalar,&
		ls_Cod_Barras,&
		ls_Vigencia,&
		ls_Ultima_Alteracao,&
		ls_Alteracao_Manual,&
		ls_Tipo_Alteracao,&
		ls_Alteracao_Via_XLS,&
		ls_Tipo_Lista,&
		ls_Cd_Antigo_Apresentacao,&
		ls_Cd_Antigo_Laboratorio,&
		ls_Preco_Fabrica_19,&
		ls_Preco_Fabrica_18,&
		ls_Preco_Fabrica_17,&
		ls_Preco_Fabrica_17_M,&
		ls_Preco_Fabrica_12,&
		ls_Preco_Maximo_19,&
		ls_Preco_Maximo_18,&
		ls_Preco_Maximo_17,&
		ls_Preco_Maximo_17_M,&
		ls_Preco_Maximo_12,&
		ls_Preco_Sugerido_19,&
		ls_Preco_Sugerido_18,&
		ls_Preco_Sugerido_17,&
		ls_Preco_Sugerido_17_M,&
		ls_Preco_Sugerido_12,&
		ls_Preco_Fabrica_20,&
		ls_Preco_Fabrica_18_M,&
		ls_Preco_Fabrica_17_5,&
		ls_Preco_Maximo_20,&
		ls_Preco_Maximo_18_M,&
		ls_Preco_Maximo_17_5,&
		ls_Preco_Sugerido_20,&
		ls_Preco_Sugerido_18_M,&
		ls_Preco_Sugerido_17_5,&
		ls_Nm_Fantasia_Laborat,&
		ls_Rasao_Social_Laborat
		
Decimal	ldc_Preco_Fabrica_20,&
			ldc_Preco_Maximo_20,&
			ldc_Preco_Fabrica_19,&
			ldc_Preco_Maximo_19,&
			ldc_Preco_Fabrica_18,&
			ldc_Preco_Maximo_18,&
			ldc_Preco_Fabrica_17,&
			ldc_Preco_Maximo_17,&
			ldc_Preco_Fabrica_12,&
			ldc_Preco_Maximo_12
			
		
ll_Posicao_Fim		= Pos(as_Registro, "|", 1)
ls_Codigo_Linha	= MidA(as_Registro, 1, ll_Posicao_Fim - 1)

If ls_Codigo_Linha = "01" Then
	
	ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
	ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
	ls_Cd_Laboratorio				=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)
	
	ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
	ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
	ls_Nm_Fantasia_Laborat		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)
	
	ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
	ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
	ls_Rasao_Social_Laborat		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

	ll_Linha_Laboratorio	= ids_Laboratorios.InsertRow(0)
	
	ids_Laboratorios.Object.cd_laboratorio	[ll_Linha_Laboratorio]	=	ls_Cd_Laboratorio
	ids_Laboratorios.Object.nm_laboratorio	[ll_Linha_Laboratorio]	=	ls_Nm_Fantasia_Laborat
	
End If

If ls_Codigo_Linha <> "20" Then
	Return True
End If		
		

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Codigo_Prd					=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Nm_Produto					=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Laboratorio				=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Tipo_Prd					=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Portaria					=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Principio_Ativo			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Generico						=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Classificacao_Fiscal		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Codigo_Apresentacao		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Sequencia					=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Apresentacao				=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Data_Inclusao				=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_GGREM						=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_ANVISA					=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_EAN_ANVISA				=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Regist_Minist_Saude		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_ATC						=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Fracao						=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Apresent_Base			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Apr_Base_Antigo		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Fator_Divisao				=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Grupo_Anatomico		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Grupo_Terapeut		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Grupo_Farmacol		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Grupo_Quimico			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Tp_Preco						=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Liberado_Fabricante		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Prd_Hospitalar				=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cod_Barras					=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Vigencia						=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Ultima_Alteracao			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Alteracao_Manual			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Tipo_Alteracao				=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Alteracao_Via_XLS			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Tipo_Lista					=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Antigo_Apresentacao	=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Cd_Antigo_Laboratorio	=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Fabrica_19			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Fabrica_18			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Fabrica_17			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Fabrica_17_M		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Fabrica_12			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Maximo_19			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Maximo_18			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Maximo_17			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Maximo_17_M		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Maximo_12			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Sugerido_19		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Sugerido_18		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Sugerido_17		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Sugerido_17_M	=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Sugerido_12	=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Fabrica_20			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Fabrica_18_M		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Fabrica_17_5		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Maximo_20			=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Maximo_18_M		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Maximo_17_5		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Sugerido_20		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Sugerido_18_M	=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)

ll_Posicao_Inicio				=	ll_Posicao_Fim + 1
ll_Posicao_Fim					=	Pos(as_Registro, "|", ll_Posicao_Inicio)
ls_Preco_Sugerido_17_5		=	MidA(as_Registro, ll_Posicao_Inicio, ll_Posicao_Fim - ll_Posicao_Inicio)
	

If Not IsNumber(ls_Codigo_Apresentacao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto '" + ls_Codigo_Apresentacao + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	Return False
End If


If ls_Preco_Fabrica_20 <> "" Then	ldc_Preco_Fabrica_20		= Dec(ls_Preco_Fabrica_20)	Else SetNull(ldc_Preco_Fabrica_20)
If ls_Preco_Maximo_20 <> "" Then	ldc_Preco_Maximo_20	= Dec(ls_Preco_Maximo_20)	Else SetNull(ldc_Preco_Maximo_20)
If ls_Preco_Fabrica_19 <> "" Then	ldc_Preco_Fabrica_19		= Dec(ls_Preco_Fabrica_19)	Else SetNull(ldc_Preco_Fabrica_19)
If ls_Preco_Maximo_19 <> "" Then	ldc_Preco_Maximo_19	= Dec(ls_Preco_Maximo_19)	Else SetNull(ls_Preco_Maximo_19)
If ls_Preco_Fabrica_18 <> "" Then	ldc_Preco_Fabrica_18		= Dec(ls_Preco_Fabrica_18)	Else SetNull(ldc_Preco_Fabrica_18)
If ls_Preco_Maximo_18 <> "" Then	ldc_Preco_Maximo_18	= Dec(ls_Preco_Maximo_18)	Else SetNull(ldc_Preco_Maximo_18)
If ls_Preco_Fabrica_17 <> "" Then	ldc_Preco_Fabrica_17		= Dec(ls_Preco_Fabrica_17)	Else SetNull(ldc_Preco_Fabrica_17)
If ls_Preco_Maximo_17 <> "" Then	ldc_Preco_Maximo_17	= Dec(ls_Preco_Maximo_17)	Else SetNull(ldc_Preco_Maximo_17)
If ls_Preco_Fabrica_12 <> "" Then	ldc_Preco_Fabrica_12		= Dec(ls_Preco_Fabrica_12)	Else SetNull(ldc_Preco_Fabrica_12)
If ls_Preco_Maximo_12 <> "" Then	ldc_Preco_Maximo_12	= Dec(ls_Preco_Maximo_12)	Else SetNull(ldc_Preco_Maximo_12)
			

ll_Linha = dw_2.InsertRow(0)

dw_2.Object.Med_Abc	[ll_Linha] = ls_Codigo_Apresentacao

dw_2.Object.Med_Ctr		[ll_Linha] = ls_Tp_Preco

dw_2.Object.Med_Des	[ll_Linha] = Trim(ls_Nm_Produto)
dw_2.Object.Med_Apr	[ll_Linha] = Trim(ls_Apresentacao)

dw_2.Object.Med_Pla20	[ll_Linha] = ldc_Preco_Fabrica_20
dw_2.Object.Med_Pco20	[ll_Linha] = ldc_Preco_Maximo_20
dw_2.Object.Med_Fra20	[ll_Linha] = 0.00 //????

dw_2.Object.Med_Pla19	[ll_Linha] = ldc_Preco_Fabrica_19
dw_2.Object.Med_Pco19	[ll_Linha] = ldc_Preco_Maximo_19
dw_2.Object.Med_Fra19	[ll_Linha] = 0.00 //????

dw_2.Object.Med_Pla18	[ll_Linha] = ldc_Preco_Fabrica_18
dw_2.Object.Med_Pco18	[ll_Linha] = ldc_Preco_Maximo_18
dw_2.Object.Med_Fra18	[ll_Linha] = 0.00 //????

dw_2.Object.Med_Pla17	[ll_Linha] = ldc_Preco_Fabrica_17
dw_2.Object.Med_Pco17	[ll_Linha] = ldc_Preco_Maximo_17
dw_2.Object.Med_Fra17	[ll_Linha] = 0.00 //????

dw_2.Object.Med_Pla12	[ll_Linha] = ldc_Preco_Fabrica_12
dw_2.Object.Med_Pco12	[ll_Linha] = ldc_Preco_Maximo_12
dw_2.Object.Med_Fra12	[ll_Linha] = 0.00 //????

dw_2.Object.Med_Ipi		[ll_Linha] = 0.00 //????
dw_2.Object.Med_Dtvig	[ll_Linha] = Date(ls_Vigencia)

If ls_Tipo_Alteracao = "N" Then //Produto Novo
	dw_2.Object.Exp_13	[ll_Linha] = "S"
Else
	dw_2.Object.Exp_13	[ll_Linha] = "N"
End If

If ls_Generico = "S" Then
	dw_2.Object.Med_Tipmed	[ll_Linha]	= "SIM"
ELSE
	dw_2.Object.Med_Tipmed	[ll_Linha]	= "N$$HEX1$$c300$$ENDHEX$$O"
End If

dw_2.Object.Med_Barra		[ll_Linha]	= Trim(ls_Cod_Barras)
dw_2.Object.Med_NCM		[ll_Linha]	= gf_Replace(Trim(ls_Classificacao_Fiscal), ".", "", 0)
dw_2.Object.Med_DCB		[ll_Linha] = ""
dw_2.Object.Med_Regims	[ll_Linha] = Trim(ls_Regist_Minist_Saude)

ll_Find	=ids_Laboratorios.Find("cd_laboratorio = '"+ls_Cd_Laboratorio+"'", 1, ids_Laboratorios.RowCount())

If ll_Find < 0 Then
	MessageBox("Erro", "Erro no Find que localiza o nome do laborat$$HEX1$$f300$$ENDHEX$$rio.")
	Return False
End If

If ll_Find > 0 Then
	dw_2.Object.Lab_Nom	[ll_Linha] = ids_Laboratorios.Object.nm_laboratorio[ll_Find]
End If

Return True
end function

on w_ge368_leitura_arquivo_abcfarma.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_gravar=create cb_gravar
this.cb_ler_arquivo=create cb_ler_arquivo
this.cb_sair=create cb_sair
this.cb_procurar=create cb_procurar
this.dw_1=create dw_1
this.gb_2=create gb_2
this.dw_2=create dw_2
this.cb_ler_webservice=create cb_ler_webservice
this.cb_exportar_excel=create cb_exportar_excel
this.cb_validar=create cb_validar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_gravar
this.Control[iCurrent+3]=this.cb_ler_arquivo
this.Control[iCurrent+4]=this.cb_sair
this.Control[iCurrent+5]=this.cb_procurar
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.cb_ler_webservice
this.Control[iCurrent+10]=this.cb_exportar_excel
this.Control[iCurrent+11]=this.cb_validar
end on

on w_ge368_leitura_arquivo_abcfarma.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_gravar)
destroy(this.cb_ler_arquivo)
destroy(this.cb_sair)
destroy(this.cb_procurar)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.dw_2)
destroy(this.cb_ler_webservice)
destroy(this.cb_exportar_excel)
destroy(this.cb_validar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()

ids_Laboratorios = Create dc_uo_ds_base

If Not ids_Laboratorios.of_ChangeDataObject("ds_ge368_laboratorios") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge368_laboratorios'.", StopSign!)
	Close(This)
	Return
End If


//Par$$HEX1$$e200$$ENDHEX$$metro
select cast(vl_parametro as date)
Into :idt_Parametro
from parametro_geral
where cd_parametro = 'DT_INICIO_IMPORTACAO_GUIA_FARMACIA'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Date(gf_GetServerDate()) >= idt_Parametro Then
			ib_Guia_Da_Farmacia = True
			
			This.title = "GE368 - Leitura do Arquivo Guia da Farm$$HEX1$$e100$$ENDHEX$$cia"
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro 'DT_INICIO_IMPORTACAO_GUIA_FARMACIA'.")
		Close(This)
		Return
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro 'DT_INICIO_IMPORTACAO_GUIA_FARMACIA'.")
		Close(This)
		Return
End Choose
end event

event close;call super::close;Destroy(ids_Laboratorios)

end event

event open;call super::open;ib_Guia_Da_Farmacia = False
end event

type pb_help from dc_w_response`pb_help within w_ge368_leitura_arquivo_abcfarma
end type

type gb_1 from groupbox within w_ge368_leitura_arquivo_abcfarma
integer x = 18
integer y = 272
integer width = 3922
integer height = 1388
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Conte$$HEX1$$fa00$$ENDHEX$$do do Arquivo"
borderstyle borderstyle = styleraised!
end type

type cb_gravar from commandbutton within w_ge368_leitura_arquivo_abcfarma
integer x = 3077
integer y = 1688
integer width = 384
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Gravar"
end type

event clicked;Boolean lvb_Sucesso = True

Long lvl_Contador, &
	  lvl_Produto_Leitura, &
	  lvl_Produto_AbcFarma,&
	  ll_NCM
	  
String lvs_Controle_Preco, &
		 lvs_Fabricante, &
		 lvs_Descricao, &
		 lvs_Apresentacao, &
		 lvs_Produto_Novo,&
		 ls_Registro_MS,&
		 ls_DCB,&
		 ls_EAN
		  
Decimal	lvdc_Fabricante_17, &
			lvdc_Venda_17, &
			lvdc_Fabricante_18, &
			lvdc_Venda_18, &
			lvdc_Fabricante_12, &
			lvdc_Venda_12, &
			lvdc_Fabricante_20, &
			lvdc_Venda_20, &
			lvdc_Fabricante_19, &
			lvdc_Venda_19, &
			lvdc_IPI

Date lvdt_Vigencia

DateTime lvdh_Atualizacao

SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Gravando Informa$$HEX2$$e700f500$$ENDHEX$$es do Arquivo..."

lvdh_Atualizacao = gf_GetServerDate()

w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())

try 
	SqlCa.autocommit  =  True

	For lvl_Contador = 1 To dw_2.RowCount()
		lvl_Produto_Leitura = Long(dw_2.Object.Med_Abc[lvl_Contador])
		
		lvs_Controle_Preco  	= dw_2.Object.Med_Ctr  		[lvl_Contador]
		lvs_Fabricante      		= dw_2.Object.Lab_Nom  		[lvl_Contador]
		lvs_Descricao       		= dw_2.Object.Med_Des  		[lvl_Contador]
		lvs_Apresentacao    	= dw_2.Object.Med_Apr  		[lvl_Contador]
		lvs_Produto_Novo    	= dw_2.Object.Exp_13   			[lvl_Contador]
		lvdc_Fabricante_17  	= dw_2.Object.Med_Pla17		[lvl_Contador]
		lvdc_Venda_17       	= dw_2.Object.Med_Pco17		[lvl_Contador]
		lvdc_Fabricante_18  	= dw_2.Object.Med_Pla18		[lvl_Contador]
		lvdc_Venda_18       	= dw_2.Object.Med_Pco18		[lvl_Contador]
		lvdc_Fabricante_12  	= dw_2.Object.Med_Pla12		[lvl_Contador]
		lvdc_Venda_12       	= dw_2.Object.Med_Pco12		[lvl_Contador]
		lvdc_Fabricante_20  	= dw_2.Object.Med_Pla20		[lvl_Contador]
		lvdc_Venda_20       	= dw_2.Object.Med_Pco20		[lvl_Contador]
		lvdc_Fabricante_19  	= dw_2.Object.Med_Pla19		[lvl_Contador]
		lvdc_Venda_19       	= dw_2.Object.Med_Pco19		[lvl_Contador]
		lvdc_IPI            		= dw_2.Object.Med_IPI  			[lvl_Contador]
		lvdt_Vigencia       		= dw_2.Object.Med_DtVig		[lvl_Contador]
		ls_Registro_MS    		= dw_2.Object.Med_Regims	[lvl_Contador]
		ll_NCM    				= Long(dw_2.Object.Med_Ncm	[lvl_Contador])
		ls_DCB    				= dw_2.Object.Med_Dcb			[lvl_Contador]
		ls_EAN					= dw_2.Object.med_barra		[lvl_Contador]
							
		lvs_Descricao    		= Upper(Trim(lvs_Descricao))
		lvs_Apresentacao 		= Upper(Trim(lvs_Apresentacao))
		lvs_Fabricante   		= Upper(Trim(lvs_Fabricante))
		
		If lvs_Produto_Novo = "T" Then 
			lvs_Produto_Novo = "S"
		Else
			lvs_Produto_Novo = "N"
		End If	
		
		Select cd_produto_abcfarma
			Into :lvl_Produto_AbcFarma
		From produto_abcfarma
		Where cd_produto_abcfarma = :lvl_Produto_Leitura
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				Update produto_abcfarma
				Set id_controle_preco				= :lvs_Controle_Preco,
					 nm_fabricante					= :lvs_Fabricante,
					 de_produto						= :lvs_Descricao,
					 de_apresentacao				= :lvs_Apresentacao,
					 vl_preco_fabricante			= :lvdc_Fabricante_17,
					 vl_preco_venda_maximo	= :lvdc_Venda_17,
					 pc_ipi							= :lvdc_IPI,
					 dh_vigencia						= :lvdt_Vigencia,
					 id_produto_novo				= :lvs_Produto_Novo,
					 dh_atualizacao					= :lvdh_Atualizacao,
					 vl_preco_fabricante_18		= :lvdc_Fabricante_18,
					 vl_preco_venda_18			= :lvdc_Venda_18,
					 vl_preco_fabricante_12		= :lvdc_Fabricante_12,
					 vl_preco_venda_12			= :lvdc_Venda_12,
					 vl_preco_fabricante_19		= :lvdc_Fabricante_19,
					 vl_preco_venda_19			= :lvdc_Venda_19,
					 vl_preco_fabricante_20		= :lvdc_Fabricante_20,
					 vl_preco_venda_20			= :lvdc_Venda_20,
					 de_registro_ms				= :ls_Registro_MS,
					 nr_ncm							= :ll_NCM,
					 cd_dcb							= :ls_DCB,
					 de_codigo_barras				= :ls_EAN
				Where cd_produto_abcfarma	= :lvl_Produto_Leitura
				Using SqlCa;
	
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_RollBack()
					SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Produto ABC Farma")
					lvb_Sucesso = False
					Exit
				End If
				
			Case 100
				Insert Into produto_abcfarma (cd_produto_abcfarma,
														id_controle_preco,
														nm_fabricante,
														de_produto,
														de_apresentacao,
														vl_preco_fabricante,
														vl_preco_venda_maximo,
														pc_ipi,
														dh_vigencia,
														id_produto_novo,
														dh_atualizacao,
														vl_preco_fabricante_18,
														vl_preco_venda_18,
														vl_preco_fabricante_12,
														vl_preco_venda_12,
														vl_preco_fabricante_19,
														vl_preco_venda_19,
														vl_preco_fabricante_20,
														vl_preco_venda_20,
														de_registro_ms,
														nr_ncm,
														cd_dcb,
														de_codigo_barras)
				Values (:lvl_Produto_Leitura,
						  :lvs_controle_preco,
						  :lvs_Fabricante,
						  :lvs_Descricao,
						  :lvs_Apresentacao,
						  :lvdc_Fabricante_17,
						  :lvdc_Venda_17,
						  :lvdc_ipi,
						  :lvdt_vigencia,
						  :lvs_produto_novo,
						  :lvdh_Atualizacao,
						  :lvdc_Fabricante_18,
						  :lvdc_Venda_18,
						  :lvdc_Fabricante_12,
						  :lvdc_Venda_12,
						  :lvdc_Fabricante_19,
						  :lvdc_Venda_19,
						  :lvdc_Fabricante_20,
						  :lvdc_Venda_20,
						  :ls_Registro_MS,
						  :ll_NCM,
						  :ls_DCB,
						  :ls_EAN)
				Using SqlCa;
			
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_RollBack()
					SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Produto ABC Farma")		
					lvb_Sucesso = False
					Exit				
				End If
		End Choose
					
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next

catch (runtimeerror lo_erro)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o produto central. '" +  lo_erro.GetMessage() + "'.", StopSign!)
	Return -1
finally
	SqlCa.autocommit  =  False
	Close(w_Aguarde)
end try

If lvb_Sucesso Then
	Update parametro
		Set dh_leitura_abcfarma = :lvdh_Atualizacao
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Leitura do Arquivo")
		lvb_Sucesso = False
	End If
End If	

If lvb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do arquivo realizada com sucesso.")
	
	dw_2.Event ue_Reset()
	cb_Gravar.Enabled      		= False
	cb_Ler_Arquivo.Enabled		= False
	cb_ler_webservice.Enabled	=True
	cb_validar.Enabled 			= True
	
	dw_1.Event ue_Retrieve()
Else
	SqlCa.of_RollBack();
End If

SetPointer(Arrow!)
end event

type cb_ler_arquivo from commandbutton within w_ge368_leitura_arquivo_abcfarma
integer x = 2665
integer y = 1688
integer width = 384
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Ler Arquivo"
end type

event clicked;String lvs_Arquivo

Long lvl_Linhas

Date ldt_Parametro

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.De_Arquivo[1]

If Not FileExists(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + lvs_Arquivo + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
	Return
End If

dw_2.Event ue_Reset()
	
//lvl_Linhas = dw_2.ImportFile(lvs_Arquivo)

//If lvl_Linhas <= 0 Then 
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
//	Return
//End If

// N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais necess$$HEX1$$e100$$ENDHEX$$rio rodar esta fun$$HEX2$$e700e300$$ENDHEX$$o no PB12
//wf_Corrige_Decimais()

If Not wf_Processa_Importacao(lvs_Arquivo) Then Return -1

dw_2.Sort()

cb_Gravar.Enabled = True
cb_Gravar.SetFocus()
end event

type cb_sair from commandbutton within w_ge368_leitura_arquivo_abcfarma
integer x = 3557
integer y = 1688
integer width = 384
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sai&r"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_procurar from commandbutton within w_ge368_leitura_arquivo_abcfarma
integer x = 3351
integer y = 164
integer width = 590
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Procurar Arquivo..."
end type

event clicked;Integer lvi_Arquivo

String lvs_Path, &
       lvs_Arquivo
		 
If ib_Guia_Da_Farmacia Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A partir do dia "+String(idt_Parametro, "dd/mm/yyyy")+" dever$$HEX1$$e100$$ENDHEX$$ ser importado o arquivo do GUIA DA FARM$$HEX1$$c100$$ENDHEX$$CIA.")
	
	lvi_Arquivo = GetFileOpenName("Selecione o Arquivo Guia da Farm$$HEX1$$e100$$ENDHEX$$cia", lvs_Path, lvs_Arquivo, "", "Arquivos DBase (*.TXT), *.TXT")
Else
	lvi_Arquivo = GetFileOpenName("Selecione o Arquivo ABC Farma", lvs_Path, lvs_Arquivo, "", "Arquivos DBase (*.TXT), *.TXT")
End If

If lvi_Arquivo = 1 Then
	dw_1.Object.De_Arquivo[1] = Upper(lvs_Path)
	cb_Ler_Arquivo.Enabled = True
Else
	dw_1.Object.De_Arquivo[1] = ""
	cb_Ler_Arquivo.Enabled = False
End If
end event

type dw_1 from dc_uo_dw_base within w_ge368_leitura_arquivo_abcfarma
integer x = 41
integer y = 64
integer width = 2770
integer height = 184
integer taborder = 70
string dataobject = "dw_ge368_selecao"
end type

type gb_2 from groupbox within w_ge368_leitura_arquivo_abcfarma
integer x = 18
integer width = 2802
integer height = 260
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o do Arquivo"
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within w_ge368_leitura_arquivo_abcfarma
integer x = 59
integer y = 320
integer width = 3849
integer height = 1316
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge368_lista"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

type cb_ler_webservice from commandbutton within w_ge368_leitura_arquivo_abcfarma
integer x = 2176
integer y = 1688
integer width = 466
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Ler WebService"
end type

event clicked;String	ls_Json,&
		ls_Erro
		
Boolean	lb_Sucesso = False

Long	ll_Total_Itens,&
		ll_Total_Pagina,&
		ll_Pagina = 0
		
If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja buscar as informa$$HEX2$$e700f500$$ENDHEX$$es no WebService da ABC FARMA?", Question!, YesNo!, 1) = 2 Then
	Return
End If

Try
	Open(w_Aguarde)
	w_Aguarde.Title = "Importando p$$HEX1$$e100$$ENDHEX$$ginas... Aguarde."
	
	dw_2.SetRedRaw(False)
		
	DO	
		ll_Pagina ++
		
		If ll_Pagina = 1 Then
			w_Aguarde.Title = "Importando p$$HEX1$$e100$$ENDHEX$$gina 1."
		Else
			w_Aguarde.Title = "Importando p$$HEX1$$e100$$ENDHEX$$gina "+String(ll_Pagina)+" de "+String(ll_Total_Pagina)+"."
		End If
		
		If wf_Abcfarma_Webservice (ll_Pagina, Ref ls_Json, Ref ls_Erro) Then
			If wf_replace_unicode(Ref ls_Json, Ref ls_Erro) Then
				If wf_Processa_Retorno_Webservice(ls_Json, Ref ll_Pagina, Ref ll_Total_Pagina, Ref ll_Total_Itens, Ref ls_Erro) Then
					lb_Sucesso = True
				End If	
			End If
		End If
		
		If Not lb_Sucesso Then
			MessageBox("Erro", ls_Erro)
			dw_2.Reset()
			Return -1
		End If
		
		If ll_Pagina = 1 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Total_Pagina)
		End If
		
		If ll_Pagina > 0 Then
			w_Aguarde.uo_Progress.of_SetProgress(ll_Pagina)
		End If
		
	LOOP WHILE ll_Pagina < ll_Total_Pagina
	
Finally
	dw_2.SetRedRaw(True)
	Close(w_Aguarde)
End Try

If ll_Total_Itens <> dw_2.RowCount() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deveria ter importado "+String(ll_Total_Itens)+" itens, importou "+String(dw_2.RowCount())+".~rTente importar novamente.")
	dw_2.Reset()
	Return 1
End If

dw_2.Sort()

cb_ler_webservice.Enabled	= False
cb_Gravar.Enabled				= True
cb_Gravar.SetFocus()
end event

type cb_exportar_excel from commandbutton within w_ge368_leitura_arquivo_abcfarma
integer x = 14
integer y = 1688
integer width = 457
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exportar Excel"
end type

event clicked;If dw_2.RowCount() < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhum registro para ser salvo.")
	Return 1
End If

dw_2.Event ue_SaveAs()
end event

type cb_validar from commandbutton within w_ge368_leitura_arquivo_abcfarma
integer x = 498
integer y = 1688
integer width = 631
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Corrigir Duplicidade"
end type

event clicked;datetime ldh_atualizacao

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja corrigir as informa$$HEX2$$e700f500$$ENDHEX$$es carregadas ABC FARMA?", Question!, YesNo!, 1) = 2 Then
	Return
End If

wf_inativa_cod_barras()

select max(dh_atualizacao)
into :ldh_atualizacao
from produto_abcfarma
using SqlCA;
	
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack()
	SqlCa.of_MsgdbError("Erro busca data Maxima Abc Farma")
	Return -1   
End If

wf_exporta_planilha(ldh_atualizacao) 

end event

