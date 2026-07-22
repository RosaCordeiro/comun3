HA$PBExportHeader$uo_parametro_loja_central.sru
forward
global type uo_parametro_loja_central from nonvisualobject
end type
end forward

global type uo_parametro_loja_central from nonvisualobject
end type
global uo_parametro_loja_central uo_parametro_loja_central

type variables
Integer cd_cidade

String ivs_Retorno

String ivs_parametro

String id_registro
String  nr_registro
String cd_unidade_federacao
String nm_prescritor
String de_endereco
String de_bairro
String nr_ddd_telefone
String nr_telefone
String nr_cep

Boolean Localizado
end variables

forward prototypes
public function boolean of_localiza (long pl_filial, string ps_codigo, ref string ps_valor)
public function boolean of_localiza_parametro_central (string as_parametro, ref date adt_data)
public function boolean of_localiza_parametro_central (string as_parametro, ref string as_valor)
public function boolean of_proximo_sequencial (string as_parametro, ref long al_proximo)
public function boolean of_localiza_parametro (string as_parametro, ref long al_valor)
public function boolean of_localiza_parametro (string as_codigo, ref string as_valor)
public function boolean of_localiza_parametro (string as_parametro, ref long al_valor, ref string ps_mensagem)
public function boolean of_localiza_parametro (string as_codigo, ref string as_valor, ref string as_mensagem)
end prototypes

public function boolean of_localiza (long pl_filial, string ps_codigo, ref string ps_valor);/* Realiza a consulta na tabela parametro_loja
	pelo servidor distribu$$HEX1$$ed00$$ENDHEX$$do
*/

Boolean lvb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao( )
lvo_Conexao.of_Define_Variaveis( True )

If lvo_Conexao.of_Executa_Rotina( "0120",{String(pl_Filial), "'" + ps_Codigo + "'"} ) Then
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno( "vl_parametro", Ref ps_Valor ) Then 
			lvb_Sucesso = True
		End If
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Par$$HEX1$$e200$$ENDHEX$$metro '" + ps_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado." )
		lvb_Sucesso = True
	End If
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro '" + ps_Codigo + "'.",StopSign! )
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro_central (string as_parametro, ref date adt_data);Boolean lvb_Sucesso = False

String lvs_Valor

// Formato do par$$HEX1$$e200$$ENDHEX$$metro: dd/mm/yyyy

If This.of_Localiza_Parametro_Central(as_Parametro, Ref lvs_Valor) Then 	
	If IsDate(lvs_Valor) Then
		adt_Data = Date(lvs_Valor)
		
		lvb_Sucesso = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro_central (string as_parametro, ref string as_valor);Boolean lvb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

If lvo_Conexao.of_Executa_Rotina("0121", {"'" + as_Parametro + "'"}) Then
	
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("vl_parametro", Ref as_Valor) Then
			lvb_Sucesso = True	
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "'.", StopSign!)
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_proximo_sequencial (string as_parametro, ref long al_proximo);Boolean lvb_Sucesso = False

Long lvl_Ultima
Long lvl_Row
	  
String	lvs_Ultima
String	lvs_Proxima

String	lvs_Tabela
String	lvs_Set
String	lvs_Where

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

If This.of_Localiza_Parametro(as_Parametro, ref lvl_Ultima) Then
	al_Proximo = lvl_Ultima + 1
	
	lvs_Ultima  = String(lvl_Ultima)
	lvs_Proxima = String(al_Proximo)
	
	lvs_Tabela	= "parametro_geral"
	
	lvs_Set		= "vl_parametro = '" + lvs_Proxima + "'"
	
	lvs_Where 	= "cd_parametro 	 = '" + as_Parametro + "'"
	lvs_Where  += " and vl_parametro = '" + lvs_Ultima + "'"
	
	If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "'.")
		lvb_Sucesso = False
	End If	
	
	If lvl_Row > 0 Then
		lvb_Sucesso = True
	Else
		lvb_Sucesso = This.of_Proximo_Sequencial(as_Parametro, ref al_Proximo)
	End If
	
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref long al_valor);Boolean lb_Sucesso = False

String ls_Mensagem

SetNull( ls_Mensagem )

lb_Sucesso = This.of_Localiza_Parametro( as_Parametro, Ref al_Valor, Ref ls_Mensagem )

If Not lb_Sucesso And Not IsNull( ls_Mensagem ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem )
End If

Return lb_Sucesso
end function

public function boolean of_localiza_parametro (string as_codigo, ref string as_valor);Boolean lb_Sucesso = False

String ls_Mensagem

SetNull( ls_Mensagem )

lb_Sucesso = This.of_Localiza_Parametro( as_Codigo, Ref as_Valor, Ref ls_Mensagem )

If Not IsNull( ls_Mensagem ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem )
End If

Return lb_Sucesso
end function

public function boolean of_localiza_parametro (string as_parametro, ref long al_valor, ref string ps_mensagem);Boolean lb_Sucesso = False

String ls_Valor

If This.of_Localiza_Parametro( as_Parametro, Ref ls_Valor, Ref ps_Mensagem ) Then 
	If IsNumber( ls_Valor ) Then
		al_Valor = Long( ls_Valor )	
		
		lb_Sucesso = True
	Else
		ps_Mensagem = "Valor '" + ls_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido."
	End If
End If

Return lb_Sucesso
end function

public function boolean of_localiza_parametro (string as_codigo, ref string as_valor, ref string as_mensagem);/* Realiza consulta na tabela parametro_geral
	pelo servidor distribu$$HEX1$$ed00$$ENDHEX$$do	
*/

Boolean lb_Sucesso = False

uo_Transacao_Remota lo_Conexao
lo_Conexao = Create uo_Transacao_Remota

lo_Conexao.of_BancoProducao()

lo_Conexao.of_Define_Variaveis(True)

lo_Conexao.of_Executa_Rotina( "0121",{"'" + as_Codigo + "'"} )

If lo_Conexao.of_Erro_Execucao( ) Or lo_Conexao.of_Erro_Conexao( ) Then
	as_Mensagem = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "'."
Else
	If lo_Conexao.of_Linhas( ) > 0 Then
		If lo_Conexao.of_Retorno( "vl_parametro", Ref as_Valor ) Then
			lb_Sucesso = True
		End If
	Else
		as_Mensagem = "Par$$HEX1$$e200$$ENDHEX$$metro '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado."
	End If
End If

Destroy(lo_Conexao)

Return lb_Sucesso
end function

on uo_parametro_loja_central.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametro_loja_central.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

