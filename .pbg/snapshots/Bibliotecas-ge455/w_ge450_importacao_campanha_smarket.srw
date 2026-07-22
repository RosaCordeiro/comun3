HA$PBExportHeader$w_ge450_importacao_campanha_smarket.srw
forward
global type w_ge450_importacao_campanha_smarket from dc_w_response
end type
type pb_selecionar_arquivo from picturebutton within w_ge450_importacao_campanha_smarket
end type
type gb_1 from groupbox within w_ge450_importacao_campanha_smarket
end type
type dw_1 from dc_uo_dw_base within w_ge450_importacao_campanha_smarket
end type
type cb_sair from commandbutton within w_ge450_importacao_campanha_smarket
end type
type cb_atualizar from commandbutton within w_ge450_importacao_campanha_smarket
end type
type st_msg from statictext within w_ge450_importacao_campanha_smarket
end type
end forward

global type w_ge450_importacao_campanha_smarket from dc_w_response
integer x = 704
integer y = 980
integer width = 2345
integer height = 444
string title = "GE450 - Importa$$HEX2$$e700e300$$ENDHEX$$o de Arquivo Campanha Smarket"
boolean controlmenu = false
long backcolor = 80269524
pb_selecionar_arquivo pb_selecionar_arquivo
gb_1 gb_1
dw_1 dw_1
cb_sair cb_sair
cb_atualizar cb_atualizar
st_msg st_msg
end type
global w_ge450_importacao_campanha_smarket w_ge450_importacao_campanha_smarket

type variables
dc_uo_API	ivo_Api

end variables

forward prototypes
public function boolean wf_processa_arquivo (string as_path, integer ai_arquivo, integer ai_log)
public function boolean wf_retorna_total_linhas_arquivo (string ps_arquivo, ref long pl_total_linhas)
public function string wf_getstring (ref string as_source, string as_separator)
public function boolean wf_data (string as_data, ref date adt_data)
public function boolean wf_decimal (string as_valor, ref decimal adc_valor)
public function boolean wf_grava_log (integer ai_log, string as_mensagem)
public function boolean wf_insere_campanha (long pl_cd_campanha, string ps_ds_campanha, string ps_ds_midia, date pdt_inicio, date pdt_termino, ref long pl_cd_promocao_sos, ref string ps_log)
end prototypes

public function boolean wf_processa_arquivo (string as_path, integer ai_arquivo, integer ai_log);Boolean 	lvb_Sucesso = False

String 	lvs_Tipo_Registro, &
			lvs_Registro, &
			lvs_Desc_Campanha, &
			lvs_Desc_Midia, &
			lvs_Dt_Inicio, &
			lvs_Dt_Termino, &
			lvs_Tipo_Oferta, &
			lvs_Desc_Produto, &
			lvs_Preco_Varejo, &
			lvs_Preco_Atacado, &
			lvs_Log

Long 	lvl_Linha, &
		lvl_Total_Registros, &
		lvl_Cd_Campanha, &
		lvl_Cd_Oferta, &
		lvl_Cd_Produto, &
		lvl_Cd_Filial, &
		lvl_Cd_Promocao_SOS
		
Integer lvi_Read

Date	lvdt_Inicio_Campanha, &
		lvdt_Termino_Campanha
		
Decimal{2} lvdc_Preco_Varejo

