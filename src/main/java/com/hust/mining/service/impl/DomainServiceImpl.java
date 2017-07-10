package com.hust.mining.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hust.mining.dao.DomainOneDao;
import com.hust.mining.dao.DomainPropertyDao;
import com.hust.mining.dao.DomainTwoDao;
import com.hust.mining.dao.ExtraPropertyDao;
import com.hust.mining.model.DomainOne;
import com.hust.mining.model.DomainOneProperty;
import com.hust.mining.model.DomainProperty;
import com.hust.mining.model.DomainTwo;
import com.hust.mining.model.DomainTwoProperty;
import com.hust.mining.model.ExtraProperty;
import com.hust.mining.model.params.DomainOneQueryCondition;
import com.hust.mining.model.params.DomainPropertyQueryCondition;
import com.hust.mining.model.params.DomainTwoQueryCondition;
import com.hust.mining.service.DomainService;

@Service
public class DomainServiceImpl implements DomainService {

	@Autowired
	private DomainOneDao domainOneDao;
	@Autowired
	private DomainTwoDao domainTwoDao;
	@Autowired
	private DomainPropertyDao domainPropertyDao;
	@Autowired
	private ExtraPropertyDao extraPropertyDao;

	@Override
	public boolean addDomainOne(DomainOne domainOne) {
		// TODO Auto-generated method stub
		if (0 < domainOneDao.insertDomain(domainOne))
			return true;
		else
			return false;
	}

	@Override
	public boolean addDomainOne(List<DomainOne> list) {
		// TODO Auto-generated method stub
		if (0 < domainOneDao.insertDomain(list))
			return true;
		else
			return false;
	}

	@Override
	public boolean deleteDomainOneById(String uuid) {
		// TODO Auto-generated method stub
		if (0 < domainOneDao.delelteDomainOneById(uuid))
			return true;
		else
			return false;
	}

	@Override
	public boolean updateDomainOne(DomainOne domainOne) {
		// TODO Auto-generated method stub
		if (0 < domainOneDao.updateDomainOneInfo(domainOne))
			return true;
		else
			return false;
	}

	@Override
	public List<DomainOne> getDomainOne(DomainOneQueryCondition condition) {
		// TODO Auto-generated method stub
		if (null == condition) {
			return domainOneDao.getAllDomainOneOrderByTime(0, 0);
		}
		return domainOneDao.getDomainOneOrderByTime(condition);
	}

	@Override
	public List<DomainOne> getDomainOne() {
		// TODO Auto-generated method stub
		return domainOneDao.getAllDomainOneOrderByWeight();
	}

	@Override
	public long getDomainOneCount() {
		// TODO Auto-generated method stub
		return domainOneDao.getDomainOneCount();
	}

	@Override
	public boolean addDomainTwo(DomainTwo domainTwo) {
		// TODO Auto-generated method stub
		if (0 < domainTwoDao.insertDomainTwo(domainTwo))
			return true;
		else
			return false;
	}

	@Override
	public boolean addDomainTwo(List<DomainTwo> list) {
		// TODO Auto-generated method stub
		if (0 < domainTwoDao.insertDomainTwo(list))
			return true;
		else
			return false;
	}

	@Override
	public boolean deleteDomainTwoById(String uuid) {
		// TODO Auto-generated method stub
		if (0 < domainTwoDao.deleteDomainById(uuid))
			return true;
		else
			return false;
	}

	@Override
	public boolean updateDomainTwo(DomainTwo domainTwo) {
		// TODO Auto-generated method stub
		if (0 < domainTwoDao.updateDomainTwo(domainTwo))
			return true;
		else
			return false;
	}

	@Override
	public List<DomainTwo> getDomainTwo(DomainTwoQueryCondition condition) {
		// TODO Auto-generated method stub
		if(null == condition){
			return domainTwoDao.getAllDomainTwo();
		}
		return domainTwoDao.getDomainTwoByCondition(condition);
	}

	@Override
	public List<DomainTwo> getDomainTwo() {
		// TODO Auto-generated method stub
		return domainTwoDao.getAllDomainOrderByWeight();
	}

	@Override
	public long getDomainTwoCount() {
		// TODO Auto-generated method stub
		return domainTwoDao.getDomainTwoCount();
	}

	//综合查询部分
	
	@Override
	public List<List<DomainTwoProperty>> getDomainTwoPByOne(List<DomainOne> list) {
		// TODO Auto-generated method stub
		List<List<DomainTwoProperty>> twoPList = new ArrayList<>();
		for (DomainOne domainOne : list) {
			List<DomainTwoProperty> twoP = new ArrayList<>();
			twoP = getDomainTwoExtraProperty(domainTwoDao.getDomainTwoByFatherId(domainOne.getUuid()));
			twoPList.add(twoP);
		}
		return twoPList;
	}

	@Override
	public List<List<DomainTwo>> getDomainTwoByOne(List<DomainOne> list) {
		// TODO Auto-generated method stub
		List<List<DomainTwo>> twoPList = new ArrayList<>();
		for (DomainOne domainOne : list) {
			List<DomainTwo> twoP = new ArrayList<>();
			twoP = domainTwoDao.getDomainTwoByFatherId(domainOne.getUuid());
			twoPList.add(twoP);
		}
		return twoPList;
	}

	@Override
	public List<DomainOneProperty> getDomainOneExtraProperty(List<DomainOne> list) {
		// TODO Auto-generated method stub
		List<DomainOneProperty> onePList =  new ArrayList<>();
		List<ExtraProperty> eProList = extraPropertyDao.getAllExtraProperty();
		for (DomainOne domainOne : list) {
			DomainOneProperty oneProperty = new DomainOneProperty();
			Map<String,String> map = new HashMap<>();
			for (ExtraProperty extraProperty : eProList) {
				DomainPropertyQueryCondition condition = new DomainPropertyQueryCondition();
				condition.setDomainUuid(domainOne.getUuid());
				condition.setPropertyId(extraProperty.getId());
				List<DomainProperty> dpList = domainPropertyDao.getDomainPropertyByCondition(condition);
				if(dpList.size() == 0){
					map.put(extraProperty.getName(), null);
				}else{
					map.put(extraProperty.getName(),dpList.get(0).getPropertyValue());
				}
			}
			oneProperty.setDomainOne(domainOne);
			oneProperty.setExtraProperty(map);
			onePList.add(oneProperty);
		}
		return onePList;
	}

	@Override
	public List<DomainTwoProperty> getDomainTwoExtraProperty(List<DomainTwo> list) {
		// TODO Auto-generated method stub
		List<DomainTwoProperty> twoPList = new ArrayList<>();
		List<ExtraProperty> eProList = extraPropertyDao.getAllExtraProperty();
		for (DomainTwo domainTwo : list) {
			DomainTwoProperty twoProperty = new DomainTwoProperty();
			Map<String,String> map = new HashMap<>();
			for (ExtraProperty extraProperty : eProList) {
				DomainPropertyQueryCondition condition = new DomainPropertyQueryCondition();
				condition.setDomainUuid(domainTwo.getUuid());
				condition.setPropertyId(extraProperty.getId());
				List<DomainProperty> dpList = domainPropertyDao.getDomainPropertyByCondition(condition);
				if(dpList.size() == 0){
					map.put(extraProperty.getName(), null);
				}else{
					map.put(extraProperty.getName(),dpList.get(0).getPropertyValue());
				}
			}
			twoProperty.setDomainTwo(domainTwo);
			twoProperty.setExtraProperty(map);
			twoPList.add(twoProperty);
		}
		return twoPList;
	}

}
