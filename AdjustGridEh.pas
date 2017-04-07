{ This unit was developed by Philippe Randour (philippe_randour@hotmail.com)
  in August 2000. It can be freely used in your own development.
  Thank you for your interest. }

unit AdjustGridEh;

interface

uses Windows, Forms, DBGridEh;

procedure AdjustColumnWidthsEh(DBGridEh: TDBGridEh);

implementation

procedure AdjustColumnWidthsEh(DBGridEh: TDBGridEh);
var
  TotalColumnWidth, ColumnCount, GridClientWidth, Filler, i: Integer;
begin
  ColumnCount := DBGridEh.Columns.Count;
  if ColumnCount = 0 then
    Exit;

  // compute total width used by grid columns and vertical lines if any
  TotalColumnWidth := 0;
  for i := 0 to ColumnCount - 1 do
    TotalColumnWidth := TotalColumnWidth + DBGridEh.Columns[i].Width;
  if dgColLines in DBGridEh.Options then
    // include vertical lines in total (one per column)
    TotalColumnWidth := TotalColumnWidth + ColumnCount;

  // compute grid client width by excluding vertical scroll bar, grid indicator,
  // and grid border
  GridClientWidth := DBGridEh.Width - GetSystemMetrics(SM_CXVSCROLL);
  if dgIndicator in DBGridEh.Options then
  begin
    GridClientWidth := GridClientWidth - IndicatorWidth;
    if dgColLines in DBGridEh.Options then
      Dec(GridClientWidth);
  end;
  if DBGridEh.BorderStyle = bsSingle then
  begin
    if DBGridEh.Ctl3D then // border is sunken (vertical border is 2 pixels wide)
      GridClientWidth := GridClientWidth - 4
    else // border is one-dimensional (vertical border is one pixel wide)
      GridClientWidth := GridClientWidth - 2;
  end;

  // adjust column widths
  if TotalColumnWidth < GridClientWidth then
  begin
    Filler := (GridClientWidth - TotalColumnWidth) div ColumnCount;
    for i := 0 to ColumnCount - 1 do
      DBGridEh.Columns[i].Width := DBGridEh.Columns[i].Width + Filler;
  end
  else if TotalColumnWidth > GridClientWidth then
  begin
    Filler := (TotalColumnWidth - GridClientWidth) div ColumnCount;
    if (TotalColumnWidth - GridClientWidth) mod ColumnCount <> 0 then
      Inc(Filler);
    for i := 0 to ColumnCount - 1 do
      DBGridEh.Columns[i].Width := DBGridEh.Columns[i].Width - Filler;
  end;
end;

end.
