package mul.cam.a.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dto.ChatRoomDto;

@Repository
public class ChatRoomDao {
	@Autowired
	SqlSession session;
	
	String namespace = "ChatRoom.";

	public List<ChatRoomDto> printAllChatRoom(String userId) {
		List<ChatRoomDto> chatRoomList= session.selectList(namespace+"printAllChatRoom", userId);
		
		//  from /member1//member2/ to member1,member2
		for (ChatRoomDto chatRoom : chatRoomList) {
			chatRoom.setMembers(memberStringSplitedByComma(chatRoom.getMembers())); 
		}
		return chatRoomList;
	};
	
	public int createChatRoom(ChatRoomDto dto) {
		// TODO Auto-generated method stub
		//멤버가 sql 에서 string 으로 들어가기에 "/" 를 구분자로 나눔
		String[] memberList = dto.getMembers().split(",");
		String stringSplitedBySlash = memberStringSplitedBySlash(memberList, dto.getCreatedBy());
		dto.setMembers(stringSplitedBySlash); // 구분자를 추가함
		return session.insert(namespace+"createChatRoom", dto);
	};
	
	public ChatRoomDto chatRoomInfo(String roomId) {
		ChatRoomDto chatRoom = session.selectOne(namespace+"chatRoomInfo", roomId);
		chatRoom.setMembers(memberStringSplitedByComma(chatRoom.getMembers()));
		return chatRoom;
	};
	
	
	// 문자열 처리 부분
	public String memberStringSplitedBySlash(String[] memberList, String createdBy) {
		String stringSplitedBySlash = "/"+ createdBy + "/" ; // 방장도 멤버
		for (String member : memberList) {
			stringSplitedBySlash += "/";
			stringSplitedBySlash += member.strip();
			stringSplitedBySlash += "/";
		}
		return stringSplitedBySlash;
	}
	public String memberStringSplitedByComma(String memberSplitedBySlash) {
		String[] memberList = memberSplitedBySlash.split("/"); 
		String  stringSplitedByComma = "";
		// 빈문자열일경우 포함하지 않음
		for (int i=0 ; i < memberList.length-1; i++ ) {
			stringSplitedByComma += memberList[i];
			if (!memberList[i].equals("")) { // 빈문자열이 아니면 뒤에 콤마 추가
				stringSplitedByComma += ",";
			}
		}
		stringSplitedByComma += memberList[memberList.length-1];
		// 마지막 멤버일 경우 뒤에 콤마 없음
		return stringSplitedByComma;
	}
}