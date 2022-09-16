pageextension 50125 AVListExtend extends "Analysis View List"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(EditAnalysis)
        {
            action(CustomAnalysisByDim)
            {
                ApplicationArea = Dimensions;
                Caption = 'Analysis by Dimensions Custom';
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'View amounts in G/L accounts by their dimension values and other filters that you define in an analysis view and then show in a matrix window.';

                trigger OnAction()
                begin
                    RunAnalysisByDimensionCustomPage();
                end;
            }
        }
    }

    var
        myInt: Integer;
}