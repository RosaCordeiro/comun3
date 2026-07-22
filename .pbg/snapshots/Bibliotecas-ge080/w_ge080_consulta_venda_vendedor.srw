HA$PBExportHeader$w_ge080_consulta_venda_vendedor.srw
forward
global type w_ge080_consulta_venda_vendedor from dc_w_selecao_lista_relatorio
end type
type cb_gerar_arquivo from commandbutton within w_ge080_consulta_venda_vendedor
end type
end forward

global type w_ge080_consulta_venda_vendedor from dc_w_selecao_lista_relatorio
integer width = 3305
integer height = 1684
string title = "GE080 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas por Vendedor"
long backcolor = 80269524
cb_gerar_arquivo cb_gerar_arquivo
end type
global w_ge080_consulta_venda_vendedor w_ge080_consulta_venda_vendedor

type variables
dc_uo_ds_base ivds_dev

uo_filial ivo_filial					//GE009
uo_vendedor ivo_vendedor		//GE013

Boolean ivb_Matriz		= True

String ivs_Rede

dc_uo_transacao rubi

Integer ii_Timer = 20
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
end prototypes

public subroutine wf_localiza_filial ();String lvs_Texto

lvs_Texto = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Texto)

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	dw_1.Object.de_Filial[1] = ivo_Filial.Nm_Fantasia	
End If
end subroutine

public subroutine wf_localiza_vendedor ();String lvs_Texto

lvs_Texto = dw_1.GetText()

ivo_vendedor.of_Localiza_Vendedor(lvs_Texto)

If ivo_Vendedor.Localizado Then
	dw_1.Object.Nr_Matricula_Vendedor[1] = ivo_Vendedor.Nr_Matricula_Vendedor
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
		dw_2.Object.Clientes	   [lvl_Linha] = dw_2.Object.Clientes	 [lvl_Linha] - ivds_Dev.Object.Clientes	[lvl_Find]
		dw_2.Object.Valor       [lvl_Linha] = dw_2.Object.Valor      [lvl_Linha] - ivds_Dev.Object.Vl_Comissao[lvl_Find]
		dw_2.Object.Vl_Devolucao[lvl_Linha] = ivds_Dev.Object.Vl_Devolucao[lvl_Find]	
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
	  
String lvs_Nm_Fantasia, &
       lvs_Nr_Matricula

Decimal{2} lvdc_Valor, &
	        lvdc_Vendas,&
			  lvdc_Devolucao
			  
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Filial       = dw_1.Object.Cd_Filial[1]
lvs_Nm_Fantasia  = dw_1.Object.De_Filial[1]
lvdc_Valor       = dw_2.Object.Sum_Valor		  [dw_2.RowCount()]
lvdc_Vendas      = dw_2.Object.Sum_Vl_Venda    [dw_2.RowCount()]
lvdc_Devolucao   = dw_2.Object.Sum_Vl_Devolucao[dw_2.RowCount()]

If lvdc_Valor > 0 Then
	lvl_Insert       = pds_1.InsertRow(0)
		
	pds_1.Object.Cd_Filial   [lvl_Insert] = lvl_Filial
	pds_1.Object.Nm_Fantasia [lvl_Insert] = lvs_Nm_Fantasia
	pds_1.Object.Vl_Total    [lvl_Insert] = lvdc_Valor
	//pds_1.Object.Vl_Venda    [lvl_Insert] = lvdc_Vendas
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
		     lvdc_Devolucao
		 
dw_1.AcceptText()
dw_2.AcceptText()

lvl_Filial       = dw_1.Object.Cd_Filial[1]
lvs_Nm_Fantasia  = dw_1.Object.De_Filial[1]

