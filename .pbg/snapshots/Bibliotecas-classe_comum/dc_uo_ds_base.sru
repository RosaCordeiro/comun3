HA$PBExportHeader$dc_uo_ds_base.sru
forward
global type dc_uo_ds_base from datastore
end type
end forward

global type dc_uo_ds_base from datastore
end type
global dc_uo_ds_base dc_uo_ds_base

type variables
boolean ivb_SQL_Alterado

string ivs_SQL_Original

dc_uo_transacao itr_transacao

dc_uo_dberror ivo_dberror

long ivl_numero_paginas
end variables

forward prototypes
public subroutine of_appendwhere (string ps_where)
public subroutine of_changesql (string ps_sql)
public subroutine of_appendwhere (string ps_where, integer pi_union)
public subroutine of_appendfrom (string ps_from)
public subroutine of_appendfrom (string ps_from, integer pi_union)
public subroutine of_restoresqloriginal ()
public subroutine of_settransobject (transaction ptr_transacao)
public function long of_importfile (string ps_arquivo)
public subroutine of_msgupdateerror ()
public function boolean of_update (boolean pb_mensagem)
public function boolean of_update ()
public subroutine of_saveas (string as_arquivo)
public subroutine of_print (boolean ab_imediato)
public function boolean of_changedataobject (string as_dataobject, boolean ab_mensagem)
public function boolean of_changedataobject (string as_dataobject)
public subroutine of_appendselect (string ps_campo)
public subroutine of_appendwhere_subquery (string ps_where, integer pi_where)
public function string of_getsql ()
public function boolean of_exporta_excel (string ps_arquivo)
public subroutine of_appendfrom_ansi (string ps_from, integer pi_union)
end prototypes

public subroutine of_appendwhere (string ps_where);String lvs_SQL
String lvs_Aux

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE")

If lvl_Posicao = 0 Then
	lvl_Posicao = PosA(Upper(lvs_SQL), "GROUP BY ")
	If lvl_Posicao > 0 Then
		lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao - 1) + " WHERE " + ps_Where +' '+ MidA(lvs_SQL, lvl_Posicao)	
	Else
		lvl_Posicao = PosA(Upper(lvs_SQL), "HAVING ")
		If lvl_Posicao > 0 Then
			lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao - 1) + " WHERE " + ps_Where +' '+ MidA(lvs_SQL, lvl_Posicao)	
		Else
			lvl_Posicao = PosA(Upper(lvs_SQL), "ORDER BY ")
			If lvl_Posicao > 0 Then
				lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao - 1) + " WHERE " + ps_Where +' '+ MidA(lvs_SQL, lvl_Posicao)	
			Else
				lvs_SQL += " WHERE " + ps_Where
			End If
		End If
	End If
Else
	lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 5) + " " + ps_Where + " and " + &
	          MidA(lvs_SQL, lvl_Posicao + 6)
End If

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_changesql (string ps_sql);This.Object.DataWindow.Table.Select = ps_SQL
This.ivb_SQL_Alterado = True
end subroutine

public subroutine of_appendwhere (string ps_where, integer pi_union);Integer lvi_Contador = 0

String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "SELECT")

Do While lvl_Posicao > 0
	lvi_Contador ++
	If lvi_Contador = pi_Union Then Exit
		
	lvl_Posicao = PosA(Upper(lvs_SQL), "SELECT", lvl_Posicao + 6)
Loop

// Verifica se encontrou o WHERE na posi$$HEX2$$e700e300$$ENDHEX$$o desejada pelo UNION
If lvi_Contador <> pi_Union Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o AppendWhere.", StopSign!)
	Return
End If

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE", lvl_Posicao)

If lvl_Posicao = 0 Then
	lvs_SQL += " WHERE " + ps_Where
Else
	lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 5) + " " + ps_Where + " and " + &
	          MidA(lvs_SQL, lvl_Posicao + 6)
