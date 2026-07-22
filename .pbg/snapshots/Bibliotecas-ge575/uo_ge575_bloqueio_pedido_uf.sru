HA$PBExportHeader$uo_ge575_bloqueio_pedido_uf.sru
forward
global type uo_ge575_bloqueio_pedido_uf from nonvisualobject
end type
end forward

global type uo_ge575_bloqueio_pedido_uf from nonvisualobject
end type
global uo_ge575_bloqueio_pedido_uf uo_ge575_bloqueio_pedido_uf

type variables
String ivs_Msg, ivs_SetColumn, ivs_Campo_Anterior
Long ivl_Row_Set
end variables

forward prototypes
public function string of_get_where_consulta (dc_uo_dw_base pdw_consulta)
public function str_ge575_bloqueio_pedido_uf of_montar_str_bloqueios (ref dc_uo_dw_base pdw_selecao_bloqueio)
public function string of_vigente (datetime pdh_inicio_bloqueio, datetime pdh_termino_bloqueio)
public function boolean of_inserir_distribuidora_default (dc_uo_dw_base pdw_sel)
public function boolean of_validar_filtros_consulta (dc_uo_dw_base pdw_consulta)
public function boolean of_validar_campos_inclusao (dc_uo_dw_base pdw_inclusao)
public function boolean of_validar_periodo (dc_uo_dw_base pdw_validar)
public function boolean of_incluir_bloqueio (ref dc_uo_dw_base pdw_bloqueios, ref string ps_distribuidora)
public function boolean of_excluir_bloqueio (dc_uo_dw_base pdw_bloqueios, long pl_row)
public function boolean of_excluir_bloqueios (dc_uo_dw_base pdw_bloqueios, boolean pb_todosantigos)
public function boolean of_get_ufs_sel (dc_uo_dw_base pdw_selecao, ref string ps_UFs[])
public function boolean of_gravar_historico_alteracao (dc_uo_dw_base pdw_bloqueios)
end prototypes

public function string of_get_where_consulta (dc_uo_dw_base pdw_consulta);String lvs_Distribuidora, lvs_UFs[], lvs_UFs_In, ls_Where
DateTime lvdh_Inicio_Bloqueio, lvdh_Termino_Bloqueio

pdw_Consulta.AcceptText()

// Distribuidora
lvs_Distribuidora = Trim(gf_Coalesce(pdw_Consulta.GetItemString(pdw_Consulta.GetRow(), 'cd_distribuidora'), ''))
If lvs_Distribuidora <> '' ANd lvs_Distribuidora <> '000000000' Then
	ls_Where += " AND cd_distribuidora IN('"+lvs_Distribuidora+"') "
End If

// In$$HEX1$$ed00$$ENDHEX$$cio
lvdh_Inicio_Bloqueio = pdw_Consulta.GetItemDateTime(pdw_Consulta.GetRow(), 'dh_inicio_bloqueio')
If Not isNull(lvdh_Inicio_Bloqueio) Then
	ls_Where += " AND dh_inicio_bloqueio >= '"+String(lvdh_Inicio_Bloqueio, 'yyyy-mm-dd')+"' "
End If

// T$$HEX1$$e900$$ENDHEX$$rmino
lvdh_Termino_Bloqueio = pdw_Consulta.GetItemDateTime(pdw_Consulta.GetRow(), 'dh_termino_bloqueio')
If Not isNull(lvdh_Termino_Bloqueio) Then
	ls_Where += " AND dh_termino_bloqueio <= '"+String(lvdh_Termino_Bloqueio, 'yyyy-mm-dd')+"' "
End If

// UFs
lvs_UFs_In = pdw_Consulta.of_ddw_MultiSelecao_Get("','")
If lvs_UFs_In <> '' And lvs_UFs_In <> 'TODAS' Then
	ls_Where += " AND cd_uf IN('"+lvs_UFs_In+"') "
Else
	ls_Where += " AND cd_uf is not null"
End If

Return ls_Where
end function

