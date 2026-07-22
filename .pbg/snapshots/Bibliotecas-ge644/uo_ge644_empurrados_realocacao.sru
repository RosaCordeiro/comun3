HA$PBExportHeader$uo_ge644_empurrados_realocacao.sru
forward
global type uo_ge644_empurrados_realocacao from nonvisualobject
end type
end forward

global type uo_ge644_empurrados_realocacao from nonvisualobject
end type
global uo_ge644_empurrados_realocacao uo_ge644_empurrados_realocacao

forward prototypes
public function boolean of_consulta_parametro_dias (ref integer as_dias_empurados, ref string as_erro)
public function boolean of_principal ()
public function boolean of_dias_consulta (integer as_dias_empurrados, date adt_data, ref date adt_datas_consulta[])
public function boolean of_envia_email_log (string as_erro, long al_filial, string as_processo)
public function boolean of_envia_email_cancelamento (long al_nr_pedido_empurrado[], long al_filial, date adh_inicio, date adh_fim)
public function boolean of_envia_email_reprocessamento (long al_nr_pedido_empurrado[], long al_filial, date adh_inicio, date adh_fim)
end prototypes

public function boolean of_consulta_parametro_dias (ref integer as_dias_empurados, ref string as_erro);select vl_parametro
Into :as_dias_empurados
	from parametro_geral 
	where cd_parametro = 'DIAS_REALOCACAO_EMPURRADOS'
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro "
		Return False
	
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro " + SqlCa.SqlErrText
		Return False
		
	Case 0 
		Return True
End Choose
end function

public function boolean of_principal ();Boolean	lb_Resultado

Integer	ll_Dias_empurados
Integer	ll_Count_dias_uteis

Datetime	ldh_Emissao
Datetime	ldh_Inclusao

Date 		ldt_Pedidos_cancelados
Date		ldt_Hoje
Date		ldt_Datas_consulta []
Date		ldt_Data
Date		ldt_Inicio_Reativacao

Long		ll_Linha
Long		ll_Linhas
Long		ll_Cd_filial
Long		ll_Nr_pedido_empurrado
Long		ll_Cd_filial_ant
Long 		ll_Nr_pedidos_array[]
Long		ll_Null_array[]

String	ls_Situacao
String	ls_Processado
String	ls_Erro
String	ls_situacao_ant

ldt_hoje = Date(gf_GetServerDate())

If Not gf_verifica_dias_uteis(1, ldt_hoje, lb_resultado)  Then
	of_envia_email_log ('N$$HEX1$$e300$$ENDHEX$$o foi possivel fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o dos dias uteis',0,'gf_verifica_dias_uteis')
	Return False
End if

If lb_resultado = False Then
	Return false
End if

If Not of_consulta_parametro_dias(ref ll_dias_empurados, ref ls_erro) Then
	of_envia_email_log (ls_erro,0,'of_consulta_parametro_dias')
	Return False
End if

ldt_data = ldt_hoje
ll_Count_dias_uteis = 0  

Do while ll_Count_dias_uteis <= ll_dias_empurados
	
	If Not gf_verifica_dias_uteis(1, ldt_data, lb_resultado)  Then
		of_envia_email_log ('N$$HEX1$$e300$$ENDHEX$$o foi possivel fazer a verifica$$HEX2$$e700e300$$ENDHEX$$o dos dias uteis',0,'gf_verifica_dias_uteis')
		Return False
	End if	
	
	If lb_resultado = True Then
		ldt_datas_consulta[UpperBound(ldt_datas_consulta) + 1] = ldt_data
		ll_Count_dias_uteis ++  
	End If
	
	ldt_data = RelativeDate(ldt_data, -1)
Loop

ldt_Inicio_Reativacao	= ldt_datas_consulta[UpperBound(ldt_datas_consulta)]
ldt_Pedidos_cancelados	= RelativeDate(ldt_Inicio_Reativacao, -1)

dc_uo_ds_base lds_empurrados
lds_empurrados = Create dc_uo_ds_base
lds_empurrados.Of_ChangeDataObject('ds_ge644_pedido_empurrado_realocacao')
lds_empurrados.Retrieve(ldt_Pedidos_cancelados,ldt_hoje)

