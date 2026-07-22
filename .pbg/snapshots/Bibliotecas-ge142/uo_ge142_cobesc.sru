HA$PBExportHeader$uo_ge142_cobesc.sru
forward
global type uo_ge142_cobesc from nonvisualobject
end type
end forward

global type uo_ge142_cobesc from nonvisualobject
end type
global uo_ge142_cobesc uo_ge142_cobesc

type variables
uo_parametro_geral ivo_parametro

String 	ivs_Carteira_Manual, &
          	ivs_Carteira_Automatica, &
			ivs_Portador_Sicredi, &
			ivs_Agencia_Sicredi, &
			ivs_Cedente_Sicredi, &
			ivs_Posto_Sicredi, &
	    		ivs_Ano, &
		 	ivs_Byte_Geracao_Nosso_Numero
end variables

forward prototypes
public function boolean of_calculo_digito_verificador (string ps_nr_titulo_banco, ref string ps_digito_verificador)
public function boolean of_verifica_digito_verificador (string ps_nr_titulo_banco)
public function boolean of_titulo_banco (ref string ps_nr_titulo_banco)
public function boolean of_proximo_titulo_banco (ref string ps_nr_titulo_banco)
public function boolean of_inicializa_parametros ()
public function string of_string (string ps_string, integer pi_tamanho)
public function string of_date (datetime pdh_data)
public function string of_decimal (decimal pdc_valor, integer pi_tamanho)
public function string of_decimal (decimal pdc_valor, integer pi_tamanho, integer pi_decimal)
public function datetime of_datetime (string ps_string)
public function boolean of_proximo_titulo_banco_old (ref string ps_nr_titulo_banco)
public function boolean of_proximo_titulo_sicredi (ref string ps_nr_titulo_banco)
public function boolean of_titulo_banco_sicredi (ref string ps_nr_titulo_banco)
public function boolean of_calculo_digito_verificador_sicredi (string ps_nr_titulo_banco, ref string ps_digito_verificador)
end prototypes

public function boolean of_calculo_digito_verificador (string ps_nr_titulo_banco, ref string ps_digito_verificador);Integer lvi_Resto_Digito

Long lvl_Soma_Digito
		  
lvl_Soma_Digito = long(MidA(ps_nr_titulo_banco,01,1)) * 2 + &
                  long(MidA(ps_nr_titulo_banco,02,1)) * 7 + &
						long(MidA(ps_nr_titulo_banco,03,1)) * 6 + &
						long(MidA(ps_nr_titulo_banco,04,1)) * 5 + &
                  long(MidA(ps_nr_titulo_banco,05,1)) * 4 + &
						long(MidA(ps_nr_titulo_banco,06,1)) * 3 + &
						long(MidA(ps_nr_titulo_banco,07,1)) * 2 + &
						long(MidA(ps_nr_titulo_banco,08,1)) * 7 + &
						long(MidA(ps_nr_titulo_banco,09,1)) * 6 + &
						long(MidA(ps_nr_titulo_banco,10,1)) * 5 + &
						long(MidA(ps_nr_titulo_banco,11,1)) * 4 + &
						long(MidA(ps_nr_titulo_banco,12,1)) * 3 + &
						long(MidA(ps_nr_titulo_banco,13,1)) * 2 

lvi_Resto_Digito = Mod(lvl_Soma_Digito,11)	

Choose Case lvi_Resto_Digito
	Case 0    ; ps_Digito_VerIficador = '0'
	Case 1    ; ps_Digito_VerIficador = 'P'
	Case Else ; ps_Digito_VerIficador = String(11 - lvi_resto_digito)		
End Choose
	
Return true
end function

public function boolean of_verifica_digito_verificador (string ps_nr_titulo_banco);Integer lvi_Resto_Digito

Long lvl_Soma_Digito
		  
String lvs_digito_verIficador ,&
       lvs_nosso_numero       

If MidA(ps_nr_titulo_banco,1,2) <> ivs_Carteira_Manual and MidA(ps_nr_titulo_banco,1,2) <> ivs_Carteira_Automatica Then
   beep(1)
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Carteira inv$$HEX1$$e100$$ENDHEX$$lida.',StopSign!,OK!)
	Return False
End If
	
