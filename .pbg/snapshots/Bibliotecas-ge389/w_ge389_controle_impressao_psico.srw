HA$PBExportHeader$w_ge389_controle_impressao_psico.srw
forward
global type w_ge389_controle_impressao_psico from dc_w_cadastro_freeform
end type
type cb_gerar from commandbutton within w_ge389_controle_impressao_psico
end type
type st_1 from statictext within w_ge389_controle_impressao_psico
end type
end forward

global type w_ge389_controle_impressao_psico from dc_w_cadastro_freeform
integer width = 2217
integer height = 816
string title = "GE389 - Relat$$HEX1$$f300$$ENDHEX$$rios da Vigil$$HEX1$$e200$$ENDHEX$$ncia Sanit$$HEX1$$e100$$ENDHEX$$ria"
cb_gerar cb_gerar
st_1 st_1
end type
global w_ge389_controle_impressao_psico w_ge389_controle_impressao_psico

type variables
Boolean ivb_gera_capa, ib_erro_impressora 

long il_Ano, il_Job, il_Vias

date idt_Inicio_Periodo, idt_Termino_Periodo, idt_Inicial, idt_Final

string is_Grupo, is_Grupo_Retrieve, is_Relatorio, is_Responsavel_Tecnico, is_Telefone

dc_uo_ds_base ivo, ivo_Capa, ivo_Enc, ivo_Parametro

uo_parametro_geral io_Parametro_Geral


end variables

forward prototypes
public function boolean wf_verifica_parametro (long pl_filial)
public function string wf_formata_grupo (ref string ps_texto)
public function boolean wf_grava_arquivo_pdf (datastore a_ds, string as_nome, long al_filial, long pl_vias)
public function boolean wf_consulta_dados_capa ()
public function boolean wf_envia_email (string ps_mensagem)
public function boolean wf_gera_livro (integer al_filial, integer al_linha)
public function boolean wf_gera_livro_novo (integer al_filial, integer al_linha)
public function boolean wf_gera_rmv_novo (long al_filial, long al_linha)
public function boolean wf_gera_rel_rmv (long pl_filial)
public subroutine wf_inicializa_periodo ()
end prototypes

public function boolean wf_verifica_parametro (long pl_filial);Long ll_Linhas, ll_Linha
	 
ivo_Parametro.Retrieve(pl_Filial)
ll_linhas = ivo_Parametro.RowCount()
	
If ll_linhas > 0 Then
	dw_1.AcceptText()
	
	For ll_linha = 1 To ll_linhas 
		is_Grupo					= ivo_Parametro.Object.vl_parametro	[ll_linha]
		is_Grupo_Retrieve 	= wf_Formata_Grupo(is_Grupo)
		il_Vias       			= ivo_Parametro.Object.Nr_Vias   			[ll_linha]
			
		//ivo_Enc = Create dc_uo_ds_base
		If is_Relatorio="LIVRO" Then
			If Not wf_gera_livro_novo(pl_Filial, ll_linha) Then
				Return False
			End If
		End If 		
		
		If is_Relatorio = "RMV" Then 
			If Not wf_gera_rmv_novo(pl_Filial, ll_linha) Then
				Return False
			End If
		End If 				
				
		//Destroy ivo_Enc

		
		If ib_erro_impressora Then Exit
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem par$$HEX1$$e200$$ENDHEX$$metros cadastrados para gerar o relat$$HEX1$$f300$$ENDHEX$$rio da filal '" + string(pl_filial) + "'.")
	Return False
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Relat$$HEX1$$f300$$ENDHEX$$rios gerados com sucesso.")

Return True
end function

public function string wf_formata_grupo (ref string ps_texto);String ls_Grupo

Long ll_Tamanho
Long ll_Controle = 1

ll_Tamanho = LenA(ps_Texto)

If ll_Tamanho = 1 Then
	Return  "'" + ps_Texto + "'"
End If

Do While ll_Controle < ll_Tamanho
	
	ls_Grupo += "'" + MidA(ps_Texto, ll_Controle, 2) + "',"
	ll_Controle+=2
	
Loop

ls_Grupo = MidA(ls_Grupo, 1, LenA(ls_Grupo) -1)

Return ls_Grupo
end function

public function boolean wf_grava_arquivo_pdf (datastore a_ds, string as_nome, long al_filial, long pl_vias);Long ll_Paginas

a_DS.Object.DataWindow.Print.Copies = pl_Vias

If il_Job > 1 Then
	If PrintDataWindow ( il_Job, a_DS ) = -1 Then
		wf_Envia_Email("Erro ao gerar o arquivo PDF '" + as_Nome + "'.")
		Return False
	End If
	
	ll_Paginas = ivo.ivl_Numero_Paginas
	//ll_Paginas = a_DS.object.ivl_Numero_Paginas

	If is_Relatorio = 'LIVRO' Then ll_Paginas++
	
	ll_Paginas = ll_Paginas * il_vias

	  
Else
	wf_Envia_Email("Erro ao abrir o arquivo PDF '" + as_Nome + "'.")
	Return False
End If

Return True
end function

public function boolean wf_consulta_dados_capa ();String ls_Nome_Rt
String ls_Matricula
String ls_Crf

If Not io_Parametro_Geral.of_Localiza_Parametro('NR_MATRIC_RESP_TECNICO_ESTOQUE_CENTRAL', Ref ls_Matricula) Then
	Return False
End If

If Not io_Parametro_Geral.of_Localiza_Parametro('NR_CRF_RESP_TECNICO_ESTOQUE_CENTRAL', Ref ls_Crf) Then
	Return False
End If

If Not io_Parametro_Geral.of_Localiza_Parametro('NR_TELEFONE_ESTOQUE_CENTRAL', Ref is_Telefone) Then
	Return False
End If

Select nm_usuario
Into :ls_Nome_Rt
From usuario
Where nr_matricula = :ls_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o nome do Respons$$HEX1$$e100$$ENDHEX$$vel T$$HEX1$$e900$$ENDHEX$$cnico. " + SqlCa.SQLErrText)
		Return False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o nome do Respons$$HEX1$$e100$$ENDHEX$$vel T$$HEX1$$e900$$ENDHEX$$cnico. " + SqlCa.SQLErrText)
		Return False
		
End Choose

ls_Crf = "C.R.F " + ls_Crf


