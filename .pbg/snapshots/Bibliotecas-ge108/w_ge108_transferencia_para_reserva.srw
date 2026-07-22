HA$PBExportHeader$w_ge108_transferencia_para_reserva.srw
forward
global type w_ge108_transferencia_para_reserva from dc_w_response_ok_cancela
end type
end forward

global type w_ge108_transferencia_para_reserva from dc_w_response_ok_cancela
integer height = 632
string title = "GE108 - Pr$$HEX1$$e900$$ENDHEX$$-Reserva de Produto"
end type
global w_ge108_transferencia_para_reserva w_ge108_transferencia_para_reserva

type variables
uo_Filial 		io_Filial
uo_Usuario 	io_Usuario
uo_Produto	io_Produto

uo_ge108_parametros io_Parametros

String is_Texto = "PREENCHA SOMENTE SE FOR SOLICITADO POR TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA"
end variables

forward prototypes
public function boolean wf_busca_cliente_cpf (string ps_cd_cliente, ref string ps_nr_cpf, ref string ps_log)
end prototypes

public function boolean wf_busca_cliente_cpf (string ps_cd_cliente, ref string ps_nr_cpf, ref string ps_log);select nr_cpf_cgc
into :ps_nr_cpf
from cliente
where cd_cliente = :ps_cd_cliente;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela "cliente": ' + sqlca.sqlerrtext
	return false
end if

return true
end function

on w_ge108_transferencia_para_reserva.create
call super::create
end on

on w_ge108_transferencia_para_reserva.destroy
call super::destroy
end on

event open;call super::open;io_Parametros = Message.PowerObjectParm	

io_Filial 		= Create uo_Filial
io_Produto	= Create uo_Produto
io_Usuario 	= Create uo_Usuario

end event

event close;call super::close;IF IsValid( io_Filial ) 		Then Destroy io_Filial
IF IsValid( io_Usuario ) 	Then Destroy io_Usuario

end event

event ue_postopen;call super::ue_postopen;//Filial
If Not IsNull( io_Parametros.filial ) And io_Parametros.filial > 0 Then
	io_Filial.of_localiza_codigo( io_Parametros.filial )
	
	If io_Filial.Localizada Then
		dw_1.Object.cd_filial			[ 1 ] = io_Filial.cd_filial
		dw_1.Object.nm_fantasia	[ 1 ] = io_Filial.nm_fantasia
		
		dw_1.Object.nm_fantasia.Protect = 1
	End If
Else
	dw_1.Object.nm_fantasia[1] = is_Texto	
End If

//Produto
If Not IsNull( io_Parametros.produto ) And io_Parametros.produto > 0 Then
	io_Produto.of_localiza_codigo_Interno( io_Parametros.produto )
	
	If io_Produto.Localizado Then
		dw_1.Object.cd_Produto	[ 1 ] = io_Produto.cd_produto
		dw_1.Object.de_Produto	[ 1 ] = io_Produto.ivs_descricao_apresentacao_venda
	End If
End If

//Usuario
If Not IsNull( io_Parametros.matricula_resp_reserva ) And Trim(io_Parametros.matricula_resp_reserva) <> "" Then
	io_Usuario.of_localiza_matricula( io_Parametros.matricula_resp_reserva )
	
	If io_Usuario.Localizado Then
		dw_1.Object.nr_matricula	[ 1 ] = io_Usuario.nr_matricula
		dw_1.Object.nm_usuario		[ 1 ] = io_Usuario.nm_usuario
	End If
Else
	dw_1.Object.nm_usuario[1] = is_Texto
End If

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_transferencia_para_reserva
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_transferencia_para_reserva
integer height = 408
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_transferencia_para_reserva
integer x = 46
integer width = 2363
integer height = 320
string dataobject = "dw_ge108_transferencia_para_reserva"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.Of_Inicializa()
			
			This.Object.cd_filial		[1] = io_Filial.Cd_Filial
			This.Object.nm_fantasia	[1] = io_Filial.Nm_Fantasia
		End If
				
	Case "nm_usuario"			
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Usuario.nm_usuario Then
				Return 1
			End If
		Else
			io_Usuario.Of_Inicializa()
			
			This.Object.nr_matricula		[1] = io_Usuario.nr_matricula
			This.Object.nm_usuario		[1] = io_Usuario.nm_usuario
		End If
			
End Choose
end event

event dw_1::ue_key;call super::ue_key;Long ll_Null

