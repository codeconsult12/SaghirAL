// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

query 50113 LineCountAPI
{
    QueryType = Normal;

    elements
    {

        dataitem(Gen__Journal_Batch; "Gen. Journal Batch")
        {
            column(Name; Name)
            {

            }
            column(Journal_Template_Name; "Journal Template Name") { }
            column(Description; Description) { }

            dataitem(GenJournalLine; "Gen. Journal Line")
            {
                DataItemLink = "Journal Batch Name" = Gen__Journal_Batch.Name;
                SqlJoinType = LeftOuterJoin;
                DataItemTableFilter = "Account No." = filter(<> '');

                column(Counts)
                {
                    Method = Count;
                }

                /*column(JournalBatchName; "Journal Batch Name")
                {
                }
*/
                //column(Document_No_; "Document No.") { }
                /*column(DocumentNo; "Document No.")
                {

                }*/
                /*column(Account_No_; "Account No.")
                {
                    ColumnFilter = Account_No_ = filter(= '');
                }*/

            }
        }

        /*        dataitem(GenJournalLine; "Gen. Journal Line")
                {
                    DataItemTableFilter = "Document No." = filter(<> '');
                    column(Counts)
                    {
                        Method = Count;
                    }
                    column(DocumentType; "Document Type")
                    {
                    }
                    column(JournalBatchName; "Journal Batch Name")
                    {
                    }

                    column(JournalTemplateName; "Journal Template Name") { }
                    //column(Document_No_; "Document No.") { }
                    column(DocumentNo; "Document No.")
                    {

                    }
                }*/
    }
}

table 50110 JournalLineCount
{
    fields
    {
        field(1; id; Integer)
        {
        }
        field(2; "Document Type"; Option)
        {
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(3; "Journal Batch Name"; Text[100])
        {

        }
        field(4; "Journal Template Name"; Text[50])
        {

        }
        field(5; "Document No."; Text[50])
        {

        }
        field(6; "Count"; Integer)
        {

        }
    }

    keys
    {
        key(PK; id)
        {
            Clustered = true;
        }
    }
}
page 50111 BatchJournals
{
    PageType = List;
    Caption = 'Unposted Journals';
    ApplicationArea = basic;
    UsageCategory = Lists;
    SourceTable = JournalLineCount;
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Journal Batch Name"; "Journal Batch Name")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    begin
                    end;
                }
                field("Count"; "Count") { ApplicationArea = all; }
                field("Journal Type"; "Journal Template Name")
                {
                    Caption = 'Journal Type';
                    ApplicationArea = all;
                }

            }
        }
        area(Factboxes)
        {

        }
    }
    var
        QueBatch: Query LineCountAPI;

    trigger OnOpenPage()
    var
        //res:Dialog;
        tempBatchName: Text;

        VJsonArray: JsonArray;
        VJsonArrayLines: JsonArray;

        jToken: JsonToken;
        jObj: JsonObject;
        i: Integer;

        dict: Dictionary of [Text, Integer];
        lstKeys: List of [text];

        str: Text;
        counter: Integer;
        splits: list of [Text];
    begin
        QueBatch.Open();

        while QueBatch.Read() do begin

            str := QueBatch.Journal_Template_Name + ',' + QueBatch.Name;
            if dict.ContainsKey(str) then begin
                counter := dict.Get(str);
                dict.Set(str, counter + 1);
            end else begin
                dict.Add(str, 1);
            end;




        end;
        lstKeys := dict.Keys;
        for i := 1 to lstKeys.Count do begin
            str := lstKeys.Get(i);
            "Count" := dict.get(str);
            splits := str.Split(',');
            "Journal Template Name" := splits.get(1);
            "Journal Batch Name" := splits.Get(2);
            id := i;
            Insert();
        end;
        //if not FindFirst() then begin
        //Error('There are no journals waiting to be posted');
        //res.Close();
        //end
        //else
        //FindFirst();

    end;

    trigger OnAfterGetRecord()
    begin
        if not QueBatch.Read() then
            exit
    end;

    trigger OnClosePage()
    begin
        QueBatch.Close();
    end;


}

pageextension 50112 "Bus. Mgr. Role Center" extends "Business Manager Role Center"
{
    layout
    {
        modify(Control16)
        {
            Visible = false;
        }
        addafter(Control16)
        //        addbefore()
        {
            part(Journals; BatchJournals)
            {
                ApplicationArea = All;
                Caption = ' Unposted Journals';
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        /*addafter("Excel Reports")
        {
            action("PowerBI Management")
            {
                ApplicationArea = All;
                Image = Account;
                Promoted = true;
                PromotedCategory = Report;
                RunObject = page "Power BI Management";

            }
        }*/
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}