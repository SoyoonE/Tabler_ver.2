package com.yoon.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yoon.domain.BoardVO;
import com.yoon.domain.Criteria;

public interface BoardMapper {
//boardMapper 인터페이스에서 SQL문 처리했으니까 여긴 주석처리
//	@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
	
	//criteria 를 파라미터로 사용하는 매서드 생성
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long bno);
	
	public int delete(Long bno);
	
	public int update(BoardVO board);

	public int getTotalCount(Criteria cri);
	
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	
	
}
