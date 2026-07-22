HA$PBExportHeader$w_ge404_rel_dinamico_perfil_temp.srw
forward
global type w_ge404_rel_dinamico_perfil_temp from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge404_rel_dinamico_perfil_temp from dc_w_selecao_lista_dinamica_relatorio
integer width = 3301
integer height = 1444
string title = "GE404 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Perfis Tempor$$HEX1$$e100$$ENDHEX$$rios"
end type
global w_ge404_rel_dinamico_perfil_temp w_ge404_rel_dinamico_perfil_temp

type variables
uo_usuario 		ivo_usuario
uo_filial 			ivo_filial
uo_cargo_rh	ivo_cargo_rh //GE384
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Grupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW( "cd_sistema" )			

ldwc_Child.SetItem(1, "cd_sistema", ""	)
ldwc_Child.SetItem(1, "nm_sistema", "TODOS")
ldwc_Child.SetItem(1, "id_loja", "S")
ldwc_Child.SetItem(1, "id_controle_acesso", "S")

ldwc_Child.SetFilter("id_loja='S' and id_controle_acesso='S'")
ldwc_Child.Filter()

dw_1.Object.cd_sistema[1] = ""

/* Regi$$HEX1$$e300$$ENDHEX$$o */
ldwc_Child  = dw_1.of_InsertRow_DDDW( "cd_regiao" )			
ldwc_Child.SetItem(1, "cd_regiao", 0	)
ldwc_Child.SetItem(1, "de_regiao", "TODAS")
dw_1.Object.cd_regiao[1] = 0
end subroutine

on w_ge404_rel_dinamico_perfil_temp.create
call super::create
end on

on w_ge404_rel_dinamico_perfil_temp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Cria$$HEX2$$e700e300$$ENDHEX$$o Objetos
ivo_usuario		= Create uo_usuario
ivo_filial			= Create uo_filial
ivo_cargo_rh	= Create uo_cargo_rh
ivo_usuario.of_todos_usuarios( )

//Dimensionamento de tela
MaxHeight 	= 9999
MaxWidth 	= 4275

//SQL Base para formar o grid
ivs_sqlbase = 	"from usuario_sistema_temporario t "				+ &
					"inner join filial f "											+ &
					"	on f.cd_filial = t.cd_filial_usuario "					+ &
					"inner join sistema s "									+ &
					"	on s.cd_sistema = t.cd_sistema "					+ &
					"inner join usuario ub "									+ &
					"	on ub.nr_matricula = t.nr_matricula " 			+ &
					"inner join perfil_usuario pua "							+ &
					"	on pua.cd_sistema = t.cd_sistema "				+ &
					"	and pua.cd_perfil_usuario = t.cd_perfil_atual "	+ &
					"inner join perfil_usuario put " 							+ &
					"	on put.cd_sistema = t.cd_sistema " 				+ &
					"	and put.cd_perfil_usuario = t.cd_perfil_temporario " + &
					"inner join usuario ui " 									+ &
					"	on ui.nr_matricula = t.nr_matricula_inclusao "	+ &
					"inner join regiao r "										+ &
					"	on r.cd_regiao = f.cd_regiao "						+ &
					"left outer join usuario ur "								+ &
					"	on ur.nr_matricula = r.nr_matricula_regional "	+ &
					"left outer join cargo_rh crh "							+ &
					"	on crh.cd_cargo_rh = ub.cd_cargo_rh "			+ &
					"Where f.cd_filial = t.cd_filial_usuario "
			
//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_consulta = 19
end event

event close;call super::close;Destroy(ivo_cargo_rh)
Destroy(ivo_usuario)
Destroy(ivo_filial)
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()