ll_Linhas = lds_empurrados.RowCount()

For ll_Linha = 1 To ll_Linhas
	
	ll_Cd_filial					= lds_empurrados.Object.cd_filial							[ll_Linha]
	ll_Nr_pedido_empurrado	= lds_empurrados.Object.nr_pedido_empurrado		[ll_Linha]
	ls_Situacao					= lds_empurrados.Object.id_situacao						[ll_Linha]
	ls_Processado				= lds_empurrados.Object.id_processado					[ll_Linha]
	ldh_Emissao					= lds_empurrados.Object.dh_emissao					[ll_Linha]
	ldh_Inclusao					= lds_empurrados.Object.dh_inclusao					[ll_Linha]	
		
	If date(ldh_Emissao) > ldt_Pedidos_cancelados Then
		lds_empurrados.SetItem(ll_Linha, "id_processado", "N")
		lds_empurrados.SetItem(ll_Linha, "id_situacao", "C")
		
		If lds_empurrados.Update() = 1 Then
			SqlCa.of_Commit()
		Else
			ls_erro	= SQLCA.SQLErrText			
			SqlCa.of_Rollback()
			of_envia_email_log (ls_erro,ll_Cd_filial,'Commit do Reprocessamento')
		End If		
		
	Else
		lds_empurrados.SetItem(ll_Linha, "id_situacao", "X")
		lds_empurrados.SetItem(ll_Linha, "dh_cancelamento", ldt_hoje)
		lds_empurrados.SetItem(ll_Linha, "nr_matricula_cancelamento", "14330")
		lds_empurrados.SetItem(ll_Linha, "de_motivo_cancelamento", "CANCELAMENTO AUTOM$$HEX1$$c100$$ENDHEX$$TICO DO PEDIDO")
		
		If lds_empurrados.Update() = 1 Then
			SqlCa.of_Commit()
		Else
			ls_erro = SQLCA.SQLErrText
			SqlCa.of_Rollback()
			of_envia_email_log (ls_erro,ll_Cd_filial,'Commit do Cancelamento')
		End If
	End if
Next

lds_empurrados.setsort('id_situacao, cd_filial, nr_pedido_empurrado')
lds_empurrados.sort()

ls_situacao_ant	= ''
ll_Cd_filial_ant	= 0
	
For ll_Linha = 1 To ll_Linhas

	ll_Cd_filial					= lds_empurrados.Object.cd_filial							[ll_Linha]
	ll_Nr_pedido_empurrado	= lds_empurrados.Object.nr_pedido_empurrado		[ll_Linha]
	ls_Situacao					= lds_empurrados.Object.id_situacao						[ll_Linha]
	
	If ll_Cd_filial <> ll_Cd_filial_ant or ls_situacao <> ls_situacao_ant Then
		
		If ls_situacao_ant = 'X' Then
			If Not of_envia_email_cancelamento(ll_Nr_pedidos_array,ll_Cd_filial_ant,ldt_Pedidos_cancelados,ldt_hoje)  Then
				ls_erro = SQLCA.SQLErrText
			 	of_envia_email_log (ls_erro,ll_Cd_filial_ant,'Envio do E-mail para a filial')
			End if
		Elseif ls_situacao_ant = 'C' Then
			If Not of_envia_email_reprocessamento(ll_Nr_pedidos_array,ll_Cd_filial_ant,ldt_Pedidos_cancelados,ldt_hoje)  Then
				ls_erro = SQLCA.SQLErrText
			 	of_envia_email_log (ls_erro,ll_Cd_filial_ant,'Envio do E-mail para a filial')
			End if
		End if
		
		ll_Nr_pedidos_array = ll_null_array
 	End if

	ll_Nr_pedidos_array[upperbound(ll_Nr_pedidos_array) + 1] = ll_Nr_pedido_empurrado
	
	ls_situacao_ant	= ls_situacao
	ll_Cd_filial_ant	= ll_Cd_filial
Next

