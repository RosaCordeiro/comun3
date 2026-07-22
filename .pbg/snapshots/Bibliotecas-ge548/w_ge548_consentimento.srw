HA$PBExportHeader$w_ge548_consentimento.srw
forward
global type w_ge548_consentimento from dc_w_response_ok_cancela
end type
type cb_nao_titular from commandbutton within w_ge548_consentimento
end type
end forward

global type w_ge548_consentimento from dc_w_response_ok_cancela
integer width = 2075
integer height = 1056
string title = "GE548 - Permiss$$HEX1$$f500$$ENDHEX$$es do Cliente"
boolean ivb_permite_fechar = false
cb_nao_titular cb_nao_titular
end type
global w_ge548_consentimento w_ge548_consentimento

type variables
String is_Cliente

String is_Matricula_Captacao

Datetime idt_Abertura_Tela
end variables

forward prototypes
public function boolean wf_localiza_consentimento ()
public function boolean wf_grava_consentimento (long al_cd_tipo_aviso, string as_situacao)
public function boolean wf_grava_dados_coleta_matriz (datetime pdt_termino_coleta)
public function boolean wf_grava_dados_coleta (datetime pdt_termino_coleta)
public function boolean wf_atualiza_consentimentos (string as_id_sim, string as_id_nao)
end prototypes

public function boolean wf_localiza_consentimento ();Integer li_Linhas, li_Row, li_Find

String ls_Tipo, ls_Situacao, ls_Rede

Date ldt_Consentimento, ldt_Inicio_Consentimento

Long ll_Cd_Tipo

