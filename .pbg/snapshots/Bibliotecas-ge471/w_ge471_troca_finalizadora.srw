HA$PBExportHeader$w_ge471_troca_finalizadora.srw
forward
global type w_ge471_troca_finalizadora from dc_w_sheet
end type
type dw_2 from dc_uo_dw_base within w_ge471_troca_finalizadora
end type
type dw_3 from dc_uo_dw_base within w_ge471_troca_finalizadora
end type
type gb_hubt101 from groupbox within w_ge471_troca_finalizadora
end type
type gb_fin_origem from groupbox within w_ge471_troca_finalizadora
end type
type gb_fin_destino from groupbox within w_ge471_troca_finalizadora
end type
type dw_1 from dc_uo_dw_base within w_ge471_troca_finalizadora
end type
end forward

global type w_ge471_troca_finalizadora from dc_w_sheet
integer width = 3634
integer height = 1920
string title = "GE471 - Troca Finalizadora CAR"
dw_2 dw_2
dw_3 dw_3
gb_hubt101 gb_hubt101
gb_fin_origem gb_fin_origem
gb_fin_destino gb_fin_destino
dw_1 dw_1
end type
global w_ge471_troca_finalizadora w_ge471_troca_finalizadora

type variables
Decimal{0} ivdc_Nr_Atualizacao

uo_ge471_finalizadoras_car ivo_Finalizadora
end variables

forward prototypes
public function boolean wf_valida_finalizadora (long pl_linha, string ps_cdfin)
public function boolean wf_altera_finalizadora (long pl_linha)
end prototypes

public function boolean wf_valida_finalizadora (long pl_linha, string ps_cdfin);String lvs_CampoInv
String lvs_Campos=""
String lvs_Descr_Fin
String lvs_Tipo_Fin
Long lvl_Colunas
Long lvl_Coluna

String lvs_Tabela
String lvs_Coluna
String lvs_DBColuna
String lvs_ColunmType

String lvs_Valor
Decimal lvdc_Valor
Long lvl_Valor
Date lvdt_Valor
Datetime lvdh_Valor
Any lva_Null

Boolean lvb_Sucesso = True
Boolean lvb_Sem_Valor = False
Boolean lvb_Campo_Requerido
Boolean lvb_Campo_Vazio
Boolean lvb_Campo_Alerta

SetNull(lva_Null)

