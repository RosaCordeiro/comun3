HA$PBExportHeader$uo_ge614_notas_canceladas.sru
forward
global type uo_ge614_notas_canceladas from nonvisualobject
end type
end forward

global type uo_ge614_notas_canceladas from nonvisualobject
end type
global uo_ge614_notas_canceladas uo_ge614_notas_canceladas

forward prototypes
public function boolean of_verifica_nf (ref string ps_msg)
end prototypes

public function boolean of_verifica_nf (ref string ps_msg);Long ll_Linhas, i
Long ll_Nota, ll_Filial
String ls_Chave, ls_Fornecedor, ls_Corpo_Email
Date ldt_Movimentacao

Try
	
	dc_uo_ds_Base lds_nf
	lds_nf = Create dc_uo_ds_Base
	
	If Not lds_nf.of_ChangeDataObject("ds_GE614_notas_canceladas") Then
		ps_msg = "Erro no changeDataObject. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_nf"
		Return False
	End If
	
	ll_Linhas = lds_nf.Retrieve()
	
	If ll_Linhas < 0 Then
		ps_msg = 'Erro no Retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_nf'
		Return False
	End If
	
	For i = 1 To ll_Linhas
		ll_Nota				= lds_nf.Object.nr_nf 								[ i ]
		ll_Filial				= lds_nf.Object.cd_filial 								[ i ]
		ls_Chave				= lds_nf.Object.de_chave_acesso 					[ i ]
		ls_Fornecedor		= lds_nf.Object.cd_fornecedor						[ i ]
		ldt_Movimentacao	= Date(lds_nf.Object.dh_movimentacao_caixa 	[ i ])
					
		ls_Corpo_Email += "<tr>" + &
									"<td>"+String(ldt_Movimentacao, 'dd/mm/yyyy')			+ "</td>" 			+ &
									"<td align=right>" + Right('0000'+String(ll_Filial),4) 		+ "</td>" 			+ &
									"<td>" +ls_Fornecedor											+ "</td>" 			+ &
									"<td align=right>" +String(ll_Nota)							+ "</td>" 			+ &
									"<td>" + ls_Chave 												+ "</td>"			+ &
								  "</tr>"
		
	Next
	
	If Not IsNull(ls_Corpo_Email) And ls_Corpo_Email <> '' Then 
		//ls_Corpo_Email = "As notas fiscais da listagem abaixo devem ser exclu$$HEX1$$ed00$$ENDHEX$$das dos sistemas Sybase e Multi.<br><br><table BORDER=1><tr BGCOLOR='#CCCCCC'><td>DATA</td><td WIDTH=80 align=right>FILIAL</td><td>FORNECEDOR</td><td WIDTH=100 align=right>NOTA</td><td>CHAVE</td></tr>" + ls_Corpo_Email + "</table>"
		ls_Corpo_Email = "<table BORDER=1><tr BGCOLOR='#CCCCCC'><td>DATA</td><td WIDTH=80 align=right>FILIAL</td><td>FORNECEDOR</td><td WIDTH=100 align=right>NOTA</td><td>CHAVE DE ACESSO</td></tr>" + ls_Corpo_Email + "</table>"
		
		//Envia Email: Fiscal / Compras
		gf_ge202_envia_email_automatico(38, '', ls_Corpo_Email, {''} )
	End If
 	
Finally
	If Not IsNull(ps_msg) And ps_msg <> '' Then gvo_Aplicacao.of_Grava_Log( ps_msg )
	
	If IsValid( lds_nf )  Then Destroy lds_nf
End Try
end function

on uo_ge614_notas_canceladas.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge614_notas_canceladas.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

