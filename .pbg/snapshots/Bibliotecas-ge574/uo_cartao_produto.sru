HA$PBExportHeader$uo_cartao_produto.sru
forward
global type uo_cartao_produto from nonvisualobject
end type
end forward

global type uo_cartao_produto from nonvisualobject
end type
global uo_cartao_produto uo_cartao_produto

type variables
Protected:
Long Cd_Administradora
Long Cd_Bandeira
String Nm_Cartao_Produto

String Tipo_Data_Credito='1'

Boolean Localizado=False
end variables

forward prototypes
public function boolean of_localiza_cartao_produto (string ps_cartao_produto)
public subroutine of_inicializa ()
private function boolean of_retorna_data_credito_2 (string ps_cartao_produto, string ps_tipo_operacao, datetime pdh_operacao, date pdt_deposito, long pl_parcela, ref date pdt_credito)
private function boolean of_retorna_data_credito_1 (string ps_cartao_produto, string ps_tipo_operacao, datetime pdh_operacao, date pdt_deposito, long pl_parcela, ref date pdt_credito)
public function boolean of_retorna_tipo_data_credito (string ps_cartao_produto, ref string ps_tipo_data_credito)
public function boolean of_retorna_data_credito (string ps_cartao_produto, string ps_tipo_operacao, datetime pdh_operacao, date pdt_deposito, long pl_parcela, ref date pdt_credito)
private function boolean of_verifica_feriado (date pdh_data)
end prototypes

public function boolean of_localiza_cartao_produto (string ps_cartao_produto);Try
	//Reseta os dados para evitar sujeira
	This.Of_Inicializa( )
	
	//Busca o valor na tabela cartao_produto
	select cd_administradora, cd_bandeira, nm_produto, id_tipo_data_credito
	Into :Cd_Administradora, :Cd_Bandeira, :Nm_Cartao_Produto, :Tipo_Data_Credito
	From cartao_produto
	Where nm_produto = :ps_cartao_produto
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		If Not gvb_auto Then MessageBox("Erro", "Falha ao buscar os dados do cartao_produto ["+gf_coalesce(ps_cartao_produto, "")+"].~r~n"+SQLCa.SQLErrText, StopSign!)
		gvo_aplicacao.Of_Grava_log( "Falha ao buscar os dados do cartao_produto ["+gf_coalesce(ps_cartao_produto, "")+"].~r~n"+SQLCa.SQLErrText )
		Localizado = False
		Return False
	End If

	Localizado = (SQLCa.SQLCode = 0)
	
Catch(RuntimeError lvo_Erro)
	If Not gvb_auto Then MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	gvo_aplicacao.Of_Grava_log( lvo_Erro.GetMessage() )
	
	This.Of_Inicializa( )
	Localizado = False
	Return False
	
Finally
	//
End Try

Return Localizado
end function

public subroutine of_inicializa ();SetNull(Cd_Administradora)
SetNull(Cd_Bandeira)
SetNull(Nm_Cartao_Produto)
Tipo_Data_Credito='1'

Localizado=False
end subroutine

private function boolean of_retorna_data_credito_2 (string ps_cartao_produto, string ps_tipo_operacao, datetime pdh_operacao, date pdt_deposito, long pl_parcela, ref date pdt_credito);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//															Tipo 2: utilizado no PIX SAQUE																//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Cr$$HEX1$$e900$$ENDHEX$$dito das transa$$HEX2$$e700f500$$ENDHEX$$es de saque... As TEDs ocorrem de segunda a sexta, da seguinte forma:										//
// 		- Segunda: TED das transa$$HEX2$$e700f500$$ENDHEX$$es de quinta a partir das 00h + transa$$HEX2$$e700f500$$ENDHEX$$es de sexta, s$$HEX1$$e100$$ENDHEX$$bado e domingo at$$HEX1$$e900$$ENDHEX$$ as 23h59;		//
//		- Ter$$HEX1$$e700$$ENDHEX$$a: TED das transa$$HEX2$$e700f500$$ENDHEX$$es de domingo a partir das 00h + transa$$HEX2$$e700f500$$ENDHEX$$es de segunda realizadas at$$HEX1$$e900$$ENDHEX$$ as 23h59;				//
//		- Quarta: TED das transa$$HEX2$$e700f500$$ENDHEX$$es de segunda realizadas a partir das 00h+ transa$$HEX2$$e700f500$$ENDHEX$$es de ter$$HEX1$$e700$$ENDHEX$$ar ealizadas at$$HEX1$$e900$$ENDHEX$$ as 23h59;	//
//		- Quinta: TED das transa$$HEX2$$e700f500$$ENDHEX$$es de ter$$HEX1$$e700$$ENDHEX$$a realizadas a partir das 00h + transa$$HEX2$$e700f500$$ENDHEX$$esde quarta realizadas at$$HEX1$$e900$$ENDHEX$$ as 23h59;		//
//		- Sexta: TED das transa$$HEX2$$e700f500$$ENDHEX$$es de quarta realizadas a partir das 00h + transa$$HEX2$$e700f500$$ENDHEX$$es de quinta realizadas at$$HEX1$$e900$$ENDHEX$$ as 23h59		//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Date lvdt_Credito
Boolean lvb_Posterga=False

