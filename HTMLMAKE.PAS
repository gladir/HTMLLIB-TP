{ @author: Sylvain Maltais (support@gladir.com)
  @created: 2023
  @website(https://www.gladir.com/CODER/HTMLLIB-TP)
  @abstract(Target: Turbo Pascal 7, Free Pascal 3.2)
}

Unit HTMLMAKE;

INTERFACE

Procedure BeginBodyHTML(Var F:Text);
Procedure BeginDivHTML(Var F:Text);
Procedure BeginHeaderHTML(Var F:Text);
Procedure BeginParagraphHTML(Var F:Text);
Procedure BeginSpanHTML(Var F:Text);
Procedure BeginTableCellHTML(Var F:Text);
Procedure BeginTableHTML(Var F:Text);
Procedure BeginTableHeaderColumnHTML(Var F:Text);
Procedure BeginTableHeaderHTML(Var F:Text);
Procedure BeginTableRowHTML(Var F:Text);
Function  CloseHTML(Var F:Text):Boolean;
Function  CreateHTML(Var F:Text;FileName:String):Boolean;
Procedure EndBodyHTML(Var F:Text);
Procedure EndDivHTML(Var F:Text);
Procedure EndHeaderHTML(Var F:Text);
Procedure EndParagraphHTML(Var F:Text);
Procedure EndSpanHTML(Var F:Text);
Procedure EndTableCellHTML(Var F:Text);
Procedure EndTableHTML(Var F:Text);
Procedure EndTableHeaderColumnHTML(Var F:Text);
Procedure EndTableHeaderHTML(Var F:Text);
Procedure EndTableRowHTML(Var F:Text);
Function  GetLanguageHTML:String;
Procedure SetBoldHTML(Var F:Text);
Procedure SetItalicHTML(Var F:Text);
Procedure SetLanguageHTML(LangMID:String);
Procedure SetTitleHTML(Var F:Text;Title:String);
Procedure SetVersionHTML(Version,SubVersion:Byte);
Procedure UnSetBoldHTML(Var F:Text);
Procedure UnSetItalicHTML(Var F:Text);
Procedure WriteHTML(Var F:Text;Txt:String);
Procedure WriteTextHTML(Var F:Text;Txt:String);

IMPLEMENTATION

Var
 HTMLVersion,HTMLSubVersion:Byte;
 Language:String[3];

Function Replace(Source,Old,New:String):String;
Var
 P:LongInt;
Begin
 While Pos(Old,Source)<>0 do Begin
  P:=Pos(Old,Source);
  Delete(Source,P,Length(Old));
  Insert(New,Source,P);
 End;
 Replace:=Source;
End;

Procedure SetVersionHTML(Version,SubVersion:Byte);Begin
 HTMLVersion:=Version;
 HTMLSubversion:=SubVersion;
End;

Procedure SetLanguageHTML(LangMID:String);Begin
 Language:=LangMID;
End;

Function GetLanguageHTML:String;Begin
 GetLanguageHTML:=Language;
End;

Function CreateHTML(Var F:Text;FileName:String):Boolean;
Var
 R:Boolean;
Begin
 {$I-}Assign(F,FileName);
 Rewrite(F);{$I+}
 R:=IOResult=0;
 CreateHTML:=R;
 If(R)Then Begin
  Case HTMLVersion of
   1:Begin
    { ... Ne rien rajouter }
   End;
   2:WriteLn(F,'<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.',HTMLSubVersion,'//EN">');
   3:Begin
    WriteLn(F,'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.',HTMLSubVersion,'//EN">');
    WriteLn(F,'<HTML>');
   End;
   4:Begin
    WriteLn(F,'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.',HTMLSubVersion,'//EN" "https://www.w3.org/TR/html4/strict.dtd">');
    WriteLn(F,'<HTML>');
   End;
   5:Begin
    WriteLn(F,'<!DOCTYPE html>');
    WriteLn(F,'<html lang="',Language,'">');
   End;
  End;
 End;
End;

Procedure BeginHeaderHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn(F,'<HEAD>');
  5:WriteLn(F,'<head>');
 End;
End;

Procedure SetTitleHTML(Var F:Text;Title:String);Begin
 Title:=Replace(Title,'<','&lt;');
 Title:=Replace(Title,'>','&gt;');
 Case HTMLVersion of
  1,2,3,4:WriteLn(F,'<TITLE>',Title,'</TITLE>');
  5:WriteLn(F,'<title>',Title,'</title>');
 End;
End;

Procedure BeginBodyHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn(F,'<BODY>');
  5:WriteLn(F,'<body>');
 End;
End;

Procedure EndHeaderHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn(F,'</HEAD>');
  5:WriteLn(F,'</head>');
 End;
End;

Procedure EndBodyHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn(F,'</BODY>');
  5:WriteLn(F,'</body>');
 End;
End;

Procedure SetItalicHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('<I>');
  5:Write('<i>');
 End;
End;

Procedure UnSetItalicHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('</I>');
  5:Write('</i>');
 End;
End;

Procedure SetBoldHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('<B>');
  5:Write('<b>');
 End;
End;

Procedure UnSetBoldHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('</B>');
  5:Write('</b>');
 End;
End;

Procedure BeginParagraphHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('<P>');
  5:Write('<p>');
 End;
End;

Procedure EndParagraphHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('</P>');
  5:Write('</p>');
 End;
End;

Procedure BeginDivHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('<DIV>');
  5:Write('<div>');
 End;
End;

Procedure EndDivHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('</DIV>');
  5:Write('</div>');
 End;
End;

Procedure BeginSpanHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('<SPAN>');
  5:Write('<span>');
 End;
End;

Procedure EndSpanHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('</SPAN>');
  5:Write('</span>');
 End;
End;

Procedure BeginTableHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn('<TABLE>');
  5:WriteLn('<table>');
 End;
End;

Procedure EndTableHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn('</TABLE>');
  5:WriteLn('</table>');
 End;
End;

Procedure BeginTableHeaderHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn('<TR>');
  5:WriteLn('<tr>');
 End;
End;

Procedure EndTableHeaderHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn('</TR>');
  5:WriteLn('</tr>');
 End;
End;

Procedure BeginTableHeaderColumnHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('<TH>');
  5:Write('<th>');
 End;
End;

Procedure EndTableHeaderColumnHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('</TH>');
  5:Write('</th>');
 End;
End;

Procedure BeginTableRowHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn('<TR>');
  5:WriteLn('<tr>');
 End;
End;

Procedure EndTableRowHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:WriteLn('</TR>');
  5:WriteLn('</tr>');
 End;
End;

Procedure BeginTableCellHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('<TD>');
  5:Write('<td>');
 End;
End;

Procedure EndTableCellHTML(Var F:Text);Begin
 Case HTMLVersion of
  1,2,3,4:Write('</Td>');
  5:Write('</td>');
 End;
End;

Procedure WriteHTML(Var F:Text;Txt:String);Begin
 Write(F,Txt);
End;

Procedure WriteTextHTML(Var F:Text;Txt:String);Begin
 Txt:=Replace(Txt,'<','&lt;');
 Txt:=Replace(Txt,'>','&gt;');
 Write(F,Txt);
End;

Function CloseHTML(Var F:Text):Boolean;Begin
 Case HTMLVersion of
  3,4:WriteLn(F,'</HTML>');
  5:WriteLn(F,'</html>');
 End;
 Close(F);
 CloseHTML:=IOResult=0;
End;

BEGIN
 HTMLVersion:=5;
 HTMLSubVersion:=0;
 Language:='fr';
END.