dw_1.Object.dh_vigencia_ini	[1] = Datetime(Today(), Time('00:00:00'))
dw_1.Object.dh_vigencia_fim	[1] = Datetime(Today(), Time('23:59:59'))
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge404_rel_dinamico_perfil_temp
integer x = 87
integer y = 1804
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge404_rel_dinamico_perfil_temp
integer x = 50
integer y = 1732
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge404_rel_dinamico_perfil_temp
integer width = 3200
integer height = 856
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge404_rel_dinamico_perfil_temp
integer width = 3200
integer height = 356
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge404_rel_dinamico_perfil_temp
integer width = 3136
integer height = 248
string dataobject = "dw_ge404_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case 'nm_usuario' 
		If Data <> ivo_usuario.nm_usuario Then
			If Data <> '' Then
				Return 1
			Else
				ivo_usuario.of_inicializa( )
				This.Object.nr_matricula	[Row] = ivo_usuario.nr_matricula
				This.Object.nm_usuario	[Row] = ivo_usuario.nm_usuario
			End If
		End If
		
	Case 'nm_filial' 
		If Data <> ivo_filial.nm_fantasia Then
			If Data <> '' Then
				Return 1
			Else
				ivo_filial.of_inicializa( )
				This.Object.cd_filial		[Row] = ivo_filial.cd_filial
				This.Object.nm_filial		[Row] = ivo_filial.nm_fantasia
			End If
		End If
		
	Case 'de_cargo_rh' 
		If Data <> ivo_cargo_rh.de_cargo_rh Then
			If Data <> '' Then
				Return 1
			Else
				ivo_cargo_rh.of_inicializa( )
				This.Object.cd_cargo_rh		[Row] = ivo_cargo_rh.cd_cargo_rh
				This.Object.de_cargo_rh		[Row] = ivo_cargo_rh.de_cargo_rh
			End If
		End If
		
	Case 'id_master'
		This.Object.id_inclui	[Row] = 'T'
		This.Object.id_altera	[Row] = 'T'
		This.Object.id_exclui	[Row] = 'T'
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_usuario) Then
	This.Object.nm_usuario [1] = ivo_usuario.nm_usuario
End if

If IsValid(ivo_Filial) Then
	This.Object.nm_filial [1] = ivo_Filial.nm_fantasia
End if

If IsValid(ivo_cargo_rh) Then
	This.Object.de_cargo_rh [1] = ivo_cargo_rh.de_cargo_rh
End If
end event

event dw_1::ue_key;call super::ue_key;If Key=KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'nm_usuario'
			ivo_usuario.of_inicializa( )
			ivo_usuario.of_localiza_usuario(This.GetText())
			
			This.Object.nr_matricula	[1] = ivo_usuario.nr_matricula
			This.Object.nm_usuario	[1] = ivo_usuario.nm_usuario	
			
		Case 'nm_filial'
			ivo_filial.of_inicializa( )
			ivo_filial.of_localiza_filial(This.GetText())
			
			This.Object.cd_filial	[1] = ivo_filial.cd_filial
			This.Object.nm_filial	[1] = ivo_filial.nm_fantasia	
			
		Case 'de_cargo_rh'
			ivo_cargo_rh.of_inicializa( )
			ivo_cargo_rh.of_localiza(This.GetText())
			
			This.Object.cd_cargo_rh	[1] = ivo_cargo_rh.cd_cargo_rh
			This.Object.de_cargo_rh	[1] = ivo_cargo_rh.de_cargo_rh	
			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge404_rel_dinamico_perfil_temp
integer width = 3131
integer height = 748
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio de Permiss$$HEX1$$f500$$ENDHEX$$es Tempor$$HEX1$$e100$$ENDHEX$$rias"
boolean hscrollbar = false
boolean hsplitscroll = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Matricula
String lvs_Inclui
String lvs_Exclui
String lvs_Altera
String lvs_Sistema
String lvs_SQLAux
String lvs_Cargo

Long lvl_Filial
Long lvl_SubQuery = 0
Long lvl_Regiao

Datetime lvdh_Vigencia_Ini
Datetime lvdh_Vigencia_Fim

dw_1.Accepttext( )

lvs_Matricula		= dw_1.Object.nr_matricula			[1]
lvs_Sistema			= dw_1.Object.cd_sistema			[1]
lvl_Filial 				= dw_1.Object.cd_filial				[1]
lvs_Cargo			= dw_1.Object.cd_cargo_rh			[1]
lvl_Regiao			= dw_1.Object.cd_regiao			[1]
lvdh_Vigencia_Ini	= dw_1.Object.dh_vigencia_ini		[1]
lvdh_Vigencia_Fim	= dw_1.Object.dh_vigencia_fim	[1]

