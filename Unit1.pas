unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit;

type
  { TForm1 }
  {=
    Hoofdvenster van de FireMonkey Rekenmachine.
    Beheert de gebruikersinterface, de invoerstatus en de rekenkundige logica.
  }
  TForm1 = class(TForm)
    PrincipalLayout: TFlowLayout;
    Display: TEdit;
    MemoryButtonsGrid: TGridLayout;
    MemoryBtn0: TButton; // MC (Memory Clear)
    MemoryBtn1: TButton; // MR (Memory Recall)
    MemoryBtn2: TButton; // M+ (Memory Add)
    MemoryBtn3: TButton; // M- (Memory Subtract)
    ManageInputDataButton: TFlowLayout;
    BtnBackspace: TButton;
    BtnClearEntry: TButton;
    BtnClear: TButton;
    RegularOperationsButtons: TFlowLayout;
    BtnNegative: TButton;
    BtnDivide: TButton;
    BtnMultiply: TButton;
    BtnMinus: TButton;
    DigitsButtons: TFlowLayout;
    RegularDigitsButtons: TGridLayout;
    Btn7: TButton;
    Btn8: TButton;
    Btn9: TButton;
    Btn4: TButton;
    Btn5: TButton;
    Btn6: TButton;
    Btn1: TButton;
    Btn2: TButton;
    Btn3: TButton;
    SpecialDigitsButtons: TFlowLayout;
    Btn0: TButton;
    Btndot: TButton;
    GridLayout1: TGridLayout;
    BtnPlus: TButton;
    BtnEqual: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnDigitClick(Sender: TObject);
    procedure BtndotClick(Sender: TObject);
    procedure BtnOpClick(Sender: TObject);
    procedure BtnEqualClick(Sender: TObject);
    procedure BtnClearClick(Sender: TObject);
    procedure BtnClearEntryClick(Sender: TObject);
    procedure BtnBackspaceClick(Sender: TObject);
    procedure BtnNegativeClick(Sender: TObject);
    procedure MemoryBtnClick(Sender: TObject);
  private
    FCurrentValue: Double;    /// <summary>De opgeslagen tussenwaarde voor de huidige berekening.</summary>
    FMemoryValue: Double;     /// <summary>De waarde die in het interne geheugen (MC/MR/M+/M-) zit.</summary>
    FActiveOperation: string; /// <summary>De actieve wiskundige bewerking (+, -, *, /).</summary>
    FIsNewValue: Boolean;     /// <summary>Geeft aan of de volgende cijferinvoer het display moet overschrijven.</summary>

    /// <summary>Voert de opgeslagen wiskundige bewerking uit op de huidige displaywaarde.</summary>
    procedure Calculate;

    /// <summary>Veilige methode om de tekst in het display-veld bij te werken.</summary>
    /// <param name="AText">De string die getoond moet worden.</param>
    procedure UpdateDisplay(const AText: string);
  public
    /// <summary>Geeft een geformatteerde handleiding terug voor de rekenmachine.</summary>
    function GetHelpText: string;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}
{$R *.iPad.fmx IOS}
{$R *.iPhone.fmx IOS}
{$R *.iPhone47in.fmx IOS}
{$R *.XLgXhdpiTb.fmx ANDROID}
{$R *.GGlass.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}
{$R *.Macintosh.fmx MACOS}
{$R *.Surface.fmx MSWINDOWS}

/// <summary>
/// Initialiseert de rekenmachine bij het opstarten van het formulier.
/// </summary>
procedure TForm1.FormCreate(Sender: TObject);
begin
  // Reset de rekenmachine naar de beginstand
  BtnClearClick(Self);
  FMemoryValue := 0.0;
end;

/// <summary>
/// Updatet het tekstveld van het display.
/// </summary>
procedure TForm1.UpdateDisplay(const AText: string);
begin
  Display.Text := AText;
end;

/// <summary>
/// Universele eventhandler voor alle cijferknoppen (0 t/m 9).
/// </summary>
procedure TForm1.BtnDigitClick(Sender: TObject);
var
  Digit: string;
