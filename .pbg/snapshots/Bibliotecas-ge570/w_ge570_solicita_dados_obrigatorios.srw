HA$PBExportHeader$w_ge570_solicita_dados_obrigatorios.srw
forward
global type w_ge570_solicita_dados_obrigatorios from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge570_solicita_dados_obrigatorios
end type
end forward

global type w_ge570_solicita_dados_obrigatorios from dc_w_response_ok_cancela
integer width = 2130
integer height = 1232
string title = "GE570 - Informa$$HEX2$$e700f500$$ENDHEX$$es adicionais"
cb_1 cb_1
end type
global w_ge570_solicita_dados_obrigatorios w_ge570_solicita_dados_obrigatorios

type variables

uo_ge570_dados_obrigatorios io_Dados

uo_prescritor_receita io_prescritor

String is_CPF
String is_Cartao
String is_CPF_Aux

Boolean ib_Obriga_Cupom 	= False
Boolean ib_Obriga_CPF 		= False
end variables

on w_ge570_solicita_dados_obrigatorios.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge570_solicita_dados_obrigatorios.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;io_prescritor 	= Create uo_prescritor_receita
io_Dados 		= Create uo_ge570_dados_obrigatorios 

uo_Cliente lo_Cliente
lo_Cliente = Create uo_Cliente

dw_1.Object.nr_cpf_mascarado.Protect	= 0
dw_1.Object.dh_nascimento.Protect		= 0
dw_1.Object.nr_celular.Protect		= 0
dw_1.Object.nr_ddd_fixo.Protect	= 0
dw_1.Object.nr_fixo.Protect			= 0
dw_1.Object.de_email.Protect		= 0

If Not IsNull( is_CPF ) And Trim(is_CPF) <> '' Then 
	lo_Cliente.of_localiza_cpf( is_CPF )
	
	If lo_Cliente.Localizado Then
		dw_1.Object.nr_ddd_celular [1] = lo_Cliente.nr_ddd_celular	
		dw_1.Object.nr_celular	 	 [1] = lo_Cliente.nr_fone_celular								
		dw_1.Object.nr_ddd_fixo		 [1] = lo_Cliente.nr_ddd_fone
		dw_1.Object.nr_fixo			 [1] = lo_Cliente.nr_fone
		dw_1.Object.de_email		 [1] = lo_Cliente.de_email
		
		dw_1.Object.nr_cpf			 		[1] = lo_Cliente.nr_CPF_CGC
		dw_1.Object.nr_cpf_mascarado	[1] = gf_mascara_cpf_cnpj ( lo_Cliente.nr_CPF_CGC )
		dw_1.Object.dh_nascimento		[1] = Date(lo_Cliente.dh_nascimento)
		
		dw_1.Object.nr_cpf_mascarado.Protect	= 1
		dw_1.Object.dh_nascimento.Protect		= 1
		
		dw_1.Object.nr_celular.Protect		= 1
		dw_1.Object.nr_ddd_fixo.Protect	= 1
		dw_1.Object.nr_fixo.Protect			= 1
		dw_1.Object.de_email.Protect		= 1
		
		dw_1.Event ue_Pos(1, "nr_cartao")
	Else
		dw_1.Object.nr_cpf					[1]	= is_CPF
		dw_1.Object.nr_cpf_mascarado	[1]	= gf_mascara_cpf_cnpj (is_CPF )
	End If
End If

If Not IsNull( is_Cartao ) And Trim(is_Cartao) <> '' Then 
	dw_1.Object.nr_cartao[1] = is_Cartao
End If

If ib_Obriga_CPF 		Then dw_1.Object.st_cpf_obrigatorio.Visible 		= 1
If ib_Obriga_Cupom	Then dw_1.Object.st_cartao_obrigatorio.Visible 	= 1



If IsValid(lo_Cliente) Then Destroy lo_Cliente


end event

event close;call super::close;If IsValid(io_prescritor) Then Destroy io_prescritor
end event

event open;call super::open;String ls_Parametro, ls_Obriga_Cupom, ls_Obriga_CPF

ls_Parametro = Message.StringParm

//parametros enviados
//ls_Obriga_Cupom | ls_Obriga_CPF | Nr CPF | Nr cartao industria
//EX: S|S|12312312387|12356456465465456

