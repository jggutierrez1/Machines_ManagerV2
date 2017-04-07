unit BuscarGenM2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Grids, DBGrids,
  DB, ComCtrls,
  Mask, DBCtrlsEh, DBGridEhGrouping, GridsEh, DBGridEh, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DBAxisGridsEh;

type
  TFBuscarGenM2 = class(TForm)
    BitBtn9: TBitBtn;
    oSql1: TMemo;
    oDs_Qry: TDataSource;
    oSqlTmp: TMemo;
    StatusBar1: TStatusBar;
    GroupBox1: TGroupBox;
    oLst_campos: TDBComboBoxEh;
    oFilter: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    oTot_Regs: TDBNumberEditEh;
    Shape1: TShape;
    oGrid: TDBGridEh;
    oConection: TFDConnection;
    oQry: TFDQuery;
    procedure FormShow(Sender: TObject);
    procedure oFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Grid_Show;
    procedure SetGridColumnWidths(Grid: TDBGridEh);
    procedure oGridTitleClick(Column: TColumnEh);
    procedure oGridDblClick(Sender: TObject);

  private
  public
  end;

type
  oLista = object
    Campo: string;
    Texto: string;
    LLave: boolean;
  end;

var
  FBuscarGenM2: TFBuscarGenM2;
  vFindResult: string;
  cCampoLLave: variant;
  oListData: array [1 .. 10] of oLista;
  nLimit: Integer;
  DEFBORDER: Integer;
  cMasterTable: string;

implementation

uses utilesV20, AdjustGrid, TecladoGen1;
{$R *.dfm}

procedure TFBuscarGenM2.BitBtn1Click(Sender: TObject);
var
  nIndex: Integer;
begin
  oGrid.Visible := false;
  Shape1.Visible := true;

  oSqlTmp.Clear;
  oSqlTmp.Text := oSql1.Text;

  // for nIndex := 1 to self.oLst_campos.Items.Count do
  // begin
  if not fUtilesV20.isEmpty(self.oFilter.Text) then
  begin
    if fUtilesV20.isEmpty(cMasterTable) = true then
      oSqlTmp.Lines.Add(' AND ' + trim(self.oLst_campos.Value) + ' LIKE "%' + trim(self.oFilter.Text) + '%" ')
    else
      oSqlTmp.Lines.Add(' AND ' + trim(cMasterTable) + '.' + trim(self.oLst_campos.Value) + ' LIKE "%' +
        trim(self.oFilter.Text) + '%" ');
  end;

  if fUtilesV20.isEmpty(cMasterTable) = true then
    oSqlTmp.Lines.Add(' ORDER BY ' + trim(self.oLst_campos.Value))
  else
    oSqlTmp.Lines.Add(' ORDER BY ' + trim(cMasterTable) + '.' + trim(self.oLst_campos.Value));

  fUtilesV20.ConnectServer(utilesV20.sSlectedHost);
  oQry.Connection := fUtilesV20.oPublicCnn;
  oQry.SQL.Clear;
  oQry.SQL.Text := oSqlTmp.Text;
  oQry.Open;
  if oQry.RecordCount > 0 then
    self.oGrid.enabled := true
  else
    self.oGrid.enabled := false;
  self.SetGridColumnWidths(oGrid);
  oGrid.Visible := true;
  Shape1.Visible := false;

  self.oTot_Regs.Value := oQry.RecordCount;
  self.oGrid.Refresh;
  self.oGrid.AutoFitColWidths := true;
  self.oGrid.Repaint;
end;

procedure TFBuscarGenM2.BitBtn9Click(Sender: TObject);
begin
  vFindResult := '';
  self.close;
end;

procedure TFBuscarGenM2.oFilterKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    self.BitBtn1Click(self);
  end;
end;

procedure TFBuscarGenM2.oGridDblClick(Sender: TObject);
begin
  vFindResult := self.oGrid.SelectedField.DataSet.FieldByName(cCampoLLave).AsString;
  close;
end;

