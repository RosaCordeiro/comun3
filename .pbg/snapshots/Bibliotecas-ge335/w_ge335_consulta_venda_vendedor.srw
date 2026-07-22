HA$PBExportHeader$w_ge335_consulta_venda_vendedor.srw
forward
global type w_ge335_consulta_venda_vendedor from dc_w_selecao_lista_relatorio
end type
type cb_gerar_arquivo from commandbutton within w_ge335_consulta_venda_vendedor
end type
end forward

global type w_ge335_consulta_venda_vendedor from dc_w_selecao_lista_relatorio
integer width = 5093
integer height = 1768
string title = "GE335 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas por Vendedor"
long backcolor = 80269524
cb_gerar_arquivo cb_gerar_arquivo
end type
global w_ge335_consulta_venda_vendedor w_ge335_consulta_venda_vendedor

type variables
dc_uo_ds_base ivds_dev

uo_filial ivo_filial					//GE009
uo_vendedor ivo_vendedor		//GE013

Boolean ivb_Matriz		= True
Boolean ivb_Alerta_Data	= True
Boolean ivb_Aceita_Data = True
Boolean ivb_Gerar_Arquivo = False

Decimal idc_Total_Valor
Decimal idc_Total_Valor_Prestes

String ivs_Rede
String is_Usuario

dc_uo_transacao rubi

Integer ii_Timer = 20

Date ivdt_Periodo_De
Date ivdt_Periodo_Ate
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_vendedor ()
public subroutine wf_atualiza_devolucoes ()
public function string wf_retira_strings (string ps_char_delete, string ps_char_nova, string ps_string)
public subroutine wf_gerar_arquivo_total_filiais (dc_uo_ds_base pds_1)
public function boolean wf_gerar_arquivo_venda_vendedor (dc_uo_ds_base pds_1)
public function boolean wf_conecta_banco_rh ()
public subroutine wf_gerar_arquivo_txt (datastore ads)
public function string wf_valor (decimal adc_valor)
public function boolean wf_verifica_cpf_rubi (long pl_matricula, ref string ps_cpf)
public subroutine wf_calcula_periodo ()
public function string wf_get_periodo (string ps_tipo)
end prototypes

public subroutine wf_localiza_filial ();String lvs_Texto

lvs_Texto = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Texto)

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
	dw_1.Object.de_Filial	[1] = ivo_Filial.Nm_Fantasia	
End If
end subroutine

public subroutine wf_localiza_vendedor ();String lvs_Texto

lvs_Texto = dw_1.GetText()

ivo_vendedor.of_Localiza_Vendedor(lvs_Texto)

If ivo_Vendedor.Localizado Then
	dw_1.Object.Nr_Matricula_Vendedor	[1] = ivo_Vendedor.Nr_Matricula_Vendedor
	dw_1.Object.Nm_Usuario				[1] = ivo_Vendedor.Nm_Usuario
End If
end subroutine

public subroutine wf_atualiza_devolucoes ();dw_1.AcceptText()
dw_2.AcceptText()

Long lvl_Linha_Vendas, &
	  lvl_Linha, &
	  lvl_Find
	  
String lvs_Vendedor

lvl_Linha_Vendas = dw_2.RowCount()

Open(w_Aguarde)
w_Aguarde.uo_Progress.of_SetMax(lvl_Linha_Vendas)
w_Aguarde.Title = "Atualizando vendas, aguarde..."

For lvl_Linha = 1 To lvl_Linha_Vendas
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	
	lvs_Vendedor = dw_2.Object.Nr_Matricula_Vendedor[lvl_Linha]
	
	lvl_Find = ivds_Dev.Find("nr_matricula_vendedor = '" + lvs_Vendedor + "'" , 1, ivds_Dev.RowCount() )
	
	If lvl_Find <> 0 Then	
		dw_2.Object.Clientes	   		[lvl_Linha] = dw_2.Object.Clientes	 	[lvl_Linha] - ivds_Dev.Object.Clientes			[lvl_Find]
		dw_2.Object.Valor       		[lvl_Linha] = dw_2.Object.Valor      	[lvl_Linha] - ivds_Dev.Object.Vl_Comissao	[lvl_Find]
		dw_2.Object.Vl_Devolucao	[lvl_Linha] = ivds_Dev.Object.Vl_Devolucao[lvl_Find]	
		dw_2.Object.Valor_Prestes       	[lvl_Linha] = dw_2.Object.Valor_Prestes [lvl_Linha] - ivds_Dev.Object.Vl_Comissao_Prestes	[lvl_Find]
		dw_2.Object.Vl_Devolucao_Prestes [lvl_Linha] = ivds_Dev.Object.Vl_Devolucao_Prestes [lvl_Find]
	End If
Next

Close(w_Aguarde)
end subroutine

public function string wf_retira_strings (string ps_char_delete, string ps_char_nova, string ps_string);String lvs_limpo, &
       lvs_auxlimpo
		 
Integer lvi_posicao, &
        lvi_contador, &
		  lvi_ASC
		  
Boolean lvb_exist

lvi_ASC = AscA(ps_char_delete)

//Procura o caracter enter
lvi_posicao = PosA(ps_string,CharA(lvi_ASC))