begin
  if not (Sender is TButton) then Exit;
  Digit := TButton(Sender).Text;

  // Als er net op een bewerking is geklikt, of het display staat op '0', overschrijf de tekst
  if FIsNewValue or (Display.Text = '0') then
  begin
    UpdateDisplay(Digit);
    FIsNewValue := False;
  end
  else
  begin
    // Anders voegen we het cijfer achteraan toe
    UpdateDisplay(Display.Text + Digit);
  end;
end;

/// <summary>
/// Voegt een decimaal scheidingsteken toe, rekening houdend met de Windows/Systeeminstellingen.
/// </summary>
procedure TForm1.BtndotClick(Sender: TObject);
begin
  // Als we met een nieuw getal beginnen en direct op de punt drukken, maak er '0,' of '0.' van
  if FIsNewValue then
  begin
    UpdateDisplay('0' + FormatSettings.DecimalSeparator);
    FIsNewValue := False;
    Exit;
  end;

  // Voorkom dat er meerdere komma's/punten in één getal worden getypt
  if not Display.Text.Contains(FormatSettings.DecimalSeparator) then
    UpdateDisplay(Display.Text + FormatSettings.DecimalSeparator);
end;

/// <summary>
/// Handelt de druk op een bewerkingsknop (+, -, *, /) af.
/// </summary>
procedure TForm1.BtnOpClick(Sender: TObject);
begin
  if not (Sender is TButton) then Exit;

  try
    // Kettingberekening: als er al een bewerking klaarstond, bereken die dan eerst
    if FActiveOperation <> '' then
      Calculate;

    FCurrentValue := StrToFloat(Display.Text);
    FActiveOperation := TButton(Sender).Text;
    FIsNewValue := True; // Volgende invoer start een nieuw getal
  except
    on E: EConvertError do UpdateDisplay('Fout');
  end;
end;

/// <summary>
/// Voert de daadwerkelijke rekenkundige bewerking uit.
/// </summary>
procedure TForm1.Calculate;
var
  SecondValue: Double;
begin
  try
    SecondValue := StrToFloat(Display.Text);

    if FActiveOperation = '+' then
      FCurrentValue := FCurrentValue + SecondValue
    else if FActiveOperation = '-' then
      FCurrentValue := FCurrentValue - SecondValue
    else if FActiveOperation = '*' then
      FCurrentValue := FCurrentValue * SecondValue
    else if FActiveOperation = '/' then
    begin
      // Specifieke afhandeling voor de wiskundige fout: delen door nul
      if SecondValue = 0 then
      begin
        UpdateDisplay('Kan niet delen door 0');
        FActiveOperation := '';
        FIsNewValue := True;
        Exit;
      end;
      FCurrentValue := FCurrentValue / SecondValue;
    end;

    // Toon het resultaat op het display
    UpdateDisplay(FloatToStr(FCurrentValue));
  except
    on E: Exception do UpdateDisplay('Fout');
  end;
end;

/// <summary>
/// Eventhandler voor de Is-gelijk-aan knop (=). Rondt de lopende berekening af.
/// </summary>
procedure TForm1.BtnEqualClick(Sender: TObject);
begin
  if FActiveOperation = '' then Exit;
  Calculate;
  FActiveOperation := '';
  FIsNewValue := True;
end;

/// <summary>
/// Wisselt het teken van het huidige getal op het display (+/-).
/// </summary>
procedure TForm1.BtnNegativeClick(Sender: TObject);
var
  Value: Double;
begin
  try
    Value := StrToFloat(Display.Text);
    if Value <> 0 then
      UpdateDisplay(FloatToStr(-Value));
  except
    on E: EConvertError do ;
  end;
end;

/// <summary>
/// Verwijdert het laatste karakter van de huidige invoer (Backspace).
/// </summary>
procedure TForm1.BtnBackspaceClick(Sender: TObject);
var
  CurrentText: string;
begin
  CurrentText := Display.Text;
  if CurrentText.Length > 0 then
  begin
    // Verwijder het allerlaatste karakter uit de string
    Delete(CurrentText, CurrentText.Length, 1);

    // Als het display nu leeg is of alleen een minteken bevat, reset naar '0'
    if (CurrentText = '') or (CurrentText = '-') then
      CurrentText := '0';

    UpdateDisplay(CurrentText);
  end;
