HA$PBExportHeader$dc_w_alteracao_senha.srw
forward
global type dc_w_alteracao_senha from dc_w_response_ok_cancela
end type
type st_1 from statictext within dc_w_alteracao_senha
end type
type st_historico_senha from statictext within dc_w_alteracao_senha
end type
type st_igual_matricula from statictext within dc_w_alteracao_senha
end type
type st_espaco_branco from statictext within dc_w_alteracao_senha
end type
type p_img from picture within dc_w_alteracao_senha
end type
type st_tamanho from statictext within dc_w_alteracao_senha
end type
type st_letras from statictext within dc_w_alteracao_senha
end type
type st_caracter from statictext within dc_w_alteracao_senha
end type
type p_ok1 from picture within dc_w_alteracao_senha
end type
type p_ok2 from picture within dc_w_alteracao_senha
end type
type p_ok3 from picture within dc_w_alteracao_senha
end type
type p_ok4 from picture within dc_w_alteracao_senha
end type
type p_ok5 from picture within dc_w_alteracao_senha
end type
type p_ok6 from picture within dc_w_alteracao_senha
end type
type p_c1 from picture within dc_w_alteracao_senha
end type
type p_c2 from picture within dc_w_alteracao_senha
end type
type p_c3 from picture within dc_w_alteracao_senha
end type
type p_c4 from picture within dc_w_alteracao_senha
end type
type p_c6 from picture within dc_w_alteracao_senha
end type
type st_numeros from statictext within dc_w_alteracao_senha
end type
type p_ok7 from picture within dc_w_alteracao_senha
end type
type p_c7 from picture within dc_w_alteracao_senha
end type
type p_c5 from picture within dc_w_alteracao_senha
end type
end forward

global type dc_w_alteracao_senha from dc_w_response_ok_cancela
integer x = 1074
integer y = 664
integer width = 2423
integer height = 1036
string title = "Altera$$HEX2$$e700e300$$ENDHEX$$o de Senhas"
st_1 st_1
st_historico_senha st_historico_senha
st_igual_matricula st_igual_matricula
st_espaco_branco st_espaco_branco
p_img p_img
st_tamanho st_tamanho
st_letras st_letras
st_caracter st_caracter
p_ok1 p_ok1
p_ok2 p_ok2
p_ok3 p_ok3
p_ok4 p_ok4
p_ok5 p_ok5
p_ok6 p_ok6
p_c1 p_c1
p_c2 p_c2
p_c3 p_c3
p_c4 p_c4
p_c6 p_c6
st_numeros st_numeros
p_ok7 p_ok7
p_c7 p_c7
p_c5 p_c5
end type
global dc_w_alteracao_senha dc_w_alteracao_senha

type variables
dc_uo_encript ivo_encripta

Private:
Long ivl_letras
Long ivl_numeros
Long ivl_caracteres_especiais 
Long ivl_tamanho_senha
Long ivl_historico_senha 

Boolean ivb_Senha_Valida = False
Boolean ivb_Token = False

String ivs_Token = ""

String is_Usuario

//Valores Anteriores
String is_Matricula_Sistema

Boolean ib_Persiste_Usuario
end variables

forward prototypes
public subroutine wf_valida_regras (string ps_senha_nova, string ps_senha_atual)
public function boolean wf_valida_historico_senha (string ps_senha_nova)
end prototypes

public subroutine wf_valida_regras (string ps_senha_nova, string ps_senha_atual);p_ok1.Visible = (Len(Trim(ps_senha_nova))>=ivl_tamanho_senha)
p_c1.Visible = ( Not p_ok1.Visible )

p_c6.Visible = ( ps_senha_nova = gvo_Aplicacao.ivo_seguranca.nr_matricula )
p_ok6.Visible = (Not p_c6.Visible)

p_c7.Visible = ( PosA(ps_senha_nova, " ") > 0 )
p_ok7.Visible = (Not p_c7.Visible)

ivb_Senha_Valida = ((p_ok1.Visible)and(p_ok6.Visible)and(p_ok7.Visible))