//Concatenando com espa$$HEX1$$e700$$ENDHEX$$os para montar a identifica$$HEX2$$e700e300$$ENDHEX$$o do respons$$HEX1$$e100$$ENDHEX$$vel t$$HEX1$$e900$$ENDHEX$$cnico na capa do relat$$HEX1$$f300$$ENDHEX$$rio
is_Responsavel_Tecnico = ls_Nome_Rt  + "                         " + ls_Crf


Return True
end function

public function boolean wf_envia_email (string ps_mensagem);String ls_Anexo[]

gf_ge202_Envia_Email_Automatico(53, "", ps_Mensagem, ls_Anexo)

Return True
end function

public function boolean wf_gera_livro (integer al_filial, integer al_linha);Boolean lvb_Sucesso = False

Long	ll_Linhas, &
		lvl_Paginas, &
		ll_Copias, &
		lvl_Retrieve

String lvs_Nome_Arquivo, &
		 lvs_Tipo,&
		 lvs_dw_dados,&
		 lvs_dw_capa,&
		 lvs_dw_encerramento
		 
						
String	ls_Anual
String    ls_Impressora

dw_1.AcceptText()

Open(w_Aguarde)
 
 
If is_Relatorio = 'LIVRO' Then
   lvs_Nome_Arquivo =	"FolhaLivroRegistroEspecifico"+"_" + is_grupo + "_" + &
								String( idt_Inicio_Periodo, 'ddmm' ) + '_' +  String( idt_Termino_Periodo, 'ddmm' ) + '_' + String( il_ano )
   lvs_dw_dados = "dw_ge389_livro_perini"
   lvs_dw_capa   = "" 
   lvs_dw_encerramento = ""	

Else 								
	lvs_Nome_Arquivo =	"RelatorioMensalVendas"+"_" + is_grupo + "_" + &
									 String( idt_Inicio_Periodo, 'ddmm' ) + '_' +  String( idt_Termino_Periodo, 'ddmm' ) + '_' + String( il_ano )
	lvs_dw_dados = "dw_ge389_dados_rmv"
	lvs_dw_capa   = ""
	lvs_dw_encerramento = ""
	ivb_gera_capa = False
End If 								
							
w_Aguarde.Title = "Gerando arquivo " + lvs_Nome_Arquivo + ". Aguarde..."

If Not ivo.of_ChangeDataObject(lvs_dw_dados) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na mudan$$HEX1$$e700$$ENDHEX$$a da DW" + lvs_dw_dados , StopSign!)
	Close(w_Aguarde)
	Return False
End If
	
If al_Linha = 1 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de selecionar a impressora PDF." + &
							  "~rDeseja Continuar?", Question!, YesNo!, 2 ) = 2 Then
		ib_erro_impressora = True
		Close(w_Aguarde)			  
		Return False
	End If
		
	If PrintSetup() = -1 Then
		ib_erro_impressora = True
		Close(w_Aguarde)
		Return False
	End If
End If
		
ls_Impressora = Trim(PrintGetPrinter ( ))


If Pos(ls_Impressora, "PDF")  = 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A impressora selecionada n$$HEX1$$e300$$ENDHEX$$o gera PDF. Este relatorio $$HEX1$$e900$$ENDHEX$$ somente gerado e enviado neste formato." , StopSign!)
	ib_erro_impressora = True
	Close(w_Aguarde)	
	Return False
Else
	ib_erro_impressora = False
End If 	
		
		
If is_Relatorio="LIVRO" Then 
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 1)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 4)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 6)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 8)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 10)
Else
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 1)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 3)
End If 


ll_Linhas = ivo.Retrieve(al_Filial, idt_Inicio_Periodo, idt_Termino_Periodo, lvs_Tipo, is_Grupo_Retrieve)

If ll_Linhas > 0 Then
	il_Job = PrintOpen(lvs_Nome_Arquivo + ".pdf")
	
	If il_Job = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintOpen. 1$$HEX1$$ba00$$ENDHEX$$", StopSign!)
		Close(w_Aguarde)
		Return False
	End If
	
	If PrintDataWindow ( il_Job, ivo ) <> -1 Then
		lvb_Sucesso = True
		lvl_Paginas = ivo.ivl_Numero_Paginas
		//gf_Delay(2)
		
		If PrintClose(il_Job) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintClose. 1$$HEX1$$ba00$$ENDHEX$$~rwf_gera_livro", StopSign!)
			Close(w_Aguarde)
			Return False
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintDataWindow. 1$$HEX1$$ba00$$ENDHEX$$", StopSign!)
		Close(w_Aguarde)
		Return false
	End If
	

	
ElseIf ll_Linhas = 0 Then
	wf_Envia_Email("Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para gerar o relat$$HEX1$$f300$$ENDHEX$$rio. '" + lvs_Nome_Arquivo + "'.")
	Close(w_Aguarde)
	Return False
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivo.ivo_dberror.ivs_Mensagem)
	Close(w_Aguarde)
	Return False
End If



