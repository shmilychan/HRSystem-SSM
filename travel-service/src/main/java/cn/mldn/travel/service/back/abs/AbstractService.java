package cn.mldn.travel.service.back.abs;

import java.util.HashMap;
import java.util.Map;

public abstract class AbstractService {
	public Map<String, Object> handleParam(long currentPage, int lineSize,
			String column, String keyWord) {
		Map<String,Object> param = new HashMap<String,Object>() ;
		param.put("start", (currentPage - 1) * lineSize) ;
		param.put("lineSize", lineSize) ;
		if ("".equals(keyWord) || "null".equals(keyWord) || keyWord == null) {
			param.put("keyWord", null) ;
		} else {
			param.put("keyWord", "%"+keyWord+"%") ;
		}
		if ("".equals(column) || "null".equals(column) || column == null) {
			param.put("column", null) ;
		} else {
			param.put("column", column) ;
		}
		return param ;
	}
}
