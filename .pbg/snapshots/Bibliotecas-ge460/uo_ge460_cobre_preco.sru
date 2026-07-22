HA$PBExportHeader$uo_ge460_cobre_preco.sru
forward
global type uo_ge460_cobre_preco from nonvisualobject
end type
end forward

global type uo_ge460_cobre_preco from nonvisualobject
end type
global uo_ge460_cobre_preco uo_ge460_cobre_preco

type variables
Long il_Filial_Parametro, il_Filial_Matriz

Decimal idc_Sum_Cota_Mes_Filial
Decimal idc_Cota_Dia_Filial
Decimal idc_Total_Utilizado_Mes
Decimal idc_Total_Utilizado_Dia
Decimal idc_PC_Limite_Cota
Decimal idc_Vl_Limite_Cota

String is_id_dir_cota_mes	 	
String is_id_dir_cota_dia	
String is_id_dir_vl_fixo 
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_limite_utilizado_mes (ref boolean ab_bloqueia_utilizacao)
public subroutine of_cota_filial (long al_filial, date adt_mes)
public function integer of_valor_utilizado_negociacao_mes (long al_filial, date adt_periodo)
public function boolean of_verifica_limite_cadastrado ()
end prototypes

public subroutine of_inicializa ();
end subroutine

public subroutine of_limite_utilizado_mes (ref boolean ab_bloqueia_utilizacao);
Decimal ldc_Limite_Cota_mes
Decimal ldc_Limite_Cota_dia
Decimal ldc_PC_Atingido

Date ldt_Periodo

Try
	//
	ab_bloqueia_utilizacao = False
	
	ldt_Periodo = Date(gf_getserverdate())
	
	//01
	If Not of_verifica_limite_cadastrado() then		
		Return
	End if

	if is_id_dir_cota_mes	= '' then is_id_dir_cota_mes	= 'N'
	if is_id_dir_cota_dia	= '' then is_id_dir_cota_dia		= 'N' 
	if is_id_dir_vl_fixo		= '' then is_id_dir_vl_fixo			= 'N' 

	If is_id_dir_cota_mes = 'N' And is_id_dir_cota_dia = 'N' And is_id_dir_vl_fixo = 'N' Then
		//Diretrizes indicando se deve validar os par$$HEX1$$e200$$ENDHEX$$metros do COBRE PRE$$HEX1$$c700$$ENDHEX$$O, antes de liberar a venda
		Return
	End If
	

	//02
	//Cota M$$HEX1$$ea00$$ENDHEX$$s Filial e Cota Dia Filial
	of_cota_filial( gvo_Parametro.Cd_Filial, ldt_Periodo )

	//Limite da cota com base no % definido pelo pricing    			// param cobre preco 0,5%
	ldc_Limite_Cota_mes = Round(idc_Sum_Cota_Mes_Filial 	* (    idc_PC_Limite_Cota	/ 100), 2)
	ldc_Limite_Cota_dia   = Round(idc_Cota_Dia_Filial          	* (    idc_PC_Limite_Cota	/ 100), 2)
	
	
	//03
	//Total dos descontos utilizados no cobre pre$$HEX1$$e700$$ENDHEX$$o
	if This.of_valor_utilizado_negociacao_mes( gvo_Parametro.Cd_Filial, ldt_Periodo ) <> 1 then
		Return
	End if

	
	//04
	//Cota atingida
	If 	is_id_dir_cota_mes = 'S'  THEN
		If idc_Total_Utilizado_Mes > ldc_Limite_Cota_mes then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O seu limite de descontos no m$$HEX1$$ea00$$ENDHEX$$s se esgotou. ~r~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel utilizar o Cobre Pre$$HEX1$$e700$$ENDHEX$$o.", Exclamation!)
			ab_bloqueia_utilizacao = True
			Return
		End If
	End If
	
	If 	is_id_dir_cota_dia = 'S' then
		If idc_Total_Utilizado_Dia > ldc_Limite_Cota_dia then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O seu limite de descontos para hoje se esgotou. ~r~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel utilizar o Cobre Pre$$HEX1$$e700$$ENDHEX$$o.", Exclamation!)
			ab_bloqueia_utilizacao = True
			Return
		End If
	End If

	If is_id_dir_vl_fixo = 'S' then
		If idc_Total_Utilizado_Mes > idc_VL_Limite_Cota then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A sua cota de descontos no m$$HEX1$$ea00$$ENDHEX$$s se esgotou. ~r~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel utilizar o Cobre Pre$$HEX1$$e700$$ENDHEX$$o.", Exclamation!)
			ab_bloqueia_utilizacao = True
			Return
		End If
	End if
	
	
	
	
	//05
	//Quando h$$HEX1$$e100$$ENDHEX$$ % limite cadastrado
	If ldc_Limite_Cota_mes > 0 Then
		//Limite atingido por % definido
		ldc_PC_Atingido = Round(( idc_Total_Utilizado_Mes / ldc_Limite_Cota_mes ) * 100 , 2)
		
		If ldc_PC_Atingido >= 80 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O seu limite de descontos no m$$HEX1$$ea00$$ENDHEX$$s est$$HEX1$$e100$$ENDHEX$$ prestes a se esgotar.", Exclamation!)
			Return
		End If
	End If

	If ldc_Limite_Cota_dia > 0 Then
		//Limite atingido por % definido
		ldc_PC_Atingido = Round(( idc_Total_Utilizado_Dia / ldc_Limite_Cota_dia ) * 100 , 2)
		
		If ldc_PC_Atingido >= 80 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O seu limite de descontos no dia est$$HEX1$$e100$$ENDHEX$$ prestes a se esgotar.", Exclamation!)
			Return
		End If
	End If
	
	
	//Quando h$$HEX1$$e100$$ENDHEX$$ valor limite cadastrado
	If idc_Vl_Limite_Cota > 0 Then 
		//Limite atingido por valor definido
		ldc_PC_Atingido = Round(( idc_Total_Utilizado_Mes / idc_Vl_Limite_Cota ) * 100 , 2)
		
		If ldc_PC_Atingido >= 80 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O seu limite de descontos no per$$HEX1$$ed00$$ENDHEX$$odo est$$HEX1$$e100$$ENDHEX$$ prestes a se esgotar.", Exclamation!)
			Return
		End If
	End If