If  lvb_Sucesso Then
//	gf_Delay(5)
	lvb_Sucesso = False
	
	// Capa do Livro  : Quando Tiver
	If lvs_dw_capa<>"" Then 
		If Not ivo_Capa.of_ChangeDataObject(lvs_dw_capa) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na mudan$$HEX1$$e700$$ENDHEX$$a da DW : " + lvs_dw_capa , StopSign!)
			Close(w_Aguarde)
			Return False
		End If
	
		lvl_Retrieve = ivo_Capa.Retrieve(al_Filial, idt_Inicio_Periodo, idt_Termino_Periodo, lvl_Paginas, is_Responsavel_Tecnico, is_Grupo_Retrieve, lvs_Tipo)
		ivo_Capa.Object.Nr_Telefone_Estoque[1] = is_Telefone
	
		If lvl_Retrieve < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar informa$$HEX2$$e700f500$$ENDHEX$$es da DataStore :" + lvs_dw_capa +  ivo_Capa.ivo_DbError.ivs_Mensagem, StopSign!)
			Close(w_Aguarde)
			Return False
		End If
	End If 
	
	// Encerramento do Livro : Quando Tiver
	If lvs_dw_encerramento<>"" Then 
		If IsValid(ivo_Enc) Then
			If Not ivo_Enc.of_ChangeDataObject(lvs_dw_encerramento) Then
				Close(w_Aguarde)
				Return False
			End If
			
			If ivo_Enc.Retrieve(al_Filial, lvl_Paginas + 1) < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivo_Enc.ivo_dberror.ivs_Mensagem, StopSign!)
				Close(w_Aguarde)
				Return False
			End If			
		End If	
	End If 
	
	If lvs_dw_capa<>""  Then   // Com Capa e Encerramento
		If ivo_Capa.RowCount() > 0  Then
			ivb_gera_capa = True
			il_Job = PrintOpen(lvs_Nome_Arquivo)
			If il_Job = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintOpen. 2$$HEX1$$ba00$$ENDHEX$$", StopSign!)
			End If
			
			For ll_Copias = 1 To il_Vias	
				If wf_grava_arquivo_pdf(ivo_Capa, lvs_Nome_Arquivo, al_Filial, 1) Then  // Capa
					If wf_grava_arquivo_pdf(ivo, lvs_Nome_Arquivo, al_Filial, 1) Then      // Conteudo
				   	    If IsValid(ivo_Enc) Then													
							If wf_grava_arquivo_pdf(ivo_Enc, lvs_Nome_Arquivo, al_Filial, 1) Then	  //Encerramento
								lvb_Sucesso = True
							End If
						Else 
							lvb_Sucesso = True
						End If
					End If
				End If
			Next		
		End If 
	Else           // Sem Capa e Sem Encerramento
		il_Job = PrintOpen(lvs_Nome_Arquivo)	
		If il_Job = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintOpen. 2$$HEX1$$ba00$$ENDHEX$$", StopSign!)
		End If
			
		For ll_Copias = 1 To il_Vias	
			If wf_grava_arquivo_pdf(ivo, lvs_Nome_Arquivo, al_Filial, 1) Then
				lvb_Sucesso = True
			End If 
		Next 		
	End If 
Else
	wf_Envia_Email("Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para gerar a capa relat$$HEX1$$f300$$ENDHEX$$rio. '" + lvs_Nome_Arquivo + "'.")
End If



Close(w_Aguarde)

Return lvb_Sucesso
end function

public function boolean wf_gera_livro_novo (integer al_filial, integer al_linha);Boolean lvb_Sucesso = False

datawindowchild 	ldwc_Report_Detalhes
						
Long	ll_Linhas, &
		lvl_Paginas, &
		ll_Copias, &
		lvl_Retrieve,&
		ll_Paginas

String lvs_Nome_Arquivo, &
		 lvs_Tipo,&
		 lvs_dw_dados,&
		 lvs_dw_capa,&
		 lvs_dw_encerramento,&
		 lvs_Sql_Detalhes,&
		 lvs_Anual,&
		 lvs_Impressora
		 
dc_uo_ds_base lds