Try
	//Localiza atributos e obrigatoriedades de preenchimento dessa finalizadora
	If Not ivo_Finalizadora.Of_Localiza(ps_cdfin) Then
		lvs_CampoInv 	= "cdfin"
		lvs_Campos		+= " * C$$HEX1$$f300$$ENDHEX$$digo Finalizadora"
		lvb_Sucesso 	= False
		Return lvb_Sucesso
	End If
	
	lvl_Colunas	= Long(dw_3.Describe("DataWindow.Column.Count"))
	lvs_Tabela	= dw_3.Object.DataWindow.Table.UpdateTable
	
	For lvl_Coluna = 1 To lvl_Colunas
		lvs_Coluna		= dw_3.Describe("#"+String(lvl_Coluna)+".Name")
		lvs_DBColuna	= gf_replace(dw_3.Describe("#"+String(lvl_Coluna)+".DBName"),lvs_Tabela+'.','',0)
		
		lvb_Campo_Requerido	= ivo_Finalizadora.Of_Coluna_Obrigatoria(lvs_Coluna)
		lvb_Campo_Vazio	 	 	= ivo_Finalizadora.Of_Coluna_Vazia(lvs_Coluna)
		lvb_Campo_Alerta	 	 	= ivo_Finalizadora.Of_Coluna_Alerta(lvs_Coluna)
		
		//Recupera o tipo de dado da coluna
		lvs_ColunmType = Upper(dw_3.Describe("#"+String(lvl_Coluna)+".Coltype"))
		//Recupera os valores atual e antigo da coluna conforme o tipo de dado e converte para string
		Choose Case lvs_ColunmType
			Case 'NUMBER','LONG','INT','ULONG'
				lvl_Valor 			= dw_3.GetItemNumber(pl_linha,lvs_Coluna)
				lvb_Sem_Valor = (gf_coalesce(lvl_Valor,0)=0)
				
			Case 'DATE'
				lvdt_Valor		= dw_3.GetItemDate(pl_linha,lvs_Coluna)
				lvb_Sem_Valor = (gf_coalesce(lvdt_Valor,Date("20221231")) < Date("20230101"))
				
			Case 'DATETIME'
				lvdh_Valor		= dw_3.GetItemDatetime(pl_linha,lvs_Coluna)
				lvb_Sem_Valor = (gf_coalesce(lvdh_Valor,Datetime("20221231")) < Datetime("20230101"))			
				
			Case Else
				If (Pos(lvs_ColunmType,'DECIMAL')>0)or(lvs_ColunmType='REAL') Then
					lvdc_Valor		= dw_3.GetItemDecimal(pl_linha,lvs_Coluna)
					lvb_Sem_Valor = (gf_coalesce(lvdc_Valor,0) = 0)
				Else
					lvs_Valor			= dw_3.GetItemString(pl_linha,lvs_Coluna)
					lvb_Sem_Valor	= (gf_coalesce(lvs_Valor,"") = "")
					//Se for o campo CPF ou CNPJ, valida os dois juntos
					If lvb_Sem_Valor and (lvs_Coluna="stcd1" or lvs_Coluna="stcd2") Then
						lvs_Valor			= dw_3.GetItemString(pl_linha,IIF(lvs_Coluna="stcd2","stcd1","stcd2"))
						lvb_Sem_Valor	= (gf_coalesce(lvs_Valor,"") = "")
					End If
				End If
		End Choose
		
		//Campo sem valor (nulo ou zerado)
		If lvb_Sem_Valor Then
			//Se for requerido
			If lvb_Campo_Requerido Then
				If lvs_CampoInv="" Then lvs_CampoInv = lvs_Coluna	
				lvs_Campos		+= "~r * "+ivo_Finalizadora.Of_Retorna_Nome_Campo(lvs_Coluna)
				lvb_Sucesso = False
			//Se o campo estiver para alertar
			ElseIf lvb_Campo_Alerta Then
				If MessageBox("Alerta","O campo "+lvs_Coluna+" est$$HEX1$$e100$$ENDHEX$$ sem valor.~r"+&
					"Deseja prosseguir mesmo assim?", Question!, YesNo!,2)=2 Then
					If lvs_CampoInv="" Then lvs_CampoInv = lvs_Coluna
					lvs_Campos		+= "~r * "+ivo_Finalizadora.Of_Retorna_Nome_Campo(lvs_Coluna)
					lvs_Campos		+= IIF(lvs_Coluna="stcd1"," ou CPF","")
					lvs_Campos		+= IIF(lvs_Coluna="stcd2"," ou CNPJ","")
					lvb_Sucesso = False	
				End If
			End If
		//Campo possui valor
		Else
			//Para essa finalizadora o campo deve permanecer vazio?
			If lvb_Campo_Vazio Then
				dw_3.SetItem(pl_linha, lvs_Coluna, lva_Null)
			End If				
		End If
	Next
	
Catch (RuntimeError lvo_Erro)
	MessageBox("Erro",lvo_Erro.GetMessage(), StopSign!)
	lvb_Sucesso = False
	Return False

Finally
	//Retorna Mensagem valida$$HEX2$$e700e300$$ENDHEX$$o
	If Not lvb_Sucesso and lvs_CampoInv<>"" Then
		dw_3.Event ue_Pos(pl_linha, lvs_CampoInv)
		MessageBox("Preenchimento Inv$$HEX1$$e100$$ENDHEX$$lido", "Para a finalizadora "+gf_coalesce(ps_cdfin,"")+" $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio o preenchimento dos campos:~r~r"+gf_coalesce(lvs_Campos,""))
	End If
	
End Try

Return lvb_Sucesso
end function

public function boolean wf_altera_finalizadora (long pl_linha);Long lvl_Colunas
Long lvl_Coluna

String lvs_Tabela
String lvs_Coluna
String lvs_DBColuna
String lvs_ColunmType

String lvs_Valor
Decimal lvdc_Valor
Long lvl_Valor
Date lvdt_Valor
Datetime lvdh_Valor
Any lva_Null

Boolean lvb_Sucesso = True
Boolean lvb_Sem_Valor = False
Boolean lvb_Campo_Vazio

