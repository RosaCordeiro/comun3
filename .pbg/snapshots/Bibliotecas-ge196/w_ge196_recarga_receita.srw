HA$PBExportHeader$w_ge196_recarga_receita.srw
forward
global type w_ge196_recarga_receita from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge196_recarga_receita
end type
end forward

global type w_ge196_recarga_receita from dc_w_cadastro_selecao_lista
integer width = 2130
integer height = 1524
string title = "GE196 - Cadastro Receita Recarga Celular"
cb_1 cb_1
end type
global w_ge196_recarga_receita w_ge196_recarga_receita

forward prototypes
public function decimal wf_retorna_pc_receita_vigente (long pl_operadora, string ps_tipo_recarga)
end prototypes

public function decimal wf_retorna_pc_receita_vigente (long pl_operadora, string ps_tipo_recarga);Decimal{4} lvdc_PC_Receita

select r1.pc_receita 
Into :lvdc_PC_Receita
from recarga_receita r1 
where r1.cd_operadora		= :pl_operadora
	and r1.id_tipo_recarga	= :ps_tipo_recarga
	and r1.dh_inicio = (select max(dh_inicio)
							 from recarga_receita r2
							 Where r2.cd_operadora		= r1.cd_operadora
								and r2.id_tipo_recarga	= r1.id_tipo_recarga
								and r2.dh_inicio <= getdate())
Using SQLCa;

Choose Case SQLCa.SQLCode
	Case -1 
		SQLCa.Of_Msgdberror( "Falha na busca da al$$HEX1$$ed00$$ENDHEX$$quota vigente, contate a TI.")
		SetNull(lvdc_PC_Receita)
	Case 100
		SetNull(lvdc_PC_Receita)
End Choose

Return lvdc_PC_Receita

end function

on w_ge196_recarga_receita.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge196_recarga_receita.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_addrow;call super::ue_addrow;If wf_valida_salva() > 0 then
	dw_1.Object.dt_inicio [1] = RelativeDate(Today(),1)
	dw_2.Post Event ue_Retrieve()
End If
end event

event open;call super::open;This.ivm_menu.ivb_permite_incluir = True
This.ivm_menu.ivb_permite_excluir = False

This.ivm_menu.Post mf_incluir(True)
This.ivm_menu.Post mf_excluir(False)
end event

event ue_preopen;call super::ue_preopen;MaxHeight = 1500
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge196_recarga_receita
integer x = 123
integer y = 2100
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge196_recarga_receita
integer x = 87
integer y = 2036
integer height = 228
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge196_recarga_receita
integer y = 72
integer width = 672
integer height = 84
string dataobject = "dw_ge196_selecao"
end type

event dw_1::editchanged;call super::editchanged;Dw_2.Post Event ue_reset()
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	dw_2.Post Event ue_Retrieve()
End If
end event

event dw_1::getfocus;call super::getfocus;This.ivm_menu.mf_incluir( False )
This.ivm_menu.mf_excluir( False )
end event

event dw_1::ue_cancel;//override
Return 
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge196_recarga_receita
integer y = 196
integer width = 2034
integer height = 1124
string text = "% Receita Sobre a Recarga"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge196_recarga_receita
integer width = 731
integer height = 172
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge196_recarga_receita
integer y = 272
integer width = 1979
integer height = 1024
string dataobject = "dw_ge196_cadastro"
end type

event dw_2::ue_recuperar;Date lvdt_Inicio

String lvs_Tipo

dw_1.AcceptText( )
lvdt_Inicio = dw_1.Object.dt_inicio [1]

Return This.Retrieve(lvdt_Inicio)
end event

event dw_2::ue_postretrieve;//override
Long lvl_Linha
Long lvl_Linhas
Long lvl_Codigo
String lvs_Operadora
String lvs_Tipo

If pl_linhas = 0 Then
	/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
	DECLARE lcu_operadora CURSOR FOR
	SELECT o.cd_operadora, o.nm_operadora
	FROM operadora_telefonia o
	Where o.id_recarga = 'S'
	Order by 1;
	
	// Abrindo o cursor
	OPEN lcu_operadora;
	
	// Buscar a primeira linha do resultado
	FETCH lcu_operadora INTO :lvl_Codigo,:lvs_Operadora;
	
	// Repetir Enquanto Houver Linhas
	DO WHILE SQLCA.sqlcode = 0
		lvl_Linha = This.InsertRow(0)
		This.Object.cd_operadora	[lvl_Linha] = lvl_Codigo
		This.Object.nm_operadora	[lvl_Linha] = lvs_Operadora
		This.Object.id_altera			[lvl_Linha] = 'S'
		This.Object.id_tipo_recarga [lvl_Linha] = '1'
		This.Object.pc_receita		[lvl_Linha] = wf_retorna_pc_receita_vigente(lvl_Codigo, '1')
		
		
		lvl_Linhas = This.InsertRow(0)
		This.Object.cd_operadora	[lvl_Linhas] = lvl_Codigo
		This.Object.nm_operadora	[lvl_Linhas] = lvs_Operadora
		This.Object.id_altera			[lvl_Linhas] = 'S'
		This.Object.id_tipo_recarga [lvl_Linhas] = '2'
		This.Object.pc_receita		[lvl_Linhas] = wf_retorna_pc_receita_vigente(lvl_Codigo, '2')
		
		//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
		FETCH lcu_operadora INTO :lvl_Codigo,:lvs_Operadora;
	LOOP
	
	// No fim fechar o cursor
	CLOSE lcu_operadora;