/*Letras*/
If ivl_letras > 0 Then
	p_ok2.Visible 	= (Len(Trim(gf_retorna_so_letras(ps_senha_nova))) >= ivl_letras)
	p_c2.Visible 	= ( Not p_ok2.Visible )
	ivb_Senha_Valida = ((ivb_Senha_Valida) and (p_ok2.Visible))
End If

/*Numeros*/
If ivl_numeros > 0 Then
	p_ok3.Visible = (Len(Trim(gf_retorna_so_numeros(ps_senha_nova))) >= ivl_numeros)
	p_c3.Visible = ( Not p_ok3.Visible )	
	ivb_Senha_Valida = ((ivb_Senha_Valida)and(p_ok3.Visible))
End If

/*Caracteres Especiais*/
If ivl_caracteres_especiais > 0 Then
	p_ok4.Visible = (Len(Trim(gf_retorna_so_caracteres_especiais(ps_senha_nova))) >= ivl_caracteres_especiais)
	p_c4.Visible = ( Not p_ok4.Visible )
	ivb_Senha_Valida = ((ivb_Senha_Valida)and(p_ok4.Visible))
End If

/* Hist$$HEX1$$f300$$ENDHEX$$rico Senha */
If ivl_historico_senha > 0 Then
	p_c5.Visible = ( ps_senha_nova = gvo_Aplicacao.ivo_seguranca.de_senha ) or (Not (wf_valida_historico_senha(ps_senha_nova)))
	p_ok5.Visible = (Not p_c5.Visible)
	ivb_Senha_Valida = ((ivb_Senha_Valida)and(p_ok5.Visible))
End If

cb_ok.Enabled = ivb_Senha_Valida
end subroutine

public function boolean wf_valida_historico_senha (string ps_senha_nova);Long lvl_Total = 0

If ivl_historico_senha > 0 Then
	ps_senha_nova = ivo_encripta.of_encripta(ps_senha_nova)
	
	select coalesce(count(1),0)
	Into :lvl_Total
	From usuario_historico_senha
	Where nr_matricula = :gvo_Aplicacao.ivo_seguranca.nr_matricula
		And de_senha = :ps_senha_nova
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.of_msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o hist$$HEX1$$f300$$ENDHEX$$rico senha." )
		lvl_Total = 0
	End If
End If

Return lvl_Total = 0
end function

on dc_w_alteracao_senha.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_historico_senha=create st_historico_senha
this.st_igual_matricula=create st_igual_matricula
this.st_espaco_branco=create st_espaco_branco
this.p_img=create p_img
this.st_tamanho=create st_tamanho
this.st_letras=create st_letras
this.st_caracter=create st_caracter
this.p_ok1=create p_ok1
this.p_ok2=create p_ok2
this.p_ok3=create p_ok3
this.p_ok4=create p_ok4
this.p_ok5=create p_ok5
this.p_ok6=create p_ok6
this.p_c1=create p_c1
this.p_c2=create p_c2
this.p_c3=create p_c3
this.p_c4=create p_c4
this.p_c6=create p_c6
this.st_numeros=create st_numeros
this.p_ok7=create p_ok7
this.p_c7=create p_c7
this.p_c5=create p_c5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_historico_senha
this.Control[iCurrent+3]=this.st_igual_matricula
this.Control[iCurrent+4]=this.st_espaco_branco
this.Control[iCurrent+5]=this.p_img
this.Control[iCurrent+6]=this.st_tamanho
this.Control[iCurrent+7]=this.st_letras
this.Control[iCurrent+8]=this.st_caracter
this.Control[iCurrent+9]=this.p_ok1
this.Control[iCurrent+10]=this.p_ok2
this.Control[iCurrent+11]=this.p_ok3
this.Control[iCurrent+12]=this.p_ok4
this.Control[iCurrent+13]=this.p_ok5
this.Control[iCurrent+14]=this.p_ok6
this.Control[iCurrent+15]=this.p_c1
this.Control[iCurrent+16]=this.p_c2
this.Control[iCurrent+17]=this.p_c3
this.Control[iCurrent+18]=this.p_c4
this.Control[iCurrent+19]=this.p_c6
this.Control[iCurrent+20]=this.st_numeros
this.Control[iCurrent+21]=this.p_ok7
this.Control[iCurrent+22]=this.p_c7
this.Control[iCurrent+23]=this.p_c5
end on