Try
	SetNull(lva_Null)
	dw_3.SetRedraw(False)
	
	lvl_Colunas	= Long(dw_3.Describe("DataWindow.Column.Count"))
	lvs_Tabela	= dw_3.Object.DataWindow.Table.UpdateTable
	
	//Percorre as colunas limpando os valores n$$HEX1$$e300$$ENDHEX$$o necess$$HEX1$$e100$$ENDHEX$$rios
	For lvl_Coluna = 1 To lvl_Colunas
		lvs_Coluna		= dw_3.Describe("#"+String(lvl_Coluna)+".Name")
		lvs_DBColuna	= gf_replace(dw_3.Describe("#"+String(lvl_Coluna)+".DBName"),lvs_Tabela+'.','',0)
		//Para essa finalizadora o campo deve ficar vazio?
		lvb_Campo_Vazio	 	 	= ivo_Finalizadora.Of_Coluna_Vazia(lvs_Coluna)
		
		//Recupera o tipo de dado da coluna
		lvs_ColunmType = Upper(dw_3.Describe("#"+String(lvl_Coluna)+".Coltype"))
		//Recupera os valores atual e antigo da coluna conforme o tipo de dado e converte para string
		Choose Case lvs_ColunmType
			Case 'NUMBER','LONG','INT','ULONG'
				lvl_Valor 			= dw_3.GetItemNumber(pl_linha,lvs_Coluna)
				lvb_Sem_Valor = (gf_coalesce(lvl_Valor,0)=0)
				
				//Campo com valor e deveria ficar sem valor
				If Not lvb_Sem_Valor and lvb_Campo_Vazio Then
					dw_3.SetItem(pl_linha, lvs_Coluna, 0)	
				End If
				
			Case 'DATE'
				lvdt_Valor		= dw_3.GetItemDate(pl_linha,lvs_Coluna)
				lvb_Sem_Valor = (gf_coalesce(lvdt_Valor,Date("20221231")) < Date("20230101"))
				
				//Campo com valor e deveria ficar sem valor
				If Not lvb_Sem_Valor and lvb_Campo_Vazio Then
					SetNull(lvdt_Valor)
					dw_3.SetItem(pl_linha, lvs_Coluna, lvdt_Valor)	
				End If
				
			Case 'DATETIME'
				lvdh_Valor		= dw_3.GetItemDatetime(pl_linha,lvs_Coluna)
				lvb_Sem_Valor = (gf_coalesce(lvdh_Valor,Datetime("20221231")) < Datetime("20230101"))
				
				//Campo com valor e deveria ficar sem valor
				If Not lvb_Sem_Valor and lvb_Campo_Vazio Then
					SetNull(lvdh_Valor)
					dw_3.SetItem(pl_linha, lvs_Coluna, lvdh_Valor)	
				End If
				
			Case Else
				If (Pos(lvs_ColunmType,'DECIMAL')>0)or(lvs_ColunmType='REAL') Then
					lvdc_Valor		= dw_3.GetItemDecimal(pl_linha,lvs_Coluna)
					lvb_Sem_Valor = (gf_coalesce(lvdc_Valor,0) = 0)
					
					//Campo com valor e deveria ficar sem valor
					If Not lvb_Sem_Valor and lvb_Campo_Vazio Then
						dw_3.SetItem(pl_linha, lvs_Coluna, 0)	
					End If
				Else
					lvs_Valor			= dw_3.GetItemString(pl_linha,lvs_Coluna)
					lvb_Sem_Valor	= (gf_coalesce(lvs_Valor,"") = "")
					//Se for o campo CPF ou CNPJ, valida os dois juntos
					If lvb_Sem_Valor and (lvs_Coluna="stcd1" or lvs_Coluna="stcd2") Then
						lvs_Valor			= dw_3.GetItemString(pl_linha,IIF(lvs_Coluna="stcd2","stcd1","stcd2"))
						lvb_Sem_Valor	= (gf_coalesce(lvs_Valor,"") = "")
					End If
					
					//Campo com valor e deveria ficar sem valor
					If Not lvb_Sem_Valor and lvb_Campo_Vazio Then
						dw_3.SetItem( pl_linha, lvs_Coluna, "")	
					End If
				End If
		End Choose
	Next
	
	//Popula dados padr$$HEX1$$e300$$ENDHEX$$o conforme o tipo de finalizadora
	Choose Case ivo_finalizadora.Tipo_finalizadora
		Case 'DI'
			dw_3.Object.dtpag	[pl_linha] = dw_1.Object.dtopr [1]
			dw_3.Object.qtdia		[pl_linha] = 0
			dw_3.Object.zterm	[pl_linha] = 'D000'
			
		Case 'CA'
			If dw_3.Object.zterm	[pl_linha] <> 'DD01' Then
				dw_3.Object.dtpag	[pl_linha] = RelativeDate(dw_1.Object.dtopr [1], 1)
				dw_3.Object.qtdia		[pl_linha] = 2
				dw_3.Object.zterm	[pl_linha] = 'DD01'
			End If
			
		Case '	CP'
			If dw_3.Object.zterm	[pl_linha] <> 'DC01' Then
				dw_3.Object.zterm	[pl_linha] = 'DC01'
				dw_3.Object.qtdia		[pl_linha] = 30
				dw_3.Object.dtpag	[pl_linha] = RelativeDate(dw_1.Object.dtopr [1], 30)
			End If
			
		Case 'CV'
			If dw_3.Object.zterm	[pl_linha] <> 'DCV0' Then
				dw_3.Object.zterm	[pl_linha] = 'DCV0'
				dw_3.Object.qtdia		[pl_linha] = 0
				dw_3.Object.dtpag	[pl_linha] = dw_1.Object.dtopr [1]
			End If
			
		Case 'CR'
			dw_3.Object.zterm	[pl_linha] = 'DCR1'
			dw_3.Object.qtdia		[pl_linha] = 0
			dw_3.Object.dtpag	[pl_linha] = dw_1.Object.dtopr [1]
			
		Case 'CC'
			dw_3.Object.zterm	[pl_linha] = 'DCC0'
			dw_3.Object.qtdia		[pl_linha] = 30
			dw_3.Object.dtpag	[pl_linha] = RelativeDate(dw_1.Object.dtopr [1], 30)
			
		Case 'PX'
			dw_3.Object.dtpag	[pl_linha] = dw_1.Object.dtopr [1]
			dw_3.Object.qtdia		[pl_linha] = 0
			dw_3.Object.zterm	[pl_linha] = 'D000'
	End Choose
