HA$PBExportHeader$uo_parametro_loja.sru
forward
global type uo_parametro_loja from nonvisualobject
end type
end forward

global type uo_parametro_loja from nonvisualobject
end type
global uo_parametro_loja uo_parametro_loja

type variables
String ivs_UF_Filial, &
          de_especie_cf, &
          de_serie_cf, &
          De_Especie_NF, &
          De_Serie_NF, &
          Cd_Bloq_Conv_Nao_Rec, &
          Cd_Bloq_Conv_cad_Filial, &
          nm_cidade_filial, &
          nm_filial_matriz, &
          de_mensagem_cupom, &
          nm_fantasia_filial, &
          nr_cgc,&
          nm_razao_social,&
          nr_inscricao_estadual,&
          de_endereco, &
		 id_rede_filial, &
		 cd_cidade_ibge, &
		 de_bairro, &
		 cd_cep_filial, &
		 id_nfce_ativa, &
		 de_serie_NFCE, &
		 de_especie_NFCE, &
		 nr_csc_token, &
		 nr_token_NFCE, &
		 de_fuso_horario_NFCE, &
		 id_sat_ativa, &
		 de_serie_SAT, &
		 de_especie_SAT, &
		 cd_ativacao_SAT, &
		 nr_ddd, &
		 nr_telefone, &
		 de_complemento_endereco, &
		 id_desconto_plano_saude

Public ProtectedWrite long cd_filial
Public ProtectedWrite long cd_filial_matriz
Public ProtectedWrite DateTime Dh_Movimentacao

Long cd_Cidade, &
	   nr_endereco
end variables

forward prototypes
public subroutine of_carrega_parametros ()
public function long of_proxima_nf ()
public function long of_proxima_cf ()
public function boolean of_atualiza_dh_movimentacao (datetime a_data_hora)
public function long of_filial ()
public function long of_filial_matriz ()
public function datetime of_dh_movimentacao ()
public function string of_nome_filial_parametro ()
public subroutine of_carrega_parametros_nfce ()
public subroutine of_carrega_parametros_sat ()
end prototypes

public subroutine of_carrega_parametros ();Select p.cd_filial,
		p.cd_filial_matriz,
		p.de_especie_nf,
		p.de_serie_nf,
		p.dh_movimentacao,
		p.cd_bloq_conv_nao_rec,
		p.cd_bloq_conv_cad_filial,
		c.cd_unidade_federacao,
		f.cd_cidade,
		c.nm_cidade ,
		p.de_mensagem_cupom,
		p.de_especie_cf,
		p.de_serie_cf, 
		f.nm_fantasia,
		f.nr_cgc,
		f.nm_razao_social,
		f.nr_inscricao_estadual,
		f.de_endereco,
		f.id_rede_filial,
		f.nr_endereco,
		c.cd_cidade_ibge,
		f.de_bairro,
		f.nr_cep,
		f.nr_ddd_telefone,
		f.nr_telefone,
		f.de_complemento_endereco
  Into :Cd_Filial,
		:Cd_Filial_Matriz,
		:De_Especie_NF,
		:De_Serie_NF,
		:Dh_Movimentacao,
		:Cd_Bloq_Conv_Nao_Rec,
		:Cd_Bloq_Conv_cad_Filial,	  
		:ivs_UF_Filial,
		:cd_cidade,
		:nm_cidade_filial,
		:de_mensagem_cupom,
		:de_especie_cf,
		:de_serie_cf,
		:nm_fantasia_filial,
		:nr_cgc,
		:nm_razao_social,
		:nr_inscricao_estadual,
		:de_endereco,
		:id_rede_filial,
		:nr_endereco,
		:cd_cidade_ibge,
		:de_bairro,
		:cd_cep_filial,
		:nr_ddd,
		:nr_telefone,
		:de_complemento_endereco
From parametro		p,
		filial				f,
		cidade			c
Where p.cd_filial			= f.cd_filial
	and f.cd_cidade		= c.cd_cidade
	and p.id_parametro	= '1';

Choose Case SqlCa.SqlCode
	Case 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos par$$HEX1$$e200$$ENDHEX$$metros do sistema." + Sqlca.SqlErrText , StopSign!)		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metros do sistema n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)		
