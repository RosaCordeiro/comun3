HA$PBExportHeader$uo_ge589_exportacao_j1btax.sru
forward
global type uo_ge589_exportacao_j1btax from nonvisualobject
end type
end forward

global type uo_ge589_exportacao_j1btax from nonvisualobject
end type
global uo_ge589_exportacao_j1btax uo_ge589_exportacao_j1btax

type variables
String ivs_Log
Integer ivi_cd_tabela

uo_ge481_wms_imposto iuo_ge481_wms_imposto
dc_uo_dw_base idw_Regras
end variables

forward prototypes
public subroutine of_inicializa (string ps_cd_tabela_sap)
public function string of_get_id_situacao_aprovacao (long pl_nr_controle)
public function boolean of_reprova (long pl_nr_controle)
public subroutine of_setdwregras (dc_uo_dw_base pdw_regras)
public function boolean of_aprova_regras (long pl_nr_controle, boolean pb_aprovou_todas)
public function boolean of_aprova_reprova (long pl_nr_controle)
public function boolean of_aprovar_subida (long pl_nr_controle, string ps_ambiente_sap, ref boolean pb_todas_aprovadas, ref boolean pb_todas_reprovadas)
end prototypes

public subroutine of_inicializa (string ps_cd_tabela_sap);Choose Case ps_cd_tabela_sap
	Case 'J_1BTXIC3'
		ivi_cd_tabela = 140

	Case 'J_1BTXIP3'
		ivi_cd_tabela = 141
		
	Case 'J_1BTXISS'
		ivi_cd_tabela = 142
		
	Case 'J_1BTXPIS'
		ivi_cd_tabela = 143
		
	Case 'J_1BTXCOF'
		ivi_cd_tabela = 144
		
	Case 'J_1BTXST3'
		ivi_cd_tabela = 145
		
End Choose
end subroutine

public function string of_get_id_situacao_aprovacao (long pl_nr_controle);String lvs_ret

Select id_situacao_aprovacao
Into	:lvs_ret
From	log_exportacao_j1btax
Where nr_controle = :pl_nr_controle
Using SQLCA;

If SQLCA.SqlCode = -1 Then
	SQLCA.of_msgdberror("Erro ao consultar id_situacao_aprovacao do controle: "+String(pl_nr_controle))
	Return ''
End If

Return lvs_ret
end function

public function boolean of_reprova (long pl_nr_controle);UPDATE log_exportacao_j1btax
SET	 id_situacao_aprovacao = 'R',
		 nr_matricula_resp_aprovacao = :gvo_Aplicacao.ivo_seguranca.Nr_Matricula,
		 dh_aprovacao = getdate()
WHERE	 nr_controle = :pl_nr_controle
USING	 SQLCA;

If SQLCA.SQLCode = -1 Then
	ivs_Log = "uo_ge589_exportacao_j1btax.of_reprova: "+SQLCA.SQLErrText
	Return false
End If

Return True
end function

public subroutine of_setdwregras (dc_uo_dw_base pdw_regras);idw_Regras = pdw_Regras
end subroutine

public function boolean of_aprova_regras (long pl_nr_controle, boolean pb_aprovou_todas);Long lvl_For, lvl_nr_item
String lvs_id_aprovado

// Aprovou todas
If pb_Aprovou_Todas Then
	UPDATE 	log_exportacao_j1btax_item
	Set		id_aprovado = 'S'
	Where		nr_controle = :pl_nr_controle
	Using 	SQLCA;
	
	If SQLCA.SQLCode = -1 Then
		ivs_Log = "uo_ge589_exportacao_j1btax.of_aprova_regras: "+SQLCA.SQLErrText
		Return false
	End If
	
	Return True
	
End If

////////// N$$HEX1$$e300$$ENDHEX$$o aprovou todas, percorrer a DW e aprovar s$$HEX1$$f300$$ENDHEX$$ o necess$$HEX1$$e100$$ENDHEX$$rio

// dw inv$$HEX1$$e100$$ENDHEX$$lida
If Not isValid(idw_Regras) Then 
	ivs_Log = "uo_ge589_exportacao_j1btax.of_aprova_regras: idw_Regras inv$$HEX1$$e100$$ENDHEX$$lida."
	Return False
End If