Catch ( runtimeError re )
	MessageBox (	"Erro", "Ocorreu um erro ao verificar o valor utilizado no m$$HEX1$$ea00$$ENDHEX$$s. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_limite_utilizado_mes(). ~r~r"+ & 						
 						"Erro: "+ re.GetMessage( ), StopSign!)
Finally
End Try
end subroutine

public subroutine of_cota_filial (long al_filial, date adt_mes);Date ldt_Ultimo_dia_Mes
Date ldt_primeiro_dia_mes

ldt_Ultimo_dia_Mes 	= gf_retorna_ultimo_dia_mes( adt_mes )
ldt_primeiro_dia_mes = gf_primeiro_dia_mes( adt_mes )

If This.il_Filial_Parametro <> This.il_Filial_Matriz Then
	
	SELECT sum( vl_cota )
	INTO :idc_Sum_Cota_Mes_Filial
	FROM cota_filial 
	WHERE dh_cota between :ldt_primeiro_dia_mes AND :ldt_Ultimo_dia_Mes
	 Using SqlCa;
	 
Else	
	//Matriz
	SELECT sum( vl_cota )
	INTO :idc_Sum_Cota_Mes_Filial
	FROM cota_filial 
	WHERE dh_cota between :ldt_primeiro_dia_mes AND  :ldt_Ultimo_dia_Mes
	 Using SqlCa;
	 
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError( "Erro ao localizar a cota mensal da filial. " +String(al_filial) )
	Return
End If

Select vl_cota
into :idc_Cota_Dia_Filial
from cota_filial
where dh_cota = :adt_mes 
 Using SqlCa;
	 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError( "Erro ao localizar a cota di$$HEX1$$e100$$ENDHEX$$ria da filial . " +String(al_filial) )
	Return
End If
	 
end subroutine

public function integer of_valor_utilizado_negociacao_mes (long al_filial, date adt_periodo);Date ldt_Inicio
Date ldt_Termino

ldt_Inicio 	= gf_primeiro_dia_mes ( adt_periodo )
ldt_Termino	= gf_retorna_ultimo_dia_mes ( adt_periodo )

SELECT IsNull(Round(Sum( n.qt_negociada * (	n.vl_preco_unitario * (((Case when n.pc_desconto_negociado > n.pc_desconto_unitario then n.pc_desconto_negociado else n.pc_desconto_unitario end) - n.pc_desconto_unitario) / 100))) ,	2), 0)
	INTO :idc_Total_Utilizado_Mes
FROM cliente_caixa c
	INNER JOIN negociacao_cliente n
	ON n.nr_sequencial_cliente_caixa = c.nr_sequencial
WHERE c.dh_movimentacao between :ldt_Inicio AND :ldt_Termino
	AND n.cd_filial	 	= :al_filial
	AND n.id_situacao 	= 'A'
	AND c.id_situacao in ( 'A', 'C' )
	AND   NOT EXISTS ( select x.nr_nf FROM nf_venda x 
								  WHERE x.cd_filial  		= c.cd_filial
									 AND x.nr_nf      		= c.nr_nf
									 AND x.de_especie 	= c.de_especie
									 AND x.de_serie   		= c.de_serie
									 AND x.dh_cancelamento IS NOT NULL )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o m$$HEX1$$ea00$$ENDHEX$$s no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
	Return -1
