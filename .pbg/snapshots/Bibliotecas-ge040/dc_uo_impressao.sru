HA$PBExportHeader$dc_uo_impressao.sru
forward
global type dc_uo_impressao from nonvisualobject
end type
end forward

global type dc_uo_impressao from nonvisualobject
end type
global dc_uo_impressao dc_uo_impressao

type variables
Boolean ivb_usa_cabecalho = FALSE

Long   ivl_Pagina
 
String   ivs_Impressora,&
            ivs_Titulo_Relatorio

Integer ivi_Arquivo,&
            ivi_Colunas

Long    ivl_Linha,&
            ivl_Linhas_Pagina

end variables

forward prototypes
public function boolean of_insere_linha (string ps_linha)
public function boolean of_modelo_impressora (string ps_modelo)
public subroutine of_colunas (long pl_colunas)
public subroutine of_linhas_pagina (long pl_linhas)
public function boolean of_salta_pagina ()
public subroutine of_finalizar ()
public subroutine of_titulo_relatorio (string ps_titulo)
public subroutine of_usa_cabecalho (boolean pb_cabecalho)
public subroutine of_cabecalho_padrao ()
public function boolean of_insere_linha_cabecalho (string ps_linha)
public function boolean of_inicializar ()
public function long of_linha ()
public function boolean of_imprimir (string ps_lpt)
public function boolean of_imprimir ()
public function boolean of_final_pagina ()
public subroutine of_salta_linha ()
public function boolean of_salta_linha (long pl_linha)
public function string of_char_eject ()
public function boolean of_configura_impressao (string ps_configuracao)
public function boolean of_inicializar (string as_tipo)
public function boolean of_imprimir (integer ai_tipo)
end prototypes

public function boolean of_insere_linha (string ps_linha);Integer lvi_Retorno

If ivl_Linha = 0 Then

	//Insere Cabecalho Padrao	
	If ivb_usa_cabecalho Then of_cabecalho_padrao()
			
End If	

ps_Linha = Trim(ps_Linha)

lvi_Retorno = FileWrite(ivi_Arquivo,ps_Linha)

If lvi_Retorno = -1 Then Return False

//Incrementa linha para controle de saldo de p$$HEX1$$e100$$ENDHEX$$gina
ivl_Linha ++

//Tamanho m$$HEX1$$e100$$ENDHEX$$ximo de linhas na p$$HEX1$$e100$$ENDHEX$$gina
If ivl_Linha >= ivl_Linhas_Pagina Then
	
	of_salta_pagina()

	//Reinicializa Controladores
	ivl_Linha = 0
	ivl_Pagina ++
				
End If	

Return True
end function

public function boolean of_modelo_impressora (string ps_modelo);
Choose Case ps_Modelo 
	Case "EPSON"
		ivs_Impressora = ps_Modelo
	Case Else	
		ivs_Impressora = 'EPSON' // Default
End Choose

Return True
end function

public subroutine of_colunas (long pl_colunas);
If pl_Colunas > 130 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero m$$HEX1$$e100$$ENDHEX$$ximo de colunas $$HEX1$$e900$$ENDHEX$$ 130",StopSign!)
	ivi_Colunas = 130
Else
	ivi_Colunas = pl_Colunas
End If	
	
end subroutine

public subroutine of_linhas_pagina (long pl_linhas);
ivl_Linhas_Pagina = pl_linhas
end subroutine

public function boolean of_salta_pagina ();Integer lvi_Retorno

String  lvs_Char

ivl_Linha  = 0
ivl_Pagina ++

lvs_Char = of_char_eject()

lvi_Retorno = FileWrite(ivi_Arquivo,lvs_Char)

If lvi_Retorno = -1 Then Return False

Return True

end function

public subroutine of_finalizar ();FileClose(ivi_Arquivo) //Fecha arquivo para impress$$HEX1$$e300$$ENDHEX$$o
end subroutine

public subroutine of_titulo_relatorio (string ps_titulo);ivs_Titulo_Relatorio = ps_titulo
end subroutine

public subroutine of_usa_cabecalho (boolean pb_cabecalho);ivb_usa_cabecalho = pb_cabecalho
end subroutine

public subroutine of_cabecalho_padrao ();String lvs_Linha

lvs_Linha = FillA('*',ivi_Colunas)

of_insere_linha_cabecalho(lvs_Linha)

lvs_Linha  = 'DROGARIA E FARMACIA CATARINSE S/A'
lvs_Linha += FillA(' ', ivi_Colunas - LenA(Trim(lvs_Linha)) - 16) + 'DATA: ' + String(Today(),'dd/mm/yyyy')

of_insere_linha_cabecalho(lvs_Linha)

lvs_Linha  = '.' + FillA(' ', ivi_Colunas - 8) + 'PAG:' + String(ivl_Pagina,'000')

of_insere_linha_cabecalho(lvs_Linha)

lvs_Linha  = ivs_Titulo_Relatorio

of_insere_linha_cabecalho(lvs_Linha)

lvs_Linha = FillA('*',ivi_Colunas)

of_insere_linha_cabecalho(lvs_Linha)
end subroutine

public function boolean of_insere_linha_cabecalho (string ps_linha);Integer lvi_Retorno

If LenA(Trim(ps_Linha)) > ivi_Colunas Then

	//Redimensiona a linha para o tamanho m$$HEX1$$e100$$ENDHEX$$ximo
	ps_Linha = LeftA(ps_Linha,ivi_Colunas)
	