public function str_ge575_bloqueio_pedido_uf of_montar_str_bloqueios (ref dc_uo_dw_base pdw_selecao_bloqueio);str_ge575_bloqueio_pedido_uf lvst_Bloqueios
Long lvl_For, lvl_Row

pdw_Selecao_Bloqueio.AcceptText()

// Recuperar as UFs selecionadas no dropdown.
of_Get_UFs_Sel(ref pdw_Selecao_Bloqueio, ref lvst_Bloqueios.cd_UF)

lvl_Row = pdw_Selecao_Bloqueio.GetRow()

// Inserir um para cada UF selecionada.
For lvl_For = 1 To UpperBound(lvst_Bloqueios.cd_UF)
	lvst_Bloqueios.cd_distribuidora[lvl_For] 		= pdw_Selecao_Bloqueio.GetItemString(lvl_Row, 'cd_distribuidora')
	lvst_Bloqueios.nm_fantasia[lvl_For] 			= pdw_Selecao_Bloqueio.GetItemString(lvl_Row, 'nm_fantasia')
	lvst_Bloqueios.de_motivo_bloqueio[lvl_For] 	= pdw_Selecao_Bloqueio.GetItemString(lvl_Row, 'de_motivo_bloqueio')
	lvst_Bloqueios.dh_inicio_bloqueio[lvl_For] 	= pdw_Selecao_Bloqueio.GetItemDateTime(lvl_Row, 'dh_inicio_bloqueio')
	lvst_Bloqueios.dh_termino_bloqueio[lvl_For] = pdw_Selecao_Bloqueio.GetItemDateTime(lvl_Row, 'dh_termino_bloqueio')
Next

Return lvst_Bloqueios
end function

public function string of_vigente (datetime pdh_inicio_bloqueio, datetime pdh_termino_bloqueio);If (gvo_Parametro.dh_Movimentacao >= pdh_Inicio_Bloqueio) And (gvo_Parametro.dh_Movimentacao <= pdh_Termino_Bloqueio) Then
	Return 'S'
Else
	Return 'N'
End If
end function

public function boolean of_inserir_distribuidora_default (dc_uo_dw_base pdw_sel);DataWindowChild lvdwc
Integer lvi_Row
ivs_Msg = ''

If pdw_Sel.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvi_Row = lvdwc.InsertRow(1)
	
	lvdwc.SetItem(lvi_Row, "cd_fornecedor", "000000000")
	lvdwc.SetItem(lvi_Row, "nm_fantasia",   "TODAS")
	
	pdw_Sel.SetItem(pdw_Sel.GetRow(), 'cd_distribuidora', "000000000")
	Return True
Else
	ivs_Msg = 'Erro no GetChild da distribuidora.'
	Return False
End If
end function

public function boolean of_validar_filtros_consulta (dc_uo_dw_base pdw_consulta);pdw_Consulta.AcceptText()
ivs_Msg = ''
ivs_SetColumn = ''

// Per$$HEX1$$ed00$$ENDHEX$$odo.
If pdw_Consulta.GetItemDateTime(pdw_Consulta.GetRow(), 'dh_inicio_bloqueio') > pdw_Consulta.GetItemDateTime(pdw_Consulta.GetRow(), 'dh_termino_bloqueio') Then
	ivs_Msg = 'A data de t$$HEX1$$e900$$ENDHEX$$rmino do bloqueio deve ser igual ou posterior $$HEX1$$e000$$ENDHEX$$ data de in$$HEX1$$ed00$$ENDHEX$$cio!~rFavor verificar!'
	ivs_SetColumn = 'dh_termino_bloqueio'
	Return False
End If

Return True
end function

public function boolean of_validar_campos_inclusao (dc_uo_dw_base pdw_inclusao);Long lvl_Row
String lvs_UFs[]

lvl_Row = pdw_Inclusao.GetRow()
ivs_SetColumn = ''
ivs_Msg = ''

pdw_Inclusao.AcceptText()