Try
	
	Open(w_Aguarde)	
	w_Aguarde.Title = "Verificando Total de Registros do Arquivo..."
	If Not wf_Retorna_Total_Linhas_Arquivo(as_Path, ref lvl_Total_Registros) Then Return False
	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total_Registros)
	
	lvi_Read = FileRead(ai_Arquivo, lvs_Registro)
	lvl_Linha ++

	SetPointer(HourGlass!)
	
	Do While lvi_Read > 0
		w_Aguarde.Title = "Lendo Dados do Arquivo - Registro: " + String(lvl_Linha) + " de " + String(lvl_Total_Registros)				
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		w_Aguarde.Show()
		
		lvs_Registro = gf_Replace(lvs_Registro, '"', '', 0)
		
		lvl_Cd_Campanha				= Long(wf_GetString(ref lvs_Registro, ";"))	// C01
		lvs_Desc_Campanha			= wf_GetString(ref lvs_Registro, ";") 			// C02
		lvs_Desc_Midia		 			= wf_GetString(ref lvs_Registro, ";") 			// C03
		lvs_Dt_Inicio						= wf_GetString(ref lvs_Registro, ";") 			// C04
		lvs_Dt_Termino					= wf_GetString(ref lvs_Registro, ";") 			// C05
		lvl_Cd_Filial						= Long(wf_GetString(ref lvs_Registro, ";")) 	// C06
		lvl_Cd_Oferta					= Long(wf_GetString(ref lvs_Registro, ";")) 	// C07
		lvs_Tipo_Oferta				= wf_GetString(ref lvs_Registro, ";") 			// C08
		lvl_Cd_Produto					= Long(wf_GetString(ref lvs_Registro, ";")) 	// C09
		lvs_Desc_Produto				= wf_GetString(ref lvs_Registro, ";") 			// C10
		lvs_Preco_Varejo				= wf_GetString(ref lvs_Registro, ";") 			// C11
		lvs_Preco_Atacado				= wf_GetString(ref lvs_Registro, ";") 			// C12
		
		wf_Data(lvs_Dt_Inicio, ref lvdt_Inicio_Campanha)
		wf_Data(lvs_Dt_Termino, ref lvdt_Termino_Campanha)
		
		If Not wf_Decimal(lvs_Preco_Varejo, ref lvdc_Preco_Varejo) Then
			lvs_Log += "Valor da Oferta '" + lvs_Preco_Varejo + "' Inv$$HEX1$$e100$$ENDHEX$$lido. Linha:" + String(lvl_Linha)
			wf_Grava_Log(ai_Log, lvs_Log)
			Return False
		End If
		
		// Insere Campanha		
		If wf_Insere_Campanha(lvl_Cd_Campanha, lvs_Desc_Campanha, lvs_Desc_Midia, lvdt_Inicio_Campanha, lvdt_Termino_Campanha, ref lvl_Cd_Promocao_SOS, ref lvs_Log) Then
//			If wf_Insere_Campanha_Filial(lvl_Cd_Promocao_SOS, lvl_Cd_Filial, ref lvs_Log) Then
//				If wf_Insere_Campanha_Produto(lvl_Cd_Promocao_SOS, lvl_Cd_Produto, lvdc_Preco_Varejo, ref lvs_Log) Then
					lvb_Sucesso = True
//				End If
//			End If
		End If
		
		If Not lvb_Sucesso Then
			wf_Grava_Log(ai_Log, lvs_Log)
			Return False	
		End If		
		// Fim Insere Campanha
					
		lvi_Read = FileRead(ai_Arquivo, lvs_Registro)
		lvl_Linha ++
	Loop
	
	SetPointer(Arrow!)
	
Finally
	Close( w_Aguarde )
End Try

Return True
end function

public function boolean wf_retorna_total_linhas_arquivo (string ps_arquivo, ref long pl_total_linhas);Integer	lvi_Arquivo, &
			lvi_Read
			
String 	lvs_Registro			

// Abertura do Arquivo
lvi_Arquivo = FileOpen(ps_Arquivo, LineMode!, Read!, LockWrite!, Append!)

If lvi_Arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na abertura do arquivo: '" + ps_Arquivo + "'.", StopSign!)
	Return False
End If

lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
pl_total_linhas ++

SetPointer(HourGlass!)

Do While lvi_Read > 0
	lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
	
	pl_total_linhas ++
Loop

pl_total_linhas --

Return True
end function

public function string wf_getstring (ref string as_source, string as_separator);int 		li_pos
string 	ls_ret

