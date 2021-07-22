package com.honjal.honjal.dao.ext;

import java.util.List;

import com.honjal.honjal.dao.GenericDao;
import com.honjal.honjal.model.ContentDTO;
import com.honjal.honjal.model.ContentFilesDTO;
import com.honjal.honjal.model.ContentListDTO;
import com.honjal.honjal.model.ContentVO;

public interface ContentDao extends GenericDao<ContentVO, Integer>{

	public ContentVO findByIdContent(Integer content_num);
	
	public void insert(ContentVO contentVO);
	public void update(ContentVO contentVO);
	public void delete(Integer content_num);
	
	public List<ContentListDTO> allContent();
	public List<ContentListDTO> menuContent(String board_code);
	
	public List<ContentListDTO> searchTitleContent(String menu, String search_word);
	
	public void view_count(int content_num) throws Exception;
	
	public void comment_count(int content_num)throws Exception;
	
	public List<ContentFilesDTO> findByIdGalleryFiles(Long g_seq);
	public ContentDTO  findByIdGalleryFilesResultMap(Long g_seq);
	public void insert(ContentDTO contentDTO);
	
}
