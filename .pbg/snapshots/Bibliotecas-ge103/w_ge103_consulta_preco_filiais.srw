HA$PBExportHeader$w_ge103_consulta_preco_filiais.srw
forward
global type w_ge103_consulta_preco_filiais from dc_w_selecao_lista_relatorio
end type
type cb_copia_produto from commandbutton within w_ge103_consulta_preco_filiais
end type
type cb_lojas_proximas from commandbutton within w_ge103_consulta_preco_filiais
end type
end forward

global type w_ge103_consulta_preco_filiais from dc_w_selecao_lista_relatorio
string accessiblename = "Consulta Pre$$HEX1$$e700$$ENDHEX$$o Geral (GE103)"
integer x = 599
integer y = 576
integer width = 5115
integer height = 1992
string title = "GE103 - Consulta Pre$$HEX1$$e700$$ENDHEX$$o Geral"
long backcolor = 80269524
cb_copia_produto cb_copia_produto
cb_lojas_proximas cb_lojas_proximas
end type
global w_ge103_consulta_preco_filiais w_ge103_consulta_preco_filiais

type variables
uo_produto ivo_produto
uo_cidade ivo_cidade
uo_filial ivo_filial

String ivs_filiais, ivs_nulo, ivs_Tipo_Selecao, is_DataBase

Long ivl_Filial
end variables

forward prototypes
public subroutine wf_localiza_produto ()
public function long wf_saldo_inicial (long pl_produto, date pdt_inicio)
public function date wf_primeiro_mes_saldo (long pl_produto)
public subroutine wf_localiza_cidade ()
public function boolean wf_saldo_produto (long al_filial, long al_produto, ref long al_saldo)
public function decimal wf_promocao_sos_farm_popular (long al_filial, date adh_parametro, ref string as_mensagem)
public subroutine wf_oculta_campos ()
public subroutine wf_verifica_pbm (long pl_produto)
public function boolean wf_localiza_promocao_progressiva (long al_produto, long al_filial, date adh_parametro)
end prototypes

public subroutine wf_localiza_produto ();String lvs_Produto
Boolean lb_Visivel = False

Decimal ldc_valor_fpb

lvs_Produto = dw_1.GetText()

If (gvo_parametro.cd_Filial = gvo_parametro.cd_filial_matriz) and gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'GF' Then
	ivo_Produto.is_window_selecao_generica = ivs_Tipo_Selecao
End If

ivo_Produto.of_Localiza_Produto(lvs_Produto)

dw_1.Object.bmp_vidalink.Visible 					= False
dw_1.Object.st_gratis_farm_popular.Visible 	= False
dw_1.Object.Id_PBM[1] 								= 'N'
cb_copia_produto.Enabled 							= False

If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	cb_copia_produto.Enabled 	  = True
	
	If ivo_Produto.Id_Farmacia_Popular 	 = 'S' Then dw_1.Object.bmp_vidalink.Visible 				= True
	If ivo_Produto.id_gratis_farm_popular = 'S' Then dw_1.Object.st_gratis_farm_popular.Visible 	= True
	
	wf_Verifica_Pbm(ivo_Produto.Cd_Produto)
	
	If ivo_Produto.Id_Situacao = 'I' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Produto est$$HEX1$$e100$$ENDHEX$$ Inativo, venda somente sob consulta.", Exclamation!)
	End If
	
End If


end subroutine

public function long wf_saldo_inicial (long pl_produto, date pdt_inicio);Long lvl_Saldo = -111111

Date lvdt_Anterior, &
     lvdt_Saldo, &
	  lvdt_Primeiro_Saldo

lvdt_Anterior = RelativeDate(pdt_Inicio, -1)

lvdt_Saldo = Date(String(lvdt_Anterior, "01/mm/yyyy"))

