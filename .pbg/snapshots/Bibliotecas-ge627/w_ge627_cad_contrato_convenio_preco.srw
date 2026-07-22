HA$PBExportHeader$w_ge627_cad_contrato_convenio_preco.srw
forward
global type w_ge627_cad_contrato_convenio_preco from dc_w_cadastro_selecao_lista
end type
type dw_3 from dc_uo_dw_base within w_ge627_cad_contrato_convenio_preco
end type
type dw_4 from dc_uo_dw_base within w_ge627_cad_contrato_convenio_preco
end type
type gb_3 from groupbox within w_ge627_cad_contrato_convenio_preco
end type
type gb_4 from groupbox within w_ge627_cad_contrato_convenio_preco
end type
end forward

global type w_ge627_cad_contrato_convenio_preco from dc_w_cadastro_selecao_lista
integer width = 4279
integer height = 2164
string title = "GE627 - Cadastro Pre$$HEX1$$e700$$ENDHEX$$o Conv$$HEX1$$ea00$$ENDHEX$$nio"
dw_3 dw_3
dw_4 dw_4
gb_3 gb_3
gb_4 gb_4
end type
global w_ge627_cad_contrato_convenio_preco w_ge627_cad_contrato_convenio_preco

type variables
uo_convenio ivo_convenio
uo_produto ivo_produto
end variables

forward prototypes
public subroutine wf_localiza_convenio ()
public function boolean wf_busca_percentual_prod (string ps_id_lei_generico, ref decimal pc_desconto, ref string ls_log)
public function boolean wf_atualiza_produtos ()
public function boolean wf_atualiza_data_contrato (long pl_cd_convenio, long pl_nr_contrato, ref string ps_log)
end prototypes

public subroutine wf_localiza_convenio ();String lvs_Convenio

Date	lvdt_Vencimento

lvs_Convenio = dw_1.GetText()

ivo_Convenio.of_Localiza_Convenio(lvs_Convenio)

If ivo_Convenio.Localizado Then
	dw_1.Object.Cd_Convenio[1] = ivo_Convenio.Cd_Convenio
	dw_1.Object.Nm_Fantasia[1] = ivo_Convenio.Nm_Fantasia

	dw_2.Event ue_Retrieve()
	If dw_2.rowcount( ) > 0 Then
		dw_3.Event ue_Retrieve()
		dw_4.Event ue_Retrieve()
	End If
	
	ivm_Menu.mf_Incluir(True)
	ivm_Menu.mf_Recuperar(True)
	
End If
end subroutine

public function boolean wf_busca_percentual_prod (string ps_id_lei_generico, ref decimal pc_desconto, ref string ls_log);long ll_find

ll_find = dw_2.find( 'id_lei_generico = "' + ps_id_lei_generico + '"', 1, dw_2.rowcount())

//if ll_find


return true
end function

public function boolean wf_atualiza_produtos ();long ll_cd_convenio
long ll_nr_contrato

string ls_log

uo_ge627_contrato_convenio luo_contrato

Try

	ll_cd_convenio = dw_2.getitemnumber(dw_2.getrow(), 'cd_convenio')
	ll_nr_contrato = dw_2.getitemnumber(dw_2.getrow(), 'nr_contrato')
	
	if ll_cd_convenio = 0 or isnull(ll_cd_convenio) Then
		ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar os produtos. N$$HEX1$$fa00$$ENDHEX$$mero do convenio n$$HEX1$$e300$$ENDHEX$$o encontrado.'
		return false
	ENd if
	
	if ll_nr_contrato = 0 or isnull(ll_nr_contrato) Then
		ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel atualizar os produtos. N$$HEX1$$fa00$$ENDHEX$$mero do contrato n$$HEX1$$e300$$ENDHEX$$o encontrado.'
		return false
	ENd if
	
	if Not this.wf_atualiza_data_contrato( ll_cd_convenio, ll_nr_contrato, ref ls_log) then return false
	
	luo_contrato = create uo_ge627_contrato_convenio
	
	luo_contrato.of_atualiza_contratos( ll_cd_convenio, ll_nr_contrato)
	
	dw_4.Event ue_retrieve()
	
Finally
	
	destroy(luo_contrato)
		
	if ls_log <> '' and not isnull(ls_log) then messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_log)
	
End Try

return true
end function

public function boolean wf_atualiza_data_contrato (long pl_cd_convenio, long pl_nr_contrato, ref string ps_log);
update contrato_preco_convenio
set dh_atualizacao_desconto = dbo.adddate( 'day', -1, (select dh_movimentacao from parametro) ),
     id_utiliza_desc_parametrizado = 'S'
where cd_convenio = :pl_cd_convenio
and nr_contrato = :pl_nr_contrato;

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao atualizar a tabela contrato_preco_convenio: ' + sqlca.sqlerrtext
	return false
End if

return true
end function

on w_ge627_cad_contrato_convenio_preco.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.dw_4=create dw_4
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.gb_4
end on

on w_ge627_cad_contrato_convenio_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2, dw_3, dw_4}
This.wf_SetUpdate_DW(lvo_Update)

