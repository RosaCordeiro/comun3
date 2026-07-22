HA$PBExportHeader$dc_w_liberacao_procedimento_coletor.srw
forward
global type dc_w_liberacao_procedimento_coletor from dc_w_response
end type
type cb_ok from commandbutton within dc_w_liberacao_procedimento_coletor
end type
type cb_cancelar from commandbutton within dc_w_liberacao_procedimento_coletor
end type
type dw_1 from dc_uo_dw_base within dc_w_liberacao_procedimento_coletor
end type
end forward

global type dc_w_liberacao_procedimento_coletor from dc_w_response
integer x = 873
integer y = 840
integer width = 1065
integer height = 732
string title = "Libera$$HEX2$$e700e300$$ENDHEX$$o de Procedimentos"
boolean controlmenu = false
long backcolor = 255
cb_ok cb_ok
cb_cancelar cb_cancelar
dw_1 dw_1
end type
global dc_w_liberacao_procedimento_coletor dc_w_liberacao_procedimento_coletor

type variables
Boolean ivb_Exige_Cadastro_Biometrico = False

Integer ivi_Tentativas = 1

dc_uo_seguranca ivo_seguranca

String ivs_retorno

String ivs_Cpf

Boolean ivb_Inseriu_Senha = False

dc_uo_encript ivo_encript
end variables

forward prototypes
public function string wf_descricao_procedimento ()
public function integer wf_senha_biometrica ()
public subroutine wf_habilita_biometria (boolean pb_habilita)
end prototypes

public function string wf_descricao_procedimento ();String lvs_Descricao

Select de_procedimento Into :lvs_Descricao
From procedimento_sistema
Where cd_sistema      = :This.ivo_Seguranca.Cd_Sistema
  and cd_procedimento = :This.ivo_Seguranca.Cd_Procedimento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Procedimento '" + This.ivo_Seguranca.Cd_Procedimento + "' do sistema '" + &
		                      This.ivo_Seguranca.Cd_Sistema + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do procedimento '" + This.ivo_Seguranca.Cd_Procedimento + "' do sistema '" + &
		                      This.ivo_Seguranca.Cd_Sistema + "'.", StopSign!)		
End Choose

Return lvs_Descricao
end function

public function integer wf_senha_biometrica ();String ls_Dedos

Integer li_Retorno

uo_GE040_Leitor_Biometrico lvo_Biometria
lvo_Biometria = Create uo_GE040_Leitor_Biometrico

lvo_Biometria.of_Dedos_Cadastrados( ivs_Cpf, ref ls_Dedos )

li_Retorno = lvo_Biometria.of_Identifica( ivs_Cpf )

Choose Case li_Retorno
	Case -1
		cb_Cancelar.Event Clicked()
		// Erro
		
	Case 0
		lvo_Biometria.of_Dedos_Cadastrados( ivs_Cpf, ref ls_Dedos)
		ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Digital incorreta', False, "B" )
		If MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Digital n$$HEX1$$e300$$ENDHEX$$o localizada no cadastro.~r~rOs dedos cadastrados para este usu$$HEX1$$e100$$ENDHEX$$rio s$$HEX1$$e300$$ENDHEX$$o: ' + ls_Dedos + '~r~rTentar novamente?', Question!, YesNo! ) = 1 Then
			Destroy lvo_Biometria
			wf_Senha_Biometrica()
		Else
			Destroy lvo_Biometria
			cb_Cancelar.Event Clicked()
		End If
		
	Case 1
		ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Digital incorreta', True, "B" )
		//gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = True
		ivs_Retorno	=  gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		dw_1.Object.De_Senha[1] = ivo_Seguranca.De_Senha
		gvo_Aplicacao.of_SetMicroHelp()
		cb_Ok.Event Clicked()
End Choose

Destroy lvo_Biometria

Return li_Retorno
end function

public subroutine wf_habilita_biometria (boolean pb_habilita);If pb_Habilita Then
	cb_Ok.Enabled	= False
	dw_1.SetTabOrder( 'de_senha', 0 )
	wf_Senha_Biometrica()
Else
	cb_Ok.Enabled	= True	
	dw_1.SetTabOrder( 'de_senha', 20 )
	dw_1.Event ue_Pos( 1, 'de_senha' )
End If
end subroutine

on dc_w_liberacao_procedimento_coletor.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.dw_1
end on

on dc_w_liberacao_procedimento_coletor.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancelar)
destroy(this.dw_1)
end on

event open;call super::open;String lvs_Descricao
Long ll_Color

SetNull(ivs_Retorno)

ivo_Seguranca = Message.PowerObjectParm

