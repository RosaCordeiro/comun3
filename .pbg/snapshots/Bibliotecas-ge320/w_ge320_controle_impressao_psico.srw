HA$PBExportHeader$w_ge320_controle_impressao_psico.srw
forward
global type w_ge320_controle_impressao_psico from dc_w_cadastro_freeform
end type
type cb_gerar from commandbutton within w_ge320_controle_impressao_psico
end type
end forward

global type w_ge320_controle_impressao_psico from dc_w_cadastro_freeform
integer width = 1472
integer height = 508
string title = "GE320 - Relat$$HEX1$$f300$$ENDHEX$$rios da Vigil$$HEX1$$e200$$ENDHEX$$ncia Santin$$HEX1$$e100$$ENDHEX$$ria"
cb_gerar cb_gerar
end type
global w_ge320_controle_impressao_psico w_ge320_controle_impressao_psico

type variables
Boolean ivb_gera_capa, ib_erro_impressora 

long il_Ano, il_Job, il_Vias

date idt_Inicio_Mes, idt_Termino_Mes

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
end prototypes

public function boolean wf_verifica_parametro (long pl_filial);Long ll_Linhas, ll_Linha
		 
ivo_Parametro.Retrieve(pl_Filial)
ll_linhas = ivo_Parametro.RowCount()
	
If ll_linhas > 0 Then
	
	dw_1.AcceptText()
	
	For ll_linha = 1 To ll_linhas 
		
		is_Grupo						= ivo_Parametro.Object.vl_parametro	[ll_linha]
		is_Grupo_Retrieve 		= wf_Formata_Grupo(is_Grupo)
		is_Relatorio	 	  			= ivo_Parametro.Object.cd_parametro	[ll_linha]
		il_Vias       		 	  		= ivo_Parametro.Object.Nr_Vias   			[ll_linha]
			
		ivo_Enc = Create dc_uo_ds_base
		wf_gera_livro(pl_Filial, ll_linha)
		Destroy ivo_Enc
		
		If ib_erro_impressora Then Exit
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem par$$HEX1$$e200$$ENDHEX$$metros cadastrados para gerar o relat$$HEX1$$f300$$ENDHEX$$rio da filal '" + string(pl_filial) + "'.")
	Return False
End If

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
	
	If is_Relatorio = 'LIVRO' Then ll_Paginas++
	
	ll_Paginas = ll_Paginas * il_vias
	
//	Update parametro_impressao_psico
//		 set nr_paginas		= :ll_Paginas
//	 where cd_filial			= :al_Filial
//	     and cd_parametro	= :ivs_relatorio
//	     and vl_parametro	= :ivs_grupo
//		and id_periodo		= :ivs_Periodo_Parametro
//	  Using SqlCa;
//	  
//	  Choose Case SqlCa.SqlCode
//		Case -1
//			SqlCa.of_MsgDbError()
//			
//		Case Else
//			SqlCa.of_Commit()
//	  End Choose
	  
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

String	lvs_Nome_Arquivo, &
		lvs_Tipo
		
String	ls_Anual
String ls_Impressora

dw_1.AcceptText()

Open(w_Aguarde)
 
lvs_Nome_Arquivo =	String(al_filial, "0000") + "_" + is_Relatorio + "_" + is_grupo + "_" + &
							String( idt_Inicio_Mes, 'ddmm' ) + '_' +  String( idt_Termino_Mes, 'ddmm' ) + '_' + String( il_ano )
							
w_Aguarde.Title = "Gerando arquivo " + lvs_Nome_Arquivo + ". Aguarde..."

If is_Relatorio = 'LIVRO' Then
	If Not ivo.of_ChangeDataObject("dw_ge320_livro_perini") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na mudan$$HEX1$$e700$$ENDHEX$$a da DW dw_ge320_livro_perini", StopSign!)
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
		
	ls_Impressora = PrintGetPrinter ( )
	
	If MidA(ls_Impressora, 1, 10) <> "PDFCreator" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A impressora selecionada n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ PDF Creator.", StopSign!)
		ib_erro_impressora = True
		Close(w_Aguarde)
		Return False
	Else
		ib_erro_impressora = False
	End If
		
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 1)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 4)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 6)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 8)
	ivo.of_AppendWhere("p.cd_grupo_psico in (" + is_Grupo_Retrieve + ")", 10)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de relat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o previsto '" + is_Relatorio + "'.", StopSign!)
	Close(w_Aguarde)
	Return False
End If

ll_Linhas = ivo.Retrieve(al_Filial, idt_Inicio_Mes, idt_Termino_Mes, lvs_Tipo, is_Grupo_Retrieve)

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
		
		gf_Delay(2)
		
		If PrintClose(il_Job) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintClose. 1$$HEX1$$ba00$$ENDHEX$$", StopSign!)
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

