HA$PBExportHeader$w_ge031_cadastro_cliente_cheque.srw
forward
global type w_ge031_cadastro_cliente_cheque from window
end type
type st_menu_fiscal from statictext within w_ge031_cadastro_cliente_cheque
end type
type pb_help from picturebutton within w_ge031_cadastro_cliente_cheque
end type
type cb_assinatura from commandbutton within w_ge031_cadastro_cliente_cheque
end type
type dw_1 from dc_uo_dw_base within w_ge031_cadastro_cliente_cheque
end type
type cb_cheques from commandbutton within w_ge031_cadastro_cliente_cheque
end type
type cb_liberar from commandbutton within w_ge031_cadastro_cliente_cheque
end type
type cb_sair from commandbutton within w_ge031_cadastro_cliente_cheque
end type
type cb_alterar from commandbutton within w_ge031_cadastro_cliente_cheque
end type
type cb_cancelar from commandbutton within w_ge031_cadastro_cliente_cheque
end type
end forward

global type w_ge031_cadastro_cliente_cheque from window
integer x = 654
integer y = 100
integer width = 2533
integer height = 2064
boolean titlebar = true
string title = "GE031 - Cadastro de Cliente Cheque"
windowtype windowtype = response!
long backcolor = 80269524
boolean center = true
st_menu_fiscal st_menu_fiscal
pb_help pb_help
cb_assinatura cb_assinatura
dw_1 dw_1
cb_cheques cb_cheques
cb_liberar cb_liberar
cb_sair cb_sair
cb_alterar cb_alterar
cb_cancelar cb_cancelar
end type
global w_ge031_cadastro_cliente_cheque w_ge031_cadastro_cliente_cheque

type variables
uo_cliente_cheque	ivo_cliente  //GE032

uo_cliente_cheque	ivo_dependente

uo_cidade			ivo_cidade
dc_uo_ds_base		ids_cheques

String					ivs_retorno
String					ivs_tipo_abertura
Boolean				ivb_Cheque_Central
Long					ivl_Qt_Cheques

String ivs_Texto_Endereco = "Digite aqui o cep ou o endere$$HEX1$$e700$$ENDHEX$$o e pressione [Enter]"
Boolean ivb_valida_salva = false
Boolean ivb_Localizou_Endereco
uo_ge099_endereco ivo_endereco
end variables

forward prototypes
public subroutine wf_inicializa_consulta ()
public function boolean wf_valida_dados_cliente ()
public subroutine wf_localiza_cidade (string ps_cidade)
public function boolean wf_salvar ()
public subroutine wf_consulta_cheques_cliente (string ps_cpf)
public function boolean wf_valida_cpf_cgc (string ps_parametro)
public function boolean wf_cliente_bloqueado_bacen (string as_cpf)
public function boolean wf_cliente_liberado (string ps_cpf_cgc)
public function boolean wf_localiza_cliente (string ps_cpf_cgc)
public function boolean wf_localiza_dependente (string ps_cpf)
public subroutine wf_help (string ps_arquivo)
public subroutine wf_consulta_cheques_central (string ps_cpf)
public subroutine wf_envia_email (string ps_cpf, long pl_cheques)
public function boolean wf_consulta_situacao_central (string ps_cpf, ref string ps_situacao)
public subroutine wf_localiza_endereco ()
public subroutine wf_centraliza_janela ()
end prototypes

public subroutine wf_inicializa_consulta ();Long ll_filial

ll_filial = gvo_Parametro.of_filial()

//Inicializa Tela de Consulta
dw_1.SetReDraw(False)
dw_1.Reset()
dw_1.InsertRow(0)
dw_1.object.id_habilita_alteracao		[1] = 'N'
dw_1.object.cd_filial_inclusao			[1] = ll_filial
dw_1.Object.dh_Inclusao				[1] = gf_GetServerDate()
dw_1.Object.nr_Matricula_Inclusao	[1] = gvo_Aplicacao.ivo_Seguranca.nr_Matricula
dw_1.object.nr_cpf.protect = 0
dw_1.SetTabOrder('de_endereco', 0)
dw_1.SetTabOrder('de_bairro', 0)
dw_1.SetTabOrder('nm_cidade', 0)
dw_1.SetFocus()
dw_1.SetReDraw(True)
dw_1.Object.nr_cpf_dependente.Protect = 1

//Tamanho original da janela

This.Height = 2100

ids_cheques.Reset()

cb_liberar.Enabled		= False
cb_cancelar.Enabled	= False
cb_alterar.Enabled		= False
cb_cheques.Enabled	= False

//cb_liberar.Default	= True

//Limpa objeto cidade
SetNull(ivo_cidade.cd_cidade)
ivo_cidade.nm_cidade = ''
ivo_endereco.of_inicializa()

dw_1.Event ue_Pos(1, "nr_cpf")

end subroutine

public function boolean wf_valida_dados_cliente ();DateTime ldh_Data_Nasc

Long lvl_cidade

String	lvs_nr_cpf, &
		lvs_rg, &
		lvs_nm_cliente, &
		lvs_de_endereco, &
		lvs_de_bairro, &
		lvs_nr_cep, &
		lvs_nr_ddd, &
		lvs_nr_telefone, &
		ls_Nr_Endereco, &
		ls_Nr_Cpf_Dependente, &
		ls_Mae, &
		ls_email,&
		lvs_DDD_Cel,&
		lvs_Fone_Cel 
		
dw_1.AcceptText()
	
