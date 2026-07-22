HA$PBExportHeader$w_ge099_selecao_endereco.srw
forward
global type w_ge099_selecao_endereco from dc_w_selecao_generica
end type
type st_1 from statictext within w_ge099_selecao_endereco
end type
type st_2 from statictext within w_ge099_selecao_endereco
end type
end forward

global type w_ge099_selecao_endereco from dc_w_selecao_generica
integer x = 192
integer y = 16
integer width = 3616
integer height = 1792
string title = "GE099 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Endere$$HEX1$$e700$$ENDHEX$$o"
long backcolor = 80269524
st_1 st_1
st_2 st_2
end type
global w_ge099_selecao_endereco w_ge099_selecao_endereco

type variables
uo_cidade ivo_Cidade

uo_ge099_endereco ivo_Endereco

Integer ivi_Tentativas = 0
end variables

on w_ge099_selecao_endereco.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
end on

on w_ge099_selecao_endereco.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;ivo_cidade = create uo_cidade

STRING lvs_endereco

ivo_Endereco = Message.PowerObjectParm

lvs_endereco = ivo_Endereco.ivs_Parametro_Selecao
dw_1.Object.de_endereco[1] = lvs_endereco

If Not IsNull( ivo_Endereco.ivl_Cidade_Informada ) And ivo_Endereco.ivl_Cidade_Informada <> 0 Then
	 dw_1.Object.Nm_Cidade[1] = String( ivo_Endereco.ivl_Cidade_Informada )
	 dw_1.Event ue_pos(1, 'nm_cidade')
	 
	 dw_1.AcceptText()
	 dw_1.Event ue_Key( KeyEnter!, 0 )
	 dw_1.Event ue_pos(1, 'de_endereco')
	 
	 If Trim(lvs_endereco) <> "" Then			
		ivb_Pesquisa_Direta = True
	End If
Else
	dw_1.Event ue_pos(1, 'nm_cidade')	
End If
end event

event close;call super::close;destroy(ivo_cidade)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge099_selecao_endereco
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge099_selecao_endereco
integer x = 14
integer y = 284
integer width = 3561
integer height = 1244
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge099_selecao_endereco
integer x = 14
integer width = 1733
integer height = 264
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge099_selecao_endereco
event ue_atualiza_cidade ( )
integer x = 32
integer width = 1678
integer height = 160
string dataobject = "dw_ge099_selecao"
end type

event dw_1::ue_atualiza_cidade();ivo_Endereco.ivs_Cep_Generico = ''

//ivo_Endereco.of_Cep_Generico( ivo_Cidade.Cd_Cidade_Ibge )

This.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
This.Object.Cd_Cidade[1] = ivo_Cidade.Cd_Cidade

This.Object.Cd_Uf[1]     = ivo_Cidade.Cd_Unidade_Federacao

This.Event ue_Pos(1, "de_endereco")


end event

event dw_1::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_cidade"
			ivo_Cidade.of_Localiza_Cidade(This.GetText())
			
			If ivo_Cidade.Localizada Then
				This.Event ue_Atualiza_Cidade()
			End If
			
//		Case "de_endereco"
			
			
		Case Else
			This.Event ue_SelectText()
			This.of_Marca_Coluna_Ativa(This.GetColumnName())			
			
			cb_Pesquisar.Default  = True
			cb_Selecionar.Default = False
			
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_cidade"
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Cidade.Nm_Cidade Then
				Return 1
			End If
		Else	
			ivo_Cidade.of_Inicializa()
			
			This.Event ue_Atualiza_Cidade()
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Cidade) Then
	This.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
End If
end event

event dw_1::getfocus;//OverRide
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge099_selecao_endereco
integer x = 37
integer y = 344
integer width = 3520
integer height = 1164
string dataobject = "dw_ge099_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Cidade

String lvs_Sql, &
	   lvs_Endereco, &
	   lvs_Uf, &
	   lvs_Where, &
	   ls_Extenso

dw_1.AcceptText()

lvs_Endereco	= Trim(dw_1.Object.De_Endereco	[1])
lvl_Cidade		= Long(dw_1.Object.Cd_Cidade	[1])
lvs_Uf				= String(dw_1.Object.cd_uf    		[1])

If isNull(lvl_Cidade) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A cidade deve ser informada.")
	dw_1.Event ue_Pos(1, "nm_cidade")
	Return -1
End If