ivo_Convenio  = Create uo_Convenio
ivo_produto = Create uo_produto

This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Recuperar(False)
This.ivm_Menu.mf_Excluir(False)

This.ivm_Menu.mf_SalvarComo(True)
dw_4.ivo_Controle_Menu.of_SalvarComo(True)

dw_1.SetFocus()

end event

event ue_addrow;GraphicObject lg_objeto
string ls_classname

lg_objeto = getfocus()

if isvalid(lg_objeto) Then
	ls_classname = lg_objeto.classname( )
	
	if ls_classname = 'dw_2' Then
		dw_2.Event ue_AddRow()
	ENd if
	
ENd if

end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	wf_atualiza_produtos()
End If

return 1
end event

event ue_preupdate;call super::ue_preupdate;dw_3.accepttext( )

if dw_3.find('pc_desconto = 0 or isnull(pc_desconto)', 1, dw_3.rowcount()) > 0 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O Percentual de desconto deve ser preenchido.')
	return false
end if

if dw_3.find('pc_desconto > 50', 1, dw_3.rowcount()) > 0 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O Percentual de desconto nao pode ser superior a 50%.')
	return false
end if

return true
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge627_cad_contrato_convenio_preco
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge627_cad_contrato_convenio_preco
integer x = 357
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge627_cad_contrato_convenio_preco
integer x = 73
integer width = 1970
integer height = 96
string dataobject = "dw_ge627_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Data <> ivo_Convenio.Nm_Fantasia Then
			Return 1
		End If
			
End Choose
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "nm_fantasia"
			wf_Localiza_Convenio()
	End Choose
End If
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge627_cad_contrato_convenio_preco
integer y = 252
integer width = 2939
integer height = 480
string text = "Contratos"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge627_cad_contrato_convenio_preco
integer width = 2030
integer height = 220
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge627_cad_contrato_convenio_preco
integer y = 336
integer width = 2866
integer height = 372
string dataobject = "dw_ge627_contrato"
end type

event dw_2::ue_recuperar;long ll_cd_convenio

dw_1.accepttext( )

ll_cd_convenio = dw_1.getitemnumber(1,'cd_convenio')

Return This.Retrieve(ll_cd_convenio)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If this.rowcount( ) > 0 Then
	dw_3.Event ue_Retrieve()
	dw_4.Event ue_Retrieve()
Else
	dw_3.reset()
	dw_4.reset()
End If

end event

event dw_2::ue_preupdate;long ll_Linha, ll_linhas, ll_linha_desc
long ll_nr_contrato, ll_cd_convenio

string ls_erro

datetime ldh_atual, ldh_inicio, ldh_termino

dwitemstatus ldw_status

Try 

	ldh_atual = gf_getserverdate()
	
	ll_Linha = this.getrow()
	
	ldw_status = this.getitemstatus( ll_linha, 0, primary!)
	
	ll_cd_convenio = dw_1.getitemnumber(1, 'cd_convenio')
	
	ldh_inicio = this.getitemdatetime(ll_linha, 'dh_inicio')
	ldh_termino = this.getitemdatetime(ll_linha, 'dh_termino')
	
	if isnull(ldh_inicio) or date(ldh_inicio) = date('01/01/1900') Then
		ls_erro = 'A data de in$$HEX1$$ed00$$ENDHEX$$cio do contrato deve ser preenchida.'
		return -1
	ENd if
	
	if isnull(ldh_termino) or date(ldh_termino) = date('01/01/1900') Then
		ls_erro = 'A data de t$$HEX1$$e900$$ENDHEX$$rmino do contrato deve ser preenchida.'
		return -1
	ENd if
	
	if date(ldh_inicio) <= date(ldh_atual) Then
		ls_erro = 'A data de in$$HEX1$$ed00$$ENDHEX$$cio do contrato deve ser superior a data atual.'
		return -1
	ENd if
	
	if  ldh_inicio >= ldh_termino Then
		ls_erro = 'A data de in$$HEX1$$ed00$$ENDHEX$$cio do contrato deve ser inferior a data de t$$HEX1$$e900$$ENDHEX$$rmino.'
		return -1
	ENd if
	
	
	If ldw_status = NewModified! then
		
		
		select max(nr_contrato)
		into :ll_nr_contrato
		from contrato_preco_convenio 
		where cd_convenio = :ll_cd_convenio;
		
		if sqlca.sqlcode = -1 then
			ls_erro = 'Erro ao consultar a tabela contrato_preco_convenio: ' + sqlca.sqlerrtext
			return -1
		ENd if
		
		if ll_nr_contrato = 0 or isnull(ll_nr_contrato) then
			ll_nr_contrato = 1
		Else
			ll_nr_contrato++
		ENd if
		
		this.setitem(ll_linha,'cd_convenio', ll_cd_convenio)
		this.setitem(ll_linha,'nr_contrato', ll_nr_contrato)
		this.setitem(ll_linha,'dh_atualizacao_desconto', ldh_atual)
		
		For ll_linha_desc = 1 to dw_3.rowcount( ) 
			If IsNull(dw_3.Object.nr_contrato [ll_linha_desc]) Or dw_3.Object.nr_contrato [ll_linha_desc] = 0 Then 
				dw_3.Object.nr_contrato [ll_linha_desc] = ll_nr_contrato
			End If
		Next
		
	ENd if

