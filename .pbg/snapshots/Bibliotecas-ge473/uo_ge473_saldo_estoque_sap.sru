HA$PBExportHeader$uo_ge473_saldo_estoque_sap.sru
$PBExportComments$objeto de interface da classe planejamento_estoque_sap
forward
global type uo_ge473_saldo_estoque_sap from nonvisualobject
end type
end forward

global type uo_ge473_saldo_estoque_sap from nonvisualobject
end type
global uo_ge473_saldo_estoque_sap uo_ge473_saldo_estoque_sap

type variables
uo_ge473_comum io_Comum

String 	is_cd_produto_sap,     &
		    is_filial_sap 

Long     Il_cd_filial_legado,        &
            Il_cod_produto_legado
      
String  is_tp_alteracao

DateTime	idt_dh_saldo, &
                  idt_dh_atualizacao 

long            il_qt_saldo
Long 			il_Tabela = 27

Decimal	  idc_vl_custo

//String is_chave

//-- Erro --//
  long    il_nr_controle_erro
  String is_Coluna_erro
  Int      ii_nr_item_erro
              


		
end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_grava (long al_filial, long al_produto, ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_saldo_estoque_sap (long al_controle, long al_tabela)
public function boolean of_insere_saldo_estoque_sap (long al_filial, long al_produto, datetime pdt_data, ref string as_log)
public function boolean of_excluir_registro_saldo (long al_filial, datetime pdt_data, ref string as_log)
public function boolean of_atualiza_parametro_reposicao (long al_filial, datetime pdt_data, ref string as_log)
public function boolean of_data_inclusao (long al_controle, ref datetime pdt_data, ref string as_log)
public function boolean of_valida_filial (long pl_controle, ref long pl_cd_filial, ref string ps_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);Try
		
	If IsNull(is_cd_produto_sap) or Trim(is_cd_produto_sap) = "" Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto do SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If
	
	If IsNull(is_filial_sap) or (Trim(is_filial_sap) = "") Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da filial est$$HEX1$$e100$$ENDHEX$$ nulo."
		Return False
	End If
	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
     SetNull( is_cd_produto_sap )
     SetNull( is_filial_sap )
     SetNull( is_tp_alteracao )
     SetNull( idt_dh_saldo )
     SetNull( idt_dh_atualizacao 	)
     SetNull( il_qt_saldo )
     SetNull( idc_vl_custo	)
     SetNull( Il_cd_filial_legado)
     SetNull( Il_cod_produto_legado ) 	  

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_valida_grava (long al_filial, long al_produto, ref string as_log);Try
	If IsNull(al_filial)  Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da filial legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False   
	End If

	If IsNull(al_produto)  Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto legado n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False  
	End If

	If IsNull( il_qt_saldo  )   Then
		is_Coluna_erro = 'qt_saldo'
		as_Log	= "A quantidade de disponivel n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
     //
	If  idt_dh_atualizacao < datetime('1901-01-01 00:00:00')  Then
		is_Coluna_erro = 'dh_atualizacao'
		as_Log	= "A data e hora da informa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lida!"
		Return False
	End If	
	 
	If IsNull( idt_dh_saldo ) or idt_dh_saldo < datetime('1901-01-01 00:00:00')  Then
		is_Coluna_erro = 'dh_saldo'
		as_Log	= "A data do saldo do produto na filial tem que ser uma data v$$HEX1$$e100$$ENDHEX$$lida!"
		Return False
	End If		
	
	 If isnull( idc_vl_custo ) Then
		 is_Coluna_erro = 'vl_custo'
		 as_Log	= "O valor do custo do produto n$$HEX1$$e300$$ENDHEX$$o pode ser nulo!"
		 Return False
	End If		
	
Catch ( runtimeerror   lo_rte )   
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_grava'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Saldo Estoque SAP - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_saldo_estoque_sap.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_saldo_estoque_sap  lo_saldo_estoque_sap			 
			Try
				lo_saldo_estoque_sap	= Create uo_ge473_saldo_estoque_sap
				lo_saldo_estoque_sap.of_atualiza_saldo_estoque_sap( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_saldo_estoque_sap)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Saldo Estoque SAP - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_saldo_estoque_sap.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_saldo_estoque_sap (long al_controle, long al_tabela);long ll_atualizacao_pend, &
	   ll_linhas, &
	   ll_linha, ll_cd_filial

String ls_qt_saldo, &
		ls_log,&
		ls_Hora,&
		ls_Data_Saldo

Boolean	lb_Sucesso = False

Date ldh_DH_Saldo
Time ldh_Hora_Saldo

datetime ldt_data

Try
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	 Open(w_aguarde)
	 w_aguarde.Title = "Processando Saldo Estoque SAP.."
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	if Not this.of_valida_filial( al_controle, ref ll_cd_filial, ref ls_log ) Then return false
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If Not This.of_data_inclusao(al_Controle, ref ldt_data, ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
	
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if ll_linhas = 0 Then
	
			if not this.of_atualiza_parametro_reposicao( ll_cd_filial, ldt_data, ref ls_log ) Then 
//				lb_sucesso = false
				return false
			end if
		
		ElseIf ll_Linhas > 0  Then
		
			ldh_DH_Saldo 	 = Date(lo_Comum.ids_lista_registros.Object.dh_saldo[1]) // 21/10/2019
			ldh_Hora_Saldo = Time(Mid(lo_Comum.ids_lista_registros.Object.hr_saldo[1], 1, 2) + ':' + Mid(lo_Comum.ids_lista_registros.Object.hr_saldo[1], 3, 2) + ':00') // 133847 (n$$HEX1$$e300$$ENDHEX$$o considera os mil$$HEX1$$e900$$ENDHEX$$simos de segundos)
			
			ldt_data = DateTime( ldh_DH_Saldo, ldh_Hora_Saldo)
									
			For ll_Linha = 1 To ll_Linhas
				
				// Valida se todas as datas s$$HEX1$$e300$$ENDHEX$$o realmente iguais
				If lo_Comum.ids_lista_registros.Object.hr_saldo[ll_Linha] <> lo_Comum.ids_lista_registros.Object.hr_saldo[1] Then
					ls_Log = "As datas do saldo dos materiais n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o iguais."
					Return False
				End If
												
				If Not This.of_inicializa_variaveis(Ref ls_Log) Then 
//					lb_Sucesso = False
					Return False
				End If
				
				// Filial
				If Not lo_Comum.of_localiza_codigo_filial_legado(lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha], Ref Il_cd_filial_legado, Ref ls_Log) Then 
//					lb_Sucesso = False
					Return False
				End If
				
				// Produto
				If Not lo_Comum.of_Localiza_Codigo_Produto_Legado(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha], Ref Il_cod_produto_legado, Ref ls_Log) Then 