End If

SELECT IsNull(Round(Sum( n.qt_negociada * (	n.vl_preco_unitario * (((Case when n.pc_desconto_negociado > n.pc_desconto_unitario then n.pc_desconto_negociado else n.pc_desconto_unitario end) - n.pc_desconto_unitario) / 100))) ,	2), 0)
	INTO :idc_Total_Utilizado_Dia
FROM cliente_caixa c
	INNER JOIN negociacao_cliente n
	ON n.nr_sequencial_cliente_caixa = c.nr_sequencial
WHERE c.dh_movimentacao = :adt_periodo
	AND n.cd_filial	 	= :al_filial
	AND n.id_situacao 	= 'A'
	AND c.id_situacao in ( 'A', 'C' )
	AND   NOT EXISTS ( select x.nr_nf FROM nf_venda x 
								  WHERE x.cd_filial  		= c.cd_filial
									 AND x.nr_nf      		= c.nr_nf
									 AND x.de_especie 	= c.de_especie
									 AND x.de_serie   		= c.de_serie
									 AND x.dh_cancelamento IS NOT NULL )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o dia no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
	Return -1
End If


If idc_Total_Utilizado_Mes < 0 	or IsNull( idc_Total_Utilizado_Mes ) 	Then idc_Total_Utilizado_Mes = 0
If idc_Total_Utilizado_Dia < 0 	or IsNull( idc_Total_Utilizado_Dia ) 	Then idc_Total_Utilizado_Dia = 0

Return 1
end function

public function boolean of_verifica_limite_cadastrado ();date ldt_sisdate
Date ldt_primeiro_dia_mes
Date ldt_Ultimo_dia_Mes

ldt_sisdate = date(gf_getserverdate())
ldt_primeiro_dia_mes = gf_primeiro_dia_mes(ldt_sisdate)
ldt_Ultimo_dia_Mes 	= gf_retorna_ultimo_dia_mes( ldt_sisdate)

  select  pc_cota,	 				 id_dir_cota_mes,	  	  id_dir_cota_dia,	 	 vl_fixo,	 				id_dir_vl_fixo
	Into :idc_PC_Limite_Cota,	:is_id_dir_cota_mes,	 :is_id_dir_cota_dia,	:idc_Vl_Limite_Cota,	:is_id_dir_vl_fixo
   from parametro_cobre_preco
 where cd_filial = :gvo_Parametro.Cd_Filial
	and dh_cota between :ldt_primeiro_dia_mes and :ldt_Ultimo_dia_Mes
 USING Sqlca;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar os limites da par$$HEX1$$e200$$ENDHEX$$metros cobre pre$$HEX1$$e700$$ENDHEX$$o para a filial " + String( gvo_Parametro.Cd_Filial ))
	Return false
End If

If Sqlca.sqlcode = 100 then
	
	Select max(dh_cota) 
	into :ldt_sisdate 
	from parametro_cobre_preco 
	using sqlca;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_msgDbError("Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo registro dos limites cadastrados na par$$HEX1$$e200$$ENDHEX$$metros cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial " + String( gvo_Parametro.Cd_Filial ))
		Return false
	End If
	
	ldt_primeiro_dia_mes = gf_primeiro_dia_mes(ldt_sisdate)
	ldt_Ultimo_dia_Mes 	= gf_retorna_ultimo_dia_mes( ldt_sisdate)
	
	select  pc_cota,	 				 id_dir_cota_mes,	  	  id_dir_cota_dia,	 	 vl_fixo,	 				id_dir_vl_fixo
	   Into :idc_PC_Limite_Cota,	:is_id_dir_cota_mes,	 :is_id_dir_cota_dia,	:idc_Vl_Limite_Cota,	:is_id_dir_vl_fixo
	  from parametro_cobre_preco
	where cd_filial = :gvo_Parametro.Cd_Filial
	    	and dh_cota between :ldt_primeiro_dia_mes and :ldt_Ultimo_dia_Mes
		USING Sqlca;
		
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_msgDbError("Erro ao localizar os limites da par$$HEX1$$e200$$ENDHEX$$metros cobre pre$$HEX1$$e700$$ENDHEX$$o para a filial " + String( gvo_Parametro.Cd_Filial ))
		Return false
	End If

End If

Return true
end function

on uo_ge460_cobre_preco.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge460_cobre_preco.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;gf_filiais_parametro( Ref il_Filial_Parametro, Ref il_Filial_Matriz )
end event

