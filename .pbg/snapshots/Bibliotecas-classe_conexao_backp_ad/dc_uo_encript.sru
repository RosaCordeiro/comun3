HA$PBExportHeader$dc_uo_encript.sru
forward
global type dc_uo_encript from nonvisualobject
end type
end forward

global type dc_uo_encript from nonvisualobject descriptor "PS_JaguarProject" = "" 
end type
global dc_uo_encript dc_uo_encript

type variables
String ivs_Origem[]={'1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','X','Z','W','Y','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','x','z','w','y','$$HEX1$$c100$$ENDHEX$$','$$HEX1$$c000$$ENDHEX$$','$$HEX1$$c300$$ENDHEX$$','$$HEX1$$c900$$ENDHEX$$','$$HEX1$$c800$$ENDHEX$$','$$HEX1$$cd00$$ENDHEX$$','$$HEX1$$d300$$ENDHEX$$','$$HEX1$$d500$$ENDHEX$$','$$HEX1$$da00$$ENDHEX$$','$$HEX1$$c700$$ENDHEX$$','$$HEX1$$e100$$ENDHEX$$','$$HEX1$$e000$$ENDHEX$$','$$HEX1$$e300$$ENDHEX$$','$$HEX1$$e900$$ENDHEX$$','$$HEX1$$e800$$ENDHEX$$','$$HEX1$$ea00$$ENDHEX$$','$$HEX1$$ed00$$ENDHEX$$','$$HEX1$$f500$$ENDHEX$$','$$HEX1$$fa00$$ENDHEX$$','$$HEX1$$e700$$ENDHEX$$','@','!','&','$','%','+','-','*','_',' '}
String ivs_Destino[]={'G','u','$$HEX1$$da00$$ENDHEX$$','f','_','4','*','S','2','a','l','$$HEX1$$cd00$$ENDHEX$$','c','g','$$HEX1$$c300$$ENDHEX$$','h','j','$$HEX1$$d500$$ENDHEX$$','o','$$HEX1$$c100$$ENDHEX$$','$$HEX1$$e000$$ENDHEX$$','$$HEX1$$c700$$ENDHEX$$','q','r','$$HEX1$$d300$$ENDHEX$$','x','y','U','C','i','+','V','$$HEX1$$e300$$ENDHEX$$','X','e','B','Z','d','$$HEX1$$c800$$ENDHEX$$','z','W','b','O','k','5','K','n','L','v','$$HEX1$$c900$$ENDHEX$$','$$HEX1$$e800$$ENDHEX$$','M','p','E','$$HEX1$$ed00$$ENDHEX$$','N','$$HEX1$$e700$$ENDHEX$$','P','%','6','t','7','@','!','0','A','$$HEX1$$e900$$ENDHEX$$',' ','D','&','$$HEX1$$fa00$$ENDHEX$$','F','3','H','m','$$HEX1$$c000$$ENDHEX$$','$$HEX1$$e100$$ENDHEX$$','$','I','J','Q','s','-','Y','1','R','$$HEX1$$f500$$ENDHEX$$','T','8','$$HEX1$$ea00$$ENDHEX$$','9','w'}

private:
String  Chave
end variables

forward prototypes
private function long of_posicao_origem (string ps_char)
private function long of_posicao_destino (string ps_char)
private function string of_encripta_char (string ps_char, long pl_posicao)
private function string of_decripta_char (string ps_char, long pl_posicao)
private function string of_caracter_destino (long pl_posicao)
private function string of_caracter_origem (long pl_posicao)
public function string of_encripta (string ps_texto)
public function boolean of_set_mapas (string ps_origem[], string ps_destino[])
private function string of_retorna_chave (string ps_chave)
public function string of_encripta (string ps_senha, string ps_chave, boolean pb_add_chave)
private function string of_desembaralha_texto (string ps_texto)
private function string of_embaralha_texto (string ps_texto)
public function string of_decripta (string ps_senha, string ps_chave, boolean pb_add_chave)
public function integer of_retorna_passagens ()
end prototypes

private function long of_posicao_origem (string ps_char);Long lvl_Linha

