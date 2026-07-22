HA$PBExportHeader$w_ge362_cadastra_desconto.srw
forward
global type w_ge362_cadastra_desconto from dc_w_response_ok_cancela
end type
end forward

global type w_ge362_cadastra_desconto from dc_w_response_ok_cancela
integer width = 2094
integer height = 664
string title = "GE362 - Cadastra Desconto"
end type
global w_ge362_cadastra_desconto w_ge362_cadastra_desconto

type variables
uo_promocao io_Promocao //ge065

String is_Tipo
String lvs_Cd_promocao_sap
end variables

forward prototypes
public function boolean wf_grava_informacao ()
end prototypes

public function boolean wf_grava_informacao ();Decimal ldc_Desconto
Decimal ldc_Desconto_Anterior

Long ll_Promocao
Long ll_Achou

String ls_Cd_Grupo
String ls_De_Grupo
String ls_Lei_Generico
String ls_De_Lei_Generico
String ls_Promocao
String ls_Erro
String ls_Chave
String ls_Valor_De
String ls_Operador
String ls_Nulo

dw_1.AcceptText()

SetNull(ls_Nulo)

ll_Promocao					= dw_1.Object.Cd_Promocao_Sos		[1]
ls_Promocao				= dw_1.Object.Nm_Promocao_Sos	[1]
ls_Cd_Grupo				= dw_1.Object.Cd_Grupo				[1]
ls_De_Grupo				= dw_1.Object.De_Grupo				[1]
ls_Lei_Generico				= dw_1.Object.Id_Lei_Generico		[1]
ldc_Desconto				= dw_1.Object.Pc_Desconto				[1]
ldc_Desconto_Anterior	= dw_1.Object.Pc_Desconto_Anterior	[1]

Choose Case ls_Lei_Generico
	Case "E"
		ls_De_Lei_Generico = "EQUIVALENTE"
	Case "G"
		ls_De_Lei_Generico = "GEN$$HEX1$$c900$$ENDHEX$$RICO"
	Case "R"
		ls_De_Lei_Generico = "REFER$$HEX1$$ca00$$ENDHEX$$NCIA"
	Case "S"
		ls_De_Lei_Generico = "SIMILAR"
	Case "O"
		ls_De_Lei_Generico = "OUTROS"
End Choose

Choose Case is_Tipo
	Case "I"
	
		Select Count(*)
			Into :ll_Achou
		From promocao_sos_produto_novo
		Where cd_grupo = :ls_Cd_Grupo
			And cd_promocao_sos = :ll_Promocao
			And id_lei_generico = :ls_Lei_Generico
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a tabela se a promo$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrada.", StopSign!)
			Return False
		End If
		
		If ll_Achou > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Promo$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Promocao + " (" + String(ll_Promocao) + ")' j$$HEX1$$e100$$ENDHEX$$ cadastrada para: " + &
											"~rGrupo: " + ls_De_Grupo + &
											"~rLei Gen$$HEX1$$e900$$ENDHEX$$rico: " + ls_De_Lei_Generico, Exclamation!)
			Return False
		End If
		
		Insert Into promocao_sos_produto_novo(cd_grupo, cd_promocao_sos, id_lei_generico, pc_desconto)
			Values(:ls_Cd_Grupo, :ll_Promocao, :ls_Lei_Generico, :ldc_Desconto)
		Using SqlCa;
		
	Case "A"
		
		Update promocao_sos_produto_novo
			Set pc_desconto = :ldc_Desconto
		Where cd_grupo = :ls_Cd_Grupo
			And cd_promocao_sos = :ll_Promocao
			And id_lei_generico = :ls_Lei_Generico
		Using SqlCa;
		
	Case "E"
		
		Delete From promocao_sos_produto_novo
		Where cd_grupo = :ls_Cd_Grupo
			And cd_promocao_sos = :ll_Promocao
			And id_lei_generico = :ls_Lei_Generico
		Using SqlCa;	
End Choose

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar a informa$$HEX2$$e700e300$$ENDHEX$$o. " + ls_Erro, StopSign!)
	Return False
End If
	
ls_Operador = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

ls_Chave = ls_Cd_Grupo + '@#!' + MidA(String(ll_Promocao) + Space(5), 1, 5) + '@#!' + ls_Lei_Generico

Choose Case is_Tipo
	Case "I"		
		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO_NOVO', ls_Chave, 'PC_DESCONTO', ls_Nulo, String(ldc_Desconto), ls_Operador, is_Tipo, Ref ls_Erro,True) Then Return False
		
	Case "A"		
		If ldc_Desconto_Anterior <> ldc_Desconto Then
			If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO_NOVO', ls_Chave, 'PC_DESCONTO', String(ldc_Desconto_Anterior), String(ldc_Desconto), ls_Operador, is_Tipo, Ref ls_Erro,True) Then Return False
		End If
		
	Case "E"		
		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO_NOVO', ls_Chave, 'PC_DESCONTO', String(ldc_Desconto), ls_Nulo, ls_Operador, is_Tipo, Ref ls_Erro,True) Then Return False		
End Choose

SqlCa.of_Commit();

Return True
end function

on w_ge362_cadastra_desconto.create
call super::create
end on

on w_ge362_cadastra_desconto.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;st_parametros_promocao str

str = Message.PowerObjectParm

io_Promocao.ivs_Tipo = "N"

dw_1.AcceptText()