Try
	
	lds = Create dc_uo_ds_base
	
	If is_Relatorio = 'LIVRO' Then
		lvs_Nome_Arquivo =	"FolhaLivroRegistroEspecifico"+"_" + is_grupo + "_" + &
									String( idt_Inicio_Periodo, 'ddmm' ) + '_' +  String( idt_Termino_Periodo, 'ddmm' ) + '_' + String( il_ano )
	
		If Not lds.of_ChangeDataObject("dw_ge389_livro_perini_composite") Then
			Return False
		End If	
	End If 
		
	If al_Linha = 1 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de selecionar a impressora PDF." + &
							  "~rDeseja Continuar?", Question!, YesNo!, 2 ) = 2 Then	  
			Return False	
		End If
			
		If PrintSetup() = -1 Then
			Return False
		End If
	End If
			
	lvs_Impressora = Trim(PrintGetPrinter ( ))
	
	If Pos(lvs_Impressora, "PDF")  = 0  Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A impressora selecionada n$$HEX1$$e300$$ENDHEX$$o gera PDF. Este relatorio $$HEX1$$e900$$ENDHEX$$ somente gerado e enviado neste formato." , StopSign!)
		Return False	
	End If 	
		
		
	Open(w_Aguarde)
	
	lvs_Sql_Detalhes = "   SELECT    p.cd_produto as cd_produto,"+&
	"         				  fa.nm_razao_social as de_fabricante,"+&
	"					      p.de_produto + ':' + p.de_apresentacao_venda + '(' + 'DCB: ' + d.cd_dcb + ' ' + d.de_dcb + ')' as de_produto, "+&
	"         				  Convert(date,'" + String(idt_Inicio_Periodo) + "') as dh_movimento,"+&
	"         0 as nr_ordem,"+&
	"         'TRANSFERIDO DO LIVRO ' + Convert(varchar,DatePart(year,DateAdd(Month,-1,   '" + String(idt_Inicio_Periodo) + "'     ))) as de_historico,"+&
	"         0 as qt_entrada,"+&
	"         0 as qt_saida,"+&
	"         0 as qt_perda,"+&
	"         (s.qt_saldo_final + x.qt_saldo_final) as qt_estoque,"+&
	"         space(60) as de_prescritor,"+&
	"         space(60) as de_obs "+&
	"    FROM produto_geral p,"+&
	"         saldo_produto s, "+&
	"         dcb_produto d,"+&
	"         fabricante fa,"+&
	"		saldo_produto x "+&
	"   WHERE p.cd_grupo_psico is not null"+&
	"     and s.cd_filial      =  534 "+&
	"     and s.cd_produto     =  p.cd_produto"+&
	"     and s.dh_saldo       =  DateAdd(Month,-1,'" + String(idt_Inicio_Periodo,'YYYYMMDD') + "')"+&
	"     and d.cd_dcb         =* p.cd_dcb"+&
	"     and fa.cd_fabricante =* p.cd_fabricante"+&
	"     and x.cd_filial      =  1"+&
	"     and x.cd_produto     =  p.cd_produto"+&
	"     and x.dh_saldo       =  DateAdd(Month,-1,'" + String(idt_Inicio_Periodo,'YYYYMMDD') + "')"+&
	"	  and p.cd_grupo_psico in ( " + is_Grupo_Retrieve + ")"+& 
	"     and ( Exists ( select *"+&
	"                    from movimento_estoque m"+&
	"	  			       where m.cd_filial_movimento = s.cd_filial"+&
	"                     and m.cd_produto          = s.cd_produto"+&
	"				         and m.dh_movimento  between '"+String(idt_Inicio_Periodo,'YYYYMMDD') +"'" +& 
	"					    and  '" + String(idt_Termino_Periodo, 'YYYYMMDD')+ "')  OR"+&
	"			EXISTS ( select *"+&
	"                    from movimento_estoque m"+&
	"	  			       where m.cd_filial_movimento = x.cd_filial"+&
	"                     and m.cd_produto          = x.cd_produto"+&
	"				         and m.dh_movimento   between '"+ String(idt_Inicio_Periodo, 'YYYYMMDD') + "'"+&
	"				         and '" +string(idt_Termino_Periodo, 'YYYYMMDD' )+ "'))"+&
	"Union      "+&							
	"  SELECT       p.cd_produto			as cd_produto,"+&	
	"         fa.nm_razao_social	as de_fabricante,"+&	
	"         p.de_produto + ' : ' + p.de_apresentacao_venda + '(' + 'DCB: ' + d.cd_dcb + ' ' + d.de_dcb + ')' as de_produto ,"+&	
	"         m.dh_movimento			as dh_movimento,"+&	
	"         1							as nr_ordem,"+&	
	"         fa.nm_razao_social	as de_fabricante,"+&	
	"         Case "+&	
	"				When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'N' ) Then m.qt_movimento"+&	
	"				When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'S' ) Then m.qt_movimento"+&	
	"				Else 0"+&
	"			End as qt_entrada,"+&	
	"			Case"+&	
	"				When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'N' ) Then m.qt_movimento"+&	
	"				When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'S' ) Then m.qt_movimento"+&	
	"				Else 0"+&	
	"			End as qt_saida,"+&	
	"			0	as qt_perda,"+&	
	"			0	as qt_estoque,"+&	
	"			'' as  de_prescritor,"+&	
	"			cl.nm_cliente + 'NF.' + Convert(varchar,m.nr_nf) as de_obs  "+&	
	" FROM  movimento_estoque	as m "+&	
	"		inner join tipo_movimento_estoque as t "+&	
	"			on t.cd_tipo_movimento = m.cd_tipo_movimento"+&	
	"		  and t.id_tipo_movimento = 'V'"+&	
	"		inner join produto_geral as p"+&	
	"			on p.cd_produto = m.cd_produto"+&	
	"		  and p.cd_grupo_psico is not null"+&	
	"		inner join filial	as f"+&	
	"			on f.cd_filial = m.cd_filial_movimento"+&	
	"		left outer join dcb_produto as d"+&	
	"			on d.cd_dcb = p.cd_dcb"+&	
	"      left outer join fabricante as fa"+&	
	"			on fa.cd_fabricante = p.cd_fabricante"+&	
	"		left outer join cliente as cl"+&	
	"			on cl.cd_cliente = m.cd_cliente "+&	
	"   WHERE m.cd_filial_movimento	= 534 "+&	
	"  and m.dh_movimento	between 	'"+ String(idt_Inicio_Periodo, 'YYYYMMDD') + "'" +&	
	"  and  '" + String(idt_Termino_Periodo, 'YYYYMMDD')+ "'"+&	 
	"  and p.cd_grupo_psico in ( " + is_Grupo_Retrieve + ")"+& 
	"	and not exists(   select *"+&	
	"							from nf_transferencia_sinistrada as sin"+&	
	"						 where m.cd_filial		= sin.cd_filial_origem"+&	
	"							  and m.nr_nf		= sin.nr_nf"+&	
	"							and m.de_especie	= sin.de_especie"+&	
	"							and m.de_serie		= sin.de_serie )"+&	
	"Union      "+&	
	" SELECT         p.cd_produto as cd_produto," +&	
	"      fa.nm_razao_social as de_fabricante," +& 
	"      p.de_produto + ':' + p.de_apresentacao_venda + '(' + 'DCB: ' + d.cd_dcb + ' ' + d.de_dcb + ')' as de_produto, "+&
	"      m.dh_movimento as dh_movimento,"+&
	"      1 as nr_ordem," +&
	"      'TRANSFERENCIA' as de_historico," +&
	"       Case "+&
	"	   	  When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'N' ) Then m.qt_movimento "+&
	"          When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'S' ) Then m.qt_movimento "+&
	"          Else 0 "+&
	"  	    End as qt_entrada,"+&
	"       Case "+&
	"          When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'N' ) Then m.qt_movimento"+&
	"          When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'S' ) Then m.qt_movimento"+&
	"          Else 0"+&
	"  	    End as qt_saida,"+&
	"       0 as qt_perda,"+&
	"       0 as qt_estoque,"+&
	"       f.nr_cgc as de_prescritor,"+&
	"       Case "+&
	"          When m.cd_filial = 1 Then 'ESTOQUE CENTRAL NF.'+ Convert(varchar,m.nr_nf) "+&
	"          Else f.nm_fantasia + 'NF.' + Convert(varchar,m.nr_nf) End as de_obs    "+&
	" FROM  movimento_estoque m, "+&
	"	   tipo_movimento_estoque t,"+&
	"      produto_geral p,"+&
	"      filial f,"+&
	"      dcb_produto d,"+&
	"      fabricante fa   "+&
	"   WHERE  m.cd_filial_movimento = 534 "+&
	"  and m.dh_movimento	between 	 '"+ String(idt_Inicio_Periodo, 'YYYYMMDD') + "'" +&	
	"  and  '" + String(idt_Termino_Periodo, 'YYYYMMDD')+ "'"+&	 
	"  and t.cd_tipo_movimento   = m.cd_tipo_movimento"+&	 
	"  and t.id_tipo_movimento = 'T' "+&	 
	"  and p.cd_grupo_psico in ( " + is_Grupo_Retrieve + ")"+& 
	"  and p.cd_produto          = m.cd_produto"+&	 
	"  and p.cd_grupo_psico is not null"+&	 
	"  and d.cd_dcb              =* p.cd_dcb"+&	 
	"  and fa.cd_fabricante      =* p.cd_fabricante"+&	 
	"  and f.cd_filial           = m.cd_filial "+&	 
	"	and not exists(   select *"+&	 
	"							from nf_transferencia_sinistrada as sin"+&	 
	"						 where m.cd_filial		= sin.cd_filial_origem"+&	 
	"							  and m.nr_nf		= sin.nr_nf"+&	 
	"							and m.de_especie	= sin.de_especie"+&	 
	"							and m.de_serie		= sin.de_serie )"+&	 
	"Union     "+&	 
	" SELECT        p.cd_produto as cd_produto,"+&
	"        fa.nm_razao_social as de_fabricante,"+&
	"       p.de_produto + ':' + p.de_apresentacao_venda + '(' + 'DCB: ' + d.cd_dcb + ' ' + d.de_dcb + ')' as de_produto, "+&
	"	    m.dh_movimento as dh_movimento,"+&
	"		1 as nr_ordem,"+&
	"		f.nm_fantasia + ' NF. ' + Convert(varchar,m.nr_nf) as de_historico ,"+&
	"		Case " +&
	"			When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'N' ) Then m.qt_movimento "+&
	"			When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'S' ) Then m.qt_movimento "+&
	"			Else 0 "+&
	"		End as qt_entrada,"+& 
	"		Case "+&
	"			When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'N' ) Then m.qt_movimento "+&
	"			When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'S' ) Then m.qt_movimento "+&
	"			Else 0 "+&
	"		End as  qt_saida,"+&
	"		0 as qt_perda,"+&
	"		0 as qt_estoque,"+&
	"		fa.nr_cgc as de_prescritor,"+&
	"		t.de_tipo_movimento as de_obs    "+&
	"  FROM movimento_estoque m,"+&
	"	   tipo_movimento_estoque t,"+&
	"      produto_geral p,"+&
	"      fornecedor f,"+&
	"      dcb_produto d,"+&
	"      fabricante fa  "+&
	"   WHERE  m.cd_filial_movimento = 534 "+&
	"  and m.dh_movimento	between 	 '"+ String(idt_Inicio_Periodo, 'YYYYMMDD') + "'" +&	
	"  and  '" + String(idt_Termino_Periodo, 'YYYYMMDD')+ "'"+&	 
	"  and p.cd_grupo_psico in ( " + is_Grupo_Retrieve + ")"+& 
	"  and t.cd_tipo_movimento   = m.cd_tipo_movimento"+&	 
	"  and t.id_tipo_movimento   = 'C'  "+&	 
	"  and p.cd_produto          = m.cd_produto "+&	 
	"  and p.cd_grupo_psico is not null"+&	 
	"  and d.cd_dcb              =* p.cd_dcb"+&	 
	"  and fa.cd_fabricante      =* p.cd_fabricante"+&	 
	"  and f.cd_fornecedor       = m.cd_fornecedor"+&	 
	"	and not exists(   select * "+&	 
	"							from nf_transferencia_sinistrada as sin"+&	 
	"						 where m.cd_filial		= sin.cd_filial_origem"+&	 
	"							  and m.nr_nf		= sin.nr_nf"+&	 
	"							and m.de_especie	= sin.de_especie"+&	 
	"							and m.de_serie		= sin.de_serie )"+&	 
	"Union     "+&	 
	" SELECT        p.cd_produto as cd_produto,"+&
	"        fa.nm_razao_social  as  de_fabricante,"+&
	"        p.de_produto + ':' + p.de_apresentacao_venda + '(' + 'DCB: ' + d.cd_dcb + ' ' + d.de_dcb + ')' as de_produto, "+&
	"		 m.dh_movimento as dh_movimento,"+&
	"	     1 as nr_ordem,"+&
	"		  'PERDA' as de_historico,"+&
	"	 	  0 as qt_entrada,"+&
	"		  0 as qt_saida,"+&
	"		  Case  "+&
	"		     When ( t.id_entrada_saida = 'S' ) Then m.qt_movimento "+&
	"			  Else 0 "+&
	"		  End as qt_perda,"+&
	"		  0 as qt_estoque,"+&
	"	     space(40) as de_prescritor,"+&
	"		  'ENTREGA VIG.SANITARIA' as de_obs    " +&
	"  FROM   movimento_estoque m, "+&
	"	   tipo_movimento_estoque t,"+&
	"      produto_geral p,"+&
	"      dcb_produto d,"+&
	"      fabricante fa "+&
	"   WHERE  m.cd_filial_movimento = 534 "+&
	"  and  m.dh_movimento	between 	 '"+ String(idt_Inicio_Periodo, 'YYYYMMDD') + "'" +&	
	"  and  '" + String(idt_Termino_Periodo, 'YYYYMMDD')+ "'"+&	 
	"  and p.cd_grupo_psico in ( " + is_Grupo_Retrieve + ")"+& 
	"  and t.cd_tipo_movimento   = m.cd_tipo_movimento"+&
	"  and t.id_tipo_movimento   = 'A' "+&
	"  and p.cd_produto          = m.cd_produto "+&
	"  and p.cd_grupo_psico is not null "+&
	"  and d.cd_dcb              =* p.cd_dcb  "+&
	"  and fa.cd_fabricante      =* p.cd_fabricante  "+&
	"	and not exists(   select * "+&
	"							from nf_transferencia_sinistrada as sin "+&
	"						 where m.cd_filial		= sin.cd_filial_origem "+&
	"							  and m.nr_nf		= sin.nr_nf "+&
	"							and m.de_especie	= sin.de_especie "+&
	"							and m.de_serie		= sin.de_serie )	 "
													
	If lds.getchild('dw_2', ldwc_Report_Detalhes) = -1 Then
		MessageBox("Aviso", "Erro no getchild da 'ldwc_Report_Detalhe'")
		Return False
	End If
		
	If ldwc_Report_Detalhes.SetTransObject(SqlCa) = -1 Then
		MessageBox("Aviso", "Erro no settransobject da 'ldwc_Report_Detalhe'")
		Return False
	End If
		
	If ldwc_Report_Detalhes.SetSQLSelect(lvs_Sql_Detalhes) = -1 Then
		MessageBox("Aviso", "Erro no setsqlselect da 'ldwc_Report_Detalhe'")
		Return False
	End If	
	
	ll_Linhas = ldwc_Report_Detalhes.Retrieve()
		
	If ll_Linhas = -1 Then
		MessageBox("Aviso", "Erro no retrieve da 'ldwc_Report_Detalhes': " + SQLCA.SQLErrText)
		Return False
	End If		
	
	If ll_Linhas > 0 Then		
		ll_Paginas = ldwc_Report_Detalhes.GetItemNumber(1, "nr_paginas")
		
		lds.object.dw_1.object.t_pagina_inicia.text 	= string(ll_Paginas) 
		lds.object.dw_2.object.t_4.text 					= string(is_grupo) 
		lds.object.dw_3.object.t_pagina_encerra.text = string(ll_Paginas) 	
		
		Try
			il_Job = PrintOpen(lvs_Nome_Arquivo + ".pdf")
			
			If il_Job = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintOpen. 1$$HEX1$$ba00$$ENDHEX$$", StopSign!)
				Return False
			End If
			
			For ll_Copias = 1 To il_Vias
				If PrintDataWindow ( il_Job, lds ) = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintClose. 1$$HEX1$$ba00$$ENDHEX$$~rwf_gera_livro_novo", StopSign!)
					Return False
				End If
			Next
		Finally
			PrintClose(il_Job)
			SetNull(ll_Paginas)
			SetNull(is_grupo)
		End Try
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ informa$$HEX2$$e700f500$$ENDHEX$$es de movimento para o grupo psico (" + is_Grupo_Retrieve + ")")
	End If
		
	Return True
	