For lvl_Linha = 1 To UpperBound(ivs_Origem)
	If ivs_Origem[lvl_Linha] = ps_char Then	Return lvl_Linha
Next

Return -1
end function

private function long of_posicao_destino (string ps_char);Long lvl_Linha

For lvl_Linha = 1 To UpperBound(ivs_Destino)
	If ivs_Destino[lvl_Linha] = ps_char Then	Return lvl_Linha
Next

Return -1
end function

private function string of_encripta_char (string ps_char, long pl_posicao);Long lvl_Posicao
Long lvl_Key

//Recupera a posi$$HEX2$$e700e300$$ENDHEX$$o do caracter no mapa de caracteres de origem
lvl_Posicao = This.Of_Posicao_Origem(ps_char)

//Se n$$HEX1$$e300$$ENDHEX$$o existe no mapa de caracteres, o retorno ser$$HEX1$$e100$$ENDHEX$$ -1, e o pr$$HEX1$$f300$$ENDHEX$$prio caracter ser$$HEX1$$e100$$ENDHEX$$ retornado
If lvl_Posicao = -1 Then Return ps_Char

//Verifica caracteres par ou impar, se impar adiciona posi$$HEX2$$e700e300$$ENDHEX$$o do caracter na palavra se par diminui
If Mod(pl_posicao,2) = 1 Then
	lvl_Posicao += pl_posicao
Else
	lvl_Posicao -= pl_posicao
End If

For lvl_Key = 1 To Len(Chave)
	lvl_Posicao += This.of_posicao_origem(Mid(Chave,lvl_Key,1))
Next

//Retorna o caracter da posi$$HEX2$$e700e300$$ENDHEX$$o calculada de destino
Return This.Of_Caracter_Destino(lvl_Posicao)
end function

private function string of_decripta_char (string ps_char, long pl_posicao);Long lvl_Posicao
Long lvl_Key

//Recupera a posi$$HEX2$$e700e300$$ENDHEX$$o do caracter no mapa de caracteres de destino
lvl_Posicao = This.Of_Posicao_Destino(ps_char)

//Se n$$HEX1$$e300$$ENDHEX$$o existe no mapa de caracteres, o retorno ser$$HEX1$$e100$$ENDHEX$$ -1, e o pr$$HEX1$$f300$$ENDHEX$$prio caracter ser$$HEX1$$e100$$ENDHEX$$ retornado
If lvl_Posicao = -1 Then Return ps_Char

For lvl_Key = 1 To Len(Chave)
	lvl_Posicao -= This.of_posicao_origem(Mid(Chave,lvl_Key,1))
Next

//Verifica caracteres par ou impar, se impar diminui posi$$HEX2$$e700e300$$ENDHEX$$o do caracter na palavra se par adiciona
If Mod(pl_posicao,2) = 1 Then
	lvl_Posicao -= pl_posicao
Else
	lvl_Posicao += pl_posicao
End If

//Retorna o caracter da posi$$HEX2$$e700e300$$ENDHEX$$o calculada no mapa de origem
Return This.Of_Caracter_Origem(lvl_Posicao)
end function

private function string of_caracter_destino (long pl_posicao);//Verifica se a posi$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dentro do intervalo de caracteres

//Reduz a posi$$HEX2$$e700e300$$ENDHEX$$o at$$HEX1$$e900$$ENDHEX$$ estar dentro do mapa
Do While pl_posicao > UpperBound(ivs_Destino)
	pl_posicao -= UpperBound(ivs_Destino)
Loop

//Aumenta a posi$$HEX2$$e700e300$$ENDHEX$$o at$$HEX1$$e900$$ENDHEX$$ estar dentro do mapa
Do While pl_posicao <= 0
	pl_posicao += UpperBound(ivs_Destino)
Loop

Return ivs_Destino[pl_posicao]
end function

private function string of_caracter_origem (long pl_posicao);//Verifica se a posi$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dentro do intervalo de caracteres

//Reduz a posi$$HEX2$$e700e300$$ENDHEX$$o at$$HEX1$$e900$$ENDHEX$$ estar dentro do mapa
Do While pl_posicao > UpperBound(ivs_Destino)
	pl_posicao -= UpperBound(ivs_Destino)
