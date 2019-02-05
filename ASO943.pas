// Inicio Uso Est�ndares : 01/08/2011
// Unidad                : ASO943
// Formulario            : fDatosSocEco
// Fecha de Creaci�n     : 15/05/2018
// Autor                 : Equipo de Sistemas
// Objetivo		           : DATOS SOCIO ECON�MICOS
// Actualizaciones:
// HPC_201801_MAS

//Inicio HPC_201801_MAS
Unit ASO943;

Interface

Uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, ExtCtrls, wwdblook, Mask, wwdbedit, Buttons, Grids,
   Wwdbigrd, Wwdbgrid, ComCtrls, Wwdbdlg, Spin, wwIDlg, DB;

Type
   TfDatosSocEco = Class(TForm)
      dtgDetalles: TwwDBGrid;
      dtgDetallesIButton: TwwIButton;
      bbtnSalirDatLab: TBitBtn;
      Procedure FormKeyPress(Sender: TObject; Var Key: Char);
      Procedure FormCreate(Sender: TObject);
      Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
      Procedure bbtnSalirDatLabClick(Sender: TObject);
      Procedure dtgDetallesIButtonClick(Sender: TObject);
      Procedure dtgDetallesDblClick(Sender: TObject);
   Private
    { Private declarations }
   Public
    { Public declarations }
      wEsIngreso, wCrea: boolean;
   End;

Var
   fDatosSocEco: TfDatosSocEco;

Implementation

Uses ASODM, ASO900, ASO943b; 

{$R *.dfm}

Procedure TfDatosSocEco.FormKeyPress(Sender: TObject; Var Key: Char);
Begin
   If Key = #13 Then
   Begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
   End;
End;

Procedure TfDatosSocEco.FormCreate(Sender: TObject);
Var
   xSQL, xIndice: String;
