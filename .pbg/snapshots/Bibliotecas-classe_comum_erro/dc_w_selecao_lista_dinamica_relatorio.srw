HA$PBExportHeader$dc_w_selecao_lista_dinamica_relatorio.srw
forward
global type dc_w_selecao_lista_dinamica_relatorio from dc_w_selecao_lista_relatorio
end type
type dw_campos from dc_uo_dw_base within dc_w_selecao_lista_dinamica_relatorio
end type
type st_dica from statictext within dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type dc_w_selecao_lista_dinamica_relatorio from dc_w_selecao_lista_relatorio
integer width = 2798
integer height = 1600
dw_campos dw_campos
st_dica st_dica
end type
global dc_w_selecao_lista_dinamica_relatorio dc_w_selecao_lista_dinamica_relatorio

type variables
Long ivl_consulta

String ivs_SQLBase
String ivs_SQL
String ivs_Parametros[]

String ivs_Logo = "CL"
end variables

forward prototypes
public function long wf_last_pos (string ps_texto, string ps_find)
public function integer wf_retorna_pos_fim_campo (string ps_string, string ps_char)
public function string wf_get_sql_consulta (long pl_consulta, string ps_sql)
public subroutine wf_altera_grid ()
protected function boolean wf_retorna_formatacao_campo (string ps_tipo, string ps_campo, string ps_dbcampo, ref long pl_width, ref string ps_mascara, ref long pl_alinhamento)
end prototypes

public function long wf_last_pos (string ps_texto, string ps_find);String lvs_Texto
Long lvl_Pos = 0
Long lvl_Count = 0

lvs_Texto = ps_texto
Do While Pos(lvs_Texto,ps_find) > 0
	lvl_Pos += Pos(lvs_Texto,ps_find)-1
	lvs_Texto = Mid(lvs_Texto,Pos(lvs_Texto,ps_find)+Len(ps_find),Len(lvs_Texto) - Pos(lvs_Texto,ps_find) - Len(ps_find)+1)
	If lvl_Count > 0 Then  lvl_Pos += Len(ps_find)
	lvl_Count += 1
Loop

If lvl_Pos = 0 then
	lvl_Pos = Len(ps_texto)
End If

Return lvl_Pos
end function

public function integer wf_retorna_pos_fim_campo (string ps_string, string ps_char);Long lvl_Char
Long lvl_Parenteses = 0

ps_string = Upper(ps_string)
ps_char = Upper(ps_char)

For lvl_Char = 1 To Len(ps_string)
	Choose Case Mid(ps_string,lvl_Char,1)
		Case '('
			lvl_parenteses += 1
		Case ')'
			lvl_parenteses -= 1
	End Choose
	If (Mid(ps_string,lvl_Char,Len(ps_char))=ps_char)and(lvl_Parenteses = 0) Then
		Exit
	End If
Next

Return lvl_Char
end function

public function string wf_get_sql_consulta (long pl_consulta, string ps_sql);String lvs_SQL
String lvs_Having

Long lvl_Linha

lvs_SQL = ps_SQL

dw_campos.SetFilter("id_visivel='S'")
dw_campos.Filter()
dw_campos.SetSort("nr_seq D")
dw_campos.Sort()

lvs_SQL = Lower(lvs_SQL+' ')
For lvl_Linha = 1 to dw_campos.RowCount()
	If lvl_Linha = 1 then
		lvs_SQL = dw_campos.Object.de_sqlcampo	[lvl_Linha] +' '+ lvs_SQL
	Else 
		lvs_SQL = dw_campos.Object.de_sqlcampo	[lvl_Linha]+ ', '+ lvs_SQL
	End If
Next

lvs_SQL = 'select '+lvs_SQL

lvs_SQL = Mid(lvs_SQL,1,wf_retorna_pos_fim_campo(lvs_SQL,'group by ')-1)

dw_campos.SetFilter("id_agregacao='S' AND id_visivel='S'")
dw_campos.Filter()

