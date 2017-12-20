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
    Memo1: TMemo;
    StornoBtn: TButton;
    OvocieBtn: TButton;
    ZeleninaBtn: TButton;
    PecivoBtn: TButton;
    OstatneBtn: TButton;
    Button6: TButton;
    VlozBtn: TButton;
    PlatbaBtn: TButton;
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
    ListBox2: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure PlatbaBtnClick(Sender: TObject);
    procedure OvocieBtnClick(Sender: TObject);
    procedure StornoBtnClick(Sender: TObject);
    procedure ZeleninaBtnClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure VlozBtnClick(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Vyhladajpodlakodu;
    procedure Prihlasenie;
    procedure SchovajObjekty;
  private
    { private declarations }
  public
    { public declarations }
  end;

type zoznamtovaru=record
     kod: integer;
     nazov: string;
     nakupnacena: integer;
     predajnacena: integer;
     pocet: integer;
end;

type zoznampokladnikov=record
     meno: string;
     kod: string;
end;

type zoznamovocia=record
     kod: integer;
     nazov: string;
     nakupnacena: integer;
     predajnacena: integer;
     pocet: integer;
end;

type zoznamuctenka=record
     kod: integer;
     nazov: string;
     pocet: integer;
     cena: integer;
end;

const n=6;
      m=10;
      o=5;
      p=50;

var
  pokladnici: array[1..n] of zoznampokladnikov;
  tovar: array[1..m] of zoznamtovaru;
  sklad: array[1..2,1..m] of integer;
  ovocie: array[1..o] of zoznamovocia;
  uctenka: array[1..p] of zoznamuctenka;
  i, itemindex, kodtovaru, pocetobjektov: integer;
  subor1, subor2, subor3, subor4, subor5: textfile;
  znak: char;
  kod, pokladnik: string;
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Prihlasenie;
begin
kod:=edit1.Text;
for i:=1 to n do
    if pokladnici[i].kod = kod then begin
       pokladnik:=pokladnici[i].meno;
       label3.caption:='Pokladnu obsluhuje: '+pokladnik;
       image1.visible:=true;
       listbox1.visible:=true;
       label2.visible:=false;
       label3.visible:=true;
       label4.visible:=true;
       label5.visible:=true;
       OvocieBtn.visible:=true;
       ZeleninaBtn.visible:=true;
       PecivoBtn.visible:=true;
       OstatneBtn.visible:=true;
       button6.visible:=true;
       VlozBtn.visible:=true;
       PlatbaBtn.visible:=true;
       edit2.visible:=true;
       edit3.visible:=true;
       listbox2.visible:=true;
       label1.visible:=false;
       edit1.visible:=false;
       button1.visible:=false;
       StornoBtn.visible:=true;
    end;
end;

procedure TForm1.SchovajObjekty;
begin
image1.visible:=false;
label2.visible:=false;
label3.visible:=false;
label4.visible:=false;
label5.visible:=false;
OvocieBtn.visible:=false;
ZeleninaBtn.visible:=false;
PecivoBtn.visible:=false;
OstatneBtn.visible:=false;
button6.visible:=false;
VlozBtn.visible:=false;
PlatbaBtn.visible:=false;
edit2.visible:=false;
edit3.visible:=false;
listbox2.visible:=false;
listbox1.Visible:=false;
StornoBtn.visible:=false;
end;

procedure TForm1.VyhladajPodlaKodu;
begin
ListBox1.Items.Clear;
kodtovaru:=strtoint(edit3.text);
for i:=1 to m do
    if kodtovaru=tovar[i].kod then
       ListBox1.Items.Add(tovar[i].nazov);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
prihlasenie();
end;

procedure TForm1.PlatbaBtnClick(Sender: TObject);
begin
SchovajObjekty;

end;

procedure TForm1.OvocieBtnClick(Sender: TObject);
begin
ListBox1.Items.Clear;
for i:=1 to m do
    ListBox1.Items.Add(tovar[i].nazov);
end;

procedure TForm1.StornoBtnClick(Sender: TObject);
var
  stornoIndex, i: integer;
begin

     case QuestionDlg ('STORNO','Chcete stornovať celý nákup alebo zvolenú položku?',mtCustom,[mrYes,'Nákup', mrNo , 'Položku', 'IsDefault'],'') of
        mrYes: if PasswordBox( 'STORNO' , 'Zadajte váš kód:' ) = kod  then Close else ShowMessage('Nesprávny kód.');
        mrNo:  if PasswordBox( 'STORNO' , 'Zadajte váš kód:' ) =  kod  then
                  begin
                    for i := 0 to (ListBox2.Count - 1) do
                        if ListBox2.Selected[ i ] = True then
                           stornoIndex := i;

                    Listbox2.Items.Delete(stornoIndex);
                    dec(pocetobjektov);
                  end
               else ShowMessage('Nesprávny kód.');
        mrCancel: ;
     end;

end;

procedure TForm1.ZeleninaBtnClick(Sender: TObject);
begin

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
vyhladajpodlakodu;
end;

procedure TForm1.VlozBtnClick(Sender: TObject);
var
pocet: integer;
begin
i:=0;
inc(pocetobjektov);
itemindex:=itemindex+1;
pocet:=strtoint(edit2.text);
Listbox2.Items.Add(inttostr(tovar[itemindex].kod)+'  '+tovar[itemindex].nazov+'         '+inttostr(pocet)+'x'+inttostr(tovar[itemindex].predajnacena)+'€'+'    '+inttostr(pocet*tovar[itemindex].predajnacena)+'€');
edit2.clear;
inc(i);
uctenka[i].kod:=tovar[itemindex].kod;
uctenka[i].nazov:=tovar[itemindex].nazov;
uctenka[i].cena:=tovar[itemindex].predajnacena;
uctenka[i].pocet:=pocet;
end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
prihlasenie;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
hold,j,x2,x3,x4,kod,nakupnacena,predajnacena,pocet: integer;    //x je premenna na pocet riadkov v txt subore
begin
ListBox2.Items.Clear;
image1.picture.loadfromfile('logo.png');
SchovajObjekty;
assignfile(subor1,'pokladnici.txt');
reset(subor1);
i:=0;
while not eof(subor1) do     //nacitanie mien a kodov pokladnikov
begin
     inc(i);
     read(subor1,znak);
     repeat
       pokladnici[i].meno:=pokladnici[i].meno+znak;
       read(subor1,znak);
     until znak = ' ';

     repeat
       read(subor1,znak);
       pokladnici[i].kod:=pokladnici[i].kod+znak;
     until eoLn(subor1);
     readln(subor1);
end;

assignfile(subor2,'TOVAR.txt');
reset(subor2);
i:=0;
readln(subor2,x2);
while not eof(subor2) do
begin
     inc(i);
     read(subor2,tovar[i].kod);
     read(subor2,znak);  //precitaj medzeru
     readln(subor2,tovar[i].nazov);  //precita cely string po koniec a skoci na dalsi riadok
     //memo1.append(inttostr(tovar[i].kod)+tovar[i].nazov);
end;
closefile(subor2);

assignfile(subor3,'CENNIK.txt');
reset(subor3);
i:=0;
readln(subor3,x3);
while not eof(subor3) do
begin
     inc(i);
     read(subor3,kod);
     read(subor3,nakupnacena);
     read(subor3,predajnacena);
     for j:=1 to m do
         if tovar[j].kod=kod then
            begin
                 tovar[j].nakupnacena:=nakupnacena;
                 tovar[j].predajnacena:=predajnacena;
            end;
end;
closefile(subor3);


assignfile(subor4,'SKLAD.txt');
reset(subor4);
i:=0;
readln(subor4,x4);
while not eof(subor4) do
begin
     inc(i);
     read(subor4,kod);
     read(subor4,pocet);
     for j:=1 to m do
         if tovar[j].kod=kod then tovar[j].pocet:=pocet;
     //memo1.append(inttostr(tovar[i].kod)+tovar[i].nazov+inttostr(tovar[i].nakupnacena)+inttostr(tovar[i].predajnacena)+inttostr(tovar[i].pocet));
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
label2.visible:=true;
end;

end.