Loop

//Aumenta a posi$$HEX2$$e700e300$$ENDHEX$$o at$$HEX1$$e900$$ENDHEX$$ estar dentro do mapa
Do While pl_posicao <= 0
	pl_posicao += UpperBound(ivs_Destino)
Loop

Return ivs_Origem[pl_posicao]
end function

public function string of_encripta (string ps_texto);//************************ N$$HEX1$$c300$$ENDHEX$$O ALTERAR  ***********************//
//  Utilizado para criptografar as senhas de usu$$HEX1$$e100$$ENDHEX$$rios, clientes e conveniados           //
//  Em caso de altera$$HEX2$$e700e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio alterar na intranet, NFE e site conv$$HEX1$$ea00$$ENDHEX$$nios   //
//***********************************************************//
Long lvl_Char
String lvs_Encript = ''

//Encripta e inverte a ordem
For lvl_Char = Len(ps_texto) To 1 step -1
	lvs_Encript += This.of_encripta_char(Mid(ps_texto,lvl_Char,1),lvl_Char)
Next

Return lvs_Encript
end function

public function boolean of_set_mapas (string ps_origem[], string ps_destino[]);Boolean lvb_Retorno

lvb_Retorno = UpperBound(ps_origem)=UpperBound(ps_destino)

If lvb_Retorno Then
	ivs_Origem	= ps_origem
	ivs_Destino	= ps_destino
End If


Return lvb_Retorno
end function

private function string of_retorna_chave (string ps_chave);Long lvl_Char
Long lvl_Calc = 1
Long lvl_Aux

For lvl_Char = 1 To Len(ps_chave)
	lvl_Aux = This.Of_Posicao_Origem(Mid(ps_chave,lvl_Char,1))
	
	If lvl_Aux > 0 Then lvl_Calc *= lvl_Aux
Next

Return String(lvl_Calc)
end function

public function string of_encripta (string ps_senha, string ps_chave, boolean pb_add_chave);Long lvl_Char
Long lvl_Pass

String lvs_Encript = ''
String lvs_Aux 	= ''
String lvs_Senha

Chave = ps_chave

If pb_add_chave Then
	lvs_Senha = This.of_Embaralha_Texto(ps_Senha)
Else
	lvs_Senha = ps_Senha
End If

//Encripta e inverte a ordem
For lvl_Char = Len(lvs_Senha) To 1 step -1
	lvs_Encript += This.of_encripta_char( Mid(lvs_Senha,lvl_Char,1) , lvl_Char)
Next

For lvl_Pass = 1 To This.Of_Retorna_Passagens()
	lvs_Aux = ''
	For lvl_Char = 1 To Len(lvs_Encript) 
		lvs_Aux += This.of_encripta_char( Mid(lvs_Encript,lvl_Char,1) , lvl_Char)
	Next
	lvs_Encript = Mid(lvs_Aux,1,1) + Mid(lvs_Aux,3,Len(lvs_Aux)-3)+ Mid(lvs_Aux,2,1) + Mid(lvs_Aux,Len(lvs_Aux),1)
Next

Return lvs_Encript

end function

private function string of_desembaralha_texto (string ps_texto);Long lvl_Intervalo
Long lvl_Char
Long lvl_Aux

String lvs_Retorno = ''
String lvs_ChaveRetorno
String lvs_Chave = ''
String lvs_Aux = ''

If Len(Chave) = 0 Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Chave inv$$HEX1$$e100$$ENDHEX$$lida para decriptografia.~rContate a infom$$HEX1$$e100$$ENDHEX$$tica!',Exclamation!)
	Return ''
Else
	lvs_Chave = This.of_retorna_chave(Chave)
End If

lvl_Intervalo = Truncate((Len(ps_texto) - Len(lvs_Chave)) / Len(lvs_Chave),0)
If lvl_Intervalo = 0 Then lvl_Intervalo = 1

//Inverte ordem dos caracteres
For lvl_Char = Len(ps_texto) To 1 step -1
	lvs_Aux += Mid(ps_texto,lvl_Char,1)
Next

