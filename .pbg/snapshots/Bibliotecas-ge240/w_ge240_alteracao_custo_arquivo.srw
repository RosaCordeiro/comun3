HA$PBExportHeader$w_ge240_alteracao_custo_arquivo.srw
forward
global type w_ge240_alteracao_custo_arquivo from dc_w_response_ok_cancela
end type
end forward

global type w_ge240_alteracao_custo_arquivo from dc_w_response_ok_cancela
string tag = "w_ge240_alteracao_custo_arquivo"
integer width = 4805
integer height = 1336
string title = "GE240 - Altera$$HEX2$$e700e300$$ENDHEX$$o de Custos - ViaPlanilha"
end type
global w_ge240_alteracao_custo_arquivo w_ge240_alteracao_custo_arquivo

type variables

String is_Resp

///uo_usuario ivo_usuario
end variables

forward prototypes
public function boolean wf_valor_custo_anterior (long al_filial, long al_produto, ref decimal adc_custo_anterior, decimal adc_custo_gerencial_ant)
public function boolean wf_processa_atualizacao ()
public subroutine wf_localiza_usuario (string ps_matricula)
public function long wf_proximo_sequencial (long pl_filial)
end prototypes

public function boolean wf_valor_custo_anterior (long al_filial, long al_produto, ref decimal adc_custo_anterior, decimal adc_custo_gerencial_ant);


Select vl_custo_medio, vl_custo_gerencial
Into :adc_custo_anterior, :adc_custo_gerencial_ant
From vw_saldo_atual_produto
Where cd_filial  = :al_Filial
  and cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do custo do produto '" + String(al_Produto) + "' da filial '" + String(al_Filial))
	Return False
End If

If SqlCa.SqlCode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o custo do produto '" + String(al_Produto) +&
	"' da filial '" + String(al_Filial))
	Return False
End If


Return True
end function

public function boolean wf_processa_atualizacao ();Boolean lvb_Sucesso  =  True 

Long lvi_Sequencial

Long lvl_Linha,&
	   lvl_Linhas,&
	   lvl_Produto,&
	   lvl_Filial

String lvs_Motivo,&
		 lvs_Matricula,&
		 lvs_atualiza
		 
DateTime lvdt_Ajuste
Date	lvdh_Saldo
Decimal lvdc_Custo_Contabil_Anterior
Decimal lvdc_Custo_Gerencial_Anterior
Decimal  lvdc_Custo_Gerencial_Novo
Decimal  lvdc_Fator_Conversao
Decimal lvdc_Venda

lvl_linhas = dw_1.RowCount()

If lvl_Linhas > 0 Then 
	lvdt_Ajuste               			= gf_GetServerDate()
	For	lvl_Linha = 1 To lvl_Linhas
			lvs_atualiza						= dw_1.Object.id_atualiza[lvl_Linha]
			
			If lvs_atualiza= 'S' Then
				
				lvl_Filial							= dw_1.Object.cd_filial	      		[lvl_Linha]
				lvl_Produto               			= dw_1.Object.cd_produto      		[lvl_Linha]
				lvs_Matricula             		= dw_1.Object.nr_matricula    		[lvl_Linha]
				lvs_Motivo                			= dw_1.Object.de_Motivo        		[lvl_Linha]
				lvdc_Custo_Gerencial_Novo 	= dw_1.Object.vl_custo_novo		[lvl_Linha]
				lvdc_Fator_Conversao 		= dw_1.Object.vl_fator_conversao	[lvl_Linha]
				lvi_Sequencial 					= wf_Proximo_Sequencial(lvl_Filial)
				lvdh_Saldo 						= Date("01/" +  string(Month(date(lvdt_Ajuste)), "00") + "/" + string(Year(date(lvdt_Ajuste)), "0000"))
				lvdc_Venda 						= dw_1.Object.vl_preco_final	[lvl_Linha]

				If Not wf_Valor_Custo_Anterior(lvl_Filial,&
										       lvl_Produto,& 
											   Ref lvdc_Custo_Contabil_Anterior,&
											   Ref lvdc_Custo_Gerencial_Anterior) Then
					lvb_Sucesso = False
					Exit
				End If


				// Atualiza Filial  : 534 
				If lvl_Filial = 534 then
					lvdc_Venda = Round(lvdc_Venda * lvdc_Fator_Conversao, 2)
				
					Update saldo_produto
					Set vl_custo_medio = :lvdc_Custo_Gerencial_Novo, vl_custo_gerencial = :lvdc_Custo_Gerencial_Novo
					Where cd_filial 		= 534
						and cd_produto	= :lvl_Produto
						and dh_saldo 	= :lvdh_Saldo
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do ajuste de custo.")
						lvb_Sucesso = False
						Exit
					End If					
				End If	
			
				// Valida Custo X Valor Venda 
				If lvdc_Custo_Gerencial_Novo > lvdc_Venda Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O custo informado deve ser menor que o pre$$HEX1$$e700$$ENDHEX$$o de venda.")
					lvb_Sucesso = False
					Exit
				End If

				// Insere Ajuste
				Insert Into ajuste_custo_filial(cd_filial,
			                                nr_sequencial,
										cd_produto,
										dh_ajuste,
										vl_custo_ajustado,
										nr_matricula_responsavel,
										de_motivo_ajuste,
										vl_custo_anterior,   
							          	vl_custo_gerencial_novo,   
								         vl_custo_gerencial_anterior )  
									
				Values (:lvl_Filial,
						 :lvi_Sequencial,
						 :lvl_Produto,
						 :lvdt_Ajuste,
						 :lvdc_Custo_Gerencial_Novo,
						 :lvs_Matricula,
						 :lvs_Motivo,
						 :lvdc_Custo_Contabil_Anterior,
						 :lvdc_Custo_Gerencial_Novo,
						 :lvdc_Custo_Gerencial_Anterior)
				Using SqlCa;
				  
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do ajuste de custo.")
					lvb_Sucesso = False
					Exit
				End If
			 End If			
	Next
	
	If lvb_Sucesso Then
		SqlCa.of_Commit();
		Return lvb_Sucesso
	Else
		SqlCa.Of_Rollback();
		Return lvb_Sucesso
	End If	
