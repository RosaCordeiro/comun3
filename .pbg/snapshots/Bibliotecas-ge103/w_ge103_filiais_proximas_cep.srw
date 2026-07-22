HA$PBExportHeader$w_ge103_filiais_proximas_cep.srw
forward
global type w_ge103_filiais_proximas_cep from dc_w_base
end type
type cbx_pp from checkbox within w_ge103_filiais_proximas_cep
end type
type cbx_dc from checkbox within w_ge103_filiais_proximas_cep
end type
type cbx_disque from checkbox within w_ge103_filiais_proximas_cep
end type
type cb_localizar_lojas from picturebutton within w_ge103_filiais_proximas_cep
end type
type dw_3 from dc_uo_dw_base within w_ge103_filiais_proximas_cep
end type
type dw_2 from dc_uo_dw_base within w_ge103_filiais_proximas_cep
end type
type dw_1 from dc_uo_dw_base within w_ge103_filiais_proximas_cep
end type
type gb_1 from groupbox within w_ge103_filiais_proximas_cep
end type
type gb_2 from groupbox within w_ge103_filiais_proximas_cep
end type
type gb_3 from groupbox within w_ge103_filiais_proximas_cep
end type
end forward

global type w_ge103_filiais_proximas_cep from dc_w_base
integer width = 2578
integer height = 2040
string title = "GE103 - Consulta Filiais Pr$$HEX1$$f300$$ENDHEX$$ximas"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cbx_pp cbx_pp
cbx_dc cbx_dc
cbx_disque cbx_disque
cb_localizar_lojas cb_localizar_lojas
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_ge103_filiais_proximas_cep w_ge103_filiais_proximas_cep

type variables
uo_Cidade io_Cidade
uo_Cliente io_Cliente

String is_Texto_Endereco = "Digite aqui o cep ou o endere$$HEX1$$e700$$ENDHEX$$o e pressione [Enter]"

uo_ge099_endereco io_Endereco
end variables

forward prototypes
public subroutine wf_localiza_endereco ()
public subroutine wf_dados_cep (string ps_cep)
end prototypes

public subroutine wf_localiza_endereco ();String lvs_Cep

Long ll_Cidade_Informada

Decimal	ldc_Vl_Frete

dw_2.AcceptText()

lvs_Cep = trim(dw_2.Object.Localizacao_Endereco[1])
ll_Cidade_Informada = dw_2.Object.Cd_Cidade[1]

If IsNull( ll_Cidade_Informada ) Or ll_Cidade_Informada = 0 Then ll_Cidade_Informada = gvo_Parametro.Cd_Cidade

io_Endereco.ivl_Cidade_Informada = ll_Cidade_Informada

lvs_Cep = gf_Replace(lvs_Cep,".","", 1)
lvs_Cep = gf_ge099_Remove_Hifen_Cep(lvs_Cep) //Se o usu$$HEX1$$e100$$ENDHEX$$rio informou hifen na pesquisa o sistema retira pra fazer a consulta
io_Endereco.of_Localiza_endereco(lvs_Cep)