If lvs_Endereco <> "" Then
	If SqlCa.of_Dbms_Name( ) = 'POSTGRESQL' Then
		//Se for pesquisado n$$HEX1$$fa00$$ENDHEX$$mero n$$HEX1$$e300$$ENDHEX$$o usa o dbo.uf_metaphone
		lvs_Endereco = gf_ge099_Remove_Hifen_Cep(lvs_Endereco)
		
		If IsNumber(lvs_Endereco) Then
			If LenA(lvs_Endereco) <> 8 Then
				ls_Extenso = gf_Extenso_Valor_Endereco(Long(lvs_Endereco))
				lvs_Where = "(dbo.remove_acento( de_endereco ) like dbo.remove_acento( '" + ivo_Endereco.of_string_sem_acento( lvs_Endereco ) + "' ) || '%' " + &
								"Or dbo.remove_acento( de_endereco ) like dbo.remove_acento( '" + ivo_Endereco.of_string_sem_acento( ls_Extenso ) + "' ) || '%')"
			Else
				//Se o usu$$HEX1$$e100$$ENDHEX$$rio digitar 8 n$$HEX1$$fa00$$ENDHEX$$meros, procura pelo cep
				lvs_Where = "nr_cep = '" + lvs_Endereco + "'"
			End If
		Else
			lvs_Where = "(dbo.remove_acento( de_endereco ) like dbo.remove_acento( '" + ivo_Endereco.of_string_sem_acento( lvs_Endereco ) + "' ) || '%' Or dbo.remove_acento( de_endereco ) like dbo.uf_metaphone( '" + lvs_Endereco + "' ) || '%')"
		End If
		
	Else
		lvs_Where = "de_endereco like '%" + ivo_Endereco.of_string_sem_acento( lvs_Endereco ) + "%'"
	End If
	
	This.of_AppendWhere(lvs_Where)
End If

This.of_AppendWhere( "cd_cidade = " + String(lvl_Cidade) )
This.of_AppendWhere( "cd_uf = '" + lvs_Uf + "'" )

Return 1
end event

event dw_2::ue_recuperar;// OverRide
Long ll_Retorno

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando as Informa$$HEX2$$e700f500$$ENDHEX$$es no Banco de Dados da Filial.."

ll_Retorno = This.Retrieve()

Close(w_Aguarde)

Return ll_Retorno

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;String ls_Cep_Padrao_Cidade

If pl_Linhas = 0 Then
	ivi_Tentativas++
	
	If ivo_Endereco.ivb_Permite_Sem_Localizar Then
		If ivi_Tentativas >= 2 Then
			//ivo_Endereco.of_Cep_Generico( ivo_Cidade.Cd_Cidade_Ibge )
			
			ls_Cep_Padrao_Cidade = ivo_Endereco.of_Localiza_Cep_Padrao_Cidade(ivo_Cidade.Cd_Cidade)
			
			//Se ls_Cep_Padrao_Cidade for nulo $$HEX1$$e900$$ENDHEX$$ porque n$$HEX1$$e300$$ENDHEX$$o foi localizado o cep padr$$HEX1$$e300$$ENDHEX$$o entao tenta usar da filial
			If IsNull(ls_Cep_Padrao_Cidade) Then
				If Not ivo_Endereco.of_Existe_Cep(gvo_Parametro.Cd_Cep_Filial) Then Return -1
				
				ls_Cep_Padrao_Cidade = gvo_Parametro.Cd_Cep_Filial
			End If
							
			This.InsertRow(0)
			This.Object.Nr_Cep							[1] = ls_Cep_Padrao_Cidade
			This.Object.De_Endereco_Complemento	[1] = 'ENDERE$$HEX1$$c700$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO, PRESSIONE [SELECIONAR] PARA PREENCHER'
			This.Object.De_Bairro							[1] = ''
			cb_Selecionar.Enabled = True
		End If
	End If
	
End If

Return pl_Linhas
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge099_selecao_endereco
integer x = 2811
integer y = 1572
end type

event cb_selecionar::clicked;Long lvl_Linha
Long ll_Cidade

