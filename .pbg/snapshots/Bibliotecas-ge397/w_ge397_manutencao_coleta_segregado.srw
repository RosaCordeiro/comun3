HA$PBExportHeader$w_ge397_manutencao_coleta_segregado.srw
forward
global type w_ge397_manutencao_coleta_segregado from dc_w_cadastro_selecao_lista
end type
type dw_3 from dc_uo_dw_base within w_ge397_manutencao_coleta_segregado
end type
end forward

global type w_ge397_manutencao_coleta_segregado from dc_w_cadastro_selecao_lista
integer width = 5120
integer height = 2144
string title = "GE397 - Manuten$$HEX2$$e700e300$$ENDHEX$$o Coletas Segregado"
dw_3 dw_3
end type
global w_ge397_manutencao_coleta_segregado w_ge397_manutencao_coleta_segregado

type variables
uo_filial ivo_filial
uo_fornecedor ivo_Fornecedor
dc_uo_aplicacao io_Aplicacao
uo_ge149_comprador io_Comprador


String is_Fornecedor, &
		ivs_Operador
		
		







end variables

on w_ge397_manutencao_coleta_segregado.create
int iCurrent
call super::create
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
end on

on w_ge397_manutencao_coleta_segregado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
end on

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(io_Comprador)
end event

event ue_postopen;call super::ue_postopen;Integer 	lvi_Retorno, &
        		lvi_Linha

DataWindowChild	ldwc_Child
ivo_Fornecedor 			= Create uo_Fornecedor
io_Comprador				= Create uo_ge149_comprador

ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Object.dh_inicio			[1] = Date("01/" + String(Today(), "mm/yyyy"))
dw_1.Object.dh_termino		[1] = Today()

