HA$PBExportHeader$uo_ge140_cancela_nf_sefaz.sru
forward
global type uo_ge140_cancela_nf_sefaz from nonvisualobject
end type
end forward

global type uo_ge140_cancela_nf_sefaz from nonvisualobject
end type
global uo_ge140_cancela_nf_sefaz uo_ge140_cancela_nf_sefaz

type prototypes
Function Integer Cancelar(String as_Chave, String as_Protocolo, String as_Justificativa, String as_Data_Hora, String as_Fuso_Horario, Integer ai_Ambiente, Ref String as_Retorno)  library "C:\Sistemas\DLL\Sefaz\SEFAZ.dll" alias for "Cancelar;Ansi"
end prototypes

type variables

end variables

forward prototypes
public function boolean of_fuso_horario_filial (string as_uf, ref string as_fuso_horario)
public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos)
public function boolean of_cancela_nfe (long al_filial, string as_chave, string as_proc_envio, string as_motivo, ref string as_proc_cancelamento, ref string as_log)
end prototypes

public function boolean of_fuso_horario_filial (string as_uf, ref string as_fuso_horario);String ls_Id_Horario_Verao

as_Fuso_Horario 	= ""

select vl_parametro
into :ls_Id_Horario_Verao
from parametro_loja
where cd_parametro = 'ID_HORARIO_VERAO_NFE'
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro ID_HORARIO_VERAO_NFE.")
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro ID_HORARIO_VERAO_NFE.")
		Return False					
End Choose		

If ls_Id_Horario_Verao = "S" Then
	If as_UF = 'MS' Then
		as_Fuso_Horario = '-03:00'
	Else
		as_Fuso_Horario = '-02:00'
	End If	
Else
	If as_UF = 'MS' Then
		as_Fuso_Horario = '-04:00'
	Else
		as_Fuso_Horario = '-03:00'
	End If
End If

Return True

end function

public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos);Integer li_Esp, li_i, li_Inicio, li_Fim
string  ls_Result, ls_Xml_Aux

as_Tag = gf_Replace(as_Tag, '/', '',  0)
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

public function boolean of_cancela_nfe (long al_filial, string as_chave, string as_proc_envio, string as_motivo, ref string as_proc_cancelamento, ref string as_log);Boolean lb_Sucesso = False

String ls_Retorno_Sefaz
String ls_Dh_Evento
String ls_UF
String ls_Fuso_Horario
String ls_Status
String ls_Mensagem_Evento
String ls_Parametro

Long ll_Retorno

DateTime ldh_Evento

Integer li_Ambiente	//1-Produ$$HEX2$$e700e300$$ENDHEX$$o 2-Homologa$$HEX2$$e700e300$$ENDHEX$$o

Try

	li_Ambiente					= 1
	as_Log 						= ""
	as_Proc_Cancelamento 	= ""
	ls_Retorno_Sefaz 			= Space(3000)
	
	Open ( w_Aguarde ) 
	w_Aguarde.Title = "Cancelando NF-e, aguarde..."
	
	If Not gf_Estacao_Servidor() Then
		as_log = "O cancelamento de nota fiscal deve ser executado somente no computador onde $$HEX1$$e900$$ENDHEX$$ feita a comunica$$HEX2$$e700e300$$ENDHEX$$o."
		Return False
	End If
	
	If Not FileExists("C:\Sistemas\DLL\SEFAZ\SEFAZ.dll") Then
		as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o arquivo: C:\Sistemas\DLL\SEFAZ\SEFAZ.dll.~rInforme o depto. de INFORM$$HEX1$$c100$$ENDHEX$$TICA."
		Return False	
	End If
	
	Select vl_parametro
	 Into :ls_Parametro
	from parametro_loja
	Where cd_parametro = 'ID_BASE_PRODUCAO'
	Using SQLCa;
	
	If SQLCa.SQLCode = 0 Then
		If Trim(ls_Parametro) = "S"  Then
			li_Ambiente = 1
		Else
			li_Ambiente = 2
		End If
	End If
		
	SELECT 	 c.cd_unidade_federacao 
		INTO	 :ls_UF
		FROM  filial f
	INNER JOIN cidade c ON f.cd_cidade = c.cd_cidade
		WHERE f.cd_filial = :al_Filial
		Using SqlCa;
	
	Choose Case SqlCa.SqlCode 
		Case -1
			as_log = "Erro ao selecionar dados da filial. " + SqlCa.SqlErrText
			Return False
		Case 100
			as_log = "Dados da filial "+String(al_Filial)+" n$$HEX1$$e300$$ENDHEX$$o localizados."
			Return False			
	End Choose		
				
	If Not of_Fuso_Horario_Filial( ls_UF, Ref ls_Fuso_Horario ) Then
		Return False	
	End If
	
	ldh_Evento 		= gf_GetServerDate()
	ls_Dh_Evento 	= String(ldh_Evento, "YYYY-MM-DD")+"T"+String(ldh_Evento, "HH:MM:SS")
	
	ll_Retorno = Cancelar( as_Chave, as_Proc_Envio, as_motivo, ls_Dh_Evento, ls_Fuso_Horario, li_Ambiente, Ref ls_Retorno_Sefaz ) 
		
	If ll_Retorno <> -1 Then
		ls_Status 					= This.of_Get_Value_Tag( ls_Retorno_Sefaz, '<cStat>', 2 )
		ls_Mensagem_Evento 	= This.of_Get_Value_Tag( ls_Retorno_Sefaz, '<xMotivo>', 2 )
		as_proc_cancelamento 	= This.of_Get_Value_Tag( ls_Retorno_Sefaz, '<nProt>', 1 )
		
		Choose Case ls_Status
			Case '135'
				lb_Sucesso = True
				as_log = 'Nota Fiscal cancelada com sucesso.'		
			Case '573'
				//Neste caso, a nota j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cancelada no SEFAZ e por isso, poder$$HEX1$$e100$$ENDHEX$$ ser cancelada tamb$$HEX1$$e900$$ENDHEX$$m no RL sem apresentar mensagem p/ usuario				
				//as_log = 'Nota Fiscal j$$HEX1$$e100$$ENDHEX$$ cancelada na Sefaz.~r' + ls_Mensagem_Evento
				
				lb_Sucesso = True
				as_log = 'Nota Fiscal cancelada com sucesso.'		

			Case Else
				as_log = ls_Mensagem_Evento 
		End Choose			
	Else
		as_log = "Erro no retorno: SEFAZ.DLL."
	End If
	
	Return lb_Sucesso
	
Finally
	Close(  w_Aguarde )
End Try
end function

on uo_ge140_cancela_nf_sefaz.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge140_cancela_nf_sefaz.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