lvl_Linha = dw_campos.RowCount()
If lvl_Linha > 0 then
	dw_campos.SetFilter("id_agregacao='N' AND id_visivel='S'")
	dw_campos.Filter()
	dw_campos.SetSort("nr_seq A")
	dw_campos.Sort()
	
	For lvl_Linha = 1 to dw_campos.RowCount()
		If lvl_Linha = 1 then lvs_SQL += 'group by '
		lvs_SQL += Mid(dw_campos.Object.de_sqlcampo	[lvl_Linha],1,wf_last_pos(lower(dw_campos.Object.de_sqlcampo[lvl_Linha]),' as '))
		If lvl_Linha <> dw_campos.RowCount() then lvs_SQL += ', '
	Next
End If

//lvs_SQL += ' order by 1'

dw_campos.SetSort("nr_seq A")
dw_campos.Sort()
dw_campos.SetFilter("")
dw_campos.Filter()

Return lvs_SQL
end function

public subroutine wf_altera_grid ();String lvs_estilo, lvs_err, lvs_sintaxe

//Retorna SQL formatado
ivs_sql = wf_get_sql_consulta(ivl_consulta,ivs_SQLBase)
dw_2.of_ChangeSQL(ivs_sql)

//Seta o Stilo da grid de consulta
lvs_estilo =   "Style(Type=Tabular)" + &
				 "Text(Background.Color=0 Color=8388608 Font.Face='Verdana' Font.Height=-8 Font.Width=10 font.weight=400) " + & 
				 "Column(Background.Color=16777215 Background.Mode=0 Border=2 Color=8388608 Font.Face='Verdana' Font.Height=-8 Font.Width=32) " + &
				 "Datawindow(Color=67108864) "
 //Prepara Sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o datawindow din$$HEX1$$e200$$ENDHEX$$mica
lvs_sintaxe = dw_2.itr_Transacao.SyntaxFromSql(ivs_sql, lvs_estilo, lvs_err)
//Verifica erro sintaxe
If len(lvs_err) > 0 Then
	MessageBox("Error","SyntaxFromSql causado pelo seguinte erro: " + lvs_err)
	Return
End If

//Cria Datawindow baseado nos stilos setados
dw_2.create(lvs_sintaxe, lvs_err)
dw_2.SetTransObject(dw_2.itr_Transacao)
dw_2.SetSort(dw_2.Describe("#1.Name")+' A')
end subroutine

protected function boolean wf_retorna_formatacao_campo (string ps_tipo, string ps_campo, string ps_dbcampo, ref long pl_width, ref string ps_mascara, ref long pl_alinhamento);ps_mascara	= ''
pl_width 		= Long(dw_2.Describe(ps_campo+'.Width'))
ps_tipo		= Upper(ps_tipo)
ps_dbcampo= Upper(ps_dbcampo)

//Ajuste espec$$HEX1$$ed00$$ENDHEX$$fico para coluna
If (Pos(ps_dbcampo,'CD_FILIAL') > 0) or (Pos(ps_dbcampo,'CD_REGIAO') > 0) Then
	pl_width=115
ElseIf (Pos(ps_dbcampo,'CD_CONVENIO') > 0) or (Pos(ps_dbcampo,'CD_PRODUTO') > 0) or (Pos(ps_dbcampo,'NR_ENDERECO') > 0)   Then
	pl_width=215
	pl_alinhamento = 1
ElseIf (Pos(ps_dbcampo,'NR_NF') > 0) Then
	pl_width=280
	pl_alinhamento = 1