End If

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_appendfrom (string ps_from);String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "FROM", 1)

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 4) + " " + ps_From + ", " + &
          MidA(lvs_SQL, lvl_Posicao + 4)

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_appendfrom (string ps_from, integer pi_union);Integer lvi_Contador = 0

String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "SELECT")

Do While lvl_Posicao > 0
	lvi_Contador ++
	If lvi_Contador = pi_Union Then Exit
		
	lvl_Posicao = PosA(Upper(lvs_SQL), "SELECT", lvl_Posicao + 6)
Loop

// Verifica se encontrou o FROM na posi$$HEX2$$e700e300$$ENDHEX$$o desejada pelo UNION
If lvi_Contador <> pi_Union Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o AppendFrom.", StopSign!)
	Return
End If

lvl_Posicao = PosA(Upper(lvs_SQL), "FROM", lvl_Posicao)

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 4) + " " + ps_From + ", " + &
          MidA(lvs_SQL, lvl_Posicao + 4)

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_restoresqloriginal ();This.Object.DataWindow.Table.Select = This.ivs_SQL_Original
This.ivb_SQL_Alterado = False
end subroutine

public subroutine of_settransobject (transaction ptr_transacao);This.itr_Transacao = ptr_Transacao
This.SetTransObject(ptr_Transacao)
end subroutine

public function long of_importfile (string ps_arquivo);Long lvl_Retorno

String lvs_Mensagem = ""

lvl_Retorno = This.ImportFile(ps_Arquivo)

Choose Case lvl_Retorno
	Case 0
		lvs_Mensagem = "Muitas linhas."
	Case -1
		lvs_Mensagem = "Nenhuma linha."
	Case -2
		lvs_Mensagem = "Arquivo vazio."
	Case -3
		lvs_Mensagem = "Argumento inv$$HEX1$$e100$$ENDHEX$$lido."
	Case -4
		lvs_Mensagem = "Entrada inv$$HEX1$$e100$$ENDHEX$$lida."
	Case -5
		lvs_Mensagem = "Erro na abertura do arquivo."
	Case -6
		lvs_Mensagem = "Erro no fechamento do arquivo."
	Case -7
		lvs_Mensagem = "Erro lendo o arquivo."
	Case -8
		lvs_Mensagem = "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um arquivo texto."
	Case -9
		lvs_Mensagem = "Usu$$HEX1$$e100$$ENDHEX$$rio cancelou a importa$$HEX2$$e700e300$$ENDHEX$$o."
	Case -10
		lvs_Mensagem = "Formato do arquivo dBase n$$HEX1$$e300$$ENDHEX$$o suportado."
End Choose

If Trim(lvs_Mensagem) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na importa$$HEX2$$e700e300$$ENDHEX$$o do arquivo '" + ps_Arquivo + "'.~r~r" + &
	                      "Motivo: " + lvs_Mensagem, StopSign!)
End If

Return lvl_Retorno
end function

public subroutine of_msgupdateerror ();This.ivo_dbError.of_Trata_Erro()
end subroutine

public function boolean of_update (boolean pb_mensagem);If This.Update() = 1 Then
	Return True
Else
	If pb_Mensagem Then
		This.ivo_dbError.of_Trata_Erro()
	End If
	
	Return False
End If


end function

public function boolean of_update ();Return This.of_Update(True)
end function

public subroutine of_saveas (string as_arquivo);String	lvs_Arquivo, &
		lvs_Diretorio, &
		lvs_Extensao

Integer lvi_Retorno


// Verifica o nome do arquivo
If Trim(as_Arquivo) = "" or IsNull(as_Arquivo) Then
	lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
											lvs_Diretorio, 	&
											lvs_Arquivo, 	&
											"XLS", 			&
											"Arquivos Excel (*.XLS),*.XLS,Arquivos Excel Formatado (*.XLS),*.XLSF" 	+ &
											",Arquivos Excel (*.XLSX),*.XLSX,Arquivos CSV (*.CSV),*.CSV"	+ &
											",Arquivos HTML (*.HTML),*.HTML" 		+ &
											",Arquivos Texto (*.TXT),*.TXT")
	
	If lvi_Retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
		Return 
	Else
		If lvi_Retorno = 0 Then Return
	End If
	
