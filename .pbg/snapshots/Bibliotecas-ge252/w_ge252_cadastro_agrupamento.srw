HA$PBExportHeader$w_ge252_cadastro_agrupamento.srw
forward
global type w_ge252_cadastro_agrupamento from dc_w_response_ok_cancela
end type
end forward

global type w_ge252_cadastro_agrupamento from dc_w_response_ok_cancela
integer width = 1998
integer height = 856
string title = "GE252 - Cadastro de Agrupamento de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compras"
boolean controlmenu = true
long backcolor = 80269524
end type
global w_ge252_cadastro_agrupamento w_ge252_cadastro_agrupamento

type variables
uo_fornecedor ivo_forn
uo_parametro_geral ivo_parametro_geral
uo_usuario io_Usuario

long ivl_Agrupamento

Boolean	lb_Divisao_Fornecedor	 = False
end variables

forward prototypes
public function boolean wf_verifica_tipo_produto_agrupamento (long al_agrupamento)
public function boolean wf_verifica_fornecedor_produto ()
public function boolean wf_notas_outro_fornecedor (long al_agrupamento, string as_fornecedor, ref boolean ab_erro)
public function boolean wf_divisao_fornecedor (string as_fornecedor)
end prototypes

public function boolean wf_verifica_tipo_produto_agrupamento (long al_agrupamento);String ls_Tipo
Long ll_Qtde

dw_1.AcceptText()

ls_Tipo = dw_1.object.id_tipo[1]

Choose Case ls_Tipo
	Case "1" //Controlados
		select count(*)
		Into :ll_Qtde
		from agrupamento_dev_compra_prd a
		inner join produto_geral b on b.cd_produto = a.cd_produto
		where nr_agrupamento  = :al_Agrupamento
		and b.cd_grupo_psico is null
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de produto n$$HEX1$$e300$$ENDHEX$$o controlado.")
			Return False
		End If
		
		If ll_Qtde > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse agrupamento n$$HEX1$$e300$$ENDHEX$$o pode ser do tipo CONTROLADO.~rJ$$HEX1$$e100$$ENDHEX$$ tem produto que n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ controlado cadastrado para ele.")
			Return False
		End If
	Case "2"//N$$HEX1$$e300$$ENDHEX$$o controlados
		select count(*)
		Into :ll_Qtde
		from agrupamento_dev_compra_prd a
		inner join produto_geral b on b.cd_produto = a.cd_produto
		where nr_agrupamento  = :al_Agrupamento
		and b.cd_grupo_psico is not null
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de produto controlado.")
			Return False
		End If
		
		If ll_Qtde > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse agrupamento n$$HEX1$$e300$$ENDHEX$$o pode ser do tipo N$$HEX1$$c300$$ENDHEX$$O CONTROLADO.~rJ$$HEX1$$e100$$ENDHEX$$ tem produto controlado cadastrado para ele.")
			Return False
		End If
		
End Choose


Return True
end function

public function boolean wf_verifica_fornecedor_produto ();Long ll_Qtde
String 	ls_Fornecedor,&
			ls_Fornecedor_Select,&
			ls_Matricula,&
			ls_Razao_Social
Boolean lb_Erro			

Select count(*)
Into :ll_Qtde
FROM agrupamento_dev_compra_prd 
WHERE nr_agrupamento = :ivl_Agrupamento    
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de produto no agrupamento.")
	Return False
End If

If ll_Qtde > 0 Then
	
	dw_1.AcceptText()
	ls_Fornecedor 		= dw_1.object.cd_fornecedor[1]
	ls_Razao_Social	= dw_1.object.nm_razao_social[1]
	
	Select cd_fornecedor
	Into :ls_Fornecedor_Select
	FROM agrupamento_dev_compra
	WHERE nr_agrupamento = :ivl_Agrupamento    
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de produto no agrupamento.")
		Return False
	End If
	
	If ls_Fornecedor <> ls_Fornecedor_Select Then
		If wf_Notas_Outro_Fornecedor(ivl_Agrupamento, ls_Fornecedor, Ref lb_Erro) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O fornecedor n$$HEX1$$e300$$ENDHEX$$o pode ser alterado, existem produtos com notas de origem diferente do fornecedor ("+ls_Fornecedor+") "+ls_Razao_Social+".")
			Return False
		Else
			If lb_Erro Then Return False
			
			If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE252_ALTERAR_FORNECEDOR_AGRUPAMENTO", ref ls_Matricula) Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o tem permiss$$HEX1$$e300$$ENDHEX$$o para alterar o fornecedor do agrupamento quando h$$HEX1$$e100$$ENDHEX$$ produtos no agrupamento.")
				Return False
			End If
		End If
	End If
	
End If

Return True
end function

public function boolean wf_notas_outro_fornecedor (long al_agrupamento, string as_fornecedor, ref boolean ab_erro);Long ll_Qtde

ab_Erro = False