on dc_w_alteracao_senha.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_historico_senha)
destroy(this.st_igual_matricula)
destroy(this.st_espaco_branco)
destroy(this.p_img)
destroy(this.st_tamanho)
destroy(this.st_letras)
destroy(this.st_caracter)
destroy(this.p_ok1)
destroy(this.p_ok2)
destroy(this.p_ok3)
destroy(this.p_ok4)
destroy(this.p_ok5)
destroy(this.p_ok6)
destroy(this.p_c1)
destroy(this.p_c2)
destroy(this.p_c3)
destroy(this.p_c4)
destroy(this.p_c6)
destroy(this.st_numeros)
destroy(this.p_ok7)
destroy(this.p_c7)
destroy(this.p_c5)
end on

event ue_preopen;call super::ue_preopen;Long lvl_Filial
Long lvl_Filial_Matriz

String ls_Parametro, ls_Senha_Expirada

ivo_encripta 	= Create dc_uo_encript

is_Matricula_SIstema	= gvo_Aplicacao.ivo_seguranca.nr_matricula
ib_Persiste_Usuario 	= gvo_Aplicacao.ivo_Seguranca.of_Get_Persiste_Usuario( )

select cd_filial, cd_filial_matriz
Into :lvl_Filial, :lvl_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SQLCa;

ls_Parametro = Trim(Message.StringParm)

//ls_Parametro = 'MENU'
//ls_Parametro = "N"
//ls_Parametro = "S"
//ls_Parametro = 334545

//If ls_Parametro = 'S' Then
//	ls_Senha_Expirada = ls_Parametro
//Else
//	If IsNumber(ls_Parametro) Then
//		ivb_Token = True
//		ivs_Token = IIF(ivb_Token, ls_Parametro, "")
//	End If
//	ls_Senha_Expirada = 'N'
//End If

Choose Case Upper( ls_Parametro )
	Case '' //Acesso pelo Menu Arquivo / Alterar Senha
		
		//Usado para n$$HEX1$$e300$$ENDHEX$$o aparecer o usuario logado na libera$$HEX2$$e700e300$$ENDHEX$$o de procedimento.
		gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( False )
		
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Usuario( ref is_Usuario) Then 
			This.il_Retorno = -1
		End If
		
		gvo_Aplicacao.ivo_Seguranca.of_localiza_usuario( is_Usuario )
		
	Case Else
		If IsNumber(ls_Parametro) and (gvo_Aplicacao.ivo_Seguranca.de_senha <> ivo_encripta.of_encripta( ls_Parametro ) and (is_Usuario <> ls_Parametro)) Then
			ivb_Token = True
			ivs_Token = IIF(ivb_Token, ls_Parametro, "")
		End If
End Choose
		
//If Not ivb_Token And ls_Senha_Expirada = 'N' Then
//	//Usado para n$$HEX1$$e300$$ENDHEX$$o aparecer o usuario logado na libera$$HEX2$$e700e300$$ENDHEX$$o de procedimento.
//	gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( False )
//	
//	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Usuario( ref is_Usuario) Then 
//		This.il_Retorno = -1
//	End If
//	
//	gvo_Aplicacao.ivo_Seguranca.of_localiza_usuario( is_Usuario )
//End If