// Distribuidora
If Trim(gf_Coalesce(pdw_Inclusao.GetItemString(lvl_Row, 'cd_distribuidora'), '')) = '' Then
	ivs_Msg = 'Favor selecionar a distribuidora.'
	ivs_SetColumn = 'cd_distribuidora'
	Return False
End If

// UF
of_Get_UFs_Sel(pdw_Inclusao , ref lvs_UFs)
If UpperBound(lvs_UFs) = 0 Then
	ivs_Msg = "Favor selecionar as UF's para bloqueio dos pedidos."
	ivs_SetColumn = 'cd_uf_sel'
	Return False
End If

// Per$$HEX1$$ed00$$ENDHEX$$odo
If Not of_Validar_Periodo(pdw_Inclusao) Then
	Return False
End If

// Motivo
If Len(Trim(gf_Coalesce(pdw_Inclusao.GetItemString(lvl_Row, 'de_motivo_bloqueio'), ''))) < 15 Then
	ivs_Msg = 'Favor informar o motivo do bloqueio com pelo menos 15 caracteres.'
	ivs_SetColumn = 'de_motivo_bloqueio'
	Return False
End If

Return True
end function

public function boolean of_validar_periodo (dc_uo_dw_base pdw_validar);Long lvl_For

ivs_Msg = ''

For lvl_For = 1 To pdw_Validar.RowCount()
	// Dados que n$$HEX1$$e300$$ENDHEX$$o foram inseridos nem alterados agora, n$$HEX1$$e300$$ENDHEX$$o precisa validar.
	If pdw_Validar.GetItemStatus(lvl_For, 0, Primary!) = NotModified! Then Continue
	
	// Data inicial em branco.
	If IsNull(pdw_Validar.GetItemDateTime(lvl_For, 'dh_inicio_bloqueio')) Or &
		pdw_Validar.GetItemDateTime(lvl_For, 'dh_inicio_bloqueio') = DateTime('01/01/1900') Then
		ivs_Msg = 'Favor informar uma data v$$HEX1$$e100$$ENDHEX$$lida para o in$$HEX1$$ed00$$ENDHEX$$cio do bloqueio.'
		ivs_SetColumn = 'dh_inicio_bloqueio'
		ivl_Row_Set = lvl_For
		Return False
	End If
	
	// Data final em branco.
	If IsNull(pdw_Validar.GetItemDateTime(lvl_For, 'dh_termino_bloqueio')) Or &
		pdw_Validar.GetItemDateTime(lvl_For, 'dh_termino_bloqueio') = DateTime('01/01/1900') Then
		ivs_Msg = 'Favor informar uma data v$$HEX1$$e100$$ENDHEX$$lida para o t$$HEX1$$e900$$ENDHEX$$rmino do bloqueio.'
		ivs_SetColumn = 'dh_termino_bloqueio'
		ivl_Row_Set = lvl_For
		Return False
	End If
	
	// Inicial maior que final.
	If pdw_Validar.GetItemDateTime(lvl_For, 'dh_inicio_bloqueio') > pdw_Validar.GetItemDateTime(lvl_For, 'dh_termino_bloqueio') Then
		ivs_Msg = 'A data de t$$HEX1$$e900$$ENDHEX$$rmino do bloqueio deve ser igual ou posterior $$HEX1$$e000$$ENDHEX$$ data de in$$HEX1$$ed00$$ENDHEX$$cio!~rFavor verificar.'
		ivs_SetColumn = 'dh_termino_bloqueio'
		ivl_Row_Set = lvl_For
		Return False
	End If
	
	// Data final menor que hoje.
	If pdw_Validar.GetItemDateTime(lvl_For, 'dh_termino_bloqueio') < gvo_Parametro.dh_Movimentacao Then
		ivs_Msg = 'A data de t$$HEX1$$e900$$ENDHEX$$rmino do bloqueio deve ser igual ou posterior $$HEX1$$e000$$ENDHEX$$ data atual!~rFavor verificar.'
		ivs_SetColumn = 'dh_termino_bloqueio'
		ivl_Row_Set = lvl_For
		Return False
	End If
