// Inicio Uso Est�ndares   :  01/08/2011
// Unidad                  :  ASO266.pas
// Formulario              :  Fverificaasociado
// Fecha de Creaci�n       :  15/05/2018
// Autor                   :  Equipo de Desarrollo de Sistemas DM
// Objetivo                :  Validaci�n de registros CADAPS
// Actualizaciones:
// HPC_201801_MAS

//Inicio HPC_201801_MAS

unit ASO266;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask;

type
  TFverificaasociado = class(TForm)
    BitGrabar: TBitBtn;
    Bitsalir: TBitBtn;
    rgvalida: TRadioGroup;
    GroupBox1: TGroupBox;
    mecomentario: TMaskEdit;
    procedure BitGrabarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitsalirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fverificaasociado: TFverificaasociado;

implementation

uses ASODM;

{$R *.dfm}

procedure TFverificaasociado.BitGrabarClick(Sender: TObject);
Var xSql, xvalida : string;
begin
   If Trim(mecomentario.Text) = '' Then
   Begin
      MessageDlg('Debe ingresar un comentario.', mtError, [mbOk], 0);
      mecomentario.SetFocus;
      Exit;
   End;
   If MessageDlg('� Seguro de actualizar registro ?' ,mtConfirmation, [mbYes, mbNo], 0) = mrYes  then
   Begin
      If rgvalida.ItemIndex = 0 Then xvalida := 'VALIDA' Else xvalida := 'NO VALIDA';
      DM1.cdsReporte.Edit;
      DM1.cdsReporte.FieldByName('REEVACADAPS').AsString := xvalida;
      DM1.cdsReporte.FieldByName('COMCHEREG').AsString := mecomentario.Text;
      DM1.cdsReporte.FieldByName('CHEREG').AsString := 'S';
      DM1.cdsReporte.FieldByName('USUCHEREG').AsString := DM1.wUsuario;
      DM1.cdsReporte.FieldByName('FECHORCHEREG').AsString := DM1.FechaHora;
      xSql := 'UPDATE ASO_VAL_CADAPS SET CHEREG = ''S'', USUCHEREG = '+QuotedStr(DM1.wUsuario)+', FECHORCHEREG = SYSDATE, COMCHEREG = '+QuotedStr(mecomentario.Text)
      +', REEVACADAPS = '+QuotedStr(xvalida)
      +' WHERE ASOID = '+QuotedStr(DM1.cdsReporte.FieldByName('ASOID').AsString)
      +' AND REGVIG = ''S''';
      DM1.DCOM1.AppServer.EjecutaSql(xSql);
      Close;
   End;
end;

procedure TFverificaasociado.FormActivate(Sender: TObject);
begin
   If  DM1.cdsReporte.FieldByName('EVACADAPS').AsString = 'VALIDA' Then
      rgvalida.ItemIndex := 0
   Else
      rgvalida.ItemIndex := 1;
end;

procedure TFverificaasociado.BitsalirClick(Sender: TObject);
begin
   Close;
end;

end.
//FIN HPC_201801_MAS
