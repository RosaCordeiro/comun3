HA$PBExportHeader$w_ge375_cad_alteracao_preco_venda.srw
forward
global type w_ge375_cad_alteracao_preco_venda from dc_w_response_ok_cancela
end type
type pb_1 from picturebutton within w_ge375_cad_alteracao_preco_venda
end type
type pb_2 from picturebutton within w_ge375_cad_alteracao_preco_venda
end type
end forward

global type w_ge375_cad_alteracao_preco_venda from dc_w_response_ok_cancela
integer width = 2153
integer height = 656
string title = "GE375 - Cadastro Altera$$HEX2$$e700e300$$ENDHEX$$o Pre$$HEX1$$e700$$ENDHEX$$o Venda"
pb_1 pb_1
pb_2 pb_2
end type
global w_ge375_cad_alteracao_preco_venda w_ge375_cad_alteracao_preco_venda

type variables
uo_Fornecedor io_Fornecedor
end variables

forward prototypes
public function boolean wf_proximo_c$$HEX1$$f300$$ENDHEX$$digo (ref long al_codigo)
end prototypes

public function boolean wf_proximo_c$$HEX1$$f300$$ENDHEX$$digo (ref long al_codigo);
Select coalesce( max(nr_alteracao) + 1 , 1 )
	into :al_Codigo
From alteracao_preco_venda
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo sequencial. " + SqlCa.SqlErrText)
End If

Return (SqlCa.SqlCode = 0)

end function

on w_ge375_cad_alteracao_preco_venda.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
end on

on w_ge375_cad_alteracao_preco_venda.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.pb_2)
end on

event ue_postopen;call super::ue_postopen;io_Fornecedor = CReate uo_Fornecedor
end event

event close;call super::close;Destroy io_Fornecedor
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge375_cad_alteracao_preco_venda
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge375_cad_alteracao_preco_venda
integer width = 2094
integer height = 420
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge375_cad_alteracao_preco_venda
integer y = 72
integer width = 2007
integer height = 324
string dataobject = "dw_ge375_lista_cadastro"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Fornecedor.nm_Fantasia Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.cd_fornecedor_faturamento	[1] = io_Fornecedor.cd_Fornecedor
			This.Object.nm_Fantasia						[1] = io_Fornecedor.nm_Fantasia
		End If
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then

		io_Fornecedor.of_Localiza_Fornecedor( This.GetText() )

		If io_Fornecedor.Localizado Then
			This.Object.cd_fornecedor_faturamento	[1] = io_Fornecedor.cd_Fornecedor
			This.Object.nm_Fantasia						[1] = io_Fornecedor.nm_Fantasia			
		End If
		
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge375_cad_alteracao_preco_venda
boolean visible = false
integer x = 27
integer y = 640
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge375_cad_alteracao_preco_venda
boolean visible = false
integer x = 361
integer y = 640
end type

type pb_1 from picturebutton within w_ge375_cad_alteracao_preco_venda
integer x = 1678
integer y = 448
integer width = 439
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_cancelar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type pb_2 from picturebutton within w_ge375_cad_alteracao_preco_venda
integer x = 1198
integer y = 448
integer width = 462
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar_desabilitado.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_Descricao, ls_Fornecedor, ls_Matricula
long ll_Codigo
dateTime ldh_Parametro

dw_1.AcceptText()

ls_Descricao 	= dw_1.Object.de_alteracao					[ 1 ] 
ls_Fornecedor 	= dw_1.Object.cd_fornecedor_faturamento	[ 1 ] 
ldh_Parametro	= gf_GetServerDate()
ls_Matricula		= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

If IsNull(ls_Descricao) Or Trim(ls_Descricao) = "" Then
	MessageBOx("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a descri$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_pos(1,'de_alteracao')
	Return
End If

If IsNull(ls_Fornecedor) Then
	MessageBOx("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o fornecedor.")
	dw_1.Event ue_pos(1,'nm_fantasia')
	Return
End If


If Not wf_Proximo_C$$HEX1$$f300$$ENDHEX$$digo(Ref ll_Codigo) Then Return

Insert into alteracao_preco_venda
		(nr_alteracao,
		de_alteracao,
		cd_fornecedor_faturamento,
		dh_inclusao,
		nr_matricula_inclusao,
		id_situacao)
Values
	(:ll_Codigo,
	:ls_Descricao,
	:ls_Fornecedor,
	:ldh_Parametro,
	:ls_Matricula,
	'P')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_Rollback()
	SqlCa.of_msgDbError("Erro ao inserir um novo registro. " + SqlCa.SqlErrText )
	Return
End If

SqlCa.of_Commit()

CloseWithReturn( Parent, ll_Codigo )



end event

