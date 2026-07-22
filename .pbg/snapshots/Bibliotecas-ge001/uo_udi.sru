HA$PBExportHeader$uo_udi.sru
forward
global type uo_udi from nonvisualobject
end type
type item_udi from structure within uo_udi
end type
end forward

type item_udi from structure
	string		id_item
	string		de_item
	string		vl_item
end type

global type uo_udi from nonvisualobject
end type
global uo_udi uo_udi

type variables
Date		idt_Producao, &
			idt_Validade

Long		il_Qt_Embalagem

String	is_GTIN, &
			is_Lote, &
			is_separador
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine _documentacao_ ()
public function boolean of_parse_udi (string as_cd_barra_udi)
end prototypes

public subroutine of_inicializa ();SetNull (idt_Producao)
SetNull (idt_Validade)
SetNull (il_Qt_Embalagem)
SetNull (is_GTIN)
SetNull (is_Lote)

Return
end subroutine

public subroutine _documentacao_ ();/*
+===================+==================================================+===================================+
| AI (Dois d$$HEX1$$ed00$$ENDHEX$$gitos) | Informa$$HEX2$$e700e300$$ENDHEX$$o conforme c$$HEX1$$f300$$ENDHEX$$digo AI                                                        |
+===================+==================================================+===================================+
| AI                | Significado                                      | Formato / Observa$$HEX2$$e700f500$$ENDHEX$$es             |
+===================+==================================================+===================================+
| 00                | SSCC $$HEX1$$1320$$ENDHEX$$ C$$HEX1$$f300$$ENDHEX$$digo de s$$HEX1$$e900$$ENDHEX$$rie de cont$$HEX1$$ea00$$ENDHEX$$iner de envio     | 18 d$$HEX1$$ed00$$ENDHEX$$gitos                        |
| 01                | GTIN do item (n$$HEX1$$ed00$$ENDHEX$$vel prim$$HEX1$$e100$$ENDHEX$$rio)                    | 14 d$$HEX1$$ed00$$ENDHEX$$gitos                        |
| 02                | GTIN da embalagem (n$$HEX1$$ed00$$ENDHEX$$vel secund$$HEX1$$e100$$ENDHEX$$rio)             | 14 d$$HEX1$$ed00$$ENDHEX$$gitos                        |
| 10                | N$$HEX1$$fa00$$ENDHEX$$mero do lote                                   | Alfanum$$HEX1$$e900$$ENDHEX$$rico, at$$HEX1$$e900$$ENDHEX$$ 20 caracteres   |
| 11                | Data de produ$$HEX2$$e700e300$$ENDHEX$$o                                 | AAMMDD (6 d$$HEX1$$ed00$$ENDHEX$$gitos)                |
| 13                | Data de embalagem                                | AAMMDD (6 d$$HEX1$$ed00$$ENDHEX$$gitos)                |
| 15                | Data de durabilidade m$$HEX1$$ed00$$ENDHEX$$nima                      | AAMMDD (6 d$$HEX1$$ed00$$ENDHEX$$gitos)                |
| 17                | Data de validade                                 | AAMMDD (6 d$$HEX1$$ed00$$ENDHEX$$gitos)                |
| 20                | Quantidade no pedido                             | 2 d$$HEX1$$ed00$$ENDHEX$$gitos                         |
| 21                | N$$HEX1$$fa00$$ENDHEX$$mero de s$$HEX1$$e900$$ENDHEX$$rie                                  | Alfanum$$HEX1$$e900$$ENDHEX$$rico, at$$HEX1$$e900$$ENDHEX$$ 20 caracteres   |
| 22                | Vers$$HEX1$$e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo de produto                      | Vari$$HEX1$$e100$$ENDHEX$$vel                          |
| 30                | Quantidade vari$$HEX1$$e100$$ENDHEX$$vel                              | Num$$HEX1$$e900$$ENDHEX$$rico, at$$HEX1$$e900$$ENDHEX$$ 8 d$$HEX1$$ed00$$ENDHEX$$gitos           |
| 37                | Quantidade em embalagem                          | Num$$HEX1$$e900$$ENDHEX$$rico, at$$HEX1$$e900$$ENDHEX$$ 8 d$$HEX1$$ed00$$ENDHEX$$gitos           |
| 7001              | N$$HEX1$$fa00$$ENDHEX$$mero global de devolu$$HEX2$$e700e300$$ENDHEX$$o de item (GRAI)        | 14 d$$HEX1$$ed00$$ENDHEX$$gitos                        |
| 7002              | N$$HEX1$$fa00$$ENDHEX$$mero de ativo reutiliz$$HEX1$$e100$$ENDHEX$$vel (GIAI)              | Alfanum$$HEX1$$e900$$ENDHEX$$rico                      |
| 8001              | Medi$$HEX2$$e700e300$$ENDHEX$$o de peso l$$HEX1$$ed00$$ENDHEX$$quido                          | Em kg com 6 decimais              |
| 8002              | N$$HEX1$$fa00$$ENDHEX$$mero serial de software ou outro identificador | Alfanum$$HEX1$$e900$$ENDHEX$$rico                      |
| 8018              | UDI-DI (para dispositivos m$$HEX1$$e900$$ENDHEX$$dicos $$HEX1$$1320$$ENDHEX$$ GTIN base)   | Normalmente igual ao GTIN         |
| 8019              | UDI-PI (informa$$HEX2$$e700f500$$ENDHEX$$es como lote, validade, etc.)   | Dados combinados                  |
| 91$$HEX1$$1320$$ENDHEX$$99             | AIs definidos pelo usu$$HEX1$$e100$$ENDHEX$$rio                       | Para uso interno ou personalizado |
+===================+==================================================+===================================+
*/
end subroutine

