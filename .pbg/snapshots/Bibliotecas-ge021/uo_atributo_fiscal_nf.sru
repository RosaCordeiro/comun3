HA$PBExportHeader$uo_atributo_fiscal_nf.sru
forward
global type uo_atributo_fiscal_nf from nonvisualobject
end type
end forward

global type uo_atributo_fiscal_nf from nonvisualobject
end type
global uo_atributo_fiscal_nf uo_atributo_fiscal_nf

type variables
decimal {2} vl_bc_icms_uf_destino
decimal {2} vl_bc_icms_fcp_uf_destino

decimal {2}	pc_icms_uf_destino
decimal {2}	pc_icms_fcp_uf_destino
decimal {2}	pc_partilha
decimal {2}	vl_icms_fcp_uf_destino
decimal {2}	vl_fcp
decimal {2}	pc_fcp
decimal {2}	pc_aliq_pis
decimal {2}	pc_aliq_cofins

decimal{4}	vl_bc_icms			
decimal{4}	vl_bc_icms_st		
decimal{4}	vl_icms				
decimal{4}	vl_icms_st			
decimal{4}	vl_bc_icms_st_prd	
decimal{4}	vl_preco_medio_ponderado_cf //unit$$HEX1$$e100$$ENDHEX$$rio
decimal{4}	vl_preco_maximo_consumidor  //unit$$HEX1$$e100$$ENDHEX$$rio
decimal{4}	pc_icms
decimal{4}	vl_icms_st_prd		
decimal{4}	vl_bc_icms_prd		
decimal{4}	vl_icms_prd			
decimal{4}	vl_icms_prd_nfe	
decimal{4}	pc_icms_st
decimal{4}	vl_mva
decimal{4}	pc_reducao_base_icms
decimal{4}	vl_bc_ipi
decimal{4}	vl_ipi
decimal{4}	pc_repasse_icms
decimal{4}	vl_repasse_icms
decimal{4}	vl_icms_uf_destino
decimal{4}	vl_icms_uf_origem
decimal{4}	vl_icms_operacao
decimal{4}	pc_icms_diferido 
decimal{4}	vl_icms_diferido
decimal{4}  vl_icms_desonerado
				
decimal {4} vl_bc_pis
decimal {4} vl_pis
decimal {4} vl_bc_cofins
decimal {4} vl_cofins

decimal {4} vl_bc_icms_antecipacao
decimal {4} pc_mva_antecipacao
decimal {4} pc_icms_antecipacao
decimal {4} vl_icms_antecipacao

decimal {4} vl_bc_icms_efetivo
decimal {4} pc_icms_efetivo
decimal {4} vl_icms_efetivo

decimal {4} pc_trava_iva_st							 
decimal {5} pc_reducao_base_st

string	cd_st_origem
string	cd_st_tributacao
string cd_beneficio
string	cd_cst_pis
string	cd_cst_cofins
String id_motivo_desoneracao
String cd_mod_bc_st //0=Pre$$HEX1$$e700$$ENDHEX$$o Tabelado ou M$$HEX1$$e100$$ENDHEX$$ximo; 1=Lista Negativa; 2=Lista Positiva; 3=Lista Neutra; 4=MVA; 5=Pauta

long cd_mensagem_fiscal
string de_mensagem_fiscal

/****** Reforma Tribut$$HEX1$$e100$$ENDHEX$$ria *****/
Long id_cst_ibscbs
String cd_cst_ibscbs
String id_class_trib_ibscbs
String cd_class_trib_ibscbs
Decimal{2} vl_bc_ibscbs

/* CBS */
Decimal{4} pc_cbs
Decimal{4} pc_reducao_cbs
Decimal{4} pc_efetiva_cbs
Decimal{4} pc_dif_cbs
Decimal{2} vl_dif_cbs
Decimal{2} vl_dev_trib_cbs
Decimal{2} vl_cbs

/* IBS */
Decimal{2} vl_ibs