Finally
	Destroy(lds)
	Close(w_Aguarde)
End Try
end function

public function boolean wf_gera_rmv_novo (long al_filial, long al_linha);Boolean lvb_Sucesso = False


datawindowchild 	ldwc_Report_Detalhes
						
				
Long	ll_Linhas, &
		lvl_Paginas, &
		ll_Copias, &
		lvl_Retrieve,&
		ll_Paginas

String lvs_Nome_Arquivo, &
		 lvs_Tipo,&
		 lvs_dw_dados,&
		 lvs_dw_capa,&
		 lvs_dw_encerramento,&
		 lvs_Sql_Detalhes,&
		 lvs_Anual,&
		 lvs_Impressora
		 
dc_uo_ds_base lds


Try
	
	lds = Create dc_uo_ds_base
	
	If is_Relatorio = 'RMV' Then
		lvs_Nome_Arquivo =	"RelatorioMensalVendas"+"_" + is_grupo + "_" + &
									 String( idt_Inicio_Periodo, 'ddmm' ) + '_' +  String( idt_Termino_Periodo, 'ddmm' ) + '_' + String( il_ano )
		
		If Not lds.of_ChangeDataObject("dw_ge389_rmv_composite") Then
			Return False
		End If	
	End If 
		
	If al_Linha = 1 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de selecionar a impressora PDF." + &
							  "~rDeseja Continuar?", Question!, YesNo!, 2 ) = 2 Then	  
			Return False	
		End If
			
		If PrintSetup() = -1 Then
			Return False
		End If
	End If
			
	lvs_Impressora = Trim (PrintGetPrinter ( ))
	
	If Pos(lvs_Impressora, "PDF")  = 0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A impressora selecionada n$$HEX1$$e300$$ENDHEX$$o gera PDF. Este relatorio $$HEX1$$e900$$ENDHEX$$ somente gerado e enviado neste formato." , StopSign!)
		Return False	
	End If 
	
	
	Open(w_Aguarde)
	
	
	lvs_Sql_Detalhes = " SELECT	 p.cd_produto			as cd_produto,  "+&
	" 		fa.nm_razao_social	as de_fabricante, "+&
	" 		p.de_produto + ':' + p.de_apresentacao_venda + '(' + 'DCB: ' + d.cd_dcb + ' ' + d.de_dcb + ')' as de_produto,  "+&
	" 		m.dh_movimento		as dh_movimento, "+&
	" 		1							as nr_ordem,   "+&
	" 		fa.nm_razao_social	as de_fabricante, "+&
	" 		Case  " +&
	" 			When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'N' ) Then m.qt_movimento  "+&
	" 			When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'S' ) Then m.qt_movimento "+&
	" 			Else 0     "+&
	" 		End as qt_entrada, "+&
	" 		Case  "+&
	" 			When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'N' ) Then m.qt_movimento "+&
	" 			When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'S' ) Then m.qt_movimento "+&
	" 			Else 0  "+&
	" 		End as qt_saida,  "+&
	" 		0	as qt_perda,   "+&
	" 		0	as qt_estoque, "+&
	" 		'' as  de_prescritor, "+& 
	" 		cl.nm_cliente + '-NF:' + Convert(varchar,m.nr_nf) as de_obs, "+&
	" 		p.de_produto as 'Medicamento',  "+&
	" 		p.de_apresentacao_venda as 'ApresVenda' , "+&
	" 		j.nm_fantasia as  'NFilial', "+&
	" 		j.nr_cgc as 'cgc' , "+&
	" 		'SC' as 'uf'	, "+&
	" 		dcb.de_dcb as 'dcb' ,  "+&
	" 		Convert(varchar,m.nr_nf) as 'NF' ,  "+&
	" 		lte.nr_lote as 'Lote' ,   "+&
	" 		dcb.cd_dcb as 'cd_dcb'  "+&
	" FROM 	movimento_estoque	as m    "+&
	" INNER JOIN  tipo_movimento_estoque as t on t.cd_tipo_movimento = m.cd_tipo_movimento    "+&
	" INNER JOIN  produto_geral as p 	on p.cd_produto = m.cd_produto	  and p.cd_grupo_psico is not null "+&
	" INNER JOIN  filial	as f	on f.cd_filial = m.cd_filial_movimento   "+&
	" LEFT OUTER JOIN dcb_produto as d 	on d.cd_dcb = p.cd_dcb  "+&
	" LEFT OUTER JOIN fabricante as fa 		on fa.cd_fabricante = p.cd_fabricante  "+&
	" LEFT OUTER JOIN cliente as cl 	on cl.cd_cliente = m.cd_cliente  "+&
	" INNER JOIN filial j on j.cd_filial = m.cd_filial_movimento  "+&
	" INNER JOIN item_nf_transferencia_lote lte on  	lte.cd_produto = p.cd_produto  "+&
	" 			and 	lte.cd_filial_origem =m.cd_filial_movimento   "+&
	" 			and   lte.nr_nf = m.nr_nf  "+&
	" INNER JOIN dcb_produto dcb on dcb.cd_dcb = p.cd_dcb   "+&
	" WHERE m.cd_filial_movimento	= 534    "+&
	"  and p.cd_grupo_psico = " + is_Grupo_Retrieve +&
	"  and     m.dh_movimento	between 	'"+ String(idt_Inicio_Periodo, 'YYYYMMDD') + "'" +&	
	"  and  '" + String(idt_Termino_Periodo, 'YYYYMMDD')+ "'"+&	 
	"  and  t.id_tipo_movimento = 'V'  "+&
	" and not exists(   select *   "+&
	" 						from nf_transferencia_sinistrada as sin   "+&
	" 						where m.cd_filial		= sin.cd_filial_origem  "+&
	" 						and m.nr_nf		= sin.nr_nf   "+&
	" 						and m.de_especie	= sin.de_especie  "+&
	" 						and m.de_serie		= sin.de_serie )   "+&
	" UNION     "+& 
	"  SELECT	  p.cd_produto as 'cd_produto'  ,   "+&
	" 			fa.nm_razao_social as  'de_fabricante',  "+&
	" 			p.de_produto + ':' + p.de_apresentacao_venda + '(' + 'DCB: ' + d.cd_dcb + ' ' + d.de_dcb + ')'  as de_produto,  "+&
	" 			m.dh_movimento as 'dh_movimento',  "+&
	" 			1 as 'nr_ordem',  "+&
	" 	       'TRANSFERENCIA' as de_historico,   "+&
	" 			Case   	When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'N' ) Then m.qt_movimento   "+&
	" 				         When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'S' ) Then m.qt_movimento   "+&
	" 	          Else 0 	    End as qt_entrada,   "+& 
	" 			Case    When ( t.id_entrada_saida = 'S' and t.id_cancelamento = 'N' ) Then m.qt_movimento   "+& 
	" 				        When ( t.id_entrada_saida = 'E' and t.id_cancelamento = 'S' ) Then m.qt_movimento   "+&
	"    		       Else 0 	    End  as qt_saida,   "+&
	" 		    0 as qt_perda,   "+&
	" 			0 as qt_estoque,  "+&
	" 			f.nr_cgc as de_prescritor, "+&  
	" 			Case   When m.cd_filial = 1 Then 'ESTOQUE CENTRAL NF. ' + Convert(varchar,m.nr_nf)  "+&
	"           	Else f.nm_fantasia + '-NF:' + Convert(varchar,m.nr_nf) End as de_obs,   "+&
	" 			p.de_produto as Medicamento ,   "+&
	" 			p.de_apresentacao_venda as ApresVenda,  "+&
	" 			f.nm_fantasia as NFilial,   "+&
	" 			f.nr_cgc as cgc,    "+&
	" 			'SC' as uf,    "+&
	" 			dcb.de_dcb as dcb,   "+& 
	" 			Convert(varchar,m.nr_nf) as NF,   "+& 
	" 			lte.nr_lote as Lote,   "+&
	" 			dcb.cd_dcb  as cd_dcb    "+&
	"  FROM		movimento_estoque m,   "+&
	" 			tipo_movimento_estoque t,  "+&
	" 			produto_geral p,  "+&
	" 			filial f,   "+&
	" 			dcb_produto d,  "+&
	" 			fabricante fa ,   "+&
	" 			dcb_produto dcb ,   "+& 
	" 			item_nf_transferencia_lote lte    "+& 
	"  WHERE  m.cd_filial_movimento = 534        "+&  
	"  and     m.dh_movimento	between 	'"+ String(idt_Inicio_Periodo, 'YYYYMMDD') + "'" +&	
	"  and  '" + String(idt_Termino_Periodo, 'YYYYMMDD')+ "'"+&	 
	"  and t.cd_tipo_movimento   = m.cd_tipo_movimento   " +& 
	"  and  t.id_tipo_movimento = 'T'  "+&
	"  and p.cd_produto          = m.cd_produto  "+&
	"  and p.cd_grupo_psico is not null    "+&
	"  and p.cd_grupo_psico = " + is_Grupo_Retrieve +&	
	"  and d.cd_dcb              =* p.cd_dcb   "+&
	"  and fa.cd_fabricante      =* p.cd_fabricante   "+& 
	"  and f.cd_filial           = m.cd_filial     "+& 
	"  and dcb.cd_dcb = p.cd_dcb    "+& 
	"  and lte.cd_produto = p.cd_produto   "+& 
	"  and lte.cd_filial_origem =m.cd_filial_movimento   "+& 
	"  and lte.nr_nf = m.nr_nf    "+& 
	"  and not exists(   select *    "+& 
	" 						from nf_transferencia_sinistrada as sin   "+& 
	" 					 where m.cd_filial		= sin.cd_filial_origem   "+& 
	" 					  and m.nr_nf		= sin.nr_nf     "+& 
	" 					and m.de_especie	= sin.de_especie   "+& 
	" 					and m.de_serie		= sin.de_serie )   "

					
	If lds.getchild('dw_2', ldwc_Report_Detalhes) = -1 Then
		MessageBox("Aviso", "Erro no getchild da 'ldwc_Report_Detalhe'")
		Return False
	End If
		
	If ldwc_Report_Detalhes.SetTransObject(SqlCa) = -1 Then
		MessageBox("Aviso", "Erro no settransobject da 'ldwc_Report_Detalhe'")
		Return False
	End If
		
	If ldwc_Report_Detalhes.SetSQLSelect(lvs_Sql_Detalhes) = -1 Then
		MessageBox("Aviso", "Erro no setsqlselect da 'ldwc_Report_Detalhe'")
		Return False
	End If	
	
	ll_Linhas = ldwc_Report_Detalhes.Retrieve()
		
	If ll_Linhas = -1 Then
		MessageBox("Aviso", "Erro no retrieve da 'ldwc_Report_Detalhes'")
		Return False
	End If		
	
	If ll_Linhas > 0 Then	
		
		lds.object.dw_1.object.t_6.text = String(idt_Inicio_Periodo, 'MM') + '/' + String( il_ano )
		lds.object.dw_2.object.t_2.text = string (is_grupo) 

		Try
			il_Job = PrintOpen(lvs_Nome_Arquivo + ".pdf")
			
			If il_Job = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintOpen. 1$$HEX1$$ba00$$ENDHEX$$", StopSign!)
				Return False
			End If
			
			For ll_Copias = 1 To il_Vias
				If PrintDataWindow ( il_Job, lds ) = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintClose. 1$$HEX1$$ba00$$ENDHEX$$~rwf_rmv_novo", StopSign!)
					Return False
				End If
			Next
		Catch (RunTimeError RTE)
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', RTE.getmessage())
		Finally
			PrintClose(il_Job)
		End Try
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintDataWindow. 1$$HEX1$$ba00$$ENDHEX$$", StopSign!)
		Return False
	End If
		
	Return True
	