//VerIfica se existe o caracter
If lvi_posicao > 0 and not isnull(lvi_posicao) Then
	lvb_exist = True
Else
	lvb_exist = False
	Return(ps_string)
End If

//A primeira vez, vai ser o valor do parametro
lvs_limpo = ps_string

//Rotina para retirar todos os caracteres lvl_ASC da string

DO WHILE lvb_exist = True
  lvs_auxlimpo = lvs_limpo
  lvi_posicao  = PosA(lvs_auxlimpo, CharA(lvi_ASC))
  
  If lvi_posicao > 0 and not isnull(lvi_posicao) Then
    lvs_limpo = ReplaceA (lvs_auxlimpo, lvi_posicao, 1, ps_char_nova)
  Else
    lvb_exist = False
End If

LOOP

//Retorna a string j$$HEX1$$e100$$ENDHEX$$ limpa
Return(lvs_limpo)
end function

public subroutine wf_gerar_arquivo_total_filiais (dc_uo_ds_base pds_1);Long lvl_Insert, &
     lvl_Filial
	  
String lvs_Nm_Fantasia

//Decimal{2}	lvdc_Valor		, &
//	        		lvdc_Vendas		, &
//			 	lvdc_Devolucao
			  
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Filial				= dw_1.Object.Cd_Filial[1]
lvs_Nm_Fantasia	= dw_1.Object.De_Filial[1]
//lvdc_Valor			= dw_2.Object.Sum_Valor		  	[dw_2.RowCount()]
//lvdc_Vendas			= dw_2.Object.Sum_Vl_Venda   	[dw_2.RowCount()]
//lvdc_Devolucao		= dw_2.Object.Sum_Vl_Devolucao[dw_2.RowCount()]

If idc_Total_Valor > 0 or idc_Total_Valor_Prestes > 0 Then
	lvl_Insert       = pds_1.InsertRow(0)
		
	pds_1.Object.Cd_Filial		[lvl_Insert] = lvl_Filial
	pds_1.Object.Nm_Fantasia	[lvl_Insert] = lvs_Nm_Fantasia
	pds_1.Object.Vl_Total    		[lvl_Insert] = idc_Total_Valor
	//pds_1.Object.Vl_Venda    	[lvl_Insert] = lvdc_Vendas
	//pds_1.Object.Vl_Devolucao[lvl_Insert] = lvdc_Devolucao
	
End If
end subroutine

public function boolean wf_gerar_arquivo_venda_vendedor (dc_uo_ds_base pds_1);Long lvl_Row, &
     lvl_Insert, &
	  lvl_Filial
	  
String lvs_Nm_Fantasia, &
       lvs_Nr_Matricula, &
		 lvs_Vendedor, &
		 lvs_CPF

Decimal{2} lvdc_Valor, &
           lvdc_Vendas,&	  
		     lvdc_Devolucao, &
			  lvdc_Valor_Prestes, &
           lvdc_Vendas_Prestes,&
		     lvdc_Devolucao_Prestes, &
			  lvdc_Valor_Liquido_Comissao
		 
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Filial				= dw_1.Object.Cd_Filial[1]
lvs_Nm_Fantasia	= dw_1.Object.De_Filial[1]

//Reinicia a var$$HEX1$$ed00$$ENDHEX$$avel que acumula o campo valor
idc_Total_Valor = 0.00
idc_Total_Valor_Prestes = 0.00

For lvl_Row = 1 To dw_2.RowCount()
	
	lvs_Nr_Matricula	= dw_2.Object.Nr_Matricula_Vendedor	[lvl_Row]
	lvs_Vendedor		= dw_2.Object.Nm_Usuario	   		 		[lvl_Row]
	lvdc_Valor			= dw_2.Object.Valor							[lvl_Row]
	lvdc_Vendas			= dw_2.Object.Vl_Venda						[lvl_Row]  
	lvdc_Devolucao		= dw_2.Object.Vl_Devolucao  		 		[lvl_Row]
	lvdc_Valor_Prestes          = dw_2.Object.Valor_Prestes        [lvl_Row]
	lvdc_Vendas_Prestes         = dw_2.Object.Vl_Venda_Prestes     [lvl_Row]  
	lvdc_Devolucao_Prestes      = dw_2.Object.Vl_Devolucao_Prestes [lvl_Row]
	lvdc_Valor_Liquido_Comissao = dw_2.Object.vl_liquido_comissao  [lvl_Row]

	If lvdc_Valor > 0 or lvdc_Valor_Prestes > 0 Then
		
		lvs_Cpf = ""
		
