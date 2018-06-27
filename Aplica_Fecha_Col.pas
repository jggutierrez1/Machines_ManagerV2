unit Aplica_Fecha_Col;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, sPanel, sMonthCalendar, Vcl.StdCtrls, Vcl.Buttons, PngBitBtn, Vcl.WinXCalendars;

type
  TfAplica_Fecha_Col = class(TForm)
    oBtnExit: TPngBitBtn;
    oBtnApply: TPngBitBtn;
    StaticText1: TStaticText;
    CalendarView1: TCalendarView;
    oBtn_IrHoy: TPngBitBtn;
    procedure oBtnExitClick(Sender: TObject);
    procedure oBtnApplyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure oBtn_IrHoyClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iOption: integer;
  end;

var
  fAplica_Fecha_Col: TfAplica_Fecha_Col;

implementation

{$R *.dfm}

procedure TfAplica_Fecha_Col.FormCreate(Sender: TObject);
begin
  self.iOption := 0;
end;

procedure TfAplica_Fecha_Col.oBtnApplyClick(Sender: TObject);
begin
  if ((self.CalendarView1.Date < (Now() - 15)) or (self.CalendarView1.Date > (Now() + 15))) then
  begin
    MessageDlg('NO ES POSIBLE APLICAR UNA COLECTA ANTES DE DESPUES DE 15 DIAS DE LA FECHA DE HOY.', mtWarning, [mboK], 0);
    EXIT;
  end;

  self.iOption := 1;
  close;
end;

procedure TfAplica_Fecha_Col.oBtnExitClick(Sender: TObject);
begin
  self.iOption := 0;
  close;
end;

procedure TfAplica_Fecha_Col.oBtn_IrHoyClick(Sender: TObject);
begin
  self.CalendarView1.Date := Now();
  self.CalendarView1.Refresh;
end;

end.
