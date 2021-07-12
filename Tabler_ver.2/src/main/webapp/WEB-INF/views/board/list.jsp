<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 				prefix="c" 			%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" 				prefix="fmt" 		%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" 		prefix="fn" 		%>
<%@ taglib uri="http://www.springframework.org/tags" 			prefix="spring" 	%>
	<jsp:include page="../includes/header.jsp"/>
		<div class="container-xl"> 
          <!-- Page title -->
          <div class="page-header d-print-none">
            <div class="row align-items-center">
              <div class="col">
                <!-- Page pre-title -->
                <div class="page-pretitle">
                  Overview
                </div>
                <h2 class="page-title">
                  board
                </h2>
              </div>
              <!-- Page title actions -->
              
              <div class="col-auto ms-auto d-print-none">
              	
	                <div class="btn-list">
	                <%-- <c:if test="${sessionScope.ldata ne null}"> --%>
	                	<button id="regBtn" class="btn btn-primary d-none d-sm-inline-block" >
		                    <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
		                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></svg>
		                    Create
	                  	</button>
	                  	<button id="regBtn" class="btn btn-primary d-sm-none btn-icon" aria-label="Create new report">
		                    <!-- Download SVG icon from http://tabler-icons.io/i/plus -->
		                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg>
	                  	</button>
	                <%-- </c:if> --%>
	                </div>
              </div>
              	
            </div>
          </div>
        </div>
        
        <div class="page-body">
          <div class="container-xl">
            <div class="row row-deck row-cards">
         		<div class="col-12">
	                <div class="card">
	                <div class="card-body border-bottom py-3">
	                    <div class="d-flex">
	                      <div class="text-muted">
	                        Show
	                        <div class="mx-2 d-inline-block">
	                          <input type="text" class="form-control form-control-sm" value="8" size="3" aria-label="Invoices count">
	                        </div>
	                        entries
	                      </div>
	                      
	                      <!-- search -->
	                      
	                       	<div class="ms-auto text-muted ">
	                        <form action="/board/list" id="searchForm" method="get">
	                        Search:
	                        <div class="choices d-inline-block ml-2" data-type="select-one" tabindex="0" role="listbox" aria-haspopup="true" aria-expanded="false">
	                        	<select name="type">
	                        		<option value="" 
	                        			<c:out value="${pageMaker.cri.type == null?'selected':'' }"/>>---</option>
	                        		<option value="T" 
	                        			<c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
	                        		<option value="C" 
	                        			<c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
	                        		<option value="W" 
	                        			<c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
	                        		<option value="TC" 
	                        			<c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목 or 내용</option>
	                        		<option value="TW" 
	                        			<c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목 or 작성자</option>
	                        		<option value="TWC" 
	                        			<c:out value="${pageMaker.cri.type eq 'TWC'?'selected':'' }"/>>제목 or 내용 or 작성자</option>
	                        	</select>           	
	                        </div>
	                        <div class="ms-2 d-inline-block">
	                          <input type="text" class="form-control form-control-sm" name="keyword" value="<c:out value="${pageMaker.cri.keyword }"/>" />
	                        </div>
	                        
	                        <input type="hidden" name="pageNum" value="<c:out value="${pageMaker.cri.pageNum }"/>" />
	                        <input type="hidden" name="amount" value="<c:out value="${pageMaker.cri.amount }"/>" />
	                        
	                        <div class="col-auto d-inline-block">
                            	<button class="btn btn-icon btn-sm btn-ghost-light active w-100">
                                    <!-- Download SVG icon from http://tabler-icons.io/i/search -->
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><circle cx="10" cy="10" r="7"></circle><line x1="21" y1="21" x2="15" y2="15"></line></svg>
                                </button>
                            </div>
	                      </form>
	                      </div>
	                      
 	                      
	                    </div>
	                </div>
	                  <div class="table-responsive">
	                    <table class="table table-vcenter card-table">
	                    <!-- table title wirter 빼고 전부 가운데정렬로 -->
	                      <thead>
	                        <tr>
	                          <th>No.</th>
	                          <th>TITLE</th>
	                          <th>NAME</th>
	                          <th>DATE</th>
	                          <th>UPDATE</th>
	                          <th>REPLYS</th>
	                        </tr>
	                      </thead>
	                      <tbody>
	                      
	                      	<c:forEach items="${list}" var="board">
								<tr>
									<td><c:out value="${board.bno}"/></td>
									<td><a class="move" href='<c:out value="${board.bno}"/>'> <c:out value="${board.title}"/> </a> </td>
									
									<td><c:out value="${board.writer}"/></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updatedate}"/></td>
									<td><c:out value="${board.replyCnt }"/></td>
								</tr>
							</c:forEach>
	                       
	                      </tbody>
	                    </table>
	                  </div>
	                  
	                  <!-- paging -->
	                  <div class="card-footer d-flex align-items-center">
	                    <p class="m-0 text-muted">Showing <span>1</span> to <span>8</span> of <span>16</span> entries</p>
	                    <ul class="pagination m-0 ms-auto">
	                    
		                  <c:if test="${pageMaker.prev }">
		                     <li class="page-item previous">
		                        <a class="page-link" href="${pageMaker.startPage -1 }" aria-disabled="true">
		                          <!-- Download SVG icon from http://tabler-icons.io/i/chevron-left -->
		                          <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><polyline points="15 6 9 12 15 18"></polyline></svg>
		                          prev
		                        </a>
		                     </li>
	                      </c:if>
	                      
	                      <c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
	                      	<li class="page-item ${pageMaker.cri.pageNum == num ?" active":""}">
	                      		<a class="page-link" href="${num }">${num }</a>
	                      	</li>
	                      </c:forEach>	
						  
	                      <c:if test="${pageMaker.next }">
		                      <li class="page-item next">
		                        <a class="page-link" href="${pageMaker.endPage +1 }">
		                          next <!-- Download SVG icon from http://tabler-icons.io/i/chevron-right -->
		                          <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"></path><polyline points="9 6 15 12 9 18"></polyline></svg>
		                        </a>
		                      </li>
	                      </c:if>
	                      
	                    </ul>
                  	</div>       	
	            </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal modal-blur fade" id="myModal" tabindex="-1" style="display: none;" aria-hidden="true">
	      <div class="modal-dialog modal-dialog-centered" role="document">
	        <div class="modal-content">
	          <div class="modal-header">
	            <h5 class="modal-title">Info</h5>
	            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	          </div>
	          <div class="modal-body">
	            처리가 완료되었습니다
	          </div>
	          <div class="modal-footer">
	            <button type="button" class="btn me-auto" data-bs-dismiss="modal">닫기</button>
	            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
	          </div>
	        </div>
	      </div>
	    </div>	
	    
	    <form action="/board/list" id="actionForm" method="get">
        	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
       		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
       		<input type="hidden" name="type" value="<c:out value="${pageMaker.cri.type }"/>">
       		<input type="hidden" name="keyword" value="<c:out value="${pageMaker.cri.keyword }"/>">
        </form>
	    
		<script type="text/javascript">
		
		$(document).ready(function() {

			var result = '<c:out value="${result}"/>';

			checkModal(result);

			history.replaceState({}, null, null);

			function checkModal(result) {

				if (result === '' || history.state) {
					return;
				}

				if (parseInt(result) > 0) {
					$(".modal-body").html("게시글 " + parseInt(result) + " 번으로 등록되었습니다.");
				}

				$("#myModal").modal("show");
			}

			$("#regBtn").on("click", function() {

				self.location = "/board/register";

			});

			var actionForm = $("#actionForm");

			$(".page-item a").on("click",function(e) {

				e.preventDefault();

				console.log('click');

				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				
				actionForm.submit();
			});
			
			$(".move").on("click", function(e){
				
				e.preventDefault();
				
				actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href")+"'>");
				
				actionForm.attr("action","/board/get");
				
				actionForm.submit();
			});
			
			var searchForm = $("searchForm");
			
			$("#searchForm button").on("click",function(e){
				
				/* if(!searchForm.find("option:selected").val()){
					alert("검색종류를 선택하세요");
					return false;
				}
				if(!searchForm.find("input[name='keyword']").val()){
					alert("키워드를 입력하세요");
					return false;
				} */
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefalut();
				
				searchForm.submit();
			});
		});
        </script>
        
<jsp:include page="../includes/footer.jsp"/>