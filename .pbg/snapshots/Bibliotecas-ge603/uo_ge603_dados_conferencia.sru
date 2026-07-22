HA$PBExportHeader$uo_ge603_dados_conferencia.sru
forward
global type uo_ge603_dados_conferencia from nonvisualobject
end type
end forward

global type uo_ge603_dados_conferencia from nonvisualobject
end type
global uo_ge603_dados_conferencia uo_ge603_dados_conferencia

forward prototypes
public subroutine _documentacao ()
public function boolean of_processa_exclusao_conferencia ()
end prototypes

public subroutine _documentacao ();/*
  Objetivo:  Excluir os dados de conferencia de bacia ao final do processo.
  Motivo   :   Sem necessidade de ter estes dados por muito tempo.
*/
end subroutine

public function boolean of_processa_exclusao_conferencia ();Long ll_Linha, ll_Linhas
Long ll_cd_filial, ll_pedido, ll_Volume
Boolean lb_Sucesso = True

Try 
	dc_uo_ds_base lds_1
	lds_1 = Create dc_uo_ds_base
	
	If Not lds_1.of_ChangeDataObject('dw_ge603_dados_conferencia', False) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao trocar a DW dw_ge603_dados_conferencia", StopSign!)
		Return False
	End If 
	
	ll_Linhas = lds_1.retrieve()
		
	If ll_Linhas >0 Then
	
			// Para Carregando....
			If Not IsValid(w_aguarde) then
			Open(w_aguarde)
			End If
			w_aguarde.Title = "WMS-Processando Exclusao Dados Confer$$HEX1$$ea00$$ENDHEX$$ncia Coletor"
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.Of_SetMax(ll_linhas)
	
	
			For ll_Linha = 1 To ll_Linhas
				// Para Carregando
				w_aguarde.Title = "WMS-Processando Exclusao Endere$$HEX1$$e700$$ENDHEX$$os Controlado:" + String(ll_Linha)+" De :"+String(ll_Linhas)
				// Campos da Data Window
				ll_cd_filial 	= lds_1.Object.cd_filial[ll_Linha]
				ll_pedido 	= lds_1.Object.nr_pedido_distribuidora [ll_Linha]
				ll_Volume 	= lds_1.Object.nr_volume [ll_Linha]
			
				// Apaga Registros j$$HEX1$$e100$$ENDHEX$$ feitos Confer$$HEX1$$ea00$$ENDHEX$$ncia no Passado
				Delete From  wms_romaneio_conferencia
				Where		cd_filial  =:ll_cd_filial 
				and			nr_pedido_distribuidora=:ll_pedido
				and			nr_volume  =:ll_Volume
				Using SqlCA;
		
				If SqlCa.SqlCode = -1 Then
					lb_Sucesso = False
					SqlCa.of_Rollback()
					Exit
				End If
		
			// Para Carregando
			w_aguarde.uo_progress.Of_SetProgress(ll_Linha)
		Next
	End If
Finally
	If lb_Sucesso Then
		SqlCa.of_commit( )
	End If

	// Destroy Objetos
	If IsValid(w_aguarde) Then Close(w_aguarde)
	If IsValid(lds_1) Then Destroy(lds_1)
End try

Return lb_Sucesso
end function

on uo_ge603_dados_conferencia.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge603_dados_conferencia.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

