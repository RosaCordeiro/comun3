HA$PBExportHeader$w_ge187_cadastro_conta_fluxo_caixa.srw
forward
global type w_ge187_cadastro_conta_fluxo_caixa from dc_w_cadastro_freeform
end type
type gb_2 from groupbox within w_ge187_cadastro_conta_fluxo_caixa
end type
type dw_2 from dc_uo_dw_base within w_ge187_cadastro_conta_fluxo_caixa
end type
end forward

global type w_ge187_cadastro_conta_fluxo_caixa from dc_w_cadastro_freeform
integer width = 5966
integer height = 1168
string title = "GE187 - Cadastro de Contas de Fluxo de Caixa"
boolean resizable = false
gb_2 gb_2
dw_2 dw_2
end type
global w_ge187_cadastro_conta_fluxo_caixa w_ge187_cadastro_conta_fluxo_caixa

type variables
uo_filial 						ivo_filial						//GE009
uo_conta_fluxo_caixa 	ivo_conta					//GE187
uo_tipo_numerario_sap	ivo_numerario_sap		//GE187
end variables

forward prototypes
public function boolean wf_ultimo_codigo (ref long al_codigo)
public subroutine wf_altera_tipo_conta (string ps_tipo)
end prototypes

public function boolean wf_ultimo_codigo (ref long al_codigo);Boolean lvb_Sucesso = False

Select max(cd_conta_fluxo_caixa) Into :al_Codigo
From conta_fluxo_caixa
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_Codigo) Then al_Codigo = 0
		
		lvb_Sucesso = True
	Case 100
		al_Codigo = 0
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo C$$HEX1$$f300$$ENDHEX$$digo")
End Choose

Return lvb_Sucesso
end function

public subroutine wf_altera_tipo_conta (string ps_tipo);If ps_tipo = "C" or ps_tipo = "B" Then
	This.Width = 5957
	//dw_2.Of_Set_Somente_Leitura( False )
Else
	string lvs_null
	setnull(lvs_null)
	this.dw_1.setitem( 1, 'cd_tipo_conta',lvs_null )
	This.Width = 2000
	//dw_2.Of_Set_Somente_Leitura( True )
End If
end subroutine

on w_ge187_cadastro_conta_fluxo_caixa.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_2
end on

on w_ge187_cadastro_conta_fluxo_caixa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.dw_2)
end on

event open;call super::open;ivo_Filial					= Create uo_Filial
ivo_Conta				= Create uo_Conta_Fluxo_Caixa
ivo_numerario_sap	= Create uo_tipo_numerario_sap
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Conta)
If IsValid(ivo_numerario_sap) Then Destroy(ivo_numerario_sap)
end event

event ue_saveas;call super::ue_saveas;String lvs_Arquivo

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge187_excel") Then Return

SetPointer(HourGlass!)

If lvds_1.Retrieve() > 0 Then
	lvs_Arquivo = "c:\sistemas\cr\arquivos\conta_fluxo_caixa.xls"
	
	lvds_1.of_SaveAs(lvs_Arquivo)
	
End If

SetPointer(Arrow!)
end event

event ue_preopen;call super::ue_preopen;ivb_grava_log = True
end event

event ue_presave;call super::ue_presave;String lvs_Exporta_SAP
String lvs_Tipo_Conta
String lvs_Conta_SAP
String lvs_Tipo_Numerario_SAP, lvs_cd_conta_contabil_sap, lvs_id_credito_debito, lvs_id_credito_debito_num, lvs_id_tipo_taxa

Long lvl_Linha
Long lvl_Conta_Fluxo
Long lvl_Find

Decimal{4} lvdc_PC_Debito
Decimal{4} lvdc_PC_Cred_Avista
Decimal{4} lvdc_PC_Cred_2
Decimal{4} lvdc_PC_Cred_3
Decimal{4} lvdc_PC_Cred_4
Decimal{4} lvdc_PC_Cred_5
Decimal{4} lvdc_PC_Cred_6
Decimal{4} lvdc_PC_Fund_Emerg

