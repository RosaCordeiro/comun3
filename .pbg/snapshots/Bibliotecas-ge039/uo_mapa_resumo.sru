HA$PBExportHeader$uo_mapa_resumo.sru
forward
global type uo_mapa_resumo from nonvisualobject
end type
end forward

global type uo_mapa_resumo from nonvisualobject
end type
global uo_mapa_resumo uo_mapa_resumo

type variables
//uo_pdv ivo_pdv

Date dh_fiscal
Date dt_inicio_blocox
String id_gera_blocoX = 'N'
end variables

forward prototypes
public function boolean of_gravacao_mapa_resumo_ok ()
public function boolean of_imprime_mapa_resumo (long pl_mapa)
public function boolean of_grava_aliquota_mapa_resumo (long pl_filial, long pl_mapa, string ps_especie, string ps_serie, long pl_ecf, integer pi_aliq[], decimal pd_base[])
public function boolean of_proximo_mapa_resumo (ref long pl_mapa, ref boolean pb_novo_mapa, date pdh_movimento)
public function long of_ultimo_sequencial (long pl_ecf)
public function boolean of_grava_mapa_resumo_bematech ()
public function boolean of_grava_mapa_resumo ()
public function boolean of_grava_mapa_resumo_sweda ()
public function boolean of_grava_mapa_resumo (date pdt_mapa)
public function boolean of_grava_mapa_resumo_bematech (date pdt_mapa)
public function boolean of_grava_mapa_resumo_daruma ()
public function boolean of_insere_mapa_resumo (long pl_filial, long pl_mapa, string ps_especie, string ps_serie, date pdt_data_fiscal)
public function boolean of_grava_mapa_resumo_epson ()
public function boolean of_proximo_historico (ref long pl_sequencial)
public function boolean of_grava_blocox_pendente (long pl_filial, long pl_mapa, long pl_ecf)
end prototypes

public function boolean of_gravacao_mapa_resumo_ok ();//Retirado, essas fun$$HEX2$$e700f500$$ENDHEX$$es j$$HEX1$$e100$$ENDHEX$$ s$$HEX1$$e300$$ENDHEX$$o chamadas no constructor do objeto uo_PDV, que $$HEX1$$e900$$ENDHEX$$ chamado no cronstructor deste objeto.
//ivo_pdv.of_modo_impressora()
//If Not ivo_pdv.Of_AbrePorta() Then Return False

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "In$$HEX1$$ed00$$ENDHEX$$cio da grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo(of_gravacao_mapa_resumo_ok).")

If Not Of_Grava_Mapa_Resumo() THEN
	
	Sqlca.of_RollBack();
		
	Return False
	
ELSE
	
	Sqlca.of_Commit();
	
	If Sqlca.sqlcode = -1 Then
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Erro no Commit.")
		Sqlca.of_MsgDbError("Erro no Commit.")
		Return False
	END IF	
	
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "T$$HEX1$$e900$$ENDHEX$$rmino da grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo(of_gravacao_mapa_resumo_ok - of_commit).")	
	
END IF	

//PDV.of_fechaporta()  - Retirado, j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ chamado no destroy da tela.

Return True
end function

public function boolean of_imprime_mapa_resumo (long pl_mapa);RETURN TRUE
end function

public function boolean of_grava_aliquota_mapa_resumo (long pl_filial, long pl_mapa, string ps_especie, string ps_serie, long pl_ecf, integer pi_aliq[], decimal pd_base[]);
LONG        lvl_Row
DECIMAL {2} lvdc_pc_aliq,lvdc_vl_base, lvdc_vl_icms

Delete From aliquota_mapa_resumo_ecf
Where cd_filial   = :pl_filial
  and nr_mapa     = :pl_mapa
  and de_especie  = :ps_especie
  and de_serie    = :ps_serie
  and nr_ecf      = :pl_ecf;

If SQLCA.SqlCode = -1 Then
	SQLCA.Of_LogDbError(gvo_Aplicacao.ivi_Log,'Exclus$$HEX1$$e300$$ENDHEX$$o das Aliquotas do Mapa Resumo.')	
	SQLCA.Of_MsgDbError('Exclus$$HEX1$$e300$$ENDHEX$$o das Aliquotas do Mapa Resumo.')
	Return False
End If

For lvl_Row = 1 To UpperBound(pi_aliq)
	
	lvdc_pc_aliq = pi_aliq[lvl_Row]
	lvdc_vl_base = pd_base[lvl_Row]
	lvdc_vl_icms = Truncate(lvdc_vl_base*(lvdc_pc_aliq/100),2)
	
	Insert Into aliquota_mapa_resumo_ecf
				(cd_filial,
				 nr_mapa,
				 de_especie,
				 de_serie,
				 nr_ecf,
				 pc_aliquota,
				 vl_base_calculo,
				 vl_icms)
	Values (:pl_filial,
			  :pl_mapa,
			  :ps_especie,
			  :ps_serie,
			  :pl_ecf,
			  :lvdc_pc_aliq,
			  :lvdc_vl_base,
			  :lvdc_vl_icms);
	
	If SQLCA.Sqlcode = -1 Then
		SQLCA.Of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o das Aliquotas de ICMS Mapa Resumo.")		
		SQLCA.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o das Aliquotas de ICMS Mapa Resumo.")
		Return False
	End If
	
Next

Return True
end function

public function boolean of_proximo_mapa_resumo (ref long pl_mapa, ref boolean pb_novo_mapa, date pdh_movimento);LONG lvl_Mapa
//
pl_mapa = 0
//
Select distinct(nr_mapa) Into :lvl_Mapa
From mapa_resumo
Where dh_emissao = :pdh_movimento
Using Sqlca;
//
Choose Case Sqlca.Sqlcode
	Case -1	
		Sqlca.Of_MsgDbError("N$$HEX1$$fa00$$ENDHEX$$mero Mapa Resumo")
		Sqlca.Of_LogDbError(gvo_Aplicacao.ivi_Log,"N$$HEX1$$fa00$$ENDHEX$$mero Mapa Resumo")
		Return False
	Case Else
		
		If lvl_Mapa > 0 Then
			pl_Mapa = lvl_Mapa
		Else
			//
			If IsNull(lvl_Mapa) or lvl_Mapa = 0 Then
				//
				Select max(nr_mapa) Into :lvl_Mapa
				From mapa_resumo
				Using Sqlca;				
				//
				If Sqlca.Sqlcode = -1 Then
					Sqlca.Of_MsgDbError("N$$HEX1$$fa00$$ENDHEX$$mero Mapa Resumo")
					Sqlca.Of_LogDbError(gvo_Aplicacao.ivi_Log,"N$$HEX1$$fa00$$ENDHEX$$mero Mapa Resumo")
					Return False
				End If
				//
				If IsNull(lvl_Mapa) Then lvl_Mapa = 0
				//
				pl_Mapa = lvl_Mapa + 1
				//
				pb_Novo_Mapa = True
				//
			End If
			//
		End If
		//
End Choose
//
Return True
end function

public function long of_ultimo_sequencial (long pl_ecf);LONG lvl_Seq,&
     lvl_Filial

lvl_Filial = gvo_parametro.cd_filial

Select max(nr_operacao_final) Into :lvl_Seq
From mapa_resumo_ecf
Where cd_filial = :lvl_Filial
  and nr_ecf    = :pl_ecf
  and nr_mapa   = ( Select max(nr_mapa)
                    from mapa_resumo_ecf
                    where cd_filial = :lvl_Filial
                      and nr_ecf    = :pl_ecf ) ;

IF SQLCA.Sqlcode = -1 THEN
	SQLCA.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Seq. Inicial.")
	SetNull(lvl_Seq)
ELSE
	IF IsNull(lvl_Seq) THEN	lvl_Seq = 1
END IF

RETURN lvl_Seq
end function

public function boolean of_grava_mapa_resumo_bematech ();

STRING      lvs_Especie, &
            lvs_Serie, &
		   lvs_serie_nova
		
DATE        lvdh_Data_Fiscal

DATETIME    lvdh_Movimentacao_Caixa,&
            lvdh_Reducao
                        
LONG 			lvl_ecf, &
     			lvl_filial, &
				lvl_Mapa_Resumo, &
				lvl_nr_operacao_atual, &				
				lvl_nr_operacao_inicial, &
				lvl_qt_reducao, &
				lvl_qt_reinicio, &
				lvl_qt_cupom_cancelado,&
				lvl_Aliq,&
				lvl_Row,&
				lvl_File,&
				lvl_Row_icms,&
				lvl_seq,&
				lvl_qt_reducao_existente

DECIMAL {2} lvdc_total_geral_inicial, &
            lvdc_total_geral_final, &
				lvdc_cancelamento, &
				lvdc_desconto, &
				lvdc_contabil, &
				lvdc_isento, &
				lvdc_nao_incidencia, &
				lvdc_st,&
				lvdc_pc_aliquota,&
				lvdc_vl_base_calculo,&
				lvdc_Faixa_Icm[],&
				lvdc_Vl_Icm[],&
	         lvdc_vl_icms,&
				lvdc_isento_iss,&
				lvdc_nao_incidencia_iss,&
				lvdc_st_iss,&
				lvdc_desconto_iss,&
				lvdc_acrescimo,&
				lvdc_acrescimo_iss,&
				lvdc_cancelamento_iss,&
				lvdc_operacao_nao_fiscal

BOOLEAN     lvb_Novo_Mapa = False

s_ge039_mapa_resumo lvs_mapa_resumo

SetPointer(HourGlass!)

gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Inicio Fun$$HEX2$$e700e300$$ENDHEX$$o da Bematech of_gravacao_mapa_resumo_bematech().")

If Not PDV.of_Verifica_Cupons_Pendentes()        Then Return False

If Not PDV.of_Mapa_Resumo(Ref lvs_mapa_resumo)   Then Return False

lvdh_Reducao = gf_GetServerDate()

//Data $$HEX1$$e900$$ENDHEX$$ armazenada antes de executar a Redu$$HEX2$$e700e300$$ENDHEX$$o Z, ap$$HEX1$$f300$$ENDHEX$$s a Redu$$HEX2$$e700e300$$ENDHEX$$o Z n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ como saber.
lvdh_Data_Fiscal	= This.dh_fiscal

lvl_Ecf					= lvs_mapa_resumo.ecf
lvl_nr_operacao_atual= lvs_mapa_resumo.operacao

lvdc_total_geral_final	= lvs_mapa_resumo.grande_total
lvdc_cancelamento	= lvs_mapa_resumo.cancelamentos
lvdc_desconto			= lvs_mapa_resumo.descontos
lvdc_contabil			= lvs_mapa_resumo.liquido

lvl_qt_reducao				= lvs_mapa_resumo.reducoes
lvl_qt_reinicio				= lvs_mapa_resumo.qt_reinicio_z
lvl_qt_cupom_cancelado	= lvs_mapa_resumo.qt_cupom_cancelado

lvdc_Isento				= lvs_mapa_resumo.isento
lvdc_nao_incidencia	= lvs_mapa_resumo.vl_nao_incidencia
lvdc_st                		= lvs_mapa_resumo.vlst

lvdc_isento_iss				= lvs_mapa_resumo.vl_isento_iss
lvdc_nao_incidencia_iss	= lvs_mapa_resumo.vl_nao_incidencia_iss
lvdc_st_iss					= lvs_mapa_resumo.vl_st_iss
lvdc_desconto_iss			= lvs_mapa_resumo.vl_desconto_iss
lvdc_acrescimo				= lvs_mapa_resumo.vl_acrescimo
lvdc_acrescimo_iss		= lvs_mapa_resumo.vl_acrescimo_iss
lvdc_cancelamento_iss	= lvs_mapa_resumo.vl_cancelamento_iss
lvdc_operacao_nao_fiscal= lvs_mapa_resumo.vl_operacao_nao_fiscal

lvdc_total_geral_inicial = lvdc_total_geral_final - ( lvdc_desconto + lvdc_cancelamento + lvdc_contabil )

If lvl_ecf = 0 Then
	gvo_Aplicacao.of_Grava_Log( "uo_mapa_resumo - of_grava_mapa_resumo_bematech - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o por numero ecf igual a 0(zero)." )			
	Return True
End If