Try
	dc_uo_ds_base lds_Consentimentos
	lds_Consentimentos = Create dc_uo_ds_base
	
	If Not lds_Consentimentos.of_changedataobject( 'ds_ge040_consentimento_cliente' ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_changedataobject")
		Return False
	End If
	
	ls_Rede = gvo_Parametro.id_rede_filial
	
	li_Linhas = lds_Consentimentos.Retrieve( is_Cliente, ls_Rede )
	
	If li_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_localiza_consentimento()")
		Return False
	End If
	
	uo_parametro_filial lo_Parametro
	lo_Parametro = Create uo_parametro_filial
	If Not lo_Parametro.of_localiza_parametro( 'DH_INICIO_CONSENTIMENTO_CLIENTE', Ref ldt_Inicio_Consentimento ) Then
		Return False
	End If
	If IsValid(lo_Parametro) Then Destroy lo_Parametro
	
	For li_Row = 1 To li_Linhas
		ll_Cd_Tipo				= lds_Consentimentos.Object.cd_tipo_aviso			[ li_Row ]
		ls_Tipo 					= lds_Consentimentos.Object.de_tipo					[ li_Row ]
		ls_Situacao 				= lds_Consentimentos.Object.id_situacao			[ li_Row ]
		ldt_Consentimento 	= lds_Consentimentos.Object.dh_consentimento	[ li_Row ]
		
		If IsNull(ls_Situacao) Or IsNull( ldt_Consentimento ) Or (ldt_Consentimento < ldt_Inicio_Consentimento) Then
			ls_Situacao = 'I'
		End If
		
		If PosA(ls_Tipo, 'SMS') > 0 Then 
			dw_1.Object.id_sms[1] 			= ls_Situacao
			dw_1.Object.cd_tipo_sms[1] 	= ll_Cd_Tipo
			Continue
		End If
		If PosA(ls_Tipo, 'EMAIL') > 0 Then 
			dw_1.Object.id_email[1] 		= ls_Situacao
			dw_1.Object.cd_tipo_email[1] 	= ll_Cd_Tipo
			Continue
		End If
		If PosA(ls_Tipo, 'LIGA$$HEX2$$c700c300$$ENDHEX$$O') > 0 Then 
			dw_1.Object.id_ligacao[1] 			= ls_Situacao
			dw_1.Object.cd_tipo_ligacao[1] 	= ll_Cd_Tipo
			Continue
		End If
		If PosA(ls_Tipo, 'PESQUISAS') > 0 Then 
			dw_1.Object.id_pesquisas[1] 		= ls_Situacao
			dw_1.Object.cd_tipo_pesquisa[1] 	= ll_Cd_Tipo
			Continue
		End If
		If PosA(ls_Tipo, 'WHATSAPP') > 0 Then 
			dw_1.Object.id_whatsapp[1] 			= ls_Situacao
			dw_1.Object.cd_tipo_whatsapp[1] 	= ll_Cd_Tipo
			Continue
		End If
		If PosA(ls_Tipo, 'REDES') > 0 Then 
			dw_1.Object.id_rede[1] 			= ls_Situacao
			dw_1.Object.cd_tipo_rede[1] 	= ll_Cd_Tipo
			Continue
		End If
		If PosA(ls_Tipo, 'CORRESPOND$$HEX1$$ca00$$ENDHEX$$NCIA') > 0 Then 
			dw_1.Object.id_correspondencia[1] 			= ls_Situacao
			dw_1.Object.cd_tipo_correspondencia[1] 	= ll_Cd_Tipo
			Continue
		End If
//		If PosA(ls_Tipo, 'MEDICAMENTOS') > 0 Then 
//			dw_1.Object.id_medicamentos[1] 			= ls_Situacao
//			dw_1.Object.cd_tipo_medicamento[1] 	= ll_Cd_Tipo
//			Continue
//		End If
	Next

	dw_1.AcceptText()
	
	Return True	
Finally
	If IsValid(lds_Consentimentos) Then Destroy lds_Consentimentos
	dw_1.AcceptText()
End Try
end function

public function boolean wf_grava_consentimento (long al_cd_tipo_aviso, string as_situacao);Integer li_Cd_Tipo

Long ll_Filial

String ls_Situacao_Anterior

ll_Filial = gvo_Parametro.cd_filial

Select id_situacao
	into :ls_Situacao_Anterior
from tipo_aviso_cliente 
 where cd_tipo_aviso = :al_cd_tipo_aviso
 	and cd_cliente 		= :is_Cliente
 Using SqlCa;
 
 CHoose Case SqlCa.SqlCode
	Case -1 
		SqlCa.of_MsgDbError("Erro ao localizar o consentimento " + String( al_cd_tipo_aviso ))
		Return False
		
	Case 100
		//Insert
		Insert Into tipo_aviso_cliente(cd_tipo_aviso, cd_cliente, id_situacao, dh_consentimento, cd_filial_inclusao, nr_matricula_inclusao)
			Values( :al_cd_tipo_aviso, :is_Cliente, :as_Situacao, getdate(), :ll_Filial, :is_Matricula_Captacao )
		Using SqlCa;
		
	Case 0
		//Update
		Update tipo_aviso_cliente set id_situacao 					= :as_Situacao, 
											  dh_consentimento 			= getdate(),
											  cd_filial_atualizacao 		= :ll_Filial,
											  nr_matricula_atualizacao 	= :is_matricula_captacao 
			where  cd_tipo_aviso 	= :al_cd_tipo_aviso
 				and cd_cliente 		= :is_Cliente
		Using SqlCa;
End Choose

//Insert/Update
If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_MsgDbError("Erro ao atualizar o consentimento "+ String( al_cd_tipo_aviso ) )
	Return False
End If

Return True

end function

public function boolean wf_grava_dados_coleta_matriz (datetime pdt_termino_coleta);Long ll_Row

DateTime ldt_Parametro

String ls_Colunas, ls_Values, ls_Tabela, ls_Rede

Try
	ls_Rede = gvo_Parametro.id_rede_filial
	
	uo_Transacao_Remota lo_Conexao
	lo_Conexao = Create uo_Transacao_Remota 
	
	lo_Conexao.of_BancoProducao()
	
	ls_Tabela 	= "coleta_consentimento_lgpd"
	ls_Colunas 	= "id_rede, cd_cliente, dh_inicio_coleta, dh_termino_coleta, nr_matricula_coleta"
	
	ls_Values = "'" + ls_Rede + "','" + is_cliente + "', " + &
					"'" + String( idt_Abertura_Tela,"yyyy/mm/dd hh:mm:ss") + "', " + &
					"'" + String( pdt_termino_coleta,"yyyy/mm/dd hh:mm:ss") + "', " + &
					"'" + is_Matricula_Captacao + "'"
		
	If Not lo_Conexao.of_Insert_Registro(ls_Tabela, ls_Colunas, ls_Values, Ref ll_Row) Then
		gvo_Aplicacao.of_grava_log( "GE548: wf_grava_dados_coleta_matriz: Erro na grava$$HEX2$$e700e300$$ENDHEX$$o da coleta do consentimento. Cliente: " + is_Cliente)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na grava$$HEX2$$e700e300$$ENDHEX$$o da coleta do consentimento na matriz. Cliente: '" + is_Cliente + "'.")
		Return False
	End If
		
	Return True

Finally
	If IsValid(lo_Conexao) Then Destroy(lo_Conexao)	
End Try

end function

public function boolean wf_grava_dados_coleta (datetime pdt_termino_coleta);
String ls_Rede

ls_Rede = gvo_Parametro.id_rede_filial

Insert into coleta_consentimento_lgpd(id_rede, cd_cliente, dh_inicio_coleta, dh_termino_coleta, nr_matricula_coleta)
Values(:ls_Rede, :is_Cliente, :idt_Abertura_Tela, :pdt_termino_coleta, :is_Matricula_Captacao )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_rollback( )
	SqlCa.of_msgdberror( "Erro no insert coleta_consentimento_lgpd. Cliente: " + is_Cliente )
	Return False
End If

//Commit
SqlCa.of_commit( )

Return True

end function

public function boolean wf_atualiza_consentimentos (string as_id_sim, string as_id_nao);Boolean lb_Sucesso = True

Integer li_Row

Long ll_Cd_Tipo

String ls_Sit_Aux
String ls_Aviso
String ls_Consentimentos[]

ls_Consentimentos = {'SMS','WHATSAPP', 'EMAIL', 'LIGACAO','REDE' , 'CORRESPONDENCIA' }

For li_Row = 1 TO UpperBound( ls_Consentimentos[] )
	ls_Aviso = ls_Consentimentos[ li_Row ]
	Choose Case ls_Aviso
        Case 'SMS'
			ll_Cd_Tipo  	= dw_1.Object.cd_tipo_sms					[1]
			ls_Sit_Aux	= dw_1.Object.id_sms						[1]
        Case 'WHATSAPP'
			ll_Cd_Tipo  	= dw_1.Object.cd_tipo_whatsapp			[1]
			ls_Sit_Aux	= dw_1.Object.id_whatsapp					[1]
        Case 'EMAIL'
			ll_Cd_Tipo  	= dw_1.Object.cd_tipo_email				[1]
			ls_Sit_Aux	= dw_1.Object.id_email						[1]
        Case 'LIGACAO'
			ll_Cd_Tipo  	= dw_1.Object.cd_tipo_ligacao				[1]
			ls_Sit_Aux	= dw_1.Object.id_ligacao					[1]
        Case 'REDE'
			ll_Cd_Tipo  	= dw_1.Object.cd_tipo_rede				[1]
			ls_Sit_Aux	= dw_1.Object.id_rede						[1]
        Case 'CORRESPONDENCIA'
			ll_Cd_Tipo  	= dw_1.Object.cd_tipo_correspondencia	[1]
			ls_Sit_Aux	= dw_1.Object.id_correspondencia		[1]
    End Choose  
	
	//Chamado: 1228692 
	If as_id_nao = 'S' Then
		//Marcado significa que o cliente n$$HEX1$$e300$$ENDHEX$$o quer receber contato
		If ls_Sit_Aux = 'A' Then
			ls_Sit_Aux = 'I'
		Else
			ls_Sit_Aux = 'A'
		End If 
	End If
	
//	//Se estiver selecionada a op$$HEX2$$e700e300$$ENDHEX$$o NAO, ser$$HEX1$$e100$$ENDHEX$$ inativado todos os tipos de aviso
//	//Caso contrario, verifica a op$$HEX2$$e700e300$$ENDHEX$$o selecionada na tela
//	If as_situacao = 'I' Then //INATIVO
//		ls_Sit_Aux = as_situacao
//	End If
		
	If Not wf_Grava_Consentimento( ll_Cd_Tipo, ls_Sit_Aux ) Then
		lb_Sucesso = False
	End If 
Next

If lb_Sucesso Then
	SqlCa.of_Commit()
End If

Return lb_Sucesso
end function

on w_ge548_consentimento.create
int iCurrent
call super::create
this.cb_nao_titular=create cb_nao_titular
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_nao_titular
end on

on w_ge548_consentimento.destroy
call super::destroy
destroy(this.cb_nao_titular)
end on

event ue_postopen;call super::ue_postopen;If Not wf_localiza_consentimento(  ) Then
	This.il_retorno = -1
	Close(This)
Else
	This.setredraw(True)
End If


//Armazena o inicio da coleta
idt_Abertura_Tela = gf_GetServerDate()
end event

event ue_preopen;call super::ue_preopen;String ls_Parametro

ls_Parametro = Message.StringParm

//Chamado	1008673
//Pede p/ habilitar o bot$$HEX1$$e300$$ENDHEX$$o Atendimento Telefonico nos cadastros novos.
//Cadastro cliente novo deixar o bot$$HEX1$$e300$$ENDHEX$$o cancelar oculto
//If Mid(ls_Parametro, 1,1)  = 'S' Then
//	cb_cancelar.Visible = False
//Else
//	cb_cancelar.Visible = True
//End If
	
is_Cliente = Mid(ls_Parametro, 2)

This.setredraw(False)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge548_consentimento
integer x = 73
integer y = 56
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge548_consentimento
integer width = 2011
integer height = 812
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge548_consentimento
integer y = 52
integer width = 1915
integer height = 716
string dataobject = "dw_ge548_coleta_consentimento"
end type

event dw_1::itemchanged;call super::itemchanged;String ls_Situacao

If dwo.Name = 'id_sim' Then	
	If Data = 'S' Then 
		This.Object.id_nao[1] = 'N'
		ls_Situacao = 'A'
	Else
		ls_Situacao = 'I'
	End If
		
	This.Object.id_sms				[1] = ls_Situacao
	This.Object.id_whatsapp			[1] = ls_Situacao
	This.Object.id_ligacao			[1] = ls_Situacao
	This.Object.id_email				[1] = ls_Situacao
	This.Object.id_correspondencia[1] = ls_Situacao
	This.Object.id_rede				[1] = ls_Situacao

End If

//Op$$HEX2$$e700e300$$ENDHEX$$o NAO $$HEX1$$e900$$ENDHEX$$ ao contrario da tela, 
// A op$$HEX2$$e700e300$$ENDHEX$$o marcada $$HEX1$$e900$$ENDHEX$$ aquela que o cliente N$$HEX1$$c300$$ENDHEX$$O deseja receber contato.
If dwo.Name = 'id_nao' Then
	If Data = 'S' Then 
		This.Object.id_sim[1] = 'N'
		ls_Situacao = 'I'
	End If	
	
	This.Object.id_sms				[1] = ls_Situacao
	This.Object.id_whatsapp			[1] = ls_Situacao
	This.Object.id_ligacao			[1] = ls_Situacao
	This.Object.id_email				[1] = ls_Situacao
	This.Object.id_correspondencia[1] = ls_Situacao
	This.Object.id_rede				[1] = ls_Situacao
End If

This.acceptText()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge548_consentimento
integer x = 1728
integer y = 844
end type

event cb_ok::clicked;call super::clicked;//Agora por favor, confirme suas permiss$$HEX1$$f500$$ENDHEX$$es atrav$$HEX1$$e900$$ENDHEX$$s do bot$$HEX1$$e300$$ENDHEX$$o verde do pinpad.

Integer li_Retorno

String ls_Sim, ls_Nao, ls_Situacao
String ls_Msg
String ls_Atendimento_Telefonico = 'N'

Datetime ldt_Termino_Coleta

Try
	If Not This.Enabled Then
		Return -1
	End If
	
	Parent.cb_cancelar.Enabled 	= False
	Parent.cb_nao_titular.Enabled 	= False
	This.Enabled 						= False
	
	dw_1.AcceptText()

	ls_Sim = dw_1.Object.id_sim[1]
	ls_Nao = dw_1.Object.id_nao[1]
	
	If ls_Sim = 'N' And ls_Nao = 'N' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma das op$$HEX2$$e700f500$$ENDHEX$$es: Sim / N$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
		Parent.cb_cancelar.Enabled 	= True
		Parent.cb_nao_titular.Enabled 	= True
		This.Enabled 						= True
		Return -1
	End If
	
	If ls_Sim = 'S' And ls_Nao = 'S' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione apenas uma das op$$HEX2$$e700f500$$ENDHEX$$es: Sim / N$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
		Parent.cb_cancelar.Enabled 	= True
		Parent.cb_nao_titular.Enabled 	= True
		This.Enabled 						= True
		Return -1
	End If

	If ls_Sim = 'S' Or ls_Nao = 'S' Then
		//Verifica se pelo menos uma das op$$HEX1$$e700$$ENDHEX$$oes esta marcada
		If dw_1.Object.id_sms						[1] = 'I' And +&
			dw_1.Object.id_whatsapp				[1] = 'I' And +&
			dw_1.Object.id_ligacao					[1] = 'I' And +&
			dw_1.Object.id_email						[1] = 'I' And +&
			dw_1.Object.id_correspondencia		[1] = 'I' And +&
			dw_1.Object.id_rede						[1] = 'I' Then
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma op$$HEX2$$e700e300$$ENDHEX$$o foi selecionada.", Exclamation!)
			Parent.cb_cancelar.Enabled 	= True
			Parent.cb_nao_titular.Enabled 	= True
			This.Enabled 						= True			
			Return -1
		End If
	End If
		
	//Selecionou a op$$HEX2$$e700e300$$ENDHEX$$o N$$HEX1$$e300$$ENDHEX$$o, mostrar mensagem de confirma$$HEX2$$e700e300$$ENDHEX$$o
//	If ls_Nao = 'S' Then
//		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ confirma que o(a) cliente n$$HEX1$$e300$$ENDHEX$$o aceita receber benef$$HEX1$$ed00$$ENDHEX$$cios por nenhum dos meios listados?", Question!, yesNo!, 2) = 2 Then
//			Parent.cb_cancelar.Enabled = True
//			This.Enabled 					= True
//			Return -1			
//		End If
//	End If
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("COLETA_CONSENTIMENTOS_CLIENTE", ref is_Matricula_Captacao) Then 
		SetPointer(Arrow!)
		Parent.cb_cancelar.Enabled 	= True
		Parent.cb_nao_titular.Enabled 	= True
		This.Enabled 						= True
		Return -1
	End If
			
	//Tratamento RL
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then
		ls_Msg = "Tente finalizar o sistema de Caixa deixando somente o sistema Reguarda de Loja aberto."
		
		If IsValid(SITEF) Then Destroy SITEF
		
		If Not FileExists('c:\sistemas\dll\sitef\CliSiTef32I.dll') Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'N$$HEX1$$e300$$ENDHEX$$o existe pinpad configurado neste PDV para realizar a confirma$$HEX2$$e700e300$$ENDHEX$$o dos consentimentos.', Exclamation!)
			Parent.cb_cancelar.Enabled 	= True
			Parent.cb_nao_titular.Enabled 	= True
			This.Enabled 						= True
			Return -1
		End If
		
		SITEF = Create uo_sitef // GE084	
		If Not SITEF.of_configura() Then 
			Parent.cb_cancelar.Enabled 	= True
			Parent.cb_nao_titular.Enabled 	= True
			This.Enabled 						= True
			Return -1
		End If
		If Not SITEF.of_Inicia_Comunicacao() Then
			Parent.cb_cancelar.Enabled 	= True
			Parent.cb_nao_titular.Enabled 	= True
			This.Enabled 						= True
			Return -1
		End If
		Sitef.of_inicializa( )
	Else
		ls_Msg = "Tente finalizar o sistema Retaguarda de Loja deixando somente o sistema de Caixa aberto."
	End If
		
	If Not Sitef.of_confirmacao_pinpad("Favor confirmar a opera$$HEX2$$e700e300$$ENDHEX$$o.", li_Retorno) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Porta de comunica$$HEX2$$e700e300$$ENDHEX$$o do pinpad em uso ou n$$HEX1$$e300$$ENDHEX$$o configurada.~r~r" + ls_Msg , Exclamation!)
		Parent.cb_cancelar.Enabled 	= True
		Parent.cb_nao_titular.Enabled 	= True
		This.Enabled 						= True
		Return -1
	End If
	
	//0-Anula
	//1-Confirma
	If li_Retorno = 0 Then
		Parent.cb_cancelar.Enabled 	= True
		Parent.cb_nao_titular.Enabled 	= True
		This.Enabled 						= True
		Return -1
	End If
	
	If Not wf_Atualiza_Consentimentos( ls_Sim, ls_Nao ) Then
		Parent.cb_cancelar.Enabled 	= True
		Parent.cb_nao_titular.Enabled 	= True
		This.Enabled 						= True
		Return -1
	End If
	
	Try
		gf_ge548_imprime_consentimento_cliente( is_Cliente )
	Catch( runtimeError lre )
		MessageBox("Erro","Erro ap$$HEX1$$f300$$ENDHEX$$s imprimir os consentimentos.~r" +lre.GetMessage() )
	Finally
	End Try
	
	ldt_Termino_Coleta = gf_GetServerDate()
	
	//Atualiza a tabela historico_coleta_consentimento
	If Not gf_ge548_grava_tempo_coleta(is_Cliente, idt_Abertura_Tela, ldt_Termino_Coleta, is_Matricula_Captacao, ls_Atendimento_Telefonico,'S' ) Then
		Parent.cb_cancelar.Enabled 	= True
		Parent.cb_nao_titular.Enabled 	= True
		This.Enabled 						= True
		Return -1
	End If
		
	If IsValid( Parent ) Then
		CloseWithReturn(Parent, 'OK')
	End If
