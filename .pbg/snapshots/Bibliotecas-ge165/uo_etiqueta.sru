HA$PBExportHeader$uo_etiqueta.sru
forward
global type uo_etiqueta from nonvisualobject
end type
end forward

global type uo_etiqueta from nonvisualobject
end type
global uo_etiqueta uo_etiqueta

type variables
Boolean ib_devolucao = False // ws160
end variables

forward prototypes
public function boolean of_executa_rotina_intranet (long al_filial_origem, long al_filial_destino, long al_nf, string as_especie, string as_serie, string as_matricula)
public function long of_imprimir_etiqueta (long al_filial, long al_nf, string as_especie, string as_serie)
end prototypes

public function boolean of_executa_rotina_intranet (long al_filial_origem, long al_filial_destino, long al_nf, string as_especie, string as_serie, string as_matricula);uo_transacao_remota lo_SD
String ls_argumentos
Boolean lb_Retorno = True
Boolean lb_Desenvolvimento = False

Try
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' Then lb_Desenvolvimento = True
	
	lo_SD = Create uo_transacao_remota
	
	ls_argumentos =	"cd_filial_origem="	+ String( al_filial_origem )	+ &
							"&cd_filial_destino="	+ String( al_filial_destino )	+ &
							"&nr_nf="				+ String( al_nf )		+ &
							"&de_serie="			+ as_serie 				+ &
							"&de_especie="		+ as_especie 			+ &
							"&nr_matricula="		+ as_matricula 
	
	If lb_Desenvolvimento Then
		messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Registra Saida Transferencia em ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o.")
		lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos, False )	
	Else
		lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos )
	End If	
	
Catch ( runtimeerror  lo_rte )
	MessageBox (	"Erro", "O correu erro ao executar a rotina da intranet. ~r~r"+ & 						
 						"Erro: "+lo_rte.GetMessage( ), StopSign!)
	lb_Retorno = False	
	
Finally	
	Destroy(lo_SD)	
	Return lb_Retorno
End Try




end function

public function long of_imprimir_etiqueta (long al_filial, long al_nf, string as_especie, string as_serie);Long ll_Retorno = -1
dc_uo_ds_base lvds

Boolean lb_Etiqueta_Termica = False

Try
	lvds = Create dc_uo_ds_base
	
	If ib_devolucao Then
		If Not lvds.of_ChangeDataObject("dw_ge165_relatorio_impr_termica") Then 
			Return -1
		End If
		
		lb_Etiqueta_Termica = True
	Else
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja imprimir a etiqueta na IMPRESSORA T$$HEX1$$c900$$ENDHEX$$RMICA?", Question!, YesNo!, 1) = 1 Then
			If Not lvds.of_ChangeDataObject("dw_ge165_relatorio_impr_termica") Then 
				Return -1
			End If
			
			lb_Etiqueta_Termica = True
			
		Else
			If Not lvds.of_ChangeDataObject("dw_ge165_relatorio") Then 
				Return -1
			End If
		End If
	End If
	
	//Abre tela para selecionar a impressora
	If PrintSetup() = -1 Then
		MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
		Return -1
	End If
	
	If lvds.Retrieve(al_Filial, al_Nf, as_Especie, as_Serie) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es: ~r"+lvds.ivo_dberror.ivs_sqlerrtext )
		Return -1
	End If
	
	If lb_Etiqueta_Termica Then
		lvds.Object.codigo_barras	[1] = gf_ean128(lvds.Object.de_codigo_barras	[1])	
		
		//na ws160 antes de chamar esta fun$$HEX2$$e700e300$$ENDHEX$$o, define o ib_devolucao como true.
		If ib_devolucao Then
			lvds.Object.de_origem	[1]  = "DEVOLU$$HEX2$$c700c300$$ENDHEX$$O SEGREGADO"
		End If
	End If
	
	ll_Retorno = lvds.print()
Finally
  Destroy(lvds)
End Try  

Return ll_Retorno
end function

on uo_etiqueta.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_etiqueta.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