lvl_Soma_Digito = long(MidA(ps_nr_titulo_banco,01,1)) * 2 + &
                  long(MidA(ps_nr_titulo_banco,02,1)) * 7 + &
						long(MidA(ps_nr_titulo_banco,03,1)) * 6 + &
						long(MidA(ps_nr_titulo_banco,04,1)) * 5 + &
                  long(MidA(ps_nr_titulo_banco,05,1)) * 4 + &
						long(MidA(ps_nr_titulo_banco,06,1)) * 3 + &
						long(MidA(ps_nr_titulo_banco,07,1)) * 2 + &
						long(MidA(ps_nr_titulo_banco,08,1)) * 7 + &
						long(MidA(ps_nr_titulo_banco,09,1)) * 6 + &
						long(MidA(ps_nr_titulo_banco,10,1)) * 5 + &
						long(MidA(ps_nr_titulo_banco,11,1)) * 4 + &
						long(MidA(ps_nr_titulo_banco,12,1)) * 3 + &
						long(MidA(ps_nr_titulo_banco,13,1)) * 2 							
		
lvi_Resto_Digito = Mod(lvl_Soma_Digito,11)	

Choose Case lvi_resto_digito 
	Case 0    ; lvs_digito_verIficador = '0'
	Case 1    ; lvs_digito_verIficador = 'P'
	Case Else ; lvs_digito_verIficador = String(11 - lvi_Resto_Digito)
End Choose
	
If MidA(ps_nr_titulo_banco,14,1) <> lvs_digito_verIficador Then
   beep(1)
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Digito Verificador n$$HEX1$$e300$$ENDHEX$$o Confere - Redigite n$$HEX1$$fa00$$ENDHEX$$mero do t$$HEX1$$ed00$$ENDHEX$$tulo banco.',StopSign!,OK!)
	Return False
End If	

Return True
end function

public function boolean of_titulo_banco (ref string ps_nr_titulo_banco);Boolean lvb_Sucesso = False

String lvs_Digito_Verificador

// Verifica pr$$HEX1$$f300$$ENDHEX$$ximo t$$HEX1$$ed00$$ENDHEX$$tulo
If This.of_Proximo_Titulo_Banco(ref ps_nr_titulo_banco) Then
	
	// Seleciona o d$$HEX1$$ed00$$ENDHEX$$gito de auto-confer$$HEX1$$ea00$$ENDHEX$$ncia
	If This.of_Calculo_Digito_Verificador(ivs_Carteira_Automatica + ps_nr_titulo_banco, ref lvs_Digito_Verificador) Then
	
		ps_nr_titulo_banco += lvs_Digito_Verificador
		
		// Atualiza o pr$$HEX1$$f300$$ENDHEX$$ximo t$$HEX1$$ed00$$ENDHEX$$tulo
		If This.of_Verifica_Digito_Verificador(ivs_Carteira_Automatica + ps_nr_titulo_banco) Then lvb_Sucesso = True
	End If
End If

ps_nr_titulo_banco = ivs_Carteira_Automatica + ps_nr_titulo_banco

Return lvb_Sucesso
end function

public function boolean of_proximo_titulo_banco (ref string ps_nr_titulo_banco);Boolean lvb_Sucesso = True

Double 	lvd_Nr_Titulo_Banco

Return This.of_Proximo_Titulo_Banco_Old(ps_nr_titulo_banco)


// Cria$$HEX2$$e700e300$$ENDHEX$$o: Douglas Starosky
// Data: 20/08/2014
// Tabela com campo identity - procedimento criado visando eliminar a concorr$$HEX1$$ea00$$ENDHEX$$ncia entre processos de fechamento
// CC e CV.
Insert Into titulo_receber_banco(id_titulo_banco) 
Values('S')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do titulo_receber_banco", StopSign!)
	Return False
End If

SqlCa.Of_Commit()

Select max(@@identity)
Into :lvd_Nr_Titulo_Banco
 From titulo_receber_banco
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na sele$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo t$$HEX1$$ed00$$ENDHEX$$tulo banc$$HEX1$$e100$$ENDHEX$$rio.", StopSign!)
	Return False
End If

Delete From titulo_receber_banco
Where nr_titulo_banco < :lvd_Nr_Titulo_Banco
Using SqlCa;

SqlCa.Of_Commit()

ps_Nr_Titulo_Banco = String(lvd_Nr_Titulo_Banco, "00000000000")	
	
If LenA(ps_Nr_Titulo_Banco) <> 11 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Tamanho do pr$$HEX1$$f300$$ENDHEX$$ximo t$$HEX1$$ed00$$ENDHEX$$tulo no banco inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
	Return False
End If

Return lvb_Sucesso
end function

public function boolean of_inicializa_parametros ();SetNull(ivs_Carteira_Manual)
SetNull(ivs_Carteira_Automatica)
SetNull(ivs_Portador_Sicredi)
SetNull(ivs_Agencia_Sicredi)
SetNull(ivs_Cedente_Sicredi)
SetNull(ivs_Posto_Sicredi)

// Seleciona a carteira Manual
If Not ivo_Parametro.of_Localiza_Parametro("CD_CARTEIRA_BRADESCO_MANUAL", ref ivs_Carteira_Manual) Then Return False