/* Motivos Devolu$$HEX2$$e700e300$$ENDHEX$$o */
DataWindowChild lvdwc
lvi_Retorno = dw_1.GetChild("cd_motivo_devolucao", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_motivo_devolucao", 0)
		lvdwc.SetItem(lvi_Linha, "de_motivo_devolucao", "TODOS MOTIVOS")
		
		dw_1.Object.Cd_Motivo_Devolucao [lvi_Linha] = 0
	End If 	
End If

dw_2.ShareData(dw_3)
dw_1.SetFocus()







end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge397_manutencao_coleta_segregado
integer x = 9
integer y = 1560
string dataobject = ""
end type

event dw_visual::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino


lvdt_Inicio		= dw_1.Object.Dh_Inicio 	[1]
lvdt_Termino	= dw_1.Object.Dh_Termino	[1]


Return AncestorReturnValue
end event

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge397_manutencao_coleta_segregado
integer x = 0
integer y = 1500
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge397_manutencao_coleta_segregado
integer x = 18
integer y = 68
integer width = 3474
integer height = 404
string dataobject = "dw_ge397_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_nulo
dw_2.Event ue_Reset()


Choose Case dwo.Name
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
	
	Case "nm_comprador"			
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.nm_usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
			This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
		End If

	Case "id_nota_compra"
	    This.Object.nr_nota	[1] = 0 
		This.Object.de_serie[1] =  ls_nulo
		This.Object.de_especie 	[1] = ls_nulo
			
End Choose






end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If

If IsValid(io_Comprador) Then
	This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
	This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
End If



end event

event dw_1::ue_key;call super::ue_key;
String lvs_Nulo,&
		lvs_ChaveAcesso

If Key = KeyEnter! Then
	
	If This.GetColumnName() = "nm_comprador" Then
		io_Comprador.of_Localiza_Comprador(This.GetText())
		
		If io_Comprador.Localizado Then
			This.Object.nr_matricula_comprador	[1] = io_Comprador.nr_matricula
			This.Object.nm_comprador				[1] = io_Comprador.nm_usuario
		End If
	End If
	
	If This.GetColumnName() = 'nm_fornecedor' Then
		ivo_Fornecedor.of_Localiza_Fornecedor(dw_1.GetText())
	
		If ivo_Fornecedor.Localizado Then
			dw_1.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
			dw_1.Object.nm_fornecedor  [1] = ivo_Fornecedor.Nm_Razao_Social
		Else
			SetNull(lvs_Nulo)
					
			dw_1.Object.cd_fornecedor[1] = lvs_Nulo
			dw_1.Object.nm_fornecedor[1] = lvs_Nulo
		End If
	End If	

	If This.GetColumnName() = 'de_chave_acesso' Then
			dw_2.event ue_preretrieve( )
	End If
	
	
	
	
	

End If



end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge397_manutencao_coleta_segregado
integer x = 9
integer y = 512
integer width = 5065
integer height = 1416
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge397_manutencao_coleta_segregado
integer x = 5
integer width = 3497
integer height = 496
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge397_manutencao_coleta_segregado
integer x = 23
integer y = 560
integer width = 5029
integer height = 1348
string dataobject = "dw_ge397_lista"
boolean hscrollbar = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;
If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_salvarcomo(True)
	ivo_Controle_Menu.of_imprimir( True)
Else
	ivo_Controle_Menu.of_salvarcomo(False)
	ivo_Controle_Menu.of_imprimir(False)
End If

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String	ls_SerieDev,&
		ls_EspecieDev,&
		ls_Fornecedor,&
		ls_Comprador,&
		ls_ChaveAcesso,&
		ls_StatusColeta	,&
		ls_Busca_nf_Compra 

Date ldh_inicio,&
			 ldh_fim
			 
Long 		  ll_NotaDev,&
			  ll_Linhas,&
			  ll_DiasIni,&
			  ll_DiasFim,&
		  	  ll_Agrupamento,&
			  ll_MotivoDevolucao

Boolean   lb_PesquisaChave = False			  

dw_1.AcceptText()			
ldh_inicio     =  dw_1.Object.dh_inicio	 [1]
ldh_fim   	=  dw_1.Object.dh_termino[1]

ls_SerieDev			=  Trim(dw_1.object.de_serie[1]) 
ls_EspecieDev		= Trim(dw_1.object.de_especie[1])
ls_Fornecedor 		= Trim(dw_1.Object.cd_fornecedor[1])  
ls_Comprador 		= dw_1.object.nr_matricula_comprador[1]
ls_ChaveAcesso 	= Trim(dw_1.object.de_chave_acesso[1]) 
ls_StatusColeta		= dw_1.object.cd_status_coleta[1]   
ll_MotivoDevolucao		= dw_1.object.cd_motivo_devolucao[1]
ls_Busca_nf_Compra		=	dw_1.object.id_nota_compra  [1]  

ll_NotaDev			= dw_1.object.nr_nota[1]
ll_DiasIni				= dw_1.object.dia_inicial[1]
ll_DiasFim		 	= dw_1.object.dia_final[1]
ll_Agrupamento 	= dw_1.object.nr_agrupamento[1]


If Not IsNull(ls_ChaveAcesso) And Trim(ls_ChaveAcesso) <> "" Then
	If Not gf_valida_chave_nfe( ls_ChaveAcesso ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Chave de acesso inv$$HEX1$$e100$$ENDHEX$$lida.")
		dw_1.Event ue_Pos(1, "de_chave_acesso")
		Return -1	
	End If
	lb_PesquisaChave = True
End If

// Apenas Usa filtro ChaveAcesso
If lb_PesquisaChave  Then 
	// Apenas Usa o filtro ChaveAcesso
	If Not IsNull(ls_ChaveAcesso)  and Trim(ls_ChaveAcesso) <> "" Then  
		This.of_AppendWhere(" nfe.de_chave_acesso = '" + ls_ChaveAcesso + "'" )
	End If
Else	
	// Valida os filtros
	If IsNull(ldh_inicio) or Not IsDate(String(ldh_inicio, "dd/mm/yyyy"))Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
		dw_1.SetFocus()
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return -1
	End If 	
	
	If IsNull(ldh_fim) or Not IsDate(String(ldh_fim, "dd/mm/yyyy")) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
		dw_1.SetFocus()
		dw_1.Event ue_Pos(1, "dh_termino")
		Return -1
	End If 	
	
	If ldh_inicio > ldh_fim Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor ou igual a de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
		dw_1.SetFocus()
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return -1
	End If 	
	
	If ll_DiasFim<ll_DiasIni Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade de Dias Final deve ser maior que Dias Inicial.", Information!)
		dw_1.SetFocus()
		dw_1.Event ue_Pos(1, "dia_inicial")
		Return -1
	End If

	// Adicionar as Condi$$HEX2$$e700f500$$ENDHEX$$es do Filtro
	If Not IsNull(ldh_inicio) Then
		This.of_AppendWhere("b.dh_movimentacao_caixa>='"+String(ldh_Inicio,'YYYYMMDD' )+"'")
	End If
	
	If Not IsNull(ldh_fim) Then
		This.of_AppendWhere("b.dh_movimentacao_caixa<='"+String(ldh_fim,'YYYYMMDD' )+"'")
	End If
	
	
	If Not IsNull(ll_Agrupamento) or ll_Agrupamento > 0 Then 
		This.of_AppendWhere("a.nr_agrupamento = " + String(ll_Agrupamento))	
	End If
	
	If ls_StatusColeta<>"T"  Then
		This.of_AppendWhere(" a.id_situacao = '" + ls_StatusColeta + "'" )
	End If
	
	If Not IsNull(ls_Comprador) Then
		This.of_AppendWhere(" usu_compr.nr_matricula = '" + ls_Comprador + "'" )
	End If
	
	If Not IsNull(ls_Fornecedor) Then
		This.of_AppendWhere(" a.cd_fornecedor = '" + ls_Fornecedor + "'" )
	End If
	
	If ll_MotivoDevolucao<>0 Then 
		This.of_AppendWhere(" b.cd_motivo_devolucao = " + String (ll_MotivoDevolucao))
	End If	
	
	If ll_DiasIni>0 and ll_DiasFim>0 Then 
		This.of_AppendWhere("datediff(dd, b.dh_movimentacao_caixa, getdate()) >=" + String(ll_DiasIni))	
		This.of_AppendWhere("datediff(dd, b.dh_movimentacao_caixa, getdate()) <=" + String(ll_DiasFim))	
	End If
	
	
	If ls_Busca_nf_Compra = "N" Then 
		// Busca por NOTA DE DEV COMPRA
		If Not IsNull(ll_NotaDev) and ll_NotaDev > 0 Then
			This.of_AppendWhere("a.nr_nf = " + String(ll_NotaDev) )
		End If
		
		If Not IsNull(ls_EspecieDev) and ls_EspecieDev <> "" Then
			This.of_AppendWhere("a.de_especie = '" + ls_EspecieDev + "'" )
		End If
		
		If Not IsNull(ls_SerieDev) and ls_SerieDev <> "" Then
			This.of_AppendWhere("a.de_serie = '" + ls_SerieDev + "'" )
		End If
	Else
		// Busca por NOTA DE COMPRA
		If Not IsNull(ll_NotaDev) and ll_NotaDev > 0 Then
			This.of_AppendWhere("b.nr_nf_compra = " + String(ll_NotaDev) )
		End If
		
		If Not IsNull(ls_EspecieDev) and ls_EspecieDev <> "" Then
			This.of_AppendWhere("b.de_especie_compra = '" + ls_EspecieDev + "'" )
		End If
		
		If Not IsNull(ls_SerieDev) and ls_SerieDev <> "" Then
			This.of_AppendWhere("b.de_serie_compra = '" + ls_SerieDev + "'" )
		End If		
	End If 	
	
	
	
End If 

ll_Linhas = dw_2.Retrieve()

If ll_Linhas	> 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
End If

Return ll_Linhas
end event

event dw_2::itemchanged;call super::itemchanged;String ls_idSituacaoAtual
Datetime ldh_Situacao

ldh_Situacao = Datetime (String(Today(), "dd/mm/yyyy hh:mm"))
ls_idSituacaoAtual = This.Object.id_situacao[row]

If dwo.name = 'id_situacao' Then
	This.Object.dh_situacao[row] = ldh_Situacao
	
	If ls_idSituacaoAtual = "X" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o pode mudar a situa$$HEX2$$e700e300$$ENDHEX$$o de notas canceladas.")
		This.Object.id_situacao[row] = ls_idSituacaoAtual
 	     Return 1
	End If

	// Para Substituido
	If data = 'S' Then
	   This.event ue_Pos(row,"nr_nf_subs")	
	End If	
	
    // Para Voltar Coletado para Pendente 
	If data = 'P' and ls_idSituacaoAtual = 'C' Then 
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ esta retornando : Coletado->Pendente!."+".~rDeseja continuar?", Question!,YesNo!, 2) = 2 Then
			This.Object.id_situacao[row] = 'C'
			Return 1   
		End If 	   
	End If 	
	
	If ls_idSituacaoAtual = 'P' and data <> 'P' Then 
		This.Object.dh_saida_pendente[row] = ldh_Situacao  
	End If 	

End If 	
	


end event

event dw_2::ue_printimmediate;//OverRide
dw_3.print( )
end event

event dw_2::ue_print;// OverRide

end event

event dw_2::constructor;call super::constructor;ivb_ordena_colunas = True
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long ll_Linha

String ls_Para

dw_2.AcceptText()

For ll_Linha = 1 To dw_2.RowCount()
	
	If gf_houve_alteracao_dw(This, 'ID_SITUACAO', ll_Linha, Ref ls_Para) Then
		dw_2.Object.Nr_Matricula [ll_Linha] = gvo_aplicacao.ivo_seguranca.Nr_Matricula
	End If
	
Next

Return 1
end event

type dw_3 from dc_uo_dw_base within w_ge397_manutencao_coleta_segregado
boolean visible = false
integer x = 3579
integer y = 36
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_ge397_lista_rel"
end type