public function boolean of_parse_udi (string as_cd_barra_udi);/*
	Esta fun$$HEX2$$e700e300$$ENDHEX$$o considera que o separador, o caracter Ascii 29, vem apenas antes do AI (se o separador estiver presente)
*/
//DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean	lb_AI

Date		ldt_Aux

Integer	li_Pos,      &
			li_PosAIVar, &
			li_PosItem,  &
			li_PosSep,   &
			li_TamBarra, &
			li_TamAI,    &
			li_TamItem,  &
			li_Tem_Separador = 0	/* 0 = n$$HEX1$$e300$$ENDHEX$$o tem separador ; 1 = tem separador */

String	ls_Item,    &
			ls_Prox_AI, &
			ls_id_item	//AI (application identifier)
String	ls_Separador

//AIs de comprimento vari$$HEX1$$e100$$ENDHEX$$vel
String	ls_Id_AI_Variavel []
Integer	li_Tam_AI_Variavel [], &
			li_NumAIVar, li_QtdAIVar

ls_Id_AI_Variavel [1] = '10'; li_Tam_AI_Variavel [1] = 20;	//Lote
ls_Id_AI_Variavel [2] = '37'; li_Tam_AI_Variavel [2] =  8;	//Qtd na embalagem

li_QtdAIVar = UpperBound (ls_Id_AI_Variavel)

//PROCEDIMENTOS

If IsNull (as_cd_barra_udi) then
	Return False
End if

ls_Separador = Char (29)

If Left (as_cd_barra_udi, 1) = ls_Separador then
	li_Tem_Separador = 1
	is_Separador = 'COM SEPARADOR'
else
	is_Separador = 'SEM SEPARADOR'
End if

If Left (as_cd_barra_udi, 3) = '[C1' then as_cd_barra_udi = Mid (as_cd_barra_udi, 4)
li_TamBarra  = Len (as_cd_barra_udi)

For li_Pos = 1 to li_TamBarra
//	If li_Tem_Separador = 1 then
//		li_TamAI = Pos (as_cd_barra_udi, ls_SepFim, li_Pos) - 1 - li_Pos
//	else
		li_TamAI = 2
