HA$PBExportHeader$uo_ge099_endereco.sru
forward
global type uo_ge099_endereco from nonvisualobject
end type
end forward

global type uo_ge099_endereco from nonvisualobject
end type
global uo_ge099_endereco uo_ge099_endereco

type variables
Boolean ivb_Libera_Digitacao			= False // Para liberar a localiza$$HEX2$$e700e300$$ENDHEX$$o da cidade
Boolean ivb_Permite_Sem_Localizar	= True // Para que o usu$$HEX1$$e100$$ENDHEX$$rio, caso n$$HEX1$$e300$$ENDHEX$$o localize o endere$$HEX1$$e700$$ENDHEX$$o, possa digitar livremente

Decimal	vl_frete

string nr_cep, &         
		tipo_endereco, &
		de_endereco, &
		de_endereco_abreviado, &
		de_bairro, &
		de_bairro_abreviado, &
		nm_cidade, &
		cd_unidade_federacao, &
		nr_chave, &
		ivs_Parametro_Selecao
			
String ivs_Cep_Generico = '89200000'

long	cd_cidade, &
		nr_ceps, &
		ivl_cidade_informada, &
		Nr_Bairro

boolean localizado
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_endereco (string ps_parametro)
public function string of_string_sem_acento (string ps_string)
public function string of_replace (string ps_string, character ps_search, character ps_replace)
public function boolean of_localiza_cep (string ps_chave)
public function boolean of_conta_cep (string ps_cep)
public function boolean of_existe_uf (string cd_uf)
public function boolean of_existe_cep (string ps_cep)
public subroutine of_cep_generico ()
public subroutine of_cep_generico (string ps_cidade_ibge)
public function string of_localiza_cep_padrao_cidade (long al_cidade)
end prototypes

public subroutine of_inicializa ();nr_cep						= ""
de_endereco				= ""
de_endereco_abreviado	= ""
de_bairro					= ""
de_bairro_abreviado		= ""
nm_cidade					= ""
cd_unidade_federacao	= ""
tipo_endereco				= ""
nr_chave						= ""

setnull(cd_Cidade)
setnull(vl_Frete)
setnull(ivl_Cidade_Informada)

localizado = false
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String ls_Cep

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge099_Selecao_Endereco, This)

ls_Cep = Message.StringParm

If Not This.Localizado Then
	of_Localiza_Cep(ls_Cep)
//Else
//	Localizado = False
End If

//Localizado = True
end subroutine

public subroutine of_localiza_endereco (string ps_parametro);Integer lvi_Tamanho 	    

lvi_Tamanho = LenA(ps_Parametro)

Localizado = False

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then
		
		// Conta os ceps retornados pelo par$$HEX1$$e200$$ENDHEX$$metro passado (CEP), problema com ceps retornando mais de um bairro.
		of_conta_cep(ps_Parametro)
		
		If nr_ceps = 1 Then
			//Localiza diretamente pelo chave do CEP
			of_Localiza_Cep(nr_chave)
	//	ElseIf nr_ceps > 1 Then
//			OpenWithParm(w_ge099_Selecao_Endereco, This)
//			This = Message.PowerObjectParm
		End If

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo CEP
//		of_Localiza_Cep(ps_Parametro)

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica(ps_Parametro)
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o endere$$HEX1$$e700$$ENDHEX$$o
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public function string of_string_sem_acento (string ps_string);String ls_Retorno

ls_Retorno = ps_String

ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$c100$$ENDHEX$$", "A" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$c000$$ENDHEX$$", "A" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$c400$$ENDHEX$$", "A" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$c300$$ENDHEX$$", "A" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$c200$$ENDHEX$$", "A" )

ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$c900$$ENDHEX$$", "E" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$c800$$ENDHEX$$", "E" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$cb00$$ENDHEX$$", "E" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$ca00$$ENDHEX$$", "E" )

ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$cd00$$ENDHEX$$", "I" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$cc00$$ENDHEX$$", "I" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$ce00$$ENDHEX$$", "I" )

ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$d300$$ENDHEX$$", "O" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$d200$$ENDHEX$$", "O" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$d400$$ENDHEX$$", "O" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$d600$$ENDHEX$$", "O" )

ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$da00$$ENDHEX$$", "U" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$d900$$ENDHEX$$", "U" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$db00$$ENDHEX$$", "U" )
ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$dc00$$ENDHEX$$", "U" )

ls_Retorno = This.of_Replace( ls_Retorno, "$$HEX1$$c700$$ENDHEX$$", "C" )

Return ls_Retorno
end function

public function string of_replace (string ps_string, character ps_search, character ps_replace);Long ll_Pos, &
	 ll_Len
	  
String ls_Retorno

ls_Retorno = ps_String
	  