For lvl_Row = 1 To UpperBound(lvs_mapa_resumo.str_aliquota)
	If lvs_mapa_resumo.str_aliquota[lvl_Row].valor > 0 Then
		lvl_Row_icms += 1
		lvdc_Faixa_Icm[lvl_Row_icms]	= Dec(lvs_mapa_resumo.str_aliquota[lvl_Row].aliquota)
		lvdc_Vl_Icm	    [lvl_Row_icms]	= lvs_mapa_resumo.str_aliquota[lvl_Row].valor
	End If
Next

lvl_filial             = gvo_parametro.cd_filial

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Bematech - Inclus$$HEX1$$e300$$ENDHEX$$o dos Dados(of_gravacao_mapa_resumo_bematech).")

Select mrecf.nr_ecf,
		mr.nr_mapa,
		mr.de_especie,
		mr.de_serie,
		mrecf.qt_reducao_z
Into	:lvl_Ecf,
		:lvl_Mapa_Resumo,
		:lvs_Especie,
		:lvs_Serie,
		:lvl_qt_reducao_existente
  From mapa_resumo_ecf mrecf,
       mapa_resumo mr
 Where mr.cd_filial	= mrecf.cd_filial		and
		mr.de_especie	= mrecf.de_especie	and
	    mr.de_serie		= mrecf.de_serie		and
	    mr.nr_mapa		= mrecf.nr_mapa		and
	    mr.dh_emissao	= :lvdh_Data_Fiscal	and
	    mrecf.cd_filial	= :lvl_filial       			and
	    mrecf.nr_ecf		= :lvl_ecf
 Using Sqlca;

Choose Case Sqlca.SqlCode		
	Case -1		
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")		
		Return False	
	Case 0
		If lvl_qt_reducao_existente <> lvl_qt_reducao Then //Nova redu$$HEX2$$e700e300$$ENDHEX$$o z para o mesmo dia.
			Select max(de_serie) into :lvs_serie_nova
				From mapa_resumo
			Where cd_filial =  :lvl_filial
			and nr_mapa = :lvl_mapa_resumo
			Using Sqlca;
			//
			If Sqlca.Sqlcode = -1	Then
				Sqlca.Of_MsgDbError("Serie Mapa Resumo")
				Sqlca.Of_LogDbError(gvo_Aplicacao.ivi_Log,"Serie Mapa Resumo")
				Return False
			Else
				If IsNumber(lvs_serie_nova) Then
					lvs_serie = String(Long(lvs_serie_nova) + 1)
				Else
					lvs_Serie   = '2'				
				End if
			End If		
		
			//Incluir nova serie
			lvs_Especie = 'MR'
			lvs_Serie   = '2'
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If	
			
			Insert Into mapa_resumo_ecf
					( cd_filial,   
					  nr_mapa,   
					  de_especie,   
					  de_serie,   
					  nr_ecf,
					  nr_operacao_inicial,
					  nr_operacao_final,
					  vl_total_geral_inicial,
					  vl_total_geral_final,
					  vl_cancelamento,
					  vl_desconto,
					  vl_contabil,
					  vl_isenta,
					  vl_nao_incidencia,
					  vl_st,
					  qt_reducao_z,
					  qt_reinicio_z,
					  qt_cupom_cancelado,
					  dh_reducao,
					  vl_isento_iss,
					  vl_nao_incidencia_iss,
					  vl_st_iss,
					  vl_desconto_iss,
					  vl_acrescimo,
					  vl_acrescimo_iss,
					  vl_cancelamento_iss,
					  vl_operacao_nao_fiscal)
			Values ( :lvl_filial,
						:lvl_Mapa_Resumo,   
						:lvs_especie,
						:lvs_serie,   
						:lvl_ecf,
						:lvl_nr_operacao_inicial,
						:lvl_nr_operacao_atual,
						:lvdc_total_geral_inicial,
						:lvdc_total_geral_final,
						:lvdc_cancelamento,
						:lvdc_desconto,
						:lvdc_contabil,
						:lvdc_isento,
						:lvdc_nao_incidencia,
						:lvdc_st,
						:lvl_qt_reducao,
						:lvl_qt_reinicio,
						:lvl_qt_cupom_cancelado,
						:lvdh_Reducao,
						:lvdc_isento_iss,
						:lvdc_nao_incidencia_iss,
						:lvdc_st_iss,
						:lvdc_desconto_iss,
						:lvdc_acrescimo,
						:lvdc_acrescimo_iss,
						:lvdc_cancelamento_iss,
						:lvdc_operacao_nao_fiscal)
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
				Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
				Return False
			End If	
			
			If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
			
			lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
			
			Update mapa_resumo
			set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
			Where nr_mapa    = :lvl_Mapa_Resumo
			  and cd_filial  = :lvl_filial
			  and de_especie = :lvs_especie
			  and de_serie   = :lvs_serie
			Using Sqlca;
		
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
				Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
				Return False
			End If
			
			//Grava controle de historio de envio de arquivos blocoX
			If Trim(This.id_gera_blocoX) = 'S' And lvdh_Data_Fiscal >= This.dt_inicio_blocox Then
				If Not This.of_grava_blocox_pendente( lvl_filial, lvl_mapa_resumo, lvl_ecf) Then Return False
				
				Select nr_sequencial
				Into  :lvl_seq
				  From historico_envio_arquivo_paf
				 Where cd_filial    = :lvl_filial  and
						cd_tipo = 'RZ' and
						 nr_ecf = :lvl_ecf and
						nr_mapa_resumo  = :lvl_mapa_resumo and
						qt_reducao_z = :lvl_qt_reducao
				 Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
					Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
					Return False	
				End If
				
				If Isnull(lvl_seq) Or lvl_seq = 0 Then			
					If Not This.of_proximo_historico(Ref PDV.ivl_seq_historico)   Then Return False							
					
					Insert Into historico_envio_arquivo_paf
							( cd_filial,   
							  cd_tipo,
							  qt_reducao_z,
							  nr_ecf,				  
							  nr_mapa_resumo,
							  dh_movimento,
							  id_situacao,
							  id_enviado_matriz)
					Values ( :lvl_filial,
								'RZ',
								:lvl_qt_reducao,
								:lvl_ecf,					
								:lvl_Mapa_Resumo,
								:lvdh_Data_Fiscal,
								'P',
								'N')
					Using Sqlca;	
					
					If Sqlca.Sqlcode = -1 Then
						Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
						Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
						Return False
					End If						
				Else				
					PDV.ivl_seq_historico = lvl_seq
				End If
			End If						
		Else
			Update mapa_resumo_ecf
				Set nr_operacao_final	= :lvl_nr_operacao_atual,
					 vl_total_geral_final	= :lvdc_total_geral_final,
					 vl_cancelamento		= :lvdc_cancelamento,
					 vl_desconto				= :lvdc_desconto,
					 vl_contabil				= :lvdc_contabil,
					 vl_isenta				= :lvdc_isento,
					 vl_nao_incidencia		= :lvdc_nao_incidencia,
					 vl_st						= :lvdc_st,
					 qt_reducao_z           = :lvl_qt_reducao,
					 qt_reinicio_z			= :lvl_qt_reinicio,
					 qt_cupom_cancelado	= :lvl_qt_cupom_cancelado,
	//				 dh_reducao				= :lvdh_Reducao,
					 vl_isento_iss			= :lvdc_isento_iss,	
					 vl_nao_incidencia_iss= :lvdc_nao_incidencia_iss,
					 vl_st_iss					= :lvdc_st_iss,
					 vl_desconto_iss		= :lvdc_desconto_iss,
					 vl_acrescimo			= :lvdc_acrescimo,
					 vl_acrescimo_iss		= :lvdc_acrescimo_iss,
					 vl_cancelamento_iss	= :lvdc_cancelamento_iss,
					 vl_operacao_nao_fiscal = :lvdc_operacao_nao_fiscal
			Where cd_filial  = :lvl_filial
			  and nr_mapa    = :lvl_Mapa_Resumo
			  and de_especie = :lvs_especie
			  and de_serie   = :lvs_serie
			  and nr_ecf     = :lvl_ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")			
				Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")
				Return False
			End If
			
			If Not of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		End If
	
	Case 100
		lvs_Especie = 'MR'
		lvs_Serie   = '1'
		
		If Not Of_Proximo_Mapa_Resumo(Ref lvl_Mapa_Resumo,Ref lvb_Novo_Mapa, lvdh_Data_Fiscal) Then Return False
		
		lvl_nr_operacao_inicial  = Of_Ultimo_Sequencial(lvl_Ecf)
		
		//Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial
		If IsNull(lvl_nr_operacao_inicial) Then 
			Sqlca.Of_MsgDbError("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - opera$$HEX2$$e700e300$$ENDHEX$$o inicial")
			gvo_Aplicacao.of_Grava_Log( "uo_mapa_resumo - of_grava_mapa_resumo_bematech - opera$$HEX2$$e700e300$$ENDHEX$$o inicial com valor nulo" )	
			lvl_nr_operacao_inicial = lvl_nr_operacao_atual
		End If	
		
		//Se a ECF ainda est$$HEX1$$e100$$ENDHEX$$ com a mesmo COO do $$HEX1$$fa00$$ENDHEX$$ltimo mapa gravado significa que este mapa j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ gravado
		If lvl_nr_operacao_inicial = lvl_nr_operacao_atual Then
			gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Bematech - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o pois a operacao inicial $$HEX1$$e900$$ENDHEX$$ igual a final!(of_gravacao_mapa_resumo_bematech).")			
			Return True
		End If
		
		If lvl_nr_operacao_inicial <> 0 Then
			If lvl_nr_operacao_inicial + 1 <= lvl_nr_operacao_atual Then
				lvl_nr_operacao_inicial ++
			End If	
		End If	
		
		If lvb_Novo_Mapa Then
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If
		End If	
		
		Insert Into mapa_resumo_ecf
				( cd_filial,   
				  nr_mapa,   
				  de_especie,   
				  de_serie,   
				  nr_ecf,
				  nr_operacao_inicial,
				  nr_operacao_final,
				  vl_total_geral_inicial,
				  vl_total_geral_final,
				  vl_cancelamento,
				  vl_desconto,
				  vl_contabil,
				  vl_isenta,
				  vl_nao_incidencia,
				  vl_st,
				  qt_reducao_z,
				  qt_reinicio_z,
				  qt_cupom_cancelado,
				  dh_reducao,
				  vl_isento_iss,
				  vl_nao_incidencia_iss,
				  vl_st_iss,
				  vl_desconto_iss,
				  vl_acrescimo,
				  vl_acrescimo_iss,
				  vl_cancelamento_iss,
				  vl_operacao_nao_fiscal)
		Values ( :lvl_filial,
					:lvl_Mapa_Resumo,   
					:lvs_especie,
					:lvs_serie,   
					:lvl_ecf,
					:lvl_nr_operacao_inicial,
					:lvl_nr_operacao_atual,
					:lvdc_total_geral_inicial,
					:lvdc_total_geral_final,
					:lvdc_cancelamento,
					:lvdc_desconto,
					:lvdc_contabil,
					:lvdc_isento,
					:lvdc_nao_incidencia,
					:lvdc_st,
					:lvl_qt_reducao,
					:lvl_qt_reinicio,
					:lvl_qt_cupom_cancelado,
					:lvdh_Reducao,
					:lvdc_isento_iss,
					:lvdc_nao_incidencia_iss,
					:lvdc_st_iss,
					:lvdc_desconto_iss,
					:lvdc_acrescimo,
					:lvdc_acrescimo_iss,
					:lvdc_cancelamento_iss,
					:lvdc_operacao_nao_fiscal)
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
			Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
			Return False
		End If	
		
		If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		
		lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
		
		Update mapa_resumo
		set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
		Where nr_mapa    = :lvl_Mapa_Resumo
		  and cd_filial  = :lvl_filial
		  and de_especie = :lvs_especie
		  and de_serie   = :lvs_serie
		Using Sqlca;
	
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
			Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
			Return False
		End If
		
		//Grava controle de historio de envio de arquivos blocoX
		If Trim(This.id_gera_blocoX) = 'S' And lvdh_Data_Fiscal >= This.dt_inicio_blocox Then
			If Not This.of_grava_blocox_pendente( lvl_filial, lvl_mapa_resumo, lvl_ecf) Then Return False
			
			Select nr_sequencial
			Into  :lvl_seq
			  From historico_envio_arquivo_paf
			 Where cd_filial    = :lvl_filial  and
			 		cd_tipo = 'RZ' and
					 nr_ecf = :lvl_ecf and
					nr_mapa_resumo  = :lvl_mapa_resumo and
					qt_reducao_z = :lvl_qt_reducao
			 Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
				Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
				Return False	
			End If
			
			If Isnull(lvl_seq) Or lvl_seq = 0 Then			
				If Not This.of_proximo_historico(Ref PDV.ivl_seq_historico)   Then Return False							
				
				Insert Into historico_envio_arquivo_paf
						( cd_filial,   
						  cd_tipo,
						  qt_reducao_z,
						  nr_ecf,				  
						  nr_mapa_resumo,
						  dh_movimento,
						  id_situacao,
						  id_enviado_matriz)
				Values ( :lvl_filial,
							'RZ',
							:lvl_qt_reducao,
							:lvl_ecf,					
							:lvl_Mapa_Resumo,
							:lvdh_Data_Fiscal,
							'P',
							'N')
				Using Sqlca;	
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
					Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
					Return False
				End If						
			Else				
				PDV.ivl_seq_historico = lvl_seq
			End If
		End If				
	
