unit Denominaciones;

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms,
  DBCtrls, Dialogs, StdCtrls,
  Mask, ExtCtrls, ComCtrls, Buttons,
  GridsEh, DBGridEh, DB, ADODB,
  DBCtrlsEh, pngimage, PngBitBtn, PngSpeedButton,
  WideStrings, SqlExpr, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, DBAxisGridsEh,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  EhLibVCL;

type
  TfDenom = class(TForm)
    oDBNav: TDBNavigator;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    oDS_Deno: TDataSource;
    StatusBar1: TStatusBar;
    oBtnExit: TPngBitBtn;
    oBtnAbort: TPngBitBtn;
    oBtnSave: TPngBitBtn;
    oBtnFind: TPngBitBtn;
    oBtnDelete: TPngBitBtn;
    oBtnEdit: TPngBitBtn;
    oBtnNew: TPngBitBtn;
    oBtnPrint: TPngBitBtn;
    DBGridEh1: TDBGridEh;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    oSalidas: TDBNumberEditEh;
    oEntradas: TDBNumberEditEh;
    oNombre: TDBEdit;
    oID: TDBEdit;
    oActivo: TDBCheckBox;
    Label1: TLabel;
    oValor: TDBNumberEditEh;
    oFecha_Crea: TDBDateTimeEditEh;
    oFecha_Mod: TDBDateTimeEditEh;
    Label14: TLabel;
    Label13: TLabel;
    oGrpPruevas: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    oAnterior: TDBNumberEditEh;
    oActual: TDBNumberEditEh;
    oRespuesta: TDBNumberEditEh;
    RadioGroup1: TRadioGroup;
    oChkEntrada: TRadioButton;
    oChkSalida: TRadioButton;
    oConection: TFDConnection;
    otDeno: TFDTable;
    procedure Action_Control(pOption: integer);
    procedure oBtnNewClick(Sender: TObject);
    procedure oBtnEditClick(Sender: TObject);
    procedure oBtnDeleteClick(Sender: TObject);
    procedure oBtnFindClick(Sender: TObject);
    procedure oBtnPrintClick(Sender: TObject);
    procedure oBtnSaveClick(Sender: TObject);
    procedure oBtnAbortClick(Sender: TObject);
    procedure oBtnExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure calc;
    procedure oChkEntradaClick(Sender: TObject);
    procedure oChkSalidaClick(Sender: TObject);
    procedure oAnteriorExit(Sender: TObject);
    procedure oActualExit(Sender: TObject);
    procedure oChkEntradaExit(Sender: TObject);
    procedure oChkSalidaExit(Sender: TObject);
    procedure Activa_Objetos(bPar: boolean);
    procedure FormShow(Sender: TObject);
    procedure oValorKeyPress(Sender: TObject; var Key: Char);
    procedure oNombreKeyPress(Sender: TObject; var Key: Char);
    procedure oEntradasKeyPress(Sender: TObject; var Key: Char);
    procedure oSalidasKeyPress(Sender: TObject; var Key: Char);
    procedure oDBNavClick(Sender: TObject; Button: TNavigateBtn);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure ResizeKit1ExitResize(Sender: TObject; XScale, YScale: Double);
    procedure otDenoAfterInsert(DataSet: TDataSet);
    procedure otDenoBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
    // oObjRez: TReziseCntl;
  public
    { Public declarations }
  end;

var
  fDenom: TfDenom;

implementation

USES buscargen, UtilesV20;
{$R *.dfm}

procedure TfDenom.FormCreate(Sender: TObject);
begin
  // self.ResizeKit1.Enabled := utiles.Ctrl_Resize;
  // utiles.ResizeKit_DBGridEh_Prepare(self.DBGridEh1, oObjRez);
  freeandnil(oConection);
  self.PageControl1.ActivePageIndex := 0;
  self.otDeno.Connection := futilesV20.oPublicCnn;
  self.otDeno.Active := true;
  self.oDS_Deno.Enabled := true;
end;

procedure TfDenom.FormShow(Sender: TObject);
begin
  self.Activa_Objetos(false);
end;

procedure TfDenom.oActualExit(Sender: TObject);
begin
  self.calc;
end;

procedure TfDenom.oAnteriorExit(Sender: TObject);
begin
  self.calc;
end;

procedure TfDenom.oBtnAbortClick(Sender: TObject);
begin
  self.otDeno.Cancel;
  self.Action_Control(7);
  self.Activa_Objetos(false);
end;

