HA$PBExportHeader$uo_ge253_mult.sru
forward
global type uo_ge253_mult from nonvisualobject
end type
end forward

global type uo_ge253_mult from nonvisualobject
end type
global uo_ge253_mult uo_ge253_mult

type variables
Boolean Exibe_Confirmacao = False
Boolean Exibe_Mensagem = True

String Log

end variables

forward prototypes
public function boolean of_grava_lote_item (long pl_exportacao, long pl_filial, date pdh_contabil, long pl_conta, string ps_natureza, decimal pdc_valor, string ps_obs, long pl_cc)
private function string of_decimal (decimal adc_valor, integer ai_decimal)
public function boolean of_grava_lote_item (long pl_exportacao, long pl_filial, date pdh_contabil, long pl_conta, string ps_natureza, decimal pdc_valor, string ps_obs)
public function long of_inicia_lote (string ps_procedimento, string ps_tipo_docto, date pdh_inclusao)
public function boolean of_finaliza_lote (long pl_lote)
private function boolean of_exporta_lote_item (integer ai_arquivo, long al_filial, date adt_data, string as_conta_debito, string as_conta_credito, decimal adc_valor, string as_complemento)
private function boolean of_exporta_lote_cc (integer ai_arquivo, string as_centro_custo, decimal adc_valor)
private subroutine of_log (string ps_mensagem)
private function boolean of_exporta_lote_cabecalho (integer pi_arquivo, string ps_tipo_docto, long pl_filial)
public function boolean of_exporta_lote (long pl_lote, string ps_arquivo, boolean pb_gera_cabecalho)
private function integer of_abre_arquivo (string ps_arquivo)
end prototypes

public function boolean of_grava_lote_item (long pl_exportacao, long pl_filial, date pdh_contabil, long pl_conta, string ps_natureza, decimal pdc_valor, string ps_obs, long pl_cc);Boolean lvb_Sucesso = True
Long lvl_Item

If pdc_valor = 0.00 Then Return True
If Not(pl_cc > 0) Then SetNull(pl_cc)

select coalesce(max(nr_item),0) +1 
Into :lvl_Item
from lote_exportacao_item 
where nr_exportacao = :pl_exportacao
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	If Exibe_Mensagem Then
		SQLCa.Of_MsgDbError('Ocorreu um erro ao tentar localizar o sequencial do lote na base.')
	Else
		This.Of_Log('Ocorreu um erro ao tentar localizar o sequencial do lote na base.~r~n'+SQLCa.is_lasterrortext)
	End If
	
	lvb_Sucesso = False
Else 
	If IsNull(lvl_Item) or (lvl_Item<=0) Then lvl_Item = 1
	
	Insert Into lote_exportacao_item(nr_exportacao, nr_item, cd_filial, dh_contabil, cd_conta_contabil, id_natureza, vl_contabil, de_observacao, cd_centro_custo)
	Values (:pl_exportacao, :lvl_Item, :pl_filial,:pdh_contabil,:pl_conta, :ps_natureza, :pdc_valor, :ps_obs, :pl_cc)
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_RollBack()
		If Exibe_Mensagem Then
			SQLCa.Of_MsgDbError('Ocorreu um erro ao tentar gravar o lote na base.')
		Else
			This.Of_Log('Ocorreu um erro ao tentar gravar o lote na base.~r~n'+SQLCa.is_lasterrortext)
		End If
		lvb_Sucesso = False
	End If
End If

Return lvb_Sucesso
end function

private function string of_decimal (decimal adc_valor, integer ai_decimal);String lvs_Valor, &
		 lvs_Decimal

If IsNull(adc_Valor) Then adc_Valor = 0

If adc_Valor = 0 Then
	lvs_Valor = "0.00"
Else
	lvs_Decimal = FillA("0", ai_Decimal)
	
	lvs_Valor = String(adc_Valor, "0." + lvs_Decimal)
	
	lvs_Valor = LeftA(lvs_Valor, LenA(lvs_Valor) - ai_Decimal - 1) + "." + RightA(lvs_Valor, ai_Decimal)