If io_Endereco.Localizado Then
	io_Cidade.of_Localiza_Cidade(String(io_Endereco.Cd_Cidade))
	
	dw_2.Object.nr_cep[1] = io_Endereco.nr_cep
	
	cb_Localizar_lojas.Visible 				= False
	dw_2.Object.localizar_filiais_t.Visible 	= False
	
	//If io_Endereco.ivb_Libera_Digitacao Then
	If IsNull(io_Endereco.de_endereco) Then
		dw_2.SetTabOrder('nm_cidade', 20)
		dw_2.SetTabOrder('cd_unidade_federacao', 0)
		dw_2.SetTabOrder('de_endereco', 40)
		dw_2.SetTabOrder('nr_cep', 0)
		dw_2.SetTabOrder('de_bairro', 60)
	
		dw_2.Modify('nm_cidade.background.color="16777215"')
		dw_2.Modify('de_endereco.background.color="16777215"')
		dw_2.Modify('de_bairro.background.color="16777215"')
		
		cb_Localizar_lojas.Visible 				= True
		dw_2.Object.localizar_filiais_t.Visible 	= True
		
		dw_2.Object.nm_cidade					[1] = io_Endereco.Nm_cidade
		dw_2.Object.cd_cidade					[1] = io_Endereco.cd_cidade
		dw_2.Object.cd_unidade_federacao	[1] = io_Endereco.cd_unidade_federacao
		dw_2.Object.de_endereco				[1] = ""
		dw_2.Object.de_bairro					[1] = ""		
		
		dw_2.Event ue_pos(1, 'nm_cidade')		
	Else
		dw_2.SetTabOrder('nm_cidade', 0)
		dw_2.SetTabOrder('cd_unidade_federacao', 0)
		dw_2.SetTabOrder('de_endereco', 0)
		dw_2.SetTabOrder('nr_cep', 0)
		dw_2.SetTabOrder('de_bairro', 0)
		
		dw_2.Modify('nm_cidade.background.color="67108864"')
		dw_2.Modify('de_endereco.background.color="67108864"')
		dw_2.Modify('de_bairro.background.color="67108864"')
		
		dw_2.Object.nm_cidade					[1] = io_Endereco.Nm_cidade
		dw_2.Object.cd_cidade					[1] = io_Endereco.cd_cidade
		dw_2.Object.de_endereco				[1] = io_Endereco.de_endereco
		dw_2.Object.cd_unidade_federacao	[1] = io_Endereco.cd_unidade_federacao
		dw_2.Object.de_bairro					[1] = MidA(io_Endereco.de_bairro, 1, 20)
	End If
	
	// Se o campo bairro for maior que 20 pega bairro abreviado <> ''.		
	If LenA(io_Endereco.de_bairro) > 20 Then		
		If io_Endereco.de_bairro_abreviado <> "" and Not IsNull(io_Endereco.de_bairro_abreviado) Then
			dw_2.Object.de_bairro[1] = MidA(io_Endereco.de_bairro_abreviado, 1, 20)
		End If
	End If	
	
	// Se campo endereco for > 40 pega endereco abreviado que tem 36 caracteres.
	If LenA(io_Endereco.de_endereco) > 40 Then
		dw_2.Object.de_endereco[1] = io_Endereco.de_endereco_abreviado
	End If
	
	If Not IsNull(io_Endereco.de_endereco) Then
		//Recupera as filiais mais proximas do CEP
		wf_Dados_CEP( io_Endereco.nr_cep )
	End If
		
Else
	dw_2.Event ue_pos(1, 'localizacao_endereco')
End If

dw_2.Object.Localizacao_Endereco[1] = is_Texto_Endereco
end subroutine

public subroutine wf_dados_cep (string ps_cep);Boolean lb_Localizado = True

String ls_json, ls_erro, ls_Aux, ls_Casas_dec

Decimal{8} ldc_Latitude, ldc_Longitude

Integer li_Pos, li_Qt_Logradouro

Long ll_Cidade

String ls_Latitude, ls_Longitude
String ls_Logradouro, ls_Bairro, ls_Cidade, ls_UF, ls_Parametro

Boolean lb_Existe_Logradouro