ll_Color = ivo_Seguranca.ivl_Color
dw_1.Modify("datawindow.color="+String(ll_Color))
dw_1.Modify("gb_1.background.color="+String(ll_Color))
dw_1.Modify("gb_2.background.color="+String(ll_Color))
dw_1.Modify("de_procedimento.background.color="+String(ll_Color))
This.BackColor = ll_Color

If Not ivo_Seguranca.ivb_Habilita_Cancelar Then
	This.cb_Cancelar.Enabled = False
End If

If This.ivo_Seguranca.Cd_Procedimento <> "" Then
	lvs_Descricao = wf_Descricao_Procedimento()
Else
	lvs_Descricao = "VERIFICA$$HEX2$$c700c300$$ENDHEX$$O DE ACESSO"
End If

dw_1.InsertRow(0)
dw_1.Object.Cd_Procedimento[1] = This.ivo_Seguranca.Cd_Procedimento

If Trim(lvs_Descricao) <> "" Then
	dw_1.Object.De_Procedimento[1] = lvs_Descricao
	X = 10 //900
	Y = 254 //750	
Else
	SetNull(lvs_Descricao)
	CloseWithReturn(This, lvs_Descricao)
End If
end event

event close;call super::close;If IsValid( ivo_encript ) Then Destroy(ivo_encript)

CloseWithReturn(This,ivs_Retorno)

end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Pos( 1, 'nr_matricula' )
end event

event ue_preopen;call super::ue_preopen;ivo_encript = Create dc_uo_encript
end event