//Check parameters
If IsNull(as_source) or IsNull(as_separator) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

/////////////////////////////////////////////////////////////////////////////////
// Get the position of the separator
/////////////////////////////////////////////////////////////////////////////////
li_pos = PosA(as_source, as_separator)	

/////////////////////////////////////////////////////////////////////////////////
// Compute the length of the token to be stripped off of the source string.
/////////////////////////////////////////////////////////////////////////////////

// If no separator, the token to be stripped is the entire source string
if li_pos = 0 then
	ls_ret = as_source
	as_source = ""	
else
	// Otherwise, return just the token and strip it & the separator from the source string
	ls_ret = MidA(as_source, 1, li_pos - 1)
	as_source = RightA(as_source, LenA(as_source) - (li_pos+LenA(as_separator)-1) )
end if

return ls_ret
end function

public function boolean wf_data (string as_data, ref date adt_data);String lvs_Data

If LenA(as_Data) = 8 Then
	lvs_Data = MidA(as_Data, 7, 2)   + "/" + &
				  MidA(as_Data, 5, 2) + "/" + &
				  MidA(as_Data, 1, 4)
Else
	lvs_Data = MidA(as_Data, 5, 2)   + "/" + &
				  MidA(as_Data, 3, 2) + "/" + &
				  MidA(as_Data, 1, 2)
End If
			
If Not IsDate(lvs_Data) Then
	Return False
Else
	adt_Data = Date(lvs_Data)
	Return True
End If
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

public function boolean wf_grava_log (integer ai_log, string as_mensagem);Integer lvi_Status

String lvs_Mensagem 

lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + &
               String(Now(), "hh:mm:ss") + " " + as_Mensagem
	
lvi_Status = FileWrite(ai_LOG, lvs_Mensagem)

If lvi_Status <> LenA(lvs_Mensagem) Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
Else
	Return True
End If
end function

public function boolean wf_insere_campanha (long pl_cd_campanha, string ps_ds_campanha, string ps_ds_midia, date pdt_inicio, date pdt_termino, ref long pl_cd_promocao_sos, ref string ps_log);Boolean lvb_Sucesso = True



//Select count(1)
// From promocao_sos
//Where 

Select max(cd_promocao_sos)
 Into :pl_cd_promocao_sos
From promocao_sos
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_Log += "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo c$$HEX1$$f300$$ENDHEX$$digo de promocao_sos"
	lvb_Sucesso = False
	Return lvb_Sucesso
End If

pl_cd_promocao_sos = pl_cd_promocao_sos + 1




Return lvb_Sucesso
end function

on w_ge450_importacao_campanha_smarket.create
int iCurrent
call super::create
this.pb_selecionar_arquivo=create pb_selecionar_arquivo
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_sair=create cb_sair
this.cb_atualizar=create cb_atualizar
this.st_msg=create st_msg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_selecionar_arquivo
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_sair
this.Control[iCurrent+5]=this.cb_atualizar
this.Control[iCurrent+6]=this.st_msg
end on

on w_ge450_importacao_campanha_smarket.destroy
call super::destroy
destroy(this.pb_selecionar_arquivo)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_sair)
destroy(this.cb_atualizar)
destroy(this.st_msg)
end on

event ue_postopen;call super::ue_postopen;ivo_Api = Create dc_uo_api

dw_1.Event ue_AddRow()
end event

event close;call super::close;Destroy(ivo_Api)

end event

