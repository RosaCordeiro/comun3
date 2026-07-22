HA$PBExportHeader$uo_filial.sru
forward
global type uo_filial from nonvisualobject
end type
end forward

global type uo_filial from nonvisualobject
end type
global uo_filial uo_filial

type variables
Boolean Localizada = False

Long cd_filial,&
         cd_filial_sede_drogaexpress,&
         nr_prioridade_faturamento,&
         ivl_Filial_parametro,&
         ivl_filial_matriz, &
         cd_cidade, &
		cd_Filial_FCerta, &
		cd_Filial_Entrega_FCerta, &
		nr_rota_entrega
		

String nm_fantasia, &
          nm_razao_social, &
          cd_unidade_federacao, &
          nr_cgc , &
          de_endereco, &
          nr_inscricao_estadual, &
          de_bairro, &
          nm_cidade, &
          nr_cep, &
          nr_endereco, &
          nr_ddd_telefone, &
          nr_telefone, &
          id_abre_domingo, &
          id_situacao, &
          id_liberada_nfe,&
		 id_rede_filial, &
		 id_possui_farmacia_popular,&
		 id_sistema_novo
		 
		

string ivs_centralizadora = "T", &
         ivs_parametro_selecao

//Vari$$HEX1$$e100$$ENDHEX$$vel utilizada para localizar nas FILIAIS somente filiais ATIVAS. 	 
Boolean ib_localiza_somente_ativas = False
//Utilizada para filtrar somente filiais de determinada situa$$HEX2$$e700e300$$ENDHEX$$o
String ivs_Filtro_Situacao
//Utilizada para filtrar somente filiais de determinada UF
String ivs_Filtro_UF
end variables

forward prototypes
public function decimal of_desconto_medio (date pdt_inicio, date pdt_termino)
public subroutine of_inicializa ()
public subroutine of_filial_fcerta ()
public function string of_liberada_nfe (long pl_filial)
public function boolean of_localiza_codigo (long pl_filial)
public function boolean of_localiza_codigo_ativa (long pl_filial)
public function boolean of_localiza_filial (string ps_parametro, string ps_situacao, string ps_uf)
public function boolean of_localiza_codigo (long pl_filial, string ps_situacao, string ps_uf)
public function boolean of_localiza_codigo (long pl_filial, string ps_situacao)
public function boolean of_localiza_filial_ativa (string ps_parametro)
public function boolean of_localiza_filial (string ps_parametro)
public function boolean of_localiza_filial (string ps_parametro, string ps_situacao)
public function boolean of_localiza_generica (string ps_parametro, string ps_situacao, string ps_uf)
public function boolean of_localiza_generica_ativa (string ps_parametro)
end prototypes

public function decimal of_desconto_medio (date pdt_inicio, date pdt_termino);Decimal lvdc_Venda_Bruta, &
        lvdc_Venda_Liquida, &
		  lvdc_Devolucao_Bruta, &
		  lvdc_Devolucao_Liquida, &
		  lvdc_Venda, &
		  lvdc_Devolucao, &
		  lvdc_Desconto = 0

Select sum(vl_venda_bruta),
       sum(vl_venda_avista + vl_venda_crediario + vl_venda_conta_corrente + vl_venda_convenio),
		 sum(vl_devolucao_venda),
		 sum(vl_devolucao_venda_bruta)
Into :lvdc_Venda_Bruta,
     :lvdc_Venda_Liquida,
	  :lvdc_Devolucao_Bruta,
	  :lvdc_Devolucao_Liquida
From resumo_movimento_estoque
Where dh_resumo between :pdt_Inicio and :pdt_Termino
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvdc_Venda_Bruta   = lvdc_Venda_Bruta   - lvdc_Devolucao_Bruta
		lvdc_Venda_Liquida = lvdc_Venda_Liquida - lvdc_Devolucao_Liquida
		
		If lvdc_Venda_Bruta <> 0 Then
			lvdc_Desconto = Round(((lvdc_Venda_Bruta - lvdc_Venda_Liquida) / lvdc_Venda_Bruta) * 100, 2)
		End If
	Case 100
	Case -1
		SqlCa.of_MsgdbError("C$$HEX1$$e100$$ENDHEX$$lculo Desconto M$$HEX1$$e900$$ENDHEX$$dio")
