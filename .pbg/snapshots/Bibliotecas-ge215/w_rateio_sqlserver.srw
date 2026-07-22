HA$PBExportHeader$w_rateio_sqlserver.srw
forward
global type w_rateio_sqlserver from dc_w_sheet
end type
type st_confirmar from statictext within w_rateio_sqlserver
end type
type em_1 from editmask within w_rateio_sqlserver
end type
type st_2 from statictext within w_rateio_sqlserver
end type
type tx_nome from singlelineedit within w_rateio_sqlserver
end type
type tx_matricula from editmask within w_rateio_sqlserver
end type
type st_1 from statictext within w_rateio_sqlserver
end type
type dw_6 from datawindow within w_rateio_sqlserver
end type
type dw_5 from datawindow within w_rateio_sqlserver
end type
type gb_3 from groupbox within w_rateio_sqlserver
end type
type dw_4 from datawindow within w_rateio_sqlserver
end type
type cb_2 from commandbutton within w_rateio_sqlserver
end type
type cb_1 from commandbutton within w_rateio_sqlserver
end type
type dw_3 from datawindow within w_rateio_sqlserver
end type
type dw_2 from datawindow within w_rateio_sqlserver
end type
type gb_2 from groupbox within w_rateio_sqlserver
end type
end forward

global type w_rateio_sqlserver from dc_w_sheet
integer x = 1399
integer y = 456
integer width = 4590
integer height = 2476
string title = "GE215 - Rateio no Vetor"
boolean maxbox = true
long backcolor = 82899184
st_confirmar st_confirmar
em_1 em_1
st_2 st_2
tx_nome tx_nome
tx_matricula tx_matricula
st_1 st_1
dw_6 dw_6
dw_5 dw_5
gb_3 gb_3
dw_4 dw_4
cb_2 cb_2
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
gb_2 gb_2
end type
global w_rateio_sqlserver w_rateio_sqlserver

type variables
long ivl_linha_dw2, ivl_tipcol, ivl_numcad, ivl_codrat, &
        ivl_numfolha
		  
decimal ivdc_proventos

boolean ivb_Check

long ivi_teste


end variables

forward prototypes
public function decimal wf_decide_pat (decimal vl_parm)
public function string wf_pega_regional (integer cd_filial)
public subroutine wf_filtro ()
public function boolean wf_recupera_inf_vetor (long pl_cod_folha)
public function boolean wf_insere_inf_vetor (long pl_cod_folha)
public function boolean wf_conecta_banco ()
end prototypes

public function decimal wf_decide_pat (decimal vl_parm); decimal lvdc_valor
 
 choose case vl_parm
		
	// 280
	case 56 ; lvdc_valor = 280.00 - 56.00
	case 112 ; lvdc_valor = 560.00 - 112.00
	case 280 ; lvdc_valor = 280.00 - 280.00
	case 336 ; lvdc_valor = 560.00 - 336.00                                                 
	case 560 ; lvdc_valor = 560.00 - 560.00                                
                                                               
	// Passo Fundo
	// e-Mail do Fernando Linhares enviado dia 24/02
	case 16.80 ; lvdc_valor = 280.00 - 16.80
	case 33.60 ; lvdc_valor = 560.00 - 33.60
	case 296.80 ; lvdc_valor = 560.00 - 296.80
                
	case else 
		
		lvdc_valor  = 0

end choose

return lvdc_valor

end function

public function string wf_pega_regional (integer cd_filial);string lvs_regional

select left(u.nm_usuario, charindex(' ', u.nm_usuario) -1) nm_regional
  into :lvs_regional
  from filial fd,
       regiao r,
       usuario u
 where fd.cd_filial = :cd_filial
   and r.cd_regiao = fd.cd_regiao
   and u.nr_matricula = r.nr_matricula_regional
 using SQLCa;
 
 return lvs_regional
end function