Catch (RuntimeError lvo_Erro)
	MessageBox("Erro",lvo_Erro.GetMessage(), StopSign!)
	lvb_Sucesso = False
	Return False

Finally
	dw_3.SetRedraw(True)
End Try

Return lvb_Sucesso
end function

on w_ge471_troca_finalizadora.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.gb_hubt101=create gb_hubt101
this.gb_fin_origem=create gb_fin_origem
this.gb_fin_destino=create gb_fin_destino
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.gb_hubt101
this.Control[iCurrent+4]=this.gb_fin_origem
this.Control[iCurrent+5]=this.gb_fin_destino
this.Control[iCurrent+6]=this.dw_1
end on

on w_ge471_troca_finalizadora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.gb_hubt101)
destroy(this.gb_fin_origem)
destroy(this.gb_fin_destino)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;ivdc_Nr_Atualizacao = Message.DoubleParm	

ivo_Finalizadora = Create uo_ge471_finalizadoras_car

MaxHeight = 1900
MaxWidth = 3680
end event

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1, dw_2, dw_3}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_Retrieve()
end event

event resize;call super::resize;gb_fin_origem.Width = NewWidth - gb_fin_origem.X - 35
dw_2.Width = gb_fin_origem.Width - 75

gb_fin_destino.Width = gb_fin_origem.Width
dw_3.Width = dw_2.Width
end event

event ue_presave;call super::ue_presave;Long lvl_Linha
Long lvl_Linhas

String lvs_CdFin

dw_1.AcceptText()
dw_3.AcceptText()

If dw_2.GetItemDecimal(1,"vl_total_rec") + dw_3.GetItemDecimal(1, "vl_total_rec") <> 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O total das finalizadoras destino n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o iguais ao total da finalizadora origem.",Exclamation!)
	dw_3.SetFocus()
	Return False
End If


lvl_Linhas = dw_3.RowCount()
For lvl_Linha = 1 To lvl_Linhas
	lvs_CdFin = dw_3.Object.cdfin [lvl_Linha]
	
	If Not wf_valida_finalizadora(lvl_Linha, lvs_CdFin) Then Return False
