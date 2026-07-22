HA$PBExportHeader$w_ge128_atualizar_estoque_minimo_excel.srw
forward
global type w_ge128_atualizar_estoque_minimo_excel from dc_w_sheet
end type
type cb_2 from commandbutton within w_ge128_atualizar_estoque_minimo_excel
end type
type pb_1 from picturebutton within w_ge128_atualizar_estoque_minimo_excel
end type
type sle_1 from singlelineedit within w_ge128_atualizar_estoque_minimo_excel
end type
type st_1 from statictext within w_ge128_atualizar_estoque_minimo_excel
end type
type gb_1 from groupbox within w_ge128_atualizar_estoque_minimo_excel
end type
type cb_1 from commandbutton within w_ge128_atualizar_estoque_minimo_excel
end type
type dw_1 from dc_uo_dw_base within w_ge128_atualizar_estoque_minimo_excel
end type
end forward

global type w_ge128_atualizar_estoque_minimo_excel from dc_w_sheet
integer width = 2418
integer height = 660
string title = "GE128 - Atualizar o Estoque M$$HEX1$$ed00$$ENDHEX$$nimo Via Excel"
cb_2 cb_2
pb_1 pb_1
sle_1 sle_1
st_1 st_1
gb_1 gb_1
cb_1 cb_1
dw_1 dw_1
end type
global w_ge128_atualizar_estoque_minimo_excel w_ge128_atualizar_estoque_minimo_excel

type variables
Long ivl_Index
end variables

forward prototypes
public function boolean wf_valida_filial (long al_filial)
public function long wf_atualiza ()
public function boolean wf_valida_filial_promocao (long al_filial, long al_promocao)
public function boolean wf_valida_produto (long al_produto, ref long al_fator_conversao)
public function boolean wf_atualiza_estoque_minimo (long al_promocao, long al_filial, long al_produto, long al_estoque_minimo, long al_motivo)
public function boolean wf_valida_promocao (long al_promocao, ref string as_tipo_promocao)
end prototypes

public function boolean wf_valida_filial (long al_filial);Long lvl_Qtde


select Count(*) 
Into :lvl_Qtde
from filial
where cd_filial = :al_filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Qtde > 0 Then
			Return True
		End If
		
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial.")	
		
End Choose

Return False
end function

public function long wf_atualiza ();Any lva_Dado

Boolean lvb_Altera
	 
Long lvl_Linha, lvl_Linhas, lvl_Promocao, lvl_Filial, lvl_Produto, lvl_Estoque_Minimo, ll_Fator, lvl_Sucesso = 1

String	lvs_Arquivo,&
		ls_Filias_Nao_Atualizadas	= "",&
		ls_Parametro,&
		ls_Tipo_Promocao

dc_uo_excel lvo_Excel

ivl_Index = 0

lvs_Arquivo = sle_1.Text

lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando o estoque m$$HEX1$$ed00$$ENDHEX$$nimo..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas
			
			lvb_Altera = True
			
			// Promo$$HEX2$$e700e300$$ENDHEX$$o
			lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
									
			If Not wf_valida_promocao(lva_Dado, Ref ls_Tipo_Promocao) Then
				ivl_Index += 1
				gvs_Log[ivl_Index] = "Promo$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lida '" + String(lva_Dado) + "' na linha '" + String(lvl_Linha) + "'.~r~n"
				lvl_Sucesso 	= 0
				lvb_Altera 		= False
			End If
			lvl_Promocao = Long(lva_Dado)
			
			//Filial
			lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
			
			If Not wf_valida_filial(lva_Dado) Then
				ivl_Index += 1
				gvs_Log[ivl_Index] = "Filial inv$$HEX1$$e100$$ENDHEX$$lida '" + String(lva_Dado) + "' na linha '" + String(lvl_Linha) + "'.~r~n"
				lvl_Sucesso 	= 0
				lvb_Altera 		= False
			End If
			lvl_Filial = Long(lva_Dado)
			
			If Not wf_valida_filial_promocao(lvl_Filial, lvl_Promocao) Then
				ivl_Index += 1
				gvs_Log[ivl_Index] = "A filial  '" + String(lvl_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o pertence a promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(lvl_Promocao) + "' na linha '" + String(lvl_Linha) + "'.~r~n"
				lvl_Sucesso 	= 0
				lvb_Altera 		= False
			End If
						
			//Produto
			lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
			
			If Not wf_valida_produto(Long(lva_Dado), Ref ll_Fator) Then
				ivl_Index += 1
				gvs_Log[ivl_Index] = "Produto inv$$HEX1$$e100$$ENDHEX$$lido '" + String(lva_Dado) + "' na linha '" + String(lvl_Linha) + "'.~r~n"
				lvl_Sucesso 	= 0
				lvb_Altera 		= False
			End If
			lvl_Produto = Long(lva_Dado)
						
			// Estoque m$$HEX1$$ed00$$ENDHEX$$nimo			
			lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "D")
			
			If ClassName(lva_Dado) <> "double" Then
				ivl_Index += 1
				gvs_Log[ivl_Index] = "Estoque m$$HEX1$$ed00$$ENDHEX$$nimo inv$$HEX1$$e100$$ENDHEX$$lido '" + String(lva_Dado) + "' na linha '" + 	String(lvl_Linha) + "'.~r~n"
				lvl_Sucesso 	= 0
				lvb_Altera 		= False
			End If
			lvl_Estoque_Minimo = Long(lva_Dado)
			
			If IsNull(lvl_Estoque_Minimo) or lvl_Estoque_Minimo < 0 Then lvl_Estoque_Minimo = 0

			//Tratamento para n$$HEX1$$e300$$ENDHEX$$o deixar se o fator de convers$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o for m$$HEX1$$fa00$$ENDHEX$$ltiplo
			If lvl_Estoque_Minimo > 0 And ll_Fator > 0 Then
				If Mod(lvl_Estoque_Minimo, ll_Fator) <> 0 Then
					ivl_Index += 1
					gvs_Log[ivl_Index] = "Estoque m$$HEX1$$ed00$$ENDHEX$$nimo do produto '" + String(lvl_Produto) + "' deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Fator) + "' utilizado no estoque central na linha '" + String(lvl_Linha) + "'.~r~n"
					lvl_Sucesso 	= 0
					lvb_Altera 		= False
				End If
			End If
		
			If lvb_Altera Then
				
				If ls_Tipo_Promocao <> "P"  Then    // Promocao N$$HEX1$$e300$$ENDHEX$$o Planograma
					//Verifica se vai ser atulizado no SAP
					If Not gf_filial_administrada_sap(lvl_Filial, Ref ls_Parametro) Then
						Return 1
					End If
				
					If ls_Parametro = "S" Then
						If ls_Filias_Nao_Atualizadas = "" Then
							ls_Filias_Nao_Atualizadas	= String(lvl_Filial)
						Else
							ls_Filias_Nao_Atualizadas	+= ", "+String(lvl_Filial)
						End If
					Else
						If Not wf_Atualiza_Estoque_Minimo(lvl_Promocao, lvl_Filial, lvl_Produto, lvl_Estoque_Minimo, dw_1.Object.Cd_Motivo[1]) Then
							lvl_Sucesso = 0
							Exit
						End If
					End If
				Else
					// Para Prom. Tipo Planograma Atualiza Direto	
					If Not wf_Atualiza_Estoque_Minimo(lvl_Promocao, lvl_Filial, lvl_Produto, lvl_Estoque_Minimo, dw_1.Object.Cd_Motivo[1]) Then
						lvl_Sucesso = 0
						Exit
					End If
				End If 					
			End If
															
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
		
		If ls_Filias_Nao_Atualizadas <> "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para a altera$$HEX2$$e700e300$$ENDHEX$$o das filiais "+ls_Filias_Nao_Atualizadas+" deve ser utilizada o SAP.~rAs demais filiais formam atualizadas com sucesso.")
		End If
	  
	Else
		
		lvl_Sucesso = -1
	End If
End If

Close(w_Aguarde)

Destroy(lvo_Excel)

Return lvl_Sucesso

end function

public function boolean wf_valida_filial_promocao (long al_filial, long al_promocao);Long lvl_Qtde


select Count(*) 
Into :lvl_Qtde
from promocao_sos_filial
where cd_promocao_sos = :al_promocao
    and cd_filial				= :al_filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Qtde > 0 Then
			Return True
		End If
		
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o sos filial.")	
		
End Choose

Return False
end function

public function boolean wf_valida_produto (long al_produto, ref long al_fator_conversao);al_Fator_Conversao = 0

select vl_fator_conversao
Into :al_Fator_Conversao
from produto_geral
where cd_produto = :al_produto
group by vl_fator_conversao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
				
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto.")
		
End Choose

Return False
end function

public function boolean wf_atualiza_estoque_minimo (long al_promocao, long al_filial, long al_produto, long al_estoque_minimo, long al_motivo);Long	ll_exists


If al_Motivo = 0 Then
	SetNull(al_Motivo)
End If

select 1
  into :ll_exists
  from promocao_sos_estoque_minimo psem
 where cd_promocao_sos = :al_promocao
	and cd_filial = :al_Filial
	and cd_produto = :al_Produto
Using SqlCa;

