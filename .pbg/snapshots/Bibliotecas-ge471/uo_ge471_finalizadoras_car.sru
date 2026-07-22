HA$PBExportHeader$uo_ge471_finalizadoras_car.sru
forward
global type uo_ge471_finalizadoras_car from nonvisualobject
end type
end forward

global type uo_ge471_finalizadoras_car from nonvisualobject
end type
global uo_ge471_finalizadoras_car uo_ge471_finalizadoras_car

type variables
String Cd_Finalizadora
String Ds_Finalizadora
String Tipo_Finalizadora

Boolean Localizado

Protected:
String ivs_Campos_Obrig[]
String ivs_Campos_Alerta[]
String ivs_Campos_Vazio[]
end variables

forward prototypes
public function boolean of_carrega_campos_validacao (string ps_cdfin)
public function boolean of_localiza (string ps_cdfin)
public subroutine of_inicializa ()
public function boolean of_coluna_obrigatoria (string ps_coluna)
public function boolean of_coluna_vazia (string ps_coluna)
public function boolean of_coluna_alerta (string ps_coluna)
public function string of_retorna_nome_campo (string ps_campo)
end prototypes

public function boolean of_carrega_campos_validacao (string ps_cdfin);Try
	Choose Case Tipo_Finalizadora
		Case "DI" 			//Dinheiro
			ivs_Campos_Obrig		= {"vlrec","cdfin","pcela","zterm"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"bnknu","agnnu","connu","chqnu","chqna","ccmc7", "nsuid","cdaut","pctax","taxad","cardn","nroad","redad","banad","nucov","nacov","mcvdo","ncvdo","nrzae","nrautcd","rbank"}
					
		Case "HP","HA" 	//Cheque a Prazo e Cheque a Vista
			ivs_Campos_Obrig		= {"vlrec","cdfin","pcela","zterm","stcd1","bnknu","agnnu","connu","chqnu","chqna","ccmc7"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		=	{"nsuid","cdaut","pctax","taxad","cardn","nroad","redad","banad","nucov","nacov","mcvdo", "ncvdo","nrzae","nrautcd","rbank"}
			
		Case "CP", "CA"	//Cart$$HEX1$$e300$$ENDHEX$$o a Prazo e Cart$$HEX1$$e300$$ENDHEX$$o a Vista
			ivs_Campos_Obrig		= {"vlrec","cdfin","pcela","zterm","nsuid","cdaut","redad","banad"}
			ivs_Campos_Alerta	= {"taxad"}
			ivs_Campos_Vazio		= {"bnknu","agnnu","connu","chqnu","chqna","ccmc7","nucov","nacov","mcvdo", "ncvdo","nrzae","rbank"}
		
		Case "CD"	//Carteira Digital
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","nsuid","obspg"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"cardn","bnknu","agnnu","connu","chqnu","chqna","ccmc7","nucov","nacov","mcvdo", "ncvdo","nrzae","nrautcd","rbank"}
			
		Case "DL"	//Delivery
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","nsuid","obspg","nrzae","redad","nsuid"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"cardn","bnknu","agnnu","connu","chqnu","chqna","ccmc7","nucov","nacov","mcvdo", "ncvdo","nrautcd","rbank"}
			
		Case "EC"	//Ecommerce
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","nsuid","obspg","nrzae","redad","nsuid"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"cardn","bnknu","agnnu","connu","chqnu","chqna","ccmc7","nucov","nacov","mcvdo", "ncvdo","nrautcd","rbank"}
			
		Case "VO"	//Voucher
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","obspg"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"cardn","bnknu","agnnu","connu","chqnu","chqna","ccmc7","nucov","nacov","mcvdo", "ncvdo","nrautcd","rbank"}
			
		Case "PX"	//PIX
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","obspg","nrautcd","rbank"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"cardn","bnknu","agnnu","connu","chqnu","chqna","ccmc7","nucov","nacov","mcvdo", "ncvdo","nrzae"}
			
		Case "CV"	//Conv$$HEX1$$ea00$$ENDHEX$$nio
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","stcd1","dtpag","nucov","obspg"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"bnknu","agnnu","connu","chqnu","chqna","ccmc7", "nsuid","cdaut","pctax","taxad","cardn","nroad","redad","banad","nrzae","nrautcd","rbank"}

		Case "BL" 	//Boleto
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","stcd1","dtpag","obspg"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"bnknu","agnnu","connu","chqnu","chqna","ccmc7","nsuid","cdaut","pctax","taxad","cardn","nroad","redad","banad","nucov","nacov","mcvdo","ncvdo","nrzae","nrautcd","rbank"}
	
		Case "CR" 	//Credi$$HEX1$$e100$$ENDHEX$$rio
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","stcd1","dtpag","obspg","xref3"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"bnknu","agnnu","connu","chqnu","chqna","ccmc7","nsuid","cdaut","pctax","taxad","cardn","nroad","redad","banad","nucov","nacov","mcvdo","ncvdo","nrzae","nrautcd","rbank"}
	
		Case "CC"	//Conta Corrente
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","stcd1","dtpag","obspg"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"bnknu","agnnu","connu","chqnu","chqna","ccmc7", "nsuid","cdaut","pctax","taxad","cardn","nroad","redad","banad","nucov","nacov","mcvdo","ncvdo","nrzae","nrautcd","rbank"}
		
		Case "PA"	//Pagamento Antecipado
			ivs_Campos_Obrig 	= {"vlrec","cdfin","pcela","zterm","nsuid","obspg","nrzae","redad","nsuid"}
			ivs_Campos_Alerta	= {""}
			ivs_Campos_Vazio		= {"cardn","bnknu","agnnu","connu","chqnu","chqna","ccmc7","nucov","nacov","mcvdo", "ncvdo","nrautcd","rbank"}
			
	End Choose
	
Catch (RuntimeError lvo_Erro)
	If Not gvb_Auto Then
		MessageBox("Erro",lvo_Erro.GetMessage(), StopSign!)
	Else
		gvo_aplicacao.Of_Grava_Log(lvo_Erro.GetMessage())
	End If
	
	Return False

Finally
	//	
End Try

Return True
end function

public function boolean of_localiza (string ps_cdfin);If trim(gf_coalesce(ps_cdfin, ""))="" Then Return False
	
Select cdfin, dsfin, tpfin
Into :Cd_Finalizadora, :Ds_Finalizadora, :Tipo_Finalizadora
From hubcfrm
where cdfin = :ps_cdfin
Using SQLCa;

Localizado = (SQLCa.SQLCode = 0)

If SQLCa.SQLCode = -1 Then
	If Not gvb_Auto Then
		MessageBox("Falha", "Falha ao localizar a finalizadora na tabela HUBCFRM.~r~r"+SQLCa.SQLErrText)
	Else
		gvo_Aplicacao.Of_Grava_Log("Falha ao localizar a finalizadora na tabela HUBCFRM.~r~r"+SQLCa.SQLErrText)
	End If
End If

If Not Localizado Then
	This.Of_Inicializa()
Else
	This.Of_Carrega_Campos_Validacao(Cd_Finalizadora)
End If

Return Localizado
end function

public subroutine of_inicializa ();Cd_Finalizadora		= ""
Ds_Finalizadora		= ""
Tipo_Finalizadora		= ""
ivs_Campos_Obrig		= {""}
ivs_Campos_Alerta	= {""}
ivs_Campos_Vazio		= {""}

Localizado = False
end subroutine

public function boolean of_coluna_obrigatoria (string ps_coluna);Boolean lvb_Obrigatoria=False
Long lvl_Campo

For lvl_Campo=1 To UpperBound(ivs_Campos_Obrig)
	If Lower(ps_coluna)=Lower(ivs_Campos_Obrig[lvl_Campo]) Then
		lvb_Obrigatoria = True
		Exit
	End if 
Next

Return lvb_Obrigatoria
end function

public function boolean of_coluna_vazia (string ps_coluna);Boolean lvb_Vazio=False
Long lvl_Campo

For lvl_Campo=1 To UpperBound(ivs_Campos_Vazio)
	If Lower(ps_coluna)=Lower(ivs_Campos_Vazio[lvl_Campo]) Then
		lvb_Vazio = True
		Exit
	End if 
Next

Return lvb_Vazio
end function

public function boolean of_coluna_alerta (string ps_coluna);Boolean lvb_Alerta=False
Long lvl_Campo

For lvl_Campo=1 To UpperBound(ivs_Campos_Alerta)
	If Lower(ps_coluna)=Lower(ivs_Campos_Alerta[lvl_Campo]) Then
		lvb_Alerta = True
		Exit
	End if 
Next

Return lvb_Alerta
end function

public function string of_retorna_nome_campo (string ps_campo);String lvs_Retorno

Choose Case ps_campo
	Case "mandt" 	; lvs_Retorno = "Mandante"
	Case "werks" 	; lvs_Retorno = "Filial"
	Case "cdsis" 	; lvs_Retorno = "C$$HEX1$$f300$$ENDHEX$$digo Sistema"
	Case "nupdv"	; lvs_Retorno = "N$$HEX1$$fa00$$ENDHEX$$mero PDV"
	Case "tpopr"	; lvs_Retorno = "Tipo Opera$$HEX2$$e700e300$$ENDHEX$$o"
	Case "mvend"	; lvs_Retorno = "Meio de Venda"
	Case "dtopr"	; lvs_Retorno = "Data Opera$$HEX2$$e700e300$$ENDHEX$$o"
	Case "ntran"	; lvs_Retorno = "Transa$$HEX2$$e700e300$$ENDHEX$$o"
	Case "serie"		; lvs_Retorno = "S$$HEX1$$e900$$ENDHEX$$rie"
	Case "seqnu"	; lvs_Retorno = "Sequencial Opera$$HEX2$$e700e300$$ENDHEX$$o"
	Case "finnu"		; lvs_Retorno = "Sequencial Finalizadora"
	Case "cdfin"		; lvs_Retorno = "C$$HEX1$$f300$$ENDHEX$$digo Finalizadora"
	Case "pcela"	; lvs_Retorno = "N$$HEX1$$ba00$$ENDHEX$$ Parcelas"
	Case "qtdia"		; lvs_Retorno = "Qtde Dias"
	Case "zterm"	; lvs_Retorno = "Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento"
	Case "vlrec"		; lvs_Retorno = "Valor Finalizadora"
	Case "vltro"		; lvs_Retorno = "Valor Troco"
	Case "bnknu"	; lvs_Retorno = "Banco"
	Case "agnnu"	; lvs_Retorno = "Ag$$HEX1$$ea00$$ENDHEX$$ncia"
	Case "connu"	; lvs_Retorno = "N$$HEX1$$ba00$$ENDHEX$$ Conta"
	Case "chqnu"	; lvs_Retorno = "N$$HEX1$$ba00$$ENDHEX$$ Cheque"
	Case "chqna"	; lvs_Retorno = "Nome Cliente Cheque"
	Case "ccmc7"	; lvs_Retorno = "CMC7"
	Case "refbn"	; lvs_Retorno = "Refer. Banc$$HEX1$$e100$$ENDHEX$$ria"
	Case "refbl"		; lvs_Retorno = "Refer. Boleto"
	Case "kunnr"	; lvs_Retorno = "Cliente SAP"
	Case "stcd1"	; lvs_Retorno = "CNPJ"
	Case "stcd2"	; lvs_Retorno = "CPF"
	Case "stcd3"	; lvs_Retorno = "I.E."
	Case "cardn"	; lvs_Retorno = "N$$HEX1$$ba00$$ENDHEX$$ Cart$$HEX1$$e300$$ENDHEX$$o"
	Case "nsuid"	; lvs_Retorno = "NSU"
	Case "cdaut"	; lvs_Retorno = "Cod. Autoriza$$HEX2$$e700e300$$ENDHEX$$o"
	Case "dtpag"	; lvs_Retorno = "Data Pagamento"
	Case "hrpag"	; lvs_Retorno = "Hora Pagamento"
	Case "obspg"	; lvs_Retorno = "Observ. Pagamento"
	Case "nroad"	; lvs_Retorno = "N$$HEX1$$ba00$$ENDHEX$$ Administradora SAP"
	Case "taxad"	; lvs_Retorno = "Valor Taxa Cart$$HEX1$$e300$$ENDHEX$$o"
	Case "redad"	; lvs_Retorno = "Rede Cart$$HEX1$$e300$$ENDHEX$$o"
	Case "banad"	; lvs_Retorno = "Bandeira Cart$$HEX1$$e300$$ENDHEX$$o"
	Case "nucov"	; lvs_Retorno = "C$$HEX1$$f300$$ENDHEX$$d. Conv$$HEX1$$ea00$$ENDHEX$$nio"
	Case "nacov"	; lvs_Retorno = "Nome Conv$$HEX1$$ea00$$ENDHEX$$nio"
	Case "mcvdo"	; lvs_Retorno = "C$$HEX1$$f300$$ENDHEX$$d. Conveniado"
	Case "ncvdo"	; lvs_Retorno = "Nome Conveniado"
	Case "nrzae"	; lvs_Retorno = "Raz$$HEX1$$e300$$ENDHEX$$o Especial"
	Case "xref3"		; lvs_Retorno = "Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 3"
	Case "rbank"	; lvs_Retorno = "Cliente PIX"
	Case "nrautcd"	; lvs_Retorno = "N$$HEX1$$ba00$$ENDHEX$$ Autoriz. Carteira Digital"
	Case "dtaut"		; lvs_Retorno = "Data Autoriza$$HEX2$$e700e300$$ENDHEX$$o"
	Case "pctax"	; lvs_Retorno = "% Taxa Cart$$HEX1$$e300$$ENDHEX$$o"
		
	Case Else  ; lvs_Retorno = ps_campo
End Choose

Return lvs_Retorno
end function

on uo_ge471_finalizadoras_car.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge471_finalizadoras_car.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