Begin
// hist�rico de datos Socio-Econ�micos
   xSQL := 'SELECT A.ASOID, A.ITEM, '
      + '     case when A.IDE_PAD is not null then ''POR PADR�N'' else ''POR BOLETA'' end TIPO_ACTUALIZAC, '
      + '     A.IDE_PAD, A.PERIODO, '
      + '     A.ASOCODMOD, '
      + '     A.CONVIVID, D.TIPVIVABR, '
      + '     A.INMUEBLE, A.VEHICULO, A.ANO_VEHICULO, '
      + '     A.GRAINSTID, C.GRAINSABR, '
      + '     A.ESTCIVID, B.ESTCIVDES, '
      + '     A.CRGFAMID, E.PARENABR, '
      + '     A.NROHIJOS, A.TIPPROID, '
      + '     case when TIPPROID=''01'' then ''Casa'' '
      + '          when TIPPROID=''02'' then ''Terreno'' '
      + '          when TIPPROID=''03'' then ''Local Comercial '' '
      + '          else TIPPROID '
      + '     end TIPPRO_DES, '
      + '     A.CARLAB, F.DES_SIT CARLAB_DES, ' // Cargo Laboral
      + '     A.SITACT, G.DES_SIT SITACT_DES, ' // Situaci�n Laboral
      + '     A.TIPSER, H.DES_SIT TIPSER_DES, ' // Tipo de Servidor
      + '     A.AINGFAM, ' // Bruto
      + '     A.AINGMAG, ' // Neto
      + '     A.USUARIO, '
      + '     A.FREG, A.HREG, '
      + '     A.AINGCON, A.RESFVIF '
      + ' FROM APO206 A, TGE125 B, TGE119 C, APO109 D, TGE149 E, '
      + ' (select COD_SIT, DES_SIT from ASO_PAD_SIT_ASO where COD_MAE=''03'' and COD_SIT is not null) F, ' // CARGO_LABORAL
      + ' (select COD_SIT, DES_SIT from ASO_PAD_SIT_ASO where COD_MAE=''02'' and COD_SIT is not null) G, ' // SIT_TRABAJADOR
      + ' (select COD_SIT, DES_SIT from ASO_PAD_SIT_ASO where COD_MAE=''01'' and COD_SIT is not null) H ' // TIPO_SERVIDOR
      + ' WHERE A.ASOID = ' + QuotedStr(DM1.cdsAso.FieldByName('ASOID').AsString)
      + '   and B.ESTCIVID(+)=A.ESTCIVID '
      + '   and C.GRAINSID(+)=A.GRAINSTID '
      + '   and D.TIPVIVID(+)=A.CONVIVID '
      + '   and E.PARENID(+)=A.CRGFAMID '
      + '   and F.COD_SIT(+)=A.CARLAB '
      + '   and G.COD_SIT(+)=A.SITACT '
      + '   and H.COD_SIT(+)=A.TIPSER '
      + ' ORDER BY A.HREG DESC ';
   DM1.cdsDSocioE.Close;
   DM1.cdsDSocioE.DataRequest(xSQL);
   DM1.cdsDSocioE.Open;

   dtgDetalles.Selected.Clear;
   dtgDetalles.Selected.Add('ITEM'#9'6'#9'Correlativo'#9#9);
   dtgDetalles.Selected.Add('TIPO_ACTUALIZAC'#9'12'#9'Tipo de~Actualizaci�n'#9#9);
   dtgDetalles.Selected.Add('IDE_PAD'#9'12'#9'Identificador~Padr�n'#9#9);
   dtgDetalles.Selected.Add('PERIODO'#9'12'#9'Periodo'#9#9);
   dtgDetalles.Selected.Add('ASOCODMOD'#9'10'#9'C�digo~Modular'#9#9);
   dtgDetalles.Selected.Add('TIPVIVABR'#9'15'#9'Condici�n de~la Vivienda'#9#9);
   dtgDetalles.Selected.Add('INMUEBLE'#9'10'#9'Tipo de~Negocio'#9#9);
   dtgDetalles.Selected.Add('VEHICULO'#9'15'#9'Veh�culo'#9#9);
   dtgDetalles.Selected.Add('ANO_VEHICULO'#9'10'#9'A�o~Veh�culo'#9#9);
   dtgDetalles.Selected.Add('GRAINSABR'#9'10'#9'Grado de~Instrucci�n'#9#9);
   dtgDetalles.Selected.Add('ESTCIVDES'#9'10'#9'Estado~Civil'#9#9);
   dtgDetalles.Selected.Add('PARENABR'#9'20'#9'Carga~Familiar'#9#9);
   dtgDetalles.Selected.Add('NROHIJOS'#9'9'#9'N�mero de~Hijos'#9#9);
   dtgDetalles.Selected.Add('TIPPRO_DES'#9'20'#9'Tipo de~Propiedad'#9#9); // 01=Casa, 02=Terreno, 03=Local Comercial
   dtgDetalles.Selected.Add('AINGFAM'#9'12'#9'Ingreso~Bruto'#9#9);
   dtgDetalles.Selected.Add('AINGMAG'#9'13'#9'Ingreso~Neto'#9#9);
   dtgDetalles.Selected.Add('CARLAB'#9'10'#9'Cargo~Laboral ID'#9#9);
   dtgDetalles.Selected.Add('CARLAB_DES'#9'20'#9'Cargo~Laboral'#9#9);
   dtgDetalles.Selected.Add('SITACT'#9'10'#9'Situaci�n~Laboral ID'#9#9);
   dtgDetalles.Selected.Add('SITACT_DES'#9'20'#9'Situaci�n~Laboral'#9#9);
   dtgDetalles.Selected.Add('TIPSER'#9'10'#9'Tipo~Servidor ID'#9#9);
   dtgDetalles.Selected.Add('TIPSER_DES'#9'20'#9'Tipo~Servidor'#9#9);
   dtgDetalles.Selected.Add('USUARIO'#9'10'#9'Usuario~que Registra'#9#9);
   dtgDetalles.Selected.Add('HREG'#9'21'#9'Fecha~�lt.Reg'#9#9);

   dtgDetalles.ApplySelected;

   xSQL := 'select COD_SIT, DES_SIT '
      + 'from ASO_PAD_SIT_ASO '
      + 'where COD_MAE=''03'' and COD_SIT is not null ';
   DM1.cdsQry8.Close;
   DM1.cdsQry8.DataRequest(xSQL);
   DM1.cdsQry8.Open;

   xSQL := 'select COD_SIT, DES_SIT '
      + 'from ASO_PAD_SIT_ASO '
      + 'where COD_MAE=''02'' and COD_SIT is not null ';
   DM1.cdsQry6.Close;
   DM1.cdsQry6.DataRequest(xSQL);
   DM1.cdsQry6.Open;

   xSQL := 'select COD_SIT, DES_SIT '
      + 'from ASO_PAD_SIT_ASO '
      + 'where COD_MAE=''01'' and COD_SIT is not null ';
   DM1.cdsTPension.Close;
   DM1.cdsTPension.DataRequest(xSQL);
   DM1.cdsTPension.Open;

End;

Procedure TfDatosSocEco.FormClose(Sender: TObject;
   Var Action: TCloseAction);
Begin
   DM1.cdsQry.Close;
   DM1.cdsTZona.Close;
   DM1.cdsDSocioE.Close;
   DM1.cdsQry4.Close;
   DM1.cdsQry8.Close;
   DM1.cdsQry6.Close;
   DM1.cdsTPension.Close;
End;

Procedure TfDatosSocEco.bbtnSalirDatLabClick(Sender: TObject);
Begin
   Close;
End;

Procedure TfDatosSocEco.dtgDetallesIButtonClick(Sender: TObject);
Begin
   wCrea := True;
   wEsIngreso := True;
   Try
      FDatosSocEcoxReg := TFDatosSocEcoxReg.create(self);
      FDatosSocEcoxReg.Showmodal;
   Finally
      FDatosSocEcoxReg.free;
   End;
End;

Procedure TfDatosSocEco.dtgDetallesDblClick(Sender: TObject);
Begin
   wCrea := True;
   wEsIngreso := False;
   Try
      FDatosSocEcoxReg := TFDatosSocEcoxReg.create(self);
      FDatosSocEcoxReg.Showmodal;
   Finally
      FDatosSocEcoxReg.free;
   End;
End;

End.
//FIN HPC_201801_MAS
