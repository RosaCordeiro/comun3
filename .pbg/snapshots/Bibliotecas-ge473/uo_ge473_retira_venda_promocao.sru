HA$PBExportHeader$uo_ge473_retira_venda_promocao.sru
forward
global type uo_ge473_retira_venda_promocao from nonvisualobject
end type
end forward

global type uo_ge473_retira_venda_promocao from nonvisualobject
end type
global uo_ge473_retira_venda_promocao uo_ge473_retira_venda_promocao

type variables
long il_ano_documento
datetime idt_dt_documento
string is_log_criacao_doc
string is_nr_documento
string is_nr_solicitacao

boolean ib_execucao_simultanea=false
		
end variables

forward prototypes
public subroutine of_processa_atualizacao (long al_tabela)
public function boolean of_atualiza_retira_venda_promocao (long al_controle, long al_tabela)
public function boolean of_altera_promocao_sos_produto (uo_ge473_comum acomum, ref string as_log)
end prototypes

public subroutine of_processa_atualizacao (long al_tabela);Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Retira Venda Promo$$HEX2$$e700e300$$ENDHEX$$o - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_retira_venda_promocao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(al_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
			
				uo_ge473_retira_venda_promocao	lo_retira_venda_promocao
				 
				Try
					lo_retira_venda_promocao	= Create uo_ge473_retira_venda_promocao
					lo_retira_venda_promocao.of_atualiza_retira_venda_promocao( lds.Object.nr_controle[ll_Linha],al_tabela )
	
				Finally
					Destroy(lo_retira_venda_promocao)
				End Try			
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Retira Venda da Promo$$HEX2$$e700e300$$ENDHEX$$o - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_retira_venda_promocao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_retira_venda_promocao (long al_controle, long al_tabela);Boolean 	lb_Sucesso = False
Long 		ll_Atualizacao_Pend, ll_Linhas, ll_for
String 	ls_Log, ls_Chave_Controle


Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum

	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False

	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		If ll_Linhas = 1 Then
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + is_nr_solicitacao , 3 )
			end if
			
			if not this.of_altera_promocao_sos_produto(lo_Comum, ref ls_Log) then
				Return False
			else
				lb_Sucesso	 = True
			end if
									
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
		
	End If
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_retira_venda_promocao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_retira_venda_promocao]. Erro: "+lo_rte.GetMessage( )
	Return False		
Finally
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
End Try

Return True
end function

public function boolean of_altera_promocao_sos_produto (uo_ge473_comum acomum, ref string as_log);Long		ll_cd_produto, ll_cd_promocao
String	ls_cd_promocao_sap, ls_cd_produto_sap, ls_id_retira_venda, ls_id_retira_venda_calculo_eb


ls_cd_promocao_sap	= aComum.ids_lista_registros.Object.cd_promocao[1]
ls_cd_produto_sap		= aComum.ids_lista_registros.Object.cd_produto[1]
ls_id_retira_venda	= aComum.ids_lista_registros.Object.id_retira_venda[1]

select cd_promocao_sos
  into :ll_cd_promocao
  from promocao_sos
 where cd_promocao_sap	= :ls_cd_promocao_sap;

choose case SqlCa.sqlcode
	case -1
		as_Log = "Erro ao verificar existencia de registro na tabela j_1btxcof. Erro: "+SqlCa.sqlErrText
		Return False
	case 100
		as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrada promo$$HEX2$$e700e300$$ENDHEX$$o com o c$$HEX1$$f300$$ENDHEX$$digo do sap enviado."
		Return False
end choose

select cd_produto
  into :ll_cd_produto
  from produto_geral
 where cd_produto_sap	= :ls_cd_produto_sap;

choose case SqlCa.sqlcode
	case -1
		as_Log = "Erro ao verificar existencia de registro na tabela produto_geral. Erro: "+SqlCa.sqlErrText
		Return False
	case 100
		as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado produto com o c$$HEX1$$f300$$ENDHEX$$digo do sap enviado."
		Return False
end choose

if ls_id_retira_venda = 'X' then
	ls_id_retira_venda_calculo_eb	= 'S'
else
	ls_id_retira_venda_calculo_eb	= 'N'
end if

update promocao_sos_produto
	set id_retira_venda_calculo_eb	= :ls_id_retira_venda_calculo_eb
 where cd_promocao_sos	= :ll_cd_promocao and
		 cd_produto			= :ll_cd_produto;

if SqlCa.sqlcode = -1 then
	as_Log = "Erro ao atualizar a tabela promocao_sos_produto. Erro: "+SqlCa.sqlErrText
	Return False
end if

return true
end function

on uo_ge473_retira_venda_promocao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_retira_venda_promocao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

