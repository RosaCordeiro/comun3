HA$PBExportHeader$w_ge101_importa_produtos_excel.srw
forward
global type w_ge101_importa_produtos_excel from dc_w_response
end type
type cb_confirma from commandbutton within w_ge101_importa_produtos_excel
end type
type gb_1 from groupbox within w_ge101_importa_produtos_excel
end type
type dw_1 from dc_uo_dw_base within w_ge101_importa_produtos_excel
end type
type pb_selecao from picturebutton within w_ge101_importa_produtos_excel
end type
type cb_cancelar from commandbutton within w_ge101_importa_produtos_excel
end type
type dw_2 from datawindow within w_ge101_importa_produtos_excel
end type
end forward

global type w_ge101_importa_produtos_excel from dc_w_response
integer width = 2139
integer height = 500
string title = "GE101 - Importa Produtos"
long backcolor = 80269524
cb_confirma cb_confirma
gb_1 gb_1
dw_1 dw_1
pb_selecao pb_selecao
cb_cancelar cb_cancelar
dw_2 dw_2
end type
global w_ge101_importa_produtos_excel w_ge101_importa_produtos_excel

type variables

end variables

forward prototypes
public function boolean wf_lojas (ref long al_lojas)
public function boolean wf_coluna (long al_linha, ref string as_coluna)
public function boolean wf_atualiza_cota (long al_filial, datetime adh_dia, decimal adc_valor, string as_tipo)
public function boolean wf_existe_filial (ref long al_filial)
end prototypes

public function boolean wf_lojas (ref long al_lojas);Select Count(cd_filial)
Into :al_Lojas
From filial
Where id_situacao = 'A'
  and cd_filial <> 534
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das filiais ativas")
	Return False
End If

Return True
end function