Else 

	//Preenche at$$HEX1$$e900$$ENDHEX$$ o tamanho m$$HEX1$$e100$$ENDHEX$$ximo da linha com caracteres em branco
	ps_Linha = Trim(ps_Linha) + FillA(' ',ivi_Colunas - LenA(Trim(ps_Linha)))
	
End If

lvi_Retorno = FileWrite(ivi_Arquivo,ps_Linha)

If lvi_Retorno = -1 Then Return False

//Incrementa linha para controle de saldo de p$$HEX1$$e100$$ENDHEX$$gina
ivl_Linha ++

Return True
end function

public function boolean of_inicializar ();ivi_Arquivo = FileOpen("c:\impressao.tmp",LineMode!,Write!,LockWrite!,Replace!)

If ivi_Arquivo = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar arquivo tempor$$HEX1$$e100$$ENDHEX$$rio para impress$$HEX1$$e300$$ENDHEX$$o")
	Return False
End If

If Not FileExists('C:\IMPRIMIR.BAT') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Redirecionamento de impress$$HEX1$$e300$$ENDHEX$$o c:\imprimir.bat n$$HEX1$$e300$$ENDHEX$$o encontrado.",Exclamation!)
	Return False
End If	

//Default
ivl_Linha  = 0
ivl_Pagina = 1

//Default
ivl_Linhas_Pagina = 60

//Default
ivi_Colunas = 80

//Default
ivs_Impressora = "EPSON"

Return True

end function

public function long of_linha ();Return ivl_linha
end function

public function boolean of_imprimir (string ps_lpt);Integer lvi_Retorno

lvi_Retorno = Run('C:\IMPRIMIR.BAT C:\impressao.tmp ' + ps_lpt ,Minimized!)

If lvi_Retorno = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao enviar dados para a impressora.",StopSign!)
	Return False
End If	

Return True

end function

public function boolean of_imprimir ();Integer lvi_Retorno

lvi_Retorno = Run('C:\IMPRIMIR.BAT C:\impressao.tmp',Minimized!)

If lvi_Retorno = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao enviar dados para a impressora.",StopSign!)
	Return False
End If	

Return True

end function

public function boolean of_final_pagina ();
If ivl_Linha >= ivl_Linhas_Pagina Then Return True

Return False
end function

public subroutine of_salta_linha ();of_Salta_Linha(1)
end subroutine

public function boolean of_salta_linha (long pl_linha);Long    lvl_Conta

Integer lvi_Retorno

ivl_Pagina ++

For lvl_Conta = 1 To pl_Linha

	lvi_Retorno = FileWrite(ivi_Arquivo,"")
	
	If lvi_Retorno = -1 Then Return False
	
Next	

ivl_Linha = ivl_Linha + pl_Linha

Return True

end function

public function string of_char_eject ();String lvs_Char

Choose Case ivs_Impressora
	Case "EPSON"	
		lvs_Char = CharA(12)
		
End Choose		

Return lvs_Char
end function

public function boolean of_configura_impressao (string ps_configuracao);Integer lvi_Retorno

lvi_Retorno = FileWrite(ivi_Arquivo,ps_configuracao)

If lvi_Retorno = -1 Then Return False

Return True

end function

public function boolean of_inicializar (string as_tipo);// Estoque Central
If as_Tipo = "E" Then
	ivi_Arquivo = FileOpen("c:\impressao.tmp",LineMode!,Write!,LockWrite!,Replace!)
Else
	// Almoxarifado
	ivi_Arquivo = FileOpen("c:\impressao_almox.tmp",LineMode!,Write!,LockWrite!,Replace!)
End If

If ivi_Arquivo = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar arquivo tempor$$HEX1$$e100$$ENDHEX$$rio para impress$$HEX1$$e300$$ENDHEX$$o")
	Return False
End If


If as_Tipo = "E" Then
	If Not FileExists('C:\IMPRIMIR.BAT') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Redirecionamento de impress$$HEX1$$e300$$ENDHEX$$o c:\imprimir.bat n$$HEX1$$e300$$ENDHEX$$o encontrado.",Exclamation!)
		Return False
	End If	
Else
	If Not FileExists('C:\IMPRIMIR_ALMOX.BAT') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Redirecionamento de impress$$HEX1$$e300$$ENDHEX$$o c:\imprimir_almox.bat n$$HEX1$$e300$$ENDHEX$$o encontrado.",Exclamation!)
		Return False
	End If	
End If

//Default
ivl_Linha  = 0
ivl_Pagina = 1

//Default
ivl_Linhas_Pagina = 60

//Default
ivi_Colunas = 80

//Default
ivs_Impressora = "EPSON"

Return True

end function

public function boolean of_imprimir (integer ai_tipo);Integer lvi_Retorno

// estoque
If ai_tipo = 1 Then
	lvi_Retorno = Run('C:\IMPRIMIR.BAT C:\impressao.tmp',Minimized!)
Else
	// Almoxarifado
	lvi_Retorno = Run('C:\IMPRIMIR_ALMOX.BAT C:\impressao_almox.tmp',Minimized!)
End If

If lvi_Retorno = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao enviar dados para a impressora.",StopSign!)
	Return False
End If	

Return True

end function

on dc_uo_impressao.create
TriggerEvent( this, "constructor" )
end on

on dc_uo_impressao.destroy
TriggerEvent( this, "destructor" )
end on

event destructor;FileClose(ivi_Arquivo)

//FileDelete('c:\impressao.tmp')


end event