public subroutine wf_filtro ();String lvs_Nome
String lvs_Matricula
String lvs_Filtro
String lvs_Filtro_RH

lvs_Nome		= Trim(tx_Nome.Text)
lvs_Matricula	= Trim(tx_Matricula.Text)
lvs_Filtro = ""
lvs_Filtro_RH = ""

dw_2.SetRedraw(False)
dw_3.SetRedraw(False)

If Len(lvs_Matricula) > 3 Then
	lvs_Filtro = "nr_matricula = " + lvs_Matricula
	lvs_Filtro_RH = "numcad = " + lvs_Matricula
End If

If Len(lvs_Nome) > 2 Then
	If lvs_Filtro <> "" Then
		lvs_Filtro += " and "
		lvs_Filtro_RH += " and "
	End If
	
	lvs_Filtro += "nm_colaborador like '" + lvs_Nome + "%'"	
	lvs_Filtro_RH += "nomfun like '" + lvs_Nome + "%'"
End If

dw_2.SetFilter(lvs_Filtro_RH)
dw_2.Filter()
dw_3.SetFilter(lvs_Filtro)
dw_3.Filter()

dw_2.SetRedraw(True)
dw_3.SetRedraw(True)
end subroutine

public function boolean wf_recupera_inf_vetor (long pl_cod_folha);
String lvs_Retorno

DECLARE sp_rateio procedure for sp_rateio_folha_contabil 
  ( 
  p_cod_folha			=> :pl_cod_folha
  )
 Using gtr_rh;	

Execute sp_rateio;

Fetch sp_rateio Into :lvs_Retorno;

Close sp_rateio;

Choose Case gtr_rh.SqlCode
	Case -1
		gtr_rh.of_MsgDbError()
		Return False
End Choose

If Upper(lvs_Retorno) <> 'PROCEDURE EXECUTADA' Then
	Return False
End If

Return True
end function

public function boolean wf_insere_inf_vetor (long pl_cod_folha);Long 	lvl_TipoCol, &
		lvl_NumCad, &
		lvl_FilCTB, &
		lvl_Tabeve, &
		lvl_Codeve, &
		lvl_Codrat
		
String		lvs_NomFun, &
			lvs_NmFilial, &
			lvs_IdAdm, &
			lvs_Usu_Nomres, &
			lvs_Filnom, &
			lvs_localiza
			
Decimal {2} lvdc_Refeve, &
				lvdc_Valeve
				
ivdc_proventos = 0.00				
				
Declare c1 Cursor For Select r.tipcol,  
									 r.numcad,  
									 f.nomfun,  
									 l1.filctb,  
									case t.id_adm when 'A' then l1.nomfil  ||  - 'Adm.' else l1.nomfil end,  
									 t.id_adm,  
									 l1.usu_nomres,  
									 r.tabeve,  
									 r.codeve,  
									 l2.filctb as codrat,  
									 l2.nomfil as filnom,  
									 r.refeve,  
									 coalesce(r.valeve ,0.00) valeve
								from r046ffr r,  
									 r008evc e,  
									 r034fun f,  
									 r030fil l1,  
									 r030fil l2,  
									 historico_local t  
								where f.numemp 	= 1   
								  and f.tipcol 		= r.tipcol  
								  and f.numcad 	= r.numcad  
								  and l1.numemp 	= 1   
								  and l1.codfil 		= t.codfil  
								  and l2.numemp 	= 1   
								  and l2.codfil 		= r.codrat  
								  and t.tipcol 		= r.tipcol   
								  and t.numcad 	= r.numcad  
								  and e.codtab 		= r.tabeve   
								  and e.codeve 		= r.codeve   
								  and e.tipeve 		in (1, 2)  
								  and r.codcal 		= :pl_Cod_Folha   
								  and exists (select 1  
												 from historico_local t  
												where r.numemp 	= 1   
												  and r.tipcol 		= t.tipcol  
												  and r.numcad 	= t.numcad  
												  and r.codrat 		<> t.codfil)  
								order by r.tipcol,  
										 r.numcad,  
										  l2.filctb
								using gtr_rh;
