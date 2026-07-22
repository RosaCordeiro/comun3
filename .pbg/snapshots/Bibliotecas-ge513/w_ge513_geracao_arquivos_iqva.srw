HA$PBExportHeader$w_ge513_geracao_arquivos_iqva.srw
forward
global type w_ge513_geracao_arquivos_iqva from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge513_geracao_arquivos_iqva
end type
type cb_gerar from commandbutton within w_ge513_geracao_arquivos_iqva
end type
type cb_sair from commandbutton within w_ge513_geracao_arquivos_iqva
end type
type cb_1 from commandbutton within w_ge513_geracao_arquivos_iqva
end type
type dw_2 from datawindow within w_ge513_geracao_arquivos_iqva
end type
type gb_1 from groupbox within w_ge513_geracao_arquivos_iqva
end type
end forward

global type w_ge513_geracao_arquivos_iqva from dc_w_response
integer width = 1541
integer height = 1332
string title = "GE513 - Gera$$HEX2$$e700e300$$ENDHEX$$o de Arquivos IQVIA"
boolean center = true
dw_1 dw_1
cb_gerar cb_gerar
cb_sair cb_sair
cb_1 cb_1
dw_2 dw_2
gb_1 gb_1
end type
global w_ge513_geracao_arquivos_iqva w_ge513_geracao_arquivos_iqva

type variables
String is_Arquivo_Excel
end variables

forward prototypes
public function boolean wf_valida_dados (ref string ps_log)
public function boolean wf_carrega_dados_excel_ole (string as_arquivo, ref long al_qt_linhas)
end prototypes

public function boolean wf_valida_dados (ref string ps_log);long ll_existe
date ldt_data, ldt_data_ate
string ls_exp_compra, ls_exp_venda, ls_exp_ticket
string ls_exp_estoque_cd, ls_exp_estoque_loja
string ls_exp_pedido_cd, ls_exp_pedido_loja
string ls_exp_entrada_cd, ls_exp_entrada_loja
String ls_exp_ims_health, ls_exp_closeup

ldt_data						= dw_1.object.dt_data			[1]
ldt_data_ate				= dw_1.object.dt_data_ate     [1]
ls_exp_compra			= dw_1.object.id_compra			[1]
ls_exp_venda				= dw_1.object.id_venda			[1]
ls_exp_ticket				= dw_1.object.id_ticket			[1]
ls_exp_estoque_cd		= dw_1.object.id_estoque_cd	[1]
ls_exp_estoque_loja	= dw_1.object.id_estoque_loja	[1]
ls_exp_pedido_cd		= dw_1.object.id_pedido_cd		[1]
ls_exp_pedido_loja		= dw_1.object.id_pedido_loja	[1]
ls_exp_entrada_cd		= dw_1.object.id_entrada_cd	[1]
ls_exp_entrada_loja		= dw_1.object.id_entrada_loja	[1]
ls_exp_ims_health       = dw_1.object.id_ims_health   [1]
ls_exp_closeup          = dw_1.object.id_closeup      [1]

if isnull(ldt_data) or ldt_data = date('01/01/1900') Then
	ps_log = 'Informe uma data para realizar a exporta$$HEX2$$e700e300$$ENDHEX$$o do arquivo.'
	dw_1.setcolumn('dt_data')
	dw_1.setfocus()
	return false
end if

If ls_exp_ims_health = 'S' or ls_exp_closeup = 'S' then
	If IsNull (ldt_data_ate) or ldt_data_ate = Date ('01/01/1900') then
		ldt_data_ate = ldt_data
		dw_1.object.dt_data_ate [1] = ldt_data_ate
	End if
End if
	
if ls_exp_compra			= 'N' and &
   ls_exp_venda			= 'N' and &
   ls_exp_ticket			= 'N' and &
   ls_exp_estoque_cd	= 'N' and ls_exp_estoque_loja	= 'N' and &
   ls_exp_pedido_cd		= 'N' and ls_exp_pedido_loja		= 'N' and &
   ls_exp_entrada_cd	= 'N' and ls_exp_entrada_loja	= 'N'and &
	ls_exp_ims_health      = 'N' and ls_exp_closeup = 'N' Then
	
	ps_log = 'Selecione um tipo de arquivo.'
	return false