Datetime lvdh_Inicio

DWItemStatus lvdw_Status

dw_1.Accepttext( )
dw_2.Accepttext( )

lvs_Exporta_SAP				= dw_1.Object.id_exporta_sap				[1]
lvs_Tipo_Conta					= dw_1.Object.id_tipo_conta				[1]
lvs_Conta_SAP					= dw_1.Object.cd_conta_sap				[1]
lvs_Tipo_Numerario_SAP	= dw_1.Object.cd_tipo_numerario_sap	[1]
lvs_cd_conta_contabil_sap	= dw_1.Object.cd_conta_contabil_sap	[1]
lvs_id_credito_debito_num	= dw_1.Object.id_credito_debito_num	[1]
lvs_id_credito_debito			= dw_1.Object.id_credito_debito			[1]

If lvs_Exporta_SAP = "S" Then
	If IsNull(lvs_Conta_SAP) or (Trim(lvs_Conta_SAP)="") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta conta est$$HEX1$$e100$$ENDHEX$$ marcada para exportar SAP e para tanto precisa que seja informada a conta cont$$HEX1$$e100$$ENDHEX$$bil SAP.", Exclamation!)
		dw_1.Event ue_Pos(1, "cd_conta_sap")
		Return False
	End If
	
	If IsNull(lvs_Tipo_Numerario_SAP) or (Trim(lvs_Tipo_Numerario_SAP)="") Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Esta conta est$$HEX1$$e100$$ENDHEX$$ marcada para exportar SAP se for um numer$$HEX1$$e100$$ENDHEX$$rio precisa que seja informado o tipo de numer$$HEX1$$e100$$ENDHEX$$rio SAP.~n~nDeseja continuar sem informar o tipo de numer$$HEX1$$e100$$ENDHEX$$rio?", Exclamation!, YesNo!, 2) = 2 Then
			dw_1.Event ue_Pos(1, "de_tipo_numerario_sap")
			Return False
		End If
	End If
	
	if not (isnull(lvs_cd_conta_contabil_sap) or (Trim(lvs_cd_conta_contabil_sap)="")) Then
		if lvs_cd_conta_contabil_sap <> lvs_Conta_SAP then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Conta informada para exportar pro SAP est$$HEX1$$e100$$ENDHEX$$ diverg$$HEX1$$ea00$$ENDHEX$$nte da cadastrada no numer$$HEX1$$e100$$ENDHEX$$rio!")
			dw_1.Event ue_Pos(1, "cd_conta_sap")
			Return False
		end if
	end if
	
	if not (isnull(lvs_id_credito_debito_num) or (Trim(lvs_id_credito_debito_num)="")) Then
		if lvs_id_credito_debito_num <> lvs_id_credito_debito then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Identificador de cr$$HEX1$$e900$$ENDHEX$$dito e d$$HEX1$$e900$$ENDHEX$$bito est$$HEX1$$e100$$ENDHEX$$ diverg$$HEX1$$ea00$$ENDHEX$$nte entre a informada e a cadastrada no numer$$HEX1$$e100$$ENDHEX$$rio!")
			dw_1.Event ue_Pos(1, "id_credito_debito")
			Return False
		end if
	end if
	
End If

//Exclui linhas em branco
lvl_Find = dw_2.Find("IsNull(cd_conta_fluxo_caixa) and IsNull(cd_canal_venda)", 1, dw_2.RowCount())
Do While lvl_Find > 0
	dw_2.DeleteRow( lvl_Find )
	If dw_2.RowCount() > 0 Then
		lvl_Find = dw_2.Find("IsNull(cd_conta_fluxo_caixa) and IsNull(cd_canal_venda)", 1, dw_2.RowCount())
	Else
		lvl_Find = 0
	End If
Loop

