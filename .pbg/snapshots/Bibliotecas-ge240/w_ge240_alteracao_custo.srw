HA$PBExportHeader$w_ge240_alteracao_custo.srw
forward
global type w_ge240_alteracao_custo from dc_w_selecao_lista_relatorio
end type
type cb_todas_filiais from commandbutton within w_ge240_alteracao_custo
end type
type cb_filiais from commandbutton within w_ge240_alteracao_custo
end type
type cb_1 from commandbutton within w_ge240_alteracao_custo
end type
end forward

global type w_ge240_alteracao_custo from dc_w_selecao_lista_relatorio
string tag = "w_ge240_alteracao_custo"
integer width = 3086
integer height = 1928
string title = "GE240 - Altera$$HEX2$$e700e300$$ENDHEX$$o de Custos"
cb_todas_filiais cb_todas_filiais
cb_filiais cb_filiais
cb_1 cb_1
end type
global w_ge240_alteracao_custo w_ge240_alteracao_custo

type variables
uo_produto ivo_produto

uo_usuario ivo_usuario

uo_ge216_filiais ivo_filiais

String is_Responsavel
String is_Responsavel_importar

string ivs_filiais, ivs_nulo
end variables

forward prototypes
public subroutine wf_localiza_produto ()
public function boolean wf_valor_custo_anterior (long al_filial, long al_produto, ref decimal adc_custo_anterior, ref decimal adc_custo_gerencial_ant)
public subroutine wf_localiza_usuario (string ps_matricula)
public function long wf_proximo_sequencial (long pl_filial)
end prototypes

public subroutine wf_localiza_produto ();dw_1.AcceptText()

ivo_Produto.of_Localiza_Produto(dw_1.GetText())

If ivo_Produto.Localizado Then
	
	dw_1.Object.cd_produto				[1] = ivo_Produto.cd_Produto
	dw_1.Object.de_produto				[1] = ivo_Produto.de_Produto + ":" + ivo_Produto.De_Apresentacao_Venda
	dw_1.Object.vl_fator_conversao	[1] = ivo_Produto.vl_fator_conversao
	
	
Else
	
	ivo_Produto.of_Inicializa()
	
	dw_1.Object.cd_produto				[1] = ivo_Produto.cd_Produto
	dw_1.Object.de_produto				[1] = ivo_Produto.de_Produto
	dw_1.Object.vl_fator_conversao	[1] = ivo_Produto.vl_fator_conversao

End If
end subroutine

public function boolean wf_valor_custo_anterior (long al_filial, long al_produto, ref decimal adc_custo_anterior, ref decimal adc_custo_gerencial_ant);Select vl_custo_medio, vl_custo_gerencial
Into :adc_custo_anterior, :adc_custo_gerencial_ant
From vw_saldo_atual_produto
Where cd_filial  = :al_Filial
  and cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do custo do produto '" + String(al_Produto) + "' da filial '" + String(al_Filial))
	Return False
End If

If SqlCa.SqlCode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o custo do produto '" + String(al_Produto) +&
	"' da filial '" + String(al_Filial))
	Return False
End If


Return True
end function

public subroutine wf_localiza_usuario (string ps_matricula);ivo_Usuario.of_Localiza_Usuario( ps_matricula )

If Not ivo_Usuario.Localizado Then
	
	ivo_Usuario.of_Inicializa()

End If

dw_1.Object.Nr_Matricula		[1] = ivo_Usuario.Nr_Matricula
dw_1.Object.Nm_Responsavel	[1] = ivo_Usuario.Nm_Usuario
end subroutine

public function long wf_proximo_sequencial (long pl_filial);long lvl_Sequencial = 0

select max(nr_sequencial) into :lvl_Sequencial
from ajuste_custo_filial
where cd_filial = :pl_filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvl_Sequencial) Then lvl_Sequencial = 0
		lvl_Sequencial ++
	
	Case 100
		lvl_Sequencial = 1
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do sequencial")
End Choose

Return lvl_Sequencial
end function

on w_ge240_alteracao_custo.create
int iCurrent
call super::create
this.cb_todas_filiais=create cb_todas_filiais
this.cb_filiais=create cb_filiais
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_todas_filiais
this.Control[iCurrent+2]=this.cb_filiais
this.Control[iCurrent+3]=this.cb_1
end on

