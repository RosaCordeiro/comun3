HA$PBExportHeader$w_ge359_redefinir_senha_colaborador.srw
forward
global type w_ge359_redefinir_senha_colaborador from dc_w_sheet
end type
type dw_1 from dc_uo_dw_base within w_ge359_redefinir_senha_colaborador
end type
type gb_1 from groupbox within w_ge359_redefinir_senha_colaborador
end type
type cb_salvar from commandbutton within w_ge359_redefinir_senha_colaborador
end type
end forward

global type w_ge359_redefinir_senha_colaborador from dc_w_sheet
string accessiblename = "Redefinir Senha de Colaborador (GE359)"
integer width = 2295
integer height = 720
string title = "GE359 - Redefinir Senha de Colaborador"
dw_1 dw_1
gb_1 gb_1
cb_salvar cb_salvar
end type
global w_ge359_redefinir_senha_colaborador w_ge359_redefinir_senha_colaborador

type variables
String is_Operador
String is_Usuario_SD
String is_Chamado_SD

uo_Filial		io_Filial // GE009
uo_Usuario	io_Usuario /// GE010
dc_uo_odbc io_Odbc

uo_ge136_transacao_remota itr_Filial
end variables

forward prototypes
public function boolean wf_colaborador_filial_correta ()
public function boolean wf_atualiza_senha ()
public function boolean wf_chamado_existe ()
public function boolean wf_grava_historico ()
public function boolean wf_conecta_filial (long pl_filial)
public function boolean wf_notifica_tentativa_redefinicao ()
end prototypes

public function boolean wf_colaborador_filial_correta ();Long ll_Filial

 SELECT cd_filial
	INTO :ll_Filial
   FROM usuario
 WHERE nr_matricula = :io_Usuario.Nr_Matricula
  USING itr_Filial;
  
Choose Case itr_Filial.SqlCode
	Case -1
		itr_Filial.of_MsgDbError( "wf_colaborador_filial_correta( )" )
		
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Colaborador " + io_Usuario.Nm_Usuario + " n$$HEX1$$e300$$ENDHEX$$o localizado no banco de dados da filial " + io_Filial.Nm_Fantasia, StopSign! )

	Case 0
		If ll_Filial = io_Filial.Cd_Filial Then
			Return True
		Else
			Return MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Colaborador " + io_Usuario.Nm_Usuario + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ vinculado a filial " + io_Filial.Nm_Fantasia+".~r"+&
										"Deseja continuar mesmo assim?", Question!, YesNo!, 2 ) = 1
		End If

End Choose

Return False
end function

public function boolean wf_atualiza_senha ();String lvs_Mensagem

Long lvl_chamado

UPDATE usuario
	 SET	de_senha = :io_Usuario.Nr_Matricula,
	 		id_senha_criptografada = 'N',
	 		id_situacao = case when id_situacao = 'B' then 'A' else id_situacao end,
			cd_filial_atualizacao = (select cd_filial from parametro where id_parametro = '1'),
			dh_alteracao_senha = getdate()
 WHERE nr_matricula = :io_Usuario.Nr_Matricula
  USING itr_Filial;
  
Choose Case itr_Filial.SqlCode
	Case -1
		itr_Filial.of_RollBack( )
		itr_Filial.of_MsgDbError( "wf_atualiza_senha( )" )
		Return False
	Case Else
		dw_1.Accepttext( )
		lvl_chamado = dw_1.Object.nr_chamado [1]
		
		uo_Usuario	lvo_Usuario
		lvo_Usuario = Create uo_Usuario
		lvo_Usuario.of_localiza_matricula( is_Operador )
		
		lvs_Mensagem = 	"Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio(a),<br>"+&
								"<br>"+ &
								"O usu$$HEX1$$e100$$ENDHEX$$rio "+lvo_Usuario.nm_usuario+" ("+lvo_Usuario.nr_matricula+") redefiniu a senha do usu$$HEX1$$e100$$ENDHEX$$rio "+&
								io_Usuario.nm_usuario+" ("+io_Usuario.Nr_Matricula+")."+ &
								"<br />"+ &
								"<br /><b>Database: </b>"+itr_Filial.Database+&
								"<br />"+ &
								"<br /><b>Chamado: </b>"+String(lvl_chamado)+&
								"<br /><b>Usu$$HEX1$$e100$$ENDHEX$$rio: </b>"+is_Usuario_SD+ &
								"<br /><b>Descri$$HEX2$$e700e300$$ENDHEX$$o Chamado: </b><i>"+is_Chamado_SD+"</i>"
		
		gf_ge202_envia_email_automatico(106,'Redefini$$HEX2$$e700e300$$ENDHEX$$o Senha Usu$$HEX1$$e100$$ENDHEX$$rio',lvs_Mensagem)
		
		Destroy lvo_Usuario