End Choose
end subroutine

public function long of_proxima_nf ();Long	lvl_Ultimo, &
		lvl_Proximo

Select nr_nf
   Into :lvl_Ultimo
 From parametro
Where id_parametro = '1'
 Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvl_Proximo = lvl_Ultimo + 1	
		
		Update parametro
			Set nr_nf = :lvl_Proximo
		Where id_parametro	= '1'
			and nr_nf			= :lvl_Ultimo
		  Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError( "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero sequencial da nota fiscal." )
			Return 0
		Else
			If SqlCa.SqlnRows = 0 Then
				Return of_Proxima_NF()
			Else
				Return lvl_Proximo
			End If
		End If
		
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign! )		
		Return 0
		
	Case -1
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign! )
		Return 0
End Choose
end function

public function long of_proxima_cf ();Long lvl_Ultimo

Update parametro
	 Set nr_cf = nr_cf + 1
 Where id_parametro = '1'
	Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack( )
	SqlCa.of_MsgDbError( "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero sequencial do cupom fiscal. ~ruo_parametro_loja.of_proxima_cf( )" )
	Return 0
Else
	If SqlCa.SqlnRows = 0 Then
		Return of_Proxima_cf( )				
	End If
End If

 Select nr_cf Into :lvl_Ultimo
  From parametro
Where id_parametro = '1'
  Using SqlCa;
  
Choose Case SqlCa.SqlCode
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado. ~ruo_parametro_loja.of_proxima_cf( )", StopSign!, Ok! )		
		Return 0
		
	Case -1
		SqlCa.of_MsgDbError( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro. ~ruo_parametro_loja.of_proxima_cf( )" )
		Return 0
End Choose

Return lvl_Ultimo
end function

public function boolean of_atualiza_dh_movimentacao (datetime a_data_hora);//
UPDATE parametro  
SET 	 dh_movimentacao = :a_data_hora  
WHERE  parametro.id_parametro = '1'
USING  SQLCA;
//
IF SQLCA.SQLCode = -1 THEN
	MESSAGEBOX("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro : " + SQLCA.SQLErrtext)
	RETURN FALSE
END IF
//
This.dh_movimentacao = a_data_hora
//
RETURN TRUE
//

end function

public function long of_filial ();Select cd_filial Into :cd_filial
From parametro 
Where id_parametro = '1';
//
Choose Case Sqlca.SqlCode
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial.~rGE036.uo_parametro_loja.of_filial( )", StopSign! )
		SetNull(Cd_Filial)
	Case -1
		SqlCa.of_MsgDbError( "Erro ao verificar filial do par$$HEX1$$e200$$ENDHEX$$metro." )
		SetNull(Cd_Filial)
End Choose

Return Cd_Filial
end function

public function long of_filial_matriz ();Select cd_filial_matriz Into :cd_filial_matriz
From parametro 
Where id_parametro = '1';

Choose Case Sqlca.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial.~rGE036.uo_parametro_loja.of_filial_matriz( )", StopSign!)
		SetNull(Cd_Filial_Matriz)
	Case -1
		SqlCa.of_MsgdbError( "Erro ao verificar filial do par$$HEX1$$e200$$ENDHEX$$metro." )
		SetNull(Cd_Filial_Matriz)
End Choose

Return Cd_Filial_Matriz
end function

public function datetime of_dh_movimentacao ();DateTime lvdh_Nulo

SetNull(lvdh_Nulo)

Select dh_movimentacao Into :dh_movimentacao
From parametro 
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return dh_movimentacao		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada nos par$$HEX1$$e200$$ENDHEX$$metros.", StopSign!)
		Return lvdh_Nulo
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o nos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		Return lvdh_Nulo
End Choose
end function

public function string of_nome_filial_parametro ();String lvs_nome_codigo_filial_parametro
//
SELECT filial.nm_fantasia || ' (' || CAST(filial.cd_filial AS VARCHAR) || ')'
     INTO :lvs_nome_codigo_filial_parametro 
  FROM filial,   
       parametro  
 WHERE parametro.cd_filial = filial.cd_filial    
   and id_parametro = '1';
//
Choose Case Sqlca.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial..~rGE036.uo_parametro_loja.of_nome_filial_parametro( )", StopSign!)
		SetNull(Cd_Filial)
		Return ''
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar filial do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign!)
		SetNull(Cd_Filial)
		Return ''
