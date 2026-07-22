HA$PBExportHeader$uo_ge162_desbloquear_produto.sru
forward
global type uo_ge162_desbloquear_produto from nonvisualobject
end type
end forward

global type uo_ge162_desbloquear_produto from nonvisualobject
end type
global uo_ge162_desbloquear_produto uo_ge162_desbloquear_produto

forward prototypes
public function boolean of_desbloqueia_produto_distribuidora ()
end prototypes

public function boolean of_desbloqueia_produto_distribuidora ();Boolean lb_Sucesso = True 
Date ldh_Parametro
s_email str //ge202
String ls_Texto_Email

ldh_Parametro = Date( gf_GetServerDate() )

Update distribuidora_produto
Set id_situacao						= 'A',
	dh_alteracao_situacao			= getdate(),
	nr_matric_alteracao_situacao	= '14330',
	de_alteracao_situacao			= 'DESBLOQUEIO AUTOM$$HEX1$$c100$$ENDHEX$$TICO',
	dh_alteracao_situacao_termino = Null
Where id_situacao = 'B'
And Cast(dh_alteracao_situacao_termino as DATE) = :ldh_Parametro
Using SqlCA;
	
If SQLCA.SQlCode = -1 Then 	
	SqlCA.of_MsgDBError("Erro ao atualizar os Dados para Ativo: DESBLOQUEIO AUTOM$$HEX1$$c100$$ENDHEX$$TICO")
	SqlCa.of_rollback( )
	lb_Sucesso = False
	ls_Texto_Email = "Erro na ativa$$HEX2$$e700e300$$ENDHEX$$o dos produtos das distribuidoras.~r~Mensagem:~r"+String(SQLCA.SQLErrText)
Else
	SqlCa.of_Commit()	
	lb_Sucesso = True
	ls_Texto_Email = "Sucesso na ativa$$HEX2$$e700e300$$ENDHEX$$o dos produtos das distribuidoras agendados para "+String(ldh_Parametro, "dd/mm/yyyy")+"."
	ls_Texto_Email += "~r~rForam atualizados "+String(SQLCA.SQLNRows)+" produtos de distribuidoras."
	ls_Texto_Email += "~r~rPara consultar quais produtos foram desbloqueados, acesse no sistema Compras: 'Relat$$HEX1$$f300$$ENDHEX$$rio > Distribuidoras > Produtos Desbloqueados Automaticamente'"
End If
				
If SQLCA.SQLNRows > 0 Or Not lb_Sucesso	Then
	str.ps_Mensagem	= ls_Texto_Email
	str.pb_Assinatura	= True
	gf_ge202_envia_email_padrao(247, str)
End If

Return True 
end function

on uo_ge162_desbloquear_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge162_desbloquear_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

