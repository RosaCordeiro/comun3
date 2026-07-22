HA$PBExportHeader$uo_natureza_operacao.sru
forward
global type uo_natureza_operacao from nonvisualobject
end type
end forward

global type uo_natureza_operacao from nonvisualobject
end type
global uo_natureza_operacao uo_natureza_operacao

type variables
Boolean Localizado

Long Cd_Natureza_Operacao

String	De_Natureza_Operacao	, &
		ivs_parametro_selecao	, &
		id_estadual					, &
		id_finalidade_nfe			, &
		id_movimenta_estoque	, &
		id_entrada_saida			, &
		id_operacao
		
String ivs_Somente_Diversas='S'
		
end variables

forward prototypes
public subroutine of_localiza_codigo (long pl_cd_natureza_operacao)
public subroutine of_localiza_codigo (long pl_cd_natureza_operacao, string ps_diversa)
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_natureza (string ps_parametro)
public function boolean of_calcula_difa ()
end prototypes

public subroutine of_localiza_codigo (long pl_cd_natureza_operacao);This.of_localiza_codigo(pl_cd_natureza_operacao, ivs_Somente_Diversas)
end subroutine

public subroutine of_localiza_codigo (long pl_cd_natureza_operacao, string ps_diversa);Long lvl_Cd_Filial_Matriz
Long lvl_Cd_Filial

String lvs_Diversa
String lvs_Diversa_Matriz

lvl_cd_filial_matriz = gvo_parametro.of_filial_matriz()
lvl_cd_filial = gvo_parametro.of_filial()

If (lvl_cd_filial_matriz = lvl_cd_filial) then
	select		cd_natureza_operacao,
				de_natureza_operacao,
				id_estadual,
				id_diversa,
				id_diversa_matriz,
				coalesce(id_finalidade_nfe,'') as id_finalidade_nfe,
				coalesce(id_movimenta_estoque,'N') as id_movimenta_estoque,
				id_entrada_saida,
				id_operacao
	  Into :cd_natureza_operacao,
			 :de_natureza_operacao,
			 :id_estadual,
			 :lvs_Diversa,
			 :lvs_Diversa_Matriz,
			 :id_finalidade_nfe,
			 :id_movimenta_estoque,
			 :id_entrada_saida,
			 :id_operacao
	from   natureza_operacao
	where  cd_natureza_operacao = :pl_cd_natureza_operacao;
Else
	select cd_natureza_operacao,
			 de_natureza_operacao,
			 id_estadual,
			 id_diversa,
			 coalesce(id_finalidade_nfe,'') as id_finalidade_nfe,
			  coalesce(id_movimenta_estoque,'N') as id_movimenta_estoque,
			 id_entrada_saida,
			 cast(null as char(1)) as id_operacao
	  Into :cd_natureza_operacao,
			 :de_natureza_operacao,
			 :id_estadual,
			 :lvs_Diversa,
			 :id_finalidade_nfe,
			 :id_movimenta_estoque,
			 :id_entrada_saida,
			 :id_operacao
	from   natureza_operacao
	where  cd_natureza_operacao = :pl_cd_natureza_operacao;
End If

If SqlCa.SqlCode = 100 Then
	Localizado = False
ElseIf SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da Natureza Opera$$HEX2$$e700e300$$ENDHEX$$o: " + &
	            SqlCa.SqlErrText + ".",StopSign!,Ok!)
	This.Of_Inicializa()
Else	
	Localizado = True
	If IsNull(id_estadual) Then id_estadual = 'N'
	
	If ((lvl_cd_filial_matriz <> lvl_cd_filial)and(lvs_Diversa = 'N')) or &
	   ((lvl_cd_filial_matriz = lvl_cd_filial)and(lvs_Diversa_matriz = 'N')) Then
		//Localiza somente diversas?
		If ps_diversa = 'S' Then 
			This.Of_Inicializa()
		End If
	End If
		
End If
end subroutine

public subroutine of_inicializa ();Localizado = False
SetNull(Cd_Natureza_Operacao)
De_Natureza_Operacao = ''
id_estadual = ''
id_finalidade_nfe = ''
id_movimenta_estoque = ''
id_entrada_saida = ''
id_operacao = ''
ivs_Somente_Diversas='S'
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_natureza_operacao

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge023_Selecao_natureza_operacao, ps_Parametro)

lvs_natureza_operacao = Message.StringParm

If IsNull(lvs_natureza_operacao) Then
	Localizado = False
Else
	of_Localiza_Codigo(Long(lvs_natureza_operacao),'N')
End If
end subroutine

public subroutine of_localiza_natureza (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome da cidade
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public function boolean of_calcula_difa ();String lvs_Tipo_Difa

Select coalesce(id_difa,'N')
Into :lvs_Tipo_Difa
From natureza_operacao
Where cd_natureza_operacao = :This.Cd_Natureza_Operacao
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_MsgDBError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o tipo DIFA." )
	lvs_Tipo_Difa = "N"
End If

Return (lvs_Tipo_Difa = "N")
end function

on uo_natureza_operacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_natureza_operacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