If (lvl_Filial <> lvl_Filial_Matriz) and &
	(gvo_aplicacao.ivo_seguranca.of_get_perfil_usuario_matriz(gvo_aplicacao.ivo_seguranca.cd_sistema, gvo_aplicacao.ivo_seguranca.cd_perfil_usuario)) Then
	//N$$HEX1$$e300$$ENDHEX$$o efetua esta valida$$HEX2$$e700e300$$ENDHEX$$o para os perfis AUDITOR e FACILITADOR, que s$$HEX1$$e300$$ENDHEX$$o usu$$HEX1$$e100$$ENDHEX$$rios matriz mas visitam fisicamente as lojas.
	If Not(gvo_aplicacao.ivo_seguranca.cd_perfil_usuario = 6 or gvo_aplicacao.ivo_seguranca.cd_perfil_usuario = 11) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Devido a pol$$HEX1$$ed00$$ENDHEX$$tica de senha, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel efetuar a altera$$HEX2$$e700e300$$ENDHEX$$o de senha de um usu$$HEX1$$e100$$ENDHEX$$rio da matriz nas lojas.", Exclamation!)
		This.il_Retorno = -1
	End If
End If

end event

event close;call super::close;destroy(ivo_encripta)

If Not ivb_Token Then
	gvo_Aplicacao.ivo_Seguranca.of_localiza_usuario( is_Matricula_Sistema )
	
	gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( ib_Persiste_Usuario )
End If
end event

event ue_postopen;call super::ue_postopen;gvo_Aplicacao.ivo_seguranca.of_get_formatacao_senha( ivl_letras		, &
																		 ivl_numeros	, &
																		 ivl_caracteres_especiais, &
																		 ivl_tamanho_senha	, &
																		 ivl_historico_senha)
																		 
st_letras.disabledlook 				= (ivl_letras = 0)
st_numeros.disabledlook 			= (ivl_numeros = 0)
st_historico_senha.DisabledLook	= (ivl_historico_senha = 0)
st_caracter.disabledlook 				= (ivl_caracteres_especiais = 0)

p_ok1.Visible	= False
p_c1.Visible		= False
p_ok2.Visible	= False
p_c2.Visible		= False
p_ok3.Visible	= False
p_c3.Visible		= False
p_ok4.Visible	= False
p_c4.Visible		= False
p_c6.Visible		= False
p_ok6.Visible	= False
p_c7.Visible		= False
p_ok7.Visible	= False
p_c5.Visible		= False
p_ok5.Visible	= False

st_letras.text 				= "Ter "+String(ivl_letras)+" letra(s)"
st_caracter.text 			= "Ter "+String(ivl_caracteres_especiais)+" caracter(es) especial(is)"
st_numeros.text 			= "Ter "+String(ivl_numeros)+" n$$HEX1$$fa00$$ENDHEX$$mero(s)"
st_historico_senha.text 	= "N$$HEX1$$e300$$ENDHEX$$o ser igual as $$HEX1$$fa00$$ENDHEX$$ltimas "+String(ivl_historico_senha)+" senhas"
st_tamanho.Text 			= "Ter "+String(ivl_tamanho_senha)+" ("+Lower(gf_replace(gf_replace(gf_extenso_valor(ivl_tamanho_senha)," REAIS", "", 0)," REAL", "", 0))+") caracter(es)"

st_1.Text = gvo_Aplicacao.ivo_Seguranca.Nm_usuario + ", informe duas vezes a nova senha e clique no bot$$HEX1$$e300$$ENDHEX$$o [OK]."

end event

