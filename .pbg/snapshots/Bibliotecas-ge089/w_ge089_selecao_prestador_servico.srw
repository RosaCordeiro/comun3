HA$PBExportHeader$w_ge089_selecao_prestador_servico.srw
forward
global type w_ge089_selecao_prestador_servico from dc_w_selecao_generica
end type
end forward

global type w_ge089_selecao_prestador_servico from dc_w_selecao_generica
integer x = 827
integer width = 2839
integer height = 1548
string title = "GE089 - Sele$$HEX2$$e700e300$$ENDHEX$$o dos Pretadores de Servi$$HEX1$$e700$$ENDHEX$$os do Clube"
long backcolor = 80269524
end type
global w_ge089_selecao_prestador_servico w_ge089_selecao_prestador_servico

type variables
uo_prestador_servico_clube ivo_prestador_servico


end variables

on w_ge089_selecao_prestador_servico.create
call super::create
end on

on w_ge089_selecao_prestador_servico.destroy
call super::destroy
end on

event open;call super::open;ivo_Prestador_Servico = Message.PowerObjectParm

If ivo_Prestador_Servico.ivs_Parametro <> "" Then
	dw_1.Object.de_localizacao[1] = ivo_Prestador_Servico.ivs_Parametro
	ivb_Pesquisa_Direta = True
End If


end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge089_selecao_prestador_servico
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge089_selecao_prestador_servico
integer x = 23
integer y = 188
integer width = 2766
integer height = 1116
long backcolor = 80269524
string text = "Lista de Prestadores"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge089_selecao_prestador_servico
integer x = 23
integer y = 4
integer width = 1495
integer height = 168
long backcolor = 80269524
string text = "Par$$HEX1$$e200$$ENDHEX$$metro de Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge089_selecao_prestador_servico
integer x = 46
integer y = 60
integer width = 1454
integer height = 100
string dataobject = "dw_ge089_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge089_selecao_prestador_servico
integer x = 46
integer y = 236
integer width = 2720
integer height = 1032
string dataobject = "dw_ge089_lista_prestador"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Prestador

Long lvl_Filial

dw_1.AcceptText()

lvs_Prestador = Trim(dw_1.Object.de_localizacao[1])
lvl_Filial    = gvo_Parametro.of_Filial()

If lvs_Prestador <> "" Then
	This.of_AppendWhere("nm_prestador like '" + lvs_Prestador + "%'")
End If

Return 1
end event

event dw_2::ue_recuperar;// Override
Long lvl_Retorno

String lvs_Retorno

This.SetRedraw(False)

This.Event ue_Reset()

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Relatorio(True)

lvo_Conexao.of_Retrieve(This.GetSqlSelect(), Ref lvs_Retorno)

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else
	If Not IsNull(lvs_Retorno) And lvs_Retorno <> '' Then
		lvl_Retorno = This.ImportString(lvs_Retorno)
		If lvl_Retorno < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao importar os dados do servidor distribu$$HEX1$$ed00$$ENDHEX$$do para a data window local.")
		End If
	End If
End If 

Destroy(lvo_Conexao)

This.VScrollBar = True

This.SetRedraw(True)

Return lvl_Retorno
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge089_selecao_prestador_servico
integer x = 2025
integer y = 1332
end type

event cb_selecionar::clicked;Long lvl_Linha, &
     lvl_Prestador

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Prestador = dw_2.Object.cd_prestador[lvl_Linha]
	CloseWithReturn(Parent, lvl_Prestador)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um prestador.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge089_selecao_prestador_servico
integer x = 2414
integer y = 1332
end type

event cb_cancelar::clicked;STRING lvs_Centro_Custo

SetNull(lvs_Centro_Custo)

CloseWithReturn(Parent, lvs_Centro_Custo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge089_selecao_prestador_servico
integer x = 1637
integer y = 1332
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge089_selecao_prestador_servico
integer x = 37
integer y = 1336
integer width = 1426
long backcolor = 80269524
end type