lvs_nr_cpf					= dw_1.object.nr_cpf						[1]
lvs_rg							= dw_1.object.nr_rg						[1]
lvs_nm_cliente				= dw_1.object.nm_cliente				[1]
lvl_cidade					= dw_1.object.cd_cidade				[1]
lvs_de_endereco			= dw_1.object.de_endereco				[1]
lvs_de_bairro				= dw_1.object.de_bairro					[1]
lvs_nr_cep					= dw_1.object.nr_cep					[1]
lvs_nr_ddd					= dw_1.object.nr_ddd_telefone		[1]
lvs_nr_telefone				= dw_1.object.nr_telefone				[1]
ls_Nr_Endereco				= dw_1.Object.Nr_Endereco			[1]
ls_Nr_Cpf_Dependente	= dw_1.Object.Nr_Cpf_Dependente	[1]
ls_Mae						= dw_1.Object.Nm_Mae					[1]
ldh_Data_Nasc				= dw_1.Object.Dh_Nascimento			[1]
ls_Email						= dw_1.Object.De_Endereco_Email	[1]
lvs_DDD_Cel					= dw_1.Object.nr_ddd_celular			[1]
lvs_Fone_Cel 				= dw_1.Object.nr_celular				[1]

If Not wf_valida_cpf_cgc(lvs_nr_cpf) Then Return False

If Not IsNull(ls_Nr_Cpf_Dependente) And Trim(ls_Nr_Cpf_Dependente) <> "" Then
	If Not wf_valida_cpf_cgc(ls_Nr_Cpf_Dependente) Then
		dw_1.Event ue_Pos(1, "nr_cpf_dependente")
		Return False
	End If
End If

If LenA(Trim(lvs_nr_cpf)) = 11 Then                           // Valida rg somente para clientes pf
	If IsNull(lvs_rg) or Trim(lvs_rg) = '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o R.G. do cliente.",Exclamation!)
		dw_1.SetColumn('nr_rg')
		dw_1.SetFocus()
		Return False
	End If	
Else
	dw_1.object.nr_rg[1] = '.'
End If	
	
If IsNull(lvs_nm_cliente) or Trim(lvs_nm_cliente) = '' or LenA(lvs_nm_cliente) < 6 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o nome do cliente.",Exclamation!)
	dw_1.SetColumn('nm_cliente')
	dw_1.SetFocus()
	Return False
End If	

If IsNull(lvs_de_endereco) or Trim(lvs_de_endereco) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o endere$$HEX1$$e700$$ENDHEX$$o completo.",Exclamation!)
	dw_1.SetColumn('de_endereco')	
	dw_1.SetFocus()	
	Return False
End If

If IsNull(ls_Nr_Endereco) Or Trim(ls_Nr_Endereco) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o n$$HEX1$$fa00$$ENDHEX$$mero do endere$$HEX1$$e700$$ENDHEX$$o.", Exclamation!)
	dw_1.SetColumn('nr_endereco')
	dw_1.SetFocus()	
	Return False
End If

if IsNull(lvs_nr_cep) or Trim(lvs_nr_cep)	= '' then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o cep do cliente.",Exclamation!)
	dw_1.SetColumn('nr_cep')
	dw_1.SetFocus()
	Return False
Else
	If Not ivo_Endereco.of_Existe_Cep(trim(lvs_nr_cep)) And not ivo_Endereco.ivb_Libera_Digitacao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CEP informado n$$HEX1$$e300$$ENDHEX$$o foi localizado no cadastro de endere$$HEX1$$e700$$ENDHEX$$os.", StopSign!)
		dw_1.Event ue_Pos( 1, 'Localiza_endereco' )
		Return False
	End If
End if


If IsNull(lvs_de_bairro) or Trim(lvs_de_bairro) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o bairro.",Exclamation!)
	dw_1.SetColumn('de_bairro')	
	dw_1.SetFocus()	
	Return False
End If	


If IsNull(lvl_cidade) or lvl_cidade = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a cidade do cliente.",Exclamation!)
	dw_1.SetColumn('nm_cidade')
	dw_1.SetFocus()
	Return False
Else
	wf_localiza_cidade(string(lvl_cidade))
End If	

If IsNull(lvs_nr_ddd) or Trim(lvs_nr_ddd) = '' or LenA(lvs_nr_ddd) <> 2 or Long(lvs_nr_ddd) < 11 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o DDD do telefone do cliente corretamente (2 d$$HEX1$$ed00$$ENDHEX$$gitos).",Exclamation!)
	dw_1.SetColumn('nr_ddd_telefone')		
	dw_1.SetFocus()	
	Return False
End If	

If IsNull(lvs_nr_telefone) or Trim(lvs_nr_telefone) = '' or LenA( lvs_nr_telefone ) < 8 or LenA( lvs_nr_telefone) > 8 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o Telefone corretamente.",Exclamation!)
	dw_1.SetColumn('nr_telefone')		
	dw_1.SetFocus()	
	Return False
End If

If (Not IsNull( lvs_nr_ddd ) And IsNull( lvs_nr_telefone )) or ( IsNull( lvs_nr_ddd ) And Not IsNull( lvs_nr_telefone ) ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "DDD do telefone residencial ou Telefone n$$HEX1$$e300$$ENDHEX$$o foi preenchido, favor verificar.", Exclamation! )
	dw_1.Event ue_Pos(1, "nr_telefone")
	Return false
End If

// Valida$$HEX2$$e700e300$$ENDHEX$$o do DDD celular
If Not IsNull( lvs_DDD_Cel ) and (Not IsNull(lvs_Fone_cel) and lvs_Fone_cel <> '' )Then
	If LenA( lvs_DDD_Cel ) <> 2 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone celular corretamente (2 d$$HEX1$$ed00$$ENDHEX$$gitos).", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_ddd_celular")
		Return False
	End If
	If Long(lvs_DDD_Cel) < 11 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O DDD do telefone celular n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_ddd_celular")
		Return false
	End If			
End If

