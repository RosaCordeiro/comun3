HA$PBExportHeader$w_ge350_observacao.srw
forward
global type w_ge350_observacao from dc_w_response_ok_cancela
end type
type cb_add from commandbutton within w_ge350_observacao
end type
type cb_del from commandbutton within w_ge350_observacao
end type
type st_1 from statictext within w_ge350_observacao
end type
end forward

global type w_ge350_observacao from dc_w_response_ok_cancela
string tag = "w_ge350_observacao"
integer width = 3049
string title = "GE350 - Observa$$HEX2$$e700f500$$ENDHEX$$es"
cb_add cb_add
cb_del cb_del
st_1 st_1
end type
global w_ge350_observacao w_ge350_observacao

type variables
String ivs_Parametro, is_Situacao, is_tipo_retirada, is_de_tipo_retirada

Long il_Filial, il_Retirada
String is_parametro

Boolean ib_Alterou = False
end variables

forward prototypes
public function integer wf_ultimo_codigo (long al_filial, long al_nr_retirada_estoque, string as_erro)
public function boolean wf_envia_email ()
end prototypes

public function integer wf_ultimo_codigo (long al_filial, long al_nr_retirada_estoque, string as_erro);Integer lvi_Ultimo

Select Max(nr_observacao) 
into :lvi_Ultimo
from retirada_estoque_observacao
where cd_filial = :al_filial
	and nr_retirada_estoque = :al_nr_retirada_estoque
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case -1
		as_erro = "Erro ao encontrar ultimo c$$HEX1$$f300$$ENDHEX$$digo da Retirada N$$HEX1$$ba00$$ENDHEX$$ " + string(al_nr_retirada_estoque) + ", Filial: " + string(al_filial)
		Return -1
	Case 0
		If IsNull(lvi_Ultimo) Then
			
			lvi_Ultimo = 0 		
		End If	
End Choose

Return lvi_Ultimo
end function

public function boolean wf_envia_email ();Long ll_Linhas,&
        ll_Linha,&
	    ll_nr_observacao,&
		ll_Retirada,&
		ll_Filial

String lvs_Observacao,&
		lvs_dados_email,&
		lvs_texto_email,&
		lvs_email,&
		lvs_NmFantasia
		
DateTime ldh_registro
Long ll_Mensgem

s_email str //ge202
s_email str_nulo //ge202
lvs_email = String(il_Filial, "0000") + '@clamedlocal.com.br'
ll_Linhas = dw_1.retrieve(il_Filial, il_Retirada)

If is_tipo_retirada = 'A' Then 
	ll_Mensgem = 308 
Else
	ll_Mensgem = 309
End If	


If ll_Linhas >0  Then 	
	For ll_Linha =1 To ll_Linhas
		lvs_Observacao 	= 	dw_1.object.de_observacao		[ll_Linha]
		ldh_registro	 	 	= 	dw_1.object.dh_registro			[ll_Linha]
		lvs_NmFantasia		= 	dw_1.object.nm_fantasia		[1]
		
		// Dados das Observa$$HEX2$$e700f500$$ENDHEX$$es		
		lvs_dados_email += "<tr>"+&																
										"<td>" + lvs_Observacao + "~n</td>"+&										
										"<td>" + String(ldh_registro, "dd/mm/yyyy hh:mm") + "~n</td>"+&	
									    "</tr>"										 		
	Next  	

	lvs_Texto_Email = 	"<html>"+&
										"<body>"+&
										"<br>"+&										
										"<table border=0>"+&
										"<tr>"+& 
										"<td><B>Mensagens Retirada Estoque</B></td>"+&	
										"</tr>"+&
										"<tr>"+& 
										"<td>Filial : "+String(il_Filial)+"-"+String(lvs_NmFantasia)+"~n</td> "+&	
										"</tr>"+&									
										"<tr>"+& 
										"<td>N$$HEX1$$fa00$$ENDHEX$$mero Retirada:"+ string(il_Retirada) + " ~t" + is_de_tipo_retirada + "~n</td> "+&	
										"</tr><br>"+&																			
										"</table>"+&										
										"<table border = 1> "+&
										"<tr bgcolor='#ffff66'> "+& 									
										"<td>Mensagem</td> "+&
										"<td>Data Hora</td> "+&										
										"</tr>" +&
										lvs_dados_email +&
										"</table><br></body>"+&	
										"</html>" 

	str.ps_Assunto	= ": "+String(il_Filial)+"-"+String(lvs_NmFantasia)
	str.ps_to[1]	= lvs_email
	str.ps_Mensagem	= lvs_Texto_Email
	str.pb_Assinatura	= True
	str.pb_info_nao_responda = False
	gf_ge202_envia_email_padrao_nao_resp(ll_Mensgem, str, True)
	//Limpa a estrutura do e-mail
	str = str_nulo							