End If

Return lvs_Valor
end function

public function boolean of_grava_lote_item (long pl_exportacao, long pl_filial, date pdh_contabil, long pl_conta, string ps_natureza, decimal pdc_valor, string ps_obs);Long lvl_CC

SetNull(lvl_CC)
Return This.of_grava_lote_item(pl_exportacao, pl_filial, pdh_contabil, pl_conta, ps_natureza, pdc_valor, ps_obs, lvl_CC)
end function

public function long of_inicia_lote (string ps_procedimento, string ps_tipo_docto, date pdh_inclusao);Long lvl_Exportacao
Long lvl_Count

If Len(ps_procedimento)>7 Then ps_procedimento = Mid(ps_procedimento,1,7)

Select count(1)
Into :lvl_Count
From lote_exportacao
Where cd_procedimento = :ps_procedimento
	And de_tipo_docto = :ps_tipo_docto
	And dh_inclusao = :pdh_inclusao
Using SQLCa;

If lvl_Count > 0 Then 
	If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','J$$HEX1$$e100$$ENDHEX$$ foi gravada uma requisi$$HEX2$$e700e300$$ENDHEX$$o de importa$$HEX2$$e700e300$$ENDHEX$$o deste tipo hoje.~r~nDeseja gravar mais uma requisi$$HEX2$$e700e300$$ENDHEX$$o?',Question!,YesNo!,2)=2 Then
		Return -1
	End If
End If

Insert Into lote_exportacao (cd_procedimento, de_tipo_docto, dh_inclusao, id_status, nr_matricula)
Values (:ps_procedimento, :ps_tipo_docto, :pdh_inclusao, 'I',:gvo_Aplicacao.ivo_seguranca.nr_matricula)
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_RollBack()
	If Exibe_Mensagem Then
		MessageBox('Erro!','Erro ao inserir o registro de lote para exporta$$HEX2$$e700e300$$ENDHEX$$o!~r~n'+SQLCa.SQLErrText,StopSign!)
	Else
		This.Of_Log('Erro ao inserir o registro de lote para exporta$$HEX2$$e700e300$$ENDHEX$$o!~r~n'+SQLCa.SQLErrText)
	End If
	lvl_Exportacao = -1
Else	
	select @@identity 
	Into :lvl_Exportacao 
	from lote_exportacao
	Using SQLCa;
	
	/*If SQLCa.SQLCode = -1 Then
		SQLCa.Of_RollBack()
		MessageBox('Erro!','Erro ao inserir o registro de lote para exporta$$HEX2$$e700e300$$ENDHEX$$o!~r~n'+SQLCa.SQLErrText,StopSign!)
		lvl_Exportacao = -1
	End If*/
End If

Return lvl_Exportacao
end function

public function boolean of_finaliza_lote (long pl_lote);Decimal{2} lvdc_Credito
Decimal{2} lvdc_Debito

String lvs_Retorno

Select sum(case when id_natureza = 'D' then vl_contabil else 0.00 end) as vl_debito, 
		 sum(case when id_natureza = 'C' then vl_contabil else 0.00 end) as vl_credito
Into :lvdc_Debito, :lvdc_Credito
From lote_exportacao_item
Where nr_exportacao = :pl_lote
Using SQLCa;