type pb_help from dc_w_response_ok_cancela`pb_help within dc_w_alteracao_senha
integer x = 2208
integer y = 52
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within dc_w_alteracao_senha
integer x = 37
integer y = 148
integer width = 1051
integer height = 648
integer taborder = 0
integer weight = 700
string facename = "Verdana"
string text = "Regras"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within dc_w_alteracao_senha
integer x = 1097
integer y = 544
integer width = 1312
integer height = 260
integer taborder = 10
string dataobject = "dc_dw_alteracao_senha"
end type

event dw_1::editchanged;call super::editchanged;String lvs_Senha_Atual

Choose Case Dwo.Name
	Case 'de_senha_nova_1' 
		This.AcceptText()
		
		lvs_Senha_Atual	= Trim(This.Object.De_Senha_Atual[1])
		
		wf_valida_regras(Data, lvs_Senha_Atual)		
End Choose

cb_ok.Default = ivb_Senha_Valida


end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If Not ivb_senha_valida Then
		Choose Case This.GetColumnName()
			Case "de_senha_atual"
				This.Event ue_Pos(1, "de_senha_nova_1")
			Case "de_senha_nova_1"
				This.Event ue_Pos(1, "de_senha_nova_2")
		End Choose
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;String lvs_Senha_Atual

Choose Case Dwo.Name
	Case 'de_senha_nova_1' 
		This.AcceptText()
		
		lvs_Senha_Atual	= Trim(This.Object.De_Senha_Atual[1])
		
		wf_valida_regras(Data, lvs_Senha_Atual)
		
End Choose

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within dc_w_alteracao_senha
integer x = 1737
integer y = 824
integer weight = 700
boolean enabled = false
end type

event cb_ok::clicked;call super::clicked;Integer lit_retorna_funcao

String	lvs_Senha_Atual	, &
		lvs_Senha_Nova_1, &
		lvs_Senha_Nova_2, &
		lvs_Msg				, &
		lvs_Perfil_Usuario
		
Long lvl_Filial
Long lvl_Filial_Matriz

Datetime lvdh_Atual

dw_1.AcceptText()

lvs_Senha_Nova_1	= Trim(dw_1.Object.De_Senha_Nova_1[1])
lvs_Senha_Nova_2	= Trim(dw_1.Object.De_Senha_Nova_2[1])

wf_valida_regras(lvs_Senha_Nova_1, lvs_Senha_Atual)

If IsNull(lvs_Senha_Nova_1) or lvs_Senha_Nova_1 = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a nova senha.", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_1")
	Return
End If

If PosA(lvs_Senha_Nova_1, " ") > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nova senha n$$HEX1$$e300$$ENDHEX$$o pode conter espa$$HEX1$$e700$$ENDHEX$$os em branco.", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_1")
	Return
End If

If IsNull(lvs_Senha_Nova_2) or lvs_Senha_Nova_2 = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a nova senha para confirma$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_2")
	Return
End If

If lvs_Senha_Nova_1 <> lvs_Senha_Nova_2 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As senhas digitadas devem ser iguais.", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_2")
	Return
End If

If lvs_Senha_Nova_1 = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nova senha deve ser diferente da matr$$HEX1$$ed00$$ENDHEX$$cula.", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_1")
	Return
End If

If Not wf_valida_historico_senha(lvs_Senha_Nova_1) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A senha atual deve ser diferente das $$HEX1$$fa00$$ENDHEX$$ltimas "+String(ivl_historico_senha)+" senhas.", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_1")
	Return
End If

If Len(Trim(gf_retorna_so_numeros(lvs_Senha_Nova_1)))< ivl_numeros Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nova senha deve conter "+String(ivl_numeros)+" n$$HEX1$$fa00$$ENDHEX$$mero(s).", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_1")
	Return
End If

If Len(Trim(gf_retorna_so_letras(lvs_Senha_Nova_1))) < ivl_letras Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nova senha deve conter "+String(ivl_letras)+" letra(s).", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_1")
	Return
End If

If Len(Trim(gf_retorna_so_caracteres_especiais(lvs_Senha_Nova_1))) < ivl_caracteres_especiais Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A nova senha deve conter "+String(ivl_caracteres_especiais)+" caracter(es) especial(is).", Information!)
	dw_1.Event ue_Pos(1, "de_senha_nova_1")
	Return
End If

If Not gvo_Aplicacao.ivo_seguranca.of_Altera_Senha(lvs_Senha_Nova_1) Then
	dw_1.Event ue_Pos(1, "de_senha_atual")
Else
	If ivb_Token Then
		select pu.de_perfil_usuario, pa.cd_filial, pa.cd_filial_matriz, getdate()
			Into :lvs_Perfil_Usuario, :lvl_Filial, :lvl_Filial_Matriz, :lvdh_Atual
		From perfil_usuario pu, parametro pa
		Where pu.cd_perfil_usuario = :gvo_Aplicacao.ivo_seguranca.Cd_Perfil_Usuario
			And pu.cd_sistema = :gvo_Aplicacao.ivo_seguranca.Cd_Sistema
		Using SQLCa;
		
		lvs_Msg 	= 	"Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio,<br /><br />"+ &
						"Senha de usu$$HEX1$$e100$$ENDHEX$$rio redefinida atrav$$HEX1$$e900$$ENDHEX$$s da utiliza$$HEX2$$e700e300$$ENDHEX$$o de token:<br /><br />"+ &
						"<b>Token: </b>"+ivs_Token+"<br />"+ &
						"<b>Matr$$HEX1$$ed00$$ENDHEX$$cula: </b>"+gvo_Aplicacao.ivo_seguranca.nr_matricula+"<br />"+ &
						"<b>Nome Usu$$HEX1$$e100$$ENDHEX$$rio: </b>"+gvo_Aplicacao.ivo_seguranca.nm_usuario+"<br />"+ &
						"<b>Procedimento: </b>"+IIF(gvo_Aplicacao.ivo_seguranca.of_Get_Ultimo_Procedimento()<>"",gvo_Aplicacao.ivo_seguranca.of_Get_Descricao_Procedimento(False),"LOGIN")+"<br />"+ &
						IIF(Not IsNull(lvs_Perfil_Usuario) and lvs_Perfil_Usuario<>"","<b>Perfil Usu$$HEX1$$e100$$ENDHEX$$rio: </b>"+String(gvo_Aplicacao.ivo_seguranca.Cd_Perfil_Usuario)+" - "+lvs_Perfil_Usuario+"<br />","")+ &
						"<b>Data/Hora: </b>"+String(lvdh_Atual,'DD/MM/YYYY HH:MM:SS')+"<br />"+ &
						"<b>Filial: </b>"+String(lvl_Filial)+"<br />"+ &
						"<b>Host: </b>"+gvo_Aplicacao.ivo_seguranca.of_Get_Host()+"<br />"+ &
						"<b>Usu$$HEX1$$e100$$ENDHEX$$rio Windows: </b>"+gvo_Aplicacao.ivo_seguranca.of_Get_Usuario_Windows()+"<br />"+ &
						"<b>Sistema: </b>"+gvo_Aplicacao.ivo_seguranca.Cd_sistema+"<br />"+ &
						"<br /><b>Database: </b>"+IIF(IsNull(SQLCa.Database),"",SQLCa.Database)+IIF(IsNull(SQlca.ivs_database), "", " ("+SQLCa.ivs_Database+")")
		
		If lvl_Filial <> lvl_Filial_Matriz Then
			gf_ge202_envia_email_log(106,'['+gvo_aplicacao.ivo_seguranca.cd_sistema+'] - Redefini$$HEX2$$e700e300$$ENDHEX$$o de Senha por Token',lvs_Msg,False,True)
		Else
			gf_ge202_envia_email_automatico(106,'Redefini$$HEX2$$e700e300$$ENDHEX$$o de Senha por Token',lvs_Msg)
		End If
	End If
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700e300$$ENDHEX$$o de senha efetuada.", Information!)
	CloseWithReturn(Parent, 1)
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within dc_w_alteracao_senha
integer x = 2071
integer y = 824
end type

event cb_cancelar::clicked;//OverRide
CloseWithReturn(Parent, 0)
end event

type st_1 from statictext within dc_w_alteracao_senha
integer x = 18
integer y = 8
integer width = 2341
integer height = 152
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Informe sua senha atual e duas vezes a nova senha"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_historico_senha from statictext within dc_w_alteracao_senha
integer x = 174
integer y = 228
integer width = 891
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "N$$HEX1$$e300$$ENDHEX$$o ser igual as $$HEX1$$fa00$$ENDHEX$$ltimas 4 senhas"
boolean focusrectangle = false
end type

type st_igual_matricula from statictext within dc_w_alteracao_senha
integer x = 174
integer y = 308
integer width = 850
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "N$$HEX1$$e300$$ENDHEX$$o ser igual a sua matr$$HEX1$$ed00$$ENDHEX$$cula"
boolean focusrectangle = false
end type

type st_espaco_branco from statictext within dc_w_alteracao_senha
integer x = 174
integer y = 388
integer width = 850
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "N$$HEX1$$e300$$ENDHEX$$o conter espa$$HEX1$$e700$$ENDHEX$$os em branco"
boolean focusrectangle = false
end type

type p_img from picture within dc_w_alteracao_senha
integer x = 1518
integer y = 192
integer width = 421
integer height = 284
boolean bringtotop = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\password.png"
boolean focusrectangle = false
end type

type st_tamanho from statictext within dc_w_alteracao_senha
integer x = 174
integer y = 468
integer width = 850
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Ter 6 (seis) caracteres"
boolean focusrectangle = false
end type

type st_letras from statictext within dc_w_alteracao_senha
integer x = 174
integer y = 548
integer width = 850
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Ter letras"
boolean focusrectangle = false
end type

type st_caracter from statictext within dc_w_alteracao_senha
integer x = 174
integer y = 704
integer width = 887
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Ter caracter especial ($, %, !, @)"
boolean focusrectangle = false
end type

type p_ok1 from picture within dc_w_alteracao_senha
boolean visible = false
integer x = 82
integer y = 468
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\confirmar_peq.gif"
boolean focusrectangle = false
end type

type p_ok2 from picture within dc_w_alteracao_senha
boolean visible = false
integer x = 82
integer y = 544
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\confirmar_peq.gif"
boolean focusrectangle = false
end type

type p_ok3 from picture within dc_w_alteracao_senha
boolean visible = false
integer x = 82
integer y = 620
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\confirmar_peq.gif"
boolean focusrectangle = false
end type

type p_ok4 from picture within dc_w_alteracao_senha
boolean visible = false
integer x = 82
integer y = 700
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\confirmar_peq.gif"
boolean focusrectangle = false
end type

type p_ok5 from picture within dc_w_alteracao_senha
boolean visible = false
integer x = 82
integer y = 224
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\confirmar_peq.gif"
boolean focusrectangle = false
end type

type p_ok6 from picture within dc_w_alteracao_senha
boolean visible = false
integer x = 82
integer y = 304
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\confirmar_peq.gif"
boolean focusrectangle = false
end type

type p_c1 from picture within dc_w_alteracao_senha
integer x = 82
integer y = 464
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\cancel_peq.png"
boolean focusrectangle = false
end type

type p_c2 from picture within dc_w_alteracao_senha
integer x = 82
integer y = 544
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\cancel_peq.png"
boolean focusrectangle = false
end type

type p_c3 from picture within dc_w_alteracao_senha
integer x = 82
integer y = 620
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\cancel_peq.png"
boolean focusrectangle = false
end type

type p_c4 from picture within dc_w_alteracao_senha
integer x = 82
integer y = 700
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\cancel_peq.png"
boolean focusrectangle = false
end type

type p_c6 from picture within dc_w_alteracao_senha
integer x = 82
integer y = 304
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\cancel_peq.png"
boolean focusrectangle = false
end type

type st_numeros from statictext within dc_w_alteracao_senha
integer x = 174
integer y = 624
integer width = 850
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Ter n$$HEX1$$fa00$$ENDHEX$$meros"
boolean focusrectangle = false
end type

type p_ok7 from picture within dc_w_alteracao_senha
boolean visible = false
integer x = 82
integer y = 384
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\confirmar_peq.gif"
boolean focusrectangle = false
end type

type p_c7 from picture within dc_w_alteracao_senha
integer x = 82
integer y = 384
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\cancel_peq.png"
boolean focusrectangle = false
end type

type p_c5 from picture within dc_w_alteracao_senha
integer x = 82
integer y = 224
integer width = 73
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\cancel_peq.png"
boolean focusrectangle = false
end type