Try
	dw_2.AcceptText()
	
	ls_Logradouro 	= gf_retira_acentos( dw_2.Object.de_endereco				[1] )
	ls_Bairro			= gf_retira_acentos( dw_2.Object.de_bairro					[1] )
	ls_Cidade		= gf_retira_acentos( dw_2.Object.nm_cidade					[1] )
	ls_UF				= gf_retira_acentos( dw_2.Object.cd_unidade_federacao	[1] )
	ll_Cidade			= dw_2.Object.cd_cidade											[1]
	
	If IsNull(ls_Logradouro) Or IsNull(ls_Bairro) Or IsNull(ls_Cidade) Or IsNull(ls_UF) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o endere$$HEX1$$e700$$ENDHEX$$o corretamente", Exclamation!)
		Return
	End If
	
	//Tratamento para as cidades com CEP $$HEX1$$fa00$$ENDHEX$$nico
	If IsNull(ls_Bairro) Or ls_Bairro = '' Then
		ls_Bairro = 'CENTRO'
	End If
	
	dw_3.setredraw( False)
	
	uo_ge040_geocode lo_geocode
	lo_geocode = Create uo_ge040_geocode

	ls_Parametro = ls_Logradouro+ ' '+ls_Bairro+' '+ls_Cidade
		
	If Not lo_geocode.of_dados_endereco( ls_Parametro, True, ref ls_json, ref ls_erro) Then	
		//Tenta buscar por Bairro / Cidade
		ls_Parametro = ls_Bairro+' '+ls_Cidade
		If Not lo_geocode.of_dados_endereco( ls_Parametro, False, ref ls_json, ref ls_erro) Then	
			//Cidade
			ls_Parametro = ls_Cidade
			If Not lo_geocode.of_dados_endereco( ls_Parametro, False, ref ls_json, ref ls_erro) Then	
				lb_Localizado = False
			End If
		End If
	End If
	
	If Trim(ls_erro) <> '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta do CEP.~r~r" + ls_erro)
	End If
	
	//	Formata latitude
	li_Pos  	 		= Pos( lo_geocode.is_latitude, '.' )
	ls_Aux	 		= Mid( lo_geocode.is_latitude, 1, li_Pos -1 )
	ls_Casas_dec	= Mid( lo_geocode.is_latitude, li_Pos + 1 )
	ldc_Latitude 	= Dec( ls_Aux + ',' +  ls_Casas_dec )
	
	//	Formata longitude
	li_Pos  	 		= Pos( lo_geocode.is_longitude, '.' )
	ls_Aux	 		= Mid( lo_geocode.is_longitude, 1, li_Pos -1 )
	ls_Casas_dec	= Mid( lo_geocode.is_longitude, li_Pos + 1, 8 )
	ldc_Longitude 	= Dec( ls_Aux + ',' +  ls_Casas_dec )
	
	If lb_Localizado Then
		dw_3.of_changedataobject( 'dw_ge103_filiais_proximas' )
		dw_3.Retrieve( ldc_Latitude, ldc_Longitude )
	Else
		dw_3.Of_changedataobject( "dw_ge103_filiais_cidade" )
		dw_3.Retrieve( )
		If dw_3.Find("cd_filial = " +String( ll_Cidade ), 1, dw_3.RowCount() )  > 0 Then
			dw_3.Setsort( "cd_cidade" )
		Else
			dw_3.Setsort( "nm_fantasia" )
		End If
		dw_3.Sort( )
	End If
	
	If dw_3.RowCount() > 0 Then
		 dw_3.of_SetRowSelection()
	End If
		
	//Se nao encontrou nenhuma coordenada, busca pela cidade
	If Not lb_Localizado Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma loja encontrada pr$$HEX1$$f300$$ENDHEX$$xima ao endere$$HEX1$$e700$$ENDHEX$$o pesquisado.", Exclamation!)
	End If
	
	dw_3.setredraw( True )
Finally
	If IsValid(lo_geocode) Then Destroy lo_geocode
End Try
end subroutine

on w_ge103_filiais_proximas_cep.create
int iCurrent
call super::create
this.cbx_pp=create cbx_pp
this.cbx_dc=create cbx_dc
this.cbx_disque=create cbx_disque
this.cb_localizar_lojas=create cb_localizar_lojas
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_pp
this.Control[iCurrent+2]=this.cbx_dc
this.Control[iCurrent+3]=this.cbx_disque
this.Control[iCurrent+4]=this.cb_localizar_lojas
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_ge103_filiais_proximas_cep.destroy
call super::destroy
destroy(this.cbx_pp)
destroy(this.cbx_dc)
destroy(this.cbx_disque)
destroy(this.cb_localizar_lojas)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;io_Cidade 		= Create uo_Cidade
io_Cliente 		= Create uo_Cliente
io_Endereco 	= Create uo_ge099_endereco

Dw_1.Event ue_AddRow()
Dw_2.Event ue_AddRow()
Dw_3.Event ue_AddRow()

Dw_1.Event ue_Pos(1, 'nm_cliente')
end event

event close;call super::close;If IsValid(io_Cidade) 		Then Destroy io_Cidade
If IsValid(io_Cliente) 		Then Destroy io_Cliente
If IsValid(io_Endereco) 	Then Destroy io_Endereco
end event