Try
	//Trata parcela vazia ou n$$HEX1$$e300$$ENDHEX$$o informada
	If gf_coalesce(pl_parcela, 0)<=0 Then pl_parcela = 1
	//D+1 devido ao horario de corte ser 23:59
	lvdt_Credito = RelativeDate(Date(pdh_operacao), 1)
	//Se for feriado, s$$HEX1$$e100$$ENDHEX$$bado ou domingo precisa postergar data
	lvb_Posterga = (DayNumber(lvdt_Credito)=1 or DayNumber(lvdt_Credito)=7 or This.Of_Verifica_Feriado( lvdt_Credito ))
	//LOOP para avalia$$HEX2$$e700e300$$ENDHEX$$o da data
	Do While lvb_Posterga
		//Se $$HEX1$$e900$$ENDHEX$$ para postergar, pula um dia
		If lvb_Posterga Then lvdt_Credito =  RelativeDate(Date(lvdt_Credito), 1)	
		//Refaz a verifica$$HEX2$$e700e300$$ENDHEX$$o
		lvb_Posterga = (This.Of_Verifica_Feriado( lvdt_Credito ) or DayNumber(lvdt_Credito)=1 or DayNumber(lvdt_Credito)=7)
	Loop
	
	//Seta a vari$$HEX1$$e100$$ENDHEX$$vel de retorno
	pdt_credito = lvdt_Credito
	
Catch (RuntimeError lvo_Erro)
	If Not gvb_auto Then MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	gvo_aplicacao.Of_Grava_Log( lvo_Erro.GetMessage() )
	Return False
	
Finally
	//
End Try

Return True
end function

private function boolean of_retorna_data_credito_1 (string ps_cartao_produto, string ps_tipo_operacao, datetime pdh_operacao, date pdt_deposito, long pl_parcela, ref date pdt_credito);///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//													Tipo 1: Padr$$HEX1$$e300$$ENDHEX$$o Anterior do Troca Dados														//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Data de dep$$HEX1$$f300$$ENDHEX$$sito (dh_deposito):																												//
//			$$HEX1$$c900$$ENDHEX$$ no mesmo dia em meses subsequentes, conforme o n$$HEX1$$fa00$$ENDHEX$$mero da parcela, ou seja, se dh_operacao for	31/05		//
//			a parcela 1 ter$$HEX1$$e100$$ENDHEX$$ o dh_deposito em 31/05, a parcela 2 em 30/06, a parcela 3 em 31/07.									//
// Data Cr$$HEX1$$e900$$ENDHEX$$dito (dh_credito):																														//
//		- D$$HEX1$$e900$$ENDHEX$$bito: dh_deposito + 2																													//
//		- Cr$$HEX1$$e900$$ENDHEX$$dito: dh_deposito + 30																													//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Try
	//Anula a informa$$HEX2$$e700e300$$ENDHEX$$o da vari$$HEX1$$e100$$ENDHEX$$vel
	SetNull(pdt_credito)
	//Trata parcela vazia ou n$$HEX1$$e300$$ENDHEX$$o informada
	If gf_coalesce(pl_parcela, 0)<=0 Then pl_parcela = 1
	//Atribui o valor padr$$HEX1$$e300$$ENDHEX$$o, d$$HEX1$$e900$$ENDHEX$$bito 2 dias e cr$$HEX1$$e900$$ENDHEX$$dito 30 dias
	If ps_tipo_operacao = "VD" Then
		//padr$$HEX1$$e300$$ENDHEX$$o para d$$HEX1$$e900$$ENDHEX$$bito 2 dias ap$$HEX1$$f300$$ENDHEX$$s a opera$$HEX2$$e700e300$$ENDHEX$$o
		pdt_credito = RelativeDate(pdt_deposito, 2)
	Else
		//Data de cr$$HEX1$$e900$$ENDHEX$$dito recebe 30 dias depois da data de dep$$HEX1$$f300$$ENDHEX$$sito
		pdt_credito = RelativeDate(pdt_deposito, 30)
	End If
	
Catch (RuntimeError lvo_Erro)
	If Not gvb_auto Then MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	gvo_aplicacao.Of_Grava_Log( lvo_Erro.GetMessage() )
	Return False
	