// Telefone preenchido deve ter o DDD preenchido corretamente, e o telefone deve ter no m$$HEX1$$ed00$$ENDHEX$$nimo 9 d$$HEX1$$ed00$$ENDHEX$$gitos sem incluir o DDD no mesmo campo
If Not IsNull( lvs_Fone_Cel ) and ( Not IsNull(lvs_DDD_Cel) and lvs_DDD_Cel <> ''  ) Then
	If LenA( lvs_Fone_Cel ) < 9 Or LenA( lvs_Fone_Cel ) > 9 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O telefone celular informado n$$HEX1$$e300$$ENDHEX$$o possui 9 d$$HEX1$$ed00$$ENDHEX$$gitos.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_celular")
		Return false
	End If

	If Not IsNull( lvs_DDD_Cel ) Then
		If lvs_DDD_Cel = LeftA( lvs_Fone_Cel, 2 ) Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o preencha o DDD do celular no mesmo campo do N$$HEX1$$da00$$ENDHEX$$MERO do telefone.", Exclamation! )
			dw_1.Event ue_Pos(1, "nr_ddd_celular")
			Return false
		End If
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone celular.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_ddd_celular")		
		Return False
	End If
End If

If (Not IsNull( lvs_DDD_Cel ) And IsNull( lvs_Fone_Cel )) or ( IsNull( lvs_DDD_Cel ) And Not IsNull( lvs_Fone_Cel ) ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "DDD do telefone celular ou celular n$$HEX1$$e300$$ENDHEX$$o foi preenchido, favor verificar.", Exclamation! )
	dw_1.Event ue_Pos(1, "nr_telefone")
	Return false
End If

If Not IsNull(ls_email) Then
	If Not gf_Valida_Email(ls_email) Then
		dw_1.SetColumn('de_endereco_email')
		dw_1.SetFocus()
		Return False
	End If
End If

If LenA(Trim(lvs_nr_cpf)) = 11 Then
	If Not gf_Valida_Informacoes_Cliente(ls_Mae, 1) Then
		dw_1.Event ue_Pos(1, "nm_mae")
		Return False
	End If
	
	If IsNull(ldh_Data_Nasc) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de nascimento.", Exclamation!)
		dw_1.SetColumn('dh_nascimento')
		dw_1.SetFocus()
		Return False
	End If
	
	If Date(ldh_Data_Nasc) < Date("01/01/1800") or Date(ldh_Data_Nasc) > Today() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de nascimento do cliente deve ser entre '01/01/1800' e '" + String(Today(), "dd/mm/yyyy") + "'.", Information!)
		dw_1.SetColumn('dh_nascimento')
		dw_1.SetFocus()
		Return False
	End If
End If

If lvs_Nr_Cpf = ls_Nr_Cpf_Dependente Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cliente e dependente n$$HEX1$$e300$$ENDHEX$$o podem ser o mesmo.", StopSign!)
	dw_1.Event ue_Pos(1, "nr_cpf_dependente")
	Return False
End If

Return True
end function

public subroutine wf_localiza_cidade (string ps_cidade);ivo_Cidade.of_Localiza_Cidade(ps_Cidade)

If ivo_Cidade.Localizada Then
	dw_1.Object.Cd_Cidade[1] = ivo_Cidade.Cd_Cidade
	dw_1.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
End If

end subroutine

public function boolean wf_salvar ();DateTime lvdh_Movimentacao

Long     lvl_Filial

SetPointer(HourGlass!)

If Not wf_valida_dados_cliente() Then Return False
	
lvdh_Movimentacao = gvo_parametro.of_dh_movimentacao()
lvl_filial        = gvo_parametro.cd_filial

dw_1.Object.cd_filial_atualizacao			[1] = lvl_Filial
dw_1.Object.dh_atualizacao					[1] = lvdh_Movimentacao
dw_1.Object.nr_Matricula_Atualizacao	[1] = gvo_Aplicacao.ivo_Seguranca.nr_Matricula

If dw_1.Update() = 1 Then	
	SqlCa.of_Commit()
	Return True	
Else		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao salvar dados do cliente.~n~nErro: " + Sqlca.SqlErrText ,StopSign!)	
	Sqlca.of_RollBack()
	Return False	
End If
end function

public subroutine wf_consulta_cheques_cliente (string ps_cpf);Date     lvdt_Movimento

lvdt_Movimento = Date(gvo_Parametro.of_dh_Movimentacao())
lvdt_Movimento = RelativeDate(lvdt_Movimento, -10)

//Verifica cheques pendentes
ids_cheques.Retrieve(ivo_cliente.nr_cpf,lvdt_Movimento)

//Habilita bot$$HEX1$$e300$$ENDHEX$$o para mostrar cheques Pendentes
If ids_cheques.RowCount() > 0 Then cb_cheques.Enabled = True




end subroutine

public function boolean wf_valida_cpf_cgc (string ps_parametro);Boolean lvb_Retorno

ps_parametro = Trim(ps_parametro)

If LenA(ps_parametro) = 11 Then                         //Valida cpf
	lvb_Retorno = gf_nr_cpf_valido(ps_parametro)
ElseIf LenA(ps_parametro) = 14 Then
	lvb_Retorno = gf_cgc_valido(ps_parametro)           //Valida cgc
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o CPF ou CNPJ v$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
End If

Return lvb_Retorno
end function

public function boolean wf_cliente_bloqueado_bacen (string as_cpf);Boolean lvb_Bloqueado = False

/*
Novo - Depende de altera$$HEX2$$e700e300$$ENDHEX$$o na ge105 : of_consulta_cheque : alterar de base de teste para produ$$HEX2$$e700e300$$ENDHEX$$o
*/

If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Homologacao","") = 'S' Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Transa$$HEX2$$e700e300$$ENDHEX$$o com cheque no ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o. Sem valida$$HEX2$$e700e300$$ENDHEX$$o de CPF.")
	Return False
End If

uo_transacao_remota lo_SD

lo_SD = Create uo_transacao_remota