End Choose

Return True
end function

public function boolean wf_chamado_existe ();Long ll_Chamado

String ls_Filial_SD
String ls_Desc_Chamado

uo_ge136_transacao_remota itr_SD

is_Chamado_SD = ""
is_Usuario_SD = ""

Try
	dw_1.AcceptText( )
	ll_Chamado = dw_1.Object.Nr_Chamado[ 1 ]
	
	If Not gf_Ge136_Conecta_Banco_ServiceDesk( Ref itr_SD ) Then 
		Return MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar a base de dados do servicedesk para validar o chamado.~r" + &
									"Deseja continuar mesmo assim?", Question!, YesNo!, 2) = 1
	End If
	
	SELECT COALESCE(u.nm_usuario, '' ), left(ds_chamado, 1000)
		INTO :is_Usuario_SD, :is_Chamado_SD
	  FROM sd_chamado c
	INNER JOIN sd_usuario u 
		ON u.cd_usuario = c.cd_usuario
	WHERE c.cd_chamado = :ll_Chamado
	  USING itr_SD;
	  
	ls_Filial_SD = Mid(is_Usuario_SD, 1, 4)  
	
	Choose Case itr_SD.SqlCode
		Case -1
			itr_SD.of_MsgDbError( "wf_chamado_existe( )" )
			Return False
			
		Case 0
			If Not IsNumber( ls_Filial_SD ) and io_Filial.Cd_Filial <> 534 Then
				Return MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial do chamado informado n$$HEX1$$e300$$ENDHEX$$o correponde a filial informada.~r~rDeseja continuar?", Exclamation!, YesNo!, 2 ) = 1
			End If
			
			If Long( ls_Filial_SD ) <> io_Filial.Cd_Filial and io_Filial.Cd_Filial <> 534 Then
				Return MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial do chamado informado n$$HEX1$$e300$$ENDHEX$$o correponde a filial informada.~r~rDeseja continuar?", Exclamation!, YesNo!, 2 ) = 1
			End If
		Case 100
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Chamado n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign! )
				Return False
	End Choose
	
	Return True
Finally
	If IsValid( itr_SD ) Then
		itr_SD.of_Deleta_ODBC( "servicedesk" )
		Destroy itr_SD
	End If
End Try
end function

public function boolean wf_grava_historico ();dw_1.AcceptText( )

Long ll_Chamado
Long ll_Sequencial

ll_Chamado = dw_1.Object.Nr_Chamado[ 1 ]

 SELECT COALESCE( MAX( nr_sequencial ), 1 ) + 1
	INTO :ll_Sequencial
   FROM historico_redefinicao_senha
  USING SqlCa;
  
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_RollBack( )
		SqlCa.of_MsgDbError( "wf_grava_historico( )" )
		Return False
End Choose

INSERT 
   INTO historico_redefinicao_senha(
		nr_sequencial,
		cd_filial_colaborador,
		nr_matricula_colaborador,
		nr_matricula_operador,
		nr_chamado_servicedesk,
		dh_redefinicao)
	VALUES ( :ll_Sequencial,
				:io_Filial.Cd_Filial,
				:io_Usuario.Nr_Matricula,
				:is_Operador,
				:ll_Chamado,
				getdate( ) )
	USING SqlCa;
	
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_RollBack( )
		SqlCa.of_MsgDbError( "wf_grava_historico( )" )
		Return False
End Choose

SqlCa.of_Commit( )
Return True
end function

public function boolean wf_conecta_filial (long pl_filial);Boolean lvb_Sucesso = False
Datetime lvdh_Server
Long lvl_Feriado

