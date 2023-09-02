<%-- 
    Document   : index
    Created on : 2 ก.ย. 2566, 6:34:10
    Author     : Gus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Bootstrap demo</title>
        <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
        <link href="https://cdn.datatables.net/v/bs5/jszip-3.10.1/dt-1.13.6/af-2.6.0/b-2.4.2/b-colvis-2.4.2/b-html5-2.4.2/b-print-2.4.2/cr-1.7.0/date-1.5.1/fc-4.3.0/fh-3.4.0/kt-2.10.0/r-2.5.0/rg-1.4.0/rr-1.4.1/sc-2.2.0/sb-1.5.0/sp-2.2.0/sl-1.7.0/sr-1.3.0/datatables.min.css" rel="stylesheet">
        
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/pdfmake.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.2.7/vfs_fonts.js"></script>
        <script src="https://cdn.datatables.net/v/bs5/jszip-3.10.1/dt-1.13.6/af-2.6.0/b-2.4.2/b-colvis-2.4.2/b-html5-2.4.2/b-print-2.4.2/cr-1.7.0/date-1.5.1/fc-4.3.0/fh-3.4.0/kt-2.10.0/r-2.5.0/rg-1.4.0/rr-1.4.1/sc-2.2.0/sb-1.5.0/sp-2.2.0/sl-1.7.0/sr-1.3.0/datatables.min.js"></script>
        
    </head>
    <body>
        <div class="h3 text-center mt-3" >
            Test ServerSide
        </div>
        <div class="container">
            <table class="table table-bordered w-100" id="table_user">
                
            </table>
        </div>
        
        <script>
            
            function gettableuser(){
                $("#table_user").DataTable({
                    serverSide: true,
                    scrollX: true,
                    ajax: {
                        type:"post",
                        url:"User",
                        data:{
                            type:"gettableuser"
                        },
                        dataSrc:function(json){
                            var arr = [];
                            var data = JSON.parse(json.data);
                            console.log(data);
                            
                            $.each(data,function(k,v){
                                
                                var result = {
                                    user_id:v.user_id,
                                    user_user:v.user_user,
                                    user_pass:v.user_pass,
                                    user_name:v.user_name
                                }
                                arr.push(result);
                            
                            })
                            return arr
                        }
                    },
                    columns: [
                       
                        {
                            title : 'ID',
                            data : 'user_id'
                        },
                        {
                            title:'User',
                            data : 'user_user' 
                        },
                        {
                            title:'Pass',
                            data : 'user_pass' 
                        },
                        {
                            title:'Name',
                            data : 'user_name' 
                        },
                        
                                      
                        
                    ],
                   
                    
                    bDestroy: true
                  
                          
                });
            }
            
            $(document).ready(function(){
                gettableuser()
            });
            
            
            
            
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    </body>
</html>