Finally
	//
End Try

Return True
end function

public function boolean of_retorna_tipo_data_credito (string ps_cartao_produto, ref string ps_tipo_data_credito);Try
	//Anula o valor para garantir que n$$HEX1$$e100$$ENDHEX$$o repasse valores antigos
	SetNull(ps_tipo_data_credito)
	//Localiza os dados do cartao produto
	If This.Of_Localiza_Cartao_Produto( ps_cartao_produto ) Then
		ps_tipo_data_credito = Tipo_Data_Credito
	End If

Catch(RuntimeError lvo_Erro)
	If Not gvb_auto Then MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	gvo_aplicacao.Of_Grava_log( lvo_Erro.GetMessage() )
	Return False
	
Finally
	//
End Try

Return This.Localizado
end function

public function boolean of_retorna_data_credito (string ps_cartao_produto, string ps_tipo_operacao, datetime pdh_operacao, date pdt_deposito, long pl_parcela, ref date pdt_credito);Try
	//Anula a informa$$HEX2$$e700e300$$ENDHEX$$o da vari$$HEX1$$e100$$ENDHEX$$vel
	SetNull(pdt_credito)
	//Trata parcela vazia ou n$$HEX1$$e300$$ENDHEX$$o informada
	If gf_coalesce(pl_parcela, 0)<=0 Then pl_parcela = 1
	//Se for administradora diferente da anterior
	If gf_coalesce(Nm_Cartao_Produto, "") <> ps_cartao_produto Then
		//Retorna o tipo de data, conforme a data $$HEX1$$e900$$ENDHEX$$ uma formula$$HEX2$$e700e300$$ENDHEX$$o diferente
		If Not This.Of_Retorna_Tipo_Data_Credito(ps_cartao_produto, ref Tipo_Data_Credito) Then Return False
	End If
	
	Choose Case Tipo_Data_Credito
		Case '1' //D$$HEX1$$e900$$ENDHEX$$bito D+2, cr$$HEX1$$e900$$ENDHEX$$dito 30 dias
			If Not This.of_Retorna_Data_Credito_1( ps_cartao_produto, ps_tipo_operacao, pdh_operacao, pdt_deposito, pl_parcela, ref pdt_credito) Then Return False
		Case '2' //das 00:00 $$HEX1$$e000$$ENDHEX$$s 23:59, pagto em D+1, se s$$HEX1$$e100$$ENDHEX$$bado, domingo ou feriado posterga... (ex. PIX SAQUE)
			If Not This.of_Retorna_Data_Credito_2( ps_cartao_produto, ps_tipo_operacao, pdh_operacao, pdt_deposito, pl_parcela, ref pdt_credito) Then Return False
		Case Else
			If Not gvb_auto Then MessageBox("Falha", 'Tipo de data de cr$$HEX1$$e900$$ENDHEX$$dito n$$HEX1$$e300$$ENDHEX$$o definido na cartao_produto', StopSign!)
			Return False
	End Choose
	
Catch (RuntimeError lvo_Erro)
	If Not gvb_auto Then MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	gvo_aplicacao.Of_Grava_Log( lvo_Erro.GetMessage() )
	Return False
	
Finally
	//Se aqui ainda tiver vazia a data de cr$$HEX1$$e900$$ENDHEX$$dito ent$$HEX1$$e300$$ENDHEX$$o pega o valor padr$$HEX1$$e300$$ENDHEX$$o
	If IsNull(pdt_credito) Then
		If Not This.of_Retorna_Data_Credito_1( ps_cartao_produto, ps_tipo_operacao, pdh_operacao, pdt_deposito, pl_parcela, ref pdt_credito) Then Return False
	End If
End Try

Return True
end function

private function boolean of_verifica_feriado (date pdh_data);String lvs_Feriado

Try
	select case when count(1) > 0 then 'S' else 'N' end id_feriado 
	Into :lvs_Feriado
	from feriado 
	where dh_feriado=:pdh_data
		and cd_grupo_feriado=3 //grupo feriados geral
	Using SQLCa;
	
	If SQLCa.SQLCode=-1 Then
		If Not gvb_auto Then MessageBox("Erro", "Falha na busca do feriado.~r"+SQLCa.SQLErrText, StopSign!)
		gvo_aplicacao.Of_Grava_Log( "Falha na busca do feriado. "+SQLCa.SQLErrText )
	End If

Catch (RuntimeError lvo_Erro)
	If Not gvb_auto Then MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	gvo_aplicacao.Of_Grava_Log( lvo_Erro.GetMessage() )
	Return False
	
Finally
	//
End Try

Return (lvs_Feriado = 'S')
end function

on uo_cartao_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cartao_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