Else
	//Verifica se a coluna $$HEX1$$e900$$ENDHEX$$ um campo de valor
	Choose Case ps_tipo
		Case 'NUMBER'
			//Alinha Direita
			pl_alinhamento = 1
			//Insere m$$HEX1$$e100$$ENDHEX$$scara de n$$HEX1$$fa00$$ENDHEX$$meros
			ps_mascara = '#,##0.00'
		Case 'LONG'
			//Alinha Direita
			pl_alinhamento = 1
	
			//Insere m$$HEX1$$e100$$ENDHEX$$scara de n$$HEX1$$fa00$$ENDHEX$$meros
			ps_mascara = '#,##0'
			
		Case 'DATE', 'DATETIME'
			//Centralizado
			pl_alinhamento = 2
			
			If (Mid(ps_dbcampo,1,2)='DH') and (ps_tipo='DATETIME') Then
				ps_mascara = 'DD/MM/YYYY HH:MM'		
				pl_width = 450
			Else
				ps_mascara = 'DD/MM/YYYY'	
				pl_width = 310
			End If
			
		Case Else 
			If Pos(ps_tipo,'DECIMAL')>0 Then
				//Alinha $$HEX1$$e000$$ENDHEX$$ Direita
				pl_alinhamento = 1
				//Insere m$$HEX1$$e100$$ENDHEX$$scara de n$$HEX1$$fa00$$ENDHEX$$meros
				If Pos(ps_tipo,'DECIMAL(0)')>0 Then 		; ps_mascara = "#,##0"
				ElseIf Pos(ps_tipo,'DECIMAL(1)')>0 Then	; ps_mascara = '#,##0.0'
				ElseIf Pos(ps_tipo,'DECIMAL(2)')>0 Then	; ps_mascara = '#,##0.00'
				ElseIf Pos(ps_tipo,'DECIMAL(3)')>0 Then	; ps_mascara = '#,##0.000'
				ElseIf Pos(ps_tipo,'DECIMAL(4)')>0 Then	; ps_mascara = '#,##0.0000'
				ElseIf Pos(ps_tipo,'DECIMAL(5)')>0 Then	; ps_mascara = '#,##0.00000'
				ElseIf Pos(ps_tipo,'DECIMAL(6)')>0 Then	; ps_mascara = '#,##0.000000'
				Else 
					ps_mascara = '#,##0.00'
				End If
				
				If Mid(ps_dbcampo,1,2)='PC' Then
					pl_width=160
				End If
			Else
				//Alinha Esquerda
				pl_alinhamento = 0
				pl_width		-= pl_width / 10
			End If
	End Choose
End If

Return (ps_mascara <> '')
end function

on dc_w_selecao_lista_dinamica_relatorio.create
int iCurrent
call super::create
this.dw_campos=create dw_campos
this.st_dica=create st_dica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_campos
this.Control[iCurrent+2]=this.st_dica
end on

on dc_w_selecao_lista_dinamica_relatorio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_campos)
destroy(this.st_dica)
end on

event ue_postopen;call super::ue_postopen;If (Not IsNull(ivl_consulta)) and (ivl_consulta > 0) Then
	If Not (dw_campos.Event ue_Retrieve() > 0) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Campos da consulta n$$HEX1$$e300$$ENDHEX$$o foram localizado.',StopSign!)
		Return 
	End If	
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','C$$HEX1$$f300$$ENDHEX$$digo da consulta n$$HEX1$$e300$$ENDHEX$$o atribu$$HEX1$$ed00$$ENDHEX$$do na fun$$HEX2$$e700e300$$ENDHEX$$o ue_PreOpen().',StopSign!)
	Return 
End If

wf_altera_grid()
dw_2.Event ue_reset()

ivm_menu.ivb_permite_imprimir = True
end event

event ue_preopen;call super::ue_preopen;dw_campos.Visible = False
end event

event ue_print;//override
dw_2.Event ue_imprimir_relatorio(dw_2.Title, ivs_Logo, False)
end event

event ue_printimmediate;//override
dw_2.Event ue_imprimir_relatorio(dw_2.Title, ivs_Logo, True)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within dc_w_selecao_lista_dinamica_relatorio
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within dc_w_selecao_lista_dinamica_relatorio
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within dc_w_selecao_lista_dinamica_relatorio
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within dc_w_selecao_lista_dinamica_relatorio
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within dc_w_selecao_lista_dinamica_relatorio
end type

event dw_1::itemchanged;//override
dw_2.Reset()
This.ivm_menu.mf_Classificar(False)
This.ivm_menu.mf_Filtrar(False)
This.ivm_menu.mf_Imprimir(False)
This.ivm_menu.mf_SalvarComo(False)
end event

event dw_1::editchanged;//override
dw_2.Reset()
This.ivm_menu.mf_Classificar(False)
This.ivm_menu.mf_Filtrar(False)
This.ivm_menu.mf_Imprimir(False)
This.ivm_menu.mf_SalvarComo(False)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within dc_w_selecao_lista_dinamica_relatorio
boolean hscrollbar = true
end type