For lvl_Row = 1 To dw_2.RowCount()
	
	lvs_Nr_Matricula = dw_2.Object.Nr_Matricula_Vendedor[lvl_Row]
	lvs_Vendedor     = dw_2.Object.Nm_Usuario	   		 [lvl_Row]
	lvdc_Valor       = dw_2.Object.Valor					 [lvl_Row]
	lvdc_Vendas      = dw_2.Object.Vl_Venda        		 [lvl_Row]  
	lvdc_Devolucao   = dw_2.Object.Vl_Devolucao  		 [lvl_Row]

	If lvdc_Valor > 0 Then
		
		lvs_Cpf = ""
		
		If Not wf_Verifica_CPF_Rubi(Long(lvs_Nr_Matricula), Ref lvs_CPF) Then Return False
		
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
		
		pds_1.Object.Cd_Filial   [lvl_Insert] = lvl_Filial
		pds_1.Object.Nm_Fantasia [lvl_Insert] = lvs_Nm_Fantasia
		pds_1.Object.Nr_Matricula[lvl_Insert] = lvs_Nr_Matricula
		pds_1.Object.Nm_Vendedor [lvl_Insert] = lvs_Vendedor
		pds_1.Object.Vl_Pagar    [lvl_Insert] = lvdc_Valor
		pds_1.Object.Nr_CPF      [lvl_Insert] = lvs_CPF
		pds_1.Object.Vl_Venda    [lvl_Insert] = lvdc_Vendas
		pds_1.Object.Vl_Devolucao[lvl_Insert] = lvdc_Devolucao
	End If
	
Next

Return True
end function

public function boolean wf_conecta_banco_rh ();Rubi = Create dc_uo_transacao
Rubi.ivs_DataBase = 'ORACLE_RH'

If Not Rubi.of_connect('vetorh_ti', gvo_Aplicacao.ivo_Seguranca.Cd_Sistema) Then
   Destroy(Rubi)
   Return False
End If

Return True
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
	   lvs_Valor
	 
lvl_Linhas = ads.RowCount()

lvs_Nome_Arquivo = "C:\SISTEMAS\CR\ARQUIVOS\VENDAS_VENDEDORES.TXT" 

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
	
	lvdc_Valor 		= ads.Object.vl_pagar[lvl_Linha]
	lvs_Valor		= wf_Valor(lvdc_Valor)
	lvs_Matricula	= Trim(ads.Object.nr_matricula[lvl_Linha])
	lvs_Matricula_2 = MidA(lvs_Matricula, 1, 4)
	
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

on w_ge080_consulta_venda_vendedor.create
int iCurrent
call super::create
this.cb_gerar_arquivo=create cb_gerar_arquivo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar_arquivo
end on

on w_ge080_consulta_venda_vendedor.destroy
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


dw_1.Object.Dt_Periodo_De [1] = Today()
dw_1.Object.Dt_Periodo_Ate[1] = Today()

ivm_Menu.mf_Recuperar(True)
ivm_Menu.ivb_Permite_Imprimir = True

If Not ivb_Matriz Then
	
	ivo_vendedor.of_Localiza_Codigo( is_Matricula_Abertura_Tela )
	
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
	dw_1.Object.id_beauty.visible 	= 1
	
	//Altera$$HEX2$$e700e300$$ENDHEX$$o Ref. Chamado: 93566
	dw_1.Object.nr_matricula_vendedor	[1]			= ivo_vendedor.nr_matricula_vendedor
	dw_1.Object.nm_usuario					[1]			= ivo_vendedor.nm_usuario
	dw_1.Object.nr_matricula_vendedor.Protect	= 1
	dw_1.Object.nm_usuario.Protect 					= 1
	
	Timer( ii_Timer, This )
		
End If
end event

event ue_preprint;call super::ue_preprint;dw_3.Object.St_Periodo.Text 	= STRING(dw_1.Object.dt_periodo_de [1], "DD/MM/YYYY") + " at$$HEX1$$e900$$ENDHEX$$: " + STRING(dw_1.Object.dt_periodo_ate[1], "DD/MM/YYYY")
dw_3.Object.St_Filial.Text  		= dw_1.Object.de_filial[1] + " - (" + STRING(dw_1.Object.cd_filial[1]) + ")"

