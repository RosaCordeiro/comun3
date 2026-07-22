HA$PBExportHeader$dc_uo_excel.sru
forward
global type dc_uo_excel from nonvisualobject
end type
end forward

global type dc_uo_excel from nonvisualobject
end type
global dc_uo_excel dc_uo_excel

type variables
OLEObject lole_book 
OLEObject lole_workbook 
OLEObject lole_sheet

String is_Extensao_Arquivo = ""
end variables

forward prototypes
public function boolean uo_referencia_objeto_excel (string ps_nm_arquivo)
public function any uo_lendo_dados (long pl_row, string ps_coluna)
public function long uo_verifica_tamanho_arquivo (string ps_celula)
public subroutine uo_desconexao ()
public function string uo_retorna_coluna (integer al_col)
public subroutine uo_gravando_dados (long pl_row, long pl_coluna, any pa_dado)
public subroutine uo_salva ()
public function any uo_lendo_dados_cells (long pl_row, string ps_coluna)
end prototypes

public function boolean uo_referencia_objeto_excel (string ps_nm_arquivo);// Abrindo objeto na nova Instance. 
lole_book.ConnectToNewObject("excel.application") 
lole_book.Visible = False 
lole_book.workBooks.Open(ps_Nm_Arquivo)

lole_workbook = lole_book.ActiveWorkBook

// Recuperando a referencia da WorkSheet 
lole_sheet = lole_book.ActiveWorkBook.WorkSheets(1)

//Captura a extens$$HEX1$$e300$$ENDHEX$$o do arquivo
This.is_Extensao_Arquivo = Upper(gf_replace(Mid(ps_nm_Arquivo,Len(ps_nm_Arquivo)-3,4),'.','',0))

Return True
end function

public function any uo_lendo_dados (long pl_row, string ps_coluna);Any lva_Dado

If ps_Coluna = 'DZ' Then
	ps_Coluna = ps_Coluna
End If

lva_Dado = lole_sheet.Range(ps_Coluna + String(pl_Row)).Value

Return lva_Dado

end function

public function long uo_verifica_tamanho_arquivo (string ps_celula);Long lvl_Row = 0
Long lvl_Row_Aux
Long lvl_Row_Aux2

Any lva_Dado

//Limita o tamanho apenas se a extens$$HEX1$$e300$$ENDHEX$$o for .xls
If This.is_Extensao_Arquivo = "XLS" Then

	//Pula de 1000 em 1000 para agilizar a descoberta
	For lvl_Row = 1 To 66
		// Lendo a primeira linha
		lvl_Row_Aux = lvl_Row * 1000		
	
		If lvl_Row_Aux > 65536 Then lvl_Row_Aux = 65536
		
		lva_Dado = lole_sheet.Range(ps_Celula + String(lvl_Row_Aux)).Value
		
		If IsNull(ClassName(lva_Dado)) Then Exit
	Next
	
Else
	
	lva_Dado = 0
	
	Do While Not IsNull(ClassName(lva_Dado))
		
		lvl_Row++
		lvl_Row_Aux = lvl_Row * 1000		
		
		lva_Dado = lole_sheet.Range(ps_Celula + String(lvl_Row_Aux)).Value		
	Loop	
End If

lvl_Row_Aux2 = lvl_Row_Aux - 1000
If lvl_Row_Aux2 <= 0 Then lvl_Row_Aux2 = 1

For lvl_Row = lvl_Row_Aux2 To lvl_Row_Aux
	// Lendo a primeira linha
	lva_Dado = lole_sheet.Range(ps_Celula + String(lvl_Row)).Value
	
	If IsNull(ClassName(lva_Dado)) Then Exit
Next


Return lvl_Row -1
end function

public subroutine uo_desconexao ();// Disconectando e fechando 
Try
	lole_sheet.DisconnectObject( )
	lole_workbook.Close()
	lole_workbook.DisconnectObject( )
	lole_book.application.quit()
	lole_book.DisconnectObject() 
Finally
	If IsValid(lole_sheet) Then Destroy(lole_sheet)
	If IsValid(lole_workbook) Then Destroy(lole_workbook) 
	If IsValid(lole_book) Then Destroy(lole_book)
	
     GarbageCollect()
End Try
end subroutine

public function string uo_retorna_coluna (integer al_col);// char(65) = A, char(90) = Z

Long ll_Contador = -1

String ls_Coluna = ""

al_Col = al_col  - 1

If al_col < 26 Then
	ls_Coluna = CharA( al_col + 65 )
Else
	Do While al_col > 25
		 al_col -= 26
		 ll_Contador++
	Loop
	
	ls_Coluna = CharA( ll_Contador + 65 ) + CharA( al_col + 65 )
End If

Return ls_Coluna
end function

public subroutine uo_gravando_dados (long pl_row, long pl_coluna, any pa_dado);Any lva_Dado

lole_sheet.cells(pl_Row, pl_coluna).value = String(lva_Dado)
end subroutine

public subroutine uo_salva ();lole_workbook.save()
end subroutine

public function any uo_lendo_dados_cells (long pl_row, string ps_coluna);Any lva_Dado

If ps_Coluna = 'DZ' Then
	ps_Coluna = ps_Coluna
End If

//lendo dados duplicado porque este usa especificadamente a celula, o outro pode ser que utilizem o range para algo
lva_Dado = lole_sheet.cells(String(pl_Row), ps_Coluna).value

Return lva_Dado

end function

on dc_uo_excel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_excel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Criando a PB OLE instance. 
lole_book = Create OLEObject 

end event

event destructor;This.uo_desconexao( )
end event

