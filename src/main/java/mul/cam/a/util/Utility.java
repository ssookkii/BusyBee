package mul.cam.a.util;

public class Utility {

	public static String arrow(int depth){
		String arrow = "┗";	
		String nbsp = "&nbsp;&nbsp;&nbsp;&nbsp;";
		
		String ts = "";
		for(int i = 0;i < depth; i++){
			ts += nbsp;
		}
		
		return depth==0?"":ts + arrow;
	}
	
	public static String lock(boolean sceret){
		String lock = "&nbsp;<img src='./images/lock.png' width='15px' height='15px' />";	
		
		
		return sceret?lock:"";
	}
	
}