event dw_2::ue_reset;call super::ue_reset;Long lvl_Colunas
Long lvl_Coluna
Long lvl_Y
Long lvl_Width
Long lvl_AuxWidth
Long lvl_Alinhamento
Long lvl_DescX = 0
Long lvl_Width_Total = 0

String lvs_Coluna
String lvs_ColunmType
String lvs_dbName
String lvs_Mascara
String lvs_Erro
String lvs_CampoSumariza
String lvs_Colunas[]
String lvs_NmColunas[]

Boolean lvb_Sumario = False
Boolean lvb_Mascara

//Retorna N$$HEX1$$ba00$$ENDHEX$$ de Colunas do SQL
lvl_Colunas = Long(This.Describe("DataWindow.Column.Count"))
//Seta Tamanho Cabe$$HEX1$$e700$$ENDHEX$$alho
This.Modify("DataWindow.Detail.Height=80")
//Seta Tamanho Cabe$$HEX1$$e700$$ENDHEX$$alho
This.Modify("DataWindow.Header.Height=100")

lvs_Colunas = {''}
lvs_NmColunas = {''}
dw_campos.SetFilter(" id_visivel = 'S' ")
dw_campos.Filter()
lvl_Width_Total = 0
for lvl_Coluna = 1 to lvl_Colunas
	lvs_CampoSumariza = dw_campos.Object.id_sumariza [lvl_Coluna]
	//Recupera nome coluna
	lvs_Coluna = This.Describe("#"+String(lvl_Coluna)+".Name")
	lvs_ColunmType = This.Describe(lvs_Coluna+".Coltype")
	lvs_Colunas[lvl_Coluna]=lvs_Coluna
	//Seta TabOrder=0 para n$$HEX1$$e300$$ENDHEX$$o haver edi$$HEX2$$e700e300$$ENDHEX$$o
	This.Modify(lvs_Coluna+".TabSequence=0")
	//Retorna o nome do campo informado no SQL
	lvs_DbName = This.Describe(lvs_Coluna+".DbName")
	//Remove a tabela do prefixo do campo retornado da base
	lvs_DbName = Mid(lvs_DbName,Pos(lvs_DbName,'.')+1,Len(lvs_DbName)-Pos(lvs_DbName,'.')+1)
	//Retorna configura$$HEX2$$e700e300$$ENDHEX$$o dos campos
	lvb_Mascara = wf_retorna_formatacao_campo(lvs_ColunmType,lvs_Coluna,lvs_DbName,lvl_Width,lvs_Mascara,lvl_Alinhamento)
	//Alinhamento
	This.Modify(lvs_Coluna+".Alignment="+String(lvl_Alinhamento))
	This.Modify(lvs_Coluna+"_t.Alignment="+String(lvl_Alinhamento))
	//Insere Mascara?
	If lvb_Mascara Then This.Modify(lvs_Coluna+".EditMask.Mask='"+lvs_Mascara+"'")
	//Ajusta a largura?
	lvl_AuxWidth = Long(This.Describe(lvs_Coluna+'.Width'))
	If lvl_Width <> lvl_AuxWidth Then 
		This.Modify(lvs_Coluna+".Width="+String(lvl_Width))
		lvl_AuxWidth -= lvl_Width						
		lvl_DescX += lvl_AuxWidth
	Else
		lvl_AuxWidth = 0
	End If
	//Insere sumarizador?
	If lvs_CampoSumariza = 'S' Then
		lvb_Sumario = True
		If lvb_Mascara Then
			This.Modify('create compute(band=Summary color="0" alignment="1" border="2" height.autosize=No x="'+This.Describe(lvs_Coluna+".X")+'" y="5" height="64" width="'+This.Describe(lvs_Coluna+".Width")+'" format="'+lvs_Mascara+'" name=cp'+This.Describe(lvs_Coluna+".Name")+' expression="sum('+This.Describe(lvs_Coluna+".Name")+' for all)" font.face="Verdana" font.height="-7" font.weight="700" font.pitch="2" background.mode="0" background.color="16777215")')
		Else
			This.Modify('create compute(band=Summary color="0" alignment="1" border="2" height.autosize=No x="'+This.Describe(lvs_Coluna+".X")+'" y="5" height="64" width="'+This.Describe(lvs_Coluna+".Width")+'" name=cp'+This.Describe(lvs_Coluna+".Name")+' expression="sum('+This.Describe(lvs_Coluna+".Name")+' for all)" font.face="Verdana" font.height="-7" font.weight="700" font.pitch="2" background.mode="0" background.color="16777215")')
		End If
	End If
	
	//Altera Nome T$$HEX1$$ed00$$ENDHEX$$tulo Coluna
	lvs_NmColunas[lvl_Coluna]=dw_campos.Object.nm_campo [lvl_Coluna]
	This.Modify(lvs_Coluna+"_t.Text='"+lvs_NmColunas[lvl_Coluna]+"'")
	//Ajusta tamanho fonte
	This.Modify(lvs_Coluna+".Font.Height='-7'")
	//Altera a cor
	This.Modify(lvs_Coluna+".Color='0'")
	//Ajusta Largura Colunas
	lvl_Width = Long(This.Describe(lvs_Coluna+'.Width')) 
	This.Modify(lvs_Coluna+".Width="+String(lvl_Width+30))
	This.Modify(lvs_Coluna+"_t.Width="+This.Describe(lvs_Coluna+'.Width'))
	//Ajusta posi$$HEX2$$e700e300$$ENDHEX$$o Colunas
	lvl_Width = Long(This.Describe(lvs_Coluna+'.X'))
	This.Modify(lvs_Coluna+".Y=2")
	This.Modify(lvs_Coluna+".X="+String(lvl_Width - lvl_DescX + lvl_AuxWidth + (32*lvl_Coluna)))
	This.Modify(lvs_Coluna+"_t.X="+This.Describe(lvs_Coluna+'.X'))
	This.Modify(lvs_Coluna+"_t.Height=64")
	This.Modify(lvs_Coluna+"_t.Y=20")
	//Ajusta sumarizadores
	If lvs_CampoSumariza = 'S' Then
		This.Modify("cp"+lvs_Coluna+".Width="+This.Describe(lvs_Coluna+'.Width'))
		This.Modify("cp"+lvs_Coluna+".X="+This.Describe(lvs_Coluna+'.X'))
	End If
	//Insere Linhas abaixo colunas
	lvl_Y = Long(This.Describe(lvs_Coluna+"_t.Y")) + Long(This.Describe(lvs_Coluna+"_t.Height"))
	This.Modify('create line(band=Header x1="'+This.Describe(lvs_Coluna+"_t.X")+'" y1="'+String(lvl_Y)+'" x2="'+String(Long(This.Describe(lvs_Coluna+"_t.X"))+Long(This.Describe(lvs_Coluna+"_t.Width")))+'" y2="'+String(lvl_Y+2)+'" name=l_'+String(lvl_Coluna+1)+' pen.style="0" pen.width="9" pen.color="8388608" background.mode="0" background.color="8388608")')
	lvl_Width_Total += Long(This.Describe(lvs_Coluna+'.Width'))