Finally
	If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = "RL" Then
		If IsValid(Sitef) Then Destroy Sitef
	End If
End Try

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge548_consentimento
integer x = 18
integer y = 844
integer width = 713
string text = "Atendimento Telef$$HEX1$$f400$$ENDHEX$$nico"
boolean cancel = false
end type

event cb_cancelar::clicked;//OverRide
String lvs_Retorno
String ls_Parametros

//Desabilita o bot$$HEX1$$e300$$ENDHEX$$o
This.Enabled = False

//Abre tela envio de SMS / EMAIL
ls_Parametros = is_Cliente + "|" + String(idt_Abertura_Tela, 'yyyy/mm/dd hh:mm:ss')

OpenWithParm(w_ge548_consentimento_envio_sms, ls_Parametros)
//Retorno do envio SMS ou EMAIL

//Habilita o bot$$HEX1$$e300$$ENDHEX$$o
This.Enabled = True

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_nao_titular from commandbutton within w_ge548_consentimento
integer x = 809
integer y = 844
integer width = 654
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ o Titular"
end type

event clicked;Datetime ldt_Termino_Coleta

Try
	Parent.cb_cancelar.Enabled = False
	Parent.cb_ok.Enabled			= False	
	This.Enabled 					= False
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma que n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ o titular presente no momento desta compra?", Question!, yesNo!, 2) = 2 Then
		Parent.cb_cancelar.Enabled = True
		Parent.cb_ok.Enabled			= True	
		This.Enabled 					= True
		Return -1			
	End If
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("COLETA_CONSENTIMENTOS_CLIENTE", ref is_Matricula_Captacao) Then 
		Parent.cb_cancelar.Enabled = True
		Parent.cb_ok.Enabled			= True	
		This.Enabled 					= True
		Return -1
	End If
	
	ldt_Termino_Coleta = gf_GetServerDate()
	//Atualiza a tabela historico_coleta_consentimento																		          Fone?|Titular?
	If Not gf_ge548_grava_tempo_coleta(is_Cliente, idt_Abertura_Tela, ldt_Termino_Coleta, is_Matricula_Captacao, '','N' ) Then
		Parent.cb_cancelar.Enabled = True
		Parent.cb_ok.Enabled			= True	
		This.Enabled 					= True			
		Return -1
	End If
	
	If IsValid( Parent ) Then
		CloseWithReturn(Parent, '')
	End If

Finally
	//
End Try


end event