//		If Not wf_Verifica_CPF_Rubi(Long(lvs_Nr_Matricula), Ref lvs_CPF) Then Return False

		If dw_2.DataObject = "dw_ge335_lista_vendas_matriz" Then
			lvs_Cpf = dw_2.Object.nr_cpf	[lvl_Row]
		End If
		
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$c100$$ENDHEX$$", "A", lvs_Vendedor)
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$c900$$ENDHEX$$", "E", lvs_Vendedor)
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$cd00$$ENDHEX$$", "I", lvs_Vendedor)
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$d300$$ENDHEX$$", "O", lvs_Vendedor)
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$da00$$ENDHEX$$", "U", lvs_Vendedor)
		
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$c700$$ENDHEX$$", "C", lvs_Vendedor)
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$c300$$ENDHEX$$", "A", lvs_Vendedor)
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$d500$$ENDHEX$$", "0", lvs_Vendedor)
		
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$c200$$ENDHEX$$", "A", lvs_Vendedor)
		lvs_Vendedor = wf_Retira_Strings("$$HEX1$$ca00$$ENDHEX$$", "E", lvs_Vendedor)

		lvl_Insert = pds_1.InsertRow(0)
		
		pds_1.Object.Cd_Filial			[lvl_Insert] = lvl_Filial
		pds_1.Object.Nm_Fantasia		[lvl_Insert] = lvs_Nm_Fantasia
		pds_1.Object.Nr_Matricula		[lvl_Insert] = lvs_Nr_Matricula
		pds_1.Object.Nm_Vendedor	[lvl_Insert] = lvs_Vendedor
		pds_1.Object.Vl_Pagar			[lvl_Insert] = lvdc_Valor
		pds_1.Object.Nr_CPF			[lvl_Insert] = lvs_CPF
		pds_1.Object.Vl_Venda			[lvl_Insert] = lvdc_Vendas
		pds_1.Object.Vl_Devolucao		[lvl_Insert] = lvdc_Devolucao
		pds_1.Object.Vl_Pagar_Prestes     [lvl_Insert] = lvdc_Valor_Prestes
		pds_1.Object.Vl_Venda_Prestes     [lvl_Insert] = lvdc_Vendas_Prestes
		pds_1.Object.Vl_Devolucao_Prestes [lvl_Insert] = lvdc_Devolucao_Prestes
		pds_1.Object.vl_Pagar_Total       [lvl_Insert] = lvdc_Valor_Liquido_Comissao
		
		//Acumula o valor para mostrar no relat$$HEX1$$f300$$ENDHEX$$rio de totais
		idc_Total_Valor += lvdc_Valor_Liquido_Comissao
	End If
	
Next

Return True
end function

public function boolean wf_conecta_banco_rh ();Return gf_conecta_banco_rh(Rubi, "vetorh_ti")

//// Conex$$HEX1$$e300$$ENDHEX$$o com o banco Oracle - RH
//if Not(IsValid(gtr_RH)) Then gtr_RH = Create dc_uo_transacao
//
//If Not(gtr_RH.of_isconnected()) Then
//	w_Aguarde.Title = "Conectando ao banco de dados do RH ..."
//	gtr_RH.ivs_DataBase = "ORACLE_RH"
//	
//	If Not gtr_RH.of_Connect("vetorh_ti", "EX") Then
//		Close(w_Aguarde)
//		Return False
//	End If
//End If
//

//return true
end function

public subroutine wf_gerar_arquivo_txt (datastore ads);Boolean lvb_Sucesso = True

Decimal lvdc_Valor

Long lvl_Linhas,&
	 lvl_Linha
	
Integer lvi_Arquivo,&
	    lvi_Resp

String lvs_Nome_Arquivo,&
	   lvs_Matricula,&
	   lvs_Matricula_2,&
	   lvs_Empresa,&
	   lvs_Registro,&
	   lvs_Valor, &
	   lvs_Id_Fechamento
	 
lvl_Linhas = ads.RowCount()

lvs_Id_Fechamento = dw_1.Object.id_fechamento[1]

If lvs_Id_Fechamento = 'S' Then
	lvs_Nome_Arquivo	= gvo_Aplicacao.of_GetFromINI("Diretorio", "Comissao") + "VENDAS_VENDEDORES_"+wf_Get_Periodo('NOME')+".TXT"
Else
	lvs_Nome_Arquivo = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio") + "VENDAS_VENDEDORES_"+wf_Get_Periodo('NOME')+".TXT" 
End If

// Se existir o arquivo 
If FileExists(lvs_Nome_Arquivo) Then
	lvi_Resp = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Nome_Arquivo + "' existente ?", Question!, YesNo!)
	
	If lvi_Resp = 1 Then
		If Not FileDelete(lvs_Nome_Arquivo) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Nome_Arquivo + "'.", StopSign!)
			Return
		End If
	Else
		Return 
	End If
End If

lvi_Arquivo      = FileOpen(lvs_Nome_Arquivo, LineMode!, Write!, LockWrite!, Append!)

If lvi_Arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo '" + lvs_Nome_Arquivo + "'.", StopSign!)
	Return
End If

For lvl_Linha = 1 To lvl_Linhas
	
	lvdc_Valor = ads.Object.vl_pagar_total [lvl_Linha]
	lvs_Valor  = wf_Valor (lvdc_Valor)
	
	lvs_Matricula	= Trim(ads.Object.nr_matricula[lvl_Linha])
	lvs_Matricula_2	= MidA(lvs_Matricula, 1, 4)
	