//Envia o e-mail da $$HEX1$$fa00$$ENDHEX$$ltima filial 
If ll_Linhas > 0 Then
	If ls_situacao_ant = 'X' Then
		If Not of_envia_email_cancelamento(ll_Nr_pedidos_array,ll_Cd_filial_ant,ldt_Pedidos_cancelados,ldt_hoje)  Then
			ls_erro = SQLCA.SQLErrText
			of_envia_email_log (ls_erro,ll_Cd_filial_ant,'Envio do E-mail para a filial')
		End if 
	Elseif ls_situacao_ant = 'C' Then
		If Not of_envia_email_reprocessamento(ll_Nr_pedidos_array,ll_Cd_filial_ant,ldt_Pedidos_cancelados,ldt_hoje)  Then
			ls_erro = SQLCA.SQLErrText
			of_envia_email_log (ls_erro,ll_Cd_filial_ant,'Envio do E-mail para a filial')
		End if
	End if
End if

Return True

end function

public function boolean of_dias_consulta (integer as_dias_empurrados, date adt_data, ref date adt_datas_consulta[]);Integer	li_contador
Date 		ldt_data

If as_dias_empurrados < 0 Then
	Return false
End If

For li_contador = 0 To as_dias_empurrados
	ldt_data = RelativeDate(adt_data, - li_contador)
	adt_datas_consulta[UpperBound(adt_datas_consulta) + 1] = ldt_data
Next

Return True






end function

public function boolean of_envia_email_log (string as_erro, long al_filial, string as_processo);String lvs_data_envio
String ls_Texto_email
String ls_Texto01
String ls_Texto02

	
s_email str 

ls_Texto01 = "Ocorreram erros na execu$$HEX2$$e700e300$$ENDHEX$$o da tarefa ES - ATUALIZACAO EMPURRADOS NAO FATURADOS "

If as_processo = 'of_consulta_parametro_dias' Then
	ls_Texto02 = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_consulta_parametro_dias, uo_ge644_empurrados_realocacao"
Else
	ls_Texto02 = "Erro:" + 	as_erro + ", na filial: " + string(al_filial) + ", Processo: " + as_processo
End if

lvs_data_envio = String ( RelativeDate (Date (gf_GetServerDate()),-0), "yyyy-mm-dd")
		
ls_Texto_Email = 	"<HTML>"+&
										"<BODY>"+&
										"<BR>"+&										
										"<TABLE border=0>"+&
										"<TR>"+& 
										"<TD>" + ls_Texto01 + "</TD>"+&	
										"</TR>"+& 									
										"<TR>"+& 
										"<TD>" + ls_Texto02 + "</TD>"+&	
										"</TR>"										

ls_Texto_Email		= ls_Texto_Email +"</TABLE></BODY></HTML>" 
str.ps_Mensagem	= ls_Texto_Email	
str.pb_Assinatura	= True
gf_ge202_envia_email_padrao(340, str)

Return True 
end function

public function boolean of_envia_email_cancelamento (long al_nr_pedido_empurrado[], long al_filial, date adh_inicio, date adh_fim);Long	ll_Pedido_Numero_Ant

Long	ll_Cod_Msg
Long	ll_linha
Long	ll_tamanho
Long	ll_linhas
Long	ll_ret
Long	ll_Linha_Produto
Long	ll_Pedido_Numero

String	lvs_data_envio
String	ls_Texto_email
String	ls_Texto01
String	ls_Texto02
String	ls_Email_filial
String	ls_Pedido_Empurrado_Atual
String	ls_cd_produto
String	ls_de_produto
String	ls_qt_faltante

s_email	str 
ls_Email_filial = Right("0000" + String(al_filial), 4) + '@clamedlocal.com.br'
//ls_Email_filial = 'giovani.santos@clamed.com.br' // retirar em produ$$HEX2$$e700e300$$ENDHEX$$o 
str.ps_to[UpperBound(str.ps_to)+1] = ls_Email_filial

ll_Linhas = UpperBound(al_nr_pedido_empurrado)

If ll_Linhas < 1 Then
	MessageBox("Erro", "Nenhum pedido para processar", StopSign!)
	Return False
End If

