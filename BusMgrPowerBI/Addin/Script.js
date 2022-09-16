var controlAddIn = document.getElementById('controlAddIn');
controlAddIn.innerHTML= "<a download='somedata.csv' href='#' onclick='return ExcellentExport.csv(this, 'datatable');'>Export to CSV<//a><br/>";
//controlAddIn.innerHTML = "<iframe src='https://app.powerbi.com/reportEmbed?reportId=3191edb5-7527-452b-a188-e8b15e8f12a3&amp;config=eyJjbHVzdGVyVXJsIjoiaHR0cHM6Ly9XQUJJLVVTLU5PUlRILUNFTlRSQUwtQi1yZWRpcmVjdC5hbmFseXNpcy53aW5kb3dzLm5ldCIsImVtYmVkRmVhdHVyZXMiOnsibW9kZXJuRW1iZWQiOmZhbHNlfX0%3d&amp;filterPaneEnabled=false&amp;navContentPaneEnabled=false' width='100%' height='320' frameborder='0'></iframe>";

//parent.document.getElementsByClassName('ms-nav-band')[0].style.display='none';





function run() {
    var iframe = parent.document.querySelector("[title='WebReportViewer']");
    if (iframe != null) {
  //      clearInterval(interval);
 //   }
   // else {
        var elem = iframe.contentWindow.document.querySelector("[seamless='seamless']");
    //    alert(elem.getAttribute('width'));
        elem.setAttribute("width", "100%");
        elem.setAttribute("height","1080px");
        sleep(15000);
        //iframe.removeAttribute('src');

    }
}

const interval = setInterval(run, 2000);




<a download="somedata.csv" href="#" onclick="return ExcellentExport.csv(this, 'datatable');">Export to CSV</a>