Else
	lvs_Diretorio	= as_Arquivo
	lvs_Arquivo 	= as_Arquivo
End If

lvs_Diretorio = Upper( lvs_Diretorio )
lvs_Diretorio = gf_replace(lvs_Diretorio,'.XLSF','.XLS',0)

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return
		End If
	Else
		Return 
	End If   
End If

// Salva o arquivo
lvs_Extensao = gf_replace(Mid(lvs_Arquivo,Len(lvs_Arquivo)-3,4),'.','',0)

lvs_Extensao = Upper( lvs_Extensao )

If (lvs_Extensao = 'XLS') or (lvs_Extensao = 'XLSF') then
	If This.RowCount() > 65000 Then 
		If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',	'Este relat$$HEX1$$f300$$ENDHEX$$rio excede o limite de 65.000 linhas do formato Excel (XLS).~r~n'+ &
											'O arquivo n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salvo neste formato.~r~n~r~n'+ &
											'Deseja selecionar outro formato?',Question!, YesNo!,1)=1 Then 
			This.Of_SaveAs(as_arquivo)
			Return
		Else
			Return
		End If
	End If
End If

Open(w_aguarde_1)
If IsValid(w_aguarde_1) Then w_aguarde_1.Title = 'Aguarde... Salvando...'
Choose Case lvs_Extensao
	Case 'XLS'
		lvi_Retorno = This.SaveAs(lvs_Diretorio, Excel8!, True)
	Case 'XLSX'
		lvi_Retorno = This.SaveAs(lvs_Diretorio, XLSX!, True)
	Case 'CSV'
		//lvi_Retorno = This.SaveAs(lvs_Diretorio, CSV!, True,EncodingUTF8!)
		lvi_Retorno = This.SaveAsFormattedText(lvs_Diretorio, EncodingANSI!, ";", "")
	Case 'HTML'
		lvi_Retorno = This.SaveAs(lvs_Diretorio, HTMLTable!, True)
	Case 'TXT'
		lvi_Retorno = This.SaveAs(lvs_Diretorio, Text!, True,EncodingUTF8!)
	Case 'XLSF'
		If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetMax(2)
		If This.SaveAs( lvs_Diretorio, HTMLTable!, True ) = 1 Then
			If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetProgress(1)
			// Converte arquivo HTML para Excel
			OLEObject Excel 
			Excel = Create OLEObject 
			
			If Excel.ConnectToNewObject('Excel.Application') = 0 Then
				Excel.Application.DisplayAlerts = False
				Excel.Application.Workbooks.Open(lvs_Diretorio)
				Excel.Application.Workbooks( 1 ).Parent.Windows( Excel.Application.Workbooks( 1 ).Name ).Visible = True
				Excel.Application.Workbooks( 1 ).SaveAs(lvs_Diretorio, 56 ) 
				Excel.Application.Workbooks( 1 ).Close()
				Excel.DisconnectObject()
			
				Destroy(Excel)
				lvi_Retorno = 1
			Else
				Destroy(Excel)
				lvi_Retorno = -1
			End If
			If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetProgress(2)
		Else
			lvi_Retorno = -1
		End If
End Choose
If IsValid(w_aguarde_1) Then Close(w_aguarde_1)

If lvi_Retorno <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
	Return 
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
End If
end subroutine

public subroutine of_print (boolean ab_imediato);String lvs_Intervalo

dc_uo_Parametro_Impressao lvo_Parametro

lvo_Parametro = Create dc_uo_Parametro_Impressao

If Not ab_Imediato Then
	OpenWithParm(dc_w_Configuracao_Impressao, lvo_Parametro)

	If lvo_Parametro.ivb_Cancelar_Impressao Then 
		Destroy(lvo_Parametro)
		Return
	End If
