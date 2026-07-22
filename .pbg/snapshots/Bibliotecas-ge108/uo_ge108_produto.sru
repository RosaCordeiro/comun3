HA$PBExportHeader$uo_ge108_produto.sru
forward
global type uo_ge108_produto from uo_produto
end type
end forward

global type uo_ge108_produto from uo_produto
end type
global uo_ge108_produto uo_ge108_produto

type variables
Long il_convenio
Long il_Condicao_Convenio

Boolean ib_Cobre_Preco = False

Decimal idc_Preco_Concorrente = 0

String is_Vendedor = ""

String is_Subcategoria
Decimal idc_qt_Concentracao
Long il_Qt_Embalagem

String is_Retorno = ""

//PBM/ PBM Clamed/ Vidalink
String is_Pertence_ao_PBM

Decimal idc_desconto = 0.00
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_consulta_regras_pbms_vidalink ()
public function boolean of_possui_pbms_vidalink ()
end prototypes

public subroutine of_localiza_generica (string ps_parametro);//OverRide

String lvs_Produto

This.ivs_Parametro = ps_Parametro

Choose Case Lower( is_Window_Selecao_Generica )
	Case ""
		If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
			If gvo_aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
				OpenWithParm(w_ge001_Selecao_Produto_Filial_Paf, This)
			Else
				OpenWithParm(w_ge001_Selecao_Produto_Filial, This)		
			End If
		Else
			OpenWithParm(w_ge001_Selecao_Produto_Matriz, This)
		End If
		
	Case "w_ge001_selecao_produto_filial_atendimento" // Exclusiva para a GE108_Consulta_Preco
		OpenWithParm( w_ge108_selecao_produto_filial_atendimento, This )

	Case "w_ge001_selecao_produto_atendimento_sac" // Exclusiva para a GE103_Consulta_Preco_Filiais - SAC
		OpenWithParm( w_ge001_selecao_produto_atendimento_sac, This )		
		
	Case "w_rl154_selecao_produto_cobre_preco" // Exclusiva para a RL154 Cobre Preco
		OpenWithParm( w_rl154_selecao_produto_cobre_preco, This )
		
End Choose

lvs_Produto = Message.StringParm

If IsNull(lvs_Produto) Then
	Localizado = False
Else
	If is_Window_Selecao_Generica = 'w_rl154_selecao_produto_cobre_preco' Then
		If lvs_Produto = "NENHUM" Then
			This.Localizado = False
			This.is_retorno = lvs_Produto
			Return 
		End If
	End If
	
	This.of_Localiza_Codigo_Interno(Long(lvs_Produto))
End If
end subroutine

public subroutine of_consulta_regras_pbms_vidalink ();String ls_Log
String ls_Servidor_Intranet

If This.of_possui_pbms_vidalink( ) Then

	Choose Case This.is_Pertence_ao_PBM
		Case "PBMCLAMED"
			OpenWithParm( w_ge108_promocao_vinculada, String(idc_desconto)+'|C|'+String(This.Cd_Produto) )
			
		Case "PBM"
			OpenWithParm(w_ge001_consulta_pbm_produto, This.Cd_Produto)
			
		Case "VIDALINK"
			Try
				If Not gf_Servidor_Intranet(True, Ref ls_Servidor_Intranet, Ref ls_Log ) Then 
					Return
				End If
								
				dc_uo_api lo_Api
				lo_Api = Create dc_uo_Api
				lo_Api.of_shell_execute( ls_Servidor_Intranet + "/menu/documentos/suporte/arquivo_361_49_2.pdf", "" )
			Catch( RuntimeError ru )
				MessageBox( "RuntimeError", ru.GetMessage( ) + '~rw_ge108_consulta_preco.dw_2.event ue_Key( )', StopSign! )
			Finally
				If IsValid(lo_Api) Then Destroy lo_Api
			End Try
	
	End Choose
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(This.Cd_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o possui cadastro nos PBMs.", Information!)
End If


end subroutine

public function boolean of_possui_pbms_vidalink ();//Verifica qual PBM o produto participa
//PBM Clamed
//PBM
///Vidalink

Long ll_Count

SetNull(This.is_Pertence_ao_PBM)

If Not This.Localizado Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto n$$HEX1$$e300$$ENDHEX$$o localizado.")
	Return False
End If

//******************* a sequencia deve ser a seguinte: PBMCLamed / PBM / Vidalink

// PBM Clamed
If This.of_possui_pbm_clamed( ) Then
	is_Pertence_ao_PBM = "PBMCLAMED"
Else	
	Select Count( pp.cd_pbm )
	  Into :ll_Count
	  From pbm p, pbm_produto pp
	 Where pp.cd_produto 	= :This.Cd_Produto
		and pp.cd_pbm			= p.cd_pbm
	 Using SqlCa;
	 
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(This.Cd_Produto) + "'.")
		Return False
	End If
	
	If ll_Count > 0 Then
		is_Pertence_ao_PBM = "PBM"
	Else
		//Vidalink
		If This.Id_Farmacia_Popular = 'S' Then
			is_Pertence_ao_PBM = "VIDALINK"
		Else
			Return False
		End If
	End If
End If

Return True
	
end function

on uo_ge108_produto.create
call super::create
end on

on uo_ge108_produto.destroy
call super::destroy
end on

