HA$PBExportHeader$uo_ge641_processa_atualizacao_chave_sap.sru
forward
global type uo_ge641_processa_atualizacao_chave_sap from dc_uo_ds_base
end type
end forward

global type uo_ge641_processa_atualizacao_chave_sap from dc_uo_ds_base
end type
global uo_ge641_processa_atualizacao_chave_sap uo_ge641_processa_atualizacao_chave_sap

forward prototypes
public function boolean of_processa_atualizacao_chave_update (string as_chave_interface, string as_id_tipo, string as_nr_atualizacao, ref string as_msg)
public function boolean of_processa_atualizacao_chave ()
public function boolean of_grava_log_chave_interface (string as_chave_interface, string as_id_tipo, string as_nr_atualizacao, string as_msg)
public subroutine atualiza_cd_chave_interface_wms_int_sap ()
end prototypes

public function boolean of_processa_atualizacao_chave_update (string as_chave_interface, string as_id_tipo, string as_nr_atualizacao, ref string as_msg);Long ll_nr_atualizacao
String ls_cd_chave

ll_nr_atualizacao = Long(as_nr_atualizacao)

SELECT cd_chave
INTO :ls_cd_chave
FROM log_exportacao_sap 
WHERE id_tipo_nf IN ('WMD', 'WMA', 'WMI')
  AND nr_atualizacao = :ll_nr_atualizacao
USING SqlCa;

Choose Case as_id_tipo
    Case 'N'
        UPDATE log_exportacao_sap 
        SET cd_chave_interface = :as_chave_interface
        WHERE nr_atualizacao = :ll_nr_atualizacao
        Using SqlCa;
			
    Case 'E'
        UPDATE log_exportacao 
        SET cd_varchar3 = :as_chave_interface
        WHERE nr_exportacao = :as_nr_atualizacao
        Using SqlCa;

    Case Else
        as_msg = "Tipo de registro '" + as_id_tipo + "' n$$HEX1$$e300$$ENDHEX$$o foi encontrado"
        Return False
End Choose

If ls_cd_chave <> '' And IsNumber(ls_cd_chave) Then		
    UPDATE wms_int_sap
    SET cd_chave_interface = :as_chave_interface
    WHERE Cast(nr_integracao AS Varchar(10)) = :ls_cd_chave
    Using SqlCa;	
End If

Choose Case SqlCa.SqlCode
    Case -1
        as_msg = SQLCA.SQLErrText
        SqlCa.of_Rollback()
        Return False

    Case 0
        SQLCA.of_Commit()
End Choose

Return True


end function

public function boolean of_processa_atualizacao_chave ();String	ls_Nr_atualizacao
String	ls_msg
String	ls_id_tipo
String	ls_chave_interface

Long		ll_Linha, ll_Linhas, ll_nr_atualizacao

dc_uo_ds_base lvds
lvds = Create dc_uo_ds_base

lvds.Of_ChangeDataObject('ds_ge641_processa_atualizacao_chave_sap')

ll_Linhas	= lvds.Retrieve()

If ll_Linhas > 0 Then
    For ll_Linha = 1 To ll_Linhas

        ls_id_tipo = lvds.GetItemString(ll_Linha, 'id_tipo')
        ls_nr_atualizacao = lvds.GetItemString(ll_Linha, 'nr_atualizacao')

        If Not gf_proxima_solicitacao_sap(Ref ls_chave_interface, Ref ls_msg) Then
				SQLCA.of_Rollback()
				of_grava_log_chave_interface(ls_chave_interface, ls_id_tipo, ls_nr_atualizacao, ls_msg)
            Continue
        End If

        If Not of_processa_atualizacao_chave_update(ls_chave_interface, ls_id_tipo, ls_nr_atualizacao,ref ls_msg) Then
				SQLCA.of_Rollback()
            of_grava_log_chave_interface(ls_chave_interface, ls_id_tipo, ls_nr_atualizacao, ls_msg)
				Continue
        End If
    Next
End If

Destroy lvds

Return true

end function

public function boolean of_grava_log_chave_interface (string as_chave_interface, string as_id_tipo, string as_nr_atualizacao, string as_msg);   Long ll_nr_atualizacao
	
	Choose Case as_id_tipo
        Case 'N'
				
				ll_nr_atualizacao = long(as_nr_atualizacao)
			
            UPDATE log_exportacao_sap 
            SET de_erro					= :as_msg
            WHERE nr_atualizacao		= :ll_nr_atualizacao
            Using SqlCa;

        Case 'E'
            UPDATE log_exportacao 
            SET de_erro					= :as_msg
            WHERE nr_exportacao		= :as_nr_atualizacao
            Using SqlCa;
			
		  Case Else
            // Se nenhum tipo for encontrado Enviar e-mail
            as_msg = "Tipo de registro '" +as_id_tipo + "' n$$HEX1$$e300$$ENDHEX$$o foi encontrado"
			Return False
    End Choose

    Choose Case SqlCa.SqlCode
        Case -1
            as_msg = SQLCA.SQLErrText
            SqlCa.of_Rollback()
				Return False
        Case 0
            SQLCA.of_Commit()
    End Choose

    Return true

end function

public subroutine atualiza_cd_chave_interface_wms_int_sap ();
end subroutine

on uo_ge641_processa_atualizacao_chave_sap.create
call super::create
end on

on uo_ge641_processa_atualizacao_chave_sap.destroy
call super::destroy
end on

