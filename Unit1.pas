unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    PrincipalLayout: TFlowLayout;
    Display: TEdit;
    MemoryButtonsGrid: TGridLayout;
    MemoryBtn0: TButton;
    MemoryBtn1: TButton;
    MemoryBtn2: TButton;
    MemoryBtn3: TButton;
    ManageInputDataButton: TFlowLayout;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    RegularOperationsButtons: TFlowLayout;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    DigitsButtons: TFlowLayout;
    RegularDigitsButtons: TGridLayout;
    Button8: TButton;
    Button9: TButton;
    Button10: TButton;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    SpecialDigitsButtons: TFlowLayout;
    Button17: TButton;
    Button18: TButton;
    GridLayout1: TGridLayout;
    Button19: TButton;
    Button20: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
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

end.