SetNull(ll_Null)

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()			
		Case "nm_fantasia"
			If Upper(Trim(This.GetText())) = Upper(is_Texto) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_Texto, StopSign!)
				Return -1
			End If			
			
			io_Filial.of_Localiza_Filial( dw_1.GetText() )
						
			If io_Filial.Localizada Then
				If gvo_Parametro.cd_filial = io_Filial.cd_Filial Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A filial selecionada deve ser diferente da filial do par$$HEX1$$e200$$ENDHEX$$metro.", Exclamation!)
					Return -1
				End If
				
				This.Object.cd_filial			[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia		[1] = io_Filial.Nm_Fantasia
			End If
			
		Case "nm_usuario"
			io_Usuario.ivl_filial = ll_Null
			
			io_Usuario.of_Localiza_Usuario( dw_1.GetText() )
						
			If io_Usuario.Localizado Then
				This.Object.nr_matricula		[1] = io_Usuario.nr_Matricula
				This.Object.nm_usuario		[1] = io_Usuario.nm_Usuario
			End If
			
	End Choose
	
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_transferencia_para_reserva
integer x = 1797
integer y = 432
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_Matricula, ls_Retorno, ls_nr_cpf, ls_log

Integer li_Posicao, li_Aux

Boolean lb_Novo_Pedido = False

Decimal ldc_Qtde_Fracionada
Decimal ldc_Aux

Long ll_Filial, ll_Qtde_Empurrada
Long ll_Nr_Pedido, ll_Qtde_Cd, ll_Qtde_minima, ll_Mix_Produto

dw_1.AcceptText()

ll_Filial 		= dw_1.Object.cd_filial 			[1]
ls_Matricula = dw_1.Object.nr_matricula		[1]

If IsNull( ls_Matricula ) 	Then ls_Matricula 	= ""
If IsNull( ll_Filial ) 			Then ll_Filial 		= 0

ll_Qtde_Empurrada = io_Parametros.Qtde_Solicitada

If ll_Filial = 534 Then
	
	If gvo_Parametro.ivs_UF_Filial = "BA" And io_Produto.Id_Geladeira = "S" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido pedido urgente contendo T$$HEX1$$c900$$ENDHEX$$RMOLABIL para a Bahia.")
		Return -1
	End If
	
	Try
		uo_ge108_reserva_produtos lo_Reserva
		lo_Reserva = Create uo_ge108_reserva_produtos
		
//Vai ser tratado na gera$$HEX2$$e700e300$$ENDHEX$$o do pedido.
//		If Not lo_Reserva.of_verifica_geracao_pedido_matriz(Ref ls_log) Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_log, Exclamation!)
//			Return -1
//		End If
		
		If Not lo_Reserva.of_verifica_informacoes_matriz( io_Produto.cd_produto, ll_Qtde_Empurrada, Ref ll_Nr_Pedido, Ref ll_Qtde_Cd, Ref ll_Qtde_minima, Ref ll_Mix_Produto ) Then
			Return -1
		End If
		
		If ll_Qtde_Cd < ll_Qtde_Empurrada Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto " + String( io_Parametros.produto ) + " n$$HEX1$$e300$$ENDHEX$$o possui saldo no CD para atender esta reserva.~rQtde dispon$$HEX1$$ed00$$ENDHEX$$vel:  " + String( ll_Qtde_Cd ), Exclamation!)
			Return -1
		End If
		
	Finally
		If IsValid( lo_Reserva ) Then Destroy lo_Reserva
 	End Try
	
	//Produto com fator de conversao
	If io_Produto.vl_fator_conversao > 1 Then
		ldc_Qtde_Fracionada = Round( io_Parametros.Qtde_Solicitada / io_Produto.vl_fator_conversao, 2 )
		
		li_Posicao = PosA( String(ldc_Qtde_Fracionada), ',' )
		
		li_Aux = Integer( Mid( String( ldc_Qtde_Fracionada ), li_Posicao + 1))
		
		If li_Aux > 0 then li_Aux = 1 
			
		ll_Qtde_Empurrada = Int(ldc_Qtde_Fracionada + li_Aux)
		
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto com Fator de Convers$$HEX1$$e300$$ENDHEX$$o, ser$$HEX1$$e100$$ENDHEX$$ realizado um pedido urgente de " + String( io_Produto.vl_fator_conversao * ll_Qtde_Empurrada, '#,##0' ) + " UN.", Exclamation!)
	End If	
End If

//Retorna para a dw_2 filial e atendente atualizados
io_Parametros.Filial 							= ll_Filial
io_Parametros.Matricula_Resp_Reserva 	= ls_Matricula
io_Parametros.Mix_Produto					= ll_Mix_Produto
io_Parametros.Qtde_Minima_Aprovacao	= ll_Qtde_minima

//Grava pedido_urgente matriz
If ll_Filial = 534 Then
	Try
		uo_ge108_reserva_produtos lo
		lo = Create uo_ge108_reserva_produtos
		
		//Primeiro pedido empurrado da filial
		If IsNull( ll_Nr_Pedido ) Then ll_Nr_Pedido = 0
		
		ll_Nr_Pedido++
		
		io_Parametros.Pedido_Empurrado = ll_Nr_Pedido
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Um pedido urgente autom$$HEX1$$e100$$ENDHEX$$tico ser$$HEX1$$e100$$ENDHEX$$ gerado no CD ao t$$HEX1$$e900$$ENDHEX$$rmino desta reserva.~r~rProduto: " + io_Produto.ivs_descricao_apresentacao_venda + ".~rQtde pedida: " + String( io_Produto.vl_fator_conversao * ll_Qtde_Empurrada, '#,##0' ) + " UN." + IIF(  io_Produto.vl_fator_conversao > 1, "~rFator Convers$$HEX1$$e300$$ENDHEX$$o: " + String( io_Produto.vl_fator_conversao, '#,##0' ), "" ) + "~r~rConfirma a opera$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2 ) = 2 Then
			Return -1
		End If
		
		if Not parent.wf_busca_cliente_cpf( io_Parametros.cliente, ref ls_nr_cpf, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		end if
		
		If Not lo.of_Grava_Ped_Urgente_Matriz( ll_Nr_Pedido, io_Parametros.Matricula_Vendedor, io_Parametros.Produto, ll_Qtde_Empurrada, ls_nr_cpf ) Then
			Return -1
		End If
		
	Finally
		If IsValid( lo) Then Destroy lo
 	End Try
Else
	SetNull(io_Parametros.Pedido_empurrado)
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a pr$$HEX1$$e900$$ENDHEX$$-reserva do produto?", Question!, YesNo!, 2) = 2 Then
		Return -1
	End If
End If

io_Parametros.Retorno = "OK"

CloseWithReturn( Parent, io_Parametros )
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_transferencia_para_reserva
integer x = 2130
integer y = 432
end type

event cb_cancelar::clicked;//OverRide

String ls_Null

SetNull( ls_Null )
io_Parametros.Retorno = ls_Null

CloseWithReturn(Parent, io_Parametros)
end event

