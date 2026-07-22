HA$PBExportHeader$uo_arquivo_texto.sru
forward
global type uo_arquivo_texto from nonvisualobject
end type
end forward

global type uo_arquivo_texto from nonvisualobject
end type
global uo_arquivo_texto uo_arquivo_texto

forward prototypes
public function integer of_abre_arquivo (string ps_arquivo)
public subroutine grava_arquivo (integer pi_arquivo, string ps_mensagem)
end prototypes

public function integer of_abre_arquivo (string ps_arquivo);INTEGER lvi_Retorno, lvi_Arquivo

If FileExists(ps_Arquivo) Then

   If Not FileDelete(ps_Arquivo) Then
		
	   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo : " + ps_Arquivo , Information!, Ok!)
		Halt Close

	End If
		
End If

lvi_Arquivo = FileOpen( ps_Arquivo, LineMode!, Write!, LockReadWrite!, Append!)

If lvi_Arquivo = -1 Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo : " + ps_Arquivo , Information!, Ok!)
	Halt Close
	
End If

Return lvi_Arquivo
end function

public subroutine grava_arquivo (integer pi_arquivo, string ps_mensagem);INTEGER lvi_Status
	
lvi_Status = FileWrite(pi_Arquivo, ps_Mensagem)

If lvi_Status <> LenA(ps_Mensagem) Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo.", Information!, Ok!)
	Halt Close

End If

end subroutine

on uo_arquivo_texto.create
TriggerEvent( this, "constructor" )
end on

on uo_arquivo_texto.destroy
TriggerEvent( this, "destructor" )
end on