NEXT
lvl_Width_Total += (32*lvl_Coluna)

If lvl_Width_Total > gb_1.Width Then
	Parent.Width = lvl_Width_Total + 220
Else
	Parent.Width = gb_1.Width + 146
End If

If lvb_Sumario Then
	//This.Modify('create line(band=Summary x1="'+This.Describe("#1.X")+'" y1="10" x2="'+String(lvl_Width_Total)+'" y2="10" name=l_sumario pen.style="0" pen.width="9" pen.color="8388608" background.mode="0" background.color="8388608")')
	This.Modify("DataWindow.Summary.Height=84")
End if

/* Insere coment$$HEX1$$e100$$ENDHEX$$rio de funcionamento no Footer */
This.Modify('create text(band=footer alignment="0" text="" border="0" color="8388608" x="5" y="4" height="48" width="2185" html.valueishtml="0"  name=info_footer visible="1"  font.face="Verdana" font.height="-7" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
This.Object.info_footer.Text = '* Duplo clique sobre a lista para alterar a ordem e/ou exibir/ocultar colunas.'
This.Modify("DataWindow.Footer.Height=50")
	
dw_campos.SetFilter("")
dw_campos.Filter()

//Cria datawindow de relat$$HEX1$$f300$$ENDHEX$$rio baseado na datawindow de lista
dw_3.Create(dw_2.Describe("DataWindow.Syntax"), lvs_Erro)
dw_3.SetTransObject(dw_2.itr_Transacao)
dw_3.Modify('CREATE bitmap(band=foreground filename="S:\Sistemas_PB12\Comuns\Figuras\Logo_Cia_Latino_Americana.bmp" x="0" y="12" height="188" width="626" border="0" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0"  name=logotipo_relatorio visible="1" transparency="0"')
dw_3.Modify('DataWindow.Color="33554431"')
dw_3.Event ue_Reset()

//Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o Sort
This.of_SetSort(lvs_Colunas, lvs_NmColunas)
//Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o Filter
This.of_SetFilter(lvs_Colunas, lvs_NmColunas)

This.ivm_menu.mf_Classificar(False)
This.ivm_menu.mf_Filtrar(False)
This.ivm_menu.mf_Imprimir(False)
This.ivm_menu.mf_SalvarComo(False)

This.ShareData(dw_3)

This.of_SetRowSelection()

This.Show( )
end event

event dw_2::doubleclicked;call super::doubleclicked;OpenWithParm(w_campos_consulta,dw_campos)

wf_altera_grid()
This.Event ue_Reset()
end event

event dw_2::constructor;//override
String lvs_sintaxe, lvs_err

String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

lvs_sintaxe = 'release 12;'+CharA(13)+CharA(10) +&
				'datawindow(units=0 timer_interval=0 color=553648127 brushmode=0 transparency=0 gradient.angle=0 gradient.color=8421504 gradient.focus=0 gradient.repetition.count=0 gradient.repetition.length=100 gradient.repetition.mode=0 gradient.scale=100 gradient.spread=100 gradient.transparency=0 picture.blur=0 picture.clip.bottom=0 picture.clip.left=0 picture.clip.right=0 picture.clip.top=0 picture.mode=0 picture.scale.x=100 picture.scale.y=100 picture.transparency=0 processing=0 HTMLDW=no print.printername="" print.documentname="" print.orientation = 0 print.margin.left = 110 print.margin.right = 110 print.margin.top = 96 print.margin.bottom = 96 print.paper.source = 0 print.paper.size = 0 print.canusedefaultprinter=yes print.prompt=no print.buttons=no print.preview.buttons=no print.cliptext=no print.overrideprintjob=no print.collate=yes print.background=no print.preview.background=no print.preview.outline=yes hidegrayline=no showbackcoloronxp=no picture.file="" )'+CharA(13)+CharA(10) +&
				'header(height=0 color="536870912" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="0" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="100" gradient.spread="100" )'+CharA(13)+CharA(10) +&
				'summary(height=0 color="536870912" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="0" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="100" gradient.spread="100" )'+CharA(13)+CharA(10) +&
				'footer(height=0 color="536870912" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="0" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="100" gradient.spread="100" )'+CharA(13)+CharA(10) +&
				'detail(height=1048 color="536870912" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="0" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="100" gradient.spread="100" )'+CharA(13)+CharA(10) +&
				'table('+CharA(13)+CharA(10)+ &
				' )'+CharA(13)+CharA(10) +&
				'htmltable(border="1" )'+CharA(13)+CharA(10) +&
				'htmlgen(clientevents="1" clientvalidation="1" clientcomputedfields="1" clientformatting="0" clientscriptable="0" generatejavascript="1" encodeselflinkargs="1" netscapelayers="0" pagingmethod=0 generatedddwframes="1" )'+CharA(13)+CharA(10) +&
				'xhtmlgen() cssgen(sessionspecific="0" )'+CharA(13)+CharA(10) +&
				'xmlgen(inline="0" )'+CharA(13)+CharA(10) +&
				'xsltgen()'+CharA(13)+CharA(10) +&
				'jsgen()'+CharA(13)+CharA(10) +&
				'export.xml(headgroups="1" includewhitespace="0" metadatatype=0 savemetadata=0 )'+CharA(13)+CharA(10) +&
				'import.xml()'+CharA(13)+CharA(10) +&
				'export.pdf(method=0 distill.custompostscript="0" xslfop.print="0" )'+CharA(13)+CharA(10) +&
				'export.xhtml()'
				
dw_2.Create(lvs_sintaxe, lvs_err)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;ivs_Parametros={""}

This.SetSQLSelect(ivs_SQL)

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_imprimir(pl_linhas > 0)
This.ivm_menu.mf_Classificar(pl_linhas > 0)
This.ivm_menu.mf_Filtrar(pl_linhas > 0)
This.ivm_menu.mf_SalvarComo(pl_linhas > 0)

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within dc_w_selecao_lista_dinamica_relatorio
integer x = 1842
integer y = 144
end type

event dw_3::constructor;call super::constructor;This.Modify("DataWindow.Print.Preview=Yes")
end event

event dw_3::ue_preprint;call super::ue_preprint;/*Long lvl_Param
Long lvl_Colunas
Long lvl_Coluna
Long lvl_Y
Long lvl_Width = 0

String lvs_Coluna
String lvs_ColumnType
String lvs_Sumariza

//Insere par$$HEX1$$e200$$ENDHEX$$metros preenchidos
For lvl_Param = 1 To UpperBound(ivs_Parametros)
	If Trim(ivs_Parametros[lvl_Param]) <> '' Then
		This.Modify('create text(band=header alignment="0" text="'+ivs_Parametros[lvl_Param]+'" border="0" color="0" x="'+This.Describe("#1.X")+'" y="'+String(80+(lvl_Param*76))+'" height="72" width="1000" html.valueishtml="0"  name=titulo_dw visible="1"  font.face="Verdana" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
	End if
Next

//Retorna N$$HEX1$$ba00$$ENDHEX$$ de Colunas do SQL
lvl_Colunas = Long(This.Describe("DataWindow.Column.Count"))
//Seta Tamanho Detail
This.Modify("DataWindow.Detail.Height='64'")
//Seta Tamanho Cabe$$HEX1$$e700$$ENDHEX$$alho
This.Modify("DataWindow.Header.Height.AutoSize='Yes'")

dw_campos.SetFilter(" id_visivel = 'S' ")
dw_campos.Filter()

for lvl_Coluna = 1 to lvl_Colunas
	lvs_Sumariza = dw_campos.Object.id_sumariza [lvl_Coluna]
	//Recupera nome coluna
	lvs_Coluna = This.Describe("#"+String(lvl_Coluna)+".Name")
	lvs_ColumnType = Upper(This.Describe("#"+String(lvl_Coluna)+".Coltype"))
	//Altera Posi$$HEX2$$e700e300$$ENDHEX$$o
	This.Modify(lvs_Coluna+"_t.Y='"+String(Long(This.Describe(lvs_Coluna+'.Y'))+100+(lvl_Param*76))+"'")
	lvl_Y = Long(This.Describe(lvs_Coluna+"_t.Y")) + Long(This.Describe(lvs_Coluna+"_t.Height"))
	This.Modify("l_"+String(lvl_Coluna+1)+".Y1='"+String(lvl_Y+3)+"'")
	This.Modify("l_"+String(lvl_Coluna+1)+".Y2='"+String(lvl_Y+3)+"'")
	//Diminui linha
	This.Modify(lvs_Coluna+".Height='64'")	
	//Diminui a fonte
	This.Modify(lvs_Coluna+".Font.Height='-7'")	
	//Remove a borda
	This.Modify(lvs_Coluna+".Border='0'")
	//Altera a cor
	This.Modify(lvs_Coluna+".Color='0'")
	//Altera a cor
	This.Modify(lvs_Coluna+"_t.Color='0'")
	This.Modify("l_"+String(lvl_Coluna+1)+".Pen.Color='0'")
	//Acumula largura total das colunas
	lvl_Width += Long(This.Describe(lvs_Coluna+".Width"))
	
	//Altera Sumario
	If lvs_Sumariza = 'S' Then
		//Diminui a fonte
		This.Modify("cp"+lvs_Coluna+".Font.Height='-7'")	
		//Remove a borda
		This.Modify("cp"+lvs_Coluna+".Border='0'")
		//Altera a cor
		This.Modify("cp"+lvs_Coluna+".Color='0'")
	End If
Next

dw_campos.SetFilter("")
dw_campos.Filter()

//Ajusta magens e cofigura$$HEX2$$e700e300$$ENDHEX$$o pra impress$$HEX1$$e300$$ENDHEX$$o
If lvl_Width > 3200 then
	This.Modify("DataWindow.Print.Orientation= '1'")
End If
This.Modify("DataWindow.Print.Margin.Left = 110")
This.Modify("DataWindow.Print.Margin.Right = 110")
This.Modify("DataWindow.Print.Margin.Top = 96")
This.Modify("DataWindow.Print.Margin.Bottom = 96")
This.Modify("DataWindow.Print.Paper.Source = 0")
This.Modify("DataWindow.Print.Paper.Size = 0")
This.Modify("DataWindow.Print.Canusedefaultprinter=yes")

//Insere T$$HEX1$$ed00$$ENDHEX$$tulo
This.Modify('create text(band=header alignment="2" text="'+This.Title+'" border="0" color="0" x="650" y="96" height="72" width="'+String(2200+(1300*Long(This.Describe("DataWindow.Print.Orientation"))))+'" html.valueishtml="0"  name=titulo_dw visible="1"  font.face="Verdana" font.height="-11" font.weight="700"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
//Insere N$$HEX1$$ba00$$ENDHEX$$ Pagina
This.Modify('create compute(band=header alignment="1" expression="'+"'P$$HEX1$$e100$$ENDHEX$$g. '"+" + page() + ' de ' + pageCount()"+'" border="0" color="0" x="'+String(2850+(1300*Long(This.Describe("DataWindow.Print.Orientation"))))+'" y="144" height="64" width="526" format="[general]" html.valueishtml="0"  name=pagina_dw visible="1"  font.face="Verdana" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
//Insere data impress$$HEX1$$e300$$ENDHEX$$o
This.Modify('create compute(band=header alignment="1" expression="today()" border="0" color="0" x="'+String(2850+(1300*Long(This.Describe("DataWindow.Print.Orientation"))))+'" y="60" height="64" width="526" format="dd/mm/yyyy hh:mm" html.valueishtml="0"  name=data_dw visible="1"  font.face="Verdana" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" background.transparency="0" background.gradient.color="8421504" background.gradient.transparency="0" background.gradient.angle="0" background.brushmode="0" background.gradient.repetition.mode="0" background.gradient.repetition.count="0" background.gradient.repetition.length="100" background.gradient.focus="0" background.gradient.scale="100" background.gradient.spread="100" tooltip.backcolor="134217752" tooltip.delay.initial="0" tooltip.delay.visible="32000" tooltip.enabled="0" tooltip.hasclosebutton="0" tooltip.icon="0" tooltip.isbubble="0" tooltip.maxwidth="0" tooltip.textcolor="134217751" tooltip.transparency="0" transparency="0" )')
//Ajusta tamanho cabe$$HEX1$$e700$$ENDHEX$$alho
This.Modify("DataWindow.Header.Height="+String(150+(lvl_Param*76)))
//Retira o coment$$HEX1$$e100$$ENDHEX$$rio de cuplo clique
This.Object.info_footer.Visible = False*/

Return AncestorReturnValue
end event

type dw_campos from dc_uo_dw_base within dc_w_selecao_lista_dinamica_relatorio
integer x = 1856
integer y = 464
integer width = 462
integer height = 256
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_campos_consulta"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha

This.SetSort("id_visivel desc, nr_seq_original asc")
This.Sort()

For lvl_Linha = 1 To pl_Linhas
	This.Object.nr_seq [lvl_Linha] = lvl_Linha
Next

This.SetSort("nr_seq asc")
This.Sort()

Return AncestorReturnValue
end event

event ue_recuperar;//override
Return This.Retrieve(ivl_consulta)
end event

type st_dica from statictext within dc_w_selecao_lista_dinamica_relatorio
boolean visible = false
integer x = 73
integer y = 564
integer width = 1600
integer height = 264
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "Insira o nome do relat$$HEX1$$f300$$ENDHEX$$rio na propriedade TITLE da dw_2"
alignment alignment = center!
boolean focusrectangle = false
end type