ls_Texto01 = "Gostar$$HEX1$$ed00$$ENDHEX$$amos de informar que o(s) produto(s) do(s) pedido(s) empurrado(s) abaixo foram <b><span style='color:red'>CANCELADOS</span></b> automaticamente."
ls_Texto02 = "Refor$$HEX1$$e700$$ENDHEX$$amos que a tratativa para o material deve ser resolvida via cria$$HEX2$$e700e300$$ENDHEX$$o de pedido manual para atender a loja, caso seja vi$$HEX1$$e100$$ENDHEX$$vel."

ls_Texto_Email =	"<HTML>" + &
				"<BODY>" + &
				"<BR>" + &										
				"<TABLE border=0>" + &
				"<TR><TD>" + ls_Texto01 + "</TD></TR>" + &	
				"<TR><TD>" + ls_Texto02 + "</TD></TR>" + &
				"</TABLE>" + &
				"<BR/><BR/>" + &
				"<TABLE border='1' cellpadding='5' style='border-collapse: collapse'>" + &
				"<TR style='background-color: #f2f2f2'>" + &
				"<TH>Pedido Empurrado</TH>" + &
				"<TH>C$$HEX1$$f300$$ENDHEX$$digo Produto</TH>" + &
				"<TH>Descri$$HEX2$$e700e300$$ENDHEX$$o</TH>" + &
				"<TH>Qtde Faltante</TH>" + &
				"</TR>"

For ll_Linha = 1 To ll_Linhas
	ll_Pedido_Numero = al_nr_pedido_empurrado[ll_Linha] 
	ls_Pedido_Empurrado_Atual = String(ll_Pedido_Numero)
		 
	If ll_Pedido_Numero = ll_Pedido_Numero_Ant then
		Continue
	End if
    
	dc_uo_ds_base lds_produtos_empurrados
	lds_produtos_empurrados = Create dc_uo_ds_base
	lds_produtos_empurrados.Of_ChangeDataObject('ds_ge644_ped_emp_realocacao_prod')
	ll_ret = lds_produtos_empurrados.Retrieve(adh_inicio, adh_fim, 'X', al_filial, ll_Pedido_Numero)
	
	If ll_ret < 1 Then
		Destroy lds_produtos_empurrados
		Continue
	End If

	For ll_Linha_Produto = 1 To lds_produtos_empurrados.RowCount()
		ls_cd_produto	= String(lds_produtos_empurrados.GetItemString(ll_Linha_Produto, "cd_produto"))
		ls_de_produto	= lds_produtos_empurrados.GetItemString(ll_Linha_Produto, "produto")
		ls_qt_faltante	= String(lds_produtos_empurrados.GetItemNumber(ll_Linha_Produto, "qt_faltante"))
		ls_Texto_Email	+= "<TR>" + &
						"<TD style='padding: 5px'>" + ls_Pedido_Empurrado_Atual + "</TD>" + &
						"<TD style='padding: 5px'>" + ls_cd_produto + "</TD>" + &
						"<TD style='padding: 5px'>" + ls_de_produto + "</TD>" + &
						"<TD style='padding: 5px; text-align: center'>" + ls_qt_faltante + "</TD>" + &
						"</TR>"
	Next
	
	ll_Pedido_Numero_Ant	= ll_Pedido_Numero
	 
	Destroy lds_produtos_empurrados
Next

ls_Texto_Email += "</TABLE></BODY></HTML>" 

str.ps_Mensagem	= ls_Texto_Email	
str.pb_Assinatura	= True
gf_ge202_envia_email_padrao(339, str)

Return True
end function

public function boolean of_envia_email_reprocessamento (long al_nr_pedido_empurrado[], long al_filial, date adh_inicio, date adh_fim);Long	ll_Cod_Msg
Long	ll_Linha
Long	ll_Linhas
Long	ll_ret
Long	ll_Linha_Produto
Long	ll_Pedido_Numero
Long	ll_Pedido_Numero_Ant = -1

String	lvs_data_envio
String	ls_Texto_email
String	ls_Texto01
String	ls_Texto02
String	ls_Email_filial
String	ls_Pedido_Empurrado_Atual
String	ls_cd_produto
String	ls_de_produto
String	ls_qt_faltante

s_email	str 