lvb_Bloqueado = lo_SD.of_Consulta_Cheque(as_CPF)

If lvb_Bloqueado = False Then
	cb_liberar.Enabled	= False
End If

Destroy lo_SD

Return Not lvb_Bloqueado
end function

public function boolean wf_cliente_liberado (string ps_cpf_cgc);Long    lvl_find
String ls_mensagem
String ls_bloqueio_central

Boolean lvb_Retorno = True

ivo_Cliente.of_localiza_cpf_cgc(ps_cpf_cgc)

Choose Case ivo_Cliente.id_bloqueado
	Case 'N'	

		If ids_cheques.RowCount() > 0 Then 			// Cheques Pendentes, devolvidos
		
			lvl_find = ids_cheques.Find('Not IsNull(dh_devolucao) and IsNull(dh_baixa)',1,ids_cheques.RowCount())
			
			If lvl_find > 0  Then  // Caso exista cheques devolvidos
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Libera$$HEX2$$e700e300$$ENDHEX$$o bloqueada. Cliente possui cheque(s) devolvido(s)." + "~n~nMais detalhes clique em [Cheques]",StopSign!)
				lvb_Retorno = False
			ElseIf lvl_find = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find.",StopSign!)
				lvb_Retorno = False
			Else
				wf_consulta_cheques_central(ps_cpf_cgc)
				lvb_Retorno = gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_VENDA_CHEQUE")
				If lvb_Retorno Then
					If ivb_cheque_central And ivl_qt_cheques >= 3 Then
						//Envia e-mail de alerta
						wf_envia_email(ps_cpf_cgc, ivl_qt_cheques)
					End If
				End If
			End If
		Else
			wf_consulta_cheques_central(ps_cpf_cgc)
			If ivb_cheque_central Then
				lvb_Retorno = gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_VENDA_CHEQUE")
				If lvb_Retorno Then				
					If ivl_qt_cheques >= 3 Then
						//Envia e-mail de alerta
						wf_envia_email(ps_cpf_cgc, ivl_qt_cheques)					
					End If
				End If
			End If			
		End If

	Case 'P'
		If IsNull(ivo_cliente.de_bloqueio) Then
			ls_mensagem = "Cliente bloqueado por pend$$HEX1$$ea00$$ENDHEX$$ncias no Cadastro. ~n~n~Deseja liberar venda ?"			
		Else
			ls_mensagem = "Cliente bloqueado : " + ivo_cliente.de_bloqueio + "~n~n~Deseja liberar venda ?"
		End If
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_mensagem, Question!,YesNo!,1) = 1 Then
			lvb_Retorno = gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_VENDA_CHEQUE")
		Else
			lvb_Retorno = False
		End If	
				
	Case 'S'
		//Verifica se o bloqueio ainda existe no Central.
		If wf_consulta_situacao_central(ps_cpf_cgc, Ref ls_bloqueio_central) Then
			If ls_bloqueio_central <> 'S' Then
				Return lvb_Retorno				
			End If
		End If
		If IsNull(ivo_cliente.de_bloqueio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente bloqueado!",Exclamation!)			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente bloqueado ~n~nMotivo : " + ivo_cliente.de_bloqueio,Exclamation!)			
		End If
		lvb_Retorno = False
		
End Choose

Return lvb_Retorno
end function

public function boolean wf_localiza_cliente (string ps_cpf_cgc);String ls_Dependente

dw_1.AcceptText()

If Not wf_valida_cpf_cgc(ps_cpf_cgc) Then
	dw_1.Event ue_Pos( 1, "Nr_Cpf" )
	Return False
End If

dw_1.object.nr_cpf.protect = 1
dw_1.Object.nr_cpf_dependente.Protect = 1

If wf_Cliente_Bloqueado_Bacen(ps_cpf_cgc) Then Return False
	
ivo_Cliente.of_localiza_cpf_cgc(ps_cpf_cgc)

If ivo_Cliente.Localizado Then
	
	If ivo_Cliente.ivs_Fisica_Juridica = 'F'	Then This.Height = 2100
	If ivo_Cliente.ivs_Fisica_Juridica = 'J'	Then This.Height = 1100
	cb_liberar.Enabled = True
	dw_1.Retrieve(ps_cpf_cgc)
	
	ls_Dependente = dw_1.Object.Nr_Cpf_Dependente[1]
	
	wf_Localiza_Dependente( ls_Dependente )
	
	If Not IsNull(ls_Dependente) And Trim(ls_Dependente) <> ""Then
		If wf_Cliente_Bloqueado_Bacen(ls_Dependente) Then Return False
	End If

	//Localiza cidade do cliente
	ivo_cidade.of_localiza_codigo( dw_1.object.cd_cidade[1] )
	
	//Verifica cheques pendentes, devolvidos
	wf_Consulta_Cheques_Cliente( ps_cpf_cgc )
	dw_1.object.id_habilita_alteracao[1] = 'N'
	cb_Alterar.Text			=	"&Alterar"
	cb_Alterar.Enabled	=	True
Else
	If LenA(ps_cpf_cgc) = 14 Then
		This.Height = 1100
	End If
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente n$$HEX1$$e300$$ENDHEX$$o localizado. Deseja cadastr$$HEX1$$e100$$ENDHEX$$-lo ?",Question!,YesNo!,1) = 1 Then
		dw_1.object.id_habilita_alteracao[1] = 'S'
		
		If LenA(ps_cpf_cgc) = 14 Then
			dw_1.object.id_bloqueado[1] = 'P'
			dw_1.object.de_bloqueio [1] = 'PENDENTE ANALISE DE CADASTRO'
		End If	
		
		//Protege o CPF digitado
		dw_1.Event ue_Pos( 1, "nr_rg" )
		
		cb_liberar.Enabled	= False
		cb_Alterar.Text			=	"&Cadastrar"
		cb_Alterar.Enabled	=	True
	Else
		dw_1.object.nr_cpf.protect = 0
		dw_1.Object.Nr_Cpf[1] = ''
		This.Height = 2100
		Return False
	End If
