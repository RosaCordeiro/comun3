HA$PBExportHeader$uo_parametro_janelas.sru
forward
global type uo_parametro_janelas from nonvisualobject
end type
end forward

global type uo_parametro_janelas from nonvisualobject
end type
global uo_parametro_janelas uo_parametro_janelas

type variables
Datetime ivdh_inicio_mes, ivdh_fim_mes, ivdh_inicio_ano, &
               ivdh_fim_ano, ivdh_hoje
Date ivdt_ontem
Long ivl_filial_dc[], ivl_filial_pp[], ivl_filial_dcp[], &
         ivl_filial_man[], ivl_filial_umso[], ivl_filial_pro[], ivl_filial_cd[], ivl_filial_far[]
String ivs_rede
Integer ivi_numero_dias_mes, ivi_numero_dias_ano, &
            ivi_dias_corrente
Integer ivi_Tipo_Ano = 1 //1 - Normal, 2 - Bissexto
				
Decimal 	ivdc_Venda_Dia,&
			ivdc_Cota_Dia,&
			ivdc_Venda_Mes,&
			ivdc_Cota_Mes,&
			ivdc_Venda_Ano,&
			ivdc_Cota_Ano
			
Long ivl_clientes_dia, ivl_clientes_mes, ivl_clientes_ano


end variables

on uo_parametro_janelas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_parametro_janelas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

