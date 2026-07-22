HA$PBExportHeader$w_ge067_cadastro_banco.srw
forward
global type w_ge067_cadastro_banco from dc_w_cadastro_lista
end type
end forward

global type w_ge067_cadastro_banco from dc_w_cadastro_lista
int Width=1765
int Height=1820
boolean TitleBar=true
string Title="GE067 - Cadastro de Bancos"
boolean Resizable=false
end type
global w_ge067_cadastro_banco w_ge067_cadastro_banco

on w_ge067_cadastro_banco.create
call super::create
end on

on w_ge067_cadastro_banco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge067_cadastro_banco
int X=55
int Y=48
int Width=1623
int Height=1560
boolean BringToTop=true
string DataObject="dw_ge067_lista_banco"
boolean LiveScroll=false
end type

event dw_1::constructor;call super::constructor;String lvs_Colunas[],&
       lvs_Nomes  []
		 
lvs_Colunas = { 'cd_banco','nm_banco' }
lvs_Nomes   = { 'C$$HEX1$$f300$$ENDHEX$$digo ' ,'Banco'    }

This.of_SetSort(lvs_Colunas,lvs_Nomes)
This.of_SetFilter(lvs_Colunas,lvs_Nomes)
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge067_cadastro_banco
int X=18
int Y=0
int Width=1701
int Height=1624
end type