End If

Return True
end function

public function boolean wf_localiza_dependente (string ps_cpf);If Trim(ps_Cpf) <> "" Then
	If wf_Valida_Cpf_Cgc(ps_Cpf) Then 
		ivo_Dependente.of_localiza_cpf_cgc(ps_Cpf)
					
		If ivo_Dependente.Localizado Then
			dw_1.Object.Nm_Dependente[1] = ivo_Dependente.Nm_Cliente
			cb_alterar.Text = '&Salvar'
			Return True
		End If
	End If
End If

Return False
end function

public subroutine wf_help (string ps_arquivo);ShowHelp( gvo_Aplicacao.ivs_Path_Manual, KeyWord!, ps_Arquivo )
end subroutine

public subroutine wf_consulta_cheques_central (string ps_cpf);Date     lvdt_Movimento
String	  ls_Retorno
Long 	  ll_Retorno
Long	  ll_cheques

lvdt_Movimento = Date(gvo_Parametro.of_dh_Movimentacao())
lvdt_Movimento = RelativeDate(lvdt_Movimento, -2)

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ds_ge031_cheques_central") Then
	Destroy(lvds_1)
	Return
End If

lvds_1.of_AppendWhere("cheque.nr_cpf_cliente = '" + ps_cpf + "' and cheque.dh_emissao >= '" + String(lvdt_Movimento,'YYYYMMDD') + "'")

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Retrieve(lvds_1.GetSQLSelect(), Ref ls_Retorno)

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else
	If Not IsNull(ls_Retorno) And Trim(ls_Retorno) <> '' Then
		ll_Retorno = lvds_1.ImportString(ls_Retorno)
		
		If ll_Retorno > 0 Then
			ll_cheques = lvds_1.RowCount()
			If ll_cheques > 0 Then
				ivb_cheque_central = True
				ivl_qt_cheques = ll_cheques
			End If
		End If
	End If

End If

Destroy lvo_Conexao
Destroy lvds_1

Return
end subroutine

public subroutine wf_envia_email (string ps_cpf, long pl_cheques);Date     lvdt_Movimento

String ls_Cabecalho
String ls_msg
String ls_titulo
String ls_retorno
String ls_To[]
String ls_Cc[]
String ls_Co[]

Long ll_row
Long ll_retorno
Long ll_Ind_To
Long ll_Ind_CC
Long ll_Ind_CO

lvdt_Movimento = Date(gvo_Parametro.of_dh_Movimentacao())

ls_Cabecalho = "<font face='verdana' size='1'>'Este $$HEX1$$e900$$ENDHEX$$ um email autom$$HEX1$$e100$$ENDHEX$$tico. Favor n$$HEX1$$e300$$ENDHEX$$o responder esta mensagem.'</font><br /><br />" + &
		 "ALERTA De Recebimento de CHEQUES - Filial: " + String(gvo_parametro.cd_filial) + ". <p><p>"

ls_msg =  ls_msg + "Cliente de CPF/CNPJ: " + ps_cpf + " esta fazendo nova compra com cheque. " + &
						" Na filial " + String(gvo_parametro.cd_filial) + &
						". O Cliente j$$HEX1$$e100$$ENDHEX$$ tem " + String(pl_cheques)  + " lan$$HEX1$$e700$$ENDHEX$$ados na rede nos ultimos dias. <p><p>"

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ds_ge031_email_envio") Then
	Destroy(lvds_1)
Else
	lvds_1.of_AppendWhere("m.cd_mensagem = 22")	

	uo_Transacao_Remota lvo_Conexao
	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao()
	
	lvo_Conexao.of_Retrieve(lvds_1.GetSQLSelect(), Ref ls_Retorno)
	
	If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
		ll_Retorno = 0
	Else
		If IsNull(ls_Retorno) Or Trim(ls_Retorno) = '' Then
			ll_Retorno = 0
		Else
			ll_Retorno = lvds_1.ImportString(ls_Retorno)
			
			If ll_Retorno >= 0 Then
				ll_Row = 0
				For ll_Row = 1 To lvds_1.RowCount()
					ls_Titulo = lvds_1.Object.de_assunto[ll_Row] + ": " + String(gvo_parametro.cd_filial)					

					Choose Case lvds_1.Object.id_tipo_envio[ll_Row]
						Case 'TO'
							ll_Ind_To ++
							ls_To[ll_Ind_To] = lvds_1.Object.de_email[ll_Row]							
						Case 'CC'
							ll_Ind_Cc ++
							ls_Cc[ll_Ind_Cc] = lvds_1.Object.de_email[ll_Row]							
						Case 'CO'
							ll_Ind_Co ++
							ls_Co[ll_Ind_Co] = lvds_1.Object.de_email[ll_Row]														
					End Choose						
				Next
				
				uo_smtp lvo_smtp
				lvo_smtp = Create uo_smtp
									
				lvo_Smtp.ib_grava_log_db = False

				lvo_smtp.of_envia_email("ALERTA DE SISTEMA", &
											  "sistemas@clamed.com.br", + &
											  ls_Titulo, + &
											  ls_cabecalho + ls_Msg, + &
											  ls_To,ls_Cc,ls_Co)			
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar os dados do servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
			End If
		End If
	End If		
End If

Destroy(lvo_Conexao)
Destroy(lvds_1)	
Destroy(lvo_smtp)	


end subroutine

public function boolean wf_consulta_situacao_central (string ps_cpf, ref string ps_situacao);String lvs_Select, &
		 lvs_Retorno

Boolean lb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
		
lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina('0006',{"select id_bloqueado from cliente_cheque Where nr_cpf = '" + ps_cpf + "'"})

If Not lvo_Conexao.of_Erro_Execucao() Then

	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno('id_bloqueado', Ref ps_situacao) Then				
			lb_Sucesso = True
		End If
	End If
	
End If

Destroy lvo_Conexao

Return lb_Sucesso
end function

public subroutine wf_localiza_endereco ();String lvs_Cep

Long ll_Cidade_Informada
dw_1.AcceptText()

ivo_Endereco.of_inicializa( )
lvs_Cep = trim(dw_1.Object.Localiza_Endereco[1])
ll_Cidade_Informada = dw_1.Object.Cd_Cidade[1]

If IsNull( ll_Cidade_Informada ) Or ll_Cidade_Informada = 0 Then ll_Cidade_Informada = gvo_Parametro.Cd_Cidade

ivo_Endereco.ivl_Cidade_Informada = ll_Cidade_Informada

//Se o usu$$HEX1$$e100$$ENDHEX$$rio informou hifen na pesquisa o sistema retira pra fazer a consulta
lvs_Cep = gf_ge099_Remove_Hifen_Cep(lvs_Cep)
ivo_Endereco.of_Localiza_endereco(lvs_Cep)

ivb_Localizou_Endereco = True

If ivo_Endereco.Localizado Then
	ivo_Cidade.of_Localiza_Cidade(String(ivo_Endereco.Cd_Cidade))
	
	dw_1.Object.nr_cep[1] = ivo_Endereco.nr_cep
	
	If ivo_Endereco.ivb_Libera_Digitacao Then
		dw_1.SetTabOrder('de_endereco', 50)
		//dw_1.SetTabOrder('Nm_cidade', 130)
		dw_1.SetTabOrder('de_bairro', 70)
		
		dw_1.Object.de_endereco	[1] = ""
		dw_1.Object.de_bairro		[1] = ""
		
		dw_1.Event ue_pos(1, 'de_endereco')		
	Else
		dw_1.SetTabOrder('de_endereco', 0)
		dw_1.SetTabOrder('de_bairro', 0)
		//dw_1.SetTabOrder('Nm_cidade', 0)		
		
		dw_1.Object.Nm_cidade		[1] = ivo_Endereco.Nm_cidade
		dw_1.Object.cd_cidade  		[1] = ivo_Endereco.cd_cidade
		dw_1.Object.de_endereco	[1] = ivo_Endereco.de_endereco
		dw_1.Object.de_bairro  		[1] = MidA(ivo_Endereco.de_bairro, 1, 20)
	End If
	
	// Se o campo bairro for maior que 20 pega bairro abreviado <> ''.		
	If LenA(ivo_Endereco.de_bairro) > 20 Then		
		If ivo_Endereco.de_bairro_abreviado <> "" and Not IsNull(ivo_Endereco.de_bairro_abreviado) Then
			dw_1.Object.de_bairro[1] = MidA(ivo_Endereco.de_bairro_abreviado, 1, 20)
		End If
	End If	
	
	// Se campo endereco for > 40 pega endereco abreviado que tem 36 caracteres.
	If LenA(ivo_Endereco.de_endereco) > 40 Then
		dw_1.Object.de_endereco[1] = ivo_Endereco.de_endereco_abreviado
	End If
	
Else
	dw_1.Event ue_pos(1, 'Localiza_Endereco')
End If

dw_1.Object.Localiza_Endereco[1] = ivs_Texto_Endereco
end subroutine

public subroutine wf_centraliza_janela ();Window w_Parent
w_Parent = ParentWindow()

This.X = (w_Parent.WorkSpaceWidth () - This.Width ) / 2
This.Y = (w_Parent.WorkSpaceHeight() - This.Height) / 2

This.Show()
end subroutine

on w_ge031_cadastro_cliente_cheque.create
this.st_menu_fiscal=create st_menu_fiscal
this.pb_help=create pb_help
this.cb_assinatura=create cb_assinatura
this.dw_1=create dw_1
this.cb_cheques=create cb_cheques
this.cb_liberar=create cb_liberar
this.cb_sair=create cb_sair
this.cb_alterar=create cb_alterar
this.cb_cancelar=create cb_cancelar
this.Control[]={this.st_menu_fiscal,&
this.pb_help,&
this.cb_assinatura,&
this.dw_1,&
this.cb_cheques,&
this.cb_liberar,&
this.cb_sair,&
this.cb_alterar,&
this.cb_cancelar}
end on

on w_ge031_cadastro_cliente_cheque.destroy
destroy(this.st_menu_fiscal)
destroy(this.pb_help)
destroy(this.cb_assinatura)
destroy(this.dw_1)
destroy(this.cb_cheques)
destroy(this.cb_liberar)
destroy(this.cb_sair)
destroy(this.cb_alterar)
destroy(this.cb_cancelar)
end on

event close;Destroy(ivo_cliente)
Destroy(ivo_cidade)
Destroy(ids_cheques)
Destroy(ivo_Dependente)

CloseWithReturn(This,ivs_retorno)
end event

event open;//wf_centraliza_janela()

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CL' Or gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'DE' Then
	cb_liberar.Visible			= True
	pb_help.Visible 			= False
	st_menu_fiscal.Visible 	= True
Else
	This.ivs_tipo_abertura = Message.StringParm 
	If This.ivs_tipo_abertura = 'R' Then
		cb_liberar.Visible	= True
		pb_help.Visible 	= False
	Else
		cb_liberar.Visible	= False
		pb_help.Visible		= True		
	End If
End If

ivo_cliente			= Create uo_cliente_cheque
ivo_cidade			= Create uo_cidade
ivo_Dependente	= Create uo_Cliente_Cheque
ids_cheques			= Create dc_uo_ds_base
ivo_Endereco 		= Create uo_ge099_endereco

