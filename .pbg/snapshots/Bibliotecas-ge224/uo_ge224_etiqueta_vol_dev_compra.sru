HA$PBExportHeader$uo_ge224_etiqueta_vol_dev_compra.sru
forward
global type uo_ge224_etiqueta_vol_dev_compra from nonvisualobject
end type
end forward

global type uo_ge224_etiqueta_vol_dev_compra from nonvisualobject
end type
global uo_ge224_etiqueta_vol_dev_compra uo_ge224_etiqueta_vol_dev_compra

forward prototypes
private function boolean of_imprime_etiquetas (string as_fornecedor, string as_nfe, string as_nfo, long al_volumes)
public function boolean of_emite_etiqueta (long al_nfe, string as_serie, string as_especie, long al_volumes)
public function boolean of_emite_etiqueta (long al_nfe, long al_volumes)
end prototypes

private function boolean of_imprime_etiquetas (string as_fornecedor, string as_nfe, string as_nfo, long al_volumes);
dc_uo_ds_base lds_Etiquetas

Long ll_Linha

Try
	lds_Etiquetas	= Create dc_uo_ds_base

	
	If Not lds_Etiquetas.of_ChangeDataObject("ds_ge224_etiqueta_dev_compra") Then
		Return False
	End If
	
	For ll_Linha = 1 to al_Volumes
		lds_Etiquetas.Object.de_fornecedor		[ll_Linha] = as_Fornecedor
		lds_Etiquetas.Object.de_nfe					[ll_Linha] = as_Nfe
		lds_Etiquetas.Object.de_nfo					[ll_Linha] = as_Nfo
		lds_Etiquetas.Object.nr_volume			[ll_Linha] = ll_Linha
		lds_Etiquetas.Object.nr_total_volumes	[ll_Linha] = al_Volumes
		lds_Etiquetas.Object.dh_impressao		[ll_Linha] = Date(gf_GetServerDate())
	Next
	
	lds_Etiquetas.Print()
	
Finally
	Destroy(lds_Etiquetas)
End Try
	
end function

public function boolean of_emite_etiqueta (long al_nfe, string as_serie, string as_especie, long al_volumes);String 	ls_Especie,&
			ls_Serie,&
			ls_Nome_Fornecedor,&
			ls_Notas_Origem = ""
			
Long	ll_Filial = 534,&
		ll_Linha,&
		ll_Linhas
			
uo_Parametro_Geral lo_Parametro
dc_uo_ds_base lds_Notas_Origem

Try
	lo_Parametro		=  Create uo_Parametro_Geral
	lds_Notas_Origem	= Create dc_uo_ds_base
	
	If IsNull(as_especie) then
		If Not lo_Parametro.of_Especie_NF(Ref ls_Especie) Then
			Return False
		End If
	Else
		ls_Especie = as_especie
	End If
	
	if IsNull(as_serie) then
		If Not lo_Parametro.of_Serie_NF(Ref ls_serie) Then
			Return False
		End If
	else
		ls_serie	= as_serie
	End If
	
	If Not lds_Notas_Origem.of_ChangeDataObject("ds_ge224_notas_origem") Then
		Return False
	End If
	
	ll_Linhas = lds_Notas_Origem.Retrieve(ll_Filial, al_Nfe, ls_Especie, ls_serie)
	
	If ll_Linhas > 0 Then
		ls_Nome_Fornecedor = lds_Notas_Origem.Object.nm_fantasia[1]
		
		For ll_Linha = 1 To ll_Linhas
			If ls_Notas_Origem = "" Then
				ls_Notas_Origem = String(lds_Notas_Origem.Object.nr_nf[ll_Linha])
			Else
				ls_Notas_Origem = ls_Notas_Origem +" "+String(lds_Notas_Origem.Object.nr_nf[ll_Linha])
			End If
		Next
		
	  
		If Not This.of_Imprime_Etiquetas(ls_Nome_Fornecedor, String(al_Nfe), ls_Notas_Origem, al_Volumes)  Then
			Return False
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nota de compra.")
	End If
	
Finally
	Destroy(lo_Parametro)
	Destroy(lds_Notas_Origem)
End Try

Return True
end function

public function boolean of_emite_etiqueta (long al_nfe, long al_volumes);String	ls_null

SetNull(ls_null)

Return This.of_emite_etiqueta(al_nfe, ls_null, ls_null, al_volumes)
end function

on uo_ge224_etiqueta_vol_dev_compra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge224_etiqueta_vol_dev_compra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

