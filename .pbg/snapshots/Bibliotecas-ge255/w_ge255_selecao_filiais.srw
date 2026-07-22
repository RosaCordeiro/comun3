HA$PBExportHeader$w_ge255_selecao_filiais.srw
forward
global type w_ge255_selecao_filiais from dc_w_response_ok_cancela
end type
type cb_selecao from commandbutton within w_ge255_selecao_filiais
end type
type cb_seleciona_filiais from commandbutton within w_ge255_selecao_filiais
end type
end forward

global type w_ge255_selecao_filiais from dc_w_response_ok_cancela
integer width = 1751
integer height = 1616
string title = "GE255 - Importa$$HEX2$$e700e300$$ENDHEX$$o dos Pedidos do Almoxarifado"
cb_selecao cb_selecao
cb_seleciona_filiais cb_seleciona_filiais
end type
global w_ge255_selecao_filiais w_ge255_selecao_filiais

forward prototypes
public subroutine wf_seleciona_filiais (long pl_inicio, long pl_termino)
public function boolean wf_verifica_bloqueio (long al_filial, string as_distribuidora, ref boolean ab_bloqueio)
end prototypes

public subroutine wf_seleciona_filiais (long pl_inicio, long pl_termino);Long ll_Row, ll_Filial

For ll_Row = 1 To dw_1.RowCount()
	
	ll_Filial = dw_1.Object.cd_filial	[ ll_Row ]
			
	If ll_Filial >= pl_Inicio And ll_Filial <= pl_Termino Then
		dw_1.Object.Id_Marcado [ ll_Row ] = "S"	
	End If
	
Next


end subroutine

public function boolean wf_verifica_bloqueio (long al_filial, string as_distribuidora, ref boolean ab_bloqueio);Boolean lvb_Sucesso = True

Date ldt_Bloqueio

DateTime ldh_Bloqueio

Integer li_Dia_Semana

String lvs_Fantasia

gf_Data_Parametro(Ref ldh_Bloqueio)

li_Dia_Semana = DayNumber(Date(ldh_Bloqueio))

If li_Dia_Semana = 1 Then
	ldt_Bloqueio = RelativeDate(Date(ldh_Bloqueio), -1)
	ldh_Bloqueio = DateTime(ldt_Bloqueio)
End If

ab_Bloqueio = True

Select f.nm_fantasia Into :lvs_Fantasia
From filial f
Where f.cd_filial = :al_Filial
  and Not Exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
						  and b.cd_distribuidora = :as_Distribuidora
						  and b.dh_pedido        = :ldh_Bloqueio
						  and b.cd_filial is null
						  and b.nr_dia_semana is null)
  and Not Exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
						  and b.cd_distribuidora = :as_Distribuidora
						  and b.nr_dia_semana    = datepart(weekday, :ldh_Bloqueio)
						  and b.cd_filial is null
						  and b.dh_pedido is null)
  and Not Exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
						  and b.cd_distribuidora = :as_Distribuidora
						  and b.cd_filial        = :al_Filial
						  and b.dh_pedido        = :ldh_Bloqueio
						  and b.nr_dia_semana is null)
  and Not Exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
						  and b.cd_distribuidora = :as_Distribuidora
						  and b.cd_filial        = :al_Filial
						  and b.nr_dia_semana    = datepart(weekday, :ldh_Bloqueio)
						  and b.dh_pedido is null)
  and not exists (Select *
					   From pedido_filial_bloqueio b
					   Where b.id_tipo_bloqueio = 'D'
					 	 and b.cd_distribuidora = :as_Distribuidora
						 and b.cd_filial        is null
						 and b.nr_dia_semana    is null
						 and b.dh_pedido 	    is null)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Bloqueio = False

	Case 100
		
	Case -1
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

on w_ge255_selecao_filiais.create
int iCurrent
call super::create
this.cb_selecao=create cb_selecao
this.cb_seleciona_filiais=create cb_seleciona_filiais
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecao
this.Control[iCurrent+2]=this.cb_seleciona_filiais
end on

on w_ge255_selecao_filiais.destroy
call super::destroy
destroy(this.cb_selecao)
destroy(this.cb_seleciona_filiais)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
end event

event open;call super::open;//string ls_usuario
//
//If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE255_LIBERACAO_PROCEDIMENTO", ref ls_usuario) Then 
//	Close(This)
//	Return
//End If
//
//If ls_usuario <> "505059" Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Procedimento n$$HEX1$$e300$$ENDHEX$$o liberado para este usu$$HEX1$$e100$$ENDHEX$$rio.")
//	Close(This)
//	Return
//End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge255_selecao_filiais
integer x = 14
integer y = 1284
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge255_selecao_filiais
integer width = 1691
integer height = 1396
integer weight = 700
string facename = "Verdana"
string text = "Importa$$HEX2$$e700e300$$ENDHEX$$o Pedidos do Almoxarifado"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge255_selecao_filiais
integer width = 1637
integer height = 1316
string dataobject = "dw_ge255_selecao_filiais"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge255_selecao_filiais
integer x = 1074
integer y = 1412
end type

event cb_ok::clicked;call super::clicked;Long ll_Row
Long ll_Linhas
Long ll_Filial

String	ls_Mensagem,&
		ls_ListaErros,&
		ls_Erro

Integer li_Dia, li_Hora