ids_cheques.of_ChangeDataObject( "dw_ge031_cheques_pendentes" )

wf_inicializa_consulta()

ivs_retorno = ''
end event

type st_menu_fiscal from statictext within w_ge031_cadastro_cliente_cheque
boolean visible = false
integer x = 1984
integer y = 1776
integer width = 443
integer height = 160
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "MENU FISCAL INACESS$$HEX1$$cd00$$ENDHEX$$VEL NESTA TELA"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_help from picturebutton within w_ge031_cadastro_cliente_cheque
integer x = 2350
integer y = 44
integer width = 142
integer height = 120
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question_1.png"
alignment htextalign = left!
end type

event clicked;wf_Help( "Cadastro de Cliente Cheque (GE031)" )
end event

type cb_assinatura from commandbutton within w_ge031_cadastro_cliente_cheque
integer x = 1943
integer y = 512
integer width = 549
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Consulta Assinatura"
end type

event clicked;//GE0036 - uo_ajuda_convenio

uo_ajuda_convenio lvo_Ajuda
lvo_Ajuda = Create uo_ajuda_convenio

lvo_Ajuda.of_Manual_Atendimento(String(dw_1.Object.Nr_Cpf[1]), 'htm')

Destroy lvo_Ajuda
end event

type dw_1 from dc_uo_dw_base within w_ge031_cadastro_cliente_cheque
integer x = 37
integer y = 32
integer width = 1897
integer height = 1936
string dataobject = "dw_ge031_cadastro_cliente_cheque"
boolean livescroll = false
end type

event editchanged;// Override

cb_cancelar.Enabled = True

If dwo.Name <> "localiza_endereco" Then
	ivb_Valida_Salva = True
End If


end event

event itemchanged;call super::itemchanged;String lvs_Nulo

SetNull(lvs_Nulo)

Choose Case dwo.Name
			
	Case "nm_cidade"
		If Data <> ivo_Cidade.Nm_Cidade Then
			Return 1
		End If
			
End Choose
end event

event itemfocuschanged;call super::itemfocuschanged;String lvs_Coluna

lvs_Coluna = dwo.name 

If cb_Alterar.Enabled Then
	If lvs_Coluna = "nm_cidade" or lvs_Coluna = "localiza_endereco" Then
		cb_Alterar.Default = False   
	Else  											 // Evita que o enter para localiza$$HEX2$$e700e300$$ENDHEX$$o da cidade
		cb_Alterar.Default = True          // execute o clicked do bot$$HEX1$$e300$$ENDHEX$$o [cadastrar]
	End If 											 
End If

SelectText(1,50)
end event

event losefocus;call super::losefocus;If IsValid(ivo_Cidade) Then
	This.Object.Cd_Cidade[1] = ivo_Cidade.Cd_Cidade
	This.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
End If
end event

event ue_key;String	lvs_Coluna,&
       	lvs_Texto

lvs_Coluna = dw_1.GetColumnName() 

If key = KeyEnter! Then

	lvs_Texto = dw_1.GetText()

	Choose Case lvs_Coluna
		Case "nr_cpf"
			dw_1.Object.Localiza_Endereco[1] = ivs_Texto_Endereco
			
			cb_liberar.Default = False
			
			If LenA(lvs_Texto) = 11 Or LenA(lvs_Texto) = 14 Then
				wf_Localiza_Cliente(lvs_Texto)
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe CPF/CNPJ v$$HEX1$$e100$$ENDHEX$$lido!")				
			End If
			cb_alterar.Default	= false
			
		Case "nm_cidade"
			wf_localiza_cidade(lvs_Texto)
			
		Case "nr_cpf_dependente"
			cb_alterar.Default = False
						
			If Not ivo_Cliente.Localizado Then
				
				// Desabilita o campo nr_cpf_dependente da salva, salva
				// o cadastro e reabilita o campo nr_cpf_dependente para salva
				This.Modify( "nr_cpf_dependente.update = No" )
				If cb_alterar.Event Clicked() = -1 Then
					Return -1
				End If
				This.Modify( "nr_cpf_dependente.update = Yes" )
				
				ivo_Cliente.of_Localiza_Cpf_Cgc(This.Object.Nr_Cpf[1])
			End If
				
			If wf_Valida_Cpf_Cgc(lvs_Texto) Then
				If Not wf_Localiza_Dependente(lvs_Texto) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dependente n$$HEX1$$e300$$ENDHEX$$o localizado, o mesmo dever$$HEX1$$e100$$ENDHEX$$ ser cadastrado.")
					
					ivo_Cliente.Nr_Cpf_Dependente = lvs_Texto
					OpenWithParm(w_ge031_cadastro_cliente_cheque_dependente, ivo_Cliente)
					lvs_Texto = Message.StringParm
					
					If lvs_Texto <> "" Then
						wf_Localiza_Dependente(lvs_Texto)
						If wf_Cliente_Bloqueado_Bacen(lvs_Texto) Then Return -1
					Else
						dw_1.Object.Nr_Cpf_Dependente[1] = ""
					End If
				End If
			End If
		
		Case "localiza_endereco"
			wf_localiza_endereco()
		
		Case "nr_cep"
			wf_localiza_endereco()
		
		Case Else
			If cb_Alterar.Enabled Then
				cb_Alterar.Default = True
			End If
			
	End Choose

End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	dw_1.Object.Localizacao_Endereco[1] = ivs_Texto_Endereco
	return 1
end if
end event

type cb_cheques from commandbutton within w_ge031_cadastro_cliente_cheque
integer x = 1943
integer y = 396
integer width = 549
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cheques"
end type

event clicked;ivo_Cliente.of_consulta_pendencias()
end event

event getfocus;This.Weight = 700
end event