Next

Return AncestorReturnValue
end event

event close;call super::close;If IsValid(ivo_Finalizadora) Then Destroy(ivo_Finalizadora)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge471_troca_finalizadora
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge471_troca_finalizadora
end type

type dw_2 from dc_uo_dw_base within w_ge471_troca_finalizadora
integer x = 82
integer y = 680
integer width = 3415
integer height = 416
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge471_finalizadoras"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Linhas

Try
	//Limpa o datastore
	This.Reset()
	
	dc_uo_ds_base lvds_log_fin
	lvds_log_fin = Create dc_uo_ds_base
	If Not lvds_log_fin.Of_Changedataobject("ds_ge471_log_financeiro", False) Then
		MessageBox('Alerta',"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel alterar o datastore para ds_ge471_log_financeiro", Exclamation!)
		Return 0
	End If
	
	lvl_Linhas = lvds_log_fin.Retrieve(ivdc_Nr_Atualizacao)
	
	For lvl_Linha = 1 To lvl_Linhas
		This.InsertRow(0)
		This.Object.mandt		[lvl_Linha] = lvds_log_fin.Object.mandt	[lvl_Linha]
		This.Object.werks		[lvl_Linha] = lvds_log_fin.Object.werks	[lvl_Linha]
		This.Object.cdsis		[lvl_Linha] = lvds_log_fin.Object.cdsis	[lvl_Linha]
		This.Object.nupdv		[lvl_Linha] = lvds_log_fin.Object.nupdv	[lvl_Linha]
		This.Object.tpopr		[lvl_Linha] = lvds_log_fin.Object.tpopr	[lvl_Linha]
		This.Object.mvend		[lvl_Linha] = lvds_log_fin.Object.mvend	[lvl_Linha]
		This.Object.dtopr		[lvl_Linha] = lvds_log_fin.Object.dtopr	[lvl_Linha]
		This.Object.ntran		[lvl_Linha] = lvds_log_fin.Object.ntran	[lvl_Linha]
		This.Object.serie		[lvl_Linha] = lvds_log_fin.Object.serie	[lvl_Linha]
		This.Object.seqnu		[lvl_Linha] = lvds_log_fin.Object.seqnu	[lvl_Linha]
		This.Object.finnu		[lvl_Linha] = lvds_log_fin.Object.finnu	[lvl_Linha]
		This.Object.cdfin		[lvl_Linha] = lvds_log_fin.Object.cdfin		[lvl_Linha]
		This.Object.pcela		[lvl_Linha] = lvds_log_fin.Object.pcela	[lvl_Linha]
		This.Object.qtdia		[lvl_Linha] = lvds_log_fin.Object.qtdia	[lvl_Linha]
		This.Object.zterm		[lvl_Linha] = lvds_log_fin.Object.zterm	[lvl_Linha]
		This.Object.vlrec		[lvl_Linha] = lvds_log_fin.Object.vlrec		[lvl_Linha] * -1
	//	This.Object.vltro		[lvl_Linha] = lvds_log_fin.Object.vltro		[lvl_Linha]
		This.Object.bnknu		[lvl_Linha] = lvds_log_fin.Object.bnknu	[lvl_Linha]
		This.Object.agnnu		[lvl_Linha] = lvds_log_fin.Object.agnnu	[lvl_Linha]
		This.Object.connu		[lvl_Linha] = lvds_log_fin.Object.connu	[lvl_Linha]
		This.Object.chqnu		[lvl_Linha] = lvds_log_fin.Object.chqnu	[lvl_Linha]
		This.Object.chqna		[lvl_Linha] = lvds_log_fin.Object.chqna	[lvl_Linha]
		This.Object.ccmc7		[lvl_Linha] = lvds_log_fin.Object.ccmc7	[lvl_Linha]
		This.Object.refbn		[lvl_Linha] = lvds_log_fin.Object.refbn 	[lvl_Linha]
		This.Object.refbl		[lvl_Linha] = lvds_log_fin.Object.refbl 	[lvl_Linha]
	//	This.Object.kunnr		[lvl_Linha] = lvds_log_fin.Object.kunnr 	[lvl_Linha]
		This.Object.stcd1		[lvl_Linha] = lvds_log_fin.Object.stcd1	[lvl_Linha]
		This.Object.stcd2		[lvl_Linha] = lvds_log_fin.Object.stcd2	[lvl_Linha]
		This.Object.stcd3		[lvl_Linha] = lvds_log_fin.Object.stcd3	[lvl_Linha]
		This.Object.cardn		[lvl_Linha] = lvds_log_fin.Object.cardn	[lvl_Linha]
		This.Object.nsuid		[lvl_Linha] = lvds_log_fin.Object.nsuid	[lvl_Linha]
		This.Object.cdaut		[lvl_Linha] = lvds_log_fin.Object.cdaut	[lvl_Linha]
		This.Object.dtpag		[lvl_Linha] = lvds_log_fin.Object.dtpag	[lvl_Linha]
		This.Object.hrpag		[lvl_Linha] = lvds_log_fin.Object.hrpag	[lvl_Linha]
		This.Object.obspg		[lvl_Linha] = lvds_log_fin.Object.obspg	[lvl_Linha]
	//	This.Object.nroad		[lvl_Linha] = lvds_log_fin.Object.nroad	[lvl_Linha]
		This.Object.taxad		[lvl_Linha] = lvds_log_fin.Object.taxad	[lvl_Linha] * -1
		This.Object.redad		[lvl_Linha] = lvds_log_fin.Object.redad	[lvl_Linha]
		This.Object.banad		[lvl_Linha] = lvds_log_fin.Object.banad	[lvl_Linha]
		This.Object.nucov		[lvl_Linha] = lvds_log_fin.Object.nucov	[lvl_Linha]
		This.Object.nacov		[lvl_Linha] = lvds_log_fin.Object.nacov	[lvl_Linha]
		This.Object.mcvdo		[lvl_Linha] = lvds_log_fin.Object.mcvdo	[lvl_Linha]
		This.Object.ncvdo		[lvl_Linha] = lvds_log_fin.Object.ncvdo	[lvl_Linha]
		This.Object.nrzae		[lvl_Linha] = lvds_log_fin.Object.nrzae	[lvl_Linha]
		This.Object.dtaut		[lvl_Linha] = lvds_log_fin.Object.dtaut	[lvl_Linha]
		This.Object.pctax		[lvl_Linha] = lvds_log_fin.Object.pctax	[lvl_Linha]
		This.Object.xref3		[lvl_Linha] = lvds_log_fin.Object.xref3	[lvl_Linha]
		This.Object.rbank		[lvl_Linha] = lvds_log_fin.Object.rbank	[lvl_Linha]
		This.Object.nrautcd	[lvl_Linha] = lvds_log_fin.Object.nrautcd	[lvl_Linha]
	Next
	