Finally
	
	if ls_erro <> '' and not isnull(ls_erro) then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_erro)
	ENd if
	
End Try

return 1
end event

event dw_2::ue_postretrieve;//OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

If pl_Linhas > 0 Then
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar		= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)
	
	//lvb_Excluir = True

	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(False)

Return pl_Linhas
end event

event dw_2::getfocus;call super::getfocus;Parent.ivm_Menu.mf_Excluir(False)
end event

type dw_3 from dc_uo_dw_base within w_ge627_cad_contrato_convenio_preco
integer x = 78
integer y = 844
integer width = 1271
integer height = 1052
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge627_generico"
end type

event ue_recuperar;long ll_cd_convenio, ll_nr_contrato

ll_cd_convenio = dw_1.getitemnumber(1,'cd_convenio')
ll_nr_contrato = dw_2.getitemnumber(dw_2.getrow(),'nr_contrato')

Return This.Retrieve(ll_cd_convenio, ll_nr_contrato)
end event

event ue_postretrieve;long ll_linha, ll_for
long ll_cd_convenio
long ll_nr_contrato

string ls_id_generico, ls_de_tipo

decimal{2} ldc_desconto

if pl_linhas = 0 then
	
	ll_cd_convenio = dw_1.getitemnumber(1, 'cd_convenio')
	ll_nr_contrato = dw_2.getitemnumber(dw_2.getrow(), 'nr_contrato')
	ldc_desconto = 0
	
	for ll_for = 1 to 5
		
		ll_linha = this.insertrow(0)
		
		Choose Case ll_linha
			Case 1
				ls_id_generico = 'G'
				ls_de_tipo = 'GEN$$HEX1$$c900$$ENDHEX$$RICO'
			Case 2
				ls_id_generico = 'S'
				ls_de_tipo = 'SIMILAR'
			Case 3
				ls_id_generico = 'R'
				ls_de_tipo = 'REFER$$HEX1$$ca00$$ENDHEX$$NCIA'
			Case 4
				ls_id_generico = 'E'
				ls_de_tipo = 'EQUIVALENTE'
			Case 5
				ls_id_generico = 'O'
				ls_de_tipo = 'OUTROS'
		End Choose
		
		this.setitem(ll_linha, 'cd_convenio', ll_cd_convenio)
		this.setitem(ll_linha, 'nr_contrato', ll_nr_contrato)
		this.setitem(ll_linha, 'cd_grupo', '1')
		
		this.setitem(ll_linha, 'id_lei_generico', ls_id_generico)
		this.setitem(ll_linha, 'pc_desconto', ldc_desconto)
		this.setitem(ll_linha, 'de_tipo', ls_de_tipo)
		
	Next
	
ENd if

return 1
end event

event editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_preupdate;call super::ue_preupdate;long ll_Linha, ll_linhas

string ls_erro, ls_matricula

datetime ldh_atual

dwitemstatus ldw_status

Try 

	ldh_atual = gf_getserverdate()
	ls_matricula = gvo_aplicacao.ivo_seguranca.nr_matricula
	
	
	For ll_linha = 1 to this.rowcount( )
	
		ldw_status = this.getitemstatus( ll_linha, 0, primary!)
	
		If ldw_status = NewModified! or ldw_status = DataModified!  then		
			this.setitem(ll_linha,'nr_matricula_alteracao', ls_matricula)
			this.setitem(ll_linha,'dh_alteracao', ldh_atual)				
		ENd if
		
	Next

Finally
	
	if ls_erro <> '' and not isnull(ls_erro) then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_erro)
	ENd if
	
End Try

return 1
end event

event itemchanged;call super::itemchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

type dw_4 from dc_uo_dw_base within w_ge627_cad_contrato_convenio_preco
integer x = 1522
integer y = 844
integer width = 2651
integer height = 1064
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge627_produto"
boolean vscrollbar = true
end type

event ue_recuperar;long ll_cd_convenio, ll_nr_contrato

ll_cd_convenio = dw_1.getitemnumber(1,'cd_convenio')
ll_nr_contrato = dw_2.getitemnumber(dw_2.getrow(),'nr_contrato')

Return This.Retrieve(ll_cd_convenio, ll_nr_contrato)
end event

event constructor;call super::constructor;This.of_SetRowSelection()

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

type gb_3 from groupbox within w_ge627_cad_contrato_convenio_preco
integer x = 37
integer y = 776
integer width = 1367
integer height = 1152
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lei Gen$$HEX1$$e900$$ENDHEX$$rico dos Medicamentos"
end type

type gb_4 from groupbox within w_ge627_cad_contrato_convenio_preco
integer x = 1481
integer y = 776
integer width = 2720
integer height = 1164
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
end type