Open c1;

If gtr_rh.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na abertura do cursor.", StopSign!, Ok!)
	Return False
End If

Fetch c1 Into 	:lvl_TipoCol,
					:lvl_NumCad,
					:lvs_NomFun,
					:lvl_FilCTB,
					:lvs_NmFilial,
					:lvs_IdAdm,
					:lvs_Usu_Nomres,
					:lvl_Tabeve,					
					:lvl_Codeve,
					:lvl_Codrat,
					:lvs_Filnom,
					:lvdc_Refeve,
					:lvdc_Valeve;

Do While gtr_rh.SqlCode = 0
	If IsNull(lvdc_Valeve) Then lvdc_Valeve = 0.00
	
	if lvl_TipoCol <> ivl_tipcol or &
		lvl_NumCad <> ivl_numcad then
		
		if ivl_tipcol <> 0 then
			If IsNull(ivdc_proventos) Then ivdc_proventos = 0.00
			
			dw_2.object.total_proventos[ivl_linha_dw2] = ivdc_proventos
			dw_2.object.encargos[ivl_linha_dw2] 		= round(ivdc_proventos * 0.6205, 2)
			dw_2.object.pat[ivl_linha_dw2] 				= 0
			dw_2.object.valetransp[ivl_linha_dw2] 		= 0
		end if
		
		ivl_codrat 		= lvl_Codrat
		ivdc_proventos 	= 0.00
		
		ivl_linha_dw2 = dw_2.insertrow(0)
		
		dw_2.object.nomfil[ivl_linha_dw2] 		= lvs_NmFilial
		dw_2.object.usu_nomres[ivl_linha_dw2] = lvs_Usu_Nomres
		dw_2.object.tipcol[ivl_linha_dw2] 			= lvl_TipoCol
		dw_2.object.numcad[ivl_linha_dw2] 		= lvl_NumCad
		dw_2.object.nomfun[ivl_linha_dw2] 		= lvs_NomFun
		dw_2.object.filnom[ivl_linha_dw2] 		= lvs_Filnom
		dw_2.object.codrat[ivl_linha_dw2] 		= lvl_Codrat
		dw_2.object.filctb[ivl_linha_dw2] 			= lvl_FilCTB
		dw_2.object.id_adm[ivl_linha_dw2] 		= lvs_IdAdm
		
		lvs_localiza 									= string(lvl_TipoCol, "0") + string(lvl_NumCad, "000000000") + string(lvl_Codrat, "0000")
		dw_2.object.localiza[ivl_linha_dw2] 	= lvs_localiza
		
		ivl_tipcol 			= lvl_TipoCol
		ivl_numcad 		= lvl_numcad
		
		If IsNull(lvdc_Valeve) Then lvdc_Valeve = 0.00
		
		ivdc_proventos	= lvdc_Valeve	
	else		
		if lvl_codrat <> ivl_codrat then
	
			If IsNull(ivdc_proventos) Then ivdc_proventos = 0.00
			
			dw_2.object.total_proventos[ivl_linha_dw2] = ivdc_proventos
			dw_2.object.encargos[ivl_linha_dw2] 		= round(ivdc_proventos * 0.6205, 2)
			dw_2.object.pat[ivl_linha_dw2] 				= 0
			dw_2.object.valetransp[ivl_linha_dw2] 		= 0
	
			ivl_linha_dw2 = dw_2.insertrow(0)
			
			dw_2.object.nomfil[ivl_linha_dw2] 		= lvs_NmFilial
			dw_2.object.usu_nomres[ivl_linha_dw2] = lvs_Usu_Nomres
			dw_2.object.tipcol[ivl_linha_dw2] 			= lvl_TipoCol
			dw_2.object.numcad[ivl_linha_dw2] 		= lvl_NumCad
			dw_2.object.nomfun[ivl_linha_dw2] 		= lvs_NomFun
			dw_2.object.filnom[ivl_linha_dw2] 		= lvs_Filnom
			dw_2.object.codrat[ivl_linha_dw2] 		= lvl_Codrat
			dw_2.object.filctb[ivl_linha_dw2] 			= lvl_FilCTB
			dw_2.object.id_adm[ivl_linha_dw2] 		= lvs_IdAdm
			
			lvs_localiza 									= string(lvl_TipoCol, "0") + string(lvl_NumCad, "000000000") + string(lvl_Codrat, "0000")
			dw_2.object.localiza[ivl_linha_dw2] 	= lvs_localiza
		
			ivl_codrat = lvl_Codrat
			
			If IsNull(lvdc_Valeve) Then lvdc_Valeve = 0.00
			
			ivdc_proventos = lvdc_Valeve	
		else			
			If IsNull(ivdc_proventos) Then ivdc_proventos = 0.00
			If IsNull(lvdc_Valeve) Then lvdc_Valeve = 0.00
			
			ivdc_proventos = ivdc_proventos + lvdc_Valeve		
		end if
	end if	
	
	Fetch c1 Into 	:lvl_TipoCol,
						:lvl_NumCad,
						:lvs_NomFun,
						:lvl_FilCTB,
						:lvs_NmFilial,
						:lvs_IdAdm,
						:lvs_Usu_Nomres,
						:lvl_Tabeve,					
						:lvl_Codeve,
						:lvl_Codrat,
						:lvs_Filnom,
						:lvdc_Refeve,
						:lvdc_Valeve;
