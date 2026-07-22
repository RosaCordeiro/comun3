HA$PBExportHeader$w_ge390_habilita_uf.srw
forward
global type w_ge390_habilita_uf from dc_w_response_ok_cancela
end type
end forward

global type w_ge390_habilita_uf from dc_w_response_ok_cancela
integer width = 1225
integer height = 1344
string title = "GE390 - Habilita e Desabilita UF"
end type
global w_ge390_habilita_uf w_ge390_habilita_uf

forward prototypes
public function boolean wf_habilita_desabilita_uf (string as_uf, string as_id_pedido_exclusivo, ref string as_msg)
end prototypes

public function boolean wf_habilita_desabilita_uf (string as_uf, string as_id_pedido_exclusivo, ref string as_msg);String ls_Exclusivo
String ls_Erro

Update unidade_federacao
	Set id_pedido_exclusivo_falta = :as_id_pedido_exclusivo
Where cd_unidade_federacao = :as_uf
Using SqlCa;
			
If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o 'id_pedido_exclusivo_falta' na tabela unidade_federacao. " + ls_Erro, StopSign!)
	Return False
End If
			
	If Not gf_grava_historico_alteracao_tabela('UNIDADE_FEDERACAO',as_uf+'/' + as_id_pedido_exclusivo , 'ID_PEDIDO_EXCLUSIVO_FALTA', 'N', 'S', gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Erro, True) Then Return False

Return True
end function

on w_ge390_habilita_uf.create
call super::create
end on

on w_ge390_habilita_uf.destroy
call super::destroy
end on

event open;call super::open;
//DAR RETRIEVE NA TELA ASSIM QUE ABRIR */
String ls_Matricula

ls_Matricula                = gvo_Aplicacao.ivo_Seguranca.nr_matricula
	
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE390_HABILITA_DESABILITA_UF", ref ls_Matricula) Then 
	dw_1.Modify("id_pedido_exclusivo_falta.Protect = '1'")
End If

dw_1.Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge390_habilita_uf
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge390_habilita_uf
integer width = 1184
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge390_habilita_uf
integer width = 1106
string dataobject = "dw_ge390_lista_uf_habilitada"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge390_habilita_uf
integer x = 453
integer y = 1148
end type

event cb_ok::clicked;call super::clicked;Long ll_Linhas
Long ll_Linha

String ls_UF
String ls_id_pedido_exclusivo
String ls_msg

dwItemStatus lds_Status

dw_1.AcceptText()

ll_Linhas = dw_1.RowCount()

For ll_Linha = 1 to ll_Linhas

	lds_Status = dw_1.GetItemStatus(ll_Linha, 0, Primary!)
	
	If lds_Status = DataModified! OR lds_Status = NewModified! THEN
		
		ls_UF							= dw_1.Object.cd_unidade_federacao		[ll_Linha]
		ls_id_pedido_exclusivo	= dw_1.Object.id_pedido_exclusivo_falta	[ll_Linha]
		
		If Not  wf_habilita_desabilita_uf(ls_uf,ls_id_pedido_exclusivo,ls_msg) Then
			Return 0
		Else 
			SqlCa.of_Commit();
		End if
			
	End if
Next

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700e300$$ENDHEX$$o realizadas com sucesso!")
CloseWithReturn(Parent, "OK")
				


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge390_habilita_uf
integer x = 786
integer y = 1148
end type