End Choose

Return lvdc_Desconto
end function

public subroutine of_inicializa ();SetNull( Cd_Filial)
Nm_Fantasia     = ""
Nm_Razao_Social = ""
id_possui_farmacia_popular = "N"
Localizada = False
SetNull( This.Cd_Filial_FCerta )
SetNull( This.cd_Filial_Entrega_FCerta )
ib_localiza_somente_ativas = False

SetNull( cd_filial_sede_drogaexpress )
SetNull( nr_prioridade_faturamento )
SetNull( cd_cidade )
SetNull( cd_unidade_federacao)
SetNull( nr_cgc  )
SetNull( de_endereco )
SetNull( nr_inscricao_estadual )
SetNull( de_bairro )
SetNull( nm_cidade )
SetNull( nr_cep )
SetNull( nr_endereco )
SetNull( nr_ddd_telefone )
SetNull( nr_telefone )
SetNull( id_abre_domingo )
SetNull( id_situacao )
SetNull(id_rede_filial)
SetNull(nr_rota_entrega)
SetNull(id_sistema_novo)
SetNull(ivs_Filtro_UF)
end subroutine

public subroutine of_filial_fcerta ();If This.Localizada Then
	Choose Case This.Cd_Filial
		Case 688
			This.Cd_Filial_FCerta				= 1
			This.cd_Filial_Entrega_FCerta	= 5
			
		Case 711
			This.Cd_Filial_FCerta				= 100
			This.cd_Filial_Entrega_FCerta	= 100
			
		Case 723
			This.Cd_Filial_FCerta				= 101
			This.cd_Filial_Entrega_FCerta	= 101
			
		Case 768
			This.Cd_Filial_FCerta				= 43
			This.cd_Filial_Entrega_FCerta	= 13
			
		Case 769
			This.Cd_Filial_FCerta				= 44
			This.cd_Filial_Entrega_FCerta	= 44
			
		Case 786
			This.Cd_Filial_FCerta				= 50
			This.cd_Filial_Entrega_FCerta	= 50
			
		Case 84
			This.Cd_Filial_FCerta				= 84
			This.cd_Filial_Entrega_FCerta	= 84			

		Case 663
			This.Cd_Filial_FCerta				= 663
			This.cd_Filial_Entrega_FCerta	= 663				
			
		Case 203
			This.Cd_Filial_FCerta				= 203
			This.cd_Filial_Entrega_FCerta	= 5				
			
		Case Else
			SetNull( This.Cd_Filial_FCerta )
			SetNull( This.cd_Filial_Entrega_FCerta )
			
	End Choose
End If

end subroutine

public function string of_liberada_nfe (long pl_filial);String lvs_Liberado_NFe = "S"

If Upper(SQLCa.ivs_Database) = "SYBASE" Then
	select coalesce(pnfe.vl_parametro,'N')
	Into :lvs_Liberado_NFe
	From parametro_loja pnfe
	Where cd_filial = :pl_filial
		And pnfe.cd_parametro = 'ID_NFE_LIBERADA'
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.of_msgdberror("Localiza$$HEX2$$e700e300$$ENDHEX$$o par$$HEX1$$e200$$ENDHEX$$metro NFE.")
		Return lvs_Liberado_NFe
	ElseIf SQLCa.SQLCode = 100 Then
		lvs_Liberado_NFe = "N"
	End If	