Loop

If gtr_rh.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na sa$$HEX1$$ed00$$ENDHEX$$da do cursor.", StopSign!, Ok!)
	Return False
End If

Close c1;

decimal lvdc_mov, lvdc_rateio, lvdc_retorno, lvdc_total_proventos, lvdc_proventos_filial, lvdc_proporcao
long lvl_linha_dw2, lvl_linha_dw4, lvl_linha_dw5, lvl_linha_dw6, lvl_tipcol

setpointer(hourglass!)

// monta $$HEX1$$fa00$$ENDHEX$$ltima linha de valores
If IsNull(ivdc_proventos) Then ivdc_proventos = 0.00

If ivl_linha_dw2 > 0 Then
	dw_2.object.total_proventos[ivl_linha_dw2] = ivdc_proventos
	dw_2.object.encargos[ivl_linha_dw2] 		= round(ivdc_proventos * 0.6205, 2)
	dw_2.object.pat[ivl_linha_dw2] 				= 0
	dw_2.object.valetransp[ivl_linha_dw2] 		= 0
End If

// comp$$HEX1$$f500$$ENDHEX$$e resto da dw

For lvl_linha_dw2 = 1 to dw_2.rowcount()

	lvl_tipcol 					= dw_2.object.tipcol[lvl_linha_dw2]
	lvl_numcad 				= dw_2.object.numcad[lvl_linha_dw2]
	lvdc_proventos_filial 	= dw_2.object.total_proventos[lvl_linha_dw2]
	
	If IsNull(lvdc_proventos_filial) Then lvdc_proventos_filial = 0.00

	lvl_linha_dw5 = dw_5.retrieve(lvl_tipcol, lvl_numcad, ivl_numfolha)

	If lvl_linha_dw5 = 0 Then
		Continue
	End If

	If lvl_linha_dw5 <> 1 Then
		Return False
	End If
	
	lvdc_total_proventos 	= dw_5.object.total_proventos[lvl_linha_dw5]	
	
	If IsNull(lvdc_total_proventos) Then lvdc_total_proventos = 0.00
	
	If lvdc_Total_Proventos > 0 Then
		lvdc_proporcao = round(lvdc_proventos_filial / lvdc_total_proventos, 2)
	Else
		lvdc_proporcao = 0.00
	End If
	
	lvl_linha_dw4 = dw_4.retrieve(lvl_tipcol, lvl_numcad, ivl_numfolha)

	If lvl_linha_dw4 = 1 Then
		lvdc_mov 	= dw_4.object.valmov[lvl_linha_dw4]
		lvdc_rateio 	= dw_4.object.valrat[lvl_linha_dw4]
	
		dw_2.object.valetransp[lvl_linha_dw2] = round((lvdc_mov - lvdc_rateio) * lvdc_proporcao, 2)
	End If

	lvl_linha_dw6 = dw_6.retrieve(lvl_tipcol, lvl_numcad, ivl_numfolha)

	If lvl_linha_dw6 = 1 Then
		lvdc_mov 		= dw_6.object.valeve[lvl_linha_dw6]
		lvdc_retorno 	= round(wf_decide_pat(lvdc_mov) * lvdc_proporcao, 2)
	
		dw_2.object.pat[lvl_linha_dw2] = lvdc_retorno
	End If	