dw_3.Object.Vl_Total_Vendas.Text	   	= String(Dec(Round(dw_2.Object.Vl_Total_Vendas    	[1],2)))
dw_3.Object.Vl_Total_Devolucao.Text 	= String(Dec(Round(dw_2.Object.Vl_Total_Devolucao 	[1],2)))
dw_3.Object.Vl_Total_Liquido.Text   		= String(Dec(Round(dw_2.Object.Vl_Total_Liquido	 	[1],2)))
dw_3.Object.Total_Clientes.Text     		= String(dw_2.Object.Total_Cliente 	    						[1])
dw_3.Object.Vl_Total_Valor.Text     		= String(Dec(Round(dw_2.Object.Total_Valor	 	    		[1],2)))
dw_3.Object.Total_Produtos.Text     		= String(dw_2.Object.Total_Produtos	    						[1])

Return AncestorReturnValue

end event

event timer;call super::timer;Return Close( This )
end event

event ue_preopen;call super::ue_preopen;If Not ivb_Matriz Then
	If Not This.ib_Solicitou_Liberacao_Procedimento_Base  Then
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE080_CONSULTA_VENDA_VENDEDOR", ref is_Matricula_Abertura_Tela) Then 
			This.il_Retorno = -1
			Return
		End If
	End If
End If
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge080_consulta_venda_vendedor
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge080_consulta_venda_vendedor
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge080_consulta_venda_vendedor
integer x = 14
integer y = 340
integer width = 3223
integer height = 1132
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge080_consulta_venda_vendedor
integer x = 14
integer y = 0
integer width = 1911
integer height = 336
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge080_consulta_venda_vendedor
integer x = 27
integer y = 52
integer width = 1874
integer height = 256
string dataobject = "dw_ge080_selecao"
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

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_filial" Then
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

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge080_consulta_venda_vendedor
integer x = 46
integer y = 396
integer width = 3163
integer height = 1040
string dataobject = "dw_ge080_lista_vendas"
end type

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

String lvs_Vendedor,&
		lvs_Beauty

Date lvdt_Inicio, &
	  lvdt_Termino, &
	  lvdh_Data_Minima
	  
Long lvl_Filial
Long lvl_Intervalo

dw_1.AcceptText()

lvs_Vendedor 	= dw_1.Object.Nr_Matricula_Vendedor	[1]
lvdt_Inicio  		= dw_1.Object.Dt_Periodo_De 		   		[1]
lvdt_Termino 	= dw_1.Object.Dt_Periodo_Ate 			[1]
lvl_Filial	 		= Long(dw_1.Object.Cd_Filial				[1])
lvs_Beauty		= dw_1.Object.id_beauty					[1]

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

If IsNull(lvl_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial deve ser informada.")
	dw_1.Event Ue_Pos(1, "de_filial")
	Return -1
End If

If Not ivb_Matriz Then
	lvdh_Data_Minima = gf_primeiro_dia_mes( Date(gvo_Parametro.of_Dh_Movimentacao()) )
	
	lvdh_Data_Minima = RelativeDate( lvdh_Data_Minima, -365)
	
	If lvdh_Data_Minima > lvdt_Inicio Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial deve ser maior ou igual a '" + String(lvdh_Data_Minima) + "'.")
		dw_1.Event ue_Pos(1, "dt_periodo_de")
		Return -1
	End If
	
	This.of_AppendWhere("v.id_mostrar_comissao = 'S'")

End If

If lvs_Vendedor <> "" And Not IsNull(lvs_Vendedor) Then
	dw_2.of_AppendWhere("n.nr_matricula_vendedor = '" + lvs_Vendedor + "'")
End If

If lvs_Beauty = 'S' Then
	dw_2.of_AppendWhere("i.cd_produto in (select cd_produto from produto_geral where id_beauty = 'S')")
End If

This.SetRedraw(False)

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de vendas, aguarde..."

Return This.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Filial)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas <= 0 Then
	Close(w_Aguarde)