procedure TfDenom.oBtnDeleteClick(Sender: TObject);
var
  nResp: integer;
begin
  self.Action_Control(3);
  nResp := Application.MessageBox('Seguro desea borrar?', '', MB_YESNO);
  If (nResp = ID_YES) Then
  begin
    self.oDBNav.DataSource.DataSet.Delete;
    self.oDBNav.DataSource.DataSet.Refresh;
  end;

end;

procedure TfDenom.oBtnEditClick(Sender: TObject);
begin
  self.otDeno.Edit;
  self.Activa_Objetos(true);
  self.Action_Control(2);
end;

procedure TfDenom.oBtnExitClick(Sender: TObject);
begin
  self.close;
end;

procedure TfDenom.oBtnFindClick(Sender: TObject);
begin
  self.Action_Control(4);
  Application.CreateForm(TFbuscargen, Fbuscargen);
  Fbuscargen.Hide;
  Fbuscargen.oSql1.Clear;
  Fbuscargen.oSql1.Lines.Add('SELECT den_id,den_descripcion FROM denominaciones ');
  Fbuscargen.oFieldName1.Text := 'den_id';
  Fbuscargen.oFieldName2.Text := 'den_descripcion';
  Fbuscargen.oFieldCaption1.Caption := 'Código';
  Fbuscargen.oFieldCaption2.Caption := 'Nombre';
  Fbuscargen.ShowModal;
  self.oDBNav.DataSource.DataSet.Locate('den_id', buscargen.VAR01, []);
  Fbuscargen.Free;
end;

procedure TfDenom.oBtnNewClick(Sender: TObject);
begin
  self.otDeno.Insert;
  self.oActivo.Checked := true;
  self.Action_Control(1);
  self.Activa_Objetos(true);
  self.otDeno.FieldByName('den_inactiva').AsInteger := 0;
  self.oNombre.SetFocus;
end;

procedure TfDenom.oBtnPrintClick(Sender: TObject);
begin
  self.Action_Control(5);
  ShowMessage('Opción aún no programada.');
end;

procedure TfDenom.oBtnSaveClick(Sender: TObject);
begin
  self.otDeno.Post;
  self.Action_Control(6);
  self.Activa_Objetos(false);
end;

procedure TfDenom.oChkEntradaClick(Sender: TObject);
begin
  self.calc;
end;

procedure TfDenom.oChkEntradaExit(Sender: TObject);
begin
  self.calc;
end;

procedure TfDenom.oChkSalidaClick(Sender: TObject);
begin
  self.calc;
end;

procedure TfDenom.oChkSalidaExit(Sender: TObject);
begin
  self.calc;
end;

procedure TfDenom.oDBNavClick(Sender: TObject; Button: TNavigateBtn);
begin
  self.calc;
end;

procedure TfDenom.oEntradasKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfDenom.oNombreKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfDenom.oSalidasKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfDenom.otDenoAfterInsert(DataSet: TDataSet);
begin
  DataSet.FieldByName('den_valor').AsFloat := 0.00;
  DataSet.FieldByName('den_fact_e').AsInteger := 1;
  DataSet.FieldByName('den_fact_s').AsInteger := 1;
  DataSet.FieldByName('den_inactiva').AsInteger := 0;
end;

procedure TfDenom.otDenoBeforePost(DataSet: TDataSet);
begin
  if DataSet.State IN [dsEdit, dsInsert] then
  begin
    if futilesV20.isEmpty(DataSet.FieldByName('den_descripcion').AsString) then
    begin
      ShowMessage('Para crear una denominacion es necesario el nombre de la denominación.');
      self.oNombre.SetFocus;
      abort;
    end;

    if futilesV20.isEmpty(DataSet.FieldByName('den_fact_e').AsString) then
    begin
      ShowMessage('Para crear una denominacion es necesario definir los pulsos de entrada.');
      self.oEntradas.SetFocus;
      abort;
    end;

    if futilesV20.isEmpty(DataSet.FieldByName('den_fact_s').AsString) then
    begin
      ShowMessage('Para crear una denominacion es necesario definir los pulsos de salida.');
      self.oSalidas.SetFocus;
      abort;
    end;

    if futilesV20.isEmpty(DataSet.FieldByName('den_valor').AsString) then
    begin
      ShowMessage('Para crear una denominacion es necesario definir el valor de la denominacion.');
      self.oValor.SetFocus;
      abort;
    end;

    if DataSet.State = dsEdit then
    begin
      DataSet.FieldByName('u_usuario_modif').Value := UtilesV20.sUserName;
      DataSet.FieldByName('den_fecha_Modif').Value := now();
    end
    else if DataSet.State = dsInsert then
    begin
      DataSet.FieldByName('u_usuario_alta').Value := UtilesV20.sUserName;
      DataSet.FieldByName('den_fecha_alta').Value := now();
    end;
  end;