//Apenas para contas do tipo cart$$HEX1$$e300$$ENDHEX$$o de cr$$HEX1$$e900$$ENDHEX$$dito e cart$$HEX1$$e300$$ENDHEX$$o d$$HEX1$$e900$$ENDHEX$$bito
If lvs_Tipo_Conta = "C" or lvs_Tipo_Conta = "B" Then
	If dw_2.RowCount() = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe ao menos uma taxa para este cart$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
		dw_2.Event ue_AddRow()
		dw_2.SetFocus()
		Return False		
	End If
	
	For lvl_Linha = 1 To dw_2.RowCount()
		
		lvdw_Status = dw_2.GetItemStatus(lvl_Linha,0,Primary!)
		If lvdw_Status = NotModified! Then Continue
		
		lvl_Conta_Fluxo			= dw_2.Object.cd_conta_fluxo_caixa			[lvl_Linha]	
		lvdh_Inicio				= dw_2.Object.dh_inicio							[lvl_Linha]
		lvdc_PC_Debito			= dw_2.Object.pc_comissao_debito			[lvl_Linha]
		lvdc_PC_Fund_Emerg	= dw_2.Object.pc_comissao_fundo_emerg	[lvl_Linha]
		lvdc_PC_Cred_Avista	= dw_2.Object.pc_comissao_credito_avista	[lvl_Linha]
		lvdc_PC_Cred_2		= dw_2.Object.pc_comissao_credito_2		[lvl_Linha]
		lvdc_PC_Cred_3		= dw_2.Object.pc_comissao_credito_3		[lvl_Linha]
		lvdc_PC_Cred_4		= dw_2.Object.pc_comissao_credito_4		[lvl_Linha]
		lvdc_PC_Cred_5		= dw_2.Object.pc_comissao_credito_5		[lvl_Linha]
		lvdc_PC_Cred_6		= dw_2.Object.pc_comissao_credito_6		[lvl_Linha]
		lvs_id_tipo_taxa		= dw_2.Object.id_tipo_taxa						[lvl_Linha]
		
		If IsNull(lvdc_PC_Debito) Then lvdc_PC_Debito = 0.00
		If IsNull(lvdc_PC_Fund_Emerg) Then lvdc_PC_Fund_Emerg = 0.00
		If IsNull(lvdc_PC_Cred_Avista) Then lvdc_PC_Cred_Avista = 0.00
		If IsNull(lvdc_PC_Cred_2) Then lvdc_PC_Cred_2 = 0.00
		If IsNull(lvdc_PC_Cred_3) Then lvdc_PC_Cred_3 = 0.00
		If IsNull(lvdc_PC_Cred_4) Then lvdc_PC_Cred_4 = 0.00
		If IsNull(lvdc_PC_Cred_5) Then lvdc_PC_Cred_5 = 0.00
		If IsNull(lvdc_PC_Cred_6) Then lvdc_PC_Cred_6 = 0.00
				
		If IsNull(lvdh_Inicio) or (Not lvdh_Inicio > datetime("2010/01/01")) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data v$$HEX1$$e100$$ENDHEX$$lida para in$$HEX1$$ed00$$ENDHEX$$cio da taxa de cart$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
			dw_2.Event ue_Pos(lvl_Linha, "dh_inicio")
			Return False
		End If
		
		If (lvdc_PC_Debito + lvdc_PC_Cred_Avista + lvdc_PC_Cred_2 + lvdc_PC_Fund_Emerg) = 0.00  Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe ao menos uma taxa para este cart$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
			dw_2.Event ue_Pos(lvl_Linha, "pc_comissao_credito_avista")
			Return False
		End If
		
		If dw_2.GetItemStatus(lvl_Linha, "dh_inicio",Primary!) <> NotModified! Then
			If lvdh_Inicio <= gf_GetServerDate() Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data in$$HEX1$$ed00$$ENDHEX$$cio deve ser sempre uma data futura.", Exclamation!)
				dw_2.Event ue_Pos(lvl_Linha, "dh_inicio")
				Return False
			End If
		End If
		
		if isnull(lvs_id_tipo_taxa) then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O preenchimento do tipo da taxa $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio!", Exclamation!)
			dw_2.Event ue_Pos(lvl_Linha, "id_tipo_taxa")
			Return False
		end if
		
	Next
End If

Return AncestorReturnValue
end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1, dw_2}
This.wf_SetUpdate_DW(lvo_Update)

