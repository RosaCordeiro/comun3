HA$PBExportHeader$dc_uo_excel_novo.sru
forward
global type dc_uo_excel_novo from nonvisualobject
end type
end forward

global type dc_uo_excel_novo from nonvisualobject
end type
global dc_uo_excel_novo dc_uo_excel_novo

type variables
OLEObject ivo_excel
end variables

forward prototypes
public function boolean of_total_linhas_planilha (string as_arquivo, ref long al_linhas)
public subroutine of_carrega_dados (ref any aa_conteudo, long al_linha, long al_coluna)
end prototypes

public function boolean of_total_linhas_planilha (string as_arquivo, ref long al_linhas);Long lvl_Contador

Any lva_Dado

Integer lvi_Retorno

lvi_Retorno = ivo_excel.ConnectToObject(as_arquivo)

If lvi_Retorno = 0 Then 
	// 2 => Porque a planilha tem a linha de cabe$$HEX1$$e700$$ENDHEX$$alho
	For lvl_Contador = 1 To 65536 
		lva_Dado = ivo_Excel.application.workbooks(1).worksheets(1).cells(lvl_Contador,1).value
		
		If IsNull(lva_Dado) Then
			lvl_Contador = lvl_Contador -1
			Exit
		End If
	Next
	
	// Se o retorno da linhas for igual "1", a planilha s$$HEX1$$f300$$ENDHEX$$ tem cabe$$HEX1$$e700$$ENDHEX$$alho
	If lvl_Contador = 1 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha '" + as_arquivo + "' n$$HEX1$$e300$$ENDHEX$$o possui informa$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
		Return False
	End IF
	
	al_Linhas = lvl_Contador
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do arquivo '" + as_arquivo + "'.", StopSign!)
	Return False
End If
	
Return True


end function

public subroutine of_carrega_dados (ref any aa_conteudo, long al_linha, long al_coluna);aa_conteudo = ivo_Excel.application.workbooks(1).worksheets(1).cells(al_linha,al_coluna).value	


end subroutine

on dc_uo_excel_novo.create
TriggerEvent( this, "constructor" )
end on

on dc_uo_excel_novo.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;ivo_excel = CREATE OLEObject

end event

event destructor;Destroy(ivo_excel)
end event