End Choose

gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Bematech - Termino da fun$$HEX1$$e700$$ENDHEX$$ao com sucesso!(of_gravacao_mapa_resumo_bematech).")

Return True
end function

public function boolean of_grava_mapa_resumo ();Boolean lvb_Sucesso

If IsValid(w_janela_aguarde) Then 
	w_janela_aguarde.mle_1.text = "Gravando Mapa Resumo"
Else
	Open(w_janela_aguarde)	
	w_janela_aguarde.mle_1.text = "Gravando Mapa Resumo"
End If	

Choose Case PDV.Fabricante
	Case "Bematech"
		lvb_Sucesso = This.of_grava_mapa_resumo_bematech()
	Case "Itautec"
		
	Case "Daruma"
		lvb_Sucesso = This.of_grava_mapa_resumo_daruma()
		
	Case "Epson"
		lvb_Sucesso = This.of_grava_mapa_resumo_epson()		
		
	Case Else
		lvb_Sucesso = This.of_grava_mapa_resumo_sweda()
End Choose

Return lvb_Sucesso

end function

public function boolean of_grava_mapa_resumo_sweda ();STRING      lvs_Especie, &
            lvs_Serie,&
		   lvs_serie_nova
		
DATE        lvdh_Data_Fiscal

DATETIME    lvdh_Movimentacao_Caixa,&
            lvdh_Reducao
                        
LONG 			lvl_ecf, &
     			lvl_filial, &
				lvl_Mapa_Resumo, &
				lvl_nr_operacao_atual, &				
				lvl_nr_operacao_inicial, &
				lvl_qt_reducao, &
				lvl_qt_reinicio, &
				lvl_qt_cupom_cancelado,&
				lvl_Aliq,&
				lvl_Row,&
				lvl_File,&
				lvl_Row_icms,&
				lvl_seq,&
				lvl_qt_reducao_existente

DECIMAL {2} lvdc_total_geral_inicial, &
            lvdc_total_geral_final, &
				lvdc_cancelamento, &
				lvdc_desconto, &
				lvdc_contabil, &
				lvdc_isento, &
				lvdc_nao_incidencia, &
				lvdc_st,&
				lvdc_pc_aliquota,&
				lvdc_vl_base_calculo,&
				lvdc_Faixa_Icm[],&
				lvdc_Vl_Icm[],&
	         lvdc_vl_icms,&
				lvdc_isento_iss,&
				lvdc_nao_incidencia_iss,&
				lvdc_st_iss,&
				lvdc_desconto_iss,&
				lvdc_acrescimo,&
				lvdc_acrescimo_iss,&
				lvdc_cancelamento_iss,&
				lvdc_operacao_nao_fiscal

BOOLEAN     lvb_Novo_Mapa = False

s_ge039_mapa_resumo lvs_mapa_resumo

SetPointer(HourGlass!)

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Inicio Fun$$HEX2$$e700e300$$ENDHEX$$o da Sweda(of_gravacao_mapa_resumo_sweda).")

If Not PDV.of_Verifica_Cupons_Pendentes()        Then Return False

If Not PDV.of_Mapa_Resumo(Ref lvs_mapa_resumo)   Then Return False

lvdh_Reducao = gf_GetServerDate()

//Data $$HEX1$$e900$$ENDHEX$$ armazenada antes de executar a Redu$$HEX2$$e700e300$$ENDHEX$$o Z, ap$$HEX1$$f300$$ENDHEX$$s a Redu$$HEX2$$e700e300$$ENDHEX$$o Z n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ como saber.
lvdh_Data_Fiscal       = This.dh_fiscal

lvl_Ecf                = lvs_mapa_resumo.ecf
lvl_nr_operacao_atual  = lvs_mapa_resumo.operacao

lvdc_total_geral_final = lvs_mapa_resumo.grande_total
lvdc_cancelamento      = lvs_mapa_resumo.cancelamentos
lvdc_desconto          = lvs_mapa_resumo.descontos
lvdc_contabil          = lvs_mapa_resumo.liquido

lvl_qt_reducao         = lvs_mapa_resumo.reducoes
lvl_qt_reinicio        = lvs_mapa_resumo.qt_reinicio_z
lvl_qt_cupom_cancelado = lvs_mapa_resumo.qt_cupom_cancelado

lvdc_Isento            = lvs_mapa_resumo.isento
lvdc_nao_incidencia    = lvs_mapa_resumo.vl_nao_incidencia
lvdc_st                = lvs_mapa_resumo.vlst

lvdc_isento_iss			 = lvs_mapa_resumo.vl_isento_iss
lvdc_nao_incidencia_iss  = lvs_mapa_resumo.vl_nao_incidencia_iss
lvdc_st_iss					 = lvs_mapa_resumo.vl_st_iss
lvdc_desconto_iss			 = lvs_mapa_resumo.vl_desconto_iss
lvdc_acrescimo				 = lvs_mapa_resumo.vl_acrescimo
lvdc_acrescimo_iss		 =	lvs_mapa_resumo.vl_acrescimo_iss
lvdc_cancelamento_iss	 = lvs_mapa_resumo.vl_cancelamento_iss
lvdc_operacao_nao_fiscal = lvs_mapa_resumo.vl_operacao_nao_fiscal

lvdc_total_geral_inicial = lvdc_total_geral_final - ( lvdc_desconto + lvdc_cancelamento + lvdc_contabil )

If lvl_ecf = 0 Then 
	gvo_Aplicacao.of_Grava_Log( "uo_mapa_resumo - of_grava_mapa_resumo_sweda - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o por numero ecf igual a 0(zero)." )		
	Return True
End If

For lvl_Row = 1 To UpperBound(lvs_mapa_resumo.str_aliquota)
	If lvs_mapa_resumo.str_aliquota[lvl_Row].valor > 0 Then
		lvl_Row_icms += 1
		lvdc_Faixa_Icm[lvl_Row_icms]      = Dec(lvs_mapa_resumo.str_aliquota[lvl_Row].aliquota)
		lvdc_Vl_Icm	    [lvl_Row_icms]      = lvs_mapa_resumo.str_aliquota[lvl_Row].valor
	End If
Next

lvl_filial             = gvo_parametro.cd_filial

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Sweda - Inclus$$HEX1$$e300$$ENDHEX$$o dos Dados(of_gravacao_mapa_resumo_sweda).")

Select mrecf.nr_ecf,
       mr.nr_mapa,
	    mr.de_especie,
	    mr.de_serie,
	    mrecf.qt_reducao_z
Into  :lvl_Ecf,
      :lvl_Mapa_Resumo,
	   :lvs_Especie,
	   :lvs_Serie,
	   :lvl_qt_reducao_existente
  From mapa_resumo_ecf mrecf,
       mapa_resumo mr
 Where mr.cd_filial    = mrecf.cd_filial   and
       mr.de_especie   = mrecf.de_especie  and
	    mr.de_serie     = mrecf.de_serie    and
	    mr.nr_mapa      = mrecf.nr_mapa     and
	    mr.dh_emissao   = :lvdh_Data_Fiscal and
	    mrecf.cd_filial = :lvl_filial       and
	    mrecf.nr_ecf    = :lvl_ecf
 Using Sqlca;
 
lvl_Ecf = lvs_mapa_resumo.ecf