public function boolean wf_coluna (long al_linha, ref string as_coluna);Choose Case al_Linha
	Case 	1	; as_Coluna = "A"
	Case 	2	; as_Coluna = "B"
	Case 	3	; as_Coluna = "C"
	Case 	4	; as_Coluna = "D"
	Case 	5	; as_Coluna = "E"
	Case 	6	; as_Coluna = "F"
	Case 	7	; as_Coluna = "G"
	Case 	8	; as_Coluna = "H"
	Case 	9	; as_Coluna = "I"
	Case 	10	; as_Coluna = "J"
	Case 	11	; as_Coluna = "K"
	Case 	12	; as_Coluna = "L"
	Case 	13	; as_Coluna = "M"
	Case 	14	; as_Coluna = "N"
	Case 	15	; as_Coluna = "O"
	Case 	16	; as_Coluna = "P"
	Case 	17	; as_Coluna = "Q"
	Case 	18	; as_Coluna = "R"
	Case 	19	; as_Coluna = "S"
	Case 	20	; as_Coluna = "T"
	Case 	21	; as_Coluna = "U"
	Case 	22	; as_Coluna = "V"
	Case   	23	; as_Coluna = "W"
	Case 	24	; as_Coluna = "X"
	Case 	25	; as_Coluna = "Y"
	Case 	26	; as_Coluna = "Z"
	Case 	27	; as_Coluna = "AA"
	Case 	28	; as_Coluna = "AB"
	Case 	29	; as_Coluna = "AC"
	Case 	30	; as_Coluna = "AD"
	Case 	31	; as_Coluna = "AE"
	Case 	32	; as_Coluna = "AF"
	Case 	33	; as_Coluna = "AG"
	Case 	34	; as_Coluna = "AH"
	Case 	35	; as_Coluna = "AI"
	Case 	36	; as_Coluna = "AJ"
	Case 	37	; as_Coluna = "AK"
	Case 	38	; as_Coluna = "AL"
	Case 	39	; as_Coluna = "AM"
	Case 	40	; as_Coluna = "AN"
	Case 	41	; as_Coluna = "AO"
	Case 	42	; as_Coluna = "AP"
	Case 	43	; as_Coluna = "AQ"
	Case 	44	; as_Coluna = "AR"
	Case 	45	; as_Coluna = "AS"
	Case 	46	; as_Coluna = "AT"
	Case 	47	; as_Coluna = "AU"
	Case 	48	; as_Coluna = "AV"
	Case 	49	; as_Coluna = "AW"
	Case 	50	; as_Coluna = "AX"
	Case 	51	; as_Coluna = "AY"
	Case 	52	; as_Coluna = "AZ"
	Case 	53	; as_Coluna = "BA"
	Case 	54	; as_Coluna = "BB"
	Case 	55	; as_Coluna = "BC"
	Case 	56	; as_Coluna = "BD"
	Case 	57	; as_Coluna = "BE"
	Case 	58	; as_Coluna = "BF"
	Case 	59	; as_Coluna = "BG"
	Case 	60	; as_Coluna = "BH"
	Case 	61	; as_Coluna = "BI"
	Case 	62	; as_Coluna = "BJ"
	Case 	63	; as_Coluna = "BK"
	Case 	64	; as_Coluna = "BL"
	Case 	65	; as_Coluna = "BM"
	Case 	66	; as_Coluna = "BN"
	Case 	67	; as_Coluna = "BO"
	Case 	68	; as_Coluna = "BP"
	Case 	69	; as_Coluna = "BQ"
	Case 	70	; as_Coluna = "BR"
	Case 	71	; as_Coluna = "BS"
	Case 	72	; as_Coluna = "BT"
	Case 	73	; as_Coluna = "BU"
	Case 	74	; as_Coluna = "BV"
	Case 	75	; as_Coluna = "BW"
	Case 	76	; as_Coluna = "BX"
	Case 	77	; as_Coluna = "BY"
	Case 	78	; as_Coluna = "BZ"
	Case 	79	; as_Coluna = "CA"
	Case 	80	; as_Coluna = "CB"
	Case 	81	; as_Coluna = "CC"
	Case 	82	; as_Coluna = "CD"
	Case 	83	; as_Coluna = "CE"
	Case 	84	; as_Coluna = "CF"
	Case 	85	; as_Coluna = "CG"
	Case 	86	; as_Coluna = "CH"
	Case 	87	; as_Coluna = "CI"
	Case 	88	; as_Coluna = "CJ"
	Case 	89	; as_Coluna = "CK"
	Case 	90	; as_Coluna = "CL"
	Case 	91	; as_Coluna = "CM"
	Case 	92	; as_Coluna = "CN"
	Case	93	; as_Coluna = "CO"
	Case	94	; as_Coluna = "CP"
	Case	95	; as_Coluna = "CQ"
	Case	96	; as_Coluna = "CR"
	Case	97	; as_Coluna = "CS"
	Case	98	; as_Coluna = "CT"
	Case	99	; as_Coluna = "CU"
	Case	100	; as_Coluna = "CV"
	Case	101	; as_Coluna = "CW"
	Case	102	; as_Coluna = "CX"
	Case	103	; as_Coluna = "CY"
	Case	104	; as_Coluna = "CZ"
	Case	105	; as_Coluna = "DA"
	Case	106	; as_Coluna = "DB"
	Case	107	; as_Coluna = "DC"
	Case	108	; as_Coluna = "DD"
	Case	109	; as_Coluna = "DE"
	Case	110	; as_Coluna = "DF"
	Case	111	; as_Coluna = "DG"
	Case	112	; as_Coluna = "DH"
	Case	113	; as_Coluna = "DI"
	Case	114	; as_Coluna = "DJ"
	Case	115	; as_Coluna = "DK"
	Case	116	; as_Coluna = "DL"
	Case	117	; as_Coluna = "DM"
	Case	118	; as_Coluna = "DN"
	Case	119	; as_Coluna = "DO"
	Case	120	; as_Coluna = "DP"
	Case	121	; as_Coluna = "DQ"
	Case	122	; as_Coluna = "DR"
	Case	123	; as_Coluna = "DS"
	Case	124	; as_Coluna = "DT"
	Case	125	; as_Coluna = "DU"
	Case	126	; as_Coluna = "DV"
	Case	127	; as_Coluna = "DW"
	Case	128	; as_Coluna = "DX"
	Case	129	; as_Coluna = "DY"
	Case	130	; as_Coluna = "DZ"
	Case Else  
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Coluna n$$HEX1$$e300$$ENDHEX$$o cadastrada '" + String(al_Linha) + "'.")
		Return False
End Choose

Return True
end function

public function boolean wf_atualiza_cota (long al_filial, datetime adh_dia, decimal adc_valor, string as_tipo);Long lvl_Existe

String lvs_Chave

lvs_Chave = String(al_Filial, "0000") + " - " + String(adh_Dia, "dd/mm/yyyy") + " - "

Select cd_filial Into :lvl_Existe
From cota_filial
Where cd_filial = :al_Filial
  and dh_cota   = :adh_Dia 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		// CIA
		If as_Tipo = "C" Then
			Update cota_filial
			Set vl_cota = :adc_valor
			Where cd_filial = :al_Filial
			  and dh_cota   = :adh_Dia 
			Using SqlCa;
		Else
			// Filial
			Update cota_filial
			Set vl_cota_filial = :adc_valor
			Where cd_filial = :al_Filial
			  and dh_cota   = :adh_Dia 
			Using SqlCa;
		End If
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError(lvs_Chave + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Cota")
			Return False
		End If
		
	Case 100
		// CIA
		If as_Tipo = "C" Then
			Insert Into cota_filial (cd_filial,   
									 dh_cota,   
									 vl_cota)
			Values (:al_Filial,   
					:adh_Dia,   
					:adc_valor)
			Using SqlCa;
		Else
			// Filial
			Insert Into cota_filial (cd_filial,   
									 dh_cota,   
									 vl_cota_filial)
			Values (:al_Filial,   
					:adh_Dia,   
					:adc_valor)
			Using SqlCa;
		End If

		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError(lvs_Chave + "Inclus$$HEX1$$e300$$ENDHEX$$o da Cota")
			Return False
		End If
		
	Case -1
		SqlCa.of_MsgdbError(lvs_Chave + "Localiza$$HEX2$$e700e300$$ENDHEX$$o da Cota")
		Return False
End Choose
	
		
Return True
end function

public function boolean wf_existe_filial (ref long al_filial);Long lvl_Filial 

Select cd_filial
Into :lvl_Filial
From filial
Where cd_filial =:al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizada.")
		al_Filial = 0
	Case -1
		SqlCa.of_MsgDBError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Filial")
		Return False
End Choose

Return True
end function

on w_ge101_importa_produtos_excel.create
int iCurrent
call super::create
this.cb_confirma=create cb_confirma
this.gb_1=create gb_1
this.dw_1=create dw_1
this.pb_selecao=create pb_selecao
this.cb_cancelar=create cb_cancelar
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_confirma
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.pb_selecao
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.dw_2
end on

on w_ge101_importa_produtos_excel.destroy
call super::destroy
destroy(this.cb_confirma)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.pb_selecao)
destroy(this.cb_cancelar)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