Select qt_saldo_final Into :lvl_Saldo
From saldo_produto
Where cd_produto = :pl_Produto
  and dh_saldo   = :lvdt_Saldo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		lvdt_Primeiro_Saldo = wf_Primeiro_Mes_Saldo(pl_Produto)
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O saldo inicial do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado.~rO primeiro " + &
		                      "saldo dispon$$HEX1$$ed00$$ENDHEX$$vel $$HEX1$$e900$$ENDHEX$$ do m$$HEX1$$ea00$$ENDHEX$$s '" + String(lvdt_Primeiro_Saldo, "mm/yyyy") + &
									 "'.~r~rSer$$HEX1$$e100$$ENDHEX$$ considerado saldo inicial igual a zero.", Information!)
		
		lvl_Saldo = 0
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo inicial do produto.")
End Choose

Return lvl_Saldo
end function

public function date wf_primeiro_mes_saldo (long pl_produto);DateTime lvdh_Saldo

Date lvdt_Retorno

lvdt_Retorno = Date("01/01/1900")

Select min(dh_saldo) Into :lvdh_Saldo
From saldo_produto
Where cd_produto = :pl_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvdh_Saldo) Then
			lvdt_Retorno = Date(lvdh_Saldo)
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Primeiro m$$HEX1$$ea00$$ENDHEX$$s de movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do primeiro m$$HEX1$$ea00$$ENDHEX$$s de movimenta$$HEX2$$e700e300$$ENDHEX$$o.")		
End Choose

Return lvdt_Retorno
end function

public subroutine wf_localiza_cidade ();
String lvs_Cidade

Long   ll_Nulo

SetNull(ll_Nulo)

lvs_Cidade = dw_1.GetText()

ivo_Cidade.of_Localiza_Cidade(lvs_Cidade)

If ivo_Cidade.Localizada Then
	dw_1.Object.Cd_Cidade[1] = ivo_Cidade.Cd_Cidade
	dw_1.Object.Nm_Cidade[1] = ivo_Cidade.Nm_Cidade
Else
	dw_1.Object.Cd_Cidade[1] = ll_Nulo
	dw_1.Object.Nm_Cidade[1] = ''
End If
end subroutine

public function boolean wf_saldo_produto (long al_filial, long al_produto, ref long al_saldo);
select coalesce( qt_saldo_final, 0 ) - dbo.uf_saldo_produto_pendente( cd_filial, cd_produto)
	into :al_saldo
from vw_saldo_atual_produto
where cd_filial = :al_Filial
and 	cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCOde = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar o saldo produto. " + SqlCa.SqlErrText)
	Return False
End If

Return True
end function

public function decimal wf_promocao_sos_farm_popular (long al_filial, date adh_parametro, ref string as_mensagem);Decimal lvdc_Desconto, 	lvdc_Nulo

Long lvl_Promocao_SOS

Date ldh_Inicio, ldh_Termino, ldh_Parametro

String lvs_Parametro

SetNull(lvdc_Nulo)

lvdc_Desconto = lvdc_Nulo

as_mensagem = ""

Select vl_parametro
Into :lvs_Parametro
From parametro_loja
Where cd_filial = :al_filial
	and cd_parametro = 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
				
		If IsNumber(lvs_Parametro) Then
			
			lvl_Promocao_SOS = Long(lvs_Parametro)
			
			Select p.pc_desconto, s.dh_inicio, s.dh_termino
			Into :lvdc_Desconto, :ldh_Inicio, :ldh_Termino
			From promocao_sos_produto p
			inner join promocao_sos s
				on s.cd_promocao_sos 		= p.cd_promocao_sos
			Where s.cd_promocao_sos		= :lvl_Promocao_SOS
			  and p.cd_produto				= :ivo_Produto.cd_produto
			  
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					If IsNull(lvdc_Desconto) or lvdc_Desconto <= 0 Then
						lvdc_Desconto = 0.00
					End If					
					
					If ldh_inicio > adh_parametro or ldh_termino < adh_parametro Then
						as_mensagem = 'Promo$$HEX2$$e700e300$$ENDHEX$$o: ' + lvs_Parametro + ' - N$$HEX1$$c300$$ENDHEX$$O VIGENTE'
					End If
					
				Case 100
					lvdc_Desconto = 0.00
				Case -1
					SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto da promo$$HEX2$$e700e300$$ENDHEX$$o sos '" + String(lvl_Promocao_SOS) + "'")
			End Choose
			
		End If
		
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e300$$ENDHEX$$metro loja 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'")
End Choose

