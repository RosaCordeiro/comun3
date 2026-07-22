HA$PBExportHeader$dc_w_identificacao_usuario.srw
forward
global type dc_w_identificacao_usuario from dc_w_response
end type
type cb_ok from commandbutton within dc_w_identificacao_usuario
end type
type cb_cancelar from commandbutton within dc_w_identificacao_usuario
end type
type dw_1 from dc_uo_dw_base within dc_w_identificacao_usuario
end type
end forward

global type dc_w_identificacao_usuario from dc_w_response
integer x = 873
integer y = 840
integer width = 1925
integer height = 632
string title = "Identifica$$HEX2$$e700e300$$ENDHEX$$o de Usu$$HEX1$$e100$$ENDHEX$$rio"
boolean controlmenu = false
long backcolor = 80269524
boolean center = true
cb_ok cb_ok
cb_cancelar cb_cancelar
dw_1 dw_1
end type
global dc_w_identificacao_usuario dc_w_identificacao_usuario

type variables
dc_uo_seguranca ivo_seguranca

String ivs_retorno
end variables

forward prototypes
public function string wf_descricao_procedimento ()
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

on dc_w_identificacao_usuario.create
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

on dc_w_identificacao_usuario.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancelar)
destroy(this.dw_1)
end on

event open;call super::open;String lvs_Descricao

SetNull(ivs_Retorno)

lvs_Descricao = Message.StringParm

ivo_seguranca = Create dc_uo_seguranca

ivo_seguranca.Cd_Sistema				= gvo_Aplicacao.ivo_Seguranca.cd_Sistema
ivo_seguranca.Cd_Procedimento     	= lvs_Descricao
ivo_seguranca.ivb_Controle_Acesso	= gvo_Aplicacao.ivo_Seguranca.ivb_Controle_Acesso
ivo_seguranca.ivb_Habilita_Cancelar	= True
ivo_seguranca.ivl_Color					= gvo_Aplicacao.ivo_Seguranca.ivl_Color

If lvs_Descricao <> "" Then
	lvs_Descricao = wf_Descricao_Procedimento()
Else
	lvs_Descricao = "VERIFICA$$HEX2$$c700c300$$ENDHEX$$O DE ACESSO"
End If

dw_1.InsertRow(0)
dw_1.Object.Cd_Procedimento[1] = This.ivo_Seguranca.Cd_Procedimento

If Trim(lvs_Descricao) <> "" Then
	dw_1.Object.De_Procedimento[1] = lvs_Descricao
	X = 900
	Y = 750	
Else
	SetNull(lvs_Descricao)
	CloseWithReturn(This, lvs_Descricao)
End If
end event

event close;call super::close;CloseWithReturn( This, ivs_Retorno )

end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Pos( 1, 'nr_matricula' )

Try
	If gvo_Aplicacao.ivb_Forca_End_Transaction Then
		SqlCa.of_End_Transaction( )
	End If
Catch( RuntimeError ex )

End Try
end event

type pb_help from dc_w_response`pb_help within dc_w_identificacao_usuario
end type

type cb_ok from commandbutton within dc_w_identificacao_usuario
boolean visible = false
integer x = 1147
integer y = 408
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
string text = "O&K"
boolean default = true
end type

event clicked;Integer lvi_Retorno

ivo_Seguranca.ivb_Login_Sucesso = True
ivs_Retorno = ivo_Seguranca.Nr_Matricula

Parent.Event Close( )
end event

type cb_cancelar from commandbutton within dc_w_identificacao_usuario
integer x = 1522
integer y = 408
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

type dw_1 from dc_uo_dw_base within dc_w_identificacao_usuario
integer x = 5
integer y = 4
integer width = 1888
integer height = 388
boolean bringtotop = true
string dataobject = "dc_dw_identificacao_usuario"
end type

event itemchanged;call super::itemchanged;String lvs_Nr_Matricula

Try
	If dwo.Name = "nr_matricula" Then
		// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio digitado existe
		This.AcceptText()
		lvs_Nr_Matricula = String( This.Object.Nr_Matricula[1] )
		
		ivo_Seguranca.of_Localiza_Usuario( lvs_Nr_Matricula )
		
		If Not ivo_Seguranca.ivb_Usuario_Localizado Then
			cb_Ok.Visible = False
			Return 1
		Else
			This.Object.Nm_Usuario[1] = ivo_Seguranca.Nm_Usuario
			
			cb_Ok.Visible	= True	
			//	
		End If
	End If // dwo.Name = "nr_matricula"
	
Catch( RuntimeError ru )
End Try
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
	
Catch ( NullObjectError  lo_noe )
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

event editchanged;call super::editchanged;If Dwo.Name = 'nr_matricula' Then
	If This.Object.Nm_Usuario[1] <> '' Then
		cb_Ok.Visible = False
	
		This.Object.Nm_Usuario[1] = ''
	End If
End If
end event