// Seleciona a carteira Autom$$HEX1$$e100$$ENDHEX$$tica
If Not ivo_Parametro.of_Localiza_Parametro("CD_CARTEIRA_BRADESCO_AUTOMATICA", ref ivs_Carteira_Automatica) Then Return False

If Not ivo_Parametro.of_Localiza_Parametro("CD_AGENCIA_SICREDI", ref ivs_Agencia_Sicredi) Then Return False
If Not ivo_Parametro.of_Localiza_Parametro("CD_CEDENTE_SICREDI", ref ivs_Cedente_Sicredi) Then Return False
If Not ivo_Parametro.of_Localiza_Parametro("CD_POSTO_SICREDI", ref ivs_Posto_Sicredi) Then Return False
If Not ivo_Parametro.of_Localiza_Parametro("CD_PORTADOR_SICREDI", ref ivs_Portador_Sicredi) Then Return False

ivs_Ano 									= String(gf_GetServerDate(), "YY")
ivs_Byte_Geracao_Nosso_Numero = "2"

Return True
end function

public function string of_string (string ps_string, integer pi_tamanho);String lvs_String

If IsNull(ps_String) Then ps_String = ""

lvs_String = LeftA(ps_String, pi_Tamanho) + Space(pi_Tamanho - LenA(ps_String))

Return lvs_String
end function

public function string of_date (datetime pdh_data);String lvs_String

If Not IsNull(pdh_Data) Then
	lvs_String  = String(pdh_Data, "ddmmyy")
Else
	lvs_String = "000000"
End If

Return lvs_String
end function

public function string of_decimal (decimal pdc_valor, integer pi_tamanho);Return This.of_Decimal(pdc_Valor, pi_Tamanho, 2)
end function

public function string of_decimal (decimal pdc_valor, integer pi_tamanho, integer pi_decimal);String lvs_Valor, &
       lvs_Zeros, &
		 lvs_Decimal

Integer lvi_Contador

If IsNull(pdc_Valor) Then pdc_Valor = 0

For lvi_Contador = 1 To pi_Decimal
	lvs_Decimal += "0"
Next

lvs_Valor = String(pdc_Valor, "0." + lvs_Decimal)

lvs_Valor = LeftA(lvs_Valor, LenA(lvs_Valor) - pi_Decimal - 1) + RightA(lvs_Valor, pi_Decimal)

For lvi_Contador = 1 To pi_Tamanho - LenA(lvs_Valor)
	lvs_Zeros += "0"
Next

lvs_Valor = lvs_Zeros + lvs_Valor

Return lvs_Valor
end function

public function datetime of_datetime (string ps_string);DateTime lvdh_Data

String lvs_Data

If ps_String = "" Then ps_String = "000000"
		 
If ps_String <> "000000" Then
	lvs_Data = LeftA(ps_String, 2) + "/" + &
				  MidA(ps_String, 3, 2) + "/" + &
				  MidA(ps_String, 5, 2)
	
	If Not IsDate(lvs_Data) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Imposs$$HEX1$$ed00$$ENDHEX$$vel converter a string '" + lvs_Data + "' para uma data.", StopSign!)
		SetNull(lvdh_Data)
	Else
		lvdh_Data = DateTime(Date(lvs_Data))
	End If
Else
	SetNull(lvdh_Data)
End If

Return lvdh_Data
end function

public function boolean of_proximo_titulo_banco_old (ref string ps_nr_titulo_banco);Boolean lvb_Sucesso = False

If ivo_Parametro.of_Localiza_Parametro('NR_ULTIMO_TITULO_BANCO', ref ps_Nr_Titulo_Banco) Then
	
	If IsNull(ps_Nr_Titulo_Banco) Then ps_Nr_Titulo_Banco = "00000000000"

	ps_Nr_Titulo_Banco = String(Long(ps_Nr_Titulo_Banco) + 1, "00000000000")
	
	If LenA(ps_Nr_Titulo_Banco) <> 11 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tamanho do pr$$HEX1$$f300$$ENDHEX$$ximo t$$HEX1$$ed00$$ENDHEX$$tulo no banco inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
		Return False
	End If
	
	// Atualiza Parametro
	If ivo_Parametro.of_Atualiza_Parametro('NR_ULTIMO_TITULO_BANCO', ps_Nr_Titulo_Banco) Then lvb_Sucesso = True
	
End If

Return lvb_Sucesso
end function

public function boolean of_proximo_titulo_sicredi (ref string ps_nr_titulo_banco);Boolean lvb_Sucesso = False