on w_ge240_alteracao_custo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_todas_filiais)
destroy(this.cb_filiais)
destroy(this.cb_1)
end on

event open;call super::open;ivo_Produto = Create uo_Produto
ivo_Usuario = Create uo_Usuario


end event

event ue_postopen;// OverRide

ivo_dbError 	= Create dc_uo_dbError
ivo_filiais		= Create uo_ge216_filiais 

dw_1.Event ue_AddRow()
dw_1.SetFocus()

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE240_LIBERACAO_PROCEDIMENTO", ref is_Responsavel) Then 
	Close(This)
	Return
End If

Wf_Localiza_Usuario( is_Responsavel )


This.ivm_Menu.mf_Recuperar(False)

dw_1.SetColumn("de_produto")
dw_1.SetFocus()



end event

event ue_presave;call super::ue_presave;dw_1.AcceptText()

If IsNull(dw_1.Object.Cd_Produto[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.",StopSign!,OK!)
	dw_1.SetColumn("de_produto")
	dw_1.SetFocus()
	Return False
End If

If IsNull(dw_1.Object.Nr_Matricula[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a matr$$HEX1$$ed00$$ENDHEX$$cula do respons$$HEX1$$e100$$ENDHEX$$vel.",StopSign!,OK!)
	dw_1.SetColumn("nm_responsavel")
	dw_1.SetFocus()
	Return False
End If	

If IsNull(dw_1.Object.de_Motivo[1]) or dw_1.Object.de_Motivo[1] = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo.",StopSign!,OK!)
	dw_1.SetColumn("de_motivo")
	dw_1.SetFocus()
	Return False
End If

If IsNull(dw_1.Object.vl_novo_custo[1]) or dw_1.Object.vl_novo_custo[1] = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O valor do custo informado deve ser maior que zero.",StopSign!,OK!)
	dw_1.SetColumn("vl_novo_custo")
	dw_1.SetFocus()
	Return False
End If	

Return True
end event

event ue_preupdate;call super::ue_preupdate;Boolean lvb_Sucesso = True

Long lvl_Row, &
     lvl_Linhas, &
	 lvl_Filial, &
	 lvl_Produto
	 
Date lvdh_Saldo
	  
Long lvl_Sequencial

String lvs_Motivo, &
       lvs_Matricula

DateTime lvdt_Ajuste

Decimal lvdc_Custo_Contabil_Novo,&
        	lvdc_Custo_Contabil_Anterior,&
			lvdc_Custo_Gerencial_Anterior,&
			lvdc_Custo_Gerencial_Novo

Decimal ldc_Venda, lvdc_Fator_Conversao
	
If Not AncestorReturnValue Then Return AncestorReturnValue

dw_1.AcceptText()
dw_2.AcceptText()

lvl_Linhas = dw_2.Find("id_atualiza = 'S'",1 ,dw_2.RowCount())

If lvl_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as filiais.")
	Return False
End If

If lvl_Linhas > 0 Then
	
	lvl_Produto               			= dw_1.Object.Cd_Produto      		[1]
	lvs_Matricula             		= dw_1.Object.Nr_Matricula      	[1]
	lvs_Motivo                			= dw_1.Object.de_Motivo        		[1]
	lvdc_Custo_Gerencial_Novo 	= dw_1.Object.vl_novo_Custo		[1]
	lvdc_Fator_Conversao 		= dw_1.Object.vl_fator_conversao	[1]
	lvdt_Ajuste               			= gf_GetServerDate()
	
	lvdh_Saldo = Date("01/" +  string(Month(date(lvdt_Ajuste)), "00") + "/" + string(Year(date(lvdt_Ajuste)), "0000"))
		
	For lvl_Row = 1 To dw_2.RowCount()
		
		If dw_2.Object.Id_Atualiza[lvl_Row] = 'S' Then
			
			lvl_Filial     			= dw_2.Object.Cd_Filial			[ lvl_Row ]
			ldc_Venda			= dw_2.Object.vl_preco_final	[ lvl_Row ]
			lvl_Sequencial 	= wf_Proximo_Sequencial(lvl_Filial)
						
			If Not wf_Valor_Custo_Anterior(lvl_Filial,&
									       lvl_Produto,& 
										   Ref lvdc_Custo_Contabil_Anterior,&
										   Ref lvdc_Custo_Gerencial_Anterior) Then
				lvb_Sucesso = False
				Exit
			End If
					
			If lvl_Filial = 534 then
				
				ldc_Venda = Round(ldc_Venda * lvdc_Fator_Conversao, 2)
				
				Update saldo_produto
				Set vl_custo_medio = :lvdc_Custo_Gerencial_Novo, vl_custo_gerencial = :lvdc_Custo_Gerencial_Novo
				Where cd_filial 		= 534
				 	and cd_produto	= :lvl_Produto
					and dh_saldo 	= :lvdh_Saldo
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do ajuste de custo.")
					lvb_Sucesso = False
					Exit
				End If
				
			End If	
			
			If lvdc_Custo_Gerencial_Novo > ldc_Venda Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O custo informado deve ser menor que o pre$$HEX1$$e700$$ENDHEX$$o de venda.")
				dw_2.Event ue_Pos( lvl_Row, "cd_filial" )
				lvb_Sucesso = False
				Exit
			End If
			
			Insert Into ajuste_custo_filial(cd_filial,
			                                nr_sequencial,
										cd_produto,
										dh_ajuste,
										vl_custo_ajustado,
										nr_matricula_responsavel,
										de_motivo_ajuste,
										vl_custo_anterior,   
							          	vl_custo_gerencial_novo,   
								         vl_custo_gerencial_anterior )  
									
		  	Values (:lvl_Filial,
				    :lvl_Sequencial,
				    :lvl_Produto,
				    :lvdt_Ajuste,
				    :lvdc_Custo_Gerencial_Novo,
				    :lvs_Matricula,
				    :lvs_Motivo,
				    :lvdc_Custo_Contabil_Anterior,
				    :lvdc_Custo_Gerencial_Novo,
				    :lvdc_Custo_Gerencial_Anterior)
		  	Using SqlCa;
			  
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do ajuste de custo.")
				lvb_Sucesso = False
				Exit
			End If
		 End If
		
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma filial foi selecionada.", Information!,Ok!)
	Return False
End If

If lvb_Sucesso Then
	SqlCa.of_Commit();
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os custos foram atualizados com sucesso.")
Else
	SqlCa.Of_Rollback();
	Return False
End If
		
Return lvb_Sucesso	
end event

event ue_save;//OverRide

If Not This.Event ue_PreSave()   Then Return -1
If Not This.Event ue_PreUpdate() Then Return -2

This.Event ue_Cancel()

Return 1
end event

event ue_cancel;call super::ue_cancel;dw_2.Reset()
dw_2.Event ue_Retrieve()

dw_1.SetColumn("de_produto")
dw_1.SetFocus()

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)
end event

event close;call super::close;Destroy ivo_filiais
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge240_alteracao_custo
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge240_alteracao_custo
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge240_alteracao_custo
integer x = 18
integer y = 436
integer width = 3008
integer height = 1176
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge240_alteracao_custo
integer x = 18
integer y = 4
integer width = 1755
integer height = 420
string text = "Altera$$HEX2$$e700e300$$ENDHEX$$o do Custo"
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge240_alteracao_custo
integer x = 50
integer y = 64
integer width = 1701
integer height = 324
string dataobject = "dw_ge240_selecao"
end type

event dw_1::itemchanged;// OverRide

Choose Case dwo.Name
	
	Case "de_produto"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Produto.De_Produto Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto      		 	[1] = ivo_Produto.Cd_Produto
			This.Object.de_produto        	 	[1] = ivo_Produto.De_Produto
			This.Object.vl_fator_conversao		[1] = ivo_Produto.vl_fator_conversao
			
			dw_2.Reset()
			
		End If		
			
End Choose

ivw_ParentWindow.ivb_Valida_Salva = True

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)


end event

event dw_1::ue_key;String lvs_Coluna

If key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case 'de_produto'
			wf_Localiza_Produto()
			
			dw_2.Reset()
		
	End Choose
End If
end event

event dw_1::getfocus;This.ivm_Menu.mf_Classificar(False)
end event

event dw_1::editchanged;//OverRide

ivw_ParentWindow.ivb_Valida_Salva = True

This.ivm_Menu.mf_Confirmar(True)
This.ivm_Menu.mf_Cancelar(True)


end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge240_alteracao_custo
integer x = 50
integer y = 500
integer width = 2958
integer height = 1084
string dataobject = "dw_ge240_lista"
end type

event dw_2::ue_postretrieve;//OverRide
Boolean lvb_Ok = False
Long ll_Row
Long ll_Filial

If pl_Linhas > 0 Then
	
	lvb_Ok = True
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando pre$$HEX1$$e700$$ENDHEX$$o de venda, aguarde..."
	w_Aguarde.uo_progress.of_SetMax( pl_Linhas )
	
	SetPointer( HourGlass! )
	
	For ll_Row = 1 To pl_Linhas
		
		w_Aguarde.uo_Progress.of_SetProgress( ll_Row )
		
		ll_Filial = This.Object.cd_filial [ ll_Row ] 
		
		This.Object.vl_unitario		[ ll_Row ] = ivo_Produto.of_Preco_Venda_Filial_Matriz( ll_Filial )
		This.Object.pc_desconto	[ ll_Row ] = ivo_Produto.Of_Desconto_Filial( ll_Filial )
		
	Next
	
	SetPointer( Arrow! )
	
	Close(w_Aguarde)
	
	This.SetRedRaw( True )
	
	ivb_Valida_Salva = True

	This.SetRow(1)
	This.SetFocus()
	cb_todas_filiais.Enabled = True
	
ElseIf pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	ivb_Valida_Salva = False
	cb_todas_filiais.Enabled = False
End If

ivm_Menu.mf_Classificar(lvb_Ok)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", "nm_fantasia"}

lvs_Nome = {"c$$HEX1$$f300$$ENDHEX$$digo", "filial"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		 

end event

event dw_2::getfocus;This.ivm_Menu.mf_Classificar(True)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Produto

ll_Produto = dw_1.Object.cd_produto[1]

If IsNull( ll_Produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um produto.")
	dw_1.Event ue_pos(1,"de_produto")
	Return -1
End If

This.of_AppendWhere("v.cd_produto = " + String( ll_Produto ) )

This.of_AppendWhere("v.cd_filial in (" + ivs_Filiais + " )")

This.SetRedRaw( False)

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge240_alteracao_custo
boolean visible = false
integer x = 2427
integer y = 28
integer width = 594
integer height = 256
integer taborder = 50
end type

type cb_todas_filiais from commandbutton within w_ge240_alteracao_custo
integer x = 18
integer y = 1628
integer width = 480
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Todas Filiais"
end type

event clicked;Long lvl_Linha

If cb_todas_filiais.Text = '&Todas Filiais' Then

	For lvl_Linha = 1 To dw_2.RowCount()
		dw_2.Object.Id_Atualiza[lvl_Linha] = 'S'
	Next
	cb_todas_filiais.Text = '&Nenhuma Filial'
Else
	For lvl_Linha = 1 To dw_2.RowCount()
		dw_2.Object.Id_Atualiza[lvl_Linha] = 'N'
	Next
	cb_todas_filiais.Text = '&Todas Filiais'
End If
end event

type cb_filiais from commandbutton within w_ge240_alteracao_custo
integer x = 1824
integer y = 324
integer width = 558
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
end type

event clicked;Long ll_Lojas


If IsNull( dw_1.Object.cd_produto[1] ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto.")
	Return
End If

ivs_filiais = ivs_nulo 
			
OpenWithParm(w_ge216_selecao_filiais, ivo_filiais)

ll_Lojas = Message.DoubleParm

If ll_Lojas > 0 Then
	ivs_filiais = ivo_filiais.ivs_filiais
	
	dw_2.Event ue_Retrieve()
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
	dw_2.Reset()
End If
			
			
end event

type cb_1 from commandbutton within w_ge240_alteracao_custo
integer x = 1824
integer y = 56
integer width = 558
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar(.xlsx)"
end type

event clicked;
OpenWithParm (w_ge240_alteracao_custo_arquivo, is_Responsavel )
end event