Choose Case Sqlca.SqlCode		
	Case -1		
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")		
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")
		Return False	
	Case 0
		If lvl_qt_reducao_existente <> lvl_qt_reducao Then //Nova redu$$HEX2$$e700e300$$ENDHEX$$o z para o mesmo dia.
			Select max(de_serie) into :lvs_serie_nova
				From mapa_resumo
			Where cd_filial =  :lvl_filial
			and nr_mapa = :lvl_mapa_resumo
			Using Sqlca;
			//
			If Sqlca.Sqlcode = -1	Then
				Sqlca.Of_MsgDbError("Serie Mapa Resumo")
				Sqlca.Of_LogDbError(gvo_Aplicacao.ivi_Log,"Serie Mapa Resumo")
				Return False
			Else
				If IsNumber(lvs_serie_nova) Then
					lvs_serie = String(Long(lvs_serie_nova) + 1)
				Else
					lvs_Serie   = '2'				
				End if
			End If		
		
			//Incluir nova serie
			lvs_Especie = 'MR'
			lvs_Serie   = '2'
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If	
			
			Insert Into mapa_resumo_ecf
					( cd_filial,   
					  nr_mapa,   
					  de_especie,   
					  de_serie,   
					  nr_ecf,
					  nr_operacao_inicial,
					  nr_operacao_final,
					  vl_total_geral_inicial,
					  vl_total_geral_final,
					  vl_cancelamento,
					  vl_desconto,
					  vl_contabil,
					  vl_isenta,
					  vl_nao_incidencia,
					  vl_st,
					  qt_reducao_z,
					  qt_reinicio_z,
					  qt_cupom_cancelado,
					  dh_reducao,
					  vl_isento_iss,
					  vl_nao_incidencia_iss,
					  vl_st_iss,
					  vl_desconto_iss,
					  vl_acrescimo,
					  vl_acrescimo_iss,
					  vl_cancelamento_iss,
					  vl_operacao_nao_fiscal)
			Values ( :lvl_filial,
						:lvl_Mapa_Resumo,   
						:lvs_especie,
						:lvs_serie,   
						:lvl_ecf,
						:lvl_nr_operacao_inicial,
						:lvl_nr_operacao_atual,
						:lvdc_total_geral_inicial,
						:lvdc_total_geral_final,
						:lvdc_cancelamento,
						:lvdc_desconto,
						:lvdc_contabil,
						:lvdc_isento,
						:lvdc_nao_incidencia,
						:lvdc_st,
						:lvl_qt_reducao,
						:lvl_qt_reinicio,
						:lvl_qt_cupom_cancelado,
						:lvdh_Reducao,
						:lvdc_isento_iss,
						:lvdc_nao_incidencia_iss,
						:lvdc_st_iss,
						:lvdc_desconto_iss,
						:lvdc_acrescimo,
						:lvdc_acrescimo_iss,
						:lvdc_cancelamento_iss,
						:lvdc_operacao_nao_fiscal)
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
				Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
				Return False
			End If	
			
			If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
			
			lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
			
			Update mapa_resumo
			set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
			Where nr_mapa    = :lvl_Mapa_Resumo
			  and cd_filial  = :lvl_filial
			  and de_especie = :lvs_especie
			  and de_serie   = :lvs_serie
			Using Sqlca;
		
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
				Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
				Return False
			End If
			
			//Grava controle de historio de envio de arquivos blocoX
			If Trim(This.id_gera_blocoX) = 'S' And lvdh_Data_Fiscal >= This.dt_inicio_blocox Then
				If Not This.of_grava_blocox_pendente( lvl_filial, lvl_mapa_resumo, lvl_ecf) Then Return False
				
				Select nr_sequencial
				Into  :lvl_seq
				  From historico_envio_arquivo_paf
				 Where cd_filial    = :lvl_filial  and
						cd_tipo = 'RZ' and
						 nr_ecf = :lvl_ecf and
						nr_mapa_resumo  = :lvl_mapa_resumo and
						qt_reducao_z = :lvl_qt_reducao
				 Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
					Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
					Return False	
				End If
				
				If Isnull(lvl_seq) Or lvl_seq = 0 Then			
					If Not This.of_proximo_historico(Ref PDV.ivl_seq_historico)   Then Return False							
					
					Insert Into historico_envio_arquivo_paf
							( cd_filial,   
							  cd_tipo,
							  qt_reducao_z,
							  nr_ecf,				  
							  nr_mapa_resumo,
							  dh_movimento,
							  id_situacao,
							  id_enviado_matriz)
					Values ( :lvl_filial,
								'RZ',
								:lvl_qt_reducao,
								:lvl_ecf,					
								:lvl_Mapa_Resumo,
								:lvdh_Data_Fiscal,
								'P',
								'N')
					Using Sqlca;	
					
					If Sqlca.Sqlcode = -1 Then
						Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
						Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
						Return False
					End If						
				Else				
					PDV.ivl_seq_historico = lvl_seq
				End If
			End If						
		Else
			Update mapa_resumo_ecf
				Set nr_operacao_final      = :lvl_nr_operacao_atual,
					 vl_total_geral_final   = :lvdc_total_geral_final,
					 vl_cancelamento        = :lvdc_cancelamento,
					 vl_desconto		      = :lvdc_desconto,
					 vl_contabil            = :lvdc_contabil,
					 vl_isenta              = :lvdc_isento,
					 vl_nao_incidencia	   = :lvdc_nao_incidencia,
					 vl_st                  = :lvdc_st,
					 qt_reducao_z           = :lvl_qt_reducao,
					 qt_reinicio_z          = :lvl_qt_reinicio,
					 qt_cupom_cancelado     = :lvl_qt_cupom_cancelado,
	//				 dh_reducao				   = :lvdh_Reducao,
					 vl_isento_iss			   = :lvdc_isento_iss,	
					 vl_nao_incidencia_iss  = :lvdc_nao_incidencia_iss,
					 vl_st_iss				   = :lvdc_st_iss,
					 vl_desconto_iss        = :lvdc_desconto_iss,
					 vl_acrescimo           = :lvdc_acrescimo,
					 vl_acrescimo_iss       = :lvdc_acrescimo_iss,
					 vl_cancelamento_iss    = :lvdc_cancelamento_iss,
					 vl_operacao_nao_fiscal = :lvdc_operacao_nao_fiscal
			Where cd_filial  = :lvl_filial
			  and nr_mapa    = :lvl_Mapa_Resumo
			  and de_especie = :lvs_especie
			  and de_serie   = :lvs_serie
			  and nr_ecf     = :lvl_ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")			
				Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")
				Return False
			End If
			
			If Not of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		End If
		
	Case 100	
		lvs_Especie = 'MR'
		lvs_Serie   = '1'
		
		If Not Of_Proximo_Mapa_Resumo(Ref lvl_Mapa_Resumo,Ref lvb_Novo_Mapa, lvdh_Data_Fiscal) Then Return False
		
		lvl_nr_operacao_inicial  = Of_Ultimo_Sequencial(lvl_Ecf)
		
		//Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial
		If IsNull(lvl_nr_operacao_inicial) Then 
			Sqlca.Of_MsgDbError("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - opera$$HEX2$$e700e300$$ENDHEX$$o inicial")
			gvo_Aplicacao.of_Grava_Log( "uo_mapa_resumo - of_grava_mapa_resumo_sweda - opera$$HEX2$$e700e300$$ENDHEX$$o inicial com valor nulo" )				
			lvl_nr_operacao_inicial = lvl_nr_operacao_atual
		End If	
		
		//Se a ECF ainda est$$HEX1$$e100$$ENDHEX$$ com a mesmo COO do $$HEX1$$fa00$$ENDHEX$$ltimo mapa gravado significa que este mapa j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ gravado
		If lvl_nr_operacao_inicial = lvl_nr_operacao_atual Then
			gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Sweda - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o pois a operacao inicial $$HEX1$$e900$$ENDHEX$$ igual a final!(of_gravacao_mapa_resumo_sweda).")						
			Return True
		End If
		
		If lvl_nr_operacao_inicial <> 0 Then
			If lvl_nr_operacao_inicial + 1 <= lvl_nr_operacao_atual Then
				lvl_nr_operacao_inicial ++
			End If	
		End If	
		
		If lvb_Novo_Mapa Then
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If
		End If	
		
		Insert Into mapa_resumo_ecf
				( cd_filial,   
				  nr_mapa,   
				  de_especie,   
				  de_serie,   
				  nr_ecf,
				  nr_operacao_inicial,
				  nr_operacao_final,
				  vl_total_geral_inicial,
				  vl_total_geral_final,
				  vl_cancelamento,
				  vl_desconto,
				  vl_contabil,
				  vl_isenta,
				  vl_nao_incidencia,
				  vl_st,
				  qt_reducao_z,
				  qt_reinicio_z,
				  qt_cupom_cancelado,
				  dh_reducao,
				  vl_isento_iss,
				  vl_nao_incidencia_iss,
				  vl_st_iss,
				  vl_desconto_iss,
				  vl_acrescimo,
				  vl_acrescimo_iss,
				  vl_cancelamento_iss,
				  vl_operacao_nao_fiscal)
		Values ( :lvl_filial,
					:lvl_Mapa_Resumo,   
					:lvs_especie,
					:lvs_serie,   
					:lvl_ecf,
					:lvl_nr_operacao_inicial,
					:lvl_nr_operacao_atual,
					:lvdc_total_geral_inicial,
					:lvdc_total_geral_final,
					:lvdc_cancelamento,
					:lvdc_desconto,
					:lvdc_contabil,
					:lvdc_isento,
					:lvdc_nao_incidencia,
					:lvdc_st,
					:lvl_qt_reducao,
					:lvl_qt_reinicio,
					:lvl_qt_cupom_cancelado,
					:lvdh_Reducao,
					:lvdc_isento_iss,
					:lvdc_nao_incidencia_iss,
					:lvdc_st_iss,
					:lvdc_desconto_iss,
					:lvdc_acrescimo,
					:lvdc_acrescimo_iss,
					:lvdc_cancelamento_iss,
					:lvdc_operacao_nao_fiscal)
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
			Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
			Return False
		End If
		
		If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		
		lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
		
		Update mapa_resumo
		set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
		Where nr_mapa    = :lvl_Mapa_Resumo
		  and cd_filial  = :lvl_filial
		  and de_especie = :lvs_especie
		  and de_serie   = :lvs_serie
		Using Sqlca;
	
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
			Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
			Return False
		End If
		
		//Grava controle de historio de envio de arquivos blocoX
		If Trim(This.id_gera_blocoX) = 'S' And lvdh_Data_Fiscal >= This.dt_inicio_blocox Then
			If Not This.of_grava_blocox_pendente( lvl_filial, lvl_mapa_resumo, lvl_ecf) Then Return False
			
			Select nr_sequencial
			Into  :lvl_seq
			  From historico_envio_arquivo_paf
			 Where cd_filial    = :lvl_filial  and
			 		cd_tipo = 'RZ' and
					 nr_ecf = :lvl_ecf and
					nr_mapa_resumo  = :lvl_mapa_resumo and
					qt_reducao_z = :lvl_qt_reducao
			 Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
				Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
				Return False	
			End If
			
			If Isnull(lvl_seq) Or lvl_seq = 0 Then			
				If Not This.of_proximo_historico(Ref PDV.ivl_seq_historico)   Then Return False							
				
				Insert Into historico_envio_arquivo_paf
						( cd_filial,   
						  cd_tipo,
						  qt_reducao_z,
						  nr_ecf,				  
						  nr_mapa_resumo,
						  dh_movimento,
						  id_situacao,
						  id_enviado_matriz)
				Values ( :lvl_filial,
							'RZ',
							:lvl_qt_reducao,
							:lvl_ecf,					
							:lvl_Mapa_Resumo,
							:lvdh_Data_Fiscal,
							'P',
							'N')
				Using Sqlca;	
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
					Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
					Return False
				End If						
			Else				
				PDV.ivl_seq_historico = lvl_seq
			End If
		End If				
	
End Choose

gvo_aplicacao.of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Sweda - Termino da fun$$HEX1$$e700$$ENDHEX$$ao com sucesso!(of_gravacao_mapa_resumo_sweda).")

Return True
end function

public function boolean of_grava_mapa_resumo (date pdt_mapa);Boolean lvb_Sucesso

Choose Case PDV.Fabricante
	Case "Bematech"
		lvb_Sucesso = this.of_grava_mapa_resumo_bematech(pdt_mapa)
	Case "Itautec"
	Case Else
End Choose

Return lvb_Sucesso

end function

public function boolean of_grava_mapa_resumo_bematech (date pdt_mapa);

STRING      lvs_Especie, &
            lvs_Serie
		
DATE        lvdh_Data_Fiscal

DATETIME    lvdh_Movimentacao_Caixa,&
            lvdh_Reducao
                        
LONG 			lvl_ecf, &
     			lvl_filial, &
				lvl_Mapa_Resumo, &
				lvl_nr_operacao_atual, &				
				lvl_nr_operacao_inicial, &
				lvl_qt_reducao, &
				lvl_qt_reinicio, &
				lvl_qt_cupom_cancelado,&
				lvl_Aliq,&
				lvl_Row,&
				lvl_File,&
				lvl_Row_icms

DECIMAL {2} lvdc_total_geral_inicial, &
            lvdc_total_geral_final, &
				lvdc_cancelamento, &
				lvdc_desconto, &
				lvdc_contabil, &
				lvdc_isento, &
				lvdc_nao_incidencia, &
				lvdc_st,&
				lvdc_pc_aliquota,&
				lvdc_vl_base_calculo,&
				lvdc_Faixa_Icm[],&
				lvdc_Vl_Icm[],&
	         lvdc_vl_icms,&
				lvdc_isento_iss,&
				lvdc_nao_incidencia_iss,&
				lvdc_st_iss,&
				lvdc_desconto_iss,&
				lvdc_acrescimo,&
				lvdc_acrescimo_iss,&
				lvdc_cancelamento_iss,&
				lvdc_operacao_nao_fiscal

BOOLEAN     lvb_Novo_Mapa = False

s_ge039_mapa_resumo lvs_mapa_resumo

SetPointer(HourGlass!)

If Not PDV.of_Verifica_Cupons_Pendentes()        Then Return False

If Not PDV.of_Mapa_Resumo(Ref lvs_mapa_resumo)   Then Return False

lvdh_Reducao = gf_GetServerDate()

//Data $$HEX1$$e900$$ENDHEX$$ armazenada antes de executar a Redu$$HEX2$$e700e300$$ENDHEX$$o Z, ap$$HEX1$$f300$$ENDHEX$$s a Redu$$HEX2$$e700e300$$ENDHEX$$o Z n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ como saber.
lvdh_Data_Fiscal       = This.dh_fiscal

lvl_Ecf                = lvs_mapa_resumo.ecf
lvl_nr_operacao_atual  = lvs_mapa_resumo.operacao

lvdc_total_geral_final = lvs_mapa_resumo.grande_total
lvdc_cancelamento      = lvs_mapa_resumo.cancelamentos
lvdc_desconto          = lvs_mapa_resumo.descontos
lvdc_contabil          = lvs_mapa_resumo.liquido

lvl_qt_reducao         = lvs_mapa_resumo.reducoes
lvl_qt_reinicio        = lvs_mapa_resumo.qt_reinicio_z
lvl_qt_cupom_cancelado = lvs_mapa_resumo.qt_cupom_cancelado

lvdc_Isento            = lvs_mapa_resumo.isento
lvdc_nao_incidencia    = lvs_mapa_resumo.vl_nao_incidencia
lvdc_st                = lvs_mapa_resumo.vlst

lvdc_isento_iss			 = lvs_mapa_resumo.vl_isento_iss
lvdc_nao_incidencia_iss  = lvs_mapa_resumo.vl_nao_incidencia_iss
lvdc_st_iss					 = lvs_mapa_resumo.vl_st_iss
lvdc_desconto_iss			 = lvs_mapa_resumo.vl_desconto_iss
lvdc_acrescimo				 = lvs_mapa_resumo.vl_acrescimo
lvdc_acrescimo_iss		 =	lvs_mapa_resumo.vl_acrescimo_iss
lvdc_cancelamento_iss	 = lvs_mapa_resumo.vl_cancelamento_iss
lvdc_operacao_nao_fiscal = lvs_mapa_resumo.vl_operacao_nao_fiscal

lvdc_total_geral_inicial = lvdc_total_geral_final - ( lvdc_desconto + lvdc_cancelamento + lvdc_contabil )

