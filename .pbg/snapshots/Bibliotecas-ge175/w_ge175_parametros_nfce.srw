HA$PBExportHeader$w_ge175_parametros_nfce.srw
forward
global type w_ge175_parametros_nfce from w_ge175_alteracao_parametro_loja
end type
end forward

global type w_ge175_parametros_nfce from w_ge175_alteracao_parametro_loja
string accessiblename = "Cadastro de Par$$HEX1$$e200$$ENDHEX$$metros NFCe (GE175)"
integer width = 2153
integer height = 1128
string title = "GE175 - Cadastro de Par$$HEX1$$e200$$ENDHEX$$metros da NFC-e / NF-e"
end type
global w_ge175_parametros_nfce w_ge175_parametros_nfce

on w_ge175_parametros_nfce.create
call super::create
end on

on w_ge175_parametros_nfce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;is_Insert_Parametros[] = {'ID_NFE_LIBERADA', 'ID_NFCE_LIBERADA', 'NR_NF_NFCE', 'DE_ESPECIE_NFCE', 'DE_SERIE_NFCE',  'NR_ID_TOKEN_NFCE', 'NR_TOKEN_NFCE' }
end event

event ue_preupdate;call super::ue_preupdate;String ls_Parametro
String ls_Valor

Integer ll_Row

dwItemStatus ldwis_Status

dw_2.AcceptText()

//

For ll_Row = 1 To dw_2.RowCount()
	ldwis_Status = dw_2.GetItemStatus( ll_Row, 'vl_parametro', Primary! )
	
	If ldwis_Status <> NotModified! Then
		dw_2.Object.Vl_Parametro[ ll_Row ] = Upper( Trim( dw_2.Object.Vl_Parametro[ ll_Row ] ) )
		
		ls_Parametro	= dw_2.Object.Cd_Parametro	[ ll_Row ]
		ls_Valor			= dw_2.Object.Vl_Parametro	[ ll_Row ]
		
		Choose Case ls_Parametro
			Case 'DE_ESPECIE_NFCE' , 'DE_SERIE_NFCE' 
				If LenA( ls_Valor ) > 3 Then
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do par$$HEX1$$e200$$ENDHEX$$metro maior que o esperado (3 caracteres).", StopSign! )
					dw_2.Event ue_Pos( ll_Row, 'vl_parametro' )
					Return False
				End If
			
			Case 'ID_NFCE_LIBERADA', 'ID_NFE_LIBERADA'
				If ls_Valor <> 'N' And ls_Valor <> 'S' Then 
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do par$$HEX1$$e200$$ENDHEX$$metro diferente de S/N.", StopSign! )
					dw_2.Event ue_Pos( ll_Row, 'vl_parametro' )
					Return False
				End If
		
			Case 'NR_ID_TOKEN_NFCE' , 'NR_NF_NFCE'
				If Not IsNumber( ls_Valor ) Then
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor num$$HEX1$$e900$$ENDHEX$$rico n$$HEX1$$e300$$ENDHEX$$o informado.", StopSign! )
					dw_2.Event ue_Pos( ll_Row, 'vl_parametro' )
					Return False
				End If 
				
			Case 'NR_TOKEN_NFCE'
				If ls_Valor = '?' Then
					dw_2.Object.Vl_Parametro [ ll_Row ] = ''
				End If
		End Choose
	End If
	
Next

Return AncestorReturnValue
end event

event ue_presave;call super::ue_presave;Return MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Estes par$$HEX1$$e200$$ENDHEX$$metros interferem na emiss$$HEX1$$e300$$ENDHEX$$o de NFE/NFCe da filial.~r~n'+&
					'Valores incorretos podem fazer com a filial n$$HEX1$$e300$$ENDHEX$$o emita notas.~r~n~r~n'+&
					'Deseja realmente alterar estes par$$HEX1$$e200$$ENDHEX$$metros?',Question!,YesNo!,2) = 1
end event

type dw_visual from w_ge175_alteracao_parametro_loja`dw_visual within w_ge175_parametros_nfce
end type

type gb_aux_visual from w_ge175_alteracao_parametro_loja`gb_aux_visual within w_ge175_parametros_nfce
end type

type dw_1 from w_ge175_alteracao_parametro_loja`dw_1 within w_ge175_parametros_nfce
end type

type gb_2 from w_ge175_alteracao_parametro_loja`gb_2 within w_ge175_parametros_nfce
integer height = 720
end type

type gb_1 from w_ge175_alteracao_parametro_loja`gb_1 within w_ge175_parametros_nfce
end type

type dw_2 from w_ge175_alteracao_parametro_loja`dw_2 within w_ge175_parametros_nfce
integer height = 624
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;Integer ll_Rows, i
String ls_Parametro, ls_Retrieve = 'S', ls_Valor

ll_Rows = Upperbound( is_Insert_Parametros )

If pl_Linhas <> ll_Rows Then
	If Not wf_Conecta_Filial() Then Return -1
		
	For i = 1 To ll_Rows
		ls_Valor 			= '?'		
		ls_Parametro 	= is_Insert_Parametros[ i ]
		
		Choose Case ls_Parametro
			Case 'DE_ESPECIE_NFCE' 
				ls_Valor = 'NFC'
			Case 'DE_SERIE_NFCE'
				ls_Valor = '1'
			Case 'ID_NFCE_LIBERADA'
				ls_Valor = 'N'
			Case 'NR_ID_TOKEN_NFCE'
				ls_Valor = '000001'
			Case 'NR_NF_NFCE'
				ls_Valor = '0'
			Case 'ID_NFE_LIBERADA'
				ls_Valor = 'N'
		End Choose
		
		//Insert parametros na matriz
		If Not wf_Insert_Parametro_Loja( ls_Parametro, ls_Valor ) Then 
			ls_Retrieve = 'N'
			Exit
		End If
		
		//Insert parametros direto na filial
		If Not wf_Insert_Parametros_na_Filial( ls_Parametro, ls_Valor ) Then 
			ls_Retrieve = 'N'
			Exit
		End If
		
	Next 
	
	wf_Desconecta_Filial()

	If ls_Retrieve = 'S' Then Return This.Event ue_Retrieve( )		
End If

Return pl_Linhas
end event