//					lb_Sucesso = False
					Return False
				End If
	
				//dh_saldo
				If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_saldo[ll_Linha], 'DH_SALDO', ref  idt_dh_saldo, ref ls_Log) Then 
//					lb_Sucesso = False
					Return False				
				End If
				
				//qt_saldo
				il_qt_saldo = Long(gf_Replace(lo_Comum.ids_lista_registros.Object.qt_saldo[ll_Linha], '.', ',', 0))
				
				//vl_custo
				If IsNull(lo_Comum.ids_lista_registros.Object.vl_custo[ll_Linha]) Then
					lo_Comum.ids_lista_registros.Object.vl_custo[ll_Linha] = '0.00'
				End If
				
				If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_custo[ll_Linha], 'VL_CUSTO', ref  idc_vl_custo, ref ls_Log) Then 
//					lb_Sucesso = False
					Return False				
				End If
				
				 If not This.of_Insere_saldo_Estoque_Sap(Il_cd_filial_legado, Il_cod_produto_legado, ldt_data, Ref ls_Log) Then
//					lb_Sucesso = false
					Return False
				End IF
			
			next
			
			If IsNull(ll_cd_filial) or ll_cd_filial = 0 Then ll_cd_filial = Il_cd_filial_legado
			
			if not this.of_atualiza_parametro_reposicao( ll_cd_filial, ldt_data, ref ls_log ) Then 
//				lb_Sucesso = false
				return false
			End If
			
			if Not This.of_excluir_registro_saldo( ll_cd_filial, ldt_data, ref ls_log) Then
//				lb_Sucesso = false
				Return False
			End IF
			
			lb_Sucesso = True
			
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

public function boolean of_insere_saldo_estoque_sap (long al_filial, long al_produto, datetime pdt_data, ref string as_log);long ll_existe
datetime ldt_nulo

ldt_nulo = datetime(date('01/01/2200'),time('00:00'))

Select 1
into :ll_existe
from saldo_estoque_sap
Where cd_filial = :al_Filial
	And cd_produto = :al_Produto
Using SqlCa;
	
Choose Case Sqlca.SqlCode
	Case 0

		Update saldo_estoque_sap 
		set  qt_saldo = :il_qt_saldo ,
			dh_atualizacao = :pdt_data,
			vl_custo = :idc_vl_custo 
		Where cd_filial = :al_Filial
			And cd_produto = :al_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar os dados da tabela 'SALDO_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If	
		
		If SqlCa.SqlNRows <> 1 Then
			as_Log	= "Deveria ter atualizado 1 linha na tabela 'SALDO_ESTOQUE_SAP', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]."
			Return False
		End If
		
	Case 100

		Insert into saldo_estoque_sap ( cd_filial,
											cd_produto,
											qt_saldo,
											dh_atualizacao,
											vl_custo )
		values
			  ( :al_filial ,
				 :al_produto ,	
				 :il_qt_saldo ,
				:pdt_data ,
				 :idc_vl_custo )
		Using SqlCA;

		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao inserir dados na tabela 'SALDO_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
			Return False
		End If	
		
	Case -1
		
		as_Log	= "Erro ao consultar dados da tabela 'SALDO_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
		Return False	
		
