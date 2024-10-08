package com.spring.javaclassS11.common;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS11.dao.BoardDAO;
import com.spring.javaclassS11.dao.NoticeDAO;
import com.spring.javaclassS11.vo.PagVO;

@Service
public class PageProcess {


	@Autowired
	NoticeDAO noticeDAO;
	@Autowired
	BoardDAO boardDAO; 


	public PagVO getTotRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PagVO pageVO = new PagVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("noticeBoard")) {
			if(part.equals(""))	totRecCnt = noticeDAO.totRecCnt("noticeBoard");
			else {
				search = part;
				//totRecCnt = noticeDAO.totRecCntSearch(search, searchString);
			}
		}
		else if(section.equals("freeBoard")) {
			if(part.equals(""))	totRecCnt = boardDAO.totRecCnt("freeBoard");
			else {
				search = part;
			}
		}
		else if(section.equals("fromIVE")) {
			if(part.equals(""))	totRecCnt = boardDAO.totRecCnt("fromIVE");
			else {
				search = part;
			}
		}
		else if(section.equals("toIVE")) {
			if(part.equals(""))	totRecCnt = boardDAO.totRecCnt("toIVE");
			else {
				search = part;
			}
		}
		else if(section.equals("songSuggestions")) {
			if(part.equals(""))	totRecCnt = boardDAO.totRecCnt("songSuggestions");
			else {
				search = part;
			}
		}
		else if(section.equals("choreographySuggestions")) {
			if(part.equals(""))	totRecCnt = boardDAO.totRecCnt("choreographySuggestions");
			else {
				search = part;
			}
		}
		
		int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		pageVO.setPart(part);
				
		return pageVO;
	}

	

	
	
	
	
}
