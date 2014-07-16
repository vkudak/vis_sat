unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,iniFiles;

type
    r=record
     N:integer;
     Dpt:real;
    end;
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button2: TButton;
    Edit3: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit4: TEdit;
    CheckBox1: TCheckBox;
    Button3: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
      ChaosDIR:string;
    { Public declarations }
  end;

var
  Form1: TForm1;
  Ini: TIniFile;
  i,j,code,Ns,k,VAZH:integer;
    cat,n,f2:textfile;
    s:string;
    dpt,mag,P:double;
    nl_st:TStrings;
    a:array of r;
implementation
uses strUtils;

{$R *.dfm}
function Separate (s:string;N:integer):double;
var p,e,z,f:integer;
    rez:string;
begin
e:=1;         z:=0;  f:=0;
while (e>0)and(f<n)do
  begin
    p:=PosEx('|',s,z);
    e:=PosEx('|',s,p+1);
    if e>p then begin f:=f+1;z:=e;end  else z:=z+1;
    rez:=copy(s,p+1,e-1-p);
  end;
result:=strtofloat(rez);
end;

procedure TForm1.Button1Click(Sender: TObject);
label 1,2,3,4;
begin
if not checkbox1.checked then k:=0;
setlength(a,100000);   // 100 000!!!
if opendialog1.Execute then
 begin
 assignfile(cat,opendialog1.FileName);
 reset(cat);
 setcurrentdir(Extractfilepath(application.ExeName));
////
nl_st:=TStringList.Create;
if checkbox1.checked then nl_st.LoadFromFile('nLine.txt');
///

 assignfile(f2,'nLine.txt');
 if not checkbox1.Checked then
 rewrite(f2)
  else if FileExists('nLine.txt') then append(f2) else rewrite(f2);

  readln(cat,s);
  While (length(s)=0) or (s[1]<>'|') do readln(cat,s);
  readln(cat,s);     //зупинка перед данними

 while not eof(cat) do
  begin
   readln(cat,s);
   //val(s[2]+s[3]+s[4]+s[5]+s[6]+s[7],Ns,code);    // read Sat ID Number
   if (s[1]<>'-')or(s='')or(s=' ') then
    begin
     Ns:=round(Separate(s,1));
     //mag:=strtofloat(s[157]+s[158]+s[159]+s[160]+s[161]);
     mag:=Separate(s,19);
     //dpt:=strtofloat(s[37]+s[38]+s[39]+s[40]+s[41]+s[42]);
     dpt:=Separate(s,6);
     //VAZH:=strtoint(s[13]+s[14]+s[15]);
     VAZH:=round(Separate(s,3));
     P:=round(Separate(s,9));

     if checkBox2.Checked then
        if Ns<40000 then goto 1;
     if checkBox4.Checked then goto 3;
     if checkBox3.Checked then
        if P<800 then goto 1;
     3:
     if (checkbox4.Checked) and ( ((Ns>43000) and (Ns<44000)) or
                                 ((Ns>90000) and (Ns<91000))or
                                 ((Ns>92000) and (Ns<93000))or
                                 ((Ns>96000) and (Ns<97000))or
                                 ((Ns>95200) and (Ns<=95999)) )
                                then goto 4 else goto 1;
     4:
     begin
      if VAZH< strtoint(edit4.Text) then goto 1;
      if (dpt<strtoint(edit1.text)) and(dpt>strtoint(edit2.text))
        and(mag<strtoint(edit3.text))and (VAZH>strtoint(edit4.Text))
        then
         begin
             writeln(f2,Ns,' = GEO 7x10');
             nl_st.add(inttoStr(Ns)+' = GEO 7x10');
             a[k].N:=Ns;
             a[k].dpt:=dpt;
             k:=k+1;
             form1.Caption:=inttostr(k);
         end;
     end;

    end;
    1:
  end;
closefile(cat);
closefile(f2);
 end;