Next

Return True
end function

public function boolean of_incluir_bloqueio (ref dc_uo_dw_base pdw_bloqueios, ref string ps_distribuidora);Long lvl_Qtd_Incluir, lvl_For, lvl_Existe, lvl_Incluidos
String lvs_Chave, lvs_Para, lvs_Nulo, lvs_Erro
str_ge575_bloqueio_pedido_uf lvst_Bloqueios

ivs_Msg = ''
SetNull(lvs_Nulo)

// Abrir tela para inclus$$HEX1$$e300$$ENDHEX$$o de bloqueio. Se passar uma distribuidora vai selecionar automaticamente
OpenWithParm(w_ge575_bloqueio_pedido_uf_inclusao, ps_Distribuidora)
lvst_Bloqueios = Message.PowerObjectParm

// Incluir bloqueios caso retorne algum dado na str
If isValid(lvst_Bloqueios) Then
	lvl_Qtd_Incluir = UpperBound(lvst_Bloqueios.cd_distribuidora)
	If lvl_Qtd_Incluir > 0 Then
		// Percorrer registros a incluir
		For lvl_For = 1 To lvl_Qtd_Incluir
			lvl_Existe=0
			// Para n$$HEX1$$e300$$ENDHEX$$o inserir duplicado
			SELECT 1 INTO :lvl_Existe
			FROM dbo.pedido_filial_bloqueio
			WHERE 	cd_distribuidora = :lvst_Bloqueios.cd_distribuidora[lvl_For] AND
						dh_inicio_bloqueio = :lvst_Bloqueios.dh_inicio_bloqueio[lvl_For] AND
						dh_termino_bloqueio = :lvst_Bloqueios.dh_termino_bloqueio[lvl_For] AND
						cd_uf = :lvst_Bloqueios.cd_uf[lvl_For]
			USING SQLCA;
			
			If lvl_Existe > 0 Then Continue // Se todos existirem, n$$HEX1$$e300$$ENDHEX$$o vai fazer nada
			
			// N$$HEX1$$e300$$ENDHEX$$o existe, incluir
			INSERT INTO dbo.pedido_filial_bloqueio
				(cd_distribuidora, de_motivo_bloqueio, dh_inicio_bloqueio, dh_termino_bloqueio, 
					cd_uf, nr_matricula_inclusao, id_tipo_bloqueio)
			VALUES
				(:lvst_Bloqueios.cd_distribuidora[lvl_For], :lvst_Bloqueios.de_motivo_bloqueio[lvl_For], :lvst_Bloqueios.dh_inicio_bloqueio[lvl_For], :lvst_Bloqueios.dh_termino_bloqueio[lvl_For],
					:lvst_Bloqueios.cd_uf[lvl_For], :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'D')
			USING SQLCA;
			
			If SQLCA.SqlCode = -1 Then
				ivs_Msg = 'Erro na inclus$$HEX1$$e300$$ENDHEX$$o do bloqueio: ' + SqlCa.SqlErrText
				SQLCA.of_Rollback()
				Return False
			End If
			
			// Gravar hist$$HEX1$$f300$$ENDHEX$$rico
			lvs_Chave = 'CD_DISTRIBUIDORA@#!CD_UF@#!DH_INICIO_BLOQUEIO@#!DH_TERMINO_BLOQUEIO@#!DE_MOTIVO_BLOQUEIO'
			lvs_Para = lvst_Bloqueios.cd_distribuidora[lvl_For] + "@#!"
			lvs_Para += lvst_Bloqueios.cd_uf[lvl_For] + "@#!"
			lvs_Para += String(lvst_Bloqueios.dh_inicio_bloqueio[lvl_For], 'dd/mm/yyyy') + "@#!"
			lvs_Para += String(lvst_Bloqueios.dh_termino_bloqueio[lvl_For], 'dd/mm/yyyy') + "@#!"
			lvs_Para += lvst_Bloqueios.de_motivo_bloqueio[lvl_For]
			
			If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_FILIAL_BLOQUEIO', lvs_Chave, 'NR_BLOQUEIO', lvs_Nulo, lvs_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref lvs_Erro, False) Then
				ivs_Msg = lvs_Erro
				Return False // J$$HEX1$$e100$$ENDHEX$$ fez rollback na gf em caso de erro
			End If
			
			lvl_Incluidos++
		Next
		
		ps_Distribuidora = lvst_Bloqueios.cd_distribuidora[1] // Retorna para fazer o retrieve
		
		// N$$HEX1$$e300$$ENDHEX$$o incluiu nenhum porque j$$HEX1$$e100$$ENDHEX$$ tinha todos
		If lvl_Incluidos = 0 Then ivs_Msg = 'O bloqueio selecionado para inclus$$HEX1$$e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ existia.~rOpera$$HEX2$$e700e300$$ENDHEX$$o cancelada.'
		
		SqlCa.of_Commit()
		Return True
	End If