event losefocus;This.Weight = 400
end event

type cb_liberar from commandbutton within w_ge031_cadastro_cliente_cheque
integer x = 1943
integer y = 44
integer width = 549
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Liberar"
end type

event clicked;String lvs_cpf_cgc
String ls_Cpf_Dependente
String lvs_cliente

dw_1.AcceptText()

//Caso cliente n$$HEX1$$e300$$ENDHEX$$o possua bloqueio, nem cheques devolvidos permite libera$$HEX2$$e700e300$$ENDHEX$$o

lvs_cpf_cgc				= dw_1.Object.nr_cpf						[1]
lvs_cliente				= dw_1.Object.nm_cliente				[1]
ls_Cpf_Dependente	= dw_1.Object.Nr_Cpf_Dependente	[1]

If Not wf_Valida_Cpf_Cgc(lvs_cpf_cgc) Then
	dw_1.Event ue_Pos(1, "nr_cpf")
	Return -1
End If

If Not IsNull(ls_Cpf_Dependente) And Trim(ls_Cpf_Dependente) <> "" Then
	If Not wf_Valida_Cpf_Cgc(ls_Cpf_Dependente) Then
		dw_1.Event ue_Pos(1, "nr_cpf_dependente")
		Return -1
	End If
End If

//If wf_Cliente_Bloqueado_Bacen(lvs_cpf_cgc) Then Return -1  *** J$$HEX1$$e100$$ENDHEX$$ faz ao informar o CPF.

If Not wf_Cliente_Liberado(lvs_cpf_cgc) Then
	Return -1
End If

If Not IsNull(ls_Cpf_Dependente) And Trim(ls_Cpf_Dependente) <> "" Then
	ivo_Cliente.of_Localiza_Cpf_Cgc(ls_Cpf_Dependente)		
	If Not ivo_Cliente.Localizado Then
		If wf_Valida_Cpf_Cgc(ls_Cpf_Dependente) Then
			If Not wf_Localiza_Dependente(ls_Cpf_Dependente) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dependente n$$HEX1$$e300$$ENDHEX$$o localizado, o mesmo dever$$HEX1$$e100$$ENDHEX$$ ser cadastrado.")
				
				ivo_Cliente.Nr_Cpf_Dependente = ls_Cpf_Dependente
				OpenWithParm(w_ge031_cadastro_cliente_cheque_dependente, ivo_Cliente)
				ls_Cpf_Dependente = Message.StringParm
				
				If ls_Cpf_Dependente <> "" Then
					wf_Localiza_Dependente(ls_Cpf_Dependente)
				Else
					dw_1.Object.Nr_Cpf_Dependente[1] = ""
				End If
			End If
		Else
			Return -1
		End If
	End If

	dw_1.Event ue_Update()

	If wf_Cliente_Bloqueado_Bacen(ls_Cpf_Dependente) Then Return -1		

	If Wf_Cliente_Liberado(ls_Cpf_Dependente) Then
		ivs_Retorno = lvs_cpf_cgc +'|'+ lvs_cliente
		Close(Parent)
	End If
Else
	ivs_Retorno = lvs_cpf_cgc +'|'+ lvs_cliente
	Close(Parent)
End If
end event

event getfocus;If This.Text <> "&Salvar" Then
	This.Default = True
	This.Weight  = 700
End If 
end event

event losefocus;This.Weight = 400
end event

type cb_sair from commandbutton within w_ge031_cadastro_cliente_cheque
integer x = 1943
integer y = 752
integer width = 549
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Sair"
boolean cancel = true
end type

event clicked;
ivs_Retorno = '' 

Close(Parent)


end event

event getfocus;This.Default = True
This.Weight  = 700
end event

event losefocus;This.Default = False
This.Weight = 400
end event

type cb_alterar from commandbutton within w_ge031_cadastro_cliente_cheque
integer x = 1943
integer y = 280
integer width = 549
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Alterar"
end type

event clicked;String lvs_cpf

// Bot$$HEX1$$e300$$ENDHEX$$o Salvar
Choose Case This.Text
	Case "&Salvar", "&Cadastrar"
		If Wf_Salvar() Then
			dw_1.Object.nr_cpf_dependente.Protect = 1
			lvs_cpf = dw_1.object.nr_cpf[1]
			
			//Protege o CPF digitado
			dw_1.object.nr_cpf.protect = 1 
		
			dw_1.object.id_habilita_alteracao[1] = 'N'
			dw_1.Event ue_Pos( 1, 'nr_cpf' )
			dw_1.SetTabOrder('de_endereco', 0)
			dw_1.SetTabOrder('de_bairro', 0)			
			
			If gvo_Aplicacao.ivo_seguranca.Cd_Sistema = 'CL' Or ivs_tipo_abertura = 'R' Then
				cb_liberar.Default	= True
				cb_liberar.Enabled = True
			End If
			
			cb_cancelar.Enabled  = True
			This.Enabled			= True
			cb_liberar.SetFocus()
			
			This.Text    = "&Alterar"	

			Return 0
		Else
			Return -1
		End If

	Case "&Alterar"
		This.Text    = "&Salvar"
		dw_1.Object.nr_cpf_dependente.Protect = 0
		dw_1.Object.id_habilita_alteracao[1] = 'S'
		dw_1.Event ue_Pos( 1, 'nr_rg' )
		
		//This.Enabled = False
End Choose
end event

event getfocus;This.Weight = 700
end event

event losefocus;This.Weight = 400
end event

type cb_cancelar from commandbutton within w_ge031_cadastro_cliente_cheque
integer x = 1943
integer y = 636
integer width = 549
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "C&ancelar"
end type

event clicked;wf_inicializa_consulta()

ivo_Cliente.of_Inicializa()

end event

event getfocus;This.Weight = 700
end event

event losefocus;This.Weight = 400
end event