type cbx_pp from checkbox within w_ge103_filiais_proximas_cep
integer x = 1728
integer y = 948
integer width = 197
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "PP"
end type

event clicked;String ls_Filtro=""

If cbx_dc.checked Then
	cbx_dc.checked = False
End If

If cbx_disque.checked Then
	ls_Filtro = "id_disque_entrega='S'"
End If

If This.checked Then
	If ls_Filtro <> "" Then
		ls_Filtro += ' And '
	End If
	
	ls_Filtro += "f.id_rede_filial = 'PP'"
End If	

dw_3.setfilter( ls_Filtro )
dw_3.Filter()
dw_3.setsort( "distancia_km" )
dw_3.Sort()




end event

type cbx_dc from checkbox within w_ge103_filiais_proximas_cep
integer x = 1504
integer y = 948
integer width = 197
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "DC"
end type

event clicked;String ls_Filtro=""

If cbx_pp.checked Then
	cbx_pp.checked = False
End If

If cbx_disque.checked Then
	ls_Filtro = "id_disque_entrega='S'"
End If

If This.checked Then
	If ls_Filtro <> "" Then
		ls_Filtro += ' And '
	End If
	
	ls_Filtro += "f.id_rede_filial = 'DC'"
End If	

dw_3.setfilter( ls_Filtro )
dw_3.Filter()
dw_3.setsort( "distancia_km" )
dw_3.Sort()




end event

type cbx_disque from checkbox within w_ge103_filiais_proximas_cep
integer x = 2103
integer y = 952
integer width = 297
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Disque?"
end type

event clicked;String ls_Filtro

//Verifica se alguma rede esta marcada
If cbx_pp.checked Then
	ls_Filtro = "f.id_rede_filial = 'PP'"
End If

IF cbx_dc.checked Then
	ls_Filtro = "f.id_rede_filial = 'DC'"
End If

//Limpa o Filtro Se nenhuma rede estiver marcada
If Not cbx_PP.checked And Not cbx_DC.checked Then
	ls_Filtro = ""
End If

If This.checked Then
	If dw_3.RowCount() > 0 Then	
		If ls_Filtro <> "" Then
			ls_Filtro += ' And '
		End If
		
		ls_Filtro += "f.id_disque_entrega = 'S'"
	End If
End If	

dw_3.setfilter( ls_Filtro )
dw_3.Filter()
dw_3.setsort( "distancia_km" )
dw_3.Sort()

end event

type cb_localizar_lojas from picturebutton within w_ge103_filiais_proximas_cep
boolean visible = false
integer x = 2222
integer y = 660
integer width = 165
integer height = 124
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\icon_search.PNG"
alignment htextalign = left!
long backcolor = 16777215
end type

event clicked;//Recupera as filiais mais proximas do CEP
	wf_Dados_CEP( io_Endereco.nr_cep )
end event

type dw_3 from dc_uo_dw_base within w_ge103_filiais_proximas_cep
integer x = 82
integer y = 940
integer width = 2418
integer height = 964
integer taborder = 20
string dataobject = "dw_ge103_filiais_proximas"
boolean vscrollbar = true
end type

event clicked;call super::clicked;Long ll_Filial

If dwo.Name = 'bt_disque_entrega' Then
	
	ll_Filial = This.Object.cd_filial [ row ]
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja incluir um pedido disque entrega atrav$$HEX1$$e900$$ENDHEX$$s do sistema Retaguarda de Loja?", Question!, YesNo!, 2) = 1 Then
		Return CloseWithReturn(Parent, ll_Filial)
	End If
		
End If
end event

type dw_2 from dc_uo_dw_base within w_ge103_filiais_proximas_cep
integer x = 59
integer y = 344
integer width = 2446
integer height = 492
integer taborder = 30
string dataobject = "dw_ge103_endereco"
end type

event itemchanged;call super::itemchanged;Integer  li_Parcelas, ll_Null
Decimal ldc_Vl_Parcela, ldc_Frete

SetNull(ll_Null)