Else
	select Case when substr(coalesce(f.nr_inscricao_estadual,'99999999'),3,5)<>'99999' Then 'S' else 'N' end
	Into :lvs_Liberado_NFe
	From filial f
	Inner join parametro_odbc p
		on p.cd_filial = f.cd_filial
	Where f.cd_filial = :pl_filial
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.of_msgdberror("Localiza$$HEX2$$e700e300$$ENDHEX$$o IE Filial.")
		Return lvs_Liberado_NFe
	ElseIf SQLCa.SQLCode = 100 Then
		lvs_Liberado_NFe = "N"
	End If	
End If

	
Return lvs_Liberado_NFe
end function

public function boolean of_localiza_codigo (long pl_filial);String lvs_Null

SetNull(lvs_Null)

Return This.Of_Localiza_Codigo( pl_filial, lvs_Null)
end function

public function boolean of_localiza_codigo_ativa (long pl_filial);String lvs_UF

SetNull(lvs_UF)

Return This.Of_Localiza_codigo(pl_filial, "A", lvs_UF)
end function

public function boolean of_localiza_filial (string ps_parametro, string ps_situacao, string ps_uf);Integer lvi_Tamanho

This.ivs_Parametro_Selecao	= ps_Parametro
This.ivs_Filtro_Situacao			= ps_situacao
This.ivs_Filtro_UF					= ps_uf
ib_localiza_somente_ativas		= (ps_situacao = "A")

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da filial
		This.of_Localiza_Codigo(Long(ps_Parametro), ps_situacao, ps_uf)

		If Not This.Localizada Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			This.of_Localiza_Generica(ps_Parametro, ps_situacao, ps_uf)
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		This.of_Localiza_Generica(ps_Parametro, ps_situacao, ps_uf)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	This.of_Localiza_Generica("", ps_situacao, ps_uf)
End If

Return This.Localizada
end function

public function boolean of_localiza_codigo (long pl_filial, string ps_situacao, string ps_uf);String lvs_Regional
String lvs_Situacao



If ps_situacao = "" Then SetNull(ps_situacao)
If ps_uf = "" Then SetNull(ps_uf)
ib_localiza_somente_ativas		= (ps_situacao = "A")

SELECT	f.cd_filial,
			f.nm_fantasia,
			f.nm_razao_social,
			c.cd_unidade_federacao,
			f.nr_cgc , 
			f.de_endereco, 
			f.nr_endereco, 
			f.nr_inscricao_estadual, 
			f.de_bairro, 
			c.nm_cidade, 
			f.nr_cep, 
			f.nr_ddd_telefone, 
			f.nr_telefone,
			f.id_regional,
			f.id_abre_domingo,
			f.cd_filial_sede_drogaexpress,
			f.id_situacao,
			f.cd_cidade,
			f.id_rede_filial,
			f.nr_rota_entrega,
			coalesce(f.id_sistema_novo, 'N') 
INTO	:cd_filial,
		:nm_fantasia,
		:nm_razao_social,
		:cd_unidade_federacao,
		:nr_cgc, 
		:de_endereco, 
		:nr_endereco,
		:nr_inscricao_estadual, 
		:de_bairro, 
		:nm_cidade, 
		:nr_cep, 
		:nr_ddd_telefone, 
		:nr_telefone,
		:lvs_Regional,
		:id_abre_domingo,
		:cd_filial_sede_drogaexpress,
		:id_situacao,
		:cd_cidade,
		:id_rede_filial,
		:nr_rota_entrega,
		:id_sistema_novo
FROM filial f
INNER JOIN cidade c
	ON c.cd_cidade = f.cd_cidade
WHERE f.cd_filial = :pl_filial
	AND f.id_situacao = coalesce(:ps_situacao, f.id_situacao)
	and (c.cd_unidade_federacao = coalesce(:ps_uf,c.cd_unidade_federacao) );
  