Catch (RuntimeError lvo_Erro)
	MessageBox('Erro',lvo_Erro.GetMessage(), StopSign!)
	This.Event ue_Reset()
	
Finally
	If IsValid(lvds_log_fin) Then Destroy(lvds_log_fin)
End Try

Return This.RowCount()
end event

event constructor;call super::constructor;This.ivi_tipo_cancelar = RETRIEVE

This.Of_SetRowSelection()
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	dw_3.Event ue_Retrieve()
End If 

This.Of_Set_Somente_Leitura( False )

Return AncestorReturnValue
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linhas
Long lvl_Linha

dw_1.AcceptText( )

lvl_Linhas = This.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	This.Object.cd_ambiente_sap	[lvl_Linha] = dw_1.Object.cd_ambiente_sap	[1]
	This.Object.werks					[lvl_Linha] = dw_1.Object.werks					[1]
	This.Object.cdsis					[lvl_Linha] = dw_1.Object.cdsis					[1]
	This.Object.nupdv					[lvl_Linha] = dw_1.Object.nupdv					[1]
	This.Object.tpopr					[lvl_Linha] = dw_1.Object.tpopr					[1]
	This.Object.mvend					[lvl_Linha] = dw_1.Object.mvend					[1]
	This.Object.dtopr					[lvl_Linha] = dw_1.Object.dtopr					[1]
	This.Object.ntran					[lvl_Linha] = dw_1.Object.ntran					[1]
	This.Object.serie					[lvl_Linha] = dw_1.Object.serie					[1]
	This.Object.seqnu					[lvl_Linha] = dw_1.Object.seqnu					[1]