//	If lvs_Matricula_2 = "5010" or lvs_Matricula_2 = "5020" or lvs_Matricula_2 = "5030" or lvs_Matricula_2 = "5040" Then
//		lvs_Empresa = "5"
//	Else
//		lvs_Empresa = "1"
//	End If
	
	lvs_Empresa = "1"
	
	lvs_Registro = lvs_Empresa + ";" + lvs_Matricula + ";" + lvs_Valor + ";"
		
	If FileWrite(lvi_Arquivo, lvs_Registro) = -1 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro no arquivo '" + lvs_Nome_Arquivo + "'.", StopSign!)
		lvb_Sucesso = False
		Exit
	End If
Next

FileClose(lvi_Arquivo)

If lvb_Sucesso Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi gravado com sucesso '" + lvs_Nome_Arquivo + "'.")
End If

end subroutine

public function string wf_valor (decimal adc_valor);String lvs_String,&
	   lvs_Valor

Integer lvi_Pos

lvs_String = String(adc_valor)

lvi_Pos = PosA(lvs_String, ",")

lvs_Valor = MidA(lvs_String, 1, lvi_Pos -1) + MidA(lvs_String, lvi_Pos + 1, LenA(lvs_String))

Return lvs_Valor


end function

public function boolean wf_verifica_cpf_rubi (long pl_matricula, ref string ps_cpf);Boolean lvb_Sucesso = True

select numcpf Into :ps_Cpf
from R034FUN
where numcad = :pl_Matricula
Using Rubi;

Choose Case SqlCa.SqlCode
	Case -1
		Rubi.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do CPF: " + ps_CPF)
		lvb_Sucesso = False
	Case 100
		ps_CPF = ""
End Choose

Return lvb_Sucesso
end function

public subroutine wf_calcula_periodo ();
If  Integer(String(Today(), "dd") )  < 29 Then
	ivdt_Periodo_De  = Date("26/" + String( RelativeDate(Today(),  - 30), "mm/yyyy"))
Else
	ivdt_Periodo_De  = Date("26/" + String( Today(), "mm/yyyy"))	
End If

ivdt_Periodo_Ate = Today()

dw_1.Object.Dt_Periodo_De		[1] = ivdt_Periodo_De
dw_1.Object.Dt_Periodo_Ate 	[1] = ivdt_Periodo_Ate
end subroutine

public function string wf_get_periodo (string ps_tipo);If ps_Tipo = 'LINHA' Then
	Return "Per$$HEX1$$ed00$$ENDHEX$$odo gerado de "+String(dw_1.GetItemDate(1, "dt_periodo_de"), "DD/MM/YYYY") + " a " + String(dw_1.GetItemDate(1, "dt_periodo_ate"), "DD/MM/YYYY")
Else
	Return String(dw_1.GetItemDate(1, "dt_periodo_de"), "DD_MM_YYYY") + "_A_" + String(dw_1.GetItemDate(1, "dt_periodo_ate"), "DD_MM_YYYY")
End If
end function

on w_ge335_consulta_venda_vendedor.create
int iCurrent
call super::create
this.cb_gerar_arquivo=create cb_gerar_arquivo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar_arquivo
end on

on w_ge335_consulta_venda_vendedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_gerar_arquivo)
end on

event close;call super::close;If IsValid( ivds_Dev ) 			Then Destroy(ivds_Dev)
If IsValid( ivo_Vendedor ) 	Then Destroy(ivo_Vendedor)
If IsValid( ivo_Filial ) 			Then Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;ivds_Dev 	 	= Create dc_uo_ds_base
ivo_Vendedor 	= Create uo_Vendedor
ivo_Filial   		= Create uo_Filial

wf_calcula_periodo()

ivm_Menu.mf_Recuperar(True)
ivm_Menu.ivb_Permite_Imprimir = True

If Not ivb_Matriz Then
	
	ivo_vendedor.of_Localiza_Codigo( is_Usuario )
	
	If Not ivo_vendedor.Localizado Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Vendedor n$$HEX1$$e300$$ENDHEX$$o localizado.")
		Close(This)
		Return
	End If
	
	dw_1.Object.Cd_Filial[1]      	= gvo_Parametro.of_Filial()
	dw_1.Object.De_Filial[1]      	= gvo_Parametro.Nm_Fantasia_Filial
	dw_1.Object.Cd_Filial.Protect 	= 1
	dw_1.Object.De_Filial.Protect 	= 1
	cb_gerar_arquivo.Visible      	= False
	dw_1.Object.id_beauty.visible = 1
	
	//Altera$$HEX2$$e700e300$$ENDHEX$$o Ref. Chamado: 93566
	dw_1.Object.nr_matricula_vendedor	[1]			= ivo_vendedor.nr_matricula_vendedor
	dw_1.Object.nm_usuario					[1]		= ivo_vendedor.nm_usuario
	dw_1.Object.nr_matricula_vendedor.Protect	= 1
	dw_1.Object.nm_usuario.Protect 					= 1
	Timer( ii_Timer, This )
Else
	dw_2.of_Changedataobject( "dw_ge335_lista_vendas_matriz" )
	dw_3.of_Changedataobject( "dw_ge335_relatorio_matriz" )
	
	dw_2.SetTransObject(SqlCa)
	dw_3.SetTransObject(SqlCa)	
	
	dw_2.of_SetRowSelection()
	dw_2.ShareData(dw_3)
			
End If
end event

