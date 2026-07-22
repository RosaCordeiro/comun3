HA$PBExportHeader$uo_ge220_tributacao_produto.sru
forward
global type uo_ge220_tributacao_produto from nonvisualobject
end type
end forward

global type uo_ge220_tributacao_produto from nonvisualobject
end type
global uo_ge220_tributacao_produto uo_ge220_tributacao_produto

type variables
Boolean Localizado

Long Cd_Tributacao_Produto
Long Cd_Filial
Long Ncm_Inicial
Long Ncm_Final

String De_Tributacao_Produto
String Uf
String Lista_Pis_Cofins
String Lei_Generico
String ivs_Parametro_Selecao

Decimal St_Estadual
Decimal St_InterEstadual


end variables

forward prototypes
public subroutine of_localiza_tributacao_produto (string ps_parametro)
public subroutine of_inicializa ()
public function boolean of_localiza_generica (string ps_parametro, string ps_uf, long pl_trib_antiga, long pl_ncm)
public function boolean of_localiza_generica (string ps_parametro, string ps_uf, long pl_trib_antiga, long pl_ncm, string ps_lista_pis_cofins, string ps_lei_generico)
public function boolean of_localiza_generica (string ps_parametro, string ps_uf, long pl_trib_antiga)
public function boolean of_localiza_generica (string ps_parametro, string ps_uf)
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza_codigo (long pl_cd_tributacao_produto)
end prototypes

public subroutine of_localiza_tributacao_produto (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome da cidade
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_inicializa ();Long	ll_Nulo

Setnull(ll_Nulo)

Cd_Tributacao_Produto 	= ll_Nulo
Cd_Filial						= ll_Nulo
Ncm_Inicial					= ll_Nulo
Ncm_Final					= ll_Nulo
De_Tributacao_Produto 	= ""
Uf 								= ""

St_Estadual					= 0.0000
St_InterEstadual			= 0.0000
end subroutine

public function boolean of_localiza_generica (string ps_parametro, string ps_uf, long pl_trib_antiga, long pl_ncm);Return This.Of_Localiza_Generica(ps_parametro,ps_uf,pl_trib_antiga,pl_ncm,'','')
end function

public function boolean of_localiza_generica (string ps_parametro, string ps_uf, long pl_trib_antiga, long pl_ncm, string ps_lista_pis_cofins, string ps_lei_generico);String lvs_Tributacao
String lvs_Filtro
String lvs_Trib
String lvs_NCM

lvs_Filtro = ps_Parametro

If IsNull (ps_UF) Then ps_UF = ''

If IsNull(pl_trib_antiga) Then
	lvs_Trib = ''
Else
	lvs_Trib = String(pl_trib_antiga)
End If

If IsNull(pl_ncm) Then
	lvs_NCM = ''
Else
	lvs_NCM = String(pl_ncm)
End If

lvs_Filtro = ps_UF + ';' + ps_Parametro + ';'+lvs_Trib+';'+lvs_NCM+';'+ps_lista_pis_cofins+';'+ps_lei_generico

This.ivs_Parametro_Selecao = lvs_Filtro

OpenWithParm(w_ge220_selecao_tributa_farmaceuticos, lvs_Filtro)

lvs_Tributacao = Message.StringParm

If IsNull(lvs_Tributacao) Then
	Localizado = False
Else
	of_Localiza_Codigo(Long(lvs_Tributacao))
End If

Return This.Localizado
end function

public function boolean of_localiza_generica (string ps_parametro, string ps_uf, long pl_trib_antiga);Long lvl_NCM

SetNull(lvl_NCM)

Return This.Of_Localiza_Generica(ps_parametro, ps_uf, pl_trib_antiga, lvl_NCM)
end function

public function boolean of_localiza_generica (string ps_parametro, string ps_uf);Long lvl_Nulo

SetNull(lvl_Nulo)

Return This.of_localiza_generica(ps_parametro,ps_uf,lvl_Nulo)
end function

public function boolean of_localiza_generica (string ps_parametro);Return This.of_localiza_generica(ps_Parametro, '')
end function

public function boolean of_localiza_codigo (long pl_cd_tributacao_produto);  SELECT cd_tributacao_produto,   
         	 de_tributacao_produto,   
          	 pc_st_estadual,
          	 pc_st_interestadual,
			 cd_unidade_federacao,
         	 cd_ncm_inicial,
			 cd_ncm_final,
			 id_situacao_pis_cofins,
			 id_lei_generico
	  Into 	 :Cd_Tributacao_Produto,
	  		 :De_Tributacao_Produto,
			  :St_Estadual,
			  :St_InterEstadual,
			  :Uf,
			  :Ncm_Inicial,
			  :Ncm_Final,
			  :Lista_Pis_Cofins,
			  :Lei_Generico				  
    FROM tributa_produtos_farmaceuticos
where cd_tributacao_produto = :pl_cd_tributacao_produto
Using Sqlca; 

Choose Case SqlCa.SqlCode
		
	Case  100
		Localizado = False
	Case 0
		Localizado = True
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da Tributa$$HEX2$$e700e300$$ENDHEX$$o Produto: " + &
	            SqlCa.SqlErrText + ".",StopSign!,Ok!)
					
		Localizado = False
End Choose

Return Localizado
end function

on uo_ge220_tributacao_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge220_tributacao_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