Else
	lvo_Parametro.ivb_Todas_Paginas = True

	lvo_Parametro.ivi_Qtde_Copias = 1
	
	lvo_Parametro.ivb_Agrupar_Copias = False
End If

If lvo_Parametro.ivb_Todas_Paginas Then
	lvs_Intervalo = ""
Else
	lvs_Intervalo = String(lvo_Parametro.ivi_Pagina_Inicial) + "-" + String(lvo_Parametro.ivi_Pagina_Final)
End If

This.Object.DataWindow.Print.Page.Range = lvs_Intervalo

This.Object.DataWindow.Print.Copies = lvo_Parametro.ivi_Qtde_Copias

This.Object.DataWindow.Print.Collate = lvo_Parametro.ivb_Agrupar_Copias

This.Print(True)	

Destroy(lvo_Parametro)
end subroutine

public function boolean of_changedataobject (string as_dataobject, boolean ab_mensagem);Integer lvi_Retorno


Try
	if IsValid(This) Then
		This.DataObject = as_DataObject
		
		lvi_Retorno = This.SetTransObject(This.itr_Transacao)
	else
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto n$$HEX1$$e300$$ENDHEX$$o v$$HEX1$$e100$$ENDHEX$$lido para altera$$HEX2$$e700e300$$ENDHEX$$o do dataobject: ' + as_dataobject, StopSign!)
		Return False
	end if
	
	If lvi_Retorno = -1 Then
		If ab_Mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW '" + as_DataObject + "'.", StopSign!)
		End If
		
		Return False
	Else
		if IsValid(This) then
			This.ivs_SQL_Original = This.Object.DataWindow.Table.Select
			This.ivb_SQL_Alterado = False	
			
			Return True
		else
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Objeto n$$HEX1$$e300$$ENDHEX$$o v$$HEX1$$e100$$ENDHEX$$lido para altera$$HEX2$$e700e300$$ENDHEX$$o do dataobject: ' + as_dataobject, StopSign!)
			Return False
		end if
	End If
Catch (RunTimeError rte)
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_changedataobject do objeto dc_uo_ds_base. ~r~r' + rte.GetMessage(), StopSign!)
	Return False
End Try
end function

public function boolean of_changedataobject (string as_dataobject);Return This.of_ChangeDataObject(as_DataObject, True)
end function

public subroutine of_appendselect (string ps_campo);String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "FROM", 1)

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao -1) + ", " + ps_Campo + " " + &
          MidA(lvs_SQL, lvl_Posicao)

This.of_ChangeSQL(lvs_SQL)
end subroutine

public subroutine of_appendwhere_subquery (string ps_where, integer pi_where);Integer lvi_Contador = 0

String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE")

Do While lvl_Posicao > 0
	lvi_Contador ++
	If lvi_Contador = pi_Where Then Exit
		
	lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE", lvl_Posicao + 5)
Loop

// Verifica se encontrou o WHERE na posi$$HEX2$$e700e300$$ENDHEX$$o desejada
If lvi_Contador <> pi_where Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o AppendWhere.", StopSign!)
	Return
End If

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE", lvl_Posicao)

If lvl_Posicao = 0 Then
	lvs_SQL += " WHERE " + ps_Where
Else
	lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao + 5) + " " + ps_Where + " and " + &
	          MidA(lvs_SQL, lvl_Posicao + 6)
End If

This.of_ChangeSQL(lvs_SQL)
end subroutine

public function string of_getsql ();Return This.Object.DataWindow.Table.Select
end function

public function boolean of_exporta_excel (string ps_arquivo);String lvs_Arquivo
String lvs_Diretorio

Long lvi_Retorno

lvs_Diretorio = ps_arquivo

lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
										lvs_Diretorio, &
										lvs_Arquivo, &
										"XLS", "Arquivos do Excel (*.XLS)")

If lvi_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
	Return False
Else
	If lvi_Retorno = 0 Then Return False
End If