//Desembaralha
For lvl_Char = 1 To Len(lvs_Aux)
	If Mod(lvl_Char,lvl_Intervalo)=0 Then 	
		lvl_Aux ++
		If lvl_Aux <= Len(lvs_Chave) Then 
			lvs_ChaveRetorno += Mid(lvs_Aux,lvl_Char,1)
			lvl_Char ++
		End If
	End If
	
	If Len(lvs_Retorno) < (Len(lvs_Aux) - Len(lvs_chave)) Then 
		lvs_Retorno += Mid(lvs_Aux,lvl_Char,1)
	Else
		lvs_ChaveRetorno += Mid(lvs_Aux,lvl_Char,1)
	End If
Next

If lvs_ChaveRetorno <> lvs_Chave Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Chave inv$$HEX1$$e100$$ENDHEX$$lida ou texto corrompido!',Exclamation!)
	lvs_Retorno = ''
End If

Return lvs_Retorno
end function

private function string of_embaralha_texto (string ps_texto);Long lvl_Intervalo
Long lvl_Char
Long lvl_Aux = 0

String lvs_Retorno = ''
String lvs_Chave

If Len(Chave) <> 0 Then 
	lvs_Chave = This.of_retorna_chave(Chave)
	lvl_Intervalo = Truncate(Len(ps_texto) / Len(lvs_Chave),0)
	If lvl_Intervalo = 0 Then lvl_Intervalo = 1
	
	For lvl_Char = 1 To Len(ps_texto)
		If Mod(lvl_Char + lvl_Aux,lvl_Intervalo)=0 Then 
			lvl_Aux ++
			If lvl_Aux <= Len(lvs_Chave) Then lvs_Retorno += Mid(lvs_Chave,lvl_Aux,1)
		End If
		lvs_Retorno += Mid(ps_texto,lvl_Char,1)
	Next
	
	If lvl_Aux <= Len(lvs_Chave) Then lvs_Retorno += Mid(lvs_Chave,lvl_Aux + 1)
Else
	//MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar uma chave para criptografar os dados.~r~nContate a inform$$HEX1$$e100$$ENDHEX$$tica!',Exclamation!)
	lvs_Retorno = ps_texto
End If

Return lvs_Retorno
end function

public function string of_decripta (string ps_senha, string ps_chave, boolean pb_add_chave);Long lvl_Char
Long lvl_Pass

String lvs_Aux = ''
String lvs_Senha = ''
String lvs_Decript

If Trim(ps_chave)<>'' Then
	Chave = ps_chave
	
	lvs_Decript = ps_senha
	For lvl_Pass = 1 To This.Of_Retorna_Passagens()
		
		lvs_Decript = Mid(lvs_Decript,1,1) + Mid(lvs_Decript,Len(lvs_Decript) - 1,1) + Mid(lvs_Decript,2,Len(lvs_Decript)-3) + Mid(lvs_Decript,Len(lvs_Decript),1)
		For lvl_Char = 1 To Len(lvs_Decript) 
			lvs_Aux += This.of_decripta_char( Mid(lvs_Decript,lvl_Char,1) , lvl_Char)
		Next
		lvs_Decript = lvs_Aux
		lvs_Aux= ''
	Next
	
	//Decripta cada caracter
	For lvl_Char = 1  To Len(lvs_Decript)
		lvs_Aux += This.of_decripta_char(Mid(lvs_Decript,lvl_Char,1),Len(lvs_Decript) - lvl_Char + 1)
	Next
	
	If pb_add_chave Then
		lvs_Senha = This.of_Desembaralha_Texto(lvs_Aux)
	Else
		For lvl_Char = Len(ps_senha)  To 1 step -1
			lvs_Senha += Mid(lvs_Aux,lvl_Char,1)
		Next
	End If
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a chave para desencripta$$HEX2$$e700e300$$ENDHEX$$o!',Exclamation!)
End If

Return lvs_Senha
end function

public function integer of_retorna_passagens ();If Len(Chave) > 32 Then
	Return 14
ElseIf Len(Chave) > 24 Then
	Return 12
Else
	Return 8
End If
end function

on dc_uo_encript.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_encript.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