/* IBS Estadual */
Decimal{4} pc_ibs_uf
Decimal{4} pc_reducao_ibs_uf
Decimal{4} pc_efetiva_ibs_uf
Decimal{4} pc_dif_ibs_uf
Decimal{2} vl_dif_ibs_uf
Decimal{2} vl_dev_trib_ibs_uf
Decimal{2} vl_ibs_uf

/* IBS Municipal */
Decimal{4} pc_ibs_mun
Decimal{4} pc_reducao_ibs_mun
Decimal{4} pc_efetiva_ibs_mun
Decimal{4} pc_dif_ibs_mun 
Decimal{2} vl_dif_ibs_mun
Decimal{2} vl_dev_trib_ibs_mun
Decimal{2} vl_ibs_mun

/* Imposto Seletivo */
Long id_cst_is
String cd_cst_is
String id_classificacao_trib_is
String cd_classificacao_trib_is
Decimal{2} vl_bc_is
Decimal{4} pc_is
Decimal{4} pc_is_espec
String cd_un_trib_is
Decimal{4} qt_trib_is
Decimal{2} vl_is

/* Tributa$$HEX2$$e700e300$$ENDHEX$$o CBS/IBS Regular */
Long id_cst_ibscbs_reg
String cd_cst_ibscbs_reg
String id_class_trib_ibscbs_reg
String cd_class_trib_ibscbs_reg
Decimal{4} pc_efetiva_reg_ibs_uf
Decimal{2} vl_trib_reg_ibs_uf
Decimal{4} pc_efetiva_reg_ibs_mun
Decimal{2} vl_trib_reg_ibs_mun
Decimal{4} pc_efetiva_reg_cbs
Decimal{2} vl_trib_reg_cbs
end variables

forward prototypes
public subroutine of_inicializa_campos_reforma ()
end prototypes

public subroutine of_inicializa_campos_reforma ();SetNull(id_cst_ibscbs)
SetNull(cd_cst_ibscbs)
SetNull(id_class_trib_ibscbs)
SetNull(cd_class_trib_ibscbs)

vl_bc_ibscbs = 0

/* CBS */
pc_cbs = 0
SetNull(pc_reducao_cbs)
SetNull(pc_efetiva_cbs)
SetNull(pc_dif_cbs)
SetNull(vl_dif_cbs)
SetNull(vl_dev_trib_cbs)
vl_cbs = 0

/* IBS */
vl_ibs = 0

/* IBS Estadual */
pc_ibs_uf = 0
SetNull(pc_reducao_ibs_uf)
SetNull(pc_efetiva_ibs_uf)
SetNull(pc_dif_ibs_uf)
SetNull(vl_dif_ibs_uf)
SetNull(vl_dev_trib_ibs_uf)
vl_ibs_uf = 0

/* IBS Municipal */
pc_ibs_mun = 0
SetNull(pc_reducao_ibs_mun)
SetNull(pc_efetiva_ibs_mun)
SetNull(pc_dif_ibs_mun)
SetNull(vl_dif_ibs_mun)
SetNull(vl_dev_trib_ibs_mun)
vl_ibs_mun = 0

/* Imposto Seletivo */
SetNull(id_cst_is)
SetNull(cd_cst_is)
SetNull(id_classificacao_trib_is)
SetNull(cd_classificacao_trib_is)
vl_bc_is = 0
pc_is = 0
pc_is_espec = 0
SetNull(cd_un_trib_is)
SetNull(qt_trib_is)
vl_is = 0

/* Tributa$$HEX2$$e700e300$$ENDHEX$$o CBS/IBS Regular */
SetNull(id_cst_ibscbs_reg)
SetNull(cd_cst_ibscbs_reg)
SetNull(id_class_trib_ibscbs_reg)
SetNull(cd_class_trib_ibscbs_reg)
SetNull(pc_efetiva_reg_ibs_uf)
SetNull(vl_trib_reg_ibs_uf)
SetNull(pc_efetiva_reg_ibs_mun)
SetNull(vl_trib_reg_ibs_mun)
SetNull(pc_efetiva_reg_cbs)
SetNull(vl_trib_reg_cbs)
end subroutine

on uo_atributo_fiscal_nf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_atributo_fiscal_nf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