dw_1.SetFocus()


end event

event close;call super::close;//String lvs_Nulo
//
//SetNull(lvs_Nulo)
//
//CloseWithReturn(This, lvs_Nulo)
end event

type pb_help from dc_w_response`pb_help within w_ge101_importa_produtos_excel
end type

type cb_confirma from commandbutton within w_ge101_importa_produtos_excel
integer x = 1326
integer y = 296
integer width = 361
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Confirma"
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nulo,&
	   lvs_Tipo

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.nm_arquivo	 [1]
lvs_Tipo 	= dw_1.Object.id_tipo_arquivo[1] 

SetNull(lvs_Nulo)

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a inclus$$HEX1$$e300$$ENDHEX$$o dos produtos ?", Question!, YesNo!, 2) = 2 Then 
	lvs_Arquivo = lvs_Nulo
Else
	lvs_Arquivo = lvs_Arquivo + lvs_Tipo
End If

CloseWithReturn(Parent, lvs_Arquivo)




	






end event

type gb_1 from groupbox within w_ge101_importa_produtos_excel
integer x = 23
integer y = 8
integer width = 2062
integer height = 260
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge101_importa_produtos_excel
integer x = 37
integer y = 68
integer width = 1897
integer height = 184
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge101_selecao_arquivo"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type pb_selecao from picturebutton within w_ge101_importa_produtos_excel
integer x = 1947
integer y = 148
integer width = 110
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\localizar_arquivo.bmp"
alignment htextalign = left!
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nome,&
	   lvs_Mensagem,&
	   lvs_Tipo

Integer lvi_Retorno 

// Tipo
// 1 -> SEM COMPLEMENTO (SEM PRE$$HEX1$$c700$$ENDHEX$$O E SEM DESCONTO)
// 2 -> COM PRE$$HEX1$$c700$$ENDHEX$$O
// 3 -> COM DESCONTO
// 4 -> COM PRE$$HEX1$$c700$$ENDHEX$$O + DESCONTO

dw_1.AcceptText()

lvs_Tipo = dw_1.Object.id_tipo_arquivo[1]

If IsNull(lvs_Tipo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o tipo da planilha.")
	dw_1.Event ue_Pos(1, "id_tipo_arquivo")
	dw_1.SetFocus()
	Return
End If

Choose Case lvs_Tipo
	Case "1"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A	= Produto~r"     + &
					 	"Coluna B	= Quantidade"
	Case "2"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A	= Produto~r"     + &
					 	"Coluna B	= Quantidade~r" +&
					 	"Coluna C	= Pre$$HEX1$$e700$$ENDHEX$$o"
		
	Case "3"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A	= Produto~r"     + &
					 	"Coluna B	= Quantidade~r" +&
					 	"Coluna C	= Desconto"
	Case "4"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A	= Produto~r"     + &
					 	"Coluna B	= Quantidade~r" +&
					 	"Coluna C	= Pre$$HEX1$$e700$$ENDHEX$$o~r" +&
						"Coluna D	= Desconto"
End Choose 

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem)

lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Arquivo, lvs_Nome, "XLS", "Excel (*.XLS),*.XLS,")

If lvi_Retorno = 1 Then 
	dw_1.Object.nm_arquivo[1] = Upper(lvs_Arquivo)
	cb_confirma.Enabled = True
Else
	cb_confirma.Enabled = False
End If
	
	


end event

type cb_cancelar from commandbutton within w_ge101_importa_produtos_excel
integer x = 1719
integer y = 296
integer width = 366
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "C&ancela"
end type

event clicked;String lvs_Nulo

SetNull(lvs_Nulo)

CloseWithReturn(Parent, lvs_Nulo)

end event

type dw_2 from datawindow within w_ge101_importa_produtos_excel
boolean visible = false
integer x = 101
integer y = 444
integer width = 1993
integer height = 720
integer taborder = 40
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
end type