End Choose

Return True
end function

public function boolean of_excluir_registro_saldo (long al_filial, datetime pdt_data, ref string as_log);Delete from saldo_estoque_sap
Where cd_filial = :al_Filial
	And dh_atualizacao < :pdt_data;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao excluir registros da tabela 'SALDO_ESTOQUE_SAP': "+ SqlCa.SqlErrText
	Return False
End If	

return true
end function

public function boolean of_atualiza_parametro_reposicao (long al_filial, datetime pdt_data, ref string as_log);long ll_existe
datetime ldt_nulo

ldt_nulo = datetime(date('01/01/2200'),time('00:00'))

Select count(*)
into :ll_existe
from parametro_reposicao_estoque
Where cd_filial = :al_filial
Using SQLCA;

Choose Case Sqlca.SqlCode
		
	Case 0
		
		Update parametro_reposicao_estoque
		set dh_atualizacao_estoque = :pdt_data
		Where cd_filial = :al_filial
		Using SQLCA;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar dados na tabela 'PARAMETRO_REPOSICAO_ESTOQUE': "+ SqlCa.SqlErrText
			Return False
		End If	
		
	Case 100
		
		Insert into parametro_reposicao_estoque(cd_filial, 
															id_tipo_reposicao,
															dh_inicio_periodo_1,
															dh_termino_periodo_1,
															vl_peso_periodo_1,
															dh_inicio_periodo_2,
															dh_termino_periodo_2,
															vl_peso_periodo_2,
															dh_inicio_periodo_3,
															dh_termino_periodo_3,
															vl_peso_periodo_3,
															dh_inicio_periodo_4,
															dh_termino_periodo_4,
															vl_peso_periodo_4,
															dh_inicio_periodo_5,
															dh_termino_periodo_5,
															vl_peso_periodo_5,
															dh_inicio_periodo_6,
															dh_termino_periodo_6,
															vl_peso_periodo_6,
															id_periodos_atualizados,
															dh_proximo_calculo)
																							
		Values (:al_filial, 'S', 
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				'N',
				:ldt_nulo)
				Using SQLCA;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao inserir dados na tabela 'PARAMETRO_REPOSICAO_ESTOQUE': "+ SqlCa.SqlErrText
			Return False
		End If	
		
		Insert into parametro_reposicao_estoque(cd_filial, 
															id_tipo_reposicao,
															dh_inicio_periodo_1,
															dh_termino_periodo_1,
															vl_peso_periodo_1,
															dh_inicio_periodo_2,
															dh_termino_periodo_2,
															vl_peso_periodo_2,
															dh_inicio_periodo_3,
															dh_termino_periodo_3,
															vl_peso_periodo_3,
															dh_inicio_periodo_4,
															dh_termino_periodo_4,
															vl_peso_periodo_4,
															dh_inicio_periodo_5,
															dh_termino_periodo_5,
															vl_peso_periodo_5,
															dh_inicio_periodo_6,
															dh_termino_periodo_6,
															vl_peso_periodo_6,
															id_periodos_atualizados,
															dh_proximo_calculo)
																							
		Values (:al_filial, 'E', 
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				:ldt_nulo,
				:ldt_nulo,
				0,
				'N',
				:ldt_nulo)
				Using SQLCA;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao inserir dados na tabela 'PARAMETRO_REPOSICAO_ESTOQUE': "+ SqlCa.SqlErrText
			Return False
		End If	
		
	Case -1
		
		as_Log	= "Erro ao consultar dados na tabela 'PARAMETRO_REPOSICAO_ESTOQUE': "+ SqlCa.SqlErrText
		Return False
		
End Choose		
		
Return true
end function

public function boolean of_data_inclusao (long al_controle, ref datetime pdt_data, ref string as_log);Select dh_inclusao
into :pdt_data
from interface_sap
Where nr_controle = :al_controle
Using SQLCA;

If Sqlca.Sqlcode = -1 Then
	as_Log	= "Erro ao consultar a data de inclus$$HEX1$$e300$$ENDHEX$$o  'INTERFACE_SAP': "+ SqlCa.SqlErrText
	Return False
End If
	
Return true
end function

public function boolean of_valida_filial (long pl_controle, ref long pl_cd_filial, ref string ps_log);String ls_chave_legado

select cd_chave_legado
into :ls_chave_legado
from integracao_sap i
where cd_tabela = 'FILIAL'
and cd_chave_sap in (select de_chave_sap from interface_sap 
							where nr_controle = :pl_controle )
Using SQLCA;

if ls_chave_legado = '' Then
	ps_log = 'O c$$HEX1$$f300$$ENDHEX$$digo da filial n$$HEX1$$e300$$ENDHEX$$o foi encontrado no sistema.'
	return false
end if

pl_cd_filial = long(ls_chave_legado)

return true
end function

on uo_ge473_saldo_estoque_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_saldo_estoque_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