End If 
end function

public subroutine wf_localiza_usuario (string ps_matricula);
//
//ivo_Usuario.of_Localiza_Usuario( ps_matricula )
//
//If Not ivo_Usuario.Localizado Then
//	
//	ivo_Usuario.of_Inicializa()
//
//End If
//
//
end subroutine

public function long wf_proximo_sequencial (long pl_filial);


Long lvi_Sequencial = 0

select max(nr_sequencial) into :lvi_Sequencial
from ajuste_custo_filial
where cd_filial = :pl_filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvi_Sequencial) Then lvi_Sequencial = 0
		lvi_Sequencial ++
	
	Case 100
		lvi_Sequencial = 1
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do sequencial")
End Choose

Return lvi_Sequencial
end function

on w_ge240_alteracao_custo_arquivo.create
call super::create
end on

on w_ge240_alteracao_custo_arquivo.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;Long ll_Linha
Long ll_Linhas
String lvs_Matricula 



dc_uo_ds_base lds_dados
lds_dados = Create dc_uo_ds_base
	
If Not lds_dados.of_ChangeDataObject("ds_ge240_lista_arquivo") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data store 'ds_ge240_lista_arquivo'.", StopSign!)
	Return
End If

// Respons$$HEX1$$e100$$ENDHEX$$vel
lvs_Matricula = Message.StringParm
	
OpenWithParm(w_ge240_seleciona_planilha, lds_dados)
	
lds_dados = Message.PowerObjectParm
ll_Linhas	 = lds_dados.RowCount()

For ll_Linha  = 1 To ll_Linhas
	
	dw_1.Object.cd_filial 			[ ll_Linha ]   = lds_dados.object.cd_filial [ll_Linha]
	dw_1.Object.nm_fantasia 	[ ll_Linha ]   = lds_dados.object.nm_fantasia[ll_Linha]
	dw_1.Object.cd_produto 	[ ll_Linha ]   = lds_dados.object.cd_produto[ll_Linha]
	dw_1.Object.de_produto 	[ ll_Linha ]   = lds_dados.object.de_produto [ll_Linha]
	dw_1.Object.id_atualiza 		[ ll_Linha ]   = "S"
	
	dw_1.Object.vl_custo_atual	 [ ll_Linha ]   = lds_dados.object.vl_custo_atual [ll_Linha]
	dw_1.Object.vl_custo_novo	 [ ll_Linha ]   = lds_dados.object.vl_custo_novo [ll_Linha]	
	dw_1.Object.de_motivo		 [ ll_Linha ]   = lds_dados.object.de_motivo [ll_Linha]	
	
	dw_1.Object.pc_desconto		 [ ll_Linha ]   = lds_dados.object.pc_desconto [ll_Linha]	
	dw_1.Object.vl_preco_unitario	 [ ll_Linha ]   = lds_dados.object.vl_preco_unitario[ll_Linha]	
	dw_1.Object.nr_matricula	 	 [ ll_Linha ]   = lvs_Matricula
	dw_1.Object.vl_preco_final	 	 [ ll_Linha ]   = dw_1.Object.valor_preco_final	 [ ll_Linha ]
	dw_1.Object.vl_fator_conversao 	 	[ ll_Linha ]   =	lds_dados.object.vl_fator_conversao [ll_Linha]
Next 






end event

event open;call super::open;//ivo_Usuario = Create uo_Usuario
//
//
//
//
//If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE240_ALTERACAO_CUSTO_ARQUIVO", ref is_Resp) Then 
//	Close(This)
//	Return
//End If
//
//Wf_Localiza_Usuario( is_Resp )
end event

event close;call super::close;///Destroy(ivo_Usuario)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge240_alteracao_custo_arquivo
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge240_alteracao_custo_arquivo
integer width = 4750
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge240_alteracao_custo_arquivo
integer x = 50
integer y = 48
integer width = 4718
integer height = 1056
string dataobject = "ds_ge240_lista_arquivo"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge240_alteracao_custo_arquivo
integer x = 4123
integer y = 1136
end type

event cb_ok::clicked;call super::clicked;

If Not wf_processa_atualizacao() Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas nas atualiza$$HEX2$$e700f500$$ENDHEX$$es: Os custos n$$HEX1$$e300$$ENDHEX$$o foram atualizados com sucesso.")		
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualizado com Sucesso!.")		
	Close(w_ge240_alteracao_custo_arquivo)	
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge240_alteracao_custo_arquivo
integer x = 4457
integer y = 1136
end type