End If 


Return True 
end function

on w_ge350_observacao.create
int iCurrent
call super::create
this.cb_add=create cb_add
this.cb_del=create cb_del
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_add
this.Control[iCurrent+2]=this.cb_del
this.Control[iCurrent+3]=this.st_1
end on

on w_ge350_observacao.destroy
call super::destroy
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.st_1)
end on

event open;call super::open;ivs_Parametro = Message.StringParm

il_Filial 				= Long(Mid(Message.StringParm, 1, 4))     
il_Retirada 			= Long(Mid(Message.StringParm, 5, 6))        
is_Situacao			= Mid(Message.StringParm, 11, 1)        
is_tipo_retirada  	= Mid(Message.StringParm, 12, 1)        

If Not (is_Situacao = 'F' Or is_Situacao = 'A' Or is_Situacao = 'S') Then
	This.Title = 'GE350 - Observa$$HEX2$$e700f500$$ENDHEX$$es - ' + 'Retirada: ' + string(il_Retirada) + ' - Filial: ' + string(il_Filial) + ' *Somente Leitura*'
Else
	This.Title = 'GE350 - Observa$$HEX2$$e700f500$$ENDHEX$$es - ' + 'Retirada: ' + string(il_Retirada) + ' - Filial: ' + string(il_Filial)
End If



end event

event ue_postopen;call super::ue_postopen;dc_uo_ds_base	lds_tipo_retirada
Long				ll_Find

lds_tipo_retirada = Create dc_uo_ds_base

If Not lds_tipo_retirada.of_ChangeDataObject ('ddw_tipo_retirada_perini') then
	Close (This)
	Return
End if

lds_tipo_retirada.Retrieve ()

ll_Find = lds_tipo_retirada.Find ("id_tipo = '" + is_tipo_retirada + "'", 1, lds_tipo_retirada.RowCount ())
If ll_Find = 0 then
	Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A descri$$HEX2$$e700e300$$ENDHEX$$o do tipo de retirada n$$HEX1$$e300$$ENDHEX$$o foi encontrada', StopSign!)
	Close (This)
	Return
End if

is_de_tipo_retirada = lds_tipo_retirada.Object.de_tipo [ll_Find]

If is_Situacao = 'X' Then
	cb_ok.Enabled = False
	cb_add.Enabled = False
	cb_del.Enabled = False
End If

Dw_1.Event ue_recuperar()

Dw_1.Event ue_postretrieve(dw_1.rowcount())
end event

event close;call super::close;
If ib_Alterou Then
	SqlCa.of_commit( )
	Return 1
Else
	SqlCa.of_rollback()
	Return -1
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge350_observacao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge350_observacao
integer width = 2793
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge350_observacao
integer width = 2757
string dataobject = "dw_ge350_observacao"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"dh_registro", "de_observacao", "id_msg_destino"}