Return lvdc_Desconto
end function

public subroutine wf_oculta_campos ();dw_1.Object.bmp_vidalink.Visible 								= False
dw_1.Object.st_gratis_farm_popular.Visible 				= False

dw_2.Object.st_nome_pmc_farm_popular.Visible 			= False
dw_2.Object.st_nome_preco_final_farm_popular.Visible = False
dw_2.Object.bmp_vidalink2.Visible 							= False
dw_2.Object.st_msg.Visible										= False
dw_2.Object.st_preco_final_farm_popular.Visible 			= False
dw_2.Object.st_pmc_farm_popular.Visible 					= False
end subroutine

public subroutine wf_verifica_pbm (long pl_produto);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de PBM em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

Select Count(pp.cd_pbm)
  Into :lvl_Count
  From pbm p, pbm_produto pp
 Where pp.cd_produto = :pl_produto
   and pp.cd_pbm		= p.cd_pbm
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(pl_Produto) + "'.")
	Return
End If

If lvl_Count > 0 Then
	dw_1.Object.Id_PBM[1] = 'S'
End If

end subroutine

public function boolean wf_localiza_promocao_progressiva (long al_produto, long al_filial, date adh_parametro);Long ll_Qtd
Boolean lb_Retorno = False

Select count(*) 
Into :ll_Qtd
From promocao_sos_produto p
inner join promocao_sos s        on s.cd_promocao_sos 		= p.cd_promocao_sos
inner join promocao_sos_filial f on f.cd_promocao_sos = p.cd_promocao_sos
where p.cd_produto				= :al_produto
and     f.cd_filial = :al_filial
and s.id_tipo_promocao = 'Q'
and s.id_situacao = 'L'
and s.dh_inicio <= :adh_parametro
and s.dh_termino >= :adh_parametro
and (p.cd_desc_progressivo is not null or
       p.cd_desc_progressivo_clube is not null ) 		 
Using SqlCA;	  
       
Choose Case SqlCa.SqlCode
	Case 0
		If ll_Qtd>0 Then lb_Retorno  = True			
	Case 100
		lb_Retorno  = False
	Case -1
		lb_Retorno = False
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e300$$ENDHEX$$metro loja 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'")
End Choose		  

Return lb_Retorno
end function

on w_ge103_consulta_preco_filiais.create
int iCurrent
call super::create
this.cb_copia_produto=create cb_copia_produto
this.cb_lojas_proximas=create cb_lojas_proximas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_copia_produto
this.Control[iCurrent+2]=this.cb_lojas_proximas
end on

on w_ge103_consulta_preco_filiais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_copia_produto)
destroy(this.cb_lojas_proximas)
end on

event ue_postopen;call super::ue_postopen;This.ivm_Menu.ivb_Permite_Imprimir = False

ivo_Filial 	= Create uo_Filial
end event

event open;call super::open;ivo_Produto = Create uo_Produto
ivo_Cidade  = Create uo_Cidade

Setnull(ivs_nulo)

String lvs_Filial, lvs_Msg
Boolean lvb_Sucesso = False