// dw vazia
If idw_Regras.RowCount() = 0 Then 
	ivs_Log = "uo_ge589_exportacao_j1btax.of_aprova_regras: idw_Regras vazia."
	Return False
End If

// Aqui faz update para Aprovado apenas nas regras marcadas para aprova$$HEX2$$e700e300$$ENDHEX$$o
For lvl_For = 1 To idw_Regras.RowCount()
	lvl_nr_item = idw_Regras.GetItemNumber(lvl_For, "nr_item")
	
	If idw_Regras.GetItemString(lvl_For, "id_aprovado") = 'S' Then
		UPDATE 	log_exportacao_j1btax_item
		Set		id_aprovado = 'S'
		Where		nr_controle = :pl_nr_controle
			And	nr_item 		= :lvl_nr_item
		Using 	SQLCA;
	
		If SQLCA.SQLCode = -1 Then
			ivs_Log = "uo_ge589_exportacao_j1btax.of_aprova_regras: "+SQLCA.SQLErrText
			Return false
		End If
	End If
	
Next

Return True
end function

public function boolean of_aprova_reprova (long pl_nr_controle);// Se alguma regra foi aprovada, altera para Aprovado
// Se todas foram reprovadas, altera para Reprovado.

Int	 lvi_alguma_aprovada
String id_situacao_aprovacao

SELECT top 1 1
Into  :lvi_alguma_aprovada
From	log_exportacao_j1btax_item
Where	nr_controle = :pl_nr_controle
	And id_aprovado = 'S'
Using SQLCA;

If SQLCA.SQLCode = -1 Then
	ivs_Log = "uo_ge589_exportacao_j1btax.of_aprova: "+SQLCA.SQLErrText
	Return false
End If

If lvi_alguma_aprovada > 0 Then
	id_situacao_aprovacao = 'A'
Else
	id_situacao_aprovacao = 'R'
End If

UPDATE log_exportacao_j1btax
SET	 id_situacao_aprovacao 			= :id_situacao_aprovacao,
		 nr_matricula_resp_aprovacao 	= :gvo_Aplicacao.ivo_seguranca.Nr_Matricula,
		 dh_aprovacao 						= getdate()
WHERE	 nr_controle	= :pl_nr_controle
USING	 SQLCA;

If SQLCA.SQLCode = -1 Then
	ivs_Log = "uo_ge589_exportacao_j1btax.of_aprova: "+SQLCA.SQLErrText
	Return false
End If

Return True
end function

public function boolean of_aprovar_subida (long pl_nr_controle, string ps_ambiente_sap, ref boolean pb_todas_aprovadas, ref boolean pb_todas_reprovadas);Boolean lvb_Sucesso

Try
	// N$$HEX1$$e300$$ENDHEX$$o deixa enviar do homologa para o PRD
	If Lower(SQLCA.DataBase) = "homologa" and ps_Ambiente_SAP = "PRD" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Proibido enviar regra do banco Homologa para o SAP PRD.~r~rO relat$$HEX1$$f300$$ENDHEX$$rio ser$$HEX1$$e100$$ENDHEX$$ Reprovado automaticamente.", StopSign!)
		pb_Todas_Reprovadas = True
		pb_Todas_Aprovadas = False
	End If
	
	iuo_ge481_wms_imposto.of_Inicializa( ivi_cd_tabela )
	
	// Gera Log Exporta$$HEX2$$e700e300$$ENDHEX$$o apenas se n$$HEX1$$e300$$ENDHEX$$o reprovou todas
	If Not pb_Todas_Reprovadas Then
		If Not iuo_ge481_wms_imposto.of_Gera_Envio_SAP(pl_nr_controle, ps_ambiente_sap, Ref ivs_Log) Then 
			Return False
		End If
		
		// Atualiza cada regra aprovada
		If Not of_Aprova_Regras(pl_nr_controle, pb_todas_aprovadas) Then Return False
	End If
	
	// Atualizar o id_situacao_aprovacao para 'A' ou 'R'
	If Not of_Aprova_Reprova(pl_nr_controle) Then Return False
	
	lvb_Sucesso = True
	
	Return True
Finally
	If lvb_Sucesso Then
		SQLCA.of_Commit()
	Else
		SQLCA.of_Rollback()
	End If
End Try
end function

on uo_ge589_exportacao_j1btax.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge589_exportacao_j1btax.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