End Choose
//
Return lvs_nome_codigo_filial_parametro

end function

public subroutine of_carrega_parametros_nfce ();String ls_nfce_ativo
String ls_serie
String ls_csc
String ls_token
String ls_verao
String ls_saude

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lvo_Parametro.of_Localiza_Parametro("ID_DESCONTO_PLANO_SAUDE_LIBERADO", ref ls_Saude, False)	
This.id_desconto_plano_saude = Upper(Trim(ls_saude))

If lvo_Parametro.of_Localiza_Parametro("ID_NFCE_LIBERADA", ref ls_nfce_ativo, False) Then
	This.id_nfce_ativa = Upper(Trim(ls_nfce_ativo))
End If	

If This.id_nfce_ativa = 'S' Then	
	lvo_Parametro.of_Localiza_Parametro("DE_SERIE_NFCE", ref ls_Serie, False)	
	This.de_serie_NFCE = Upper(Trim(ls_Serie))
	
	lvo_Parametro.of_Localiza_Parametro("DE_ESPECIE_NFCE", ref ls_Serie, False)	
	This.de_especie_NFCE = Upper(Trim(ls_Serie))		
	
	lvo_Parametro.of_Localiza_Parametro("NR_TOKEN_NFCE", ref ls_csc, False)	
	This.nr_csc_token = Trim(ls_csc)

	lvo_Parametro.of_Localiza_Parametro("NR_ID_TOKEN_NFCE", ref ls_token, False)	
	This.nr_token_NFCE = Upper(Trim(ls_token))
	
	lvo_Parametro.of_Localiza_Parametro("ID_HORARIO_VERAO_NFE", ref ls_verao, False)		
	If ls_verao = 'S' Then
		If This.ivs_UF_Filial = 'MS' then
			This.de_fuso_horario_NFCE = '-03:00'
		Else
			This.de_fuso_horario_NFCE = '-02:00'
	 	End If		
	Else
		If This.ivs_UF_Filial = 'MS' then
			This.de_fuso_horario_NFCE = '-04:00'
		Else
			This.de_fuso_horario_NFCE = '-03:00'
	 	End If				
	End If
Else
	This.id_nfce_ativa	= 'N'
End If

Destroy(lvo_Parametro)

end subroutine

public subroutine of_carrega_parametros_sat ();String ls_sat_ativo
String ls_serie
String ls_especie
String ls_ativacao
String ls_verao

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If lvo_Parametro.of_Localiza_Parametro("ID_SAT_LIBERADO", ref ls_sat_ativo, False) Then
	This.id_sat_ativa = Upper(Trim(ls_sat_ativo))
End If	

If This.id_sat_ativa = 'S' Then	
	lvo_Parametro.of_Localiza_Parametro("DE_SERIE_SAT", ref ls_Serie, False)	
	This.de_serie_SAT = Upper(Trim(ls_Serie))
	
	lvo_Parametro.of_Localiza_Parametro("DE_ESPECIE_SAT", ref ls_especie, False)	
	This.de_especie_SAT = Upper(Trim(ls_especie))		
	
	lvo_Parametro.of_Localiza_Parametro("CD_ATIVACAO_SAT", ref ls_ativacao, False)	
	This.cd_ativacao_sat = Trim(ls_ativacao)

	lvo_Parametro.of_Localiza_Parametro("ID_HORARIO_VERAO_NFE", ref ls_verao, False)		
	If ls_verao = 'S' Then
		If This.ivs_UF_Filial = 'MS' then
			This.de_fuso_horario_NFCE = '-03:00'
		Else
			This.de_fuso_horario_NFCE = '-02:00'
	 	End If		
	Else
		If This.ivs_UF_Filial = 'MS' then
			This.de_fuso_horario_NFCE = '-04:00'
		Else
			This.de_fuso_horario_NFCE = '-03:00'
	 	End If				
	End If
Else
	This.id_sat_ativa	= 'N'
End If

Destroy(lvo_Parametro)

end subroutine

on uo_parametro_loja.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametro_loja.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