If lvl_ecf = 0 Then Return True

For lvl_Row = 1 To UpperBound(lvs_mapa_resumo.str_aliquota)
	If lvs_mapa_resumo.str_aliquota[lvl_Row].valor > 0 Then
		lvl_Row_icms += 1
		lvdc_Faixa_Icm[lvl_Row_icms]      = Dec(lvs_mapa_resumo.str_aliquota[lvl_Row].aliquota)
		lvdc_Vl_Icm	    [lvl_Row_icms]      = lvs_mapa_resumo.str_aliquota[lvl_Row].valor
	End If
Next

//lvdc_Faixa_Icm[1]      = 7.00
//lvdc_Vl_Icm	  [1]      = lvs_mapa_resumo.icm07
//
//lvdc_Faixa_Icm[2]      = 12.00
//lvdc_Vl_Icm	  [2]      = lvs_mapa_resumo.icm12
//
//lvdc_Faixa_Icm[3]      = 25.00
//lvdc_Vl_Icm	  [3]      = lvs_mapa_resumo.icm25
//
//lvdc_Faixa_Icm[4]      = 17.00
//lvdc_Vl_Icm	  [4]      = lvs_mapa_resumo.icm17
//
//lvdc_Faixa_Icm[5]      = 18.00
//lvdc_Vl_Icm	  [5]      = lvs_mapa_resumo.icm18

lvl_filial             = gvo_parametro.cd_filial

Select mrecf.nr_ecf,
       mr.nr_mapa,
	    mr.de_especie,
	    mr.de_serie
Into  :lvl_Ecf,
      :lvl_Mapa_Resumo,
	   :lvs_Especie,
	   :lvs_Serie
  From mapa_resumo_ecf mrecf,
       mapa_resumo mr
 Where mr.cd_filial    = mrecf.cd_filial   and
       mr.de_especie   = mrecf.de_especie  and
	    mr.de_serie     = mrecf.de_serie    and
	    mr.nr_mapa      = mrecf.nr_mapa     and
	    mr.dh_emissao   = :lvdh_Data_Fiscal and
	    mrecf.cd_filial = :lvl_filial       and
	    mrecf.nr_ecf    = :lvl_ecf
 Using Sqlca;

Choose Case Sqlca.SqlCode		
	Case -1
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")		
		Sqlca.of_MsgDBError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")		
		Return False	
	Case 0
		
		Update mapa_resumo_ecf
			Set nr_operacao_final      = :lvl_nr_operacao_atual,
				 vl_total_geral_final   = :lvdc_total_geral_final,
				 vl_cancelamento        = :lvdc_cancelamento,
				 vl_desconto		      = :lvdc_desconto,
				 vl_contabil            = :lvdc_contabil,
				 vl_isenta              = :lvdc_isento,
				 vl_nao_incidencia	   = :lvdc_nao_incidencia,
				 vl_st                  = :lvdc_st,
				 qt_reducao_z           = :lvl_qt_reducao,
				 qt_reinicio_z          = :lvl_qt_reinicio,
				 qt_cupom_cancelado     = :lvl_qt_cupom_cancelado,
				 dh_reducao				   = :lvdh_Reducao,
				 vl_isento_iss			   = :lvdc_isento_iss,	
				 vl_nao_incidencia_iss  = :lvdc_nao_incidencia_iss,
				 vl_st_iss				   = :lvdc_st_iss,
				 vl_desconto_iss        = :lvdc_desconto_iss,
				 vl_acrescimo           = :lvdc_acrescimo,
				 vl_acrescimo_iss       = :lvdc_acrescimo_iss,
				 vl_cancelamento_iss    = :lvdc_cancelamento_iss,
				 vl_operacao_nao_fiscal = :lvdc_operacao_nao_fiscal
		Where cd_filial  = :lvl_filial
		  and nr_mapa    = :lvl_Mapa_Resumo
		  and de_especie = :lvs_especie
		  and de_serie   = :lvs_serie
		  and nr_ecf     = :lvl_ecf
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")			
			Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")		
			Return False
		End If
		
		If Not of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
	
	Case 100
	
		lvs_Especie = 'MR'
		lvs_Serie   = '1'
		
		If Not Of_Proximo_Mapa_Resumo(Ref lvl_Mapa_Resumo,Ref lvb_Novo_Mapa, lvdh_Data_Fiscal) Then Return False
		
		lvl_nr_operacao_inicial  = Of_Ultimo_Sequencial(lvl_Ecf)
		
		//Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial
		If IsNull(lvl_nr_operacao_inicial) Then 
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - opera$$HEX2$$e700e300$$ENDHEX$$o inicial")			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo. ~n~n Erro: " + Sqlca.SqlErrText)
			lvl_nr_operacao_inicial = lvl_nr_operacao_atual
		End If	
		
		//Se a ECF ainda est$$HEX1$$e100$$ENDHEX$$ com a mesmo COO do $$HEX1$$fa00$$ENDHEX$$ltimo mapa gravado significa que este mapa j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ gravado
		If lvl_nr_operacao_inicial = lvl_nr_operacao_atual Then Return True
		
		If lvl_nr_operacao_inicial <> 0 Then
			If lvl_nr_operacao_inicial + 1 <= lvl_nr_operacao_atual Then
				lvl_nr_operacao_inicial ++
			End If	
		End If	
		
		If lvb_Novo_Mapa Then
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If
			
		End If	
		
		Insert Into mapa_resumo_ecf
				( cd_filial,   
				  nr_mapa,   
				  de_especie,   
				  de_serie,   
				  nr_ecf,
				  nr_operacao_inicial,
				  nr_operacao_final,
				  vl_total_geral_inicial,
				  vl_total_geral_final,
				  vl_cancelamento,
				  vl_desconto,
				  vl_contabil,
				  vl_isenta,
				  vl_nao_incidencia,
				  vl_st,
				  qt_reducao_z,
				  qt_reinicio_z,
				  qt_cupom_cancelado,
				  dh_reducao,
				  vl_isento_iss,
				  vl_nao_incidencia_iss,
				  vl_st_iss,
				  vl_desconto_iss,
				  vl_acrescimo,
				  vl_acrescimo_iss,
				  vl_cancelamento_iss,
				  vl_operacao_nao_fiscal)
		Values ( :lvl_filial,
					:lvl_Mapa_Resumo,   
					:lvs_especie,
					:lvs_serie,   
					:lvl_ecf,
					:lvl_nr_operacao_inicial,
					:lvl_nr_operacao_atual,
					:lvdc_total_geral_inicial,
					:lvdc_total_geral_final,
					:lvdc_cancelamento,
					:lvdc_desconto,
					:lvdc_contabil,
					:lvdc_isento,
					:lvdc_nao_incidencia,
					:lvdc_st,
					:lvl_qt_reducao,
					:lvl_qt_reinicio,
					:lvl_qt_cupom_cancelado,
					:lvdh_Reducao,
					:lvdc_isento_iss,
					:lvdc_nao_incidencia_iss,
					:lvdc_st_iss,
					:lvdc_desconto_iss,
					:lvdc_acrescimo,
					:lvdc_acrescimo_iss,
					:lvdc_cancelamento_iss,
					:lvdc_operacao_nao_fiscal)
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
			Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")					
			Return False
		End If
		
		If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		
		lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
		
		Update mapa_resumo
		set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
		Where nr_mapa    = :lvl_Mapa_Resumo
		  and cd_filial  = :lvl_filial
		  and de_especie = :lvs_especie
		  and de_serie   = :lvs_serie
		Using Sqlca;
	
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
			Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
			Return False
		End If
	
End Choose

Return True
end function

public function boolean of_grava_mapa_resumo_daruma ();STRING      lvs_Especie, &
            lvs_Serie,&
		   lvs_serie_nova
		
DATE        lvdh_Data_Fiscal

DATETIME    lvdh_Movimentacao_Caixa,&
            lvdh_Reducao
                        
LONG 			lvl_ecf, &
     			lvl_filial, &
				lvl_Mapa_Resumo, &
				lvl_nr_operacao_atual, &				
				lvl_nr_operacao_inicial, &
				lvl_qt_reducao, &
				lvl_qt_reinicio, &
				lvl_qt_cupom_cancelado,&
				lvl_Aliq,&
				lvl_Row,&
				lvl_File,&
				lvl_Row_icms,&
				lvl_seq,&
				lvl_qt_reducao_existente
				

DECIMAL {2} lvdc_total_geral_inicial, &
            lvdc_total_geral_final, &
				lvdc_cancelamento, &
				lvdc_desconto, &
				lvdc_contabil, &
				lvdc_isento, &
				lvdc_nao_incidencia, &
				lvdc_st,&
				lvdc_pc_aliquota,&
				lvdc_vl_base_calculo,&
				lvdc_Faixa_Icm[],&
				lvdc_Vl_Icm[],&
	         lvdc_vl_icms,&
				lvdc_isento_iss,&
				lvdc_nao_incidencia_iss,&
				lvdc_st_iss,&
				lvdc_desconto_iss,&
				lvdc_acrescimo,&
				lvdc_acrescimo_iss,&
				lvdc_cancelamento_iss,&
				lvdc_operacao_nao_fiscal

BOOLEAN     lvb_Novo_Mapa = False

s_ge039_mapa_resumo lvs_mapa_resumo

SetPointer(HourGlass!)

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Inicio Fun$$HEX2$$e700e300$$ENDHEX$$o da Daruma(of_gravacao_mapa_resumo_daruma).")

If Not PDV.of_Verifica_Cupons_Pendentes()        Then Return False

If Not PDV.of_Mapa_Resumo(Ref lvs_mapa_resumo)   Then Return False

lvdh_Reducao = gf_GetServerDate()

//Data $$HEX1$$e900$$ENDHEX$$ armazenada antes de executar a Redu$$HEX2$$e700e300$$ENDHEX$$o Z, ap$$HEX1$$f300$$ENDHEX$$s a Redu$$HEX2$$e700e300$$ENDHEX$$o Z n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ como saber.
lvdh_Data_Fiscal       = This.dh_fiscal

lvl_Ecf                = lvs_mapa_resumo.ecf
lvl_nr_operacao_atual  = lvs_mapa_resumo.operacao

lvdc_total_geral_final = lvs_mapa_resumo.grande_total
lvdc_cancelamento      = lvs_mapa_resumo.cancelamentos
lvdc_desconto          = lvs_mapa_resumo.descontos
lvdc_contabil          = lvs_mapa_resumo.liquido

lvl_qt_reducao         = lvs_mapa_resumo.reducoes
lvl_qt_reinicio        = lvs_mapa_resumo.qt_reinicio_z
lvl_qt_cupom_cancelado = lvs_mapa_resumo.qt_cupom_cancelado

lvdc_Isento            = lvs_mapa_resumo.isento
lvdc_nao_incidencia    = lvs_mapa_resumo.vl_nao_incidencia
lvdc_st                = lvs_mapa_resumo.vlst

lvdc_isento_iss			 = lvs_mapa_resumo.vl_isento_iss
lvdc_nao_incidencia_iss  = lvs_mapa_resumo.vl_nao_incidencia_iss
lvdc_st_iss					 = lvs_mapa_resumo.vl_st_iss
lvdc_desconto_iss			 = lvs_mapa_resumo.vl_desconto_iss
lvdc_acrescimo				 = lvs_mapa_resumo.vl_acrescimo
lvdc_acrescimo_iss		 =	lvs_mapa_resumo.vl_acrescimo_iss
lvdc_cancelamento_iss	 = lvs_mapa_resumo.vl_cancelamento_iss
lvdc_operacao_nao_fiscal = lvs_mapa_resumo.vl_operacao_nao_fiscal

lvdc_total_geral_inicial = lvdc_total_geral_final - ( lvdc_desconto + lvdc_cancelamento + lvdc_contabil )

If lvl_ecf = 0 Then
	gvo_Aplicacao.of_Grava_Log( "uo_mapa_resumo - of_grava_mapa_resumo_daruma - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o por numero ecf igual a 0(zero)." )		
	Return True
End If

For lvl_Row = 1 To UpperBound(lvs_mapa_resumo.str_aliquota)
	If lvs_mapa_resumo.str_aliquota[lvl_Row].valor > 0 Then
		lvl_Row_icms += 1
		lvdc_Faixa_Icm[lvl_Row_icms]      = Dec(lvs_mapa_resumo.str_aliquota[lvl_Row].aliquota)
		lvdc_Vl_Icm	    [lvl_Row_icms]      = lvs_mapa_resumo.str_aliquota[lvl_Row].valor
	End If
