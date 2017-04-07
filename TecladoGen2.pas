unit TecladoGen2;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,
  ComCtrls;

type
  TfTecladoGen2 = class(TForm)
    DISPLAY: TEdit;
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
    procedure FormShow(Sender: TObject);
    procedure ClickBotaoG(numero: string);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fTecladoGen2: TfTecladoGen2;
  Primeiro, Segundo: real;
  Operacao, oblig: integer;
  Igual, Limpa: boolean;
  FUNCIONTECLADO: string;
  cFindResult: string;

implementation

uses utilesV20;
{$R *.dfm}

procedure TfTecladoGen2.ClickBotaoG(numero: string);
begin
  if (Igual or Limpa) then
  begin
    DISPLAY.text := '';
    Igual := False;
    Limpa := False;
    DISPLAY.text := DISPLAY.text + numero;
  end
  else
    DISPLAY.text := DISPLAY.text + numero;
end;

procedure TfTecladoGen2.btn0Click(Sender: TObject);
begin
  ClickBotaoG('0');
end;

procedure TfTecladoGen2.btn1Click(Sender: TObject);
begin
  ClickBotaoG('1');
end;

procedure TfTecladoGen2.btn2Click(Sender: TObject);
begin
  ClickBotaoG('2');
end;

procedure TfTecladoGen2.btn3Click(Sender: TObject);
begin
  ClickBotaoG('3');
end;

procedure TfTecladoGen2.btn4Click(Sender: TObject);
begin
  ClickBotaoG('4');
end;

procedure TfTecladoGen2.btn5Click(Sender: TObject);
begin
  ClickBotaoG('5');
end;

procedure TfTecladoGen2.btn6Click(Sender: TObject);
begin
  ClickBotaoG('6');
end;

procedure TfTecladoGen2.btn7Click(Sender: TObject);
begin
  ClickBotaoG('7');
end;

procedure TfTecladoGen2.btn8Click(Sender: TObject);
begin
  ClickBotaoG('8');
end;

procedure TfTecladoGen2.btn9Click(Sender: TObject);
begin
  ClickBotaoG('9');
end;

procedure TfTecladoGen2.BtnmmClick(Sender: TObject);
begin
  Limpa := True;
  DISPLAY.text := '';
end;

procedure TfTecladoGen2.btnpontoClick(Sender: TObject);
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

procedure TfTecladoGen2.FormCreate(Sender: TObject);
begin
  self.DISPLAY.Visible := True;
  self.DISPLAY.PasswordChar := #0;
end;

procedure TfTecladoGen2.FormShow(Sender: TObject);
begin
  cFindResult := '';

  if trim(DISPLAY.PasswordChar) = '' then
    DISPLAY.PasswordChar := #0;

  if trim(UpperCase(FUNCIONTECLADO)) = 'CLAVE' then
    DISPLAY.PasswordChar := '*';

  Limpa := True;
  DISPLAY.text := '';
end;

procedure TfTecladoGen2.BitBtn45Click(Sender: TObject);
begin
  if (oblig = 1) and (DISPLAY.text = '') then
  begin
    application.MessageBox('Debe escribir un dato', 'Información', 0);
    exit;
  end
  else
  begin
    if ((trim(DISPLAY.text) = '') or (trim(DISPLAY.text) = '.')) then
      DISPLAY.text := '0';
  end;
  cFindResult := DISPLAY.text;
  oblig := 0;
  DISPLAY.PasswordChar := #0;
  close;
end;

end.
