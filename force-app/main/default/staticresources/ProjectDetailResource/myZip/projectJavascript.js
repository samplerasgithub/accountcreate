<script type="text/Javascript">
    function getRecordDetails()
    {
    	var statusname = document.getElementById('searchbar').value;
        console.log(statusname);
        Visualforce.remoting.Manager.invokeAction(
    	'{!$RemoteAction.ProjectDetail.getCase}',
     	statusname,
        function (result, event)
        {
            if(event.status)
                {
                    
                    console.log('success');
                    var markup ='<table id="records">';
                    markup += '<tr><th>Id</th><th>Subject</th><th>Status</th><th>Priority</th></tr>';
                    for(var i=0;i<result.length;i++)
                        {
                            var recordDetail ='<tr>' +
                                 "<td>" + result[i].Id + "</td>" +
                                "<td>" + result[i].Subject + "</td>" +
                                "<td>" + result[i].Status + "</td>" +
                                "<td>" + result[i].Priority + "</td>" +
                                '</tr>';
                            markup += recordDetail;
                            }
                    document.getElementById('responseError').innerHTML = markup;
                                
                            }
                    
               
        else if(event.status==='exception')
    	{
        document.getElementById("responseError") = event.message + '<br></br>' + event.where;
        console.log('exception');
        }
            else
                {
                    document.getElementById("responseError") = event.message;
                    console.log('unhandled');
            }
            },
        {escape:true}
    );
     }
    </script>