ls_Email_filial = Right("0000" + String(al_filial), 4) + '@clamedlocal.com.br'
//ls_Email_filial = 'giovani.santos@clamed.com.br' // Remover em produ$$HEX2$$e700e300$$ENDHEX$$o
str.ps_to[UpperBound(str.ps_to)+1] = ls_Email_filial

ll_Linhas = UpperBound(al_nr_pedido_empurrado)

If ll_Linhas < 1 Then
	MessageBox("Erro", "Nenhum pedido para processar", StopSign!)
	Return False
End If

ls_Texto01 = "Gostar$$HEX1$$ed00$$ENDHEX$$amos de informar que o(s) produto(s) do(s) pedido(s) empurrado(s) abaixo n$$HEX1$$e300$$ENDHEX$$o foram faturados no pedido atual."
ls_Texto02 = "A remessa ser$$HEX1$$e100$$ENDHEX$$ reinserida automaticamente na separa$$HEX2$$e700e300$$ENDHEX$$o no pr$$HEX1$$f300$$ENDHEX$$ximo pedido do CD e n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio nenhuma tratativa por parte da loja."

ls_Texto_Email =	"<HTML>" + &
				"<BODY>" + &
				"<BR>" + &										
				"<TABLE border=0>" + &
				"<TR><TD>" + ls_Texto01 + "</TD></TR>" + &	
				"<TR><TD>" + ls_Texto02 + "</TD></TR>" + &
				"</TABLE>" + &
				"<BR/><BR/>" + &
				"<TABLE border='1' cellpadding='5' style='border-collapse: collapse'>" + &
				"<TR style='background-color: #f2f2f2'>" + &
				"<TH>Pedido Empurrado</TH>" + &
				"<TH>C$$HEX1$$f300$$ENDHEX$$digo Produto</TH>" + &
				"<TH>Descri$$HEX2$$e700e300$$ENDHEX$$o</TH>" + &
				"<TH>Qtde Faltante</TH>" + &
				"</TR>"

For ll_Linha = 1 To ll_Linhas
	ll_Pedido_Numero = al_nr_pedido_empurrado[ll_Linha]
	
	If ll_Pedido_Numero = ll_Pedido_Numero_Ant Then
		Continue
	End If
	
	ls_Pedido_Empurrado_Atual = String(ll_Pedido_Numero)
	
	dc_uo_ds_base lds_produtos_empurrados
	lds_produtos_empurrados = Create dc_uo_ds_base
	lds_produtos_empurrados.Of_ChangeDataObject('ds_ge644_ped_emp_realocacao_prod')
	ll_ret = lds_produtos_empurrados.Retrieve(adh_inicio, adh_fim, 'C', al_filial, ll_Pedido_Numero)
	
	If ll_ret < 1 Then
		Destroy lds_produtos_empurrados
		Continue
	End If

	For ll_Linha_Produto = 1 To lds_produtos_empurrados.RowCount()
		ls_cd_produto = lds_produtos_empurrados.GetItemString(ll_Linha_Produto, "cd_produto")
		ls_de_produto = lds_produtos_empurrados.GetItemString(ll_Linha_Produto, "produto")
		ls_qt_faltante = String(lds_produtos_empurrados.GetItemNumber(ll_Linha_Produto, "qt_faltante"))
		
		ls_Texto_Email += "<TR>" + &
						"<TD style='padding: 5px'>" + ls_Pedido_Empurrado_Atual + "</TD>" + &
						"<TD style='padding: 5px'>" + ls_cd_produto + "</TD>" + &
						"<TD style='padding: 5px'>" + ls_de_produto + "</TD>" + &
						"<TD style='padding: 5px; text-align: center'>" + ls_qt_faltante + "</TD>" + &
						"</TR>"
	Next
	
	ll_Pedido_Numero_Ant = ll_Pedido_Numero
	Destroy lds_produtos_empurrados
Next

ls_Texto_Email += "</TABLE></BODY></HTML>" 

str.ps_Mensagem	= ls_Texto_Email	
str.pb_Assinatura	= True
gf_ge202_envia_email_padrao(338, str)

Return True
end function

on uo_ge644_empurrados_realocacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge644_empurrados_realocacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

