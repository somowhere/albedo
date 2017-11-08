package com.albedo.java.common.queue;

import java.util.HashMap;
import java.util.Map;

/**
 * 队列执行工具类
 *
 * @author: lijie
 * @date: 2017-8-23   上午10:56:01
 */
public class QueueSendMsgUtil {

//	static BaseInterfaceLogService baseInterfaceLogService = SpringContextUtil.getBeanT(BaseInterfaceLogService.class);
//
//	static TransactionerLog transactionerLog = new TransactionerLog(baseInterfaceLogService);

    static Map<String, ThreadPoolManager> printMap = new HashMap<>();

    private static ThreadPoolManager getTpmInstance(Transactioner transactioner) {
        ThreadPoolManager tpm = printMap.get(transactioner.getKey());
        if (tpm == null) {
            tpm = new ThreadPoolManager(transactioner);
            printMap.put(transactioner.getKey(), tpm);
        }
        return tpm;
    }

//	public static void sendLogMsg(BaseInterfaceLogEntity finalLogEntity){
//		ThreadPoolManager tpm = getTpmInstance(transactionerLog);
//		tpm.addAutoMsg(JSON.toJSONString(finalLogEntity));
//	}
}