end if

ll_existe = 0

if ls_exp_compra = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '014'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Compra. ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if

ll_existe=0

if ls_exp_venda = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '013'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Venda. ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if

ll_existe=0

if ls_exp_ticket = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '015'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Ticket. ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if

ll_existe=0

if ls_exp_estoque_cd = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '016'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Estoque (CD). ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if

ll_existe=0

if ls_exp_estoque_loja = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '017'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Estoque (Loja). ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if

ll_existe = 0

if ls_exp_pedido_cd = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '018'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Pedido (CD). ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if

ll_existe=0

if ls_exp_pedido_loja = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '019'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Pedido (Loja). ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if

ll_existe=0

if ls_exp_entrada_cd = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '020'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Entrada (CD). ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if

ll_existe=0

if ls_exp_entrada_loja = 'S' then
	
	Select count(*)
	into :ll_existe
	from controle_export_arq_periodo
	where cd_exportacao = '021'
	and dh_movimento = :ldt_data;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: wf_valida_dados ~nProblemas ao consultar a tabela "controle_export_arq_periodo": ~n~n' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		ps_log = 'Para a data informada ainda n$$HEX1$$e300$$ENDHEX$$o foi gerado um arquivo de Entrada (Loja). ~nDeve-se aguardar a exporta$$HEX2$$e700e300$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tica do arquivo.'
		return false
	end if
	
end if
return true
end function

public function boolean wf_carrega_dados_excel_ole (string as_arquivo, ref long al_qt_linhas);OLEObject excel

Integer li_RetValue, li_rtn
Boolean lb_sheet_rtn
Long ll_cnt, ll_xls_rows
Date	ldt_data_de

dw_2.reset()
dw_2.AcceptText()

SetPointer(HourGlass!)

If as_arquivo = '' Then Return False

excel = create OLEObject
li_rtn = excel.ConnectToNewObject("excel.application")
If li_rtn <> 0 Then
	MessageBox('Excel error','Erro ao iniciar aplica$$HEX2$$e700e300$$ENDHEX$$o excel.')
	Destroy excel
	Return False
End If

excel.WorkBooks.Open(as_arquivo)
excel.Application.Visible = false

lb_sheet_rtn = excel.worksheets(1).Activate

ll_xls_rows = excel.worksheets(1).Usedrange.rows.count

excel.Worksheets(1).Range("A1:B"+string(ll_xls_rows)).Copy

al_qt_linhas = dw_2.importclipboard()

excel.Application.Quit
excel.DisConnectObject()
DESTROY excel

If al_qt_linhas > 0 Then
	If not IsDate (dw_2.Object.de_data [1]) then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A primeira linha est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida. Favor corrigir a planilha e importar novamente.', Exclamation!)
		Return False
	else
		ldt_data_de = Date (dw_2.Object.de_data [1])
		If IsNull (ldt_data_de) or ldt_data_de = Date ('1900/01/01') then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A primeira data est$$HEX1$$e100$$ENDHEX$$ vazia. Favor corrigir a planilha e importar novamente.', Exclamation!)
			Return False
		else
			Return True
		End if
	End if
Else 
	Return False
End If
end function

on w_ge513_geracao_arquivos_iqva.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_gerar=create cb_gerar
this.cb_sair=create cb_sair
this.cb_1=create cb_1
this.dw_2=create dw_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_gerar
this.Control[iCurrent+3]=this.cb_sair
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.gb_1
end on

on w_ge513_geracao_arquivos_iqva.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_gerar)
destroy(this.cb_sair)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.insertrow(1)
SetNull(is_Arquivo_Excel)

dw_1.setcolumn('dt_data')
dw_1.setfocus()

cb_1.visible = True


end event