Next

lvl_filial             = gvo_parametro.cd_filial

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Daruma - Inclus$$HEX1$$e300$$ENDHEX$$o dos Dados(of_gravacao_mapa_resumo_daruma).")

Select mrecf.nr_ecf,
       mr.nr_mapa,
	    mr.de_especie,
	    mr.de_serie,
		mrecf.qt_reducao_z
Into  :lvl_Ecf,
      :lvl_Mapa_Resumo,
	   :lvs_Especie,
	   :lvs_Serie,
	   :lvl_qt_reducao_existente
  From mapa_resumo_ecf mrecf,
       mapa_resumo mr
 Where mr.cd_filial    = mrecf.cd_filial   and
       mr.de_especie   = mrecf.de_especie  and
	    mr.de_serie     = mrecf.de_serie    and
	    mr.nr_mapa      = mrecf.nr_mapa     and
	    mr.dh_emissao   = :lvdh_Data_Fiscal and
	    mrecf.cd_filial = :lvl_filial       and
	    mrecf.nr_ecf    = :lvl_ecf
 Using Sqlca;
 
lvl_Ecf = lvs_mapa_resumo.ecf

Choose Case Sqlca.SqlCode		
	Case -1		
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")		
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")
		Return False	
	Case 0
		If lvl_qt_reducao_existente <> lvl_qt_reducao Then //Nova redu$$HEX2$$e700e300$$ENDHEX$$o z para o mesmo dia.
			Select max(de_serie) into :lvs_serie_nova
				From mapa_resumo
			Where cd_filial =  :lvl_filial
			and nr_mapa = :lvl_mapa_resumo
			Using Sqlca;
			//
			If Sqlca.Sqlcode = -1	Then
				Sqlca.Of_MsgDbError("Serie Mapa Resumo")
				Sqlca.Of_LogDbError(gvo_Aplicacao.ivi_Log,"Serie Mapa Resumo")
				Return False
			Else
				If IsNumber(lvs_serie_nova) Then
					lvs_serie = String(Long(lvs_serie_nova) + 1)
				Else
					lvs_Serie   = '2'				
				End if
			End If		
		
			//Incluir nova serie
			lvs_Especie = 'MR'
			lvs_Serie   = '2'
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If	
			
			Insert Into mapa_resumo_ecf
					( cd_filial,   
					  nr_mapa,   
					  de_especie,   
					  de_serie,   
					  nr_ecf,
					  nr_operacao_inicial,
					  nr_operacao_final,
					  vl_total_geral_inicial,
					  vl_total_geral_final,
					  vl_cancelamento,
					  vl_desconto,
					  vl_contabil,
					  vl_isenta,
					  vl_nao_incidencia,
					  vl_st,
					  qt_reducao_z,
					  qt_reinicio_z,
					  qt_cupom_cancelado,
					  dh_reducao,
					  vl_isento_iss,
					  vl_nao_incidencia_iss,
					  vl_st_iss,
					  vl_desconto_iss,
					  vl_acrescimo,
					  vl_acrescimo_iss,
					  vl_cancelamento_iss,
					  vl_operacao_nao_fiscal)
			Values ( :lvl_filial,
						:lvl_Mapa_Resumo,   
						:lvs_especie,
						:lvs_serie,   
						:lvl_ecf,
						:lvl_nr_operacao_inicial,
						:lvl_nr_operacao_atual,
						:lvdc_total_geral_inicial,
						:lvdc_total_geral_final,
						:lvdc_cancelamento,
						:lvdc_desconto,
						:lvdc_contabil,
						:lvdc_isento,
						:lvdc_nao_incidencia,
						:lvdc_st,
						:lvl_qt_reducao,
						:lvl_qt_reinicio,
						:lvl_qt_cupom_cancelado,
						:lvdh_Reducao,
						:lvdc_isento_iss,
						:lvdc_nao_incidencia_iss,
						:lvdc_st_iss,
						:lvdc_desconto_iss,
						:lvdc_acrescimo,
						:lvdc_acrescimo_iss,
						:lvdc_cancelamento_iss,
						:lvdc_operacao_nao_fiscal)
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
				Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
				Return False
			End If	
			
			If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
			
			lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
			
			Update mapa_resumo
			set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
			Where nr_mapa    = :lvl_Mapa_Resumo
			  and cd_filial  = :lvl_filial
			  and de_especie = :lvs_especie
			  and de_serie   = :lvs_serie
			Using Sqlca;
		
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
				Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
				Return False
			End If
			
			//Grava controle de historio de envio de arquivos blocoX
			If Trim(This.id_gera_blocoX) = 'S' And lvdh_Data_Fiscal >= This.dt_inicio_blocox Then
				If Not This.of_grava_blocox_pendente( lvl_filial, lvl_mapa_resumo, lvl_ecf) Then Return False
				
				Select nr_sequencial
				Into  :lvl_seq
				  From historico_envio_arquivo_paf
				 Where cd_filial    = :lvl_filial  and
						cd_tipo = 'RZ' and
						 nr_ecf = :lvl_ecf and
						nr_mapa_resumo  = :lvl_mapa_resumo and
						qt_reducao_z = :lvl_qt_reducao
				 Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
					Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
					Return False	
				End If
				
				If Isnull(lvl_seq) Or lvl_seq = 0 Then			
					If Not This.of_proximo_historico(Ref PDV.ivl_seq_historico)   Then Return False							
					
					Insert Into historico_envio_arquivo_paf
							( cd_filial,   
							  cd_tipo,
							  qt_reducao_z,
							  nr_ecf,				  
							  nr_mapa_resumo,
							  dh_movimento,
							  id_situacao,
							  id_enviado_matriz)
					Values ( :lvl_filial,
								'RZ',
								:lvl_qt_reducao,
								:lvl_ecf,					
								:lvl_Mapa_Resumo,
								:lvdh_Data_Fiscal,
								'P',
								'N')
					Using Sqlca;	
					
					If Sqlca.Sqlcode = -1 Then
						Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
						Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
						Return False
					End If						
				Else				
					PDV.ivl_seq_historico = lvl_seq
				End If
			End If						
		Else		
			Update mapa_resumo_ecf
				Set nr_operacao_final      = :lvl_nr_operacao_atual,
					 vl_total_geral_final   = :lvdc_total_geral_final,
					 vl_cancelamento        = :lvdc_cancelamento,
					 vl_desconto		      = :lvdc_desconto,
					 vl_contabil            = :lvdc_contabil,
					 vl_isenta              = :lvdc_isento,
					 vl_nao_incidencia	   = :lvdc_nao_incidencia,
					 vl_st                  = :lvdc_st,
					 qt_reducao_z           = :lvl_qt_reducao,
					 qt_reinicio_z          = :lvl_qt_reinicio,
					 qt_cupom_cancelado     = :lvl_qt_cupom_cancelado,
	//				 dh_reducao				   = :lvdh_Reducao,
					 vl_isento_iss			   = :lvdc_isento_iss,	
					 vl_nao_incidencia_iss  = :lvdc_nao_incidencia_iss,
					 vl_st_iss				   = :lvdc_st_iss,
					 vl_desconto_iss        = :lvdc_desconto_iss,
					 vl_acrescimo           = :lvdc_acrescimo,
					 vl_acrescimo_iss       = :lvdc_acrescimo_iss,
					 vl_cancelamento_iss    = :lvdc_cancelamento_iss,
					 vl_operacao_nao_fiscal = :lvdc_operacao_nao_fiscal
			Where cd_filial  = :lvl_filial
			  and nr_mapa    = :lvl_Mapa_Resumo
			  and de_especie = :lvs_especie
			  and de_serie   = :lvs_serie
			  and nr_ecf     = :lvl_ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")			
				Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")
				Return False
			End If
			
			If Not of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		End If
		
	Case 100	
		lvs_Especie = 'MR'
		lvs_Serie   = '1'
		
		If Not Of_Proximo_Mapa_Resumo(Ref lvl_Mapa_Resumo,Ref lvb_Novo_Mapa, lvdh_Data_Fiscal) Then Return False
		
		lvl_nr_operacao_inicial  = Of_Ultimo_Sequencial(lvl_Ecf)
		
		//Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial
		If IsNull(lvl_nr_operacao_inicial) Then 
			Sqlca.Of_MsgDbError("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - opera$$HEX2$$e700e300$$ENDHEX$$o inicial")
			gvo_Aplicacao.of_Grava_Log( "uo_mapa_resumo - of_grava_mapa_resumo_daruma - opera$$HEX2$$e700e300$$ENDHEX$$o inicial com valor nulo" )				
			lvl_nr_operacao_inicial = lvl_nr_operacao_atual
		End If	
		
		//Se a ECF ainda est$$HEX1$$e100$$ENDHEX$$ com a mesmo COO do $$HEX1$$fa00$$ENDHEX$$ltimo mapa gravado significa que este mapa j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ gravado
		If lvl_nr_operacao_inicial = lvl_nr_operacao_atual Then
			gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Daruma - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o pois a operacao inicial $$HEX1$$e900$$ENDHEX$$ igual a final!(of_gravacao_mapa_resumo_daruma).")			
			Return True
		End If
		
		If lvl_nr_operacao_inicial <> 0 Then
			If lvl_nr_operacao_inicial + 1 <= lvl_nr_operacao_atual Then
				lvl_nr_operacao_inicial ++
			End If	
		End If	
		
		If lvb_Novo_Mapa Then
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If
		End If	
		
		Insert Into mapa_resumo_ecf
				( cd_filial,   
				  nr_mapa,   
				  de_especie,   
				  de_serie,   
				  nr_ecf,
				  nr_operacao_inicial,
				  nr_operacao_final,
				  vl_total_geral_inicial,
				  vl_total_geral_final,
				  vl_cancelamento,
				  vl_desconto,
				  vl_contabil,
				  vl_isenta,
				  vl_nao_incidencia,
				  vl_st,
				  qt_reducao_z,
				  qt_reinicio_z,
				  qt_cupom_cancelado,
				  dh_reducao,
				  vl_isento_iss,
				  vl_nao_incidencia_iss,
				  vl_st_iss,
				  vl_desconto_iss,
				  vl_acrescimo,
				  vl_acrescimo_iss,
				  vl_cancelamento_iss,
				  vl_operacao_nao_fiscal)
		Values ( :lvl_filial,
					:lvl_Mapa_Resumo,   
					:lvs_especie,
					:lvs_serie,   
					:lvl_ecf,
					:lvl_nr_operacao_inicial,
					:lvl_nr_operacao_atual,
					:lvdc_total_geral_inicial,
					:lvdc_total_geral_final,
					:lvdc_cancelamento,
					:lvdc_desconto,
					:lvdc_contabil,
					:lvdc_isento,
					:lvdc_nao_incidencia,
					:lvdc_st,
					:lvl_qt_reducao,
					:lvl_qt_reinicio,
					:lvl_qt_cupom_cancelado,
					:lvdh_Reducao,
					:lvdc_isento_iss,
					:lvdc_nao_incidencia_iss,
					:lvdc_st_iss,
					:lvdc_desconto_iss,
					:lvdc_acrescimo,
					:lvdc_acrescimo_iss,
					:lvdc_cancelamento_iss,
					:lvdc_operacao_nao_fiscal)
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
			Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
			Return False
		End If
		
		If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		
		lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
		
		Update mapa_resumo
		set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
		Where nr_mapa    = :lvl_Mapa_Resumo
		  and cd_filial  = :lvl_filial
		  and de_especie = :lvs_especie
		  and de_serie   = :lvs_serie
		Using Sqlca;
	
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
			Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
			Return False
		End If
		
		//Grava controle de historio de envio de arquivos blocoX
		If Trim(This.id_gera_blocoX) = 'S' And lvdh_Data_Fiscal >= This.dt_inicio_blocox Then
			If Not This.of_grava_blocox_pendente( lvl_filial, lvl_mapa_resumo, lvl_ecf) Then Return False
			
			Select nr_sequencial
			Into  :lvl_seq
			  From historico_envio_arquivo_paf
			 Where cd_filial    = :lvl_filial  and
			 		cd_tipo = 'RZ' and
					 nr_ecf = :lvl_ecf and
					nr_mapa_resumo  = :lvl_mapa_resumo and
					qt_reducao_z = :lvl_qt_reducao
			 Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
				Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
				Return False	
			End If
			
			If Isnull(lvl_seq) Or lvl_seq = 0 Then			
				If Not This.of_proximo_historico(Ref PDV.ivl_seq_historico)   Then Return False							
				
				Insert Into historico_envio_arquivo_paf
						( cd_filial,   
						  cd_tipo,
						  qt_reducao_z,
						  nr_ecf,				  
						  nr_mapa_resumo,
						  dh_movimento,
						  id_situacao,
						  id_enviado_matriz)
				Values ( :lvl_filial,
							'RZ',
							:lvl_qt_reducao,
							:lvl_ecf,					
							:lvl_Mapa_Resumo,
							:lvdh_Data_Fiscal,
							'P',
							'N')
				Using Sqlca;	
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
					Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
					Return False
				End If						
			Else				
				PDV.ivl_seq_historico = lvl_seq
			End If
		End If				
	
