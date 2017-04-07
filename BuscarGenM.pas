unit BuscarGenM;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Grids, DBGrids,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZConnection, DB, ComCtrls, Mask, DBCtrlsEh;

type
  TFBuscarGenM = class(TForm)
    oFilter: TEdit;
    dbgrid1: TDBGrid;
    RadioGroup1: TRadioGroup;
    bcodigo: TRadioButton;
    bnombre: TRadioButton;
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
    oQry: TZQuery;
    BitBtn1: TBitBtn;
    StatusBar1: TStatusBar;
    oFieldName4: TEdit;
    oFieldName5: TEdit;
    oFieldCaption4: TLabel;
    oFieldCaption5: TLabel;
    oTot_Regs: TDBNumberEditEh;
    Label2: TLabel;
    procedure dbgrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure oFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  FBuscarGenM: TFBuscarGenM;
  VAR01: variant;

implementation

uses utiles;
{$R *.dfm}

procedure TFBuscarGenM.BitBtn1Click(Sender: TObject);
begin
  // oQry:=tzquery.Create(nil);
  dbgrid1.Columns[0].Alignment := taLeftJustify;
  oSqlTmp.Clear;
  oSqlTmp.Text := oSql1.Text;
  if bcodigo.Checked = true then
  begin
    if not utiles.isEmpty(self.oFilter.Text) then
      oSqlTmp.Lines.Add(' AND ' + self.oFieldName1.Text + ' LIKE "%' + trim(self.oFilter.Text) + '%" ');
    oSqlTmp.Lines.Add(' ORDER BY ' + self.oFieldName1.Text);

    dbgrid1.Columns[0].FieldName := oFieldName1.Text;
    dbgrid1.Columns[0].Title.caption := self.oFieldCaption1.caption;

    if not utiles.isEmpty(oFieldName2.Text) then
    begin
      dbgrid1.Columns[1].FieldName := oFieldName2.Text;
      dbgrid1.Columns[1].Title.caption := self.oFieldCaption2.caption;
    end;

    if not utiles.isEmpty(oFieldName2.Text) then
    begin
      dbgrid1.Columns[1].FieldName := oFieldName2.Text;
      dbgrid1.Columns[1].Title.caption := self.oFieldCaption2.caption;
    end;

  end
  else
  begin
    if not utiles.isEmpty(self.oFilter.Text) then
      oSqlTmp.Lines.Add(' AND ' + self.oFieldName2.Text + ' LIKE "%' + trim(self.oFilter.Text) + '%" ');
    oSqlTmp.Lines.Add(' ORDER BY ' + self.oFieldName2.Text);

    dbgrid1.Columns[0].FieldName := oFieldName1.Text;
    dbgrid1.Columns[0].Title.caption := self.oFieldCaption1.caption;

    if not utiles.isEmpty(oFieldName1.Text) then
    begin
      dbgrid1.Columns[1].FieldName := oFieldName2.Text;
      dbgrid1.Columns[1].Title.caption := self.oFieldCaption2.caption;
    end;
  end;

  utiles.ConnectServer(utiles.sSlectedHost);
  oQry.Connection := utiles.oPublicCnn;
  oQry.SQL.Clear;
  oQry.SQL.Text := oSqlTmp.Text;
  oQry.Open;
  DataSource1.DataSet := oQry;
  oTot_Regs.value := oQry.RecordCount;

  if oQry.fields[0].Text <> '' then
    self.dbgrid1.enabled := true
  else
    self.dbgrid1.enabled := false;
end;

procedure TFBuscarGenM.BitBtn9Click(Sender: TObject);
begin
  VAR01 := '';
  self.close;
end;

procedure TFBuscarGenM.oFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    self.BitBtn1Click(self);
  end;
end;

procedure TFBuscarGenM.dbgrid1DblClick(Sender: TObject);
begin
  VAR01 := self.dbgrid1.SelectedField.DataSet.FieldByName(oFieldName1.Text).Value;
  close;
end;

procedure TFBuscarGenM.FormCreate(Sender: TObject);
begin
  //self.ResizeKit1.enabled := utiles.Ctrl_Resize;
end;

procedure TFBuscarGenM.FormShow(Sender: TObject);
begin
  self.oTot_Regs.value := 0;
  self.oFilter.SETFOCUS;
end;

end.