Choose Case SqlCa.SqlCode 
	Case -1
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial.")
		Localizada = False
	Case 100
		Localizada = False
	Case Else
		If This.ivs_Centralizadora = "S" Then
			If lvs_Regional = "N" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial " + This.Nm_Fantasia + " (" + String(This.Cd_Filial) + ")" + &
											 " n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ centralizadora.", Information!)
	
				This.Of_Inicializa( )
			Else
				//Busca se a filial possui farm$$HEX1$$e100$$ENDHEX$$cia popular
				If ivl_filial_matriz = ivl_Filial_parametro Then
					Select coalesce(plfp.vl_parametro, 'N') as id_possui_farmacia_popular
					Into :id_possui_farmacia_popular
					From parametro_loja plfp
					Where plfp.cd_filial = :pl_filial
						AND plfp.cd_parametro = 'ID_POSSUI_VIDALINK'
					Using SQLCa;
				Else
					Select coalesce(plfp.vl_parametro, 'N') as id_possui_farmacia_popular
					Into :id_possui_farmacia_popular
					From parametro_loja plfp
					Where plfp.cd_parametro = 'ID_POSSUI_VIDALINK'
					Using SQLCa;
				End if
				
				If SQLCa.SQLCode = -1 Then
					SQLCa.Of_Msgdberror( "Busca parametro farm$$HEX1$$e100$$ENDHEX$$cia popular.")
					id_possui_farmacia_popular = "N"
				End If
				
				Localizada = True					
			End If
		Else	
			Localizada = True		
		End If
		
		If This.Localizada Then
			This.of_Filial_Fcerta( )
		End If

End Choose

If Localizada Then
	id_liberada_nfe = This.Of_liberada_nfe( This.Cd_Filial)
Else
	id_liberada_nfe = "N"
End If

Return Localizada
end function

public function boolean of_localiza_codigo (long pl_filial, string ps_situacao);String lvs_Null

SetNull(lvs_Null)

Return This.Of_Localiza_Codigo( pl_filial, ps_situacao, lvs_Null)
end function

public function boolean of_localiza_filial_ativa (string ps_parametro);String lvs_Null
SetNull(lvs_Null)

Return This.Of_Localiza_filial(ps_parametro, "A", lvs_Null)
end function

public function boolean of_localiza_filial (string ps_parametro);String lvs_Null

SetNull( lvs_Null )

Return This.Of_Localiza_Filial( ps_parametro, lvs_Null)
end function

public function boolean of_localiza_filial (string ps_parametro, string ps_situacao);String lvs_Null

SetNull( lvs_Null )

Return This.Of_Localiza_Filial( ps_parametro, ps_situacao, lvs_Null)
end function

public function boolean of_localiza_generica (string ps_parametro, string ps_situacao, string ps_uf);STRING lvs_Filial

ib_localiza_somente_ativas		= (ps_situacao = "A")
This.ivs_Parametro_Selecao	= ps_Parametro
This.ivs_Filtro_Situacao			= ps_situacao
This.ivs_Filtro_UF					= ps_uf

If ivl_Filial_Parametro <> ivl_Filial_Matriz Then
	OpenWithParm(w_ge009_Selecao_Filial, This)
Else
	OpenWithParm(w_ge009_Selecao_Filial_Matriz, This)
End If

lvs_Filial = Message.StringParm

If Not IsNull(lvs_Filial) Then
	This.of_Localiza_Codigo(Long(lvs_Filial))
Else
	This.Localizada = False
End If

Return This.Localizada
end function

public function boolean of_localiza_generica_ativa (string ps_parametro);String lvs_Null

SetNull(lvs_Null)

Return This.Of_localiza_generica( ps_parametro, "A", lvs_Null)
end function

on uo_filial.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_filial.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Select cd_filial, 
       cd_filial_matriz
Into :ivl_Filial_Parametro,
     :ivl_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial dos par$$HEX1$$e200$$ENDHEX$$metros n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		SetNull(This.ivl_Filial_Parametro)		
		SetNull(This.ivl_Filial_Matriz)				
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial dos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		SetNull(This.ivl_Filial_Parametro)
		SetNull(This.ivl_Filial_Matriz)				
End Choose

SetNull(This.Cd_Filial)

This.of_Inicializa()
end event

