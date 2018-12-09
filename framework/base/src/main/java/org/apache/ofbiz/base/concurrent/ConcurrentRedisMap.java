package org.apache.ofbiz.base.concurrent;

import java.io.Serializable;
import java.util.AbstractMap;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.apache.ofbiz.catalina.container.CatalinaContainer;
import org.redisson.api.RMap;

public class ConcurrentRedisMap<K, V> extends AbstractMap<K,V>
implements ConcurrentMap<K,V>, Serializable {
	
	private String name;


	public ConcurrentRedisMap(String name) {
		super();
		this.name = name;
	}
	private ConcurrentHashMap<K,V> map = new ConcurrentHashMap<K,V>();
	/**
	 * 
	 */
	private static final long serialVersionUID = -246394995251001502L;
	
	
    public V put(K key, V value) {
    		if(CatalinaContainer.getClient()!=null) {
                RMap<K, V> map1 = CatalinaContainer.getClient().getMap("ofbiz.cache:" + name);
                if(map1!=null) {
                		return map1.put(key, value);
                }else {
                		return null;
                }
   
    		}else {
    			return map.put(key, value);
    		}
    }

	@Override
	public V putIfAbsent(K key, V value) {
		// TODO Auto-generated method stub
		if(CatalinaContainer.getClient()!=null) {
			RMap<K, V> map1 = CatalinaContainer.getClient().getMap("ofbiz.cache:" + name);
            if(map1!=null) {
            		return map1.putIfAbsent(key, value);
	        }else {
	        		return null;
	        }
			
		}else {
			return map.putIfAbsent(key, value);
		}
	}

	@Override
	public boolean remove(Object key, Object value) {
		// TODO Auto-generated method stub
		if(CatalinaContainer.getClient()!=null) {
			RMap<K, V> map1 = CatalinaContainer.getClient().getMap("ofbiz.cache:" + name);
            if(map1!=null) {
            		return map1.remove(key, value);
	        }else {
	        		return false;
	        }
			
		}else {
			return map.remove(key, value);
		}
		
	}

	@Override
	public boolean replace(K key, V oldValue, V newValue) {
		if(CatalinaContainer.getClient()!=null) {
			RMap<K, V> map1 = CatalinaContainer.getClient().getMap("ofbiz.cache:" + name);
            if(map1!=null) {
            		return map1.replace(key, oldValue, newValue);
	        }else {
	        		return false;
	        }
			
		}else {
			return map.replace(key, oldValue, newValue);
		}
		
	}

	@Override
	public V replace(K key, V value) {
		if(CatalinaContainer.getClient()!=null) {
			RMap<K, V> map1 = CatalinaContainer.getClient().getMap("ofbiz.cache:" + name);
            if(map1!=null) {
            		return map1.replace(key, value);
	        }else {
	        		return null;
	        }
			
		}else {
			return map.replace(key, value);
		}
		
	}

	@Override
	public Set<Entry<K, V>> entrySet() {
		if(CatalinaContainer.getClient()!=null) {
			RMap<K, V> map1 = CatalinaContainer.getClient().getMap("ofbiz.cache:" + name);
            if(map1!=null) {
            		return map1.entrySet();
	        }else {
	        		return null;
	        }
			
		}else {
			return map.entrySet();
		}
		
	}

	

}