End If

Return False
end function

public function boolean of_excluir_bloqueio (dc_uo_dw_base pdw_bloqueios, long pl_row);Long lvl_Nr_Bloqueio
String lvs_Chave, lvs_De, lvs_Null, lvs_Erro

lvl_Nr_Bloqueio = pdw_Bloqueios.GetItemNumber(pl_Row, 'nr_bloqueio')

DELETE FROM dbo.pedido_filial_bloqueio
WHERE nr_bloqueio = :lvl_Nr_Bloqueio
USING SQLCA;

If SQLCA.SqlCode = -1 Then
	ivs_Msg = 'Erro na exclus$$HEX1$$e300$$ENDHEX$$o do bloqueio: ' + SqlCa.SqlErrText
	SQLCA.of_Rollback()
	Return False
End If

SetNull(lvs_Null)

// Gravar hist$$HEX1$$f300$$ENDHEX$$rico.
lvs_Chave = 'NR_BLOQUEIO@#!CD_DISTRIBUIDORA@#!CD_UF@#!DH_INICIO_BLOQUEIO@#!DH_TERMINO_BLOQUEIO'
lvs_De += String(lvl_Nr_Bloqueio) + "@#!"
lvs_De += pdw_Bloqueios.GetItemString(pl_Row, 'cd_distribuidora') + "@#!"
lvs_De += pdw_Bloqueios.GetItemString(pl_Row, 'cd_uf') + "@#!"
lvs_De += String(pdw_Bloqueios.GetItemDateTime(pl_Row, 'dh_inicio_bloqueio'), 'dd/mm/yyyy') + "@#!"
lvs_De += String(pdw_Bloqueios.GetItemDateTime(pl_Row, 'dh_termino_bloqueio'), 'dd/mm/yyyy')

If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_FILIAL_BLOQUEIO', lvs_Chave, 'NR_BLOQUEIO', lvs_De, lvs_Null, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref lvs_Erro, False) Then
	ivs_Msg = lvs_Erro
	Return False // J$$HEX1$$e100$$ENDHEX$$ fez rollback na gf em caso de erro.
End If

SQLCA.of_Commit()
pdw_Bloqueios.DeleteRow(pl_Row)
Return True
end function

public function boolean of_excluir_bloqueios (dc_uo_dw_base pdw_bloqueios, boolean pb_todosantigos);Long lvl_For
Boolean lvb_Delete

For lvl_For = 1 To pdw_Bloqueios.RowCount()
	lvb_Delete = False
	
	// Excluir antigos.
	If pb_TodosAntigos Then
		If pdw_Bloqueios.GetItemDateTime(lvl_For, 'dh_termino_bloqueio') < gvo_Parametro.dh_Movimentacao Then
			lvb_Delete = True
		End If
	Else // Excluir selecionados.
		If pdw_Bloqueios.GetItemString(lvl_For, 'id_excluir') = 'S' Then
			lvb_Delete = True
		End If
	End If
	
	// Apagar.
	If lvb_Delete Then
		If Not of_Excluir_Bloqueio(pdw_Bloqueios, lvl_For) Then
			Return False
		End If
		lvl_For -- // Fez DeleteRow na of_Excluir_Bloqueio.
	End If