SELECT 	count(*)
Into :ll_Qtde
FROM agrupamento_dev_compra_prd_nf 
WHERE nr_agrupamento = :al_Agrupamento  
and cd_fornecedor <> :as_Fornecedor
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ab_Erro = True
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das notas do agrupamento.")
	Return False
End If

If ll_Qtde > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_divisao_fornecedor (string as_fornecedor);Long	ll_Linhas

DataWindowChild lvdwc

If dw_1.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then	
	If lvdwc.settransobject( SqlCa) <> 1 Then
		MessageBox("Erro", "Erro no 'settransobject' da coluna 'nr_divisao_fornecedor'.")
		Return False
	End If
	
	lvdwc.setsqlselect(	"Select '' as de_divisao, "+&
							" 0 nr_divisao "+&
							" union "+&
							" SELECT 	cast(f.nr_divisao as varchar) + ' - ' + f.nm_divisao de_divisao,"+&
							"				f.nr_divisao "+&
							" FROM fornecedor_divisao f"+&
							" WHERE f.cd_fornecedor = '"+as_Fornecedor+"'"+&
							" ORDER BY nr_divisao")
	
	ll_Linhas	=  lvdwc.retrieve( )
	
	If IsNull(ivl_Agrupamento) Then	
		If ll_Linhas	> 1 Then	//Maior do que 1 porque tem o union no SQL, sempre vai trazer um registro
			lb_Divisao_Fornecedor	= True
			dw_1.Object.nr_divisao_fornecedor.Protect = 0
			dw_1.Modify("nr_divisao_fornecedor.background.color='16777215'")
		Else
			lb_Divisao_Fornecedor	= False
			dw_1.Object.nr_divisao_fornecedor.Protect = 1
			dw_1.Modify("nr_divisao_fornecedor.background.color='67108864'")				
		End If
		
		dw_1.Object.nr_divisao_fornecedor[1] = 0
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da Divis$$HEX1$$e300$$ENDHEX$$o do Fornecedor.")
End If


Return True
end function

on w_ge252_cadastro_agrupamento.create
call super::create
end on

on w_ge252_cadastro_agrupamento.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

If Not IsNull(ivl_Agrupamento) Then
	dw_1.Object.id_destino_final.protect		= true
	dw_1.Object.nm_razao_social.protect	= true
	dw_1.Object.nm_comprador.protect		= true
	
	dw_1.Modify("nm_razao_social.background.color='67108864'")
	dw_1.Modify("cd_fornecedor.background.color='67108864'")
	dw_1.Modify("nm_comprador.background.color='67108864'")
	dw_1.Modify("nr_matricula_comprador.background.color='67108864'")

	dw_1.Retrieve(ivl_Agrupamento)
	
	If Not wf_Divisao_Fornecedor(dw_1.Object.cd_fornecedor[1]) Then
		Close(This)
		Return
	End If
End If
end event

event close;call super::close;Destroy(ivo_Forn)
Destroy(ivo_Parametro_Geral)
Destroy(io_Usuario)
end event

event open;call super::open;ivl_Agrupamento = Message.DoubleParm

ivo_forn            		= Create uo_Fornecedor
ivo_parametro_geral 	= Create uo_Parametro_Geral
io_Usuario				= Create uo_usuario


end event

event ue_save;call super::ue_save;If AncestorReturnValue <> -1 Then
	Close(This)
End If

Return AncestorReturnValue
end event

event closequery;//OverRide

If KeyDown(KeyF4!) Then 
	Return 1
End If

If Not ivb_Valida_Salva Then Return 0

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja fechar sem salvar?", Question!, YesNo!, 2) = 1 Then
	Return 0 
Else
	Return 1
End If

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge252_cadastro_agrupamento
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge252_cadastro_agrupamento
integer y = 0
integer width = 1934
integer height = 640
integer weight = 700
string facename = "Verdana"
long backcolor = 80269524
string text = "Agrupamento"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge252_cadastro_agrupamento
integer x = 46
integer y = 64
integer width = 1902
integer height = 564
string dataobject = "dw_ge252_manutencao_agrupamento"
end type

event dw_1::ue_key;String lvs_Nulo
Long ll_Nulo

If key = KeyEnter! Then
	SetNull(ll_Nulo)
	SetNull(lvs_Nulo)
	
	Choose Case This.GetColumnName()
		Case 'nm_razao_social'		
			ivo_Forn.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Forn.Localizado Then
				This.Object.cd_fornecedor		[1] = ivo_Forn.cd_fornecedor
				This.Object.nm_razao_social	[1] = ivo_Forn.nm_razao_social
				
				If Not wf_Divisao_Fornecedor(ivo_Forn.cd_fornecedor) Then
					Return -1
				End If
			Else
				This.Object.cd_fornecedor				[1] = lvs_Nulo
				This.Object.nm_razao_social			[1] = lvs_Nulo
				This.Object.nr_divisao_fornecedor		[1] = ll_Nulo
				cb_ok.Enabled = False
			End If
			
		Case 'nm_comprador'
			io_Usuario.of_Localiza_Usuario(This.GetText())
			
			If io_Usuario.Localizado Then
				This.Object.nr_matricula_comprador	[1] = io_Usuario.nr_matricula
				This.Object.nm_comprador				[1] = io_Usuario.nm_usuario
			Else
				This.Object.nr_matricula_comprador	[1] = lvs_Nulo
				This.Object.nm_comprador				[1] = lvs_Nulo
				cb_ok.Enabled = False
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Long	ll_Nulo

