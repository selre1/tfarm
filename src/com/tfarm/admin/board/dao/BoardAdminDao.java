package com.tfarm.admin.board.dao;

import java.util.List;


import com.tfarm.admin.board.model.BoardListDto;

public interface BoardAdminDao {

	
	List<BoardListDto> boardMenu();
	
}
