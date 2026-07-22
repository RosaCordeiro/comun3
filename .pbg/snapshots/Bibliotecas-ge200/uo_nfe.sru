HA$PBExportHeader$uo_nfe.sru
forward
global type uo_nfe from userobject
end type
end forward

global type uo_nfe from userobject
integer width = 1015
integer height = 792
userobjects objecttype = externalvisual!
long backcolor = 67108864
string text = "none"
end type
global uo_nfe uo_nfe

forward prototypes
public function string of_getvaluetag (string ps_tag, integer ps_pos)
end prototypes

public function string of_getvaluetag (string ps_tag, integer ps_pos);integer lvi_Esp, lvi_I, lvi_Inicio,lvi_Fim
string lvs_Tag,lvs_Result


//lvs_Tag = StringReplace( ps_Tag, "/","")
//lvs_Tag = StringReplace(lvs_Tag, "<",'')
//lvs_Tag = StringReplace(lvs_Tag, ">",'')
//
//lvs_Esp = IIF(Pos(" ", 





//function TfrmExemplo.GetValueTagEx(ANFe, ATag: String; APos:integer): String;
//var
//  iEsp, i, Inicio, Fim: Integer;
//  LResult:string;
//begin
//  ATag:=StringReplace(ATag,'/','',[rfReplaceAll]);
//  ATag:=StringReplace(ATag,'<','',[rfReplaceAll]);
//  ATag:=StringReplace(ATag,'>','',[rfReplaceAll]);
//  iEsp:=IIF(Pos(' ',ATag)>0,Pos(' ',ATag),Length(ATag));
//  //Result:=Copy(ANFe,(Pos('<'+ATag+'>',ANFe)+Length(ATag)+2),Pos('</'+Copy(ATag,1,iEsp)+'>',ANFe)-(Pos('<'+ATag+'>',ANFe)+Length(ATag)+2));
//
//  inicio :=1;
//  for i:= 1 to APos do
//  begin
//    LResult:=
//    Copy(ANFe,
//    (PosEx('<'+ATag+'>',ANFe,Inicio)+Length(ATag)+2),
//    PosEx('</'+Copy(ATag,1,iEsp)+'>',ANFe,Inicio)-(PosEx('<'+ATag+'>',ANFe,Inicio)+Length(ATag)+2));
//    Inicio:=PosEx('</'+ATag+'>',ANFe,Inicio)+2;
//  end;
//  Result := LResult;
//
//end;

return ''
end function

on uo_nfe.create
end on

on uo_nfe.destroy
end on