ls_Obriga_Cupom  = Mid( ls_Parametro, 1, 1 )
ls_Obriga_CPF		= Mid( ls_Parametro, 3, 1 )
is_CPF				= Mid( ls_Parametro, 5, 11)
is_Cartao			= Mid( ls_Parametro, 17)

is_CPF_Aux		= is_CPF

//is_CPF 				= Mid( ls_Parametro, 1, PosA(ls_Parametro, '|')  - 1 )
//ls_Obriga_Cupom  = Mid( ls_Parametro,  PosA(ls_Parametro, '|')  + 1 )
//ls_Obriga_CPF		= Mid( ls_Parametro,  PosA(ls_Parametro, '|')  + 1 )

ib_Obriga_Cupom 	= (ls_Obriga_Cupom	='S')
ib_Obriga_CPF		= (ls_Obriga_CPF		='S')

//No sistema de Caixa vai passar o CPF que veio do RL
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then 
	If Trim(is_CPF) = '' Then
		dw_1.Object.t_mensagem_clube.text = 'O cliente Clube n$$HEX1$$e300$$ENDHEX$$o foi localizado. Informe o CPF do benefici$$HEX1$$e100$$ENDHEX$$rio do PBM.'
		dw_1.Object.id_mesmo_cpf.visible 	= 0 
	Else
		dw_1.Object.t_mensagem_clube.text = 'O titular da receita $$HEX1$$e900$$ENDHEX$$ o mesmo que o titular do Clube?'
		dw_1.Object.id_mesmo_cpf.visible 	= 1
	End If
Else
	dw_1.Object.t_mensagem_clube.Visible	= 0
	dw_1.Object.id_mesmo_cpf.visible 		= 0 
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge570_solicita_dados_obrigatorios
integer y = 208
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge570_solicita_dados_obrigatorios
integer x = 32
integer y = 0
integer width = 2057
integer height = 1008
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge570_solicita_dados_obrigatorios
integer x = 64
integer y = 64
integer width = 1993
integer height = 920
string dataobject = "dw_ge570_dados_obrigatorios"
end type

event dw_1::ue_key;call super::ue_key;String lvs_Coluna,&
  	   lvs_prescritor

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	Choose Case lvs_Coluna
			
		Case "de_localizacao_prescritor"
			
			lvs_prescritor = This.GetText()
			
			io_Prescritor.of_Localiza_generica(lvs_Prescritor)
			
			If io_Prescritor.Localizado Then
				dw_1.Object.nm_prescritor				[1] = io_Prescritor.nm_prescritor	
				dw_1.Object.cd_uf_prescritor			[1] = io_Prescritor.cd_unidade_federacao	
				dw_1.Object.de_registro_prescritor	[1] = io_Prescritor.nr_registro	
				dw_1.Object.cd_tipo_prescritor			[1] = io_Prescritor.id_registro	
			End If
									
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'de_localizacao_prescritor'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Prescritor.nm_Prescritor Then
				Return 1
			End If
		Else
			io_Prescritor.of_inicializa( )
			
			dw_1.Object.nm_prescritor				[1] = io_Prescritor.nm_prescritor	
			dw_1.Object.cd_uf_prescritor			[1] = io_Prescritor.cd_unidade_federacao	
			dw_1.Object.de_registro_prescritor	[1] = io_Prescritor.nr_registro	
			dw_1.Object.cd_tipo_prescritor			[1] = io_Prescritor.id_registro	
		End If
		
	Case 'id_mesmo_cpf'
		If Data = 'S' Then
			dw_1.Object.nr_cpf					[1] = is_CPF_AUX
			dw_1.Object.nr_cpf_mascarado	[1] = gf_mascara_cpf_cnpj (is_CPF_AUX )
		Else
			dw_1.Object.nr_cpf					[1] = ''
			dw_1.Object.nr_cpf_mascarado	[1] = ''
			dw_1.Object.nr_cpf_mascarado.Protect	= 0
			dw_1.Event ue_Pos(1, "nr_cpf_mascarado")
		End If
			
End Choose


			
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge570_solicita_dados_obrigatorios
integer x = 1454
integer y = 1024
integer weight = 700
boolean default = false
end type

event cb_ok::clicked;call super::clicked;
String ls_DDD_CEL, ls_DDD_FIXO
String ls_Fone_Cel, ls_Fone_Fixo
String ls_Email
String ls_CPF, ls_CPF_Mascarado

