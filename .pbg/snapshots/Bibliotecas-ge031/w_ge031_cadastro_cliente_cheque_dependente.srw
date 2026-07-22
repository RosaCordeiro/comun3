HA$PBExportHeader$w_ge031_cadastro_cliente_cheque_dependente.srw
forward
global type w_ge031_cadastro_cliente_cheque_dependente from window
end type
type st_menu_fiscal from statictext within w_ge031_cadastro_cliente_cheque_dependente
end type
type dw_1 from dc_uo_dw_base within w_ge031_cadastro_cliente_cheque_dependente
end type
type cb_cadastrar from commandbutton within w_ge031_cadastro_cliente_cheque_dependente
end type
type cb_sair from commandbutton within w_ge031_cadastro_cliente_cheque_dependente
end type
end forward

global type w_ge031_cadastro_cliente_cheque_dependente from window
integer x = 901
integer y = 152
integer width = 2533
integer height = 1816
boolean titlebar = true
string title = "GE031 - Cadastro de Cliente Cheque (Segundo Titular)"
windowtype windowtype = response!
long backcolor = 80269524
boolean center = true
st_menu_fiscal st_menu_fiscal
dw_1 dw_1
cb_cadastrar cb_cadastrar
cb_sair cb_sair
end type
global w_ge031_cadastro_cliente_cheque_dependente w_ge031_cadastro_cliente_cheque_dependente

type variables
uo_cliente_cheque	ivo_cliente  //GE032
uo_cidade			ivo_cidade
uo_ge099_endereco ivo_endereco

String					ivs_retorno
String 				ivs_Texto_Endereco
Boolean 				ivb_Localizou_Endereco
end variables

forward prototypes
public subroutine wf_inicializa_consulta ()
public function boolean wf_valida_dados_cliente ()
public subroutine wf_localiza_cidade (string ps_cidade)
public function boolean wf_salvar ()
public function boolean wf_valida_cpf_cgc (string ps_parametro)
public function boolean wf_localiza_cliente (string ps_cpf_cgc)
public function boolean wf_preenche_campos ()
public subroutine wf_centraliza_janela ()
public subroutine wf_localiza_endereco ()
end prototypes

public subroutine wf_inicializa_consulta ();Long ll_filial

ll_filial = gvo_Parametro.of_filial()

//Inicializa Tela de Consulta
dw_1.SetReDraw(False)
dw_1.Reset()
dw_1.InsertRow(0)
dw_1.object.id_habilita_alteracao		[1] = 'S'
dw_1.object.cd_filial_inclusao			[1] = ll_filial
dw_1.Object.dh_Inclusao				[1] = gf_GetServerDate()
dw_1.Object.nr_Matricula_Inclusao	[1] = gvo_Aplicacao.ivo_Seguranca.nr_Matricula
dw_1.object.nr_cpf.protect = 0
dw_1.SetTabOrder('de_endereco', 0)
dw_1.SetTabOrder('de_bairro', 0)
dw_1.SetTabOrder('nm_cidade', 0)
dw_1.SetFocus()
dw_1.SetReDraw(True)

ivo_endereco.of_inicializa()

//Tamanho original da janela

//This.Height = 1836
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
ls_Mae						= dw_1.Object.Nm_Mae					[1]
ldh_Data_Nasc				= dw_1.Object.Dh_Nascimento			[1]
ls_Email						= dw_1.Object.De_Endereco_Email	[1]
lvs_DDD_Cel					= dw_1.Object.nr_ddd_celular			[1]
lvs_Fone_Cel 				= dw_1.Object.nr_celular				[1]

If Not wf_valida_cpf_cgc(lvs_nr_cpf) Then Return False

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

Return True
end function

public subroutine wf_localiza_cidade (string ps_cidade);
ivo_Cidade.of_Localiza_Cidade(ps_Cidade)

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

public function boolean wf_valida_cpf_cgc (string ps_parametro);Boolean lvb_Retorno

ps_parametro = Trim(ps_parametro)

If LenA(ps_parametro) = 11 Then                         //Valida cpf
	lvb_Retorno = gf_nr_cpf_valido(ps_parametro)
ElseIf LenA(ps_parametro) = 14 Then
	lvb_Retorno = gf_cgc_valido(ps_parametro)           //Valida cgc
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o CPF ou CGC v$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
End If

Return lvb_Retorno
end function

public function boolean wf_localiza_cliente (string ps_cpf_cgc);If Not wf_valida_cpf_cgc(ps_cpf_cgc) Then
	dw_1.SetFocus()
	Return False
End If
	
ivo_Cliente.of_localiza_cpf_cgc(ps_cpf_cgc)

If ivo_Cliente.Localizado Then
	If ivo_Cliente.ivs_Fisica_Juridica = 'F'	Then This.Height = 2100
	If ivo_Cliente.ivs_Fisica_Juridica = 'J'	Then This.Height = 870
	dw_1.Retrieve(ps_cpf_cgc)
Else
	Return False
End If

Return True
end function

public function boolean wf_preenche_campos ();dw_1.AcceptText()

ivo_Cidade.Of_Localiza_Codigo(ivo_Cliente.Cd_Cidade)

If ivo_Cidade.Localizada Then
	dw_1.Object.Nm_Cidade		[1]	= ivo_Cidade.Nm_Cidade
	dw_1.Object.Cd_Cidade		[1]	= ivo_Cidade.Cd_Cidade
