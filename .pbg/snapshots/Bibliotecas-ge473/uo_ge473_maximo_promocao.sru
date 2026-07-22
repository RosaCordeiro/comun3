HA$PBExportHeader$uo_ge473_maximo_promocao.sru
$PBExportComments$Objeto da interface Maximo Promo$$HEX2$$e700e300$$ENDHEX$$o.
forward
global type uo_ge473_maximo_promocao from nonvisualobject
end type
end forward

global type uo_ge473_maximo_promocao from nonvisualobject
end type
global uo_ge473_maximo_promocao uo_ge473_maximo_promocao

type variables
uo_ge473_comum io_Comum

String 	is_cd_produto_sap,     &
		    is_filial_sap 

Long     Il_cd_filial_legado,        &
            Il_cod_produto_legado, il_cd_promocao_legado
      
String  is_tp_alteracao

DateTime	idt_dh_saldo, &
                  idt_dh_atualizacao 

long            il_qt_max_promocao
Long 			il_Tabela = 47

Decimal	  idc_vl_custo

//-- Erro --//
  long    il_nr_controle_erro
  String is_Coluna_erro
  Int      ii_nr_item_erro
              


		
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_insere_promocao_produto (long al_cd_promocao, long al_produto, ref string as_log)
public function boolean of_atualiza_maximo_promocao (long al_controle, long al_tabela)
public subroutine of_processa_atualizacao ()
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
     SetNull( is_cd_produto_sap )
     SetNull( is_filial_sap )
     SetNull( is_tp_alteracao )
     SetNull( il_qt_max_promocao )
     SetNull( Il_cd_filial_legado)
     SetNull( Il_cod_produto_legado )
     SetNull( Il_cd_promocao_legado )

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_insere_promocao_produto (long al_cd_promocao, long al_produto, ref string as_log);long ll_existe

Select 1
into :ll_existe
from promocao_sos_produto
Where cd_produto = :al_Produto
	and cd_promocao_sos = :al_cd_promocao
Using SqlCa;
	
Choose Case Sqlca.SqlCode
	Case 0

		Update promocao_sos_produto 
		set  qt_estoque_minimo = :il_qt_max_promocao
	Where cd_produto = :al_Produto
		and cd_promocao_sos = :al_cd_promocao
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar os dados da tabela 'PROMOCAO_SOS_PRODUTO'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If	
		
	Case -1
		
		as_Log	= "Erro ao consultar dados da tabela 'PROMOCAO_SOS_PRODUTO'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
		Return False	
		
End Choose
//
Return True
end function

public function boolean of_atualiza_maximo_promocao (long al_controle, long al_tabela);long ll_achou, &
		ll_atualizacao_pend, &
		ll_linhas, &
		ll_linha

String ls_qt_saldo, &
		ls_log

Boolean	lb_Sucesso = True		

Try
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then 
		lb_sucesso = false
		return false
	end if
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
	
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If ll_Linhas > 0  Then
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_reset()
				w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
			end if
			
			For ll_Linha = 1 To ll_Linhas
				
				If Not This.of_inicializa_variaveis(Ref ls_Log) Then 
					lb_Sucesso = False
					Return False
				End If
				
				// Promocao
				If Not lo_Comum.of_localiza_codigo_promocao_legado(gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_promocao_sap[ll_Linha]), Ref il_cd_promocao_legado, Ref ls_Log) Then 
					lb_Sucesso = False
					Return False
				End If
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.wf_settext('Promo$$HEX2$$e700e300$$ENDHEX$$o: ' + String(il_cd_promocao_legado), 3 )
				end if
				
//				// Filial
//				If Not lo_Comum.of_localiza_codigo_filial_legado(lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha], Ref Il_cd_filial_legado, Ref ls_Log) Then 
//					lb_Sucesso = False
//					Return False
//				End If
				
				// Produto
				If Not lo_Comum.of_Localiza_Codigo_Produto_Legado(gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha]), Ref Il_cod_produto_legado, Ref ls_Log) Then 
					lb_Sucesso = False
					Return False
				End If
				
				//qt_max_promocao
				il_qt_max_promocao = Long(gf_Replace(lo_Comum.ids_lista_registros.Object.qt_max_promocao[ll_Linha], '.', ',', 0))
				
				
				 If not This.of_Insere_promocao_produto(il_cd_promocao_legado, Il_cod_produto_legado, Ref ls_Log) Then
					lb_Sucesso = false
					Return False
				End IF
			
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
				end if
			
			next
			
		end if
	
	end if

Finally 
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
	
End Try

Return lb_Sucesso
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_maximo_promocao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_maximo_promocao  lo_promocao
			Try
				lo_promocao	= Create uo_ge473_maximo_promocao
				lo_promocao.of_atualiza_maximo_promocao( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_promocao)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface M$$HEX1$$e100$$ENDHEX$$ximo Promo$$HEX2$$e700e300$$ENDHEX$$o - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_maximo_promocao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

on uo_ge473_maximo_promocao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_maximo_promocao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