String ls_Cartao_Industria

Date ldh_Nascimento

dw_1.AcceptText()

ls_CPF					= dw_1.object.nr_cpf					[1]
ls_CPF_Mascarado		= dw_1.object.nr_cpf_mascarado	[1]
ldh_Nascimento		= dw_1.object.dh_nascimento		[1]
ls_Cartao_Industria	= dw_1.Object.nr_cartao			[1]

ls_DDD_CEL 	= dw_1.object.nr_ddd_celular	[1]
ls_Fone_Cel 	= dw_1.object.nr_celular		[1]
ls_DDD_Fixo 	= dw_1.object.nr_ddd_fixo		[1]
ls_Fone_Fixo	= dw_1.object.nr_fixo			[1]
ls_Email			= dw_1.object.de_email			[1]

//Atribui o Valor do CPF digitado em tela
If IsNull(ls_CPF) Or Trim(ls_CPF) = '' Then
	If Not IsNull(ls_CPF_Mascarado) Then
		ls_CPF = ls_CPF_Mascarado
	End If
End If

If ib_Obriga_CPF Then
	If IsNull( ls_CPF ) Or Trim( ls_CPF ) = '' Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem produtos na lista que obrigam informar o CPF do cliente.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_cpf_mascarado")
		Return -1
	End If
End If

If Not gf_valida_cpf(ls_CPF, True ) Then
	dw_1.Event ue_Pos(1, "nr_cpf_mascarado")
	Return -1
End If

//No caixa tem a pergunta antes da abertura da tela
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then 
	If ib_Obriga_Cupom Then
		If IsNUll(ls_Cartao_Industria) Or Trim(ls_Cartao_Industria) = '' Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alguns produtos na lista necessitam do cart$$HEX1$$e300$$ENDHEX$$o da ind$$HEX1$$fa00$$ENDHEX$$stria para conceder o melhor desconto.~r~rDeseja inform$$HEX1$$e100$$ENDHEX$$-lo?.", Question!, YesNo!, 2) = 1 Then
				dw_1.Event ue_Pos(1, "nr_cartao")
				Return -1		
			End If
		End If
	End If
End If

If (Not IsNull( ls_CPF ) And Trim( ls_CPF ) <> '' ) And (Not IsNull( ls_Cartao_Industria ) And Trim( ls_Cartao_Industria ) <> '') Then
	If ls_CPF = ls_Cartao_Industria Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CPF e o Cart$$HEX1$$e300$$ENDHEX$$o da Ind$$HEX1$$fa00$$ENDHEX$$stria n$$HEX1$$e300$$ENDHEX$$o podem ter o mesmo n$$HEX1$$fa00$$ENDHEX$$mero.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_cpf_mascarado")
		Return -1
	End If
End If

If IsNull( ls_CPF ) Or Trim( ls_CPF ) = '' Then
	If IsNull( ls_Cartao_Industria ) Or Trim( ls_Cartao_Industria ) = '' Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar o CPF ou o Cart$$HEX1$$e300$$ENDHEX$$o da Ind$$HEX1$$fa00$$ENDHEX$$stria para a identifica$$HEX2$$e700e300$$ENDHEX$$o do cliente.", Exclamation! )
		dw_1.Event ue_Pos(1, "nr_cpf_mascarado")
		Return -1
	End If
End If

//If Not IsNull(ls_CPF) And Trim(ls_CPF) <> '' Then
//	If IsNull(ldh_Nascimento) or Not IsDate(String(ldh_Nascimento, "dd/mm/yyyy")) Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de nascimento do cliente.", Exclamation!)
//		dw_1.Event ue_Pos(1, "dh_nascimento")
//		Return -1	
//	End If
//	
//	If ldh_Nascimento <= Date("01/01/1900") or ldh_Nascimento > Today() Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de nascimento do cliente deve ser entre '01/01/1901' e '" + String(Today(), "dd/mm/yyyy") + "'.", Exclamation!)
//		dw_1.Event ue_Pos(1, "dh_nascimento")
//		Return -1
//	End If
//End If