Boolean lb_PDV_Java

String ls_Ref

If Not gf_retorna_loja_pdv_novo(pl_filial, ref lb_PDV_Java, ref ls_Ref ) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao conferir se a filial $$HEX1$$e900$$ENDHEX$$ PDV Java " + ls_Ref, StopSign!)
 End If

If Not lb_PDV_Java And pl_filial <> 534 Then
	If IsNull(pl_filial) Then Return False
	
	//Sistemas diferentes do SA
	If gvo_aplicacao.ivo_seguranca.cd_sistema <> "SA" Then
		lvdh_Server = gf_getserverdate()
		//Em outros sistemas apenas finais de semana ou antes das 7:30 da manha ou ap$$HEX1$$f300$$ENDHEX$$s 17:30
		If Not ((Time(lvdh_Server) >= Time("17:30")) or (Time(lvdh_Server) < Time("07:30")) or (DayNumber(Date(lvdh_Server)) = 1) or (DayNumber(Date(lvdh_Server)) = 7)) Then
			// Verifica se $$HEX1$$e900$$ENDHEX$$ feriado nacional ou municipal em Joinville
			select coalesce(count(1),0)
			Into :lvl_Feriado
			from feriado fe
			where fe.dh_feriado = cast(getdate() as date)
				and (fe.cd_grupo_feriado = 3
				or fe.cd_grupo_feriado = (select f1.cd_grupo_feriado from filial f1 where f1.cd_filial = 13))
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				SQLCa.of_msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o feriados." )
				Return False
			End If
			
			If SQLCa.SQLCode = 100 or lvl_Feriado = 0 Then
				wf_notifica_tentativa_redefinicao()
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel redefinir senha de usu$$HEX1$$e100$$ENDHEX$$rios em hor$$HEX1$$e100$$ENDHEX$$rios de plant$$HEX1$$e300$$ENDHEX$$o.", StopSign! )
				Return False
			End If
		End If
	End If
	
	Try
		dw_1.AcceptText( )
		
		w_Aguarde_1.Title = "Conectando no banco de dados da filial " + String( pl_filial )
		
		io_Odbc.of_Atualiza_Odbcs( String( pl_filial ) )
		
		lvb_Sucesso = gf_GE136_Conecta_Banco_Filial( pl_filial, Ref itr_Filial )
	
	Catch( Exception ex )
		MessageBox( "Exception", ex.getMessage( ), StopSign! )
		lvb_Sucesso = False		
	End Try
ElseIf gvo_aplicacao.ivo_seguranca.cd_sistema = "SA" Then
	itr_Filial = SQLCa
	lvb_Sucesso = True
Else
	wf_notifica_tentativa_redefinicao()
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel redefinir senha de usu$$HEX1$$e100$$ENDHEX$$rios da filial matriz.", StopSign! )
	lvb_Sucesso = False
End If

Return lvb_Sucesso
end function

public function boolean wf_notifica_tentativa_redefinicao ();String lvs_Mensagem
Long lvl_chamado
Long lvl_Filial

dw_1.Accepttext( )
lvl_chamado	= dw_1.Object.nr_chamado	[1]
lvl_Filial		= dw_1.Object.cd_filial 		[1]

uo_Usuario	lvo_Usuario
lvo_Usuario = Create uo_Usuario
lvo_Usuario.of_localiza_matricula( is_Operador )

lvs_Mensagem = 	"Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio(a),<br>"+&
						"<br>"+ &
						"O usu$$HEX1$$e100$$ENDHEX$$rio "+lvo_Usuario.nm_usuario+" ("+lvo_Usuario.nr_matricula+") tentou redefinir a senha do usu$$HEX1$$e100$$ENDHEX$$rio "+&
						io_Usuario.nm_usuario+" ("+io_Usuario.Nr_Matricula+"). A tentativa n$$HEX1$$e300$$ENDHEX$$o foi completada."+ &
						"<br />"+ &
						"<br /><b>Filial: </b>"+String(lvl_Filial)+&
						"<br /><b>Sistema: </b>"+gvo_aplicacao.ivo_seguranca.cd_sistema+&
						"<br /><b>Chamado: </b>"+String(lvl_chamado)