event ue_preprint;call super::ue_preprint;dw_3.Object.St_Periodo.Text 	= STRING(dw_1.Object.dt_periodo_de [1], "DD/MM/YYYY") + " $$HEX1$$e000$$ENDHEX$$ " + STRING(dw_1.Object.dt_periodo_ate[1], "DD/MM/YYYY")
dw_3.Object.St_Filial.Text  		= dw_1.Object.de_filial[1] + " - (" + STRING(dw_1.Object.cd_filial[1]) + ")"

dw_3.Object.Vl_Total_Vendas.Text	   	= String(Dec(Round(dw_2.Object.Vl_Total_Vendas    	[1],2)))
dw_3.Object.Vl_Total_Devolucao.Text 	= String(Dec(Round(dw_2.Object.Vl_Total_Devolucao 	[1],2)))
dw_3.Object.Vl_Total_Liquido.Text   		= String(Dec(Round(dw_2.Object.Vl_Total_Liquido	 	[1],2)))
dw_3.Object.Total_Clientes.Text     		= String(dw_2.Object.Total_Cliente 	    						[1])
dw_3.Object.Vl_Total_Valor.Text     		= String(Dec(Round(dw_2.Object.Total_Valor	 	    		[1],2)))
dw_3.Object.Total_Produtos.Text     		= String(dw_2.Object.Total_Produtos	    						[1])
//Prestes:
dw_3.Object.Vl_Total_Vendas_Prestes.Text	  = String (Dec (Round(dw_2.Object.Vl_Total_Vendas_Prestes    [1], 2)))
dw_3.Object.Vl_Total_Devolucao_Prestes.Text = String (Dec (Round(dw_2.Object.Vl_Total_Devolucao_Prestes [1], 2)))
dw_3.Object.Vl_Total_Liquido_Prestes.Text   = String (Dec (Round(dw_2.Object.Vl_Total_Liquido_Prestes	  [1], 2)))
dw_3.Object.Vl_Total_Valor_Prestes.Text     = String (Dec (Round(dw_2.Object.Total_Valor_Prestes	 	  [1], 2)))
dw_3.Object.Total_Produtos_Prestes.Text     = String (dw_2.Object.Total_Produtos_Prestes	    			  [1])
dw_3.Object.Vl_Total_Liquido_Comissao.Text  = String (dw_2.Object.Vl_Total_Liquido_Comissao             [1])

Return AncestorReturnValue

end event

event timer;call super::timer;Return Close( This )
end event

event ue_preopen;call super::ue_preopen;If Not ivb_Matriz Then
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE335_CONSULTA_VENDA_VENDEDOR", ref is_Usuario ) Then 
		il_Retorno = -1
	End If
End If

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge335_consulta_venda_vendedor
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge335_consulta_venda_vendedor
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge335_consulta_venda_vendedor
integer x = 14
integer y = 400
integer width = 5019
integer height = 1144
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge335_consulta_venda_vendedor
integer x = 14
integer y = 0
integer width = 1911
integer height = 396
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge335_consulta_venda_vendedor
integer x = 27
integer y = 52
integer width = 1874
integer height = 312
string dataobject = "dw_ge335_selecao"
end type

event dw_1::ue_key;String lvs_Coluna

dw_1.AcceptText()

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "de_filial"
			wf_Localiza_Filial()
			
		Case "nm_usuario"
			wf_Localiza_Vendedor()
	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Integer lvi_Resp

If dwo.Name = "de_filial" Then
	If Data <> ivo_Filial.Nm_Fantasia Then Return 1
End If

If dwo.Name = "nm_usuario" Then
	
	If Data = "" OR IsNull(Data) Then 
		This.Object.Nr_Matricula_Vendedor[1] = ""
		Return 0
	End If
	
	If Data <> ivo_Vendedor.Nm_Usuario Then Return 1
End If



end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge335_consulta_venda_vendedor
integer x = 46
integer y = 476
integer width = 4960
integer height = 1016
string dataobject = "dw_ge335_lista_vendas"
borderstyle borderstyle = StyleBox!
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date lvdt_Inicio, &
	  lvdt_Termino, &
	  lvdh_Data_Minima
	  
Long lvl_Filial, &
	  lvl_Intervalo

Integer lvi_Resp

dw_1.AcceptText()

lvdt_Inicio  		= dw_1.Object.Dt_Periodo_De	[1]
lvdt_Termino	= dw_1.Object.Dt_Periodo_Ate	[1]
lvl_Filial   		= dw_1.Object.Cd_Filial	  		[1]

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event Ue_Pos(1, "dt_periodo_de")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event Ue_Pos(1, "dt_periodo_ate")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior ou igual a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event Ue_Pos(1, "dt_periodo_ate")
	Return -1
End If