End If

dw_1.Object.Nr_Cpf					[1]	= ivo_Cliente.Nr_Cpf_Dependente
dw_1.Object.De_Endereco			[1]	= ivo_Cliente.De_Endereco
dw_1.Object.Nr_Endereco			[1]	= ivo_Cliente.Nr_Endereco
dw_1.Object.De_Bairro				[1]	= ivo_Cliente.De_Bairro
dw_1.Object.Nr_Cep					[1]	= ivo_Cliente.Nr_Cep
dw_1.Object.Nr_Ddd_Telefone		[1]	= ivo_Cliente.Nr_Ddd_Telefone
dw_1.Object.Nr_Telefone			[1]	= ivo_Cliente.Nr_Telefone

dw_1.Event ue_Pos(1, "nr_rg")

Return True
end function

public subroutine wf_centraliza_janela ();Window w_Parent
w_Parent = ParentWindow()

This.X = (w_Parent.WorkSpaceWidth () - This.Width ) / 2
This.Y = (w_Parent.WorkSpaceHeight() - This.Height) / 2

This.Show()
end subroutine

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

on w_ge031_cadastro_cliente_cheque_dependente.create
this.st_menu_fiscal=create st_menu_fiscal
this.dw_1=create dw_1
this.cb_cadastrar=create cb_cadastrar
this.cb_sair=create cb_sair
this.Control[]={this.st_menu_fiscal,&
this.dw_1,&
this.cb_cadastrar,&
this.cb_sair}
end on

on w_ge031_cadastro_cliente_cheque_dependente.destroy
destroy(this.st_menu_fiscal)
destroy(this.dw_1)
destroy(this.cb_cadastrar)
destroy(this.cb_sair)
end on

event close;Destroy(ivo_cidade)
end event

event open;ivo_cidade  = Create uo_cidade
ivo_Cliente = Message.PowerObjectParm

ivo_Endereco 		= Create uo_ge099_endereco

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CL' Then
	st_menu_fiscal.Visible 	= True
End If

wf_inicializa_consulta()

ivs_retorno = ''

wf_Preenche_Campos()

dw_1.SetColumn('nr_rg')

//wf_Centraliza_Janela()
end event

type st_menu_fiscal from statictext within w_ge031_cadastro_cliente_cheque_dependente
boolean visible = false
integer x = 1984
integer y = 1504
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

type dw_1 from dc_uo_dw_base within w_ge031_cadastro_cliente_cheque_dependente
integer x = 37
integer y = 32
integer width = 1897
integer height = 1696
string dataobject = "dw_ge031_cadastro_cliente_cheque"
end type

event itemchanged;call super::itemchanged;String lvs_Nulo

SetNull(lvs_Nulo)

Choose Case dwo.Name
	Case "nr_cpf"
		
		If Not wf_valida_cpf_cgc(data) Then Return 1
			
//		If LenA(data) = 11 Then Parent.Height = 1836     // digitou cpf
//		If LenA(data) = 14 Then Parent.Height = 870      // digitou cnpj
			
	Case "nm_cidade"
		If Data <> ivo_Cidade.Nm_Cidade Then
			Return 1
		End If
			
End Choose
end event

event itemfocuschanged;call super::itemfocuschanged;String lvs_Coluna

lvs_Coluna = dwo.name 

If cb_Cadastrar.Enabled Then	
	If lvs_Coluna = "nm_cidade" or lvs_Coluna = "localiza_endereco" Then	
		cb_Cadastrar.Default = False   
	Else  											 // Evita que o enter para localiza$$HEX2$$e700e300$$ENDHEX$$o da cidade
		cb_Cadastrar.Default = True          // execute o clicked do bot$$HEX1$$e300$$ENDHEX$$o [cadastrar]
	End If 											 
End If

SelectText(1,50)
end event

event losefocus;call super::losefocus;
If IsValid(ivo_Cidade) Then
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
			wf_Localiza_Cliente(lvs_Texto)
			
		Case "nm_cidade"
		
			wf_localiza_cidade(lvs_Texto)
			
		Case "localiza_endereco"
			wf_localiza_endereco()
		
		Case "nr_cep"
			wf_localiza_endereco()			
					
	End Choose

End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type cb_cadastrar from commandbutton within w_ge031_cadastro_cliente_cheque_dependente
integer x = 1943
integer y = 52
integer width = 544
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar"
end type

event clicked;String lvs_cpf

If Wf_Salvar() Then
	
	This.Enabled = False
	
	lvs_cpf = dw_1.object.nr_cpf[1]
	
	//Protege o CPF digitado
	dw_1.object.nr_cpf.protect = 1 

	dw_1.object.id_habilita_alteracao[1] = 'N'
	dw_1.SetColumn('nr_cpf')
			
	cb_cadastrar.Enabled = False
	
	CloseWithReturn(Parent, ivo_Cliente.Nr_Cpf_Dependente)
		
End If
end event

event getfocus;This.Weight = 700
end event

event losefocus;This.Weight = 400
end event

type cb_sair from commandbutton within w_ge031_cadastro_cliente_cheque_dependente
integer x = 1943
integer y = 188
integer width = 544
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

event clicked;CloseWithReturn(Parent, "")
end event

event getfocus;This.Default = True
This.Weight  = 700
end event

event losefocus;This.Default = False
This.Weight = 400
end event