//	End if
	
	ls_id_item = Mid (as_cd_barra_udi, li_Pos + li_Tem_Separador, li_TamAI)
	
	Choose case ls_id_item
		case '01', '02'	//GTIN
			
			li_TamItem = 14
			
			If li_pos = 1 then
				ls_Item = Mid (as_cd_barra_udi, li_Pos + li_TamAI + li_Tem_Separador, li_TamItem)
				
				If not IsNull (ls_Item) then
					is_GTIN = ls_Item
					//Avan$$HEX1$$e700$$ENDHEX$$a para a posi$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo AI
					li_pos += li_TamAI + li_TamItem + li_Tem_Separador - 1 //AI + GTIN
					Continue
				else
					//GTIN n$$HEX1$$e300$$ENDHEX$$o informado
					Return False
				End if
			else
				//GTIN estaria na posi$$HEX2$$e700e300$$ENDHEX$$o errada
				Return False
			End if
			
		case '11', '17'	//DATA DE PRODU$$HEX2$$c700c300$$ENDHEX$$O, DATA DE VALIDADE
			
			li_TamItem = 6
			ls_Item    = Mid (as_cd_barra_udi, li_Pos + li_TamAI + li_Tem_Separador, li_TamItem)	//AAMMDD
			
			If not IsNull (ls_Item) and Len (ls_Item) = li_TamItem then
				If Right (ls_Item, 2) = '00' then	//quando o dia vier zerado
					ls_Item = Left (ls_Item, li_TamItem - 2) + '01'
				End if
				
				If IsDate (Right (ls_Item, 2) + '/' + Mid (ls_Item, 3, 2) + '/' + Left (ls_Item, 2)) then
					ldt_Aux = Date (Right (ls_Item, 2) + '/' + Mid (ls_Item, 3, 2) + '/' + Left (ls_Item, 2))
					Choose case ls_id_item
						case '11'
							idt_Producao = ldt_Aux
						case '17'
							If Day (ldt_Aux) > 1 then	//Validade sempre ser$$HEX1$$e100$$ENDHEX$$ no dia 1$$HEX1$$ba00$$ENDHEX$$
								ldt_Aux = Date (Year (ldt_Aux), Month (ldt_Aux), 1)
							End if
							idt_Validade = ldt_Aux
					End choose
					
					//Avan$$HEX1$$e700$$ENDHEX$$a para a posi$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo AI
					li_pos += li_TamAI + li_TamItem + li_Tem_Separador - 1 //AI + data
					Continue
				End if
			End if
			
		case else
			
			//Verifica se $$HEX1$$e900$$ENDHEX$$ um AI vari$$HEX1$$e100$$ENDHEX$$vel
			For li_NumAIVar = 1 to li_QtdAIVar
				If ls_Id_AI_Variavel [li_NumAIVar] = ls_id_item then
					li_TamItem = li_Tam_AI_Variavel [li_NumAIVar]
					ls_Item    = Mid (as_cd_barra_udi, li_Pos + li_TamAI + li_Tem_Separador, li_TamItem)
					
					If li_Tem_Separador = 1 then
						li_PosSep  = Pos (ls_Item, ls_Separador)
						
						If li_PosSep > 0 then
							ls_Item = Left (ls_Item, li_PosSep - 1)
						End if
					End if
					
					li_TamItem = Len (ls_Item)
					
					//Se n$$HEX1$$e300$$ENDHEX$$o tiver separador, verifica se h$$HEX1$$e100$$ENDHEX$$ outro AI vari$$HEX1$$e100$$ENDHEX$$vel embutido no item, mas somente se
					//houver caracteres suficientes para conter o conte$$HEX1$$fa00$$ENDHEX$$do deste mais o outro AI e seu conte$$HEX1$$fa00$$ENDHEX$$do
					If li_Tem_Separador = 0 then
						
						If li_TamItem > 1 + li_TamAI then	//1 seria o tam. m$$HEX1$$ed00$$ENDHEX$$nimo do AI atual
							For li_PosItem = 1 to li_TamItem
								
								ls_Prox_AI = Mid (ls_Item, li_PosItem, li_TamAI)
								lb_AI      = false
								
								For li_PosAIVar = 1 to li_QtdAIVar
									If ls_Prox_AI = ls_Id_AI_Variavel [li_PosAIVar] and ls_Prox_AI <> ls_id_item then
										lb_AI = True
										Exit
									End if
								Next
								
								If lb_AI then
									//Se outro AI vari$$HEX1$$e100$$ENDHEX$$vel for encontrado dentro no conte$$HEX1$$fa00$$ENDHEX$$do do AI vari$$HEX1$$e100$$ENDHEX$$vel j$$HEX1$$e100$$ENDHEX$$ obtido,
									//todo o conte$$HEX1$$fa00$$ENDHEX$$do destes e dos pr$$HEX1$$f300$$ENDHEX$$ximos AIs ser$$HEX1$$e100$$ENDHEX$$ ignorado, evitando o retorno de
									//informa$$HEX2$$e700f500$$ENDHEX$$es incorretas
									SetNull (ls_Item)
									li_TamItem = li_TamBarra	//For$$HEX1$$e700$$ENDHEX$$a o fim do loop de varredura do UDI
									
//									ls_Item = Left (ls_Item, li_PosItem - 1)
//									li_TamItem = Len (ls_Item)
									Exit
								End if
							Next
						End if
					End if
					
					Choose case ls_id_item
						case '10'	//lote
							is_lote = ls_Item
							
						case '37'	//qtd na embalagem
							il_qt_embalagem = Long (ls_Item)
					End choose
					
					Exit
				End if
			Next
			
			li_pos += li_TamAI + li_TamItem + li_Tem_Separador - 1 //AI + data
			
	End choose
Next

Return True
end function

on uo_udi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_udi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_inicializa ()
end event