If ivo_Parametro.of_Localiza_Parametro('NR_ULTIMO_TITULO_BANCO_SICREDI', ref ps_Nr_Titulo_Banco) Then
	
	If IsNull(ps_Nr_Titulo_Banco) Then ps_Nr_Titulo_Banco = "00000"

	ps_Nr_Titulo_Banco = String(Long(ps_Nr_Titulo_Banco) + 1, "00000")
	
	If LenA(ps_Nr_Titulo_Banco) <> 5 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tamanho do pr$$HEX1$$f300$$ENDHEX$$ximo t$$HEX1$$ed00$$ENDHEX$$tulo no banco inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
		Return False
	End If
	
	// Atualiza Parametro
	If ivo_Parametro.of_Atualiza_Parametro('NR_ULTIMO_TITULO_BANCO_SICREDI', ps_Nr_Titulo_Banco) Then lvb_Sucesso = True
	
End If

Return lvb_Sucesso
end function

public function boolean of_titulo_banco_sicredi (ref string ps_nr_titulo_banco);Boolean lvb_Sucesso = False

String lvs_Digito_Verificador

// Verifica pr$$HEX1$$f300$$ENDHEX$$ximo t$$HEX1$$ed00$$ENDHEX$$tulo
If This.of_Proximo_Titulo_Sicredi(ref ps_nr_titulo_banco) Then
	
	// Seleciona o d$$HEX1$$ed00$$ENDHEX$$gito de auto-confer$$HEX1$$ea00$$ENDHEX$$ncia
	If This.of_Calculo_Digito_Verificador_Sicredi(ps_nr_titulo_banco, ref lvs_Digito_Verificador) Then
	
//		ps_nr_titulo_banco += lvs_Digito_Verificador
		
		lvb_Sucesso = True
//		// Atualiza o pr$$HEX1$$f300$$ENDHEX$$ximo t$$HEX1$$ed00$$ENDHEX$$tulo
//		If This.of_Verifica_Digito_Verificador_Sicredi(ps_nr_titulo_banco) Then lvb_Sucesso = True
	End If
End If

// 16 2 00001 5
ps_nr_titulo_banco = ivs_Ano + ivs_Byte_Geracao_Nosso_Numero + ps_nr_titulo_banco + lvs_Digito_Verificador

Return lvb_Sucesso
end function

public function boolean of_calculo_digito_verificador_sicredi (string ps_nr_titulo_banco, ref string ps_digito_verificador);Integer lvi_Resto_Digito

Long 	lvl_Soma_Digito
		  
lvl_Soma_Digito = long(MidA(ivs_Agencia_Sicredi,01,1)) * 4 + &
                  		long(MidA(ivs_Agencia_Sicredi,02,1)) * 3 + &
						long(MidA(ivs_Agencia_Sicredi,03,1)) * 2 + &
						long(MidA(ivs_Agencia_Sicredi,04,1)) * 9 + &
                  		long(MidA(ivs_Posto_Sicredi,01,1)) * 8 + &
						long(MidA(ivs_Posto_Sicredi,02,1)) * 7 + &
						long(MidA(ivs_Cedente_Sicredi,01,1)) * 6 + &
						long(MidA(ivs_Cedente_Sicredi,02,1)) * 5 + &
						long(MidA(ivs_Cedente_Sicredi,03,1)) * 4 + &
						long(MidA(ivs_Cedente_Sicredi,04,1)) * 3 + &
						long(MidA(ivs_Cedente_Sicredi,05,1)) * 2 + &
						long(MidA(ivs_Ano,01,1)) * 9 + &
						long(MidA(ivs_Ano,02,1)) * 8 + &
						long(ivs_Byte_Geracao_Nosso_Numero) * 7 + &
						long(MidA(ps_nr_titulo_banco,01,1)) * 6 + &
						long(MidA(ps_nr_titulo_banco,02,1)) * 5 + &
						long(MidA(ps_nr_titulo_banco,03,1)) * 4 + &
						long(MidA(ps_nr_titulo_banco,04,1)) * 3 + &
						long(MidA(ps_nr_titulo_banco,05,1)) * 2

lvi_Resto_Digito 	= lvl_Soma_Digito / 11
lvi_Resto_Digito	= lvi_Resto_Digito * 11
lvi_Resto_Digito	= lvl_Soma_Digito - lvi_Resto_Digito
lvi_Resto_Digito	= 11 - lvi_Resto_Digito

ps_Digito_VerIficador = String(lvi_Resto_Digito)

If lvi_Resto_Digito > 9 Then ps_Digito_VerIficador = '0'

Return true
end function

on uo_ge142_cobesc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge142_cobesc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_Parametro = Create uo_parametro_geral

If Not This.of_Inicializa_Parametros() Then 
	Destroy(ivo_Parametro)
	Close(Parent)
End If


end event

event destructor;Destroy(ivo_Parametro)
end event