is_Tipo = str.Id_Tipo

If is_Tipo = "A" Or is_Tipo = "E" Then //Altera$$HEX2$$e700e300$$ENDHEX$$o Ou Exclus$$HEX1$$e300$$ENDHEX$$o
	
	dw_1.Object.Cd_Promocao_Sos		[1] = str.Cd_Promocao_Sos
	dw_1.Object.Nm_Promocao_Sos		[1] = str.Nm_Promocao_Sos
	dw_1.Object.Cd_Grupo					[1] = str.Cd_Grupo
	dw_1.Object.De_Grupo					[1] = str.De_Grupo
	dw_1.Object.Id_Lei_Generico			[1] = str.Id_Lei_Generico
	dw_1.Object.Pc_Desconto				[1] = str.Pc_Desconto
	dw_1.Object.Pc_Desconto_Anterior	[1] = str.Pc_Desconto
	
	dw_1.SetTabOrder('nm_promocao_sos', 0)
	dw_1.SetTabOrder('id_lei_generico', 0)
	
	If is_Tipo = "E" Then
		dw_1.SetTabOrder('pc_desconto', 0)
		dw_1.Object.Acao.Text = "EXCLUIR"
	Else
		dw_1.Object.Acao.Text = "ALTERAR"
	End If
	
Else
	
	dw_1.Object.Cd_Grupo			[1] = "1"
	dw_1.Object.De_Grupo			[1] = "MEDICAMENTO"
	dw_1.Object.Id_Lei_Generico	[1] = "E"
	
	dw_1.SetTabOrder('nm_promocao_sos', 1)
	dw_1.SetTabOrder('id_lei_generico', 2)
	
	dw_1.Object.Acao.Text = "INCLUIR"
End If
end event

event ue_preopen;call super::ue_preopen;io_Promocao = Create uo_promocao
end event

event close;call super::close;Destroy(io_Promocao)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge362_cadastra_desconto
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge362_cadastra_desconto
integer width = 2011
integer height = 424
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge362_cadastra_desconto
integer width = 1952
integer height = 332
string dataobject = "dw_ge362_lista_response"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_promocao_sos" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Promocao.Nm_Promocao Then
			Return 1
		End If
	Else
		io_Promocao.of_Inicializa()
		
		// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap (io_Promocao.Cd_Promocao   ,  lvs_Cd_promocao_sap ) Then 
	 	    If 	Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				Return 
			End If 
		End If 		
		
		This.Object.Cd_Promocao_Sos	[1]	= io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1]	= io_Promocao.Nm_Promocao
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "nm_promocao_sos" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Promocao.Nm_Promocao Then
			Return 1
		End If
	Else
		io_Promocao.of_Inicializa()
				
		// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap (io_Promocao.Cd_Promocao   ,  lvs_Cd_promocao_sap ) Then 
	 	    If 	Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				Return 
			End If 
		End If 
		
		This.Object.Cd_Promocao_Sos	[1]	= io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1]	= io_Promocao.Nm_Promocao
	End If
End If


end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_promocao_sos" Then
		
		io_Promocao.of_Localiza(This.GetText())
			
		If Not io_Promocao.Localizado Then
			io_Promocao.of_Inicializa()
		End If		
	
		// Verifica se foi cadastrada no SAP. Caso sim, n$$HEX1$$e300$$ENDHEX$$o permite operacao para a promocao no legado.
		If gf_promocao_sap ( io_Promocao.Cd_Promocao   ,  lvs_Cd_promocao_sap ) Then 
	 	    If 	Long(lvs_Cd_promocao_sap) > 0  Then 					
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(io_Promocao.Cd_Promocao) + "' foi cadastrada no SAP." + &
							"~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel altera$$HEX2$$e700e300$$ENDHEX$$o neste sistema, somente no SAP.", Exclamation!)					
				Return
			End If 
		End If 		
		
		This.Object.Cd_Promocao_Sos	[1] = io_Promocao.Cd_Promocao
		This.Object.Nm_Promocao_Sos[1] = io_Promocao.Nm_Promocao
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge362_cadastra_desconto
integer x = 1385
integer y = 452
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Decimal ldc_Desconto

Long ll_Promocao

dw_1.AcceptText()

If is_Tipo = "A" Or is_Tipo = "I" Then

	ll_Promocao		= dw_1.Object.Cd_Promocao_Sos	[1]
	ldc_Desconto	= dw_1.Object.Pc_Desconto			[1]
	
	If IsNull(ll_Promocao) Or ll_Promocao = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a promo$$HEX2$$e700e300$$ENDHEX$$o.")
		dw_1.Event ue_Pos(1, "cd_promocao_sos")
		Return -1
	End If
	
	If IsNull(ldc_Desconto) Or ldc_Desconto <= 0.00 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um desconto v$$HEX1$$e100$$ENDHEX$$lido.")
		dw_1.Event ue_Pos(1, "pc_desconto")
		Return -1
	End If
	
	If ldc_Desconto > 50.00 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O percentual informado n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que 50 (%).")
		dw_1.Event ue_Pos(1, "pc_desconto")
		Return -1
	End If
	
Else
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o do registro de desconto para produtos novos?", Question!, YesNo!, 2) = 2 Then Return -1
End If

If Not wf_Grava_Informacao() Then Return -1

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge362_cadastra_desconto
integer x = 1719
integer y = 452
end type