cb_lojas_proximas.Visible 	= False

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'GF' Then
	//Habilita o bot$$HEX1$$e300$$ENDHEX$$o Lojas Pr$$HEX1$$f300$$ENDHEX$$ximas
	cb_lojas_proximas.Visible 	= True
	cb_lojas_proximas.Enabled 	= True
	
	is_DataBase = gvo_Aplicacao.ivs_DataBase
	
	ivs_Tipo_Selecao = "w_ge001_selecao_produto_atendimento_sac"
End If
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Cidade)
Destroy(ivo_Filial)
end event

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino
	  
lvdt_Inicio  = dw_1.Object.Dt_Inicio[1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

dw_3.Object.Periodo_t.Text = String(lvdt_Inicio, "dd/mm/yyyy") + "  at$$HEX1$$e900$$ENDHEX$$ :  " + &
                             String(lvdt_Termino, "dd/mm/yyyy")

dw_3.Object.Produto_t.Text = String(ivo_Produto.Cd_Produto) + "  -  " + &
                             ivo_Produto.ivs_Descricao_Apresentacao_Venda

Return AncestorReturnValue
end event

event ue_preopen;call super::ue_preopen;//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
MaxWidth	= 5150

//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
//Neste caso como s$$HEX1$$e300$$ENDHEX$$o muitos registros o sistema ajusta ao m$$HEX1$$e100$$ENDHEX$$ximo poss$$HEX1$$ed00$$ENDHEX$$vel da tela
MaxHeight	= 9999


//Maxheight = 1900
//MaxWidth = 4868
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge103_consulta_preco_filiais
integer y = 1360
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge103_consulta_preco_filiais
integer y = 1288
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge103_consulta_preco_filiais
integer x = 23
integer y = 392
integer width = 5033
integer height = 1404
string text = "Pre$$HEX1$$e700$$ENDHEX$$os Filiais"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge103_consulta_preco_filiais
integer x = 23
integer y = 4
integer width = 1993
integer height = 348
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge103_consulta_preco_filiais
integer x = 55
integer width = 1934
integer height = 252
string dataobject = "dw_ge103_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

Choose Case dwo.Name 
				
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto	[1] = ivo_Produto.cd_produto
			This.Object.de_produto	[1] = ivo_Produto.de_produto
			
			cb_copia_produto.Enabled = False
			
			wf_oculta_campos()
					
		End If
		
	Case "id_filial"
		
		//A tela conecta no banco da loja para localizar o produto quando est$$HEX1$$e100$$ENDHEX$$ executando o sistema GF, sempre que abrir a tela sele$$HEX2$$e700e300$$ENDHEX$$o de filiais o sistema vai setar o banco como Sybase
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'GF' Then
			gvo_Aplicacao.ivs_DataBase = is_DataBase
		End If
		
		wf_oculta_campos()
		
		If Data = 'C' Then
			
			ivo_Filial.of_Inicializa()
			
			This.Object.cd_Filial[1] = ivo_Filial.cd_filial
			This.Object.nm_Filial[1] = ivo_Filial.nm_fantasia
					
			ivs_filiais = ivs_nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nenhuma filial foi selecionada.", Exclamation!)
			End If
			
			Destroy(uo_Filiais)
			
		End If
		
	Case "nm_filial"
	
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.cd_Filial[1] = ivo_Filial.cd_filial
			This.Object.nm_Filial[1] = ivo_Filial.nm_fantasia
		End If
	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.cd_filial
	This.Object.Nm_Filial[1] = ivo_Filial.nm_fantasia
End If


end event

event dw_1::ue_key;Long lvl_Produto
String ls_Servidor_Intranet, ls_log

If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
		Case "de_produto"
			wf_Localiza_Produto()
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.cd_filial	[1]  	= ivo_Filial.cd_filial
				This.Object.nm_filial	[1]  	= ivo_Filial.nm_fantasia
				This.Object.id_filial	[1] 	= 'T'
				ivs_filiais = ivs_nulo 
			End If
	End Choose
End If

If Key = KeyF5! Then
		lvl_Produto = This.Object.cd_produto[1]
		
		If This.Object.id_pbm[1] = "S" Then						 
			If Not IsNull(lvl_Produto) Then
				OpenWithParm(w_ge113_consulta_pbm_produto, lvl_Produto)
			End If
		ElseIf ivo_Produto.Id_Farmacia_Popular = 'S' Then
			//ShowHelp( gvo_Aplicacao.ivs_Path_Manual, KeyWord!, "procedimentos_farmacia_popular" )
			Try
				If Not gf_Servidor_Intranet(True, Ref ls_Servidor_Intranet, Ref ls_log) Then
					Return -1
				End If
								
				dc_uo_api lo_Api
				lo_Api = Create dc_uo_Api
				lo_Api.of_shell_execute( ls_Servidor_Intranet + "/menu/documentos/suporte/arquivo_361_49_2.pdf", "" )
			Catch( RuntimeError ru )
				MessageBox( "RuntimeError", ru.GetMessage( ) + '~rw_ge103_consulta_preco.tab_1.tabpage_1.dw_2.event ue_Key( )', StopSign! )
			Finally
				Destroy lo_Api
			End Try
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o possui cadastro nos PBMs.", Information!)
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge103_consulta_preco_filiais
integer x = 41
integer y = 448
integer width = 5001
integer height = 1336
string dataobject = "dw_ge103_lista"
boolean hscrollbar = true
boolean livescroll = false
end type

event dw_2::ue_recuperar;// Override

Long lvl_Produto, ll_Filial
	  
String ls_Filiais

dw_1.AcceptText()	

lvl_Produto  = dw_1.Object.Cd_Produto  [ 1 ]
ls_Filiais		= dw_1.Object.id_Filial		[ 1 ]
ll_Filial		= dw_1.Object.cd_filial		[ 1 ]

If IsNull(lvl_Produto) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Favor informar o produto.",Exclamation!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If Not IsNull(ll_Filial) Then
	This.of_appendwhere_subquery("f.cd_filial in (" + String(ll_Filial) + ")", 4)
	This.of_appendwhere_subquery("f.cd_filial in (" + String(ll_Filial) + ")", 6)
Else
	If ls_Filiais = 'C' Then
		This.of_appendwhere_subquery("f.cd_filial in (" + ivs_filiais + ")", 4)
		This.of_appendwhere_subquery("f.cd_filial in (" + ivs_filiais + ")", 6)
	End If
End If

//This.of_SetRowSelection()
This.SetRedraw(False)

Return This.Retrieve(lvl_Produto)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Decimal lvdc_Desconto_Clube

Long lvl_Linha,&
	 lvl_Filial,&
	 lvl_Produto,&
	 lvl_Nulo
	
Long lvl_Saldo

String lvs_tipo, ls_msg_promocao

Date ldh_parametro

SetNull(lvl_Nulo)
			
dw_1.AcceptText()

lvl_Produto = dw_1.Object.cd_produto[1]

If pl_Linhas > 0 Then
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = 'Verificando os pre$$HEX1$$e700$$ENDHEX$$os nas filiais ...'
	
	w_aguarde.uo_progress.of_setmax(pl_Linhas)
	
	ldh_parametro = Date(gf_GetServerDate())
	
	For lvl_Linha = 1 To pl_linhas
		
		lvl_Filial = This.object.cd_filial   [lvl_Linha]
		lvs_Tipo   = This.object.id_tipo_rede[lvl_Linha]
		
		This.Object.vl_preco_unitario						[lvl_Linha] = ivo_Produto.Of_Preco_Venda_Filial_Matriz(lvl_Filial)
		This.Object.pc_desconto		 						[lvl_Linha] = ivo_Produto.Of_Desconto_Filial(lvl_Filial)
		This.Object.Pc_Desconto_SOS_Farm_Popular	[lvl_Linha] = 0.00 //wf_Promocao_SOS_Farm_Popular( lvl_Filial, ldh_parametro, Ref ls_msg_promocao )
		This.Object.de_msg_promocao						[lvl_Linha] = ls_msg_promocao

		If wf_localiza_promocao_progressiva ( 	lvl_Produto  ,  lvl_Filial, ldh_parametro ) Then 
			This.Object.id_tem_progressiva	[lvl_Linha] = '1'			
		Else 
			This.Object.id_tem_progressiva	[lvl_Linha] = '0'			
		End If 
		
		lvdc_Desconto_Clube    = ivo_Produto.of_Desconto_Clube_Filial_Nova(lvl_Filial)
		
		If lvdc_Desconto_Clube = 0 Then lvdc_Desconto_Clube = lvl_Nulo 
					
		This.Object.pc_desconto_clube[lvl_Linha] = lvdc_Desconto_Clube
		
		Choose Case lvs_Tipo
			Case "DC"
				This.Object.de_rede[lvl_Linha] = "DROGARIA CATARINENSE"
			Case "PP"
				This.Object.de_rede[lvl_Linha] = "PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
			Case "AL"
				This.Object.de_rede[lvl_Linha] = "ALOMED"
			Case "FA"
				This.Object.de_rede[lvl_Linha] = "FARMAGORA"
			Case "CD"
				This.Object.de_rede[lvl_Linha] = "CENTRO DISTRIBUI$$HEX2$$c700c300$$ENDHEX$$O"
			Case "DP"
				This.Object.de_rede[lvl_Linha] = "DROG. PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
			Case 'MP'
				This.Object.de_rede[lvl_Linha] = "MANIPULA$$HEX2$$c700c300$$ENDHEX$$O"
			Case 'PF'
				This.Object.de_rede[lvl_Linha] = "PROF$$HEX1$$d300$$ENDHEX$$RMULA"
			Case 'CP'
				This.Object.de_rede[lvl_Linha] = "DROGARIA CATARINENSE PLUS"
		End Choose
		
		w_aguarde.uo_progress.of_setprogress(lvl_Linha)
		
	Next
	
	Close(w_aguarde)
	
	This.SetRedraw(True)
	
	This.Sort()
	This.GroupCalc()
	
	This.Event RowFocusChanged(1)
	
End If

This.ivm_menu.mf_salvarcomo(pl_linhas > 0)

Return pl_Linhas


end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Boolean lvb_Visible

Decimal 	lvdc_Nulo, lvdc_Preco_Final, &
			ldc_valor_fpb
		
String lvs_Nulo		
		
SetNull(lvdc_Nulo)
SetNull(lvs_Nulo)

// Tratamento Farm$$HEX1$$e100$$ENDHEX$$cia Popular do Brasil
lvb_Visible = False

If currentRow > 0 Then

	This.Object.st_pmc_farm_popular.text 			= lvs_Nulo
	This.Object.st_preco_final_farm_popular.text 	= lvs_Nulo
	
	If ivo_Produto.id_farmacia_popular = 'S' Then
		
		lvb_Visible = True
			
		// Altera$$HEX2$$e700e300$$ENDHEX$$o realizada
		ldc_valor_fpb = dw_2.Object.Vl_Preco_Pago_FPB[CurrentRow]

		If ldc_valor_fpb > 0 Then
			If (dw_2.Object.vl_preco_final[CurrentRow] * 0.9) >= ldc_valor_fpb Then
				ldc_valor_fpb =  Round( dw_2.Object.vl_preco_final[CurrentRow] - ldc_valor_fpb, 2 )
			Else
				ldc_valor_fpb = Round( dw_2.Object.vl_preco_final[CurrentRow] * 0.1, 2 )
			End If
		Else
			dw_2.Object.Vl_Preco_Pago_FPB[CurrentRow] = 0.00
		End If

		If ldc_valor_fpb >= 0 Then
			This.Object.st_preco_final_farm_popular.text = String(ldc_valor_fpb, "#,##0.00")
		End If
		// fim altera$$HEX2$$e700e300$$ENDHEX$$o

		This.Object.st_pmc_farm_popular.text = String(This.Object.vl_preco_unitario[CurrentRow], "#,##0.00")		
		
	End If
		
	This.Object.st_nome_pmc_farm_popular.Visible 			= lvb_Visible
	This.Object.st_nome_preco_final_farm_popular.Visible 	= lvb_Visible
	This.Object.bmp_vidalink2.Visible 								= lvb_Visible
	This.Object.st_msg.Visible										= lvb_Visible
	This.Object.st_preco_final_farm_popular.Visible 			= lvb_Visible
	This.Object.st_pmc_farm_popular.Visible 					= lvb_Visible
	
End if
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_salvarcomo(False)
end event

event dw_2::ue_key;call super::ue_key;String ls_Parametro

Long 	ll_Filial

Choose Case Key
	Case KeyF5!
		
		If This.GetRow() = 0 Then Return
		
		ll_Filial = This.Object.cd_filial[This.GetRow() ]
		
		If Not IsNull( ll_Filial ) Then
			ls_Parametro = String(ivo_Produto.cd_produto) + "@#!" + String(ll_Filial)
			
			OpenWithParm( w_ge103_consulta_saldo_filial, ls_Parametro )
		End If
		
		Case KeyF6!
			If This.GetRow() = 0 Then Return
			
			ll_Filial = This.Object.cd_filial[This.GetRow() ]
			
			ls_Parametro = Right("0000"+String(ll_Filial), 4) + String(ivo_Produto.cd_produto)
			
			OpenWithParm(w_ge103_Busca_Facil_lista_tecnica, ls_Parametro)
			
		Case KeyF7!
		
			If This.GetRow() = 0 Then Return
			
			ll_Filial = This.Object.cd_filial[This.GetRow() ]
			
			If Not IsNull( ll_Filial ) Then
				ls_Parametro = String(ivo_Produto.cd_produto) + "@#!" + String(ll_Filial)
				
				OpenWithParm( w_ge103_consulta_desconto_progressivo, ls_Parametro )
			End If
		
		
End Choose
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge103_consulta_preco_filiais
integer x = 3145
integer y = 0
integer width = 681
integer height = 200
end type

type cb_copia_produto from commandbutton within w_ge103_consulta_preco_filiais
integer x = 2048
integer y = 28
integer width = 594
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Copia C$$HEX1$$f300$$ENDHEX$$d. Produto"
end type

event clicked;String ls_Cd_Produto

ls_Cd_Produto = String(dw_1.Object.Cd_Produto[1])

Clipboard(ls_Cd_Produto)
end event

type cb_lojas_proximas from commandbutton within w_ge103_consulta_preco_filiais
integer x = 2048
integer y = 252
integer width = 594
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Lojas Pr$$HEX1$$f300$$ENDHEX$$ximas"
end type

event clicked;Long ll_Filial
Long ll_Row

String ls_ODBC

Try
	Open(w_ge103_filiais_proximas_cep)
	
	ll_Filial = Message.DoubleParm
	
	If IsNull(ll_Filial) Or ll_Filial = 0 Then
		Return -1
	End If
	
	dc_uo_odbc lo_Odbc
	lo_Odbc = Create dc_uo_odbc
	lo_Odbc.Of_atualiza_odbcs( String(ll_Filial) )
	Destroy lo_Odbc
	
	If FileExists("C:\Sistemas\RL\Exe\rl.exe") Then
		Run("C:\Sistemas\RL\Exe\rl.exe /BD"+  String(ll_Filial, '0000'))		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi localizado o sistema Retaguarda de Loja na m$$HEX1$$e100$$ENDHEX$$quina local.", Exclamation!)
	End If	
	
	Return 1
Finally
	
End Try
end event

