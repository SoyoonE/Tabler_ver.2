<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 				prefix="c" 			%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" 				prefix="fmt" 		%>
	<jsp:include page="../includes/header.jsp"/>
	
		<div class="page-body">
          <div class="container-xl">
            <div class="row row-cards">
            <div class="col-md-12">
            	게시물 수정
              <hr>
              	<div class="card">
	                <form role="form" action="/board/modify" method="post">
	                	<!-- paging & search -->
	                	<input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
                        <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">
		                <input type="hidden" name="keyword" value="<c:out value="${cri.keyword}"/>">
					  	<input type="hidden" name="type" value="<c:out value="${cri.type}"/>">
		                <div class="card-body">
 
							  <input type="hidden" class="form-control" name='bno' value='<c:out value="${board.bno }"/>' readonly="readonly">
						
							
							<div class="form-group">
							  <label>Title</label> 
							  <input class="form-control" name='title' value='<c:out value="${board.title }"/>' >
							</div>
							
							  <input type="hidden" class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">            
						
						</div>
						
						<div class="card-body">
							
							<div class="form-group">
							 	<label>Content</label>
							  	<textarea class="form-control" rows="3" name='content' ><c:out value="${board.content}"/></textarea>
							</div>
							
							  <input type="hidden" class="form-control" name='regdate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.regdate}" />'  readonly="readonly">            
				
							  <input type="hidden" class="form-control" name='updatedate' value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${board.updatedate}" />'  readonly="readonly">            
							

		                </div>
		                
		                <div class="card-body">
		                	<!-- file -->
		                	<div class="mb-3">								
								<label class="form-label">ADD FILE</label>
		                    	<input type="file" class="form-control" name="uploadFile" multiple>
		                    </div>
		                	<label class="form-label">FILE LIST</label>
		                	<div class="uploadResult">
		                		<ul class="px-0">
		                			
		                		</ul>
		                	</div>
		                </div>
		                
		                <div class="card-footer text-end">
		                  <div class="float-right">
		                  	  <button type="submit" class="btn btn-ghost-cyan ms-auto" data-oper='modify'> 수정하기 </button>
		                  
			                  <button type="submit" class="btn btn-ghost-cyan ms-auto" data-oper='list'>목록가기 </button>
			                  
		                      <input type="button" class="btn btn-ghost-cyan" data-bs-toggle="modal" data-bs-target="#modal-small" value="삭제하기">
		                    
		                  </div>
	                	</div>  
	                	
	              </form>
	              
	          </div>
	              
              <hr>
              
            </div>
          </div>
        </div>
      </div>
      
      <div class="modal modal-blur fade" id="modal-small" tabindex="-1" style="display: none;" aria-hidden="true">
	      <div class="modal-dialog modal-sm modal-dialog-centered" role="document">
	        <div class="modal-content">
	          <div class="modal-body">
	            <div class="modal-title">해당 글을 삭제할까요?</div>

	            <div>삭제하는 즉시 복구는 불가능 합니다.</div>
	          </div>
	          <div class="modal-footer">
	            <button type="button" class="btn btn-link link-secondary me-auto" data-bs-dismiss="modal">돌아가기</button>
	            <button type="submit" class="btn btn-cyan" data-bs-dismiss="modal" data-oper='remove'>삭제하기</button>
	          </div>
	        </div>
	      </div>
	    </div>
	    
	    <script type="text/javascript">
	    	$(document).ready(function(){
	    		
	    		var formObj = $("form");
	    		
	    		$("button").on("click",function(e){
		    	
		    		e.preventDefault();
		    		
		    		var operation = $(this).data("oper");
		    		
		    		console.log(operation);
		    		
		    		if(operation === 'remove'){
		    			formObj.attr("action","/board/remove");
		    	
		    		}else if(operation === 'list'){
						
						formObj.attr("action","/board/list").attr("method","get");
						var pageNumTag =$("input[name='pageNum']").clone();
						var amountTag = $("input[name='amount']").clone();
						var keywordTag = $("input[name='keyword']").clone();
						var typeTag = $("input[name='type']").clone();
						
						formObj.empty();
						formObj.append(pageNumTag);
						formObj.append(amountTag);
						formObj.append(keywordTag);
						formObj.append(typeTag);
						
		    		}else if(operation === 'modify'){
	        
	        			console.log("submit clicked");
	        
				        var str = "";
				        
				        $(".uploadResult ul li").each(function(i, obj){
	          
	          				var jobj = $(obj);
	          
	          				console.dir(jobj);
	          
				          	str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				          	str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				          	str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				          	str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
	          
	        			});
	        			formObj.append(str).submit();
        			}		    	
		    		formObj.submit();
	    		});
	    	});
	    </script>

		<script>

		$(document).ready(function() {
		  (function(){
		    
		    var bno = '<c:out value="${board.bno}"/>';
		    
		    $.getJSON("/board/getAttachList", {bno: bno}, function(arr){
		    
		      console.log(arr);
		      
		      var str = "";
		
		
		      $(arr).each(function(i, attach){
		          
		          //image type
		          if(attach.fileType){
		            var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
		            
		            str += "<li "
						str += "data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'data-filename='"+attach.fileName+"' data-type='"+attach.image+"'>";
						str += "<div class='list-group-item'>";
						str += "<div class='row'>";
						str += "<div class='col-auto'>";
						str += "<span class='avatar  me-3' style='background-image: url(/display?fileName=" + fileCallPath + ")'></span>";
						str += "</div>";
						str += "<div class='col text-truncate d-flex align-items-center'>";
						str += "<div class='font-weight-medium'>"+ attach.fileName +"</div>";
						str += "<button class='btn btn-icon btn-ghost-light ms-auto' data-file=\'"+fileCallPath+"\' data-type='image'>";
						str += "<svg xmlns='http://www.w3.org/2000/svg' class='icon' width='24' height='24' viewBox='0 0 24 24' stroke-width='2' stroke='currentColor' fill='none' stroke-linecap='round' stroke-linejoin='round'><path stroke='none' d='M0 0h24v24H0z' fill='none'/><line x1='18' y1='6' x2='6' y2='18' /><line x1='6' y1='6' x2='18' y2='18' /></svg>";
						str += "</button></div></div></div></li>";
			      }else{
		              
		             str += "<li "
						str += "data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"'data-filename='"+attach.fileName+"' data-type='"+attach.image+"'>";
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
		  
		  
		  $(".uploadResult").on("click", "button", function(e){
			    
		    console.log("delete file");
		      
		    if(confirm("Remove this file? ")){
		    
		      var targetLi = $(this).closest("li");
		      targetLi.remove();
		    }
		  });  
		  
		  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		  var maxSize = 5242880; //5MB
		  
		  function checkExtension(fileName, fileSize){
		    
		    if(fileSize >= maxSize){
		      alert("파일 사이즈 초과");
		      return false;
		    }
		    
		    if(regex.test(fileName)){
		      alert("해당 종류의 파일은 업로드할 수 없습니다.");
		      return false;
		    }
		    return true;
		  }
		  
		  $("input[type='file']").change(function(e){
		
		    var formData = new FormData();
		    
		    var inputFile = $("input[name='uploadFile']");
		    
		    var files = inputFile[0].files;
		    
		    for(var i = 0; i < files.length; i++){
		
		      if(!checkExtension(files[i].name, files[i].size) ){
		        return false;
		      }
		      formData.append("uploadFile", files[i]);
		      
		    }
		    
		    $.ajax({
		      url: '/uploadAjaxAction',
		      processData: false, 
		      contentType: false,data: 
		      formData,type: 'POST',
		      dataType:'json',
		        success: function(result){
		          console.log(result); 
				  showUploadResult(result); //업로드 결과 처리 함수 
		
		      }
		    }); //$.ajax
		    
		  });    
		
		  function showUploadResult(uploadResultArr){
			    
		    if(!uploadResultArr || uploadResultArr.length == 0){ return; }
		    
		    var uploadUL = $(".uploadResult ul");
		    
		    var str ="";
		    
		    $(uploadResultArr).each(function(i, obj){
				
				if(obj.image){
					var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
					str += "<li "
					str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
					str += "<div class='list-group-item'>";
					str += "<div class='row'>";
					str += "<div class='col-auto'>";
					str += "<span class='avatar  me-3' style='background-image: url(/display?fileName=" + fileCallPath + ")'></span>";
					str += "</div>";
					str += "<div class='col text-truncate d-flex align-items-center'>";
					str += "<div class='font-weight-medium'>"+ obj.fileName +"</div>";
					str += "</div></div></div></li>";
				}else{
					var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);			      
				    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				      
					str += "<li "
					str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
					str += "<div class='list-group-item'>";
					str += "<div class='row'>";
					str += "<div class='col-auto'>";
					str += "<div class='avatar me-3'>" ; 
					str += "<svg xmlns='http://www.w3.org/2000/svg' class='icon' width='24' height='24' viewBox='0 0 24 24' stroke-width='2' stroke='currentColor' fill='none' stroke-linecap='round' stroke-linejoin='round'><path stroke='none' d='M0 0h24v24H0z' fill='none'/><path d='M14 3v4a1 1 0 0 0 1 1h4' /><path d='M17 21h-10a2 2 0 0 1 -2 -2v-14a2 2 0 0 1 2 -2h7l5 5v11a2 2 0 0 1 -2 2z' /><line x1='12' y1='17' x2='12.01' y2='17' /><line x1='12' y1='11' x2='12' y2='14' /></svg>" ; 
					str += "</div></div>";
					str += "<div class='col text-truncate d-flex align-items-center'>";
					str += "<div class='font-weight-medium'>"+ obj.fileName +"</div>";
					str += "</div></div></div></li>";
				}
		
		    });
		    
		    uploadUL.append(str);
		  }
		  
		});
		
		</script>
	
	<jsp:include page="../includes/footer.jsp"/>