end;

procedure TfDenom.oValorKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then { if it's an enter key }
  begin
    Key := #0; { eat enter key }
    Perform(WM_NEXTDLGCTL, 0, 0); { move to next control }
  end
end;

procedure TfDenom.ResizeKit1ExitResize(Sender: TObject; XScale, YScale: Double);
begin
  // utiles.ResizeKit_DBGridEh(self.DBGridEh1, XScale, YScale, oObjRez);
end;

procedure TfDenom.Action_Control(pOption: integer);
begin
  if ((pOption = 1) or (pOption = 2)) then
  begin
    oDBNav.Visible := false;
    oBtnNew.Visible := false;
    oBtnEdit.Visible := false;
    oBtnDelete.Visible := false;
    oBtnFind.Visible := false;
    oBtnPrint.Visible := false;
    oBtnExit.Enabled := false;
    oBtnSave.Top := oBtnNew.Top;
    oBtnSave.Left := oBtnNew.Left;

    oBtnAbort.Top := oBtnEdit.Top;
    oBtnAbort.Left := oBtnEdit.Left;

    oBtnAbort.Visible := true;
    oBtnSave.Visible := true;
    oBtnExit.Visible := false;
    oGrpPruevas.Visible := false;
    DBGridEh1.Enabled := false;
  end;

  if ((pOption = 6) or (pOption = 7)) then
  begin
    oDBNav.Visible := true;
    oBtnNew.Visible := true;
    oBtnEdit.Visible := true;
    oBtnDelete.Visible := true;
    oBtnFind.Visible := true;
    oBtnPrint.Visible := false;
    oBtnExit.Enabled := true;
    oBtnSave.Top := oBtnNew.Top;
    oBtnSave.Left := oBtnNew.Left;

    oBtnAbort.Top := oBtnEdit.Top;
    oBtnAbort.Left := oBtnEdit.Left;

    oBtnAbort.Visible := false;
    oBtnSave.Visible := false;
    oBtnExit.Visible := true;
    oGrpPruevas.Visible := true;
    DBGridEh1.Enabled := true;
  end;

end;

procedure TfDenom.calc;
var
  iAnt, iAct: integer;
  ipFac_s, ipFac_e: integer;
  itot, ipDValor: Double;
begin
  iAnt := self.oAnterior.Value;
  iAct := self.oActual.Value;
  ipFac_s := self.oSalidas.Value;
  ipFac_e := self.oEntradas.Value;
  ipDValor := self.oValor.Value;
  if (self.oChkEntrada.Checked = true) then
  begin
    if ipFac_e = 0 then
      itot := 0
    else
      itot := ((iAct - iAnt) / ipFac_e) * ipDValor;
  end
  else
  begin
    if ipFac_s = 0 then
      itot := 0
    else
      itot := ((iAct - iAnt) / ipFac_s) * ipDValor;
  end;
  self.oRespuesta.Value := itot;
end;

procedure TfDenom.DBGridEh1CellClick(Column: TColumnEh);
begin
  self.calc;
end;

procedure TfDenom.DBGridEh1DblClick(Sender: TObject);
begin
  self.calc;
end;

procedure TfDenom.Activa_Objetos(bPar: boolean);
var
  i: Word;
begin
  for i := 0 to self.ComponentCount - 1 do
  begin
    if (self.Components[i] is TDBEdit) then
      TDBEdit(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBMemo) then
      TDBMemo(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBNumberEditEh) then
    begin
      if TDBNumberEditEh(self.Components[i]).tag = 1 then
        TDBNumberEditEh(self.Components[i]).Enabled := not bPar
      else
        TDBNumberEditEh(self.Components[i]).Enabled := bPar;
    end;
    // if (self.Components[i] is TDBLookupComboboxEh) then
    // TDBLookupComboboxEh(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBCheckBoxEh) then
      TDBCheckBoxEh(self.Components[i]).Enabled := bPar;
    if (self.Components[i] is TDBCheckBox) then
      TDBCheckBox(self.Components[i]).Enabled := bPar;
  end;
  self.oID.Enabled := false;
  self.oGrpPruevas.Enabled := not bPar;
  self.DBGridEh1.Enabled := not bPar;
end;

end.