If ivb_Alerta_Data = True Then
	If lvdt_Inicio <> ivdt_Periodo_De Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem certeza que deseja alterar o per$$HEX1$$ed00$$ENDHEX$$odo?", Question!, YesNo!) = 2 Then	
			dw_1.Object.Dt_Periodo_De		[1] = ivdt_Periodo_De
			dw_1.Object.Dt_Periodo_Ate	[1] = ivdt_Periodo_Ate
			dw_1.Event ue_Pos(1, "dt_periodo_de")
			ivb_Aceita_Data = False
			Return -1
		Else
			ivb_Aceita_Data = True
		End If
	Else
		If lvdt_Termino <>  ivdt_Periodo_Ate Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem certeza que deseja alterar o per$$HEX1$$ed00$$ENDHEX$$odo?", Question!, YesNo!) = 2 Then
				dw_1.Object.Dt_Periodo_De		[1] = ivdt_Periodo_De
				dw_1.Object.Dt_Periodo_Ate	[1] = ivdt_Periodo_Ate
				dw_1.Event ue_Pos(1, "dt_periodo_ate")
				ivb_Aceita_Data = False
				Return -1
			Else
				ivb_Aceita_Data = True
			End If
		Else
			ivb_Aceita_Data = True
		End If
	End If
End If

If IsNull(lvl_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial deve ser informada.")
	dw_1.Event Ue_Pos(1, "de_filial")
	Return -1
End If

If Not ivb_Matriz Then
	lvdh_Data_Minima = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -60)
	
	If lvdh_Data_Minima > lvdt_Inicio Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial deve ser maior ou igual a '" + String(lvdh_Data_Minima) + "'.")
		dw_1.Event ue_Pos(1, "dt_periodo_de")
		Return -1
	End If
	This.of_AppendWhere("v.id_mostrar_comissao = 'S'")

End If

This.SetRedraw(False)

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

String lvs_Vendedor,&
		lvs_Beauty

Date lvdt_Inicio, &
	  lvdt_Termino
	  
Long lvl_Filial

lvs_Vendedor 	= dw_1.Object.Nr_Matricula_Vendedor	[1]
lvdt_Inicio  		= dw_1.Object.Dt_Periodo_De 		   		[1]
lvdt_Termino 	= dw_1.Object.Dt_Periodo_Ate 			[1]
lvl_Filial	 		= Long(dw_1.Object.Cd_Filial				[1])
lvs_Beauty		= dw_1.Object.id_beauty					[1]

If lvs_Vendedor <> "" And Not IsNull(lvs_Vendedor) Then
	dw_2.of_AppendWhere("n.nr_matricula_vendedor = '" + lvs_Vendedor + "'")
End If

If lvs_Beauty = 'S' Then
	dw_2.of_AppendWhere("i.cd_produto in (select cd_produto from produto_geral where id_beauty = 'S')")
End If

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de vendas, aguarde..."

Return This.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Filial)
end event

event dw_2::ue_postretrieve;// OverRide

Boolean lvb_Classificar, &
            lvb_Filtrar, &
		  lvb_Localizar

If pl_Linhas <= 0 Then
	If ivb_Gerar_Arquivo = False Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
	Close(w_Aguarde)
Else	
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar     	= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)	

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de devolu$$HEX2$$e700f500$$ENDHEX$$es, aguarde..."
	dw_1.AcceptText()
	
	String lvs_Vendedor,&
			lvs_Beauty
	
	Date lvdt_Inicio, &
		  lvdt_Termino
		  
	Long lvl_Filial
	
	ivds_Dev.of_ChangeDataObject("dw_ge335_lista_devolucao")
	
	lvs_Vendedor 	= dw_1.Object.Nr_Matricula_Vendedor	[1]
	lvdt_Inicio  		= dw_1.Object.Dt_Periodo_De 		   		[1]
	lvdt_Termino 	= dw_1.Object.Dt_Periodo_Ate 			[1]
	lvl_Filial	 		= Long(dw_1.Object.Cd_Filial				[1])
	lvs_beauty		= dw_1.Object.id_beauty		 			[1]

	If lvs_Vendedor <> "" And Not IsNull(lvs_Vendedor) Then
		ivds_Dev.of_AppendWhere("n.nr_matricula_vendedor = '" + lvs_Vendedor + "'")
	End If
	
	If lvs_Beauty = 'S' Then
		ivds_Dev.of_AppendWhere("i.cd_produto in (select cd_produto from produto_geral where id_beauty = 'S')")
	End If
	
	ivds_Dev.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Filial)	
	
	wf_Atualiza_Devolucoes()
	
End If

This.SetRedraw(True)

If ivb_Matriz Then
	This.ivm_Menu.mf_Imprimir(True)
	This.ivm_Menu.mf_SalvarComo(True)
	This.ivm_Menu.mf_Classificar(lvb_Classificar)
	This.ivm_Menu.mf_Filtrar(lvb_Filtrar)
	This.ivm_Menu.mf_Localizar(lvb_Localizar)
Else
	This.ivm_Menu.mf_Imprimir(False)
	This.ivm_Menu.mf_SalvarComo(False)
	This.ivm_Menu.mf_Classificar( False )
	This.ivm_Menu.mf_Filtrar( False )	
	This.ivm_Menu.mf_Localizar(lvb_Localizar)
	Timer( ii_Timer )
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;Integer	li_recuo		//comprimento dos campos VALOR E PRODUTOS

Long	lvl_Filial, &
		lvl_Filial_Matriz
	
lvl_Filial			= gvo_Parametro.of_Filial()
lvl_Filial_Matriz	=  gvo_Parametro.of_Filial_Matriz()

