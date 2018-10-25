unit acceso1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  Tfacceso1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    oPass: TEdit;
    oBtn_Ok: TBitBtn;
    oBtn_Cancel: TBitBtn;
    oQry_Gen: TFDQuery;
    procedure FormCreate(Sender: TObject);
    procedure oBtn_OkClick(Sender: TObject);
    procedure oBtn_CancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    bPass_Ok: boolean;
    { Public declarations }
  end;

var
  facceso1: Tfacceso1;

implementation

uses UtilesV20;
{$R *.dfm}

procedure Tfacceso1.oBtn_OkClick(Sender: TObject);
var
  cSql_Ln: string;
  sClave: string;
begin
  if (self.oPass.Text = '') then
  begin
    exit;
  end;

  sClave := fUtilesV20.Encrypt(trim(self.oPass.Text));

  cSql_Ln := '';
  cSql_Ln := cSql_Ln + 'SELECT u_acceso1 ';
  cSql_Ln := cSql_Ln + 'FROM usuarios ';
  // cSql_Ln := cSql_Ln + 'WHERE  BASE64_DECODE(u_clave)="' + trim(self.oPass.Text) + '"';
  cSql_Ln := cSql_Ln + 'WHERE u_clave=' + QuotedStr(sClave) + ' ';
  cSql_Ln := cSql_Ln + 'ORDER BY u_usuario ';
  UtilesV20.Exec_Select_SQL(self.oQry_Gen, cSql_Ln, true, false);

  if (self.oQry_Gen.FieldByName('u_acceso1').AsInteger = 1) then
    self.bPass_Ok := true
  else
    self.bPass_Ok := false;
  close;
end;

procedure Tfacceso1.oBtn_CancelClick(Sender: TObject);
begin
  self.bPass_Ok := false;
  close;
end;

procedure Tfacceso1.FormCreate(Sender: TObject);
begin
  self.oPass.Text := '';
  self.bPass_Ok := false;
end;

end.