End Choose

gvo_aplicacao.Of_grava_log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Daruma - Termino da fun$$HEX1$$e700$$ENDHEX$$ao com sucesso!(of_gravacao_mapa_resumo_daruma).")

Return True
end function

public function boolean of_insere_mapa_resumo (long pl_filial, long pl_mapa, string ps_especie, string ps_serie, date pdt_data_fiscal);Insert Into mapa_resumo
			 (cd_filial,
			  nr_mapa,
			  de_especie,
			  de_serie,
			  dh_emissao,
			  dh_movimentacao_caixa)
	Select  :pl_filial,
			  :pl_Mapa,
			  :ps_especie,
			  :ps_serie,
			  :pdt_Data_Fiscal,
			  p.dh_movimentacao
	From parametro p
  Where p.id_parametro = '1'
	Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo.")
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo.")
	Return False
End If

Return True
end function

public function boolean of_grava_mapa_resumo_epson ();

STRING      lvs_Especie, &
            lvs_Serie,&
		   lvs_serie_nova
		
DATE        lvdh_Data_Fiscal

DATETIME    lvdh_Movimentacao_Caixa,&
            lvdh_Reducao
                        
LONG 			lvl_ecf, &
     			lvl_filial, &
				lvl_Mapa_Resumo, &
				lvl_nr_operacao_atual, &				
				lvl_nr_operacao_inicial, &
				lvl_qt_reducao, &
				lvl_qt_reinicio, &
				lvl_qt_cupom_cancelado,&
				lvl_Aliq,&
				lvl_Row,&
				lvl_File,&
				lvl_Row_icms,&
				lvl_seq,&
				lvl_qt_reducao_existente

DECIMAL {2} lvdc_total_geral_inicial, &
            lvdc_total_geral_final, &
				lvdc_cancelamento, &
				lvdc_desconto, &
				lvdc_contabil, &
				lvdc_isento, &
				lvdc_nao_incidencia, &
				lvdc_st,&
				lvdc_pc_aliquota,&
				lvdc_vl_base_calculo,&
				lvdc_Faixa_Icm[],&
				lvdc_Vl_Icm[],&
	         lvdc_vl_icms,&
				lvdc_isento_iss,&
				lvdc_nao_incidencia_iss,&
				lvdc_st_iss,&
				lvdc_desconto_iss,&
				lvdc_acrescimo,&
				lvdc_acrescimo_iss,&
				lvdc_cancelamento_iss,&
				lvdc_operacao_nao_fiscal

BOOLEAN     lvb_Novo_Mapa = False

s_ge039_mapa_resumo lvs_mapa_resumo

SetPointer(HourGlass!)

gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Inicio Fun$$HEX2$$e700e300$$ENDHEX$$o da Epson of_gravacao_mapa_resumo_epson().")

If Not PDV.of_Verifica_Cupons_Pendentes()        Then Return False

If Not PDV.of_Mapa_Resumo(Ref lvs_mapa_resumo)   Then Return False

lvdh_Reducao = gf_GetServerDate()

//Data $$HEX1$$e900$$ENDHEX$$ armazenada antes de executar a Redu$$HEX2$$e700e300$$ENDHEX$$o Z, ap$$HEX1$$f300$$ENDHEX$$s a Redu$$HEX2$$e700e300$$ENDHEX$$o Z n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ como saber.
lvdh_Data_Fiscal	= This.dh_fiscal

lvl_Ecf					= lvs_mapa_resumo.ecf
lvl_nr_operacao_atual= lvs_mapa_resumo.operacao

lvdc_total_geral_final	= lvs_mapa_resumo.grande_total
lvdc_cancelamento	= lvs_mapa_resumo.cancelamentos
lvdc_desconto			= lvs_mapa_resumo.descontos
lvdc_contabil			= lvs_mapa_resumo.liquido

lvl_qt_reducao				= lvs_mapa_resumo.reducoes
lvl_qt_reinicio				= lvs_mapa_resumo.qt_reinicio_z
lvl_qt_cupom_cancelado	= lvs_mapa_resumo.qt_cupom_cancelado

lvdc_Isento				= lvs_mapa_resumo.isento
lvdc_nao_incidencia	= lvs_mapa_resumo.vl_nao_incidencia
lvdc_st                		= lvs_mapa_resumo.vlst

lvdc_isento_iss				= lvs_mapa_resumo.vl_isento_iss
lvdc_nao_incidencia_iss	= lvs_mapa_resumo.vl_nao_incidencia_iss
lvdc_st_iss					= lvs_mapa_resumo.vl_st_iss
lvdc_desconto_iss			= lvs_mapa_resumo.vl_desconto_iss
lvdc_acrescimo				= lvs_mapa_resumo.vl_acrescimo
lvdc_acrescimo_iss		= lvs_mapa_resumo.vl_acrescimo_iss
lvdc_cancelamento_iss	= lvs_mapa_resumo.vl_cancelamento_iss
lvdc_operacao_nao_fiscal= lvs_mapa_resumo.vl_operacao_nao_fiscal

lvdc_total_geral_inicial = lvdc_total_geral_final - ( lvdc_desconto + lvdc_cancelamento + lvdc_contabil )

If lvl_ecf = 0 Then
	gvo_Aplicacao.of_Grava_Log( "uo_mapa_resumo - of_grava_mapa_resumo_epson - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o por numero ecf igual a 0(zero)." )			
	Return True
End If

For lvl_Row = 1 To UpperBound(lvs_mapa_resumo.str_aliquota)
	If lvs_mapa_resumo.str_aliquota[lvl_Row].valor > 0 Then
		lvl_Row_icms += 1
		lvdc_Faixa_Icm[lvl_Row_icms]	= Dec(lvs_mapa_resumo.str_aliquota[lvl_Row].aliquota)
		lvdc_Vl_Icm	    [lvl_Row_icms]	= lvs_mapa_resumo.str_aliquota[lvl_Row].valor
	End If
Next

lvl_filial             = gvo_parametro.cd_filial

Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Epson - Inclus$$HEX1$$e300$$ENDHEX$$o dos Dados(of_gravacao_mapa_resumo_epson).")

Select mrecf.nr_ecf,
		mr.nr_mapa,
		mr.de_especie,
		mr.de_serie,
		mrecf.qt_reducao_z
Into	:lvl_Ecf,
		:lvl_Mapa_Resumo,
		:lvs_Especie,
		:lvs_Serie,
		:lvl_qt_reducao_existente
  From mapa_resumo_ecf mrecf,
       mapa_resumo mr
 Where mr.cd_filial	= mrecf.cd_filial		and
		mr.de_especie	= mrecf.de_especie	and
	    mr.de_serie		= mrecf.de_serie		and
	    mr.nr_mapa		= mrecf.nr_mapa		and
	    mr.dh_emissao	= :lvdh_Data_Fiscal	and
	    mrecf.cd_filial	= :lvl_filial       			and
	    mrecf.nr_ecf		= :lvl_ecf
 Using Sqlca;