If lvl_Filial <> lvl_Filial_Matriz Then
	ivb_Matriz = False
	
	uo_Parametro_Filial lvo_Parametro
	lvo_Parametro = Create uo_Parametro_Filial

	lvo_Parametro.of_Localiza_Parametro('ID_REDE_FILIAL', Ref ivs_Rede)

	Destroy(lvo_Parametro)
	
	If ivs_Rede = 'PP' Then
		dw_2.Modify('valor_t.Visible=0')
		dw_2.Modify('valor.Visible=0')
		dw_2.Modify('ln_valor.Visible=0')
		dw_2.Modify('total_valor.Visible=0')
		
		dw_2.Modify('qtde_t.Visible=0')
		dw_2.Modify('qtde.Visible=0')
		dw_2.Modify('ln_qtde.Visible=0')
		dw_2.Modify('total_produtos.Visible=0')
		
		dw_2.Modify('valor_prestes_t.Visible=0')
		dw_2.Modify('valor_prestes.Visible=0')
		dw_2.Modify('ln_valor_prestes.Visible=0')
		dw_2.Modify('total_valor_prestes.Visible=0')
		
		dw_2.Modify('qtde_prestes_t.Visible=0')
		dw_2.Modify('qtde_prestes.Visible=0')
		dw_2.Modify('ln_qtde_prestes.Visible=0')
		dw_2.Modify('total_produtos_prestes.Visible=0')
		
		dw_2.Modify('comissao_total_t.Visible=0')
		dw_2.Modify('vl_liquido_comissao.Visible=0')
		dw_2.Modify('ln_comissao_total.Visible=0')
		dw_2.Modify('vl_total_liquido_comissao.Visible=0')
		
		li_recuo = 30 + Integer (dw_2.Object.valor_t.Width) + Integer (dw_2.Object.qtde_t.Width)
		
		dw_2.Modify ('normais_t.Width = '              + String (Integer (dw_2.Object.normais_t.Width)              - li_recuo))
		dw_2.Modify ('ln_normais.X2 = '                + String (Integer (dw_2.Object.ln_normais.X2)                - li_recuo))
		
		li_recuo += 8
		
		dw_2.Modify ('prestes_t.Width = '              + String (Integer (dw_2.Object.prestes_t.Width)              - li_recuo))
		dw_2.Modify ('prestes_t.X = '                  + String (Integer (dw_2.Object.prestes_t.X)                  - li_recuo))
		dw_2.Modify ('ln_prestes.X1 = '                + String (Integer (dw_2.Object.ln_prestes.X1)                - li_recuo))
		dw_2.Modify ('ln_prestes.X2 = '                + String (Integer (dw_2.Object.ln_prestes.X2)                - (li_recuo * 2)))
		
		dw_2.Modify ('vl_venda_prestes_t.X = '         + String (Integer (dw_2.Object.vl_venda_prestes_t.X)         - li_recuo))
		dw_2.Modify ('ln_vendas_prestes.X1 = '         + String (Integer (dw_2.Object.ln_vendas_prestes.X1)         - li_recuo))
		dw_2.Modify ('ln_vendas_prestes.X2 = '         + String (Integer (dw_2.Object.ln_vendas_prestes.X2)         - li_recuo))
		dw_2.Modify ('vl_venda_prestes.X = '           + String (Integer (dw_2.Object.vl_venda_prestes.X)           - li_recuo))
		dw_2.Modify ('vl_total_vendas_prestes.X = '    + String (Integer (dw_2.Object.vl_total_vendas_prestes.X)    - li_recuo))
		
		dw_2.Modify ('vl_devolucao_prestes_t.X = '     + String (Integer (dw_2.Object.vl_devolucao_prestes_t.X)     - li_recuo))
		dw_2.Modify ('ln_vl_devolucao_prestes.X1 = '   + String (Integer (dw_2.Object.ln_vl_devolucao_prestes.X1)   - li_recuo))
		dw_2.Modify ('ln_vl_devolucao_prestes.X2 = '   + String (Integer (dw_2.Object.ln_vl_devolucao_prestes.X2)   - li_recuo))
		dw_2.Modify ('vl_devolucao_prestes.X = '       + String (Integer (dw_2.Object.vl_devolucao_prestes.X)       - li_recuo))
		dw_2.Modify ('vl_total_devolucao_prestes.X = ' + String (Integer (dw_2.Object.vl_total_devolucao_prestes.X) - li_recuo))
		
		dw_2.Modify ('total_vendas_prestes_t.X = '     + String (Integer (dw_2.Object.total_vendas_prestes_t.X)     - li_recuo))
		dw_2.Modify ('ln_total_vendas_prestes.X1 = '   + String (Integer (dw_2.Object.ln_total_vendas_prestes.X1)   - li_recuo))
		dw_2.Modify ('ln_total_vendas_prestes.X2 = '   + String (Integer (dw_2.Object.ln_total_vendas_prestes.X2)   - li_recuo))
		dw_2.Modify ('total_vendas_prestes.X = '       + String (Integer (dw_2.Object.total_vendas_prestes.X)       - li_recuo))
		dw_2.Modify ('vl_total_liquido_prestes.X = '   + String (Integer (dw_2.Object.vl_total_liquido_prestes.X)   - li_recuo))
		
		dw_2.Modify ('comissao_total_t.X = '           + String (Integer (dw_2.Object.comissao_total_t.X)           - li_recuo))
		dw_2.Modify ('ln_comissao_total.X1 = '         + String (Integer (dw_2.Object.ln_comissao_total.X1)         - li_recuo))
		dw_2.Modify ('ln_comissao_total.X2 = '         + String (Integer (dw_2.Object.ln_comissao_total.X2)         - li_recuo))
		dw_2.Modify ('vl_liquido_comissao.X = '        + String (Integer (dw_2.Object.vl_liquido_comissao.X)        - li_recuo))
		dw_2.Modify ('vl_total_liquido_comissao.X = '  + String (Integer (dw_2.Object.vl_total_liquido_comissao.X)  - li_recuo))
		
		dw_2.Width = dw_2.Width - ((li_recuo * 2) + Integer (dw_2.Object.comissao_total_t.Width))
		
		Parent.gb_2.Width = dw_2.Width + 70
		Parent.Width = gb_2.Width + 90
		
	End If	
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge335_consulta_venda_vendedor
integer x = 2757
integer y = 20
integer width = 434
integer height = 252
integer taborder = 50
string dataobject = "dw_ge335_relatorio"
end type