type pb_help from dc_w_response`pb_help within dc_w_liberacao_procedimento_coletor
end type

type cb_ok from commandbutton within dc_w_liberacao_procedimento_coletor
integer x = 288
integer y = 512
integer width = 347
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "O&K"
boolean default = true
end type

event clicked;String lvs_De_Senha

Integer lvi_Retorno

//If not ivb_Inseriu_Senha Then
//	dw_1.Event ue_Pos(1, "de_senha")
//	Return 1
//End If

dw_1.AcceptText()
lvs_De_Senha = Trim(dw_1.Object.De_Senha[1])


If lvs_De_Senha <> "" Then
	//Encripta Senha para compara$$HEX2$$e700e300$$ENDHEX$$o
	If ivo_Seguranca.id_senha_criptografada Then lvs_De_Senha = ivo_encript.of_encripta(lvs_De_Senha)
	
	If lvs_De_Senha <> ivo_Seguranca.De_Senha Then
		If ivi_Tentativas < 3 Then
			ivi_Tentativas ++
			
			ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Senha incorreta', False, "D" )
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Senha incorreta.", Information!, Ok!)
			dw_1.SetColumn("de_senha")
			dw_1.SetFocus()			
			Return
		Else
			ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Senha incorreta', False, "D" )
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Limite de tentativas esgotado.", Information!, Ok!)
			ivs_Retorno = "CANCEL"
		End If
	Else
		ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Senha incorreta', True, "D" )
		ivs_Retorno = ivo_Seguranca.Nr_Matricula
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a senha do usu$$HEX1$$e100$$ENDHEX$$rio.", Information!, Ok!)
	dw_1.SetColumn("de_senha")
	dw_1.SetFocus()
	Return	
End If

If ivb_Exige_Cadastro_Biometrico Then
	uo_GE040_Leitor_Biometrico lvo_Biometria
	lvo_Biometria = Create uo_GE040_Leitor_Biometrico
	
	If gvo_Aplicacao.ivo_Seguranca.Nr_Cpf = '0' Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi encontrado CPF para este usu$$HEX1$$e100$$ENDHEX$$rio." )
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A seguir, o sistema ir$$HEX1$$e100$$ENDHEX$$ solicitar o cadastro biom$$HEX1$$e900$$ENDHEX$$trico, por favor realize-o." )
		If lvo_Biometria.of_Cadastra( ivs_Cpf ) Then
			Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Digital cadastrada com sucesso." )
			ivs_Retorno = ivo_Seguranca.Nr_Matricula
		Else
			ivs_Retorno = "CANCEL"
		End If
	End If
	
	Destroy lvo_Biometria
End If

Close(Parent)
end event

type cb_cancelar from commandbutton within dc_w_liberacao_procedimento_coletor
integer x = 663
integer y = 512
integer width = 347
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;ivs_Retorno = "CANCEL"

Close(Parent)
end event

type dw_1 from dc_uo_dw_base within dc_w_liberacao_procedimento_coletor
integer y = 4
integer width = 1042
integer height = 496
boolean bringtotop = true
string dataobject = "dc_dw_liberacao_procedimento_coletor"
end type

event itemchanged;call super::itemchanged;String lvs_Nr_Matricula

Choose Case dwo.Name 
	Case "nr_matricula" 
		// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio digitado existe
		This.AcceptText()
		lvs_Nr_Matricula = String(This.Object.Nr_Matricula[1])
		
		ivo_Seguranca.of_Localiza_Usuario( lvs_Nr_Matricula )
		
		If Not ivo_Seguranca.ivb_Usuario_Localizado Then
			Return 1
		Else
			
			This.Object.Nm_Usuario[1] = ivo_Seguranca.Nm_Usuario
			
			If gvo_Aplicacao.ivb_Usa_Biometria Then // Usu$$HEX1$$e100$$ENDHEX$$rio desenvolvimento de sistemas, n$$HEX1$$e300$$ENDHEX$$o utiliza biometria
				// Biometria
				uo_GE040_Leitor_Biometrico lvo_Biometria
				lvo_Biometria = Create uo_GE040_Leitor_Biometrico
				
				Select coalesce( nr_cpf, '0' )
					Into :ivs_Cpf
				 From usuario
				Where nr_matricula = :lvs_Nr_Matricula
					And id_situacao = 'A'
				  Using SqlCa;
				  
				Choose Case SqlCa.SqlCode
					Case -1
						SqlCa.of_MsgDbError()					
				End Choose
				
				If lvo_Biometria.of_Inicializa() Then
					If Not lvo_Biometria.of_Usuario_Isento( lvs_Nr_Matricula ) Then
						If lvo_Biometria.of_Existe_Digital_Cadastrada( ivs_Cpf ) Then
							wf_Habilita_Biometria( True )
						Else
							ivb_Exige_Cadastro_Biometrico = True
							wf_Habilita_Biometria( False )
						End If
					Else
						wf_Habilita_Biometria( False )
					End If
				Else
					wf_Habilita_Biometria( False )
				End If //  lvo_Biometria.of_Inicializa()
				
				Destroy lvo_Biometria
			Else
				wf_Habilita_Biometria( False )
			End If
			//	
		End If
		
End Choose


end event

event clicked;//OverRide
Try
	If Row > 0 Then This.SetRow(Row)
	
	String lvs_titulo
	String lvs_coluna
	String lvs_sort_atual
	String lvs_Cabecalho
	
	Integer lvi_tamanho
	
	If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	
		lvs_titulo 		= This.GetObjectAtPointer()
		lvs_Cabecalho  = This.GetBandAtPointer()
			
		If LeftA(lvs_Cabecalho, 6) = "header" Then
			
			lvi_tamanho = PosA(lvs_titulo,CharA(9))-1
			
			If lvi_tamanho > 0 Then
				
				lvs_titulo = LeftA(lvs_titulo, lvi_tamanho)
				
				This.of_Marca_Coluna_Ativa_Ordenacao(lvs_titulo)
				
				lvs_Coluna = LeftA(lvs_Titulo,lvi_Tamanho -2 )
						
				lvs_sort_atual = This.Object.DataWindow.Table.Sort
				
				lvi_tamanho 	= LenA(lvs_sort_atual) - 2
				lvs_titulo  	= LeftA(lvs_sort_atual, lvi_tamanho)
				
				If lvs_coluna = lvs_titulo Then
					
					lvs_sort_atual = RightA(lvs_sort_atual, 1)
					
					If lvs_sort_atual = "A" Then
						lvs_sort_atual = " D"
					Else
						lvs_sort_atual = " A"
					End If
					
					lvs_coluna = lvs_coluna + lvs_sort_atual
				Else
					lvs_coluna += " A"				
				End If
				
				This.SetSort(lvs_coluna)
				This.Sort()
				
			End If	
			
		End If
	End If
Catch ( runtimeerror  lo_rte )
	//Caso o usu$$HEX1$$e100$$ENDHEX$$rio clique no campo senha, causava erro e fechava o sistema
//	MessageBox (	"Erro", "Ocorreu erro ao clicar na DW. ~r~r"+ &
// 						"Erro: "+lo_rte.GetMessage( ) + "~r~r" + &
//						 "Caso esteja utilizando leitor biom$$HEX1$$e900$$ENDHEX$$trico, ap$$HEX1$$f300$$ENDHEX$$s digitar o n$$HEX1$$fa00$$ENDHEX$$mero da matr$$HEX1$$ed00$$ENDHEX$$cula para liberar um procedimento, " + &
//						 "pressione [TAB] no teclado ao inv$$HEX1$$e900$$ENDHEX$$s de clicar sobre o campo [Senha] com o mouse.", StopSign! )
Finally	
//	Return 1
End Try
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case dw_1.GetColumnName()  
		Case "nr_matricula"			
			ivb_Inseriu_Senha = False
			dw_1.Event ue_Pos(1, "de_senha")
			
		Case "de_senha"
			ivb_Inseriu_Senha = True
	End Choose
End If
end event