Boolean lb_Pedido_Novo
Boolean lb_Bloqueio_Pedido

ll_Linhas = dw_1.RowCount()

open(w_Aguarde)
w_Aguarde.uo_Progress.of_SetMax( ll_Linhas )

For ll_Row = 1 To ll_Linhas
	
	ls_Mensagem = ""
	
	If dw_1.Object.id_Marcado[ ll_Row ] = 'S' Then
	
		ll_Filial = dw_1.Object.cd_filial [ ll_Row ]
			
		If Not wf_Verifica_Bloqueio(ll_Filial, '053404705', Ref lb_Bloqueio_Pedido) Then
			Continue
		End If
		
		If lb_Bloqueio_Pedido Then
			Continue
		End If
		
		w_Aguarde.title = "Buscando Pedidos do Almoxarifado, Filial: " + String(ll_Filial)
		
		//Novo processo de pedido almoxarifado n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ necessidade de gravar faltas
		If Not gf_Pedido_Almoxarifado_Novo(ll_Filial, Ref lb_Pedido_Novo, Ref ls_Erro) Then
			ls_ListaErros += "<br>" + ls_Erro
			Continue
		End If
		
		If lb_Pedido_Novo Then
			Continue
		End If
		////
		
		Try
		
			uo_ge255_pedido_almoxarifado lo_Pedidos
			lo_Pedidos = Create uo_ge255_pedido_almoxarifado
			
			If Not lo_Pedidos.of_Conecta_Filial( ll_Filial, Ref ls_Mensagem  ) Then 
				ls_ListaErros += "<br>" + ls_Mensagem
				Continue
			End If
			
			If Not lo_Pedidos.of_Busca_Pedidos(ll_Filial, Ref ls_Mensagem) Then
				gvo_Aplicacao.of_Grava_Log("Filial: " + String(ll_Filial) + " - " + ls_Mensagem)
				If upper(ls_Mensagem) <> "NENHUM PEDIDO DO ALMOXARIFADO PARA SER EXPORTADO" Then ls_ListaErros +=  "<br>" + ls_Mensagem
			End If
			
		Catch ( NullObjectError ne )
			gvo_Aplicacao.of_Grava_Log( "Filial: " + String(ll_Filial) + " - " + ne.getMessage() )
			ls_ListaErros +=  "<br>" + "Filial: " + String(ll_Filial) + " - " + ne.getMessage()
		Finally
			Destroy lo_Pedidos
		End Try
		
	End If

	w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
		
Next

If Not IsNull( ls_ListaErros ) And Trim( ls_ListaErros ) <> "" Then gf_ge202_envia_email_automatico( 15, "Pedido Almoxarifado - Lista Erros", ls_ListaErros, {''} )              

Close(w_Aguarde)

li_Dia = DayNumber(Date(gf_GetServerDate()))

li_Hora = Integer(String(gf_GetServerDate(), "hh"))

If li_Dia >= 2 And li_Dia <= 5 Then 
								
	If li_Hora >= 18 and li_Hora <=23 Then
		OpenWithParm (w_ro016_atualizacao_faltas_almoxarifado, 'S' )	
	End If
	
End If

// Domingo
If li_Dia = 1 Then
	uo_ro097_rateio_estoque_central_almox lo_Rateio
	uo_ge259_pedido_almoxarifado lo_Pedido
	
	lo_Rateio = Create uo_ro097_rateio_estoque_central_almox
	lo_Pedido = Create uo_ge259_pedido_almoxarifado
	
	lo_Rateio.of_rateio_estoque()
	
	If lo_Rateio.ivb_Rateio_OK Then
		lo_Pedido.of_gera_pedido_distribuidora()
	End If
	
	Destroy(lo_Rateio)
	Destroy(lo_Pedido)
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Processo finalizado com sucesso.")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge255_selecao_filiais
integer x = 1403
integer y = 1412
end type

type cb_selecao from commandbutton within w_ge255_selecao_filiais
integer x = 23
integer y = 1412
integer width = 430
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Nenhuma &Filial"
end type

event clicked;Long ll_Contador

String ls_Selecao

If This.Text = "Nenhuma &Filial" Then
	This.Text = "Todas &Filiais"
	ls_Selecao = "N"	
Else
	This.Text = "Nenhuma &Filial"
	ls_Selecao = "S"
End If

For ll_Contador = 1 To dw_1.RowCount()
	dw_1.Object.Id_Marcado [ ll_Contador ] = ls_Selecao
Next
end event

type cb_seleciona_filiais from commandbutton within w_ge255_selecao_filiais
integer x = 462
integer y = 1412
integer width = 466
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Seleciona Filiais"
end type

event clicked;String ls_Retorno_Filiais

Long ll_Inicio_Filiais
Long ll_Termino_Filiais

SetPointer(HourGlass!)

Open( w_ro033_selecao_filiais )

SetPointer(Arrow!)

ls_Retorno_Filiais 	= Message.StringParm

If IsNull( ls_Retorno_Filiais ) Then Return

ll_Inicio_Filiais		= Long( Mid( ls_Retorno_Filiais, 1, 4 ) )
ll_Termino_Filiais	= Long( Mid( ls_Retorno_Filiais, 5, 8 ) )

wf_Seleciona_Filiais( ll_Inicio_Filiais, ll_Termino_Filiais )

Return
end event

