unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure vyhladajpodlakodu;
    procedure prihlasenie;
  private
    { private declarations }
  public
    { public declarations }
  end;

type zoznam2=record
     kod: integer;
     nazov: string;
     cena: integer;
     pocet: integer;
end;

type zoznam1=record
     meno: string;
     kod: integer;
end;

const n=6;
      m=2;

var
  pole1: array[1..n] of zoznam1;
  pole2: array[1..m] of zoznam2;
  kod,i,itemindex,kodtovaru: integer;
  subor1,subor2,uctenka: textfile;
  znak: char;
  pokladnik: string;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.prihlasenie;
begin
kod:=strtoint(edit1.Text);
for i:=1 to n do                           //tu asi treba zmenit cyklus
    if pole1[i].kod = kod then begin
       pokladnik:=pole1[i].meno;
       label3.caption:='Pokladnu obsluhuje: '+pokladnik;
       image1.visible:=true;
       listbox1.visible:=true;
       label2.visible:=false;
       label3.visible:=true;
       label4.visible:=true;
       label5.visible:=true;
       button2.visible:=true;
       button3.visible:=true;
       button4.visible:=true;
       button5.visible:=true;
       button6.visible:=true;
       button7.visible:=true;
       button8.visible:=true;
       edit2.visible:=true;
       edit3.visible:=true;
       memo1.visible:=true;
       label1.visible:=false;
       edit1.visible:=false;
       button1.visible:=false;
    end;
end;

procedure TForm1.vyhladajpodlakodu;
begin
kodtovaru:=strtoint(edit3.text);
for i:=1 to m do
    if kodtovaru=pole2[i].kod then
       ListBox1.Items.Add(pole2[i].nazov);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
prihlasenie;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
ListBox1.Items.Clear;
for i:=1 to m do
    ListBox1.Items.Add(pole2[i].nazov);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
vyhladajpodlakodu;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
itemindex:=itemindex+1;
assignfile(uctenka,'uctenka.txt');
append(uctenka);
//write(uctenka,'Meno pokladnika: '+pokladnik);
//writeln(uctenka);
writeln(uctenka,pole2[itemindex].nazov+'    '+edit2.text+'x'+'    '+inttostr((pole2[itemindex].cena*strtoint(edit2.text)))+'€');
closefile(uctenka);
memo1.append(pole2[itemindex].nazov+'    '+edit2.text+'x'+'    '+inttostr((pole2[itemindex].cena*strtoint(edit2.text)))+'€');
end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
prihlasenie;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
memo1.clear;
image1.picture.loadfromfile('logo.png');
image1.visible:=false;
label2.visible:=false;
label3.visible:=false;
label4.visible:=false;
label5.visible:=false;
button2.visible:=false;
button3.visible:=false;
button4.visible:=false;
button5.visible:=false;
button6.visible:=false;
button7.visible:=false;
button8.visible:=false;
edit2.visible:=false;
edit3.visible:=false;
memo1.visible:=false;
listbox1.Visible:=false;

assignfile(subor1,'pokladnici.txt');
reset(subor1);
i:=0;
while not eof(subor1) do     //nacitanie mien a kodov pokladnikov
begin
     inc(i);
     read(subor1,znak);
     repeat
     pole1[i].meno:=pole1[i].meno+znak;
     read(subor1,znak);
     until znak=' ';
     read(subor1,pole1[i].kod);
     readln(subor1);
end;

assignfile(subor2,'ovocie.txt');
reset(subor2);
i:=0;
while not eof(subor2) do
begin
     inc(i);
     read(subor2,pole2[i].kod);
     read(subor2,znak);
     read(subor2,znak);
     repeat
     pole2[i].nazov:=pole2[i].nazov+znak;
     read(subor2,znak);
     until znak=' ';
     read(subor2,pole2[i].cena);
     read(subor2,pole2[i].pocet);
     readln(subor1);
     //memo1.append(inttostr(pole2[i].kod)+pole2[i].nazov+inttostr(pole2[i].cena)+inttostr(pole2[i].pocet));
end;

end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

procedure TForm1.ListBox1Click(Sender: TObject);
var i: integer;
begin
for i:= 0 to ListBox1.Count-1 do
    if ListBox1.Selected[i]=True then
       begin
            itemIndex:=i;
            break;
       end;
label2.caption:=(ListBox1.Items[itemIndex]);
end;

end.