Next

Return AncestorReturnValue
end event

type dw_3 from dc_uo_dw_base within w_ge471_troca_finalizadora
integer x = 82
integer y = 1228
integer width = 3415
integer height = 412
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge471_finalizadoras"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_updateable = true
end type

event constructor;call super::constructor;This.ivi_tipo_cancelar = RETRIEVE
This.Of_SetColSelection(True)
end event

event ue_recuperar;//Override
Long lvl_Linha
Long lvl_Linhas

Try
	This.Reset()
	If dw_2.Rowscopy(1, dw_2.RowCount(), Primary!, This, 1, Primary!) < 0 Then
		MessageBox("Falha", "Falha ao copiar o conte$$HEX1$$fa00$$ENDHEX$$do das finalizadoras para DW_3.", Exclamation!)
		Return 0
	End If
	
	//Pega o n$$HEX1$$fa00$$ENDHEX$$mero de linhas
	lvl_Linhas = This.RowCount()
	
	//Percorre os registros e inverte os valores
	For lvl_Linha = 1 To lvl_Linhas
		This.Object.vlrec	[lvl_Linha] = This.Object.vlrec	[lvl_Linha] * -1
		This.Object.taxad	[lvl_Linha] = This.Object.taxad	[lvl_Linha] * -1
	Next
	
Catch (RuntimeError lvo_Erro)
	
Finally
	//
End Try

Return This.RowCount()
end event

event itemchanged;call super::itemchanged;This.ivm_menu.mf_confirmar( True )
This.ivm_menu.mf_cancelar( True )

Choose Case Dwo.Name
	Case "cdfin"
		If Data = "" Then
			ivo_Finalizadora.of_inicializa( )
			This.Object.cdfin	[Row] = ivo_Finalizadora.cd_finalizadora
		Else
			If ivo_Finalizadora.Of_Localiza(Data) Then
				wf_altera_finalizadora(Row)
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Finalizadora n$$HEX1$$e300$$ENDHEX$$o encontrada na tabela HUBCFRM",Exclamation!)
				Return 1
			End If
		End If
	
End Choose
end event

event editchanged;call super::editchanged;This.ivm_menu.mf_confirmar( True )
This.ivm_menu.mf_cancelar( True )
end event

event ue_deleterow;call super::ue_deleterow;If This.RowCount()=0 Then
	This.Event Post ue_AddRow()
End If

Return True
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_cancelar(pl_linhas > 0)
This.ivm_menu.mf_confirmar(pl_linhas > 0)
This.ivm_menu.mf_incluir(True)
This.ivm_menu.mf_excluir(pl_linhas > 0)

Return pl_linhas
end event

event ue_addrow;call super::ue_addrow;Long lvl_Linha

lvl_Linha = This.RowCount()
This.Object.finnu	[ lvl_Linha ] = lvl_Linha
This.Object.vlrec	[ lvl_Linha ] = (dw_2.GetItemDecimal(1, "vl_total_rec") * -1) - This.GetItemDecimal(1, "vl_total_rec")

This.ivm_menu.mf_excluir(true)

Return AncestorReturnValue
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linhas
Long lvl_Linha

Long lvl_FinNu

dw_1.AcceptText( )
lvl_Linhas = This.RowCount()

//pega o maior sequencial de finalizadora da DW_2 (finalizadoras origem)
If dw_2.RowCount() > 0 Then lvl_FinNu = dw_2.Object.finnu [dw_2.RowCount()]

For lvl_Linha = 1 To lvl_Linhas
	//Incrementa 1 no sequencial das finalizadoras
	lvl_FinNu++
	This.Object.finnu					[lvl_Linha] = lvl_FinNu
	This.Object.cd_ambiente_sap	[lvl_Linha] = dw_1.Object.cd_ambiente_sap	[1]
	This.Object.werks					[lvl_Linha] = dw_1.Object.werks					[1]
	This.Object.cdsis					[lvl_Linha] = dw_1.Object.cdsis					[1]
	This.Object.nupdv					[lvl_Linha] = dw_1.Object.nupdv					[1]
	This.Object.tpopr					[lvl_Linha] = dw_1.Object.tpopr					[1]
	This.Object.mvend					[lvl_Linha] = dw_1.Object.mvend					[1]
	This.Object.dtopr					[lvl_Linha] = dw_1.Object.dtopr					[1]
	This.Object.ntran					[lvl_Linha] = dw_1.Object.ntran					[1]
	This.Object.serie					[lvl_Linha] = dw_1.Object.serie					[1]
	This.Object.seqnu					[lvl_Linha] = dw_1.Object.seqnu					[1]