String lvs_Chave
dw_2.AcceptText()

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	ll_Cidade = dw_2.Object.cd_cidade[lvl_Linha]
	
	If IsNull( ll_Cidade ) Then
		ivo_Endereco.ivb_Libera_Digitacao 	= True
		ivo_Endereco.cd_cidade					= dw_1.Object.cd_cidade	[1]
		ivo_Endereco.Nm_cidade					= dw_1.Object.Nm_cidade	[1]
		ivo_Endereco.cd_unidade_federacao  = dw_1.Object.cd_uf			[1]
	Else
		ivo_Endereco.ivb_Libera_Digitacao 	= False
		ivo_Endereco.cd_cidade					= dw_2.Object.cd_cidade	[lvl_Linha]
		ivo_Endereco.Nm_cidade					= dw_2.Object.Nm_cidade	[lvl_Linha]		
		ivo_Endereco.cd_unidade_federacao  = dw_2.Object.cd_uf			[lvl_Linha]
	End If
	
	ivo_Endereco.Nr_cep							= dw_2.Object.nr_cep				  		[lvl_Linha]
	ivo_Endereco.de_endereco					= dw_2.Object.de_endereco		  		[lvl_Linha]
	ivo_Endereco.de_endereco_abreviado	= dw_2.Object.de_endereco_abreviado	[lvl_Linha]
	ivo_Endereco.de_bairro						= dw_2.Object.de_bairro			  		[lvl_Linha]
	ivo_Endereco.de_bairro_abreviado		= dw_2.Object.de_bairro_abreviado  		[lvl_Linha]
	ivo_Endereco.Nr_Bairro						= dw_2.Object.Nr_Bairro						[lvl_Linha]
	
	ivo_Endereco.Localizado = True

	//CloseWithReturn( Parent, ivo_Endereco.Nr_cep )
	Close(Parent)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Endere$$HEX1$$e700$$ENDHEX$$o.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge099_selecao_endereco
integer x = 3205
integer y = 1572
end type

event cb_cancelar::clicked;STRING lvs_Cep

SetNull(lvs_Cep)

CloseWithReturn(Parent, lvs_Cep)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge099_selecao_endereco
integer x = 2368
integer y = 1572
end type

event cb_pesquisar::clicked;//OverRide

String ls_Endereco, &
	   ls_Cd_uf, &
	   ls_Retorno
	   
Long ll_Retorno = -1
Long ll_Cidade
	   
dw_1.AcceptText()

ls_Endereco = dw_1.Object.de_endereco[1]
ls_Cd_uf    = dw_1.Object.cd_uf[1]
ll_Cidade		= Long(dw_1.Object.Cd_Cidade	[1])

// Se a UF n$$HEX1$$e300$$ENDHEX$$o existir na base local, busca o endere$$HEX1$$e700$$ENDHEX$$o na matriz pelo distribu$$HEX1$$ed00$$ENDHEX$$do.
If Not ivo_endereco.of_existe_uf(ls_Cd_uf) Then
	
	If dw_2.Event ue_Retrieve() >= 0 Then
		
		Open(w_Aguarde)
		w_Aguarde.Title = "Recuperando as Informa$$HEX2$$e700f500$$ENDHEX$$es na Matriz..."

		dw_2.of_restoreoriginalsql( )
		dw_2.of_AppendWhere( "cd_cidade = " + String(ll_Cidade) + " and cd_uf = '" + ls_cd_Uf + "' and de_endereco like '" + ivo_Endereco.of_string_sem_acento( ls_Endereco ) + "%'")

		//lvs_Where = "de_endereco like '" + ivo_Endereco.of_string_sem_acento( lvs_Endereco ) + "%'"		

		uo_Transacao_Remota lvo_Conexao
		lvo_Conexao = Create uo_Transacao_Remota
	
		lvo_Conexao.of_BancoProducao()
		
		This.SetRedraw(False)
			
		lvo_Conexao.of_Retrieve(dw_2.GetSQLSelect(), ls_Retorno)
		
		If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
		Else
			If IsNull(ls_Retorno) Or ls_Retorno = "" Then
				ll_Retorno = 0
			Else
				ll_Retorno = dw_2.ImportString(ls_Retorno)			
				If ll_Retorno < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao copiar as informa$$HEX2$$e700f500$$ENDHEX$$es do servidor distribu$$HEX1$$ed00$$ENDHEX$$do para a DataWindow local.")	
				End If
			End If
		End If
		
		Destroy(lvo_Conexao)
		Close(w_Aguarde)
		
	End If

	
	This.SetRedraw(True)
		
	dw_2.Event ue_Postretrieve(dw_2.RowCount())
	
Else
	dw_2.Event ue_Retrieve()
End If
end event

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge099_selecao_endereco
integer y = 1584
integer width = 1605
long backcolor = 80269524
end type

type st_1 from statictext within w_ge099_selecao_endereco
boolean visible = false
integer x = 1774
integer y = 88
integer width = 1824
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Endere$$HEX1$$e700$$ENDHEX$$os com n$$HEX1$$fa00$$ENDHEX$$meros no nome, devem ser digitados por extenso"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge099_selecao_endereco
boolean visible = false
integer x = 1774
integer y = 160
integer width = 677
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Ex: Nove de mar$$HEX1$$e700$$ENDHEX$$o"
boolean focusrectangle = false
end type