Finally
	Destroy(lds)
	Close(w_Aguarde)
End Try

end function

public function boolean wf_gera_rel_rmv (long pl_filial);Long ll_Linhas, ll_Linha

	 
ivo_Parametro.Retrieve(pl_Filial)
ll_linhas = ivo_Parametro.RowCount()

If ll_linhas > 0 Then
	dw_1.AcceptText()
	
	For ll_linha = 1 To ll_linhas 
		is_Grupo					= ivo_Parametro.Object.vl_parametro	[ll_linha]
		is_Grupo_Retrieve 	= wf_Formata_Grupo(is_Grupo)
		is_Relatorio	 	  	= ivo_Parametro.Object.cd_parametro	[ll_linha]
		il_Vias       		 	= ivo_Parametro.Object.Nr_Vias   			[ll_linha]
			
		//ivo_Enc = Create dc_uo_ds_base
		If is_Relatorio="LIVRO" Then
			If Not wf_gera_livro_novo(pl_Filial, ll_linha) Then
				Return False
			End If
		End If 		
		
		If is_Relatorio = "RMV" Then 
			If Not wf_gera_rmv_novo(pl_Filial, ll_linha) Then
				Return False
			End If
		End If 				
				
		//Destroy ivo_Enc

		
		If ib_erro_impressora Then Exit
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem par$$HEX1$$e200$$ENDHEX$$metros cadastrados para gerar o relat$$HEX1$$f300$$ENDHEX$$rio da filal '" + string(pl_filial) + "'.")
	Return False
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Relat$$HEX1$$f300$$ENDHEX$$rios gerados com sucesso.")