Else	
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de devolu$$HEX2$$e700f500$$ENDHEX$$es, aguarde..."
	
	dw_1.AcceptText()
	
	String lvs_Vendedor,&
			lvs_Beauty
	
	Date lvdt_Inicio, &
		  lvdt_Termino
		  
	Long lvl_Filial
	
	ivds_Dev.of_ChangeDataObject("dw_ge080_lista_devolucao")
	
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
Else
	This.ivm_Menu.mf_Classificar( False )
	This.ivm_Menu.mf_Filtrar( False )
	This.ivm_Menu.mf_Imprimir(False)
	This.ivm_Menu.mf_SalvarComo(False)
	Timer( ii_Timer )
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;Long	lvl_Filial, &
		lvl_Filial_Matriz
	
lvl_Filial			= gvo_Parametro.of_Filial()
lvl_Filial_Matriz	=  gvo_Parametro.of_Filial_Matriz()

If lvl_Filial <> lvl_Filial_Matriz Then
	ivb_Matriz = False
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge080_consulta_venda_vendedor
integer x = 2757
integer y = 20
integer width = 434
integer height = 252
integer taborder = 50
string dataobject = "dw_ge080_relatorio"
end type

type cb_gerar_arquivo from commandbutton within w_ge080_consulta_venda_vendedor
integer x = 2016
integer y = 24
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
		  lvi_Linhas

Long lvl_Promocao

String lvs_Nm_Arquivo

uo_Selecao_Filiais lvo_Filial
lvo_Filial = Create uo_Selecao_Filiais

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject("ds_ge080_gera_vendas_vendedor_arquivo") Then Return

dc_uo_ds_base lvds_2
lvds_2 = Create dc_uo_ds_base

If Not lvds_2.of_ChangeDataObject("ds_ge080_gera_vendas_total_arquivo") Then Return

OpenWithParm(w_ge044_selecao_filiais, lvo_Filial)

lvo_Filial = Message.PowerObjectParm

If IsNull(lvo_Filial) Then Return

If Not wf_Conecta_Banco_RH() Then Return

lvi_Linhas = UpperBound(lvo_Filial.Cd_Filial)

For lvi_Row = 1 To lvi_Linhas
	
	lvi_Filial = lvo_Filial.Cd_Filial[lvi_Row]
	
	If lvi_Filial = 534 Then Continue
	
	dw_1.Object.Cd_Filial[1] = lvi_Filial
	dw_1.Object.De_Filial[1] = lvo_Filial.Nm_Fantasia[lvi_Row]
	
	dw_2.Event ue_Retrieve()
	
	If dw_2.RowCount() > 0 Then
		
		wf_Gerar_Arquivo_Venda_Vendedor(lvds_1)
		wf_Gerar_Arquivo_Total_Filiais (lvds_2)
		
	End If	
Next

// gnv_app.of_GetFromINI("Diretorio", "Diretorio")

/* Foi colocado o caminho fixo, pq esta mesma janela $$HEX1$$e900$$ENDHEX$$ executada na loja. Um sistema classe nova e outra classe
   antiga. Quando o CR estiver com a classe nova poder$$HEX1$$e100$$ENDHEX$$ ser utilizada a fun$$HEX2$$e700e300$$ENDHEX$$o da aplica$$HEX2$$e700e300$$ENDHEX$$o.
*/
   
lvs_Nm_Arquivo = "C:\SISTEMAS\CR\ARQUIVOS\"

If lvds_1.RowCount() > 0 Then
	lvds_1.of_SaveAs(lvs_Nm_Arquivo + "VENDAS_VENDEDORES.XLS")
	wf_gerar_arquivo_txt(lvds_1)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para gerar o arquivo 'VENDAS_VENDEDORES.XLS'.")
End If

If lvds_2.RowCount() > 0 Then
	lvds_2.of_SaveAs(lvs_Nm_Arquivo + "TOTAIS_VENDAS_FILIAIS.XLS")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para gerar o arquivo 'TOTAIS_VENDAS_FILIAIS.XLS'.")
End If

Destroy(lvo_Filial)
Destroy(lvds_1)
Destroy(lvds_2)


end event

