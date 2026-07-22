HA$PBExportHeader$uo_tributacao_icms.sru
forward
global type uo_tributacao_icms from nonvisualobject
end type
end forward

global type uo_tributacao_icms from nonvisualobject
end type
global uo_tributacao_icms uo_tributacao_icms

type variables
string cd_tributacao_icms, &
         de_tributacao_icms, &
         id_icms_normal, &
         id_icms_st, &
         id_reducao_base_icms, &
		cd_cst_tributacao, &
		cd_situacao_tributaria, &
		id_icms_diferido, &
		id_icms_st_retido_ant


long ivl_Filial, ivl_Filial_Matriz

Long cd_tributacao_produto
 
Decimal{4} pc_st_estadual
end variables

forward prototypes
public function boolean of_localiza_tributacao (string ps_tributacao)
public function boolean of_carrega_parametros ()
public function boolean of_tributacao_produto_old (string as_uf, long al_produto)
public function boolean of_localiza_tributacao_cst (string ps_cst_tributacao)
end prototypes

public function boolean of_localiza_tributacao (string ps_tributacao);Select		cd_tributacao_icms,
			de_tributacao_icms,
			id_icms_normal,
			id_icms_st,
			id_reducao_base_icms,
			cd_cst_tributacao,
			id_icms_diferido,
			id_icms_st_retido_ant
	Into	:cd_tributacao_icms,
			:de_tributacao_icms,
			:id_icms_normal,
			:id_icms_st,
			:id_reducao_base_icms,
			:cd_cst_tributacao,
			:id_icms_diferido,
			:id_icms_st_retido_ant
From tributacao_icms
Where cd_tributacao_icms = :ps_Tributacao;

cd_situacao_tributaria = '0'+LeftA(cd_cst_tributacao, 1)

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ps_Tributacao + "' n$$HEX1$$e300$$ENDHEX$$o localizada.", Information!, Ok!)
		Return False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da tributa$$HEX2$$e700e300$$ENDHEX$$o '" + ps_Tributacao + "'." + SqlCa.SqlErrText, Information!, Ok!)
		Return False		
End Choose

end function

public function boolean of_carrega_parametros ();DateTime lvdh_Data

Select cd_filial,
       cd_filial_matriz
Into :ivl_Filial,
     :ivl_Filial_Matriz
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data do par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizada para tratamento fiscal.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data do Par$$HEX1$$e200$$ENDHEX$$metro para Tratamento Fiscal")
End Choose

Return False
end function

public function boolean of_tributacao_produto_old (string as_uf, long al_produto);If This.of_carrega_parametros() Then
	If ivl_Filial = ivl_Filial_matriz Then
		Select p.cd_tributacao_icms, p.cd_tributacao_produto, t.pc_st_estadual
		Into :cd_tributacao_icms, :cd_tributacao_produto, :pc_st_estadual
		From produto_uf p, tributa_produtos_farmaceuticos t
		Where p.cd_unidade_federacao 	= :as_UF
		  and p.cd_produto  		   	= :al_Produto
		  and t.cd_tributacao_produto	= p.cd_tributacao_produto
		  and i.cd_tipo_icms			= p.cd_tipo_icms
		Using Sqlca;
	Else
		Select p.cd_tributacao_icms, p.cd_tributacao_produto, t.pc_st_estadual
		Into :cd_tributacao_icms, :cd_tributacao_produto, :pc_st_estadual
		From produto_geral p
		where p.cd_unidade_federacao 	= :as_UF
		  and p.cd_produto  		   	= :al_Produto
		Using Sqlca;
	End If
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar a tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS do produto.", StopSign!)
			Return False
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da tributa$$HEX2$$e700e300$$ENDHEX$$o de ICMS do produto.")
			Return False
	End Choose
End If

Return True


  
 
 
 
end function

public function boolean of_localiza_tributacao_cst (string ps_cst_tributacao);Select		cd_tributacao_icms,
			de_tributacao_icms,
			id_icms_normal,
			id_icms_st,
			id_reducao_base_icms,
			cd_cst_tributacao,
			id_icms_diferido,
			id_icms_st_retido_ant
	Into	:cd_tributacao_icms,
			:de_tributacao_icms,
			:id_icms_normal,
			:id_icms_st,
			:id_reducao_base_icms,
			:cd_cst_tributacao,
			:id_icms_diferido,
			:id_icms_st_retido_ant
From tributacao_icms
Where cd_cst_tributacao = :ps_cst_tributacao;

cd_situacao_tributaria = '0'+LeftA(cd_cst_tributacao, 1)

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tributa$$HEX2$$e700e300$$ENDHEX$$o da CST '" + ps_cst_tributacao + "' n$$HEX1$$e300$$ENDHEX$$o localizada.", Information!, Ok!)
		Return False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da tributa$$HEX2$$e700e300$$ENDHEX$$o por CST '" + ps_cst_tributacao + "'." + SqlCa.SqlErrText, Information!, Ok!)
		Return False		
End Choose

end function

on uo_tributacao_icms.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tributacao_icms.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