ll_Len = LenA( ls_Retorno )
ll_Pos = PosA( ls_Retorno, ps_Search )

Do While ll_Pos > 0
	ls_Retorno = ReplaceA( ls_Retorno, ll_Pos, 1, ps_Replace )
	
	ll_Pos = PosA( ls_Retorno, ps_Search, ll_Pos+1 )
Loop

Return ls_Retorno
end function

public function boolean of_localiza_cep (string ps_chave);SELECT	nr_cep,
			de_endereco,
			cd_uf,
			nr_bairro,
			de_bairro,
			de_bairro_abreviado,
			nm_cidade,
			cd_cidade,
			tipo_endereco,
			de_endereco_abreviado,
			nr_chave,
			0.00
  Into :nr_cep,
		:de_endereco,
		:cd_unidade_federacao,
		:Nr_Bairro,
		:de_bairro,
		:de_bairro_abreviado,
		:nm_cidade,
		:cd_cidade,
		:tipo_endereco,
		:de_endereco_abreviado,
		:nr_chave,
		:vl_frete
  From vw_endereco 
 Where nr_chave = :ps_chave
 Using SqlCa;
 
Choose Case sqlCa.SqlCode
	Case 0
		localizado = True
		
	Case 100
		Localizado = False
		
	Case -1
		Localizado = False
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Endere$$HEX1$$e700$$ENDHEX$$o")
		
End Choose
 
Return True
end function

public function boolean of_conta_cep (string ps_cep);SELECT count(*)
  Into :nr_ceps
  From vw_endereco 
 Where nr_cep = :ps_cep
 Using SqlCa;
 
 
Choose Case sqlCa.SqlCode
	Case 0
		If nr_ceps = 1 Then
			
			SELECT nr_chave
			  INTO :nr_chave
			  FROM vw_endereco
			 WHERE nr_cep = :ps_cep
			 Using SqlCa;
			 
			Choose Case sqlCa.SqlCode
				Case 0 
					Localizado = True
					
				Case 100
					Localizado = False				
					
				Case -1
					Localizado = False
					SqlCa.of_MsgdbError("Erro ao localizar o endereco pelo CEP")
					
			End Choose
		End If 
		
	Case 100
		Localizado = False
		
	Case -1
		Localizado = False
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Endere$$HEX1$$e700$$ENDHEX$$o")
		
End Choose
 
Return True
end function

public function boolean of_existe_uf (string cd_uf);Long ll_cont_uf

SELECT count(*)
  INTO :ll_cont_uf
  FROM vw_endereco
 WHERE cd_uf = :cd_uf
 Using SqlCa;
 
Choose Case sqlCa.SqlCode
	Case 0
		If ll_cont_uf > 0 Then
			Return True
		End If
		
	Case 100
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de UF no banco local.")
		
End Choose

Return false
 

end function

public function boolean of_existe_cep (string ps_cep);Boolean lb_Sucesso = False

Long ll_Achou

If ps_Cep = ivs_Cep_Generico Then Return True

select count(*)
  Into :ll_Achou
  from vw_endereco
where nr_cep = :ps_cep
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		
	Case 0
		If Not IsNull( ll_Achou ) And ll_Achou > 0 Then
			 lb_Sucesso = True
		End If
		
	Case 100
		
End Choose

Return lb_Sucesso
end function

public subroutine of_cep_generico ();String ls_Ibge

 Select cd_cidade_ibge
    Into :ls_Ibge
  From cidade
 Where cd_cidade = ( Select cd_cidade
 							  From filial
							Where cd_filial = :gvo_Parametro.Cd_Filial )
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
End Choose

This.of_Cep_Generico( ls_Ibge )
end subroutine

public subroutine of_cep_generico (string ps_cidade_ibge);select coalesce( max(l.nr_cep), '89200000' )
   Into :ivs_Cep_Generico
  from ect_localidade l
where l.cd_cidade_ibge	= :ps_Cidade_Ibge
 Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
End Choose
end subroutine

public function string of_localiza_cep_padrao_cidade (long al_cidade);String ls_Cep_Padrao_Cidade

Select nr_cep_padrao
	Into :ls_Cep_Padrao_Cidade
From cidade
Where cd_cidade = :al_Cidade
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o cep padr$$HEX1$$e300$$ENDHEX$$o da cidade '" + String(al_Cidade) + "'. " + SqlCa.SqlErrText, StopSign!)	
End If

If ls_Cep_Padrao_Cidade = "" Then
	SetNull(ls_Cep_Padrao_Cidade)
End If

Return ls_Cep_Padrao_Cidade
end function

on uo_ge099_endereco.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge099_endereco.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_cep_generico()

SetNull( vl_Frete )
end event