End If

//Chama evento ancestral
SUPER::EVENT ue_PostRetrieve(This.RowCount())

This.ivm_menu.mf_incluir(True)
This.ivm_menu.mf_excluir(False)

If This.RowCount() > 0 Then
	This.Post Event ue_Pos(1,'pc_receita')
End If

Return This.RowCount()
end event

event dw_2::ue_update;//override
Long lvl_Linha
Long lvl_Operadora

Datetime lvdh_Inicio

String lvs_Altera
String lvs_Tipo

Decimal{2} lvdc_Receita

If ivb_grava_log Then
	gf_grava_log_alteracao(This)
End If

dw_1.Accepttext( )
lvdh_Inicio = Datetime(dw_1.Object.dt_inicio [1])
lvs_Tipo = dw_1.Object.Id_Tipo_Recarga[1]

For lvl_Linha = 1 To This.RowCount()
	lvs_Altera 		= This.Object.id_altera 		[lvl_Linha]
	lvl_Operadora	= This.Object.cd_operadora	[lvl_Linha]
	lvdc_Receita		= This.Object.pc_receita		[lvl_Linha]
	lvs_Tipo			= This.Object.id_tipo_recarga [lvl_Linha]
	
	If lvs_Altera = 'S' Then
		Insert into recarga_receita (cd_operadora, dh_inicio, pc_receita, id_tipo_recarga)
		Values(:lvl_Operadora, :lvdh_Inicio, :lvdc_Receita, :lvs_Tipo)
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.of_rollback( )
			SQLCa.of_msgdberror('Inserir registro recarga_receita.')
			Return -1
		End If
	End If 
Next

SQLCa.Of_commit( )

Return 1
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date lvdt_Inicio
Date lvdt_Max

Long lvl_Count

String lvs_Tipo

dw_1.Accepttext( )
lvdt_Inicio = dw_1.Object.dt_inicio [1] 
lvs_Tipo = dw_1.Object.Id_Tipo_Recarga[1]

If Not wf_valida_salva() > 0 then Return -1

If lvdt_Inicio >= Date('2011/01/01') Then
	select count(1)
	Into :lvl_Count
	From recarga_receita
	where dh_inicio = :lvdt_Inicio
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.of_msgdberror('Recuperar recarga_receita na data informada.')
		Return -1
	ElseIf lvl_Count = 0 Then
		
		If lvdt_Inicio < gf_primeiro_dia_mes(Today()) Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel inserir percentual de receita para meses anteriores!',Exclamation!)
			Return -1
		Else
		
			select max(dh_inicio)
			Into :lvdt_Max
			From recarga_receita
			Using SQLCa;
	
			If SQLCa.SQLCode = -1 Then
				SQLCa.of_msgdberror('Recuperar maior data de recarga_receita configurada.')
				Return -1
			End If
			
			If lvdt_Inicio < lvdt_Max Then
				If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','J$$HEX1$$e100$$ENDHEX$$ existe uma parametriza$$HEX2$$e700e300$$ENDHEX$$o mais recente, com in$$HEX1$$ed00$$ENDHEX$$cio em: '+String(lvdt_Max,'DD/MM/YYYY') + &
									'.~rDeseja inserir novos percentuais de receita recarga para '+String(lvdt_Inicio,'DD/MM/YYYY')+' assim mesmo?',Question!,YesNo!,2) = 2 Then
					Return -1
				End If
			End If
			
			If lvdt_Inicio < Today() Then
				If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Caso a data de in$$HEX1$$ed00$$ENDHEX$$cio seja inferior a data atual ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio o reimportar os caixas para o sistema cont$$HEX1$$e100$$ENDHEX$$bil.~r~r'+ &
									'Deseja continuar o cadastro com data de in$$HEX1$$ed00$$ENDHEX$$cio em '+String(lvdt_Inicio,'DD/MM/YYYY')+'?',Exclamation!,YesNo!,2) = 2 Then
					Return -1
				End If
			End If
		End If
	End If
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'Data inv$$HEX1$$e100$$ENDHEX$$lida ou inferior a 01/01/2011.',Exclamation!)
	Return -1
End If

If lvs_Tipo <> "T" Then
	This.of_AppendWhere("id_tipo_recarga = '" + lvs_Tipo + "'")
End If

Return AncestorReturnValue
end event

event dw_2::ue_key;call super::ue_key;Long lvl_linha
Long lvl_Operadora

If (Key = KeyF4!) Then
	lvl_linha = This.GetRow()
	
	If lvl_linha > 0 Then
		lvl_Operadora = This.Object.cd_operadora [lvl_linha]
		OpenWithParm(w_ge196_selecao_receita_recarga, lvl_Operadora)
	End If
End If
end event

event dw_2::getfocus;call super::getfocus;This.ivm_menu.mf_incluir( True )
This.ivm_menu.mf_excluir( False )
end event

event dw_2::ue_addrow;call super::ue_addrow;//override
Return -1
end event

event dw_2::constructor;call super::constructor;ivi_tipo_cancelar = Retrieve

end event

type cb_1 from commandbutton within w_ge196_recarga_receita
integer x = 795
integer y = 64
integer width = 613
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar Existentes"
end type

event clicked;String lvs_Data

OpenWithParm(w_ge196_selecao_receita_recarga,0)

lvs_Data = Message.StringParm

If IsDate(lvs_Data) Then
	dw_1.Object.dt_inicio [1] = Date(lvs_Data)
	dw_2.Post Event ue_Retrieve()
End If


end event