// Valida$$HEX2$$e700e300$$ENDHEX$$o do DDD Fixo
//If IsNull( ls_DDD_Fixo ) Then
//	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone fixo.", Exclamation! )
//	dw_1.Event ue_Pos(1, "nr_ddd_fixo")		
//	Return -1	
//Else
//	If LenA( ls_DDD_Fixo ) < 2 Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone fixo corretamente (2 d$$HEX1$$ed00$$ENDHEX$$gitos).", Exclamation! )
//		dw_1.Event ue_Pos(1, "nr_ddd_fixo")
//		Return -1		
//	End If
//End If
//
//// Telefone preenchido deve ter o DDD preenchido corretamente, e o telefone deve ter no m$$HEX1$$ed00$$ENDHEX$$nimo 8 d$$HEX1$$ed00$$ENDHEX$$gitos
//If IsNull( ls_Fone_Fixo ) Then
//	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preenha o n$$HEX1$$fa00$$ENDHEX$$mero do telefone fixo.", Exclamation! )
//	dw_1.Event ue_Pos(1, "nr_fixo")
//	Return -1
//Else
//	If LenA( ls_Fone_Fixo ) < 8 or LenA( ls_Fone_Fixo ) > 8 Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O telefone fixo informado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ valido.", Exclamation! )
//		dw_1.Event ue_Pos(1, "nr_fixo")
//		Return -1		
//	End If	
//End If
//------------FIM Validacao Tel FIXO


// Valida$$HEX2$$e700e300$$ENDHEX$$o do DDD celular
//If IsNull( ls_DDD_Cel ) Then
//	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone celular.", Exclamation! )
//	dw_1.Event ue_Pos(1, "nr_ddd_celular")		
//	Return -1
//Else
//	If LenA( ls_DDD_Cel ) < 2 Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preencha o DDD do telefone celular corretamente (2 d$$HEX1$$ed00$$ENDHEX$$gitos).", Exclamation! )
//		dw_1.Event ue_Pos(1, "nr_ddd_celular")
//		Return -1
//	End If
//End If
//
////Telefone preenchido deve ter o DDD preenchido corretamente, e o telefone deve ter no m$$HEX1$$ed00$$ENDHEX$$nimo 9 d$$HEX1$$ed00$$ENDHEX$$gitos
//If IsNull( ls_Fone_Cel ) Then
//	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preenha o n$$HEX1$$fa00$$ENDHEX$$mero do telefone celular.", Exclamation! )
//	dw_1.Event ue_Pos(1, "nr_celular")
//	Return -1
//Else
//	If LenA( ls_Fone_Cel ) < 9 Or LenA( ls_Fone_Cel ) > 9 Then
//		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O telefone celular informado n$$HEX1$$e300$$ENDHEX$$o possui 9 d$$HEX1$$ed00$$ENDHEX$$gitos.", Exclamation! )
//		dw_1.Event ue_Pos(1, "nr_celular")
//		Return -1
//	End If
//End If
////------------Fim Validacao Tel Celular
//
//If IsNull( ls_Email ) Then
//	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Preenha o endere$$HEX1$$e700$$ENDHEX$$o de e-mail.", Exclamation! )
//	dw_1.Event ue_Pos(1, "de_email")
//	Return -1
//End If

//If Not IsNull( ls_Email ) And LenA(Trim(ls_Email)) > 0 Then
//	If Not gf_Valida_Email(ls_Email) Then	
//		dw_1.Event ue_Pos(1, "de_email")
//		Return -1
//	End If
//End If

//ls_Fone_Cel		= String(Integer(ls_DDD_Cel),'000') 	+ ls_Fone_Cel
//ls_Fone_Fixo	= String(Integer(ls_DDD_Fixo),'000')  + ls_Fone_Fixo
		

io_Dados.nr_Fone_Fixo			= ls_Fone_Fixo
io_Dados.nr_fone_celular		= ls_Fone_Cel
io_Dados.de_email				= ls_Email
io_Dados.nr_cartao_industria	= ls_Cartao_Industria
io_Dados.nr_cpf					= ls_CPF
io_Dados.dh_nascimento			= ldh_Nascimento

CloseWithReturn(Parent, io_Dados)


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge570_solicita_dados_obrigatorios
integer x = 1787
integer y = 1024
end type

event cb_cancelar::clicked;//OverRide
SetNull(io_Dados)

CloseWithReturn(Parent, io_Dados)

end event

type cb_1 from commandbutton within w_ge570_solicita_dados_obrigatorios
boolean visible = false
integer x = 41
integer y = 1024
integer width = 539
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Inserir Prescritor"
end type

event clicked;Open(w_ge085_cadastro_prescritor_receita)
end event

