unit TecladoGen1;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  ComCtrls;

type
  TfTecladoGen1 = class(TForm)
    DISPLAY: TEdit;
    BitBtn13: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn16: TBitBtn;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn20: TBitBtn;
    BitBtn21: TBitBtn;
    BitBtn22: TBitBtn;
    BitBtn23: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn25: TBitBtn;
    BitBtn26: TBitBtn;
    BitBtn27: TBitBtn;
    BitBtn28: TBitBtn;
    BitBtn29: TBitBtn;
    BitBtn30: TBitBtn;
    BitBtn31: TBitBtn;
    BitBtn32: TBitBtn;
    BitBtn24: TBitBtn;
    BitBtn33: TBitBtn;
    BitBtn34: TBitBtn;
    BitBtn35: TBitBtn;
    BitBtn36: TBitBtn;
    BitBtn37: TBitBtn;
    BitBtn38: TBitBtn;
    BitBtn39: TBitBtn;
    BitBtn40: TBitBtn;
    BitBtn41: TBitBtn;
    BitBtn42: TBitBtn;
    BitBtn43: TBitBtn;
    BitBtn44: TBitBtn;
    BitBtn45: TBitBtn;
    btn9: TSpeedButton;
    btn7: TSpeedButton;
    btn8: TSpeedButton;
    btn6: TSpeedButton;
    btn5: TSpeedButton;
    btn4: TSpeedButton;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    btn3: TSpeedButton;
    Btnmm: TSpeedButton;
    btnponto: TSpeedButton;
    btn0: TSpeedButton;
    StatusBar1: TStatusBar;
    oBtn_Extended: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn45Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn7Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure btn5Click(Sender: TObject);
    procedure btn9Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure BtnmmClick(Sender: TObject);
    procedure btnpontoClick(Sender: TObject);
    procedure btn0Click(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure BitBtn31Click(Sender: TObject);
    procedure BitBtn32Click(Sender: TObject);
    procedure BitBtn38Click(Sender: TObject);
    procedure BitBtn39Click(Sender: TObject);
    procedure BitBtn40Click(Sender: TObject);
    procedure BitBtn43Click(Sender: TObject);
    procedure BitBtn27Click(Sender: TObject);
    procedure BitBtn28Click(Sender: TObject);
    procedure BitBtn29Click(Sender: TObject);
    procedure BitBtn35Click(Sender: TObject);
    procedure BitBtn36Click(Sender: TObject);
    procedure BitBtn37Click(Sender: TObject);
    procedure BitBtn42Click(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn25Click(Sender: TObject);
    procedure BitBtn26Click(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure BitBtn33Click(Sender: TObject);
    procedure BitBtn34Click(Sender: TObject);
    procedure BitBtn41Click(Sender: TObject);
    procedure BitBtn44Click(Sender: TObject);
    procedure BitBtn23Click(Sender: TObject);
    procedure BitBtn30Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure ClickBotaoG(numero: string);
    procedure oBtn_ExtendedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fTecladoGen1: TfTecladoGen1;
  Primeiro, Segundo: real;
  Operacao, oblig: integer;
  Igual, Limpa: boolean;
  KeyExtended: boolean;
  FUNCIONTECLADO: string;
  cFindResult: string;

implementation

uses utilesV20;
{$R *.dfm}

procedure TfTecladoGen1.ClickBotaoG(numero: string);
begin
  if trim(numero) = 'ç' then
  begin
    if trim(DISPLAY.text) = '' then
      exit;
    DISPLAY.text := copy(DISPLAY.text, 1, StrLen(PansiChar(DISPLAY.text)) - 1);
    exit;
  end;
  if (Igual or Limpa) then
  begin
    DISPLAY.text := '';
    Igual := False;
    Limpa := False;
    DISPLAY.text := DISPLAY.text + numero;
  end
  else
  begin
    DISPLAY.text := DISPLAY.text + numero;
  end;
end;

procedure TfTecladoGen1.BitBtn20Click(Sender: TObject);
begin
  ClickBotaoG('D');
end;

procedure TfTecladoGen1.BitBtn21Click(Sender: TObject);
begin
  ClickBotaoG('Q');
end;

procedure TfTecladoGen1.BitBtn22Click(Sender: TObject);
begin
  ClickBotaoG('W');
end;

procedure TfTecladoGen1.BitBtn23Click(Sender: TObject);
begin
  ClickBotaoG('E');
end;

procedure TfTecladoGen1.BitBtn24Click(Sender: TObject);
begin
  ClickBotaoG('M');
end;

procedure TfTecladoGen1.BitBtn25Click(Sender: TObject);
begin
  ClickBotaoG('B');
end;

procedure TfTecladoGen1.BitBtn26Click(Sender: TObject);
begin
  ClickBotaoG('N');
end;

procedure TfTecladoGen1.BitBtn27Click(Sender: TObject);
begin
  ClickBotaoG('F');
end;

procedure TfTecladoGen1.BitBtn28Click(Sender: TObject);
begin
  ClickBotaoG('G');
end;

procedure TfTecladoGen1.BitBtn29Click(Sender: TObject);
begin
  ClickBotaoG('H');
end;

procedure TfTecladoGen1.BitBtn2Click(Sender: TObject);
begin
  ClickBotaoG('_');
end;

procedure TfTecladoGen1.BitBtn30Click(Sender: TObject);
begin
  ClickBotaoG('R');
end;

procedure TfTecladoGen1.BitBtn31Click(Sender: TObject);
begin
  ClickBotaoG('T');
end;

procedure TfTecladoGen1.BitBtn32Click(Sender: TObject);
begin
  ClickBotaoG('Y');
end;

procedure TfTecladoGen1.BitBtn33Click(Sender: TObject);
begin
  ClickBotaoG(',');
end;

procedure TfTecladoGen1.BitBtn34Click(Sender: TObject);
begin
  ClickBotaoG('.');
end;

procedure TfTecladoGen1.BitBtn35Click(Sender: TObject);
begin
  ClickBotaoG('J');
end;

procedure TfTecladoGen1.BitBtn36Click(Sender: TObject);
begin
  ClickBotaoG('K');
end;

procedure TfTecladoGen1.BitBtn37Click(Sender: TObject);
begin
  ClickBotaoG('L');
end;

procedure TfTecladoGen1.BitBtn38Click(Sender: TObject);
begin
  ClickBotaoG('U');
end;

procedure TfTecladoGen1.BitBtn39Click(Sender: TObject);
begin
  ClickBotaoG('I');
end;

procedure TfTecladoGen1.BitBtn3Click(Sender: TObject);
begin
  ClickBotaoG('ç');
end;

procedure TfTecladoGen1.btn0Click(Sender: TObject);
begin
  ClickBotaoG('0');
end;

procedure TfTecladoGen1.btn1Click(Sender: TObject);
begin
  ClickBotaoG('1');
end;

procedure TfTecladoGen1.btn2Click(Sender: TObject);
begin
  ClickBotaoG('2');
end;

procedure TfTecladoGen1.btn3Click(Sender: TObject);
begin
  ClickBotaoG('3');
end;

procedure TfTecladoGen1.btn4Click(Sender: TObject);
begin
  ClickBotaoG('4');
end;

procedure TfTecladoGen1.btn5Click(Sender: TObject);
begin
  ClickBotaoG('5');
end;

procedure TfTecladoGen1.btn6Click(Sender: TObject);
begin
  ClickBotaoG('6');
end;

procedure TfTecladoGen1.btn7Click(Sender: TObject);
begin
  ClickBotaoG('7');
end;

procedure TfTecladoGen1.btn8Click(Sender: TObject);
begin
  ClickBotaoG('8');
end;

procedure TfTecladoGen1.btn9Click(Sender: TObject);
begin
  ClickBotaoG('9');
end;

procedure TfTecladoGen1.BtnmmClick(Sender: TObject);
begin
  Limpa := True;
  DISPLAY.text := '';
end;

procedure TfTecladoGen1.btnpontoClick(Sender: TObject);
begin
  if (Igual or Limpa) then
  begin
    DISPLAY.text := '';
    Igual := False;
    Limpa := False;
    DISPLAY.text := DISPLAY.text + '.';
  end
  else if (pos('.', DISPLAY.text) = 0) then
    DISPLAY.text := DISPLAY.text + '.';
end;

procedure TfTecladoGen1.FormCreate(Sender: TObject);
begin
  self.DISPLAY.Visible := True;
  self.DISPLAY.PasswordChar := #0;

  KeyExtended := False;
end;

procedure TfTecladoGen1.FormShow(Sender: TObject);
begin
  cFindResult := '';
  if trim(DISPLAY.PasswordChar) = '' then
    DISPLAY.PasswordChar := #0;

  if trim(UpperCase(FUNCIONTECLADO)) = 'CLAVE' then
    DISPLAY.PasswordChar := '*';

  Limpa := True;
  DISPLAY.text := '';
  oBtn_Extended.Click;
end;

procedure TfTecladoGen1.oBtn_ExtendedClick(Sender: TObject);
begin
  if KeyExtended = True then
  begin
    self.oBtn_Extended.Caption := '<';
    self.Width := 910;
    KeyExtended := False;
  end
  else
  begin
    self.oBtn_Extended.Caption := '>';
    self.Width := 704;
    KeyExtended := True;
  end;
end;

procedure TfTecladoGen1.BitBtn13Click(Sender: TObject);
begin
  Limpa := True;
  DISPLAY.text := '';
end;

procedure TfTecladoGen1.BitBtn14Click(Sender: TObject);
begin
  ClickBotaoG('V');
end;

procedure TfTecladoGen1.BitBtn15Click(Sender: TObject);
begin
  ClickBotaoG('Z');
end;

procedure TfTecladoGen1.BitBtn16Click(Sender: TObject);
begin
  ClickBotaoG('X');
end;

procedure TfTecladoGen1.BitBtn17Click(Sender: TObject);
begin
  ClickBotaoG('C');
end;

procedure TfTecladoGen1.BitBtn18Click(Sender: TObject);
begin
  ClickBotaoG('A');
end;

procedure TfTecladoGen1.BitBtn19Click(Sender: TObject);
begin
  ClickBotaoG('S');
end;

procedure TfTecladoGen1.BitBtn1Click(Sender: TObject);
begin
  ClickBotaoG('@');
end;

procedure TfTecladoGen1.BitBtn40Click(Sender: TObject);
begin
  ClickBotaoG('O');
end;

procedure TfTecladoGen1.BitBtn41Click(Sender: TObject);
begin
  ClickBotaoG('-');
end;

procedure TfTecladoGen1.BitBtn42Click(Sender: TObject);
begin
  ClickBotaoG('Ñ');
end;

procedure TfTecladoGen1.BitBtn43Click(Sender: TObject);
begin
  ClickBotaoG('P');
end;

procedure TfTecladoGen1.BitBtn44Click(Sender: TObject);
begin
  ClickBotaoG(' ');
end;

procedure TfTecladoGen1.BitBtn45Click(Sender: TObject);
begin
  cFindResult := DISPLAY.text;
  if (oblig = 1) and (DISPLAY.text = '') then
  begin
    application.MessageBox('Debe escribir un dato', 'Información', 0);
    exit;
  end;
  oblig := 0;
  DISPLAY.PasswordChar := #0;
  close;
end;

end.