// Capa do livro
If lvb_Sucesso Then
	
	gf_Delay(5)
	
	lvb_Sucesso = False
	
	If Not ivo_Capa.of_ChangeDataObject("dw_ge320_capa_livro_perini") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na mudan$$HEX1$$e700$$ENDHEX$$a da DW dw_ge320_capa_livro_perini", StopSign!)
		Close(w_Aguarde)
		Return False
	End If
	
	lvl_Retrieve = ivo_Capa.Retrieve(al_Filial, idt_Inicio_Mes, idt_Termino_Mes, lvl_Paginas, is_Responsavel_Tecnico, is_Grupo_Retrieve, lvs_Tipo)
	
	ivo_Capa.Object.Nr_Telefone_Estoque[1] = is_Telefone
	
	If lvl_Retrieve < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar informa$$HEX2$$e700f500$$ENDHEX$$es da DataStore 'dw_ge320_capa_livro_perini'.~r" + &
									 ivo_Capa.ivo_DbError.ivs_Mensagem, StopSign!)
		Close(w_Aguarde)
		Return False
	End If
	
	If IsValid(ivo_Enc) Then
		
		If Not ivo_Enc.of_ChangeDataObject("dw_ge320_encerramento_livro") Then
			Close(w_Aguarde)
			Return False
		End If
		
		If ivo_Enc.Retrieve(al_Filial, lvl_Paginas + 1) < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivo_Enc.ivo_dberror.ivs_Mensagem, StopSign!)
			Close(w_Aguarde)
			Return False
		End If
		
	End If
		
	If ivo_Capa.RowCount() > 0  Then
		
		ivb_gera_capa = True
		
		il_Job = PrintOpen(lvs_Nome_Arquivo)
		
		If il_Job = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintOpen. 2$$HEX1$$ba00$$ENDHEX$$", StopSign!)
		End If
		
		For ll_Copias = 1 To il_Vias	
			
			If wf_grava_arquivo_pdf(ivo_Capa, lvs_Nome_Arquivo, al_Filial, 1) Then
				If wf_grava_arquivo_pdf(ivo, lvs_Nome_Arquivo, al_Filial, 1) Then
					
					If IsValid(ivo_Enc) Then
						If wf_grava_arquivo_pdf(ivo_Enc, lvs_Nome_Arquivo, al_Filial, 1) Then
							lvb_Sucesso = True
						End If
					Else 
						lvb_Sucesso = True
					End If
					
				End If
			End If
		
		Next
		
		If PrintClose(il_Job) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o PrintClose. 2$$HEX1$$ba00$$ENDHEX$$", StopSign!)
		End If
		
	Else
		wf_Envia_Email("Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada para gerar a capa relat$$HEX1$$f300$$ENDHEX$$rio. '" + lvs_Nome_Arquivo + "'.")
	End If
End If

Close(w_Aguarde)

Return lvb_Sucesso
end function

on w_ge320_controle_impressao_psico.create
int iCurrent
call super::create
this.cb_gerar=create cb_gerar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
end on

on w_ge320_controle_impressao_psico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_gerar)
end on

event ue_postopen;call super::ue_postopen;// OverRide
Long ll_Mes, ll_Ano

ivo_dbError = Create dc_uo_dbError

dw_1.Event ue_AddRow()
dw_1.SetFocus()

ll_Ano = Year(Date(gvo_Parametro.of_dh_movimentacao()))
ll_Mes = Month(Date(gvo_Parametro.of_dh_movimentacao()))

If  ll_Mes = 1 Then
	ll_Mes = 12
	ll_Ano = ll_Ano - 1
Else
	ll_Mes = ll_Mes -1
End If

dw_1.Object.nr_Ano[1] = ll_Ano
dw_1.Object.nr_mes[1] = ll_Mes

ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

event open;call super::open;ivo							= Create dc_uo_ds_base
ivo_Capa					= Create dc_uo_ds_base
ivo_Parametro			= Create dc_uo_ds_base
io_Parametro_Geral	= Create uo_parametro_geral

ivo_Parametro.of_ChangeDataObject('ds_ge320_parametro')
end event

event close;call super::close;Destroy(ivo)
Destroy(ivo_Capa)
Destroy(ivo_Parametro)
Destroy(io_Parametro_Geral)
end event

type dw_visual from dc_w_cadastro_freeform`dw_visual within w_ge320_controle_impressao_psico
end type

type gb_aux_visual from dc_w_cadastro_freeform`gb_aux_visual within w_ge320_controle_impressao_psico
end type

type dw_1 from dc_w_cadastro_freeform`dw_1 within w_ge320_controle_impressao_psico
integer x = 59
integer y = 64
integer width = 1303
integer height = 100
string dataobject = "dw_ge320_selecao"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_1::itemchanged;call super::itemchanged;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

type gb_1 from dc_w_cadastro_freeform`gb_1 within w_ge320_controle_impressao_psico
integer x = 27
integer y = 16
integer width = 1362
integer height = 172
end type

type cb_gerar from commandbutton within w_ge320_controle_impressao_psico
integer x = 704
integer y = 200
integer width = 690
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Relat$$HEX1$$f300$$ENDHEX$$rio"
end type

event clicked;Long ll_Mes

dw_1.AcceptText()

ll_Mes	= dw_1.Object.Nr_Mes[1]
il_Ano		= dw_1.Object.Nr_Ano[1]

idt_Inicio_Mes			= Date( "01/" + String( ll_Mes, '00' ) + "/" + String(il_Ano) )
idt_Termino_Mes		= gf_Calcula_Ultimo_Dia_Mes( ll_Mes, il_Ano )

/*is_Responsavel_Tecnico - Essa vari$$HEX1$$e100$$ENDHEX$$vel $$HEX1$$e900$$ENDHEX$$ utilizada na fun$$HEX2$$e700e300$$ENDHEX$$o wf_gera_livro para preencher o
nome do RT na capa do relat$$HEX1$$f300$$ENDHEX$$rio*/

If Not wf_Consulta_Dados_Capa() Then
	Return -1
End If

wf_Verifica_Parametro(534)
end event