Choose Case Sqlca.SqlCode		
	Case -1		
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo")		
		Return False	
	Case 0
		If lvl_qt_reducao_existente <> lvl_qt_reducao Then //Nova redu$$HEX2$$e700e300$$ENDHEX$$o z para o mesmo dia.
			Select max(de_serie) into :lvs_serie_nova
				From mapa_resumo
			Where cd_filial =  :lvl_filial
			and nr_mapa = :lvl_mapa_resumo
			Using Sqlca;
			//
			If Sqlca.Sqlcode = -1	Then
				Sqlca.Of_MsgDbError("Serie Mapa Resumo")
				Sqlca.Of_LogDbError(gvo_Aplicacao.ivi_Log,"Serie Mapa Resumo")
				Return False
			Else
				If IsNumber(lvs_serie_nova) Then
					lvs_serie = String(Long(lvs_serie_nova) + 1)
				Else
					lvs_Serie   = '2'				
				End if
			End If		
		
			//Incluir nova serie
			lvs_Especie = 'MR'
			lvs_Serie   = '2'
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If	
			
			Insert Into mapa_resumo_ecf
					( cd_filial,   
					  nr_mapa,   
					  de_especie,   
					  de_serie,   
					  nr_ecf,
					  nr_operacao_inicial,
					  nr_operacao_final,
					  vl_total_geral_inicial,
					  vl_total_geral_final,
					  vl_cancelamento,
					  vl_desconto,
					  vl_contabil,
					  vl_isenta,
					  vl_nao_incidencia,
					  vl_st,
					  qt_reducao_z,
					  qt_reinicio_z,
					  qt_cupom_cancelado,
					  dh_reducao,
					  vl_isento_iss,
					  vl_nao_incidencia_iss,
					  vl_st_iss,
					  vl_desconto_iss,
					  vl_acrescimo,
					  vl_acrescimo_iss,
					  vl_cancelamento_iss,
					  vl_operacao_nao_fiscal)
			Values ( :lvl_filial,
						:lvl_Mapa_Resumo,   
						:lvs_especie,
						:lvs_serie,   
						:lvl_ecf,
						:lvl_nr_operacao_inicial,
						:lvl_nr_operacao_atual,
						:lvdc_total_geral_inicial,
						:lvdc_total_geral_final,
						:lvdc_cancelamento,
						:lvdc_desconto,
						:lvdc_contabil,
						:lvdc_isento,
						:lvdc_nao_incidencia,
						:lvdc_st,
						:lvl_qt_reducao,
						:lvl_qt_reinicio,
						:lvl_qt_cupom_cancelado,
						:lvdh_Reducao,
						:lvdc_isento_iss,
						:lvdc_nao_incidencia_iss,
						:lvdc_st_iss,
						:lvdc_desconto_iss,
						:lvdc_acrescimo,
						:lvdc_acrescimo_iss,
						:lvdc_cancelamento_iss,
						:lvdc_operacao_nao_fiscal)
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
				Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
				Return False
			End If	
			
			If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
			
			lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
			
			Update mapa_resumo
			set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
			Where nr_mapa    = :lvl_Mapa_Resumo
			  and cd_filial  = :lvl_filial
			  and de_especie = :lvs_especie
			  and de_serie   = :lvs_serie
			Using Sqlca;
		
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
				Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
				Return False
			End If
			
			//Grava controle de historio de envio de arquivos blocoX
			If Trim(This.id_gera_blocoX) = 'S' And lvdh_Data_Fiscal >= This.dt_inicio_blocox Then
				If Not This.of_grava_blocox_pendente( lvl_filial, lvl_mapa_resumo, lvl_ecf) Then Return False
				
				Select nr_sequencial
				Into  :lvl_seq
				  From historico_envio_arquivo_paf
				 Where cd_filial    = :lvl_filial  and
						cd_tipo = 'RZ' and
						 nr_ecf = :lvl_ecf and
						nr_mapa_resumo  = :lvl_mapa_resumo and
						qt_reducao_z = :lvl_qt_reducao
				 Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
					Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
					Return False	
				End If
				
				If Isnull(lvl_seq) Or lvl_seq = 0 Then			
					If Not This.of_proximo_historico(Ref PDV.ivl_seq_historico)   Then Return False							
					
					Insert Into historico_envio_arquivo_paf
							( cd_filial,   
							  cd_tipo,
							  qt_reducao_z,
							  nr_ecf,				  
							  nr_mapa_resumo,
							  dh_movimento,
							  id_situacao,
							  id_enviado_matriz)
					Values ( :lvl_filial,
								'RZ',
								:lvl_qt_reducao,
								:lvl_ecf,					
								:lvl_Mapa_Resumo,
								:lvdh_Data_Fiscal,
								'P',
								'N')
					Using Sqlca;	
					
					If Sqlca.Sqlcode = -1 Then
						Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
						Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
						Return False
					End If						
				Else				
					PDV.ivl_seq_historico = lvl_seq
				End If
			End If						
		Else		
			Update mapa_resumo_ecf
				Set nr_operacao_final	= :lvl_nr_operacao_atual,
					 vl_total_geral_final	= :lvdc_total_geral_final,
					 vl_cancelamento		= :lvdc_cancelamento,
					 vl_desconto				= :lvdc_desconto,
					 vl_contabil				= :lvdc_contabil,
					 vl_isenta				= :lvdc_isento,
					 vl_nao_incidencia		= :lvdc_nao_incidencia,
					 vl_st						= :lvdc_st,
					 qt_reducao_z           = :lvl_qt_reducao,
					 qt_reinicio_z			= :lvl_qt_reinicio,
					 qt_cupom_cancelado	= :lvl_qt_cupom_cancelado,
	//				 dh_reducao				= :lvdh_Reducao,
					 vl_isento_iss			= :lvdc_isento_iss,	
					 vl_nao_incidencia_iss= :lvdc_nao_incidencia_iss,
					 vl_st_iss					= :lvdc_st_iss,
					 vl_desconto_iss		= :lvdc_desconto_iss,
					 vl_acrescimo			= :lvdc_acrescimo,
					 vl_acrescimo_iss		= :lvdc_acrescimo_iss,
					 vl_cancelamento_iss	= :lvdc_cancelamento_iss,
					 vl_operacao_nao_fiscal = :lvdc_operacao_nao_fiscal
			Where cd_filial  = :lvl_filial
			  and nr_mapa    = :lvl_Mapa_Resumo
			  and de_especie = :lvs_especie
			  and de_serie   = :lvs_serie
			  and nr_ecf     = :lvl_ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")			
				Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo.")
				Return False
			End If
			
			If Not of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		End If
	
	Case 100
		lvs_Especie = 'MR'
		lvs_Serie   = '1'
		
		If Not Of_Proximo_Mapa_Resumo(Ref lvl_Mapa_Resumo,Ref lvb_Novo_Mapa, lvdh_Data_Fiscal) Then Return False
		
		lvl_nr_operacao_inicial  = Of_Ultimo_Sequencial(lvl_Ecf)
		
		//Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial
		If IsNull(lvl_nr_operacao_inicial) Then 
			Sqlca.Of_MsgDbError("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - opera$$HEX2$$e700e300$$ENDHEX$$o inicial")
			gvo_Aplicacao.of_Grava_Log( "uo_mapa_resumo - of_grava_mapa_resumo_bematech - opera$$HEX2$$e700e300$$ENDHEX$$o inicial com valor nulo" )	
			lvl_nr_operacao_inicial = lvl_nr_operacao_atual
		End If	
		
		//Se a ECF ainda est$$HEX1$$e100$$ENDHEX$$ com a mesmo COO do $$HEX1$$fa00$$ENDHEX$$ltimo mapa gravado significa que este mapa j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ gravado
		If lvl_nr_operacao_inicial = lvl_nr_operacao_atual Then
			gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Bematech - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o pois a operacao inicial $$HEX1$$e900$$ENDHEX$$ igual a final!(of_gravacao_mapa_resumo_bematech).")			
			Return True
		End If
		
		If lvl_nr_operacao_inicial <> 0 Then
			If lvl_nr_operacao_inicial + 1 <= lvl_nr_operacao_atual Then
				lvl_nr_operacao_inicial ++
			End If	
		End If	
		
		If lvb_Novo_Mapa Then
			If Not This.of_Insere_Mapa_Resumo( lvl_filial, lvl_Mapa_Resumo, lvs_especie, lvs_serie, lvdh_Data_Fiscal ) Then
				Return False
			End If
		End If	
		
		Insert Into mapa_resumo_ecf
				( cd_filial,   
				  nr_mapa,   
				  de_especie,   
				  de_serie,   
				  nr_ecf,
				  nr_operacao_inicial,
				  nr_operacao_final,
				  vl_total_geral_inicial,
				  vl_total_geral_final,
				  vl_cancelamento,
				  vl_desconto,
				  vl_contabil,
				  vl_isenta,
				  vl_nao_incidencia,
				  vl_st,
				  qt_reducao_z,
				  qt_reinicio_z,
				  qt_cupom_cancelado,
				  dh_reducao,
				  vl_isento_iss,
				  vl_nao_incidencia_iss,
				  vl_st_iss,
				  vl_desconto_iss,
				  vl_acrescimo,
				  vl_acrescimo_iss,
				  vl_cancelamento_iss,
				  vl_operacao_nao_fiscal)
		Values ( :lvl_filial,
					:lvl_Mapa_Resumo,   
					:lvs_especie,
					:lvs_serie,   
					:lvl_ecf,
					:lvl_nr_operacao_inicial,
					:lvl_nr_operacao_atual,
					:lvdc_total_geral_inicial,
					:lvdc_total_geral_final,
					:lvdc_cancelamento,
					:lvdc_desconto,
					:lvdc_contabil,
					:lvdc_isento,
					:lvdc_nao_incidencia,
					:lvdc_st,
					:lvl_qt_reducao,
					:lvl_qt_reinicio,
					:lvl_qt_cupom_cancelado,
					:lvdh_Reducao,
					:lvdc_isento_iss,
					:lvdc_nao_incidencia_iss,
					:lvdc_st_iss,
					:lvdc_desconto_iss,
					:lvdc_acrescimo,
					:lvdc_acrescimo_iss,
					:lvdc_cancelamento_iss,
					:lvdc_operacao_nao_fiscal)
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")			
			Sqlca.Of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Mapa Resumo ECF.")
			Return False
		End If
		
		If Not Of_Grava_Aliquota_Mapa_Resumo(lvl_filial,lvl_Mapa_Resumo,lvs_especie,lvs_serie,lvl_ecf,lvdc_Faixa_Icm,lvdc_Vl_Icm) Then Return False
		
		lvdh_Movimentacao_Caixa = gvo_parametro.of_dh_movimentacao()
		
		Update mapa_resumo
		set dh_movimentacao_caixa = :lvdh_Movimentacao_Caixa
		Where nr_mapa    = :lvl_Mapa_Resumo
		  and cd_filial  = :lvl_filial
		  and de_especie = :lvs_especie
		  and de_serie   = :lvs_serie
		Using Sqlca;
	
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")			
			Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o data movimenta$$HEX2$$e700e300$$ENDHEX$$o no mapa resumo.")
			Return False
		End If
		
		//Grava controle de historio de envio de arquivos blocoX
		If Trim(This.id_gera_blocoX) = 'S' And lvdh_Data_Fiscal >= This.dt_inicio_blocox Then
			If Not This.of_grava_blocox_pendente( lvl_filial, lvl_mapa_resumo, lvl_ecf) Then Return False
			
			Select nr_sequencial
			Into  :lvl_seq
			  From historico_envio_arquivo_paf
			 Where cd_filial    = :lvl_filial  and
			 		cd_tipo = 'RZ' and
					 nr_ecf = :lvl_ecf and
					nr_mapa_resumo  = :lvl_mapa_resumo and
					qt_reducao_z = :lvl_qt_reducao
			 Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
				Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o historico blocox")
				Return False	
			End If
			
			If Isnull(lvl_seq) Or lvl_seq = 0 Then			
				If Not This.of_proximo_historico(Ref PDV.ivl_seq_historico)   Then Return False							
				
				Insert Into historico_envio_arquivo_paf
						( cd_filial,   
						  cd_tipo,
						  qt_reducao_z,
						  nr_ecf,				  
						  nr_mapa_resumo,
						  dh_movimento,
						  id_situacao,
						  id_enviado_matriz)
				Values ( :lvl_filial,
							'RZ',
							:lvl_qt_reducao,
							:lvl_ecf,					
							:lvl_Mapa_Resumo,
							:lvdh_Data_Fiscal,
							'P',
							'N')
				Using Sqlca;	
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
					Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
					Return False
				End If						
			Else				
				PDV.ivl_seq_historico = lvl_seq
			End If
		End If				

End Choose

gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Mapa Resumo - Fun$$HEX2$$e700e300$$ENDHEX$$o da Epson - Termino da fun$$HEX1$$e700$$ENDHEX$$ao com sucesso!(of_gravacao_mapa_resumo_epson).")

Return True
end function

public function boolean of_proximo_historico (ref long pl_sequencial);Long ll_filial

ll_filial = gvo_parametro.cd_filial

Select max(nr_sequencial) Into :pl_sequencial
From historico_envio_arquivo_paf
Where cd_filial = :ll_filial
Using Sqlca;
//
Choose Case Sqlca.Sqlcode
	Case -1	
		Sqlca.Of_MsgDbError("N$$HEX1$$fa00$$ENDHEX$$mero Historico Paf")
		Sqlca.Of_LogDbError(gvo_Aplicacao.ivi_Log,"N$$HEX1$$fa00$$ENDHEX$$mero Historico Paf")
		Return False
	Case Else
		If IsNull(pl_sequencial) Then pl_sequencial = 0

		pl_sequencial = pl_sequencial + 1
		
End Choose

Return True
end function

public function boolean of_grava_blocox_pendente (long pl_filial, long pl_mapa, long pl_ecf);//Fun$$HEX2$$e700e300$$ENDHEX$$o para verificar se algum mapa_resumo_ecf falta gravar o historico para envido do Bloco X
Long ll_retorno
Long ll_row
Long ll_mapa
Long ll_qtd_rz
Long ll_ecf

Date ldt_movimento

//Procura em 10 movimentos de mapa para tr$$HEX1$$e100$$ENDHEX$$s.
ll_mapa = pl_mapa - 10
If ll_mapa <= 0 Then
	ll_mapa = 1
End If

dc_uo_ds_base lds_mapa
lds_mapa  = Create dc_uo_ds_base

If Not lds_mapa.of_ChangeDataObject('ds_ge039_mapa_sem_blocox') Then Return False

ll_Retorno = lds_mapa.Retrieve(This.dt_inicio_blocox,pl_filial,ll_mapa,pl_ecf,pl_mapa)

Choose Case ll_Retorno
	Case is < 0 //Erro no retrieve
		gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o blocox Pendente - " + lds_mapa.itr_transacao.is_lasterrortext + " (of_grava_blocox_pendente).")
		Return False

	Case 0 //Retorno sem registros
		Return True
		
	Case Else //Sucesso		
		For ll_row = 1 To lds_mapa.RowCount()	
			ll_mapa 				= lds_mapa.Object.nr_mapa		[ll_row]
			ldt_movimento		= lds_mapa.Object.dh_emissao	[ll_row]
			ll_qtd_rz				= lds_mapa.Object.qt_reducao_z	[ll_row]
			ll_ecf					= lds_mapa.Object.nr_ecf			[ll_row]

			Insert Into historico_envio_arquivo_paf
					( cd_filial,   
					  cd_tipo,
					  qt_reducao_z,
					  nr_ecf,				  
					  nr_mapa_resumo,
					  dh_movimento,
					  id_situacao,
					  id_enviado_matriz)
			Values ( :pl_filial,
						'RZ',
						:ll_qtd_rz,
						:ll_ecf,					
						:ll_Mapa,
						:ldt_movimento,
						'P',
						'N')
			Using Sqlca;	
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")			
				Sqlca.of_MsgDBError("Inclus$$HEX1$$e300$$ENDHEX$$o do Hist$$HEX1$$f300$$ENDHEX$$rico Arquivo PAF.")					
				Return False
			End If			
		Next
End choose

Return True
end function

on uo_mapa_resumo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mapa_resumo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;If Not IsValid(PDV) Then PDV = Create uo_pdv

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

String ls_data_blocox

lvo_Parametro.of_Localiza_Parametro("ID_GERA_ARQUIVO_BLOCOX", ref This.id_gera_blocoX, False)
lvo_Parametro.of_Localiza_Parametro("DT_INICIO_BLOCOX", ref ls_data_blocox, False)
If IsDate(ls_data_blocox) Then
	This.dt_inicio_blocox = Date(ls_data_blocox)
Else
	IsNull(This.dt_inicio_blocox)
End If	

Destroy(lvo_Parametro)
end event

event destructor;//Destroy(PDV)
end event

