tableextension 50124 AnalysisViewExtend extends "Analysis View"
{
    procedure RunAnalysisByDimensionCustomPage()
    var
        AnalysisByDimParameters: Record "Analysis by Dim. Parameters" temporary;
    begin
        AnalysisByDimParameters."Analysis View Code" := Code;
        AnalysisByDimParameters.Insert();
        PAGE.RUN(PAGE::AnalysisByDimensionsCustom, AnalysisByDimParameters);
    end;
}