lvs_SQLAux = This.GetSQLSelect()
Do While Pos(Upper(lvs_SQLAux), "WHERE ") > 0 
	lvl_SubQuery ++
	lvs_SQLAux = Mid(lvs_SQLAux, Pos(Upper(lvs_SQLAux), "WHERE ") + 7)
Loop

If Not IsNull(lvs_Matricula) and (Trim(lvs_Matricula)<>'') Then
	This.Of_AppendWhere_SubQuery("t.nr_matricula = '"+lvs_Matricula+"'", lvl_SubQuery)
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = "Usu$$HEX1$$e100$$ENDHEX$$rio Beneficiado: "+ivo_usuario.nm_usuario+" ("+ivo_usuario.nr_matricula+")"
End if

If Not IsNull(lvs_Sistema) and (Trim(lvs_Sistema)<>'') Then
	This.Of_AppendWhere_SubQuery("t.cd_sistema = '"+lvs_Sistema+"'", lvl_SubQuery)
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = "Sistema: "+dw_1.Describe("Evaluate('LookUpDisplay(cd_sistema)',1)")
End if

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.Of_AppendWhere_SubQuery("t.cd_filial_usuario = "+String(lvl_Filial), lvl_SubQuery)
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = "Filial Beneficiado: "+ivo_filial.nm_fantasia+" ("+String(ivo_filial.cd_filial)+")"
ElseIf Not IsNull(lvl_Regiao) and (lvl_Regiao > 0) Then
	This.Of_AppendWhere_SubQuery("f.cd_regiao = "+String(lvl_Regiao), lvl_SubQuery)
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = "Regi$$HEX1$$e300$$ENDHEX$$o: "+dw_1.Describe("Evaluate('LookUpDisplay(cd_regiao)',1)")
End If

If (Not IsNull(lvdh_Vigencia_Ini) and (lvdh_Vigencia_Ini >= Datetime('2017/01/01'))) or (Not IsNull(lvdh_Vigencia_Fim) and (lvdh_Vigencia_Fim >= Datetime('2017/01/01'))) Then
	If IsNull(lvdh_Vigencia_Fim) Then lvdh_Vigencia_Fim = lvdh_Vigencia_Ini
	If IsNull(lvdh_Vigencia_Ini) Then lvdh_Vigencia_Ini = lvdh_Vigencia_Fim
	
	This.Of_AppendWhere_SubQuery("((t.dh_inicio_vigencia <= '"+String(lvdh_Vigencia_Fim, 'YYYY/MM/DD HH:MM')+"') and "+&
													"(t.dh_termino_vigencia >= '"+String(lvdh_Vigencia_Ini, 'YYYY/MM/DD HH:MM')+"'))", lvl_SubQuery)

	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = "Vigentes entre: "+String(lvdh_Vigencia_Ini, 'DD/MM/YYYY HH:MM')+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdh_Vigencia_Fim, 'DD/MM/YYYY HH:MM')
End If

If lvs_Cargo<>"T" Then
	This.Of_AppendWhere_SubQuery("ub.cd_cargo_rh = '"+lvs_Cargo+"'", lvl_SubQuery)
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = "Cargo RH: "+ivo_cargo_rh.de_cargo_rh+" ("+lvs_Cargo+")"
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
String lvs_SQL

lvs_SQL = Trim( This.GetSQLSelect() )
lvs_SQL = Mid(lvs_SQL,1, 7)+ ' distinct '+Mid(lvs_SQL,8)

This.SetSQLSelect(lvs_SQL)

Return This.Retrieve()
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge404_rel_dinamico_perfil_temp
integer x = 3666
integer y = 700
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge404_rel_dinamico_perfil_temp
integer x = 3753
integer y = 260
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge404_rel_dinamico_perfil_temp
integer x = 777
integer y = 692
end type