Next

Return AncestorReturnValue
end event

type gb_hubt101 from groupbox within w_ge471_troca_finalizadora
integer x = 37
integer y = 16
integer width = 3511
integer height = 572
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Cabe$$HEX1$$e700$$ENDHEX$$alho"
borderstyle borderstyle = styleraised!
end type

type gb_fin_origem from groupbox within w_ge471_troca_finalizadora
integer x = 37
integer y = 616
integer width = 3511
integer height = 524
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Finalizadora(s) Original(is)"
borderstyle borderstyle = styleraised!
end type

type gb_fin_destino from groupbox within w_ge471_troca_finalizadora
integer x = 37
integer y = 1156
integer width = 3511
integer height = 528
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Finalizadora(s) Destino"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge471_troca_finalizadora
integer x = 82
integer y = 88
integer width = 3415
integer height = 492
boolean bringtotop = true
string dataobject = "dw_ge471_cabecalho"
boolean ivb_updateable = true
end type

event constructor;call super::constructor;This.ivi_tipo_cancelar = RETRIEVE
end event

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Linhas

Try
	//Limpa o datastore
	This.Reset()
	
	If IsNull(ivdc_Nr_Atualizacao) or gf_coalesce(ivdc_Nr_Atualizacao,0)=0 Then Return 0
	
	dc_uo_ds_base lvds_log
	lvds_log = Create dc_uo_ds_base
	If Not lvds_log.Of_Changedataobject("ds_ge471_cabecalho", False) Then
		MessageBox('Alerta',"N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel alterar o datastore para ds_ge471_cabecalho", Exclamation!)
		Return 0
	End If
	
	lvl_Linhas = lvds_log.Retrieve(ivdc_Nr_Atualizacao)
	
	If lvl_Linhas > 0 Then
		lvl_Linha = This.InsertRow(0)
		This.Object.cd_ambiente_sap [lvl_Linha] = lvds_log.Object.cd_ambiente_sap	[lvl_Linha]
		
		This.Object.mandt	[lvl_Linha] = lvds_log.Object.mandt	[lvl_Linha]
		This.Object.werks	[lvl_Linha] = lvds_log.Object.werks	[lvl_Linha]
		This.Object.cdsis	[lvl_Linha] = lvds_log.Object.cdsis		[lvl_Linha]
		This.Object.nupdv	[lvl_Linha] = lvds_log.Object.nupdv	[lvl_Linha]
		This.Object.tpopr	[lvl_Linha] = lvds_log.Object.tpopr		[lvl_Linha]
		This.Object.mvend	[lvl_Linha] = lvds_log.Object.mvend	[lvl_Linha]
		This.Object.dtopr	[lvl_Linha] = lvds_log.Object.dtopr		[lvl_Linha]
		This.Object.ntran	[lvl_Linha] = lvds_log.Object.ntran		[lvl_Linha]
		This.Object.serie	[lvl_Linha] = lvds_log.Object.serie		[lvl_Linha]
		This.Object.seqnu	[lvl_Linha] = lvds_log.Object.seqnu	[lvl_Linha]
	Else
		MessageBox("Falha", "Falha ao buscar os dados do log: "+String(ivdc_Nr_Atualizacao), Exclamation!)
	End If
	
Catch (RuntimeError lvo_Erro)
	MessageBox('Erro',lvo_Erro.GetMessage(), StopSign!)
	This.Event ue_Reset()
	
Finally
	If IsValid(lvds_log) Then Destroy(lvds_log)
End Try

Return This.RowCount()
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	dw_2.Event ue_Retrieve()
	This.Object.cdopr	[1] = gvo_aplicacao.ivo_seguranca.nr_matricula
End If 

Return AncestorReturnValue
end event

event ue_preupdate;call super::ue_preupdate;This.Object.qtfrm	[1] = dw_2.RowCount() + dw_3.RowCount()

Return AncestorReturnValue
end event