gf_ge202_envia_email_automatico(106,'Tentativa de Redefini$$HEX2$$e700e300$$ENDHEX$$o Senha',lvs_Mensagem)

Destroy lvo_Usuario

Return True
end function

on w_ge359_redefinir_senha_colaborador.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.cb_salvar=create cb_salvar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_salvar
end on

on w_ge359_redefinir_senha_colaborador.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.cb_salvar)
end on

event close;call super::close;Destroy(io_Filial)
Destroy(io_Odbc)
Destroy(io_Usuario)
end event

event ue_postopen;call super::ue_postopen;io_Filial		= Create uo_Filial
io_Usuario	= Create uo_Usuario
io_Odbc		= Create dc_uo_odbc

dw_1.Event ue_AddRow( )
dw_1.Event ue_Pos( 1, "nm_usuario" )
end event

event ue_preopen;call super::ue_preopen;If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("w_ge359_redefinir_senha_colaborador", ref is_Operador) Then 
	This.il_Retorno = -1
End If


end event

type dw_visual from dc_w_sheet`dw_visual within w_ge359_redefinir_senha_colaborador
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge359_redefinir_senha_colaborador
end type

type dw_1 from dc_uo_dw_base within w_ge359_redefinir_senha_colaborador
event type boolean ue_dados_preenchidos ( )
integer x = 50
integer y = 72
integer width = 2130
integer height = 268
string dataobject = "dw_ge359_cadastro"
end type

event type boolean ue_dados_preenchidos();This.AcceptText( )

If Not io_Filial.Localizada Or ( io_Filial.cd_Filial <> This.Object.Cd_Filial[ 1 ] ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial n$$HEX1$$e300$$ENDHEX$$o foi informada.", StopSign! )
	This.Event ue_Pos( 1, "nm_fantasia" )
	Return False
End If

If  Not io_Usuario.Localizado Or ( io_Usuario.Nr_Matricula <> This.Object.Nr_Matricula[ 1 ] ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O colaborador n$$HEX1$$e300$$ENDHEX$$o foi informado.", StopSign! )
	This.Event ue_Pos( 1, "nm_usuario" )
	Return False
End If

If IsNull( This.Object.Nr_Chamado[ 1 ] ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O n$$HEX1$$fa00$$ENDHEX$$mero do chamado desta ocorr$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o foi informado.", StopSign! )
	This.Event ue_Pos( 1, "nr_chamado" )
	Return False
End If

Return True
end event

event ue_key;call super::ue_key;String ls_Coluna

ls_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	Choose Case ls_Coluna
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial( This.GetText( ) )
			
//			If io_Filial.Cd_Filial = 534 or io_Filial.Cd_Filial = 2 Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Esta opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser realizada para usu$$HEX1$$e100$$ENDHEX$$rios da matriz.", Exclamation!)
//				This.Event ue_Pos(1,"Nm_Fantasia")
//				io_Filial.of_Inicializa( )
//			End If
			
			If Not io_Filial.Localizada Then
				io_Filial.of_Inicializa( )
			End If
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			
		Case "nm_usuario"
			io_Usuario.of_Localiza_Usuario( This.GetText( ) )
			
			If Not io_Usuario.Localizado Then
				io_Usuario.of_Inicializa( )
			End If
			
			This.Object.Nm_Usuario	[1] = io_Usuario.Nm_Usuario
			This.Object.Nr_Matricula	[1] = io_Usuario.Nr_Matricula
			
			If io_Usuario.Localizado Then
				io_Filial.of_localiza_codigo(io_usuario.cd_filial)
			Else
				io_filial.of_inicializa( )
			End If
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			
	End Choose
End If
end event

event losefocus;call super::losefocus;If IsValid( io_Filial ) Then
	If io_Filial.Cd_Filial <> This.Object.Cd_Filial[ 1 ] Then
		This.Object.Nm_Fantasia	[ 1 ] = io_Filial.Nm_Fantasia
		This.Object.Cd_Filial		[ 1 ] = io_Filial.Cd_Filial
	End If
End If

If IsValid( io_Usuario ) Then
	If io_Usuario.Nr_Matricula <> This.Object.Nr_Matricula[ 1 ] Then
		This.Object.Nm_Usuario	[ 1 ] = io_Usuario.Nm_Usuario
		This.Object.Nr_Matricula	[ 1 ] = io_Usuario.Nr_Matricula
	End If
End If
end event

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'nm_fantasia' 
		If Data <> io_filial.nm_fantasia Then
			If Data <> '' Then
				Return 1
			Else				
				io_filial.of_inicializa( )
				This.Object.Cd_Filial		[Row] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[Row] = io_Filial.Nm_Fantasia
			End If
		End If
		
	Case 'nm_usuario' 
		If Data <> io_usuario.nm_usuario Then
			If Data <> '' Then
				Return 1
			Else
				io_usuario.of_inicializa( )
				This.Object.nr_matricula	[Row] = io_usuario.nr_matricula
				This.Object.nm_usuario	[Row] = io_usuario.nm_usuario
				
				io_filial.of_inicializa( )
				This.Object.Cd_Filial		[Row] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[Row] = io_Filial.Nm_Fantasia
			End If
		End If
End Choose
end event

type gb_1 from groupbox within w_ge359_redefinir_senha_colaborador
integer x = 37
integer y = 20
integer width = 2181
integer height = 348
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type cb_salvar from commandbutton within w_ge359_redefinir_senha_colaborador
integer x = 1682
integer y = 400
integer width = 530
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Salvar"
end type

event clicked;Boolean lb_Close = False

dw_1.AcceptText( )

If dw_1.Event ue_Dados_Preenchidos( ) Then
	If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma redefini$$HEX2$$e700e300$$ENDHEX$$o da senha do colaborador " + io_Usuario.Nm_Usuario + " para senha inicial?", &
										Question!, YesNo!, 2 ) = 1 Then
		
		Try
			Open( w_Aguarde_1 )
			w_Aguarde_1.Title = "Realizando conex$$HEX1$$e300$$ENDHEX$$o com a filial..."
			
			If wf_conecta_filial( io_Filial.Cd_Filial ) Then
				
				w_Aguarde_1.Title = "Verificando se o colaborador est$$HEX1$$e100$$ENDHEX$$ associado a filial informada..."			
				If wf_Colaborador_Filial_Correta( ) Then
					
					w_Aguarde_1.Title = "Verificando a exist$$HEX1$$ea00$$ENDHEX$$ncia do chamado para a ocorr$$HEX1$$ea00$$ENDHEX$$ncia..."
					If wf_Chamado_Existe( ) Then
						
						w_Aguarde_1.Title = "Redefinindo a senha..."
						If wf_Atualiza_Senha( ) Then
							
							w_Aguarde_1.Title = "Gravando hist$$HEX1$$f300$$ENDHEX$$rico da redefini$$HEX2$$e700e300$$ENDHEX$$o..."
							If wf_Grava_Historico( ) Then
								
								w_Aguarde_1.Title = "Inicializando objetos..."
								
								io_Filial.of_Inicializa( )
								io_Usuario.of_Inicializa( )
								dw_1.Event ue_Reset( )
								dw_1.Event ue_AddRow( )
								
								w_Aguarde_1.Title = "Efetivando as altera$$HEX2$$e700f500$$ENDHEX$$es realizadas..."
								itr_Filial.of_Commit( )
								SqlCa.of_Commit( )
								
								If IsValid( w_Aguarde_1 ) Then Close( w_Aguarde_1 )
								
								MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Altera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.~r~rO colaborador dever$$HEX1$$e100$$ENDHEX$$ acessar o sistema com a senha igual a matr$$HEX1$$ed00$$ENDHEX$$cula." )
								lb_Close  = True
							End If
						End If
					Else
						dw_1.Event ue_Pos(1, 'nr_chamado')
					End If
				End If
			Else			
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar na filial.",Exclamation!)
			End If
		Finally
			If IsValid( w_Aguarde_1 ) Then Close( w_Aguarde_1 )			
			If IsValid( itr_Filial ) Then 
				If itr_Filial <> SQLCa Then Destroy(itr_Filial)
			End If
			
			If lb_Close Then Close( Parent )
		End Try
	End If
End If
end event

