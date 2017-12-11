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
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

type zoznam1=record
meno: string;
kod: integer;
end;

const n=6;

var
  pole1: array[1..n] of zoznam1;
  kod,i: integer;
  subor1: textfile;
  znak: char;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
kod:=strtoint(edit1.Text);
for i:=1 to n do
    if pole1[i].kod = kod then begin
       label2.visible:=false;
       button2.visible:=true;
       button3.visible:=true;
       button4.visible:=true;
       button5.visible:=true;
       button6.visible:=true;
       button7.visible:=true;
       edit2.visible:=true;
       edit3.visible:=true;
       memo1.visible:=true;
       label1.visible:=false;
       edit1.visible:=false;
       button1.visible:=false;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
label2.visible:=false;
button2.visible:=false;
button3.visible:=false;
button4.visible:=false;
button5.visible:=false;
button6.visible:=false;
button7.visible:=false;
edit2.visible:=false;
edit3.visible:=false;
memo1.visible:=false;

assignfile(subor1,'pokladnici.txt');
reset(subor1);
i:=0;
while not eof(subor1) do
begin
     inc(i);
     read(subor1,znak);
     repeat
     pole1[i].meno:=pole1[i].meno+znak;
     read(subor1,znak);
     until znak=' ';

     read(subor1,pole1[i].kod);

     readln(subor1);

     //memo2.Append(pole1[i].meno+' '+inttostr(pole1[i].kod));
end;
end;

procedure TForm1.Image2Click(Sender: TObject);
begin

end;

end.

