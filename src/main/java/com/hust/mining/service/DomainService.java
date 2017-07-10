package com.hust.mining.service;

import java.util.List;
import java.util.Map;

import com.hust.mining.model.DomainOne;
import com.hust.mining.model.DomainOneProperty;
import com.hust.mining.model.DomainTwo;
import com.hust.mining.model.DomainTwoProperty;
import com.hust.mining.model.params.DomainOneQueryCondition;
import com.hust.mining.model.params.DomainTwoQueryCondition;

public interface DomainService {
	//一级域名start
	/**
	 * 单个添加一级域名 不用包含uuid
	 * @param domainOne
	 * @return 添加成功返回ture，失败返回false
	 */
	boolean addDomainOne(DomainOne domainOne);
	/**
	 * 批量添加一级域名
	 * @param list
	 * @return 全部失败返回false，否则返回true
	 */
	boolean addDomainOne(List<DomainOne> list);
	/**
	 * 根据uuid删除一级域名
	 * @param uuid
	 * @return 删除成功返回true，失败返回false
	 */
	boolean deleteDomainOneById(String uuid);
	/**
	 * 根据uuid，更新一级域名
	 * @param domainone  必须包含uuid
	 * @return 更新成功返回true，失败返回false
	 */
	boolean updateDomainOne(DomainOne domainOne);
	/**
	 * 根据指定条件查询一级域名,为null则查询所有
	 * @param condition 如需分页，请在condition中设置start,limit
	 * @return 
	 */
	List<DomainOne> getDomainOne(DomainOneQueryCondition condition);
	/**
	 * 按权重大小排序获取权重不为0的所有一级域名
	 * @return
	 */
	List<DomainOne> getDomainOne();
	/**
	 * 获取所有一级域名数
	 * @return
	 */
	long getDomainOneCount();
	//一级域名end
	
	/**
	 * 二级域名start
	 */
	/**
	 * 添加单个二级域名，不用包含uuid
	 * @param domainTwo
	 * @return 添加成功返回true，失败返回false
	 */
	boolean addDomainTwo(DomainTwo domainTwo);
	/**
	 * 批量添加二级域名
	 * @param list
	 * @return 全部失败返回false，否则返回true
	 */
	boolean addDomainTwo(List<DomainTwo> list);
	/**
	 * 根据id删除二级域名
	 * @param uuid
	 * @return 删除成功返回true，失败返回false
	 */
	boolean deleteDomainTwoById(String uuid);
	/**
	 * 根据id更新二级域名
	 * @param domainTwo 必须包含uuid
	 * @return 更新成功返回true,失败返回false
	 */
	boolean updateDomainTwo(DomainTwo domainTwo);
	/**
	 * 根据条件查询二级域名，null则查询所有
	 * @param condition
	 * @return
	 */
	List<DomainTwo> getDomainTwo(DomainTwoQueryCondition condition);
	/**
	 * 按权重大小排序获取权重不为0的所有二级域名
	 * @return
	 */
	List<DomainTwo> getDomainTwo();
	/**
	 * 查询所有二级域名的个数
	 * @return
	 */
	long getDomainTwoCount();
	/**
	 * 二级域名end
	 */
	
	/**
	 * 域名综合start
	 */
		
	/**
	 * 根据一级域名查询对应的二级域名
	 * @return 返回的二级域名顺序与一级域名一一对应 List< one --> List<two>>
	 */
	List<List<DomainTwo>> getDomainTwoByOne(List<DomainOne> list);
	/**
	 * 根据一级域名查询对应的带扩展属性的二级域名
	 * @return 返回的二级域名顺序与一级域名一一对应 List< one --> List<two>>
	 */
	List<List<DomainTwoProperty>> getDomainTwoPByOne(List<DomainOne> list);
	
	/**
	 * 根据一级域名获取带扩展属性的一级域名
	 * @param list
	 * @return
	 */
	List<DomainOneProperty> getDomainOneExtraProperty(List<DomainOne> list);
	/**
	 * 根据二级域名获取带扩展属性的二级域名
	 * @param list
	 * @return
	 */
	List<DomainTwoProperty> getDomainTwoExtraProperty(List<DomainTwo> list);
	/**
	 * 域名综合end
	 */
}