Return True
end function

public subroutine wf_inicializa_periodo ();Integer	li_Ano, li_Mes, li_Semestre
String	ls_periodo	//M=mensal; S=semestral

ls_periodo = dw_1.Object.id_periodo [1]
li_Ano     = Year  (Date (gvo_Parametro.of_dh_movimentacao ()))
li_Mes     = Month (Date (gvo_Parametro.of_dh_movimentacao ()))

If ls_periodo = 'M' then
	If li_Mes = 1 then
		li_Mes = 12
		li_Ano = li_Ano - 1
	else
		li_Mes = li_Mes - 1
	End if
	
	dw_1.Object.nr_mes [1] = li_Mes
else
	If li_Mes < 7 then
		li_Semestre = 2
		li_Ano      = li_Ano - 1
	else
		li_Semestre = 1
	End if
	
	dw_1.Object.nr_semestre [1] = li_Semestre
End if

dw_1.Object.nr_Ano[1] = li_Ano

Return
end subroutine

on w_ge389_controle_impressao_psico.create
int iCurrent
call super::create
this.cb_gerar=create cb_gerar
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
this.Control[iCurrent+2]=this.st_1
end on

on w_ge389_controle_impressao_psico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_gerar)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;// OverRide
ivo_dbError = Create dc_uo_dbError