Next

pdw_Bloqueios.ResetUpdate()
Return True
end function

public function boolean of_get_ufs_sel (dc_uo_dw_base pdw_selecao, ref string ps_UFs[]);DataWindowChild lvdwc
Long lvl_For
Boolean lvb_Todas

// Percorrer ddw para pegar os marcados.
If pdw_Selecao.GetChild('cd_uf', lvdwc) > 0 Then
	lvb_Todas = (lvdwc.GetItemString(1, 'id_selecionado') = 'S') // TODAS
	For lvl_For = 2 To lvdwc.RowCount()
		If lvdwc.GetItemString(lvl_For, 'id_selecionado') = 'S' Or lvb_Todas Then
			ps_UFs[UpperBound(ps_UFs) +1] = lvdwc.GetItemString(lvl_For, 'cd_uf')
		End If
 	Next
End If

Return lvb_Todas
end function

public function boolean of_gravar_historico_alteracao (dc_uo_dw_base pdw_bloqueios);Long lvl_Nr_Bloqueio, lvl_For
String lvs_Chave, lvs_De, lvs_Erro, lvs_Para

For lvl_For = 1 To pdw_Bloqueios.RowCount()
	If pdw_Bloqueios.GetItemStatus(lvl_For, 'dh_termino_bloqueio', Primary!) <> DataModified! Then Continue
	
	lvl_Nr_Bloqueio = pdw_Bloqueios.GetItemNumber(lvl_For, 'nr_bloqueio')
	
	// Gravar hist$$HEX1$$f300$$ENDHEX$$rico.
	lvs_Chave = 'NR_BLOQUEIO@#!CD_DISTRIBUIDORA@#!CD_UF@#!DH_INICIO_BLOQUEIO@#!DH_TERMINO_BLOQUEIO'
	lvs_De = String(lvl_Nr_Bloqueio) + "@#!"
	lvs_De += pdw_Bloqueios.GetItemString(lvl_For, 'cd_distribuidora') + "@#!"
	lvs_De += pdw_Bloqueios.GetItemString(lvl_For, 'cd_uf') + "@#!"
	lvs_De += String(pdw_Bloqueios.GetItemDateTime(lvl_For, 'dh_inicio_bloqueio'), 'dd/mm/yyyy') + "@#!"
	lvs_De += String(pdw_Bloqueios.GetItemDateTime(lvl_For, 'dh_termino_bloqueio', Primary!, True), 'dd/mm/yyyy')
	
	lvs_Para = String(lvl_Nr_Bloqueio) + "@#!"
	lvs_Para += pdw_Bloqueios.GetItemString(lvl_For, 'cd_distribuidora') + "@#!"
	lvs_Para += pdw_Bloqueios.GetItemString(lvl_For, 'cd_uf') + "@#!"
	lvs_Para += String(pdw_Bloqueios.GetItemDateTime(lvl_For, 'dh_inicio_bloqueio'), 'dd/mm/yyyy') + "@#!"
	lvs_Para += String(pdw_Bloqueios.GetItemDateTime(lvl_For, 'dh_termino_bloqueio'), 'dd/mm/yyyy')
	
	If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_FILIAL_BLOQUEIO', lvs_Chave, 'DH_TERMINO_BLOQUEIO', lvs_De, lvs_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref lvs_Erro, False) Then
		ivs_Msg = lvs_Erro
		Return False // J$$HEX1$$e100$$ENDHEX$$ fez rollback na gf em caso de erro.
	End If
Next

Return True
end function

on uo_ge575_bloqueio_pedido_uf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge575_bloqueio_pedido_uf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

