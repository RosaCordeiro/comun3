HA$PBExportHeader$uo_margem_resultado_preco.sru
forward
global type uo_margem_resultado_preco from nonvisualobject
end type
end forward

global type uo_margem_resultado_preco from nonvisualobject
end type
global uo_margem_resultado_preco uo_margem_resultado_preco

type variables
Long nr_margem
Long cd_tipo_margem
String id_rede_filial
String id_lei_generico
Long cd_classificacao_subcategoria
Long cd_tier_subcategoria
Decimal{4} pc_margem_resultado

Boolean Localizada
end variables

forward prototypes
public subroutine of_inicializa ()
public function Boolean of_localiza_codigo (long pl_codigo)
public function boolean of_localiza (string ps_parametro, long pl_tipo_margem, string ps_rede_filial, string ps_lei_generico, long pl_tier, long pl_classificacao)
public function boolean of_localiza_generica (long pl_tipo_margem, string ps_rede_filial, string ps_lei_generico, long pl_tier, long pl_classificacao)
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_margem_tipo_1 (string ps_rede_filial, string ps_lei_generico)
public function boolean of_localiza_margem_tipo_2 (string ps_rede_filial, long pl_classificacao)
public function boolean of_localiza_margem_tipo_3 (string ps_rede_filial, string ps_lei_generico, long pl_tier)
end prototypes

public subroutine of_inicializa ();SetNull( nr_margem )
SetNull( cd_tipo_margem )
SetNull( id_rede_filial )
SetNull( id_lei_generico )
SetNull( cd_classificacao_subcategoria )
SetNull( cd_tier_subcategoria )
SetNull( pc_margem_resultado )

Localizada = False
end subroutine

public function Boolean of_localiza_codigo (long pl_codigo);This.Of_Inicializa( )

Select nr_margem,
		 cd_tipo_margem,
		 id_rede_filial,
		 id_lei_generico,
		 cd_classificacao_subcategoria,
		 cd_tier_subcategoria,
		 pc_margem_resultado
Into  	:nr_margem,
		:cd_tipo_margem,
		:id_rede_filial,
		:id_lei_generico,
		:cd_classificacao_subcategoria,
		:cd_tier_subcategoria,
		:pc_margem_resultado
From margem_resultado_preco
Where nr_margem = :pl_codigo
Using SQLCa;

If SQLCa.SQLCode = -1 Then	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o informa$$HEX2$$e700f500$$ENDHEX$$es margem resultado de pre$$HEX1$$e700$$ENDHEX$$o." )

This.Localizada = (SQLCa.SQLCode = 0)

Return This.Localizada
end function

public function boolean of_localiza (string ps_parametro, long pl_tipo_margem, string ps_rede_filial, string ps_lei_generico, long pl_tier, long pl_classificacao);This.Of_inicializa( )

If IsNumber(ps_parametro) Then
	This.Of_Localiza_Codigo( Long(ps_parametro) )
End If

If Not This.Localizada Then
	This.Of_Localiza_Generica( pl_tipo_margem, ps_rede_filial, ps_lei_generico, pl_tier, pl_classificacao)
End If

Return This.Localizada
end function

public function boolean of_localiza_generica (long pl_tipo_margem, string ps_rede_filial, string ps_lei_generico, long pl_tier, long pl_classificacao);String lvs_Parametro

This.Of_Inicializa()	

//Anula par$$HEX1$$e200$$ENDHEX$$metros inconsistentes com o tipo de margem
If Not This.Localizada Then
	Choose Case pl_tipo_margem
		Case 1 //Por Lei Gen$$HEX1$$e900$$ENDHEX$$rico
			SetNull(pl_tier)
			SetNull(pl_classificacao)
			
			This.Of_localiza_margem_tipo_1( ps_rede_filial, ps_lei_generico)
		Case 2 //Por Classifica$$HEX2$$e700e300$$ENDHEX$$o/Papel Subcategoria
			SetNull(pl_tier)
			ps_lei_generico = ""
			
			This.Of_localiza_margem_tipo_2( ps_rede_filial, pl_classificacao)
		Case 3 //Por Tier e Lei Gen$$HEX1$$e900$$ENDHEX$$rico
			SetNull(pl_classificacao)
			
			This.Of_localiza_margem_tipo_3( ps_rede_filial, ps_lei_generico, pl_tier)
	End Choose
End If

