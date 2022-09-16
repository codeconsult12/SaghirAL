// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!
query 50103 VendDimQuery
{
    QueryType = Normal;
    elements
    {
        dataitem(Vendor; Vendor)
        {
            column(No_; "No.") { }
            column(VendName; Name) { }
            dataitem(Dimension_Value; "Dimension Value")
            {

                DataItemLink = Code = Vendor."No.";
                SqlJoinType = FullOuterJoin;
                DataItemTableFilter = "Dimension Code" = filter('VENDOR');
                column(Code; Code)
                {

                }
                column(DimName; Name)
                {

                }
            }
        }
    }
}
report 50100 VendorDimensionQuery
{

    DefaultLayout = RDLC;
    RDLCLayout = 'QueryReport.rdl';
    UsageCategory = Administration;
    ApplicationArea = Basic, suite;

    dataset
    {
        dataitem(Integer; Integer)
        {
            column(VNo; VNo) { }
            column(VName; VName) { }
            column(DCode; DCode) { }
            column(DName; DName) { }

            trigger OnPreDataItem()
            begin
                VendorDimension.Open();
            end;

            trigger OnAfterGetRecord()
            begin
                if VendorDimension.Read() then begin
                    VNo := VendorDimension.No_;
                    VName := VendorDimension.VendName;
                    DCode := VendorDimension.Code;
                    DName := VendorDimension.DimName;
                end
                else begin
                    CurrReport.Skip();
                end;
            end;
        }
    }
    var
        VendorDimension: Query VendDimQuery;
        VNo: Text;
        VName: Text;
        DCode: Text;
        DName: Text;
}
