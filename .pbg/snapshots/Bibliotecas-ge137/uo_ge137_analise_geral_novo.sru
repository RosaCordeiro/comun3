HA$PBExportHeader$uo_ge137_analise_geral_novo.sru
forward
global type uo_ge137_analise_geral_novo from nonvisualobject
end type
end forward

global type uo_ge137_analise_geral_novo from nonvisualobject
end type
global uo_ge137_analise_geral_novo uo_ge137_analise_geral_novo

type variables
Long il_Planogramas[]

String is_planogramas

Long il_Analise
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine uo_ge137_planogramas ()
public function boolean of_gera_arquivo ()
public function boolean of_processo_automativo (string as_diretorio_padrao, ref string as_path_automatico)
public function boolean of_envio_email (string as_mensagem)
public subroutine of_exclui_arquivos (string as_diretorio_padrao)
end prototypes

public subroutine of_inicializa ();
end subroutine

public subroutine uo_ge137_planogramas ();
end subroutine

public function boolean of_gera_arquivo ();String lvs_Diretorio , ls_Path , lvs_Arquivo  
Long lvl_Total, ll_Saveas 

SqlCA.AutoCommit =  True

lvs_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
	
If Not This.of_processo_automativo(lvs_Diretorio, Ref ls_Path) Then Return False

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
If Not lvds_1.of_ChangeDataObject("dw_ge137_planilha_nova") Then Return False

lvl_Total = lvds_1.Retrieve()

SqlCA.AutoCommit = False 

If lvl_Total  > 0  Then 
	
	//Salva no diret$$HEX1$$f300$$ENDHEX$$rio especificado pelo compras somente quando $$HEX1$$e900$$ENDHEX$$ gerado autom$$HEX1$$e100$$ENDHEX$$tico
	lvs_Arquivo =  ls_Path + "\analise_geral_automatica_" + String(Today(), "ddmmyy") + "_" + String(Now(), "hhmm") + ".csv"
	ll_Saveas = lvds_1.SaveAsFormattedText(lvs_Arquivo, EncodingANSI!, ";")
	
	//  Se Der Erro Salva Local
	If ll_Saveas = -1 Then 
	   lvs_Arquivo =  lvs_Diretorio + "analise_geral_automatica_" + String(Today(), "ddmmyy") + "_" + String(Now(), "hhmm") + ".csv"
	   ll_Saveas = lvds_1.SaveAsFormattedText(lvs_Arquivo, EncodingANSI!, ";")	
	End If 		
End If 		

Destroy(lvds_1)



	
end function

public function boolean of_processo_automativo (string as_diretorio_padrao, ref string as_path_automatico);
Date ldt_Atual


ldt_Atual = Today()

//No processo autom$$HEX1$$e100$$ENDHEX$$tico se for domingo ou s$$HEX1$$e100$$ENDHEX$$bado n$$HEX1$$e300$$ENDHEX$$o gera o arquivo
If DayNumber(ldt_Atual) = 1 Or DayNumber(ldt_Atual) = 7 Then Return False

Select vl_parametro
	Into :as_Path_Automatico
From parametro_geral
Where cd_parametro = 'ANALISE_GERAL_AUTOMATICO'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	of_Envio_Email("Novo Processo: Erro ao consultar o diret$$HEX1$$f300$$ENDHEX$$rio de destino para o arquivo gerado autom$$HEX1$$e100$$ENDHEX$$ticamente.")
	Return False
End If

If Trim(as_Path_Automatico) = "" Or IsNull(as_Path_Automatico) Then
	of_Envio_Email("Novo Processo: A coluna vl_parametro do par$$HEX1$$e200$$ENDHEX$$metro geral 'ANALISE_GERAL_AUTOMATICO' est$$HEX1$$e100$$ENDHEX$$ branca ou nula.")
End If

If Not DirectoryExists(as_Path_Automatico) Then
	If CreateDirectory(as_Path_Automatico) = -1 Then
		of_Envio_Email("Novo Processo: Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + as_Path_Automatico + "'.")
		Return False
	End If
End If

of_Exclui_Arquivos(as_Diretorio_Padrao)

Return True
end function

public function boolean of_envio_email (string as_mensagem);


String ls_Anexo[]

gf_ge202_Envia_Email_Automatico(169, "", as_Mensagem, ls_Anexo[], True)


Return True 
end function

public subroutine of_exclui_arquivos (string as_diretorio_padrao);Long ll_Linha

String ls_Arquivo
String ls_Anexo[]
String ls_Nome_Arquivo

gf_Dir_List(as_Diretorio_Padrao, "analise_geral_automatica*", 1, Ref ls_Anexo[])

For ll_Linha = 1 To UpperBound(ls_Anexo)
	ls_Arquivo = ls_Anexo[ll_Linha]
	
	ls_Nome_Arquivo = as_Diretorio_Padrao + ls_Arquivo
	
	If Not FileDelete(ls_Nome_Arquivo) Then
		of_Envio_Email("Novo Processo: Erro ao deletar o arquivo " + ls_Arquivo + " da pasta " + as_Diretorio_Padrao + ".")
	End If
Next


end subroutine

on uo_ge137_analise_geral_novo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge137_analise_geral_novo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