type pb_help from dc_w_response`pb_help within w_ge513_geracao_arquivos_iqva
end type

type dw_1 from dc_uo_dw_base within w_ge513_geracao_arquivos_iqva
integer x = 37
integer y = 60
integer width = 1408
integer height = 1036
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge513_geracao_arquivos_iqva"
end type

event constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type cb_gerar from commandbutton within w_ge513_geracao_arquivos_iqva
integer x = 672
integer y = 1116
integer width = 320
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar"
end type

event clicked;String	ls_log
long		ll_existe, ll_Qt_Linhas , ll_Linha
Date		ldt_data, ldt_data_ate
String	ls_exp_compra, ls_exp_venda, ls_exp_ticket
String 	ls_exp_estoque_cd, ls_exp_estoque_loja
String 	ls_exp_pedido_cd, ls_exp_pedido_loja
String 	ls_exp_entrada_cd, ls_exp_entrada_loja
String	ls_exp_ims_health, ls_exp_closeup
Boolean lb_Usa_Excel  = False  
String	ls_Parametro_Arquivo

ll_Qt_Linhas = 0 
uo_ge513_exporta_arquivos_farmacia luo_exportar

dw_1.accepttext( )
dw_2.accepttext( )

If Not IsNull(is_Arquivo_Excel) Then 	
		lb_Usa_Excel = True 
		ll_Qt_Linhas = dw_2.rowcount( )
End If 		

If ll_Qt_Linhas =0 Then 
	lb_Usa_Excel = False
	if Not parent.wf_valida_dados( ref ls_log ) then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
		return -1
	end if
End If 	

luo_exportar = Create uo_ge513_exporta_arquivos_farmacia

ldt_data						= dw_1.object.dt_data			[1]
ldt_data_ate				= dw_1.object.dt_data_ate     [1]
ls_exp_compra				= dw_1.object.id_compra			[1]
ls_exp_venda				= dw_1.object.id_venda			[1]
ls_exp_ticket				= dw_1.object.id_ticket			[1]
ls_exp_estoque_cd			= dw_1.object.id_estoque_cd	[1]
ls_exp_estoque_loja		= dw_1.object.id_estoque_loja	[1]
ls_exp_pedido_cd			= dw_1.object.id_pedido_cd		[1]
ls_exp_pedido_loja		= dw_1.object.id_pedido_loja	[1]
ls_exp_entrada_cd			= dw_1.object.id_entrada_cd	[1]
ls_exp_entrada_loja		= dw_1.object.id_entrada_loja	[1]
ls_exp_ims_health			= dw_1.object.id_ims_health	[1]
ls_exp_closeup				= dw_1.object.id_closeup		[1]

If ls_exp_ims_health = 'S' then
	If lb_Usa_Excel then
		For ll_Linha = 1 To ll_Qt_Linhas
			If Not IsDate (dw_2.Object.de_data [ll_Linha]) or Not IsDate (dw_2.Object.de_data_ate [ll_Linha]) then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Data inv$$HEX1$$e100$$ENDHEX$$lida na linha ' + String (ll_Linha) + ' da planilha', Exclamation!)
				Return -1
			End if
			
			ldt_data     = Date (dw_2.Object.de_data     [ll_Linha])
			ldt_data_ate = Date (dw_2.Object.de_data_ate [ll_Linha])
			
			If IsNull (ldt_data) then
				Continue
			End if
			
			If IsNull (ldt_data_ate) or ldt_data_ate < ldt_data then
				ldt_data_ate = ldt_data
			End if
			
			If Not luo_exportar.of_gera_arquivos ('011', ref ls_log, ldt_data, ldt_data_ate) then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				Return -1
			End if
		Next
	Else
		If Not luo_exportar.of_gera_arquivos ('011', ref ls_log, ldt_data, ldt_data_ate) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			Return -1
		End if
	End if
End if

If ls_exp_closeup = 'S' then
	If lb_Usa_Excel then
		For ll_Linha = 1 To ll_Qt_Linhas
			ldt_data     = Date (dw_2.Object.de_data     [ll_Linha])
			ldt_data_ate = Date (dw_2.Object.de_data_ate [ll_Linha])
			If Not luo_exportar.of_gera_arquivos ('012', ref ls_log, ldt_data, ldt_data_ate) then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				Return -1
			End if
		Next
	Else
		If Not luo_exportar.of_gera_arquivos ('012', ref ls_log, ldt_data, ldt_data_ate) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			Return -1
		End if
	End if
End if

If ls_exp_compra = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '014', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 
	Else
		If Not luo_exportar.of_exporta_iqva( '014', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		End If
	End If 	
End if

If ls_exp_venda = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '013', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 		
	Else
		If Not luo_exportar.of_exporta_iqva( '013', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		End If
	End If 	
End if

If ls_exp_ticket = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '015', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 		
	Else
		If Not luo_exportar.of_exporta_iqva( '015', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		End if
	End If 	
End if

If ls_exp_estoque_cd = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '016', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 		
	Else
		If Not luo_exportar.of_exporta_iqva( '016', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		End if
	End If 	
End if

If ls_exp_estoque_loja = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '017', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 
	Else
		If Not luo_exportar.of_exporta_iqva( '017', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		End if
	End If 
End if

If ls_exp_pedido_cd = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '018', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 		
	Else
		If Not luo_exportar.of_exporta_iqva( '018', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		End if
	End If 	
End if

If ls_exp_pedido_loja = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '019', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 		
	Else
		If Not luo_exportar.of_exporta_iqva( '019', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		End if
	End If 	
End if

If ls_exp_entrada_cd = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '020', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 		
	Else
		If Not luo_exportar.of_exporta_iqva( '020', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		end if
	End If 	
End if

If ls_exp_entrada_loja = 'S' then
	If lb_Usa_Excel Then 
		For ll_Linha = 1 To ll_Qt_Linhas
			 ldt_data =  Date(dw_2.Object.de_data[ll_Linha])
			 If Not luo_exportar.of_exporta_iqva( '021', ldt_data, ref ls_log ) Then
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
				return -1
			End if			
		Next 		
	Else
		If Not luo_exportar.of_exporta_iqva( '021', ldt_data, ref ls_log ) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
			return -1
		End if
	End If 	
End if

Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Arquivo(s) gerado(s) com sucesso.')
end event

type cb_sair from commandbutton within w_ge513_geracao_arquivos_iqva
integer x = 1019
integer y = 1116
integer width = 320
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Fechar"
boolean cancel = true
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_ge513_geracao_arquivos_iqva
boolean visible = false
integer x = 55
integer y = 1116
integer width = 434
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importa Datas"
end type

event clicked;Long ll_Qt_Linhas 

SetNull(is_Arquivo_Excel)

MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
				'Para os arquivos IMS HEALTH [11] e CLOSEUP [12], favor carregar um arquivo Excel com duas colunas ("A" e "B") ' + &
				'preenchidas com as datas de in$$HEX1$$ed00$$ENDHEX$$cio e fim de cada per$$HEX1$$ed00$$ENDHEX$$odo que deseja gerar o arquivo. ' + &
				'Se a coluna "B" n$$HEX1$$e300$$ENDHEX$$o estiver preenchida, ser$$HEX1$$e100$$ENDHEX$$ considerada a mesma data da coluna "A"' + '~n~n~r' + &
				'Para os demais casos, favor carregar um arquivo Excel com apenas a coluna "A" preenchida com as datas que deseja gerar o arquivo.' + '~n~n~r' + &
				'Todas as datas devem estar no formado DD/MM/AAAA.')

Open(w_ge513_importacao_datas)
is_Arquivo_Excel = Message.StringParm

If  (Trim(is_Arquivo_Excel) <> '' Or Not Isnull(is_Arquivo_Excel) ) And Len(is_Arquivo_Excel) > 3 Then 
	If Not wf_carrega_dados_excel_ole(is_Arquivo_Excel, Ref ll_Qt_Linhas) Then
		SqlCa.of_Rollback()
		Return 0
	End If 	
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'As Datas Foram Carregadas')
End If
			
Return 1 

end event

type dw_2 from datawindow within w_ge513_geracao_arquivos_iqva
boolean visible = false
integer x = 1650
integer y = 72
integer width = 581
integer height = 248
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge513_importa_datas_excel"
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_ge513_geracao_arquivos_iqva
integer x = 23
integer width = 1481
integer height = 1236
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