Next

dw_2.sort()

setpointer(arrow!)

Return True
end function

public function boolean wf_conecta_banco ();Return gf_conecta_banco_rh(gtr_rh, "vetorh_ti")
end function

on w_rateio_sqlserver.create
int iCurrent
call super::create
this.st_confirmar=create st_confirmar
this.em_1=create em_1
this.st_2=create st_2
this.tx_nome=create tx_nome
this.tx_matricula=create tx_matricula
this.st_1=create st_1
this.dw_6=create dw_6
this.dw_5=create dw_5
this.gb_3=create gb_3
this.dw_4=create dw_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_confirmar
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.tx_nome
this.Control[iCurrent+5]=this.tx_matricula
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.dw_6
this.Control[iCurrent+8]=this.dw_5
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.dw_4
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.dw_2
this.Control[iCurrent+15]=this.gb_2
end on

on w_rateio_sqlserver.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_confirmar)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.tx_nome)
destroy(this.tx_matricula)
destroy(this.st_1)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.gb_3)
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.gb_2)
end on

event open;x= 0
y = 0

ivl_tipcol = 0
ivl_numcad = 0
ivl_codrat = 0
ivdc_proventos = 0

end event

type dw_visual from dc_w_sheet`dw_visual within w_rateio_sqlserver
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_rateio_sqlserver
end type

type st_confirmar from statictext within w_rateio_sqlserver
boolean visible = false
integer x = 3607
integer y = 168
integer width = 878
integer height = 56
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
boolean focusrectangle = false
end type

type em_1 from editmask within w_rateio_sqlserver
integer x = 603
integer y = 24
integer width = 293
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
alignment alignment = right!
textcase textcase = upper!
string mask = "#####"
end type

type st_2 from statictext within w_rateio_sqlserver
string tag = "M$$HEX1$$ed00$$ENDHEX$$nimo tr$$HEX1$$ea00$$ENDHEX$$s digitos"
integer x = 1883
integer y = 28
integer width = 585
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Nome Colaborador:"
boolean focusrectangle = false
end type

type tx_nome from singlelineedit within w_rateio_sqlserver
event editchanged pbm_enchange
string tag = "M$$HEX1$$ed00$$ENDHEX$$nimo tr$$HEX1$$ea00$$ENDHEX$$s digitos"
integer x = 2469
integer y = 24
integer width = 1006
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
boolean enabled = false
textcase textcase = upper!
end type

event editchanged;wf_filtro()

//String lvs_Texto
//
//lvs_Texto = Trim(This.Text)
//
//dw_2.SetRedraw(False)
//dw_3.SetRedraw(False)
//
//If Len(lvs_Texto) > 2 Then
//	dw_2.SetFilter("nomfun like '" + lvs_Texto + "%'")
//	dw_2.Filter()
//	dw_3.SetFilter("nm_colaborador like '" + lvs_Texto + "%'")
//	dw_3.Filter()
//Else
//	dw_2.SetFilter("")
//	dw_2.Filter()
//	dw_3.SetFilter("")
//	dw_3.Filter()
//End If
//
//dw_2.SetRedraw(True)
//dw_3.SetRedraw(True)
end event

type tx_matricula from editmask within w_rateio_sqlserver
event editchanged pbm_enchange
string tag = "M$$HEX1$$ed00$$ENDHEX$$nimo tr$$HEX1$$ea00$$ENDHEX$$s digitos"
integer x = 3488
integer y = 24
integer width = 270
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
boolean enabled = false
alignment alignment = right!
textcase textcase = upper!
string mask = "######"
end type

event editchanged;wf_filtro()

//String lvs_Texto
//
//lvs_Texto = Trim(This.Text)
//
//dw_2.SetRedraw(False)
//dw_3.SetRedraw(False)
//
//If Len(lvs_Texto) > 3 Then
//	dw_2.SetFilter("numcad = " + lvs_Texto)
//	dw_2.Filter()
//	dw_3.SetFilter("nr_matricula = " + lvs_Texto)
//	dw_3.Filter()
//Else
//	dw_2.SetFilter("")
//	dw_2.Filter()
//	dw_3.SetFilter("")
//	dw_3.Filter()
//End If
//
//dw_2.SetRedraw(True)
//dw_3.SetRedraw(True)
end event

type st_1 from statictext within w_rateio_sqlserver
integer x = 64
integer y = 28
integer width = 553
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "N$$HEX1$$fa00$$ENDHEX$$mero da Folha:"
boolean focusrectangle = false
end type

type dw_6 from datawindow within w_rateio_sqlserver
boolean visible = false
integer x = 2473
integer y = 476
integer width = 389
integer height = 228
string dataobject = "dw_pat"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event constructor;If wf_conecta_banco() Then
	This.SetTransObject(gtr_rh)
End If
end event

type dw_5 from datawindow within w_rateio_sqlserver
boolean visible = false
integer x = 2130
integer y = 464
integer width = 320
integer height = 236
string dataobject = "dw_total_proventos"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event constructor;If wf_conecta_banco() Then
	This.SetTransObject(gtr_rh)
End If
end event

type gb_3 from groupbox within w_rateio_sqlserver
integer x = 18
integer y = 1356
integer width = 4503
integer height = 916
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Rateios a serem enviados a contabilidade"
borderstyle borderstyle = styleraised!
end type

type dw_4 from datawindow within w_rateio_sqlserver
boolean visible = false
integer x = 1682
integer y = 464
integer width = 425
integer height = 248
string dataobject = "dw_valetransp"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event constructor;If wf_conecta_banco() Then
	This.SetTransObject(gtr_rh)
End If
end event

type cb_2 from commandbutton within w_rateio_sqlserver
integer x = 1344
integer y = 12
integer width = 393
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Salvar"
end type

event clicked;If dw_2.rowcount() <= 0 Then Return

long lvl_linha_dw2, lvl_linha_dw3, lvl_Filial_De, lvl_Filial_Para

dwitemstatus ldw_status

string lvs_localiza_dw2, lvs_localiza_dw3, lvs_regional

Decimal 	lvdc_Total_Proventos, &
			lvdc_Total_Encargos, &
			lvdc_Pat, &
			lvdc_Total_ValTrans

setpointer(hourglass!)

dw_2.accepttext()
dw_3.accepttext()
dw_3.SetRedraw(false)

lvdc_Total_Proventos = 0.00
lvdc_Total_Encargos	= 0.00
lvdc_Pat					= 0.00
lvdc_Total_ValTrans	= 0.00

for lvl_linha_dw2 = 1 to dw_2.rowcount()	
	ldw_status = dw_2.getitemstatus(lvl_linha_dw2, 0, primary!)
	
	if ldw_status <> newmodified! and ldw_status <> datamodified! then
		continue
	end if
	
	lvs_localiza_dw2 = "localiza='" + dw_2.object.localiza[lvl_linha_dw2] + "'"
	lvl_linha_dw3 = dw_3.find(lvs_localiza_dw2, 1, dw_3.rowcount())

	if dw_2.object.marca[lvl_linha_dw2] = 'S' then
		
		if lvl_linha_dw3 < 1 then
			lvl_linha_dw3 = dw_3.insertrow(0)
		end if
	
		dw_3.object.nr_folha[lvl_linha_dw3] 					= ivl_numfolha
		dw_3.object.cd_tipo_colaborador[lvl_linha_dw3] 	= dw_2.object.tipcol[lvl_linha_dw2]
		dw_3.object.nr_matricula[lvl_linha_dw3] 			= dw_2.object.numcad[lvl_linha_dw2]
		dw_3.object.nm_colaborador[lvl_linha_dw3] 		= dw_2.object.nomfun[lvl_linha_dw2]
		dw_3.object.cd_filial_de[lvl_linha_dw3] 				= dw_2.object.filctb[lvl_linha_dw2]
		//dw_3.object.cd_filial_de[lvl_linha_dw3] 			= lvl_Filial_De
		dw_3.object.nm_filial_de[lvl_linha_dw3] 			= dw_2.object.nomfil[lvl_linha_dw2]
		dw_3.object.cd_filial_para[lvl_linha_dw3] 			= dw_2.object.codrat[lvl_linha_dw2]
		//dw_3.object.cd_filial_para[lvl_linha_dw3] 			= lvl_Filial_Para
		dw_3.object.nm_filial_para[lvl_linha_dw3] 			= dw_2.object.filnom[lvl_linha_dw2]
		
		lvdc_Total_Proventos = dw_2.object.total_proventos[lvl_linha_dw2]
		If IsNull(lvdc_Total_Proventos) Then lvdc_Total_Proventos = 0.00		
		dw_3.object.vl_total_proventos[lvl_linha_dw3] 	= lvdc_Total_Proventos
		
		lvdc_Total_Encargos = dw_2.object.encargos[lvl_linha_dw2]
		If IsNull(lvdc_Total_Encargos) Then lvdc_Total_Encargos = 0.00
		dw_3.object.vl_encargos[lvl_linha_dw3] 	= lvdc_Total_Encargos		
		
		lvdc_Pat	= dw_2.object.pat[lvl_linha_dw2]		
		If IsNull(lvdc_Pat) Then lvdc_Pat = 0.00
		dw_3.object.vl_pat[lvl_linha_dw3] = lvdc_Pat
		
		lvdc_Total_ValTrans = dw_2.object.valetransp[lvl_linha_dw2]
		If IsNull(lvdc_Total_ValTrans) Then lvdc_Total_ValTrans = 0.00		
		dw_3.object.vl_valetransp[lvl_linha_dw3] = lvdc_Total_ValTrans
		
		dw_3.object.id_adm[lvl_linha_dw3] 					= dw_2.object.id_adm[lvl_linha_dw2]
		dw_3.object.localiza[lvl_linha_dw3] 					= dw_2.object.localiza[lvl_linha_dw2]
		
		dw_3.object.nm_regional[lvl_linha_dw3] = wf_pega_regional(dw_2.object.filctb[lvl_linha_dw2])

	else	
		if lvl_linha_dw3 >= 1 then
			dw_3.deleterow(lvl_linha_dw3)
		end if			
	end if	
next

dw_3.update()
dw_3.sort()
dw_3.SetRedraw(true)

setpointer(arrow!)
end event

type cb_1 from commandbutton within w_rateio_sqlserver
integer x = 933
integer y = 12
integer width = 393
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Carregar"
end type

event clicked;long lvl_linha

setpointer(hourglass!)

ivl_numfolha = integer(em_1.text)

if isnull(ivl_numfolha) or ivl_numfolha = 0 then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar o c$$HEX1$$f300$$ENDHEX$$digo da folha", Information!)
	em_1.setfocus()
	return
end if

If wf_Recupera_Inf_Vetor(ivl_numfolha) Then	
	If Not wf_insere_inf_vetor(ivl_numfolha) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "N$$HEX1$$e300$$ENDHEX$$o foram encontrados rateios para esta folha", Exclamation!)
		em_1.setfocus()
		Return
	End If	
End If

lvl_linha = dw_3.Retrieve(ivl_numfolha)

dw_2.ResetUpdate()

cb_2.enabled = true
this.enabled = false
em_1.enabled = false
tx_Nome.enabled = true
tx_Matricula.enabled = true

setpointer(arrow!)
end event

type dw_3 from datawindow within w_rateio_sqlserver
integer x = 46
integer y = 1424
integer width = 4453
integer height = 824
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_rateio_sybase"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean hsplitscroll = true
boolean livescroll = true
end type

event constructor;If Not wf_conecta_banco() Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao banco de dados do RH.~r~nA tela "'+Parent.Title+'" ser$$HEX1$$e100$$ENDHEX$$ encerrada!',StopSign!)
	Close(Parent)
	Return
Else
	This.SetTransObject(SQLCa)
End If
end event

event updateend;commit using SQLCa;
end event

event retrieverow;string lvs_localiza
long lvl_linha_dw2

setpointer(hourglass!)

lvs_localiza = string(this.object.cd_tipo_colaborador[row], "0") + string(this.object.nr_matricula[row], "000000000") + &
               string(this.object.cd_filial_para[row], "0000")
					
If this.object.nr_matricula[row] = 35881 Then
	this.object.nr_matricula[row] = 35881
End If

this.object.localiza[row] = lvs_localiza

lvs_localiza = "localiza='" + lvs_localiza + "'"
lvl_linha_dw2 = dw_2.find(lvs_localiza, 1, dw_2.rowcount())
if lvl_linha_dw2 < 1 then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do rateio", information!)
	return
end if

dw_2.object.marca[lvl_linha_dw2] = 'S'

setpointer(arrow!)
end event

event rbuttondown;if this.rowcount() > 0 then
	this.saveas("", excel!, true)
end if
end event

type dw_2 from datawindow within w_rateio_sqlserver
event ue_mousemove pbm_mousemove
integer x = 50
integer y = 220
integer width = 4448
integer height = 1104
integer taborder = 50
string dataobject = "dw_sumariza_procedure_sql"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_mousemove;If This.RowCount() > 0 Then
	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and &
		  ypos >= 0 and ypos < 40 Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event itemfocuschanged;if this.isselected(row) Then
	this.selectrow(row, false)
else
	this.selectrow(0, false)
	this.selectrow(row, true)
end if
end event

event clicked;// OverRide
If dwo.name = 'id_imagem' Then Return

if this.isselected(row) = true then
	this.selectrow(row, false)
else
	this.selectrow(0, false)
	this.selectrow(row, true)
end if
end event

event doubleclicked;String lvs_Incluir_Excluir,&
	   lvs_Marcacao

Integer lvi_Row
		  
If dwo.Name = "id_imagem" Then
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check 	 = False
		// Excluir
		lvs_Incluir_Excluir = "E"
	Else
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
		// Incluir
		lvs_Incluir_Excluir = "I"
	End If
	
	For lvi_Row = 1 To This.RowCount()
		This.Object.marca[lvi_Row] = lvs_Marcacao
	Next
	
End If


end event

type gb_2 from groupbox within w_rateio_sqlserver
integer x = 18
integer y = 144
integer width = 4503
integer height = 1204
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Rateios lidos do VetorRH"
borderstyle borderstyle = styleraised!
end type

