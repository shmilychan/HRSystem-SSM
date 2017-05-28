package cn.mldn.util;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator; 
import java.util.List;
import java.util.Map;

public class ListToMapUtils<K, V> {
	private String keyProperty; // 存放要设置为key的属性名称
	private String valueProperty; // 存放要设置为value的属性名称
	public ListToMapUtils(String keyProperty, String valueProperty) {
		this.keyProperty = keyProperty;
		this.valueProperty = valueProperty;
	}
	public Map<K, V> converter(List<?> allList) {
		Map<K, V> map = new HashMap<K, V>();
		Iterator<?> iter = allList.iterator();
		while (iter.hasNext()) {
			Object obj = iter.next(); // 取得每一个VO类对象
			map.put((K) this.getProperty(obj, this.keyProperty),
					(V) this.getProperty(obj, this.valueProperty));
		}
		return map;
	}
	/**
	 * 根据指定的成员取得其对应的属性内容
	 * @param obj  当前的操作对象 
	 * @param fieldName  属性名称 
	 * @return 返回指定的getter方法的返回结果
	 */
	private Object getProperty(Object obj,String filedName) {
		try {
			Method getMethod = obj.getClass()
					.getMethod("get" + org.apache.commons.lang.StringUtils
							.capitalize(filedName));
			return getMethod.invoke(obj) ;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
