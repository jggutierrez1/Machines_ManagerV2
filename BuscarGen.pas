unit BuscarGen;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls,
  Grids, DBGrids,  DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TFBuscarGen = class(TForm)
    BUSCAR: TLabel;
    oFilter: TEdit;
    dbgrid1: TDBGrid;
    RadioGroup1: TRadioGroup;
    bcodigo: TRadioButton;
    bnombre: TRadioButton;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn9: TBitBtn;
    oFieldName1: TEdit;
    oFieldName2: TEdit;
    oFieldName3: TEdit;
    oFieldCaption1: TLabel;
    oFieldCaption2: TLabel;
    oFieldCaption3: TLabel;
    oSql1: TMemo;
    DataSource1: TDataSource;
    oSqlTmp: TMemo;
    Image1: TImage;
    oConection: TFDConnection;
    oQry: TFDQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure dbgrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure oFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FBuscarGen: TFBuscarGen;
  VAR01: variant;

implementation

uses utilesv20;
{$R *.dfm}

procedure TFBuscarGen.BitBtn1Click(Sender: TObject);
begin
  // oQry:=tzquery.Create(nil);
  dbgrid1.Columns[0].Alignment := taLeftJustify;
  oSqlTmp.Clear;
  oSqlTmp.Text := oSql1.Text;
  if bcodigo.Checked = true then
  begin
    if not futilesv20.isEmpty(self.oFilter.Text) then
      oSqlTmp.Lines.Add(' AND ' + self.oFieldName1.Text + ' LIKE "%' + trim(self.oFilter.Text) + '%" ');
    oSqlTmp.Lines.Add(' ORDER BY ' + self.oFieldName1.Text);

    dbgrid1.Columns[0].FieldName := oFieldName1.Text;
    dbgrid1.Columns[0].Title.caption := self.oFieldCaption1.caption;

    if not futilesv20.isEmpty(oFieldName2.Text) then
    begin
      dbgrid1.Columns[1].FieldName := oFieldName2.Text;
      dbgrid1.Columns[1].Title.caption := self.oFieldCaption2.caption;
    end;

  end
  else
  begin
    if not futilesv20.isEmpty(self.oFilter.Text) then
      oSqlTmp.Lines.Add(' AND ' + self.oFieldName2.Text + ' LIKE "%' + trim(self.oFilter.Text) + '%" ');
    oSqlTmp.Lines.Add(' ORDER BY ' + self.oFieldName2.Text);

    dbgrid1.Columns[0].FieldName := oFieldName1.Text;
    dbgrid1.Columns[0].Title.caption := self.oFieldCaption1.caption;

    if not futilesv20.isEmpty(oFieldName1.Text) then
    begin
      dbgrid1.Columns[1].FieldName := oFieldName2.Text;
      dbgrid1.Columns[1].Title.caption := self.oFieldCaption2.caption;
    end;
  end;

  futilesv20.ConnectServer(utilesv20.sSlectedHost);
  oQry.Connection := futilesv20.oPublicCnn;
  oQry.SQL.Clear;
  oQry.SQL.Text := oSqlTmp.Text;
  oQry.Open;
  DataSource1.DataSet := oQry;
  Label2.caption := inttostr(oQry.RecordCount);

  if oQry.fields[0].Text <> '' then
    self.dbgrid1.enabled := true
  else
    self.dbgrid1.enabled := false;
end;

procedure TFBuscarGen.BitBtn9Click(Sender: TObject);
begin
  VAR01 := '';
  self.close;
end;

procedure TFBuscarGen.oFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    self.BitBtn1Click(self);
  end;
end;

procedure TFBuscarGen.dbgrid1DblClick(Sender: TObject);
begin
  if not oQry.Eof then
  begin
    if oQry.RecordCount > 0 then
      VAR01 := self.dbgrid1.SelectedField.DataSet.FieldByName(oFieldName1.Text).Value
    else
      VAR01 := '';
  end
  else
    VAR01 := '';
  close;
end;

procedure TFBuscarGen.FormCreate(Sender: TObject);
begin
  //self.ResizeKit1.enabled := utiles.Ctrl_Resize;
end;

procedure TFBuscarGen.FormShow(Sender: TObject);
begin
  self.Label2.caption := '0';
  self.oFilter.SETFOCUS;
end;

end.
