HA$PBExportHeader$uo_ge147_csv_import.sru
forward
global type uo_ge147_csv_import from nonvisualobject
end type
end forward

global type uo_ge147_csv_import from nonvisualobject autoinstantiate
end type

type variables																																																																																																																					 
end variables

forward prototypes
public function integer of_importfile (string as_filename, datawindow adw_datawindow)
public function string of_csv_to_tab (readonly string as_csv)
public function integer of_importcsvstring (readonly string as_importstring, datastore as_ds)
public function integer of_importcsvstring (readonly string as_importstring, datawindow as_dw)
public function integer of_importfile (string as_filename, datastore ads_datastore)
end prototypes

public function integer of_importfile (string as_filename, datawindow adw_datawindow);//of_ImportFile( filename, datawindow )
int li_fnum 
long ll_bytes
string ls_Line

li_fnum = FileOpen( as_FileName )

do
	ll_bytes = FileRead(li_fnum, ls_Line )
	if ll_bytes > 0 then this.of_ImportcsvString( ls_line, adw_datawindow )

loop while ll_bytes > 0 
FileClose( li_fnum )


return 1
end function

public function string of_csv_to_tab (readonly string as_csv);//of_csv_to_tab

string ls_import, ls_token
long ll_tokenlen, ll_findChar, ll_currentpos
character lc_quote = ';'

ll_currentpos = 1
if ( mid(as_csv, ll_currentpos, 1) = '"') then
	ll_findChar = pos(as_csv, '"', ll_currentpos + 1 ) //find as "
	ll_findChar = pos(as_csv, ';', ll_findChar )  //Vai ate o  (;)
	if ll_findChar <= 0 then 
		lc_quote = ','
		ll_findChar = pos(as_csv, lc_quote, ll_findChar )  //Vai ate (,)
	end if
else
	ll_findChar = pos(as_csv, ';', ll_currentpos )
	if ll_findChar <= 0 then 
		lc_quote = ','
		ll_findChar = pos(as_csv, lc_quote, ll_currentpos )
	end if
end if

do while ll_findChar > 0 
	
	ll_tokenlen = ll_findChar - ll_currentpos 
	ls_token = mid( as_csv, ll_currentpos, ll_tokenlen )
	if ls_import = "" then 
		ls_import = ls_token
	else
		ls_import += "~t" + ls_token
	end if
	
	
	ll_currentpos = ll_findChar + 1
	
	ll_findChar = pos(as_csv, lc_quote, ll_currentpos )
	if ( mid(as_csv, ll_currentpos, 1) = '"') then  //busca a "
		ll_findChar = pos(as_csv, '"', ll_currentpos + 1 ) //Pega a primeira "
		do while mid(as_csv, ll_findChar, 2) = '""' 
			//Verifca se " duplas
			ll_findChar = pos(as_csv, '"', ll_findChar+2 ) //Pega a " dupla
		loop
		ll_findChar = pos(as_csv, lc_quote, ll_findChar )
	end if
	
	
loop

//Ultimo campo
ll_tokenlen = len( as_csv ) + 1 - ll_currentpos
ls_token = mid( as_csv, ll_currentpos, ll_tokenlen )
ls_import += "~t" + ls_token

return ls_import
end function

public function integer of_importcsvstring (readonly string as_importstring, datastore as_ds);//of_ImportcsvString( importstring, datastore )
string ls_Import

ls_Import = of_csv_to_tab( as_ImportString )
as_ds.importstring( ls_import )

return 0
end function

public function integer of_importcsvstring (readonly string as_importstring, datawindow as_dw);//of_ImportcsvString
string ls_Import

ls_Import = of_csv_to_tab( as_ImportString )
as_dw.importstring( ls_import )

return 0
end function

public function integer of_importfile (string as_filename, datastore ads_datastore);//of_ImportFile( filename, datastore )
int li_fnum 
long ll_bytes
string ls_Line

li_fnum = FileOpen( as_FileName )

do
	ll_bytes = FileRead(li_fnum, ls_Line )
	if ll_bytes > 0 then this.of_ImportcsvString( ls_line, ads_datastore )

loop while ll_bytes > 0 
FileClose( li_fnum )


return 1
end function

on uo_ge147_csv_import.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge147_csv_import.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