If Not This.Localizada Then
	If IsNull(ps_rede_filial) Then ps_rede_filial = ""
	If IsNull(ps_lei_generico) Then ps_lei_generico = ""
	
	lvs_Parametro = String(pl_tipo_margem)+";"+ps_rede_filial+";"+ps_lei_generico+";"+String(pl_tier)+";"+String(pl_classificacao)
	OpenWithParm(w_ge451_selecao_margem_preco, lvs_Parametro)
	
	lvs_Parametro = Message.StringParm
	
	If IsNumber(lvs_Parametro) Then
		This.Of_Localiza_Codigo(Long(lvs_Parametro))
	End If
End If

Return This.Localizada
end function

public function boolean of_localiza (string ps_parametro);Long lvl_Null

SetNull( lvl_Null )

Return This.Of_localiza(ps_parametro, lvl_Null, "", "", lvl_Null, lvl_Null)
end function

public function boolean of_localiza_margem_tipo_1 (string ps_rede_filial, string ps_lei_generico);If IsNull(ps_rede_filial) or ps_rede_filial = "" Then Return False
If IsNull(ps_lei_generico) or ps_lei_generico = "" Then Return False

This.Of_Inicializa( )

Select nr_margem,
		 cd_tipo_margem,
		 id_rede_filial,
		 id_lei_generico,
		 cd_classificacao_subcategoria,
		 cd_tier_subcategoria,
		 pc_margem_resultado
Into  	:nr_margem,
		:cd_tipo_margem,
		:id_rede_filial,
		:id_lei_generico,
		:cd_classificacao_subcategoria,
		:cd_tier_subcategoria,
		:pc_margem_resultado
From margem_resultado_preco
Where cd_tipo_margem = 1
	And id_rede_filial = :ps_rede_filial
	And id_lei_generico = :ps_lei_generico
Using SQLCa;

If SQLCa.SQLCode = -1 Then	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o informa$$HEX2$$e700f500$$ENDHEX$$es margem resultado de pre$$HEX1$$e700$$ENDHEX$$o." )

This.Localizada = (SQLCa.SQLCode = 0)

Return This.Localizada
end function

public function boolean of_localiza_margem_tipo_2 (string ps_rede_filial, long pl_classificacao);If IsNull(ps_rede_filial) or ps_rede_filial = "" Then Return False
If IsNull(pl_classificacao) or pl_classificacao = 0 Then Return False

This.Of_Inicializa( )

Select nr_margem,
		 cd_tipo_margem,
		 id_rede_filial,
		 id_lei_generico,
		 cd_classificacao_subcategoria,
		 cd_tier_subcategoria,
		 pc_margem_resultado
Into  	:nr_margem,
		:cd_tipo_margem,
		:id_rede_filial,
		:id_lei_generico,
		:cd_classificacao_subcategoria,
		:cd_tier_subcategoria,
		:pc_margem_resultado
From margem_resultado_preco
Where cd_tipo_margem = 2
	And id_rede_filial = :ps_rede_filial
	And cd_classificacao_subcategoria = :pl_classificacao
Using SQLCa;

If SQLCa.SQLCode = -1 Then	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o informa$$HEX2$$e700f500$$ENDHEX$$es margem resultado de pre$$HEX1$$e700$$ENDHEX$$o." )

This.Localizada = (SQLCa.SQLCode = 0)

Return This.Localizada
end function

public function boolean of_localiza_margem_tipo_3 (string ps_rede_filial, string ps_lei_generico, long pl_tier);If IsNull(ps_rede_filial) or ps_rede_filial = "" Then Return False
If IsNull(ps_lei_generico) or ps_lei_generico = "" Then Return False
If IsNull(pl_tier) or pl_tier = 0 Then Return False

This.Of_Inicializa( )

Select nr_margem,
		 cd_tipo_margem,
		 id_rede_filial,
		 id_lei_generico,
		 cd_classificacao_subcategoria,
		 cd_tier_subcategoria,
		 pc_margem_resultado
Into  	:nr_margem,
		:cd_tipo_margem,
		:id_rede_filial,
		:id_lei_generico,
		:cd_classificacao_subcategoria,
		:cd_tier_subcategoria,
		:pc_margem_resultado
From margem_resultado_preco
Where cd_tipo_margem	= 3
	And id_rede_filial 		= :ps_rede_filial
	And id_lei_generico	= :ps_lei_generico
	And cd_tier_subcategoria = :pl_tier
Using SQLCa;

If SQLCa.SQLCode = -1 Then	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o informa$$HEX2$$e700f500$$ENDHEX$$es margem resultado de pre$$HEX1$$e700$$ENDHEX$$o." )

This.Localizada = (SQLCa.SQLCode = 0)

Return This.Localizada
end function

on uo_margem_resultado_preco.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_margem_resultado_preco.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