If Not Exibe_Confirmacao Then	
	If lvdc_Debito <> lvdc_Credito Then
		If Exibe_Mensagem Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Diverg$$HEX1$$ea00$$ENDHEX$$ncia entre cr$$HEX1$$e900$$ENDHEX$$dito ('+String(lvdc_Credito,'#,##0.00')+') e d$$HEX1$$e900$$ENDHEX$$bito ('+String(lvdc_Debito,'#,##0.00')+'). ~r~nO lote n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ gravado, contate a inform$$HEX1$$e100$$ENDHEX$$tica.',Exclamation!,OK!)
		Else
			This.Of_Log('Diverg$$HEX1$$ea00$$ENDHEX$$ncia entre cr$$HEX1$$e900$$ENDHEX$$dito ('+String(lvdc_Credito,'#,##0.00')+') e d$$HEX1$$e900$$ENDHEX$$bito ('+String(lvdc_Debito,'#,##0.00')+'). ~r~nO lote n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ gravado.')
		End If
		SQLCa.Of_RollBack()
		Return False
	End If
Else
	OpenWithParm(w_ge253_confirma_gravacao,pl_lote)
	lvs_Retorno = Message.StringParm
	
	If lvs_Retorno = 'N' Then
		SQLCa.Of_RollBack()
		Return False
	End If
End If

If IsNull(lvdc_Debito) Then lvdc_Debito = 0.00 
If IsNull(lvdc_Credito) Then lvdc_Credito = 0.00 

If (lvdc_Debito + lvdc_Credito) = 0.00 Then
	Delete From lote_exportacao
	Where nr_exportacao = :pl_lote
		And not exists (select 1 from lote_exportacao_item where nr_exportacao = :pl_lote)
	Using SQLCa;
End If

Return True
end function

private function boolean of_exporta_lote_item (integer ai_arquivo, long al_filial, date adt_data, string as_conta_debito, string as_conta_credito, decimal adc_valor, string as_complemento);Boolean lvb_Sucesso = True

String lvs_Registro
String lvs_Sep = ','

Integer lvi_Write

// Filial
lvs_Registro = String(al_Filial) + lvs_Sep

// Data
lvs_Registro += String(adt_Data, "ddmmyyyy") + lvs_Sep

// Conta D$$HEX1$$e900$$ENDHEX$$bito e Cr$$HEX1$$e900$$ENDHEX$$dito
lvs_Registro += as_Conta_Debito + lvs_Sep + as_Conta_Credito + lvs_Sep

// Valor do Lan$$HEX1$$e700$$ENDHEX$$amento
lvs_Registro += This.of_Decimal(adc_Valor, 2) + lvs_Sep

// Hist$$HEX1$$f300$$ENDHEX$$rico Padr$$HEX1$$e300$$ENDHEX$$o
lvs_Registro += "0" + lvs_Sep

// Complemento
lvs_Registro += '"' + Upper(as_Complemento) + '"'
			
lvi_Write = FileWrite(ai_Arquivo, lvs_Registro)

If lvi_Write <> LenA(lvs_Registro) Then
	If Exibe_Mensagem Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo.", StopSign!)
	Else
		This.Of_Log("Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo.")
	End If
	lvb_Sucesso = False
End If

Return lvb_Sucesso
end function

private function boolean of_exporta_lote_cc (integer ai_arquivo, string as_centro_custo, decimal adc_valor);Boolean lvb_Sucesso = True

Integer lvi_Write

String lvs_Registro
String lvs_Sep = ','

If adc_Valor > 0 Then
	
	// Centro de custo
	
	lvs_Registro = "|"+ lvs_Sep + as_centro_custo + lvs_Sep
	
	// Valor do Lan$$HEX1$$e700$$ENDHEX$$amento
	lvs_Registro += This.of_Decimal(adc_Valor, 2)
	
	lvi_Write = FileWrite(ai_Arquivo, lvs_Registro)
	
	If lvi_Write <> LenA(lvs_Registro) Then
		If Exibe_Mensagem Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo.", StopSign!)
		Else 
			This.Of_Log("Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo.")
		End If
		lvb_Sucesso = False
	End If
End If

Return lvb_Sucesso
end function

private subroutine of_log (string ps_mensagem);If Log <> '' Then Log += '~r~n'
	
Log += 'Data: '+String(Today(),'DD/MM/YYYY HH:MM:SS')+' '+ps_mensagem 
end subroutine

private function boolean of_exporta_lote_cabecalho (integer pi_arquivo, string ps_tipo_docto, long pl_filial);Boolean lvb_Sucesso = True

Integer lvi_Write

String lvs_Registro
String lvs_Sep = '|'

//1 = Tipo de Opera$$HEX2$$e700e300$$ENDHEX$$o
lvs_Registro = '1400' + lvs_Sep
//2 = C$$HEX1$$f300$$ENDHEX$$digo Tipo de Documento
lvs_Registro += ps_tipo_docto + lvs_Sep
//3 = Ignorar Zeros a Esquerda T/F
lvs_Registro += 'T' + lvs_Sep
//4 = C$$HEX1$$f300$$ENDHEX$$digo Filial
lvs_Registro += '' /*String(pl_filial)*/ + lvs_Sep
//5 = Modelo = 5
lvs_Registro += '5' + lvs_Sep
//6 = Docto Lote
lvs_Registro += '' + lvs_Sep
//7 = Data Emi DD/MM/YYYY
lvs_Registro += '' + lvs_Sep
//8 = Bloqueado Altera$$HEX2$$e700e300$$ENDHEX$$o T/F
lvs_Registro += '' + lvs_Sep
	
lvi_Write = FileWrite(pi_arquivo, lvs_Registro)

If lvi_Write <> LenA(lvs_Registro) Then
	If Exibe_Mensagem Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo.", StopSign!)
	Else
		This.Of_Log("Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo.")
	End If
	
	lvb_Sucesso = False
End If

Return lvb_Sucesso
end function

public function boolean of_exporta_lote (long pl_lote, string ps_arquivo, boolean pb_gera_cabecalho);Long lvl_Linha
Long lvl_Linhas
Long lvl_CC
Long lvl_Filial

Integer lvi_Arquivo

String lvs_Historico
String lvs_Natureza
String lvs_Conta_Cred
String lvs_Conta_Deb
String lvs_Tipo_Docto
String lvs_Arquivo_Temp

Date lvdt_Contabil

Decimal{2} lvdc_Valor

Boolean lvb_Retorno = True


dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.Of_ChangeDataObject('dw_ge253_lista_itens') Then
	If Exibe_mensagem Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Erro ao trocar para dw_ge253_lista_itens na fun$$HEX2$$e700e300$$ENDHEX$$o of_exporta_lote.~r~nContate a inform$$HEX1$$e100$$ENDHEX$$tica.')
	Else 
		Of_Log('Erro ao trocar para dw_ge253_lista_itens na fun$$HEX2$$e700e300$$ENDHEX$$o of_exporta_lote.')
	End If
	Return False
End If

/* Arquivo tempor$$HEX1$$e100$$ENDHEX$$rio */
lvs_Arquivo_Temp = Mid(ps_arquivo,1,Len(ps_arquivo)-4)+'.EXP'	

lvi_Arquivo = This.of_abre_arquivo(lvs_Arquivo_Temp)

lvb_Retorno = (lvi_Arquivo > 0)

If lvb_Retorno Then
	Update lote_exportacao
	Set id_status = 'P'
	From lote_exportacao
	Where nr_exportacao = :pl_lote
		And id_status <> 'P'
	Using SQLCa;
	
	lvb_Retorno = ((SQLCa.SQLCode = 0)and(SQLCa.SQLNRows > 0))
	
	If lvb_Retorno Then 
		SQLCa.Of_Commit()
		lvds_1.Of_AppendWhere("le.id_status='P'")
		lvl_Linhas = lvds_1.Retrieve(pl_lote)
		
		If lvl_Linhas > 0 Then
			Select de_tipo_docto
			Into :lvs_Tipo_Docto
			From lote_exportacao
			Where nr_exportacao = :pl_lote
			Using SQLCa;
			
			lvb_Retorno = (SQLCa.SQLCode = 0)
			If lvb_Retorno Then 
				//Gera cabe$$HEX1$$e700$$ENDHEX$$alho?
				If pb_gera_cabecalho Then 	lvb_Retorno = This.of_Exporta_Lote_Cabecalho(lvi_Arquivo, lvs_Tipo_Docto, 534)
					
				If lvb_Retorno Then
				
					For lvl_Linha = 1 To lvl_Linhas
						lvl_Filial			= lvds_1.Object.cd_filial 				[lvl_Linha]
						lvs_Conta_Cred	= String(lvds_1.Object.cd_conta_credito	[lvl_Linha])
						lvs_Conta_Deb	= String(lvds_1.Object.cd_conta_debito	[lvl_Linha])
						lvs_Historico		= lvds_1.Object.de_observacao	[lvl_Linha]
						lvdt_Contabil	= Date(lvds_1.Object.dh_contabil	[lvl_Linha])
						lvdc_Valor		= lvds_1.Object.vl_contabil			[lvl_Linha]
						lvl_CC				= lvds_1.Object.cd_centro_custo	[lvl_Linha]
						
						//Gera Item
						If Not This.Of_Exporta_Lote_Item(lvi_Arquivo		, &
																	lvl_Filial			, &
																	lvdt_Contabil	, &
																	lvs_Conta_Deb	, &
																	lvs_Conta_Cred	, &
																	lvdc_Valor		, &
																	lvs_Historico) Then 
							lvb_Retorno = False
							Exit
						End If
						//Gera CC?									
						If (Not IsNull(lvl_CC)) and (lvl_CC > 0) Then 
							If Not This.Of_exporta_lote_cc(lvi_Arquivo,String(lvl_CC), lvdc_Valor) Then
								lvb_Retorno = False
								Exit
							End If
						End If
					Next
				End If
			End If
		End If
		
		If lvb_Retorno Then
			Update lote_exportacao
			Set id_status = 'E', dh_exportacao = GetDate()
			From lote_exportacao
			Where nr_exportacao = :pl_lote
				And id_status = 'P'
			Using SQLCa;
			
			lvb_Retorno = ((SQLCa.SQLCode = 0)and(SQLCa.SQLNRows > 0))
			
			If lvb_retorno Then
				SQLCa.Of_Commit()
			Else
				SQLCa.Of_RollBack()
			End If
		End If
	Else
		If Exibe_Mensagem Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','O lote '+String(pl_lote)+' est$$HEX1$$e100$$ENDHEX$$ sendo exportado por outro processo.',Exclamation!)
		Else
			This.Of_Log('O lote '+String(pl_lote)+' est$$HEX1$$e100$$ENDHEX$$ sendo exportado por outro processo.')
		End If
	End If
End If

/* Renomeia Arquivo */
FileClose(lvi_Arquivo)

If   FileLength(lvs_Arquivo_Temp) = 0 Then
	FileDelete(lvs_Arquivo_Temp) 
Else	
	If FileExists(ps_arquivo) Then
		FileDelete(ps_arquivo)
	End If
	FileMove(lvs_Arquivo_Temp,ps_arquivo)
End If

Destroy(lvds_1)

Return lvb_Retorno
end function

private function integer of_abre_arquivo (string ps_arquivo);Integer lvi_Arquivo

If FileExists(ps_Arquivo) Then	
	If Not FileDelete(ps_Arquivo) Then	
		
		If Exibe_Mensagem Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo: " + ps_Arquivo+". ~r~n A exporta$$HEX2$$e700e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ cancelada!", StopSign!, Ok! )
		Else
			This.Of_Log("Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo: " + ps_Arquivo+".")
		End If
		
		Return -1
	End If			
End If

lvi_Arquivo = FileOpen(ps_Arquivo , LineMode!, Write!, LockWrite!, Replace!)

If lvi_Arquivo = -1 Then
	If Exibe_Mensagem Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo: " + ps_Arquivo+". ~r~n A exporta$$HEX2$$e700e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ cancelada!", StopSign!, Ok! )
	Else
		This.Of_Log("Erro na abertura do arquivo: " + ps_Arquivo+".")
	End If
End If

Return lvi_Arquivo
end function

on uo_ge253_mult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge253_mult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

