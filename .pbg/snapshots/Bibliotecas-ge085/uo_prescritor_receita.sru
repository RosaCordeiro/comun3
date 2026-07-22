HA$PBExportHeader$uo_prescritor_receita.sru
forward
global type uo_prescritor_receita from nonvisualobject
end type
end forward

global type uo_prescritor_receita from nonvisualobject
end type
global uo_prescritor_receita uo_prescritor_receita

type variables
String ivs_Retorno

String ivs_parametro

String id_registro
String  nr_registro
String cd_unidade_federacao
String nm_prescritor
String de_endereco
String de_bairro
String cd_cidade
String nr_ddd_telefone
String nr_telefone
String nr_cep

Boolean Localizado
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza (string ps_id_registro, string ps_registro, string ps_uf)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String lvs_prescritor

This.ivs_Parametro = ps_Parametro

OpenWithParm(w_ge085_selecao_prescritor_receita, This)

If This.ivs_Retorno = "OK" Then
	This.of_Localiza(This.id_registro,This.nr_registro,This.cd_unidade_federacao)
Else
	This.Localizado = False
End If
end subroutine

public subroutine of_localiza (string ps_id_registro, string ps_registro, string ps_uf);Select prescritor_receita.id_registro,   
       nr_registro,   
       cd_unidade_federacao,   
       nm_prescritor,   
       de_endereco,   
       de_bairro,   
       cd_cidade,   
       nr_ddd_telefone,   
       nr_telefone,   
       nr_cep  
 Into :id_registro,   
      :nr_registro,   
      :cd_unidade_federacao,   
      :nm_prescritor,   
      :de_endereco,   
      :de_bairro,   
      :cd_cidade,   
      :nr_ddd_telefone,   
      :nr_telefone,   
      :nr_cep
 From prescritor_receita	  
Where id_registro          = :ps_id_registro
  and nr_registro          = :ps_registro
  and cd_unidade_federacao = :ps_uf
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 100
		Localizado = False
	Case -1
		SqlCa.of_MsgDbError( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do prescritor. " )
		Localizado = False
	Case 0
		Localizado = True		
End Choose
end subroutine

public subroutine of_inicializa ();ivs_Retorno			= ''
ivs_parametro		= ''
id_registro			= ''
nr_registro			= ''
cd_unidade_federacao = ''
nm_prescritor		= ''
de_endereco		= ''
de_bairro			= ''
cd_cidade			= ''
nr_ddd_telefone	= ''
nr_telefone 			= ''
nr_cep 				= ''

Localizado = False
end subroutine

on uo_prescritor_receita.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_prescritor_receita.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