end;

/// <summary>
/// Wist de huidige invoer (CE - Clear Entry), maar behoudt de lopende berekening.
/// </summary>
procedure TForm1.BtnClearEntryClick(Sender: TObject);
begin
  UpdateDisplay('0');
  FIsNewValue := True;
end;

/// <summary>
/// Reset de volledige rekenmachine (C - Clear) naar de nulstand.
/// </summary>
procedure TForm1.BtnClearClick(Sender: TObject);
begin
  FCurrentValue := 0.0;
  FActiveOperation := '';
  FIsNewValue := True;
  UpdateDisplay('0');
end;

/// <summary>
/// Centrale verwerking voor alle vier de geheugenknoppen (MC, MR, M+, M-).
/// </summary>
procedure TForm1.MemoryBtnClick(Sender: TObject);
var
  BtnName: string;
begin
  if not (Sender is TButton) then Exit;
  BtnName := TButton(Sender).Name;

  try
    { MemoryBtn0 = MC (Memory Clear) -> Wist het geheugen }
    if BtnName = 'MemoryBtn0' then
      FMemoryValue := 0.0

    { MemoryBtn1 = MR (Memory Recall) -> Haalt de waarde op uit het geheugen }
    else if BtnName = 'MemoryBtn1' then
    begin
      UpdateDisplay(FloatToStr(FMemoryValue));
      FIsNewValue := True;
    end

    { MemoryBtn2 = M+ (Memory Add) -> Tel huidige displaywaarde op bij het geheugen }
    else if BtnName = 'MemoryBtn2' then
    begin
      FMemoryValue := FMemoryValue + StrToFloat(Display.Text);
      FIsNewValue := True;
    end

    { MemoryBtn3 = M- (Memory Subtract) -> Trek huidige displaywaarde af van het geheugen }
    else if BtnName = 'MemoryBtn3' then
    begin
      FMemoryValue := FMemoryValue - StrToFloat(Display.Text);
      FIsNewValue := True;
    end;
  except
    on E: EConvertError do ;
  end;
end;

/// <summary>
/// Genereert een gestructureerde helptekst met uitleg over alle knoppen.
/// </summary>
function TForm1.GetHelpText: string;
begin
  Result :=
    '=== REKENMACHINE GEBRUIKERSHANDLEIDING ===' + sLineBreak + sLineBreak +
    'BASISFUNCTIES:' + sLineBreak +
    '* [0-9] : Voert cijfers in.' + sLineBreak +
    '* [.]   : Voegt een decimaal scheidingsteken toe.' + sLineBreak +
    '* [+/-] : Wisselt het getal tussen positief en negatief.' + sLineBreak +
    '* [=]   : Berekent het eindresultaat.' + sLineBreak + sLineBreak +
    'BEWERKINGEN:' + sLineBreak +
    '* [+] : Optellen' + sLineBreak +
    '* [-] : Aftrekken' + sLineBreak +
    '* [*] : Vermenigvuldigen' + sLineBreak +
    '* [/] : Delen (Delen door 0 geeft een foutmelding)' + sLineBreak + sLineBreak +
    'CORRECTIE & RESET:' + sLineBreak +
    '* [⌫ Backspace] : Verwijdert het laatst getypte cijfer.' + sLineBreak +
    '* [CE]: Wist de huidige invoer (Clear Entry).' + sLineBreak +
    '* [C]: Wist de gehele berekening en reset het display (Clear).' + sLineBreak + sLineBreak +'GEHEUGENFUNCTIES (Memory):' + sLineBreak +
    '* [MemoryBtn0] (MC) : Wist het opgeslagen geheugen (Memory Clear).' + sLineBreak +
    '* [MemoryBtn1] (MR) : Haalt het getal uit het geheugen op (Memory Recall).' + sLineBreak +
    '* [MemoryBtn2] (M+) : Tel huidige displaywaarde op bij het geheugen.' + sLineBreak +
    '* [MemoryBtn3] (M-) : Trek huidige displaywaarde af van het geheugen.';
end;

end.




