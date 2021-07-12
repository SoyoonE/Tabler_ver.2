<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 				prefix="c" 			%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" 				prefix="fmt" 		%>
	<jsp:include page="../includes/header.jsp"/>
		<div class="container-xl"> 
          <!-- Page title -->
          <div class="page-header d-print-none">
            <div class="row align-items-center">
              <div class="col">
                <h2 class="page-title">
                  새로운 글 작성하기
                </h2>
              </div>
            </div>
          </div>
        </div>
        <form role="form" action="/board/register" method="post">
	         <div class="page-body">
		         <div class="container-xl">
		            <div class="row row-deck row-cards">
						<div class="col-12">
							<div class="card">
	                        	<div class="card-body">
	                        		<label class="form-label">TITLE</label>
	                                <input type="text" class="form-control " name="title" placeholder="제목을 입력합니다">
	                            </div>
	                            <div class="card-body">
	                        		<label class="form-label">WRITER</label>
	                                <input type="text" class="form-control " name="writer" placeholder="글쓴이">
	                            </div>
	                            <div class="card-body">
	                                <div class="mb-3">
		                            	<label class="form-label">CONTENT<span class="form-label-description">0/1000</span></label>
		                            	<textarea class="form-control" name="content" data-bs-toggle="autosize" rows="6" placeholder="내용을 입력합니다"></textarea>
		                            </div>
	                            </div>



	                            <div class="card-body">
	                                <div class="mb-3">								
									<label class="form-label">FILE</label>
		                            <input type="file" class="form-control" name="uploadFile" multiple>
		                            </div>
		                            <div class="uploadResult">
		                            	<div class="mb-3">										
			                            <label class="form-label">FILE LIST</label>
			                            <div class="form-selectgroup form-selectgroup-boxes d-flex flex-column">
										  <ul class="px-0">
											<!-- <li>										
				                              <div class="list-group-item">
							                      <div class="row">
							                        <div class="col-auto">
							                            <span class="avatar" style="background-image: url(./static/avatars/023f.jpg)"></span>
							                        </div>
							                        <div class="col text-truncate d-flex align-items-center">
							                          <div class="font-weight-medium">FILENAME</div>
							                          <button class="btn btn-icon btn-ghost-light ms-auto">
														<svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></svg>
							                          </button>
							                        </div>
							                      </div>
							                    </div>
			                             	</li> -->
			                              </ul>
			                            </div>
			                          </div>
		                            </div>
	                            </div>




	                            <!-- Card footer -->
	                            <div class="card-footer">	                            
	                            	<div class="d-flex">
		                            	<label class="form-check mb-2">
			                            	<input class="form-check-input" type="checkbox" checked="">
			                              	<span class="form-check-label">
			                               		댓글 허용
			                              	</span>
			                              	<span class="form-check-description">
			                                	다른 사용자들이 해당 게시글에 댓글을 달 수 있습니다.
			                              	</span>  
			                            </label>
	                            		<div class="btn-list ms-auto">
	                            			<button type="reset" class="btn btn-primary">Reset</button>
	                            			<button type="submit" class="btn btn-primary">Submit</button>
	                            		</div>
	                            	</div>
	                            </div>
	                    	</div>
	                    </div>
		         	</div>
		         </div>
	        </div>
        </form>  
        
	<script type="text/javascript">
	
		$(document).ready(function(e){
	
			var formObj = $("form[role='form']");
		
			$("button[type='submit']").on("click", function(e){
				e.preventDefault();
	    
	    		console.log("submit clicked");
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i,obj){
				
					var jobj = $(obj);
					
					console.dir(jobj);
					console.log("-------------------------");
      				console.log(jobj.data("filename"));

					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
				    str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				    str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
				    str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";

				});
				console.log(str);
				formObj.append(str).submit();
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
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
						
						str += "<li "
						str += "data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"'data-filename='"+obj.fileName+"' data-type='"+obj.image+"'>";
						str += "<div class='list-group-item'>";
						str += "<div class='row'>";
						str += "<div class='col-auto'>";
						str += "<span class='avatar  me-3' style='background-image: url(/display?fileName=" + fileCallPath + ")'></span>";
						str += "</div>";
						str += "<div class='col text-truncate d-flex align-items-center'>";
						str += "<div class='font-weight-medium'>"+ obj.fileName +"</div>";
						str += "<button class='btn btn-icon btn-ghost-light ms-auto' data-file=\'"+fileCallPath+"\' data-type='image'>";
						str += "<svg xmlns='http://www.w3.org/2000/svg' class='icon' width='24' height='24' viewBox='0 0 24 24' stroke-width='2' stroke='currentColor' fill='none' stroke-linecap='round' stroke-linejoin='round'><path stroke='none' d='M0 0h24v24H0z' fill='none'/><line x1='18' y1='6' x2='6' y2='18' /><line x1='6' y1='6' x2='18' y2='18' /></svg>";
						str += "</button></div></div></div></li>";
						
					}else{
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
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
						str += "<button class='btn btn-icon btn-ghost-light ms-auto' data-file=\'"+fileCallPath+"\' data-type='file'>";
						str += "<svg xmlns='http://www.w3.org/2000/svg' class='icon' width='24' height='24' viewBox='0 0 24 24' stroke-width='2' stroke='currentColor' fill='none' stroke-linecap='round' stroke-linejoin='round'><path stroke='none' d='M0 0h24v24H0z' fill='none'/><line x1='18' y1='6' x2='6' y2='18' /><line x1='6' y1='6' x2='18' y2='18' /></svg>";
						str += "</button></div></div></div></li>";

					}
				});
				uploadUL.append(str);
			}
			
			$(".uploadResult").on("click", "button", function(e){
	    
			    console.log("delete file");
			      
			    var targetFile = $(this).data("file");
			    var type = $(this).data("type");
			    
			    var targetLi = $(this).closest("li");
			    
			    $.ajax({
			      url: '/deleteFile',
			      data: {fileName: targetFile, type:type},
			      dataType:'text',
			      type: 'POST',
			        success: function(result){
			           alert(result);
			           
			           targetLi.remove();
			         }
			    }); //$.ajax
		   });


		});
			
	</script>

	<jsp:include page="../includes/footer.jsp"/>