lvs_Diretorio = Upper(lvs_Diretorio)

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return False
		End If
	Else
		Return False
   End If   
End If

If This.SaveAs( lvs_Diretorio, HTMLTable!, True ) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel exportar os dados.~r~n Erro ao sobreescrever o arquivo: "+lvs_Arquivo+"!",Exclamation!)
	Return False
End If

// Convert HTML file to Excel native format
OLEObject Excel 
Excel = Create OLEObject 

If Excel.ConnectToNewObject('Excel.Application') = 0 Then
	Excel.Application.DisplayAlerts = False
	Excel.Application.Workbooks.Open(lvs_Diretorio)
	Excel.Application.Workbooks( 1 ).Parent.Windows( Excel.Application.Workbooks( 1 ).Name ).Visible = True
	Excel.Application.Workbooks( 1 ).SaveAs(lvs_Diretorio, 56 ) 
	Excel.Application.Workbooks( 1 ).Close()
	Excel.DisconnectObject()
	
	MessageBox('Sucesso!','Arquivo gerado: '+lvs_Diretorio)

	Destroy(Excel)
	Return True
Else
	MessageBox('Erro!','O arquivo n$$HEX1$$e300$$ENDHEX$$o pode ser salvo!',StopSign!)
	Destroy(Excel)
	Return False
End If
end function

public subroutine of_appendfrom_ansi (string ps_from, integer pi_union);Integer lvi_Contador = 0

String lvs_SQL

Long lvl_Posicao

lvs_SQL = This.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE")

Do While lvl_Posicao > 0
	lvi_Contador ++
	If lvi_Contador = pi_Union Then Exit
		
	lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE", lvl_Posicao + 5)
Loop

// Verifica se encontrou o FROM na posi$$HEX2$$e700e300$$ENDHEX$$o desejada pelo UNION
If lvi_Contador <> pi_Union Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o AppendFrom.", StopSign!)
	Return
End If

lvl_Posicao = PosA(Upper(lvs_SQL), "WHERE ", lvl_Posicao - 5 )

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao - 1) + " " + ps_From + " " + &
          MidA(lvs_SQL, lvl_Posicao)

This.of_ChangeSQL(lvs_SQL)
end subroutine

on dc_uo_ds_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_ds_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_SetTransObject(SqlCa)

ivo_dbError = Create dc_uo_dbError

ivl_Numero_Paginas = 0

end event

event destructor;Destroy(ivo_dbError)
end event

event dberror;String lvs_Mensagem

SetPointer(HourGlass!)


if not gf_valida_dberror_auto(SqlErrText) then
	Return -1
end if

If SqldbCode = -3 Then
	lvs_Mensagem = "Ocorreram altera$$HEX2$$e700f500$$ENDHEX$$es no banco de dados em uma das informa$$HEX2$$e700f500$$ENDHEX$$es modificadas " + &
	               "nesta janela. Por favor, recupere os registros novamente e proceda as modifica$$HEX2$$e700f500$$ENDHEX$$es " + &
					   "efetuadas."
Else
	lvs_Mensagem = "Ocorreu um erro de base de dados.~r~n~r~n~r~n" + &
						"C$$HEX1$$f300$$ENDHEX$$digo:  " + String(SqldbCode) + "~r~n~r~n" + &
						"Descri$$HEX2$$e700e300$$ENDHEX$$o:~r~n" + SqlErrText
End If

// Atualiza as informa$$HEX2$$e700f500$$ENDHEX$$es sobre o erro ocorrido
This.ivo_dbError.ivl_SqldbCode  = SqldbCode
This.ivo_dbError.ivs_SqlErrText = SqlErrText
This.ivo_dbError.ivs_SqlSyntax  = SqlSyntax
This.ivo_dbError.ivs_Mensagem   = lvs_Mensagem
This.ivo_dbError.ivs_DataBase   = This.itr_Transacao.ivs_DataBase

SetPointer(Arrow!)
Return 1
end event

event printpage;ivl_Numero_Paginas = pagenumber

end event