type pb_help from dc_w_response`pb_help within w_ge450_importacao_campanha_smarket
end type

type pb_selecionar_arquivo from picturebutton within w_ge450_importacao_campanha_smarket
integer x = 2171
integer y = 56
integer width = 110
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Open!"
vtextalign vtextalign = vcenter!
string powertiptext = "Selecionar Arquivo"
long textcolor = 33554431
long backcolor = 16777215
end type

event clicked;String 	lvs_Path, &
      		lvs_Arquivo
		 
Integer lvi_Retorno

lvi_Retorno = GetFileOpenName("Selecione o Arquivo", &
										lvs_Path, &
										lvs_Arquivo,&
										"CSV", &
    	                        			   	"Arquivo Texto (*.CSV),*.CSV")
										
lvs_Path    	= lower(lvs_Path)										
lvs_Arquivo 	= lower(lvs_Arquivo)

If lvi_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Ocorreu um erro na sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
ElseIf lvi_Retorno = 1 Then
	dw_1.Object.Nm_Arquivo[1] 	= lvs_Path
	cb_Atualizar.Enabled 				= True
End If
						
end event

type gb_1 from groupbox within w_ge450_importacao_campanha_smarket
integer x = 23
integer width = 2290
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge450_importacao_campanha_smarket
integer x = 41
integer y = 56
integer width = 2135
integer height = 100
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_ge450_selecao"
end type

type cb_sair from commandbutton within w_ge450_importacao_campanha_smarket
integer x = 1943
integer y = 228
integer width = 370
integer height = 96
integer taborder = 30
boolean bringtotop = true
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

type cb_atualizar from commandbutton within w_ge450_importacao_campanha_smarket
integer x = 1554
integer y = 228
integer width = 379
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Importar"
boolean default = true
end type

event clicked;Boolean lvb_Sucesso = False

String lvs_Arquivo, &
       	lvs_Log, &
		lvs_Arquivo_Origem

Integer lvi_Arquivo, &
        lvi_Log

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.Nm_Arquivo[1]

If IsNull(lvs_Arquivo) or Trim(lvs_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione o arquivo para atualiza$$HEX2$$e700e300$$ENDHEX$$o dos dados.", Exclamation!)
	Return
End If

lvs_Log = LeftA(lvs_Arquivo, LenA(lvs_Arquivo) - 4) + ".log"

FileDelete(lvs_Log)

// Abertura do Log
lvi_Log = FileOpen(lvs_Log, LineMode!, Write!, LockWrite!, Append!)

If lvi_Log = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na abertura do arquivo de LOG: '" + lvs_Log + "'.", StopSign!)
	Return
End If

// Renomeia o arquivo
If FileLength(lvs_Arquivo) > 0 Then
	lvs_Arquivo_Origem = lvs_Arquivo
	ivo_Api.of_Rename_File(lvs_Arquivo, lvs_Arquivo + ".ok")
	lvs_Arquivo = lvs_Arquivo + ".ok"
End If

// Abertura do Arquivo
lvi_Arquivo = FileOpen(lvs_Arquivo, LineMode!, Read!, LockWrite!, Append!)

If lvi_Arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na abertura do arquivo: '" + lvs_Arquivo + "'.", StopSign!)
	Return
End If

SetPointer(HourGlass!)

If wf_Processa_Arquivo(lvs_Arquivo, lvi_Arquivo, lvi_Log) Then
	lvb_Sucesso = True
End If

FileClose(lvi_Arquivo)
FileClose(lvi_Log)

If lvb_Sucesso Then
	
	SqlCa.of_Commit()
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Importa$$HEX2$$e700e300$$ENDHEX$$o efetuada com sucesso.", Information!)
Else
	SqlCa.of_RollBack()
End If

If FileLength(lvs_Log) > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Ocorreram erros na atualiza$$HEX2$$e700e300$$ENDHEX$$o do arquivo.~r" + &
	                      "Verifique o arquivo de log '" + lvs_Log + "'.",  StopSign!)
Else
	If Not FileDelete(lvs_Log) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo de log '" + lvs_Log + "'.", StopSign!)
	End If
End If

st_msg.Text = ""

SetPointer(Arrow!)
end event

type st_msg from statictext within w_ge450_importacao_campanha_smarket
integer x = 23
integer y = 240
integer width = 1472
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 80269524
boolean enabled = false
boolean focusrectangle = false
end type