SetNull(ll_Nulo)

cb_ok.Enabled = True

Choose Case This.GetColumnName() 
	Case 'nm_razao_social'
		If Not IsNull(data) and data <> "" Then
			If data <> ivo_Forn.nm_razao_social Then
				Return 1
			End If
		Else
			This.Object.nr_divisao_fornecedor.Protect = 1
			This.Modify("nr_divisao_fornecedor.background.color='67108864'")
			This.Object.nr_divisao_fornecedor[1] = ll_Nulo
			
			This.Object.cd_fornecedor  				[1] = ""
			This.Object.nm_razao_social			[1] = ""
			This.Object.nr_divisao_fornecedor		[1] = ll_Nulo
		End If
		
	Case 'nm_comprador'
		If Not IsNull(data) and data <> "" Then
			If data <> io_Usuario.nm_Usuario Then
				Return 1
			End If
		Else
			This.Object.nr_matricula_comprador	[1] = ""
			This.Object.nm_Comprador				[1] = ""
		End If
End Choose




end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long	ll_Agrupamento,&
		ll_Motivo,&
		ll_Divisao_Fornecedor,&
		ll_Nulo

String 	lvs_Fornecedor,&
			ls_Destino_Final

This.AcceptText()

SetNull(ll_Nulo)

ll_Agrupamento 		= This.Object.nr_agrupamento     		[1]
lvs_Fornecedor  		= This.Object.cd_fornecedor			[1]
ll_Motivo			 		= This.Object.cd_motivo_devolucao	[1]
ls_Destino_Final		= This.Object.id_destino_final			[1]
ll_Divisao_Fornecedor	= This.Object.nr_divisao_fornecedor	[1]

If IsNull(lvs_Fornecedor) or lvs_Fornecedor = "" Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor.", Information!)
	This.SetFocus()
	This.Event ue_Pos(1, 'nm_razao_social')
	cb_ok.Enabled = False
	Return -1
End If

If lb_Divisao_Fornecedor Then
	If IsNull(ll_Divisao_Fornecedor) or (ll_Divisao_Fornecedor < 1) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor.", Information!)
		This.SetFocus()
		This.Event ue_Pos(1, 'nr_divisao_fornecedor')
		cb_ok.Enabled = False
		Return -1
	End If
Else
	This.Object.nr_divisao_fornecedor	[1]	= ll_Nulo
End If

If IsNull( ll_Motivo ) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da devolu$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	This.SetFocus()
	This.Event ue_Pos(1, 'cd_motivo_devolucao')
	cb_ok.Enabled = False
	Return -1
End If

If ls_Destino_Final = 'X' Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o destino final.", Information!)
	This.SetFocus()
	This.Event ue_Pos(1, 'id_destino_final')
	cb_ok.Enabled = False
	Return -1
End If

If IsNull(ll_Agrupamento) Then
	If Not ivo_Parametro_Geral.of_Proximo_Sequencial("NR_ULTIMO_AGRUPAMENTO_DEVOLUCAO", Ref ll_Agrupamento) Then
		Return -1
	Else
		This.Object.nr_agrupamento[1] = ll_Agrupamento
	End If
End If

This.Object.dh_Inclusao          			[1] = gvo_Parametro.of_DH_Movimentacao()
This.Object.nr_matricula_inclusao 	[1] = gvo_Aplicacao.ivo_Seguranca.nr_matricula
This.Object.vl_agrupamento             	[1] = 0.00
This.Object.id_situacao	              	[1] = 'A'

Return 1

end event

event dw_1::editchanged;call super::editchanged;Long	ll_Nulo

cb_ok.Enabled = True



end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge252_cadastro_agrupamento
integer x = 1221
integer y = 656
integer width = 357
boolean enabled = false
string text = "&Confirmar"
boolean default = false
end type

event cb_ok::clicked;dw_1.AcceptText()

If Not IsNull(ivl_Agrupamento) Then
	If Not wf_Verifica_Tipo_Produto_Agrupamento(ivl_Agrupamento) Then
		Return 1
	End If
	
	If Not wf_verifica_fornecedor_produto() Then
		Return 1
	End If
End If

Parent.Event ue_Save()


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge252_cadastro_agrupamento
integer x = 1595
integer y = 656
integer width = 357
end type

