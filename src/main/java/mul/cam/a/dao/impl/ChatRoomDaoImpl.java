package mul.cam.a.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mul.cam.a.dao.ChatRoomDao;
import mul.cam.a.dto.ChatRoomDto;

@Repository
public class ChatRoomDaoImpl implements ChatRoomDao{
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
		String[] memberList = dto.getMembers().split(",");
		//멤버가 sql 에서 string 으로 들어가기에 "/" 를 구분자로 나눔
		String stringSplitedBySlash = memberStringSplitedBySlash(memberList, dto.getCreatedBy());
		dto.setMembers(stringSplitedBySlash); // 구분자를 추가함
		return session.insert(namespace+"createChatRoom", dto);
	};
	
	public ChatRoomDto chatRoomInfo(String roomId) {
		ChatRoomDto chatRoom = session.selectOne(namespace+"chatRoomInfo", roomId);
		if (chatRoom == null) {
			return null;
		}
		chatRoom.setMembers(memberStringSplitedByComma(chatRoom.getMembers()));
		return chatRoom;
	};
	
	public int exitChatRoom(String roomId, String user){
		// 먼저 나갈 채팅방의 정보를 가져온다(member) 
		// 멤버를 수정해서 update 해줄 것이다.
		ChatRoomDto chatRoom = session.selectOne(namespace+"chatRoomInfo", roomId);
		// DB 에 있는 멤버 중에서 채팅나간 유저를 제거한다
		String updateMembers = removeUserFromChatMembers(user, chatRoom.getMembers());
		HashMap<String, String> roomIdAndUpdateMembers= new HashMap<>();
		roomIdAndUpdateMembers.put("roomId", roomId); // 채팅방 찾고
		roomIdAndUpdateMembers.put("updateMembers", updateMembers); // 채팅방 멤버 업데이트
		return session.update(namespace + "exitChatRoom", roomIdAndUpdateMembers);
	} 
	
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
	
	public String removeUserFromChatMembers(String user, String members) {
		int userNameLength = user.length();
		int userNameIndex = members.indexOf("/" + user + "/");
		int membersLength = members.length();
		
		String updateMembers = "";
		if (userNameIndex == 0) {
			// 해당 유저가 맨앞의 위치한 경우
			updateMembers = members.substring(userNameLength + 2);
		}else if (userNameIndex == (membersLength - userNameIndex - 2)){
			updateMembers = members.substring(userNameIndex);
		}else {			
			// 해당 유저가 중간에 위치한 경우
			updateMembers = members.substring(0, userNameIndex) + members.substring(userNameIndex + userNameLength + 1);			
		}
		return updateMembers;
	}
}