package com.honjal.honjal.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.honjal.honjal.model.ContentDTO;
import com.honjal.honjal.model.ContentFilesDTO;
import com.honjal.honjal.model.ContentListDTO;
import com.honjal.honjal.model.ContentVO;

public interface ContentService {
	
	public ContentVO findByIdContent(Integer content_num);
	// 글번호로 글찾기
	
	public void insert(ContentVO contentVO) throws Exception;
	// 글쓰기
	
	public void update(ContentVO contentVO) throws Exception;
	// 글수정
	
	public void delete(Integer content_num) throws Exception;
	// 글삭제
	
	
	
	public List<ContentListDTO> allContent();
	// 올라오는 모든 글 리스트 (메인화면 최신글목록에서 사용)
	
	public List<ContentListDTO> menuContent(String board_code);
	// 메뉴별 글 리스트 (각 게시판에서 사용)
	
	public List<ContentListDTO> menuContentPage(String board_code, int pageNum);
	// 페이지네이션 적용된 메뉴별 글 리스트 (각 게시판에서 사용)
	
	
	
	public List<ContentListDTO> searchTitleContent(String menu, String title);
	// 글검색 (제목으로)
	
	public List<ContentListDTO> searchTextContent(String text);
	// 글검색 (내용으로)
	
	public List<ContentListDTO> searchNameContent(String name);
	// 글검색 (작성자로)
	
	public List<ContentListDTO> MyContent(Integer member_num);
	// 내가 쓴 글 보기
	

	public void view_count(int content_view) throws Exception;
	
	public void comment_count (int content_view)throws Exception;
	
	
	public List<ContentFilesDTO> findByIdGalleryFiles(Long g_seq);
	public ContentFilesDTO findByIdGalleryFilesResultMap(Long g_seq);
	
	public void input(ContentDTO ContentDTO, 
			MultipartFile one_file, 
			MultipartHttpServletRequest m_file) throws Exception;
}