procedure TFBuscarGenM2.oGridTitleClick(Column: TColumnEh);
{$J+}
const
  PreviousColumnIndex: Integer = 1;
{$J-}
begin
  try
    oGrid.Columns[PreviousColumnIndex].title.Font.Style := oGrid.Columns[PreviousColumnIndex].title.Font.Style
      - [fsBold];
  except
  end;

  Column.title.Font.Style := Column.title.Font.Style + [fsBold];
  PreviousColumnIndex := Column.Index;

  if (Pos(Column.Field.FieldName, oQry.IndexFieldNames) = 1) and (Pos(' DESC', uppercase(oQry.IndexFieldNames)) = 0)
  then
    oQry.IndexFieldNames := Column.Field.FieldName + ':D'
  else
    oQry.IndexFieldNames := Column.Field.FieldName + ':A';

  oQry.First;
end;

procedure TFBuscarGenM2.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  cMasterTable := '';
  Shape1.Width := oGrid.Width;
  Shape1.Top := oGrid.Top;
  Shape1.Left := oGrid.Left;
  Shape1.Height := oGrid.Height;
  Shape1.Visible := false;
  DEFBORDER := 40;
  // self.ResizeKit1.enabled := utiles.Ctrl_Resize;
  nLimit := 10;
  for I := 1 to 10 do
  begin
    oListData[I].Campo := '';
    oListData[I].Texto := '';
    oListData[I].LLave := false;
  end;
end;

procedure TFBuscarGenM2.FormShow(Sender: TObject);
var
  nIndex: Integer;
begin
  for nIndex := 1 to nLimit do
  begin
    if oListData[nIndex].Texto = '' then
      Continue
    else
    begin
      oLst_campos.Items.Add(oListData[nIndex].Texto);
      oLst_campos.KeyItems.Add(oListData[nIndex].Campo);
      if oListData[nIndex].LLave = true then
        cCampoLLave := oListData[nIndex].Campo;
    end;
  end;
  oLst_campos.ItemIndex := 1;
  self.Grid_Show;
end;

procedure TFBuscarGenM2.Grid_Show;
var
  nIndex: Integer;
  oColumnX: TColumnEh;
begin
  oDs_Qry.DataSet := oQry;
  oGrid.DataSource := oDs_Qry;
  oGrid.Columns.Clear;
  for nIndex := 1 to nLimit do
  begin
    if oListData[nIndex].Texto = '' then
      Continue
    else
    begin
      if nIndex = 1 then
        oGrid.Columns.Add
      else
        oGrid.Columns.Insert(oGrid.Columns.Count);
      oColumnX := oGrid.Columns.Items[oGrid.Columns.Count - 1];
      oColumnX.Alignment := taLeftJustify;
      oColumnX.FieldName := oListData[nIndex].Campo;
      oColumnX.title.Caption := oListData[nIndex].Texto;

    end;
  end;
  // AdjustColumnWidths(oGrid);
  if oQry.isEmpty then
    self.oTot_Regs.Value := 0
  else
    self.oTot_Regs.Value := oQry.RecordCount;
  self.oFilter.SETFOCUS;
end;

procedure TFBuscarGenM2.SetGridColumnWidths(Grid: TDBGridEh);
{
  const
  DEFBORDER = 10;
}
var
  temp, n: Integer;
  lmax: array [0 .. 30] of Integer;
begin
  with Grid do
  begin
    Canvas.Font := Font;
    for n := 0 to Columns.Count - 1 do
      lmax[n] := Canvas.TextWidth(Grid.Columns[n].title.Caption) + DEFBORDER;
    // fields[n].FieldName
    Grid.DataSource.DataSet.First;
    while not Grid.DataSource.DataSet.Eof do
    begin
      for n := 0 to Columns.Count - 1 do
      begin
        temp := Canvas.TextWidth(trim(Columns[n].Field.DisplayText)) + DEFBORDER;
        if temp > lmax[n] then
          lmax[n] := temp;
      end; { for }
      Grid.DataSource.DataSet.Next;
    end;
    Grid.DataSource.DataSet.First;
    for n := 0 to Columns.Count - 1 do
      if lmax[n] > 0 then
        Columns[n].Width := lmax[n];
  end;
end; { SetGridColumnWidths }

end.
