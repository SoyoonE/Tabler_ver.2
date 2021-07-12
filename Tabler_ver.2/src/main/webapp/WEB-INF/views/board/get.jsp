<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 				prefix="c" 			%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" 				prefix="fmt" 		%>
	<jsp:include page="../includes/header.jsp"/>
		<div class="page-body">
          <div class="container-xl">
            <div class="row row-cards">
            <div class="col-md-12">
              <hr>
              <!-- 목록으로 돌아가기 버튼만들까 말까 -->
              <div class="card">
              
                <div class="card-body">
                	<!-- no. & TITLE -->
                	<input type="hidden" name="bno" value="<c:out value="${board.bno}"/>">
					<label class="form-label">TITLE</label>
                    <input type="text" readonly onfocus="this.blur()" name="title" value="<c:out value="${board.title}"/>" class="form-control" >
	            </div>
	            <div class="card-body">
	                <!-- writer -->
	                <label class="form-label">DATE</label>
	                <input type="hidden" class="form-control-plaintext" name="updatedate"  readonly onfocus="this.blur()" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate}"/>">
		            <input type="text" class="form-control" name="regdate"  readonly onfocus="this.blur()" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/>">
                </div>
	            <div class="card-body">
	                <!-- writer -->
	                <label class="form-label">WRITER</label>
	                <input type="text" readonly onfocus="this.blur()" class="form-control" name="writer" value="<c:out value="${board.writer}"/>">
                </div>
                
                <div class="card-body">
                	<!-- CONTENT -->
                	<label class="form-label">CONTENT</label>
                	<textarea readonly onfocus="this.blur()" class="form-control" name="content" rows="5"><c:out value="${board.content}"/></textarea>                
                </div>
                
                <div class="bigPictureWrapper">
                	<div class="bigPicture">
                	</div>
                </div>
                
                <div class="card-body">
                	<!-- file -->
                	<label class="form-label">FILE LIST</label>
                	<div class="uploadResult">
                		<ul class="px-0">
                			
                		</ul>
                	</div>
                </div>
                
                <!-- Button -->
                <div class="card-footer text-end">
                  <div class="float-right">
                  	
                  	<button data-oper='modify' class="btn btn-ghost-cyan">수정하기</button>
					<button data-oper='list' class="btn btn-ghost-cyan ms-auto">목록으로</button>
                  	
                  	<form id='operForm' action="/boad/modify" method="get">
					  <input type="hidden" id="bno" name="bno" value="<c:out value="${board.bno}"/>">
					  <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
					  <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
					  <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
					  <input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
					</form>
					
                  </div>
                </div>
              </div>
              
              <hr>
              
              <!-- Reply -->
              <div class="card mb-3">
                  <div class="card-header bg-cyan-lt d-flex">
                    <h3 class="card-title">Reply</h3>
					<button id='addReplyBtn' class="btn btn-ghost-cyan ms-auto">Reply</button>
					
                  </div>
				  <div> 
	                 <ul class="chat list-group list-group-flush list-group-hoverable">
	                	<!-- script -->
	                 </ul>
                  </div>
                  <div class="card-body panel-footer">
                  
                  </div>
              </div>
                 
            </div>
          </div>
        </div>
      </div>
	
	<!-- Modal -->
	<div class="modal modal-blur fade" id="myModal" tabindex="-1" style="display: none;" aria-hidden="true">
      <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">New Reply</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="row">
              <div class="col-lg-6">
                <div class="mb-3">
                  <label class="form-label">Writer</label>
                  <input type="text" class="form-control" name="replyer">
                </div>
              </div>
              <div class="col-lg-6">
                <div class="mb-3">
                  <label class="form-label">Date</label>
                  <input type="text" class="form-control" name="replyDate">
                </div>
              </div>
              <div class="col-lg-12">
                <div>
                  <label class="form-label">Reply Comment</label>
                  <input type="text" class="form-control" name="reply">
                </div>
              </div>
            </div>
          </div>
          
          <div class="modal-footer">
          	<button class="btn btn-primary" id="modalCloseBtn"  data-bs-dismiss="modal">Close</button>
          	<button class="btn btn-primary ms-auto" id="modalModBtn">Modify</button>
          	<button class="btn btn-primary" id="modalRemoveBtn">Remove</button>
            <button class="btn btn-primary ms-auto" id="modalRegisterBtn">
              <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
              <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
              Create new Reply
            </button>
            
          </div>
        </div>
      </div>
    </div>












      <script type="text/javascript" src="/resources/assets/js/reply.js"></script>
      
      
      <script>

		$(document).ready(function () {
		  
			var bnoValue = '<c:out value="${board.bno}"/>';
			var replyUL = $(".chat");
			  
			showList(1);
			    
			function showList(page){
			    
				console.log("showList"+ page);
			    replyService.getList({bno:bnoValue,page: page|| 1 }, 
				
				function(replyCnt, list) {
			      	console.log("replyCnt: "+ replyCnt);
					console.log("list: " + list);
					console.log(list);
					
					if(page == -1){
						pageNum = Math.ceil(replyCnt/10.0);
						showList(pageNum);
						return;
					}
			     	var str="";
			     
				    if(list == null || list.length == 0){
				       	return;
				    }
			     
			     for (var i = 0, len = list.length || 0; i < len; i++) {
			       str +="<li class='list-group-item' data-rno='"+list[i].rno+"'><div class='row align-items-center'><div class='col-auto'><a href='#'><span class='avatar' style='background-image: url(./static/avatars/000m.jpg)''></span></a></div><div class='col text-truncate'>";
			       str +="<a href='#' class='text-body d-block'>"+list[i].replyer+"</a>"; 
				   str +="<p class='d-block text-muted text-truncate mt-n1'>"+list[i].reply+"</p></div>";
			       str +="<div class='col-auto'><p class='text-muted small lh-base'>"
					   +replyService.displayTime(list[i].replyDate)+"</p></div></li>";
			     }
			     
			     replyUL.html(str);
				 showReplyPage(replyCnt);
			     
			   });//end function
			     
			}//end showList
		
			var pageNum = 1;
		    var replyPageFooter = $(".panel-footer");
		    
		    function showReplyPage(replyCnt){
		      
			      var endNum = Math.ceil(pageNum / 10.0) * 10;  
			      var startNum = endNum - 9; 
			      
			      var prev = startNum != 1;
			      var next = false;
			      
			      if(endNum * 10 >= replyCnt){
			        endNum = Math.ceil(replyCnt/10.0);
			      }
			      
			      if(endNum * 10 < replyCnt){
			        next = true;
			      }
			      
			      var str = "<ul class='pagination pull-right'>";
			      
			      if(prev){
			        str+= "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>Previous</a></li>";
			      }
			      
			      for(var i = startNum ; i <= endNum; i++){
			        
			        var active = pageNum == i? "active":"";
			        
			        str+= "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			      }
			      
			      if(next){
			        str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
			      }
			      
			      str += "</ul></div>";
			      
			      console.log(str);
			      
			      replyPageFooter.html(str);
			}
			replyPageFooter.on("click","li a", function(e){
			
			      e.preventDefault();
			      console.log("page click");
			       
			      var targetPageNum = $(this).attr("href");
			       
			      console.log("targetPageNum: " + targetPageNum);
			       
			      pageNum = targetPageNum;
			       
			      showList(pageNum);
		    });     
		
			var modal = $(".modal");
			var modalInputReply = modal.find("input[name='reply']");
			var modalInputReplyer = modal.find("input[name='replyer']");
			var modalInputReplyDate = modal.find("input[name='replyDate']");
			
			var modalModBtn = $("#modalModBtn");
			var modalRemoveBtn = $("#modalRemoveBtn");
			var modalRegisterBtn = $("#modalRegisterBtn");
			
			$("#addReplyBtn").on("click",function(e){
				modal.find("input").val("");
				modalInputReplyDate.closest("div").hide();
				
				modal.find("button[id !='modalCloseBtn']").hide();
				modalRegisterBtn.show();
				
				$(".modal").modal("show");
			});
			
			modalRegisterBtn.on("click",function(e){
      			
		   		var reply = {
		            reply: modalInputReply.val(),
		            replyer:modalInputReplyer.val(),
		            bno:bnoValue
		          };
				
		    	replyService.add(reply, function(result){

			        //alert(result);
	
			        modal.find("input").val("");
			        modal.modal("hide");
			        
			        showList(-1);
		        
		    	});
      
    		}); //end modalRegisterBtn

			$(".chat").on("click", "li", function(e){
      
			    var rno = $(this).data("rno");
			      
			    replyService.get(rno, function(reply){
			      	
			        modalInputReply.val(reply.reply);
			        modalInputReplyer.val(reply.replyer);
					modalInputReplyDate.show();
			        modalInputReplyDate.val(replyService.displayTime( reply.replyDate)).attr("readonly","readonly");
			        modal.data("rno", reply.rno);

			        modal.find("button[id !='modalCloseBtn']").hide();
			        modalModBtn.show();
			        modalRemoveBtn.show();
			        
			        $(".modal").modal("show");
			            
			    });
		    });//end chatClick

			modalModBtn.on("click", function(e){
    	  
			   	  var reply = {rno:modal.data("rno"), reply: modalInputReply.val()};
			   	  
			   	  replyService.update(reply, function(result){
			   	        
				   	    alert(result);
				   	    modal.modal("hide");
				   	    showList(pageNum);
				   	    
			   	  });
		   	  
		   	});//end replymodify

			modalRemoveBtn.on("click", function (e){
   	  
			   	var rno = modal.data("rno");
			   	  
			   	  replyService.remove(rno, function(result){
			   	        
			   	      alert(result);
			   	      modal.modal("hide");
			   	      showList(pageNum);
			   	      
			   	});
		   	  
		   	});

		
		});
      </script>
      
      
	  <script>
/*	  	console.log("=============");
	  	console.log("JS TEST");
	  	
	  	var bnoValue = '<c:out value="${board.bno}"/>';
		
	  	//for replyService add test
	  	replyService.add(
	  		{reply:"JS Test",reply:"tester", bno:bnoValue},
	  		function(result){
	  			alert("RESULT: " + result);
	  		}
	  	);
		
		//reply List Test
		replyService.getList({bno:bnoValue, page:1}, function(list){
			for(var i = 0, len = list.length||0; i < len; i++){
				console.log(list[i]);
			}
		});	 
		
		replyService.remove(15, function(count) {
			
			console.log(count);
			
			if(count === "success"){
				alert("REMOVED");
			}
		},function(err){
			alert("ERROR::::::::::");
		});
		
		replyService.update({
			rno : 21,
			bno : bnoValue,
			reply : "Modified Reply::::::::"
		}, function(result){
			alert("수정완료!!!!!");
		});
		
		replyService.get(10, function(data){
			console.log("dataaaaaaaaaaa"+data);
		});
*/
	  	</script>

      	<script type="text/javascript">

			$(document).ready(function() {
		  
			  	var operForm = $("#operForm"); 
			  
			  	$("button[data-oper='modify']").on("click", function(e){
			    
			    	operForm.attr("action","/board/modify").submit();
			    
			  	});
			  
			    
			 	$("button[data-oper='list']").on("click", function(e){
			    
				    operForm.find("#bno").remove();
				    operForm.attr("action","/board/list")
				    operForm.submit();
		    
		  		});  
			});
		
	  	</script>
		
		<script>
			$(document).ready(function(){
  
	  			(function(){
	  
	    		var bno = '<c:out value="${board.bno}"/>';
	    
    			$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
        
       				console.log(arr);
       
       				var str = "";
       
      	 			$(arr).each(function(i, attach){
       
			        	//image type
				        if(attach.fileType){
				        	var fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
									
							str += "<li "
							str += "data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
							str += "<div class='list-group-item'>";
							str += "<div class='row'>";
							str += "<div class='col-auto'>";
							str += "<span class='avatar  me-3' style='background-image: url(/display?fileName=" + fileCallPath + ")'></span>";
							str += "</div>";
							str += "<div class='col text-truncate d-flex align-items-center'>";
							str += "<div class='font-weight-medium'>"+ attach.fileName +"</div>";							
							str += "</div></div></div></li>";
							
						}else{
	             
	           				str += "<li "
							str += "data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'>";
							str += "<div class='list-group-item'>";
							str += "<div class='row'>";
							str += "<div class='col-auto'>";
							str += "<div class='avatar me-3'>" ; 
							str += "<svg xmlns='http://www.w3.org/2000/svg' class='icon' width='24' height='24' viewBox='0 0 24 24' stroke-width='2' stroke='currentColor' fill='none' stroke-linecap='round' stroke-linejoin='round'><path stroke='none' d='M0 0h24v24H0z' fill='none'/><path d='M14 3v4a1 1 0 0 0 1 1h4' /><path d='M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z' /><line x1='12' y1='17' x2='12.01' y2='17' /><line x1='12' y1='11' x2='12' y2='14' /></svg>" ; 
							str += "</div></div>";
							str += "<div class='col text-truncate d-flex align-items-center'>";
							str += "<div class='font-weight-medium'>"+ attach.fileName +"</div>";								
							str += "</div></div></div></li>";
						}
	       			});
       
       				$(".uploadResult ul").html(str);
       
     			});//end getjson

			})();//end function
  
			$(".uploadResult").on("click","li", function(e){
			      
			 	console.log("view image");
				    
			    var liObj = $(this);
				    
			    var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" + liObj.data("filename"));
				    
			    if(liObj.data("type")){
			      	showImage(path.replace(new RegExp(/\\/g),"/"));

			    }else {
			      	//download 
			      	self.location ="/download?fileName="+path
			    }
			    
			    
			  });
  
			  function showImage(fileCallPath){
				    
			  		alert(fileCallPath);
				    
				    $(".bigPictureWrapper").css("display","flex").show();
				    
				    $(".bigPicture")
				    .html("<img src='/display?fileName="+fileCallPath+"' >")
				    .animate({width:'100%', height: '100%'}, 1000);
			    
			  }

			  $(".bigPictureWrapper").on("click", function(e){
			    $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
			    setTimeout(function(){
			      $('.bigPictureWrapper').hide();
			    }, 1000);
			  });

			});

		</script>
		
	<jsp:include page="../includes/footer.jsp"/>