type cb_gerar_arquivo from commandbutton within w_ge335_consulta_venda_vendedor
integer x = 1943
integer y = 284
integer width = 485
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Gerar Arquivo"
end type

event clicked;Integer lvi_Row, &
        	  lvi_Filial, &
		  lvi_Linhas, &
		  lvi_retorno

Long lvl_Promocao

String lvs_Nm_Arquivo, &
		 lvs_Id_Fechamento

uo_Selecao_Filiais lvo_Filial
lvo_Filial = Create uo_Selecao_Filiais

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject("ds_ge335_gera_vendas_vendedor_arquivo") Then Return

dc_uo_ds_base lvds_2
lvds_2 = Create dc_uo_ds_base

If Not lvds_2.of_ChangeDataObject("ds_ge335_gera_vendas_total_arquivo") Then Return

OpenWithParm(w_ge044_selecao_filiais, lvo_Filial)

lvo_Filial = Message.PowerObjectParm

If IsNull(lvo_Filial) Then Return

//wf_Conecta_Banco_RH()

lvi_Linhas = UpperBound(lvo_Filial.Cd_Filial)
ivb_Gerar_Arquivo = True

For lvi_Row = 1 To lvi_Linhas
	
	lvi_Filial = lvo_Filial.Cd_Filial[lvi_Row]	
	dw_1.Object.Cd_Filial[1] = lvi_Filial
	dw_1.Object.De_Filial[1] = lvo_Filial.Nm_Fantasia[lvi_Row]
	
	If lvi_Filial = 534 Then Continue	
	
	dw_2.Event ue_Retrieve()
	ivb_Alerta_Data = False
	
	If ivb_Aceita_Data = False Then
		ivb_Alerta_Data = True
		Return
	End If
	
	If dw_2.RowCount() > 0 Then
		
		wf_Gerar_Arquivo_Venda_Vendedor(lvds_1)
		wf_Gerar_Arquivo_Total_Filiais (lvds_2)
		
	End If	
Next
ivb_Alerta_Data = True 

lvs_Nm_Arquivo = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If lvds_1.RowCount() > 0 Then
	// Insere uma linha com o per$$HEX1$$ed00$$ENDHEX$$odo
	lvds_1.InsertRow(1)
	lvds_1.SetItem(1, "nm_fantasia", wf_Get_Periodo('LINHA'))
	
	// Salva o XLS
	lvds_1.of_SaveAs(lvs_Nm_Arquivo + "VENDAS_VENDEDORES_"+wf_Get_Periodo('NOME')+".XLS")

	// Remove a linha com o per$$HEX1$$ed00$$ENDHEX$$odo para n$$HEX1$$e300$$ENDHEX$$o sair no TXT
	lvds_1.RowsDiscard(1, 1, Primary!)
	
	wf_gerar_arquivo_txt(lvds_1)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para gerar o arquivo 'VENDAS_VENDEDORES_"+wf_Get_Periodo('NOME')+".XLS'.")
End If

If lvds_2.RowCount() > 0 Then
	// Insere uma linha com o per$$HEX1$$ed00$$ENDHEX$$odo
	lvds_2.InsertRow(1)
	lvds_2.SetItem(1, "nm_fantasia", wf_Get_Periodo('LINHA'))
	
	// Salva o XLS
	lvds_2.of_SaveAs(lvs_Nm_Arquivo + "TOTAIS_VENDAS_FILIAIS_"+wf_Get_Periodo('NOME')+".XLS")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para gerar o arquivo 'TOTAIS_VENDAS_FILIAIS_"+wf_Get_Periodo('NOME')+".XLS'.")
End If

ivb_Aceita_Data = False
ivb_Gerar_Arquivo = False
Destroy(lvo_Filial)
Destroy(lvds_1)
Destroy(lvds_2)


end event

