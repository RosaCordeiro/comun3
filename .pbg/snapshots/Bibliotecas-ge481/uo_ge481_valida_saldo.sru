HA$PBExportHeader$uo_ge481_valida_saldo.sru
forward
global type uo_ge481_valida_saldo from nonvisualobject
end type
end forward

global type uo_ge481_valida_saldo from nonvisualobject
end type
global uo_ge481_valida_saldo uo_ge481_valida_saldo

type variables
Integer ii_log
end variables

forward prototypes
public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos)
public function double of_str_double_value (string as_value)
public function boolean of_abre_log ()
public function boolean of_grava_log (string as_mensagem)
public function boolean of_read_xml (string as_xml, ref st_valida_saldo ast_valida_saldo[])
end prototypes

public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos);Integer li_Esp, li_i, li_Inicio, li_Fim
string  ls_Result, ls_Xml_Aux

as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '<', '', 0)
as_Tag = gf_Replace(as_Tag, '>', '', 0)
If Pos(' ', as_Tag) > 0 Then 
	li_Esp = Pos(' ',as_Tag)
Else
	li_Esp = LenA(as_Tag)
End If	

li_Inicio = 1
ls_Xml_Aux = as_xml
for li_i = 1 to ai_Pos 
	 ls_Result = Mid(	ls_Xml_Aux,  &
	 						Pos(ls_Xml_Aux, '<'+as_tag+'>')+LenA(as_tag)+2, &
	 						Pos(ls_Xml_Aux, '</'+as_tag+'>') - (Pos(ls_Xml_Aux, '<'+as_tag+'>')+LenA(as_tag)+2))
	ls_Xml_Aux = Mid(ls_Xml_Aux, Pos(ls_Xml_Aux, '</'+as_tag+'>') +  LenA(as_tag)+3)
Next
 Return ls_Result
end function

public function double of_str_double_value (string as_value);Double ls_Value
If as_Value <> "" Then
	ls_Value = Double(gf_Replace(as_Value, ".", ",", 0))
Else
	ls_Value = 0.00
End If	
Return ls_Value
end function

public function boolean of_abre_log ();String ls_Path

ls_Path 	= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If IsNull(ls_Path) or Trim(ls_Path) = '' Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do log n$$HEX1$$e300$$ENDHEX$$o foi localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o. Chave: Diretorio | Se$$HEX2$$e700e300$$ENDHEX$$o: Diretorio = c:\sistemas\gn\arquivos\ .", StopSign!)
	Return False
End If

ls_Path = ls_Path + "xml_email_" + string(Today(),"ddmm")

If Not gf_Cria_Logs(ls_Path, 4, ref ii_log) Then
	Return False
End If

Return True
end function

public function boolean of_grava_log (string as_mensagem);String lvs_Mensagem

Integer lvi_Write
	
lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
               " - " + as_Mensagem

lvi_Write = FileWrite(ii_log, lvs_Mensagem)

If lvi_Write = LenA(lvs_Mensagem) Then
	Return True
Else
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de LOG.", StopSign!)
	Return False
End If
end function

public function boolean of_read_xml (string as_xml, ref st_valida_saldo ast_valida_saldo[]);String 	ls_Xml,&
			ls_XmlAux,&
			ls_XmlAux_1
Integer 	li_contador_saida, li_contador_objetos

ls_Xml   = gf_Replace(as_Xml, "~r~n", "", 0)

ls_Xml   = gf_Replace(ls_Xml, "~n", "", 0)

ls_Xml   = gf_Replace(ls_Xml, "~r", "", 0)

Try
	ls_XmlAux	= ls_Xml
	li_contador_saida		= 1
	li_contador_objetos	= 1
	
	DO WHILE Pos(ls_XmlAux, '<SAIDA>') > 0	 /*and i < 1000*/
		ls_XmlAux_1 = Mid(ls_XmlAux, Pos(ls_XmlAux, '<SAIDA>'), Pos(ls_XmlAux, '</SAIDA>') - Pos(ls_XmlAux, '<SAIDA>') + LenA('</SAIDA>') )
		If LenA(ls_XmlAux_1) > 0 Then
			ast_valida_saldo[li_contador_objetos].saida[li_contador_saida].centro		= of_get_value_tag(ls_XmlAux, "<CENTRO>", 1)
			ast_valida_saldo[li_contador_objetos].saida[li_contador_saida].material	= of_get_value_tag(ls_XmlAux, "<MATERIAL>", 1)
			ast_valida_saldo[li_contador_objetos].saida[li_contador_saida].deposito	= of_get_value_tag(ls_XmlAux, "<DEPOSITO>", 1)
			ast_valida_saldo[li_contador_objetos].saida[li_contador_saida].saldo		= of_get_value_tag(ls_XmlAux, "<SALDO>", 1)
			ast_valida_saldo[li_contador_objetos].saida[li_contador_saida].mensagem	= of_get_value_tag(ls_XmlAux, "<MENSAGEM>", 1)
			
			if li_contador_saida = 10000 then
				li_contador_objetos ++
				
				li_contador_saida	= 0
			end if
			
			li_contador_saida += 1
			
			ls_XmlAux = gf_Replace(ls_XmlAux, ls_XmlAux_1 , '', 0)	
		End If
	LOOP
Catch (runtimeerror er)   
	MessageBox("Erro", "Erro ao ler o XML da CT-e: ~r~r"+er.GetMessage(), StopSign!)
	Return False
End Try

Return True
end function

on uo_ge481_valida_saldo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge481_valida_saldo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