setlength(a,k);
If checkbox1.Checked then
BEGIN
2:
for i:=0 to nl_st.Count-1 do
 begin
  for j:=1 to nl_st.Count-1 do
   if (nl_st.Strings[i]=nl_st.Strings[j]) and (i<>j) then
    begin nl_st.Delete(j); goto 2; end;
 end;
nl_st.SaveToFile('object.txt');
END;

Assignfile (n,'n.txt');
rewrite(n);
for i:=0 to nl_st.Count-1 do
  write(n, copy(nl_st.strings[i],1,pos(' =',nl_st.Strings[i])-1)+' ');
closefile(n);

nl_st.Free;
Form1.Caption:='Ephem processing '+'N='+inttostr(k);
button3.Enabled:=true;
end;

procedure LoadFilesByMask(lst: TStrings; const SpecDir, WildCard: string);
var
  intFound: Integer;
  SearchRec: TSearchRec;
begin
  lst.Clear;
  intFound := FindFirst(SpecDir + WildCard, faAnyFile, SearchRec);
  while intFound = 0 do
  begin
    lst.Add(SpecDir + SearchRec.Name);
    intFound := FindNext(SearchRec);
  end;
  FindClose(SearchRec);
end;


procedure TForm1.FormCreate(Sender: TObject);
var f:textfile;
begin
k:=0;
assignfile(f,'DIR');
reset(f);
readln(f,ChaosDIR);
closefile(f);
Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
if FileExists(ChangeFileExt( Application.ExeName, '.INI' )) then
try
    edit1.Text:= floattoStr(Ini.ReadFloat( 'Options', 'dpt1', 85 ));
    edit2.Text:= floattoStr(Ini.ReadFloat( 'Options', 'dpt2', -40 ));
    edit3.Text:= floattoStr(Ini.ReadFloat( 'Options', 'Max_m', 15 ));
    edit4.Text:= floattoStr(Ini.ReadFloat( 'Options', 'min_Vazhnost', 0 ));
  finally
    Ini.Free;
  end;
end;

 function FileSizeB(fileName : wideString) : Int64;
 var
   sr : TSearchRec;
 begin
   if FindFirst(fileName, faAnyFile, sr ) = 0 then
      result := Int64(sr.FindData.nFileSizeHigh) shl Int64(32) + Int64(sr.FindData.nFileSizeLow)
   else
      result := -1;
 
   FindClose(sr) ;
 end;


procedure TForm1.Button2Click(Sender: TObject);
var List:TStrings;
    i:integer;
    NName,Nname1:string;
begin
list:=TStringList.Create;
LoadFilesByMask(list,ChaosDIR+'vt\','*.*');
for i:=2 to list.count-1 do
 begin
 NName:=Extractfilename(List.strings[i]);
 Nname1:=copy(NName,1,pos('_',NName)-1);
// NName1:=NName[1]+NName[2]+NName[3]+NName[4]+NName[5];
 NName:=extractfilePAth(List.Strings[i])+NName1+'.vt';
 RenameFile(List.Strings[i], NName);
 if filesizeB(NName)<1000 then Deletefile(NName);
 end;
list.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var f:textfile;
    tmp:r;
begin
   for j:=0 to k-2 do
     for i:=0 to k-2-j do
        if a[i].dpt<a[i+1].Dpt then
          begin
          tmp:=a[i];
          a[i]:=a[i+1];
          a[i+1]:=tmp;
          end;
assignfile(f,'nLineSS.txt');
rewrite(f);
for i:=0 to k-1 do
writeln(f,a[i].N, ' = GEO 7x10'{, a[i].dpt:10:5});
closefile(f);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Ini := TIniFile.Create( ChangeFileExt( Application.ExeName, '.INI' ) );
    Ini.WriteFloat( 'Options', 'dpt1', strtofloat(edit1.text) );
    Ini.WriteFloat( 'Options', 'dpt2', strtofloat(edit2.text) );
    Ini.WriteFloat( 'Options', 'Max_m', strtofloat(edit3.text) );
    Ini.WriteFloat( 'Options', 'min_Vazhnost', strtofloat(edit4.text) );
ini.Free;
end;

end.