Choose Case SQLCA.SQLCode
	Case -1
		SqlCa.of_RollBack();
		ivl_Index += 1
		gvs_Log[ivl_Index] = "Erro ao buscar promo$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(al_Produto) + "' da filial  '" + 	String(al_Filial) + "'.~r~rErro: "+SqlCa.SQLErrText+".~r~n"
		Return False
	Case 0
		update promocao_sos_estoque_minimo
			set qt_estoque_minimo			= :al_Estoque_Minimo,
				 qt_estoque_minimo_matriz	= :al_Estoque_Minimo,
				 nr_matricula_alteracao		= :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
				 cd_motivo_alteracao			= :al_Motivo
		 where cd_promocao_sos = :al_promocao
		   and cd_filial = :al_Filial
		   and cd_produto = :al_Produto
		Using SqlCa;
			
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_RollBack();
				ivl_Index += 1
				gvs_Log[ivl_Index] = "O produto '" + String(al_Produto) + "' da filial  '" + 	String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o atualizou por que ocorreu o erro "+SqlCa.SQLErrText+".~r~n"
				Return False
		End Choose
	Case 100
		insert into promocao_sos_estoque_minimo (
			cd_promocao_sos,
			cd_filial,
			cd_produto,
			qt_estoque_minimo,
			id_alterado_filial,
			qt_estoque_minimo_matriz,
			nr_matricula_alteracao,
			cd_motivo_alteracao )
		values (
			:al_promocao,
			:al_Filial,
			:al_Produto,
			:al_Estoque_Minimo,
			'N',
			:al_Estoque_Minimo,
			:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
			:al_Motivo)
		using SQLCA;
		
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_RollBack();
				ivl_Index += 1
				gvs_Log[ivl_Index] = "O produto '" + String(al_Produto) + "' da filial  '" + 	String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o foi inserido por que ocorreu o erro "+SqlCa.SQLErrText+".~r~n"
				Return False
		End Choose
End Choose

SqlCa.of_Commit();

Return True
end function

public function boolean wf_valida_promocao (long al_promocao, ref string as_tipo_promocao);Long lvl_Qtde

Select id_tipo_promocao, Count(*) 
Into :as_tipo_promocao, :lvl_Qtde
From promocao_sos
Where cd_promocao_sos = :al_promocao
Group by id_tipo_promocao 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Qtde > 0 Then
			Return True
		End If
		
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o.")	
		
End Choose

Return False
end function

on w_ge128_atualizar_estoque_minimo_excel.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.pb_1=create pb_1
this.sle_1=create sle_1
this.st_1=create st_1
this.gb_1=create gb_1
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_1
end on

on w_ge128_atualizar_estoque_minimo_excel.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.pb_1)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

sle_1.SetFocus()
end event

event open;call super::open;ivb_permite_fechar = false
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge128_atualizar_estoque_minimo_excel
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge128_atualizar_estoque_minimo_excel
end type

type cb_2 from commandbutton within w_ge128_atualizar_estoque_minimo_excel
integer x = 1495
integer y = 356
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;Close(Parent)
end event

type pb_1 from picturebutton within w_ge128_atualizar_estoque_minimo_excel
integer x = 2144
integer y = 96
integer width = 133
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\icon_search.PNG"
alignment htextalign = left!
string powertiptext = "Localizar arquivo excel"
long backcolor = 67108864
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nome,&
	   lvs_Nulo

Integer lvi_Retorno 

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
				 "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o~r"     + &
				 "Coluna B = C$$HEX1$$f300$$ENDHEX$$digo da filial~r"    + &
				 "Coluna C = C$$HEX1$$f300$$ENDHEX$$digo do produto~r" +&
				  "Coluna D = Qtde estoque m$$HEX1$$ed00$$ENDHEX$$nimo~r"    )

lvi_Retorno = GetFileOpenName("Seleciona o arquivo", lvs_Arquivo, lvs_Nome,  "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Retorno = 1 Then 
	sle_1.Text = Upper(lvs_Arquivo)
	cb_1.Enabled = True
Else
	SetNull(lvs_Nulo)
	sle_1.Text = ""
	cb_1.Enabled = False
End If
end event

type sle_1 from singlelineedit within w_ge128_atualizar_estoque_minimo_excel
integer x = 311
integer y = 100
integer width = 1819
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
end type

type st_1 from statictext within w_ge128_atualizar_estoque_minimo_excel
integer x = 50
integer y = 108
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Diret$$HEX1$$f300$$ENDHEX$$rio:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge128_atualizar_estoque_minimo_excel
integer x = 32
integer y = 16
integer width = 2295
integer height = 316
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type cb_1 from commandbutton within w_ge128_atualizar_estoque_minimo_excel
integer x = 1925
integer y = 356
integer width = 402
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Alterar"
end type

event clicked;dw_1.AcceptText()

If Trim(sle_1.Text) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o arquivo a ser importado.")
	sle_1.SetFocus()
	Return
End If

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "GC" Then
	//Se o motivo for 'NENHUM'
	If dw_1.Object.Cd_Motivo[1] = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo de altera$$HEX2$$e700e300$$ENDHEX$$o.")
		Return -1
	End If
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo?", Question!, YesNo!, 1) = 1 Then
	Choose Case wf_Atualiza()
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		Case 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  "Alguns itens n$$HEX1$$e300$$ENDHEX$$o foram atualizados.")
			Open(w_ge128_log)
		Case 1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  "Todos os itens foram atualizados com sucesso.")
	End Choose
End If

ivl_Index = 0
end event

type dw_1 from dc_uo_dw_base within w_ge128_atualizar_estoque_minimo_excel
integer x = 78
integer y = 200
integer width = 1637
integer height = 116
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge128_selecao"
end type

