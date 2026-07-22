HA$PBExportHeader$uo_ge582_aviso_pagmto_guia.sru
forward
global type uo_ge582_aviso_pagmto_guia from nonvisualobject
end type
end forward

global type uo_ge582_aviso_pagmto_guia from nonvisualobject
end type
global uo_ge582_aviso_pagmto_guia uo_ge582_aviso_pagmto_guia

type variables
String is_Uf_Filiais
Long il_Cod_Msg = 287

String is_Data_Hoje 
end variables

forward prototypes
public function boolean of_verifica_faturamento_filiais_estados (string as_filiais)
public function boolean of_verifica_parametro_filiais ()
public function boolean of_processa_aviso ()
public function boolean of_envia_email (string al_filiais)
public function boolean of_verifica_reexecucao ()
public function boolean of_atualiza_data_envio ()
end prototypes

public function boolean of_verifica_faturamento_filiais_estados (string as_filiais);Long ll_qtd
date ldt_data_ontem
string ls_sql

ldt_data_ontem = RelativeDate(date(is_Data_Hoje), -1)


ls_sql = 	"Select count(*) " + &
         	"From pedido_distribuidora pd " + &
         	"Inner Join filial f ON f.cd_filial = pd.cd_filial " + &
         	"Inner Join cidade c ON c.cd_cidade = f.cd_cidade " + &
         	"Where pd.dh_emissao >= '" + string(ldt_data_ontem, "yyyy-mm-dd") +" 00:00:00' "+&
         	"And c.cd_unidade_federacao IN (" + is_Uf_Filiais + ") " + &
         	"And pd.cd_distribuidora = '053404705' " + &
         	"And pd.id_situacao NOT IN ('F', 'J', 'X')"

PREPARE SQLSA FROM :ls_sql ;
DESCRIBE SQLSA INTO SQLDA ;
DECLARE lcu_cursor DYNAMIC CURSOR FOR SQLSA ;
OPEN DYNAMIC lcu_cursor USING DESCRIPTOR SQLDA ;
FETCH lcu_cursor  INTO :ll_qtd;

Choose Case SQLCa.SQLCode
    Case -1
        Return false
End Choose
CLOSE lcu_cursor ;


If ll_qtd = 0 Then
    Return True
Else
    Return False
End If
end function

public function boolean of_verifica_parametro_filiais ();
//checa parametro
Select vl_parametro
Into :is_Uf_Filiais
From wms_parametro 
Where cd_parametro = 'DE_ESTADO_AVISO_GNRE'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.Of_MsgDbError("Erro ao verificar o parametro DE_ESTADO_AVISO_GNRE.")
	Return False
End If

If Not is_Uf_Filiais = "" OR Not IsNull(is_Uf_Filiais) Then
	Return True
Else
	Return False
End If


end function

public function boolean of_processa_aviso ();boolean lb_Sucesso = False

is_Data_Hoje = String ( Date (gf_GetServerDate()), "yyyy-mm-dd" )

If of_verifica_reexecucao() Then
	If of_verifica_parametro_filiais() Then
		If of_verifica_faturamento_filiais_estados( is_Uf_Filiais ) Then
			If of_envia_email(is_Uf_Filiais) Then 
				If of_atualiza_data_envio() Then
					lb_Sucesso = True
				End If
			End If
		End If
	End If
End If

Return lb_Sucesso

end function

public function boolean of_envia_email (string al_filiais);
String ls_Texto_email, ls_Filiais_Parametro
Long  ll_Cod_Msg
		 
s_email str //ge202

ls_Filiais_Parametro = gf_Replace(al_filiais, "'", "", len(ls_Filiais_Parametro))

ls_Texto_Email = 	"<b>Faturamento Finalizado! Envio de e-mail autom$$HEX1$$e100$$ENDHEX$$tico CD - Perini.</b>"+&
						"<br><br>"+&
						"Notas dos Estados de: "+ ls_Filiais_Parametro +" foram faturadas pelo CD. "+&
						"<br><br>"+&
						"<b>J$$HEX1$$e100$$ENDHEX$$ esta liberado para gera$$HEX2$$e700e300$$ENDHEX$$o da GUIA GNRE para pagamento!</b>"+&
						"<br><br>"+&
						"Atenciosamente."

If  al_Filiais <> "" Then 
	str.ps_Mensagem	= ls_Texto_Email
	
	str.pb_Assinatura	= True
	
	gf_ge202_envia_email_padrao(il_Cod_Msg, str)
Else
	Return False
End If 

Return True
end function

public function boolean of_verifica_reexecucao ();String ls_Envio_Paramentro

//checa parametro
Select convert(varchar(10), cast(vl_parametro as date), 23)
Into :ls_Envio_Paramentro
From wms_parametro 
Where cd_parametro = 'DT_ENVIO_AVISO_GNRE'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.Of_MsgDbError("Erro ao verificar o parametro DT_ENVIO_AVISO_GNRE.")
	Return False
End If

If Not IsNull(ls_Envio_Paramentro) OR ls_Envio_Paramentro <> "" Then
	If ls_Envio_Paramentro = is_Data_Hoje Then
		//ja foi feito envio do email hoje
		Return False
	Else
		Return True
	End If
Else
	Return True
End If


end function

public function boolean of_atualiza_data_envio ();Update wms_parametro
Set vl_parametro = :is_Data_Hoje
Where cd_parametro = 'DT_ENVIO_AVISO_GNRE'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack()
	Return False					
End If

SqlCa.of_Commit()

Return True
end function

on uo_ge582_aviso_pagmto_guia.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge582_aviso_pagmto_guia.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