dw_1.Event ue_AddRow()
dw_1.SetFocus()

wf_inicializa_periodo ()

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

event open;call super::open;ivo							= Create dc_uo_ds_base
ivo_Capa					= Create dc_uo_ds_base
ivo_Parametro			= Create dc_uo_ds_base
io_Parametro_Geral	= Create uo_parametro_geral

ivo_Parametro.of_ChangeDataObject('ds_ge389_parametro')
end event

event close;call super::close;Destroy(ivo)
Destroy(ivo_Capa)
Destroy(ivo_Parametro)
Destroy(io_Parametro_Geral)
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge389_controle_impressao_psico
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge389_controle_impressao_psico
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge389_controle_impressao_psico
integer x = 32
integer y = 32
integer width = 2085
integer height = 412
string dataobject = "dw_ge389_selecao"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_1::itemchanged;call super::itemchanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

Choose case Lower (dwo.Name)
	case 'id_relatorio'
		Choose case data
			case 'A'
				This.Post SetItem (row, 'id_periodo', 'S')
			case 'V'
				This.Post SetItem (row, 'id_periodo', 'M')
		End choose
		
		Post wf_inicializa_periodo ()
		
	case 'id_periodo'
		Post wf_inicializa_periodo ()
		
End choose
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge389_controle_impressao_psico
integer x = 27
integer y = 0
integer width = 2112
integer height = 464
end type

type cb_gerar from commandbutton within w_ge389_controle_impressao_psico
integer x = 718
integer y = 496
integer width = 731
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Relat$$HEX1$$f300$$ENDHEX$$rio"
end type

event clicked;Integer	li_Mes

dw_1.AcceptText ()

il_Ano = dw_1.Object.Nr_Ano [1]

Choose case dw_1.Object.id_periodo [1]
	case 'M'
		li_Mes = dw_1.Object.Nr_Mes [1]
		
		idt_Inicio_Periodo  = Date ('01/' + String (li_Mes, '00') + '/' + String (il_Ano))
		idt_Termino_Periodo = gf_Calcula_Ultimo_Dia_Mes (li_Mes, il_Ano)
		
	case 'S'
		Choose case dw_1.Object.nr_semestre [1]
			case 1
				idt_Inicio_Periodo  = Date ('01/01/' + String (il_Ano))
				idt_Termino_Periodo = Date ('30/06/' + String (il_Ano))
				
			case 2
				idt_Inicio_Periodo  = Date ('01/07/' + String (il_Ano))
				idt_Termino_Periodo = Date ('31/12/' + String (il_Ano))
		End choose
		
End choose

Choose case dw_1.Object.id_relatorio [1]
	case 'A'	//Relat$$HEX1$$f300$$ENDHEX$$rio solicitado pela ANVISA
		If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o!', &
							'A gera$$HEX2$$e700e300$$ENDHEX$$o do Livro de Registro Espec$$HEX1$$ed00$$ENDHEX$$fico consome um grande volume de recursos e deve ser feita em m$$HEX1$$e100$$ENDHEX$$quina local.' + '~n~r~r' + &
							'Deseja continuar?', &
							Question!, YesNo!, 2) = 2 then
			Return
		End if
		
		is_Relatorio = 'LIVRO'
	case 'V'	//Relat$$HEX1$$f300$$ENDHEX$$rio solicitado pela VISA
		is_Relatorio = 'RMV'
End choose

If Not wf_Consulta_Dados_Capa () then
	Return
End if

wf_Verifica_Parametro (534)

Return 1
end event

type st_1 from statictext within w_ge389_controle_impressao_psico
integer x = 27
integer y = 464
integer width = 2112
integer height = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 8421376
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