This.ivm_Menu.mf_Incluir(True)
//This.ivm_Menu.mf_Recuperar(True)

wf_altera_tipo_conta('')
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge187_cadastro_conta_fluxo_caixa
integer x = 91
integer y = 1680
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge187_cadastro_conta_fluxo_caixa
integer x = 55
integer y = 1608
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge187_cadastro_conta_fluxo_caixa
integer x = 41
integer y = 48
integer width = 1879
integer height = 928
string dataobject = "dw_ge187_cadastro"
boolean vscrollbar = false
end type

event dw_1::constructor;call super::constructor;ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}
end event

event dw_1::ue_recuperar;// Override

Return This.Retrieve(ivo_Conta.Cd_Conta_Fluxo_Caixa)
end event

event dw_1::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_localizacao"
			ivo_Conta.of_Localiza_Conta(This.GetText())
			
			If ivo_Conta.Localizado Then
				//This.Object.Cd_Conta_Fluxo_Caixa[1] = ivo_Conta.Cd_Conta_Fluxo_Caixa
				This.Event ue_Retrieve()
			End If
			
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial_Contabil	[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial         		[1] = ivo_Filial.Nm_Fantasia
			End If
			
		Case "de_tipo_numerario_sap"
			ivo_numerario_sap.of_Localiza(This.GetText()) 
			
			If ivo_numerario_sap.localizado Then
				This.Object.cd_tipo_numerario_sap	[1] = ivo_numerario_sap.cd_tipo_numerario_sap
				This.Object.de_tipo_numerario_sap	[1] = ivo_numerario_sap.de_tipo_numerario_sap
				This.Object.cd_conta_contabil_sap	[1] = ivo_numerario_sap.cd_conta_contabil_sap
				This.Object.id_credito_debito_num	[1] = ivo_numerario_sap.id_credito_debito
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;
Choose Case dwo.Name
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_inicializa( )
			
			This.Object.Cd_Filial_Contabil	[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial         		[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "de_tipo_numerario_sap"
	
		If Trim(Data) <> "" Then
			If Data <> ivo_numerario_sap.de_tipo_numerario_sap Then
				Return 1
			End If
		Else
			ivo_numerario_sap.Of_inicializa( )
			
			This.Object.cd_tipo_numerario_sap	[1] = ivo_numerario_sap.cd_tipo_numerario_sap
			This.Object.de_tipo_numerario_sap	[1] = ivo_numerario_sap.de_tipo_numerario_sap
			This.Object.cd_conta_contabil_sap	[1] = ivo_numerario_sap.cd_conta_contabil_sap
			This.Object.id_credito_debito_num	[1] = ivo_numerario_sap.id_credito_debito
			
		End If
		
	Case "id_tipo_conta"	
		wf_altera_tipo_conta( Data )
		
		
End Choose
end event

event dw_1::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_numerario_sap) Then
	This.Object.de_tipo_numerario_sap[1] = ivo_numerario_sap.de_tipo_numerario_sap
End If

end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Long lvl_Filial

String lvs_Neces_Dig
String lvs_Tipo_Conta
String lvs_Tipo_Numerario

If pl_Linhas > 0 Then
	lvl_Filial 					= This.Object.Cd_Filial_Contabil			[1]
	lvs_Neces_Dig			= This.Object.id_necessita_anexo			[1]
	lvs_Tipo_Conta			= This.Object.id_tipo_conta					[1]
	lvs_Tipo_Numerario	= This.Object.cd_tipo_numerario_sap	[1]
	
	If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
		ivo_Filial.of_Localiza_Codigo(lvl_Filial)
	
		If ivo_Filial.Localizada Then
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
	Else
		ivo_Filial.Of_inicializa( )
	End If
	
	If lvs_Tipo_Numerario<>"" Then
		ivo_numerario_sap.Of_localiza_codigo(lvs_Tipo_Numerario)
	Else 
		ivo_numerario_sap.Of_Inicializa()
	End If
	
	If IsNull(lvs_Neces_Dig) Then		
		This.Object.id_necessita_anexo	[1] = "N"
	End If
	
	wf_altera_tipo_conta( lvs_Tipo_Conta )
End If

This.ivm_Menu.mf_SalvarComo( pl_Linhas > 0 )

dw_2.Post Event ue_Retrieve()

Return pl_Linhas
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long lvl_Codigo

If This.RowCount() > 0 Then
	If IsNull(This.Object.Cd_Conta_Fluxo_Caixa[1]) Then
		If Not wf_Ultimo_Codigo(ref lvl_Codigo) Then Return -1
		
		This.Object.Cd_Conta_Fluxo_Caixa[1] = lvl_Codigo + 1
	End If
End If

Return 1
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivo_Filial.Of_Inicializa()
End If

dw_2.Event ue_Cancel()

Return AncestorReturnValue
end event

event dw_1::ue_cancel;call super::ue_cancel;dw_2.Post Event ue_Cancel()
wf_altera_tipo_conta( '' )
end event

event dw_1::ue_reset;call super::ue_reset;dw_2.Post Event ue_Reset()
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge187_cadastro_conta_fluxo_caixa
integer x = 23
integer y = 8
integer width = 1929
integer height = 976
integer taborder = 20
end type

type gb_2 from groupbox within w_ge187_cadastro_conta_fluxo_caixa
integer x = 1998
integer y = 8
integer width = 3922
integer height = 976
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Taxa Cart$$HEX1$$e300$$ENDHEX$$o"
end type

type dw_2 from dc_uo_dw_base within w_ge187_cadastro_conta_fluxo_caixa
integer x = 2025
integer y = 76
integer width = 3881
integer height = 884
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge187_cad_taxa_cartao"
end type

event ue_recuperar;//override
Long lvl_Conta

dw_1.AcceptText( )
If dw_1.RowCount() >= 1 Then
	lvl_Conta = dw_1.Object.cd_conta_fluxo_caixa [1]
Else
	SetNull(lvl_Conta)
End If

Return This.Retrieve(lvl_Conta)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas = 0 Then This.Event ue_AddRow()

Return AncestorReturnValue
end event

event ue_addrow;call super::ue_addrow;This.Object.dh_inicio [ This.GetRow() ] = RelativeDate(gf_retorna_ultimo_dia_mes(date(Today())), 1)

Return AncestorReturnValue
end event

event constructor;call super::constructor;This.ivi_tipo_cancelar = RETRIEVE
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha
Long lvl_Conta_Fluxo

If dw_1.RowCount() > 0 Then
	dw_1.Accepttext( )
	lvl_Conta_Fluxo = dw_1.Object.cd_conta_fluxo_caixa [1]
	
	For lvl_Linha = 1 To This.RowCount()
		If IsNull(This.Object.cd_conta_fluxo_caixa[lvl_Linha]) Then
			This.Object.cd_conta_fluxo_caixa				[lvl_Linha] = lvl_Conta_Fluxo
			This.Object.pc_comissao_credito_parcelado	[lvl_Linha] = This.Object.pc_comissao_credito_2	[lvl_Linha]
		End If
	Next
End If

Return AncestorReturnValue
end event

event itemchanged;call super::itemchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)
End If
end event

event editchanged;call super::editchanged;If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)
End If
end event

event ue_predeleterow;call super::ue_predeleterow;Datetime lvdh_Inicio 

If This.GetItemStatus(This.GetRow(), "dh_inicio",Primary!) <> NotModified! Then
	lvdh_Inicio = This.Object.dh_inicio [This.GetRow()]
	If lvdh_Inicio <= gf_GetServerDate() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel excluir registros de taxas com data in$$HEX1$$ed00$$ENDHEX$$cio anterior a data atual.", Exclamation!)
		Return False
	End If
End If

Return AncestorReturnValue
end event

event getfocus;call super::getfocus;If This.Find("IsNull(cd_conta_fluxo_caixa)", 1, This.RowCount()) = 0 Then
	This.Post Event ue_AddRow()
End If
end event