Choose Case Lower(dwo.Name) 		
	
	Case "nm_cidade"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Cidade.Nm_Cidade Then
				Return 1
			End If
		Else
			io_Cidade.Of_Inicializa()
			
			This.Object.cd_cidade	[1] = io_Cidade.cd_cidade
			This.Object.nm_cidade	[1] = io_Cidade.nm_cidade
		End If
			
End Choose


end event

event ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	Choose Case lvs_Coluna
		Case "nm_cidade"
			io_Cidade.of_Localiza_Cidade(This.GetText())
			
			If io_Cidade.Localizada Then					
				dw_2.Object.nm_cidade						[1] = io_Cidade.nm_cidade
				dw_2.Object.cd_cidade						[1] = io_Cidade.cd_cidade
				dw_2.Object.cd_unidade_federacao	 	[1] = io_Cidade.cd_unidade_federacao
			End If
			
		Case "localizacao_endereco"
			If Upper(Trim(This.GetText())) = Upper(is_Texto_Endereco) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_Texto_Endereco, StopSign!)
				Return -1
			End If
						
			wf_localiza_endereco()
	End Choose
End If	

end event

event editchanged;call super::editchanged;cbx_PP.Checked 		= False
cbx_DC.Checked 		= False
cbx_Disque.checked 	= False

dw_3.Reset()

end event

event constructor;call super::constructor;This.Object.localizar_filiais_t.Visible 	= False
end event

type dw_1 from dc_uo_dw_base within w_ge103_filiais_proximas_cep
integer x = 59
integer y = 68
integer width = 2034
integer height = 184
integer taborder = 20
string dataobject = "dw_ge103_cliente"
end type

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_cliente"
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Cliente.nm_cliente Then
				Return 1
			End If
		Else
			io_Cliente.of_Inicializa()
			
			This.Object.cd_Cliente  	[1] = io_Cliente.cd_Cliente
			This.Object.nm_cliente	[1] = io_Cliente.nm_cliente
			This.Object.nr_cpf_cgc	[1] = io_Cliente.nr_cpf_cgc
			
			cbx_PP.Checked 		= False
			cbx_DC.Checked 		= False
			cbx_Disque.checked 	= False
			
			dw_3.Reset()	
			dw_2.Reset()
			dw_2.Event ue_AddRow()
			
		End If
			
End Choose
end event

event ue_key;call super::ue_key;String ls_Localizacao

If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
		Case "nm_cliente"
			
			ls_Localizacao = This.GetText()

			If LenA( ls_Localizacao ) = 11 And IsNumber( ls_Localizacao ) Then
				io_Cliente.of_Localiza_Cpf( ls_Localizacao )
			Else		
				io_Cliente.of_Localiza_Cliente( ls_Localizacao )
			End If
						
			If io_cliente.Localizado Then
				This.Object.cd_cliente	[1]  	= io_cliente.cd_cliente
				This.Object.nm_cliente	[1]  	= io_cliente.nm_cliente
				This.Object.nr_cpf_cgc	[1] 	= io_cliente.nr_cpf_cgc
				
				If LenA( io_cliente.nr_cpf_cgc ) > 11 Then
					dw_1.Object.nr_cpf_cgc.EditMask.mask = '!!.!!!.!!!/!!!!-!!'
				Else
					dw_1.Object.nr_cpf_cgc.EditMask.mask = '###.###.###-##'
				End If
				
				dw_2.Object.localizacao_endereco[1] = io_cliente.nr_cep
				dw_2.AcceptText()
				wf_Localiza_endereco()
			End If
	End Choose
End If

end event

type gb_1 from groupbox within w_ge103_filiais_proximas_cep
integer x = 32
integer y = 876
integer width = 2505
integer height = 1064
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filiais"
end type

type gb_2 from groupbox within w_ge103_filiais_proximas_cep
integer x = 32
integer y = 4
integer width = 2089
integer height = 268
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Cliente"
end type

type gb_3 from groupbox within w_ge103_filiais_proximas_cep
integer x = 32
integer y = 288
integer width = 2505
integer height = 576
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Endere$$HEX1$$e700$$ENDHEX$$o"
end type

