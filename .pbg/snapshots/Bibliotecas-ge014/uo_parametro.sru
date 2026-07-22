HA$PBExportHeader$uo_parametro.sru
forward
global type uo_parametro from nonvisualobject
end type
end forward

global type uo_parametro from nonvisualobject
end type
global uo_parametro uo_parametro

type variables
Long Cd_Filial, &
         Cd_Filial_Matriz

DateTime Dh_Movimentacao

String ivs_UF_FIlial

Decimal {2} Pc_Juros_Diario

String Cd_Bloq_Conv_Nao_Rec, &
          Cd_Bloq_Conv_Cad_Filial

String nm_Fantasia_Filial , &
          nm_razao_social   , &
          nr_cgc, &
		 nr_inscricao_estadual, &
		 nm_Cidade_Filial, &
		 de_endereco

		 //Variaveis criadas para n$$HEX1$$e300$$ENDHEX$$o ocorrer erro em objetos usados
String	 id_rede_filial, &
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
		 de_complemento_endereco
		 
Long cd_Cidade, &
	   nr_endereco		 
end variables

forward prototypes
public subroutine of_carrega_parametros ()
public function boolean of_atualiza_data_movimentacao (datetime pdh_data)
public function long of_proxima_nf ()
public function long of_filial ()
public function long of_filial_matriz ()
public function datetime of_dh_movimentacao ()
public function string of_nome_filial_parametro ()
public function string of_distribuidora_estoque ()
public function boolean of_filial_matriz (ref long al_filial)
end prototypes

public subroutine of_carrega_parametros ();Select P.cd_filial,
       P.cd_filial_matriz,
       P.dh_movimentacao,
		 P.pc_juros_diario,
		 P.cd_bloq_conv_nao_rec,
		 P.cd_bloq_conv_cad_filial,		 
		 C.cd_unidade_federacao,
		 F.nm_fantasia,
		 F.nm_razao_social,
		 F.nr_cgc,
		 F.nr_inscricao_estadual,
		 F.de_endereco,
		 C.nm_cidade
Into :Cd_Filial,
     :Cd_Filial_Matriz,
     :Dh_Movimentacao,
	  :Pc_Juros_Diario,
	  :Cd_Bloq_Conv_Nao_Rec,
	  :Cd_Bloq_Conv_Cad_Filial,	  
 	  :ivs_UF_Filial,
     :nm_fantasia_filial,
	  :nm_razao_social,
	  :nr_cgc,
	  :nr_inscricao_estadual,
	  :de_endereco,
	  :nm_cidade_filial
From parametro P,
     filial F,
     cidade C
Where P.cd_filial = F.cd_filial
  and F.cd_cidade = C.cd_cidade
  and P.id_parametro = '1'
Using SqlCa;

If SqlCa.SqlCode <> 0 Then
	SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos par$$HEX1$$e200$$ENDHEX$$metros do sistema.")
End If
end subroutine

public function boolean of_atualiza_data_movimentacao (datetime pdh_data);Update parametro  
Set dh_movimentacao = :pdh_Data
Where id_parametro = '1'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign!, Ok!)
	Return False
End If

This.Dh_Movimentacao = pdh_Data

Return True
end function

public function long of_proxima_nf ();Long lvl_Ultimo, &
     lvl_Proximo

Select nr_nf Into :lvl_Ultimo
From parametro
Where id_parametro = '1';

Choose Case SqlCa.SqlCode
	Case 0
		lvl_Proximo = lvl_Ultimo + 1	
		
		Update parametro
		Set nr_nf = :lvl_Proximo
		Where id_parametro = '1'
		  and nr_nf        = :lvl_Ultimo;
		
		If SqlCa.SqlCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero sequencial da nota fiscal." + SqlCa.SqlErrText, StopSign!)
			Return 0
		Else
			If SqlCa.SqlnRows = 0 Then
				Return of_Proxima_NF()				
			Else
				Return lvl_Proximo
			End If
		End If		
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!, Ok!)		
		Return 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign!, Ok!)		
		Return 0
End Choose
end function

public function long of_filial ();Select cd_filial Into :cd_filial
From parametro 
Where id_parametro = '1';

Choose Case Sqlca.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial.", StopSign!)
		SetNull(Cd_Filial)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar filial do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign!)
		SetNull(Cd_Filial)
End Choose

Return Cd_Filial
end function

public function long of_filial_matriz ();Select cd_filial_matriz Into :cd_filial_matriz
From parametro 
Where id_parametro = '1';

Choose Case Sqlca.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial.", StopSign!)
		SetNull(Cd_Filial_Matriz)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar filial do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign!)
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
SELECT filial.nm_fantasia + ' (' + ltrim(str(filial.cd_filial)) + ')' into :lvs_nome_codigo_filial_parametro 
  FROM filial,   
       parametro  
 WHERE parametro.cd_filial = filial.cd_filial    
   and id_parametro = '1';
//
Choose Case Sqlca.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial.", StopSign!)
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

public function string of_distribuidora_estoque ();String lvs_distribuidora

Select cd_distribuidora_estoque Into :lvs_distribuidora
From parametro 
Where id_parametro = '1';

Choose Case Sqlca.SqlCode
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado do c$$HEX1$$f300$$ENDHEX$$digo da distribuidora Estoque Central.", StopSign!)
		SetNull(lvs_Distribuidora)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar c$$HEX1$$f300$$ENDHEX$$digo da distribuidora Estoque Central." + SqlCa.SqlErrText, StopSign!)
		SetNull(lvs_Distribuidora)
End Choose

Return lvs_Distribuidora
end function

public function boolean of_filial_matriz (ref long al_filial);Boolean lvb_Sucesso = False

Select cd_filial_matriz Into :al_Filial
From parametro 
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial matriz.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Filial Matriz no Par$$HEX1$$e200$$ENDHEX$$metro")
End Choose

Return lvb_Sucesso
end function

on uo_parametro.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametro.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