lvs_Nome = {"Data", "Observacao", "Destino"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		 

This.of_SetRowSelection()

ivb_ordena_colunas = True
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If is_Situacao = 'X' Then
//	ivo_Controle_Menu.of_salvarcomo(False)
//	ivo_Controle_Menu.of_excluir(False)
//	ivo_Controle_Menu.of_incluir(False)

	This.Object.nr_observacao.Protect = 1
	This.Object.cd_filial.Protect = 1
	This.Object.nr_retirada_estoque.Protect = 1
	This.Object.id_msg_destino.Protect = 1
	This.Object.de_observacao.Protect = 1
	This.Object.dh_registro.Protect = 1
End If

Return pl_Linhas
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Integer lvi_Proximo_Codigo

Long  lvl_Linha, &
      lvl_Total

String ls_Erro

// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero de linhas da DW
lvl_Total = This.RowCount()

// Localiza a primeira linha sem c$$HEX1$$f300$$ENDHEX$$digo
lvl_Linha = This.Find("isnull(nr_observacao)", 0, lvl_Total)

lvi_Proximo_Codigo = wf_Ultimo_Codigo(il_Filial, il_Retirada, Ref ls_Erro)

If lvi_Proximo_Codigo = -1 Then Return -1
	
// Executa enquanto existirem linhas sem c$$HEX1$$f300$$ENDHEX$$digo
Do While lvl_Linha > 0
	lvi_Proximo_Codigo ++
	
	If IsNull(this.object.de_observacao[lvl_Linha]) Or len(trim(this.object.de_observacao[lvl_Linha])) < 1 Then 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Favor informar a observa$$HEX2$$e700e300$$ENDHEX$$o.')
		dw_1.Event ue_Pos(lvl_Linha, "de_observacao")	
		lvl_Linha = -1
		Return -1
	End If
	
	If this.object.id_msg_destino[lvl_Linha] = 'X' Then 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer o preenchimento do Destinat$$HEX1$$e100$$ENDHEX$$rio!')
		dw_1.Event ue_Pos(lvl_Linha, "id_msg_destino")	
		lvl_Linha = -1
		Return -1
	End If
	
	// Atualiza a DW com o c$$HEX1$$f300$$ENDHEX$$digo sequencial
	This.Object.cd_filial[lvl_Linha] = il_Filial
	This.Object.nr_retirada_estoque[lvl_Linha] = il_Retirada
	This.Object.nr_observacao[lvl_Linha] = lvi_Proximo_Codigo
	If IsNull(This.Object.dh_registro[lvl_Linha]) Then This.Object.dh_registro[lvl_Linha] = gf_getserverdate()
	
	lvl_Linha = This.Find("isnull(nr_observacao)", lvl_Linha, lvl_Total)
Loop

Return 1
end event

event dw_1::ue_recuperar;//override

Return this.retrieve(il_Filial, il_Retirada)


end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge350_observacao
integer x = 2176
integer y = 1176
string text = "&Salvar"
end type

event cb_ok::clicked;call super::clicked;If Dw_1.Event ue_preupdate() > 0 Then
	If Dw_1.Event ue_update() < 0 Then 
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Erro ao salvar dados.')
		Return -1
	Else
		ib_Alterou = True
	End If
Else
	Return -1
End If



If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja Enviar as Mensagens para Loja ?", Question!, YesNo!, 2) = 2 Then 
	Return -1	
Else
	wf_envia_email()	
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Mensagem Enviada com Sucesso!')
End If 	
	

Return 1


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge350_observacao
integer x = 2510
integer y = 1176
string text = "&Fechar"
end type

type cb_add from commandbutton within w_ge350_observacao
integer x = 2848
integer y = 28
integer width = 142
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "+"
end type

event clicked;Long ll_Linha

ll_Linha = Dw_1.Event ue_addrow()

dw_1.Event ue_Pos( ll_Linha , "de_observacao")

dw_1.object.dh_registro[ll_Linha] = gf_getserverdate()
end event

type cb_del from commandbutton within w_ge350_observacao
integer x = 2848
integer y = 148
integer width = 142
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "-"
end type

event clicked;Dw_1.Event ue_deleterow()

If Dw_1.Event ue_preupdate() > 0 Then
	If Dw_1.Event ue_update() < 0 Then 
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Erro ao salvar dados.')
		Return -1
	Else
		ib_Alterou = True
	End If
Else
	Return -1
End If

end event

type st_1 from statictext within w_ge350_observacao
integer x = 23
integer y = 1132
integer width = 2043
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "No campo Observa$$HEX2$$e700e300$$ENDHEX$$o, no final de cada linha use o <Ctrl + Enter>"
boolean focusrectangle = false
end type

