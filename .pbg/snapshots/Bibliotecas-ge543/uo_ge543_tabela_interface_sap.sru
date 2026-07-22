HA$PBExportHeader$uo_ge543_tabela_interface_sap.sru
forward
global type uo_ge543_tabela_interface_sap from nonvisualobject
end type
end forward

global type uo_ge543_tabela_interface_sap from nonvisualobject
end type
global uo_ge543_tabela_interface_sap uo_ge543_tabela_interface_sap

type variables
Boolean ib_localizado

Long		il_cd_tabela
String 	is_de_tabela
String 	is_id_situacao
String 	is_parametro
String	is_tipo
string 	is_cd_sistema	= ''
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_tabela (string ps_cd_tabela)
public subroutine of_localiza_tabela_interface_sap (string ps_parametro)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String ls_tabela


This.is_Parametro = ps_Parametro

OpenWithParm(w_ge543_selecao_tabela_interface_sap, This)

ls_tabela = Message.StringParm

If Not IsNull(ls_tabela) Then
	of_localiza_tabela(ls_tabela)
Else
	ib_localizado = False
End If
end subroutine

public subroutine of_inicializa ();ib_localizado = False

SetNull(il_cd_tabela)
SetNull(is_de_tabela)
SetNull(is_id_situacao)
SetNull(is_parametro)
end subroutine

public subroutine of_localiza_tabela (string ps_cd_tabela);il_cd_tabela	= Long(ps_cd_tabela)

select t.de_tabela
  into :is_de_tabela
  from tabela_interface_sap t
 where cd_tabela = :il_cd_tabela and
		 id_integra_legado = 'S' and
		 coalesce(id_tabela_pai, 'N') = 'S' and
       id_subida_descida = :is_tipo and
		 coalesce(cd_sistema, '') = coalesce(:is_cd_sistema, cd_sistema, '')
using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ib_localizado = True

	Case 100
		ib_localizado = False
		
	Case -1
		Sqlca.Of_MsgDbError("Erro ao localizar tabela da interface.")
		
		ib_localizado = False
End Choose
end subroutine

public subroutine of_localiza_tabela_interface_sap (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
		If IsNumber(ps_Parametro) Then
			
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
			of_Localiza_tabela(ps_Parametro)
		
			If Not ib_localizado Then
				
				// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
				// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
				of_Localiza_Generica("")
			
			End If
	
	Else
	
		// Para Localiza$$HEX2$$e700e300$$ENDHEX$$o de Estagi$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o remunerado, matr$$HEX1$$ed00$$ENDHEX$$cula composta por 'E' + Sequencial num$$HEX1$$e900$$ENDHEX$$rico iniciando em '00001' at$$HEX1$$e900$$ENDHEX$$ '99999'
		If LeftA( ps_Parametro, 1 ) = 'E' And IsNumber( MidA( ps_Parametro, 2 ) ) Then
			of_Localiza_tabela( ps_Parametro )
			
			If Not ib_Localizado Then
				
				// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
				// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
				of_Localiza_Generica("")
			
			End If
		Else
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome ta tabela
			of_Localiza_Generica(ps_Parametro)
		End If

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

on uo_ge543_tabela_interface_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge543_tabela_interface_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

